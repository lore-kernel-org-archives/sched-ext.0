Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3F3DDB0D;
	Thu, 10 Sep 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034836; cv=none; b=TdF16RsHYH7uiLVelAT5bY8K5LLeGKQo6e6oj7Jc/aO5mdG1KpnKMMSid9UC9KO8Vppy+UZ374e0xnQpyXdO0OCjm+5C1JPwebaeYcOvmOQlwDvCkyOrovtrIt6IFdBegCSG9+quzDpGtJwLvrAL1rIRAIwvBxW9OQOWBD2ZrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034836; c=relaxed/simple;
	bh=k94awpgt723oeHEb+b2cubA9NJwFOaBZ3kmkxECckrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9hMqctBho9hLoxmcxHOaMHtRkMcci7KdFLj56h0EGL4/2cCy/VcyCiQ7dG9T3x4FuQ2QLz4gbI9OmYf7N8ZoU1XxmDo/oYdYzHMBYbfKigerhGDyOtc9gJ4yplBCUTWmZsqvDP2V8lGcIN3BQWiaCDILoHjS03natTKyysVGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YCh1MS/A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCh1MS/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+8T09nof1B/bWhhdFyjSdHtqI0P0pbt7H2tQc3YbqvY=; b=YCh1MS/AMOPoSKMWUy0dqMojG8
	yHl6jPItYiQWrRoaFTdb5fpjY8cR4Hjfw+cnjg6Byj7jb6+tD4UuD6WiZqAyQVOTirb4zMtsPGEHR
	XEVtUNats6GOf1E516SJt9Uk6eBHX4Yx2KITpk3T81g8c7nT0jsvfq+2aVTBCzZvOMiLbTtECFF0m
	Oxy/Zh/2fPxas8DMXBYEonIMt42QOivGvc31ov5PByHQNhjwkdRJH/vHTbn+ssMamO2yGUyB3ggv7
	bR143+UwPKs2FwVocJ8HPUsfcwJaL7r/jJezb/B+DooWdSFpjotNQF76b0PY3Yzlvz77VYyBJJ02B
	4umiXP4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4bgD-00000002Iys-4A2H;
	Thu, 10 Sep 2026 10:06:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1317300400; Thu, 10 Sep 2026 12:06:52 +0200 (CEST)
Date: Thu, 10 Sep 2026 12:06:52 +0200
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
Subject: Re: [PATCH 04/18] sched/core: Avoid false migration warning for
 proxy donors
Message-ID: <20260910100652.GF4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-5-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:14PM +0200, Andrea Righi wrote:
> Proxy execution can move a blocked donor's scheduling context to the
> lock owner's CPU even when the donor is migration-disabled. The donor
> does not execute there, and its original execution CPU remains recorded
> in wake_cpu.
> 
> set_task_cpu() warns unconditionally for migration-disabled tasks, so a
> subsequent proxy migration or the wakeup path returning the donor home
> triggers a false positive. Moving a blocked scheduling context does not
> violate the migration-disabled execution context.
> 
> Exclude blocked proxy donors from the warning. The proxy wakeup path
> restores an executable placement before clearing the blocked state.
> 
> This is a preparatory fix for enabling proxy execution together with
> sched_ext.
> 
> Acked-by: John Stultz <jstultz@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 14d0d5c884393..0a2eabadfee02 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3351,6 +3351,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>  void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  {
>  	unsigned int state = READ_ONCE(p->__state);
> +	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
> +			      task_cpu(p) != p->wake_cpu;
>  
>  	/*
>  	 * We should never call set_task_cpu() on a blocked task,
> @@ -3386,7 +3388,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  	 */
>  	WARN_ON_ONCE(!cpu_online(new_cpu));
>  
> -	WARN_ON_ONCE(is_migration_disabled(p));
> +	/*
> +	 * Proxy execution can move a blocked task's scheduling context to any
> +	 * CPU without moving its migration-disabled execution context. The
> +	 * wakeup path will return the task to a CPU where it can execute.
> +	 */
> +	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
>  
>  	trace_sched_migrate_task(p, new_cpu);

I'm not sure why we're not hitting this upstream?
