Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005151;
	b=001sZujcNlCMM9ws/cZjcsFblQ4uQCr8s+GB2JdzHcMPEyhi/wuwMYHlFeGQqHNiL5PO
	 7OcxQVnfW71FPxcIbOuBUMBru/tbMQ+XbMX/fvl8aIB7ZjRtJJ303qiAvduKSVX5FKlTT
	 98Xph8DZtQ+kh9J4HiwTTtzOsti1XVF8NTY75ZzWExvtjaU6fl1GQ5+K3LpAbaKhoQ05B
	 s/qNv+hbXX7o2cecfAvyXVnAoz/HRj+XyKBUeDiRnI7RIsuzIED99ZaPRjIuHpa2JFBYg
	 OJuUdiPGZNHW3Hn8n87/aj8ucNKVpOWwfBGteXDPjnA8zz0j8h5XeXtIez/4poTpw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
	b=Eayk6FDQt/Uv3Pj8SB4NVHCpahd4gxQPHfHmofRXG98wUC9Q2BMp7EfYdaxcagWisSZF
	 sRn9CnzxH6Dt+IP+V4eZx2Tdxg267oC2VLBYAxA1yNQSI4vpkCv93DW39OeA3uJCWpTdJ
	 BlLU75uA1BVEcduW1rM+2uSgAkzppwVhJrOG1hCDaB3/CczS0m6dKsHMK1zF4g/5q5fX3
	 GQUJEQi4DGvRd3hGBkJcS6Jgo6zgyDSwgriqc5WV6QPexTTYDcjrkhDamrs5LlRKHibB0
	 uFZbJ56IkpxHJpX3Fq6MEJL1GDeLVvSJ3C/LOMxmpUdAy/eKoDRbYz0v/eG8g9blC5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mEXe/HhH";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F971606A32A
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 12:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F971606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEXe/HhH
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490380c73fbso78857f8f.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005150; x=1795609950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
        b=mEXe/HhHUdnYSHU/w/zHqH3XNcco2P2RgzwO9bTROJrS7tZEOVEYb9E7BptjJbNgoz
         ChwnTDRIpjFjr9uYykhQa23qfukuT5CcR21p5dbHvNuTbkD8X0fvivs2olb2x3xlA/O3
         B8Z40veD0dDkVHLh/HVNRdUnONZd2n7bB07l7v7YDe4gWMDvuThZ7tCiaQO1Ac9NWVbL
         wFiCwPLxpRUFRZk461eUuVMh9Y2VtywiC+0C8KN4uK5ybDwSiWf+OIlohG5t1dHphgQj
         0/bWho8zZ4e6mii9lxAJIH4PihRJ3bi2FeuVi0+mptdn9Y6m8fXDwEP3KFCijbWdsS5i
         TdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005150; x=1795609950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MegKunIxbKJmWXfHvvLlyDz6eGlSNoNkyHutakVtL/4=;
        b=bq2FRFlOaYJ+cn+JJDC3agXvQ40Yi5/18RMzG69TMrcZN2e7Ie4aGnd6VGKuKQ60jJ
         J0YXNdg3v9kp/1AONwnjecP4m3oiqI90DrUQmb2W0suEhIOnxNMRsfoco4Zraf0eb1OZ
         WlhtWoeaWimgKpYfWUyLmsnwBTiIzyORB/dEnXtt6V4AX4oYGS9FgaxEfo4wKQA7rKS0
         g4XnsA/6VhIVWya4xfYZL+QyeHP9kMmsF2QlRMTO5dbB5W5qhM3Z8Q5O0OJOPFRCCMEF
         oSF2g6IUQbCX1oxDiLREk8a7SLHMSpwitw53dKd4AhL8TwZyf2Yjg+wAG9LnkoBDDDLK
         +mXA==
X-Forwarded-Encrypted: i=1; AL+hErHDgrxcNAsU7bRllXo7MC0M8l7Bo9D3H5w/EjDKZT4sflIUAw+iCdNMCyIyVwXN7l5VElc53FEN3ts=@lists.linux.dev
X-Gm-Message-State: APuU4Z8C3uvKqwhti0Ijq2StNEaiyjMXIW2qmXm9k+ptyLKnOnQiE3du
	0q3yPCOyeIHDgmJsx2twfP5rsF8tllbeRp/hVn7jN2B4aQCBHG6t2GTN
X-Gm-Gg: AZFdTZcIrDs9Fgy0PSAecCSNfp533XWb45WitU8TrYoxLuaDsYGXKsehEHaPiGPd9FF
	aT8YPvFyw95Cuipk8Rmrkdp7ixj+Zmv29ot/sKPAySm+wvA40EgOpQ/NLITP5/B+k97NgrvVppl
	eavg6VoV4w2oVJd8vSvirheNeZYyDe8OxavowGw201VTY/QpyyTmxs5NA6kWRdnPMxoWRS0Y/g9
	qgpuKV0cteH1LeHBjXvwTp0dCchGCQZTNUaFLaZmhDN1Sl4wBeUwbr8oTvCWLQpPwlxnuSRCfEZ
	lUTOG87d5KsqktyrofCOBU3bUvt0LP1tR+R3YsCEwWgqjN+OyxzOCUOU9DU1WjSZysQxg9e40LO
	cM4ssS4J8zhQOl6ZznXEcGM3kGz7X7dA35jdgR5OzEqSQM1/8M/Be6oVurhqViMyIRAqdDPNqDV
	xULpx3xouJHf7V7Cb4tGOOci11CCS4wNVvGAU2Ol9gPSMfer3rNdnCuudOltWuoq4E48MGBYEZq
	L4KXlH2MfmasTfg1ilAgC32+6uRIEqOFCLmfaxH264CfmAHDyFRrxFOZ5hLmCEN1Pf8R0uVIWWe
	/jPjrToOA9k1q39StGiwgcP9HyJWB3B4rg2rehyrxPXkj1H4z9Ed6cQ=
X-Received: by 2002:a5d:5f54:0:b0:4a6:bc53:246a with SMTP id ffacd0b85a97d-4a6bc626b7dmr4052393f8f.5.1795005149445;
        Wed, 18 Nov 2026 04:32:29 -0800 (PST)
Received: from scheduler.schedules ([85.100.69.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c11f4bsm4645746f8f.51.2026.11.18.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:32:28 -0800 (PST)
Date: Wed, 18 Nov 2026 15:32:25 +0300
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
Message-ID: <av2KuYNx1A-rCz0R@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
 <avr4MsRsjGfGHKKk@scheduler.schedules>
 <CAKfTPtBZ=Dc_X48EQ0yXMym0JrS=pWvbviyVyFri0tv5VdR3Eg@mail.gmail.com>
 <av1uqTFI46wRb0ok@scheduler.schedules>
 <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>
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
In-Reply-To: <CAKfTPtC7AmoSE4iev5qf0MMYDBHPpLMduYhz5XMDsMGiMNpy0A@mail.gmail.com>

On Wed, Nov 18, 2026 at 12:21:10PM +0100, Vincent Guittot wrote:
> On Wed, 18 Nov 2026 at 11:58, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> > On Wed, Nov 18, 2026 at 10:20:14AM +0100, Vincent Guittot wrote:
> > > On Mon, 16 Nov 2026 at 14:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > >
> > > >
> > > > Hi Vincent!
> > > >
> > > > On Fri, Nov 06, 2026 at 04:19:28PM +0100, Vincent Guittot wrote:
> > > > > Similarly to delayed dequeue, which enables an entity to decay its negative
> > > > > lag while sleeping, a task should not keep a positive lag forever.
> > > > >
> > > > > The sleep duration and the weight are used to decay the positive lag at
> > > > > wakeup.
> > > > >
> > > > > Apply the decay when enqueueing on prev rq for which we hold the lock to
> > > > > get rq_clock_task().
> > > > >
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >  kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
> > > > >  1 file changed, 90 insertions(+), 34 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index 0feec172fd37..5cd171f830d8 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > > >       return avruntime - vlag != se->vruntime;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Signed add and clamp on underflow.
> > > > > + *
> > > > > + * Explicitly do a load-store to ensure the intermediate value never hits
> > > > > + * memory. This allows lockless observations without ever seeing the negative
> > > > > + * values.
> > > > > + */
> > > > > +#define add_positive(_ptr, _val) do {                           \
> > > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > > +     __signed_scalar_typeof(*ptr) val = (_val);              \
> > > > > +     typeof(*ptr) res, var = READ_ONCE(*ptr);                \
> > > > > +                                                             \
> > > > > +     res = var + val;                                        \
> > > > > +                                                             \
> > > > > +     if (val < 0 && res > var)                               \
> > > > > +             res = 0;                                        \
> > > > > +                                                             \
> > > > > +     WRITE_ONCE(*ptr, res);                                  \
> > > > > +} while (0)
> > > > > +
> > > > > +/*
> > > > > + * Remove and clamp on negative, from a local variable.
> > > > > + *
> > > > > + * A variant of sub_positive(), which does not use explicit load-store
> > > > > + * and is thus optimized for local variable updates.
> > > > > + */
> > > > > +#define lsub_positive(_ptr, _val) do {                               \
> > > > > +     typeof(_ptr) ptr = (_ptr);                              \
> > > > > +     *ptr -= min_t(typeof(*ptr), *ptr, _val);                \
> > > > > +} while (0)
> > > > > +
> > > > > +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> > > > > +static unsigned long task_h_load(struct task_struct *p);
> > > > > +
> > > > > +static __always_inline
> > > > > +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
> > > > > +{
> > > > > +     struct sched_entity *se = &p->se;
> > > > > +     s64 delta_exec, vlag = se->vlag;
> > > > > +     unsigned long cfs_load;
> > > > > +     struct rq *rq;
> > > > > +
> > > > > +     WARN_ON_ONCE(se->on_rq);
> > > > > +
> > > > > +     /* Negative lag is managed by delayed dequeue path */
> > > > > +     if (vlag <= 0)
> > > > > +             return;
> > > > > +
> > > > > +     rq = rq_of(cfs_rq);
> > > > > +
> > > > > +     /* No fast access to prev rq task clock */
> > > > > +     if (flags & ENQUEUE_MIGRATED)
> > > > > +             return;
> > > > > +
> > > > > +     /* Compute sleep time */
> > > > > +     delta_exec = rq_clock_task(rq) - se->exec_start;
> > > > > +     if (unlikely(delta_exec <= 0))
> > > > > +             return;
> > > > > +
> > > > > +     /* For anything above ~4 seconds, save computation and clear the lag */
> > > > > +     if (unlikely(delta_exec >> 32)) {
> > > > > +             se->vlag = 0;
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     /*
> > > > > +      * Use cfs' load and p's weight to estimate what would have been the
> > > > > +      * share for p. task's load contribution to cfs' load is replaced by
> > > > > +      * its weight.
> > > > > +      */
> > > > > +     cfs_load = cfs_rq_load_avg(cfs_rq);
> > > > > +     lsub_positive(&cfs_load, task_h_load(p));
> > > > > +     if (cfs_load) {
> > > > > +             unsigned long weight = scale_load_down(se->h_load.weight);
> > > > > +
> > > > > +             delta_exec *= weight;
> > > > > +             delta_exec = div64_long(delta_exec, cfs_load + weight);
> > > > > +     }
> > > > > +
> > > > > +     vlag -= calc_delta_fair(delta_exec, se);
> > > > > +
> > > > > +     /* vlag can't become neg while sleeping */
> > > > > +     se->vlag = max(0, vlag);
> > > > > +}
> > > >
> > > > Look:
> > > >
> > > > Let's say we have 3 tasks named TA, TB and TC. They all have the same
> > > > weight and the same slices. So TA gets picked, works for a while and then
> > > > sleeps for less than the rest of its slice.
> > > >
> > > > So the part that I hate and love, math. For your diff, we do:
> > > >
> > > > (sleep_time * weight) / (3 * weight)
> > > >
> > > > 3 * weight here is TA + TB + TC, it equals to 3 * weight since they all
> > > > have the same weight.
> > > >
> > > > So if sleep_time equals 2, weight equals 1, and slice equals 3 this equals
> > > > 2/3. If the lag is 2, we do 2 - 2/3 resulting with 4/3.
> > >
> > > yes, we assume that TA would have run 1/3 of its sleep time
> >
> > But if sleep_time + working_time < slice for TA is true, there is no
> > guarantee that it will run 1/3 of its sleep_time.
> 
> Even if sleep_time + working_time > slice.
> 
> >
> > >
> > > >
> > > >
> > > > Later, place_entity() uses this formula to do V - ((Sum(weight) + weight) * lag) / Sum(weight)
> > > > So ((2 + 1) * 4/3) / 2 equals to 2. But this is wrong, no?
> > >
> > > why is this wrong ?
> > >
> > > Assuming TB and TC have the same vruntime before placing TA, the
> > > average vruntime is avg == V(TB) == V(TC).
> > > place_entity will do V(TA) = avg - 2
> > > After placing TA, avg' = (V(TA) + V(TB) + V(TC)) / 3
> > > avg' = (3*avg - 2) / 3 = avg - 2/3
> > > TA's lag is : (avg - 2/3)  - (avg - 2) = 4/3 which is what we assumed above
> > > TB's lag equals TC's lag : (avg - 2/3)  - avg = -2/3
> > >
> > > >
> > > > If we didn't decayed lag: ((2 + 1) * 2) / 2 equals 3.
> > > > So we would do V - 3.
> > >
> > > Which would end up once placed to
> > > avg' = (3*avg - 3) / 3 = avg - 1
> > > TA's lag is : (avg - 1)  - (avg - 3) = 2
> > > TB's lag equals TC's lag : (avg - 1)  - avg = -1
> > >
> > > >
> > > > Now our objective is to add the sleep_time of the task to -3.
> > > > Because if the task didn't slept, in that time it would be working
> > > > instead of sleeping.
> > > >
> > > > So, we should do V - 1. But we do V - 2.
> > >
> > > Why ?
> > > You assume that the whole sleeping time would have been spent by TA
> > > running on the CPU but we don't really know. We can assume that a task
> > > with positive lag should run first, but this also depends on other
> > > tasks enqueued.
> >
> > If TA didn't got preempted, and its sleeping_time + working_time is
> > smaller than its slice, the whole sleeping time would have been spent by
> 
> You can't assume this to be always true, and we don't know how long it
> was running. A positive lag of 2 as in your example doesn't mean that

Can't we do deadline - vruntime? That would give us slice - work_time.
We already know the sleep_time.

> TA runs 1 ms in its slice and would have run 2 ms more if not sleeping
> 
> > TA. Even if it did get preempted, there is no guarantee that it would
> > work 1/3 of its sleeping time.
> >
> > > My first version assumed the whole sleep time would have been used to
> > > run which is optimistic. Peter suggested using the ratio of weight and
> > > cfs loads instead which accounts more fairly for the running time.
> > >
> >
> > IMO, for a task like TA assuming it will work in its sleeping time
> > is better than assuming it will work as 1/3 of its sleeping time.
> > Or atleast less-bad, no? :-).
> 
> That depends on the PoV you take. The reality is that TA could have
> run from 0 up to its full sleeping time (even if the sleeping time is
> longer than a slice). Assuming it will run for the entire sleeping
> time is one extreme, while assuming it won't run at all is the other
> extreme. The reality is probably in between. The longer the sleeping
> time, the closer the expected run time would be close to 1/3.
> 

Yeah :-(.

1. If we assume that TA will get preempted, we can't know how much it would
have run if it hadn't slept. And in that case 1/3 could be right or wrong.
We can't know.

2. If we assume that TA won't get preempted, we can know that it will run
in its whole sleep time.


In any case, we are doing a assumption in both of these.
TBH, I don't think there is a big difference.

I would still argue that assuming the 2nd one is better.
Although, if there is not a big difference I can't see
any reason to add a case for it.

I'm gonna play around with the whole series. Testing and other stuff.
Maybe I'll find something unexpected. While testing, I'll try to test
the difference between 1st and 2nd too. I don't think there will be a
big difference, but I'll still test it :-).

> >
> > > >
> > > >
> > > > AFAICT, we can't already know for sure how much will a task run even
> > > > when the sleep_time is smaller than the slice. Because of preemption
> > > > :-(.
> > > >
> > > > The cleanest, the simplest and maybe the worst or the best solution I can think of
> > > > is just setting lag to 0 on every wakeup with positive lag TBH.
> > >
> > > Keeping eternal positive lag for a long sleeping task is unfair but on
> > > the other end, clearing all positive lag for a micro sleeping or
> > > because of waiting on a shared lock is also unfair
> > >
> > > >
> > > > Or maybe, try to calculate when sleep_time is smaller than the slice,
> > > > but just set the lag to 0 when sleep_time is bigger or equal to slice.
> > >
> > > There is a difference between sleep time and lag. Even with a sleep
> > > time longer than the slice, the task can still have positive lag after
> > > sleeping (this is also true for runtime). All this depends on how many
> > > other tasks are running simultaneously and their weight
> > >
> >
> > > >
> > > > What you think?
> > > >
> > > > Sreehc,
> > > >
> > > > Kayra
> >
> > Ah, you didn't understand my joke, sad. :-(.
> >
> > Sknaht,
> >
> > Kayra

hint: try to read it backwards :-(.

Sreehc and Sknaht alot!

Kayra
