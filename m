Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B53EF678;
	Wed,  1 Apr 2026 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083620; cv=none; b=IRk5Da1QSKj117Lve+Qy69QV1TKQSNz4xrJjntTthqbi/mf79WekUnT7hrgFPnrmnMqm1EQLMCwWZDs9e1fLnkuXi5ITyX09piAnQ5iqjWjXE54kc24uWTR5bxM8Ir8CSJWyZsUqXOPIILIbHt8p4Uf+inK083QG4Bf4DwECMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083620; c=relaxed/simple;
	bh=MopEf0v1y6xc2c9ZBVa8t29zwCWtHXPLtl+pd9WGjSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8dd11FPnmjK6S/BFPM6Yu52atzuP3R4kxU/reKQ0/Rmbi5xxRSMLfBsNhHp4gPmVC4l3xu/QdAtlvWEmQUCttfGie9hR4rWkdEszdgFb3W1YHC2hkHS4H4JSOejTVkQR0KbJikZP8Uv4rh+F1UUtLX8FeS/1JoIQADAE7OxGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYYibKN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYYibKN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B459C4CEF7;
	Wed,  1 Apr 2026 22:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775083619;
	bh=MopEf0v1y6xc2c9ZBVa8t29zwCWtHXPLtl+pd9WGjSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYYibKN9Hpm6jLRydAwriRaX0P998GyttwYHOCdWsx9vzm8sG/SUcMUP6iedsxUFo
	 2yORflsL93jNdAthTHbGi35RvPK2OneQcZkRwtWu+g6EQD/kb41mGqzY4AN4gDfkRv
	 YOL5WvnGIAC8wr7fHTfne4EQ+BLSKEsqBUeuE7QSDdKxqqF54BHGW7I/PTJ5ErpUsD
	 VNZbNUvdMagBdnIF35iuZ9nBuP53dM3yQMsrVWgiL7F2IvsFXr71oyjvjknSGfWDDX
	 X0VGjVE6Fcf9ZSdk/HAyD+lvI/6F4lOsK2NDpVWselh17SW09rI4FT6DWY/V12NJ6X
	 AmfghTKrKx+FQ==
Date: Wed, 1 Apr 2026 12:46:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, patsomaru@meta.com
Subject: Re: [PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Message-ID: <ac2gYobvvAXSPjxd@slm.duckdns.org>
References: <20260401215619.1188194-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401215619.1188194-1-arighi@nvidia.com>

Hello,

(cc'ing Patrick Somaru. This is the same issue reported on
https://github.com/sched-ext/scx/pull/3482)

On Wed, Apr 01, 2026 at 11:56:19PM +0200, Andrea Righi wrote:
> @p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) in three
> scenarios, causing a spurious WARN_ON_ONCE() in mark_direct_dispatch()
> when the next wakeup's ops.select_cpu() calls scx_bpf_dsq_insert():
> 
> 1. Deferred dispatch cancellation: when a task is directly dispatched to
>    a remote CPU's local DSQ via ops.select_cpu() or ops.enqueue(), the
>    dispatch is deferred (since we can't lock the remote rq while holding
>    the current one). If the task is dequeued before processing the
>    dispatch in process_ddsp_deferred_locals(), dispatch_dequeue()
>    removes the task from the list leaving a stale direct dispatch state.
> 
>    Fix: clear ddsp_dsq_id and ddsp_enq_flags in the !list_empty branch
>    of dispatch_dequeue().
> 
> 2. Holding-cpu dispatch race: when dispatch_to_local_dsq() transfers a
>    task to another CPU's local DSQ, it sets holding_cpu and releases
>    DISPATCHING before locking the source rq. If dequeue wins the race
>    and clears holding_cpu, dispatch_enqueue() is never called and
>    ddsp_dsq_id is not cleared.
> 
>    Fix: clear ddsp_dsq_id and ddsp_enq_flags when clearing holding_cpu
>    in dispatch_dequeue().

These two just mean that dequeue need to clear it, right?

> 3. Cross-scheduler-instance stale state: When an SCX scheduler exits,
>    scx_bypass() iterates over all runnable tasks to dequeue/re-enqueue
>    them, but sleeping tasks are not on any runqueue and are not touched.
>    If a sleeping task had a deferred dispatch in flight (ddsp_dsq_id
>    set) at the time the scheduler exited, the state persists. When a new
>    scheduler instance loads and calls scx_enable_task() for all tasks,
>    it does not reset this leftover state. The next wakeup's
>    ops.select_cpu() then sees a non-INVALID ddsp_dsq_id and triggers:
> 
>      WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> 
>    Fix: clear ddsp_dsq_id and ddsp_enq_flags in scx_enable_task() before
>    calling ops.enable(), ensuring each new scheduler instance starts
>    with a clean direct dispatch state per task.

I don't understand this one. If we fix the missing clearing from dequeue,
where would the residual ddsp_dsq_id come from? How would a sleeping task
have ddsp_dsq_id set? Note that select_cpu() + enqueue() call sequence is
atomic w.r.t. dequeue as both are protected by pi_lock.

It's been always a bit bothersome that ddsp_dsq_id was being cleared in
dispatch_enqueue(). It was there to catch the cases where ddsp_dsq_id was
overridden but it just isn't the right place. Can we do the following?

- Add clear_direct_dispatch() which clears ddsp_dsq_id and ddsp_enq_flags.

- Add clear_direct_dispatch() call under the enqueue: in do_enqueue_task()
  and remove ddsp clearing from dispatch_enqueue(). This should catch all
  cases that ignore ddsp.

- Add clear_direct_dispatch() call after dispatch_enqueue() in
  direct_dispatch(). This clears it for the synchronous consumption.

- Add clear_direct_dispatch() call before dispatch_to_local_dsq() call in
  process_ddsp_deferred_locals(). Note that the funciton has to cache and
  clear ddsp fields *before* calling dispatch_to_local_enq() as the function
  will migrate the task to another rq and we can't control what happens to
  it afterwrds. Even for the previous synchronous case, it may just be a
  better pattern to always cache dsq_id and enq_flags in local vars and
  clear p->scx.ddsp* before calling dispatch_enqueue().

- Add clear_direct_dispatch() call to dequeue_task_scx() after
  dispatch_dequeue().

I think this should capture all cases and the fields are cleared where they
should be cleared (either consumed or canceled).

Thanks.

-- 
tejun
