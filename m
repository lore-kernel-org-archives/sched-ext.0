Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DA3115A3;
	Mon, 22 Sep 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557681; cv=none; b=IjD84tt8Iqcq/OzLDU8g+Myp9QeOm6/MXHzBOa/X72Nds7naauvr9sOkdlypVp5wfa3KsD05+I610IlMGAFiOI0Osd9G+e1hqtQdA4kybRUIlRdsm/pwn/mtkcDWf98/WqSk4ufo4Vhrqma62nNeunBIAa6Zhz1eNSE2zg+aF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557681; c=relaxed/simple;
	bh=N8NdxfmZXIcYOUKNsEt/ZUcRXN1TPpQdfGuEhvDG+QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2mSrBU8C47JZ+Ph2EPa5Qa/2b4bkOqrTwuvC3GjAhJh075FeSygLUelXwSnHB8BtqqGlv/sGYo6QjbQYh2b4Ga5KtSk97Hq+cIZZr+jWW837exwPH8Y574wXiPulrzt4fXWOgsVpJ85xvo+kFsgqLQZszTiFCA8dQ0AJrTT0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIo1ZTsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIo1ZTsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7115EC4CEF0;
	Mon, 22 Sep 2025 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557680;
	bh=N8NdxfmZXIcYOUKNsEt/ZUcRXN1TPpQdfGuEhvDG+QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIo1ZTspYOYVbTQF9vbdoRwV5HLaCLsI9xlEIi83rjmEf2y4HyMdnnJbODGQw38K8
	 GcUOP7sFoKqQvHgPnyMaBEz0E0OteN/RwuRueLcpTd7EaWsCIxAKbaHq41hwZrpFsk
	 hxna8oVljjCmlZQddAxS2Yp2VnAFQbrBCUFcGPP5froIcJ+URIUQPY8mcKJhW3stx7
	 XezXW0vy6HL4YUaZunHs3/q8BLh+yRs9UYrpmbwIkCxCpNUCwmAN2NduEvFRr2dcNR
	 qAqc9/yIgf6F+QMKRMzZAIdEWgQms/rS3i2gViFBZhl5SqgwKUiPUPKVYEEoqih9+T
	 QN/bVWdInX7jA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/7] sched_ext: Add the @sch parameter to ext_idle helpers
Date: Mon, 22 Sep 2025 06:14:32 -1000
Message-ID: <20250922161436.358949-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, add the @sch parameter to
validate_node(), check_builtin_idle_enabled() and select_cpu_from_kfunc(),
and update their callers to read $scx_root, verify that it's not NULL and
pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_idle.c | 109 ++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 7174e1c1a392..6e2504ae7357 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -819,7 +819,7 @@ void scx_idle_disable(void)
  * Helpers that can be called from the BPF scheduler.
  */
 
-static int validate_node(int node)
+static int validate_node(struct scx_sched *sch, int node)
 {
 	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("per-node idle tracking is disabled");
@@ -847,7 +847,7 @@ static int validate_node(int node)
 
 __bpf_kfunc_start_defs();
 
-static bool check_builtin_idle_enabled(void)
+static bool check_builtin_idle_enabled(struct scx_sched *sch)
 {
 	if (static_branch_likely(&scx_builtin_idle_enabled))
 		return true;
@@ -856,7 +856,8 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
-static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
+				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
 	struct rq *rq;
@@ -866,7 +867,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
 	if (!kf_cpu_valid(prev_cpu, NULL))
 		return -EINVAL;
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return -EBUSY;
 
 	/*
@@ -946,15 +947,21 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	struct scx_sched *sch;
 	s32 cpu;
 
-	cpu = select_cpu_from_kfunc(p, prev_cpu, wake_flags, NULL, 0);
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	cpu = select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags, NULL, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
 	}
 	*is_idle = false;
-
 	return prev_cpu;
 }
 
@@ -981,7 +988,16 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				       const struct cpumask *cpus_allowed, u64 flags)
 {
-	return select_cpu_from_kfunc(p, prev_cpu, wake_flags, cpus_allowed, flags);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	return select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags,
+				     cpus_allowed, flags);
 }
 
 /**
@@ -995,7 +1011,15 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return cpu_none_mask;
 
@@ -1011,12 +1035,20 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return cpu_none_mask;
 
 	return idle_cpumask(NUMA_NO_NODE)->cpu;
@@ -1034,7 +1066,15 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return cpu_none_mask;
 
@@ -1054,12 +1094,20 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return cpu_none_mask;
 
 	if (sched_smt_active())
@@ -1095,7 +1143,15 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
  */
 __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 {
-	if (!check_builtin_idle_enabled())
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
+
+	if (!check_builtin_idle_enabled(sch))
 		return false;
 
 	if (!kf_cpu_valid(cpu, NULL))
@@ -1126,7 +1182,15 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 					   int node, u64 flags)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return node;
 
@@ -1158,12 +1222,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 				      u64 flags)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
 	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
 		scx_kf_error("per-node idle tracking is enabled");
 		return -EBUSY;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return -EBUSY;
 
 	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
@@ -1193,9 +1265,16 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 					  int node, u64 flags)
 {
+	struct scx_sched *sch;
 	s32 cpu;
 
-	node = validate_node(node);
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return node;
 
-- 
2.51.0

