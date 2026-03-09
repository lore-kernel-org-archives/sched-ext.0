Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043143E0C47
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076598; cv=none; b=M+KMeUyhlXBWWkcix9i6Bn7sCqS/MSPg1wpFKkgKBal5biS9TvPRDNzNpij+4QREMMMVTuOWewusGYLJEbk/gw82RoOib10na8YDZ1ufhoAzv/SJc5faLzbihhXZoO3iZOEU+Z9xOLECC51SXVQdMCjcWzWhgoUAmamaVYq65X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076598; c=relaxed/simple;
	bh=crNMCA5ktD14zfVIv93hIx0X5o23M0NyvgXd2Axo92k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=RVtRNmR2wJFYbvTmcTbuiLo6pDj6LbuYp4qKHNTBxggNydSLTu/ZfybG5+lPoezUyaZidL59B4p9RV9+jIs7vJaLYGiG4Odhlddk6UsbT2NmNE8hLEJLTOjqv3ksNHTe1dd2J7Y7NPYbXspxxSHkmTlR4OrRvB2dvqvs7dtzKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gAsIjqJG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gAsIjqJG"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso95097485a.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773076595; x=1773681395; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8tMd3FX/RPteIzK+SdplhSGoomoGc/EUtMTOAmfBOM=;
        b=gAsIjqJGF8QgTnGXQM9zga912sVYliFUKLjJUlcGECjsmqhmYSrkyWVUhuzes1c/jc
         nd9h1Hsg89LqYSkiTRPQHgT4xRDV1QatIHSzLO2370C7i71H6mN3XNyck4qbN3zc5TNp
         Ddgv0906amnEQ8ffHdv9ocLCP0rc4lAyFhY6EuU23kq5J1yF887t3vTiZpsApHxJxltP
         OKk0VnCGZC95Gz/bURTazWurjn0Jk+Jo4y6CCDn1BtzQ9DGp8/2oXxZMuiF9VpcpoF12
         LINKwMA+Dmc2oyT+YrprdELEsIxeMpcwlru6gxWl0F31/k660oldNlnqSqBnIewUcyWe
         C/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076595; x=1773681395;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8tMd3FX/RPteIzK+SdplhSGoomoGc/EUtMTOAmfBOM=;
        b=E++U96dYckS208BZJJNfM9nA9FZykVavhCLBVrm1RVlqoLKSr2yhmfDyEnia++7FBZ
         HBiZ9cm/V0STv9BFsXQPRwQmzSrXo0dkwOronH66K63xz+AR4LysE/jsxq2KFCh066f4
         KDYrGgki8HyYOgzLvggHVz+oQwWmtyj5VhWRFS3yVXw3CIx21KuN/sVqkmAC+UHzJW3F
         rVjXhLronG5ATSRSw+FJS0YQZDcWSoOxxKDTNCHQs+4r+LY48VYCgwKVQYwrwqWMGpd5
         jEAU0a64US/1UP6oxzYTfLpNcrKRvvKu18hXoVwvIOocaKg5igTrkurSyu959ML/yoWE
         KgyA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcGc0+y4Vh3wqj1lLQ14x5MYa0HCOLfpVZuUL9dAtiJ+paShboFMzWkzhGQ2FdFzDSQMhvWIcqpo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4nZAh3VFxDmwNSqZl1ZrkJjY2iuIz6BQ2ssAH3SS0BYxi9qK7
	0Ha8A5r7UjsAElHSfpQ5Vzl3a9JT5KKqU25iwn14bDgp0gwI1blmxaAB87S2Lfbk9F0=
X-Gm-Gg: ATEYQzxgKkawMxopfnAZ154IWXyniRcwNMPF1sXpLOpBqv3WcRN5On0eEWXR9NPGCRd
	6rlHOeCKUq1YaTpp4fo0D0rOwWSTtELk5Y2mQS0B0BbmotpAmE7VBDsEXh9uOisab8Uu1NE4cLs
	tnJGT2VcDv0DNch7BmqxaKAVd/ibfW/LIbbbrQCmrC27puzDddi9O0tATARwJm0XSsPd1OvQPML
	yGv9nvwuUpZ58LfZ7d8MSgF4kuKqVUHVnNIPbUDmA1OExBqqmDVWdDOSFhwLDudQhVl7o+L9nWx
	b7Yhwne9+ALQDSNv7mA/oJgB3QBTQbZZfYzeB+BI118aOWXsx31rYyvTVi1h4h5yWLEOwEUXT0I
	wTOYFI4FJACKuuAcQSmT1LT4FW2pdSNfpbPQbx40E9O+A0Z8t150jO8OrZ9xNNj2N3EpMjhWJTK
	+6t+nvRlgmckKSVwTHiYkYOJs=
X-Received: by 2002:a05:620a:29cf:b0:8cb:678b:4877 with SMTP id af79cd13be357-8cd6d46a66amr1468528785a.57.1773076594886;
        Mon, 09 Mar 2026 10:16:34 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f54bb7csm704599385a.38.2026.03.09.10.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 13:16:33 -0400
Message-Id: <DGYF723KXAFB.5PZCNY3PKLJ1@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <sched-ext@lists.linux.dev>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 06/15] sched_ext: Convert deferred_reenq_locals from
 llist to regular list
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-7-tj@kernel.org>
 <DGYF3L29QDRO.367HHV8YV77QW@etsalapatis.com>
In-Reply-To: <DGYF3L29QDRO.367HHV8YV77QW@etsalapatis.com>

On Mon Mar 9, 2026 at 1:12 PM EDT, Emil Tsalapatis wrote:
> On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
>> The deferred reenqueue local mechanism uses an llist (lockless list) for
>> collecting schedulers that need their local DSQs re-enqueued. Convert to=
 a
>> regular list protected by a raw_spinlock.
>>
>> The llist was used for its lockless properties, but the upcoming changes=
 to
>> support remote reenqueue require more complex list operations that are
>> difficult to implement correctly with lockless data structures. A spinlo=
ck-
>> protected regular list provides the necessary flexibility.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
>> ---
>>  kernel/sched/ext.c          | 57 ++++++++++++++++++++++++-------------
>>  kernel/sched/ext_internal.h |  2 +-
>>  kernel/sched/sched.h        |  3 +-
>>  3 files changed, 41 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 1b6cd1e4f8b9..ffccaf04e34d 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -3640,23 +3640,37 @@ static u32 reenq_local(struct scx_sched *sch, st=
ruct rq *rq)
>>  	return nr_enqueued;
>>  }
>> =20
>> -static void run_deferred(struct rq *rq)
>> +static void process_deferred_reenq_locals(struct rq *rq)
>>  {
>> -	process_ddsp_deferred_locals(rq);
>> -
>> -	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
>> -		struct llist_node *llist =3D
>> -			llist_del_all(&rq->scx.deferred_reenq_locals);
>> -		struct scx_sched_pcpu *pos, *next;
>> +	lockdep_assert_rq_held(rq);
>> =20
>> -		llist_for_each_entry_safe(pos, next, llist,
>> -					  deferred_reenq_locals_node) {
>> -			init_llist_node(&pos->deferred_reenq_locals_node);
>> -			reenq_local(pos->sch, rq);
>> +	while (true) {
>> +		struct scx_sched *sch;
>> +
>> +		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
>> +			struct scx_sched_pcpu *sch_pcpu =3D
>> +				list_first_entry_or_null(&rq->scx.deferred_reenq_locals,
>> +							 struct scx_sched_pcpu,
>> +							 deferred_reenq_local_node);
>> +			if (!sch_pcpu)
>> +				return;
>> +
>> +			sch =3D sch_pcpu->sch;
>
> While both scx and sch_pcpu aren't used in this patch, they are useful
> for subsequent patches.
>

This comment was meant for the next patch in the series, sorry about
that. The review tag still applies.

>> +			list_del_init(&sch_pcpu->deferred_reenq_local_node);
>>  		}
>> +
>> +		reenq_local(sch, rq);
>>  	}
>>  }
>> =20
>> +static void run_deferred(struct rq *rq)
>> +{
>> +	process_ddsp_deferred_locals(rq);
>> +
>> +	if (!list_empty(&rq->scx.deferred_reenq_locals))
>> +		process_deferred_reenq_locals(rq);
>> +}
>> +
>>  #ifdef CONFIG_NO_HZ_FULL
>>  bool scx_can_stop_tick(struct rq *rq)
>>  {
>> @@ -4180,13 +4194,13 @@ static void scx_sched_free_rcu_work(struct work_=
struct *work)
>> =20
>>  	/*
>>  	 * $sch would have entered bypass mode before the RCU grace period. As
>> -	 * that blocks new deferrals, all deferred_reenq_locals_node's must be
>> +	 * that blocks new deferrals, all deferred_reenq_local_node's must be
>>  	 * off-list by now.
>>  	 */
>>  	for_each_possible_cpu(cpu) {
>>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
>> =20
>> -		WARN_ON_ONCE(llist_on_list(&pcpu->deferred_reenq_locals_node));
>> +		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local_node));
>>  	}
>> =20
>>  	free_percpu(sch->pcpu);
>> @@ -5799,7 +5813,7 @@ static struct scx_sched *scx_alloc_and_add_sched(s=
truct sched_ext_ops *ops,
>>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
>> =20
>>  		pcpu->sch =3D sch;
>> -		init_llist_node(&pcpu->deferred_reenq_locals_node);
>> +		INIT_LIST_HEAD(&pcpu->deferred_reenq_local_node);
>>  	}
>> =20
>>  	sch->helper =3D kthread_run_worker(0, "sched_ext_helper");
>> @@ -7126,7 +7140,8 @@ void __init init_sched_ext_class(void)
>>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KE=
RNEL, n));
>>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL,=
 n));
>>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n)=
);
>> -		init_llist_head(&rq->scx.deferred_reenq_locals);
>> +		raw_spin_lock_init(&rq->scx.deferred_reenq_lock);
>> +		INIT_LIST_HEAD(&rq->scx.deferred_reenq_locals);
>>  		rq->scx.deferred_irq_work =3D IRQ_WORK_INIT_HARD(deferred_irq_workfn)=
;
>>  		rq->scx.kick_cpus_irq_work =3D IRQ_WORK_INIT_HARD(kick_cpus_irq_workf=
n);
>> =20
>> @@ -8358,7 +8373,6 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(cons=
t struct bpf_prog_aux *aux)
>>  	unsigned long flags;
>>  	struct scx_sched *sch;
>>  	struct rq *rq;
>> -	struct llist_node *lnode;
>> =20
>>  	raw_local_irq_save(flags);
>> =20
>> @@ -8374,9 +8388,14 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(con=
st struct bpf_prog_aux *aux)
>>  		goto out_irq_restore;
>> =20
>>  	rq =3D this_rq();
>> -	lnode =3D &this_cpu_ptr(sch->pcpu)->deferred_reenq_locals_node;
>> -	if (!llist_on_list(lnode))
>> -		llist_add(lnode, &rq->scx.deferred_reenq_locals);
>> +	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
>> +		struct scx_sched_pcpu *pcpu =3D this_cpu_ptr(sch->pcpu);
>> +
>> +		if (list_empty(&pcpu->deferred_reenq_local_node))
>> +			list_move_tail(&pcpu->deferred_reenq_local_node,
>> +				       &rq->scx.deferred_reenq_locals);
>> +	}
>> +
>>  	schedule_deferred(rq);
>>  out_irq_restore:
>>  	raw_local_irq_restore(flags);
>> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
>> index 9e5ebd00ea0c..80d40a9c5ad9 100644
>> --- a/kernel/sched/ext_internal.h
>> +++ b/kernel/sched/ext_internal.h
>> @@ -965,7 +965,7 @@ struct scx_sched_pcpu {
>>  	 */
>>  	struct scx_event_stats	event_stats;
>> =20
>> -	struct llist_node	deferred_reenq_locals_node;
>> +	struct list_head	deferred_reenq_local_node;
>>  	struct scx_dispatch_q	bypass_dsq;
>>  #ifdef CONFIG_EXT_SUB_SCHED
>>  	u32			bypass_host_seq;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index ebe971d12cb8..0794852524e7 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -808,7 +808,8 @@ struct scx_rq {
>> =20
>>  	struct task_struct	*sub_dispatch_prev;
>> =20
>> -	struct llist_head	deferred_reenq_locals;
>> +	raw_spinlock_t		deferred_reenq_lock;
>> +	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of =
local DSQ */
>>  	struct balance_callback	deferred_bal_cb;
>>  	struct irq_work		deferred_irq_work;
>>  	struct irq_work		kick_cpus_irq_work;

