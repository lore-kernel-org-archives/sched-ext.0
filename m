Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114F282F0B
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337186; cv=none; b=aH5sUZ4YbrK4Jg84+DLR/ug2+QN3XUOcMx1M4JzGqE4CWg0bNBckbDWDvEfKuKgOAQMNm9sHCb9+7UlOXU6ufNshTg4CeD7Tm/AfcaPLxj6She0oEb2y/t86lqy/4IGCp55qeSrmC89iumEG/cSmi2DSk8t7XN4YfN0KuiD1QM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337186; c=relaxed/simple;
	bh=iJGPAjxxIadOYSrwMzUWNw4STC1X9i/wJDX9NHr9GDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=O689+jIa4lrnbppdeuAlVzV7an/VV1caS6qEavhgOuY8MPMt7V8/+AlHE7bADj4QsgoSrChu+FxhCYE30iwQg4DTbcSBZRWQhGoakUsB2NS+TkAU2TZSY8VyF4flVGgYc9yH3XlpSo0yHhMuS3gv4RADxtjepg24i0xK0HpVKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s92FIAYj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s92FIAYj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc85eda6b6so27348845ad.1
        for <sched-ext@lists.linux.dev>; Wed, 20 May 2026 21:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779337172; x=1779941972; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et0bGEjjWdmJXg1QKS6BT27sCw0OJSCkjTf2JeHVHR8=;
        b=s92FIAYjxH/kFcSY4Ka3Ju4q5rgfqxoWwfLKtpF4B8HdT0nihyDzjzV4rInJxw0RP6
         kioD6IxxKchgZSLW9vG8nwuvotycT6aoqL5kMCkr10x2mtigrndqXOFGWRWgnzqWYFIx
         0F0lTzVQu54IgMSJNnknEPN/Xz2inrpza3/L7YPRwrQyLDg/IifK6GL7Lo2PMeUQnKD3
         MMOAuYk/xk0Cs0/6vvhOssSOZkYYWh5ye4reUPSZ4kcy7n2sF2SNoEu1t8mW49bHjSH3
         5oBNWyb4Zfs5TJ76ebx7A1EmJaqMYpi1H46SAq1obnLC14KdSqT/NTAOSCNuToxcMOIo
         vnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779337172; x=1779941972;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Et0bGEjjWdmJXg1QKS6BT27sCw0OJSCkjTf2JeHVHR8=;
        b=GP+f2NybqzO7a0j3W5WDhJ8NuKphOYEVWb89w0Qi/ZhgaFl3bLsIbUiUyrvZuXGHhh
         FcjKZIIrs11MdqgpOf8hMyfjEiK4VipPy5x26o8uyTJi0s1h/xuLXRTrjQT824Ir4EO9
         K/5AT0xp4EtDsNRRH/3t+gKrWUFFhDZhpG7G6t5nHl+Hif2c2k8AvLl+Vfz3i6Xf4AOU
         ZKQ8d+8tT3z6dYx382iZdvvHLVkVSl/iumdw+JdCbgOzscscykCwD6WcA410+iyqLN2h
         q8yLqwfXLRIzffSMgUxNKnu3dgoUvoYDFaB7PXFtzSCNYW3ISryhP5R341eJnDAzVE+O
         rH3g==
X-Forwarded-Encrypted: i=1; AFNElJ/RnGGom8ys8q5mhf7loP8hSjhVdTHleihkNp7K6krLnQHGffZVcKEhFMJazrt4zhdzgHFI0L5V5lM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxN8DZzRTOUchVI6RCVm6OUp56YHMigb28jx8BL2nO55IE6LCe7
	Ub9A25oxhOhSp/6TeVz5yW5Isvw5jq8DekB7eTf51inNorr9WAkWUvL8u2k2q8nqPHE=
X-Gm-Gg: Acq92OHuveV3JBKi6Akzf9mqz4DFJfC/wOIdZuecohJs/suG2CiSVXWqTvbZpHoMbjU
	Vw/fU80Tf59oD1XHLhdl4r9cWfOWu3lVHuSlRo940m/AACjK2lLwi+SXxQq2CpAwd28H9MfFvVD
	TzopY32gjJIsru1uKHCKcT05NV7wqWISjDeU1dg+cbCQ+6LkW9tydrG7btsQZe1jixfkrO9+4wc
	czlkCMXO9zTE5SDbrPfnLwRHobJI9Ni1XVHpgQX+86rNtmSDAlU/NEFfcSg777D555l/+s+gGwS
	ojQAPwwRRZQMvYyz4zWBf4S8435m53nGsCZ86YVm1GuIKxrLspQV7xGF7GNjeJlgP8n3jAjhHrZ
	DQ/MiHd/1GokL39DnQZrVNmCfe7itw65EjCvGG1nyqzT3y5/KwMfNGSNiVLhz6wq52yjGiRLgJR
	NCwcrBkSSQEY0DZxw+3D2vuwQD
X-Received: by 2002:a17:903:1b06:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2bea2f89c83mr11555725ad.0.1779337171498;
        Wed, 20 May 2026 21:19:31 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05fcb3sm243627525ad.26.2026.05.20.21.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 21:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 00:19:30 -0400
Message-Id: <DIO2DVGYRBUN.1QPC47NPPWTZ9@etsalapatis.com>
Subject: Re: [PATCH 8/8] sched_ext: Convert ops.set_cmask() to
 arena-resident cmask
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-9-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-9-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> ops_cid.set_cmask() expects a cmask. The kernel couldn't write into the
> arena, so it translated cpumask -> cmask in kernel memory and passed the
> result as a trusted pointer. The BPF cmask helpers all operate on arena
> cmasks though, so the BPF side had to word-by-word probe-read the kernel
> cmask into an arena cmask via cmask_copy_from_kernel() before any helper
> could touch it. It works, but is clumsy.
>
> With direct kernel-side arena access now in place, build the cmask in the
> arena. The kernel writes to it through the kern_va side of the dual mappi=
ng;
> BPF directly dereferences it via an __arena pointer like any other arena
> struct.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                    | 68 +++++++++++++++++++++++++--
>  kernel/sched/ext_cid.c                | 20 +-------
>  kernel/sched/ext_internal.h           | 10 +++-
>  tools/sched_ext/include/scx/cid.bpf.h | 52 --------------------
>  tools/sched_ext/scx_qmap.bpf.c        |  5 +-
>  5 files changed, 75 insertions(+), 80 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fb91079c1244..94562e3350c6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -621,11 +621,16 @@ static inline void scx_call_op_set_cpumask(struct s=
cx_sched *sch, struct rq *rq,
>  		update_locked_rq(rq);
> =20
>  	if (scx_is_cid_type()) {
> -		struct scx_cmask *cmask =3D this_cpu_ptr(scx_set_cmask_scratch);
> -
> -		lockdep_assert_irqs_disabled();
> -		scx_cpumask_to_cmask(cpumask, cmask);
> -		sch->ops_cid.set_cmask(task, cmask);
> +		struct scx_cmask *kern_va =3D *this_cpu_ptr(sch->set_cmask_scratch);
> +		unsigned long uaddr =3D (unsigned long)kern_va -
> +			bpf_arena_map_kern_vm_start(sch->arena_map);
> +		/*
> +		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
> +		 * holds the rq lock with IRQs disabled, which makes us the sole
> +		 * user of the scratch area.
> +		 */
> +		scx_cpumask_to_cmask(cpumask, kern_va);
> +		sch->ops_cid.set_cmask(task, (struct scx_cmask *)uaddr);
>  	} else {
>  		sch->ops.set_cpumask(task, cpumask);
>  	}
> @@ -4949,6 +4954,48 @@ static const struct attribute_group scx_global_att=
r_group =3D {
>  static void free_pnode(struct scx_sched_pnode *pnode);
>  static void free_exit_info(struct scx_exit_info *ei);
> =20
> +static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
> +{
> +	size_t size =3D struct_size_t(struct scx_cmask, bits,
> +				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
> +	int cpu;
> +
> +	if (!sch->is_cid_type || !sch->arena_pool)
> +		return 0;
> +
> +	sch->set_cmask_scratch =3D alloc_percpu(struct scx_cmask *);
> +	if (!sch->set_cmask_scratch)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_cmask **slot =3D per_cpu_ptr(sch->set_cmask_scratch, cpu);
> +
> +		*slot =3D scx_arena_alloc(sch, size);
> +		if (!*slot)
> +			return -ENOMEM;
> +		scx_cmask_init(*slot, 0, num_possible_cpus());
> +	}
> +	return 0;
> +}
> +
> +static void scx_set_cmask_scratch_free(struct scx_sched *sch)
> +{
> +	size_t size =3D struct_size_t(struct scx_cmask, bits,
> +				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
> +	int cpu;
> +
> +	if (!sch->set_cmask_scratch)
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_cmask **slot =3D per_cpu_ptr(sch->set_cmask_scratch, cpu);
> +
> +		scx_arena_free(sch, *slot, size);
> +	}
> +	free_percpu(sch->set_cmask_scratch);
> +	sch->set_cmask_scratch =3D NULL;
> +}
> +
>  static void scx_sched_free_rcu_work(struct work_struct *work)
>  {
>  	struct rcu_work *rcu_work =3D to_rcu_work(work);
> @@ -5003,6 +5050,7 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
> =20
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  	free_exit_info(sch->exit_info);
> +	scx_set_cmask_scratch_free(sch);
>  	scx_arena_pool_destroy(sch);
>  	if (sch->arena_map)
>  		bpf_map_put(sch->arena_map);
> @@ -7162,6 +7210,12 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	ret =3D scx_set_cmask_scratch_alloc(sch);
> +	if (ret) {
> +		cpus_read_unlock();
> +		goto err_disable;
> +	}
> +
>  	for (i =3D SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
>  		if (((void (**)(void))ops)[i])
>  			set_bit(i, sch->has_op);
> @@ -7484,6 +7538,10 @@ static void scx_sub_enable_workfn(struct kthread_w=
ork *work)
>  	if (ret)
>  		goto err_disable;
> =20
> +	ret =3D scx_set_cmask_scratch_alloc(sch);
> +	if (ret)
> +		goto err_disable;
> +
>  	if (validate_ops(sch, ops))
>  		goto err_disable;
> =20
> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
> index 0c91b951fd33..808c6390da5a 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext_cid.c
> @@ -7,14 +7,6 @@
>   */
>  #include <linux/cacheinfo.h>
> =20
> -/*
> - * Per-cpu scratch cmask used by scx_call_op_set_cpumask() to synthesize=
 a
> - * cmask from a cpumask. Allocated alongside the cid arrays on first ena=
ble
> - * and never freed. Sized to the full cid space. Caller holds rq lock so
> - * this_cpu_ptr is safe.
> - */
> -struct scx_cmask __percpu *scx_set_cmask_scratch;
> -
>  /*
>   * cid tables.
>   *
> @@ -54,8 +46,6 @@ static s32 scx_cid_arrays_alloc(void)
>  	u32 npossible =3D num_possible_cpus();
>  	s16 *cid_to_cpu, *cpu_to_cid;
>  	struct scx_cid_topo *cid_topo;
> -	struct scx_cmask __percpu *set_cmask_scratch;
> -	s32 cpu;
> =20
>  	if (scx_cid_to_cpu_tbl)
>  		return 0;
> @@ -63,25 +53,17 @@ static s32 scx_cid_arrays_alloc(void)
>  	cid_to_cpu =3D kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL)=
;
>  	cpu_to_cid =3D kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL=
);
>  	cid_topo =3D kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
> -	set_cmask_scratch =3D __alloc_percpu(struct_size(set_cmask_scratch, bit=
s,
> -						       SCX_CMASK_NR_WORDS(npossible)),
> -					   sizeof(u64));
> =20
> -	if (!cid_to_cpu || !cpu_to_cid || !cid_topo || !set_cmask_scratch) {
> +	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
>  		kfree(cid_to_cpu);
>  		kfree(cpu_to_cid);
>  		kfree(cid_topo);
> -		free_percpu(set_cmask_scratch);
>  		return -ENOMEM;
>  	}
> =20
>  	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
>  	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
>  	WRITE_ONCE(scx_cid_topo, cid_topo);
> -	for_each_possible_cpu(cpu)
> -		scx_cmask_init(per_cpu_ptr(set_cmask_scratch, cpu),
> -			       0, npossible);
> -	WRITE_ONCE(scx_set_cmask_scratch, set_cmask_scratch);
>  	return 0;
>  }
> =20
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index ff7e882bd67a..9bb65367f510 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1124,6 +1124,14 @@ struct scx_sched {
>  	struct bpf_map		*arena_map;
>  	struct gen_pool		*arena_pool;
> =20
> +	/*
> +	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmas=
k
> +	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va=
;
> +	 * the BPF-arena uaddr handed to BPF is recovered by subtracting the
> +	 * arena's kern_vm_start.
> +	 */
> +	struct scx_cmask * __percpu *set_cmask_scratch;
> +
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
> =20
>  	/*
> @@ -1480,8 +1488,6 @@ enum scx_ops_state {
>  extern struct scx_sched __rcu *scx_root;
>  DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
> =20
> -extern struct scx_cmask __percpu *scx_set_cmask_scratch;
> -
>  /*
>   * True when the currently loaded scheduler hierarchy is cid-form. All s=
cheds
>   * in a hierarchy share one form, so this single key tells callsites whi=
ch
> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/incl=
ude/scx/cid.bpf.h
> index e281c88fa824..70f2a3829af4 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h
> @@ -675,56 +675,4 @@ static __always_inline void cmask_from_cpumask(struc=
t scx_cmask __arena *m,
>  	}
>  }
> =20
> -/**
> - * cmask_copy_from_kernel - probe-read a kernel cmask into an arena cmas=
k
> - * @dst: arena cmask to fill; must have @dst->base =3D=3D 0 and be sized=
 for @src.
> - * @src: kernel-memory cmask (e.g. ops.set_cmask() arg); @src->base must=
 be 0.
> - *
> - * Word-for-word copy; @src and @dst must share base 0 alignment. Trigge=
rs
> - * scx_bpf_error() on probe failure or precondition violation.
> - */
> -static __always_inline void cmask_copy_from_kernel(struct scx_cmask __ar=
ena *dst,
> -						   const struct scx_cmask *src)
> -{
> -	u32 base =3D 0, nr_cids =3D 0, nr_words, wi;
> -
> -	if (dst->base !=3D 0) {
> -		scx_bpf_error("cmask_copy_from_kernel requires dst->base =3D=3D 0");
> -		return;
> -	}
> -
> -	if (bpf_probe_read_kernel(&base, sizeof(base), &src->base)) {
> -		scx_bpf_error("probe-read cmask->base failed");
> -		return;
> -	}
> -	if (base !=3D 0) {
> -		scx_bpf_error("cmask_copy_from_kernel requires src->base =3D=3D 0");
> -		return;
> -	}
> -
> -	if (bpf_probe_read_kernel(&nr_cids, sizeof(nr_cids), &src->nr_cids)) {
> -		scx_bpf_error("probe-read cmask->nr_cids failed");
> -		return;
> -	}
> -
> -	if (nr_cids > dst->nr_cids) {
> -		scx_bpf_error("src cmask nr_cids=3D%u exceeds dst nr_cids=3D%u",
> -			      nr_cids, dst->nr_cids);
> -		return;
> -	}
> -
> -	nr_words =3D CMASK_NR_WORDS(nr_cids);
> -	cmask_zero(dst);
> -	bpf_for(wi, 0, CMASK_MAX_WORDS) {
> -		u64 word =3D 0;
> -		if (wi >=3D nr_words)
> -			break;
> -		if (bpf_probe_read_kernel(&word, sizeof(u64), &src->bits[wi])) {
> -			scx_bpf_error("probe-read cmask->bits[%u] failed", wi);
> -			return;
> -		}
> -		dst->bits[wi] =3D word;
> -	}
> -}
> -
>  #endif /* __SCX_CID_BPF_H */
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 7e77f22674ea..8a2d6a8ebd8e 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -919,14 +919,15 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool=
 idle)
>  }
> =20
>  void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
> -		    const struct scx_cmask *cmask)
> +		    const struct scx_cmask *cmask_in)
>  {
> +	struct scx_cmask __arena *cmask =3D (struct scx_cmask __arena *)(long)c=
mask_in;
>  	task_ctx_t *taskc;
> =20
>  	taskc =3D lookup_task_ctx(p);
>  	if (!taskc)
>  		return;
> -	cmask_copy_from_kernel(&taskc->cpus_allowed, cmask);
> +	cmask_copy(&taskc->cpus_allowed, cmask);
>  }
> =20
>  struct monitor_timer {

