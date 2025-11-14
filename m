Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8092F360A
	for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148256; cv=none; b=rYIqhQMhJm4vM7kp6voYteLCGzQ/kMkF92sagGo/cbin830uE5j0H8z4UthJbz0dCnCulQNKDu4drH3ZFSY/X9hMjnPv5Sl/kYUBF+maoo18/qWy1eZMvupw/XfyJk7kARVeJJmH0rlHCVoalRdnvLXYnkXItz2YMqza7RJmioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148256; c=relaxed/simple;
	bh=PboLNgDccFpPL0qOOtP8vwBEIWyfnS0YDfaz+7DHEyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTtrcM4Dvhic2dTXtcthKv1E6eGiXpxf42REjVdCGWwZrnKlFkRpLHszFXilgRjFMYNPON1L/ygD+gbLE6uMPBkGx+Zph19NGTFmefbWj7KZAC1kxOQjD8Xgtk2UoX7bJKYOA53itUMVPSLVAsvg3Eh8iUsiXqcHp1E/ayASR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bourhCQ/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bourhCQ/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73161849e1so400669266b.2
        for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763148253; x=1763753053; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A4Txqr2OWen3sGNdXytrE6WT1GjyqTyN0KPSubBZ7M=;
        b=bourhCQ/tvmprUJrbLAvilZb6TLa8+sumjD+zkrC0CtKhBhMOw1BN7pOHpsGJ1RIzP
         dZuw7dDgSXqHEFiyipcK5PMkUff1MWFlz/iWVGaYW8t0SC899dXL3bDTcGwccawPT8zO
         1U1tAr9Ghbz0IpxP/pW1Hq3zsW3Kl9Mw5Q6vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763148253; x=1763753053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0A4Txqr2OWen3sGNdXytrE6WT1GjyqTyN0KPSubBZ7M=;
        b=KbXT6Dnuj5DWGtyAz2bu8vCxnb2FCjBSGYKN/8Ftt3fLaCSIj8hzY2qOMgu9i+GXAt
         C0o4vJ2XqRHKXB7GORWTuv4596q87hS4beF95l8V+0reqHL1mvgTX0knyMLU062n0DKI
         1MlIePVjuReP5w/fi54h/cMdTGj4vWFwUxAhJpwI5UEN2D298rkbclo6Mn+lEgzH/14p
         IxK5T0mHGdHj8w9HP9TbumQsrUg3x7IgqbuPlJ0GUo67gxGXs4O3A2d+W2/SlLsE16la
         dWfZb2WgY6BCxShtc71s5KJSppJUaBtPmVMN3Rs0WuOLRzHcErOMjI/kzdEZ79Dmc68q
         Pxkw==
X-Forwarded-Encrypted: i=1; AJvYcCUgJnWf0FYg5tSYbGLvyQ8Du4g1szxEI4et+8dz0pkDunjgjwd9U7ifKhtR5O50hlreD8v3lW/Jsv8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yynso5EKJD4fOjOKhLv4OtS5ykv+fgcZjat7cgJ1G17jj60rH6/
	CYp604/W8cxYqAf8Ciezs74+iRxSlNoGlpFUjtFAoApIk/x6bC0a2KXWF1tdiM5+GYM6RZawFK4
	81+gcV9JI
X-Gm-Gg: ASbGncsyBcOtp4R2OO3FHCpNA0h0Od1SQ9h11fy85GzrtZiV/xl27BzzR2PGA3kUo4J
	7da+UUlA5Qat0Tb4aY79AOfoApGfA3i9v0du775mQh6gzIhri2gIG5NxE/997NDlk/JFSKUlukH
	vqyVTEXQInHIUxGXXkYnEL761O7YsyJR2Ewrvk/CU/ei2LND8JChk/6YEk66tgMBvgPqzUgPaQd
	INn0myJZhrEobGD8iNbUVhnBefcnUlQPSLGnuFtBG/YP6SEyEYLhr/Z3e+K+4byxogyrrism5Pz
	kqP1i17Aca9Sslw88SgoUnJe3Jc7uTUCeJNlo2/NqImaHbw9Sntes6UN6jP1pEKlStvR9cXEhn8
	OL9VLgPK5jlhvw0jXflCiHBV7S8kK10hM46S5bYHm+k6iltMtvxo1gF+x4IdorhQtefDHVvD1jY
	3xZhgnCMsuz0DNkqchQ5iiABZoakurodvN8WXJZyliiy5sjpMGhozJEX9xQK1BYf/aAxroxOg=
X-Google-Smtp-Source: AGHT+IHGw9Dz8D2IPIKpu0oGWoDMAc/A9igOwCDx41WoJyH8E6t7oOtOUZb5PoGltSNPrPwC73Noag==
X-Received: by 2002:a17:907:1b0a:b0:b5c:753a:e022 with SMTP id a640c23a62f3a-b7367836dafmr415666466b.29.1763148253008;
        Fri, 14 Nov 2025 11:24:13 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734e9e0f20sm453423666b.0.2025.11.14.11.24.12
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:24:12 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b32900c8bso1392580f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 14 Nov 2025 11:24:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdaND1RiQhwD8cbs0PXvYtRxwuJivvcDdlpA0aRXA6GN5BSGjH3VupiMrARSK0HcvdYDbGHlCKj44=@lists.linux.dev
X-Received: by 2002:a05:6000:3108:b0:42b:30d4:e3f0 with SMTP id
 ffacd0b85a97d-42b5933b5c7mr4406488f8f.22.1763148251833; Fri, 14 Nov 2025
 11:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251111191816.862797-1-tj@kernel.org> <20251111191816.862797-10-tj@kernel.org>
 <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com> <aRaG9X9xfS_QL2QF@slm.duckdns.org>
In-Reply-To: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Nov 2025 11:24:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V=cRXkC2+1RcRHEn7ynpSro=Hk8fXhnubjm5n7r6T22w@mail.gmail.com>
X-Gm-Features: AWmQ_bmmJkxx0Qdfo3bXAzrhhUBfAug8wSDPHRsOuYb2IpOw_nDzoFaJmUmjV3s
Message-ID: <CAD=FV=V=cRXkC2+1RcRHEn7ynpSro=Hk8fXhnubjm5n7r6T22w@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter
 to scx_hardlockup() and add docs
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 13, 2025 at 5:33=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> With the buddy lockup detector, smp_processor_id() returns the detecting =
CPU,
> not the locked CPU, making scx_hardlockup()'s printouts confusing. Pass t=
he
> locked CPU number from watchdog_hardlockup_check() as a parameter instead=
.
>
> Also add kerneldoc comments to handle_lockup(), scx_hardlockup(), and
> scx_rcu_cpu_stall() documenting their return value semantics.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h |    4 ++--
>  kernel/sched/ext.c        |   25 ++++++++++++++++++++++---
>  kernel/watchdog.c         |    2 +-
>  3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
