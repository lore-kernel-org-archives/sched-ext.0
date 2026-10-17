Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F36346FB3;
	Sat, 17 Oct 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280111; cv=none; b=LVYuC9tqmewauD3z36w1RWpL5X000NQYeOvnMe2PCccQ37hlLPQ1oSfQ9rbeuQS2xlv253fzXnfM2+xU+aFjO32in5Fp207eav2otJNoxe1qMXUnUg63tcgUqbtAGiHysgjON9DdX5a3YFeH8sH13M/Fdd8WYEK0eVk22VOcidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280111; c=relaxed/simple;
	bh=d/tdwr1b3hkTLiYKxIeAnt+rAerCENL7AhlcMr594Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFSzelAcujpVHawgKTNiZUcL2Mwp09KbMSK8NHdWAsohq91Ht9D5Hp754lJbevSVCchkKtdKwCBV/uxIwpOPbkPl4Di4sZj4Dcc0JJGyQeqPj8p1XbMSqWbNzMVvrUGdpIu123CslpHzVigTMnb9Ygpg0IsroUi5Jjb9CeiInpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvnMn0rB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvnMn0rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF341F000C4;
	Sat, 17 Oct 2026 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280109;
	bh=rFwF76BPBvhcNrioCQSFYbb8UtAgwgzWLpK+kaVpSqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvnMn0rBS9HA90YSeC0fLnpw+XK0uqZQ6W9ReoIrEt3GBmocFuucKJ03qFcUSay+V
	 XUWj4lttsi5wBK5zjeoEeTR7yeayWedJh12GqF1osHMS9BQwV0v+VIP5nQyl540euM
	 78a3WDwca/Bo1VkjuopkFkZETPz0/eCjUtR11mwxAfm5zMwbLMn5FXDMRfdH7AnE05
	 N+3C7k409U5RvUt55Dd3W9sfkpUl4dLLXmKgaalupjE1O+BuSqKrpOVGSHS52i/qs9
	 oMel+TUDlGqXGq4fuh4AyONieXh9NKV83GBi1Rx9I2Kh9H1/vCv1pXRYZ1WJOf6a6k
	 0z5Z/roxeUAng==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 2/3] sched_ext: Add scx_bpf_dsq_reenq_task() to re-enqueue single tasks from a DSQ iteration
Date: Sat, 17 Oct 2026 13:35:08 -1000
Message-ID: <20261017233508.1276329-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017223738.993262-3-tj@kernel.org>
References: <20261017223738.993262-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_reenq() re-enqueues a whole DSQ, but a scheduler that loses the
cpus serving a DSQ, such as a sub-scheduler after a cap revoke, needs only
the stranded tasks placed again.

Add scx_bpf_dsq_reenq_task(), which marks a task from a DSQ iteration. When
the iteration ends, the DSQ's deferred re-enqueue walk is scheduled once and
re-enqueues only the marked tasks. The kfunc locks the task's rq and the DSQ
like scx_bpf_dsq_move() and is callable from the same contexts. The mark is
cleared when the task leaves the DSQ, so a task consumed before the walk is
not re-enqueued.

An iteration's DSQ can be destroyed before the iteration ends, so
schedule_dsq_reenq() now skips a destroyed DSQ instead of aborting the
scheduler. scx_bpf_dsq_reenq() racing scx_bpf_destroy_dsq() takes the same
path.

Declare the kfunc for the tools and add a compat probe.

v2: Note in the kerneldoc that another iteration's re-enqueue may take a
marked task early, and that a task on another scheduler returns false
(Andrea).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext/ext.c                   | 82 +++++++++++++++++++++++-
 kernel/sched/ext/internal.h              |  2 +
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  6 ++
 5 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index ae696d11dac9..efd635a99309 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -157,6 +157,7 @@ enum scx_ent_flags {
 /* scx_entity.dsq_flags */
 enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+	SCX_TASK_DSQ_REENQ	= 1 << 1, /* marked by scx_bpf_dsq_reenq_task() */
 };
 
 enum scx_dsq_lnode_flags {
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3e707b00e78b..14fe63428036 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -555,11 +555,13 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_HAS_REENQ	= 1U << 29,
 	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
 	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
 
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
 	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_HAS_REENQ |
 					  __SCX_DSQ_ITER_HAS_SLICE |
 					  __SCX_DSQ_ITER_HAS_VTIME,
 };
@@ -1292,7 +1294,9 @@ void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
 		}
 	} else {
-		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
+		/* destroyed since the caller resolved it, nothing to reenq */
+		if (READ_ONCE(dsq->id) != SCX_DSQ_INVALID)
+			scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
 		return;
 	}
 
@@ -1918,6 +1922,7 @@ void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq)
 		RB_CLEAR_NODE(&p->scx.dsq_priq);
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
+	p->scx.dsq_flags &= ~SCX_TASK_DSQ_REENQ;
 
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_dec_nr(dsq, p);
@@ -5095,7 +5100,9 @@ static void process_deferred_reenq_locals(struct rq *rq)
 static bool user_task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
 {
 	*reason = SCX_TASK_REENQ_KFUNC;
-	return reenq_flags & SCX_REENQ_ANY;
+	if (reenq_flags & SCX_REENQ_ANY)
+		return true;
+	return (reenq_flags & SCX_REENQ_MARKED) && (p->scx.dsq_flags & SCX_TASK_DSQ_REENQ);
 }
 
 static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flags)
@@ -10087,6 +10094,8 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+/* also in scx_kfunc_ids_unlocked, same contexts as scx_bpf_dsq_move() */
+BTF_ID_FLAGS(func, scx_bpf_dsq_reenq_task, KF_RCU)
 #ifdef CONFIG_EXT_SUB_SCHED
 BTF_ID_FLAGS(func, scx_bpf_sub_dispatch, KF_IMPLICIT_ARGS)
 #endif
@@ -10202,6 +10211,7 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_reenq_task, KF_RCU)
 /* also in scx_kfunc_ids_select_cpu: also callable from ops.select_cpu()/ops.enqueue() */
 BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
@@ -10610,7 +10620,8 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
  * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
  * @it: iterator to destroy
  *
- * Undo bpf_iter_scx_dsq_new().
+ * Undo bpf_iter_scx_dsq_new(). If the iteration marked tasks with
+ * scx_bpf_dsq_reenq_task(), schedule their re-enqueue.
  */
 __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 {
@@ -10626,6 +10637,13 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 		list_del_init(&kit->cursor.node);
 		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
 	}
+
+	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_REENQ) {
+		guard(preempt)();
+		schedule_dsq_reenq(kit->dsq->sched, kit->dsq, SCX_REENQ_MARKED,
+				   scx_locked_rq());
+	}
+
 	kit->dsq = NULL;
 }
 
@@ -10714,6 +10732,64 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 	schedule_dsq_reenq(sch, dsq, reenq_flags, locked_rq);
 }
 
+/**
+ * scx_bpf_dsq_reenq_task - Re-enqueue a task from a DSQ iteration
+ * @it__iter: DSQ iterator in progress
+ * @p: task to re-enqueue
+ *
+ * Mark @p, which is on the DSQ iterated by @it__iter and was queued before the
+ * iteration started, for re-enqueue. When the iteration ends, the DSQ's marked
+ * tasks go through ops.enqueue() with %SCX_ENQ_REENQ in DSQ order and the other
+ * tasks on the DSQ keep their positions. A marked task that leaves the DSQ in
+ * the meantime is not re-enqueued. The mark belongs to @p, so a re-enqueue
+ * scheduled by another iteration of the DSQ may re-enqueue @p before this
+ * iteration ends. @p must be on the DSQ's scheduler.
+ *
+ * Re-enqueues are performed asynchronously. Can be called from ops.dispatch()
+ * or any BPF context which doesn't hold a rq lock (e.g. BPF timers or SYSCALL
+ * programs).
+ *
+ * Return %true if @p was marked, %false if @p left the DSQ or was queued after
+ * the iteration started, @p is on another scheduler, or the iterator holds no
+ * DSQ.
+ */
+__bpf_kfunc bool scx_bpf_dsq_reenq_task(struct bpf_iter_scx_dsq *it__iter,
+					struct task_struct *p)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it__iter;
+	struct scx_dispatch_q *dsq = kit->dsq;
+	struct rq *src_rq, *entry_rq;
+	unsigned long flags;
+	bool marked = false;
+
+	/* NULL after a failed bpf_iter_scx_dsq_new(), see scx_dsq_move() */
+	if (unlikely(!dsq))
+		return false;
+
+	/* the cursor check needs @p's rq locked */
+	src_rq = task_rq(p);
+	entry_rq = kf_switch_rq_lock(src_rq, &flags);
+
+	scoped_guard (raw_spinlock, &dsq->lock) {
+		if (nldsq_cursor_lost_task(&kit->cursor, src_rq, dsq, p))
+			break;
+
+		if (unlikely(!scx_task_on_sched(dsq->sched, p))) {
+			scx_error(dsq->sched, "scx_bpf_dsq_reenq_task() on %s[%d] but the task belongs to a different scheduler",
+				  p->comm, p->pid);
+			break;
+		}
+
+		p->scx.dsq_flags |= SCX_TASK_DSQ_REENQ;
+		/* the walk is scheduled once, by bpf_iter_scx_dsq_destroy() */
+		kit->cursor.flags |= __SCX_DSQ_ITER_HAS_REENQ;
+		marked = true;
+	}
+
+	kf_restore_rq_lock(src_rq, entry_rq, flags);
+	return marked;
+}
+
 /**
  * scx_bpf_reenqueue_local___v2 - Re-enqueue tasks on a local DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b408993af794..29e69a83d876 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1946,6 +1946,8 @@ enum scx_reenq_flags {
 
 	/* internal: kernel-issued on cap revoke, not accepted from BPF */
 	SCX_REENQ_CAP_REVOKE	= 1LLU << 1,
+	/* internal: tasks marked by scx_bpf_dsq_reenq_task() */
+	SCX_REENQ_MARKED	= 1LLU << 2,
 
 	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 651bd4952647..9376d5704a47 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -75,6 +75,7 @@ struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
+bool scx_bpf_dsq_reenq_task(struct bpf_iter_scx_dsq *it, struct task_struct *p) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index c26024a6e2b1..254882bd8ce6 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -498,6 +498,12 @@ static inline bool __COMPAT_has_generic_reenq(void)
 	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
 }
 
+/* v7.4: Add scx_bpf_dsq_reenq_task(). */
+static inline bool __COMPAT_has_dsq_reenq_task(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_reenq_task);
+}
+
 /*
  * v6.19: The new void variant can be called from anywhere while the older v1
  * variant can only be called from ops.cpu_release(). The double ___ prefixes on
-- 
2.56.0

