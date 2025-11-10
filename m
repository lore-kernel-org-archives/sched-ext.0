Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CA2FBDFE
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763363; cv=none; b=O7N0D3L00ZdZuxcWMYBW+Qk1bGHnbrQWhu9jXbPFNp7eQ/gS5btx8VrGcPErogA27CKs8I2sTaqD9IucbFjSAqfU5iVzk6Z0oQB7asQzZdqk23U7mhD0LwsnOx8NLTVd7WUmxxPhPXk4jEVLzhRxT9HcHFi+CpN/H9oj2xg9AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763363; c=relaxed/simple;
	bh=1DI0C6TD1pJNAktK7mZYzqqAHphWxufDYfb+YjafTb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewctgi0zkpy/VS4vNGL8OVsEjqEImxoGM1TYd813eyK/nRMljbTV2902XRAK7CeE7TkbkVTD9U30cG2KpkDp+lDLmAKnVo/Xg0lgVS7lLxR2SQstH8merge/ykBJs1SaAMJFNHTp9zP+xQKbD9A1JNTxrFHGY9UPw7amM0uJRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JrTOKaLJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JrTOKaLJ"
Date: Mon, 10 Nov 2025 09:29:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762763358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwEovwYnJISBpjPgJBfuCCVHlQcUzW6qeBuUiR7KQnU=;
	b=JrTOKaLJJZe763/yey3Lwkx1rX3l72FQmiYZ8oWBfD2V6tq0Z1n31LDNv5tMkOywquQYWu
	Pcz9TuWPQxKxZdgKgT15KBDZ4+N9gs/c41mEwd91RaGUxNBG4uDLLP2uyNTcaQ9f94dA4i
	JP2V0eP0TjOr2+Bo2pucgkN15kNWawQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] sched_ext: Refactor lockup handlers into
 handle_lockup()
Message-ID: <aRGiWTDEK16ge301@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-9-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-9-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:31:07AM -1000, Tejun Heo wrote:
> scx_rcu_cpu_stall() and scx_softlockup() share the same pattern: check if the
> scheduler is enabled under RCU read lock and trigger an error if so. Extract
> the common pattern into handle_lockup() helper. Add scx_verror() macro and use
> guard(rcu)().
> 
> This simplifies both handlers, reduces code duplication, and prepares for
> hardlockup handling.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 65 ++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 033c8b8e88e8..5c75b0125dfe 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -195,6 +195,7 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>  }
>  
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> +#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
>  
>  #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
>  
> @@ -3653,39 +3654,40 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>  	return false;
>  }
>  
> -/**
> - * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
> - *
> - * While there are various reasons why RCU CPU stalls can occur on a system
> - * that may not be caused by the current BPF scheduler, try kicking out the
> - * current scheduler in an attempt to recover the system to a good state before
> - * issuing panics.
> - */
> -bool scx_rcu_cpu_stall(void)
> +static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
> +	va_list args;
>  
> -	rcu_read_lock();
> +	guard(rcu)();
>  
>  	sch = rcu_dereference(scx_root);
> -	if (unlikely(!sch)) {
> -		rcu_read_unlock();
> +	if (unlikely(!sch))
>  		return false;
> -	}
>  
>  	switch (scx_enable_state()) {
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
> -		break;
> +		va_start(args, fmt);
> +		scx_verror(sch, fmt, args);
> +		va_end(args);
> +		return true;
>  	default:
> -		rcu_read_unlock();
>  		return false;
>  	}
> +}
>  
> -	scx_error(sch, "RCU CPU stall detected!");
> -	rcu_read_unlock();
> -
> -	return true;
> +/**
> + * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
> + *
> + * While there are various reasons why RCU CPU stalls can occur on a system
> + * that may not be caused by the current BPF scheduler, try kicking out the
> + * current scheduler in an attempt to recover the system to a good state before
> + * issuing panics.
> + */
> +bool scx_rcu_cpu_stall(void)
> +{
> +	return handle_lockup("RCU CPU stall detected!");
>  }
>  
>  /**
> @@ -3700,28 +3702,11 @@ bool scx_rcu_cpu_stall(void)
>   */
>  void scx_softlockup(u32 dur_s)
>  {
> -	struct scx_sched *sch;
> -
> -	rcu_read_lock();
> -
> -	sch = rcu_dereference(scx_root);
> -	if (unlikely(!sch))
> -		goto out_unlock;
> -
> -	switch (scx_enable_state()) {
> -	case SCX_ENABLING:
> -	case SCX_ENABLED:
> -		break;
> -	default:
> -		goto out_unlock;
> -	}
> -
> -	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
> -			smp_processor_id(), dur_s, scx_root->ops.name);
> +	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
> +		return;
>  
> -	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
> -out_unlock:
> -	rcu_read_unlock();
> +	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
> +			smp_processor_id(), dur_s);
>  }
>  
>  /**
> -- 
> 2.51.1
> 
