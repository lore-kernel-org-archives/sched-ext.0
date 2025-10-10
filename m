Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536D1C5F27
	for <sched-ext@lists.linux.dev>; Fri, 10 Oct 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101375; cv=none; b=mh9r7Ovb+OCNC5gOHRoYKUx9Cm3cmNh2dd9UIqRbpr/BwGzQ4ByxvLuOCLFctnla0lYdaEBN/+whCX3DXg3dECd6SfuM+DmyTdPzRgg8UXZxeQQarmUHVTTTUq2yPkJ7S4LZAqmKvYc8DNOHYlZX2NrhSCVc4qpSYbnxZbOpbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101375; c=relaxed/simple;
	bh=LXQ0ZKqzL6qLtYEGSWa1BRoPL1JcnDWHMUF6VWSGeSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kS5SJMltqes267scZj16QSOKECT2d3g5cNni93QSwzLaXX0cCr6jN4Oo5EVSp9v9Nii/M9GGzHBJbCWoSoNGs3/3uHxUN77+x7mzqztAJ4axen2bl0Pll0iHp8hiTTQUUzTEY9Wdrm2dSBde9ASMClfxuvXz0Vg+trMqw8tUg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhkbBNgW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhkbBNgW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760101373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf40ogENIfUOYPOu7bjlvcdHnuAHFYBIjeEto1R+RLk=;
	b=FhkbBNgWc+9JKvU4aKZenpj9K+Vp8Xrf60/W7WKYSMZTk/yC3jaDX3CkpbRWLzL25BrWm9
	N5Um0p12hIJ5xc2C/EEAQup/WPLWGjiSSSF7ZV1ME7E3iDHJ3ZHe84ZzmeO7Hob3eWXlbb
	XSdD+8MaqGdmbuaQK6Vt3+OOgOZWlZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-jszUASSSMWepZSLA4cDqgg-1; Fri,
 10 Oct 2025 09:02:50 -0400
X-MC-Unique: jszUASSSMWepZSLA4cDqgg-1
X-Mimecast-MFC-AGG-ID: jszUASSSMWepZSLA4cDqgg_1760101369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B271219560A1;
	Fri, 10 Oct 2025 13:02:48 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.193])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0411800282;
	Fri, 10 Oct 2025 13:02:46 +0000 (UTC)
Date: Fri, 10 Oct 2025 09:02:44 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <20251010130244.GB408475@pauld.westford.csb>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org>
 <aObkkKf_UCHySRGz@gpd4>
 <aOb1e7R1lAGVGH-2@slm.duckdns.org>
 <aOb3Hv0uPv9G7N33@slm.duckdns.org>
 <20251009120635.GA277792@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251009120635.GA277792@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GPqrvpb9UL7Wn_WUZRnEPJZvzVeXKiyR80CohXK1BUE_1760101369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 08:06:40AM -0400 Phil Auld wrote:
> Hi Tejun,
> 
> On Wed, Oct 08, 2025 at 01:43:26PM -1000 Tejun Heo wrote:
> > On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
> > boot because it exceeds the 32,768 byte percpu allocator limit.
> > 
> > Restructure to use DEFINE_PER_CPU() for the per-CPU pointers, with each CPU
> > pointing to its own kvzalloc'd array. Move allocation from boot time to
> > scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
> > consumed when sched_ext is active.
> > 
> > Use RCU to guard against racing with free. Arrays are freed via call_rcu()
> > and kick_cpus_irq_workfn() uses rcu_dereference_bh() with a NULL check.
> > 
> > While at it, rename to scx_kick_pseqs for brevity and update comments to
> > clarify these are pick_task sequence numbers.
> > 
> > v2: RCU protect scx_kick_seqs to manage kick_cpus_irq_workfn() racing
> >     against disable as per Andrea.
> > 
> > v3: Fix bugs notcied by Andrea.
> 
> This looks good to me.  The original patch of course did solve
> the boot issue. They aren't using scx so there were no other issues
> seen. I've kicked off a build with this version and will try to
> get that booted on the large system as well. It should solve that
> problem just as well as the original one obviously.
>

Just to follow up: as expected this also boots on the 5220 cpu
system. 


Cheers,
Phil


> Thanks for the quick turn around.
> 
> I'm not going to offer a Tested tag since it was only boot tested
> (with no scx use) on the large system. And all that really tests
> is the 5 lines removed from init_sched_ext_class...
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> 
> 
> Cheers,
> Phil
> 
> > 
> > Reported-by: Phil Auld <pauld@redhat.com>
> > Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 89 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 79 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 2b0e88206d07..01010c3378b0 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -67,8 +67,19 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
> >  
> >  static struct delayed_work scx_watchdog_work;
> >  
> > -/* for %SCX_KICK_WAIT */
> > -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> > +/*
> > + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task sequence
> > + * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
> > + * allocator limits on large machines. O(nr_cpu_ids^2) allocation, allocated
> > + * lazily when enabling and freed when disabling to avoid waste when sched_ext
> > + * isn't active.
> > + */
> > +struct scx_kick_pseqs {
> > +	struct rcu_head		rcu;
> > +	unsigned long		seqs[];
> > +};
> > +
> > +static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
> >  
> >  /*
> >   * Direct dispatch marker.
> > @@ -3850,6 +3861,27 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
> >  	}
> >  }
> >  
> > +static void free_kick_pseqs_rcu(struct rcu_head *rcu)
> > +{
> > +	struct scx_kick_pseqs *pseqs = container_of(rcu, struct scx_kick_pseqs, rcu);
> > +
> > +	kvfree(pseqs);
> > +}
> > +
> > +static void free_kick_pseqs(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> > +		struct scx_kick_pseqs *to_free;
> > +
> > +		to_free = rcu_replace_pointer(*pseqs, NULL, true);
> > +		if (to_free)
> > +			call_rcu(&to_free->rcu, free_kick_pseqs_rcu);
> > +	}
> > +}
> > +
> >  static void scx_disable_workfn(struct kthread_work *work)
> >  {
> >  	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
> > @@ -3986,6 +4018,7 @@ static void scx_disable_workfn(struct kthread_work *work)
> >  	free_percpu(scx_dsp_ctx);
> >  	scx_dsp_ctx = NULL;
> >  	scx_dsp_max_batch = 0;
> > +	free_kick_pseqs();
> >  
> >  	mutex_unlock(&scx_enable_mutex);
> >  
> > @@ -4348,6 +4381,33 @@ static void scx_vexit(struct scx_sched *sch,
> >  	irq_work_queue(&sch->error_irq_work);
> >  }
> >  
> > +static int alloc_kick_pseqs(void)
> > +{
> > +	int cpu;
> > +
> > +	/*
> > +	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
> > +	 * can exceed percpu allocator limits on large machines.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> > +		struct scx_kick_pseqs *new_pseqs;
> > +
> > +		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
> > +
> > +		new_pseqs = kvzalloc_node(struct_size(new_pseqs, seqs, nr_cpu_ids),
> > +					  GFP_KERNEL, cpu_to_node(cpu));
> > +		if (!new_pseqs) {
> > +			free_kick_pseqs();
> > +			return -ENOMEM;
> > +		}
> > +
> > +		rcu_assign_pointer(*pseqs, new_pseqs);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
> >  {
> >  	struct scx_sched *sch;
> > @@ -4490,15 +4550,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  
> >  	mutex_lock(&scx_enable_mutex);
> >  
> > +	ret = alloc_kick_pseqs();
> > +	if (ret)
> > +		goto err_unlock;
> > +
> >  	if (scx_enable_state() != SCX_DISABLED) {
> >  		ret = -EBUSY;
> > -		goto err_unlock;
> > +		goto err_free_pseqs;
> >  	}
> >  
> >  	sch = scx_alloc_and_add_sched(ops);
> >  	if (IS_ERR(sch)) {
> >  		ret = PTR_ERR(sch);
> > -		goto err_unlock;
> > +		goto err_free_pseqs;
> >  	}
> >  
> >  	/*
> > @@ -4701,6 +4765,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  
> >  	return 0;
> >  
> > +err_free_pseqs:
> > +	free_kick_pseqs();
> >  err_unlock:
> >  	mutex_unlock(&scx_enable_mutex);
> >  	return ret;
> > @@ -5082,10 +5148,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
> >  {
> >  	struct rq *this_rq = this_rq();
> >  	struct scx_rq *this_scx = &this_rq->scx;
> > -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> > +	struct scx_kick_pseqs __rcu *pseqs_pcpu = __this_cpu_read(scx_kick_pseqs);
> >  	bool should_wait = false;
> > +	unsigned long *pseqs;
> >  	s32 cpu;
> >  
> > +	if (unlikely(!pseqs_pcpu)) {
> > +		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_pseqs");
> > +		return;
> > +	}
> > +
> > +	pseqs = rcu_dereference_bh(pseqs_pcpu)->seqs;
> > +
> >  	for_each_cpu(cpu, this_scx->cpus_to_kick) {
> >  		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
> >  		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> > @@ -5208,11 +5282,6 @@ void __init init_sched_ext_class(void)
> >  
> >  	scx_idle_init_masks();
> >  
> > -	scx_kick_cpus_pnt_seqs =
> > -		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> > -			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
> > -	BUG_ON(!scx_kick_cpus_pnt_seqs);
> > -
> >  	for_each_possible_cpu(cpu) {
> >  		struct rq *rq = cpu_rq(cpu);
> >  		int  n = cpu_to_node(cpu);
> > -- 
> > 2.51.0
> > 
> 
> -- 

-- 

