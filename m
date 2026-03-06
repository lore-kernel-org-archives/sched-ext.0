Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086992641FC;
	Fri,  6 Mar 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818770; cv=none; b=oblXes1AVi+bLoqiuOxOS4qId9QSS7TbISvw1hmk16qVpmrBQO6H9BXd+JwFK+59j8ik0NTPvSE5lgiC4YHneAoaeFcwsw7r288HU2D9mvkA9sYmS/kNNrJzg4NnwruzvX6XeJadMrLjR9v3Y8RX+RDCmyB6Snl4+fumEM52h5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818770; c=relaxed/simple;
	bh=53lkugIh9yJgTVGPfLNKn1r0jUDMQbDQnU6FLB3QjLU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FVeaM30O2JcBHqxHrTUlXKVzHssJi1igjoQQ1GFIfrG2/YFOmZr09Aw1lrwQ4JfuNz2m/brQcMD5hCP+48n6Li6sEvVkl3terDjdjF8z7X6HxskHdlrU9IKhGNpRV/hb01sRRbNvGm8ja3KWnkr9buTQXnB3Q2+e4bbZLMcg784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhe2RGi5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhe2RGi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B5CC4CEF7;
	Fri,  6 Mar 2026 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772818769;
	bh=53lkugIh9yJgTVGPfLNKn1r0jUDMQbDQnU6FLB3QjLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vhe2RGi5ldLd4AfdPCecYldYilC6pmCJb/0Mwa5DCjcj0aJ3cG5hpyViz3LOLnZ5J
	 RT4Y6oz0Y6Z1obJrOn6TKIskJr6/h8mWcYJlJwkgHNbOI5aAyrJA8yW4FqVDulNEjv
	 l+RYcuM6pVFOoEBMZfY8wTkSMGCgV7TJeuSBGeEW0diFKmw0KQ/NnRfaHAydXtS5KD
	 hxOyFBECnG6mzFyQ3WKwYZrhRv2zLyaAzOim9BOr2YWH1KCKsKWt7tvwu9MNrCl60/
	 sPL/Lu+F3mAaEzxqRlwneEW03pZcAwvT02IAT3/KlazPtCWjjiFymwiljmEnov/9ee
	 z0a+Xt7dBzViQ==
Date: Fri, 06 Mar 2026 07:39:28 -1000
Message-ID: <469f234fc8aa6b1df4afd6ea80f77a47@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 jserv@ccns.ncku.edu.tw
Subject: [PATCH v2 29/34] sched_ext: Implement cgroup sub-sched enabling
 and disabling
In-Reply-To: <20260304220119.4095551-30-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-30-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The preceding changes implemented the framework to support cgroup
sub-scheds and updated scheduling paths and kfuncs so that they have
minimal but working support for sub-scheds. However, actual sub-sched
enabling/disabling hasn't been implemented yet and all tasks stayed on
scx_root.

Implement cgroup sub-sched enabling and disabling to actually activate
sub-scheds:

- Both enable and disable operations bypass only the tasks in the subtree
  of the child being enabled or disabled to limit disruptions.

- When enabling, all candidate tasks are first initialized for the child
  sched. Once that succeeds, the tasks are exited for the parent and then
  switched over to the child. This adds a bit of complication but
  guarantees that child scheduler failures are always contained.

- Disabling works the same way in the other direction. However, when the
  parent may fail to initialize a task, disabling is propagated up to the
  parent. While this means that a parent sched fail due to a child sched
  event, the failure can only originate from the parent itself (its
  ops.init_task()). The only effect a malfunctioning child can have on the
  parent is attempting to move the tasks back to the parent.

After this change, although not all the necessary mechanisms are in place
yet, sub-scheds can take control of their tasks and schedule them.

v2: Fix missing scx_cgroup_unlock()/percpu_up_write() in abort path
    (Cheng-Yang Chou).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |    1
 include/linux/sched/ext.h |    1 
 kernel/sched/ext.c        |  285 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 280 insertions(+), 6 deletions(-)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -88,6 +88,7 @@ enum scx_ent_flags {
 	SCX_TASK_IN_CUSTODY	= 1 << 1, /* in custody, needs ops.dequeue() when leaving */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 
 	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
 	SCX_TASK_STATE_BITS	= 2,
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -51,6 +51,17 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_a
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/*
+ * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
+ * tasks for the sub-sched being enabled. Use a global variable instead of a
+ * per-task field as all enables are serialized.
+ */
+static struct scx_sched *scx_enabling_sub_sched;
+#else
+#define scx_enabling_sub_sched	(struct scx_sched *)NULL
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 /*
  * A monotically increasing sequence number that is incremented every time a
  * scheduler is enabled. This can be used by to check if any custom sched_ext
@@ -3342,6 +3353,17 @@ static void scx_disable_and_exit_task(st
 {
 	__scx_disable_and_exit_task(sch, p);
 
+	/*
+	 * If set, @p exited between __scx_init_task() and scx_enable_task() in
+	 * scx_sub_enable() and is initialized for both the associated sched and
+	 * its parent. Disable and exit for the child too.
+	 */
+	if ((p->scx.flags & SCX_TASK_SUB_INIT) &&
+	    !WARN_ON_ONCE(!scx_enabling_sub_sched)) {
+		__scx_disable_and_exit_task(scx_enabling_sub_sched, p);
+		p->scx.flags &= ~SCX_TASK_SUB_INIT;
+	}
+
 	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
@@ -3377,9 +3399,14 @@ int scx_fork(struct task_struct *p, stru
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(scx_root, p, true);
+#ifdef CONFIG_EXT_SUB_SCHED
+		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
+#else
+		struct scx_sched *sch = scx_root;
+#endif
+		ret = scx_init_task(sch, p, true);
 		if (!ret)
-			scx_set_task_sched(p, scx_root);
+			scx_set_task_sched(p, sch);
 		return ret;
 	}
 
@@ -4643,9 +4670,9 @@ static void scx_bypass(struct scx_sched
 		struct rq *rq = cpu_rq(cpu);
 		struct task_struct *p, *n;
 
+		raw_spin_lock(&scx_sched_lock);
 		raw_spin_rq_lock(rq);
 
-		raw_spin_lock(&scx_sched_lock);
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
 
@@ -4654,6 +4681,7 @@ static void scx_bypass(struct scx_sched
 			else
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+
 		raw_spin_unlock(&scx_sched_lock);
 
 		/*
@@ -4798,23 +4826,139 @@ static void drain_descendants(struct scx
 	wait_event(scx_unlink_waitq, list_empty(&sch->children));
 }
 
+static void scx_fail_parent(struct scx_sched *sch,
+			    struct task_struct *failed, s32 fail_code)
+{
+	struct scx_sched *parent = scx_parent(sch);
+	struct scx_task_iter sti;
+	struct task_struct *p;
+
+	scx_error(parent, "ops.init_task() failed (%d) for %s[%d] while disabling a sub-scheduler",
+		  fail_code, failed->comm, failed->pid);
+
+	/*
+	 * Once $parent is bypassed, it's safe to put SCX_TASK_NONE tasks into
+	 * it. This may cause downstream failures on the BPF side but $parent is
+	 * dying anyway.
+	 */
+	scx_bypass(parent, true);
+
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		if (scx_task_on_sched(parent, p))
+			continue;
+
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			scx_disable_and_exit_task(sch, p);
+			rcu_assign_pointer(p->scx.sched, parent);
+		}
+	}
+	scx_task_iter_stop(&sti);
+}
+
 static void scx_sub_disable(struct scx_sched *sch)
 {
 	struct scx_sched *parent = scx_parent(sch);
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	int ret;
 
+	/*
+	 * Guarantee forward progress and wait for descendants to be disabled.
+	 * To limit
+	 * disruptions, $parent is not bypassed. Tasks are fully prepped and
+	 * then inserted back into $parent.
+	 */
+	scx_bypass(sch, true);
 	drain_descendants(sch);
 
+	/*
+	 * Here, every runnable task is guaranteed to make forward progress and
+	 * we can safely use blocking synchronization constructs. Actually
+	 * disable ops.
+	 */
 	mutex_lock(&scx_enable_mutex);
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
 	set_cgroup_sched(sch_cgroup(sch), parent);
 
-	/* TODO - perform actual disabling here */
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		/* filter out duplicate visits */
+		if (scx_task_on_sched(parent, p))
+			continue;
+
+		/*
+		 * By the time control reaches here, all descendant schedulers
+		 * should already have been disabled.
+		 */
+		WARN_ON_ONCE(!scx_task_on_sched(sch, p));
+
+		/*
+		 * If $p is about to be freed, nothing prevents $sch from
+		 * unloading before $p reaches sched_ext_free(). Disable and
+		 * exit $p right away.
+		 */
+		if (!tryget_task_struct(p)) {
+			scx_disable_and_exit_task(sch, p);
+			continue;
+		}
+
+		scx_task_iter_unlock(&sti);
+
+		/*
+		 * $p is READY or ENABLED on @sch. Initialize for $parent,
+		 * disable and exit from @sch, and then switch over to $parent.
+		 *
+		 * If a task fails to initialize for $parent, the only available
+		 * action is disabling $parent too. While this allows disabling
+		 * of a child sched to cause the parent scheduler to fail, the
+		 * failure can only originate from ops.init_task() of the
+		 * parent. A child can't directly affect the parent through its
+		 * own failures.
+		 */
+		ret = __scx_init_task(parent, p, false);
+		if (ret) {
+			scx_fail_parent(sch, p, ret);
+			put_task_struct(p);
+			break;
+		}
+
+		rq = task_rq_lock(p, &rf);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			/*
+			 * $p is initialized for $parent and still attached to
+			 * @sch. Disable and exit for @sch, switch over to
+			 * $parent, override the state to READY to account for
+			 * $p having already been initialized, and then enable.
+			 */
+			scx_disable_and_exit_task(sch, p);
+			scx_set_task_state(p, SCX_TASK_INIT);
+			rcu_assign_pointer(p->scx.sched, parent);
+			scx_set_task_state(p, SCX_TASK_READY);
+			scx_enable_task(parent, p);
+		}
+		task_rq_unlock(rq, p, &rf);
+
+		put_task_struct(p);
+	}
+	scx_task_iter_stop(&sti);
 
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	/*
+	 * All tasks are moved off of @sch but there may still be on-going
+	 * operations (e.g. ops.select_cpu()). Drain them by flushing RCU. Use
+	 * the expedited version as ancestors may be waiting in bypass mode.
+	 * Also, tell the parent that there is no need to keep running bypass
+	 * DSQs for us.
+	 */
+	synchronize_rcu_expedited();
 	disable_bypass_dsp(sch);
 
 	raw_spin_lock_irq(&scx_sched_lock);
@@ -5933,13 +6077,30 @@ static struct scx_sched *find_parent_sch
 	return parent;
 }
 
+static bool assert_task_ready_or_enabled(struct task_struct *p)
+{
+	enum scx_task_state state = scx_get_task_state(p);
+
+	switch (state) {
+	case SCX_TASK_READY:
+	case SCX_TASK_ENABLED:
+		return true;
+	default:
+		WARN_ONCE(true, "sched_ext: Invalid task state %d for %s[%d] during enabling sub sched",
+			  state, p->comm, p->pid);
+		return false;
+	}
+}
+
 static void scx_sub_enable_workfn(struct kthread_work *work)
 {
 	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
 	struct sched_ext_ops *ops = cmd->ops;
 	struct cgroup *cgrp;
 	struct scx_sched *parent, *sch;
-	s32 ret;
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	s32 i, ret;
 
 	mutex_lock(&scx_enable_mutex);
 
@@ -6011,6 +6172,12 @@ static void scx_sub_enable_workfn(struct
 	}
 	sch->sub_attached = true;
 
+	scx_bypass(sch, true);
+
+	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
+		if (((void (**)(void))ops)[i])
+			set_bit(i, sch->has_op);
+
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
@@ -6024,16 +6191,121 @@ static void scx_sub_enable_workfn(struct
 		goto err_unlock_and_disable;
 	}
 
-	/* TODO - perform actual enabling here */
+	/*
+	 * Initialize tasks for the new child $sch without exiting them for
+	 * $parent so that the tasks can always be reverted back to $parent
+	 * sched on child init failure.
+	 */
+	WARN_ON_ONCE(scx_enabling_sub_sched);
+	scx_enabling_sub_sched = sch;
+
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		/*
+		 * Task iteration may visit the same task twice when racing
+		 * against exiting. Use %SCX_TASK_SUB_INIT to mark tasks which
+		 * finished __scx_init_task() and skip if set.
+		 *
+		 * A task may exit and get freed between __scx_init_task()
+		 * completion and scx_enable_task(). In such cases,
+		 * scx_disable_and_exit_task() must exit the task for both the
+		 * parent and child scheds.
+		 */
+		if (p->scx.flags & SCX_TASK_SUB_INIT)
+			continue;
+
+		/* see scx_root_enable() */
+		if (!tryget_task_struct(p))
+			continue;
+
+		if (!assert_task_ready_or_enabled(p)) {
+			ret = -EINVAL;
+			goto abort;
+		}
+
+		scx_task_iter_unlock(&sti);
+
+		/*
+		 * As $p is still on $parent, it can't be transitioned to INIT.
+		 * Let's worry about task state later. Use __scx_init_task().
+		 */
+		ret = __scx_init_task(sch, p, false);
+		if (ret)
+			goto abort;
+
+		rq = task_rq_lock(p, &rf);
+		p->scx.flags |= SCX_TASK_SUB_INIT;
+		task_rq_unlock(rq, p, &rf);
+
+		put_task_struct(p);
+	}
+	scx_task_iter_stop(&sti);
+
+	/*
+	 * All tasks are prepped. Disable/exit tasks for $parent and enable for
+	 * the new @sch.
+	 */
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		/*
+		 * Use clearing of %SCX_TASK_SUB_INIT to detect and skip
+		 * duplicate iterations.
+		 */
+		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
+			continue;
+
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+			/*
+			 * $p must be either READY or ENABLED. If ENABLED,
+			 * __scx_disabled_and_exit_task() first disables and
+			 * makes it READY. However, after exiting $p, it will
+			 * leave $p as READY.
+			 */
+			assert_task_ready_or_enabled(p);
+			__scx_disable_and_exit_task(parent, p);
+
+			/*
+			 * $p is now only initialized for @sch and READY, which
+			 * is what we want. Assign it to @sch and enable.
+			 */
+			rcu_assign_pointer(p->scx.sched, sch);
+			scx_enable_task(sch, p);
+
+			p->scx.flags &= ~SCX_TASK_SUB_INIT;
+		}
+	}
+	scx_task_iter_stop(&sti);
+
+	scx_enabling_sub_sched = NULL;
 
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	scx_bypass(sch, false);
+
 	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
 	ret = 0;
 	goto out_unlock;
 
+abort:
+	put_task_struct(p);
+	scx_task_iter_stop(&sti);
+	scx_enabling_sub_sched = NULL;
+
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		if (p->scx.flags & SCX_TASK_SUB_INIT) {
+			__scx_disable_and_exit_task(sch, p);
+			p->scx.flags &= ~SCX_TASK_SUB_INIT;
+		}
+	}
+	scx_task_iter_stop(&sti);
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
 out_put_cgrp:
 	cgroup_put(cgrp);
 out_unlock:
@@ -6042,6 +6314,7 @@ out_unlock:
 	return;
 
 err_unlock_and_disable:
+	/* we'll soon enter disable path, keep bypass on */
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
