Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F422FF675;
	Thu,  3 Sep 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475907; cv=none; b=ikfep6CFq7JymKT8A56upwwUffwwR+8nAeLgDe6LyccsTCNLiLx/6i765XOHCtSzDXo4ESGXm5D2MkNTt1eVrDsYaQtCdhtdwP9rL3fZcpDOMFKZmHqn+e8mqRf6IqirgCG+okB7J9s/df12+49f95bVJCH66GrsYwQ3KNNoro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475907; c=relaxed/simple;
	bh=Qao28PMwPDwGpzt2tJnwdYx8DC4qF/msjcKDuj+JIvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvx+YjekTwoNNxokA81iXw+dbT96Kco+fbfAUp+FRGEKyJ0EVhhzpQmukdUmMqkTmFIAj3qPLZqddFYgJXAG87jpDP3kp5yn6/k5Jp4gZGvPzSBBeNIvRU8fe7Xyz1Lczgb6mLb5mnQckzMzAYaqAjS0FLF5jhj8cQ1aUFdrS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmCE0Qh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmCE0Qh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574FC1F000E9;
	Thu,  3 Sep 2026 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788475906;
	bh=B8aw6NRJYaAfVoiwDPClSHmYgT2Dwig7v9HfzVUnaX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmCE0Qh5NXbNUformwnvTN57LpbPc0bw20dnkX4dKpdRkVM7B0oPnoMQLuw83rgiN
	 kmek9MAw58iH5EJ4VFj1npkzx3DOuUb+bx3KlQQ2XwV/hr+PlReNa7k+xk5tMbVwYc
	 5GZyVzXljihuMrFOL3AkL//o13nS1iuJ3JRPdKu3Bv1UOFs9Nj0141nzw7AOAA/fw/
	 Ep8AP0rVys6oOvlxPUnkN/k0LQkuy34GSdQW6ZDrLKMcjcXD1108abs8eqTr729wWP
	 qaD7OWEUPiPUh94QGNGcHObXfyNt4/VupKk7DK3dL9MmrFqBUveT8B0pbIEVxp9ZmR
	 uIxtk7+AhcIbw==
Date: Thu, 3 Sep 2026 12:51:45 -1000
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
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v13 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <apn6AdgyTr0btXDS@slm.duckdns.org>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>

Hello,

Other than some nits, generally looks okay to me from sched_ext POV and it
looks ready to merge and iterate in tree. Peter, what do you think?

Thanks.

-- 
tejun
