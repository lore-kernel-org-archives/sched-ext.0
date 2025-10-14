Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5A2DE6F5
	for <sched-ext@lists.linux.dev>; Tue, 14 Oct 2025 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483665; cv=none; b=Wtn+WTFEkimpmmzduGOfOXXoijQa82YEdZ9KrrTtULTkthIcVvZ2jz7X+JK0GhVvVoDiZAxnR2X7XUlblnk7ZGJAEGHQ+udm6G8LpTSqm33Yvyifyh5+pEd/7lusl8DHECRpMQ0z/LDW3Xl8ltPAZOm2My0JTR4DGleJvhdDxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483665; c=relaxed/simple;
	bh=EClcHiBVnCp7dWHLzwzW330HQK8qfwjfP1HQwE9nVWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+hrO5UYOVSpFRHhzlwQxGOHA48DztwIbq/Sj2Zcxu4ZOc7d/uzysuI9EqflLz9Z1gaVNQeaVtYAkg53ysfb/Jr5EhFsJE5Jko7F2yZFcbqVdQACcJsRHsWTam3yDrZANMSg6KVOgTeT4K2F3zBnDK01xj1AiLnqfUA+TwwTmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk; spf=pass smtp.mailfrom=hillion.co.uk; dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b=gkLazxRj; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b="gkLazxRj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hillion.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=AJdFH2sz/jA18mHmAfPZMPPk9tfrCqPZrJ4AUwUoi58=; b=gkLazxRjXFA3JIU1fy61/r9rPw
	xyOSomqDrkZp7Pv5MM6k+xX03+jdZoORS4/p6PgVSCt1d2COw4WtizBFHD8y8cmwQkBXbej+XDedT
	/V6PlUirQR46m3izKaHnMGOzh9nkILMzlyRVRGGfWPi1TODab4Lff+lmucJe8oiInFOuIdljJVbPD
	vAZjAXHcXHEkpfe2BybR15OKK5y9M/xahcWR/nuIxoODK9wEme5uDpTOBRDLPlShFYhaUz2xNPZ+8
	6Bj90SroLG3qWfTxr70T6+NR0JRjfUvDvuvt0QurqN98CipCenHWv1jU1CccDmCIBBTS8by7jwXon
	AI/S/Gtw==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jake@hillion.co.uk>)
	id 1v8nVB-00HV6o-0I;
	Tue, 14 Oct 2025 23:28:17 +0100
Date: Tue, 14 Oct 2025 23:27:57 +0100
From: Jake Hillion <jake@hillion.co.uk>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org, 
	arighi@nvidia.com, newton@meta.com
Subject: Re: [PATCH v3 1/2] sched_ext: Add lockless peek operation for DSQs
Message-ID: <ccbxwwb26ttq2jrgsie7uf4l5vy7mwe2a4yi7t3khllgfhuh75@hq4jdate7kyf>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
 <t8b-vwUhQyqC7uNXUsOCnC3pGMBTSqhIZuWqdx20sYVIriGXnnJVD9UP7K2ye1vrnyXglcpU14hevzw_xfCnMA==@protonmail.internalid>
 <20251006170403.3584204-2-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006170403.3584204-2-rrnewton@gmail.com>
X-BlackCat-Spam-Score: 4

On Mon, Oct 06, 2025 at 01:04:02PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>

Hi Ryan,

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

Applied to my local kernel and modified my scheduler to use this
feature. dmesg is clean and it works great.

Tested-by: Jake Hillion <jake@hillion.co.uk>

Thanks!
Jake.

> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext.c                       | 54 +++++++++++++++++++++++-
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++++++
>  4 files changed, 73 insertions(+), 2 deletions(-)
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
> index 2b0e88206d07..6d3537e65001 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -944,8 +944,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
> @@ -953,10 +956,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
> @@ -1011,6 +1023,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
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
> @@ -6084,6 +6103,36 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
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
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return NULL;
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
> +	return rcu_dereference(dsq->first_task);
> +}
> +
>  __bpf_kfunc_end_defs();
> 
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
> @@ -6641,6 +6690,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..fbf3e7f9526c 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
>  int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
>  struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
>  void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..97b10c184b2c 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
>  	false;									\
>  })
> 
> +
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
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> --
> 2.51.0
> 
> 
