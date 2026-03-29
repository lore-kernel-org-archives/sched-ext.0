Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A031C3BF7;
	Sun, 29 Mar 2026 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774743539; cv=none; b=XQhtC47S0+if9B1syXnRqc2NEkCFR7Y9wySq9U/6Ci02glGRpwh5Hj6zIBfVn2MQNLFlHw8ckwLXVFiJoBXRYmUvNHSAUQ1qvyYsJIag1rOn9rWef9V78qp76JnwMK6JNR0+svp+t2HnxzyeIG6PJR4G8y4DMyOQWUbPCogUw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774743539; c=relaxed/simple;
	bh=qI3LxaF2i7zvQxM4b3Bv8MGqQM7yPPQiDUrfFLDcLwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMfrrU+Fv8WqUcN2Hc0LEx73P8BN2RfR/7z43FlS31NMFTgp/azF1MqHDlKfDZF2DRT5wKLAHWI85YGIDQ47LzO+A9pH8l78GbPftOKzh83tAOGRBt1PP9b3HISW9FaK22ytyrTEA+u2Uwz68M1eZ06wBtiGG3vzPTEu6CqKrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbtKpxAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbtKpxAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCF6C4CEF7;
	Sun, 29 Mar 2026 00:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774743539;
	bh=qI3LxaF2i7zvQxM4b3Bv8MGqQM7yPPQiDUrfFLDcLwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbtKpxACj/Wir9Wzck/1klBex4kHDCM5TaqfMpzt+tbJSyJThCncOuSbVwBzDWkCB
	 heyiK2/5xDGbym/Cf3Vx6vsGx5WshP5PZ9j7e/z4tp64vbWwhEDntwaQ4XK7i4Vt66
	 ZZopjKqyDIlZ4Qor1i1n6OrOTa2dU2ZETjm442IYAlbEE3yal1iSSvFVZg8mjQGzrd
	 ihWgZTN3bvz++ra/OP2i9ELbNAYnJ51irEfAN0cPrGCLetOMeUYRLbkao8AWAOfxP9
	 x6eHmysZCarTN9gca8aFrvA+CghHAgvi0oEr60d4CMH6jE1ZhfNiHFPyM3FIJHhMLJ
	 7hTtN/5NaHX7Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test
Date: Sat, 28 Mar 2026 14:18:56 -1000
Message-ID: <20260329001856.835643-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329001856.835643-1-tj@kernel.org>
References: <20260329001856.835643-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that creates a 3-CPU kick_wait cycle (A->B->C->A). A BPF
scheduler kicks the next CPU in the ring with SCX_KICK_WAIT on every
enqueue while userspace workers generate continuous scheduling churn via
sched_yield(). Without the preceding fix, this hangs the machine within seconds.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/cyclic_kick_wait.bpf.c          |  68 ++++++
 .../selftests/sched_ext/cyclic_kick_wait.c    | 194 ++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/cyclic_kick_wait.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cyclic_kick_wait.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 006300ac6dff..1c9ca328cca1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -188,6 +188,7 @@ auto-test-targets :=			\
 	rt_stall			\
 	test_example			\
 	total_bw			\
+	cyclic_kick_wait		\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/cyclic_kick_wait.bpf.c b/tools/testing/selftests/sched_ext/cyclic_kick_wait.bpf.c
new file mode 100644
index 000000000000..cb34d3335917
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cyclic_kick_wait.bpf.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Stress concurrent SCX_KICK_WAIT calls to reproduce wait-cycle deadlock.
+ *
+ * Three CPUs are designated from userspace. Every enqueue from one of the
+ * three CPUs kicks the next CPU in the ring with SCX_KICK_WAIT, creating a
+ * persistent A -> B -> C -> A wait cycle pressure.
+ */
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
+void BPF_STRUCT_OPS(cyclic_kick_wait_enqueue, struct task_struct *p,
+		    u64 enq_flags)
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
+void BPF_STRUCT_OPS(cyclic_kick_wait_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops cyclic_kick_wait_ops = {
+	.enqueue		= cyclic_kick_wait_enqueue,
+	.exit			= cyclic_kick_wait_exit,
+	.name			= "cyclic_kick_wait",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
new file mode 100644
index 000000000000..c2e5aa9de715
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test SCX_KICK_WAIT forward progress under cyclic wait pressure.
+ *
+ * SCX_KICK_WAIT busy-waits until the target CPU enters the scheduling path.
+ * If multiple CPUs form a wait cycle (A waits for B, B waits for C, C waits
+ * for A), all CPUs deadlock unless the implementation breaks the cycle.
+ *
+ * This test creates that scenario: three CPUs are arranged in a ring. The BPF
+ * scheduler's ops.enqueue() kicks the next CPU in the ring with SCX_KICK_WAIT
+ * on every enqueue. Userspace pins 4 worker threads per CPU that loop calling
+ * sched_yield(), generating a steady stream of enqueues and thus sustained
+ * A->B->C->A kick_wait cycle pressure. The test passes if the system remains
+ * responsive for 5 seconds without the scheduler being killed by the watchdog.
+ */
+#define _GNU_SOURCE
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
+#include "cyclic_kick_wait.bpf.skel.h"
+
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
+	struct cyclic_kick_wait *skel;
+
+	skel = cyclic_kick_wait__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct cyclic_kick_wait *skel = ctx;
+	struct worker_ctx workers[NR_WORKERS] = {};
+	struct bpf_link *link = NULL;
+	enum scx_test_status status = SCX_TEST_PASS;
+	int test_cpus[NR_TEST_CPUS];
+	int nr_cpus = 0;
+	cpu_set_t mask;
+	int ret, i;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask)) {
+		SCX_ERR("Failed to get affinity (%d)", errno);
+		return SCX_TEST_FAIL;
+	}
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, &mask))
+			test_cpus[nr_cpus++] = i;
+		if (nr_cpus == NR_TEST_CPUS)
+			break;
+	}
+
+	if (nr_cpus < NR_TEST_CPUS)
+		return SCX_TEST_SKIP;
+
+	skel->rodata->test_cpu_a = test_cpus[0];
+	skel->rodata->test_cpu_b = test_cpus[1];
+	skel->rodata->test_cpu_c = test_cpus[2];
+
+	if (cyclic_kick_wait__load(skel)) {
+		SCX_ERR("Failed to load skel");
+		return SCX_TEST_FAIL;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.cyclic_kick_wait_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
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
+	sleep(5);
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
+	struct cyclic_kick_wait *skel = ctx;
+
+	cyclic_kick_wait__destroy(skel);
+}
+
+struct scx_test cyclic_kick_wait = {
+	.name = "cyclic_kick_wait",
+	.description = "Verify SCX_KICK_WAIT forward progress under a 3-CPU wait cycle",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&cyclic_kick_wait)
-- 
2.53.0

