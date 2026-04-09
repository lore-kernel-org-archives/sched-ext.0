Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0F21771B;
	Thu,  9 Apr 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697300; cv=none; b=DwhZDDC6T8G9JWwZd9WgHJiDjFuTrxuH8QAEyIsYNtT5zD0tZn8zS+wM/mxl1bGNPBWi9ZHLshYOmHW4c9jHBaX+ryu/zRObbYttlndL9tldE1AWIoyTY9S3zRQ+xbX7KYmTtmUajCAFJ1dt+1v8kRkn5nwDNQ+HD9dmt7Aq4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697300; c=relaxed/simple;
	bh=F+R+IdLDTAz3uXDVZvNzORTw+8TGENuOJgRaiugnua4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6qm7jPxXpoaDJ3rRl/xTkLDqfDPXnmz599jw6kp8TFdbekfiNU0xacSdgnbMHUNSwVu9c7eGQ2NrDPptuXAmnpXld5r04iy5zH79KCfofJJDXTdFGdyqdMghGN1j39sQPb/EFkYLmiD3Oi+4uo94j7dFKYeUGitYMFjz7ABjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnszZYX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnszZYX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D103C19421;
	Thu,  9 Apr 2026 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697299;
	bh=F+R+IdLDTAz3uXDVZvNzORTw+8TGENuOJgRaiugnua4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnszZYX+GeyItCee4gpC+TLILMjr7ruLbWTh3Y22PXzaYgFytDJ5CkVRVZABkx4Sp
	 yisQHxY6QO/4tzN3A/k2wenAcgutooUz1HFK37IB5qkAWhgyyuYCsSPHjGexaLqM7L
	 2dUIXZW2Zkrpp7ZsoB3+rrB3FueFMXpYqmQGVaIBlWCWoO/On+d7kvLzj5Rsv1F51K
	 cK8VDNHY8mazQvDuzKQWPCm6owrXEmYAksVVe6idEx0O9R4/zrfY4Uitx20LeXsaoE
	 Bms8R90o2gHLpuAIry4pZjPCO/sZ6dp02XewOkqg+ewSY6sAINEd4pWVPQlOuT1LNs
	 4uvhry9SOabkA==
Date: Wed, 8 Apr 2026 15:14:58 -1000
From: Tejun Heo <tj@kernel.org>
To: KobaK <kobak@nvidia.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/ext: fix cpumask leak in scx_init() error path
Message-ID: <adb9knvhHdYaqhAP@slm.duckdns.org>
References: <20260408172312.2178104-1-kobak@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408172312.2178104-1-kobak@nvidia.com>

On Thu, Apr 09, 2026 at 01:23:12AM +0800, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> In scx_init(), two cpumask allocations are combined with || short-circuit
> evaluation. If the first alloc_cpumask_var (scx_bypass_lb_donee_cpumask)
> succeeds but the second (scx_bypass_lb_resched_cpumask) fails, the first
> cpumask is leaked.

This is an initcall. It runs once and failure is a kernel bug triggering a
WARN. It won't fail and error handling is meaningless here. Once you fail
one of these, the system is not in a good state as later code paths assume
that these succeeded during boot. Not freeing is the least of our problems.

Thanks.

-- 
tejun
