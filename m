Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C03B05AB
	for <sched-ext@lists.linux.dev>; Sat, 12 Sep 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236359; cv=none; b=DHGsAMpZb0ydwEIKcKmiVwy1FRIADUMkZXE9SobYpklWKkAkIlpAzrA+zIozseVeA6j8GkYla3bVBvKyk3Y0K75Kw2NwJ944EGRTHX+bX3TGgzuViv5c2/gVZDebK8tHABMtFPTuAXJG2fPACGCXQ3DfoRhirpsxf+70t50DUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236359; c=relaxed/simple;
	bh=5LyXheGwkVod9oSkzW580o/jJRJxoRxXas19ZHmA5Rs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=SqBDiJszXfQtU1YwA9Z6WFsmCiST/2Pf6gEa9hMDatsywoOCqiHpBQUdL8181dMCRioJUBJFsXpNxR9lBwa1CtLtt5VF3pywG181s5PgaG+LhfIa34a6ui2POkUYJbr/zKO2EpXyw+qjjLf571fzT5lJ97eaDWSQJqH0TFtmm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lcVsvUQL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lcVsvUQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date:MIME-Version:
	Content-Type; bh=KRPZfJXNJS/wVDiiOGPcYZdtHA8B4I9Kxglp+kJDh/Y=;
	b=lcVsvUQL0KtVxepcVVzjFszclM3AiVsdBq56sJeLW2xi8hVSSEitz1u8PEB9Ps
	x9iPa+92WnSw7xL/u/lnVhllGyke98mNrJO+oO8G1FhM+GEXaxGowmLHcTiZonly
	qOj/aCS1wedRiKvvSauGw4Omarrjp7aYA52KU2Y3oX7/Y=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXfrTvk6VqXk4IRQ--.23765S2;
	Sun, 13 Sep 2026 02:03:29 +0800 (CST)
Message-ID: <c8b457d91942d655cea763b6094c9df4.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Zhidao Su <soolaugust@gmail.com>, Andrea Righi <arighi@nvidia.com>
Cc: mingo@redhat.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
	kprateek.nayak@amd.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, connoro@google.com, jstultz@google.com,
	tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 4/5] sched/rt: Fix RT watchdog accounting for proxy execution
Date: Sun, 13 Sep 2026 02:30:00 +0900
In-Reply-To: <20260909110438.GA4120091@noisy.programming.kicks-ass.net>
References: <20260909092901.2989564-1-sh_def@163.com>
 <20260909092901.2989564-5-sh_def@163.com>
 <20260909110438.GA4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:QCgvCgCXfrTvk6VqXk4IRQ--.23765S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFW7uw4kurWkuFWxWr43Awb_yoW8Gr13to
	Zavayqvw1ktwnrZ3y7AF18tF97ur4DGryDXr4Sgwn5WayxWw1UW3y7Kwn8Za4xX3WUCayx
	Aa48tan8Zr45Ja1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw5l1DUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hIlhGqlk-L9lAAA3e

Hi Peter,

> It might come as no surprise that this isn't going to fly. I've not
> though about the problem yet, but we're not going to be sprinkling rt
> bits like this in the middle of __schedule().

I took another look at this after your comment above, as well as at the
lifecycle-based WIP I posted afterwards.

I agree that putting RT-specific reset handling directly in __schedule() is
the wrong abstraction. The current WIP instead exposes generic proxy
relationship lifecycle events from the scheduler core and lets the RT class
consume those events.

The original attribution issue is relatively small: the RT scheduling
context belongs to rq->donor, while the watchdog state needs to follow the
execution context in rq->curr.

The harder part is defining the watchdog interval reset boundaries under
proxy execution. The current version therefore has generic START/STOP/BLOCK
notifications and propagates proxy-context changes through
find_proxy_task().

Compared with the previous WIP, this version no longer invokes the
lifecycle callback directly from the mutex handoff path. The handoff only
changes the blocked_donor relation, and the resulting STOP is reported when
the execution task next enters __schedule(), with the rq lock held. It also
preserves the previous effective root when an intermediate retained donor
is promoted, so that root changes can be propagated to downstream execution
owners.

While working through this, I noticed that this is also the same area
touched by Zhidao Su's pending proxy-walk cycle handling:
https://lore.kernel.org/r/20260722120346.93000-1-soolaugust@gmail.com/

In particular, the new retained blocked_donor walks in this WIP assume an
acyclic chain. Zhidao's work adds cycle detection in find_proxy_task(),
while the new walks here rely on the retained blocked_donor chain being
acyclic. The lifecycle handling therefore needs to be reconciled with that
work before I consider the RT patch ready.

There is a separate integration issue around patch 1 of this series: its
task_tick() donor/curr ownership changes overlap with Andrea's pending
sched_ext/proxy-execution work:
https://lore.kernel.org/r/20260831134338.1531664-1-arighi@nvidia.com/

Rather than coupling that integration work with the independent
RT/find_proxy_task() issue, I am inclined to make the next revision a
four-patch series containing the current patches 1, 2, 3 and the core-slice
patch (patch 5 in v4, renumbered as 4/4), while continuing the RT watchdog
work separately.
The task_tick()/sched_ext overlap can then be handled on its own without
being tied to the RT lifecycle changes.

In the meantime, I would appreciate any thoughts on the current RT
lifecycle approach. I have included the current WIP diff below. It is not
intended for merging as-is; in particular, I still need to reconcile the
find_proxy_task() changes with the pending proxy-walk cycle handling.

The WIP diff below is based on patches 1-3 of this series, so task_tick()
already uses the updated callback interface.

The main idea is:

* watchdog accounting follows rq->curr while RT scheduling remains
  donor-owned;
* blocking terminates the current watchdog interval;
* START/STOP mark changes to the effective proxy scheduling context;
* native RT-policy tasks keep their existing timeout semantics;
* non-RT execution owners reset their timeout when entering or leaving an
  RT proxy context;
* root changes in a retained proxy chain are propagated to downstream
  execution owners.

If this direction looks reasonable, I will keep the RT work separate,
reconcile it with the cycle handling, and let the remaining four-patch
series continue without being tied to the RT lifecycle changes.

Thanks,
Hui

---

 kernel/sched/core.c  | 138 ++++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/rt.c    |  35 ++++++++++++-
 kernel/sched/sched.h |  15 ++++++
 3 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 05e599665fdd..57d24cbd8eea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4647,6 +4647,93 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 	init_sched_mm(p);
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+/*
+ * Follow the blocked_donor stack built by the current donor-pick cycle.
+ * The stack is stable while rq->lock is held.
+ */
+static inline struct task_struct *
+proxy_root_donor(struct rq *rq, struct task_struct *exec)
+{
+	struct task_struct *donor = exec;
+
+	lockdep_assert_rq_held(rq);
+
+	while (donor->blocked_donor)
+		donor = donor->blocked_donor;
+
+	return donor;
+}
+
+/* Notify the classes owning the proxy scheduling and execution contexts. */
+static inline void proxy_event(struct rq *rq, struct task_struct *donor,
+			       struct task_struct *exec, enum sched_proxy_event event)
+{
+	const struct sched_class *donor_class, *exec_class;
+
+	lockdep_assert_rq_held(rq);
+
+	donor_class = donor->sched_class;
+	exec_class = exec->sched_class;
+
+	if (donor_class->proxy_event)
+		donor_class->proxy_event(donor, exec, event);
+	if (exec_class != donor_class && exec_class->proxy_event)
+		exec_class->proxy_event(donor, exec, event);
+}
+
+/* Notify every execution context in the current proxy chain. */
+static inline void
+proxy_event_chain(struct rq *rq, struct task_struct *donor, enum sched_proxy_event event)
+{
+	struct task_struct *exec = rq->curr;
+
+	if (exec == donor)
+		return;
+
+	for (; exec && exec != donor;
+	     exec = READ_ONCE(exec->blocked_donor))
+		proxy_event(rq, donor, exec, event);
+}
+
+/* Promote @p from a retained proxy owner to the new scheduling root. */
+static inline struct task_struct *
+proxy_promote_root(struct rq *rq, struct task_struct *p)
+{
+	struct task_struct *old_root = NULL;
+
+	if (READ_ONCE(p->blocked_donor)) {
+		old_root = proxy_root_donor(rq, p);
+
+		if (old_root != p)
+			proxy_event(rq, old_root, p, SCHED_PROXY_STOP);
+		else
+			old_root = NULL;
+	}
+
+	p->blocked_donor = NULL;
+
+	return old_root;
+}
+
+#else
+static inline struct task_struct *
+proxy_root_donor(struct rq *rq, struct task_struct *exec)
+{
+	return exec;
+}
+
+static inline void proxy_event(struct rq *rq, struct task_struct *donor,
+			       struct task_struct *exec, enum sched_proxy_event event) {}
+static inline void
+proxy_event_chain(struct rq *rq, struct task_struct *donor, enum sched_proxy_event event) {}
+static inline struct task_struct *
+proxy_promote_root(struct rq *rq, struct task_struct *p)
+{
+	return NULL;
+}
+#endif
+
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -6768,6 +6855,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (sched_proxy_exec())
+		proxy_event(rq, rq->donor, p, SCHED_PROXY_BLOCK);
+
 	p->is_blocked = 1;
 
 	/*
@@ -6925,11 +7015,12 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
  * Returns the task that is going to be used as execution context (the one
  * that is actually going to be run on cpu_of(rq)).
  */
-static struct task_struct *
-find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+static struct task_struct *find_proxy_task(struct rq *rq, struct task_struct *donor,
+		struct task_struct *old_root, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *owner = NULL;
+	bool context_changed = old_root != NULL;
 	bool curr_in_chain = false;
 	int this_cpu = cpu_of(rq);
 	struct task_struct *p;
@@ -7056,7 +7147,24 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
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
+			old_root = proxy_root_donor(rq, owner);
+
+			if (old_root != owner)
+				proxy_event(rq, old_root, owner, SCHED_PROXY_STOP);
+
+			owner->blocked_donor = p;
+			context_changed = true;
+		} else if (context_changed && old_root != owner) {
+			proxy_event(rq, old_root, owner, SCHED_PROXY_STOP);
+		}
+		if (context_changed)
+			proxy_event(rq, donor, owner, SCHED_PROXY_START);
 	}
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
@@ -7069,8 +7177,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	return NULL;
 }
 #else /* SCHED_PROXY_EXEC */
-static struct task_struct *
-find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+static struct task_struct *find_proxy_task(struct rq *rq, struct task_struct *donor,
+		struct task_struct *old_root, struct rq_flags *rf)
 {
 	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
 	return donor;
@@ -7208,11 +7316,19 @@ static void __sched notrace __schedule(int sched_mode)
 	rq->next_class = next->sched_class;
 	if (sched_proxy_exec()) {
 		struct task_struct *prev_donor = rq->donor;
+		struct task_struct *old_root;
+
+		/*
+		 * A mutex handoff may clear the backlink outside rq->lock.
+		 * Report the resulting proxy STOP once serialized here.
+		 */
+		if (prev != prev_donor && !READ_ONCE(prev->blocked_donor))
+			proxy_event(rq, prev_donor, prev, SCHED_PROXY_STOP);
 
 		rq_set_donor(rq, next);
-		next->blocked_donor = NULL;
+		old_root = proxy_promote_root(rq, next);
 		if (unlikely(next->is_blocked)) {
-			next = find_proxy_task(rq, next, &rf);
+			next = find_proxy_task(rq, next, old_root, &rf);
 			if (!next) {
 				zap_balance_callbacks(rq);
 				goto pick_again;
@@ -11277,6 +11393,10 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
 
 	lockdep_assert_rq_held(rq);
 
+	/* End proxy service before changing the donor's scheduling class. */
+	if ((flags & DEQUEUE_CLASS) && task_current_donor(rq, p))
+		proxy_event_chain(rq, p, SCHED_PROXY_STOP);
+
 	if (!(flags & DEQUEUE_NOCLOCK)) {
 		update_rq_clock(rq);
 		flags |= DEQUEUE_NOCLOCK;
@@ -11335,6 +11455,10 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
index dd058a6ca06b..14595f632b17 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2530,6 +2530,36 @@ static void watchdog(struct rq *rq, struct task_struct *p)
 static inline void watchdog(struct rq *rq, struct task_struct *p) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static void
+proxy_event_rt(struct task_struct *donor, struct task_struct *exec, enum sched_proxy_event event)
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
@@ -2550,7 +2580,7 @@ static void task_tick_rt(struct rq *rq, int queued)
 	update_curr_rt(rq);
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
-	watchdog(rq, p);
+	watchdog(rq, rq->curr);
 
 	/*
 	 * RR tasks need a special form of time-slice management.
@@ -2625,6 +2655,9 @@ DEFINE_SCHED_CLASS(rt) = {
 	.find_lock_rq		= find_lock_lowest_rq,
 
 	.task_tick		= task_tick_rt,
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	.proxy_event		= proxy_event_rt,
+#endif
 
 	.get_rr_interval	= get_rr_interval_rt,
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f2f1e3642831..426cc466e813 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2623,6 +2623,12 @@ struct affinity_context {
 
 extern s64 update_curr_common(struct rq *rq);
 
+enum sched_proxy_event {
+	SCHED_PROXY_START,
+	SCHED_PROXY_BLOCK,
+	SCHED_PROXY_STOP,
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2721,6 +2727,15 @@ struct sched_class {
 	 * sched_tick_remote: rq->lock
 	 */
 	void (*task_tick)(struct rq *rq, int queued);
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	/*
+	 * Proxy execution transitions. Callbacks run with the rq lock held and
+	 * must not sleep. Donor and execution task lifetime is protected by the
+	 * caller.
+	 */
+	void (*proxy_event)(struct task_struct *donor, struct task_struct *exec,
+			    enum sched_proxy_event event);
+#endif
 	/*
 	 * sched_cgroup_fork: p->pi_lock
 	 */

