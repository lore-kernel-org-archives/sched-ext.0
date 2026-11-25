Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620866;
	b=icmVUjGP7QKFI0AMfbPG+SrfZxI9366SR9+ZkdJxcfH5KqUoMhPvkXXdeTfY9bRCsgF0
	 5lhHvs2mRQIflLkxNoU5VgO101r4MY5YBbdwFU/zqaajb2p+NBGw6OiV4K0NI6QxmsWnT
	 LhZBa47bhakCgC3T4MnxcFK6rG9CAWPxtOgPdza55IXZ7Ghm9qdaoGSnRyLPgvwpogXsG
	 DMJN1J6GF3AkyHYCNcfkh9VBEOzhguw3Z7JgsZm4ZhcKm8Jt0lHrAMr+lD6jKArblhztF
	 B9XNxNPFN0Ix90tQYnha4I38020+dlzH/i6+inOcN+84rzK4utcjG9qxt8KeQ3uF9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8l9s48cBd/rt+ucRPW5523+jZ1OWhLcxRKhL/h7UiBA=;
	b=Ho0J6eTkNsnxbaqhumosuVAa6QiK5FGI7E8la82zKkwG2TXRt65urbL6Rflsn7pk0ake
	 zb80rSD2Yq4CK2Qt0RFjUVntc4tv7ZpKW3VuNRGaBVjhBNd1L/Ri4cStkL+g8jkVtpzdi
	 59OzFiAMtVzxsJxUW2i9hnnMmE50asP74S6C4XJvmm6drHODV2ubXD/y16zhqkiU8hI/4
	 9vc6xgsxRXso5j3TXnB8+QtW1nCEzaLY5DODDYNvyWHRQPTCZOZXXvnjZFGNLeSExQn8Q
	 v+j2wINw+iuOsnkgAj1rT/aLqy5f9WQFYHFHM4rjoKyn08li/a/KyJuDFzqPLMNCEhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MLu4TvuN;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A2606A335
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 15:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0A2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MLu4TvuN
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49337a224a8so3627762f8f.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 07:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795620865; x=1796225665; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l9s48cBd/rt+ucRPW5523+jZ1OWhLcxRKhL/h7UiBA=;
        b=MLu4TvuN7C9uuHnE3h0sL7xGqm0eMNT/1FNMf1+X/+tdREQjOmweYtkQ7W4J06/bnT
         A0cKuuljQUU7/dw6LqmXYeJjvmHIyXNDas/uEfLO4vtJqaoOSckCroYP35LrPjdOJRzi
         XVXGWpT9Wf+Lsj2q2bvLTGv7/dp4Ahh4nz+Bdf7z99aXR5B4EQKH6X9bNNwGDHCTGbJ+
         LTMxi2v9kQzPdJrjAYbd2FxGcT4khTnbTX179PH5pZsjyuseykHcQ/Q+Jc3NI/FOpLAT
         Dd8eXbdx75j4uMKoJ1B5XthKPcQhsEXkKUAkjr6CGSIOm+ZUwMT528WqW3qx+xqGo/ay
         M85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620865; x=1796225665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8l9s48cBd/rt+ucRPW5523+jZ1OWhLcxRKhL/h7UiBA=;
        b=ToRzfbIbL8RWgwJ9LtLtyl1piTcgD9UJYFyE1WrRWuvq26nhSPJ/LI9Qt/koU+ME3J
         +9iusAVipVaDQ/fDDgZ16LSioPYVsvHK43uIejmsRSt+lEZI1byfXiIiiAjf7kuXMqs/
         HX+h9DYgiZAfLBBcy856YJ+2xIiel6Y0HhVCgt8FzZqe01ytUUE0OSnQQUnWdJAoAfzz
         dodbjLkiah2tUd0ZCDIsANaCKoYN2rdqk9d26cX7brqURbma8aM3JwrvkukAx1Q9pNX7
         msqzIF8H7YlShSk2q1pM+7qDg9Kh/lyWyztesxwusMvQm4AVEzEsS+QiraMdJNWk1xq4
         V3vw==
X-Forwarded-Encrypted: i=1; AL+hErEVCZCWRJBBpauyjt41x3QkEiLuc5Z30/L6SnpLf6+AlIGDHJhgGGV8BvC/18faAIxHVjVDEerUwiE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/NVRH5VnDJZVDAzB482Llq2uqmzTXPdaTrChOVJ68cVFKoxs4d
	DRHbTgD9Ximt9+LzU1V4ShNUCYwWa8SILhWmaR3d6Ouj4GYGyyW31w2KKS+EFql+BI1ZMcAmO6b
	QfVD+jJGX265LGQ==
X-Received: from wroe1.prod.google.com ([2002:adf:ef01:0:b0:48e:3465:b63e])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:288e:b0:49e:4ba2:a775 with SMTP id ffacd0b85a97d-4abb86e50eamr35228561f8f.56.1795620864367;
 Wed, 25 Nov 2026 07:34:24 -0800 (PST)
Date: Wed, 25 Nov 2026 15:34:21 +0000
In-Reply-To: <20261125153353.1364467-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125153353.1364467-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125153353.1364467-3-jpiecuch@google.com>
Subject: [RFC PATCH 2/2] selftests/sched_ext: Test that ops.sub_caps_updated()
 runs unlocked
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add sub_caps_ctx. A cid-form root grants and revokes caps to a child
sub-scheduler from ops.enqueue() (SCX_CAP_PERF) and ops.select_cid()
(SCX_CAP_PREEMPT). The child calls scx_bpf_cidperf_set() on every cid from
ops.sub_caps_updated(), which aborts the child if the callback inherits
the parent's rq lock. The test is skipped on a single cpu, where the only
cid is the parent's rq.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/sub_caps_ctx.bpf.c    | 136 +++++++++++++++
 .../selftests/sched_ext/sub_caps_ctx.c        | 165 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_caps_ctx.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9a776a8a36ff..caedba9dcde9 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -196,6 +196,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	sub_caps_ctx			\
 	rt_stall			\
 	test_example			\
 	total_bw			\
diff --git a/tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c b/tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
new file mode 100644
index 000000000000..e6613fc23d15
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A cid-form root scheduler which grants and revokes caps to a child
+ * sub-scheduler from its rq-locked ops.enqueue() and from ops.select_cid(), and
+ * a child which calls scx_bpf_cidperf_set() on every cid from
+ * ops.sub_caps_updated().
+ *
+ * ops.sub_caps_updated() must not inherit the parent's rq lock context. If it
+ * did, scx_bpf_cidperf_set() on any cid other than the parent's locked rq's
+ * would fail with "Invalid target CPU" and abort the child.
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_CIDS	1024
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1 << 8);
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+struct sub_caps_ctx_cmask {
+	union {
+		struct scx_cmask mask;
+		u64 words[CMASK_NR_WORDS(MAX_CIDS) + 2];
+	};
+};
+
+struct sub_caps_ctx_cmask __arena_global all_cids;
+
+u64 child_cgid;
+u64 nr_enqueued, nr_selected, nr_grants, nr_revokes, nr_caps_updated, nr_perf_set;
+
+UEI_DEFINE(uei);
+
+/*
+ * Toggle @cap on all cids of the child every 8th call. ops.select_cid() and
+ * ops.enqueue() toggle different caps so that neither turns the other's grant
+ * or revoke into a no-op.
+ */
+static void toggle_child_cap(u64 cap, u64 seq)
+{
+	u64 cgid = child_cgid;
+
+	if (!cgid || (seq & 7) || nr_grants + nr_revokes >= 4096)
+		return;
+
+	if ((seq >> 3) & 1) {
+		scx_bpf_sub_revoke(cgid, cap, &all_cids.mask);
+		__sync_fetch_and_add(&nr_revokes, 1);
+	} else {
+		scx_bpf_sub_grant(cgid, cap, &all_cids.mask, NULL);
+		__sync_fetch_and_add(&nr_grants, 1);
+	}
+}
+
+/* grant / revoke from the ops.select_cid() context */
+s32 BPF_STRUCT_OPS(sub_caps_ctx_select_cid, struct task_struct *p, s32 prev_cid, u64 wake_flags)
+{
+	toggle_child_cap(SCX_CAP_PREEMPT, __sync_fetch_and_add(&nr_selected, 1));
+	return prev_cid;
+}
+
+/* grant / revoke while holding the enqueue rq lock */
+void BPF_STRUCT_OPS(sub_caps_ctx_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	toggle_child_cap(SCX_CAP_PERF, __sync_fetch_and_add(&nr_enqueued, 1));
+}
+
+void BPF_STRUCT_OPS(sub_caps_ctx_sub_caps_updated, const struct scx_cmask *cmask, u64 caps)
+{
+	u32 nr_cids = scx_bpf_nr_cids();
+	s32 cid;
+
+	/* @cmask is an arena pointer, associate the arena */
+	asm volatile("" :: "r"(&arena));
+
+	__sync_fetch_and_add(&nr_caps_updated, 1);
+
+	/* any cid must be accepted when no rq lock is held */
+	bpf_for(cid, 0, nr_cids) {
+		if (!scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE))
+			__sync_fetch_and_add(&nr_perf_set, 1);
+	}
+}
+
+s32 BPF_STRUCT_OPS(sub_caps_ctx_sub_attach, struct scx_sub_attach_args *args)
+{
+	child_cgid = args->ops->sub_cgroup_id;
+	return 0;
+}
+
+void BPF_STRUCT_OPS(sub_caps_ctx_sub_detach, struct scx_sub_detach_args *args)
+{
+	child_cgid = 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(sub_caps_ctx_init)
+{
+	u32 nr_cids = scx_bpf_nr_cids();
+	s32 cid;
+
+	if (nr_cids > MAX_CIDS) {
+		scx_bpf_error("nr_cids=%u exceeds MAX_CIDS=%d", nr_cids, MAX_CIDS);
+		return -EINVAL;
+	}
+
+	cmask_init(&all_cids.mask, 0, nr_cids);
+	bpf_for(cid, 0, nr_cids)
+		cmask_set(cid, &all_cids.mask);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(sub_caps_ctx_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_CID_DEFINE(sub_caps_ctx_ops,
+		   .select_cid		= (void *)sub_caps_ctx_select_cid,
+		   .enqueue		= (void *)sub_caps_ctx_enqueue,
+		   .sub_caps_updated	= (void *)sub_caps_ctx_sub_caps_updated,
+		   .sub_attach		= (void *)sub_caps_ctx_sub_attach,
+		   .sub_detach		= (void *)sub_caps_ctx_sub_detach,
+		   .init		= (void *)sub_caps_ctx_init,
+		   .exit		= (void *)sub_caps_ctx_exit,
+		   .name		= "sub_caps_ctx");
diff --git a/tools/testing/selftests/sched_ext/sub_caps_ctx.c b/tools/testing/selftests/sched_ext/sub_caps_ctx.c
new file mode 100644
index 000000000000..5881a6312cb6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_caps_ctx.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Grant and revoke caps to a sub-scheduler from the parent's rq-locked
+ * ops.enqueue() and verify that the child's ops.sub_caps_updated() runs in an
+ * unlocked context.
+ */
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+
+/* opaque to userspace, must match the size in sub_caps_ctx.bpf.c */
+#define MAX_CIDS	1024
+struct sub_caps_ctx_cmask {
+	__u64 words[(MAX_CIDS + 63) / 64 + 1 + 2];
+};
+
+#include "sub_caps_ctx.bpf.skel.h"
+#include "scx_test.h"
+
+#define CGRP_ROOT	"/sys/fs/cgroup"
+#define CGRP_PATH	CGRP_ROOT "/sub_caps_ctx"
+#define NR_WORKERS	8
+
+struct ctx {
+	struct sub_caps_ctx *parent;
+	struct sub_caps_ctx *child;
+	struct bpf_link *parent_link;
+	struct bpf_link *child_link;
+};
+
+static struct ctx test_ctx;
+
+static void write_file(const char *path, const char *buf)
+{
+	FILE *f = fopen(path, "w");
+
+	if (!f)
+		return;
+	fputs(buf, f);
+	fclose(f);
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct sub_caps_ctx *skel;
+	struct stat st;
+
+	if (!__COMPAT_struct_has_field("sched_ext_ops_cid", "sub_caps_updated"))
+		return SCX_TEST_SKIP;
+
+	/* a single cid is always the parent's rq, which scx_bpf_cidperf_set() accepts */
+	if (sysconf(_SC_NPROCESSORS_ONLN) < 2)
+		return SCX_TEST_SKIP;
+
+	write_file(CGRP_ROOT "/cgroup.subtree_control", "+cpu");
+	if (mkdir(CGRP_PATH, 0755) && errno != EEXIST) {
+		fprintf(stderr, "Failed to create %s (%s)\n", CGRP_PATH, strerror(errno));
+		return SCX_TEST_SKIP;
+	}
+	SCX_FAIL_IF(stat(CGRP_PATH, &st), "Failed to stat %s", CGRP_PATH);
+
+	skel = SCX_OPS_CID_OPEN(sub_caps_ctx_ops, sub_caps_ctx);
+	SCX_OPS_LOAD(skel, sub_caps_ctx_ops, sub_caps_ctx, uei);
+	test_ctx.parent = skel;
+
+	skel = SCX_OPS_CID_OPEN(sub_caps_ctx_ops, sub_caps_ctx);
+	skel->struct_ops.sub_caps_ctx_ops->sub_cgroup_id = st.st_ino;
+	SCX_OPS_LOAD(skel, sub_caps_ctx_ops, sub_caps_ctx, uei);
+	test_ctx.child = skel;
+
+	*ctx = &test_ctx;
+	return SCX_TEST_PASS;
+}
+
+/* sleep and wake repeatedly to drive the parent's ops.enqueue() */
+static void worker(void)
+{
+	struct timespec ts = { .tv_nsec = 100 * 1000 };
+	int i;
+
+	for (i = 0; i < 2000; i++)
+		nanosleep(&ts, NULL);
+	exit(0);
+}
+
+static enum scx_test_status run(void *arg)
+{
+	struct ctx *ctx = arg;
+	pid_t pids[NR_WORKERS];
+	int i, status;
+
+	ctx->parent_link = bpf_map__attach_struct_ops(ctx->parent->maps.sub_caps_ctx_ops);
+	SCX_FAIL_IF(!ctx->parent_link, "Failed to attach parent");
+
+	ctx->child_link = bpf_map__attach_struct_ops(ctx->child->maps.sub_caps_ctx_ops);
+	SCX_FAIL_IF(!ctx->child_link, "Failed to attach child");
+	SCX_GT(ctx->parent->bss->child_cgid, 0);
+
+	for (i = 0; i < NR_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork");
+		if (!pids[i])
+			worker();
+	}
+	for (i = 0; i < NR_WORKERS; i++)
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i] || status,
+			    "Worker %d failed", i);
+
+	/* let deferred notifications drain */
+	usleep(100 * 1000);
+
+	printf("enqueued=%lu selected=%lu grants=%lu revokes=%lu caps_updated=%lu perf_set=%lu\n",
+	       (unsigned long)ctx->parent->bss->nr_enqueued,
+	       (unsigned long)ctx->parent->bss->nr_selected,
+	       (unsigned long)ctx->parent->bss->nr_grants,
+	       (unsigned long)ctx->parent->bss->nr_revokes,
+	       (unsigned long)ctx->child->bss->nr_caps_updated,
+	       (unsigned long)ctx->child->bss->nr_perf_set);
+
+	SCX_ASSERT_ALIVE(ctx->child, uei);
+	SCX_ASSERT_ALIVE(ctx->parent, uei);
+	SCX_GT(ctx->parent->bss->nr_grants, 0);
+	SCX_GT(ctx->parent->bss->nr_revokes, 0);
+	SCX_GT(ctx->child->bss->nr_caps_updated, 0);
+
+	bpf_link__destroy(ctx->child_link);
+	ctx->child_link = NULL;
+	bpf_link__destroy(ctx->parent_link);
+	ctx->parent_link = NULL;
+
+	SCX_EQ(ctx->child->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+	SCX_EQ(ctx->parent->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *arg)
+{
+	struct ctx *ctx = arg;
+
+	if (ctx->child_link)
+		bpf_link__destroy(ctx->child_link);
+	if (ctx->parent_link)
+		bpf_link__destroy(ctx->parent_link);
+	sub_caps_ctx__destroy(ctx->child);
+	sub_caps_ctx__destroy(ctx->parent);
+	rmdir(CGRP_PATH);
+}
+
+struct scx_test sub_caps_ctx = {
+	.name = "sub_caps_ctx",
+	.description = "Check ops.sub_caps_updated() runs unlocked after a locked grant",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&sub_caps_ctx)
-- 
2.56.1.839.g22a8290db9-goog

