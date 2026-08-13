Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084931B828
	for <sched-ext@lists.linux.dev>; Thu, 13 Aug 2026 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595939; cv=none; b=WVzzkWNomgOpkGdcpVwzTGI+5kyVabGjp2Zdxqt3iALL3y8hkraq2cFbiqjgKngU4L9p5TnEYQdAwCoaKH23pkdwzSu47SLOR9hnV4tqndrWMLxNnrZ0gCrZt6AnCyyYyr1JBZYIOd4KgeevbMVA2v58eGzEKYNu7je+l7T4v5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595939; c=relaxed/simple;
	bh=ZP+YmiMqjne+BIOHGU+qADJTqbtfWsS0k9JYL/OigHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bhpTIeAeW1vl1+0Dk7NkgmlaAyWQxjFEHXpg1vBa7caa+k3WX/jwUVcbxy2jH1gDsQqil7ZXPcP4I8RffD4eTXLdk21R2h/EDXcd2rawPztb2Q+GEJU4q0wfX6RtgKcwFjPQ13xPy+6Uu/yTyeUpHMcCETumMjq2X9fuifXYWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ4WJtCH; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ4WJtCH"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso4404705e9.1
        for <sched-ext@lists.linux.dev>; Wed, 12 Aug 2026 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786595935; x=1787200735; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GAZ+x7z6BZhFTzywSoAUTFEoxQswSZuOueFTYMsV3yc=;
        b=gQ4WJtCHyew+2EdpKB8DC/fhIZfW6q9AgLUYMzsggKhkyT8G2G+hJTJw6tDzU75phM
         XYDMniP+ztGXM1Ezikprl0ONCoiyo11AV+RINfWxsHRUGbIUqFvHfXZ2op/sGbXH+3i1
         86qDtwCJuu1GYfZ3emAHKKVvCu5AksWiPpG663GDx2DNfDbZC9TOhs5BCPItNb6DDkGc
         cbQUsgguEpEWV02nnqGtiAJ5EutwP8uVCTyRnJ6+iqNYavtM6mMj2v+04TipFc9QEVce
         bqhe5QU2ySgiTd7a9POYwlBNQD71TdcJZbkmVLToSv959WkL/eVwIDxiZqtoijl7wmYF
         gI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595935; x=1787200735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAZ+x7z6BZhFTzywSoAUTFEoxQswSZuOueFTYMsV3yc=;
        b=CYRE/JYjRbFvjMVkJCIL8r+YHmuOWKSZQnkhSvX9vuZJKRELKjIZzjPA/ZwIF9Gssq
         Vmar84gj7hB9PAxNb+n8a9T6sMmF8fxBND5DeKYA0E1JbCM/LL9x82AWSk01CEyVIRla
         +ousRS27fKmxa/ZxSbi2dU8VwBluILEKKaCYUoK0qbFtynxDRtD/nJNe3T9Eqk175QAA
         RCJ1O4lJrsikGxa4Mz7+iGIxXZx5/AOTUoWSPaBTwOnu4E+Yhn8j8gpqccMucbrqgzQq
         8mXPP/UkIORccW+vOdI2NmF9xaVnnqcyJi/Tk1RsdlP1dgW0du+P1BGSSdJ/iFRX1bBT
         qE6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoGNhI61tS13SEZcnn9fbgql7Fq7yh7mXtJ3ZgbyEvKT8o7FdjG2vRHe2zmGAJ4pU67mDjxHlV1YDA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyNqv/+vxnPZJ4yEnBWX0isypXpc/nbQ3TKnlSuEGEwtuImZQpy
	CL559cDFBMmW2jX2I/qVDRvStmDnwIj+YEpf9KiQIEbP1wdH7UnOiYdU
X-Gm-Gg: AR+sD13NG05IrWv5lMaWjCLKVwLq5h6Ao9yrH1CNKSVKXj3HlMQuVQQpK2fiKcGUFU4
	pt9HYwdQY7lkw/dIPDOyirg3mZS+mmBbO+nsnq5Wc4bebeZmSOlvbOHcDjCk8sVK5lAuR+/aLdf
	wHWiAcL4K5RT1SiqdQEwFwLCWLy0/Z8HSz+SbTbui5JjtnVNn6m01tMzkssEVmqhLsM9SNKHbe3
	dvci4NCXV6c3iygC5fceFlxApIylVPRV3EiakXBV7Ac3Py0erzVAMJL2G1mD1CVNPzmJ7K3ULB6
	Olkq4HKvUOn2Tee2PjJLgnLgVTLQUWUu4nukfJTxwurFSXzk62Q5LIkStSLtX0LPPXgcnAp07kp
	8fu1qxGJ0l/9CwGwr1BuBJOskWXNzb0jgYjbXjaDC9rAe+bkzrv7YyPAwsg3EyQVlvaUUIus9R3
	lCnllBTy6FZWkALuCMctmxl+LcDXH0xG4YYT/WLzbaGJXGka/lUCaNp6JViFRHxL51VZbBLpFjP
	BiVXs36Iacok+R2akA9KHKeivLE1P6DaI1gd6aHnP0Pj80eQuWy94hQQnDBxZFJHsqL3addbQy6
	AHawsDGRI3IiIi/ypevitos+0X0=
X-Received: by 2002:a05:600c:310e:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499821881d3mr26179715e9.1.1786595935294;
        Wed, 12 Aug 2026 21:38:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820f5d26sm23033735e9.1.2026.08.12.21.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 21:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 06:38:54 +0200
Message-Id: <DKNJEHJWIC8Y.2QH6JE3N590FS@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260803001807.646357-1-changwoo@igalia.com>
In-Reply-To: <20260803001807.646357-1-changwoo@igalia.com>

On Mon Aug 3, 2026 at 2:18 AM CEST, Changwoo Min wrote:
> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
> every translation unit including it emits a copy. __weak makes them all
> resolve to one instance, but bpftool gen object merges only the symbols
> and concatenates each input's .addr_space.1 bytes, leaving the surplus
> copies unreferenced in the linked object.
>
> libarena links ten such units, so nine copies were dead weight (bytes):
>
>   object                             before       after
>   -----------------------------------------------------
>   .addr_space.1 in libarena.bpf.o    676200       86376
>   libarena.skel.h                   2100123      892371
>   libarena_asan.skel.h              2641124     1466477
>
> Declare qnodes in the header and let each program define it once:
> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
> lock it guards.
>
> Tested with test_progs -t arena_spin_lock and -t libarena.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---

This seems ok to me. I don't have better ideas. Emil, any thoughts?

>  .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h   | 7 +------
>  tools/testing/selftests/bpf/libarena/src/common.bpf.c      | 7 +++++++
>  tools/testing/selftests/bpf/progs/arena_spin_lock.c        | 7 +++++++
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_=
lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> index ae6b72d15bb6..71d9db610263 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> @@ -103,12 +103,7 @@ struct arena_qnode {
>  #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
>  #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
>
> -/*
> - * The qnodes are marked __weak so we can define them in the header
> - * while still ensuring all compilation units use the same struct
> - * instance.
> - */
> -struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];
> +extern struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NO=
DES];
>
>  static inline u32 encode_tail(int cpu, int idx)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
> index 50be57213dfb..06481f2a2892 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> @@ -8,6 +8,13 @@ const volatile u32 zero =3D 0;
>
>  struct buddy __arena buddy;
>
> +/*
> + * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each p=
rogram
> + * linking the arena spinlock provides exactly one definition, so that t=
he array
> + * is emitted once rather than once per translation unit.
> + */
> +struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
> +
>  int arena_fls(__u64 word)
>  {
>  	if (!word)
> diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/=
testing/selftests/bpf/progs/arena_spin_lock.c
> index cf7cda79c16c..92e75ec3844c 100644
> --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> @@ -23,6 +23,13 @@ int cs_count;
>  #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CA=
ST)
>  arena_spinlock_t __arena lock;
>  int test_skip =3D 1;
> +
> +/*
> + * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each p=
rogram
> + * linking the arena spinlock provides exactly one definition; libarena'=
s lives
> + * in libarena/src/common.bpf.c.
> + */
> +struct arena_qnode __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
>  #else
>  int test_skip =3D 2;
>  #endif

