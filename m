Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EE49EC5E;
	Sat,  5 Sep 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624610; cv=none; b=M6Vl1j34crYHdUTnq8KRNu9zK2t1uQRLnvkbaXav6kainynUEOwaOxfTy4AZ8d810r8GDDKRfC6nFEOv7zYYnvhC9wUW2wbJUi8VHaE/j4Vm4uf0YpOHfngtyIYnBvP9hAek9qlcXi+quMcdstsyCmmuCSS2jwK7y664cTBuSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624610; c=relaxed/simple;
	bh=jBJPmNfV1l4/5KkFs+AnyjYFHHEWSzcNvlvbMnzJQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb8DbQpPz5WUMWKVq98SUqklEKXToBSanY5MTY2FlSX6/Y4Gsyt/Uww6bj7msSAw3uo0yyn60dS3B+bx32AMpG1q8SzwD4JPBIS/H1lbbonCNX2ZpJ6FcgJXEYLIG88ZK/5Lp7DaokFGK2E9JHk5FeyxcSPU5CZUDgTtfubGpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUVKu6ZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUVKu6ZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC21F00A3E;
	Sat,  5 Sep 2026 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624601;
	bh=TdCyfuU3488UhW1r6QgCT+FAlblqFFwg3w+DGLJkVyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUVKu6ZLuc4JJb1gSGTh4ZF3IDtQY93meQgQZ+D37EVSRjTqKOwv+KJXq5AXkabyX
	 m0FxA4sa+iv3WJjXacUR5Y53ADxKfD0CSCx7x44oQJG0HYGDEiSkqOYl0V9CCVrohk
	 4Ib8LLX/D5vwTwO3OI1UcYOvixPUU6S9Fi59xbasavUSvX0VL3PqQF8UH2MwmNwV1L
	 ExWSIuFFtUDmBWy9H2d8s0xeOE/hfoAG3TWE0tBev4Wt2akOdRMx+9I2Y5WcnRheLu
	 F3HKFWg38KIJmByvWEyjGS0t7nWhN0CqaPGFn1ZLNOqOMML4YuuCT37gmTTxds3Oe5
	 XlOoqwp7aOAQQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes 2/4] sched_ext: Use @prev's scheduler for the keep decisions in dispatch_one()
Date: Sat,  5 Sep 2026 06:09:56 -1000
Message-ID: <20260905160958.1565156-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dispatch_one() tests ops flags and bypass state against the root scheduler
in both places where it decides to keep running @prev: the early keep of a
@prev with slice left tests the root's bypass state, and the keep-last at
the end tests the root's SCX_OPS_ENQ_LAST and bypass state. Both are
properties of the scheduler @prev belongs to, and put_prev_task_scx(), which
acts on the outcome, reads them from that scheduler. When @prev belongs to a
sub-scheduler the two sides disagree.

The keep-last case is visible. The root set SCX_OPS_ENQ_LAST, so a lone
@prev of a sub-scheduler is not kept and is enqueued with SCX_ENQ_LAST to a
sub-scheduler that never opted in. This trips the WARN_ON_ONCE in
put_prev_task_scx() for the missing flag, and the sub-scheduler queues the
task like any other and triggers no follow-up scheduling event, which can
lead to stalls.

Test SCX_OPS_ENQ_LAST and bypass state on @prev's sched in both places and
charge SCX_EV_DISPATCH_KEEP_LAST to it. Read the sched at each decision, as
the dispatch in between can drop the rq lock.

Fixes: 88234b075c3f ("sched_ext: Introduce scx_task_sched[_rcu]()")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 120540cdda74..adf5993fa597 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2955,7 +2955,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		 * test.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
-		    !scx_bypassing(root_sch, cpu)) {
+		    !scx_bypassing(scx_task_sched(prev), cpu)) {
 			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
@@ -2972,15 +2972,20 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		goto has_tasks;
 
 	/*
-	 * Didn't find another task to run. Keep running @prev unless
-	 * %SCX_OPS_ENQ_LAST is in effect.
+	 * Didn't find another task to run. Keep running @prev unless its own
+	 * scheduler set %SCX_OPS_ENQ_LAST and takes the enqueue instead, see
+	 * put_prev_task_scx(). Read the scheduler here as the dispatch above
+	 * may have dropped the rq lock while @prev changed class or scheduler.
 	 */
-	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!(root_sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(root_sch, cpu)) &&
-	    scx_task_can_stay_on_cpu(rq, prev)) {
-		__scx_add_event(root_sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
-		verdict = SCX_DSP_PREV;
-		goto has_tasks;
+	if (prev->scx.flags & SCX_TASK_QUEUED) {
+		struct scx_sched *prev_sch = scx_task_sched(prev);
+
+		if ((!(prev_sch->ops.flags & SCX_OPS_ENQ_LAST) ||
+		     scx_bypassing(prev_sch, cpu)) && scx_task_can_stay_on_cpu(rq, prev)) {
+			__scx_add_event(prev_sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
+			verdict = SCX_DSP_PREV;
+			goto has_tasks;
+		}
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
 	return SCX_DSP_NONE;
-- 
2.55.0

