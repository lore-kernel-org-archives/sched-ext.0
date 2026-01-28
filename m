Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833ED3033F4;
	Wed, 28 Jan 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635270; cv=none; b=umhVazrIFMOPHgdogRj+taNCpwFBouGbvxWBVQzSsj842qZz1wZ7mJ5ldLS3U7mj3XY++MNbOzkX4nU4aTcOTKAt2AnhPovpCpLhedoNj017sHwwNKzyJsH6e4uYc5dU4NSqED2Ddyu891rEaPHp1l5IUmjoPzaew95Cslqu2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635270; c=relaxed/simple;
	bh=xL4iWToRfzzAGO/pEbWp6kOErE9kS07td9k8UslbXkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+75WgZkMyy9CUQOmY/+HPI6ZFKQs3gvnyObqmKM0JsOWDQVaIkl0yOxdjLrrWmoi1OD9rcLz7vS+mJwaeEWVg7NxQfUEZ0j+9AGYxkdxRE/WElQ2vvq6CEqLxfhd43sP8Fvt8+0llrIXrHxgDdO0hWN1e62hM7ilKQbrTYXdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuM0nHtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuM0nHtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E86C4CEF7;
	Wed, 28 Jan 2026 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769635270;
	bh=xL4iWToRfzzAGO/pEbWp6kOErE9kS07td9k8UslbXkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuM0nHtIqllS/FUUTSv5458CQL0vhcJ1cUe+xFgflSQI/6AJbP7Lla+vFwvtO0AcX
	 ROEzu/BQvfRpuqr3AyzWC4w8PuH3KfAlSSRPLuVq4NXHxt1K2DHupbrtwpfcuuPIvL
	 WV3iYUjovzYBZlpOVJQUaXh3zGCp9OIEZx/RFM7HMoHSCAfz3p8DIOOQB/j3URUgZT
	 Kw7bsR62yVFaAV5RLZVMidWZHtdJYkF0j3Ve5cXsFw0Gfxz8Bpgw9diCVPJckX7893
	 YrHVtmbYAWLuOfExCBw/HKWmWw443s43O/qhwB4WhnucJtAV5yhiaZrB9zTRnG4SUx
	 UqLQAAlcQGaWg==
Date: Wed, 28 Jan 2026 11:21:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aXp9xSpYhaysBLQ2@slm.duckdns.org>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126084258.3798129-2-arighi@nvidia.com>

Hello,

On Mon, Jan 26, 2026 at 09:41:49AM +0100, Andrea Righi wrote:
> @@ -1287,6 +1287,20 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
>  
>  	p->scx.ddsp_enq_flags |= enq_flags;
>  
> +	/*
> +	 * The task is about to be dispatched. If ops.enqueue() was called,
> +	 * notify the BPF scheduler by calling ops.dequeue().
> +	 *
> +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> +	 * Mark that the dispatch dequeue has been called to distinguish
> +	 * from property change dequeues.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> +		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
> +	}

1. When to call ops.dequeue()?

I'm not sure whether deciding whether to call ops.dequeue() solely onwhether
ops.enqueue() was called. Direct dispatch has been expanded to include other
DSQs but was originally added as a way to shortcut the dispatch path and
"dispatch directly" for execution from ops.select_cpu/enqueue() paths. ie.
When a task is dispatched directly to a local DSQ, the BPF scheduler is done
with that task - the task is now in the same state with tasks that get
dispatched to a local DSQ from ops.dispatch().

ie. What effectively decides whether a task left the BPF scheduler is
whether the task reached a local DSQ or not, and direct dispatching into a
local DSQ shouldn't trigger ops.dequeue() - the task never really "queues"
on the BPF scheduler.

This creates another discrepancy - From ops.enqueue(), direct dispatching
into a non-local DSQ clearly makes the task enter the BPF scheduler and thus
its departure should trigger ops.dequeue(). What about a task which is
direct dispatched to a non-local DSQ from ops.select_cpu()? Superficially,
the right thing to do seems to skip ops.dequeue(). After all, the task has
never been ops.enqueue()'d. However, I think this is another case where
what's obvious doesn't agree with what's happening underneath.

ops.select_cpu() cannot actually queue anything. It's too early. Direct
dispatch from ops.select_cpu() is a shortcut to schedule direct dispatch
once the enqueue path is invoked so that the BPF scheudler can avoid
invocation of ops.enqueue() when the decision has already been made. While
this shortcut was added for convenience (so that e.g. the BPF scheduler
doesn't have to pass a note from ops.select_cpu() to ops.enqueue()), it has
real performance implications as it does save a roundtrip through
ops.enqueue() and we know that such overheads do matter for some use cases
(e.g. maximizing FPS on certain games).

So, while more subtle on the surface, I think the right thing to do is
basing the decision to call ops.dequeue() on the task's actual state -
ops.dequeue() should be called if the task is "on" the BPF scheduler - ie.
if the task ran ops.select_cpu/enqueue() paths and ended up in a non-local
DSQ or on the BPF side.

The subtlety would need clear documentation and we probably want to allow
ops.dequeue() to distinguish different cases. If you boil it down to the
actual task state, I don't think it's that subtle - if a task is in the
custody of the BPF scheduler, ops.dequeue() will be called. Otherwise, not.
Note that, this way, whether ops.dequeue() needs to be called agrees with
whether the task needs to be dispatched to run.

2. Why keep %SCX_TASK_OPS_ENQUEUED for %SCX_DEQ_SCHED_CHANGE?

Wouldn't that lead to calling ops.dequeue() more than once for the same
enqueue event? If the BPF scheduler is told that the task has left it
already, why does it matter whether the task gets dequeued for sched change
afterwards? e.g. from the BPF sched's POV, it shouldn't matter whether the
task is still on the local DSQ or already running, in which case the sched
class's dequeue() wouldn't be called in the first place, no?

Thanks.

-- 
tejun
