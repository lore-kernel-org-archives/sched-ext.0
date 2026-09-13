Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FE30E0EE;
	Sun, 13 Sep 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789318216; cv=none; b=bf3Gb+8f/7tV7NIqO7Qod1C52PMEdgHs5kCtiSNtYbYXdTrKZONrf8jj+3rO2KeLk663ks8EBmj+9GFUgcuykifUCjzRar38L4Olu6UDHn5uFUANdVOat7eyqqGnUARe5F0F+y9L+4IOcc2cD0lZF+CA7ettHCkFhSKy9gzsDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789318216; c=relaxed/simple;
	bh=wj4ZET2zAbKIHeQpR3aYShj4XxSnLfoLq3SPGIZZ2M8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=LKfZbQumx1Cs68LoTOH35Po6zZPupFCV3tG7Rt587Ed7+dDxkqVptB06M1Fcqbxz1xumPAidwraf3uuZVpC/g65J2WrXci4lKe/a0eGanyifPqedt+f+6y+ktcqlk0InS0ZzhqmOHlQE66MTK4QL8cyXTrO6FpNl88Oz8eeYAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGlxj9jf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGlxj9jf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22751F00899;
	Sun, 13 Sep 2026 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789318215;
	bh=cT/Ct3npTn3qGSuTsKomZ8JiTFXvwSohL/rmg+3EyZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WGlxj9jf9MxIUJw7k/hEnnLtfd6UmJ7AZWE8cJrN/MKHQN1FI7DPneN+id6FD+Zz3
	 Uy/VM2f11p3zSufWElvofAzjC1Jblocd3IPl5EY+fZ3kZl/COgYwYwyDaF59T8MM97
	 vvUtgM+I4srHJjv9502uV3JrEClL86X8JbRLyfbr07ZfoZIdomq3gFl1vxEvrQmi3z
	 x5X448rvIMa2S+DSgHPqhL/YncByZuUCuMNspl40GNJehYABSuo+/B4dVdwlCBBJUG
	 3sUQp3xdN9jUzS+SluTu6v/5pAktUBb4wnKAQtv3ySk+qTWPHo4g42R3kR9YwCuYpB
	 2BRX2+k36Y62w==
Date: Sun, 13 Sep 2026 06:50:14 -1000
Message-ID: <050b21a95813f39e131ff1509ad76120@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
In-Reply-To: <20260911195800.974364-2-arighi@nvidia.com>
References: <20260911195800.974364-1-arighi@nvidia.com>
 <20260911195800.974364-2-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

This mostly looks fine to me, but the kick path changes could be simpler.

On Fri, Sep 11, 2026 at 09:56:53PM +0200, Andrea Righi wrote:
> +		if ((sch->ops.flags & SCX_OPS_LAZY_SLICE_EXPIRY) &&
> +		    !scx_bypassing(sch, cpu_of(rq)))
> +			resched_curr_lazy(rq);

Could lazy slice expiry be a per-task flag, with the ops flag providing the
default? That would let a scheduler choose immediate or lazy expiry for
individual tasks. BPF should be able to override the default in either
direction, with bypass still forcing immediate rescheduling.

There's also a NO_HZ_FULL corner case. If a remote target is running with
SCX_SLICE_INF and its tick stopped, resched_curr_lazy() sends no IPI, and
clearing the slice doesn't restart the tick. sched_tick_remote() calls
task_tick_scx() directly, bypassing the lazy-to-immediate promotion in
sched_tick(). With lazy expiry enabled, it keeps requesting lazy
rescheduling. That leaves delivery dependent on another interrupt, such as
the deadline server timer. Both the kick and enqueue paths need to arrange
progress for a tick-stopped target.

> +	if (preempt)
> +		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
> +	if (preempt_lazy)
> +		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);

Why not clear both masks where cpus_to_preempt was previously cleared,
including the skipped-kick path? There's no need for the additional
conditions here.

> +	if (unlikely((flags & SCX_KICK_PREEMPT) && (flags & SCX_KICK_PREEMPT_LAZY))) {
> +		scx_error(sch, "SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY cannot be combined");
> +		return;
> +	}
> +	if (unlikely((flags & SCX_KICK_PREEMPT_LAZY) && (flags & SCX_KICK_WAIT))) {
> +		scx_error(sch, "SCX_KICK_PREEMPT_LAZY cannot be used with SCX_KICK_WAIT");
> +		return;
> +	}

Do we need to reject all these combinations? PREEMPT should win over
PREEMPT_LAZY, as it does when separate calls request both. WAIT can force
immediate rescheduling. A plain kick combined with lazy preemption should
still clear the slice and reschedule immediately.

> +		if (!cpumask_test_cpu(cpu, pcpu->cpus_to_preempt))
> +			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);

[ ... ]

> +			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);

Can we just accumulate the requested bits and resolve precedence in
kick_one_cpu()? That would remove both the guard against cpus_to_preempt and
the clearing of cpus_to_preempt_lazy.

Thanks.

-- 
tejun
