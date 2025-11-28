Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7730BF70;
	Fri, 28 Nov 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327867; cv=none; b=uIhp5euiHkYAQjw2IpzK8F9E/PXVZQBgrlC+EjuqKm4aJFpL713e6JCbi+ve/jMrjT/U9s4ZYjOe2eQAZu58+gY09niCSGie7cqxvrYURF1UJdMweSu6JpTNS3b3ZkwsXEDK+UWJvfXwIImwhkMMj6B4bWe4JEFRaqTpLDjazEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327867; c=relaxed/simple;
	bh=AFxWITh4OgIkrtFSkPqIKwTTgsQBAo5rywujIFT130Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOxDlAfKN+TtbWteCE03NlDfDKbRUXKcRGK9cw/AxZNmaVgldKZzlGUpHkqXSlEQ9Ahp8L0xskbT8MtEw0ochhEhcB5mv5JFgfVtdqQel73qPZrUrlTpWpYM1Tmdto+Pdvuwvy79XFtTjJubrDU8yrQD7xSm6KD7WdkCRz9MB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lG4yjCFC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lG4yjCFC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sdlV1nnoj0E2OH02DlC+wLGanNT+HR0gjnrkSL7bYvI=; b=lG4yjCFCfgt3R8HHrOND84qUk3
	twWcoE7Eq1Y+elwIWSN7I3V3sDXmhsfxFxw+qyYtFhwI+t6wJepa7WzPbXPNjX7qS4m+pguoYpnKm
	SjSN2RVyaZMF0lzROyn7IgbZ9nDTv7H9b5rx3jcOcERjUyjSFyLjfx7oDilSkNpLqSENeq5eghQhG
	MXVQH6Uu4AuoVMBu1QgYSg14Q8xjsYZ5mXWw83PKNaHORckWzw/AFCcKV13egx7417tnLQgCKxOsA
	7KZOA7+3wMGYvb4kBRQS/ciLzFSlPBGS0ferc5j0FMPcQPYetUqus8pgQ3Rjx4xyR5DWZgFRYSS7Z
	oTcj3CHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOwGv-0000000D6JF-3iXs;
	Fri, 28 Nov 2025 11:04:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CC013001D4; Fri, 28 Nov 2025 12:04:16 +0100 (CET)
Date: Fri, 28 Nov 2025 12:04:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, vincent.guittot@linaro.org,
	Paul McKenney <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/5] sched: Change rcu_dereference_check_sched_domain()
 to rcu-sched
Message-ID: <20251128110416.GR4068168@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.647502625@infradead.org>
 <20251128105723.GZ4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128105723.GZ4067720@noisy.programming.kicks-ass.net>

On Fri, Nov 28, 2025 at 11:57:23AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 27, 2025 at 04:39:46PM +0100, Peter Zijlstra wrote:
> > By changing rcu_dereference_check_sched_domain() to use
> > rcu_dereference_sched_check() it also considers preempt_disable() to
> > be equivalent to rcu_read_lock().
> > 
> > Since rcu fully implies rcu_sched this has absolutely no change in
> > behaviour, but it does allow removing a bunch of otherwise redundant
> > rcu_read_lock() noise.
> 
> This goes sideways with NUMABALANCING=y, it needs a little more. I'll
> have a poke.

Bah, so I overlooked that rcu_dereference_sched() checks
rcu_sched_lock_map while rcu_dereference() checks rcu_lock_map.

Paul, with RCU being unified, how much sense does it make that the rcu
validation stuff is still fully separated?

Case at hand, I'm trying to remove a bunch of
rcu_read_lock()/rcu_read_unlock() noise from deep inside the scheduler
where I know IRQs are disabled.

But the rcu checking thing is still living in the separated universe and
giving me pain.


