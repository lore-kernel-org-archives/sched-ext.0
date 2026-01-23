Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB9318EE3
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138801; cv=none; b=UMGIq1ayNPTeMajnRdUcVMfVB8ag9p0CW/ympTxEHg+FDy4FZ3wb84/gZo2q7InwGeekhp2nBbnAG74kgtyEtotXxhnsXtXXnZcdvLD1EI/iFyEy43fz5ZWfREUOeFWksqFWEuMrs8y429tFs9QNcWOnNdJLq+WyOTBeIcyO6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138801; c=relaxed/simple;
	bh=kKdk0Y5LvTcmDggGj3tc8tZsK+0zVQA0+d0y828l/m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxLu4JV+bOa0gUJxJ7CU8lKDH3BJOB5qLw3jzKCzz2S9Q6kb1yxZNIBAHOSezruEcq2oeccvIswfjFXTZTT85Qd3o61dZcUJq+I+WY+O8nqTuWHpV5prKetqB4xT1tb4RsFlN2EuxVyUdQtHWXa34pkt4ek7i7JAlaZdWs0GaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bxGxf547; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bxGxf547"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c533228383so108003485a.3
        for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 19:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769138786; x=1769743586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpTqIYH56LgTJI2R+I+AUv+3zM58G5Zmq1ltLpxPK44=;
        b=bxGxf547kWiqX+5e4MsMSQU3EAjYhzkQtkGpQYZTPxrc2Vv0O+569GSOV5+R60SXXK
         knc4aql+UsXZ/qtPdV/QrO9pkwHK+FgOu45hrjx/9Roz96ZyMDMF2hWVuF0FLAYn5rmp
         AZvGzzP2cfvOxKTLiN8ldB/4J6oFqtoBzuXXw1NbOgUpH+ReT1v5rSZsCZFHWKjv1Mdc
         zkXzjbRxcUYdnU4w8LjzOQhJnpmMARrdrDWa3ugwAzyKWXd/lKX7QlvKcObbKv9Qfawk
         wRZT2PsA/FNTjDgZB0HzwgA5uL9YmybjMLrvKbEAxyRSheeWmI0PuCa69wKZO0WswzJ3
         B9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769138786; x=1769743586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OpTqIYH56LgTJI2R+I+AUv+3zM58G5Zmq1ltLpxPK44=;
        b=AIm902PyQW0VylMugXixxAZT8nJLJoATKwB0xkl8FQqxJJc11bTOPg0qawpZ+goXnh
         hpq/FrFoLkOvrIQQfFSSwJ0OaPIcde7cbuh/XYpgwM/VT8H3jUGjB68XA/HwL2JAixyO
         ELuSMOvVLSpYe8NBzhPVWyX2gTXlAFKgDF5Ek47YUxpxk/xhWsvpQuR83qYtoYg6GXq3
         AGdpJpIyaP89rsuwbsfajvofFbdcXJXPZUyc5UIYvm6Bpq56lihtKVKIcz0WSh5LNVuB
         D1XmiYqX9oL+VJtZWCOJFweH478278qrj/U7alqyobu3voCAgNVjHO5rBaJM4pVy9fZ/
         jmQw==
X-Gm-Message-State: AOJu0YwjOej1tpyxQQw9NaU2ygy57G3zUCy45svIqYVjwhZaon58uGmo
	4GtFjpnABWr7Z2mYfalGA1oDmVbhfw+aqBFNeHdf+1AD5VTAk4AFMx7tF4yXdnezC9a9Upr7HsV
	BsiOk
X-Gm-Gg: AZuq6aIMaxmrHqhL2L7tS2MTWNR95tjcOsu8M69xLhUEOg9OrsH4aW1MKpNKqGgrHvd
	5J6ChnQWJL9WMvu4CHitwud7GZTdzvS/vyVWNXB4WHlMNFsMO/e7guOIj6b0FXxXEbAyKjIf9io
	OUjVbe3yRL08xlxxfsClUOa+I3j7O9Q5UX3vg/JkTpLYmUUZJj/36GoCqEerYW0/iTzqK6synyN
	ycn8KraP1VEkmYGc5ZAOTGE0QACFHxLeCanCypKDDzXnCwI/KuvmQHSj6hdI/fv8CKVb6oYeKhU
	JA/m5YbDFQclaSFMfBhPZaF/X8SyGHYCYRhQ0bLEh4exu8K/iDu3ENZ2FRKIZxw7/xu4kTHtgnP
	oo9ksXGGXxDgwR9gDYxjtDEWJco28vM2RchBiPdZKBSjwGwu1SKqHQJZ2ECcRxdb8Fg4rD4Ncia
	07gKoy3D3i/g==
X-Received: by 2002:a05:620a:258b:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8c6e2e46b71mr212574685a.77.1769138785866;
        Thu, 22 Jan 2026 19:26:25 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3855617sm80725485a.43.2026.01.22.19.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 19:26:25 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <dvernet@meta.com>
Subject: [PATCH v3 1/3] tools/sched_ext: add scx_userland scheduler
Date: Thu, 22 Jan 2026 22:26:03 -0500
Message-ID: <20260123032605.49140-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123032605.49140-1-emil@etsalapatis.com>
References: <20260123032605.49140-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add in the scx_userland scheduler that does vruntime-based
scheduling in userspace code and communicates scheduling
decisions to BPF by accessing and modifying globals through
the skeleton.

Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <dvernet@meta.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/sched_ext/Makefile           |   2 +-
 tools/sched_ext/scx_userland.bpf.c | 344 +++++++++++++++++++++++
 tools/sched_ext/scx_userland.c     | 437 +++++++++++++++++++++++++++++
 tools/sched_ext/scx_userland.h     |  17 ++
 4 files changed, 799 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_userland.bpf.c
 create mode 100644 tools/sched_ext/scx_userland.c
 create mode 100644 tools/sched_ext/scx_userland.h

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index e4bda2474060..12043a82a1a9 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -189,7 +189,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_userland.bpf.c b/tools/sched_ext/scx_userland.bpf.c
new file mode 100644
index 000000000000..f29862b89386
--- /dev/null
+++ b/tools/sched_ext/scx_userland.bpf.c
@@ -0,0 +1,344 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A minimal userland scheduler.
+ *
+ * In terms of scheduling, this provides two different types of behaviors:
+ * 1. A global FIFO scheduling order for _any_ tasks that have CPU affinity.
+ *    All such tasks are direct-dispatched from the kernel, and are never
+ *    enqueued in user space.
+ * 2. A primitive vruntime scheduler that is implemented in user space, for all
+ *    other tasks.
+ *
+ * Some parts of this example user space scheduler could be implemented more
+ * efficiently using more complex and sophisticated data structures. For
+ * example, rather than using BPF_MAP_TYPE_QUEUE's,
+ * BPF_MAP_TYPE_{USER_}RINGBUF's could be used for exchanging messages between
+ * user space and kernel space. Similarly, we use a simple vruntime-sorted list
+ * in user space, but an rbtree could be used instead.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+#include "scx_userland.h"
+
+/*
+ * Maximum amount of tasks enqueued/dispatched between kernel and user-space.
+ */
+#define MAX_ENQUEUED_TASKS 4096
+
+char _license[] SEC("license") = "GPL";
+
+const volatile s32 usersched_pid;
+
+/* !0 for veristat, set during init */
+const volatile u32 num_possible_cpus = 64;
+
+/* Stats that are printed by user space. */
+u64 nr_failed_enqueues, nr_kernel_enqueues, nr_user_enqueues;
+
+/*
+ * Number of tasks that are queued for scheduling.
+ *
+ * This number is incremented by the BPF component when a task is queued to the
+ * user-space scheduler and it must be decremented by the user-space scheduler
+ * when a task is consumed.
+ */
+volatile u64 nr_queued;
+
+/*
+ * Number of tasks that are waiting for scheduling.
+ *
+ * This number must be updated by the user-space scheduler to keep track if
+ * there is still some scheduling work to do.
+ */
+volatile u64 nr_scheduled;
+
+UEI_DEFINE(uei);
+
+/*
+ * The map containing tasks that are enqueued in user space from the kernel.
+ *
+ * This map is drained by the user space scheduler.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_ENQUEUED_TASKS);
+	__type(value, struct scx_userland_enqueued_task);
+} enqueued SEC(".maps");
+
+/*
+ * The map containing tasks that are dispatched to the kernel from user space.
+ *
+ * Drained by the kernel in userland_dispatch().
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_ENQUEUED_TASKS);
+	__type(value, s32);
+} dispatched SEC(".maps");
+
+/* Per-task scheduling context */
+struct task_ctx {
+	bool force_local; /* Dispatch directly to local DSQ */
+};
+
+/* Map that contains task-local storage. */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+/*
+ * Flag used to wake-up the user-space scheduler.
+ */
+static volatile u32 usersched_needed;
+
+/*
+ * Set user-space scheduler wake-up flag (equivalent to an atomic release
+ * operation).
+ */
+static void set_usersched_needed(void)
+{
+	__sync_fetch_and_or(&usersched_needed, 1);
+}
+
+/*
+ * Check and clear user-space scheduler wake-up flag (equivalent to an atomic
+ * acquire operation).
+ */
+static bool test_and_clear_usersched_needed(void)
+{
+	return __sync_fetch_and_and(&usersched_needed, 0) == 1;
+}
+
+static bool is_usersched_task(const struct task_struct *p)
+{
+	return p->pid == usersched_pid;
+}
+
+static bool keep_in_kernel(const struct task_struct *p)
+{
+	return p->nr_cpus_allowed < num_possible_cpus;
+}
+
+static struct task_struct *usersched_task(void)
+{
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(usersched_pid);
+	/*
+	 * Should never happen -- the usersched task should always be managed
+	 * by sched_ext.
+	 */
+	if (!p)
+		scx_bpf_error("Failed to find usersched task %d", usersched_pid);
+
+	return p;
+}
+
+s32 BPF_STRUCT_OPS(userland_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	if (keep_in_kernel(p)) {
+		s32 cpu;
+		struct task_ctx *tctx;
+
+		tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+		if (!tctx) {
+			scx_bpf_error("Failed to look up task-local storage for %s", p->comm);
+			return -ESRCH;
+		}
+
+		if (p->nr_cpus_allowed == 1 ||
+		    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+			tctx->force_local = true;
+			return prev_cpu;
+		}
+
+		cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+		if (cpu >= 0) {
+			tctx->force_local = true;
+			return cpu;
+		}
+	}
+
+	return prev_cpu;
+}
+
+static void dispatch_user_scheduler(void)
+{
+	struct task_struct *p;
+
+	p = usersched_task();
+	if (p) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	}
+}
+
+static void enqueue_task_in_user_space(struct task_struct *p, u64 enq_flags)
+{
+	struct scx_userland_enqueued_task task = {};
+
+	task.pid = p->pid;
+	task.sum_exec_runtime = p->se.sum_exec_runtime;
+	task.weight = p->scx.weight;
+
+	if (bpf_map_push_elem(&enqueued, &task, 0)) {
+		/*
+		 * If we fail to enqueue the task in user space, put it
+		 * directly on the global DSQ.
+		 */
+		__sync_fetch_and_add(&nr_failed_enqueues, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	} else {
+		__sync_fetch_and_add(&nr_user_enqueues, 1);
+		set_usersched_needed();
+	}
+}
+
+void BPF_STRUCT_OPS(userland_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (keep_in_kernel(p)) {
+		u64 dsq_id = SCX_DSQ_GLOBAL;
+		struct task_ctx *tctx;
+
+		tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+		if (!tctx) {
+			scx_bpf_error("Failed to lookup task ctx for %s", p->comm);
+			return;
+		}
+
+		if (tctx->force_local)
+			dsq_id = SCX_DSQ_LOCAL;
+		tctx->force_local = false;
+		scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+		__sync_fetch_and_add(&nr_kernel_enqueues, 1);
+		return;
+	} else if (!is_usersched_task(p)) {
+		enqueue_task_in_user_space(p, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(userland_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (test_and_clear_usersched_needed())
+		dispatch_user_scheduler();
+
+	bpf_repeat(MAX_ENQUEUED_TASKS) {
+		s32 pid;
+		struct task_struct *p;
+
+		if (bpf_map_pop_elem(&dispatched, &pid))
+			break;
+
+		/*
+		 * The task could have exited by the time we get around to
+		 * dispatching it. Treat this as a normal occurrence, and simply
+		 * move onto the next iteration.
+		 */
+		p = bpf_task_from_pid(pid);
+		if (!p)
+			continue;
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	}
+}
+
+/*
+ * A CPU is about to change its idle state. If the CPU is going idle, ensure
+ * that the user-space scheduler has a chance to run if there is any remaining
+ * work to do.
+ */
+void BPF_STRUCT_OPS(userland_update_idle, s32 cpu, bool idle)
+{
+	/*
+	 * Don't do anything if we exit from and idle state, a CPU owner will
+	 * be assigned in .running().
+	 */
+	if (!idle)
+		return;
+	/*
+	 * A CPU is now available, notify the user-space scheduler that tasks
+	 * can be dispatched, if there is at least one task waiting to be
+	 * scheduled, either queued (accounted in nr_queued) or scheduled
+	 * (accounted in nr_scheduled).
+	 *
+	 * NOTE: nr_queued is incremented by the BPF component, more exactly in
+	 * enqueue(), when a task is sent to the user-space scheduler, then
+	 * the scheduler drains the queued tasks (updating nr_queued) and adds
+	 * them to its internal data structures / state; at this point tasks
+	 * become "scheduled" and the user-space scheduler will take care of
+	 * updating nr_scheduled accordingly; lastly tasks will be dispatched
+	 * and the user-space scheduler will update nr_scheduled again.
+	 *
+	 * Checking both counters allows to determine if there is still some
+	 * pending work to do for the scheduler: new tasks have been queued
+	 * since last check, or there are still tasks "queued" or "scheduled"
+	 * since the previous user-space scheduler run. If the counters are
+	 * both zero it is pointless to wake-up the scheduler (even if a CPU
+	 * becomes idle), because there is nothing to do.
+	 *
+	 * Keep in mind that update_idle() doesn't run concurrently with the
+	 * user-space scheduler (that is single-threaded): this function is
+	 * naturally serialized with the user-space scheduler code, therefore
+	 * this check here is also safe from a concurrency perspective.
+	 */
+	if (nr_queued || nr_scheduled) {
+		/*
+		 * Kick the CPU to make it immediately ready to accept
+		 * dispatched tasks.
+		 */
+		set_usersched_needed();
+		scx_bpf_kick_cpu(cpu, 0);
+	}
+}
+
+s32 BPF_STRUCT_OPS(userland_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return 0;
+	else
+		return -ENOMEM;
+}
+
+s32 BPF_STRUCT_OPS(userland_init)
+{
+	if (num_possible_cpus == 0) {
+		scx_bpf_error("User scheduler # CPUs uninitialized (%d)",
+			      num_possible_cpus);
+		return -EINVAL;
+	}
+
+	if (usersched_pid <= 0) {
+		scx_bpf_error("User scheduler pid uninitialized (%d)",
+			      usersched_pid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(userland_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(userland_ops,
+	       .select_cpu		= (void *)userland_select_cpu,
+	       .enqueue			= (void *)userland_enqueue,
+	       .dispatch		= (void *)userland_dispatch,
+	       .update_idle		= (void *)userland_update_idle,
+	       .init_task		= (void *)userland_init_task,
+	       .init			= (void *)userland_init,
+	       .exit			= (void *)userland_exit,
+	       .flags			= SCX_OPS_ENQ_LAST |
+					  SCX_OPS_KEEP_BUILTIN_IDLE,
+	       .name			= "userland");
diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
new file mode 100644
index 000000000000..10b31020f44f
--- /dev/null
+++ b/tools/sched_ext/scx_userland.c
@@ -0,0 +1,437 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext user space scheduler which provides vruntime semantics
+ * using a simple ordered-list implementation.
+ *
+ * Each CPU in the system resides in a single, global domain. This precludes
+ * the need to do any load balancing between domains. The scheduler could
+ * easily be extended to support multiple domains, with load balancing
+ * happening in user space.
+ *
+ * Any task which has any CPU affinity is scheduled entirely in BPF. This
+ * program only schedules tasks which may run on any CPU.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <sched.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <pthread.h>
+#include <bpf/bpf.h>
+#include <sys/mman.h>
+#include <sys/queue.h>
+#include <sys/syscall.h>
+
+#include <scx/common.h>
+#include "scx_userland.h"
+#include "scx_userland.bpf.skel.h"
+
+const char help_fmt[] =
+"A minimal userland sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Try to reduce `sysctl kernel.pid_max` if this program triggers OOMs.\n"
+"\n"
+"Usage: %s [-b BATCH]\n"
+"\n"
+"  -b BATCH      The number of tasks to batch when dispatching (default: 8)\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+/* Defined in UAPI */
+#define SCHED_EXT 7
+
+/* Number of tasks to batch when dispatching to user space. */
+static __u32 batch_size = 8;
+
+static bool verbose;
+static volatile int exit_req;
+static int enqueued_fd, dispatched_fd;
+
+static struct scx_userland *skel;
+static struct bpf_link *ops_link;
+
+/* Stats collected in user space. */
+static __u64 nr_vruntime_enqueues, nr_vruntime_dispatches, nr_vruntime_failed;
+
+/* Number of tasks currently enqueued. */
+static __u64 nr_curr_enqueued;
+
+/* The data structure containing tasks that are enqueued in user space. */
+struct enqueued_task {
+	LIST_ENTRY(enqueued_task) entries;
+	__u64 sum_exec_runtime;
+	double vruntime;
+};
+
+/*
+ * Use a vruntime-sorted list to store tasks. This could easily be extended to
+ * a more optimal data structure, such as an rbtree as is done in CFS. We
+ * currently elect to use a sorted list to simplify the example for
+ * illustrative purposes.
+ */
+LIST_HEAD(listhead, enqueued_task);
+
+/*
+ * A vruntime-sorted list of tasks. The head of the list contains the task with
+ * the lowest vruntime. That is, the task that has the "highest" claim to be
+ * scheduled.
+ */
+static struct listhead vruntime_head = LIST_HEAD_INITIALIZER(vruntime_head);
+
+/*
+ * The main array of tasks. The array is allocated all at once during
+ * initialization, based on /proc/sys/kernel/pid_max, to avoid having to
+ * dynamically allocate memory on the enqueue path, which could cause a
+ * deadlock. A more substantive user space scheduler could e.g. provide a hook
+ * for newly enabled tasks that are passed to the scheduler from the
+ * .prep_enable() callback to allows the scheduler to allocate on safe paths.
+ */
+struct enqueued_task *tasks;
+static int pid_max;
+
+static double min_vruntime;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int userland)
+{
+	exit_req = 1;
+}
+
+static int get_pid_max(void)
+{
+	FILE *fp;
+	int pid_max;
+
+	fp = fopen("/proc/sys/kernel/pid_max", "r");
+	if (fp == NULL) {
+		fprintf(stderr, "Error opening /proc/sys/kernel/pid_max\n");
+		return -1;
+	}
+	if (fscanf(fp, "%d", &pid_max) != 1) {
+		fprintf(stderr, "Error reading from /proc/sys/kernel/pid_max\n");
+		fclose(fp);
+		return -1;
+	}
+	fclose(fp);
+
+	return pid_max;
+}
+
+static int init_tasks(void)
+{
+	pid_max = get_pid_max();
+	if (pid_max < 0)
+		return pid_max;
+
+	tasks = calloc(pid_max, sizeof(*tasks));
+	if (!tasks) {
+		fprintf(stderr, "Error allocating tasks array\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static __u32 task_pid(const struct enqueued_task *task)
+{
+	return ((uintptr_t)task - (uintptr_t)tasks) / sizeof(*task);
+}
+
+static int dispatch_task(__s32 pid)
+{
+	int err;
+
+	err = bpf_map_update_elem(dispatched_fd, NULL, &pid, 0);
+	if (err) {
+		nr_vruntime_failed++;
+	} else {
+		nr_vruntime_dispatches++;
+	}
+
+	return err;
+}
+
+static struct enqueued_task *get_enqueued_task(__s32 pid)
+{
+	if (pid >= pid_max)
+		return NULL;
+
+	return &tasks[pid];
+}
+
+static double calc_vruntime_delta(__u64 weight, __u64 delta)
+{
+	double weight_f = (double)weight / 100.0;
+	double delta_f = (double)delta;
+
+	return delta_f / weight_f;
+}
+
+static void update_enqueued(struct enqueued_task *enqueued, const struct scx_userland_enqueued_task *bpf_task)
+{
+	__u64 delta;
+
+	delta = bpf_task->sum_exec_runtime - enqueued->sum_exec_runtime;
+
+	enqueued->vruntime += calc_vruntime_delta(bpf_task->weight, delta);
+	if (min_vruntime > enqueued->vruntime)
+		enqueued->vruntime = min_vruntime;
+	enqueued->sum_exec_runtime = bpf_task->sum_exec_runtime;
+}
+
+static int vruntime_enqueue(const struct scx_userland_enqueued_task *bpf_task)
+{
+	struct enqueued_task *curr, *enqueued, *prev;
+
+	curr = get_enqueued_task(bpf_task->pid);
+	if (!curr)
+		return ENOENT;
+
+	update_enqueued(curr, bpf_task);
+	nr_vruntime_enqueues++;
+	nr_curr_enqueued++;
+
+	/*
+	 * Enqueue the task in a vruntime-sorted list. A more optimal data
+	 * structure such as an rbtree could easily be used as well. We elect
+	 * to use a list here simply because it's less code, and thus the
+	 * example is less convoluted and better serves to illustrate what a
+	 * user space scheduler could look like.
+	 */
+
+	if (LIST_EMPTY(&vruntime_head)) {
+		LIST_INSERT_HEAD(&vruntime_head, curr, entries);
+		return 0;
+	}
+
+	LIST_FOREACH(enqueued, &vruntime_head, entries) {
+		if (curr->vruntime <= enqueued->vruntime) {
+			LIST_INSERT_BEFORE(enqueued, curr, entries);
+			return 0;
+		}
+		prev = enqueued;
+	}
+
+	LIST_INSERT_AFTER(prev, curr, entries);
+
+	return 0;
+}
+
+static void drain_enqueued_map(void)
+{
+	while (1) {
+		struct scx_userland_enqueued_task task;
+		int err;
+
+		if (bpf_map_lookup_and_delete_elem(enqueued_fd, NULL, &task)) {
+			skel->bss->nr_queued = 0;
+			skel->bss->nr_scheduled = nr_curr_enqueued;
+			return;
+		}
+
+		err = vruntime_enqueue(&task);
+		if (err) {
+			fprintf(stderr, "Failed to enqueue task %d: %s\n",
+				task.pid, strerror(err));
+			exit_req = 1;
+			return;
+		}
+	}
+}
+
+static void dispatch_batch(void)
+{
+	__u32 i;
+
+	for (i = 0; i < batch_size; i++) {
+		struct enqueued_task *task;
+		int err;
+		__s32 pid;
+
+		task = LIST_FIRST(&vruntime_head);
+		if (!task)
+			break;
+
+		min_vruntime = task->vruntime;
+		pid = task_pid(task);
+		LIST_REMOVE(task, entries);
+		err = dispatch_task(pid);
+		if (err) {
+			/*
+			 * If we fail to dispatch, put the task back to the
+			 * vruntime_head list and stop dispatching additional
+			 * tasks in this batch.
+			 */
+			LIST_INSERT_HEAD(&vruntime_head, task, entries);
+			break;
+		}
+		nr_curr_enqueued--;
+	}
+	skel->bss->nr_scheduled = nr_curr_enqueued;
+}
+
+static void *run_stats_printer(void *arg)
+{
+	while (!exit_req) {
+		__u64 nr_failed_enqueues, nr_kernel_enqueues, nr_user_enqueues, total;
+
+		nr_failed_enqueues = skel->bss->nr_failed_enqueues;
+		nr_kernel_enqueues = skel->bss->nr_kernel_enqueues;
+		nr_user_enqueues = skel->bss->nr_user_enqueues;
+		total = nr_failed_enqueues + nr_kernel_enqueues + nr_user_enqueues;
+
+		printf("o-----------------------o\n");
+		printf("| BPF ENQUEUES          |\n");
+		printf("|-----------------------|\n");
+		printf("|  kern:     %10llu |\n", nr_kernel_enqueues);
+		printf("|  user:     %10llu |\n", nr_user_enqueues);
+		printf("|  failed:   %10llu |\n", nr_failed_enqueues);
+		printf("|  -------------------- |\n");
+		printf("|  total:    %10llu |\n", total);
+		printf("|                       |\n");
+		printf("|-----------------------|\n");
+		printf("| VRUNTIME / USER       |\n");
+		printf("|-----------------------|\n");
+		printf("|  enq:      %10llu |\n", nr_vruntime_enqueues);
+		printf("|  disp:     %10llu |\n", nr_vruntime_dispatches);
+		printf("|  failed:   %10llu |\n", nr_vruntime_failed);
+		printf("o-----------------------o\n");
+		printf("\n\n");
+		fflush(stdout);
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+static int spawn_stats_thread(void)
+{
+	pthread_t stats_printer;
+
+	return pthread_create(&stats_printer, NULL, run_stats_printer, NULL);
+}
+
+static void pre_bootstrap(int argc, char **argv)
+{
+	int err;
+	__u32 opt;
+	struct sched_param sched_param = {
+		.sched_priority = sched_get_priority_max(SCHED_EXT),
+	};
+
+	err = init_tasks();
+	if (err)
+		exit(err);
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	/*
+	 * Enforce that the user scheduler task is managed by sched_ext. The
+	 * task eagerly drains the list of enqueued tasks in its main work
+	 * loop, and then yields the CPU. The BPF scheduler only schedules the
+	 * user space scheduler task when at least one other task in the system
+	 * needs to be scheduled.
+	 */
+	err = syscall(__NR_sched_setscheduler, getpid(), SCHED_EXT, &sched_param);
+	SCX_BUG_ON(err, "Failed to set scheduler to SCHED_EXT");
+
+	while ((opt = getopt(argc, argv, "b:vh")) != -1) {
+		switch (opt) {
+		case 'b':
+			batch_size = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			exit(opt != 'h');
+		}
+	}
+
+	/*
+	 * It's not always safe to allocate in a user space scheduler, as an
+	 * enqueued task could hold a lock that we require in order to be able
+	 * to allocate.
+	 */
+	err = mlockall(MCL_CURRENT | MCL_FUTURE);
+	SCX_BUG_ON(err, "Failed to prefault and lock address space");
+}
+
+static void bootstrap(char *comm)
+{
+	skel = SCX_OPS_OPEN(userland_ops, scx_userland);
+
+	skel->rodata->num_possible_cpus = libbpf_num_possible_cpus();
+	assert(skel->rodata->num_possible_cpus > 0);
+	skel->rodata->usersched_pid = getpid();
+	assert(skel->rodata->usersched_pid > 0);
+
+	SCX_OPS_LOAD(skel, userland_ops, scx_userland, uei);
+
+	enqueued_fd = bpf_map__fd(skel->maps.enqueued);
+	dispatched_fd = bpf_map__fd(skel->maps.dispatched);
+	assert(enqueued_fd > 0);
+	assert(dispatched_fd > 0);
+
+	SCX_BUG_ON(spawn_stats_thread(), "Failed to spawn stats thread");
+
+	ops_link = SCX_OPS_ATTACH(skel, userland_ops, scx_userland);
+}
+
+static void sched_main_loop(void)
+{
+	while (!exit_req) {
+		/*
+		 * Perform the following work in the main user space scheduler
+		 * loop:
+		 *
+		 * 1. Drain all tasks from the enqueued map, and enqueue them
+		 *    to the vruntime sorted list.
+		 *
+		 * 2. Dispatch a batch of tasks from the vruntime sorted list
+		 *    down to the kernel.
+		 *
+		 * 3. Yield the CPU back to the system. The BPF scheduler will
+		 *    reschedule the user space scheduler once another task has
+		 *    been enqueued to user space.
+		 */
+		drain_enqueued_map();
+		dispatch_batch();
+		sched_yield();
+	}
+}
+
+int main(int argc, char **argv)
+{
+	__u64 ecode;
+
+	pre_bootstrap(argc, argv);
+restart:
+	bootstrap(argv[0]);
+	sched_main_loop();
+
+	exit_req = 1;
+	bpf_link__destroy(ops_link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_userland__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
diff --git a/tools/sched_ext/scx_userland.h b/tools/sched_ext/scx_userland.h
new file mode 100644
index 000000000000..684fb2dd5de9
--- /dev/null
+++ b/tools/sched_ext/scx_userland.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta, Inc */
+
+#ifndef __SCX_USERLAND_COMMON_H
+#define __SCX_USERLAND_COMMON_H
+
+/*
+ * An instance of a task that has been enqueued by the kernel for consumption
+ * by a user space global scheduler thread.
+ */
+struct scx_userland_enqueued_task {
+	__s32 pid;
+	u64 sum_exec_runtime;
+	u64 weight;
+};
+
+#endif  // __SCX_USERLAND_COMMON_H
-- 
2.49.0

