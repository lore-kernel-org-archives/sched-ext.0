Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEF22A7F0;
	Thu, 11 Jun 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185515; cv=none; b=K06dwfYY5y7Clb07m0tvQt/+l8j3aU+ozxTJwPu4Cm0VF6efhTLR5N8wPItP4H7M8Qa0cxfoK6bv+Uoen/d2cdpGDyiW4CErJ3BPRJo1DJPwWnEud/DMInDPaxAH6OCulHh9GJnLBtob0ddyWNC9ClFdh1oXOdFmVVQsVFDUNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185515; c=relaxed/simple;
	bh=/3962jdLwoLBRz331vcusCpPn1KMsZyC0KQKcU7c0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZRV6iTELJwyHvlpqPgYFMDnK9shEeqxRTxHG14qUHGZ9+0E/H80hHWUdgVK5wDKYSW5ClcnEBRtIRSSqF9n71DLglMeGQLuHEZ6FfPa8MSVM+oZu4koyggLN3MQjANXzazbSIQA6iwaTAUyqbLIs2ZyX4xE15rI8piNvVzkQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwv8hG+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwv8hG+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7BE1F00893;
	Thu, 11 Jun 2026 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185514;
	bh=5MszHcu+oUEiIoDZ/mT/p+/9jADaMXNbhJrStrbGjCc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Lwv8hG+2RAUeLre1zCm46lD49gppa6V9T5rzEYn0/WENxFWR+m1S3XtsfFWAjLIRE
	 0MJ0UE7onp0TBePikCwJk7Lxj2NiVeTVD2dsDwP3EDo3OLsGstWYjFRY6kBN6ftw7W
	 WGX8hAf3tnHGYhu4b6IPbe1Nsvp4RyTvgZMmUZV6ky7J6DJii5gic74F8JDxfKdeNg
	 osj3TZMUJXqByVEnG0BZS6xeKVWlhxcsDc79RRbPgcy88uvDLixcQqqzFmcTyaKonE
	 2ul9pxfs7IKD3w9jWjwckC5EH5JANs5jpj5Uh7CLovli31QknuU3esvKbDl0jNpxT2
	 bUp7iZjVFpt+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 19AF9CE04B1; Thu, 11 Jun 2026 06:45:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:45:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiqxpzgl2YVVSARw@matt-Precision-5490>

On Thu, Jun 11, 2026 at 02:02:58PM +0100, Matt Fleming wrote:
> On Tue, Jun 09, 2026 at 04:23:23AM -0700, Paul E. McKenney wrote:
> > 
> > Does commenting out the 'call_rcu_tasks_generic+547' printk() avoid the
> > issue?  If so, that printk() might be deferred or some such.
> > 
> > "But if you cannot trust printk(), what *can* you trust?"  ;-)
> 
> I tried this and it still crashes so apparently not! I'll keep digging
> to find the real cause (it's somewhat cumbersome to reproduce this hard
> lockup).

If this code path is nevertheless involved, one thing that might speed
things up would be to do bursts of call_rcu_tasks() from lots of CPUs,
then avoid doing any call_rcu_tasks() for some time, then do a single
isolated call_rcu_tasks().  Or maybe you are already doing this.

							Thanx, Paul
