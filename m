Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDB3E4506;
	Wed,  8 Jul 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545909; cv=none; b=rLdPAjrUZe8iBWCX40pNdzsD9cjvPX/vQ/qZIbyyM8Bmvvm6BJ+GKSx1e72lH5SadDyZj0hC3O86F9qPpTPcB2pILHopaTY/PigjmRNq8GvzNO3ccH1U0NL39OxJ5lfdkhXxAuI5Gk6iN/H164PazWtuuBJ8KuSM+FB9+iSJviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545909; c=relaxed/simple;
	bh=8XmOsXojlkk9u85EXqqILlZRJJ7BVU6iLzuivKnmaK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coK+FqAH0pQmfqb9kcpvSYCqOgnwO2e0jy4cm5zditW3lQ3nfhR3Cm9sCJ311LbVIa6Hjtw99Hyk5lb5gNRXtqy96EyZqpBkHknZfiyoOl/fv3wxAZML4wbdaVfsh9l4LbmY7MBbWqmHxl05YSkc7DqHgQcMA4DXWdVOytrqfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrO1aurU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrO1aurU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036651F000E9;
	Wed,  8 Jul 2026 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545908;
	bh=ppIvqF2G6l6xd7f33nf0XQtODVGKiMXCcDJCKgvZHiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrO1aurUObaDLEu8RVzJGj/rRAcoPHVxzr5uCQ7ajvDaolO/6BIvwcLgnT/R/ZQa3
	 3MSKMH+Eh1IgWAkhsdRSyrNayDd0PWAa5EDOZ73GTtoY5AnFVzylck4D/1KSRBFTNy
	 ZkySwyQ8rws3vSziagC1ro+NmpiRXZ+AyOKhqHZHraIOD/FlSFaSoxWns98wCg4pTn
	 l+8IpLigKw4/ZOgSOtcOgSunYHuZFtkpVr9WKA97FN3kinQdu8rIR+7yqgRpIIfpBU
	 R+M20D0VIhmPBUDbw+5ZQk23O7qo4PWsHs0X/cr8WeVhasgKdIbMp0k8C8jzXO5ESJ
	 LTxuc+d0faEHw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 34/40] sched_ext: Authorize remote-move inserts against the placing scheduler
Date: Wed,  8 Jul 2026 11:24:23 -1000
Message-ID: <20260708212429.3405787-35-tj@kernel.org>
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

scx_local_or_reject_dsq() authorizes a local-DSQ insert against the caps
of the scheduler doing the insert. On the consume/dispatch paths that is
the scheduler running balance_one(), passed down through
scx_consume_dispatch_q() and move_local_task_to_local_dsq(), so the check
is correct.

The remote-move path loses it. move_remote_task_to_local_dsq()
re-activates @p on the destination rq through enqueue_task_scx(), which
reconstructs the scheduler from the task, i.e. @p's owner. When an
ancestor places a descendant's task - e.g. draining a bypassed
sub-scheduler - the owner is a sub-scheduler of the placer, so
authorizing against the owner checks a narrower cap set and can
spuriously reject a task the placer is entitled to run.

Carry the placing scheduler across the activate_task() boundary the same
way enq_flags already are, via a per-rq field set only for the duration
of the re-activation, and have scx_local_or_reject_dsq() authorize
against it. The placer's caps are a superset of the owner's, so this
admits what the placer may run and keeps rejecting what it may not.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 27 +++++++++++++++------------
 kernel/sched/ext/sub.c |  9 +++++++--
 kernel/sched/sched.h   |  3 ++-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e15297c29617..896f8f9eea6f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2256,7 +2256,8 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
  *
  * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
  */
-static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+static void move_remote_task_to_local_dsq(struct scx_sched *sch,
+					  struct task_struct *p, u64 enq_flags,
 					  struct rq *src_rq, struct rq *dst_rq)
 {
 	lockdep_assert_rq_held(src_rq);
@@ -2273,15 +2274,19 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	raw_spin_rq_lock(dst_rq);
 
 	/*
-	 * We want to pass scx-specific enq_flags but activate_task() will
-	 * truncate the upper 32 bit. As we own @rq, we can pass them through
-	 * @rq->scx.remote_activate_enq_flags instead.
+	 * activate_task() below truncates enq_flags to 32 bits and re-derives
+	 * @p's owner, dropping our scx flags and the placing @sch. We own @rq,
+	 * so stash both across the call. The enqueue reads them back, keeping
+	 * the scx flags and checking caps against the placer, not the owner.
 	 */
 	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
-	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags);
+	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags ||
+		     dst_rq->scx.remote_activate_sch);
 	dst_rq->scx.remote_activate_enq_flags = enq_flags;
+	dst_rq->scx.remote_activate_sch = sch;
 	activate_task(dst_rq, p, 0);
 	dst_rq->scx.remote_activate_enq_flags = 0;
+	dst_rq->scx.remote_activate_sch = NULL;
 }
 
 /*
@@ -2410,14 +2415,14 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq,
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
-		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
+		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
 		raw_spin_rq_unlock(src_rq);
@@ -2479,8 +2484,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 			raw_spin_unlock(&src_dsq->lock);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
+			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
 		}
 	} else {
 		/*
@@ -2533,7 +2537,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
@@ -2627,8 +2631,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
 		} else {
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
+			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
 			/* task has been moved to dst_rq, which is now locked */
 			locked_rq = dst_rq;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 9a1eac886928..f66e97f08ce6 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -237,12 +237,17 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 					       struct task_struct *p, u64 *enq_flags)
 {
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
+	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
 	u64 needed = scx_caps_for_enq(*enq_flags);
 	u64 missing;
 
+	/*
+	 * On a remote activation the scheduling sched (@asch) differs from
+	 * @p's owner (@sch). Check caps against the scheduling sched.
+	 */
 	if (*enq_flags & SCX_ENQ_PREEMPT)
-		needed |= scx_caps_for_preempt(sch, rq);
-	missing = scx_missing_caps(sch, cpu_of(rq), needed);
+		needed |= scx_caps_for_preempt(asch, rq);
+	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
 	/* requirements met */
 	if (likely(!missing))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c0a4699a6c0a..cdd21c814008 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -800,8 +800,9 @@ struct scx_rq {
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
-	/* see move_remote_task_to_local_dsq() */
+	/* both stashed across the activate_task() in move_remote_task_to_local_dsq() */
 	u64			remote_activate_enq_flags;
+	struct scx_sched	*remote_activate_sch;
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			in_select_cpu;
-- 
2.54.0

