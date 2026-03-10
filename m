Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC122261B9E;
	Tue, 10 Mar 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167221; cv=none; b=bSH36Dp3NZycWUcQcqWr2uq8iAy3rPX2U1SHfbx7QwGKBFR1Zgf28+jOWPVZ1NeoqucMOd1E6m0OoKQM0SXarnuKxFH7G6bn7xcDm2HaaXn3iDeYVNUGvz/g+WXc8zxxFwLtdM/XrOdPaM/rdxYJJe025DCwySMaoOwT1lDNB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167221; c=relaxed/simple;
	bh=W3Xg/ZhlLPY3l7RWq4xOR3mR7cF+nKjropKwt+rXgVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9DvOyDxiSaovHAzs16HdzEYinIm8zWi6gQMYwsrjYnZjWR8R9kjZykxcb/zF0EBvzJ9HMNQB6DD1bTvs6/ieoVQcs83o+jU3SHo0/rFNy/V84FHZr9azYrchZbVgzsg5s6LfzIiuOllIQSFopa0GlzjCDUSIIV9jBa4SpIrLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8QCjRAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8QCjRAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A74AC19423;
	Tue, 10 Mar 2026 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773167221;
	bh=W3Xg/ZhlLPY3l7RWq4xOR3mR7cF+nKjropKwt+rXgVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8QCjRAX0VRR8z9yFGCRpvv09oTcscJsjQE1SijpSITjI6OYAg63zqj0xMqzEF8U7
	 d0PB7n6s8sRBTzzzF1lOWAyubnPSn4CqelPPeQfOYGYA0HAGIVg2sldReqdk3IFw+1
	 Gqnef4NnJR4quG7BLFHz4I6OQv44Dak4r0SJETg4+9u+cbhC7CIjd3XJmCtWCVhsUZ
	 Gg2EDqBTrNg+T4oBZTG7EeUp0cYlzrgI0B5ft0ggKPkFfryN7hKm8wp51K+mxA31Sy
	 WA+0aJ6RV7nig2zPREm3ubyW1y9B22JY0f8ck0EEm/sC2UjSi6cTsnkHRhZxedrfaW
	 URYH6NdPyYO4A==
Date: Tue, 10 Mar 2026 08:27:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: sched-ext@lists.linux.dev, kernel-team@cloudflare.com,
	arighi@nvidia.com, void@manifault.com, changwoo@igalia.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sched_ext: Partial mode priority and fallthrough to EEVDF
Message-ID: <abBidFKC2Hp6Wca-@slm.duckdns.org>
References: <20260310145213.1060649-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310145213.1060649-1-matt@readmodwrite.com>

Hello, Matt.

On Tue, Mar 10, 2026 at 02:52:13PM +0000, Matt Fleming wrote:
> At Cloudflare we're experimenting with inverting the priority of the
> ext_sched_class and fair_sched_class to allow us to pick SCHED_EXT
> tasks to run before SCHED_NORMAL. This gives us better scheduling
> decisions for those SCHED_EXT tasks where we can embed business logic
> into the BPF program and prevents them being starved by the larger
> number of SCHED_NORMAL tasks under CPU contention. There are a couple
> of reasons we took this route:
> 
>  1. Our workloads are heterogeneous and complex and we can't move entire
>  systems to SCHED_EXT in one shot. We want to experiment with running
>  SCHED_EXT in partial mode as we progressively onboard more and more
>  services (we run multiple services on single machines).
> 
>  2. There's no way today (AFAIK) to run in "full-mode" and have BPF
>  schedulers fallthrough to EEVDF.
> 
> In an ideal world, 2 is what we'd want to do. Is anyone else interested
> in this problem or currently working on it? Is there anything coming in
> the future that would make it easier for those of us slowly
> transitioning to SCHED_EXT?

Hmm... I have a bit of hard time following how that's different from partial
mode. If you want the scheduler to decide whether a task should be in SCX or
fair, you can do so from ops.init_task() by asserting p->scx.disallow. If
you mean that you want to switch dynamically on each scheduling event, I
don't think that's a good idea given that each hop would be full sched_class
switch.

As for the ordering between the two, I don't know. How are you using partial
mode? No matter how you order them, the behaviors on pathological cases are
pretty bad and I've been thinking that most would use partial mode to
partition the system so that some CPUs are managed by SCX and others by fair
in which case the ordering doesn't matter that much. If you're mixing the
two classes on the same CPUs, I wonder whether this is something which can
be better dealt with the deadline servers. Andrea, what do you think?

Thanks.

-- 
tejun
