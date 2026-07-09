Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C63C0633;
	Thu,  9 Jul 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637463; cv=none; b=PTh2KLd/jFPHkXvEBo4MZA9iROF+R/ensdTxtpP8MGKiGtGxZpuGt9fTHx72yd4ip9OMm5sjV4o0zjKt6z0m6IcX/vde7RSU9TC2KBmeamD2Tls6gHG7z/c2c7Koz3APkerOik1m82QUPI/EsRS9N0ZciSPfXxbRE6JwyxBj2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637463; c=relaxed/simple;
	bh=Qvlq+G+yo8cBl0fVU+u6ihmyZY349289MLhJXnk2OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ3vu2/bY1uQLd3M+uJ3cA33qW4071eHio35LjWFNy5+emrGadt8dO6o7H8jwmrxE4ZcgzGZh84DtLs0W9R7vyWvkjj+gR5qSYCuM28z/o1wg1/BqIYSVloGHp/CA7/lJ2dIEjjlDGrX9d0C2vu4JowZ7iIUgwCe6CoyciCq77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtSLT3NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtSLT3NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0061F000E9;
	Thu,  9 Jul 2026 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637461;
	bh=9/RWg2GecaryKN0shBEpzoGthIrosBf7BftgLAo1RSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MtSLT3NCq54/8AyLPxXcZsLACdKfUbM0nkxKJX9dDpk5TCJOrP27EQTiVjZSgYpwb
	 pGwRRbhbXJnKVFpkSz5Jp61zF3f8RARDD2n2G8pMkFnzoiwisQuMPFLiJCoLDSgOuH
	 nSFMSg0pk2Mq3a8JRYw6iAllFjg/4aZrkp3vpimqzcAPep1XuMMN+aviFRGNS9XElP
	 7cNgc+Ufjqelh5eQXSUREk93AWEruFRNF9jlbqNO1KsYl4rl3SRFgTDVYMCn0VTgWD
	 7NclD4XSqz5WgwPrzGIoEMLGkZB4XbZfI1ll7rpz2HVmgd3rL1fYRKlYP5SM9EOrJO
	 FVIiCVxI5kIbA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 17/33] sched_ext: Generalize local-DSQ handling to rq-owned DSQs
Date: Thu,  9 Jul 2026 12:50:25 -1000
Message-ID: <20260709225041.1695495-18-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local DSQ is synchronized by the containing rq lock rather than its own
dsq->lock. A later patch adds a second such DSQ. In preparation, factor the
"rq owns the lock" test into dsq_is_rq_owned() and rename
local_dsq_post_enq() to rq_owned_post_enq(), taking @rq explicitly.

No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9d111bdd05e9..f58cf7c39b6e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -96,6 +96,17 @@ static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 /* Global cursor for the per-CPU tid allocator. Starts at 1; tid 0 is reserved. */
 static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
 
+/* is @dsq synchronized by the containing rq lock instead of dsq->lock? */
+static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
+{
+	switch (dsq->id) {
+	case SCX_DSQ_LOCAL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -1270,11 +1281,10 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
-static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			       struct task_struct *p, u64 enq_flags)
+static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
+			      struct scx_dispatch_q *dsq, struct task_struct *p,
+			      u64 enq_flags)
 {
-	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
@@ -1334,13 +1344,13 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 enq_flags)
 {
-	bool is_local = dsq->id == SCX_DSQ_LOCAL;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
 		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
 
-	if (!is_local) {
+	if (!is_rq_owned) {
 		raw_spin_lock_nested(&dsq->lock,
 			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
 
@@ -1435,8 +1445,8 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	 * ops_state first, both sides would modify p->scx.flags
 	 * concurrently in a non-atomic way.
 	 */
-	if (is_local) {
-		local_dsq_post_enq(sch, dsq, p, enq_flags);
+	if (is_rq_owned) {
+		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
 	} else {
 		/*
 		 * Global and bypass DSQs are terminal - the task leaves the
@@ -1487,7 +1497,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
-	bool is_local = dsq == &rq->scx.local_dsq;
+	bool is_rq_owned = dsq && dsq_is_rq_owned(dsq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -1511,7 +1521,7 @@ static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_lock(&dsq->lock);
 
 	/*
@@ -1533,7 +1543,7 @@ static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
 
@@ -2085,7 +2095,7 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
-	local_dsq_post_enq(sch, dst_dsq, p, enq_flags);
+	rq_owned_post_enq(sch, dst_rq, dst_dsq, p, enq_flags);
 }
 
 /**
-- 
2.55.0

