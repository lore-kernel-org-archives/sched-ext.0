Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101961;
	b=T53XgL7ELBBMZerAICWzsda0LM3OV87I/4oT67qITazGSOw548q0HpW5JlA37k3KxyAG
	 nM/blDA5r5V917YeI9sAf50WBkIIY93l3yrkuufaa0PI2F8mZNlxDD7syTr/WuUhg9akY
	 Kmo+fdFjQKbuaT5mFXut6ZaeikKrASdPo1PwZ1ZIoVCMzq1/8AuXEnpqqY8oybCn0ljHv
	 ilKqwd8q9BfP1ntXSmdi9eqDc4O+8y4qsT3CdnPdGLsP7RhA5docPM9ZYdvH6/lBGkqZU
	 /zPnnpxHsBd4IS4H/ZXfE19HiDr5V7N4zV/99XJFE7l8y/SakeVZSElLCKCssmSjj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101961;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RTUNY12Kk2hu55BR/I6ei8JLRh/Fu6fPdaSExOFhP8o=;
	b=xMaw0eUjzg+WnGQJ3BubLZg7EFNzWjKRgX/QfRFJEuCV1J2Yvd/h4DlahqgRIc33kl4V
	 PPlQRXBb1wDI3inM5sOUfz8HHhqmiP01lANoye9KDdiGk3lFRBsrVdJzMpIJA55AUZ6tp
	 ydPabKJd2BtMhn2H8wPHvT4Mlo/AFUtxr0k6J152rVmRI3wFR5kKOVZZmjJ2dqUQhtvPA
	 tgaQWvFe4TWUKDFiQ9XFfrn0BPy1iOGvmrEh/xFElIzcWMP+rbip17/nTx4GxJYi4u+no
	 0SRY5CTSd93CGBdCP2dB/VYHXYce81sFy9pzZql0J0x8ChiP0KphGPge7oy0IRmKuGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TbeUJXPp;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5F606A31B;
	Tue, 27 Oct 2026 11:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E5F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TbeUJXPp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RTUNY12Kk2hu55BR/I6ei8JLRh/Fu6fPdaSExOFhP8o=; b=TbeUJXPpj+jD7aDbOqRGfRQgwF
	xzkudsFBiyBgSUoPn9OdSPUlvJYxN7OHzKQOolV8wuqw/sCWo+IhGeg6KDHX3+5bU1WjV0byKUa5U
	d8IG3KOZWbxMPl+shcCt2wgZ46JwbVZDmKiAQ/ito2DHp0riE0CaK+uLPYJO/IaPWCjAh7oA48l/4
	Z553U3ZtIL/tIl0X8V1shGtNRK+SlAzsLFa1CI1oPBZPBd+D8874dImMbPhqMN1iyj//4OzNuHeSf
	lnsOaDEXPCWZGMbHFLFT3kOf/eiPZf1ZfJcPHo6hvqtns8WGerzahDkSO7vyMCG8lpdBrhWvdL8ji
	DNH/Jx/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfjE-0000000EtKD-0CaF;
	Tue, 27 Oct 2026 11:52:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 102E63014C0; Tue, 27 Oct 2026 12:52:30 +0100 (CET)
Date: Tue, 27 Oct 2026 12:52:30 +0100
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
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
Message-ID: <20261027115230.GJ2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
 <20261027104317.GC2668564@noisy.programming.kicks-ass.net>
 <auCGbbLTw4qZS536@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auCGbbLTw4qZS536@gpd4>

On Tue, Oct 27, 2026 at 12:09:33PM +0100, Andrea Righi wrote:
> Hi Peter,
> 
> On Tue, Oct 27, 2026 at 11:43:17AM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 27, 2026 at 05:13:31AM +0100, Andrea Righi wrote:
> > > A task under a BPF scheduler can take NUMA hinting faults via
> > > task_numa_fault() and then reach numa_migrate_preferred(), which may
> > > migrate the task to its preferred node through task_numa_migrate().
> > > 
> > > The migration of such a task should always be driven by its BPF
> > > scheduler, which owns the placement of its tasks.
> > > 
> > > Keep collecting the statistics, which is what makes
> > > p->numa_preferred_nid worth reading, but skip the migration for a task
> > > owned by a BPF scheduler. The scheduler can read the preferred node and
> > > decide for itself whether moving the task is worth the cost.
> > > 
> > > For the same reason, never pick a task owned by a BPF scheduler as the
> > > swap partner of another task that NUMA balancing migrates, e.g., a fair
> > > task when the BPF scheduler runs in partial mode. Such a task is
> > > treated like a kthread on the destination CPU: the migrating task can
> > > still move there alone, but the BPF-scheduled task is left in place.
> > > 
> > > Reported-by: Vladimir Vdovin <deliran@verdict.gg>
> > > Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/fair.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 36df9a4dde534..5064c7b707f4d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
> > >  
> > >  	rcu_read_lock();
> > >  	cur = rcu_dereference_all(dst_rq->curr);
> > > +	/*
> > > +	 * Never pick a task under a BPF scheduler as the swap partner: its
> > > +	 * placement is left to that scheduler, see numa_migrate_preferred().
> > > +	 * Moving the faulting task alone to the destination is still allowed.
> > > +	 */
> > >  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> > > -		    !cur->mm))
> > > +		    !cur->mm || task_on_scx(cur)))
> > >  		cur = NULL;
> > 
> > Rather than check task_on_scx(); your argument with Prateek seems to
> > highlight that the actual check you're looking for should be something
> > like: cur->class != &fair_sched_class or somesuch, right?
> 
> Right, the actual condition is "cur is not a fair task". I used
> task_on_scx() only to avoid changing the behavior of RT/DL tasks, but
> the same arguments apply to them: their se.avg isn't updated either, so
> task_h_load(cur) is stale, and their placement is driven by their own
> class (push/pull), so fair shouldn't move them around.
> 
> So yeah... "task not in the fair class" seems the right thing to do.
> 
> > 
> > >  	/*
> > > @@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
> > >  	if (task_node(p) == p->numa_preferred_nid)
> > >  		return;
> > >  
> > > +	/*
> > > +	 * A task under a BPF scheduler is placed by that scheduler. Keep the
> > > +	 * statistics coming, which is what makes p->numa_preferred_nid worth
> > > +	 * reading, but leave the placement alone.
> > > +	 */
> > > +	if (task_on_scx(p))
> > > +		return;
> > > +
> > >  	/* Otherwise, try migrate to a CPU on the preferred node */
> > >  	task_numa_migrate(p);
> > >  }
> > 
> > I am somewhat confused on all this still, probably because I've not
> > looked at it for more than a couple of minutes at this point :-)
> > 
> > But rather than putting a callback in sched_setnuma() should you not put
> > a class call here?
> > 
> > That is; have this be:
> > 
> > 	p->class->task_numa_migrate(p);
> > 
> > and have fair set task_numa_migrate_fair(), which is the current
> > function, and then ext can implement the BPF thing.
> 
> Yeah, that'd be a much cleaner approach than special-casing ext in fair.
> But I think it gives a different signal than the sched_setnuma()
> callback.
> 
> numa_migrate_preferred() is called from task_numa_fault(), in the
> context of the faulting task, at most every numa_migrate_retry, and it
> only gets to this point when the task isn't on its preferred node. So a
> class call here means "this task is misplaced, migrate it if you want",
> repeated at each retry, even if the preferred node remains the same.

This is an important signal; it is fundamental to the whole controller.
Without a force to keep a task on its preferred node, the memory will
keep migrating around for no purpose.

A task really should be moved 'back' to its preferred node it at all
possible, and it remaining to run outside of it had better have a good
reason (like imbalance). Of course, if a task is ran elsewhere, then
eventually memory will migrate to the 'new' place and then a new
preferred node will be selected.

The new place is typically constrained by the numa distance, when its
not possible to run on the preferred node, it tries to run near, which
then limits the possible nodes and will have it converge on a new node.

The recently added cache-aware will help here, since that is a short
term signal to stick to one place, ensuring the memory migration is
also likely to be more stable and the whole thing will converge on a new
node more quickly.

> The sched_setnuma() callback instead reports when the preferred node
> changes, which is what a BPF scheduler needs to use the preferred node
> as a placement hint.
> 
> So I think the two are complementary: the class call would replace the
> task_on_scx() check here (ext can just skip the migration, or expose it
> to BPF if we think it's useful), while the notification would stay in
> sched_setnuma().

I am still not quite sure I understand why sched_ext needs the
sched_setnuma() hint for placement.

> One thing to consider: RT/DL tasks would also stop being migrated here
> (they can take hinting faults too), which seems more correct honestly:
> task_numa_migrate() decides the move based on task_h_load(p), which is
> stale for them, and their faults only come from pages scanned by other
> fair threads of the same mm, since they don't drive the scanning
> themselves.
> 
> Would that work for you?

RT/DL should definitely be ignored. 

> > Anyway, if you want to do this task_on_scx() thing like you did, its in
> > the wrong spot, that condition right above it is irrelevant if you're
> > not going to be calling task_numa_migrate(). 
> 
> Right, I'll move it before that check. It still needs to stay after the
> p->numa_migrate_retry update though, otherwise the time_after() check in
> task_numa_fault() would be always true for scx tasks and
> task_numa_placement() would be called at every hinting fault.

Just so.
