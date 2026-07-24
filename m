Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969941C6A;
	Fri, 24 Jul 2026 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856558; cv=none; b=EF1VUO8UkY44J5djcYxAdl1bLKnGPjsi3GMrBYMTXrTY/3kMMf0mnqz7if9AVHBp+urfuuTTDHn1Y560Y39f/XRjKi/OWXCpmwWP64ES9QJ5Np7gmnnLVwCun/DDYy8mG953z8Cy0L/0o9CRzYvlAvWIO7+MokEJMrOqFs7sN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856558; c=relaxed/simple;
	bh=hQ9yjB2V78yGmF8bqttIkzuug9InpmOAPTH23ZMKuKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiL802xtk2TrGz2AptbsDEA80vzg5B9+HTG2vXgqfgM4Rkd92foREop2E3MRUoFY5OE6bXL24Rv1qdtXH0JgFyaX+F6rFEjv9yxoIx9ywISQHZHU0e6D6DClIT07usID9mDDiFYUJU343lebW50rmBgZfY8HkpSPQAA0BwFwrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz0n0y2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz0n0y2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E901F00A3A;
	Fri, 24 Jul 2026 01:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856556;
	bh=tdV4o3gD7B1e5duHZe7d0TQJSiZvkg2PReIZsI7RDRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bz0n0y2+7SZ1H20MsR9zPKzixrKl9JIKlSZfEEju5MDadsWq6lOpMvk9UuJqpFDOp
	 EQaDWG1C5ok+Vlkv0UlVwH5yPrM9vW+yYAm+nwIMskUzuONgiZrZI3XpxUCETw/uTu
	 6PU0rTW8uYrkjbpL48lfqbFnngQs6zKeL96DkMZIuJ+WuCfMJ0ijCj/IOzP0jtBA9R
	 dRpdrWzTx0t38Aw84C2j2TbTN6wsGUvoShX32ewopvKJmdvXjpzkvV99UEQ172ze/n
	 bZX3M/SJUJXGxa/7EtJaSzKlkmZfyGnhvgHzm19bxkDHwn9phEwTyaJCoLUCjOlraC
	 G25PFsz6zxEbw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Add scx_cgroup_sched() for cgrp->scx_sched reads
Date: Thu, 23 Jul 2026 15:29:12 -1000
Message-ID: <20260724012914.107823-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724012914.107823-1-tj@kernel.org>
References: <20260724012914.107823-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgrp->scx_sched is __rcu and published with rcu_assign_pointer() but every
reader loads it with a plain access, so sparse flags all of them. The reads
are lock-protected: enable/disable paths rewrite the field under all of
scx_enable_mutex, scx_fork_rwsem and cgroup_mutex, and cgroup creation
inherits the parent's sched under cgroup_mutex before the new cgroup is
reachable, so holding any one of the three locks makes the read stable.

Add scx_cgroup_sched() which states the protection with
rcu_dereference_check() and convert the readers. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |  6 +++---
 kernel/sched/ext/sub.c | 16 +++++++++-------
 kernel/sched/ext/sub.h | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 81c2d8eeae41..d172ff5f7dc3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3795,7 +3795,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 
 	if (scx_init_task_enabled) {
 #ifdef CONFIG_EXT_SUB_SCHED
-		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
+		struct scx_sched *sch = scx_cgroup_sched(kargs->cset->dfl_cgrp);
 #else
 		struct scx_sched *sch = scx_root;
 #endif
@@ -4449,7 +4449,7 @@ int scx_tg_online(struct task_group *tg)
 		 * always belongs to the root sched.
 		 */
 		if (cgroup_on_dfl(tg->css.cgroup))
-			sch = tg->css.cgroup->scx_sched;
+			sch = scx_cgroup_sched(tg->css.cgroup);
 		else
 			sch = scx_tg_sched(&root_task_group);
 
@@ -4530,7 +4530,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 		 * cgroup's sched and is reported through the
 		 * exit_task/init_task pair that the re-homing generates.
 		 */
-		if (!sch || sch != task_css_set(p)->mg_dst_cset->dfl_cgrp->scx_sched)
+		if (!sch || sch != scx_cgroup_sched(task_css_set(p)->mg_dst_cset->dfl_cgrp))
 			continue;
 
 		if (SCX_HAS_OP(sch, cgroup_prep_move)) {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6da6c91e4287..2a8c979c7976 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1204,7 +1204,7 @@ void scx_sub_disable(struct scx_sched *sch)
 /* verify that a scheduler can be attached to @cgrp and return the parent */
 static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
 {
-	struct scx_sched *parent = cgrp->scx_sched;
+	struct scx_sched *parent = scx_cgroup_sched(cgrp);
 	struct scx_sched *pos;
 
 	lockdep_assert_held(&scx_sched_lock);
@@ -1578,7 +1578,7 @@ static s32 scx_cgroup_task_migrating(struct cgroup_task_migrate_ctx *ctx)
 	if (!scx_cgroup_enabled)
 		return NOTIFY_OK;
 
-	to = ctx->dst_dcgrp->scx_sched;
+	to = scx_cgroup_sched(ctx->dst_dcgrp);
 	if (scx_task_on_sched(to, p))
 		return NOTIFY_OK;
 
@@ -1612,7 +1612,7 @@ static void scx_cgroup_task_migrated(struct cgroup_task_migrate_ctx *ctx)
 	if (!scx_cgroup_enabled)
 		return;
 
-	to = ctx->dst_dcgrp->scx_sched;
+	to = scx_cgroup_sched(ctx->dst_dcgrp);
 	if (scx_task_on_sched(to, p))
 		return;
 
@@ -1639,7 +1639,7 @@ static void scx_cgroup_task_migrate_canceled(struct cgroup_task_migrate_ctx *ctx
 	if (!scx_cgroup_enabled)
 		return;
 
-	to = ctx->dst_dcgrp->scx_sched;
+	to = scx_cgroup_sched(ctx->dst_dcgrp);
 	if (scx_task_on_sched(to, p))
 		return;
 
@@ -1653,6 +1653,7 @@ static s32 scx_cgroup_lifetime_notify(struct notifier_block *nb,
 {
 	struct cgroup *cgrp = data;
 	struct cgroup *parent = cgroup_parent(cgrp);
+	struct scx_sched *sch;
 
 	if (!cgroup_on_dfl(cgrp))
 		return NOTIFY_OK;
@@ -1661,12 +1662,13 @@ static s32 scx_cgroup_lifetime_notify(struct notifier_block *nb,
 	case CGROUP_LIFETIME_ONLINE:
 		/* inherit ->scx_sched from $parent */
 		if (parent)
-			rcu_assign_pointer(cgrp->scx_sched, parent->scx_sched);
+			rcu_assign_pointer(cgrp->scx_sched, scx_cgroup_sched(parent));
 		break;
 	case CGROUP_LIFETIME_OFFLINE:
 		/* if there is a sched attached, shoot it down */
-		if (cgrp->scx_sched && cgrp->scx_sched->cgrp == cgrp)
-			scx_exit(cgrp->scx_sched, SCX_EXIT_UNREG_KERN,
+		sch = scx_cgroup_sched(cgrp);
+		if (sch && sch->cgrp == cgrp)
+			scx_exit(sch, SCX_EXIT_UNREG_KERN,
 				 SCX_ECODE_RSN_CGROUP_OFFLINE,
 				 "cgroup %llu going offline", cgroup_id(cgrp));
 		break;
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 625d7ce334aa..0019b75a2560 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -39,6 +39,20 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
 void scx_reenq_reject(struct rq *rq);
 
+/*
+ * cgrp->scx_sched is written by root/sub enable/disable under all of
+ * scx_enable_mutex, scx_fork_rwsem and cgroup_mutex. A new cgroup inherits the
+ * parent's sched under just cgroup_mutex but is not yet reachable by the other
+ * two lock holders. Any one of the three locks stabilizes the association.
+ */
+static inline struct scx_sched *scx_cgroup_sched(struct cgroup *cgrp)
+{
+	return rcu_dereference_check(cgrp->scx_sched,
+				     lockdep_is_held(&cgroup_mutex) ||
+				     percpu_rwsem_is_held(&scx_fork_rwsem) ||
+				     lockdep_is_held(&scx_enable_mutex));
+}
+
 static inline const char *sch_cgrp_path(struct scx_sched *sch)
 {
 	return sch->cgrp_path;
-- 
2.55.0

