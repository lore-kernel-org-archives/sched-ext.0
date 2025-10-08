Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3D225791
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922601; cv=none; b=VqaoixRHP3tdQEomxUU6mEzUgU6zr9FyjTSnLOeOLYniH0/FNsJ9eFi9Jot8V4L3iVGAF/65obsIHQVU22VtIT4A3xXSy3A5ZLXPFK/5rI8kQtY3vxhfZswO4dULDWiHPIwQG+iejAy40RMkZN1+mdrzKLVrKqQVTDJpV1M0U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922601; c=relaxed/simple;
	bh=KxxbJPJreNgpREsl+UIMou7zPfsQ7i/KcDifHUEaR/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SlVMBz0zl6tEp9NvMmLhyoxwvc2o0RlfkBqFblghyRU7UqR9selwHyhMiznsv2GaNhaCbJ2VijTIcml3OOZpdEGWMkzOp4NxskMJTc9c6TG8ZkV5W+cPBgklmFkqZIsXLtyWEUWbYfgrxbwOAbFcOk4SyL8AYvWuVNTJckUPkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vp/5vkmF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vp/5vkmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759922598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjK0x7VkR55zw2tDVfBXgmVZOJtRweevFKYIMOvdWcE=;
	b=Vp/5vkmF8BhbBCAayTiTHIs/XyIkpVzrMRtC9Q3hf6GxoRp23HN6+3DSw9a9CJbG8YZ7yJ
	nPjihKChY0UuqfubBH06hmCuyzMG4Qt4k1n+8aExH1WcHGYItffEbJoUH/c5sOxhMW6zHR
	/Mje0fsor3b5qND7mO7ZdMOap/q90/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-QTqSDJMNOGO29Z7AsojmoA-1; Wed,
 08 Oct 2025 07:23:13 -0400
X-MC-Unique: QTqSDJMNOGO29Z7AsojmoA-1
X-Mimecast-MFC-AGG-ID: QTqSDJMNOGO29Z7AsojmoA_1759922592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4671800451;
	Wed,  8 Oct 2025 11:23:11 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.80])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B7BA19560A2;
	Wed,  8 Oct 2025 11:23:09 +0000 (UTC)
Date: Wed, 8 Oct 2025 07:23:06 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: sched_ext and large cpu counts
Message-ID: <20251008112306.GA177858@pauld.westford.csb>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -a6JqBgFQAWyirfYe1CPZuSDj96ENUcHzudLtFADAp8_1759922592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 04:37:24PM -1000 Tejun Heo wrote:
> Hello,
> 
> Can you please see whether the following patch resolves the problem?
>

Yes, thanks, I'll do that. It may take a little time since they have
not given me such a machine.  I'll built it and pass it on to the
partner to test it.  My take a few days to turn around. 


Cheers,
Phil

> Thanks.
> 
> --
> tejun
> 
> ----- 8< -----
> From 4d7f7d24e90fba47bb08ddbeb8668123b4bbab1b Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Tue, 7 Oct 2025 16:23:43 -1000
> Subject: [PATCH] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using
>  kvzalloc()
> 
> On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
> boot because it exceeds the 32,768 byte percpu allocator limit. The allocation
> size is sizeof(unsigned long) * nr_cpu_ids, which becomes 33,792 bytes with
> 4224 CPUs.
> 
> Restructure scx_kick_cpus_pnt_seqs to use DEFINE_PER_CPU() for the per-CPU
> pointers, with each CPU pointing to its own kvzalloc'd array. This avoids
> percpu allocator size limits. Additionally, move allocation from boot time to
> scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
> consumed when sched_ext is active.
> 
> Reported-by: Phil Auld <pauld@redhat.com>
> Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 59 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..042fc73fb141 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -67,8 +67,13 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
>  
>  static struct delayed_work scx_watchdog_work;
>  
> -/* for %SCX_KICK_WAIT */
> -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> +/*
> + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of sequence numbers.
> + * The arrays are allocated with kvzalloc() as size can exceed percpu allocator
> + * limits on large machines. O(nr_cpu_ids^2) allocation, allocated lazily when
> + * enabling and freed when disabling to avoid waste when sched_ext isn't active.
> + */
> +static DEFINE_PER_CPU(unsigned long *, scx_kick_cpus_pnt_seqs);
>  
>  /*
>   * Direct dispatch marker.
> @@ -3850,6 +3855,16 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
>  	}
>  }
>  
> +static void free_kick_cpus_pnt_seqs(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		kvfree(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
> +		per_cpu(scx_kick_cpus_pnt_seqs, cpu) = NULL;
> +	}
> +}
> +
>  static void scx_disable_workfn(struct kthread_work *work)
>  {
>  	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
> @@ -3986,6 +4001,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	free_percpu(scx_dsp_ctx);
>  	scx_dsp_ctx = NULL;
>  	scx_dsp_max_batch = 0;
> +	free_kick_cpus_pnt_seqs();
>  
>  	mutex_unlock(&scx_enable_mutex);
>  
> @@ -4348,6 +4364,28 @@ static void scx_vexit(struct scx_sched *sch,
>  	irq_work_queue(&sch->error_irq_work);
>  }
>  
> +static int alloc_kick_cpus_pnt_seqs(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
> +	 * can exceed percpu allocator limits on large machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		WARN_ON_ONCE(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
> +		per_cpu(scx_kick_cpus_pnt_seqs, cpu) =
> +			kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
> +				      GFP_KERNEL, cpu_to_node(cpu));
> +		if (!per_cpu(scx_kick_cpus_pnt_seqs, cpu)) {
> +			free_kick_cpus_pnt_seqs();
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  {
>  	struct scx_sched *sch;
> @@ -4490,15 +4528,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	mutex_lock(&scx_enable_mutex);
>  
> +	ret = alloc_kick_cpus_pnt_seqs();
> +	if (ret)
> +		goto err_unlock;
> +
>  	if (scx_enable_state() != SCX_DISABLED) {
>  		ret = -EBUSY;
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	sch = scx_alloc_and_add_sched(ops);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	/*
> @@ -4701,6 +4743,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	return 0;
>  
> +err_free_pseqs:
> +	free_kick_cpus_pnt_seqs();
>  err_unlock:
>  	mutex_unlock(&scx_enable_mutex);
>  	return ret;
> @@ -5082,7 +5126,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  {
>  	struct rq *this_rq = this_rq();
>  	struct scx_rq *this_scx = &this_rq->scx;
> -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> +	unsigned long *pseqs = __this_cpu_read(scx_kick_cpus_pnt_seqs);
>  	bool should_wait = false;
>  	s32 cpu;
>  
> @@ -5208,11 +5252,6 @@ void __init init_sched_ext_class(void)
>  
>  	scx_idle_init_masks();
>  
> -	scx_kick_cpus_pnt_seqs =
> -		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> -			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
> -	BUG_ON(!scx_kick_cpus_pnt_seqs);
> -
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
>  		int  n = cpu_to_node(cpu);
> -- 
> 2.51.0
> 

-- 

