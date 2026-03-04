Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39139448D;
	Wed,  4 Mar 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661694; cv=none; b=pJlcY/Ba4QR/RYbG5tgFLbJo32X0lAGP2M1k/Yhtvvo4P+A6RszMtczU4sKv9E77VGSabjf7SXoPYTqQ8y4Z9TIyrOes0Yf3u/9lodKY/2DuwB52HJp/N8zMe9NunOnMg80zual4TRZcBhfROuBEfLNeszZ17co+4X8XxUx2Bqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661694; c=relaxed/simple;
	bh=dZxQtbm3OaBgjS8OWahf629wh02F8Cz6JCupgGfsK2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSu5+W5pbT3XKZpmzm1pMChm5jB3emM8bo1HO1+6Xn/JnJc1m/q3jssJoBAPMcOg/jQFMwamoCySMsLuAmj/n215FHNpmp1/SM0gMH7xMGTxklJCAuuViT+VNnaNbuF3z6D715fn+ys4uqU/La5en7UJVgcnXvEAGXTlXSzNeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BALFtlHw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BALFtlHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18993C4CEF7;
	Wed,  4 Mar 2026 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661694;
	bh=dZxQtbm3OaBgjS8OWahf629wh02F8Cz6JCupgGfsK2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BALFtlHwgy4PPoAoQpKOyAI4PCmbwPwbm6tYkF7vPpgqLToOZ5cwTP1Wu2KfuSAdE
	 Gf5AC7VeQQ7xbML6p9Hqx5SYrMkuRp+2wU/LcsBqXr+ewoygP0ZZUN1M5hWy7LYpsw
	 2aMLJoy/SNvyFz5hah5qCVxqjGg+l4DXSNz/+8X9xlxp156jRyq0kjpPxrL0zTe4R7
	 KDYcK0d08rFGN9Hp1qYCxmXQthWF40ph2Wm6VlPeeAOhlyhLyqNnkdmZgAhvFGFQwy
	 v/3AH5R1sXTaAyUZc463T9DZAY8ZTtqQ4DALJBVIIo4c5yuJ+FIjw2YJxKBJRM4/Er
	 5ypEbRwWwzyNw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/34] sched_ext: Refactor task init/exit helpers
Date: Wed,  4 Mar 2026 12:00:58 -1000
Message-ID: <20260304220119.4095551-14-tj@kernel.org>
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

- Add the @sch parameter to scx_init_task() and drop @tg as it can be
  obtained from @p. Separate out __scx_init_task() which does everything
  except for the task state transition.

- Add the @sch parameter to scx_enable_task(). Separate out
  __scx_enable_task() which does everything except for the task state
  transition.

- Add the @sch parameter to scx_disable_task().

- Rename scx_exit_task() to scx_disable_and_exit_task() and separate out
  __scx_disable_and_exit_task() which does everything except for the task
  state transition.

While some task state transitions are relocated, no meaningful behavior
changes are expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 68 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 349f94864e51..4280b639a6e0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3111,16 +3111,15 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
 }
 
-static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork)
+static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
-	struct scx_sched *sch = scx_root;
 	int ret;
 
 	p->scx.disallow = false;
 
 	if (SCX_HAS_OP(sch, init_task)) {
 		struct scx_init_task_args args = {
-			SCX_INIT_TASK_ARGS_CGROUP(tg)
+			SCX_INIT_TASK_ARGS_CGROUP(task_group(p))
 			.fork = fork,
 		};
 
@@ -3132,8 +3131,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	scx_set_task_state(p, SCX_TASK_INIT);
-
 	if (p->scx.disallow) {
 		if (unlikely(scx_parent(sch))) {
 			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
@@ -3163,13 +3160,27 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 	return 0;
 }
 
-static void scx_enable_task(struct task_struct *p)
+static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
+{
+	int ret;
+
+	ret = __scx_init_task(sch, p, fork);
+	if (!ret) {
+		/*
+		 * While @p's rq is not locked. @p is not visible to the rest of
+		 * SCX yet and it's safe to update the flags and state.
+		 */
+		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+		scx_set_task_state(p, SCX_TASK_INIT);
+	}
+	return ret;
+}
+
+static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 	u32 weight;
 
@@ -3195,16 +3206,20 @@ static void scx_enable_task(struct task_struct *p)
 
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
-	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
 				 p, p->scx.weight);
 }
 
-static void scx_disable_task(struct task_struct *p)
+static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
+{
+	__scx_enable_task(sch, p);
+	scx_set_task_state(p, SCX_TASK_ENABLED);
+}
+
+static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
@@ -3222,9 +3237,9 @@ static void scx_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
 
-static void scx_exit_task(struct task_struct *p)
+static void __scx_disable_and_exit_task(struct scx_sched *sch,
+					struct task_struct *p)
 {
-	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
@@ -3241,7 +3256,7 @@ static void scx_exit_task(struct task_struct *p)
 	case SCX_TASK_READY:
 		break;
 	case SCX_TASK_ENABLED:
-		scx_disable_task(p);
+		scx_disable_task(sch, p);
 		break;
 	default:
 		WARN_ON_ONCE(true);
@@ -3251,6 +3266,13 @@ static void scx_exit_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, exit_task))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
 				 p, &args);
+}
+
+static void scx_disable_and_exit_task(struct scx_sched *sch,
+				      struct task_struct *p)
+{
+	__scx_disable_and_exit_task(sch, p);
+
 	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
@@ -3286,7 +3308,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(p, task_group(p), true);
+		ret = scx_init_task(scx_root, p, true);
 		if (!ret)
 			scx_set_task_sched(p, scx_root);
 		return ret;
@@ -3310,7 +3332,7 @@ void scx_post_fork(struct task_struct *p)
 			struct rq *rq;
 
 			rq = task_rq_lock(p, &rf);
-			scx_enable_task(p);
+			scx_enable_task(scx_task_sched(p), p);
 			task_rq_unlock(rq, p, &rf);
 		}
 	}
@@ -3330,7 +3352,7 @@ void scx_cancel_fork(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 
@@ -3389,7 +3411,7 @@ void sched_ext_dead(struct task_struct *p)
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
@@ -3421,7 +3443,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	if (task_dead_and_done(p))
 		return;
 
-	scx_enable_task(p);
+	scx_enable_task(sch, p);
 
 	/*
 	 * set_cpus_allowed_scx() is not called while @p is associated with a
@@ -3437,7 +3459,7 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	if (task_dead_and_done(p))
 		return;
 
-	scx_disable_task(p);
+	scx_disable_task(scx_task_sched(p), p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
@@ -4681,7 +4703,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/*
 	 * Shut down cgroup support before tasks so that the cgroup attach path
-	 * doesn't race against scx_exit_task().
+	 * doesn't race against scx_disable_and_exit_task().
 	 */
 	scx_cgroup_lock();
 	scx_cgroup_exit(sch);
@@ -4710,7 +4732,7 @@ static void scx_root_disable(struct scx_sched *sch)
 			p->sched_class = new_class;
 		}
 
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 	}
 	scx_task_iter_stop(&sti);
 
@@ -5595,7 +5617,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		scx_task_iter_unlock(&sti);
 
-		ret = scx_init_task(p, task_group(p), false);
+		ret = scx_init_task(sch, p, false);
 		if (ret) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
-- 
2.53.0

