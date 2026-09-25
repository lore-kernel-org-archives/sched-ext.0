Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1E334C1C;
	Fri, 25 Sep 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322999; cv=none; b=pavg5q8wLAxcyvDjjFZHs50wivNLc79eerZwjgrVkD6t58Rp2MzlIKvOJPcQ3jArNDDLsyZWZoDlz9g9IYmNxxjCDJjMjgIw+V8gtNgOxyxSeZNZMcxzX9/B3fLq/63HAvXxcEuecpmeCEZTCrcPsAzSPOP6M7mRt18BnbtgKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322999; c=relaxed/simple;
	bh=DaDWOsg3JESoFQO4/IfSuup+nSUCy1i3Yzf4kXpRvdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RydiUTts9l9tYRAZmKJnGPBUgOdQGO43dBYdBmppxibaIlM1ZGQzv1DHx2iRucJ280258omc366ioAmop/yhVsCul16VNxi1LaDAwHulfpIqayrDEotwtN2DjLoNgfSr+YN4gKdIepdDFyfG/j+Mwj/igtFYBYZI+GmumkmhSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSN0l5PI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSN0l5PI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oAlcJYNKSbQ+EFk0h6WTT+OIWimF+0yq5qKNYUwMB84=; b=lSN0l5PIx2sJXSxOd/EWQwsRst
	bWlBJg+pJSbKp3EBsZTmy2vNnJsQOk/VAwl4divJdaWJlOkqdQlkgJSfgoNARF+bf6iYEBDSrPovv
	j/4RhBq6yfnIHVlBWGnVymF5AwNzO9t4z0KathlRkzw+Ge52Gz3V4BpiePQAYP/Z4xtezOeVPayUU
	9nQ+niMdTH8IDtvURENFQx7soIbIIYQ9cIlc8qCRYd0bYNtFtRmUgnmCpUxOMwxIr6KEv0xWu7XO3
	IloQhAUcjF/s/T1ddPF+hN6wxcU058eZl2uLw7LJZcFfpVm1T1uzlPrVOnJsXcpMWK5gYx4biDRt4
	5FmV7e3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xA0nF-0000000GiNz-3bKQ;
	Fri, 25 Sep 2026 07:56:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DAB763008D6; Fri, 25 Sep 2026 09:56:28 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:56:28 +0200
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
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <20260925075628.GI4121339@noisy.programming.kicks-ass.net>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
 <arYm4PPMhevWQWsK@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYm4PPMhevWQWsK@gpd4>

On Fri, Sep 25, 2026 at 09:46:40AM +0200, Andrea Righi wrote:
> Hi Peter,
> 
> On Thu, Sep 24, 2026 at 09:52:37AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:
> > 
> > > Andrea Righi (16):
> > >       sched/core: Drop mutex locks before proxy rescheduling
> > >       sched/core: Dequeue waking proxy donors before reset
> > >       sched/core: Mark wakeups completed through ttwu_runnable()
> > >       sched: Add helper to block retained proxy donors
> > >       sched: Add sched_ext hooks for proxy execution
> > 
> > Right, so these add:
> > 
> > WF_TTWU_RQ:
> > 
> >   Used like ENQUEUE_DELAYED; could be fixed by generalizing that to cover all
> >   of p->is_blocked.
> > 
> > scx_allow_proxy_exec():
> > 
> >   Hook to kill proxy exec for scx
> > 
> > scx_proxy_reenqueue_retry():
> > 
> >   Like put_prev_task(), but for current. Ensures current gets put back on a DSQ
> >   once its done running.
> > 
> > scx_proxy_donor_start():
> > 
> >   Delayed set_next_task(), confirms donor will be used.
> > 
> > sched_proxy_block_task():
> > 
> >   Almost like switching_to_scx(), except it needs to change ctx->queued in case
> >   of p->is_blocked. Hence a new callback ran before sched_change_begin().
> 
> Yes, that matches the intent, with one small clarification:
> scx_proxy_reenqueue_retry() doesn't directly put current back on a DSQ, a task
> that couldn't be reenqueued remains on the reject DSQ and the hook schedules a
> deferred retry after proxy resolution.
> 
> > 
> > 
> > 
> > Now, I have:
> > 
> >   https://patch.msgid.link/20260917-sched-fair-hrtick-restart-v4-1-4dd1414da81a@gentwo.org,
> > 
> > pending, would something like the below on top of both this work?
> > 
> > (although I'm not convinced SC_CONFIRM is actually making it better)
> 
> Yes, this works.
> 
> I applied Shubhang's v4 hrtick patch as a preliminary commit, then added the
> SNT_CONFIRM callback and reworked the proxy-exec series to use it. sched_ext now
> confirms the donor in set_next_task_scx() and scx_proxy_donor_start() is gone.
> 
> I tested the updated series and it passed all my scx proxy exec tests. The
> branch is available here:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec-next
> 
> It's not an obvious simplification, but if we want to go this way, we can
> express both the provisional pick and donor confirmation through the sched class
> callback.

Yeah, I'm not convinced either, but I'm also not liking scx specific
hooks. I'll apply your patches as is, and we can noodle on the
difference later.

TJ, would you like me to take the sched_ext part of this series too, or
will you pull in sched/core after these land and then put those patches
on top in your tree?
