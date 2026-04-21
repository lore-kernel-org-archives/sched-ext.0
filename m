Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88C3876AF;
	Tue, 21 Apr 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755992; cv=none; b=oex0FeobOVhVWFhap51p4bNxLIDrMJX6ku9rffR3lHiEfvpU/Qli1oQ8TJcKa5gNKC5/bTqvMH4dU2/ecexBt+1QeEYlpycqgciPY8dE5PC8yQo7yPu7ePOE1onXiAvxJ6zBB9OGRU9oZRD4llhLPhILkwc2r6X1qJ4QwqHVyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755992; c=relaxed/simple;
	bh=vmfcFdnPYrX3o+pQIMNxLd2lzxF8QL5S4e7E9kR3ftw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvzF6cCfDiWgc3mjAWgyiA01UMBAxzPcvwSavJJRxkCApZ6ckDAtqeFmPykv0zDRuphO6M1OXPs5I4hnpGskAfGrjHyQauHM9vanGPL1st7k+x68ufqXOzkBWwHaRThJbs6xbAUm1w/5dkQkqbvE6JArMbj05OkO1I8xYJepUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Z/9NmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Z/9NmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCCC2BCB7;
	Tue, 21 Apr 2026 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755992;
	bh=vmfcFdnPYrX3o+pQIMNxLd2lzxF8QL5S4e7E9kR3ftw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1Z/9NmNqoD+Buepvct8b5CBqbXISrWBJtEVJiHWcMLuDdg/v/kBsdJb0sp1AUvjx
	 7lvniz5BHUbvQNr4OMgwqQa1HqtX/QsE0baCFnN2y1WkALg98vo/No9Hhx0+rZEvPL
	 ETZWKt/aANqndxfmi8vKgp63Lf+g/2a56p4mV5zUdNjiQFnQEMmpANK+KmPZPlPmsJ
	 b49IHzOXN4yxk8JAA/iLQiGYJJPLw6ndhJNy5C7aw0h3J3vztS02olfIYwuKPMqF21
	 7KbxEjVeNteUpuX4DeWUtSG1EZ3SFBVY/8zfyO/cz83v8RhOu7XFCLjXkzQj1JgQfl
	 SceRrxr+WF76g==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/16] sched_ext: Make scx_enable() take scx_enable_cmd
Date: Mon, 20 Apr 2026 21:19:34 -1000
Message-ID: <20260421071945.3110084-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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
---
 kernel/sched/ext.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 74e4271e44e9..62aab432dbf4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6424,6 +6424,19 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
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
@@ -6655,19 +6668,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7243,11 +7243,10 @@ static s32 __init scx_cgroup_lifetime_notifier_init(void)
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
@@ -7271,16 +7270,15 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
 
 
@@ -7452,7 +7450,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
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

