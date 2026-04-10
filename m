Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9338A718;
	Fri, 10 Apr 2026 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802654; cv=none; b=FQ4yaRtBRF1tcmGtsvWW42o0BJDyVkxmIQgaDtjJO0OVWY0rRhxStQvatkJFQGmUKmOo2F3MVBBnD2GxAh6ausxwNK/DtjoUwvqtksXPAxpUX/+hKaRFvkOw98Vitr7+2FSgF0v7hNoSPd8Gn/e18jJGzrsfKgJXks+N688t5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802654; c=relaxed/simple;
	bh=wiJFHileQ+ppFseX2D5Q4r/DnY65TWDGKAgRx+FaKZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syoOtey14qWs6TR6PCMo1+gF/Qu9M6WXpuzDtjYNcyKutbY2+9I8472m984xRP87at6THtH6y0i2uEJ4oN8nEOt2NZa5UqB+is1On2qz/GCJZvmNo46zJK+ibzG89s6kneCFB1o93iINfGaHSxw3Vxl3c+s9Ep+a/fZmb6ZSD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAl+GUcc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAl+GUcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E62C2BCB1;
	Fri, 10 Apr 2026 06:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802654;
	bh=wiJFHileQ+ppFseX2D5Q4r/DnY65TWDGKAgRx+FaKZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAl+GUccZzRQXlA0u41beGWo5I1XHgaVruTj7HWVTv3XIUYbz7Gc2is33+9fFDnEb
	 B5UXB7+aKl3SZ51+u493qMPaYoW8ur8cbjFiPp2qlk2SfmsmH2MD9FeTn23VcUcpNI
	 Pg1dWcyYpC7F4sNXXUAoYFo949NHtc06d+BLA+MplM/+yAN3PFc+u7CBe/YUcT3D81
	 qC3lrSlElESX9ojdMza0qd2nZ+MP1fIF96dtraaaMC7Bo87WPwShCj+/LK+wfCECt4
	 0gkbg2/oS3lRv4OHhVHqQ9rhX8tCNH6HcCWBOPRCbOQhE3dP5GbG/V7T5QOb4WOp18
	 u8EYZ1m4Nf1cQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] sched_ext: Drop redundant rq-locked check from scx_bpf_task_cgroup()
Date: Thu,  9 Apr 2026 20:30:42 -1000
Message-ID: <20260410063046.3556100-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_kf_allowed_on_arg_tasks() runs both an scx_kf_allowed(__SCX_KF_RQ_LOCKED)
mask check and a kf_tasks[] check. After the preceding call-site fixes,
every SCX_CALL_OP_TASK*() invocation has kf_mask & __SCX_KF_RQ_LOCKED
non-zero, so the mask check is redundant whenever the kf_tasks[] check
passes. Drop it and simplify the helper to take only @sch and @p.

Fold the locking guarantee into the SCX_CALL_OP_TASK() comment block, which
scx_bpf_task_cgroup() now points to.

No functional change.

Extracted from a larger verifier-time kfunc context filter patch
originally written by Juntong Deng.

Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a0bcdc805273..6d7c5c2605c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -540,15 +540,18 @@ do {										\
 })
 
 /*
- * Some kfuncs are allowed only on the tasks that are subjects of the
- * in-progress scx_ops operation for, e.g., locking guarantees. To enforce such
- * restrictions, the following SCX_CALL_OP_*() variants should be used when
- * invoking scx_ops operations that take task arguments. These can only be used
- * for non-nesting operations due to the way the tasks are tracked.
- *
- * kfuncs which can only operate on such tasks can in turn use
- * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
- * the specific task.
+ * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
+ * and records them in current->scx.kf_tasks[] for the duration of the call. A
+ * kfunc invoked from inside such an op can then use
+ * scx_kf_allowed_on_arg_tasks() to verify that its task argument is one of
+ * those subject tasks.
+ *
+ * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
+ * either via the @rq argument here, or (for ops.select_cpu()) via @p's pi_lock
+ * held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu. So if
+ * kf_tasks[] is set, @p's scheduler-protected fields are stable.
+ *
+ * These macros only work for non-nesting ops since kf_tasks[] is not stacked.
  */
 #define SCX_CALL_OP_TASK(sch, mask, op, rq, task, args...)			\
 do {										\
@@ -613,12 +616,8 @@ static __always_inline bool scx_kf_allowed(struct scx_sched *sch, u32 mask)
 
 /* see SCX_CALL_OP_TASK() */
 static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
-							u32 mask,
 							struct task_struct *p)
 {
-	if (!scx_kf_allowed(sch, mask))
-		return false;
-
 	if (unlikely((p != current->scx.kf_tasks[0] &&
 		      p != current->scx.kf_tasks[1]))) {
 		scx_error(sch, "called on a task not being operated on");
@@ -9535,9 +9534,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
  * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
  * from the scheduler's POV. SCX operations should use this function to
  * determine @p's current cgroup as, unlike following @p->cgroups,
- * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
- * rq-locked operations. Can be called on the parameter tasks of rq-locked
- * operations. The restriction guarantees that @p's rq is locked by the caller.
+ * @p->sched_task_group is stable for the duration of the SCX op. See
+ * SCX_CALL_OP_TASK() for details.
  */
 __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 					       const struct bpf_prog_aux *aux)
@@ -9552,7 +9550,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 	if (unlikely(!sch))
 		goto out;
 
-	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(sch, p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
-- 
2.53.0

