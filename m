Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3E4028F7
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542511; cv=none; b=RIh2tbMmIlzr0d6fyIBLJSlMPCbU2nv4Z+Z0SM4tWU/247bTT7+PlNkZz8iOLKhUhJiEqN0xj6vNnItgFwJpwTlmqwdipGT++ugZQkqu8FZp23RBznPHS4eXex+VzhFTqA07HFoa6adhm1Y3wLvkU8AcR/VG3Tntsrk1MNxAe/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542511; c=relaxed/simple;
	bh=mq9u9qcfkd8QpAcy1yN31/sAIXLN/xlr17NLNCo9vFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlIg5wXyDMCTCYx1wCfIakIh+891PiyV28E0FVf3caR79OJwj7hbRE0JZmdY60rOsRzr3+ZWuQOVdJBV8nWtG/fcF2KT6qRyuzskVekWQd5F24QcLWsw7+mQt5zOudUSY/zrMqBkhd6iPbQqvVgP6+Skh39erB2PqrGZ/PTglLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f1331f6b19d11f19a56ed5b684f684d-20260916
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5ea7f180-63f9-4aab-aca6-9ebfd3ea28f1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b8e9fa0e7382d59fbcee472f82bb53b0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f1331f6b19d11f19a56ed5b684f684d-20260916
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2057830666; Wed, 16 Sep 2026 15:08:08 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/sched_ext: Test that ops.dequeue() can iterate the consumed DSQ
Date: Wed, 16 Sep 2026 15:07:53 +0800
Message-Id: <20260916070753.3343113-3-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916070753.3343113-1-fangqiurong@kylinos.cn>
References: <20260916070753.3343113-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

Add a scheduler whose ops.dequeue() iterates the source user DSQ with
bpf_iter_scx_dsq. The iteration takes the DSQ's raw spinlock; on a
kernel that runs ops.dequeue() while the consume path still holds that
lock, the first task consumed self-deadlocks the CPU with IRQs
disabled. The watchdog cannot recover from that state, so on an
unfixed kernel this test wedges the system instead of failing cleanly.
On a fixed kernel the scheduler runs clean and the test passes.

Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dequeue_iter.bpf.c    | 73 +++++++++++++++
 .../selftests/sched_ext/dequeue_iter.c        | 90 +++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_iter.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5f5dd9ab903a..08c2646cdd1a 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -164,6 +164,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
+	dequeue_iter			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c b/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
new file mode 100644
index 000000000000..7f23b0a8af7f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_iter.bpf.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ops.dequeue() of this scheduler iterates the user DSQ tasks are
+ * consumed from with bpf_iter_scx_dsq, which takes the DSQ lock.
+ * On a kernel that still runs ops.dequeue() with that lock held, the
+ * iteration self-deadlocks the CPU - this test wedges the system on
+ * unfixed kernels instead of failing cleanly.
+ *
+ * Copyright (c) 2026 fangqiurong <fangqiurong@kylinos.cn>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+#define TEST_DSQ_ID 1000
+
+u64 dq_count;
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_iter_init)
+{
+	return scx_bpf_create_dsq(TEST_DSQ_ID, -1);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_iter_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_iter_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	scx_bpf_dsq_insert(p, TEST_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(dequeue_iter_dispatch, s32 cpu, struct task_struct *task)
+{
+	scx_bpf_dsq_move_to_local(TEST_DSQ_ID, 0);
+}
+
+void BPF_STRUCT_OPS(dequeue_iter_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct bpf_iter_scx_dsq it;
+	struct task_struct *t;
+
+	if (!bpf_iter_scx_dsq_new(&it, TEST_DSQ_ID, 0)) {
+		while ((t = bpf_iter_scx_dsq_next(&it)))
+			;
+	}
+	bpf_iter_scx_dsq_destroy(&it);
+
+	__sync_fetch_and_add(&dq_count, 1);
+}
+
+void BPF_STRUCT_OPS(dequeue_iter_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+	scx_bpf_destroy_dsq(TEST_DSQ_ID);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_iter_ops = {
+	.init			= (void *)dequeue_iter_init,
+	.select_cpu		= (void *)dequeue_iter_select_cpu,
+	.enqueue		= (void *)dequeue_iter_enqueue,
+	.dispatch		= (void *)dequeue_iter_dispatch,
+	.dequeue		= (void *)dequeue_iter_dequeue,
+	.exit			= (void *)dequeue_iter_exit,
+	.timeout_ms		= 1000U,
+	.name			= "dequeue_iter",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue_iter.c b/tools/testing/selftests/sched_ext/dequeue_iter.c
new file mode 100644
index 000000000000..bcd12fc6c781
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_iter.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 fangqiurong <fangqiurong@kylinos.cn>
+ */
+#include <bpf/bpf.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <time.h>
+#include <unistd.h>
+#include "dequeue_iter.bpf.skel.h"
+#include "scx_test.h"
+
+#define DQ_TARGET	10
+#define DQ_DEADLINE_MS	3000
+
+static unsigned long long now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+
+	return ts.tv_sec * 1000ULL + ts.tv_nsec / 1000000;
+}
+
+static void *run_workload(void *arg)
+{
+	struct dequeue_iter *skel = arg;
+	unsigned long long end = now_ms() + DQ_DEADLINE_MS;
+
+	while (skel->bss->dq_count < DQ_TARGET && !UEI_EXITED(skel, uei) &&
+	       now_ms() < end)
+		usleep(100);
+
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue_iter *skel;
+
+	skel = dequeue_iter__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue_iter__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue_iter *skel = ctx;
+	struct bpf_link *link;
+	pthread_t tid;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_iter_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	SCX_FAIL_IF(pthread_create(&tid, NULL, run_workload, skel),
+		    "Failed to create workload thread");
+	pthread_join(tid, NULL);
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	if (skel->bss->dq_count < DQ_TARGET) {
+		SCX_ERR("ops.dequeue() fired only %llu times",
+			(unsigned long long)skel->bss->dq_count);
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue_iter *skel = ctx;
+
+	dequeue_iter__destroy(skel);
+}
+
+struct scx_test dequeue_iter = {
+	.name = "dequeue_iter",
+	.description = "Verify ops.dequeue() can iterate its source user DSQ",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&dequeue_iter)
-- 
2.43.0

