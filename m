Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B723E1688;
	Thu,  9 Jul 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637468; cv=none; b=KEJTei3JwaHoQnUgdADsJ0z81wgZPeOQShVjvNze2ZBkTYRNhhw4QY6I8/TwrcebnCjWif2TlkH5HhpBINPJdQv3bsKtfp+6RzvV7nTtKSmNF4c3/JonG+BxOa6Kkk/NQo3Vx7FTAYKjeK2nMrdEz+EiUrswDu7GO8gExdOau6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637468; c=relaxed/simple;
	bh=0kdeurD0JhxbvgIbB47hPpsYqZX2gJlOkQUVj6dHfes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ6r0JzFxkh+Z3TcjxaTEyff6YikRWsn9wuVCk1YMKLQt0UeTxQC5WAmAZD0F+Cij1rfBeHLqJnbKRF7Xc0EYccKaAR6bGfWw8qDJ/OcNWKajxhj0L/ap3TgjdU7PcjVdTUitlySPdElLNxBeQDnHEs9+G9h5X1QidbgU9rJvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFUjyZYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFUjyZYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E6B1F000E9;
	Thu,  9 Jul 2026 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637467;
	bh=Pfg32u11AcfwrPhnQUPx6DxaPjxWvVfZqwsb4sSxAVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFUjyZYHhaWpzxJehXzuQzbpCAvt7XfG4gjdmx9xz2ZZqnoEdZkP7TvjdH9uuLrSl
	 RHt9Kpis2t1lqj5gupjgO8WKbNVjht0oA2eYtoVmkaHTnZ9Nog0G5vdspIKgj6A97e
	 gaBPkcoiNbP+K2EwEagbwHc6NZPyW8U1h6/SDosdCXG6PZ1f8SVWVCqi35w5Hm7+t0
	 dGV9aewwBeJg72+zwzLH4Uu5tLh0g6/nDROadWORQLC/daBIwKLZnrmQ9rJ7s1SRAF
	 sBBHCkImoNrMG/0NBQRzXFVfpV2MlB4cDP5Pl8hED2LGh8U9itrnjBCUaBaohCguum
	 D+xhyRsL4aYlQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 22/33] sched_ext: Route task slice writes through set_task_slice()
Date: Thu,  9 Jul 2026 12:50:30 -1000
Message-ID: <20260709225041.1695495-23-tj@kernel.org>
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
index 0efb396de008..de5a7293c1fb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1165,6 +1165,12 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
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
@@ -1250,7 +1256,7 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(sch->slice_dfl);
+	set_task_slice(p, READ_ONCE(sch->slice_dfl));
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -1345,7 +1351,7 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+		set_task_slice(rq->curr, 0);
 		resched_curr(rq);
 	}
 }
@@ -2058,7 +2064,7 @@ static void yield_task_scx(struct rq *rq)
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
 	else
-		p->scx.slice = 0;
+		set_task_slice(p, 0);
 }
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
@@ -3302,7 +3308,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		curr->scx.slice = 0;
+		set_task_slice(curr, 0);
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
@@ -3441,7 +3447,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	 * control, after ops.disable() has observed their final values.
 	 */
 	p->scx.dsq_vtime = 0;
-	p->scx.slice = 0;
+	set_task_slice(p, 0);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -7091,7 +7097,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(sch->slice_dfl);
+			set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -7734,7 +7740,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				set_task_slice(rq->curr, 0);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -8084,9 +8090,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 
@@ -8110,9 +8116,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		p->scx.slice = slice;
+		set_task_slice(p, slice);
 	else
-		p->scx.slice = p->scx.slice ?: 1;
+		set_task_slice(p, p->scx.slice ?: 1);
 
 	p->scx.dsq_vtime = vtime;
 
@@ -8294,7 +8300,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		p->scx.slice = kit->slice;
+		set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -8687,7 +8693,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	p->scx.slice = slice;
+	set_task_slice(p, slice);
 	return true;
 }
 
-- 
2.55.0

