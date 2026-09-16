Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3F483BF6;
	Wed, 16 Sep 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549256; cv=none; b=l1qtjJWyzO3CDLQaF3ONHtgPHQqwejlTGBel9d9sXjYYkJ9RSiHiEY/UXDm9edgXy/HzXInfWZ3aQJCg9xquKb/ja721nAC/hd5T/IeyJARodtYnQBtO9LSjr4L0/1Qkooyiyy8TMyOJHtuuPzmIZ/j6sBhMwiR0qwqui0RlCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549256; c=relaxed/simple;
	bh=MiqPyjOBo/6FhmQI0L33ejXMpulhlmnTC9H8PQTadHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5Hsks6VPTToWnlgqAPg20ejQdMdTgTmTorn6P50Sp9OngRFZGuAdSywyHvbtvQe/DhvLpm57hHyN7qG3rpo3O2M+4O0xA1idLMxqoU3SWXxG4F1g7D1TEdmkgWC+v0jpDxsbD9Bu4FurWQJ8IXTZuFc8jFBgOwBtYwNzyO6xnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9Di94Uq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9Di94Uq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bMtk8abwTjoKsyJlAN5e81hNdTDsB9SrVtsm0UrhpzY=; b=F9Di94Uqd2leQ49JV27i+aPfHC
	akzTb0sIR051yLMNR0rp1txc6cEjorSvSOHqZoyqeQolfKKIOkSm6A1LggAhr6uyKp1apGX1PQY9a
	r1JfmGgb39nTAWJTero/JQTMSO0ibuDrrc8cbm+T/pK2opRJ6hlt6L1udM/fDJ9g7FRfYcW08k/7q
	jX/5ccWPVs5+eZ0mXr6sZZFl3rdugRUk0Gh8gj8m/W/2pifKKi9TNFUuGFc4qt6yICz3NOADBLNNW
	JSsc2htZGukzqGW0I2WCfB2Y/D8P2DJO6MBsS9tLVAfACTwDvtsR6WmL3NuKCTuwNaDEsIMcJuxDy
	Jz+3LGhA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6lV5-00000007f7z-0BOA;
	Wed, 16 Sep 2026 09:00:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71AF4301BDE; Wed, 16 Sep 2026 11:00:17 +0200 (CEST)
Date: Wed, 16 Sep 2026 11:00:17 +0200
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
Subject: Re: [PATCH 07/18] sched: Add sched_ext hooks for proxy execution
Message-ID: <20260916090017.GF4121339@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-8-arighi@nvidia.com>
 <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
 <aqmq7iahwiBR34zU@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqmq7iahwiBR34zU@gpd4>

On Tue, Sep 15, 2026 at 10:30:38PM +0200, Andrea Righi wrote:
> On Thu, Sep 10, 2026 at 12:38:18PM +0200, Peter Zijlstra wrote:

> > > @@ -7264,6 +7264,8 @@ static void __sched notrace __schedule(int sched_mode)
> > >  			donor->sched_class->put_prev_task(rq, donor, donor);
> > >  			donor->sched_class->set_next_task(rq, donor, true);
> > >  		}
> > > +		scx_proxy_donor_start(rq);
> > > +		scx_proxy_resolved(rq);
> > >  	} else {
> > >  		rq_set_donor(rq, next);
> > >  	}
> > 
> > Can you expand on the need for scx_proxy_resolved() ? I understand the
> > other two, but this one I'm struggling with a bit.
> 
> Yeah and the name is a poor choice, it should renamed
> scx_proxy_reenqueue_retry() or something similar.
> 
> It's the retry point for a task that sched_ext couldn't move while
> processing a dispatch from a remote DSQ (used later in the series).
> 
> When sched_ext consumes a task dispatched to a CPU other than the one
> whose rq currently owns it, it may find (after locking the task's
> source rq) that proxy exec has made the task either the physical
> current task or the active donor. It can't migrate the task in that
> state, so it parks the task on the source rq's reject DSQ.
> 
> If the deferred reject-DSQ drain runs while the task is still current
> or donating, the task must remain parked. Retrying immediately could
> spin until the proxy relationship changes. The hook provides the
> notification that proxy selection has run again, allowing sched_ext to
> schedule another deferred drain after the current context switch.
> 
> I couldn't find an existing event that covers this transition without
> periodically retrying the reject-DSQ drain. Is there a better place to
> trigger this retry?

Ah, so its a little like that problem we had with ->balance() and
->pick_task(). Where a task gets taken off the DSQ and moved to the
local queue, but when not picked, it must be moved back.

In this case, ->donor is visible to ext and all is well, but ->curr is
not so easy.

I'm still a little confused though, why not leave blocked tasks on this
reject queue. If they're needed, the proxy mechanism will move them
around. They won't actually ever run except through proxy.

The point where they will become runnable again, is through wakeup. So
why not delay everything until that point?

Or am I not understanding ext again?
