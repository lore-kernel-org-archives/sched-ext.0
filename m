Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E138B124;
	Mon,  6 Jul 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302089; cv=none; b=hutC7B0h2/IfjWPk/kBsWm3uTGkFlSe67d5SgGzVdQsc0NP7A9aNsc7o5n6DjtRr2L4gMU+CErwOWrjSFXqCLUp/yHqOCn0q4bJlv/zDmdvashXk/9HYLHMe/Zd2d0rTqlKFWRGC77SRW4+DX3rAS2KEVpjwGv4dyQQHzNuamzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302089; c=relaxed/simple;
	bh=ttHsFXkvQtPKTXE5mcSG8v9tKYtarS9f+sSZKz4XIb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItlO9Va9v7ByNU/+dTMhrZzftXzvHpVVSvJNvusSf4oMYfy+0q07NTWKKZTvaGpORNqsV30AODT55WCplY1Ay0onY1CDcv+kt8BimNnJnXmWS7plDUPIy8FTk93VKzYamGpA16MN/hz7KK7B3/mmSec/BnEVo9GrSw0ofpJflys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a80gvZWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a80gvZWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED661F00A3E;
	Mon,  6 Jul 2026 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302087;
	bh=tTmtipCxbpmNKfrqMR8WnYSLvMgys6w8nZNbv1FBB+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a80gvZWhmr47xEqK3rUdZpAT79Fbo3S27pml33BNJ5Qi6LRFaMJSCUVXNtELSaZbu
	 pLR1sUsjnjKQGB+4QuNSglswMBmT3+9ZUX2Rz6U5s3aMou0w6bjibd5pqUAwKFkTLg
	 PBCTezkZhZmYdUC87j52QtxOxprFQCfVsmIkM0FUJnveC7U3Ej/xTQ/+jIUuvzkSku
	 +kdnA1NmoXnDuquMCf/q+f6dyDm86HCUxXJtVfY+5vKk7OfLvAZuDd0oWrlxSE34KS
	 E4chjzHz/fPJC0zc5whrZUnm3cEkbjxiYHpBd25Znr0ntr88Lr0+br8k41Rc+dEqKD
	 9GWawxKYag0KQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 27/36] sched_ext: Route task slice writes through set_task_slice()
Date: Sun,  5 Jul 2026 15:40:49 -1000
Message-ID: <20260706014058.439853-28-tj@kernel.org>
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

A later change makes every write to p->scx.slice also drop a pending
out-of-band slice request, which needs all such writes to go through one
place. Introduce set_task_slice() and route the existing direct writes
through it. No functional change - the helper only assigns p->scx.slice.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9fa4cfbc75c8..ff997ba881b0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1153,6 +1153,12 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
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
@@ -1238,7 +1244,7 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(sch->slice_dfl);
+	set_task_slice(p, READ_ONCE(sch->slice_dfl));
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -1333,7 +1339,7 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+		set_task_slice(rq->curr, 0);
 		resched_curr(rq);
 	}
 }
@@ -2039,7 +2045,7 @@ static void yield_task_scx(struct rq *rq)
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
 	else
-		p->scx.slice = 0;
+		set_task_slice(p, 0);
 }
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
@@ -3273,7 +3279,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		curr->scx.slice = 0;
+		set_task_slice(curr, 0);
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
@@ -3412,7 +3418,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	 * control, after ops.disable() has observed their final values.
 	 */
 	p->scx.dsq_vtime = 0;
-	p->scx.slice = 0;
+	set_task_slice(p, 0);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -7033,7 +7039,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -7671,7 +7677,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				set_task_slice(rq->curr, 0);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -8021,9 +8027,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 
@@ -8047,9 +8053,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	p->scx.dsq_vtime = vtime;
 
@@ -8233,7 +8239,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		p->scx.slice = kit->slice;
+		set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -8628,7 +8634,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	p->scx.slice = slice;
+	set_task_slice(p, slice);
 	return true;
 }
 
-- 
2.54.0

