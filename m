Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06499360EDA
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333443; cv=none; b=qNGj3KqJILL7WuYeWG/4lFxJ6b4SyUp92WGloyKzWDPcDy9tKAK2G+WYhWjcSYZMY3RMnG62iozmnWUfXOSYA7LVDosMlDvnoCbwN/fpg2kWkQ6wpV+wsNcCDYeyESw1qs0xW9FNUjoVE4XyykkGkG4WgbUmJ+J5sexOpIkkwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333443; c=relaxed/simple;
	bh=ny4F686XU3gQ2H+vMFM/I+B0c5kC47mbwkkPWhSTfgM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=M+gkut6g4+dR7wt4FrLfivO2j0tRL+jww8YqHtFSvm1We4ReoptghE4ivBn/tb5ryK25Bz/X3WKbnXN/PbO0zE/077luVOArKuej7DuaTnea71MX5Er6eiBMAL+gkEe6/CP9xfKiqotNH6RHYpumprXD2kYxSohv2fJ6roPv7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ylN6K7jd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ylN6K7jd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso2849809a91.1
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779333441; x=1779938241; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnZgEvyl5JzulXJ71OevVX7wYBcNSF1YrTlDeDtAzPQ=;
        b=ylN6K7jd4xJcXzobwmxsu3MB2hiXHIIK1a2/fhD8v/p0lfndM6nHVQyxKeNpRSF+Wj
         9RmTUsc0HCgcYHRdRaRMk0Yop9miRIgfTTDI+qWtn5mfyzCd2NbXOWKk45eW3yYl/hes
         pDTXAi+LPBjWR7Hc+3pgWV/S7Dkk4rf6D0GDdx6wW7ilL5fuYBCDW4Ya3VtEIy3QFuom
         scoROhBWirzz3m+zCSfUvTtIDVNjwVYAyRUTGYGP7lmtCv6egrxnPXRJADH19033vVZQ
         H5SHLynvIfNvQp8PBqzFpaqZSiXEWRxHcEXIiOAwJfg1FNvOthtoNxVkzDxNhLas75Qh
         zPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333441; x=1779938241;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnZgEvyl5JzulXJ71OevVX7wYBcNSF1YrTlDeDtAzPQ=;
        b=Y0ZTaXFjTKMZRmtPsWYI9Qx/PuYRcJ7gMSUSHRroPn54O6juVnIvBUi9cE5mucHHxi
         Xm0TvOqbjUBYH7zzrnRg9UOfKTKF7OiCzDG/L+4DJB9DwKQYzKLu3CNz6VUr6g1esAR2
         bmKp/s8A8RLDs2niIhseHs3ajtlE7FbwB4HJv8ZjEbkzgbVgrm6gn+6ovR5aE/kx2E2j
         80EabJTdU0bn8xGmT2nVxIrvCo2Thi/h4uAzITa/z5Cs8GXA33r+0CmTIlnDrBL5TCbb
         idS8wcyS+O7rrm230ysOTJx1YeFPQ/4hr4+v4gpTSlpK/DyPaSLh6TzGccCtWnvAfcwk
         JwHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Mg3xEWwjJ7Tvo3cTklwqjSGcvTLSJ36eMgWFw9kFCCRFAwCii95pl+cz7L6YFXwxrD787m77/N64=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8/J41m3t0vwaacr1IlbzTnYyeCRpCJme4vHmDs5AbIJALz+k/
	rVxnae5ILWywieLidCZGJt80jWAFXc5EzcP3iO5e5lSH0Gk+GdlCAau3nBsSST0XKh8=
X-Gm-Gg: Acq92OGuKax82j5z8RQAqozqWxRbQMF8Urf+fDp2yHvJgy6DmUNfhyJWb+tDotAz7hX
	pnI6QiBP3S5p90AYYU4z57MvW/TA4LjrqD+IAkrHMlYlr7ylW32nM86xI1cLwXg5MkfLPI0ow5d
	wYzNV9+bw3JM2Pt3vVDdR0ZA+0rhB8b3L9zmW9KDMOxc+pI6qS5OM/unqLbFYH9vWXeVe8lx1eU
	rLQWfuqKfysm1AJZxzoB7IvPd6j3mktCFuu6DcsAjjeuLEfTnGFW3oz07YmRFYxGOdEBs8H3poQ
	BoTuKP1RFYBHxkirdoH5jkIRHOxvUnVotNNPuZZ9EhjJaXZJFf+1Ptwv+Fq4sPlmuUr8+n9JCIe
	IPEAoL2YLKFIcmdm7dW63Geb4nCCFw5IaZ3T10vnVLvGGcpA5rWBTQ7yrDqAOp5WCCQZ1B2dVo6
	6sa6A0GTKVWUj8AAEKh6vCYiAH
X-Received: by 2002:a17:90b:1fc3:b0:366:16d1:6a26 with SMTP id 98e67ed59e1d1-36a45139004mr1096386a91.5.1779333441193;
        Wed, 20 May 2026 20:17:21 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a4560779csm222458a91.1.2026.05.20.20.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 20:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 23:17:20 -0400
Message-Id: <DIO129TJQ1F9.20NON5EPGLHRO@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] bpf: Add sleepable variant of bpf_arena_alloc_pages
 for kernel callers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-4-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-4-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> The existing kernel-side export of bpf_arena_alloc_pages is _non_sleepabl=
e
> only - it's used by the verifier to inline the kfunc when the call site i=
s
> non-sleepable. There is no sleepable equivalent for kernel callers; the
> kfunc bpf_arena_alloc_pages itself is BPF-only.
>
> sched_ext needs sleepable kernel-side allocs for its arena pool init/grow
> paths. Add bpf_arena_alloc_pages_sleepable() mirroring the _non_sleepable
> wrapper but passing sleepable=3Dtrue to arena_alloc_pages().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h |  8 ++++++++
>  kernel/bpf/arena.c  | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 831996c411cf..64968ca6db51 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -679,6 +679,8 @@ int bpf_dynptr_from_file_sleepable(struct file *file,=
 u32 flags,
>  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign,=
 u32 page_cnt, int node_id,
>  					  u64 flags);
>  void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u3=
2 page_cnt);
> +void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32=
 page_cnt, int node_id,
> +				      u64 flags);
>  #else
>  static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, vo=
id *addr__ign, u32 page_cnt,
>  							int node_id, u64 flags)
> @@ -689,6 +691,12 @@ static inline void *bpf_arena_alloc_pages_non_sleepa=
ble(void *p__map, void *addr
>  static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void=
 *ptr__ign, u32 page_cnt)
>  {
>  }
> +
> +static inline void *bpf_arena_alloc_pages_sleepable(void *p__map, void *=
addr__ign, u32 page_cnt,
> +						    int node_id, u64 flags)
> +{
> +	return NULL;
> +}
>  #endif
> =20
>  extern const struct bpf_map_ops bpf_map_offload_ops;
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 1c0b87ecc817..a811cf6170fa 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -934,6 +934,19 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__m=
ap, void *addr__ign, u32 pag
> =20
>  	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, false);
>  }
> +
> +void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32=
 page_cnt,
> +				      int node_id, u64 flags)
> +{
> +	struct bpf_map *map =3D p__map;
> +	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt)
> +		return NULL;
> +
> +	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, true);
> +}
> +
>  __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 =
page_cnt)
>  {
>  	struct bpf_map *map =3D p__map;

