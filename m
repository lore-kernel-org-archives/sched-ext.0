Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B73E3DB0;
	Thu, 28 May 2026 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968200; cv=none; b=iV/XKf9DQJjAivUGwBKmOKX71KXu5VYlrkOvYtysXf/HxrB/w5QulYxX6guNKFOWOAzYbvx1CuvbkAQ71FV61MdHsTXslW6/zMm67fONBpzjKBmy3SotsLeUbLbz4ffUIYP9BiUR3oGl2/6kZzPvfnxdGsAhIHPDchvBTUPrmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968200; c=relaxed/simple;
	bh=eY6zRG8qwqs6YTk58GwBsYPRSIHeXoO+SEMNXDg6y4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R45t74Aj2E6EACVB1IxB6oIE0kmcCIWYlZTSci9/TL73GOI77J4eVO35Eu3LMBg0wn27EoyKW9LCw1KqKVDhksJ1gIpNUe/iTtwPQjFPdjhaJUsO+9AY6PcNmndxp7hbb8Mw8VUudEJ9wuzABAAOJOPqWjMU9wVWAP9ARw/+dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CKQ3IrhV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKQ3IrhV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=41E9o/+rJy1836eshpDTX+Ea/HUQ3SrPiOU4MW8MUYo=; b=CKQ3IrhVV/Y3pPajFVVXbhJ/zN
	2TvzsH1f6UvfYKnWce3hcjfGIhFJyKXpd+kEAhM6QCj1p7C9wYtfKSQY57F0uFXdp+NfLndlDwBlz
	+Aw9mQ1Vp9cHAM9raOHy2d5pdq5g3M/P8EWJZVhpjny+zzW0k90nZmkA4KQTTy38H69fnMVh0zczs
	iOJ3eAjG4R0Q9Cc27680v+03xdYQBMmjDnoZaiXDWZdTXUfY8CZSGzIgi9FeHZ17x1YjGEtQLZrca
	mOQ2PhFgLx401MlszL+0VbwzFi8sbOrTWBIGMYi6bju5My5bf/7NgsCWZNrOroJKYgeenWqjcsvrQ
	TOa0aFiQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSZ2D-0000000GI5K-1JoI;
	Thu, 28 May 2026 11:36:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D26A300CB5; Thu, 28 May 2026 13:36:21 +0200 (CEST)
Date: Thu, 28 May 2026 13:36:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Message-ID: <20260528113621.GE3493090@noisy.programming.kicks-ass.net>
References: <20260526164420.638711-1-arighi@nvidia.com>
 <20260526164420.638711-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526164420.638711-2-arighi@nvidia.com>

On Tue, May 26, 2026 at 06:42:48PM +0200, Andrea Righi wrote:
> @@ -6187,10 +6190,34 @@ static void scx_root_disable(struct scx_sched *sch)
>  	/*
>  	 * Invalidate all the rq clocks to prevent getting outdated
>  	 * rq clocks from a previous scx scheduler.
> +	 *
> +	 * Also re-balance the dl_server bandwidth reservations: detach
> +	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
> +	 * was previously detached because we were running in full mode.
> +	 *
> +	 * Unlike the enable path, this runs on a recovery path that cannot
> +	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
> +	 * bandwidth and reclaim it for fair_server under the same dl_b lock.
> +	 *
> +	 * The swap can still fail with -EBUSY if someone bumped ext_server's
> +	 * runtime via debugfs between enable and disable; in that narrow case
> +	 * both servers end up detached and we just WARN.
>  	 */
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
> +
>  		scx_rq_clock_invalidate(rq);
> +
> +		scoped_guard(rq_lock_irqsave, rq) {
> +			update_rq_clock(rq);
> +			if (was_switched_all) {
> +				if (WARN_ON_ONCE(dl_server_swap_bw(&rq->ext_server,
> +								   &rq->fair_server)))
> +					pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);

One option here, with the swap, is to reduce the fair servers bandwidth
to match the outgoing ext server. Then at least you end up with the fair
server running, rather than having it completely stopped.

But this is going to be a rather rare occurrence, and people will have
to go poke at the debugfs controls anyway if this happens, so maybe
that's just not worth the effort.

But I wanted to mention it...

> +			} else {
> +				dl_server_detach_bw(&rq->ext_server);
> +			}
> +		}
>  	}
>  
>  	/* no task is on scx, turn off all the switches and flush in-progress calls */
