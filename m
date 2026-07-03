Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019137D137;
	Fri,  3 Jul 2026 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065733; cv=none; b=WvNyGcvj94dLpvHv7MgOp5TINKf350gxIaoONA44DY7lQn11ptmXpVLaYTMaVtYtjgJWCqIrkOhfCTCfEUz33XeTPkSDZJhAuDNo8yewy4vKrDOGHJixijCDHDMzzqasgB+lOftWKJ1KqESiZYsSKXbeaYzjxq1pU3010olvkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065733; c=relaxed/simple;
	bh=0TIM1F3Q3Nhb+vyuPksjtaJeWoqSOZQGJP85GkSub9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYY0WFlamXDR57GyUmfGkWeTkcenqeRgk2bPPVHhxmQWttT7dNy2G313RHLQGXezrZarGw5jm4hucYnf/8kxOknWJVIcYKP6DxNPEmEiRgrUiXnM6LNi9bF0WSwpeG/RCih5wMm6p9MkitgtkX9ASbELSFhmPQovkaTYfTWCSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXbsFidv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXbsFidv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0981F000E9;
	Fri,  3 Jul 2026 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065731;
	bh=6HiHT0a7L7FHYa7qUnKc6LBIIc0A5qcu1vD8yHRmmUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXbsFidvXF9AAFKhNDFLkHjEUUDSolyhaqu8+0Ld0wBq6embilgzEYFKa7S8LWYJA
	 kacJOUcUb5W35FcIErBUxuE+ICGN1W3y25oD+R2xELP1pprdeMCjsNf+zOj7lNv7lM
	 2GoEbSXiMYZ/a2Hh0kIC2DGw5u/ueUnpPUD1As/YFn1gifBrC3HfjTEmm8E/y07da5
	 WfH/WgtNTaOkmNcvqZTcA3i85KlxQxBEkVvBTLU3pw4Sw2ZkOkT9SgIjfDxnU5EtKo
	 UyTDU6+C6q3yl8+8RrhXu3kYvcJZlT/B15gmSutWIbOcoyAI/OcTMj1x6MnY5MORQx
	 tplXXq8ZOw3FA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 11/32] sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
Date: Thu,  2 Jul 2026 22:01:38 -1000
Message-ID: <20260703080159.2314350-12-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index 87a3fb9bb446..fcb8bf0d2422 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5704,7 +5704,9 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->sub_kset)
 		kobject_del(&sch->sub_kset->kobj);
 #endif
-	kobject_del(&sch->kobj);
+	/* not added if enable failed before scx_sched_sysfs_add() */
+	if (sch->kobj.state_in_sysfs)
+		kobject_del(&sch->kobj);
 
 	free_kick_syncs();
 
@@ -6421,36 +6423,15 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
@@ -6508,6 +6489,36 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
@@ -6730,6 +6741,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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
index ba5e9be0e3c3..7c6f4ed10cde 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1689,6 +1689,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 					  struct cgroup *cgrp,
 					  struct scx_sched *parent);
 int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
+int scx_sched_sysfs_add(struct scx_sched *sch);
 
 extern raw_spinlock_t scx_sched_lock;
 extern struct mutex scx_enable_mutex;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 050420427273..e94a415ee10a 100644
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

