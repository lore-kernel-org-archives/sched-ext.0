Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDB3E3DAB;
	Sun, 16 Aug 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786918219; cv=none; b=k5zcRbvHpgEhBs9kVhNh3kpwm951xfSarECeUxXO5eooaWWd/Mvnln5CwzSceLDTvX/1MSRlWnakJWWAOYntP/uNaXWoMNqCfVHrWfDTWlsPGmpguHeMBIxOc2rdjy37FTLOB8hAAzACQFKT+A+m2X6kzPZI2ovm9LDNWatPteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786918219; c=relaxed/simple;
	bh=EzOuXyexltRzXq+QC3UuAeTh1Z3ySQBjWAmpfvgeCPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgdhVdvCD7+wa8vusPh8OHzHbGj4OSJisPg9nCnNoh7w2Mq/sI/tocua6d6S0BM2A/XnCGGHOE8Lvy7SDr2z6pAgkfXwoqjlSXA41uGD6IwhMC3NKFQ+fdmiwqkgRYJiqtBUrculUmiX9uabxZcMVC3P+VA1ypBEhDpbGwf3cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiUL77dj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiUL77dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36CA1F000E9;
	Sun, 16 Aug 2026 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786918217;
	bh=Olu7KHexUKxKv01MUI4+BC0gKgTEcYyYSrMV7/g1lLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QiUL77djb01qbxFsBF2ONmBxLcJu1x4zkVusHCwCi49aUWLIxuchPjUyBxAdcO81C
	 IG5zLCsltePx1q9NZ+QC+01pia/8LYBX1jrrFV0lT/sdbRx8RJEpVy/pt+VYTdOn0a
	 vB15Zwu+hroQrXK/PZ4mjWsF68uKMXIxy2b6k6lil7C5WYeV/Mgqq3oMEKP1ELqvmA
	 mm9O5L9XhTq930/oDKOb+Nu/NYKvkEyHsKydWYdaYnL+Y6M4A8Wbl01YLdMMXF/FG7
	 rt9jTv3NR3yXvT/IBjJhOdENak8GadwOKCxGBwJ53SeNQQ6nfLx7LG+mOxe/oDFvw3
	 SVotYcagk3/Lg==
Date: Sun, 16 Aug 2026 12:10:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] sched_ext: Fix ops.running/stopping() pairing for
 proxy-exec donors
Message-ID: <aoI1SOEXuIUHl7jc@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-10-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816173732.17162-10-arighi@nvidia.com>

Hello,

On Sun, Aug 16, 2026 at 07:35:07PM +0200, Andrea Righi wrote:
> +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> +{
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		/*
>  		 * Core-sched might decide to execute @p before it is
> @@ -3024,9 +3037,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>  
>  	p->se.exec_start = rq_clock_task(rq);
>  
> -	/* see dequeue_task_scx() on why we skip when !QUEUED */
> -	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
> -		SCX_CALL_OP_TASK(sch, running, rq, p);
> +	/*
> +	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
> +	 * scheduling transition, defer starting a blocked donor's session until
> +	 * proxy resolution succeeds. A restore follows an already resolved
> +	 * scheduling context and can start the session immediately.
> +	 */
> +	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
> +		scx_start_task_running(rq, p);

nit: can we do !(p->is_blocked && first) instead? I think that matches
what's being expressed better.

Also, can you expand the comment? I find it a bit difficult to follow. So,
when we're actually switching to a donor, we skip running transition because
proxy resolution might give us nothing or it may have to run on a differnet
CPU and so on, so we do running transition after proxy resolution is done.
For SAVE/RESTORE, this doesn't apply as they're always matched regardless of
donor state. Is that the right reading?

>  	clr_task_runnable(p, true);
>  
> @@ -3072,6 +3090,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>  
>  void scx_proxy_donor_start(struct rq *rq)
>  {
> +	struct task_struct *donor = rq->donor;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (donor->sched_class == &ext_sched_class &&
> +	    (donor->scx.flags & SCX_TASK_QUEUED))

another nit: no need for line break.

> +		scx_start_task_running(rq, donor);
>  }

Thanks.

-- 
tejun
