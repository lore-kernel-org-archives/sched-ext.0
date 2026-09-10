Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E43D953E;
	Thu, 10 Sep 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034106; cv=none; b=Ak7JoMxvTerbBvmBWrffYC9YN/iFeOfvu6YCxKiqRlF5Q9rVTM2MorlvYptbI35EgSQDDiHVS0aGa97jZ1GKLtfb8E0+cPAXvNUsp9/p/HSI0XVACDK7Jxpowz1WGxG/IYqy6kgYYFrl5fIl8pUtbof0a4qbGhJXHzkKjNFQR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034106; c=relaxed/simple;
	bh=IjQgWcBdDaeIRFoNlHdXHDMf732D8GiR42ZzxWjiN6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo85+k2QPYiYzhqAXuSCPjT69EikHnE02Vzl7r6DCmwMv9Pq42RrNOkyONdg8+0PpisMcnA7QUPIlrl9b+yOHUuKdsaG97jUl0pcVSl82l/6QNGu8LGPZV/PKe2avAGyIDEElUFrjOjfFlC8GBddsSrHFqJ5rg7Z9utRVqLRU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=auGg7QPA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="auGg7QPA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9+OMSGN1tjh9V0hWB/JangblYswcq7i3USvWFkZeZY=; b=auGg7QPA51QZDJGiiW/ZLZmpMO
	Up7cQSD3NFEcxCFAhcagZDpl2sG3Ccs7iradn+TxTsEu/jCYydQUM8cTYYtCXbxJ/fYJFlPe6EUJY
	ZbsN4lUCVoSeS9ZuWJlVU3F4nqrJzGDaOAf+0QDS6zux+6JFhHY94OeNb1oxQ0niiSZI5jTXEAz7V
	PCx4fpxVlut969Iud/f9dbEInKuI68OuE4LMOyDsSEoD30hxDcK2eE65gao37KU0AeM74aGzMdyVk
	L6LoaPB3kZCehP0bUchg8FCQpTIts//IcZ5Ipzi7u2vXpAp1Mz+ENlUpKUNA+sIDHjHortEJv3YrD
	L8sQEnNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bUX-0000000FHdH-0Lim;
	Thu, 10 Sep 2026 09:54:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27F0530056B; Thu, 10 Sep 2026 11:54:48 +0200 (CEST)
Date: Thu, 10 Sep 2026 11:54:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH 03/18] sched: Make NOHZ CFS bandwidth checks follow proxy
 donor
Message-ID: <20260910095448.GE4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-4-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:13PM +0200, Andrea Righi wrote:
> Proxy execution separates the scheduling context in rq->donor from the
> physical execution context in rq->curr. sched_can_stop_tick() checks the
> latter for CFS bandwidth constraints and only does so when nr_running is
> one.
> 
> A retained proxy donor keeps both the donor and mutex owner queued. The
> check therefore misses a constrained FAIR donor and may stop the tick
> while its runtime still needs to be enforced.
> 
> Check the selected donor instead and remove the nr_running restriction.
> The donor being a queued FAIR task is sufficient to require bandwidth
> accounting regardless of other runnable tasks.
> 
> Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org
> Acked-by: John Stultz <jstultz@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 35 ++++++++++++++++++-----------------
>  kernel/sched/fair.c | 12 +++++++-----
>  2 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 237d216382f46..14d0d5c884393 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1419,11 +1419,8 @@ static void nohz_csd_func(void *info)
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> -static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
> +static inline bool __need_bw_check(struct task_struct *p)
>  {
> -	if (rq->nr_running != 1)
> -		return false;
> -
>  	if (p->sched_class != &fair_sched_class)
>  		return false;
>  
> @@ -1441,6 +1438,14 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->dl.dl_nr_running)
>  		return false;
>  
> +	/*
> +	 * The selected scheduling context can be a constrained FAIR donor even
> +	 * when rq->curr is an RT task. Check it before the RT fast paths below,
> +	 * which may report that the tick can stop for a throttled RT context.
> +	 */

I am most confused... how can we ever have rq->donor be FAIR and
rq->curr be RT? That makes no sense. If an RT task is runnable, pick
should just straight up pick that.

> +	if (__need_bw_check(rq->donor) && cfs_task_bw_constrained(rq->donor))
> +		return false;
> +


> @@ -7114,7 +7107,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>   */
>  static void __sched notrace __schedule(int sched_mode)
>  {
> -	struct task_struct *prev, *next;
> +	struct task_struct *prev, *next, *tick_donor;
>  	/*
>  	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
>  	 * as a preemption by schedule_debug() and RCU.
> @@ -7168,6 +7161,7 @@ static void __sched notrace __schedule(int sched_mode)
>  	rq->clock_update_flags <<= 1;
>  	update_rq_clock(rq);
>  	rq->clock_update_flags = RQCF_UPDATED;
> +	tick_donor = rq->donor;
>  
>  	switch_count = &prev->nivcsw;
>  
> @@ -7243,6 +7237,13 @@ static void __sched notrace __schedule(int sched_mode)
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  keep_resched:
> +	/*
> +	 * Enqueue and dequeue updates can evaluate the outgoing donor. Refresh
> +	 * the dependency after selecting a different scheduling context.
> +	 */
> +	if (rq->donor != tick_donor)
> +		sched_update_tick_dependency(rq);

Please keep all the proxy specific bits inside the one
sched_proxy_exec() branch above.
