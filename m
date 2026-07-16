Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85C222590;
	Thu, 16 Jul 2026 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237461; cv=none; b=RcIa+gGKhVH9jekX0j/cIlMEaocfU8c2mhX0ohlE5DKgJBp0cZxDcAI2nrU/RvO8kXIHDGW6mkUcv4GkZOsgzdp7FdIUO1+PslkES37WwtXv8sfHOTSb9WuBMDoEmDRZ/hZFzKvFuPRcth+sO2YlbqtCXwx+yt2nvaotjm+bqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237461; c=relaxed/simple;
	bh=3OYNvgAJYW4/5i7a/Un5X/tq9VhwXscMQSEWIyRJzIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDAeEkK7AeujzkrJtx2E1KK2NO8hweASsY8WuQs+E/3VHJH+weDgw8caJMEwoAQJmPNiDksCnYV/S/8vAbawX+KLPyLSZlJVGyQluGUbSag/WutXwDSRlM6kDZA6k6liIC+yCvfCUAopfAUWEqtqGNAVSkxLIioiApHWxFDzLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdUZdxTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdUZdxTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8833E1F00A3A;
	Thu, 16 Jul 2026 21:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237460;
	bh=fnJNGHYbgWNOFIzLHzhVS/6fjjyZB4GqVTP4V7QopHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdUZdxTrjX/ZveJFDis9gBChqtW9/cS2PpP5NWgH3Ez+MiDbu4TAAEoxvS6dXMci7
	 FmZQ6Ii9eRDJP+W2CW9sm8B+6Gf5kp6R3lvsqGFMmxUIMAcbGs4A+iuGRKa6Xhbd0r
	 /N3kPHb1f1idXkK+tdF2i3QbpeHO1oVZz+IQIyAoA3sqth9phF/RCIC9NZyDcu75PI
	 LB6LzbRDI5AT4/ZJI1N0l0TJUOm2hcdSvKwBer/vbn3UK+oTuGYBRVK+MllYpPghJI
	 yDLKw9A8v7o+UeZoRc2wDP1qOuhNyIh+4u5+kCrcPeFExnDtRiKRhnLM/WROYjUprQ
	 K/bhNcRF/U7YA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: Reject setting disallow from init_task outside the enable path
Date: Thu, 16 Jul 2026 11:30:55 -1000
Message-ID: <20260716213058.1739522-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
References: <20260716213058.1739522-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The p->scx.disallow revert assumes the root enable path, where the switching
loop reads the reverted policy right afterwards and leaves the task off SCX.
The sub-scheduler disable path also reaches it when re-initializing the
returned tasks on a root parent. Nothing reads the policy there: the task is
enabled on root anyway and keeps running on the ext class with a silently
rewritten policy.

Kill the sched instead, matching the fork and non-root branches, and update
the disallow documentation, which equated !fork with the load path and
pointed at a stale debugfs path for nr_rejected.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 10 +++++-----
 kernel/sched/ext/ext.c    |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 20b2343aa344..87e353f7e011 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -244,11 +244,11 @@ struct sched_ext_entity {
 	 * to %SCHED_EXT with -%EACCES.
 	 *
 	 * Can be set from ops.init_task() while the BPF scheduler is being
-	 * loaded (!scx_init_task_args->fork). If set and the task's policy is
-	 * already %SCHED_EXT, the task's policy is rejected and forcefully
-	 * reverted to %SCHED_NORMAL. The number of such events are reported
-	 * through /sys/kernel/debug/sched_ext::nr_rejected. Setting this flag
-	 * during fork is not allowed.
+	 * loaded. If set and the task's policy is already %SCHED_EXT, the
+	 * task's policy is rejected and forcefully reverted to %SCHED_NORMAL.
+	 * The number of such events are reported through
+	 * /sys/kernel/sched_ext/nr_rejected. Setting this flag from any other
+	 * ops.init_task() invocation, such as during fork, fails the scheduler.
 	 */
 	bool			disallow;	/* reject switching into SCX */
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e3fa7b2fac9d..46f135bddd46 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3606,6 +3606,9 @@ static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fo
 		} else if (unlikely(fork)) {
 			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
 				  p->comm, p->pid);
+		} else if (unlikely(scx_enable_state() != SCX_ENABLING)) {
+			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] outside the enable path",
+				  p->comm, p->pid);
 		} else {
 			struct rq *rq;
 			struct rq_flags rf;
-- 
2.55.0

