Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6827F016
	for <sched-ext@lists.linux.dev>; Sat, 18 Oct 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818065; cv=none; b=gcJE7Tns7oroedWs6yuo5DOsuzjdmXQ/sUEEPJG2qFEwUd8uG7vob3sD3VZYqas1SnAOBW0AIi++CJnGBvN/xsdimNu6jmHzX/gfs20rtdj7wwjJsBTH0HZ+EpZGeagno3i6AGUx0ETa3j8OvXdEqeDIq/IDE66f1P+SxPG5iXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818065; c=relaxed/simple;
	bh=tpkmTrj9yvJP77GUvZDq7eaApIWSV6MeSWRkmJu8+5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0MsrfEq0Dh8Y1EuZxQo3wa4i9bsf2RFLGwBqQ4djnq5kVKYfKl5C4Y7f9sj8AGubbKgdwasCcxyIbBRPHjEVzCk6QFTtans/voJF19jw625wZrQTySK1hBi9pLRhxDU4rcQWE+JZraJMXFtZoZpOKbbWdIDOXgiyyUcew9QRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=xwROiYis; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="xwROiYis"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e330a1360so93682d50.3
        for <sched-ext@lists.linux.dev>; Sat, 18 Oct 2025 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1760818060; x=1761422860; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucpvAeUqe9rF0WcERnFwmxp6mxNyXUwA/gyiOAOR/Lg=;
        b=xwROiYisW0Z9uNA0hqqT6wSmT0/HQNZnuxqwjWwIIlN3aCH1A9tt6LLE72x0cDK237
         Q2W/27ZrpjnE0aBv8jwF8UVPm1ROjQhu10A6LmMVEMvWEcB8RZAe6yAHcJVWcgdku3zg
         HqvGaKXONv0kLJkin+xYBRlKkJ4kDtzw9X1qn29N0ReS10OvY8klYYeVyWrE0Y7pNCXy
         CT2Fgaze6klqV/UK7U5BYMI7pDdTiLuZfg0hZvdV1n/Ig37eJ2/pySAvRIiVNDoJX6l6
         s/7tiUi0dDTybsYknJwKTX4zNrNg54u5C9dex1EibvkjOjvc9tYZuJRnCmDXAXVjRE6I
         7HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760818060; x=1761422860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpvAeUqe9rF0WcERnFwmxp6mxNyXUwA/gyiOAOR/Lg=;
        b=pBUnTmNuJG26HsygrsIw2Jp2ULYjXEs8a5iYsneusz4Z5JWPLepT/jdD9A65kzNDPk
         rrurgkiHNUe95vwnVH4MSMxFqlCwDlKW4vYlQ+rAAio4op9SQh7OgC0JIoJrPDFLDveY
         /fY7CJUDtnTe/ZXtGEao8tn9lUdUMaIhh3mlqTbbUGCC3j1rW9r/3FJNoqQZJpm5YKiu
         wefWlcfBcRGf71sclvds5tg/RbFmRSE/7qx3ag81GmwJ4sQaor2Ets1n5SSmKIXIHRUF
         r6HekoxxBCV6F8pE44zAe5aRQ96IMN0MfDVVds0lrdzttMllaAT1GSRjRs1npU5+k+7T
         Ticw==
X-Forwarded-Encrypted: i=1; AJvYcCXzYYhSHvg5JSqVWXFQrr3BSMKuseOtmWqL/tNEGYZHrYiIX6zT14Rb34ic6ibMAUCFxW/r6uyRkMA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcXti2mu/o8dAGZEGS4tFtzAtRlD5pTuKD8/mcOGVvV1YB2BZi
	SFYkNgdAftAXkFVMMOxGJSeOWEpw+axqSyaOJmHD3lbjIGyZP996jZSbwEN+DkB3rP6ss5e5tO7
	Dpalg0xIOJDwtE7WOndSzDi6/Fz+fAZV8Mw2Rhtpwew==
X-Gm-Gg: ASbGncuGqxWVpICNh3x827NBUW6LxkmNGBxfcSxc6RmqQE9OtSpPuTAYv0LPbIvPzzC
	Vtu2lO/YBtFxxWZano1qr5k6IoQxb/XeP/KcwkGhClBBmCmcfJ2PdNNzH523+9fzeFESOhh2kZz
	QEocrH66OaqWwOVoj4BUYOHMdzGvkiAi9rCqktBNjuWTL+53OJFtLTWiE/uqT+eIaRBYMRguqwQ
	vaLplY0WaVN1yYw1QwwlSP4d3uSFcf48k3GwkJ8sWz6vFPf8nOuoeTej9Nt71A=
X-Google-Smtp-Source: AGHT+IGOl8H82Sx/wGP3Lk4LzvH69LpdZ72JdsN8VVV+1bEc2glqYTC2G/fZkSILyr+uLFJgb3nxX3nvD/2iHwRIYZk=
X-Received: by 2002:a05:690e:12c7:b0:633:a96a:fdd3 with SMTP id
 956f58d0204a3-63e1617af6fmr7232645d50.16.1760818060518; Sat, 18 Oct 2025
 13:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251018141014.212571-1-arighi@nvidia.com>
In-Reply-To: <20251018141014.212571-1-arighi@nvidia.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 18 Oct 2025 16:07:29 -0400
X-Gm-Features: AS18NWC4Bp-6A72bzOw_BYBQDAYmAgQUippkjZIGTYkjtfhqPFshTDYgUD4ccyg
Message-ID: <CABFh=a55MGEVxuBg9mtZob5GbacPk_2EjXLDdjKMJmVhF6d7Sw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Allow forcibly picking an
 scx task
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 10:10=E2=80=AFAM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Refactor pick_task_scx() adding a new argument to forcibly pick a
> SCHED_EXT task, ignoring any higher-priority sched class activity.
>
> This refactoring prepares the code for future scenarios, e.g., allowing
> the ext dl_server to force a SCHED_EXT task selection.
>
> No functional changes.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index adff739b396ce..35bc37c7ee199 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2351,7 +2351,8 @@ static struct task_struct *first_local_task(struct =
rq *rq)
>                                         struct task_struct, scx.dsq_list.=
node);
>  }
>
> -static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags =
*rf)
> +static struct task_struct *
> +do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
>         struct task_struct *prev =3D rq->curr;
>         bool keep_prev, kick_idle =3D false;
> @@ -2365,7 +2366,15 @@ static struct task_struct *pick_task_scx(struct rq=
 *rq, struct rq_flags *rf)
>
>         maybe_queue_balance_callback(rq);
>
> -       if (rq_modified_above(rq, &ext_sched_class))
> +       /*
> +        * If any higher-priority sched class enqueued a runnable task on
> +        * this rq during balance_one(), abort and return RETRY_TASK, so
> +        * that the scheduler loop can restart.
> +        *
> +        * If @force_scx is true, always try to pick a SCHED_EXT task,
> +        * regardless of any higher-priority sched classes activity.
> +        */
> +       if (!force_scx && rq_modified_above(rq, &ext_sched_class))
>                 return RETRY_TASK;
>
>         keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
> @@ -2408,6 +2417,11 @@ static struct task_struct *pick_task_scx(struct rq=
 *rq, struct rq_flags *rf)
>         return p;
>  }
>
> +static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags =
*rf)
> +{
> +       return do_pick_task_scx(rq, rf, false);
> +}
> +
>  #ifdef CONFIG_SCHED_CORE
>  /**
>   * scx_prio_less - Task ordering for core-sched
> --
> 2.51.1.dirty
>
>
