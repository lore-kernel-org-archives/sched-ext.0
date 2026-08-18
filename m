Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122685B21A;
	Tue, 18 Aug 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088806; cv=none; b=BuPFOZonZacs09N/ZmxNnuWpwM9UwyHGvyak1iLN3pZzgqkUZ9WfYV6minhdR1iR4oVMakV0ytyri+ZdR3PJZ7/L//3uhYqwEAts614fjqtVuyJZVsV3t/PmY8A3prxtkkwW0x7YjXEj7uBEp4w4Kbv37B0JauNDc/upqSU7gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088806; c=relaxed/simple;
	bh=6/F2n2xgqXi8tnfmNfjq4MbcmIJ7fNaBh2L63hPR9GQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fNE+SUmgqeDh047gM5pbFENq7G21x7QzPaRSxmQsredHGcvk5PCT3aIZqTd86v49il+nMZNDXQiYRizmvfaMAn4cHdME2TCr7Rs8UtTpU2W+9B98H0yasBj5RHSD53gaOMaxZOWY4vSi3dSODd8j49euil13N64hLYGaQETP30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA1/R+Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA1/R+Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B701F000E9;
	Tue, 18 Aug 2026 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088804;
	bh=6RBq0peoeyJ8d7IrQlPxjRwmSuGeIm62hZPGpqNoLXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nA1/R+BaVGBJ1n5Cv2TMNIvRW/tv5HoXVlG+S/SINW5EEomx5/5QFvgTCRYFojuFC
	 BcC0a0+CZfQTr+hMcCrR3p6aTtYmARzsgZKKtcuVJp4mnetapLVRCwsrooS6VfuyVt
	 UlPr+0iHRKpcGS+IiMpUuY09JYdUE5ZJPcNlM4VZWnt1zVRr+i+ZyOUO6XdWpD6RFn
	 P8ZDDpSmwlaq5eXpX9DC220nnGwpp29eEu7yl4VVTaNubxGIwVrq+mShEFmFxa20u6
	 zgWz4l6UF9Byf4FGYblnLl4cq0//f1wNvljwfSR6WuX0loZXLtA6xBIMhyXChwARMa
	 BMKxCzNvUMd+Q==
Date: Tue, 18 Aug 2026 11:33:23 -1000
Message-ID: <e2f7a97a70966c6d132a494500b55811@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: sashiko-bot@kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Gavin Guo <gavinguo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Sync common and compat headers from the scx repo
In-Reply-To: <20260818210732.AB27B1F000E9@smtp.kernel.org>
References: <20260818205711.3175265-1-tj@kernel.org> <20260818205711.3175265-3-tj@kernel.org> <20260818210732.AB27B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Aug 18, 2026 at 09:07:32PM +0000, sashiko-bot@kernel.org wrote:
> > +/*
> > + * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) calls
> > + * migrate_disable() for the current task. Recorded once by
> > + * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires during
> > + * the natural scheduler-attach call chain (auto-attached by scx_ops_attach!).
> > + *
> > + * Defaults to true (conservative). Over-reporting in is_migration_disabled()
> > + * causes local-only dispatch, which is safe. Under-reporting can crash the
> > + * scheduler, so we err high if the probe somehow fails to run.
> > + */
> > +bool __scx_prolog_disables_migration __weak = true;
>
> [Severity: High]
> Does this default value actually under-report if the probe fails to run?
>
> The documentation indicates that the fallback should err high (over-report)
> to avoid crashing the scheduler. However, looking at the slow path in
> is_migration_disabled() below, when __scx_prolog_disables_migration is true,
> the macro evaluates bpf_get_current_task_btf() != p. This causes it to
> return false for the current task, which means it incorrectly assumes
> migration is not disabled (under-reporting).
>
> Should the default value of __scx_prolog_disables_migration be false
> instead, so that it falls back to returning true?

The comment and the default do disagree. true matches the stock pre-v6.18
prolog behavior, so a failed probe still yields correct results on stock
kernels. However, if the probe fails on a kernel that cherry-picked
8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for trampoline.c"),
is_migration_disabled(current) under-reports, which is the direction the
comment claims to avoid. Erring high would be defaulting to false.

Changwoo, this code is synced from the scx repo. Can you update the scx
side, either flipping the default or fixing the comment? I'll re-sync
afterwards.

> > +static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
> > +{
> > +	struct rq *rq;
> > +
> > +	if (bpf_ksym_exists(scx_bpf_cpu_curr))
> > +		return scx_bpf_cpu_curr(cpu);
> > +
> > +	rq = scx_bpf_cpu_rq(cpu);
>
> [Severity: High]
> Will this unconditionally call scx_bpf_cpu_rq() on newer kernels?
>
> If both scx_bpf_cpu_curr and scx_bpf_cpu_rq have been dropped from the kernel
> tree, on modern kernels bpf_ksym_exists(scx_bpf_cpu_curr) evaluates to false
> and the fallback path is taken.
>
> Because the call to scx_bpf_cpu_rq() is not guarded by its own
> bpf_ksym_exists() check, won't libbpf poison the missing call and cause the
> BPF verifier to reject the program on newer kernels? Should we guard the
> fallback call as well?

scx_bpf_cpu_curr() wasn't dropped. It was added in v6.18 and only
scx_bpf_cpu_rq() is being removed, so there is no kernel where both are
missing. On kernels without scx_bpf_cpu_rq(),
bpf_ksym_exists(scx_bpf_cpu_curr) is constant true, the fallback is dead
code, and the poisoned call to the missing __weak ksym never reaches the
verifier.

Thanks.

--
tejun
