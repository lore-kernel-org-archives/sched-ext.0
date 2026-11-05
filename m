Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909026;
	b=RXlwTNr41qTHTLf9zENDiV39M9x+Lw9f8LnckJnZwFXjNU0mF04ABQqmSUxwMl8i7bog
	 LIRPMHTnU1sF7s+mBdtwhz4i3XUiAskb/VkpJya8UXwG7A+ly36E9FkwkmoYIuqbMb8PM
	 zp8uW88cZBErLyIP9Gh8o7KANmodA4P+qWdsiDUkBKx/iFcZH1yP6O64k3nZ7nCPGGqyp
	 NfDMh8HYrMouV23c4y1ZhXPIuu4YNcgtwAcqtR2vO6h/Zlm489q1T4G7zCE/Psq/puhVe
	 fXqJcGoezGkWz+F0bncCTPw7j/2qkzSqB+ghJu8G7ALtun/Y5hftKMAu4lmdKEvEMeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AHnL6HTnCc0Zd3BawHZgPaOdgGgFkN/Y22u/KUXamYI=;
	b=tee+8ZFavuSois0KNVvCtWl0mLY4kd6p00qwSmsQLaK76f/TABl5XFLIKeEaiulJpC6S
	 FzwAFXaknXU1DBBv/3i/cwqerf3V2RrbVd4zvsYUsjfuyiratN9Ff2otbcb56jSZps0Au
	 YEUqDwh808hFTqkjukJaa1Y5V+n47CRQOgFPIfaFeisulawcYq5tDJiC6M+mDqwN03c15
	 2isxZrWGjlt5w0u35QAMACEUTmwNVM0tuAvDUXGvT/M5AH8iBfSws5BwQX+RTmPCdLHPX
	 d3Kcu14xwK6X1vakRfto3y43sqk09pDEGSCMNTGz+NH4Lv2XWF08ltjzDru6wiz4QOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLN5BlYd;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1826606A31B
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 20:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1826606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLN5BlYd
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso25145015e9.1
        for <sched-ext@lists.linux.dev>; Thu, 05 Nov 2026 12:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909024; x=1794513824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHnL6HTnCc0Zd3BawHZgPaOdgGgFkN/Y22u/KUXamYI=;
        b=GLN5BlYdizTfrmVT+1J+Z2GWzG5X/p4ut708yMmbvEdOBVE+56mdoalPAswIc56+L5
         JAmZUgzLhHmyNqvj35f3yb8PaOwTve8RDfSSr1Q0I0Bqnmwx8BCs19KBrGDTbDN8F2Et
         USKRsLl94sa4wTfirig+GRMieoR3D/qAibTTuiTaQKIwc5KxFqGcVr636YE/lVXJldXK
         51UN1BwxigdcvbdcGFoc2BOvlHpdRLz5/BZHuFBtgcM4IS9A0dge2LftZRtlf74eWgAa
         Zj6XVHsaFp6EmsYnw+5kgYdGye/3bjvcup5WPVVU4mbFLXZkFhMcvBxUoXJQMQYfnUPF
         ZeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909024; x=1794513824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHnL6HTnCc0Zd3BawHZgPaOdgGgFkN/Y22u/KUXamYI=;
        b=hgtbHMX6ABkOpbU8VG8jqPxSkwJJVM53GankbYU43BUWQ5YucN0IfA+XwtH7z9EZxG
         5dl9yb3Rydr1y+9HBktRoKAW8kWwrhcP1YjByPUNgl/6oShnk6qUz0tnQ7cSoPi4ZT0C
         Bs6F2uff2N1+jqGU37rSV2M28jegFLIP38nH5sYOT0+3mLx1qsjkI8WLt1bhCIvLVG0U
         GLb4SjHiFr3o61+0GQKi2NoyWIR4PodAO9xgFBm3jxGFrws8MJcbNflPD7F0I9fjrdjy
         oqLOoztn1ch2vIZkGFPT31FQys7hHc0Czh2o9OODbQiZ87IPk2WGvr9otIVyHUjZYZ71
         2a/A==
X-Forwarded-Encrypted: i=1; AKwUvBy+hTxLOAECvtetHee7CxfX4Utx1a9rilwFnvymX3mMqvwwm+MHrlO1O+bCWFAN95k7FtVA1gT32Dk=@lists.linux.dev
X-Gm-Message-State: APuU4Z+d69eSqedXIaY77tNIi7NcxAKtAvyflxUlAguT57BsCMcMXdh2
	mTRkqoUBCrB9WT6mQFqkFAKeTWUV6JCIrEM/qir90YEaiJ981d7CRBIN
X-Gm-Gg: AYBFou3YjJf24EFUVwg9sTE3f0pqKuDnAkZwpdVA1mtHPr6w3VppR5RS+h8dcqQ4+uN
	mtqRqXDvT1gNkZ452Ifw6JxBHc2KHD2B7HDZEyVqetp2cxh7jp1mVx9HLYIz/f6Kje/3Nkp4+dX
	YTk3fCTPPV+e5erK6GMxkJO/9MoqbXDFu3JRSpoNemgYkG16n3aD8+DW67DsenhwKaXXzqgyIpn
	gjfcfuGflfROTlRFGk2bYBSUAhIFRSRybGp9LLDLTgVXbck0+PxDXq3aR1LziwfkZHTaEMOn4Pt
	hXzfzT1JxEHa90gV6g0FAd6Zran5lblrYuJ3USXOEU6tRAaFj10rSGyu4cD+W4dXlrORDcxRRus
	pOEjEs2EWfdc/tWgsOt0sREiOfuxiLGl2pQoFe4AijyxX6nH1VJyzQcLGwm4Z+CcBGtZ5Y/uNvN
	nxGg26u0G9OgwH7BTwwctAZMo4qOP5RuUSlHjThFhl3Xhj0VH/+OVRexLs6gWF7bBAH5XGfo8kK
	xMbhWOjauYAtXBP+3rAVZdjn3gdmFTEsIOwOerOCJojfumpsON6n4VfKWvp5umqOySLQlJgauPR
	Nkjv9q9WQxZT1bzxooYU1qD8CYdjRYEO1Gu5E9j+Y0A04MRI9QMEQ4dgfbtwBj/OIhEpNTdZcZp
	/ag==
X-Received: by 2002:a05:600c:83c3:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4b6dd54b63cmr3631345e9.8.1793909023879;
        Thu, 05 Nov 2026 12:03:43 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm88965055e9.13.2026.11.05.12.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:03:43 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	tglx@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Radu Toader <radu.m.toader@gmail.com>
Subject: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
Date: Thu,  5 Nov 2026 20:02:04 +0000
Message-ID: <20261105200205.1178097-2-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105200205.1178097-1-radu.m.toader@gmail.com>
References: <20261105200205.1178097-1-radu.m.toader@gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The state behind the tick_irq_exit() gate - the idle task running on a
CPU whose run queue is not empty - is reachable with the existing
example schedulers but not holdable with them, which makes everything
that depends on how long it lasts impossible to measure.

enqueue_task_scx() raises rq->nr_running before it calls ops.enqueue(),
so a scheduler that stashes the task in a map of its own leaves it
runnable and accounted on that CPU with nothing for the CPU to pick.
scx_central already does exactly that, and then calls
scx_bpf_kick_cpu() immediately, so the window is microseconds wide.

This scheduler is the same thing with the kick removed: a tagged task
is parked on the target CPU's run queue and released only by a timer
pinned to another CPU, so the window is as wide as -H says. Untagged
tasks go through a shared DSQ and per-CPU kthreads keep their local DSQ
and preemption, so the machine stays usable and the timer's softirq
cannot be starved.

Two things it has to get right, both of which cost a measurement round
before they were found. The release timer must kick @target_cpu only
when something is actually held: an unconditional SCX_KICK_PREEMPT
lands on the task released a moment earlier and throws it off the CPU
mid-run, whereupon ops.enqueue() holds it again, and the load then
reports using half the CPU it asked for. And a tagged task that is
already running goes straight back into the local DSQ instead of being
held, so the hold only ever delays the start of a run - the state the
gate under test mis-judges - and never interrupts one. nr_requeue
counts the second case so a run can show whether it happened.

It reports the mean and worst hold it actually achieved, which is the
independent variable of any experiment using it and is not otherwise
observable from userspace. Do not use a hold that divides the load's
period: with a 100 ms spinner, holds of 5/10/20 ms phase-lock and the
task is only ever held for microseconds.

Tooling: written by Claude Opus 5 (Claude Code) while measuring what
the tick_irq_exit() idle gate changes. All of this patch is
tool-generated.

Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
---
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/README.md         |  13 ++
 tools/sched_ext/scx_tickbug.bpf.c | 364 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_tickbug.c     | 166 ++++++++++++++
 4 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_tickbug.bpf.c
 create mode 100644 tools/sched_ext/scx_tickbug.c

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 70d2503b6b33..02e1500bf402 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -191,7 +191,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_tickbug scx_flatcg scx_userland scx_pair scx_sdt
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 0ee5a3d997e5..4addc7c2ed23 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -185,6 +185,19 @@ where this could be particularly useful is running VMs, where running with
 infinite slices and no timer ticks allows the VM to avoid unnecessary expensive
 vmexits.
 
+## scx_tickbug
+
+A scheduler whose only job is to keep one task runnable on a CPU that is in the
+idle loop, for a length of time given on the command line. That state - the
+idle task running while the run queue is not empty - is reachable by several of
+the schedulers here, but none of them holds it long enough to observe what
+depends on it. Tasks named "spin" are parked on the target CPU's run queue and
+released only by a periodic timer; everything else runs through a shared DSQ so
+the machine stays usable.
+
+This is a test scheduler, not a policy. It exists so that the idle-time
+bookkeeping skipped by an interrupt taken in that state can be measured.
+
 ## scx_flatcg
 
 A flattened cgroup hierarchy scheduler. This scheduler implements hierarchical
diff --git a/tools/sched_ext/scx_tickbug.bpf.c b/tools/sched_ext/scx_tickbug.bpf.c
new file mode 100644
index 000000000000..e6a6d627f042
--- /dev/null
+++ b/tools/sched_ext/scx_tickbug.bpf.c
@@ -0,0 +1,364 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * scx_tickbug: keep a task runnable on a CPU that is in the idle loop.
+ *
+ * This scheduler exists to hold one state for a controllable length of time:
+ * the idle task running on a CPU whose run queue is not empty.
+ *
+ * enqueue_task_scx() raises rq->nr_running before it calls ops.enqueue(), so a
+ * BPF scheduler that stashes the task somewhere of its own - here a BPF queue
+ * map - leaves it runnable and accounted on that CPU with nothing for the CPU
+ * to pick. The CPU enters the idle loop and stays there. In that state
+ * idle_cpu() is false, because idle_rq() tests rq->nr_running, while
+ * is_idle_task(current) is true.
+ *
+ * tick_irq_exit() used to ask idle_cpu(), so every interrupt taken in that
+ * idle loop skipped tick_nohz_irq_exit(). Each skip leaves TS_FLAG_IDLE_ACTIVE
+ * clear, and the next exit from the idle loop then also skips
+ * sched_clock_idle_wakeup_event(), so with an unstable sched_clock the CPU's
+ * clock is never resynchronized: the task picked next starts with a stale
+ * exec_start and the next tick charges it the whole idle stretch.
+ *
+ * The in-tree example schedulers can reach this state but not hold it.
+ * scx_central stashes a task in a BPF queue exactly like this, then
+ * immediately calls scx_bpf_kick_cpu(), so the window is microseconds wide and
+ * nothing measurable accumulates. Here the only thing that releases a held
+ * task is a periodic timer, so the window is hold_ns wide and can be swept.
+ *
+ * Only tasks named by @tag_comm are held; everything else runs through a
+ * shared DSQ so the machine stays usable while the test runs.
+ *
+ * Copyright (c) 2026 Radu Toader
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	SHARED_DSQ	= 0,
+	MS_TO_NS	= 1000LLU * 1000,
+};
+
+/* CPU whose run queue holds the tagged task while the CPU idles. */
+const volatile s32 target_cpu;
+/* CPU the release timer is pinned to. Must not be @target_cpu. */
+const volatile s32 timer_cpu = 1;
+/* How long a tagged task is held before it is allowed to run. */
+const volatile u64 hold_ns = 10 * MS_TO_NS;
+const volatile u64 slice_ns;
+const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
+
+bool timer_pinned = true;
+bool timer_started;
+
+/*
+ * Set by the release timer, consumed by ops.dispatch() on @target_cpu. Without
+ * it ops.dispatch() would hand the held task straight back out, because the
+ * core calls ops.dispatch() whenever the CPU is about to go idle.
+ */
+bool release_now;
+
+u64 nr_enq, nr_held, nr_released, nr_timers;
+u64 nr_passthru, nr_locals, nr_lost, nr_other_cpu, nr_overflow, nr_requeue;
+/*
+ * How many tagged tasks are held right now. The release timer only kicks when
+ * this is non-zero: a kick with nothing held would preempt whatever is running
+ * on @target_cpu, and since that is normally the task just released, the task
+ * would lose most of its CPU to its own release mechanism. The first version of
+ * this scheduler did exactly that and reported half the usage it should.
+ */
+u64 nr_held_now;
+/* Proof that the hold actually happened, and how wide it was. */
+u64 held_at, total_held_ns, max_held_ns;
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1024);
+	__type(value, s32);
+} hold_q SEC(".maps");
+
+struct tickbug_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct tickbug_timer);
+} release_timer SEC(".maps");
+
+/*
+ * The load generator is called "spin". Compare 5 bytes so the terminating NUL
+ * has to match too and a longer name starting with "spin" is not held.
+ */
+static bool is_tagged(struct task_struct *p)
+{
+	return !bpf_strncmp(p->comm, 5, "spin");
+}
+
+s32 BPF_STRUCT_OPS(tickbug_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	if (is_tagged(p))
+		return target_cpu;
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(tickbug_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	__sync_fetch_and_add(&nr_enq, 1);
+
+	/*
+	 * Per-CPU kthreads go to the head of their own CPU's local DSQ with
+	 * preemption. The release timer runs from a softirq, so if a kthread
+	 * such as ksoftirqd were starved behind a user task the held task
+	 * would never be released.
+	 */
+	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		__sync_fetch_and_add(&nr_locals, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns,
+				   enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
+	if (is_tagged(p)) {
+		if (scx_bpf_task_cpu(p) != target_cpu) {
+			/*
+			 * ops.select_cpu() is only a hint and is not called on
+			 * every path. Counted rather than forced: a run with a
+			 * non-zero count here did not test what it meant to.
+			 */
+			__sync_fetch_and_add(&nr_other_cpu, 1);
+		} else if (scx_bpf_task_running(p)) {
+			/*
+			 * Already on the CPU and merely re-enqueued, e.g. after
+			 * a kthread preempted it. Holding it here would take
+			 * CPU away from work already in progress, which is not
+			 * the state under test: the hold belongs at the start
+			 * of a run, not in the middle of one. Put it straight
+			 * back so it carries on.
+			 */
+			__sync_fetch_and_add(&nr_requeue, 1);
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+			return;
+		} else if (bpf_map_push_elem(&hold_q, &pid, 0)) {
+			__sync_fetch_and_add(&nr_overflow, 1);
+		} else {
+			/*
+			 * This is the whole scheduler. The task is already in
+			 * target_cpu's rq->nr_running; parking its pid here
+			 * and deliberately not kicking the CPU leaves it in
+			 * the idle loop with a runnable task queued.
+			 */
+			held_at = scx_bpf_now() ?: 1;
+			__sync_fetch_and_add(&nr_held, 1);
+			__sync_fetch_and_add(&nr_held_now, 1);
+			return;
+		}
+	}
+
+	__sync_fetch_and_add(&nr_passthru, 1);
+	scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, enq_flags);
+}
+
+/* Let one held task run on the CPU we are dispatching for. */
+static bool release_one(void)
+{
+	struct task_struct *p;
+	s32 pid;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		u64 now, at;
+
+		if (bpf_map_pop_elem(&hold_q, &pid))
+			return false;
+
+		p = bpf_task_from_pid(pid);
+		if (!p) {
+			__sync_fetch_and_add(&nr_lost, 1);
+			__sync_fetch_and_sub(&nr_held_now, 1);
+			continue;
+		}
+
+		/*
+		 * Affinity may have changed while the task sat in the queue.
+		 * Such a task goes to the shared DSQ instead of being pinned
+		 * to a CPU it is no longer allowed on.
+		 */
+		if (!bpf_cpumask_test_cpu(target_cpu, p->cpus_ptr) ||
+		    is_migration_disabled(p)) {
+			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
+			bpf_task_release(p);
+			__sync_fetch_and_sub(&nr_held_now, 1);
+			if (!scx_bpf_dispatch_nr_slots())
+				return false;
+			continue;
+		}
+
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, 0);
+		bpf_task_release(p);
+		__sync_fetch_and_sub(&nr_held_now, 1);
+
+		at = held_at;
+		now = scx_bpf_now();
+		if (at && now > at) {
+			u64 d = now - at;
+
+			__sync_fetch_and_add(&total_held_ns, d);
+			if (d > max_held_ns)
+				max_held_ns = d;
+		}
+		held_at = 0;
+
+		__sync_fetch_and_add(&nr_released, 1);
+		return true;
+	}
+
+	return false;
+}
+
+static void start_release_timer(void)
+{
+	struct bpf_timer *timer;
+	u32 key = 0;
+	int ret;
+
+	if (likely(timer_started))
+		return;
+
+	timer = bpf_map_lookup_elem(&release_timer, &key);
+	if (!timer) {
+		scx_bpf_error("failed to look up the release timer");
+		return;
+	}
+
+	ret = bpf_timer_start(timer, hold_ns, BPF_F_TIMER_CPU_PIN);
+	if (ret == -EINVAL) {
+		/* BPF_F_TIMER_CPU_PIN needs >= 6.7 */
+		timer_pinned = false;
+		ret = bpf_timer_start(timer, hold_ns, 0);
+	}
+	if (ret) {
+		scx_bpf_error("bpf_timer_start failed (%d)", ret);
+		return;
+	}
+
+	timer_started = true;
+}
+
+void BPF_STRUCT_OPS(tickbug_dispatch, s32 cpu, struct task_struct *prev)
+{
+	/*
+	 * Arm the timer from the CPU it must be pinned to. ops.init() runs in
+	 * whatever context loaded the scheduler, which is the wrong CPU.
+	 */
+	if (cpu == timer_cpu)
+		start_release_timer();
+
+	if (cpu == target_cpu && release_now) {
+		release_now = false;
+		if (release_one())
+			return;
+	}
+
+	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
+}
+
+static int release_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	s32 curr_cpu = bpf_get_smp_processor_id();
+	int ret;
+
+	if (timer_pinned && curr_cpu == target_cpu) {
+		scx_bpf_error("release timer ran on the target CPU %d", curr_cpu);
+		return 0;
+	}
+
+	/*
+	 * Nothing held means @target_cpu is either idle with an empty run
+	 * queue or busy with the task released last time. Kicking in either
+	 * case is at best pointless and at worst preempts that task.
+	 */
+	if (!nr_held_now)
+		goto rearm;
+
+	/*
+	 * Allow one held task through and make @target_cpu notice.
+	 * SCX_KICK_PREEMPT sends a reschedule IPI, which does not go through
+	 * irq_enter() and so does not run tick_irq_exit() itself: it only ends
+	 * the idle stretch whose bookkeeping the mis-gated interrupts dropped.
+	 */
+	release_now = true;
+	scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT);
+
+rearm:
+
+	__sync_fetch_and_add(&nr_timers, 1);
+
+	ret = bpf_timer_start(timer, hold_ns,
+			      timer_pinned ? BPF_F_TIMER_CPU_PIN : 0);
+	if (ret)
+		scx_bpf_error("bpf_timer_start failed (%d)", ret);
+	return 0;
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(tickbug_init)
+{
+	struct bpf_timer *timer;
+	u32 key = 0;
+	int ret;
+
+	if (target_cpu == timer_cpu) {
+		scx_bpf_error("target and timer CPU must differ (both %d)",
+			      target_cpu);
+		return -EINVAL;
+	}
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
+		return ret;
+	}
+
+	timer = bpf_map_lookup_elem(&release_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	bpf_timer_init(timer, &release_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, release_timerfn);
+
+	/* Get ops.dispatch() to run on @timer_cpu so it arms the timer. */
+	scx_bpf_kick_cpu(timer_cpu, 0);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(tickbug_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(tickbug_ops,
+	       /*
+		* The last runnable task on a CPU has to come through
+		* ops.enqueue() too, otherwise the tagged task would simply
+		* keep running on @target_cpu and never be held.
+		*/
+	       .flags			= SCX_OPS_ENQ_LAST,
+
+	       .select_cpu		= (void *)tickbug_select_cpu,
+	       .enqueue			= (void *)tickbug_enqueue,
+	       .dispatch		= (void *)tickbug_dispatch,
+	       .init			= (void *)tickbug_init,
+	       .exit			= (void *)tickbug_exit,
+	       /*
+		* A held task is runnable and not running, which is what the
+		* watchdog looks for. Keep the timeout well above any hold.
+		*/
+	       .timeout_ms		= 5000U,
+	       .name			= "tickbug");
diff --git a/tools/sched_ext/scx_tickbug.c b/tools/sched_ext/scx_tickbug.c
new file mode 100644
index 000000000000..8acca5c1ff6a
--- /dev/null
+++ b/tools/sched_ext/scx_tickbug.c
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Radu Toader
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_tickbug.bpf.skel.h"
+
+const char help_fmt[] =
+"Hold a task runnable on a CPU that is in the idle loop.\n"
+"\n"
+"Tasks named \"spin\" are queued on the target CPU's run queue and left\n"
+"there, so the CPU idles with a runnable task queued, until a periodic\n"
+"timer releases one. Every other task runs through a shared DSQ.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-c CPU] [-t CPU] [-H HOLD_MS] [-s SLICE_US] [-v]\n"
+"\n"
+"  -c CPU        Target CPU, the one that idles with a task queued (default: 0)\n"
+"  -t CPU        CPU the release timer is pinned to (default: 1)\n"
+"  -H HOLD_MS    How long a task is held before release (default: 10)\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_tickbug *skel;
+	struct bpf_link *link;
+	__u64 seq = 0, ecode;
+	__u32 nr_cpu_ids;
+	__s32 opt;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+restart:
+	optind = 1;
+	skel = SCX_OPS_OPEN(tickbug_ops, scx_tickbug);
+
+	nr_cpu_ids = libbpf_num_possible_cpus();
+	assert(nr_cpu_ids > 0);
+	assert(nr_cpu_ids <= INT32_MAX);
+
+	skel->rodata->nr_cpu_ids = nr_cpu_ids;
+	skel->rodata->target_cpu = 0;
+	skel->rodata->timer_cpu = 1;
+	skel->rodata->hold_ns = 10ULL * 1000 * 1000;
+	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
+
+	while ((opt = getopt(argc, argv, "c:t:H:s:vh")) != -1) {
+		switch (opt) {
+		case 'c':
+		case 't': {
+			unsigned long cpu = strtoul(optarg, NULL, 0);
+
+			if (cpu >= nr_cpu_ids) {
+				fprintf(stderr, "invalid CPU id %lu (%u max)\n",
+					cpu, nr_cpu_ids - 1);
+				scx_tickbug__destroy(skel);
+				return 1;
+			}
+			if (opt == 'c')
+				skel->rodata->target_cpu = (s32)cpu;
+			else
+				skel->rodata->timer_cpu = (s32)cpu;
+			break;
+		}
+		case 'H':
+			skel->rodata->hold_ns = strtoull(optarg, NULL, 0) * 1000 * 1000;
+			break;
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	if (skel->rodata->target_cpu == skel->rodata->timer_cpu) {
+		fprintf(stderr, "the target CPU and the timer CPU must differ (both %d)\n",
+			skel->rodata->target_cpu);
+		scx_tickbug__destroy(skel);
+		return 1;
+	}
+	if (!skel->rodata->hold_ns) {
+		fprintf(stderr, "a hold of 0 would not hold anything\n");
+		scx_tickbug__destroy(skel);
+		return 1;
+	}
+
+	SCX_OPS_LOAD(skel, tickbug_ops, scx_tickbug, uei);
+	link = SCX_OPS_ATTACH(skel, tickbug_ops, scx_tickbug);
+
+	printf("target_cpu=%d timer_cpu=%d hold_ms=%llu slice_us=%llu\n",
+	       skel->rodata->target_cpu, skel->rodata->timer_cpu,
+	       (unsigned long long)(skel->rodata->hold_ns / 1000000),
+	       (unsigned long long)(skel->rodata->slice_ns / 1000));
+
+	if (!skel->data->timer_pinned)
+		printf("WARNING: BPF_F_TIMER_CPU_PIN unavailable, release timer is not pinned\n");
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		__u64 released = skel->bss->nr_released;
+
+		printf("[SEQ %llu]\n", seq++);
+		printf("enq    :%10" PRIu64 "   held:%10" PRIu64
+		       " released:%10" PRIu64 " timers:%10" PRIu64 "\n",
+		       skel->bss->nr_enq, skel->bss->nr_held,
+		       skel->bss->nr_released, skel->bss->nr_timers);
+		printf("pass   :%10" PRIu64 "  local:%10" PRIu64
+		       "     lost:%10" PRIu64 " othrcpu:%10" PRIu64
+		       " overflow:%10" PRIu64 " requeue:%10" PRIu64
+		       " now:%10" PRIu64 "\n",
+		       skel->bss->nr_passthru, skel->bss->nr_locals,
+		       skel->bss->nr_lost, skel->bss->nr_other_cpu,
+		       skel->bss->nr_overflow, skel->bss->nr_requeue,
+		       skel->bss->nr_held_now);
+		/*
+		 * The mean and the worst hold are the independent variable of
+		 * the whole experiment: without them the run proves nothing.
+		 */
+		printf("hold_us: mean %8llu   max %8llu\n",
+		       (unsigned long long)(released ?
+			       (skel->bss->total_held_ns / released) / 1000 : 0),
+		       (unsigned long long)(skel->bss->max_held_ns / 1000));
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_tickbug__destroy(skel);
+
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
-- 
2.43.0

