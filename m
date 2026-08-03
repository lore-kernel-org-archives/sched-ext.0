Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BC2ECD3A;
	Mon,  3 Aug 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789318; cv=none; b=MV7VMtcreu6JqX2Orp7oQJ9m4WCeiqA5GGGFckyMU/u1DjBI0/qSUS8oxtIwE9Sk4fokWpv4ftXoV/vgM5fIgAmHVWvSJweyE/R/h3tONgWhPzvtdTYwzQN+QwW99rc7DawBZQ09uC2AjwsDI61cCqNid0nm69BC+2FePA2IytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789318; c=relaxed/simple;
	bh=GzSnHAUB08spuwArpDjSB8L7Rp2P1SLODThSebNm0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUu7QXIk1o1jgLf6tHGFuNEiQmC1JEhaXaBj9RpvlVI3DwyncqOfFpanKgsM8OI1gLLX+EHH04ZxWezllm2oqXXY3kG3S5f+QgFuRUP8KqTX9Qc+VRy/j7MGenTiaD52C4/fsRnIdGBeiATZ3THWVYEnplb9Gv4yu1nzNwnFJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSmw4VId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSmw4VId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D4A1F000E9;
	Mon,  3 Aug 2026 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785789317;
	bh=uk+4yRNP0Rm/dnrNFdFgKcuY5sozpDdPOZvYdYllFoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSmw4VId3rUNNpNxosdrLSyGVRQJAOQsPejVmDDiEl1ptSwW2Jl6lDlhSmm6itEOh
	 vBqCWXLV2o4Ic4ZzfZyVNX+QxGzZvFPy1P9caaRPtxae21KEQFKqIpXSbD6BlUAjqJ
	 eprU2/CBLQcJI+8la+rte6nj75cb3QaK+5ANg3S4P9tUDjf8210dnkE/E4/YYlXcKZ
	 0wHzPlbbZhUVcV++elkcpn6YBTQn1S5ep9k5OFjexLlsMIanSVvn+7xU2UcKurTzK6
	 A+tqOFpRIm9DwQsZCdDqqBG7rTeP7gBjzK5AFvDvt1RvcJ6ICUutPKZ+Wd0/apVw48
	 +ZTJjNkHFokgw==
Date: Mon, 3 Aug 2026 10:35:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <anD7hCGZ5v1TggPd@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-10-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-10-arighi@nvidia.com>

On Tue, Jul 28, 2026 at 05:43:27PM +0200, Andrea Righi wrote:
...
> +static void scx_reenq_reject(struct rq *rq)
> +{
> +	LIST_HEAD(tasks);
> +	struct task_struct *p, *n;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (list_empty(&rq->scx.reject_dsq.list))
> +		return;
> +
> +	/*
> +	 * Move tasks to a private list so a task re-rejected by
> +	 * scx_do_enqueue_task() below isn't revisited this round.
> +	 */
> +	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> +		u32 reason = p->scx.reject_reason;
> +
> +		/* migration_pending tasks should have bypassed to local DSQ */
> +		if (WARN_ON_ONCE(p->migration_pending))
> +			continue;
> +		if (WARN_ON_ONCE(!reason))
> +			continue;
> +
> +		scx_dispatch_dequeue(rq, p);
> +		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
> +
> +		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> +			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> +		p->scx.flags |= reason;

Can you separate out code movement and actual changes into separate patches?
Even for relatively simple changes, combining move and changes adds
significant unnecessary review friction.

Thanks.

-- 
tejun
