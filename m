Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F8369224;
	Tue, 15 Sep 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499405; cv=none; b=N5JpLyHpZMrTw/V+RFQTL7YkvKEwdF2JmzFoPx9HdzWZNxGU8rtgGXsju5X7mj8iJiW9yKVmJKk/SebW+0QQDUnsGcTS2RZvK9Y46zdfe0mYB44Xa03npKpiLjPezgEJWAPdNKoZ9xg8gIerLnm+os4gqkfFqgsTr2Tizyhhmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499405; c=relaxed/simple;
	bh=Ue5mWf8mDUirgpnnhuzG3Gp9XqpTaq55Bk6NCZCmSCs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=S1g2iz/OB7BIDo63B5Gvl1vTVUMDc9wFV813mY+IOid4ZlQu92cFxJC0kI6RNns0RJxDQqsUiexr5rxNf3I568Wdw7TtgTlPED5hRDMqgAbc0jc1QfnrcEsZ95BbgCkHOWaX5iL+JAgP76KDZm45IVRzQubjyWETPFt6XQzTfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtpu+0+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtpu+0+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E6C1F000FF;
	Tue, 15 Sep 2026 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789499403;
	bh=f6PhqPOqbbuKPz7kclrcySJw5xGN2l1h8uJlpci9x3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jtpu+0+SlA/diRv/ZK13CfBwaEZvjKeX//CEtmSPLbEyLQO+JjsTgVxHppvABQgkg
	 YYxAATuG1x2OjHyLWVbQo1JVHH957x1gEvgT8E6lz6gBnpbk5ADqI0fIvZEMD5AuX4
	 xZ/d31r8Vbf8/xtqii2s4npOOPp/aWTOJMEXs14ojZUK+sKWdBoV0hZNRqK833I/rs
	 jcdeoXzBBVpBN80qjPTJ3a4txxBsy//oAirvXu1edZBR0+fZ7c3j81PJ1Cg/wLCnlS
	 1T6qkrgGoEWkmhNRYMkayK9h5IbrQRa7wf02Ma1DFEcAYP1p8wtyX91mQcHIJH8aJm
	 e9yTUEkP1I/gw==
Date: Tue, 15 Sep 2026 09:10:02 -1000
Message-ID: <e69a808d40739510ffa7d2c7f053a9e8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, arighi@nvidia.com, void@manifault.com,
 changwoo@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched_ext: Don't run ops.dequeue() with a DSQ
 lock held
In-Reply-To: <20260915130334.714388-2-fangqiurong@kylinos.cn>
References: <aqkQ1MtqtqnS0wUs@gpd4>
 <20260915130334.714388-1-fangqiurong@kylinos.cn>
 <20260915130334.714388-2-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Tue, Sep 15, 2026 at 09:03:33PM +0800, Qiurong Fang wrote:
> ops.dequeue() is called with the source user DSQ's lock still held on
> the consume and move paths (scx_consume_dispatch_q(),
> move_task_between_dsqs()) and with the terminal global/bypass DSQ's
> lock still held in scx_dispatch_enqueue(). A BPF scheduler that locks
> the same DSQ from ops.dequeue() - e.g. by iterating it with
> bpf_iter_scx_dsq, which takes the DSQ lock on every step -
> self-deadlocks.

The self-deadlock only exists on the two user DSQ paths. ops.dequeue() can
only call the "any" kfuncs and none of them can lock a builtin DSQ, so the
global/bypass path can't deadlock. Moving it out is still right because all
DSQ locks share one lockdep class and iterating any user DSQ from there
trips the recursion check. Please describe it that way.

> Move the invocation after the DSQ unlock on all three paths.
> SCX_TASK_IN_CUSTODY is cleared under the lock so that the callback is
> invoked exactly once; it is not ordered against consumption of the
> task and may run after the task has been moved to, or consumed from,
> a terminal DSQ.

The last sentence and the matching doc addition confuse more than they help.
The only thing that matters is that the task can't start running or be
re-enqueued before ops.dequeue() completes. Please state that invariant
instead or drop it.

That invariant currently has a hole which this patch widens. After the
unlock, the task sits in an unlocked DSQ with ops_state still DISPATCHING
until the final store, now for the whole callback, and the reenq paths don't
wait on DISPATCHING the way ops_dequeue() does. That's from ebf1ccff79c4 and
I'll fix it separately. No need to address it here.

>  		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
> -			call_task_dequeue(sch, rq, p, 0);
> +			call_dequeue = task_leave_custody(p);
>  		else
>  			p->scx.flags |= SCX_TASK_IN_CUSTODY;
>
>  		raw_spin_unlock(&dsq->lock);
> +
> +		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
> +			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);

This leaves call_task_dequeue() with two callers, both of which are these
two lines without the unlock in between. Please open-code them too and drop
call_task_dequeue(). Each ops.dequeue() invocation being explicit is better
than a helper which may or may not invoke it depending on a flag cleared
elsewhere.

> +static struct scx_dispatch_q *
> +__scx_move_local_task_to_local_dsq(struct scx_sched *sch,
> +				   struct task_struct *p, u64 *enq_flags,
> +				   struct scx_dispatch_q *src_dsq,
> +				   struct rq *dst_rq)

The split isn't necessary. Unlock @src_dsq right after
scx_task_unlink_from_dsq() in the two callers and call
scx_move_local_task_to_local_dsq() as is, dropping its lockdep assert on
@src_dsq. @p is off the DSQ and its rq is locked, so nothing can reach it in
between.

Also, please add Cc: stable # v7.1+.

Thanks.

--
tejun
