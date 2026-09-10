Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993837C10C;
	Thu, 10 Sep 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047556; cv=none; b=Jsvu118hzhH0jC5MWWkiyEdXeoHSQopHBsErdwmBLxvNJgo4gCDNry/jhxMXqqkSY+wHnw1khRhrHwJLL1uIUMIjQGzC18rM9u/t14zQQ1DvuaiQvraJEpgvcCQp3mxoEUMBPaFgumLfvd4DrXdiwiuPCHBvQpol27CrR2jV41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047556; c=relaxed/simple;
	bh=mcMJDM8a1eJCC094E8iHtLaECQdPmcra7LuwvzVQ7M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPBYh6oilFB80P8pG3iNqs5peLOahEOqZO1nRAscZMTY6rNhlwvKojPqcfeQ0EtmfCfHD1/38TrAuEulf3/Z6T1OgbPL3bClJ0cePQX4M5l6C3iuPRkZJ7OPIDzpsA3a2XjXhfq0VV44RmsH46vwmGZZ1IwZhOR98eEh8z1VZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blKeRR+/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blKeRR+/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GiWQPrjaz8+nxLgM6sOizDmSUd/SxTm1oiFePM6L7So=; b=blKeRR+/SpQgaMamNKPkdB8jiw
	aA0uG479JNcDvP66mpFIZT3fqOtWGMehUHIJ8Jvt4Qdy3Hv+qTP3Le5GS5omjVHIXROURV6jX/HhU
	qc0/yCYesJz44esdwx0dEGN7XSWKfcLxOK1zfohBW1TN26fdgcRypqp0qtG1nLAojzYh11f2bnY7T
	orlwK8j/VNjq+fwc4ip7YtA8toPbdt+jfNniHiAjcBbgBPlEfyrxTJStB8yvLa3vn1fEVA0VaG9LX
	iloCtlMZQI/5+WMF0kNW1wmG9mE8NZwRLJlRiLQRd/NEf3tHgx5vvHNVXcJR/V0/QoBvUViH3NRrl
	cswtJ/PQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ezV-00000000THO-3SnK;
	Thu, 10 Sep 2026 13:39:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C127130056B; Thu, 10 Sep 2026 15:39:00 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:39:00 +0200
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
Subject: Re: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <20260910133900.GT776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-16-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-16-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:25PM +0200, Andrea Righi wrote:

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 5f4956cf7e369..aa6ba9e8d7cb0 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -26,7 +26,28 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
>  
>  bool scx_allow_proxy_exec(const struct task_struct *p)
>  {
> -	return p->sched_class != &ext_sched_class;
> +	struct scx_sched *sch;
> +
> +	if (p->sched_class != &ext_sched_class)
> +		return true;
> +
> +	sch = scx_task_sched(p);
> +	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
> +}

Can we have this thing either be inline or wrapped in an inline function
that has scx_enabled() on?

