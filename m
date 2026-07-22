Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCA459AE4;
	Wed, 22 Jul 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763363; cv=none; b=WR/nnHJOV17GKe4zRArZL7nXOnDzlKTR0ogN8c3L523Absngofc+IrB9XZ8DxdXDKgakJOoMW9WpPKhu5a53oI3iifo5166omslidbMgKn9aHWsmG1Rf2MrOxz4LYO34V4zmU0r4SE10v8oFmi/c6Rt0hHMku5FR3F4kdgbBUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763363; c=relaxed/simple;
	bh=e+aXTC/EB1lGzjC3jXrGbdWGaj9vUga9zpOpdviE86Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=X550G88WGO8JP/3Cr9Z7+K9bsjo7VCQF0tgJ+ESjZR6H+ZjTNvACYKRiSomEFdfWZ9YoFNdyIIlupj/Y13yHORqqTIHhi+zG+hIfBws0AXj/RWS0+dBZ9YmKhoItimeBKo8T2HFDebqw5lDU8LbNLAyIAXHeacCGWewFuD/8mcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD1w2lN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD1w2lN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DE31F000E9;
	Wed, 22 Jul 2026 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763361;
	bh=yF7k/YnuLVzLhPrTMw2CIr44hNwMazZmMpCI9IoD9rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kD1w2lN1pckmCdNM2CWE9NSG2C0+ZR8QP7G9reIgGPu1Vjv1QSv4Z2GwMv1VSrny2
	 pMfMTXXC61llay391uJ9p8UtuH+txoRsQdE59qNenfu7avAUQNui39MdNNio/v4O7n
	 7d64D5iQ9mQXMiLvAhl+y+7PAkxWRX6o1Bm5t4TTpcYH8mIQpesQB4zwTeGw28XnlJ
	 0ojrdlx/pyaaCA7EE8NI7wEyFxn4sFtrX/PvtVHg3kC4ChSO8K//+yXaTjAB41IHih
	 BFxQPmGC/NXh4bbRX+YpvvR+NAuot+s6EtCL3Gq9R2U1uYJj8j/HUs9SVq+aG/BGbw
	 jIvhD03+fNOCA==
Message-ID: <1fa1975601015d95f9f5ab5cf0d95963@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] sched_ext: Fix proxy-exec race in consume_remote_task()
Date: Wed, 22 Jul 2026 13:26:03 -1000
In-Reply-To: <20260721063242.552774-7-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 21, 2026 at 08:31:27AM +0200, Andrea Righi wrote:
> +		/*
> +		 * Proxy execution may have changed @p's running or migration-disabled
> +		 * state while switching rq locks without clearing holding_cpu. This is
> +		 * a kernel-side race, not an invalid BPF placement request, so don't
> +		 * abort the scheduler on failure. Fall back to the global DSQ, where
> +		 * normal consumption filters can select a valid destination.
> +		 */
> +		if (unlikely(!task_can_move_from_locked_rq(p))) {
> +			p->scx.dsq = NULL;
> +			p->scx.holding_cpu = -1;
> +			scx_dispatch_enqueue(sch, src_rq,
> +					     find_global_dsq(sch, task_cpu(p)), p,
> +					     enq_flags | SCX_ENQ_CLEAR_OPSS |
> +					     SCX_ENQ_GDSQ_FALLBACK);
> +			if (sched_class_above(p->sched_class,
> +					      src_rq->donor->sched_class))
> +				resched_curr(src_rq);
> +			switch_rq_lock(src_rq, this_rq);
> +			return false;
> +		}

I don't think bouncing the rejected task to the global DSQ is the right
thing to do. Unlike the existing GDSQ_FALLBACK cases, this fires on plain
mutex contention with proxy execution enabled, so userspace can trigger it
routinely, and the bounce bypasses the BPF scheduler's placement. It also
breaks sub-scheduler containment - when a host consumes the bypass DSQ for
its bypassing descendants, @sch is the host and a descendant's task lands on
the host's global DSQ outside its cap grants.

How about parking the rejected task on the reject DSQ and bouncing it back
through the reenqueue path so that the owning scheduler re-places it? The
two rejection reasons want different timings:

1. A migration-disabled donor can be reenqueued right away. The forced-admit
   path in scx_local_or_reject_dsq() covers pinned admission and the
   deferred irq_work wakes up an idle target CPU.

2. An on-CPU proxy owner should stay parked until it's switched out, or the
   reenqueue can just cycle back to rejection. This needs a callout at proxy
   resolution - the owner is still rq->curr when balance runs for the pick
   that switches it out, so draining from balance alone isn't enough.

That'd make the scan_seq tracking, the resched_curr() and the repeated
consume attempts against an in-flight proxy section unnecessary. The reject
DSQ and scx_reenq_reject() are currently sub-sched only and would need
generalizing.

> +		/*
> +		 * consume_remote_task() may drop @dsq->lock and requeue a
> +		 * rejected task onto this same DSQ. Don't reconsider tasks queued
> +		 * after this consume attempt started. This bounds the retry loop
> +		 * even when the rejected task remains on-CPU.
> +		 */
> +		if (proxy_exec &&
> +		    unlikely(u32_before(scan_seq, p->scx.dsq_seq)))
> +			continue;

If the requeue approach stays, the comment should mention when a task can
get bounced back - proxy execution turning it on-CPU or migration-disabled
while its context is still queued. Also, the condition fits on one line,
ditto the sched_class_above() one above.

Thanks.

-- 
tejun
