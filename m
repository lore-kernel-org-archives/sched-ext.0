Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81886346FA8;
	Tue, 28 Apr 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408553; cv=none; b=dcr83uOELun5BEHEc+sB3rk0bP3OufBxKRn86cQJmpFCh8Ityw2KkWGKHgcvyDfRSM6kMKeR6DuT3zhOq/iB+dv9thsfoCG8SvknoeIovOBtJ21baOjpy+oVLVdy1SS8iTbplp7kmxONUDRjDytZHIL3LO6FFYtvYK9ggxLQdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408553; c=relaxed/simple;
	bh=hzm6iScRhjtkV1zjmS1rgZO1i2ahdWOrQ7A3gTIrzhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo/6KyaJwCXZ5d8Y4my5iRDK5z4mN1nkqPMG8p2VbdzRXULxBKMWYR7PhseloFUXKrgOt8G4wkrcb4q2yxC4V4yxnIGv4Ly7yjKMACjhO40+H6aABJZwXPtWal5/WKp3UY2VE0NAeCH1thUa7s+5nC32oWRODv/LXZpVYlZ4sac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xry0KIyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xry0KIyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49581C2BCAF;
	Tue, 28 Apr 2026 20:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408553;
	bh=hzm6iScRhjtkV1zjmS1rgZO1i2ahdWOrQ7A3gTIrzhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xry0KIyqZF2L/Hy8YVXsDeuU68bgoumsiaHR8kDCIegOjjV9aGUSB5P9p77v+9k6s
	 BkAOzaRUdB6MoHEEGZcN3dNnuWBoQhYhv4gVF+nbUcW8doxV2XwUu4myGb2jZ13SdH
	 kQ6FmCa4wV8MGIYIMJ7TQpzl1HjmFo+ho7eVyQomuTfB3NYM8SsoMzLdtp513twIwe
	 3wzKjCMCmKeZMtmZ+lz/jhqx4VDGpr0LNM7EO65jGfDU6hQF66lBE57ElxiEoX+4So
	 8X+VgNhCjC0IPy2WOm22Z2PA48qhKsAwizU/I7yepd+El6KiEpTLJSiWs1RybirL9p
	 GxDVK9/SajfnQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 06/17] sched_ext: Make scx_enable() take scx_enable_cmd
Date: Tue, 28 Apr 2026 10:35:34 -1000
Message-ID: <20260428203545.181052-7-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
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
index b197da2b960d..f9a1f217bc47 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6507,6 +6507,19 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
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
@@ -6749,19 +6762,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -7346,11 +7346,10 @@ static s32 __init scx_cgroup_lifetime_notifier_init(void)
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
@@ -7374,16 +7373,15 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
 
 
@@ -7555,7 +7553,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_enable(kdata, link);
+	struct scx_enable_cmd cmd = { .ops = kdata };
+
+	return scx_enable(&cmd, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
-- 
2.54.0

