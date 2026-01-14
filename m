Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAED25F7A5
	for <sched-ext@lists.linux.dev>; Wed, 14 Jan 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400456; cv=none; b=I7bhQzFYn6X+Nqgg2ESslP/f8IjA7A57WMTNnNr/VV/s80ULSZu1Msm5UELZ93BXsEGW5V6XnowT6KvO0c59JDILi5BnWLQsGDypiebV6k+ZLdDgwHNBrbOOUlUhkd/omwp2PqF/xkqLLCyAaRjP2/EtC7xanOvsp32Ow8kI4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400456; c=relaxed/simple;
	bh=XMj4ssOkyrzw5suqQ9n8OiEK3bHMp4fUmo//LSS0zBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hu0vPmaWo5rFLmW2QQ8jlif0XTxdBjEsM/n5mr2gOXV4vcJDyj584NgbZaPJUCu9f+/2UqRXS3h81G+cPq9BhedvIsXATyzVn1VjOz1w++wd40RI6TN8sHolhR5cplmvsC4UqnZBoQlWz0xw+860AHxlphJKNVW7mjJ63A9PuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XueP6IYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XueP6IYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768400454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAAVPKAhdXdYSTKcBmSZbQ487SONxLb+XK4TvVsSDGA=;
	b=XueP6IYnQU1FhWnVDl28TlR2t2QFgwL71xp0Z2mAj2o+G68M4tCyMnaCLMwLdiu3Q9ronA
	N0+dXLNIRhfplYFUl8nyQ8PTYgmKNcPMyf/mzisfPdOBLLWSDSUV2ewpLWqF295jXoEjdI
	z9RdQ2TaRNNXtYSWNEYxWwPKTuKQJi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-UVRX9uFJNGGGh--R1x5ZTA-1; Wed, 14 Jan 2026 09:20:53 -0500
X-MC-Unique: UVRX9uFJNGGGh--R1x5ZTA-1
X-Mimecast-MFC-AGG-ID: UVRX9uFJNGGGh--R1x5ZTA_1768400452
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fc153d50so6458829f8f.1
        for <sched-ext@lists.linux.dev>; Wed, 14 Jan 2026 06:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400452; x=1769005252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAAVPKAhdXdYSTKcBmSZbQ487SONxLb+XK4TvVsSDGA=;
        b=qJ0/lvsbcC2rTqq2e2VbAw+Zvr2bcNyPTsSHrSn6RNacxZ37o59EzGReFGhXmwNfp5
         JzNXo0nNQFPsqS4dDiiqScqjtW/4xQfqQySlh0xnJHbj7D1vxMrQrYygIrrvQA8f3hHh
         JTwEF+i5BIV7IFdYwGjgQhuqK0eODNibUfzDMkpT7qXP2uyxURHzeK9XRt4nRhisY7zV
         tHO/NpopWOiUK+2NcCM8g6VmEcE7gq4XvdZ2kkdyAkLp2k0qL1i/Z0qcAJX6Ja9saapb
         jFW1mSekXVLJl6JXHnVgS9Cyl971zJEiDfUKH+9KJgJ4DEnxr1LfYScQpjcym3pE86i2
         LfZw==
X-Forwarded-Encrypted: i=1; AJvYcCXG+293X49boJuNgvGr329cZWFt8F8PXuO07AGrfKV/TXqQHcwirzSMnJwxY08xO7hdkje4EVbV1Xo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yya+ArBR5w/D6YylkMgutwPxNiEQrg7CnF/+9BUwe1kM4yCxghI
	aV7cJYWM36BJSvwoJJGvuJBsuCKB/RTsmoKVsKJ106eY1bpzIqWAwvt80tuHuOwqYRZc0k7qEFZ
	WFwjt96INOvCR68jdStB+5V7FRzNdFNyZS47wrgmIAyNRSIpv2OyxXxIUn02YAA==
X-Gm-Gg: AY/fxX6xp6XUKEshJ353Uj2fcTQn1lPgdYDFB8kOMh0H6IRctDxYdRnNkMds6aX78gV
	/k59X3LuTGWO+MaF/f14AcpzFyUVdfP5s8Vd8Ac2w/lYGG+0wUG6ipQ9WNR+eVjjbjvDUJ/VVQv
	mf8vkyHgM1UPLwL8lSIbTosYWvIHYadguPEdremggnPh4yZkpNQ8vXuwfEkzcAvCpiNN8ae9il8
	L/pUEMFdelmPSGoNWu6YtekDsyV6NN+EIAWZW5lpv0v24CeHFwZS6OtjZ4SmI62YJttude/JxW/
	TTzCHKhYUlYtfE1Xq9HP2DHe1+Z2edZPfDrXjcN0rR4e9i48xTGHtGjXUc/gvUt/eVwCjyUaid0
	VFofW7zv1DAonDxa6Lpj1E7q1CFxQGgoP0kzSBhRw
X-Received: by 2002:a05:6000:200d:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-4342c4ee846mr2866403f8f.9.1768400451797;
        Wed, 14 Jan 2026 06:20:51 -0800 (PST)
X-Received: by 2002:a05:6000:200d:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-4342c4ee846mr2866361f8f.9.1768400451309;
        Wed, 14 Jan 2026 06:20:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm48924149f8f.10.2026.01.14.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:20:50 -0800 (PST)
Date: Wed, 14 Jan 2026 15:20:48 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YnBCLpJ03NLmk2QFLqiN0FpFJFD9bPsuxorNvt9XbRc_1768400452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 14/01/26 14:05, Peter Zijlstra wrote:
> On Wed, Jan 14, 2026 at 11:23:36AM +0100, Peter Zijlstra wrote:
> 
> > Juri, Luca, I'm tempted to suggest to simply remove the replenish on
> > RESTORE entirely -- that would allow the task to continue as it had
> > been, irrespective of it being 'late'.
> > 
> > Something like so -- what would this break?
> > 
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
> >  		update_dl_entity(dl_se);
> >  	} else if (flags & ENQUEUE_REPLENISH) {
> >  		replenish_dl_entity(dl_se);
> > -	} else if ((flags & ENQUEUE_RESTORE) &&
> > -		   !is_dl_boosted(dl_se) &&
> > -		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> > -		setup_new_dl_entity(dl_se);
> >  	}
> >  
> >  	/*
> 
> Ah, this is de-boost, right? Boosting allows one to break the CBS rules
> and then we have to rein in the excesses.
> 
> But we have {DE,EN}QUEUE_MOVE for this, that explicitly allows priority
> to change and is set for rt_mutex_setprio() (among others).
> 
> So doing s/RESTORE/MOVE/ above.
> 
> The corollary to all this is that everybody that sets MOVE must be able
> to deal with balance callbacks, so audit that too.
> 
> This then gives something like so.. which builds and boots for me, but
> clearly I haven't been able to trigger these funny cases.
> 
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4969,9 +4969,13 @@ struct balance_callback *splice_balance_
>  	return __splice_balance_callbacks(rq, true);
>  }
>  
> -static void __balance_callbacks(struct rq *rq)
> +void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
>  {
> +	if (rf)
> +		rq_unpin_lock(rq, rf);
>  	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
> +	if (rf)
> +		rq_repin_lock(rq, rf);
>  }
>  
>  void balance_callbacks(struct rq *rq, struct balance_callback *head)
> @@ -5018,7 +5022,7 @@ static inline void finish_lock_switch(st
>  	 * prev into current:
>  	 */
>  	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
> -	__balance_callbacks(rq);
> +	__balance_callbacks(rq, NULL);
>  	raw_spin_rq_unlock_irq(rq);
>  }
>  
> @@ -6901,7 +6905,7 @@ static void __sched notrace __schedule(i
>  			proxy_tag_curr(rq, next);
>  
>  		rq_unpin_lock(rq, &rf);
> -		__balance_callbacks(rq);
> +		__balance_callbacks(rq, NULL);
>  		raw_spin_rq_unlock_irq(rq);
>  	}
>  	trace_sched_exit_tp(is_switch);
> @@ -7350,7 +7354,7 @@ void rt_mutex_setprio(struct task_struct
>  	trace_sched_pi_setprio(p, pi_task);
>  	oldprio = p->prio;
>  
> -	if (oldprio == prio)
> +	if (oldprio == prio && !dl_prio(prio))
>  		queue_flag &= ~DEQUEUE_MOVE;
>  
>  	prev_class = p->sched_class;
> @@ -7396,9 +7400,7 @@ void rt_mutex_setprio(struct task_struct
>  out_unlock:
>  	/* Caller holds task_struct::pi_lock, IRQs are still disabled */
>  
> -	rq_unpin_lock(rq, &rf);
> -	__balance_callbacks(rq);
> -	rq_repin_lock(rq, &rf);
> +	__balance_callbacks(rq, &rf);
>  	__task_rq_unlock(rq, p, &rf);
>  }
>  #endif /* CONFIG_RT_MUTEXES */
> @@ -9167,6 +9169,8 @@ void sched_move_task(struct task_struct
>  
>  	if (resched)
>  		resched_curr(rq);
> +
> +	__balance_callbacks(rq, &rq_guard.rf);
>  }
>  
>  static struct cgroup_subsys_state *
> @@ -10891,6 +10895,9 @@ void sched_change_end(struct sched_chang
>  				resched_curr(rq);
>  		}
>  	} else {
> +		/*
> +		 * XXX validate prio only really changed when ENQUEUE_MOVE is set.
> +		 */
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2214,9 +2214,14 @@ enqueue_dl_entity(struct sched_dl_entity
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_RESTORE) &&
> +	} else if ((flags & ENQUEUE_MOVE) &&
>  		   !is_dl_boosted(dl_se) &&
>  		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> +		/*
> +		 * Deals with the de-boost case, and ENQUEUE_MOVE explicitly
> +		 * allows us to change priority. Callers are expected to deal
> +		 * with balance_callbacks.
> +		 */
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -545,6 +545,7 @@ static void scx_task_iter_start(struct s
>  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
>  {
>  	if (iter->locked_task) {
> +		__balance_callbacks(iter->rq, &iter->rf);
>  		task_rq_unlock(iter->rq, iter->locked_task, &iter->rf);
>  		iter->locked_task = NULL;
>  	}
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2430,7 +2430,8 @@ extern const u32		sched_prio_to_wmult[40
>   *                should preserve as much state as possible.
>   *
>   * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
> - *        in the runqueue.
> + *        in the runqueue. IOW the priority is allowed to change. Callers
> + *        must expect to deal with balance callbacks.
>   *
>   * NOCLOCK - skip the update_rq_clock() (avoids double updates)
>   *
> @@ -4019,6 +4020,8 @@ extern void enqueue_task(struct rq *rq,
>  extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
>  
>  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
> +
> +extern void __balance_callbacks(struct rq *rq, struct rq_flags *rf);
>  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>  
>  /*
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
>  		 * itself.
>  		 */
>  		newprio = rt_effective_prio(p, newprio);
> -		if (newprio == oldprio)
> +		if (newprio == oldprio && !dl_prio(newprio))
>  			queue_flags &= ~DEQUEUE_MOVE;
>  	}

We have been using (improperly?) ENQUEUE_SAVE also to know when a new
entity gets setscheduled to DEADLINE (or its parameters are changed) and
it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
quick first look, it does sound good to me.

Thanks!
Juri

