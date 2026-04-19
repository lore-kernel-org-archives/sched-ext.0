Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822112E03EA
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776623962; cv=none; b=kOCsi4QtSuydAVcDuMYf22a5PlPX8jNgfKXZml8d2vAO7Thi2PeNzyZpS4mzFbV+LGFXaxj2w7QByeIzRnwrYTETjTl/GyYbUUmghg76Nw2kf97+OgpgXP41EKPo2VcnFUStuLfD84l8r9CZfQwk0cPOp8w8gUNC9JhWVHVaLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776623962; c=relaxed/simple;
	bh=MvV6Dr1g1fxM5kysADG9LfMou0OIjkr2OGcPt0qgV/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaE2lJT4X/r50mMXIhLQBQAmZN/knesmJ1SZSBK6fzDde2EKefKAGZOj6uIdIW00tKE4xQSza10lXQQs3NkjPtxkIZfOPzg5t4VHIFXrinpoGBaA3+GXsbYKDFFbfP/3BMKT15n4H64QQDw0PGrrysK/w4CT9NpTMasscZnt2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehe3H0py; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehe3H0py"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1383281a91.3
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776623959; x=1777228759; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1EhbFStW/WMxkhtLlF+rphy4IZyi1GR8Jp5xQMxNg8=;
        b=ehe3H0py8t7pYgihwkMaaUqHn8YobCNvgsC5UjcSzAosCl92mFdsKEQPNvH5oj34hS
         jTRKLNubImW/P7Ng1dLzlF55Ik/wvjJMH2SjXW1w8M1aARiXMEmem9WAo3pI3gDWO1J1
         F2wL1v4/eKhgYxmuTP40V5OeNQyDygMCJ0xR1/sPBLA6HF0ocsoEtlS5mKYH4N7HTfy8
         9wEiZOitreDWhfdpFHRNHuKrPO+wd+2kD766NhPSDOshdrpdBUb4i6Z1QWfuFZ0dRwo4
         mX7AdJ53kezPZ7Oz8cvsExP1LO2NmjsuXoO/nq2x1lCB4jiyM4lZ8U3NdnzO81k0v8yD
         3Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776623959; x=1777228759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1EhbFStW/WMxkhtLlF+rphy4IZyi1GR8Jp5xQMxNg8=;
        b=MqileXMV6Oi3sbJ1BMI1u/a03svWvRPVjM8NxtKpjkNaK08lfqNjgr09iwBPd7bx4s
         EJAMF1++43SI9Ppxzd6jpjHLwDAX2v/VnmY+hV56K6AhJp28lU/ATaDuLvMdn+S7iWuT
         xV43Cd1d1qbfa5K5NLy27GSZ6Bp03D6FCKix0FvGA7Zi/OsLsSPs9zxFUqmOLfiBmUbQ
         e3HEzOFZIXxrnJsPwNCXlh9MD7KjMxZoHCr7OuE6H2ZGqT7WkIko9woycJdttMWsUjIY
         k3rUzQMSRO2eNDx2jwvbH+3kQOjQ76F/qSvQC7RcO1RjIUwcZlo6TM7tJNevMGAwXToW
         sw7g==
X-Forwarded-Encrypted: i=1; AFNElJ+o3HskxOVQz8imeG1dy3J8IzEAObfeQ842aRemeJBQiQSz8MHrIn2jfEx0b/EbGYsDHuAZqZuysUg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjVY/OdxaPSnv/kqOVnRiPU1wUNlR0g7dPjgGeDyD9nP++bHFf
	3yLzrYMk7HG4OmLAmUpJAoUpXfFdqiUuNNSVcedanOEOqJN3LbIDi4w1
X-Gm-Gg: AeBDiet9LPK8JfjJH408eZ0eW4s683Lduq1HFWaqecvSDHTR5xbcGOiXbZEhHlDxGK5
	9BE/6s1nYbXK+6u6+VxDWkBsFpmjstMTw62ApdgxZGK9qTgeLPI0bBdXNfD6UGiB3gMXPemevQb
	pDiMmx/vRey7mvFBBoQ3Qk61A/U8YjqnI19e7zfRYtAtVlTfnza5Z0k8O6sDqJQaUA8dcXYGddS
	I6usfj0NOITeMrFTtcRbtWUA4oV7l9XLntAS2oU7CjiGED/Wks+sO3slhRcqGkguJ6Of8Z17n/B
	EbHoPagaNevm9rPNuQPEgPo0wo53bM/uBbl42Rl+1gGQsgOh9sYPVCRaHUlAP18pb+P9tjkKjr3
	5qdYhKndnkulmpmi1exXwRUJJgiJY1Q1JUJR22wjk3z0KEf7jmw6cNn5zVrfNRpUjtgLPvWqiQD
	juxV04w3aXLHgLDo4zG6ULdEWFt3ppUgsXQZzOu5WvWsRfTaMHDg==
X-Received: by 2002:a17:90a:f94f:b0:35f:c5cd:cc5 with SMTP id 98e67ed59e1d1-36140498686mr11351105a91.24.1776623958716;
        Sun, 19 Apr 2026 11:39:18 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:2604:2a99:5447:dfea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3128880a91.11.2026.04.19.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:39:18 -0700 (PDT)
Date: Mon, 20 Apr 2026 02:39:12 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <hbpu63krraoqeitnr7ju5jftad7s2hxv6lykx2kqnlzw5nlwne@bvgrcccx4kf5>
References: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>

Hi Tejun,

On Sun, Apr 19, 2026 at 08:36:45AM -1000, Tejun Heo wrote:
> BPF schedulers that can't hold task_struct pointers (arena-backed ones in
> particular) key tasks by pid. During exit, pid is released before the
> task finishes passing through scheduler callbacks, so a dying task
> becomes invisible to the BPF side mid-schedule. scx_qmap hits this: an
> exiting task's dispatch callback can't recover its queue entry, stalling
> dispatch until SCX_EXIT_ERROR_STALL.
> 
> Add a unique non-zero u64 p->scx.tid assigned at fork that survives the
> full task lifetime including exit. scx_bpf_tid_to_task() looks up the
> task; unlike bpf_task_from_pid(), it handles exiting tasks.
> 
> The lookup costs an rhashtable insert/remove under scx_tasks_lock, so
> root schedulers opt in via SCX_OPS_TID_TO_TASK. Sub-schedulers that set
> the flag to declare a dependency are rejected at attach if root didn't
> opt in.
> 
> scx_qmap converted: keys tasks by tid and enables SCX_OPS_ENQ_EXITING.
> Pre-patch it stalls within seconds under a non-leader-exec workload;
> with the patch it runs cleanly.
> 
> v3: Warn on rhashtable_lookup_insert_fast() failure via new
>     scx_tid_hash_insert() helper (Cheng-Yang Chou).
> 
> v2: Guard scx_root deref in scx_bpf_tid_to_task() error path. The kfunc
>     is registered via scx_kfunc_set_any and reachable from tracing and
>     syscall programs when no scheduler is attached (Cheng-Yang Chou).

Looks good, thanks!

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h                |    9 +
>  kernel/sched/ext.c                       |  154 +++++++++++++++++++++++++++++--
>  kernel/sched/ext_internal.h              |   20 +++-
>  tools/sched_ext/include/scx/common.bpf.h |    1 
>  tools/sched_ext/scx_qmap.bpf.c           |   13 +-
>  5 files changed, 180 insertions(+), 17 deletions(-)
> 
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -203,6 +203,15 @@ struct sched_ext_entity {
>  	u64			core_sched_at;	/* see scx_prio_less() */
>  #endif
>  
> +	/*
> +	 * Unique non-zero task ID assigned at fork. Persists across exec and
> +	 * is never reused. Lets BPF schedulers identify tasks without storing
> +	 * kernel pointers - arena-backed schedulers being one example. See
> +	 * scx_bpf_tid_to_task().
> +	 */
> +	u64			tid;
> +	struct rhash_head	tid_hash_node;	/* see SCX_OPS_TID_TO_TASK */
> +
>  	/* BPF scheduler modifiable fields */
>  
>  	/*
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -38,6 +38,15 @@ static const struct rhashtable_params sc
>  static struct rhashtable scx_sched_hash;
>  #endif
>  
> +/* see SCX_OPS_TID_TO_TASK */
> +static const struct rhashtable_params scx_tid_hash_params = {
> +	.key_len		= sizeof_field(struct sched_ext_entity, tid),
> +	.key_offset		= offsetof(struct sched_ext_entity, tid),
> +	.head_offset		= offsetof(struct sched_ext_entity, tid_hash_node),
> +	.insecure_elasticity	= true,	/* inserted/removed under scx_tasks_lock */
> +};
> +static struct rhashtable scx_tid_hash;
> +
>  /*
>   * During exit, a task may schedule after losing its PIDs. When disabling the
>   * BPF scheduler, we need to be able to iterate tasks in every state to
> @@ -58,10 +67,25 @@ static cpumask_var_t scx_bypass_lb_resch
>  static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
> +static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
> +
> +/*
> + * True once SCX_OPS_TID_TO_TASK has been negotiated with the root scheduler
> + * and the tid->task table is live. Wraps the static key so callers don't
> + * take the address, and hints "likely enabled" for the common case where
> + * the feature is in use.
> + */
> +static inline bool scx_tid_to_task_enabled(void)
> +{
> +	return static_branch_likely(&__scx_tid_to_task_enabled);
> +}
>  
>  static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
>  static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
>  
> +/* Global cursor for the per-CPU tid allocator. Starts at 1; tid 0 is reserved. */
> +static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
> +
>  #ifdef CONFIG_EXT_SUB_SCHED
>  /*
>   * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
> @@ -111,6 +135,17 @@ struct scx_kick_syncs {
>  static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
>  
>  /*
> + * Per-CPU buffered allocator state for p->scx.tid. Each CPU pulls a chunk of
> + * SCX_TID_CHUNK ids from scx_tid_cursor and hands them out locally without
> + * further synchronization. See scx_alloc_tid().
> + */
> +struct scx_tid_alloc {
> +	u64	next;
> +	u64	end;
> +};
> +static DEFINE_PER_CPU(struct scx_tid_alloc, scx_tid_alloc);
> +
> +/*
>   * Direct dispatch marker.
>   *
>   * Non-NULL values are used for direct dispatch from enqueue path. A valid
> @@ -3665,6 +3700,33 @@ void init_scx_entity(struct sched_ext_en
>  	scx->slice = SCX_SLICE_DFL;
>  }
>  
> +/* See scx_tid_alloc / scx_tid_cursor. */
> +static u64 scx_alloc_tid(void)
> +{
> +	struct scx_tid_alloc *ta;
> +
> +	guard(preempt)();
> +	ta = this_cpu_ptr(&scx_tid_alloc);
> +
> +	if (unlikely(ta->next >= ta->end)) {
> +		ta->next = atomic64_fetch_add(SCX_TID_CHUNK, &scx_tid_cursor);
> +		ta->end = ta->next + SCX_TID_CHUNK;
> +	}
> +	return ta->next++;
> +}
> +
> +static void scx_tid_hash_insert(struct task_struct *p)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&scx_tasks_lock);
> +
> +	ret = rhashtable_lookup_insert_fast(&scx_tid_hash,
> +					    &p->scx.tid_hash_node,
> +					    scx_tid_hash_params);
> +	WARN_ON_ONCE(ret);
> +}
> +
>  void scx_pre_fork(struct task_struct *p)
>  {
>  	/*
> @@ -3682,6 +3744,8 @@ int scx_fork(struct task_struct *p, stru
>  
>  	percpu_rwsem_assert_held(&scx_fork_rwsem);
>  
> +	p->scx.tid = scx_alloc_tid();
> +
>  	if (scx_init_task_enabled) {
>  #ifdef CONFIG_EXT_SUB_SCHED
>  		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
> @@ -3717,9 +3781,11 @@ void scx_post_fork(struct task_struct *p
>  		}
>  	}
>  
> -	raw_spin_lock_irq(&scx_tasks_lock);
> -	list_add_tail(&p->scx.tasks_node, &scx_tasks);
> -	raw_spin_unlock_irq(&scx_tasks_lock);
> +	scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
> +		list_add_tail(&p->scx.tasks_node, &scx_tasks);
> +		if (scx_tid_to_task_enabled())
> +			scx_tid_hash_insert(p);
> +	}
>  
>  	percpu_up_read(&scx_fork_rwsem);
>  }
> @@ -3770,17 +3836,19 @@ static bool task_dead_and_done(struct ta
>  
>  void sched_ext_dead(struct task_struct *p)
>  {
> -	unsigned long flags;
> -
>  	/*
>  	 * By the time control reaches here, @p has %TASK_DEAD set, switched out
>  	 * for the last time and then dropped the rq lock - task_dead_and_done()
>  	 * should be returning %true nullifying the straggling sched_class ops.
>  	 * Remove from scx_tasks and exit @p.
>  	 */
> -	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
> -	list_del_init(&p->scx.tasks_node);
> -	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
> +	scoped_guard(raw_spinlock_irqsave, &scx_tasks_lock) {
> +		list_del_init(&p->scx.tasks_node);
> +		if (scx_tid_to_task_enabled())
> +			rhashtable_remove_fast(&scx_tid_hash,
> +					       &p->scx.tid_hash_node,
> +					       scx_tid_hash_params);
> +	}
>  
>  	/*
>  	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
> @@ -5794,9 +5862,13 @@ static void scx_root_disable(struct scx_
>  
>  	/* no task is on scx, turn off all the switches and flush in-progress calls */
>  	static_branch_disable(&__scx_enabled);
> +	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
> +		static_branch_disable(&__scx_tid_to_task_enabled);
>  	bitmap_zero(sch->has_op, SCX_OPI_END);
>  	scx_idle_disable();
>  	synchronize_rcu();
> +	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
> +		rhashtable_free_and_destroy(&scx_tid_hash, NULL, NULL);
>  
>  	if (ei->kind >= SCX_EXIT_ERROR) {
>  		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
> @@ -6553,6 +6625,17 @@ static int validate_ops(struct scx_sched
>  	}
>  
>  	/*
> +	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
> +	 * may set it to declare a dependency; reject if the root hasn't
> +	 * enabled it.
> +	 */
> +	if ((ops->flags & SCX_OPS_TID_TO_TASK) && scx_parent(sch) &&
> +	    !(scx_root->ops.flags & SCX_OPS_TID_TO_TASK)) {
> +		scx_error(sch, "SCX_OPS_TID_TO_TASK requires root scheduler to enable it");
> +		return -EINVAL;
> +	}
> +
> +	/*
>  	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
>  	 * selection policy to be enabled.
>  	 */
> @@ -6602,13 +6685,19 @@ static void scx_root_enable_workfn(struc
>  	if (ret)
>  		goto err_unlock;
>  
> +	if (ops->flags & SCX_OPS_TID_TO_TASK) {
> +		ret = rhashtable_init(&scx_tid_hash, &scx_tid_hash_params);
> +		if (ret)
> +			goto err_free_ksyncs;
> +	}
> +
>  #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>  	cgroup_get(cgrp);
>  #endif
>  	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -		goto err_free_ksyncs;
> +		goto err_free_tid_hash;
>  	}
>  
>  	/*
> @@ -6697,6 +6786,10 @@ static void scx_root_enable_workfn(struc
>  	WARN_ON_ONCE(scx_init_task_enabled);
>  	scx_init_task_enabled = true;
>  
> +	/* flip under fork_rwsem; the iter below covers existing tasks */
> +	if (ops->flags & SCX_OPS_TID_TO_TASK)
> +		static_branch_enable(&__scx_tid_to_task_enabled);
> +
>  	/*
>  	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
>  	 * preventing new tasks from being added. No need to exclude tasks
> @@ -6740,6 +6833,17 @@ static void scx_root_enable_workfn(struc
>  		scx_set_task_sched(p, sch);
>  		scx_set_task_state(p, SCX_TASK_READY);
>  
> +		/*
> +		 * Insert into the tid hash under scx_tasks_lock so we can't
> +		 * race sched_ext_dead() and leave a stale entry for an already
> +		 * exited task.
> +		 */
> +		if (scx_tid_to_task_enabled()) {
> +			guard(raw_spinlock_irq)(&scx_tasks_lock);
> +			if (!list_empty(&p->scx.tasks_node))
> +				scx_tid_hash_insert(p);
> +		}
> +
>  		put_task_struct(p);
>  	}
>  	scx_task_iter_stop(&sti);
> @@ -6799,6 +6903,9 @@ static void scx_root_enable_workfn(struc
>  	cmd->ret = 0;
>  	return;
>  
> +err_free_tid_hash:
> +	if (ops->flags & SCX_OPS_TID_TO_TASK)
> +		rhashtable_free_and_destroy(&scx_tid_hash, NULL, NULL);
>  err_free_ksyncs:
>  	free_kick_syncs();
>  err_unlock:
> @@ -9288,6 +9395,34 @@ __bpf_kfunc struct task_struct *scx_bpf_
>  }
>  
>  /**
> + * scx_bpf_tid_to_task - Look up a task by its scx tid
> + * @tid: task ID previously read from p->scx.tid
> + *
> + * Returns the task with the given tid, or NULL if no such task exists. The
> + * returned pointer is valid until the end of the current RCU read section
> + * (KF_RCU_PROTECTED). Requires SCX_OPS_TID_TO_TASK to be set on the root
> + * scheduler; otherwise an error is raised and NULL returned.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
> +{
> +	struct sched_ext_entity *scx;
> +
> +	if (!scx_tid_to_task_enabled()) {
> +		struct scx_sched *sch = rcu_dereference(scx_root);
> +
> +		if (sch)
> +			scx_error(sch, "scx_bpf_tid_to_task() called without SCX_OPS_TID_TO_TASK");
> +		return NULL;
> +	}
> +
> +	scx = rhashtable_lookup(&scx_tid_hash, &tid, scx_tid_hash_params);
> +	if (!scx)
> +		return NULL;
> +
> +	return container_of(scx, struct task_struct, scx);
> +}
> +
> +/**
>   * scx_bpf_now - Returns a high-performance monotonically non-decreasing
>   * clock for the current CPU. The clock returned is in nanoseconds.
>   *
> @@ -9470,6 +9605,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, scx_bpf_tid_to_task, KF_RET_NULL | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_now)
>  BTF_ID_FLAGS(func, scx_bpf_events)
>  #ifdef CONFIG_CGROUP_SCHED
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -13,6 +13,9 @@ enum scx_consts {
>  	SCX_DSP_MAX_LOOPS		= 32,
>  	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
>  
> +	/* per-CPU chunk size for p->scx.tid allocation, see scx_alloc_tid() */
> +	SCX_TID_CHUNK			= 1024,
> +
>  	SCX_EXIT_BT_LEN			= 64,
>  	SCX_EXIT_MSG_LEN		= 1024,
>  	SCX_EXIT_DUMP_DFL_LEN		= 32768,
> @@ -138,7 +141,8 @@ enum scx_ops_flags {
>  	 * To mask this problem, by default, unhashed tasks are automatically
>  	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
>  	 * depend on pid lookups and wants to handle these tasks directly, the
> -	 * following flag can be used.
> +	 * following flag can be used. With %SCX_OPS_TID_TO_TASK,
> +	 * scx_bpf_tid_to_task() can find exiting tasks reliably.
>  	 */
>  	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
>  
> @@ -189,6 +193,17 @@ enum scx_ops_flags {
>  	 */
>  	SCX_OPS_ALWAYS_ENQ_IMMED	= 1LLU << 7,
>  
> +	/*
> +	 * Maintain a mapping from p->scx.tid to task_struct so the BPF
> +	 * scheduler can recover task pointers from stored tids via
> +	 * scx_bpf_tid_to_task().
> +	 *
> +	 * Only the root scheduler turns this on. A sub-sched may set the flag
> +	 * to declare a dependency on the lookup; if the root scheduler hasn't
> +	 * enabled it, attaching the sub-sched is rejected.
> +	 */
> +	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
> +
>  	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
>  					  SCX_OPS_ENQ_LAST |
>  					  SCX_OPS_ENQ_EXITING |
> @@ -196,7 +211,8 @@ enum scx_ops_flags {
>  					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  					  SCX_OPS_SWITCH_PARTIAL |
>  					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> -					  SCX_OPS_ALWAYS_ENQ_IMMED,
> +					  SCX_OPS_ALWAYS_ENQ_IMMED |
> +					  SCX_OPS_TID_TO_TASK,
>  
>  	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
>  	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -99,6 +99,7 @@ s32 scx_bpf_task_cpu(const struct task_s
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_locked_rq(void) __ksym;
>  struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
> +struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
>  u64 scx_bpf_now(void) __ksym __weak;
>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
>  
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -127,7 +127,8 @@ struct task_ctx {
>  	struct task_ctx __arena	*q_next;	/* queue link, NULL if tail */
>  	struct task_ctx __arena	*q_prev;	/* queue link, NULL if head */
>  	struct qmap_fifo __arena *fifo;		/* queue we're on, NULL if not queued */
> -	s32			pid;
> +	u64			tid;
> +	s32			pid;	/* for dump only */
>  	bool			force_local;	/* Dispatch directly to local_dsq */
>  	bool			highpri;
>  	u64			core_sched_seq;
> @@ -547,7 +548,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
>  			if (!taskc)
>  				break;
>  
> -			p = bpf_task_from_pid(taskc->pid);
> +			p = scx_bpf_tid_to_task(taskc->tid);
>  			if (!p)
>  				continue;
>  
> @@ -598,8 +599,6 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
>  			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
>  				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
>  
> -			bpf_task_release(p);
> -
>  			batch--;
>  			cpuc->dsp_cnt--;
>  			if (!batch || !scx_bpf_dispatch_nr_slots()) {
> @@ -724,6 +723,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_t
>  	taskc->q_next = NULL;
>  	taskc->q_prev = NULL;
>  	taskc->fifo = NULL;
> +	taskc->tid = p->scx.tid;
>  	taskc->pid = p->pid;
>  	taskc->force_local = false;
>  	taskc->highpri = false;
> @@ -776,7 +776,7 @@ void BPF_STRUCT_OPS(qmap_dump, struct sc
>  	/*
>  	 * Walk the queue lists without locking - kfunc calls (scx_bpf_dump)
>  	 * aren't in the verifier's kfunc_spin_allowed() list so we can't hold
> -	 * a lock and dump. Best-effort; racing may print stale pids but the
> +	 * a lock and dump. Best-effort; racing may print stale tids but the
>  	 * walk is bounded by bpf_repeat() so it always terminates.
>  	 */
>  	bpf_for(i, 0, 5) {
> @@ -785,7 +785,7 @@ void BPF_STRUCT_OPS(qmap_dump, struct sc
>  		bpf_repeat(4096) {
>  			if (!taskc)
>  				break;
> -			scx_bpf_dump(" %d", taskc->pid);
> +			scx_bpf_dump(" %d:%llu", taskc->pid, taskc->tid);
>  			taskc = taskc->q_next;
>  		}
>  		scx_bpf_dump("\n");
> @@ -1159,6 +1159,7 @@ void BPF_STRUCT_OPS(qmap_sub_detach, str
>  }
>  
>  SCX_OPS_DEFINE(qmap_ops,
> +	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
>  	       .select_cpu		= (void *)qmap_select_cpu,
>  	       .enqueue			= (void *)qmap_enqueue,
>  	       .dequeue			= (void *)qmap_dequeue,

-- 
Cheers,
Cheng-Yang
