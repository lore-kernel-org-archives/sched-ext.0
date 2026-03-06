Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE63AE704
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805826; cv=none; b=PTVzdxHaAqP79CDoJWx60d/w5Nw0yyEITmRKJq/wCRAR6FDpnJNYEdOvz/vVzec1IsTroipczRfIulGRF1vigKN5AaTh3l9yzdNkbJf+A9g1sSQFa316NhNoVCLw6EEjn5UjAuO7BLEIXBEuC5BcfS2zchmcsSM6FnwV4D6nr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805826; c=relaxed/simple;
	bh=BZeeJ1JML7xaZoBvWAKlQYnkV7F90b7mZuzv0ATZ6Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuFd1UrO2OB751tocm3p42kuTBTr2TjDeKZfthBcIW81GscLekybpYpWsbBrzgnVGFW4vZisRSlMswPrBO2nS+hU1yb36AyIELl1cTd7LnNBZMvJ8trPRZkI+BoKW99JGHf8n1UhWiAM5VCG8kejrBDjm8K1U3ZW8xf+FIOkBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2wpwbiY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2wpwbiY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4d919f9bso34776735ad.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805824; x=1773410624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TnQKdPGtTuRU+46cutq94eviTJ71u1qZiPiKlbjQJQ=;
        b=g2wpwbiYR37ZD5txvSMMfh6ycor70TjMHJxqhpLSWpp9KXyeS7FZQ4bAYmqkG1IKo4
         pcxIwoTT+KmdbJMdpr4BBpmj7CkChzPcJZq+OGNtX9iICvpk/bLySQoo1H5nmN9aEOcJ
         u61+44VC+2RPR5S2+b0/fzFCTkCMN+KND2L8lR2jbr1NoO9qU1I3LY6fO1xeDGpMzZKg
         uXyWx2nI8IPYVHSnUy3HZzdUqyS5Il/jfo4opNBREI7YupPtJYLsBvywk+Q+IxU36w+t
         xbT59qR1zHqDyPJYtX++0M/+3Psk8GPLVWZxUhXyZifSNhl8UychP/c/cvp5/j8KrTHG
         icRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805824; x=1773410624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TnQKdPGtTuRU+46cutq94eviTJ71u1qZiPiKlbjQJQ=;
        b=w36PnSsraEvDsI7E9kJASDYfT9nqji0EkyT8h8za/uyb1/60ReEYD5EtLoURvUfrGs
         m1BR68NFsx+kXg6fjEdNJOBno4JX22mh7rv80uy6zEtV9rjFYRa7frhDxNj9C6pQaiNG
         rRtFx+QD4U8ZhthsYpAFHVrT5wJxKKzh16c+M/E6Lc7upPKmaT0kDmpg8JkUcs/nJIzk
         I7HzrLutGRRCddMvabsQ3g8KCSkratk9JyrxIUDN3zv+OLoVJ8HuHmVPwi3wJEaDdzpo
         sJwUFeHBC3QU8Iww6X67DlXfQrMBEkTnL1s8YgPjHOW0jE1Ot/m8xfz+EfWP1/XHEL6H
         V9uw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+Gcoc91P2Q0xUylS3vWXrCeGGrXvxeUiZMRWiZjsyXKrzKKRZygoQ1kHKcio2Hhd7ssjwpn6CjA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzDDJoiwlB5MaRMIYLFXsCsMFrWmXodV5gCz5MnmDT5iwp0Wj6C
	Vk6zNjfTVWGSj28fYjU9ku5eaNJSrLrxRGLw0B8x47TYuXyrR/jBW5w2
X-Gm-Gg: ATEYQzzosn8VK76ZkK2DtOTNdGU5/lX+TocDDMrHr2tUAwxN141Suxf8Zl/XcQ92b9P
	66ijNazHJIPdwdt8nWA72dAdaISk1pjF4UHbqfjYIhVn/oxkDppQBNIsghZtkGZN4lCKCcQ9Mq+
	uuvgwPrvJ/7Iq93inxC2ok2g/H0xcW4vnYHEXOkbFy7yzVPWD3+bkIxm/mDznvL6jyg8REQ+X3F
	QCcDYrbGwMyN0D3amr2H9gWEUSvP6cHfDslCI9TSY8H5Uo7oXnDCEKzGHEs3aeLwh7ullyjJ0rW
	PRR/d3XpHazcfssBXqVDMfmadKS2t6PQi6EKn3pVhZJ0LKs8vXopbQyMW8wU28YA4N/0obBu8K5
	iXsvM7n1bEKSkiwmhF8iL3/h7n1Y3pwSEgrotA7Eh+Vjxt/Uzqi8WS20JbXMbS6owDye8a0SH7q
	EUvMK3TdVlZR9XLaXAopm3LDzlWXD9G6hbxcySmEHTsxhRaZ/xTkT/9ZiuCAiplYjJWki269Adz
	Fs=
X-Received: by 2002:a17:902:f78a:b0:2ae:4948:f866 with SMTP id d9443c01a7336-2ae8239bd5emr22877785ad.22.1772805824108;
        Fri, 06 Mar 2026 06:03:44 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:43 -0800 (PST)
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
Date: Fri,  6 Mar 2026 22:03:24 +0800
Message-ID: <20260306140325.2710927-5-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306140325.2710927-1-suzhidao@xiaomi.com>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
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

