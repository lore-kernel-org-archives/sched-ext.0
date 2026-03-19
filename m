Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A53C1997
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916295; cv=none; b=Oo880nn21dWXnCnymRY+RPygcU231ORU153qRTtOdTOYMdydccBPnWZQ1bxA4fObO6tIhaZbdjRfTQNuS9iIxiegSbJXOuRU06g6p9h/1spxhxRmOdP0VD7WJlPwfzFLRGbruF8aUorzqBak+zZ9pSGN206OoJbprpItOb5FgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916295; c=relaxed/simple;
	bh=fdDW+cyULHtF9068HKpKB1+dQ6QqBdJldhZl7Oek9Ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oe0sG4l3wEhhPTfWEFO5Jjzdr2Y/iX8IXBL8BQld7/agI7JgA766riyROdP9P9gp0pXSWtj6he7Nc4YKC6LcUC8g8xjcEKeo2cSsayxJ4rfvOVxQM1at2NI5QeZgOG1B0m+j+e50ZvI/zje2x18/dtuRusuqmWsovqTbHiUn+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0hlJ3hH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0hlJ3hH"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so7490135e9.0
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773916291; x=1774521091; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QAJwDvz3p/lKamkB5t02atWMJOrYh8w3uDwHSA2+9E=;
        b=r0hlJ3hH1U2+QLWul6rwKQGhJpQOalvTnE0EWd5wO3CIl1m8a/WuPKubI5GKk9agvD
         YXCWMLCo4+dIRRrAJiDQIMekloWLPyYlqZLhECK+6OCifrJOFVMwLNAkSxiGj8xLW7U+
         dAEVl5vQGx9hli9Z7HNIYguQ2oW5q2ok4m3FNYjEpj5PBPK/UjDrZ7hULaXW34GRx/De
         +ZSRNuIPyz5+nd4lUkOI3Nt/eNxiByoTpK/j3Um3kRL+c2Z2ClkAYmOrwzB0CjXVrKyp
         pyKRKwaBXHYjpuYH4Cm/38InPUkbF3KNEAOmnMgapEG4g4ojlHykVf81K+vR7f0BMniL
         DLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773916291; x=1774521091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QAJwDvz3p/lKamkB5t02atWMJOrYh8w3uDwHSA2+9E=;
        b=dphIl8z93fXLOKP3SfiI7UCgrfcxXpKB79Al5kVHpRwN1q99/Nzsr2ibgK8C8B9kY+
         G5Qj8d3SJXbgz28T5WjuASYzuWcXdpXJe5HXxADsME7mzyKXWQXJRXll5bXfrLW1C20R
         tersWuVPV25CJLXaEegnqzc/yA5LVG+Jap/GsPswG3MVFbOCk74oArPUptJOQdDH44IJ
         BknesNjaEc0TTV9ahk/iCmzeBjYSRodjg8eiwwhNH4TRKzAPRwZlSWUXeMnvkQ5FNvRE
         xDQXQDpIAiq4IUoHMREf63jMT9zNCJ2jGyoP92xE+JgZ9mQNLS1h0E5IdzBnTQFodmOB
         2CHg==
X-Forwarded-Encrypted: i=1; AJvYcCV243QnC2e1hbZXsjfLanACJxyFc4ePwWVaJLZFJRQ6tIsXXVsEMzB8djuQoNLRnCBtBpA33Dvt5e0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwxHqbhOE5EBrnm3V533DnAiaAr9L1BuZqfNn2+7Kjmtd6L9m8i
	Gy/W3fDNAoUgSKrTaHijjarKSO+dU0hf6czZkotTVXI+D2I+hM0BILMGgOojvrrY/X3r2Xcp7kM
	ACX7R76LGTi03bg==
X-Received: from wmil1.prod.google.com ([2002:a7b:c441:0:b0:485:40d2:1ebf])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f13:b0:485:3c05:24dc with SMTP id 5b1f17b1804b1-486f4465ec5mr110316055e9.33.1773916291431;
 Thu, 19 Mar 2026 03:31:31 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:31:30 +0000
In-Reply-To: <20260319083518.94673-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Thu Mar 19, 2026 at 8:35 AM UTC, Andrea Righi wrote:
> @@ -2043,6 +2041,13 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> +		/*
> +		 * Invalidate any in-flight dispatches for this task. The
> +		 * task is leaving the runqueue, so any dispatch decision
> +		 * made while it was queued is stale.
> +		 */
> +		rq->scx.ops_qseq++;

I'm not sure why this is necessary. Isn't setting the ops_state to
SCX_OPSS_NONE enough to invalidate in-flight dispatches? Could you describe
a scenario where incrementing qseq on dequeue is necessary?

> @@ -2537,9 +2546,26 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  	}
>  
>  	if (src_rq != dst_rq &&
> -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
> -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
> +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> +		/*
> +		 * Affinity changed after dispatch decision and the task
> +		 * can't run anymore on the destination rq.

More of a nitpick, but this doesn't necessarily mean that the affinity changed.
The scheduler could have also issued an invalid dispatch to a CPU outside of
the task's cpumask (e.g. due to a bug), in which case the task won't be
re-enqueued if we simply drop the dispatch, correct?

> +		 *
> +		 * Drop the dispatch, the task will be re-enqueued. Set the

Just to clarify, is this referring to the enqueue that happens in
do_set_cpus_allowed(), immediately after the actual cpumask change?

> +		 * task back to QUEUED so dequeue (if waiting) can proceed
> +		 * using current qseq from the task's rq.
> +		 */
> +		if (src_rq != rq) {
> +			raw_spin_rq_unlock(rq);
> +			raw_spin_rq_lock(src_rq);
> +		}
> +		atomic_long_set_release(&p->scx.ops_state,
> +			       SCX_OPSS_QUEUED |
> +			       (src_rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
> +		if (src_rq != rq) {
> +			raw_spin_rq_unlock(src_rq);
> +			raw_spin_rq_lock(rq);
> +		}
>  		return;
>  	}

My understanding is that task_can_run_on_remote_rq() can run without src_rq
locked, so it's possible that @p's cpumask changes after the check, isn't it?
In that case, I think it's still possible to move the task to the local DSQ
of a CPU that is outside of its cpumask, triggering a warning in
move_remote_task_to_local_dsq().

Thanks,
Kuba
