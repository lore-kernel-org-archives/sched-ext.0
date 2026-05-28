Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA632B133
	for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003833; cv=none; b=O0CB4heSRWharGB9Z6vTQ2VR9VE/5ihk8vPGhRk5kaOp4Y8GIcNEBBX2CQ94rxti+jsoi1+qT6Zu9px15P0A8ohBRlMf3OE88VHLnGp7DPsToTRR8RioyukYBnsT5LOdA0NPeHihHUARkowzUPkROkDKPIVmPO+tcmmIl5fpHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003833; c=relaxed/simple;
	bh=Z5fwT8m/j0scgq8nZY7qsq1dvsdBoBnzZKP0fDmds4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Gtc91lxf1MVQNgEnHOgwlNkJAQbdjqvuHsoq/x08i+awwLgKl9OUf9KiOvXzybS+MVA87RGyOs8fY1FHWvlKp3c2tAHjxUEijT/bpR4CL3SA4cgJ9R2IBNFbaicW1Q0VJXSKPtKCBHIl/Rv1qml+omq2Y6q3obyJJeBrb8bieKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpyRJ9qy; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpyRJ9qy"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso11831860a34.0
        for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003831; x=1780608631; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpHrgIeXXcvDfmuKsXXjHhEfFrUsBGF9Cp2mPrCFg1E=;
        b=EpyRJ9qypdylGIZ4Eu2FcDf5vT8lo6pBsJ9y+qDmlOJGKzcnqG+pVXSs8qMt6YvWyA
         NfNnhWD+fZQtugCBP+RiBsW0VT6r9KdGEhWgPby9NiFVevzN0SiyzdUA+6MLtAMycrj6
         fuTXOJei9XHkinTjkjki6E+WUfIVow4YEjObGaVX3iyixwRtMd/hCDg2BDpQfCZQq5Vh
         /SuMJZ3gqHPwzkCaCqOr8lgkuELkLUNplHm8XB5Mt6dBYQJ9onR6Y+o2BLVL2sbfeDao
         U9ROZqgPytBCqjhhbgEmRsfYIImrDUC0bDWnkFHXXmWWVjSI+EC6xdx1CLLeTXY3pHY9
         EU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003831; x=1780608631;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpHrgIeXXcvDfmuKsXXjHhEfFrUsBGF9Cp2mPrCFg1E=;
        b=QV6eg/K6fO+8URrTjP6Mv1oKdUJ4OkhS1lGEFnVHpwPNYecTjoO6wQTBwsUDbJMOG2
         l2DvNSB3ntSxvEj/eg+IS5vSykkoFjCvl/WSw14sHcwt+iIIxmPF2MdMSo/juzwN0/a/
         h+xy4Iawy+wiSqyt609aTGx/9z34/f7bInhNYzrIKJJNHwkAVL2F21vLEQvaZaUa4e9x
         etjsqRuTYzFR10GEUj3M6ixUKGVt/OKDn9SEZVN+vWa1gP7rbSXh3u/InXN6wbSVsoyM
         3Eh4pF5R+M+U0FpUxJyMgZO/EIY4iEEbYiZ6FLhyAVhdl5rkGpXXDSVMvB5wr6ZoXFtV
         BpZA==
X-Forwarded-Encrypted: i=1; AFNElJ+O2pmGnhIcB1cTYIw8feJzg5/k489goqlLJVdLJkEbxXcSmdyT0tlS7JlSTBpVEDBwPikYPajVamo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzL5uAVWIB8PH/fbpADkf7A+HNrUguIQnaULmh+6bfem3fUnfX5
	QN0rkjxxXYJGOeVK8MEpgXpcD0YiSpSMRqJ/NB+Ee33ZVHnvxewrMvL9
X-Gm-Gg: Acq92OELb1rxwAXqhm6vyQd/9Jmt6bEln6844vFJB8fi50kmca9BiBTfYwcPk1y93m4
	DmDIergfju2qgmgJV+uQtovjCUY1wnJRX+mO5ICzUsPp2p0QPK7rGBbaG3ANG/x6rnMcuJiYpNU
	asRtsGLQvsu0cKuGmPCCJjg7JxH0+KcsTr3PL8+jJfMqCIg5rBHs4k4oTOM79b2HhjEbu5mzFeL
	yNuGP9knWO1P2n4YwW4cW7WTqK5cUox3r+ZDHnhpyDiKn/jWMt6iJenxoWKd+Hi+aiB8O5Lrhyu
	h6ieWi9vnyGHiPuC7r0SufrnWjweFn1RndJygzaxlKdIoQiiomHEMLRCmQxjMqFT910Rc5NYKdX
	jrxu+ueDcpSPe/jlQ24PT06DF5BgZstP12OwPnqeEAehSs1QikLbSa3QYyYJhwT8JuuiUj7zxUQ
	O57HteKyn6OJ4AMnjueQs4x8ntZfC9YEDeGI9o1wqeFzN7oxvAJiebAmmFwDYDFdcJtKBqp1mj8
	p3pOuaXkmR4q0dKJuXwnl78umxx
X-Received: by 2002:a05:6830:81e9:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7e694e30aa5mr218271a34.23.1780003830565;
        Thu, 28 May 2026 14:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695212f9asm129362a34.13.2026.05.28.14.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 14:30:28 -0700
Message-Id: <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mike Rapoport"
 <rppt@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>, <x86@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
X-Mailer: aerc
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
In-Reply-To: <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>

On Tue May 26, 2026 at 5:45 AM PDT, David Hildenbrand (Arm) wrote:
>
> There is still the chance that apply_range_set_cb() could race with scrat=
ch
> insertion, right?

yes, it can race, but the fix is to remove only:

-       /* sanity check */
-       if (unlikely(!pte_none(ptep_get(pte))))
-               return -EBUSY;

It was sanity check, now it's simply in the way.
It should do set_pte_at() unconditionally.
It's totally fine to set it to proper page instead of scratch or empty.

Tejun,
do you mind sending a patch to remove these 3 lines or should I do it?

Changing topic. re: zap_vma_range() issue.
It's not forgotten, just complicated, since we can't just take
mmap_read_lock under arena->lock, since arena_vm_close()=20
is called with mmap_write_lock held and it takes arena->lock.
Will figure something out.

> Shouldn't we also be using ptep_try_set() there?
>
> The nasty thing is handling whether ptep_try_set() actually works.
>
> Something like the following on top, maybe?
>
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 49a8f7b1beef5..086bea3f3698e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -122,19 +122,27 @@ static int apply_range_set_cb(pte_t *pte, unsigned =
long
> addr, void *data)
>  {
>         struct apply_range_data *d =3D data;
>         struct page *page;
> +       pte_t pteval;
>
>         if (!data)
>                 return 0;
> -       /* sanity check */
> -       if (unlikely(!pte_none(ptep_get(pte))))
> -               return -EBUSY;
>
>         page =3D d->pages[d->i];
>         /* paranoia, similar to vmap_pages_pte_range() */
>         if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>                 return -EINVAL;
>
> -       set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> +       pteval =3D mk_pte(page, PAGE_KERNEL);
> +#ifdef ptep_try_set
> +       if (unlikely(!ptep_try_set(pte, pteval)))
> +               return -EBUSY;
> +#else
> +       if (unlikely(!pte_none(ptep_get(pte))))
> +               return -EBUSY;
> +
> +       set_pte_at(&init_mm, addr, pte, pteval);
> +#endif
>         d->i++;
>         return 0;
>  }

