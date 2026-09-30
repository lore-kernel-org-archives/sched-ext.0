Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BF49A3C4
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768852; cv=none; b=qNnLE6oi8hGyZk7NJ1bcjwc8j77UsOAtnC3KDsiffRQ61oIhvbDQc+zlX9/Kjednpuy48Y9tw7VH3dIGtZcxBtrCWCr6ogr+CYT6q0wADcVt/NHXEPMd5LAQghncGUEBR+Fc+iDBDOMoHcFvJqio1LYUWNck1ZPj+WBqMc1a4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768852; c=relaxed/simple;
	bh=1lCMpdVbhhFMkz8/73emLNGu0dXMYnSiVduT5MaB1N0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eB2GZ+PZVS0MEwKerLMwh95UnfQXhWGojF+VCYbzzuUOmeL9ogdTrIxgdtC+1OdfJcKjlfvZDotmCNmmMUi3p10nQ1Ff82bJCBRzyOWf1HCUhxB42J2jDo+84tyuQEewb+eKyTOaCKcB4e+NVGwfsQ0POBVkDzLZIa29BgOWMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/lV1YaR; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/lV1YaR"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49fcd86b8d3so45494785e9.3
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790768848; x=1791373648; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAWIKfukzaeNGvOmI8DxKa3twzwxWV2LFW8U4DwENrQ=;
        b=L/lV1YaRleX88E0wilcM+JkFZVQNoU3QPDcBuZyBGSRcJP32S9gMBZLBZY0uE4brBH
         cQbMmqJRzTslaLU/4nHGZ45LsGGQVTcJq4bkuj++tncPGnaeTUXR8ty2vb2InYoET8Qs
         eXS0q+w50MaeXfDWcupPMAOKnjUavQ2Hx1DX4ne0cADlr1aXhl95/wCVqYlIEKp/OEks
         ZpDYzSF6INz0zImSPpbXuy/HZ7Nl133qP2KHZsrVnf0sCBry3oUwfRQr7ONyA8lkDgYn
         r1YJPVuCKg3IYdl7aWkR2p5Xd+6vOsVzhdYpZCvOObsD4CY6rdSLXR3OFFLZ8ZekmUxF
         m2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768848; x=1791373648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAWIKfukzaeNGvOmI8DxKa3twzwxWV2LFW8U4DwENrQ=;
        b=gpzBGTCQAPjjUYwN0FsFXbSMNBB62sWiCn9B90zyTkJJnwAyPsONI4mgq2BOGf3LFM
         wxl/w/SCGFnUNlJPNfwht7stKuf4v7fqMKKOAVIwrGHZuuUv2p58tSGUF40AcyQIKwbV
         zBsf88snwUQtlzC3lRPExItWJf0FptfQxNHWnJmTzPoo0XsPzSLUr+kNcojkrcLHWWp5
         Oc/dN2jX9VsMiXx35x3we2f2iZMg6BYjmBYpyu32OiPcfIt52Ye9XgSWb8riR45nsExs
         Drvqez0kVeAVlYyX9iG8NUyBisJHcgRa9L/XpAXZ2/Uxboso11rN95wT1T68tqNOvWtD
         GIZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxK88tb4XMUgI7xa+Ute/21NGApQOD9FmDfav126KkXY7p8yh6zXf7nXHqGV5m+VeWFFL8XNqpUlKk=@lists.linux.dev
X-Gm-Message-State: AFuF++mT9fc8fmu7y3HnEZim12cBfLUC23POXlbtN5UK29KQ0q5Jmmzw
	upfQMXCV4TkUEf6hi0j3Es1idTXx1tYjRMKPeShlaC7Uzf0S0vRbRyp1gUsUEgS7i/MFnXZA4qm
	nN/2hXMSNf3h4Bg==
X-Received: from wmpu38.prod.google.com ([2002:a05:600c:4d26:b0:4a0:1e1:5dde])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c11:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-4a01afff3dbmr24479315e9.18.1790768847902;
 Wed, 30 Sep 2026 04:47:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:47:23 +0000
In-Reply-To: <20260930114725.331370-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260930114725.331370-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930114725.331370-3-jpiecuch@google.com>
Subject: [PATCH v2 2/2] selftests/sched_ext: Add a test for ops.dequeue() on
 remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a dequeue_remote test that makes moves of tasks in the BPF
scheduler's custody to another CPU's local DSQ the common case, both via
SCX_DSQ_LOCAL_ON dispatch and via scx_bpf_dsq_move_to_local(). The BPF
scheduler tracks each task's custody state and triggers scx_bpf_error()
if a custody period doesn't end with exactly one ops.dequeue() before
the task runs, or if it ends with an SCX_DEQ_CORE_SCHED_EXEC dequeue of
a task without a core cookie.

Without the previous patch, the test fails with:

  sched_ext: dequeue_remote: dequeue_remote.bpf.c:141: 15 (rcu_preempt): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=3 cpu=2 seq=1)
     ...
     ops_dequeue+0x114/0x170
     set_next_task_scx+0x104/0x1e0
     __pick_next_task+0xc7/0x180
     __schedule+0x154/0x1870

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dequeue_remote.bpf.c  | 265 ++++++++++++++++++
 .../selftests/sched_ext/dequeue_remote.c      | 202 +++++++++++++
 3 files changed, 468 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 4e06d0baaeec..af919a56a4f4 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -165,6 +165,7 @@ auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
 	dequeue_iter			\
+	dequeue_remote			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
new file mode 100644
index 000000000000..55fc77a0de0b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that ops.dequeue() is called when a task leaves the BPF scheduler's
+ * custody by being moved to the local DSQ of a CPU other than the one whose
+ * rq it's on (move_remote_task_to_local_dsq()).
+ *
+ * ops.enqueue() puts every task into custody and ops.dispatch() moves it to
+ * the dispatching CPU's local DSQ, so most moves cross CPUs. With
+ * @test_use_move_to_local, tasks are queued on a user DSQ and consumed with
+ * scx_bpf_dsq_move_to_local(). Otherwise, they are queued in a BPF queue and
+ * dispatched with SCX_DSQ_LOCAL_ON.
+ *
+ * Copyright (c) 2026 Google LLC.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ		0
+#define MAX_DISPATCH_POPS	8
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
+/* core_cookie only exists with CONFIG_SCHED_CORE */
+struct task_struct___core_sched {
+	unsigned long core_cookie;
+} __attribute__((preserve_access_index));
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
+static bool task_has_core_cookie(struct task_struct *p)
+{
+	struct task_struct___core_sched *t = (void *)p;
+
+	if (!bpf_core_field_exists(t->core_cookie))
+		return false;
+	return BPF_CORE_READ(t, core_cookie);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_remote_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* no direct dispatch, always go through ops.enqueue() */
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
+	/* the previous custody period must have ended with ops.dequeue() */
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
+	 * Only core scheduling can pick a task straight out of custody, and
+	 * only if the task has a core cookie. Otherwise, the custody exit was
+	 * missed when @p was inserted into a local DSQ and got deferred until
+	 * @p was picked.
+	 */
+	if ((deq_flags & SCX_DEQ_CORE_SCHED_EXEC) && !task_has_core_cookie(p)) {
+		__sync_fetch_and_add(&core_sched_exec_dequeue_cnt, 1);
+		scx_bpf_error("%d (%s): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=%d cpu=%d seq=%llu)",
+			      p->pid, p->comm, tctx->enq_cpu,
+			      scx_bpf_task_cpu(p), tctx->enqueue_seq);
+	}
+
+	/* ops.dequeue() ends the custody period started by ops.enqueue() */
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
+	int i;
+
+	if (test_use_move_to_local) {
+		scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
+		return;
+	}
+
+	/* pop past stale entries so that they don't leave this CPU idle */
+	bpf_for(i, 0, MAX_DISPATCH_POPS) {
+		if (bpf_map_pop_elem(&global_queue, &pid))
+			return;
+
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			continue;
+
+		/*
+		 * Entries are stale if @p left custody through a property
+		 * change dequeue or was dispatched from a duplicate entry.
+		 */
+		tctx = lookup_task_ctx(p);
+		if (!tctx || tctx->state != TASK_ENQUEUED) {
+			bpf_task_release(p);
+			continue;
+		}
+
+		if (bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			if (scx_bpf_task_cpu(p) != cpu)
+				__sync_fetch_and_add(&remote_dispatch_cnt, 1);
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu,
+					   SCX_SLICE_DFL, 0);
+		} else {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		}
+
+		bpf_task_release(p);
+		return;
+	}
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
+	/* tasks can only run from a local DSQ, i.e. after leaving custody */
+	if (tctx->state == TASK_ENQUEUED) {
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
index 000000000000..0f03044a5bc6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
@@ -0,0 +1,202 @@
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
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include "scx_test.h"
+#include "dequeue_remote.bpf.skel.h"
+
+#define MAX_WORKERS	64
+#define RUN_MS		2000
+
+static int nr_cpus;
+
+static long long now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000LL + ts.tv_nsec / 1000000;
+}
+
+/* mix of short bursts and sleeps to generate lots of enqueues and wakeups */
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
+	enum scx_test_status ret = SCX_TEST_PASS;
+	struct bpf_link *link;
+	pid_t pids[MAX_WORKERS];
+	int nr_workers, nr_forked, i;
+
+	nr_workers = 2 * nr_cpus;
+	if (nr_workers < 4)
+		nr_workers = 4;
+	if (nr_workers > MAX_WORKERS)
+		nr_workers = MAX_WORKERS;
+
+	skel->bss->test_use_move_to_local = use_move_to_local;
+	skel->bss->enqueue_cnt = 0;
+	skel->bss->dequeue_cnt = 0;
+	skel->bss->dispatch_dequeue_cnt = 0;
+	skel->bss->change_dequeue_cnt = 0;
+	skel->bss->remote_dispatch_cnt = 0;
+	skel->bss->remote_running_cnt = 0;
+	skel->bss->missed_dequeue_cnt = 0;
+	skel->bss->core_sched_exec_dequeue_cnt = 0;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_remote_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for %s", name);
+
+	fflush(stdout);
+	fflush(stderr);
+
+	for (nr_forked = 0; nr_forked < nr_workers; nr_forked++) {
+		pid_t pid = fork();
+
+		if (pid < 0) {
+			SCX_ERR("Failed to fork worker %d", nr_forked);
+			ret = SCX_TEST_FAIL;
+			break;
+		}
+		if (pid == 0)
+			worker_fn(nr_forked);
+		pids[nr_forked] = pid;
+	}
+
+	/* on failure, kill the remaining workers but still reap them */
+	for (i = 0; i < nr_forked; i++) {
+		int status;
+
+		if (ret != SCX_TEST_PASS)
+			kill(pids[i], SIGKILL);
+
+		if (waitpid(pids[i], &status, 0) != pids[i]) {
+			SCX_ERR("Failed to wait for worker %d", i);
+			ret = SCX_TEST_FAIL;
+		} else if (ret == SCX_TEST_PASS && status != 0) {
+			SCX_ERR("Worker %d exited with status %d", i, status);
+			ret = SCX_TEST_FAIL;
+		}
+	}
+
+	bpf_link__destroy(link);
+
+	if (ret != SCX_TEST_PASS)
+		return ret;
+
+	printf("%s:\n", name);
+	printf("  workers: %d\n", nr_workers);
+	printf("  enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)skel->bss->dequeue_cnt,
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt,
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	if (!use_move_to_local)
+		printf("  remote SCX_DSQ_LOCAL_ON dispatches: %lu\n",
+		       (unsigned long)skel->bss->remote_dispatch_cnt);
+	printf("  ran on a CPU other than the enqueue CPU: %lu\n",
+	       (unsigned long)skel->bss->remote_running_cnt);
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
+	SCX_GT(skel->bss->remote_running_cnt, 0);
+	SCX_EQ(skel->bss->enqueue_cnt, skel->bss->dequeue_cnt);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue_remote *skel;
+	cpu_set_t cpus;
+
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(cpus), &cpus),
+		    "Failed to get CPU affinity");
+	nr_cpus = CPU_COUNT(&cpus);
+	if (nr_cpus < 2) {
+		fprintf(stderr, "Skipping: requires at least 2 usable CPUs\n");
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

