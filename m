Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9D23C4E9;
	Fri,  6 Mar 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770181; cv=none; b=VYi9s3+9/ueIORwhlYUQvu/TVmLit5ULJCNHEKSFp4+rumAFopFWJgc/czoab2amoNoH60U/PmOdxQLB4Krzu8qi83Hw7eYGFDTlNxr9860aBKuYVjT2OHi8j8CInFjERHEmuU+ipr134BRXgju14pF+P5cSMETV184iZaprHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770181; c=relaxed/simple;
	bh=iP0tZ1f20f6gxlg6VlL3nc7rIejVeFXXl3YEVmnvDQA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=sN05pG9xgzWet5N4mUJ4QCypV5HkaQg0ldx+wzlTQRhULbEuKRPQWLmHNq6xVKNAXL80C9fZ95Ig3ZE4YwdS3mprcKKrf70/XMEEY1qbsap+9JAwv44UOA2Wd0quNYHyFo5a6STJFLFLwIgQveLdsqwXMURB90SA/j5PNNYbz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C17FZ3as; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C17FZ3as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342CCC4CEF7;
	Fri,  6 Mar 2026 04:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772770181;
	bh=iP0tZ1f20f6gxlg6VlL3nc7rIejVeFXXl3YEVmnvDQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C17FZ3asVfVGKPfp5FBP+CxZQSQZtReysBI2YyZCAHbspxhD2wXFr9RGXjxvEVfUi
	 TPRCfITgw4VjjSMq7X4HH/Ag8A28sybjFLGbw8SVsd01+WnKUCPD/gwMcENbCWPpT/
	 7PR+AlrBi4u3NSgVJ0m6t6xrZ/Xaof3WD1uxZ16lYnyFx68QNZnpfq2Mz1MsToVMlq
	 poe21BJxisYNa2RpSvYOJxPnm+RYrIiP9p0jJb6JecqwYbzn/Q9won00segYSCraed
	 emc1WX39dajNWxD5b6MUkReuBdNPOQmhKeLKGIHXU+fCOLH2AFwOoCllfmHQuT1Rxs
	 uBnIgCf3WBPvw==
Date: Thu, 05 Mar 2026 18:09:40 -1000
Message-ID: <dbf73a65da8d1f8c84cabc010d05f71c@kernel.org>
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

Applied 1-34 to sched_ext/for-7.1.

Thanks.

--
tejun
