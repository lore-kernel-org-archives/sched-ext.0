Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363C499F2C;
	Thu, 17 Sep 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641334; cv=none; b=OZaoXZj2HoC38QMD0hQCuLS59Hwv9rqm1OBsISDPOSt2wQhesUwKNk9VeUIZ5Ya+jadxvdjS6YWXr0K6zR2kXL5jcFWFwlYSjIckHl6SCoqodC533yGyWgy/aVWlvHLMN/TBJUwVD81SwSbWIFvE41gYxpduOCh4G+uv6GpmnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641334; c=relaxed/simple;
	bh=qz4YSOL29TSpL4pQBJWR2QYeo7ZyR5cRhGlIx2ribl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyA0wOp77x8kKysZtCx0bhStQtkSlkAUekwPnmwY3PvbY/GUg4Im9uf0x8kzPh5wSIRGjQE//mhBgaSagqGpaeIWuxChoOGGg7HdCgA9+ahziZMxW8BlwdzzYb4pEK3Z6WlFzNNPfFUMHSQyLygS5Ksm4FkuywPiRpcOzhkh7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lw+gds8B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lw+gds8B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uPueS4wjgjkJZFlI/bANeBSjKGHblrmVslFltjMSfN8=; b=Lw+gds8B7t6wKBoyC/fuJM8Yxe
	ztuD+qUy3ZPxvYGyhlUoCWSzBZadvezCu2nZnPq06iH3qA1+XrnGCf+fXZ30jT4EzqbxW/DlwWShS
	iDEte/5KwPfXmbO5v1RRONAYsFspm+f2XBgEO3Qi4gA6WsLTGxPAxcOu84sqUOgZ+69lq6kTrS4gD
	WX7CFLNLnTnj85pR8xsY2bDC36ozYMFuET3SSLjat8tUXN8O2B5vipMXG59g60vjPbwYffZQ6Z/z0
	S32rfebaFovSwRSOW4wOyJegpUCMx1uEXzkiKtI3n/L4ypkTBa4Z0fRxrJE9j66sruJwS8KaJ04d9
	IlYxz90g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x79SO-00000008mJ7-2tAN;
	Thu, 17 Sep 2026 10:35:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 50F8A300583; Thu, 17 Sep 2026 12:35:07 +0200 (CEST)
Date: Thu, 17 Sep 2026 12:35:07 +0200
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
Message-ID: <20260917103507.GJ776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-8-arighi@nvidia.com>
 <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
 <aqmq7iahwiBR34zU@gpd4>
 <20260916090017.GF4121339@noisy.programming.kicks-ass.net>
 <aqq7Si1D3P2et_gw@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqq7Si1D3P2et_gw@gpd4>

On Wed, Sep 16, 2026 at 05:52:42PM +0200, Andrea Righi wrote:

> > In this case, ->donor is visible to ext and all is well, but ->curr is
> > not so easy.
> > 
> > I'm still a little confused though, why not leave blocked tasks on this
> > reject queue. If they're needed, the proxy mechanism will move them
> > around. They won't actually ever run except through proxy.
> > 
> > The point where they will become runnable again, is through wakeup. So
> > why not delay everything until that point?
> > 
> > Or am I not understanding ext again?
> 
> I think the missing detail is that the task rejected by the remote DSQ transfer
> isn't necessarily blocked.
> 
> Consider a blocked donor D proxy-executing a runnable EXT mutex owner
> O on CPU0.  O is rq->curr and D is rq->donor. Since O is executing
> using D's scheduling context, O's own EXT scheduling entity may still
> be on a non-local DSQ.
> 
> CPU1 could concurrently consume O from that non-local DSQ and start
> transferring it to CPU1. After dropping the DSQ lock and acquiring O's
> source rq lock, it discovers that O has become rq->curr on CPU0 and
> therefore can't be migrated.  O is then parked on CPU0's reject DSQ.
> 
> When proxy exec switches away from O, O stops being rq->curr but
> remains runnable. There's no wakeup in this case, because O never
> blocked. If it remains on the reject DSQ, it's no longer visible to
> the BPF scheduler and can't subsequently run using its own scheduling
> context.

Argh, right! I got D and O switched around :-/

> The rq->donor case has a similar issue even though that task is
> blocked: a blocked donor can stop being the active donor before the
> mutex wakes it (for example, if another scheduling context is
> selected). The proxy exec mechanism follows the owner chain after the
> donor has been selected, it doesn't select tasks from the internal
> reject DSQ. Leaving the donor there until wakeup would prevent it from
> being selected again for proxy execution in the meantime.

Ah, but rq->donor gets a put_prev_task() to sort it out. While there is
no such things for rq->curr.

> This is why the retry is tied to another proxy selection point, once
> the task is no longer rq->curr or rq->donor, it can be re-enqueued to
> through its BPF scheduler.

Fair enough. 
