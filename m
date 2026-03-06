Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFF421F10;
	Fri,  6 Mar 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824000; cv=none; b=ETF46QHXvz7poIAUvQaB6Qbenu0xSAeBJ534FxgFDkiZfCV3Ntr1OL2PVLgeX4VYA9nWuG0bwSvlDKFGBGeBsCJsZ0pKKDE5CtiWXvkxllfSG1IE1szhVb9Ei5yyE5P/oPt5JqXXjkgel5mfc5TPT14gMRBi9Jn8mStXCfiFKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824000; c=relaxed/simple;
	bh=TFYywAM/f+xXUDVeL7sQ9iz7QOKrWvoe9JXAoKFbIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuNzWDdSXQ+XKJDC4Hnf373qHWaWzCyA43HCvaONVcGuao/OM3IY+qvCvFaidh3inlJbNC714CdI2NKsSYL2nOe/Rk5PHsWoddgSskFC19W+W84NyeS+361HlUOkltBCXRC5hhiozqRPCrPR5+MLmQ+FwZdgyxYMmZpz+s7F5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJE1PcKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJE1PcKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FBC19425;
	Fri,  6 Mar 2026 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772824000;
	bh=TFYywAM/f+xXUDVeL7sQ9iz7QOKrWvoe9JXAoKFbIIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJE1PcKxf7UE8hYPqfc6rx0RWwFYosGnLO47pGo/MhdNq8eoRZYZeaOHY0tTL308p
	 mNcW1qLU7tX+jWXvBeZyEjFHYr+Q0fYH6c/naiDiY0NEhEW54qnFeB34ZjKYVHwrNa
	 +PCEI2u2WxTvzWfUXmcaymDyOcSe9/uuGvDF2rGa2xJaOaAEwToVzVbiRq3rUnv7ka
	 9BQql4l0I0BInFSqCWdrmX/DYKlNkr+4zKdxMjCtnEcaqDL0IMfXEK1fuTiazO+vf3
	 K4o6SwKoDcx6dHL+l9ZQ5VNe5e3VW+3wFR+QDwhcSwtrA2u+6evj219JV4EkutqRHG
	 tmJny7T7aZWvw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/15] sched_ext: Add SCX_TASK_REENQ_REASON flags
Date: Fri,  6 Mar 2026 09:06:23 -1000
Message-ID: <20260306190623.1076074-16-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_ENQ_REENQ indicates that a task is being re-enqueued but doesn't tell the
BPF scheduler why. Add SCX_TASK_REENQ_REASON flags using bits 12-13 of
p->scx.flags to communicate the reason during ops.enqueue():

- NONE: Not being reenqueued
- KFUNC: Reenqueued by scx_bpf_dsq_reenq() and friends

More reasons will be added.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   | 15 +++++++++++++++
 kernel/sched/ext.c          | 25 ++++++++++++++++++++++---
 kernel/sched/ext_internal.h | 10 +++-------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index e822b374b17f..60a4f65d0174 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -118,6 +118,21 @@ enum scx_ent_flags {
 	SCX_TASK_READY		= 2 << SCX_TASK_STATE_SHIFT,
 	SCX_TASK_ENABLED	= 3 << SCX_TASK_STATE_SHIFT,
 
+	/*
+	 * Bits 12 and 13 are used to carry reenqueue reason. In addition to
+	 * %SCX_ENQ_REENQ flag, ops.enqueue() can also test for
+	 * %SCX_TASK_REENQ_REASON_NONE to distinguish reenqueues.
+	 *
+	 * NONE		not being reenqueued
+	 * KFUNC	reenqueued by scx_bpf_dsq_reenq() and friends
+	 */
+	SCX_TASK_REENQ_REASON_SHIFT = 12,
+	SCX_TASK_REENQ_REASON_BITS = 2,
+	SCX_TASK_REENQ_REASON_MASK = ((1 << SCX_TASK_REENQ_REASON_BITS) - 1) << SCX_TASK_REENQ_REASON_SHIFT,
+
+	SCX_TASK_REENQ_NONE	= 0 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_KFUNC	= 1 << SCX_TASK_REENQ_REASON_SHIFT,
+
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
 };
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df659e51bd8a..66af7a83bb1e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3729,8 +3729,10 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
-static bool task_should_reenq(struct task_struct *p, u64 reenq_flags)
+static bool task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
 {
+	*reason = SCX_TASK_REENQ_KFUNC;
+
 	if (reenq_flags & SCX_REENQ_ANY)
 		return true;
 	return false;
@@ -3752,6 +3754,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
 				 scx.dsq_list.node) {
 		struct scx_sched *task_sch = scx_task_sched(p);
+		u32 reason;
 
 		/*
 		 * If @p is being migrated, @p's current CPU may not agree with
@@ -3770,16 +3773,24 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!scx_is_descendant(task_sch, sch))
 			continue;
 
-		if (!task_should_reenq(p, reenq_flags))
+		if (!task_should_reenq(p, reenq_flags, &reason))
 			continue;
 
 		dispatch_dequeue(rq, p);
+
+		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		p->scx.flags |= reason;
+
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
 	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
 		list_del_init(&p->scx.dsq_list.node);
+
 		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 		nr_enqueued++;
 	}
 
@@ -3833,12 +3844,13 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 
 	while (likely(!READ_ONCE(sch->bypass_depth))) {
 		struct rq *task_rq;
+		u32 reason;
 
 		p = nldsq_cursor_next_task(&cursor, dsq);
 		if (!p)
 			break;
 
-		if (!task_should_reenq(p, reenq_flags))
+		if (!task_should_reenq(p, reenq_flags, &reason))
 			continue;
 
 		task_rq = task_rq(p);
@@ -3861,8 +3873,15 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		/* @p is on @dsq, its rq and @dsq are locked */
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
+
+		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		p->scx.flags |= reason;
+
 		do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
 
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+
 		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
 			raw_spin_rq_unlock(locked_rq);
 			locked_rq = NULL;
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index d9eda2e8701c..f8df73044515 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1080,13 +1080,9 @@ enum scx_enq_flags {
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
 	/*
-	 * The task being enqueued was previously enqueued on the current CPU's
-	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
-	 * scx_bpf_reenqueue_local() kfunc. If scx_bpf_reenqueue_local() was
-	 * invoked in a ->cpu_release() callback, and the task is again
-	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
-	 * task will not be scheduled on the CPU until at least the next invocation
-	 * of the ->cpu_acquire() callback.
+	 * The task being enqueued was previously enqueued on a DSQ, but was
+	 * removed and is being re-enqueued. See SCX_TASK_REENQ_* flags to find
+	 * out why a given task is being reenqueued.
 	 */
 	SCX_ENQ_REENQ		= 1LLU << 40,
 
-- 
2.53.0

