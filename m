Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660953D955B
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962377; cv=pass; b=XDGKuWhEvolppxX870yFSdgZruuK/oaR1Q2NjpHZFGa5zTgHMsz9AA0rZ3iTDBtnFOVszZOESTQl9xsn62wUS8mK0WoA6PIWiqaMdQc50QfCkmrmf8NUOlK7iYFFW9sBdsC6FwPgssG9cxM146wFlAUj0ofn28RofvSwWdTT9Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962377; c=relaxed/simple;
	bh=+nKE0aerXq5zcerPMktiueb2dpi7N/wqcFUGs1sFppk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujTXoYl4e2NblSChM616R4+s6OX3OVtT+hMxqNwfpjBMJ9eLSVleDYFQW1XPKTFnFSNLdEa2t1+tn9mjw3ntabmCaJB6QFkMhkq8dJ2ACRbpCuYRWAa796FAnegKTDoOXGOn7OmawYxHjE/pikZdXqbviOADQK1NkgrwYwPMv9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmeO323I; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmeO323I"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so5760194a12.2
        for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 00:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791962374; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4fkyy7NqFP+RVykre+7V3HC74iwWjUAMOBjqg+8BEg9mTHXE1ir7yJ23VZaMhe400
         ipGKFWCTd4mUfMHhh8ucL6U3hni2ClVXoVhd3f/bTT9Nj7wBHG+kaET3UqNc9L1nj7Qh
         UzIrtzjUQfALHP9A2+8KL8deoHXki81iy32YTQ56nPQ4oeFfFxlQL98N2zAJp6yEavn/
         MizfTKJhrUQEu5qmJF9MpdP62Na4sKeXkDds1ePksAY4uJOBkMnjpDScbiZJSdjCjpR1
         bu5SDPDKHF0fZagZFhyogUb6RG38wuJCwYBEm7Lj5JFhl40VcC+Se+LHWwMx1p2Qaxwr
         U3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        fh=YEQOnSnj+fOCXAULcmu5yd9LiJRUJufEPDKLkPu0PoE=;
        b=qSgxlXpAT7NR/dPk761k7/2GapPmQ9zKl9Y/nkJI6LGJ1FQUJOZUVjDkxd0tVmz8Dy
         xL8+VFEhW0XIjxtuEw/yllDBKe755G0Y+fGly9UY3vC2eQ97WbR8nHc+k3GxYmKfvfKR
         UfJeCHpW59a51++w0L2RftI9qxx1H/4nYTK8ARu0iccS2JVIkKiIli/5NiE6oCmohSmK
         DRpW5VxjtCIuSUMhHePHrv+sYgx2pqSHvH0TEX1n7dz9kI38V4XH33txud/1f10qpk32
         rnWufJwZjULIMjYxQyy2RN8aOiimyQOKxdBtUGab9+jYyUh/j6IKzLV1RYT/pDKcvDpZ
         CqYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791962374; x=1792567174; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        b=lmeO323IBBC0JBxN0YSBqqSRbP7Lq4UZCI4KonkxZitmUeBHrL+N2+Y/zaMODWv3GG
         xiBPkuzQUzOg5nvjHMrTt9o4KWkTpQrVlgzQMjJafefeA4lT2oPN3mlwt5sZp+jnm0UG
         W40Y5pnJ6orky2OKzP336ubs44vqf7AmTYtAgi7GuwWba0gyzffv91PqgRk4ZUYhpT1B
         dB3Tkfj7XM57RVQgs+6hLE1FkktZTOIANFXKH0NNT4NR8S83XkyV/tmiaJyKEerd6FjL
         zXXtcDdI+RxgtKR8YtPgXdm3Im2BX6oog8nbzo1cKxx1snSHJC80lm7vuWd19UL9GHx4
         eGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962374; x=1792567174;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        b=CB8sMuvfVNAUzcnueSV53vPL0+KFAWzVuNKIjrj60HEtqAZWwzvXdsgURnKOnq2+r9
         MKRfJEL7EhDwFkkqcN44/ArC8dOmMUigg6Fmji3ICkr75grHXH+NN4Yngn/z+VmDVEFx
         4PhTHL59ilvIl/S5y0KjBmwdhFu5DukQbxDC/UZlUZuDART+AXQcjVB6LklQlrf+fyRm
         359FookuhYo5Q7q3dlCziXv4lkBtBEyD7Kp04m+CiKoRabS6sQtpKfEcPZMzIHYdqL8X
         DMd0gf3AUBE4+G138/9tvxT/UTuKRdpshnCCnf5KaruEMtapdCiRfMNM3jp8hZBl+E9I
         kVKA==
X-Forwarded-Encrypted: i=1; AKwUvBw6BP7la5olP3kQeJT4cSGxBqjGs09stX66J+Txlqd50QvjNrlDRP62Z6aYtkgXOuA/iXuxJlP2Qts=@lists.linux.dev
X-Gm-Message-State: AFq9FYI2OkuIfOSs6aYPVdoWHbx9qJ90BtpySL1awO4swAeaUySET0JE
	0Law9gwsIaFUeaGnAiqwIMQWFMibK/vje5Gt27ebPguRiOcjFU1KhFCQ6UrtNFcBRvYStCEpPlQ
	2WgABxbyOF8S3/TIX0WqJ/5qw7q7LDionkQtmHDBLUA==
X-Gm-Gg: AYBFou1hCF8QO6FCD0aUcllwPSjRUnrIVzET7OzwSt5IVrFpK1daWvBH4bgafl0W6OS
	KNRox8Q5ImAqZq+wk/r13p+gJuu3Mdku8+L5dX3pwJi+hBAjiz7aEje1fAaWDnLX0Gtn82hiLqX
	QdDyMYRZtqfWqZy1XyCvAwryXZeSfjAv6qp7v4LYdfZfKnPN6IyLs1MnSOINWFGb3dEGYlgJOgQ
	69qEOLSjEjjpCeyt578spENmE9lej+cOGmQly0nn2WvD1366F1XitolF0hB2GdD7aFI7sE/VIKF
	dtRVNt34KyNquJYuB8jDdYGKIDfvOXNTFgX5BkQ+GRoQ+bDTy19qazVQOnVLH90xAgh5prQZbVo
	YbEKTBzGRzdw=
X-Received: by 2002:a17:907:6095:b0:c34:c5e8:1dc5 with SMTP id
 a640c23a62f3a-c34c5e82123mr828929666b.20.1791962373480; Wed, 14 Oct 2026
 00:19:33 -0700 (PDT)
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
Date: Wed, 14 Oct 2026 09:19:21 +0200
X-Gm-Features: AclHuK8o97-tByDZxo3ZbCUEwmJUGSdqAopCL1P-qHwY8E-185Z3bC_zZwQQAnI
Message-ID: <CAKfTPtCh1ZSWudmniet1UoGDAS3cQJYkLTuH-QuubGc8-rxOCw@mail.gmail.com>
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

Not needed, teh statis key has been test prior calling it

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

This can happen after it has been added to the list

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

I followed what is done in RT and deadline

>
> In failure cases also, it can return true. No? for example,
> is_migration_disabled(), It is needed since you need to iterate the
> rq to see if there is a task to move.

Yes, we skip the current task and continue witht the next one

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
