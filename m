Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA6425CF4;
	Fri,  6 Mar 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823997; cv=none; b=YRoc/7ISgoRrODKCsuLXCjBlA/nNnnHYljIolf4JZVCfbambm65+WGOw025lbHfgztSamMI5psocBgp3CcXzk1rPVS/hQxISb27o5gcBhBj0alDWOl/ktBcFG/eMCOD69ohuMSyUocDmkgb7Jqd2iZWVuFwH10WwhGkoZShzQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823997; c=relaxed/simple;
	bh=e5TTG3VOv2cy13Z3rEXnH7BxB3Fg7swDTjMt0kwSNCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlilCdRBxO9EMABMCPZDLU2E9rBNm/wKw1D6jG9/WoSSnzBwdtDe2xa9dQqVAvbTNWqbVA5kMfd4gSAlPLP8EJkUccG92y9DwvvNAoFRTIvtNQhVlobh8qYRmD4Vxj8mUSrAyfoSPkUTevAPXxG3kFNs/TDYhnK2RTfjj9lMcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2FcnifF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2FcnifF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3B7C19425;
	Fri,  6 Mar 2026 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823996;
	bh=e5TTG3VOv2cy13Z3rEXnH7BxB3Fg7swDTjMt0kwSNCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2FcnifFBDIzv9s6rdDD5HljSpSBL1Q7wOGEnUjq1gV2H2hthLHfU+xe6I0j19BTu
	 dg2zH3Z7tHvhb6VWpz/k10JMudsw/Tcje6TIFmLyRoXveUMTTJvoIs4b0rOaXkL8I6
	 h1ln1IwSRJQe8X3kUttHgipRBQAkLkSTZ1wS6rmjK9VxScxBGV0XKvCv/mrwv4lusR
	 DdCSfpG17QEr6+mjPTmp+tkRO6QMyEsBaeCZb1Qqw+dp++FNd8jnVWTe5sCuFTfabV
	 jRlwHHuPBV69zFAq69ZW1DjWnzfkhleey55Vl3aKPjmOX+1qAmUdFN92ZglZkPN93y
	 RlaAcmHbx+Zng==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/15] sched_ext: Factor out nldsq_cursor_next_task() and nldsq_cursor_lost_task()
Date: Fri,  6 Mar 2026 09:06:19 -1000
Message-ID: <20260306190623.1076074-12-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out cursor-based DSQ iteration from bpf_iter_scx_dsq_next() into
nldsq_cursor_next_task() and the task-lost check from scx_dsq_move() into
nldsq_cursor_lost_task() to prepare for reuse.

As ->priv is only used to record dsq->seq for cursors, update
INIT_DSQ_LIST_CURSOR() to take the DSQ pointer and set ->priv from dsq->seq
so that users don't have to read it manually. Move scx_dsq_iter_flags enum
earlier so nldsq_cursor_next_task() can use SCX_DSQ_ITER_REV.

bypass_lb_cpu() now sets cursor.priv to dsq->seq but doesn't use it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |   6 +-
 kernel/sched/ext.c        | 154 ++++++++++++++++++++++++--------------
 2 files changed, 102 insertions(+), 58 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 98cc1f41b91e..303f57dfb947 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -157,11 +157,11 @@ struct scx_dsq_list_node {
 	u32			priv;		/* can be used by iter cursor */
 };
 
-#define INIT_DSQ_LIST_CURSOR(__node, __flags, __priv)				\
+#define INIT_DSQ_LIST_CURSOR(__cursor, __dsq, __flags)				\
 	(struct scx_dsq_list_node) {						\
-		.node = LIST_HEAD_INIT((__node).node),				\
+		.node = LIST_HEAD_INIT((__cursor).node),			\
 		.flags = SCX_DSQ_LNODE_ITER_CURSOR | (__flags),			\
-		.priv = (__priv),						\
+		.priv = READ_ONCE((__dsq)->seq),				\
 	}
 
 struct scx_sched;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 996c410cc892..6e4f84d3c407 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -570,9 +570,22 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
 	return true;
 }
 
+enum scx_dsq_iter_flags {
+	/* iterate in the reverse dispatch order */
+	SCX_DSQ_ITER_REV		= 1U << 16,
+
+	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
+	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
+
+	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
+	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_HAS_SLICE |
+					  __SCX_DSQ_ITER_HAS_VTIME,
+};
+
 /**
  * nldsq_next_task - Iterate to the next task in a non-local DSQ
- * @dsq: user dsq being iterated
+ * @dsq: non-local dsq being iterated
  * @cur: current position, %NULL to start iteration
  * @rev: walk backwards
  *
@@ -612,6 +625,85 @@ static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
 	for ((p) = nldsq_next_task((dsq), NULL, false); (p);			\
 	     (p) = nldsq_next_task((dsq), (p), false))
 
+/**
+ * nldsq_cursor_next_task - Iterate to the next task given a cursor in a non-local DSQ
+ * @cursor: scx_dsq_list_node initialized with INIT_DSQ_LIST_CURSOR()
+ * @dsq: non-local dsq being iterated
+ *
+ * Find the next task in a cursor based iteration. The caller must have
+ * initialized @cursor using INIT_DSQ_LIST_CURSOR() and can release the DSQ lock
+ * between the iteration steps.
+ *
+ * Only tasks which were queued before @cursor was initialized are visible. This
+ * bounds the iteration and guarantees that vtime never jumps in the other
+ * direction while iterating.
+ */
+static struct task_struct *nldsq_cursor_next_task(struct scx_dsq_list_node *cursor,
+						  struct scx_dispatch_q *dsq)
+{
+	bool rev = cursor->flags & SCX_DSQ_ITER_REV;
+	struct task_struct *p;
+
+	lockdep_assert_held(&dsq->lock);
+	BUG_ON(!(cursor->flags & SCX_DSQ_LNODE_ITER_CURSOR));
+
+	if (list_empty(&cursor->node))
+		p = NULL;
+	else
+		p = container_of(cursor, struct task_struct, scx.dsq_list);
+
+	/* skip cursors and tasks that were queued after @cursor init */
+	do {
+		p = nldsq_next_task(dsq, p, rev);
+	} while (p && unlikely(u32_before(cursor->priv, p->scx.dsq_seq)));
+
+	if (p) {
+		if (rev)
+			list_move_tail(&cursor->node, &p->scx.dsq_list.node);
+		else
+			list_move(&cursor->node, &p->scx.dsq_list.node);
+	} else {
+		list_del_init(&cursor->node);
+	}
+
+	return p;
+}
+
+/**
+ * nldsq_cursor_lost_task - Test whether someone else took the task since iteration
+ * @cursor: scx_dsq_list_node initialized with INIT_DSQ_LIST_CURSOR()
+ * @rq: rq @p was on
+ * @dsq: dsq @p was on
+ * @p: target task
+ *
+ * @p is a task returned by nldsq_cursor_next_task(). The locks may have been
+ * dropped and re-acquired inbetween. Verify that no one else took or is in the
+ * process of taking @p from @dsq.
+ *
+ * On %false return, the caller can assume full ownership of @p.
+ */
+static bool nldsq_cursor_lost_task(struct scx_dsq_list_node *cursor,
+				   struct rq *rq, struct scx_dispatch_q *dsq,
+				   struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+	lockdep_assert_held(&dsq->lock);
+
+	/*
+	 * @p could have already left $src_dsq, got re-enqueud, or be in the
+	 * process of being consumed by someone else.
+	 */
+	if (unlikely(p->scx.dsq != dsq ||
+		     u32_before(cursor->priv, p->scx.dsq_seq) ||
+		     p->scx.holding_cpu >= 0))
+		return true;
+
+	/* if @p has stayed on @dsq, its rq couldn't have changed */
+	if (WARN_ON_ONCE(rq != task_rq(p)))
+		return true;
+
+	return false;
+}
 
 /*
  * BPF DSQ iterator. Tasks in a non-local DSQ can be iterated in [reverse]
@@ -619,19 +711,6 @@ static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
  * changes without breaking backward compatibility. Can be used with
  * bpf_for_each(). See bpf_iter_scx_dsq_*().
  */
-enum scx_dsq_iter_flags {
-	/* iterate in the reverse dispatch order */
-	SCX_DSQ_ITER_REV		= 1U << 16,
-
-	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
-	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
-
-	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
-	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
-					  __SCX_DSQ_ITER_HAS_SLICE |
-					  __SCX_DSQ_ITER_HAS_VTIME,
-};
-
 struct bpf_iter_scx_dsq_kern {
 	struct scx_dsq_list_node	cursor;
 	struct scx_dispatch_q		*dsq;
@@ -4498,7 +4577,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 	struct rq *donor_rq = cpu_rq(donor);
 	struct scx_dispatch_q *donor_dsq = bypass_dsq(sch, donor);
 	struct task_struct *p, *n;
-	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, 0, 0);
+	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, donor_dsq, 0);
 	s32 delta = READ_ONCE(donor_dsq->nr) - nr_donor_target;
 	u32 nr_balanced = 0, min_delta_us;
 
@@ -7540,14 +7619,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	locked_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
 
-	/*
-	 * Did someone else get to it? @p could have already left $src_dsq, got
-	 * re-enqueud, or be in the process of being consumed by someone else.
-	 */
-	if (unlikely(p->scx.dsq != src_dsq ||
-		     u32_before(kit->cursor.priv, p->scx.dsq_seq) ||
-		     p->scx.holding_cpu >= 0) ||
-	    WARN_ON_ONCE(src_rq != task_rq(p))) {
+	/* did someone else get to it while we dropped the locks? */
+	if (nldsq_cursor_lost_task(&kit->cursor, src_rq, src_dsq, p)) {
 		raw_spin_unlock(&src_dsq->lock);
 		goto out;
 	}
@@ -8186,8 +8259,7 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	if (!kit->dsq)
 		return -ENOENT;
 
-	kit->cursor = INIT_DSQ_LIST_CURSOR(kit->cursor, flags,
-					   READ_ONCE(kit->dsq->seq));
+	kit->cursor = INIT_DSQ_LIST_CURSOR(kit->cursor, kit->dsq, flags);
 
 	return 0;
 }
@@ -8201,41 +8273,13 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
-	bool rev = kit->cursor.flags & SCX_DSQ_ITER_REV;
-	struct task_struct *p;
-	unsigned long flags;
 
 	if (!kit->dsq)
 		return NULL;
 
-	raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
-	if (list_empty(&kit->cursor.node))
-		p = NULL;
-	else
-		p = container_of(&kit->cursor, struct task_struct, scx.dsq_list);
-
-	/*
-	 * Only tasks which were queued before the iteration started are
-	 * visible. This bounds BPF iterations and guarantees that vtime never
-	 * jumps in the other direction while iterating.
-	 */
-	do {
-		p = nldsq_next_task(kit->dsq, p, rev);
-	} while (p && unlikely(u32_before(kit->cursor.priv, p->scx.dsq_seq)));
-
-	if (p) {
-		if (rev)
-			list_move_tail(&kit->cursor.node, &p->scx.dsq_list.node);
-		else
-			list_move(&kit->cursor.node, &p->scx.dsq_list.node);
-	} else {
-		list_del_init(&kit->cursor.node);
-	}
-
-	raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
-
-	return p;
+	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
 }
 
 /**
-- 
2.53.0

