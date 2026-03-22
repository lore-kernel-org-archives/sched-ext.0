Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5533B6CC
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774222446; cv=none; b=MMkxNuFSH44RvdK/csdnTpkDlyejiVwRCJliQL++k6la23MjBiIJRJFw7Qswp9G7ErLCyDIG3KPgXq/i3EQ2YyGG/QpstV/ysQ0YaPISNSFJvuC3HY4H1E1sQztKb0juQYInpwW8BYu+2PhXbXt+PyPpkwueaGX0QBXhGLvc8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774222446; c=relaxed/simple;
	bh=Yvx+EuPgWvjtjy658e1zHhslLR3HfdGscfTgmem5PQA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GCKDrR0Kr4BxQeXgepfW1jyKsLLxd3yl35GlItR0i/Wik+gWgoktOu8ZN7mcVq1wtZMXC3yBHNxzUIr7Iq59xQhnSOYGZbTaytAQKIuTEmD0hLqb6QwtSmiGvoUgKUsI1J/64oYYnrnV2Nmb2Y0lfgJf4cz3b9qFMaa8QTYViSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=quhNgHYB; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="quhNgHYB"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d77b179b52so2875313a34.2
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1774222443; x=1774827243; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILmjQxcfB9xi0INuqN7GRsQnoqsM2fGKPtNxDztVzeU=;
        b=quhNgHYBT4B4GdK3iM/lAhMQhw7NxpHMfFHq9uEderPczdOrHeQNJztQkA8rEj/STd
         R1Eeo+cBNq9hWG1WroEZURrPQAr+IVkPK3Z/Jawf7NBtI/ULKDYG0iArKVLGfW2i7FFp
         c6ZBA47S7OMSnDuaLom2mS3i2pQ7oHUYyXsOdxroLEjnG/kJ4m6CdpN0YVu4layRhYsr
         WuX/mPhOh05KRMholT5zGKLN7W1tOL11PrSoziZMq1Nwkmw6tdh2BI0ZZWCnDWz5ajM4
         bFOezORqsboA02VxbyZVghx33rsgiZ8LexC4L86sFp29QpipN6s8Wrud1NCXPyebz5mO
         CTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774222443; x=1774827243;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILmjQxcfB9xi0INuqN7GRsQnoqsM2fGKPtNxDztVzeU=;
        b=L04pFPxAvTxtXrkTTGpprtBL4G2bYNaJVnTqAFp6+CHH//F+ZT5Jj93nx+W16mbpSe
         94F8DGo+pUl71uYLYXujnAw5Lbb+2wlyda4jKbqyE1v1VC9yiafpgM+2W8d0DhTCjNIo
         3HJ7Kvc3bmTpTjK0hO+oM7Lwp9HGo+Y39sFBgkaDtPRTfz8Yk0IwNBW7YngsCZO09sxV
         0o6OXA4wMSuUTz/1cwhANc3wfwPzlfcCMaVjOYUYZie7FdYwqX5N9OctkAagZNbFHNAR
         MIBwj3VVtf/X7Lfdm929bmu8CM7rUKDU0+dSWmYwVmNS7sAdiXDrY9oRvPtddO2L7vro
         fcxQ==
X-Gm-Message-State: AOJu0YyZlxsWdPhkqAv7hrHkKffV4orLRVEIdbtFhg8w4vWA8UWUIlV5
	jfnsU5xT5LBRCivXnsWvw5dswfzf/BZbnCDHOLnj5GWwUbSfpkOT2bCRYW52zrbXPwA=
X-Gm-Gg: ATEYQzwuJJgvxaTAySwyDjc9RZawGJ6wEE73ORmS6+DEXhcu6/qWExwtqbKeWZZ+fr4
	nhp1rFsXJOIFq5kE//BKKiYhyB4L3vpevMTxNcULjCuPu8q/RTTCaP2CAaCxRC9180gjJEbne7U
	nOxjOwYVli+fcDJRJAaZxCiQ13+AyFpiYA92CxbdpA7pwDmOpSYYMkWruhSD6P1c+X/HUotOJHz
	PPT7RURBCONTlbJSUlnCJO1knhWIHB6vTc/ZeQOTvHArPgX60TNpaFKdvl3rqkef6vuf+UkQCNp
	ivXyX6+hVfdxLG3pYXWe0yYun7VuVOW2Kt88JzmNrFB56M8FL7KgVCcuR9kGURwHPAPCLg6e21U
	K4etk8O6TRqWpNvtacDdPpju3fO1JiAN4TsCabBanYUmSOJ1sM9Y/N8h8sjD0APvZJ2KJNcW53V
	LaYyB4Mm5g0zBhejytmPrtPjE=
X-Received: by 2002:a05:6808:8816:b0:467:32c1:acf3 with SMTP id 5614622812f47-467e5f7b686mr4173660b6e.52.1774222443094;
        Sun, 22 Mar 2026 16:34:03 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4bdbdsm5855407b6e.7.2026.03.22.16.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 16:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Mar 2026 19:34:01 -0400
Message-Id: <DH9PD5IB1A7M.1P73IYGVL0PDL@etsalapatis.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Use irq_work_queue_on() in
 schedule_deferred()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <a80d84c345be8fbbd5a1294b9a72ae37@kernel.org>
In-Reply-To: <a80d84c345be8fbbd5a1294b9a72ae37@kernel.org>

On Sun Mar 22, 2026 at 4:33 PM EDT, Tejun Heo wrote:
> schedule_deferred() uses irq_work_queue() which always queues on the
> calling CPU. The deferred work can run from any CPU correctly, and the
> _locked() path already processes remote rqs from the calling CPU. However=
,
> when falling through to the irq_work path, queuing on the target CPU is
> preferable as the work can run sooner via IPI delivery rather than waitin=
g
> for the calling CPU to re-enable IRQs.
>
> Currently, only reenqueue operations use this path - either BPF-initiated
> reenqueue targeting a remote rq, or IMMED reenqueue when the target CPU i=
s
> busy running userspace (not in balance or wakeup, so the _locked() fast
> paths aren't available). Use irq_work_queue_on() to target the owning CPU=
.
>
> This improves IMMED reenqueue latency when tasks are dispatched to
> remote local DSQs. Testing on a 24-CPU AMD Ryzen 3900X with scx_qmap
> -I -F 50 (ALWAYS_ENQ_IMMED, every 50th enqueue forced to prev_cpu's
> local DSQ) under heavy mixed load (2x CPU oversubscription, yield and
> context-switch pressure, SCHED_FIFO bursts, periodic fork storms, mixed
> nice levels, C-states disabled), measuring local DSQ residence time
> (insert to remove) over 5 x 120s runs (~1.2M tasks per set):
>
>   >128us outliers:  71 -> 39  (-45%)
>   >256us outliers:  59 -> 36  (-39%)
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1164,10 +1164,18 @@ static void deferred_irq_workfn(struct i
>  static void schedule_deferred(struct rq *rq)
>  {
>  	/*
> -	 * Queue an irq work. They are executed on IRQ re-enable which may take
> -	 * a bit longer than the scheduler hook in schedule_deferred_locked().
> +	 * This is the fallback when schedule_deferred_locked() can't use
> +	 * the cheaper balance callback or wakeup hook paths (the target
> +	 * CPU is not in balance or wakeup). Currently, this is primarily
> +	 * hit by reenqueue operations targeting a remote CPU.
> +	 *
> +	 * Queue on the target CPU. The deferred work can run from any CPU
> +	 * correctly - the _locked() path already processes remote rqs from
> +	 * the calling CPU - but targeting the owning CPU allows IPI delivery
> +	 * without waiting for the calling CPU to re-enable IRQs and is
> +	 * cheaper as the reenqueue runs locally.
>  	 */
> -	irq_work_queue(&rq->scx.deferred_irq_work);
> +	irq_work_queue_on(&rq->scx.deferred_irq_work, cpu_of(rq));
>  }
>
>  /**
> --
> tejun

