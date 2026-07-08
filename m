Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CE3F5BE5;
	Wed,  8 Jul 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545888; cv=none; b=K/7Do47GP2zfaTizk710jSaBvg0kFEFSipYYAHxeqCY9kmNJ5+U08QjSdAIB+SsWr+gg65l9RC+IJ3GUVC2sKUvQNVrgmxfLDa3Idt/CygO78E8ZRujQM5nFq6BsheAEauAr/W/1PIjU4BzG9TIMRngtf8LlRADiffvMIfQJosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545888; c=relaxed/simple;
	bh=qPQX27uE5+pCYac79oM/sK6PeVtvrf3lGZasWaQW8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrsG1SCkhBSEaOzY/pIHjj3thqd5q0T8o0MIEGIDar+ahFRKm6UJsOhDJhh9PASOxnxJY2vLXuAZRHulhKYoggVQvD/OT7ctp3MXs6f6eoeVscumT6C2bAJUYwfRmsO5lrojdp0d9BeVCTCzKkLy4cGXsBdEQYEMTal/fHgY0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuDJRCTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuDJRCTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7151F00ACA;
	Wed,  8 Jul 2026 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545885;
	bh=Lbc+TgH0SgQI+N3JrbFyn59mTDEnq8nZTMwBtViDvT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuDJRCTFHuNgaBuxtvo05tVjNsA7T4jQ2vo3IKjlJWn8/eehuY2sTWSV+3dTJK/Zl
	 oYziAMxKABmY0whfwPdjwKGVXasChxYBnqv01USBLCiDgWhkj1wlHJi+4rD6J+SLxC
	 kDDLfU8GI7XT20uw40t5n2wOdrmbQNAfXfz4vt3ydYBjKRM5sNcGwtO1+BSHXB9yr1
	 +NopIqSu/PqgkADGw59WKuudvcxbPIG7VdPTSapPUwvhQcpnKvbXwY83quHyJhUBFP
	 9Zfdrgxca7/5wHY9qLWNRutmtYtNkj3rIZgart1+ihz8/Rz/FhQmEMqaPHVfcWfDFe
	 DX/X4+CpTH8Cw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 14/40] sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
Date: Wed,  8 Jul 2026 11:24:03 -1000
Message-ID: <20260708212429.3405787-15-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split kobject_init_and_add() in scx_alloc_and_add_sched(): only
kobject_init() runs there. A new scx_sched_sysfs_add() helper does
kobject_add() (and creates sub_kset when the scheduler implements
ops.sub_attach), called by both enable workfns once @sch is linked and its
sysfs-visible state is initialized. Prep so a future caps attribute can rely
on @sch being fully built by the time it's sysfs-visible. Add early enough
that a stall later in enable still leaves sysfs inspectable.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 73 +++++++++++++++++++++++--------------
 kernel/sched/ext/internal.h |  1 +
 kernel/sched/ext/sub.c      |  8 +++-
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 93cd66b1a0e0..1a8d62efb5c5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5698,7 +5698,9 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->sub_kset)
 		kobject_del(&sch->sub_kset->kobj);
 #endif
-	kobject_del(&sch->kobj);
+	/* not added if enable failed before scx_sched_sysfs_add() */
+	if (sch->kobj.state_in_sysfs)
+		kobject_del(&sch->kobj);
 
 	free_kick_syncs();
 
@@ -6415,36 +6417,15 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		 * disable. Released in scx_sched_free_rcu_work().
 		 */
 		kobject_get(&parent->kobj);
-		ret = kobject_init_and_add(&sch->kobj, &scx_ktype,
-					   &parent->sub_kset->kobj,
-					   "sub-%llu", cgroup_id(cgrp));
-	} else {
-		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
-	}
-
-	if (ret < 0) {
-		RCU_INIT_POINTER(ops->priv, NULL);
-		kobject_put(&sch->kobj);
-		return ERR_PTR(ret);
-	}
-
-	if (ops->sub_attach) {
-		sch->sub_kset = kset_create_and_add("sub", NULL, &sch->kobj);
-		if (!sch->sub_kset) {
-			RCU_INIT_POINTER(ops->priv, NULL);
-			kobject_put(&sch->kobj);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-#else	/* CONFIG_EXT_SUB_SCHED */
-	ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
-	if (ret < 0) {
-		RCU_INIT_POINTER(ops->priv, NULL);
-		kobject_put(&sch->kobj);
-		return ERR_PTR(ret);
 	}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * Init the kobj but don't add to sysfs yet. The enable path calls
+	 * scx_sched_sysfs_add() once @sch's sysfs-visible state is initialized.
+	 */
+	kobject_init(&sch->kobj, &scx_ktype);
+
 	/*
 	 * Consume the arena_map ref bpf_scx_reg_cid() took. Defer to here so
 	 * earlier failure paths leave cmd->arena_map set and bpf_scx_reg_cid
@@ -6502,6 +6483,36 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	return ERR_PTR(ret);
 }
 
+/*
+ * Add @sch's kobject to sysfs, and create its sub_kset if the scheduler
+ * implements ops.sub_attach. Called by the enable workfns once @sch's
+ * sysfs-visible state is initialized.
+ */
+int scx_sched_sysfs_add(struct scx_sched *sch)
+{
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_sched *parent = scx_parent(sch);
+	int ret;
+
+	if (parent)
+		ret = kobject_add(&sch->kobj, &parent->sub_kset->kobj,
+				  "sub-%llu", cgroup_id(sch_cgroup(sch)));
+	else
+		ret = kobject_add(&sch->kobj, NULL, "root");
+	if (ret < 0)
+		return ret;
+
+	if (sch->ops.sub_attach) {
+		sch->sub_kset = kset_create_and_add("sub", NULL, &sch->kobj);
+		if (!sch->sub_kset)
+			return -ENOMEM;
+	}
+	return 0;
+#else
+	return kobject_add(&sch->kobj, NULL, "root");
+#endif
+}
+
 static int check_hotplug_seq(struct scx_sched *sch,
 			      const struct sched_ext_ops *ops)
 {
@@ -6724,6 +6735,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
+	ret = scx_sched_sysfs_add(sch);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
+
 	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a02aad5c0338..61a9230265cd 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1690,6 +1690,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 					  struct cgroup *cgrp,
 					  struct scx_sched *parent);
 int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
+int scx_sched_sysfs_add(struct scx_sched *sch);
 
 extern raw_spinlock_t scx_sched_lock;
 extern struct mutex scx_enable_mutex;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index ce76ae141e0a..9855a9a4e709 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -270,7 +270,9 @@ void scx_sub_disable(struct scx_sched *sch)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 	if (sch->sub_kset)
 		kobject_del(&sch->sub_kset->kobj);
-	kobject_del(&sch->kobj);
+	/* not added if enable failed before scx_sched_sysfs_add() */
+	if (sch->kobj.state_in_sysfs)
+		kobject_del(&sch->kobj);
 }
 
 /* verify that a scheduler can be attached to @cgrp and return the parent */
@@ -363,6 +365,10 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	ret = scx_sched_sysfs_add(sch);
+	if (ret)
+		goto err_disable;
+
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
-- 
2.54.0

