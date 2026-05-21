Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C116DEB1
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336514; cv=none; b=SzkmBYxdygO+fqjssPA5XaJttB7SEwr4JBDcLqgAzeU8dE6bQUDGheKAc9/UbAWrfBRsl4YdhZXvr1tAUZNTGQlIpGEQtq+CFB5C++dSMHYOOyWi00SoK0rq73LNDxYaRbJn/tduvKbNcRsy1ZxOGt5WSXTMA1a52i1e4y8IkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336514; c=relaxed/simple;
	bh=cXsEv7M8s8B+fW56IioKkoVTP6yPw0hwmUPpqeXjWu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=taeKNmFvOR1LumPAsSp2sD8JuL9WEJspMq16Zgg9szyLGEmOfti7K348YD0zUgKH8GixAdrDQyRz/9nHyfHShJNceLuvXUyMUIklA04cM1D2Y5WWNoMabnfLawM7XJSHYjovqbP6MICOaoSLVvLAUVNtshhcp697eZkGmrrGRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CnRHI9K5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CnRHI9K5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83ef1d17904so5612946b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336512; x=1779941312; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynBnbM/NLUcVxU1YYBO1La/PNj07zsMaWyq2DVRegqU=;
        b=CnRHI9K5GG7gE40hoOjmMfuhbkUo4HiQh4AE4QMxzU/VZ005kvXUqTRdmjMJo184zu
         Qd213FN9oQyTHLVrcgXfSq1WHfPDcyhuQZeTufgR12g1q6B5vYpRVRREfGTYoOk6JaMc
         pRAv216/oOOWNe05OJjhPqtZMqGq7Cp6joMIEPIK3VAGKnkK9c/Auyienq9noZkVyD+z
         5vxaiJd+gz+fV5Ao8L5CKKuSXlPDWbW6kyciBGmg/KBwaLHsAkXfI6h8wNh284GtN6J6
         6R2nUQyJLeinqFPzwBq4+MBy6/atD3r1K7+CIqiaecUSIgHFWuNv32SDmDn39spgc9kw
         gA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336512; x=1779941312;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynBnbM/NLUcVxU1YYBO1La/PNj07zsMaWyq2DVRegqU=;
        b=E2JxOTDlUj2z3koa5vwCKV40OHYEi0OrQzacf7mU90Mo03N1Vza3TouaV+wpWqX08A
         TND7JTgr4kJFZJhy7mLx98LkLALotHOwqV0saCwDw5HTeC4vOlltVknlhnZwm5f0j0fl
         +5Ml3LH+yBhwFecTKsJMhpLUh3BVAjcI8rmbgaf6F1/IjN9oYmSZuhtOqomoQCIvnHw1
         xyd3CTqPg+nTTYCJkOz/2Qlsi+StPV+SqHeklWH8rrZPGa3/xVmf+n0xYisCZ2aQHR48
         Mc3V7ba3RbiS08tnenvLsF8DPA2JywFvLhBevifua9CMYeXhd8+sWyGfyM+hz3hpjCfd
         71KA==
X-Forwarded-Encrypted: i=1; AFNElJ+egSw6OvxJY1Ra22MEYkpjmv9WTm/omLFcOW8uv2ZY2+eOK9VEInyIGSF5gjbc+8HZcKppiEOvxIs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxjvYecI0dsm8ZhGwv21twndPakuUgRaqsHnmphTkNAxZa6iVKz
	nCKIu6TkBCXxznRhNO72FOL1ClH03v7RkYERUqpO02vD3PMg9ONkGbsVFZhJ/uGhQy4=
X-Gm-Gg: Acq92OHSwT5FKiRI1g8R4jOD4f3VPWHWccmphsfq1SvLL0hufx6Ba7pziojn8NKpgkQ
	87+xxydQbhx0heWqiiN+Hm3jgrA+cjM+rYqDd+n7Ll6ne0oNn44ARh3/WVUZtKYtI/6AgLEUFRA
	409l4Ce7ITBNDPHmSsP0LC+jsSrJK4FkSLH5mf/0VcWzDXQzUZ9z+m6baLZuQLSl04XpEk2/q9w
	36WdsLTNTSmKefM2KR/E+o3fzwDlN1JjQ0iC/nmGkE9UaMwcolm/tL3O1lwGUVmlnk0Q6Atkcsi
	9WS60iLwpaK2ewnsfc8+C6l0hA9+ipIkFieEd5/qomHuFCgzv5FdUjVCsLAnRcPu3QI5502TGs1
	0Dyz/nrM3qGhq6FKaR40wJiPo6F3UcoJpfgRo+KpuRHSuA9Z7HMt9oi7FBgFE2G9Fc1gRjjjeCx
	ZJo2foId1NhT/HZgu0VhhjmfUJ
X-Received: by 2002:aa7:88c1:0:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-8414adf532amr1336929b3a.31.1779336511925;
        Wed, 20 May 2026 21:08:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8413ac7b2b2sm3505781b3a.14.2026.05.20.21.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:08:30 -0400
Message-Id: <DIO25GJPKAS6.1MJRN7AI18G4P@etsalapatis.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] bpf/arena: Add bpf_arena_map_kern_vm_start() and
 bpf_prog_arena()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-6-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-6-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> struct bpf_arena is opaque to callers outside arena.c. Add two helpers
> for struct_ops subsystems that need to reach into an arena:
>
>   bpf_arena_map_kern_vm_start(struct bpf_map *map)
>     returns @map's kern_vm_start. A sched_ext follow-up needs this
>     to translate kern_va <-> uaddr.
>
>   bpf_prog_arena(struct bpf_prog *prog)
>     returns the bpf_map of the arena referenced by @prog (NULL if
>     @prog references no arena). The verifier enforces at most one
>     arena per program. Used by struct_ops callers that auto-discover
>     an arena from a member prog and need to take a map reference.
>
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/arena.c  | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b99d786e98c..e1ba57c10aaa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -618,6 +618,8 @@ void bpf_rb_root_free(const struct btf_field *field, =
void *rb_root,
>  		      struct bpf_spin_lock *spin_lock);
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
>  u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
> +u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
> +struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
>  int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
> =20
>  struct bpf_offload_dev;
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index a811cf6170fa..51b9ae36feb6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -84,6 +84,32 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *aren=
a)
>  	return arena ? arena->user_vm_start : 0;
>  }
> =20
> +/**
> + * bpf_arena_map_kern_vm_start - kern_vm_start lookup by struct bpf_map =
*
> + * @map: a BPF_MAP_TYPE_ARENA map
> + *
> + * Return @map's kern_vm_start.
> + */
> +u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
> +{
> +	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, =
map));
> +}
> +
> +/**
> + * bpf_prog_arena - return the bpf_map of the arena referenced by @prog
> + * @prog: a loaded BPF program
> + *
> + * The verifier enforces at most one arena per program and stores it in
> + * prog->aux->arena. Return that arena's underlying bpf_map, or NULL if
> + * @prog does not reference an arena.
> + */
> +struct bpf_map *bpf_prog_arena(struct bpf_prog *prog)
> +{
> +	struct bpf_arena *arena =3D prog->aux->arena;
> +
> +	return arena ? &arena->map : NULL;
> +}
> +
>  static long arena_map_peek_elem(struct bpf_map *map, void *value)
>  {
>  	return -EOPNOTSUPP;

