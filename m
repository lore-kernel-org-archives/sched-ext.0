Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B4376A0A;
	Fri, 21 Aug 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297222; cv=none; b=Y76a1fj1oRkX2rWWlRnYR/svgOU7WutbdaQXi3GJ+lBlSIJy471f7oKzKXKFh1kbzyS8DqhiyBz6HaAVgctdSdKm9Td+bDhOmlSl7ySwp8zAjuIhylyu3k8hnGfzw8xFqSKiXb2Bi1van9Rvg2uScEm2KMzoiW5FgboXgcVS8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297222; c=relaxed/simple;
	bh=ujs01LsbYoFWDsEKucmYAAeg3X4q6/liv7/0ASjcS70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoIf/vSf+c7Uq1LY6oUPAHr4wUHs0P98udyvw0TP2hyypmvAkh5TJT8Og2qzXITFlm2qdGdRnjdsNWu6h3OEgvbb5RSv76kR1zoiPRMyrc4Szd+HSH/ACko8bKANTGsOy3eKLNLf88pdLiMipupbQWuBUbvzV+nBTQMHqu917C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kQxA6f8b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kQxA6f8b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UknPsqmY1hEIo/lnBl+MoQHeD8mmK/W3caSnngii74U=; b=kQxA6f8b3Xm1fCI/A1xNHey7eH
	wp3s2nnZjYFLncfQxEAiS0RGxSYG65D02NzFLnTNFLhbc2Fh7ry1F1TA1esBvkArVi6Yo7QV5Bhv/
	v/pchFUNfRTfcd74rQPDKoTwH3WUGRU04pyGPlL6Im6im05+iBysw7JVBmKvJiJ0Q6BU4ko0HGBNg
	w/Q48i3oXR5LDlZdsbXKM3kXp5hsBXCNiatlIWKpKN38phn2D/hXfIjnKTFHZOGyZYxyvN+P4ghur
	YLjwigfkhG6ec3pAwvljLbK8e9rE4QI8TctejROpM2k+qcHl21betVEE+Q4B/MaawV2UKR5OEoh0x
	vDJ5ifAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxJeR-0000000GwOC-2FH7;
	Fri, 21 Aug 2026 07:26:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0682F300324; Fri, 21 Aug 2026 09:26:54 +0200 (CEST)
Date: Fri, 21 Aug 2026 09:26:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal Blaszczyk <michalblk@google.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Serialize cgroup updates to prevent CFS/SCX state
 divergence
Message-ID: <20260821072653.GD4120091@noisy.programming.kicks-ass.net>
References: <20260820160956.910663-1-michalblk@google.com>
 <aoc3fUfZDnZ0eSL_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoc3fUfZDnZ0eSL_@slm.duckdns.org>

On Thu, Aug 20, 2026 at 07:21:01AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 20, 2026 at 04:09:56PM +0000, Michal Blaszczyk wrote:
> > Concurrent writes to cgroup control files (such as cpu.shares or
> > cpu.weight) can lead to state divergence between CFS and SCX.
> > 
> > For instance, in cpu_shares_write_u64(), the CFS update is serialized
> > by shares_mutex (internal to fair.c), but this lock is dropped before
> > scx_group_set_weight() is called. The latter only acquires a read
> > semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
> > and act on the sched_ext update concurrently.
> > 
> > This serialization gap allows concurrent writes to interleave.
> > As a result, the recorded state in CFS, the SCX internal bookkeeping
> > (e.g., tg->scx.weight), and the BPF scheduler itself can end up operating
> > on completely distinct parameters (pairwise distinct values).
> > 
> > Similar races are present in tg_set_bandwidth(), cpu_idle_write_s64(),
> > cpu_weight_write_u64(), and cpu_weight_nice_write_s64().
> > 
> > Fix this by introducing scx_cgroup_mutex in kernel/sched/core.c to
> > serialize these file write operations.
> 
> I wonder whether a better way to do this is just taking out fair's
> cpu.weight and .max locking into the core layer so that both callbacks are
> called under the same locking. Peter, what do you think?

Yeah, makes sense, no point in fair having an extra/superfluous layer of
locking if it is (also) needed in core.
