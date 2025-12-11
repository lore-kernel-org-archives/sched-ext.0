Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDD1684A4;
	Thu, 11 Dec 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470024; cv=none; b=hOuTHazbtfzSJmdEj6Lc2m6OcY0aRbOCu0yriiS4blkaJ8vwn+PZGpBJDEg4H/XJaY29WvPEHEqDPNzZK063jqXkuAQdUjuqBUX33JOWZzIL0TxxMDsB8/D0BUw70dhPku+UbXbXE8ETWgicM7eYvIKXFAWc9DbAOcK6yXfBMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470024; c=relaxed/simple;
	bh=jSIMPy3T3M8u0zbLHMGV00TUpGIk3zMPwxo4sxqG2HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTkOeHOagz++AFMTXY/XveOFwxH4XuzTb8ZTfi98P/b7mayMZNGUny/5HOab1nqQwozN1w1YG118/Xo/MeeixRYYDCfACrDUsJ47OEJwvq6PbTnbpvCqwUu1Dk8fZjd3tmANka7dlXub+tEfLj+OkS9rnA10+TycujoqIaPbRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXM7YgT/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXM7YgT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BBAC4CEFB;
	Thu, 11 Dec 2025 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765470023;
	bh=jSIMPy3T3M8u0zbLHMGV00TUpGIk3zMPwxo4sxqG2HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXM7YgT/1ZvT1vcEhXXu8tGh4kpBOhJRscmYvAY5/V2rwPGH4JzP+Kg1zaQmTHyy8
	 Qt+dx8KaWE1S/DfPMLHjhufTTpNNsDqbIvbu3I5VGWJiN0gt4vR/cpMjl0w7qTpH50
	 zD5Uk9884/NHyF6n6AcfK48Z5FHhsWG81u8rRfgrlfsm57ijBGKqeHdWPcP6KUwYUO
	 jZDAnvz5ZQxzfBCNt20o8FW0dUT2zhv3paj+SAv2rz37WgENSKuV3RjAPjDY/eLunX
	 2JIBZxcxRZ48NLHbpqFPbvjDT8aw7N55duVOTPziYrc9X0CREqpBA2W0E+mEYu4q5b
	 mgxsqYMCXrKtg==
Date: Thu, 11 Dec 2025 06:20:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aTrvRpr8yblKXlP7@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
 <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>
 <aTruf0rK94ujYH0f@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTruf0rK94ujYH0f@slm.duckdns.org>

On Thu, Dec 11, 2025 at 06:17:03AM -1000, Tejun Heo wrote:
> Hello, Kuba.
> 
> On Thu, Dec 11, 2025 at 02:24:04PM +0000, Kuba Piecuch wrote:
> > Since we're doing a direct dispatch, the user scheduler task will be
> > inserted into the dispatch queue in enable_task_scx(), without dropping the rq
> > lock between example_enqueue() and the insertion, which means reenq_local()
> > will run afterwards (since it's deferred using irq_work), removing all tasks
> > from the DSQ, including the userspace scheduler.
> > 
> > A similar problem arises even if we don't do direct dispatch and drop the rq
> > lock after example_enqueue(): since dispatching and reenq_local() are deferred
> > using different irq_work entries, and irq_work_run() processes entries from
> > newest to oldest, dispatching will be handled before reenq_local(), yielding
> > the same result.
> 
> Oh yeah, the asynchronity can become pretty confusing.
> 
> > The user may be unaware of this behavior (it's not mentioned anywhere) and
> > expect the reenqueue to happen before dispatching the new task.
> > 
> > I think at the very least we should make users aware of this in the comment
> > for scx_bpf_reenqueue_local___v2().
> 
> Documentation is always helpful but I wonder whether this can be improved by
> the reenqueue function capturing the dsq seq number and re-enqueueing only
> the ones that were enqueued before the reenqueue was called.

That doesn't fix the ordering problem in the other direction, but the
reordering in the other direction seems inherently less useful at least.
Maybe this can also be solved with seq - ie. make enqueue record the current
seq, mark the DSQ with the latest reenqueue seq and at enqueue commit time
if the captured seq is alreaddy reenqueued, trigger reenqueue.

Thanks.

-- 
tejun
