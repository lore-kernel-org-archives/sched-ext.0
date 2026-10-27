Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110130;
	b=04PAXK+KpRw7NLdfb6G5C5J7zNCh38QQa/dRPyDopXli+3J4xpf7n5mu/GpIXbaMOL34
	 8bgzG245JWtiDtcQat165DqVHd45L0cjF1xI9Wb0Ma6ggEUKSl2smCYG8uRvYGRzNnmsz
	 nBG6mqYUvqtZyy6a+BW2wN5+FjV8ETp/d7busc1I9ivXDpTlQkTnpfIPPNmd+MRTfMhw6
	 Wmz/3Q8s+GpT5PJVkOyBqtX/hv0bk7K3v2ZgSrASzqAfJFkqiSa7dWtbjekn/tDIWIBVO
	 EavntFdgFhDDQpSx2lsX9y1XwQJtdYH/vJSvNkOKgWve5Ot1NscCa9QU/p89sIgmWTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cOUNxOkSiHz1UCe8MVMbaOdkOf4/O9eR04u47GsA7QY=;
	b=BvMmllqXguQ27EhczGAzcmnhXRBnJVm6Ul/crjfSnYaT0KJYDwLSCuXxPNde17Tr7L0F
	 E43DIgDHQTB48umROiLguXTbCdDSZNQTvXvT8rF+pvMO1Egu+A3ukorXMKFtssHfeoPW0
	 NwjCxVeghnfVNyHaEKtDNe2n154GaOXS3tn/zNHHovxDelQiwbxx4vhcNPoOqe1KcMyc4
	 S3tJ7Yrz2cQ4ieDcskOFprfoWd6Axmu2YhYZEPcMv23ev5nozAfZiWF2AUECXfVFHv3dw
	 ICO+aoNo7Rp+MuSw/4PMeT/IrXTzAMHPr3z4dAQ36wsiF16QKM0wfFfrfXs1jhKQeoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEIji5oT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C775606A337;
	Tue, 27 Oct 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEIji5oT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A4F1F031E3;
	Tue, 27 Oct 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110129;
	bh=cOUNxOkSiHz1UCe8MVMbaOdkOf4/O9eR04u47GsA7QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEIji5oTloCbrt8InyF+KOb4NeVovMN988PPlvWaeQ4KW5z3/xgJxSqeXokh97UwO
	 IrePtV6zHNGnrDuecld3aflDlhZx8sv4ziUza+0SkoVCiPYeBh5ZL9Q8Mpk4TXTIvq
	 eXos5vYji3WPwQdY5Dvq3NiVIhjyE6aH1dCghC1kocacYupKWNYri9lOkUMf0J8mWE
	 Fx13Pu9DczRuszty7h0Ai/I8qh7A0kwDcOrYh7cT7WFQx0GThKETAevX+k2iOiVE/A
	 r42VNaQgNixhWMJkh4i/clbrjzzaMdl+rexcvCKPwCrktAz5TLrd9scLgvnm+J/Sv+
	 k1U1SYds3CuUA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 19/18] sched_ext: Fix use-after-free of a NONE rescuee leaving its sched while running
Date: Tue, 27 Oct 2026 04:08:47 -1000
Message-ID: <20261027140848.2280121-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since an earlier patch sends a bypassed task to rescue when its host lacks
SCX_CAP_BASE, a task scx_fail_parent() punted to its bypassing parent at
NONE can be a rescuee.

When a cgroup migration into a root-owned cgroup re-homes it while running,
nothing resets it: the DEQUEUE_SAVE dequeue and put_prev_task_scx() keep a
running task's slice, and __scx_disable_and_exit_task() skips a NONE task.

rq->scx.rescue.curr keeps pointing at the task, now on the root. An RT task,
for example, can keep the task from serving its grant until the last sub is
freed. From then on scx_rescuee() returns NULL and the rescue never ends.
scx_rescue_timerfn() keeps accessing the task after it is freed.

Move the reset out of scx_disable_task() into scx_reset_task_fields() and
call it on every path that takes a task out of its sched's control, the exit
of a NONE task included.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 66 +++++++++++++++++++++++++++---------------
 kernel/sched/ext/sub.c |  4 +--
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b7a78be01b42..afcbe8f06de6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2511,8 +2511,9 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	/*
 	 * Don't reset runnable_at. If @p is waiting, the wait continues across
 	 * temporary dequeues, e.g. for a migration or an attribute change.
-	 * scx_disable_task() ends it if @p leaves its scheduler. scx_bypass()
-	 * restarts it when its requeue can change the sched running @p.
+	 * scx_reset_task_fields() ends it if @p leaves its sched's control.
+	 * scx_bypass() restarts it when its requeue can change the sched
+	 * running @p.
 	 */
 	clr_task_runnable(p, false);
 
@@ -4657,23 +4658,20 @@ void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 }
 
-static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
+/**
+ * scx_reset_task_fields - Reset what @p carries from its sched's control
+ * @rq: @p's rq, locked
+ * @p: task leaving its sched's control
+ *
+ * The vtime, the slice and what rides on it, the reenqueue count and the
+ * watchdog wait belong to the sched while it controls @p. The control ends when
+ * @p is taken off the sched or leaves the ext class while staying on the sched.
+ * Reset them so that @p starts clean wherever it goes.
+ */
+static void scx_reset_task_fields(struct rq *rq, struct task_struct *p)
 {
-	struct rq *rq = task_rq(p);
-
 	lockdep_assert_rq_held(rq);
-	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
-
-	clear_direct_dispatch(p);
 
-	if (SCX_HAS_OP(sch, disable))
-		SCX_CALL_OP_TASK(sch, disable, rq, p);
-	scx_set_task_state(p, SCX_TASK_READY);
-
-	/*
-	 * Reset the SCX-managed fields when @p leaves the BPF scheduler's
-	 * control, after ops.disable() has observed their final values.
-	 */
 	p->scx.dsq_vtime = 0;
 	scx_task_slice_ended(rq, p);
 	scx_set_task_slice(p, 0);
@@ -4681,11 +4679,25 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 
 	/*
 	 * If @p is runnable but not running, its wait started at runnable_at,
-	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
-	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
-	 * doesn't count the time @p spends elsewhere.
+	 * which ops_dequeue() didn't reset. Leaving the sched's control ends
+	 * the wait. Reset runnable_at the next time @p is enqueued on SCX, so
+	 * that the watchdog doesn't count the time @p spends elsewhere.
 	 */
 	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+}
+
+static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
+{
+	struct rq *rq = task_rq(p);
+
+	lockdep_assert_rq_held(rq);
+	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
+
+	clear_direct_dispatch(p);
+
+	if (SCX_HAS_OP(sch, disable))
+		SCX_CALL_OP_TASK(sch, disable, rq, p);
+	scx_set_task_state(p, SCX_TASK_READY);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -4706,6 +4718,11 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 
 	switch (scx_get_task_state(p)) {
 	case SCX_TASK_NONE:
+		/*
+		 * No op to call, but @p may still carry @sch's state, e.g. a
+		 * task punted by scx_fail_parent() and being rescued.
+		 */
+		scx_reset_task_fields(task_rq(p), p);
 		return;
 	case SCX_TASK_INIT:
 		args.cancelled = true;
@@ -4714,6 +4731,8 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
+		/* after ops.disable() has seen the final values */
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	default:
 		WARN_ON_ONCE(true);
@@ -5022,13 +5041,12 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
 	 * NONE -> READY validation failure.
 	 *
-	 * @p can still be a rescuee under the parent. End its slice as
-	 * scx_disable_task() does for an enabled task.
+	 * Either way, reset @p after ops.disable() has seen the final values. A
+	 * %NONE @p can still be a rescuee under the parent.
 	 */
-	if (scx_get_task_state(p) == SCX_TASK_NONE)
-		scx_task_slice_ended(rq, p);
-	else
+	if (scx_get_task_state(p) != SCX_TASK_NONE)
 		scx_disable_task(scx_task_sched(p), p);
+	scx_reset_task_fields(rq, p);
 }
 
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index ecab82ca5e82..e0aed3ce9735 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1666,8 +1666,8 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
  * Used when @to must take over @p but failed to initialize it. Bypass keeps
  * scheduling decisions away from @to but @p can still trigger its task ops,
  * which may confuse the BPF side. @to is dying anyway. The exit paths call no
- * op on a %NONE task. __scx_disable_and_exit_task() skips it and
- * switched_from_scx() only ends its slice.
+ * op on a %NONE task. __scx_disable_and_exit_task() and switched_from_scx()
+ * only reset its fields, see scx_reset_task_fields().
  */
 static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 {
-- 
2.56.0

