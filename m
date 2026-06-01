Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32201946BC
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272993; cv=none; b=l+9NykIyUN4hFZanlc2tgsuMB+LwTNPwraeq4iWV56c/bCdZ6cTZ5OFh5OlGP4IfNOtYRpXmxXt/kY4ZOoJb8Sun9jeSxdgrlyEM3FsulLVs92scGxPHuf17InrAY1Ywn9DH2L/3cC9hD5HSxjhwkWjuInVmNqTCdUy+HDwcJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272993; c=relaxed/simple;
	bh=U/Nl6wR3sC9zWrUXUr0okCgaH9pl58OSQrMDaxSxSsA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gg2SnPOqbU2qiINBTIjW8z8Kq7ghFvys8We++mE8+G8i07QZ1iNCNILj7+kbU8LWTTGpVPkPtNUzwz6tAlKqvIh83O/YRFuqetwRapVGkecEEPI4iRhT8xzBcMwyG/7anAw4SlMv2iHJpYVzKOjs3pAR065rMSxossxa3xm/Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS+aATaF; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS+aATaF"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43ca73487d2so948243fac.1
        for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780272992; x=1780877792; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQdZFdRPMl5NqctlRONekKw7Ci+pCu3VSk8zafduNPg=;
        b=ZS+aATaFtz7184RkaHptBYvIgk0jg3V33yFVXHiqNJkimOoLXtSsh/4a1M2I3EABuJ
         0DHp66xQLx/m7Xbv0ZElylqxOsL/Ku7g0dUqvtr2SWS5c9n/A2tB16y95zyUH9dhpCgc
         QvgWhQzA7H/EFIoWj5Lnp5n4zRfW5gCaht8a//52EH4LCinloXO3Xy9rA1ABzVoR8679
         KCeV1TBX92l4T/zwnXVTWQ94GEuwDaAM/B9MaY3xu+mswR+gWntUSrW6JeQJs13MTGem
         yBSRw2UUs+ttrGwQpUZ+suu8KCNcRv+9tCtJvyNiUNeIxNrGkU03pBC9M73k635GC0JY
         JFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272992; x=1780877792;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQdZFdRPMl5NqctlRONekKw7Ci+pCu3VSk8zafduNPg=;
        b=DE9oaSAN1QPbRhgWRL3WDJqAvImK9YkhtwF9FAC5on3qANxBtLnifBj5t6/ngMbOOF
         wcxbOFMmRLzVBdtlQdwPvcPSVVZxvewig1GSUwtsV0ZTOo+yPGcyXGXZCwMvF3m/s0oq
         QYPS9dAtgY/HjLGWPDPoEPHXWAE0qF5wEm0i+YRpVI1P6VGdTN5Y/DIHx6UIworX9fkK
         8kQGDuYRV/KUlmwuuSI1N+6BjpE4w2GcqbEiA+LyiRMWkJ9M8zDcLmHE6IRi0IzKJiaa
         t4oEqutbYsH7Pp83oegPG2YhMj8jXvs77bcTz7hdygjisnBglSwntAESa63I47WxbR2A
         8ReA==
X-Forwarded-Encrypted: i=1; AFNElJ8Sls/WiLZtHFeO/LO7C2F/1m+dLxszjDX/c1BaHyiyKU/tLjL7qpoxb2Adq3AHJ/cWrNE0/AF54VI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZoeX8OOBfFAGppFSbhPWihRuH53j63S0t8NzPXIQ3BqnL+Jq3
	swFWpvq0z3BOoYlLUbK+az2LUJRQhjW6SN0TNfqD0kSGygWptDg7sak+
X-Gm-Gg: Acq92OFJ53zSPvUM7BnPRBBpuF5PDGQPDNIPTAB+bIJkR0RmZyQrjEL50pEbc7Kl9sU
	KAxswdp2B2L/rNm0KqDdaT6NqoZ3RGSuwQYELLM5BzEntBPdgpT5PxOTxTlFzZqRc0ro/fCM/8h
	yTsv3qMKAlF/zZzYLBct6ENtnSP2u50ffXuNXz6cEscUVyzs4KU2RACHrI1+qqMSKDEsC31Vuqg
	h0UR7QvTZJq8hMM+IW1QMMHljYW3iVv3zOD5+CJv5FrKrTQZUWd94Lcf8uqjcnRPFzbfjXpkmM+
	/31hZWYgftEOmKkhbmfIafo57e/4DPog1p8ZFaQWlX7bb+weaMj5V2FIvvOh1nMfCHtv6q9cDx8
	FyBWrxoTsxJ+xeem6qpxlkKZT6EHMRATiLRoT8G7NVcH/BhsjlAVn4tkMR4NdYgG5yXwq1fya6I
	CbaOlGQQbW9x6WmCoAvdsSifdppkYVZRAHd8OjrDK7xlGRC+EoTmm2iwUl5/uh632H2BNWhxAD2
	FMbsd/pJr2lzWlT4WfHXs4X
X-Received: by 2002:a05:6808:80c8:b0:47a:499:b616 with SMTP id 5614622812f47-485fb2aa4c8mr3766450b6e.16.1780272991503;
        Sun, 31 May 2026 17:16:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a576sm3396395b6e.4.2026.05.31.17.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 17:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 17:16:27 -0700
Message-Id: <DIXA3RWL6XLD.1WZMXZRHBH1SD@gmail.com>
Cc: "David Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Peter Zijlstra" <peterz@infradead.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "David Hildenbrand" <david@kernel.org>
X-Mailer: aerc
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
 <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
 <3901fe0537edee9d7acdfd91695ead28@kernel.org>
 <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com>
 <ahnedQ33ZH8ogjbC@slm.duckdns.org>
 <8cc56c7a4aa29628b7d17d85be7eadb9@kernel.org>
In-Reply-To: <8cc56c7a4aa29628b7d17d85be7eadb9@kernel.org>

On Sun May 31, 2026 at 10:47 AM PDT, Tejun Heo wrote:
> Hello,
>
> I posted the check removal [1], and Sashiko's review flagged a
> break-before-make problem with it [2] that I think is real.

ohh. interesting.

> So instead of just dropping the check, the install should route through a=
n
> invalid entry rather than overwrite in place:
>
> 	while (!ptep_try_set(pte, mk_pte(page, PAGE_KERNEL))) {
> 		old =3D ptep_get(pte);
> 		if (pte_none(old))
> 			continue;
> 		if (WARN_ON_ONCE(pte_page(old) !=3D arena->scratch_page))
> 			return -EBUSY;
> 		ptep_get_and_clear(&init_mm, addr, pte);
> 		broke_scratch =3D true;
> 	}
>
> ptep_try_set() only fills a none slot, so the slot goes scratch->none->pa=
ge
> and never valid->valid, and the loop copes with a concurrent fault
> re-scratching it. This also closes the set_pte_at()-vs-ptep_try_set() rac=
e
> I raised earlier, since both sides are now cmpxchg. A broken scratch entr=
y
> was live, so the caller flush_tlb_kernel_range()s those pages when
> broke_scratch is set, like arena_free_pages() already does after clearing=
.

Makes sense to me.
