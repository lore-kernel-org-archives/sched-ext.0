Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF1352009
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553146; cv=pass; b=bu2lrGReNY9j3lPfDjdMYmz7hXC3u98SsHoFnstwCO6KBK8m1qlpDgZvuXKesxPedKneYab8HQQuCIU5/xAgilsS9JtM3YqpYawzASc8XAfu5t7kDwD5ujgvnSmQY13ikJ7KVX05v/Fw7XIZ6BHHCPYSB4BdxobEG7xzaV6CS8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553146; c=relaxed/simple;
	bh=eszsKsyKpb9lT+hzleu80ByvkFfGr5QN8UFWzwVlJw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcfNfFSl6RwD8rKy1HhnpuZSpFtpJDGEg0tt41AexC7QjeN7HC9wArqNWYETPhxi8k9sJk7Gcjscifqe0BnkUWyqhq4G00RnCAWPGKvTI4lKHWriZmztBuCI7QhhDuHTZJPvXqS9Px/KETuf3x3s5WYjyEpeduJMckQ+ZdXFOag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srGVQ/W1; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srGVQ/W1"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c247f6687dcso658360666b.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 06:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791553143; cv=none;
        d=google.com; s=arc-20260327;
        b=IZJwJrOxE8M/fu8fRV5GpCZsrUZfVUr0k6hwK6RJ3a1OP73Ao33A6J67ZpVCNz8A0h
         Qq2EyGwICJkixgnXUIOHTxIuh6U0hgB8zT4JpzUN7CjzM+Hcl4SmzlQXIRbXEUuv/RNY
         sdQqgqu0pP1JEMvM92/bVSL+ylB3Ldo+mK411UQ1YXqJk9j4rcNoDuHEVQgXS0EtYtsQ
         lUtdPZb1w+5fi6cnYWNAw4PNRU3rmTDTZwh8NnmoRpFFAfJUNM5CWRzNOlAnfvfj7nDg
         BZj42SAUx06g8bTCVXf72TGjBUrZSDNlbDtXKpkMfY2dhv8MP6ksjC+saA3h49onqdwo
         eM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uzADCC8NPSRlhSrBRERpfxRJX72nbK8pgUsrCulq8pU=;
        fh=1UJfmxrloLYhFLcWMrUyRK8dM1ALehp5n3GEMwPhSBM=;
        b=O+QeAGF8MkZg5br03k2gjHuIDyosxKVqHZfBy3GgP6FAunFZoCuMJMYwYUfUA49SLB
         TULlCtSTyhiSiudz+ypi7W9omKKWL5RK7xURWniTh39XSIbGIF/r+R1ex5/xKAC/ZvmN
         EzB34dIH6GaglsTmRLFe7tpv6yhJrCWs8xpiWFztVbOHx8NSKfcCDRJnakF892CnQA8T
         AYjmBGa90Mu6gSrm0c3T5fZFBde8trrSuG0wncCslBNhK/PnT9EWN5vkvvFUmg7viYA9
         tzJm/Bj6qrVvbx6GomXGF/cPbTT3loeSOFKGdPbWmoh5Sl8FTwi3pxj4lqU9Drlk7ZNY
         v5Gw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791553143; x=1792157943; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzADCC8NPSRlhSrBRERpfxRJX72nbK8pgUsrCulq8pU=;
        b=srGVQ/W1jU2XIhQAO7Dezp+99T8uAo4nHC8NugzQTlGfzW0+jup9p1wQn6HhvKWezD
         D6D8/xzv3hoYkcpmq1nRdBbpn4nGInXBYHluxpY9PDnO/27Wxcv6w2Rdlw2ZahdnDIkR
         UZc6/Vx1hUrpbx0wXBKFqZub33Q9k8hiqqw+Wjo9HCw3zP2VOysTJkgYNvnZr1svBE0A
         uOJMyQ8hzIHOHmsyUCl2GBVfyvZMD7MR+Us3N1XRjSHHv+nNE3mOvsgDHjigOG0rzbvT
         u3SvSQLXYynTaA3BsAf5mqLLthqD7bCDzmcFKN1s/xvX/7SS8YACr939YeoO6zFgjKoM
         ubYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553143; x=1792157943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uzADCC8NPSRlhSrBRERpfxRJX72nbK8pgUsrCulq8pU=;
        b=QlShJmOwGSlfzFOA/9x0v1P1uusNEBgVRDm0hrDeKubkqpTjbgEeNTwWUL43985/XO
         Ued86iyS2GGljB3/GIZbf/EsPEVS2BnfNx3uMDEAlzpM66jXKzimrP2S/IOY1UBAEsnw
         /syT20dbKevmP8Lr6c6/1TER0HFgXXOJ8S2hyVCtAuJlcW/YMiUzNFlm5+sRfGURkB2U
         JiR0SKy1zD9VPZywpNXUJSGhP530hsam48sz8JUblKOJlF0LdWQO/a/Mk18l13MEJRaY
         QKZiorvJXTjyC7VcMJ5qzz9M4Tg6R9QkIUAPvXIaEF9gHH87UAsHSBjKeTumiNbKaF4X
         J0Vw==
X-Forwarded-Encrypted: i=1; AKwUvBynb4HjnTBo2KrGB+stpLxFgTMVWyLorOwGV4WBuejllpcxr7MPKYAQYvFKi8nmIImGm8EZdIJcquk=@lists.linux.dev
X-Gm-Message-State: AFq9FYLMj9hC0CqfyYSNWJJO2TI5RM91h8Y7S85VnL9x3DJuPwJ43dof
	oXQrQF+svWLAOUvv7PwuYBsFDFrTmXjoOWif0/7CskLkC2xpZjS3+AQEgb6tY+KXBFwvRaHWpDj
	WW49hmTPuRVZZyu0MBy7MtZIkjSU58266RDu4Xa8qoQ==
X-Gm-Gg: AYBFou0GyX3btZg9ZejgbpGZIQ2RRkgiv8QsrgftFp6I6af73L8zsJD4tO5rMZb0q0D
	rlbeRK0oqYCc3j0PQA6VnlKVo2LTU/5NS5skHTHyHrTSxnM5YnSMAryODqNsyerI1LOh2jIrk3T
	dwbWZDrLqFX4izY9DM5ydaV5xwtq5wqlpIJW83Hy0AgVoIzHAHAy3fQIvM3pevlDp3Ld2Sa7Svr
	Nl4Yk9mg7z0jmjRz7MOYLJVo8E7VvEoP1DJX+jqDlxa1vRcLlmX6aK8+9Ra/cflp9LwjpaJqBXq
	7WAgssT7W96GLMKcLkzUsCMLZ006xl4AP/ip5uAfP3obicYLPrjA7boKvslzCo56GJ3lH8fJZOX
	rQlxObwgAJDY=
X-Received: by 2002:a17:907:9485:b0:c2d:c98f:482d with SMTP id
 a640c23a62f3a-c31aa05e1d6mr220762466b.31.1791553142780; Fri, 09 Oct 2026
 06:39:02 -0700 (PDT)
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
Date: Fri, 9 Oct 2026 15:38:51 +0200
X-Gm-Features: AclHuK9ZEGHudOxQMUBCGqwsW1_88xYs0fNp7hJNPkNbdurNtelmMUpyv9uGoTw
Message-ID: <CAKfTPtBv27s+BroNcGV+VDavZD-piYUbFpcQ5WoWsYvo=d+PRw@mail.gmail.com>
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

Thanks for testing.

Yes, the short task case is the only one using it right now but the
goal is to extend its usage, and the cache-aware scheduler is one that
could also take advantage


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
