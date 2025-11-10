Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54227330B1F
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811793; cv=none; b=b/aB5HywrJTpd9YThmR3EuWPVHjRosrWyM95JSYSt1bc9tgLuv4LpLXPiRChATsQcPZovP5n1ByihwZ+1tGME7lxtj7sBo1VLTnw9RJ+MA0TR7gJetpej4W/UcSHWfzyIjI3zojtazek/1aOC+RXLgVntnEvHHiyzsh2JD0b+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811793; c=relaxed/simple;
	bh=YdQkEd7BN6+h/jC85fJP17qHcLGxJekDZ7ZotjlxRiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbwY/+ehGXmX4vUEgYbV+M+1r1qWgQdp2Q3e7Jq7lK5qDXKWeX2Fb8JAee8DbEYPlL94cTw4bq4yWXgRWcPO/x2UeZM8AsvXu/zdFeGQw2DBB5teu0US6uTsjVx2OxEt/ELyQYmvoKhLJCy+KvpBAFvRDhsQ/cLhQAw20i76vlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=LwSPXzW4; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="LwSPXzW4"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640d0895d7cso348827d50.1
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762811790; x=1763416590; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBGv/ezsu5Nu8Kia5+lyxOyM9iwDFkTudN57nfIGJNs=;
        b=LwSPXzW4wDhAEvP5e10OZL2+jRL1AWLkDAPhU9Z7+A5iPVU28Pf7UUh10Wje7idZxX
         ZHvKV5fSKzbS9h9tFTM48bqLA+BqbgX/sEN6S5pla4zB5YXIcRYEZB3Fs5Ty1aYfPl94
         VIXv9BbE0X2EQwE1U70IhfGdkICMgZHBQi+Y2OBFea2tMxYUis95oW3G+Z7W57LrMb4n
         Ij/lOvqRmcCW3FkFIOsURhQXpcKJItFbPRBipTWDHvHzzKtR+EmH0K5m8QIj1WanP40l
         AhHrJP5VDRY2QQZPLXLKqtGClgrOHJiCTJp2GqatkucbngD2CRvX91NUvBr/mVyg3kB/
         tp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811790; x=1763416590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBGv/ezsu5Nu8Kia5+lyxOyM9iwDFkTudN57nfIGJNs=;
        b=duHzMV+H0fEcv6XfIOMqm2/XO5GHViVC9Svvo2IpdRpj9fO0JM1y6GKoxgLzT/4Hqj
         WrhdD74skhQsXljvdTwfEGQPWi4K2+0t7ya8dIkaz8ErzBlQxfQXK0yz3OZMx4zkJGBh
         r/lHA6NC9auecQSThCB8g9blOzv9+N4KzU0iwE9ALx9R/EOg8GUECbXWK48WMoT6hph+
         GoBWms1eonllkrpKRebnu9J7HHaQXZgE909SiWxsgBybFtsa5Nwuk59dIy7cmtrULrJy
         YV/WL9mDTtXh9EIHgPVPWulDm4moncepIWB18ALRJlpojzTTkpEORU7UTWaTdXCZ/rVF
         Yr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK3nqF9y1bdpyluH1mgIAAwHB9uqBGiEPlNhr7f8ENN5U7yd2dBUQcgQxrUmeTq8ZM0Dj0ryjhSmQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx252xJhw2RWAQN8bINMdyu612qqNTNLPH3elOI/qSXIEZ4YDHO
	R2gTVN8yhdEZliI/9zYSkiCl6Dnq/osJi/uHehdpJdYXhq4Sa0plx8/D/Nh1b6DBJ2thlaRgiLd
	B/g61XUt+BKGjsfmBDK7nQ+XvPU5YPCr/Jz+JzicOvg==
X-Gm-Gg: ASbGncuPK+R/+Ds8JFTRLC+JhPi0TpqxcYwjHGcn49s15JDCJ9JYh6G9MabefJy2cVb
	oqEe8z1anoH6IaMgGMTNOSpZ3tvAdkWh2VfiFw7cr8kcQyUrMEiAjZUXG/3PS1W7FLjgZMANaMh
	qsCEU0EG0rXxIjcG8dmJftiGjim10TZDcp1uF/mxv7HTyI5yZiDz0w4gq4+DPBm8iTO8C1D6uOP
	seWHJuZ4uPYmpcn/ksbcJ97AXLXqmc/mHyZafqOBhu90ZH8qha3fXNzjjH0QKE=
X-Google-Smtp-Source: AGHT+IHCr6GIvLHDQyg/etbAgX3Qx1oJCVQraKrWlGLG42IF0yIv0gzfVCym/QH5ldNJLYjcKXYRDL8/olyRiOOPhr8=
X-Received: by 2002:a05:690e:140d:b0:63f:bb1b:b63a with SMTP id
 956f58d0204a3-640f735ece7mr855546d50.11.1762811790007; Mon, 10 Nov 2025
 13:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-3-tj@kernel.org>
In-Reply-To: <20251110205636.405592-3-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:56:19 -0500
X-Gm-Features: AWmQ_blHcJtCFoKEPJw7CGCr7uwdPwo4N7tnDQSFaLHmTAvc-H5jhOXiPJsQi0I
Message-ID: <CABFh=a4FndcB1-Fimh68uQqXtHCXkGt4vgLb1SmCVW7D7nU-aQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> There have been reported cases of bypass mode not making forward progress=
 fast
> enough. The 20ms default slice is unnecessarily long for bypass mode wher=
e the
> primary goal is ensuring all tasks can make forward progress.
>
> Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automaticall=
y
> switch to it when entering bypass mode. Also make the bypass slice value
> tunable through the slice_bypass_us module parameter (adjustable between =
100us
> and 100ms) to make it easier to test whether slice durations are a factor=
 in
> problem cases.
>
> v2: Removed slice_dfl_us module parameter. Fixed typos (Andrea).
>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h | 11 +++++++++++
>  kernel/sched/ext.c        | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index eb776b094d36..60285c3d07cf 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -17,7 +17,18 @@
>  enum scx_public_consts {
>         SCX_OPS_NAME_LEN        =3D 128,
>
> +       /*
> +        * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler=
 misses
> +        * to set the slice for a task that is selected for execution.
> +        * %SCX_EV_REFILL_SLICE_DFL counts the number of times the defaul=
t slice
> +        * refill has been triggered.
> +        *
> +        * %SCX_SLICE_BYPASS is used as the slice for all tasks in the by=
pass
> +        * mode. As making forward progress for all tasks is the main goa=
l of
> +        * the bypass mode, a shorter slice is used.
> +        */
>         SCX_SLICE_DFL           =3D 20 * 1000000, /* 20ms */
> +       SCX_SLICE_BYPASS        =3D  5 * 1000000, /*  5ms */
>         SCX_SLICE_INF           =3D U64_MAX,      /* infinite, implies no=
hz */
>  };
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cf8d86a2585c..abf2075f174f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -143,6 +143,32 @@ static struct scx_dump_data scx_dump_data =3D {
>  /* /sys/kernel/sched_ext interface */
>  static struct kset *scx_kset;
>
> +/*
> + * Parameters that can be adjusted through /sys/module/sched_ext/paramet=
ers.
> + * There usually is no reason to modify these as normal scheduler operat=
ion
> + * shouldn't be affected by them. The knobs are primarily for debugging.
> + */
> +static u64 scx_slice_dfl =3D SCX_SLICE_DFL;
> +static unsigned int scx_slice_bypass_us =3D SCX_SLICE_BYPASS / NSEC_PER_=
USEC;
> +
> +static int set_slice_us(const char *val, const struct kernel_param *kp)
> +{
> +       return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
> +}
> +
> +static const struct kernel_param_ops slice_us_param_ops =3D {
> +       .set =3D set_slice_us,
> +       .get =3D param_get_uint,
> +};
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX    "sched_ext."
> +
> +module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_=
us, 0600);
> +MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied=
 on [un]load (100us to 100ms)");
> +
> +#undef MODULE_PARAM_PREFIX
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
>
> @@ -919,7 +945,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s3=
2 delta)
>
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_str=
uct *p)
>  {
> -       p->scx.slice =3D SCX_SLICE_DFL;
> +       p->scx.slice =3D scx_slice_dfl;
>         __scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>
> @@ -2892,7 +2918,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
>         INIT_LIST_HEAD(&scx->runnable_node);
>         scx->runnable_at =3D jiffies;
>         scx->ddsp_dsq_id =3D SCX_DSQ_INVALID;
> -       scx->slice =3D SCX_SLICE_DFL;
> +       scx->slice =3D scx_slice_dfl;
>  }
>
>  void scx_pre_fork(struct task_struct *p)
> @@ -3770,6 +3796,7 @@ static void scx_bypass(bool bypass)
>                 WARN_ON_ONCE(scx_bypass_depth <=3D 0);
>                 if (scx_bypass_depth !=3D 1)
>                         goto unlock;
> +               scx_slice_dfl =3D scx_slice_bypass_us * NSEC_PER_USEC;
>                 bypass_timestamp =3D ktime_get_ns();
>                 if (sch)
>                         scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3778,6 +3805,7 @@ static void scx_bypass(bool bypass)
>                 WARN_ON_ONCE(scx_bypass_depth < 0);
>                 if (scx_bypass_depth !=3D 0)
>                         goto unlock;
> +               scx_slice_dfl =3D SCX_SLICE_DFL;
>                 if (sch)
>                         scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>                                       ktime_get_ns() - bypass_timestamp);
> @@ -4776,7 +4804,7 @@ static int scx_enable(struct sched_ext_ops *ops, st=
ruct bpf_link *link)
>                         queue_flags |=3D DEQUEUE_CLASS;
>
>                 scoped_guard (sched_change, p, queue_flags) {
> -                       p->scx.slice =3D SCX_SLICE_DFL;
> +                       p->scx.slice =3D scx_slice_dfl;
>                         p->sched_class =3D new_class;
>                 }
>         }
> --
> 2.51.2
>
>
