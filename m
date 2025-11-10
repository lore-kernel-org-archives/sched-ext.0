Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCC2F83AB;
	Mon, 10 Nov 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802508; cv=none; b=CIgXBr+3VNkPPLnGSj/aKpCAtKXEXFuI/JVl+LIem+zX939MhZAP6YR3y/7WmYZBBy/RL7/LF6zKMOleQuUB0yaawhj6TBAGgWyorOMNeR9Mhk42CNQ8zG+xy5s5xa0wHBT9FPPJELZhUBxMJVWvW7g2mC8/UjxD1+jF5hePlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802508; c=relaxed/simple;
	bh=BpiB3Jqw/O9NILP1Qrckoo0KtLBu7dQiPmSMa7xAZfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+1l5t80gTpeTgyBcFVzbCRzVwZpOP5vHIwgWCO8AK1tBxiJw29GewECF0yT7WtPBPbeHkYavIhQ7URAaerKhCaYC+r3mEf5IMwRnhXAw76BHcr6Sd0GTINT0p4YDeUbSoD072QboIPZUC3HUpI8FjWuSEhwg26FhSh5ErZ8j0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA5BJQ3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA5BJQ3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE10C19423;
	Mon, 10 Nov 2025 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762802507;
	bh=BpiB3Jqw/O9NILP1Qrckoo0KtLBu7dQiPmSMa7xAZfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lA5BJQ3H2kzOgzP3FhHyboF6Il23ry2J/7I2Cueuq2tvlr92f352/QH9pCkbZjQMo
	 957Zj7WdSGqLQKRnyyjBEorn/XwR0uhDCHv4trD3SxV7+U6XvY3w8vwcqBHxdZ5ip4
	 GL2ZX8Rdkez5M7t6vk04B68COl4Qu9DZm0blQQDXJMMMvtztnPDAdmQyAz069cF/Af
	 Ti+g0Yg+VoXxYA+v4Sm8hV+WCBaQ7dQvJM4ZXXJ3jq9+7fL04+CGfQSONbBKIibKqY
	 azDld9sukbgpe3U/k8F861V34yv1abP+PwFg5/ahQcyl2MTPfg6cs7ur2BrsqYl83v
	 5KxYa8v8wyX2g==
Date: Mon, 10 Nov 2025 09:21:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode
Message-ID: <aRI7SpAS_CQeS-Ph@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-14-tj@kernel.org>
 <aRGyo6M9AbInZTkb@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGyo6M9AbInZTkb@gpd4>

Hello,

On Mon, Nov 10, 2025 at 10:38:43AM +0100, Andrea Righi wrote:
> > @@ -965,7 +980,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> >  		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
> >  
> >  	if (!is_local) {
> > -		raw_spin_lock(&dsq->lock);
> > +		raw_spin_lock_nested(&dsq->lock,
> > +			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
> > +
> >  		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
> >  			scx_error(sch, "attempting to dispatch to a destroyed dsq");
> >  			/* fall back to the global dsq */
> 
> Outside the context of the patch we're doing:
> 
> 			/* fall back to the global dsq */
> 			raw_spin_unlock(&dsq->lock);
> 			dsq = find_global_dsq(sch, p);
> 			raw_spin_lock(&dsq->lock);
> 
> I think we should we preserve the nested lock annotation also when locking
> the global DSQ and do:
> 
> 		raw_spin_lock_nested(&dsq->lock,
> 			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
> 
> It seems correct either way, but without this I think we could potentially
> trigger false positive lockdep warnings.

That'd be a bug. I'll add an explicit WARN. I don't think falling back to
global DSQ quietly makes sense - e.g. global DSQ is not even consumed in
bypass mode anymore.

> > +		/*
> > +		 * Moving $p from one non-local DSQ to another. The source DSQ
> > +		 * is already locked. Do an abbreviated dequeue and then perform
> > +		 * enqueue without unlocking $donor_dsq.
> > +		 *
> > +		 * We don't want to drop and reacquire the lock on each
> > +		 * iteration as @donor_dsq can be very long and potentially
> > +		 * highly contended. Donee DSQs are less likely to be contended.
> > +		 * The nested locking is safe as only this LB moves tasks
> > +		 * between bypass DSQs.
> > +		 */
> > +		task_unlink_from_dsq(p, donor_dsq);
> > +		p->scx.dsq = NULL;
> > +		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
> 
> Are we racing with dispatch_dequeue() and the holding_cpu dancing here?
> 
> If I read correctly, dispatch_dequeue() reads p->scx.dsq without holding
> the lock, then acquires the lock on that DSQ, but between the read and lock
> acquisition, the load balancer can move the task to a different DSQ.
> 
> Maybe we should change dispatch_dequeue() as well to verify after locking
> that we locked the correct DSQ, and retry if the task was moved.

Right, this is a bug. The LB should hold the source rq lock too. Let me
update the code and add a lockdep annotation.

Thanks.

-- 
tejun
