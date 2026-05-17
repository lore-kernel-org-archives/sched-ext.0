Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032F361DDE
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034092; cv=none; b=NlDFfFiCLV0AlF6DvwbdN8bqk1w2RzgbKsW56vgg6kBz60G0Mk27W3NOvfINgQcJ8j/sXexw6zE/48ysXVfpL0XtB1w/POzuT2+7zFxAzQ08Iye8RTA366GfYAAC54ZcLzSxEHFcbpxqEd8E7qQIya+T43kEMW1z/ypo0FOiNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034092; c=relaxed/simple;
	bh=F6i2AT0JaGRG4i13mHV8/t0QYkoNRcB+biePBczZ3QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIlBbz+RAbZoXY+t48iXBd4SdrwqGHrxNdS82LlvFKJLM0+9XSPHm82ghYvb6pKvDNjHkR1mkE6z//mb0cE1REUiO9dp2Ejty4NuezXDCq3TBGV2X1COCX2yA1DbAAhm9rzjI25PGuYjrktFc/Ihctyg7f8tImgZ2Xa2FNiqDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjgkADBR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjgkADBR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so584280a12.0
        for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779034090; x=1779638890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewb/vcCAW4T3qYCqoZidr6uNqEhYqfHVueO6BxP2CYE=;
        b=OjgkADBRGfY1eMYvJ2DoGSPX+igHXXoYE2E01+uCECxSg1Mu/5cd9zVwDULOfS+LHK
         heFUx3MwgcQlICZ5EQJ5GXPlHSKMOybCjj3mBaMMDg0wNAt1jsq6vSRYyJQBOEjius9z
         Se82I4BjZLpigjGbbK4Mq8T2m2uTuk/hXVqFQXgIQkMLVHdQXDmodz0Np0wlWNmhUj9r
         5wUCQl+V2p4Go9oaKqqa7dvImGcJrUkbYwqzoiXhB/nT1G518VONF0iIMHeYRZ5Kr+ZN
         FVUnahbYQc4+oQ+ZfVYune1Q88INbgMcHBXDMTteKOe4HleWRzLZ3fzyIbrp2uY5CnI3
         LUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779034090; x=1779638890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewb/vcCAW4T3qYCqoZidr6uNqEhYqfHVueO6BxP2CYE=;
        b=MP0LSw9c7Fml/fgUt39BKPJRVrgGIHfgwr0XjnJONaPcE3j7kshL8qZ1turi/4Qxf7
         NYyyo0UID0PcWVxnD+H5lLcC2ZPb8kulYdK7Wr9awhnYzFHFvgxnI2rRQ/qE/0aQH2ZI
         BGHt432im+ak0XwgoUwcb0yIru0aUWBo3o6/stXhdUxNq/UzTdKNUm1/a10W/UnRB9g+
         6JRck/543zPm8FhwFoJYaaCU5133tf6yVsJWFFsym+Fd7coviGn18xuWbIW36QVpICYl
         C3xMDxBeToSE8Dm+v3/+sbNfr6ARtXbLt8GoU9utjWq4IZZRLzBXfAd1VHwnGog44C3l
         Ei+g==
X-Gm-Message-State: AOJu0Yw2nmh4T9OAaTEpJvIHDY+nwIqSead7EQRINz8kwZbjZMmdAo4d
	lUDhX5VYCcvLKq+oazpObMT8+JsiZVRChW2JJ5Ilv59NT4Q9urzuLZea
X-Gm-Gg: Acq92OEM13Cd8/ZRWFVKfu2D56Th3iX5z2liCzJ2cVPHK2iJ5UHnxWyO1JQhaPHXqiW
	AT6NyIVkvOOombIsI194MXWMMkLUeeqt4fk9Ba3wwfJoWdjkxFAZ0cfZ3OH97nOx1zxypj4d4mm
	MOHKbLl1Eie6YBtqjaPUnLHQ9kWX/tO4E6DcG9+Xqz/oDbwQkyhxiWYGcoi+qtU6w6WDFis3xLH
	NTqapwVOJKrjU1TIAlkDxVfb5/B4UHXotewP/HYEY/prAXTcODuJiWx7USHv8CEcPqMY9ym+xBx
	Th4fRJggWuu1iE3Z/KtdL0SEhfX5WlcqrYhZi1wPTlHYR9jtTJDUCM9GZ75juuawnuPxvzr47GC
	eOfbeK9W3o2wVF3qN6KaQg+MIkj/HpxH7/RGNn1ildHAnXQ9eyOdJePr9WxOVo+K42CUxQ14EIe
	FdHvApp0lGD67lJtB/P52slkEq3Y0EYM7m5ncD3AYO2CF+ApuVqvE=
X-Received: by 2002:a05:6a21:600d:b0:3b2:6988:a6f5 with SMTP id adf61e73a8af0-3b26988d373mr4729331637.4.1779034089762;
        Sun, 17 May 2026 09:08:09 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:43af:54c2:876:4f0f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82da93df0dsm4586076a12.19.2026.05.17.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:08:08 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: yphbchou0911@gmail.com
Cc: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: [PATCH v2 3/3] selftests/sched_ext: Add dispatch_cookie test
Date: Mon, 18 May 2026 00:07:42 +0800
Message-ID: <20260517160742.935859-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260515172807.254804-4-yphbchou0911@gmail.com>
References: <20260515172807.254804-4-yphbchou0911@gmail.com>
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
After a successful dispatch, the token is stored in a BPF hash map. On
the task's next dispatch (after dequeue/re-enqueue increments qseq), the
stored token is stale and finish_dispatch() silently drops the buffered
entry; a fallback scx_bpf_dsq_insert() then dispatches the task.

Userspace forks spinning children and repeatedly flips their CPU affinity
to the first online CPU and back, triggering dequeue/re-enqueue cycles.
The test asserts that both nr_tx_dispatched (fresh commits) and
nr_tx_stale (attempted stale commits) are positive, exercising both the
happy path and the stale-token path. The test skips on kernels that
predate the dispatch transaction API.

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Assign *ctx = tctx early and initialize skel = NULL before failure paths
- Add NULL guard in cleanup() to prevent NULL-deref on failed setup()

 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 120 ++++++++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 135 ++++++++++++++++++
 3 files changed, 256 insertions(+)
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
index 000000000000..160a77ed9000
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit().
+ *
+ * Exercises both the happy path (fresh token committed successfully) and
+ * the stale-token path (stored token reused after the task was dequeued and
+ * re-enqueued, incrementing qseq and making the token stale).
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
+	 * Tasks pinned to a different CPU (e.g. per-CPU kworkers) cannot be
+	 * inserted into this CPU's local DSQ. Skip the transaction path and
+	 * fall back to the global DSQ so the scheduler does not abort.
+	 */
+	if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+		return;
+	}
+
+	/*
+	 * After a successful fresh dispatch, store the token. On the task's
+	 * next dispatch (after re-enqueue increments qseq), the stored token
+	 * exercises the stale path in finish_dispatch().
+	 *
+	 * scx_bpf_dsq_insert_commit() always returns %true when the preamble
+	 * passes; stale detection fires asynchronously in finish_dispatch()
+	 * with no BPF-observable signal. Always pair the commit() call with a
+	 * fallback scx_bpf_dsq_insert(): if the token is stale,
+	 * finish_dispatch() drops the buffered entry and the fallback
+	 * dispatches the task. If the token is still fresh, finish_dispatch()
+	 * dispatches it and the fallback's CAS is a no-op.
+	 */
+	struct scx_bpf_dsq_insert_commit_args commit_args = {
+		.dsq_id		= SCX_DSQ_LOCAL,
+		.slice		= 0,
+		.enq_flags	= 0,
+	};
+
+	stored = bpf_map_lookup_elem(&last_token, &pid);
+	if (stored) {
+		token = *stored;
+		bpf_map_delete_elem(&last_token, &pid);
+		scx_bpf_dsq_insert_commit(p, &commit_args, token);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+		/* counts attempted stale commits, not finish_dispatch() rejections */
+		__sync_fetch_and_add(&nr_tx_stale, 1);
+	} else {
+		token = scx_bpf_dsq_insert_begin(p);
+		if (scx_bpf_dsq_insert_commit(p, &commit_args, token)) {
+			__sync_fetch_and_add(&nr_tx_dispatched, 1);
+			bpf_map_update_elem(&last_token, &pid, &token, BPF_ANY);
+		} else {
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
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
index 000000000000..89e6ad6d6a79
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c
@@ -0,0 +1,135 @@
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
+	tctx->skel = NULL;
+	tctx->link = NULL;
+	*ctx = tctx;
+
+	tctx->skel = dispatch_cookie__open();
+	SCX_FAIL_IF(!tctx->skel, "Failed to open skel");
+
+	SCX_ENUM_INIT(tctx->skel);
+	SCX_FAIL_IF(dispatch_cookie__load(tctx->skel), "Failed to load skel");
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dispatch_cookie_ctx *tctx = ctx;
+	cpu_set_t cpuset_one, cpuset_all;
+	pid_t pids[NUM_CHILDREN];
+	int i, j, nforked = 0, status, first_cpu;
+
+	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.dispatch_cookie_ops);
+	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
+
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(cpuset_all), &cpuset_all),
+		    "Failed to get CPU affinity (%d)", errno);
+
+	first_cpu = -1;
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, &cpuset_all)) {
+			first_cpu = i;
+			break;
+		}
+	}
+	SCX_FAIL_IF(first_cpu < 0, "No online CPUs found");
+
+	CPU_ZERO(&cpuset_one);
+	CPU_SET(first_cpu, &cpuset_one);
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
+			sched_setaffinity(pids[j], sizeof(cpuset_one), &cpuset_one);
+			sched_setaffinity(pids[j], sizeof(cpuset_all), &cpuset_all);
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
+	if (!tctx)
+		return;
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

