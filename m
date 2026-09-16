Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79414A5EB8;
	Wed, 16 Sep 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550404; cv=none; b=UqD3EYfsGRAyRsWbe9iah6zko6vCvtZnZTVp5k+6M6mMmxVUzdisJsyM8+oRgd4DZD7/5pMxGeE1z4tCH95km0WbXwrLzTqL2ARbDz8jiGPchMbPsf+gt9jvwWOLNDEN0xEqlyS9T8dmIdVUgFa0sCMFFBn0LHpLI6AsDpaXjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550404; c=relaxed/simple;
	bh=9bo681hPnxC/7PYEB4YJR7t/zFa6XOG8NFH0Ij6ePIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoIqurae8XYwI4WEXPl0p0HHIA8KquTKu8VJAmuz9FOxeRWKzWwdl0tEWU0gpSXsvOhIbP/M618TJGHYuAieXvDtA9mIEGVPhyZmXpfXAmQWyWTWycY39m4V6CGs/rtsZKZqK8f0OLyaOoz12zZ9jlXXD71pelU+WCzGTMfVRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h0hTdgH6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0hTdgH6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UAn839ZZxRbCAuApTfK0jneV0NeeQScWBtLsAnEwTTg=; b=h0hTdgH6tZ3SND2iBI1JvQ5wBr
	jVe2GR4qIull3j7kNKDxcp/YYrd0kGYT8lYuj395Q5FyH7sPaEZ7wMnE0BlxM4KUU6HXvcjMuNIvD
	TGJ2Gyxk4QNcydD8OWIpC0fWSIlggNb2IryVL7QKpK7Wi11GlowXK8MdKj1BOLZfxb8OM+PSF1TM+
	3RD2IfecZmoLTuj0txBlXtHmN63AA5bn3WBmvEr0g+oR2tUd/7fQJaYJvwb6WRLki+Cek015De8ku
	KI8rXZPyed6OjJNwBNvnwxtG7C/0hbE9sX683cSDE3lXPH0/045o0Qn48pSRQ52JHZPpxTiQcbhdU
	+95LKAmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6lnJ-00000007gF7-3GrJ;
	Wed, 16 Sep 2026 09:19:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1D7F3012C6; Wed, 16 Sep 2026 11:19:08 +0200 (CEST)
Date: Wed, 16 Sep 2026 11:19:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Message-ID: <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
 <aqmw0OT5cCtge-QI@gpd4>
 <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>

On Tue, Sep 15, 2026 at 02:14:11PM -0700, John Stultz wrote:
> On Tue, Sep 15, 2026 at 1:55 PM Andrea Righi <arighi@nvidia.com> wrote:

> > What sched_ext actually needs to know is: did this wakeup use ttwu_runnable(),
> > changing the task back to TASK_RUNNING without calling activate_task() /
> > enqueue_task()?
> >
> > We need the distinction because a retained proxy donor remains on the runqueue
> > while blocked. When it wakes, ttwu_runnable() can clear its blocked state
> > without calling enqueue_task_scx() again.
> >
> > sched_ext must therefore request a reschedule so the newly unblocked task
> > is reconsidered for dispatch. We don't want this extra reschedule for a normal
> > wakeup because that path already called enqueue_task_scx() and performed the
> > required sched_ext bookkeeping.
> 
> Would it be sufficient to just drop the if (task_cpu(p) ==
> p->wake_cpu)  shortcut in proxy_needs_return()?
> (or conditionalize it on the sched_class?)

One of the things I have on the TODO list was look at getting rid of
p->se.sched_delayed usage in the core (That's bugged me ever since I
introduced it.)

We're part-way there with the introduction of p->is_blocked.

The tentative plan -- but I've not tried, or even thought overly much
about is -- is to do something like the *COMPLETELY*UNTESTED* below.

This would get the class methods {EN,DE}QUEUE_BLOCKED calls (which are
unhandled except for fair, so that needs fixing at the very least).

I *think* this would allow ext to do the right thing, but I'm not saying
we have to do this now, this might turn out to be a pain in the arse --
as these things tend to be.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 91f059a55695..9a583e3cc528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -305,7 +305,7 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 
 void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
-	if (p->se.sched_delayed)
+	if (p->is_blocked)
 		return;
 
 	rq->core->core_task_seq++;
@@ -318,7 +318,7 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 
 void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->se.sched_delayed)
+	if (p->is_blocked)
 		return;
 
 	rq->core->core_task_seq++;
@@ -1880,7 +1880,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags
 		return;
 
 	/* Only inc the delayed task which being woken up. */
-	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
+	if (p->is_blocked && !(flags & ENQUEUE_BLOCKED))
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -1907,7 +1907,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	if (p->se.sched_delayed)
+	if (p->is_blocked)
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -2393,8 +2393,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * If task is sched_delayed, force dequeue it, to avoid always
 		 * hitting the tick timeout in the queued case
 		 */
-		if (p->se.sched_delayed)
-			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		if (p->is_blocked)
+			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_BLOCKED);
 		trace_sched_wait_task(p);
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
@@ -3889,8 +3889,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	update_rq_clock(rq);
 	if (p->is_blocked) {
-		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+		enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_BLOCKED);
 		if (proxy_needs_return(rq, p))
 			return 0;
 	}
@@ -4288,7 +4287,6 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		WARN_ON_ONCE(p->se.sched_delayed);
 		WARN_ON_ONCE(p->is_blocked);
 		/* If p is current, we know we can run here, so clear blocked_on */
 		clear_task_blocked_on(p, NULL);
@@ -4592,7 +4590,6 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
-	WARN_ON_ONCE(p->se.sched_delayed);
 	WARN_ON_ONCE(p->is_blocked);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -7288,7 +7285,7 @@ static void __sched notrace __schedule(int sched_mode)
 
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
-					     prev->se.sched_delayed);
+					     prev->is_blocked);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d0b94465d19..ad72f428565f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6439,7 +6439,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (task_on_rq_migrating(task_of(se)))
 			action |= DO_DETACH;
 
-		if ((flags & DEQUEUE_SLEEP) && !(flags & DEQUEUE_DELAYED))
+		if ((flags & DEQUEUE_SLEEP) && !(flags & DEQUEUE_BLOCKED))
 			action |= UPDATE_UTIL_EST;
 	}
 
@@ -6525,7 +6525,7 @@ pick_next_entity(struct rq *rq, bool protect)
 
 	se = pick_eevdf(cfs_rq, protect);
 	if (se->sched_delayed) {
-		__dequeue_task(rq, task_of(se), DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		__dequeue_task(rq, task_of(se), DEQUEUE_SLEEP | DEQUEUE_BLOCKED);
 		/*
 		 * Must not reference @se again, see __block_task().
 		 */
@@ -8007,13 +8007,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
+	if (!p->se.sched_delayed || (flags & ENQUEUE_BLOCKED))
 		util_est_enqueue(cfs_rq, p);
 
 	update_curr_eevdf(cfs_rq);
 
-	if (flags & ENQUEUE_DELAYED) {
-		requeue_delayed_entity(cfs_rq, se);
+	if (flags & ENQUEUE_BLOCKED) {
+		if (se->sched_delayed)
+			requeue_delayed_entity(cfs_rq, se);
 		return;
 	}
 
@@ -8075,7 +8076,7 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 {
 	struct sched_entity *se = &p->se;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
-	bool task_delayed = flags & DEQUEUE_DELAYED;
+	bool task_delayed = flags & DEQUEUE_BLOCKED;
 	bool task_throttled = flags & DEQUEUE_THROTTLE;
 	int h_nr_runnable = 0;
 	int h_nr_idle = task_has_idle_policy(p);
@@ -8111,7 +8112,7 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 			record_throttle_clock(cfs_rq);
 
 		flags |= DEQUEUE_SLEEP;
-		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
+		flags &= ~(DEQUEUE_BLOCKED | DEQUEUE_SPECIAL);
 	}
 }
 
@@ -8128,15 +8129,16 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	bool was_sched_idle = sched_idle_rq(rq);
 	bool task_sleep = flags & DEQUEUE_SLEEP;
-	bool task_delayed = flags & DEQUEUE_DELAYED;
+	bool task_delayed = flags & DEQUEUE_BLOCKED;
 
 	clear_buddies(cfs_rq, se);
 
 	update_curr_eevdf(cfs_rq);
 	update_entity_lag(cfs_rq, se);
 
-	if (flags & DEQUEUE_DELAYED) {
-		WARN_ON_ONCE(!se->sched_delayed);
+	if (flags & DEQUEUE_BLOCKED) {
+		if (!se->sched_delayed)
+			return true;
 	} else {
 		bool delay = task_sleep;
 		/*
@@ -15213,7 +15215,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 static void switching_from_fair(struct rq *rq, struct task_struct *p)
 {
 	if (p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_BLOCKED | DEQUEUE_NOCLOCK);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c3ad70e58b8..bd02ae83719c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2578,7 +2578,7 @@ extern const u32		sched_prio_to_wmult[40];
  *
  * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
  *
- * DELAYED - de/re-queue a sched_delayed task
+ * BLOCKED - de/re-queue a sched_delayed task
  *
  * CLASS - going to update p->sched_class; makes sched_change call the
  *         various switch methods.
@@ -2598,7 +2598,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_NOCLOCK		0x0008 /* Matches ENQUEUE_NOCLOCK */
 
 #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
-#define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_BLOCKED		0x0020 /* Matches ENQUEUE_DELAYED */
 #define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
 
 #define DEQUEUE_SPECIAL		0x00010000
@@ -2610,7 +2610,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_NOCLOCK		0x0008
 
 #define ENQUEUE_MIGRATING	0x0010
-#define ENQUEUE_DELAYED		0x0020
+#define ENQUEUE_BLOCKED		0x0020
 #define ENQUEUE_CLASS		0x0040
 
 #define ENQUEUE_HEAD		0x00010000
