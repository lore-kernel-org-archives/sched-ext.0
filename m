Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741226A095;
	Wed, 16 Jul 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671223; cv=none; b=qzy0vESyRYDBNER8ljZdKum6UTY72diw9lUpW5doNq3+HI7QnBqZyOa9q61D3b8MSEWt4xuDc69YNQ6mmhtToyRRe9boplI97D/u68HR2dZ8CMAAts2rscR4KyNs+8vfrnZQA2Ud2GJyGTGGDbjOccaKwAEOJjsUY2D5klari44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671223; c=relaxed/simple;
	bh=OdAg8UVik1sWPytx8f+dmqwJDHwUtMO74k2Yv62Wlg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA3seoaKpocz/AAE0PGlDjsmj66WaIEVUqL7xN+j2JA7b2BL3H2ghMLrwfX6r9WjCHPr7IyUauf5xkzsG7PiaJJnFRCUFL9a9C1f8a68Nxe8wlhn4Lu+iuy7ZDu9CAFjBwta/PkXjjZxcJAC96q/y3C4ZTufzvCAeqF3rUiwFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aV+L67EC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aV+L67EC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Kb38UOihm8MuhCk9V0Io0nyyQaSy9MIGCxhxTLd0a8=; b=aV+L67ECxAfLI7PhNgvNfDzBPK
	xqZhDgMwv2xQrdBP2NM0gAL2NDtq/M3DTmLw4Ri191byNXmyVAZpmXlhrI33WLDWc7+nXas0uTyEh
	LhliT0LrP9OjjU/ICLTyyAy9QtngtpAvyhNgw5eTh121pU5TWcfiV8X/iZhW90aS2kH3fu/ru5Lsy
	BjFxIC8OBcoX3xbXG1BvRrDkfcYirEcN37Jj+todqDvixdFqS2HVXqQptSZOxjWRJoM9iw3xAX8dt
	vJirfSZwRGqTU/iGiwv8mp6KvUhjrmccD7xs8o6D1V+KEYe0n1+vRic+eaFSVeis/lO1CCR9BIdDC
	YQXbV9qQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1qX-0000000GcdK-1LT5;
	Wed, 16 Jul 2025 13:06:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DCB5A300186; Wed, 16 Jul 2025 15:06:52 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:06:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716130652.GB3429938@noisy.programming.kicks-ass.net>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716085447.06feeb86@gandalf.local.home>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716085447.06feeb86@gandalf.local.home>

On Wed, Jul 16, 2025 at 08:54:47AM -0400, Steven Rostedt wrote:
> On Wed, 16 Jul 2025 05:46:15 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > __this_cpu_write() emits a warning if used with preemption enabled.
> > 
> > Function update_locked_rq() might be called with preemption enabled,
> > which causes the following warning:
> > 
> > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > 
> > Disable preemption around the __this_cpu_write() call in
> > update_locked_rq() to suppress the warning, without affecting behavior.
> > 
> > If preemption triggers a  jump to another CPU during the callback it's
> > fine, since we would track the rq state on the other CPU with its own
> > local variable.
> > 
> > Suggested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> > Acked-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index b498d867ba210..24fcbd7331f73 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
> >  	 */
> >  	if (rq)
> >  		lockdep_assert_rq_held(rq);
> 
> <blink>
> 
> If an rq lock is expected to be held, there had better be no preemption
> enabled. How is this OK?

The rq=NULL case; but from the usage I've seen that also happens with
rq lock held.

Specifically I think the check ought to be:

	if (rq)
		lockdep_assert_rq_held(rq)
	else
		lockdep_assert_rq_held(__this_cpu_read(locked_rq));


