Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCC37EFE3
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273254; cv=none; b=cfsAhPLZS6hd1XLbSkL3v7jcDx0Ys9TktY8a1Ijqs0R579VLaDgeae1qqd2PJAGctPyDygs4RmDeCXkZ1iRBz77Av6CZWws3PsKnXHN7c3H9zNSqWDUg7M1lO1rMN7qDJHT++tk+NtUrdMqxO5hWF8yhdIvTZU3oST+94spCk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273254; c=relaxed/simple;
	bh=qDVl3R031gIIEb/Q5XJYesl8F7O4SraS3927vgvm1hI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrQge2H5BEZwm4rXQtu3+3cakG2NHZu4EcTJolvyBDa9Hj7LFqAPsOC35YZsZOaDVDKM9JBYQYTEQTKa/dtIHNKFRlM0MKf6J2SZdL6AMFLveo58L5ksoj1aQrtEd11mQkyevk2ahar2QIzBo0CiVMqDM/4Y9H0JctPdjT3JbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe0HmfTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe0HmfTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EC6C2BCB0;
	Fri,  8 May 2026 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273254;
	bh=qDVl3R031gIIEb/Q5XJYesl8F7O4SraS3927vgvm1hI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Oe0HmfTlUEWIuiKjfMHxinMCjezCmEq2CgNpPSPlHsZyjFoCIhKM9K/3Dpad4yzyX
	 coMb9C/rJZfGNas5N+3VfME+JiUEY3tSmE5I6ILFUEsewGIpMTeqdtr68vw4o2zzi6
	 MsLJw43h05TIAmro5n1IMotEGglGoIaOPQbI8qmKx7ebJ9aB1S+t/PW6n+ZhxcXQLK
	 wzIb96A924hAvuL25lTsyZ27HqpFh5JNld8BIXxZpvL2SZKFBhig2fl0C+IKesA8pg
	 cGSjPjqEXR6Uf3YoWvJB4z0iKBY0aq+qkK3/hrKKDhjvk7StFz6p3hKhKvaLlRZtUY
	 6HAxTbVN4gnLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize
 sch->disable_irq_work
Reply-To: sashiko@lists.linux.dev
To: Zqiang <qiang.zhang@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260508115045.23739-1-qiang.zhang@linux.dev>
References: <20260508115045.23739-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:47:33 +0000
Message-Id: <20260508204734.12EC6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch forces scx_disable_irq_workfn to run in hardirq context,=
 causing unbounded execution time with interrupts disabled, which severely =
breaks PREEMPT_RT latency guarantees.
--

commit 3f0e90ad5f7a3132810aa08d6137cba68235020c
Author: Zqiang <qiang.zhang@linux.dev>

sched_ext: Use IRQ_WORK_INIT_HARD() to initialize sch->disable_irq_work

This commit changes the initialization of the disable_irq_work in sched_ext
to use IRQ_WORK_INIT_HARD(). The intention is to force
scx_disable_irq_workfn() to run in hardirq context rather than a threaded
kthread on PREEMPT_RT, so that scx_dump_state() captures the expected
comm and pid.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 345aa11b84b28..c6b6038a97010 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -6559,7 +6559,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct sched_ext_ops *ops,
> =20
>  	sch->slice_dfl =3D SCX_SLICE_DFL;
>  	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
> -	init_irq_work(&sch->disable_irq_work, scx_disable_irq_workfn);
> +	sch->disable_irq_work =3D IRQ_WORK_INIT_HARD(scx_disable_irq_workfn);

Will executing this in hardirq context cause severe latency spikes or hard
lockups on PREEMPT_RT?

scx_disable_irq_workfn() calls scx_dump_state(), which performs a heavy
workload. It iterates over all possible CPUs, takes their raw_spinlock_t
runqueue locks, formats sequence buffers, saves stack traces, and executes
BPF dump callbacks.

Performing this work with interrupts entirely disabled can break PREEMPT_RT
latency guarantees.

Instead of moving the entire dump to hardirq context, could the original
task's comm and pid be captured and stored in scx_exit_info during
scx_vexit()?

This would allow the heavy dump workload to remain safely deferred to the
threaded kthread execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508115045.2373=
9-1-qiang.zhang@linux.dev?part=3D1
