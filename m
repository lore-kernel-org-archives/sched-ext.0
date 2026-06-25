Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605A38BF61
	for <sched-ext@lists.linux.dev>; Thu, 25 Jun 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380734; cv=none; b=AbF/vhXkGvCdISCuc8rPbiEnIhZ0OHL7gYN22dC1n4wGKx2QZh44V0a8BQvUzUm1uxtmbRUS9ZzIBLYdN6QAASnYL3mm91JsT1Fjfd2T8l6LU+cZJbNKw3NTu/jmkftAN1hSqP8+SNq9MrdHIZ0JqxJogIMhQpNWFlajeD4qTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380734; c=relaxed/simple;
	bh=X2QMhKHE5H7+OyUXq/L5gfDPWATHZgfeLqD/VWbxIlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZiFWF16xvErd3Nm4VV1G3LJutMO8fj7I1rIZncaPAFjeHkiRJRsJElsCsUqIBZskJMHegRmgyXOH1zgI80VYyiIcGKUJa/wtAUv0wSbHqoRzWUoJUc2lWF93PJE2YTktdRLsAEejKUr48JOnNr407Uywj6M3/WM21mN5T5jh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlkdb3wj; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlkdb3wj"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c0afbf73482so185469666b.0
        for <sched-ext@lists.linux.dev>; Thu, 25 Jun 2026 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782380731; x=1782985531; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNTGmwEEQTKVnN2TQ9nF4qbHA2nrSPdvPZBtz33EKno=;
        b=mlkdb3wjxTVnblPJpgMuGZ9D/EtDwG1UUW8GazYsktpoIozVU5zRl4J1PeXke8dsI4
         j4FIxj+VBCzm9kGgDpMu/xVm/sXwRBotZcxFoQ3WjVdyGt+Tj7XqAKZPJN2+WEdHHkoX
         IDKOxUS7uuGS5idmXG4FujcV2ICHSrv9gwvR64orm2CJtRDN1CoK9kLqi+oLfr7V7En6
         zR1vqgHZ9YLV29Hm/kYrtY3a7zspphlRDB9q9FOSnXAgklxk9YqWo3eEK4JcKZBcPh5Z
         sXYAdPT2iaRdZnZD6a3Cpgdle1wH7nuG1QJ5cbuhUdFSuciY/s5dZ0AXktaUS9SnAdDi
         QSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380731; x=1782985531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNTGmwEEQTKVnN2TQ9nF4qbHA2nrSPdvPZBtz33EKno=;
        b=otT+cjC8KVbKH5ZH3nxGazcKKlgZVFGilIaMMRdnj2sZzv0pu7jfQt1f04TpNb8EXJ
         rasYF3DS4BKFvGIZPLv6RkRh1P6emZkLMfd51jnqGA1SFh4siD6PVhVUYTX5Iom73Sa6
         h1vVBp9cOluRL5VVTXgmnyiJIwgt+p7e5PExn0j+P5UAaSG2edgpdMuL3levyM96loSn
         uS2qCpf0PnkPFCRt+v4tF5cXje+l6wh0A1vP3WGfo0N2mfoMiLf2paM/AFaMqGIJ44hc
         dg9pRMfLALehJpzUUEn7gcObPs2sTtXg68Y0xZXUS079iSR8XM5kffl7CNL6bfiBctBO
         lECw==
X-Forwarded-Encrypted: i=1; AHgh+RoDa+sYxs8gB0dz6/At39ONo7SvrumLjhE9COYcaX61g6PahMzlv5/7RfuJUi7TZgZNLlZazErrj3E=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLsNTrx4ShF0TZnCfuLPWJN72km9H9fYfe6vWHw5hE7GgZEX1W
	secth6pDKHGxbETPHHP5vjQ2echS8mVEy2OuaFsfDypzcwOLq0k6xOfu6yS+RRT5VjTIgzX0tOJ
	87DtrlscmqS7Fog==
X-Received: from ejje10.prod.google.com ([2002:a17:906:1e8a:b0:c0b:a48b:a0be])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:849:b0:bb7:eb68:514e with SMTP id a640c23a62f3a-c1205f2315bmr114423766b.36.1782380730826;
 Thu, 25 Jun 2026 02:45:30 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:45:30 +0000
In-Reply-To: <20260624235531.2979880-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260624235531.2979880-1-tj@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DJI17L7ZP0BT.3VW1FVZMRGWOM@google.com>
Subject: Re: [PATCH] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Wed Jun 24, 2026 at 11:55 PM UTC, Tejun Heo wrote:
> put_prev_task_scx() warns when a runnable task drops to a lower
> sched_class without SCX_OPS_ENQ_LAST, assuming balance_one() would
> otherwise keep it running.
>
> Under core scheduling that assumption is wrong: a forced-idle SMT sibling
> reschedules through the core_pick fast path in pick_next_task(), which
> skips balance() for the CPU, so balance_one() never runs and a runnable

Nit: balance_one() doesn't happen in balance() anymore, it happens in pick.
So IMO it should read "... skips pick_task_scx() for the CPU, ...".

> task can drop to idle with ENQ_LAST unset. Skip the warning when core
> scheduling is enabled.
>
> Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 9c9cb9d08bca..503c4d2105ee 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3092,7 +3092,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 * which should trigger an explicit follow-up scheduling event.
>  		 */
>  		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
> -			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
> +			/* core-sched can force cpu idle while @p is runnable */
> +			if (!sched_core_enabled(rq))

Is there a more precise check that we could do to determine if this switch is
due to core-sched forcing the CPU idle? I was thinking about
rq->core->core_forceidle_count, but IIUC that's the core-wide number of CPUs
forced idle, so it's not a reliable signal about any particular CPU.

> +				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
>  			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
>  		} else {
>  			do_enqueue_task(rq, p, 0, -1);

This patch made me think a bit about core-sched interactions and I have
a concern about IMMED tasks staying on local DSQ when the CPU is forced idle.
I wasn't able to quickly convince myself that an IMMED task will be reenqueued
in the case where a CPU running an SCX task has an IMMED task enqueued in its
local DSQ by a remote CPU, and the CPU is forced idle while the IMMED task
is on the local DSQ.
Looks like we might need a call to schedule_reenq_local() somewhere in here
(in a separate patch, of course). WDYT?

Thanks,
Kuba
