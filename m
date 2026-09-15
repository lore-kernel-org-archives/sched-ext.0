Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AD43846E;
	Tue, 15 Sep 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493074; cv=none; b=Kz9C3ih6Z4HUnhbfdLzmq7lnLVuJp971F7G/ljIneuw/2KszebY6QDCzebeAsv8xACE3a6D0RXja0gFJXz00O0UfAlde4555CnSIE00Ilpm8sZneOgG1uoANUxcDqEBTu5SqKZRjTBWO5XCcI5z/uybcNBeLzciLeeKCQjHdkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493074; c=relaxed/simple;
	bh=N1uo+LN+BR8bycRT34CjAMfqEO8I+aN9SICXho/lqhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYTXx1qqcV8g9pS2VQjObBk8r18KlXYrD2e/X6PDZIyxi76V7GPwwJ0RDnhdE0Rj6tsj1dXWTn92wPwcrIDEB5fulhBYO6A0MCq6O4Vbl8/Ht8re85tmglVY+i+AeuNTHWIMAu+N+Ay6UYKbPGefVw/PeO5GekPNeCQQOiIS6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TRSoUWwF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TRSoUWwF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o3sBMMNkZYGHRLzQ0L/ylrvpboFh8FkZPjaw8+4m7mg=; b=TRSoUWwFm1Y6hmiYVd7LEdKj/X
	za/zJaazOFTjy9xXwXfLDvFYzIWFUUBcA3HtZzTojrZPUUeJOqO9wkgFPGrs+j6AYvnSIXzLeGwaZ
	wMwtSzJXmnBZeI/heWcMhm9oVWkKDp5BQvMWGPw0rs3OqTaJ7UvcURCsokRWe29R81UoBzBW5mwvz
	FJAGZ48xbbuuFVvXKyPxiEjRnIWINcCEPoe70oKmtoxO28lZGz6ElroCWS8pTg4dt3rLZeI0dQSHg
	OCYl1wIRcNWRePV3DoaA5lH1VSUAGEzgb8FebOepBC7PxlD9JzFoCfbI/bzPiz0zKAe0/GXg0taEK
	sYq/bp6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6WtG-0000000GmAB-1ynd;
	Tue, 15 Sep 2026 17:24:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D738300328; Tue, 15 Sep 2026 19:24:17 +0200 (CEST)
Date: Tue, 15 Sep 2026 19:24:17 +0200
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
Subject: Re: [PATCH 04/18] sched/core: Avoid false migration warning for
 proxy donors
Message-ID: <20260915172417.GA2835410@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-5-arighi@nvidia.com>
 <20260910100652.GF4120091@noisy.programming.kicks-ass.net>
 <aqlstkw_QzFqe03A@gpd4>
 <aql-bQRXTP6lCcso@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aql-bQRXTP6lCcso@gpd4>

On Tue, Sep 15, 2026 at 07:20:45PM +0200, Andrea Righi wrote:

> > > I'm not sure why we're not hitting this upstream?
> > 
> > I think this can be hit upstream as well. I'll try to create a reproducer.
> 
> And I can reproduce this with the latest tip/master:
> 
>   proxy_migrate_repro: donor blocking on CPU0 with migration disabled
>   proxy_migrate_repro: donor moved from CPU0 to CPU1
>   WARNING: kernel/sched/core.c:3389 at set_task_cpu+0x1d3/0x280
>   ...
>   Call Trace:
>    try_to_wake_up+0x43f/0x780
>    __mutex_unlock_slowpath+0x330/0x540
>    owner_fn+0x9f/0xc0 [proxy_migrate_repro]
>   ...
>   proxy_migrate_repro: donor woke on CPU0, task_cpu=0
>   proxy_migrate_repro: completed
> 
> The reproducer creates a mutex owner on CPU1 and a migration-disabled waiter on
> CPU0. The waiter is proxy-migrated to CPU1 while blocked. When the owner
> releases the mutex, try_to_wake_up() returns the waiter to its pinned CPU0
> through set_task_cpu(), triggering the warning.
> 
> I guess I can send this as a separate fix, it doesn't necessarily need to be in
> this series.

Right, or at the head with a Fixes tag on will do too. Thanks for
checking!
