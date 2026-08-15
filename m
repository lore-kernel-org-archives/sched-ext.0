Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCF1E32D6
	for <sched-ext@lists.linux.dev>; Sat, 15 Aug 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773845; cv=none; b=QWXrQNwg5MSEePQs8xPHHOetpJpfUKBKsNJPHVaxITLi68OsHmTf+8k6iaJZGXrfaGtT2xt+6mH/L9rK2JmKBAxmJoIO/yhuDcJbOn08aLfjmBUz0yRCzehWfr6ty3R2d/Y533YewLwe/PDpNh0DEtxlU1LyloJWdbvRxjPTZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773845; c=relaxed/simple;
	bh=W+NZ3pjWiNgMLDn+5ei/FwPxx2QgaYV7nkVMzsJ+rHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hah9E4qpEhV+OSAvgVkS2XVANw/rBaQ/B0tbmeMI2tqCsKQ+nDbcgn9gMvJK2zamq1EgKK7nqxs69pcn9iwMMW2J0IHRzWf/+uBoRsNLwJ7B4QnN7Zrgg63D8oWGwRaBLvWB5I2tBypIjlkio5gveuUc8rIYeerJopRIh8PuJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubizyo/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubizyo/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C69F1F000E9;
	Sat, 15 Aug 2026 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786773843;
	bh=tagnhSsFz/xKwy6+gjGb3wCVRlk5yqql1EhYNu9DGBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ubizyo/ptd5yCs63S7yTY+p3lRZ4S4hYhcHZRz9bXSFdn2hvFt1W0fCQF4R0AW0Ru
	 VbR37cVArj8dssYSUzQ634yXviMlyf5qg+9uxaAywP8hfJ41N+NRfaUSu9GkPrfgtj
	 QB1Q4XyrdN63QmL6Htru5ccmdw+ADXsqPlDNFnabYY55+hzGmj+dnrSSkF5fLE1riG
	 1Lc15loGb3Hkqa3X1irM12Xh1En6rp9T4wznCvuV2QJSesijyMBH3fd/DqhuaOdnKu
	 X3YyS5iWbBy0jSOpet5QyDxWm/sZni8IqcaQ/YPI0I1oSfKlLtFJ8t7RrTLu4VzThe
	 8DRSFKs+M+mfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Make scx_bpf_events() read the calling
 scheduler's counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260815055107.115671-3-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
 <20260815055107.115671-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 06:04:02 +0000
Message-Id: <20260815060403.0C69F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A tracing or syscall BPF program can cause an out-of-bounds memory=
 read by associating with a non-sched_ext struct_ops map (like `tcp_congest=
ion_ops`), which is then incorrectly cast to `struct sched_ext_ops *` by `s=
cx_prog_sched()`.
--

--- Patch [2]: [PATCH 2/2] sched_ext: Make scx_bpf_events() read the callin=
g scheduler's counters ---
commit c53feaf881922f5f2912216d45a7b765df97ad06
Author: Tejun Heo <tj@kernel.org>

sched_ext: Make scx_bpf_events() read the calling scheduler's counters

scx_bpf_events() now resolves the scheduler from the calling program with
scx_prog_sched(), instead of always reading the root scheduler's event
counters.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 40c9467d8b186..ee865d0f65112 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -10418,19 +10418,23 @@ static void scx_read_events(struct scx_sched *s=
ch, struct scx_event_stats *event
>  	}
>  }
> =20
> -/*
> - * scx_bpf_events - Get a system-wide event counter to
> +/**
> + * scx_bpf_events - Read the event counters of the calling scheduler
>   * @events: output buffer from a BPF program
> - * @events__sz: @events len, must end in '__sz'' for the verifier
> + * @events__sz: @events len, must end in '__sz' for the verifier
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> + *
> + * Read the event counters of the scheduler associated with the calling =
program.
> + * @events is zeroed when no scheduler can be resolved.
>   */
> -__bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
> -				size_t events__sz)
> +__bpf_kfunc void scx_bpf_events(struct scx_event_stats *events, size_t e=
vents__sz,
> +				const struct bpf_prog_aux *aux)
>  {
>  	struct scx_sched *sch;
>  	struct scx_event_stats e_sys;
> =20
>  	rcu_read_lock();
> -	sch =3D rcu_dereference(scx_root);
> +	sch =3D scx_prog_sched(aux);

[Severity: High]
This is a pre-existing issue, but does this expose us to a type confusion
and out-of-bounds read?

Looking at scx_prog_sched() in kernel/sched/ext/internal.h, it retrieves
associated struct_ops:

kernel/sched/ext/internal.h:scx_prog_sched() {
    ...
    ops =3D bpf_prog_get_assoc_struct_ops(aux);
    if (likely(ops))
        return rcu_dereference_all(ops->priv);
    ...
}

If a BPF_PROG_TYPE_TRACING or BPF_PROG_TYPE_SYSCALL program is associated
with a different struct_ops map (like tcp_congestion_ops), the pointer is
blindly cast to struct sched_ext_ops *.

Since struct sched_ext_ops is much larger than other struct_ops structures,
reading ops->priv could read memory well past the end of the map allocation
and cause a kernel panic when the garbage value is dereferenced as a
struct scx_sched *.

Does scx_prog_sched() need to verify the type of the associated struct_ops
before accessing ops->priv?

>  	if (sch)
>  		scx_read_events(sch, &e_sys);
>  	else

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815055107.1156=
71-1-tj@kernel.org?part=3D2
