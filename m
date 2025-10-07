Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBA2E542B
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850540; cv=none; b=KvogrHw4oZELUCFXeCW7/s4pPp72VtHthv3UhudZET2bPRXIhl8ezUspqMNA2hMYfZraWLFlgSPDbVXD6gvmsSY+mjZPGx9gRIEL34o87LMEW2N73HvieicjKI3DTg02uiaYdgRmK9lwwlkPgYkMmJlwhB1+g47TAihkzGIjMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850540; c=relaxed/simple;
	bh=WM6hgH1P8GcEwnp4CSHs/x3JAUOpqZrrbyxYf6RpLPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhhYBvjj9CRAloX9a5CivWBcsPFI01p/HO0xn0UpPTRJfJtEc9fHkE8HnpUq3v5hA9RMBe4nyBpQqsk/YHM76EvmesEZmZTPKIlK6i40dqwsnUwyWyF0lOXqcCKYlCpw33Bx6evQ37HNdm6Ujd9J4fOGqle6xWVJftb1M0Cj614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B85m63Ci; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B85m63Ci"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso10301945a12.0
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850536; x=1760455336; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj+6bWQslfiTLa+4PHpgmn9y75LNrAViNjvut2qJSfk=;
        b=B85m63CiCRx54ixsvbndRsGpRFsciVs2pnqVAZrR6sVhETDL5ZZ1WMD5jOexIzb7Uq
         lixnD0TJ5WfKsJp/FkEbHo29zXhGJ160ZKHWTxz0x3TXllcjuhce9kW547oMM2+VHGTD
         unMFLHxCC3pBlkvzgHUU771U3dz3fJfC8Aab/7PuHHNo0pWsLi/3k9La6F8ecCszb5bi
         v3XjLvZF/cR7JKfaYm5AytRiy6eDs5Vgzr462+jApv6+PO4WDg2Pej2pZL86COCpPG7y
         Cl8KbxYZC2VJyxqgHcEIZ0WxJ3hbAgz9ctZXRAquSduX9LORjTohRgive0i9qDldvNGS
         2zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850536; x=1760455336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj+6bWQslfiTLa+4PHpgmn9y75LNrAViNjvut2qJSfk=;
        b=MQGGW8pfYqOR8GELv4Id04BK4FwZfZQXWuMhYHru/yMkcxjElwfjuXN0UnOz8l5vr3
         NgE8hCXT/1oU2yv4GC/2UScuO5RmaMDLVjzw4FIP/UHtsyhnZ1xVROiwPj0qK9G/TL0U
         jPBY89fEzsJUkOhE2LkfbE186dqRl2ODh2xUYBQvU23JuF9ADLzViU5K7zJqYKtU8u03
         GPJIRN02p31FazupXxV6WAsOmBwb9fIHsUnsYUPULXXpkq3huq8fhDgwX0mJttQZ7AgP
         P6yOC2+ciYCtT4/T3Z5rLIWmBUMRqS3RLnVWbBSlf+551VUAx/hQKKEPNZp8Z8/I5kmG
         qL2A==
X-Forwarded-Encrypted: i=1; AJvYcCU6Fk6tK+6hwHN2NDYNiOIyftBkvjx+O9qNfPSivQ5osTTXlzdRSBj/b8rJ/R6h/F6f7FBW2jHF2Nw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9euylnMruEOyNAHGMQJneAr8RAYNEaqBvsk1Oa9PMeUYTgdZV
	RmNdBTESYh4gP6UEcg0fRF8ZWr0b0AQ5FTkvoaYWKFhU6xkYFkpShGEyVdSIYnDUtZNsulQRdxw
	1pOIH7lHfFCM8VzsWvt2cZn9mgz1c8uGNa67cLH1RuA==
X-Gm-Gg: ASbGncuXfff8rmjhZ7Snuug8lXrDfvZlmF7ZAfLE75yYaC4CZ45lAvcidrTzhlwxEeq
	QNKg/FYxI+yPAUNTY/ngrBTwg3x7cUY3h/HSfUjYEXuITx2Qa8bK4aNroHJpeBxDDT0wP13HOAO
	Kaig/zNH1G2iv+MBDdMsDcywgEx9RXHSgCmHF/zG2tphLlWo1XkyyhhCZ/3J9smUpsI2WE8zgNW
	BQko98tlX9DFaNTefADXFIjuEKZCBVbjInIs8/hF8KXcCx6HkM+mHzN1CQKOAI=
X-Google-Smtp-Source: AGHT+IEOLX7r/tKzGoeeZy9wOj+XUlBEOxx8L5IKIwy+J8iOESDBaK6+dbXRpt6rG0Ux0Pp6UBfDLtppzsDqp59rsPk=
X-Received: by 2002:a17:907:dac:b0:b49:5103:c0b4 with SMTP id
 a640c23a62f3a-b49c32554f5mr2167080366b.56.1759850536235; Tue, 07 Oct 2025
 08:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104402.946760805@infradead.org> <20251006104526.964100769@infradead.org>
In-Reply-To: <20251006104526.964100769@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Oct 2025 17:22:05 +0200
X-Gm-Features: AS18NWBp67oekCA5wJuqsWfMSlc_Mr63BTHm_H8SM2ppgSw678wieZ4yFPZoLog
Message-ID: <CAKfTPtAY5Py=rmzbT+e7p5Em2eU0Do25ZKfcKZ2ZTjf6jFFOCg@mail.gmail.com>
Subject: Re: [PATCH 04/12] sched: Cleanup sched_delayed handling for class switches
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Use the new sched_class::switching_from() method to dequeue delayed
> tasks before switching to another class.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c     |   12 ++++++++----
>  kernel/sched/ext.c      |    6 ------
>  kernel/sched/fair.c     |    7 +++++++
>  kernel/sched/syscalls.c |    3 ---
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7368,9 +7368,6 @@ void rt_mutex_setprio(struct task_struct
>                 queue_flag &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>         }
>
> -       if (prev_class != next_class && p->se.sched_delayed)
> -               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>         scoped_guard (sched_change, p, queue_flag) {
>                 /*
>                  * Boosting condition are:
> @@ -10845,8 +10842,15 @@ struct sched_change_ctx *sched_change_be
>                 if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
>                         flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>
> -               if (p->sched_class->switching_from)
> +               if (p->sched_class->switching_from) {
> +                       /*
> +                        * switching_from_fair() assumes CLASS implies NOCLOCK;
> +                        * fixing this assumption would mean switching_from()
> +                        * would need to be able to change flags.
> +                        */
> +                       WARN_ON(!(flags & DEQUEUE_NOCLOCK));
>                         p->sched_class->switching_from(rq, p);
> +               }
>         }
>
>         *ctx = (struct sched_change_ctx){
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3924,9 +3924,6 @@ static void scx_disable_workfn(struct kt
>                         queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                 }
>
> -               if (old_class != new_class && p->se.sched_delayed)
> -                       dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>                 scoped_guard (sched_change, p, queue_flags) {
>                         p->sched_class = new_class;
>                 }
> @@ -4677,9 +4674,6 @@ static int scx_enable(struct sched_ext_o
>                         queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>                 }
>
> -               if (old_class != new_class && p->se.sched_delayed)
> -                       dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>                 scoped_guard (sched_change, p, queue_flags) {
>                         p->scx.slice = SCX_SLICE_DFL;
>                         p->sched_class = new_class;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13237,6 +13237,12 @@ static void attach_task_cfs_rq(struct ta
>         attach_entity_cfs_rq(se);
>  }
>
> +static void switching_from_fair(struct rq *rq, struct task_struct *p)
> +{
> +       if (p->se.sched_delayed)
> +               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +}
> +
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>         detach_task_cfs_rq(p);
> @@ -13638,6 +13644,7 @@ DEFINE_SCHED_CLASS(fair) = {
>
>         .reweight_task          = reweight_task_fair,
>         .prio_changed           = prio_changed_fair,
> +       .switching_from         = switching_from_fair,
>         .switched_from          = switched_from_fair,
>         .switched_to            = switched_to_fair,
>
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -689,9 +689,6 @@ int __sched_setscheduler(struct task_str
>                 queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
>         }
>
> -       if (prev_class != next_class && p->se.sched_delayed)
> -               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> -
>         scoped_guard (sched_change, p, queue_flags) {
>
>                 if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
>
>
