Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D248E0DB;
	Thu, 10 Sep 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047718; cv=none; b=lrHHnzS7z+TWkWtPAoZb7kgsLXuY1eCH4tTO5qbSDoP5kdfDRZUNBCvYXaGLN24us0LGlxCpXmYYz+DXySelSiMcJmHlaBTQ/Ay5xqkgXgTqtHHeyEAMxQXcDi4E5vto7gtuvhvE/6zbnWxUh7gFDegNPWeASf3inEytdhC+Hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047718; c=relaxed/simple;
	bh=xQxLRxF550yGp+tOB7Nbf4yRJJodema3UjeVrM1qlMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKOnzFp/xql5AVdH8agWs+jUQz5Zk3nCLSe+K1b3Th4PTFEFdtA7O5z42k+Th4zQjIsHRr72I6EjGs74tDEcLnaiX+ijo1it0EZnF2fEkdGh0tdPDjG/Odx5nDif0T0hJl5Hj5atjwqbqtaackB+NnvSIYXTEXccdEfGb6aFnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EMIG831f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMIG831f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lEfV4tg3FVpNhBBaFkMoDkUqZnqsQJHNrX+3eQAG4dM=; b=EMIG831fnQGVUNJDiT4i7QDrm5
	MR9w4OeCq6SdqBvaSEB9Rrc5cncL+NCPpuBpoIujVtz7lEF4KJYfhNMObaHCAzHDfo6sfQcJmDQSy
	UJMBQzJO2efdlh1Ue4ljuPD/CmiEwb/PO4HDUYDp+qgIHyBHTwm5U8cpg6+bZaUQl35nrg49a7pcA
	mRF4JXDQ2nXPyg0CkmzJsFKrGve+s2iF0bj+MxwutVBxI2KiF5herQ1OyX0fpRmVtXGggpkNy3WNt
	OmJywBKdZqtTYtjDpwkm5LJb2VjYULBeu4fI4y55wIrfEZMqYdKIMnX7ZFYXtCN82Ik5m5WSAfbLw
	9OWXRBHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4f27-00000002Y8Y-0ykO;
	Thu, 10 Sep 2026 13:41:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E6F9300400; Thu, 10 Sep 2026 15:41:42 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:41:42 +0200
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
Subject: Re: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <20260910134142.GU776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-16-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-16-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:25PM +0200, Andrea Righi wrote:

> +/*
> + * End retained proxy execution before changing @p's BPF scheduler ownership.
> + * Called with @p's pi and rq locks held immediately before
> + * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
> + * is updated only once.
> + */
> +void scx_prepare_task_sched_change(struct task_struct *p)
> +{
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(task_rq(p));
> +
> +	update_rq_clock(task_rq(p));
> +	sched_proxy_block_task(task_rq(p), p);
>  }
>  
>  /*

> @@ -8027,6 +8108,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  
>  		if (old_class != new_class)
>  			queue_flags |= DEQUEUE_CLASS;
> +		if (old_class == new_class && new_class == &ext_sched_class) {
> +			/*
> +			 * This is an EXT-to-EXT scheduler ownership change, so
> +			 * sched_change_begin() won't end retained proxy execution.
> +			 */
> +			scx_prepare_task_sched_change(p);

Here, see, this is what I was expecting for this thing. Just have it be
always instead of for ext-ext only.
