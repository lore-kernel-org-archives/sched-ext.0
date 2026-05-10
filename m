Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B916369970;
	Sun, 10 May 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398878; cv=none; b=FHZp0j996kI3kvwrHYM4yT73XO34i+V7nA/F5K4BvL9eZPPnp5B53ZchKXvFqjEAfPlN3Xlr6aFcC4EOXvNOkxaMt3hGnjCpoPxMw4v4yNIrw9vTdrWjFKXNSQw+CcWNJocpS+dE4hT/IhedUEyqYGHVE0hfyji2ZbwLBrCSBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398878; c=relaxed/simple;
	bh=qyAZgTDF0GBoiqjbpW0wva77DgLmIAnVdkwOc1hocaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1EWpEIPmusKcWm4t0nGORYC4gVZvoY2Jd+J2romrKpUxjsFS/z+e5knviWobwWhIbzbovZKRvvmisjapohHjgMk3xZGG2WiikRnDIL1yJ8/ww50SqXUyXKaUTIuDBkRSNxI1bOdhR/JIIkUj1Kq8gR+g4QNIDZUHwWihMtpKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Q4LUO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Q4LUO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08423C2BCB8;
	Sun, 10 May 2026 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398878;
	bh=qyAZgTDF0GBoiqjbpW0wva77DgLmIAnVdkwOc1hocaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0Q4LUO+zyUmIaqICKElmcBgbRPnpeLHbEQQrsk5xMAtY3IqFJPLEzdp6ziRAfz/w
	 G4CwPk1Y9WiD6GkJpIdEMmzQtwnu4PN+2j2444Zvxbrt/bLxZAtQRNMB0sC8cXn7TB
	 7sGsTnjRfgqgTrjgIKo/z2kvATIC1xwZcSQ8tpJwC20HjlhEwwF9velNPeABO11i+J
	 uDYcWXdmwxnm6ZClwgQimU1pN/a1EiMUx+mjeDTMRSnQRyokKXz9upqD7lDMnmtupx
	 5j3JyIyzCpNXgbAORwErH14uvT6FKpgmW1BdL5dEJpouTGpRtEtJMw0CnzQeL1ONpQ
	 VFvRaCJeOs8yg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Replace SCX_TASK_OFF_TASKS flag with SCX_TASK_DEAD state
Date: Sat,  9 May 2026 21:41:10 -1000
Message-ID: <20260510074113.2049514-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510074113.2049514-1-tj@kernel.org>
References: <20260510074113.2049514-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_TASK_OFF_TASKS marked tasks already through sched_ext_dead() so cgroup
task iteration would skip them. This can be expressed better with a task
state. Replace the flag with SCX_TASK_DEAD.

scx_disable_and_exit_task() resets state to NONE on its way out, so
sched_ext_dead() now sets DEAD after the wrapper returns. The validation
matrix grows NONE -> DEAD, warns on DEAD -> NONE, and tightens READY's
predecessor to INIT or ENABLED so the new DEAD value cannot silently
transition to READY.

Prepares for the following enable vs dead race fix.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  9 +++++----
 kernel/sched/ext.c        | 17 +++++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index adb9a4de068a..9f1a326ad03e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -101,24 +101,25 @@ enum scx_ent_flags {
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
-	SCX_TASK_OFF_TASKS	= 1 << 6, /* removed from scx_tasks by sched_ext_dead() */
 
 	/*
-	 * Bits 8 and 9 are used to carry task state:
+	 * Bits 8 to 10 are used to carry task state:
 	 *
 	 * NONE		ops.init_task() not called yet
 	 * INIT		ops.init_task() succeeded, but task can be cancelled
 	 * READY	fully initialized, but not in sched_ext
 	 * ENABLED	fully initialized and in sched_ext
+	 * DEAD		terminal state set by sched_ext_dead()
 	 */
-	SCX_TASK_STATE_SHIFT	= 8,	  /* bits 8 and 9 are used to carry task state */
-	SCX_TASK_STATE_BITS	= 2,
+	SCX_TASK_STATE_SHIFT	= 8,
+	SCX_TASK_STATE_BITS	= 3,
 	SCX_TASK_STATE_MASK	= ((1 << SCX_TASK_STATE_BITS) - 1) << SCX_TASK_STATE_SHIFT,
 
 	SCX_TASK_NONE		= 0 << SCX_TASK_STATE_SHIFT,
 	SCX_TASK_INIT		= 1 << SCX_TASK_STATE_SHIFT,
 	SCX_TASK_READY		= 2 << SCX_TASK_STATE_SHIFT,
 	SCX_TASK_ENABLED	= 3 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_DEAD		= 4 << SCX_TASK_STATE_SHIFT,
 
 	/*
 	 * Bits 12 and 13 are used to carry reenqueue reason. In addition to
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 81841277a54f..2fc4a12711f9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -723,17 +723,22 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
 
 	switch (state) {
 	case SCX_TASK_NONE:
+		warn = prev_state == SCX_TASK_DEAD;
 		break;
 	case SCX_TASK_INIT:
 		warn = prev_state != SCX_TASK_NONE;
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 		break;
 	case SCX_TASK_READY:
-		warn = prev_state == SCX_TASK_NONE;
+		warn = !(prev_state == SCX_TASK_INIT ||
+			 prev_state == SCX_TASK_ENABLED);
 		break;
 	case SCX_TASK_ENABLED:
 		warn = prev_state != SCX_TASK_READY;
 		break;
+	case SCX_TASK_DEAD:
+		warn = prev_state != SCX_TASK_NONE;
+		break;
 	default:
 		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
 			  prev_state, state, p->comm, p->pid);
@@ -972,11 +977,11 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 		/*
 		 * cgroup_task_dead() removes the dead tasks from cset->tasks
 		 * after sched_ext_dead() and cgroup iteration may see tasks
-		 * which already finished sched_ext_dead(). %SCX_TASK_OFF_TASKS
-		 * is set by sched_ext_dead() under @p's rq lock. Test it to
+		 * which already finished sched_ext_dead(). %SCX_TASK_DEAD is
+		 * set by sched_ext_dead() under @p's rq lock. Test it to
 		 * avoid visiting tasks which are already dead from SCX POV.
 		 */
-		if (p->scx.flags & SCX_TASK_OFF_TASKS) {
+		if (scx_get_task_state(p) == SCX_TASK_DEAD) {
 			__scx_task_iter_rq_unlock(iter);
 			continue;
 		}
@@ -3847,7 +3852,7 @@ void sched_ext_dead(struct task_struct *p)
 	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
 	 * ENABLED transitions can't race us. Disable ops for @p.
 	 *
-	 * %SCX_TASK_OFF_TASKS synchronizes against cgroup task iteration - see
+	 * %SCX_TASK_DEAD synchronizes against cgroup task iteration - see
 	 * scx_task_iter_next_locked(). NONE tasks need no marking: cgroup
 	 * iteration is only used from sub-sched paths, which require root
 	 * enabled. Root enable transitions every live task to at least READY.
@@ -3858,7 +3863,7 @@ void sched_ext_dead(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		scx_disable_and_exit_task(scx_task_sched(p), p);
-		p->scx.flags |= SCX_TASK_OFF_TASKS;
+		scx_set_task_state(p, SCX_TASK_DEAD);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
-- 
2.54.0

