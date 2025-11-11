Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85B328B41;
	Tue, 11 Nov 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888708; cv=none; b=rulP6xpCs1tTrW4cKtO6PIR4XR9a308ZSPHgXhSzEuLOOE4f+fFlt9bT4+7EDakazSp4fTbhIwCgkyU7yPC6n8RHo7BwekLrQqRNt/8FNHxz6GMhrVRy20hHdVeQz6VhDEGjXKjVBJ8k8C8KBuOMYHhqXkAs3oREBiTCZY6gtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888708; c=relaxed/simple;
	bh=oMoWfYcQzwI3soMqVN26ZmFx7y2wRv+PAkucpMr9zMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJkaap34tDH3oMVwisi2xTCO1y9/XWX1vWycPbfteaqoVHlR8mAllob+yH++UNwV6uzxV11nM81YNZLAIFpN4hCW6XAEEvBwGbQ2QMOPxNbQBokqfbzsTyPaOe2L0LHQp6mfC6ZxSKH0QNWSBnVnwXRMp4JN+sA4SY/co5CmHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHb95tSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHb95tSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24BC19423;
	Tue, 11 Nov 2025 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888708;
	bh=oMoWfYcQzwI3soMqVN26ZmFx7y2wRv+PAkucpMr9zMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHb95tScpE7+YgKFau3/K3BKyUSfsT8XagQbgql8j+t2svnn4cAl//F/YbAHrzpht
	 EjwIrt+ck+VkVszcbQrIvmFJ8SEKUbHh9673x68Bf3CluzRQK8oVcDrDVlInR8muRj
	 wP4aR+pxvsSe+i0UavsAoegDHKGy7aC+e8qzaN3po6zuNoWTNzKZ2YnjZpQXQtZ6sM
	 M/RSBP+6QuXDorOItT0saisLtR/Bk5Gad8sMHap/ul7gleNHYaftbdcdFyPDbOy7n2
	 nanCa2lb/+1AoDPOCst3N+vkoK7R9nH3QY50/E0FGzWXtH/1zrjujGQZhaRvJLpzWf
	 BGglaBZe3oEBg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 10/13] sched_ext: Add scx_cpu0 example scheduler
Date: Tue, 11 Nov 2025 09:18:13 -1000
Message-ID: <20251111191816.862797-11-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add scx_cpu0, a simple scheduler that queues all tasks to a single DSQ and
only dispatches them from CPU0 in FIFO order. This is useful for testing bypass
behavior when many tasks are concentrated on a single CPU. If the load balancer
doesn't work, bypass mode can trigger task hangs or RCU stalls as the queue is
long and there's only one CPU working on it.

v2: Check whether task is on CPU0 at enqueue using scx_bpf_task_cpu() instead
    of nr_cpus_allowed (Andrea Righi).

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/Makefile       |   2 +-
 tools/sched_ext/scx_cpu0.bpf.c |  88 +++++++++++++++++++++++++++
 tools/sched_ext/scx_cpu0.c     | 106 +++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_cpu0.bpf.c
 create mode 100644 tools/sched_ext/scx_cpu0.c

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index d68780e2e03d..069b0bc38e55 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -187,7 +187,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_qmap scx_central scx_flatcg
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_cpu0.bpf.c b/tools/sched_ext/scx_cpu0.bpf.c
new file mode 100644
index 000000000000..6326ce598c8e
--- /dev/null
+++ b/tools/sched_ext/scx_cpu0.bpf.c
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A CPU0 scheduler.
+ *
+ * This scheduler queues all tasks to a shared DSQ and only dispatches them on
+ * CPU0 in FIFO order. This is useful for testing bypass behavior when many
+ * tasks are concentrated on a single CPU. If the load balancer doesn't work,
+ * bypass mode can trigger task hangs or RCU stalls as the queue is long and
+ * there's only one CPU working on it.
+ *
+ * - Statistics tracking how many tasks are queued to local and CPU0 DSQs.
+ * - Termination notification for userspace.
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
+
+UEI_DEFINE(uei);
+
+/*
+ * We create a custom DSQ with ID 0 that we dispatch to and consume from on
+ * CPU0.
+ */
+#define DSQ_CPU0 0
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, 2);			/* [local, cpu0] */
+} stats SEC(".maps");
+
+static void stat_inc(u32 idx)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+s32 BPF_STRUCT_OPS(cpu0_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	/*
+	 * select_cpu() always picks CPU0. If @p is not on CPU0, it can't run on
+	 * CPU 0. Queue on whichever CPU it's currently only.
+	 */
+	if (scx_bpf_task_cpu(p) != 0) {
+		stat_inc(0);	/* count local queueing */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		return;
+	}
+
+	stat_inc(1);	/* count cpu0 queueing */
+	scx_bpf_dsq_insert(p, DSQ_CPU0, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(cpu0_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (cpu == 0)
+		scx_bpf_dsq_move_to_local(DSQ_CPU0);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(cpu0_init)
+{
+	return scx_bpf_create_dsq(DSQ_CPU0, -1);
+}
+
+void BPF_STRUCT_OPS(cpu0_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(cpu0_ops,
+	       .select_cpu		= (void *)cpu0_select_cpu,
+	       .enqueue			= (void *)cpu0_enqueue,
+	       .dispatch		= (void *)cpu0_dispatch,
+	       .init			= (void *)cpu0_init,
+	       .exit			= (void *)cpu0_exit,
+	       .name			= "cpu0");
diff --git a/tools/sched_ext/scx_cpu0.c b/tools/sched_ext/scx_cpu0.c
new file mode 100644
index 000000000000..1e4fa4ab8da9
--- /dev/null
+++ b/tools/sched_ext/scx_cpu0.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_cpu0.bpf.skel.h"
+
+const char help_fmt[] =
+"A cpu0 sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-v]\n"
+"\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int sig)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct scx_cpu0 *skel, __u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	assert(nr_cpus > 0);
+	__u64 cnts[2][nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * 2);
+
+	for (idx = 0; idx < 2; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_cpu0 *skel;
+	struct bpf_link *link;
+	__u32 opt;
+	__u64 ecode;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+restart:
+	skel = SCX_OPS_OPEN(cpu0_ops, scx_cpu0);
+
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "vh")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_OPS_LOAD(skel, cpu0_ops, scx_cpu0, uei);
+	link = SCX_OPS_ATTACH(skel, cpu0_ops, scx_cpu0);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		__u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("local=%llu cpu0=%llu\n", stats[0], stats[1]);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_cpu0__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
-- 
2.51.2

