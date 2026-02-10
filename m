Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78035898
	for <sched-ext@lists.linux.dev>; Tue, 10 Feb 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688116; cv=pass; b=CrS4vMTp0yhMNp195qwXNP0yICqV7p1hzl/Ie8d6m37w8T1g5vQIh2Hef93/yYSbgADIzM5euscYIbnbPerAa0ZFSz4PQDbr9vUzHSnsM0iJ7UdNl2CfAxCIKbIv812HkPd1dhAupvKt5DAIP9u5dkgI1y9+052J9IedpACf3Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688116; c=relaxed/simple;
	bh=oiZQacHR/S7EwHoTc/kL7wGs0zwfmaBF4z2GD67obiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1TAea6eYf2x947rxJYaEIGbJUgZmIwisa4fn564Nz8WcWPT3E2OOAZJ+nmH+wysCMUFx7TPL4tfdIyyJP7BZzu4evoiiMrMO5eCtdxIbVyH0nNkF4inYGsfxkbkz8JXSqNdndhHU1NyKaQwkiKZFrnVBe/1pU/HXSOAvUqrVNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4zd3XXK; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4zd3XXK"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89473dca8aaso50696626d6.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Feb 2026 17:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770688114; cv=none;
        d=google.com; s=arc-20240605;
        b=i+pORZUTZDyn/Q8gXW4SifbdsPW+erxHHJ4g4DnIwi0z66STqse2ocguYMYbVYprfJ
         tGFmjIk0zCeWxikgkK3ku6p5pavEINeCqRt6t+i/zhK8pmZue70Ic3BeaqDGB0OyZWJ2
         sY8oJxFBIDX3lwaZtIgGYqBDJdGaRTh+lhPFoJpO4e4T6GeiTVB97XG5jaPbqL2hh+dm
         42swfH4LgjCIVvgFXq6s7NWMAbIppsrJc5eKd982cAEL7XU5Ot0x0sFy45Vhb6hzCUoy
         3eGFy89pwbM3OB+BaxkGLghq6nYDACb5Hdd4yZEVLuk6+PFKzARBKvHX3Q0Z6OqKeN+z
         GijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        fh=K9RjYIo9E/95RuANBw2WX3jcZs0dz3cAI7B3xxphtzc=;
        b=dUxPs4X1h38ISLQIg2sS8cvcm6G3/JxXyQ5trU9WFLhFs0s/hEy5/00LdK9apkgEqq
         JLpU9bwS2UhREewgbMEK4jbYCr0++10/zuwwgAKK7xAQCwjQLigQfvB9o+7qNJ6eSsx3
         TQH+F60zdBzMCa6P6TTIWTle6r2AjXQ2cPNrpwrX6wojrt/vgu2pZo6Ez0k1S3wz7CUO
         +mYcAMouArvXSH5C5MxsRmbBQTE0Ds6u+94nEWiigiQE7tmEq8Wt4ilgf1LAl1zvY+4i
         qW7Epgsi9WrG4FkYaV16+VyGKp0QI+uBgkBOSRCQ5SHMOOOjEhXQlgrlUEZPmOnBTGSs
         4z9A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770688114; x=1771292914; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        b=Y4zd3XXKtbS8xQbzAi62K3/da+w1d4+8Was8moCsgaXimZ7jXgyfP24dPj/rvKEw00
         UnMy/XLEwlmn+JWwgmI7KewxqoOxCQjVEGbsvtocyem6dt73BmMDDdSC45Vb7KRBMVVZ
         ZBrQl+z3Pa8DvlWPB/T8ClTJpf8j4aOhoY+yT94db0PFTrQH/ZjK0DGOfQKjOcVV9IEX
         PsOrbyucJVvd7f25nHELUzYqHPT41zYVVoPvhwWha8z1h/ATCQvAedAgyNXF/d3AtChJ
         hkXzleTWNFqeqWK9+jXXdob66KfTKT3q/DraYbBPvGsdClbXPaSwkKFEp5FMB1ydAPz0
         Gcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688114; x=1771292914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfM95cRUHR5M3Md8H2tOdqR6MV1wasnXxpRfrafM1/Y=;
        b=XaqTZzsL0PF6jmjn3X7fHXmGr41HOaM9Z8mBhXwiZlDOrLCf0fMJxHP+1nko7Mvuw2
         fPumxwK6cPjWyssF0nTq/jRJfJhurKFpg1inm/XKuyRHDF0Bo3fWZK5x2+RAcP5Kx+Bt
         bNYrpbqN+8EiZ2TWgXC5CiRQNmT6EkCnvBNn5mA0UzOVEPMKitbtVpTgQTo47WoYegxI
         a/gvG+Nbx1oYN3Nj6jDzhkcoW+6wqXU/iZTo9k/A1DwQNBLQbM+ERpumGTxVRTA3wSPO
         I7+bzAQ6oKLlBAhqmvjWUw9FCXJyRdg0CkD2HsgVPXb+U7ZbFEHAim/1WT7DvaYkuQfD
         Wx1A==
X-Forwarded-Encrypted: i=1; AJvYcCU48RfbQHktwMtnSdxYJu9cYJ7aKYHToaMZEXwcvqp4/XJxwxEmP/a30jyePC+5mSMqxkD8HUpxalA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz91qXcFeSueL+MzwpWkDCO91sHFKxKh3AeZcTJ2ChbE4stKX/u
	8e5jEFfSxUhPb2mAI8WKJjs+K5nWMVHnx8n9UX1gCizvjbIxOGtZoL3UVnUccOcaEAveyoaDQFR
	yAjaWYbLsFszPYtVJiLv2gLlj22s8R1E=
X-Gm-Gg: AZuq6aI4/cgvscP6tEKJfZhcZhN/YDslZ4CgBxu0y2nF+DptkYiUWMOOfmuJpEkkBsX
	C3dh/GZW1BAlrn5yvilBIbOyRnOLENrb/vaDZrIO7/z/tFLDeNCnALQgG1RvfPVt9IlWcJJtuLL
	bpj4efzPlgX44D27cB3lzGyImg8nZn+JgGfthKyypC0OAIYQvq0SARcBuN30IFvr5oYbVndAC+m
	kFKNZIQWSI8BZWFUlz8JQYUhTfCEFRzXkZ39wlhgjDfFU5gkFFRfCN9WMTcYDpQYli94YM5KIjz
	mbT6sAq1
X-Received: by 2002:a05:6214:2022:b0:896:fea0:ccfa with SMTP id
 6a1803df08f44-896fea0d4eamr74854806d6.10.1770688114558; Mon, 09 Feb 2026
 17:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260209085536.16723-1-xuewen.yan@unisoc.com> <aYoxSfDjUvnIIAMd@slm.duckdns.org>
In-Reply-To: <aYoxSfDjUvnIIAMd@slm.duckdns.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 10 Feb 2026 09:48:23 +0800
X-Gm-Features: AZwV_QieB5nmasjZ7MAfcz8hm16jdjD9Mn--TBSkbruab4F10si3jQOMR-XGVfE
Message-ID: <CAB8ipk8H65Kn+Cg8cVuLCwgcvWP_Q4tXUS1hqr_cSweV=DZFtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tools/sched_ext: Use u64 for kind field to fix ARM64
 atomic ops
To: Tejun Heo <tj@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, guohua.yan@unisoc.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 3:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 09, 2026 at 04:55:36PM +0800, Xuewen Yan wrote:
> > From: Guohua Yan <guohua.yan@unisoc.com>
> >
> > There are following compile errors in arm64:
> >
> > bpftools/CORE/scx_simple.bpf.c:144:2: error: unsupported atomic operati=
on, please use 64 bit version
> >   144 |         UEI_RECORD(uei, ei);
> >       |         ^
> >
> > Convert kind from int to u64 to resolve ARM64 atomic operation
> > limitations. ARM64 primarily supports 64-bit atomic operations.
>
> Alexei says this is llvm bpf backend error and the answer is to upgrade t=
o a
> modern llvm that defaults to -mcpu=3Dv3.

Thank you for the insight. We'll upgrade our LLVM toolchain and test
with -mcpu=3Dv3.
Appreciate your guidance on this backend issue.

Thanks=EF=BC=81
