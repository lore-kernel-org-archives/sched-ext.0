Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D445D92D;
	Thu, 10 Sep 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037144; cv=none; b=sqfB2k3Sz2lQ5Cg7/0oGw2jg3VoS1bZM+5xPkoOfPLLN+HL+trkPEX6ar8wTTn8JBAy8+IDuUkkUxSravNvs60+XdBVkmVFWg/V7zWz/EBNGAmA0LJ6naynlIjcT+a/UNVCXvLm2Mr+Z6FIDzZ4OPUvevAN5mX24Xk0j2jisnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037144; c=relaxed/simple;
	bh=7mB91F2bpOIoDuvFbgbmZ3E1vU8W06FnaPbbY4+0ucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYtUOMUxRqz47ch7gXR0yBJVIWL3+bYZCPRjV1ZBi4pJ6aiF9jmkmJKc2OmnlP2Mtv2jIDbjgL4Rj8z7xCf5Bd0ADJmawXPg7fGiF+98ovnQGlulH9Tv90zGVJVwu1HHhFCXAs5c2b0OsxRX4VhbzGgQ4cynBw/uh2Q1LTrBTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Owjx0cIN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Owjx0cIN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yhrca4I4IvshIQRv8T/Y6iGQz4G4HSyXgNE0gKp/I2w=; b=Owjx0cIN4maISN3fg2YEEtJouq
	rJ20mERSUj35VPVu1S1YijmRi+yYMNSnGsqBvmOhuwBbDBIESlXOUReAVeshafzzfQRM3l9jYeAoy
	01gvfpuh2U420bB/VZlObpUQpTAOCitD5t/eWLPnd2pmZn4gEy0m+S5knSVx2AYUmDeSHnTtYuTMF
	6hOT2rEwk5s7xCKqchMS0ZrqpFGGKqWBtul2MJClMa7MgDujrk+8+YqfVRb6APSp5aDRO0qT6aDYi
	mu5ATQzpvo3u8rc0euJDYaE0HktoIGdbBfX6HnhK+tzqP50woxs7pKwgPkWRPvhWDz9B5hn6bMMJK
	ofejRszQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4cHZ-0000000FlVb-0nQo;
	Thu, 10 Sep 2026 10:45:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29FC2300400; Thu, 10 Sep 2026 12:45:28 +0200 (CEST)
Date: Thu, 10 Sep 2026 12:45:28 +0200
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
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Message-ID: <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-9-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:18PM +0200, Andrea Righi wrote:
> ttwu_runnable() handles wakeups for tasks which are already on the
> runqueue, but scheduling classes cannot distinguish that path from a
> full wakeup activation in wakeup_preempt().
> 
> Pass WF_ON_RQ to wakeup_preempt() from ttwu_runnable() so scheduling
> classes can handle already-runnable wakeups separately.
> 
> This is a preparatory change to support proxy execution with sched_ext.
> No functional change.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c  | 2 +-
>  kernel/sched/sched.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d578dd635f2eb..f142ab455b797 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3908,7 +3908,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  		 * When on_rq && !on_cpu the task is preempted, see if
>  		 * it should preempt the task that is current now.
>  		 */
> -		wakeup_preempt(rq, p, wake_flags);
> +		wakeup_preempt(rq, p, wake_flags | WF_ON_RQ);
>  	}
>  	ttwu_do_wakeup(p);
>  	return 1;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 56ac104f1f825..f30d122909e7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2538,6 +2538,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  #define WF_MIGRATED		0x20 /* Internal use, task got migrated */
>  #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
> +#define WF_ON_RQ		0x100 /* Wakeup of an already runnable task */

I are confused again... help?

wakeup_preempt() can only ever be called for tasks that are on the
runqueue. That is more or less the point of wakeup-preemption.

Even the already-runnable distinction would mean things like
move_queued_task() should also have this. The task is new to this
runqueue, but was definitely already runnable before.

What actual distinction are you needing?
