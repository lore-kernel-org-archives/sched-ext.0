Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A634EF0C;
	Sun,  8 Mar 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937924; cv=none; b=U2owuwEsDqBkTt6Tx/yUXdWEQ3QHNMF2Gl43jvZhbLBqso26a6OpDdL2pJ6wSBEGLz1juINOWz8LhekuG8MMeoa8/SrK7oiO8M+Pnfx4zO6lNiVIuar388nSRqvimTMSbRdB8/Ng6FOvRgTPoLLBWsh5iacAbDR8B/UfrfvPf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937924; c=relaxed/simple;
	bh=dl1RPsr67yxCa3lILeLDfExlKMlKntZYiF8Hk1Akwq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly4RKNFAOvbYq6rR4GI0RpuJPVRpdfxN5ONWURCrxVYIyVYDa1me5evw/gQ9gVBIH+LlGooJ2YW2qsjbb19HTgDIkd8lwbLGI18NlJRLbzAl4BZITHflZMolTGjVa4WGA6xquJssUCfzjjfgo0RyOKgIv53HPAopGAVFzfIHbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAiSuFcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAiSuFcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B715DC19425;
	Sun,  8 Mar 2026 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937923;
	bh=dl1RPsr67yxCa3lILeLDfExlKMlKntZYiF8Hk1Akwq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAiSuFcuME0P7BUDnXucUEMU5lmWmG0ReVaC2qxcePvUgeGN1NRqQbDn41yllh7h/
	 EwuGuKB5YTiZguxK5ZOJyXCUjMuiO6vXdP+FMix31Uxr5Bb7WLHbyIFSiHHNnbBEp5
	 hZ0GcKPv8lnxQcZiglch3gZ+cTkj4/vLwBNMzLd9LxQE6A/BI7Ghk18mLN3mVrsC06
	 //NASFVZiakgt7ZZEbWUI86ZVaD9xf37yGAm2FId05i3aVZqMAAu1Oy6yqzfWusEV5
	 P/BQwNjKRKyduyMlEy6x9iE9gBAxlJXtKchbPHiJuCgK0AteT6f26Gt3atpJMLgn/D
	 QiVlvd3heScxg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] tools/sched_ext/include: Add missing helpers to common.bpf.h
Date: Sat,  7 Mar 2026 16:45:16 -1000
Message-ID: <20260308024519.1980564-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sync several helpers from the scx repo:
- bpf_cgroup_acquire() ksym declaration
- __sink() macro for hiding values from verifier precision tracking
- ctzll() count-trailing-zeros implementation
- get_prandom_u64() helper
- scx_clock_task/pelt/virt/irq() clock helpers with get_current_rq()

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/common.bpf.h | 277 +++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index eba4d87345e0..a63a98a96b86 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -292,6 +292,50 @@ BPF_PROG(name, ##args)
 })
 #endif /* ARRAY_ELEM_PTR */
 
+/**
+ * __sink - Hide @expr's value from the compiler and BPF verifier
+ * @expr: The expression whose value should be opacified
+ *
+ * No-op at runtime. The empty inline assembly with a read-write constraint
+ * ("+g") has two effects at compile/verify time:
+ *
+ * 1. Compiler: treats @expr as both read and written, preventing dead-code
+ *    elimination and keeping @expr (and any side effects that produced it)
+ *    alive.
+ *
+ * 2. BPF verifier: forgets the precise value/range of @expr ("makes it
+ *    imprecise"). The verifier normally tracks exact ranges for every register
+ *    and stack slot. While useful, precision means each distinct value creates a
+ *    separate verifier state. Inside loops this leads to state explosion - each
+ *    iteration carries different precise values so states never merge and the
+ *    verifier explores every iteration individually.
+ *
+ * Example - preventing loop state explosion::
+ *
+ *     u32 nr_intersects = 0, nr_covered = 0;
+ *     __sink(nr_intersects);
+ *     __sink(nr_covered);
+ *     bpf_for(i, 0, nr_nodes) {
+ *         if (intersects(cpumask, node_mask[i]))
+ *             nr_intersects++;
+ *         if (covers(cpumask, node_mask[i]))
+ *             nr_covered++;
+ *     }
+ *
+ * Without __sink(), the verifier tracks every possible (nr_intersects,
+ * nr_covered) pair across iterations, causing "BPF program is too large". With
+ * __sink(), the values become unknown scalars so all iterations collapse into
+ * one reusable state.
+ *
+ * Example - keeping a reference alive::
+ *
+ *     struct task_struct *t = bpf_task_acquire(task);
+ *     __sink(t);
+ *
+ * Follows the convention from BPF selftests (bpf_misc.h).
+ */
+#define __sink(expr) asm volatile ("" : "+g"(expr))
+
 /*
  * BPF declarations and helpers
  */
@@ -337,6 +381,7 @@ void bpf_task_release(struct task_struct *p) __ksym;
 
 /* cgroup */
 struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __ksym;
 void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 
@@ -742,6 +787,73 @@ static inline u64 __sqrt_u64(u64 x)
 	return r;
 }
 
+/*
+ * ctzll -- Counts trailing zeros in an unsigned long long. If the input value
+ * is zero, the return value is undefined.
+ */
+static inline int ctzll(u64 v)
+{
+#if (!defined(__BPF__) && defined(__SCX_TARGET_ARCH_x86)) || \
+	(defined(__BPF__) && defined(__clang_major__) && __clang_major__ >= 19)
+	/*
+	 * Use the ctz builtin when: (1) building for native x86, or
+	 * (2) building for BPF with clang >= 19 (BPF backend supports
+	 * the intrinsic from clang 19 onward; earlier versions hit
+	 * "unimplemented opcode" in the backend).
+	 */
+	return __builtin_ctzll(v);
+#else
+	/*
+	 * If neither the target architecture nor the toolchains support ctzll,
+	 * use software-based emulation. Let's use the De Bruijn sequence-based
+	 * approach to find LSB fastly. See the details of De Bruijn sequence:
+	 *
+	 * https://en.wikipedia.org/wiki/De_Bruijn_sequence
+	 * https://www.chessprogramming.org/BitScan#De_Bruijn_Multiplication
+	 */
+	const int lookup_table[64] = {
+		 0,  1, 48,  2, 57, 49, 28,  3, 61, 58, 50, 42, 38, 29, 17,  4,
+		62, 55, 59, 36, 53, 51, 43, 22, 45, 39, 33, 30, 24, 18, 12,  5,
+		63, 47, 56, 27, 60, 41, 37, 16, 54, 35, 52, 21, 44, 32, 23, 11,
+		46, 26, 40, 15, 34, 20, 31, 10, 25, 14, 19,  9, 13,  8,  7,  6,
+	};
+	const u64 DEBRUIJN_CONSTANT = 0x03f79d71b4cb0a89ULL;
+	unsigned int index;
+	u64 lowest_bit;
+	const int *lt;
+
+	if (v == 0)
+		return -1;
+
+	/*
+	 * Isolate the least significant bit (LSB).
+	 * For example, if v = 0b...10100, then v & -v = 0b...00100
+	 */
+	lowest_bit = v & -v;
+
+	/*
+	 * Each isolated bit produces a unique 6-bit value, guaranteed by the
+	 * De Bruijn property. Calculate a unique index into the lookup table
+	 * using the magic constant and a right shift.
+	 *
+	 * Multiplying by the 64-bit constant "spreads out" that 1-bit into a
+	 * unique pattern in the top 6 bits. This uniqueness property is
+	 * exactly what a De Bruijn sequence guarantees: Every possible 6-bit
+	 * pattern (in top bits) occurs exactly once for each LSB position. So,
+	 * the constant 0x03f79d71b4cb0a89ULL is carefully chosen to be a
+	 * De Bruijn sequence, ensuring no collisions in the table index.
+	 */
+	index = (lowest_bit * DEBRUIJN_CONSTANT) >> 58;
+
+	/*
+	 * Lookup in a precomputed table. No collision is guaranteed by the
+	 * De Bruijn property.
+	 */
+	lt = MEMBER_VPTR(lookup_table, [index]);
+	return (lt)? *lt : -1;
+#endif
+}
+
 /*
  * Return a value proportionally scaled to the task's weight.
  */
@@ -759,6 +871,171 @@ static inline u64 scale_by_task_weight_inverse(const struct task_struct *p, u64
 }
 
 
+/*
+ * Get a random u64 from the kernel's pseudo-random generator.
+ */
+static inline u64 get_prandom_u64()
+{
+	return ((u64)bpf_get_prandom_u32() << 32) | bpf_get_prandom_u32();
+}
+
+/*
+ * Define the shadow structure to avoid a compilation error when
+ * vmlinux.h does not enable necessary kernel configs. The ___local
+ * suffix is a CO-RE convention that tells the loader to match this
+ * against the base struct rq in the kernel. The attribute
+ * preserve_access_index tells the compiler to generate a CO-RE
+ * relocation for these fields.
+ */
+struct rq___local {
+	/*
+	 * A monotonically increasing clock per CPU. It is rq->clock minus
+	 * cumulative IRQ time and hypervisor steal time. Unlike rq->clock,
+	 * it does not advance during IRQ processing or hypervisor preemption.
+	 * It does advance during idle (the idle task counts as a running task
+	 * for this purpose).
+	 */
+	u64		clock_task;
+	/*
+	 * Invariant version of clock_task scaled by CPU capacity and
+	 * frequency. For example, clock_pelt advances 2x slower on a CPU
+	 * with half the capacity.
+	 *
+	 * At idle exit, rq->clock_pelt jumps forward to resync with
+	 * clock_task. The kernel's rq_clock_pelt() corrects for this jump
+	 * by subtracting lost_idle_time, yielding a clock that appears
+	 * continuous across idle transitions. scx_clock_pelt() mirrors
+	 * rq_clock_pelt() by performing the same subtraction.
+	 */
+	u64		clock_pelt;
+	/*
+	 * Accumulates the magnitude of each clock_pelt jump at idle exit.
+	 * Subtracting this from clock_pelt gives rq_clock_pelt(): a
+	 * continuous, capacity-invariant clock suitable for both task
+	 * execution time stamping and cross-idle measurements.
+	 */
+	unsigned long	lost_idle_time;
+	/*
+	 * Shadow of paravirt_steal_clock() (the hypervisor's cumulative
+	 * stolen time counter). Stays frozen while the hypervisor preempts
+	 * the vCPU; catches up the next time update_rq_clock_task() is
+	 * called. The delta is the stolen time not yet subtracted from
+	 * clock_task.
+	 *
+	 * Unlike irqtime->total (a plain kernel-side field), the live stolen
+	 * time counter lives in hypervisor-specific shared memory and has no
+	 * kernel-side equivalent readable from BPF in a hypervisor-agnostic
+	 * way. This field is therefore the only portable BPF-accessible
+	 * approximation of cumulative steal time.
+	 *
+	 * Available only when CONFIG_PARAVIRT_TIME_ACCOUNTING is on.
+	 */
+	u64		prev_steal_time_rq;
+} __attribute__((preserve_access_index));
+
+extern struct rq runqueues __ksym;
+
+/*
+ * Define the shadow structure to avoid a compilation error when
+ * vmlinux.h does not enable necessary kernel configs.
+ */
+struct irqtime___local {
+	/*
+	 * Cumulative IRQ time counter for this CPU, in nanoseconds. Advances
+	 * immediately at the exit of every hardirq and non-ksoftirqd softirq
+	 * via irqtime_account_irq(). ksoftirqd time is counted as normal
+	 * task time and is NOT included. NMI time is also NOT included.
+	 *
+	 * The companion field irqtime->sync (struct u64_stats_sync) protects
+	 * against 64-bit tearing on 32-bit architectures. On 64-bit kernels,
+	 * u64_stats_sync is an empty struct and all seqcount operations are
+	 * no-ops, so a plain BPF_CORE_READ of this field is safe.
+	 *
+	 * Available only when CONFIG_IRQ_TIME_ACCOUNTING is on.
+	 */
+	u64		total;
+} __attribute__((preserve_access_index));
+
+/*
+ * cpu_irqtime is a per-CPU variable defined only when
+ * CONFIG_IRQ_TIME_ACCOUNTING is on. Declare it as __weak so the BPF
+ * loader sets its address to 0 (rather than failing) when the symbol
+ * is absent from the running kernel.
+ */
+extern struct irqtime___local cpu_irqtime __ksym __weak;
+
+static inline struct rq___local *get_current_rq(u32 cpu)
+{
+	/*
+	 * This is a workaround to get an rq pointer since we decided to
+	 * deprecate scx_bpf_cpu_rq().
+	 *
+	 * WARNING: The caller must hold the rq lock for @cpu. This is
+	 * guaranteed when called from scheduling callbacks (ops.running,
+	 * ops.stopping, ops.enqueue, ops.dequeue, ops.dispatch, etc.).
+	 * There is no runtime check available in BPF for kernel spinlock
+	 * state — correctness is enforced by calling context only.
+	 */
+	return (void *)bpf_per_cpu_ptr(&runqueues, cpu);
+}
+
+static inline u64 scx_clock_task(u32 cpu)
+{
+	struct rq___local *rq = get_current_rq(cpu);
+
+	/* Equivalent to the kernel's rq_clock_task(). */
+	return rq ? rq->clock_task : 0;
+}
+
+static inline u64 scx_clock_pelt(u32 cpu)
+{
+	struct rq___local *rq = get_current_rq(cpu);
+
+	/*
+	 * Equivalent to the kernel's rq_clock_pelt(): subtracts
+	 * lost_idle_time from clock_pelt to absorb the jump that occurs
+	 * when clock_pelt resyncs with clock_task at idle exit. The result
+	 * is a continuous, capacity-invariant clock safe for both task
+	 * execution time stamping and cross-idle measurements.
+	 */
+	return rq ? (rq->clock_pelt - rq->lost_idle_time) : 0;
+}
+
+static inline u64 scx_clock_virt(u32 cpu)
+{
+	struct rq___local *rq;
+
+	/*
+	 * Check field existence before calling get_current_rq() so we avoid
+	 * the per_cpu lookup entirely on kernels built without
+	 * CONFIG_PARAVIRT_TIME_ACCOUNTING.
+	 */
+	if (!bpf_core_field_exists(((struct rq___local *)0)->prev_steal_time_rq))
+		return 0;
+
+	/* Lagging shadow of the kernel's paravirt_steal_clock(). */
+	rq = get_current_rq(cpu);
+	return rq ? BPF_CORE_READ(rq, prev_steal_time_rq) : 0;
+}
+
+static inline u64 scx_clock_irq(u32 cpu)
+{
+	struct irqtime___local *irqt;
+
+	/*
+	 * bpf_core_type_exists() resolves at load time: if struct irqtime is
+	 * absent from kernel BTF (CONFIG_IRQ_TIME_ACCOUNTING off), the loader
+	 * patches this into an unconditional return 0, making the
+	 * bpf_per_cpu_ptr() call below dead code that the verifier never sees.
+	 */
+	if (!bpf_core_type_exists(struct irqtime___local))
+		return 0;
+
+	/* Equivalent to the kernel's irq_time_read(). */
+	irqt = bpf_per_cpu_ptr(&cpu_irqtime, cpu);
+	return irqt ? BPF_CORE_READ(irqt, total) : 0;
+}
+
 #include "compat.bpf.h"
 #include "enums.bpf.h"
 
-- 
2.53.0

