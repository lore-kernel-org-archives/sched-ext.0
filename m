Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993630;
	b=YKKQOdieYk+vn2FrZJKE10La/JM+LlrUXcfq2t079NGxNWivwIvLg9Nm6k7OlYC94i1c
	 eB9b7yJv2nrwT9s8w7gRVFfyW7z/aNxxAl7XeByNREuXVYlTmP83X7Ade7ILPPmsdkHko
	 3HdyuB5Dh62/Jbo95NNjrwpJpwDqGH8zZMCpzjrWkLFgwKxpImHwlRELkT9sORCIjVk+H
	 vHqIyzwQBSg4X3QH6BgQxxRGXUUl8Ar4ndPuBoFtWIVEn2W+n1ljVS97t2HKdE+vZ4Y2w
	 ynBR0GVl/PjhW+nXpnPCAbtqzAzY9IbcXwfdViidcXE2+2ZVZxtIkkNHSDS29Ck/jgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
	b=QCqdZww/JOE9LX7xj9Gwft456jFyhN/2kUeZSulUO6xInQ7ewt8wvkitDCo8BqDgzjbI
	 LOTve4DUBlQd5VQMRJYten8vtE8toE8S1EyeKl9fEZfCyN+ly2r76n/EXLYwzHfysflnQ
	 /JhBhTYFtArl7+Dc2GNwwafES3CUosD0/luaMU0uYREFewZ6Q9dwE/v1RpjT8kMNScxas
	 EstrwCLoJUJzgtBoBih4FT+4L6DSug0HGqvdqCC0YHxWetWXIgUIy+c8EugrTe5LPZXxD
	 0HWP9nwSwJ2yUPt5yuV6ZuedD0kCS83tZ6mWqRi8RADLhB/DZHydMB4X4ebkJqrOThQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mTSjVQ4R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1EB606A881
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1EB606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mTSjVQ4R
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1062425a12.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 01:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794993628; cv=none;
        d=google.com; s=arc-20260327;
        b=ns9fEBYm/OnDEJZxCzZJQBGo46PjsyD7Pqj9y4IIZyfEyRQ0MAN15JuvLqweDvcIdc
         abm2jytn6HqEXlzJ2UBKarnZlRnFkXzhVIoc2gCS7sN6qap3DzgGQLxqst547vjf+yOp
         Avdb0Kpf5xUWJ+FarWp/F6IoMstm9SiboguOOs9w3i1THQJG91MX+50Ib9pqKeKFBbLd
         vErGZg8gzR72mRHngUrMpiw/CQouDBdMfnmFEoih4UryoVcKq/uoCOfgKXvFGeYHpqng
         V17ywdtfpS8bGT+KH4uyKI5Ekqe156A9/2A+eBeDOoeOrokMYCo1lmt0OTWGFHn1exWN
         th0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        fh=HMgL78ATWn9x2stC+20UuvE95ZwZT3razAmxy/q/314=;
        b=lFHdsOOQI+eRIs9qFm2bPVaql+nM2i6gnl3vQSJ8E19v0e9G3qOUJ2kXhaFzlvr0yv
         5QE/xwEZvCIi7IGBwRboA4MZs0qJlX3HvuO8pAZThzybFmWcLOLWiO4b52Xv4FGmUi/p
         PEWMTbArI2mS11grup3Oejdvw49TqA8+nXbLzGpQPtWmZh8yUtMFj8dUTIjjjU0yPal5
         2Gj2tP/P6uws16YkDvFPmBfyPiNJrFcSBCkXaIuhOQr/LjYRh+fTreTGob6NOIUqryEe
         5H4qie2EqJ+8TPTFP49DqSuvdpp1+H8FSZZ4r9dGJqmpGE4AEH4YN0lpU/LVzLkZ1gS8
         wMrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794993628; x=1795598428; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        b=mTSjVQ4RMfX9s/8vHfEkNSVFgSOd1sBtGTaaq68mLX97LAs95wcWclagbv8POec+wM
         piCUaJ2dZEfCYUiuaZRAHmaEKWi5Dt4iHVOKarhh5CRQY4n8OhmHHIvd584KZAlG80Xy
         S1MgLEPW7yvmdWm/Yji7CIeDQwyCcOCSt2wQL1WooYpBLhhHn0DQRF1wnx3PcFexguVW
         72z/L3AOuz95C8BMm+vDW6rlV+4niIgzxK2SF5AO0Z7OJb5TU2RJ8Yo4qXLKCE92gvwp
         UrM+tJP/nMD7LA5PYNhQAIIlEXSGrdRoC8t9X3Eq1/j6qDC5ydbXZ1p/5CBJQ+JojaRv
         br7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993628; x=1795598428;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Aeo8Kc6gDZPXZvE0DmabfYTz/zNuvasGH9KV0/D9kjE=;
        b=z4soKbAoQT+Q6NOJpt1AKC9URjCWEXnCHlh65GaOcDeGb5CXE+xik2NGdxoH4n7yY3
         FnEND7zaa3jx872MDobDjhsV6kY/p8Yx24nrc7HzCw3Z0Grhr0okmIOWgfy/ylvi7JVI
         j3WSgHR+LLsUJCsLNRdb31tqgr+3Z69GzRtwF8KmPwwXlrOKuXrDatFJrsKt8fPoTf10
         OwVWRFKbD6i774BAqd/brD82NEhKhj0USWAQFJPnz3v7QDkiOXpklGBCMYLtlK0jS2qD
         A8Zt5+VIbA8qK0kkqGI/cZUMrd6sf0kQpSllNB4HzbKypwVoQqbyfbOKv+yNdKRutGVB
         Mpzw==
X-Forwarded-Encrypted: i=1; AL+hErF+2P2ti2ryjzaQIwmaIONpQ7vr+SyhYzcT1N/Ca5kEH9GHcCs7s6O6YRqD/hTkdFjQp9lVYeQ4dk4=@lists.linux.dev
X-Gm-Message-State: APuU4Z9bss6wFVUR150cZIfl8oWwQRrHFrkqrVGOKRmbE+nRGswe8ttc
	6OvBPT2IvzZDxqokMwiL4xrMBdHEIvjJUlyvLu1sjjZV4FkuRgdGtMWOAOF9fdlUG6hy1evArE9
	720xJg/x20cxKrNwOI4BVXPSAvpwt8EACw6a1IHmLFg==
X-Gm-Gg: AYBFou1W5jeNEE0gH1IqGyhveWvB18N3RK5L/Su+zwqakcuIrp2cN16YYV6t6vP1BX6
	wPydeXGK+gpTd+z+WUW8g+mALGVeEpQrw1v3WkwJCnhDgDeRRUpbWOUUd6FJ2sCSr+7A4fhA2fv
	VbhrmCGYYIQB2ojF54IqG96/QudUrrWELUScueLNXJHANgZex0zVA3lg0o2hEDQ2N5gG+s7vv3B
	ZebKDWSW7n3GsVNUM+XxQrdQEX9DAcajQBWkzscb1wb5A3AaDFnptqbEfhw1d7tnh/s9RXQ45XC
	4KqeY69iAcDY+9iplioPxMLTNTEZ/CS3PkiOSNY5AmHBOmtDA729e03x85K/vNT0V+Gtf7C5udc
	H4GnBW0O8g4G6pj4DgbXqM+vkGc+YmNk1oVJH04PbdBhf1F+ODbz+YvTPCeU7+JV6cDuyOUnrVX
	0N5Lyz5oMAMr9Y
X-Received: by 2002:a05:6402:5025:b0:6b7:dda4:f72c with SMTP id
 4fb4d7f45d1cf-6b88814ddbemr1418382a12.44.1794993627427; Wed, 18 Nov 2026
 01:20:27 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org> <avr4MsRsjGfGHKKk@scheduler.schedules>
In-Reply-To: <avr4MsRsjGfGHKKk@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 18 Nov 2026 10:20:14 +0100
X-Gm-Features: AclHuK_oniCwAqlI2oAZeu8xsFu1h8iipcGgGgvvNigzDOS5HzX_db5ZNqKqLFA
Message-ID: <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping entities
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
>
> Hi Vincent!
>
> On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > Similarly to delayed dequeue, which enables an entity to decay its negative
> > lag while sleeping, a task should not keep a positive lag forever.
> >
> > The sleep duration and the weight are used to decay the positive lag at
> > wakeup.
> >
> > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > get rq_clock_task().
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 90 insertions(+), 34 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0feec172fd37..5cd171f830d8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >       return avruntime - vlag != se->vruntime;
> >  }
> >
> > +/*
> > + * Signed add and clamp on underflow.
> > + *
> > + * Explicitly do a load-store to ensure the intermediate value never hits
> > + * memory. This allows lockless observations without ever seeing the negative
> > + * values.
> > + */
> > +#define add_positive(_ptr, _val) do {                           \
> > +     typeof(_ptr) ptr = (_ptr);                              \
> > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > +                                                             \
> > +     res = var + val;                                        \
> > +                                                             \
> > +     if (val < 0 && res > var)                               \
> > +             res = 0;                                        \
> > +                                                             \
> > +     WRITE_ONCE(*ptr, res);                                  \
> > +} while (0)
> > +
> > +/*
> > + * Remove and clamp on negative, from a local variable.
> > + *
> > + * A variant of sub_positive(), which does not use explicit load-store
> > + * and is thus optimized for local variable updates.
> > + */
> > +#define lsub_positive(_ptr, _val) do {                               \
> > +     typeof(_ptr) ptr = (_ptr);                              \
> > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > +} while (0)
> > +
> > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > +static unsigned long task_h_load(struct task_struct *p);
> > +
> > +static __always_inline
> > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > +{
> > +     struct sched_entity *se = &p->se;
> > +     s64 delta_exec, vlag = se->vlag;
> > +     unsigned long cfs_load;
> > +     struct rq *rq;
> > +
> > +     WARN_ON_ONCE(se->on_rq);
> > +
> > +     /* Negative lag is managed by delayed dequeue path */
> > +     if (vlag <= 0)
> > +             return;
> > +
> > +     rq = rq_of(cfs_rq);
> > +
> > +     /* No fast access to prev rq task clock */
> > +     if (flags & ENQUEUE_MIGRATED)
> > +             return;
> > +
> > +     /* Compute sleep time */
> > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > +     if (unlikely(delta_exec <= 0))
> > +             return;
> > +
> > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > +     if (unlikely(delta_exec >> 32)) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Use cfs' load and p's weight to estimate what would have been the
> > +      * share for p. task's load contribution to cfs' load is replaced by
> > +      * its weight.
> > +      */
> > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > +     lsub_positive(&cfs_load, task_h_load(p));
> > +     if (cfs_load) {
> > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > +
> > +             delta_exec *= weight;
> > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > +     }
> > +
> > +     vlag -= calc_delta_fair(delta_exec, se);
> > +
> > +     /* vlag can't become neg while sleeping */
> > +     se->vlag = max(0, vlag);
> > +}
>
> Look:
>
> Let's say we have 3 tasks named TA, TB and TC. They all have the same
> weight and the same slices. So TA gets picked, works for a while and then
> sleeps for less than the rest of its slice.
>
> So the part that I hate and love, math. For your diff, we do:
>
> (sleep_time * weight) / (3 * weight)
>
> 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> have the same weight.
>
> So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.

yes, we assume that TA would have run 1/3 of its sleep time

>
>
> Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?

why is this wrong ?

Assuming TB and TC have the same vruntime before placing TA, the
average vruntime is avg == V(TB) == V(TC).
place_entity will do V(TA) = avg - 2
After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
avg' = (3*avg - 2) / 3 = avg - 2/3
TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3

>
> If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> So we would do V - 3.

Which would end up once placed to
avg' = (3*avg - 3) / 3 = avg - 1
TA's lag is : (avg - 1)  - (avg - 3) = 2
TB's lag equals TC's lag : (avg - 1)  - avg = -1

>
> Now our objective is to add the sleep_time of the task to -3.
> Because if the task didn't slept, in that time it would be working
> instead of sleeping.
>
> So, we should do V - 1. But we do V - 2.

Why ?
You assume that the whole sleeping time would have been spent by TA
running on the CPU but we don't really know. We can assume that a task
with positive lag should run first, but this also depends on other
tasks enqueued.
My first version assumed the whole sleep time would have been used to
run which is optimistic. Peter suggested using the ratio of weight and
cfs loads instead which accounts more fairly for the running time.

>
>
> AFAICT, we can't already know for sure how much will a task run even
> when the sleep_time is smaller than the slice. Because of preemption
> :-(.
>
> The cleanest, the simplest and maybe the worst or the best solution I can think of
> is just setting lag to 0 on every wakeup with positive lag TBH.

Keeping eternal positive lag for a long sleeping task is unfair but on
the other end, clearing all positive lag for a micro sleeping or
because of waiting on a shared lock is also unfair

>
> Or maybe, try to calculate when sleep_time is smaller than the slice,
> but just set the lag to 0 when sleep_time is bigger or equal to slice.

There is a difference between sleep time and lag. Even with a sleep
time longer than the slice, the task can still have positive lag after
sleeping (this is also true for runtime). All this depends on how many
other tasks are running simultaneously and their weight

>
> What you think?
>
> Sreehc,
>
> Kayra
