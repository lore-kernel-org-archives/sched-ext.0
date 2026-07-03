Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F23769FF;
	Fri,  3 Jul 2026 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065741; cv=none; b=IVlAUhaoYY8HRvithd8OinBtnpAiTAyLxs1XMcABXNimQk49LYzgmfzsGuunTZ0RZmGKU7Net0rx7EGWTRIfvc4HW6UpGM+YgZSrAOivwQJHnpn4P50CrVayEPkWMR0ucvYDEScOYLKt11k+CXuyrav98ByPjuBgQN6OSEk+fDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065741; c=relaxed/simple;
	bh=Q9MHvO1Mg+fJgEmB5ToXhPQf5PaGzFnFoAHtM5PqRLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUvUA4ZoQHITzgXMjc9HLPA6S1xE0YeLPquYQLOYkas2qfdcBF7XlzqaER8jf4KI/4YZpoMwNb1eMqW77kkGqqbq3MkkeSnjwIudKbi8WPYI5o3GGfZK9G1Z6Je2SmtJKuPRDyFX6efjhhuXHcIYq8rjyZck1xrkpBI+udecYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIFJTLCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIFJTLCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DDB1F000E9;
	Fri,  3 Jul 2026 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065740;
	bh=BPJPZtvPNmvxz8zHs3l4lLnqw91ZscDgdeY9b3+eMPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIFJTLCPiaGIAWyZIayZGNZqkN3F5S5ERK8mEYiGCL/fqOmiPo72iAV++wuX5PeSN
	 GkEYLp4xdEDC4qX43SCBQN0UQim+YVsP982Jut0zYPon42clKL1H9r/JmWnrPNKT34
	 k+HlwE+Xd1X0ThrUUZ8BsTRfxsdoVA+a5GTtRpEkaw4/0k0jq9iT/b49nbvoCDf5XA
	 deDxEf52NvG9YZ8o5fyFFKrPZ/OdmGtWVrsISL5NMF5hyCKuVxnhn+a02X/wMmGUOx
	 KHlmk5xyAS1yqCOaxQy4YmzdleIjlyqYt88oepwM2/WOhmbZ0wajOCIYC9fTBBuRMs
	 0h1Qs3qccldcg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 20/32] sched_ext: Generalize local-DSQ handling to rq-owned DSQs
Date: Thu,  2 Jul 2026 22:01:47 -1000
Message-ID: <20260703080159.2314350-21-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index 4f0d72658fd8..7d8846cea425 100644
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
@@ -1263,11 +1274,10 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
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
@@ -1327,13 +1337,13 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
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
 
@@ -1428,8 +1438,8 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	 * ops_state first, both sides would modify p->scx.flags
 	 * concurrently in a non-atomic way.
 	 */
-	if (is_local) {
-		local_dsq_post_enq(sch, dsq, p, enq_flags);
+	if (is_rq_owned) {
+		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
 	} else {
 		/*
 		 * Task on global/bypass DSQ: leave custody, task on
@@ -1476,7 +1486,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
-	bool is_local = dsq == &rq->scx.local_dsq;
+	bool is_rq_owned = dsq && dsq_is_rq_owned(dsq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -1500,7 +1510,7 @@ static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_lock(&dsq->lock);
 
 	/*
@@ -1522,7 +1532,7 @@ static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
 
@@ -2074,7 +2084,7 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
-	local_dsq_post_enq(sch, dst_dsq, p, enq_flags);
+	rq_owned_post_enq(sch, dst_rq, dst_dsq, p, enq_flags);
 }
 
 /**
-- 
2.54.0

