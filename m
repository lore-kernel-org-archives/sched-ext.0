Received: from mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1746AEF1
	for <sched-ext@lists.linux.dev>; Tue,  6 Oct 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296930; cv=none; b=eUJ1UoEoHs8d41iX+p1W2Ys0OVHT2GmKL4/GlohhgrlPu5DFoSDFOpPV5X8Yd28U/iuJi8e0r3d+MbXaMqOBF0esQchXcRGkw1tyMzEZFSTv3e74YGqHnBZ7g2b6N4/dFoVjHJO3mZnIDlmufueoZp4li0MPnyzWnvOIhsNYUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296930; c=relaxed/simple;
	bh=KfJqLZ4X1oPy80bZ/h+F4nTzpIu9KsAneTAs+RzMD7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oad83sdZVnkE4Za4OpTeayZG1B7nScXKl/SNhibQ1LF2VwKFCEl1coyNFIFwiBBFXjtMBVVRlXRJNk7i359gJ/UlDLimcxzGBnrvMJCARMHENUdKuXARnYRrq+D2kZG3iUi5iTXZfkLOPwIHS+M1VAm/Y9LHBkFG2KlwlqEYhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSseiekR; arc=none smtp.client-ip=95.215.58.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSseiekR"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KfJqLZ4X1oPy80bZ/h+F4nTzpIu9KsAneTAs+RzMD7c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791296925; v=1; x=1791901725;
 b=bSseiekRmDZ0bsQlxz491AgDz72LwOTs3IBoNL2eb9msE8UfjHpMMvkyT6CVHQjs+B3n9XRo
 tKBBPmepSUutsYlRj+7I8JPGT7GAf4hunzhd3cx5rQJNpzNqT16HDs5tCy61iSC2wNz6ayMum17
 r32oMUB8HeW4/vplTeoR2MuM=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f5a81b7b640c6ee3;
	Tue, 06 Oct 2026 14:28:45 +0000
X-Mizu-Trace-ID: f5a81b7b640c6ee3
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] sched_ext: Reset cpuperf_target when a sub loses SCX_CAP_PERF or dies
Date: Tue,  6 Oct 2026 22:28:34 +0800
Message-ID: <20261006142834.2815197-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

When a sub-scheduler holding SCX_CAP_PERF sets a low cpuperf target and
then goes away - through cap revoke, kill, detach or cgroup removal -
the target stays behind. scx_bpf_sub_revoke() only clears the pshard
caps[] bitmaps: the cap gate in scx_cpuperf_set() blocks new writes but
leaves the old value in place. scx_sub_disable() rehomes the tasks and
unlinks the scheduler without touching rq->scx.cpuperf_target either.

Nothing ever resets the value afterwards. The reader gate
scx_cpuperf_target() only tests the global scx_enabled(), which still
holds while the root scheduler is running, so schedutil keeps consuming
the stale target as its utilization base on every DVFS update. In
switched-all mode, where sugov_get_util() does not add CFS utilization
on top, the affected CPU stays pinned at a low frequency until sched_ext
is disabled and re-enabled as a whole. A root scheduler like scx_simple
never calls the cpuperf kfuncs, so the pin is unbounded.

Fix it by restoring the neutral base that the root scheduler establishes
at enable time, at every point where a writer loses the ability to
write:

- scx_bpf_sub_revoke() queues a reset for the CPUs backing the
  actually-revoked cids. The revoke's write gate only closes when the
  target CPU folds the ecaps sync in dispatch_one, so the queueing alone
  leaves a window where the still-running sub-scheduler can re-pollute
  the freshly reset value; the fold now also restores the neutral base
  in the same rq-locked section that closes the gate, which is ordered
  against both the racing writes and any surviving co-holder's writes.
- scx_sub_disable() sweeps the scheduler's pshard SCX_CAP_PERF cmasks
  after it is unlinked and drained and queues a reset for every CPU it
  held the cap on. The sweep runs with scx_enable_mutex and
  cpus_read_lock() held: the mutex keeps a concurrent root disable from
  retiring the cid tables the sweep dereferences - drain_descendants()
  only waits for descendants to unlink, so scx_root_disable() would
  otherwise be free to run to scx_cid_retire_tables() while the sweep is
  in flight - and cpus_read_lock() keeps the target CPUs from going
  offline across the cpu_online() tests. The tables are __rcu-annotated
  and the sweeper is preemptible, so the sweep also takes the RCU read
  side.
- scx_bpf_cidperf_set() rejects writes from a dying scheduler: between
  the sweep and ops.exit() - and in the timers/tracers window after it -
  the exit path may still run, and a write there would land after the
  final reset with nothing left to clean it up.
- scx_online_ecaps() restores the neutral base when a CPU comes back, so
  a CPU that was offline when its writer went away is cleaned up at
  re-online instead of resuming the pin.

The reset needs the target rq's lock. scx_bpf_sub_revoke() runs with
IRQs disabled under pshard locks and may be entered from BPF with
another rq already locked, so the reset is carried out from a per-CPU
irq_work on the target CPU instead of taking cross-CPU rq locks. The two
resets cover different cases: the fold-time reset closes the window at
the moment the gate closes, and the IPI resets the value right away
for CPUs whose fold is postponed indefinitely by a higher-class hog or
that never dispatch again - a sustained remote writer against such a CPU
can keep re-polluting the value after the one-shot IPI; it is corrected
whenever the gate eventually closes, and for a CPU that never dispatches
again the exposure lasts as long as the writer does. The revoke
path can't pin hotplug; there, a CPU marked offline between the
cpu_online() test and the queueing trips irq_work_queue_on()'s
WARN_ON_ONCE once, and the queued work is still delivered - by the
dying-cpu flush, the re-online flush, or the per-CPU irq_work kthread
on RT - before or after the online reset; either order ends at the
neutral base. Over-resetting is deliberate: a scheduler still sharing
the cap rewrites its own target on its next update, which on an idle
CPU may take a while; a writer that never writes again leaves the CPU
at the neutral
base - the safe state to sit on.

Tested on a VM with a lockdep-enabled kernel. A sub-scheduler setting
target 1 and then being killed leaves rq->scx.cpuperf_target at 1 under
full load on the baseline; with this patch, the target returns to
SCX_CPUPERF_ONE immediately on kill. With the CPU taken offline before
the kill, the baseline resumes pinning the CPU at the stale target once
it comes back, while this patch restores the neutral base at re-online.
Revoking SCX_CAP_PERF from a live sub-scheduler resets the target when
the revoke's gate closes and the cap gate keeps the CPU at the neutral
base afterwards. A hotplug cycle with the cap still held restores the
base at re-online until the sub-scheduler rewrites it, and ten rounds of
sub-scheduler load/unload with interleaved hotplug run clean under both
lockdep and KASAN.

Fixes: 3a21e34eb258 ("sched_ext: Gate scx_bpf_cidperf_set() behind a new SCX_CAP_PERF")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
v1 -> v2:
- queue the disable-path sweep under scx_enable_mutex and
  cpus_read_lock() so that it can't race scx_cid_retire_tables() on a
  concurrent root disable and its cpu_online() tests can't lose to
  hotplug (Sashiko)
- take the RCU read side around the sweep: the tables are
  __rcu-annotated and the sweeper is preemptible, so lockdep (rightly)
  complained about the bare dereference
- restore the neutral base in scx_online_ecaps() so that a CPU which was
  offline when its writer went away doesn't come back up with the stale
  target, refreshing the rq clock first so that cpufreq_update_util()'s
  rq_clock assertion holds on the hotplug path (Sashiko)
- fold the target back to the neutral base in the rq-locked section that
  closes the write gate on cap loss, closing the window where a
  still-running sub-scheduler could re-pollute the value reset by the
  revoke-path IPI
- reject cpuperf writes from a dying scheduler so that ops.exit() and
  late stragglers can't land a write after the final sweep
- fix up the comments that the above falsifies and reword the
  over-reset/bounded claims; retarget Fixes at the commit that
  introduced the SCX_CAP_PERF gate

Link: https://lore.kernel.org/sched-ext/20261004012721.615419-1-cui.tao@linux.dev/
---
 kernel/sched/ext/ext.c |  17 ++++-
 kernel/sched/ext/sub.c | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ae62c08b097a..5490a0e3cf9e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10884,7 +10884,9 @@ static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)
 	/*
 	 * ecaps updates are folded under the rq lock, making this test
 	 * authoritative: a write can never land after a revoke has taken
-	 * effect on @cpu.
+	 * effect on @cpu. The fold in scx_process_sync_ecaps() also restores
+	 * the neutral target when SCX_CAP_PERF is lost, so a revoke can't
+	 * leave a stale value behind the just-closed gate.
 	 */
 	if (likely(!scx_missing_caps(sch, cpu, SCX_CAP_PERF))) {
 		rq->scx.cpuperf_target = perf;
@@ -10940,8 +10942,8 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
  *
  * cid-addressed equivalent of scx_bpf_cpuperf_set(). A sub-sched needs
  * SCX_CAP_PERF on @cid. Returns 0 if the target was applied, -%EACCES if
- * the write was denied for missing caps, other -errnos if @cid didn't
- * resolve.
+ * the write was denied for missing caps or because the scheduler is dying,
+ * other -errnos if @cid didn't resolve.
  */
 __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32 perf,
 				    const struct bpf_prog_aux *aux)
@@ -10958,6 +10960,15 @@ __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32 perf,
 	if (!scx_kf_allowed_ctx(sch))
 		return -EDEADLK;
 
+	/*
+	 * Reject writes from a dying scheduler. Its targets have been or
+	 * will be swept back to the neutral base, but ops.exit() and any
+	 * late stragglers still run after that sweep - a write there would
+	 * land after the final reset with nothing left to clean it up.
+	 */
+	if (unlikely(atomic_read(&sch->exit_kind) != SCX_EXIT_NONE))
+		return -EACCES;
+
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return cpu;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 48e17aeb1cb6..091d0cb18595 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -28,6 +28,63 @@
  */
 DEFINE_STATIC_KEY_FALSE(__scx_has_subs);
 
+/*
+ * Reset rq->scx.cpuperf_target back to the neutral SCX_CPUPERF_ONE base
+ * when a sub-scheduler that wrote targets loses SCX_CAP_PERF or dies. The
+ * reset runs from an irq_work on the target CPU so it can take the target
+ * rq's lock without imposing any rq lock ordering on the callers:
+ * scx_bpf_sub_revoke() runs with IRQs disabled under pshard locks and may
+ * be reached from BPF with another rq already locked.
+ */
+static DEFINE_PER_CPU(struct irq_work, scx_cpuperf_reset_iw);
+
+static void scx_cpuperf_reset_fn(struct irq_work *iw)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!scx_enabled())
+		return;
+
+	rq = cpu_rq(smp_processor_id());
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+	if (rq->scx.cpuperf_target != SCX_CPUPERF_ONE) {
+		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
+		cpufreq_update_util(rq, 0);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+/*
+ * Queue a reset of @cpu's cpuperf target. Idempotent: the work is always a
+ * plain restore of the neutral base, so concurrent queues collapse into one
+ * run; CPUs that never had a sub-scheduler target no-op.
+ *
+ * The pshard sweep calls in with cpus_read_lock() held, so @cpu can't go
+ * offline across the cpu_online() test. The revoke path can't pin hotplug -
+ * it runs from BPF with IRQs disabled under pshard locks - so an offline
+ * loss there trips irq_work_queue_on()'s WARN_ON_ONCE once and delivery
+ * waits for the flush at re-online; either order ends at the neutral base.
+ */
+static void scx_cpuperf_queue_reset(s32 cpu)
+{
+	if (cpu < 0 || cpu >= nr_cpu_ids || !cpu_online(cpu))
+		return;
+	irq_work_queue_on(&per_cpu(scx_cpuperf_reset_iw, cpu), cpu);
+}
+
+static int __init scx_cpuperf_reset_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		init_irq_work(per_cpu_ptr(&scx_cpuperf_reset_iw, cpu),
+			      scx_cpuperf_reset_fn);
+	return 0;
+}
+subsys_initcall(scx_cpuperf_reset_init);
+
 /* latched at root enable before any rescue runs */
 static s32 scx_rescue_bw_1024;
 static s64 scx_rescue_quantum_ns;
@@ -958,6 +1015,20 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		gained = ecaps & ~old;
 		lost_all |= lost;
 
+		/*
+		 * Losing SCX_CAP_PERF closes this scheduler's write gate on
+		 * @cpu - fold the target back to the neutral base right
+		 * here, ordered against the writes racing the revoke.
+		 */
+		if ((lost & SCX_CAP_PERF) &&
+		    rq->scx.cpuperf_target != SCX_CPUPERF_ONE) {
+			/* an op callback may have dropped the rq lock */
+			if (rq->clock_update_flags < RQCF_UPDATED)
+				update_rq_clock(rq);
+			rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
+			cpufreq_update_util(rq, 0);
+		}
+
 		/*
 		 * Tell the sched its effective caps on this cid changed. The
 		 * invocation is equivalent to the dispatch path and may drop
@@ -1044,6 +1115,15 @@ void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
  * A cpu came back. Re-seed each sub-sched's ecaps on the cpu's cid. The sync
  * recomputes effective caps from the pshard and fires ops.sub_ecaps_updated()
  * only on a real change since offline.
+ *
+ * Also restore the neutral cpuperf base. The cpu may be coming back with a
+ * target written before it went down: the rq persists across hotplug, the
+ * reset skips offline CPUs and no sub-scheduler rewrites the target while
+ * the cpu is down, so without this the stale value would resume pinning the
+ * cpu as soon as schedutil starts consuming it again. Over-resetting is
+ * deliberate: any scheduler still holding SCX_CAP_PERF rewrites its own
+ * target on its next update, which on an idle cpu may take a while - the
+ * neutral base is the safe state to sit on until then.
  */
 void scx_online_ecaps(struct rq *rq)
 {
@@ -1061,6 +1141,13 @@ void scx_online_ecaps(struct rq *rq)
 
 	guard(rq_lock_irqsave)(rq);
 
+	if (rq->scx.cpuperf_target != SCX_CPUPERF_ONE) {
+		/* the hotplug path doesn't guarantee an updated rq clock */
+		update_rq_clock(rq);
+		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
+		cpufreq_update_util(rq, 0);
+	}
+
 	root = scx_root_protected();
 	cid = __scx_cpu_to_cid(cpu_of(rq));
 	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
@@ -1457,6 +1544,50 @@ static inline s32 scx_cgroup_claim_subtree(struct scx_sched *sch) { return 0; }
 static inline void scx_cgroup_return_subtree(struct scx_sched *sch) {}
 #endif
 
+/*
+ * Queue cpuperf resets for the CPUs backing the cids in @delta, the set
+ * SCX_CAP_PERF was just revoked on.
+ */
+static void scx_cpuperf_revoke_cids(const struct scx_cmask *delta)
+{
+	s32 cid;
+
+	scx_cmask_for_each_cid(cid, delta)
+		scx_cpuperf_queue_reset(__scx_cid_to_cpu(cid));
+}
+
+/*
+ * Restore the neutral cpuperf base on every CPU @sch holds SCX_CAP_PERF on.
+ * Over-resetting is deliberate: a scheduler still sharing the cap rewrites
+ * its own target on its next update - a writer that never writes again
+ * leaves the cpu at the neutral base, which is the safe direction.
+ * Must be called after @sch is unlinked and drained with scx_enable_mutex
+ * and cpus_read_lock() held: the mutex excludes scx_cid_retire_tables() on
+ * a concurrent root disable - the cid table dereference below is not
+ * otherwise protected and drain_descendants() only guarantees that every
+ * descendant reached unlinking - and cpus_read_lock() keeps @cpu online
+ * across the cpu_online() tests in the queueing. The table is
+ * __rcu-annotated and the caller may be preemptible, so take the RCU read
+ * side around the sweep; it also keeps the dereferences safe against a
+ * later retirement even if the surrounding locking ever changes.
+ */
+static void scx_sub_reset_cpuperf(struct scx_sched *sch)
+{
+	s32 si, cid;
+
+	if (!READ_ONCE(sch->pshard))
+		return;
+
+	rcu_read_lock();
+	for (si = 0; si < sch->nr_pshards; si++) {
+		struct scx_cmask *cm = &sch->pshard[si]->caps[__SCX_CAP_PERF].cmask;
+
+		scx_cmask_for_each_cid(cid, cm)
+			scx_cpuperf_queue_reset(__scx_cid_to_cpu(cid));
+	}
+	rcu_read_unlock();
+}
+
 void scx_sub_disable(struct scx_sched *sch)
 {
 	struct scx_sched *parent = scx_parent(sch);
@@ -1583,6 +1714,23 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	scx_unlink_sched(sch);
 
+	/*
+	 * @sch is being torn down: from unlinking on, its cpuperf writes are
+	 * rejected by the dying gate in scx_bpf_cidperf_set(). Queue a reset
+	 * for every CPU it held SCX_CAP_PERF on so schedutil doesn't keep
+	 * consuming the targets it left behind - ops.exit() and stragglers
+	 * still run after this point but can no longer write. Queue them
+	 * while still inside scx_enable_mutex so that a root disable can't
+	 * retire the cid tables while the sweep dereferences them -
+	 * drain_descendants() only waited for @sch to unlink, so
+	 * scx_root_disable() is free to run to scx_cid_retire_tables()
+	 * concurrently otherwise. CPUs held down by cpus_read_lock() can't go
+	 * offline across the cpu_online() tests either.
+	 */
+	cpus_read_lock();
+	scx_sub_reset_cpuperf(sch);
+	cpus_read_unlock();
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -2447,6 +2595,18 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 					scx_cmask_andnot(cm, delta);
 					scx_cmask_or(changed_cids, delta);
 					revoked_caps |= BIT_U64(cap_bit);
+
+					/*
+					 * A lost SCX_CAP_PERF also invalidates
+					 * the cpuperf targets @pos may have
+					 * written on the revoked cids. Queue
+					 * the reset; this runs with IRQs
+					 * disabled under pshard locks, so the
+					 * rq locks are taken on the target
+					 * CPUs from irq_work instead.
+					 */
+					if (cap_bit == __SCX_CAP_PERF)
+						scx_cpuperf_revoke_cids(delta);
 				}
 
 				if (revoked_caps) {
-- 
2.53.0

