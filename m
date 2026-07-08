Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF909402B8A;
	Wed,  8 Jul 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545904; cv=none; b=DnxVs1pLe4LTmhDnT6MzzMVK44zicirbaM2BLeAp4lGj0iYzdOOHae20hS7WhA4MkuisbJKALVGQP1EQ3Ajgzz+3c8U9PLCtwRwGuExbIBNEyt135EzShMXK4OQTPE4PMvYlss7EA0cD724Px0FaZBl1kZ9QVTDd4V9sf8dNqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545904; c=relaxed/simple;
	bh=PasJ2IaHCFMCuMWk3XqrjzD7Jzuh0Y//VMV4KVkd4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGZptbfByDGTkbSzFHxjWLYfxnCvuFmicgRSOk0DEQzbYe7zWW5Jj9foIaJPPP2oS6fMRXfpHYVC0fojS07YiFBDmwiO5UQJNKdTty0NIdNLUKs8PCl+2X2c4/IdvJ7ShwBioBSBwmSCwy35QzcY3CAvVogcwX+uSyYWWFOJYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwbDcfu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwbDcfu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A41F000E9;
	Wed,  8 Jul 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545902;
	bh=ZHR5HtJKxwzK9vXztW7diWj+vj3+eGN5AdkMgigKhSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwbDcfu+kTPHQ1QhE3wu7T8je5+pPis331ebSS6c2u1NyPxKhW5iz7ZcSB8OHM2sl
	 N0j6YbhgejHix+GCnMDBqq+h6k24Qdlde3mcDkXtOUuKp6YZeom5qx25K+1zbmcET5
	 7bCi4OV3VHqc6bLRNvNCKThIckdWHozp6PAxiZ76Fp2gFqEsAlEfmN0Tt+Vw9pOkwE
	 mfX9aL5ExzoKgVmxU5SX7DxNAqJxhXedc8umBmbNu/mRi3moEgidNd9D8IDgwaUxHQ
	 BNfHDwu8zSkxVxkL30WYvg27JyVZNjie9alS+iqNn2inrfryqk3/HLdVXNXak+07YG
	 G5vqvKP67/C6g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 29/40] sched_ext: Route task slice writes through set_task_slice()
Date: Wed,  8 Jul 2026 11:24:18 -1000
Message-ID: <20260708212429.3405787-30-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later change makes set_task_slice() also drop a pending out-of-band slice
request, so the BPF-triggered writes to p->scx.slice need to funnel through
one place. Introduce set_task_slice() and route those writes through it.
update_curr_scx() decrements curr->scx.slice directly for accounting and is
left alone. No functional change - the helper only assigns p->scx.slice.

v2: Reword the set_task_slice comment to "BPF-triggered writes". (Andrea)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 96e5e4a6a695..ef0bc5c521d2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1153,6 +1153,12 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 #endif
 }
 
+/* set @p's slice, BPF-triggered writes to p->scx.slice go through here */
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
@@ -7051,7 +7057,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -7694,7 +7700,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				set_task_slice(rq->curr, 0);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -8044,9 +8050,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 
@@ -8070,9 +8076,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	p->scx.dsq_vtime = vtime;
 
@@ -8256,7 +8262,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		p->scx.slice = kit->slice;
+		set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -8651,7 +8657,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	p->scx.slice = slice;
+	set_task_slice(p, slice);
 	return true;
 }
 
-- 
2.54.0

