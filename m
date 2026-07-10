Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC7409113
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727504; cv=none; b=oaAH+VlhcDhAEY7aXa8b/hER3r+5tx+tiHK74P891ALTFDE1JhMKrquUeoz50A8Ow7DVPE12WVcCkxqm9v3PlvJe9dizi+BXdM+K0hkZsjJb3zLFMTHB0f9AxKehWJvAADjPuqD2EB1cVJlhyglV97CcmJzdcYrN+Eb6r/sB/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727504; c=relaxed/simple;
	bh=M2LYlek18/SB1FwIlRPhotmjnWvh7cFNxln01OnmkGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ak0seMscpFM1Nrh4/VcnMoBpiZluHVuGJRwj9CCvSKclJi1Qo0H/kXpXbbmPZh73FcVAsMsiT2w61a/x8iAO2rzRNRa6i4Z5dSS22OC3rqgRecWxlQDZf95dQMMLcn0bv73g+hbyfBywRUtv+GQNY70IOjjHXmmO4RBW9B95aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ple6ymhK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ple6ymhK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1272825a91.1
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783727502; x=1784332302; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xDBJh71NIluoymLki2hOB+D5KgIyGHjvz4ujUNdEcn4=;
        b=Ple6ymhKWprCjHhFOcWKhKAASfTYgnw9HbwEg5cxsc5WxIpWBa7gJkRLuewniwdLQO
         4JCwX+st2KSnUQ4cnSblfAIy9wr5xbYcKW8We6XjytVwvfUzd5V/iab0StwnuOR74YZF
         SH+qzJ9FiOIJzKIs0Q/h8s7ysk3TqvhpduYBS05GmZKGQdPtP04MExPH+lZftnAVwgtt
         lYsqk7LikxF7K0UTPXcjjs6U+0wm7Kzm5Gj8mIBWUzteH5Tw6eeSMrGqgl4LVX9AB4uH
         pcNvdSh7R3YQnwfnBEJGTnjNJPnLrtZdDVBTsjLwwQjCiJ5iNXIn8ZpCQcLFiS7DmXkR
         9ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783727502; x=1784332302;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDBJh71NIluoymLki2hOB+D5KgIyGHjvz4ujUNdEcn4=;
        b=bR1ZdEyrYVm5MmpVxT408uAZc5lw70B9la2kfw7V3Bw54lbalviic+eqtABNMoITtr
         lHkhtIy0oXisi0QWsV7t3skCW1/+LcqfJ+jWuF1+3o3OgnpIBJxH5uN8O0w6F7AjrFe1
         PocXhjeb1zuI5SmIjUykrOyq6WZBgfEkgpXtwpecEC5yRzFsvl+EB3mRaKLsumvA7xVL
         riMbID795fyU66PwcVpRJSIlTBy8pDLFBeXtVohx+4+gC7+ewLSzLO3IXsUIWrPhKdC/
         9OTFk8ui0hPcMiB6AgRrW3+Un0YNhzPnWSQpRGj9z3+xWIufWg9mcBOX2s/ViUXC2PW3
         JkCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQSAo3stLIKU8AHscrnnkUtPNSWU6JOzFSgBX6FBdNLxQdFBkoCPyZmPj1iluzcmDbPRik4XOR27s=@lists.linux.dev
X-Gm-Message-State: AOJu0YzEroKaKtPtHSp4OzZBDrRGGnBIaJxLHfRdGn/N8aydXLpVTxyJ
	ubPp35x9OM5EDjvGr6xkMDWyqtxdJSAzHfZBw3ZI+2oaf2f9fS9MsW5qqSf5iYwhquY=
X-Gm-Gg: AfdE7cna1NOKDmCRNbRpI7KzIucVz3TgEmF2PGMWkq0Du0T0/w9AvHjR2iJbLKun3Ak
	lqXesl6wRL8eK+yq9z7EUGEwJHuokMtn4Kd0a9NH21EJbQFiSCZGgGlkQzYNbE41hhlRIEZ6pdY
	xO++Oh31z36RsiM8qPJrZMk2BoJyMOsFuCTcGG6l5CIvUGsnfSvkx04p6hPK2Su/pzEaPSxZ7WD
	+UXNJGNCzxNmsXVXT/BqT1bW+YadVmBfByvYZnQmAvRP1TzW3OMIK7JWqZ5Pv29NIKKLzcbzSTs
	xgqqi3Cxhc8G4jxWaZKU1BFtH7Do8P1Hrxmawfh9HK69CekPRGLuOaqb3lzN7iN1RwQUT+sNbXI
	xRWxOVtyr0+1TH2LklqFsXJ06Fos2RrWAiITqJ5R2D8WZzJJuVbOMvdLt2ntL7KFr0xI5vA==
X-Received: by 2002:a05:6a20:3d02:b0:3a2:dc51:458 with SMTP id adf61e73a8af0-3c110be6e17mr1117243637.41.1783727502204;
        Fri, 10 Jul 2026 16:51:42 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::6185])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8665sm44079029c88.10.2026.07.10.16.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:51:39 -0400
Message-Id: <DJVAML1EF9NM.3GAXGFLUZB5GW@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: test
 bpf_cpumask_populate() rejects a borrowed cpumask
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-3-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-3-main.kalliope@gmail.com>

On Thu Jul 9, 2026 at 2:28 PM EDT, Nicholas Dudar wrote:
> bpf_cpumask_populate() now takes a struct bpf_cpumask *, so update the
> kfunc declaration and drop the struct cpumask * casts in the existing
> populate tests. Add test_populate_borrowed_destination, which passes a
> borrowed task->cpus_ptr and asserts the verifier rejects it as a writable
> destination.
>
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One thing that'd be nice is an explicit test that checks modifying the
cpumask being returned by scx_bpf_get_idle_cpumask, since this was the
motivation in the first place. But we don't have a sched_ext test in
selftests/bpf, so it's not worth the complexity. Since what we're really
testing is that bpf_cpumask -> cpumask conversions are acceptable but
not the opposite, I think the tp test suffices.

> ---
>  .../selftests/bpf/progs/cpumask_common.h      |  2 +-
>  .../selftests/bpf/progs/cpumask_failure.c     | 23 +++++++++++++++++--
>  .../selftests/bpf/progs/cpumask_success.c     |  6 ++---
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/t=
esting/selftests/bpf/progs/cpumask_common.h
> index 86085b79f5ca..8fe01308d210 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> @@ -61,7 +61,7 @@ u32 bpf_cpumask_any_distribute(const struct cpumask *sr=
c) __ksym __weak;
>  u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
>  				   const struct cpumask *src2) __ksym __weak;
>  u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
> -int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src_=
_sz) __ksym __weak;
> +int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *src, size_t =
src__sz) __ksym __weak;
> =20
>  void bpf_rcu_read_lock(void) __ksym __weak;
>  void bpf_rcu_read_unlock(void) __ksym __weak;
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/=
testing/selftests/bpf/progs/cpumask_failure.c
> index 4c45346fe6f7..74b4cd4bcdbb 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> @@ -231,7 +231,7 @@ int BPF_PROG(test_populate_invalid_destination, struc=
t task_struct *task, u64 cl
>  	u64 bits;
>  	int ret;
> =20
> -	ret =3D bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof(b=
its));
> +	ret =3D bpf_cpumask_populate(invalid, &bits, sizeof(bits));
>  	if (!ret)
>  		err =3D 2;
> =20
> @@ -252,7 +252,7 @@ int BPF_PROG(test_populate_invalid_source, struct tas=
k_struct *task, u64 clone_f
>  		return 0;
>  	}
> =20
> -	ret =3D bpf_cpumask_populate((struct cpumask *)local, garbage, 8);
> +	ret =3D bpf_cpumask_populate(local, garbage, 8);
>  	if (!ret)
>  		err =3D 2;
> =20
> @@ -260,3 +260,22 @@ int BPF_PROG(test_populate_invalid_source, struct ta=
sk_struct *task, u64 clone_f
> =20
>  	return 0;
>  }
> +
> +SEC("tp_btf/task_newtask")
> +__failure __msg("expected pointer to STRUCT bpf_cpumask but R1 has a poi=
nter to STRUCT cpumask")
> +int BPF_PROG(test_populate_borrowed_destination, struct task_struct *tas=
k, u64 clone_flags)
> +{
> +	u64 bits;
> +	int ret;
> +
> +	/*
> +	 * task->cpus_ptr is a borrowed, read-only struct cpumask *, not an
> +	 * owned struct bpf_cpumask *. The verifier must reject it as a
> +	 * writable destination for bpf_cpumask_populate().
> +	 */
> +	ret =3D bpf_cpumask_populate((struct bpf_cpumask *)task->cpus_ptr, &bit=
s, sizeof(bits));
> +	if (!ret)
> +		err =3D 2;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/=
testing/selftests/bpf/progs/cpumask_success.c
> index 774706e7b058..36f77b9732d4 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -785,7 +785,7 @@ int BPF_PROG(test_populate_reject_small_mask, struct =
task_struct *task, u64 clon
>  		return 0;
> =20
>  	/* The kfunc should prevent this operation */
> -	ret =3D bpf_cpumask_populate((struct cpumask *)local, &toofewbits, size=
of(toofewbits));
> +	ret =3D bpf_cpumask_populate(local, &toofewbits, sizeof(toofewbits));
>  	if (ret !=3D -EACCES)
>  		err =3D 2;
> =20
> @@ -824,7 +824,7 @@ int BPF_PROG(test_populate_reject_unaligned, struct t=
ask_struct *task, u64 clone
>  	/* Misalign the source array by a byte. */
>  	src =3D &((char *)bits)[1];
> =20
> -	ret =3D bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK_TEST_=
MASKLEN);
> +	ret =3D bpf_cpumask_populate(mask, src, CPUMASK_TEST_MASKLEN);
>  	if (ret !=3D -EINVAL)
>  		err =3D 2;
> =20
> @@ -855,7 +855,7 @@ int BPF_PROG(test_populate, struct task_struct *task,=
 u64 clone_flags)
>  	}
> =20
>  	/* Pass the entire bits array, the kfunc will only copy the valid bits.=
 */
> -	ret =3D bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST=
_MASKLEN);
> +	ret =3D bpf_cpumask_populate(mask, bits, CPUMASK_TEST_MASKLEN);
>  	if (ret) {
>  		err =3D 2;
>  		goto out;

