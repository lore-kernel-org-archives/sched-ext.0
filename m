Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3C455176;
	Thu, 10 Sep 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036712; cv=none; b=MPv7IqTPyM9n1bW+LwMThvCGUp+uZzFqs6zgs1hRV2INFfWjsUD41U/uReE2vgStu4lNAg22vWDD4J5t8TNG4Ufbho0yecfuB8HuRUry9jxz7L1XjLfcAFv8Vt6QCGCGO/puut4uGileW2H85NecS28QxguG+cF1O17T/BepvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036712; c=relaxed/simple;
	bh=6vnFr65x8+MgNoAd6e1I2W0+ljuPVyeuH7FB4u4TqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQfh0tFdVLSLR3/sl5Z4BLulIfS408cgSR7wlMTIH7WH+D44npi9BPVYc7CzSS6reoPsj+QACJmvCmSxg5ajEHiVK2Butn7NywE1w0u+N6ACiAwU/yJjtcSZaSh4bOsnn1XLDEeSRNamdBX+BjivwxffIFa6W658Azu68YccOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m3IDpAg2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3IDpAg2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8r6IyBpcLFd8eGwMl+s54hpnssHIQXxQVO6P+3A6Prw=; b=m3IDpAg2cgu9vNfEQuM6yRy89t
	AN7pCCLryAK2Kk0m6xGaKH16hg/sCyUyemYjV5junlTsQHHkRGF09Bm63B3T9lvAJlKNx9rtqSfIj
	UHTuxpejXUxqjsDHDuxPNAednXrfqq2h/hueZhJB0Cw3Y3Jm1Lbrby7DTDYg5iB47O3vw032RN8aQ
	+C7ZgnysoKl/BQKba0UyHjTF748+/1haYQyGQFRLIE1WHg/paNVAF+LeYBVzIOnGJxIBqYDFq28E9
	FcSNFv5QmsrXAwz/Sd2wRIIY00GAcMgE/77nMph25oU03jsO3et0Rz5sGm5gmM3B1h4D5CLfbvHR7
	P3Lk/PFw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4cAd-00000002LAx-3QFs;
	Thu, 10 Sep 2026 10:38:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60A4B30056B; Thu, 10 Sep 2026 12:38:18 +0200 (CEST)
Date: Thu, 10 Sep 2026 12:38:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/18] sched: Add sched_ext hooks for proxy execution
Message-ID: <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-8-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:17PM +0200, Andrea Righi wrote:
> Proxy execution splits the scheduling context (the donor) from the
> execution context (the lock owner). sched_ext needs to observe that
> split at three points in __schedule():
> 
>  - whether a blocked EXT task can be retained on the runqueue as a
>    donor,
>  - when a donor's scheduling context starts driving a lock owner,
>  - once proxy resolution has settled for the current pick.
> 
> Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
> scx_proxy_resolved(), and add their call sites in __schedule(). The
> implementations are empty here and are filled in by the sched_ext
> changes that follow, so that all the sched core changes needed by proxy
> execution stay together in the preparatory patches.
> 
> SCHED_PROXY_EXEC still depends on !SCHED_CLASS_EXT, so the new hooks are
> inert: they are compiled out with CONFIG_SCHED_CLASS_EXT=n and
> unreachable otherwise.
> 
> This is a preparatory change to support proxy execution with sched_ext.
> No functional change.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c    | 12 +++++++-----
>  kernel/sched/ext/ext.c | 13 +++++++++++++
>  kernel/sched/ext/ext.h |  6 ++++++
>  3 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bb79fcfa21cd2..d578dd635f2eb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7217,13 +7217,12 @@ static void __sched notrace __schedule(int sched_mode)
>  		}
>  	} else if (!preempt && prev_state) {
>  		/*
> -		 * We pass task_is_blocked() as the should_block arg
> -		 * in order to keep mutex-blocked tasks on the runqueue
> -		 * for slection with proxy-exec (without proxy-exec
> -		 * task_is_blocked() will always be false).
> +		 * Keep mutex-blocked tasks on the runqueue for proxy execution
> +		 * only when their scheduling class allows it. Without proxy
> +		 * execution, task_is_blocked() always returns false.
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> -				  !task_is_blocked(prev));
> +				  !task_is_blocked(prev) || !scx_allow_proxy_exec(prev));
>  		switch_count = &prev->nvcsw;
>  	}
>  
> @@ -7244,6 +7243,7 @@ static void __sched notrace __schedule(int sched_mode)
>  			}
>  			if (next == rq->idle) {
>  				zap_balance_callbacks(rq);
> +				scx_proxy_resolved(rq);
>  				goto keep_resched;
>  			}
>  		}
> @@ -7264,6 +7264,8 @@ static void __sched notrace __schedule(int sched_mode)
>  			donor->sched_class->put_prev_task(rq, donor, donor);
>  			donor->sched_class->set_next_task(rq, donor, true);
>  		}
> +		scx_proxy_donor_start(rq);
> +		scx_proxy_resolved(rq);
>  	} else {
>  		rq_set_donor(rq, next);
>  	}

Can you expand on the need for scx_proxy_resolved() ? I understand the
other two, but this one I'm struggling with a bit.
