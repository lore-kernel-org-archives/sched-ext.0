Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257033B8D45
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496123; cv=none; b=VEJpf+6UvI2t3c1kAzHLoPUggByzswv94gZaJwSPvLyaLZskErA3fWfB3TaralpZs+k888lFgZVNgudljGLjTFu1JZWwYqPLtuIDUiMMuPFRxAE/R0meSJh8rmOeuAADOeidS34Dam+Xwpp1ZlBNTadjIKiRLYT2DsnpBIm9tGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496123; c=relaxed/simple;
	bh=nE0ptUaJoZ0D70tR2zcMW1PUDWE9EIvrtz2wJsf5LMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZczSWF8yjFioYeXmCgOBYm0uGq0mDF1g7ArlLgc2knPk4BfWxVNaZB9x+xjzlHAc3+sYVHVq/qXe5lkf+K049v5XGTumUwEUXN9rM8u/iq1Diszqo0jiYcrhJkKOK7b/QTKgPX0rVJSoDU7j2947tWFIJoy/E6L4sxEv5pt8/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347A81063;
	Thu, 11 Dec 2025 15:35:14 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C503F740;
	Thu, 11 Dec 2025 15:35:19 -0800 (PST)
Message-ID: <b53f8ef6-9cac-4b95-8ebb-0f498d02f4ac@arm.com>
Date: Thu, 11 Dec 2025 23:35:17 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251211224809.3383633-3-tj@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251211224809.3383633-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 22:48, Tejun Heo wrote:
> move_local_task_to_local_dsq() is used when moving a task from a non-local
> DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
> without going through dispatch_enqueue() and was missing the post-enqueue
> handling that triggers preemption when SCX_ENQ_PREEMPT is set or the
> enqueued task should preempt a lower priority task.
> 
> This was fine when the function was only used from consume_dispatch_q()
> where the CPU is already vacant and looking for the next task. However, the
> function is now also used by move_task_between_dsqs() which backs
> scx_bpf_dsq_move() which may be called while the CPU is busy.

When was this changed? I couldn't find the commit when looking briefly :/

> 
> Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
> dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
> early exit to keep consume_dispatch_q() behavior unchanged and avoid
> triggering unnecessary resched when scx_bpf_dsq_move() is used from the
> dispatch path.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -981,6 +981,14 @@ static void local_dsq_post_enq(struct sc
>  	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
>  	bool preempt = false;
>  
> +	/*
> +	 * If @rq is in balance, the CPU is already vacant and looking for the
> +	 * next task to run. No need to preempt or trigger resched after moving
> +	 * @p into its local DSQ.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		return;
> +
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
>  	    rq->curr->sched_class == &ext_sched_class) {
>  		rq->curr->scx.slice = 0;
> @@ -1629,6 +1637,8 @@ static void move_local_task_to_local_dsq
>  
>  	dsq_mod_nr(dst_dsq, 1);
>  	p->scx.dsq = dst_dsq;
> +
> +	local_dsq_post_enq(dst_dsq, p, enq_flags);
>  }
>  
>  /**
> 

