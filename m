Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D559463
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908756; cv=none; b=hT7UIdgAuPB3MNeR/1NAeDcwq9R5BkGKg9FGIMKnJoDfjFuZMUfjNl/W4efMZNmNFyqAB3sNLnE27mEusLOLijvRD/IL3Bu+dMwwkCNx0/KRn5zfbShqoRhCruD6B3A8+mmoiDsW3kG7Sm7ZuZuJ641voNGIeVm+oh1Ob16z2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908756; c=relaxed/simple;
	bh=orNmBWQYDQX2Iyd2Wfw+eIEURD2sZfnmHBS1cLn5HV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3ugCasj9z7BKI8a23Jk83IiBMCvNPr2iPOAMCJTh3+otVC1Jbf6WmNoKcuojx8ZYLj37cTyUvZtR67iflthYcPJYY3+Nx8xw8Wn3bCb12mhEE7hbBeRfa82Hq6zii+u01lvHMI4ViEUjCBLvi7oYQd1bzfpRXwtv2Fb6WDok30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bPqAk1Fy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPqAk1Fy"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c03eb31db80so3482915a12.2
        for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765908754; x=1766513554; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsGQBcQVSuN0hd4yFcJ6HCAqnhcHxfYgZdavfeipf0E=;
        b=bPqAk1Fy04dpE2bmgzGahNnl3Mx+3cOAyOXcsH+toJ0PFlsjUuetfnrKT7VqjeNRso
         1Jv1g7gLvazGN7o1i7DY15CbtD3xMvXMf9t3xtdooRnEBXUCBn25tCUKU9NrNQBvRIWu
         bYjZ+oeFmkj3gRBazp2ZpqqmmtiQAjXunVskZH2vEdAIrkkNUcmzjdjg4aC6KA0W74Gz
         jy1+/Fzk7RZdxnTHUT78njqQPEevbuPybAhptSlZ7BhWR3v4wb7cdWZryivh28pyGRDS
         VMufGFu1z/4XSPzCb9Om9RpV3xUN+7tuxzm06uEi2yT9KLJK7H654yCiEJrYW5dwc3eQ
         nZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765908754; x=1766513554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsGQBcQVSuN0hd4yFcJ6HCAqnhcHxfYgZdavfeipf0E=;
        b=T2xuu8k8kKdvqN4UN9zEA4Dl3JUqTQ4RuxeFJpdNqx7RpTi/Dg7UW861TEu/i49OiJ
         4JUmDfIjAFRZm5U/KHvDNlDz9VGEK/J+9c1jxpq16eERxO8/ppA6aBUZVbLN9SyTuRKf
         CCTOWDzVv89QKzeHykfEpbDhPkmEx1FKfjKglTdlOPPrxucV7E2rs3DRgemk0kyvJWR9
         ZFoxWUQcSDB49hkfbs5AM4CD5MBMmFsF/SVPFVKpEl3AW4lLtAOuFj1dmu3sbhmzLL/x
         z8nDABxfaSn46FB20TcPLiB+0pCyuXH0winp2EEWnDxxoFgz8AAVzHmSijL9ZBzmSpGH
         +r3g==
X-Gm-Message-State: AOJu0YzKNzawIWDiC+rP5MGkF3YHBDQKS8zAIr9Umliv2zhA8werDE+V
	Xp3TX9v/Yq4jiizBYd+2LcnX6TVigZ2c84wR83tULxTiIf5C1KtoRenQCOg/5ktUN72L5OsqDkD
	TjGioMOxqJgVNw9Hdhn8g03U7om6m1cVALra1evHfgA==
X-Gm-Gg: AY/fxX5p2tKKwX0xP9ZjZuuQeqafRzhvb/ms1Hwbh/ChHV9kMjJtL15nV9xCKG6siJ7
	Qf9la/1SC0RH5zk2f0WwNE0r878p86k+FSqhxOeA1UJ7Y3yxIY47Wm+9LgPqUWx6oGNkv4FLeXp
	y3WdtsA5333rSiIsbLRrdup1WMMVyJ+WkCGOXBkhfwXdvs6BiMUTXs0HRh5QbEHvxNsTy13M++K
	hWVSXvLTcN75Vp/uaeUC4wUb+T9DY8GdyiZaCLfyxBjQ+1StE6AFwQppDdqBVC8KKn4DFsldO+D
	n0ZsptoEFDEw2Vi3xmcn0SAT8BBQ55nRTeRwkiA=
X-Google-Smtp-Source: AGHT+IFztaoUBHe+m7C6rCvcXV0bwIfZbdALDzVf8ZZHufZSXNlImzsRsD6WWTT8J31ESi3J2dzBqBKAuhcoq/HIZvw=
X-Received: by 2002:a05:7301:df44:b0:2a4:7fb3:7a96 with SMTP id
 5a478bee46e88-2ac3014694emr9206619eec.36.1765908754363; Tue, 16 Dec 2025
 10:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+G9fYuUYboYg9Kq24NL+LY3XqCELWkwbGZ8bh9EjQdoj2k7yg@mail.gmail.com>
 <20251216141725.GW3707837@noisy.programming.kicks-ass.net>
In-Reply-To: <20251216141725.GW3707837@noisy.programming.kicks-ass.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Dec 2025 23:42:21 +0530
X-Gm-Features: AQt7F2pxgbjyljfpiTLIBLTdqS5DCUVRD8teIn6lnB2ad9R-faCegw5-CW2XQRo
Message-ID: <CA+G9fYt3x1C1u7_xe5zUXgOY-fr5O25tFTgffyrxG1avncRzbA@mail.gmail.com>
Subject: Re: Boot regression: next-20251215: arm64: WARNING:
 kernel/sched/core.c:10851 at sched_change_end
To: Peter Zijlstra <peterz@infradead.org>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Ingo Molnar <mingo@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 19:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 16, 2025 at 06:11:11PM +0530, Naresh Kamboju wrote:
> > [Re-sending with unwrapping]
> >
> > The following boot warning is noticed on qemu-arm64 booting the
> > Linux next-20251215 and next-20251216.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > First seen on next-20251215
> > Bad:  next-20251215 and next-20251216
> > Good: next-20251212
> >
> > Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end
> >
> > Are these expected warnings ? Anyone noticed ?
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Still a wrapped mess :/
>
> Anyway, afaik you're the first to notice.

<trim>

> This is:
>
>         WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
>                         !test_tsk_need_resched(p));
>
> And rt_mutex_setprio() doesn't set need_resched() on demotion; but
> worse, reading it now, I realize that if p != current, nobody ever will.
>
> I suppose something like so will cure things?

I have tested this patch and did not encounter any regressions.

Tested-by:  Linux Kernel Functional Testing <lkft@linaro.org>

>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7d0a862a8c75..5b17d8e3cb55 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10833,23 +10833,24 @@ void sched_change_end(struct sched_change_ctx *ctx)
>                 if (p->sched_class->switched_to)
>                         p->sched_class->switched_to(rq, p);
>
> -               /*
> -                * If this was a class promotion; let the old class know it
> -                * got preempted. Note that none of the switch*_from() methods
> -                * know the new class and none of the switch*_to() methods
> -                * know the old class.
> -                */
> -               if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
> -                       rq->next_class->wakeup_preempt(rq, p, 0);
> -                       rq->next_class = p->sched_class;
> +               if (ctx->running) {
> +                       /*
> +                        * If this was a class promotion; let the old class
> +                        * know it got preempted. Note that none of the
> +                        * switch*_from() methods know the new class and none
> +                        * of the switch*_to() methods know the old class.
> +                        */
> +                       if (sched_class_above(p->sched_class, ctx->class)) {
> +                               rq->next_class->wakeup_preempt(rq, p, 0);
> +                               rq->next_class = p->sched_class;
> +                       }
> +                       /*
> +                        * If this was a degradation in class; make sure to
> +                        * reschedule.
> +                        */
> +                       if (sched_class_above(ctx->class, p->sched_class))
> +                               resched_curr(rq);
>                 }
> -
> -               /*
> -                * If this was a degradation in class someone should have set
> -                * need_resched by now.
> -                */
> -               WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
> -                            !test_tsk_need_resched(p));
>         } else {
>                 p->sched_class->prio_changed(rq, p, ctx->prio);
>         }
>

 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/36wC2DzDokQEutv2FqXwjRjSv82

- Naresh
