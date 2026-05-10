Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0C309EFF;
	Sun, 10 May 2026 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778443490; cv=none; b=JqM5y6U3aAShJ1U3c/1uaYX6lWeu93PMkadFVfQK5Jd6oWC/E5tZPJ8XScQBz1u0LNLkIJAQeJKCc5ZfjaLMj+fHSevWO4g7WT1kFKYvUb+DZ718oie6yqSPpNYkJr0LwIFofLCPRHpnh2u0V5IcpDkeMltE5dXjf60zvZBz4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778443490; c=relaxed/simple;
	bh=GYRDMX2SF76afM3g6C9vn7LUXD54k2rlanlHA6wIIqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab2q8tuDqojVqFOV+vkF5EHMnNR9a8EMjJB705Ldl+kDFOcUDw7s3LtTJW0Hl/AqgKHKfhCmgtPMuTwRvrFq5UPv9Qt7dL4hxfJ+MiSgX8ZxnnLfhn142N7ziJBoO8mGDHnSptjbvxKaD/Y1slrTNRov441fEdT7TZKK9thrl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4DvD7Ga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4DvD7Ga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF1C2BCB8;
	Sun, 10 May 2026 20:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778443489;
	bh=GYRDMX2SF76afM3g6C9vn7LUXD54k2rlanlHA6wIIqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4DvD7Ga1HxCyU3d4gokKPRCI30OorIHRbaBXMtcTiF7dfnAFkKPDRn8hAMZ7v+TD
	 IxSB/dUZL+ZGeO0Nc852KC3lYEDdN4r/EQKZA1b2BL9biON69oBGLmp5u1lBb3rdKD
	 WVdZdBp/d2wksTkACvpztwg6p++ceR4hjUa5wpnQxdxww8WUB5V6z5zYMzYRfynRbA
	 4NFWjAtiECzOOOMg/v1/aGh84KycK/oRSoe7cfkrOK4y8V2QMO1iI240r27a9Sqnj9
	 +YwU7lVWpxBjCdhYqfb22M2e7rvTwYSOf1lVVZRohf28j5RF7ygy0Y28y0r0TuftjO
	 3WONjqgnUgCtQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 2/6] sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_task_state()
Date: Sun, 10 May 2026 10:04:48 -1000
Message-ID: <20260510200448.2471037-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510074113.2049514-3-tj@kernel.org>
References: <20260510074113.2049514-1-tj@kernel.org> <20260510074113.2049514-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the SCX_TASK_INIT_BEGIN/DEAD work that follows by collapsing the
scx_init_task() helper. Move the SCX_TASK_RESET_RUNNABLE_AT setting into
scx_set_task_state() on the INIT transition (it was set unconditionally at
every INIT site through the scx_init_task() helper), inline scx_init_task()
into scx_fork() and scx_root_enable_workfn(), and drop the helper.

As a side effect, scx_sub_disable() migration sequence now also sets
RESET_RUNNABLE_AT (it previously wrote INIT directly without going through
scx_init_task()). The flag triggers a runnable_at reset on the next
set_task_runnable(), which is harmless on a task that has just been moved
between scheds.

On root-enable, p->scx.flags is written without the task's rq lock. The task
isn't visible to scx yet, and a follow-up patch restores the lock-held
write.

v2: Note p->scx.flags rq-lock relaxation on root-enable path. (Andrea)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 10c6e0261f11..81841277a54f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -726,6 +726,7 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
 		break;
 	case SCX_TASK_INIT:
 		warn = prev_state != SCX_TASK_NONE;
+		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 		break;
 	case SCX_TASK_READY:
 		warn = prev_state == SCX_TASK_NONE;
@@ -3585,22 +3586,6 @@ static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fo
 	return 0;
 }
 
-static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
-{
-	int ret;
-
-	ret = __scx_init_task(sch, p, fork);
-	if (!ret) {
-		/*
-		 * While @p's rq is not locked. @p is not visible to the rest of
-		 * SCX yet and it's safe to update the flags and state.
-		 */
-		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
-		scx_set_task_state(p, SCX_TASK_INIT);
-	}
-	return ret;
-}
-
 static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 {
 	struct rq *rq = task_rq(p);
@@ -3763,10 +3748,11 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 #else
 		struct scx_sched *sch = scx_root;
 #endif
-		ret = scx_init_task(sch, p, true);
-		if (!ret)
-			scx_set_task_sched(p, sch);
-		return ret;
+		ret = __scx_init_task(sch, p, true);
+		if (unlikely(ret))
+			return ret;
+		scx_set_task_state(p, SCX_TASK_INIT);
+		scx_set_task_sched(p, sch);
 	}
 
 	return 0;
@@ -6897,8 +6883,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		scx_task_iter_unlock(&sti);
 
-		ret = scx_init_task(sch, p, false);
-		if (ret) {
+		ret = __scx_init_task(sch, p, false);
+		if (unlikely(ret)) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
@@ -6906,6 +6892,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			goto err_disable_unlock_all;
 		}
 
+		scx_set_task_state(p, SCX_TASK_INIT);
 		scx_set_task_sched(p, sch);
 		scx_set_task_state(p, SCX_TASK_READY);
 
-- 
2.54.0

