Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6E33A9CB;
	Mon, 16 Mar 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683171; cv=none; b=ON7/XfJLeB3uL8Ka+4qiNIsEhjOkOXa5dz0Nv0O2EFyj6gDT0Mozeo19M/mJWaaPJlO7eSophhc3wGMSjtcsSg95zSl0+ivMe4BX1R1lP/y5UH8cukyzlUliIQ9a0cqFQDBj1tEsj0j1Xli+Su4g+Oa2YrTSQDQ55ZCCEwVBAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683171; c=relaxed/simple;
	bh=JdyaiONH52g+nD3QHnkSfpwNciaHiabRP3Vyfw+Zf7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHDCY1DXgVJ5cu1xeRnuD3MtJwIpqCSfktmjg1aeiTYkFQ5VvQqQUshbLpa4Asd9ZuImfRL9XMX9vMG7PFOAtZYyblkMwe/ivKh5DXgH8Lp3HbofM7NmJg7An2Vx6DB0tgQucq6ffF6KSSnZNMTo8utUcn5NmbNi5Yp6LC3mPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1g1fCaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1g1fCaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A66C19421;
	Mon, 16 Mar 2026 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683171;
	bh=JdyaiONH52g+nD3QHnkSfpwNciaHiabRP3Vyfw+Zf7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1g1fCaKAD9Oa2ohg1wR/i3ByC9m/rMLraUvhcwlpnGOfMDnwNsSBc67w3olyB8bB
	 /LJH/w/Y1qh1OmQ6fmVlgEv8hxUlEvsn8VY8Kt2l6/2JUOTTQk3x9ZJdgMArXEsv3x
	 S4XHwJyAYN64+q4ofKbiNryvTArTJkq+Xg4jqh3tFrCwqCJHYrNG+Tew1/iOFzfQWM
	 Bh4P5FNpWYRHmyiC6i1a+OtnJbhHWG8p3dZyPSNtmFs9L5wAZvK3JQ94u5TMTqrp/o
	 xJPRJiKEJHu26Q9WSIzPJhpGSZVvIF2NORpkkjhU13TEi/MgVIDqe3qSjyQsXn06bG
	 6Ep6/pzd5JCmQ==
Date: Mon, 16 Mar 2026 07:46:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, mingo@redhat.com,
	peterz@infradead.org, shuah@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
Message-ID: <abhB4bCsvd9WDxid@slm.duckdns.org>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
 <20260316100249.1651641-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316100249.1651641-2-christian.loehle@arm.com>

Hello,

On Mon, Mar 16, 2026 at 10:02:48AM +0000, Christian Loehle wrote:
> @@ -5686,11 +5718,20 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  		 * task is picked subsequently. The latter is necessary to break
>  		 * the wait when $cpu is taken by a higher sched class.
>  		 */
> -		if (cpu != cpu_of(this_rq))
> +		if (cpu != this_cpu)
>  			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);

Given that irq_work is executed at the end of IRQ handling, we can just
reschedule the irq work when the condition is not met (or separate that out
into its own irq_work). That way, I think we can avoid the global lock.

Thanks.

-- 
tejun
