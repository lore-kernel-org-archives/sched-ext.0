Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396591;
	b=AP/Aumv6R5yfcu2HNLCFhaOrQ1rwcNoyROtB/KftuU8Xt2Y+T3903cfu2rkPlGUrlkRn
	 z1+ahQtp4qYAXvTLbsGgpG/r0R924TlyyIn8nPinThfZzfP4scXE9ik0S1OAYT9aYg6Hw
	 r4r+kddNHjiXfucaewbMa+8OoHaMmKvDFa+GGkFFoeUHs9Z4IKMcbxwPtfCv35NOlQegS
	 mV+PEvQZasecWtMSh0fIB6WiPmqLxg3AzxvH8+gKK/FZlmUw9qCsrip0ba12DHC7uAJ60
	 96jEXWqtC8Mo7yIQXmteP2iOhO5w8AQ6jjILDqBJ9LmL9W35JLPBNjZLE7l8nK4k7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WkB8fsr47aYLBpdq7IfPBM4C/nowCRinQnYQ8Fh6Bis=;
	b=IzrP/vCbh806EahDivck8HT7UHvpagMY6zncAZAtEt0+nkwfJo7q21pMO+RX2dprGOqe
	 8INMddp6qfrfcBY4Yj4MZYh1UOtNfCzE2/2YvbOtUZt2Qq6xYKjUi8i/4OPayeFtDdfME
	 QiIfN1J5SEdnHofIIQmeNyoFM8Ae/9Rh0cw2igKmUZFYy+yJJvaVicCpSbsDpt2BrValY
	 h8FJevyap2v/CPabg0JkzraCWgnyr3D18yH33KIhu792X+465QWrZOBHwAWcym0HP+v6g
	 oWyDYlWXgNjkXMQ0oup1YM42QvyhQnRH2PIR3+NGNAIKHdj1c0N9rGzxZQ72kvlKkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ye7AzYJG;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE7606A32D
	for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CE7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ye7AzYJG
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso23583445e9.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396589; x=1795001389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkB8fsr47aYLBpdq7IfPBM4C/nowCRinQnYQ8Fh6Bis=;
        b=Ye7AzYJGDdlKbnUbyrw+lOpcqPZHJcz8U88nm31drxrMh6yrLKHLidmhAuvu+/SMaA
         072+wMpJDBaenWaQnlJtnyzSzBzHnnJy1PXqjqTe1F5dQlX0IoaQsJxN9UZya1C4BWp0
         IOMj87bPD8bX7EttOScP9s02r/aRrxcGgJ3M5VwF422+4iG77xM8nA3ueKfGJrX+otDe
         qa3YIxkPckRgxIhocsG9OkyXUO3LbxgAYV05J0Nw+iQdgzRdSIdQbN9IV2GZzCorquRu
         s5oihm1WhmxDu99lhf20QVRFm6g3QHoaWsYFhw6MFg6PngP6NRIEZ3F/p9Qlto0xPiyb
         H6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396589; x=1795001389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WkB8fsr47aYLBpdq7IfPBM4C/nowCRinQnYQ8Fh6Bis=;
        b=2xT8pGgOnr5VRv88VzGe+6dy353Qtno0job/02VElgT1avDUfqUp7Sz66cULy9wmKS
         UapJ/9AZARUDlZdiG0mLFPzYVjjm4Q8dbJ9pEb5ppCA/Ps77J9JjP3m60e/VINSQr0HP
         lmivFnzmyAfz0bEvql6w7HDb2Is3XUl5K7YuBCCHajlk0hWHXg4ZCKI0ZnVHmmFSAal+
         96eRuguSxzFLIzrJjzs7M2DzXKr8L9d4FXvnVi8U3AmQ+22V/eOhalLiyyd07Eope57N
         p1XHk9OzMYQDwisE823Q1a17MSmEh80XYQqeeZTs9egCrnw8HRTm0ryw7qGlmgJ8L+Ju
         iydA==
X-Forwarded-Encrypted: i=1; AL+hErEA0eFuaNbsNScw/wtsFy7Yki1h6XujzYPrqeS5CHTFUjvrItxwH7rfQo59JR/XGaDgTAw8EOT3SB0=@lists.linux.dev
X-Gm-Message-State: APuU4Z/QScUZ+43QEwVYvBlabp/8pDugZbufDZb6v2Bf86ZWRsLMGpc+
	K5gB7NR+XJj1jN71+CDKste7buLTIIND5KD9oz0x/kPv6OUmyzIAWhr1
X-Gm-Gg: AYBFou38FD2mVYPGXcorMsV3ZxacLzLFmW0lzm4WWIP33bFBH8lSc5/7vF6HKzBnRl8
	scNCmF3+YOjY6Ew0N4KFeCnYoBvqMS9s5r6OsZoes+WULFRwh51QSsE6fFF1yORnpYXcCbE+ZME
	WZYLvU3RoVkF0YP2hYjicnWEa1L7sPWZHeAvWd91GtSR2Ho9YWJl6pghxqmHrShGK9lwRQmcQhp
	jAtzlRFF6YcpnrucMfkSSwyf7TuqLxAahvoJGY0KYOPzhzLN68sR/4SJV6dYYFGfbloJtIhJHos
	qQE9fTwkUxSeEqu4mChQTCsD99msAXTDCK8IZs+H9NLeDRwR3EX2PlvKkhRZcE0w87cdwjNPupo
	ZbyxaEPVt3E9HnC166Zv4Nr4qz6Do/sLNQ/hrzwspZRJjzkbe3KoS/beG31tSXQpWz49cvWLzbp
	NqZnxKPuV53tzjrvVnTC6Da/DeHBcnUgwgpfe1x4J9PNsTD4OMbBkvSvYR9/Mn9t2ZNlNOISSxM
	ylgEsZy0tUiyExcUNAssp3VjxbUGQP3aFWQmnCLvQe2NqhdQ0P0ZwDCF58sx3NBTEzFnGqVymor
	jQhFVGLg5fEVlLmu2mbEJ6rOkguJyfacwU06VvmREmGJORu8xWmaplUwo9UNL+hGaEUGXp52+Hw
	wOQ==
X-Received: by 2002:a05:600c:630c:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4ba0931ecd1mr39827525e9.1.1794396588804;
        Wed, 11 Nov 2026 03:29:48 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm161247285e9.2.2026.11.11.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:29:48 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com,
	boqun@kernel.org,
	joelagnelf@nvidia.com,
	enlin.mu@linux.dev,
	brads@mainlining.org,
	kmehltretter@gmail.com,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Wed, 11 Nov 2026 11:29:44 +0000
Message-ID: <20261111112944.3868822-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tick_irq_exit() only runs tick_nohz_irq_exit() if sched_core_idle_cpu(),
which is idle_cpu() unless core scheduling is built in. idle_cpu() is
false when the run queue has tasks while the idle task runs.

That is the normal state of a CPU under sched_ext whose BPF scheduler
holds back a runnable task of that CPU in one of its queues, e.g. a task
of a cgroup at its CPU limit: the task stays queued on the CPU's run
queue and counts in rq->nr_running, while the CPU sits in the idle loop.

tick_nohz_irq_exit() is what marks an idle CPU as idle again for the
scheduler clock after an interrupt in the idle loop
(TS_FLAG_IDLE_ACTIVE, sched_clock_idle_sleep_event()). Without it, the
next exit from the idle loop doesn't resynchronize the CPU's sched_clock
with sched_clock_idle_wakeup_event(). With an unstable sched_clock, e.g.
under kvm-clock without a stable TSC, the clock of a CPU in tick-stopped
idle is clamped to its last stamp plus a tick, so a task picked after a
reschedule IPI (which doesn't go through irq_enter()) starts with a
stale exec_start, and the next tick charges the whole idle stretch to
it.

Measured with one thread spinning 10 ms in every 100 ms in a cgroup,
kept off its CPU for a further 7 to 53 ms per period by a sched_ext
scheduler: the cgroup's cpu.stat usage_usec over the thread's own
CLOCK_MONOTONIC measurement of its busy time reached 2.00, twice the
CPU time the thread could possibly have used, and is 0.96 with this
patch. The same ratio with no BPF scheduler loaded is 1.005.

Commit 548796e2e70b ("sched/core: introduce sched_core_idle_cpu()")
fixed this same gate for the other case of "the idle task runs while
nr_running > 0", forced idle under core scheduling, where the symptom
was too little idle time in /proc/stat. sched_ext made that state
reachable without CONFIG_SCHED_CORE, and there the symptom is idle time
charged to a task as runtime.

Ask whether the idle task is running, which covers both cases. CPUs
whose run queue is really empty are unaffected; a CPU interrupted
between leaving the idle loop and switching to a task has need_resched()
set or has already left the idle accounting, see tick_nohz_irq_exit().
sched_core_idle_cpu() has no users left and goes.

The two gates test different predicates rather than one containing the
other, and the difference is deliberate. idle_cpu() is idle_rq():
rq->curr == rq->idle && !rq->nr_running && !rq->ttwu_pending.
is_idle_task() tests PF_IDLE on current. Newly covered:

 - the two "the idle task runs while nr_running > 0" cases above;

 - a CPU idling with a wakeup queued by TTWU_QUEUE whose IPI has not
   run yet;

 - injected idle. play_idle_precise() sets PF_IDLE on a SCHED_FIFO
   kthread which then loops on do_idle(), so rq->curr is not rq->idle
   there and the old gate was false off nohz_full CPUs. Interrupts
   taken during injected idle now run tick_nohz_irq_exit() with
   TS_FLAG_INIDLE set. That CPU is running an idle state and needs the
   same latch for the same reason, so this is wanted rather than merely
   harmless, but note it reaches the idle injection users in
   drivers/powercap/idle_inject.c, intel_powerclamp and
   cpuidle_cooling, and is not confined to sched_ext.

One state is no longer covered: PF_IDLE is set by cpu_startup_entry()
and not by init_idle(), so a CPU on its idle task before that point
satisfied idle_cpu() but does not satisfy is_idle_task(current). Nothing
is lost, because TS_FLAG_INIDLE is only set inside do_idle(), so
tick_nohz_irq_exit() had nothing to do there, and nohz_full CPUs are
covered by tick_nohz_full_cpu(cpu) either way.

What keeps the new gate from giving a CPU idle accounting it should not
have is that tick_nohz_irq_exit() tests TS_FLAG_INIDLE itself and only
does the idle bookkeeping inside the idle loop.

Tooling: the bug was found and this patch and changelog were written by
Claude Opus 5 (Claude Code), in a session measuring cgroup CPU limit
enforcement under sched_ext. All of the patch and all of the changelog
are tool-generated. The measurements above were taken on hosts that no
longer exist and were not repeated for this posting. By the threat model
in Documentation/process/threat-model.rst this is a regular bug and not
a vulnerability: it misreports CPU time under a legitimate configuration
and crosses no privilege or isolation boundary.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Link: https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/
Signed-off-by: Radu Toader <radu.m.toader@gmail.com>
---
Changes in v3:
 - No code change; the diff is identical to v2.
 - Moved the posting notes out of the changelog and below this line, as
   asked in review of v2. The Link: tag still points at the reproducer.
 - The Tooling: line stays in the changelog above the --- line, because
   Documentation/process/generated-content.rst asks for tool use to be
   noted there.

The reproducer is a sched_ext scheduler that parks a tagged task on an
otherwise idle CPU for a set time. It was patch 1 of v1 and is dropped
from this posting at the maintainer's request; it remains in the list
archive, see the Link: tag above.

Compile-tested in four x86_64 defconfig variants - SCHED_CORE=y with
NO_HZ_FULL=y, SCHED_CORE=n, NO_HZ_COMMON=n, and SCHED_CLASS_EXT=y with
SCHED_CORE=y and NO_HZ_FULL=y - with no new warnings at W=1.

v1: https://lore.kernel.org/lkml/20261106094343.174905-1-radu.m.toader@gmail.com/
v2 and its CI run: https://patchwork.kernel.org/series/1206104/

 include/linux/sched.h   |  2 --
 kernel/sched/syscalls.c | 12 ------------
 kernel/softirq.c        | 12 ++++++++++--
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..0e704ea9416f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2326,11 +2326,9 @@ extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
-extern int sched_core_idle_cpu(int cpu);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
-static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd..22e316680a86 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -194,18 +194,6 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
-#ifdef CONFIG_SCHED_CORE
-int sched_core_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	if (sched_core_enabled(rq) && rq->curr == rq->idle)
-		return 1;
-
-	return idle_cpu(cpu);
-}
-#endif /* CONFIG_SCHED_CORE */
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7fc2200392cd..e7d649c29c0c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -738,8 +738,16 @@ static inline void tick_irq_exit(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	int cpu = smp_processor_id();
 
-	/* Make sure that timer wheel updates are propagated */
-	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	/*
+	 * Make sure that timer wheel updates are propagated. An interrupted
+	 * idle loop counts as idle even with runnable tasks queued on the
+	 * CPU: forced idle under core scheduling, and the tasks sched_ext
+	 * keeps on a CPU's run queue while its BPF scheduler holds them back.
+	 * idle_cpu() would skip the idle bookkeeping of tick_nohz_irq_exit()
+	 * for those, and with an unstable sched_clock the CPU's clock then
+	 * isn't resynchronized when it leaves the idle loop.
+	 */
+	if ((is_idle_task(current) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (hardirq_count() == HARDIRQ_OFFSET)
 			tick_nohz_irq_exit();
 	}

base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

