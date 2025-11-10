Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435222B8A6
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763307; cv=none; b=ghLgJcltEsqROIei9crsdxIz2fHQtKuWavf/iRLumlQIPG/py3RznJyAFo/TF+Q1m5b8jzLpKV4xh2VJWuL9L+N68hmcDudEsJ1PQgERw9aFp2a+Lg3FfIcVMjxez5GWdlP2Z7FCoCLmcKM3+QEpedtihqZGpPkec/MpV7ZG2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763307; c=relaxed/simple;
	bh=l0J+8dQQbgU0yw2KZGK6xdvyZmhABMxI6VAqyFoE8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYzSWEssiXel2Lmg9Vo2kkMTVa/IyV5XJsdqWESLJfDroGexqeJju061ISqfNYbaqgYJ7EFQQtd/QidDeB+ij9OPx3Y21D7zaccaBIxdxePg38AugGrbaMjVbBi4NQT+ZbZNOWReVfqxhGtRiwQty0oAkm27Y8nQwMPanLsuDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TslX7b4m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TslX7b4m"
Date: Mon, 10 Nov 2025 09:28:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762763303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJvPx6JcjmPq45B8EiRsUpEhEG/c/KoZtcvUTMbJQPI=;
	b=TslX7b4m7vPR5Qq3r94nPNXNFZPJ+AW7WZmPIipVY+NDyWPtY82KXE7B2Y9jrfQSpfJo0X
	VduppTeRWvrkvFjdqWx9Ru0BXDz2v/k2rjYvIsLRwULEVhS+BN6jmyoqudCI2in1Dvnx8g
	OEqNGHXfSD81PURQVAwgcRtJ4TMOULQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] sched_ext: Make scx_exit() and scx_vexit() return
 bool
Message-ID: <aRGiI4UySRlHyxxC@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-8-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:31:06AM -1000, Tejun Heo wrote:
> Make scx_exit() and scx_vexit() return bool indicating whether the calling
> thread successfully claimed the exit. This will be used by the abort mechanism
> added in a later patch.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afa89ca3659e..033c8b8e88e8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -177,18 +177,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
>  static void process_ddsp_deferred_locals(struct rq *rq);
>  static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
> -static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> +static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>  		      s64 exit_code, const char *fmt, va_list args);
>  
> -static __printf(4, 5) void scx_exit(struct scx_sched *sch,
> +static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>  				    enum scx_exit_kind kind, s64 exit_code,
>  				    const char *fmt, ...)
>  {
>  	va_list args;
> +	bool ret;
>  
>  	va_start(args, fmt);
> -	scx_vexit(sch, kind, exit_code, fmt, args);
> +	ret = scx_vexit(sch, kind, exit_code, fmt, args);
>  	va_end(args);
> +
> +	return ret;
>  }
>  
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> @@ -4399,14 +4402,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
>  	kthread_queue_work(sch->helper, &sch->disable_work);
>  }
>  
> -static void scx_vexit(struct scx_sched *sch,
> +static bool scx_vexit(struct scx_sched *sch,
>  		      enum scx_exit_kind kind, s64 exit_code,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
>  
>  	if (!scx_claim_exit(sch, kind))
> -		return;
> +		return false;
>  
>  	ei->exit_code = exit_code;
>  #ifdef CONFIG_STACKTRACE
> @@ -4423,6 +4426,7 @@ static void scx_vexit(struct scx_sched *sch,
>  	ei->reason = scx_exit_reason(ei->kind);
>  
>  	irq_work_queue(&sch->error_irq_work);
> +	return true;
>  }
>  
>  static int alloc_kick_syncs(void)
> -- 
> 2.51.1
> 
