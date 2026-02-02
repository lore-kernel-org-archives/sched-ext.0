Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1B310625;
	Mon,  2 Feb 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066882; cv=none; b=Iz1ynAgxdhU//mDll/+j36+KylNQDW2dvhZAHSUv4CLIllEVvqVKeDbf15NGbGyIqCSsJh35ktUC5O9G0ylecTQFHFOuqQl4tCjaV7w6mCy3IPBYWNO5hrLOAP4iHyLGBaEPl2tqMGOQMDcG+baHWKiWro0I9wSFHXeRCtQ2Td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066882; c=relaxed/simple;
	bh=7AsVDpx7fzySqQjRWEzl9G8Lisu8ChnSrqWiyb8laHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIPd6zxuk8wviKNHSXHcNaZnuh0UWrPW9moHaqj238XvuLm/MNnJvW4wfTHy9EDPc7XFK6X7jGwTpC0jidB4LYbtZANL/r4ffwg4DzR7mtJYdGZgFBY5isg1sFHUsWSR/bmAqTU50pgWBzkoq6UdIpGQW3doufIC57QnF7992mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erQvZ7Pn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erQvZ7Pn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gC392/ksJWhRyXZSUXll3DU+g5kZuHFXb9MCfj/wI7o=; b=erQvZ7Pn8/gGviMZ9JBSp5xq0D
	UHnQLiOSROzJwKgJpwbBBMpZNAvFTYVgTHGncHlgwxbKD8gTERbWVu47Gujr97IGckb4zCKal7iAl
	5goOekq0iCr4FWZh57GhvAS+CoYbK27YvKe8VKpDd+It5lhLI1voW+R3cE7rhxJOiXIqRuflhkdKf
	FLCfcv/qleGcn7IvaGWOmEvn92Ug7PrytWJAXdMB9+wGQumjeunuBZTZERF5noR2QmhEwUaLdGHk6
	i3OPYTlF3JxTfL0yE72c64FXORu15+xoHaiHTuAKFX10m3hl+GqwOP0zD69wkHt/NmI8qwuTv6VYj
	CfNKc+zg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn1Fj-0000000FD75-1vrE;
	Mon, 02 Feb 2026 21:14:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F5F6300BD2; Mon, 02 Feb 2026 22:14:35 +0100 (CET)
Date: Mon, 2 Feb 2026 22:14:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/debug: Stop and start server based on if it
 was active
Message-ID: <20260202211435.GE1395416@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211326.GN1395266@noisy.programming.kicks-ass.net>

On Mon, Feb 02, 2026 at 10:13:26PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 26, 2026 at 10:59:01AM +0100, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 93f009e1076d8..dd793f8f3858a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		update_rq_clock(rq);
> > -		dl_server_stop(&rq->fair_server);
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> > +			update_rq_clock(rq);
> > +			dl_server_stop(&rq->fair_server);
> > +		}
> >  
> >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> >  
> > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> >  					cpu_of(rq));
> >  
> > -		if (rq->cfs.h_nr_queued)
> > +		if (is_active && runtime)
> >  			dl_server_start(&rq->fair_server);
> >  
> >  		if (retval < 0)
> 
> Suppose runtime was 0, and gets incremented while there are already
> tasks enqueued, then the above isn't going to DTRT.

Perhaps simply make that:

	if (runtime)
		dl_server_start();

That might spuriously start the thing, but that should be harmless. It
will just go back to sleep for not finding any tasks to run and all
that.
