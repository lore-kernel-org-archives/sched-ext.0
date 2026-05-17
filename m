Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE52F7F12;
	Sun, 17 May 2026 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044927; cv=none; b=coD78cd0REzi5IbZjPqI9ps+olm/CciTgmv3nzjCaGDsW8/wxA4PEpTCKrbCVP/zZr886od2zFkBBoknNEdRBnsFm7biBE9GTOgFpfvAwczN7PtciQXEBZoLjHJ4JpN9k8wXGpH0XSR4CUcyVSY1bJ+RWgmlZPnUc97ttcV0CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044927; c=relaxed/simple;
	bh=4TK9iDoeYN4d+D/4JjUbra3eNEzXboa4o1KTW31m/1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isYWwDbct3eV2sLo8V8RlQTfiC1yPOygBtEh11HjndfLDDwj9FcjADI2mFu9u+ZYKtgBjLabbMfL/Q0to5OwccWoLexr3m4nFK5xd9WWeMGtYIp08UnmCSU1W2zTbag5ZVz7tRy0Bh+en930GeuRfQmSkXm7bTOfrz1Ilb1S9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjeRCbSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjeRCbSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3158C2BCB0;
	Sun, 17 May 2026 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779044926;
	bh=4TK9iDoeYN4d+D/4JjUbra3eNEzXboa4o1KTW31m/1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjeRCbSE5cIOIPMGRm8adBElqQBmiIqE8hI8UPfv46JTNsJmfGOgfTqIka0Fnhaud
	 A4MQ6Ur8i0c1QujgL83CROamg2Og/ntKOhW2wQWkWJ///YD+sivY+j/JH3q0Od13YD
	 fN27cUkqZvK4gLR+zF3tn1hlMzKPwSVeRWYcO2swtro28oladx9cGxxMnbfYippKSw
	 f22XxOAbJmKvK1fqu8onM9U1QCy88i+58BvYLoHjrHvAs/rq2P+R0wSebz4HqFL1Q4
	 PB1pfbFKmo1MZO6k02k4T0ReTNdsK2Bvr4EqbXClBibIhsFxPyyTl1TMfjaXMOYZcT
	 2pSab+Na/5DMw==
Date: Sun, 17 May 2026 09:08:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix deadlock
 between scx_root_disable() and concurrent forks
Message-ID: <agoSPRzgEy7CvCe2@slm.duckdns.org>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
 <362a365eb559003ed21c6dac12d92c5d@kernel.org>
 <agoNQ7cKgkX1pWmo@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agoNQ7cKgkX1pWmo@gpd4>

Hello,

On Sun, May 17, 2026 at 08:47:31PM +0200, Andrea Righi wrote:
...
> Yeah, this is much better than my comment (that was quite confusing).
> 
> To make sure I understand: what fixes the deadlock is checking scx_switching_all
> before DISABLING in task_should_scx(), because in this way the sched_ext_helper
> kthread goes to scx (not fair), runs, the enable path completes, releases the
> mutex and the disable path moves forward.
> 
> When I wrote my comment I was looking at the ordering of [__]scx_switched_all in
> scx_root_disable():
> 
>   static_branch_disable(&__scx_switched_all);
>   WRITE_ONCE(scx_switching_all, false);
> 
> And I was wondering, if we invert those we'd have a similar issue: a small
> window where __scx_switched_all == ON and scx_switching_all == false. But the
> current order is already the safe one, so no change needed.

Yeah, and even if create that window between __scx_switched_all and
scx_switching_all, it's transient. Let's say a task slips into eevdf between
the two. The task has no way of preventing disable from completing
__scx_switched_all transition, and the condition would unwind. The problem
with DISABLING transition was that it could make a racing enable path to
wait for kthread creation to finish while holding enable_mutex. Because
disable path needs the same mutex to turn off __scx_switched_all and the
stalled task needs __scx_switched_all to be turned off to progress, we end
up in a deadlock.

Thanks.

-- 
tejun
