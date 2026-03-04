Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B26384238;
	Wed,  4 Mar 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661681; cv=none; b=pNITGk166UCVbq4jEKboGt4GaojYngygDG1mQddRtX3O2Fy9RX12guvvqrqDNm98k6QTvZLOKpwrRY3DqJx1PprZ2Vt+m/zGd7cjD/zp6PAcAI8DeXobhM0szcRJD4e1UBLwCE2hZSfmdnZdX/rgHLGZuK7xHHMzpsxhJgkj21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661681; c=relaxed/simple;
	bh=oHMnYfp0QkrFMysB7/o+H9TrpnY3meUcdmI6EK/oBFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXiPccOE8b/XghQzfKWj6oEhs3mroIN8c6dcYk/9t4oXZA6f+ejttjFJHL2rrWEesJt+E4TEiJAMVZ68/bCoUVmZaCk1qPKKvXrSViGHIRlGECTUA3EA3oWpDybngz2ZblRfEYDCk1yP3Do2QebHto0wm3eVYujBST/MW9MuHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3skbwy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3skbwy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F33C4CEF7;
	Wed,  4 Mar 2026 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661681;
	bh=oHMnYfp0QkrFMysB7/o+H9TrpnY3meUcdmI6EK/oBFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3skbwy1sjSBXgjqgeTpvytVBMqELbKt6NOKL5t4j7FSq1cieerXWbhw5ZSAGU4rP
	 5Nm7Te3RjjQG2uCpThtKX9EfY3qKBt1oI7kQ04Zje+L8WEQIpXqETR5bc2ftFnS0B8
	 DVDi3zPmgZJZg+HeS+ePgwi2dAroSRkXmZHRg7fXfQ/JzqkItW6PR/D/JkAFfiHKeX
	 QUAtkY4zxNgpLiev1mLLhw4qrodv/HqkLIuwFgVMAkQBIff4BasMmHkPz2a093UjBL
	 SjklqVFVq2Fhvw5qdZquK+/qR1z/lDBQzscuMUNYbMp14fIUc3UbtpqRZRc1Wrtmwf
	 NkXNmZiAByfGg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/34] sched_ext: Implement cgroup subtree iteration for scx_task_iter
Date: Wed,  4 Mar 2026 12:00:46 -1000
Message-ID: <20260304220119.4095551-2-tj@kernel.org>
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

For the planned cgroup sub-scheduler support, enable/disable operations are
going to be subtree specific and iterating all tasks in the system for those
operations can be unnecessarily expensive and disruptive.

cgroup already has mechanisms to perform subtree task iterations. Implement
cgroup subtree iteration for scx_task_iter:

- Add optional @cgrp to scx_task_iter_start() which enables cgroup subtree
  iteration.

- Make scx_task_iter use css_next_descendant_pre() and css_task_iter to
  iterate all tasks in the cgroup subtree.

- Update all existing callers to pass NULL to maintain current behavior.

The two iteration mechanisms are independent and duplicate. It's likely that
scx_tasks can be removed in favor of always using cgroup iteration if
CONFIG_SCHED_CLASS_EXT depends on CONFIG_CGROUPS.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 64 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1c3170846c84..0bd86540472d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -514,14 +514,31 @@ struct scx_task_iter {
 	struct rq_flags			rf;
 	u32				cnt;
 	bool				list_locked;
+#ifdef CONFIG_CGROUPS
+	struct cgroup			*cgrp;
+	struct cgroup_subsys_state	*css_pos;
+	struct css_task_iter		css_iter;
+#endif
 };
 
 /**
  * scx_task_iter_start - Lock scx_tasks_lock and start a task iteration
  * @iter: iterator to init
+ * @cgrp: Optional root of cgroup subhierarchy to iterate
+ *
+ * Initialize @iter. Once initialized, @iter must eventually be stopped with
+ * scx_task_iter_stop().
+ *
+ * If @cgrp is %NULL, scx_tasks is used for iteration and this function returns
+ * with scx_tasks_lock held and @iter->cursor inserted into scx_tasks.
+ *
+ * If @cgrp is not %NULL, @cgrp and its descendants' tasks are walked using
+ * @iter->css_iter. The caller must be holding cgroup_lock() to prevent cgroup
+ * task migrations.
  *
- * Initialize @iter and return with scx_tasks_lock held. Once initialized, @iter
- * must eventually be stopped with scx_task_iter_stop().
+ * The two modes of iterations are largely independent and it's likely that
+ * scx_tasks can be removed in favor of always using cgroup iteration if
+ * CONFIG_SCHED_CLASS_EXT depends on CONFIG_CGROUPS.
  *
  * scx_tasks_lock and the rq lock may be released using scx_task_iter_unlock()
  * between this and the first next() call or between any two next() calls. If
@@ -532,10 +549,19 @@ struct scx_task_iter {
  * All tasks which existed when the iteration started are guaranteed to be
  * visited as long as they are not dead.
  */
-static void scx_task_iter_start(struct scx_task_iter *iter)
+static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 {
 	memset(iter, 0, sizeof(*iter));
 
+#ifdef CONFIG_CGROUPS
+	if (cgrp) {
+		lockdep_assert_held(&cgroup_mutex);
+		iter->cgrp = cgrp;
+		iter->css_pos = css_next_descendant_pre(NULL, &iter->cgrp->self);
+		css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		return;
+	}
+#endif
 	raw_spin_lock_irq(&scx_tasks_lock);
 
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
@@ -588,6 +614,14 @@ static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
  */
 static void scx_task_iter_stop(struct scx_task_iter *iter)
 {
+#ifdef CONFIG_CGROUPS
+	if (iter->cgrp) {
+		if (iter->css_pos)
+			css_task_iter_end(&iter->css_iter);
+		__scx_task_iter_rq_unlock(iter);
+		return;
+	}
+#endif
 	__scx_task_iter_maybe_relock(iter);
 	list_del_init(&iter->cursor.tasks_node);
 	scx_task_iter_unlock(iter);
@@ -611,6 +645,24 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 		cond_resched();
 	}
 
+#ifdef CONFIG_CGROUPS
+	if (iter->cgrp) {
+		while (iter->css_pos) {
+			struct task_struct *p;
+
+			p = css_task_iter_next(&iter->css_iter);
+			if (p)
+				return p;
+
+			css_task_iter_end(&iter->css_iter);
+			iter->css_pos = css_next_descendant_pre(iter->css_pos,
+								&iter->cgrp->self);
+			if (iter->css_pos)
+				css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		}
+		return NULL;
+	}
+#endif
 	__scx_task_iter_maybe_relock(iter);
 
 	list_for_each_entry(pos, cursor, tasks_node) {
@@ -4440,7 +4492,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
@@ -5230,7 +5282,7 @@ static void scx_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
 		 * @p may already be dead, have lost all its usages counts and
@@ -5272,7 +5324,7 @@ static void scx_enable_workfn(struct kthread_work *work)
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
-- 
2.53.0

