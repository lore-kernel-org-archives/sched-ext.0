Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA564316E;
	Tue,  7 Oct 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855671; cv=none; b=BVP4CEPLZK3zyGmvDURC1U/sRo0Gq1CkusqxtJt+z1fkluSif1WUbN0OuR33aYPXKZdj+9ulOMh2qJntXU2AvBJgfQMOcCwVfwjq9J1jOGqsMXTwCkSujhlWsfsCuzznXaOteDacyCRFfuRj3aySTbhiEYSro83WSlUiDEyCMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855671; c=relaxed/simple;
	bh=AnQPvORkMfFIrLtm1OwQcGJ4F1LisjXo4BbSMM2PHG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4/TE6mehR+iLeOM3SUZEfDMVaI9mT1qZzlqKqtjyvT1VCKUOuLLVfUtQ6V0UlIGzzqCg/ZzTwOC73WaZF5At1A1x9XXw6Th3KLcV38xFSNYXkvz2yQTfPps4H8TONzCUJs2KTdv104OYPDgD7rp2k+yojPmATh14Yio1cx7qBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P82dITe/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P82dITe/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Q6kuk1BSWKuld3b7wnE+3xvam0vxOKcqnOWNWJle5I=; b=P82dITe/i8/v/fY7qNgH9OgwIg
	39RFEZQreiQ5sqgESBWN4TdCa3PIuQB9MF/bDiZ8ySyOuLsNgR0TJjUWQtv2Y83+wjoxtuHKnQfxC
	JlRAznTnqQrqEhW7bpIciohif4JTny8z8FjgHKd9niD+yLcMAHgBhCv2Eh713t45RJClNIbhgRQ+s
	nhvkqsJDUdPErrYKdmq7XLu9TF8dLfD+6T4W0bFF2d+QFLVOm3k5+n0OJO3rIDWAh3yvhNQD38Yf+
	c24Lk46GFGkM/M8WH/anmh3xpHEfVOtPjlPvx755WNiLRWFYJE2RVgdhq94czwuS7JCYR0oIpeDEy
	G8H0r79g==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v6Aqj-006HNs-TR; Tue, 07 Oct 2025 18:47:42 +0200
Message-ID: <4b91c6f0-8325-4eee-9a7a-e3f78f0d550a@igalia.com>
Date: Wed, 8 Oct 2025 01:47:37 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-5-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20251007015147.2496026-5-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/25 10:51, Tejun Heo wrote:
> In preparation for hierarchical schedulers, change scx_bpf_dsq_insert() and
> scx_bpf_dsq_insert_vtime() to return bool instead of void. With
> sub-schedulers, there will be no reliable way to guarantee a task is still
> owned by the sub-scheduler at insertion time (e.g., the task may have been
> migrated to another scheduler). The bool return value will enable
> sub-schedulers to detect and gracefully handle insertion failures.
> 
> For the root scheduler, insertion failures will continue to trigger scheduler
> abort via scx_error(), so existing code doesn't need to check the return
> value. Backward compatibility is maintained through compat wrappers.
> 
> Also update scx_bpf_dsq_move() documentation to clarify that it can return
> false for sub-schedulers when @dsq_id points to a disallowed local DSQ.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me.

Reviewed-by: Changwoo Min <changwoo@igalia.com>

Regards,
Changwoo Min


> ---
>   kernel/sched/ext.c                       | 45 ++++++++++++++++++------
>   tools/sched_ext/include/scx/common.bpf.h |  3 +-
>   tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++--
>   3 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a34e731229de..399e53c8939c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5323,8 +5323,12 @@ __bpf_kfunc_start_defs();
>    * exhaustion. If zero, the current residual slice is maintained. If
>    * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the CPU with
>    * scx_bpf_kick_cpu() to trigger scheduling.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller doesn't need
> + * to check the return value.
>    */
> -__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
> +__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
>   				    u64 enq_flags)
>   {
>   	struct scx_sched *sch;
> @@ -5332,10 +5336,10 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>   	guard(rcu)();
>   	sch = rcu_dereference(scx_root);
>   	if (unlikely(!sch))
> -		return;
> +		return false;
>   
>   	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +		return false;
>   
>   	if (slice)
>   		p->scx.slice = slice;
> @@ -5343,13 +5347,24 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
>   		p->scx.slice = p->scx.slice ?: 1;
>   
>   	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> +
> +	return true;
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id,
> +					     u64 slice, u64 enq_flags)
> +{
> +	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
>   }
>   
> -static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
> +static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>   				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
>   {
>   	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -		return;
> +		return false;
>   
>   	if (slice)
>   		p->scx.slice = slice;
> @@ -5359,6 +5374,8 @@ static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>   	p->scx.dsq_vtime = vtime;
>   
>   	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
> +
> +	return true;
>   }
>   
>   struct scx_bpf_dsq_insert_vtime_args {
> @@ -5394,8 +5411,12 @@ struct scx_bpf_dsq_insert_vtime_args {
>    * function must not be called on a DSQ which already has one or more FIFO tasks
>    * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>    * SCX_DSQ_GLOBAL) cannot be used as priority queues.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller doesn't need
> + * to check the return value.
>    */
> -__bpf_kfunc void
> +__bpf_kfunc bool
>   __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>   			   struct scx_bpf_dsq_insert_vtime_args *args)
>   {
> @@ -5405,10 +5426,10 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>   
>   	sch = rcu_dereference(scx_root);
>   	if (unlikely(!sch))
> -		return;
> +		return false;
>   
> -	scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vtime,
> -			     args->enq_flags);
> +	return scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice,
> +				    args->vtime, args->enq_flags);
>   }
>   
>   /*
> @@ -5432,6 +5453,7 @@ __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>   BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
>   BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>   BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>   BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> @@ -5686,8 +5708,9 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter,
>    * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
>    * lock (e.g. BPF timers or SYSCALL programs).
>    *
> - * Returns %true if @p has been consumed, %false if @p had already been consumed
> - * or dequeued.
> + * Returns %true if @p has been consumed, %false if @p had already been
> + * consumed, dequeued, or, for sub-scheds, @dsq_id points to a disallowed local
> + * DSQ.
>    */
>   __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>   				  struct task_struct *p, u64 dsq_id,
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index b1c2a0dde76e..522c90d0ced2 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -62,8 +62,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>   s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
>   s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
>   			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
> -void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> -void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
>   u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>   void scx_bpf_dispatch_cancel(void) __ksym;
>   bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index e172de696f99..33c26928f4e9 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -196,7 +196,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>    * Inline wrapper that packs scalar arguments into a struct and calls
>    * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
>    */
> -static inline void
> +static inline bool
>   scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
>   			 u64 enq_flags)
>   {
> @@ -208,10 +208,29 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime
>   			.enq_flags = enq_flags,
>   		};
>   
> -		__scx_bpf_dsq_insert_vtime(p, &args);
> +		return __scx_bpf_dsq_insert_vtime(p, &args);
>   	} else {
>   		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
>   						  enq_flags);
> +		return true;
> +	}
> +}
> +
> +/*
> + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper after v6.22.
> + */
> +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> +
> +static inline bool
> +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
> +{
> +	if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
> +		return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_flags);
> +	} else {
> +		scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
> +		return true;
>   	}
>   }
>   

