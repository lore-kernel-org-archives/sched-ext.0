Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F485280037
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774164060; cv=none; b=VpPeda7oKryBCrmwNrF+mfN85inmSnJUQ74rs9aZQFdVoEU8oaEyoptSWby0AkdyvCArt0Vx7lvVK9QCYj29r61rY1hXY7Fmgb6Q/wpYL3my7p98LaiRO4Diaq6yBOOX7Q/Ks1ahkRcz9KYisgcX8pzJM1MpiMB/v9ygz0gNNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774164060; c=relaxed/simple;
	bh=MTfYH1mJOOIZnUBsfGF3xOOE0qMfObZu0BYKeHE+n+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnUdUZW9SVwgm5iWFUuxtsg5E+mZbt34Cfk7q0H5485ekzt7oUzLNcj6rSMGBsSafPC+PfPckFGQRhoN+1WoPx+zUdLjQBW1jBBt37/yko1O8L5hRa/34bYTne/v4xAM8++lvmBWlWjbK7AHn0X3p9Y/fQkblqkXMZCrvn4paPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfibZcs3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfibZcs3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2257864a12.3
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774164057; x=1774768857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HO+ajf2ZoKGrSNQnh5E0xTLD/ma7tKOZhmOru8ILlvQ=;
        b=gfibZcs3UUiGnmEP/5mvQR904gvyTU4jNZOQAfd+rNwk8DCQIhSNJttKP8HYkpDGgo
         M5MWtnpW2wBI4o0WwKlnhGAVSUdqM/lidzkdNLaL58ZSOceqs0acR5nMxmZwhAS0i9bI
         ERCkzO927jhCpaG2pYHzUpLYw6nIsQHBvtUJcs7FyMuu5GZUJ4BC35A+gJFmVRqfa9Tc
         ob1JBZrQb8Xwj4XeerrZfVxjME/b8s1Q0IacjGIRkB9r4k2jBtrhqGLXYBgO+274tolJ
         ++E4PdiTLZ4YfQtFRuYGwCVZOXVQVhRGDq4T6PdSZBKZjm3aR96smXdhM/0NLpL/2e+S
         uTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774164057; x=1774768857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO+ajf2ZoKGrSNQnh5E0xTLD/ma7tKOZhmOru8ILlvQ=;
        b=ZOQE9HAGu9GjHFXguggoZWOeyRYi/vxbZD8xy5E/fyGNKInjr1BWCcudgQDU89Wgpk
         Zp+nVHsPZxwiIDzx/nlT88abCic7R3SEfFjxN8rgSt0yShLDPe7Uth/WjIxDPxXr8B3U
         UYIjZ3Nncb8aMGanRotNtJtqL7sr/SEEYarEo4sigoitudFcxfogC3a5A6pnaE/Wh+ru
         obTa9rDTP+3mfOp/up74ADUqxISRSk4HgC39voaLEngEtqFdmcvcAywPh2HpJ3FrBgKM
         t/jopvkPytP+ifSwqIdpwuXWcezSdrmduji9NdG7VcSGvvZ27O6rPxraYKX3xRBEOvmS
         3m1w==
X-Gm-Message-State: AOJu0YyT21qqVZBJfndNquSQXTM5aKm1KuQnp2Te89c9iqR2BvbUNr+L
	X36jbd3njpKaf7MpVzOsW2h5zX2ZoEDkV5j2vYpG50YauE6pNSaug6yKA57KtA==
X-Gm-Gg: ATEYQzylHgeNKh0ojf/SPCKrk3nGNLzCaB2P9/a/IjcAKMFxxxPddj1SJHlkxjGLojL
	v7pjGgZ5RreVsCSsM+cVoDzGOjRqUdOOdysKKueVqc2z0qLedAThMyaga7PMGNykzwYs/SJaJtw
	2vQcitwrO+KyVi+PsdGS583NC0lk1iiwrEFxQ0TEckbC0MZGhN6NiRWRawpNqeT2ckz6+GhnPlr
	r4ipChOzUkmbQdWfr94h1uwo7tFDlWcn0dn0B00Ms3g76SQeuwZ83KiFQ63+jfjHgv6l60ECsjn
	X7rhm5FzFwkO7I2X7B7MRjLI9ZLU6P2oQfnfJaqUG6dGC5F52o2i7kcNdWVXKfA2aH4uCyx13Rm
	zAWdSOAmaZr1pKt/gfYW+Dc9QOrurZHy9MyxIGjegdtq/d7M0BL8EnpSYzVGvt17YLYcIxwowzT
	lpvOstLSUortY6fP3XchEggCtdEv764A/6nRZpqHshUcZn2pIiyBVCBPGx4ukiHOgi5lpR+99jS
	1Q=
X-Received: by 2002:a05:6a20:a124:b0:398:92f7:9d24 with SMTP id adf61e73a8af0-39bce7611c9mr8030013637.0.1774164057349;
        Sun, 22 Mar 2026 00:20:57 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a817cffsm5031608a12.11.2026.03.22.00.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 00:20:57 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	Su Zhidao <soolaugust@gmail.com>
Subject: [PATCH] selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()
Date: Sun, 22 Mar 2026 15:20:51 +0800
Message-ID: <20260322072051.993347-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <soolaugust@gmail.com>

Add three selftests covering features introduced in v7.1:

- dsq_reenq: Verify scx_bpf_dsq_reenq() on user DSQs triggers
  ops.enqueue() with SCX_ENQ_REENQ and SCX_TASK_REENQ_KFUNC in
  p->scx.flags.

- enq_immed: Verify SCX_OPS_ALWAYS_ENQ_IMMED slow path where tasks
  dispatched to a busy CPU's local DSQ are re-enqueued through
  ops.enqueue() with SCX_TASK_REENQ_IMMED.

- consume_immed: Verify SCX_ENQ_IMMED via the consume path using
  scx_bpf_dsq_move_to_local___v2() with explicit SCX_ENQ_IMMED.

All three tests skip gracefully on kernels that predate the required
features by checking availability via __COMPAT_has_ksym() /
__COMPAT_read_enum() before loading.

Signed-off-by: Su Zhidao <soolaugust@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   3 +
 .../selftests/sched_ext/consume_immed.bpf.c   |  88 +++++++++++++
 .../selftests/sched_ext/consume_immed.c       | 115 +++++++++++++++++
 .../selftests/sched_ext/dsq_reenq.bpf.c       | 120 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dsq_reenq.c |  95 ++++++++++++++
 .../selftests/sched_ext/enq_immed.bpf.c       |  63 +++++++++
 tools/testing/selftests/sched_ext/enq_immed.c | 117 +++++++++++++++++
 7 files changed, 601 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/consume_immed.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/consume_immed.c
 create mode 100644 tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dsq_reenq.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_immed.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_immed.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index a3bbe2c7911b..84e4f69b8833 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -162,8 +162,11 @@ endef
 all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
 
 auto-test-targets :=			\
+	consume_immed			\
 	create_dsq			\
 	dequeue				\
+	dsq_reenq			\
+	enq_immed			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/consume_immed.bpf.c b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
new file mode 100644
index 000000000000..9c7808f5abe1
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Validate SCX_ENQ_IMMED semantics through the consume path.
+ *
+ * This is the orthogonal counterpart to enq_immed:
+ *
+ *   enq_immed:      SCX_ENQ_IMMED via scx_bpf_dsq_insert() to local DSQ
+ *                   with SCX_OPS_ALWAYS_ENQ_IMMED
+ *
+ *   consume_immed:  SCX_ENQ_IMMED via scx_bpf_dsq_move_to_local() with
+ *                   explicit SCX_ENQ_IMMED in enq_flags (requires v2 kfunc)
+ *
+ * Worker threads belonging to test_tgid are inserted into USER_DSQ.
+ * ops.dispatch() on CPU 0 consumes from USER_DSQ with SCX_ENQ_IMMED.
+ * With multiple workers competing for CPU 0, dsq->nr > 1 triggers the
+ * IMMED slow path (reenqueue with SCX_TASK_REENQ_IMMED).
+ *
+ * Requires scx_bpf_dsq_move_to_local___v2() (v7.1+) for enq_flags support.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+#define USER_DSQ	0
+
+/* Set by userspace to identify the test process group. */
+const volatile u32 test_tgid;
+
+/*
+ * SCX_TASK_REENQ_REASON_MASK and SCX_TASK_REENQ_IMMED are exported via
+ * vmlinux BTF as part of enum scx_ent_flags.
+ */
+
+u64 nr_consume_immed_reenq;
+
+void BPF_STRUCT_OPS(consume_immed_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_REENQ) {
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
+		if (reason == SCX_TASK_REENQ_IMMED)
+			__sync_fetch_and_add(&nr_consume_immed_reenq, 1);
+	}
+
+	if (p->tgid == (pid_t)test_tgid)
+		scx_bpf_dsq_insert(p, USER_DSQ, SCX_SLICE_DFL, enq_flags);
+	else
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL,
+				   enq_flags);
+}
+
+void BPF_STRUCT_OPS(consume_immed_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (cpu == 0)
+		scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED);
+	else
+		scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(consume_immed_init)
+{
+	/*
+	 * scx_bpf_dsq_move_to_local___v2() adds the enq_flags parameter.
+	 * On older kernels the consume path cannot pass SCX_ENQ_IMMED.
+	 */
+	if (!bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2)) {
+		scx_bpf_error("scx_bpf_dsq_move_to_local v2 not available");
+		return -EOPNOTSUPP;
+	}
+
+	return scx_bpf_create_dsq(USER_DSQ, -1);
+}
+
+void BPF_STRUCT_OPS(consume_immed_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(consume_immed_ops,
+	       .enqueue		= (void *)consume_immed_enqueue,
+	       .dispatch	= (void *)consume_immed_dispatch,
+	       .init		= (void *)consume_immed_init,
+	       .exit		= (void *)consume_immed_exit,
+	       .name		= "consume_immed")
diff --git a/tools/testing/selftests/sched_ext/consume_immed.c b/tools/testing/selftests/sched_ext/consume_immed.c
new file mode 100644
index 000000000000..7f9594cfa9cb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/consume_immed.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace test for SCX_ENQ_IMMED via the consume path.
+ *
+ * Validates that scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED) on
+ * a busy CPU triggers the IMMED slow path, re-enqueuing tasks through
+ * ops.enqueue() with SCX_TASK_REENQ_IMMED.
+ *
+ * Skipped on single-CPU systems where local DSQ contention cannot occur.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "consume_immed.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_WORKERS		4
+#define TEST_DURATION_SEC	3
+
+static volatile bool stop_workers;
+
+static void *worker_fn(void *arg)
+{
+	while (!stop_workers) {
+		volatile unsigned long i;
+
+		for (i = 0; i < 100000UL; i++)
+			;
+		usleep(100);
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct consume_immed *skel;
+
+	if (!__COMPAT_has_ksym("scx_bpf_dsq_move_to_local___v2")) {
+		fprintf(stderr,
+			"SKIP: scx_bpf_dsq_move_to_local v2 not available\n");
+		return SCX_TEST_SKIP;
+	}
+
+	skel = consume_immed__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+
+	skel->rodata->test_tgid = (u32)getpid();
+
+	SCX_FAIL_IF(consume_immed__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct consume_immed *skel = ctx;
+	struct bpf_link *link;
+	pthread_t workers[NUM_WORKERS];
+	long nproc;
+	int i;
+	u64 reenq;
+
+	nproc = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nproc <= 1) {
+		fprintf(stderr,
+			"SKIP: single CPU, consume IMMED slow path may not trigger\n");
+		return SCX_TEST_SKIP;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.consume_immed_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	stop_workers = false;
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(pthread_create(&workers[i], NULL, worker_fn, NULL),
+			    "Failed to create worker %d", i);
+	}
+
+	sleep(TEST_DURATION_SEC);
+
+	reenq = skel->bss->nr_consume_immed_reenq;
+
+	stop_workers = true;
+	for (i = 0; i < NUM_WORKERS; i++)
+		pthread_join(workers[i], NULL);
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_GT(reenq, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct consume_immed *skel = ctx;
+
+	consume_immed__destroy(skel);
+}
+
+struct scx_test consume_immed = {
+	.name		= "consume_immed",
+	.description	= "Verify SCX_ENQ_IMMED slow path via "
+			  "scx_bpf_dsq_move_to_local() consume path",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&consume_immed)
diff --git a/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
new file mode 100644
index 000000000000..750bb10508df
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsq_reenq.bpf.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Validate scx_bpf_dsq_reenq() semantics on user DSQs.
+ *
+ * A BPF timer periodically calls scx_bpf_dsq_reenq() on a user DSQ,
+ * causing tasks to be re-enqueued through ops.enqueue() with SCX_ENQ_REENQ
+ * set and SCX_TASK_REENQ_KFUNC recorded in p->scx.flags.
+ *
+ * The test verifies:
+ *  - scx_bpf_dsq_reenq() triggers ops.enqueue() with SCX_ENQ_REENQ
+ *  - The reenqueue reason is SCX_TASK_REENQ_KFUNC (bit 12 set)
+ *  - Tasks are correctly re-dispatched after reenqueue
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+#define USER_DSQ	0
+
+/*
+ * SCX_TASK_REENQ_REASON_MASK and SCX_TASK_REENQ_KFUNC are exported via
+ * vmlinux BTF as part of enum scx_ent_flags.
+ */
+
+/* 5ms timer interval */
+#define REENQ_TIMER_NS		(5 * 1000 * 1000ULL)
+
+/*
+ * Number of times ops.enqueue() was called with SCX_ENQ_REENQ set and
+ * SCX_TASK_REENQ_KFUNC recorded in p->scx.flags.
+ */
+u64 nr_reenq_kfunc;
+
+struct reenq_timer_val {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct reenq_timer_val);
+} reenq_timer SEC(".maps");
+
+/*
+ * Timer callback: reenqueue all tasks currently sitting on USER_DSQ back
+ * through ops.enqueue() with SCX_ENQ_REENQ | SCX_TASK_REENQ_KFUNC.
+ */
+static int reenq_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	scx_bpf_dsq_reenq(USER_DSQ, 0);
+	bpf_timer_start(timer, REENQ_TIMER_NS, 0);
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dsq_reenq_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	/*
+	 * If this is a kfunc-triggered reenqueue, verify that
+	 * SCX_TASK_REENQ_KFUNC is recorded in p->scx.flags.
+	 */
+	if (enq_flags & SCX_ENQ_REENQ) {
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
+		if (reason == SCX_TASK_REENQ_KFUNC)
+			__sync_fetch_and_add(&nr_reenq_kfunc, 1);
+	}
+
+	/*
+	 * Always dispatch to USER_DSQ so the timer can reenqueue tasks again
+	 * on the next tick.
+	 */
+	scx_bpf_dsq_insert(p, USER_DSQ, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(dsq_reenq_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(USER_DSQ, 0);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_reenq_init)
+{
+	struct reenq_timer_val *tval;
+	u32 key = 0;
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(USER_DSQ, -1);
+	if (ret)
+		return ret;
+
+	if (!__COMPAT_has_generic_reenq()) {
+		scx_bpf_error("scx_bpf_dsq_reenq() not available");
+		return -EOPNOTSUPP;
+	}
+
+	tval = bpf_map_lookup_elem(&reenq_timer, &key);
+	if (!tval)
+		return -ESRCH;
+
+	bpf_timer_init(&tval->timer, &reenq_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(&tval->timer, reenq_timerfn);
+
+	return bpf_timer_start(&tval->timer, REENQ_TIMER_NS, 0);
+}
+
+void BPF_STRUCT_OPS(dsq_reenq_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(dsq_reenq_ops,
+	       .enqueue		= (void *)dsq_reenq_enqueue,
+	       .dispatch	= (void *)dsq_reenq_dispatch,
+	       .init		= (void *)dsq_reenq_init,
+	       .exit		= (void *)dsq_reenq_exit,
+	       .timeout_ms	= 10000,
+	       .name		= "dsq_reenq")
diff --git a/tools/testing/selftests/sched_ext/dsq_reenq.c b/tools/testing/selftests/sched_ext/dsq_reenq.c
new file mode 100644
index 000000000000..b0d99f9c9a9a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsq_reenq.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace test for scx_bpf_dsq_reenq() semantics.
+ *
+ * Attaches the dsq_reenq BPF scheduler, runs workload threads that
+ * sleep and yield to keep tasks on USER_DSQ, waits for the BPF timer
+ * to fire several times, then verifies that at least one kfunc-triggered
+ * reenqueue was observed (ops.enqueue() called with SCX_ENQ_REENQ and
+ * SCX_TASK_REENQ_KFUNC in p->scx.flags).
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include <pthread.h>
+#include "dsq_reenq.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_WORKERS	4
+#define TEST_DURATION_SEC 3
+
+static volatile bool stop_workers;
+static pthread_t workers[NUM_WORKERS];
+
+static void *worker_fn(void *arg)
+{
+	while (!stop_workers) {
+		usleep(500);
+		sched_yield();
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dsq_reenq *skel;
+
+	if (!__COMPAT_has_ksym("scx_bpf_dsq_reenq")) {
+		fprintf(stderr, "SKIP: scx_bpf_dsq_reenq() not available\n");
+		return SCX_TEST_SKIP;
+	}
+
+	skel = dsq_reenq__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dsq_reenq__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dsq_reenq *skel = ctx;
+	struct bpf_link *link;
+	int i;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dsq_reenq_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	stop_workers = false;
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(pthread_create(&workers[i], NULL, worker_fn, NULL),
+			    "Failed to create worker %d", i);
+	}
+
+	sleep(TEST_DURATION_SEC);
+
+	stop_workers = true;
+	for (i = 0; i < NUM_WORKERS; i++)
+		pthread_join(workers[i], NULL);
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_GT(skel->bss->nr_reenq_kfunc, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dsq_reenq *skel = ctx;
+
+	dsq_reenq__destroy(skel);
+}
+
+struct scx_test dsq_reenq = {
+	.name		= "dsq_reenq",
+	.description	= "Verify scx_bpf_dsq_reenq() triggers enqueue with "
+			  "SCX_ENQ_REENQ and SCX_TASK_REENQ_KFUNC reason",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&dsq_reenq)
diff --git a/tools/testing/selftests/sched_ext/enq_immed.bpf.c b/tools/testing/selftests/sched_ext/enq_immed.bpf.c
new file mode 100644
index 000000000000..805dd0256218
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_immed.bpf.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Validate SCX_ENQ_IMMED fast/slow path semantics via the direct insert path.
+ *
+ * With SCX_OPS_ALWAYS_ENQ_IMMED set, the kernel automatically adds
+ * SCX_ENQ_IMMED to every local DSQ dispatch.  When the target CPU's local
+ * DSQ already has tasks queued (dsq->nr > 1), the kernel re-enqueues the
+ * task through ops.enqueue() with SCX_ENQ_REENQ and SCX_TASK_REENQ_IMMED
+ * recorded in p->scx.flags (the "slow path").
+ *
+ * Worker threads are pinned to CPU 0 via SCX_DSQ_LOCAL_ON to guarantee
+ * local DSQ contention.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/* Set by userspace to identify the test process group. */
+const volatile u32 test_tgid;
+
+/*
+ * SCX_TASK_REENQ_REASON_MASK and SCX_TASK_REENQ_IMMED are exported via
+ * vmlinux BTF as part of enum scx_ent_flags.
+ */
+
+u64 nr_immed_reenq;
+
+void BPF_STRUCT_OPS(enq_immed_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_REENQ) {
+		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
+
+		if (reason == SCX_TASK_REENQ_IMMED)
+			__sync_fetch_and_add(&nr_immed_reenq, 1);
+	}
+
+	if (p->tgid == (pid_t)test_tgid)
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | 0, SCX_SLICE_DFL,
+				   enq_flags);
+	else
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL,
+				   enq_flags);
+}
+
+void BPF_STRUCT_OPS(enq_immed_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);
+}
+
+void BPF_STRUCT_OPS(enq_immed_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(enq_immed_ops,
+	       .enqueue		= (void *)enq_immed_enqueue,
+	       .dispatch	= (void *)enq_immed_dispatch,
+	       .exit		= (void *)enq_immed_exit,
+	       .flags		= SCX_OPS_ALWAYS_ENQ_IMMED,
+	       .name		= "enq_immed")
diff --git a/tools/testing/selftests/sched_ext/enq_immed.c b/tools/testing/selftests/sched_ext/enq_immed.c
new file mode 100644
index 000000000000..44681e41975d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_immed.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace test for SCX_ENQ_IMMED via the direct insert path.
+ *
+ * Validates that dispatching tasks to a busy CPU's local DSQ with
+ * SCX_OPS_ALWAYS_ENQ_IMMED triggers the IMMED slow path: the kernel
+ * re-enqueues the task through ops.enqueue() with SCX_TASK_REENQ_IMMED.
+ *
+ * Skipped on single-CPU systems where local DSQ contention cannot occur.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "enq_immed.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_WORKERS		4
+#define TEST_DURATION_SEC	3
+
+static volatile bool stop_workers;
+
+static void *worker_fn(void *arg)
+{
+	while (!stop_workers) {
+		volatile unsigned long i;
+
+		for (i = 0; i < 100000UL; i++)
+			;
+		usleep(100);
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_immed *skel;
+	u64 v;
+
+	if (!__COMPAT_read_enum("scx_ops_flags",
+				"SCX_OPS_ALWAYS_ENQ_IMMED", &v)) {
+		fprintf(stderr,
+			"SKIP: SCX_OPS_ALWAYS_ENQ_IMMED not available\n");
+		return SCX_TEST_SKIP;
+	}
+
+	skel = enq_immed__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+
+	skel->rodata->test_tgid = (u32)getpid();
+
+	SCX_FAIL_IF(enq_immed__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enq_immed *skel = ctx;
+	struct bpf_link *link;
+	pthread_t workers[NUM_WORKERS];
+	long nproc;
+	int i;
+	u64 reenq;
+
+	nproc = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nproc <= 1) {
+		fprintf(stderr,
+			"SKIP: single CPU, IMMED slow path may not trigger\n");
+		return SCX_TEST_SKIP;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_immed_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	stop_workers = false;
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(pthread_create(&workers[i], NULL, worker_fn, NULL),
+			    "Failed to create worker %d", i);
+	}
+
+	sleep(TEST_DURATION_SEC);
+
+	reenq = skel->bss->nr_immed_reenq;
+
+	stop_workers = true;
+	for (i = 0; i < NUM_WORKERS; i++)
+		pthread_join(workers[i], NULL);
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_GT(reenq, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct enq_immed *skel = ctx;
+
+	enq_immed__destroy(skel);
+}
+
+struct scx_test enq_immed = {
+	.name		= "enq_immed",
+	.description	= "Verify SCX_ENQ_IMMED slow path via direct insert "
+			  "with SCX_OPS_ALWAYS_ENQ_IMMED",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&enq_immed)
-- 
2.43.0

