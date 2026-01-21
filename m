Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC984534BE;
	Wed, 21 Jan 2026 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037115; cv=none; b=cWH2xBXzRe0/1+AIG/y39u1L2R2uZ35vrwgMf6ZqexXsZ8WQzzs6hyJTblle1Qu0fZTUKnaD/lZHz02VjoKyBJLRdF1MuYWYy9MEALGRzesZXKKvlSzs7T6bpVfcbaPT884Akgifkuf0jzsaeAlVvK15dfEfBBlq90dWg5OF9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037115; c=relaxed/simple;
	bh=Z3y19F6fI9KHCp1/Vo5Gdy7VEMVR9Cl/kby8qMzcq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa+k4nd3S1qQr+snN738fpqPm8KHbegYPnphiqX/L1CyE/CceGZ3R4R3xtCgREsYR+PTn94UPrwrqc+3GDsnIGMBQPr0UJXXUltwbHN21ZhIAWg3/Diuuu8RG/YX6s4DtlHkmTGsvF2oKdueFVNA67ZcyfbfcrCwTzBG9VpYjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqQNrtTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqQNrtTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A0DC4CEF1;
	Wed, 21 Jan 2026 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037115;
	bh=Z3y19F6fI9KHCp1/Vo5Gdy7VEMVR9Cl/kby8qMzcq4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqQNrtTFHBMxbgH2VXis/Pp4euGOSJMlWxTSMBz5mjlaUjb83SNuBxkoSTxVDTDz/
	 SCJ5phDoMsU9Pi+T7ZSsez+28JpB/vuNWERVPwYBXLsjIMhNF207anSn79RUV8GEIX
	 U4M73PxseAgYnBZtZB2G7VZQkFxc2SdA8njhvDzXpKMJFVqBLnvilr/GX0GpT/aEVO
	 DQMDtqHP/d/eYjbcXPieLbdu5HzxjPFg8B/mtUVQCTUxJGMa9gCblO1vUJFFuk/j8k
	 l66TgFcdeLOfhN4UHxwh7VXjOdPBoizzoM9CV1+/ZkPY9kGnVlIzuPeZuF1FiT1HRz
	 Z9p3HTLfOr4mg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/34] sched_ext: Refactor task init/exit helpers
Date: Wed, 21 Jan 2026 13:11:19 -1000
Message-ID: <20260121231140.832332-14-tj@kernel.org>
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
 kernel/sched/ext.c | 67 +++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 07cd130f62fb..a834da7701df 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2987,9 +2987,9 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
 }
 
-static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork)
+static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
-	struct scx_sched *sch = scx_root;
+	struct task_group *tg = task_group(p);
 	int ret;
 
 	p->scx.disallow = false;
@@ -3008,8 +3008,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	scx_set_task_state(p, SCX_TASK_INIT);
-
 	if (p->scx.disallow) {
 		if (unlikely(scx_parent(sch))) {
 			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
@@ -3039,13 +3037,27 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
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
 
@@ -3064,16 +3076,20 @@ static void scx_enable_task(struct task_struct *p)
 
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
@@ -3084,9 +3100,9 @@ static void scx_disable_task(struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_READY);
 }
 
-static void scx_exit_task(struct task_struct *p)
+static void __scx_disable_and_exit_task(struct scx_sched *sch,
+					struct task_struct *p)
 {
-	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
@@ -3103,7 +3119,7 @@ static void scx_exit_task(struct task_struct *p)
 	case SCX_TASK_READY:
 		break;
 	case SCX_TASK_ENABLED:
-		scx_disable_task(p);
+		scx_disable_task(sch, p);
 		break;
 	default:
 		WARN_ON_ONCE(true);
@@ -3113,6 +3129,13 @@ static void scx_exit_task(struct task_struct *p)
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
@@ -3148,7 +3171,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(p, task_group(p), true);
+		ret = scx_init_task(scx_root, p, true);
 		if (!ret)
 			scx_set_task_sched(p, scx_root);
 		return ret;
@@ -3172,7 +3195,7 @@ void scx_post_fork(struct task_struct *p)
 			struct rq *rq;
 
 			rq = task_rq_lock(p, &rf);
-			scx_enable_task(p);
+			scx_enable_task(scx_task_sched(p), p);
 			task_rq_unlock(rq, p, &rf);
 		}
 	}
@@ -3192,7 +3215,7 @@ void scx_cancel_fork(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 
@@ -3216,7 +3239,7 @@ void sched_ext_dead(struct task_struct *p)
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
@@ -3242,7 +3265,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
-	scx_enable_task(p);
+	scx_enable_task(sch, p);
 
 	/*
 	 * set_cpus_allowed_scx() is not called while @p is associated with a
@@ -3255,7 +3278,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
-	scx_disable_task(p);
+	scx_disable_task(scx_task_sched(p), p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -4485,7 +4508,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/*
 	 * Shut down cgroup support before tasks so that the cgroup attach path
-	 * doesn't race against scx_exit_task().
+	 * doesn't race against scx_disable_and_exit_task().
 	 */
 	scx_cgroup_lock();
 	scx_cgroup_exit(sch);
@@ -4514,7 +4537,7 @@ static void scx_root_disable(struct scx_sched *sch)
 			p->sched_class = new_class;
 		}
 
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 	}
 	scx_task_iter_stop(&sti);
 
@@ -5379,7 +5402,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		scx_task_iter_unlock(&sti);
 
-		ret = scx_init_task(p, task_group(p), false);
+		ret = scx_init_task(sch, p, false);
 		if (ret) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
-- 
2.52.0

