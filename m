Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E62F4A16;
	Wed, 16 Jul 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670301; cv=none; b=F6ImJt9Q8u7KT4MJBqQWgunj826TZ2wyEaQKZIZ/CURknm5HLQmH4EMhqZ0F7T+BNwdT8ghHgOGVYBR9LiAHG5DK6jwfeWQqgiYkbIPIBS+UnauLW/QAS7RsofL8L7G3SMJDVQS5dJXP6NifJKcuPdRhPspZzclT/t70Jt5O21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670301; c=relaxed/simple;
	bh=mMvWaLNOwtl8MXi1ChoYu02nFr3kiqf+L6ufzBWr4MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gauZx0QHyptzpAtipO1qsr4fBDiiD+/2gYH7sHWsjlvRzR+gdoahrnlSlSVgq6X+pebva3hPESOnE4l0HKF9xoLJGCLD5yETorGbFH09rFvgJ1AwfANdusHJ29kUXToAZwtBn4Z+ez93IKNpBIZiujo5LCl1sxkwkbB1p6z3TTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iV94vVxm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iV94vVxm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ofeIGZ8x5KoMgSaejtDVRToiFCJTnfX/7IoKzW3fTa8=; b=iV94vVxmRr6Qdcjtg0dyNjtu5R
	sdoPNd7SBTvXfrqPAYUbispvthgeggoNGrfH/MnzuqHW4vqh01nLwEUFdte0WPVLaO0il3VJAMcNJ
	JRtrtUkXGUGMf5ALms4acNlEb4qyOnl7NZO8EFRFzJxalvIpZTs2XcflUB7RyhbJTU62tG0dCWCZu
	hPaFli5uGJZvFDSDvFyi4EHoBMaRScN3RulBNJLywGvqfBCsI7N/IgEC8TCi2Lrg4lF2VSg6zAwnp
	IeewslqiN9ZeZBlteFaN5+PP5A9jKM3oSIF9AjOXAi4H6+BWlR/hx6ElAc6zuMio0dWZ574495v5j
	Jrz07ZiA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1bd-0000000A6IQ-1XUt;
	Wed, 16 Jul 2025 12:51:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3E94300186; Wed, 16 Jul 2025 14:51:28 +0200 (CEST)
Date: Wed, 16 Jul 2025 14:51:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716125128.GX905792@noisy.programming.kicks-ass.net>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>

On Wed, Jul 16, 2025 at 05:46:15AM -0700, Breno Leitao wrote:
> __this_cpu_write() emits a warning if used with preemption enabled.
> 
> Function update_locked_rq() might be called with preemption enabled,
> which causes the following warning:
> 
> 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> 
> Disable preemption around the __this_cpu_write() call in
> update_locked_rq() to suppress the warning, without affecting behavior.
> 
> If preemption triggers a  jump to another CPU during the callback it's
> fine, since we would track the rq state on the other CPU with its own
> local variable.
> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> Acked-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d867ba210..24fcbd7331f73 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
>  	 */
>  	if (rq)
>  		lockdep_assert_rq_held(rq);
> +	/*
> +	 * __this_cpu_write() emits a warning when used with preemption enabled.
> +	 * While there's no functional issue if the callback runs on another
> +	 * CPU, we disable preemption here solely to suppress that warning.
> +	 */
> +	preempt_disable();
>  	__this_cpu_write(locked_rq, rq);
> +	preempt_enable();
>  }

This looks dodgy as heck. Why can't we do this update_locked_rq(NULL)
call while still holding rq? Also, I don't seem to have this scx_layered
thing.
