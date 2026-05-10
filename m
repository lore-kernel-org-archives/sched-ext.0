Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E73659FB;
	Sun, 10 May 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398876; cv=none; b=AuJl4fUoMa/A9hHmCZrcExaWLIx4O9yPbRNAn2y0Zumt0ByTYnn26WShP+qts+fNabOkcx/p+JQUvJQ1AJxUFGdQEq0tDkxz75p6KLuqEevevkCQeazZKCOsDITkQgqB4GdJ8ONOGCFsCyfTS8LWJKBsqmglZJIZERyJAA4EJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398876; c=relaxed/simple;
	bh=0azDLewswXg+tFhZjYsCaYQYMTyckf+GbVshyn1sOh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLFzrAgdTQ9P1PLcP7BynkUP4NDVD9GpgtV1XmVQ78ykjneD/kfL/wkMfRP6qGNt60h8qhoYrJh9u/8knL3v8Li7jFVly4VY+NiMgkUeoBsZXGeAVby3cKeBVSVrbFXV6cKsyAxoJGqhPl/Qxa0Y5piyfSNsoWpju1wiq+glYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnbtGZjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnbtGZjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB829C2BCB8;
	Sun, 10 May 2026 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398876;
	bh=0azDLewswXg+tFhZjYsCaYQYMTyckf+GbVshyn1sOh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnbtGZjVOwBT5BwQ4670Kr86Qc94AR5WcgT7EuNMOQRP/ZeF9iRgjx4/eIttZPfUS
	 ns8NKMNPROVl5a/OA9vVEtq96P+jkr+lpv15YBfgjh+PVIeyP2u7J8ATEtbHM8Kmej
	 bzdQ6Mm76dFEtHhBw69Q9H/yJkWPv+/5p2G22eJG0UOvOLn+9R76b3b7zu7f36GvPy
	 GLTL5UyOw5LFE9DgGs+4g8oxR1C/dzbffz5n6iDFWzXSPZQ8B5uQNPqPcVvxYIgyx5
	 XtgqBxYABB4LPJjYKmqqkRFGZgf+XXvH0ilfz3mVY4slr+JcCnEe2GAvrMOkDaItOO
	 YqCS3y49rrp4w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched_ext: Cleanups in preparation for the SCX_TASK_INIT_BEGIN/DEAD work
Date: Sat,  9 May 2026 21:41:08 -1000
Message-ID: <20260510074113.2049514-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510074113.2049514-1-tj@kernel.org>
References: <20260510074113.2049514-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanups in preparation for the state-machine work that follows:

- Convert three sub-sched call sites that open-code
  rcu_assign_pointer(p->scx.sched, ...) to scx_set_task_sched().

- Move scx_get_task_state()/scx_set_task_state() above the SCX task iter
  section so scx_task_iter_next_locked() can use them without a forward
  declaration.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 76 +++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df305712a2d4..10c6e0261f11 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -711,6 +711,41 @@ struct bpf_iter_scx_dsq {
 } __attribute__((aligned(8)));
 
 
+static u32 scx_get_task_state(const struct task_struct *p)
+{
+	return p->scx.flags & SCX_TASK_STATE_MASK;
+}
+
+static void scx_set_task_state(struct task_struct *p, u32 state)
+{
+	u32 prev_state = scx_get_task_state(p);
+	bool warn = false;
+
+	switch (state) {
+	case SCX_TASK_NONE:
+		break;
+	case SCX_TASK_INIT:
+		warn = prev_state != SCX_TASK_NONE;
+		break;
+	case SCX_TASK_READY:
+		warn = prev_state == SCX_TASK_NONE;
+		break;
+	case SCX_TASK_ENABLED:
+		warn = prev_state != SCX_TASK_READY;
+		break;
+	default:
+		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
+			  prev_state, state, p->comm, p->pid);
+		return;
+	}
+
+	WARN_ONCE(warn, "sched_ext: Invalid task state transition 0x%x -> 0x%x for %s[%d]",
+		  prev_state, state, p->comm, p->pid);
+
+	p->scx.flags &= ~SCX_TASK_STATE_MASK;
+	p->scx.flags |= state;
+}
+
 /*
  * SCX task iterator.
  */
@@ -3499,41 +3534,6 @@ static struct cgroup *tg_cgrp(struct task_group *tg)
 
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
-static u32 scx_get_task_state(const struct task_struct *p)
-{
-	return p->scx.flags & SCX_TASK_STATE_MASK;
-}
-
-static void scx_set_task_state(struct task_struct *p, u32 state)
-{
-	u32 prev_state = scx_get_task_state(p);
-	bool warn = false;
-
-	switch (state) {
-	case SCX_TASK_NONE:
-		break;
-	case SCX_TASK_INIT:
-		warn = prev_state != SCX_TASK_NONE;
-		break;
-	case SCX_TASK_READY:
-		warn = prev_state == SCX_TASK_NONE;
-		break;
-	case SCX_TASK_ENABLED:
-		warn = prev_state != SCX_TASK_READY;
-		break;
-	default:
-		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
-			  prev_state, state, p->comm, p->pid);
-		return;
-	}
-
-	WARN_ONCE(warn, "sched_ext: Invalid task state transition 0x%x -> 0x%x for %s[%d]",
-		  prev_state, state, p->comm, p->pid);
-
-	p->scx.flags &= ~SCX_TASK_STATE_MASK;
-	p->scx.flags |= state;
-}
-
 static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
 	int ret;
@@ -5696,7 +5696,7 @@ static void scx_fail_parent(struct scx_sched *sch,
 
 		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			scx_disable_and_exit_task(sch, p);
-			rcu_assign_pointer(p->scx.sched, parent);
+			scx_set_task_sched(p, parent);
 		}
 	}
 	scx_task_iter_stop(&sti);
@@ -5783,7 +5783,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 			 */
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_state(p, SCX_TASK_INIT);
-			rcu_assign_pointer(p->scx.sched, parent);
+			scx_set_task_sched(p, parent);
 			scx_set_task_state(p, SCX_TASK_READY);
 			scx_enable_task(parent, p);
 		}
@@ -7212,7 +7212,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 			 * $p is now only initialized for @sch and READY, which
 			 * is what we want. Assign it to @sch and enable.
 			 */
-			rcu_assign_pointer(p->scx.sched, sch);
+			scx_set_task_sched(p, sch);
 			scx_enable_task(sch, p);
 
 			p->scx.flags &= ~SCX_TASK_SUB_INIT;
-- 
2.54.0

