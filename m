Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2B376BD0;
	Wed, 21 Jan 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037132; cv=none; b=JbdmVjCmM7kHsgJS7JuUp/lVlUoVtU7S3xWmnM17M/olia2QdBnjX/wsBoqC2nPq13aJJkeqCiO/5y8VllaPepoX4DzPDWdJtxlphczwViE86IVqFWOMrr+bwunAbC+acREj4qv0gVNYtr44QWjRifVVAt3KfkLxHACLX6K2Fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037132; c=relaxed/simple;
	bh=DUdQSG01l4LrLosRIdqEQqQB2bysBjgSpLFLV3jnvjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvp+2SPrv7rblBKv280NV9Xc+mLY6RCbjyxb697DTP9EegxQh+BpXHTXyKUCq4FJxCxCwgPdF4ViIqkN6KHLpk29fRqpBx7TU2Bw7/JPG3eJLyzSj1tYcHiyCbjZZ9oQnPtaDIj1kOKOhOTdnJYDwFt/Esa4QXi3ekE/8aKOEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E91ReH9u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E91ReH9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB947C16AAE;
	Wed, 21 Jan 2026 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037131;
	bh=DUdQSG01l4LrLosRIdqEQqQB2bysBjgSpLFLV3jnvjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E91ReH9uqXr7OLKP6g4Z1q91GjcOLiwULovdYI9wdGOiMHgogUnRVGl1zIbAJ9Xcj
	 NbLnfDp31R+JAjMEAoFKkVy5GJqiIcgxzwDOXLqibruG41faBU/VzUaeLUIhN8jkDg
	 ZNmUDNqO+o9mzzUgDAeqsUeQNUC4PAAK/F4oCuostS7K+7Qx80HT0wE0kaa3p7kfsY
	 LutiAq/jwX43i1esORIkjrUloNOqXBf7MDLgLuGmTpdubysFh4esRYtF2UwN/ZNyfa
	 X2UYvqSVrJUy7jHzR+sDf9sEy6RCw6lnNEZP3vzDY6sXOcOkFP0BU5j7TYdpbkzvoE
	 j4Giag9dF0bHg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 28/34] sched_ext: Support dumping multiple schedulers and add scheduler identification
Date: Wed, 21 Jan 2026 13:11:34 -1000
Message-ID: <20260121231140.832332-29-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend scx_dump_state() to support multiple schedulers and improve task
identification in dumps. The function now takes a specific scheduler to
dump and can optionally filter tasks by scheduler.

scx_dump_task() now displays which scheduler each task belongs to, using
"*" to mark tasks owned by the scheduler being dumped. Sub-schedulers
are identified with their level and cgroup ID.

The SysRq-D handler now iterates through all active schedulers under
scx_sched_lock and dumps each one separately. For SysRq-D dumps, only
tasks owned by each scheduler are dumped to avoid redundancy since all
schedulers are being dumped. Error-triggered dumps continue to dump all
tasks since only that specific scheduler is being dumped.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 54 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e8d7ad0a8a6b..be049ab1fbcc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4969,22 +4969,34 @@ static void ops_dump_exit(void)
 	scx_dump_data.cpu = -1;
 }
 
-static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
+static void scx_dump_task(struct scx_sched *sch,
+			  struct seq_buf *s, struct scx_dump_ctx *dctx,
 			  struct task_struct *p, char marker)
 {
 	static unsigned long bt[SCX_EXIT_BT_LEN];
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *task_sch = scx_task_sched(p);
+	const char *own_marker;
+	char sch_id_buf[32];
 	char dsq_id_buf[19] = "(n/a)";
 	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
 	unsigned int bt_len = 0;
 
+	own_marker = task_sch == sch ? "*" : "";
+
+	if (task_sch->level == 0)
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "root");
+	else
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "sub%d-%llu",
+			  task_sch->level, task_sch->ops.sub_cgroup_id);
+
 	if (p->scx.dsq)
 		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
 			  (unsigned long long)p->scx.dsq->id);
 
 	dump_newline(s);
-	dump_line(s, " %c%c %s[%d] %+ldms",
+	dump_line(s, " %c%c %s[%d] %s%s %+ldms",
 		  marker, task_state_to_char(p), p->comm, p->pid,
+		  own_marker, sch_id_buf,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
@@ -5012,11 +5024,18 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 	}
 }
 
-static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
+/*
+ * Dump scheduler state. If @dump_all_tasks is true, dump all tasks regardless
+ * of which scheduler they belong to. If false, only dump tasks owned by @sch.
+ * For SysRq-D dumps, @dump_all_tasks=false since all schedulers are dumped
+ * separately. For error dumps, @dump_all_tasks=true since only the failing
+ * scheduler is dumped.
+ */
+static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
+			   size_t dump_len, bool dump_all_tasks)
 {
 	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
-	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
 		.kind = ei->kind,
 		.exit_code = ei->exit_code,
@@ -5033,6 +5052,14 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (sch->level == 0)
+		dump_line(&s, "%s: root", sch->ops.name);
+	else
+		dump_line(&s, "%s: sub%d-%llu %s",
+			  sch->ops.name, sch->level, sch->ops.sub_cgroup_id,
+			  sch->cgrp_path);
+#endif
 	if (ei->kind == SCX_EXIT_NONE) {
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
@@ -5125,11 +5152,13 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 				seq_buf_set_overflow(&s);
 		}
 
-		if (rq->curr->sched_class == &ext_sched_class)
-			scx_dump_task(&s, &dctx, rq->curr, '*');
+		if (rq->curr->sched_class == &ext_sched_class &&
+		    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
+			scx_dump_task(sch, &s, &dctx, rq->curr, '*');
 
 		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
-			scx_dump_task(&s, &dctx, p, ' ');
+			if (dump_all_tasks || scx_task_on_sched(sch, p))
+				scx_dump_task(sch, &s, &dctx, p, ' ');
 	next:
 		rq_unlock_irqrestore(rq, &rf);
 	}
@@ -5162,7 +5191,7 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (ei->kind >= SCX_EXIT_ERROR)
-		scx_dump_state(ei, sch->ops.exit_dump_len);
+		scx_dump_state(sch, ei, sch->ops.exit_dump_len, true);
 
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
@@ -6145,9 +6174,12 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void sysrq_handle_sched_ext_dump(u8 key)
 {
 	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
+	struct scx_sched *sch;
 
-	if (scx_enabled())
-		scx_dump_state(&ei, 0);
+	guard(raw_spinlock_irqsave)(&scx_sched_lock);
+
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		scx_dump_state(sch, &ei, 0, false);
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_dump_op = {
-- 
2.52.0

