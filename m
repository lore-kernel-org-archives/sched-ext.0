Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82772384249
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757323; cv=none; b=WTftIK790gTuaSIemUpELqYpuCKSxWrsxd6bxBk+gTCYDMAYrJoEFmStvKZ8xtA2qDyzgLVpUSPUv/d2z/8Bb11R0qTiEq6M8W7m3ROeHFWi3VVnsAiV/1jwPIejEii9k+2RSzBq2TaX44UhPxLDXf5sDSQQGXGCdJRP1f71ZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757323; c=relaxed/simple;
	bh=sfjioUaQo0yCJAHoE/77AyEh5uDV+4qhnkiIpJsrCR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUJRz2MuEIYqYItASpPsTDBlMgwhdNe48Dn9Uw5Fpuc8P7U7EQpVNeK4oUEWmkP/+wKxykp8Ycc12f1LU0G3zXQb9VCEEIBOyLK5YvERZ2zcHnRtEKLIcw3MazCkEEawVfq98xahy3rkFhB6ao7YCszat/zATVXsGR+lrlY0YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NINBQ6n/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NINBQ6n/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2551393a91.3
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776757322; x=1777362122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBYy3Jfrhb7qcHHkSroUAQ5EBGIuhc+jxuCnT81HWnk=;
        b=NINBQ6n/qLjaf3C518IpiQxIswhCjli/6Suat0ho8aaVIpFwQU+jorErpQleHU7TV0
         o+3JMNpUiNxIBFJ1crUflFwBUThnlBhShMBT0/cMfrZnYq5CWZZGamuUAmtoEPI7z0yb
         Bngs2G/WwcI+fq/2WUEBjHDXGM6XprO7Fi3UK9nGmQPUcKWUG3+58ogfNFcq0twbfm3A
         7ru7AxmopqjeZfYPqUZZ3PJWtu/enHvRZHO+ec0mtDCNfMdWDPddNs/HITTbJ54UgoYS
         o6SL32uPhIxzCFcLqwvSW7S46LZ6JV8lsz/lXLDtc/aHznizO6DpwzGaPUbWfn0WcacZ
         4oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776757322; x=1777362122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBYy3Jfrhb7qcHHkSroUAQ5EBGIuhc+jxuCnT81HWnk=;
        b=lyDb9ml3XBeSQtqfoD2TbG/d3Y4lpn9g1gavHM1N2r7zBGBb1hy5PM93BaPdTiMnOi
         2gKzXUZTjkdSKPlrV54JT/pwe0p0xCYRc8qiZuKiHqmfj7m0Gt5L0P/zzAXcinEdNb81
         Dplem1lCMWvHYyzZV3qxTzXY4x5uPPv7S4PT5exMSTeuntd4/FuKEXD/qr481LTD3Cmc
         1RmpxKRV2GmQc2Y8rEXympgnlbhwNEWcMGsSLkwPdw7NWXetBizc2YV8AUxD6A2WqzHR
         R/Ejpw4FyhHO7uxpEdiC5spT6wyeHm7tiWRau1aaxg47qa5GDv7K0Ukv214lgAV76vDE
         E0xw==
X-Gm-Message-State: AOJu0YynfCKoRqP8O6tA0KIRLAqYg11H5GcQpDgkBVeKEtdm/nYjA7B6
	yYH37f2lXwAafpWQz03EzmqmAGW4e5fBQIEqYio+xlW9FTgVI1DiF9kIQgZxaQ==
X-Gm-Gg: AeBDievxMsMHdx3VXMXUQGcKXHr0LFaEzgI9r9a9nHvasSRSu3UwUz2/rrKo4v0vwLk
	K4VTKcDwF2qKKFfP7BxPG2CBcRovpq2ERxLd8UyayMgLUsV5CRSyZ4Ez3yaCftv0cHTFXJ4yXKm
	HtiMIgXHvCHmvN2XbKKqQeKy97g0xkSpNgrb5LhGvx7SOOLLsn33EeB03Dv/WJ4179TFvNSIdSi
	TUqeIPbMz0uAThRwvE6WgpAuSyHOy3rQEtubBm5V5j6BvcbMteZRTboDjfpg5dc96Wcv+Aq5iKd
	iuZIo/EEyB7gMTEvSO3NwkZzP3lnmsgYMRZvl171nNUdtlsy/SQiwQpBf2CBFkCrDSyUcto1d+L
	6bdNpqBa3XA1O0LSQcJ78EEFlJ1BdxNxO5V7hTTmwrFCikE0SkT9IHRD1cPoMythySNugIRGCnf
	M9iifpO0/v84QQ/qZ0T+BdLtsLO51+iL8tUtDJAlIiuPxhrPksy5pBA7UUpWkzAac=
X-Received: by 2002:a17:903:1663:b0:2b2:dca5:101b with SMTP id d9443c01a7336-2b5f9efc3b7mr190070645ad.12.1776757321531;
        Tue, 21 Apr 2026 00:42:01 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:f553:3118:76d2:96d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm126987055ad.5.2026.04.21.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:42:01 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2] sched_ext: Refactor scx_root_enable_workfn() enablement task migration
Date: Tue, 21 Apr 2026 15:41:35 +0800
Message-ID: <20260421074154.584737-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scx_root_enable_workfn() function handles several distinct phases of
scheduler enablement. Decomposing it into focused helpers clarifies the
high-level flow:

  +-----------------------+
  | 1. Prep & Sched Alloc |
  +-----------------------+
             |
             v
  +-----------------------+
  | 2. CPU & Subsys Init  |
  +-----------------------+
             |
             v
  +-----------------------+
  | 3. Task Preparation   | <-- Extracted to scx_ops_prep_tasks()
  +-----------------------+
             |
             v
  +-----------------------+
  | 4. THE COMMIT POINT   | <-- static_branch_enable()
  +-----------------------+
             |
             v
  +-----------------------+
  | 5. Task Switching     | <-- Extracted to scx_ops_switch_tasks()
  +-----------------------+
             |
             v
  +-----------------------+
  | 6. Finalize & Cleanup |
  +-----------------------+

Phases 3 & 5 involved large, indented task iteration loops that made
the critical transition point (Phase 4) difficult to identify.

- scx_ops_prep_tasks() handles Phase 3, including scx_fork_rwsem and
  cgroup_lock acquisition, task-specific initialization, and TID hash
  insertion.

- scx_ops_switch_tasks() handles Phase 5, performing the final transition
  of READY tasks to the ext_sched_class.

No functional changes.

Test plan:
- Run all demo schedulers with stress-ng -c 10 without crashing.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Currently, scx_root_enable_workfn() is ~240 lines long.
IMHO, this makes it hard to maintain and follow.

 kernel/sched/ext.c | 216 +++++++++++++++++++++++++--------------------
 1 file changed, 119 insertions(+), 97 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0a53a0dd64bf..21880db4e757 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6673,14 +6673,128 @@ struct scx_enable_cmd {
 	int			ret;
 };
 
+static int scx_ops_prep_tasks(struct scx_sched *sch)
+{
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	int ret;
+
+	percpu_down_write(&scx_fork_rwsem);
+
+	WARN_ON_ONCE(scx_init_task_enabled);
+	scx_init_task_enabled = true;
+
+	/* flip under fork_rwsem; the iter below covers existing tasks */
+	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
+		static_branch_enable(&__scx_tid_to_task_enabled);
+
+	/*
+	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
+	 * preventing new tasks from being added. No need to exclude tasks
+	 * leaving as sched_ext_free() can handle both prepped and enabled
+	 * tasks. Prep all tasks first and then enable them with preemption
+	 * disabled.
+	 *
+	 * All cgroups should be initialized before scx_init_task() so that the
+	 * BPF scheduler can reliably track each task's cgroup membership from
+	 * scx_init_task(). Lock out cgroup on/offlining and task migrations
+	 * while tasks are being initialized so that scx_cgroup_can_attach()
+	 * never sees uninitialized tasks.
+	 */
+	scx_cgroup_lock();
+	set_cgroup_sched(sch_cgroup(sch), sch);
+	ret = scx_cgroup_init(sch);
+	if (ret)
+		goto err_unlock_all;
+
+	scx_task_iter_start(&sti, NULL);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		/*
+		 * @p may already be dead, have lost all its usages counts and
+		 * be waiting for RCU grace period before being freed. @p can't
+		 * be initialized for SCX in such cases and should be ignored.
+		 */
+		if (!tryget_task_struct(p))
+			continue;
+
+		scx_task_iter_unlock(&sti);
+
+		ret = scx_init_task(sch, p, false);
+		if (ret) {
+			put_task_struct(p);
+			scx_task_iter_stop(&sti);
+			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
+				  ret, p->comm, p->pid);
+			goto err_unlock_all;
+		}
+
+		scx_set_task_sched(p, sch);
+		scx_set_task_state(p, SCX_TASK_READY);
+
+		/*
+		 * Insert into the tid hash under scx_tasks_lock so we can't
+		 * race sched_ext_dead() and leave a stale entry for an already
+		 * exited task.
+		 */
+		if (scx_tid_to_task_enabled()) {
+			guard(raw_spinlock_irq)(&scx_tasks_lock);
+			if (!list_empty(&p->scx.tasks_node))
+				scx_tid_hash_insert(p);
+		}
+
+		put_task_struct(p);
+	}
+	scx_task_iter_stop(&sti);
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+
+	return 0;
+
+err_unlock_all:
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+	return ret;
+}
+
+static void scx_ops_switch_tasks(struct scx_sched *sch)
+{
+	struct scx_task_iter sti;
+	struct task_struct *p;
+
+	percpu_down_write(&scx_fork_rwsem);
+
+	/*
+	 * We're fully committed and can't fail. The task READY -> ENABLED
+	 * transitions here are synchronized against sched_ext_free() through
+	 * scx_tasks_lock.
+	 */
+	scx_task_iter_start(&sti, NULL);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
+		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class = scx_setscheduler_class(p);
+
+		if (scx_get_task_state(p) != SCX_TASK_READY)
+			continue;
+
+		if (old_class != new_class)
+			queue_flags |= DEQUEUE_CLASS;
+
+		scoped_guard (sched_change, p, queue_flags) {
+			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			p->sched_class = new_class;
+		}
+	}
+	scx_task_iter_stop(&sti);
+	percpu_up_write(&scx_fork_rwsem);
+}
+
 static void scx_root_enable_workfn(struct kthread_work *work)
 {
 	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
 	struct sched_ext_ops *ops = cmd->ops;
 	struct cgroup *cgrp = root_cgroup();
 	struct scx_sched *sch;
-	struct scx_task_iter sti;
-	struct task_struct *p;
 	int i, cpu, ret;
 
 	mutex_lock(&scx_enable_mutex);
@@ -6790,74 +6904,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
 	 */
-	percpu_down_write(&scx_fork_rwsem);
-
-	WARN_ON_ONCE(scx_init_task_enabled);
-	scx_init_task_enabled = true;
-
-	/* flip under fork_rwsem; the iter below covers existing tasks */
-	if (ops->flags & SCX_OPS_TID_TO_TASK)
-		static_branch_enable(&__scx_tid_to_task_enabled);
-
-	/*
-	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
-	 * preventing new tasks from being added. No need to exclude tasks
-	 * leaving as sched_ext_free() can handle both prepped and enabled
-	 * tasks. Prep all tasks first and then enable them with preemption
-	 * disabled.
-	 *
-	 * All cgroups should be initialized before scx_init_task() so that the
-	 * BPF scheduler can reliably track each task's cgroup membership from
-	 * scx_init_task(). Lock out cgroup on/offlining and task migrations
-	 * while tasks are being initialized so that scx_cgroup_can_attach()
-	 * never sees uninitialized tasks.
-	 */
-	scx_cgroup_lock();
-	set_cgroup_sched(sch_cgroup(sch), sch);
-	ret = scx_cgroup_init(sch);
+	ret = scx_ops_prep_tasks(sch);
 	if (ret)
-		goto err_disable_unlock_all;
-
-	scx_task_iter_start(&sti, NULL);
-	while ((p = scx_task_iter_next_locked(&sti))) {
-		/*
-		 * @p may already be dead, have lost all its usages counts and
-		 * be waiting for RCU grace period before being freed. @p can't
-		 * be initialized for SCX in such cases and should be ignored.
-		 */
-		if (!tryget_task_struct(p))
-			continue;
-
-		scx_task_iter_unlock(&sti);
-
-		ret = scx_init_task(sch, p, false);
-		if (ret) {
-			put_task_struct(p);
-			scx_task_iter_stop(&sti);
-			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
-				  ret, p->comm, p->pid);
-			goto err_disable_unlock_all;
-		}
-
-		scx_set_task_sched(p, sch);
-		scx_set_task_state(p, SCX_TASK_READY);
-
-		/*
-		 * Insert into the tid hash under scx_tasks_lock so we can't
-		 * race sched_ext_dead() and leave a stale entry for an already
-		 * exited task.
-		 */
-		if (scx_tid_to_task_enabled()) {
-			guard(raw_spinlock_irq)(&scx_tasks_lock);
-			if (!list_empty(&p->scx.tasks_node))
-				scx_tid_hash_insert(p);
-		}
-
-		put_task_struct(p);
-	}
-	scx_task_iter_stop(&sti);
-	scx_cgroup_unlock();
-	percpu_up_write(&scx_fork_rwsem);
+		goto err_disable;
 
 	/*
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
@@ -6866,31 +6915,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
 	static_branch_enable(&__scx_enabled);
 
-	/*
-	 * We're fully committed and can't fail. The task READY -> ENABLED
-	 * transitions here are synchronized against sched_ext_free() through
-	 * scx_tasks_lock.
-	 */
-	percpu_down_write(&scx_fork_rwsem);
-	scx_task_iter_start(&sti, NULL);
-	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
-		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class = scx_setscheduler_class(p);
-
-		if (scx_get_task_state(p) != SCX_TASK_READY)
-			continue;
-
-		if (old_class != new_class)
-			queue_flags |= DEQUEUE_CLASS;
-
-		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
-			p->sched_class = new_class;
-		}
-	}
-	scx_task_iter_stop(&sti);
-	percpu_up_write(&scx_fork_rwsem);
+	scx_ops_switch_tasks(sch);
 
 	scx_bypass(sch, false);
 
@@ -6922,9 +6947,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	cmd->ret = ret;
 	return;
 
-err_disable_unlock_all:
-	scx_cgroup_unlock();
-	percpu_up_write(&scx_fork_rwsem);
 	/* we'll soon enter disable path, keep bypass on */
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
-- 
2.48.1

