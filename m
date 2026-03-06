Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191741C0B8;
	Fri,  6 Mar 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820850; cv=none; b=C3kE8tPuij3VDmm9bcz2Foq2YLopqWQ7BVwN98LKfD1VHCb3DhoO3vJgh+DLq5undLtGOU9An8hKmnbRPAHv093VEFRow6008Mlb0+vaaWrfE5kSTwVw4+jLsx8cRLBBGSx9TjqFxTj4NS6k8HTzG3HjDcFzaOPcrN5I4hVcX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820850; c=relaxed/simple;
	bh=zoLHZ8DDfSsm4d+jd+7Y6eGvTFtj00Go6tucsYRUtiU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T5FFodRhND8GFKmq9nCrr1JIez+asZML5q7NIsbORPx3cdGR9AIHI5Uqpvpc320gATsIH7RwjEOymJQ8+XgqOxG/ykDZLYgmOyzoxuAU3L9S0wbhWtarIZferOhA/HfnjkMllsLQCrR1Yco57Sl51QQMSsfclGFQrMuL8muawcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekTxZWNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekTxZWNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAABC4CEF7;
	Fri,  6 Mar 2026 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772820849;
	bh=zoLHZ8DDfSsm4d+jd+7Y6eGvTFtj00Go6tucsYRUtiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekTxZWNzQyEGaTsMqzY3dxZtiWwX1mHrxjebK3hef64mAa1vFVbE1rQLSVTnSh/5D
	 1fUg94AjqlQZC+LFSpCD+gNNu91qlBfObDct9FRejGnhxmrQ833OedCg5ef3A54W0n
	 kRpQ2bkYE7aGW1KHIdNBo1qCD3C9x1UMUg/h5y0wjC+hsjIFx575vCsD7ojNNaMG7A
	 Nkgwxrm7x/hvzeW42tEQ7CFeYdz4b4JqegFR3+rORsDPaNB1jRmMWN/v5lAtidFWTp
	 VeMYuml2zFtVmSpbJrFbW/ERQxPYgTBGBhdiq44nbmokzBf9FdDPBZJPJv5cHLEnFz
	 71YgZG4+FndLw==
Date: Fri, 06 Mar 2026 08:14:08 -1000
Message-ID: <d6c4d2531455e6505108726bb41e4dd0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: Re: [PATCHSET v3 sched_ext/for-7.1] sched_ext: Implement cgroup
 sub-scheduler support
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (34):
>  sched_ext: Implement cgroup subtree iteration for scx_task_iter
>  sched_ext: Add @kargs to scx_fork()
>  sched/core: Swap the order between sched_post_fork() and cgroup_post_fork()
>  cgroup: Expose some cgroup helpers
>  sched_ext: Update p->scx.disallow warning in scx_init_task()
>  sched_ext: Reorganize enable/disable path for multi-scheduler support
>  sched_ext: Introduce cgroup sub-sched support
>  sched_ext: Introduce scx_task_sched[_rcu]()
>  sched_ext: Introduce scx_prog_sched()
>  sched_ext: Enforce scheduling authority in dispatch and select_cpu operations
>  sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime
>  sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
>  sched_ext: Refactor task init/exit helpers
>  sched_ext: Make scx_prio_less() handle multiple schedulers
>  sched_ext: Move default slice to per-scheduler field
>  sched_ext: Move aborting flag to per-scheduler field
>  sched_ext: Move bypass_dsq into scx_sched_pcpu
>  sched_ext: Move bypass state into scx_sched
>  sched_ext: Prepare bypass mode for hierarchical operation
>  sched_ext: Factor out scx_dispatch_sched()
>  sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
>  sched_ext: Separate bypass dispatch enabling from bypass depth tracking
>  sched_ext: Implement hierarchical bypass mode
>  sched_ext: Dispatch from all scx_sched instances
>  sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
>  sched_ext: Make watchdog sub-sched aware
>  sched_ext: Convert scx_dump_state() spinlock to raw spinlock
>  sched_ext: Support dumping multiple schedulers and add scheduler identification
>  sched_ext: Implement cgroup sub-sched enabling and disabling
>  sched_ext: Add scx_sched back pointer to scx_sched_pcpu
>  sched_ext: Make scx_bpf_reenqueue_local() sub-sched aware
>  sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
>  sched_ext: Add rhashtable lookup for sub-schedulers
>  sched_ext: Add basic building blocks for nested sub-scheduler dispatching

Applied to sched_ext/for-7.1 with the following updates:

- #4 applied to cgroup/for-7.1 and pulled into sched_ext/for-7.1.
- #23: Fix comment typos (Andrea).
- #29: Fix missing scx_cgroup_unlock()/percpu_up_write() in abort path
  (Cheng-Yang Chou).

Thanks.

--
tejun
