Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37E473C76;
	Thu, 10 Sep 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040860; cv=none; b=Bo0cEZLqHhZf/4eXX996hQcVb+sEC88yqj9XVXwYtbzinsNuH1SuBhd64Hxrn2if1Nl+M9RDJlafjRrT+QPJJ+9seVqb0RKNDR6nJzNwLwdUNJUgs2HhMuXIKo6HHY9Iyn2dqBPn6d0ZhDeSPuf9rxqtGI+887suw8+UsNWj5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040860; c=relaxed/simple;
	bh=Qf/ty3xDnT9ta1DPBM7dqflzHLLH0CYUrg2l6QLtve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XckNV22BXn3a5FwjiT6wFEdrkMB8W6qQjbFYK9w28M9FD8IrTtf1TwZz6D61BVqMHkpINjmL+ZhCVbqBBQq3HJvsF9wrhWAQZvFkKwG7HYOAsMqO0IVOQ8naLh/TSS2qBM1W6CKwnPhDH3iMIXym1s4cZzxoLE813EQc9UxQLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=neutb/6G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neutb/6G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AP5XdrbtCpbt0OBV3AQsk9iIA1wwjdQcbxqP+TdiSWI=; b=neutb/6GBhCj6Dl43J3U449RA+
	8EfAki+svyNwUQrQs0XYVFvs7Jg5eGDXC7DzEpiE0RoPezVEbO+nvMkSGDpwaFe8Q3xL9fu8MXoJA
	gA//IOGbOtTCaRGdz7W23T/C8BA/UEynC0bjsbnHmVmyHEc08M+qPjL/TN2JImZeRp1WQD3Q/yeds
	z6wgTqfwspHZ7pax6xZZNciuQ51AnOtlfQ0edScanCb4cFqLW8KiKXwwi8+Lbjd/Bsg9fxKBVAZ3e
	ZU7x5VNkoJ+zkP5BRYPRAaRLxROzcSGZieF6K8z25aqRGbzdawl7Zi/mLRaxCH/HuYd/eOlRcRaq6
	ZmpJbNWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4dFX-0000000GbIo-1esh;
	Thu, 10 Sep 2026 11:47:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A8DF300400; Thu, 10 Sep 2026 13:47:26 +0200 (CEST)
Date: Thu, 10 Sep 2026 13:47:26 +0200
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
Subject: Re: [PATCH 14/18] sched_ext: Split curr|donor references properly
Message-ID: <20260910114726.GR776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-15-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-15-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:24PM +0200, Andrea Righi wrote:

> Consider FAIR and EXT tasks with sched_ext running in partial mode. FAIR
> can be replaced with a higher scheduling class such as RT or deadline
> without changing the class interaction described here. The possible
> combinations are:
> 
>   1. D is EXT, O is EXT, T is EXT
> 
>      D can interrupt T according to BPF scheduling policy. O executes
>      with D's EXT priority and runtime budget, while T waits in EXT.
> 
>   2. D is EXT, O is EXT, T is FAIR
> 
>      D is visible to the BPF scheduler, but cannot preempt T because
>      EXT is below FAIR. Once T stops, BPF can dispatch D and O executes
>      with D's EXT priority and runtime budget. If T becomes runnable
>      again, it preempts the D/O proxy execution.
> 
>   3. D is EXT, O is FAIR, T is EXT
> 
>      This cannot represent T preempting O because EXT is below FAIR.
> 
>   4. D is EXT, O is FAIR, T is FAIR
> 
>      D cannot boost O above T because EXT is below FAIR. O and T
>      continue competing under FAIR. Once O releases M, D wakes and
>      resumes normal EXT scheduling.
> 
>   5. D is FAIR, O is EXT, T is EXT
> 
>      D preempts T as the higher-class scheduling context. O executes
>      with D's FAIR priority and runtime budget, while T waits in EXT.
>      D is not visible to the BPF scheduler.
> 
>   6. D is FAIR, O is EXT, T is FAIR
> 
>      D competes with T according to its FAIR deadline. When D is
>      selected, O executes with D's FAIR priority and runtime budget.
>      D is not visible to the BPF scheduler.
> 
>   7. D is FAIR, O is FAIR, T is EXT
> 
>      This cannot represent T preempting O because EXT is below FAIR.
> 
>   8. D is FAIR, O is FAIR, T is FAIR
> 
>      O, T, and D all have FAIR scheduling contexts. D remains runnable
>      as a blocked proxy donor. When CFS selects D, O executes using D's
>      FAIR scheduling context. When CFS selects O, O executes using its
>      own FAIR context, and when CFS selects T, T executes normally. D
>      is not visible to the BPF scheduler.

I don't see how 3,4 can happen. If there is a runnable FAIR task, then
pick will pick that directly.

Per the pick priority, the donor class must always be higher than the
owner class.

