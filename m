Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706169;
	b=Tgo51axWG5rm0nmcbMh6IMKn4rB6rwM5/Lew2okzLE3oCZUJyrIGRzAgZuemSkaXTbys
	 N8RjA4t2VBRbL1QECIbsLkJaZBFmnI1lkZ8qQiIFkneF6vhMKivTihCw3jTwJDDH9XdSS
	 QVzg43hd/YWpM04GclrbNgNrG8gLWole/YNxAL+DiJ/h3tjv6+UxRuhc3pEnt4CinXsPA
	 m5SrC9OOYkWUKn1SZsL07RiiATp5gRDKbNJJ9ibzPTiqzLQ+f6GLziVCVxCo7V9BisGkG
	 dXOiG2YVGQBMa8CO4j2NLrKcAMCctezd9aM47C7j6Kw7BGwrS10PZOxpRNl9joHiLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ups1s11vrWEtEO9z9HN269lSB+icY81yubi41Edvn1s=;
	b=Lyqphv8CG81tZ1UjqaVgOEFIxpyVV3ELu/qwVBtR8CF1b6gMwOjBeeShN9xow1i6soTK
	 jLDanU8qSRmLSToJobSxBQzMQUhAqhEsXVQqFg0KT1QUS5L7Y/0L6kXYBdQrIDe7T4YMq
	 K8rgRyLihn0UOa8LU00baRK/quXhtuw/MQqTViqiB6JUn6fqJ2mZWrr7KIi7tnzHcPe6p
	 8ip3a3LNhjmGerWfnHqCKpKiOIOMSMojDmw+Q0HoHPHRqYer5c9STO57Rupp+QSKvt4sh
	 SsROJBYWFodA4ktVGJCYycG42k7L2mR6r2SVFvDIMoDqDRxAT84iiULAwl34ARIHmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8Cs9o3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CC606A31A
	for <sched-ext@lists.linux.dev>; Thu, 22 Oct 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8Cs9o3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3EF1F01825;
	Thu, 22 Oct 2026 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706168;
	bh=ups1s11vrWEtEO9z9HN269lSB+icY81yubi41Edvn1s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=h8Cs9o3Ofl2AkFHZhYZzMPYC+WPmNt0AeiRr3ON2Dzw3oaEku2gyTfi0aYNxM/WQH
	 xiPPz3OEJ2WgM4fRwUYFP5X3qyMh/bHDkScxRh1Vj8I4GrimsfA5DXhXpjW92ycAAN
	 MtxeP1rxC40cX+fAVqq/hIxP3Wl/cb4f7mdqGFxaUNUm9Z/xmL+tXusXf/Wkp4DTtu
	 RiJ1c4SAWmLS8GmkzGAH9o5OrOfLR/ogNiXdtpRn/l+PlccmzIb6dM1xVbh2V/JjFc
	 cdwZNS70QQ8XVK6g1vpeRila+YWubvcBtgXcGqsU7bnl7Si5YEfqgu6qssOfsyByv+
	 okapYTc8/75uA==
Message-ID: <sashiko-outbox-182079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/14] sched_ext: Fix a cpu idling with a runnable
 rescuee
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261022213836.2259069-7-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
 <20261022213836.2259069-7-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:56:08 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: premature rescue end in dispatch_one() via keep-last =
check
--

commit e79ddf5c81c9e04dfc120cdedd71ae201dfeefb0
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix a cpu idling with a runnable rescuee

This commit updates dispatch_one() to call scx_rescue_keep() when no other
task is runnable so that a rescuee with a zeroed slice continues running on
its unserved rescue remainder instead of letting the CPU go idle.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e9224351e9dff..e587743b6136f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3389,6 +3389,26 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  			verdict =3D SCX_DSP_PREV;
>  			goto has_tasks;
>  		}
> +
> +		/*
> +		 * The scheduler preempts a rescuee like any other task by
> +		 * zeroing its slice. The grant survives the preemption. The
> +		 * rescuee gets the unserved remainder back and runs again
> +		 * behind whatever the scheduler wanted to run first.
> +		 *
> +		 * Two sites restore the remainder. When another task won the
> +		 * pick, put_prev_task_scx() restores it and queues the rescuee
> +		 * at the tail of the local DSQ.
> +		 *
> +		 * When nothing else is runnable, the cpu must not go idle with
> +		 * the rescuee queued. The keep above declined @prev, and a
> +		 * reinsert from put_prev_task_scx() would come after the pick
> +		 * settled on idle. Keep @prev running on the remainder here.
> +		 */
> +		if (unlikely(prev =3D=3D scx_rescuee(rq)) && scx_rescue_keep(rq, prev)=
) {
> +			verdict =3D SCX_DSP_PREV;
> +			goto has_tasks;
> +		}

[Severity: Medium]
Should the scx_rescue_keep() check in kernel/sched/ext/ext.c:dispatch_one()
run before the SCX_EV_DISPATCH_KEEP_LAST check above it?

Right before this addition, dispatch_one() checks whether prev can stay on
the CPU:

	if (prev->scx.flags & SCX_TASK_QUEUED) {
		struct scx_sched *prev_sch =3D scx_task_sched(prev);

		if ((!(prev_sch->ops.flags & SCX_OPS_ENQ_LAST) ||
		     scx_bypassing(prev_sch, cpu)) && scx_task_can_stay_on_cpu(rq, prev))=
 {
			__scx_add_event(prev_sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
			verdict =3D SCX_DSP_PREV;
			goto has_tasks;
		}

In kernel/sched/ext/sub.h:scx_task_can_stay_on_cpu(), this condition returns
true for an active rescuee if the task is in a migrate_disable() section, or
if prev_sch holds SCX_CAP_BASE on the CPU (for instance, when the task was
diverted to rescue because an enqueue required SCX_CAP_ENQ or SCX_CAP_PREEM=
PT,
or if SCX_CAP_BASE was granted after the rescue started):

	if (unlikely(is_migration_disabled(p)))
		return true;

	/* check caps against the sched running a bypassed task */
	return likely(!scx_missing_caps(scx_exec_sched(scx_task_sched(p), cpu), cp=
u,
					SCX_CAP_BASE));

When !(prev_sch->ops.flags & SCX_OPS_ENQ_LAST) and scx_task_can_stay_on_cpu=
()
is true, a rescuee whose slice was zeroed before serving its full rescue
quantum will take the SCX_EV_DISPATCH_KEEP_LAST branch and return
SCX_DSP_PREV with prev->scx.slice =3D=3D 0 instead of calling scx_rescue_ke=
ep().

Then kernel/sched/ext/ext.c:do_pick_task_scx() sees !p->scx.slice:

	if (verdict =3D=3D SCX_DSP_PREV) {
		p =3D prev;
		if (!p->scx.slice) {
			/* the slice is consumed, protection ends */
			scx_task_slice_ended(rq, p);
			refill_task_slice_dfl(scx_task_sched(p), p);
		}
	}

Wouldn't that call scx_task_slice_ended() -> scx_rescue_end() to terminate
the rescue prematurely and refill p->scx.slice with an unmetered default
slice instead of restoring the unserved rescue remainder?

>  	}
>  	rq->scx.flags &=3D ~SCX_RQ_IN_DISPATCH;
>  	return SCX_DSP_NONE;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022213836.2259=
069-1-tj@kernel.org?part=3D6
