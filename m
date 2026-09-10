Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447103D9665;
	Thu, 10 Sep 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040535; cv=none; b=pHIjJfYFeXb2RBZMTvugKMZ0TKMcwSLqgIvdppF2z0tk5J7PIWXxUlq5jLCsZCDQJ8TE0QFP7uKEgEgoF0XFVvvksJvJdTWA1yS588q/tr8Zi4YMAdz4qrjwvlHbNPR6OJTg6OFxbQxvjI1499jlQrjGESn8AHNsls8n0Z83CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040535; c=relaxed/simple;
	bh=6AOCNf6ooFNeuXFrnz43a327Rz8xtP3Ul00LnedLQxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqq4y1UI1ksLBmaPDvfhWVTtvftLeB5qsBuKGo+3O/LWCs0frHddhroyEngHaeQ70VKdTDgKAvCwsastvrXnKoL9+sRFHINU79VEt2y48nioMUwN3abWJN/vr27k4HExWM4dnHpISXMddXVc9a6Mp981Dy3ld0E0C328GbExcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cFvp8FY5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFvp8FY5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mYHX7D1sxLMnaBQzTNpoWoa87XdRkMOjNcbxh5lYfc4=; b=cFvp8FY5Q5g1yXt0yD6FpW/z2m
	TrcxAZMA3OgbUdew3x8bnNr2RQHiVZZJ1hCr+4iWuoAoPsnn5ntyxj6IO0atFGERL4zvqzN4iMsdX
	6gEth2hcDyxGZDqkzRYWBWlSce3LBggoHwKlTro8rl4Y7gC+DSyyUitcMpSeQA4DUwtHznAexm1Y5
	U5FjRtO7/ViYfmadN921wMcBzP8N263PR65vsepm8Y7mNjtJ/eCJMxN/8rJWqDggbp9nWIWaFMdof
	yaF4p0saZhgrgg4rSRNx6x7kzTWkn/s1L7D+MfZa5TC1wLrkLFttziebMrxef8cElj4VmJr0+y7zV
	4Q9ZsJWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4dAG-00000002PsX-1M0G;
	Thu, 10 Sep 2026 11:42:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7097300400; Thu, 10 Sep 2026 13:41:58 +0200 (CEST)
Date: Thu, 10 Sep 2026 13:41:58 +0200
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
Message-ID: <20260910114158.GS788244@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-10-arighi@nvidia.com>
 <20260910105335.GJ4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910105335.GJ4120091@noisy.programming.kicks-ass.net>

On Thu, Sep 10, 2026 at 12:53:35PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:19PM +0200, Andrea Righi wrote:

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f142ab455b797..4bd956182af8d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11302,6 +11302,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
> >  		flags |= DEQUEUE_NOCLOCK;
> >  	}
> >  
> > +	/*
> > +	 * Don't carry retained proxy state across scheduling class changes.
> > +	 * Compatible RT/DL PI transitions could preserve the session so that a
> > +	 * boosted donor continues proxy-executing its lock owner. Defining which
> > +	 * class transitions can safely retain that state is left for future work.
> > +	 */
> > +	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
> 
> That's a tautology, having DEQUEUE_CLASS means next_class !=
> ->sched_class.
> 
> > +		sched_proxy_block_task(rq, p);
> > +
> >  	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
> >  		p->sched_class->switching_from(rq, p);
> >  

> Hmmmm... I don't like this. I was expecting this
> sched_proxy_block_task() thing to be called in the big switcheroo
> function when loading one of these ext thing. (scx_root_enable_ or
> somesuch).
> 
> We most certainly don't want to do this on every sched class change. It
> isn't even gated by scx_allow_proxy_exec().

Why not do:

switching_to_scx():

+	if (!scx_allow_proxy_exec(p))
+		sched_proxy_block_task(rq, p);


