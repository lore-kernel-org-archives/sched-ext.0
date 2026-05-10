Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF536A02C;
	Sun, 10 May 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398879; cv=none; b=pxYDJ2fdhGVOasxJ1UsUwew+E32RR+Hf2Ys1zYxeuuYq3qjTkPWzn8gKsuCTJk9KhJnCLn4PPTq/ctUTrQi0+/fUypAqxRnf/f8nlZ65ZV39t+Xihy4NSXuT89KhM3JPWKgDMsFO+2fKJDvZEkrB0fVJ4VJcX67nH1qgBo7Yp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398879; c=relaxed/simple;
	bh=BcUlhzwhZ3V7iPCvM8YvuPLuBVp8mcsPjWuK/ChcHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFa7ROj7scjYyXMsTYoJP8e1DXuQABKRZXlVG8FrgIOHhcGbpezbavN+VBg+DM9+IX0Z8fyre4ZFsbmeNKh6DU1VcJ6w1eNsDc4zBMGCJr09ivbxcqslQczOthOGbPJ7A3b4YU/RRmdWdCIaCYXJqTFoMh8nPi3SgVv1dQ3RsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjz/Vi4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjz/Vi4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A040C2BCB8;
	Sun, 10 May 2026 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398879;
	bh=BcUlhzwhZ3V7iPCvM8YvuPLuBVp8mcsPjWuK/ChcHWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjz/Vi4r5N4dzxgWbxI5pHPdTgKm7NItABlgKCZE1xveJEdP4uwTvi3u2fZxHmi1G
	 WvyMLsIV8oN67bQ8OLKrIbgHi5yiB0iXXYbJaJOjbdDlkf5F6Zn/37IAUZrP7NbFrT
	 7fPzoHK3kujWWJQWS2m8f7syGTOySXfoMo6E+IhXMkQM+TS63ikQzrdljzKZBTFOCR
	 Eb9j5jdU0L5aMdb/3Ylan8MCTlvxj1C9jquuQTnUCvRG1/H6EL/GTPuDMoVCvp0nt0
	 dW/rKtZ9k+gDDDE3yuqTBlvINjPkrToif3FRLelRKcVlpjOkaNYv5MyL6alQmfFK+8
	 C1JQXC4Yhh3Sg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: Close root-enable vs sched_ext_dead() race with SCX_TASK_INIT_BEGIN
Date: Sat,  9 May 2026 21:41:11 -1000
Message-ID: <20260510074113.2049514-5-tj@kernel.org>
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

scx_root_enable_workfn() drops the iter rq lock for ops.init_task() and a
TASK_DEAD @p can fall through sched_ext_dead() in that window. The race hits
when sched_ext_dead() observes SCX_TASK_INIT (the intermediate state before
@p->scx.sched is published) and dereferences NULL via SCX_HAS_OP(NULL,
exit_task), or observes SCX_TASK_NONE during the unlocked init window and
skips cleanup so exit_task() never runs.

Add SCX_TASK_INIT_BEGIN. The enable path writes NONE -> INIT_BEGIN under the
iter rq lock, then takes the rq lock again after init to walk INIT_BEGIN ->
INIT -> READY. sched_ext_dead() that wins the rq-lock race observes
INIT_BEGIN and sets DEAD without calling into ops; the post-init recheck
unwinds via scx_sub_init_cancel_task().

scx_fork() runs single-threaded against sched_ext_dead() (the task is not on
scx_tasks until scx_post_fork() adds it) so its INIT_BEGIN -> INIT walk
needs no rq-lock pairing; it rolls back to NONE on ops.init_task() failure.

The validation matrix grows the INIT_BEGIN row and the INIT_BEGIN -> DEAD
edge; INIT now requires INIT_BEGIN as the predecessor. scx_sub_disable()'s
migration writes INIT_BEGIN as a synthetic predecessor to satisfy the
tightened verification.

The sub-sched paths still race with sched_ext_dead() during the unlocked
init window. This will be fixed by the next patch.

Reported-by: zhidao su <suzhidao@xiaomi.com>
Link: https://lore.kernel.org/all/20260429133155.3825247-1-suzhidao@xiaomi.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 10 ++++---
 kernel/sched/ext.c        | 56 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9f1a326ad03e..2129e18ada58 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -106,6 +106,7 @@ enum scx_ent_flags {
 	 * Bits 8 to 10 are used to carry task state:
 	 *
 	 * NONE		ops.init_task() not called yet
+	 * INIT_BEGIN	ops.init_task() in flight; see sched_ext_dead()
 	 * INIT		ops.init_task() succeeded, but task can be cancelled
 	 * READY	fully initialized, but not in sched_ext
 	 * ENABLED	fully initialized and in sched_ext
@@ -116,10 +117,11 @@ enum scx_ent_flags {
 	SCX_TASK_STATE_MASK	= ((1 << SCX_TASK_STATE_BITS) - 1) << SCX_TASK_STATE_SHIFT,
 
 	SCX_TASK_NONE		= 0 << SCX_TASK_STATE_SHIFT,
-	SCX_TASK_INIT		= 1 << SCX_TASK_STATE_SHIFT,
-	SCX_TASK_READY		= 2 << SCX_TASK_STATE_SHIFT,
-	SCX_TASK_ENABLED	= 3 << SCX_TASK_STATE_SHIFT,
-	SCX_TASK_DEAD		= 4 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_INIT_BEGIN	= 1 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_INIT		= 2 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_READY		= 3 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_ENABLED	= 4 << SCX_TASK_STATE_SHIFT,
+	SCX_TASK_DEAD		= 5 << SCX_TASK_STATE_SHIFT,
 
 	/*
 	 * Bits 12 and 13 are used to carry reenqueue reason. In addition to
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2fc4a12711f9..29fa9ffe7c7b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -725,8 +725,11 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
 	case SCX_TASK_NONE:
 		warn = prev_state == SCX_TASK_DEAD;
 		break;
-	case SCX_TASK_INIT:
+	case SCX_TASK_INIT_BEGIN:
 		warn = prev_state != SCX_TASK_NONE;
+		break;
+	case SCX_TASK_INIT:
+		warn = prev_state != SCX_TASK_INIT_BEGIN;
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 		break;
 	case SCX_TASK_READY:
@@ -737,7 +740,8 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
 		warn = prev_state != SCX_TASK_READY;
 		break;
 	case SCX_TASK_DEAD:
-		warn = prev_state != SCX_TASK_NONE;
+		warn = !(prev_state == SCX_TASK_NONE ||
+			 prev_state == SCX_TASK_INIT_BEGIN);
 		break;
 	default:
 		WARN_ONCE(1, "sched_ext: Invalid task state %d -> %d for %s[%d]",
@@ -3753,9 +3757,12 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 #else
 		struct scx_sched *sch = scx_root;
 #endif
+		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		ret = __scx_init_task(sch, p, true);
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			scx_set_task_state(p, SCX_TASK_NONE);
 			return ret;
+		}
 		scx_set_task_state(p, SCX_TASK_INIT);
 		scx_set_task_sched(p, sch);
 	}
@@ -3856,13 +3863,18 @@ void sched_ext_dead(struct task_struct *p)
 	 * scx_task_iter_next_locked(). NONE tasks need no marking: cgroup
 	 * iteration is only used from sub-sched paths, which require root
 	 * enabled. Root enable transitions every live task to at least READY.
+	 *
+	 * %INIT_BEGIN means ops.init_task() is running for @p. Don't call
+	 * into ops; transition to %DEAD so the post-init recheck unwinds
+	 * via scx_sub_init_cancel_task().
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_disable_and_exit_task(scx_task_sched(p), p);
+		if (scx_get_task_state(p) != SCX_TASK_INIT_BEGIN)
+			scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_DEAD);
 		task_rq_unlock(rq, p, &rf);
 	}
@@ -5773,6 +5785,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 			 * $p having already been initialized, and then enable.
 			 */
 			scx_disable_and_exit_task(sch, p);
+			scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 			scx_set_task_state(p, SCX_TASK_INIT);
 			scx_set_task_sched(p, parent);
 			scx_set_task_state(p, SCX_TASK_READY);
@@ -6878,6 +6891,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		struct rq_flags rf;
+		struct rq *rq;
+
 		/*
 		 * @p may already be dead, have lost all its usages counts and
 		 * be waiting for RCU grace period before being freed. @p can't
@@ -6886,10 +6902,26 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		if (!tryget_task_struct(p))
 			continue;
 
+		/*
+		 * Set %INIT_BEGIN under the iter's rq lock so that a concurrent
+		 * sched_ext_dead() does not call ops.exit_task() on @p while
+		 * ops.init_task() is running. If sched_ext_dead() runs before
+		 * this store, it has already removed @p from scx_tasks and the
+		 * iter won't visit @p; if it runs after, it observes
+		 * %INIT_BEGIN and transitions to %DEAD without calling ops,
+		 * leaving the post-init recheck below to unwind.
+		 */
+		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_task_iter_unlock(&sti);
 
 		ret = __scx_init_task(sch, p, false);
+
+		rq = task_rq_lock(p, &rf);
+
 		if (unlikely(ret)) {
+			if (scx_get_task_state(p) != SCX_TASK_DEAD)
+				scx_set_task_state(p, SCX_TASK_NONE);
+			task_rq_unlock(rq, p, &rf);
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
@@ -6897,10 +6929,20 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			goto err_disable_unlock_all;
 		}
 
-		scx_set_task_state(p, SCX_TASK_INIT);
-		scx_set_task_sched(p, sch);
-		scx_set_task_state(p, SCX_TASK_READY);
+		if (scx_get_task_state(p) == SCX_TASK_DEAD) {
+			/*
+			 * sched_ext_dead() observed %INIT_BEGIN and set %DEAD.
+			 * ops.exit_task() is owed to the sched __scx_init_task()
+			 * ran against; call it now.
+			 */
+			scx_sub_init_cancel_task(sch, p);
+		} else {
+			scx_set_task_state(p, SCX_TASK_INIT);
+			scx_set_task_sched(p, sch);
+			scx_set_task_state(p, SCX_TASK_READY);
+		}
 
+		task_rq_unlock(rq, p, &rf);
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
-- 
2.54.0

