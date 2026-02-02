Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151023093B6;
	Mon,  2 Feb 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066658; cv=none; b=hRdGYwRzQDktN4NPDRDGOytFWVCJ+5O/KMKVDZSWFi+TW9tlixfpn9jvEala/CdJWuDX1KSu9OesK+rNu97/SQ3jGaIFQQlgo6mJPqzBe0dUwz0X2oY50TeJ/R689s7cU6B7xbNFVi106X92U0Uc0a9YfLv+1mxfiK/xWSq7peU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066658; c=relaxed/simple;
	bh=rXW/s9uhCrJ96UtyN80fI85hBjGSkGV8q77nLD4OvGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8OFJdGePqXFPk9IcykOC0IEKWubfsF70hjba4BPSssbo/5zhGARS3oA/gLujDmPSGc2g8VnqeClVjuz+gFw/N7rNeAm0cyyOsw0QJQv6nw0VXB1pnafh3mkzSGytpyC4HYu508Bxem6Wtm59vQ3FRF8kx+geXbuU3L3za0BT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XXSrvVQw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXSrvVQw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EmGgObEjX21dQ1acAgRS0BcKdoP3bFt7sS30jm+LoJo=; b=XXSrvVQwmzTHA4IzMkLI2McJq3
	YBBTrUG4fiXvJ7GoDIKSjS6/idrWvmuVapuzsIHCYD7rLdB5hEHKqVp6Rlsv9Tp9/SdDgo09Hz6tq
	ae0jiyW9gW5M7sEow77YCSd3bTbQpvr44IQ3Smo9NetnVrSLRGZLSkFHUOYV3SdF/E0aPd4DW7mDI
	zGPuBIyCaEHPrc3yKmws21Lspr7J3GEGIIME++avHO9qveKPb+r9SZXiKQ4mUORnhXCJhGm41ciMT
	BTxNtaQdwOQDIBkSHptG99CrOIh57ZjuYHx5talTASXmrM3FZyqxjKhYnCAU9L/OJtnDvdpL2afx3
	CzcwuViQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn1BN-0000000FCpy-3VE8;
	Mon, 02 Feb 2026 21:10:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B6BE3008E2; Mon, 02 Feb 2026 22:10:04 +0100 (CET)
Date: Mon, 2 Feb 2026 22:10:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20260202211004.GM1395266@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-5-arighi@nvidia.com>
 <20260202195035.GG1282955@noisy.programming.kicks-ass.net>
 <aYEJ4BCyw1tE7xOC@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYEJ4BCyw1tE7xOC@gpd4>

On Mon, Feb 02, 2026 at 09:32:32PM +0100, Andrea Righi wrote:
> Hi Peter,
> 
> On Mon, Feb 02, 2026 at 08:50:35PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 26, 2026 at 10:59:02AM +0100, Andrea Righi wrote:
> > 
> > > @@ -3181,6 +3193,36 @@ void dl_add_task_root_domain(struct task_struct *p)
> > >  	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> > >  }
> > >  
> > > +static void dl_server_add_bw(struct root_domain *rd, int cpu)
> > > +{
> > > +	struct sched_dl_entity *dl_se;
> > > +
> > > +	dl_se = &cpu_rq(cpu)->fair_server;
> > > +	if (dl_server(dl_se) && cpu_active(cpu))
> > > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > > +
> > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > +	dl_se = &cpu_rq(cpu)->ext_server;
> > > +	if (dl_server(dl_se) && cpu_active(cpu))
> > > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > > +#endif
> > > +}
> > > +
> > > +static u64 dl_server_read_bw(int cpu)
> > > +{
> > > +	u64 dl_bw = 0;
> > > +
> > > +	if (cpu_rq(cpu)->fair_server.dl_server)
> > > +		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
> > > +
> > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > +	if (cpu_rq(cpu)->ext_server.dl_server)
> > > +		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
> > > +#endif
> > > +
> > > +	return dl_bw;
> > > +}
> > 
> > Should not this also depend on scx_enabled()? It seems unfortunate to
> > consume bandwidth if scx isn't even enabled.
> 
> Yeah, that's a good point. We can just add scx_enabled() here. Let me try
> running some tests with this.

I suspect you need some callbacks around where scx_enabled() is changed
to add/stop/remove things.

> > 
> > > @@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
> > >  	if (enq_flags & SCX_ENQ_WAKEUP)
> > >  		touch_core_sched(rq, p);
> > >  
> > > +	/* Start dl_server if this is the first task being enqueued */
> > > +	if (rq->scx.nr_running == 1)
> > > +		dl_server_start(&rq->ext_server);
> > > +
> > >  	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
> > >  out:
> > >  	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
> > 
> > So this starts the dl_server for the CPU the thing gets enqueued on, but
> > SCX being what it is, there is absolutely no guarantee its actually ever
> > pickable from there, right?
> > 
> > Does it make sense to delay this until its a DSQ_LOCAL enqueue? Or will
> > it never get that far without help?
> 
> We could probably move dl_server_start() to local_dsq_post_enq() and start
> the dl server when a task is actually dispatched to the local DSQ. I think
> it should work, but I'd like to do more extensive testing with this change.
> 
> In any case, IMHO these are improvements we can make later, even in its
> current form, this is still better than what we have and it would at least
> address the recurring bug reports about RT tasks starving scx tasks...

Yeah, we can do on top.
