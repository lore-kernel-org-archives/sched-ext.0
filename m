Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B78271468;
	Thu, 11 Dec 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493293; cv=none; b=KeFqS5eNrR/KtBhc41MYx1Auw6eTwrPfEe+WptTXuO58WqVMcNiNb36NtdlX+Q8cWt4NHsELGJBtLBYPP3lobhKL/0HBrY5vJbe450HT375lb7IDORv923CvjtGzXKCGqY0Trl/DO5UXV93bne5fALi5pcHyrgQ0TqNgsx2cdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493293; c=relaxed/simple;
	bh=nbTSTaX/kJX5OXIFW8r6a1z3RZsyFQM/mRbsvU3jyhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7r1jlclyB1M8/7q9CQPuvl52oM83rxUx5444N8UpBsXmifyJK20/X5HEnlYBjZtsOgtlQDRYgvcI4b4vYcLk4v/IEw8qrkIheICCd+6f+RkVitCBudWh43dxZX9rRMVNr5l/OBcrW9yES5+BkhJVj5Z/tPamEF+A9RphLJ60E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR9EN7bf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR9EN7bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE71C4CEF7;
	Thu, 11 Dec 2025 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765493293;
	bh=nbTSTaX/kJX5OXIFW8r6a1z3RZsyFQM/mRbsvU3jyhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WR9EN7bf0iA4aobhoRvPlu+5OgQIN3mUHApxQh4W1cTn9MV6CsyXuNURN9egVSo5v
	 s9YbMF6F/uueguokV1FG+Uo1x90jmFSY6ZnbimWeUw0NMZ7sRE8ggu+T1HRI03Ppfz
	 qFSSTWWytXgOO/7U8OP/A44au2+8RbDuAckl0sSnDSrkTk72RSa/S51KShEfY1WLLq
	 IVIfCZHhUKZrFM7C8CABzVgm20qKKFAkwx3Eni2Dwqfsk/MpqHJAaotMXzmIn0gU21
	 rpew3izMs+Ptn0exXy3uAf73JXQ7lvewoSMcorGkddGcovhfVMZKtmC2RvgnQUe7ik
	 LPSxhY0oRTTqw==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Thu, 11 Dec 2025 12:48:09 -1000
Message-ID: <20251211224809.3383633-3-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211224809.3383633-1-tj@kernel.org>
References: <20251211224809.3383633-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_local_task_to_local_dsq() is used when moving a task from a non-local
DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
without going through dispatch_enqueue() and was missing the post-enqueue
handling that triggers preemption when SCX_ENQ_PREEMPT is set or the
enqueued task should preempt a lower priority task.

This was fine when the function was only used from consume_dispatch_q()
where the CPU is already vacant and looking for the next task. However, the
function is now also used by move_task_between_dsqs() which backs
scx_bpf_dsq_move() which may be called while the CPU is busy.

Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
early exit to keep consume_dispatch_q() behavior unchanged and avoid
triggering unnecessary resched when scx_bpf_dsq_move() is used from the
dispatch path.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -981,6 +981,14 @@ static void local_dsq_post_enq(struct sc
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 	bool preempt = false;
 
+	/*
+	 * If @rq is in balance, the CPU is already vacant and looking for the
+	 * next task to run. No need to preempt or trigger resched after moving
+	 * @p into its local DSQ.
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		return;
+
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
 		rq->curr->scx.slice = 0;
@@ -1629,6 +1637,8 @@ static void move_local_task_to_local_dsq
 
 	dsq_mod_nr(dst_dsq, 1);
 	p->scx.dsq = dst_dsq;
+
+	local_dsq_post_enq(dst_dsq, p, enq_flags);
 }
 
 /**
