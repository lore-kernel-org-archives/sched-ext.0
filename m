Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3450AC02;
	Wed, 16 Sep 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554677; cv=none; b=HHDsUfdxOZxhHsmGR8iLOnVKUAQM1Ss3QbjYipZAR6wCzGf2HhJhUKdOTRL0Xwyi2gXjBgTFvtTockCw2PUbEUfS60iqboHdhH46sicFH5SYHLfW1v3dx+OILt6YzKpuT0oFV8OzJrO2MeCPxVG3KmBbu5R/Yh/ZmAf0GTB4JKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554677; c=relaxed/simple;
	bh=URByYqUlVkXn0kbytuHqOUyHgofje47yOhGQ1FVzd3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx7w20Vwvrp7tzv3jnDZKdOegcCT3t8iAnKtBCwHexSWojTj9pzfW2FDMg1kfxXDYtgC9Bv2Yy9UBTAryaRmmL+gkVKkaYUGUot2Pkr4s/8TO87gZuJqda9himGp6+2S9KEbKG7am1M0K4Z4IGLIdY6zRxPye9SzIe2o/ktMfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XXTrfCPp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXTrfCPp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2lwWlCZjh4BXIZ9G5SRm+hR1cYJZhyuxsVaYcGHSVPA=; b=XXTrfCPpSItfECPmAF6//pcGs5
	t9A8Wz74WEMOc2l3icE2wLWu0twPpv6Swfcz2Vp+eB5Uft0cZwKCJIFf7jn8Mxcyc+agRSeDLmz1j
	/WiweesxUek0B1Gh/Be1zeEl/3vg9u9por1ztj3Q81OiMVN0tOimHyOCUCjlNf0GeJG4vB+CTYQYm
	Cjur1Kn8rK5OuHutX3IVaJOWAuMGTdvZBqkDiPkdlu1ls0baan1GdDxF8JBkqm06Bx63vdfMrcyoD
	zBp2zc3/e2YpPBK3ejIOW1ZCclOzsIssio0ly778bVGGrw20Vcj1hh7ImjPjK6RGVxpykwweDMqpj
	8D7fVc5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6mub-00000007k3D-1dow;
	Wed, 16 Sep 2026 10:30:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD944302431; Wed, 16 Sep 2026 12:30:43 +0200 (CEST)
Date: Wed, 16 Sep 2026 12:30:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Message-ID: <20260916103043.GC776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
 <aqmw0OT5cCtge-QI@gpd4>
 <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
 <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
 <40a61874-4841-4e38-b22b-6b8c30667340@amd.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a61874-4841-4e38-b22b-6b8c30667340@amd.com>

On Wed, Sep 16, 2026 at 03:57:54PM +0530, K Prateek Nayak wrote:

> > @@ -2393,8 +2393,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
> >  		 * If task is sched_delayed, force dequeue it, to avoid always
> >  		 * hitting the tick timeout in the queued case
> >  		 */
> > -		if (p->se.sched_delayed)
> > -			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> > +		if (p->is_blocked)
> > +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_BLOCKED);
> 
> For proxy donors, this will simply dequeue the task without
> transitioning p->on_rq to 0.
> 
> If we want to break proxy at this point, maybe we want to bring
> that __block_task() into dequeue task and do it for
> DEQUEUE_BLOCKED?
> 
> >  		trace_sched_wait_task(p);
> >  		running = task_on_cpu(rq, p);
> >  		queued = task_on_rq_queued(p);
> > @@ -3889,8 +3889,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >  
> >  	update_rq_clock(rq);
> >  	if (p->is_blocked) {
> > -		if (p->se.sched_delayed)
> > -			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> > +		enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_BLOCKED);
> 
> For proxy donors on rq that don't belong to fair, this will enqueue
> an already enqueued task.

For both the idea would be that {EN,DE}QUEUE_BLOCKED would be ignored
when inappropriate.

Eg. fair will no-op when !sched_delayed.

I did mention none of the other classes behave properly in this regard,
although the note was perhaps a little cryptic.
