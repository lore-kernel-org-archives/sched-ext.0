Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FC374730;
	Sun, 15 Mar 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605451; cv=none; b=EXliR78F5HwnVW78NtlvVzHy/qoR5W2RiqgldxFj1L1hO+xu/q+YppL0iaivGn3fXDsx7IUErm+L2R5FRbftc+IqqcEAUKuwBpseTEsqF/33CKVMNFHGdv1EBWGsbBTncVdhWhmpraqnSVNY2/yWhCk9GKIwTg6z9vF9PLoIAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605451; c=relaxed/simple;
	bh=8hwK4wdAS2dqjAT/wdZ1kip1o2FwiGC/pQ9aHjdQzhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZEG12L0PtoN1APTw9U19AH28P2g7mhDe2JuvGaKB7CrkWbam7pon2YDXPUvNFte+09RJ68qI6Ruh1T1UcfDYJ7Fr6SuhCipi8NFP9IWX01T8L8t8J0r1SMBWxGN8TeoDRX0pX89nws0OKB7okQ+3EYfh0XUnISIes3stzFN6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8DkslNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8DkslNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA1BC4CEF7;
	Sun, 15 Mar 2026 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773605450;
	bh=8hwK4wdAS2dqjAT/wdZ1kip1o2FwiGC/pQ9aHjdQzhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8DkslNXgktkAGJ6MuEn6LlQ5y90BfzQbko1GOQXLE4XkG+l2vv/J5EncH8P7t11s
	 KB0x/I6PK8jMyS0uTgQ53rKANcJjxc8gwEfVdwH9mkKmJ8nW8EwtY66Mo99tzsgJlg
	 Vk6mag7H5yivMD86L3ESPxN1QYjeDWq65M4DVdOmNWWmeVWgA1NgBAaC22RcyvUTmK
	 Huh92NbbwUB/BXtnW7sB5DGSNltYnP8gy2weaFo4EhRrcv8s5JyEJww/a4MXo3beyG
	 b+hr+57dv9XKNg7YWylQkXLb+eAAUs1tOulY3QL75gSJVdi/TVUC9aHcVJeCBOwi76
	 xk5tmRQnFT+jw==
Date: Sun, 15 Mar 2026 10:10:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, newton@meta.com
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Reduce DSQ lock contention
 in consume_dispatch_q()
Message-ID: <abcSSTZglXeHmgT4@slm.duckdns.org>
References: <20260314235231.684671-1-arighi@nvidia.com>
 <abZ0nerzU1j19BEG@slm.duckdns.org>
 <abZ-li3Dq9_PXu58@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abZ-li3Dq9_PXu58@gpd4>

(cc'ing Ryan Newton and quoting whole body)

On Sun, Mar 15, 2026 at 10:40:38AM +0100, Andrea Righi wrote:
> On Sat, Mar 14, 2026 at 10:58:05PM -1000, Tejun Heo wrote:
> > Hello, Andrea.
> > 
> > On Sun, Mar 15, 2026 at 12:52:31AM +0100, Andrea Righi wrote:
> > ...
> > > Benchmarks that generate many enqueue/dispatch events (e.g., schbench)
> > > show around 2-3x higher throughput with most of the scx schedulers with
> > > this change applied.
> > 
> > Can you share more details about the benchmark setup and results?
> 
> Just running schbench and perf bench for now, it definitely needs more
> testing, but I wanted to send a patch to start a discussion about this (I
> should have added the RFC in the subject, sorry).
> 
> > 
> > > +	/*
> > > +	 * Use trylock to avoid spinning on a contended DSQ, if we fail to
> > > +	 * acquire the lock kick the CPU to retry on the next balance.
> > > +	 *
> > > +	 * In bypass mode simply spin to acquire the lock, since
> > > +	 * scx_kick_cpu() is suppressed.
> > > +	 */
> > > +	if (scx_bypassing(sch, cpu)) {
> > > +		raw_spin_lock(&dsq->lock);
> > > +	} else if (!raw_spin_trylock(&dsq->lock)) {
> > > +		scx_kick_cpu(sch, cpu, 0);
> > > +		return false;
> > > +	}
> > 
> > But I'm not sure this is what we wanna do. If we *really* want to do this,
> > maybe we can add a try_move variant; however, I'm pretty deeply skeptical
> > about the approach for a few reasons.
> > 
> > - If a shared DSQ becomes a bottleneck, the right thing to do would be
> >   introducing multiple DSQs and shard them.
> 
> True, but then we also need a load balancer with multiple DSQs and moving
> tasks across DSQs is also not very efficient. With a shared DSQ we do
> really well with latency, but under intense scheduling activity (e.g.,
> schbench) we get poor performance, so all those scheduling-related
> benchmarks get a bad score with most of the scx schedulers.
> 
> With this applied pretty much all the scx schedulers (scx_cosmos,
> scx_bpfland, scx_p2dq, scx_lavd) get pretty much the same score (or
> even slightly better) as EEVDF with schbench, without any noticeable impact
> on latency (tested avg fps and tail latency with a few games).
> 
> > 
> > - This likely is trading off fairness to gain bandwidth and this approach
> >   depending on machine / workload may lead to severe starvation. One can
> >   argue that controlled trade off between fairness and bandwidth is useful
> >   for some use cases. However, even if that is the case, I don't think
> >   trylock is the way to get there. If we think that low overhead high
> >   fan-out shared queue is desirable, it'd be better to introduce dedicated
> >   data structure which can do so in a controlled manner.
> 
> True, and I think with moderate CPU activity this may increase latency due
> to the additional kick/balance step when trylock fails (maybe control this
> behavior with a flag?).
> 
> That said, the throughput benefits seem significant. While schbench is
> probably an extreme case, the improvement there is substantial (2-3x),
> which suggests this approach might also benefit some more realistic
> workloads. I'm planning to run additional tests over the next few days to
> better understand this.
> 
> Based on the schbench results, it seems like a missed opportunity to drop
> this entirely. Can you elaborate more on the dedicated data structure you
> mentioned? Do you have something specific in mind?

IIRC, Ryan was experimenting with some data structures which trade off
fairness for scalability in BPF and saw promising results. Ryan, can you
please share what you did?

Thanks.

-- 
tejun
