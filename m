Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980315;
	b=2VgB/U61YOQGAkJuw3/LWzRMr2pgU92qEov9fqe5WdLZZH4gIpMFtnJavi9jOfMKnjKH
	 AOV5zLWOKAj9MOEecbDdKGBNSjpgM08hEpHCimqRAEgt3uop8+UJowjC8m/gMKg5nInDe
	 azuCcuIrbkUL1BH0/iwL40JZ+1+/dS0KTMA4Ka/4Id8b8wcAHgAZUghwRjL0iEZsYUG4U
	 tSoJ2UZKPoAZlg4JiLlQHsPT2Hscpb4jFCxNw1IV0PZV73xmSLd8W+bGLgmTMS9EevhG5
	 vI3ccNxE76+UXzAU1R3+wV6S+iSvqpfEbsEHvbsoSnozC7Jm3as3bnxxfW7vw+I4d/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=91JI+yvUQ5ZY1tTORn4r2SloSv4vb/kr9Y1CPLV/xfc=;
	b=Jwqn/nQWf6ZDxWh+o9xMlu12TIvAgh8QgcDbNAB0gG7WWG4F//VG9PUodIY7VdSNIbE4
	 rShsnwiJSqnsb5vH3xPlHL/2dcSoFqg5zpTQZglYvpGS6+7uA2jNCb2UEU63ahiYzXd0A
	 FjrY0gtGd6BYj1yrGfW8+892KDv+g3fTCr6tVsXYZQ4hNDx004qyYadCua6dYxSjCgS1x
	 rXnhcxKCFn2HEvQfjJMN9aykzyjRh5V75tMQOddl68jxLfa9HQe9qXJTBpi1irNz6aGwY
	 ZO36eXfNMdsNmcf7vFl9mn30lcEelR/2V26IaBICmCeK2BaJ/PBVUE7Ht/jCUC1rBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZEnWpzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155C606A329
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZEnWpzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8E1F008A1;
	Fri,  6 Nov 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980314;
	bh=91JI+yvUQ5ZY1tTORn4r2SloSv4vb/kr9Y1CPLV/xfc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EZEnWpzKPUWcZSo26EUNQr3TpIk8HHRiYo7v4xvqc6VkzovmuE2wbMCy+G0oCaKZ2
	 eqBEhr874gf+YAEpHdFjzyTZLBLXifYmqRLVsiFGU2O2iWUOEX9ekBFd+UwVzui5HV
	 RHDUwuCZvxlF03yzxGX/7cEHFldpReyj9KeKS3kyrbJCIPvHT1zYaA4Q9MFm4N1/W+
	 8mvblaXr8+Qem9DhV0nYVY+ramZ9fbfCdRPqvd1SubHcn0bhi5xTiOQL66NvzoVMjK
	 HxXLHKPNs1+lQTLdjDt3rXnD2DIzDnKOdyh4UjK9AZGx7RJLLmXGcTemx899FhKGy4
	 r6FzKJrkDDAYA==
Message-ID: <sashiko-outbox-201739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/20 v3] sched/fair: Support not wakeup case in
 select_idle_sibling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-13-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-13-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:51:53 +0000
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
- [Low] sched/fair: kernel-doc parameter mismatch for @rq in
  idle_rq_without()
--

commit ab3889b91b4dc4e984d6982f09014756fc8d7899
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Support not wakeup case in select_idle_sibling

This commit updates choose_idle_cpu() to check whether a runqueue would be
idle without an already-enqueued task p, and renames idle_cpu_without() to
idle_rq_without() to take a struct rq pointer.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f2a0d2c2bb632..980eda9c935a8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -12968,23 +12985,21 @@ static unsigned int task_running_on_cpu(int cpu=
, struct task_struct *p)
>  }
> =20
>  /**
> - * idle_cpu_without - would a given CPU be idle without p ?
> + * idle_rq_without - would a given CPU be idle without p ?
>   * @cpu: the processor on which idleness is tested.
>   * @p: task which should be ignored.
>   *
>   * Return: 1 if the CPU would be idle. 0 otherwise.
>   */
> -static int idle_cpu_without(int cpu, struct task_struct *p)
> +static int idle_rq_without(struct rq *rq, struct task_struct *p)

[Severity: Low]
Should the kernel-doc comment for idle_rq_without() document @rq instead
of @cpu to match the updated parameter list and avoid W=3D1 kernel-doc
warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D12
