Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFD32860C;
	Wed,  4 Feb 2026 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235677; cv=none; b=Hl/MWHgVBPxaDrj9skx9TEjS+HQ+gmrPxFTMdsOeh3va7uq7UE4qtGtefrhauGE2Eek9r9pMIi2xUn+CJ36fQrlEIGqK6tkz19UkLFZn5NuZY17xY/VI4/25/KyJHIpMqGVRgUOEyv/FpfZ96LVXkKLo/D+v1E8QZMJioYziWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235677; c=relaxed/simple;
	bh=slVjfynISWO9uzWBod/Q6pTYX7gqI57GHnrjeUEiVeY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=R3SjfwK3LPUw691/uTINkVWIAs6F2hItw3sxus0W9U7gdru8MqC0Dbu4vFuY6Zsw02eaS6tI5QXd2jsesUs+kguhlnps09l1ED7Ook/jaR8VewyPShSx72ZVtsTvoh/HFQz5BA2KoPzFqbrpZBhgvRksrpYBMMJUGN6ftKaLeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPo+UCcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPo+UCcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B764DC4CEF7;
	Wed,  4 Feb 2026 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770235676;
	bh=slVjfynISWO9uzWBod/Q6pTYX7gqI57GHnrjeUEiVeY=;
	h=Date:From:To:Cc:Subject:From;
	b=MPo+UCcSy+l1cK6qRaJDYT4uj0YAhJcRq/rp4z23NW2ar2YhWEwrrztBqb/9GMOhX
	 tclQRMFWuKOgpf3la3MAEuyrlSkw90ERceeF99MoTJ+VTHXVw93Mc2d5olKWILWRjN
	 sRmyphdSBJiF3e2jFL7N/R4z5lZroCAEmVkuTbU1tF3K1UpMoqEdx9OVasvSc47b4c
	 AUSYLjd/Phu5VqgACOoDNgVbc0U7HWtgjTtBlrqTvojELuYNZ80vyo9Ixg/LZp3B1L
	 Uezpwr13mB28l7VD1CCPm4d7NLbsTDF7wHfVLrcPhv4Q426lFEBFUrXqRGvzGlhkaH
	 LELV9AzjdknoQ==
Date: Wed, 04 Feb 2026 10:07:55 -1000
Message-ID: <fc034891cef55029c16122f4279e4057@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19-fixes] sched_ext: Short-circuit sched_class
 operations on dead tasks
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free()
to finish_task_switch()") moved sched_ext_free() to finish_task_switch() and
renamed it to sched_ext_dead() to fix cgroup exit ordering issues. However,
this created a race window where certain sched_class ops may be invoked on
dead tasks leading to failures - e.g. sched_setscheduler() may try to switch a
task which finished sched_ext_dead() back into SCX triggering invalid SCX task
state transitions.

Add task_dead_and_done() which tests whether a task is TASK_DEAD and has
completed its final context switch, and use it to short-circuit sched_class
operations which may be called on dead tasks.

Fixes: 7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: http://lkml.kernel.org/r/20260202151341.796959-1-arighi@nvidia.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -194,6 +194,7 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "byp
 #include <trace/events/sched_ext.h>

 static void process_ddsp_deferred_locals(struct rq *rq);
+static bool task_dead_and_done(struct task_struct *p);
 static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -2618,6 +2619,9 @@ static void set_cpus_allowed_scx(struct

 	set_cpus_allowed_common(p, ac);

+	if (task_dead_and_done(p))
+		return;
+
 	/*
 	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
 	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
@@ -3033,10 +3037,45 @@ void scx_cancel_fork(struct task_struct
 	percpu_up_read(&scx_fork_rwsem);
 }

+/**
+ * task_dead_and_done - Is a task dead and done running?
+ * @p: target task
+ *
+ * Once sched_ext_dead() removes the dead task from scx_tasks and exits it, the
+ * task no longer exists from SCX's POV. However, certain sched_class ops may be
+ * invoked on these dead tasks leading to failures - e.g. sched_setscheduler()
+ * may try to switch a task which finished sched_ext_dead() back into SCX
+ * triggering invalid SCX task state transitions and worse.
+ *
+ * Once a task has finished the final switch, sched_ext_dead() is the only thing
+ * that needs to happen on the task. Use this test to short-circuit sched_class
+ * operations which may be called on dead tasks.
+ */
+static bool task_dead_and_done(struct task_struct *p)
+{
+	struct rq *rq = task_rq(p);
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * In do_task_dead(), a dying task sets %TASK_DEAD with preemption
+	 * disabled and __schedule(). If @p has %TASK_DEAD set and off CPU, @p
+	 * won't ever run again.
+	 */
+	return unlikely(READ_ONCE(p->__state) == TASK_DEAD) &&
+		!task_on_cpu(rq, p);
+}
+
 void sched_ext_dead(struct task_struct *p)
 {
 	unsigned long flags;

+	/*
+	 * By the time control reaches here, @p has %TASK_DEAD set, switched out
+	 * for the last time and then dropped the rq lock - task_dead_and_done()
+	 * should be returning %true nullifying the straggling sched_class ops.
+	 * Remove from scx_tasks and exit @p.
+	 */
 	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
 	list_del_init(&p->scx.tasks_node);
 	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
@@ -3062,6 +3101,9 @@ static void reweight_task_scx(struct rq

 	lockdep_assert_rq_held(task_rq(p));

+	if (task_dead_and_done(p))
+		return;
+
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
@@ -3076,6 +3118,9 @@ static void switching_to_scx(struct rq *
 {
 	struct scx_sched *sch = scx_root;

+	if (task_dead_and_done(p))
+		return;
+
 	scx_enable_task(p);

 	/*
@@ -3089,6 +3134,9 @@ static void switching_to_scx(struct rq *

 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
+	if (task_dead_and_done(p))
+		return;
+
 	scx_disable_task(p);
 }
