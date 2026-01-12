Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F436402C
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234415; cv=none; b=JSXsEuAmV4EA+m8g9XaFOuwLQznJBi/K3wsnor5qr/gYs33mW+BvqtcZSDq2tHPBj6eF2HAnFR2Kg4SXFxm9NewmigHadSy1NjsIRZUqolRWy4uDdielr3K9NrDqfoE4vsnCX+1dS4GPiWfBbzM09UCUmcImqJQVbI9wKvgGAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234415; c=relaxed/simple;
	bh=eWD7AB0Z4GHcjHPJj6s/tEyAD76MDx2kXuwtI4N7olw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ex3r7VGzzB7JnRg4n5Qgj+M5PUntG75wLq+BOKPSgdRioNjq8XY0hdcVjB9tYFoqebiHsSzlqum2/Tt4oBfoDa8zinmO+03PT+gICGphfFYlcPJUA3kwWOZz0oefKW22KkgRCD6t2wsKvrgoLsSgJJi4TFH5ezWH689KvEZbw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ocuHnH57; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ocuHnH57"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2d32b9777so993418585a.2
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768234412; x=1768839212; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6vE/6fj0HDe/uEUcNhn8WJ5uOQLSRzlEAkg34B5H/g=;
        b=ocuHnH576Msr6HwQgt49nVMHI3DsF1d/dWmL9QpHgiqtmo4g6b351Pvgt/9k2j9pdk
         qMboNhnpY34/pUMyvaU6fi8M5YJnmwskWzXBFBPz1b++BrpwU1LH4hD19566U3xdwPsd
         paqxAG7jyiKu2yRjQvv5kWfGa/lCw0RNLT79zsbrgo3NcvuGqJUbLSmj6mHjXIt61ith
         xcUNakjp7EIkK+U8MifTlX31W5KL5LUuwFZLr/PBt975jNCvaMio3jFtg2mzqCbHeaHJ
         EHJbi5xXfgBZS1YkkKhu+8VgWPi7553CDSIDvSx86IOL+SOlJnZRPxrNGG5OWlmxYIwA
         M2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234412; x=1768839212;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6vE/6fj0HDe/uEUcNhn8WJ5uOQLSRzlEAkg34B5H/g=;
        b=gR3c1Oioy6BFh0My5VKNgP2htLQqnJo9SiF8wHWeL24HrNEIASGi8F/Lfr8jvIi0l2
         B6865H8XTt5FwO3joxb3ttsEo1JVY3FHO5oGN6lqEZ18vx8rBi8DGKxhm4MjBjIZ2d4F
         Y92LH7d4I5OZVuwb7Ede4PpSvNpHFdLlcNISjcybO+RNSnEwkK675aVRqnZUJUEJrrH8
         3C1nZwYXA+czCSECDKphYApjN4GGMUssRzy1TonEfU0ZXVVN2BKGcKzLJ7QNr2CQgrQA
         Bn71I6DG6OLdsNNGjiOP7quMtNKdlrftB4WL29a4KWSgquW8vJ/I26Lighdz/jaX6jlP
         3L2A==
X-Forwarded-Encrypted: i=1; AJvYcCUO46CuRrcFMxnKRNS4Y5VoJoBBKcc8X4zj+oXVs8vr9UjJlM1XwYxWrz1horZm4DPdlYMHx1brZHk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwuqIURsr4DzxrQkrCpMXHLF8k1CE5jzNHJMHZSLt2P35M0ZTzx
	LhGFnQ2Qkcc89w9koWB5pMTaFXKeNlhxNj5QwF0d6pKAJZyiZ8D1xfNwDWxgZX5qSiE=
X-Gm-Gg: AY/fxX6CWIsnvYvOtoBhcyZbsd7WW+GRxBdFfx9dhXOBYumr8//qWN/HXt9AJtlDCQi
	+L6E3x+ACq52X+5A0mxTTes/f0srZCBok9Hy6izFM7QNvNOSLdsb84Ey2NBSj1yWJBzUfteVD1B
	9sncbRADHh9Xr09LCNC2HhinASLaGrgVM37ewISBMP4eKGBCyESLCHiGWngrbJT4px6P+LqbThh
	xJRGkkiYAxisK1riTLds+Hw/PplrsrqUUtHOdno0J8ew9guuImB9e5WEj6qS49zZ8vHFkUSrzkg
	XpeJhjzhdmsc3fv9j0R43vyvdQ2E8fg6gZvtph5yYUi5zkpONDTaJIJnaM4UJPuxN7FAugIllk/
	LYTrklWOdPJJulaTgfEOeLSU896PyUA3plnbnG+OYOXZLy+qCwag7YYETTKEj2W1xKIgCtn2xAm
	QnxHKy9SK/bXtu1+zHKpZeeg==
X-Google-Smtp-Source: AGHT+IGjJ4morYlfzpxFu1VW6wdIGzAAijPKGMQexQiCb2GPGl4FwnurUMyUv9A3xv4106n9EBLpjA==
X-Received: by 2002:a05:620a:298e:b0:8a1:21a6:e045 with SMTP id af79cd13be357-8c389394c2cmr2640506285a.19.1768234411738;
        Mon, 12 Jan 2026 08:13:31 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm1536437485a.26.2026.01.12.08.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Jan 2026 11:13:30 -0500
Message-Id: <DFMQS9YM408T.13HOS5HP1SJJ6@etsalapatis.com>
Cc: <changwoo@igalia.com>, <david.dai@linux.dev>, <dongwanqiang@xiaomi.com>
Subject: Re: [PATCH v2] scx_lavd: Optimize CPU selection in pick_idle_cpu
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "dongwanqiang" <dongwanqiang2021@gmail.com>, <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260112150724.1553199-1-dongwanqiang@xiaomi.com>
In-Reply-To: <20260112150724.1553199-1-dongwanqiang@xiaomi.com>

On Mon Jan 12, 2026 at 10:07 AM EST, dongwanqiang wrote:
> From: Dong Wanqiang <dongwanqiang@xiaomi.com>
>
> Optimize the CPU selection algorithm in pick_idle_cpu() to improve
> performance in highly loaded systems with multiple compute domains.
>
> The current implementation iterates through all neighboring domains
> without considering distance or early exit conditions, which can
> lead to unnecessary iterations when no idle cores are available.
>
> Changes:
> 1. Add tracking of stealer domains found at each distance level
> 2. Skip domains without idle cores early (nr_idle_cores =3D=3D 0)
> 3. Add early exit when stealer domains are found but no idle cores
>    are available in closer domains
> 4. Add optimization comments explaining the improvements
>
> These changes reduce the search time in the critical path while
> maintaining the same task migration behavior and load balancing
> characteristics.
>
> Signed-off-by: Dong Wanqiang <dongwanqiang@xiaomi.com>

The scx_lavd scheduler is not in the kernel repo, can you open a PR
at https://github.com/sched-ext/scx?

> ---
>  scheds/rust/scx_lavd/src/bpf/idle.bpf.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c b/scheds/rust/scx_la=
vd/src/bpf/idle.bpf.c
> index 9f08f972..4340f453 100644
> --- a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
> +++ b/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
> @@ -757,10 +757,15 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct=
 pick_ctx *ctx, bool *is_idle
>  		goto skip_fully_idle_neighbor;
> =20
>  	mig_cpdom =3D sticky_cpdom;
> +	/* Optimization: Prioritize closer domains and add early exit condition=
s */
>  	bpf_for(i, 0, LAVD_CPDOM_MAX_DIST) {
>  		nr_nbr =3D min(cpdc->nr_neighbors[i], LAVD_CPDOM_MAX_NR);
>  		if (nr_nbr =3D=3D 0)
>  			break;
> +
> +		/* Track if we found any stealer domains at this distance */
> +		bool found_stealer_at_dist =3D false;
> +
>  		bpf_for(j, 0, LAVD_CPDOM_MAX_NR) {
>  			if (j >=3D nr_nbr)
>  				break;
> @@ -772,6 +777,12 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct =
pick_ctx *ctx, bool *is_idle
>  			if (!mig_cpdc || !READ_ONCE(mig_cpdc->is_stealer))
>  				continue;
> =20
> +			found_stealer_at_dist =3D true;
> +
> +			/* Quick check: skip domains without idle cores */
> +			if (mig_cpdc->nr_idle_cores =3D=3D 0)
> +				continue;
> +
>  			cpu =3D pick_idle_cpu_at_cpdom(ctx, mig_cpdom, SCX_PICK_IDLE_CORE, is=
_idle);
>  			if (cpu >=3D 0) {
>  				/*
> @@ -789,6 +800,11 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct =
pick_ctx *ctx, bool *is_idle
>  				goto unlock_out;
>  			}
>  		}
> +
> +		/* Early exit: if we found stealer domains but no idle cores,
> +		 * it's unlikely to find idle cores in farther domains */
> +		if (found_stealer_at_dist && i > 0)
> +			break;
>  	}
>  skip_fully_idle_neighbor:
>  	/* NOTE: There is no fully idle CPU in the neighboring domain,

