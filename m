Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515C436375
	for <sched-ext@lists.linux.dev>; Fri, 29 May 2026 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079918; cv=pass; b=qr4qMVjvfGooF1SRe2edhjKM1Puq9KkVsM0A8SdN14nklJW6sZPp5q+kIQIUPo2+onO+OCTuz0ASImiJ1Ea4SuiGaU304gnShuo5XCtjaD7e14JuCS+h7MdwJK63r8x4YN3Z2htnf4qLObgevS5pg+d2kBYAkjdVNlll2Kycl9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079918; c=relaxed/simple;
	bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogrnhsoVZbQQbquy/eGWXXN7kdARqVgxTiIULCC00rKT808uRPN3Xc8Y66pDG+OI6ckpR8GFJQzuHyPKwsW7uqQpD5ImSXpvaykyGrIrFD+FZTb89o2M3f0LLEalOq+wNGyZfdYoDOaQa7f4UIQUIS9J4z/lIzpFYjWMeE496zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y70qrzxp; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y70qrzxp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1216133f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 29 May 2026 11:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079914; cv=none;
        d=google.com; s=arc-20240605;
        b=D8ueWqDkClB6dqgYDneILTqMl4kpMYV/nr/23BtIPoRyF31Z9w1RIJbQm2mZlGS006
         OEHdWJlJgeD+junMbOa2W3EThTuEDZpxRk/zkFQ0F7e9PirG/cOdmOWk25MJ/0g85VoH
         adM3BCFplRlXZLMHgM9cv/jN5csYmZTR9okQGLe2NUrNTNmUlrJM5VU0BbgJGSiYIYDd
         Bn5sZx9ZOmVNl+lWCz20FJwwTnvI8/qLr4IHOnxbl1bQ1Yzb6JEMhYqJoca7eZ64iQP0
         BfzGnnlYz1zOhR5/mO0WLYDmmyEZvljCyPwrqYGGRD8/U8f0QhtEHjNI//+OyREQmAag
         5UgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        fh=RZB2D6aXtGcxifR3bJIlPc6P2p4hVxcH1SSb5IZX/UE=;
        b=c5uB0LYy534ErAMzGFk4u1/ecJlYBOyoFfDk7BvC3y9LR7nxHDi3I5PK7hksruZUbs
         Pvx7sPh5N/yn2h0wzo0CWqtB61nVWw/CnZdmQAZizFVYwxQwHMmLgu8pfET/RfU7o543
         DSni9BTXig/oGNfzCf8fg+j2fY3toClNPUNUgOgNvGfxvgnHUaRUR1uwWKtOJzlqbtfi
         LFQxvHzjvNfxo0XBbfGC6rGnOVEIoxZQWtHKseE0nGY8cwfSZ/mDWoKCPA0hST4ROu78
         2v0MMK9cDkhWB6KBvx2/4VOTx1cziL9NST1JaCsjfhqr0MDGCwitF0AfAx1qo2iju+j4
         2QsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079914; x=1780684714; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        b=Y70qrzxpJ/AIyjiGgVE/SocPNddx6dLFwDbmDNxbazyFj5tVlOhA3fCBwfA/UsIvxo
         bVCKFeWgahw1vGrFXNfR/chaH5iwCoWPJDpgEhydb+ulGSnyURSl3RHMNWKj9o8tvqHp
         FEsaDcoqSiAbyY7N4RyDI/2H1P9Q1UVfldnOgUGABxvaZG3Kjw/ZZGVzyeQByJn50yex
         KZgFdzPSJGR0cfQgoL2ZPskeb8ZGHUTCR86Z/fWfUQ6xNXtU1GmImqpiSO44CJMAEFdm
         4/nSrLGQqqV1kLRZgEBhPoH8vtlcsJm1UYG1945++xlyNxbGalEVWyU5iTqdmBYqQFLU
         g7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079914; x=1780684714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iWiuvGopjfPOqN1ltMMiCqrYpx4WW05J/mF6yDghGQ=;
        b=SzokSmu5+Q86ooCOKl3VO3DuPifSo6Zok4AeZwbrRkzQvwHjGI195CbUdoqVZm6XF5
         cYMpGnnHXXn+sqnytrECuywtm9Dd/khf78JGYHhjWTPUC/CPlUd9skjJ4auVi8JFQ/5k
         20YMvkhM+TlIfWLHq4EcxTswm9r4wph+W1kDq0n66QPjGM5UBlCknWrIIapqPh6sqvbE
         MnU1oH6NXpMo98CByVgl9Jbmu8Rmh/SP3eWB+BUot09DL77mK1+6uo1K3C2u+wtZRbvt
         ZEbwFhTafKa9cAtBmdZ2BgXpRTz7ttlhMhhMp8kX7SILy89cfUJ4q5pCWjdv60BJ4uRl
         T1kw==
X-Forwarded-Encrypted: i=1; AFNElJ/eA/uTimvHHKSQd4CbNk+2K+KoOwbwYn95/1YIZV3x2qaiRTb3WDt8wAtvNb1rvLaf0Vafe/U7fOs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2KnhemHUBGuOYS9gy9C8jvmKVM24QaVW5izPIIxFWpAEp4yKM
	Seapea3qgCmHRtdYq7XshITS0eEYoRQPzorXKMlQdOAMhrs09dxfjx8R45VEsZP84MFiBUZh+rr
	G5WRDpMniPa2e+HJBIk2OpqPDYOiUYio=
X-Gm-Gg: Acq92OGuD+40Jwuuk1/+AQVA4QR+sfTWVYyGPw0sNl3PQkHtD9naRo8RMw9brj9md0b
	Ag6DZIwEG7dojut8Wrj3tT8bJ/RlP6FTiucjaSpugcJ0pvoo4CItWly2G1mkbz+19rslpGF9wBr
	OfcMkxWfKu3rrKPeO4X7l5ISaJdb1DaCjKd1NsB2v+XoZOzLbrvGF04izzcnopGC0UNZ4TYQ0vd
	lvHmAlxBWKa/Elukc1toiWdACrYlJ+DsPx6QBY+YHGvFgyHQpsW5ZZBtAYZ9VcVG5Ty+YuMzsv4
	EPKD4XPoMB4bqpcmkgBS2VYoB80oqvWxSUI2qAHAPPKN69En3tqSpqrLJjl6oGzpjJ/UYcwYrcu
	8Akwyq1Q3zpgqmvN4Qlel3EiVLT898bySyrFhb+OeeGE7i4w=
X-Received: by 2002:a05:600c:34c8:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-490a2b6e3d2mr7261425e9.5.1780079914175; Fri, 29 May 2026
 11:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522172219.1423324-1-tj@kernel.org> <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org> <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
 <3901fe0537edee9d7acdfd91695ead28@kernel.org>
In-Reply-To: <3901fe0537edee9d7acdfd91695ead28@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 May 2026 11:38:21 -0700
X-Gm-Features: AVHnY4KtV1pUn-d6UzBaLOg5AUfIedwDfvDWPug9r5TxPVQH38dOVxXqqoga_T4
Message-ID: <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
To: Tejun Heo <tj@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:12=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> > It should do set_pte_at() unconditionally.
>
> I think two concerns are tangled here.
>
> 1. The racing write. set_pte_at() and the scratch installer's
> ptep_try_set() hit the same PTE with no common lock. On x86-64 and arm64
> set_pte_at() is a single atomic store, so it can't tear against the
> cmpxchg, but a plain store racing a cmpxchg isn't atomic in general.
> David, is that the worry - an arch where set_pte_at() is split and could
> tear - or something else?
>
> 2. The SEGV. It's a BPF program failure propagating out as a SEGV. Maybe
> not ideal, but as long as we surface the BPF error properly, it doesn't
> necessarily seem broken to me.

returning EBUSY because apply_range_set_cb() hit scratch page
is SEGV out of arena_vm_fault() and arguably ok-ish,
but bpf_arena_alloc_pages() returning NULL because scratch page
was in the range just sucks.
Earlier bpf prog passed the wrong arena addr to kfunc and triggered
that scratch page. It broke the contract and kept the pieces,
so ok-ish too, but overwriting scratch page with proper page
during bpf_arena_alloc_pages() is imo much better behavior.
That scratch page will cause all future bpf_arena_alloc_pages() fail as wel=
l.
Hence I prefer that check removed.
