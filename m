Received: from out-2z4y-a135.jellyfish.systems (out-2z4y-a135.jellyfish.systems [198.54.127.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563272621
	for <sched-ext@lists.linux.dev>; Sun,  6 Sep 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705648; cv=none; b=NBzp/KHlg69sHK93lqxK6P7jL6wiZiGK77pxYbF9hS6dlA4yx5KC8tpvi40f3Yi3J9SvD+iN+l+j9Mab/7qNrePGG6A3ErsR1/ZAlSmIrYjibuS5VkWVM3db/Nj5SNBQ9S0jAOGiF5kQoiU21jkGXViPoX5/CmDfMR33n0tb5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705648; c=relaxed/simple;
	bh=1h/QQ6duO528OlThOs542J/mhgQmH9J87s2umK0mSko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwdvvI5xzmLbtRlEI1XWoee6MAj/ZGv1hUQsKamqL9wM+YgEU4iY/apX9wamLWviQKOp2QC2JUWMIBYrkKg88aoy/WqvSS4hLiZEr6eJeR46T7FGxoL3Eh02smb6Tmme7wcS7sAf+56fVp5LiPtN8oV7dicqv8ikS+VcD+TmpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Q1GAzMbn; arc=none smtp.client-ip=198.54.127.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Q1GAzMbn"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdCYM6yjLz8sY8;
	Sun, 06 Sep 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788705644;
	bh=PVCy054hdtEsDkZ1qYlyURG4QQmkYxTjJnPPeIByJ9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Q1GAzMbn0tzJwSvzVzb8i32sTN0hgnG5bZc1dARMG2pCCwSHz6vOtRP6pIXJmXfco
	 9yLHOSB9J4M3YpSlKxTd2wsBBf7bkNPyU08PX7Va3nt3PI770RXtQH2nYqtyT4D7n9
	 27pI8d+Jt6TJOvT1InF7mN+4Bsbd0k41v7QPZ3gRdIqgDnhUYBEqMfsRCxV//2N1Rx
	 wZr9ESRgm49mftQyXMJphCpzhAskNfGdxnh0opoTUkvnZKaOPC067HFvNF5SJCs5iG
	 2LeYSPRC1tWEmqlwu6hDgPI45RKqgGhb0VgUU0K35PJ9jPiA9JUmE9crq46aMm54OW
	 Gnbx2lwVnkKJg==
From: Tianyi Chen <hi@tychen.cc>
To: tj@kernel.org,
	David Vernet <void@manifault.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched_ext: Validate select_cpu_and mask constraints
Date: Sun,  6 Sep 2026 22:40:29 +0800
Message-ID: <20260906144029.848978-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

The syscall test checks whether BPF_PROG_TEST_RUN succeeds, but only
prints the CPU selection result returned by the BPF program.

Exercise empty and affinity-disjoint custom masks and require -EBUSY.
Also exercise a legal singleton mask, allowing its CPU to be busy.
Interpret retval as signed and reject unexpected errors or selection
outside the custom mask or the task's affinity.

Choose CPUs from the runner's affinity, restore it after the disjoint
case, and skip only that case when fewer than two CPUs are available.

The test passes in a two-CPU VM with full and single-CPU affinity.
Forcing selection of CPU 0 against an empty mask makes it fail with
-ERANGE; the restored test passes again.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 24 +++++-
 .../selftests/sched_ext/allowed_cpus.c        | 77 ++++++++++++++++---
 2 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 9dd72d0da29..08c2fe0e1c3 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -147,23 +147,41 @@ void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
 }
 
 struct task_cpu_arg {
-	pid_t pid;
+	u64 pid;
+	s64 custom_cpu;
 };
 
 SEC("syscall")
 int select_cpu_from_user(struct task_cpu_arg *input)
 {
 	struct task_struct *p;
-	int cpu;
+	struct bpf_cpumask *mask;
+	s32 cpu;
 
 	p = bpf_task_from_pid(input->pid);
 	if (!p)
 		return -EINVAL;
 
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		bpf_task_release(p);
+		return -ENOMEM;
+	}
+
+	/* A negative custom_cpu leaves the custom mask empty. */
+	if (input->custom_cpu >= 0)
+		bpf_cpumask_set_cpu(input->custom_cpu, mask);
+
 	bpf_rcu_read_lock();
-	cpu = scx_bpf_select_cpu_and(p, bpf_get_smp_processor_id(), 0, p->cpus_ptr, 0);
+	cpu = scx_bpf_select_cpu_and(p, bpf_get_smp_processor_id(), 0,
+				     cast_mask(mask), 0);
+	if (cpu >= 0 &&
+	    (!bpf_cpumask_test_cpu(cpu, cast_mask(mask)) ||
+	     !bpf_cpumask_test_cpu(cpu, p->cpus_ptr)))
+		cpu = -ERANGE;
 	bpf_rcu_read_unlock();
 
+	bpf_cpumask_release(mask);
 	bpf_task_release(p);
 
 	return cpu;
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
index 093f285ab4b..cc08c42ad95 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
  */
+#define _GNU_SOURCE
 #include <bpf/bpf.h>
+#include <sched.h>
 #include <scx/common.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -23,17 +25,19 @@ static enum scx_test_status setup(void **ctx)
 	return SCX_TEST_PASS;
 }
 
-static int test_select_cpu_from_user(const struct allowed_cpus *skel)
+static int test_select_cpu_from_user(const struct allowed_cpus *skel,
+				     const char *name, int custom_cpu,
+				     bool expect_busy)
 {
 	int fd, ret;
-	__u64 args[1];
+	__s32 cpu;
+	__u64 args[] = { getpid(), (__u64)(__s64)custom_cpu };
 
 	LIBBPF_OPTS(bpf_test_run_opts, attr,
 		.ctx_in = args,
 		.ctx_size_in = sizeof(args),
 	);
 
-	args[0] = getpid();
 	fd = bpf_program__fd(skel->progs.select_cpu_from_user);
 	if (fd < 0)
 		return fd;
@@ -42,7 +46,13 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
 	if (ret < 0)
 		return ret;
 
-	fprintf(stderr, "%s: CPU %d\n", __func__, attr.retval);
+	/* test_run returns the signed BPF result through an unsigned field. */
+	cpu = (__s32)attr.retval;
+	if ((expect_busy && cpu != -EBUSY) ||
+	    (!expect_busy && cpu != -EBUSY && cpu != custom_cpu)) {
+		SCX_ERR("%s: unexpected CPU selection result %d", name, cpu);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -50,21 +60,64 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
 static enum scx_test_status run(void *ctx)
 {
 	struct allowed_cpus *skel = ctx;
+	enum scx_test_status status = SCX_TEST_FAIL;
+	cpu_set_t original, pinned;
+	int first = -1, second = -1, cpu;
 	struct bpf_link *link;
 
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(original), &original),
+		    "Failed to get affinity (%d)", errno);
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &original))
+			continue;
+		if (first < 0)
+			first = cpu;
+		else {
+			second = cpu;
+			break;
+		}
+	}
+	SCX_FAIL_IF(first < 0, "No CPU in affinity mask");
+
 	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
 	SCX_FAIL_IF(!link, "Failed to attach scheduler");
 
-	/* Pick an idle CPU from user-space */
-	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
-
-	/* Just sleeping is fine, plenty of scheduling events happening */
+	if (test_select_cpu_from_user(skel, "empty mask", -1, true))
+		goto out;
+
+	/* A legal candidate may be busy; selection need not succeed. */
+	if (test_select_cpu_from_user(skel, "legal candidate", first, false))
+		goto out;
+
+	if (second >= 0) {
+		CPU_ZERO(&pinned);
+		CPU_SET(first, &pinned);
+		if (sched_setaffinity(0, sizeof(pinned), &pinned)) {
+			SCX_ERR("Failed to pin task (%d)", errno);
+			goto out;
+		}
+		if (test_select_cpu_from_user(skel, "disjoint masks", second, true))
+			goto restore;
+	} else {
+		fprintf(stderr, "Skipping disjoint masks: need two allowed CPUs\n");
+	}
+
+	/* Just sleeping is fine, plenty of scheduling events happening. */
 	sleep(1);
-
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly");
+		goto restore;
+	}
+	status = SCX_TEST_PASS;
+
+restore:
+	if (second >= 0 && sched_setaffinity(0, sizeof(original), &original)) {
+		SCX_ERR("Failed to restore affinity (%d)", errno);
+		status = SCX_TEST_FAIL;
+	}
+out:
 	bpf_link__destroy(link);
-
-	return SCX_TEST_PASS;
+	return status;
 }
 
 static void cleanup(void *ctx)
-- 
2.55.0

