Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795000887;
	b=E1wwxw/tFyHE4csuLibqcjBqntzjYcRqrj5wsKKLqUSOxXHOaH7rx/x4bjmC4V7reaTT
	 aPmqyyWzuaQDZzd3zBKM8GyaPy0DeN4g1j2dsdlZ/HJBcbfTErQA3fkB6ngu1KCa8npUI
	 rMivvwqdtCLWc3SB9M93e5d2AAegJq36MZY+fZHNJ+7p8G9+fG+pZpMgHePb7MuEYgeL6
	 zbgBYVldt1gQeEVbDnD0EEZEP0bsQQzV0hEN+SIjES1GCs9/OeTXgSOjE9QMU3y98YmwA
	 lrvK/d0H0Mq8TRwVSZCISLMjyebJ7VVSC/YxwjADQ2+cOtvmwIMcrlIDAB5rTIwM/pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
	b=IcsDFZnTB0fEfNgezdPo0emUorERZwHfn5SylemyTA0FAywKKTRdDLxdWsI74XGHFK0u
	 I0FyJnYVG1kayK/jiD+mAZyaL5d3lCcz7xf6IhPN4drhCJv/Ptn5XgG4dKx0Rw+Q8/i7k
	 Dwj+TxRfFoHG5jX3ZRAQk98ZESIaey4CsIZcbb5vAxwHNLtwgiJbsL4HwMUhNhuhbHlqZ
	 nJZ2LWD8bpAPI85CBRIhD0m+WaLvGcHgEygm7NX9TidTf/jN1VFY+FXCl+w9Fi9eUEtiH
	 CaNsCrsiNHADpMA36WtAAR7/iQffLS0dhlhEDXun7y33SLawq257MmJIZFauFBlx2hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nfzgg1pn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C118606A325
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 11:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C118606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nfzgg1pn
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so2096239eec.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 03:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795000885; cv=none;
        d=google.com; s=arc-20260327;
        b=ivofr7j8hR7hoFGBdfMuzNcH9z6a/PUWQBIxqXvUiFI9Hepbs8lb26FmW6PWAmJx2W
         I4dUvofEBdRcVth8UT9SDRs0i8hm++LcHxc8cfVX086UgIGOF3xcgZbjUs8eWVevdlgT
         Kj8CvAj91Phn6nUya/WahbnTefurCPpjVfa/tj2Jqh6g5AEayhOZM83piL6780DPTOFO
         53KUdTkDMhlH5VHD/rcjMStRSRG945YFOrEww+ee+T/JAXXf5PvA+yKbZto6qP61Txei
         CIOyXGT5dbu+sCfj7qo9OJ9U2ZI86O9Kmd0+pGxqWCgucESoVmgFuD8N99Pop5lz6jvC
         hL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        fh=u7jNAc1ZHUOnEO38HOuYH6TZqp79PipwTFxySWSzxPo=;
        b=gtt+H7j6Bf1Qso3j2aob040sByM30Q852xp7TDOtHogl9D3LXaw5OIW3TqcEHWWIzV
         Nlmew1SZJJK2PTjCFFOTVVKJTXVgOcmvHZHbRrXxuc1AVYyrPePHXBbvfri6d5Ig9jHs
         RNzMdrvHGa8DWAVOHSwgiUHO4Yrjxc+wGq8aKY/JmUJfnJaOYSK+OARRu1Lh4kvGWF3i
         Z1YEn2y4eZCxXaBBIIlx+OYcBlzcesYzlAnFYZW9FMojt20YS7SsQKq5+uHaakjO5R7b
         ouAtCYBgRe+Y4Objl2ibTypts3udAQ5X1a0a3j2Q5tu7w5W84iDVaczFLzEYjvBc6gLP
         lSXA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795000885; x=1795605685; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        b=nfzgg1pnazAkmV9ogLbWCh07X75BQJE+pi69X2QW4Bw3jSDgIjsSJ45fdiRTD750mY
         p0jYAF/KeYjd8JfrfJFh108lWnproJFjP9hI+zJaeDHUbMaq1pgDmPZ7Sgz/mGIiB0oI
         n+9u6/ZxvqYqTgc0hq0MHXS/M46oTzyfAtvQZOXWTyWkTaHnNhuOWfWumJ2ENJBH1qJA
         B1caG6QdwQ5hy59Z4tnlbOQApXFWeXrCY5xJJOsemwqJ8t5gsNBCeYlqUIZMjsv4+O8g
         0RZ9VzeXeDCGVW23NbDVvBFE3g4vyAffpiQOi/e219JtsymZDAQ2kKncrYcpctwSKYjs
         j2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000885; x=1795605685;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ftWeT9v9vnvRt2kmLZwEf0dDqTmHNYp8z9nzUAEucvg=;
        b=Z/W5XObmmYWv0g+zjFwuzBQcTw+dXlt86Tm66CUANNNDJWGbe4kILDZEDutVKXHSJj
         zEXXyD6sZ50QOeMJy77z5zTnQpcA4JAxLKUFEg1QdkhmazElnFLc7GRMVMPU/GACD6zw
         XD5sYryxRPvDO5F9kL+Er3HNjuBMcatUZa0bykkN4EVGd8rt/+Ll5beWCFL+t38asVpL
         WxZEY/yL6HybD1ElNIG3/hEWYaB5b7briugVQWzMojstxSDub0oBkSCqk7DPJkzErKmO
         6lFYPEd5NowoZZzVy4PRyb7/atUH1FcX9jvLphBygSrel6ZXm73D2vXP9aLXiSKdqmxV
         TSTA==
X-Forwarded-Encrypted: i=1; AL+hErHdALarOYto0q9Mm3CQjPEgSLSY5X74CpoT8bhV1RZtuB0/NxsnlkqJAV1iVo2NlRXw3VvXHkZxH94=@lists.linux.dev
X-Gm-Message-State: APuU4Z+tauRdtVc/8mcPhUHFPiO9akNVcd53vE/WoOlU+Inr/0LgrbvD
	/IWUwKsjtDfdCR5B0yR1nHu0X9DW/NdKecLf4xk8WnLnaRNmjWtLtfGjawvy/iDinunH9AzTOUd
	4xThhSb0WA+cGy216HKQjXZE67xXfgiSkqNwsqT0WKA==
X-Gm-Gg: AYBFou08bHQcz4cUmXC2zePlywhkTw7TEZUqSfS804i6oIAKre87HqE0QyfMdgOlOHr
	k2iMv2KAl/cBClWbHbYyrpxglcnu8CWOEBA2IkBnKCYL+zRFOtuTygdPVes7DIeRkNxaj21bp1j
	PbZfkMfdkXX0nNFow4lJL7jX3nWwnkhESc7iRQUfhFtraGV2K39aPM8qbV2ZNGcG88egsFF0Xsd
	5SBuscF9rp8uJVfSQJds8CYwQkw4HTowrh6Fo/juG8txhtYdc+GN19UJwmqCh9Y/0BAILQUSlZf
	8XvuQ4U6EPWtNYZkIVeAIG5/cgVSIbbEBaw5Kv4da7uFOe2ZDU2/kWGZoxy6hN31kDPmcgADBsx
	uChkr4TqGVAPem8mfZbWmyDqZiKncZpYNogOYG4qdDCn8Pq7pEG46mgqN3od4tItRZ8c+
X-Received: by 2002:a05:701b:4588:20b0:1b2:610b:878 with SMTP id
 a92af1059eb24-1b543c3693bmr2080228c88.6.1795000885174; Wed, 18 Nov 2026
 03:21:25 -0800 (PST)
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
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com> <av1uqTFI46wRb0ok@scheduler.schedules>
In-Reply-To: <av1uqTFI46wRb0ok@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 18 Nov 2026 12:21:10 +0100
X-Gm-Features: AclHuK9YhWIoWx_QC_rN-ICEQIlD18KQ9aWWGzZ60ZJoewobyLYX02l8R4wpJP0
Message-ID: <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>
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

On Wed, 18 Nov 2026 at 11:58, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> > On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > >
> > > Hi Vincent!
> > >
> > > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > > lag while sleeping, a task should not keep a positive lag forever.
> > > >
> > > > The sleep duration and the weight are used to decay the positive lag at
> > > > wakeup.
> > > >
> > > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > > get rq_clock_task().
> > > >
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 0feec172fd37..5cd171f830d8 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > >       return avruntime - vlag != se->vruntime;
> > > >  }
> > > >
> > > > +/*
> > > > + * Signed add and clamp on underflow.
> > > > + *
> > > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > > + * memory. This allows lockless observations without ever seeing the negative
> > > > + * values.
> > > > + */
> > > > +#define add_positive(_ptr, _val) do {                           \
> > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > > +                                                             \
> > > > +     res = var + val;                                        \
> > > > +                                                             \
> > > > +     if (val < 0 && res > var)                               \
> > > > +             res = 0;                                        \
> > > > +                                                             \
> > > > +     WRITE_ONCE(*ptr, res);                                  \
> > > > +} while (0)
> > > > +
> > > > +/*
> > > > + * Remove and clamp on negative, from a local variable.
> > > > + *
> > > > + * A variant of sub_positive(), which does not use explicit load-store
> > > > + * and is thus optimized for local variable updates.
> > > > + */
> > > > +#define lsub_positive(_ptr, _val) do {                               \
> > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > > +} while (0)
> > > > +
> > > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > > +static unsigned long task_h_load(struct task_struct *p);
> > > > +
> > > > +static __always_inline
> > > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > > +{
> > > > +     struct sched_entity *se = &p->se;
> > > > +     s64 delta_exec, vlag = se->vlag;
> > > > +     unsigned long cfs_load;
> > > > +     struct rq *rq;
> > > > +
> > > > +     WARN_ON_ONCE(se->on_rq);
> > > > +
> > > > +     /* Negative lag is managed by delayed dequeue path */
> > > > +     if (vlag <= 0)
> > > > +             return;
> > > > +
> > > > +     rq = rq_of(cfs_rq);
> > > > +
> > > > +     /* No fast access to prev rq task clock */
> > > > +     if (flags & ENQUEUE_MIGRATED)
> > > > +             return;
> > > > +
> > > > +     /* Compute sleep time */
> > > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > > +     if (unlikely(delta_exec <= 0))
> > > > +             return;
> > > > +
> > > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > > +     if (unlikely(delta_exec >> 32)) {
> > > > +             se->vlag = 0;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > > +      * its weight.
> > > > +      */
> > > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > > +     if (cfs_load) {
> > > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > > +
> > > > +             delta_exec *= weight;
> > > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > > +     }
> > > > +
> > > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > > +
> > > > +     /* vlag can't become neg while sleeping */
> > > > +     se->vlag = max(0, vlag);
> > > > +}
> > >
> > > Look:
> > >
> > > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > > weight and the same slices. So TA gets picked, works for a while and then
> > > sleeps for less than the rest of its slice.
> > >
> > > So the part that I hate and love, math. For your diff, we do:
> > >
> > > (sleep_time * weight) / (3 * weight)
> > >
> > > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > > have the same weight.
> > >
> > > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> >
> > yes, we assume that TA would have run 1/3 of its sleep time
>
> But if sleep_time + working_time < slice for TA is true, there is no
> guarantee that it will run 1/3 of its sleep_time.

Even if sleep_time + working_time > slice.

>
> >
> > >
> > >
> > > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> >
> > why is this wrong ?
> >
> > Assuming TB and TC have the same vruntime before placing TA, the
> > average vruntime is avg == V(TB) == V(TC).
> > place_entity will do V(TA) = avg - 2
> > After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> > avg' = (3*avg - 2) / 3 = avg - 2/3
> > TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> > TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> >
> > >
> > > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > > So we would do V - 3.
> >
> > Which would end up once placed to
> > avg' = (3*avg - 3) / 3 = avg - 1
> > TA's lag is : (avg - 1)  - (avg - 3) = 2
> > TB's lag equals TC's lag : (avg - 1)  - avg = -1
> >
> > >
> > > Now our objective is to add the sleep_time of the task to -3.
> > > Because if the task didn't slept, in that time it would be working
> > > instead of sleeping.
> > >
> > > So, we should do V - 1. But we do V - 2.
> >
> > Why ?
> > You assume that the whole sleeping time would have been spent by TA
> > running on the CPU but we don't really know. We can assume that a task
> > with positive lag should run first, but this also depends on other
> > tasks enqueued.
>
> If TA didn't got preempted, and its sleeping_time + working_time is
> smaller than its slice, the whole sleeping time would have been spent by

You can't assume this to be always true, and we don't know how long it
was running. A positive lag of 2 as in your example doesn't mean that
TA runs 1 ms in its slice and would have run 2 ms more if not sleeping

> TA. Even if it did get preempted, there is no guarantee that it would
> work 1/3 of its sleeping time.
>
> > My first version assumed the whole sleep time would have been used to
> > run which is optimistic. Peter suggested using the ratio of weight and
> > cfs loads instead which accounts more fairly for the running time.
> >
>
> IMO, for a task like TA assuming it will work in its sleeping time
> is better than assuming it will work as 1/3 of its sleeping time.
> Or atleast less-bad, no? :-).

That depends on the PoV you take. The reality is that TA could have
run from 0 up to its full sleeping time (even if the sleeping time is
longer than a slice). Assuming it will run for the entire sleeping
time is one extreme, while assuming it won't run at all is the other
extreme. The reality is probably in between. The longer the sleeping
time, the closer the expected run time would be close to 1/3.

>
> > >
> > >
> > > AFAICT, we can't already know for sure how much will a task run even
> > > when the sleep_time is smaller than the slice. Because of preemption
> > > :-(.
> > >
> > > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > > is just setting lag to 0 on every wakeup with positive lag TBH.
> >
> > Keeping eternal positive lag for a long sleeping task is unfair but on
> > the other end, clearing all positive lag for a micro sleeping or
> > because of waiting on a shared lock is also unfair
> >
> > >
> > > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> >
> > There is a difference between sleep time and lag. Even with a sleep
> > time longer than the slice, the task can still have positive lag after
> > sleeping (this is also true for runtime). All this depends on how many
> > other tasks are running simultaneously and their weight
> >
>
> > >
> > > What you think?
> > >
> > > Sreehc,
> > >
> > > Kayra
>
> Ah, you didn't understand my joke, sad. :-(.
>
> Sknaht,
>
> Kayra
