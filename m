Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464B492185
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831361; cv=none; b=O9eCRPycglYnexuTuWOg6uvjoNmQL77Dz7lyLbVwmIhNL6kKwmEyqEwuUGel2xQmVdRtE8neGSK1v550TT/eu5X+QvISh/bvp4cJbkT2WKYh+XmWdOzijch50DR8IY8PonLHBhxMvHQSlVwJLhFUkSckn0U5E4PQ6zPxuId/RCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831361; c=relaxed/simple;
	bh=JDdLDrRCDTZBKVmw3n5NK786r0Eg5MDC/uY74iYc2mo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ZR7qsRX2v18oBTyCUbVnTsil7c5SxyzHAOmfiLP5ghr3dnD3NoQtf2h/AmCS1BnmZRJtudrIExjBn0fWlV3FoCq0vEx7qp8rJhoPLNvAHhm7NwvxdGARKMcwbJK+hGGNcuRx9IrxS2aiOJA3b52kcqbFmn9sm5bmxsttowv1j5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hzRTgLI5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hzRTgLI5"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-508fe217a44so4649421cf.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772831355; x=1773436155; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8PaeZhBJKFwWcc3eumfEq1eMgqmDoF5z6N5AUW84Qs=;
        b=hzRTgLI5hP1q4yR3o5sFv8pddL6O7BBDZYN/zSLnLA6AEXe1Bf4Y6zxOfZUxCowKiz
         O1M5cqezzgHDsDDOUgEx9aQ8TqWYJtDHEwVp4nzfv0vVmBFuFSUXMJUyJsCieT3BR4EA
         tuBNhrvMNC4MmPZMKbrqwGid/FfrXZmVAmipBME1aYN2LTzkLu9t7kWO5grUNR7vLy8g
         LsZzpiwO7Y2rNipTK+jxsMo8LzlI2yJdSsPuGJQk4P1qbtM3Q9g0C9yYFtwTv39qHQA9
         mBX4/LqNceG2v4BR1+qboCRvK4OhQa9yXOpWFbGQJfXUPKHH1hUL/xLSElvaFKKWXnl6
         Y/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831355; x=1773436155;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8PaeZhBJKFwWcc3eumfEq1eMgqmDoF5z6N5AUW84Qs=;
        b=n+dhC8HsL3mDq+gGgrQzXF0TO347vKNIqcsAzGVklbtIiiXdTNKbJZRS9XVzUa/bWW
         LcC50R/dm2OsQzVXKnY/jfpdve+zvEui4xnMPk4VXqqx1bN6gS57xL2cqm56UhbEtcdY
         W9gXOroNeMsFTarT7LE6/Kvf8BVlqqyI8lvEkkIlzAfVYX3PfuWNjvpVnmwIcZjdNOGs
         3W7rYNRN31a7cFomH2T368tbsOBLTcKSzZ8F58q3MgLLyvWfZbSJImGoEMzQcVCjGSYg
         lS0BGlmhAyhhEs/WlzdU0qhdk1kdtsc1KyAgVQ2RZu34ZDy+Oots2JF4+uFEiWD7U1U1
         cGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVCYFgG+c4KezNUX37iq7AJtE8dN7kacbZQEn9MMchgMlC/TW+G6vYP7fMLZjF0QO09l0xLqLMMa0k=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXJxJa+DvZBZ5s24DS/UvFzkN8Xu1sj+5UFAHKDDHt5Id6bpEZ
	jWy8b8N0nfEyZOhUryUs81EonKpMaJlpcQtB0sPr3toz97+leqJv8kEWSIEpF1rFEk0=
X-Gm-Gg: ATEYQzw1sA4BTU0osxtHqeUXwxqePGdScgxrb7NWOm4w77OQtCyU27i65+ACGDTJY0T
	mFFxQ9TUDMQ6STBTsd+bLGY+H52fNgCdP0ySiEQZQstu04KbEK9OUotsASmckzEh3LAR1W0V47U
	eL1phcZlnkuKwqMD8EUYxmlqOoFDLvqRuofmLyvooeEtuuFuUdLNNFxqsexW4OWtxeWmEVlE8wp
	RaRXLs64w6Op6ZegQlY6WKOu7tI57M8AmDamn3HtaETJ3ugOKHvTXbmhj/dU9ETB1LEiHVJjL4l
	sP9dmaGI0Z25gnRuAfQn5h7SpZcnmZc2Wb5POSz6TANQQ/eEBgyfd90VWMtxg44imAEstiHI7dV
	0xr86ysVaVBcJwlwx3Tr4m+iGTcHaoLV7J56FM2kgDihnp7KPE7j/5+9PJ+hnglopldpOxxKR9O
	+pEkS4WwCU+oEQuvoEhf1IP60=
X-Received: by 2002:a05:622a:1ba3:b0:504:3c8f:f9bf with SMTP id d75a77b69052e-508f49697c4mr45505741cf.74.1772831355211;
        Fri, 06 Mar 2026 13:09:15 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316da913sm24965146d6.29.2026.03.06.13.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 16:09:13 -0500
Message-Id: <DGW09KIXQWOQ.1ZY3NV5EJO62S@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 05/15] sched_ext: Relocate reenq_local() and
 run_deferred()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-6-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-6-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Previously, both process_ddsp_deferred_locals() and reenq_local() require=
d
> forward declarations. Reorganize so that only run_deferred() needs to be
> declared. This reduces forward declaration clutter and will ease adding m=
ore
> to the run_deferred() path.
>
> No functional changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 132 ++++++++++++++++++++++-----------------------
>  1 file changed, 65 insertions(+), 67 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c44893878878..1b6cd1e4f8b9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -193,9 +193,8 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load bala=
nce interval in microsecond
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
> =20
> -static void process_ddsp_deferred_locals(struct rq *rq);
> +static void run_deferred(struct rq *rq);
>  static bool task_dead_and_done(struct task_struct *p);
> -static u32 reenq_local(struct scx_sched *sch, struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>  static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
>  static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> @@ -1003,23 +1002,6 @@ static int ops_sanitize_err(struct scx_sched *sch,=
 const char *ops_name, s32 err
>  	return -EPROTO;
>  }
> =20
> -static void run_deferred(struct rq *rq)
> -{
> -	process_ddsp_deferred_locals(rq);
> -
> -	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
> -		struct llist_node *llist =3D
> -			llist_del_all(&rq->scx.deferred_reenq_locals);
> -		struct scx_sched_pcpu *pos, *next;
> -
> -		llist_for_each_entry_safe(pos, next, llist,
> -					  deferred_reenq_locals_node) {
> -			init_llist_node(&pos->deferred_reenq_locals_node);
> -			reenq_local(pos->sch, rq);
> -		}
> -	}
> -}
> -
>  static void deferred_bal_cb_workfn(struct rq *rq)
>  {
>  	run_deferred(rq);
> @@ -3072,7 +3054,6 @@ static void rq_offline_scx(struct rq *rq)
>  	rq->scx.flags &=3D ~SCX_RQ_ONLINE;
>  }
> =20
> -
>  static bool check_rq_for_timeouts(struct rq *rq)
>  {
>  	struct scx_sched *sch;
> @@ -3612,6 +3593,70 @@ int scx_check_setscheduler(struct task_struct *p, =
int policy)
>  	return 0;
>  }
> =20
> +static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
> +{
> +	LIST_HEAD(tasks);
> +	u32 nr_enqueued =3D 0;
> +	struct task_struct *p, *n;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * The BPF scheduler may choose to dispatch tasks back to
> +	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
> +	 * first to avoid processing the same tasks repeatedly.
> +	 */
> +	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
> +				 scx.dsq_list.node) {
> +		struct scx_sched *task_sch =3D scx_task_sched(p);
> +
> +		/*
> +		 * If @p is being migrated, @p's current CPU may not agree with
> +		 * its allowed CPUs and the migration_cpu_stop is about to
> +		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
> +		 *
> +		 * While racing sched property changes may also dequeue and
> +		 * re-enqueue a migrating task while its current CPU and allowed
> +		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
> +		 * the current local DSQ for running tasks and thus are not
> +		 * visible to the BPF scheduler.
> +		 */
> +		if (p->migration_pending)
> +			continue;
> +
> +		if (!scx_is_descendant(task_sch, sch))
> +			continue;
> +
> +		dispatch_dequeue(rq, p);
> +		list_add_tail(&p->scx.dsq_list.node, &tasks);
> +	}
> +
> +	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
> +		list_del_init(&p->scx.dsq_list.node);
> +		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> +		nr_enqueued++;
> +	}
> +
> +	return nr_enqueued;
> +}
> +
> +static void run_deferred(struct rq *rq)
> +{
> +	process_ddsp_deferred_locals(rq);
> +
> +	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
> +		struct llist_node *llist =3D
> +			llist_del_all(&rq->scx.deferred_reenq_locals);
> +		struct scx_sched_pcpu *pos, *next;
> +
> +		llist_for_each_entry_safe(pos, next, llist,
> +					  deferred_reenq_locals_node) {
> +			init_llist_node(&pos->deferred_reenq_locals_node);
> +			reenq_local(pos->sch, rq);
> +		}
> +	}
> +}
> +
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> @@ -7702,53 +7747,6 @@ static const struct btf_kfunc_id_set scx_kfunc_set=
_dispatch =3D {
>  	.set			=3D &scx_kfunc_ids_dispatch,
>  };
> =20
> -static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
> -{
> -	LIST_HEAD(tasks);
> -	u32 nr_enqueued =3D 0;
> -	struct task_struct *p, *n;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	/*
> -	 * The BPF scheduler may choose to dispatch tasks back to
> -	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
> -	 * first to avoid processing the same tasks repeatedly.
> -	 */
> -	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
> -				 scx.dsq_list.node) {
> -		struct scx_sched *task_sch =3D scx_task_sched(p);
> -
> -		/*
> -		 * If @p is being migrated, @p's current CPU may not agree with
> -		 * its allowed CPUs and the migration_cpu_stop is about to
> -		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
> -		 *
> -		 * While racing sched property changes may also dequeue and
> -		 * re-enqueue a migrating task while its current CPU and allowed
> -		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
> -		 * the current local DSQ for running tasks and thus are not
> -		 * visible to the BPF scheduler.
> -		 */
> -		if (p->migration_pending)
> -			continue;
> -
> -		if (!scx_is_descendant(task_sch, sch))
> -			continue;
> -
> -		dispatch_dequeue(rq, p);
> -		list_add_tail(&p->scx.dsq_list.node, &tasks);
> -	}
> -
> -	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
> -		list_del_init(&p->scx.dsq_list.node);
> -		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> -		nr_enqueued++;
> -	}
> -
> -	return nr_enqueued;
> -}
> -
>  __bpf_kfunc_start_defs();
> =20
>  /**

