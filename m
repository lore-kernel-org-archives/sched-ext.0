Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB942BD012;
	Tue, 12 Aug 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985655; cv=none; b=OyUSdjJuDX4RbiaeVk6T8GD2lgB9+gdvydsRO29Kmy2JDn40IA6YNo4Rd6Q1r+XbIstJuGbV6iXqjvWa5dt1hM6FIzVLiHZEX7M7Ficz5s+iVrMGfmJ9RLWNmszLyY0SklrRScGDeN2m3gKXTahXjtGxaM2MNuraqAlCp70rFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985655; c=relaxed/simple;
	bh=uyEtLXeLg4FHmnligzjbn2MdDoRRq4bB6zO2ymBoI8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPDrcKuI9O3XwC11t0W2oTOZH5cKgd0BT/M3+lhJnB/ro6UemmfaqNaGNjWgDR9El+RFybOr7B5qBviZBiQjfVeUuV6JY89tWd0hgRyD+SLEAzT5XpurEJC2RXgNkmelRLoXQhacNdIAoHYFZ4rg2yuTcIpSnriqgegLdblQ4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZLkIo9R/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLkIo9R/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wlmUP0bvh7oStSsT56tZcpB9xFZY6Z5hBSuWAqL4Ejs=; b=ZLkIo9R/mEzx6Ei4GgNt9pxcUW
	/f5duMLQg4WvcKAvpaYEZN0btxfEJXZBiXzX/scUAg8VnrULricim/D8CMQYQ6Fyw29oUVEuKuIdy
	6nE1p4+OYXXUUnKP9Ppbw7lEPDEVlOUpp5b5I9axsiNI3R6cWYvZZA4svQcEF4qxBN6WV7+/oi/eO
	7f/g3uYLBkSEqiNFUGvdevxU/jqBTgEYM01kqLf5sWEukwXlYiYXvIBl+IRG+NNdIKEOWmQiOOhhx
	21sfgEvEAqn4rsMkT93uU+mTrG6g4ukDKrzyc3eGA8+BnqwvjBvxEWuZxev3Rk78Vrk5rNAKTFHeT
	Ikc6ravQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljw6-0000000E8eQ-0wNK;
	Tue, 12 Aug 2025 08:00:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68A433002C5; Tue, 12 Aug 2025 10:00:46 +0200 (CEST)
Date: Tue, 12 Aug 2025 10:00:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, arighi@nvidia.com, void@manifault.com,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com,
	jake@hillion.co.uk
Subject: Re: [PATCH v4 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <20250812080046.GF4067720@noisy.programming.kicks-ass.net>
References: <20250811212150.85759-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811212150.85759-1-christian.loehle@arm.com>

On Mon, Aug 11, 2025 at 10:21:47PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_task_acquire_remote_curr() that
> doesn't expose struct rq and provide a hardened scx_bpf_cpu_rq_locked()
> by ensuring we hold the rq lock.
> Add a deprecation warning to scx_bpf_cpu_rq_locked() that mentions the
> two alternatives.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> if (!p)
> 	return;
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_task_acquire_remote_curr(cpu);
> if (!p)
> 	return;
> /* ... Do something with p */
> bpf_task_release(p);

Why do that mandatory refcount dance, rather than directly exposing the
RCU-ness of that pointer? IIRC BPF was good with RCU.
