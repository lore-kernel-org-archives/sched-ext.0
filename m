Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608975;
	b=Q2iW/izn8Ff6G1IDpGsydXyfUYXK/VaHIwPJBuVbsXc+LopDENBfnSchndxx7qgCZ0xy
	 AwJ/TYuP/o/mB4m7Itgl2kd/jposF00IzLPS2PXgG0cYaKJPOL2NHzb2L58uHiwIPQvzQ
	 4K1c+LAJXp5JktO1damchG43jWE8slVtcnw8kz1AtlCx09u8LNzqsQ2PDTJQyIqSXhwlR
	 MzbKtlYJ2dKtqlwBIY2rw0oTlNYG4ry1no0H0jyQZZau1RmaBVUJNJels4rrYF5JQnH8W
	 Hz+YmiQ5ZXJYxCdvGYm5ph3Wh4KiBvqY7E+JsE23KqNaDiZnOXkpKbeTTPyEbsDb/9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=40td+cC0XulVTj8ihSxZArq/29E2fY4EGQMPMELXKFs=;
	b=vQQDsLVIZ16kg7hYGhIKNUgykPCN6ePk89Lg+MVP2BsD0E89CdMj/xSpV/Ym9nYwD8H4
	 AIzxc9B20BMP7T4auOgxW4+Szqh8AX/ep56JzgDmPA1Rl17eauiklu1hEmaj3oMJXNbf/
	 sHCVfAPhRGYcui6LPJ+mcgpaD6EEsWoe+oJy4AMsLkttjabJIxXV6CZRyBUBm+CaiPArh
	 o7wy8K8SVYnUHHgoZy8pPPlRAMay/QRUuZdMOM1/Q8/64gFUr5mMC1XuDwDIhOZkZHATe
	 lhdYZsdqdvPFh/Bt58Vns3jzeYCl/hqCT+jwgh9CMrwFhCOOtUAw5OANz3jC7F9gQXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzQzpGDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB5C606A31E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzQzpGDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45191F000C6;
	Wed, 25 Nov 2026 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608974;
	bh=40td+cC0XulVTj8ihSxZArq/29E2fY4EGQMPMELXKFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzQzpGDNpN06Tk167w++N8o6HTFRwwF4agcBM7ygKWy0GjWygmIwezNVmoqZuOiZI
	 wGgT9jHMuAKTcY++lS1GEzGjpUpswJCieeOA0GzzsrOKENHC7OA9qBu/2La4jLDs3Z
	 aN5GNmS8r43UERdhSGXubFij+f/yVol2Pzmmp5gCOclnbdXUz74/5Ufrop+NBWOJwl
	 5NQPg4+HEeTPwNiLZAJk1W5MnH86391CflpLql0NL5OppgzSRjWNutSAreaKzKGQDT
	 aHiWaXIUS8zTYSTLrWJCEUeUCOrezG35Sc8ccv8lej4YmHfPjKRe+0tu6iO+oWAW19
	 IRSHTS0Iy8JTA==
Message-ID: <sashiko-outbox-233340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] sched_ext: Reenqueue IMMED tasks when a higher
 class wins the pick
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261125114932.3198836-2-jpiecuch@google.com>
References: <20261125114932.3198836-1-jpiecuch@google.com>
 <20261125114932.3198836-2-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:16:14 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched_ext: missed scx_settle_pick() on core-sched sibling in
  pick_next_task()
--

commit 6268089dba82c4845b6bc4c92ec88a503f333074
Author: Kuba Piecuch <jpiecuch@google.com>

sched_ext: Reenqueue IMMED tasks when a higher class wins the pick

This commit adds scx_settle_pick() in __schedule() after task selection and
proxy resolution complete so that SCX_ENQ_IMMED tasks on the local DSQ are
reenqueued whenever rq->next_class ends up above ext_sched_class, replacing
the proxy-only check in scx_proxy_reenqueue_retry().

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ea89471d4743c..430795ddd2c55 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7389,6 +7389,7 @@ static void __sched notrace __schedule(int sched_mo=
de)
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  keep_resched:
> +	scx_settle_pick(rq);
>  	rq->last_seen_need_resched_ns =3D 0;
> =20
>  	is_switch =3D prev !=3D next;

[Severity: Medium]
With CONFIG_SCHED_CORE, can a sibling CPU miss scx_settle_pick() and leave
SCX_ENQ_IMMED tasks stranded on its local DSQ when cookie matching falls
back to its currently running higher-class task?

During a core-wide pick in pick_next_task(), pick_task(rq_i, rf) on a
sibling running a higher-class task with core_cookie C can run
ext_server_pick_task() -> do_pick_task_scx().  That lowers rq_i->next_class
to &ext_sched_class via rq_modified_begin() and allows ops.dispatch() to
insert an SCX_ENQ_IMMED task with a different cookie onto
rq_i->scx.local_dsq.  If another sibling's task with cookie C wins max and
sched_core_find(rq_i, C) selects rq_i->curr again, pick_next_task() skips
rescheduling rq_i:

kernel/sched/core.c:pick_next_task() {
	...
		if (rq_i->curr =3D=3D rq_i->core_pick) {
			rq_i->core_pick =3D NULL;
			rq_i->core_dl_server =3D NULL;
			continue;
		}

		resched_curr(rq_i);
	...
}

Because rq_i never enters __schedule(), rq_i->next_class is not restored to
rq_i->curr->sched_class and scx_settle_pick(rq_i) never runs, leaving the
IMMED task on rq_i->scx.local_dsq while the higher-class task continues
running and causing subsequent rq_is_open(rq_i, ...) checks to see
rq_i->next_class =3D=3D &ext_sched_class.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125114932.3198=
836-2-jpiecuch@google.com?part=3D1
