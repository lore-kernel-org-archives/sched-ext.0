Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708897;
	b=LRzM3ei8B+Y8bNLPeRTe5UvcPsCV9yiwN/E+2YaNGl1D4zBicByq+/IT05fv+0HnGGbp
	 BjSWXVArXHOEomvHvareEPTFc/3poefpOvLEF8mPZ7oTTKKixbwf84LqL7rJU/V66Pa69
	 0B7QQ0MnTWEns59NGGr9rAwtW8ePddN9zfZxS7Rrj9LTLQMXcXnt9ahIvUB7w4yAC7cd0
	 aqHqqVDqiC/+GpDeffWI/kubKxl7kBFdv7xTsdqd/vkyrtzQ174yq/TMCEjs5bl+81EvD
	 qcs8JgoXlnIyyOZs8fG2zVq5PKeGaZXzxYAKFLy2IOnJxdsLIpoYIAf0zSdGNK0620g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=I+0p/DOi1/yQUslD6IHt4Ig4oxuCoDb72Zi4u5IuZwY=;
	b=MZzEcwC4lQOFAF7xAL5DCer89jAsWGewnkVSjA8GiYFnfnJbH9E9PlBvbvjwLUrC3ZgU
	 CuegmGZf3MS48X1gTQtb6zMiI4L6spPNyV/51H4Zzjkx37HYAk5HMcX04/raH8HazE8nQ
	 7pWc2VTDF9KyW0gdjZDscur5E1RkR2bVsr6ZhgSuJNvChocxMZ2bWy0oPUEM7WS218dK2
	 R5GDsgJi/7wloMYRz0bwbCsE3f1DcZOpiVRIqaq14Qs9m2iBWfGGst0RIKWf0lsqVocba
	 KfLmwius7obwBvapLIcszoB1Lpg3GTsdH5UHyUXzgJBpZKBptoAy1AUZZcDOoNvPQQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=PUk7d4BP;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA24606A32D;
	Thu, 26 Nov 2026 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA24606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=PUk7d4BP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I+0p/DOi1/yQUslD6IHt4Ig4oxuCoDb72Zi4u5IuZwY=; b=PUk7d4BPYX/VBeB2M27v3SCr8w
	lDuSUKAjqtjkiINNRsBbbDlVk3zqECQuwhbDRWG0PWNaEFmZd3t7psZvkRqiVBGcBWTVWtRkIAYW8
	/+vScuXCihwIM8Rq9n/oypsAoRSlW7/YCSdJhacGvq0MNXEdPjgZbxqaKqZTse9GOkiNYUumDYnGd
	/dTTkimnxxF9/0v2VH1BLBWyyBwnM+PNQUQ8a5/r/zacYWT2kkATUn8EKKhFG0xX7a/CvTu8mKYG+
	bEuIEF7rTZBX2s8l1XYo0sV6qaf9qCahy54t33OCyjx+/VDQWL/KjSF4TDl61zFrcRKlM8QhsCjgG
	6qWO9aNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbua-00000006xDB-4BUM;
	Thu, 26 Nov 2026 16:01:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1967E302186; Thu, 26 Nov 2026 17:01:28 +0100 (CET)
Date: Thu, 26 Nov 2026 17:01:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Tao Cui <cuitao@kylinos.cn>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched: Let switching_to() decide whether to keep a
 retained proxy donor
Message-ID: <20261126160128.GL49833@noisy.programming.kicks-ass.net>
References: <20261126111649.208476-1-arighi@nvidia.com>
 <20261126111649.208476-2-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126111649.208476-2-arighi@nvidia.com>

On Thu, Nov 26, 2026 at 12:13:57PM +0100, Andrea Righi wrote:
> @@ -11200,6 +11213,58 @@ struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsigned int
>  	return ctx;
>  }
>  
> +/*
> + * Block a mutex-blocked task retained on the rq for proxy execution, because
> + * the class it is switching to does not accept blocked tasks.
> + *
> + * sched_change_begin() already dequeued @p from its old class and put it if
> + * it was the donor, so finish the job a sleeping dequeue would have done
> + * without going through a class again.
> + *
> + * The caller holds p->pi_lock, so @p cannot wake and migrate once
> + * __block_task() clears p->on_rq.
> + */
> +static void sched_change_block_task(struct rq *rq, struct sched_change_ctx *ctx)
> +{
> +	struct task_struct *p = ctx->p;
> +	unsigned long state = READ_ONCE(p->__state);
> +
> +	lockdep_assert_held(&p->pi_lock);
> +
> +	if (WARN_ON_ONCE(state == TASK_RUNNING))
> +		return;
> +
> +	/*
> +	 * Hand the donor role back to the execution context before clearing
> +	 * p->on_rq. This is proxy_reset_donor() without put_prev_task(), which
> +	 * sched_change_begin() already did, and without zapping the balance
> +	 * callbacks: nothing redoes them here, and they include the pull that
> +	 * switched_from_rt() or switched_from_dl() may have queued.
> +	 *
> +	 * If @p is rq->curr, __schedule() retained it and dropped the rq lock
> +	 * while picking. Block it like any prev that blocks in __schedule():
> +	 * keep it set, and let the pending pick put it.
> +	 */
> +	if (ctx->running && rq->curr != p) {
> +		struct task_struct *curr = rq->curr;
> +
> +		__put_prev_set_next_dl_server(rq, p, curr);
> +		curr->sched_class->set_next_task(rq, curr, SNT_PICK);
> +		proxy_set_curr_donor(rq);
> +		ctx->running = false;
> +	}
> +
> +	p->sched_contributes_to_load = task_state_contributes_to_load(state);
> +
> +	/* The DEQUEUE_SAVE in sched_change_begin() skipped these. */
> +	sched_info_dequeue(rq, p);
> +	psi_dequeue(p, DEQUEUE_SLEEP);

Should we assert DEQUEUE_SAVE was set? I mean, it should be, but afaict
nothing screams if someone forgets? And with these changes on, it will
go a bit funny.

> +	__block_task(rq, p);
> +
> +	ctx->queued = false;
> +}

Other than that, this looks good. Let me go read the next patches.
