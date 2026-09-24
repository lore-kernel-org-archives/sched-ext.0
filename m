Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2A43A7E9;
	Thu, 24 Sep 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236296; cv=none; b=doBDgEf6H0N2A1ngPIPQIDDv5c49VN5ioTKyLXSt0RJ6GP4b8TeNS4afLuvtQO0y/sRMfAzai9DLGCciRLdJEAEzGNRDivGM6rHoPD1OmznunoKKIZZGsv80jaRrWB1OF7pAvCUyul02aIo21hQOgyBRM5zmP3JTpKd1wFA29ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236296; c=relaxed/simple;
	bh=2Gc3xaIe85+L9ZRUEyTbQRf5F8toGHzPsdYvmEe05V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddg8eoqQ5vWAJrwVaAcPNHMaAJhiYWskgaXFpEcwxai7Z7RLjSYmzTiIFMxpprqmStrbe4XF60AqKDIlFIoSHeB/DGeAJU6cz411rsYYz5JbWBJ7zU7nNH+KYmAkxImQhC1pSa58IL/hcdj+zFb9ADSTePbpERIusOuo+8zWCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g/nraA/D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g/nraA/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJ4xBM6zEv7n3jH3x+/IK13F+D7pCvGlbkUP3NLkJNE=; b=g/nraA/DtUUzS5WHOdLX+99sJU
	NDuvKrlX9eiOgENS187OfhWuVHycoXRe+K3ObUJnxGoGMWE5Co7WMEpfMk/2tY2Uz90d6GOu4Kkg3
	YrxUXFAb0lWfBPY4zu+XBgQYdXm1fpsbY+zL41gZ7AJRJrXQSF6iNhr/EgJNRdhADnzEidFb++z3h
	8El75TkkLbdNIvL8Hha3MHUPMVa+sgMwgwJT/VQFuZuhKMCBns7IqFUZZ23mgp1CNgkW8+GJtzk99
	MVu82mMrvbb/a9u3zjYP71bAdlAGvo8QNUY4dl7XmkhTv2Bqjs5P4igg/mXq53rCDk/JgeWYpouCM
	eHaOTkQg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9eEX-0000000Fg6K-3AC4;
	Thu, 24 Sep 2026 07:51:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBE12300756; Thu, 24 Sep 2026 09:51:07 +0200 (CEST)
Date: Thu, 24 Sep 2026 09:51:07 +0200
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] sched: Add sched_ext hooks for proxy execution
Message-ID: <20260924075107.GC4121339@noisy.programming.kicks-ass.net>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260922165445.943315-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922165445.943315-6-arighi@nvidia.com>

On Tue, Sep 22, 2026 at 06:51:44PM +0200, Andrea Righi wrote:
> Proxy execution splits the scheduling context (the donor) from the
> execution context (the lock owner). sched_ext needs to observe that
> split at three points in __schedule():
> 
>  - whether a blocked EXT task can be retained on the runqueue as a
>    donor,
>  - when a donor's scheduling context starts driving a lock owner,
>  - after proxy resolution, when deferred reenqueue work that was blocked
>    by an active proxy relationship can be retried.
> 
> Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
> scx_proxy_reenqueue_retry(), and add their call sites in __schedule().
> The implementations are empty here and are filled in by the sched_ext
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

> @@ -7243,6 +7242,7 @@ static void __sched notrace __schedule(int sched_mode)
>  			}
>  			if (next == rq->idle) {
>  				zap_balance_callbacks(rq);
> +				scx_proxy_reenqueue_retry(rq, next);
>  				goto keep_resched;
>  			}
>  		}
> @@ -7263,6 +7263,8 @@ static void __sched notrace __schedule(int sched_mode)
>  			donor->sched_class->put_prev_task(rq, donor, donor);
>  			donor->sched_class->set_next_task(rq, donor, true);
>  		}
> +		scx_proxy_donor_start(rq);
> +		scx_proxy_reenqueue_retry(rq, next);
>  	} else {
>  		rq_set_donor(rq, next);
>  	}

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f60894dbf0623..aaa6ee66917e8 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

> @@ -1110,6 +1115,10 @@ static void schedule_deferred_locked(struct rq *rq)
>  	schedule_deferred(rq);
>  }
>  
> +void scx_proxy_reenqueue_retry(struct rq *rq)
> +{
> +}

Doesn't match its prototype, also, I'm a little confused about the next
argument in the next == rq->idle case. 

Hmm, you seem to be using the argument like:

  bool proxy = next != rq->donor;

And I suppose that works. But that seems to be about the tick, not
putting current back on a dsq.

> diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
> index 0012f708a5504..cca3f7c97b788 100644
> --- a/kernel/sched/ext/ext.h
> +++ b/kernel/sched/ext/ext.h
> @@ -20,6 +20,9 @@ void scx_rq_deactivate(struct rq *rq);
>  int scx_check_setscheduler(struct task_struct *p, int policy);
>  bool task_should_scx(int policy);
>  bool scx_allow_ttwu_queue(const struct task_struct *p);
> +bool scx_allow_proxy_exec(const struct task_struct *p);
> +void scx_proxy_donor_start(struct rq *rq);
> +void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next);
>  void init_sched_ext_class(void);
>  void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
>  
