Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C401B7910;
	Thu,  9 Jul 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637445; cv=none; b=H+YyDdUqxAlzZ+qsXWii8Havk9cHRWf3h8Hu0fRCfx9T74hc97UoLfHfafQSWazz6sWyx5uMMcImbJEfDo0CLx04XO8BQlWRpj+v0aumKAmhiTAHofzXIsXpS3z0HPd34zrUSOXknDJ6m7lmiML0/hdthxGMyjEtaEYhemFwGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637445; c=relaxed/simple;
	bh=6gwGU20dsGHp+PYnGzFRxinKyQq8BeKSkPlbdAltD8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxeq4plLSqihu2rKj9rhbuZeRuoj+sWjNH/ZRVnWY+hUbqqJfskYR5+lxNEVchVMblkiggjnL5Poc6asMzaT4x8KSb8u+wpCXzQKNWbIJZ3ubkY3/fEPvPnm34DV7wPlOw3kpJmukPLOunD16RvNgEnUkN9aDOWCVMVH/O4U890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrjAymCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrjAymCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D1A1F00A3A;
	Thu,  9 Jul 2026 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637443;
	bh=FL9n3EWHTffkv0GP/jCWQ4/Ug9iRhn+ugqp0Qzg2iIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrjAymCsl9UzHZQjzLaMiGUzrD/8nuzNvVE5zRbFUAQVc7IYnzNEHCT/11hEREQ9Q
	 ScKoqwJvsXotLqAaKz3OOjqbUvSnI1/CNiPoWQ0UuN55eALR67b6mSTcSRPnzqw39p
	 4/DYCGrgxfzL3rWoWV+0ez7v40r3GRIcFsNxbDZJl4zy0Mx+X8siGD4+hfYrI48G9H
	 KZGhsrz4OrCPgIiY5obVzVUT5sfuDOxaKwY8SuWYUU5WchojMBA8u4hBfkGs676EaV
	 2QVI45AFzPG9y88j/+ksTUvWUlDtjjZil50IuICmF2yUD/VjmUhJUN5ujvaPeBFHGK
	 ldPfBUSKp/FUw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 01/33] sched_ext: Assert per-task ops run on the task's owner
Date: Thu,  9 Jul 2026 12:50:09 -1000
Message-ID: <20260709225041.1695495-2-tj@kernel.org>
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

A per-task op must be dispatched on the scheduler that owns the task.
SCX_CALL_OP_TASK() and its _RET twin take @sch explicitly, and a caller that
passes the wrong scheduler would silently run the op on it. Add a
WARN_ON_ONCE() that @sch matches the task's owner so such a mismatch is
caught rather than hidden.

Two sites legitimately target a scheduler other than the task's owner:
cgroup_move() runs on the root sched, and scx_sub_init_cancel_task() fires
exit_task() on a task not yet associated with @sch. Both switch to the inner
__SCX_CALL_OP_TASK(), which dispatches on the explicit @sch without the
assert.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 20 +++++++++++++-------
 kernel/sched/ext/internal.h | 10 +++++++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5241b55a58ec..acc3b43fe88a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1436,8 +1436,12 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 		local_dsq_post_enq(sch, dsq, p, enq_flags);
 	} else {
 		/*
-		 * Task on global/bypass DSQ: leave custody, task on
-		 * non-terminal DSQ: enter custody.
+		 * Global and bypass DSQs are terminal - the task leaves the
+		 * scheduler's custody, so ops.dequeue() fires here. It can run
+		 * without @p's rq lock (finish_dispatch() passes the dispatch
+		 * rq); that's safe because dequeue_task_scx() waits on
+		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
+		 * can't race it. A non-terminal DSQ keeps the task in custody.
 		 */
 		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
 			call_task_dequeue(sch, rq, p, 0);
@@ -3446,8 +3450,9 @@ void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
+	/* @p was never associated with @sch, dispatch on the explicit @sch */
 	if (SCX_HAS_OP(sch, exit_task))
-		SCX_CALL_OP_TASK(sch, exit_task, task_rq(p), p, &args);
+		__SCX_CALL_OP_TASK(sch, ops, exit_task, task_rq(p), p, &args);
 }
 
 void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
@@ -4184,12 +4189,13 @@ void scx_cgroup_move_task(struct task_struct *p)
 	 * cgroup changes. Migration keys off css rather than cgroup identity,
 	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
 	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
-	 * keep prep_move and move paired.
+	 * keep prep_move and move paired. Cgroup ops run on the root sched,
+	 * dispatch on the explicit @sch.
 	 */
 	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
-		SCX_CALL_OP_TASK(sch, cgroup_move, task_rq(p),
-				 p, p->scx.cgrp_moving_from,
-				 tg_cgrp(task_group(p)));
+		__SCX_CALL_OP_TASK(sch, ops, cgroup_move, task_rq(p),
+				   p, p->scx.cgrp_moving_from,
+				   tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5ca44ad88786..8aabd92fae3b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1810,8 +1810,15 @@ do {										\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
+/*
+ * A per-task op runs on @task's owner - WARN if @sch isn't it. Sites that must
+ * target a different scheduler call __SCX_CALL_OP_TASK() directly.
+ */
 #define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
-	__SCX_CALL_OP_TASK(sch, ops, op, locked_rq, task, ##args)
+do {										\
+	WARN_ON_ONCE((sch) != scx_task_sched_rcu(task));			\
+	__SCX_CALL_OP_TASK((sch), ops, op, locked_rq, task, ##args);		\
+} while (0)
 
 /*
  * Dispatch a task op through the cid-form ops_cid table. Only set_cmask() needs
@@ -1824,6 +1831,7 @@ do {										\
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
+	WARN_ON_ONCE((sch) != scx_task_sched_rcu(task));			\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
-- 
2.55.0

