Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE0BE5E;
	Tue, 23 Sep 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647970; cv=none; b=HFyBkklEUxCWBI9pHdVzpxNn+95uovG/BaG0HxwoxcSLNvne7GK57cpl/ih6rTzIzgw3BXAVNDV09/0HPgmKpy0YZZALOiyVN5s+JIhEJiounrxGV3L6pfwSoaUKhRc/YzsZmAEGmPTrFd7Mu8HGXRfd5eK2DrnwGT6q76/bIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647970; c=relaxed/simple;
	bh=0uTSkSFLioPYfCT/LQepL3I2twmRWTmOkdtJHuBCCkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRHzho27tDmtspcFPIXD0whBFtprAvh4Egw8W7NYTpAjMN+X3i3i4c5LG6IC1XBIIwKucY2581C96osndOGVznXlbudQgSjRr8+BXXuxpeWzF98t42nOWu0o5b6dBESPYvFUDForbLvfsYZAPUle6ooeSLnIed3rT4z8n9B6xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkNcVd+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkNcVd+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F05BC4CEF5;
	Tue, 23 Sep 2025 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647970;
	bh=0uTSkSFLioPYfCT/LQepL3I2twmRWTmOkdtJHuBCCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkNcVd+np9jru1UIEUhX1rQR8DJy3qEEjfnmp3Ziu+8sXTniPmXYOsa8j7AfxdEf6
	 q6ctjuzBRsw2f4DiWv0lNpWodMXn6aaYrb433Whl5dHFPzFQZSQhTotdoZfL1qbpq7
	 nA486q9EL1Q9nV1pE73KId2vDfbhfB9CBqw8oIAYErr0SmPFhZQcK9/K0q1T4U3ScB
	 Wu8jBb0LWhuEvNKwIKvp8FEPxlmpc2XzwAlv1RVv5Q2AeYozo9ws5yvHIQJv/P5P0b
	 SfL35PObw3lINVJfPj1PrwynfA7mDm0wRAj4BtKC3QN/A/fgWbWmYGBrZTXW63E9En
	 3+e4ON7y1AX7A==
Date: Tue, 23 Sep 2025 07:19:29 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH v2 7/7] sched_ext: Misc updates around scx_sched instance
 pointer
Message-ID: <aNLWobG3HV5VX_FB@slm.duckdns.org>
References: <20250922161436.358949-1-tj@kernel.org>
 <20250922161436.358949-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161436.358949-8-tj@kernel.org>

In preparation for multiple scheduler support:

- Add the @sch parameter to find_global_dsq() and refill_task_slice_dfl().

- Restructure scx_allow_ttwu_queue() and make it read scx_root into $sch.

- Make RCU protection in scx_dsq_move() and scx_bpf_dsq_move_to_local()
  explicit.

v2: Add scx_root -> sch conversion in scx_allow_ttwu_queue().

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   62 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -181,10 +181,9 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
-static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
+static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
+					      struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
-
 	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
 }
 
@@ -880,10 +879,10 @@ static void dsq_mod_nr(struct scx_dispat
 	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
-static void refill_task_slice_dfl(struct task_struct *p)
+static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
 	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(scx_root, SCX_EV_REFILL_SLICE_DFL, 1);
+	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -901,7 +900,7 @@ static void dispatch_enqueue(struct scx_
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(p);
+			dsq = find_global_dsq(sch, p);
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1080,20 +1079,20 @@ static struct scx_dispatch_q *find_dsq_f
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
 		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return find_global_dsq(p);
+			return find_global_dsq(sch, p);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
 	if (dsq_id == SCX_DSQ_GLOBAL)
-		dsq = find_global_dsq(p);
+		dsq = find_global_dsq(sch, p);
 	else
 		dsq = find_user_dsq(sch, dsq_id);
 
 	if (unlikely(!dsq)) {
 		scx_error(sch, "non-existent DSQ 0x%llx for %s[%d]",
 			  dsq_id, p->comm, p->pid);
-		return find_global_dsq(p);
+		return find_global_dsq(sch, p);
 	}
 
 	return dsq;
@@ -1272,15 +1271,15 @@ local:
 	 * higher priority it becomes from scx_prio_less()'s POV.
 	 */
 	touch_core_sched(rq, p);
-	refill_task_slice_dfl(p);
+	refill_task_slice_dfl(sch, p);
 local_norefill:
 	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(p);
-	dispatch_enqueue(sch, find_global_dsq(p), p, enq_flags);
+	refill_task_slice_dfl(sch, p);
+	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1692,7 +1691,7 @@ static struct rq *move_task_between_dsqs
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(p);
+			dst_dsq = find_global_dsq(sch, p);
 			dst_rq = src_rq;
 		}
 	} else {
@@ -1848,7 +1847,7 @@ static void dispatch_to_local_dsq(struct
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(p), p,
+		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2380,7 +2379,7 @@ static struct task_struct *pick_task_scx
 	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
 	} else {
 		p = first_local_task(rq);
 		if (!p) {
@@ -2391,14 +2390,14 @@ static struct task_struct *pick_task_scx
 		}
 
 		if (unlikely(!p->scx.slice)) {
-			struct scx_sched *sch = scx_root;
+			struct scx_sched *sch = rcu_dereference_sched(scx_root);
 
 			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
 						p->comm, p->pid, __func__);
 				sch->warned_zero_slice = true;
 			}
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 		}
 	}
 
@@ -2487,7 +2486,7 @@ static int select_task_rq_scx(struct tas
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
 		if (cpu >= 0) {
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
 		} else {
 			cpu = prev_cpu;
@@ -3572,9 +3571,22 @@ bool task_should_scx(int policy)
 
 bool scx_allow_ttwu_queue(const struct task_struct *p)
 {
-	return !scx_enabled() ||
-		(scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP) ||
-		p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (!scx_enabled())
+		return true;
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch))
+		return true;
+
+	if (sch->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
+		return true;
+
+	if (unlikely(p->sched_class != &ext_sched_class))
+		return true;
+
+	return false;
 }
 
 /**
@@ -5541,9 +5553,15 @@ __bpf_kfunc void scx_bpf_dispatch_cancel
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
 
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
