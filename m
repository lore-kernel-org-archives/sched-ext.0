Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2B2E8B69;
	Tue,  7 Oct 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855139; cv=none; b=kcppuN/37jr0pxNAnTUWkvpH58S7rR8Pya4EYwTmqBplEHBmjJAgWrRSHxZx5lQd6oVTSjme8DM/5b/PcBBkzkrpbvPAcBy5aMzkFOa3EPVTeDfy+pv/k0kSN2RoUKrOiMhe5yT035zj2pF7+RoQFUl0lNpx1VJ+VPN4E2k3qHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855139; c=relaxed/simple;
	bh=Zsuq54As8jZAKbG54I6CJNr4gHjnPdUWDo6xEueVhmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcQHkGkhxVDgf01qHchoViBDDGzNrtAMyxMOqzPaOm/Y/eLx0QSHuow5nSP3vxYs9v5Dgwo9Yp6rYQufLMKjFhe3NAUGm6KMFbuYEdVPP+9wQ0fJFG14k7I6E9WE6AGBW20N4v9f/Br6HLZI094lyN0h49By/Jm9fhj7647MSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OSdzloNx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OSdzloNx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FssPK5MGKMzI5YLOdhZcxcmu1hPqJ9D3Z/Vz9SFm474=; b=OSdzloNxOne1WfH0OYSa57CnRY
	dDKrsSj1gjPDyzU14wkl9AEB99804ZJsYWNLSm8IN0ODLNgF5e6sJ5Ejpt6E6H/Tc8mwfvUlL4H9p
	TWm+eY+H5c+Dxe0wq31Gixk1E1/ZP+b6T8ZHEjlFnl2Qyi1l7GhAM6IxiGE4BgogeNczB+xSlCBNG
	IcrOfHLO5WPTqxDA2uhg6NXOqlTG2Uvby9bywTXGU3c5gkhs52LKtI6JWhx1+JoyU/1GuAOC7rQ1J
	fqn2kb8t0U25P2TBPHXOul1sHffgfqWIiYlCNtUyGeK2A5zzH4JrSk7zSryxSBH/tKspAEj3ij72Z
	8iMqh9rQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v6Ai8-006HF9-7T; Tue, 07 Oct 2025 18:38:48 +0200
Message-ID: <6d21d11f-5bf0-4b0b-ab17-4afa29b0c94c@igalia.com>
Date: Wed, 8 Oct 2025 01:38:43 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for
 aux__prog
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-4-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20251007015147.2496026-4-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/25 10:51, Tejun Heo wrote:
> scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and() currently have 5
> parameters. An upcoming change will add aux__prog parameter which will exceed
> BPF's 5 argument limit.
> 
> Prepare by adding new kfuncs __scx_bpf_dsq_insert_vtime() and
> __scx_bpf_select_cpu_and() that take args structs. The existing kfuncs are
> kept as compatibility wrappers. BPF programs use inline wrappers that detect
> kernel API version via bpf_core_type_exists() and use the new struct-based
> kfuncs when available, falling back to compat kfuncs otherwise. This allows
> BPF programs to work with both old and new kernels.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me.

Reviewed-by: Changwoo Min <changwoo@igalia.com>> ---
>   kernel/sched/ext.c                       | 82 ++++++++++++++++++------
>   kernel/sched/ext_idle.c                  | 43 +++++++++++--
>   tools/sched_ext/include/scx/common.bpf.h |  6 +-
>   tools/sched_ext/include/scx/compat.bpf.h | 72 +++++++++++++++++++++
>   4 files changed, 173 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d76efaaa9b2..a34e731229de 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5345,54 +5345,94 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>   	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
>   }
>   
> +static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
> +				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> +		return;
> +
> +	if (slice)
> +		p->scx.slice = slice;
> +	else
> +		p->scx.slice = p->scx.slice ?: 1;
> +
> +	p->scx.dsq_vtime = vtime;
> +
> +	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +}
> +
> +struct scx_bpf_dsq_insert_vtime_args {
> +	/* @p can't be packed together as KF_RCU is not transitive */
> +	u64			dsq_id;
> +	u64			slice;
> +	u64			vtime;
> +	u64			enq_flags;
> +};
> +
>   /**
> - * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
> + * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
>    * @p: task_struct to insert
> - * @dsq_id: DSQ to insert into
> - * @slice: duration @p can run for in nsecs, 0 to keep the current value
> - * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> - * @enq_flags: SCX_ENQ_*
> + * @args: struct containing the rest of the arguments
> + *       @args->dsq_id: DSQ to insert into
> + *       @args->slice: duration @p can run for in nsecs, 0 to keep the current value
> + *       @args->vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + *       @args->enq_flags: SCX_ENQ_*
>    *
> - * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
> - * Tasks queued into the priority queue are ordered by @vtime. All other aspects
> - * are identical to scx_bpf_dsq_insert().
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 argument
> + * limit. BPF programs should use scx_bpf_dsq_insert_vtime() which is provided
> + * as an inline wrapper in common.bpf.h.
>    *
> - * @vtime ordering is according to time_before64() which considers wrapping. A
> - * numerically larger vtime may indicate an earlier position in the ordering and
> - * vice-versa.
> + * Insert @p into the vtime priority queue of the DSQ identified by
> + * @args->dsq_id. Tasks queued into the priority queue are ordered by
> + * @args->vtime. All other aspects are identical to scx_bpf_dsq_insert().
> + *
> + * @args->vtime ordering is according to time_before64() which considers
> + * wrapping. A numerically larger vtime may indicate an earlier position in the
> + * ordering and vice-versa.
>    *
>    * A DSQ can only be used as a FIFO or priority queue at any given time and this
>    * function must not be called on a DSQ which already has one or more FIFO tasks
>    * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>    * SCX_DSQ_GLOBAL) cannot be used as priority queues.
>    */
> -__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
> -					  u64 slice, u64 vtime, u64 enq_flags)
> +__bpf_kfunc void
> +__scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +			   struct scx_bpf_dsq_insert_vtime_args *args)
>   {
>   	struct scx_sched *sch;
>   
>   	guard(rcu)();
> +
>   	sch = rcu_dereference(scx_root);
>   	if (unlikely(!sch))
>   		return;
>   
> -	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +	scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vtime,
> +			     args->enq_flags);
> +}
>   
> -	if (slice)
> -		p->scx.slice = slice;
> -	else
> -		p->scx.slice = p->scx.slice ?: 1;
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
> +					  u64 slice, u64 vtime, u64 enq_flags)
> +{
> +	struct scx_sched *sch;
>   
> -	p->scx.dsq_vtime = vtime;
> +	guard(rcu)();
>   
> -	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return;
> +
> +	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>   }
>   
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>   BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>   BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>   
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index d2434c954848..3d9d404d5cd2 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -995,26 +995,56 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   	return prev_cpu;
>   }
>   
> +struct scx_bpf_select_cpu_and_args {
> +	/* @p and @cpus_allowed can't be packed together as KF_RCU is not transitive */
> +	s32			prev_cpu;
> +	u64			wake_flags;
> +	u64			flags;
> +};
> +
>   /**
> - * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
> - *			    prioritizing those in @cpus_allowed
> + * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
>    * @p: task_struct to select a CPU for
> - * @prev_cpu: CPU @p was on previously
> - * @wake_flags: %SCX_WAKE_* flags
>    * @cpus_allowed: cpumask of allowed CPUs
> - * @flags: %SCX_PICK_IDLE* flags
> + * @args: struct containing the rest of the arguments
> + *       @args->prev_cpu: CPU @p was on previously
> + *       @args->wake_flags: %SCX_WAKE_* flags
> + *       @args->flags: %SCX_PICK_IDLE* flags
> + *
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 argument
> + * limit. BPF programs should use scx_bpf_select_cpu_and() which is provided
> + * as an inline wrapper in common.bpf.h.
>    *
>    * Can be called from ops.select_cpu(), ops.enqueue(), or from an unlocked
>    * context such as a BPF test_run() call, as long as built-in CPU selection
>    * is enabled: ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE
>    * is set.
>    *
> - * @p, @prev_cpu and @wake_flags match ops.select_cpu().
> + * @p, @args->prev_cpu and @args->wake_flags match ops.select_cpu().
>    *
>    * Returns the selected idle CPU, which will be automatically awakened upon
>    * returning from ops.select_cpu() and can be used for direct dispatch, or
>    * a negative value if no idle CPU is available.
>    */
> +__bpf_kfunc s32
> +__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
> +			 struct scx_bpf_select_cpu_and_args *args)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return -ENODEV;
> +
> +	return select_cpu_from_kfunc(sch, p, args->prev_cpu, args->wake_flags,
> +				     cpus_allowed, args->flags);
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.22.
> + */
>   __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>   				       const struct cpumask *cpus_allowed, u64 flags)
>   {
> @@ -1383,6 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>   BTF_KFUNCS_END(scx_kfunc_ids_idle)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 505231b7b7ae..b1c2a0dde76e 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -60,10 +60,10 @@ static inline void ___vmlinux_h_sanity_check___(void)
>   
>   s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>   s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
> -s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> -			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
> +s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
> +			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
>   void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
>   u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>   void scx_bpf_dispatch_cancel(void) __ksym;
>   bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index d979f16a3ae2..e172de696f99 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -143,6 +143,78 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
>   	return rq ? rq->curr : NULL;
>   }
>   
> +/*
> + * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
> + * replaced with variants that pack scalar arguments in a struct. Wrappers are
> + * provided to maintain source compatibility.
> + *
> + * The kernel will carry the compat variants until v6.23 to maintain binary
> + * compatibility. After v6.23 release, remove the compat handling and move the
> + * wrappers to common.bpf.h.
> + */
> +s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
> +void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +
> +/**
> + * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> + * @p: task_struct to select a CPU for
> + * @prev_cpu: CPU @p was on previously
> + * @wake_flags: %SCX_WAKE_* flags
> + * @cpus_allowed: cpumask of allowed CPUs
> + * @flags: %SCX_PICK_IDLE* flags
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for details.
> + */
> +static inline s32
> +scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +		       const struct cpumask *cpus_allowed, u64 flags)
> +{
> +	if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
> +		struct scx_bpf_select_cpu_and_args args = {
> +			.prev_cpu = prev_cpu,
> +			.wake_flags = wake_flags,
> +			.flags = flags,
> +		};
> +
> +		return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
> +	} else {
> +		return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_flags,
> +						       cpus_allowed, flags);
> +	}
> +}
> +
> +/**
> + * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + * @enq_flags: SCX_ENQ_*
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
> + */
> +static inline void
> +scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
> +			 u64 enq_flags)
> +{
> +	if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
> +		struct scx_bpf_dsq_insert_vtime_args args = {
> +			.dsq_id = dsq_id,
> +			.slice = slice,
> +			.vtime = vtime,
> +			.enq_flags = enq_flags,
> +		};
> +
> +		__scx_bpf_dsq_insert_vtime(p, &args);
> +	} else {
> +		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
> +						  enq_flags);
> +	}
> +}
> +
>   /*
>    * Define sched_ext_ops. This may be expanded to define multiple variants for
>    * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().

