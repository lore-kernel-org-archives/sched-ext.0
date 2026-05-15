Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055F2F7EE5
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866104; cv=none; b=ocIluP3CKvzbiu9u7gpx8B1/s0D7HQHKu9ELLnYKAgSBW7z2bXESR7kHyvP5s2rs/LDW9Lre9Xa/hcFCwT+qwjJydyjt2rTFCr9ZmkoK1I89K7HUkH3NNiA0GMX9smjf0ZI0iTjvbXQr0IvjVbUs65lqo7FBAgmQ9K1xBQYQl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866104; c=relaxed/simple;
	bh=0E9IvA+11uE6+mWKNaFVOqWX7eF+pNiz/qQFk7rsaho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXDq69tWmawpevfx+XpLKo+8peO28Cwp0EtlO0cQW288HZjjYnWeEjvVtCenBXjjsUQw0GkXj+fYbXMTp24YxYWAivIhcanzyeDpqyyBCALSldfslwkcQ7299XYsgFapr70nE06DM2rpsFJWUEof5t30z0W9Q7oRMPECjDwBp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGYZN/jl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGYZN/jl"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f8b60e485so60159b3a.0
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866102; x=1779470902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc6kO7ZIhw+ZXN3nmKWmP2NmmGCMHsftS43kwquBE/Y=;
        b=bGYZN/jln/rXAYZsMAZ1+92GSkWRZS9m7vp0utoXNclJdmDl97uLnm0LWzFOAGYed3
         x2bo7e+HzS/8IdepI/EyXMhjhY8Q+J+/+zOYrTc6DN72ukwxQIwO8jPzXIzWvj2/8q8g
         ccrk21pYMmMK8v2G413YlQ4XixfwrfCk75Ia/pm5ir5x6Z+ypxuhr0ho7jfap1NghKCv
         nHFyN+5fU7xxQXwP+LYom7oAoiE+Ti5kUj7Lo5ZMF7EabiLVnawtUeYAA+bayVJG2JzG
         PzxHsKP90orV25/T3tkK+vNVnKCQGsj3+aYvSiyprhw3TAk9G7bKDkqtZbKUIAAAGvHB
         2zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866102; x=1779470902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mc6kO7ZIhw+ZXN3nmKWmP2NmmGCMHsftS43kwquBE/Y=;
        b=XbQ9Inyxab/JRAetr+Rr5f90kR0FM3E/KrCwPYM6zvKCJQf0zy+j2smj3yKR5Fh5vg
         X2Z8acn99OnsvRkTJdi6NurAPv0/tIE0l8zsqJYnrkshhjuHUqulQJPvFlhVGMG4s7sB
         2/iYEb0FjQOz9QnDS0Wlb64hVMNCUz6JC92sAM+n37VR7/uH5XLyJgtnxZtL+zAz9n6E
         Y/Co50CYjx7h1IbS90/9DfZAkLlISxXbJcZ63zUlnxGfzNokEUL4HmakeZHo+zedvOiV
         uz+AvcaRY/CL62AJnUk5QtEg98vQYfmY6KN0kzVvpm9xDvgJ7bqUEOspZFBQTRSauq22
         DBsQ==
X-Gm-Message-State: AOJu0Yw1/d5a7RHMh1vioV9omPQjMfIxxGG9Xaf7rYFHoFNmKEp9H/Rf
	NKk0Fnjl1XqGba8zZrPH+yYTp0pL6z6at/OS3R+Y5e2HxQnq5Wd2ynVmiVUU8A==
X-Gm-Gg: Acq92OFlJGn3jHibyDvNHcmgJV6fTUcBpRHMVJPBt9e9HwC6s0C9btZ6UXmhL7N+ov+
	bHk0v+Ea4ad4ctNnFuiE9Du6Qb5jYqlm9plzLzMWzoSdc+YosL+tPESBN6Ry2KM/FrSl75LBEIM
	z84csmZYcijk5Sm4Eezh4keA1RM3IF5udoU9R0A4L0IF38hYfDU/6y/BcXNxQmTBFOAb2Ke7kS6
	Bl3/wMx+knJTKgt9HWaB8NCg6maHp/kZIU6f7EfgouAqdbW58IYhUfvt8L4zgfLePERmzmY1zG9
	RuD68TZhR1Cx9wH0i9Rx5M+B+eVNMCA5lkpdQ41Jye/XQhb882Oo1TV0i3E/kHVcxab/LB8fzUM
	nfNrxLd0tGud/NUpbAEMxWfnXmQXBtxtagQk0hcvyFxyuntokqocvU69/UIDu6VTyBidMmU7Ojy
	EwCPdHy8+yhdFmNElXD4aEjztc2eae57XHUNJcGJp5fInnwGgcOC7uiiYujUkPOR8=
X-Received: by 2002:a05:6a00:e87:b0:82f:70a7:4a25 with SMTP id d2e1a72fcca58-83f33d639e2mr5635453b3a.35.1778866101928;
        Fri, 15 May 2026 10:28:21 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:9584:f97f:cff9:ff7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b71fsm5973035b3a.29.2026.05.15.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:28:21 -0700 (PDT)
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
Subject: [PATCH 3/3] selftests/sched_ext: Add dispatch_cookie test
Date: Sat, 16 May 2026 01:27:41 +0800
Message-ID: <20260515172807.254804-4-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260515172807.254804-1-yphbchou0911@gmail.com>
References: <20260515172807.254804-1-yphbchou0911@gmail.com>
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
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 120 +++++++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 139 ++++++++++++++++++
 3 files changed, 260 insertions(+)
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
index 000000000000..047d9ea1822b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c
@@ -0,0 +1,139 @@
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

