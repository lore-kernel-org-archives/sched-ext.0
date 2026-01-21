Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13D21ADA7;
	Wed, 21 Jan 2026 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037103; cv=none; b=eYo94zaySKNYfpqpWT2YECup2s2DQIxSfRYBgTjK0q9D6g68JyCHmfanmuDM/869nmq8bL3prvJyffxCtsMMbeNMhjqZU/NR05FE255cFX8xsvragIYsWA5leL6k++na77ej2Jo6Whh3s38cNN6e+4egfyvFB/M0Y+n2QWkqYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037103; c=relaxed/simple;
	bh=QJjuxoBQ5h4rTad4VsQ5GSM354zodZUrcBVH26Bylmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScwLjhk2GtdLoi6c/SD6R/lfNme1/mvweAMvqyzpQPSJEYxDUIxxdqO9XXC2WPwRYNZtJL11po+TWLMl/Xj5KY4IKSl9lyIkdZBQdDy0gNB7B/UJADpjjRKzMI7rGczxSjoCBTWhGC5QrnKBdUTKPwONjDbhi4zrBxaqhZxe2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1jbKW4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1jbKW4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CF2C16AAE;
	Wed, 21 Jan 2026 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037102;
	bh=QJjuxoBQ5h4rTad4VsQ5GSM354zodZUrcBVH26Bylmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1jbKW4BIu4Pa1fP7PMwDP/lwvnq7RQYxUvla2pj9xtjluC11bxkjLkubkN1hAEcC
	 HXehPJJPguReR8ttvWOsIQTWvA4Pb/9BP14AWjUntSOzClnI434c8VAGukLw7ug8FM
	 gXiuT27oKgL5rb9FX44ny5A3k5/9EGq/x/W2S2whSPx8061stmeeGdSBEc/OAZhuUv
	 +Bafyas2T0rPLGwDr6dIW1OKPUO++F1trgWAoQssZRMH78VQgoVwLjsuLKpFWsNKS9
	 qL7llAJCDdG414pnHXtrCYIzlmjCOyVR+PEx6h9cUo1+98av9HJ9DgTeuE5kv7Oqz7
	 z5usL+IrLiY4Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/34] sched_ext: Implement cgroup subtree iteration for scx_task_iter
Date: Wed, 21 Jan 2026 13:11:07 -1000
Message-ID: <20260121231140.832332-2-tj@kernel.org>
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
index bd2fed7a1c56..ba2a72752e13 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -513,14 +513,31 @@ struct scx_task_iter {
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
@@ -531,10 +548,19 @@ struct scx_task_iter {
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
@@ -586,6 +612,14 @@ static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
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
@@ -609,6 +643,24 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
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
@@ -4256,7 +4308,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
@@ -5025,7 +5077,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
 		 * @p may already be dead, have lost all its usages counts and
@@ -5067,7 +5119,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
-- 
2.52.0

