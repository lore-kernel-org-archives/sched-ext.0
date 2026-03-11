Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BF2D9EED
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235361; cv=none; b=PoIdrugnbUXFLhZUPXKIASnHf/hY6RMxczn0WiVOXcjzlQ2wXVAWFOV2UOqI8YdZmg0CHRmNZMzPt4M9lztvJTyMCdFHgO6ewyZ/LBiOrsOxFhZzOOKK/lMCsoNGOPQPH24453Y5krc5jWOC9f9bk1we43HoQIvQ1mRxiolOOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235361; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upT3m8UYb5PeP3qzisXj7X/erJ50+YfQzuszUAzsTWdNc+IsOaU4GwoUjhf1J1dS5b9YjsYTbe7A9nHMbcb82D9H24RkRUbIUdQmPgTUqD3ZNiB+su0+M4DAGt0/rsoSzeIWfSJ08uW1+h8ue405ricTDdC6ZNrvPKGX6upOCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5675d609621so11791586e0c.2
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 06:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235359; x=1773840159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=Y1WLsL3WDVbBf3b/653MigcXeWPY82K6REPBztFP2PjV3WOng+/fueK2irDxnI7gzk
         xybFAbLkYgaz/e48Q/hgQTTQoLNMcNWCBV93WUkm1Ws2jbpHCT6wvq77e9afz40PsS/4
         dUNIqzbq2oESNMpH8rIG8TfHA5l8qwmjYQXRx/e0PDEkkLcBcH9Q0qCevIP06TPJNQJ3
         +JLpmlTCtf6Ff5Mxqpz+cJE/AxHy+S5gAzSZo+W7O0QkBgo8hR12G/2HDOmKMfo3KxDx
         xb3sBIslUI+reWPxNxCTw+XYVjH6u0k/BL7DDJA/tAg63m35f3l9r+9N28mnsPGtOYq+
         rH+A==
X-Forwarded-Encrypted: i=1; AJvYcCVegBlhlHQnPCm4XS3A7dCwmpO+cC4MdIetV2lF49npJ/jZ3WTLSz/9asGY7zM6QUKql+gESksRZGw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjzAUqk1hDWhi/gJ5fjoq7FYxfba04tV6zevD5fHXnSxsFHOmO
	rXbP8qRvn6i815rNhbkkZrc8rrEI94MhftyRCzh/WzANmiHuRWwCw0VWeEfWmK/+TxA=
X-Gm-Gg: ATEYQzyQ4S+cEBP5nh2IHRZlbf5i61qf5kVQQTV03qdjCe4KfIhTeT5vI5PiLTL2qsc
	okaVplW4FSpnw0iA2D0BRxY7lnZMNpiT04BSSxMI5OwX9StSU8mu4dIQ5jto+OhyrgbQlUghXL9
	CI6U4uZO1ICgfw9IBjR4FxSnftgb4ygxX3AbSIHpWuCLjc76yHgLyxVj4wjADFSeXxIVviXFzY+
	MGwUNM21V5B6qI36iZO/x7m8OjpDlzEBMddHzCY0pUs0Vh/HF1+THY9wRxh356AKUjIUN1pzpSu
	vHWaMVJV6UnVs3Yz9lezv80K2oDrCgcVuk17Mcpy86IDdzXT6foE6nCbGbdbNs64cXbgca1gSBL
	H7s51y1abCBLEqDNMNyJZRJny/hvrPOxU64lgJionNLaKEQQNXSV+My/iHwInetgehqd/HAgLIJ
	X27+tE0ignyRY6B2gM7GlssedHsKc0jmJKP8rIXLkVI7q5ztwWkxBTRj59I8x9xqZIZBXsNN7Cz
	Yc=
X-Received: by 2002:a05:6122:8c17:b0:567:5ccc:1367 with SMTP id 71dfb90a1353d-56b4752d741mr865568e0c.11.1773235358882;
        Wed, 11 Mar 2026 06:22:38 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46311c18sm940658e0c.1.2026.03.11.06.22.38
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:22:38 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2423441e0c.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 06:22:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlCKeDv6H5TBV8iSLGMZ0/jmsacyGV1W5z8C5USXyMT8Xq7Ii/fEwtph3bC9dDJlt/SAW1KYnUgLc=@lists.linux.dev
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
