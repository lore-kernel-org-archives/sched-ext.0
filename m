Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C2268C40
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819023; cv=none; b=jdZtF8rx7Wof2xwKEXdxB4udIbXEFjiGTOuCYL6PXZDvYrIXDXK0gGy8QZvaxKvcCIuQpUwr40sRywjy7YWjX3q6X3iPq855o3MLWqbDcE4oWrGIIws74utjerC26gcCFGUFOanj0N3zlgA721TGm+D2/iz8KRGFLX1oJapMTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819023; c=relaxed/simple;
	bh=tgfiS9cTra3MjR8Qx3EjT2AU898OkeuQf4TpjzJhbkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjLu0CpphD8vynKm0RclOC4ZkLw25ifIuakZi9qFxw8NL3NH6AuPo2qSBREBVAHppYdCklsyv4lzFNCp28Zq+rUTRQbp8SLX2EblbxOdpMjFGvgAtYM6s3gWBmRTD1Zg1x2SawIiRculiWTOGsAsGlaTmejepuw5jT0nRyDOiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=KFDV7uns; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="KFDV7uns"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f9beb2730so2992846d50.0
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762819019; x=1763423819; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nj1q0mNcasYTnvKP6x35pxta4p3k2au3FFGEe/4tvQ=;
        b=KFDV7uns3RVnVmYB9kjvz67fTKYUHqT8AoVRoDRqdaYaSXgBx45icoVyAWeUlXkRZg
         kVqLt4ybIVlo+EtgoeXgcoF3NcZcaJYSojyudIcUeAXL9PbM5jbXiPTVebHZN0tt9M9F
         tl1tlhA2X/v2lq/+exQITexVOn6gX2afTzrP2LNmgMsFe8CQPEC9uFUrViGAdpUxipo+
         Al6CUnC0LFJhEqjwMsjt51usMH/glMT73tpCdiZM9JHQySrDHwIzlAkXCDIL7fT/L4PS
         l9PQaEF4pKbo2Ql6nWqwNZsdhou1Aa9E7CE0MkotsTnF+RynS7Fzepxk7d2JyUc9TmQW
         7syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819019; x=1763423819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Nj1q0mNcasYTnvKP6x35pxta4p3k2au3FFGEe/4tvQ=;
        b=r0jCQrt7ACBOvQiM6GS4ACR3wdF0od/3zcJSwkh6ssVOVJ73xjy7fpMn3xZj+5oJ4u
         r4hfvH+OVkIp8w7Ry9LIyDmUwRPZ9CB+bxkHCn/FDky8SWKMHOZHKg30S+Goy7ftj8dU
         sS7JnHrSkYt1yu44phl28Tdn9Jq1sveQFhBqGaAzQUSQ8bm54572z1VsmTlB16a3igt+
         m881g43QPxpuYXZigUDrR3EIejGnLwwuH6Rn4THpXqSEjsUDZcfe/CcLtRZy8CkCS115
         rhOMTrpI2ijlGyzsoXYkhYPPa7rFPR3RmjJBXIydN/6CXnsFRS9dKIQ+z3PiqMxJLCD1
         sKpg==
X-Forwarded-Encrypted: i=1; AJvYcCU6myYnN8FD4TOCq/UXbih7sP7ddXYPWGu3kRIXOB8LV4nr6GB6w6DqFgxuIEox9t+2vs/ZQ3j+D+0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwpPrsnbJPYGwWwLoB7tyVAvXXxsr+Fms3SNivbTI9dvgDIOWnh
	PEvczoOv86llZ9iECdJSZ21PATUBJkue+FJSuhf6UTHD8gYjmA0PbG0fxYFvhNDnvJ0Di8R99AH
	PljbOpSVPqlhbAE9N2HMDLt25qfT6b4RK8G7SRspPXFbUFEcb92r9
X-Gm-Gg: ASbGnctVbbbH6ZxOzQWsMum47LQmydEX593XKjOsaAWiIeXhG2HvcWiRCYTlODdDo6P
	Gz49AxK75bNE0JCb8FZ+wKTmR4bKRBSdpqU55mbCf+FwrHwjNcRBIg0YXgATUlEmMMvHHGv2Phe
	lvlIdIMNEK18i8xE3HCP50/MZJSODN8AyjKK33BZHPcma+aGT+MXd4qQfwcaKkUl7Tyr/bn6YVw
	/e1Do1gDsvDNxVuMcah1+8ZY3996B1WTgCmyx3d3BLRATo0Ti3MKkOKwRtWvkI=
X-Google-Smtp-Source: AGHT+IEYS9SgK5WzsgyfFw2SD3xybWKtZXTp6PZoYwrkPfKwTSmMkqLzXwB/JbmTscVTXPcbHxNw0AfHx1HwzeaUldc=
X-Received: by 2002:a05:690c:4681:b0:786:4ed4:24ff with SMTP id
 00721157ae682-787d5350164mr91957387b3.1.1762819018909; Mon, 10 Nov 2025
 15:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-13-tj@kernel.org>
In-Reply-To: <20251110205636.405592-13-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 18:56:48 -0500
X-Gm-Features: AWmQ_bnZeNnUS9oP_2Fx4DPImpvH26pzs7x9mbIoeSRMS41rpiNw8pWfz58gD0Y
Message-ID: <CABFh=a7x4rXergkASTr2T8c20Yu1E0+_5ZaPijLhzGEkM_Pmrw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] sched_ext: Factor out scx_dsq_list_node cursor
 initialization into INIT_DSQ_LIST_CURSOR
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CUR=
SOR
> macro in preparation for additional users.
>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Acked-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h | 7 +++++++
>  kernel/sched/ext.c        | 5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 4b501ad7a3fc..3f6bf2875431 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -149,6 +149,13 @@ struct scx_dsq_list_node {
>         u32                     priv;           /* can be used by iter cu=
rsor */
>  };
>
> +#define INIT_DSQ_LIST_CURSOR(__node, __flags, __priv)                   =
       \
> +       (struct scx_dsq_list_node) {                                     =
       \
> +               .node =3D LIST_HEAD_INIT((__node).node),                 =
         \
> +               .flags =3D SCX_DSQ_LNODE_ITER_CURSOR | (__flags),        =
         \
> +               .priv =3D (__priv),                                      =
         \
> +       }
> +
>  /*
>   * The following is embedded in task_struct and contains all fields nece=
ssary
>   * for a task to be scheduled by SCX.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d16525abf9e0..82f0d2202b99 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6249,9 +6249,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_ite=
r_scx_dsq *it, u64 dsq_id,
>         if (!kit->dsq)
>                 return -ENOENT;
>
> -       INIT_LIST_HEAD(&kit->cursor.node);
> -       kit->cursor.flags =3D SCX_DSQ_LNODE_ITER_CURSOR | flags;
> -       kit->cursor.priv =3D READ_ONCE(kit->dsq->seq);
> +       kit->cursor =3D INIT_DSQ_LIST_CURSOR(kit->cursor, flags,
> +                                          READ_ONCE(kit->dsq->seq));
>
>         return 0;
>  }
> --
> 2.51.2
>
>
