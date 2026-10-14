Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A65221D2
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992254; cv=pass; b=eaJYhLghGCMoTUqTcgwwh+3um6dJgDzc0syry5der0rtN6949fImGVXKRWIhZZVBf/48G+z6kufuy9dCIhjVRRTD/cljbJH0Ij6TEpHeR9DOxrxTN+DqCoUmDpAl0zwxpmq8Ii9mIgFS1uUDEq1/GVaKR7k//ZiVpImpfl7qoeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992254; c=relaxed/simple;
	bh=eN9RmH4BI2cnExW/4JcWr15L/o/fC5a8DaLSvML2mAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8fSw3lAfOLOLn+w+6gyLgnWqLMF3EEWzP8puAbPD8+ATfUUfE88UefIUCTFknISg0t1xdYlWmGKMIrowsTpm9CNG9q8284e6Aj22WixWOwvXxjYnBMDJB9e33BGxRzZF126vLPzrt7GgUQNyPczwLuUmuJpwl49Em0RmQ7ghnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2jJ9OyU; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2jJ9OyU"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2acc1e170cso721438866b.1
        for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 08:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791992250; cv=none;
        d=google.com; s=arc-20260327;
        b=d6SQX50kz7zPSpN/c8Ne1BgwAD+oNwjxHE3SVe0nMQfc6CctVzMIdqR05UjlJvpKfb
         /bbCUxeqOOyQgCCXU+Ya2IECuJmTdbxVgqg8AzbS27YRFi9K6DTMrzaTcHkTb+WCi6gM
         c8We+aZYRh6rDuKn1aTT7c1dOX1srfscUK4AQnLmLE3sBYgIjQBwTrXQ9+LBwjILsfil
         YreoS+XAEUoNwcnGsuTMa+HKYal09IsG2ZXr7wXNPQl6H6237RXueDaSLkd3n+fshhDq
         KuQwNwI+DHlkXIJ2UYJxLJnKmHj5qzpB+wmfne4UntSgTnBxEkshQyK7edauVsd4tcTl
         x2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        fh=dnVUX0GC6m2J9WHuuS4ZTE48uqXpJA1GPIScMpxeLpE=;
        b=eGwLq7z78bnP26HT4WK2CS/cKWmg9JR2ReX0l8Aag6/5B3x8e0yVUfX8E1N41s+Dy+
         WWeeGMTF+37uynrUqgegI8SEctyRAuuivEwFVwkGY0f8Np24JD9got4wQM3AHsmEJTTR
         z2fKT42K8Gmqx0QsQAIg2/kXEI4WM90nSxwoRAf5kTriMMqSF5Aut0R8RfpvAqfcvhG4
         M4Hc+SminFRyVFu/t6LVwcWl1y5vHUdEA82g9HTiO8FOFaZBWhXCkqdb4CO7LSCuyP8S
         hCBzbvfvYudrFD7Wva4ptITiOley7iUsyEaSFDWfaGwFvIaEDz96keB6+OxSxHFz9ua3
         P+dw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791992250; x=1792597050; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        b=l2jJ9OyUWgSe1/gGODR5X+xR04Zd81kvx0JtuCxdyCgZ7tE1C34pewIIWqzLxvQ6No
         eZlwlvOjMNJRzBFxQ72U0PS2Z1gmU/B1xUZmeOXUGK1TaOLI9AOzYzlSWLDKLli6luf9
         eYd/9GECER/hU+FQeT1J5NgPXZL1ESeCKE8i3mjUDWEk27tcdghBVtMHAV59XXCO0spo
         zWW7fmFg6upzsr6FGWQ9yPPYBc4g5fh5DSj722CqjWwcApvXHlDjZgCn+lTidD4IUSuG
         9X52t97o9gAezrQbfPvDSyUHeW/scqxHGSIbJOHZpjSa3aS4c/Rs55lpc6doyQUw5RuM
         YCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992250; x=1792597050;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        b=PsPbYC7HULnQBEEX+KtHQN5u9pmNsXutK8YXUAJWs/POoTH8Xwtywks1JLcwTsuSEh
         U3q4j4nnyrp0rKTg2QhQwIrWtGdRap7t3iWVOn8MP7H4bVe6SMBV1gw+slEOKVykfpEV
         4abynya/DHKwUnoPcEY9koBBVkwRwno47izVB8ZBlYlS4IZMiSOBnpoLFmZdal+adwLv
         DdHhKpPEQAenK9Lz7K+3YUnoU4rv/1chTLfwFeZSVcW5qwxpqqDmg2X2yg+wzIxeQdVm
         XqPiUKM9YrcvzD13qGNytrGnSL3uM87owAAjAiDdUvTzyIWG+u7OnDTE4JTOA3HjbGyz
         dEYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv6ken3vw8eJm4+4UFED3o8Iv3jS1fLilaYX8SRJC8nsHw+tYn9fRh7+vRTF4wOz52c66xOWomWys=@lists.linux.dev
X-Gm-Message-State: AFq9FYJBFQ91MQ6hkDHIfYYH+udKapcAnfS0CwxDTWCURHU5ytXvUFmP
	km5CZsTyiu1F9c/n43OodOw8awvC9PS8bPpoiM+R3EZHv99F59a2qLBn4oPsWEDQBNDRzXKwPOv
	Ab4i+0A/gaewo9ZnZ7zvHbC8jTj+yvMDcDk51Fc8ctw==
X-Gm-Gg: AYBFou2JvVNwcW0nuGWxnBs69vmiDJNINDJHYkPBR1b8ONALWmew4dPaws80670a953
	sRiosD8JoBD8z8QBZ2CoEGs7oncwRHsOlqOysIz0eOD/OM4ujui+aVISl8j8YBlImO+xovjG8ul
	M2tXmzuYOQLwfcgS5auedKtp/xbZgt/DGXbPk4P/PkTff1iuP1EFABWkXr5+ZzF5m3CoGw1T45Y
	8tXwQrx92YvNSMzWtUqoaMDUMT83nF/MP2a4XtVYVAQXy+VUWalcO6l2GUawkr7NIQXUCrkv1vE
	z4Xf0CvzHBMIuuY+asOaC1HCn3ut5gXHy0UJ4cmNaRufn2Wv0pQJcHmqqTSrdDxpzr6pdZjRPRg
	gEjJ+srnFGAs=
X-Received: by 2002:a17:907:eccc:b0:c25:4f7c:8ec5 with SMTP id
 a640c23a62f3a-c31aa0291acmr1487426866b.23.1791992249514; Wed, 14 Oct 2026
 08:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
In-Reply-To: <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Oct 2026 17:37:17 +0200
X-Gm-Features: AclHuK-CGGWcfZAYs4XYXiC55pivspaDbdCD0_NPFeWvFdImCVIM28r15KKP_4U
Message-ID: <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 16:07, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Hi Vincent,
>
> Disclaimer:
> I haven't read the full series yet. I will try to do. Sorry in case i read
> it wrong.
> Thought of quickly checking the push path since i had recently worked on it.
>
> On 10/2/26 9:14 PM, Vincent Guittot wrote:
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task doesn't have wakeup events anymore or at a far
> > too low pace. For such situation, we can take advantage of the task being
> > put back in the enqueued list to check if it should be pushed on another
> > CPU.
> >
> > Add a push task mechanism that enables fair scheduler to push runnable
> > tasks. EAS will be one user but other feature like filling idle CPUs or
> > short slice tasks can also take advantage of it.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/core.c  |   4 +-
> >   kernel/sched/fair.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/sched.h |   7 ++
> >   3 files changed, 172 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 837dc74c9a8d..18692b752814 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
> >    *
> >    * Returns (locked) new rq. Old rq's lock is released.
> >    */
> > -static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > -                                struct task_struct *p, int new_cpu)
> > +struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > +                         struct task_struct *p, int new_cpu)
> >       __must_hold(__rq_lockp(rq))
> >   {
> >       lockdep_assert_rq_held(rq);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f12678850ce2..00078ac7fada 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8179,6 +8179,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
> >       }
> >   }
> >
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
> > +
> >   /*
> >    * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
> >    *
> > @@ -8195,6 +8197,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >       bool task_delayed = flags & DEQUEUE_DELAYED;
> >
> >       clear_buddies(cfs_rq, se);
> > +     fair_remove_pushable_task(rq, p);
> >
> >       update_curr_eevdf(cfs_rq);
> >       update_entity_lag(cfs_rq, se);
> > @@ -9799,6 +9802,157 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       return target;
> >   }
> >
> > +DEFINE_STATIC_KEY_FALSE(sched_push_task);
> > +
> > +static inline bool sched_push_task_enabled(void)
> > +{
> > +     return static_branch_unlikely(&sched_push_task);
> > +}
> > +
> > +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (!task_on_rq_queued(p))
> > +             return false;
> > +
> > +     if (p->se.sched_delayed)
> > +             return false;
> > +
> > +     if (p->nr_cpus_allowed <= 1)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> > +{
> > +     if (!__check_pushable_fair_task(rq, p))
> > +             return false;
> > +
> > +     return false;
> > +}
> > +
> > +static inline int has_pushable_tasks(struct rq *rq)
> > +{
> > +     return !plist_head_empty(&rq->cfs.pushable_tasks);
> > +}
> > +
>
> Should this use static key?
>
> > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     if (!has_pushable_tasks(rq))
> > +             return NULL;
> > +
> > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > +                           struct task_struct, pushable_tasks);
> > +
> > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > +     WARN_ON_ONCE(task_current(rq, p));
> > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
> > +     /*
> > +      * Remove task from the pushable list as we try only once after that
> > +      * the task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
> > +
> > +static int
> > +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> > +
> > +/*
> > + * See if the non running fair tasks on this rq can be sent on other CPUs
> > + * that fits better with their profile.
> > + */
> > +static bool fair_push_task(struct rq *rq)
> > +{
> > +     struct task_struct *next_task;
> > +     int prev_cpu, new_cpu;
> > +     struct rq_flags rf;
> > +     struct rq *cur_rq;
>
> You likely need below to keep clang's context tracking to be happy.
>
>         context_unsafe_alias(rq);

I just noticed that I didn't answer to this one

Why should I need this ?

rq remains the same in fair_push_task(). I'm using rq and new_rq to
differentiate both current and new rq

>
> > +
> > +     next_task = pick_next_pushable_fair_task(rq);
> > +     if (!next_task)
> > +             return false;
> > +
> > +     if (is_migration_disabled(next_task))
> > +             return true;
>
> If migration is disabled, then it shouldn't endup on pushable_tasks?
>
> > +
> > +     /* We might release rq lock */
> > +     get_task_struct(next_task);
> > +
> > +     prev_cpu = rq->cpu;
> > +
> > +     /*
> > +      * We need to release rq lock and take both task and rq w/o
> > +      * triggering a deadlock.
> > +      */
> > +     raw_spin_rq_unlock(rq);
> > +
> > +     cur_rq = task_rq_lock(next_task, &rf);
> > +
> > +     /* Task already migrated */
> > +     if (cur_rq->cpu != prev_cpu)
> > +             goto skip_push;
> > +
> > +     new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
> > +
> > +     /* Task doesn't need to migrate */
> > +     if (new_cpu == prev_cpu)
> > +             goto skip_push;
> > +
> > +     update_rq_clock(cur_rq);
> > +     cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
> > +
> > +skip_push:
> > +     task_rq_unlock(cur_rq, next_task, &rf);
> > +
> > +     /* Restore rq state */
> > +     raw_spin_rq_lock(rq);
> > +     put_task_struct(next_task);
> > +
> > +     return true;
> > +}
> > +
> > +static void fair_push_tasks(struct rq *rq)
> > +{
> > +     /* fair_push_task() will return true if it moved a fair task */
> > +     while (fair_push_task(rq))
> > +             ;
> > +}
>
> Would it better to iterate through the list? This is bit difficult
> to read at first.
>
> In failure cases also, it can return true. No? for example,
> is_migration_disabled(), It is needed since you need to iterate the
> rq to see if there is a task to move.
>
> > +
> > +static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
> > +
> > +static inline void fair_queue_push_tasks(struct rq *rq)
> > +{
> > +     if (!sched_push_task_enabled() || !has_pushable_tasks(rq))
> > +             return;
> > +
> > +     queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), fair_push_tasks);
> > +}
> > +
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_push_task_enabled())
> > +             plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +     plist_node_init(&p->pushable_tasks, p->prio);
> > +     plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
> > +{
> > +     if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> > +             __fair_add_pushable_task(rq, prev);
> > +}
> > +
> >   /*
> >    * select_task_rq_fair: Select a target runqueue for the task.
> >    * There are 2 ways to select the target runqueue:
> > @@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
> >       cfs_rq->curr = NULL;
> >       if (se->on_rq)
> >               __enqueue_entity(cfs_rq, se);
> > +
> > +     /*
> > +      * The previous task might be eligible for being pushed on another cpu
> > +      * if it is still active.
> > +      */
> > +     fair_add_pushable_prev(rq, prev, next);
> >   }
> >
> >   /*
> > @@ -15379,6 +15539,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
> >               goto repick;
> >
> >       clear_buddies(cfs_rq, se);
> > +     fair_remove_pushable_task(rq, p);
> >
> >       if (on_rq)
> >               __dequeue_entity(cfs_rq, se);
> > @@ -15423,6 +15584,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
> >
> >       update_misfit_status(p, rq);
> >       sched_fair_update_stop_tick(rq, p);
> > +     fair_queue_push_tasks(rq);
> >
> >   repick:
> >       /*
> > @@ -15439,6 +15601,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
> >   {
> >       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> >       cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
> > +     plist_head_init(&cfs_rq->pushable_tasks);
> >       raw_spin_lock_init(&cfs_rq->removed.lock);
> >   }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e025d2a6c302..74130bd2a2c8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -721,6 +721,8 @@ struct cfs_rq {
> >               unsigned long   runnable_avg;
> >       } removed;
> >
> > +     struct plist_head       pushable_tasks;
> > +
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> >       u64                     last_update_tg_load_avg;
> >       unsigned long           tg_load_avg_contrib;
> > @@ -3877,6 +3879,8 @@ static inline bool sched_energy_enabled(void) { return false; }
> >
> >   #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
> >
> > +DECLARE_STATIC_KEY_FALSE(sched_push_task);
> > +
> >   #ifdef CONFIG_MEMBARRIER
> >
> >   /*
> > @@ -4209,6 +4213,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
> >       wakeup_preempt(dst_rq, task, 0);
> >   }
> >
> > +extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > +                                struct task_struct *p, int new_cpu);
> > +
> >   static inline
> >   bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> >   {
>
