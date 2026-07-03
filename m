Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BA3D649A
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088073; cv=none; b=uh6JwDpqVjHNXpd8wBzz9dVaQRpudJ2RRplQ+t8VZ+NV22hWl4GFvr/gfVjk0OswhgtA6v4KnXnM8cIJ+N9k43YNJPxD+lJyk5Rs9zG9dHD2EBF0F5HaXEbW9OyuqED/dEQuz8c49qCBq5L0qQNt2GckrADTcemL5prxFbMbs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088073; c=relaxed/simple;
	bh=HdgSdEQhw7B+e4nfbW8UQRMn2bBZ1gTDJON/8vO3QEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVTb6R9lBKd/bShG3jPS6z4KACzp1KsaKVXfX44x8jpckvaWnKEvVkU7O4lbgipErqRmu73PySoJiPe+YF9MorVpN/GeWfokL2hH9lXRP6I/BaBmP365xLE+wxTYz+bUIQ3Z8d9uc02OXd7PVkC48amdNB8O/KaHWy9CJFYwq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiPKnQTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiPKnQTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C56F1F000E9;
	Fri,  3 Jul 2026 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088072;
	bh=ALbsRM85ooxxwWdRaQxHTENoKOY2DSRXqG0TdBu52Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiPKnQTxgeKbchSiuxfxptV6MtsDC9PRKEG2IpUzvfKmi4JTwaWebj8DoqMwpWkQ5
	 ZxvKsWAT6fhyAV/5Qiws73fjXdL9ZG9sBm83KVwbzRb9wEbAtqXig1vnevsOe8yuze
	 XkZQjTEpP5TCIgFPMbGGn48WW2LtGcX+0J4+az2gP0garWMJ9ACtARPZbirBKUV3bO
	 ifLSCDeTT7fJcQj7AkmgRtm4lPOp0hpYHt7SvlsF/Bli9irLaI4ZLlHiWdVFBBw2xE
	 rb9W2yAPrA/NbrjQ559imFm0zTaLizW8HwLtV9huT3Q+95fLJUgLfBvII09BqKIrRN
	 BrGstciTQvA0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 28/32] sched_ext: Route
 ops.update_idle() to sub-schedulers and re-notify owed scheds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-29-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-29-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:14:32 +0000
Message-Id: <20260703141432.7C56F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double delivery of `ops.update_idle(..., true)` to BPF schedulers =
during an idle transition if a forced re-notify is pending.
--

commit f8054dfa3b3f832d674e303615ccbb3864f6e4c8
Author: Tejun Heo <tj@kernel.org>

sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed sch=
eds

This commit routes ops.update_idle() to all sub-schedulers that hold base
capabilities on a CPU, rather than just the root scheduler. It also adds a
re-notify mechanism to flush suppressed idle transitions when a scheduler
leaves bypass mode or gains baseline access.

> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index 8e8c6201b7dfd..04b320f89b6f2 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c

[ ... ]

> @@ -730,6 +731,46 @@ static void update_builtin_idle(int cpu, bool idle)
>  	}
>  }
> =20
> +/*
> + * Notify schedulers of an idle transition on @cpu's cid, delivering to =
every
> + * sched that holds %SCX_CAP_BASE on the cid (the root holds every cap).=
 A real
> + * transition (@do_notify) reaches all holders. A forced one (@root_reno=
tify for
> + * the root, a sub-sched's idle_renotify marker for a sub) reaches only =
the owed
> + * scheds.
> + */
> +static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bo=
ol root_renotify)
> +{
> +	s32 cpu =3D cpu_of(rq);
> +	s32 cid =3D scx_cpu_arg(cpu);
> +	struct scx_sched *pos;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	pos =3D scx_next_descendant_pre(NULL, scx_root);
> +	while (pos) {
> +		bool forced =3D false;
> +
> +		if (unlikely(scx_missing_caps(pos, cpu, SCX_CAP_BASE))) {
> +			pos =3D scx_skip_subtree_pre(pos, scx_root);
> +			continue;
> +		}
> +
> +		if (pos =3D=3D scx_root) {
> +			forced =3D root_renotify;
> +		}
> +#ifdef CONFIG_EXT_SUB_SCHED
> +		else if (per_cpu_ptr(pos->pcpu, cpu)->idle_renotify) {
> +			per_cpu_ptr(pos->pcpu, cpu)->idle_renotify =3D false;
> +			forced =3D true;
> +		}
> +#endif
> +		if ((do_notify || forced) && SCX_HAS_OP(pos, update_idle) &&
> +		    !scx_bypassing(pos, cpu))
> +			SCX_CALL_OP(pos, update_idle, rq, cid, idle);
> +		pos =3D scx_next_descendant_pre(pos, scx_root);
> +	}
> +}

[ ... ]

> @@ -772,20 +812,26 @@ void __scx_update_idle(struct rq *rq, bool idle, bo=
ol do_notify)
>  			update_builtin_idle(cpu, idle);
> =20
>  	/*
> -	 * Trigger ops.update_idle() only when transitioning from a task to
> -	 * the idle thread and vice versa.
> -	 *
> -	 * Idle transitions are indicated by do_notify being set to true,
> -	 * managed by put_prev_task_idle()/set_next_task_idle().
> +	 * ops.update_idle() fires on real idle transitions, indicated by
> +	 * @do_notify and managed by put_prev_task_idle()/set_next_task_idle().
> +	 * An idle pick also fires it to flush a forced notify owed to a sched
> +	 * that missed transitions while bypassed or on a cid it just gained.
> +	 * unbypass_renotify_idle() and scx_process_sync_ecaps() arm the per-rq
> +	 * gates, and scx_idle_notify() targets the owed scheds.
>  	 *
> -	 * This must come after builtin idle update so that BPF schedulers can
> -	 * create interlocking between ops.update_idle() and ops.enqueue() -
> +	 * This must come after the builtin idle update so that BPF schedulers
> +	 * can create interlocking between ops.update_idle() and ops.enqueue() -
>  	 * either enqueue() sees the idle bit or update_idle() sees the task
>  	 * that enqueue() queued.
>  	 */
> -	if (SCX_HAS_OP(sch, update_idle) && do_notify &&
> -	    !scx_bypassing(sch, cpu_of(rq)))
> -		SCX_CALL_OP(sch, update_idle, rq, scx_cpu_arg(cpu_of(rq)), idle);
> +	if (do_notify ||
> +	    (idle && (rq->scx.flags &
> +		      (SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY)))) {
> +		bool root_renotify =3D rq->scx.flags & SCX_RQ_ROOT_IDLE_RENOTIFY;
> +
> +		rq->scx.flags &=3D ~(SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOT=
IFY);
> +		scx_idle_notify(rq, idle, do_notify, root_renotify);
> +	}
>  }

[Severity: High]
Does this code introduce a regression where ops.update_idle(..., true) is
delivered twice consecutively to BPF schedulers?

If a BPF scheduler sets idle_renotify (e.g. via scx_bypass() or
scx_process_sync_ecaps()) while a CPU is active, and the CPU subsequently
goes idle:

1. __pick_next_task() calls pick_task_idle()
2. pick_task_idle() calls __scx_update_idle() with idle=3Dtrue and do_notif=
y=3Dfalse
3. __scx_update_idle() sees the renotify flags, clears them, and calls scx_=
idle_notify()
4. scx_idle_notify() delivers update_idle(..., true) to the owed scheduler =
because forced is true.

Immediately after, __pick_next_task() calls put_prev_set_next_task(), which
calls set_next_task_idle():

5. set_next_task_idle() calls __scx_update_idle() with idle=3Dtrue and do_n=
otify=3Dtrue
6. __scx_update_idle() sees do_notify=3Dtrue and calls scx_idle_notify()
7. scx_idle_notify() delivers update_idle(..., true) to all schedulers, inc=
luding the owed scheduler again.

Could this double delivery violate edge-trigger semantics and cause BPF
schedulers maintaining idle CPU lists to push the CPU multiple times?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D28
