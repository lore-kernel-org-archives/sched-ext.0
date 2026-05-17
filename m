Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B71F03D7;
	Sun, 17 May 2026 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978481; cv=none; b=SDN343Y3T+o6fd66o1W8nu5Rb0UdiGoHz/ALutoYg7+yRSYoVeytA3RBe1QHkD2NHO9QYa2j0oJc2RKPJaDT4Bw+qFUO6pjN7LLbIF4KjtCamp1To/2K5PTE6zND2K2lHisIpDx5GVcsp+o+UUfBclBpLIdZZkFHZBUVOH668xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978481; c=relaxed/simple;
	bh=RF4Twv01BJH5WVz9yxqCaftb5IzBTXYwUQdHAig06nc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=NOWQZew71q4+fdZDBzTY+51B/O3MX4aOOhUUY6CqjKUVCoh1iZZIZwS3bdzPAtJTWGE3FDs0j2/OJGrVUvhRKTN/KMqHr/qTjFfmTGiYHu0i8//8CgARdVNxBAHvqdC9YK3jQmaBx6Aw1EjoQFhXHK2d/pElHMaIO/JodRNB04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzdzRfZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzdzRfZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886CEC19425;
	Sun, 17 May 2026 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978481;
	bh=RF4Twv01BJH5WVz9yxqCaftb5IzBTXYwUQdHAig06nc=;
	h=Date:From:To:Cc:Subject:From;
	b=HzdzRfZi6l02EAW3hugfAFcit6D9fTzrC4vkNfkQ02dt64Fj2HxAf9+x50Rz6Z1G1
	 mZ2ZCJ8e0l0TA7YcdvD7Lr0Y5tfDt9rNpghjodRVYd9AwDvxGRERDOwdMRr/yzcJa6
	 g2ihGfy4f3KZxe9/qw2Z2ozEOyFnlKEDmxevfgA6ZqkVgnslVmSnb0RKE0DuGIc5sv
	 yW/uF28Y3JR3lZTTGP/1PCpd3fEihVMXcfIVBQOkJtsV8USMpLuzVKXZHwsAuQcbEu
	 euQwwugpigHuSsdWy1cBETNHlLYVv5Rntsp4x1j92HAXVZudNdG2LZelCEd+NXvBPm
	 dr4Vx9Ya3bYPA==
Date: Sat, 16 May 2026 14:41:20 -1000
Message-ID: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix deadlock between scx_root_disable() and concurrent forks
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_root_disable() enters SCX_DISABLING before it grabs scx_enable_mutex to
clear [__]scx_switching_all. task_should_scx() short-circuits on DISABLING,
so forks in that window land on fair while next_active_class() still skips
fair - the new tasks stall.

This can deadlock the disable path itself: scx_alloc_and_add_sched() runs
under scx_enable_mutex and creates a helper kthread; if that new kthread is
one of the stalled fair tasks, the mutex holder waits forever and
scx_root_disable() can never make progress. Only sub-sched support exposes
this, since sub-sched enables are the only path where
scx_alloc_and_add_sched() can race the root's disable.

Move the DISABLING check after @scx_switching_all so that whenever
@scx_switching_all is set, forks keep going to scx and stay in lockstep with
__scx_switched_all. Once both are cleared (together under the mutex),
DISABLING applies normally.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5092,10 +5092,31 @@ static const struct kset_uevent_ops scx_
  */
 bool task_should_scx(int policy)
 {
-	if (!scx_enabled() || unlikely(scx_enable_state() == SCX_DISABLING))
+	/* if disabled, nothing should be on it */
+	if (!scx_enabled())
 		return false;
+
+	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
 	if (READ_ONCE(scx_switching_all))
 		return true;
+
+	/*
+	 * scx is tearing down - keep new SCHED_EXT tasks out.
+	 *
+	 * Must come after scx_switching_all test. While both are set, we must
+	 * return true via the branch above: [__]scx_switching_all are cleared
+	 * together under scx_enable_mutex, and a fork routed to fair while
+	 * __scx_switched_all is still on would stall because
+	 * next_active_class() skips fair.
+	 *
+	 * This can develop into a deadlock - scx holds scx_enable_mutex across
+	 * kthread_create() in scx_alloc_and_add_sched(); if the new kthread is
+	 * the stalled task, the disable path can never grab the mutex to clear
+	 * scx_switching_all.
+	 */
+	if (unlikely(scx_enable_state() == SCX_DISABLING))
+		return false;
+
 	return policy == SCHED_EXT;
 }

