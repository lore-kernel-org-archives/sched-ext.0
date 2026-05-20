Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EC1F4634
	for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287507; cv=pass; b=aPCkAc7VnKKzFPY8tmvtAqhxC6euRBlLo0UMW1LRerSEpWH76x4lgeoRZUwTvKGOr1Qg1plOTEJeeyycowMf966v7G+ediTmDZBh85Xwk+Sq2LFhWXhtljvH39P8GxS/0QDq9f/O+LluWn4SMoTEP2YO8EerDkA9LmRNp0K6B8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287507; c=relaxed/simple;
	bh=MUi278I1pZtdv5LA/JQWCWwV6SHMPrlqEfIbohqCo7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BspJGvT8ucXh7FN/Bctz8tq+w5AapX+TxLIdLPXYUR2GI5nup5C4A5ZDO0KFD7TrETad4KS2z0jPFKTRXtRTN0yEKUUSw1WlNM0sjR4azo1fc45ZhLMgu1O6mjxCBp36cc5UwxGZkY60MtjQwbQEcEVOFJoPJUnYMB+JfTLTmbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLNBd7ul; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLNBd7ul"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-449de065cb3so4579329f8f.2
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 07:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287500; cv=none;
        d=google.com; s=arc-20240605;
        b=FIIqkCiTU9ykJLi969yuVR5GGkSnDnVae9ed/SMWlYeJkMuCvfrFi8mYFNDZQDNjpk
         i54wa2eq99VZPh8DmIi1RC3a31GtgeqYlJMMu9cU8elQwUflydDxUeOBhigYl29iNldX
         e+K7hIio+Cf1X/I4RYCoxqHjjQ486ZiwHUmftbng+acPyWZlhyAv7b4D6mUwIShy5tYp
         UYVjDoRZE4dB4TvE9ti/AczJyZ74qy8aV60mJNoWTxqGDKsFWqmxqi6x9VNNllIPK62s
         CBaOhH6iQ7kV4bKLzyQzzK20Btr0KKkUJqfOn9zyGQrYgeWSRLS5K07MQ3G1l8EG7otw
         XAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        fh=TYpcxyh5ZX8VT1FDnbfVgCnuVzq5WCoZ7BDH/BjlF8A=;
        b=YxjP+UIVJNbqZpLJRQ6b6JslaQnaQ5VCOnKOCOsVtlYtFCUORL/AfImsFBWIU5q5sE
         kXs3b5Wc0SlKu10X8OQ0WBBPD+merPiErkblLMmdyIOlz2tkZkiclbzlip65LKhezcGr
         R/CkgfoL9UgATdiaJGpGWQfWuy8NW3UlHdIEJ1y0QdpKveBeGpYBO3PUAqubzRy3UPCp
         yo7jGlBCPIhse3YnDsKUZFg6iUwyEiDjuENqwHZ1O2tqkVovmFsikUwngFUqUSp1/UZB
         KF0sU+Incd+w4QeGbIWCfeFe7FDcooWeCzgu+pQLnHdAQmLTGg04PKulc/AHiyhZaLfq
         PoxQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779287500; x=1779892300; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        b=qLNBd7ulpjPaOxvYUwa5MAguXwi05ZzithH7MDFErOeqoN9KQmyMkN50E+havMUsdO
         iCws1JKojF3SUimBJEnpXPmpaT6CORS5EsNRLDH/2m0dgghC5hLRuEiMQ7Y3SsyvarBl
         +IKiqoUdL6WXb5f2G91AWGD/5ZVmGb+1tevZq+ZZJsSG0ai9a9A+LF4gOQ03ua4wOjCb
         KGZ0HBQELGukJRXn3uSzs/m6w7pYztxG6gt6pVKBUOjSlcA8iudFFtfNf1iKbNPwkd2m
         kNSf6XWSXvOwhKZwzgapJz+qVzoqYmsCwpo2c1gPFZReNGJA3xtIzFVpltOTW2BxAGNh
         OGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287500; x=1779892300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+wF22bF5EmTZVPtYuYx3YYi/+1MmDMRoeQxqbotBDA=;
        b=qRlRq0puNKeVsvK+2Njdr283CJ6+MgdSe0ZMRUSscYLpDvVMi0jtx0yK6zBnmc60B0
         Hz2PbSsDs6CtY4Ig9lcjdw8zl1svsHG8MMqSJRv4tbdCOs8rUTZGH008EpSkxHSwoNKF
         K4fRQPiiovXwDANxxTmx/rgmfipc/9LAoZs/BfbsdL8DR6dmPLdQurYWJR4D4HoI3tAx
         ZZpGx9LtByE1wElVC4XJc46lHydYIo/paMEy90db6FbcwvuDnD/zMgmthOPN9nE/48bo
         dB8+wfI5wUMAU3FuI4qFZUOhuTn2R7xd/Wzz+aZ6atZydLHW5+uqBw79AxUT2DfNWCfd
         SciA==
X-Forwarded-Encrypted: i=1; AFNElJ+AAqxl3bqmRiNF3Hx4FEEJZNP9MG9/N0eQCzprfXqVxU/U+iFPOmsbyFvWgcNHk85BvpxAA2dorMo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu+u+npRWL/Qfo4B1MjGPue+vEzu1F31jW4Ya4oyNesVfM3xvK
	Gq6Edmf84bj/iJRtXqotI1x66dJAnAWKTGF356mHdr9aNxUVUzQLcwghndPAeVCBp8sah4Jamv8
	qLVt91uayhVI29L//Q4lY28e2EXWnUVc=
X-Gm-Gg: Acq92OHvCC0N+h6lg7FdVoeGEnRxeOhodcVt4kjdu+qPJwTDhvtwrpLFQAza+zoLK4D
	XhQENNZu/AiUjZLQlcWIomcLPJITOfDt6XYaWxLtjpmz1MqbGWpmolEZjBKuIHpH99WMj1zGXFN
	8vcu5Yn/0mkEJJNVEwWYXaVFH6Yl6qwttp4cNu3d3u777+mj4H3nwKjjeCeKwLrKcGaACwnlVZ+
	ItLJxefSsTclw2i+FcFUKi9jucNMzwNjabvd6FR/IQiZvtgPgONFkmr/+okjVsH2PRTJdGY8Mak
	vFIIwMCmRpZafs48hKI9m3F0tQ0USvqAGOAmbB67n167oYf9MHkJRcuNIIcP2f0vobj5vhmJw7i
	YCxU=
X-Received: by 2002:a05:6000:2489:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-45e5c57d4c7mr39111981f8f.5.1779287500133; Wed, 20 May 2026
 07:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517211232.1670594-1-tj@kernel.org> <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org> <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org> <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org> <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org> <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
 <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
In-Reply-To: <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 May 2026 07:31:28 -0700
X-Gm-Features: AVHnY4Jfl2x_h-7nV11QrGsQRKElNx9baYm9fCq6a9rlTD86qFRr9_qH0Fp83GM
Message-ID: <CAADnVQ+j4o0Xy+cykSdx9txSqCouy0yHFaA09qTJp3OVF3VaRA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot installs
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/19/26 21:04, Alexei Starovoitov wrote:
> > On Tue, May 19, 2026 at 10:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> >>
> >> On Tue, May 19, 2026 at 11:40:48AM +0200, David Hildenbrand (Arm) wrot=
e:
> >> ...
> >>
> >> Wouldn't it still be either or with both cases being okay?
> >>
> >>>
> >>> ... or can we run into similar problems with kprobes? (I am obviously=
 no bpf
> >>> expert ...)
> >>
> >> Yeah, I mean, that was just the first TP I found scanning the code. An=
y
> >> kprobes or other TPs in the path would behave the same.
> >>
> >> When this fault triggers, the BPF program has already malfunctioned, s=
o it's
> >> not going to be a high frequency path and performance isn't a primary
> >> consideration. So, anything that can ensure that the kernel doesn't cr=
ash or
> >> lock up would be fine. Any better ideas?
> >
> > As you guys already figured out the trylock is not an option.
>
> And that should be carefully documented.

+1

>
> At least in apply_range_clear_cb() one could similarly switch to
> ptep_try_install() to at least have both these paths handle races in a
> reasonable way. (having to handle when ptep_try_install() is not really i=
mplemented)

You mean to use ptep_get_and_clear() ?
Makes sense to me.

Also noticed bogus defensive check there that should be removed:
+ if (unlikely(!d))
+   return 0;


> Anyhow, the documentation of ptep_try_install() must clearly spell out th=
at this
> must be used very carefully, and only in special kernel page tables, neve=
r user
> page tables. There are likely other scenarios we should document (caller =
must
> prevent concurrent page table teardown somehow, and must be prepared to h=
andle
> races if other code is not using atomics).
>
> To highlight that, we should likely consider adding a "kernel" in the nam=
e, like
> "ptep_try_install_kernel()".
>
> I am also not sure if "install" is the right terminology and whether it s=
hould
> instead be "ptep_try_set()". (set_pte_at is the non-atomic interface righ=
t now)

I suggested using the ptep_try_set() name too :)

> Further note that last time I talked to Linus about arch helpers, he pref=
erred
>
> #define ptep_try_install ptep_try_install
>
> over __HAVE_ARCH_PTEP_TRY_INSTALL

ok.
I guess __HAVE_ARCH_PTEP_GET_AND_CLEAR is legacy ?
