Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAE45D93E
	for <sched-ext@lists.linux.dev>; Thu, 10 Sep 2026 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037755; cv=none; b=r+5eUmLluCuDweWudwwDy02uAJFYz83vOairoKiVUv/vtYytSe7gsjJkbqkwz58ZviJMw29qPjaYc5KgOnVHmi7u7172NxiyzHNDG/9JkwrQcOdhHfqDcHjRv1TUvrjcLbKljHyLPDAZ/ZnXRx6SSkf9BO/Ie+kssZwJ26BQpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037755; c=relaxed/simple;
	bh=EMHmqL6TpIlRzl1xw5Ad5qbWCJVQmAMizkx6Kgjfkwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu6z+bthSw9Wt2qQZ+nyD6en7RuW1FXldBFcn1idbqh7dCn3dYeEAcZMmAqW5Mw1g7/JO47jn3remPq8NettaQBn/Dq4JhMeXmIMoj3q3gQq8k0z/nEGX3Qq75FtNLsX6ONI4WsDMGV5gaVq3XYA35O9H8fapFHStogcyWm7FKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fcY7Kw0A; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fcY7Kw0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=q/
	PPWF6BjDYJqsqVvLWW5Ux17bojJLrDyNJEIg6u1DE=; b=fcY7Kw0ABc8Dl5cW7W
	zV/fIJp6i7+P8KhgltnOhqMYCX/hrkICoQRiRp4k78X2/agoeN+mxBPKDRwBqseX
	9D4P8LVWQaP2TH9ZEkRi8FabZ9XTwzF8Id6cg6HZfb5FiEJFfuj9MKVPLdns5BNK
	suoWmcr0n5j701nxefdHIzIIA=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3eCBKjKJqUJWKQw--.35880S2;
	Thu, 10 Sep 2026 18:54:03 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 4/5] sched/rt: Fix RT watchdog accounting for proxy execution
Date: Thu, 10 Sep 2026 19:54:02 +0900
Message-ID: <20260910105402.2784718-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909110438.GA4120091@noisy.programming.kicks-ass.net>
References: <20260909092901.2989564-1-sh_def@163.com> <20260909092901.2989564-5-sh_def@163.com> <20260909110438.GA4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3eCBKjKJqUJWKQw--.35880S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJry3Xw1DWw1fCw43CrW8Xrb_yoW8Jr1xGo
	ZaqFWDXrn5twnrX3y7JF1ktFZ7ur4qkr98WF1xKws8XFZ7Ww17W3y7Kw1UZa47X3W5ua4f
	Zas7ta98Cr4rJan3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUweOJUUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gt412qijEvZcQAA3p

On Wed, Sep 09, 2026 at 01:04:38PM +0200, Peter Zijlstra wrote:
> It might come as no surprise that this isn't going to fly. I've not
> though about the problem yet, but we're not going to be sprinkling rt
> bits like this in the middle of __schedule().

Thanks for the review.

I removed the RT-specific handling from __schedule(). The updated design
reports generic proxy lifecycle transitions through a sched_class callback;
the RT class consumes those events to preserve RLIMIT_RTTIME interval
semantics.

The relevant ownership rule is:

  RT service applicability follows the effective donor scheduling class;
  watchdog state is charged to rq->curr, whose execution runtime advances.

The callback does not acquire locks or sleep. Scheduler-core callers invoke
it with rq->lock held. The mutex handoff path invokes it without rq->lock but
with preemption disabled; the existing handoff locking keeps the proxy donor
stack stable for that transition. The current RT consumer only resets the
execution task's watchdog interval.

The implementation now handles proxy-chain relationship transitions rather
than only immediate blocked_donor changes. When a relation is replaced, the
old effective donor is reported with STOP before the new relation is
installed; an upstream change propagates STOP/START to every downstream
owner in a nested chain. Teardown also resolves the effective root donor
before sending STOP, including the mutex handoff path.

This lifecycle form avoids the per-task generation state I initially tried,
which increased task_struct by one 64-byte allocation unit on both x86-64
and i386. The task-clock baseline used by patch 5 is likewise stored in the
runqueue rather than every sched_entity; the old per-entity field is removed.

The focused checks cover RT-policy PI boost to DL (timeout preserved), RT
donor to FAIR execution (watchdog charged to the execution task), blocking,
nested chains, donor replacement, DL donor to RT/RR execution (no watchdog),
and proxy-disabled builds. The current tree also passes the proxy-on,
proxy-off, POSIX_TIMERS-off, SCHED_CORE-on, x86_64 full-image, i386 object,
module, and regenerated checkpatch checks.

Retained root donors that change scheduling class are also handled around
sched_change_begin()/sched_change_end(): the current proxy chain receives
STOP before the class change and START after it. This keeps an RT-to-FAIR-to-RT
transition from carrying a stale execution-owner interval. The dedicated
in-kernel POC builds successfully; runtime execution is reserved for the new
QEMU image.

The class-transition handling walks the current proxy chain, so a retained
nested chain is stopped and restarted for every downstream execution owner,
even when only the root donor changes scheduling class. Ordinary preemption
and resumption leave the chain intact and do not generate another transition.

Could you take a look at whether this lifecycle-based version is a reasonable
direction? If so, I will complete the pending runtime check and carry it into
v5 before posting the updated series.

For reference, the complete current RT watchdog patch follows.

Thanks,
Hui

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..c36b772ce19f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,11 +1691,13 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
+void sched_proxy_stop(struct task_struct *exec);
 static inline bool sched_proxy_exec(void)
 {
 	return static_branch_likely(&__sched_proxy_exec);
 }
 #else
+static inline void sched_proxy_stop(struct task_struct *exec) {}
 static inline bool sched_proxy_exec(void)
 {
 	return false;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 942a939cee95..c1be99391076 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1044,6 +1044,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 			next_lock = __get_task_blocked_on(donor);
 			if (next_lock == lock) {
 				next = get_task_struct(donor);
+				sched_proxy_stop(current);
 				__clear_task_blocked_on(next, lock);
 				current->blocked_donor = NULL;
 			}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 05e599665fdd..0e6ef9418604 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4647,6 +4647,69 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 	init_sched_mm(p);
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+/*
+ * Return the effective scheduling donor for a proxy execution context.
+ * blocked_donor links are stable while preemption is disabled or the rq lock
+ * is held, which are the contexts in which this helper is used.
+ */
+static inline struct task_struct *proxy_root_donor(struct task_struct *exec)
+{
+	struct task_struct *donor = exec;
+
+	while (READ_ONCE(donor->blocked_donor))
+		donor = READ_ONCE(donor->blocked_donor);
+
+	return donor;
+}
+
+/* Notify the classes owning the proxy scheduling and execution contexts. */
+static inline void proxy_event(struct task_struct *donor,
+			       struct task_struct *exec,
+			       enum sched_proxy_event event)
+{
+	const struct sched_class *donor_class = donor->sched_class;
+	const struct sched_class *exec_class = exec->sched_class;
+
+	if (donor_class->proxy_event)
+		donor_class->proxy_event(donor, exec, event);
+	if (exec_class != donor_class && exec_class->proxy_event)
+		exec_class->proxy_event(donor, exec, event);
+}
+
+/* Notify every execution context in the current proxy chain. */
+static inline void proxy_event_chain(struct rq *rq,
+				     struct task_struct *donor,
+				     enum sched_proxy_event event)
+{
+	struct task_struct *exec = rq->curr;
+
+	if (exec == donor)
+		return;
+
+	for (; exec && exec != donor;
+	     exec = READ_ONCE(exec->blocked_donor))
+		proxy_event(donor, exec, event);
+}
+
+void sched_proxy_stop(struct task_struct *exec)
+{
+	proxy_event(proxy_root_donor(exec), exec, SCHED_PROXY_STOP);
+}
+#else
+static inline struct task_struct *proxy_root_donor(struct task_struct *exec)
+{
+	return exec;
+}
+
+static inline void proxy_event(struct task_struct *donor,
+			       struct task_struct *exec,
+			       enum sched_proxy_event event) {}
+static inline void proxy_event_chain(struct rq *rq,
+				     struct task_struct *donor,
+				     enum sched_proxy_event event) {}
+#endif
+
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -6768,6 +6831,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (sched_proxy_exec())
+		proxy_event(rq->donor, p, SCHED_PROXY_BLOCK);
+
 	p->is_blocked = 1;
 
 	/*
@@ -6930,6 +6996,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *owner = NULL;
+	struct task_struct *old_donor = NULL;
+	bool context_changed = false;
 	bool curr_in_chain = false;
 	int this_cpu = cpu_of(rq);
 	struct task_struct *p;
@@ -7056,7 +7124,25 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
-		owner->blocked_donor = p;
+		/*
+		 * The relation survives ordinary preemption and resumption. Once
+		 * an upstream relation changes, however, all downstream owners
+		 * inherit a new proxy scheduling context as well.
+		 */
+		if (owner->blocked_donor != p) {
+			if (!context_changed)
+				old_donor = proxy_root_donor(owner);
+
+			if (old_donor != owner)
+				proxy_event(old_donor, owner, SCHED_PROXY_STOP);
+
+			owner->blocked_donor = p;
+			context_changed = true;
+		} else if (context_changed && old_donor != owner) {
+			proxy_event(old_donor, owner, SCHED_PROXY_STOP);
+		}
+		if (context_changed)
+			proxy_event(donor, owner, SCHED_PROXY_START);
 	}
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
@@ -7210,6 +7296,8 @@ static void __sched notrace __schedule(int sched_mode)
 		struct task_struct *prev_donor = rq->donor;
 
 		rq_set_donor(rq, next);
+		if (!next->is_blocked && next->blocked_donor)
+			proxy_event(proxy_root_donor(next), next, SCHED_PROXY_STOP);
 		next->blocked_donor = NULL;
 		if (unlikely(next->is_blocked)) {
 			next = find_proxy_task(rq, next, &rf);
@@ -11277,6 +11365,10 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 
 	lockdep_assert_rq_held(rq);
 
+	/* End proxy service before changing the donor's scheduling class. */
+	if ((flags & DEQUEUE_CLASS) && task_current_donor(rq, p))
+		proxy_event_chain(rq, p, SCHED_PROXY_STOP);
+
 	if (!(flags & DEQUEUE_NOCLOCK)) {
 		update_rq_clock(rq);
 		flags |= DEQUEUE_NOCLOCK;
@@ -11335,6 +11427,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		if (p->sched_class->switched_to)
 			p->sched_class->switched_to(rq, p);
 
+		/* Restart proxy service with the donor's new scheduling class. */
+		if (ctx->running)
+			proxy_event_chain(rq, p, SCHED_PROXY_START);
+
 		if (ctx->running) {
 			/*
 			 * If this was a class promotion; let the old class
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dd058a6ca06b..9e16d06baf48 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2530,6 +2530,37 @@ static void watchdog(struct rq *rq, struct task_struct *p)
 static inline void watchdog(struct rq *rq, struct task_struct *p) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static void proxy_event_rt(struct task_struct *donor,
+			   struct task_struct *exec,
+			   enum sched_proxy_event event)
+{
+	/* A new relation or a blocking edge terminates the prior interval. */
+	switch (event) {
+	case SCHED_PROXY_START:
+		/*
+		 * A proxy START begins an RT watchdog interval only when
+		 * the scheduling context itself is RT. This callback may also
+		 * be reached through an RT execution context while another
+		 * class supplies the donor.
+		 */
+		if (donor->sched_class == &rt_sched_class &&
+		    !task_has_rt_policy(exec))
+			exec->rt.timeout = 0;
+		break;
+	case SCHED_PROXY_BLOCK:
+		exec->rt.timeout = 0;
+		break;
+	case SCHED_PROXY_STOP:
+		/* Stop the interval when RT proxy service ends for this task. */
+		if (donor->sched_class == &rt_sched_class &&
+		    !task_has_rt_policy(exec))
+			exec->rt.timeout = 0;
+		break;
+	}
+}
+#endif
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -2550,7 +2581,7 @@ static void task_tick_rt(struct rq *rq, int queued)
 	update_curr_rt(rq);
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
-	watchdog(rq, p);
+	watchdog(rq, rq->curr);
 
 	/*
 	 * RR tasks need a special form of time-slice management.
@@ -2625,6 +2656,9 @@ DEFINE_SCHED_CLASS(rt) = {
 	.find_lock_rq		= find_lock_lowest_rq,
 
 	.task_tick		= task_tick_rt,
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	.proxy_event		= proxy_event_rt,
+#endif
 
 	.get_rr_interval	= get_rr_interval_rt,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a8deddc725b..bb6f87552220 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2621,6 +2621,12 @@ struct affinity_context {
 
 extern s64 update_curr_common(struct rq *rq);
 
+enum sched_proxy_event {
+	SCHED_PROXY_START,
+	SCHED_PROXY_BLOCK,
+	SCHED_PROXY_STOP,
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2719,6 +2725,16 @@ struct sched_class {
 	 * sched_tick_remote: rq->lock
 	 */
 	void (*task_tick)(struct rq *rq, int queued);
+	/*
+	 * Proxy execution transitions. Callbacks must not sleep. Scheduler-core
+	 * events run with the rq lock held; mutex handoff may invoke the callback
+	 * without the rq lock, with preemption disabled and blocked relation locks
+	 * held. Donor and execution task lifetime is protected by callers.
+	 */
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	void (*proxy_event)(struct task_struct *donor, struct task_struct *exec,
+			    enum sched_proxy_event event);
+#endif
 	/*
 	 * sched_cgroup_fork: p->pi_lock
 	 */

