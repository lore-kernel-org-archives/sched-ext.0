Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DA4F4738;
	Wed, 16 Sep 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555315; cv=none; b=keoCefG1Abbxi+f1/cUENt10EQjUZ2LLQR+tsiuGTqRyZX2Swgiw5aaR2Scr5hgN1M8xOWBozEcaEQCHhs6HI/q9uLaKF8cSTny0G21eN4IGFnyELHRW4TTf9ZgmjvvpPk7h9WKrIZCx4XSdVvhtxAhMSuyr9Iubp27P27iAhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555315; c=relaxed/simple;
	bh=t9CvJTvDg0lboK/l/7xusm5uF52sLbSx0E1G/42kCX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U186Z3Kv4emEk5IaPJHmbnzr4qboQdhAFKd/Xe+RhcDmiYnTgRbFO9r4IXbIc0lRwaMsLiMK27cXyYhC90yhfusx7Wfnc9p8u+7Bf1+agU+3IriSEMNwJfdKJ2VlVW/TdGR6Z3Ggi+gTKMdgNojKQdWyMEvRGr2TMVULsCv76i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mWh3fwTr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWh3fwTr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t9CvJTvDg0lboK/l/7xusm5uF52sLbSx0E1G/42kCX8=; b=mWh3fwTrIk/iSiX7NVkWofX+53
	H9AI+4WZhWTZLY+x8bOrIJVb81h4twdQ6fvIiKqPP/16boYzDE83BpF/9aRiXVCYt1aR+m8zaOzC2
	f1s+VtycIDuwQ4dP8LK236d2BxZSmlIwc+E8BCJxmY8fZrH4Rb0oQO4FDxeRFH8AaiaP36UBQ5zA0
	Qs9H/ONEU/pCCRAees6t42huuup1p+ALBRVWJqf574NDs5SEbDrxkeCUbRoUhqrgL2ieJoALJf7Ds
	BWDNpjUYamnmwyn/9FNufcCZJxo9i/oRbBIsz5ykZwe9I0gpGWrqHhxpTtO3TPGHo7EuA7ZoYxTH/
	V/ZOHoHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6n4b-00000007kc4-31H2;
	Wed, 16 Sep 2026 10:41:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2A183012C6; Wed, 16 Sep 2026 12:41:04 +0200 (CEST)
Date: Wed, 16 Sep 2026 12:41:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Message-ID: <20260916104104.GD776954@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
 <aqmw0OT5cCtge-QI@gpd4>
 <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
 <20260916091908.GG4121339@noisy.programming.kicks-ass.net>
 <40a61874-4841-4e38-b22b-6b8c30667340@amd.com>
 <20260916103043.GC776954@noisy.programming.kicks-ass.net>
 <62d8da7f-fd6f-4e65-8e6d-520d39d55570@amd.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d8da7f-fd6f-4e65-8e6d-520d39d55570@amd.com>

On Wed, Sep 16, 2026 at 04:08:48PM +0530, K Prateek Nayak wrote:

> My bad! But what do you think about having a bitmap of allowed flags
> that lives in sched_class->flags and is checked at enqueue / dequeue?

I've considered that a number of times, but never quite done it. If it
helps sure.
