Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015076;
	b=qWgQup5TgYJpBFpItih7722i+8DcimcJ1po6OPI7529k6LDdIS945QPiyF1xOhPGr6a/
	 9EdOUWzUZxnZPBK9xlZw6+WA2l7yTCuxE2XczetgjPD7OuslE03M/vE4JRmHNjCN9xZ/L
	 ByDn3dPjDEPKwaJHPs1zh67w7b8sJ491VGgYq+0wTaWk6D5tii6zN4Sp4RJNQ8S3R5Kab
	 AUN17jzglwQn92lvtlmLBdL7pp0gATWh+lbXwmC/giwNO5bDA6kXnDcMqv0JUEgDVquPI
	 TpjYekLkL8H/ix9NutfsaLgLD4f7XZgoD0zemYlq3lKMrEzYW5RG6T3v2dURbOEp6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=V5xpxZ8TVJXGI9pDk204XhuROLA8nuQ5i2IgbJUnDrU=;
	b=ZgxWjdKgb3h3I70typCnpEwNVs8961d0WHI4R7mu6DSHDYqvJl/jPHeTHUAoZtEWToME
	 Ojr6UqCw+TtFEvYONfPmGAYuMAQSxlICZpasfEhprwmjrXSgmeIBgvn6jLcSDVrb/CxOQ
	 hrWRSzw7wuIhsG9ykodwK36l6W/iIU4kuAl2EYD42Lug8771xKe0LiWgr9gyQUbZ8eM6b
	 q5nkl2TojSD4b8E22/ZakysYmKyqiRmwlyf70jgN7KJ18YYijKy50Tn5HZY5h3e7DVumC
	 H56CI2KkcES69nnYyatZZU8Xzc/0eM+n1594Pib4gnLlmVVMKqhdFBXOXRV1oeRDLEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hcrfB35G;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8B606A32A
	for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 11:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E8B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hcrfB35G
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so26507695e9.3
        for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015074; x=1793619874; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5xpxZ8TVJXGI9pDk204XhuROLA8nuQ5i2IgbJUnDrU=;
        b=hcrfB35Gga1YqD9ySQW88f14GiBQLpUpDFynBQrZfqJxTTgMMM9wL0E27bIvAjRxc4
         +sQ2GGrMsluwdYR/WcJaq7JlMk4yais+GuAqevazhRk4rW4kJqdNw0YAEy6SYEjEirHC
         QmC/kjtHCHzD9pj17n3GHceoUEztgRpvdE/nsHn9srqbm7SgMBVF/3S3dfJGDxA8jQwY
         HBTQ9QFZDsOy1snt5nK7C9WYdC/eH6QfMkupEtFx/9vwcm704MqYZ5UeYdW8c8DiU8fF
         sLV0TFVkFIWpkFX67lHlLoWmVry9WMFx/TyGnT8zcz9KO5QABun535bLw90PnTI+9IZ9
         AYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015074; x=1793619874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5xpxZ8TVJXGI9pDk204XhuROLA8nuQ5i2IgbJUnDrU=;
        b=jOSqm1y3lGuSaPJDv5zQUHu7tIDtJcXgWQFBr5tAW0otNhsV21Lxeb7CZcSYqEZRWT
         gR/I4wK0Cx5RjijAnbIbvB/8qw9rlm2VJsY+SsraJfdPo34Rlsutj1n/SHpPeZpvuBHl
         X2lPLtRGbI82ZkL4+1C86xe9V6jxM+N6ZhjbNylRT+IFWfuhbEMNL5Lm7n1RcrxBKv6P
         nrvdpsz2wS1ln+afw1ren+1TSFzpT8LaiirQTN7GOUYt6coO9IsaxrMl9WbbAz1mU+Gv
         HKu3/HK//QVIO8Tv1OKfp9RDUCuPi2/dzRQ0dz8WC0PNZ3Jb2mhoa+VfcSh5514aqgc7
         RacQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjeOyufFrU2Cgdszbrp6ucPBYbVU8N0349K9wJz/8pAvqeWj5UNl+VdRX7ELmGPHYHVB3KR4xzcaQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYK4mb/Ex35TwZfZMGGUotNJ5SA6b1/3QCM0RKegQOZTs1EWUfXD
	45jp18eMXbFy34gwihoBjf6YpDQfp8lUymwFeLeBRc9pApqr1btrDOyl2gbaaXmnlX9XrECbXNw
	lPVI0ToTP0L3o4Q==
X-Received: from wrbdk15.prod.google.com ([2002:a05:6000:b4f:b0:48d:f1b8:e785])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3553:b0:4a2:fd2:985e with SMTP id 5b1f17b1804b1-4a35aca7809mr132393545e9.17.1793015074342;
 Mon, 26 Oct 2026 04:44:34 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:44:24 +0000
In-Reply-To: <20261026114429.209588-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261026114429.209588-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026114429.209588-3-jpiecuch@google.com>
Subject: [PATCH v2 2/2] selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with
 queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that checks that SCX_ENQ_CPU_SELECTED on a wakeup
ops.enqueue() is set if and only if ops.select_cpu() ran for that wakeup.
The scheduler sets SCX_OPS_ALLOW_QUEUED_WAKEUP so that queued wakeups
are covered too.

ops.select_cpu() records in task storage that it ran and on which CPU.
ops.enqueue() checks that record against SCX_ENQ_CPU_SELECTED. Pairs of
tasks ping-pong over pipes to generate the wakeups. Each task is
affined to its own two CPUs, so ops.select_cpu() is still called, but
the waker and the wakee never share a CPU and the wakee's CPU has
nothing else to run, which ttwu_queue_cond() requires for queueing
within an LLC. Tasks stay on prev_cpu and are dispatched to the local
DSQ. An enqueue on a CPU other than the one that ran ops.select_cpu() is
counted as a queued wakeup. The test is skipped if there are fewer than
four CPUs or if no queued wakeups are seen.

This test was written with the help of an AI coding assistant.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/enq_cpu_selected.bpf.c          | 111 ++++++++++
 .../selftests/sched_ext/enq_cpu_selected.c    | 194 ++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_cpu_selected.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c5d3a2eaea7d..2e21e28426e2 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -175,6 +175,7 @@ auto-test-targets :=			\
 	ddsp_vtimelocal_fail		\
 	dsp_local_on			\
 	enable_cmask			\
+	enq_cpu_selected		\
 	enq_select_cpu			\
 	exit				\
 	hotplug				\
diff --git a/tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c b/tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
new file mode 100644
index 000000000000..5b5df2b0bdcd
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_cpu_selected.bpf.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that SCX_ENQ_CPU_SELECTED is set on a wakeup ops.enqueue() if and
+ * only if ops.select_cpu() was called for that wakeup. The scheduler sets
+ * SCX_OPS_ALLOW_QUEUED_WAKEUP so that the wakeups which are delivered through
+ * the ttwu wakelist (and thus enqueued on a CPU other than the one that ran
+ * ops.select_cpu()) are covered too.
+ *
+ * Tasks stay on prev_cpu and run from its local DSQ, so a wakeup crosses CPUs
+ * whenever the waker and the wakee have disjoint affinities, which the
+ * userspace part of the test arranges.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+struct task_ctx {
+	bool	select_cpu_called;
+	s32	select_cpu_on;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+/*
+ * nr_selected: wakeup enqueues preceded by ops.select_cpu()
+ * nr_queued:   of those, enqueues on a CPU other than the one which ran
+ *		ops.select_cpu(), i.e. delivered through the wakelist
+ * nr_missing:  ops.select_cpu() was called, SCX_ENQ_CPU_SELECTED is clear
+ * nr_spurious: ops.select_cpu() wasn't called, SCX_ENQ_CPU_SELECTED is set
+ */
+u64 nr_selected, nr_queued, nr_missing, nr_spurious;
+
+s32 BPF_STRUCT_OPS(enq_cpu_selected_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+
+	/* fork enqueues don't carry SCX_ENQ_WAKEUP, only track ttwu */
+	if (!(wake_flags & SCX_WAKE_TTWU))
+		return prev_cpu;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (tctx) {
+		tctx->select_cpu_called = true;
+		tctx->select_cpu_on = bpf_get_smp_processor_id();
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(enq_cpu_selected_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (tctx) {
+		bool called = tctx->select_cpu_called;
+		bool flagged = enq_flags & SCX_ENQ_CPU_SELECTED;
+
+		tctx->select_cpu_called = false;
+
+		if (enq_flags & SCX_ENQ_WAKEUP) {
+			if (called) {
+				__sync_fetch_and_add(&nr_selected, 1);
+				if (bpf_get_smp_processor_id() != tctx->select_cpu_on)
+					__sync_fetch_and_add(&nr_queued, 1);
+			}
+			if (called && !flagged)
+				__sync_fetch_and_add(&nr_missing, 1);
+			if (!called && flagged)
+				__sync_fetch_and_add(&nr_spurious, 1);
+		}
+	}
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+}
+
+s32 BPF_STRUCT_OPS(enq_cpu_selected_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	if (!bpf_task_storage_get(&task_ctx_stor, p, 0,
+				  BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(enq_cpu_selected_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops enq_cpu_selected_ops = {
+	.select_cpu		= (void *)enq_cpu_selected_select_cpu,
+	.enqueue		= (void *)enq_cpu_selected_enqueue,
+	.init_task		= (void *)enq_cpu_selected_init_task,
+	.exit			= (void *)enq_cpu_selected_exit,
+	.flags			= SCX_OPS_ALLOW_QUEUED_WAKEUP,
+	.name			= "enq_cpu_selected",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/enq_cpu_selected.c b/tools/testing/selftests/sched_ext/enq_cpu_selected.c
new file mode 100644
index 000000000000..674c855530ed
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_cpu_selected.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that SCX_ENQ_CPU_SELECTED reliably tells ops.enqueue() whether
+ * ops.select_cpu() was called, including for queued (wakelist) wakeups.
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "enq_cpu_selected.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_PAIRS	4
+/* ops.select_cpu() is skipped for tasks that can only run on one CPU */
+#define CPUS_PER_TASK	2
+#define WARMUP_MS	200
+#define RUN_MS		2000
+
+static int nr_pairs;
+static cpu_set_t masks[MAX_PAIRS * 2];
+
+/*
+ * Give each task its own CPUS_PER_TASK CPUs so that every wakeup crosses CPUs
+ * and the wakee's CPU has nothing else to run. ttwu_queue_cond() requires the
+ * latter for queueing a wakeup between CPUs sharing the LLC.
+ */
+static int setup_masks(void)
+{
+	int i, cpu, nr_cpus = 0;
+	cpu_set_t allowed;
+
+	if (sched_getaffinity(0, sizeof(allowed), &allowed))
+		return -errno;
+
+	for (i = 0; i < MAX_PAIRS * 2; i++)
+		CPU_ZERO(&masks[i]);
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (nr_cpus == MAX_PAIRS * 2 * CPUS_PER_TASK)
+			break;
+		if (!CPU_ISSET(cpu, &allowed))
+			continue;
+		CPU_SET(cpu, &masks[nr_cpus / CPUS_PER_TASK]);
+		nr_cpus++;
+	}
+
+	return nr_cpus / (2 * CPUS_PER_TASK);
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_cpu_selected *skel;
+
+	nr_pairs = setup_masks();
+	SCX_FAIL_IF(nr_pairs < 0, "Failed to get CPU affinity");
+	if (!nr_pairs) {
+		fprintf(stderr, "Needs at least %d CPUs, skipping\n",
+			2 * CPUS_PER_TASK);
+		return SCX_TEST_SKIP;
+	}
+
+	skel = enq_cpu_selected__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(enq_cpu_selected__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+/* Bounce a byte back and forth between two tasks to generate wakeups. */
+static void pingpong(int rfd, int wfd, bool initiator, const cpu_set_t *mask)
+{
+	char c = 0;
+
+	if (sched_setaffinity(0, sizeof(*mask), mask))
+		exit(1);
+
+	if (initiator && write(wfd, &c, 1) != 1)
+		exit(1);
+
+	while (true) {
+		if (read(rfd, &c, 1) != 1)
+			exit(1);
+		if (write(wfd, &c, 1) != 1)
+			exit(1);
+	}
+}
+
+static int spawn_pair(pid_t *pids, const cpu_set_t *pair_masks)
+{
+	int a2b[2], b2a[2];
+
+	if (pipe(a2b) || pipe(b2a))
+		return -errno;
+
+	pids[0] = fork();
+	if (pids[0] < 0)
+		return -errno;
+	if (!pids[0])
+		pingpong(b2a[0], a2b[1], true, &pair_masks[0]);
+
+	pids[1] = fork();
+	if (pids[1] < 0)
+		return -errno;
+	if (!pids[1])
+		pingpong(a2b[0], b2a[1], false, &pair_masks[1]);
+
+	close(a2b[0]);
+	close(a2b[1]);
+	close(b2a[0]);
+	close(b2a[1]);
+
+	return 0;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enq_cpu_selected *skel = ctx;
+	pid_t pids[MAX_PAIRS * 2] = {};
+	enum scx_test_status ret = SCX_TEST_PASS;
+	struct bpf_link *link;
+	int i;
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_cpu_selected_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	for (i = 0; i < nr_pairs; i++) {
+		if (spawn_pair(&pids[i * 2], &masks[i * 2])) {
+			SCX_ERR("Failed to spawn workers");
+			ret = SCX_TEST_FAIL;
+			goto out;
+		}
+	}
+
+	/* skip the wakeups racing the scheduler enable */
+	usleep(WARMUP_MS * 1000);
+	skel->bss->nr_selected = 0;
+	skel->bss->nr_queued = 0;
+	skel->bss->nr_missing = 0;
+	skel->bss->nr_spurious = 0;
+
+	usleep(RUN_MS * 1000);
+
+	fprintf(stderr, "selected=%llu queued=%llu missing=%llu spurious=%llu\n",
+		(unsigned long long)skel->bss->nr_selected,
+		(unsigned long long)skel->bss->nr_queued,
+		(unsigned long long)skel->bss->nr_missing,
+		(unsigned long long)skel->bss->nr_spurious);
+
+	if (skel->bss->nr_missing || skel->bss->nr_spurious) {
+		SCX_ERR("SCX_ENQ_CPU_SELECTED doesn't match ops.select_cpu() calls");
+		ret = SCX_TEST_FAIL;
+	} else if (!skel->bss->nr_queued) {
+		fprintf(stderr, "No queued wakeups observed, skipping\n");
+		ret = SCX_TEST_SKIP;
+	}
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly (kind=%llu)",
+			(unsigned long long)skel->data->uei.kind);
+		ret = SCX_TEST_FAIL;
+	}
+out:
+	for (i = 0; i < nr_pairs * 2; i++) {
+		if (pids[i] > 0) {
+			kill(pids[i], SIGKILL);
+			waitpid(pids[i], NULL, 0);
+		}
+	}
+	bpf_link__destroy(link);
+
+	return ret;
+}
+
+static void cleanup(void *ctx)
+{
+	struct enq_cpu_selected *skel = ctx;
+
+	enq_cpu_selected__destroy(skel);
+}
+
+struct scx_test enq_cpu_selected = {
+	.name = "enq_cpu_selected",
+	.description = "Verify SCX_ENQ_CPU_SELECTED on queued wakeups",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&enq_cpu_selected)
-- 
2.56.0.257.gf7497c7d27-goog

