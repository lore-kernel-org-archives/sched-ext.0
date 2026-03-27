Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282353783C6
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631941; cv=none; b=AaPJHuk+TkmrSpkr8Omom6crRZ18EhyjfFDeBkL6JgUzcyhA8wTfDfQY8srgoR5R5S6VJQy0s9xvDyQH1GurwFNfKuvDpO9/69KCmgnD7aYRSfHR+dt4RYIr06FjGRkIyTKccK1YkMih/bsRL3J1ldrFGaYsK4pmCC6EHPA4h7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631941; c=relaxed/simple;
	bh=ySFv+dwGoAYVa15VgN31Hltnx1939lHnM4vxMlOyjpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoEYADCEk2QdJ94Sr4riJwfhyrpRcLmi8N8jYL5zhBBlU3v9moxb9y4w/Yv3PW15rkUOv4/SEXvfozCoIYk/rIS82yk5xwj6wxjLNj3MZg/apXHLsDOXO0x3rz9pjx1gKp+mcX5WAmcK18kDkfaUZYZssDkHUTMcrSS80B47ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5s/421V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5s/421V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C2C19423;
	Fri, 27 Mar 2026 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774631940;
	bh=ySFv+dwGoAYVa15VgN31Hltnx1939lHnM4vxMlOyjpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5s/421V09TzYqfGpjFwSymjAb7l8Efj2bPig/577C1w+zS5s17ZAbI36JJnJ0Brh
	 uxuHADpcq4f3/k9DRg1oWrL1DIgeGg+LYHv/F4foyLtF98MMphSArrd1nKFOEBdeoH
	 Jv8SiWZg4JHoQI09A0aW38Et91gTrSHV2ZV5f9zXvRNZB7kxoHqT2Km7PXCXTsSfRU
	 pqgKZ0zVDilW5coQKZqa33w5p4tX1n0a8RW30hBGsIGVfAYx+gbkEJGV2fdVSNqTFu
	 8vqBqO9wWOQQpHw6Jfz5GgPSk8VdKwiIsqd8f2NOaSxhXpsCbYOn5we9iMqCznp4fs
	 TOs+zNML1bIRA==
Date: Fri, 27 Mar 2026 07:18:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <aca8A9UdYV8nElsB@slm.duckdns.org>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
 <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>

On Fri, Mar 27, 2026 at 01:35:53PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Thu, Mar 26, 2026 at 04:09:15PM +0800, Cheng-Yang Chou wrote:
> > scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> > enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> > to rcu_dereference(scx_root) for the non-sub-sched case, which is
> > semantically equivalent.
> > 
> > Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Have you tried reproducing the problem? This is trivial to try to reproduce.
You aren't even doing the absoulte minimum. Before sending patches, read the
relevant code and reproduce the problem. I get that AI makes it easy to pump
up the volume but try to reduce the volume and improve the actual
contribution. Otherwise, I'll have to mostly ignore your emails.

Thanks.

-- 
tejun
