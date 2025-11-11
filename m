Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407B325498;
	Tue, 11 Nov 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888700; cv=none; b=RJ7z5al6SeZ2pqkLAiKnp0P62on8GnII40l47iX00v97NEn0X4+QF5Z3luiZQsSFEYCW+uthjhYGsVk2fzbbSgMhZjyxCUt1NaOf2aga1nfkb1tTpK4eLtOGKdkZyVyEDvWZlfwmMCot8ceCAgsRw7Qv0NQ8Ijaz1TeMi3r6Czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888700; c=relaxed/simple;
	bh=o8vAYKTvT2RecHZKPmQOnSYn7HBon7Z82Fm0yMzR4nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hueHqWxAwHYG8hcyYfxdIv6AVozOzHeTuXTl5H/kjosy51SxZvbgZ2vv4TSc1Dwqa6+w5g1YV06zzetkMeO780vXdEKqmq+UAJF5nQ1R7Qlu1NgPjKC45OV1juJGyEtxjHop8zttMu4Hh+zefiUNpYcbT0dsnZOMARTR9Lvohr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXTQWk6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTQWk6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E543C4AF0B;
	Tue, 11 Nov 2025 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888699;
	bh=o8vAYKTvT2RecHZKPmQOnSYn7HBon7Z82Fm0yMzR4nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXTQWk6ZleClxOtGADcFbYRAmxACBExmiili9XW4bvZIVR9x3Zn1C2+p5OvWS3/nh
	 7UKPxdVC+EIj67ogM65FizRADoULTeyMExMjXPVTBD4aspO3n4+sHus87w1Y80EilZ
	 O7OOiXw5eg6EvcivbTsAh3XRBX0HR/Ir5D3rvwHLz49vXXe0CaaTMdhSoFUEthQIMv
	 84cjAv1SDCb37IuVvS9Uh/lNEWMIF/jWonvlDGBlXONAeVLwXnbjcLPS95CyF+zMnL
	 MLgjrmd2nsfCqipCuHiVm/+W7ktiEc1pRNlydcoeA7D5tuzBAy4ehX7antaTEJGDCB
	 TjW360wS6YnVg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 02/13] sched_ext: Refactor do_enqueue_task() local and global DSQ paths
Date: Tue, 11 Nov 2025 09:18:05 -1000
Message-ID: <20251111191816.862797-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local and global DSQ enqueue paths in do_enqueue_task() share the same
slice refill logic. Factor out the common code into a shared enqueue label.
This makes adding new enqueue cases easier. No functional changes.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1a9b28dd0961..43083602c15e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1279,6 +1279,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 {
 	struct scx_sched *sch = scx_root;
 	struct task_struct **ddsp_taskp;
+	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1346,8 +1347,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
-
+local_norefill:
+	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	return;
 local:
+	dsq = &rq->scx.local_dsq;
+	goto enqueue;
+global:
+	dsq = find_global_dsq(sch, p);
+	goto enqueue;
+
+enqueue:
 	/*
 	 * For task-ordering, slice refill must be treated as implying the end
 	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
@@ -1355,14 +1365,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
-	return;
-
-global:
-	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
+	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
-- 
2.51.2

