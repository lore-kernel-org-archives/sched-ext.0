Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F495510
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325706; cv=none; b=Dt0D7a8TypL2lQvqTtLiNGrcCauBvphZW/cpI1vO0qz2D7ndO4YahPDsf2m+GcqiWYD9/MCnPn82BQwSN4NluLpLDR58FsMkgfTW/Lgy+CIbcoH9gr2+AtdAoKq1dT3yoc0mfyZFBU/9Ei8CLKcS5L4YKvI67UYBlWFnwlCXuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325706; c=relaxed/simple;
	bh=wJCCUQk9f89HKHqKmTzDJJwUP6zMcn0ITOvWPuDcS98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C/5ufGql3DdKoh4UHYD6FASWpZsfTcrziEWNEjoHiguex6Qlc3wBmaW6pKnhfn8r0ggoMHwiJwt8KGlqF8CCiznLmJ+x3PssdgqJdQrm8EmgGh1T3i/5ZllOoaese3DLATuz29yfJPQt0G0cpJQWnSWh8tvKZa4JP3NLGec5lPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oyk3oIsF; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oyk3oIsF"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so138529866b.1
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325702; x=1792930502; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evlvv8rids+PsRVLTzw3XguzgDYBuaJhlitYdAR/qBQ=;
        b=Oyk3oIsFA7N4zViSnYSQ/SIucVXNajkmgip4s+6Qo2SGY2T3GFRdAuhL7XvPz3tajH
         7xwH4w1PYhVLEJ4oI8u3TNJTF6uohmDJqT8drVXziKonic5ZPujUl79AzpWCr9H1skV0
         vE687zsDDpca1/g2u4ONIFNaMKirEuSZWFrmpeHJTyWxyFZix64QxEgA2hz6PCQs1+GA
         DohpANUGbm+PfFYwW3KRMxSuzXcsoQnx2qDlqouaPgWpXugbdrBhQe+2TMNWiiBLGN+i
         bL6S1nAI6dXnslHAEtopCLX5XQcasfRcRYV/BA3pX/YuyCPa/AKk7VQai1ek36Z//o8c
         gvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325702; x=1792930502;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evlvv8rids+PsRVLTzw3XguzgDYBuaJhlitYdAR/qBQ=;
        b=PKPASC0CG9G7EJlSlqWOML9xW3iLS8u/IpDm/sHZHf3ommMrFJonj2JUrYCA3oWV9V
         YEg+KS9hLr35TQS95noi2rEnkneFd0qhQ9nzfEvpgL4tdLz0+5XBifwkyAJii8SKO3K5
         7nfIJwU+NJWiziezPHUQOmAhPtrLJ+0E/0Fnt8d3vRNcLRD201IB6D+Ip1KdZDj+zCj2
         Jkpwayn1p6mL6YVXr0sjiFIcv4gZNUxOV7xoHVeToriFzyqq52E/rchtoip5Fz5Fef2L
         VvEqm586qRK4CQwtU0Jx29ZPcdae/Tro1Rtk8nci3IaTQnuIeS+gIf7ILMZqav5Dj8am
         oMfw==
X-Forwarded-Encrypted: i=1; AKwUvByd0kn/843PTwQ7r9Nz0W/K6C0u5HmXkEANg9ZG+4qCkDcdY70cF1oJBNvDfZFBGrHBoAhB39hE0c8=@lists.linux.dev
X-Gm-Message-State: AFq9FYLD2mIHa9t8dWo973Q8kLd0hyk/QoTdUEuFhQTCc1KhXJ6Ec0fe
	+si+0pj2DTg8lJCAjuRGjDzorjEJDKm2aiOZOCCgssNJKIPgEoo6POFa2ARzRGAFnvh6C8woYol
	vgqTLC3Wk/XN8Hw==
X-Received: from edxa1.prod.google.com ([2002:a05:6402:13c1:b0:6b3:874e:205d])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2710:b0:6b1:ced2:dfcd with SMTP id 4fb4d7f45d1cf-6b3a8168a9dmr3022806a12.23.1792325701955;
 Sun, 18 Oct 2026 05:15:01 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:46 +0000
In-Reply-To: <cover.1792248922.git.jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <d77edd30310da694faa184001938a23da672c568.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH 2/5] sched_ext: Emit ops.cpu_acquire/release() on actual
 CPU transitions
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ops.cpu_acquire() and ops.cpu_release() are meant to tell the BPF
scheduler when a CPU becomes available to it and when it's taken away.
In their current form they miss events and can get stuck in the wrong
state:

- ops.cpu_release() is only emitted from put_prev_task_scx(), so a CPU
  going from idle straight to an RT, DL or stop task is never released.
  This also covers the case where ttwu() direct-dispatched a task to an
  idle CPU's local DSQ but a higher class task wins the next pick:
  nothing on the SCX side runs at all.

- ops.cpu_acquire() is emitted speculatively from dispatch_one(), before
  the pick is final. If dispatch drops the rq lock and a higher class
  task shows up, or the pick is retried, the CPU stays "acquired" while
  an RT task runs. Under core scheduling, dispatch_one() also runs for
  the siblings, so a CPU can be acquired even though its final pick is
  an RT task.

- rq->scx.cpu_released is never reset. It carries over from one
  scheduler to the next, and CPU hotplug isn't handled.

Whether a CPU is available to the BPF scheduler only depends on the
class of its scheduling context, rq->donor: the CPU is available while
an SCX task or the idle task runs on it and released while a stop, DL,
RT or fair (partial mode) task does. Every change of availability has
an SCX task or the idle task on one side, so the ext and idle classes'
own put_prev_task() and set_next_task() see all of them. No hook in the
core or in the other classes is needed.

Replace switch_class() and the acquire in dispatch_one() with a small,
idempotent state machine, __scx_update_cpu_avail(), which looks at the
task about to become rq->donor and only invokes a callback on an actual
edge. Call it from:

- set_next_task_scx(), before ops.running(): acquire.
- put_prev_task_scx(), after the outgoing task went back to the local
  DSQ, so that ops.cpu_release() can still re-enqueue it: release if the
  next task is from a higher class.
- put_prev_task_idle(), after ops.update_idle(cpu, false): release if
  the next task is from a higher class.
- set_next_task_idle(), before ops.update_idle(cpu, true): acquire.

Core-sched forced idle counts as available. Whether the BPF scheduler
can place a task on a forced idle CPU depends on that task's cookie,
which is for the BPF scheduler to decide. Idle-to-idle re-picks don't
change availability and pick_task_idle() is left alone.

Every CPU starts released. When a root scheduler implementing either
callback is enabled, reset all CPUs to released, turn on the static key
gating the hooks and acquire every available online CPU. The key is
turned off under scx_enable_mutex when the scheduler is disabled, before
tasks are switched out of SCX, so the BPF scheduler doesn't see a storm
of releases. In-flight callbacks run with an rq lock held and IRQs
disabled and are flushed by the synchronize_rcu() before ops.exit().
Schedulers which don't implement the callbacks only pay for a static
branch.

For hotplug, the callbacks are only invoked between ops.cpu_online() and
ops.cpu_offline(): ops.cpu_offline() implies a release and the CPU is
acquired right after ops.cpu_online() if it's available. This can't be
keyed off SCX_RQ_ONLINE as rq_online_scx() runs before ops.cpu_online()
when a CPU comes up: cpuset_cpu_active() rebuilds the sched domains
before sched_cpu_activate() calls scx_rq_activate(). Add
SCX_RQ_OPS_ONLINE, which scx_rq_activate() sets right after
ops.cpu_online() and scx_rq_deactivate() clears right before
ops.cpu_offline().

Add SCX_CPU_PREEMPT_FAIR for releases to a fair task in partial mode,
which used to be reported as SCX_CPU_PREEMPT_UNKNOWN. It's appended to
keep the existing values unchanged.

This changes when ops.cpu_acquire() is called: it's now called when the
CPU actually switches to an SCX task or idle rather than before
ops.dispatch(). ops.dispatch() may thus be called while the CPU is still
released.

A running SCX task changing class without a context switch is not
handled yet and is addressed by the next patch.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      | 220 +++++++++++++++++++++++++-----------
 kernel/sched/ext/ext.h      |  19 ++++
 kernel/sched/ext/internal.h |   2 +
 kernel/sched/idle.c         |   4 +
 kernel/sched/sched.h        |   6 +
 5 files changed, 185 insertions(+), 66 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f64438290218..4d02d2d6e6d0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -80,6 +80,9 @@ static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
 static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
 
+/* the root scheduler implements ops.cpu_acquire() or ops.cpu_release() */
+DEFINE_STATIC_KEY_FALSE(__scx_cpu_avail_enabled);
+
 /*
  * Gates cgroup ops delivery. Set at the end of the cgroup init phase of root
  * enable and cleared before root disable starts tearing down tasks, both under
@@ -2964,19 +2967,6 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 
 	scx_process_sync_ecaps(rq, prev);
 
-	if ((root_sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
-	    unlikely(rq->scx.cpu_released)) {
-		/*
-		 * If the previous sched_class for the current CPU was not SCX,
-		 * notify the BPF scheduler that it again has control of the
-		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in switch_class().
-		 */
-		if (root_sch->ops.cpu_acquire)
-			SCX_CALL_OP(root_sch, cpu_acquire, rq, cpu, NULL);
-		rq->scx.cpu_released = false;
-	}
-
 	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
@@ -3044,10 +3034,101 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
 }
 
+/*
+ * A CPU is available to the BPF scheduler while its scheduling context is an
+ * SCX task or the idle task. Core-sched forced idle counts as available:
+ * whether a task can be placed on such a CPU depends on that task's cookie,
+ * which is the BPF scheduler's call.
+ */
+static bool scx_cpu_avail(struct rq *rq, struct task_struct *next)
+{
+	return next->sched_class == &ext_sched_class || next == rq->idle;
+}
+
+static enum scx_cpu_preempt_reason cpu_release_reason(struct task_struct *next)
+{
+	if (next->sched_class == &stop_sched_class)
+		return SCX_CPU_PREEMPT_STOP;
+	if (next->sched_class == &dl_sched_class)
+		return SCX_CPU_PREEMPT_DL;
+	if (next->sched_class == &rt_sched_class)
+		return SCX_CPU_PREEMPT_RT;
+	if (next->sched_class == &fair_sched_class)
+		return SCX_CPU_PREEMPT_FAIR;
+	return SCX_CPU_PREEMPT_UNKNOWN;
+}
+
+/*
+ * ops.cpu_acquire/release() are edge-triggered on @rq->scx.cpu_released and
+ * only fire between ops.cpu_online() and ops.cpu_offline(), see
+ * scx_rq_activate() and scx_rq_deactivate().
+ */
+static void scx_cpu_release(struct rq *rq, enum scx_cpu_preempt_reason reason,
+			    struct task_struct *task)
+{
+	struct scx_sched *sch = scx_root_protected_live();
+
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.cpu_released || !(rq->scx.flags & SCX_RQ_OPS_ONLINE))
+		return;
+
+	/* update before calling out so that a nested re-evaluation is a no-op */
+	rq->scx.cpu_released = true;
+
+	if (sch->ops.cpu_release) {
+		struct scx_cpu_release_args args = {
+			.reason = reason,
+			.task = task,
+		};
+
+		SCX_CALL_OP(sch, cpu_release, rq, cpu_of(rq), &args);
+	}
+}
+
+static void scx_cpu_acquire(struct rq *rq)
+{
+	struct scx_sched *sch = scx_root_protected_live();
+
+	lockdep_assert_rq_held(rq);
+
+	if (!rq->scx.cpu_released || !(rq->scx.flags & SCX_RQ_OPS_ONLINE))
+		return;
+
+	rq->scx.cpu_released = false;
+
+	if (sch->ops.cpu_acquire)
+		SCX_CALL_OP(sch, cpu_acquire, rq, cpu_of(rq), NULL);
+}
+
+/**
+ * __scx_update_cpu_avail - Re-evaluate whether a CPU is available
+ * @rq: rq of the CPU, locked
+ * @next: task that is (about to become) @rq->donor
+ *
+ * Availability only depends on the class of @rq->donor and every change has
+ * an SCX task or the idle task on one side. Callers re-evaluate whenever that
+ * may have happened and a callback is only invoked on an actual transition.
+ */
+void __scx_update_cpu_avail(struct rq *rq, struct task_struct *next)
+{
+	if (scx_cpu_avail(rq, next))
+		scx_cpu_acquire(rq);
+	else
+		scx_cpu_release(rq, cpu_release_reason(next), next);
+}
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	/*
+	 * Acquire before ops.dequeue(SCX_DEQ_CORE_SCHED_EXEC) and
+	 * ops.running(). This also covers a running task switching to SCX
+	 * through sched_change_end().
+	 */
+	scx_update_cpu_avail(rq, p);
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3105,57 +3186,6 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 }
 
-static enum scx_cpu_preempt_reason
-preempt_reason_from_class(const struct sched_class *class)
-{
-	if (class == &stop_sched_class)
-		return SCX_CPU_PREEMPT_STOP;
-	if (class == &dl_sched_class)
-		return SCX_CPU_PREEMPT_DL;
-	if (class == &rt_sched_class)
-		return SCX_CPU_PREEMPT_RT;
-	return SCX_CPU_PREEMPT_UNKNOWN;
-}
-
-static void switch_class(struct rq *rq, struct task_struct *next)
-{
-	struct scx_sched *sch = scx_root_protected_live();
-	const struct sched_class *next_class = next->sched_class;
-
-	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
-		return;
-
-	/*
-	 * The callback is conceptually meant to convey that the CPU is no
-	 * longer under the control of SCX. Therefore, don't invoke the callback
-	 * if the next class is below SCX (in which case the BPF scheduler has
-	 * actively decided not to schedule any tasks on the CPU).
-	 */
-	if (sched_class_above(&ext_sched_class, next_class))
-		return;
-
-	/*
-	 * At this point we know that SCX was preempted by a higher priority
-	 * sched_class, so invoke the ->cpu_release() callback if we have not
-	 * done so already. We only send the callback once between SCX being
-	 * preempted, and it regaining control of the CPU.
-	 *
-	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
-	 *  next time that dispatch_one() is invoked.
-	 */
-	if (!rq->scx.cpu_released) {
-		if (sch->ops.cpu_release) {
-			struct scx_cpu_release_args args = {
-				.reason = preempt_reason_from_class(next_class),
-				.task = next,
-			};
-
-			SCX_CALL_OP(sch, cpu_release, rq, cpu_of(rq), &args);
-		}
-		rq->scx.cpu_released = true;
-	}
-}
-
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
@@ -3254,8 +3284,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	}
 
 switch_class:
+	/*
+	 * Release the CPU if @next is from a higher class. This is done after
+	 * @p went back to the local DSQ so that ops.cpu_release() can
+	 * re-enqueue it. SCX -> idle (including core-sched forced idle) is
+	 * not a transition as both are available.
+	 */
 	if (next && next->sched_class != &ext_sched_class)
-		switch_class(rq, next);
+		scx_update_cpu_avail(rq, next);
 }
 
 static void kick_sync_wait_bal_cb(struct rq *rq)
@@ -3749,10 +3785,29 @@ static void handle_hotplug(struct rq *rq, bool online)
 void scx_rq_activate(struct rq *rq)
 {
 	handle_hotplug(rq, true);
+
+	/*
+	 * The CPU comes up released. Now that ops.cpu_online() has been
+	 * called, let ops.cpu_acquire/release() through and acquire the CPU if
+	 * it's available. This can't be done from rq_online_scx() which may
+	 * run before ops.cpu_online() when the sched domains are rebuilt.
+	 */
+	guard(rq_lock_irqsave)(rq);
+	rq->scx.flags |= SCX_RQ_OPS_ONLINE;
+	scx_update_cpu_avail(rq, rq->donor);
 }
 
 void scx_rq_deactivate(struct rq *rq)
 {
+	/*
+	 * ops.cpu_offline() implies release. No ops.cpu_acquire/release()
+	 * until ops.cpu_online().
+	 */
+	scoped_guard(rq_lock_irqsave, rq) {
+		rq->scx.flags &= ~SCX_RQ_OPS_ONLINE;
+		rq->scx.cpu_released = true;
+	}
+
 	handle_hotplug(rq, false);
 }
 
@@ -6579,6 +6634,15 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	mutex_lock(&scx_enable_mutex);
 
+	/*
+	 * Stop ops.cpu_acquire/release() before switching tasks out so that
+	 * the BPF scheduler doesn't see a storm of releases. This must be under
+	 * scx_enable_mutex so that it's ordered after the enable path turning
+	 * the key on. In-flight callbacks hold an rq lock with IRQs disabled
+	 * and are flushed by synchronize_rcu() before ops.exit().
+	 */
+	static_branch_disable(&__scx_cpu_avail_enabled);
+
 	was_switched_all = scx_switched_all();
 
 	static_branch_disable(&__scx_switched_all);
@@ -7991,6 +8055,30 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	/*
+	 * Every CPU starts released. Once the hooks are live, acquire the
+	 * available CPUs. CPUs which don't context switch (e.g. idle ones)
+	 * wouldn't get there otherwise. scx_root_disable() turns the key off
+	 * under scx_enable_mutex, so it can't race this.
+	 */
+	if (sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) {
+		for_each_possible_cpu(cpu) {
+			struct rq *rq = cpu_rq(cpu);
+
+			guard(rq_lock_irqsave)(rq);
+			rq->scx.cpu_released = true;
+		}
+
+		static_branch_enable(&__scx_cpu_avail_enabled);
+
+		for_each_possible_cpu(cpu) {
+			struct rq *rq = cpu_rq(cpu);
+
+			guard(rq_lock_irqsave)(rq);
+			__scx_update_cpu_avail(rq, rq->donor);
+		}
+	}
+
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
 
@@ -8871,7 +8959,7 @@ void __init init_sched_ext_class(void)
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
-			cpu_rq(cpu)->scx.flags |= SCX_RQ_ONLINE;
+			cpu_rq(cpu)->scx.flags |= SCX_RQ_ONLINE | SCX_RQ_OPS_ONLINE;
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08..c03fd8bc0d66 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -70,6 +70,25 @@ static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
 #endif
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+DECLARE_STATIC_KEY_FALSE(__scx_cpu_avail_enabled);
+void __scx_update_cpu_avail(struct rq *rq, struct task_struct *next);
+
+/*
+ * @next is (about to become) @rq->donor. Notify the root BPF scheduler if this
+ * changes whether @rq's CPU is available to it. Only enabled if the root
+ * scheduler implements ops.cpu_acquire() or ops.cpu_release(). A NULL @next,
+ * from put_prev_task() without a next task, is ignored.
+ */
+static inline void scx_update_cpu_avail(struct rq *rq, struct task_struct *next)
+{
+	if (static_branch_unlikely(&__scx_cpu_avail_enabled) && next)
+		__scx_update_cpu_avail(rq, next);
+}
+#else
+static inline void scx_update_cpu_avail(struct rq *rq, struct task_struct *next) {}
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 #ifdef CONFIG_EXT_GROUP_SCHED
 void scx_tg_init(struct task_group *tg);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 352547aedbb7..2d8c789c1e76 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -298,6 +298,8 @@ enum scx_cpu_preempt_reason {
 	SCX_CPU_PREEMPT_STOP,
 	/* unknown reason for SCX being preempted */
 	SCX_CPU_PREEMPT_UNKNOWN,
+	/* next task is being scheduled by &fair_sched_class (partial mode) */
+	SCX_CPU_PREEMPT_FAIR,
 };
 
 /*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index eb73b65ce6c4..89313f697124 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -484,12 +484,16 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
 {
 	update_curr_idle(rq);
 	scx_update_idle(rq, false, true);
+	/* idle -> stop/DL/RT/fair releases the CPU from the BPF scheduler */
+	scx_update_cpu_avail(rq, next);
 	update_rq_avg_idle(rq);
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
+	/* stop/DL/RT/fair -> idle acquires the CPU for the BPF scheduler */
+	scx_update_cpu_avail(rq, next);
 	scx_update_idle(rq, true, true);
 	schedstat_inc(rq->sched_goidle);
 	next->se.exec_start = rq_clock_task(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c25fbe84fb5..7a93ee3d442d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -787,6 +787,12 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
+	/*
+	 * Set between ops.cpu_online() and ops.cpu_offline(). Unlike
+	 * %SCX_RQ_ONLINE, this is never set before ops.cpu_online() has been
+	 * called. Gates ops.cpu_acquire/release().
+	 */
+	SCX_RQ_OPS_ONLINE	= 1 << 2,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
-- 
2.56.0.176.g3575e65682-goog

