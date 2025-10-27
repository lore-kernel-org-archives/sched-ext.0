Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7763195FE;
	Mon, 27 Oct 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587406; cv=none; b=DLHraR+jemGsERNFg6PLGjB3i+I70R3IxCKpcVpnr/kmIxTBOuOoLe5s0CoAUEMFr/N6HWHps75hT3R1eAGt7aIUB2H/dsDOzsPdlHq/g3/ZHuDs5MVB7j8c6rdOLZE0VOyZDUqB2bWrSzFOEA4fQAChBcDWSjZq4spiMIO5T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587406; c=relaxed/simple;
	bh=ML4Zbq7pgwMKMFkw+kohK1LhsbPJGd+tAqes06vWZck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ4oLsTAak8ItCR/uAD1pabywsWHLyoehpAr9jtuNPuyVa9/ISMpM4NNYQd/pY8UkwXnThoag8PZj21h1bkQYxA4737SxU+Lh1ezDfKCDZoW4iiwknsJVgxpggnKVQlVng0X9gekmJWk3/+Y0QUHFVMm6UtQaa5ItF3iIjnfAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UyuvtGk1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyuvtGk1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MmdzWYIHrQBywyvqVb/dJ5qHfDuXNYE/IdRhHxcX4MI=; b=UyuvtGk1xM6wL+qRdGOBDUMKHD
	jYKxHZpU2qil5wiLQAiUqUwiG14KIwmE52M7zmxI9imbP4wrQY6QwBzNp3MUTZYYqgb5xh2ujLqY8
	1tCcDhSnPsq2e+Q/x7vk1Hj2c4GltenKW3SANEcH6Dxgbb+/lVzsxgvM377zQtfxnTVaf4gCVQ0m6
	j5k/0bS1jcfnYo3H4+utyAGR0pTg5S6en7j5vTpCyKsA4K6Jc89J8xmWyJMVMIYGbvMKhLbpMj/ao
	j/r3ieZnMVaMHI1bR/pE2sW8G/B4LoasKAUSmjr2PDm9eSGnpiFTco2aJgLEEYxhMN+YnPtEq9IPz
	YCZDL0ng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDRLt-00000008PDt-3DNL;
	Mon, 27 Oct 2025 17:49:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 885B0300323; Mon, 27 Oct 2025 18:49:53 +0100 (CET)
Date: Mon, 27 Oct 2025 18:49:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251027174953.GB3419281@noisy.programming.kicks-ass.net>
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

This would've been prime Changelog material. As is the Changelog was so
vague I wasn't even sure it was that particular problem.

Please update the changelog to be clearer.

Also, why is this patch already in a pull request to Linus? what's the
hurry.
