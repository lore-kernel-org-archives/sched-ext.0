Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F2307AD5;
	Mon,  2 Feb 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062202; cv=none; b=g2+HPYbPaMOgiVFsMVpfhL52l+zV5qpPdZEP0IFd1fg7Yftg94NRcbOXfEfvtoJkHvmXUh3U8UaMG5bGPjuTSoM+4t6OYZrCJbXKUlPr/titEW4F+FDIE/FjETtijQmFvEb/Tt0rj0uf1vevjtE4nHfJFfswxTFqLTr3MQWw6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062202; c=relaxed/simple;
	bh=zSIsEFNK/7Q5Oglr9HTeAQBH6u73EqPK/TZl5btnytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxT2+gBQ+ANehTg5QaSalkFoe7r0RDgCcLaJe826COkI+guKf18yYa4hvvrvlJ09tE1rtrGMN6BiALzpmzMzgCIs0o5MHarmJm0oijQaxeKCwMl+MEKtJpMoZ0YVKrtVncq7kX5sqO0165Aym/WRLzAfD/oo69PpOjNE574tTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxfuBidX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxfuBidX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=11T5unwckm8GnVZ0dI7RwMN5iyMPM+EwlC6O/7MQIQM=; b=SxfuBidXBjPN49wG28a9ubQUVJ
	Fd3xDeJRn21xNXFbZgAxDyWRZwjqqAO5VE8BN6ZWr04OmRZuYN812chH0rWPE/p7gJM59MBMhWtWn
	vPqnQosBeLicHcs42BenLk+pDzaEO8ud5DvuOTlcmbASx/E2IvrIm5Q/iB0LdfIpleLPEVNLBJ717
	iqM43xx9GDRvhN/9zkJkZgdkpoqrDzHqCAJwqEji/BH8dRKlGrXfK6w34nV1GDpvt9iNx7YY2wvjB
	Hc7TUe/0D8UIbW9EtUt1aHFGzYxs/aNXvoRZB81DIPtC3MA+e2ZKKJu0/Igd+R/zfOkQSsv1IU91m
	WW91OUHQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn02F-0000000GzVD-1xxd;
	Mon, 02 Feb 2026 19:56:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 03B8D3008E2; Mon, 02 Feb 2026 20:56:35 +0100 (CET)
Date: Mon, 2 Feb 2026 20:56:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v12 sched_ext/for-6.20] Add a deadline server for
 sched_ext tasks
Message-ID: <20260202195634.GH1282955@noisy.programming.kicks-ass.net>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <aYDUqdQquFcqj7rQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDUqdQquFcqj7rQ@slm.duckdns.org>

On Mon, Feb 02, 2026 at 06:45:29AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jan 26, 2026 at 10:58:58AM +0100, Andrea Righi wrote:
> > Changes in v12:
> >  - Move dl_server execution state reset on stop fix to a separate patch
> >    (https://lore.kernel.org/all/20260123161645.2181752-1-arighi@nvidia.com/)
> >  - Removed per-patch changelog (keeping a global changelog here)
> >  - Link to v11: https://lore.kernel.org/all/20260120215808.188032-1-arighi@nvidia.com/
> 
> Peter, Ingo, this patchset has been around the block for a long time and the
> remaining deadline and debug patches are reviewed and seem fairly isolated.

They're in well enough shape to merge I suppose, although I think
there's still a few issues to fix.

Notably I think it would be good to not have the scx_server consume dl
bandwidth if scx isn't enabled. And I wonder about that start condition.

> Given that the patchset addresses an on-going issue, I'd prefer to land the
> series before the merge window. If you want to route 1-3 (or the whole
> series) through sched/core, please let me know. Otherwise, I can them
> through sched_ext tree.

They seem to apply without issue to tip/sched/core, so if that works for
you I suppose I can stick them all in.

