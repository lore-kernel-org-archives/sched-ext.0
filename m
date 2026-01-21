Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E23450903;
	Wed, 21 Jan 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037132; cv=none; b=TSq9dpZoQoFlOWFKnfgSRiRPpRIQE9y60gKk6hUcECtz8ig4utlSp5rZNDdU4A6o+8OQw3QAn8v3dgxDtpx9Hvn/GX5K7jjJxS2Lh9VtY3HnmWobjkVb47pSqr5Bix48rxo8CWOZRhcnrE+mvygUMA9fXJHkMveyVg/sT/SG3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037132; c=relaxed/simple;
	bh=kDjNJNu5BzZTGIjg0ztfMmawow5sAVF9YstvTSNEuoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly2rTPDZbmXSkYM19YQU0d2mMYYeXvTgT+Sdr9yOe+q/nkdUsvJnh0rggpfgwbe0jBLnGHKrBugckysWp+s5cA4V/DZ3U/9EpgHAqLfmp6e9Wy+VzzNpbGddlHHEk3i+ZBx8o/QeU3I+4Nq1WbOThxesWMJ50pAkePlxEQkdDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caFKiyuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caFKiyuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C51C4CEF1;
	Wed, 21 Jan 2026 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037132;
	bh=kDjNJNu5BzZTGIjg0ztfMmawow5sAVF9YstvTSNEuoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caFKiyuD7F9Np6JzdaMs6kmXqbP+0Um1foaLOy40glkIasSSgIaFLpqiIi8sR7Gm3
	 MVwA2QvqVmFuBREukGjB+Ugh46XimDD+rphnp0LWQ0fRslRWSBuO7CYL3qIBqWH8KD
	 CCzLV9drY6vbViqhWgAlyVhGiebQma9HstzS6z/H7xXSvKoDccZRAsDld/Cd5JKU05
	 GBMxvsmPMQP7df4OpvB0iHEt9iBnCZwx+dE+fy/e3hDpM12IkmWf9e+lzVB3LSXd7l
	 c5f31GAEnTDGu7uAFLzSDPAnXnkaKaXJhEl0T5WK2bBSAlOh8orcxV7cX/X8CHW9qE
	 UlA1UL5Z6k2YQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 29/34] sched_ext: Implement cgroup sub-sched enabling and disabling
Date: Wed, 21 Jan 2026 13:11:35 -1000
Message-ID: <20260121231140.832332-30-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |   1 +
 kernel/sched/ext.c        | 278 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 273 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index fef788dc867d..4debd3700af4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -87,6 +87,7 @@ enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 
 	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
 	SCX_TASK_STATE_BITS	= 2,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index be049ab1fbcc..d58b2664f40a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -51,6 +51,15 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/*
+ * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
+ * tasks for the sub-sched being enabled. Use a global variable instead of a
+ * per-task field as all enables are serialized.
+ */
+static struct scx_sched *scx_enabling_sub_sched;
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 /*
  * A monotically increasing sequence number that is incremented every time a
  * scheduler is enabled. This can be used by to check if any custom sched_ext
@@ -3203,6 +3212,17 @@ static void scx_disable_and_exit_task(struct scx_sched *sch,
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
@@ -3238,9 +3258,11 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(scx_root, p, true);
+		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
+
+		ret = scx_init_task(sch, p, true);
 		if (!ret)
-			scx_set_task_sched(p, scx_root);
+			scx_set_task_sched(p, sch);
 		return ret;
 	}
 
@@ -4448,8 +4470,8 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
+		raw_spin_lock(&scx_sched_lock);	/* nests inside rq_lock */
 
-		raw_spin_lock(&scx_sched_lock);
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
 
@@ -4458,6 +4480,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 			else
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+
 		raw_spin_unlock(&scx_sched_lock);
 
 		/*
@@ -4602,23 +4625,139 @@ static void drain_descendants(struct scx_sched *sch)
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
 
 	set_cgroup_sched(sch->cgrp, parent);
 
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
+			scx_fail_parent(parent, p, ret);
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
@@ -5715,11 +5854,28 @@ static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
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
 static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct cgroup *cgrp;
 	struct scx_sched *parent, *sch;
-	s32 ret;
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	s32 i, ret;
 
 	mutex_lock(&scx_enable_mutex);
 
@@ -5791,6 +5947,12 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
 
@@ -5804,16 +5966,119 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
 out_put_cgrp:
 	cgroup_put(cgrp);
 out_unlock:
@@ -5821,6 +6086,7 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	return ret;
 
 err_unlock_and_disable:
+	/* we'll soon enter disable path, keep bypass on */
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
-- 
2.52.0

