Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41732ED54;
	Thu,  5 Feb 2026 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332225; cv=none; b=fjB31cJhm/z8mL2xFX23Hv5ciRMFiJFfDAmZaXP/wmf/WvJ2JhJ9RV2K54yqqGvrP3NRgGzOA6hsbo6WQ1sU3rCj8jH5WwhNBMy1R1gd3Eg+mB0OWV6gWznjvB1S1lVWHnUZhLIQuLwUXGSOdFKJYN4qujeaIRSXm6P5Kqg+s8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332225; c=relaxed/simple;
	bh=AWg//+9hGHmsMie8cqVo7J6PjSr/7pD9tIZbQtNXQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc/9E2FhEVm5JOmMMeIoQ723BePF02QGP27PFnigTdvSxuQxd4/+42w/jyMWnM4VaeK3sihrBVxOVikyN1Vp+UmSvwd07J3INqtpTbMJWCCL9sNEjqFnmp+RqSxc5Y0sxrD0PqIlfKiReXqfKo4OAe9G6Ey1RpAhl7ItEEVI4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEGuf9Tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEGuf9Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043F4C4CEF7;
	Thu,  5 Feb 2026 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770332225;
	bh=AWg//+9hGHmsMie8cqVo7J6PjSr/7pD9tIZbQtNXQsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEGuf9TfbhxuJpHosxUX4UYLlOT3Bw5EGffAyugQZpJnJm9mbrw5DwGh7JBIrm1Zp
	 /SLbLZ7t+9ZhRykf6OdnUpWxDJaNbrwwz3olb/L/IQTyXYRVf/5+grRaTBAWXCT2VR
	 M+U4oBAZe39fitnaBC6Q6hN0KEjXYI9ioAgmuQc2LBMdoPWHYQh8skLX61Vg2Qq5A4
	 0s9R12Uq/+wSj+hkb8SX6E6c75UrTd7vtdb8dI71xgwWzjgVduiXwGPK52vTNGOpTL
	 BGeso+fu5e2ME3ltJcOWbBG3n0L7uMaZ19Zg5B9+q3AyIrCxMoadA2fT+FWgOX38Ke
	 hDyof6O/MEmsw==
Date: Thu, 5 Feb 2026 12:57:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYUgQGvzJsoEaDZL@slm.duckdns.org>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <aYPW121Y6vGtmtST@slm.duckdns.org>
 <aYTH5XT0YFkznqvv@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYTH5XT0YFkznqvv@gpd4>

Hello,

On Thu, Feb 05, 2026 at 05:40:05PM +0100, Andrea Righi wrote:
...
> > It shouldn't be returned, right? set_cpus_allowed() dequeues and
> > re-enqueues. What the seq invalidation detected is dequeue racing the async
> > dispatch and the invalidation means that the task was dequeued while on the
> > async buffer (to be re-enqueued once the property change is complete). It
> > should just be ignored.
> 
> Yeah, the only downside is that the scheduler doesn't know that the task
> has been re-enqueued due to a failed dispatch, but that's probably fine for
> now.

Yeah, but does that matter? Consider the following three scenarios:

A. Task gets dispatched into local DSQ, CPU mask gets updated while in async
   buffer, the dispatch is ignored and then the task gets re-enqueued later.

B. The same as A but the CPU mask update happens after the task lands in the
   local DSQ but before starts executing.

C. Task gets dispatched into local DSQ and starts running, CPU mask gets
   updated so that the task can't run on the current CPU anymore, migration
   task preempts the task and it gets enqueued.

A and B woould be indistinguishible from BPF sched's POV. C would be a bit
different in that the task would transition through ops->running/stopping().

I don't see anything significantly different across the three scenarios -
the task was dispatched but cpumask got updated and the scheduler needs to
place it again.

...
> > Now, maybe we want to allow BPF schedulre to be lax about ops.dequeue()
> > synchronization and let things slide (probably optionally w/ an OPS flag),
> > but for that, falling back to global DSQ is fine, no?
> 
> I think the problem with the global DSQ fallback is that we're essentially
> ignoring a request from the BPF scheduler to dispatch a task to a specific
> CPU. Moreover, the global DSQ can potentially introduce starvation: if a
> task is silently dispatched to the global DSQ and the BPF scheduler keeps
> dispatching tasks to the local DSQs, the task waiting in the global DSQ
> will never be consumed.

While starvation is possible, it's not very likely:

- ops.select_cpu/enqueue() usually don't direct dispatch to local CPUs
  unless they're idle.

- ops.dispatch() is only called after global DSQ is drained.

If ops.select_cpu/enqueue() keeps DD'ing to local CPUs while there are other
tasks waiting, it's gonna stall whether we fall back to global DSQ or not.

But, taking a step back, the sloppy fallback behavior is secondary. What
really matters is once we fix ops.dequeue(), can the BPF scheduler properly
synchronize dequeue against scx_bpf_dsq_insert() to avoid triggering cpumask
or migration disabled state mismatches? If so, ops.dequeue() would be the
primary way to deal with these issues.

Maybe not implementing ops.dequeue() can enable sloppy fallbacks as that
indicates the scheduler isn't taking property changes into account at all,
but that's really secondary. Let's first focus on making ops.dequeue()
working properly so that the BPF scheduler can synchronize correctly.

...
> > I wonder whether we should define an invalid qseq and use that instead. The
> > queueing instance really is invalid after this and it would help catching
> > cases where BPF scheduler makes mistakes w/ synchronization. Also, wouldn't
> > dequeue_task_scx() or ops_dequeue() be a better place to shoot down the
> > enqueued instances? While the symptom we most immediately see are through
> > cpumask changes, the underlying problem is dequeue not shooting down
> > existing enqueued tasks.
> 
> I think I like the idea of having an INVALID_QSEQ or similar, it'd also
> make debugging easier.
>
> I'm not sure about moving the logic to dequeue_task_scx(), more exactly,
> I'm not sure if there're nasty locking implications. I'll do some
> experiments, if it works, sure, dequeue would be a better place to cancel
> invalid enqueued instances.

I was confused while writing above. All of the above is already happening.
When a task is dequeued, it's OPSS is cleared and the task won't be eligible
for dispatching anymore. The only "confused" case is where the task finishes
reenqueueing before the previous dispatch attempt is finished, which the BPF
scheduler should be able to handle once ops.dequeue() is fixed.

Thanks.

-- 
tejun
