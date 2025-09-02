Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C300284B25;
	Tue,  2 Sep 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856376; cv=none; b=F9S3VrjROZFBcfIyEnzG/iTcqHzpfpX4Dao23I5OAxRmDqYCxgEz6B/aH9/cNsIvyOct8VXiEDuRe5DKXdgxW39VKXatjWaT18EI00lAq8SEU4+RY7dceugKB6DKpx1zgw/swP1W1GPuBhLGztZCDmSKBhrAgCRGkUIV/2/6bB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856376; c=relaxed/simple;
	bh=Vitky2n/c8/d9rCzpk4gUupCZVYAlUW4Rx7f7y+3uXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hzU2agLhWWY+rAF6PwwGKBtI94gl3nOGbhmWTbGkPCBCWhUx4qAWxS2B/tpiN2UOH/FAA3ffXEDHiQheRQCMd7yffQ7MNhG+OmutT7oRsNS2bWZUZnY6j9SbnjvkMbObD5DoAAOyyWP6yKB+SV9tCX4GXX1COYg9ypteRl31hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNcS62jL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNcS62jL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA614C4CEED;
	Tue,  2 Sep 2025 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856375;
	bh=Vitky2n/c8/d9rCzpk4gUupCZVYAlUW4Rx7f7y+3uXA=;
	h=Date:From:To:Cc:Subject:From;
	b=hNcS62jLVIH1QDNIydyp2yGfCKXQsNDTcCf20LhqGPr3kIDM8hT3DMZgALHgDCmXP
	 GFWeQPzNu6EOZxjrsXIP2A8JaYxhJQI4ytuM2eFEHOvMGmN4bogTqFCNAeNticzT8f
	 gBRolJjBxPTPambtxHdJYFZ8GzBBjzZ8SYL6lcZktX0sjT0337gVdPI2tLWVTWgsIv
	 m3TNW3nNhUw4IlFtdN3gu+pjeQYsz+tIv3d8a1JeDQQXkhUB11gM5gddQz1b4+IpVE
	 btNyYa9iTF2ZXGqHnPmeorfBybcwlo0UAlNsBubfqBU5fv79sIivW+R6SdlmjOdBIS
	 m89Xs0KsdCYaA==
Date: Tue, 2 Sep 2025 13:39:34 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock() to
 synchronize against cgroup operations
Message-ID: <aLeANmpO03QiPgSX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

SCX hooks into CPU cgroup controller operations and read-locks
scx_cgroup_rwsem to exclude them while enabling and disable schedulers.
While this works, it's unnecessarily complicated given that
cgroup_[un]lock() are available and thus the cgroup operations can be locked
out that way.

Drop scx_cgroup_rwsem locking from the tg on/offline and cgroup [can_]attach
operations. Instead, grab cgroup_lock() from scx_cgroup_lock(). Drop
scx_cgroup_finish_attach() which is no longer necessary. Drop the now
unnecessary rcu locking and css ref bumping in scx_cgroup_init() and
scx_cgroup_exit().

As scx_cgroup_set_weight/bandwidth() paths aren't protected by
cgroup_lock(), rename scx_cgroup_rwsem to scx_cgroup_ops_rwsem and retain
the locking there.

This is overall simpler and will also allow enable/disable paths to
synchronize against cgroup changes independent of the CPU controller.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
This results in a tiny simplification on the core side. Peter, if you don't
object, I'll route this through sched_ext/for-6.18.

Thanks.

 kernel/sched/core.c |    2 -
 kernel/sched/ext.c  |   66 +++++++++++-----------------------------------------
 kernel/sched/ext.h  |    2 -
 3 files changed, 14 insertions(+), 56 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9362,8 +9362,6 @@ static void cpu_cgroup_attach(struct cgr
 
 	cgroup_taskset_for_each(task, css, tset)
 		sched_move_task(task, false);
-
-	scx_cgroup_finish_attach();
 }
 
 static void cpu_cgroup_cancel_attach(struct cgroup_taskset *tset)
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4084,7 +4084,7 @@ bool scx_can_stop_tick(struct rq *rq)
 
 #ifdef CONFIG_EXT_GROUP_SCHED
 
-DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_rwsem);
+DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_ops_rwsem);
 static bool scx_cgroup_enabled;
 
 void scx_tg_init(struct task_group *tg)
@@ -4101,8 +4101,6 @@ int scx_tg_online(struct task_group *tg)
 
 	WARN_ON_ONCE(tg->scx.flags & (SCX_TG_ONLINE | SCX_TG_INITED));
 
-	percpu_down_read(&scx_cgroup_rwsem);
-
 	if (scx_cgroup_enabled) {
 		if (SCX_HAS_OP(sch, cgroup_init)) {
 			struct scx_cgroup_init_args args =
@@ -4122,7 +4120,6 @@ int scx_tg_online(struct task_group *tg)
 		tg->scx.flags |= SCX_TG_ONLINE;
 	}
 
-	percpu_up_read(&scx_cgroup_rwsem);
 	return ret;
 }
 
@@ -4132,15 +4129,11 @@ void scx_tg_offline(struct task_group *t
 
 	WARN_ON_ONCE(!(tg->scx.flags & SCX_TG_ONLINE));
 
-	percpu_down_read(&scx_cgroup_rwsem);
-
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_exit) &&
 	    (tg->scx.flags & SCX_TG_INITED))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_exit, NULL,
 			    tg->css.cgroup);
 	tg->scx.flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
-
-	percpu_up_read(&scx_cgroup_rwsem);
 }
 
 int scx_cgroup_can_attach(struct cgroup_taskset *tset)
@@ -4150,9 +4143,6 @@ int scx_cgroup_can_attach(struct cgroup_
 	struct task_struct *p;
 	int ret;
 
-	/* released in scx_finish/cancel_attach() */
-	percpu_down_read(&scx_cgroup_rwsem);
-
 	if (!scx_cgroup_enabled)
 		return 0;
 
@@ -4192,7 +4182,6 @@ err:
 		p->scx.cgrp_moving_from = NULL;
 	}
 
-	percpu_up_read(&scx_cgroup_rwsem);
 	return ops_sanitize_err(sch, "cgroup_prep_move", ret);
 }
 
@@ -4215,11 +4204,6 @@ void scx_cgroup_move_task(struct task_st
 	p->scx.cgrp_moving_from = NULL;
 }
 
-void scx_cgroup_finish_attach(void)
-{
-	percpu_up_read(&scx_cgroup_rwsem);
-}
-
 void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct scx_sched *sch = scx_root;
@@ -4227,7 +4211,7 @@ void scx_cgroup_cancel_attach(struct cgr
 	struct task_struct *p;
 
 	if (!scx_cgroup_enabled)
-		goto out_unlock;
+		return;
 
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(sch, cgroup_cancel_move) &&
@@ -4236,15 +4220,13 @@ void scx_cgroup_cancel_attach(struct cgr
 				    p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
-out_unlock:
-	percpu_up_read(&scx_cgroup_rwsem);
 }
 
 void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
 	struct scx_sched *sch = scx_root;
 
-	percpu_down_read(&scx_cgroup_rwsem);
+	percpu_down_read(&scx_cgroup_ops_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
@@ -4253,7 +4235,7 @@ void scx_group_set_weight(struct task_gr
 
 	tg->scx.weight = weight;
 
-	percpu_up_read(&scx_cgroup_rwsem);
+	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
@@ -4266,7 +4248,7 @@ void scx_group_set_bandwidth(struct task
 {
 	struct scx_sched *sch = scx_root;
 
-	percpu_down_read(&scx_cgroup_rwsem);
+	percpu_down_read(&scx_cgroup_ops_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
 	    (tg->scx.bw_period_us != period_us ||
@@ -4279,23 +4261,25 @@ void scx_group_set_bandwidth(struct task
 	tg->scx.bw_quota_us = quota_us;
 	tg->scx.bw_burst_us = burst_us;
 
-	percpu_up_read(&scx_cgroup_rwsem);
+	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
 
 static void scx_cgroup_lock(void)
 {
-	percpu_down_write(&scx_cgroup_rwsem);
+	percpu_down_write(&scx_cgroup_ops_rwsem);
+	cgroup_lock();
 }
 
 static void scx_cgroup_unlock(void)
 {
-	percpu_up_write(&scx_cgroup_rwsem);
+	cgroup_unlock();
+	percpu_up_write(&scx_cgroup_ops_rwsem);
 }
 
 #else	/* CONFIG_EXT_GROUP_SCHED */
 
-static inline void scx_cgroup_lock(void) {}
-static inline void scx_cgroup_unlock(void) {}
+static void scx_cgroup_lock(void) {}
+static void scx_cgroup_unlock(void) {}
 
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
@@ -4411,15 +4395,12 @@ static void scx_cgroup_exit(struct scx_s
 {
 	struct cgroup_subsys_state *css;
 
-	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
-
 	scx_cgroup_enabled = false;
 
 	/*
-	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
+	 * scx_tg_on/offline() are excluded through cgroup_lock(). If we walk
 	 * cgroups and exit all the inited ones, all online cgroups are exited.
 	 */
-	rcu_read_lock();
 	css_for_each_descendant_post(css, &root_task_group.css) {
 		struct task_group *tg = css_tg(css);
 
@@ -4430,17 +4411,9 @@ static void scx_cgroup_exit(struct scx_s
 		if (!sch->ops.cgroup_exit)
 			continue;
 
-		if (WARN_ON_ONCE(!css_tryget(css)))
-			continue;
-		rcu_read_unlock();
-
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_exit, NULL,
 			    css->cgroup);
-
-		rcu_read_lock();
-		css_put(css);
 	}
-	rcu_read_unlock();
 }
 
 static int scx_cgroup_init(struct scx_sched *sch)
@@ -4448,13 +4421,10 @@ static int scx_cgroup_init(struct scx_sc
 	struct cgroup_subsys_state *css;
 	int ret;
 
-	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
-
 	/*
-	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
+	 * scx_tg_on/offline() are excluded through cgroup_lock(). If we walk
 	 * cgroups and init, all online cgroups are initialized.
 	 */
-	rcu_read_lock();
 	css_for_each_descendant_pre(css, &root_task_group.css) {
 		struct task_group *tg = css_tg(css);
 		struct scx_cgroup_init_args args = {
@@ -4473,10 +4443,6 @@ static int scx_cgroup_init(struct scx_sc
 			continue;
 		}
 
-		if (WARN_ON_ONCE(!css_tryget(css)))
-			continue;
-		rcu_read_unlock();
-
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
@@ -4485,11 +4451,7 @@ static int scx_cgroup_init(struct scx_sc
 			return ret;
 		}
 		tg->scx.flags |= SCX_TG_INITED;
-
-		rcu_read_lock();
-		css_put(css);
 	}
-	rcu_read_unlock();
 
 	WARN_ON_ONCE(scx_cgroup_enabled);
 	scx_cgroup_enabled = true;
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -100,7 +100,6 @@ int scx_tg_online(struct task_group *tg)
 void scx_tg_offline(struct task_group *tg);
 int scx_cgroup_can_attach(struct cgroup_taskset *tset);
 void scx_cgroup_move_task(struct task_struct *p);
-void scx_cgroup_finish_attach(void);
 void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
 void scx_group_set_idle(struct task_group *tg, bool idle);
@@ -111,7 +110,6 @@ static inline int scx_tg_online(struct t
 static inline void scx_tg_offline(struct task_group *tg) {}
 static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
 static inline void scx_cgroup_move_task(struct task_struct *p) {}
-static inline void scx_cgroup_finish_attach(void) {}
 static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
 static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
 static inline void scx_group_set_idle(struct task_group *tg, bool idle) {}
