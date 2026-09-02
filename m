Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BBD27473
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316399; cv=none; b=S9bTMmoz/l8mqdhBqE5YcuxkkrGOT9arRgZqaIbCTp8pP19AXjRgt+xJbqx6oj3ppb0+20dJITedBq6xwK/oTpGmdOG2XfEg93fV3pipOckHBM8dV3tXJnYmuZwubj5kVGq3fDcsu6e2YXSv17/eipPReNrsKyuRLGhfP2jSKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316399; c=relaxed/simple;
	bh=glb/PBEdqzL+kf+Rd4lYjWAv5dYTlz5u+8uroq7iHTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NphbJDR62ZwUW41RbtS3ZlcMwxG1lTWmZF0QlspaYBxnxS6B39+poi5W20MIxiKxB9KxXIEGJvUItBp+kYBT7Td3bsNbz4RbulvA0tGCsVQeOeMKrt8DzbmxoJySAwTtu48+90FBMYsrqCT6ePXl7Lb819EYoFqzineIpfAtbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a13b21d8a67611f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c53d5b8c-cd27-4641-813e-96df5e92ab8a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:fc1440427db02e7aefa831dd421f8373,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:5,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a13b21d8a67611f19a56ed5b684f684d-20260902
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2054270029; Wed, 02 Sep 2026 10:33:06 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH v2] sched_ext: Reject NMI calls to lock-taking kfuncs
Date: Wed,  2 Sep 2026 10:31:24 +0800
Message-Id: <20260902023124.1422942-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
References: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e06ece82d7b0 ("sched_ext: Report NMI kicks with scx_error()") made
scx_bpf_kick_cpu() reject NMI calls, and its cover letter describes the
reachability: sched_ext kfuncs in the "any" category "are callable from
tracing progs that can attach to functions running in NMI", and an unlucky
call from there "could deadlock the machine". The fix in that series made
the error/exit path lock-free so scx_error() is safe to call from NMI. That
closes the *error* path of every kfunc, but not a kfunc's own
business-logic lock acquisition on its success path.

The remaining lock-taking kfuncs that scx_kfunc_context_filter() exposes to
BPF_PROG_TYPE_TRACING have the same hazard: if an NMI lands on a CPU whose
interrupted context already holds the lock, the kfunc's raw spinlock
acquisition spins forever and hard-locks the CPU:

 - scx_bpf_destroy_dsq()                    -> dsq->lock
 - scx_bpf_dsq_reenq()                      -> rq's deferred_reenq_lock
 - scx_bpf_cpuperf_set() / scx_bpf_cidperf_set() -> rq->lock
 - scx_bpf_sub_grant() / scx_bpf_sub_revoke()     -> pshard lock
   (via the shared sub_cap_preamble())
 - bpf_iter_scx_dsq_next() / bpf_iter_scx_dsq_destroy() -> dsq->lock
   (bpf_iter_scx_dsq_new() is lockless and needs no guard)

As things stand, there is no scenario for reenqueueing, iterating a DSQ,
setting a performance target or granting sub-caps from NMI. The guards
defend against a buggy or malicious BPF program turning an "any"-category
kfunc into a machine-wide hard-lockup through the door that
scx_kfunc_context_filter() already opens. This matches the intent of
scx_bpf_kick_cpu()'s NMI check, which the commit cited above added not to
enable an NMI use case but to surface such a bug as a clean abort.

Route all of them through a new scx_kf_allowed_ctx() helper and reuse
scx_bpf_kick_cpu()'s existing in_nmi() check - now shared with its cid
equivalent scx_bpf_kick_cid() through scx_kick_cpu() - so the rule is
stated once and the coverage is auditable from one place. scx_error() is
already NMI-safe (commit f883dbb64ca5 ("sched_ext: Make exit claiming
lock-free")), so the reject-abort cannot deadlock the lock acquisition.
Kfuncs with an error return report -EDEADLK, the situation being avoided.

Read-only members of the reachable sets (dsq_peek, dsq_nr_queued,
cpuperf_cur/cap, sub_caps, the idle cpumask helpers and the cid lookups)
take no scheduler lock on the path a tracing program reaches them, and were
audited to that effect; they are correctly left unguarded. The select_cpu
kfuncs do take pi_lock, but scx_kfunc_context_filter() only exposes the
any/idle/cid sets to BPF_PROG_TYPE_TRACING, and struct_ops run in task
context, so no lock-taking path here is reachable from NMI.

Link: https://lore.kernel.org/r/20260901095652.1009104-1-liwanwu@kylinos.cn
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
Changes in v2:
- Rename the helper to scx_kf_allowed_ctx(), implemented as a macro that
  passes __func__ to the inline __scx_kf_allowed_ctx() so callers no longer
  spell out @who (Tejun Heo).
- Report -EDEADLK instead of -EBUSY where a kfunc bails out with an error
  (Tejun Heo).
- Condense the in-code comment to the suggested wording (Tejun Heo); the
  extended rationale now lives in this commit message.
- Move the destroy_dsq() guard into the scx_bpf_destroy_dsq() kfunc itself
  so that __func__ reports the user-visible name and the internal callers
  of destroy_dsq() are unaffected. scx_kick_cpu() now reports itself in the
  error message (shared with scx_bpf_kick_cid()).
- Carry over Acked-by from Andrea Righi (v1).

 kernel/sched/ext/ext.c      | 33 ++++++++++++++++++++++++---------
 kernel/sched/ext/internal.h | 17 +++++++++++++++++
 kernel/sched/ext/sub.c      |  3 +++
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..09ce239e9c4b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9518,14 +9518,8 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	/*
-	 * The per-cpu kick list is guarded only by local_irq_save(), which does
-	 * not mask NMIs, so kicking from NMI could corrupt it and is unsupported.
-	 */
-	if (unlikely(in_nmi())) {
-		scx_error(sch, "scx_bpf_kick_cpu() called from NMI");
+	if (!scx_kf_allowed_ctx(sch))
 		return;
-	}
 
 	local_irq_save(irq_flags);
 
@@ -9693,8 +9687,13 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id, const struct bpf_prog_aux *aux)
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
-	if (sch)
-		destroy_dsq(sch, dsq_id);
+	if (!sch)
+		return;
+
+	if (!scx_kf_allowed_ctx(sch))
+		return;
+
+	destroy_dsq(sch, dsq_id);
 }
 
 /**
@@ -9756,6 +9755,9 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
 	if (!kit->dsq)
 		return NULL;
 
+	if (!scx_kf_allowed_ctx(kit->dsq->sched))
+		return NULL;
+
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
 	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
@@ -9777,6 +9779,9 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	if (!list_empty(&kit->cursor.node)) {
 		unsigned long flags;
 
+		if (!scx_kf_allowed_ctx(kit->dsq->sched))
+			return;
+
 		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
 		list_del_init(&kit->cursor.node);
 		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
@@ -9857,6 +9862,9 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 		return;
 	}
 
+	if (!scx_kf_allowed_ctx(sch))
+		return;
+
 	/* not specifying any filter bits is the same as %SCX_REENQ_ANY */
 	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
 		reenq_flags |= SCX_REENQ_ANY;
@@ -10244,6 +10252,9 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 	if (unlikely(!sch))
 		return;
 
+	if (!scx_kf_allowed_ctx(sch))
+		return;
+
 	scx_cpuperf_set(sch, cpu, perf);
 }
 
@@ -10269,6 +10280,10 @@ __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32 perf,
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
 		return -ENODEV;
+
+	if (!scx_kf_allowed_ctx(sch))
+		return -EDEADLK;
+
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return cpu;
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d90..d7f48ec63e01 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2091,6 +2091,23 @@ extern struct scx_sched *scx_enabling_sub_sched;
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
 
+/*
+ * Tracing progs can call kfuncs from NMI. Kfuncs that take scheduler locks or
+ * touch the kick lists, which are only protected by irq masking, can't run
+ * there, so abort the scheduler instead. scx_error() is NMI-safe.
+ */
+static __always_inline bool __scx_kf_allowed_ctx(struct scx_sched *sch,
+						 const char *who)
+{
+	if (unlikely(in_nmi())) {
+		scx_error(sch, "%s called from NMI", who);
+		return false;
+	}
+	return true;
+}
+
+#define scx_kf_allowed_ctx(sch) __scx_kf_allowed_ctx((sch), __func__)
+
 /**
  * scx_root_protected_live - Root sched for paths that only run while live
  *
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0554448835bd..7d444f7aa7ab 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2265,6 +2265,9 @@ static s32 sub_cap_preamble(u64 cgroup_id, u64 caps, const struct bpf_prog_aux *
 	if (unlikely(!parent))
 		return -ENODEV;
 
+	if (!__scx_kf_allowed_ctx(parent, "sub-cap kfuncs"))
+		return -EDEADLK;
+
 	if (!scx_is_cid_type()) {
 		scx_error(parent, "sub-cap kfuncs require a cid-form scheduler");
 		return -EOPNOTSUPP;
-- 
2.25.1

