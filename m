Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAA326D44
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194857; cv=pass; b=NblULEtEBuqxOmh4ZnHeQJSzjXVftbOqseI27BN0/pbAeMxfRHZgJ9RuPMPMMIIeIsnNGGpfBsMWoOBTGQ7ThdMeDb10eQgoaxCpbcEpTj5XhlboJVHzvdlrF0PToj4zH9WYIqFbqivDGV3LvpfzaTJy98ZIZoxRmhpZjXXxxrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194857; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujY48pyoYbcjWehK57wwmd/7DaptpUIUvKvGmm8frAVN6kh/ucMwUweoSvKxUZ5QxWjjKNDkVMcOUSnav5TVvHI8yq9JAGzSy1/psiq0UoWQ8tlzNGJcUBYthKw7MZllvS/Vt5uBOAy9s/xIxl5Rsvh2JSuaEacKdFfG5IYq9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G46rxFFc; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G46rxFFc"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so8038070e87.0
        for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 19:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=ePeuzWPIUOutzeyZI6boTUCCuY3G9DnufKq0kJm+cKToxxifF+cbywwLbKKRDJ+Jfw
         HnRXfjS+kAQVjz/Fa2V4iDmQP/GVEQ5RINsW9QgNWjMuYZHs+tkop1bFevvno8lGqKpu
         vUeTKNLohy7hmJG0Zj0UivcB+5nBjqYB3voyRPJq2zp5bpYeI7VsCFgseGF8MSgu2eKp
         jN8i7hBj78Xnzus1Nyf72oZsQbr65O8W9V/DP1WZKqPTGskx04MNxNZ0plPfc8qA4ayD
         w+rZmhIUWdxG1IAubGuh3WBc3vtHLDPLxquQre0R0lXxn1DG7tDgG74nqehfZT/ftj9A
         vqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=LPDW9RyCVy4GInOU/UY5ErM7RGBNvBSgSlevJtFtRLE=;
        b=IT8JE3UkTt+FHxiAQNegyw3i4HTttmx1HbZhlwhtIOIlg8mw6J1FVjHqhVCuk5BUaf
         zjWb0PFPMAbuh+z07E4ygW1LyIh5XZncdeAVOMKuLn1TtrClfYCtmwYaFQrLOtzYvDbV
         HpxamEF4rrdMliktv+QwrJo9v26SZtGDfDw6RYKqP2tPQ2UC4hMcc7Mq9LkCa50iG0kW
         +P2cbnb9RDUwottl1p7hNalW+HbOaplUB9Pv1tzU7XuX5h3BuELWGkiJ9o1raTTjYgxd
         K59rEKVQj+VnqYSOmIxjtfONtH9CMpkthts2+MYTFbRVaOM0sqL2vABHZwth2j8RUpq4
         1SaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=G46rxFFcX1hnQKxUUrTijJdlDpB5OBfdKVt7tJqloBNXcNg5JAjWvjlGBTrQCSFpEL
         kw5r/kEngKAkJ0pkN558AqUScugTYRjvdhsBLXq38oLpcnNpxGDuEjo6TpPJTbZMKzhC
         YhKhvGGnSCYDK9QQnvadjQAxBlN7qho59qSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=eCnTuJAet/1pEN+8hgw4kJdFY6d+ucEaYQRWwgTgQVHQri6FLIFrpGs3NbjzmvCSxQ
         7kYhxNOmPOaTl+6Sqck+va7HSqPPYN+xVUGTSVyLW52Jt+d5BZoZw1CG5lqALHxXwoBU
         7VK2XIBVaGElviJi8N6xrM8ECXfaFApwm/Lc+HummHlFi8dlDMqmDo+4K9tKkGVYW+jp
         LHr2SLri+uyUfuHJkqOZz/UjjJthrPUPETtGKmwmafV86MlQxurDsWM87/ZnMzRSlTeu
         sEEuR7rKGPa3u/ZPzv/vStetyUTYE7C6P/IKtJzZ7oc4HRJv54L5W/sgHy2iPLjPPXNM
         P9WA==
X-Forwarded-Encrypted: i=1; AJvYcCV0xRgnmoH0wbjJQ6H7lPMESxELWgI3oP6FJIjqYzAuMFbypgVWDi8dK5Ey2FOqmcW5LHDa+Cd4Kzo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7ouOVe2SxStIXHEYLVxTLzt1mnUdDdju07QBA17Q4UIB6woyz
	j5856mflu+6EeKQY406de6jawsEueVqNTc9hnY7nOU8jSffEi/03EOMpaokowQ4Jcheo/UhtkFO
	Y94rn70KlAUNKh1vuxZog90p41ZoIuGseJOOC3U5M
X-Gm-Gg: ATEYQzzrS1L5hFznCwzWrS4otuPKAunOUqkT1+GZ8uYwgzn7ce76+oxqRmGxUhhbDPv
	wd23SDvkvlEBQ6sUzaHveLylyHCD2kambDykWnTh/PEfEG7a9uEGgTluMoWFG0yBzZwtnrUMZ/l
	iUwmCXyDnzDrFhtJ7aArNrXzgG0sL5EhkRDIs1sLSE/2pyYgE5vJPXMYdrXXLj/4gZInmuzqkFu
	5OBwZNeIzOIsha4B+pIVJXsOxPtJQGzkow4F2Uj1sGGNHpXZkJDxTU0ciRpfX6ebcFgzVsCSVlz
	cOODzCITGw==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
