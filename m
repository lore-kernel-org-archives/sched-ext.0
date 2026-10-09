Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091242B742
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552924; cv=pass; b=mPVdl+fdNPtK9GO1EsKOX2X9xIcNQl/oyCDfZBEfpeOXQPOfblmxoU55t1WYG03hyxQsCrEFXZ7CuFK9NEhnC7tef3/PSjZCao13n+BVTzROWLcZg6ErWkYnHktTYhCj1HgRnHZ90iV7vHkGqY/p+rSvOM6FzTzj7JyYgC1hb7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552924; c=relaxed/simple;
	bh=NSL1230ZzJQ74Jx1KNkVBnc3qpUs25gQVJx30zAtXRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPnVDjY3gqrmCXhbHBBPD5yzDTmCp/Ucux4QjmyCtUEWW9JX46PXsRmo4kkPpCjYcrj5Iuc/jF8Pvy8WUOFfrJO/ptZ2bpp2k1aFhyAJibhmw5E8ftrJj2fjZmtzFTMnwCKEDvWnaxyXHiAgzX3zl/6v39Go106X2tXjYPn55J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogVuEU/3; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogVuEU/3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2e62319cfaso660720866b.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 06:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791552921; cv=none;
        d=google.com; s=arc-20260327;
        b=m/enK6/Etajp3NvG4YpvUcLGeSFV2PQB/xfcqeVOLGPTnnfgE95S1JkZLX4MSjlNsN
         ga3gf65mGhNaJVEfTURt6YvKx5ExEvWODyu1Pd9py4X5JtKzEDQVw2Xvfjl0uba7iYIa
         oIzDVceD56+T0ztCvrn2NXbOLBEWUU2PxaizVY7UUrSfuvgm388lV/vUVkkizhUoRflg
         ZD6/7BezAf5OuVSi7k3UzrCmxljSHhOQc9Ngx/KiSwJlL441hssJHUCoqGlbz3Hsgqki
         MsFwUm+fr+0Ce/rCmzmJhQOBryJ04Q+/mbuPJgRs4f6DccyYYiXIH6/lDetjrwLJrac8
         El6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        fh=bNAoK568glOZHbceI/qhZIK4y2XPKhc+00Bo1gYIoCE=;
        b=eChS5YVXADy/14Uq7wjicjZTlFZi56/WSP5gn9UaNMh/fIEIK2NzhhcUmpsyTuyc+s
         ASu/v2j690bDcQW2m8kiDOjcXjEyCzv6zOHQtRWYiC2NuxteYdqErC21q0JZj3oPTCFh
         NnODrZ70I00YQsEvBzoIudN7mbhWqrXGheh5Ok11USk2rIyTAKk8nUX+em14ndIk5j09
         v1mIk1wNK5wqXscYEjGDiJtgUHyMaLrUquLZNIv4uBZyfQpeaL0lwtH9oA700xceEpJ7
         pRHzr2Juo/V4Nqo9HpgTZ4KqH61Z6MaFuenCfgWflxB8LGKTtx0AAxrdOrzP6BG2POVP
         DZeA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791552921; x=1792157721; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        b=ogVuEU/3hpjnKMlZXoKnoF29w1ooVM4C4P/AWcz/zOqmr842y7epmXhckmtd9tKel+
         DHoc0ReRZowlzo4BgVQiMxilHuYdas++QONastfRO83w0EU3GfI7kl72T/v9ydUkJv5s
         aNcQiHyYiCqBblxpqDNYHhdA7bF1kBgDhY9Bri4Y609CbIK/QLQ4PZkivx8YoP8v+T5I
         QRNzdj2idPulCN7hJONwAlyfLtrdbBK0kd+7A3tRp3xNjQO10QwMh8oIiH+HK/ctUTrR
         kAHUVvYWzuCrV+1fnjM9Wz3MKdzW/y9UE+a0wNa1zkUiFxEL/49eWN7RKMbzlWyIFIbg
         sSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552921; x=1792157721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gh61X4RiGipDxIUahocXKIUNnUE9ZBer048Hrx3Sr0=;
        b=0T2Q6vFG77KmA9S1QHkbybuC80n16+v0YcMeWGn6lD22Xj/tzeUGxJ6XZFReORnvrh
         cbgiSjXcfXH37fQrlGegArW6334eN6EUkWBDW/1s078VegBUXL2tZGDR/0PWbkE5xAZD
         bwQZ57+WCgPGqkzs0mae8rb/aXUkF0D7/cUjD9w7ugZM1GbJdhyhfCxeW19Uj6jsP3RR
         94zrjdpZF41Mos++f0+UyI6u8ylj/++xUeZlooyv5Y2MAPAREqwPTQ7yQw8yD3x2rBsm
         dBIK2T/yn8YSqrONolkKOFtf3f2uCqpoOreEZtZtN1JCgXwfPAipf2DXypUEIPg4BGAl
         d20Q==
X-Forwarded-Encrypted: i=1; AKwUvBziTKnhCzRyAwKxo/xdb9XXdHvcrKQOcd3vXcod3nii7nIv8vFOVL1uo77yzYwPas5EdH5ZaDAqUPU=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ20FZnmfjt2K39QSAoSuvOKFgRp2EuZ/RAGHYCSBE+AcgknyJt
	iDb387T5lxo9hP2V7BmsfHV6M4JPlCg5bGoYa9B+Tdp3rn7vk6NXJ/d0d84cBfCXQNPs81zlAIx
	Gt0t+3Ab5jN80lKT/VjjRg+aEgmWRX9qmRIwqTWRL7g==
X-Gm-Gg: AYBFou0Cx21IoBEwRQidZYe6H9R5yLHc36GphyEaS+elkxPqjlX1I/VPUChmN5T1hkM
	PHlWsLhuOAORuaKRYXZ+pGWsIL0SC9RNvSSltfUVyO3aLmVUOGCi4LrPhj59ad35vwDrygRY3Fn
	H9SsJsS4xJhVo67KxMT6iONnVMlm133cTf92VrqgyVuG4bRS0zZZ6FKdD3i/kGS3zPMx+6L0j+O
	xb5NgkPMQdbLQUJ82Uy+FVpaYdyzJQQGl8FvfdZEKK3f0SIKr3MD70CwNY6dqKwPtwZuj/Cf1I1
	ADp/mEiEDfte3T8DVBoySuYgkvVe00Jt0cs7i0BTkD14MS3yHJ7TDThO81I6oX1LJduMRDiyRQZ
	NIXROVPcLfuU=
X-Received: by 2002:a17:906:f592:b0:c26:19de:912c with SMTP id
 a640c23a62f3a-c31aa07ba07mr238720566b.31.1791552921162; Fri, 09 Oct 2026
 06:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-3-vincent.guittot@linaro.org> <20261004173032.18867-1-kayracizmeci@gmail.com>
In-Reply-To: <20261004173032.18867-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 15:35:08 +0200
X-Gm-Features: AclHuK8U9thImNFByGGzg7OkoOg8Hahf03eIGKYMWN7wt2qam3WUMqyVYhsj5oM
Message-ID: <CAKfTPtCWNmVcQ_R+dN0MdZoFnXAGkJL3XmnqSN64vuz_doQzSg@mail.gmail.com>
Subject: Re: [PATCH 02/18] sched/eevdf: Reset lag when waking up on idle cpu
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Oct 2026 at 19:30, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > When several tasks wake up simultaneously on an idle CPU, their final vlag
> > will depend of the ordering as the first one will lose its lag but not
> > the next ones.
> > Reset the lag when the enqueue happens while no fair task has already been
> > picked et set as the running task.
>
> There is a typo. ('et', also 'depend' and 'loose' Not sure that's all :>)

will fix the typo

>
> > As a typical example:
> > CPU0 is idle
> > TA with vlag 0ms and TB with vlag 5ms wake up on CPU0 simultaneously.
> > Depending which grab the lock 1st the behavior will be different:
> > If TA is enqueued 1st, TB will be enqueued with a positive lag and will
> > be picked 1st.
> > But if TB is enqueued 1st, it will loose its positive vlag and both TA and
> > TB will have 0 vlag when fair will pick a task.
>
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d7cc77181ef9..32d7077ef148 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -592,6 +592,7 @@ struct sched_entity {
> >       u64                             vruntime;
> >       /* Approximated virtual lag: */
> >       s64                             vlag;
> > +     u32                             vlag_seq;
> >       /* 'Protected' deadline, to give out minimum quantums: */
> >       u64                             vprot;
> >       u64                             slice;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8cda1d39b037..4c8f12fc8869 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -893,6 +893,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                       vlag = min(vlag, 0);
> >       }
> >       se->vlag = vlag;
> > +     se->vlag_seq = cfs_rq->idle_seq;
> >
> >       return avruntime - vlag != se->vruntime;
> >  }
> > @@ -914,9 +915,22 @@ void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >       rq = rq_of(cfs_rq);
> >
> > +     /* You can't claim any lag when waking on idle CPU */
> > +     if (rq->curr == rq->idle) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> > +     /* Accessing remote rq task clock is a cost */
> >       if (flags & ENQUEUE_MIGRATED)
> >               return;
> >
> > +     /* CPU has been idle in between so the lag has been removed */
> > +     if (se->vlag_seq != cfs_rq->idle_seq) {
> > +             se->vlag = 0;
> > +             return;
> > +     }
> > +
> >       /* Compute sleep time */
> >       delta_exec = rq_clock_task(rq) - se->exec_start;
> >       if (unlikely(delta_exec <= 0))
> > @@ -8190,6 +8204,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!cfs_rq->h_nr_queued)
> > +             cfs_rq->idle_seq++;
>
> Shouldn't this skip DEQUEUE_SAVE?

Yes


>
> > +
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b98084e1f5b0..69a2a749e188 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -689,6 +689,7 @@ struct cfs_rq {
> >       u64                     sum_weight;
> >       u64                     zero_vruntime;
> >       unsigned int            sum_shift;
> > +     u32                     idle_seq;
> >
> >  #ifdef CONFIG_SCHED_CORE
> >       unsigned int            forceidle_seq;
>
> Yeah, well AFAICT other things seems OK.
>
> Also, while trying to get this patch series on my tip
> branch I had a hard time. I was at the caves
> of git and b4 figthing with... Everything.
> Like there were no v2 tags on some of the patches
> so b4 didn't tracked them. I had to do some
> things by hand and finally it worked. (Not too greatly tho.)
>
> But who cares? :>.
>
>
> Thanks,
> Kayra
