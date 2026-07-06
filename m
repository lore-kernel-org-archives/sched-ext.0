Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583239A4BA;
	Mon,  6 Jul 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302094; cv=none; b=FQaEVW6bTgH/irtiURKUl4cN3gDUlzSBPNiX62v3Aw4KBMCUgh85grvv6kwVYbFQ/m9UTWMJbxbJrH7tkUduo8NuxNoSpOhveasVztxcG1Gh94wHRvoodamP05+XgYQ+ulo94/EcqT3vwY4eL3YuqKRI4zpPV1w1RIYs0H6jcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302094; c=relaxed/simple;
	bh=aQvRSIVx43SGtv+62tVl5iNgFuEb+s+vLT86Y04Ykl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKCpEhXRTUsTQW5PgVGAUbP9ofaE6jsdMyZHrNiOnZ7J41gSTlwDHuEdcI21UICVSF52dU8tK1/fXo1Gel7YBYJc5m0NvxQbB4UBaosRKKOJIma18xc1iL2yB7TuTH12UwrK71LFsCz4FfLTyQOWaCw+ZQRVvdmPeIsmHsLiP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt55cZp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt55cZp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA161F000E9;
	Mon,  6 Jul 2026 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302092;
	bh=bmXuZcekeP7LQs2S5bVNv3dLRSiL4xAORxPjeJveYdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rt55cZp/sZgpdJ1T17o4mDrZUtAQQL+x2OxDm8DUwJT//naGMAw0NvwjNZwZdfzf8
	 4yA16i3++H3+jyYcv/Tvo4cjGKMqWf3FPxobnvy6WPaLApafLtdazgAvgwKtcMNk+y
	 3DDCbt/OCi82ymsTuWGzoNiZeZ0XQnpNnFuVoy1S1iSGyc6l6PvImecTgFX+u7vnHr
	 NPmvxp9YhH2IL9BWkjSg8yTPLQBmnqFfCGFxKfoqdAMoI3eipLHUV4lqxzttt8q0FR
	 zGfjEIdX8o/uSo6KbOW6B1axIPHJ5x6sJwGFCZXiJTQQLAR3CcrCeiodbRLUAwpefW
	 gytM+FtWgvpMg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 32/36] sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
Date: Sun,  5 Jul 2026 15:40:54 -1000
Message-ID: <20260706014058.439853-33-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__scx_update_idle() notified only the root scheduler. A sub-scheduler that
holds a cid needs that cid's idle state to place and kick on it.

Deliver ops.update_idle() to every scheduler that holds SCX_CAP_BASE on the
transitioning cid. The root holds every cap, so a real transition always
reaches it.

Real transitions are not enough on their own. A cid that is already idle
when a sub-sched gains baseline access produces no transition, so the new
holder would never learn it is idle. The ecaps sync arms a re-notify on the
gain, and the next idle pick delivers ops.update_idle() to just that sched,
leaving holders that already track the cpu untouched. A matching loss of
baseline access drops any pending re-notify.

Bypass suppresses ops.update_idle() too, so a cpu that goes idle during a
bypass window and stays idle yields no transition to re-deliver on
un-bypass. Arm the same re-notify for every sched leaving bypass. The acute
case is a child granted cids during its own ops.sub_attach(). The grant
lands while the child is bypassed and the notify walk skips it, so on
un-bypass it holds cids it never saw go idle. The root is owed the same and
is armed through a separate per-rq flag, which keeps this working when
sub-schedulers are compiled out.

v2: Gate the idle catch-up in pick_task_idle() to avoid a double ops.update_idle(). (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 40 ++++++++++++++++-
 kernel/sched/ext/idle.c     | 86 ++++++++++++++++++++++++++-----------
 kernel/sched/ext/internal.h |  2 +
 kernel/sched/ext/sub.c      | 24 ++++++++++-
 kernel/sched/idle.c         |  8 +++-
 kernel/sched/sched.h        |  2 +
 6 files changed, 133 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 46ba905c96e2..8caca7fe2460 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5478,6 +5478,38 @@ void scx_disable_bypass_dsp(struct scx_sched *sch)
 	}
 }
 
+/**
+ * unbypass_renotify_idle - Arm an idle re-notify for a sched leaving bypass
+ * @rq: rq of the cpu leaving bypass
+ * @pos: scheduler that just left bypass on @rq's cpu
+ * @pcpu: @pos's per-cpu state for @rq's cpu
+ *
+ * A sched leaving bypass is owed the ops.update_idle() calls suppressed while
+ * bypassing. A cpu that goes idle during the bypass window and stays idle won't
+ * produce a notification. Arm a re-notify that scx_bypass()'s resched flushes
+ * on the next idle pick.
+ *
+ * An acute case is ops.sub_attach(). If the parent grants the child cids while
+ * attaching, when attach is complete and bypass is lifted, the child may hold
+ * idle cids it never saw go idle.
+ *
+ * The root is no exception as bypass suppresses its notifications the same way.
+ * However, the root uses a separate per-rq flag so its re-notify keeps working
+ * even when !CONFIG_EXT_SUB_SCHED.
+ */
+static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
+				   struct scx_sched_pcpu *pcpu)
+{
+	if (pos == scx_root) {
+		rq->scx.flags |= SCX_RQ_ROOT_IDLE_RENOTIFY;
+		return;
+	}
+#ifdef CONFIG_EXT_SUB_SCHED
+	pcpu->idle_renotify = true;
+	rq->scx.flags |= SCX_RQ_SUB_IDLE_RENOTIFY;
+#endif
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @sch: sched to bypass
@@ -5561,11 +5593,15 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+			bool was_bypassing = pcpu->flags & SCX_SCHED_PCPU_BYPASSING;
 
-			if (pos->bypass_depth)
+			if (pos->bypass_depth) {
 				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
-			else
+			} else {
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
+				if (was_bypassing)
+					unbypass_renotify_idle(rq, pos, pcpu);
+			}
 		}
 
 		raw_spin_unlock(&scx_sched_lock);
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 8e8c6201b7df..16ebe3ab8647 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -12,6 +12,7 @@
 #include "internal.h"
 #include "cid.h"
 #include "idle.h"
+#include "sub.h"
 
 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
@@ -730,6 +731,46 @@ static void update_builtin_idle(int cpu, bool idle)
 	}
 }
 
+/*
+ * Notify schedulers of an idle transition on @cpu's cid, delivering to every
+ * sched that holds %SCX_CAP_BASE on the cid (the root holds every cap). A real
+ * transition (@do_notify) reaches all holders. A forced one (@root_renotify for
+ * the root, a sub-sched's idle_renotify marker for a sub) reaches only the owed
+ * scheds.
+ */
+static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_renotify)
+{
+	s32 cpu = cpu_of(rq);
+	s32 cid = scx_cpu_arg(cpu);
+	struct scx_sched *pos;
+
+	lockdep_assert_rq_held(rq);
+
+	pos = scx_next_descendant_pre(NULL, scx_root);
+	while (pos) {
+		bool forced = false;
+
+		if (unlikely(scx_missing_caps(pos, cpu, SCX_CAP_BASE))) {
+			pos = scx_skip_subtree_pre(pos, scx_root);
+			continue;
+		}
+
+		if (pos == scx_root) {
+			forced = root_renotify;
+		}
+#ifdef CONFIG_EXT_SUB_SCHED
+		else if (per_cpu_ptr(pos->pcpu, cpu)->idle_renotify) {
+			per_cpu_ptr(pos->pcpu, cpu)->idle_renotify = false;
+			forced = true;
+		}
+#endif
+		if ((do_notify || forced) && SCX_HAS_OP(pos, update_idle) &&
+		    !scx_bypassing(pos, cpu))
+			SCX_CALL_OP(pos, update_idle, rq, cid, idle);
+		pos = scx_next_descendant_pre(pos, scx_root);
+	}
+}
+
 /*
  * Update the idle state of a CPU to @idle.
  *
@@ -748,44 +789,39 @@ static void update_builtin_idle(int cpu, bool idle)
  */
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 {
-	struct scx_sched *sch = scx_root;
 	int cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
 
 	/*
-	 * Update the idle masks:
-	 * - for real idle transitions (do_notify == true)
-	 * - for idle-to-idle transitions (indicated by the previous task
-	 *   being the idle thread, managed by pick_task_idle())
-	 *
-	 * Skip updating idle masks if the previous task is not the idle
-	 * thread, since set_next_task_idle() has already handled it when
-	 * transitioning from a task to the idle thread (calling this
-	 * function with do_notify == true).
-	 *
-	 * In this way we can avoid updating the idle masks twice,
-	 * unnecessarily.
+	 * pick_task_idle() calls here only on an idle-to-idle re-pick and the
+	 * transitions call with @do_notify, so every reaching call updates the
+	 * masks.
 	 */
 	if (static_branch_likely(&scx_builtin_idle_enabled))
-		if (do_notify || is_idle_task(rq->curr))
-			update_builtin_idle(cpu, idle);
+		update_builtin_idle(cpu, idle);
 
 	/*
-	 * Trigger ops.update_idle() only when transitioning from a task to
-	 * the idle thread and vice versa.
-	 *
-	 * Idle transitions are indicated by do_notify being set to true,
-	 * managed by put_prev_task_idle()/set_next_task_idle().
+	 * ops.update_idle() fires on real idle transitions, indicated by
+	 * @do_notify and managed by put_prev_task_idle()/set_next_task_idle().
+	 * An idle pick also fires it to flush a forced notify owed to a sched
+	 * that missed transitions while bypassed or on a cid it just gained.
+	 * unbypass_renotify_idle() and scx_process_sync_ecaps() arm the per-rq
+	 * gates, and scx_idle_notify() targets the owed scheds.
 	 *
-	 * This must come after builtin idle update so that BPF schedulers can
-	 * create interlocking between ops.update_idle() and ops.enqueue() -
+	 * This must come after the builtin idle update so that BPF schedulers
+	 * can create interlocking between ops.update_idle() and ops.enqueue() -
 	 * either enqueue() sees the idle bit or update_idle() sees the task
 	 * that enqueue() queued.
 	 */
-	if (SCX_HAS_OP(sch, update_idle) && do_notify &&
-	    !scx_bypassing(sch, cpu_of(rq)))
-		SCX_CALL_OP(sch, update_idle, rq, scx_cpu_arg(cpu_of(rq)), idle);
+	if (do_notify ||
+	    (idle && (rq->scx.flags &
+		      (SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY)))) {
+		bool root_renotify = rq->scx.flags & SCX_RQ_ROOT_IDLE_RENOTIFY;
+
+		rq->scx.flags &= ~(SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY);
+		scx_idle_notify(rq, idle, do_notify, root_renotify);
+	}
 }
 
 static void reset_idle_masks(struct sched_ext_ops *ops)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 3537c1dd532e..74160117465a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1244,6 +1244,8 @@ struct scx_sched_pcpu {
 	 */
 	u64			ecaps;
 	struct llist_node	ecaps_to_sync_node;
+	/* owed a forced update_idle() re-notify on this cpu */
+	bool			idle_renotify;
 	/* effective caps as of the last sub_ecaps_updated() delivery */
 	u64			reported_ecaps;
 #endif
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d23c1e3e8dfa..5a48304b72a6 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -470,6 +470,10 @@ static void discard_queued_syncs(struct rq *rq)
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
  * transposed copy owned by the cid's cpu and written only here under @rq's
  * lock.
+ *
+ * A sched that newly gains baseline access here is owed an update_idle() so it
+ * learns the cid's idle state. Such a gain arms the per-rq
+ * %SCX_RQ_SUB_IDLE_RENOTIFY gate so the next idle pick delivers it.
  */
 void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 {
@@ -505,7 +509,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
 		struct scx_pshard *ps = pcpu->sch->pshard[shard];
-		u64 old, ecaps, lost;
+		u64 old, ecaps, lost, gained;
 
 		init_llist_node(pos);
 
@@ -517,6 +521,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		WRITE_ONCE(pcpu->ecaps, ecaps);
 
 		lost = old & ~ecaps;
+		gained = ecaps & ~old;
 		lost_all |= lost;
 
 		/* tell the sched its effective caps on this cid changed */
@@ -534,6 +539,18 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 			scx_flush_dispatch_buf(pcpu->sch, rq);
 			pcpu->reported_ecaps = ecaps;
 		}
+
+		/*
+		 * Gaining baseline access owes an update_idle() so the sched
+		 * learns the cpu's idle state. Arm the per-rq gate so the next
+		 * idle pick flushes it. Losing access drops any pending notify.
+		 */
+		if (gained & SCX_CAP_BASE) {
+			pcpu->idle_renotify = true;
+			rq->scx.flags |= SCX_RQ_SUB_IDLE_RENOTIFY;
+		} else if (lost & SCX_CAP_BASE) {
+			pcpu->idle_renotify = false;
+		}
 	}
 
 	/*
@@ -1409,6 +1426,11 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 
 				caps_updated_record(cps, changed_cids, granted_caps,
 						    &to_deliver);
+				/*
+				 * The sync arms an update_idle() re-notify if
+				 * the cid gains baseline access, so the holder
+				 * learns of an already-idle cid.
+				 */
 				scx_cmask_for_each_cid(cid, changed_cids)
 					queue_sync_ecaps(child, cid);
 			}
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 052435f4d3e3..eb73b65ce6c4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -503,7 +503,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 
 struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
-	scx_update_idle(rq, true, false);
+	/*
+	 * Notify scx only on an idle-to-idle re-pick (the cpu was already idle).
+	 * A real task->idle transition is delivered by set_next_task_idle(), so
+	 * calling here too would duplicate it.
+	 */
+	if (scx_enabled() && is_idle_task(rq->curr))
+		scx_update_idle(rq, true, false);
 	return rq->idle;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cdd21c814008..54cff94556c0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -787,6 +787,8 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
+	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
+	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
-- 
2.54.0

