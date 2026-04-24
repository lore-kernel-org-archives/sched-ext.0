Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4283FBEB2;
	Fri, 24 Apr 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063468; cv=none; b=tQyd5IdoTfyAsdjcC7jfJ/wktufJCKcugcBvOx7ZhawGb9r91oCc5Mop4UGfyaz2Dl1R49FBUpv0gmpj8+b/WEKVaOm4HDW9d/30odTDqsUoW+OXXNjm0j98W7NQTs63D2JcdUpVNgMY39fLJiYSj12i0mUKkQuE4jFUWuZzLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063468; c=relaxed/simple;
	bh=mdeOjzu80QumdbpZxGLhkTWO9RyVu8gu57uM56tDAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCN15I4mnEKYIr3pt+OaKudl11FOgV/bkLjlLyaiUJzavwj/CmhgZb8JQvROOSUIsLuNiQRDP8DeqOTedgwltjv1z1lGbqN2e187cb92Qc2/jTQDGgctNo9jrVfOep65jz/wKIwA9uVH9eCC8cTYxop8E8M2T3sEEOfx0Jkyjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaO7Nx8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaO7Nx8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D7CC2BCB4;
	Fri, 24 Apr 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063468;
	bh=mdeOjzu80QumdbpZxGLhkTWO9RyVu8gu57uM56tDAZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaO7Nx8njGOftDfinT+33i6uaZUoGQr3jy0M72AyMn/FRfw1iPe1wj4MCd4blTgF/
	 8aOd8fAMK8fiTgQ1h7y4tM9zHlCobLWa7/sZusGUSecr88YiYo2V3ud4SbEyhTgiV5
	 2y1TBvDHJo1X1jctY4jfOHB3V8wCebSlFUu/yvy5JVaeWBEZdWLu0J2BSmrYhrj3lf
	 wogZAG39vup95uBJ3I5Omd7GXedFl/4PT11AJyXjyhjpEuc5BibPC0Yi5/vkxTxuQC
	 NYJhdSOMcZS0I7AZmHqQavZtNaqG10X7qa9YcHOLEsekjqgJudlirh9pxQv5YAxIht
	 ElTxyXdM+1+tg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/13] sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP
Date: Fri, 24 Apr 2026 10:44:13 -1000
Message-ID: <20260424204418.3809733-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_CALL_OP{,_RET}() unconditionally clears scx_locked_rq_state to NULL on
exit. Correct at the top level, but ops can recurse via
scx_bpf_sub_dispatch(): a parent's ops.dispatch calls the helper, which
invokes the child's ops.dispatch under another SCX_CALL_OP. When the inner
call returns, the NULL clobbers the outer's state. The parent's BPF then
calls kfuncs like scx_bpf_cpuperf_set() which read scx_locked_rq()==NULL and
re-acquire the already-held rq.

Snapshot scx_locked_rq_state on entry and restore on exit. Rename the rq
parameter to locked_rq across all SCX_CALL_OP* macros so the snapshot local
can be typed as 'struct rq *' without colliding with the parameter token in
the expansion. SCX_CALL_OP_TASK{,_RET}() and SCX_CALL_OP_2TASKS_RET() funnel
through the two base macros and inherit the fix.

Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 49 ++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 045b4c914768..608d5dc4c8bc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -470,24 +470,35 @@ static inline void update_locked_rq(struct rq *rq)
 	__this_cpu_write(scx_locked_rq_state, rq);
 }
 
-#define SCX_CALL_OP(sch, op, rq, args...)					\
+/*
+ * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
+ * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
+ */
+#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
 do {										\
-	if (rq)									\
-		update_locked_rq(rq);						\
+	struct rq *__prev_locked_rq;						\
+										\
+	if (locked_rq) {							\
+		__prev_locked_rq = scx_locked_rq();				\
+		update_locked_rq(locked_rq);					\
+	}									\
 	(sch)->ops.op(args);							\
-	if (rq)									\
-		update_locked_rq(NULL);						\
+	if (locked_rq)								\
+		update_locked_rq(__prev_locked_rq);				\
 } while (0)
 
-#define SCX_CALL_OP_RET(sch, op, rq, args...)					\
+#define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
 ({										\
+	struct rq *__prev_locked_rq;						\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	if (rq)									\
-		update_locked_rq(rq);						\
+	if (locked_rq) {							\
+		__prev_locked_rq = scx_locked_rq();				\
+		update_locked_rq(locked_rq);					\
+	}									\
 	__ret = (sch)->ops.op(args);						\
-	if (rq)									\
-		update_locked_rq(NULL);						\
+	if (locked_rq)								\
+		update_locked_rq(__prev_locked_rq);				\
 	__ret;									\
 })
 
@@ -499,39 +510,39 @@ do {										\
  * those subject tasks.
  *
  * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
- * either via the @rq argument here, or (for ops.select_cpu()) via @p's pi_lock
- * held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu. So if
- * kf_tasks[] is set, @p's scheduler-protected fields are stable.
+ * either via the @locked_rq argument here, or (for ops.select_cpu()) via @p's
+ * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
+ * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
  *
  * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
  * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
  * while a previous one is still in progress.
  */
-#define SCX_CALL_OP_TASK(sch, op, rq, task, args...)				\
+#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
 do {										\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP((sch), op, rq, task, ##args);				\
+	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
-#define SCX_CALL_OP_TASK_RET(sch, op, rq, task, args...)			\
+#define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
-	__ret = SCX_CALL_OP_RET((sch), op, rq, task, ##args);			\
+	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
 	current->scx.kf_tasks[0] = NULL;					\
 	__ret;									\
 })
 
-#define SCX_CALL_OP_2TASKS_RET(sch, op, rq, task0, task1, args...)		\
+#define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
 ({										\
 	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
-	__ret = SCX_CALL_OP_RET((sch), op, rq, task0, task1, ##args);		\
+	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
 	current->scx.kf_tasks[0] = NULL;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	__ret;									\
-- 
2.53.0

