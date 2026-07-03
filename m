Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3E388880;
	Fri,  3 Jul 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065746; cv=none; b=VbqNW7PTBJKclOCOAUx7QDMiPF3KRVjFZrGm9dojJhvr/eTf0BYUdwT/5D2YPVKz13c/5vu5aZ5+o7RwJvTyfQZhGIS7UKxrpNHglPeSzkysAnI7xgE/DHUE6wC1ta8WrQQWhGw8/jLC7tZ6qOjMsN0inh84ZL67m40okHm17j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065746; c=relaxed/simple;
	bh=xYsk721bnktj89JDlWgAj9cOtvh4p3apdOtfZRRxk4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1nYSeopFu6Eado4JmkHJanp4CMvmsn4ljDbaIpl3sEhFh/iIOkaD1vZluYxiYj414pqM/bnRT04QujYXl8k2zzbO5vY1JV8GUGhEInoJ6rl1W6wFsRxzqPNqh0stgQcCpmY1WZLoMPs2rYHkaL3dlzl3E9BNn7cAmWlgnFUpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDDj4tRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDDj4tRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F4C1F000E9;
	Fri,  3 Jul 2026 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065744;
	bh=bmjzeaQ7/mIB1NlagZm2u1FiQExNjHfgyEplgsGBKvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDDj4tROVZOixwGVn/I85FkAAir4S+BifRMFmVwJMfOX5c5G1Gef3LOuZIyTe03M8
	 MJZwXP6JVv22peNp6jMRIrqpvU4Z4cA+mCBybUFMARMOt4odBITgZdn/me0cSYrw05
	 To72TEP176cdz0PyKKrpUGcaaLL8A1gfHhIIzasNAB23WRToWLBbGgsNbmMCC5VZ6a
	 xIfr/ePp1qlFzM84a1ChyF5W5WGvZvv4BaxAW+UdMfWMdnzbIDuqK/kSTzCWwCR51R
	 tMxU9iIRnb7TP3UznN7BEB2vMqgVcwFJueZLxNaxJgJvNi4AuCBOs3XvJLGeGaF9oS
	 O+H17sVMggwuA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 24/32] sched_ext: Route task slice writes through set_task_slice()
Date: Thu,  2 Jul 2026 22:01:51 -1000
Message-ID: <20260703080159.2314350-25-tj@kernel.org>
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

A later change makes every write to p->scx.slice also drop a pending
out-of-band slice request, which needs all such writes to go through one
place. Introduce set_task_slice() and route the existing direct writes
through it. No functional change - the helper only assigns p->scx.slice.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7d4fd4e9d5a4..95ad8f37cc92 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1158,6 +1158,12 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/* set @p's slice, every write to p->scx.slice goes through here */
+static void set_task_slice(struct task_struct *p, u64 slice)
+{
+	p->scx.slice = slice;
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
@@ -1243,7 +1249,7 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(sch->slice_dfl);
+	set_task_slice(p, READ_ONCE(sch->slice_dfl));
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -1338,7 +1344,7 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+		set_task_slice(rq->curr, 0);
 		resched_curr(rq);
 	}
 }
@@ -2044,7 +2050,7 @@ static void yield_task_scx(struct rq *rq)
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
 	else
-		p->scx.slice = 0;
+		set_task_slice(p, 0);
 }
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
@@ -3278,7 +3284,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		curr->scx.slice = 0;
+		set_task_slice(curr, 0);
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
@@ -3417,7 +3423,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	 * control, after ops.disable() has observed their final values.
 	 */
 	p->scx.dsq_vtime = 0;
-	p->scx.slice = 0;
+	set_task_slice(p, 0);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -7038,7 +7044,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -7676,7 +7682,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				set_task_slice(rq->curr, 0);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -8026,9 +8032,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 
@@ -8052,9 +8058,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	p->scx.dsq_vtime = vtime;
 
@@ -8238,7 +8244,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		p->scx.slice = kit->slice;
+		set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -8633,7 +8639,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	p->scx.slice = slice;
+	set_task_slice(p, slice);
 	return true;
 }
 
-- 
2.54.0

