Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21976497382
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325712; cv=none; b=d8IKDvv6a3oyX8tNrD8pZAvGj2pkZjmwGXBmiS6p2KyOOMqlRjv0N0uHxPHdHlyL2Knpzt+en5sNyfmDJKHYmPTUUwju/XTBdPCxaz8nuFgJPc73w3FtNN1+tFmOAYBo6utSWnaxWaiZ4OIdRFj0oIk3UtZCC2pdhnBKu10oCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325712; c=relaxed/simple;
	bh=k74DuuYZb3KbYImmN4pyatAnOztjchzkeC4w9TGfhFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofaJ+4wFORhJCUguorL7iysQ2Rp12gs6K0oI1r7EkEElucHo+S9LYbAcyuAcVwBKbTta7gui8aO1EVLfLnV8Ret0+gN4X1LgrxViW6gAmPFGG0kAZV7CV4TqkHWlaygYMsRBh0vQreH4hQyS5wOUdmMkwosBY9j3Nud/gs9kZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j18bVkTZ; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j18bVkTZ"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c40aa03ded8so129231466b.2
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325706; x=1792930506; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjXIXCv3r8iHDNKieJEHFkXBCy70vFjyTgFpNus2Wmg=;
        b=j18bVkTZ58KiULclOO6FouIqEpdp4BnKALDpswuO9v2PKfDj2TUDaE/K0tQc/Nhd45
         7QrTVPfZsm/ZIZz2mwtcjyI7wmrPpu+hDWo4XOhFRSCcJTBZMdoWoOMVo6IBR/orDNTb
         7TzzWpMvbCmg7JujTvfCh6cle2mn7rQp3h+gez9b2pr4BLrIohCZ3o1iP6DbAkD3dUi+
         JRfvBoLozcU9dzycVMW2vx9qBl94kyaw1FfMxoIQKlHYU7vf0xmXiommtZn/P88E+Cp7
         ejipDkH6eBEGMqtXE/VGyvfQ/3lIqyZ9xPeELVzp7A+xrlP+GKf+qdH+G2Q6SgsuLi5X
         7SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325706; x=1792930506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjXIXCv3r8iHDNKieJEHFkXBCy70vFjyTgFpNus2Wmg=;
        b=p7qu5QXbkSvNJER1QYjz/WaxoKJBQyL2gDWYn+mVNEm8+fSpwj2zVrRZ0gnkUFtWjH
         LCNobMajwfDeHL9/0Id7apiCMj7Rl2LV4FrBZlpYdEBZEIi/pIOjCz/eDsCFqoT1glTA
         ZZekOqlnSrkd9LpWY+uiq/8pAtLiu8ogdiis1YoG7JscgXDMMMeVbNii7stQHP4Z2M8i
         BlFFGTeG3QBz2fhJi0J8+0Akn2Fz5Qz4IN2Kb9i1p0bEltougXoGA/gMj6gS7+iaCrXw
         pdqFo5Pt4gEfr+Nu6MYqYLq6Afv5Qocj4vPToHxRelzRahFY9Zbo4opS5OAqQmZk3sSj
         X24w==
X-Forwarded-Encrypted: i=1; AKwUvBzeA/cM0Rl8SAaeWAwGrYpQM+M7n6Xj2olrz8bYLV/u2xQMjTHg0j9AEL4qP6b+PMDdqlNaJvrSH8I=@lists.linux.dev
X-Gm-Message-State: AFq9FYI2WGPpxq4idqHA2VqDxsnjIkA0MXgi5GPN+lxDtXCbrJxuxBhu
	hGPDlU3bqg1pU8mby5Olk2iwnoJOIr0zNOg1CnkJj+D2zMDM59e9PLQH/Fa2fgcpDppbgj5lh75
	RXWeRQ1JetnuE8g==
X-Received: from ejgo26.prod.google.com ([2002:a17:906:1b1a:b0:c2d:cccd:de0d])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c142:b0:c2a:34fe:ea4d with SMTP id a640c23a62f3a-c419e639b87mr362711066b.25.1792325706044;
 Sun, 18 Oct 2026 05:15:06 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:49 +0000
In-Reply-To: <cover.1792248922.git.jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <935eb08e4c7ebce012b4f1c61406a0a53b016862.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH 5/5] selftests/sched_ext: Add cpu_avail tests
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add tests verifying that ops.cpu_acquire() and ops.cpu_release() are
invoked on every change of a CPU's availability to the BPF scheduler,
and only then.

The cpu_avail BPF scheduler tracks the state reported by the callbacks
per CPU, flagging double acquires and releases as well as callbacks
between ops.cpu_offline() and ops.cpu_online(). A sched_switch
tracepoint program checks after every pick that the reported state
matches the incoming task. In full switch mode, a CPU must be released
iff the task about to run has an RT or deadline priority, which covers
the stop task and PI-boosted tasks too. In partial mode, tasks without
the SCHED_EXT policy release it as well. The checker skips a CPU
while userspace hotplugs it, as the kernel releases the CPU before
ops.cpu_offline() updates the BPF side.

cpu_avail runs the following scenarios on top of the invariant checker:

- idle_to_rt: an RT task waking up on an idle CPU releases it, with the
  callback invoked from the idle task, and the CPU is acquired again
  when the RT task sleeps.
- class_change: switching a running SCX task to SCHED_FIFO from another
  CPU releases its CPU remotely with SCX_CPU_PREEMPT_CLASS_CHANGE and
  switching it back acquires the CPU. If the task happened not to be
  running at that moment, e.g. because the stopper preempted it, the
  switch is retried once.
- remote_reenq: same as class_change with tasks queued on the target
  CPU's local DSQ and ops.cpu_release() calling the legacy, synchronous
  scx_bpf_reenqueue_local(). The queued tasks must be re-enqueued.
- pi_boost: an SCX task holding a PI mutex is boosted by an RT waiter on
  another CPU, which releases its CPU until it's deboosted.
- churn: RT tasks, SCX tasks and class changes on all CPUs at once.
- hotplug: no callbacks while the CPU is offline and an acquire after it
  comes back online.
- partial: in partial mode, idle -> fair and a fair task preempting an
  SCX task release the CPU with SCX_CPU_PREEMPT_FAIR, and
  a running SCHED_EXT task switching to SCHED_OTHER releases it with
  SCX_CPU_PREEMPT_CLASS_CHANGE.
- reload: every scheduler instance gets an initial acquire for every
  online CPU.

cpu_avail_core needs SMT and runs SCX tasks with different core-sched
cookies on two siblings. The resulting forced idle must not release the
CPUs. An RT task sharing the other sibling's cookie must release and
re-acquire its CPU.

Also add the cpu_acquire/release() stubs back to the maximal scheduler
now that they are no longer deprecated.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 .../selftests/sched_ext/cpu_avail.bpf.c       | 218 ++++++
 tools/testing/selftests/sched_ext/cpu_avail.c | 717 ++++++++++++++++++
 tools/testing/selftests/sched_ext/cpu_avail.h | 237 ++++++
 .../selftests/sched_ext/cpu_avail_core.c      | 256 +++++++
 .../testing/selftests/sched_ext/maximal.bpf.c |  10 +
 6 files changed, 1440 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.c
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.h
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail_core.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index af919a56a4f4..c0861bd33d3a 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -162,6 +162,8 @@ endef
 all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
 
 auto-test-targets :=			\
+	cpu_avail			\
+	cpu_avail_core			\
 	create_dsq			\
 	dequeue				\
 	dequeue_iter			\
diff --git a/tools/testing/selftests/sched_ext/cpu_avail.bpf.c b/tools/testing/selftests/sched_ext/cpu_avail.bpf.c
new file mode 100644
index 000000000000..d0052d1a18a0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_avail.bpf.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Track ops.cpu_acquire/release() and verify that they reliably reflect
+ * whether each CPU is available to the BPF scheduler.
+ *
+ * A CPU is available while it runs an SCX task or the idle task. In full
+ * switch mode, every task with a normal priority is an SCX task and a CPU must
+ * be released iff the task running on it has an RT or deadline priority. This
+ * includes the stop task and PI-boosted tasks. In partial mode, only
+ * tasks with a normal priority and the SCHED_EXT policy are SCX tasks.
+ *
+ * The sched_switch tracepoint fires after the pick with the rq locked and
+ * checks that the state reported through the callbacks matches the incoming
+ * task.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_CPUS	1024
+#define NR_REASONS	8
+#define MAX_RT_PRIO	100
+#define SCHED_EXT	7
+
+/* set by userspace */
+const volatile u32 nr_cpus;
+u32 hog_tgid;			/* tasks of this tgid get an infinite slice */
+bool reenq_enabled;		/* cpu_release() of reenq_cpu calls v1 reenqueue */
+s32 reenq_cpu;
+bool check_enabled;		/* enables the sched_switch invariant checker */
+bool partial;			/* cpu_avail_partial_ops is attached */
+bool hp_busy;			/* hp_cpu is being hotplugged, don't check it */
+s32 hp_cpu;
+
+/* state as reported by the callbacks, every CPU starts released */
+bool acquired[MAX_CPUS];
+bool offline[MAX_CPUS];
+/* don't check the invariant until the first acquire after ops.cpu_online() */
+bool online_pending[MAX_CPUS];
+
+u64 nr_acquires[MAX_CPUS];
+u64 nr_releases[MAX_CPUS];
+u64 nr_reasons[MAX_CPUS][NR_REASONS];
+u64 nr_remote_releases[MAX_CPUS];	/* invoked from another CPU */
+u64 nr_idle_releases[MAX_CPUS];		/* invoked from the idle task */
+u64 nr_idle_switches[MAX_CPUS];		/* context switches to idle */
+u64 nr_hog_fair_releases[MAX_CPUS];	/* FAIR releases preempting the hog */
+
+u64 nr_dbl_acquires;
+u64 nr_dbl_releases;
+u64 nr_offline_cbs;			/* between cpu_offline() and cpu_online() */
+u64 nr_checks;
+u64 nr_violations;
+s32 violation_cpu;
+s32 violation_pid;
+s32 violation_prio;
+bool violation_acquired;
+
+/* legacy v1 scx_bpf_reenqueue_local() results */
+u64 nr_reenq_calls;
+u64 nr_reenq_remote;			/* invoked from another CPU */
+u64 nr_reenq_tasks;
+u64 nr_reenq_remote_tasks;		/* tasks re-enqueued by remote calls */
+u64 nr_reenq_enqueues;			/* ops.enqueue() with SCX_ENQ_REENQ */
+
+static __always_inline bool cpu_ok(s32 cpu)
+{
+	return cpu >= 0 && cpu < MAX_CPUS && cpu < nr_cpus;
+}
+
+void BPF_STRUCT_OPS(cpu_avail_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	u64 slice = SCX_SLICE_DFL;
+
+	if (enq_flags & SCX_ENQ_REENQ)
+		__sync_fetch_and_add(&nr_reenq_enqueues, 1);
+
+	if (hog_tgid && p->tgid == hog_tgid)
+		slice = SCX_SLICE_INF;
+
+	/* queue pinned tasks on the local DSQ of the CPU they're enqueued on */
+	if (p->nr_cpus_allowed == 1)
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice, enq_flags);
+	else
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, slice, enq_flags);
+}
+
+void BPF_STRUCT_OPS(cpu_avail_cpu_acquire, s32 cpu,
+		    struct scx_cpu_acquire_args *args)
+{
+	if (!cpu_ok(cpu))
+		return;
+
+	if (offline[cpu])
+		__sync_fetch_and_add(&nr_offline_cbs, 1);
+	if (acquired[cpu])
+		__sync_fetch_and_add(&nr_dbl_acquires, 1);
+
+	acquired[cpu] = true;
+	online_pending[cpu] = false;
+	__sync_fetch_and_add(&nr_acquires[cpu], 1);
+}
+
+void BPF_STRUCT_OPS(cpu_avail_cpu_release, s32 cpu,
+		    struct scx_cpu_release_args *args)
+{
+	struct task_struct *cur = bpf_get_current_task_btf();
+	bool remote = bpf_get_smp_processor_id() != cpu;
+	u32 reason = args->reason;
+
+	if (!cpu_ok(cpu))
+		return;
+
+	if (offline[cpu])
+		__sync_fetch_and_add(&nr_offline_cbs, 1);
+	if (!acquired[cpu])
+		__sync_fetch_and_add(&nr_dbl_releases, 1);
+
+	acquired[cpu] = false;
+	__sync_fetch_and_add(&nr_releases[cpu], 1);
+	if (reason < NR_REASONS)
+		__sync_fetch_and_add(&nr_reasons[cpu][reason], 1);
+
+	if (remote)
+		__sync_fetch_and_add(&nr_remote_releases[cpu], 1);
+	else if (cur->pid == 0)
+		__sync_fetch_and_add(&nr_idle_releases[cpu], 1);
+	else if (hog_tgid && cur->tgid == hog_tgid &&
+		 reason == SCX_CPU_PREEMPT_FAIR)
+		__sync_fetch_and_add(&nr_hog_fair_releases[cpu], 1);
+
+	if (reenq_enabled && cpu == reenq_cpu) {
+		u32 nr = scx_bpf_reenqueue_local___v1();
+
+		__sync_fetch_and_add(&nr_reenq_calls, 1);
+		__sync_fetch_and_add(&nr_reenq_tasks, nr);
+		if (remote) {
+			__sync_fetch_and_add(&nr_reenq_remote, 1);
+			__sync_fetch_and_add(&nr_reenq_remote_tasks, nr);
+		}
+	}
+}
+
+void BPF_STRUCT_OPS(cpu_avail_cpu_online, s32 cpu)
+{
+	if (!cpu_ok(cpu))
+		return;
+
+	offline[cpu] = false;
+	online_pending[cpu] = true;
+}
+
+void BPF_STRUCT_OPS(cpu_avail_cpu_offline, s32 cpu)
+{
+	if (!cpu_ok(cpu))
+		return;
+
+	/* ops.cpu_offline() implies release */
+	acquired[cpu] = false;
+	offline[cpu] = true;
+}
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(cpu_avail_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned int prev_state)
+{
+	s32 cpu = bpf_get_smp_processor_id();
+	bool avail;
+
+	if (!cpu_ok(cpu))
+		return 0;
+
+	if (next->pid == 0)
+		__sync_fetch_and_add(&nr_idle_switches[cpu], 1);
+
+	if (!check_enabled || offline[cpu] || online_pending[cpu] ||
+	    (hp_busy && cpu == hp_cpu))
+		return 0;
+
+	avail = next->pid == 0 ||
+		(next->prio >= MAX_RT_PRIO &&
+		 (!partial || next->policy == SCHED_EXT));
+
+	__sync_fetch_and_add(&nr_checks, 1);
+	if (acquired[cpu] != avail &&
+	    __sync_fetch_and_add(&nr_violations, 1) == 0) {
+		violation_cpu = cpu;
+		violation_pid = next->pid;
+		violation_prio = next->prio;
+		violation_acquired = acquired[cpu];
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops cpu_avail_ops = {
+	.enqueue		= (void *)cpu_avail_enqueue,
+	.cpu_acquire		= (void *)cpu_avail_cpu_acquire,
+	.cpu_release		= (void *)cpu_avail_cpu_release,
+	.cpu_online		= (void *)cpu_avail_cpu_online,
+	.cpu_offline		= (void *)cpu_avail_cpu_offline,
+	.name			= "cpu_avail",
+	.timeout_ms		= 10000,
+};
+
+SEC(".struct_ops.link")
+struct sched_ext_ops cpu_avail_partial_ops = {
+	.enqueue		= (void *)cpu_avail_enqueue,
+	.cpu_acquire		= (void *)cpu_avail_cpu_acquire,
+	.cpu_release		= (void *)cpu_avail_cpu_release,
+	.cpu_online		= (void *)cpu_avail_cpu_online,
+	.cpu_offline		= (void *)cpu_avail_cpu_offline,
+	.flags			= SCX_OPS_SWITCH_PARTIAL,
+	.name			= "cpu_avail_partial",
+	.timeout_ms		= 10000,
+};
diff --git a/tools/testing/selftests/sched_ext/cpu_avail.c b/tools/testing/selftests/sched_ext/cpu_avail.c
new file mode 100644
index 000000000000..3796f94b05a9
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_avail.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that ops.cpu_acquire/release() are invoked on every change of a
+ * CPU's availability to the BPF scheduler, and only then.
+ */
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <stdatomic.h>
+#include "cpu_avail.h"
+
+#define NR_RELOADS	5
+
+struct cpu_avail_ctx {
+	struct cpu_avail *skel;
+	struct bpf_link *link;
+	cpu_set_t orig_mask;
+	int nr_cpus;
+	int ctl_cpu;		/* where the test itself runs */
+	int tgt_cpu;		/* the CPU being tested */
+};
+
+/* poll @cond for up to @ms milliseconds */
+#define WAIT_FOR(cond, ms)						\
+({									\
+	u64 __end = now_ns() + (ms) * 1000000ULL;			\
+	bool __ok;							\
+									\
+	while (!(__ok = (cond)) && now_ns() < __end)			\
+		sleep_ms(1);						\
+	__ok;								\
+})
+
+/*
+ * An RT task waking up on an idle CPU must release it and the CPU must be
+ * acquired again when the RT task goes back to sleep. This never goes
+ * through the SCX class.
+ */
+static enum scx_test_status test_idle_to_rt(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	struct task_spec spec = {
+		.cpu = ctx->tgt_cpu, .policy = SCHED_FIFO, .prio = 10,
+		.period_us = 5000, .run_us = 500, .duration_ms = 500,
+	};
+	int cpu = ctx->tgt_cpu;
+	u64 rt = bss->nr_reasons[cpu][REASON(RT)];
+	u64 idle = bss->nr_idle_releases[cpu];
+	u64 acq = bss->nr_acquires[cpu];
+	pid_t pid;
+
+	pid = spawn_task(&spec);
+	SCX_FAIL_IF(pid < 0, "Failed to fork (%d)", errno);
+	SCX_FAIL_IF(!wait_task(pid), "RT task failed");
+
+	SCX_GT(bss->nr_reasons[cpu][REASON(RT)], rt);
+	SCX_GT(bss->nr_idle_releases[cpu], idle);
+	SCX_GT(bss->nr_acquires[cpu], acq);
+	SCX_ASSERT(WAIT_FOR(bss->acquired[cpu], 100));
+
+	return SCX_TEST_PASS;
+}
+
+/* @policy is the hog's SCX policy, SCHED_OTHER or SCHED_EXT */
+static pid_t spawn_hog(struct cpu_avail_ctx *ctx, int policy)
+{
+	struct task_spec spec = { .cpu = ctx->tgt_cpu, .policy = policy };
+	int go_fd;
+	pid_t pid;
+
+	pid = fork_task(&spec, &go_fd);
+	if (pid < 0)
+		return pid;
+
+	/* infinite slice so that it stays current until it changes class */
+	ctx->skel->bss->hog_tgid = pid;
+	start_task(go_fd);
+	return pid;
+}
+
+static void stop_hog(struct cpu_avail_ctx *ctx, pid_t pid)
+{
+	kill_task(pid);
+	ctx->skel->bss->hog_tgid = 0;
+}
+
+/*
+ * Switch @hog, which runs on the target CPU, from @scx_policy to @policy from
+ * the control CPU and wait for the resulting remote CLASS_CHANGE release. The
+ * hog is normally current but something else, e.g. the stopper, may have
+ * preempted it at that moment, making the release local. If so, switch it
+ * back and retry once.
+ */
+static bool hog_leave_scx(struct cpu_avail_ctx *ctx, pid_t hog, int scx_policy,
+			  int policy, int prio)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	int cpu = ctx->tgt_cpu, i;
+	u64 cc, remote;
+
+	for (i = 0; i < 2; i++) {
+		if (!WAIT_FOR(bss->acquired[cpu], 500)) {
+			SCX_ERR("CPU %d not acquired", cpu);
+			return false;
+		}
+		sleep_ms(50);
+
+		cc = bss->nr_reasons[cpu][REASON(CLASS_CHANGE)];
+		remote = bss->nr_remote_releases[cpu];
+		if (set_policy(hog, policy, prio)) {
+			SCX_ERR("Failed to set policy %d (%d)", policy, errno);
+			return false;
+		}
+		if (WAIT_FOR(bss->nr_reasons[cpu][REASON(CLASS_CHANGE)] > cc, 100) &&
+		    bss->nr_remote_releases[cpu] > remote)
+			return true;
+
+		fprintf(stderr, "No remote CLASS_CHANGE release (%lu -> %lu, %lu -> %lu)%s\n",
+			cc, bss->nr_reasons[cpu][REASON(CLASS_CHANGE)],
+			remote, bss->nr_remote_releases[cpu],
+			i ? "" : ", retrying");
+		if (set_policy(hog, scx_policy, 0)) {
+			SCX_ERR("Failed to set policy %d (%d)", scx_policy, errno);
+			return false;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * The running SCX task (policy @scx_policy) switching to @policy through
+ * sched_setscheduler() from another CPU must release the CPU without a
+ * context switch, and the switch back must acquire it.
+ */
+static enum scx_test_status class_change(struct cpu_avail_ctx *ctx,
+					 int scx_policy, int policy, int prio)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	int cpu = ctx->tgt_cpu;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	u64 acq;
+	pid_t hog;
+
+	hog = spawn_hog(ctx, scx_policy);
+	SCX_FAIL_IF(hog < 0, "Failed to fork (%d)", errno);
+
+	if (!hog_leave_scx(ctx, hog, scx_policy, policy, prio))
+		goto out;
+	sleep_ms(20);
+
+	acq = bss->nr_acquires[cpu];
+	if (set_policy(hog, scx_policy, 0)) {
+		SCX_ERR("Failed to set policy %d (%d)", scx_policy, errno);
+		goto out;
+	}
+	if (!WAIT_FOR(bss->nr_acquires[cpu] > acq && bss->acquired[cpu], 100)) {
+		SCX_ERR("CPU %d not acquired after switching back", cpu);
+		goto out;
+	}
+
+	ret = SCX_TEST_PASS;
+out:
+	stop_hog(ctx, hog);
+	return ret;
+}
+
+static enum scx_test_status test_class_change(struct cpu_avail_ctx *ctx)
+{
+	return class_change(ctx, SCHED_OTHER, SCHED_FIFO, 1);
+}
+
+/*
+ * Same as test_class_change() but with tasks queued on the target CPU's local
+ * DSQ and ops.cpu_release() calling the legacy scx_bpf_reenqueue_local().
+ * The tasks must be re-enqueued from the target CPU's local DSQ even though
+ * ops.cpu_release() runs on another CPU.
+ */
+static enum scx_test_status test_remote_reenq(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	struct task_spec spec = { .cpu = ctx->tgt_cpu, .policy = SCHED_OTHER };
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	pid_t hog, waiters[2] = { -1, -1 };
+	u64 remote, tasks, enqs;
+	int i;
+
+	hog = spawn_hog(ctx, SCHED_OTHER);
+	SCX_FAIL_IF(hog < 0, "Failed to fork (%d)", errno);
+
+	if (!WAIT_FOR(bss->acquired[ctx->tgt_cpu], 500)) {
+		SCX_ERR("CPU %d not acquired", ctx->tgt_cpu);
+		goto out;
+	}
+	sleep_ms(50);
+
+	/* these queue up behind the hog on the target CPU's local DSQ */
+	for (i = 0; i < 2; i++) {
+		waiters[i] = spawn_task(&spec);
+		if (waiters[i] < 0) {
+			SCX_ERR("Failed to fork (%d)", errno);
+			goto out;
+		}
+	}
+	sleep_ms(100);
+
+	/* a first attempt may release and re-enqueue locally, count remote only */
+	remote = bss->nr_reenq_remote;
+	tasks = bss->nr_reenq_remote_tasks;
+	enqs = bss->nr_reenq_enqueues;
+
+	bss->reenq_cpu = ctx->tgt_cpu;
+	bss->reenq_enabled = true;
+	if (!hog_leave_scx(ctx, hog, SCHED_OTHER, SCHED_FIFO, 1))
+		goto out;
+	bss->reenq_enabled = false;
+
+	if (bss->nr_reenq_remote <= remote ||
+	    bss->nr_reenq_remote_tasks <= tasks ||
+	    bss->nr_reenq_enqueues <= enqs) {
+		SCX_ERR("Bad reenq: remote %lu->%lu tasks %lu->%lu enqs %lu->%lu",
+			remote, bss->nr_reenq_remote, tasks,
+			bss->nr_reenq_remote_tasks, enqs, bss->nr_reenq_enqueues);
+		goto out;
+	}
+
+	ret = SCX_TEST_PASS;
+out:
+	bss->reenq_enabled = false;
+	for (i = 0; i < 2; i++)
+		kill_task(waiters[i]);
+	stop_hog(ctx, hog);
+	return ret;
+}
+
+struct pi_ctx {
+	pthread_mutex_t mutex;
+	atomic_bool pinned;
+	atomic_bool held;
+	int owner_cpu;
+	int waiter_cpu;
+	bool failed;
+};
+
+static void *pi_owner_fn(void *arg)
+{
+	struct pi_ctx *pi = arg;
+
+	if (pin_to_cpu(0, pi->owner_cpu)) {
+		pi->failed = true;
+		atomic_store(&pi->pinned, true);
+		atomic_store(&pi->held, true);
+		return NULL;
+	}
+	atomic_store(&pi->pinned, true);
+
+	pthread_mutex_lock(&pi->mutex);
+	atomic_store(&pi->held, true);
+	spin_us(300 * 1000);
+	pthread_mutex_unlock(&pi->mutex);
+	return NULL;
+}
+
+static void *pi_waiter_fn(void *arg)
+{
+	struct pi_ctx *pi = arg;
+	struct sched_param param = { .sched_priority = 10 };
+
+	if (pin_to_cpu(0, pi->waiter_cpu) ||
+	    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param)) {
+		pi->failed = true;
+		return NULL;
+	}
+
+	while (!atomic_load(&pi->held))
+		;
+	/* boosts the owner, which runs on another CPU */
+	pthread_mutex_lock(&pi->mutex);
+	pthread_mutex_unlock(&pi->mutex);
+	return NULL;
+}
+
+static int run_pi(int owner_cpu, int waiter_cpu)
+{
+	struct pi_ctx pi = { .owner_cpu = owner_cpu, .waiter_cpu = waiter_cpu };
+	pthread_mutexattr_t attr;
+	pthread_t owner, waiter;
+
+	pthread_mutexattr_init(&attr);
+	if (pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT) ||
+	    pthread_mutex_init(&pi.mutex, &attr))
+		return EXIT_FAILURE;
+
+	if (pthread_create(&owner, NULL, pi_owner_fn, &pi))
+		return EXIT_FAILURE;
+
+	/*
+	 * The threads start on the waiter's CPU. Don't let the busy-waiting RT
+	 * waiter starve the owner before it has moved to its own CPU.
+	 */
+	while (!atomic_load(&pi.pinned))
+		usleep(1000);
+
+	if (pthread_create(&waiter, NULL, pi_waiter_fn, &pi)) {
+		pthread_join(owner, NULL);
+		return EXIT_FAILURE;
+	}
+	pthread_join(waiter, NULL);
+	pthread_join(owner, NULL);
+
+	return pi.failed ? EXIT_FAILURE : EXIT_SUCCESS;
+}
+
+/*
+ * An SCX task holding a PI mutex is boosted to RT by an RT waiter on another
+ * CPU. Its CPU must be released while it's boosted and acquired again once
+ * it's deboosted.
+ */
+static enum scx_test_status test_pi_boost(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	int cpu = ctx->tgt_cpu;
+	u64 cc = bss->nr_reasons[cpu][REASON(CLASS_CHANGE)];
+	u64 rt = bss->nr_reasons[cpu][REASON(RT)];
+	u64 acq = bss->nr_acquires[cpu];
+	pid_t pid;
+
+	pid = fork();
+	SCX_FAIL_IF(pid < 0, "Failed to fork (%d)", errno);
+	if (!pid)
+		exit(run_pi(ctx->tgt_cpu, ctx->ctl_cpu));
+
+	SCX_FAIL_IF(!wait_task(pid), "PI test failed");
+
+	/* boosting a running owner releases with CLASS_CHANGE, a queued one RT */
+	SCX_GT(bss->nr_reasons[cpu][REASON(CLASS_CHANGE)] - cc +
+	       bss->nr_reasons[cpu][REASON(RT)] - rt, 0);
+	SCX_GT(bss->nr_acquires[cpu], acq);
+	SCX_ASSERT(WAIT_FOR(bss->acquired[cpu], 100));
+
+	return SCX_TEST_PASS;
+}
+
+/*
+ * Run RT tasks, SCX tasks and sched_setscheduler() class changes on all CPUs
+ * at once. The sched_switch checker must not find any inconsistencies.
+ */
+static enum scx_test_status test_churn(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	struct task_spec spinner = { .cpu = -1, .policy = SCHED_OTHER };
+	struct task_spec rt = {
+		.policy = SCHED_FIFO, .prio = 20,
+		.period_us = 1000, .run_us = 200, .duration_ms = 1500,
+	};
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int nr_spinners = 0, nr_rts = 0, cpu, i;
+	pid_t *spinners, *rts;
+	u64 checks = bss->nr_checks;
+	u64 end;
+
+	spinners = calloc(ctx->nr_cpus, sizeof(pid_t));
+	rts = calloc(ctx->nr_cpus, sizeof(pid_t));
+	if (!spinners || !rts) {
+		SCX_ERR("Failed to allocate");
+		goto out;
+	}
+
+	for (cpu = 0; cpu < ctx->nr_cpus; cpu++) {
+		if (!cpu_is_online(cpu))
+			continue;
+
+		spinners[nr_spinners] = spawn_task(&spinner);
+		if (spinners[nr_spinners] < 0) {
+			SCX_ERR("Failed to fork (%d)", errno);
+			goto out;
+		}
+		nr_spinners++;
+
+		rt.cpu = cpu;
+		rts[nr_rts] = spawn_task(&rt);
+		if (rts[nr_rts] < 0) {
+			SCX_ERR("Failed to fork (%d)", errno);
+			goto out;
+		}
+		nr_rts++;
+	}
+
+	/* flip a spinner between SCX and RT while the RT tasks run */
+	end = now_ns() + 1500 * 1000000ULL;
+	for (i = 0; now_ns() < end; i++) {
+		if (set_policy(spinners[0], i % 2 ? SCHED_OTHER : SCHED_FIFO,
+			       i % 2 ? 0 : 1)) {
+			SCX_ERR("Failed to set policy (%d)", errno);
+			goto out;
+		}
+		sleep_ms(2);
+	}
+
+	for (i = 0; i < nr_rts; i++) {
+		if (!wait_task(rts[i])) {
+			SCX_ERR("RT task failed");
+			rts[i] = -1;
+			goto out;
+		}
+		rts[i] = -1;
+	}
+
+	if (bss->nr_checks <= checks || bss->nr_violations) {
+		SCX_ERR("checks %lu -> %lu, violations %lu", checks,
+			bss->nr_checks, bss->nr_violations);
+		goto out;
+	}
+
+	ret = SCX_TEST_PASS;
+out:
+	for (i = 0; i < nr_rts; i++)
+		kill_task(rts[i]);
+	for (i = 0; i < nr_spinners; i++)
+		kill_task(spinners[i]);
+	free(spinners);
+	free(rts);
+	return ret;
+}
+
+/*
+ * Neither callback may be invoked between ops.cpu_offline() and
+ * ops.cpu_online(), and the CPU must be acquired after ops.cpu_online().
+ */
+static enum scx_test_status test_hotplug(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = ctx->tgt_cpu;
+	char path[64];
+	u64 acq;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	if (access(path, W_OK)) {
+		fprintf(stderr, "CPU %d can't be offlined, skipping hotplug\n", cpu);
+		return SCX_TEST_PASS;
+	}
+
+	/*
+	 * The kernel releases the CPU right before ops.cpu_offline(), which
+	 * updates the BPF side without holding the rq lock. Don't check the
+	 * CPU while it's being hotplugged.
+	 */
+	bss->hp_cpu = cpu;
+	bss->hp_busy = true;
+
+	acq = bss->nr_acquires[cpu];
+	if (file_write_long(path, 0)) {
+		SCX_ERR("Failed to offline CPU %d", cpu);
+		goto out;
+	}
+	if (!bss->offline[cpu]) {
+		SCX_ERR("ops.cpu_offline() not called for CPU %d", cpu);
+		goto out;
+	}
+	sleep_ms(100);
+
+	if (file_write_long(path, 1)) {
+		SCX_ERR("Failed to online CPU %d", cpu);
+		goto out;
+	}
+	if (bss->offline[cpu] ||
+	    !WAIT_FOR(bss->nr_acquires[cpu] > acq && bss->acquired[cpu], 500)) {
+		SCX_ERR("CPU %d not acquired after onlining", cpu);
+		goto out;
+	}
+	ret = SCX_TEST_PASS;
+out:
+	bss->hp_busy = false;
+	if (ret != SCX_TEST_PASS)
+		return ret;
+	SCX_EQ(bss->nr_offline_cbs, 0);
+	return SCX_TEST_PASS;
+}
+
+/*
+ * In partial mode, only SCHED_EXT tasks are SCX tasks and fair tasks
+ * take the CPU away from the BPF scheduler: idle -> fair, SCX -> fair
+ * preemption and an SCX task switching to SCHED_OTHER must release the CPU
+ * with SCX_CPU_PREEMPT_FAIR or SCX_CPU_PREEMPT_CLASS_CHANGE.
+ */
+static enum scx_test_status partial_scenarios(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	struct task_spec fair = {
+		.cpu = ctx->tgt_cpu, .policy = SCHED_OTHER,
+		.period_us = 5000, .run_us = 500, .duration_ms = 300,
+	};
+	int cpu = ctx->tgt_cpu;
+	enum scx_test_status ret;
+	u64 rels, idle, acq;
+	pid_t pid, hog;
+
+	/* idle -> fair -> idle */
+	fprintf(stderr, "cpu_avail: partial idle_to_fair on CPU %d\n", cpu);
+	rels = bss->nr_reasons[cpu][REASON(FAIR)];
+	idle = bss->nr_idle_releases[cpu];
+	acq = bss->nr_acquires[cpu];
+	pid = spawn_task(&fair);
+	SCX_FAIL_IF(pid < 0, "Failed to fork (%d)", errno);
+	SCX_FAIL_IF(!wait_task(pid), "fair task failed");
+	SCX_GT(bss->nr_reasons[cpu][REASON(FAIR)], rels);
+	SCX_GT(bss->nr_idle_releases[cpu], idle);
+	SCX_GT(bss->nr_acquires[cpu], acq);
+	SCX_ASSERT(WAIT_FOR(bss->acquired[cpu], 100));
+
+	/* a fair task preempting an SCX task */
+	fprintf(stderr, "cpu_avail: partial scx_to_fair on CPU %d\n", cpu);
+	hog = spawn_hog(ctx, SCHED_EXT);
+	SCX_FAIL_IF(hog < 0, "Failed to fork (%d)", errno);
+	if (!WAIT_FOR(bss->acquired[cpu], 500)) {
+		stop_hog(ctx, hog);
+		SCX_FAIL("CPU %d not acquired", cpu);
+	}
+	/* only count releases from put_prev_task_scx() of the hog */
+	rels = bss->nr_hog_fair_releases[cpu];
+	acq = bss->nr_acquires[cpu];
+	pid = spawn_task(&fair);
+	if (pid < 0 || !wait_task(pid)) {
+		stop_hog(ctx, hog);
+		SCX_FAIL("fair task failed");
+	}
+	stop_hog(ctx, hog);
+	SCX_GT(bss->nr_hog_fair_releases[cpu], rels);
+	SCX_GT(bss->nr_acquires[cpu], acq);
+
+	/* SCHED_EXT -> SCHED_OTHER on a running task */
+	fprintf(stderr, "cpu_avail: partial class_change on CPU %d\n", cpu);
+	ret = class_change(ctx, SCHED_EXT, SCHED_OTHER, 0);
+	if (ret != SCX_TEST_PASS)
+		return ret;
+
+	return check_consistency(ctx->skel);
+}
+
+static enum scx_test_status test_partial(struct cpu_avail_ctx *ctx)
+{
+	struct cpu_avail *main_skel = ctx->skel;
+	enum scx_test_status ret;
+	struct bpf_link *link;
+
+	ctx->skel = cpu_avail_open_load();
+	if (!ctx->skel) {
+		ctx->skel = main_skel;
+		SCX_FAIL("Failed to open and load skel");
+	}
+
+	ctx->skel->bss->partial = true;
+	link = bpf_map__attach_struct_ops(ctx->skel->maps.cpu_avail_partial_ops);
+	if (!link) {
+		ret = SCX_TEST_FAIL;
+		SCX_ERR("Failed to attach scheduler");
+	} else {
+		ctx->skel->bss->check_enabled = true;
+		ret = partial_scenarios(ctx);
+		bpf_link__destroy(link);
+	}
+
+	cpu_avail__destroy(ctx->skel);
+	ctx->skel = main_skel;
+	return ret;
+}
+
+/*
+ * Every scheduler instance starts with all CPUs released and must see an
+ * initial ops.cpu_acquire() for every online CPU, regardless of what the
+ * previous instance left behind.
+ */
+static enum scx_test_status test_reload(struct cpu_avail_ctx *ctx)
+{
+	enum scx_test_status ret;
+	int i, cpu;
+
+	for (i = 0; i < NR_RELOADS; i++) {
+		struct cpu_avail *skel;
+		struct bpf_link *link;
+
+		skel = cpu_avail_open_load();
+		SCX_FAIL_IF(!skel, "Failed to open and load skel");
+
+		link = bpf_map__attach_struct_ops(skel->maps.cpu_avail_ops);
+		if (!link) {
+			cpu_avail__destroy(skel);
+			SCX_FAIL("Failed to attach scheduler");
+		}
+		skel->bss->check_enabled = true;
+		sleep_ms(100);
+
+		ret = SCX_TEST_PASS;
+		for (cpu = 0; cpu < ctx->nr_cpus; cpu++) {
+			if (cpu_is_online(cpu) && !skel->bss->nr_acquires[cpu]) {
+				SCX_ERR("reload %d: CPU %d not acquired", i, cpu);
+				ret = SCX_TEST_FAIL;
+			}
+		}
+		if (ret == SCX_TEST_PASS)
+			ret = check_consistency(skel);
+
+		bpf_link__destroy(link);
+		cpu_avail__destroy(skel);
+		if (ret != SCX_TEST_PASS)
+			return ret;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctxp)
+{
+	struct cpu_avail_ctx *ctx;
+	int cpu;
+
+	ctx = calloc(1, sizeof(*ctx));
+	SCX_FAIL_IF(!ctx, "Failed to allocate");
+
+	ctx->nr_cpus = libbpf_num_possible_cpus();
+	ctx->ctl_cpu = -1;
+	ctx->tgt_cpu = -1;
+	for (cpu = 0; cpu < ctx->nr_cpus; cpu++) {
+		if (!cpu_is_online(cpu))
+			continue;
+		if (ctx->ctl_cpu < 0)
+			ctx->ctl_cpu = cpu;
+		else
+			ctx->tgt_cpu = cpu;
+	}
+	if (ctx->tgt_cpu < 0) {
+		fprintf(stderr, "Needs at least 2 online CPUs\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	if (sched_getaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask) ||
+	    pin_to_cpu(0, ctx->ctl_cpu)) {
+		SCX_ERR("Failed to pin to CPU %d", ctx->ctl_cpu);
+		free(ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	ctx->skel = cpu_avail_open_load();
+	if (!ctx->skel) {
+		sched_setaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask);
+		free(ctx);
+		SCX_FAIL("Failed to open and load skel");
+	}
+
+	*ctxp = ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *arg)
+{
+	struct cpu_avail_ctx *ctx = arg;
+	static const struct {
+		const char *name;
+		enum scx_test_status (*fn)(struct cpu_avail_ctx *ctx);
+	} tests[] = {
+		{ "idle_to_rt", test_idle_to_rt },
+		{ "class_change", test_class_change },
+		{ "remote_reenq", test_remote_reenq },
+		{ "pi_boost", test_pi_boost },
+		{ "churn", test_churn },
+		{ "hotplug", test_hotplug },
+	};
+	enum scx_test_status ret;
+	int i;
+
+	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.cpu_avail_ops);
+	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
+	ctx->skel->bss->check_enabled = true;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		fprintf(stderr, "cpu_avail: %s on CPU %d\n", tests[i].name,
+			ctx->tgt_cpu);
+		ret = tests[i].fn(ctx);
+		if (ret != SCX_TEST_PASS)
+			return ret;
+	}
+
+	ret = check_consistency(ctx->skel);
+	if (ret != SCX_TEST_PASS)
+		return ret;
+
+	bpf_link__destroy(ctx->link);
+	ctx->link = NULL;
+	ctx->skel->bss->check_enabled = false;
+
+	ret = test_partial(ctx);
+	if (ret != SCX_TEST_PASS)
+		return ret;
+
+	fprintf(stderr, "cpu_avail: reload\n");
+	return test_reload(ctx);
+}
+
+static void cleanup(void *arg)
+{
+	struct cpu_avail_ctx *ctx = arg;
+
+	bpf_link__destroy(ctx->link);
+	cpu_avail__destroy(ctx->skel);
+	sched_setaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask);
+	free(ctx);
+}
+
+struct scx_test cpu_avail = {
+	.name = "cpu_avail",
+	.description = "Verify that ops.cpu_acquire/release() track CPU availability",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&cpu_avail)
diff --git a/tools/testing/selftests/sched_ext/cpu_avail.h b/tools/testing/selftests/sched_ext/cpu_avail.h
new file mode 100644
index 000000000000..97659e1061b8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_avail.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helpers shared by the cpu_avail and cpu_avail_core tests.
+ */
+#ifndef __CPU_AVAIL_H__
+#define __CPU_AVAIL_H__
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <scx/common.h>
+#include "cpu_avail.bpf.skel.h"
+#include "scx_test.h"
+#include "util.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#endif
+
+#ifndef SCHED_EXT
+#define SCHED_EXT	7
+#endif
+
+#define REASON(__name)							\
+	__COMPAT_ENUM_OR_ZERO("scx_cpu_preempt_reason", "SCX_CPU_PREEMPT_" #__name)
+
+static inline u64 now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static inline void spin_us(u64 us)
+{
+	u64 end = now_ns() + us * 1000;
+
+	while (now_ns() < end)
+		;
+}
+
+static inline void sleep_ms(u64 ms)
+{
+	usleep(ms * 1000);
+}
+
+static inline int pin_to_cpu(pid_t pid, int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(pid, sizeof(mask), &mask);
+}
+
+static inline int set_policy(pid_t pid, int policy, int prio)
+{
+	struct sched_param param = { .sched_priority = prio };
+
+	return sched_setscheduler(pid, policy, &param);
+}
+
+static inline bool cpu_is_online(int cpu)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d", cpu);
+	if (access(path, F_OK))
+		return false;
+
+	/* CPUs which can't be offlined don't have the file */
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	if (access(path, F_OK))
+		return true;
+
+	return file_read_long(path) > 0;
+}
+
+/*
+ * What a forked task does once it's been released. @period_us == 0 means spin
+ * forever. Otherwise, sleep for @period_us - @run_us and then spin for @run_us
+ * in a loop for @duration_ms.
+ */
+struct task_spec {
+	int cpu;		/* -1 for no affinity */
+	int policy;
+	int prio;
+	u64 period_us;
+	u64 run_us;
+	u64 duration_ms;
+};
+
+static inline void task_body(const struct task_spec *spec)
+{
+	u64 end;
+
+	if (!spec->period_us) {
+		while (true)
+			spin_us(1000);
+	}
+
+	end = now_ns() + spec->duration_ms * 1000000ULL;
+	while (now_ns() < end) {
+		usleep(spec->period_us - spec->run_us);
+		spin_us(spec->run_us);
+	}
+}
+
+/*
+ * Fork a task according to @spec. The child blocks until start_task() is
+ * called on the returned pid so that the caller can set things up for it
+ * first. Returns the child's pid, or -1 on failure. @go_fd receives the write
+ * end of the pipe that releases the child.
+ */
+static inline pid_t fork_task(const struct task_spec *spec, int *go_fd)
+{
+	int fds[2];
+	pid_t pid;
+	char c;
+
+	if (pipe(fds))
+		return -1;
+
+	pid = fork();
+	if (pid < 0) {
+		close(fds[0]);
+		close(fds[1]);
+		return -1;
+	}
+
+	if (!pid) {
+		close(fds[1]);
+		if (read(fds[0], &c, 1) != 1)
+			exit(EXIT_FAILURE);
+		close(fds[0]);
+		if (spec->cpu >= 0 && pin_to_cpu(0, spec->cpu))
+			exit(EXIT_FAILURE);
+		if (spec->policy != SCHED_OTHER &&
+		    set_policy(0, spec->policy, spec->prio))
+			exit(EXIT_FAILURE);
+		task_body(spec);
+		exit(EXIT_SUCCESS);
+	}
+
+	close(fds[0]);
+	*go_fd = fds[1];
+	return pid;
+}
+
+static inline void start_task(int go_fd)
+{
+	char c = 1;
+
+	if (write(go_fd, &c, 1) != 1)
+		perror("write");
+	close(go_fd);
+}
+
+static inline pid_t spawn_task(const struct task_spec *spec)
+{
+	int go_fd;
+	pid_t pid;
+
+	pid = fork_task(spec, &go_fd);
+	if (pid > 0)
+		start_task(go_fd);
+	return pid;
+}
+
+static inline bool wait_task(pid_t pid)
+{
+	int status;
+
+	if (waitpid(pid, &status, 0) != pid)
+		return false;
+	return WIFEXITED(status) && WEXITSTATUS(status) == EXIT_SUCCESS;
+}
+
+static inline void kill_task(pid_t pid)
+{
+	if (pid <= 0)
+		return;
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+}
+
+static inline struct cpu_avail *cpu_avail_open_load(void)
+{
+	struct cpu_avail *skel;
+
+	skel = cpu_avail__open();
+	if (!skel)
+		return NULL;
+	SCX_ENUM_INIT(skel);
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	if (cpu_avail__load(skel))
+		goto err;
+
+	/* attach the sched_switch checker, a struct_ops is attached later */
+	bpf_map__set_autoattach(skel->maps.cpu_avail_ops, false);
+	bpf_map__set_autoattach(skel->maps.cpu_avail_partial_ops, false);
+	if (cpu_avail__attach(skel))
+		goto err;
+
+	return skel;
+err:
+	cpu_avail__destroy(skel);
+	return NULL;
+}
+
+/* common checks on the state accumulated by the BPF side */
+static inline enum scx_test_status check_consistency(struct cpu_avail *skel)
+{
+	struct cpu_avail__bss *bss = skel->bss;
+
+	if (bss->nr_violations)
+		SCX_ERR("first violation: cpu=%d pid=%d prio=%d acquired=%d",
+			bss->violation_cpu, bss->violation_pid,
+			bss->violation_prio, bss->violation_acquired);
+	SCX_EQ(bss->nr_violations, 0);
+	SCX_GT(bss->nr_checks, 0);
+	SCX_EQ(bss->nr_dbl_acquires, 0);
+	SCX_EQ(bss->nr_dbl_releases, 0);
+	SCX_EQ(bss->nr_offline_cbs, 0);
+	return SCX_TEST_PASS;
+}
+
+#endif /* __CPU_AVAIL_H__ */
diff --git a/tools/testing/selftests/sched_ext/cpu_avail_core.c b/tools/testing/selftests/sched_ext/cpu_avail_core.c
new file mode 100644
index 000000000000..971c4d37eb78
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_avail_core.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify ops.cpu_acquire/release() under core scheduling. A CPU which is
+ * forced idle stays available to the BPF scheduler, while an RT task with a
+ * matching cookie running on it releases it.
+ */
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+#include "cpu_avail.h"
+
+#ifndef PR_SCHED_CORE
+#define PR_SCHED_CORE			62
+#endif
+#ifndef PR_SCHED_CORE_CREATE
+#define PR_SCHED_CORE_CREATE		1
+#endif
+#ifndef PR_SCHED_CORE_SHARE_FROM
+#define PR_SCHED_CORE_SHARE_FROM	3
+#endif
+#ifndef PR_SCHED_CORE_SCOPE_THREAD
+#define PR_SCHED_CORE_SCOPE_THREAD	0
+#endif
+
+struct core_ctx {
+	struct cpu_avail *skel;
+	struct bpf_link *link;
+	cpu_set_t orig_mask;
+	int sib[2];		/* SMT siblings under test */
+	int ctl_cpu;		/* where the test itself runs, not a sibling */
+};
+
+static bool find_siblings(int cpu, int sib[2])
+{
+	char path[128], buf[64];
+	FILE *f;
+	bool ret;
+
+	snprintf(path, sizeof(path),
+		 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", cpu);
+	f = fopen(path, "r");
+	if (!f)
+		return false;
+	ret = fgets(buf, sizeof(buf), f) &&
+	      sscanf(buf, "%d%*[,-]%d", &sib[0], &sib[1]) == 2 &&
+	      sib[0] != sib[1];
+	fclose(f);
+	return ret;
+}
+
+static int core_cookie_create(pid_t pid)
+{
+	return prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid,
+		     PR_SCHED_CORE_SCOPE_THREAD, 0);
+}
+
+/* fork a spinner pinned to @cpu with a cookie of its own */
+static pid_t spawn_cookie_spinner(int cpu)
+{
+	struct task_spec spec = { .cpu = cpu, .policy = SCHED_OTHER };
+	int go_fd;
+	pid_t pid;
+
+	pid = fork_task(&spec, &go_fd);
+	if (pid < 0)
+		return pid;
+
+	if (core_cookie_create(pid)) {
+		int err = errno;
+
+		close(go_fd);
+		kill_task(pid);
+		errno = err;
+		return -1;
+	}
+
+	start_task(go_fd);
+	return pid;
+}
+
+/* fork a periodic RT task pinned to @cpu sharing @cookie_pid's cookie */
+static pid_t spawn_cookie_rt(int cpu, pid_t cookie_pid)
+{
+	struct task_spec spec = {
+		.cpu = cpu, .policy = SCHED_FIFO, .prio = 10,
+		.period_us = 5000, .run_us = 1000, .duration_ms = 1000,
+	};
+	pid_t pid;
+
+	pid = fork();
+	if (pid)
+		return pid;
+
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, cookie_pid,
+		  PR_SCHED_CORE_SCOPE_THREAD, 0))
+		exit(EXIT_FAILURE);
+	if (pin_to_cpu(0, spec.cpu) || set_policy(0, spec.policy, spec.prio))
+		exit(EXIT_FAILURE);
+	task_body(&spec);
+	exit(EXIT_SUCCESS);
+}
+
+static enum scx_test_status setup(void **ctxp)
+{
+	struct core_ctx *ctx;
+	int nr_cpus = libbpf_num_possible_cpus();
+	int cpu;
+
+	ctx = calloc(1, sizeof(*ctx));
+	SCX_FAIL_IF(!ctx, "Failed to allocate");
+
+	ctx->ctl_cpu = -1;
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (cpu_is_online(cpu) && find_siblings(cpu, ctx->sib))
+			break;
+	}
+	if (cpu == nr_cpus || !cpu_is_online(ctx->sib[0]) ||
+	    !cpu_is_online(ctx->sib[1])) {
+		fprintf(stderr, "No online SMT siblings\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (cpu_is_online(cpu) && cpu != ctx->sib[0] && cpu != ctx->sib[1]) {
+			ctx->ctl_cpu = cpu;
+			break;
+		}
+	}
+	if (ctx->ctl_cpu < 0) {
+		fprintf(stderr, "No online CPU outside of the SMT siblings\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	/* the test itself shouldn't share the core */
+	if (sched_getaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask) ||
+	    pin_to_cpu(0, ctx->ctl_cpu)) {
+		SCX_ERR("Failed to pin to CPU %d", ctx->ctl_cpu);
+		free(ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	ctx->skel = cpu_avail_open_load();
+	if (!ctx->skel) {
+		sched_setaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask);
+		free(ctx);
+		SCX_FAIL("Failed to open and load skel");
+	}
+
+	*ctxp = ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *arg)
+{
+	struct core_ctx *ctx = arg;
+	struct cpu_avail__bss *bss = ctx->skel->bss;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	pid_t spinners[2] = { -1, -1 }, rt = -1;
+	u64 unknown[2], idle[2], rels[2], rt_rels, acqs;
+	int *sib = ctx->sib, i;
+
+	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.cpu_avail_ops);
+	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
+	bss->check_enabled = true;
+
+	fprintf(stderr, "cpu_avail_core: siblings %d,%d\n", sib[0], sib[1]);
+
+	/* SCX tasks with different cookies on the siblings force idle */
+	for (i = 0; i < 2; i++) {
+		spinners[i] = spawn_cookie_spinner(sib[i]);
+		if (spinners[i] < 0) {
+			if (errno == EINVAL || errno == ENODEV) {
+				fprintf(stderr, "Core scheduling not supported (%d)\n",
+					errno);
+				ret = SCX_TEST_SKIP;
+			} else {
+				SCX_ERR("Failed to fork (%d)", errno);
+			}
+			goto out;
+		}
+	}
+	sleep_ms(100);
+
+	for (i = 0; i < 2; i++) {
+		unknown[i] = bss->nr_reasons[sib[i]][REASON(UNKNOWN)];
+		idle[i] = bss->nr_idle_switches[sib[i]];
+		rels[i] = bss->nr_releases[sib[i]];
+	}
+	sleep_ms(1000);
+
+	for (i = 0; i < 2; i++) {
+		fprintf(stderr, "cpu_avail_core: CPU %d: %lu idle switches, %lu releases\n",
+			sib[i], bss->nr_idle_switches[sib[i]] - idle[i],
+			bss->nr_releases[sib[i]] - rels[i]);
+		if (bss->nr_reasons[sib[i]][REASON(UNKNOWN)] != unknown[i]) {
+			SCX_ERR("CPU %d released while forced idle", sib[i]);
+			goto out;
+		}
+	}
+	if (bss->nr_idle_switches[sib[0]] == idle[0] &&
+	    bss->nr_idle_switches[sib[1]] == idle[1]) {
+		SCX_ERR("No forced idle observed");
+		goto out;
+	}
+
+	/* an RT task matching sib[0]'s cookie runs on sib[1] */
+	rt_rels = bss->nr_reasons[sib[1]][REASON(RT)];
+	acqs = bss->nr_acquires[sib[1]];
+	rt = spawn_cookie_rt(sib[1], spinners[0]);
+	if (rt < 0) {
+		SCX_ERR("Failed to fork (%d)", errno);
+		goto out;
+	}
+	if (!wait_task(rt)) {
+		rt = -1;
+		SCX_ERR("RT task failed");
+		goto out;
+	}
+	rt = -1;
+
+	fprintf(stderr, "cpu_avail_core: CPU %d: %lu RT releases, %lu acquires\n",
+		sib[1], bss->nr_reasons[sib[1]][REASON(RT)] - rt_rels,
+		bss->nr_acquires[sib[1]] - acqs);
+	if (bss->nr_reasons[sib[1]][REASON(RT)] == rt_rels ||
+	    bss->nr_acquires[sib[1]] == acqs) {
+		SCX_ERR("CPU %d not released and acquired around the RT task", sib[1]);
+		goto out;
+	}
+
+	ret = check_consistency(ctx->skel);
+out:
+	kill_task(rt);
+	for (i = 0; i < 2; i++)
+		kill_task(spinners[i]);
+	return ret;
+}
+
+static void cleanup(void *arg)
+{
+	struct core_ctx *ctx = arg;
+
+	bpf_link__destroy(ctx->link);
+	cpu_avail__destroy(ctx->skel);
+	sched_setaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask);
+	free(ctx);
+}
+
+struct scx_test cpu_avail_core = {
+	.name = "cpu_avail_core",
+	.description = "Verify ops.cpu_acquire/release() under core scheduling",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&cpu_avail_core)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 04a369078aac..c2ee5437df65 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -67,6 +67,14 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
 {}
 
+void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
+		    struct scx_cpu_acquire_args *args)
+{}
+
+void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
+		    struct scx_cpu_release_args *args)
+{}
+
 SEC("tp_btf/sched_switch")
 int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
 	     struct task_struct *next, unsigned int prev_state)
@@ -149,6 +157,8 @@ struct sched_ext_ops maximal_ops = {
 	.set_weight		= (void *) maximal_set_weight,
 	.set_cpumask		= (void *) maximal_set_cpumask,
 	.update_idle		= (void *) maximal_update_idle,
+	.cpu_acquire		= (void *) maximal_cpu_acquire,
+	.cpu_release		= (void *) maximal_cpu_release,
 	.cpu_online		= (void *) maximal_cpu_online,
 	.cpu_offline		= (void *) maximal_cpu_offline,
 	.init_task		= (void *) maximal_init_task,
-- 
2.56.0.176.g3575e65682-goog

