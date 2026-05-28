Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3A3A2E12;
	Thu, 28 May 2026 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960354; cv=none; b=DMQjRlcnl8I+E3Q85np0uJsX3lCThbMnH1zGQyRDpKrgns0RH3i5chhVJpjBaFljUrSYteGA/1EioVjMTRsUJ1xIqfPJ0DD8AdjhKEIRJL/H4HjQ8wZJ42nD3kHYXcD9szapeRg/HiEardmHa2ddcYIldUOSZ4EqJNYoe4KxhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960354; c=relaxed/simple;
	bh=BBNSDEQcGsj41r8vQvGfAA5jOkztJehhNFgbytmH4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFDPTP1xyd9gNkn8xdH8GBZ1mcxzsJ/0hwh1B4vafbJf6lisD+s1HimlrNHzaq0ITLGmZ5PKxclBWvHO1fTOHKNWa9njE2KozYm2mRaVKZzFqX5dAKuKyzpbnsZeViVLXt3PQuOqhKkxx+yflxII/yuJa9lkSyZOOKxGJtCyzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cctohbJA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cctohbJA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BBNSDEQcGsj41r8vQvGfAA5jOkztJehhNFgbytmH4mM=; b=cctohbJA2XccuNLfNUe2u4cJ1m
	+3DYq3A0rTF+UOPhrNVeLgss33NC0AyGjDdNzidDnJ2PPzNtgZhNSoUfH3sz8qEIo+3TBK4It6vcu
	hN/3i3XrSXGHs7iFxcAWnGc8Ooy5E+BAlKNvP1v/3rUnwddi7TRn4yxUvpm5dAlTyhQ2Nw0l3Ff03
	Tlmp/wGyI0q6NpDpnWvxULwoeoZ7JVmqZE6JyueZmPna4SZKgrBQXq2oRd69TgJ6WCibdsnHV8V5v
	H1e9XUmoQ6ITwNlWYH7j5EY9qXWEwZqHUzTUN10dEAMDNxq33TSCnHKnI5+q0/Twvw7XVJ6BKnpsP
	dxVSjH5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWzf-0000000FzfF-2ytE;
	Thu, 28 May 2026 09:25:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 55882300673; Thu, 28 May 2026 11:25:35 +0200 (CEST)
Date: Thu, 28 May 2026 11:25:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng315@gmail.com>
Cc: arighi@nvidia.com, brho@google.com, bsegall@google.com,
	changwoo@igalia.com, dietmar.eggemann@arm.com, haoluo@google.com,
	joshdon@google.com, juri.lelli@redhat.co, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	quzicheng@huawei.com, rostedt@goodmis.org,
	sched-ext@lists.linux.dev, tanghui20@huawei.com, tj@kernel.org,
	vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched_ext: Rebuild fair weight on ext to fair switches
Message-ID: <20260528092535.GC343181@noisy.programming.kicks-ass.net>
References: <ahXWaL2BYLU6ukkO@gpd4>
 <20260527094037.3494671-1-quzicheng315@gmail.com>
 <20260527112624.GT3126523@noisy.programming.kicks-ass.net>
 <3c258a36-2b28-4221-b2b6-776a0b1693ab@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c258a36-2b28-4221-b2b6-776a0b1693ab@gmail.com>

On Thu, May 28, 2026 at 10:53:54AM +0800, Zicheng Qu wrote:

> 2. Rebuilding `p->se.load` from fair's `switching_to` hook. This is the most
> natural place semantically, since the task is entering fair and fair
> prepares
> its own state before enqueue. My only concern was that, for non-ext -> fair
> paths, `__setscheduler_params()` may have already updated `p->se.load`
> through
> `set_load_weight(p, true)`, so calling `set_load_weight(p, false)`
> unconditionally here can be redundant logically. Functionally, though, it is
> harmless.

Right. We can worry about optimizing this if there's ever a report. I
don't expect this to be noticeable much. If anything, the PI code would
be the one to trip this most often I think.


