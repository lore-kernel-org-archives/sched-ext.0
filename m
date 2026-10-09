Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3E3E1222
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583801; cv=none; b=VOxXcR69TDgKbpjjEm4l/pOxfBNwLx5UgcyYbP/WQYDiFUevNnKWF2n0RQ5uSnVRVaMz2oM2a56XH1nTpf7qA2NCIYmeWl0wAxW2zW32pu3WB7L48cuRi+84LWOp5qWr4Lb0QKw0SfZH6y8W0EjlNiwccVWoGhh9qag/BQwnM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583801; c=relaxed/simple;
	bh=yZERg51Q9sPr4F9mzJNg9O+yQY2D1Le7tMCcCyWgQ28=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=noTPDZTFBBAYVAY5ho6LPjLmm67QNDBaZHFiYWEDF8rV6HrH5cK444gj4ZA2pIY487OibqeQRwtMjNljO4sSlx7pKm8KD2o6nULGgW/dF+jly9790VS7uGeGTpOLG/GBk3YEWWfTmF58XS8r6/CIY/0AUc/MNMO3cg4BW9u25w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejuLdYvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejuLdYvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06EC1F000FF;
	Fri,  9 Oct 2026 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791583800;
	bh=c5eUGRiJYemcBK+0qv0iHMTWbCp3JBHcRRbp2Deg/28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejuLdYvLIFyW0igZPWZk3LKSo+hmuinENXCLpOMufTQRl2dsQEm+SIlHY+QoME0bU
	 jV7yVtxc5c8HkcupolduENBxpc9L50/QnKpYr05fa6m5c3/Xscw0fZ656PwJY9kJrR
	 LxYoyi40B7c9f4dPVbq13RabYkU0F4MYh+zQdb6UNDqbHrptR0gJTziGlvJ9NuSXpq
	 4u057t1H5G1IC4np1QJlR74XSjPfrrVw0FJyhVB2lJcPXhmdu0Fxk7f/feBybv5/nl
	 OSeOginlbOC93OHXMag31/betwU4Yw79t626bPVjyE55KwXxCEA0DYiShHjfSJRiru
	 9ZaLNGSUJpvXQ==
Message-ID: <sashiko-outbox-166126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free
 of a destroyed user DSQ by a deferred reenqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261009220001.196762128-1-tj@kernel.org>
References: <20261009220001.196762128-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:09:59 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sched/ext: build failure due to non-existent member pcpu in struct =
scx_dispatch_q
--

commit be226bed0faf80d9afdf2b8cee5244f38b4976cc
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix use-after-free of a destroyed user DSQ by a deferred reenque=
ue

This commit cancels pending requests before an RCU grace period when destro=
ying
a user DSQ to prevent a use-after-free race condition with run_deferred().

Link: https://lore.kernel.org/all/20261008024753.4096008-1-sh_def@163.com/

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -5656,8 +5660,26 @@ static void free_dsq_irq_workfn(struct irq_work *i=
rq_work)
>  	struct llist_node *to_free =3D llist_del_all(&dsqs_to_free);
>  	struct scx_dispatch_q *dsq, *tmp_dsq;
> =20
> -	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
> +	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node) {
> +		s32 cpu;
> +
> +		/*
> +		 * Cancel pending reenqs. Only a run_deferred() that started
> +		 * before the grace period can hold one, and it keeps IRQs off,
> +		 * so the grace period waits for it. After this sweep,
> +		 * schedule_dsq_reenq() sees the invalid id under the same lock
> +		 * and queues nothing.
> +		 */
> +		for_each_possible_cpu(cpu) {
> +			struct scx_dsq_pcpu *pcpu =3D per_cpu_ptr(dsq->pcpu, cpu);

[Severity: Low]
Does this code compile when CONFIG_SCHED_CLASS_EXT is enabled? Looking at s=
truct
scx_dispatch_q defined in include/linux/sched/ext.h, it appears the correct
member name is pcpu_user, not pcpu. Using dsq->pcpu might result in an
unconditional build failure.

> +			struct rq *rq =3D cpu_rq(cpu);
> +
> +			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
> +			list_del_init(&pcpu->deferred_reenq_user.node);
> +		}
> +
>  		call_rcu(&dsq->rcu, free_dsq_rcufn);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009220001.1967=
62128-1-tj@kernel.org?part=3D1
