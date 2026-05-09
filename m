Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFA33A9D6
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353957; cv=none; b=OtnjuV+mO+S0UZVDCOqGWu/eF6aYi6QdgKTGe/Q1YLH1LnTe76UeSJeHNjK7bWRJz9Z3iHKIdcWfEYwxrAhJvigRhARE0rvs5aKNb7IZ94PXhf6KPF7qiUpm1L7dlHk4X7jsJGvkoRRrxTFHzgT6tUT2XvUW6+sig2WCrM42Sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353957; c=relaxed/simple;
	bh=efDKwQMcOEA4LhF0rbt0jmr003KCpbbUuta57g6CpQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e30FMK4oGv5IIo6GcVwcj87CeaopZ8/LHQMcBzuzwtb5NUj+tvEGML7qFBvnyC4ms1PmQZwDJu9+h7mhyo4j1GcfOgO/ySaaVDHqHZwp/6v7/hUnJbbemO+iW8RsFWgxOTxMvTE5n6lcOQ2u1X8aWRqW+gIXmhRTtDN3ERKU84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfKe08oE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfKe08oE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-835b78c3797so1294058b3a.2
        for <sched-ext@lists.linux.dev>; Sat, 09 May 2026 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778353955; x=1778958755; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLCkz/s3zDtACmmRvevuXlQ7atBBsNIhg1OYucXY7tA=;
        b=GfKe08oEGO2mlm6idw/KJJ0oPyzzoaPGVii2avxfq0ZgN3p6upq9fQ8z6CFGdyLCUp
         mI9mjwn3lk665DZuHeWBEGRh8PvlUQrAuILzg5lvT3QZgsTlwUgkTJ1Om4638YrHP73p
         5Dlnzvz7do7y6BMjVeTYSJk4Xl1ani7wRjGeP72ceKdgV68KBRmM8+9focsRfOzGO6TL
         Y4rPS5lIzCO4KX7a10MfOKes5gbbttx5qosa36XiFh0G1IxS/Fo+6UKe+x7C0Z0tTnn3
         DtxybFCD4Ik7FLZFa4EuFcBYSs/GbEix5ex45SMcF3XzBstPInJnZ4EQiRXZ4xWQNJDC
         nB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778353955; x=1778958755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLCkz/s3zDtACmmRvevuXlQ7atBBsNIhg1OYucXY7tA=;
        b=OaLMEJD2lnA/oa1eFcrfraYZ5Ei7DF1oVWLzE4qzZiBR7wRTyNulqW3+9uFmn+X57B
         jZPw3ydetUhS9IQ8Ksvemdh9Pte8VNmaUJGUD2W3uEUtvknvRwn/aKWJjIdgpY/EBgfZ
         XW3XZMeoa2huyK2qUfBjOI2ldPBa+bnfkF+YGl+H4kyooejyZ0CH4/6eBqWjtT/Iv+Wt
         oEHQQvA42amUyZDVam1jNW+Eb/XhYFna7Stb6kGpKvIutmpqkLdoAMjMnGOSKJJA9coi
         fMCRp8WVqMYbslLmX1KBiFITmDOl6cph08Lixcus6uFeYSklto7jNT5+jFABqzo2rFnB
         X81Q==
X-Gm-Message-State: AOJu0Yyzv5qJurWJ00fChxrPPZCSfJ+oUncOFir8j2hF+jH4s21/bmgp
	9loAosbarZntZw1z+nLKV8ISVPd7uET0MwHxdVmS5xoKPSvlFLKLHcUJZd1QaA==
X-Gm-Gg: Acq92OFg3LWVMnum4kQhpzqCp2kvPriqJ83LOHeHDpTbC3Kv2aEzESHfNDbtqhfLDvQ
	1eTcV2E8KXNIkRR7gqLrkoSxJoxXaeDs/ZI/GXyNDPyGGYPEAdQANAlzoI3/ahyHQEdJ1WDQFwE
	YDq27WyBSht+/qTsXSkQY5U4ug0KOgI4AuX5DZic32gnbvAQgUpj/VeYc7J5Sm8Xmp7A5rJ3vUX
	tqFJvjqcYKvZbmYrwJCCNC2amBA7V6po8pisaJO9tguvPhin0YceUhnDKEO0De+m+IoMC0Q9rSj
	m5htZM2z1PvE9npae1qxACXgp8y0oMx/k3WAQ6Ey2TW6Z4tYAI72lia4mFs3b42BUKF5KNtimjq
	qb2kNM9WKcBMiyi6Zo6qaN4dKrr/IQRNbIrbXBufHHM1GgjnChxTqG+9wtUh6gw4zX6/MQqpII/
	CXnlz0hbDDJWGm2iMwKUnKkAXfiFCys6vD5aBwn3WLEd9nUezw6Dut
X-Received: by 2002:a05:6a00:3e09:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-83cf7467698mr7588872b3a.45.1778353955127;
        Sat, 09 May 2026 12:12:35 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:7487:6815:7f54:c796])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm14470222b3a.43.2026.05.09.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:12:34 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v3 2/2] selftests/sched_ext: Add dispatch_cookie test
Date: Sun, 10 May 2026 03:11:57 +0800
Message-ID: <20260509191223.168648-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260509191223.168648-1-yphbchou0911@gmail.com>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit().

The BPF scheduler enqueues tasks into a BPF queue map in ops.enqueue()
and dispatches them via the begin/commit transaction API in ops.dispatch().
After a successful dispatch, the token is stored. On the task's next
dispatch (after dequeue/re-enqueue increments qseq), the stored token is
stale and finish_dispatch() silently drops the buffered entry.

Userspace forks spinning children and repeatedly flips their CPU affinity
to trigger dequeue/re-enqueue cycles. The test verifies both nr_tx_dispatched
and nr_tx_stale are positive, exercising both the happy path and the
race-detection window.

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 102 ++++++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 131 ++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e91..ae3dc0913378 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -164,6 +164,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
+	dispatch_cookie			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
new file mode 100644
index 000000000000..ed31cddcda7b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit().
+ *
+ * Exercises both the happy path (fresh token committed successfully) and
+ * the race-detection path (stale token from a previous dispatch cycle
+ * rejected after the task was dequeued and re-enqueued, incrementing qseq).
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 8192);
+	__type(value, s32);
+} queue SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 4096);
+	__type(key, s32);
+	__type(value, u64);
+} last_token SEC(".maps");
+
+long nr_tx_dispatched;
+long nr_tx_stale;
+
+void BPF_STRUCT_OPS(dispatch_cookie_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	if (bpf_map_push_elem(&queue, &pid, 0))
+		scx_bpf_error("Failed to enqueue %s[%d]", p->comm, p->pid);
+}
+
+void BPF_STRUCT_OPS(dispatch_cookie_dispatch, s32 cpu,
+		    struct task_struct *prev)
+{
+	s32 pid;
+	struct task_struct *p;
+	u64 *stored, token;
+
+	if (bpf_map_pop_elem(&queue, &pid))
+		return;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return;
+
+	/*
+	 * After a successful fresh dispatch, store the token. On the task's
+	 * next dispatch (after re-enqueue increments qseq), the stored token
+	 * exercises the race-detection window in finish_dispatch().
+	 *
+	 * scx_bpf_dsq_insert_commit() always returns %true when the preamble
+	 * passes. Stale detection fires asynchronously in finish_dispatch()
+	 * with no BPF-observable signal. When using a stored token, always
+	 * pair the commit() call with a fallback scx_bpf_dsq_insert(): if
+	 * the token is stale, finish_dispatch() drops the first entry and
+	 * the fallback dispatches the task. If the token is still fresh,
+	 * finish_dispatch() dispatches it and the fallback's CAS is a no-op.
+	 */
+	stored = bpf_map_lookup_elem(&last_token, &pid);
+	if (stored) {
+		token = *stored;
+		bpf_map_delete_elem(&last_token, &pid);
+		scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token);
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		__sync_fetch_and_add(&nr_tx_stale, 1);
+	} else {
+		token = scx_bpf_dsq_insert_begin(p);
+		if (scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token)) {
+			__sync_fetch_and_add(&nr_tx_dispatched, 1);
+			bpf_map_update_elem(&last_token, &pid, &token, BPF_ANY);
+		} else {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		}
+	}
+
+	bpf_task_release(p);
+}
+
+void BPF_STRUCT_OPS(dispatch_cookie_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dispatch_cookie_ops = {
+	.enqueue		= (void *) dispatch_cookie_enqueue,
+	.dispatch		= (void *) dispatch_cookie_dispatch,
+	.exit			= (void *) dispatch_cookie_exit,
+	.name			= "dispatch_cookie",
+	.timeout_ms		= 5000U,
+};
diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.c b/tools/testing/selftests/sched_ext/dispatch_cookie.c
new file mode 100644
index 000000000000..6b46ca4efeb4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit().
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "dispatch_cookie.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_CHILDREN	32
+#define NUM_FLIP_ITERS	100
+
+struct dispatch_cookie_ctx {
+	struct dispatch_cookie	*skel;
+	struct bpf_link		*link;
+};
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dispatch_cookie_ctx *tctx;
+
+	if (!__COMPAT_has_ksym("scx_bpf_dsq_insert_begin")) {
+		fprintf(stderr, "SKIP: dispatch transaction API not supported\n");
+		return SCX_TEST_SKIP;
+	}
+
+	tctx = malloc(sizeof(*tctx));
+	SCX_FAIL_IF(!tctx, "Failed to allocate test context");
+	tctx->link = NULL;
+
+	tctx->skel = dispatch_cookie__open();
+	if (!tctx->skel) {
+		free(tctx);
+		SCX_FAIL("Failed to open skel");
+	}
+	SCX_ENUM_INIT(tctx->skel);
+	if (dispatch_cookie__load(tctx->skel)) {
+		dispatch_cookie__destroy(tctx->skel);
+		free(tctx);
+		SCX_FAIL("Failed to load skel");
+	}
+
+	*ctx = tctx;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dispatch_cookie_ctx *tctx = ctx;
+	cpu_set_t cpuset_one, cpuset_all;
+	pid_t pids[NUM_CHILDREN];
+	int i, j, nforked = 0, status;
+
+	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.dispatch_cookie_ops);
+	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
+
+	CPU_ZERO(&cpuset_one);
+	CPU_SET(0, &cpuset_one);
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(cpuset_all), &cpuset_all),
+		    "Failed to get CPU affinity (%d)", errno);
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			while (1)
+				sched_yield();
+		}
+		if (pids[i] > 0)
+			nforked++;
+	}
+
+	/*
+	 * Flip affinity to trigger dequeue/re-enqueue, which increments qseq
+	 * and makes previously captured tokens stale.
+	 */
+	for (i = 0; i < NUM_FLIP_ITERS; i++) {
+		for (j = 0; j < NUM_CHILDREN; j++) {
+			if (pids[j] <= 0)
+				continue;
+			sched_setaffinity(pids[j], sizeof(cpuset_one),
+					  &cpuset_one);
+			sched_setaffinity(pids[j], sizeof(cpuset_all),
+					  &cpuset_all);
+		}
+		usleep(1000);
+	}
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		if (pids[i] <= 0)
+			continue;
+		kill(pids[i], SIGKILL);
+		waitpid(pids[i], &status, 0);
+	}
+
+	SCX_GT(nforked, 0);
+	SCX_GT(tctx->skel->bss->nr_tx_dispatched, 0);
+	SCX_GT(tctx->skel->bss->nr_tx_stale, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dispatch_cookie_ctx *tctx = ctx;
+
+	if (tctx->link)
+		bpf_link__destroy(tctx->link);
+	dispatch_cookie__destroy(tctx->skel);
+	free(tctx);
+}
+
+struct scx_test dispatch_cookie = {
+	.name		= "dispatch_cookie",
+	.description	= "Verify scx_bpf_dsq_insert_begin() and "
+			  "scx_bpf_dsq_insert_commit() dispatch tasks correctly",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&dispatch_cookie)
-- 
2.48.1

