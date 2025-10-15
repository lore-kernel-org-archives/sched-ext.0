Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DB224B1F
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521617; cv=none; b=GT34sM/ktAaW95phpNNDLDTAuPPdQz0W0NAnYtW5tbSm/5kwD8w/jjrZ8VlKDMAKUw2TOlcuEDCquwTt+V4AQyI40+YS13mv63tXoNLJBPiaxBr5p4hXDLBgdHZzxLtEw5ClEajyTWujEr/YhqpuOVSlVcjcCYRN7EE7XN3EeXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521617; c=relaxed/simple;
	bh=4QdZqAOQj3M/GEdunar4dQW5o/7Xq5VvbZzbpbWzsOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SORXFCwyjjtIiilF3kvMM2xjja+snOnZy1QeMdsNaCvdjLfeMrHxZ9VG1T8rabO0aHncdddyzSBDKOVGoVKNJWFcGzSgbWqAtQ/xdUYvEAy0y7J1dsojF0dPGMwBAe6r29GF5M+nFdvC+QOHfo1edV/QO8u2iUIkuuTRlPrdEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8750916A3;
	Wed, 15 Oct 2025 02:46:47 -0700 (PDT)
Received: from [10.1.32.75] (e127648.arm.com [10.1.32.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388423F6A8;
	Wed, 15 Oct 2025 02:46:54 -0700 (PDT)
Message-ID: <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
Date: Wed, 15 Oct 2025 10:46:52 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
To: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev, tj@kernel.org, arighi@nvidia.com,
 newton@meta.com
References: <20251015015712.3996346-1-rrnewton@gmail.com>
 <20251015015712.3996346-2-rrnewton@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251015015712.3996346-2-rrnewton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 02:57, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> The builtin DSQ queue data structures are meant to be used by a wide
> range of different sched_ext schedulers with different demands on these
> data structures. They might be per-cpu with low-contention, or
> high-contention shared queues. Unfortunately, DSQs have a coarse-grained
> lock around the whole data structure. Without going all the way to a
> lock-free, more scalable implementation, a small step we can take to
> reduce lock contention is to allow a lockless, small-fixed-cost peek at
> the head of the queue.
> 
> This change allows certain custom SCX schedulers to cheaply peek at
> queues, e.g. during load balancing, before locking them. But it
> represents a few extra memory operations to update the pointer each
> time the DSQ is modified, including a memory barrier on ARM so the write
> appears correctly ordered.
> 
> This commit adds a first_task pointer field which is updated
> atomically when the DSQ is modified, and allows any thread to peek at
> the head of the queue without holding the lock.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext.c                       | 56 +++++++++++++++++++++++-
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++
>  4 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d82b7a9b0658..81478d4ae782 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
>   */
>  struct scx_dispatch_q {
>  	raw_spinlock_t		lock;
> +	struct task_struct __rcu *first_task; /* lockless peek at head */
>  	struct list_head	list;	/* tasks in dispatch order */
>  	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
>  	u32			nr;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4b1467d3541a..430eaa7cfbbe 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -965,8 +965,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  				container_of(rbp, struct task_struct,
>  					     scx.dsq_priq);
>  			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
> +			/* first task unchanged - no update needed */
>  		} else {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> +			/* not builtin and new task is at head - use fastpath */
> +			rcu_assign_pointer(dsq->first_task, p);
>  		}
>  	} else {
>  		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
> @@ -974,10 +977,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
>  				  dsq->id);
>  
> -		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> +		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> -		else
> +			/* new task inserted at head - use fastpath */
> +			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +				rcu_assign_pointer(dsq->first_task, p);
> +		} else {
> +			bool was_empty;
> +
> +			was_empty = list_empty(&dsq->list);
>  			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
> +			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +				rcu_assign_pointer(dsq->first_task, p);
> +		}
>  	}
>  
>  	/* seq records the order tasks are queued, used by BPF DSQ iterator */
> @@ -1032,6 +1044,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
>  	}
>  
> +	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
> +		struct task_struct *first_task;
> +
> +		first_task = nldsq_next_task(dsq, NULL, false);
> +		rcu_assign_pointer(dsq->first_task, first_task);
> +	}
> +
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
>  }
> @@ -6278,6 +6297,38 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  	kit->dsq = NULL;
>  }
>  
> +/**
> + * scx_bpf_dsq_peek - Lockless peek at the first element.
> + * @dsq_id: DSQ to examine.
> + *
> + * Read the first element in the DSQ. This is semantically equivalent to using
> + * the DSQ iterator, but is lockfree.
> + *
> + * Returns the pointer, or NULL indicates an empty queue OR internal error.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> +{

Obviously there's no guarantee that scx_bpf_dsq_peek() will return the task you're gonna
get when moving a task to another DSQ or a local one. It's pretty obvious from the kernel
perspective, but I wonder if it's worth documenting here too.

> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return NULL;
> +
> +	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
> +		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
> +		return NULL;
> +	}
> +
> +	dsq = find_user_dsq(sch, dsq_id);
> +	if (unlikely(!dsq)) {
> +		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
> +		return NULL;
> +	}
> +
> +	return rcu_dereference(dsq->first_task);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
> @@ -6837,6 +6888,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index eb3c99445cb3..e65b1eb668ea 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -74,6 +74,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
>  int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
>  struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
>  void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index e487c10b5e07..619a16f0d39a 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -26,6 +26,24 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
>  	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
>  	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
>  
> +/*
> + * v6.19: Introduce lockless peek API for user DSQs.
> + *
> + * Preserve the following macro until v6.21.
> + */
> +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct task_struct *p = NULL;
> +	struct bpf_iter_scx_dsq it;
> +
> +	if (bpf_ksym_exists(scx_bpf_dsq_peek))
> +		return scx_bpf_dsq_peek(dsq_id);
> +	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> +		p = bpf_iter_scx_dsq_next(&it);
> +	bpf_iter_scx_dsq_destroy(&it);
> +	return p;
> +}
> +
I think there's an argument to be made for this to just return NULL on
!bpf_ksym_exists(scx_bpf_dsq_peek), the caller needs to handle that anyway
and at least it's guaranteed to be lockfree then?
I don't have a strong leaning either way, probably is fine if documented.
