Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5239D6E9
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069374; cv=none; b=B04E03MrgiCBuAOzgeu8A428QFTQCwQxYmim869Js4KCI185JarY+d8I6t/j5iE0Is6NSZAuoZj6HIYxzWB1hH7Ft8AG/aSVmvdMvtSQ8J1iAFdOdf2Vx8NW/9Df2h2p+HhhNaLWETm7/ffXw9EIrxA5vZfwDwJdLloOwACsw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069374; c=relaxed/simple;
	bh=l9T5em3SSZbSwGgwJguHufuInw5biaj+cik6frRn4gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I5e8UbITRQKLccgNyIApvrtyJLTrPG3FJskloenBvj8t+VHskTgF8X517GznHp21j3BNH4Ht6WpNsBeGudKIuqnxR34qp+50eCch3JLos7+oJ+ZBy8rAf6f/5xPU6AfxD2kmFu6QIi3urBEZzjqgQ40bwTMSkKgvhcSpGOXEZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2BZrZC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2BZrZC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95991F000E9;
	Fri,  3 Jul 2026 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783069373;
	bh=K5m6PlCcY36j3NsB0fT2zOl/mcmYoMqgubiButniKKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2BZrZC6CsbpOYZYk4XNWCCplBNyu3ILPFNAEyJ3kEKJ+Ez1NX2M5nOAx0kf7/xIV
	 i4N5p1qw2sgsiMK+e2TGWo6njHWAr/bxEHfX/7optbm1N8sRzobM91G5rIgO6xOJrK
	 FokWZisx7KuMSW89zyrezEH3sj7uQ8muoZb12OdmHZNrLbtGj4HvyQ8NbmtNfFn9aB
	 P2BLAkV3nQV6tBKVwNpRRX84qLZ6U0nKIE/KsR9Zkj6CXciAV1WRuSpu/Rl8J/3OW1
	 XoiYomgkybbk/ex9AJvKOddehJUNOKCK3rKnRf4/GyAQhA7R3FYopfc3pWCdA1eMrk
	 yfKdYJu+UrNzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 07/32] sched_ext: Make the kick
 machinery per-sched
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-8-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-8-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 09:02:52 +0000
Message-Id: <20260703090252.E95991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] List corruption in `scx_kick_cpu()` and `kick_cpus_irq_workfn()` d=
ue to NMI context concurrency.
--

commit 9ac2a72a88974fa9fc65a32e794dca946c726004
Author: Tejun Heo <tj@kernel.org>

sched_ext: Make the kick machinery per-sched

This commit makes the preemption kick machinery per-scheduler instead of
sharing targets across every scheduler on the cpu. It moves the kick masks
into a per-cpu structure and updates the kick machinery to link the sched
onto a per-cpu list that is consumed by a local irq work function.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 13af43bca8507..8445e34e205fb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -7543,15 +7574,24 @@ static void kick_cpus_irq_workfn(struct irq_work =
*irq_work)
> =20
>  	ksyncs =3D rcu_dereference_bh(ksyncs_pcpu)->syncs;
> =20
> -	for_each_cpu(cpu, this_scx->cpus_to_kick) {
> -		should_wait |=3D kick_one_cpu(cpu, this_rq, ksyncs);
> -		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> -		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
> -	}
> +	/*
> +	 * Walk scheds with pending kicks on this cpu. scx_kick_cpu() adds to
> +	 * the list under local_irq_save() and only this irq_work consumes it.
> +	 * A plain list without locking is sufficient.
> +	 */
> +	list_for_each_entry_safe(pcpu, tmp, &this_scx->sched_pcpus_to_kick, to_=
kick_node) {
> +		list_del_init(&pcpu->to_kick_node);

[Severity: High]
Does this code safely handle preemption by non-maskable interrupts?

The comment notes that a plain list without locking is sufficient because
scx_kick_cpu() adds to the list under local_irq_save(). However,
local_irq_save() does not mask nmi execution.

If an nmi fires while a cpu is in the middle of list_del_init() here in
kick_cpus_irq_workfn(), and the nmi handler invokes a bpf tracing program
that calls scx_bpf_kick_cpu(), could that concurrently execute
list_add_tail() on this same per-cpu list and corrupt the list pointers?

[ ... ]

> @@ -8499,16 +8541,18 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu,=
 u64 flags)
>  			}
>  			raw_spin_rq_unlock(target_rq);
>  		}
> -		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick_if_idle);
> +		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
>  	} else {
> -		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick);
> +		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
> =20
>  		if (flags & SCX_KICK_PREEMPT)
> -			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_preempt);
> +			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
>  		if (flags & SCX_KICK_WAIT)
> -			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_wait);
> +			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
>  	}
> =20
> +	if (list_empty(&pcpu->to_kick_node))
> +		list_add_tail(&pcpu->to_kick_node, &this_rq->scx.sched_pcpus_to_kick);

[Severity: High]
Can a similar race happen here during concurrent nmi execution?

Since scx_kick_cpu() protects list_add_tail() only with local_irq_save(),
an nmi can interrupt it. If the nmi executes a bpf program that also
triggers scx_kick_cpu(), won't the nested list_add_tail() operations
corrupt the standard doubly-linked list?

>  	irq_work_queue(&this_rq->scx.kick_cpus_irq_work);
>  out:
>  	local_irq_restore(irq_flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D7
