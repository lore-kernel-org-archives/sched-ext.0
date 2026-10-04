Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC3379993
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077260; cv=none; b=HloDAC9KC5BegNpif/TYai/lHIEPW3uIfXIPYuq/B7oMhOJf/AkfzEzUcJzrPXsvoWCOba4fajWC5te2+6KXXa6f7pwsJGWwhG0pjm2r6rquog3bdu6jl0p73znKnAHM2Bs1T3qk2vsZ5MyNVt+BKZX+QTBaY3DifCa7JkjbjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077260; c=relaxed/simple;
	bh=wzQ99GICs2Vc4F2iRCLllGQA0ClIQT+EdYMR6WPsm+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eb7NNVhUsNO5ObXMkIECTA/n6C2urNlLs7sTDFJuFO7JjrPcKyHEmPbSVptKDDxau2v31HeS0ag2CPQT7EhXTw/JGCJCMrwkYIy8xGgKLCrxh7J6jRO98qmhgHcsSpNkWp+Vy/ooNDtGOmANFY9t7DpTcnokvRAn3weU6p76hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GBYabbwe; arc=none smtp.client-ip=91.218.175.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GBYabbwe"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=wzQ99GICs2Vc4F2iRCLllGQA0ClIQT+EdYMR6WPsm+M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791077255; v=1; x=1791682055;
 b=GBYabbwe9IIEBOmSr/GqPLVkh386mtqj/wjq1qX4asFApO0QvJBAEgrRxmt3W33Zmp5+o3Mi
 +bxbFUvwdmAPGXLsuOz3ZSpHx5FVIUPsXHfiklJGk2xnkC0hwzMrqbC7RCRluIfTaXD5uTWS2DI
 dHSqP7QWhjuH5wULLqNe5kqE=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 91d63f57de4487cd;
	Sun, 04 Oct 2026 01:27:34 +0000
X-Mizu-Trace-ID: 91d63f57de4487cd
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
Subject: [PATCH] sched_ext: Reset cpuperf_target when a sub-scheduler loses SCX_CAP_PERF or dies
Date: Sun,  4 Oct 2026 09:27:21 +0800
Message-ID: <20261004012721.615419-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
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

Nothing ever rewrites the value afterwards. The reader gate
scx_cpuperf_target() only tests the global scx_enabled(), which still
holds while the root scheduler is running, so schedutil keeps consuming
the stale target as its utilization base on every DVFS update. In
switched-all mode, where sugov_get_util() does not add CFS utilization
on top, the affected CPU stays pinned at a low frequency until sched_ext
is disabled and re-enabled as a whole. A root scheduler like scx_simple
never calls the cpuperf kfuncs, so the pin is unbounded.

Fix it by restoring the neutral base that the root scheduler establishes
at enable time whenever a writer goes away: scx_bpf_sub_revoke() queues
a reset for the CPUs backing the actually-revoked cids, and
scx_sub_disable() sweeps the scheduler's pshard SCX_CAP_PERF cmasks
after it is unlinked and drained and queues a reset for every CPU it
held the cap on.

The reset needs the target rq's lock. scx_bpf_sub_revoke() runs with
IRQs disabled under pshard locks and may be entered from BPF with
another rq already locked, so the reset is carried out from a per-CPU
irq_work on the target CPU instead of taking cross-CPU rq locks.
CPUs that are offline at reset time are skipped: a queued work would
trip irq_work's offline-CPU warning and has no guaranteed execution
point, and any stale target there is cleared when sched_ext is
re-enabled. Over-resetting is possible when the cap is shared by
multiple schedulers on one CPU; any scheduler still holding the cap
rewrites its own target on its next update, and in the worst case the
CPU runs at the neutral base until then or until a re-enable - still
bounded, unlike the stale pin it prevents.

Tested on a VM: a sub-scheduler setting target 1 and then being killed
leaves rq->scx.cpuperf_target at 1 under full load on the baseline; with
this patch, the target returns to SCX_CPUPERF_ONE immediately on kill.

Fixes: 86094b95efcf ("sched_ext: Add per-shard cap delegation for sub-schedulers")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/sub.c | 103 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 48e17aeb1cb6..378cdabdcaf2 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -28,6 +28,57 @@
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
@@ -1457,6 +1508,39 @@ static inline s32 scx_cgroup_claim_subtree(struct scx_sched *sch) { return 0; }
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
+ * Over-resetting is safe: any scheduler still holding the cap rewrites its
+ * own target on its next update. Must be called after @sch is unlinked and
+ * drained so nothing can race the pshard caps[] reads.
+ */
+static void scx_sub_reset_cpuperf(struct scx_sched *sch)
+{
+	s32 si, cid;
+
+	if (!READ_ONCE(sch->pshard))
+		return;
+
+	for (si = 0; si < sch->nr_pshards; si++) {
+		struct scx_cmask *cm = &sch->pshard[si]->caps[__SCX_CAP_PERF].cmask;
+
+		scx_cmask_for_each_cid(cid, cm)
+			scx_cpuperf_queue_reset(__scx_cid_to_cpu(cid));
+	}
+}
+
 void scx_sub_disable(struct scx_sched *sch)
 {
 	struct scx_sched *parent = scx_parent(sch);
@@ -1585,6 +1669,13 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	mutex_unlock(&scx_enable_mutex);
 
+	/*
+	 * @sch can no longer receive grants or writes: queue a cpuperf reset
+	 * for every CPU it held SCX_CAP_PERF on so schedutil doesn't keep
+	 * consuming the targets it left behind.
+	 */
+	scx_sub_reset_cpuperf(sch);
+
 	/*
 	 * @sch is now unlinked from the parent's children list. Notify and call
 	 * ops.sub_detach/exit(). Note that ops.sub_detach/exit() must be called
@@ -2447,6 +2538,18 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
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
2.43.0

