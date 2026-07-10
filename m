Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8293B71A9
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726935; cv=none; b=NgpxGVci7ExCdZFlkRyKkKqXMeGvuS+UefYIQCtwtzRQrWhw1lkQ3yCAQyF0anE0zn/4L9ELdkC6svUDKbujhJLT4DQ71LVyCeCQr8H8Esoo0mF9mWZUcltspx8EK/NV7Y7h8zB1L7QbI8V21JnFSjMCmSJ2VSd+NAU4fBCJmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726935; c=relaxed/simple;
	bh=E9/9TuyHz+vhRwqTt3wnqGuUknTfuECvyapAS5S/naM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rJnNEzZxVlFYq31NDYVPmwCYGZYZ8Tt5Q/dHCWj3R5Ov4aV1xnrKfuytdL0a5pBQw9a8CgXFV+gI8rU+nh0HTqub5J9VY3UCFzUMh1QTO4/vwtxj1JKyQLd2Zo/eWDyGPbKkQtl58DJ8LFk+8ddhuk0niSjWTSpj1QU2MboQkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ozFSNgee; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ozFSNgee"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c89636920a3so815169a12.1
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783726929; x=1784331729; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R4FB1H/ZXfd+gXZ1WSaZrp9C6WUDHWyhV1zt1MSL4AU=;
        b=ozFSNgeepNQBeYrViOb36eQ0uC/tWQvnSPnNwGYVuHu/ficTR/4P1zRo/cPLqubjq6
         mMzDqmivwm8kLQgraMOtKyOpwJ33aWHkqdG/lpnloqJ4RHcBD75hSW9f7ExpCdocxbPm
         eTm3eslGD6eVzfnRtn3jnG3ZxF+41QTEEns0rqir6RIaL1J1bo8c4J/XhtK8g1SIAsUg
         mc6XpRErAFm97NisupGSRjqGJKYXVxngAnpQZx2G4wueGYqTulCGVzYIXPtptw8Dc9/D
         2mqbPZ8imT4RsTIU9q0kSrnLFeE3mbv1jvdrJ2hOvzAIx6mpxL6Owc4ZEd8+DdMh0mNc
         8HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783726929; x=1784331729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4FB1H/ZXfd+gXZ1WSaZrp9C6WUDHWyhV1zt1MSL4AU=;
        b=mHNDkSrEDwbWt2DsnwEK6zD33BMW2WSisIqVeh9rQSswjEGML2kl/QxvsQBseBx751
         JvmfoPr48TM7BL44EhTpBJvVW0yYUnPcX+egItxfb98vnrlsrZkK3QdrXFUZPnWEd23V
         dACyyAJE9DGx5MqjJGPVjPWxn+dJfRviD3reIdMMVWvJYzbk5hIs2jn4TsMrRYQGD7Aj
         7ngnul2x/HD4CKhwB5RZoxC54RhXtCWFc46WRnqE4ewRx1ow77aHRaV76Oxc2fVuhoQw
         zpSK8D8oLaZWZ9j5W6ixSOETpXqn6116ONkpdnsnWM3DzEFwnUCA9ob1wN4jF+YYNreo
         K34A==
X-Forwarded-Encrypted: i=1; AHgh+Rou3X54H+6TNmJr0mqj/CdB5iGyOhgSaoXApAwV1TivqR0vJuGFSXt9ZCzqkcnuFos5flFc1Kmq05o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwcGBFxOhXODpcCkQqYU3JQ8VFSBkc/We2b/L0pCuP43yb1JUTE
	xaXf3zIjlfpDANrEMHSSQPycPWjTVaWJkbPf2KtmrPqCmAhny7XLxIWAE3uP0+TRD6I=
X-Gm-Gg: AfdE7ck9+3SMpR8BMPJJ2ayrzm8fTYjD9aYwfVk4n2CGVgu16AFswKX9/EL/IpoyELS
	6NF1hsofHakFCCBAw4jUc87/Ameo1lVt/EtSTK2pK5tC+4afrI3qJu5ghzm9l6hrbDjAFe5zDEW
	mXCPYME7lBVZLmRcOCeC5d0XlqU17c7EwZCN3bU/t0aiHKVR7sddEYqU7AK0dbtP7YDx6EcptL+
	eEkLFo5MPw9eAUsXYtDUKH4Nzh/wcn+twGzgCoEgFxdH/+W9ZJWh7UK6wnOpyF8lSz/aEpw95pU
	PosCeTkGxJY5ckkCPivwxm0c8BSO/lSKtLAX0xvM0/BnJGHCUs4eCdORoDgcFsynFEagxHvoJMt
	CBaLTNyVfBBE//wrdQ1YMKZvnM3J+H04vDpotFNOfliMlOG1/HVcoQNVWfN1m2YEGszS/vOsehR
	4I/vae
X-Received: by 2002:a05:6a21:4a98:b0:3c1:657:4c95 with SMTP id adf61e73a8af0-3c11077660fmr940669637.15.1783726928529;
        Fri, 10 Jul 2026 16:42:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::6185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm14764211eec.5.2026.07.10.16.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:42:06 -0400
Message-Id: <DJVAF9H7DVKE.339TIKL2QFYF6@etsalapatis.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-2-main.kalliope@gmail.com>

On Thu Jul 9, 2026 at 2:27 PM EDT, Nicholas Dudar wrote:
> bpf_cpumask_populate() writes to its destination with bitmap_copy(), but
> the destination is typed as struct cpumask *. That allows the verifier to
> accept borrowed cpumask pointers returned by read-only kfuncs, such as
> scx_bpf_get_online_cpumask(), as a writable destination.
>
> Make the destination a struct bpf_cpumask * so populate follows the same
> ownership rule as the other mutating cpumask kfuncs. Query kfuncs continu=
e
> to accept const struct cpumask * inputs.
>
> Fixes: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/cpumask.c                     | 6 +++---
>  tools/sched_ext/include/scx/compat.bpf.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index b8c805b4b06a..1336a4efa755 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -449,12 +449,12 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpu=
mask *cpumask)
>   * @src__sz: Length of the BPF memory region in bytes.
>   *
>   * Return:
> - * * 0 if the struct cpumask * instance was populated successfully.
> + * * 0 if the struct bpf_cpumask * instance was populated successfully.
>   * * -EACCES if the memory region is too small to populate the cpumask.
>   * * -EINVAL if the memory region is not aligned to the size of a long
>   *   and the architecture does not support efficient unaligned accesses.
>   */
> -__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src,=
 size_t src__sz)
> +__bpf_kfunc int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *=
src, size_t src__sz)
>  {
>  	unsigned long source =3D (unsigned long)src;
> =20
> @@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask *=
cpumask, void *src, size_t
>  		!IS_ALIGNED(source, sizeof(long)))
>  		return -EINVAL;
> =20
> -	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
> +	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
> =20
>  	return 0;
>  }
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 87f15f296234..3f74d522f7e7 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_i=
ter_scx_dsq *it__iter, st
>   *
>   * Compat macro will be dropped on v6.19 release.
>   */
> -int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz)=
 __ksym __weak;
> +int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src_=
_sz) __ksym __weak;
> =20
>  #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
>  	(bpf_ksym_exists(bpf_cpumask_populate) ?			\

