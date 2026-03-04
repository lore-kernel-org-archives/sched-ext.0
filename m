Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECD3E0C7E;
	Wed,  4 Mar 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661697; cv=none; b=i0/QsDgK+lkTgvxOEmEwpJhegYF3tMlQnaMqFCC5G9x4xektD8E014Ty5yIABeohLZxC/iyK2MzsDn907aAl89xcCvYXw9NWXyY9DyEn6EFOzzv6FHkSiZ2/tpeRnUlGujlAV7AjpG8yC8jf9mnR54jW2tEv6y9+NaM1ckbgMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661697; c=relaxed/simple;
	bh=XGCy0Wn82xFVRla3uo784vqu+kkjAMfHR6MRyLZmAqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWmzwIg58IuzVbsE0GwAvqIs/SXz4w9BAgIE8nnOGABKTsTNtbgcrn/XiZSZoPFHmQ2PwRYkA/4J+gBNh+VlTkwORtY7I+FogYXcShHnARlR1GEE+YG/GVBiqLzsENQ8X31iLrNJ0pV0H77p/Tr+RwxbraCq8uUDORZQaIXJL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWY8jaPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWY8jaPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E88C4CEF7;
	Wed,  4 Mar 2026 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661696;
	bh=XGCy0Wn82xFVRla3uo784vqu+kkjAMfHR6MRyLZmAqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWY8jaPJMolV/jg72Ttvfuga7Y1ssCz2TDVAfEHKFS6tkNKWHBu4mq9maRYS138FY
	 SquqPul6DGCsWtb4Q+EvNZQElHe+gmhkt7lwplzVWJbZ/t+aLv7sQeDdYra5/RPyua
	 YOsfkgSJCmskAEq0tLKjLj+SXJhqlQ/T2Fn0XXum9xDOnJarzg6O5rbGByqCvNQwV7
	 iMSX/fsGY9TjtjdkDbQhDtO3wfoGhkEqqvS1kMugjVQxggH5uOhMqUQUAwCWiKCoTb
	 gVVq/NGvgsL1MmeOSbfwYiwPc0Qqb8qSPtnaNCQg+sJH65THlenqhZ9VNKp5QdgDMy
	 JsI94uRf363nQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/34] sched_ext: Move default slice to per-scheduler field
Date: Wed,  4 Mar 2026 12:01:00 -1000
Message-ID: <20260304220119.4095551-16-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default time slice was stored in the global scx_slice_dfl variable which
was dynamically modified when entering and exiting bypass mode. With
hierarchical scheduling, each scheduler instance needs its own default slice
configuration so that bypass operations on one scheduler don't affect others.

Move slice_dfl into struct scx_sched and update all access sites. The bypass
logic now modifies the root scheduler's slice_dfl. At task initialization in
init_scx_entity(), use the SCX_SLICE_DFL constant directly since the task may
not yet be associated with a specific scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 14 ++++++++------
 kernel/sched/ext_internal.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54210cef3bc7..efbc6507cd1f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -164,7 +164,6 @@ static struct kset *scx_kset;
  * There usually is no reason to modify these as normal scheduler operation
  * shouldn't be affected by them. The knobs are primarily for debugging.
  */
-static u64 scx_slice_dfl = SCX_SLICE_DFL;
 static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
 static unsigned int scx_bypass_lb_intv_us = SCX_BYPASS_LB_DFL_INTV_US;
 
@@ -1135,7 +1134,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(scx_slice_dfl);
+	p->scx.slice = READ_ONCE(sch->slice_dfl);
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -3288,7 +3287,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = READ_ONCE(scx_slice_dfl);
+	scx->slice = SCX_SLICE_DFL;
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -4449,6 +4448,8 @@ static void scx_bypass(bool bypass)
 
 	raw_spin_lock_irqsave(&bypass_lock, flags);
 	sch = rcu_dereference_bh(scx_root);
+	if (!sch)
+		goto unlock;
 
 	if (bypass) {
 		u32 intv_us;
@@ -4457,7 +4458,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
+		WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -4473,7 +4474,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, SCX_SLICE_DFL);
+		WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -5317,6 +5318,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
@@ -5662,7 +5664,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(scx_slice_dfl);
+			p->scx.slice = READ_ONCE(sch->slice_dfl);
 			p->sched_class = new_class;
 		}
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 078fcd1c6bee..842d7b4e5334 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -950,6 +950,7 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
+	u64			slice_dfl;
 	s32			level;
 
 	/*
-- 
2.53.0

