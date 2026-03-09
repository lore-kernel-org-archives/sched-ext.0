Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CF2D6E72
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077590; cv=none; b=LMLyROnDYrgIA+ZvmQGEf6vqy2hQDMg8ZPToM8iCNsCeaEGO9rGusKoEHe+aD1I6b6rcHru5fesBmZQVbPqfQk+hd4XCp98QLSH37eAGs5Cbaf4JxLsHqFgaMCwBJ97+9CxE9mOXS6kI745RxII4wdR7sNm2rgRh9ngs6fFSjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077590; c=relaxed/simple;
	bh=KnfiiN24tiN80/aEdFSJMs2igi9DgjmlqJ7y5LrNr0s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=FYiTljZtesQmukv4MMsHSa+HNfVTlqklv8m7dOLDIZkbHhJOczEC36b1otflxROhIe+s/LPabjRE65I0kpMxLw7kdSNkicWB8fBu9DbFyoiUD45qcFFrvBooU+/6idw2oLcUhCd/EV+ZSIJiecwta1iTWbsZo+ao33mEwzLuy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=cX9U9QRn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="cX9U9QRn"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-509101189f4so13212091cf.1
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773077588; x=1773682388; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y+XQW6dHwpAogIPkAAA41N3BPHzL4uWFA8t/rq7Vaw=;
        b=cX9U9QRnz+EBd5PdevxKVj0n+NfHITRf0+cXrf40ArPH1jcsRd3UczfjIDt1BcQShj
         PcZLcF9SrdEZUhB7gkMb4u4i6ZKjShDWcplJt2X5d9GoFIQgJ7xhTUdbA5XK4vHjgCZS
         D1h2BolcNcNWqyjyJxJKVm46+JoQGFQ79Q+yxvQ+uJ2HMfEN5dqC48B9qZmvEHsI/3KH
         CmjUgjNLG8hp6ajBb888HaRWBZf2lp04wXN93qU7K6r2utKS8KFeXMvSog9aq0fBPXug
         QTuPmx68tvUwdPDwB6v9SZOd2c+VJ57KlIa/Ap88fJ5/9TgHCPKGn7jciFmoA1Nt7fiS
         r+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077588; x=1773682388;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Y+XQW6dHwpAogIPkAAA41N3BPHzL4uWFA8t/rq7Vaw=;
        b=ZbEyaA8ftHjFprq/7I4opUGSe5rz+tPwWt3ZCPu2Z9jT1Wiu9ReP/PYmg9rDjla0O0
         W8u2SeZls99mV7IlCMhMWtoI1X29QRlfMh24gQ4SXT+m0Ugwh3C/0SA2I+EomZNx1wzS
         BNYzZZ4a4/JZhEib+fQw8daksAR8EVL/ugtDT8ID8Ll39m67nldYue/JOU7PcrQfLruw
         odQHvZIh3aYCgZ1DiAQeSWv2OUt3P6LGQArFhxD094FKWAETch2AGALzvzX4EB7GgxHj
         DMiXG6pVw+jNI9a8IVOnsi/o6ndnlRT/xcHjJ4feBOpGgpbApE3Hd/Y0YIvC/qOJtEcg
         3ypg==
X-Forwarded-Encrypted: i=1; AJvYcCUWScUlOk+xowiHBgTieSGjivQ4d0w6k7xZ0HoY/LxnmhL1eEy0ssuTkCZbA1enmnarBh/Czum3ZdI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6xRFwK9eWMTT/Htjhg5+KpG6pYCpmHmkWmaq36sekV4yBGkls
	lREUlmuTNrSOwSbre86vxH8PZdiXoJLi/ty8AT7LqOQB2oujmSYKf7MtMA1SC23oS90=
X-Gm-Gg: ATEYQzwa1ccQJ+Atl055/9Fe5IGKfnJtleuVLK83rDY1Pp1E8Sw3dfgU/8DSeOxLQvy
	5r6uJNrKsBGuXXhByw+N5rm/Thai3BGsD7sY+BE5y1RhPKUcrA1PIcxAJyUh+8YxDT8q7xBHTCv
	z7aWRuZr/+hysFnAgSJtqSjX8DLjKrC6e8MvlGl8vWWbKe9fcVicS85VnnVU4kn23b7EVm7++Vm
	kNTrznXfR8t9mvmH69JgGS9nz7nP8iOz94AEP5z1w8EcUBN8XJbvW/PFF+b3IQHykhTbedI9PWx
	2ZCWFuIobgxkpOyoSnSJzf4/auypBbAK85k678Z1P7T6RValcmsem9+vFrTJhUnu9yGHEULyst2
	4UTva9LYlhX65vdaJnXkElSnFKOgoj/IGCKbhFa0rVyst97O27l1HGPEsjwPCZOa7FO3j48938M
	0ytxFnFHoj+u061IX7ap24SOo=
X-Received: by 2002:ac8:7f11:0:b0:509:21c3:fa43 with SMTP id d75a77b69052e-50921c3fba9mr25707101cf.67.1773077587587;
        Mon, 09 Mar 2026 10:33:07 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a1817dsm2285636d6.4.2026.03.09.10.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 13:33:05 -0400
Message-Id: <DGYFJQ2SOLDI.27KTMALD2PMY0@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 08/15] sched_ext: Introduce scx_bpf_dsq_reenq() for
 remote local DSQ reenqueue
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-9-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-9-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> scx_bpf_reenqueue_local() can only trigger re-enqueue of the current CPU'=
s
> local DSQ. Introduce scx_bpf_dsq_reenq() which takes a DSQ ID and can tar=
get
> any local DSQ including remote CPUs via SCX_DSQ_LOCAL_ON | cpu. This will=
 be
> expanded to support user DSQs by future changes.
>
> scx_bpf_reenqueue_local() is reimplemented as a simple wrapper around
> scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0) and may be deprecated in the future.
>
> Update compat.bpf.h with a compatibility shim and scx_qmap to test the ne=
w
> functionality.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 118 ++++++++++++++---------
>  tools/sched_ext/include/scx/compat.bpf.h |  21 ++++
>  tools/sched_ext/scx_qmap.bpf.c           |  11 ++-
>  tools/sched_ext/scx_qmap.c               |   5 +-
>  4 files changed, 106 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 80d1e6ccc326..b02143b10f0f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1080,6 +1080,31 @@ static void schedule_deferred_locked(struct rq *rq=
)
>  	schedule_deferred(rq);
>  }
> =20
> +static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatc=
h_q *dsq)
> +{
> +	/*
> +	 * Allowing reenqueues doesn't make sense while bypassing. This also
> +	 * blocks from new reenqueues to be scheduled on dead scheds.
> +	 */
> +	if (unlikely(READ_ONCE(sch->bypass_depth)))
> +		return;
> +
> +	if (dsq->id =3D=3D SCX_DSQ_LOCAL) {
> +		struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
> +		struct scx_sched_pcpu *sch_pcpu =3D per_cpu_ptr(sch->pcpu, cpu_of(rq))=
;
> +		struct scx_deferred_reenq_local *drl =3D &sch_pcpu->deferred_reenq_loc=
al;
> +
> +		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
> +			if (list_empty(&drl->node))
> +				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
> +		}
> +
> +		schedule_deferred(rq);
> +	} else {
> +		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
> +	}
> +}
> +
>  /**
>   * touch_core_sched - Update timestamp used for core-sched task ordering
>   * @rq: rq to read clock from, must be locked
> @@ -7775,9 +7800,6 @@ __bpf_kfunc_start_defs();
>   * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
>   * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
>   * processed tasks. Can only be called from ops.cpu_release().
> - *
> - * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the v=
oid
> - * returning variant that can be called from anywhere.
>   */
>  __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
>  {
> @@ -8207,6 +8229,52 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u=
64 dsq_id,
>  	return rcu_dereference(dsq->first_task);
>  }
> =20
> +/**
> + * scx_bpf_dsq_reenq - Re-enqueue tasks on a DSQ
> + * @dsq_id: DSQ to re-enqueue
> + * @reenq_flags: %SCX_RENQ_*
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> + *
> + * Iterate over all of the tasks currently enqueued on the DSQ identifie=
d by
> + * @dsq_id, and re-enqueue them in the BPF scheduler. The following DSQs=
 are
> + * supported:
> + *
> + * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
> + *
> + * Re-enqueues are performed asynchronously. Can be called from anywhere=
.
> + */
> +__bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
> +				   const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	guard(preempt)();
> +
> +	sch =3D scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return;
> +
> +	dsq =3D find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id(=
));
> +	schedule_dsq_reenq(sch, dsq);
> +}
> +
> +/**
> + * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> + *
> + * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> + * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called=
 from
> + * anywhere.
> + *
> + * This is now a special case of scx_bpf_dsq_reenq() and may be removed =
in the
> + * future.
> + */
> +__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux =
*aux)
> +{
> +	scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0, aux);
> +}
> +
>  __bpf_kfunc_end_defs();
> =20
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *lin=
e_buf,
> @@ -8364,47 +8432,6 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsi=
gned long long *data,
>  		ops_dump_flush();
>  }
> =20
> -/**
> - * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> - * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
> - *
> - * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> - * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called=
 from
> - * anywhere.
> - */
> -__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux =
*aux)
> -{
> -	unsigned long flags;
> -	struct scx_sched *sch;
> -	struct rq *rq;
> -
> -	raw_local_irq_save(flags);
> -
> -	sch =3D scx_prog_sched(aux);
> -	if (unlikely(!sch))
> -		goto out_irq_restore;
> -
> -	/*
> -	 * Allowing reenqueue-locals doesn't make sense while bypassing. This
> -	 * also blocks from new reenqueues to be scheduled on dead scheds.
> -	 */
> -	if (unlikely(sch->bypass_depth))
> -		goto out_irq_restore;
> -
> -	rq =3D this_rq();
> -	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
> -		struct scx_sched_pcpu *pcpu =3D this_cpu_ptr(sch->pcpu);
> -
> -		if (list_empty(&pcpu->deferred_reenq_local.node))
> -			list_move_tail(&pcpu->deferred_reenq_local.node,
> -				       &rq->scx.deferred_reenq_locals);
> -	}
> -
> -	schedule_deferred(rq);
> -out_irq_restore:
> -	raw_local_irq_restore(flags);
> -}
> -
>  /**
>   * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
>   * @cpu: CPU of interest
> @@ -8821,13 +8848,14 @@ BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_=
ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_IMPLICIT_ARGS | KF_RCU_PROTECTED=
 | KF_RET_NULL)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_reenq, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_IMPLICIT_ARGS | KF_ITER_NEW =
| KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
> -BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index f2969c3061a7..2d3985be7e2c 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -375,6 +375,27 @@ static inline void scx_bpf_reenqueue_local(void)
>  		scx_bpf_reenqueue_local___v1();
>  }
> =20
> +/*
> + * v6.20: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. =
This
> + * will eventually deprecate scx_bpf_reenqueue_local().
> + */
> +void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags, const struc=
t bpf_prog_aux *aux__prog) __ksym __weak;
> +
> +static inline bool __COMPAT_has_generic_reenq(void)
> +{
> +	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
> +}
> +
> +static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
> +{
> +	if (bpf_ksym_exists(scx_bpf_dsq_reenq___compat))
> +		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags, NULL);
> +	else if (dsq_id =3D=3D SCX_DSQ_LOCAL && reenq_flags =3D=3D 0)
> +		scx_bpf_reenqueue_local();
> +	else
> +		scx_bpf_error("kernel too old to reenqueue foreign local or user DSQs"=
);
> +}
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variant=
s for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 91b8eac83f52..83e8289e8c0c 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -131,7 +131,7 @@ struct {
>  } cpu_ctx_stor SEC(".maps");
> =20
>  /* Statistics */
> -u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from=
_enq;
> +u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0, nr_de=
queued, nr_ddsp_from_enq;
>  u64 nr_core_sched_execed;
>  u64 nr_expedited_local, nr_expedited_remote, nr_expedited_lost, nr_exped=
ited_from_timer;
>  u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> @@ -206,8 +206,11 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
>  	void *ring;
>  	s32 cpu;
> =20
> -	if (enq_flags & SCX_ENQ_REENQ)
> +	if (enq_flags & SCX_ENQ_REENQ) {
>  		__sync_fetch_and_add(&nr_reenqueued, 1);
> +		if (scx_bpf_task_cpu(p) =3D=3D 0)
> +			__sync_fetch_and_add(&nr_reenqueued_cpu0, 1);
> +	}
> =20
>  	if (p->flags & PF_KTHREAD) {
>  		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
> @@ -561,6 +564,10 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct=
 task_struct *prev,
>  	case 2: /* SCHED_RR */
>  	case 6: /* SCHED_DEADLINE */
>  		scx_bpf_reenqueue_local();
> +
> +		/* trigger re-enqueue on CPU0 just to exercise LOCAL_ON */
> +		if (__COMPAT_has_generic_reenq())
> +			scx_bpf_dsq_reenq(SCX_DSQ_LOCAL_ON | 0, 0);
>  	}
> =20
>  	return 0;
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 5d762d10f4db..9252037284d3 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -137,9 +137,10 @@ int main(int argc, char **argv)
>  		long nr_enqueued =3D skel->bss->nr_enqueued;
>  		long nr_dispatched =3D skel->bss->nr_dispatched;
> =20
> -		printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq=3D%"PRIu64" deq=
=3D%"PRIu64" core=3D%"PRIu64" enq_ddsp=3D%"PRIu64"\n",
> +		printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq/cpu0=3D%"PRIu64=
"/%"PRIu64" deq=3D%"PRIu64" core=3D%"PRIu64" enq_ddsp=3D%"PRIu64"\n",
>  		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
> -		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
> +		       skel->bss->nr_reenqueued, skel->bss->nr_reenqueued_cpu0,
> +		       skel->bss->nr_dequeued,
>  		       skel->bss->nr_core_sched_execed,
>  		       skel->bss->nr_ddsp_from_enq);
>  		printf("         exp_local=3D%"PRIu64" exp_remote=3D%"PRIu64" exp_time=
r=3D%"PRIu64" exp_lost=3D%"PRIu64"\n",

