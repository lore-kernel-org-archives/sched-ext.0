Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238484;
	b=TUVIFkF0bliN8cTpdfotpX9WmkZ60Cjp39THSjPq+J95/iD79+KtEzjJ+rVaA7l/r86Y
	 sF2zjwY8NUdSuLPjGZllxlRWu3drn5TNMew99ECM1pAh0cAn0HUBpzu25efyXvtNbanZB
	 BjhjVxn7cX0Ef6xhqu+rqfCMsTwqxztbBs9IxFUXbL/z2gnx8VnP2m7SYrkumNDzyD0Iz
	 bNgq/QmdHz4Q0nxYwB9o7t6Wbf9s36UPElLyAN6FbQvv+U4g3mG/DFK9xjYUH8axm8wHi
	 lTl+cOwPCAVSpLwxIDXWItmmEWZF/HZrrrUs22KJMUZEGcSM+aI6Po1VAIJYw1Gikvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
	b=svs04iqdtLqhZqXeYbgIgoPQu13tfjF1g8/aRz6AwySrLaZln9NjnKuAq1UuHqY+qqhd
	 MIFLjhuhwipmajprhJ7eJwklfpzp89xaRausQuP4IaJXqfZYpVxr/B9s8LebHZrHLMnz5
	 eKIOuYKPCPuXQmEx7HXJb+e2Y0eiMH29VZQ9SGLhgUqZThe8pSZTsmwdbl5a6VKO3nSNa
	 +dsCQp0aw6acO1Rb28gv4uqppqqWmsqRlXcAxlSNTm0aDLH8mESKQ6jGodeYCgottZ8sA
	 qrtnxOceBxViW18dO+lgHoqlSrYyMb6/mfyYJYxzgSWmWO6Gstlu6BWrHzmXenq8vRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EJWvLdYt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61443606A32A
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61443606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EJWvLdYt
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso143660366b.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238483; cv=none;
        d=google.com; s=arc-20260327;
        b=rb+D2QWW0+FjnVocN88dwjBUqMN99mCIz+EVxlXxO8GYef6jYS1vsd0H3jTJsBOyaS
         gA0xSWvqhiakgHz9sA89UpxlKJW/eA5hC7mMl4t8YcUvqJvxlA91H8/3WOz4C7U9kuqN
         ke1KfRUs7d3u4blPOcVQW746kdLb7OfCNDnnRxh0d12RdMSCU76K9/dixjPyhdhIcgoR
         ODdRMKCMKDMhs16HHnUNVc63jusUJV7zEld2is5wjcvX403tLlGSLmeOWx1AsOW+bBxW
         ijxL5VQ5AEXewXAOO+cnz+fZcmfG0j2gXzrxDQOKBpYWTdzlpZH4lnvemYyCnvoZvYa1
         +e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        fh=QwOM1R3jf71JnHPeW3oMjqKMoC3Zr4JscTOnw7WbO5E=;
        b=WDJI/aCpIN9HO4c//xK37dGaGhU5IMStZ8Nq7jk4cseqjgo8wH7Fg7TevdXq/DLlx7
         SyCtPqof0FzdKu+tXLnyqO8nmOIkPjZeoS6JFMhCN5kguvHEqtgDpc0ArGrYuWoSnhqA
         DU/QKbveiUGqFjj4J+WDE+b+hLlNMVwXI7wRsI4RsevJp67RRcS0BxoKrTB4eJe0R5/d
         tbG1D7E4McfO3jlUdITsq6OKnkFTMCITS+YyZjlvS6zvbUtTQ9iety/kAyDsLKLSf5zo
         7p0clkCw09IaveKfIjzLV/BQpJTyx5HKhD6AaduFVX877GMxcfT5SqCg2Y12QzgGcwWQ
         yCKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238483; x=1794843283; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        b=EJWvLdYtMaUCDEGNTMijMfB1ZbdtNhubkkHZ6XEUIMz5ueQ6SPoQSw2za/QFLODpFY
         DREemRzQU+KMheTV7oD+0rYjRvgqxJeZ9ks2tU4Nfw6WUJcs/9ywf546Kxlt7Wrrk1A4
         owbR8bYwf1JIq3heSnMGlYYZhIAZTIBAg6QgiXceoHGycm1YYC/Vcn0kSFeI1s+8mL6b
         5YCXQM6rOvVGIdhXrKItR7jXzk9jbWn+AvBG58x17VfmEfpsTTF2zw4r0VxG5wZzLVwf
         0eyK0yRl/zFZ7SGyyCr+5etqgeAHMPVs4JQSRlAYF7CD9IHF1C3z6/fnu4m9STKM/8Wy
         aO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238483; x=1794843283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tZb/JlzaDfnhk48XsH57Tsc9HiRXe4mXenMyxxS+EE8=;
        b=f64Pdh4QB1SjJODKiBUcWVadzjT25kzGNI5fVbEKwyJ1JOr/M/ScoxYN09Dbm5tMLa
         erigk01ZUcKZA4utdNQgGvlyiaMsW18pRJFB8Dc9KyxLG6RAVO7WiRerPKjgXBTg35YQ
         KouoP7NeEVg4KIsS8srgnZXVdOdnPTpN+GJnsr5Ugu5c+rDmbF/kvKo0tf/xOmsX8BIW
         lexbXsEzxRFavQbnQ2ghidC0BxUmcTxsp/Mv+kjjAg2qoWlzlZWo5Dpkn8vvO0UIXw/W
         uY13kAtcggKBCkRstEKrRqzX2vn05/q7Y0ndG9Z83lzyixXkSZjdTLFOT+fUkvNjOse8
         FEIg==
X-Forwarded-Encrypted: i=1; AL+hErHttxsjc0fijBhvfEKvnH76r+NAULupqx9f1HcfeAV8OHwwXtxGBGeo30jU1KDM7cZ6qPandD5Qfcg=@lists.linux.dev
X-Gm-Message-State: APuU4Z+NrXO5zUPDKtgrm2Bn1pj6Ncup0oVBLSJJ2O19dt6TDJAsQLct
	tbV2VndgiCvU6G8bFqGpfR0qNjE1a+Uo4QSFao5jj1ZTd1KosaK8Tp4tbq9pSyYDhpyj7QDJrQv
	B1padJ93j8uwQ0JZvM2mMEuvp9HjlNIIGb/q/BjbrIA==
X-Gm-Gg: AYBFou1uOr+qPru04RFLhfJYd3hBKR2m54vWtttMBWvA7DHkOfc1yS8mlBeX4rvsm2W
	y+g1W2HcK6eTMtFrA7LxBUBd1oWVMOWhksZ3EZoe3gHpwJ9O1bTLXdk8Qr7cpg5DURlttwl403R
	ICZMPSekd3xE60or3T7Fn2HQAnjK4H+L8FJIx23dXhJLHg7SxnizdUygbWCb/gVX/EhHP7y5XS2
	U6KTQse50SsE33oox+l5DSc4PC0v2UOpl80t8RnnWUxXTqDhfMqt3+T8GEXwx1Uvxzks1ghK3Tg
	2Jsm82fzSY3TDzOW1JbVZuAm4XvuRbz0Ter1ig46JihNVuHh7wG0Kjy+otMdJpNY9cLoqmEUgTi
	fF7I8nnr6W6Ss7evz7i7UhKLo8TIVgvlAyX2sDEnPmvHmSf8x1VRWLx39qOaiYNstLNxNLhqWDE
	1YFXLbGgUAWLupeYs=
X-Received: by 2002:a17:907:c06:b0:c49:d1c5:431a with SMTP id
 a640c23a62f3a-c4d6dd7ce91mr380002966b.38.1794238482427; Mon, 09 Nov 2026
 07:34:42 -0800 (PST)
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
Date: Mon, 9 Nov 2026 16:34:30 +0100
X-Gm-Features: AclHuK9N2muwxBwXja5tSUoZCIluDqTOafx-CvDIw1G2kK_wi6hfcBvvANqgYW0
Message-ID: <CAKfTPtAen9jnDpaE_318hTys9ek5VzE2LUaXGz2LWdGYfOtaEg@mail.gmail.com>
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

Yes, but we don't really know. The only thing we are sure of is that
TC will be the 1st fair task to run on CPU2 whereas it will wait
before running on CPU1. I tested more changes on top of patch 20 to
handle the case where the task is enqueued on a cpu chich run higher
sched class task, but I was not yet convinced by the result vs
complexity.

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
