Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47611AB6F1;
	Fri, 22 May 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439030; cv=none; b=gO2m2lYbc8C7T8aVWbzjiB7v6omBYv1B7BE1GDfFdkkuMeBRNTTInSbWWC+q4CWyqktdovvGJFsiCin+lrF1GKiGHFYFe6ZSIhELpihyFjE3sNNWxZT5DYWyfnB0M7F0ERZYIbGPRtZAA7NU1k5tpnxBdSUh1mLGEXiLi2GNif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439030; c=relaxed/simple;
	bh=eqvXfp0f1+AFkrdn9L3GVK2rRgaCQ/W4k/YmBwYiGCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPw3ZJ/WZgZFmip8gsUvm8/BXY3ZKl/Gj7MYC5RBHPXhuAbLLFRaOB27vMH/MTpPGDGLN7X8aHE5UwKxoST9wwAN80kWE2yISnEPsnXl6ZkpYVGulE+2eDqNG0qy9N0HmhTieki/3UGaZi5hPPlDKG+eI7qWIHnzahr4x/5H5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hwqam++7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwqam++7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hSHsEXVwvyj0c1PG0TYmalgFyv+NTV6AP0jPk/Xds+g=; b=hwqam++7svcsHZ1/pS9ieH1NPH
	1ydM4YbkmR84hItH4hfq6HglK3H/EChGI1y+MEsPsfc+tLlVlpVVy/a7uz15TtJhDAWe/pBiQlI8E
	iKdx6Blan7nPl0FCUu4dxKw+sV75UufrgygflQGVzwGZmuDOeD0xGbPUctbli3OQrqB4JoiJ8nYqS
	QnFPRuAEBb3V4Pu2VNdTGousYUskHs9J+BOzFg+r633PgXBjXE4Xb0UJJm5mxyeMASqekhcuFItRu
	tHHEqU85wYj8czBkGGfdol5u1YDJqTuZB4QaeG7vctwj/lcyWWgcJs+Z6XkBykwBtkywgZzw4E0zw
	Na6imFaw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQLNJ-00000009pef-1xoP;
	Fri, 22 May 2026 08:36:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 96EEA300329; Fri, 22 May 2026 10:36:55 +0200 (CEST)
Date: Fri, 22 May 2026 10:36:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Message-ID: <20260522083655.GM3126523@noisy.programming.kicks-ass.net>
References: <20260521174509.1534623-1-arighi@nvidia.com>
 <20260521174509.1534623-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521174509.1534623-2-arighi@nvidia.com>

On Thu, May 21, 2026 at 07:33:56PM +0200, Andrea Righi wrote:

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9c458552d14ff..15ba49fcba9af 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6061,6 +6061,7 @@ static void scx_root_disable(struct scx_sched *sch)
>  {
>  	struct scx_task_iter sti;
>  	struct task_struct *p;
> +	bool was_switched_all;
>  	int cpu;
>  
>  	/* guarantee forward progress and wait for descendants to be disabled */
> @@ -6087,6 +6088,13 @@ static void scx_root_disable(struct scx_sched *sch)
>  	 */
>  	mutex_lock(&scx_enable_mutex);
>  
> +	/*
> +	 * Snapshot the full vs partial mode before clearing the static
> +	 * branch, so the dl_server re-balance below knows whether the
> +	 * fair_server reservation needs to be reinstated.
> +	 */
> +	was_switched_all = scx_switched_all();
> +
>  	static_branch_disable(&__scx_switched_all);
>  	WRITE_ONCE(scx_switching_all, false);
>  
> @@ -6136,10 +6144,24 @@ static void scx_root_disable(struct scx_sched *sch)
>  	/*
>  	 * Invalidate all the rq clocks to prevent getting outdated
>  	 * rq clocks from a previous scx scheduler.
> +	 *
> +	 * Also re-balance the dl_server bandwidth reservations: detach
> +	 * ext_server (no more sched_ext tasks) and reinstate fair_server
> +	 * if it was previously detached because we were running in full
> +	 * mode. Detach before attach to avoid a transient overflow of the
> +	 * root domain's bandwidth capacity.
>  	 */
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
> +
>  		scx_rq_clock_invalidate(rq);
> +
> +		scoped_guard(rq_lock_irqsave, rq) {
> +			dl_server_detach_bw(&rq->ext_server);
> +			if (was_switched_all &&
> +			    WARN_ON_ONCE(dl_server_attach_bw(&rq->fair_server)))
> +				pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
> +		}
>  	}
>  
>  	/* no task is on scx, turn off all the switches and flush in-progress calls */
> @@ -7314,6 +7336,27 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
>  		static_branch_enable(&__scx_switched_all);
>  
> +	/*
> +	 * Re-balance the dl_server bandwidth reservations.
> +	 *
> +	 * In full mode (!SCX_OPS_SWITCH_PARTIAL) no task will ever run in
> +	 * the fair class, so detach the fair_server reservation and give
> +	 * that bandwidth back to the RT class. Always attach the
> +	 * ext_server reservation since sched_ext tasks are now possible.
> +	 *
> +	 * Detach before attach to avoid a transient overflow of the root
> +	 * domain's bandwidth capacity.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		guard(rq_lock_irqsave)(rq);
> +		if (scx_switched_all())
> +			dl_server_detach_bw(&rq->fair_server);
> +		if (WARN_ON_ONCE(dl_server_attach_bw(&rq->ext_server)))
> +			pr_warn("failed to attach ext_server on CPU %d\n", cpu);
> +	}
> +
>  	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
>  		sch->ops.name, scx_switched_all() ? "" : " (partial)");
>  	kobject_uevent(&sch->kobj, KOBJ_ADD);

For switching *to* scx, I think it makes sense to attach ext_server
early and fail the switch if the attach fails. And only after the
switch, conditionally detach fair_server.

Since switching back to fair is a recovery path, this isn't really an
option -- the only actual option is keeping the fair_server reservation,
but that isn't ideal either.


