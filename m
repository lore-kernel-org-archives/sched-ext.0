Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311742A9D;
	Sat, 14 Feb 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771091774; cv=none; b=t2b/tnNSR94PKHRKNecJUgeWz0mJ3QrX8HefIxgucBmD91e4nH+I8GzkDMU+ooYf193q1sRQRUzHpoYmgZ2M1Ntu1vwkjMvDMBlagf28xv2j4ehUQyBZ7e6aBLky4XpwigogyIVBBdR8yYHn9ToEqAPh0JL5QCbKSo3QcbtzIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771091774; c=relaxed/simple;
	bh=OtrgpB7RSryO8DZqrAfap9oDlbY+j6mER5Kz4NXVmPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET3b4FU6ulwCh3QCs/Bv0uDUcETWaqjYGYsuFWMxzKeHlWpJuYWsChxcMuYP7RaouzBeGiSGeVkMt9719Gtyzh9pcYJ5cCeYmBSmIeGwaJxy5yA0nyDsHvb+LDJQdHLZt5peIkQ2g7pXEGffKTJQ2sr7RfAbF7Hzy2u33go0BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjhRZ0iN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjhRZ0iN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72B1C16AAE;
	Sat, 14 Feb 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771091773;
	bh=OtrgpB7RSryO8DZqrAfap9oDlbY+j6mER5Kz4NXVmPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjhRZ0iNtejSoe0zG5CifEphiihDrUbH8QjZuMKxGwgPdwNMPins0zFdIPpkAXaJY
	 uXAxH5234Kz63d43Yhdhplnjwh6ZWg7Dr7wtqiaA/gn2eFX5rOu5I8dRFz8bLn6+Ct
	 hVCsqsn41vyqZz+EXbdw3ZKsVKjPHyIjH78X1XOBm+9b3nKuJHWi+d513nc9kUXbQm
	 F2flByq+Cffc+xF+n2SlDP0cG31RaeZBxi6fW343XOYlLqpnlk3Cc8oyPosT6LlFhG
	 aSEy3zuGwIpynJG0aBjpVWLDyfpds2jeR//xruy5qLpndNB+9zGByJolBtnp3qWrPU
	 4BfYvtPN2Aqyg==
Date: Sat, 14 Feb 2026 07:56:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aZC3PC2bQNRFNURY@slm.duckdns.org>
References: <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
 <aY4YdW79Y3FBM5jo@gpd4>
 <aY4di9M4BUfutfrw@slm.duckdns.org>
 <aY5Ua_mFijPmRJSi@gpd4>
 <aZBLgiGv6U8xiZlA@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZBLgiGv6U8xiZlA@gpd4>

Hello, Andrea.

On Sat, Feb 14, 2026 at 11:16:34AM +0100, Andrea Righi wrote:
> I ran more tests and I don't think we can simply rely on p->scx.sticky_cpu.
> 
> In particular, I don't see how to handle this scenario using only
> p->scx.sticky_cpu: a task starts an internal migration, a sched_change
> occurs, and ops.dequeue() gets skipped because p->scx.sticky_cpu >= 0.

Oh, that shouldn't happen, so move_remote_task_to_local_dsq() does the
following:

	deactivate_task(src_rq, p, 0);
	set_task_cpu(p, cpu_of(dst_rq));
	p->scx.sticky_cpu = cpu_of(dst_rq);

	raw_spin_rq_unlock(src_rq);
	raw_spin_rq_lock(dst_rq);
        ...
	activate_task(dst_rq, p, 0);

It *looks* like something get can get while the locks are switched; however,
the above deactivate_task() does WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING)
and task_rq_lock() does the following:

	for (;;) {
		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
		rq = task_rq(p);
		raw_spin_rq_lock(rq);
		/*
		 *	move_queued_task()		task_rq_lock()
		 *
		 *	ACQUIRE (rq->lock)
		 *	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
		 *	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
		 *	[S] ->cpu = new_cpu		[L] task_rq()
		 *					[L] ->on_rq
		 *	RELEASE (rq->lock)
		 *
		 * If we observe the old CPU in task_rq_lock(), the acquire of
		 * the old rq->lock will fully serialize against the stores.
		 *
		 * If we observe the new CPU in task_rq_lock(), the address
		 * dependency headed by '[L] rq = task_rq()' and the acquire
		 * will pair with the WMB to ensure we then also see migrating.
		 */
		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
			rq_pin_lock(rq, rf);
			return rq;
		}
		raw_spin_rq_unlock(rq);
		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);

		while (unlikely(task_on_rq_migrating(p)))
			cpu_relax();
	}

ie. TASK_ON_RQ_MIGRATING works like a separate lock that protects the task
while it's switching the RQs, so any operations that use task_rq_lock()
which includes any property changes can't get inbetween.

Thanks.

-- 
tejun
