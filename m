Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4E319860
	for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146775; cv=none; b=NaXK5jAVlMZYSP3V9B5uE4UbE09Yr46hOOej07s5LPR6hZDi9/skGxpp5KRu9NpPEUi2ejW/kehvlDSHaHQYRLGcOYpvFgUyk3q/oRCuM8cCabkxxt6PMVtv5o0OqeqcNQnVH3E9LXIcZ0e6F94RUAgJ+F98gFx9BedS6IHSxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146775; c=relaxed/simple;
	bh=0kYTwvcQTSXqGCDcUvwL/fysNGrf0hmcI8+XhRcCZRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yg13DPKepRlLU8H42sxCz+L+QU+UMdZWhpOZ/f5D+Q4onjYUUpu+8N+1ex/iC5fRrkeDv++wjdJav6itzQ5rO4GrM8I8xxE1D+WR36wgoNi4K/sy5Sw2iug6w1+OqWcbf29cbFYQRGAk6gWoWGdWVZlv7xdRaAKVbK/qusHj0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfnV8l8S; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfnV8l8S"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651bc83e74aso3042372d50.2
        for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146773; x=1779751573; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJpF8zNQx3fuLJ61e34VmvRInkcEmUUj8JXY5zhxM5M=;
        b=OfnV8l8Sf4Y+AAagMWYYbkBgqHXAHZ/ejwiFOQNVDKM9i9erMAVVrJUK8D46pn44pT
         jdjGOR6bWQJBNOg/JHXrJCQ1WtPA50/oVzR0hIZK4rgjtXh/hvDElhyVvjB+6oG/ntrM
         Jn29iJe1K9Qame5QvzKLQ9UNEkrugjrBPTcFiC+hjywg9lbx7RGKZ134+f7YDk6aMgGS
         xdNecToSkwsUxtOVoxGUX55vjT6B956M+zWdTsvAraGaSSX1OcAoHIrKpum0f7ziebou
         ShcbP1nRO6KvZ5RqwhDOIWkiaZv5Y/2Cyq8Tc8FArdGB2hWgBg3r2noE8tXCz8N01TMF
         pBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146773; x=1779751573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJpF8zNQx3fuLJ61e34VmvRInkcEmUUj8JXY5zhxM5M=;
        b=kKcKIK8i3uuXnTzyp2jEkmVN7S5o+/XgzfOdXj6AAXqnOI6cRX8wziuF5ymX2ZW/l2
         Tx1omX2J7HbKsZGcgxPJZW9L+W/KbDie4k6rpGHkerzun7NVde59mg2BEJxHWUUZpuDB
         7cNri75DKwmpsoRdN0eG63xGHvqbyvQY0wzUfEbDPYZVzMFXx0fE4+gdWkFAibiK6Zl3
         m1X9kDnalw4bKdy4u6aGE39jJW3JyBdvf20B60GC7D3sd1A0fHWqQR6xmOqLpT+dthi1
         ewM49G/79FwtMR5WQSb7x/Wm3FR75McBU54LqrUQdCeKRr7cER+4VQYF1eenILPj9a8W
         2fKA==
X-Forwarded-Encrypted: i=1; AFNElJ95V5o3fOq1/HPMQ0G0O2rj4TUk4ggU8mrdbfV6VPV6yMEE2S4aivGgrNeIRNu5HDXeR5coXaVLFIc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzlbJIG4cEpmyWnM1zQ9/pu33m2ShvG7058E+bCAvvLDnEkfDDw
	6zL263VeBFKAgBS0wj9xGeAdWTSYkZ/38zZc1N+h1QCz4abKG1IlWR5/
X-Gm-Gg: Acq92OGCYR7y6ul4DHpEWWlQP7JZEtpBvc8vimpthZuV9ge2IEFCZPPtH83hCM/n+ty
	6HZv6ui+E6qvE0AKIktHeB6nftnUWh3YJ6+g6DYZ+LsPY39jWUukBCHpDhHOBO80bLKY4Ozc2ca
	jXCOL0yu42pwbjpSrERCdISYUeoDgtfZxe9zpwdQyytOlsx2htbRO/1HkZlQKxPVKlOcCVIvFEQ
	sZPcsUieDunuDyFgWPwFFW4svQv8BqO+I7MyHNvqq0Cu3/pMsgd8XV0ea2r0msjQRoNytnIp22Y
	TRpHYuYAQ6VI6odVPlkbLPIWp8f7MkfbTYLBZy3jFUZ86ZiBoLBPyTO+4CLeaZTJ+Dv7nl8PKGR
	oD2BZXkGM1SGJbEZB7EoEkie7ObK7oYTS2oUdqP21O6OikoEP1ygvSfsiPJ2RWpqYYZELj6xHVj
	c6FH9KT0OxpE+a5CzSktf6cFxeHwQ1KHaOL9Qxe5+vpZ5373G+Eofdi+sFKyGF8Omsrx3TIwoD9
	RJW2DCFxbeMtY949g==
X-Received: by 2002:a05:690e:14c9:b0:65e:438e:c025 with SMTP id 956f58d0204a3-65e438edademr10259078d50.19.1779146773245;
        Mon, 18 May 2026 16:26:13 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:52::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm7022713d50.12.2026.05.18.16.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 16:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 16:26:11 -0700
Message-Id: <DIM6W7GRZK2N.14AH43S1XTFCG@gmail.com>
Cc: "David Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
 <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
 <agtt2dEjS4Qg7a_P@slm.duckdns.org>
In-Reply-To: <agtt2dEjS4Qg7a_P@slm.duckdns.org>

On Mon May 18, 2026 at 12:51 PM PDT, Tejun Heo wrote:
> Hello,
>
> On Mon, May 18, 2026 at 09:20:42AM +0200, Peter Zijlstra wrote:
> ...
>> Should this really be part of scx rather than be part of the bpf-arena
>> thing proper?
>
> It's just a layer on top of arena. If bpf folks are okay with it, I don't
> see why it can't be a common utility thing on the bpf side.

Well, this gen_pool based allocator of arena memory is a temporary hack.
It's ok for rare allocation like in this at scx init time, but not suitable
for active arena management. We don't need to expose it beyond scx.
Having said that the fast and generic allocator for arena is definitely nee=
ded.
This break through with scratch page and bpf_arena_handle_page_fault()
cannot be overstated. It is a huge improvement for kernel <-> bpf interacti=
on.
Not only kfuncs can now read arena without ugly __get_kernel_nofault(),
but we can reuse mm/slub.c to manage arena memory!
The key idea is simply this:
get_freepointer() {
  if (s->flags & SLAB_BPF_ARENA)
    return (void *)(s->arena_kern_vm_start | (u32)(unsigned long)ptr);
}
I'm sloping a prototype.
