Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0922F50AD;
	Wed, 16 Jul 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680952; cv=none; b=N/KxBg2DJs4Ci8lEah2bITgA8QF8pK29JHKXPCtIfdz7KDynoRv2KTrJNFt0aPfl3k4hQlLOYzMsLoDCeTllZfvXxtYpKag3MTeAvkXoLYr4urghuJDypc41JvQRLKzLEiZuT1ogyRXD1ECnb2YE5WXlHQfZVzTpGhHqrrstcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680952; c=relaxed/simple;
	bh=V6VTJP/iTg77IQdxeEkMZwvp6TxqII/kTjKkkhzQUkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqW9l0IhFtYBqBs0CJM2iGzOg8D1+fRXn6XHkk+9lXOlpVA6v/QNVNHCKgrsRNrFdt2W5jbAlppIV9oCkFC5e58nT2w2ssJrIXo9mW6dRRrDkUhm2hqUtrsERkOsJssxyw7GQgbqCj+g7696f8rytcgfIQECO7tGdBcsJP70fsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y3l1Mwg1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3l1Mwg1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zjwmgLnVqEYhEG2CmzzL7AxDmsZViaQkBsDm8zDAvhE=; b=Y3l1Mwg1LBE2YZ+tCnbnxlh8dF
	rsmFxrIHh7WwFdEaiqkxQCJvam7brWZG5haTfVKVhmlJMighT6nvTQzG/RfmOShB1UkbrdHp25cc1
	SelR/CXNzOFes9M/499VcTkatjU1jNUJh+qUQ3WJvdbqFC/N2NTmw4q4gef9EU9cUBd7OXJdZfb2p
	U5O8GccedCXMP8SZAD9R1pD0BmqtZpoEQOdnRcEW6yLc2Dxg1JolDIO+sxIjPdHNF7+dkfLfJhJ3F
	BgN8Nc+R4aSsv9E9E8ZhOr1OZqAaLowa/8XgX2o9f03iaW4Z1WKIXCQBRVcLnVBZJEwPJFDC6NabW
	wvWFU6AQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc4NR-0000000H2nk-3yAw;
	Wed, 16 Jul 2025 15:49:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 430FA3000DA; Wed, 16 Jul 2025 17:49:01 +0200 (CEST)
Date: Wed, 16 Jul 2025 17:49:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716154901.GA1613200@noisy.programming.kicks-ass.net>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
 <aHe2j6pIyQiBf1S_@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHe2j6pIyQiBf1S_@gpd4>

On Wed, Jul 16, 2025 at 04:26:23PM +0200, Andrea Righi wrote:
> On Wed, Jul 16, 2025 at 03:36:31PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> > 
> > > The idea is to track the scx callbacks that are invoked with a rq lock held
> > > and, in those cases, store the locked rq. However, some callbacks may also
> > > be invoked from an unlocked context, where no rq is locked and in this case
> > > rq should be NULL.
> > > 
> > > In the latter case, it's acceptable for preemption to remain enabled, but
> > > we still want to explicitly set locked_rq = NULL. If during the execution
> > > of the callback we jump on another CPU, it'd still be in an unlocked state,
> > > so it's locked_rq is still NULL.
> > 
> > Right; but doing superfluous NULL stores seems pointless. So better to
> > avoid the store entirely, rather than making it more expensive and no
> > less pointless, right?
> 
> Right, we can definitely avoid rewriting NULL.
> The following should do the trick.
> 
> Breno, can you give it a try?
> 
> Thanks,
> -Andrea
> 
>  kernel/sched/ext.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index e231450768897..c76d6c9e497b4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1290,12 +1290,15 @@ static inline void update_locked_rq(struct rq *rq)
>  	 */
>  	if (rq)
>  		lockdep_assert_rq_held(rq);
> +
> +	WARN_ON_ONCE(preemptible());
>  	__this_cpu_write(scx_locked_rq_state, rq);
>  }

__this_cpu_*() implies that check, which is how we got here ;-)
