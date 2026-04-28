Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586551F37D3;
	Tue, 28 Apr 2026 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335398; cv=none; b=QzLmP9fnqKIWIh2BgGJ+cjEdLT13uzZpuhNEtXInNlXSrk/KsIbj4xtQ4vyPmHcU11s94PuWXV3VU3roU48pGzfNuHc8uvM3/LAynurudfD/HNrFfzUDHWeg9A4I/Q3jKyd7GoT87T9iZaQrAErBovY4chPbOFLmEELEo0RhbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335398; c=relaxed/simple;
	bh=fUb8cQHbn3sCpXlQVBuxU0Ixbxypt4RCQRwG3QvJiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j899z7tii+pF+knBvdIyNSoXJfTykfgJE1WnIkvJm5PfG2Wy9uP2JxWX1rU9qofdvHvNtuEsrc19BNlcrwvbgFIPsNHfw1V3yGk3lCHjxZxgqtAPLhhCzB4DeyZqBK2U+QyrEG8Oj3NRSeChckOD3621Oddf09jHvQWbQiCdmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoDO6XcJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoDO6XcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07512C2BCB7;
	Tue, 28 Apr 2026 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335398;
	bh=fUb8cQHbn3sCpXlQVBuxU0Ixbxypt4RCQRwG3QvJiiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoDO6XcJqe8VldK8tkNOX+5HPjrOPe+AtwDAmCn5LnaF3tKDFw/edWZWpPLSjAyAu
	 5c+KiH4LOOm5F1/5c7Ad52K5iRiv/2RMYmNjdpwXHTYs0/oaI0bKFM2B9odOnndRCU
	 ALmJJkOg7qujX3tIEMVMccC98X+6JBN+6DwvTTptgTNbJtQuD+1pbb2kVG5TEqPIzS
	 c0sAi8Zo04+vW+6vaCyNR8a0oVBO/f3Xu6Kw2sC7ThEX1NjX8zEJDd/o2NMCoOa8us
	 q5bEZL4rYao1X4zuwK1PTEkOHmOKUMCFePnYNr+FD20b+Bf2WrT0TIEovTdTizyeSL
	 6x56oRj3LQ7/A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Include exiting tasks in cgroup iter
Date: Mon, 27 Apr 2026 14:16:34 -1000
Message-ID: <20260428001635.3293997-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428001635.3293997-1-tj@kernel.org>
References: <20260428001635.3293997-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup") made
css_task_iter_advance() skip exiting tasks so cgroup.procs stays consistent
with waitpid() visibility. Unfortunately, this broke scx_task_iter.

scx_task_iter walks either scx_tasks (global) or a cgroup subtree via
css_task_iter() and the two modes are expected to cover the same set of
tasks. After the above change the cgroup-scoped mode silently skips tasks
past exit_signals() that are still on scx_tasks.

scx_sub_enable_workfn()'s abort path is one of the symptoms: an exiting
SCX_TASK_SUB_INIT task can race past the cgroup iter leaking
__scx_init_task() state. Other iterations share the same gap.

Add CSS_TASK_ITER_WITH_DEAD to opt out of the skip and use it from
scx_task_iter().

Fixes: b0e4c2f8a0f0 ("sched_ext: Implement cgroup subtree iteration for scx_task_iter")
Reported-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h | 1 +
 kernel/cgroup/cgroup.c | 8 +++++---
 kernel/sched/ext.c     | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index e52160e85af4..f6d037a30fd8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -53,6 +53,7 @@ struct kernel_clone_args;
 enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
+	CSS_TASK_ITER_WITH_DEAD = (1U << 2),  /* include exiting tasks */
 	CSS_TASK_ITER_SKIPPED  = (1U << 16), /* internal flags */
 };
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1f084ee71443..e51ce4cd3739 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5059,10 +5059,12 @@ static void css_task_iter_advance(struct css_task_iter *it)
 
 	task = list_entry(it->task_pos, struct task_struct, cg_list);
 	/*
-	 * Hide tasks that are exiting but not yet removed. Keep zombie
-	 * leaders with live threads visible.
+	 * Hide tasks that are exiting but not yet removed by default. Keep
+	 * zombie leaders with live threads visible. Usages that need to walk
+	 * every existing task can opt out via CSS_TASK_ITER_WITH_DEAD.
 	 */
-	if ((task->flags & PF_EXITING) && !atomic_read(&task->signal->live))
+	if (!(it->flags & CSS_TASK_ITER_WITH_DEAD) &&
+	    (task->flags & PF_EXITING) && !atomic_read(&task->signal->live))
 		goto repeat;
 
 	if (it->flags & CSS_TASK_ITER_PROCS) {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9eda20e5fdb8..cf43be8ac1aa 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -766,7 +766,8 @@ static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 		lockdep_assert_held(&cgroup_mutex);
 		iter->cgrp = cgrp;
 		iter->css_pos = css_next_descendant_pre(NULL, &iter->cgrp->self);
-		css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		css_task_iter_start(iter->css_pos, CSS_TASK_ITER_WITH_DEAD,
+				    &iter->css_iter);
 		return;
 	}
 #endif
@@ -866,7 +867,8 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 			iter->css_pos = css_next_descendant_pre(iter->css_pos,
 								&iter->cgrp->self);
 			if (iter->css_pos)
-				css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+				css_task_iter_start(iter->css_pos, CSS_TASK_ITER_WITH_DEAD,
+						    &iter->css_iter);
 		}
 		return NULL;
 	}
-- 
2.53.0

