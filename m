Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7274E0B8A
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552986; cv=pass; b=RYhMpmZGBENAGQ8AbYYnN8csbvLWyrpbr/XNCSw3TEluPvVVF6pX84GzqSUpjq7PLUfONXFDEcc7J9qq2fCqkX8bRI/dGM4PG/2vsx0WWtbZsDFG3W3GViQCjlGTO5VvD0NeT4y+ceg9OhkFr8acuD4JPeUcz9+xTnnVnLNdx+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552986; c=relaxed/simple;
	bh=4XPCH/MhgvL8FdhVT1IWLnUFXPM2Ro816H8yo3QNtog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbhDRj8wI4kpGLMaVeO9evwNINuVgND3YWVot9v2B+Nw2wplQjB3Z4b1V7rgEy1AMLF5xPlOqpOSBFKrU9BPjD/7MXsccF+9Zu0F8/+F1NyOtx9L2Z8KtgyqNFFpxnC4/5bc7SCDXr9kwh+p6BEN8LjqPbdpFCd1Ss7RxpIluQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fuWg6Nfx; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuWg6Nfx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so4341946a12.0
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 06:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791552981; cv=none;
        d=google.com; s=arc-20260327;
        b=kndJ6e/NB61Sv8M5pJbxP/kSoilmrlUpfBvcAV7XF8ckgzxzVCVbOxAcnQYqsWKkcJ
         QEhr48j27gQCqCZZxf2HjF5ex0LEs7DNu9pMOGBRl45CMS2qRckKuzBTRH4vhJFd7WFK
         SH9cnJUqU48aU9BCfkxfwL106kD5CA1FNNMxbV8iS9CmU9sM/BIZzDlKvTUjwzy1HFdW
         nphXLl1NXXXJEGiE18ZrlOtLzGpDHuReRiuPPyapNt4k+nLpF62J2U6PobreJ1newXVq
         B6i6BeQqn3hOmBJoQpTLq7Wtmz4IDSxPDplrSuvIg7eeSxyyoNXd/Q9VuWEXHpoq37I+
         rTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cSYTF5G/6IBv4qtaPQwsugnglHUYlwR0deKY7PXmuiE=;
        fh=sc05TGP1wvPXZWcsTZjqT5BBs1WJPMHIzrD3ztv+sOk=;
        b=iQYV/XyG6ONgPFAzddshy/zoRvVYOC5O2PD4fOxGaA61Ric0Dgvp9+qFnt56RQ2VJV
         3g8g20FqJblvs5HUESgEWG4HMWThiN6yOONuPw1YGKlZdU+tp1StIyDMyGNhGxsrhibG
         12O5bLp/v+PLpAc6CzTs+Qt77vWzDqiePwK5KIHvZECpxt3VH2ZYQCVwO4/up/51hvXV
         crAaYnyN6FH4GtwIOniKsTvu+jtQ4reqlCjWAkgncn6YN8xabpEc2GqeOnyGNvBlkGaa
         lorC127vBi86LFLG76InD36ElnP8/IqMYyxItd/hDiKMU14zon6LXKJP6lESWdQcpuhh
         kBzg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791552981; x=1792157781; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSYTF5G/6IBv4qtaPQwsugnglHUYlwR0deKY7PXmuiE=;
        b=fuWg6NfxvWrwpVETbA0j/po0RbdXofPoSQ67C4kZLTcZ4jnCld3sHaa6EmkC24AEvn
         1kVK8isjx/Y1gatknb8KdT5oQULLhCRYr55Pz1Zq1QPdRW1yiwU9S4Gk0V4Lnl0eNrs5
         Bif+Cv0xoDebmQwIaIgtNFbxT8Sw1ebge5zYPKcs3G7dUxYol+kf541aVGNEs0RlLzV0
         WrWOLubH+d4QepV37B0+UlbK9blFukfniY0gUR/+JQHVF8xgAZeAL7zdVOey1MFMzyZf
         zlFw87YAkkFynIbHWVpZV6wT/11+kIbx7kIMdiP3QvzweZFRxwvmwSZCqhCxI0C5c/ye
         JovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552981; x=1792157781;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cSYTF5G/6IBv4qtaPQwsugnglHUYlwR0deKY7PXmuiE=;
        b=hPYRUtHbrW/EK6nZJBLwBbtkUSNIrZkD/y/9p4nNPq1d8urBrO6uiZuByX82h64kPA
         iiU+3gzuIMrRtTzIBjYpS5xsH0JUdan3XXWod3gKd28tGN/IcbC9nGrvKjRN6vV3z3z5
         HKOk/f6sZs7wayn4LT2OPO9+AbEYbqWk2cbnbt0pabwpeZGBulBV4Dp+mFNZ6aIWcB/s
         rF/+/axyajG21LrNVCRiysupPqxcmIDJHJwLhapW+EHYGHJNG+5Im7KPji5/HSkxrdxP
         kgwHMIKQa7n51FTkCtDC/Qm2ykWcmDqIUa9qaYgVNoYg+5eTKpJQMt4RybZrfVwLgwbd
         OkqA==
X-Forwarded-Encrypted: i=1; AKwUvByHB+cyqRcmez05YbV7BH/rPUhALA66wH4H32ZAVQEU/FlGG13goeohgrh6ZwQGV1aCidxTWwP1JNo=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8NHyuOwhbqQkgQTJ+yTdtRTqmPy1xE+NfRnC8wAhDbumAmIwg
	cxaV8zfaGSyg07rrNF+iMb0dPevLPjpua/SapL4zGl3J9wWQFsN3cLMU6i0rG+2cVKsedBraF6y
	qSxasDt8LtTmZIWC4EjxUopAzvyvqRPPu8S3yd1yWNQ==
X-Gm-Gg: AYBFou2AeKJ0mSddM7/9iplCExFqt0m7bReDGcz/3neMOaXpKv4wm7ar7PVIl9Z92XY
	0npVMTOhA0ZDgpfJpbfIRil/PH2MhZp0jC2qj2pWXZ6mdRPafnjgXkXyZKcL6+82OLkR+zPvw37
	/JP/tf+TBOXW03HdT4V7629v81JZieB3ac2Oak7SskkeCefn6/goBURBUveRpBJSxTKOLoyc1Dc
	fwK4/qkuyY29tbEVM6BovwiNqQWk4P5FHlB8NkQPWeTSXjZ70HHlxtjDtCmYyz7xmr39Pu5bZIp
	ou9n1K7wk1mhrfyF1NiCxAoOIQdrKo+9EvytKOhhgLhN1Ox5JT03xlz0ryeAikZr0/dzp4L4YxC
	P+wSyqm02rd4=
X-Received: by 2002:a17:907:9709:b0:c2e:1b4d:e9f4 with SMTP id
 a640c23a62f3a-c31a9f68e76mr211664166b.31.1791552980876; Fri, 09 Oct 2026
 06:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-7-vincent.guittot@linaro.org> <95c9b871ab66588afdf09d6ec9bac577c139b8d8.camel@linux.intel.com>
In-Reply-To: <95c9b871ab66588afdf09d6ec9bac577c139b8d8.camel@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 15:36:09 +0200
X-Gm-Features: AclHuK8XPSj60dZEKCZiZmDQwF3SMh14jeoyyjcnhNQN71Gr4MJge8CeenQBmyI
Message-ID: <CAKfTPtCs5FMDWvnb6+wGhWx23YHe2azRWvmqKp0WsYpzU77v5g@mail.gmail.com>
Subject: Re: [PATCH 06/18 v2] sched/fair: Prepare select_task_rq_fair() to be
 called for new cases
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 00:25, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> > Update select_task_rq_fair() to be called out of the 3 current cases which
> > are :
> > - wake up
> > - exec
> > - fork
> >
> > We wants to select a rq in some new cases like pushing a runnable task on a
> > better CPU than the local one. In such case, it's not a wakeup , nor an
> > exec nor a fork. We make sure to not distrub these cases but still
> > go through EAS and fast-path.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c |  2 +-
> >  kernel/sched/fair.c | 57 ++++++++++++++++++++++++++-------------------
> >  2 files changed, 34 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f38cf5a37a8a..837dc74c9a8d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3618,7 +3618,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
> >  }
> >
> >  /*
> > - * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
> > + * The caller (fork, wakeup, push) owns p->pi_lock, ->cpus_ptr is stable.
> >   */
> >  static inline
> >  int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 19a0e67827f7..f12678850ce2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9800,46 +9800,55 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  }
> >
> >  /*
> > - * select_task_rq_fair: Select target runqueue for the waking task in domains
> > - * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> > - * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
> > + * select_task_rq_fair: Select a target runqueue for the task.
> > + * There are 2 ways to select the target runqueue:
> > + * - The fast path which only looks for an idle CPU in the LLC or the smallest
> > + *   asymmetric domain (i.e. the lowest domain with all compute capacities).
> > + * - The slow path which looks for the idlest CPU in the highest domain with
> > + *   the relevant SD flag set.
> >   *
> > - * Balances load by selecting the idlest CPU in the idlest group, or under
> > - * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
> > + * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU and no
> > + * flag (Push) uses the fast path.
> >   *
> > - * Returns the target CPU number.
> >   */
> >  static int
> > -select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > +select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> >  {
> > -     int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> > +     int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> > +     int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
> > +     int new_cpu, cpu = smp_processor_id();
> >       struct sched_domain *tmp, *sd = NULL;
> > -     int cpu = smp_processor_id();
> > -     int new_cpu = prev_cpu;
> > -     int want_affine = 0;
> >       /* SD_flags and WF_flags share the first nibble */
> > -     int sd_flag = wake_flags & 0xF;
> > +     int sd_flag = select_flags & 0xF;
> > +     int want_affine = 0;
> >
> >       /*
> > -      * required for stable ->cpus_allowed
> > +      * Required for stable ->cpus_allowed
> >        */
> >       lockdep_assert_held(&p->pi_lock);
> > -     if (wake_flags & WF_TTWU) {
> > +
> > +     if (select_flags & WF_TTWU) {
> >               record_wakee(p);
> >
> > -             if ((wake_flags & WF_CURRENT_CPU) &&
> > +             if ((select_flags & WF_CURRENT_CPU) &&
> >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> >                       return cpu;
> > +     }
> >
> > -             if (!is_rd_overutilized(this_rq()->rd)) {
> > -                     new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> > -                     if (new_cpu >= 0)
> > -                             return new_cpu;
> > -                     new_cpu = prev_cpu;
> > -             }
> > +     /*
> > +      * We don't want EAS to be called for exec or fork but it should be
> > +      * called for any other case such as wake up or push callback.
> > +      */
> > +     if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
> > +             new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> > +             if (new_cpu >= 0)
> > +                     return new_cpu;
> > +     }
> >
> > +     if (select_flags & WF_TTWU)
> >               want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > -     }
> > +
> > +     new_cpu = prev_cpu;
> >
> >       for_each_domain(cpu, tmp) {
> >               /*
> > @@ -9871,8 +9880,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >               return sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
> >
> >       /* Fast path */
> > -     if (wake_flags & WF_TTWU)
> > -             return select_idle_sibling(p, prev_cpu, new_cpu);
> > +     if (want_sibling)
> > +             new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>
> Hi Vincent,
>
> With this change, a push also goes through select_idle_sibling(), and
> select_idle_sibling() sets p->recent_used_cpu = prev on every call.
>
> For a wakeup, prev is the CPU where the task ran last, and the old
> value of the hint becomes a second candidate for the next wakeup. For
> a push, prev is the CPU where the task is queued now. If the push
> doesn't move the task, the hint becomes the current CPU. When the task
> later sleeps and wakes up on this CPU, recent_used_cpu is equal to
> prev, so the wakeup has no second candidate. Each push attempt that
> fails does this again.

I agree that recent_used_cpu will be updated during push selection but
I'm a bit balanced about making it a special case.
When a task wakeup several times on the same prev cpu we have the same
effect for recent_used_cpu.

CPU selection during a push should not differ from CPU selection
during a wakeup. if we end to the same cpu then it seems reasonable
that recent_used_cpu equals prev


>
> Perhaps something like the following fix below on top of the series. It
> passes the select flags to select_idle_sibling() and
> updates the hint only for WF_TTWU. When fair_push_task() moves the
> task, it saves the source CPU as the hint, which is what the hint
> holds after a wakeup migration.
>
> Tim
>
> ---
>  kernel/sched/fair.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fd22731949c5..3eb8a0170902 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1381,7 +1381,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>  #include "pelt.h"
>
> -static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> +static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int select_flags);
>  static unsigned long task_h_load(struct task_struct *p);
>  static unsigned long capacity_of(int cpu);
>
> @@ -9072,7 +9072,7 @@ static inline bool asym_fits_cpu(unsigned long util,
>  /*
>   * Try and locate an idle core/thread in the LLC cache domain.
>   */
> -static int select_idle_sibling(struct task_struct *p, int prev, int target)
> +static int select_idle_sibling(struct task_struct *p, int prev, int target, int select_flags)
>  {
>         bool has_idle_core = false;
>         struct sched_domain *sd;
> @@ -9131,7 +9131,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>
>         /* Check a recently used CPU as a potential idle candidate: */
>         recent_used_cpu = p->recent_used_cpu;
> -       p->recent_used_cpu = prev;
> +       /* A push only updates the hint when it moves the task */
> +       if (select_flags & WF_TTWU)
> +               p->recent_used_cpu = prev;
>         if (recent_used_cpu != prev &&
>             recent_used_cpu != target &&
>             cpus_share_cache(recent_used_cpu, target) &&
> @@ -10015,6 +10017,7 @@ static bool fair_push_task(struct rq *rq)
>
>         deactivate_task(rq, next_task, 0);
>         set_task_cpu(next_task, new_cpu);
> +       next_task->recent_used_cpu = prev_cpu;
>         raw_spin_rq_unlock(rq);
>
>         raw_spin_rq_lock(new_rq);
> @@ -10225,7 +10228,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>
>         /* Fast path */
>         if (want_sibling)
> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, select_flags);
>
>         return new_cpu;
>  }
