Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F339E9BD
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502275; cv=none; b=PTxgeT8dhbE1HC8xvDhSl+wkKqX2WGyuvmzUiFGAR2Fpcqc4cQ9bS6eRvqLzdlQURwUAhGVA0DMlp+szPH8bCUJJrhC1A1uuZwyEE7vPk2fBqSkjq8A/mrdahDklhfSRC4gp2XEoXRVc2tXWqDN+uQBDjJrZ8U7bhM++k+4wGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502275; c=relaxed/simple;
	bh=OFKMfKxEfzpNJjs9A8Hs2hDFlwYwF9btdP0Z4OMuIYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M6sRCN8rDz7ed8PwPjF++FjR75c1qnZMHKNdfSj6bJLArbzOnC45AyuIIye54kOt7ouBcJcQydD3Q5mcOWKwLPucFrn1wT/QZXXDpLw9w6TDiPIVICG5tXw7eWS/ZbDx0g22UeIpAWrKg8liW65U2sQpoXG2h3f8GLywNNGrrP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVSiyptQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVSiyptQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F431F000FF;
	Tue, 15 Sep 2026 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502272;
	bh=zvoZg0sqavfG0l4mHLx4OEnr6K2qZdWOM0MP4S+tsOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVSiyptQnF2p212AO0louCfJVEjrfNg4bRfA/oeGPqi2FPVInEdk4uaO0yfM+VauV
	 ujV/0ay5hbdE4r/OEbM2ohoExcPap9cAr8kE8//sGwB2QaQ4dyWTgwTJJC+HatsDIR
	 EC+bEe3wwz/Jo941cDMil6YdAVQ9cPtpwbwRl/D+280qRfPufsfCIp6EJHk+sxHQGT
	 /s7y932t4HSzI8JS3toWqh3Gg9mFglb/ObSfITbxFZ/N0tuoXG65YTXZGYUZwPo3T0
	 n12MdTUxSmcMDMEhn5xZ1JSvBBFpNKUwCmqTUZ+Aux9jPM9+3cZwqCXqMS/76N2bO9
	 UGPHvA1pjBymw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260915194611.2674127-2-arighi@nvidia.com>
References: <20260915194611.2674127-1-arighi@nvidia.com>
 <20260915194611.2674127-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:57:52 +0000
Message-Id: <20260915195752.80F431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sched_ext: redundant idle kick processing for lazy preemptions
--

commit 42fa214a424ea8999256e25137769c2bfce81537
Author: Andrea Righi <arighi@nvidia.com>
sched_ext: Add lazy preemption support

This commit adds lazy preemption support to sched_ext, allowing BPF
schedulers to request deferred rescheduling. It introduces new enqueue and
kick flags for lazy preemption, and updates the task slice expiry logic.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f875c50f00bbe..819995667cc26 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -8574,6 +8626,14 @@ static void kick_cpus_irq_workfn(struct irq_work *=
irq_work)
>  			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
>  		}
> =20
> +		/*
> +		 * kick_one_cpu() clears the lazy bit of every cpu it visited
> +		 * above; visit the remaining requests which contain lazy
> +		 * preemption, see scx_kick_cpu().
> +		 */
> +		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
> +			should_wait |=3D kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
> +

[Severity: Low]
Does this loop in kick_cpus_irq_workfn() intentionally skip clearing
cpus_to_kick_if_idle for the CPUs it processes?

If a BPF scheduler issues both an idle kick and a lazy preemption kick on
the same target within a narrow window, but without a non-lazy kick, the
target CPU is serviced by this loop.=20

Because this loop fails to clear cpus_to_kick_if_idle for the visited CPU,
the subsequent idle loop immediately below it will redundantly lock and
evaluate the same CPU again.=20

Could this cause a minor performance inefficiency due to the redundant
evaluation, and should cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle)
be added here as well?

>  		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
>  			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
>  			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915194611.2674=
127-1-arighi@nvidia.com?part=3D1
