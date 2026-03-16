Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCFA38F243
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655388; cv=none; b=BDf2W3hj7X4PiGZhXyeBN4GrPZzadBdeRWDZAW3qIGhrOnJ5p7+HV8D25pDhxeeYWwlbOo5xFTfftq3T/pL5ejhfD7h1Ni3AqPZ+SWV6/rXTX7YaLKw7Iww9ez0B5fxgUZiKkSYGh/hwjqvCJOosOzO149SxoxgcEywyGCCIujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655388; c=relaxed/simple;
	bh=VIF9kYfcgVSL3ByLqv2ACH4zHelFk2PGr95HIuYjMVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAKoEtBn4SnfBxTKhkx7W0j3SyUKqcuG7p6G4q8ZHnUFaXs/EaRjN1WaEgGXozs9fuevdPa0AmtY1GFiMT4liu4zgizDYtLADNTUJcJf1P1TJuq3dz/qpc1dsQ/OdKfN93H+0Nhjwo0rIt3MzCFvOBPzB3inNFrXdaeMPSu2FNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B8B71477;
	Mon, 16 Mar 2026 03:02:58 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13C753F73B;
	Mon, 16 Mar 2026 03:03:01 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	shuah@kernel.org,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] sched_ext/selftests: Add SCX_KICK_WAIT cycle tests
Date: Mon, 16 Mar 2026 10:02:49 +0000
Message-Id: <20260316100249.1651641-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316100249.1651641-1-christian.loehle@arm.com>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add wait_kick_cycle, a test stressing an SCX_KICK_WAIT cycle
between three CPUs by calling SCX_KICK_WAIT between them to
test if sched_ext prevents a deadlock.

Note: hangs on unfixed kernels

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/wait_kick_cycle.bpf.c |  70 ++++++
 .../selftests/sched_ext/wait_kick_cycle.c     | 223 ++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/wait_kick_cycle.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/wait_kick_cycle.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 006300ac6dff..0b5b527265f7 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -188,6 +188,7 @@ auto-test-targets :=			\
 	rt_stall			\
 	test_example			\
 	total_bw			\
+	wait_kick_cycle			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/wait_kick_cycle.bpf.c b/tools/testing/selftests/sched_ext/wait_kick_cycle.bpf.c
new file mode 100644
index 000000000000..c53cda86ec75
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/wait_kick_cycle.bpf.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Christian Loehle <christian.loehle@arm.com>
+ *
+ * Stress concurrent SCX_KICK_WAIT calls to validate forward progress.
+ *
+ * Three CPUs are designated from userspace. Every enqueue from one of the
+ * three CPUs kicks the next CPU in the ring with SCX_KICK_WAIT, creating a
+ * persistent A -> B -> C -> A wait cycle pressure.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile s32 test_cpu_a;
+const volatile s32 test_cpu_b;
+const volatile s32 test_cpu_c;
+
+u64 nr_enqueues;
+u64 nr_wait_kicks;
+
+UEI_DEFINE(uei);
+
+static s32 target_cpu(s32 cpu)
+{
+	if (cpu == test_cpu_a)
+		return test_cpu_b;
+	if (cpu == test_cpu_b)
+		return test_cpu_c;
+	if (cpu == test_cpu_c)
+		return test_cpu_a;
+	return -1;
+}
+
+void BPF_STRUCT_OPS(wait_kick_cycle_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 this_cpu = bpf_get_smp_processor_id();
+	s32 tgt;
+
+	__sync_fetch_and_add(&nr_enqueues, 1);
+
+	if (p->flags & PF_KTHREAD) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
+				   enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+
+	tgt = target_cpu(this_cpu);
+	if (tgt < 0 || tgt == this_cpu)
+		return;
+
+	__sync_fetch_and_add(&nr_wait_kicks, 1);
+	scx_bpf_kick_cpu(tgt, SCX_KICK_WAIT);
+}
+
+void BPF_STRUCT_OPS(wait_kick_cycle_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops wait_kick_cycle_ops = {
+	.enqueue		= wait_kick_cycle_enqueue,
+	.exit			= wait_kick_cycle_exit,
+	.name			= "wait_kick_cycle",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/wait_kick_cycle.c b/tools/testing/selftests/sched_ext/wait_kick_cycle.c
new file mode 100644
index 000000000000..3889e7a9a0a7
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/wait_kick_cycle.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Christian Loehle <christian.loehle@arm.com>
+ */
+#define _GNU_SOURCE
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <stdint.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "scx_test.h"
+#include "wait_kick_cycle.bpf.skel.h"
+
+/*
+ * Multiple workers per test CPU. Packing several runnable threads onto each
+ * CPU causes frequent context switching and back-to-back enqueue() calls, which
+ * maximizes the chance that all three test CPUs fire enqueue() concurrently
+ * and enter the SCX_KICK_WAIT cycle simultaneously.
+ */
+#define WORKERS_PER_CPU	4
+#define NR_TEST_CPUS	3
+#define NR_WORKERS	(NR_TEST_CPUS * WORKERS_PER_CPU)
+
+struct worker_ctx {
+	pthread_t tid;
+	int cpu;
+	volatile bool stop;
+	volatile __u64 iters;
+	bool started;
+};
+
+static int pick_test_cpus(int *cpu_a, int *cpu_b, int *cpu_c)
+{
+	cpu_set_t mask;
+	int cpus[4];
+	int nr = 0;
+	int cpu;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask))
+		return -errno;
+
+	for (cpu = 0; cpu < CPU_SETSIZE && nr < ARRAY_SIZE(cpus); cpu++) {
+		if (!CPU_ISSET(cpu, &mask))
+			continue;
+		cpus[nr++] = cpu;
+	}
+
+	if (nr < 3)
+		return -EOPNOTSUPP;
+
+	/* Leave one CPU unused when possible so one CPU remains uncongested. */
+	if (nr >= 4) {
+		*cpu_a = cpus[1];
+		*cpu_b = cpus[2];
+		*cpu_c = cpus[3];
+	} else {
+		*cpu_a = cpus[0];
+		*cpu_b = cpus[1];
+		*cpu_c = cpus[2];
+	}
+	return 0;
+}
+
+static void *worker_fn(void *arg)
+{
+	struct worker_ctx *worker = arg;
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(worker->cpu, &mask);
+
+	if (sched_setaffinity(0, sizeof(mask), &mask))
+		return (void *)(uintptr_t)errno;
+
+	/*
+	 * Tight yield loop — no sleep.  Keeping the CPU continuously busy
+	 * with rapid context switches ensures enqueue() fires at the highest
+	 * possible rate on each test CPU.
+	 */
+	while (!worker->stop) {
+		sched_yield();
+		worker->iters++;
+	}
+
+	return NULL;
+}
+
+static int join_worker(struct worker_ctx *worker)
+{
+	void *ret;
+	struct timespec ts;
+	int err;
+
+	if (!worker->started)
+		return 0;
+
+	if (clock_gettime(CLOCK_REALTIME, &ts))
+		return -errno;
+
+	ts.tv_sec += 2;
+	err = pthread_timedjoin_np(worker->tid, &ret, &ts);
+	if (err == ETIMEDOUT)
+		pthread_detach(worker->tid);
+	if (err)
+		return -err;
+
+	if ((uintptr_t)ret)
+		return -(int)(uintptr_t)ret;
+
+	return 0;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct wait_kick_cycle *skel;
+
+	skel = wait_kick_cycle__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct wait_kick_cycle *skel = ctx;
+	struct worker_ctx workers[NR_WORKERS] = {};
+	struct bpf_link *link = NULL;
+	enum scx_test_status status = SCX_TEST_PASS;
+	int test_cpus[NR_TEST_CPUS] = { -1, -1, -1 };
+	int ret;
+	int i;
+
+	ret = pick_test_cpus(&test_cpus[0], &test_cpus[1], &test_cpus[2]);
+	if (ret == -EOPNOTSUPP)
+		return SCX_TEST_SKIP;
+	if (ret) {
+		SCX_ERR("Failed to pick test cpus (%d)", ret);
+		return SCX_TEST_FAIL;
+	}
+
+	skel->rodata->test_cpu_a = test_cpus[0];
+	skel->rodata->test_cpu_b = test_cpus[1];
+	skel->rodata->test_cpu_c = test_cpus[2];
+
+	if (wait_kick_cycle__load(skel)) {
+		SCX_ERR("Failed to load skel");
+		return SCX_TEST_FAIL;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.wait_kick_cycle_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	/* WORKERS_PER_CPU threads per test CPU, all in tight yield loops. */
+	for (i = 0; i < NR_WORKERS; i++)
+		workers[i].cpu = test_cpus[i / WORKERS_PER_CPU];
+
+	for (i = 0; i < NR_WORKERS; i++) {
+		ret = pthread_create(&workers[i].tid, NULL, worker_fn, &workers[i]);
+		if (ret) {
+			SCX_ERR("Failed to create worker thread %d (%d)", i, ret);
+			status = SCX_TEST_FAIL;
+			goto out;
+		}
+		workers[i].started = true;
+	}
+
+	sleep(3);
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
+			(unsigned long long)skel->data->uei.kind,
+			(long long)skel->data->uei.exit_code);
+		status = SCX_TEST_FAIL;
+	}
+
+out:
+	for (i = 0; i < NR_WORKERS; i++)
+		workers[i].stop = true;
+
+	for (i = 0; i < NR_WORKERS; i++) {
+		ret = join_worker(&workers[i]);
+		if (ret && status == SCX_TEST_PASS) {
+			SCX_ERR("Failed to join worker thread %d (%d)", i, ret);
+			status = SCX_TEST_FAIL;
+		}
+	}
+
+	if (link)
+		bpf_link__destroy(link);
+
+	return status;
+}
+
+static void cleanup(void *ctx)
+{
+	struct wait_kick_cycle *skel = ctx;
+
+	wait_kick_cycle__destroy(skel);
+}
+
+struct scx_test wait_kick_cycle = {
+	.name = "wait_kick_cycle",
+	.description = "Verify SCX_KICK_WAIT forward progress under a 3-CPU wait cycle",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&wait_kick_cycle)
-- 
2.34.1

