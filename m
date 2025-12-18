Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC33CE8D;
	Thu, 18 Dec 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052754; cv=none; b=XfKEy1nqRoWgvVBk6y1SK3Aboa5yI9F6h+o+PKhBs6xwZVyvKuwlNukuUh1SS8R6y8Idn5+0LAHLurgZkrjJOi/J+EYL8v0kmfNNb1jnGhchQdD6YkVygsLmQkM8ggqQvUcEjx3kP5kaWgDCGG5vW7EGxcVAuZEobQISZJT7qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052754; c=relaxed/simple;
	bh=Q2j1pI2gbnZ6Er1qOLlLRw0WtqWwqQYSASs3eDFRQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXCA69TMU5oc3C1G8jLfRVEFZIbzIzvQ6r5ybYRLFRs4VEYRZ3mDJEpgJakLc0hOVv7aXRpSHWLi+ypw9pkri9ttEulQEa4G/D1Hb6J4Uze85/QIBR6iQHjLCFzdRMRVPzZVk9zSLzr7q8To9Auy4afvVGEn+s6dS1XXfrQzJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ocVfmz9A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocVfmz9A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cFttlWF0jgG52QNDRCCrAUH/tOMpNN661+8S5v4EyIc=; b=ocVfmz9AGIaeIiqfBMe8QGL8IF
	fdCF7zrB/ULoBVkSLspw2aRhZJxuWViuH7yUPuGHQQX6R9tBpfWkGHeN8uaK5PrQkvoNwNOZKJVrs
	0VKxXsZAd7lGMOyYakJr+s5hRYWiklMm6WAT81qm2YNwzDpYjr5A54dwIhZuPXPOMKp5Q7XYXMrHe
	LSB3aRJ0cuEVAzJdBpo15FLjGynOBxpDrps5qKp36AICSfXnUQNplTRnkWqFZ83vgTkgZMNRRtSj+
	aQbpNUtBL8RCPMEghDvfQEJS+ptJMx5DS0jL1vXRiYDhomOuyZVob7H+SDxnpAmPqeMRPZwmHHtge
	RN9p4vPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWAzh-00000005yLv-0o7c;
	Thu, 18 Dec 2025 10:12:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E388300578; Thu, 18 Dec 2025 11:12:24 +0100 (CET)
Date: Thu, 18 Dec 2025 11:12:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/5] sched: Add assertions to QUEUE_CLASS
Message-ID: <20251218101224.GN3707891@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.771691954@infradead.org>
 <CGME20251218100916eucas1p2258bd5447be988f61f3358963de1cebf@eucas1p2.samsung.com>
 <a6150003-7f87-4f24-9156-bec10dfb70ce@samsung.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6150003-7f87-4f24-9156-bec10dfb70ce@samsung.com>

On Thu, Dec 18, 2025 at 11:09:13AM +0100, Marek Szyprowski wrote:
> On 27.11.2025 16:39, Peter Zijlstra wrote:
> > Add some checks to the sched_change pattern to validate assumptions
> > around changing classes.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> 
> This patch landed recently in linux-next as commit 47efe2ddccb1 
> ("sched/core: Add assertions to QUEUE_CLASS"). In my tests it turned out 
> that it triggers the following warning during simple 'rtcwake' test on 
> Hardkernel's Odroid-M1 board 
> (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):
> 
> root@target:~# time rtcwake -s5 -mon
> rtcwake: wakeup using /dev/rtc0 at Thu Dec 18 10:01:28 2025
> ------------[ cut here ]------------
> WARNING: kernel/sched/core.c:10837 at sched_change_end+0x160/0x168, 

https://lkml.kernel.org/r/176596899373.510.17191516261088315233.tip-bot2@tip-bot2
