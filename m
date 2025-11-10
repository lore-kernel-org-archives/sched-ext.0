Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84962EDD57
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812397; cv=none; b=l4wbfE86ruCQodHLHOrT8XMH+r6njRGJ/X4meljZrdp93ss/yrV+rFuojzES2QzvL3fmP2oh/54Gqt63+xty/2i8AnTq8Fbdm31dqN4APnnqr9PwmKvfS2biFFqRs8SVKoclPpuGPiDIDPYwScYcoZoZXPaZqUkwkdBiaUg2GBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812397; c=relaxed/simple;
	bh=rYhUBnvwT+ub027fXUx5R6wsKiOlOm+VBlO4fl6AhFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLmjrhdQab9w1Nlqc8gV4LEUqGxw2A40I6gGcVCKEWE9RhCpL4SR3fCOlprEg/MHRZbnQnAPMPukalx7tj9LAv/BjwjJCkI8ttxBT2nL09VmNXsWVRaA8NZhmbnUs1mOD5o6M+TLvegE+EUdJUhN+zKC1EKrhTq+mWrCdlOEqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Sl8YrhWV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Sl8YrhWV"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781014f4e12so33858847b3.1
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762812395; x=1763417195; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4f9Zy+Xxr8e4Nr+RON0+4DZk9ZxxU3ItskZZmBVohc=;
        b=Sl8YrhWVGvsqABWpbe9srFoEFSoct/hnLiWYnTfeqm3nDbwmelx4UKwRv+MnSLAZ0n
         o1dMamW45zOPiaS36gEiemTjuJdclUdcUOeJaQoMnk+dVY0IBNcnC/hFV72LweukZd7Q
         MeipYwaS0qjeEsWJ7eW7Dn1KQ9AcWxoO5m43t9WeJ+a9ymBqY0ixfgtNw92V7bsAyIrG
         aENUirCi53/odUCs7EDnGUlWxSVXNGYHZui6iyTdKR6xrdHD7OrP3uxhZ4QN05Nk4ORF
         4e5qGQVtzbgBVCCo1PFQ9E2w51eoHjm5F+Q6IiyjLO1794nF2d4W0hFZap4Bqsih82br
         KoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812395; x=1763417195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4f9Zy+Xxr8e4Nr+RON0+4DZk9ZxxU3ItskZZmBVohc=;
        b=RYfxzKysaBjjCbACl/sIifqnXlkEZPKJdnJPhyAoJnA2xtWRHOzSe5lLfMFkfs26rz
         QKVG5nOYz+tWdPMJoWhEJJJYqM/dnod8w+fZcOXPwEHqaZsXPW8k+BawQaMgO9LAu+dL
         bqbk9UV2gU7RurL5nA595hE0mAUqAhuXUBGOX0tUb5eFuGjJmFvC5WUULZ9Zb7VMCRgV
         xZH6Amb0HWeGY0myoayjCnof3Wi5wJOF2OCz/ubdXmrgnAzWeHD4J3G6qUQMrAxxQs/j
         XAbGTIqPAJ9LG6g7rtZ4MVY6zV28Wcbo9bzOcl51b5Km/LL/rzTlizfYC6aZhB8tOQYv
         ZaWw==
X-Forwarded-Encrypted: i=1; AJvYcCVfuLr69x7seUlbBrKQPDleoz23YcL3R4Hi8xUY7rFQtOu0EJEyk6jy1iQPjp+TkOJuQrxHUdLGJQ0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ4pNtBfiOljOnSvLlU9P6yoY9KUooocg5aOuKkcvt7iXxKUPn
	qdHh84Yi731rD/TZA5Hw+UL5JIfJw6YHoyVYEbdmGXYdwhvZAqT+RtkcnmWPhtRb3Hv0p3gfoJp
	HekCxvFgnd/i3SFeEGmalZjfonl7QQUsEa4rZ7acwaw==
X-Gm-Gg: ASbGnctbXujnLiy5nrjoY8s/E5JfgiEBLzfLfr+gyZvWbydVJWa4w+elDJRDclwe/J9
	DfUS/uB7Nm/vgfyTSdEnEpipDUK3LlP3AduM/or449U0cdgRtY7rWDwuE7CTkuqSSydI3hV09QU
	7pjVK0pLbBPcPguh3Famh6iYiOrAUf8HsNO0cnLNkTXpVixaO6CGDrtADQtJDz/x5v4Egp3gz5S
	0SmqRqOqb0yrrn0s+H8nC7sGGi63hCUSWNjwJigxpLyP8jr6Z7cBpMkzcdpUrLomyTH0zpt/g==
X-Google-Smtp-Source: AGHT+IEqKxEQusQc/mEf1PmchCpojHyKOU/NUBIfL+zGYTHhwKG7RuZt2UrTDFinoTIQeRfak7YI8kK8uxQLm3HA6bg=
X-Received: by 2002:a05:690c:dc1:b0:786:4f0d:46be with SMTP id
 00721157ae682-787d534d0c5mr106568497b3.3.1762812394823; Mon, 10 Nov 2025
 14:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-4-tj@kernel.org>
In-Reply-To: <20251110205636.405592-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 17:06:24 -0500
X-Gm-Features: AWmQ_bmy4aLQoNCiZ7KPQEb20_Z93-ZWMhtAodbv3pzouiv5G_qhwQFn1xmSKp4
Message-ID: <CABFh=a5e0jAfLV7m8VBsDwUEOziMpeHDvyAf-9oTPYqsk3N6_g@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] sched_ext: Refactor do_enqueue_task() local and
 global DSQ paths
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The local and global DSQ enqueue paths in do_enqueue_task() share the sam=
e
> slice refill logic. Factor out the common code into a shared enqueue labe=
l.
> This makes adding new enqueue cases easier. No functional changes.
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index abf2075f174f..b18864655d3a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1279,6 +1279,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  {
>         struct scx_sched *sch =3D scx_root;
>         struct task_struct **ddsp_taskp;
> +       struct scx_dispatch_q *dsq;
>         unsigned long qseq;
>
>         WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
> @@ -1346,8 +1347,17 @@ static void do_enqueue_task(struct rq *rq, struct =
task_struct *p, u64 enq_flags,
>  direct:
>         direct_dispatch(sch, p, enq_flags);
>         return;
> -

Nit: Similar to the note for the next patch, we could inline the
dispatch_enqueue where the goto local_norefill statement is (though
the current code is pretty easy to follow - all the dispatch
statements are organized into what is basically a big switch
statement, with the goto labels doubling as documentation).

> +local_norefill:
> +       dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> +       return;
>  local:
> +       dsq =3D &rq->scx.local_dsq;
> +       goto enqueue;
> +global:
> +       dsq =3D find_global_dsq(sch, p);
> +       goto enqueue;
> +
> +enqueue:
>         /*
>          * For task-ordering, slice refill must be treated as implying th=
e end
>          * of the current slice. Otherwise, the longer @p stays on the CP=
U, the
> @@ -1355,14 +1365,7 @@ static void do_enqueue_task(struct rq *rq, struct =
task_struct *p, u64 enq_flags,
>          */
>         touch_core_sched(rq, p);
>         refill_task_slice_dfl(sch, p);
> -local_norefill:
> -       dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> -       return;
> -
> -global:
> -       touch_core_sched(rq, p);        /* see the comment in local: */
> -       refill_task_slice_dfl(sch, p);
> -       dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
> +       dispatch_enqueue(sch, dsq, p, enq_flags);
>  }
>
>  static bool task_runnable(const struct task_struct *p)
> --
> 2.51.2
>
>
