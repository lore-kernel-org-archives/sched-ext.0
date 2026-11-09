Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239738;
	b=qi2ScU0QLwgnUtRMvfn66Q4Bxyad1cXxgCDVuyHsNKklF6Xz/04AYuFej3gYl/nhkSwx
	 DN5sdk8ID1doylfajwtP5G8+9VoUYXvrv/6pxM5rxtotXZIeZP3Q7gP/4PlRN0JyrSaXe
	 C5vWIcWPMqhY1RZ3EO/S3WWtB9Dz8FHZSzHvgz0gc5RxDYrtmrXzhzha2Rnqv8EZYjFDV
	 L3Ot6AAd+vqiDYFoJ7HYH6UklvrpnLwHZxxFlJJ26xMAN/UQccNX/KsUPWvDOYLHN5yUx
	 7Qb4MW1cU3GLIkaoCRe5LL2TmtPg6vL/l/sSON90Fj75/sPgh1Y1Z9oeELHjfIp24aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
	b=WB/VL+jRNDZZOWGiwT0UYYkdQNCqN15KeBVqw8HENh+7a6Ud6ai8McSDifzsF1Fhlap2
	 KKXMw22LkhyOJ5xLD+r8bHUFNFlfVjrsuG81j3t/WfyI0blYEBkYK9YVzQLWCWQ4MHclQ
	 eFSxAkA8xBinCcWD02UU7q3325jNedOMwyFVDGIm5gQqoPXWWeE4gfvHkbwU798u2sXgP
	 pZCLOD7mS5jiHWl59T+EGPVGSQT8vrZBsvYH3G65HUpVdKg48qEs3WNExX+YRECLT+SZi
	 K/gDsvR0WsP8R85NrYzaMDQlKOF1dI4gwgOV2ni95lvDvg26V5XrgeN03NelcjRIv5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uGxOGdGG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F8606A326
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uGxOGdGG
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1262020a12.3
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794239736; cv=none;
        d=google.com; s=arc-20260327;
        b=XyN0fdJFpRV/a8+1NUyK9lAmf7b19BLJ9SXXluwYQHEnpFxZk85YKgwIq2847GYSZU
         way2lxNKD2k9KlCOSNr9/hNYNysuQNZb656gflskj8AuxGngYf4b2UhSLmmNu7yRI24h
         9ZBqHkOhBCPG54aLqVqEA6UIsfxXJQJorGtFryEaahyv+p0k9Ia9Bg/vUPd1WcYsB0T0
         sczupTYY6UbB0Nr0WCiTzZ9XM8+MPTXlzurDlu0ynXMkZXJXh4V7B8Y7y2u1pFfMqZMA
         RwxrvhGcZ/Px0/30rY9JAHxLNjwhUFp0aCBSocweQCvsnX0N39jlW+W7lTOTCHqgvbJq
         SNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        fh=y4ayM3CimTBRkTZyV9MpJN8deXcOd9BFvgkuDfIEMBY=;
        b=NM4601Zg14DEeGKY0RzlAcfWh6cFF75bNaTZKjbWhMoPEnWlZLUd0p7ThRf+hLZLE8
         AkjhBg91C0PFffs0zPq2Jwr+mPhmlDBLeDKKE5tMXtpryaJj3VjoJqTEF8LOdDXU1TFw
         B7x8mdtkNSp5zhUtkGn/i6aD04yhO+lQQKLoEVbUCHb+WfeWCK+01ps+gve2DeZJxaqr
         h8KE15ffaHHlSXYbspR/LCKqYOtGJxRSSFjoL+HNk9DTZKcZOXEDSV4kYVTJ0pJTAmTl
         lpv1phRUn8Jveyv9LjtLqS0QW7P424l/gvSUgHsModMECrd3ESI5ryA587UOUT0hnS/p
         tbyw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794239736; x=1794844536; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        b=uGxOGdGGE7cFsB8RS8BPWI2409uPYwkt3AbGztc5FXQm4peMkkLI+MqowKgwlE+uM9
         ocX6fLK7ZOB35W+XBU0ufmiaN6/8wH3CY3iTRUlyq2AToGvIIFm1LCpQGQfo6CMT+45Y
         bWSKtXVIBf60n2JrLjfTxOX4+UdnTPxliby6GofIDTNEYpQ3EWyOMwZJSqYZSF6fVTTs
         L73D5AORilU/IHdiV2KsZfDOcnaOabDqT7Worek7jPIWKwvKbV93pZgUFQYf6q6LSyDa
         AmZbPOqk8d5AonDUz9gdi8hCVqJ0LW+/ptKgYkKuKiYy/3ef4QmaY6n9t5P70HIjE3eI
         MO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239736; x=1794844536;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U0Jsq4W3eeFxH08Ha1MiRKApbxlSGjDxuaxUFi4tWRw=;
        b=lM+C7S3C276bIN5/RnRcM0hgyy3P0KYPFUgSPtXyr5Ms6y9TM7cZEIubm+M2Rl3l84
         RdOeNcoLs0UTwPiiEbElJbIucH+Pfn4JhZlIahzQYZQOD+dB8R29OcueRJd3EWuSVRJV
         FOuPpByARZySSRO5ENey1xqCkazHdySYhO9AfBkSNHFrWG6yQIrsFbQBJcDiZ1/Howcl
         UtjrSALOb+bST9xiE0zyvR6Ax64Gv+r7SRqpconzZpcIU1JnjGECKmJFPPIui/zBMirP
         h5TCVnPAsoI2Xbo1Tx9h4VUhr+JguTUn9KN5EAIhbpEncgTfqp3ZU1xNbEbtosI1A5M4
         lYCg==
X-Forwarded-Encrypted: i=1; AL+hErF8pSYz8UysH06OVP2shcRMTqQke/oxFj4OWbwVDgWNRg9lVOakrpZkagVYDn6abVmzbYXadfix3Cs=@lists.linux.dev
X-Gm-Message-State: APuU4Z8S0YCq8jKcoYaVSNmoL45BY5QCyPn67FFp3e9tAFqp4Kn5aJaz
	2YddoGRFtTshnXOoPwJbdWCSmJclT+0ibKJv24rLM7Hyc3eN1U2tWoIC5Kq2WNEZGNvOO/bhZs5
	xIRYSFP9+MG1xfq9dm/10qRYUkY+ayDxdiMbpZlhDdQ==
X-Gm-Gg: AYBFou0d8S1WqkIoohg8Uo72xignpz80KupAQsAIaBysJLxZki9WZT/VAYNwpG+xWJH
	h8HSVvb7flmzC4BiozF4rAiL78aTp/NlryNvy2VXdc0KraQNSPtEP2I6Yn85J9jPtomjkwK4tEY
	HvwOy0dMEnos2Dg6eRH/DVGPrKolk4lIXRgkUEmvxDOfvrSxNK3OEFMhf9cKSJ5JVK02U2tcbsE
	i6Bqhmt05GH02mtmYWQmqFZoZ0TTGpsMMjp6I1sIxFv+X1hrygUuPhFZ5QHGFUqBP4S2UFzyoOW
	FO6dzsh9UYDoKO33+mqMjksC+esFOENMYO41B8Q7/zyZVwJeMZBk1L4cGoWDhCRZ2I8iX/HF8Jv
	/sgsdsKS5z1QVyGlfJJtzwJjvmfwj2EPs/7ht08qIfN1ESTOSKaqImF3bznDh0t8fKtOgxA==
X-Received: by 2002:a05:6402:561f:b0:6b3:d0e9:2e87 with SMTP id
 4fb4d7f45d1cf-6b755e86651mr30882a12.5.1794239735838; Mon, 09 Nov 2026
 07:55:35 -0800 (PST)
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
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
In-Reply-To: <au7SabL5pfbsApyB@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:55:23 +0100
X-Gm-Features: AclHuK9poa26sv5bNbXpCPCpPoDt4sJTZSu0qBPd_Ku0HfRlx1XeQt-Jp_S2E7s
Message-ID: <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
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

On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
>
> Hi Vincent,
>
>
> Sashiko reviewed this one so I'll just put here my own concerns instead
> of repeating.

Regarding sashiko's feedback about cpu state ranking, I chose this
ranking on purpose.
For !SMT :
- 7 CPU is idle and fully fits (i.e. return immediately)
- 6 CPU fully fits and is not idle but we can preempt current because
of slice so the task will run on the best CPU immediately
- 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
can easily miss its deadline
- 4 CPU is idle but doesn't fit at all. This is even worse

For SMT
- 7:CPU is idle and fully fits (i.e. return immediately)
- 6: CPU is busy and fully fits. Although CPU is not idle, task can
preempt current because of its slice and run immediately on a CPU.
This is similar to an idle CPU (and maybe even better). While writing
this, I realize that I should probably check the lag too
- 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
can easily miss its deadline
- 4: CPU is idle but doesn't fit at all. This is even worse than -5
- 3: CPU is idle and fits for task but sibling is busy
- 2: CPU and sibling are busy and fits for task and like-6 task will
run immediately
- 1: CPU is idle and doesn't fit uclamp and sibling is busy
  0: CPU is idle but doesn't fit at all, and sibling is busy.

Note that with the push mecanism we could look for another CPU for the
task that will be preempted

>
>
> On Fri, Nov 06, 2026 at 04:19:33PM +0100, Vincent Guittot wrote:
>
> > Add a new level for selecting CPU when select_task_rq_fair() fails to find
> > an idle CPU. This last level compares the min slice to select a CPU where
> > the task could run 1st.
> > This helps a waking task to select a CPU where a longer slice runs
> > instead of one where a task with the same or shorter slice already runs.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c |   2 +-
> >  kernel/sched/fair.c | 157 ++++++++++++++++++++++++++++----------------
> >  2 files changed, 102 insertions(+), 57 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 031efe7d49fb..d71da9069218 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9012,7 +9012,7 @@ void __init sched_init(void)
> >               rq->sd = NULL;
> >               rq->rd = NULL;
> >               rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> > -             rq->min_slice = ULONG_MAX;
> > +             rq->min_slice = 0;
> >               rq->balance_callback = &balance_push_callback;
> >               rq->active_balance = 0;
> >               rq->next_balance = jiffies;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cfc99b94d9ce..039dce244aaa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8842,11 +8842,25 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> >       return new_cpu;
> >  }
> >
> > -static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > +static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> >  {
> > -     if (choose_idle_cpu(cpu, p) && sched_cpu_cookie_match(cpu_rq(cpu), p))
> > +     if (p->se.slice < get_rq_min_slice(rq))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
> > +{
> > +     if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
> > +             return -1;
> > +
> > +     if (choose_idle_cpu(cpu, p))
> >               return cpu;
> >
> > +     if (*slice_cpu == -1 && choose_sched_slice_rq(cpu_rq(cpu), p))
> > +             *slice_cpu = cpu;
> > +
> >       return -1;
> >  }
>
>
> Look here:
>
> CPU1: CPU2:
> FA    RA
>       FC
>
> CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> Let's say RA is running on CPU2 and FC's slice is 10 ms.
>
> And let's say FA has 8 ms slice, and a fair task named TC is waking up
> with 9 ms slice:
>
> * We look to CPU1, 9 < 8 is false so we return false
>
> * We look to CPU2, 9 < 10 is true so we return it.
>
> But the problem is, CPU2 has a RT task running and we are going to
> compete with the RT task. In that case it can be worse than CPU1.
>
> So, I would suggest something like this or so:
>
>
> (My editor got crazy, so I had to copy this diff :<)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 262626455497..8b0dd858f332 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>
>  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
>  {
> -       if (p->se.slice < get_rq_min_slice(rq))
> -               return true;
> -
> -       return false;
> +       return p->se.slice < get_rq_min_slice(rq) &&
> +               READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
>  }
>
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
> @@ -9193,7 +9191,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         bool has_idle_core = sched_smt_active() && test_idle_cores(target);
>         unsigned long task_util, util_min, util_max, best_cap = 0;
>         int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
> -       unsigned long task_slice;
>         int cpu, best_cpu = -1;
>         struct cpumask *cpus;
>         int nr = INT_MAX;
> @@ -9204,7 +9201,6 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         task_util = task_util_est(p);
>         util_min = uclamp_eff_value(p, UCLAMP_MIN);
>         util_max = uclamp_eff_value(p, UCLAMP_MAX);
> -       task_slice = p->se.slice;
>
>         if (sched_feat(SIS_UTIL) && sd->shared) {
>                 /*
> @@ -9260,7 +9256,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>                         else if (fits > 0)
>                                 fits = ASYM_IDLE_THREAD_FITS;
>
> -               } else if (fits > 0 && task_slice < get_rq_min_slice(cpu_rq(cpu))) {
> +               } else if (fits > 0 && choose_sched_slice_rq(cpu_rq(cpu), p)) {
>                         fits = ASYM_BUSY_THREAD_FITS;
>                         cpu_cap = get_actual_cpu_capacity(cpu);
>                 } else {
>
>
>
> Cheers,
>
> Kayra :-)
