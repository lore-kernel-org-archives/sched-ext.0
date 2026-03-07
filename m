Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929C27E06C;
	Sat,  7 Mar 2026 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843301; cv=none; b=UPOIOlU4hBmbgHa/+vidy49CanoBuc1RPC8B01Tvg/MEHo7priu2JXjfK7JtgCgNA65THn9gtXP3uUSGdtfLutUxIk/wn9UWcVvb/7DPwdUyV2g77FHwSpZtx2LoQM4ZqI4sJjh3WB3L+ISFvigqM46nEUFKiAmGw4tbzVC9O7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843301; c=relaxed/simple;
	bh=XCMFfmfi0Yx8VftwAhI5cvh5VwZxLfB4OsJ3lRJvJs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEIvekMPJg4lyUbj5uGxai2Ckqi6i8vinGDYWbAsHLGkhFPOZwtyMH4LOtoFZoOKa0Yqug/DMkvBRyNXZYy6Syg7xSMXSpzPzAAHHnk+kCDha7gfExVyX+6kpPNjQZf4KvGm/jipRmJu3RvGlmvcOP2EdivFTpMAKAPukd3+GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/+0Hwmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/+0Hwmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C3C4CEF7;
	Sat,  7 Mar 2026 00:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843301;
	bh=XCMFfmfi0Yx8VftwAhI5cvh5VwZxLfB4OsJ3lRJvJs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/+0Hwmnk35kqh95c8nqBk+NoWGmkuYYlGGwgGFQ36WEa9ydNyA1jw+DcvvYGSxb8
	 0laanld28UR0B3Ik50c619mq4AvtKl+XqCs9OOro/IIGrCwb2jwFHM2URA1EMq0kop
	 iNp6r4SPodvMlMvuB4QjslG4tvU0Kqe3tCZIj/UASU9ADT9z32QczSlloRkFpbEJse
	 pXLwV/w/953sd203wx2Iw4BlT3DW/171Z3mgMb3dZF3gpiYgbwXaHSBNn2BiPBhDxL
	 GbjEdATQFJBomAQO0qXoUiPJ80D0oJjDRu86U4XHBHD8IljD+hw3u6dhQmRzqEEtYO
	 yNoEMPEWWqumQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Implement SCX_ENQ_IMMED
Date: Fri,  6 Mar 2026 14:28:16 -1000
Message-ID: <20260307002817.1298341-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307002817.1298341-1-tj@kernel.org>
References: <20260307002817.1298341-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SCX_ENQ_IMMED enqueue flag for inserting into local DSQs. It requests
that the task be queued on the CPU's local DSQ only if it can execute
immediately - the current task is done and no other tasks are waiting. If the
CPU is busy, the task is re-enqueued back to the BPF scheduler with
SCX_TASK_REENQ_IMMED so that it can be dispatched elsewhere. When multiple
IMMED tasks are inserted, only the first one stays if the current task is
done and the rest are re-enqueued.

One intended use case is enabling opportunistic CPU sharing across multiple
sub-schedulers. Without this, a sub-scheduler can stuff the local DSQ of a
shared CPU, making it difficult for others to use. More generally, multiple
tasks on a local DSQ can cause high latencies, and stricter control can help.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |   3 +
 kernel/sched/ext.c          | 186 ++++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h |  36 +++++++
 kernel/sched/sched.h        |   2 +
 4 files changed, 211 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 60a4f65d0174..f1c14b950f23 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -125,6 +125,7 @@ enum scx_ent_flags {
 	 *
 	 * NONE		not being reenqueued
 	 * KFUNC	reenqueued by scx_bpf_dsq_reenq() and friends
+	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 2,
@@ -132,6 +133,7 @@ enum scx_ent_flags {
 
 	SCX_TASK_REENQ_NONE	= 0 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_KFUNC	= 1 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
@@ -140,6 +142,7 @@ enum scx_ent_flags {
 /* scx_entity.dsq_flags */
 enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+	SCX_TASK_DSQ_IMMED	= 1 << 1, /* task is queued with %SCX_ENQ_IMMED */
 };
 
 /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8c42405e27fd..eae8fc3e7b8a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -404,6 +404,38 @@ static bool bypass_dsp_enabled(struct scx_sched *sch)
 	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
 }
 
+/**
+ * is_curr_done - Is the current task of a runqueue done with the CPU?
+ * @rq: rq to test
+ */
+static bool is_curr_done(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+
+	lockdep_assert_rq_held(rq);
+
+	/* if idle, yes */
+	if (is_idle_task(curr))
+		return true;
+
+	/*
+	 * If we're in the dispatch path holding rq lock, $curr, whether in
+	 * sched_ext or a higher-priority class, is ready to give up the CPU.
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		return true;
+
+	/*
+	 * If $curr is an SCX task, 0 slice indicates that a scheduling event is
+	 * imminent. This allows e.g. %SCX_ENQ_PREEMPT and %SCX_ENQ_IMMED to
+	 * see @rq as open as soon as it clears the current task's slice.
+	 */
+	if (curr->sched_class == &ext_sched_class && !curr->scx.slice)
+		return true;
+
+	return false;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1218,6 +1250,16 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	}
 }
 
+static void schedule_root_reenq(struct rq *rq, u64 reenq_flags)
+{
+	struct scx_sched *root = rcu_dereference_sched(scx_root);
+
+	if (WARN_ON_ONCE(!root))
+		return;
+
+	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags);
+}
+
 /**
  * touch_core_sched - Update timestamp used for core-sched task ordering
  * @rq: rq to read clock from, must be locked
@@ -1294,14 +1336,53 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
 }
 
-static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
+static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 enq_flags)
 {
 	/*
 	 * scx_bpf_dsq_nr_queued() reads ->nr without locking. Use READ_ONCE()
 	 * on the read side and WRITE_ONCE() on the write side to properly
 	 * annotate the concurrent lockless access and avoid KCSAN warnings.
 	 */
-	WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) + delta);
+	WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) + 1);
+
+	if (enq_flags & SCX_ENQ_IMMED) {
+		struct rq *rq;
+
+		if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
+			WARN_ON_ONCE(!(enq_flags & SCX_ENQ_GDSQ_FALLBACK));
+			return;
+		}
+		rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		p->scx.dsq_flags |= SCX_TASK_DSQ_IMMED;
+		rq->scx.nr_immed++;
+
+		/*
+		 * If @rq already had other tasks or the current task is not
+		 * done yet, @p can't go on the CPU immediately. Re-enqueue.
+		 */
+		if (unlikely(dsq->nr > 1 || !is_curr_done(rq)))
+			schedule_root_reenq(rq, 0);
+	}
+}
+
+static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
+{
+	/* see dsq_inc_nr() */
+	WRITE_ONCE(dsq->nr, READ_ONCE(dsq->nr) - 1);
+
+	if (p->scx.dsq_flags & SCX_TASK_DSQ_IMMED) {
+		struct rq *rq;
+
+		p->scx.dsq_flags &= ~SCX_TASK_DSQ_IMMED;
+
+		if (WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
+			return;
+		rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		WARN_ON_ONCE(rq->scx.nr_immed == 0);
+		rq->scx.nr_immed--;
+	}
 }
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
@@ -1460,7 +1541,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	WRITE_ONCE(dsq->seq, dsq->seq + 1);
 	p->scx.dsq_seq = dsq->seq;
 
-	dsq_mod_nr(dsq, 1);
+	dsq_inc_nr(dsq, p, enq_flags);
 	p->scx.dsq = dsq;
 
 	/*
@@ -1514,7 +1595,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	}
 
 	list_del_init(&p->scx.dsq_list.node);
-	dsq_mod_nr(dsq, -1);
+	dsq_dec_nr(dsq, p);
 
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
@@ -2052,7 +2133,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
 
-	dsq_mod_nr(dst_dsq, 1);
+	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
 	local_dsq_post_enq(dst_dsq, p, enq_flags);
@@ -2260,6 +2341,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
+			enq_flags |= SCX_ENQ_GDSQ_FALLBACK;
 		}
 	} else {
 		/* no need to migrate if destination is a non-local DSQ */
@@ -2388,7 +2470,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
 		return;
 	}
 
@@ -2741,6 +2823,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	return false;
 
 has_tasks:
+	/*
+	 * @rq may still have an IMMED task without reenq scheduled if e.g. a
+	 * non-IMMED HEAD task gets queued in front of an IMMED task between the
+	 * IMMED queueing and the subsequent scheduling event.
+	 */
+	if (unlikely(rq->scx.nr_immed))
+		schedule_root_reenq(rq, 0);
+
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
 	return true;
 }
@@ -3729,12 +3819,25 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
-static bool task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
+static bool task_should_reenq(struct task_struct *p, u64 *reenq_flags, u32 *reason)
 {
+	bool first;
+
+	first = !(*reenq_flags & SCX_REENQ_TSR_NOT_FIRST);
+	*reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
+
 	*reason = SCX_TASK_REENQ_KFUNC;
 
-	if (reenq_flags & SCX_REENQ_ANY)
+	if ((p->scx.dsq_flags & SCX_TASK_DSQ_IMMED) &&
+	    (!first || !(*reenq_flags & SCX_REENQ_TSR_CURR_DONE))) {
+		__scx_add_event(scx_task_sched(p), SCX_EV_REENQ_IMMED, 1);
+		*reason = SCX_TASK_REENQ_IMMED;
+		return true;
+	}
+
+	if (*reenq_flags & SCX_REENQ_ANY)
 		return true;
+
 	return false;
 }
 
@@ -3746,6 +3849,11 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 	lockdep_assert_rq_held(rq);
 
+	if (WARN_ON_ONCE(reenq_flags & __SCX_REENQ_TSR_MASK))
+		reenq_flags &= ~__SCX_REENQ_TSR_MASK;
+	if (is_curr_done(rq))
+		reenq_flags |= SCX_REENQ_TSR_CURR_DONE;
+
 	/*
 	 * The BPF scheduler may choose to dispatch tasks back to
 	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
@@ -3773,7 +3881,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!scx_is_descendant(task_sch, sch))
 			continue;
 
-		if (!task_should_reenq(p, reenq_flags, &reason))
+		if (!task_should_reenq(p, &reenq_flags, &reason))
 			continue;
 
 		dispatch_dequeue(rq, p);
@@ -3799,11 +3907,14 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 static void process_deferred_reenq_locals(struct rq *rq)
 {
+	u32 seq = rq->scx.deferred_reenq_locals_seq++;
+
 	lockdep_assert_rq_held(rq);
 
 	while (true) {
 		struct scx_sched *sch;
 		u64 reenq_flags;
+		bool skip = false;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_local *drl =
@@ -3818,15 +3929,31 @@ static void process_deferred_reenq_locals(struct rq *rq)
 			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
 						deferred_reenq_local);
 			sch = sch_pcpu->sch;
+
 			reenq_flags = drl->flags;
 			WRITE_ONCE(drl->flags, 0);
 			list_del_init(&drl->node);
+
+			if (likely(drl->seq != seq)) {
+				drl->seq = seq;
+				drl->cnt = 0;
+			} else {
+				if (unlikely(++drl->cnt > SCX_REENQ_LOCAL_MAX_REPEAT)) {
+					scx_error(sch, "SCX_ENQ_REENQ on SCX_DSQ_LOCAL repeated %u times",
+						  drl->cnt);
+					skip = true;
+				}
+
+				__scx_add_event(sch, SCX_EV_REENQ_LOCAL_REPEAT, 1);
+			}
 		}
 
-		/* see schedule_dsq_reenq() */
-		smp_mb();
+		if (!skip) {
+			/* see schedule_dsq_reenq() */
+			smp_mb();
 
-		reenq_local(sch, rq, reenq_flags);
+			reenq_local(sch, rq, reenq_flags);
+		}
 	}
 }
 
@@ -3840,6 +3967,9 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 
 	lockdep_assert_rq_held(rq);
 
+	if (WARN_ON_ONCE(reenq_flags & __SCX_REENQ_TSR_MASK))
+		reenq_flags &= ~__SCX_REENQ_TSR_MASK;
+
 	raw_spin_lock(&dsq->lock);
 
 	while (likely(!READ_ONCE(sch->bypass_depth))) {
@@ -3850,7 +3980,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		if (!p)
 			break;
 
-		if (!task_should_reenq(p, reenq_flags, &reason))
+		if (!task_should_reenq(p, &reenq_flags, &reason))
 			continue;
 
 		task_rq = task_rq(p);
@@ -4581,6 +4711,8 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_IMMED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_LOCAL_REPEAT);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_REFILL_SLICE_DFL);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
@@ -5987,6 +6119,8 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	scx_dump_event(s, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_EXITING);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+	scx_dump_event(s, &events, SCX_EV_REENQ_IMMED);
+	scx_dump_event(s, &events, SCX_EV_REENQ_LOCAL_REPEAT);
 	scx_dump_event(s, &events, SCX_EV_REFILL_SLICE_DFL);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
@@ -7499,8 +7633,20 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
+static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 enq_flags)
+{
+	if ((enq_flags & SCX_ENQ_IMMED) &&
+	    unlikely(dsq_id != SCX_DSQ_LOCAL &&
+		     (dsq_id & SCX_DSQ_LOCAL_ON) != SCX_DSQ_LOCAL_ON)) {
+		scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
+		return false;
+	}
+
+	return true;
+}
+
 static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
-				    u64 enq_flags)
+				    u64 dsq_id, u64 enq_flags)
 {
 	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
@@ -7523,6 +7669,9 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
+	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+		return false;
+
 	return true;
 }
 
@@ -7604,7 +7753,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return false;
 
-	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
 		return false;
 
 	if (slice)
@@ -7630,7 +7779,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
 		return false;
 
 	if (slice)
@@ -7757,6 +7906,9 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+		return false;
+
 	/*
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as consume_dispatch_q().
@@ -9070,6 +9222,8 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
 		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_EXITING);
 		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+		scx_agg_event(events, e_cpu, SCX_EV_REENQ_IMMED);
+		scx_agg_event(events, e_cpu, SCX_EV_REENQ_LOCAL_REPEAT);
 		scx_agg_event(events, e_cpu, SCX_EV_REFILL_SLICE_DFL);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index f8df73044515..cd4272117be4 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -31,6 +31,8 @@ enum scx_consts {
 	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
 	SCX_BYPASS_LB_BATCH		= 256,
 
+	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
+
 	SCX_SUB_MAX_DEPTH		= 4,
 };
 
@@ -893,6 +895,24 @@ struct scx_event_stats {
 	 */
 	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
 
+	/*
+	 * The number of times a task, enqueued on a local DSQ with
+	 * SCX_ENQ_IMMED, was re-enqueued because the CPU was not available for
+	 * immediate execution.
+	 */
+	s64		SCX_EV_REENQ_IMMED;
+
+	/*
+	 * The number of times a reenq of local DSQ caused another reenq of
+	 * local DSQ. This can happen when %SCX_ENQ_IMMED races against a higher
+	 * priority class task even if the BPF scheduler always satisfies the
+	 * prerequisites for %SCX_ENQ_IMMED at the time of enqueue. However,
+	 * that scenario is very unlikely and this count going up regularly
+	 * indicates that the BPF scheduler is handling %SCX_ENQ_REENQ
+	 * incorrectly causing recursive reenqueues.
+	 */
+	s64		SCX_EV_REENQ_LOCAL_REPEAT;
+
 	/*
 	 * Total number of times a task's time slice was refilled with the
 	 * default value (SCX_SLICE_DFL).
@@ -957,6 +977,8 @@ struct scx_dsp_ctx {
 struct scx_deferred_reenq_local {
 	struct list_head	node;
 	u64			flags;
+	u64			seq;
+	u32			cnt;
 };
 
 struct scx_sched_pcpu {
@@ -1079,6 +1101,13 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * Only allowed on local DSQs. Enqueue succeeds iff the task can go on
+	 * the CPU immediately. Otherwise, the task is re-enqueued with
+	 * %SCX_TASK_REENQ_IMMED.
+	 */
+	SCX_ENQ_IMMED		= 1LLU << 33,
+
 	/*
 	 * The task being enqueued was previously enqueued on a DSQ, but was
 	 * removed and is being re-enqueued. See SCX_TASK_REENQ_* flags to find
@@ -1103,6 +1132,7 @@ enum scx_enq_flags {
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
 	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 	SCX_ENQ_NESTED		= 1LLU << 58,
+	SCX_ENQ_GDSQ_FALLBACK	= 1LLU << 59,	/* fell back to global DSQ */
 };
 
 enum scx_deq_flags {
@@ -1132,6 +1162,12 @@ enum scx_reenq_flags {
 	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
 
 	__SCX_REENQ_USER_MASK	= SCX_REENQ_ANY,
+
+	/* bits 32-35 used by task_should_reenq() */
+	SCX_REENQ_TSR_CURR_DONE	= 1LLU << 32,
+	SCX_REENQ_TSR_NOT_FIRST	= 1LLU << 33,
+
+	__SCX_REENQ_TSR_MASK	= 0xfLLU << 32,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 893f89ce2a77..4998211b5c35 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -799,6 +799,7 @@ struct scx_rq {
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
 	u32			flags;
+	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
@@ -809,6 +810,7 @@ struct scx_rq {
 	struct task_struct	*sub_dispatch_prev;
 
 	raw_spinlock_t		deferred_reenq_lock;
+	u64			deferred_reenq_locals_seq;
 	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
 	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
 	struct balance_callback	deferred_bal_cb;
-- 
2.53.0

