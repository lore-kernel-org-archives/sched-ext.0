Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D13DA7D2
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818612; cv=none; b=OeUoTx18Ot9D2Kpv2/tfY94a8F/iWfvprt7iNcXC+CNCdXytb6nqVhcmSMAihOTF839jev0Dbr8RjexEGavNSZdc8wSPXQvmGuxvhbzu/mRVnxfGQx6iWGk+E46FKHILBoQym5gqPWmJFn7tniufWp0j6kjpmF14cOJaGOIzYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818612; c=relaxed/simple;
	bh=1qKCCnlTdJEVphI6P5lRF4YA2TBQwXGrVTlCGWdPnyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T8lMIbyW9nRY5s4liDiI+oSBs6CJrTJAGqfWNIxN6oUVDrEh4brT5xmrsew9G6Uw71gvtWqPkqKIY1hPWujwNoE6SyTCCBKAmcxLalE4j5nVVOTdbHGT11BSJ4Kyc3xkbVbEdPZ+4CHwPQaDSK72zW9NWjTPj0M6nDPR9TP5nLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCvGISPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCvGISPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58071F000E9;
	Thu, 27 Aug 2026 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818610;
	bh=cAWyLhd2Y3MIkOXEZsZ0uofZ470R4PqZMHU128nV6sE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCvGISPSceC3GTc81Cm/9JfWAd+gxNzIRwr/eWIfSapctoK+EYMLzUmLP5bhvifhH
	 KbXwfou2gQdDsIzBifyMiacKQi+TG3yoNks9+pwb144JRG2x+zrYNxxTKRDZJyHLP+
	 n/bXhkgtzNf0kwJxQ9Q8Ga5wc2H8nMNOw8prSo6eE9oV+nGzznp66etIlRukq170do
	 sd8tAdM7+sykob6D3LYr5hDV0lTgPIzw5itWHODKGnLPjQu9qCVp5f1Sa+2voONQn4
	 k64upwgjjkBHNrpxT58XGYMx7t9CD96Y5TgLTdmZUdudJJH7b1yhWoy/kuBHrNDn7v
	 dz68b2KWEB5Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Check bpf_timer_start return values in
 scx_qmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260827080738.829103-3-liwanwu@kylinos.cn>
References: <20260827080738.829103-1-liwanwu@kylinos.cn>
 <20260827080738.829103-3-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 08:16:50 +0000
Message-Id: <20260827081650.C58071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] central_timerfn() unconditionally re-arms the timer with BPF_F_T=
IMER_CPU_PIN and ignores the return value, causing silent failure on older =
kernels.
--

commit b5a91ea2da5adc3305be9b35666d557645b76fd2
Author: Wanwu Li <liwanwu@kylinos.cn>

sched_ext: Check bpf_timer_start return values in scx_qmap

This commit adds return value checks to bpf_timer_start() calls in several
timer functions within scx_qmap. If the timer fails to re-arm, it now raises
an error via scx_bpf_error() rather than silently failing.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 5bb8b90a275a3..9f6e61d7ca071 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -1246,7 +1246,8 @@ static int monitor_timerfn(void *map, int *key, str=
uct bpf_timer *timer)

[ ... ]

> -	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
> +	if (bpf_timer_start(timer, ONE_SEC_IN_NS, 0))
> +		scx_bpf_error("failed to re-arm stats timer");
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but while adding these return value checks he=
re,
should we apply the same fix to central_timerfn() in scx_central.bpf.c?

It unconditionally re-arms the timer with BPF_F_TIMER_CPU_PIN and ignores
the return value:

tools/sched_ext/scx_central.bpf.c:central_timerfn() {
    ...
    bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
    __sync_fetch_and_add(&nr_timers, 1);
    return 0;
}

On older kernels that don't support BPF_F_TIMER_CPU_PIN, this fails with
-EINVAL. While start_central_timer() gracefully falls back to flags =3D 0
if unsupported, the timer callback unconditionally passes the flag. Because
the return value is ignored, the timer permanently stops, potentially
starving tasks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827080738.8291=
03-3-liwanwu@kylinos.cn?part=3D1
