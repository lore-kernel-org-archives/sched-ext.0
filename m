Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6852E8B77;
	Mon, 27 Oct 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556709; cv=none; b=W8B4NThKfDBZPooxb058D7mRjxUwG1JWYKxwHnB/omeePWVHJJS7q+yQoWkXkhNAU0e/kBqrURu+sVS91u08I9yTZ6gOg84O+R4v2rGLw94T8Z8LOwJp0mHnbacPL+hfchuVoQmNqom7aBpxIqjIJk4DWw8AdLZVryFL+B12ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556709; c=relaxed/simple;
	bh=j0rAp3cin22BfWgxoGwbzyfxB+QkEIsXVtuZazYSJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br0oZw9XmCgMfjicpIpu72xTdNYjh5VnXipHuEOJ1sJehHmLVZRJjR7Ru3JqW1nmerhA+0vdPaCh2vQ/JJk4MmCUoyKRRBqRoiCeIG+lkYCmB12EmO/HgpNpkcDoiXKnGSLJUzP1wkRYhu4y/bm2Rn+MVD0PEfE7d2YEK49zWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=huSHIPtN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huSHIPtN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0RkRdq2QC6jie78pIeDU77aUsNvRvjb5w4Kmu9OnrEM=; b=huSHIPtNXka5udgHrY01AxzrTH
	ZEgbkW5AmTfS5vO1GK9SWsPDMD5NyzBtBJCqv7GJl2xbPE4SC+3jd7XpBxLCz5vQ7KbbBT6QTZB4j
	xwyZPoG1TY8+LmFQJ/EDkZ5VRCtwn4KnvGsq/rlq3Mw7kPsTOlSnsJGrdDB29KYFdy1Xpd+K+zZ49
	eL+mB5I+P7vx31MOWaPGC9Za8kfUmDNqU3NNGM5julJXf/hFLgZ17jTmtx/tS5Hr5SZ9BPYa2tYRT
	9tbUsudz+xmFwncS7wkA6f8BjbNzFbcEQVO0jcqHjmfa0hMALWCyhegeWUAZPwA7Aaeh5AtpNuJ3g
	mln/zuTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIV8-00000001jAw-2o5S;
	Mon, 27 Oct 2025 08:22:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 43A4B30049D; Mon, 27 Oct 2025 10:18:22 +0100 (CET)
Date: Mon, 27 Oct 2025 10:18:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025001849.1915635-4-tj@kernel.org>

On Fri, Oct 24, 2025 at 02:18:49PM -1000, Tejun Heo wrote:
> The ops.cpu_acquire/release() callbacks are broken - they miss events under
> multiple conditions and can't be fixed without adding global sched core hooks
> that sched maintainers don't want. They also aren't necessary as BPF schedulers
> can use generic BPF mechanisms like tracepoints to achieve the same goals.
> 
> The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
> a CPU gets preempted by a higher priority scheduling class. However, the old
> scx_bpf_reenqueue_local() could only be called from cpu_release() context.

I'm a little confused. Isn't this the problem where balance_one()
migrates a task to the local rq and we end up having to RETRY_TASK
because another (higher) rq gets modified?

Why can't we simply re-queue the task in the RETRY_TASK branch --
effectively undoing balance_one()?


Relying on hooking into tracepoints seems like a gruesome hack.
