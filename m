Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23DB49E5DC
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051360; cv=pass; b=g8oJnTy5td0BnqKZ/br0M+K0BRMEX1kkCbwc683sXzYPC6MO1mFDDAuhxPJPwgv/cRjT/HwGM8lphVB5EBOWBC+fpACAsq2qp4hQq40UfY7cxUxTxppO3asS89dmrvjnr+KOwiwaZpViKVYioErumm5ii+BVf3UtzSbNKRlRqX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051360; c=relaxed/simple;
	bh=eRRqK9tqBDZb1946J9prALf3IBZg0i+rP/Tm+Nfy9u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+o5QyI3Roi7YNw2pvLfhqFxxZvPEwmnV4pPl/ptF9nPUUsUGrvao8ZDDz86ztE5Lc1hNhwxtZ2K++36mMP30Q1znnb9Ee/RvV0RKvKoR5tM+R3Tdl2iD4W0TdWnk+WpRAO6ho/40ju4Zvbh8vdxPCOwk6wG7TcgfvGEx6rWJPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJMnVjqf; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJMnVjqf"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2acc1e170cso846573166b.1
        for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 01:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792051357; cv=none;
        d=google.com; s=arc-20260327;
        b=UVPCMQSqbxfXUkh/4keR9EYptjS0PSX+AIxhTxHfowt3VkHSOl0/YuRKlEZ20r+XEz
         FcvO7y9Q/gMwf6E/Jcwb1JbukI2/76a2yXNxQSiBI9MWG+XeJO2QoQlg9yFvYuhC9fGC
         ay6vz1w6qmB0y5Lu2qbED2Q5WMlpjzyyqj4PSstZPMlyD9lWWG/qK9nFtMBas7OUIV4u
         W7KsREnKjdQO/hcAGZFCGaroH2qNxIpWb92Ty0qKVsSnG6wknekcf9xXQHVE9Efkqe0t
         wnLaYtp4Q4FEzzPwR7ywb/m4sln0oxsOMbpnU74UK0g42MDqsivRr/3DBqvFahw0VVzd
         HQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        fh=plxcKDfTvPO0pspBBcRcUZNz82vEP+DVctn/lrJIHCw=;
        b=ajq3as28sT9oUYPQOEAVbG3tTZ2bPDOgUckhJkwGIqJ2FMLArfwGIwHb4Cq17b/iRy
         i8MgdkikHJBz9RN92HAoNKLPkmM8Qx3XZa/3SHpUaUPn58n2TrJ/COjKExvLZoeOXMjP
         qh4w8DzsBHtTEp74YwnhUxVGkCZKahJwEG/8OyQnvLKWt6F5GdQ1lXvplE8lJt3gGPKe
         U5+c2pupCVQ5ZRst47r9tQ87zi+ovh6tNzi8kciGt8nnWxX6b4TfBw8o70+GbT2U+5L0
         G6NvmfpO2Qy2mnTgqJjlYdzGeYIeBR72NK4ENR/easvW4eN9dSjrRTk1obfal694CN1S
         lnsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792051357; x=1792656157; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        b=dJMnVjqf0YL5Eh3WT2GvNussSxpxCO9XCxD3ofpu2tGQVfyhRKUK59CxxR3QsTJVUc
         GBphQyM2Q+FQjnfyTMQ9Kch6wwrvRSh3IBP6OQ2rL4b88ef9pFxCW0IUuYLLnDvND2Ey
         zjm63SJIfCLWz0gjUt0jPr3R1Yci35ePMivEM7oGMp2oaJsmw2WgHnHoXnMp2HDvaDNy
         MWdCXVwowzliFnEKIzayIjOsflZAbBnhkHo8F22o3lEqrDmF/L0s2Vw6lbFQsbTPkhyX
         v/NYSRVqd9FatsenD1Bd2CEPczNBriUQC+PsScwbLXbKIYd5f1uHv3LaGFQVF4ygzvNI
         SG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051357; x=1792656157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20IfJrL4vQgVppdX0l7DtOYLpzRZDDrYGwERMl5G+kA=;
        b=AyonezbS3Wie9USDJAuM5qdidm3tqNBwu0WipWjT9J8tT711i8/VRQXRSVl+8iwpFL
         hJBHYes3nDzMqBQ8PE6YCFjnpVw5z+IPt432b1kDTN4Ixb8h/qRwefiNneFW7rtAH73L
         s7RM1ukQL2r+Q08w3+zvRJI0ONCZXs3oiDSnlRK99BU8jq7ZPlxcikz7Ud5QN7szeTiU
         R5rFcK1KGGUteDNv9l1hZkGj8y4k9E+o83SPv3E0iP6vDk1RSUjdOAOEQuZpLkzi/hWh
         Pk42d5ZdK7Whh1JzHfdv5X7p7zFgxPt1yX5Uh7tc9VJaXqfKxq5NmRUyzIuA0LLN5JSw
         sW5A==
X-Forwarded-Encrypted: i=1; AKwUvBym5TRAxhWHQEC023q9ZjNpbF9yI3OLwakVFKT0IN1JT8KIyLhqIt9V+1wzlpJr5TLKdfwRwEqJJqs=@lists.linux.dev
X-Gm-Message-State: AFq9FYLoXGcbvZB8UGMpPU1bMWuTaFUEHp7r4c4I2tyXPMoK8f8k5kqj
	X/TyW+Ou5lWaAzVvr4zh23L6ycP9c4CU3mGf4KxOIjmBgtxC0Gropc5A72cnNmAkPKqRjlvy0g3
	fruS+Qakr4Rfg6oGY7MiJtx7UTR9q/mQ32Hbhm75nbg==
X-Gm-Gg: AYBFou3HQnPPed1d2Iy++gSroXlx3Kv3Sw0XYudWnVUS4pAdCByf9DnZDxR0cnl8EKx
	TUwcygQnbndffyY/42L/4cBFAy1zJB2otqVpYHpgC0F2rdICUTQIMcNDSWPtA1qGbP0eYziZbdJ
	j7xWoOhefppN+h8gGj576BnAoF0V36vnMZA9usHUvAOeeGIZuCPd3nSXT3r3sNRHc/3FSxA6sgj
	7lDv5TleEGE1OqPOe2a4RLMv4X24Nzt6wOeJ/fBRBg7pMoJFcK4aYRb48FTkU6NlzTwt4YVAPwj
	83Z3+SfkDjXK5CIsrGD0eGyzpkYadQLWQkHUv7gtJRLsGqk1Tn44DLCR24+jFwVKeAl383w2Wr8
	w+2v9NpB2i/XB
X-Received: by 2002:a17:907:d90:b0:c2d:bc76:8342 with SMTP id
 a640c23a62f3a-c31a9a2db07mr1677128166b.5.1792051355396; Thu, 15 Oct 2026
 01:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
 <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com> <4976fcef-29ec-43fd-8655-32874720ee73@linux.ibm.com>
In-Reply-To: <4976fcef-29ec-43fd-8655-32874720ee73@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 15 Oct 2026 10:02:23 +0200
X-Gm-Features: AclHuK8YXmCN4MxRL0pXtxsV0nS_mHofnDRL2bLTzz6zddGioaxby2TUQxLM0Zg
Message-ID: <CAKfTPtAXCmf9oqy-BKYRR-cLHFQGcgOCVPwN6s=3x7hD5Xz=hg@mail.gmail.com>
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

On Wed, 14 Oct 2026 at 18:28, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
>
> >>> +static int
> >>> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> >>> +
> >>> +/*
> >>> + * See if the non running fair tasks on this rq can be sent on other CPUs
> >>> + * that fits better with their profile.
> >>> + */
> >>> +static bool fair_push_task(struct rq *rq)
> >>> +{
> >>> +     struct task_struct *next_task;
> >>> +     int prev_cpu, new_cpu;
> >>> +     struct rq_flags rf;
> >>> +     struct rq *cur_rq;
> >>
> >> You likely need below to keep clang's context tracking to be happy.
> >>
> >>          context_unsafe_alias(rq);
> >
> > I just noticed that I didn't answer to this one
> >
> > Why should I need this ?
> >
> > rq remains the same in fair_push_task(). I'm using rq and new_rq to
> > differentiate both current and new rq
> >
> >>
> I tried to use clang-23 and get below with the series applied.
> It may not be exactly here. But somewhere.

ok, the two functions probably need the below
__releases(__rq_lockp(rq))
__acquires(__rq_lockp(rq))


>
> make LLVM=/opt/llvm-23/bin/ \
>          KCFLAGS="-Werror=thread-safety-analysis" \
>          V=1 kernel/sched/fair.o
>
> kernel/sched/fair.c:9971:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>   9971 |         raw_spin_rq_unlock(rq);
>        |         ^
> kernel/sched/fair.c:9983:2: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>   9983 |         raw_spin_unlock(&next_task->pi_lock);
>        |         ^
> ./include/linux/spinlock.h:279:32: note: expanded from macro 'raw_spin_unlock'
>    279 | #define raw_spin_unlock(lock)           _raw_spin_unlock(lock)
>        |                                         ^
> kernel/sched/fair.c:9980:2: note: raw_spinlock acquired here
>   9980 |         raw_spin_rq_lock(rq);
>        |         ^
> kernel/sched/fair.c:10085:2: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>   10085 |         rq_unlock(rq, rf);
>         |         ^
> kernel/sched/fair.c:10093:1: error: raw_spinlock 'rq_lockp(rq)' is not held on every path through here
>        [-Werror,-Wthread-safety-analysis]
>   10093 | }
>         | ^
> kernel/sched/fair.c:10090:2: note: raw_spinlock acquired here
>   10090 |         rq_lock(rq, rf);
>         |         ^
