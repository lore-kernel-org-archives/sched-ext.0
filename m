Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37953BB9EB;
	Mon, 17 Aug 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998271; cv=none; b=f64fZFZxIKiuPUQhJwtgoXKENT6o5YgJFAHJSotxg8bCUJ9YxyHUP9oQpsFS5PFa7V/LbNQNzY8HeE/C1pPrK2cv/GlIxRe462QdNHiLAycTmblqugdYI4HnwZEPMUNaCGTuKmTDo2fMHsl0sYDDiOHXjmWg7bdGyCtThh+9bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998271; c=relaxed/simple;
	bh=/NSBNG8RzcXDRiB0FQ9kcRWIpVItWmLem6kj6OaPDTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPey+0nu2a6OjcR3uqWr/7tuTqmhPgsV/g2lDRxs0ouFejrcOMZU9yYZrTRBafCbn3k1+dTo6nP1WtAB1Xp8kJpDM4Z7f8NYC3ReYY0NuH1V/j/aendjAQowX4g1WkG7k2PA1y7pMTmdkWDE5NNywk83O4XWFNIOoGFyu5msXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJZGPQ9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJZGPQ9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771621F00A3A;
	Mon, 17 Aug 2026 20:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998270;
	bh=PNvZCZGxcP3YNx9ABekBFQEOnTYnjTH0mqihmB2ErIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SJZGPQ9xDweeJkD8BVaYza2VNQgOxx2YJh87/NkWg1bbaoaBDngSjb48pnKPteqea
	 CsVFbr3shS2zvXWNOm/H+wLvygAk/Jox9SsZRKkRGl82bMjZkYk2y5epahFKOCmpTZ
	 /1jrwxG0YWpgfOV20CH0/88e7w+CC+lopMFSE+VX6vOzyJpIaSFkJUYuAS4BjFLal1
	 r9bucvl7L3CGRKho1UTE4gMbMakmuS3Wmg74cAzi5ZyvHAzxwu8QRClAlXF8tznlri
	 iYfsKyoa0sc57qo/QCyfZ0PY0VK73XS685RrcJ8qFSwcQE3glxRl5iQeKjQmXKuPFj
	 TL/EWG+FTy3hQ==
Date: Mon, 17 Aug 2026 10:24:29 -1000
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
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aoNt_Rhdwl0NCFOJ@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-15-arighi@nvidia.com>
 <aoJ5q7HbSUOxlC1H@slm.duckdns.org>
 <aoNawphy4OVGU4ex@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoNawphy4OVGU4ex@gpd4>

Hello,

On Mon, Aug 17, 2026 at 09:02:26PM +0200, Andrea Righi wrote:
...
> So there are 3 cases:
>  - task_proxy_move_active() prevents moving a donor that is currently running or
>    donating,
>  - task_cpu(D) != D->wake_cpu prevents moving an inactive donor whose scheduling
>    context has already been moved to its owner's CPU by proxy exec,
>  - an inactive donor that has not yet been proxy-migrated remains under BPF
>    placement control.

I think this mostly stems from my not understanding the full picture, so
while proxy execution is in progress - the donor's context is running the
owner - the execution cannot leave the owner's last CPU? That *seems* to be
the behavior assumed by the core code. It's a bit odd that the owner becomes
essentially CPU-pinned.

Thanks.

-- 
tejun
