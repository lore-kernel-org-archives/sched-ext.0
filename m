Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D473C5DB2
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286524; cv=none; b=kdVvaj8BmD1qvroZXH7Zgw4LRRC7oOHCdiXeRIgaZYgvL6l9N3Pe9ZIv7L6/6Z09Rrui9+6MI9vIW4YKbBS98hqPfU3xAvQTsnMm9D1eLuuCTOSLRVhfRrco12t0nP9cc1hJYToKfPLAVYFHHEBZOHofVDZbEqwduk1a4gwWC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286524; c=relaxed/simple;
	bh=cDB+bSSvwzhFfwOvwHmthTOwhfiJzRlgUTwqDQ6oFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqhCIhU8r4UYm6G9Ft1KUUAWnbqMD6i8ziWb7/SbKZ1j8KHhEAukmiQ9y18DUtbxuZkDfp7T+LTuy8IgJkxTAcQ6wZa8r4uWNbxhpiMBaz9uo7nJTJ7G/CAXWkikpjvfkCaf9Kpf/5k0Rnc7/KTjWrGnwm5GFqpgh3MBRjQGYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF7JeN+n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF7JeN+n"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35691a231a7so269400a91.3
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774286522; x=1774891322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiUwmld1HCHEfyBXLWvyjnKqydf3txOWFB0VQNNLLPs=;
        b=gF7JeN+n4lX4YtI+I4ggyYB8h1Ws99nOEr/GF0p4/cILGx8qBcw3nJhLnho+13mmqN
         Fa7p75s3M0BcgIb02aQCxEM3d89yvhSDdrHaFTnKAWecc1HpGMsDIoPaKuXh/VukU3Vt
         K8EkbDp2dYuovrsep7Q2f/aC+bwr65/kGNTn54rMEM3/cIO8vS5nEYm0SdmViMS2asFJ
         u3H/PT8ghqf6YfgA7aaddrxJEqHllzQ3qOTypM5hgqAwgDLukfxyXMSTv5xhKRQmJUAh
         8ZEXJIDmfluD0fV2MAoTMEJfcEwAd1MurEnoCy9vpCL0R1u9pck8pUc9kO8S3h3ySFKA
         qsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286522; x=1774891322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XiUwmld1HCHEfyBXLWvyjnKqydf3txOWFB0VQNNLLPs=;
        b=jSOGptIQkljYcWW9K/tRXsSsiMsbNR+KFDC5RV4bfrZEfA+J10MqvmeICFScaLImWy
         9RlSST3/XA7xUlZ2RMj1Bww7Bc5NbRFb3Lp+127Refio5PHz0tvsrrTSz8FTpiMdEE9A
         lMJ6jjr4+bVye/yTooJ6gXqkkhKMRFfMePr8dVBZ1/WxadgLU2AzKHCUNR5wACXj4gEV
         oercMKSSIEV02URPMtow0uQiYUQPFhavJpz59SGFmbikFlp3wJDCtW2V6Ouiu3zu7+0g
         LMMOnv4HglrSaUtbA1rQFtEa7SKHKUp7XLb0Iozl634boRF6Cfpf1AT7AwvfEK5EOAul
         OYvg==
X-Gm-Message-State: AOJu0YyCqFLzEbK4V5ZjVfElIWlyrUFpQQ/2djUc5NuhqwXzbtzoRn5q
	10FmckANAEudYlbpihbRtstnSGaXX6CC06fVAjEl7Bg/pzsPLbTac4YdzGppxzhH
X-Gm-Gg: ATEYQzzhF83bXLDmxz1T6nNMHJSNzz5hm7yowzi1F/gm00Uh1KPgJ5Pkwi0rKkpTtBQ
	Vo/jKQfZAtCbfuC2/CcmQbV5IAnU3Nto6fL9MsbNKK4IPxdHAeMCjc4JvjOM583qw4leznGq0Hb
	e/7JnHiaKzu1NRFrkXwaaPBQNmzT3icbQhe+HgZicatddLrKSRGfbP28ZZ5pAzlLsj2ZoYzWJ2V
	jJEtMLYNXphd0VAnG3meivRWgzat1T/EKDi0zpuxJlVTAPO/UVJeepCZYHs574hcoQZC/05zear
	mDgQ0EVpNA49owPnSYGkhfUqzrbtoC4bR8amOannbZXx+Jx46Z/1zubMG7kPNh5ohJXtkgfKFwd
	bgEQTViW+HXksFaI0EE6W5T9czY5AWSB0mz/onlZ718GRtWMVk+1BvzMrcwXalFSU+BoabYYlG3
	UaX46mS6ZKIT0jSBhNoG/Hx5tOFh3foIF96u8AGOsDQP6NGzDZLOuh
X-Received: by 2002:a17:90b:3c10:b0:359:8256:19f9 with SMTP id 98e67ed59e1d1-35bd2bf8701mr10418155a91.15.1774286522117;
        Mon, 23 Mar 2026 10:22:02 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm13552672a91.14.2026.03.23.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:22:01 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 3/3] selftests/sched_ext: Update selftests to drop __COMPAT prefix
Date: Tue, 24 Mar 2026 01:21:30 +0800
Message-ID: <20260323172145.25689-4-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260323172145.25689-1-yphbchou0911@gmail.com>
References: <20260323172145.25689-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace __COMPAT prefix calls with the new transparent function names:

dsq_reenq.bpf.c:
- __COMPAT_has_generic_reenq() -> scx_bpf_has_generic_reenq()

peek_dsq.bpf.c:
- __COMPAT_scx_bpf_dsq_peek() -> scx_bpf_dsq_peek()
- bpf_ksym_exists(scx_bpf_dsq_peek) -> bpf_ksym_exists(scx_bpf_dsq_peek___compat)
  since scx_bpf_dsq_peek is now a static inline, not a __weak ksym

numa.bpf.c / numa.c:
- __COMPAT_scx_bpf_get_idle_cpumask_node() -> scx_bpf_get_idle_cpumask_node()
- __COMPAT_scx_bpf_cpu_node() -> scx_bpf_cpu_node()
- __COMPAT_scx_bpf_pick_idle_cpu_node() -> scx_bpf_pick_idle_cpu_node()
- __COMPAT_scx_bpf_pick_any_cpu_node() -> scx_bpf_pick_any_cpu_node()
- __COMPAT_scx_bpf_nr_node_ids() -> scx_bpf_nr_node_ids()
- __COMPAT_SCX_PICK_IDLE_IN_NODE rodata variable -> pick_idle_in_node

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 .../selftests/sched_ext/dsq_reenq.bpf.c       |  2 +-
 tools/testing/selftests/sched_ext/numa.bpf.c  | 22 +++++++++----------
 tools/testing/selftests/sched_ext/numa.c      |  2 +-
 .../selftests/sched_ext/peek_dsq.bpf.c        |  8 +++----
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
index 750bb10508df..131dc0c91f5c 100644
--- a/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
@@ -91,7 +91,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_reenq_init)
 	if (ret)
 		return ret;
 
-	if (!__COMPAT_has_generic_reenq()) {
+	if (!scx_bpf_has_generic_reenq()) {
 		scx_bpf_error("scx_bpf_dsq_reenq() not available");
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
index 78cc49a7f9a6..a003a1f267fa 100644
--- a/tools/testing/selftests/sched_ext/numa.bpf.c
+++ b/tools/testing/selftests/sched_ext/numa.bpf.c
@@ -17,14 +17,14 @@ char _license[] SEC("license") = "GPL";
 
 UEI_DEFINE(uei);
 
-const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_NODE;
+const volatile unsigned int pick_idle_in_node;
 
 static bool is_cpu_idle(s32 cpu, int node)
 {
 	const struct cpumask *idle_cpumask;
 	bool idle;
 
-	idle_cpumask = __COMPAT_scx_bpf_get_idle_cpumask_node(node);
+	idle_cpumask = scx_bpf_get_idle_cpumask_node(node);
 	idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
 	scx_bpf_put_cpumask(idle_cpumask);
 
@@ -34,24 +34,22 @@ static bool is_cpu_idle(s32 cpu, int node)
 s32 BPF_STRUCT_OPS(numa_select_cpu,
 		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	int node = __COMPAT_scx_bpf_cpu_node(scx_bpf_task_cpu(p));
+	int node = scx_bpf_cpu_node(scx_bpf_task_cpu(p));
 	s32 cpu;
 
 	/*
-	 * We could just use __COMPAT_scx_bpf_pick_any_cpu_node() here,
+	 * We could just use scx_bpf_pick_any_cpu_node() here,
 	 * since it already tries to pick an idle CPU within the node
 	 * first, but let's use both functions for better testing coverage.
 	 */
-	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
-					__COMPAT_SCX_PICK_IDLE_IN_NODE);
+	cpu = scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node, pick_idle_in_node);
 	if (cpu < 0)
-		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
-						__COMPAT_SCX_PICK_IDLE_IN_NODE);
+		cpu = scx_bpf_pick_any_cpu_node(p->cpus_ptr, node, pick_idle_in_node);
 
 	if (is_cpu_idle(cpu, node))
 		scx_bpf_error("CPU %d should be marked as busy", cpu);
 
-	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
+	if (scx_bpf_cpu_node(cpu) != node)
 		scx_bpf_error("CPU %d should be in node %d", cpu, node);
 
 	return cpu;
@@ -59,14 +57,14 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
 
 void BPF_STRUCT_OPS(numa_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	int node = __COMPAT_scx_bpf_cpu_node(scx_bpf_task_cpu(p));
+	int node = scx_bpf_cpu_node(scx_bpf_task_cpu(p));
 
 	scx_bpf_dsq_insert(p, node, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(numa_dispatch, s32 cpu, struct task_struct *prev)
 {
-	int node = __COMPAT_scx_bpf_cpu_node(cpu);
+	int node = scx_bpf_cpu_node(cpu);
 
 	scx_bpf_dsq_move_to_local(node, 0);
 }
@@ -75,7 +73,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(numa_init)
 {
 	int node, err;
 
-	bpf_for(node, 0, __COMPAT_scx_bpf_nr_node_ids()) {
+	bpf_for(node, 0, scx_bpf_nr_node_ids()) {
 		err = scx_bpf_create_dsq(node, node);
 		if (err)
 			return err;
diff --git a/tools/testing/selftests/sched_ext/numa.c b/tools/testing/selftests/sched_ext/numa.c
index b060c3b65c82..17f5c2b5bac1 100644
--- a/tools/testing/selftests/sched_ext/numa.c
+++ b/tools/testing/selftests/sched_ext/numa.c
@@ -16,7 +16,7 @@ static enum scx_test_status setup(void **ctx)
 	skel = numa__open();
 	SCX_FAIL_IF(!skel, "Failed to open");
 	SCX_ENUM_INIT(skel);
-	skel->rodata->__COMPAT_SCX_PICK_IDLE_IN_NODE = SCX_PICK_IDLE_IN_NODE;
+	skel->rodata->pick_idle_in_node = SCX_PICK_IDLE_IN_NODE;
 	skel->struct_ops.numa_ops->flags = SCX_OPS_BUILTIN_IDLE_PER_NODE;
 	SCX_FAIL_IF(numa__load(skel), "Failed to load skel");
 
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
index 96e3a336a8a6..0c80c65239d4 100644
--- a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -89,7 +89,7 @@ static int scan_dsq_pool(void)
 
 		total_peek_attempts++;
 
-		task = __COMPAT_scx_bpf_dsq_peek(dsq_id);
+		task = scx_bpf_dsq_peek(dsq_id);
 		if (task) {
 			successful_peeks++;
 			record_peek_result(task->pid);
@@ -119,7 +119,7 @@ void BPF_STRUCT_OPS(peek_dsq_enqueue, struct task_struct *p, u64 enq_flags)
 		bpf_printk("peek_dsq_enqueue beginning phase 1 peek test on cpu %d", cpu);
 
 		/* Test 1: Peek empty DSQ - should return NULL */
-		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		peek_result = scx_bpf_dsq_peek(test_dsq_id);
 		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
 
 		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
@@ -150,7 +150,7 @@ void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
 		bpf_printk("peek_dsq_dispatch completing phase 1 peek test on cpu %d", cpu);
 
 		/* Test 3: Peek DSQ after insert - should return the task we inserted */
-		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		peek_result = scx_bpf_dsq_peek(test_dsq_id);
 		/* Store the PID of the peeked task for comparison */
 		dsq_peek_result2 = (long)peek_result;
 		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
@@ -179,7 +179,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
 	int i;
 
 	/* Always set debug values so we can see which version we're using */
-	debug_ksym_exists = bpf_ksym_exists(scx_bpf_dsq_peek) ? 1 : 0;
+	debug_ksym_exists = bpf_ksym_exists(scx_bpf_dsq_peek___compat) ? 1 : 0;
 
 	/* Initialize state first */
 	insert_test_cpu = -1;
-- 
2.48.1

