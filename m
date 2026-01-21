Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CA44E045;
	Wed, 21 Jan 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037115; cv=none; b=SiRWS/LETyBUVD7OqmnLUebB4FmjsHHMnr04AincSz+2hFGAWoW/UDZMluLuFrtknFXucqabVjiHkFAPrWhLibqHyuWr+X5dcs4ufPMxectMqx6bMc7e8GlgBBTUrI14j3KAbOH7xP6/5izUoEczdvHrTseRFh9nOo1/YWabQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037115; c=relaxed/simple;
	bh=C/Y4hUHIvAXYWz1dKkRKihlgeUbRO1EcIFmjBPShaGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFT7Uvc9bAruczzY15hpq1hwHwri0uHjjiuSeULNcfHojNM7/qrBjcU/6aRtQQg6vOmE/PfW0D98IRdnpV0LxPfuJrIF689mwA1KtSGktcaKCyGaInWUXnRVFHIdvVAqmZCU5iA6igMHkQcp/v8oRUNzJJxqQAg/ZCcOSM5/b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5DhL6J1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5DhL6J1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B06EC19422;
	Wed, 21 Jan 2026 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037114;
	bh=C/Y4hUHIvAXYWz1dKkRKihlgeUbRO1EcIFmjBPShaGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5DhL6J1Iv6nuKfsZkmiklb3vH1jVDlh0nw7YUpGSonk4/hHbuiqFGwvXvp6/ZIUc
	 LW9cg+OqqbSORwR3df5qUMDT8lls7tvKOQI3TKEMd8WL4dn/R0BVLxV/D9/hRW4WI/
	 pok298c8QewbyFKPmssB+94SIIdlxSHHF4tit+7kaaz3tk+L369Xy+NePdFykCLAT+
	 CprMh+dKX87ZlIo1ju3SNL1iHBKgeZXvixSMTSveFIFE7sC0w0PUnuYGfyWSj+RyoF
	 9VbWbJfk0mixrggvqzwop77gbaC2J1jsAtBP0shj0TCoLQXM3zNsGCNymjEsMEpJtV
	 LdTqwosJnoq8A==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/34] sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
Date: Wed, 21 Jan 2026 13:11:18 -1000
Message-ID: <20260121231140.832332-13-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_move[_vtime]() calls scx_dsq_move() to move task from a DSQ to
another. However, @p doesn't necessarily have to come form the containing
iteration and can thus be a task which belongs to another scx_sched. Verify
that @p is on the same scx_sched as the DSQ being iterated.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index aad3af8e8377..07cd130f62fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6463,8 +6463,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
+	struct scx_sched *sch = src_dsq->sched;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
@@ -6481,6 +6481,11 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (unlikely(READ_ONCE(scx_aborting)))
 		return false;
 
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
+			  p->comm, p->pid);
+	}
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
-- 
2.52.0

