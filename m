Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479016A395;
	Tue,  7 Jul 2026 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383178; cv=none; b=SlVrwx96jNYwc7ag6ivxX2Ai6JLd1piK2aLzlNAdrR84w3bzN2kExNRuIAn2pxnbbu/y/ILo+qODRueN5EuqjNBQ5ByRvdrFfNLh5lHnEffH0ZFVjKu5LTKK7EoxQ15jEfutsyUVBMVTLAyDNehvOslkqdoy5EePyhUSl3vXsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383178; c=relaxed/simple;
	bh=BiX8CCGCSyWgpQ8VFmUnl3ALG0y6Idl0Fr6LD/mwOI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev2qx4xjWVuzARYpCHTuq2vBPShOoxl4lnx3BdDXAS+H/KgeEAoEa02lyxcfNQD+eq5ex1A6akE5sqN1g1y88ZeAADFETTuwaRH+kD43raOw0Hh1UDY0/ZMYmNXOU0KDeYPnKqA/wsSNi2XB3iq7orwDoTpZkVdkGJ6NEOmcWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhS/j7u7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhS/j7u7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E121F00A3E;
	Tue,  7 Jul 2026 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383176;
	bh=hcWjUPLkEduo7qOPkXYypvSM/AQaG9w8QOqT6VJnezw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhS/j7u7UX3oW1Cl2DacoZiJ2MUaAdf1TR5LSAukcLh5EwATKSO9EbKRKr7ZwEy9h
	 beHpwxzCWpgnth8dBqGQKAwusfSXD9OG5FCJ7usA1h6FofkAk8kyGEzA650Mdbj4Y9
	 /1MiiRTMNw2XrLTX/oCECL/zvLv+qE8PSTRXQsoIjme95DbIXteTtOWEf3PkeEP1B2
	 L6vcBtXipgfp7ZNnpsPiOXEzLuniT2UdvaL/S2LxYvrKETDopGaV2foPsc4GBaEvgH
	 OTL2WziTQbQuI8J6gjZf/eEHzXwDYzqbbT3Uy4JHOgNzIAD0iW8FAfMwgKLmEpYvGI
	 pZJMLxZJ1s+OQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 27/36] sched_ext: Route task slice writes through set_task_slice()
Date: Mon,  6 Jul 2026 14:12:20 -1000
Message-ID: <20260707001229.1410929-28-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
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
index d6584ac030bb..dd605acf0f57 100644
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
@@ -7041,7 +7047,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -7684,7 +7690,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				set_task_slice(rq->curr, 0);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -8034,9 +8040,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 
@@ -8060,9 +8066,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	p->scx.dsq_vtime = vtime;
 
@@ -8246,7 +8252,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		p->scx.slice = kit->slice;
+		set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -8641,7 +8647,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	p->scx.slice = slice;
+	set_task_slice(p, slice);
 	return true;
 }
 
-- 
2.54.0

