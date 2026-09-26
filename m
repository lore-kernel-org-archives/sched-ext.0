Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F571357CF1;
	Sat, 26 Sep 2026 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450254; cv=none; b=R956cBfK3gl7YUuSauA6Z36Hagjr0WfQ7ajxMZuucB0vJWvxlUXAa9KulcrxDpTnK/HYT0CLoy7gDVtJgISnCNzxuEVpt4KLJSSm4IJVb1r7tO0P8xI9X97i45S39b2iZWWZo4XCwjBwMCudkl9GvBw0Budu0i6WPdXlC/37U4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450254; c=relaxed/simple;
	bh=oXAIQPm9mmKrLu1oiV7R7C0VnJLzmC5RJCj/XayvByM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZo6+luWsoPfrxwAxz5YN2SVAUBhsCBig04dqRthJkrD3lFKkesNPV049qosQgWZbiOsu8K8vyp4wognJGOoyzPxBocwsIi/Ja+P5o4gNfyN0RR6NeIp4Aglbrv1FiKSXyW2v+TUnUQ0MTPEHUV0q3vpBFscs+TLJCo9qH7B1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLEaivj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLEaivj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956841F000FF;
	Sat, 26 Sep 2026 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790450252;
	bh=rACVMzVza/EoFDBKHIXnfC8ZM6I7ZAMHz7JqFeTKzEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLEaivj9ojNlIQU+b+lQdhe+CS9ixFWcfHhNsWtcVzayPWVfaASBQn3CsVHmlyzmk
	 RdL2/EL+cY3K7qqMO0F4ja3SP6+TbljPid8RW3sjJxo/p64PYPNj9MUTA5tCH5GCj6
	 +ZKFptotLVwxWF/5pVJmQPmlBTyswXH4uSospSx53cd5LbfESKSp67UloS4kvYZQkH
	 BI2IJ5VAzmvCHHAoUAVVlecbY3mOdhAK/eT75vgaeZ39aAtw5zyfkwQg+Np0kNEuin
	 k1jkHjI5To8UPAxF7mdKthXlxNATS2s8oUgKXbwZCPmcKrT+Xf0fJCrRH69gZz3MKH
	 oGNkbKlE4kICg==
Date: Sat, 26 Sep 2026 09:17:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <argaS0_-6V4l9KGq@slm.duckdns.org>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
 <arYm4PPMhevWQWsK@gpd4>
 <20260925075628.GI4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925075628.GI4121339@noisy.programming.kicks-ass.net>

Hello, Peter.

On Fri, Sep 25, 2026 at 09:56:28AM +0200, Peter Zijlstra wrote:
> TJ, would you like me to take the sched_ext part of this series too, or
> will you pull in sched/core after these land and then put those patches
> on top in your tree?

I can pull from sched/core and then apply sched_ext parts on top.

Thanks.

-- 
tejun
