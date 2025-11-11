Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B036A01B
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876205; cv=none; b=qZO+/CGN0kJqPQkFjakuBgLkpFhSxFxaBqe6TwbzFvgdGH5HOUwlLPqTZPnWHG1anbTXR+xqmwANR1Up4JJLbSChxuoHhwXBCasdXDiAJz4fcwyCJwpDxv4WOV19ii9h6aaIk1ZGsGn0bzjff9LQcSZ57rqCJD9hk+VDLZhzb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876205; c=relaxed/simple;
	bh=ESyER2JSxYY4NsV34yBghgZ/2Fls0YEErp/SY+YCskE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbkCWF4ayJS1pggKNs+HbytKFx1ClQqbXhuYAjJvV3XDjUcyuTqe0/FEpc+u2L44506ax/10epo6au3XUlrlFiZ2ZVE8rTSYYmhspfTzQdM7h3LHEfBPMySTFW33MRGD8kbf2coaaHfMMJgoetTGgm1bzpphpZ+p+Yy77x7yWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jth6rqvY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jth6rqvY"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b22b1d3e7fso430766185a.3
        for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876203; x=1763481003; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwefmE2IIwpJVnJq6WbbfWH7vOY7bkvNqlJ8WW2tUJ8=;
        b=jth6rqvYDrXXpYgudXpKLhvl2mbu7ZRdJy6CYpLucfzS885WAlqZWcwcZPX3dzoJuz
         BEzN4JtfYzj27i/iY7nd2riOBUnKtvjqWjFcE8cRIwkJf+jhtYBw6Dw/I+jFk14a2o4W
         1IBq2ocu7Q8dm2ni3LT4MpO0oPsVAqStDcxoQNvZqjbwxr8I5yUqimSHwSa+xBEIL/zK
         Ub59LlOoqPiAMDt8q1XKUJLgYvDIrOvq2gBv0rOAnySYk/qzixg5fRY6VXAfqSonQOBQ
         zha+q/yV71efTBkLv6vcphCf5fDQgSGT3m7ZVIZSGqCaadodnjjWUA9WKgmJVDrLhiYB
         iVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876203; x=1763481003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwefmE2IIwpJVnJq6WbbfWH7vOY7bkvNqlJ8WW2tUJ8=;
        b=ZKPzUZvFqdixjHkyk1UgZb9YuAFTRvQReCJ9fD6mIrtZFxGvvUe+3NGuAWfIefKJcs
         BEno2vLCZl3KV/PzCQmsFbekhoA7neOQCNWRa/0/Q6Tchlzr+NNjpLJR/dxPhdfyiYJR
         8U+ty3wngYbkHY/+9xXaFSvxZD9fO/hM6muS83JVt/f1FXT/dAOSVg6VsqLO3YAydplt
         I2dTb0TesP0hJQBr3YjOgS50r2JAmZtsHdyKVl6mK5ESYqQOnRtxeyLe8rq/WPBbYT8u
         ipw84uV0aX09LaoNfwwlid/nwBelQySNNGkI1iuMukNkEfJSSPEJn0rA1M/VBAi1cFV0
         m//w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7oal+Bt3Cu5dA8O/kPdTY5abQVLpl5z6waG/mfHcMIGjQPpVIkywSMKcrMZ6oKQwbxqLXMRSI8I=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbqZdz5TPngRqBwrsDon0F6WZOWrGVxfUwnjAjcVUBMM4gXf8o
	EH4lSYzKQjBIdhPiczEEtkroC7Fvl9V6z5B9vB9MsMzek4Jk0XipGTPaVri32w==
X-Gm-Gg: ASbGncsBOiZdo5vnN4JWJDrNfeatR6bMb1u12Kikxpi79CU7drg2Qz2zW/Mog++haXZ
	oQ4utSmyRuD4A7IwfWij8eWG5bffjxubg7yEKXQaMdlp4RpIo3xnwx0e5X9SusLQXqAIgTLinoD
	K3QqgJZB6kN+d7NTm+qzHCYeZ/wQyQtCvbwA4DyWSnMM5PB2aX3oafe76+0oxzl5E4+EhDtjA5Z
	y/WnMqe1KJD54BFuemssSgMH28U9/l5iksj9G5B6iUUZkSCsPAInq5PzdNijPWSi6LbmylezSPF
	qMU3ZiNuQiiARNChLH3XvALzwP4A3NAsQS+j0FARQtBns4cSu27Ry0KljVFezyNTMGde0UU9Mm1
	pgDe0tN9jpgzQlXOfe6ML4gaOAlDgnsfnSd/O9MPWzKlBSs45xXGENpqA01dW4hGqW6nVlqL5IU
	GrJaHaDwzfHWLTylWzVJ7/VFL5
X-Google-Smtp-Source: AGHT+IEqK4mmcwj1No+DeMHAuBPHf2gYyU/MGOLcd6RyV4lLyqhIbyC1o/hm9IO4zzs/5TliDWk8XA==
X-Received: by 2002:a05:620a:4722:b0:8a3:fa43:321b with SMTP id af79cd13be357-8b257f038cbmr1699387385a.27.1762876202543;
        Tue, 11 Nov 2025 07:50:02 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa27882sm5521185a.55.2025.11.11.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:50:01 -0800 (PST)
Date: Tue, 11 Nov 2025 10:49:59 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] sched_ext: Refactor lockup handlers into
 handle_lockup()
Message-ID: <aRNbJ2zzq814zPsG@dschatzberg-fedora-PF3DHTBV>
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

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
