Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D163932C4
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801359; cv=none; b=pq3C/0Ms30EurtvQIP/qSihSAdv4f0vDEP+ZJotejgW42Cz+nXR2c6xc21HC/Heji8R3nQZ3RGuDjPgfoRkov0c1bA0+HS1u5JpJzdvEtqT3cNvci61nwglCJOySCNLh0MaLnqbtbnOIbXbt3JvKzyd9v88TvcznXfrdwDwpyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801359; c=relaxed/simple;
	bh=BZeeJ1JML7xaZoBvWAKlQYnkV7F90b7mZuzv0ATZ6Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcCRb4zFnkjhOkJjLTwOf+75JrpJmZhmkYfkxhzEzADW2fANMDogEgRl8PVqK9u4LajEEasLJqQVVkGiKpYyQ4mpt9F5enaig+QemNpbfP5B8ACGjUmFBQ5qZOv8ckQVjoWHua/l9mZWM+YIX4W0US1lFXRoo36uosfFRqivBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fteeDa0G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fteeDa0G"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso25925945ad.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 04:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801357; x=1773406157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TnQKdPGtTuRU+46cutq94eviTJ71u1qZiPiKlbjQJQ=;
        b=fteeDa0GBHwQeMTe52CHP5FoKdO835X9i1Bj1m6b24OoFCdYSpJhXfbrM8xIaUati7
         BLcYZNVWAesQ3t2U6a7VyvR+k+DaJefxDdnbtERrvyEFMLgm+y4wFPBQ1WzOgN04abX1
         u/qdYsm/Avtl4LF6ZvicaHWVHLJowbQTZvoSYSksD3D9W9HFzpJ0/pGSxKnmNk4pUpwe
         XDELCdI7/7G2oXORC0KZYhk6h0d40hs0BPnWaOTkospKEez9fVOTdArlZD3jx60pmUj9
         pOviWSZSq9+9Y1+N8bQbq0bQPLL3UhgG28DiUk5M3O0AYvFijcTa8Jy/3V1JIdI93dyQ
         Llig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801357; x=1773406157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TnQKdPGtTuRU+46cutq94eviTJ71u1qZiPiKlbjQJQ=;
        b=Bre3UycmMeL4NlquwBO+63OKTDKfMgNBFLdWYm5yX2aL9wus2END3KDr8V6ODIKZ3V
         ZX3Iwzcuu9DJuNU0bXrUYG4JfdwFPUowRnwhFxhsg8I+x+mrw31tsuwmjVKL1Ze4t/SV
         okrXkjNk/ju7Ge3XX9jV2gAT7ObGJb79fDOq44hKal4QmRxw1Gp8YGKHkMx3zgLh92oA
         ufX6vi1vsLtCDyj/ssYs9MD/GbbJyk2Mum9sLQTnQGOsi0KpzYjFlOcagkqe7yJiAh8g
         mNm9bsLDUlzzKhUJnCjAy26uSl4Tk+3aYdTewGMcgC6gbuhmSiKbtwWjFe4CDtvIR+3l
         GCuw==
X-Forwarded-Encrypted: i=1; AJvYcCVD8R2b719xdRS5m9KND+g5CzOAPVOYLStI08Nv4AEKcbDb/z/zeKnY6+bex9KEWmAXBtiH7xB4Gkg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwEpzx4qNK2HBVrmWIjS0lNpWG5shaNI50du3HGtd/qreNhOUte
	iHP3Hpn/4gZFE6FYhcnTijKAk9ulUxCwfDlT7NcoXt7P9PIK730dBBCD
X-Gm-Gg: ATEYQzwyW+DdyU2/95ppQ2v1uuLAcesCUNs9ZOfMFRyGijfJkLdYh2ENZaCVXpcyO6i
	HGnDNORw7HEzgs4YBcNOVtvtfm4Dx/juXI1EOrZXlzPPMqrhpF38oo7mO/XSHIC0djTOsp3YoBj
	JiQHHG/7/LWdChFFrep1WOeCA4UZ3b39HuRCjucCjHHI6mn3gzMxkm/Vb2AYXIblhU3gXuZMEhV
	oLZMCVK3LgRpmkfgI5S+9fIla9PnjaA66Y3fKL/Y0QqCqW/0w1l++CzC5l+KuCodyWDvCKLZ1dD
	kLP0ieZRFrpbzoKuVqN6IBQs89UN8WfqCA2QE6GDCbKzqCpnIMOFlhNowR56piIBRS4/gGurUdA
	f+9au539fjiz2a/PiDH6p7KzTCV+AjrbGZhapUpV76qSkYSe5y+S+FkmgnYv98qgy9B0aP9KpvF
	D+qHfNFkIxyLUjeG+ZjbNS5uchmPWTdXnI7aqx/LtyQaOg6vo+80a0uyKrkSXMmYKeyfWgb9jSd
	oJz+gLwYrBVoA==
X-Received: by 2002:a17:902:d544:b0:2ae:7f3a:b213 with SMTP id d9443c01a7336-2ae8252fb45mr22420835ad.47.1772801357343;
        Fri, 06 Mar 2026 04:49:17 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f77sm27712845ad.21.2026.03.06.04.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:49:17 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: [PATCH 4/5] sched_ext/selftests: Add bypass mode operational test
Date: Fri,  6 Mar 2026 20:49:00 +0800
Message-ID: <20260306124901.2653465-4-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

Add a test that verifies the sched_ext bypass mechanism does not
prevent tasks from running to completion.

The test attaches a minimal global FIFO scheduler, spawns worker
processes that complete a fixed computation, detaches the scheduler
(which triggers bypass mode while workers are still active), and
verifies all workers complete successfully under bypass mode.

This exercises the scheduler attach/detach lifecycle and verifies
that bypass mode (activated during unregistration to guarantee
forward progress) does not stall running tasks.

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/bypass.bpf.c  |  32 ++++++
 tools/testing/selftests/sched_ext/bypass.c    | 105 ++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/bypass.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/bypass.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index a3bbe2c7911b..5fb6278d3f97 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -162,6 +162,7 @@ endef
 all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
 
 auto-test-targets :=			\
+	bypass				\
 	create_dsq			\
 	dequeue				\
 	enq_last_no_enq_fails		\
diff --git a/tools/testing/selftests/sched_ext/bypass.bpf.c b/tools/testing/selftests/sched_ext/bypass.bpf.c
new file mode 100644
index 000000000000..cb37c8df6834
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/bypass.bpf.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF scheduler for bypass mode operational test.
+ *
+ * Implements a minimal global FIFO scheduler. The userspace side
+ * attaches this scheduler, runs worker tasks to completion, and
+ * verifies that tasks complete successfully.
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(bypass_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(bypass_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops bypass_ops = {
+	.enqueue		= (void *)bypass_enqueue,
+	.exit			= (void *)bypass_exit,
+	.name			= "bypass_test",
+};
diff --git a/tools/testing/selftests/sched_ext/bypass.c b/tools/testing/selftests/sched_ext/bypass.c
new file mode 100644
index 000000000000..952f09d76bdb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/bypass.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify the sched_ext bypass mechanism: spawn worker tasks and ensure
+ * they run to completion while a BPF scheduler is active.
+ *
+ * The bypass mechanism (activated on scheduler unregistration) must
+ * guarantee forward progress. This test verifies that worker tasks
+ * complete successfully when the scheduler is detached.
+ *
+ * Copyright (c) 2026 Xiaomi Corporation.
+ */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/wait.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_test.h"
+#include "bypass.bpf.skel.h"
+
+#define NUM_BYPASS_WORKERS 4
+
+static void worker_fn(void)
+{
+	volatile int sum = 0;
+	int i;
+
+	/*
+	 * Do enough work to still be running when bpf_link__destroy()
+	 * is called, ensuring tasks are active during bypass mode.
+	 */
+	for (i = 0; i < 10000000; i++)
+		sum += i;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct bypass *skel;
+
+	skel = bypass__open();
+	SCX_FAIL_IF(!skel, "Failed to open bypass skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(bypass__load(skel), "Failed to load bypass skel");
+
+	*ctx = skel;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct bypass *skel = ctx;
+	struct bpf_link *link;
+	pid_t pids[NUM_BYPASS_WORKERS];
+	int i, status;
+
+	link = bpf_map__attach_struct_ops(skel->maps.bypass_ops);
+	SCX_FAIL_IF(!link, "Failed to attach bypass scheduler");
+
+	/*
+	 * Spawn worker processes. These must complete successfully
+	 * even as the scheduler is active and then detached (which
+	 * triggers bypass mode).
+	 */
+	for (i = 0; i < NUM_BYPASS_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "fork() failed for worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn();
+			_exit(0);
+		}
+	}
+
+	/*
+	 * Detach the scheduler while workers are still running. This
+	 * triggers bypass mode, which must guarantee forward progress
+	 * for all active tasks.
+	 */
+	bpf_link__destroy(link);
+
+	/* Workers must complete successfully under bypass mode */
+	for (i = 0; i < NUM_BYPASS_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "waitpid failed for worker %d", i);
+		SCX_FAIL_IF(!WIFEXITED(status) || WEXITSTATUS(status) != 0,
+			    "Worker %d did not exit cleanly", i);
+	}
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	bypass__destroy(ctx);
+}
+
+struct scx_test bypass_test = {
+	.name		= "bypass",
+	.description	= "Verify tasks complete during bypass mode",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&bypass_test)
-- 
2.43.0

