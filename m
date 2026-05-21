Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641A384CF0
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336931; cv=none; b=gkn/fLn9tFAmgwgr6T0BxyYDkvKKLFuu5rbtdaAaJxz4n132RuUNr0jLdjYSbDCHloBxLZLDQ7cB8i4pOmkdgc0mlpTcemhOBm+SXGl/Ejyuh06ErriBJXYT4sougk5VPgH+rjyMBuZv5b8Vgk0DraqqRs7VrRVLW6wzlIrWaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336931; c=relaxed/simple;
	bh=7pJINburNI2s6aoo69b+PuHHTBy7UiG91NoFj7AaxeM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RnNMYG9o/t6mRw8994WrTeEqVierVBnDdiIYCoxU5yovCvwxnQ3JqUuksBxGQ3a1kKBPBGxW6k8VhxgjSYUe09ELVjrA6KAI/zp3Ti+/+QaXcT4fkcW86EOnWdBIX1KAJNqf4uf4L8g13NF1KqrZvBHw9elpwgixjEU5NT9yhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nxCR2Qz1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nxCR2Qz1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bab82d75fdso27661625ad.2
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779336927; x=1779941727; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mx7h0My419s2P7k1BFl0yESBgvzIQJC2piNf13boJc=;
        b=nxCR2Qz1UMK9Ggv5pCME/nxesvoFjSuQMYN7dNnc5TI2YTgaMIIIdXTsFE9Riq3obe
         DeAj+zUE4h60si9NjpOwq2Me0jn+2elfMuMhMud70KMW2cZ9ODn6QyWT2+aGl24ggfh7
         ufDvmoGNYzdzYs4UKuIIons0tZ2Nf+dY2NzukI4mUDfNe8o8fvopblL0p3Z23yAWwtcc
         eyprMiZW4g+btvchc0ew1gf9YO3ind5GjU8NvwIsgIseeOOZDTWd8hZuyeS5024cjzhJ
         8RC+v4L6JIKodQGi83HTTWFurNb3gy45m4FTnuFq2thJHn2owZR52N54rOpsiLJfbyDz
         WIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779336927; x=1779941727;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mx7h0My419s2P7k1BFl0yESBgvzIQJC2piNf13boJc=;
        b=Bg0b46l4MFrP9tZkp+DUWI8OIxKDKph7NVKOxBISUO2t3WtfW3JFMfrIBsnLVzapr/
         ThI8C7KoSJNP3vTkUdDgohG51QTQO/r+eAi28ZyJWbXI/jYxzxdHmqUP8fGxdjcMDf6u
         XkL29pavexPBLwWjniZAYIH0LmoYU6vj6+/Q0Y9iBcRu2StpVv2ZbQncrdF4+Ssu6kEE
         bYXyUaPeD6cChW1Cvi1H8NtqtNajhr27LRucC90vLq2oiz9yiNGONhy2PTVnmKDKiBEE
         RsAnn7jdHD9Xzp/tuc8iLGtnP39GLs/Nb9Rlqym1emNSoqLI3KqwM0slTm10OEm9e0jZ
         DxzA==
X-Forwarded-Encrypted: i=1; AFNElJ9MdIS6fOrC4SMsulRJBdSED5FstfwfQjyzE+qiYv1X0ODCC3qLPLHVaPQ7HxYniYtivFRMZsTzKAg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz1ldshSHbVuz0DnXvFvThNCb3ka52IfA+eW98Mcw4ycNl6yVv
	afzXWtFP6IK+tSQopk2CiV1p1ZHQb66cPyToNkKA2l6bM0BLZM4CYBeCEzkUokocQdI=
X-Gm-Gg: Acq92OHGbW15qtYu+l+LHby9YtFReECjRsNvO/aKc7j5GLFRvUmFUAqLLI5KOh622jk
	35MRj4PLAQA7nz85RJbrfotuYUqWmm0FBfAeeEOoin3mlx6p6nOqIwdX4bM+1hKV5SnwBStbRFI
	wa/RoXNXfDdGAIR4r+lieoh3Pphpk9C9VDiNtFool82Hy8dUlLof/wCCSRacQqGtXECB5YivPo5
	xcofKxFOfsYzbQWPy+H/W1/blwCeL+5l653JYAv0xuH0jDR2o6Wj7lxMi6KlYd2eTQZPYh4hAwX
	fYFGxJsb9J6YTjuu/kzha5d6F0VIuTEBaH+wXyF0UKOZyzUZA+EhSEJuR6WBZ5kW3hENEmeaacD
	vu9m2+rJGLV3aWK7Et4C73ABGCUhnOAbo8c1TgD5d+ZnwlRSWAi9m6F9M/x2W5crd1hB4fz9oHW
	aYFe9E8knQSsZPsTesL5vKdTClEG8iPgBoNhM=
X-Received: by 2002:a17:902:c946:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2bea331d50dmr10441855ad.21.1779336927286;
        Wed, 20 May 2026 21:15:27 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm234841675ad.79.2026.05.20.21.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:15:26 -0400
Message-Id: <DIO2ARBBUOJX.1OJ5RVION2UH1@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
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
Subject: Re: [PATCH 6/8] sched_ext: Require an arena for cid-form schedulers
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-7-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-7-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> Upcoming patches will let the kernel place arena-resident scratch shared
> with the BPF program (e.g. per-CPU set_cmask cmask) so the BPF side can
> dereference it directly via __arena pointers, replacing the current
> cmask_copy_from_kernel() probe-read loop. That requires each cid-form
> scheduler to expose its arena to the kernel. Kernel- side accesses are
> recovered by the per-arena scratch-page mechanism.
>
> bpf_scx_reg_cid() walks the struct_ops member progs via
> bpf_struct_ops_for_each_prog() and reads each prog's arena via
> bpf_prog_arena(). The verifier enforces one arena per program, so each
> member prog contributes at most one arena. All non-NULL contributions mus=
t
> match and at least one member prog must use an arena. The map ref is held=
 on
> scx_sched and dropped on sched destroy. cpu-form schedulers (bpf_scx_reg)
> are unchanged - no arena requirement.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c          | 56 ++++++++++++++++++++++++++++++++++++-
>  kernel/sched/ext_internal.h |  8 ++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9c458552d14f..56f94ac32ba0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5003,6 +5003,8 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
> =20
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  	free_exit_info(sch->exit_info);
> +	if (sch->arena_map)
> +		bpf_map_put(sch->arena_map);
>  	kfree(sch);
>  }
> =20
> @@ -6746,6 +6748,7 @@ struct scx_enable_cmd {
>  		struct sched_ext_ops_cid	*ops_cid;
>  	};
>  	bool			is_cid_type;
> +	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
>  	int			ret;
>  };
> =20
> @@ -6913,6 +6916,15 @@ static struct scx_sched *scx_alloc_and_add_sched(s=
truct scx_enable_cmd *cmd,
>  		return ERR_PTR(ret);
>  	}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> +
> +	/*
> +	 * Consume the arena_map ref bpf_scx_reg_cid() took. Defer to here so
> +	 * earlier failure paths leave cmd->arena_map set and bpf_scx_reg_cid
> +	 * drops the ref. After this point, sch owns the ref and any cleanup
> +	 * runs through scx_sched_free_rcu_work() which puts it.
> +	 */
> +	sch->arena_map =3D cmd->arena_map;
> +	cmd->arena_map =3D NULL;
>  	return sch;
> =20
>  #ifdef CONFIG_EXT_SUB_SCHED
> @@ -7898,11 +7910,53 @@ static int bpf_scx_reg(void *kdata, struct bpf_li=
nk *link)
>  	return scx_enable(&cmd, link);
>  }
> =20
> +struct scx_arena_scan {
> +	struct bpf_map	*arena;
> +	int		err;

Can we skip the int err here...

> +};
> +
> +/*
> + * The verifier enforces one arena per BPF program, so each struct_ops
> + * member prog contributes at most one arena via bpf_prog_arena().
> + * Require all non-NULL contributions to match.
> + */
> +static int scx_arena_scan_prog(struct bpf_prog *prog, void *data)
> +{
> +	struct scx_arena_scan *s =3D data;
> +	struct bpf_map *arena =3D bpf_prog_arena(prog);
> +
> +	if (!arena)
> +		return 0;
> +	if (s->arena && s->arena !=3D arena) {
> +		s->err =3D -EINVAL;

...and just directly return -EINVAL here? bpf_struct_ops_for_each_prog
breaks when we return non-zero so do we need the extra scx_arena_scan
struct?

> +		return 1;
> +	}
> +	s->arena =3D arena;
> +	return 0;
> +}
> +
>  static int bpf_scx_reg_cid(void *kdata, struct bpf_link *link)
>  {
>  	struct scx_enable_cmd cmd =3D { .ops_cid =3D kdata, .is_cid_type =3D tr=
ue };
> +	struct scx_arena_scan scan =3D {};
> +	int ret;
> =20
> -	return scx_enable(&cmd, link);
> +	bpf_struct_ops_for_each_prog(kdata, scx_arena_scan_prog, &scan);
> +	if (scan.err) {
> +		pr_err("sched_ext: cid-form scheduler uses multiple arena maps\n");
> +		return scan.err;
> +	}
> +	if (!scan.arena) {
> +		pr_err("sched_ext: cid-form scheduler must use a BPF arena map\n");
> +		return -EINVAL;
> +	}
> +
> +	bpf_map_inc(scan.arena);
> +	cmd.arena_map =3D scan.arena;
> +	ret =3D scx_enable(&cmd, link);
> +	if (cmd.arena_map)		/* not consumed by scx_alloc_and_add_sched() */
> +		bpf_map_put(cmd.arena_map);
> +	return ret;
>  }
> =20
>  static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 7258aea94b9f..d40cfd29ddaa 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1111,6 +1111,14 @@ struct scx_sched {
>  		struct sched_ext_ops_cid	ops_cid;
>  	};
>  	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
> +
> +	/*
> +	 * Arena map auto-discovered from member progs at struct_ops attach.
> +	 * cid-form schedulers must use exactly one arena across all member
> +	 * progs. NULL on cpu-form.
> +	 */
> +	struct bpf_map		*arena_map;
> +
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
> =20
>  	/*

