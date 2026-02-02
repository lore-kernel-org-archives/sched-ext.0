Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D428467C;
	Mon,  2 Feb 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061851; cv=none; b=h4YbUJ+HNnCWEXBfeWgD0sukiImkYvlEVN10UK0iToAz9yKNfnoiR8zjS/ivzCKE+R50zkfGshZ50kdxipAkvbutJgPSxav8NTuxzuM9znl55i2HvjeasdCKmGPrgfYhK6IPfQMo5k3T/yqZqa4g84Eum0HrrD1XiWWCQp2OY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061851; c=relaxed/simple;
	bh=wT1r0GMeFOXN6xd4igSqukBcbOPz+w5+SmgsvjRr9L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXdy+WGVVLVGj4fhcwkZ6WTXCptb37nHFtWw4ijUBL3NlfDIZbKddBuV274KL6c1A0ATkYPlnhSGtoj7Pr14i5PYy3rzOEJ69nfOz9xhIt3+W8HjjGZsxDQTWRUM6zXgsI66A0B+1FHMc9t7phdHjzACegpYkFgigvgNaD9rvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DLyRNOwk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DLyRNOwk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1KIi/fpdXE5qZmmsbEgV1jmdXHy0c8yiXeeX6qAh54=; b=DLyRNOwkwFORcprShhLzVRIl3A
	Z8KNPZ310aNpwkQYt/NQSYZzCeVqOzD1/mogx8zcFYPu+gL9kK6hBw7NPWeXJL/mWKLRMWWdgUkHN
	GDeQs2KPjXtVfG82a58N7jU5cX2GZ09Qfa/r8DyXmaszLS3XEErq9M1IrD+d6l9VzE8cgXH0BUQ/4
	IkUxFMTK/4a6F9NCMwtBypZGn3f5o0EOd4I9rF9WitWU0qJV0lYy08k94TttAShK9BrJTW6xcUBTB
	j2dweM26IHNmf2a0ttJ3WqJbLG9lrLnOf32KG16akvBb/iTYMErK3T7lD317Vsxmiy4U1qz0PWLdW
	8W8Iaj2A==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmzwT-0000000Gz4E-0TfR;
	Mon, 02 Feb 2026 19:50:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE4943008E2; Mon, 02 Feb 2026 20:50:35 +0100 (CET)
Date: Mon, 2 Feb 2026 20:50:35 +0100
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
Message-ID: <20260202195035.GG1282955@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126100050.3854740-5-arighi@nvidia.com>

On Mon, Jan 26, 2026 at 10:59:02AM +0100, Andrea Righi wrote:

> @@ -3181,6 +3193,36 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  }
>  
> +static void dl_server_add_bw(struct root_domain *rd, int cpu)
> +{
> +	struct sched_dl_entity *dl_se;
> +
> +	dl_se = &cpu_rq(cpu)->fair_server;
> +	if (dl_server(dl_se) && cpu_active(cpu))
> +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	dl_se = &cpu_rq(cpu)->ext_server;
> +	if (dl_server(dl_se) && cpu_active(cpu))
> +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> +#endif
> +}
> +
> +static u64 dl_server_read_bw(int cpu)
> +{
> +	u64 dl_bw = 0;
> +
> +	if (cpu_rq(cpu)->fair_server.dl_server)
> +		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	if (cpu_rq(cpu)->ext_server.dl_server)
> +		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
> +#endif
> +
> +	return dl_bw;
> +}

Should not this also depend on scx_enabled()? It seems unfortunate to
consume bandwidth if scx isn't even enabled.



> @@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	if (enq_flags & SCX_ENQ_WAKEUP)
>  		touch_core_sched(rq, p);
>  
> +	/* Start dl_server if this is the first task being enqueued */
> +	if (rq->scx.nr_running == 1)
> +		dl_server_start(&rq->ext_server);
> +
>  	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
>  out:
>  	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;

So this starts the dl_server for the CPU the thing gets enqueued on, but
SCX being what it is, there is absolutely no guarantee its actually ever
pickable from there, right?

Does it make sense to delay this until its a DSQ_LOCAL enqueue? Or will
it never get that far without help?
