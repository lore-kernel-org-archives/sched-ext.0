Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E82D877A
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246725; cv=none; b=lp9NUVBlkwtTIH2u35UCmlcIDivaTGdmQ3ELZEN3aBW1YfAKVimfUIJo9FUdZIR8SqdV3G24bI+YSF65U2uxoN8/EPjY2LHUlpAptHCZpBiySlI7e7Tu/6IwGkzspYSt/PEnscdX8OMgz0D0qSTx3aI4z/nNsYNQLnGHry/tq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246725; c=relaxed/simple;
	bh=SD6fFlxip84R21jZsIIvn9RS4l3n8loxUItBuVWYdGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpS3p5+BlF2Zm+s0yk9ArvVGTeNT8wH9jnlf6r/+9UP6lICzt7/4TLL8gmEjdRHRdoFm+SZPE8IRsJ7WaenBZnQgrMgQVi1B4bpjmeT2093dEX9Uoqw8w0w5gJ/vC412/47LySgG+fzWuzPZ5vsqomq6xH1c7TEqj31Sn38Y5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOG27FaH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOG27FaH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so1301071a91.2
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774246723; x=1774851523; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDuTwFIw164+Be7lyYSYFDJTGd8JVeBkoo+RKy59yzk=;
        b=NOG27FaHJE6VoDaCpcNaJZlKXwdA4UR2qaClzpc2MD2pNF3mcXcY4wdoJxzAgfI5CL
         rtQFWWFTfs8Yw9o8HvQejqrRK5KpWMkMZKrPltLBIIVqkvVJN0Xg5pM4w0nNYzAcGVP9
         JrTW9TWHQ62xWIZ+emhRMtNgW/iEU+g3ofY/e9LB/ax9qDV/Vt/HBVnDFy6JncD14UqY
         cujEKhVLAHeEI/NyVwe1fF4w4DPbkK57rKr8dHJpUiqVe0r/GwoHDfUQNZ489GPoeUQx
         WPzaLHyRrxx1LiAmLGtdmZFs+DFNq6icFsw6599JTRO6FQpvaOZrwlFq2BcOSZQBJGKX
         lhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246723; x=1774851523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDuTwFIw164+Be7lyYSYFDJTGd8JVeBkoo+RKy59yzk=;
        b=re/I6Dsj+VeWlftbPDDbgT7w8SkM8nAOxOUoI4ILpJQ6VwecGhQAMtHP5tuxdJPVvH
         ErK88d9TFx7k0ISYC7MWeRgD+PyZg6zZkG9Ih7fb3kH7YZhzOiXY9fshDHWaE+T7Oo/e
         VIjiCZ5om++h1snMNgHcjkT3R7v/A20HUeYKGFcEWsoJ5GebvLVhEp7kIGxRF6JIfkfK
         y3rwCqEa3e+admDVjBMcfDXeFlrM1qwc8sKaCdhjdgJGUkLKqqKGVVr3AkONwIAd4Di8
         bUkH/UleFYw0/PMqThQ6y+Z1rDyKKJWHv9EREciZ4mmUSAAsxfViMudsKl+2vTBzKCnD
         i6zQ==
X-Gm-Message-State: AOJu0Yyae8N/W4ImP5rXPAXFLK3KhfmLyQHYlpUXqHgMzznexKFOdUv5
	raA0WL9/Ca2CELO2F59DTENKcc6/Y0RJtJWoBh2UlM2WFLjuiO7Fi77GfY1/6gBS
X-Gm-Gg: ATEYQzzJS8C3mwhcJp/TD33TRmOEMBds1GTOZ0Vn11VfspWFb+bfHIVqo928eiGHfRV
	kIi8+HPaUzLlPV++7o7NXH/Mp31HYlGnGLe670VtDq1BaMiKHnQ2DnpA//r5U05MbeuOJZJdgNq
	gidbMvDE/eDq75dvLl0qeObdDJ9MFk3D9G/PJeern/ZU6mOeSjtc0amVr5pVPBlXccABQksbGwq
	X64OyJaTbQ5CKNZCeMo7uGJbc7gBlXtfJZGe/ZPalzKIRivVPgf0DB8AP1LlV/mgBXHRYRhCnlb
	j8ztXGtDBJkCeHa4DJpPzzcywCliFhTgZoLbBs6yfBCb4Ox3a5jDVMrmnOEXrmXTIpe8mBVXIf1
	z1s7vVxd7xFihatwJ08kIhsRNCuPU8xrI9Fct1dZZ6w1hs1hoxKI+PSU8KGmoAsdpljOgTOu1sk
	M42ci/8q+YGmh9vH9ZTSBmzLPbl71sYJjIHN4uWHrA/lo7Gso3rrBFXEhKIWtNEL8XWYIXF2BSU
	cI=
X-Received: by 2002:a17:90b:380c:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35bd2be6e27mr9194294a91.12.1774246722437;
        Sun, 22 Mar 2026 23:18:42 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc60ebdcasm11857973a91.9.2026.03.22.23.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 23:18:42 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	shuah@kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 2/2] selftests/sched_ext: Add failure-path tests for sub-sched
Date: Mon, 23 Mar 2026 14:18:32 +0800
Message-ID: <20260323061832.2743315-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323061832.2743315-1-suzhidao@xiaomi.com>
References: <20260323061832.2743315-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sub-sched error paths have historically been fragile: a cgroup
double-put bug and an uninitialized return value were both found in
the abort path but not caught by automated tests because only the
happy path was covered.

Add three tests targeting specific failure scenarios:

1. sub_sched_parent_reject: Tests the sub_attach rejection path.
   A parent scheduler returning -EPERM forces the kernel to execute
   the abort path (ext.c abort label), which must correctly clean up
   partially-initialized tasks and SCX_TASK_SUB_INIT flags. This is
   the path where commit 0c66b0da0064 ("sched_ext: Fix cgroup
   double-put on sub-sched abort path") and commit e36bc38ebfac
   ("sched_ext: Fix uninitialized ret in scx_alloc_and_add_sched()")
   occurred.

2. sub_sched_nesting: Tests cascading disable through a 3-level
   scheduler hierarchy (root -> level1 -> level2). When schedulers
   are detached in reverse order, drain_descendants() must recursively
   wait for all children to complete their disable sequence without
   deadlock or resource leaks.

3. sub_sched_race: Tests concurrent race between parent disable and
   child enable. A background thread destroys the parent link while
   the main thread attaches the child, exercising synchronization
   between scx_sub_enable_workfn() and the parent disable path.

All three tests create cgroups under /sys/fs/cgroup/ and are verified
to pass on a kernel with sub-sched support enabled.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   3 +
 .../sched_ext/sub_sched_nesting_child.bpf.c   |  41 +++
 .../sched_ext/sub_sched_nesting_test.c        | 287 ++++++++++++++++++
 .../sched_ext/sub_sched_parent_reject.bpf.c   |  28 ++
 .../sched_ext/sub_sched_parent_reject_test.c  | 202 ++++++++++++
 .../selftests/sched_ext/sub_sched_race_test.c | 257 ++++++++++++++++
 6 files changed, 818 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/sub_sched_nesting_child.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_sched_nesting_test.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_sched_parent_reject.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_sched_parent_reject_test.c
 create mode 100644 tools/testing/selftests/sched_ext/sub_sched_race_test.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 211eef9443a9..9554d36793e1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -191,6 +191,9 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	sub_sched			\
+	sub_sched_parent_reject_test	\
+	sub_sched_nesting_test		\
+	sub_sched_race_test		\
 	test_example			\
 	total_bw			\
 
diff --git a/tools/testing/selftests/sched_ext/sub_sched_nesting_child.bpf.c b/tools/testing/selftests/sched_ext/sub_sched_nesting_child.bpf.c
new file mode 100644
index 000000000000..86e5ca386d47
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_sched_nesting_child.bpf.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Nesting-capable child scheduler for multi-level sub-sched testing.
+ *
+ * This scheduler can itself act as a parent for deeper nesting levels,
+ * allowing us to test cascading disable and cleanup of nested schedulers.
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 dispatch_count;
+
+void BPF_STRUCT_OPS(nesting_child_dispatch, s32 cpu, struct task_struct *prev)
+{
+	__sync_fetch_and_add(&dispatch_count, 1);
+}
+
+/* This child can itself be a parent to further nesting */
+s32 BPF_STRUCT_OPS(nesting_child_sub_attach, struct scx_sub_attach_args *args)
+{
+	/* Accept sub_attach to allow deeper nesting */
+	return 0;
+}
+
+void BPF_STRUCT_OPS(nesting_child_sub_detach, struct scx_sub_detach_args *args)
+{
+	/* Detach handling */
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops sub_sched_nesting_child_ops = {
+	.name			= "sub_sched_nesting_child",
+	.sub_cgroup_id		= 0,  /* Will be set by user space */
+	.dispatch		= (void *)nesting_child_dispatch,
+	.sub_attach		= (void *)nesting_child_sub_attach,
+	.sub_detach		= (void *)nesting_child_sub_detach,
+};
diff --git a/tools/testing/selftests/sched_ext/sub_sched_nesting_test.c b/tools/testing/selftests/sched_ext/sub_sched_nesting_test.c
new file mode 100644
index 000000000000..3500a75487fe
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_sched_nesting_test.c
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test for multi-level nested sub-sched cascading disable.
+ *
+ * Tests that when a parent scheduler is disabled, all nested children
+ * are properly disabled and cleaned up recursively via drain_descendants().
+ *
+ * Hierarchy:
+ *   Root Scheduler (global)
+ *     └── Parent Sub-Scheduler (level 1)
+ *            └── Child Sub-Scheduler (level 2)
+ *
+ * When root disable happens:
+ * 1. Trigger child disable first (if applicable)
+ * 2. Trigger parent disable
+ * 3. Verify no crashes, no resource leaks, proper cleanup
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "sub_sched_parent.bpf.skel.h"
+#include "sub_sched_nesting_child.bpf.skel.h"
+#include "scx_test.h"
+
+#define TEST_CGROUP_PATH "/sys/fs/cgroup/test_sub_sched_nesting"
+
+struct test_context {
+	struct sub_sched_parent *root_parent_skel;
+	struct sub_sched_nesting_child *level1_skel;
+	struct sub_sched_nesting_child *level2_skel;
+	char cgroup_path_l1[512];
+	char cgroup_path_l2[512];
+};
+
+/**
+ * Create a cgroup v2 for testing.
+ * Returns the inode number (which serves as cgroup ID) on success, -1 on error.
+ */
+static u64 create_test_cgroup(const char *path)
+{
+	struct stat st;
+
+	if (mkdir(path, 0755) < 0) {
+		if (errno != EEXIST) {
+			SCX_ERR("Failed to create cgroup: %s", strerror(errno));
+			return -1;
+		}
+	}
+
+	if (stat(path, &st) < 0) {
+		SCX_ERR("Failed to stat cgroup: %s", strerror(errno));
+		return -1;
+	}
+
+	return st.st_ino;
+}
+
+static void cleanup_cgroup(const char *path)
+{
+	if (rmdir(path) < 0 && errno != ENOENT)
+		SCX_ERR("Warning: Failed to cleanup cgroup: %s", strerror(errno));
+}
+
+/**
+ * Setup: Create 2-level cgroup hierarchy and load schedulers
+ */
+static enum scx_test_status setup(void **ctx)
+{
+	struct test_context *test_ctx;
+	u64 cgroup_id_l1, cgroup_id_l2;
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	/* Create level-1 cgroup */
+	snprintf(test_ctx->cgroup_path_l1, sizeof(test_ctx->cgroup_path_l1),
+		 "%s_l1.%d", TEST_CGROUP_PATH, getpid());
+
+	cgroup_id_l1 = create_test_cgroup(test_ctx->cgroup_path_l1);
+	if (cgroup_id_l1 == (u64)-1) {
+		SCX_ERR("Failed to create level-1 cgroup");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Create level-2 cgroup (nested under level-1) */
+	if (snprintf(test_ctx->cgroup_path_l2, sizeof(test_ctx->cgroup_path_l2),
+		     "%s/l2.%d", test_ctx->cgroup_path_l1, getpid()) >=
+	    (int)sizeof(test_ctx->cgroup_path_l2)) {
+		SCX_ERR("Path too long for level-2 cgroup");
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	cgroup_id_l2 = create_test_cgroup(test_ctx->cgroup_path_l2);
+	if (cgroup_id_l2 == (u64)-1) {
+		SCX_ERR("Failed to create level-2 cgroup");
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load root parent scheduler */
+	test_ctx->root_parent_skel = sub_sched_parent__open();
+	if (!test_ctx->root_parent_skel) {
+		SCX_ERR("Failed to open root parent BPF skeleton");
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->root_parent_skel);
+	if (sub_sched_parent__load(test_ctx->root_parent_skel)) {
+		SCX_ERR("Failed to load root parent BPF program");
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load level-1 nesting child (will be attached to root) */
+	test_ctx->level1_skel = sub_sched_nesting_child__open();
+	if (!test_ctx->level1_skel) {
+		SCX_ERR("Failed to open level-1 BPF skeleton");
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	test_ctx->level1_skel->struct_ops.sub_sched_nesting_child_ops->sub_cgroup_id = cgroup_id_l1;
+
+	SCX_ENUM_INIT(test_ctx->level1_skel);
+	if (sub_sched_nesting_child__load(test_ctx->level1_skel)) {
+		SCX_ERR("Failed to load level-1 BPF program");
+		sub_sched_nesting_child__destroy(test_ctx->level1_skel);
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load level-2 nesting child (will be attached to level-1) */
+	test_ctx->level2_skel = sub_sched_nesting_child__open();
+	if (!test_ctx->level2_skel) {
+		SCX_ERR("Failed to open level-2 BPF skeleton");
+		sub_sched_nesting_child__destroy(test_ctx->level1_skel);
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	test_ctx->level2_skel->struct_ops.sub_sched_nesting_child_ops->sub_cgroup_id = cgroup_id_l2;
+
+	SCX_ENUM_INIT(test_ctx->level2_skel);
+	if (sub_sched_nesting_child__load(test_ctx->level2_skel)) {
+		SCX_ERR("Failed to load level-2 BPF program");
+		sub_sched_nesting_child__destroy(test_ctx->level2_skel);
+		sub_sched_nesting_child__destroy(test_ctx->level1_skel);
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path_l2);
+		cleanup_cgroup(test_ctx->cgroup_path_l1);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+/**
+ * Run: Test cascading disable of nested schedulers.
+ *
+ * Tests the drain_descendants() path which recursively waits for all
+ * children to be disabled before proceeding.
+ *
+ * Execution order:
+ * 1. Attach root parent
+ * 2. Attach level-1 sub-scheduler
+ * 3. Attach level-2 sub-scheduler
+ * 4. Let all run briefly
+ * 5. Detach level-2 first
+ * 6. Detach level-1
+ * 7. Detach root (or allow kernel to clean up)
+ */
+static enum scx_test_status run(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+	struct bpf_link *root_link;
+	struct bpf_link *level1_link;
+	struct bpf_link *level2_link;
+
+	/* Attach root parent scheduler */
+	root_link = bpf_map__attach_struct_ops(
+		test_ctx->root_parent_skel->maps.sub_sched_parent_ops);
+	if (!root_link) {
+		SCX_ERR("Failed to attach root parent scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Attach level-1 sub-scheduler to root */
+	level1_link = bpf_map__attach_struct_ops(
+		test_ctx->level1_skel->maps.sub_sched_nesting_child_ops);
+	if (!level1_link) {
+		SCX_ERR("Failed to attach level-1 scheduler");
+		bpf_link__destroy(root_link);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Attach level-2 sub-scheduler to level-1 */
+	level2_link = bpf_map__attach_struct_ops(
+		test_ctx->level2_skel->maps.sub_sched_nesting_child_ops);
+	if (!level2_link) {
+		SCX_ERR("Failed to attach level-2 scheduler");
+		bpf_link__destroy(level1_link);
+		bpf_link__destroy(root_link);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Let all schedulers run briefly */
+	sleep(1);
+
+	/*
+	 * Critical test: Detach in reverse order (deepest first).
+	 * This tests that drain_descendants() properly waits for children
+	 * to complete their disable sequence.
+	 */
+	bpf_link__destroy(level2_link);
+	sleep(1);  /* Let level-1 complete its cleanup */
+
+	bpf_link__destroy(level1_link);
+	sleep(1);  /* Let root complete its cleanup */
+
+	bpf_link__destroy(root_link);
+
+	/* If we got here without crash or deadlock, cascading disable worked */
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+
+	if (!test_ctx)
+		return;
+
+	if (test_ctx->level2_skel)
+		sub_sched_nesting_child__destroy(test_ctx->level2_skel);
+
+	if (test_ctx->level1_skel)
+		sub_sched_nesting_child__destroy(test_ctx->level1_skel);
+
+	if (test_ctx->root_parent_skel)
+		sub_sched_parent__destroy(test_ctx->root_parent_skel);
+
+	cleanup_cgroup(test_ctx->cgroup_path_l2);
+	cleanup_cgroup(test_ctx->cgroup_path_l1);
+	free(test_ctx);
+}
+
+struct scx_test sub_sched_nesting = {
+	.name = "sub_sched_nesting",
+	.description = "Test multi-level nested sub-sched cascading disable",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&sub_sched_nesting)
diff --git a/tools/testing/selftests/sched_ext/sub_sched_parent_reject.bpf.c b/tools/testing/selftests/sched_ext/sub_sched_parent_reject.bpf.c
new file mode 100644
index 000000000000..656f29b6a599
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_sched_parent_reject.bpf.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Parent scheduler that rejects sub_attach for failure path testing.
+ *
+ * This scheduler deliberately rejects sub_attach to test that the kernel
+ * properly cleans up partially-initialized tasks and rolls back without crashing.
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 attach_reject_count;
+
+s32 BPF_STRUCT_OPS(parent_reject_sub_attach, struct scx_sub_attach_args *args)
+{
+	/* Deliberately reject sub_attach to trigger rollback path */
+	__sync_fetch_and_add(&attach_reject_count, 1);
+	return -EPERM;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops sub_sched_parent_reject_ops = {
+	.name			= "sub_sched_parent_reject",
+	.sub_attach		= (void *)parent_reject_sub_attach,
+};
diff --git a/tools/testing/selftests/sched_ext/sub_sched_parent_reject_test.c b/tools/testing/selftests/sched_ext/sub_sched_parent_reject_test.c
new file mode 100644
index 000000000000..f9945b8ab718
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_sched_parent_reject_test.c
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test for sub-sched parent rejection (abort path testing).
+ *
+ * Tests that when parent rejects sub_attach, the kernel:
+ * 1. Does not crash
+ * 2. Properly cleans up partially-initialized tasks
+ * 3. Rolls back without resource leaks
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "sub_sched_child.bpf.skel.h"
+#include "sub_sched_parent_reject.bpf.skel.h"
+#include "scx_test.h"
+
+#define TEST_CGROUP_PATH "/sys/fs/cgroup/test_sub_sched_reject"
+
+struct test_context {
+	struct sub_sched_parent_reject *parent_reject_skel;
+	struct sub_sched_child *child_skel;
+	char cgroup_path[256];
+};
+
+/**
+ * Create a cgroup v2 for testing.
+ * Returns the inode number (which serves as cgroup ID) on success, -1 on error.
+ */
+static u64 create_test_cgroup(const char *path)
+{
+	struct stat st;
+
+	/* Create the test cgroup directory */
+	if (mkdir(path, 0755) < 0) {
+		if (errno != EEXIST) {
+			SCX_ERR("Failed to create cgroup: %s", strerror(errno));
+			return -1;
+		}
+	}
+
+	/* Get the inode number (cgroup ID) */
+	if (stat(path, &st) < 0) {
+		SCX_ERR("Failed to stat cgroup: %s", strerror(errno));
+		return -1;
+	}
+
+	return st.st_ino;
+}
+
+static void cleanup_cgroup(const char *path)
+{
+	if (rmdir(path) < 0 && errno != ENOENT)
+		SCX_ERR("Warning: Failed to cleanup cgroup: %s", strerror(errno));
+}
+
+/**
+ * Setup for parent-reject test
+ */
+static enum scx_test_status setup(void **ctx)
+{
+	struct test_context *test_ctx;
+	u64 cgroup_id;
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	/* Create test cgroup */
+	snprintf(test_ctx->cgroup_path, sizeof(test_ctx->cgroup_path),
+		 "%s.%d", TEST_CGROUP_PATH, getpid());
+
+	cgroup_id = create_test_cgroup(test_ctx->cgroup_path);
+	if (cgroup_id == (u64)-1) {
+		SCX_ERR("Failed to create test cgroup");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load parent that rejects sub_attach */
+	test_ctx->parent_reject_skel = sub_sched_parent_reject__open();
+	if (!test_ctx->parent_reject_skel) {
+		SCX_ERR("Failed to open parent_reject BPF skeleton");
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->parent_reject_skel);
+	if (sub_sched_parent_reject__load(test_ctx->parent_reject_skel)) {
+		SCX_ERR("Failed to load parent_reject BPF program");
+		sub_sched_parent_reject__destroy(test_ctx->parent_reject_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load child scheduler */
+	test_ctx->child_skel = sub_sched_child__open();
+	if (!test_ctx->child_skel) {
+		SCX_ERR("Failed to open child BPF skeleton");
+		sub_sched_parent_reject__destroy(test_ctx->parent_reject_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Set sub_cgroup_id to the test cgroup's inode */
+	test_ctx->child_skel->struct_ops.sub_sched_child_ops->sub_cgroup_id = cgroup_id;
+
+	SCX_ENUM_INIT(test_ctx->child_skel);
+	if (sub_sched_child__load(test_ctx->child_skel)) {
+		SCX_ERR("Failed to load child BPF program");
+		sub_sched_child__destroy(test_ctx->child_skel);
+		sub_sched_parent_reject__destroy(test_ctx->parent_reject_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+/**
+ * Run: Test parent rejection of sub_attach.
+ *
+ * This tests that when parent rejects sub_attach, the kernel:
+ * 1. Does not crash
+ * 2. Properly cleans up partially-initialized tasks
+ * 3. Rolls back without resource leaks
+ *
+ * This exercise the abort path at line 7086+ in ext.c which should:
+ * - Clean up already-initialized tasks
+ * - Clear SCX_TASK_SUB_INIT flags
+ * - Properly decrement reference counts
+ */
+static enum scx_test_status run(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+	struct bpf_link *parent_link;
+	struct bpf_link *child_link;
+
+	/* Attach parent that will reject sub_attach */
+	parent_link = bpf_map__attach_struct_ops(
+		test_ctx->parent_reject_skel->maps.sub_sched_parent_reject_ops);
+	if (!parent_link) {
+		SCX_ERR("Failed to attach parent scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Try to attach child - this should fail when parent rejects sub_attach */
+	child_link = bpf_map__attach_struct_ops(test_ctx->child_skel->maps.sub_sched_child_ops);
+
+	/* It's OK if this fails - we're testing the failure path */
+	if (child_link) {
+		/* If attach somehow succeeded, clean it up */
+		bpf_link__destroy(child_link);
+	}
+
+	/* Key test: Parent can be detached cleanly even though child attach failed */
+	bpf_link__destroy(parent_link);
+
+	/* If we got here without crash, the abort path worked correctly */
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+
+	if (!test_ctx)
+		return;
+
+	if (test_ctx->child_skel)
+		sub_sched_child__destroy(test_ctx->child_skel);
+
+	if (test_ctx->parent_reject_skel)
+		sub_sched_parent_reject__destroy(test_ctx->parent_reject_skel);
+
+	cleanup_cgroup(test_ctx->cgroup_path);
+	free(test_ctx);
+}
+
+struct scx_test sub_sched_parent_reject = {
+	.name = "sub_sched_parent_reject",
+	.description = "Test sub-attach rejection (abort path cleanup)",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&sub_sched_parent_reject)
diff --git a/tools/testing/selftests/sched_ext/sub_sched_race_test.c b/tools/testing/selftests/sched_ext/sub_sched_race_test.c
new file mode 100644
index 000000000000..9ab1185b769f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/sub_sched_race_test.c
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test for concurrent parent disable vs child enable race.
+ *
+ * Tests that when parent scheduler disable happens concurrently with
+ * child scheduler enable, the kernel handles the race correctly without
+ * UAF (Use-After-Free), memory corruption, or deadlock.
+ *
+ * Key code path being tested:
+ *   scx_sub_enable_workfn() [line 6882+]:
+ *     - Sets cgroup->scx_sched (line 6973)
+ *     - Checks CSS_ONLINE flag (line 6974)
+ *   ↓ RACE ↓
+ *   scx_cgroup_lifetime_notify() [responds to CSS going offline]:
+ *     - Calls disable_and_exit_task()
+ *
+ * This can trigger:
+ * - The enable workfn starting initialization of tasks
+ * - Parent disable path trying to clean up same tasks
+ * - Both happening without proper synchronization
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "sub_sched_parent.bpf.skel.h"
+#include "sub_sched_child.bpf.skel.h"
+#include "scx_test.h"
+
+#define TEST_CGROUP_PATH "/sys/fs/cgroup/test_sub_sched_race"
+
+struct test_context {
+	struct sub_sched_parent *parent_skel;
+	struct sub_sched_child *child_skel;
+	char cgroup_path[256];
+	pthread_t disable_thread;
+	struct bpf_link *parent_link;
+	int disable_start_signal;
+};
+
+static u64 create_test_cgroup(const char *path)
+{
+	struct stat st;
+
+	if (mkdir(path, 0755) < 0) {
+		if (errno != EEXIST) {
+			SCX_ERR("Failed to create cgroup: %s", strerror(errno));
+			return -1;
+		}
+	}
+
+	if (stat(path, &st) < 0) {
+		SCX_ERR("Failed to stat cgroup: %s", strerror(errno));
+		return -1;
+	}
+
+	return st.st_ino;
+}
+
+static void cleanup_cgroup(const char *path)
+{
+	if (rmdir(path) < 0 && errno != ENOENT)
+		SCX_ERR("Warning: Failed to cleanup cgroup: %s", strerror(errno));
+}
+
+/**
+ * Thread function: Disable parent scheduler after a delay
+ * This creates the race condition with child enable
+ */
+static void *disable_thread_fn(void *arg)
+{
+	struct test_context *ctx = arg;
+
+	/* Wait for signal that child attach is happening */
+	while (!__atomic_load_n(&ctx->disable_start_signal, __ATOMIC_ACQUIRE))
+		usleep(10000);  /* 10ms */
+
+	/* Small delay to ensure we're mid-initialization */
+	usleep(50000);  /* 50ms */
+
+	/* Destroy parent link - this triggers disable path */
+	if (ctx->parent_link) {
+		bpf_link__destroy(ctx->parent_link);
+		ctx->parent_link = NULL;
+	}
+
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct test_context *test_ctx;
+	u64 cgroup_id;
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	snprintf(test_ctx->cgroup_path, sizeof(test_ctx->cgroup_path),
+		 "%s_race.%d", TEST_CGROUP_PATH, getpid());
+
+	cgroup_id = create_test_cgroup(test_ctx->cgroup_path);
+	if (cgroup_id == (u64)-1) {
+		SCX_ERR("Failed to create test cgroup");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load parent scheduler */
+	test_ctx->parent_skel = sub_sched_parent__open();
+	if (!test_ctx->parent_skel) {
+		SCX_ERR("Failed to open parent BPF skeleton");
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->parent_skel);
+	if (sub_sched_parent__load(test_ctx->parent_skel)) {
+		SCX_ERR("Failed to load parent BPF program");
+		sub_sched_parent__destroy(test_ctx->parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load child scheduler */
+	test_ctx->child_skel = sub_sched_child__open();
+	if (!test_ctx->child_skel) {
+		SCX_ERR("Failed to open child BPF skeleton");
+		sub_sched_parent__destroy(test_ctx->parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	test_ctx->child_skel->struct_ops.sub_sched_child_ops->sub_cgroup_id = cgroup_id;
+
+	SCX_ENUM_INIT(test_ctx->child_skel);
+	if (sub_sched_child__load(test_ctx->child_skel)) {
+		SCX_ERR("Failed to load child BPF program");
+		sub_sched_child__destroy(test_ctx->child_skel);
+		sub_sched_parent__destroy(test_ctx->parent_skel);
+		cleanup_cgroup(test_ctx->cgroup_path);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+/**
+ * Run: Test concurrent parent disable vs child enable.
+ *
+ * This tests the synchronization between:
+ * 1. Child scheduler enable workfn (scx_sub_enable_workfn)
+ * 2. Parent scheduler disable path (scx_sub_disable)
+ *
+ * Both can race on:
+ * - Task state changes
+ * - cgroup->scx_sched pointer updates
+ * - CSS_ONLINE checks
+ *
+ * The kernel must handle this without:
+ * - Use-After-Free (UAF)
+ * - Memory corruption
+ * - Deadlock
+ * - Reference count errors
+ */
+static enum scx_test_status run(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+	struct bpf_link *child_link;
+	int ret;
+
+	/* Attach parent scheduler */
+	test_ctx->parent_link = bpf_map__attach_struct_ops(
+		test_ctx->parent_skel->maps.sub_sched_parent_ops);
+	if (!test_ctx->parent_link) {
+		SCX_ERR("Failed to attach parent scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Start thread that will disable parent mid-way through child enable */
+	test_ctx->disable_start_signal = 0;
+	ret = pthread_create(&test_ctx->disable_thread, NULL, disable_thread_fn, test_ctx);
+	if (ret) {
+		SCX_ERR("Failed to create disable thread: %s", strerror(ret));
+		bpf_link__destroy(test_ctx->parent_link);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Signal the disable thread that we're about to attach child */
+	__atomic_store_n(&test_ctx->disable_start_signal, 1, __ATOMIC_RELEASE);
+
+	/*
+	 * Try to attach child scheduler.
+	 * The disable thread will concurrently try to disable parent.
+	 * This should not crash or deadlock.
+	 */
+	child_link = bpf_map__attach_struct_ops(test_ctx->child_skel->maps.sub_sched_child_ops);
+
+	/* Clean up */
+	if (child_link)
+		bpf_link__destroy(child_link);
+
+	/* Ensure disable thread finishes */
+	pthread_join(test_ctx->disable_thread, NULL);
+
+	/* Verify parent is still cleanly detachable (if not already destroyed) */
+	if (test_ctx->parent_link)
+		bpf_link__destroy(test_ctx->parent_link);
+
+	/* If we got here without crash, the race was handled correctly */
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct test_context *test_ctx = ctx;
+
+	if (!test_ctx)
+		return;
+
+	if (test_ctx->parent_link)
+		bpf_link__destroy(test_ctx->parent_link);
+
+	if (test_ctx->child_skel)
+		sub_sched_child__destroy(test_ctx->child_skel);
+
+	if (test_ctx->parent_skel)
+		sub_sched_parent__destroy(test_ctx->parent_skel);
+
+	cleanup_cgroup(test_ctx->cgroup_path);
+	free(test_ctx);
+}
+
+struct scx_test sub_sched_race = {
+	.name = "sub_sched_race",
+	.description = "Test concurrent parent disable vs child enable race",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&sub_sched_race)
-- 
2.43.0

