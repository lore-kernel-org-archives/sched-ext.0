Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D32C21F4;
	Fri, 24 Apr 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994348; cv=none; b=o6AH507tB62+IeG7AzCluEUTIDXfbZthP+6XHqsw9sGMX3aUSBIOz6luOfRyN6yBm/b+uO77Ayemv4lEFsJaCQTqwOKX/L7CspDl2YkFc2QnmXuvA3hF+xSvZdb4ay6oRMD4M97Ut45EE5hb0RRl15cjPmYn71kTUl223JWeyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994348; c=relaxed/simple;
	bh=Df/QrhGUTH85Yr3EbL3zRRqadS7dp2wpP9ACZpOvrQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwnaCkPIDBgIRdeaSGSnxEAirblLDkPVJhSZJzy5Huc7VhTZSAQURw5sMUSZuhLk5XHLSi64kI6clepEjTF6TpUdTIgR9+YGEDy+JqaPICcbG1TFoaEdin+XxvZqGG+0/11VH55LR1CeOw34ch8OLXtM3o//0Tp6DqDm/r0UhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctRaYHJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctRaYHJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22700C2BCB4;
	Fri, 24 Apr 2026 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994348;
	bh=Df/QrhGUTH85Yr3EbL3zRRqadS7dp2wpP9ACZpOvrQk=;
	h=From:To:Cc:Subject:Date:From;
	b=ctRaYHJMvOLS1BNHRQRCUnjrehOSe0GDtzQVj7HvS5SJjgqxATtP7aSZdjA2RoRI0
	 xKX+dvgOo4gYsgKK+qg2AXov2Otytn+KFZn459DGVAKJb3doMxjOhERDsUE6OIarOs
	 BAzL+zJAAfT+FTeNP5KR3Nop5EuBPuNiwryWi6u2FY68DuSi6jBUreZOWKmU+yfa21
	 DG+94GbR7JMKV/uoovrYnvJcFIVv9OanjCKFcZ7QQz6n3QW8z/gdk227mBVAnb/GJA
	 6RPg8hA4DtZq42OxjROcd8g0GajBe/nXS6kbr4UW///MYIRH/8A1topah9BBCaZJYn
	 PtArP8e8WU5HA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/17] sched_ext: Make scx_enable() take scx_enable_cmd
Date: Thu, 23 Apr 2026 15:32:09 -1000
Message-ID: <20260424013220.2923402-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass struct scx_enable_cmd to scx_enable() rather than unpacking @ops
at every call site and re-packing into a fresh cmd inside. bpf_scx_reg()
now builds the cmd on its stack and hands it in; scx_enable() just
wires up the kthread work and waits.

Relocate struct scx_enable_cmd above scx_alloc_and_add_sched() so
upcoming patches that also want the cmd can see it.

No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ad255268f207..cd4c235e0c82 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6425,6 +6425,19 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
 	return pnode;
 }
 
+/*
+ * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
+ * starvation. During the READY -> ENABLED task switching loop, the calling
+ * thread's sched_class gets switched from fair to ext. As fair has higher
+ * priority than ext, the calling thread can be indefinitely starved under
+ * fair-class saturation, leading to a system hang.
+ */
+struct scx_enable_cmd {
+	struct kthread_work	work;
+	struct sched_ext_ops	*ops;
+	int			ret;
+};
+
 /*
  * Allocate and initialize a new scx_sched. @cgrp's reference is always
  * consumed whether the function succeeds or fails.
@@ -6656,19 +6669,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	return 0;
 }
 
-/*
- * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
- * starvation. During the READY -> ENABLED task switching loop, the calling
- * thread's sched_class gets switched from fair to ext. As fair has higher
- * priority than ext, the calling thread can be indefinitely starved under
- * fair-class saturation, leading to a system hang.
- */
-struct scx_enable_cmd {
-	struct kthread_work	work;
-	struct sched_ext_ops	*ops;
-	int			ret;
-};
-
 static void scx_root_enable_workfn(struct kthread_work *work)
 {
 	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
@@ -7244,11 +7244,10 @@ static s32 __init scx_cgroup_lifetime_notifier_init(void)
 core_initcall(scx_cgroup_lifetime_notifier_init);
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static s32 scx_enable(struct scx_enable_cmd *cmd, struct bpf_link *link)
 {
 	static struct kthread_worker *helper;
 	static DEFINE_MUTEX(helper_mutex);
-	struct scx_enable_cmd cmd;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
 			   cpu_possible_mask)) {
@@ -7272,16 +7271,15 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 
 #ifdef CONFIG_EXT_SUB_SCHED
-	if (ops->sub_cgroup_id > 1)
-		kthread_init_work(&cmd.work, scx_sub_enable_workfn);
+	if (cmd->ops->sub_cgroup_id > 1)
+		kthread_init_work(&cmd->work, scx_sub_enable_workfn);
 	else
 #endif	/* CONFIG_EXT_SUB_SCHED */
-		kthread_init_work(&cmd.work, scx_root_enable_workfn);
-	cmd.ops = ops;
+		kthread_init_work(&cmd->work, scx_root_enable_workfn);
 
-	kthread_queue_work(READ_ONCE(helper), &cmd.work);
-	kthread_flush_work(&cmd.work);
-	return cmd.ret;
+	kthread_queue_work(READ_ONCE(helper), &cmd->work);
+	kthread_flush_work(&cmd->work);
+	return cmd->ret;
 }
 
 
@@ -7453,7 +7451,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_enable(kdata, link);
+	struct scx_enable_cmd cmd = { .ops = kdata };
+
+	return scx_enable(&cmd, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
-- 
2.53.0

