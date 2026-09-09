Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1353A896;
	Wed,  9 Sep 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951898; cv=none; b=hr3YMK4Sfu7XvDlHaveNQHPjueEsyBYbY/NN6SMLMX92M7ztmV6lpeZzPY3gIq0oVkQ8ifkFHvxaUBgqkfa49l2XkFS5aJXAM3Hrj8Sx6dKcpjpr2nnJvXexUPOVGye4z+NCPy8Ozmf3hk3frQFnj0Dtf33iBGRX9dCiTML09/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951898; c=relaxed/simple;
	bh=Flbku7aOBVzPcGp1UQX9kx1DmUdK6V/ghIx6P5gZNJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/fA7L5lK8CudwyuT0P8qiKOAHsmE4hWDKwb3vLTRg31V8Ez5y1s0M/UuMeUoquYQ75a/lxFNGId5sM1d3f+jHl1sVa3A40FbSOn5t6cHYN2VaqcuE/ZiabjbTH4KLIN7ImVp07FcIOCFvxUwqds45rDd8YMot0HpcDmqwNwekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OGguqtQE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGguqtQE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OI9vxMrjFq9PqVHr06PfRNT+t2ZxihmWB4FPPKpYImo=; b=OGguqtQE1H70nB0LEoX3R6wMHt
	iT7Pr66utb/m4aIqnsW3IRnwlVp6elg8dbM8mG+0gwxT+o2HQmlRL0CjB5cxhbpoGyPNVlioIdWPj
	SPXfdO2hYSkl6/SXnybnWwsCq8R2KD47ukF0ETu2apoKKu+GpK2Ns48UuGeC7PDeoIoqdWANipmcH
	gs0LQFhsrSswS1olEFMKlzmueN46+kdymTGlTUZ/BBNQvQEkOPwNdppzr6EB6/5dIMSiWZd3DCqgd
	Z0jn5OPB1vuTGuSSfga2BN1x+kkAdZyjgkf6BUhJPCWrajcjbhqVx1lqWmg9FFDTYHOlaH0wYXKK7
	+r2WjZug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4G6Z-000000016Gu-2pa6;
	Wed, 09 Sep 2026 11:04:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBC753005AF; Wed, 09 Sep 2026 13:04:38 +0200 (CEST)
Date: Wed, 9 Sep 2026 13:04:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hui Su <sh_def@163.com>
Cc: mingo@redhat.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
	kprateek.nayak@amd.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, connoro@google.com, jstultz@google.com,
	arighi@nvidia.com, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v4 4/5] sched/rt: Fix RT watchdog accounting for proxy
 execution
Message-ID: <20260909110438.GA4120091@noisy.programming.kicks-ass.net>
References: <20260909092901.2989564-1-sh_def@163.com>
 <20260909092901.2989564-5-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909092901.2989564-5-sh_def@163.com>

On Wed, Sep 09, 2026 at 06:29:00PM +0900, Hui Su wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 05e599665fdd..d8a785bec639 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6768,6 +6768,14 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>  		return false;
>  	}
>  
> +	/*
> +	 * Proxy execution can keep a mutex-blocked task on the runqueue, so it
> +	 * may not pass through ENQUEUE_WAKEUP, which normally resets the RT
> +	 * watchdog interval.
> +	 */
> +	if (sched_proxy_exec() && p->rt.timeout)
> +		p->rt.timeout = 0;
> +
>  	p->is_blocked = 1;
>  
>  	/*
> @@ -7243,6 +7251,16 @@ static void __sched notrace __schedule(int sched_mode)
>  		rq_set_donor(rq, next);
>  	}
>  
> +	/*
> +	 * End a previous RT proxy watchdog interval once neither context is
> +	 * in the RT class. Preserve the interval for an RT-policy task that is
> +	 * temporarily PI-boosted into the DL class.
> +	 */
> +	if (sched_proxy_exec() && !task_has_rt_policy(next) &&
> +	    !rt_prio(next->prio) &&
> +	    !rt_prio(rq->donor->prio) && next->rt.timeout)
> +		next->rt.timeout = 0;
> +
>  picked:
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();

It might come as no surprise that this isn't going to fly. I've not
though about the problem yet, but we're not going to be sprinkling rt
bits like this in the middle of __schedule().
