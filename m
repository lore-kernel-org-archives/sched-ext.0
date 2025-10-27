Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73930C60C;
	Mon, 27 Oct 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588635; cv=none; b=TQteGKlLIV7h7W7la4ghDKV2b5ADqPj/FlzKvNDW7EcEiToz1Sz7Z0nzjLFLRrpo8nYDiV97bQywYdZFqNz7BcMGwvZtMX0F7ajRHExHmBAyGkymzzWRbyyCZiuEA9CdDMQgycTg6nnay6ZMp+8yRko2qnzOtAdL+2Sib6/qMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588635; c=relaxed/simple;
	bh=wcVGvIWetF4/U0cU72L71ISJY4OdIlmPrB/who+CJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJyMhnQosxZsEv+qHnTv5baBgdLZkl7sMXFBaWim+ITBKsTfz+aNobn2xFMZxEDNKPbixTuu0ogrfnZaBThKBYPl4aWu1fkHbWPg7P14vuszaaQg6whnTCL9PDIt0WmZzqc8tGvlXTNR5CUQNpFB2YS6JxtZs4vkd4Ypy5bignA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FGlyah3J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGlyah3J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I8rPE0cdAXnJTHr6KpJ7Uz7Vy+8FrpME9wcPdicA9I0=; b=FGlyah3JRsFbfly6gXjDY5Njzg
	6aX6nzZPMpUcoqPGkTqPbjVAnq6sHhKyg3Quyaxz7YonwjAuU7mS34BDptOCvH7xRX9vuqLg+vwKm
	8ZHnSRYNnuNurnOb4IC21o/UBwYAmMpIYEkJsV5BDH1SWM6okg5YpDsQznV8HQ92Fh43zH1r1VPg1
	sm9kFFUnmuUqLz8YSxbhAXDtuy9MABxzJRu3ln2Prayjjhik74BgQ6ulXB7fTb9JoVKo3y80VO1ua
	8NqlrpJObWCi8hUxJIUDoY2f53lz1Z6fPuKB6TcNydyqTMReIdtG3pfUe/zD2iHvnGHw+66Yipw9Y
	mIfwzwLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDRfn-00000008pcO-2BNP;
	Mon, 27 Oct 2025 18:10:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4265A300323; Mon, 27 Oct 2025 19:10:28 +0100 (CET)
Date: Mon, 27 Oct 2025 19:10:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251027181028.GB988547@noisy.programming.kicks-ass.net>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-XAGrWQY1d6Bq9@slm.duckdns.org>

On Mon, Oct 27, 2025 at 06:00:00AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Oct 27, 2025 at 10:18:22AM +0100, Peter Zijlstra wrote:
> ...
> > > The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
> > > a CPU gets preempted by a higher priority scheduling class. However, the old
> > > scx_bpf_reenqueue_local() could only be called from cpu_release() context.
> > 
> > I'm a little confused. Isn't this the problem where balance_one()
> > migrates a task to the local rq and we end up having to RETRY_TASK
> > because another (higher) rq gets modified?
> 
> That's what I thought too and the gap between balance() and pick_task() can
> be closed that way. However, while plugging that, I realized there's another
> bigger gap between ttwu() and pick_task() because ttwu() can directly
> dispatch a task into the local DSQ of a CPU. That one, there's no way to
> close without a global hook.

Just for my elucidation and such.. This is when ttwu() happens and the
CPU is idle and you dispatch directly to it, expecting it to then go run
that task. After which another wakeup/balance movement happens which
places/moves a task from a higher priority class to that CPU, such that
your initial (ext) task doesn't get to run after all. Right?
