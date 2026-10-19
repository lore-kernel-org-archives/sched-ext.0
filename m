Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451773;
	b=mPmcAFywp4nQyuiXYTsDQu1H0/baJoRJ6na4anrBfibdWHbkdB4i7+6iMBSatzU1ic7P
	 ReiOcZPAk4/Z6v8qhi+zEtW2EAa+8YdRsqlHZH4NKcmzhPTHpwX8ODwL2NI56Zf4bgYj7
	 glMSb3hdY6UAfl6/wCuG25ANah3frWQPlEl8m3NAmklRJYrKCgPfhosxHSSM+2XP3IHm1
	 enWCgtabr/74Al2bv6/fFa1T9ABxeq2ULwrOC0WLFAzRHU/iBygtbMNLVZ0cHE3Hm4kpk
	 SrWBr+bFozlkY2GoRxwNKgT/D7XzXJZkUtX9Sni1SZKGG2sUbifEn/pQjASuJad6FXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451773;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=RHXpfgE6tlNl9Q6xniJ7GDPBy2ifPJZgPpwX8kMvrqc=;
	b=uAkIWZlGj0G5h3EKsP1MrbcftNTPvxh/bnD/8yoZXFN1tubIy9Wivhm2DenbVxq3DJa7
	 qbvffpiUBPWG599MsMvS07uofJd+d3LFJ+UtwGmLTzbqVvVc+wmCXv75xLb3JmVkT58Rh
	 qwv4WIek/+f4dVceZiSFYc3R0NFER2TWM3iZksbE3FoWBEiNDMgj9ZywXYsZsJSdVwE5t
	 RPKNCwtXxAzOBTjbnLI54VaWQ/Scg56dA7w9F9OsLUgG9FHNGwSXqNQtDFJpvOwvsOLnn
	 qbXCJ7BoQkHOUOLbPvx3g/cwoACZTbQZ2iUXFCHWVwiwFBpD7znfLX985e6ckdjyEgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyhoVkWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B606A31E;
	Mon, 19 Oct 2026 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyhoVkWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F2A1F000C4;
	Mon, 19 Oct 2026 23:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451773;
	bh=RHXpfgE6tlNl9Q6xniJ7GDPBy2ifPJZgPpwX8kMvrqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MyhoVkWSpTpCncGb6cV8vu3lH8diglxcCc/EJ8bObYRmb0P7KVNrjs4pI6UuODSiL
	 MpRZNtY4IVqL4yFHl2Ah8PnnVVG31tSBl1CXvZQBXz6eZC2B2meyLZ5xzFJWz3KAw/
	 YWEPDw5YdIsHNuJolJzIQgprGk5EkWHo9pmiSC8MnvSolTqEYjYenSSI9cBUliU9lP
	 9TP+E7VndYVCdJ9ANZpvcoywWMtKW+Bavs8tinyF1FXsuGpMe5s9ZmXCBsLmCZO3IX
	 1YfFi15Ff1PM3LbFIhrz84pQPOeG/nxufxidyPq88WebDIG2fwlhPEwF4Z8arRNVUl
	 hv/UksEnpdhag==
Date: Mon, 19 Oct 2026 13:16:12 -1000
Message-ID: <d9ba33d7358769a98a35eea9d603305d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Reenqueue IMMED tasks when their CPU picks idle
In-Reply-To: <20261017221924.3908922-1-arighi@nvidia.com>
References: <20261017221924.3908922-1-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Andrea.

The following is a Claude-generated review.

On Sun, Oct 18, 2026 at 12:19:24AM +0200, Andrea Righi wrote:
> +	/*
> +	 * Picking idle with IMMED tasks on the local DSQ means that they didn't
> +	 * run immediately, e.g., core scheduling forced the CPU idle. Outside
> +	 * of that, pick_task_scx() would have taken the local DSQ head. As
> +	 * next_class is idle, the rq looks open to rq_is_open(), tell
> +	 * reenq_local() to reenqueue the IMMED tasks anyway.
> +	 */
> +	if (idle && unlikely(rq->scx.nr_immed))
> +		scx_schedule_reenq_local(rq, SCX_REENQ_IDLE_PICK);

The forced-idle CPU is still advertised as idle: update_builtin_idle()
marks it idle right below, and the bounced task's task_cpu() is still
that CPU. A scheduler that trusts the idle state can put the task
straight back, e.g. scx_cosmos for a per-CPU task, which checks
test_cpu_idle(prev_cpu) and inserts into SCX_DSQ_LOCAL_ON | cpu with
SCX_ENQ_IMMED:

1. The IMMED insert calls wakeup_preempt() and reschedules the CPU.
2. The core-wide selection forces it idle again, and pick_task_idle()
   queues another IDLE_PICK reenq.
3. reenq_local() bounces the task again. p->scx.reenq_cnt is reset only
   when the task runs, so after SCX_REENQ_MAX_REPEAT rounds the
   scheduler exits with SCX_EXIT_ERROR_REENQ.

Before this patch, the task waited until the cookie allowed it to run.
With SCX_OPS_ALWAYS_ENQ_IMMED, scx_bpf_dsq_move_to_local() also inserts
with IMMED, so a dispatch can close the same loop.

"Outside of that, pick_task_scx() would have taken the local DSQ head"
doesn't hold for SCX_ENQ_LAST, with or without core scheduling, and the
same assumption was in the v1 suggestion. put_prev_task_scx() runs
ops.enqueue(SCX_ENQ_LAST) before set_next_task_idle(). If that inserts
the task into the local DSQ with IMMED, nr_immed is 1 here and the task
is bounced, although set_tsk_need_resched(next) was about to run it.
ENQ_LAST schedulers using IMMED would take an extra reenq every time a
lone task's slice expires. Would triggering from pick_task_idle(),
regardless of rq->curr, work? It runs before put_prev_task_scx(), and
the core-wide selection calls it for every forced-idle sibling.

Also, next_class isn't idle yet when this runs. On the re-pick after an
insert, it's still ext. It's idle by the time the deferred reenq_local()
runs.

> -	if (rq_is_open(rq, 0))
> +	if (!(reenq_flags & SCX_REENQ_IDLE_PICK) && rq_is_open(rq, 0))
>  		reenq_flags |= SCX_REENQ_TSR_RQ_OPEN;

Maybe update the %SCX_REENQ_TSR_RQ_OPEN description above
local_task_should_reenq() to mention SCX_REENQ_IDLE_PICK?

Separately, a case that neither this patch nor the existing triggers
cover: when the IMMED task at the head of the local DSQ doesn't match
the core cookie but sched_core_find() finds a matching SCX task outside
the local DSQ, the CPU runs that task instead of going idle, and the
IMMED task stays parked.

None of the above has been reproduced. It all comes from reading the
code.

Thanks.

--
tejun
