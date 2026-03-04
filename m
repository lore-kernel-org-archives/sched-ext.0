Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F43EBF32;
	Wed,  4 Mar 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661710; cv=none; b=jMJjCbx6FcGE1KjPffxTBSlQDsVqEHS8rQIgLqV/hwcTcqsBP4vAxqg5KQ7sokNMuVNDCbcH1weiJWeYVSVEKfe6JbTCFtG3S3wL9mciwgaDLjMYXY5ZpEdtk0tzrlWwwux/+uIoh6jen2ocsvN7pmsuDeeUeKj6jKIYx5PjEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661710; c=relaxed/simple;
	bh=hVfTJAMIhKsy/n534WmXq+HM7LV9hlTzyzlqCzaKfnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPuVsb8pd0L9b0daf9bccWx/+NjKRLzb4AKq8TsX2TPGGcprHvTbPc6QKdaP96njOrs1WrHO1+Bn7ZnML4qkoxraR20EZxiKo1KIYHHqiox4fCuQXLYTBsSQ3qxqDfDWjKBFvtxOUKKceQ/Y3Vz5qGqT1fTzDCN66C+ooqcKLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8rFXdHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8rFXdHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB8C2BCB1;
	Wed,  4 Mar 2026 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661710;
	bh=hVfTJAMIhKsy/n534WmXq+HM7LV9hlTzyzlqCzaKfnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8rFXdHx9Lw6yY06IU8vMWc/Rs0qT8mXyMH2PSIExvDKO1WQugRaytUfVLWZP0ASG
	 Bxl9GHgW+QRyZM00yyYtuK4Q9vWqjY7rx8qdiy78oBIjWzJypbYrR3oMxE8sBvCPKG
	 PbeB1sry05XxHfpdTRUFHBcRBtKppKAvJ7EccqdWvh/n2YkXXdqjX4uyRQ8j6k/Kwo
	 nwnjAaBgfHK4Yol3f+ICk1oR59cYTSd7QP13CrsaTGBUPnZz70IatD/Beey/P/pant
	 mHW1l52qX4eWU9xQkJNUI7qS2hFSnpetamcE/xam+ki/8c+S/MjHUvtBOnzRiwIKEW
	 LhJCbxqIU+ZTg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 28/34] sched_ext: Support dumping multiple schedulers and add scheduler identification
Date: Wed,  4 Mar 2026 12:01:13 -1000
Message-ID: <20260304220119.4095551-29-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
index 2811e3f7e9f0..77647657e6d2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5175,22 +5175,34 @@ static void ops_dump_exit(void)
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
@@ -5218,11 +5230,18 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
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
@@ -5239,6 +5258,14 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
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
@@ -5331,11 +5358,13 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
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
@@ -5368,7 +5397,7 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (ei->kind >= SCX_EXIT_ERROR)
-		scx_dump_state(ei, sch->ops.exit_dump_len);
+		scx_dump_state(sch, ei, sch->ops.exit_dump_len, true);
 
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
@@ -6400,9 +6429,12 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
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
2.53.0

