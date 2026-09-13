Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31E3438BE
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332103; cv=none; b=R5VZoARDDsyAQ/bg7OilgobnWaLdtdJGg6P0bGmbk3Yiz2yeQLnP+lz1AW+UZzzBu3n+ZOX5fo4s+DM6FpdYjVKKNqu4SdYMVz7Js/v1h0QWjVF0pdaHsOohrDA3S+LGVV9i58ctQNNDlego4g3AkHiK2fNNyHrYQ1NDbKks5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332103; c=relaxed/simple;
	bh=6zqr1nKqSuVDxPSCWfoPP8X08Wola6HhUZBCLnNCs/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JVE0VCgcXlVQI2/G1PWMKvgEhQLDwcdlmcbIpTOpxGasa9w5pUX4wKXUOJQdh7cIuw+Ns9ZwWbwylOAGkwx+5GiBBTLDPASCEcbj2f4IfaB7sEfJbvZnaAaiquk1s1p2xaNqCpICp4jmKE5pPIa+mHqj/1qjAcb+u5kuL+NzokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=FKHZDVia; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="FKHZDVia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1789330215;
	bh=6zqr1nKqSuVDxPSCWfoPP8X08Wola6HhUZBCLnNCs/0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FKHZDVia5QyBpdcH+kTBO5vwXVCnBcaSjytx+2M+ZXH3aKXI/+DbJCu41aOA22hL6
	 aQh95EQcMWsroMoRRKjV0J0rr+8uHeL7/JRnhTiv7ZlAffWeyPO1XoDo21xaT2GQ/V
	 yzt+Bg3R/QFw4p0rLKILY8CfqecMmQgbbv8X6LU0=
Received: by gentwo.org (Postfix, from userid 1007)
	id D92D0402BE; Sun, 13 Sep 2026 13:10:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D5CE54027F;
	Sun, 13 Sep 2026 13:10:15 -0700 (PDT)
Date: Sun, 13 Sep 2026 13:10:15 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
    K Prateek Nayak <kprateek.nayak@amd.com>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    Christoph Lameter <cl@gentwo.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
    Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
    Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched: Restart hrtick after same-task repicks
In-Reply-To: <20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org>
Message-ID: <79a14c31-b4ed-4ff2-0551-8b31b86b91cb@gentwo.org>
References: <20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi all,

There seems to be an issue with the DL rearm in v2.

On a non-tick reschedule that repicks the running SCHED_DEADLINE task,
`next == prev` skips put_prev_task_dl(). Therefore
update_curr_dl() may not have charged execution since exec_start.
The v2 SNT_REPICK path then calls start_hrtick_dl() using stale
dl_se->runtime, which can arm the next hrtick too late and delay
SCHED_DEADLINE runtime enforcement.

Unless there is a DL case that requires this rearm and accounts current
beforehand, I will drop the DL SNT_REPICK rearm in the next revision.

So for now, please disregard the DL portion of v2 for review.

Thanks,
Shubhang Kaushik

On Fri, 11 Sep 2026, Shubhang Kaushik (Ampere) wrote:

> Fair and DL hrticks are one-shot timers. After an hrtick expires, the
> next preemption point must be explicitly armed for the task that remains
> selected.
>
> For fair, the missed path is:
>
>  hrtick()
>    -> rq->donor->sched_class->task_tick(rq, rq->donor, 1)
>    -> task_tick_fair(..., queued=1)
>       -> entity_tick()
>          -> resched_curr()
>    -> schedule()
>       -> pick_task_fair() selects the current task again
>       -> put_prev_set_next_task(rq, prev, next)
>          -> next == prev
>          -> return
>
> put_prev_set_next_task() returns without calling
> next->sched_class->set_next_task(). Consequently, set_next_task_fair()
> is not called and does not invoke hrtick_start_fair() to arm the next
> fair hrtick.
>
> The same `next == prev` return skips set_next_task_dl() and
> start_hrtick_dl() when a DL hrtick causes a reschedule that repicks the
> current DL task.
>
> Replace the `bool first` argument of set_next_task() with an enum.
> SNT_NORMAL and SNT_PICK preserve the existing call sites, while
> SNT_REPICK identifies the next == prev case. On `SNT_REPICK`, fair and DL
> skip their normal task-transition work because the task is already
> current, but restart their respective hrticks.
>
> Calling the class-specific rearm from the repick path also preserves the
> existing hrtick scheduling rules. The call occurs during schedule(), with
> hrtick programming deferred by rq->hrtick_sched; hrtick_start()
> records the new delay and hrtick_schedule_exit() rearms the hrtimer
> after scheduling completes.
>
> This replaces the fair specific rq state and runnable count checks with a
> common scheduler core solution.
>
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
> Testing:
>    - Built and booted baseline 08df884136f1 and v2 with
>      CONFIG_HIGH_RES_TIMERS=y and CONFIG_SCHED_HRTICK=y.
>    - Enabled HRTICK and DELAY_DEQUEUE, set base_slice_ns to 3000000, and
>      pinned two CPU-bound nice-0 fair-class tasks plus a periodic sleeper to
>      CPU 0.
>    - Collected five 10-second `perf sched` traces per kernel.
>
>  Across the CPU-bound fair-class tasks:
>
>    baseline: maximum runtime 5.227ms; 6 samples above 4ms.
>    v2:       maximum runtime 3.386ms; no samples above 4ms.
> ---
> Changes in v2:
>
> - Replace the fair-specific hrtick rearm state with SNT_REPICK.
> - Restart hrticks for both fair and SCHED_DEADLINE same-task repicks.
> - Remove the delayed-dequeue runnable-count condition.
>
> Link to v1: https://lore.kernel.org/r/20260813-sched-fair-hrtick-restart-v1-1-4230d1e18fbb@gentwo.org
> ---
> kernel/sched/core.c      |  2 +-
> kernel/sched/deadline.c  |  8 ++++++--
> kernel/sched/ext/ext.c   |  5 ++++-
> kernel/sched/fair.c      | 15 ++++++++++-----
> kernel/sched/idle.c      |  5 ++++-
> kernel/sched/rt.c        |  7 +++++--
> kernel/sched/sched.h     | 16 ++++++++++++----
> kernel/sched/stop_task.c |  5 ++++-
> 8 files changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b998ef6b87af4fa60422fe86b3702c43103ea9aa..90607d2f3a93a59c2227ce9775ce3976054a0b96 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7221,7 +7221,7 @@ static void __sched notrace __schedule(int sched_mode)
> 			 * on_cpu.
> 			 */
> 			donor->sched_class->put_prev_task(rq, donor, donor);
> -			donor->sched_class->set_next_task(rq, donor, true);
> +			donor->sched_class->set_next_task(rq, donor, SNT_PICK);
> 		}
> 	} else {
> 		rq_set_donor(rq, next);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0663c00c41c04213fda2ebaf16a0bdf34e0849a8..6c17563f42a1d22bae5fc9f85b75497b6b4faccb 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2773,11 +2773,14 @@ static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
>  * DL keeps current in tree, because ->deadline is not typically changed while
>  * a task is runnable.
>  */
> -static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
> +static void set_next_task_dl(struct rq *rq, struct task_struct *p, enum snt_e type)
> {
> 	struct sched_dl_entity *dl_se = &p->dl;
> 	struct dl_rq *dl_rq = &rq->dl;
>
> +	if (type == SNT_REPICK)
> +		goto repick;
> +
> 	p->se.exec_start = rq_clock_task(rq);
> 	if (on_dl_rq(&p->dl))
> 		update_stats_wait_end_dl(dl_rq, dl_se);
> @@ -2788,7 +2791,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
> 	WARN_ON_ONCE(dl_rq->curr);
> 	dl_rq->curr = dl_se;
>
> -	if (!first)
> +	if (type != SNT_PICK)
> 		return;
>
> 	if (rq->donor->sched_class != &dl_sched_class)
> @@ -2796,6 +2799,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
>
> 	deadline_queue_push_tasks(rq);
>
> +repick:
> 	if (hrtick_enabled_dl(rq))
> 		start_hrtick_dl(rq, &p->dl);
> }
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 51de1d8b72a1ede6d16c07b58defb1284285b8a6..31a300f2d3b202d588ca666d6b8f6d4705ee6c79 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3003,10 +3003,13 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
> 	return verdict;
> }
>
> -static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> +static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e type)
> {
> 	struct scx_sched *sch = scx_task_sched(p);
>
> +	if (type == SNT_REPICK)
> +		return;
> +
> 	if (p->scx.flags & SCX_TASK_QUEUED) {
> 		/*
> 		 * Core-sched might decide to execute @p before it is
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ade1eceb39b806e60e44efe54e33a7097d01d1df..4a83ad97544675d52ca6b296a5e57356da537293 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -15245,14 +15245,18 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
> 	}
> }
>
> -static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> +static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e type)
> {
> 	struct sched_entity *se = &p->se;
> -	bool throttled = false;
> 	struct cfs_rq *cfs_rq = &rq->cfs;
> 	unsigned long weight = NICE_0_LOAD;
> +	bool first = type == SNT_PICK;
> +	bool throttled = false;
> 	bool on_rq = se->on_rq;
>
> +	if (type == SNT_REPICK)
> +		goto repick;
> +
> 	clear_buddies(cfs_rq, se);
>
> 	if (on_rq)
> @@ -15296,11 +15300,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>
> 	WARN_ON_ONCE(se->sched_delayed);
>
> -	if (hrtick_enabled_fair(rq))
> -		hrtick_start_fair(rq, p);
> -
> 	update_misfit_status(p, rq);
> 	sched_fair_update_stop_tick(rq, p);
> +
> +repick:
> +	if (hrtick_enabled_fair(rq))
> +		hrtick_start_fair(rq, p);
> }
>
> void init_cfs_rq(struct cfs_rq *cfs_rq)
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index eb73b65ce6c4714db1e07066c86a8cf39adbc328..76f3c84ca6846afc30609fdc512553c6797e9557 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -487,8 +487,11 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
> 	update_rq_avg_idle(rq);
> }
>
> -static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> +static void set_next_task_idle(struct rq *rq, struct task_struct *next, enum snt_e type)
> {
> +	if (type == SNT_REPICK)
> +		return;
> +
> 	update_idle_core(rq);
> 	scx_update_idle(rq, true, true);
> 	schedstat_inc(rq->sched_goidle);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 85303add726df4c2da846c427aab2d627fca9589..1535046a23ffa0705d90dce301fa4c5b015703a1 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1654,11 +1654,14 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
> 		check_preempt_equal_prio(rq, p);
> }
>
> -static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
> +static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, enum snt_e type)
> {
> 	struct sched_rt_entity *rt_se = &p->rt;
> 	struct rt_rq *rt_rq = &rq->rt;
>
> +	if (type == SNT_REPICK)
> +		return;
> +
> 	p->se.exec_start = rq_clock_task(rq);
> 	if (on_rt_rq(&p->rt))
> 		update_stats_wait_end_rt(rt_rq, rt_se);
> @@ -1666,7 +1669,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
> 	/* The running task is never eligible for pushing */
> 	dequeue_pushable_task(rq, p);
>
> -	if (!first)
> +	if (type != SNT_PICK)
> 		return;
>
> 	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e656c7059bf864d1ed91d4ec3d4624850aded7e0..defcf7fd023fa5bb3c34c3c29f99afe3c42a87de 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2621,6 +2621,12 @@ struct affinity_context {
>
> extern s64 update_curr_common(struct rq *rq);
>
> +enum snt_e {
> +	SNT_NORMAL,
> +	SNT_PICK,
> +	SNT_REPICK,
> +};
> +
> struct sched_class {
>
> #ifdef CONFIG_UCLAMP_TASK
> @@ -2678,7 +2684,7 @@ struct sched_class {
> 	 * __schedule: rq->lock
> 	 */
> 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
> -	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
> +	void (*set_next_task)(struct rq *rq, struct task_struct *p, enum snt_e type);
>
> 	/*
> 	 * select_task_rq: p->pi_lock
> @@ -2781,7 +2787,7 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>
> static inline void set_next_task(struct rq *rq, struct task_struct *next)
> {
> -	next->sched_class->set_next_task(rq, next, false);
> +	next->sched_class->set_next_task(rq, next, SNT_NORMAL);
> }
>
> static inline void
> @@ -2802,11 +2808,13 @@ static inline void put_prev_set_next_task(struct rq *rq,
>
> 	__put_prev_set_next_dl_server(rq, prev, next);
>
> -	if (next == prev)
> +	if (next == prev) {
> +		next->sched_class->set_next_task(rq, next, SNT_REPICK);
> 		return;
> +	}
>
> 	prev->sched_class->put_prev_task(rq, prev, next);
> -	next->sched_class->set_next_task(rq, next, true);
> +	next->sched_class->set_next_task(rq, next, SNT_PICK);
> }
>
> /*
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index c909ca0d8c87c1055ad5ffe58ae9f044194ee358..1e0109ec36b3f9b84f6f7290e584e38257db701c 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -27,8 +27,11 @@ wakeup_preempt_stop(struct rq *rq, struct task_struct *p, int flags)
> 	/* we're never preempted */
> }
>
> -static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool first)
> +static void set_next_task_stop(struct rq *rq, struct task_struct *stop, enum snt_e type)
> {
> +	if (type == SNT_REPICK)
> +		return;
> +
> 	stop->se.exec_start = rq_clock_task(rq);
> }
>
>
> ---
> base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
> change-id: 20260813-sched-fair-hrtick-restart-ab9d3d47ef78
>
> Best regards,
> -- 
> Shubhang Kaushik (Ampere) <sh@gentwo.org>
>
