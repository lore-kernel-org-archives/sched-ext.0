Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9E379974
	for <sched-ext@lists.linux.dev>; Mon, 27 Apr 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299277; cv=none; b=EJiXaftaaOLoh+1kZkcn8lxEe+03lGfq2Si9Pn84FQ6Cv68pwV7juphFRnnfS0hK7d37IyoVzRfY85MmwC9X09l6vLYxfGSxL9GRwLQaZAPU/17HfVCmjrooauoFxpuT4MzDDEALxlpdX/xvMHCcxV1CLNblnitayNsWMWBVmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299277; c=relaxed/simple;
	bh=7pfgC0OFpo4hH9q94IdzrBZZzdAldUhVVts4dZJ0IzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tj6LtnVUaq4/rxrxsy8sm4phzPNpdd1ZyE3Eu3NvRFxMHvd5Pmw/rTfORCKsWZKjhVdLowR6KV++ZlIotKP5KCWlKbOald21UGF4S0i20T43bFT8yz9Wp9Y1ki4dmq9nXznMxOQFwjQdbpdzgu2lX0obnFbq3cpVIoUKb+dfCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvNDrl8j; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvNDrl8j"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d70c27214so7154887f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 27 Apr 2026 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777299275; x=1777904075; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOY9fgWdFDp7gkAn6yDNTiManbjKUqC7ExhU7qOgPnw=;
        b=RvNDrl8jJFf2dkhi9PeMZ7ReRwBMbqcy6ZvtK2bTIClsyQAauv/B85F0/sH4vTCAWP
         lwP9KGVP3ezhawRzzgfR+KZiuSV+dhde6emzDj6/NhVHNvExKn8rRfXG8x4w+/t1Vesp
         CeGTDMOyvrfbPioNt4BGMIdvXIzD0iRUcsEcTwjmtTeR4OBYXtWUfZsX4RR/bul9DP/L
         BirUMKi8av5UnK+u8EwtPyHydI7NiS81LdNDQ80VejhvG6/DilNywlnKCSwR7lakhitv
         d0IzBbIVi6I0YB/QrfZKf1mDza8FxZuzFT8q2L2uMdIo1Sf2xwl/cpDj/NzclzkyEkQy
         UJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299275; x=1777904075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOY9fgWdFDp7gkAn6yDNTiManbjKUqC7ExhU7qOgPnw=;
        b=GDt854jOxIOD+uRdc7n7+NCip6a0TFoLo5YInvXB0igPxHUd/kvieAwEPFWgsRAnIq
         TkWy0mXS1yGu5FnNzWtFKm1OW9qZpOy6ARs0DObmALoJpwUbHziTuynerojwh1x+UUkJ
         GPDXnBqoqlz4TFQTgSwzL0ldxjG6h4FI8zHiDJEb/+ovSjIvEsU60WbvHfceQtQh/P/1
         HVexE2V/dM2APeZT4mNfMX3SkkPx2mjrgQ9VP/jcZJpZwjHO/ZRV8rMwV1nc+Zxxw1/4
         DXCgIterfRNXoKCb9SVXlod2I6bCJG+L1aWncw6yhlopFwRi6WBYY+lVAttAGH+4esoJ
         bhKw==
X-Forwarded-Encrypted: i=1; AFNElJ8wCkgz4o41kOJkJH2RmG/9fAv4oCqiRXH20TM90rTf4/su77yr+vY0poeiAyD48KEQhDSB/DuzYDY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyqRm5fiotlfXk9iPgH2yiPDEypjFo3KMsZRSZq4YcBioQHoEbp
	wQ690LN3zBjGv/ma5x5Ncb8Np/PvOYg1TNY7y7d6RZHHlCxqHltDvYH+jy/YbVYezxsN9ReZBjC
	Q6Q+QFTOGEnJKdA==
X-Received: from wrbdl9.prod.google.com ([2002:a05:6000:b89:b0:439:bfc3:59cd])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2502:b0:43e:b0f8:c564 with SMTP id ffacd0b85a97d-43fe3dbd756mr64451520f8f.9.1777299274278;
 Mon, 27 Apr 2026 07:14:34 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:14:33 +0000
In-Reply-To: <aeulrBs6ZAopfcHG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424092245.3212529-1-jpiecuch@google.com> <aeulrBs6ZAopfcHG@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI3ZVX73P4N5.WP4H0TMOBIHF@google.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Call wakeup_preempt()
 in local_dsq_post_enq()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Fri Apr 24, 2026 at 5:17 PM UTC, Tejun Heo wrote:
> Hello, Kuba.
>
> On Fri, Apr 24, 2026 at 09:22:44AM +0000, Kuba Piecuch wrote:
>> @@ -1408,11 +1407,19 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
>>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
>>  	    rq->curr->sched_class == &ext_sched_class) {
>>  		rq->curr->scx.slice = 0;
>> -		preempt = true;
>> +		resched_curr(rq);
>>  	}
>>  
>> -	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
>> -		resched_curr(rq);
>
> Hmm... I don't quite understand this part of the change. sched_class_above()
> got separated out into its own case but why is it dropping resched_curr() on
> SCX_ENQ_PREEMPT?

In the SCX_ENQ_PREEMPT case we call resched_curr() where we previously set
preempt = true.

In the sched_class_above() case, wakeup_preempt() will call resched_curr()
for us:

	void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
	{
		[...]

		if (p->sched_class == rq->next_class) {
			rq->next_class->wakeup_preempt(rq, p, flags);

		} else if (sched_class_above(p->sched_class, rq->next_class)) {
			rq->next_class->wakeup_preempt(rq, p, flags);
		=====>	resched_curr(rq);  <=====
			rq->next_class = p->sched_class;
		}

		[...]
	}

>
>> +	/*
>> +	 * If @rq->next_class is currently idle, we need to bump it
>> +	 * to &ext_sched_class using wakeup_preempt(). Otherwise, if we drop
>> +	 * the rq lock later in the pick and an RT task wakes up on @rq,
>> +	 * wakeup_preempt_idle() will be called during RT task wakeup and
>> +	 * SCX won't have an opportunity to re-enqueue IMMED tasks from @rq's
>> +	 * local DSQ.
>
> As this was really subtle, I think it warrants documenting all cases here.

Yeah, I was trying to keep it concise. How about something like this:

	/*
	 * Note that @rq's lock may be dropped between this enqueue and @p
	 * actually getting on CPU. This gives higher-class tasks (e.g. RT)
	 * an opportunity to wake up on @rq and prevent @p from running.
	 * Here are some concrete examples:
	 *
	 * Example 1:
         *
	 * We dispatch two tasks from a single ops.dispatch():
	 * - First, a local task to this CPU's local DSQ;
	 * - Second, a local/remote task to a remote CPU's local DSQ.
	 * We must drop the local rq lock in order to finish the second
	 * dispatch. In that time, an RT task can wake up on the local rq.
	 *
	 * Example 2:
	 *
	 * We dispatch a local/remote task to a remote CPU's local DSQ.
	 * We must drop the remote rq lock before the dispatched task can run,
	 * which gives an RT task an opportunity to wake up on the remote rq.
	 *
	 * Both examples work the same if we replace dispatching with moving
	 * the tasks from a user-created DSQ.
	 *
	 * We must detect these wakeups so that we can re-enqueue IMMED tasks
	 * from @rq's local DSQ. scx_wakeup_preempt() serves exactly this
	 * purpose, but for it to be invoked, we must ensure that we bump
	 * @rq->next_class to &ext_sched_class if it's currently idle.
	 *
	 * wakeup_preempt() does the bumping, and since we only invoke it if
	 * @rq->next_class is below &ext_sched_class, it will also
	 * resched_curr(rq).
	 */

Thanks,
Kuba


