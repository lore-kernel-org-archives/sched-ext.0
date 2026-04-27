Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EC3DBD4A;
	Mon, 27 Apr 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309272; cv=none; b=CMQtGZhRUf5Qp8UKEXjI3h4v8SOAfIwiClMgxhlNAthBWwLXxuFXP/dVeaU63CWz0ZrlF3IbEnxim4WhPSzjtf/1o7nvdd5eqoBZC0PQ8T3EwdiZB++vhmw+R3+P346AuVHfuQQ1yR5qOWJY0HqGWt0D/OljbgdlKyDDPIKwxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309272; c=relaxed/simple;
	bh=Ij5EjwOJo+62qHTynV7dJ/dfZ185bAKw70vGSx9Bli4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+SivQoGhJfrSpMaIj265IIbLO7FopQWEh4SHAaWdzjTCcMp7iqCYGRMNvc5IPi6lYVxLhRt01Gg+5oa1Dl5qqhyezwY5pJY3aKjT2G3lDPnZ2/ecB28DZWozQjlvQCvOSaH9i/TLSRP+hbZ1RrQCVFVfixnlfL4pJBqKGYwXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXuCrLW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXuCrLW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F754C2BCB5;
	Mon, 27 Apr 2026 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777309271;
	bh=Ij5EjwOJo+62qHTynV7dJ/dfZ185bAKw70vGSx9Bli4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXuCrLW+r7qb8olZVxmoNrxb8LnFn+7U9YTuKHKCf5mFx/B3JZibBwjeZSYoVgJsc
	 a/SchtXvd6T4uQd3wN/zsK2tKTjgrBTdTRs/UvXYLX1wH2J+Yj49Liu3uO4OfkkngP
	 dmPDsORPTn9oP1prlqLKueapksj2rMDnb5APu1o8UsqdYE8VbpOnZPsai002gmHhsh
	 CLtbYKA0+PUiEoYD91ZZTqGaYDUGfnJRM+d2dSGi3JO/20g4BVTPlMSm90EXEkWUvu
	 brcxc8N4Ogoa9jsBzT4OxUPzoqJeBQJpR9Juboli2//NxofUMyD91dUGb59umpRjNZ
	 D7E1Vi1tjvUvw==
Date: Mon, 27 Apr 2026 07:01:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Call wakeup_preempt()
 in local_dsq_post_enq()
Message-ID: <ae-WVgOxW5OpRGZ5@slm.duckdns.org>
References: <20260424092245.3212529-1-jpiecuch@google.com>
 <aeulrBs6ZAopfcHG@slm.duckdns.org>
 <DI3ZVX73P4N5.WP4H0TMOBIHF@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI3ZVX73P4N5.WP4H0TMOBIHF@google.com>

On Mon, Apr 27, 2026 at 02:14:33PM +0000, Kuba Piecuch wrote:
> > Hmm... I don't quite understand this part of the change. sched_class_above()
> > got separated out into its own case but why is it dropping resched_curr() on
> > SCX_ENQ_PREEMPT?
> 
> In the SCX_ENQ_PREEMPT case we call resched_curr() where we previously set
> preempt = true.
> 
> In the sched_class_above() case, wakeup_preempt() will call resched_curr()
> for us:

I see. It'd be helpful to note that in desc.

> >> +	/*
> >> +	 * If @rq->next_class is currently idle, we need to bump it
> >> +	 * to &ext_sched_class using wakeup_preempt(). Otherwise, if we drop
> >> +	 * the rq lock later in the pick and an RT task wakes up on @rq,
> >> +	 * wakeup_preempt_idle() will be called during RT task wakeup and
> >> +	 * SCX won't have an opportunity to re-enqueue IMMED tasks from @rq's
> >> +	 * local DSQ.
> >
> > As this was really subtle, I think it warrants documenting all cases here.
> 
> Yeah, I was trying to keep it concise. How about something like this:
> 
> 	/*
> 	 * Note that @rq's lock may be dropped between this enqueue and @p
> 	 * actually getting on CPU. This gives higher-class tasks (e.g. RT)
> 	 * an opportunity to wake up on @rq and prevent @p from running.
> 	 * Here are some concrete examples:
> 	 *
> 	 * Example 1:
>          *
> 	 * We dispatch two tasks from a single ops.dispatch():
> 	 * - First, a local task to this CPU's local DSQ;
> 	 * - Second, a local/remote task to a remote CPU's local DSQ.
> 	 * We must drop the local rq lock in order to finish the second
> 	 * dispatch. In that time, an RT task can wake up on the local rq.
> 	 *
> 	 * Example 2:
> 	 *
> 	 * We dispatch a local/remote task to a remote CPU's local DSQ.
> 	 * We must drop the remote rq lock before the dispatched task can run,
> 	 * which gives an RT task an opportunity to wake up on the remote rq.
> 	 *
> 	 * Both examples work the same if we replace dispatching with moving
> 	 * the tasks from a user-created DSQ.
> 	 *
> 	 * We must detect these wakeups so that we can re-enqueue IMMED tasks
> 	 * from @rq's local DSQ. scx_wakeup_preempt() serves exactly this
> 	 * purpose, but for it to be invoked, we must ensure that we bump
> 	 * @rq->next_class to &ext_sched_class if it's currently idle.
> 	 *
> 	 * wakeup_preempt() does the bumping, and since we only invoke it if
> 	 * @rq->next_class is below &ext_sched_class, it will also
> 	 * resched_curr(rq).
> 	 */

Looks good to me.

Thanks.

-- 
tejun
