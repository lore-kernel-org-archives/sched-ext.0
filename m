Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384A433E83;
	Thu,  2 Jul 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016657; cv=none; b=Rjb5fkZCIlEVamhI8uCsC/ksxHuGPVdSEi9BJyTGdjJuVQ/2OgFGq2du6FGtJeQNTNKDvs2/dv9w1X6oxLw8ZvxdHuS/bTNRRoQ5H0OtKmWhjP5J0MIowAHZwklwIHDiymrdRjrxE/G74HfNsVI61tL1XxAUx2YM/exhySJnZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016657; c=relaxed/simple;
	bh=KmUg/UQHDTILpcdvEVdTnOuV9qWOPUEoAryBAbqSAWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKo4/V1TjIlcTf7H8ZGr4HZv9xqJg/oKovLu43AozTaZyauRsB/uJq4iEfBjsapP4qNnDN5oBvssP4eljrwd6lD5Q2UciILnuLCDhGAClxL9tQmnBtPXC/sMP8ovcGR3ka+4ErxSpwB7v9XWn/5a/3kk3ZW/AowfbPiRX5HVdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SfQ3WIjX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfQ3WIjX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6IWzhe2f/pgjH98gCdbcDyYduz8BSklqfpXdqS+HK0Y=; b=SfQ3WIjX1HDRZO+toApSc04Jyo
	PNWr+4f08+6gXoVXfq8RRlijJc+vMGKa+P2TPQocF5rftPNB5bA2xbPoe23vUzqaTn/nmbuHM9rxe
	Zh9QNWUaE4tW1xOgRahcNS0BMe377/wFEhf4yX9m6W9E8O3PzIjIH1mAsSLc/0DnUynyMCNLsQ+Ga
	de9zUEOybq5BGJaxtUySBBf90cfjuxP/iqtP2vH1qV6qSaoUW0++4BQ5nDXVMr7xnFdgpGqD+YgFr
	WnWrAh0Qm5gJzsRe+IBHu6nvMvM78puy7Hyd2ExIgavAmP8r/YvZoiz2fb21Am5RRT1KVdQmkPfFo
	RkZyfoMA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wfM51-000000048j7-2IdE;
	Thu, 02 Jul 2026 18:24:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 65637300220; Thu, 02 Jul 2026 20:24:06 +0200 (CEST)
Date: Thu, 2 Jul 2026 20:24:06 +0200
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] sched/core: Skip put_prev_task/set_next_task
 re-entry for sched_ext donors
Message-ID: <20260702182406.GM751831@noisy.programming.kicks-ass.net>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702171909.1994478-3-arighi@nvidia.com>

On Thu, Jul 02, 2026 at 07:09:18PM +0200, Andrea Righi wrote:
> In __schedule(), the proxy-exec donor-stabilization block calls
> put_prev_task() and set_next_task() when rq->donor == prev_donor and
> prev != next.
> 
> For sched_ext tasks, re-entering set_next_task_scx() for a donor that
> has already been seen by BPF ops.running via the normal pick path causes
> issues. It fires SCX_CALL_OP_TASK(sch, running, rq, donor) a second
> time, and sch->ops dispatch can land on a vtable slot in a state that
> yields a NULL function pointer or corrupts the stack.
> 
> Fix this by skipping the put_prev_task/set_next_task re-entry when the
> donor is in the ext_sched_class, since sched_ext tracks curr/donor
> itself.

This really sounds like a bug in ext; how is this different from the
sched_change pattern doing a put/set cycle?
