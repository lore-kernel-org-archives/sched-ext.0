Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18623947B5;
	Wed,  1 Jul 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943020; cv=none; b=gPvOHN2AnYBe9IZ6+RcoX3APslRTsyGBStVirYvqBT0H4kMvufdh29s+/IJ94ADRePR/jXiI9CjpQlVmV8Bdy2orNZnnxGpaqCLPb7s2t6q0wkgiZG5layR1wWu9PXkIN1WGJHbqkkW+HB2+8sbub2ftSFpkwv1be+YUCpc5Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943020; c=relaxed/simple;
	bh=U600I6DqHK9LPPovilPkIBqTAYGKJ5ILULcJdmoushI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TPRZwmsLn4m2lmqk7EBtrPRAYfXVyTYs7csGbfGzygKr5m5+Eu2rFdFAc5oRsZ/A5Z+Nlchg/BHW2IcEBtv8Se9wEDmDK542YqE6cxNydsP30zY2IrBGQNTt2xVnyBbH+yi5w91lNIwJpGGjIx3uQ5pwexWePotRPI4NRVcUrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRR64a/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRR64a/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703D31F000E9;
	Wed,  1 Jul 2026 21:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782943019;
	bh=IhGXy+Ms2YYNC0tetJkuEMYEiMTdY0VELLJSVJHAr0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eRR64a/vdrdtcfRbY7AmNNHIQUa7CvuIpeX2L4GNTMl0DUn2wy9KcBP5QjUZz4zFR
	 /KeERXUXGoqLh12Wq+ULPLP4da0vSBJ/5eiKQjMz1gRm/H+QfY6W5duZpfPNodg8hC
	 4RbrOOGOaHkl+scb0REmDl4ZygxtuCmqWHYeDoC3mQ0El2crNiq4kR/PN4xY+1e4cp
	 ixTzcjZWSCgdC9sfZLXipgXZdIuyOG/wsOpl72QwnT3M2skEU6B/wXn5A9jcCwhYOv
	 pTr8WSinTaSzfxzJvgMgyQQ36lqn1ppG05u4Eka+rEFRNMliyqvIGYvoG0f5cIf5Q5
	 5VqITcephjlsQ==
Date: Wed, 01 Jul 2026 11:56:58 -1000
Message-ID: <deb61f8eec648b17a7c2062ce60d7b2c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v3 sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler
 implementation into sub.c
In-Reply-To: <20260701205513.6A9C41F000E9@smtp.kernel.org>
References: <20260701203438.2837392-1-tj@kernel.org>
 <20260701203438.2837392-5-tj@kernel.org>
 <20260701205513.6A9C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello.

> The sub-scheduler is removed from the scx_sched_hash via scx_unlink_sched()
> after the RCU grace period completes. Because it remains in the hash during
> and after the grace period, couldn't a concurrent BPF program on the parent
> scheduler call scx_bpf_sub_dispatch() and find the sub-scheduler?

It can, but that's fine. The expedited synchronize is there to drain
in-flight ops after all tasks have been moved off, not to make the sched
unreachable. The sched is freed through another RCU grace period after
unlinking and scx_bpf_sub_dispatch() runs under RCU read lock, so the
racing lookup can't see the sched freed under it. Such a dispatch is also
inert as the child is already bypassed and has no tasks left.

> If a BPF program attaches a sub-scheduler to a newly created cgroup that
> hasn't completed its ONLINE phase yet, cgrp->scx_sched might be NULL. The
> code dereferences it immediately.

The cgroup can only come from cgroup_get_from_id() which fails on kernfs
nodes which haven't been activated, and cgroup_mkdir() activates the node
after CGROUP_LIFETIME_ONLINE has fired and ->scx_sched has been inherited
from the parent. The inherited pointer is non-NULL whenever the attach can
get this far. The root enable path sets ->scx_sched on all live cgroups
before __scx_enabled is turned on, under the same scx_enable_mutex that
scx_sub_enable_workfn() holds across the scx_enabled() check. The
CSS_ONLINE check afterwards guards against destruction, not incomplete
onlining.

> This is a pre-existing issue, but do we need to call scx_error() in these
> failure paths?

Will be dealt with separately.

Thanks.

-- 
tejun
