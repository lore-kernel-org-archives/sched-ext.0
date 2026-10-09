Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27963AFCFA
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555485; cv=pass; b=hXtrkfUcZfRcWEexivK78HvtSsnL4fHXVrDxWbvwFF55+mJBIxNnLLOIc+MdhVLLESUfCjmurUW6TohrPtyLKzJG6T3ANopz4Zw/3/mWGgPoTCRBc0yez5g6er1KQFjljZ3TDxAG/+aYyR5aWe67GjBYsy7NU1LTAlv8hPz/QsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555485; c=relaxed/simple;
	bh=yXkOOHEp5xbA8RyWHIG6SKO9apysMTvV+h4+HDrM66E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB/OB5xcg7orLBF9HnxjqgqsYAzyUijSA6cVt/oih1GPajARwREbFxuxALTU22XPCsktDpTtwiLQ9HpN+WU1QN5nSqlsCewcbg2Of0RfHf58cjyLC/2vZnS5Pn8H920oMTx/Hte2epuoJRu1sd9JFzRxs4f37bT9SZcuEuRJEIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQV0KfYX; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQV0KfYX"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so6526805a12.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791555480; cv=none;
        d=google.com; s=arc-20260327;
        b=BBZVhnsEKmFnOdq1FTnEZ5r2NdwNGER5G2+XjVcqg8zmfQ9wMEShYgZLyv/t4/RBkK
         KktjSN4Mr2HlkISWf8gxwgigjhsZAg0rrweGxZtXBr3e10FnqnwSfsEXwgFRTXqS0mbs
         n06iqzQMCAs5XlwtjWS/xS+NM+s/2wkBrTLmIe0OVCvl+JXw5uPuXCCWTqkuGt6DjLCA
         AL7H/ZnInNG6D0EpWzEbiBCvAB65bCff+9Nn5e7qeCjfPdD44EDX4xG/q3AJAQ9EwJIL
         zDfPDoD3poM2Cvqy/WdB/H79P/4SORHEIIA2ZL3MLhBBotbKTEJJYsdKM0aiSSyfy8n3
         wxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        fh=VBV3CwJ/AR3XuxDgptPFnEOZ5C6ZcZnVgIk7j5P8jcQ=;
        b=Ym/gd3Okp1BVorNNh9voVofyopYSCB+hwVqgmxlpHvqNAUNh55s1nRIr61OReU30Z+
         TgliANsHEQJngyAssptiu2HpnCS+Zeqri9bqJn0TdJAcLpSh7Lcx4kUaQ9cYhyjNvXtD
         QwI+k0CPxsy8Z/6mxzKKyvoDIRlXpiwy+kyNsH/TCqyzXWjv/koHpjlWOEaehqi43a/W
         U+gHIxLOs9FvVKZnsN/4BODWQpHHRZ4drHWM1sJYmsPi49rrKGNmJtHEZ4DzCHT+/eCS
         hCnfP+lJjk52NVftMl8FsGDDD+vF4wgPFjPImasUJ4eWA2ezLBxgVgC6hsERu27kDxrx
         qQ2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791555480; x=1792160280; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        b=bQV0KfYXJ21UHtXGMZq5pboPW7F8adO0YClAd6J9Wm5dTOIGYTjiwbhD3Bxw57GIOK
         u5kpB7K90yE282uB/T2ZHkYCiPZp0QIMdxnARwbYMhDQ/2NXOeuiVKetkYduVRe367Sb
         VvMapK1P+hH3QNt+vFFNrnZGAVFSIK1p7VylcwN+SWmeeJMXSpzdZs8SrKumeSOvSZxP
         TDfYyj1PRU1abg/DItzpa9xlnbm17DnCrsuee2dcwRXq97/O/XDt/uUsyWDHJXpGyPHj
         SsR9HjN8rYp8Ea6v0MmaKGC2sDtkDk7sZwX/x9s8VR9ih7ylQTa6muWtTjrM7WK2sZ6j
         SfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791555480; x=1792160280;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mjfQzImx89RahkOfgksZ5+FFpeca3hXEAlgOHPVxIY4=;
        b=kc3p5bXm9Cfy33tBDGOXfX5OI8RRJJZza2KHk2eSBrerMxwRt+jVbE69tvZrUu6SUt
         QsWPC0qWC+LqfCdWyGPE8Au6fr+mCPWRFZNGfoZqd5ErNhQnGRetf2dVf/gtBpdOAN86
         Yhd76ZMGc8PuMYtuQ7IiuGiEDBO51fMU8crwaNWdecv9IS9eGUW2SUd64TiRN6AMZh0g
         utBxJXNPDSb3CmjW6+QNDbvjvn8tqKVtFrEDCh/tlcJUO1J5ND1fGH6z7LuU5lTAP71y
         xnAgFMkjA3rtZsz/hmL7wP5s4QP2A5brQQNIEz6hvQxj9L/NvVyWM32PtXY66t7lrYAJ
         N4jA==
X-Forwarded-Encrypted: i=1; AKwUvBzf9kisx3T1m1ZWDKNDTiHAEf0PCn/qrNO9qnRvAKmVgrNRYWy+bHpVrPXi9h9q/gwE2yYEQO0OGx0=@lists.linux.dev
X-Gm-Message-State: AFq9FYLUKMh647aa3ClKO6wAcJFs8+SQGNlrgjnNu9lCR24I2uDrUFeJ
	JzwFJojjiKM3YANeZdr1W/XT204nFoM2kvRErAuhlUc/Yp4AtQBhU6x4EQ0nw2O06fDu9ojMwG3
	GYFNOBWA/viGPrQLO5Z8X7F2Ykocmp0VIouDO4A3lew==
X-Gm-Gg: AYBFou3spVMxl04xr6GiSjIwUOYYZYm3WV+xVkh9AGNSn1ZLj6rTBPSETiN46QTPmMo
	0i0SLtJBrDx7TALlNhJ5sFvZrQ3xShxhG6A5kh7avKZmW/vTzsHzyjhD7yY1M7n8yiGW21gEdtO
	b+FL2kxlBeMKxcucnn7GFwOyf9wBLqn0T2SJiFWLc0P6OgfBSWtPWGBhE1EjdFkKXfWaRouyOHh
	OSAyHYH7/aSzEF/0oy3qyeb9yJEhJbgeD2K893FAT0OmRljqIVNvxTLo9KoALcYE7540PlcybcR
	v8//kAlkuqcYJTAiHa1u27TUYrPlGoNTSvnSWhNdT2fImJfuPFOj5a6Y6OEu3dTZ/9mYTCk2qww
	WCWI3U6s1oL4=
X-Received: by 2002:a05:6402:4606:b0:6ac:6b18:345b with SMTP id
 4fb4d7f45d1cf-6b17c24e477mr1307684a12.17.1791555479602; Fri, 09 Oct 2026
 07:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-19-vincent.guittot@linaro.org> <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
In-Reply-To: <179bcb50be21f834423f9b5c068b5fce4cb65871.camel@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:17:48 +0200
X-Gm-Features: AclHuK8Pboa48bG0Ygkxu5EGL_q1lSvm8cRTKP-bJ5A1NhoyUuVzmn0zHI8xqpo
Message-ID: <CAKfTPtDcw6J72dJkbemySR1WKE_sWB0exXp_X1=DZSdO9BbrQA@mail.gmail.com>
Subject: Re: [PATCH 18/18 v2] sched/fair: Take into account slice in EAS
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

On Fri, 9 Oct 2026 at 00:53, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> > When the cost is the same, take into account the slice of a task to try to
> > select a CPU where is will run first.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 94554f165f42..d60bb6db4ce9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9598,8 +9598,17 @@ static int check_cpu_with_task(struct task_struct *p, int cpu)
> >   */
> >  static bool update_best_cpu(struct energy_cpu_stat *target,
> >                           struct energy_cpu_stat *min,
> > -                         int prev, struct sched_domain *sd)
> > +                         int prev, struct sched_domain *sd,
> > +                         struct task_struct *p)
> >  {
> > +     unsigned long task_slice = p->se.slice;
> > +
> > +     /*  Select the one where you can run first */
> > +     if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> > +         task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> > +             return true;
> > +
> > +     /* Favor previous CPU */
> >       if (target->cpu == prev)
> >               return true;
>
> Hi Vincent,
>
> The slice check above comes before "Favor previous CPU", so I read the intent
> as: the CPU where the task can run first wins, even
> against prev_cpu. But the slice check can fail for prev CPU
> and we can skip to "Favor previous CPU" and pick prev CPU, even
> though the task can run on min CPU first but not
> necessarily on prev CPU first.

yes, I wil fix it

>
> Take an idle CPU X and a busy prev_cpu. Any task can
> run first on X, because an empty rq has min_slice == ULONG_MAX:
>
> - prev_cpu scanned first: when X is the target, the slice check
>   selects X.
> - X scanned first: when prev_cpu is the target, the slice check fails,
>   and "Favor previous CPU" then selects prev_cpu.
>
> In the second case the task is stacked on the busy prev_cpu even though
> it may not run first there.
>
> Perhaps something like the following is better.
>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a47c6521a411..3fe305d690eb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9830,11 +9830,15 @@ static bool update_best_cpu(struct energy_cpu_stat *target,
>                             struct task_struct *p)
>  {
>         unsigned long task_slice = p->se.slice;
> +       bool target_first = task_slice < get_rq_min_slice(cpu_rq(target->cpu));
> +       bool min_first = task_slice < get_rq_min_slice(cpu_rq(min->cpu));
>
> -       /*  Select the one where you can run first */
> -       if (task_slice < get_rq_min_slice(cpu_rq(target->cpu)) &&
> -           task_slice >= get_rq_min_slice(cpu_rq(min->cpu)))
> -               return true;
> +       /*
> +        * Select the one where you can run first. Check both ways, or the
> +        * result depends on the order of the CPUs in the PD.
> +        */
> +       if (target_first != min_first)
> +               return target_first;
>
>         /* Favor previous CPU */
>         if (target->cpu == prev)
>
>
> Tim
>
> >       if (min->cpu == prev)
> > @@ -9762,7 +9771,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                        */
> >                       if (target_perf < min_stat.min_perf)
> >                               find_pd_cost(pd->em_pd, target_perf, &target_stat);
> > -                     else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> > +                     else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd, p))
> >                               continue;
> >
> >                       /* Save the new most efficient CPU of the PD */
