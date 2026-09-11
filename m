Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A13246ED
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169501; cv=none; b=ijK7dFqcZfh5V3CuxATe5EQsuEu+MErFGHtWxpLucy26bMTwvySf49lZEivboU2nkhdoMj+/PM8gNL0gB9sveuRy8wazafnLPdgcXW7aDuEsZqFjeMS+LB/Dgh6xU81aLrP3Mx8JOhIXzOwaK0K2b+sWj9t+2qPd1wNg/qmzaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169501; c=relaxed/simple;
	bh=FzgRqxihB+hNLoJgN2QCemjiLyQpY0P4rHHWX6tRwIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WrTe5ZWC09kuWOw54IlFZ0gxY94gyAOg/YoSJmWG7ScogTtjt7cv0dRQXUhK43eXs2y/Nscu7MVCIW1TRHuOMLyCQZM/lnYoAX4WrPpXKsT+idlH2pmxKXEkEN4DGgDig+Y5Hhrnie55L+rnNIPOZ/EOaVFgLalcJDcS9tUZOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=ot3ePsez; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="ot3ePsez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1789169499;
	bh=FzgRqxihB+hNLoJgN2QCemjiLyQpY0P4rHHWX6tRwIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ot3ePseznL1aIJEuhuQ/6uYI4QswWZLcGAqumjC26JGtlNqCjP9TsJJzxGCeBZqiS
	 oDghBuADZVvBf/XMAs2HB14qfJ1eSZIrZCGQAQS07xZjfzkWQhE5Ve6m+eq/5LWWF3
	 Ca+gWVkcI1oZ6Or5ZyyunRAdmg601Moox2SmkKmo=
Received: by gentwo.org (Postfix, from userid 1007)
	id 052ED402A5; Fri, 11 Sep 2026 16:31:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 025C940110;
	Fri, 11 Sep 2026 16:31:39 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:31:38 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: sashiko-bot@kernel.org
cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched: Restart hrtick after same-task repicks
In-Reply-To: <20260911224230.A19611F000FF@smtp.kernel.org>
Message-ID: <671ad8e4-d252-c492-fc4f-364681655e35@gentwo.org>
References: <20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org> <20260911224230.A19611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-14539572-1789169499=:1651443"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-14539572-1789169499=:1651443
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Good catch, I missed this when extending the repick handling to DL.

On a non-tick reschedule, next == prev skips put_prev_task_dl(), so
execution since exec_start has not necessarily been charged by
update_curr_dl(). The new SNT_REPICK path can then call
start_hrtick_dl() with a stale dl_se->runtime value and delay the
next DL enforcement point.

Fair does not have the same issue because pick_task_fair() updates 
the current entity before selecting. The normal DL schedule-out path 
instead charges current from put_prev_task_dl().

Also, task_tick_dl() already updates current and rearms the DL hrtick
when the current task remains runnable and leftmost. I will remove the
DL repick handling in a respin unless there is a DL case which bypasses
that existing rearm path.

For now, please disregard the DL part of v2.

Thanks,
Shubhang Kaushik

On Fri, 11 Sep 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Restarting the SCHED_DEADLINE hrtick on same-task repick uses a stale `dl_se->runtime`, pushing the timer expiration into the future and allowing bandwidth overruns.
> --
>
> commit fe44140b6abb0653f45d8368ffe6e56a2831b43c
> Author: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> sched: Restart hrtick after same-task repicks
>
> This commit introduces explicit hrtick restarts for same-task repicks in both
> fair and deadline scheduling classes. It adds a new SNT_REPICK type to bypass
> normal transition work while still rearming the timer.
>
> Link: https://lore.kernel.org/r/20260813-sched-fair-hrtick-restart-v1-1-4230d1e18fbb@gentwo.org
>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 0663c00c41c04..6c17563f42a1d 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
> [ ... ]
>> -static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
>> +static void set_next_task_dl(struct rq *rq, struct task_struct *p, enum snt_e type)
>>  {
>>  	struct sched_dl_entity *dl_se = &p->dl;
>>  	struct dl_rq *dl_rq = &rq->dl;
>>
>> +	if (type == SNT_REPICK)
>> +		goto repick;
>> +
>>  	p->se.exec_start = rq_clock_task(rq);
> [ ... ]
>>  	deadline_queue_push_tasks(rq);
>>
>> +repick:
>>  	if (hrtick_enabled_dl(rq))
>>  		start_hrtick_dl(rq, &p->dl);
>>  }
>
> [Severity: High]
> Does this code use a stale dl_se->runtime to arm the hrtick?
>
> When a wake-up or other non-tick preemption check sets TIF_NEED_RESCHED
> on a running SCHED_DEADLINE task without calling update_curr_dl(),
> __schedule() might repick the same task (e.g., if the woken task was migrated
> away before picking).
>
> If that happens, put_prev_set_next_task() takes the SNT_REPICK path, which
> skips put_prev_task():
>
> kernel/sched/sched.h:put_prev_set_next_task() {
>    ...
> 	if (next == prev) {
> 		next->sched_class->set_next_task(rq, next, SNT_REPICK);
> 		return;
> 	}
>    ...
> }
>
> Because put_prev_task() is skipped, its embedded update_curr_dl() call is
> also skipped. As a result, dl_se->runtime is not decremented for the time
> executed since the last update.
>
> When start_hrtick_dl() is then invoked from the repick label above, the new
> hrtick is erroneously scheduled using the un-updated runtime.
>
> Can this allow SCHED_DEADLINE tasks to exceed their configured bandwidth bounds
> and starve other tasks?
>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e656c7059bf86..defcf7fd023fa 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
> [ ... ]
>> @@ -2802,11 +2808,13 @@ static inline void put_prev_set_next_task(struct rq *rq,
>>
>>  	__put_prev_set_next_dl_server(rq, prev, next);
>>
>> -	if (next == prev)
>> +	if (next == prev) {
>> +		next->sched_class->set_next_task(rq, next, SNT_REPICK);
>>  		return;
>> +	}
>>
>>  	prev->sched_class->put_prev_task(rq, prev, next);
>> -	next->sched_class->set_next_task(rq, next, true);
>> +	next->sched_class->set_next_task(rq, next, SNT_PICK);
>>  }
>
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org?part=1
>
--8323329-14539572-1789169499=:1651443--
