Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2124EFFBA
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698657; cv=none; b=HZT1Ui8ypl29BjvFzaeNIcf1ED8N/pv+/OeJyUPV+dIZbalDtcySl9wo8/ld3J8WxzMmmPs8EqlIGtJp4niIyn4YIEBbzLVHuVj5sOzuY6QksM0eeKIb36XBUJmjqt7e0KsrGgNTbI82Di9a+7EzubmJ0OIXAgAgBq4IcLSbT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698657; c=relaxed/simple;
	bh=rt5YRvbAqGURsZ4DktKgp1mWIOSt+0oRilK3WZictCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rhy34To/CVaQlHWV2uE6LOSz+JscfmSypoJtLDZhdTb+Xbl0UU4GLN+41DsJVXr20m+WotGwDolaIRWybJwNs/rxR2L4GZQo5ScFXZpLyEuPGRwdjEJWMAfjnPNHUt0ftPyMMgb4JDCGCneVh6EJYu5cVGtY7fae4i8oWlzjuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXEkySMC; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXEkySMC"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e661c6440so30467375e9.3
        for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790698653; x=1791303453; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6GhGKtQ1OB/3rGVwYvFrC1Ll2W1rr/LyOU1fT6hVHk=;
        b=IXEkySMC4AQF+GF51JxC34hl5brhGg9aBnXhAO6EhhFj0A7ayFqDnV+8ol+4DrvwDs
         QMcj2LFPhpJ56IF1U4BGzvtN/IuNymDGSWDHQZnEd+/0Vhj9zSvOixjvXQVo3N//ZSHa
         Mkj2+is6HQx0JLrUFdrpG1FR6+cyMpo3QOK2t2vEL03UFqAQgSyI9El9vXgxFKeJ2aTn
         vZPchX79nuMRYtAQlG7K4uMQ43rjMxLm4axxzS37x6bVTPw7kaNBqLekThb5RU54ZgEd
         dVVfYqIF3qH8wvLHxXGMZb5cVUwMSshe844a2j70SEy+Y9pr/B/00C84uYkxH3rXI+yJ
         zuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698653; x=1791303453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6GhGKtQ1OB/3rGVwYvFrC1Ll2W1rr/LyOU1fT6hVHk=;
        b=OEHfp2a62TWa2W11LhLjvQ+IaH1svwOMs54icojkh1J2vvMcvl4BLI3VysE8WeM1+e
         BmB3VD3AnUi7LsXUIujHD8WakyJW01+mTni9P3PF/AtlISX7LttjbqeY848oGDHdxaqu
         65wrh0ciOJz2Nl0nclpgleirYcbHKWKTW9lw4lp75cuaWh84b5bByJ/KHbDtSYaQZboD
         z7+9ROG0ZtMj79bm3p8e9IeCNRPoU0WwQXbTlVFXzff9B9PeAlbrR0nLeRfm3qaS8MM6
         LOB+Wi8Y7p8vFtc8cG7KcDnT2JKdbHfRPTJaKEkk4rPFIXqiaMuqkAk7cp66Zr/lk5Tt
         3kYw==
X-Forwarded-Encrypted: i=1; AKwUvBwA65wxiTAveATTg197oqFaDZsql+ZoGgukBHW+ITLanxnO34+NRtQYmGN3qAB4demP0aVZrkCu7VI=@lists.linux.dev
X-Gm-Message-State: AFuF++mEmMYotnAX9BnF682c8LhvdWa1O1EyyptN9TS/u0fFXjCVpl3I
	XVObRLFnrKgyGq+AUoZcNhLm07/dn71qNgo3IQlMd0MUdgs/hnbnJumt2tf0JiLU1Cfcv4CsWqN
	eoPHygJL3NGWQMg==
X-Received: from wmpj2.prod.google.com ([2002:a05:600c:4882:b0:49e:6d54:4412])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314a:b0:49e:6778:c2bd with SMTP id 5b1f17b1804b1-49fe66c86bcmr310454505e9.6.1790698652749;
 Tue, 29 Sep 2026 09:17:32 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:17:24 +0000
In-Reply-To: <20260929161730.185271-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929161730.185271-2-jpiecuch@google.com>
Subject: [PATCH 1/3] selftests/sched_ext: Add a test for ops.dequeue() on
 remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a BPF scheduler moves a task that is in its custody to the local DSQ
of a CPU other than the one whose rq the task is on, sched_ext migrates the
task with move_remote_task_to_local_dsq(). The task leaves the BPF
scheduler's custody when it is inserted into the destination local DSQ and
ops.dequeue() should be called at that point, just like for same-rq
dispatches.

Add a dequeue_remote test that exercises this path. All tasks are put
into custody from ops.enqueue() and moved to the local DSQ of whichever
CPU runs ops.dispatch(), so that most moves cross CPUs. Two variants are
covered, selected by test_use_move_to_local:

 - false: tasks are queued in a BPF queue and dispatched with
   scx_bpf_dsq_insert(SCX_DSQ_LOCAL_ON | cpu), going through
   dispatch_to_local_dsq(),

 - true: tasks are queued on a user DSQ and consumed with
   scx_bpf_dsq_move_to_local(), going through consume_remote_task().

The BPF scheduler tracks each task's custody state and triggers
scx_bpf_error() if:

 - ops.dequeue() is called with SCX_DEQ_CORE_SCHED_EXEC, meaning that
   the custody exit was missed on insertion into the local DSQ and
   deferred to set_next_task_scx(),

 - a task starts running without ops.dequeue() having been called since
   its last ops.enqueue(),

 - ops.dequeue() is called for a task that isn't in custody, or
   ops.enqueue() for a task that is.

Core scheduling can legitimately pick tasks straight out of custody, so
the test is skipped if any task has a core scheduling cookie when it
starts.

The test currently fails:

  sched_ext: dequeue_remote: dequeue_remote.bpf.c:143: 156 (runner): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=1 cpu=3 seq=1)
     ...
     ops_dequeue+0x114/0x170
     set_next_task_scx+0x104/0x1e0
     __pick_next_task+0xc7/0x180
     __schedule+0x154/0x1870

so don't add it to auto-test-targets yet. It will be enabled once the
underlying bug is fixed.

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 .../selftests/sched_ext/dequeue_remote.bpf.c  | 272 ++++++++++++++++++
 .../selftests/sched_ext/dequeue_remote.c      | 243 ++++++++++++++++
 2 files changed, 515 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.c

diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
new file mode 100644
index 000000000000..4da428116ee4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that ops.dequeue() is called when a task leaves the BPF
+ * scheduler's custody through an SCX-internal cross-CPU migration, i.e.
+ * when the task is moved to the local DSQ of a CPU other than the one
+ * whose rq it is currently on (move_remote_task_to_local_dsq()).
+ *
+ * Every task is put into BPF custody from ops.enqueue() and later moved to
+ * a local DSQ from ops.dispatch() running on an arbitrary CPU, which makes
+ * remote moves very frequent. Depending on @test_use_move_to_local, tasks
+ * are either:
+ *
+ * - false: queued in a BPF queue and dispatched with
+ *   scx_bpf_dsq_insert(SCX_DSQ_LOCAL_ON | cpu) (dispatch_to_local_dsq()),
+ * - true: queued on a user DSQ and consumed with
+ *   scx_bpf_dsq_move_to_local() (consume_remote_task()).
+ *
+ * A task can only start running from a local DSQ, i.e. after it has left
+ * custody. So by the time ops.running() is invoked, ops.dequeue() must have
+ * been called for the preceding ops.enqueue(). Moreover, as core scheduling
+ * isn't in use (the test is skipped otherwise), that ops.dequeue() must
+ * happen when the task is inserted into the local DSQ, not later when it's
+ * picked for execution, which would be reported with
+ * %SCX_DEQ_CORE_SCHED_EXEC.
+ *
+ * Copyright (c) 2026 Google LLC.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32768);
+	__type(value, s32);
+} global_queue SEC(".maps");
+
+enum task_state {
+	TASK_NONE = 0,
+	TASK_ENQUEUED,		/* in BPF custody, waiting for ops.dequeue() */
+	TASK_DISPATCHED,	/* left custody */
+};
+
+struct task_ctx {
+	enum task_state state;
+	s32 enq_cpu;		/* scx_bpf_task_cpu() at ops.enqueue() */
+	u64 enqueue_seq;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+bool test_use_move_to_local;
+
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+u64 remote_dispatch_cnt, remote_running_cnt, missed_dequeue_cnt;
+u64 core_sched_exec_dequeue_cnt;
+
+static struct task_ctx *lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_remote_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* No direct dispatch: always go through ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_remote_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	s32 pid = p->pid;
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	/*
+	 * Every task that entered custody must have received ops.dequeue()
+	 * before it can be enqueued again.
+	 */
+	if (tctx->state == TASK_ENQUEUED)
+		scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
+			      p->pid, p->comm, tctx->enqueue_seq);
+
+	/*
+	 * Mark @p as enqueued before making it visible to ops.dispatch() on
+	 * other CPUs, which skips queue entries of tasks not in ENQUEUED
+	 * state as stale.
+	 */
+	tctx->state = TASK_ENQUEUED;
+	tctx->enq_cpu = scx_bpf_task_cpu(p);
+	tctx->enqueue_seq++;
+
+	if (test_use_move_to_local) {
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+	} else if (bpf_map_push_elem(&global_queue, &pid, 0)) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		tctx->state = TASK_DISPATCHED;
+		tctx->enq_cpu = -1;
+		goto out;
+	}
+
+	__sync_fetch_and_add(&enqueue_cnt, 1);
+out:
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(dequeue_remote_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * The test doesn't run when core scheduling is in use, so no task can
+	 * be picked for execution before being dispatched to a local DSQ. A
+	 * %SCX_DEQ_CORE_SCHED_EXEC dequeue means that the task reached a
+	 * local DSQ without leaving custody (no ops.dequeue() on arrival)
+	 * and the custody exit was deferred to set_next_task_scx().
+	 */
+	if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) {
+		__sync_fetch_and_add(&core_sched_exec_dequeue_cnt, 1);
+		scx_bpf_error("%d (%s): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=%d cpu=%d seq=%llu)",
+			      p->pid, p->comm, tctx->enq_cpu,
+			      scx_bpf_task_cpu(p), tctx->enqueue_seq);
+	}
+
+	/*
+	 * ops.dequeue() is called exactly once per custody period, which
+	 * starts with ops.enqueue(). Whatever the reason, @p must be in
+	 * ENQUEUED state. In particular, NONE is only entered through a
+	 * property change dequeue, which ends custody.
+	 */
+	if (tctx->state != TASK_ENQUEUED)
+		scx_bpf_error("%d (%s): dequeue outside custody deq_flags=0x%llx state=%d seq=%llu",
+			      p->pid, p->comm, deq_flags, tctx->state,
+			      tctx->enqueue_seq);
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+		tctx->state = TASK_NONE;
+	} else {
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_remote_dispatch, s32 cpu, struct task_struct *prev)
+{
+	struct task_ctx *tctx;
+	struct task_struct *p;
+	s32 pid;
+
+	if (test_use_move_to_local) {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
+		return;
+	}
+
+	if (bpf_map_pop_elem(&global_queue, &pid))
+		return;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return;
+
+	/*
+	 * Skip stale entries: tasks that left custody through a property
+	 * change dequeue (state NONE) or that were already dispatched from
+	 * a duplicate queue entry.
+	 */
+	tctx = lookup_task_ctx(p);
+	if (!tctx || tctx->state != TASK_ENQUEUED) {
+		bpf_task_release(p);
+		return;
+	}
+
+	/*
+	 * Move the task to this CPU's local DSQ. The task sits on the rq of
+	 * the CPU it was enqueued on, so this is a remote move whenever
+	 * that CPU differs from @cpu.
+	 */
+	if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+		if (scx_bpf_task_cpu(p) != cpu)
+			__sync_fetch_and_add(&remote_dispatch_cnt, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+	} else {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	}
+
+	bpf_task_release(p);
+}
+
+void BPF_STRUCT_OPS(dequeue_remote_running, struct task_struct *p)
+{
+	struct task_ctx *tctx;
+
+	tctx = lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	if (tctx->state == TASK_ENQUEUED) {
+		/* Running from a local DSQ without having left custody */
+		__sync_fetch_and_add(&missed_dequeue_cnt, 1);
+		scx_bpf_error("%d (%s): running without ops.dequeue() (enq_cpu=%d cpu=%d seq=%llu)",
+			      p->pid, p->comm, tctx->enq_cpu,
+			      scx_bpf_task_cpu(p), tctx->enqueue_seq);
+		return;
+	}
+
+	if (tctx->enq_cpu >= 0 && tctx->enq_cpu != scx_bpf_task_cpu(p))
+		__sync_fetch_and_add(&remote_running_cnt, 1);
+	tctx->enq_cpu = -1;
+}
+
+s32 BPF_STRUCT_OPS(dequeue_remote_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	/* task storage persists across attachments, start from scratch */
+	tctx->state = TASK_NONE;
+	tctx->enq_cpu = -1;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_remote_init)
+{
+	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+}
+
+void BPF_STRUCT_OPS(dequeue_remote_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_remote_ops = {
+	.select_cpu		= (void *)dequeue_remote_select_cpu,
+	.enqueue		= (void *)dequeue_remote_enqueue,
+	.dequeue		= (void *)dequeue_remote_dequeue,
+	.dispatch		= (void *)dequeue_remote_dispatch,
+	.running		= (void *)dequeue_remote_running,
+	.init_task		= (void *)dequeue_remote_init_task,
+	.init			= (void *)dequeue_remote_init,
+	.exit			= (void *)dequeue_remote_exit,
+	.flags			= SCX_OPS_ENQ_LAST,
+	.name			= "dequeue_remote",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/testing/selftests/sched_ext/dequeue_remote.c
new file mode 100644
index 000000000000..ab42ac694ac6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that ops.dequeue() is called for tasks leaving BPF custody through
+ * an SCX-internal cross-CPU migration (move_remote_task_to_local_dsq()).
+ *
+ * Copyright (c) 2026 Google LLC.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <sched.h>
+#include <ctype.h>
+#include <dirent.h>
+#include <sys/prctl.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include "scx_test.h"
+#include "dequeue_remote.bpf.skel.h"
+
+#define MAX_WORKERS	64
+#define RUN_MS		2000
+
+static long long now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000LL + ts.tv_nsec / 1000000;
+}
+
+static int get_core_cookie(pid_t tid, unsigned long *cookie)
+{
+	return prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tid,
+		     PR_SCHED_CORE_SCOPE_THREAD, (unsigned long)cookie);
+}
+
+/*
+ * Core scheduling is in use iff some task has a core scheduling cookie. If
+ * none does now, assume that none will get one for the duration of the test.
+ */
+static bool core_sched_in_use(void)
+{
+	unsigned long cookie;
+	struct dirent *pde, *tde;
+	bool in_use = false;
+	DIR *proc, *task;
+	char path[sizeof("/proc//task") + sizeof(pde->d_name)];
+
+	/* fails with EINVAL if !CONFIG_SCHED_CORE and ENODEV if SMT is off */
+	if (get_core_cookie(0, &cookie))
+		return false;
+
+	proc = opendir("/proc");
+	if (!proc)
+		return false;
+
+	while (!in_use && (pde = readdir(proc))) {
+		if (!isdigit(pde->d_name[0]))
+			continue;
+
+		snprintf(path, sizeof(path), "/proc/%s/task", pde->d_name);
+		task = opendir(path);
+		if (!task)
+			continue;
+
+		/* errors, e.g. ESRCH for exited tasks, are ignored */
+		while (!in_use && (tde = readdir(task))) {
+			if (isdigit(tde->d_name[0]) &&
+			    !get_core_cookie(atoi(tde->d_name), &cookie))
+				in_use = cookie;
+		}
+
+		closedir(task);
+	}
+
+	closedir(proc);
+	return in_use;
+}
+
+/* Mix of short bursts and sleeps to generate lots of enqueues and wakeups */
+static void worker_fn(int id)
+{
+	long long end = now_ms() + RUN_MS;
+	volatile unsigned long sum = 0;
+
+	while (now_ms() < end) {
+		unsigned long j;
+
+		for (j = 0; j < 20000 + id * 1000; j++)
+			sum += j;
+		if (id & 1)
+			usleep(100);
+		else
+			sched_yield();
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue_remote *skel,
+					 bool use_move_to_local,
+					 const char *name)
+{
+	struct bpf_link *link;
+	pid_t pids[MAX_WORKERS];
+	int nr_workers, i, status;
+	u64 enq, deq, dsp_deq, chg_deq, remote_dsp, remote_run;
+
+	nr_workers = 2 * sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_workers < 4)
+		nr_workers = 4;
+	if (nr_workers > MAX_WORKERS)
+		nr_workers = MAX_WORKERS;
+
+	skel->bss->test_use_move_to_local = use_move_to_local;
+	enq = skel->bss->enqueue_cnt;
+	deq = skel->bss->dequeue_cnt;
+	dsp_deq = skel->bss->dispatch_dequeue_cnt;
+	chg_deq = skel->bss->change_dequeue_cnt;
+	remote_dsp = skel->bss->remote_dispatch_cnt;
+	remote_run = skel->bss->remote_running_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_remote_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for %s", name);
+
+	fflush(stdout);
+	fflush(stderr);
+
+	for (i = 0; i < nr_workers; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+		if (pids[i] == 0)
+			worker_fn(i);
+	}
+
+	for (i = 0; i < nr_workers; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	enq = skel->bss->enqueue_cnt - enq;
+	deq = skel->bss->dequeue_cnt - deq;
+	dsp_deq = skel->bss->dispatch_dequeue_cnt - dsp_deq;
+	chg_deq = skel->bss->change_dequeue_cnt - chg_deq;
+	remote_dsp = skel->bss->remote_dispatch_cnt - remote_dsp;
+	remote_run = skel->bss->remote_running_cnt - remote_run;
+
+	printf("%s:\n", name);
+	printf("  workers: %d\n", nr_workers);
+	printf("  enqueues: %lu\n", (unsigned long)enq);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq, (unsigned long)dsp_deq,
+	       (unsigned long)chg_deq);
+	if (!use_move_to_local)
+		printf("  remote SCX_DSQ_LOCAL_ON dispatches: %lu\n",
+		       (unsigned long)remote_dsp);
+	printf("  ran on a CPU other than the enqueue CPU: %lu\n",
+	       (unsigned long)remote_run);
+	printf("  ran without ops.dequeue(): %lu\n",
+	       (unsigned long)skel->bss->missed_dequeue_cnt);
+	printf("  late SCX_DEQ_CORE_SCHED_EXEC dequeues: %lu\n",
+	       (unsigned long)skel->bss->core_sched_exec_dequeue_cnt);
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_UNREG))
+		SCX_ERR("Scheduler exited with kind=%lld: %s",
+			(long long)skel->data->uei.kind, skel->data->uei.msg);
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* the test is meaningless if no task was moved across CPUs */
+	SCX_GT(remote_run, 0);
+	SCX_EQ(enq, deq);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue_remote *skel;
+
+	if (sysconf(_SC_NPROCESSORS_ONLN) < 2) {
+		fprintf(stderr, "Skipping: requires at least 2 CPUs\n");
+		return SCX_TEST_SKIP;
+	}
+
+	/*
+	 * Core scheduling can legitimately pick tasks straight out of BPF
+	 * custody, which the test would flag as late
+	 * %SCX_DEQ_CORE_SCHED_EXEC dequeues.
+	 */
+	if (core_sched_in_use()) {
+		fprintf(stderr, "Skipping: core scheduling is in use\n");
+		return SCX_TEST_SKIP;
+	}
+
+	skel = SCX_OPS_OPEN(dequeue_remote_ops, dequeue_remote);
+	SCX_OPS_LOAD(skel, dequeue_remote_ops, dequeue_remote, uei);
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue_remote *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, false,
+			      "BPF queue -> SCX_DSQ_LOCAL_ON | cpu");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, true,
+			      "user DSQ -> scx_bpf_dsq_move_to_local()");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue_remote *skel = ctx;
+
+	dequeue_remote__destroy(skel);
+}
+
+struct scx_test dequeue_remote_test = {
+	.name = "dequeue_remote",
+	.description = "Verify ops.dequeue() on SCX-internal cross-CPU migrations",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_remote_test)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

