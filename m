Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607458;
	b=heiyGwYSCGtgQMKB7k82bycN/IrqAcRkbbVCygrCPnAUwafAEGl1k9n6mCJ3zLR+16GN
	 U97H8tmYBVu6SB6jsCHkE8LIZAQEpYcX9a1IWTipAPFxkZdI2nigtz4flBkTrrfKa/uxp
	 6WkP5/pTalehY30wYxzG3SNws+suiiSNlwpYxGrNbvyxluocyjdZtL26sAgWN/uqBVtXC
	 5N+oH+7YMYZf2UEOH6W1zKmHFcNorBemYBHzGh+aKZjOTDFqf9FA7OEtSLTD+OFlLqRnz
	 rYk0QksHo7vfj7cSF15GBhsXnJI96avkMxL4BL9mD/y2kQ2Pr3FPkgENgxdgf6PTOmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TXuUl6JwjM4h8oApvNR/deLsebMYXTD4leQjsrz4ULg=;
	b=NNQh3WD52fwJDtX2llsJbBjgxwMheKyCJ87w9RdQvi4GdFtDmGBheYrDukpiOxh7Y2zw
	 eK+LyyWX2YQ54wdFLlNEkHvmhNOgdWbGLwce6ilq8KQwVIxarl55lmF5r/a5URVenR8CI
	 jA9gSGqExGexXV1D9eksec08dEZgj2Wpl6aZAUCZbFOhlLNforyj7tpzJRNZ4vNCHrVu0
	 vhwqjVfiMoXhINszqxBHfNgGoOQ+vc2Zsh0J5B2/VSyARg5XlH8ckkh0qiRzuNODR96tG
	 9owhSQ2Q9ZPBy++u0tNIxcMJdSscuktfeWl6MLO9rpo2amc/6xRi9K4c+dRnx9Hu1Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hJpQinn9;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58829606A687
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58829606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hJpQinn9
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb69d84053so40750265e9.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795607457; x=1796212257; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXuUl6JwjM4h8oApvNR/deLsebMYXTD4leQjsrz4ULg=;
        b=hJpQinn9H1DPV6i/7UOO3KbELkrym6QZgvfPRq1V/Mume0hqfKF+o4bgeWRkYZGMLP
         JH7CBj086UGZdbIU8oA1TKef4Gn25SZrfXuEH9RvoUNcJL32rmPHhjFsSOfkbMJweGv2
         L2kAllnXqk/85bT7wPrlyrt4mGcY4owJQiIkvrTGKyomanG9FvVIglWkBsf7tRuom2Bb
         qOZgptUG8n3M0H7KeBQRtIJ+4Xy+ZJs36S+b9gU8qgMqJvyMb87chrP99ydmiNsP1YAW
         sVz1yPSG3FiqxWrEwFiMzn1T5zUIkr77RLNGo7V4yIr/H1QELczUGqCqouuOddIx2Rzw
         10gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607457; x=1796212257;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXuUl6JwjM4h8oApvNR/deLsebMYXTD4leQjsrz4ULg=;
        b=WweWeAPDkb3G071YPtaG99TIG8gljIg69hsME7mcTDH7lkQdWC/3Z4GbzjNpYlC5vv
         vvp9ITYhSI09RD6pJHqtJNJF5x+6Yc37H6wY5BinBjwN4MZEk+Z1t5/cN0w/mP9GAL5d
         LWab1OqifV5RXbVz++6l9fe3U556v3581xW99CODSCc8QZgMBwQmm5VNnhRzJMKpKLHR
         YmQXNfF0mhyslsUMee2nj24tqo9FrdZ0iI2AQEg+iMH339tyjwWJuyVy1HXcwpH/miBi
         BmRqN9cK+BKsG5AXAxKADMtoyHmt+s/ek6PFnqHnMwFszKNgiMaA3CqZGafQPlVLJ2rh
         hVYA==
X-Forwarded-Encrypted: i=1; AL+hErFXyrKfEbf3kr0sc0LoCvh6EdkYiV93d2m5MLzk3zcY86e2T2VtrwvqGI7Gpsmg5MQMCxHiAEdSYMU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/KSeFB32sljyJn2QZ0pXveZnjD0aYm9r43Sf+HuXxNqKA4TsqS
	XfMRtBzjPhvBKZwqvf1z0nAIKG7bjh6duftL4OQae7L1ek/UZ83jOknuNL2C7zsS81WhXOK5s6+
	ImxkMbv82g7tRJQ==
X-Received: from wrf12-n2.prod.google.com ([2002:a05:6000:43cc:20b0:48e:d59:85ff])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8402:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4bb88806287mr278427545e9.14.1795607456575;
 Wed, 25 Nov 2026 03:50:56 -0800 (PST)
Date: Wed, 25 Nov 2026 11:50:53 +0000
In-Reply-To: <20261125114932.3198836-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125114932.3198836-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125114932.3198836-3-jpiecuch@google.com>
Subject: [RFC PATCH 2/2] selftests/sched_ext: Add immed_strand test
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test which strands an SCX_ENQ_IMMED task behind a higher class task
that takes the CPU without going through wakeup_preempt_scx().

Under core scheduling, an IMMED task gets forced idle by an RT task with a
different cookie running on the SMT sibling. The forced idle pick resets
rq->next_class to idle with the IMMED task still on the local DSQ. An RT
task sharing the sibling's cookie then wakes up on the forced idle CPU,
goes through wakeup_preempt_idle() and wins the pick.

The scheduler runs in partial mode and always inserts the test task into
the test CPU's local DSQ with SCX_ENQ_IMMED. When the task gets
reenqueued, it's parked and moved back with IMMED on the next dispatch.
The time the IMMED task spends on the local DSQ while a higher class task
runs is tracked through ops.running(), the reenqueue and the sched_switch
tracepoint. The test requires the RT task to be picked with the IMMED task
queued, the IMMED task never to wait for more than 5ms and the scheduler
not to exit.

The test doesn't cover the other ways a higher class task can take the
CPU without wakeup_preempt_scx(): sched_setscheduler() or PI boosting of a
queued task, DL replenishment, bandwidth unthrottling and the ext
dl_server running out of budget. They reschedule the CPU right away and
only strand IMMED tasks when racing with an insertion.

Enable CONFIG_SCHED_CORE in the selftest config, as the test relies on
core-sched forced idle. It is skipped without SMT siblings or core
scheduling.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 tools/testing/selftests/sched_ext/config      |   1 +
 .../selftests/sched_ext/immed_strand.bpf.c    | 174 ++++++++
 .../selftests/sched_ext/immed_strand.c        | 383 ++++++++++++++++++
 4 files changed, 559 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/immed_strand.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/immed_strand.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9a776a8a36ff..50162ba23ca2 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -178,6 +178,7 @@ auto-test-targets :=			\
 	enq_select_cpu			\
 	exit				\
 	hotplug				\
+	immed_strand			\
 	init_enable_count		\
 	kick				\
 	maximal				\
diff --git a/tools/testing/selftests/sched_ext/config b/tools/testing/selftests/sched_ext/config
index 8173f9170ffe..97f0195bbee9 100644
--- a/tools/testing/selftests/sched_ext/config
+++ b/tools/testing/selftests/sched_ext/config
@@ -3,6 +3,7 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CPUSETS=y
 CONFIG_EXT_GROUP_SCHED=y
+CONFIG_SCHED_CORE=y
 CONFIG_BPF=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO=y
diff --git a/tools/testing/selftests/sched_ext/immed_strand.bpf.c b/tools/testing/selftests/sched_ext/immed_strand.bpf.c
new file mode 100644
index 000000000000..1fab4102e7d7
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/immed_strand.bpf.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Detect %SCX_ENQ_IMMED tasks left behind on a local DSQ while a higher class
+ * task runs on the CPU.
+ *
+ * The scheduler runs in partial mode so that only the test's SCHED_EXT tasks
+ * are affected. The task identified by immed_pid is always inserted into
+ * test_cpu's local DSQ with %SCX_ENQ_IMMED. When it gets reenqueued, it's
+ * parked on PARK_DSQ and moved back with %SCX_ENQ_IMMED the next time
+ * test_cpu dispatches.
+ *
+ * The sched_switch tracepoint records when test_cpu starts running a higher
+ * class task with the IMMED task on the local DSQ (a hazard). If the IMMED task
+ * stays there for more than strand_thresh_ns while the higher class task runs,
+ * it got stranded. This is accounted when either the IMMED task leaves the
+ * local DSQ or the higher class task is switched out, whichever comes first.
+ *
+ * Copyright (c) 2026 Google LLC.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define SCHED_EXT	7
+#define MAX_RT_PRIO	100
+#define PARK_DSQ	0
+
+/* set by userspace */
+const volatile s32 test_cpu = -1;
+const volatile u64 strand_thresh_ns = 5 * 1000 * 1000;
+s32 immed_pid;		/* inserted into test_cpu's local DSQ with IMMED */
+
+/* immed_pid has been on test_cpu's local DSQ with IMMED since */
+u64 immed_since;
+/* test_cpu has been running a higher class task since */
+u64 higher_since;
+
+u64 nr_immed_inserts;
+u64 nr_immed_reenqs;
+u64 nr_hazards;
+u64 nr_strands;
+u64 max_strand_ns;
+
+UEI_DEFINE(uei);
+
+static bool is_higher(struct task_struct *p)
+{
+	return p->pid && (p->policy != SCHED_EXT || p->prio < MAX_RT_PRIO);
+}
+
+/*
+ * Account how long the IMMED task sat on the local DSQ while a higher class
+ * task ran. Called when either ends. Everything runs under test_cpu's rq lock.
+ */
+static void account_strand(u64 now)
+{
+	u64 since = immed_since, dur;
+
+	if (!since || !higher_since)
+		return;
+	if (since < higher_since)
+		since = higher_since;
+
+	dur = now - since;
+	if (dur > strand_thresh_ns)
+		__sync_fetch_and_add(&nr_strands, 1);
+	if (dur > max_strand_ns)
+		max_strand_ns = dur;
+}
+
+s32 BPF_STRUCT_OPS(immed_strand_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* no direct dispatch, every enqueue goes through ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(immed_strand_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (p->pid != immed_pid) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	if (enq_flags & SCX_ENQ_REENQ) {
+		account_strand(bpf_ktime_get_ns());
+		immed_since = 0;
+		__sync_fetch_and_add(&nr_immed_reenqs, 1);
+		scx_bpf_dsq_insert(p, PARK_DSQ, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	/* cleared by ops.running() or by the reenqueue */
+	immed_since = bpf_ktime_get_ns();
+	__sync_fetch_and_add(&nr_immed_inserts, 1);
+	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+			   enq_flags | SCX_ENQ_IMMED);
+}
+
+void BPF_STRUCT_OPS(immed_strand_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (cpu != test_cpu)
+		return;
+
+	/*
+	 * Only immed_pid is ever parked. If the IMMED insertion gets rejected,
+	 * the reenqueue is deferred and clears immed_since afterwards.
+	 */
+	if (scx_bpf_dsq_move_to_local(PARK_DSQ, SCX_ENQ_IMMED)) {
+		immed_since = bpf_ktime_get_ns();
+		__sync_fetch_and_add(&nr_immed_inserts, 1);
+	}
+}
+
+void BPF_STRUCT_OPS(immed_strand_running, struct task_struct *p)
+{
+	/*
+	 * This runs from the pick, before the sched_switch tracepoint for the
+	 * outgoing higher class task.
+	 */
+	if (p->pid == immed_pid) {
+		account_strand(bpf_ktime_get_ns());
+		immed_since = 0;
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(immed_strand_init)
+{
+	return scx_bpf_create_dsq(PARK_DSQ, -1);
+}
+
+void BPF_STRUCT_OPS(immed_strand_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(immed_strand_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned int prev_state)
+{
+	u64 now;
+
+	if (bpf_get_smp_processor_id() != test_cpu)
+		return 0;
+
+	now = bpf_ktime_get_ns();
+
+	if (higher_since) {
+		account_strand(now);
+		higher_since = 0;
+	}
+
+	if (is_higher(next)) {
+		higher_since = now;
+		if (immed_since)
+			__sync_fetch_and_add(&nr_hazards, 1);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops immed_strand_ops = {
+	.select_cpu		= (void *)immed_strand_select_cpu,
+	.enqueue		= (void *)immed_strand_enqueue,
+	.dispatch		= (void *)immed_strand_dispatch,
+	.running		= (void *)immed_strand_running,
+	.init			= (void *)immed_strand_init,
+	.exit			= (void *)immed_strand_exit,
+	.flags			= SCX_OPS_SWITCH_PARTIAL,
+	.name			= "immed_strand",
+	.timeout_ms		= 10000,
+};
diff --git a/tools/testing/selftests/sched_ext/immed_strand.c b/tools/testing/selftests/sched_ext/immed_strand.c
new file mode 100644
index 000000000000..bb9e0fb0a1aa
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/immed_strand.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that %SCX_ENQ_IMMED tasks don't get stranded on a local DSQ when a
+ * higher class task takes the CPU without going through wakeup_preempt_scx().
+ *
+ * Under core scheduling, an IMMED task gets forced idle by an RT task with a
+ * different cookie running on the SMT sibling. The forced idle pick resets
+ * rq->next_class to idle with the IMMED task still on the local DSQ. An RT task
+ * sharing the sibling's cookie then wakes up on the forced idle CPU, goes
+ * through wakeup_preempt_idle() and wins the pick. The IMMED task must get
+ * reenqueued instead of waiting for the RT task.
+ *
+ * Copyright (c) 2026 Google LLC.
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <scx/common.h>
+#include "immed_strand.bpf.skel.h"
+#include "scx_test.h"
+#include "util.h"
+
+#ifndef SCHED_EXT
+#define SCHED_EXT			7
+#endif
+#ifndef PR_SCHED_CORE
+#define PR_SCHED_CORE			62
+#endif
+#ifndef PR_SCHED_CORE_CREATE
+#define PR_SCHED_CORE_CREATE		1
+#endif
+#ifndef PR_SCHED_CORE_SHARE_FROM
+#define PR_SCHED_CORE_SHARE_FROM	3
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD
+#define PR_SCHED_CORE_SCOPE_THREAD	0
+#endif
+
+#define NR_TASKS	3
+
+struct strand_ctx {
+	struct immed_strand *skel;
+	struct bpf_link *link;
+	cpu_set_t orig_mask;
+	int test_cpu;
+	int sib_cpu;		/* test_cpu's SMT sibling */
+	pid_t pids[NR_TASKS];
+};
+
+/*
+ * What a forked task does once released. It shares @cookie_from's core cookie
+ * if set, switches to @policy and moves to @cpu in that order so that it
+ * doesn't get forced idle on @cpu before it's done setting up. @period_us == 0
+ * means spin until killed. Otherwise, sleep for @period_us - @run_us and spin
+ * for @run_us in a loop for @duration_ms.
+ */
+struct task_spec {
+	int cpu;
+	int policy;
+	int prio;
+	pid_t cookie_from;
+	__u64 period_us;
+	__u64 run_us;
+	__u64 duration_ms;
+};
+
+static __u64 now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static void spin_us(__u64 us)
+{
+	__u64 end = now_ns() + us * 1000;
+
+	while (now_ns() < end)
+		;
+}
+
+static int pin_to_cpu(pid_t pid, int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(pid, sizeof(mask), &mask);
+}
+
+static bool cpu_is_online(int cpu)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d", cpu);
+	if (access(path, F_OK))
+		return false;
+
+	/* CPUs which can't be offlined don't have the file */
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	if (access(path, F_OK))
+		return true;
+
+	return file_read_long(path) > 0;
+}
+
+static bool find_siblings(int cpu, int sib[2])
+{
+	char path[128], buf[64];
+	FILE *f;
+	bool ret;
+
+	snprintf(path, sizeof(path),
+		 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", cpu);
+	f = fopen(path, "r");
+	if (!f)
+		return false;
+	ret = fgets(buf, sizeof(buf), f) &&
+	      sscanf(buf, "%d%*[,-]%d", &sib[0], &sib[1]) == 2 &&
+	      sib[0] != sib[1];
+	fclose(f);
+	return ret;
+}
+
+static int core_cookie_create(pid_t pid)
+{
+	return prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid,
+		     PR_SCHED_CORE_SCOPE_THREAD, 0);
+}
+
+static void task_body(const struct task_spec *spec)
+{
+	__u64 end;
+
+	if (!spec->period_us) {
+		while (true)
+			spin_us(1000);
+	}
+
+	end = now_ns() + spec->duration_ms * 1000000ULL;
+	while (now_ns() < end) {
+		usleep(spec->period_us - spec->run_us);
+		spin_us(spec->run_us);
+	}
+}
+
+/*
+ * Fork a task according to @spec. The child blocks until start_task() so that
+ * the caller can set things up for it first. Returns the child's pid or -1.
+ */
+static pid_t fork_task(const struct task_spec *spec, int *go_fd)
+{
+	struct sched_param param = { .sched_priority = spec->prio };
+	int fds[2];
+	pid_t pid;
+	char c;
+
+	if (pipe(fds))
+		return -1;
+
+	pid = fork();
+	if (pid < 0) {
+		close(fds[0]);
+		close(fds[1]);
+		return -1;
+	}
+
+	if (!pid) {
+		close(fds[1]);
+		if (read(fds[0], &c, 1) != 1)
+			exit(EXIT_FAILURE);
+		close(fds[0]);
+		if (spec->cookie_from &&
+		    prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM,
+			  spec->cookie_from, PR_SCHED_CORE_SCOPE_THREAD, 0))
+			exit(EXIT_FAILURE);
+		if (spec->policy != SCHED_OTHER &&
+		    sched_setscheduler(0, spec->policy, &param))
+			exit(EXIT_FAILURE);
+		if (pin_to_cpu(0, spec->cpu))
+			exit(EXIT_FAILURE);
+		task_body(spec);
+		exit(EXIT_SUCCESS);
+	}
+
+	close(fds[0]);
+	*go_fd = fds[1];
+	return pid;
+}
+
+static void start_task(int go_fd)
+{
+	char c = 1;
+
+	if (write(go_fd, &c, 1) != 1)
+		perror("write");
+	close(go_fd);
+}
+
+static bool wait_task(pid_t pid)
+{
+	int status;
+
+	if (waitpid(pid, &status, 0) != pid)
+		return false;
+	return WIFEXITED(status) && WEXITSTATUS(status) == EXIT_SUCCESS;
+}
+
+static void kill_task(pid_t *pid)
+{
+	if (*pid <= 0)
+		return;
+	kill(*pid, SIGKILL);
+	waitpid(*pid, NULL, 0);
+	*pid = -1;
+}
+
+static void cleanup(void *arg)
+{
+	struct strand_ctx *ctx = arg;
+	int i;
+
+	for (i = 0; i < NR_TASKS; i++)
+		kill_task(&ctx->pids[i]);
+	bpf_link__destroy(ctx->link);
+	immed_strand__destroy(ctx->skel);
+	sched_setaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask);
+	free(ctx);
+}
+
+static enum scx_test_status setup(void **ctxp)
+{
+	int nr_cpus = libbpf_num_possible_cpus(), cpu, sib[2], i;
+	struct strand_ctx *ctx;
+
+	/* prefer the highest pair of siblings, away from CPU 0 */
+	for (cpu = nr_cpus - 1; cpu >= 0; cpu--) {
+		if (cpu_is_online(cpu) && find_siblings(cpu, sib) &&
+		    cpu_is_online(sib[0]) && cpu_is_online(sib[1]))
+			break;
+	}
+	if (cpu < 0) {
+		fprintf(stderr, "No online SMT siblings\n");
+		return SCX_TEST_SKIP;
+	}
+
+	/* the test itself runs outside of the core */
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (cpu != sib[0] && cpu != sib[1] && cpu_is_online(cpu))
+			break;
+	}
+	if (cpu == nr_cpus) {
+		fprintf(stderr, "No online CPU outside of the SMT siblings\n");
+		return SCX_TEST_SKIP;
+	}
+
+	ctx = calloc(1, sizeof(*ctx));
+	SCX_FAIL_IF(!ctx, "Failed to allocate");
+	ctx->sib_cpu = sib[0];
+	ctx->test_cpu = sib[1];
+	for (i = 0; i < NR_TASKS; i++)
+		ctx->pids[i] = -1;
+
+	if (sched_getaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask) ||
+	    pin_to_cpu(0, cpu)) {
+		free(ctx);
+		SCX_FAIL("Failed to pin to CPU %d", cpu);
+	}
+
+	ctx->skel = SCX_OPS_OPEN(immed_strand_ops, immed_strand);
+	ctx->skel->rodata->test_cpu = ctx->test_cpu;
+	SCX_OPS_LOAD(ctx->skel, immed_strand_ops, immed_strand, uei);
+
+	*ctxp = ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *arg)
+{
+	struct strand_ctx *ctx = arg;
+	struct immed_strand__bss *bss = ctx->skel->bss;
+	struct task_spec rt_hog_spec = {
+		.cpu = ctx->sib_cpu, .policy = SCHED_FIFO, .prio = 10,
+	};
+	struct task_spec immed_spec = {
+		.cpu = ctx->test_cpu, .policy = SCHED_EXT,
+		.period_us = 10000, .run_us = 1000, .duration_ms = 10000,
+	};
+	struct task_spec rt_spec = {
+		.cpu = ctx->test_cpu, .policy = SCHED_FIFO, .prio = 10,
+		.period_us = 100000, .run_us = 100000, .duration_ms = 200,
+	};
+	__u64 deadline, since, hazards;
+	int go_fd;
+
+	bpf_map__set_autoattach(ctx->skel->maps.immed_strand_ops, false);
+	SCX_FAIL_IF(immed_strand__attach(ctx->skel), "Failed to attach tracepoint");
+	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.immed_strand_ops);
+	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
+
+	fprintf(stderr, "immed_strand: siblings %d,%d\n", ctx->sib_cpu, ctx->test_cpu);
+
+	/* an RT hog with cookie A on the sibling */
+	ctx->pids[0] = fork_task(&rt_hog_spec, &go_fd);
+	SCX_FAIL_IF(ctx->pids[0] < 0, "Failed to fork");
+	if (core_cookie_create(ctx->pids[0])) {
+		int err = errno;
+
+		close(go_fd);
+		if (err == EINVAL || err == ENODEV) {
+			fprintf(stderr, "Core scheduling not supported (%d)\n", err);
+			return SCX_TEST_SKIP;
+		}
+		SCX_FAIL("Failed to create core cookie (%d)", err);
+	}
+	start_task(go_fd);
+
+	/* an IMMED task with cookie B, forced idle on test_cpu */
+	ctx->pids[1] = fork_task(&immed_spec, &go_fd);
+	SCX_FAIL_IF(ctx->pids[1] < 0, "Failed to fork");
+	if (core_cookie_create(ctx->pids[1])) {
+		close(go_fd);
+		SCX_FAIL("Failed to create core cookie (%d)", errno);
+	}
+	bss->immed_pid = ctx->pids[1];
+	start_task(go_fd);
+
+	/* wait for the IMMED task to sit on test_cpu's local DSQ */
+	deadline = now_ns() + 2000000000ULL;
+	while (true) {
+		since = bss->immed_since;
+		if (since && now_ns() - since > 100000000ULL)
+			break;
+		SCX_FAIL_IF(now_ns() > deadline,
+			    "IMMED task didn't get forced idle on CPU %d",
+			    ctx->test_cpu);
+		usleep(10000);
+	}
+
+	/* an RT task with cookie A waking up on test_cpu */
+	hazards = bss->nr_hazards;
+	rt_spec.cookie_from = ctx->pids[0];
+	ctx->pids[2] = fork_task(&rt_spec, &go_fd);
+	SCX_FAIL_IF(ctx->pids[2] < 0, "Failed to fork");
+	start_task(go_fd);
+	SCX_FAIL_IF(!wait_task(ctx->pids[2]), "RT task failed");
+	ctx->pids[2] = -1;
+
+	fprintf(stderr,
+		"immed_strand: CPU %d: inserts=%llu reenqs=%llu hazards=%llu strands=%llu max=%lluus\n",
+		ctx->test_cpu,
+		(unsigned long long)bss->nr_immed_inserts,
+		(unsigned long long)bss->nr_immed_reenqs,
+		(unsigned long long)bss->nr_hazards,
+		(unsigned long long)bss->nr_strands,
+		(unsigned long long)bss->max_strand_ns / 1000);
+
+	/* the RT task must have been picked with the IMMED task queued */
+	SCX_GT(bss->nr_hazards, hazards);
+	SCX_EQ(bss->nr_strands, 0);
+	/* e.g. not ejected for reenqueueing the IMMED task too many times */
+	SCX_EQ(ctx->skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	return SCX_TEST_PASS;
+}
+
+struct scx_test immed_strand = {
+	.name = "immed_strand",
+	.description = "Verify that IMMED tasks aren't stranded on core-sched forced idle CPUs",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&immed_strand)
-- 
2.56.1.839.g22a8290db9-goog

