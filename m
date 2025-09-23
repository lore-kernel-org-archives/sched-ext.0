Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF436259C92
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640380; cv=none; b=FCxhcIvsPFCHied9i/RaSZoLLKjT9/fTlJpsgIDH5/6d0GDA3YE2URoBViYFECPyylXe9Y41/dZS2s43G5O3kNak1E2GM0LwJM5rW//hDQrSct/MiL3k3nKzHmCKJj4cueLO8dreJV9MXPvXUZuRoGMEvgVyeogwflHZOZD5AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640380; c=relaxed/simple;
	bh=aEgUWgJ0RihK5oqEy2Sqh/7xnzLQ7c4nbXXy4s+OdtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaTecDzAAIFLhwDLGPzwHvJc/YOWRnJJjMmwXkGsQ2LDrZ7dr3Wg/1goFg/mEUjnlXlEVZmUc6NtzAHJvhbxn3mcsPCLwBMHHcbIktSxJWVQACKMP2CmOED/xlawiIuzFQhTU6zPINZJuJrYhGrTMec8j9/NZDW4ieSV7Z8J/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Px1I49+e; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Px1I49+e"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fd0d29e2bso6446438a12.1
        for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758640377; x=1759245177; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK4p91UquXYpcDOvla28wbpzx/0eGA1LJALNz7qAV/A=;
        b=Px1I49+eG/x4cPJWHNbJdqE0wMHyUnbq/sSvg21FuwjFeEEguJLxhbz5EBH4oYCfx2
         zrFz3AgCnld3uzbt3MgP62MM/pWWTP2n0ZfT0XDQxGPWSGn0a2FuNt0g826wJ99GuZnJ
         6nuZ1bVB8llxqTXZE3hElcplPXOnOtYMTVnoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640377; x=1759245177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK4p91UquXYpcDOvla28wbpzx/0eGA1LJALNz7qAV/A=;
        b=UK4LJOIcHfnuTizNudbLwCv1bUM1/35hEi+xanfaPaLOefwd6EYbX6+7Hb8RyBEe2/
         ejoCU7k+7aQhtztzVTCcs9GEeNrvZiNR/xtglYpusgiGErJyGWJnnMnHPPv1Ktr186oC
         H9I+41jKPHo9Gqq6x+NhvJt8PrfgLGtuuXI8/4Uxfdic47CZZG+y6xIGQ997hJvlxSO7
         plB5wG8MTqKh+CgRh9NLSuCsPjUbt1Y4XYpIG0TWV6cSKQ2pjB6vNxwDetBsupE+2oPK
         +Is2ObqFgtlFsYOmtcTcEiWgrAmtLZSlX0LVcsTSA6VxZF2Hk5+Gih1HOEwtJJpgY045
         4Fsw==
X-Forwarded-Encrypted: i=1; AJvYcCW6TA3e6VP93OxV+PyV8kXUEmjuHhBI0hLTfdluhmACu+8KgYl2VV+eJMgfbciRNgJTVX9gO4OlfOU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2gG6hyYCkEmj64XEPo/yASh58ZRgT7uwVrSp14ZLxrBHSrDjM
	8Q0SW03MAym9JqX6Fgb0cdPeCp+HR+Vm6eYcl1V9/010PIkXn7Wbq9uDXAPNvfoO2OIeJ6258lj
	HajX7Wfg=
X-Gm-Gg: ASbGncs+qB9qv6P+N+x7TqRPtcbkhEX0I1Lt9k+Wu9BTMHlsKo7u/36JmamaCNuAgx4
	d1karGhUNhOe65cs6h38MWNmMF+AQYiQUMTSzT9B8/VYiFFi9U1prHW82UL+HBHsNO8WliFu3dA
	L5wxpRNczUdVWa9LwVnH/xq+A0ScHMzWJPCdYuaVuAmXykd9XVaW+HUH4r0/eYvymSs85N+3TAV
	mcG8j/xZSqS5k4tIe+HzYeYB7Eqew5U5zESU/B7m/DMj71QQ7nBoisyTSoMDPMv163OGajYBfVE
	IOLLyTDYog+UcsaueRrp63aLN1FXEEZ6P6PyJOf6ZNHk15tUThdlzcufnHQEiMaUZlObfnsMk6m
	4Pf4OY53lLGXw0ejW2nRbAvaCWPVwb4LoKPkquhRnwO8lecITNwI5ImO3hVBIo4i/ENiqlI/x
X-Google-Smtp-Source: AGHT+IGu5zD0nipafkxlC4jUHi58s0SH+bqJW5rXqvZ9UkFocEg17DVVqabvK/lHC/fmDDjP1jdq5w==
X-Received: by 2002:a05:6402:454a:b0:633:d0b7:d6d2 with SMTP id 4fb4d7f45d1cf-63467812260mr1954279a12.18.1758640376725;
        Tue, 23 Sep 2025 08:12:56 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62faab2b84dsm10542147a12.37.2025.09.23.08.12.55
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:12:55 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07883a5feeso1126264266b.1
        for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyWST5Cbe7sAHjFdDktCcLNzoe9/LC5KQGnNNanb3KRsBit1Dc7Cr1oVVrqAsrsQccz1tTJZ1/dHc=@lists.linux.dev
X-Received: by 2002:a17:907:6e90:b0:b04:25e6:2dbe with SMTP id
 a640c23a62f3a-b302c1fff60mr269464766b.63.1758640374544; Tue, 23 Sep 2025
 08:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
In-Reply-To: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Sep 2025 08:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
X-Gm-Features: AS18NWDtCTHbiHptNh5UG7Hu3DSC-Rv2WM_knZNQ2TEGm6B2SDsTgkz_lQHSUwg
Message-ID: <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 09:49, Tejun Heo <tj@kernel.org> wrote:
>
> sched_ext: Fixes for v6.17-rc7

Oops, and people point out that I have renamed you in the merge commit
message due to a messed-up editing error.

As I removed the "es" from the "fixes", I apparently also removed the
"Te" from "Tejun".

So now you are officially just "jun Heo". Sorry about that.

          Linus
