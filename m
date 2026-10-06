Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46843E9FC;
	Tue,  6 Oct 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318516; cv=none; b=nFijb6m+moW1iWcJ2du2c6whdsqTJABKK06JzPAfPBN1vdp1JHDYLgrtHnfOCUqC7M/S2iMjVLzriO4Fm3OCtJDXdlfTAtTfXzIn2VzA/wmiicqQ4VU59MkPM+UgafvuLeHy7JB+8UKlCU9O9FQX5EZ1oqVezQv15533cX8p6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318516; c=relaxed/simple;
	bh=Eat3e7bEgyqpPuYTttt3jDqj9ScyKW32iZb9EdBlFxs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=HUupKGDWgnMeZJ4wltE6ISm+PERByOfr06SRSXFUJNf/CY++A8FFEGsJ0Or2bAI7yLrKKNIDlq4/LlVdjvQYRSlaVwPduGnVjuaEU7pfVhGx1xMBCSBEuS0nrisdh1kb74GlyR2zLRJ9ZmD2H9ApOezyIKcx52ljTWqJ90Yg4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofTIhkzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofTIhkzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536061F0089B;
	Tue,  6 Oct 2026 20:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791318515;
	bh=GvM0FgxFONdwECL2mCNFH+riRbJpF0PxT3FlpbUpFGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ofTIhkzfx3H9j1UwPcFYuez9eQ9oTLgqJN9YisGTKXrLzZQfdgYJDcx4v/sA3GxuB
	 e/z9LjSz3D2ctKGOly+bWJhJtbcsYFsWHNyuv0qxTGVFZyDGzKT5yKSaQa5yKy9rnp
	 D0xNaVM8qMrtzbhjge6ijzFDFCql/HLARP2o21UkPe/6m/OhTVbYXJeGibCUISJq3X
	 bUNT1ILPlB7aSvs3XVLgXC8i5D571jEUd6Fr5r7BKUjnEkb7tfoD32zvz6wYZrtj4m
	 X5t8Ghk2dxklEhftTX5lUwPTw+2hUF6QjiianS982rfTkHmOGw2wCahoQanKAZWoX0
	 gUwuZIUak52bg==
Date: Tue, 06 Oct 2026 10:28:34 -1000
Message-ID: <09a36d7e76652beedcfb891b587a9c82@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
In-Reply-To: <20261002221559.3090900-1-arighi@nvidia.com>
References: <20261002221559.3090900-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Oct 03, 2026 at 12:15:58AM +0200, Andrea Righi wrote:
> -			if (p->scx.flags & SCX_TASK_IMMED) {
> +			if ((p->scx.flags & SCX_TASK_IMMED) && !p->is_blocked) {
>  				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
>  				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);

Sorry, I steered this the wrong way. Exempting donors from IMMED entirely
overrides what the scheduler asked for on that task. An IMMED donor
preempted by a higher class now sits on this CPU's local DSQ until the CPU
gets back to it, where IMMED would have returned it to BPF to be placed
where it's picked and resolved right away. The donor and the owner it's
donating to end up waiting exactly where IMMED says they shouldn't.

I think the condition we want is to keep an IMMED donor local only when
it's about to be picked right away, which is the bookkeeping put from
proxy_resched_idle(), and to treat it like any other IMMED task otherwise.
That's what v1's proxy_put with PICK_PENDING did. Can we go back to that?
The deferred scan then needs no blocked exemption: after the bookkeeping
put, the donor is first and the rq is headed to idle, so the existing
first && rq_is_open() test keeps it. The wakeup_preempt_scx() recheck
isn't needed either, as a donor is never left where an unblocked IMMED
task couldn't stay.

> +					if (p->scx.flags & SCX_TASK_IMMED)
> +						enq_flags |= SCX_ENQ_IMMED;

Can you add a comment here? This reads as flag preservation, while the
reason is that scx_caps_for_enq() maps IMMED to SCX_CAP_ENQ_IMMED, so a
sub-sched holding only the base cap on the CPU can keep the donor local.

> -		if (next && sched_class_above(&ext_sched_class, next->sched_class) &&
> +		if (!p->is_blocked &&
> +		    next && sched_class_above(&ext_sched_class, next->sched_class) &&
>  		    scx_task_can_stay_on_cpu(rq, p)) {

I suggested this but I don't think donors should be excluded here. For a
scheduler without ENQ_LAST this never fires for a donor: dispatch_one()
keeps it through KEEP_LAST and refills its slice. A scheduler with
ENQ_LAST needs the signal on a donor as on any other last task: the CPU is
going idle with the task still queued and BPF has to trigger the
follow-up. Can you drop the !p->is_blocked?

The one put that changes is sched_proxy_block_task(), where
proxy_reset_donor() puts the still-queued donor with the owner's
execution context as @next. With a fair owner and a zeroed slice, that
takes the LAST branch and the WARN fires for a scheduler without
ENQ_LAST, on a legitimate path, so it needs handling along with the
above. One idea, which may or may not work: proxy_needs_return() dequeues
the donor before proxy_reset_donor() so that this put skips the QUEUED
block. If sched_proxy_block_task() can do the same, dequeue_block_task()
first, then the reset, then __block_task(), the put sees an unqueued task
and the ops.enqueue() and ops.dequeue() pair the current order generates
goes away too.

Thanks.

--
tejun
