Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176274DBD62
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556323; cv=pass; b=HZKQOWtUAeJs2BknWDSeLqLLndot21ZSiy7wEhU9vDOcgGdOjv/KFUrAVwALaYwoxQL2U69OZvNM0D+ON1zz6UXxo6ZO1nwpzJnsheGy17hKWD7h185kvnADCE6tt6ybt3cirK2bqsNbLJg0Y2m4Udg+WelQr/osXT1qDVXRaiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556323; c=relaxed/simple;
	bh=8WemYrC/oSkykk2cbuno6NjVlVtiVXE9sVqDSzzwasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1lQN8bbILDa92HUvX6wbHKK/N+HG+WgeLqP0vAkuM5JejyzaXNIIKuEWf4saKCyIRSMdSgkfL5mhqvLzM3KBt171PIbfBvUAsSKU7BfhULwDWVQXPNZIjC1gcz8CjVqHaH43IE/ukpuvpvxqD+pwP1YKbRq0wy4ncvQn86+vAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGO17TYJ; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGO17TYJ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e5d08214dso901768366b.1
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556312; cv=none;
        d=google.com; s=arc-20260327;
        b=VM27MwM0VcNeb/mkpaXi5bJh1pNSnXuk9wdqxgvZmwg+nE5CuhlUuLiHShUwdtQ2/C
         rQ01xTrSNqikHLvUCYK0jhcZOz5Q8m7A6AugfUn5jgxZuV9VlN4q3K0Y/Ol0O6/m+ABE
         NCoFg3TvN0Cw3ewG/Quboi5UCjAbVZHDpGVrSXj/vCTBRrXRgXXqcntAaMm5bpVUXI81
         0VYpVuO/1IwvXR//CSj7V7s4vGhtOsZGdRGVTZJ/EHQD4OB4v/jFlR+0jPfEGnaX7Ztp
         kPgL50cnFPSSRd4OexFR18LAfwtt7a9N1RJujaIsaPh0s+fo5odTzcCC4QaAjK4QDGZM
         Hh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        fh=53EsaK4T/MynIcWzyTuLzaak2JkrROKy05CGYgIVQsg=;
        b=Dm4+sk3kC6o+xnTZoAfp6ZSnsngcZM4lAzCI1iH/y5St/GCfAFVALiC00XJXU+IvgO
         IEIki96rQT45lKkP4asXtB+kRPH3hRSFprg6VuAppjzIyiNi+RPtEqjeMDP7lc6c1GLy
         1nbW4r1ws8Mzp62GK/XRXvY6FK4MHLtdhdMut+gW+eLtMCESC62DaZC3vmZhx2tsrZvv
         FI90lQTJMcgwg5pqvbYTnH9fgvMkTR/xPRPJiqjD/lRHwMEr309dHyZZSWcN9c1DC04U
         +et4mLJNg2HVpCckRFX2hxe/TkiWJHqsgaBucdFem4wEoxCtmua0Sf1u6nlanzwnQ+8z
         ODoQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791556312; x=1792161112; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        b=NGO17TYJWkMIhMRHSvxB5cCujoWUYhSaxvUxMzIrdoSI9XXIsbxIVgvB5fX3NvygQg
         myVYOCRRxcUjM7B+eZ3xlrEN4UP71C9DVQvMJQ20suQXq0mWBJsiv9VRQyuNeW1LUhPN
         RMcjKzylz3cJjN2xwnDw5lBKclWLFiHCJ/9aY2UHtB3b7Nl3XZRNeTGev0eh7EirnerG
         eo6fCaXlaintUXXAzZ6QXw4pRIWp8HJ0aUdS3S82qyxVLBAeIMSkAqFLeCPW8QL47XfK
         050re66Fo+SL3goZ2vaF6o1d8BCeYhmIBsnARdhUR0KgyrZu6wI4093tfL29sBTOAjc4
         c5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556312; x=1792161112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        b=PeSPD5oc1bd4ifzBFVy2P9kGhB/nWzc9FKCwkSGaFs5gROCKqha0RFpNDcjUSReNHR
         7soOion2SyWLp5il6UpzybiMIMfSwudJfvhtSjwpiXDsA51+ycMI1bSxPLTlnprJv+h/
         qg/BAEHFs9tAww6vWp7NbgAle8DdqwB8f9THjh16ojkY6FJLfr6jsDnCV8ZZwEfvJk2I
         zuALK36iirtkSDwmc9S2/AbmMrFnjag9wgl2Cp35vIWc43BogsvbRGTeThFFuFNI79q5
         j648AuyszjHiqkniLlPruCbwjxD1J9WiPcMbycn/fjBaD3FJKgreEGJfYLWL6rw1qPCu
         YBOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9ANc/eUscL15i0a1J9quQHwrXDLcfUiU2FO9sEa5kODWjAFk6jOsziTcEjfnr1OTMs0j3WatgdK0=@lists.linux.dev
X-Gm-Message-State: AFq9FYJnTRKplyV9awNl/PFG1KHQpXF6pkXPxkFxJfrtqbEoMZgN3YNB
	1ATkkL9biK8JTT9vEdbqU/HtMi+vUDJXXXrocBnvz0Iq0mUYxnWBJrAV/czsft/My6yucq4ThOf
	TDPyR1fQ2MtP5unTVeqIurjhn67g8jbx7XcJi22QWCQ==
X-Gm-Gg: AYBFou1lfLeAxNS9q55ShtaGkwCa/5s+f3QRycgvnp0c4oF4wdbvOWcbTvWrkS4Dd+Y
	cMuW2zBuP6StzuN4k+MeSSs12Np5D0KK7QtFB/VN9qinFt4K6HDCN3HBvba7CUjdUvqsDTCyqEj
	rxSQ1ogH4BSAkFWxxc+HIBn9+uwN71y5t409LdsFpOQoRtudCqWcSKqrRPZTW0HKQiid1MqOKeL
	kzhXWXR4vrnKAyf0fT8cB1XqY79FCm4J4YtZFkPAV0Cu+FRaOk2WM0GwjEMkzYowHR1m58ZaIX/
	XY0W32bZD9YgJviaFG+COzGAvxGNElQBxaGmCzSCw6ee50gNggG9xVQQnIeA+6fK5K3xVJAz4jj
	8l3glDuICLL+oLbEMMV6wWA==
X-Received: by 2002:a17:907:a08a:b0:c2d:d289:e9ed with SMTP id
 a640c23a62f3a-c31aa0293b1mr220927066b.44.1791556311764; Fri, 09 Oct 2026
 07:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
In-Reply-To: <asWyZtW7zPVo3k-A@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:31:40 +0200
X-Gm-Features: AclHuK-MW_1VEazm_dXyGcrzmICV3562LXn8DvrGfbug8xrX-mkbFJMdjIJUVpo
Message-ID: <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Fri, Oct 02, 2026 at 05:44:04PM +0200, Vincent Guittot wrote:
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
>
> A hackbench was launched on a Xeon server with 192 cores, using the default
> settings to see if there was any regression. According to the test results,
> there is no obvious difference, so I think it is good now. Later, I'll also
> test with a mix of different time slice workloads:
>
> =========================================
> Hackbench comparison
> BASE: baseline
> TEST: push
> =========================================
> MODE     G  FD |         BASE(s) |         TEST(s) |   DIFF% | RESULT
> ------- -- ----+-----------------+-----------------+---------+----------
> process 16  20 |     76.438/0.2% |     76.310/0.1% |   0.17% | IMPROVED
> process  1  20 |     52.532/2.3% |     51.217/1.1% |   2.50% | IMPROVED
> process  4  20 |     61.754/0.6% |     61.758/1.8% |  -0.01% | REGRESSED
> process  8  20 |     76.817/0.5% |     79.049/0.2% |  -2.91% | REGRESSED
> threads 16  20 |     66.290/1.5% |     67.120/3.5% |  -1.25% | REGRESSED
> threads  1  20 |     62.311/2.3% |     61.518/1.7% |   1.27% | IMPROVED
> threads  4  20 |     56.376/0.8% |     57.455/0.8% |  -1.91% | REGRESSED
> threads  8  20 |     63.871/3.8% |     68.611/0.3% |  -7.42% | REGRESSED
>
> Besides, as suggested by Qais, cache-aware scheduling could also be a user
> of the push mechanism. This is an evaluation patch that uses task push for
> cache-aware scheduling by allowing the cache-aware sensitive task to leverage
> the push path to be pushed to its preferred LLC.
>
> In my opinion, task pushing is triggered less frequently than task wakeup,
> because it has a high bar to be launched(preempted runnable task)
> This could reduce the risk of contention between the task pushing and the
> cache-aware load balancer, and achieve faster task aggregation on its
> preferred LLC.
>
> We have launched a simple migration test based on the following change, and
> will update later to see what the result is.
>
> ---
>  kernel/sched/fair.c  | 88 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  1 +
>  2 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7eea0414fd46..d5c6bbf04b47 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1391,7 +1391,8 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>  #include "pelt.h"
>
> -static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> +static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu,
> +                              int push_cpu);
>  static unsigned long task_h_load(struct task_struct *p);
>  static unsigned long capacity_of(int cpu);
>
> @@ -9325,7 +9326,8 @@ static inline bool asym_fits_cpu(unsigned long util,
>  /*
>   * Try and locate an idle core/thread in the LLC cache domain.
>   */
> -static int select_idle_sibling(struct task_struct *p, int prev, int target)
> +static int select_idle_sibling(struct task_struct *p, int prev, int target,
> +                              int push_cpu)
>  {
>         bool has_idle_core = false;
>         struct sched_domain *sd;
> @@ -9348,6 +9350,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          */
>         lockdep_assert_irqs_disabled();
>
> +       /*
> +        * push_cpu must be checked before the target: when
> +        * a task is pushed from the tick, it is rq->curr, so
> +        * idle_cpu_without() would consider the target as
> +        * idle and keep the task on its current (non-preferred) LLC.
> +        */
> +       if (push_cpu != -1 && push_cpu != target && !cpus_share_cache(push_cpu, target)) {
> +               target = push_cpu;
> +               if (choose_idle_cpu(push_cpu, p) &&
> +                   asym_fits_cpu(task_util, util_min, util_max, push_cpu))
> +                       goto select_smt_priority;
> +       }
> +
>         if (choose_idle_cpu(target, p) &&
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 goto select_smt_priority;
> @@ -10156,6 +10171,15 @@ static bool check_pushable_short_task(struct rq *rq, struct task_struct *p)
>         return false;
>  }
>
> +#ifdef CONFIG_SCHED_CACHE
> +static int check_pushable_cache_task(int this_cpu, struct task_struct *p);
> +#else
> +static inline int check_pushable_cache_task(int this_cpu, struct task_struct *p)
> +{
> +       return -1;
> +}
> +#endif
> +
>  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
>  {
>         if (!__check_pushable_fair_task(rq, p))
> @@ -10167,6 +10191,9 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
>         if (check_pushable_short_task(rq, p))
>                 return true;
>
> +       if (check_pushable_cache_task(rq->cpu, p) != -1)
> +               return true;
> +
>         return false;
>  }
>
> @@ -10231,7 +10258,7 @@ static bool fair_push_task(struct rq *rq)
>         if (!raw_spin_trylock(&next_task->pi_lock))
>                 return true;
>
> -       new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
> +       new_cpu = select_task_rq_fair(next_task, prev_cpu, WF_RQ_PUSH);
>
>         /* Task doesn't need to migrate */
>         if (new_cpu == prev_cpu)
> @@ -10335,7 +10362,7 @@ static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, stru
>         if (!raw_spin_trylock(&p->pi_lock))
>                 return false;
>
> -       new_cpu = select_task_rq_fair(p, cpu, 0);
> +       new_cpu = select_task_rq_fair(p, cpu, WF_RQ_PUSH);
>
>         raw_spin_unlock(&p->pi_lock);
>
> @@ -10382,7 +10409,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>  {
>         int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>         int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
> -       int new_cpu, cpu = smp_processor_id();
> +       int new_cpu, cpu = smp_processor_id(), push_cpu;
>         struct sched_domain *tmp, *sd = NULL;
>         /* SD_flags and WF_flags share the first nibble */
>         int sd_flag = select_flags & 0xF;
> @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>         if (select_flags & WF_TTWU)
>                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>
> +       /*
> +        * Only a push triggered by cache aware scheduling will push the
> +        * task towards its preferred LLC. Pushes for other reasons, like short
> +        * slice task, uses the default push strategy.
> +        */
> +       push_cpu = -1;
> +       if (select_flags & WF_RQ_PUSH)
> +               push_cpu = check_pushable_cache_task(prev_cpu, p);

Is there any reason that you do'nt want to migrate the task at wakeup too ?

> +
>         new_cpu = prev_cpu;
>
>         for_each_domain(cpu, tmp) {
> @@ -10441,7 +10477,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>                         break;
>         }
>
> -       /* Slow path */
> +       /* Slow path,  push task will not go inside due to flags = 0 */
>         if (unlikely(sd)) {
>                 new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>                 return select_idle_smt_cpu(p, new_cpu);
> @@ -10449,7 +10485,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>
>         /* Fast path */
>         if (want_sibling)
> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, push_cpu);
>
>         return new_cpu;
>  }
> @@ -11572,6 +11608,44 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
>         return true;
>  }
>
> +/*
> + * Return the preferred CPU that task p running on this_cpu should be
> + * pushed to for better LLC locality, or -1 if no such push is wanted.
> + */
> +static int check_pushable_cache_task(int this_cpu, struct task_struct *p)
> +{
> +       struct sched_cache_group *grp;
> +       int pref_cpu;
> +
> +       if (!sched_cache_enabled())
> +               return -1;
> +
> +       /* preemption already disabled */
> +       grp = rcu_dereference_all(p->sched_cache_grp);
> +       if (!grp)
> +               return -1;
> +
> +       pref_cpu = READ_ONCE(grp->cpu);
> +       /* If the task's pref_cpu is on the wrong(non-preferred) LLC, move it there */
> +       if (pref_cpu == -1 || cpus_share_cache(pref_cpu, this_cpu))
> +               return -1;
> +
> +       if (!cpumask_test_cpu(pref_cpu, p->cpus_ptr) ||
> +           !cpumask_test_cpu(pref_cpu, cpu_active_mask))
> +               return -1;
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +       if (static_branch_likely(&sched_numa_balancing) &&
> +           p->numa_preferred_nid != NUMA_NO_NODE &&
> +           p->numa_preferred_nid != cpu_to_node(pref_cpu))
> +               return -1;
> +#endif
> +       if (can_migrate_llc(this_cpu, pref_cpu, task_util(p), true) == mig_forbid)
> +               return -1;
> +
> +       return pref_cpu;
> +}
> +
>  #else
>  static inline bool get_llc_stats(int cpu, unsigned long *util,
>                                  unsigned long *cap)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 95a18c0d21c6..85527034572d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2559,6 +2559,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  #define WF_CURRENT_CPU         0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED         0x80 /* ->select_task_rq() was called */
>  #define WF_TTWU_RQ             0x100 /* Wakeup completed through ttwu_runnable() */
> +#define WF_RQ_PUSH             0x200 /* Push the task  */
>
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
>  static_assert(WF_FORK == SD_BALANCE_FORK);
> --
> 2.43.0
>
