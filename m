Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FD355F46;
	Mon,  3 Aug 2026 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795751; cv=none; b=RUfNWMMLs/qTeQxBBM9Y2Pxn0NOHV4p75x1cl4g8Cf1FPJDs8VBoAzj+0vLVydDQ9p3gwWVMaDf2WGKiuBLpuv3gCrs+XJY9cf9W5g5IgwRRlSXbpqwKK/3lf8BqIYnEHYzntN+dHq5Il760q43viVj96Zwmqs1DL22AJ3W1erM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795751; c=relaxed/simple;
	bh=GmCxiF9U9OrBtre3mQsfmCkPaRXph0IdtBoq9ll+H/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK9mMzEiL0FgnlFS/C209fVt04YFoXtSjYwcIgMX93uxv+vBiCY0p0qnJEX6Q6IApxHhGFqcvo2nLuXINPnxrv0OTAnmAT0W/KbxeMicLq3iTLg9JNKyXgCG8uPGVYBSelbzY2BjHVYIKj/lsObUleYHcAOZtxh8B3OWNNeACVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEOJaYY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEOJaYY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982811F000E9;
	Mon,  3 Aug 2026 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795748;
	bh=NAM6iwQoDGuxF9bQGGEnqMxouDQKDttG+RxTJKOzZr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEOJaYY6DvjnmHlygQLpwHqsfJODne6DVQ9Idp8VzFZ5qZH5OVcNWTtct+751cjGB
	 QCGE+vR9XkpOSqW61pFG8F8DSJST8Ugvs0eD98gUHxcNLlSwFqmrmiT+jttYAXqJYK
	 hcj7CI/Zr7W6RYzKgAtTB9+0AtH1d5BA4zMJNOifFHMr2EEeTvUIxaCYUlvVDmlmP9
	 Aaovh7EOC9Ge2BuPl/HZr5rM71rf+k0/FTRAkY4Q5U4J7Hna+hFDuM/rHQvnudvZxV
	 COs/mGgaueSdv/Dj0q+3itm6uHN36Evs6gDEHfkhIDkjJaAxKHsrNU3ztsBpaH56PQ
	 DLoD7PhwV/+KA==
Date: Mon, 3 Aug 2026 12:22:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 14/15] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <anEUoyw_JnTpUQZZ@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-15-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-15-arighi@nvidia.com>

On Tue, Jul 28, 2026 at 05:43:32PM +0200, Andrea Righi wrote:
> +	 * A blocked donor rejected by a local DSQ must not be dispatched back
> +	 * to the same DSQ immediately. Move it to the global DSQ so another CPU
> +	 * can pick it up and kick an idle cid to accelerate its consumption.

My mental picture isn't complete. Can you expand on why this block is
necessary?

Thanks.

-- 
tejun
