Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1E199E89
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811017; cv=none; b=bEWMKslzwFHbjKGJwaWlB7jVyEdSvvM7axnM4+mCS1dFh+fpHfGG7AfJc2yxjt/pMvDC6mVUAfX3PSKSOxaXablUHVr1xxI6xr3A1NWjKI3vANIQMNvShhcgaXeyWVZJ5wVwZw/JuDOXUWf6kmwzVp0i2WzVVIXZjkeU45faORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811017; c=relaxed/simple;
	bh=ly0mOtDUxX4tWKt/IjWg13ihHqNVJ1ciiWMf2fJAHVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hip4LXGm/Q9Zzlk2sKHffSrOUOIzNQv57RgdK6VflZbznpSQfEdmfGyJk0S+D9fxNYadYi/ZvflQdSjLrf1/Y6X2JrJXUeSo0Nf+gMqBal+u+WplZ0l8keOcO41upL8ueKI8wq6yu9j+WDHcCOIAkESUsM1ssSUDujJqbCR7XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tyuhK6CX; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tyuhK6CX"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640f2c9cc72so691710d50.3
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 13:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762811014; x=1763415814; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R91J38Rt95DFLbNanTrQ2Sogh6MvPxM64piJrtd8qMs=;
        b=tyuhK6CX+9Nqf+3Ck+eTHWhANHOWfJ2+0cH/md780Z6L3FAnOEI/gDEduR+f7DZdVu
         cqq0c8/7f4KOOLdu7O+ze+jvbMn3/uNcXSonOzwfZ9P1i87DjBJSQ9qDu4FMz+El0xjS
         nM4AbsqySJ2DX4mLb5H75RH04buuokmz6jBGBY/7h5XVO2aw/F4Jn6qKrAIJM1+Cluz2
         dhkQ40r/AIoyuP/pfXrURxS9dv/ao3rfWumkRYSbcIFG8J2sxc5gypYUquIngQUhdpky
         wJAQ8MQFaPIJbduDSu2JYAU7Y4ESit2OLbUE65sC58xlUR/HcuXdRvw8oaeiHUnES7IN
         6pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811014; x=1763415814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R91J38Rt95DFLbNanTrQ2Sogh6MvPxM64piJrtd8qMs=;
        b=PgQSZfNvWI7b6qKdsX2nTUorvuD4JwFXEaUgFL1P3iQvZTr+/VuuTgefA38dvOHhlK
         qoT+efyrnEyqXdYhD14U4y4Py09PGum1bMPI3bAw2wC+e9yjDSDGUlvHQJyFEKixAqy5
         Nm+bHlmUv998+anvj4HIIG5+uAZhI53+HM2RwOsvVOebUiNSdqjCmC443rpwSidrZXIh
         QM88uAlJidb6QnVHZatmZ7xQNVF+CT//+HoSuwczXajQI/mhMXIqqt1RYLJt7MZf26+W
         vx+MPhIRvXVZPXaBEAis1rzn2RDrXRyHQXkDSWASnhwg+y+V6C9h2+1VZfspdgVaipfW
         sKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXluMAX4CFpAbb06kiaEEBoRBJpmLoWh9UCzskk+Js5KDkPn8FeEv7j42u1Ywp0PjjHOtUgKDqPrMo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZaDEAjeSpD5djFKTmx5yiwbngxkjgBxtwVYzVEWgVmIlMkD7d
	uwaPFy6c9xtnM7x+PolWi5WZnV4qRp2yNry4AoTuLsSADq6c7/c44MzjxZIl9H+REhCDe+cWhxV
	/ZGyDkFxxO2izyR0EhV0kTVW2Pq+W3dILEI3m7JwvBA==
X-Gm-Gg: ASbGnctcUwSJmI0oo5vmM24k8icEaav/1EOqMCVlDHehrqDW7/6ATItpN2LkEGwFNVa
	xxpuq2QyyfM4PX1zZJ680b6YbM+DKdc0dD+RGfdBBycqN2GbKquPF205v/vVetWK7sFjovkMRKq
	t2s/R7BiyNLIxYobc0GK2m28PDLXQYASYjQQqQ3goQmkvoTSb/6uPLNZGSLfuFSOZIhjQojch4y
	UqnsqzJubOpuhoUT4W41YI9C5yl+ygy4ZvXxb+lOFtMAgyOIA1DBKBvPvSCW4pO8eNpgrtv8g==
X-Google-Smtp-Source: AGHT+IFm7fT23uFvjsyYyTFiMGYENtJY5fIpQe9drynzp+/2LbShu0VQNgJLN7iovx2xtPyFQG/WqLQIy+6ziKMWBtw=
X-Received: by 2002:a05:690c:6ac9:b0:787:ca87:595c with SMTP id
 00721157ae682-787d53527cemr163023057b3.9.1762811014498; Mon, 10 Nov 2025
 13:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-5-tj@kernel.org>
In-Reply-To: <20251110205636.405592-5-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:43:23 -0500
X-Gm-Features: AWmQ_blnzkBg837GPO32wah8Id-a_1xg9pBvasKGI39IKeqxzCA1Y_g3Kae1WzY
Message-ID: <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Bypass mode routes tasks through fallback dispatch queues. Originally a s=
ingle
> global DSQ, b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"=
)
> changed this to per-node DSQs to resolve NUMA-related livelocks.
>
> Dan Schatzberg found per-node DSQs can still livelock when many threads a=
re
> pinned to different small CPU subsets: each CPU must scan many incompatib=
le
> tasks to find runnable ones, causing severe contention with high CPU coun=
ts.
>
> Switch to per-CPU bypass DSQs. Each task queues on its current CPU. Defau=
lt
> idle CPU selection and direct dispatch handle most cases well.
>
> This introduces a failure mode when tasks concentrate on one CPU in
> over-saturated systems. If the BPF scheduler severely skews placement bef=
ore
> triggering bypass, that CPU's queue may be too long to drain, causing RCU
> stalls. A load balancer in a future patch will address this. The bypass D=
SQ is
> separate from local DSQ to enable load balancing: local DSQs use rq locks=
,
> preventing efficient scanning and transfer across CPUs, especially proble=
matic
> when systems are already contended.
>
> v2: Clarified why bypass DSQ is separate from local DSQ (Andrea Righi).
>
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 16 +++++++++++++---
>  kernel/sched/sched.h      |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 60285c3d07cf..3d3216ff9188 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
>         SCX_DSQ_INVALID         =3D SCX_DSQ_FLAG_BUILTIN | 0,
>         SCX_DSQ_GLOBAL          =3D SCX_DSQ_FLAG_BUILTIN | 1,
>         SCX_DSQ_LOCAL           =3D SCX_DSQ_FLAG_BUILTIN | 2,
> +       SCX_DSQ_BYPASS          =3D SCX_DSQ_FLAG_BUILTIN | 3,
>         SCX_DSQ_LOCAL_ON        =3D SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_L=
OCAL_ON,
>         SCX_DSQ_LOCAL_CPU_MASK  =3D 0xffffffffLLU,
>  };
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b18864655d3a..4e128b139e7c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>
>         if (scx_rq_bypassing(rq)) {
>                 __scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);

Nit: The bypass label has a single statement, and there is no fallthrough t=
o it.
Can we just add the logic here:

dsq =3D &task_rq(p)->scx.bypass_dsq;
goto enqueue;

and remove the new label?

> -               goto global;
> +               goto bypass;
>         }
>
>         if (p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID)
> @@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  global:
>         dsq =3D find_global_dsq(sch, p);
>         goto enqueue;
> +bypass:
> +       dsq =3D &task_rq(p)->scx.bypass_dsq;

Nit: If we keep the bypass label, we can remove the goto since the
label is right below. Otherwise, we could remove it

> +       goto enqueue;
>
>  enqueue:
>         /*
> @@ -2154,8 +2157,14 @@ static int balance_one(struct rq *rq, struct task_=
struct *prev)
>         if (consume_global_dsq(sch, rq))
>                 goto has_tasks;
>
> -       if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
> -           scx_rq_bypassing(rq) || !scx_rq_online(rq))
> +       if (scx_rq_bypassing(rq)) {
> +               if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
> +                       goto has_tasks;
> +               else
> +                       goto no_tasks;
> +       }
> +
> +       if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>                 goto no_tasks;
>
>         dspc->rq =3D rq;
> @@ -5367,6 +5376,7 @@ void __init init_sched_ext_class(void)
>                 int  n =3D cpu_to_node(cpu);
>
>                 init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
> +               init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
>                 INIT_LIST_HEAD(&rq->scx.runnable_list);
>                 INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 27aae2a298f8..5991133a4849 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,6 +808,7 @@ struct scx_rq {
>         struct balance_callback deferred_bal_cb;
>         struct irq_work         deferred_irq_work;
>         struct irq_work         kick_cpus_irq_work;
> +       struct scx_dispatch_q   bypass_dsq;
>  };
>  #endif /* CONFIG_SCHED_CLASS_EXT */
>
> --
> 2.51.2
>
>
