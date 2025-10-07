Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145F13FEE;
	Tue,  7 Oct 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854197; cv=none; b=KpFu3k/PyQr+Nl/bWawG4jK1X0qVG/vriZXRIfn7EApxR5FyztXFnt3z25C8WX7IIR8mcis1AFn9DbEptbRuOk4ZnBP1pfOj0nymCI+j6aNQAIMWUByaELfL2Mc3Zy9KHwm6EV1jYxjxsNsH6Tz4aa/Kp0gl/W3/eEP62pMZQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854197; c=relaxed/simple;
	bh=1u+DRj2qq4EJFBE9su1RLUR4e/nL+dw8v3qNPKJNM7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InmQk2U4WW1SbyQ0BRdGI7s07rGyFx85b6blscy+ZD6m5YXxHp3M6QllVtdovMDOGxVShLtatD1MGn7iKA6HFz2fxVwo5FLc9D2MlRTZIKqTt3EZGEM46SSm+6EqFHaQLeIaXicVu732R7fD2Ypqe/N712zQDs1eGvggX97KfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TZ8ZwICL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TZ8ZwICL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OzhfuRPl3cWsY88R0JG8sjwC2bLZ4eZCnz7e+4pOo8M=; b=TZ8ZwICL/6skD28FbzN0Qbtnik
	FQ+clt1d+oS+/P9QJOhDh8YDSWD7/z93gWR/b9LfUcoq8shRTMctheSGFsgF7zKOS64nGBwtCyv6i
	SMBhzbFZyEiI1+1aWgTC945y6TDBqZWRTMZ0ipFrcXsNqzh47C9ZW3cjN0daaaDpmBj5ZIVUdrQuB
	KNd/o5I8OyKJ3GL5I4rYXk9NXOtLJs5N7MwknEUBiM0MEXRnCskbEuAxLruNJB6msdVW7HZfhYgpN
	Ja4106gwycp6ouYdLNAcHyJNJsvlhRLeUtVu/MjdF4JbxlNVSHfq7BAkPP7rzAWsXvTg3KdaPc12v
	LJewPk0g==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v6ASo-006GuK-9m; Tue, 07 Oct 2025 18:22:58 +0200
Message-ID: <09b9a30a-06c8-4664-a484-7b37091782c4@igalia.com>
Date: Wed, 8 Oct 2025 01:22:47 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tools/sched_ext: Strip compatibility macros for
 cgroup and dispatch APIs
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-2-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20251007015147.2496026-2-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/25 10:51, Tejun Heo wrote:
> Enough time has passed since the introduction of scx_bpf_task_cgroup() and
> the scx_bpf_dispatch* -> scx_bpf_dsq* kfunc renaming. Strip the compatibility
> macros.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Changwoo Min <changwoo@igalia.com>

Thanks!
Changwoo Min

> ---
>   tools/sched_ext/include/scx/compat.bpf.h | 108 +----------------------
>   tools/sched_ext/scx_flatcg.bpf.c         |  10 +--
>   tools/sched_ext/scx_qmap.bpf.c           |  14 ++-
>   3 files changed, 12 insertions(+), 120 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..d979f16a3ae2 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,121 +15,17 @@
>   	__ret;									\
>   })
>   
> -/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
> -#define __COMPAT_scx_bpf_task_cgroup(p)						\
> -	(bpf_ksym_exists(scx_bpf_task_cgroup) ?					\
> -	 scx_bpf_task_cgroup((p)) : NULL)
> -
>   /*
> - * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs are
> - * renamed to unload the verb.
> - *
> - * Build error is triggered if old names are used. New binaries work with both
> - * new and old names. The compat macros will be removed on v6.15 release.
> + * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>    *
> - * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
> - * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
> - * Preserve __COMPAT macros until v6.15.
> + * Compat macro will be dropped on v6.19 release.
>    */
> -void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> -void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
> -bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>   int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
>   
> -#define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
> -	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
> -	 scx_bpf_dsq_insert((p), (dsq_id), (slice), (enq_flags)) :		\
> -	 scx_bpf_dispatch___compat((p), (dsq_id), (slice), (enq_flags)))
> -
> -#define scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_insert_vtime) ?				\
> -	 scx_bpf_dsq_insert_vtime((p), (dsq_id), (slice), (vtime), (enq_flags)) : \
> -	 scx_bpf_dispatch_vtime___compat((p), (dsq_id), (slice), (vtime), (enq_flags)))
> -
> -#define scx_bpf_dsq_move_to_local(dsq_id)					\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_to_local) ?				\
> -	 scx_bpf_dsq_move_to_local((dsq_id)) :					\
> -	 scx_bpf_consume___compat((dsq_id)))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_slice(it__iter, slice)			\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice) ?				\
> -	 scx_bpf_dsq_move_set_slice((it__iter), (slice)) :			\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___compat) ?	\
> -	  scx_bpf_dispatch_from_dsq_set_slice___compat((it__iter), (slice)) :	\
> -	  (void)0))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_vtime(it__iter, vtime)			\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_set_vtime) ?				\
> -	 scx_bpf_dsq_move_set_vtime((it__iter), (vtime)) :			\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___compat) ?	\
> -	  scx_bpf_dispatch_from_dsq_set_vtime___compat((it__iter), (vtime)) :	\
> -	  (void) 0))
> -
> -#define __COMPAT_scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_move) ?					\
> -	 scx_bpf_dsq_move((it__iter), (p), (dsq_id), (enq_flags)) :		\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___compat) ?			\
> -	  scx_bpf_dispatch_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
> -	  false))
> -
> -#define __COMPAT_scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_vtime) ?				\
> -	 scx_bpf_dsq_move_vtime((it__iter), (p), (dsq_id), (enq_flags)) :	\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___compat) ?		\
> -	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
> -	  false))
> -
>   #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
>   	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
>   	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
>   
> -#define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
> -	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
> -
> -#define scx_bpf_dispatch_vtime(p, dsq_id, slice, vtime, enq_flags)		\
> -	_Static_assert(false, "scx_bpf_dispatch_vtime() renamed to scx_bpf_dsq_insert_vtime()")
> -
> -#define scx_bpf_consume(dsq_id) ({						\
> -	_Static_assert(false, "scx_bpf_consume() renamed to scx_bpf_dsq_move_to_local()"); \
> -	false;									\
> -})
> -
> -#define scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_slice() renamed to scx_bpf_dsq_move_set_slice()")
> -
> -#define scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_vtime() renamed to scx_bpf_dsq_move_set_vtime()")
> -
> -#define scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq() renamed to scx_bpf_dsq_move()"); \
> -	false;									\
> -})
> -
> -#define scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
> -	_Static_assert(false, "scx_bpf_dispatch_vtime_from_dsq() renamed to scx_bpf_dsq_move_vtime()"); \
> -	false;									\
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_slice() renamed to __COMPAT_scx_bpf_dsq_move_set_slice()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime() renamed to __COMPAT_scx_bpf_dsq_move_set_vtime()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move()"); \
> -	false;									\
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_vtime_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move_vtime()"); \
> -	false;									\
> -})
> -
>   /**
>    * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>    * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 2c720e3ecad5..43126858b8e4 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -382,7 +382,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
>   		return;
>   	}
>   
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>   	cgc = find_cgrp_ctx(cgrp);
>   	if (!cgc)
>   		goto out_release;
> @@ -508,7 +508,7 @@ void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
>   {
>   	struct cgroup *cgrp;
>   
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>   	update_active_weight_sums(cgrp, true);
>   	bpf_cgroup_release(cgrp);
>   }
> @@ -521,7 +521,7 @@ void BPF_STRUCT_OPS(fcg_running, struct task_struct *p)
>   	if (fifo_sched)
>   		return;
>   
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>   	cgc = find_cgrp_ctx(cgrp);
>   	if (cgc) {
>   		/*
> @@ -564,7 +564,7 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>   	if (!taskc->bypassed_at)
>   		return;
>   
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>   	cgc = find_cgrp_ctx(cgrp);
>   	if (cgc) {
>   		__sync_fetch_and_add(&cgc->cvtime_delta,
> @@ -578,7 +578,7 @@ void BPF_STRUCT_OPS(fcg_quiescent, struct task_struct *p, u64 deq_flags)
>   {
>   	struct cgroup *cgrp;
>   
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>   	update_active_weight_sums(cgrp, false);
>   	bpf_cgroup_release(cgrp);
>   }
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 3072b593f898..c67dac78a4c6 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -320,12 +320,9 @@ static bool dispatch_highpri(bool from_timer)
>   
>   		if (tctx->highpri) {
>   			/* exercise the set_*() and vtime interface too */
> -			__COMPAT_scx_bpf_dsq_move_set_slice(
> -				BPF_FOR_EACH_ITER, slice_ns * 2);
> -			__COMPAT_scx_bpf_dsq_move_set_vtime(
> -				BPF_FOR_EACH_ITER, highpri_seq++);
> -			__COMPAT_scx_bpf_dsq_move_vtime(
> -				BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
> +			scx_bpf_dsq_move_set_slice(BPF_FOR_EACH_ITER, slice_ns * 2);
> +			scx_bpf_dsq_move_set_vtime(BPF_FOR_EACH_ITER, highpri_seq++);
> +			scx_bpf_dsq_move_vtime(BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
>   		}
>   	}
>   
> @@ -342,9 +339,8 @@ static bool dispatch_highpri(bool from_timer)
>   		else
>   			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
>   
> -		if (__COMPAT_scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p,
> -					      SCX_DSQ_LOCAL_ON | cpu,
> -					      SCX_ENQ_PREEMPT)) {
> +		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cpu,
> +				     SCX_ENQ_PREEMPT)) {
>   			if (cpu == this_cpu) {
>   				dispatched = true;
>   				__sync_fetch_and_add(&nr_expedited_local, 1);

