Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99545FFB5;
	Thu, 10 Sep 2026 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037628; cv=none; b=aRZn5DU65USuoYxtWKafXTWltW28+r2a1W5ghG1I7TjcIzB1P4+JWWJBm5V3Eflf0+iabc06KWEO3Lid2r705cBOzbfS0fF728pqxqu5RGhmUySWrhyWtvTXdqHo+sh+FEq212srOI7mQc+tIbGf3lssdJ7L9REHTKmLPqLPuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037628; c=relaxed/simple;
	bh=AE87lusMPfPjdrB3o6pXNzFg0voaAAjsIOr74KNCMOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY0TZgjlCwAZjdt7+VIHeVo61fl7YvEtsD7Ibe7LWgv/EbswIJuP7E9CsTQlLGkgspnKHHLFFlJbtPe3YRExrk/URwY4nP+0vLlz4appLFnkkbPMSWzCmXoAHMPWkkPNqyt7hK9rgjNj8byWlh/JMYakeE/0JUg+arK+6HIuPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qk/Ho36h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qk/Ho36h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VVwOnaOLvHrmUaRFj0thYlhFFoEcWPkUZVoSbzPkH9U=; b=qk/Ho36hMAqkPKl6+7NAXjyIvF
	7u76wg+bo0qO7NcQb347SO6o7qkadwSDLlS9yNtLN9gDnhhk8JOlsplDkZufyrHborZlFP7h0Rs2j
	7LZmZ0fO56Ovvi0JPZtLivtd3IoJkCQTKU6daNeygOLOH2IIf5SKOxZGp47OzvIs+tl9fVJgfl8gO
	lq9sZXxb1cQNogApEJn8VprKrCvDC/Aatl5/1Sj40I/WuPdJCqFxG4+lM29OyFD7Wajm8CwC4gHM4
	6K85oTOH/gcfJOn8+dJOzHUeCV+RYvAJbbp3vJwUTGJmGX5u3R42jo8GuaGjzu17kXgNDzG18+sU2
	0METmk/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4cPQ-0000000FrM0-19G2;
	Thu, 10 Sep 2026 10:53:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF87C30056B; Thu, 10 Sep 2026 12:53:35 +0200 (CEST)
Date: Thu, 10 Sep 2026 12:53:35 +0200
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
Subject: Re: [PATCH 09/18] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <20260910105335.GJ4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-10-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-10-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:19PM +0200, Andrea Righi wrote:
> Proxy execution retains mutex-blocked donors on the runqueue so their
> scheduling context can execute a lock owner. sched_ext cannot safely retain
> such donors unless the BPF scheduler explicitly participates in their
> admission and ordering.
> 
> Make sched_ext reject retained donors by default. Implement
> scx_allow_proxy_exec() to force blocked EXT tasks through the regular block
> path in schedule().
> 
> Also fully deactivate any retained proxy donor in sched_change_begin()
> before changing its scheduling class. This prevents sched_setscheduler(),
> PI transitions and sched_ext activation from carrying an existing proxy
> session into the new class.
> 
> Some RT/DL PI transitions could usefully preserve the proxy session. For
> example, an RT waiter can boost a FAIR donor which is itself blocked on a
> non-PI mutex; retaining the donor would allow the boosted context to keep
> proxy-executing that mutex owner. Doing so safely requires defining which
> scheduling classes can carry retained proxy state across a transition. Keep
> the conservative reset for now and leave compatible RT/DL PI chains for
> future work.
> 
> This is a preparatory change to support proxy execution with sched_ext.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c    | 9 +++++++++
>  kernel/sched/ext/ext.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f142ab455b797..4bd956182af8d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11302,6 +11302,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
>  		flags |= DEQUEUE_NOCLOCK;
>  	}
>  
> +	/*
> +	 * Don't carry retained proxy state across scheduling class changes.
> +	 * Compatible RT/DL PI transitions could preserve the session so that a
> +	 * boosted donor continues proxy-executing its lock owner. Defining which
> +	 * class transitions can safely retain that state is left for future work.
> +	 */
> +	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)

That's a tautology, having DEQUEUE_CLASS means next_class !=
->sched_class.

> +		sched_proxy_block_task(rq, p);
> +
>  	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
>  		p->sched_class->switching_from(rq, p);
>  
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f3e59f4fad4ac..d5ed996ebfb4c 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -26,7 +26,7 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
>  
>  bool scx_allow_proxy_exec(const struct task_struct *p)
>  {
> -	return true;
> +	return p->sched_class != &ext_sched_class;
>  }


Hmmmm... I don't like this. I was expecting this
sched_proxy_block_task() thing to be called in the big switcheroo
function when loading one of these ext thing. (scx_root_enable_ or
somesuch).

We most certainly don't want to do this on every sched class change. It
isn't even gated by scx_allow_proxy_exec().
