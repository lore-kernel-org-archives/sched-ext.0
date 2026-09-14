Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE019449ED7
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397906; cv=none; b=URJtUCMzzjYxMK35oR+mJ8jZGm7a3egb8dRqdCwOsGYQbUYCEflPhpmX2h1W5FGN/ykIYbI74yBPPRttDY74rHV+4Nzh7aRkW2ZRNfMTYealNoVqwbaw3Q44T35Xm+yteti12WfYaPdKiQhxnUcxa+caXWDyMHvKPMy57gOKV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397906; c=relaxed/simple;
	bh=coW5ThGW44Evm6qa8qCHqAjhpK21l49ITHWwDqOvTU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btZYofKdTfr5osBG8fkF63TA86PEbNHvEFdkZAZD9iuFdtPAyLNeQi7NJMJgTwDmiiaZXMTLvqE0fcqkOZbKVtE3H041fPraJr+L1pOsWb0tPhCNgRJeO/X/VTVshRjDd3QxeBGifXZTRWCphsz0iYGP2SEvJt3V7Yr4nnx22XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSBwBOyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSBwBOyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDAA1F000FF;
	Mon, 14 Sep 2026 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397904;
	bh=663MqoHMFtz7l3OHE5EPbyxYctS46CBU9+a0vmIuHxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSBwBOydPjPkYR7dAr4FWyJl6ffvCY3qmdmN81GvHC6MQzfYR12YjffF1ou3pRYw1
	 kOEYkNE1D+Lbp1XruNhfZTp5IDI/qYSNmkl0z+SdrDFdMtX0+rdSN9ohHvgeiNUStZ
	 2RQBpUo7xo1OtJ29aW508y3zeCU1x9/Z4UVSq4/dF0+CSsG9QlCXYCeu1MrGlkVDT1
	 WQQBuWZwuX01y/3JVNFnBDGDH9ouyqxb9wlWS0L4NjCaJ4nZQtC5LmHvYdCZRl8Jbw
	 TDgU38QBSOzZOx/uiXEyVrLAjzPZxbsWUfJqZShiwb5Oa/GjsrstZTlYWQGnnFSGvK
	 uIgjP/A5DBCDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260914144620.2032614-2-arighi@nvidia.com>
References: <20260914144620.2032614-1-arighi@nvidia.com>
 <20260914144620.2032614-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:58:23 +0000
Message-Id: <20260914145824.3EDAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SCX_KICK_WAIT synchronization fails permanently when combined with=
 SCX_KICK_PREEMPT_LAZY because the synchronization return flag is completel=
y discarded.
--

commit 9fb7f95cc0c5449c9ecc76666403b400b99be566
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Add lazy preemption support

This commit introduces lazy preemption support for sched_ext by adding
SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY. It updates the tick logic
and dispatch queues to handle lazy rescheduling correctly while preserving
precedence for immediate preemption and wait requests.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -8572,6 +8624,14 @@ static void kick_cpus_irq_workfn(struct irq_work *=
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
> +			kick_one_cpu(cpu, pcpu, this_rq, ksyncs);

[Severity: High]
When SCX_KICK_WAIT is combined with SCX_KICK_PREEMPT_LAZY, does this
discard the wait synchronization requirement?

kick_one_cpu() returns a boolean indicating whether synchronization is
required. In the primary loop above, the result is accumulated into
should_wait, but here the return value is ignored. If a CPU is only
processed in this lazy preemption loop, the caller might proceed
prematurely, breaking the SCX_KICK_WAIT guarantees.

[ ... ]
> @@ -9591,12 +9683,15 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu,=
 u64 flags)
>  		}
>  		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
>  	} else {
> -		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
> -
> +		/* Accumulate requests and resolve their precedence at delivery. */
>  		if (flags & SCX_KICK_PREEMPT)
>  			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
> +		if (flags & SCX_KICK_PREEMPT_LAZY)
> +			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);
>  		if (flags & SCX_KICK_WAIT)
>  			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
> +		if (!(flags & SCX_KICK_PREEMPT_LAZY))
> +			cpumask_set_cpu(cpu, pcpu->cpus_to_kick);

[Severity: High]
Does skipping the assignment to cpus_to_kick when SCX_KICK_PREEMPT_LAZY
is set force the CPU to be processed exclusively in the secondary loop in
kick_cpus_irq_workfn()?

Because the CPU is omitted from cpus_to_kick here, it bypasses the primary
loop where should_wait is accumulated. Instead, it gets handled entirely
in the cpus_to_preempt_lazy loop where the return value of kick_one_cpu()
is ignored, preventing the wait request from being properly respected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144620.2032=
614-1-arighi@nvidia.com?part=3D1
