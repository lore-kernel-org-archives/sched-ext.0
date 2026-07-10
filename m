Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7823F1AD1
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678075; cv=none; b=q5lJzTAy+0/liTHQ1NXo8tEuMkeQU7hK114wR+BFJZBc1N33fICAUWDmA8tFhoTZqGokSmy1AlzZGLV2UvpF5Wa0O8X56iwXDwJU9rAs0kOFuxZl9qttOghnf2DnMw+7CfXq1Ei9LW3OOeerBDtZAQx7tnINTNORtA4F2+0XwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678075; c=relaxed/simple;
	bh=orSZV1/zXQfZkjdxkgTTdm82T68UoUDY1pDQbP9RCtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTUcBdTf8TChvqaAKEwtcoD4+pNw49WKG0b2J3mWAp4ixMtNIu9VbEmmGPJRXqfJ0cuPF9U52MUW527hA7m63T68GOviHqKPSinkbb+RSHJDLBflFVUuXKMB8Fc0wLIepBjXO+f5hDbhjEDxYqwWHgIaVbu2NdBz4dtLvhsFl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7nm3ODs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7nm3ODs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC381F000E9;
	Fri, 10 Jul 2026 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783678074;
	bh=Kh1llx8e73XDC+WePxdSt4UTWBvxTw7ou9M98E9oFr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7nm3ODsl22a8o4MiV6FoPdrfL8Kwdj0gsOvzeXzlCSjvRTxykfK6m3V1F/33yupl
	 GBxVqcC/LaM2CFDj0BBf0BVVjhNr1zYy8F06ReFt9qnvYMvwLCtjcFfUYlsU81uS6k
	 XbmDsEWNASYeU4FlSDVJt9Ud5eOooZlQiNUiP6EbgtK7rlVW/Ajm0Qc1D8uCm7iGxO
	 FuvfTuPZxNe/9HDv3M2aSX67poIP2+skwyngseDbJO7iz+dGQcK5518D7E87s6xsM8
	 0Q4dSTG5a3oYIyrIMYBVhbWTHxA09nqj0pBLq+k4ZMGHuzFhbxyawd/LWck1HaP+Xp
	 m/+YjO1fF7BbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueue
 to irq_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Fleming" <matt@readmodwrite.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260710095359.2643791-1-matt@readmodwrite.com>
References: <20260710095359.2643791-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:07:53 +0000
Message-Id: <20260710100754.3CC381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] RCU-tasks callbacks queued with IRQs disabled prior to subsystem i=
nitialization are permanently leaked and never executed.
--

--- Patch [1]: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueu=
e to irq_work ---
commit 0fb74f52f7f1a3087f9fed2016be045b93a6a7a9
Author: Matt Fleming <mfleming@cloudflare.com>

rcu-tasks: Defer IRQ-disabled callback enqueue to irq_work
   =20
This commit splits the rcu-tasks enqueue path, routing callers with IRQs
disabled through a lockless per-CPU llist drained by a hard irq_work. This
prevents acquiring cbs_gbl_lock under unknown outer locks.

Link: https://lore.kernel.org/r/20260609104733.1184001-1-mfleming@cloudflar=
e.com

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 2dc044fd126eb..56b51946bc6b7 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

> @@ -276,6 +283,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  		if (rcu_segcblist_empty(&rtpcp->cblist))
>  			rcu_segcblist_init(&rtpcp->cblist);
>  		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
> +		init_llist_head(&rtpcp->rtp_irq_bypass_list);

[Severity: High]
Does this initialization overwrite any callbacks queued early in boot?

If call_rcu_tasks_generic() is invoked with IRQs disabled prior to
subsystem initialization, it adds the callback to rtp_irq_bypass_list
and queues the irq_work. Since interrupts are globally disabled early in
boot, the irq_work won't run until after rcu_init().

When rcu_init() calls cblist_init_generic(), will this unconditionally
clear the list head and cause pending early-boot callbacks to be
permanently leaked?

[ ... ]

> @@ -363,43 +492,23 @@ static void call_rcu_tasks_generic(struct rcu_head =
*rhp, rcu_callback_t func,
>  	chosen_cpu =3D cpumask_next(ideal_cpu - 1, cpu_possible_mask);
>  	WARN_ON_ONCE(chosen_cpu >=3D rcu_task_cpu_ids);
>  	rtpcp =3D per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
> -	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.

[ ... ]

> -	// Queuing callbacks before initialization not yet supported.
> -	if (WARN_ON_ONCE(!rcu_segcblist_is_enabled(&rtpcp->cblist)))
> -		rcu_segcblist_init(&rtpcp->cblist);

[ ... ]

> -	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
> +	if (irqsoff) {
> +		llist_add((struct llist_node *)rhp, &rtpcp->rtp_irq_bypass_list);
> +		rcu_read_unlock();
> +		local_irq_restore(flags);
> +		irq_work_queue(&rtpcp->rtp_irq_bypass_work);
> +		return;
>  	}

[Severity: High]
Can this lead to silent data loss if called during early boot?

By routing IRQ-disabled callers directly to the bypass list here, we
circumvent the pre-existing fallback (removed above) that safely
initialized the cblist on demand. Could this result in early-boot
callbacks being queued to an uninitialized list that will subsequently
be wiped out by cblist_init_generic() during rcu_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710095359.2643=
791-1-matt@readmodwrite.com?part=3D1
