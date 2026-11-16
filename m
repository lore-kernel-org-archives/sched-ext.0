Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837459;
	b=4QJOwy4sga2iwMB7OtRPIwde8PaobAUp0Q/A2lJ8timDptrcAEoZmS5OX67/dHOAi0lW
	 oTQ11iz15tqAtbV0Qp/4AWvY92kK8gwkMxz2+aKMBBhES4j3JOcMBvUGuI73+J7PL9sAl
	 2CQZEweFHFMlWvQAWPmyOP+mHgoAsilfveRKD8prGUONeek25Bmhfs0Pbw8OhXdBQPF+b
	 yNvix8IMy4l22cOIzH4PCqxEaA9SheN5feInIXaelQEl75TBZu8mhH1h5EChVgweBNkfg
	 wVjnkGGjUdySpdaZE0WnH/F0FfEoD+/+mxJKhe04Jm304ghLyjzpp3j94bQJWr5uu/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1UODTzCnkI/AIIgb2/kXpLhCU+2zXpd05+blvCLXolQ=;
	b=Wctx9lXw/OfGg5vcV249epC0JrXWJgloKicVxFjKs+tAKJEJvFuONARAQtv/KZBBfPZz
	 zjttfET6fd2FavhBoPHrQQNO3MVyFq6eqCMHAMIh1IZNEQCVjBmZmPLmBfh9Hm20OOIWs
	 rYXj/LaE/BXs9nCY1gu/7sEVckBRTg8SyHlExraLsrC9fvl+ua3OXwhb3SzY4U3SPn8sp
	 wH/1gbsLpXhBN/522L2ZHHhtkDTl9S9KdaxKKYmUHs0i5ZQlRZYT/GlzEruvEQfI9crTo
	 0l+8bVZaRGac+rnm+6dTmi6QeRJBbZ4qg1+pmUMNwFbk8dYh/0jmY3mBNfFFoJX5DvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/9R0ZVR";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9A606A32A
	for <sched-ext@lists.linux.dev>; Mon, 16 Nov 2026 13:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C9A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/9R0ZVR
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so4034415e9.3
        for <sched-ext@lists.linux.dev>; Mon, 16 Nov 2026 05:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794837457; x=1795442257; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UODTzCnkI/AIIgb2/kXpLhCU+2zXpd05+blvCLXolQ=;
        b=c/9R0ZVROD+Se8zfNWfolt0WjBsLSvY67JguI2/pBzO+HHPHRkl5guQOdA4/eSHf9j
         NbiMtt2UU2tBh4t5++7j4xkJ7dpiG1IqstYG7mt5OPKIgndMqUGV7iPUA1ehhwKFfpAn
         /Q7k0lMDsn7h9mJz7CirUOkmSzlApYEiSFNImxAyQYDkIf5KdpNgyvHk9p3fQL2rou0z
         av4V4KwGXQ0ATzVGuCh+7BZonncnjpAJaeOgAraiWWgEGHj50o5jOeYX8AzG0BsvrU1+
         YG9mFXQn2rkGZeQ8stYPnhdMGrjcqMQMqFUOMrTVzG0OOPrKanpmasDLutHD7PVBcQHC
         n99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794837457; x=1795442257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UODTzCnkI/AIIgb2/kXpLhCU+2zXpd05+blvCLXolQ=;
        b=nNY7HrDzIZSGARjRSnUren2aZsDhm20JPPZ3Yp4J6kEUFQ4DnapYI/KC+bYPD2SMiP
         qh5rCbGq5asvJfLIzhg5fm98M02j/6/uplJykDheDD1wQotrnm0jtbCNYwaluDHHBIBH
         frjnpxXrxetF2m9bLcPENi6W5xr4FIMT5Ej65YuxPNDuERlSBtetRsMugPqQxb9r89cO
         ylT+tcD0MeSDhNYgqq4K6shAVhoDucQ1frFbItawkHaiWwBKqONq/ifcj2GgywJzJ+dd
         Wh6Lx0UnDvF3RK++wHYQblmNliq6OY/5okXsqN74Y1NKUZSvpb4fm5MOX4yDtIQ4qU/n
         WjTg==
X-Forwarded-Encrypted: i=1; AL+hErFhAhNaTv3g8lzXh4TfntaqoGwiSM+1uA19NzSco/u3AIvRC7sRuX8Zqioge8zKr6VZh6VxffRd1eg=@lists.linux.dev
X-Gm-Message-State: APuU4Z9i9y6Z5niLcyq7FhyOWf4EheUErYaZ7/Mz2AJRU2W7axPQkF4m
	j4VUhYAslXbe7CD1FHiByZc13+RZDa50ZAuKHJXlGIc3UnZZCUwfwAPR
X-Gm-Gg: AYBFou22vHLh7xKDcOkFW1CpfixUOeNUjSSbatXyTkpfI2cyfGn5ke097eoJcLNagSZ
	aAAUuIzc9oG4BaFtbZpB31pb01TDvzVuYORVg5m34xBqfNIAYJ9Bm7vlkVznJaqcQOx07jB8bYh
	T+YQmRexZSplCMHTrmUZFHSlX4iKq3p637s5hAEnhLimrIPBoPed1tw48YMv2gzSpA2H3hmtyea
	kqmVsS4dqvoyaz19DRsegLquKGNFTlJECldo+phXprwSiTnfzSnnDPWMnJ1SOaMvojXF7brHEXy
	aozRRb9qISLeHcLZwbbkhOTPq4wc0E3BnRXXVfK53PrwV5MGKAm4LLXu9/LHEfUre/etacSzMdw
	sMEEtwrGXy0ba7Tki3KVaA5ywDbUgzPQUj/ssYBLW6tAugkfev9dmrstxDl36Bf4jBRHec6Cqb/
	bluiyrSTv2nwpaoS0w/T8WLi2HGyUAMiPIyeKk67izrto0AVIEBpA0xQBx36dlecERQwHaRusg/
	2/4xY+6IvZUl76NtSma4DNoir1+3cCuJ569+zFnlQ9BsSLl0VEEfaXZgCUtHCv0ia3w17TICEMH
	69c4blgund9ycMOr3EtfnuNnQol0KueF+NolE5WSb9QIYkgSr/ToYjI=
X-Received: by 2002:a05:600c:3d96:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb55a35c14mr209953705e9.1.1794837457182;
        Mon, 16 Nov 2026 05:57:37 -0800 (PST)
Received: from scheduler.schedules ([85.100.69.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb675200e4sm126280195e9.0.2026.11.16.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:57:36 -0800 (PST)
Date: Mon, 16 Nov 2026 16:57:31 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping
 entities
Message-ID: <avr4MsRsjGfGHKKk@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-2-vincent.guittot@linaro.org>


Hi Vincent!

On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> Similarly to delayed dequeue, which enables an entity to decay its negative
> lag while sleeping, a task should not keep a positive lag forever.
> 
> The sleep duration and the weight are used to decay the positive lag at
> wakeup.
> 
> Apply the decay when enqueueing on prev rq for which we hold the lock to
> get rq_clock_task().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 90 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0feec172fd37..5cd171f830d8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	return avruntime - vlag != se->vruntime;
>  }
>  
> +/*
> + * Signed add and clamp on underflow.
> + *
> + * Explicitly do a load-store to ensure the intermediate value never hits
> + * memory. This allows lockless observations without ever seeing the negative
> + * values.
> + */
> +#define add_positive(_ptr, _val) do {                           \
> +	typeof(_ptr) ptr = (_ptr);                              \
> +	__signed_scalar_typeof(*ptr) val = (_val);              \
> +	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> +								\
> +	res = var + val;                                        \
> +								\
> +	if (val < 0 && res > var)                               \
> +		res = 0;                                        \
> +								\
> +	WRITE_ONCE(*ptr, res);                                  \
> +} while (0)
> +
> +/*
> + * Remove and clamp on negative, from a local variable.
> + *
> + * A variant of sub_positive(), which does not use explicit load-store
> + * and is thus optimized for local variable updates.
> + */
> +#define lsub_positive(_ptr, _val) do {				\
> +	typeof(_ptr) ptr = (_ptr);				\
> +	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
> +} while (0)
> +
> +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> +static unsigned long task_h_load(struct task_struct *p);
> +
> +static __always_inline
> +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> +{
> +	struct sched_entity *se = &p->se;
> +	s64 delta_exec, vlag = se->vlag;
> +	unsigned long cfs_load;
> +	struct rq *rq;
> +
> +	WARN_ON_ONCE(se->on_rq);
> +
> +	/* Negative lag is managed by delayed dequeue path */
> +	if (vlag <= 0)
> +		return;
> +
> +	rq = rq_of(cfs_rq);
> +
> +	/* No fast access to prev rq task clock */
> +	if (flags & ENQUEUE_MIGRATED)
> +		return;
> +
> +	/* Compute sleep time */
> +	delta_exec = rq_clock_task(rq) - se->exec_start;
> +	if (unlikely(delta_exec <= 0))
> +		return;
> +
> +	/* For anything above ~4 seconds, save computation and clear the lag */
> +	if (unlikely(delta_exec >> 32)) {
> +		se->vlag = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * Use cfs' load and p's weight to estimate what would have been the
> +	 * share for p. task's load contribution to cfs' load is replaced by
> +	 * its weight.
> +	 */
> +	cfs_load = cfs_rq_load_avg(cfs_rq);
> +	lsub_positive(&cfs_load, task_h_load(p));
> +	if (cfs_load) {
> +		unsigned long weight = scale_load_down(se->h_load.weight);
> +
> +		delta_exec *= weight;
> +		delta_exec = div64_long(delta_exec, cfs_load + weight);
> +	}
> +
> +	vlag -= calc_delta_fair(delta_exec, se);
> +
> +	/* vlag can't become neg while sleeping */
> +	se->vlag = max(0, vlag);
> +}

Look:

Let's say we have 3 tasks named TA, TB and TC. They all have the same
weight and the same slices. So TA gets picked, works for a while and then
sleeps for less than the rest of its slice.

So the part that I hate and love, math. For your diff, we do:

(sleep_time * weight) / (3 * weight)

3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
have the same weight.

So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.


Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?

If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
So we would do V - 3.

Now our objective is to add the sleep_time of the task to -3.
Because if the task didn't slept, in that time it would be working
instead of sleeping.

So, we should do V - 1. But we do V - 2.


AFAICT, we can't already know for sure how much will a task run even
when the sleep_time is smaller than the slice. Because of preemption
:-(.

The cleanest, the simplest and maybe the worst or the best solution I can think of
is just setting lag to 0 on every wakeup with positive lag TBH.

Or maybe, try to calculate when sleep_time is smaller than the slice,
but just set the lag to 0 when sleep_time is bigger or equal to slice.

What you think?

Sreehc,

Kayra
