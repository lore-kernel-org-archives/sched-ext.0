Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598FC3AE6E6;
	Fri, 29 May 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045731; cv=none; b=QFMgrfc+juBmwIrnE6f6WL28cJ4Ka33D+edlCNdGjjIZTr1T3u5LdKkftSlDUf4ePoWBBoRF6aAuB69pbtIyzUOwAg3PwerDkiEHIhbyuP3Y/o6ywYYIXbJVkHRWGPE68sstXQyINn02KCSW2yOUH2c/iAxA++B8waWXQ7UTH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045731; c=relaxed/simple;
	bh=07cEpOAMFatDbw7QbllfQqh5xBY1zxznihn73dgmrA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd/eQNFXxAYQH4E7bf7wxqGpIQuAzewfJTkjlv2uLWvdgGKKDpPSwbE0hJNc5espJ4Oz/uPL7+sTOwMnQtkdRjbOJ+SZB/Gqz61KTo8I4ofJMgu0qXQPpiP4vukn3AJAFVUlHigg2EWPCVtLv2lIqXoK0mboQ1e9P6Ogq+Zeggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YjlbXJWN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjlbXJWN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pRL6y0+KCY9m1AmQKraHuPt4hqCY/H2MFyGAftXTKBc=; b=YjlbXJWNnB/BAhMutGXJTvIJHW
	+5qPrmysJN2ICpMB1Zam9aW62g0aOlvparN3CN9xfMzt4Gds845UgnuY9W+nCJKIKgb4cAc66RnGW
	WYtl58MjSrImOxxz0s/M07CQw8dVaaeCw4HvQOdS/o3K/D1WU31KTlPVhuQbVrk8SZOEtvEztWnWT
	BUDrqbnJLXTRSLO803uH1BTKU1XtZ4SDozj3Jz5O88LINUIQRBo7FV8BZH3uBLsjYhMXp4X5HVpk/
	2oiVcAnurVwz2qDhE7gQhQZgLuPUK+n2mKL9bjOLrp5AHmXRnOq7cULoJVpvmH0x7PBHopuEFGXNR
	5jC4VVuA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wStCs-00000000rj4-2mVV;
	Fri, 29 May 2026 09:08:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACACA300324; Fri, 29 May 2026 11:08:40 +0200 (CEST)
Date: Fri, 29 May 2026 11:08:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair
 dl_server bandwidth
Message-ID: <20260529090840.GM343181@noisy.programming.kicks-ass.net>
References: <20260526164420.638711-1-arighi@nvidia.com>
 <ahhk4LJwmJCNLQp0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahhk4LJwmJCNLQp0@slm.duckdns.org>

On Thu, May 28, 2026 at 05:53:04AM -1000, Tejun Heo wrote:
> Hello,
> 
> Peter, how do you want to route the patches? I'd be happy to take them
> through sched_ext/for-7.2.

I have them en-route to tip:sched/core.
