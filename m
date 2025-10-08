Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857528136B
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929435; cv=none; b=EM0r5/7BEj1s4LC94NcuuioI4Am65MihHw8NDyDizMe+INxigg6S2esR/rQr8OXnXPItn+jPZ2GiKTBGikhjn/SSAfMiamZF3opbfx/ti7/sPwdg0vvSjVKTQl54nH88rT4x7Emv1tkSsKU/9TdNo/fJ9Ys98NmT6KSMW7Ybo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929435; c=relaxed/simple;
	bh=lM23VZ05oNogRNCkhFGf7+cVoWLIcORAxzbXXUYOBoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P26ks/zO+iKyqNHySqIw4hARsNjRQ/ojaXN6lRIn6EP+QOoVl43NXE6bqiN88tjtB5GWGg08AlBfrTdj92AHlNJgYiUcKoYZRHpeEH8K6w356LHc3prgT7f8+PbU02daEEtZ0oIzcViN9qyWShbt9ZG4XP/qQWFI4J8vTHElHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5QodwhI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5QodwhI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3d80891c6cso147222266b.1
        for <sched-ext@lists.linux.dev>; Wed, 08 Oct 2025 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759929430; x=1760534230; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AgETe2qmZXrA8PC5KX5oL17+nNu3YuZevp2OkZQydk8=;
        b=Z5QodwhIpAMz/005gzmbADoymfvM7DrBClaZZW0nkOYGVzx5saIGzoVMN2zr57eS8r
         vSPdaIdSOk4FsWCVmwlSU9MhWNzrINjv5fye7dLEMNsGMFO1laWgennHBhCmVcZ0NHsv
         Joy6x+yeav7CVjD2884GZ/qHqLf9LzBF1s0kTLka1cSznQ9d5ccUw4iDNDDbKlDUHENK
         OY2UdvxMO6zXuNzzkzWb/gBWg3I61PPoebuKk1MzHSxhz5pcWVgQzDQxl3N99nnmEaR2
         /qGyrOEeQLeSMyOhIGQJ5S4Vr1PDSo+lxbSjJAipj7c9ms0S8Ojq08gR/2vJiy95pFaj
         k8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929430; x=1760534230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgETe2qmZXrA8PC5KX5oL17+nNu3YuZevp2OkZQydk8=;
        b=OsJ2jrgpyaATNQvj5ewETScaJD9ATtor2kT4fTNKwfnRGVLmrWR5ggzBB2UzdghZso
         aPfYR2hANft+Hnpmm7qw2EP1Kuh1BoEGfJtJdwCvQzhaALXmvbmLIHTTAiXh0l8CvUwe
         dp26NF9EID+JL4ywH2cugcPQ6dSh8V4+Aa99DoiJVl/OamYnnKDvnSZwXp6tdbbqYcbr
         2ZBehfQ3atBGFYJJPMMKsKQR+RHAjLqU1ShL7ip326a8VKZMlfjCUUC0Jo5VLOGu/7ga
         4E70NSloPQFEzmCSx+GtDUNMf77HUmkuX0S0+UHyac2NcGRugfk6OtORL1/2jvL42oRd
         /uTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrUxtyAZZ9yczXzFCzRhsW9rgssDW/sXb0YTd9KAgnIVSJ3gZIIlyR9zJeiEhJE2LE/Io3ozHBo8E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+3aZ6fp4pTQrojqt1DAUeteHF+p1+V8OWHmrRYUfOTWzrKxos
	yBUmLSqIP6vZ0vcDAQ4mvglkn870LuxYpmnyEzzzy+OjdCcyJDrKvVcKcEeINMmEU6Z256Bc9I6
	+4kd+5XTVZM4xxdmO8zBjP8umJE3aMEhsCDWUs3tpAQ==
X-Gm-Gg: ASbGnctlvzauFJQG2oov/AP6yXwj4c/uhh+sXSfQWQuP9712ILJne8DvfHQGYRgd7p6
	42RxXDKL+Fik5NgEAXswhXD8kJhQzFzeOFsASkIm/F6PVjdLaq2w9bgx4ZuH1HpgtEInD2jT9W9
	p7pkGNvD0abxJ8qHxoqpv1K3YcDi0ZR3Pth3YqobLHNnKblWFJzsIIGuiwLw3wr0JyPH7az7WHw
	Ho9/k7mjlEv5Cr+wJ/IW7scUSsXQ187Clht8YmDUhZZ2FOgeLCa6ITt9b06sf+V
X-Google-Smtp-Source: AGHT+IG4gFjWgHwFbBW9YKp9FwScon+JNV8Sg8ttg8UGGKjwDYpPijj5IV7R2qlH+lvXDpvC8deUJaTZshyvcY355o8=
X-Received: by 2002:a17:907:7b8b:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b50bd2454cdmr409486366b.14.1759929430338; Wed, 08 Oct 2025
 06:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
In-Reply-To: <20251006105453.648473106@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 8 Oct 2025 15:16:58 +0200
X-Gm-Features: AS18NWDQNQasq-_Me0Beu5RO-YdUrngng6Zj4S0Rw4gVkOVm3Xuax4jHVzeeIdw
Message-ID: <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:57, Peter Zijlstra <peterz@infradead.org> wrote:
>
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Some pick functions like the internal pick_next_task_fair() already take
> rf but some others dont. We need this for scx's server pick function.
> Prepare for this by having pick functions accept it.
>
> [peterz: - added RETRY_TASK handling
>          - removed pick_next_task_fair indirection]
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> SubmissionLink: https://lkml.kernel.org/r/20250809184800.129831-6-joelagnelf@nvidia.com
> ---
>  include/linux/sched.h    |    7 ++-----
>  kernel/sched/core.c      |   35 ++++++++++++++++++++++++++---------
>  kernel/sched/deadline.c  |    8 ++++----
>  kernel/sched/ext.c       |    2 +-
>  kernel/sched/fair.c      |   16 ++++++----------
>  kernel/sched/idle.c      |    2 +-
>  kernel/sched/rt.c        |    2 +-
>  kernel/sched/sched.h     |   10 ++++++----
>  kernel/sched/stop_task.c |    2 +-
>  9 files changed, 48 insertions(+), 36 deletions(-)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -637,8 +637,8 @@ struct sched_rt_entity {
>  #endif
>  } __randomize_layout;
>
> -typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
> -typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
> +struct rq_flags;
> +typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, struct rq_flags *rf);
>
>  struct sched_dl_entity {
>         struct rb_node                  rb_node;
> @@ -730,9 +730,6 @@ struct sched_dl_entity {
>          * dl_server_update().
>          *
>          * @rq the runqueue this server is for
> -        *
> -        * @server_has_tasks() returns true if @server_pick return a
> -        * runnable task.
>          */
>         struct rq                       *rq;
>         dl_server_pick_f                server_pick_task;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5901,7 +5901,7 @@ __pick_next_task(struct rq *rq, struct t
>
>                 /* Assume the next prioritized class is idle_sched_class */
>                 if (!p) {
> -                       p = pick_task_idle(rq);
> +                       p = pick_task_idle(rq, rf);
>                         put_prev_set_next_task(rq, prev, p);
>                 }
>
> @@ -5913,11 +5913,15 @@ __pick_next_task(struct rq *rq, struct t
>
>         for_each_active_class(class) {
>                 if (class->pick_next_task) {
> -                       p = class->pick_next_task(rq, prev);
> +                       p = class->pick_next_task(rq, prev, rf);
> +                       if (unlikely(p == RETRY_TASK))
> +                               goto restart;
>                         if (p)
>                                 return p;
>                 } else {
> -                       p = class->pick_task(rq);
> +                       p = class->pick_task(rq, rf);
> +                       if (unlikely(p == RETRY_TASK))
> +                               goto restart;
>                         if (p) {
>                                 put_prev_set_next_task(rq, prev, p);
>                                 return p;
> @@ -5947,7 +5951,11 @@ static inline bool cookie_match(struct t
>         return a->core_cookie == b->core_cookie;
>  }
>
> -static inline struct task_struct *pick_task(struct rq *rq)
> +/*
> + * Careful; this can return RETRY_TASK, it does not include the retry-loop
> + * itself due to the whole SMT pick retry thing below.
> + */
> +static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
>  {
>         const struct sched_class *class;
>         struct task_struct *p;
> @@ -5955,7 +5963,7 @@ static inline struct task_struct *pick_t
>         rq->dl_server = NULL;
>
>         for_each_active_class(class) {
> -               p = class->pick_task(rq);
> +               p = class->pick_task(rq, rf);
>                 if (p)
>                         return p;
>         }
> @@ -5970,7 +5978,7 @@ static void queue_core_balance(struct rq
>  static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> -       struct task_struct *next, *p, *max = NULL;
> +       struct task_struct *next, *p, *max;
>         const struct cpumask *smt_mask;
>         bool fi_before = false;
>         bool core_clock_updated = (rq == rq->core);
> @@ -6055,7 +6063,10 @@ pick_next_task(struct rq *rq, struct tas
>          * and there are no cookied tasks running on siblings.
>          */
>         if (!need_sync) {
> -               next = pick_task(rq);
> +restart_single:
> +               next = pick_task(rq, rf);
> +               if (unlikely(next == RETRY_TASK))
> +                       goto restart_single;
>                 if (!next->core_cookie) {
>                         rq->core_pick = NULL;
>                         rq->core_dl_server = NULL;
> @@ -6075,6 +6086,8 @@ pick_next_task(struct rq *rq, struct tas
>          *
>          * Tie-break prio towards the current CPU
>          */
> +restart_multi:
> +       max = NULL;
>         for_each_cpu_wrap(i, smt_mask, cpu) {
>                 rq_i = cpu_rq(i);
>
> @@ -6086,7 +6099,11 @@ pick_next_task(struct rq *rq, struct tas
>                 if (i != cpu && (rq_i != rq->core || !core_clock_updated))
>                         update_rq_clock(rq_i);
>
> -               rq_i->core_pick = p = pick_task(rq_i);
> +               p = pick_task(rq_i, rf);
> +               if (unlikely(p == RETRY_TASK))
> +                       goto restart_multi;
> +
> +               rq_i->core_pick = p;
>                 rq_i->core_dl_server = rq_i->dl_server;
>
>                 if (!max || prio_less(max, p, fi_before))
> @@ -6108,7 +6125,7 @@ pick_next_task(struct rq *rq, struct tas
>                         if (cookie)
>                                 p = sched_core_find(rq_i, cookie);
>                         if (!p)
> -                               p = idle_sched_class.pick_task(rq_i);
> +                               p = idle_sched_class.pick_task(rq_i, rf);
>                 }
>
>                 rq_i->core_pick = p;
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2352,7 +2352,7 @@ static struct sched_dl_entity *pick_next
>   * __pick_next_task_dl - Helper to pick the next -deadline task to run.
>   * @rq: The runqueue to pick the next task from.
>   */
> -static struct task_struct *__pick_task_dl(struct rq *rq)
> +static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
>  {
>         struct sched_dl_entity *dl_se;
>         struct dl_rq *dl_rq = &rq->dl;
> @@ -2366,7 +2366,7 @@ static struct task_struct *__pick_task_d
>         WARN_ON_ONCE(!dl_se);
>
>         if (dl_server(dl_se)) {
> -               p = dl_se->server_pick_task(dl_se);
> +               p = dl_se->server_pick_task(dl_se, rf);
>                 if (!p) {
>                         dl_server_stop(dl_se);
>                         goto again;
> @@ -2379,9 +2379,9 @@ static struct task_struct *__pick_task_d
>         return p;
>  }
>
> -static struct task_struct *pick_task_dl(struct rq *rq)
> +static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
>  {
> -       return __pick_task_dl(rq);
> +       return __pick_task_dl(rq, rf);
>  }
>
>  static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2332,7 +2332,7 @@ static struct task_struct *first_local_t
>                                         struct task_struct, scx.dsq_list.node);
>  }
>
> -static struct task_struct *pick_task_scx(struct rq *rq)
> +static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
>  {
>         struct task_struct *prev = rq->curr;
>         struct task_struct *p;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8822,7 +8822,7 @@ static void check_preempt_wakeup_fair(st
>         resched_curr_lazy(rq);
>  }
>
> -static struct task_struct *pick_task_fair(struct rq *rq)
> +static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
>  {
>         struct sched_entity *se;
>         struct cfs_rq *cfs_rq;
> @@ -8866,7 +8866,7 @@ pick_next_task_fair(struct rq *rq, struc
>         int new_tasks;
>
>  again:
> -       p = pick_task_fair(rq);
> +       p = pick_task_fair(rq, rf);
>         if (!p)
>                 goto idle;
>         se = &p->se;
> @@ -8945,14 +8945,10 @@ pick_next_task_fair(struct rq *rq, struc
>         return NULL;
>  }
>
> -static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
> +static struct task_struct *
> +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
>  {
> -       return pick_next_task_fair(rq, prev, NULL);

The special case of a NULL rf pointer is used to skip
sched_balance_newidle() at the end of pick_next_task_fair() in the
pick_next_task() slo path when prev_balance has already it. This means
that it will be called twice if prev is not a fair task.

While reviewing this series, I also noticed an older issue that we
have with check pelt lost idle time [1]
[1] https://lore.kernel.org/all/20251008131214.3759798-1-vincent.guittot@linaro.org/

We can't use rf in pick_next_task_fair() to skip
sched_balance_newidle() but we need a dedicated param


> -}
> -
> -static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
> -{
> -       return pick_task_fair(dl_se->rq);
> +       return pick_task_fair(dl_se->rq, rf);
>  }
>
>  void fair_server_init(struct rq *rq)
> @@ -13632,7 +13628,7 @@ DEFINE_SCHED_CLASS(fair) = {
>         .wakeup_preempt         = check_preempt_wakeup_fair,
>
>         .pick_task              = pick_task_fair,
> -       .pick_next_task         = __pick_next_task_fair,
> +       .pick_next_task         = pick_next_task_fair,
>         .put_prev_task          = put_prev_task_fair,
>         .set_next_task          = set_next_task_fair,
>
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -466,7 +466,7 @@ static void set_next_task_idle(struct rq
>         next->se.exec_start = rq_clock_task(rq);
>  }
>
> -struct task_struct *pick_task_idle(struct rq *rq)
> +struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
>  {
>         scx_update_idle(rq, true, false);
>         return rq->idle;
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1695,7 +1695,7 @@ static struct task_struct *_pick_next_ta
>         return rt_task_of(rt_se);
>  }
>
> -static struct task_struct *pick_task_rt(struct rq *rq)
> +static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
>  {
>         struct task_struct *p;
>
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2467,7 +2467,7 @@ struct sched_class {
>         /*
>          * schedule/pick_next_task: rq->lock
>          */
> -       struct task_struct *(*pick_task)(struct rq *rq);
> +       struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
>         /*
>          * Optional! When implemented pick_next_task() should be equivalent to:
>          *
> @@ -2477,7 +2477,8 @@ struct sched_class {
>          *       set_next_task_first(next);
>          *   }
>          */
> -       struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
> +       struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
> +                                             struct rq_flags *rf);
>
>         /*
>          * sched_change:
> @@ -2690,8 +2691,9 @@ static inline bool sched_fair_runnable(s
>         return rq->cfs.nr_queued > 0;
>  }
>
> -extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> -extern struct task_struct *pick_task_idle(struct rq *rq);
> +extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
> +                                              struct rq_flags *rf);
> +extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>
>  #define SCA_CHECK              0x01
>  #define SCA_MIGRATE_DISABLE    0x02
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -32,7 +32,7 @@ static void set_next_task_stop(struct rq
>         stop->se.exec_start = rq_clock_task(rq);
>  }
>
> -static struct task_struct *pick_task_stop(struct rq *rq)
> +static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
>  {
>         if (!sched_stop_runnable(rq))
>                 return NULL;
>
>
