Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406586;
	b=ZCo78P8o/gezgqb/61qKvEShmRUg7whx4dMtIOq+ZCf9nSKg4630Y26OjajV2A24pExE
	 5tbDWJNJLs3cqvTnnzXNP8kd7vce+U1/o8tGKMzcFn/Hr8vxRSJD3x3ngKubI0T4dDl+S
	 ljP5+FuAqGYiksFLfs51VzwlgplneecYMrQ6LMvosw6oILizW8fQgkR5PQwUNeGz1u5ku
	 tnvcs+3DseXeaEyWOiCZK2DE1aFN+NFq4rPo51KHgozQyL8L0VQ0DbMN0ZOobcYdly1IC
	 xod1ZKBWe08up/cKE2b0dpVAkt1pOGlXK4eQU9enh9bZlyFZ+mEtg7ROx8mRpiPScew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ywW7oHoXyY7elCh1+Fp4rGj3bM3BkrPOLOgQeqRQE74=;
	b=rGLLS2/d8Dhu77uLXWSHmrKe/eHIgxnfhDV0WmCVdvRMloRBnKnDNYV5xPQr3oA/Hviq
	 CjpRZLFeWu/Dw2iFHQ7DBuK4xe3oBJEx9DCh4QKH1+zKkY1Thmt4zGGK/KFvM93H8i6nh
	 3ikCLL77U/HokvZ302nSnw05C1994ZQfNXbxB7O5/VrcWvj3QglCaEWE49xoctyzf2mBe
	 7HRhYvAcrhtxeTucIRiBfwL+QQ3GdlPdqYLB/tU+VrG2/4Ug7UmCetBofEgAfBTfdOl4T
	 Ajz78cJ1aB65jFyGtIet8s1VqTCfv941tm8+Eco8sHoZb4SZwGru6kF4UE//2josbvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJFZF26I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E3606A31A
	for <sched-ext@lists.linux.dev>; Sat, 31 Oct 2026 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJFZF26I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B31F000C1;
	Sat, 31 Oct 2026 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793406585;
	bh=ywW7oHoXyY7elCh1+Fp4rGj3bM3BkrPOLOgQeqRQE74=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iJFZF26IefbX22tOy3YA02jmfca4ILcxUSZRV7vnyqWf+4i3sCYDZK+n3fJqXEziy
	 vxUWYSgxhkGCSOJjJs/pUlv0G/umIh622emKFJfcxKQIJX75/l3NFvugUb6h9Agmey
	 TuXpRnoIVXjzSINeBAAR0qvfGQFMmjDpluXygASmKeaw9e5tUvZmCaNnUOUs7yQ1zJ
	 8KY+O0ZAySiWgwsSKkhblqq1BBp/SsLDBl3s0aacWZ0TeJjATNh/GXrIahJ/QwV+4m
	 9ZtsPXvDirAP1M/Bw1QM/aa59NYfLMCu+8nEEBDfwO4Mj3BghqRjFgxh44to9a6EPN
	 la3P7TpiP2FAQ==
Message-ID: <sashiko-outbox-191676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick
 when a wakeup resets the donor during dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261030235728.4098872-1-tj@kernel.org>
References: <20261030235728.4098872-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:29:44 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched_ext: unguarded keep-prev check in scx_dispatch_sched()
- [Medium] sched_ext: premature cpu_acquire() before stale donor check in d=
ispatch_one()
- [Medium] sched: stale rq->dl_server across RETRY_TASK in __pick_next_task=
()
--

commit da4492c7a1c1f5575c5658737f248cb38f6f4291
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix stale pick when a wakeup resets the donor during dispatch

This commit restarts the sched_ext pick with SCX_DSP_RETRY when a wakeup or
sched_proxy_block_task() resets rq->donor while dispatch_one() or
scx_dispatch_sched() has the rq lock dropped. It also updates
scx_dispatch_sched() to re-evaluate whether prev is still the donor and on
the target scheduler before passing prev to ops.dispatch().

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ffaab9fafca87..fe1be3d9444dd 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  		rq->scx.cpu_released =3D false;
>  	}
> =20
> +	/* the ecaps sync may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev)) {
> +		verdict =3D SCX_DSP_RETRY;
> +		goto out;
> +	}

[Severity: Medium]
Should the scx_dsp_prev_stale() check happen immediately after
scx_process_sync_ecaps(), before checking rq->scx.cpu_released and invoking
ops.cpu_acquire()?

If scx_process_sync_ecaps() drops rq->__lock and another CPU wakes the SCX
proxy donor while rq->curr belongs to a higher scheduling class,
proxy_needs_return() calls proxy_reset_donor():

  proxy_needs_return()
    proxy_reset_donor()
      put_prev_set_next_task(rq, rq->donor, rq->curr)
        put_prev_task_scx(rq, prev, rq->curr)
          switch_class(rq, rq->curr)

That path invokes ops.cpu_release() and sets rq->scx.cpu_released =3D true,=
 and
proxy_reset_donor() sets rq->donor =3D rq->curr.

When scx_process_sync_ecaps() returns to dispatch_one(), the
rq->scx.cpu_released block then sees rq->scx.cpu_released =3D=3D true, calls
ops.cpu_acquire(), and clears rq->scx.cpu_released =3D false right before
scx_dsp_prev_stale() aborts the pick with SCX_DSP_RETRY.

On the restarted pick, rq->donor is already rq->curr in the higher class, so
put_prev_task_scx() will not run again. Wouldn't that leave
rq->scx.cpu_released false and the BPF scheduler thinking it owns the CPU
while a higher class runs?

> @@ -3449,8 +3455,19 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  	}
> =20
>  	verdict =3D scx_dispatch_sched(root_sch, rq, prev, false);
> -	if (verdict !=3D SCX_DSP_NONE)
> +
> +	/* scx_dispatch_sched() may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev))
> +		verdict =3D SCX_DSP_RETRY;
> +
> +	switch (verdict) {
> +	case SCX_DSP_RETRY:
> +		goto out;

[Severity: Medium]
As reported by Andrea Righi on v1 [1], when dispatch_one() returns
SCX_DSP_RETRY during an ext_server pick, do_pick_task_scx() returns
RETRY_TASK to __pick_task_dl():

  __pick_next_task()
    pick_task_dl()
      __pick_task_dl()
        ext_server_pick_task()
          do_pick_task_scx()
            dispatch_pick()
              dispatch_one()

In kernel/sched/deadline.c:__pick_task_dl(), RETRY_TASK is non-NULL, so
rq->dl_server is set before returning:

	if (dl_server(dl_se)) {
		p =3D dl_se->server_pick_task(dl_se, rf);
		if (!p) {
			dl_server_stop(dl_se);
			goto again;
		}
		rq->dl_server =3D dl_se;
	}

In kernel/sched/core.c:__pick_next_task(), rq->dl_server =3D NULL is placed
above the restart label:

	rq->dl_server =3D NULL;

	if (scx_enabled())
		goto restart;
...
restart:
	prev_balance(rq, rf);

	for_each_active_class(class) {
		p =3D class->pick_task(rq, rf);
		if (unlikely(p =3D=3D RETRY_TASK))
			goto restart;
		if (p) {
			put_prev_set_next_task(rq, rq->donor, p);
			return p;
		}
	}

If the retried pass picks a non-server task (for instance, if the woken don=
or
was the only sched_ext task and migrated away so ext_server_pick_task()
returns NULL and stops ext_server, or if a higher-priority task was woken
during the lock drop), won't put_prev_set_next_task() hand the stale
&rq->ext_server pointer in rq->dl_server to next->dl_server?

> diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
> index 1e39d12678c4d..fb0c58927d421 100644
> --- a/kernel/sched/ext/inlines.h
> +++ b/kernel/sched/ext/inlines.h
[ ... ]
> @@ -106,6 +124,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq =
*rq,
>  			rq->scx.sub_dispatch_prev =3D prev;
>  #endif
> =20
> +		/* the dispatch so far may have dropped the rq lock */
> +		prev_on_sch =3D !scx_dsp_prev_stale(rq, prev) &&
> +			      prev->sched_class =3D=3D &ext_sched_class &&
> +			      scx_task_on_sched(sch, prev);
> +
>  		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
>  			    prev_on_sch ? prev : NULL);

[Severity: High]
As reported by Sashiko on v1 [2], prev_on_sch guards passing prev to
ops.dispatch(), but right after scx_flush_dispatch_buf(sch, rq),
scx_dispatch_sched() still checks prev->scx.flags and prev->scx.slice
unconditionally:

		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
			    prev_on_sch ? prev : NULL);

#ifdef CONFIG_EXT_SUB_SCHED
		if (!nested)
			rq->scx.sub_dispatch_prev =3D NULL;
#endif

		scx_flush_dispatch_buf(sch, rq);

		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
			return SCX_DSP_PREV;
		if (rq->scx.local_dsq.nr)
			return SCX_DSP_LOCAL;
		if (scx_consume_global_dsq(sch, rq))
			return SCX_DSP_LOCAL;

If rq->__lock was dropped (either before ops.dispatch() or inside
scx_flush_dispatch_buf()) and another CPU woke the donor prev and enqueued =
it
remotely with SCX_TASK_QUEUED and a fresh slice, or if prev does not belong
to sch, won't this check read prev's state without holding its rq lock and
return SCX_DSP_PREV prematurely?

In that case:
- Tasks just dispatched to sch's global DSQ are left unconsumed because
  scx_dispatch_sched() returns before reaching scx_consume_global_dsq(sch, =
rq)
  or the dspc->nr_tasks retry loop.
- When called from scx_bpf_sub_dispatch(), returning SCX_DSP_PREV causes
  scx_bpf_sub_dispatch() (which tests verdict !=3D SCX_DSP_NONE) to return =
true
  to the caller even though child did not dispatch a task, including inside
  one-shot ops.sub_ecaps_updated() / ops.sub_child_ecaps_updated() callbacks
  in __scx_process_sync_ecaps() that already drained rq->scx.ecaps_to_sync
  and will not re-run when dispatch_one() retries.
- If prev =3D=3D rq->curr =3D=3D rq->donor was in fair_sched_class when dis=
patch_one()
  started via ext_server_pick_task() and another CPU switched prev to
  SCHED_EXT during scx_flush_dispatch_buf(), scx_dsp_prev_stale(rq, prev) is
  still false while prev now has SCX_TASK_QUEUED and a default slice, so
  scx_dispatch_sched() returns SCX_DSP_PREV ahead of rq->scx.local_dsq.nr e=
ven
  though ops.dispatch() was passed NULL for prev.

Should the post-flush SCX_DSP_PREV check also require prev_on_sch and
!scx_dsp_prev_stale(rq, prev)?

[1] https://lore.kernel.org/r/auTNPtiaPyO9R5NG@gpd4
[2] https://lore.kernel.org/r/20261030142338.3453484-1-tj@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030235728.4098=
872-1-tj@kernel.org?part=3D1
