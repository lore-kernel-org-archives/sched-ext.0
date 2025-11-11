Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225D2F7AD0
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875303; cv=none; b=q+qkyEVtx/u70QDZYO/gLkbY1tLvNMgghOt1rWFk54W6dYCMuswiSnRHvyE+AqLRb9fwzkVLnjlhdVZkFPQUiDvoe1hglgDvs4FCPP6CIMAUJY34dhdJxVR6TltLy1YoQUXYiIs3Mxcscot4lnEvCmZwO6NeK4+dHQwmii+Yni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875303; c=relaxed/simple;
	bh=9hKkrchyLF/jjgqjWRZlNe3Lc1clRKmIJbmYqWvJxsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXpi98Lq+rLXA6JXDYbqcZhLq2vbLN9UZM2tKf3vjG+zZ95fCeOFtZUQGWIIvyMjzLCnN+1Ab9hERa3pPeIcOf15unnZ8LIIdh7PwVMLe4truzlsCqHEJEf+JjLUFAeDqN4WPztJvKr4ugt1ZClO2khri2g9u+w6WGdpmwopOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVfubgeh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVfubgeh"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880576ebe38so41084446d6.2
        for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 07:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762875301; x=1763480101; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lMy22QQP0VSc3I+VIBBgb9L5+7BI8Iopb/MozVKJoo=;
        b=VVfubgeha3d4P8JJpXtn9gTOa0F24wrgt/2NVxe5lbelMg1LOCLB4AIX9P8tmq8x3g
         Ui3RJeapaqBHfpq9s6meXxD6dBHJS3T3fY4xcw9jBjmoaEvRteXnaUomvs1dQNCpVoyN
         97sW1/kItAYVtN6VFc08yLD2UgyZ8wmModWYoAtX5Z+QCzrP2lheyzXLfI5aFUgfKtUE
         Ur1OPXltarpSHEiV/7wbbYsnzh+AcV7J5ON+jiSwkG0ljCGjF4Mah+iRqNEhoD4vpf0N
         VospvUtL4Rp8SBrVNIdx3ob9Aln3NJKedfeZP9dC9kThOMLbDGiUutDuGSzABomIztB1
         fKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875301; x=1763480101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lMy22QQP0VSc3I+VIBBgb9L5+7BI8Iopb/MozVKJoo=;
        b=JRmgdfuTfpThrcYnMqY1grdQcXhCWb1/kdjOXI0QZX2BIfoieKR+Io0pC8GmWTnsGT
         I6ggbSI1lfp+z4ama7C2i3D8I3nnwJfk+4Wpl/dfW2hxDPRg4dmp3AWHkF4kj2OmyUZK
         BSQp99h0hquhY5ZQuimN/ZWy5lLPwbUKuwOakRTErn2eKvAcobVLQ4i1oh59oHItiP9+
         dpxYpcVnrSaWmr1pDdVdE80YmMRgGytOaGdOu7OCCFLyKhuTEponfO5GqlVenfMwiR2g
         8QuA63AnOm6VQP5vXu4lZ3lD/kvIcHS8cf2rQZRXWERwMC6cFb9bpaP2GtemEX0LkWo6
         zo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD8R2dlPuo2k9hECM33fz4Fuf7mkUNsM9/8NhSrxkM9LXhB/soc6g0o2rkyebQcR5sttJujuB4yIU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/JeayBnHbD4ddXI5GS2sLyYlgPyR7HKjhuntzly0+/rQr58tW
	aHaPEJ1csoJspv/QdW7YVK7pAbkf4KlDJvWxl+ei6bqdzXKmSMsKUEt+
X-Gm-Gg: ASbGnctnb+pW5/hlurCWY0RAIJR4lA/An+kPkoQF/3qquYRnmlb8a3Fldw/DKKDDpDS
	yH61w304OqlG1Kt2GAnCJn2nBFdpe01hSJeoABDwGOaT00a3eyjuDufF5DwE2J6GmtbSmU3HxG1
	Hiexv/fkvAM6RqhpGDJMVW4hbEcDL1t45xmghBz4VSGJipiPI61pLH8MFKg/pumUR9gNqT/a5ma
	yPHAPMwSKFz0lvwjjZBDXqxF1JvgPMJ2WPxyf+t+ZwCb1z+DJbE5gJ2av4DtMBPl1gumkhJhFcx
	iXYMd+KD4dJSs37xT/QLQ8UpRGuzStIHo5zbLHzqxyD0jMFBGLo0k2uM7hgw9KOah6lmadnelrA
	PlPmvTuyMUaTsEmxJKWrYTtHjE/DYd9GEaNmVMVxZ9GmaI/2fQxB0oV6wn5ZdaPxQ5HU2nOnItG
	UBGmvX7dR6p60Qmg==
X-Google-Smtp-Source: AGHT+IFN7gdQ8JFVDD266dWNGB0RPwkXxd1FNs848iDhuh9766bfSJ2Ycj/AfDxlo+Lw3WalVlLJxg==
X-Received: by 2002:ad4:5deb:0:b0:880:6647:1031 with SMTP id 6a1803df08f44-882385bf25amr173618676d6.1.1762875301011;
        Tue, 11 Nov 2025 07:35:01 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda578532csm68845051cf.19.2025.11.11.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:35:00 -0800 (PST)
Date: Tue, 11 Nov 2025 10:34:58 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] sched_ext: Simplify breather mechanism with
 scx_aborting flag
Message-ID: <aRNXotzRL5Dqlqyt@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-6-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:04AM -1000, Tejun Heo wrote:
> The breather mechanism was introduced in 62dcbab8b0ef ("sched_ext: Avoid
> live-locking bypass mode switching") and e32c260195e6 ("sched_ext: Enable the
> ops breather and eject BPF scheduler on softlockup") to prevent live-locks by
> injecting delays when CPUs are trapped in dispatch paths.
> 
> Currently, it uses scx_breather_depth (atomic_t) and scx_in_softlockup
> (unsigned long) with separate increment/decrement and cleanup operations. The
> breather is only activated when aborting, so tie it directly to the exit
> mechanism. Replace both variables with scx_aborting flag set when exit is
> claimed and cleared after bypass is enabled. Introduce scx_claim_exit() to
> consolidate exit_kind claiming and breather enablement. This eliminates
> scx_clear_softlockup() and simplifies scx_softlockup() and scx_bypass().
> 
> The breather mechanism will be replaced by a different abort mechanism in a
> future patch. This simplification prepares for that change.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 54 +++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4b8b91494947..905d01f74687 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -33,9 +33,8 @@ static DEFINE_MUTEX(scx_enable_mutex);
>  DEFINE_STATIC_KEY_FALSE(__scx_enabled);
>  DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
>  static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
> -static unsigned long scx_in_softlockup;
> -static atomic_t scx_breather_depth = ATOMIC_INIT(0);
>  static int scx_bypass_depth;
> +static bool scx_aborting;
>  static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
> @@ -1834,7 +1833,7 @@ static void scx_breather(struct rq *rq)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	if (likely(!atomic_read(&scx_breather_depth)))
> +	if (likely(!READ_ONCE(scx_aborting)))
>  		return;
>  
>  	raw_spin_rq_unlock(rq);
> @@ -1843,9 +1842,9 @@ static void scx_breather(struct rq *rq)
>  
>  	do {
>  		int cnt = 1024;
> -		while (atomic_read(&scx_breather_depth) && --cnt)
> +		while (READ_ONCE(scx_aborting) && --cnt)
>  			cpu_relax();
> -	} while (atomic_read(&scx_breather_depth) &&
> +	} while (READ_ONCE(scx_aborting) &&
>  		 time_before64(ktime_get_ns(), until));
>  
>  	raw_spin_rq_lock(rq);
> @@ -3740,30 +3739,14 @@ void scx_softlockup(u32 dur_s)
>  		goto out_unlock;
>  	}
>  
> -	/* allow only one instance, cleared at the end of scx_bypass() */
> -	if (test_and_set_bit(0, &scx_in_softlockup))
> -		goto out_unlock;
> -
>  	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
>  			smp_processor_id(), dur_s, scx_root->ops.name);
>  
> -	/*
> -	 * Some CPUs may be trapped in the dispatch paths. Enable breather
> -	 * immediately; otherwise, we might even be able to get to scx_bypass().
> -	 */
> -	atomic_inc(&scx_breather_depth);
> -
>  	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
>  out_unlock:
>  	rcu_read_unlock();
>  }
>  
> -static void scx_clear_softlockup(void)
> -{
> -	if (test_and_clear_bit(0, &scx_in_softlockup))
> -		atomic_dec(&scx_breather_depth);
> -}
> -
>  /**
>   * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
>   * @bypass: true for bypass, false for unbypass
> @@ -3826,8 +3809,6 @@ static void scx_bypass(bool bypass)
>  				      ktime_get_ns() - bypass_timestamp);
>  	}
>  
> -	atomic_inc(&scx_breather_depth);
> -
>  	/*
>  	 * No task property is changing. We just need to make sure all currently
>  	 * queued tasks are re-queued according to the new scx_rq_bypassing()
> @@ -3883,10 +3864,8 @@ static void scx_bypass(bool bypass)
>  		raw_spin_rq_unlock(rq);
>  	}
>  
> -	atomic_dec(&scx_breather_depth);
>  unlock:
>  	raw_spin_unlock_irqrestore(&bypass_lock, flags);
> -	scx_clear_softlockup();
>  }
>  
>  static void free_exit_info(struct scx_exit_info *ei)
> @@ -3981,6 +3960,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  
>  	/* guarantee forward progress by bypassing scx_ops */
>  	scx_bypass(true);
> +	WRITE_ONCE(scx_aborting, false);
>  
>  	switch (scx_set_enable_state(SCX_DISABLING)) {
>  	case SCX_DISABLING:
> @@ -4103,9 +4083,24 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	scx_bypass(false);
>  }
>  
> -static void scx_disable(enum scx_exit_kind kind)
> +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
>  {
>  	int none = SCX_EXIT_NONE;
> +
> +	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
> +		return false;
> +
> +	/*
> +	 * Some CPUs may be trapped in the dispatch paths. Enable breather
> +	 * immediately; otherwise, we might not even be able to get to
> +	 * scx_bypass().
> +	 */
> +	WRITE_ONCE(scx_aborting, true);
> +	return true;
> +}
> +
> +static void scx_disable(enum scx_exit_kind kind)
> +{
>  	struct scx_sched *sch;
>  
>  	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
> @@ -4114,7 +4109,7 @@ static void scx_disable(enum scx_exit_kind kind)
>  	rcu_read_lock();
>  	sch = rcu_dereference(scx_root);
>  	if (sch) {
> -		atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
> +		scx_claim_exit(sch, kind);
>  		kthread_queue_work(sch->helper, &sch->disable_work);
>  	}
>  	rcu_read_unlock();
> @@ -4435,9 +4430,8 @@ static void scx_vexit(struct scx_sched *sch,
>  		      const char *fmt, va_list args)
>  {
>  	struct scx_exit_info *ei = sch->exit_info;
> -	int none = SCX_EXIT_NONE;
>  
> -	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
> +	if (!scx_claim_exit(sch, kind))
>  		return;
>  
>  	ei->exit_code = exit_code;
> @@ -4653,6 +4647,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	 */
>  	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
>  	WARN_ON_ONCE(scx_root);
> +	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
> +		WRITE_ONCE(scx_aborting, false);
>  
>  	atomic_long_set(&scx_nr_rejected, 0);
>  
> -- 
> 2.51.1
> 

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
