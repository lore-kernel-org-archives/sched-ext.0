Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD92279DCA;
	Sun, 30 Nov 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764502357; cv=none; b=pARioo75zBWEsTfoiBGgs3tb62cQrhnsfIkyG0Q9V0h1EcqDD+p/qzCrFvD1iRq3hDURmo4Coq00iKhICSlWZL5HWI//UDk+s4TRs8PaeiylBeNHEcASvxZXhNoEWpVEiIVSHoZfZZJSvcgmnIm6s/kG6hAZftNrciL6wWNFzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764502357; c=relaxed/simple;
	bh=ir8XiEIbc8xggNeNqKz4TfPouxvPP3gccdhWVXS4GOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adnnm0TblG7uzay6xBVkLztciPMuSECwOUGHqfE4M79ANU0E4fP1uRGQO6qfaKH5O5hxU95kFKNR2h7Eh9rTd68kYpgrdeHGRRxitnz6JkQyR3Q7vBZ/J81Lh9aBedO+IRZHCd9rhs6UbBzOh+HQ0IvzBVWwNguLYa2MEetTs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nCxWfOQ2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nCxWfOQ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QDFeoargtRJ0WQT3mHQ5gBdj/l5CLm2IU3H5mUrAJHo=; b=nCxWfOQ2iuCZjj28c63yxR0mkW
	L1bWdNUy2dKCAE/WqDF/MQGbbD6akue2UcEyCQj9yNgF1K0aJSSVNWvzIUcxswkjbomRUM2nhywLC
	3SxXrJrn73/6gydg9z3+VxC9QX3uJum080nNZLNy8imSoMwiphFcNpl+spP6u5mYhIQqY3F753vb9
	ttSLc1XyvqjAz1GkxbG/AZ50EXzMrFuZ9/iAi+GE8/zMxiQILw+iEtJ0pjH+Eirw0+hVADUvwgFOw
	7OS42ZeVZUJV2kw2QoJMFcIBGI/z4I+gnOgftXR0oPvayLMgMHYZALvg8fvVNE5wUmeIjvwtpzmS9
	a6xyRbHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPeni-0000000EFm4-2d8N;
	Sun, 30 Nov 2025 10:37:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 409493002A6; Sun, 30 Nov 2025 12:32:27 +0100 (CET)
Date: Sun, 30 Nov 2025 12:32:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, mingo@kernel.org,
	vincent.guittot@linaro.org
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
Message-ID: <20251130113227.GB411057@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
 <3d9d0e43-b73c-4bed-b59c-dc1387d183e4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d9d0e43-b73c-4bed-b59c-dc1387d183e4@linux.ibm.com>

On Sat, Nov 29, 2025 at 11:38:49PM +0530, Shrikanth Hegde wrote:

> > @@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struc
> >   {
> >   	struct task_struct *donor = rq->donor;
> > -	if (p->sched_class == donor->sched_class)
> > -		donor->sched_class->wakeup_preempt(rq, p, flags);
> > -	else if (sched_class_above(p->sched_class, donor->sched_class))
> > +	if (p->sched_class == rq->next_class) {
> > +		rq->next_class->wakeup_preempt(rq, p, flags);
> > +
> > +	} else if (sched_class_above(p->sched_class, rq->next_class)) {
> > +		rq->next_class->wakeup_preempt(rq, p, flags);
> 
> Whats the logic of calling wakeup_preempt here?
> 
> say rq was running CFS, now RT is waking up. but first thing we do is
> return if not fair_sched_class. it is effectively resched_curr right?

Yes, as-is this patch seems silly, but that is mostly to preserve
current semantics :-)

The idea is that classes *could* do something else. Notably this was a
request from sched_ext. There are cases where when they pull a task from
the global runqueue and stick it on the local runqueue, but then get
preempted by a higher priority class (say RT) they would want to stick
the task back on the global runqueue such that another CPU can select it
again, instead of having that task linger on a CPU that is not
available.

This issue has come up in the past as well but was never addressed.

Anyway, this is just foundational work. It would let a class respond to
loosing the runqueue to a higher priority class.

I suppose I should go write a better changelog.

> 
> >   		resched_curr(rq);
> > +		rq->next_class = p->sched_class;
> 
> Since resched will happen and __schedule can set the next_class. it is necessary to set it
> even earlier?

Yes, because we can have another wakeup before that schedule.

Imagine running a fair class, getting a fifo wakeup and then a dl
wakeup. You want the fair class, then the rt class to get a preemption
notification.

> > @@ -3899,6 +3876,7 @@ void move_queued_task_locked(struct rq *
> >   	deactivate_task(src_rq, task, 0);
> >   	set_task_cpu(task, dst_rq->cpu);
> >   	activate_task(dst_rq, task, 0);
> > +	wakeup_preempt(dst_rq, task, 0);
> 
> Whats the need of wakeup_preempt here?

Everything that places a task on the runqueue should do a 'wakeup'
preemption to make sure the above mentioned class preemption stuff
works.

It doesn't really matter if the task is new due to an actual wakeup or
due to a migration, the task is 'new' to this CPU and stuff might need
to 'move'.

IIRC this was the only such place that missed the check.
