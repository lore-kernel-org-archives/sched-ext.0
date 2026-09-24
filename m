Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701E361943;
	Thu, 24 Sep 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240959; cv=none; b=Jg6NA2r8XvTtW6cQhYd2ca7no2T3gDNFpNjnnMYtL38dAJ6Wg02g49NHjyI/QujoOupRcAbceKW1BXzeVBoAS0igZuZK1dqywGULQBlSTPYWGgZgYcum1wVWcodTNAYkGmomEmrFjEtUNXDD/DQ3lSztprVyrZiP4p+TVFIUeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240959; c=relaxed/simple;
	bh=dOsSfragpCZL89liI2A5/mqYVe92z3wf5VnFwhzclkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzODQQaMvWAPGlNDu9Mse2k3izEQiPeWhtXBn1nU4ejjo06etnuh3J9SqsZJ79ndPcmmRM6XGhXvtbtYtNKG6+dVeTt7U/eY4J3RenaDawCRzgLj3kpIpfENW1v/TM1Q6jDQL1UIfOHfZfpY+pcQcxbY0EgpPTrYQ8QL5/LelGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NbY6NG6/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbY6NG6/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RoVa9dxqACSdBBc9RiLcnsqg8L3EHSWBbwPTgAJYlOg=; b=NbY6NG6/v+bC3MuNiZN4cE28va
	HQc+HJctv4Lhx4+MllJluCtEFC+L4SOCZ8IoUKcGWO6qg+pL+ZR9jqE+vRJsANQaE6yMHrcfeFfn3
	0+/tqZ4eO8P54jnE+3OLmug7OLvmb55Ez7GdB+IfRXw34ZIDU0ScBQQawLuZnt/I4VnMmgKxk3aVJ
	w4qxegA26HWm8n4jdQsyC7yCEuwt9/kJaqoeIKJU74ohigXv+y7WvUfYnjTTRkd80xkkP7qJ5zowL
	CMFHV6N8ctpfu5cnRfDR9EAN9kcvQVG95gwjLxxa46IltUsnijDBoNtHR/UD5mZ1wtMfPWYJx5FFi
	xZEZ2o2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9fRx-0000000G1zG-270n;
	Thu, 24 Sep 2026 09:09:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 66DDF3006DD; Thu, 24 Sep 2026 11:09:04 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:09:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <20260924090904.GJ2009045@noisy.programming.kicks-ass.net>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
 <20260924075925.GE4121620@noisy.programming.kicks-ass.net>
 <05319013-86e6-4a80-bb8f-385657cee410@amd.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05319013-86e6-4a80-bb8f-385657cee410@amd.com>

On Thu, Sep 24, 2026 at 01:40:27PM +0530, K Prateek Nayak wrote:
> On 9/24/2026 1:29 PM, Peter Zijlstra wrote:
> >>   Almost like switching_to_scx(), except it needs to change ctx->queued in case
> >>   of p->is_blocked. Hence a new callback ran before sched_change_begin().
> > 
> > And I wonder, would something like so work?
> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index adcc9264c0c6..3e7691d24930 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11215,8 +11215,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
> >  	 */
> >  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
> >  
> > -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
> > -		p->sched_class->switching_to(rq, p);
> > +	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
> > +		bool block = p->sched_class->switching_to(rq, p);
> > +		if (block && p->is_blocked) {
> 
> Shouldn't this also check for "ctx->queued"?
> 
> > +			block_task(rq, p, READ_ONCE(p->__state));
> 
> Otherwise we may block an already off rq task.
> 
> > +			ctx->queued = false;
> > +		}
> > +	}

Yes.

