Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565A3FE379;
	Fri, 24 Apr 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063464; cv=none; b=dg6hxPnD+PEMd8OE5ewWGiAyb1H3Iuo3Mg9WJuSDo7SGHW/hRXF10Cy1ANWS7tABiJ/KBZlz8K7F6eehBkSzUsd1JUWZlglHZIukmQ1J11fgmx8zhpJCsV9hu3cpdQKRF3hZoVIA1sL1wFi+uziZBoumbiSNZI6uo77i87buhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063464; c=relaxed/simple;
	bh=0D2MMMg3pyoIPMBdiUlJT69y/M9Jl2H6hssqRRfxZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K03OZGPOJCIiMA/jR+9lZCLPP/EPtEaCoC8VNtFKekS5QhF7Tq8Y73L37br6jreiNnomPHBE3A4G+H7ccHdpilaPLyVCg9L7oAXgp9K8RfebFsnCpznbV/SitnYH+breU5/EfFAj7ymtd+KuUgM8YPNdgnXUME9/qE1mUYaKwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdRDUqGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdRDUqGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1510C19425;
	Fri, 24 Apr 2026 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063464;
	bh=0D2MMMg3pyoIPMBdiUlJT69y/M9Jl2H6hssqRRfxZOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdRDUqGmEHeY1s6HSzNZs76SjgzkZCuGw1B0SX2ldadPbDi7kMysUI60hCizFnSyU
	 ER9u1c+X8YvXrK/541jcCPystw02VsJhSCmdjUnB79FHqZYMv/ok2329pALen4VPih
	 hzU8Jk8lfoD48CE8vquUdzcXaP9dwbP93XvMMGi8XMGuu1NqbaJUZyIoVSBery9UEA
	 D8PAlE+Hbu6nRi8OnJN00Nc6UHrdkBZhWlrWpXXj1EkdvlHEutFnpV+Ehcz/sQVqqe
	 g5OWjDjX5xx2WJ6f3D3/LCjAOZVg9oMpFy7AX2R2u5zAXzTQcLLhTZ5sN1F5ItH123
	 jX7/3ToQxxTyQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/13] sched_ext: Don't disable tasks in scx_sub_enable_workfn() abort path
Date: Fri, 24 Apr 2026 10:44:09 -1000
Message-ID: <20260424204418.3809733-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_sub_enable_workfn()'s prep loop calls __scx_init_task(sch, p, false)
without transitioning task state, then sets SCX_TASK_SUB_INIT. If prep fails
partway, the abort path runs __scx_disable_and_exit_task(sch, p) on the
marked tasks. Task state is still the parent's ENABLED, so that dispatches
to the SCX_TASK_ENABLED arm and calls scx_disable_task(sch, p) - i.e.
child->ops.disable() - for tasks on which child->ops.enable() never ran. A
BPF sub-scheduler allocating per-task state in enable/freeing in disable
would operate on uninitialized state.

The dying-task branch in scx_disable_and_exit_task() has the same problem,
and scx_enabling_sub_sched was cleared before the abort cleanup loop - a
task exiting during cleanup tripped the WARN and skipped both ops.exit_task
and the SCX_TASK_SUB_INIT clear, leaking per-task resources and leaving the
task stuck.

Introduce scx_sub_init_cancel_task() that calls ops.exit_task with
cancelled=true - matching what the top-level init path does when init_task
itself returns -errno. Use it in the abort loop and in the dying-task
branch. scx_enabling_sub_sched now stays set until the abort loop finishes
clearing SUB_INIT, so concurrent exits hitting the dying-task branch can
still find @sch. That branch also clears SCX_TASK_SUB_INIT unconditionally
when seen, leaving the task unmarked even if the WARN fires.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62b4139a4cc8..f7cca6f07a58 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3633,6 +3633,22 @@ static void __scx_disable_and_exit_task(struct scx_sched *sch,
 		SCX_CALL_OP_TASK(sch, exit_task, task_rq(p), p, &args);
 }
 
+/*
+ * Undo a completed __scx_init_task(sch, p, false) when scx_enable_task() never
+ * ran. The task state has not been transitioned, so this mirrors the
+ * SCX_TASK_INIT branch in __scx_disable_and_exit_task().
+ */
+static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *p)
+{
+	struct scx_exit_task_args args = { .cancelled = true };
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	if (SCX_HAS_OP(sch, exit_task))
+		SCX_CALL_OP_TASK(sch, exit_task, task_rq(p), p, &args);
+}
+
 static void scx_disable_and_exit_task(struct scx_sched *sch,
 				      struct task_struct *p)
 {
@@ -3641,11 +3657,12 @@ static void scx_disable_and_exit_task(struct scx_sched *sch,
 	/*
 	 * If set, @p exited between __scx_init_task() and scx_enable_task() in
 	 * scx_sub_enable() and is initialized for both the associated sched and
-	 * its parent. Disable and exit for the child too.
+	 * its parent. Exit for the child too - scx_enable_task() never ran for
+	 * it, so undo only init_task.
 	 */
-	if ((p->scx.flags & SCX_TASK_SUB_INIT) &&
-	    !WARN_ON_ONCE(!scx_enabling_sub_sched)) {
-		__scx_disable_and_exit_task(scx_enabling_sub_sched, p);
+	if (p->scx.flags & SCX_TASK_SUB_INIT) {
+		if (!WARN_ON_ONCE(!scx_enabling_sub_sched))
+			scx_sub_init_cancel_task(scx_enabling_sub_sched, p);
 		p->scx.flags &= ~SCX_TASK_SUB_INIT;
 	}
 
@@ -7103,16 +7120,23 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 abort:
 	put_task_struct(p);
 	scx_task_iter_stop(&sti);
-	scx_enabling_sub_sched = NULL;
 
+	/*
+	 * Undo __scx_init_task() for tasks we marked. scx_enable_task() never
+	 * ran for @sch on them, so calling scx_disable_task() here would invoke
+	 * ops.disable() without a matching ops.enable(). scx_enabling_sub_sched
+	 * must stay set until SUB_INIT is cleared from every marked task -
+	 * scx_disable_and_exit_task() reads it when a task exits concurrently.
+	 */
 	scx_task_iter_start(&sti, sch->cgrp);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		if (p->scx.flags & SCX_TASK_SUB_INIT) {
-			__scx_disable_and_exit_task(sch, p);
+			scx_sub_init_cancel_task(sch, p);
 			p->scx.flags &= ~SCX_TASK_SUB_INIT;
 		}
 	}
 	scx_task_iter_stop(&sti);
+	scx_enabling_sub_sched = NULL;
 err_unlock_and_disable:
 	/* we'll soon enter disable path, keep bypass on */
 	scx_cgroup_unlock();
-- 
2.53.0

