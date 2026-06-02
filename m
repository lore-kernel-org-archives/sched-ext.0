Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635903B9D84
	for <sched-ext@lists.linux.dev>; Tue,  2 Jun 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439366; cv=none; b=I9GOmSWaWVMXnEqoI1INk/Txkm5f+AFw1dtdXe6V6xUjOiepNeM9pHoEf9b7UU5ieocbM4a6mK6OdZjEVbttVaPNaO8ytVXjCIB55fnX2jPZ6efiDn/Er0soIaopVF8ZGaUtksvxiuC5WK1tcbeH9/yIJkJ3iqKWJGwQ5RdiSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439366; c=relaxed/simple;
	bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dEyAn9L8Sej/OsL2K9Rbu3srJXXk5CjQHfSXxQQznjRll/Iil81VQPAJVhQB1aGWpVWfF65fWTNFzh1eIO+wOdHPQ42q+1nt7rFPYfAdI4DZCWOhWdlIL36Mox4PLmGT1b0OY5Ea7zcWRcQ6kLlfqSmrHXxBDqCJLXDhFJvtQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjkg3kRO; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjkg3kRO"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-49068493267so69690545e9.1
        for <sched-ext@lists.linux.dev>; Tue, 02 Jun 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780439362; x=1781044162; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
        b=Bjkg3kROZfIrwtAwum7KRqbvOgSEFxQ3XKDhV8cFPVTlTwI23mlnz5DTS1eSTERo2f
         s8NAi1Rpgbo0WjBCI8vkzQDefafw7f7MA4l4BEdASPzhvzRww9UwaGynI+xBVUDZakVp
         2n7/S7AkFUN46t6IHEfaMgvyLHo1Cg1zPDIXXpAehE8jx7SaGMWQOxi1EhhTTWy7OwxN
         IQW9ewcJzBLdMBx9UEOaXT5L4S/cvlnrgTibh3vAT/Du/uDgAg5mejp9GD5DXhpEckPB
         X/jz+0srcgVhDtdnBk1Kky79imInnP6VhRfKgKSYay6V/rQTCtTjWYlXeu/nFSYokJw8
         OI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439362; x=1781044162;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCD4hCc4XJ9cLp0cEeWugpV7A+Kjg6CRiPP8rloQDrU=;
        b=k5sM47L6fhPiwVR/bQbp8Pqbwy7ji5qhSLDFQd7PzVU6HM7gimOSVlD2qNBXp6d4tm
         KP8yOPbr2NQuz2ZhEddJjR96UXftLrHj0TAamJ1/SAGyLLFeyrLMUPekYIlJDpON6W/x
         ClyxO8IRBV3XRXb6yzGWuT5jSB2HDcMV8D76STHXCissGGMoovPQhQ/rMHBGkctYjB1n
         eyf7DnE2j8h9qDSoC1vK5U0Oed9W37c/nppkjvX8iEJchGFX3wE7mfbYqezJppdSiR07
         0Qi+DdQ9PE49Dbd1GkE7XgcYHP/D6DtQYU8gkQvd+MW6REn5ThBjkmTdliQs2Gk8r3iN
         bvKg==
X-Forwarded-Encrypted: i=1; AFNElJ9PI4miLBNC3eo7xWsBgsz1UdV8BpNaeX2RI9/m5O6crrdPk23zOLtAiypgR7ZlH5l1AXQTv1aW/rI=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu12cqwMk2GduRPcu4WQttcwDG5ZkFy9ug/GcTj1tUJgDVmI0k
	QwlphXFxuv2wjDpTSmj7qF/1r3afqklJY1+yImHcJk2kr8CyqbDYYWhD
X-Gm-Gg: Acq92OHXJ6aRr9mWbOKAUHhgneD7RffGSfRhAur3fNsrdDVOreyOJCKbl6Uzk5HPJMc
	lDxvcYhGFenjBqldH5J3EaqWA1uYhnNLdgLbxFWpfI9wCtbU8gTCogOj2LJLKWM5areSsnD1i4E
	blJCPRt+J60DEcL61jm1Y4s/xbL06rxIDqbOeXPGEF2PeW08+p1O6a6H7Id1R+5+KZ4Oc0O4TAC
	XVGafq5SqDCxgotT57977tMeg/9qByzDRbqHH09A5AJ+DRhB3tax57VVDqZ0efaMLVNrElIgDQQ
	VuFEz93+7pDlOw2757mrFyQcxSUh/Vdix0LW5C3l4zxym0YaNXoNPL3K0Nm/WRJcypoguSxNPor
	fkDiepzn4OHeeeUgv6XXnnOzuQub2OCcsgrocJCPZZqaZ0m6A5wa7Zyg7k8j0xjKkQXmn0ZUB7n
	2ARNs9dLgnBeKSCxfDhrFuG70Dhd2KNtVMkM/IKPa1TTpct9wynWkUqvqVYPfyKAB9KrmVURlCS
	+W5h8bIygFmO2JtDk8eqAkgC6UotO1TpmXtM3fR4wyqdKNioHsX4f3OPFwl9TyVaUusBL1UCjMJ
	PqNmUm3kf88=
X-Received: by 2002:a05:600c:3495:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490b5ed636amr10835505e9.20.1780439361703;
        Tue, 02 Jun 2026 15:29:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b612f92fsm3362605e9.15.2026.06.02.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 00:29:20 +0200
Message-Id: <DIYX2UV4C7W8.212LVKLCI8WG0@gmail.com>
Cc: <peterz@infradead.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <rppt@kernel.org>, <emil@etsalapatis.com>,
 <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating arena pages
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <martin.lau@linux.dev>, <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260601183728.1800490-1-tj@kernel.org>
In-Reply-To: <20260601183728.1800490-1-tj@kernel.org>

On Mon Jun 1, 2026 at 8:37 PM CEST, Tejun Heo wrote:
> apply_range_set_cb() maps the pages for a new arena allocation and return=
ed
> -EBUSY when the target PTE was already populated. Kernel-fault recovery
> leaves the per-arena scratch page in unallocated arena PTEs, so a later
> bpf_arena_alloc_pages() over such a page hits that -EBUSY, and every
> subsequent allocation of it fails the same way. Allocation must install t=
he
> real page over scratch instead.
>
> Overwriting the scratch PTE in place is a valid->valid change, which arm6=
4
> forbids without break-before-make. Route through an invalid entry instead=
:
> ptep_try_set() fills only a none slot, so the PTE goes scratch->none->pag=
e.
> On finding scratch, clear it and flush_tlb_before_set() before retrying. =
The
> new flush_tlb_before_set() is a no-op except on arches like arm64 that ne=
ed
> the break-before-make TLB invalidate. The loop also copes with a concurre=
nt
> fault re-scratching the slot.
>
> Arches without ptep_try_set() never install the scratch page, so keep the
> must-be-empty check and set_pte_at() for them.
>
> Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page"=
)
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
