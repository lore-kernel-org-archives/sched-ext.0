Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACE47208B
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256625; cv=none; b=MR0W5U7oxNjCKBL47BYVWdn8Me1AwB+5M/upq6E2iS44hpDZdIZx89kUcKXyRS5UWFXcwNINq1ktJheutvq6mhQlC7BfOFdAIx7ZPzjrp7VgAMIDCAEvLC81xWDXNS1QlQzEUjym5uSsydUP8iam6B4cZ+VQeR96ZAtRbyjWxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256625; c=relaxed/simple;
	bh=pLU6H4VtoQMohAI3AVcy1kXr5S+mZmDCFeJzD3CFymw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IuYeOI1cadJCCe2Wrra3iwn5Wok6XdzCHhGbV8zFZle71gl2VfxkQ0F8G5LoTULaf+XNusw7VhwwvDm9BRW4C+Wo40alMx/MZlzumjVNSCUu9+HBlWh3WKTtoKjQ5BitrefEXPAxbOl1AMWg/iQMu7KeDkakjoHbnapRM7IQATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7665532ea5eb11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7f1f2c52-6a02-472d-8b22-12e4e64d2b06,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0f3500f0984a7eb79c7e8561c9ed82ee,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:5,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7665532ea5eb11f19a56ed5b684f684d-20260901
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1995746973; Tue, 01 Sep 2026 17:56:54 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Reject NMI calls to lock-taking kfuncs
Date: Tue,  1 Sep 2026 17:56:52 +0800
Message-Id: <20260901095652.1009104-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Route all of them through a new scx_kfunc_nmi_safe() helper and reuse
scx_bpf_kick_cpu()'s existing in_nmi() check - now shared with its cid
equivalent scx_bpf_kick_cid() through scx_kick_cpu() - so the rule is
stated once and the coverage is auditable from one place. scx_error() is
already NMI-safe (commit f883dbb64ca5 ("sched_ext: Make exit claiming
lock-free")), so the reject-abort cannot deadlock the lock acquisition.

Read-only members of the reachable sets (dsq_peek, dsq_nr_queued,
cpuperf_cur/cap, sub_caps, the idle cpumask helpers and the cid lookups)
take no scheduler lock on the path a tracing program reaches them, and were
audited to that effect; they are correctly left unguarded. The select_cpu
kfuncs do take pi_lock, but scx_kfunc_context_filter() only exposes the
any/idle/cid sets to BPF_PROG_TYPE_TRACING, and struct_ops run in task
context, so no lock-taking path here is reachable from NMI.

Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 27 ++++++++++++++++++++-------
 kernel/sched/ext/internal.h | 22 ++++++++++++++++++++++
 kernel/sched/ext/sub.c      |  3 +++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..a0b886975e1d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5108,6 +5108,9 @@ static void destroy_dsq(struct scx_sched *sch, u64 dsq_id)
 	struct scx_dispatch_q *dsq;
 	unsigned long flags;
 
+	if (!scx_kfunc_nmi_safe("scx_bpf_destroy_dsq()", sch))
+		return;
+
 	rcu_read_lock();
 
 	dsq = find_user_dsq(sch, dsq_id);
@@ -9518,14 +9521,8 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	/*
-	 * The per-cpu kick list is guarded only by local_irq_save(), which does
-	 * not mask NMIs, so kicking from NMI could corrupt it and is unsupported.
-	 */
-	if (unlikely(in_nmi())) {
-		scx_error(sch, "scx_bpf_kick_cpu() called from NMI");
+	if (!scx_kfunc_nmi_safe("scx_bpf_kick_cpu()", sch))
 		return;
-	}
 
 	local_irq_save(irq_flags);
 
@@ -9756,6 +9753,9 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
 	if (!kit->dsq)
 		return NULL;
 
+	if (!scx_kfunc_nmi_safe(__func__, kit->dsq->sched))
+		return NULL;
+
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
 	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
@@ -9777,6 +9777,9 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	if (!list_empty(&kit->cursor.node)) {
 		unsigned long flags;
 
+		if (!scx_kfunc_nmi_safe(__func__, kit->dsq->sched))
+			return;
+
 		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
 		list_del_init(&kit->cursor.node);
 		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
@@ -9857,6 +9860,9 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 		return;
 	}
 
+	if (!scx_kfunc_nmi_safe(__func__, sch))
+		return;
+
 	/* not specifying any filter bits is the same as %SCX_REENQ_ANY */
 	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
 		reenq_flags |= SCX_REENQ_ANY;
@@ -10244,6 +10250,9 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 	if (unlikely(!sch))
 		return;
 
+	if (!scx_kfunc_nmi_safe(__func__, sch))
+		return;
+
 	scx_cpuperf_set(sch, cpu, perf);
 }
 
@@ -10269,6 +10278,10 @@ __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32 perf,
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
 		return -ENODEV;
+
+	if (!scx_kfunc_nmi_safe(__func__, sch))
+		return -EBUSY;
+
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return cpu;
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d90..49b165effd67 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2091,6 +2091,28 @@ extern struct scx_sched *scx_enabling_sub_sched;
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
 
+/*
+ * sched_ext kfuncs that take scheduler locks are not NMI-safe: a
+ * BPF_PROG_TYPE_TRACING program can be attached to a function that runs in
+ * NMI, and scx_kfunc_context_filter() lets such a program call every kfunc in
+ * the any/cid/idle sets. Acquiring the rq, dsq or pshard raw spinlocks - or
+ * touching the irq-masking-only kick list - from NMI while the interrupted
+ * context on the same CPU already holds them deadlocks (or corrupts) it.
+ * scx_bpf_kick_cpu() was the first guard; route all of them through here.
+ *
+ * Returns true when the caller may proceed, false when running from NMI and
+ * the kfunc must bail without touching locks. scx_error() is NMI-safe (see the
+ * lock-free ->aborting claim).
+ */
+static inline bool scx_kfunc_nmi_safe(const char *who, struct scx_sched *sch)
+{
+	if (unlikely(in_nmi())) {
+		scx_error(sch, "%s called from NMI", who);
+		return false;
+	}
+	return true;
+}
+
 /**
  * scx_root_protected_live - Root sched for paths that only run while live
  *
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0554448835bd..b5125a871562 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2265,6 +2265,9 @@ static s32 sub_cap_preamble(u64 cgroup_id, u64 caps, const struct bpf_prog_aux *
 	if (unlikely(!parent))
 		return -ENODEV;
 
+	if (!scx_kfunc_nmi_safe("sub-cap kfuncs", parent))
+		return -EBUSY;
+
 	if (!scx_is_cid_type()) {
 		scx_error(parent, "sub-cap kfuncs require a cid-form scheduler");
 		return -EOPNOTSUPP;
-- 
2.25.1

