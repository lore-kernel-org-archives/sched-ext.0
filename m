Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999535;
	b=Du4lmC/RKticjd1zvuc899BLhEDa3/0U4YcsVrjYqJCVehDJsJlBdxGRH9gg4V3t57Yq
	 tqpz9IoJTN37fwDOIfygLucJokb7LDRVfNyT57Vw0k4lp26MCkts3op82XdMLoVAniG6B
	 fk77hh7PpmFPvrSTEhuRbqWPQnKNsJiqbuUHRoPUV+hCsNZzE5q7LMz8E7oAAKqTCL1iY
	 0/je5yHPst+UOSZahvUnpIgLggSPRfLFU8TC1qIfOetUkFdQ1SChTQRo5sIeJ0W9TFcKU
	 A0GSWH7zloRuVIR/qNZ/YI5auwuEF/i2mRVGp0H3aydGf9u6lCbY04qUC0fwfPdh15w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
	b=IHt5qDSoxtIdbJTDMe+zX4OK/0GshpQACsLlfyowQhkiurZgpVnqLGOOfNQ3HXkTMHta
	 2llhj0r2QiCScYrI04kByKV5sIm4duG34FKH9V3Sa3Ig7XWaem17kKIprAYPimEC+fgVu
	 TMgXbm/QRcyeS/nk6iylwDXMnYcZ/t18EKn6wzgGbasOVTNXs7HbvyecLBZc+qYkCjkyn
	 JCnCjjKiNSgPC31rdRk0wiWPtfG6U6e7Uqp9cBq9zjRSgy9nRvZwolXZyitIWZRlpTkDD
	 zm+Y66AkF4MY5rB2lc+UvRp4QxCi3DmzN6rpTyFGy+0YzmpJ3s8k3CK14yK2hC6n1+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FmxhOH/d";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9261606A320
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 10:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9261606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmxhOH/d
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a440c9e13aso18808f8f.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794999533; x=1795604333; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
        b=FmxhOH/dSO7qZkcegpE+SN+DlvLRLcSvCfhNO477NT6FpwxClMj60x4nOwk1dYqbBG
         8xXYz4SyYOnvnEdwbpYLVr3FT7AbBVKKdSEUZLzvV+n3vP5WzZuSXOipPLr0PoKa/Cpi
         Q73GlE38LZmQ1oYKOZGCf9Dx/iAurULW4E1db5Cni+SgiQX+U39S2lOuocl14C1iol2n
         uW6Y8VGYNTrIAXkvYFbNR0Tb+xbOllgjEA8nnT2EjzFy1YkaY0BKVZUHvUYTkaOMoUQ/
         /hDwgBZbNmZyGHFYjbbMlGlqyO/CkkNsOvDoaxxCeeo/+TMb9GBCYZjOsCK05d38sDpK
         LpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999533; x=1795604333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOokTz1G9UcB/naYSeBX2ofw41eva17L+gF1HVq9r8Q=;
        b=LdGZN55SgCF8OzmGWC2ohbY7sAzZRAqF+3IUxZG2StQMkR9ianszXIEUMPCRWjnSVd
         oQlQ2cvwYYVGYVpi8V5Nmome+r8nO8FFyAdiGGDQgUaGDRzx8yCaRLwsOejwGU/mtb9d
         Q5bQVgJPAYj/kgt40k4UNJkTOcS9uwgA9BcoWoOo2UjDKu2Ql7+bT0nDXFu2E87uyGeo
         F78e0NNo6J09hLIf5FipqXlwwpG0Rnvmh/RW/NxlYh5l16Zsp5flbcpTRARic5Cf1D4Y
         Bx6aRy6YLsJS0TgN/YXDEyM//MoNuKh319rfmemmWwW+XUsrc1NHI0BwTz6NrbPqbZcg
         8e9A==
X-Forwarded-Encrypted: i=1; AL+hErHNrYRG25sclT9gOmVCUXVbKzxtkf1kwNiM0t0GTtKYTIBzZw68+fGW7j/uSUjxha93mClhWGFLTjQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+ULa0tBdBoHsvHKFI0q7D5dzgaIeo0RSOYOdsxahLgnY7HylE0
	3uZZTUH/lpunSZpt8Jou+NSsizFlCJGHVz32mQRgGKw15bGcLwKVQ81/
X-Gm-Gg: AZFdTZeC59SqGfZAP0mapck2IJgQWD9TKtIMhMh4k98J7OX3sm7ZeDNilmn449d/Tqy
	0TF4BLaUaQUH55eP7JzlW9ZRGILFek9b1iE/FN9Kh0zmn3S9ykx2A141flSB4DDgB746/PFHOSz
	G2HCgdVmMK6MIPdIYz5cO8qkBRVWcVyVScCq6DrS1zO5ADo4AR+qzAl+XA9N+i1HCOFW6BOguQu
	C7M2W4Z95lsVS1xIePygoTMIBzyI6I74yjR4avWU+Ad/aX7UQ4zvFZd8rmJdtZ+Nc4N6OBN1PuG
	s9Rgo8IsDOA4z1L63PGYrk0niTBEGVOh82ZypAvuJF0rZ3jvj3gsY5BP1/1a7MKTPFp44jojLOk
	i2a4+Ys7T1+cZyS0vnAAlc0DPpzaAVvDSDK2PDdf/JO1roG8YeTXhUNYqy357JOZwvwFuiZKRLs
	QxlRIU4Jm+0rqe01udoRSiQKJf+VHsv9g28GGJcogLQ+AKpxwNE/3hkoQGlOvFzteazwQN+gqSd
	DTYhph7Xl/ZqNe0gsf8s6EfAie+kYfnhhc5aPpfIYjnqgMg7GUr/emAzGNd01WstsxGy3zit5Rv
	NAQ0Me4orivCSf7XOwsg5LQEz/K6KLtPhlw7DW6xpTj9ArP4fN0wWHk=
X-Received: by 2002:a05:6000:18a5:b0:4a6:bc53:2472 with SMTP id ffacd0b85a97d-4a6bc626a3dmr3453644f8f.5.1794999532857;
        Wed, 18 Nov 2026 02:58:52 -0800 (PST)
Received: from scheduler.schedules ([85.100.69.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560ab59sm3871525f8f.29.2026.11.18.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:58:52 -0800 (PST)
Date: Wed, 18 Nov 2026 13:58:48 +0300
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
Message-ID: <av1uqTFI46wRb0ok@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
 <avr4MsRsjGfGHKKk@scheduler.schedules>
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
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
In-Reply-To: <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>

On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> >
> > Hi Vincent!
> >
> > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > lag while sleeping, a task should not keep a positive lag forever.
> > >
> > > The sleep duration and the weight are used to decay the positive lag at
> > > wakeup.
> > >
> > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > get rq_clock_task().
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 0feec172fd37..5cd171f830d8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >       return avruntime - vlag != se->vruntime;
> > >  }
> > >
> > > +/*
> > > + * Signed add and clamp on underflow.
> > > + *
> > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > + * memory. This allows lockless observations without ever seeing the negative
> > > + * values.
> > > + */
> > > +#define add_positive(_ptr, _val) do {                           \
> > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > +                                                             \
> > > +     res = var + val;                                        \
> > > +                                                             \
> > > +     if (val < 0 && res > var)                               \
> > > +             res = 0;                                        \
> > > +                                                             \
> > > +     WRITE_ONCE(*ptr, res);                                  \
> > > +} while (0)
> > > +
> > > +/*
> > > + * Remove and clamp on negative, from a local variable.
> > > + *
> > > + * A variant of sub_positive(), which does not use explicit load-store
> > > + * and is thus optimized for local variable updates.
> > > + */
> > > +#define lsub_positive(_ptr, _val) do {                               \
> > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > +} while (0)
> > > +
> > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > +static unsigned long task_h_load(struct task_struct *p);
> > > +
> > > +static __always_inline
> > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > +{
> > > +     struct sched_entity *se = &p->se;
> > > +     s64 delta_exec, vlag = se->vlag;
> > > +     unsigned long cfs_load;
> > > +     struct rq *rq;
> > > +
> > > +     WARN_ON_ONCE(se->on_rq);
> > > +
> > > +     /* Negative lag is managed by delayed dequeue path */
> > > +     if (vlag <= 0)
> > > +             return;
> > > +
> > > +     rq = rq_of(cfs_rq);
> > > +
> > > +     /* No fast access to prev rq task clock */
> > > +     if (flags & ENQUEUE_MIGRATED)
> > > +             return;
> > > +
> > > +     /* Compute sleep time */
> > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > +     if (unlikely(delta_exec <= 0))
> > > +             return;
> > > +
> > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > +     if (unlikely(delta_exec >> 32)) {
> > > +             se->vlag = 0;
> > > +             return;
> > > +     }
> > > +
> > > +     /*
> > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > +      * its weight.
> > > +      */
> > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > +     if (cfs_load) {
> > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > +
> > > +             delta_exec *= weight;
> > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > +     }
> > > +
> > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > +
> > > +     /* vlag can't become neg while sleeping */
> > > +     se->vlag = max(0, vlag);
> > > +}
> >
> > Look:
> >
> > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > weight and the same slices. So TA gets picked, works for a while and then
> > sleeps for less than the rest of its slice.
> >
> > So the part that I hate and love, math. For your diff, we do:
> >
> > (sleep_time * weight) / (3 * weight)
> >
> > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > have the same weight.
> >
> > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> 
> yes, we assume that TA would have run 1/3 of its sleep time

But if sleep_time + working_time < slice for TA is true, there is no
guarantee that it will run 1/3 of its sleep_time.

> 
> >
> >
> > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> 
> why is this wrong ?
> 
> Assuming TB and TC have the same vruntime before placing TA, the
> average vruntime is avg == V(TB) == V(TC).
> place_entity will do V(TA) = avg - 2
> After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> avg' = (3*avg - 2) / 3 = avg - 2/3
> TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> 
> >
> > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > So we would do V - 3.
> 
> Which would end up once placed to
> avg' = (3*avg - 3) / 3 = avg - 1
> TA's lag is : (avg - 1)  - (avg - 3) = 2
> TB's lag equals TC's lag : (avg - 1)  - avg = -1
> 
> >
> > Now our objective is to add the sleep_time of the task to -3.
> > Because if the task didn't slept, in that time it would be working
> > instead of sleeping.
> >
> > So, we should do V - 1. But we do V - 2.
> 
> Why ?
> You assume that the whole sleeping time would have been spent by TA
> running on the CPU but we don't really know. We can assume that a task
> with positive lag should run first, but this also depends on other
> tasks enqueued.

If TA didn't got preempted, and its sleeping_time + working_time is
smaller than its slice, the whole sleeping time would have been spent by
TA. Even if it did get preempted, there is no guarantee that it would
work 1/3 of its sleeping time.

> My first version assumed the whole sleep time would have been used to
> run which is optimistic. Peter suggested using the ratio of weight and
> cfs loads instead which accounts more fairly for the running time.
> 

IMO, for a task like TA assuming it will work in its sleeping time
is better than assuming it will work as 1/3 of its sleeping time. 
Or atleast less-bad, no? :-).

> >
> >
> > AFAICT, we can't already know for sure how much will a task run even
> > when the sleep_time is smaller than the slice. Because of preemption
> > :-(.
> >
> > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > is just setting lag to 0 on every wakeup with positive lag TBH.
> 
> Keeping eternal positive lag for a long sleeping task is unfair but on
> the other end, clearing all positive lag for a micro sleeping or
> because of waiting on a shared lock is also unfair
> 
> >
> > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> 
> There is a difference between sleep time and lag. Even with a sleep
> time longer than the slice, the task can still have positive lag after
> sleeping (this is also true for runtime). All this depends on how many
> other tasks are running simultaneously and their weight
> 

> >
> > What you think?
> >
> > Sreehc,
> >
> > Kayra

Ah, you didn't understand my joke, sad. :-(.

Sknaht,

Kayra
