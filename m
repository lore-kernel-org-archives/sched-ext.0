Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C39371D13;
	Fri,  6 Mar 2026 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824000; cv=none; b=OGUGHbalHRbhRzj5ZljlWop1mgt63Od2Hb9g23dbbx0yIyD80rmI25OdVRPErHds7Z33MnezPk6tWjRLxRaQvDCvzjKukqrIl8o19ihEXyK+sh7+UNIbzgmBO51iAwnMTKYYudfWGGhclNKd/Gr+jQTUneN/O+bZWM0d7iMYY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824000; c=relaxed/simple;
	bh=OoJbJ4cSTH6P70VE5mdudjhWSlOp9CCFfQ9ZN3AN1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq2kO93WVcn/W7OeGQ32uh9Ixv753wXmMYk48h+8kQcF+3b0PTg3JtS1oSxkoM6VpJOUz86/ASp3zzZuvRBFaMGlcf4fNMKPZKIxLvg+qf+xVX7ggWAom77eko3Pk7U3FalOh+gjvXQxDhgJGm3ebS4RIpCX/L5rs5InkBwJj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwhxA7nX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwhxA7nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DB0C2BC9E;
	Fri,  6 Mar 2026 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823999;
	bh=OoJbJ4cSTH6P70VE5mdudjhWSlOp9CCFfQ9ZN3AN1U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwhxA7nXQVAnRItU5yNDv5XZM6EuJ28lEsiuSSJT+D/+c8vDWKfKz80+JQPJcz8Ij
	 sNQz3sW3XszaWnHncff8McxGnaRqCXmGVm/mXka4kmZ2o1O7fBi5Ki92afda4r7u/w
	 /zAaUClQ9hwO3EwwKEL6Dd35724sCyMNdKfstPmtDGmj9Ai9Ym9eBQOxogTKyerthj
	 jV9MQaxAi/oxgQAclQrrHWozLA7xOxduZCl9NQ32ZoghbjwLmuWV1jTf1lxfqDhBA8
	 qrZ/W5GqoMjobhKkfgBWZWZS7R6+ZyHV5nbwNUpe3odAbaHmkWCgbpMpiuxKT8HqHN
	 Kkde2EXyFjp2Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/15] sched_ext: Simplify task state handling
Date: Fri,  6 Mar 2026 09:06:22 -1000
Message-ID: <20260306190623.1076074-15-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Task states (NONE, INIT, READY, ENABLED) were defined in a separate enum with
unshifted values and then shifted when stored in scx_entity.flags. Simplify by
defining them as pre-shifted values directly in scx_ent_flags and removing the
separate scx_task_state enum. This removes the need for shifting when
reading/writing state values.

scx_get_task_state() now returns the masked flags value directly.
scx_set_task_state() accepts the pre-shifted state value. scx_dump_task()
shifts down for display to maintain readable output.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 28 ++++++++++++++++------------
 kernel/sched/ext.c        | 19 +++++++++----------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index e77504faa0bc..e822b374b17f 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -93,7 +93,7 @@ struct scx_dispatch_q {
 	struct rcu_head		rcu;
 };
 
-/* scx_entity.flags */
+/* sched_ext_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
 	SCX_TASK_IN_CUSTODY	= 1 << 1, /* in custody, needs ops.dequeue() when leaving */
@@ -101,21 +101,25 @@ enum scx_ent_flags {
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 
-	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
+	/*
+	 * Bits 8 and 9 are used to carry task state:
+	 *
+	 * NONE		ops.init_task() not called yet
+	 * INIT		ops.init_task() succeeded, but task can be cancelled
+	 * READY	fully initialized, but not in sched_ext
+	 * ENABLED	fully initialized and in sched_ext
+	 */
+	SCX_TASK_STATE_SHIFT	= 8,	  /* bits 8 and 9 are used to carry task state */
 	SCX_TASK_STATE_BITS	= 2,
 	SCX_TASK_STATE_MASK	= ((1 << SCX_TASK_STATE_BITS) - 1) << SCX_TASK_STATE_SHIFT,
 
-	SCX_TASK_CURSOR		= 1 << 31, /* iteration cursor, not a task */
-};
-
-/* scx_entity.flags & SCX_TASK_STATE_MASK */
-enum scx_task_state {
-	SCX_TASK_NONE,		/* ops.init_task() not called yet */
-	SCX_TASK_INIT,		/* ops.init_task() succeeded, but task can be cancelled */
-	SCX_TASK_READY,		/* fully initialized, but not in sched_ext */
-	SCX_TASK_ENABLED,	/* fully initialized and in sched_ext */
+	SCX_TASK_NONE		= 0 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_INIT		= 1 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_READY		= 2 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_ENABLED	= 3 << SCX_TASK_STATE_SHIFT,
 
-	SCX_TASK_NR_STATES,
+	/* iteration cursor, not a task */
+	SCX_TASK_CURSOR		= 1 << 31,
 };
 
 /* scx_entity.dsq_flags */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e7dffe4094c..df659e51bd8a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3312,18 +3312,16 @@ static struct cgroup *tg_cgrp(struct task_group *tg)
 
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
-static enum scx_task_state scx_get_task_state(const struct task_struct *p)
+static u32 scx_get_task_state(const struct task_struct *p)
 {
-	return (p->scx.flags & SCX_TASK_STATE_MASK) >> SCX_TASK_STATE_SHIFT;
+	return p->scx.flags & SCX_TASK_STATE_MASK;
 }
 
-static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
+static void scx_set_task_state(struct task_struct *p, u32 state)
 {
-	enum scx_task_state prev_state = scx_get_task_state(p);
+	u32 prev_state = scx_get_task_state(p);
 	bool warn = false;
 
-	BUILD_BUG_ON(SCX_TASK_NR_STATES > (1 << SCX_TASK_STATE_BITS));
-
 	switch (state) {
 	case SCX_TASK_NONE:
 		break;
@@ -3341,11 +3339,11 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 		return;
 	}
 
-	WARN_ONCE(warn, "sched_ext: Invalid task state transition %d -> %d for %s[%d]",
+	WARN_ONCE(warn, "sched_ext: Invalid task state transition 0x%x -> 0x%x for %s[%d]",
 		  prev_state, state, p->comm, p->pid);
 
 	p->scx.flags &= ~SCX_TASK_STATE_MASK;
-	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
+	p->scx.flags |= state;
 }
 
 static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
@@ -5795,7 +5793,8 @@ static void scx_dump_task(struct scx_sched *sch,
 		  own_marker, sch_id_buf,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
-		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
+		  scx_get_task_state(p) >> SCX_TASK_STATE_SHIFT,
+		  p->scx.flags & ~SCX_TASK_STATE_MASK,
 		  p->scx.dsq_flags, ops_state & SCX_OPSS_STATE_MASK,
 		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
 	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s",
@@ -6556,7 +6555,7 @@ static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
 
 static bool assert_task_ready_or_enabled(struct task_struct *p)
 {
-	enum scx_task_state state = scx_get_task_state(p);
+	u32 state = scx_get_task_state(p);
 
 	switch (state) {
 	case SCX_TASK_READY:
-- 
2.53.0

