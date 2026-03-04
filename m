Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FF3EDABB;
	Wed,  4 Mar 2026 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661715; cv=none; b=i58AKigN+LZdGLj0ihwlxLuihKv1IL2m+zIiq8H02Itlar2zPjA6whQGfuVp2q7u3BUp0mKnFKAgGdKghCLN/W2L7wxhCksPOMFfhwzKISnU2HKdrP04lTt+NG+g5m3zRFKWGWLf6rOakhPcbCxnXMxVb4s4K004+b57N093tPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661715; c=relaxed/simple;
	bh=bLeuOgmHpfrUiRxva2uxEBw10EGjfZToVOjUiiMe/j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKEmf28EPPhZ4PUF7kpBtUHYsPU00mSRRl+smTAxz4Ab4uzQgdHtrUzaFz/Qcbyhg41y0ghmgQnD2GdEOjsuZM9D9ZrMoDgtWVp0oXKS6wATRPXS9OXDcxyy2ojdgtmwVdmYd3DAOSfBePE25RgOqo1Dw/ebP00BEncGzd+3hCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiRyRnqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiRyRnqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C60C4CEF7;
	Wed,  4 Mar 2026 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661715;
	bh=bLeuOgmHpfrUiRxva2uxEBw10EGjfZToVOjUiiMe/j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiRyRnqs3Dcxpmm/V8BbxeTM6Ldp4rSjKcEvMyhVnOTvd26WKrpzwni6nAhcjMqZY
	 1RtQCy0WXt4DWo7QqTJzydeZK9pRayjOVEVhzcNKUtu0QuBRxiWjtOAbXYvic1wKVA
	 p9RFw4mWRt7PunaQzW0v7J93cWU16bDP+vFDW+tV22dLeTQ3+Sle8AEuCGpcErl9K/
	 djwApl/kmT1Ic8lRYSzvuQjrhLq+ymXyuNAm73GGk0cijjCpigMnxtjz3W2CPuVHZt
	 DG7erdEVIqmOWqjRbrLlQbTZyj8XK4vFyH6Zbqb2LmuhBPzipodYefd1wy8SKISP6T
	 BBu1ttz6Flwig==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 33/34] sched_ext: Add rhashtable lookup for sub-schedulers
Date: Wed,  4 Mar 2026 12:01:18 -1000
Message-ID: <20260304220119.4095551-34-tj@kernel.org>
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

Add rhashtable-based lookup for sub-schedulers indexed by cgroup_id to
enable efficient scheduler discovery in preparation for multiple scheduler
support. The hash table allows quick lookup of the appropriate scheduler
instance when processing tasks from different cgroups.

This extends scx_link_sched() to register sub-schedulers in the hash table
and scx_unlink_sched() to remove them. A new scx_find_sub_sched() function
provides the lookup interface.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 50 +++++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h |  2 ++
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0b7dc6573411..ed49962c8d6a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -27,6 +27,16 @@ struct scx_sched __rcu *scx_root;
  */
 static LIST_HEAD(scx_sched_all);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static const struct rhashtable_params scx_sched_hash_params = {
+	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
+	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
+	.head_offset		= offsetof(struct scx_sched, hash_node),
+};
+
+static struct rhashtable scx_sched_hash;
+#endif
+
 /*
  * During exit, a task may schedule after losing its PIDs. When disabling the
  * BPF scheduler, we need to be able to iterate tasks in every state to
@@ -287,6 +297,12 @@ static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 	return NULL;
 }
 
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id)
+{
+	return rhashtable_lookup(&scx_sched_hash, &cgroup_id,
+				 scx_sched_hash_params);
+}
+
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 {
 	rcu_assign_pointer(p->scx.sched, sch);
@@ -294,6 +310,7 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 #else	/* CONFIG_EXT_SUB_SCHED */
 static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id) { return NULL; }
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -4830,26 +4847,41 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
-static void scx_link_sched(struct scx_sched *sch)
+static s32 scx_link_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
-		if (parent)
+		s32 ret;
+
+		if (parent) {
+			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
+					&sch->hash_node, scx_sched_hash_params);
+			if (ret) {
+				scx_error(sch, "failed to insert into scx_sched_hash (%d)", ret);
+				return ret;
+			}
+
 			list_add_tail(&sch->sibling, &parent->children);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
+
 		list_add_tail_rcu(&sch->all, &scx_sched_all);
 	}
 
 	refresh_watchdog();
+	return 0;
 }
 
 static void scx_unlink_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
-		if (scx_parent(sch))
+		if (scx_parent(sch)) {
+			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
+					       scx_sched_hash_params);
 			list_del_init(&sch->sibling);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
 	}
@@ -5906,7 +5938,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	scx_idle_enable(ops);
 
@@ -6171,7 +6205,9 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		goto out_put_cgrp;
 	}
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
@@ -6997,6 +7033,10 @@ void __init init_sched_ext_class(void)
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	register_sysrq_key('D', &sysrq_sched_ext_dump_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	BUG_ON(rhashtable_init(&scx_sched_hash, &scx_sched_hash_params));
+#endif	/* CONFIG_EXT_SUB_SCHED */
 }
 
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b94b615f8d94..be1b91847cd2 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1014,6 +1014,8 @@ struct scx_sched {
 	struct list_head	all;
 
 #ifdef CONFIG_EXT_SUB_SCHED
+	struct rhash_head	hash_node;
+
 	struct list_head	children;
 	struct list_head	sibling;
 	struct cgroup		*cgrp;
-- 
2.53.0

