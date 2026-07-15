Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729652DCF74
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150160; cv=none; b=TKyfLSHPDmhCuXsakafCa3kdY9fVuxJMI7ZtXhqxpFtEhnJJtDR4RSXYHYUkhvZ2XJAJYpyb8IVExNCuEPM8CGV6R3cBP4H2DXqckNUdmNZQKQtStbYJ4pFSfCga0dDejL5sq9do7ZmY6cMVz9ZmbBbo5YaMDU5UC+2FVbA3I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150160; c=relaxed/simple;
	bh=IQDnrY+kFdJpp9HfBGXBbjwu+NFAzN68KX4Vw9U/9CM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fDkFFkFcVbIgFVOh6yY5IKx94qW4rfNlfskkzc12waIbFYqHB9eRll3ZX5Vl2M1dXXtAIQi8l8HQA4+k8ipjgWt29uxrszPuHJER3WThl59hWOnDTLlatMOTFy5ji3SWknTeNLygcFTzmApewKGkvYrg8+wybsxB/nSSzlOH28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoJu6Lfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoJu6Lfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20D01F000E9;
	Wed, 15 Jul 2026 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150159;
	bh=hnqsNXxqM2hPcXfVXIO1o9YBfcJkHhXO+yGmnrWE9XA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KoJu6LfcUyT+TZuIvKnLSUZuDI2eyhf2kaYwU385B8EXt+N088AJ8RZIpgv77L1BI
	 x4jZHrnkHmPbwqvkzI3aCKHNYPU4phx+oBKeOobUS1be/zZe6vgicWCvz4K4/3o+70
	 kJcnP1Zi4o4/L9Gmz0EMX54KeDkeOSnd6HBT1s8gON2aveKU8nElUN2oTAZRTbOtdZ
	 PPQ4L6u2vm3fFSGwHT7SG6mKDtcZFWXirNV1kHpRQvAqAvcki2l230lRwUnCm2PMGW
	 IFOVKhVj7APgQxhZv+nLhF1KqRPcjZS9Tx0sTcXF3eYFTgpPR7WOarcVY9gpOUCB9w
	 lW0fD5g/fd5cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260715205622.276220-7-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-7-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:15:58 +0000
Message-Id: <20260715211558.E20D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete migration from rq->curr to rq->donor for proxy executio=
n breaks capability revocation, preemption checks, and BPF kfuncs.
--

--- Patch [6]: [PATCH 06/11] sched_ext: Split curr|donor references properl=
y ---
commit 8ca59038e09f66e910a65ddcaf538ce84385abf5
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

This commit updates sched_ext to use rq->donor instead of rq->curr where
appropriate to correctly handle proxy execution. This ensures that the
scheduler-selected task (donor) supplies the scheduling context and budget,
even when a different task physically executes on the CPU.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 8d8057b80d544..0d2f34c79083f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8030,7 +8049,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_=
pcpu *pcpu, struct rq *this_r
>  	unsigned long flags;
> =20
>  	raw_spin_rq_lock_irqsave(rq, flags);
> -	cur_class =3D rq->curr->sched_class;
> +	cur_class =3D rq->donor->sched_class;
> =20
>  	/*
>  	 * During CPU hotplug, a CPU may depend on kicking itself to make
> @@ -8047,7 +8066,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_=
pcpu *pcpu, struct rq *this_r
>  			if (cur_class =3D=3D &ext_sched_class) {
>  				if (likely(!scx_missing_caps(pcpu->sch, cpu,
>  							     scx_caps_for_preempt(pcpu->sch, rq))))
> -					set_task_slice(rq->curr, 0);
> +					set_task_slice(rq->donor, 0);
>  				else
>  					__scx_add_event(pcpu->sch,
>  							SCX_EV_SUB_PREEMPT_DENIED, 1);

[Severity: High]
Should this migration from rq->curr to rq->donor also be applied to other
functions that interact with the scheduling context?

For example, in reenq_local(), capability revocation eviction appears to ch=
eck
the physical lock owner instead of the proxy donor:

kernel/sched/ext/ext.c:reenq_local() {
...
	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
	    rq->curr->sched_class =3D=3D &ext_sched_class &&
	    scx_task_reenq_on_cap_revoke(rq, rq->curr)) {
		set_task_slice(rq->curr, 0);
...
}

Could this cause capability revocation to fail for proxy donors executing
on behalf of non-EXT tasks?

Similarly, scx_caps_for_preempt() evaluates capabilities against the physic=
al
lock owner:

kernel/sched/ext/sub.h:scx_caps_for_preempt() {
	struct task_struct *curr =3D rq->curr;
...
	if (curr->sched_class !=3D &ext_sched_class ||
...
}

Could this allow unauthorized preemption if the proxy donor is an EXT task
but the physical lock owner is a non-EXT task?

Additionally, BPF kfuncs scx_bpf_task_running() and scx_bpf_cpu_curr() repo=
rt
the physical owner instead of the expected scheduling context:

kernel/sched/ext/ext.c:scx_bpf_task_running() {
	return task_rq(p)->curr =3D=3D p;
}

kernel/sched/ext/ext.c:scx_bpf_cpu_curr() {
	return rcu_dereference(cpu_rq(cpu)->curr);
}

Does this expose the physical lock owner instead of the proxy donor context,
potentially confusing the BPF scheduler which expects to see the EXT task it
dispatched?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715205622.2762=
20-1-arighi@nvidia.com?part=3D6
