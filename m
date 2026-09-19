Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A82ED141;
	Sat, 19 Sep 2026 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777723; cv=none; b=J8skQHUEdUZCc62zcnYAPY/prqcRFMH0A1zBUz6czU1iWux91XmEmQScADSb7zpHQAVckvmjny6/x3XB8P78QjRrIMTQCHklbK/CCul/6z6NRQYiIzDJHX2zZyCO5NNcAJ3p5uYCKvmTvQ0bZSW838y+SO3Q4CKhTmZbuVozmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777723; c=relaxed/simple;
	bh=+H3cdbhKxz1J/rZHSWd3dY30FqYrKjPUcIW5SY27YwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbUJqX9p4+qDtdtpwTLn7bXsik8C9fHFhQAr/rNlDkJBmlQIHDZQdw3i5JRGOZMrQVNhZjLpw56tIi3gov6gse0EcfPkKIhNvorQNNAaNjkR/PRmVnL7anu/gbR0lvCiFlI2HgCd1FskikOZrJyixZGD7iUSedTMw9XbtlOsCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feRwfKfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feRwfKfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D28B1F000FF;
	Sat, 19 Sep 2026 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777721;
	bh=dfg0s8xs53MvcxnXE1uoQVYF8m16Kf6WCw2fJIoPmQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=feRwfKfeeesaUSGVdDOXw2mqgG62n33mjAmFw5Z1leXVd38lPvmR7MclP3NVFwxDV
	 nQK+hvAPbHzNSau0lbFvuUe+yVZT9Z8xOxG+BAQLM9FhVXfPXhj45jC5bHLRqZXWsr
	 QJbG18KagQ0hSLZ3kxmtpiR1rO1whxV/mcD/6iE8RwSA76JJeIc/v+uGhYlXGMkrsz
	 YB/1Xx8IFjUxww3JU7zEdIgYv3eIsexX94DMRCEz1LVXmxpMmWXMw7lo6m57vNiYy5
	 MF8SeYrAGXOwWMK/+VnjmVrcyLyNsyW0HshQ5JvS6LSYTEQ6LFJHLig+SKKb1Pnm1z
	 Vf75jBWFLxQ9A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] selftests/sched_ext: Check the cmask cid-form ops.enable() receives
Date: Fri, 18 Sep 2026 14:28:38 -1000
Message-ID: <20260919002838.1960071-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919002838.1960071-1-tj@kernel.org>
References: <20260919002838.1960071-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cid-form ops.enable() now hands the task's cmask to the scheduler and
set_cmask() repeats it right after. Add a cid-form selftest that checks both
against p->cpus_ptr, that they match each other, that the initial
set_cmask() lands before set_weight() and before the task first becomes
runnable, and that set_cmask() never precedes enable(), across class-switch
enables, fork-path enables and live affinity changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/enable_cmask.bpf.c    | 213 ++++++++++++++++++
 .../selftests/sched_ext/enable_cmask.c        | 138 ++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enable_cmask.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 49897727f535..4e06d0baaeec 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -169,6 +169,7 @@ auto-test-targets :=			\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
 	dsp_local_on			\
+	enable_cmask			\
 	enq_select_cpu			\
 	exit				\
 	hotplug				\
diff --git a/tools/testing/selftests/sched_ext/enable_cmask.bpf.c b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
new file mode 100644
index 000000000000..bbbf989d2c69
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A cid-form scheduler checking the cmask cid-form ops.enable() receives: the
+ * header, every cid bit against p->cpus_ptr, and that set_cmask() follows with
+ * the same mask before set_weight() and before the task first becomes runnable,
+ * and never runs before enable().
+ *
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#include <scx/common.bpf.h>
+
+#define MAX_CPUS 1024
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1 << 16);
+} arena SEC(".maps");
+
+struct task_ctx {
+	u64	enable_fp;	/* fingerprint of the mask enable() received */
+	bool	enabled;
+	bool	pending;	/* enable() ran, the initial set_cmask() hasn't */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+u64 nr_enable, nr_initial_set_cmask, nr_set_cmask, nr_set_weight;
+s32 bad_cid;
+bool bad_want, bad_got;
+
+UEI_DEFINE(uei);
+
+static struct task_ctx *lookup_task_ctx(struct task_struct *p)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx)
+		scx_bpf_error("task_ctx lookup failed for %s[%d]", p->comm, p->pid);
+	return tctx;
+}
+
+/*
+ * Verify @m's header and every cid bit against @p's cpumask and fingerprint the
+ * bits into @fp. Return 0 on success, -EINVAL on a bad header, -ENOENT on a cid
+ * without a cpu and -EIO on a bit mismatch with the details in @bad_*.
+ */
+static int check_mask(struct task_struct *p, const struct scx_cmask __arena *m, u64 *fp)
+{
+	u32 nr_cids = scx_bpf_nr_cids();
+	u64 h = 0;
+	s32 cid;
+
+	if (m->base || m->nr_cids != nr_cids)
+		return -EINVAL;
+
+	bpf_for(cid, 0, MAX_CPUS) {
+		bool want, got;
+		s32 cpu;
+
+		if (cid >= nr_cids)
+			break;
+		cpu = scx_bpf_cid_to_cpu(cid);
+		if (cpu < 0)
+			return -ENOENT;
+		want = bpf_cpumask_test_cpu(cpu, p->cpus_ptr);
+		got = cmask_test(cid, m);
+		if (want != got) {
+			bad_cid = cid;
+			bad_want = want;
+			bad_got = got;
+			return -EIO;
+		}
+		h = h * 31 + got;
+	}
+
+	*fp = h;
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(enable_cmask_init_task, struct task_struct *p,
+			     struct scx_init_task_args *args)
+{
+	if (!bpf_task_storage_get(&task_ctx_stor, p, 0, BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return -ENOMEM;
+	return 0;
+}
+
+void BPF_STRUCT_OPS(enable_cmask_enable, struct task_struct *p, struct scx_enable_args *args)
+{
+	struct scx_cmask __arena *m = (struct scx_cmask __arena *)args->cmask_arena_addr;
+	struct task_ctx *tctx;
+	int ret;
+
+	asm volatile("" :: "r"(&arena));
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	__sync_fetch_and_add(&nr_enable, 1);
+	if (tctx->enabled || tctx->pending) {
+		scx_bpf_error("enable: %s[%d] enabled twice", p->comm, p->pid);
+		return;
+	}
+
+	ret = check_mask(p, m, &tctx->enable_fp);
+	if (ret) {
+		scx_bpf_error("enable: %s[%d] cmask check failed %d cid=%d want=%d got=%d",
+			      p->comm, p->pid, ret, bad_cid, bad_want, bad_got);
+		return;
+	}
+	tctx->enabled = true;
+	tctx->pending = true;
+}
+
+void BPF_STRUCT_OPS(enable_cmask_set_cmask, struct task_struct *p,
+		    struct scx_cmask __arena *m)
+{
+	struct task_ctx *tctx;
+	u64 fp;
+	int ret;
+
+	asm volatile("" :: "r"(&arena));
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	__sync_fetch_and_add(&nr_set_cmask, 1);
+	if (!tctx->enabled) {
+		scx_bpf_error("set_cmask: %s[%d] not enabled", p->comm, p->pid);
+		return;
+	}
+
+	ret = check_mask(p, m, &fp);
+	if (ret) {
+		scx_bpf_error("set_cmask: %s[%d] cmask check failed %d cid=%d want=%d got=%d",
+			      p->comm, p->pid, ret, bad_cid, bad_want, bad_got);
+		return;
+	}
+
+	if (tctx->pending) {
+		if (fp != tctx->enable_fp) {
+			scx_bpf_error("set_cmask: %s[%d] initial mask differs from enable()",
+				      p->comm, p->pid);
+			return;
+		}
+		tctx->pending = false;
+		__sync_fetch_and_add(&nr_initial_set_cmask, 1);
+	}
+}
+
+void BPF_STRUCT_OPS(enable_cmask_set_weight, struct task_struct *p, u32 weight)
+{
+	struct task_ctx *tctx;
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	__sync_fetch_and_add(&nr_set_weight, 1);
+	if (tctx->pending)
+		scx_bpf_error("set_weight: %s[%d] before the initial set_cmask()", p->comm,
+			      p->pid);
+}
+
+void BPF_STRUCT_OPS(enable_cmask_runnable, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	if (tctx->pending)
+		scx_bpf_error("runnable: %s[%d] before the initial set_cmask()", p->comm,
+			      p->pid);
+}
+
+void BPF_STRUCT_OPS(enable_cmask_disable, struct task_struct *p)
+{
+	struct task_ctx *tctx;
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	tctx->enabled = false;
+	tctx->pending = false;
+}
+
+void BPF_STRUCT_OPS(enable_cmask_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_CID_DEFINE(enable_cmask_ops,
+		   .init_task	= (void *)enable_cmask_init_task,
+		   .enable	= (void *)enable_cmask_enable,
+		   .set_cmask	= (void *)enable_cmask_set_cmask,
+		   .set_weight	= (void *)enable_cmask_set_weight,
+		   .runnable	= (void *)enable_cmask_runnable,
+		   .disable	= (void *)enable_cmask_disable,
+		   .exit	= (void *)enable_cmask_exit,
+		   .flags	= SCX_OPS_SWITCH_PARTIAL,
+		   .name	= "enable_cmask");
diff --git a/tools/testing/selftests/sched_ext/enable_cmask.c b/tools/testing/selftests/sched_ext/enable_cmask.c
new file mode 100644
index 000000000000..556bcad4431d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enable_cmask.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "enable_cmask.bpf.skel.h"
+#include "scx_test.h"
+
+#define SCHED_EXT 7
+#define NR_CHILDREN 8
+#define MAX_CPUS 1024
+
+static int cpus[MAX_CPUS];
+static int nr_cpus;
+
+static void spin_ms(int ms)
+{
+	struct timespec start, now;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while ((now.tv_sec - start.tv_sec) * 1000 +
+		 (now.tv_nsec - start.tv_nsec) / 1000000 < ms);
+}
+
+static int pin(pid_t pid, int idx)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpus[idx % nr_cpus], &set);
+	return sched_setaffinity(pid, sizeof(set), &set);
+}
+
+/*
+ * Pin, switch to SCHED_EXT for a class-switch enable, fork a grandchild that
+ * inherits the policy for a fork-path enable, then change affinity a few times
+ * while running for set_cmask() on live tasks.
+ */
+static int child(int idx)
+{
+	struct sched_param param = {};
+	int i, status;
+	pid_t pid;
+
+	if (pin(0, idx) || sched_setscheduler(0, SCHED_EXT, &param))
+		return 1;
+
+	pid = fork();
+	if (pid < 0)
+		return 1;
+	if (!pid) {
+		spin_ms(20);
+		return 0;
+	}
+
+	for (i = 1; i <= 4; i++) {
+		if (pin(0, idx + i))
+			return 1;
+		spin_ms(5);
+	}
+
+	return waitpid(pid, &status, 0) == pid && !status ? 0 : 1;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enable_cmask *skel;
+	struct bpf_link *link;
+	pid_t pids[NR_CHILDREN];
+	cpu_set_t set;
+	int i, status, failed = 0;
+
+	if (!__COMPAT_struct_has_field("scx_enable_args", "cmask_arena_addr"))
+		return SCX_TEST_SKIP;
+
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(set), &set), "Failed to read affinity");
+	for (i = 0; i < MAX_CPUS && i < CPU_SETSIZE; i++)
+		if (CPU_ISSET(i, &set))
+			cpus[nr_cpus++] = i;
+	if (nr_cpus < 2)
+		return SCX_TEST_SKIP;
+
+	skel = enable_cmask__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(enable_cmask__load(skel), "Failed to load skel");
+
+	link = bpf_map__attach_struct_ops(skel->maps.enable_cmask_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	for (i = 0; i < NR_CHILDREN; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork");
+		if (!pids[i])
+			exit(child(i));
+	}
+
+	/* affinity changes from the outside race with the children's own */
+	for (i = 0; i < NR_CHILDREN; i++)
+		pin(pids[i], i + NR_CHILDREN);
+
+	for (i = 0; i < NR_CHILDREN; i++) {
+		if (waitpid(pids[i], &status, 0) != pids[i] || status)
+			failed++;
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_EQ(failed, 0);
+	SCX_GE(skel->bss->nr_enable, 2 * NR_CHILDREN);
+	SCX_EQ(skel->bss->nr_initial_set_cmask, skel->bss->nr_enable);
+	SCX_GT(skel->bss->nr_set_cmask, skel->bss->nr_initial_set_cmask);
+	SCX_GE(skel->bss->nr_set_weight, skel->bss->nr_enable);
+	printf("enable=%lu initial_set_cmask=%lu set_cmask=%lu set_weight=%lu\n",
+	       (unsigned long)skel->bss->nr_enable,
+	       (unsigned long)skel->bss->nr_initial_set_cmask,
+	       (unsigned long)skel->bss->nr_set_cmask,
+	       (unsigned long)skel->bss->nr_set_weight);
+
+	enable_cmask__destroy(skel);
+	return SCX_TEST_PASS;
+}
+
+struct scx_test enable_cmask = {
+	.name = "enable_cmask",
+	.description = "Check the cid-form ops.enable() cmask and the set_cmask() after it",
+	.run = run,
+};
+REGISTER_SCX_TEST(&enable_cmask)
-- 
2.55.0

