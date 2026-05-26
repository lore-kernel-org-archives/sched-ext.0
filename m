Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E23CFF72
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787349; cv=none; b=f8TDry8mCB7EGc5zbsMxU68OBg0NEfJg6glXYGyJQcLhFhjREjLA86B+XHOqpqFqLBobrZ860OhaqMpi83SvjLhpsGUahQ/4zouHsWP2mHHSBQEB8Zva3QbhoAVsh7sF87oYazSqIDWzY7GVZkVvXuJN3z8RkJVTKacce5wN7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787349; c=relaxed/simple;
	bh=NEvkckh490Yo02xMjylUw4jsTJqU10w0awqPyTb05Jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBCDvjPrblHDAtre7PjXERB/I/U/Uhnm9cBE5YtzH99j8Mc9GgqQkGrYo6juWZ4z/JxDMgZAr22cc4HJrP2CZ2bT20KwnGcYRpVe5QafRYOVCZTfOwTE+6uAHzZlNo2EQKS4plKNomIBakcQKBfNRAlDmS2P8sm9NUEpvyz58Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJLtVm8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJLtVm8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6891F00A3A;
	Tue, 26 May 2026 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787348;
	bh=DwrFCW3rfZvAKdTRALvJM7AX59EUMJ5cDqYSW9cDRBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJLtVm8pp7Hmmba8N6WOXgV3SSrjBx6+4BFaPDSQZ777JP0OdPHzpcFGzKsTtCYfC
	 9xYlPgK2up9CmgbnY6NAIQVfegdwTEkPvHNLMDNiiZiugLmiWIYq9hMUui2G4Z7aIr
	 8yKpVNzwM+ekTenorX1JsPtXekpmrQA94Mfwfk4aAPeZcC4izjqagIKC4n8nH0rjly
	 qhwkuZhfMa+6764fNBRkgeGqtmC46W/fztIx9ELXHfoXjHzQqHhCULhEvaadZs3IPs
	 2q3h9ASmfa2G8NVkuYgiy3x7BHQ78O94UjrMSYr6Z00xM+umphIr8jAPIBEdAjNTxA
	 fPMHGK9oAZang==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260526082954.550958-2-arighi@nvidia.com>
References: <20260526082954.550958-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:22:27 +0000
Message-Id: <20260526092228.3B6891F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypassing the overflow check for detached deadline servers allows =
configuring an arbitrarily large bandwidth for offline CPUs, breaking root =
domain admission control upon hotplug.

Pre-existing issues:
- [High] Modifying a deadline server's bandwidth via debugfs for an offline=
 CPU causes division-by-zero crashes.
--

commit e4e3b446a7561269980e46cfd4aec61572b0cae1
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Auto-register/unregister dl_server reservations

This commit makes deadline server bandwidth reservations dynamic by
introducing an attached/detached state. It ensures that only the currently
active scheduling policy registers its bandwidth reservation, allowing unus=
ed
bandwidth to be reclaimed without losing the configured runtime and period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ddfd6bc63ab1d..8de5f182fd659 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -1907,13 +1918,16 @@ int dl_server_apply_params(struct sched_dl_entity=
 *dl_se, u64 runtime, u64 perio
>  	cpus =3D dl_bw_cpus(cpu);
>  	cap =3D dl_bw_capacity(cpu);
> =20
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> -		return -EBUSY;
> +	if (init || dl_se->dl_bw_attached) {
> +		if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +			return -EBUSY;
> +	}

[Severity: High]
Does bypassing the overflow check for detached servers allow configuring an
invalid bandwidth?

If userspace configures a massive bandwidth for an offline CPU while the
server is detached, the overflow check is skipped. Later, when the BPF
scheduler is loaded, scx_root_enable_workfn() calls dl_server_attach_bw()
for all possible CPUs. For the offline CPU, __dl_server_attach_bw_locked()
skips its own overflow check since the CPU is not active, but it still sets
dl_bw_attached =3D 1.

When that CPU is later brought online, the hotplug rebuild path calls
dl_server_add_bw(), which unconditionally adds the unvalidated bandwidth to
the root domain's total_bw since dl_bw_attached is now true. Could this
force the root domain into a permanently overcommitted state and break
SCHED_DEADLINE admission control?

> =20
>  	if (init) {
>  		__add_rq_bw(new_bw, &rq->dl);
>  		__dl_add(dl_b, new_bw, cpus);
> -	} else {
> +		dl_se->dl_bw_attached =3D 1;
> +	} else if (dl_se->dl_bw_attached) {
>  		__dl_sub(dl_b, dl_se->dl_bw, cpus);
>  		__dl_add(dl_b, new_bw, cpus);

[Severity: High]
This isn't a bug introduced by this patch, but can modifying an attached
server's bandwidth on an offline CPU cause a division by zero?

When a CPU is offline, it belongs to a root domain with zero active CPUs, so
dl_bw_cpus() returns 0. If a user modifies the runtime/period via debugfs
for an offline CPU with an attached server, we reach this update path.

Both __dl_sub() and __dl_add() divide by cpus internally:

kernel/sched/deadline.c:__dl_sub() {
    ...
    __dl_update(dl_b, (s32)tsk_bw / cpus);
}

Since cpus is 0, will this trigger a kernel panic and allow a local denial
of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526082954.5509=
58-1-arighi@nvidia.com?part=3D1
