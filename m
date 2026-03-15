Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762542AA9;
	Sun, 15 Mar 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773565087; cv=none; b=LbUTEFgcknaUHBjuxPqQuD1piq0dSVPHADaKw16SAXPrEY9+TOukk5pMQXYWEozwVBSDfbk0VhAbztPDxUZgw+Me8jJCcOerhXg5e0dj6CQdzaZSjCvOEoGuaqOqtfim8aJTZyp4BarZTZQ4isrkBDZ+MqAodYRB5mh2WRHqlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773565087; c=relaxed/simple;
	bh=DGLZxbgMt8PKTNjGHdKNr4RiWJNhoHbCDBjjV69f9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTtPiuRLSwTLqgLz0/JQIcbTGfjqpltWGswNGY+fq0FustPiDYl/xalAXY9ycsmf8n2fBaBcsi9IPPbWiD6ORzih72+WbMtQIYqiQZwhEgTEgeathcMyUJdwHu86ssKABS19jbH3mXpw9u7BquFV7kayPYZlsWrwMBfOYNKQfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u46yTCdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u46yTCdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC54C4CEF7;
	Sun, 15 Mar 2026 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773565086;
	bh=DGLZxbgMt8PKTNjGHdKNr4RiWJNhoHbCDBjjV69f9fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u46yTCdV6RB2B5+T3/ISGLWHAay6bNvdHIHSKbsXS2hn412/oe4FqbbICk7UNyDbC
	 SV/yecCIiZL9No31YjCPKWzB06Lt12LxziKBohsBMW0ZYk5cDPf5batQ4mhGlmtczb
	 M0NMnnepDC4jwNEJCWbgstAU562LVddmlNws5dmzSq+QdK414SRGb9VJuC2e4mpV+d
	 VJbI1nw00LDLTGmOJUkIo/Kab+a0FGzD2sRoWcnVLQB6wI21xSXj/lPLrB+4fPwERs
	 +6pttAk0C6P/y18HOYleQeSrtr8QUysavw3sdvYmvHEUX37NLYocp0ag+piaE++Q+/
	 UmAq/NaCoh/yA==
Date: Sat, 14 Mar 2026 22:58:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Reduce DSQ lock contention
 in consume_dispatch_q()
Message-ID: <abZ0nerzU1j19BEG@slm.duckdns.org>
References: <20260314235231.684671-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314235231.684671-1-arighi@nvidia.com>

Hello, Andrea.

On Sun, Mar 15, 2026 at 12:52:31AM +0100, Andrea Righi wrote:
...
> Benchmarks that generate many enqueue/dispatch events (e.g., schbench)
> show around 2-3x higher throughput with most of the scx schedulers with
> this change applied.

Can you share more details about the benchmark setup and results?

> +	/*
> +	 * Use trylock to avoid spinning on a contended DSQ, if we fail to
> +	 * acquire the lock kick the CPU to retry on the next balance.
> +	 *
> +	 * In bypass mode simply spin to acquire the lock, since
> +	 * scx_kick_cpu() is suppressed.
> +	 */
> +	if (scx_bypassing(sch, cpu)) {
> +		raw_spin_lock(&dsq->lock);
> +	} else if (!raw_spin_trylock(&dsq->lock)) {
> +		scx_kick_cpu(sch, cpu, 0);
> +		return false;
> +	}

But I'm not sure this is what we wanna do. If we *really* want to do this,
maybe we can add a try_move variant; however, I'm pretty deeply skeptical
about the approach for a few reasons.

- If a shared DSQ becomes a bottleneck, the right thing to do would be
  introducing multiple DSQs and shard them.

- This likely is trading off fairness to gain bandwidth and this approach
  depending on machine / workload may lead to severe starvation. One can
  argue that controlled trade off between fairness and bandwidth is useful
  for some use cases. However, even if that is the case, I don't think
  trylock is the way to get there. If we think that low overhead high
  fan-out shared queue is desirable, it'd be better to introduce dedicated
  data structure which can do so in a controlled manner.

Thakns.

-- 
tejun
