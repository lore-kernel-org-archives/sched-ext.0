Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F03932C0
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640896; cv=none; b=ndq60yo5C80u8egaB4nojD/6J0UeBZ/u61W0slJvCFYVTCrrLTjEAeJJU5+27VanzfuuegKee/Wyzxc/vBYysUYJ4c+brAMbXHvpmGXfJNywWkPdh4nVsYKxavW5S9sJTIUzUBaU6NGKg2m2BI+uI7kSH/6GRQG8rWj+OQH7s6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640896; c=relaxed/simple;
	bh=GtO1EnQFH9nsoz/XWsQSEmkF3Y0jL27TJPCkutKtYMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M06uWj5ACj6F9Uhh5yRouD82Xm7jkv+hPQ/hm1Z5SirZu/3yG/Il8jl6uGha215LgdTXC07thZ+fvO6nsqOULjOUKmTpzWt62P7mjqDNW8aZWvZOm8M6B4vNCRVF1i6fnmHOXwzn/F4sRUNGbjHn2LGlx5nGSI+Po8ePVRWoP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCDpedvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCDpedvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565ADC2BC9E;
	Fri, 27 Mar 2026 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774640895;
	bh=GtO1EnQFH9nsoz/XWsQSEmkF3Y0jL27TJPCkutKtYMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCDpedvjya7F6HS0hLvCItR/jYpMB+teDvgiLogvBE6cuy7E9y3MTH6J6x2YrtQ4c
	 W+h519po0RLaP7+Sum5oqc7t//myCcNTec6QbE7AUoc05nrZdka9MGYQKfYPUGKEkD
	 AAJ+tWDum/TTaXqXexjMp8UlUHesNc237gozVpI34uuDTU3UeK0l0qWTa/o/9tZMum
	 m0yc2wlfzWrwd+d/Kqo4hFKYYT5WYKM4BUN7I1HTacO/2COL4y5cAai63BpAxW2nLI
	 Z2kCqaJ3Gkk2aQz0RLXQsRVkF9T0C3XNdcDxLBkueuqEzNDU+9S2C5QctKeQdUDDgJ
	 MHTV2wlMPR0aw==
Date: Fri, 27 Mar 2026 09:48:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <acbe_sjJmLVHzNup@slm.duckdns.org>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
 <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
 <aca8A9UdYV8nElsB@slm.duckdns.org>
 <gunjxqantrttj335ai73vkvddqj5swkkfwvm5abkwprhiwjwwz@wktl537f5qim>
 <acbPa75X2LMsUUnv@gpd4>
 <rifaebh3yg7awjrfhbnhbs4gshbynt44uqje6guvs76osgly2d@zvry7xpcdsok>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rifaebh3yg7awjrfhbnhbs4gshbynt44uqje6guvs76osgly2d@zvry7xpcdsok>

Hello,

On Sat, Mar 28, 2026 at 03:01:45AM +0800, Cheng-Yang Chou wrote:
...
> I see that the fix, and I have verified the build passes there.
> I'll make sure to cross-check with the latest branch next time and not
> fully trust the robot's base tree...

It was never broken. scx_task_sched[_rcu]() were added by 88234b075c3f:

  +#ifdef CONFIG_EXT_SUB_SCHED
  ...
  +static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
  +{
  ...
  +}
  ...
  +static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
  +{
  ...
  +}
  ...
  +#else  /* CONFIG_EXT_SUB_SCHED */
  +static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
  +{
  +       return rcu_dereference_protected(scx_root,
  +                                        lockdep_is_held(&p->pi_lock) ||
  +                                        lockdep_is_held(__rq_lockp(task_rq(p))));
  +}
  +
  +static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
  +{
  +       return rcu_dereference_all(scx_root);
  +}
  ...
  +#endif /* CONFIG_EXT_SUB_SCHED */

Just a cursory look at the definition should have stopped this from
happening. Actually read the kernel test robot report. It's saying it tried
to apply the patch on non-sched_ext trees and that led to compilation
failures because they expectedly don't have changes from sched_ext/for-7.1.

> For future robot reports, should I strictly follow the provided reproducer
> steps, or just apply the robot's .config to the latest maintainer tree?

I don't think it's about having specific procedures for everything. You
can't guard against everything with proceures. It's more about the main
principle: read and understand the code before sending patches.

-- 
tejun
