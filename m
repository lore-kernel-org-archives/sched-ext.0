Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4D2E7BD3
	for <sched-ext@lists.linux.dev>; Tue, 18 Aug 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087254; cv=none; b=SkNucfAY0cWThlhdKOLP6X1WEJJscfdgDXWRg6Faw0R0/N/BZIQnghWQldPhOOlajD58ICDg08k4w7yRqjCqKBf4PrtCi42lFypMo0pquI7JUV9VvLydBAQTx36AGQS6RftZSTcbPZaxdSBaurQTJRvED7O8lgdlwq+gJ4/oKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087254; c=relaxed/simple;
	bh=hwhuVhgG1ZS6dGh0TOKsz/ObxWnIxVXJWJ10YrySh9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g4wxVgTgos7ppKNlNS6KY9CI9ogEdje/dSrCnKdr0IFDr82By2i10mFRbVNoKPFm2yZsdJ6Eg/5SyXxYaD7rMhM3D7qeFUQIH6BLbv88j2mg4CzfusEaYQtEqOsz31F0zb7epMDn6jioABQFdL15ay4UGeEn4MzwGE7fXLjawoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljBGWwzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljBGWwzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27B1F000E9;
	Tue, 18 Aug 2026 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787087252;
	bh=OXTlWHXLJRf4UujnfX26rbsbN5i/3yyjA45mOgJeoeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljBGWwzMyuHefJLtBFu8HGZ8ECczCJGqR0MbelP0UYgyNibEHcPI8fSmdc3MLOkvq
	 8hnZ4hfJAEpW1eP8jvoktceHxWIlsL1nAlMD+sjhPzUrrPgim6w0LIUCBWR6hDE2n3
	 c1cXwFjHneHZoTpFHaqKLC1blXTGdLmAydl9gh01n8dNFThdj9egql4JuMiVWV2dKE
	 R9ZKlSL3cDwXVgyNZWLd5KaP/+Flw3ru6aUM3eTo+LHApRxy3k4sUxH8kiwA0lgskl
	 e4VWWUlTvEU3lARv7sEk7HRrHUb0lmpAGW65gS+zN66vn5hc1HDRJUQH6vNH6Ser1R
	 8SCwGTcFDvBsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Sync common and compat headers from the
 scx repo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260818205711.3175265-3-tj@kernel.org>
References: <20260818205711.3175265-1-tj@kernel.org>
 <20260818205711.3175265-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 21:07:32 +0000
Message-Id: <20260818210732.AB27B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The default value of `__scx_prolog_disables_migration` contradicts=
 its safety documentation and causes dangerous under-reporting.
- [High] Missing ksym guard for `scx_bpf_cpu_rq` causes BPF program load fa=
ilure on newer kernels.
--

--- Patch [2]: [PATCH 2/2] sched_ext: Sync common and compat headers from t=
he scx repo ---
commit d5556fe1c132d0cef0267d7ea8593fa9b725e9e6
Author: Tejun Heo <tj@kernel.org>

sched_ext: Sync common and compat headers from the scx repo

Sync common.bpf.h, compat.bpf.h and compat.h with the scx repo. This=20
includes updates to 64-bit enum recovery, is_migration_disabled() logic,=20
and backwards compatibility for scx_bpf_cpu_curr and scx_bpf_cpu_rq.

Link: https://lore.kernel.org/all/20260817143126.562923-1-changwoo@igalia.c=
om

> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 979d4cabfaf98..76f5e025e1076 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h

[ ... ]

> @@ -527,32 +529,103 @@ static __always_inline const struct cpumask *cast_=
mask(struct bpf_cpumask *mask)
>  	return (const struct cpumask *)mask;
>  }
> =20
> +/*
> + * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) ca=
lls
> + * migrate_disable() for the current task. Recorded once by
> + * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires dur=
ing
> + * the natural scheduler-attach call chain (auto-attached by scx_ops_att=
ach!).
> + *
> + * Defaults to true (conservative). Over-reporting in is_migration_disab=
led()
> + * causes local-only dispatch, which is safe. Under-reporting can crash =
the
> + * scheduler, so we err high if the probe somehow fails to run.
> + */
> +bool __scx_prolog_disables_migration __weak =3D true;

[Severity: High]
Does this default value actually under-report if the probe fails to run?

The documentation indicates that the fallback should err high (over-report)
to avoid crashing the scheduler. However, looking at the slow path in
is_migration_disabled() below, when __scx_prolog_disables_migration is true,
the macro evaluates bpf_get_current_task_btf() !=3D p. This causes it to
return false for the current task, which means it incorrectly assumes
migration is not disabled (under-reporting).

Should the default value of __scx_prolog_disables_migration be false
instead, so that it falls back to returning true?

> +
> +/*
> + * scx_lib_init_probe - non-sleepable prolog probe.

[ ... ]

>  static inline bool is_migration_disabled(const struct task_struct *p)
>  {

[ ... ]

> +	if (bpf_core_field_exists(p->migration_disabled)) {
> -		if (p->migration_disabled =3D=3D 1)
> -			return bpf_get_current_task_btf() !=3D p;
> -		else
> -			return p->migration_disabled;
> +		if (p->migration_disabled =3D=3D 1) {
> +			/* Fast path: prolog always disables migration */
> +			if (CONFIG_PREEMPT_RCU)
> +				return bpf_get_current_task_btf() !=3D p;
> +			/* Fast path: prolog never disables migration */
> +			if (LINUX_KERNEL_VERSION >=3D KERNEL_VERSION(6, 18, 0))
> +				return true;
> +			/* Slow path: pre-v6.18, !PREEMPT_RCU - use runtime flag */
> +			return __scx_prolog_disables_migration ?
> +			       bpf_get_current_task_btf() !=3D p : true;
> +		}
> +		return p->migration_disabled;
>  	}
>  	return false;
>  }

[ ... ]

> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 3ab642f92c8a5..6944221f96cc0 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h

[ ... ]

> @@ -238,6 +243,26 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 =
enq_flags)
>  	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
>  	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
> =20
> +/*
> + * v6.18: Add a helper to retrieve the current task running on a CPU.
> + *
> + * The kernel tree dropped this helper and scx_bpf_cpu_rq(), but schedul=
ers in
> + * this tree still support pre-v6.18 kernels where scx_bpf_cpu_curr() do=
esn't
> + * resolve and the scx_bpf_cpu_rq() fallback still exists. Keep it until
> + * pre-v6.18 kernels fall out of the support window.
> + */
> +static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
> +{
> +	struct rq *rq;
> +
> +	if (bpf_ksym_exists(scx_bpf_cpu_curr))
> +		return scx_bpf_cpu_curr(cpu);
> +
> +	rq =3D scx_bpf_cpu_rq(cpu);

[Severity: High]
Will this unconditionally call scx_bpf_cpu_rq() on newer kernels?

If both scx_bpf_cpu_curr and scx_bpf_cpu_rq have been dropped from the kern=
el
tree, on modern kernels bpf_ksym_exists(scx_bpf_cpu_curr) evaluates to false
and the fallback path is taken.

Because the call to scx_bpf_cpu_rq() is not guarded by its own
bpf_ksym_exists() check, won't libbpf poison the missing call and cause the
BPF verifier to reject the program on newer kernels? Should we guard the
fallback call as well?

> +
> +	return rq ? rq->curr : NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818205711.3175=
265-1-tj@kernel.org?part=3D2
