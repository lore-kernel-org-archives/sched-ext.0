Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E476368942;
	Sun, 10 May 2026 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398877; cv=none; b=Vug7Qi5UW6zs6nrEyHHI0JJ6AZ+Lwn7HPUYfjCRx4xiABC3RuxZ3yvpT4lnZV7LqyT3MY4up9SNaQ9nIGN1X6o8J/pwkFEV9UxJV4oPLihlLA78q5aFcuUrTipdaw27wGMXavNHbYl3bRShzCRM87iifuLBMdR+2E5JnBJVu63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398877; c=relaxed/simple;
	bh=Mk411gmxci8x3iMx7O9qLb96PJtO4xfemtOQqpNzE78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca2G5hVtcBhg2SqN46+OG6/pz+rW7JHPu6yIQUBazpACRe/CYrO3gI2WdxeKQAjsXRuhdStNB7JcgyaNvP+jkivy5+9iGi66aswDwbOt3UDZIIsmHkMEtzcYQ3AyMoLXJ/hmb3IRFQmNrJ5qfaGIA6KDpptDVohNrehyCUQyGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbwlrShF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbwlrShF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D14C2BCFA;
	Sun, 10 May 2026 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398877;
	bh=Mk411gmxci8x3iMx7O9qLb96PJtO4xfemtOQqpNzE78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbwlrShFbLPTZKL78G6m4i0JBHSKF2P/3qp9XqH+yAMlj8RXqnleOs0Hdl6GFZ5/e
	 BV/cL6+A02OqGB+ZYIHBfDGdJeb2H+eI2fj0sinORnQwejjY7XFUhxsY45vEJ2kTn7
	 Oy3IJHy5lyFFLblZYcZsHPKymjSchBa/ixxlzcWVTyiCGfiFTGrKXnsRcRSErMWZzy
	 fZZzq1UzbLvhpuLisvW4l8xEe0GlDTuJFFJjQ2ES53+xSWiTu8r0G6pQCk+LEnhm0S
	 rv2vh5ThwMX0yZIpK43Nvms+OkQgPB7gJBGXSRokRTCDkYw7vA9efoLge7o0syJIfa
	 9q5hzFE/13zag==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_task_state()
Date: Sat,  9 May 2026 21:41:09 -1000
Message-ID: <20260510074113.2049514-3-tj@kernel.org>
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

