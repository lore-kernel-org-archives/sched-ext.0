Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DFD37E2EA;
	Thu, 23 Apr 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972593; cv=none; b=SboH2UVQShBSizOd57o4hoPEFKHjPQd65Sje68Jg74kx32jyzv3W+9/viWRiQOgFfkpT8LLoAnnrxFPkr5wq7S2iV8bVMSetQIPz20r/KxRBb2fcgZmDT/EgKeS0J6KSegb6hzGrUAU09uokaBN7guRE4qgqUZF2kyVTjZ7oTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972593; c=relaxed/simple;
	bh=nc1Jn5d0KqIGeoSHfpQd20llIqG7nIp11LcLrQ6jJio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDI8IDgg9Ls/bu9sXuBujTFX9pudyzgq2DyDKKlvEGTXRuRSerutyoaBXeadDbY8/1xFBJA2Lo5i0vyAD5Rh9fIlAJuY+MCPtO+ulBgZ3LePPki8dhFS5AzevGdF3SdfQPwyxdCh9iOw1ngkITlo9vpYCvaYT9xsPe1QM3a8noM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6/qc750; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6/qc750"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66449C2BCAF;
	Thu, 23 Apr 2026 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972592;
	bh=nc1Jn5d0KqIGeoSHfpQd20llIqG7nIp11LcLrQ6jJio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6/qc750GnH9HcaxOqw5JlcAdm3YogB2aG66wP/J1fQn0Cj1oxRMWLklVPl16K4Nt
	 y+I3kovUjscd64XR6Q1czj3eTTk08G+Jo8uZ3fgPuqFlhHQwsueQyjGCRsVLmVWE0H
	 DaUkAGztl9VsFW1CypWiKLq25h3W53iPez+i0cegtaApCKmwf8MVHkhVVqXNDb6c1L
	 iXVebUYcfnd9aYMYh4Oy7aUsgwXrlP1PKLydWWViRJw+gMl5F5aKtRZ2qd+Y1/YoK8
	 NcFKCAe9V69l9xLDoyJGvm0xdBgTJMKxE62DkTUeBvv3FYhf5vVjTWcivdMcrPM1lp
	 rPTkv8Jvt2nfA==
Date: Thu, 23 Apr 2026 09:29:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
Message-ID: <aepzL1xOEqh73hHo@slm.duckdns.org>
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>
 <aej8cmhZVhsqogr4@slm.duckdns.org>
 <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com>
 <ad24a49fd02d7b397976975a13767bb4@kernel.org>
 <DI0RERGK9HKZ.Y3HZ3N7J3RJY@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI0RERGK9HKZ.Y3HZ3N7J3RJY@google.com>

Hello,

On Thu, Apr 23, 2026 at 07:12:18PM +0000, Kuba Piecuch wrote:
...
> I think these two cases show that we don't necessarily have to migrate a task
> for wakeup_preempt() to be warranted.

I see.

> So to cover all cases (that I'm aware of), we need four checks:
> 
> * wakeup_preempt() in dispatch_to_local_dsq() in the case of rq != src_rq &&
>   src_rq == dst_rq
> 
> * wakeup_preempt() at the end of move_remote_task_to_local_dsq()
> 
> * wakeup_preempt() somewhere on the scx_dsq_move() path, but only if we're
>   moving the task to the local DSQ of a remote CPU (?)
> 
> * nr_immed check before returning RETRY_TASK
> 
> > Adding wakeup_preempt() to local_dsq_post_enq() for every insertion would
> > work too, but I'd rather keep it in sync with how core sched handles
> > move_queued_task() and only add it where it's actually needed.
> 
> Does having four separate cases to handle, not all of which involve task
> migration, change that calculus somewhat?
> I believe all of these cases will be handled if we add wakeup_preempt()
> to local_dsq_post_enq().

If we call wakeup_preempt() unconditionally, we'd be calling
wakeup_preempt_scx() on every dispatch, which isn't too appealing. We can
add an ENQ flag to mark these sites specifically but I'm not sure whether
that's necessarily better. The invovled code paths are inherently subtle and
finicky, so might as well just add the calls where they're necessary. What
do you think?

Thanks.

-- 
tejun
