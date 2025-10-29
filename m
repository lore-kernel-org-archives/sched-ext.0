Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BC24293C;
	Wed, 29 Oct 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734753; cv=none; b=LaEnXsDyeWQg2mll9xErIFk3ivVkT2w2hFcaVr/dfoMiaPwNW6u+fJqb3A6WFXh1Q7OrXS//HAILySdQ5j531DFxxaguHlhwVzFOlN35j12rkKpdozBa2YPxnH4D/Kx37BmBakAg206CnrxROYBgX7ZzmQn5fSm2r7SvZJmUn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734753; c=relaxed/simple;
	bh=gp1J/3XvL43QuO/PbnJy0L/Um1JZ738iV4lNmjvkcIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDho7P+kgGFutz4NCtphp19GusORIuRZNMkPHAcclxdzAsZCh2INUSmkACVeOR5NlDiV68UY/XIzqw/XAY2ZDPNE6pWr8Y41twnW6sZAdAa8d8FpbfOFTvsLhZHv1pgKbPAWy/zQsM5q0r5B6mfWAOPz8yB4OitngxjTsw7QNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MV3K0OsY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MV3K0OsY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OLEcKOx+r/E6W6c62wz9ndwid6HQuJrvFy2p+wBounI=; b=MV3K0OsYRnrK1Rr/Pbqu/uPwNc
	5Kt9NRV4bli4gteiGL5eMwMdvT0+e6ioIlk/VYB1rFt8sZMiUAqUfMOB5IKjPWVD66NiRJnh63HGV
	YkqVTixFwk3ov98ZkA7NGspmfpGbgq0vOdj4Qusw/4ISvkIh5wDDEcB6U9qzS75XEDuc1siOxrN2x
	KMWXHbPJsizooWvAz4NvrHsNwRKdVc7couXfYBR9sSDzvyX+hNJjUI5FD/lUxG+IrcQ8hbwol9cAh
	19YOAUOy4Q1Pye+/A028MIL96RqQKdpLUe9cy9ZpObGBXn98cdv/nBNythqW1nP1Rft0+Pe0Ujsjp
	d4TGm0Sw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3gY-00000007k01-1TcV;
	Wed, 29 Oct 2025 10:45:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57694300323; Wed, 29 Oct 2025 11:45:46 +0100 (CET)
Date: Wed, 29 Oct 2025 11:45:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v2 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251029104546.GI3419281@noisy.programming.kicks-ass.net>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-3vOtH9Dyg_R9w@slm.duckdns.org>

On Mon, Oct 27, 2025 at 08:19:40AM -1000, Tejun Heo wrote:
> The ops.cpu_acquire/release() callbacks are broken - they miss events under
> multiple conditions and can't be fixed without adding global sched core hooks
> that sched maintainers don't want.

I think I'll object to that statement just a wee bit. I think we can
make it work -- just not with the things proposed earlier.

Anyway, if you want to reduce the sched_ext interface and remove
cpu_acquire/release entirely, this is fine too.

I might still do that wakeup_preempt() change if I can merge / replace
the queue_mask RETRY_TASK logic -- I have vague memories the RT people
also wanted something like this a while ago and it isn't that big of a
change.

> There are two distinct task dispatch gaps that can cause cpu_released flag
> desynchronization:
> 
> 1. balance-to-pick_task gap: This is what was originally reported. balance_scx()
>    can enqueue a task, but during consume_remote_task() when the rq lock is
>    released, a higher priority task can be enqueued and ultimately picked while
>    cpu_released remains false. This gap is closeable via RETRY_TASK handling.
> 
> 2. ttwu-to-pick_task gap: ttwu() can directly dispatch a task to a CPU's local
>    DSQ. By the time the sched path runs on the target CPU, higher class tasks may
>    already be queued. In such cases, nothing on sched_ext side will be invoked,
>    and the only solution would be a hook invoked regardless of sched class, which
>    isn't desirable.
> 
> Rather than adding invasive core hooks, BPF schedulers can use generic BPF
> mechanisms like tracepoints. From SCX scheduler's perspective, this is congruent
> with other mechanisms it already uses and doesn't add further friction.
> 
> The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
> a CPU gets preempted by a higher priority scheduling class. However, the old
> scx_bpf_reenqueue_local() could only be called from cpu_release() context.
> 
> Add a new version of scx_bpf_reenqueue_local() that can be called from any
> context by deferring the actual re-enqueue operation. This eliminates the need
> for cpu_acquire/release() ops entirely. Schedulers can now use standard BPF
> mechanisms like the sched_switch tracepoint to detect and handle CPU preemption.
> 
> Update scx_qmap to demonstrate the new approach using sched_switch instead of
> cpu_release, with compat support for older kernels. Mark cpu_acquire/release()
> as deprecated. The old scx_bpf_reenqueue_local() variant will be removed in
> v6.23.
> 
> Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
> Link: https://lore.kernel.org/all/8d64c74118c6440f81bcf5a4ac6b9f00@honor.com/
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Yeah, this Changelog is much better, thanks!

6.23 is a long time, can't we throw this out quicker? This thing wasn't
supposed to be an ABI after all. A 1 release cycle seems fine to me ;-)
