Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE07396D1A;
	Sat,  1 Aug 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574326; cv=none; b=Vz7L6NH/+Xckkg5ECktt6EriRPF6p7e1mqjATrbqRuvV/skv52jiUHP3YlWyWXJqcm5Xf11nmZbWh/mAwxb+TlsO30FT9ZEgDwgqziWfXWQbC0CjoBm2UrcH9p93BlBjiYPHfAOomCKx7tZIlksLSR82DhXqxbv4m+8TR/QB76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574326; c=relaxed/simple;
	bh=qQPmmjl8wbo45uxK5/41SJEe28yE11WsXlyhMjak6VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmmsOQmglOrbhcGyrE8A1ifkxJICEn09mEucD/oilDDzBYRuOoa3msp/B228SWup0Z5GqlMBvc42YPv7qylCw3j6ze8vd3Thd+8ue0AAg0z3w/KYDNp73/JG2+2gcmFp9F8vy7YdzlTNWPEY5E6jU5MQYIKIJIBfJDYBM3MfK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erqriynM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erqriynM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC521F00ADF;
	Sat,  1 Aug 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574323;
	bh=9hY4MjBegmD9JLUyMx1jGbPbVaFKE9L0IzRJ3YDmCds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=erqriynMjMqwViND+J2WeXE1d6U8S+tNQ2ekPaAtNQT5ydonZ49Q6kB1ww9lJZ8/o
	 moYaYACN96yfeUWK02I9VirIQfuBA3YNfMA2+f2sgCt3ADZm98W1CXIpKKBYeHhkGc
	 0aN13A5GhbVoEbbi3SbLuEqOviCCrt1EqUxmAcYdk6pO7rv5jaUnrQq2uqv2cN+BCc
	 R/1X0gLY6o6DUfubUa6b0QqFAf5DNSkxiJCU9BwagSFuNX4pjDwON/pdA+X4KSmuAx
	 6A0ACQqNLNhXj1+gYiymBKnpllHjPDwd3/bawVtZo6xjjUVjBffDQfb8k9bpmFA881
	 ipgsP4NNtnW4g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/12] sched_ext: scx_qmap - Add rescue support
Date: Fri, 31 Jul 2026 22:51:50 -1000
Message-ID: <20260801085150.2697653-13-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sched holds only the cids its parent granted and nothing guarantees that
they cover its tasks' affinities. A task that can run on none of them has
nowhere to go and qmap stalls out: it force-inserts the task onto its first
allowed cid, but the kernel bounces the insert back and the task parks in
SHARED_DSQ, which is drained only on self cids it can't run on.

Set SCX_ENQ_RESCUE on these inserts so the kernel diverts such tasks to its
rescue path instead of bouncing them. The force-insert covers scheds with
and without children and fires on re-enqueues, and the SHARED_DSQ scan on
every dispatch rescues tasks stranded there - the enqueue-time check misses
a task whose cids were lost while it was already queued. The wrong-cid fault
injection carries the flag too and doubles as a deterministic rescue-traffic
generator.

-B and -q set the root-only rescue bandwidth and quantum ops knobs. -B 0
maps to SCX_RESCUE_DISABLE and turns rescue off kernel-side. Rescue inserts
are counted and reported in the hier stats line.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 85 +++++++++++++++++++++++-----------
 tools/sched_ext/scx_qmap.c     | 23 +++++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 79 insertions(+), 30 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 9a0321e84e88..b6e7b004611c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -449,31 +449,33 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
 	/*
-	 * A node with children delegates most cids. A task of ours that can run
-	 * on none of our self cids (e.g. a per-NUMA kthread pinned to delegated
-	 * cids) would starve in SHARED/FIFO since we never pull those on a
-	 * delegated cid. Force it onto its first allowed cid's local DSQ with
-	 * needs_immed(): if we hold access there it runs, else the kernel
-	 * rejects and bounces it back via REENQ_CAP. Best-effort
-	 * anti-starvation nudge.
+	 * A task of ours that can run on none of our self cids - the parent
+	 * didn't grant them or we delegated them to children - would starve in
+	 * SHARED/FIFO since we only pull from those on self cids.
+	 *
+	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
+	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
+	 * diverts the task to its rescue path.
 	 */
-	if (qa.nr_sub_scheds && !(enq_flags & SCX_ENQ_REENQ) &&
-	    !cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
+	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
 		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
 
 		if (c >= 0 && c < scx_bpf_nr_cids()) {
 			taskc->force_local = false;
+			__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
 			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | c, slice_ns,
-					   enq_flags | needs_immed(c));
+					   enq_flags | needs_immed(c) | SCX_ENQ_RESCUE);
 			return;
 		}
 	}
 
 	/*
 	 * Fault injection: deliberately dispatch one of our own tasks to a cid
-	 * we don't hold. The kernel cap check must reject it and re-enqueue
-	 * with SCX_TASK_REENQ_CAP, so nr_inject_attempts tracks nr_reenq_cap
-	 * and proves delivery-time enforcement. Throttled.
+	 * we don't hold. The inserts carry SCX_ENQ_RESCUE and divert to the
+	 * kernel rescue path, a deterministic rescue-traffic generator. Under
+	 * -B 0 the kernel cap check rejects and re-enqueues them instead, so
+	 * nr_inject_attempts tracks nr_reenq_cap 1:1 and proves delivery-time
+	 * enforcement. Throttled.
 	 */
 	if (qa.inject_mode == QMAP_INJ_WRONG_CID && p->nr_cpus_allowed > 1 &&
 	    !(enq_flags & SCX_ENQ_REENQ)) {
@@ -484,8 +486,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
 			if (bad >= 0 && cmask_test(bad, &taskc->cpus_allowed)) {
 				__sync_fetch_and_add(&qa.nr_inject_attempts, 1);
-				scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | bad,
-						   slice_ns, enq_flags);
+				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
+				scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | bad, slice_ns,
+						   enq_flags | SCX_ENQ_RESCUE);
 				return;
 			}
 		}
@@ -588,29 +591,47 @@ static void update_core_sched_head_seq(struct task_struct *p)
 }
 
 /*
+ * One pass over SHARED_DSQ: rescue stranded tasks and boost highpri ones. A
+ * task whose cids were lost while it was queued in the fifos would strand on
+ * SHARED_DSQ, which is consumed only on self cids it can't run on - move it to
+ * the kernel rescue path. One whose cids were lost after the highpri cull is
+ * likewise rescued out of HIGHPRI_DSQ below.
+ *
  * To demonstrate the use of scx_bpf_dsq_move(), implement silly selective
- * priority boosting mechanism by scanning SHARED_DSQ looking for highpri tasks,
- * moving them to HIGHPRI_DSQ and then consuming them first. This makes minor
- * difference only when dsp_batch is larger than 1.
+ * priority boosting mechanism by moving highpri tasks to HIGHPRI_DSQ and then
+ * consuming them first. This makes minor difference only when dsp_batch is
+ * larger than 1.
  *
  * scx_bpf_dsq_move[_vtime]() are allowed both from ops.dispatch() and
  * non-rq-lock holding BPF programs. As demonstration, this function is called
  * from qmap_dispatch() and monitor_timerfn().
  */
-static bool dispatch_highpri(bool from_timer)
+static bool scan_shared_dsq(bool from_timer)
 {
 	struct task_struct *p;
 	s32 this_cid = scx_bpf_this_cid();
 	u32 nr_cids = scx_bpf_nr_cids();
 
-	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
+	/* rescue strands and move highpri tasks to HIGHPRI_DSQ */
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
 		static u64 highpri_seq;
 		task_ctx_t *taskc;
+		s32 c;
 
 		if (!(taskc = lookup_task_ctx(p)))
 			return false;
 
+		/* stranded? rescue - it can't be dispatched here either way */
+		if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
+			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+			if (c >= 0 && c < scx_bpf_nr_cids()) {
+				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
+				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
+						 needs_immed(c) | SCX_ENQ_RESCUE);
+			}
+			continue;
+		}
+
 		if (taskc->highpri) {
 			/* exercise the set_*() and vtime interface too */
 			scx_bpf_dsq_move_set_slice(BPF_FOR_EACH_ITER, slice_ns * 2);
@@ -640,8 +661,17 @@ static bool dispatch_highpri(bool from_timer)
 			cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
 						      &qa.self_cids.mask,
 						      this_cid + 1);
-		if (cid >= nr_cids)
+		if (cid >= nr_cids) {
+			/* stranded after the cull - rescue it from here */
+			s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+
+			if (c >= 0 && c < nr_cids) {
+				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
+				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
+						 needs_immed(c) | SCX_ENQ_RESCUE);
+			}
 			continue;
+		}
 
 		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cid,
 				     SCX_ENQ_PREEMPT | needs_immed(cid))) {
@@ -670,10 +700,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 	struct cpu_ctx __arena *cpuc;
 	task_ctx_t *taskc;
 	u32 batch = dsp_batch ?: 1;
-	s32 owner;
-	s32 i;
+	s32 owner, i;
 
-	if (dispatch_highpri(false))
+	if (scan_shared_dsq(false))
 		return;
 
 	/*
@@ -785,11 +814,10 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 			 */
 			if (!cmask_test(cid, &taskc->cpus_allowed))
 				scx_bpf_kick_cid(scx_bpf_task_cid(p), 0);
-
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
-				if (dispatch_highpri(false))
+				if (scan_shared_dsq(false))
 					return;
 				scx_bpf_dsq_move_to_local(SHARED_DSQ, needs_immed(cid));
 				return;
@@ -801,6 +829,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 		cpuc->dsp_cnt = 0;
 	}
 
+	if (scan_shared_dsq(false))
+		return;
+
 	/*
 	 * No other tasks. @prev will keep running. Update its core_sched_seq as
 	 * if the task were enqueued and dispatched immediately.
@@ -1185,7 +1216,7 @@ static void dump_shared_dsq(void)
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	bpf_rcu_read_lock();
-	dispatch_highpri(true);
+	scan_shared_dsq(true);
 	bpf_rcu_read_unlock();
 
 	monitor_cpuperf();
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 3f54796e48be..189c8fed2f68 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -72,6 +72,8 @@ const char help_fmt[] =
 "  -J MODE       Fault injection (wrong-cid: dispatch to a cid not held,\n"
 "                init-fail/cgrp-init-fail: fail init_task/cpuctl_init for\n"
 "                \"qmfail*\" comms/cgroups)\n"
+"  -B PPT        Rescue bandwidth in parts per thousand, 0 disables (root only, default 20)\n"
+"  -q US         Rescue batch quantum in microseconds (root only, default 5000)\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -106,6 +108,7 @@ struct hier_prev {
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
 	u64 nr_inject_attempts;
+	u64 nr_rescue_dsp;
 };
 
 /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
@@ -187,14 +190,16 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu rescue=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
-	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts));
+	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
+	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
+	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
 
 	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
 	       "", "cgroup", "w", "alloc", "disp/s", "cids");
@@ -256,7 +261,8 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
+	while ((opt = getopt(argc, argv,
+			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -400,6 +406,17 @@ int main(int argc, char **argv)
 			else
 				inject_mode = strtoul(optarg, NULL, 0);
 			break;
+		case 'B': {
+			u32 ppt = strtoul(optarg, NULL, 0);
+
+			if (!ppt)
+				ppt = __COMPAT_ENUM_OR_ZERO("scx_consts", "SCX_RESCUE_DISABLE");
+			skel->struct_ops.qmap_ops->rescue_bandwidth_ppt = ppt;
+			break;
+		}
+		case 'q':
+			skel->struct_ops.qmap_ops->rescue_quantum_us = strtoul(optarg, NULL, 0);
+			break;
 		case 'v':
 			verbose = true;
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c42f7ef74b89..c8f602d58ca3 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -175,6 +175,7 @@ struct qmap_arena {
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
+	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
 
-- 
2.55.0

