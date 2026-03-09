Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEE39B48D
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074204; cv=none; b=kS1b4wBKDY3j5C8TQ31rrYrLhimRW8/NoiLk6jjKVNTcRdKwCWbEWHKJFH3fUuv2LIQguOEDS3nyF8gb+xNhjFe3jEhpxsMMqzdIXfW26fw178Hn7sXv183n66nmB/YzqMXzyuw18iDT5IGMGv8LQmnNiZ7QOxeTRxUcbP5ixwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074204; c=relaxed/simple;
	bh=/UKuZLPM9R8s9H5F0r9xIwsuvuUJXtRALCla8IQDVvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lxoBPxDmfOaHOJJ/9b9u1eN0pn+xHCN05JLjGUyF/YAdQ240eKPe6Z+Yj23UNwJ6KLtWvprb19bl/kFNMOVGeIOkPrSjJJrf1Cbt2Y3A/dIpX7I89ua5U+lRegh3V6jHhn5ATc1qOsTKz/kvd6SvoRzJZEAODtn1PN3gEPxs/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BxaQMezX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BxaQMezX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509061dab77so22723941cf.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773074202; x=1773679002; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXt2YirIQL3+wm3ogVH+SsSHj0oOD4TC2QgB43xa3+U=;
        b=BxaQMezXZKhWqzdUfEcACqnBJtpTB/tmX1XGUtmI+zQF3NMqa5kDHYMVa4NCJ6BjBn
         b3Pz5qCfmrOLW+ZKPx7aTkTCvkQvPqW5aWsUjha8mhk7MJL8IX8K4Uft83vlt7F1RAi8
         ljyiTjiD2uKM+Iu4ZCGawvSNJ45v1iQy7W4cEfQH7BokEizUMiFQQO1UmW2s6pM2O4MQ
         qZGJpBOGuFvDSlosWrLZEyPxkC5lpQcnUqoJgVnJlFTnnLhjdAik+Z+Zk2Fm2lR9TYpq
         YANnh6I2w/f/QK+4g/ICT4ev01nKAdbxUqUDs0i7qF9UYCCO5Qq1G24N0AaWLPJnC8wH
         nw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074202; x=1773679002;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXt2YirIQL3+wm3ogVH+SsSHj0oOD4TC2QgB43xa3+U=;
        b=Btqm/cG4o45Q7noB+8JWKYNFod3SKTN4eLad3+m0hbT0z7f8mzhuG2ntTAB71TbnAK
         PgT276xifrjFXqcL4fUx2lq52QeLiwA4khLdCSQcl+0PBLovg9wBJgjMbveQcJXRkNFT
         GHhmb28Amq49Iao/dB4lVvSz4r02iXPUscaKT5WA88xJbozoDIovh6+K28iIhYwybG4g
         +qtiY7qfahUVH+KzWUNVx8djfXkgbViyBR7vTqCvL54pL9IxBkSJatHN+63XlCIua+uV
         MW8BOPTOs7TIZ1rPdi6+pt+5gElFHi72bJFKc3EubPm65huktf2rjXWyOjfv6isMUflM
         T+KA==
X-Gm-Message-State: AOJu0Yy2zvF6Ar2fcDj5OLCB0rArz9BcWAvzIza2OsMBvdfve7LF3dk8
	cfyFv0O7alZhDMBBczLEFAO0VOw9SFuGXr+hKYECjUzLkqv3H1uNwGcOvf8QnoeDjuY=
X-Gm-Gg: ATEYQzzkE95/1qEpPtfBaoSKRVtuRR+cUYRUghzU6H7ILxbMqmtft8EXshudRaM8jGQ
	WSSo/Qe4L2FTYCDhMFKJtViz2waq/zTP5ld0Nuv6cFI5n1sxrgsvwQO6aOHip4fnoQ7tCDSkSLn
	53VCz/pdLzunpED5lS+6Aww0t5LHrakZT5sH9kiU3s7WIZeN9a4cNSICH4zP160OyBD8t/FWRzg
	Mp2ct7zPixizg1/5MukAAIfIp+wWfJ69WN7qVfbFjfbIeorxY3r460c4K4sdCgvBWFH5xfMFMrs
	Jt1R7eWvP5sGaJhBrgaTO+SwkhnMa+LFD6HQXGPSjGr8kQK8p6lboluCuTvSQjL4srxPat5QKNM
	MEYA2xVgtignatnp9FTr8/mssTMu0+6+wao5jxQC+P/0o2h2ymYKa4PWvSEV0rKUWF10VLrWPmP
	ZWC88sbvtLgclCzChqv7GdZ74=
X-Received: by 2002:a05:622a:1915:b0:509:cbc:1277 with SMTP id d75a77b69052e-5090cbc141fmr88146831cf.41.1773074201737;
        Mon, 09 Mar 2026 09:36:41 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a3a9a2sm1396576d6.15.2026.03.09.09.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 12:36:40 -0400
Message-Id: <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
Subject: Re: [PATCH v2 2/2] tools/sched_ext: scx_sdt: Fix BPF verifier
 rejection on older LLVMs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Zhao Mengmeng" <zhaomzhao@126.com>, <tj@kernel.org>,
 <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <llvm@lists.linux.dev>, <zhaomengmeng@kylinos.cn>
X-Mailer: aerc 0.20.1
References: <20260309022847.106150-1-zhaomzhao@126.com>
 <20260309022847.106150-3-zhaomzhao@126.com>
In-Reply-To: <20260309022847.106150-3-zhaomzhao@126.com>

On Sun Mar 8, 2026 at 10:28 PM EDT, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>
> Under Clang 17/18, when running scx_sdt scheduler, it fails with:
>
> libbpf: prog 'sdt_init_task': BPF program load failed: -EACCES
> libbpf: prog 'sdt_init_task': -- BEGIN PROG LOAD LOG --
> ...
> ; desc =3D desc_find_empty(alloc->root, &idx); @ scx_sdt.bpf.c:479
> 43: (79) r8 =3D *(u64 *)(r6 +32)        ; frame1: R6=3Dmap_value(map=3Dsc=
x_sdt.bss,ks=3D4,vs=3D200,off=3D120) R8=3Dscalar()
> ; for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) { @ =
scx_sdt.bpf.c:407
> 44: (e5) may_goto pc+51
> ; idx |=3D pos; @ scx_sdt.bpf.c:418
> 96: (bf) r7 =3D r2                      ; frame1: R2=3D0 R7=3D0
> 97: (bf) r1 =3D r10                     ; frame1: R1=3Dfp0 R10=3Dfp0
> ;  @ scx_sdt.bpf.c:0
> 98: (07) r1 +=3D -56                    ; frame1: R1=3Dfp-56
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 99: (b4) w2 =3D 0                       ; frame1: R2=3D0
> 100: (b4) w3 =3D 3                      ; frame1: R3=3D3
> 101: (85) call bpf_iter_num_new#82234         ; frame1: R0=3Dscalar() fp-=
56=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0)
> 102: (18) r9 =3D 0x1ffffffffffffff8     ; frame1: R9=3D0x1ffffffffffffff8
> 104: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> ;  @ scx_sdt.bpf.c:0
> 105: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 106: (85) call bpf_iter_num_next#82235        ; frame1: R0=3D0 fp-56=3Dit=
er_num(ref_id=3D2,state=3Ddrained,depth=3D0)
> 107: (15) if r0 =3D=3D 0x0 goto pc+29     ; frame1: R0=3D0
> ; if (tmp->nr_free > 0) @ scx_sdt.bpf.c:456
> 137: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> 138: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> 139: (85) call bpf_iter_num_destroy#82232     ; frame1:
> 140: (b7) r9 =3D 0                      ; frame1: R9=3D0
> ; if (unlikely(desc =3D=3D NULL)) { @ scx_sdt.bpf.c:480
> 141: (15) if r8 =3D=3D 0x0 goto pc+15     ; frame1: R8=3Dscalar(umin=3D1)
> ; chunk =3D desc->chunk; @ scx_sdt.bpf.c:485
> 142: (79) r4 =3D *(u64 *)(r8 +72)
> R8 invalid mem access 'scalar'
>
> The reason is these older compilers lacks native support for
> __BPF_FEATURE_ADDR_SPACE_CAST, __arena macro is defined as empty.
>
> Fix it by adding cast_kern when dereferencing variables with __arena tag.
>

I am not sure if we want to support older Clang versions at this point.
This issue is fixed for Clang 19, and adding the macros back in makes it=20
confusing for those who use the code as a starting point. And while
it would be nice to support older Clang versions, we already don't
handle Clang 15/16 that don't have arena support. So it's not
unreasonable if we say Clang 17/18 are also incompatible with this
example.

On the other hand, maybe the extra compatibility is worth re-adding=20
cast_kern/cast_user to the code. I am slightly in favor of keeping it
as-is to avoid churn, but can easily see why we'd go the other way.

@htejun WDYT?

> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  tools/sched_ext/scx_sdt.bpf.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.=
c
> index 31b09958e8d5..caacc55bd7a5 100644
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -148,6 +148,7 @@ static sdt_desc_t *scx_alloc_chunk(void)
> =20
>  	out =3D desc;
> =20
> +	cast_kern(desc);
>  	desc->nr_free =3D SDT_TASK_ENTS_PER_CHUNK;
>  	desc->chunk =3D chunk;
> =20
> @@ -244,6 +245,7 @@ int mark_nodes_avail(sdt_desc_t *lv_desc[SDT_TASK_LEV=
ELS], __u64 lv_pos[SDT_TASK
>  		/* Only propagate upwards if we are the parent's only free chunk. */
>  		desc =3D lv_desc[level];
> =20
> +		cast_kern(desc);
>  		ret =3D set_idx_state(desc, lv_pos[level], false);
>  		if (unlikely(ret !=3D 0))
>  			return ret;
> @@ -298,20 +300,26 @@ int scx_alloc_free_idx(struct scx_allocator *alloc,=
 __u64 idx)
>  		if (level =3D=3D SDT_TASK_LEVELS - 1)
>  			break;
> =20
> +		cast_kern(desc);
>  		chunk =3D desc->chunk;
> =20
> +		cast_kern(chunk);
>  		desc_children =3D (sdt_desc_t * __arena *)chunk->descs;
> +		cast_kern(desc_children);
>  		desc =3D desc_children[pos];
> =20
>  		if (unlikely(!desc))
>  			return -EINVAL;
>  	}
> =20
> +	cast_kern(desc);
>  	chunk =3D desc->chunk;
> =20
>  	pos =3D idx & mask;
> +	cast_kern(chunk);
>  	data =3D chunk->data[pos];
>  	if (likely(data)) {
> +		cast_kern(data);
>  		*data =3D (struct sdt_data) {
>  			.tid.genn =3D data->tid.genn + 1,
>  		};
> @@ -378,6 +386,7 @@ __u64 chunk_find_empty(sdt_desc_t __arg_arena *desc)
>  	__u64 freeslots;
>  	__u64 i;
> =20
> +	cast_kern(desc);
>  	for (i =3D 0; i < SDT_TASK_CHUNK_BITMAP_U64S; i++) {
>  		freeslots =3D ~desc->allocated[i];
>  		if (freeslots =3D=3D (__u64)0)
> @@ -426,9 +435,12 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc=
, __u64 *idxp)
>  			break;
> =20
>  		/* Allocate an internal node if necessary. */
> +		cast_kern(desc);
>  		chunk =3D desc->chunk;
> +		cast_kern(chunk);
>  		desc_children =3D (sdt_desc_t * __arena *)chunk->descs;
> =20
> +		cast_kern(desc_children);
>  		desc =3D desc_children[pos];
>  		if (!desc) {
>  			desc =3D scx_alloc_chunk();
> @@ -448,6 +460,7 @@ static sdt_desc_t * desc_find_empty(sdt_desc_t *desc,=
 __u64 *idxp)
>  		level =3D SDT_TASK_LEVELS - 1 - u;
>  		tmp =3D lv_desc[level];
> =20
> +		cast_kern(tmp);
>  		ret =3D set_idx_state(tmp, lv_pos[level], true);
>  		if (ret !=3D 0)
>  			break;
> @@ -482,10 +495,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc=
)
>  		return NULL;
>  	}
> =20
> +	cast_kern(desc);
>  	chunk =3D desc->chunk;
> =20
>  	/* Populate the leaf node if necessary. */
>  	pos =3D idx & (SDT_TASK_ENTS_PER_CHUNK - 1);
> +	cast_kern(chunk);
>  	data =3D chunk->data[pos];
>  	if (!data) {
>  		data =3D scx_alloc_from_pool(&alloc->pool);
> @@ -503,10 +518,12 @@ void __arena *scx_alloc(struct scx_allocator *alloc=
)
>  	alloc_stats.alloc_ops +=3D 1;
>  	alloc_stats.active_allocs +=3D 1;
> =20
> +	cast_kern(data);
>  	data->tid.idx =3D idx;
> =20
>  	bpf_spin_unlock(&alloc_lock);
> =20
> +	cast_user(data);
>  	return data;
>  }
> =20
> @@ -544,9 +561,10 @@ void __arena *scx_task_alloc(struct task_struct *p)
>  	if (unlikely(!data))
>  		return NULL;
> =20
> +	mval->data =3D data;
> +	cast_kern(data);
>  	mval->tid =3D data->tid;
>  	mval->tptr =3D (__u64) p;
> -	mval->data =3D data;
> =20
>  	return (void __arena *)data->payload;
>  }

