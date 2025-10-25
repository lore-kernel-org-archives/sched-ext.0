Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E132DAFA8
	for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434237; cv=none; b=Y0WA8MmUsi8Fn+WDVtbhYiU60hbdMimeg6KP+IqqlgKHtEO36z+lmjSHK5WcSkpZPB4ff20DUw0L0l6CT/b8bnnv9Z7WYNLr6qd5BXRUFdIYleBKeYieQqhTz53mk6Hz1XydJZMB0fa0qKagX8BQ8tTsBFsqAVHA6//zhuh8n5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434237; c=relaxed/simple;
	bh=pwPK/2SaTSzIG6JsYkEuwkznjmpXv6O29jp/nG6rXFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrLGiWnQEw79bEt6/HtdSsgEFLMdbW50Z+QAgFHZoOWhm4NMv8jbohZIID1nV+TRyntvllXi86WgSGZyALy5Ti56KAYEE29BFA3hlWuaYtcKoYJGJcCu9eut59DmUJS261aV1sM9kDTSBw94xrCba+U1v2CzhHhgGQiedM9GXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=exwUSzRl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="exwUSzRl"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-784a5f53e60so40633087b3.2
        for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434234; x=1762039034; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is1zpHnQGeBcCGpOoP92nGMnAqo9+w2bQCU7loHSWoo=;
        b=exwUSzRlnXUfHQGp97WBoOoKkg2xY/Vo66xjbhcDFCYz5aJ1PtUr/SSXw72GYr1aW5
         LcVmE2tGQK7K7nLPI3U2C85CUUsDDdUhNjSKV14pPNGuowBtpqSdkqHVy8vSEPCf2AFK
         f9H0tlYLFizE5mzpv99G3E+/Z3YIB86HzruuGCMky2sqJcvHiRScyPKVppClqKCHUHV1
         euO5bau6KlY+UVtXeZ6XOn4RPRUSty4O2rwTUEPaSpBCIesxZE6Yk1KQh4hR7RdxdJfn
         NI+NIS0dK3LvjkgdWQsaHTTDHaSvm2HlhwKefUOY7vRy71Z/4CLMPcdIhquE7GTqXV8+
         muXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434234; x=1762039034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is1zpHnQGeBcCGpOoP92nGMnAqo9+w2bQCU7loHSWoo=;
        b=XTWHKhRgPsFXSsdZ8O18yFVEfcYBJxpiVdILPvcbTDdZe14SqMzPPbMUcsFS/bFyQ1
         7AD46R1pchGG1qHTiphuAstxjTF5LEkWwaLCG+mbzev1GtwvVFP8n/cVYSfkhCoZ6rlH
         giHUUzLYCTGuwofqWaP0BmlnoPg31NbLsg2Roo8I734CGCL5sn1XAKTrZETt8LQTxXB6
         tWreo03S94PyzUvsKZ6lHzyt6kofK0b4Ni8cIKgx8x5L0PeU8wVAmTp0gdcGj3cHSPgI
         RJywElix7C6tJbm7onBvt/hOb9XK3JaQZeQ5bIFmV+4kGIn5EKqkVB5iGv2bn9FzFpro
         rl4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgZP8igKSRoUgQG8XAHBVS+E44UGY0jv+dDvU3mLLzECShYTN+dfeIpfC2RIdB3EyurHfFgEtOb2g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwSIOBZPtEiRE1ajFFGlniSVsMJdQVXHLQ2w5bBFq785IB5CTE
	cCEK3oVHf7jX7BFaKJB8dOV/MgRBxdM37lZaQdGYRi4Y44IFPEaS70hY1EUon+c5O8s69g7paFp
	JQddiaaGtErgVJ9NYyN1vjlAgoUp1Exe1R4GS6Xtjdg==
X-Gm-Gg: ASbGnct29XX/7YgBuQk7ZAZ/fR7fluMh4OjF1Bm890nyxw1N1SjBd3uqjJnet7NMZa3
	1xTZARbxX5dtSnt5BX289hHMu5Nhcc7MUoCbxskQ8pu5MupxF9IslUtgnnAkaXAbpefBUnuJ52a
	4uncOz+s6iIEWu21ZzJui6Y9XdQedmRwUBuE74bTBa4s+DI6i4wIXggKQ+QZ8hapQDBxbuz1yxq
	+B6eZNeuSxfdvKZLss85VZ9GDAUefQRQdagLfD+Jmg22qMdcC4/y0oVozPV178=
X-Google-Smtp-Source: AGHT+IFnZfRhn/WCV55iETc9hoxuumH+Oiddyh5cq60hBfpxfH6eutR6B09THJYqpfUb4g0f/WxZ1l7W+Yn/aqCPvT8=
X-Received: by 2002:a05:690e:1483:b0:63e:2959:9f66 with SMTP id
 956f58d0204a3-63e29599fd6mr20541585d50.62.1761434234033; Sat, 25 Oct 2025
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-2-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-2-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:17:03 -0400
X-Gm-Features: AWmQ_blZHqBCs6hg_fqxPsQWGrDJYGQQBCt1UgcV30-Y5DSrgamg-z2nSXz9sUI
Message-ID: <CABFh=a4gb7GcbMP-gB0tWXtsFtgYkpVz9NtBA1f-Ne5VWzSpmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched_ext: Split schedule_deferred() into locked and
 unlocked variants
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> schedule_deferred() currently requires the rq lock to be held so that it =
can
> use scheduler hooks for efficiency when available. However, there are cas=
es
> where deferred actions need to be scheduled from contexts that don't hold=
 the
> rq lock.
>
> Split into schedule_deferred() which can be called from any context and j=
ust
> queues irq_work, and schedule_deferred_locked() which requires the rq loc=
k and
> can optimize by using scheduler hooks when available. Update the existing=
 call
> site to use the _locked variant.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I assume we don't really care about ba

>  kernel/sched/ext.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 000000000000..111111111111 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -775,12 +775,28 @@ static void deferred_irq_workfn(struct irq_work *ir=
q_work)
>   * schedule_deferred - Schedule execution of deferred actions on an rq
>   * @rq: target rq
>   *
> - * Schedule execution of deferred actions on @rq. Must be called with @r=
q
> - * locked. Deferred actions are executed with @rq locked but unpinned, a=
nd thus
> - * can unlock @rq to e.g. migrate tasks to other rqs.
> + * Schedule execution of deferred actions on @rq. Deferred actions are e=
xecuted
> + * with @rq locked but unpinned, and thus can unlock @rq to e.g. migrate=
 tasks
> + * to other rqs.
>   */
>  static void schedule_deferred(struct rq *rq)
>  {
> +       /*
> +        * Queue an irq work. They are executed on IRQ re-enable which ma=
y take
> +        * a bit longer than the scheduler hook in schedule_deferred_lock=
ed().
> +        */
> +       irq_work_queue(&rq->scx.deferred_irq_work);
> +}
> +
> +/**
> + * schedule_deferred_locked - Schedule execution of deferred actions on =
an rq
> + * @rq: target rq
> + *
> + * Schedule execution of deferred actions on @rq. Equivalent to
> + * schedule_deferred() but requires @rq to be locked and can be more eff=
icient.
> + */
> +static void schedule_deferred_locked(struct rq *rq)
> +{
>         lockdep_assert_rq_held(rq);
>
>         /*
> @@ -812,12 +828,11 @@ static void schedule_deferred(struct rq *rq)
>         }
>
>         /*
> -        * No scheduler hooks available. Queue an irq work. They are exec=
uted on
> -        * IRQ re-enable which may take a bit longer than the scheduler h=
ooks.
> -        * The above WAKEUP and BALANCE paths should cover most of the ca=
ses and
> -        * the time to IRQ re-enable shouldn't be long.
> +        * No scheduler hooks available. Use the generic irq_work path. T=
he
> +        * above WAKEUP and BALANCE paths should cover most of the cases =
and the
> +        * time to IRQ re-enable shouldn't be long.
>          */
> -       irq_work_queue(&rq->scx.deferred_irq_work);
> +       schedule_deferred(rq);
>  }
>
>  /**
> @@ -1211,7 +1226,7 @@ static void direct_dispatch(struct scx_sched *sch, =
struct task_struct *p,
>                 WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.n=
ode));
>                 list_add_tail(&p->scx.dsq_list.node,
>                               &rq->scx.ddsp_deferred_locals);
> -               schedule_deferred(rq);
> +               schedule_deferred_locked(rq);
>                 return;
>         }
>
> --
> 2.47.1
>
