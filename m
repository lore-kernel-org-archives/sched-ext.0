Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91F3845C8
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486962; cv=none; b=lf8xJqmywwyFWlQ+zgP6nZrz2p/qwm3t2ONdUcri7QoV8/9d/+UzE3m8updqRIe/WW7f38oc9RHhGmb6SXRAlAThHsitJTK712j80Zejv9dMqpre+FA/r6Y3gy1IITLCPIbUURVG9d1I0Vun7dv2lSm9ablVyOc0Z5gnREv9a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486962; c=relaxed/simple;
	bh=CLqifUCn+tLu0VEohs+M3SSQnynIfAApf0DPx47hcqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mNHO+aulnYtl2qJHRXYMVxxWXpjKLm7ue8KYxQ93sAKJs/RJYpf5lN5Dgm2+qvjbewWp5lUxhuZSjvdOhrx/xClMDAVDlFZXJpFH7iUKL2UsRMtOxL5cLSfKMcRssRbpzffE48cfg0fbNstlJYD8JzX8THBR3m+Gy27F9V50jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Nf1mLBGR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Nf1mLBGR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so39468215ad.1
        for <sched-ext@lists.linux.dev>; Mon, 06 Apr 2026 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775486959; x=1776091759; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkhNub4LL3/cFTIw3iuBQjICw3ALHlWzhYc6XjKQcKY=;
        b=Nf1mLBGR+HPlnhXxwXucAFpzxJqjWuB1fn3AZQ1fr6hAa4ais2Wx0R/kAcmd0eBeMa
         ZgSWog3Jxb1HOqEu1hqoQbG9EFAhWEe27uwxOugSQLUE2+SOOXQzjckhD8vjFIBRPP0y
         jFjUQuYiQEHKKxUBPBemj7UFUtATD7J+ExnQ15F2wdDhqb38qmQwEKyOVZhddd26HoEu
         LBpvypkMyZ5pgfYOOc40RBFPUvdQ31+VFAzCX4o2yoV1+rSdsXlhiTWRbmHGtSs9O9Jv
         UOVBt4RPPR27XHXa3bcCZ2YhoiIqrNBYkUrhtWMAGP1H99qRxldKi3c6QjECVU1xX/d5
         klqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486959; x=1776091759;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkhNub4LL3/cFTIw3iuBQjICw3ALHlWzhYc6XjKQcKY=;
        b=tH19dDWpGnXCU5O3dnfXmX3rzandWDsRQmB/bWJbZU2u0v02vFb4yDF8P15Q5E9aLR
         eMGW9zZ0nEFbK+3gITOa/JjmCxY/jElMd9fyf+dN8ShwxeztwA5zKtfdATGkAtQA5mAO
         ONd/nDlwADyzZl1oN++7bb0UWL6uGQtwd3+9sZpouEFJi4LbBbrbV8T2rE22AFJdJvPg
         9rp45t/amttl2kkD4IQoli6iOjMNoWBn/NioqdxtyYXLLXvTil+K8BWOHbiXsQaNVU2Z
         jJ3icg+1W3pFcIMiujtFjdgIiBqiM4Qngun7Z3xY1YoqDWYgZwpask4kXf/+NhNZeHcG
         Nx4w==
X-Forwarded-Encrypted: i=1; AJvYcCV2VtVtfxft0w+D3Fcq5NS/HbSHJPL7rvTNbbaf1Gmx0srbaMMvnTuf9lZfSKfSVh1Yu5A/8xveE0c=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzQevAbDGTaMdYSrgPrFn2XAeIh8EzaN3HsIXs3DM3wJm2WcNm
	rXKzTrmKUrpMIhh2VaXYGMrI9owbNLxNVX6ZodH+pprwEAQzQQldTX7VckcS6o9IllQZ2A1fN+5
	0jYx+xB3X9g==
X-Gm-Gg: AeBDieuE42vAnCwb5XAyBCvQ1JXnxIZl8P+/DExyTx0ZU5rKbG9Fe4ZZs5TYxHEW3x4
	3Q9pQ23Q5Rpoev+HbTnRikcqpfe2fxm9IZX6wKSYoQPm585ANjp5yHxpZ6CzIYfRQRIvKBqBJ3C
	BRIDjxPVqLk8TpTGhg+LJdhb6DDi5HPHFgLTKQJeEV1WpgCf9S0SbluK5/CIqtlm1kgrvJ9DWFY
	UBz+XLBDbSmg3mSUWRgYBg5ChiCjf2E1D8RXRW7n3DH4kRpQdN2dQDo9WFuwaOPHour9SXMnTEL
	ui0lnCd/cNyRuFJI7WvomauPKbCoN834FRqJrldawFNLHZCr83xAU9thqqquRH7vrFLNWjZ3TtK
	iaNcOZZJtt9l9EA0/1WnnNeqTKTCk+X+BdCkTsU0S4qUlCsFWuKBYmeqcStX8XFz6MSzatcDWD2
	3P0HpKEkY=
X-Received: by 2002:a17:902:e78d:b0:2b0:b214:3bf0 with SMTP id d9443c01a7336-2b277e370a6mr138357705ad.17.1775486959108;
        Mon, 06 Apr 2026 07:49:19 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747530e4sm147753145ad.18.2026.04.06.07.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 07:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 10:49:18 -0400
Message-Id: <DHM5LKD95FE4.3WR8JAYD4IGL@etsalapatis.com>
Cc: "Christian Loehle" <christian.loehle@arm.com>, "Kuba Piecuch"
 <jpiecuch@google.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add
 ops.dequeue() to task lifecycle
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260406114755.840497-1-arighi@nvidia.com>
In-Reply-To: <20260406114755.840497-1-arighi@nvidia.com>

On Mon Apr 6, 2026 at 7:47 AM EDT, Andrea Righi wrote:
> Document ops.dequeue() in the sched_ext task lifecycle now that its
> semantics are well-defined.
>
> Also update the pseudo-code to use task_is_runnable() consistently and
> clarify the case where ops.dispatch() does not refill the time slice.
>
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")

Is the Fixes: tag appropriate here? It's not like the original patch
introduced a bug by fixing ops.dequeue().

Otherwise the state machine looks fine to me!

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  Documentation/scheduler/sched-ext.rst | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index 404b4e4c33f7e..9f03650abfeba 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -422,23 +422,29 @@ by a sched_ext scheduler:
> =20
>          ops.runnable();         /* Task becomes ready to run */
> =20
> -        while (task is runnable) {
> +        while (task_is_runnable(task)) {
>              if (task is not in a DSQ && task->scx.slice =3D=3D 0) {
>                  ops.enqueue();  /* Task can be added to a DSQ */
> =20
> -                /* Any usable CPU becomes available */
> +                /* Task property change (i.e., affinity, nice, etc.)? */
> +                if (sched_change(task)) {
> +                    ops.dequeue(); /* Exiting BPF scheduler custody */
> +                    continue;
> +                }
> +            }
> =20
> -                ops.dispatch(); /* Task is moved to a local DSQ */
> +            /* Any usable CPU becomes available */
> +
> +            ops.dispatch();     /* Task is moved to a local DSQ */
> +            ops.dequeue();      /* Exiting BPF scheduler custody */
> =20
> -                ops.dequeue(); /* Exiting BPF scheduler */
> -            }
>              ops.running();      /* Task starts running on its assigned C=
PU */
> =20
> -            while task_is_runnable(p) {
> -                while (task->scx.slice > 0 && task_is_runnable(p))
> -                    ops.tick();     /* Called every 1/HZ seconds */
> +            while (task_is_runnable(task) && task->scx.slice > 0) {
> +                ops.tick();     /* Called every 1/HZ seconds */
> =20
> -                ops.dispatch();     /* task->scx.slice can be refilled *=
/
> +                if (task->scx.slice =3D=3D 0)
> +                    ops.dispatch(); /* task->scx.slice can be refilled *=
/
>              }
> =20
>              ops.stopping();     /* Task stops running (time slice expire=
s or wait) */

