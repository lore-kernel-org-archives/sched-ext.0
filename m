Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB203F58C1
	for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723933; cv=pass; b=NU1xRcgJcfLMhLLap9RpTg/31nhscLQDpHkLfaP/KXYQJhmaqOkkUpJBng4r6DDdAWPQgiYF+PlcCwzi1v19HFetjSdW8SKuMNooXH09nfNEW9Ov29PYkZR09WrEP2upfRoqOZbEKnPwHtnteswy1Cas1fAORovvg0qtopoEqCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723933; c=relaxed/simple;
	bh=K1bIRSu1qsTH0QLG5z+7HNXdx36VKK8jxuEIgQjNPag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcJ3e//7vIYqImWidfdt/ET035HfMcbaaL7pwdXPuf+Ne9bQYXluJwm8K6ySix0zXDp4YLlSLBI2VVLNtDSinY6ORSoU6z97PrdDxA71it7h/eMrEiZGjSpFqhvduhc4RA43jIAZFKkXzj6c+MxU0cNnWwgcc9nBmPGFkdm3AnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjOCGzWM; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjOCGzWM"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d734223e4so6152111f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 08:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723931; cv=none;
        d=google.com; s=arc-20240605;
        b=OhNL9cFcaw5qccZtVrGtK0E7QhSUxFesEWIvvVg5bPtEUNjb/g4/od3b2b6HjI/Io+
         JLKuEfIEfMkHKTsuEocmDf3oVYUpglbFQXlDfZzp19l4gB55ZgFVITX+XsoAnO/gm8Mu
         0T66qYPRPNAl8pZCsDfAxuMKK0OsX/ZQ6f9hJQbVnIUF04VJz5MTjp0AboJRIzH9XR/p
         YHOrVNAnMlSj3yZsH0RNLPEUSXfn36PaQ12oXL8TQmjSaq18NvyPrrYwE3Pz0kOAy7R4
         AefKY2mpIkNaJw6QlqviadJ5PxVQPidxxFtTTczv2lh4jW1oFEFysPZGZ7DbEpxePRyz
         Gi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        fh=BHKt3KVFI6/59QR9pqrUDRsZsuabKH9d7m7OHho//l4=;
        b=ZSGVo8XdEXfgN7Ij18jvloHx6awixDoo7h3UWRu1KFSH5ZgwfZy/CTzw5VziKnFy7p
         rbDlG4KMpTVCKUqDh2VwG37WXIhPBfnaHICtJ/1Snma/lX/Bcl02+KO7x+3WHb/8AdNd
         iKVh5MSUqGzQ/RStCBYB4JfhGx8LdaYeDQn0bowl9TIeheDCkDpioLrqWH0841a0iTm/
         i2foMNIyab4F6W7dP+aLgMF96YBgXYQLVCVnqGLmLxO5A8mOatNIWaqtkVY72hfsEfhr
         D+WjlUQ/9wOh3W5siHTgSDQ7eudUfdBG5entA81hHKPkw9QjEH7x4xA445VUsH4WWLDm
         EJ8Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723931; x=1780328731; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        b=WjOCGzWM6i9842XzZ5Fw3OJ9DBTHnv4xG3d1zSHrIeYnXUPT91oFi581IlminfC2Zn
         FuRnN188C58p13PZm9zCggNj6dZDv1jR3G3p60FO4QUabVbKwSLMHVG9lQIFeJFD6z+O
         DYWydTACW4EKxInn2a7c5o0xjHSzUIynOWR6/Wb15H0Glg2ST0XjJvZZp0TEYJ/XPd1s
         VArnseghzgJWUZXox941n4aD0BGJGnOkFmwTMm2DtkPO5fK88f/zYypqomhOTOTJVgp5
         cezTsJJ28iF6Wnhmj2Yckx+MEyJEPalEKDl0CCmOzXWrF2F3BKr8719VR/eJRb+bumsf
         90NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723931; x=1780328731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/KJeVQcoYJeZ7NEMluoiY5LeaLQ6MRIkXZPWciIjMs=;
        b=BKV6rmbd2Yim8iVE9AiMMhB5k7pNsHQOUouiWk1LH9Jz1M+Yhp+/kJhtb56WX4EZR8
         DmjvGxLQ/VIPNl01ruPCgSzSjVggDAqeDmFxY8ndyt7YUM6/1CUWzyUjzEfsdxwNZzzs
         m1LXOWrrCrKqBYMnKTftN2Z4jCGpluKvhCGWT+7A0nPMmQ8tzyWlgqw2vqSA4kbed/SC
         3xkiKlvP8si5cHjQ2qOecOp1l7QLeVbdMhKzUjQkwD7WZjSkdSh4o4uH5Y9wqnZjfBA3
         fe+aQ2mI4i889HuVDh+YfUyXjMKO0Xxi6PULeLApfHpHiTyKa8VvAmtdbNYIBIbkC8A3
         siWg==
X-Forwarded-Encrypted: i=1; AFNElJ+TEj8TSXXov669a/6Ceaw8mq9ymz2j06QTeLt36QUVZ4mKkf0H+kQFCF2XmKLPtzro4SO038a0QRQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQWjAWufLOj2EHSbM4qJn3aeyCQzf2nNm5pEyVfo1rcyi/wnw7
	DTBAUEFgGZ8LzjBRWjAQmbf99Ci7Lg8cToQm348ifAe2uAuBagH3KwIJ6rr3fKZpULSGyqETsyq
	NpTlozyAnhWvy8Nu25HSelThSQkCLP54=
X-Gm-Gg: Acq92OFRYAhgfTGgewcXjLUnjqDKpfIH9uQ4of5mv3b4rEAsc+mUeKszRwXn9c4nT1V
	svEJSvzuIDGb5V8y+aKPsSW6O3jl/SWNEoEy6X/cQ+UhTNz9maBLhIWq/V8KM6qbKVQtVwd9Ejj
	LHvkDLqwtJfIiX+8XMI3ruykOOAHZ/0r5OarONmyN1QfvzcHmPb73+72pSG9PZfgpucniAaYYBE
	PKX1hGjaah9eRDvaYCaKF7StvCXCC7W5FVg09XxwLrPEefod/3OQ4mzB9ixoMOKbsWtHbG/UdnP
	NvoRvfQTj9v4Eq1jJ24jnJ3f7lq8AUBqyxoYhj9vNeSXv88vZHOwaRMAd4vrT2M+CWq+3Dqokv+
	ak+aLQYminkmluBL+vNOuLVoQfPKm/enB2V5c
X-Received: by 2002:a5d:59ae:0:b0:45e:8526:7dcb with SMTP id
 ffacd0b85a97d-45eb30deecdmr22155169f8f.7.1779723930477; Mon, 25 May 2026
 08:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522172219.1423324-1-tj@kernel.org>
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 May 2026 08:45:19 -0700
X-Gm-Features: AVHnY4IIG790PDlY0_eU6bDIBpmGdEOYyU8PJIW44rY53Ae4UthkEJDV1ZzBOrU
Message-ID: <CAADnVQJ2r6qYRw-kRe-55Pwg9zAhj7SQkOd_eH=JSAyBFKKymg@mail.gmail.com>
Subject: Re: [PATCHSET v4 sched_ext/for-7.2] bpf/arena: Direct kernel-side access
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:22=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Patches 1-2 (atomic PTE install + arena scratch-page recovery)
> --------------------------------------------------------------
>
>   mm: Add ptep_try_set() for lockless empty-slot installs
>   bpf: Recover arena kernel faults with scratch page
>
> Patches 3-5 (helpers used by struct_ops registration)
> -----------------------------------------------------
>
>   bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
>   bpf: Add bpf_struct_ops_for_each_prog()
>   bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()
>
> Patches 6-8 (sched_ext: arena auto-discovery, allocator, set_cmask)
> -------------------------------------------------------------------
>
>   sched_ext: Require an arena for cid-form schedulers
>   sched_ext: Sub-allocator over kernel-claimed BPF arena pages
>   sched_ext: Convert ops.set_cmask() to arena-resident cmask
>
> Patch 6 reads each member prog's prog->aux->arena via bpf_prog_arena() an=
d
> requires the cid-form struct_ops to reference exactly one arena. Patch 7
> builds a gen_pool sub-allocator inside that arena. Patch 8 converts
> set_cmask() to write into arena memory. BPF dereferences via __arena like
> any other arena struct, no probe-reads.
>
> Base
> ----
>
> sched_ext/for-7.2 (f31e89a8f583)
>
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git =
arena-direct-v4

I created a stable branch bpf-next/arena_direct_access
with the first 5 patches and merged it into bpf-next/master.

Tejun,
please pull it into sched-ext tree as well.

Let's do any follow ups on top.

Thanks everyone!
