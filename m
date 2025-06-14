Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761A12B93;
	Sat, 14 Jun 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864792; cv=none; b=mKi76UUf65ZFPQf3uiuGziqV16ACfBWqVmArYNy0ycCxAjrSJDmuAtJdIEDHNGZ77lYhBygGkX9BZhobb88mAkHhh0rAM005smhIuOPEnv0kTdROPmCm1ewEI1iV15EAcwt/bfnvyMpxi59VdZfmW5+FX13z10NWl0FbkYS68SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864792; c=relaxed/simple;
	bh=ljO7ko//xPyBGAMTXSAqK5hkpWjaCEL4iURgQsHbWRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A2e5pkqRaspFrbrPAnf9X5c3lptph272dRGt/5EFPgFpsetZAXYUMVEIJJKynUr5Qq8VfK2nmAm00AN8RSHe8vAbVOvbIbntkhs/wx3QXJSJ46wPqnsNuYMJIZud5LeomdDIAXKeXVictkxkdGGgL0GJoAf/XZOCh5vfNqlp3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2+1z64u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2+1z64u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC510C4CEE3;
	Sat, 14 Jun 2025 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864792;
	bh=ljO7ko//xPyBGAMTXSAqK5hkpWjaCEL4iURgQsHbWRc=;
	h=Date:From:To:Cc:Subject:From;
	b=M2+1z64umY3rWqdCKiOc4qOrF/M0BTYThm/wWG+aN6LkGcIipRDv8ucHVxuiTC6yg
	 dLW6sHVcIy8RJmk8xe+/gxI3brpHXEEqll5DLPpygzW3zoTm9ENWahjEy0j8eAt1RX
	 hV+vKfR3paEXP8oJGXVaVWbXs2lBaj0lVwhiR7akahSLwWeEKjzmvABLdlnvHLZJNb
	 V4eajwXxM2xJkrzBUr+FZgrgBE7c6BL1ATe1lj1Dj3oCAAU7jAb9085JwbGSafU1h7
	 vN9JGaPU1RBbYe+6Tmzrs75qHHIY87TSAA1Bg/pUyv5XgJD0IWt2bWKJT7eH1IqCaQ
	 1prfMf/8utBPA==
Date: Fri, 13 Jun 2025 15:33:10 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH sched_ext/for-6.17 1/2] sched_ext, sched/core: Factor out
 struct scx_task_group
Message-ID: <aEzRVj5ha38RAEr5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 55aa129e6add97a98340326451bdadd4c5dd3242 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 13 Jun 2025 15:06:47 -1000

More sched_ext fields will be added to struct task_group. In preparation,
factor out sched_ext fields into struct scx_task_group to reduce clutter in
the common header. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
These two patches are on top of:

 + Two fix pathces pending on sched_ext/for-6.16-fixes
     http://lkml.kernel.org/r/aEyy27BecPPHDWHc@slm.duckdns.org
     http://lkml.kernel.org/r/aEyzhBAl5zkP6Ku-@slm.duckdns.org
 + tip/sched/core patchset to reorganize bandwidth control interface handling
     http://lkml.kernel.org/r/20250614012346.2358261-1-tj@kernel.org

See the following git branch for the merged result:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-bandwidth-control

Peter, while this touches sched.h, the change is contained to scx part and
shouldn't cause noticeable problems for other scheduler changes. I'll carry
this through sched_ext/for-6.17. Please let me know if there are any
concerns.

Thanks.

 include/linux/sched/ext.h |  8 ++++++++
 kernel/sched/ext.c        | 32 ++++++++++++++++----------------
 kernel/sched/sched.h      |  5 +----
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index f7545430a548..eda89acdb7ab 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -214,4 +214,12 @@ static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
+
+struct scx_task_group {
+#ifdef CONFIG_EXT_GROUP_SCHED
+	u32			flags;		/* SCX_TG_* */
+	u32			weight;
+#endif
+};
+
 #endif	/* _LINUX_SCHED_EXT_H */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4db51e708f86..6732e50e0679 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4058,7 +4058,7 @@ static bool scx_cgroup_enabled;
 
 void scx_tg_init(struct task_group *tg)
 {
-	tg->scx_weight = CGROUP_WEIGHT_DFL;
+	tg->scx.weight = CGROUP_WEIGHT_DFL;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -4066,14 +4066,14 @@ int scx_tg_online(struct task_group *tg)
 	struct scx_sched *sch = scx_root;
 	int ret = 0;
 
-	WARN_ON_ONCE(tg->scx_flags & (SCX_TG_ONLINE | SCX_TG_INITED));
+	WARN_ON_ONCE(tg->scx.flags & (SCX_TG_ONLINE | SCX_TG_INITED));
 
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (scx_cgroup_enabled) {
 		if (SCX_HAS_OP(sch, cgroup_init)) {
 			struct scx_cgroup_init_args args =
-				{ .weight = tg->scx_weight };
+				{ .weight = tg->scx.weight };
 
 			ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -4081,9 +4081,9 @@ int scx_tg_online(struct task_group *tg)
 				ret = ops_sanitize_err(sch, "cgroup_init", ret);
 		}
 		if (ret == 0)
-			tg->scx_flags |= SCX_TG_ONLINE | SCX_TG_INITED;
+			tg->scx.flags |= SCX_TG_ONLINE | SCX_TG_INITED;
 	} else {
-		tg->scx_flags |= SCX_TG_ONLINE;
+		tg->scx.flags |= SCX_TG_ONLINE;
 	}
 
 	percpu_up_read(&scx_cgroup_rwsem);
@@ -4094,15 +4094,15 @@ void scx_tg_offline(struct task_group *tg)
 {
 	struct scx_sched *sch = scx_root;
 
-	WARN_ON_ONCE(!(tg->scx_flags & SCX_TG_ONLINE));
+	WARN_ON_ONCE(!(tg->scx.flags & SCX_TG_ONLINE));
 
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_exit) &&
-	    (tg->scx_flags & SCX_TG_INITED))
+	    (tg->scx.flags & SCX_TG_INITED))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_exit, NULL,
 			    tg->css.cgroup);
-	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
+	tg->scx.flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
 
 	percpu_up_read(&scx_cgroup_rwsem);
 }
@@ -4211,11 +4211,11 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 	percpu_down_read(&scx_cgroup_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
-	    tg->scx_weight != weight)
+	    tg->scx.weight != weight)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
 			    tg_cgrp(tg), weight);
 
-	tg->scx_weight = weight;
+	tg->scx.weight = weight;
 
 	percpu_up_read(&scx_cgroup_rwsem);
 }
@@ -4366,9 +4366,9 @@ static void scx_cgroup_exit(struct scx_sched *sch)
 	css_for_each_descendant_post(css, &root_task_group.css) {
 		struct task_group *tg = css_tg(css);
 
-		if (!(tg->scx_flags & SCX_TG_INITED))
+		if (!(tg->scx.flags & SCX_TG_INITED))
 			continue;
-		tg->scx_flags &= ~SCX_TG_INITED;
+		tg->scx.flags &= ~SCX_TG_INITED;
 
 		if (!sch->ops.cgroup_exit)
 			continue;
@@ -4400,14 +4400,14 @@ static int scx_cgroup_init(struct scx_sched *sch)
 	rcu_read_lock();
 	css_for_each_descendant_pre(css, &root_task_group.css) {
 		struct task_group *tg = css_tg(css);
-		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+		struct scx_cgroup_init_args args = { .weight = tg->scx.weight };
 
-		if ((tg->scx_flags &
+		if ((tg->scx.flags &
 		     (SCX_TG_ONLINE | SCX_TG_INITED)) != SCX_TG_ONLINE)
 			continue;
 
 		if (!sch->ops.cgroup_init) {
-			tg->scx_flags |= SCX_TG_INITED;
+			tg->scx.flags |= SCX_TG_INITED;
 			continue;
 		}
 
@@ -4422,7 +4422,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}
-		tg->scx_flags |= SCX_TG_INITED;
+		tg->scx.flags |= SCX_TG_INITED;
 
 		rcu_read_lock();
 		css_put(css);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 105190b18020..fdf5f52b54a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -471,10 +471,7 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
-#ifdef CONFIG_EXT_GROUP_SCHED
-	u32			scx_flags;	/* SCX_TG_* */
-	u32			scx_weight;
-#endif
+	struct scx_task_group	scx;
 
 	struct rcu_head		rcu;
 	struct list_head	list;
-- 
2.49.0

