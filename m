Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA037C0E7
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768776; cv=none; b=dB97DhV4kpAB+PRE0nw6V8dMGYu/TiFpAZSz7KjcHbDfSUizi75Fac5nTgkH1EON1ekl0T910Ob1hEnTI+YGeE4ol6u1zbidWJtx6IUsTHDzcFiPPae1TA+s4qb5LMVJ+RTFCWdX6E7WSJ2mqsc7y0uzqbtZrveEb79ZbzF/Sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768776; c=relaxed/simple;
	bh=lJ9qjvoIwEU8PqrKJykwXySsjdyWbOi4v/7dSh76wFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0t/GkSPUJzWWpc1nRexWDjwUCoJELlgvxsmF/LoMq9UXFIV+z3QSXuTf53BBDKkaVDFb3howcLDfPsdEd9Xwh1dackG6hQ+Yn4iPPRg1Tm2fV4ppuZObYY1XMzZ9skNVomSQ5td7mnbja1P3or9Lk6hYA58GjshL1AThLCg0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjmPYFJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjmPYFJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69D6C4CEF7;
	Tue, 17 Mar 2026 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768775;
	bh=lJ9qjvoIwEU8PqrKJykwXySsjdyWbOi4v/7dSh76wFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjmPYFJrLf7V33qmIOxW91C3gHJkla2ZfcZ2LXt4nv/5wgxQPilKpcKlVlg+oxFf/
	 gw0Y1vaAmBAzOIOz1XLBCL98K/ILCqbVuWTBs1/AIOqBFMrwphRTz913uZRfqLCfj7
	 mZRGMqpUhD0boItuEjglQvYkjBAJkiO5YL76PpdSKxmjFXdSXJE2uTAMJQ8anIeXJp
	 QulsfyP3BN9N3IcuObWY2CQQeg8aApr1ynp3EBGIy2L30oo+AogjtnS3W7/6koTPPg
	 iPmdHTOueDrMexr622KTJ11r6bkA3UisR4XOxrOBJ8059WSGhJVuNqMC6vno93/ilw
	 DhzCDytzn9Y2w==
Date: Tue, 17 Mar 2026 07:32:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in
 scx_idle_init_masks()
Message-ID: <abmQRgwQZhZk9-_S@slm.duckdns.org>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <20260315181017.1377138-2-yphbchou0911@gmail.com>
 <abgnBgO83uXd7Xq-@gpd4>
 <bwbqaaeptqcjfuotszesmckmkept2o5exdkbn67nx7uz6bwilh@mlrjlhh4ovzi>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bwbqaaeptqcjfuotszesmckmkept2o5exdkbn67nx7uz6bwilh@mlrjlhh4ovzi>

On Tue, Mar 17, 2026 at 11:04:11PM +0800, Cheng-Yang Chou wrote:
> Hi Andrea,
> 
> On Mon, Mar 16, 2026 at 04:51:34PM +0100, Andrea Righi wrote:
> > Hi Cheng-Yang,
> > 
> > this has been sitting in my TODO list for a while, so thanks for looking
> > at it. :)
> > 
> > Comments below.
> > 
> > On Mon, Mar 16, 2026 at 02:10:14AM +0800, Cheng-Yang Chou wrote:
> > > Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
> > > arrays that store NUMA nodes sorted by increasing distance from each
> > > node. They are allocated and populated once during boot in
> > > scx_idle_init_masks() using the existing for_each_node_numadist()
> > > O(N^2) traversal, so the cost is paid only at init time.

Wasn't the conclusion that given the low numa node count, O(N^2) doesn't
matter for now here although I can see node count becoming high enough with
AMD fake LLC NUMA enabled on an actual large NUMA machines. But if we decide
that's an actual problem, shouldn't it be addressed in the topology code
rather than from sched_ext side?

Thanks.

-- 
tejun
