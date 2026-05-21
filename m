Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D21D5AD4
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336469; cv=none; b=hkWGdtZQgRpZDSygKTkIL7kgoxL+ePPo9HKrodtuIoRJMy3/ku5bUkZwYP0z6G6NxqFHhYvs+d7x+gLZUppRE/XKdS3LUp70fUn1e/BiTibD/UxYGI/oRrjVhcEBhZ6lNtdnOKEcmcIqNTofDKq6+ahnX1+MrX9Z76IBtNtvfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336469; c=relaxed/simple;
	bh=fBEBu93b5jczK6qq9CsUWP0pGZF6IcTC/U317pLv/p0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DagcV8wFkUDj2TjHcL8xtmUbM0v9TSVElKf3Ww/HNKKL45xXN+OdN1qpZGNw9NonVFT5HzXdj4FXPl8DK8Um9s/OfEKyG5tHfxZN9WZWpqBh59H9AYfB6HrwrvtG8J+/AxCljkYcu6JVKa8mbd52RpogenUYNZ3u11WgoWXmMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KgMt24HA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KgMt24HA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82faf871346so4392088b3a.0
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 21:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336466; x=1779941266; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2hkMG41D7UumAODedFGWVazHZhYrfBwUFGTzkSTLig=;
        b=KgMt24HAS1IOxVqC4Anrblyz/fMYqboZ4qntalSASlqkKhf+7KGkgcBdT8aiBuFknc
         XSaBa4Lq2zlGcsIax6rf7U6HlUCQ03nZtvFrevFhNtsDrB/G1rTcRyBpZ7JSuAFl4YM2
         GeUfsEyzlOR2Lj96K2po89r20QWfDxONN/kmFKCnjPL/X7ChAsu7iTxLGJQxMfm4SHcQ
         V1vCHup0SQZYKJV3p8g0bbNQBkpM6fppVCc//SC7xVcGcN/POJ3MdRnA821PW+nhP4+D
         ukXPXm9sMpqwa93xT/PksJtDWbTvM1KaOkaagzQ8kvrCOvemjRVvPHOl3/HfmY3oVBNm
         v+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336466; x=1779941266;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2hkMG41D7UumAODedFGWVazHZhYrfBwUFGTzkSTLig=;
        b=INUcdWuUDgei7zYa8HRCw4O4o4T7iWigp3jwp/NHVE7T52xr8lNILpnhU8bnzP+S7p
         RUXJBSJbJILfMb0vnyNnt1OXdTWKVjZarTb6Cko2C06lfDjIBf/gmEk7UuxTmtu0RpAX
         EKlKM0mebtem56AKnYFWr9oQmsBpiBKYv0oyJ27GITJOxcv28wy08qJx0dAuF0UqeqF6
         +ifKUDChi7Sd+cWFFayfdgYP10iIks7+px6Q9+asp331V2bvUf47DX54oIg51gcB6t3v
         gn/EYrL7gUnwSaX9d1BqGJpPfI4ey6mvKRKFmo2MmZvl0zA/5TJLeS5UMU1EoKz1W9Zl
         Txqg==
X-Forwarded-Encrypted: i=1; AFNElJ+gvl+E29rMSfG6rxHN+0pI8q8IDkj0enWadhL5AaKnOU+RhH+tCqCrn2UQTXsJa+pb7/a7+HSNx7Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3XhX/8vL/NWIRdGcgbCBkispq1tAVIUAt8vBkqAksHglS1zc3
	s71+X3cEo6C/DaOBp/CWRIsHcrkozuL3WRZpwL8dLrnZ9s5ByydyskhGs4BKVV0Sm64=
X-Gm-Gg: Acq92OEvv4xoQ4aK/WopuZ0n1VQ8juoNbs7i9mtLu9tcsVktSFFjNusFiC/CVj8ZOn3
	LUZrnSXO06wfaFptwNuRtFHyDI+E5iQPDySeAU7OGZtqW394hc0dcJBdmZW6yY2F0IoxuIIpujB
	4EnMM4vLNte7gp1zwh9ytfelOU/t1nZ/PG8x8XxcTB3obXmol0T1EWWLnESPQ8ZxD+nfUvZP6I5
	P5soP73yui4k7d9waxS3/8e4c/vjIyxt7YfIoDkztkqyRdhH9A2v5T2ndxqZ77ZC4OALGmGBX8q
	03DkNvJvAmlaGc+t/33/i1KWqBFefEJswXbK4M0p1b4kj/d9qU/ArJtvk0dsHHeDD72m9hMlKbt
	MZ6bIYsdxcDhJtTNfzVrWfbkCM7upO0J942zBzxINkQ9s6aVA70r3wiwhIoMD6qheGZnSWTRgNJ
	nWhv8EqW6gCK5ww8D+gy3+c7nv8xopAFab1kg=
X-Received: by 2002:a05:6a00:4c8c:b0:83f:250d:59c with SMTP id d2e1a72fcca58-8414ae6e912mr1347583b3a.39.1779336465527;
        Wed, 20 May 2026 21:07:45 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cd19sm22757564b3a.54.2026.05.20.21.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:07:44 -0400
Message-Id: <DIO24V5XSTSW.2PW1QDEHN0T3M@etsalapatis.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] bpf: Add bpf_struct_ops_for_each_prog()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-5-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-5-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> Add a helper that walks the member progs of the struct_ops map
> containing a given @kdata vmtable. struct_ops ->reg() callbacks (and
> similar) sometimes need to inspect the loaded BPF programs, e.g. to
> discover maps they reference via prog->aux->used_maps.
>
> The implementation mirrors bpf_struct_ops_id(): container_of @kdata
> to recover the bpf_struct_ops_map, then iterate st_map->links[i]->prog
> for i in [0, funcs_cnt). Same access pattern, no new locking - by the
> time ->reg() fires st_map is fully populated and stable.
>
> A sched_ext follow-up walks the member progs of a cid-form scheduler's
> struct_ops map, reads prog->aux->arena directly, and requires all member
> progs to reference exactly one arena, without requiring the BPF program
> to call a registration kfunc.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h         |  3 +++
>  kernel/bpf/bpf_struct_ops.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 64968ca6db51..5b99d786e98c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2129,6 +2129,9 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog=
, struct bpf_map *map);
>  void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
>  void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
>  u32 bpf_struct_ops_id(const void *kdata);
> +int bpf_struct_ops_for_each_prog(const void *kdata,
> +				 int (*cb)(struct bpf_prog *prog, void *data),
> +				 void *data);
> =20
>  #ifdef CONFIG_NET
>  /* Define it here to avoid the use of forward declaration */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 05b366b821c3..16aec18ed31b 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1203,6 +1203,42 @@ u32 bpf_struct_ops_id(const void *kdata)
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
> =20
> +/**
> + * bpf_struct_ops_for_each_prog - Invoke @cb for each member prog
> + * @kdata: kernel-side struct_ops vmtable (the @kdata arg to ->reg/->upd=
ate/->unreg)
> + * @cb: callback invoked once per member prog; non-zero return stops ite=
ration
> + * @data: opaque argument passed to @cb
> + *
> + * Walks the struct_ops member progs registered on the map containing @k=
data.
> + * Intended for use from struct_ops ->reg() callbacks (and similar) that=
 need to
> + * inspect the loaded BPF programs (for example to discover maps they re=
ference
> + * via @prog->aux->used_maps).
> + *
> + * Return 0 if iteration completed, otherwise the first non-zero @cb ret=
urn.
> + */
> +int bpf_struct_ops_for_each_prog(const void *kdata,
> +				 int (*cb)(struct bpf_prog *prog, void *data),
> +				 void *data)
> +{
> +	struct bpf_struct_ops_value *kvalue;
> +	struct bpf_struct_ops_map *st_map;
> +	u32 i;
> +	int ret;
> +
> +	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
> +	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> +
> +	for (i =3D 0; i < st_map->funcs_cnt; i++) {
> +		if (!st_map->links[i])
> +			continue;
> +		ret =3D cb(st_map->links[i]->prog, data);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> +
>  static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;

