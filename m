Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777B3B8921;
	Fri, 16 Oct 2026 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179464; cv=none; b=pYWwlzO40+9aMqoCJVxwgDPj+ZfXJIolsqA8IGsFJ+3WP07xXNSsf6QxmAECZ8yr6mBM24b7pNDHGJoM24NXAz1dzrVJCAw4zaJgZkHT5EeR+1tAEKBn19dTc1XxkMXF2LVLX+G5zeXlfrRrdsAzhCNXsZ7N8o4WedasML7ZrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179464; c=relaxed/simple;
	bh=BUwsHumKybWCq/wn91B8jFTYl49CuWl9sag841KH7Ic=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=bTh9xPW07QPqpb+ek9cgQ9xGpDKEsuB/fYQdTmAI7UzCopBFSCpkK4kJHysxnoGy662zJmvxlpHWsK9DZ9KvJG7XgEm8COAbU7V05QmDoQ9CkpWK81d9oY6tFoUtWnkVhrSDY8G77BB+Gw6cczEimAY55G9NW4W1zQr+piSY0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzMeA3N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzMeA3N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE961F000C4;
	Fri, 16 Oct 2026 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792179461;
	bh=WfKgb3D9f7fpa4OP90c2QmPT32pLI59VaWxTPr/HY7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VzMeA3N0oe4svZjrvu/LDCuO0fcjWviKbDNMmdYK8a61KjuT+3VTpkAe8/lRgORaj
	 iwBohgY8s6ykFdQ70nvfE3R7+Mu+YxrQcT6BbhkDoBuED83b6zd3aLwWfXIip7bx1D
	 lBHBaZ7PDmTPG6wk63hqPzycyTIoXYZRDR7NM0TypiXPe5aoa8UV7daaK99jKkyJce
	 ZnPckX8VlwtIHLw6C6SovdLMiaGkWMWGeMfan95Kd/MZi/5myG36LXbplsWnVgoJt9
	 uHyTkhxk/+BULGiqhiw9TwO1kwOBzquQQfh9cLauEkJ9BBiAM6JFnjnY8oidk4BTP4
	 OiD8POSVUq6+A==
Date: Fri, 16 Oct 2026 09:37:40 -1000
Message-ID: <f010daaee76c0fe812d0b86d341fab14@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Keep proxy donors local through core-sched retries
In-Reply-To: <20261015101935.2844323-1-arighi@nvidia.com>
References: <20261015101935.2844323-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

The following is a Claude-generated review.

Everything below is from reading the code and nothing has been
reproduced.

On Thu, Oct 15, 2026 at 12:19:35PM +0200, Andrea Righi wrote:
> Fixes: 7ab553756463 ("sched_ext: Keep proxy donors with slice left on the local DSQ")

This commit doesn't exist. The parent landed in sched_ext/for-7.4 as
67d0d8d018f3.

> +	if (rq->donor == rq->idle) {
> +		struct task_struct *first;
> +
> +		first = list_first_entry_or_null(&rq->scx.local_dsq.list,
> +						 struct task_struct, scx.dsq_list.node);
> +		if (first && (first->scx.dsq_flags & SCX_TASK_DSQ_PROXY_IDLE) &&
> +		    sched_cpu_cookie_match(rq, first))
> +			return true;
> +	}

Does this need the mark? With rq->donor == rq->idle and next_class at
ext, the next pick takes the local DSQ head no matter how it got there.
Non-proxy IMMED tasks hit the same spurious reenq today. For example,
two IMMED wakeups land on an idle CPU. The first insert sees the rq open
and rq_owned_post_enq() raises next_class to ext. The second makes nr 2
and schedules a reenq, which task_woken_scx() runs. reenq_local() then
sees the rq closed and sends the first task back to BPF even though it's
at the head.

Testing just the head's cookie while the donor is idle would cover both,
and SCX_TASK_DSQ_PROXY_IDLE with its set and clear could go away.

Also, first_local_task() is the same lookup if moved up. As the block
only runs with next_class at ext, maybe it belongs below the "@rq is
either picking, in transition to, or running an SCX task." comment?

> +/*
> + * A proxy retry can bypass pick_task_scx() and leave PROXY_PENDING set.
> + * A cookie mismatch means core scheduling forced this CPU idle, not that
> + * proxy resolution put a selected donor through idle.
> + */
>  static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  			      struct task_struct *next)
>  {
>  	struct scx_sched *sch = scx_task_sched(p);
>  	bool proxy_put = p->is_blocked && next == rq->idle &&
> -			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
> +			 (rq->scx.flags & SCX_RQ_PROXY_PENDING) &&
> +			 sched_cpu_cookie_match(rq, p);

A forced idle can also happen with a matching cookie. If the core-wide
max is untagged, core_cookie is 0 and pick_next_task() forces a
mismatching rq idle without trying sched_core_find(), so an untagged
donor still passes sched_cpu_cookie_match(). For example, with CFS
bandwidth control:

1. A tagged fair task H on this rq is throttled. A sibling's core-wide
   pick selects the untagged blocked donor D for this rq under an
   untagged max.

2. H is unthrottled. The unthrottle re-enqueues H with
   enqueue_task_fair(), which doesn't bump core_task_seq, so this rq
   still takes the core_pick fastpath and set_next_task_scx() sets
   SCX_RQ_PROXY_PENDING for D.

3. find_proxy_task() abandons the pick without a put and __schedule()
   goes to pick_again.

4. H wins pick_task() on this rq, so pick_task_scx() doesn't run. The
   sibling's untagged task is still the max, core_cookie is 0 and this
   rq is forced idle.

5. put_prev_task_scx() sees the stale flag and a matching cookie and
   parks D as a proxy put.

Maybe clear SCX_RQ_PROXY_PENDING where find_proxy_task() abandons the
pick instead? None of the existing hooks fit the pick_again site, so
it'd need a small new one, but the flag then can't go stale and the
cookie test isn't needed.

And maybe retitle? The reproduced bug is an SCX wakeup during the proxy
idle rather than a core-sched retry, and "retries" reads like
SCX_RQ_PROXY_RETRY.

Thanks.

-- 
tejun
