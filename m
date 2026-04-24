Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CB346E43;
	Fri, 24 Apr 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051053; cv=none; b=W7qiz1+jcs6BK794vD6DJA62PuVAVU1NubL3lZEbQikGuKjsIL7d6n3GiQvQJxaOhTQnL8vd+GZL3Iwv54/W7GPjJKUUqSoWkvtF5TiaGJ0SVHNhKCnCIUkL7DwPTvhDf7A3VhZU8+LRXJSUEuQRLJoI/l3CMwcqU7DMB/lb6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051053; c=relaxed/simple;
	bh=WHMxlc/ot88v83RgCl3M5oF2N6A18v7hQt5MeR3eEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoSn0dt4FvNH1mpkSf/uTD1eGL/gYSgniKXFOFasgADhaEXnwl+vmm1QBLVQjgR4emXQY4H9uRqzEGKfY/3XFO0C/wXh70X2ZNJIjdcIDCGsPftlub8bEPSoLv4x3QLA85UwzGg9zGAflZj0wN0yEzISjkm9UDCAcfqyNBS1LEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtUbUtUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtUbUtUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E8C2BCB5;
	Fri, 24 Apr 2026 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051053;
	bh=WHMxlc/ot88v83RgCl3M5oF2N6A18v7hQt5MeR3eEO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtUbUtUPnHK3Nqvy06UtPCtKcrmsxuWQL7G82NQgCSlWrQ9G+BgwoSs+tsPyoVu+K
	 8Nh2FxEFlftMiQv9jWDpARTCNiYvOgz8bS4s+vOjtoXP5yKRfOp+4oxksishMLC1ki
	 kQCt3qp8HMWOJifoil+6UgkOEOshJ10dnWCW9d3xVmziALd8Po8wxrntGGW4oL0XjD
	 F6aenwe/gkIecstk15DeblapAVk8/+keY36j8jT9lVyYUg2U9STXyZvZwvAZAAEy0I
	 e2yCDLLBDP+FyD4dgxSjwkfzmGj4c9LamBVJf15t5LjUweumGEsg7HnWvXzQDWpYew
	 ZrTr/NThCP/DQ==
Date: Fri, 24 Apr 2026 07:17:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Call wakeup_preempt()
 in local_dsq_post_enq()
Message-ID: <aeulrBs6ZAopfcHG@slm.duckdns.org>
References: <20260424092245.3212529-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424092245.3212529-1-jpiecuch@google.com>

Hello, Kuba.

On Fri, Apr 24, 2026 at 09:22:44AM +0000, Kuba Piecuch wrote:
> @@ -1408,11 +1407,19 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
>  	    rq->curr->sched_class == &ext_sched_class) {
>  		rq->curr->scx.slice = 0;
> -		preempt = true;
> +		resched_curr(rq);
>  	}
>  
> -	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
> -		resched_curr(rq);

Hmm... I don't quite understand this part of the change. sched_class_above()
got separated out into its own case but why is it dropping resched_curr() on
SCX_ENQ_PREEMPT?

> +	/*
> +	 * If @rq->next_class is currently idle, we need to bump it
> +	 * to &ext_sched_class using wakeup_preempt(). Otherwise, if we drop
> +	 * the rq lock later in the pick and an RT task wakes up on @rq,
> +	 * wakeup_preempt_idle() will be called during RT task wakeup and
> +	 * SCX won't have an opportunity to re-enqueue IMMED tasks from @rq's
> +	 * local DSQ.

As this was really subtle, I think it warrants documenting all cases here.

Thanks.

-- 
tejun
