Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411656;
	b=ibMxH+FiBln+N9XNl+kon8q+P1XeA70m0c3TBY4YBerVRSU4TQ7ycWnf96kZL8G1lUjQ
	 Wt6kugDXgM7DDATe/1uoFhlb4/pZDNW8JUf47eH7rVEmvf2bGURvT83M7bF2n8J5zQjPa
	 m/hhXgg2/LVy/X/p7QCe6NUGemQjDiDJNSZ1Ay4UU8KJumXTc2BDowu8uyEhiB8cy8xsr
	 tSM6QhCN2X+DoaOuHv24g72phgA4BH/uRleto8YNw4oTN23clkliDIRaaPhL8dEIa1/w0
	 1K6VJtyFW/aDr9mhX/GKLwzhrIqYAKIJHaGwGweJ4QXqMBBjMB9pLdHplaVjpqNtbOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3ZW0Tbm6V7Os5JFX6g9Y3xjSF17p3NQDYhK9LmMYSw=;
	b=WPNBiySO1myrkEYV6h59d2jHwxd3RnL24NtgOtrUj2NvFciCctvoNpRjtr64AuV9voBd
	 694fQQFe0JQ9ZUaU2rT462XgHnxMDxj8PST8xdLCbJQDaxbivzpa7ZUb5/gdB/elbl4W2
	 0SvyvKcYealXrWPw8rwEv9QvQUhiC6BTmAM0nkNJoy00MZ5o7zk2YE7mu3mPVaar673+E
	 WQsU5nfOOnnCbx+FGehqhjeTMlWr/3YVmvSksCAbWCdJZ1o/m7GXPzLwdw5DCyjyk+CyA
	 OsFONxnuvFBhADpeoJWWpObY9oxT2e/TsAdMbi9OhHZKijfBSbdCljOI0n8bAa4Rw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk6cd7F5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F7606A31E;
	Sat, 31 Oct 2026 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk6cd7F5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C80A1F000C1;
	Sat, 31 Oct 2026 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793411655;
	bh=E3ZW0Tbm6V7Os5JFX6g9Y3xjSF17p3NQDYhK9LmMYSw=;
	h=From:To:Cc:Subject:Date;
	b=fk6cd7F5OsXROGuZQ6OUfOe0JTuZy1OY6IuN+SeePu11JVrOF1zuLPraib2ECDmy9
	 V3YqA0CZzKXt9/6ux2SBojC/kQfg7Muvgagm1x3S1B2vf+daiFB6TaToq3NO9uK8Vu
	 7ksZiPxmEzWm8Tdrb88jIVppt+yq4KIcpgUKUgb99oUESjbZZClU5ZYL9H+0PQ00Lf
	 MrU/YWxOcp4rw0Fr2/yWgUC9SXTCQl81o1F3V5MFfmYi1yGFggti92cL+TVmU3bEh9
	 x3/eXcz5vvUM9TFAcV5UDGY8KqszcnmG2crudsfd5+kVHkhYfwMEEyAGOPGc6uA0Xq
	 hPdoWTbDmTrRA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when a wakeup resets the donor during dispatch
Date: Fri, 30 Oct 2026 15:54:14 -1000
Message-ID: <20261031015414.219280-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

With proxy execution, do_pick_task_scx() passes rq->donor to dispatch_one()
as @prev. Unlike rq->curr, the donor can be moved to another CPU by a wakeup
while dispatch_one() has the rq lock dropped:

1. dispatch_one() drops the rq lock, e.g. to move a task from another CPU.
2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
   proxy_needs_return() dequeues it and resets the donor to rq->curr, and
   the wakeup enqueues it, possibly on another CPU.
3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
   on another rq.

sched_proxy_block_task() resets the donor the same way when another CPU sets
@prev's policy to SCHED_EXT or moves it to another BPF scheduler, and blocks
@prev instead.

Whatever dispatch concluded, and whatever it does with @prev after the drop,
is about a task this CPU no longer owns. rq_modified_above() catches the
reset only when rq->curr is in a class above ext, and the dl_server pick
skips the check.

Restart the pick when @prev is no longer the donor, as dispatch_core_pick()
already does after a lock drop. dispatch_one() tests after each step that
can drop the lock, and scx_dispatch_sched() decides per ops.dispatch() call
whether to hand @prev over, which also covers a class or scheduler change
across a drop. The donor only ever changes to rq->curr during a pick, so the
retried pick can't go stale again.

7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
closed the same window in prev_balance() by reading rq->donor instead of
taking @prev. That doesn't work here, as the dispatch never evaluated
rq->curr, which may not even be a sched_ext task.

Verified with a synthetic reproducer.

v2: Also cover rq lock drops inside dispatch (sashiko).

v3: Don't keep a stale @prev after ops.dispatch() (sashiko).

Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c     | 20 +++++++++++++++++++-
 kernel/sched/ext/inlines.h | 33 +++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cd923f9f1f2a..43cf98c1d511 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		rq->scx.cpu_released = false;
 	}
 
+	/* the ecaps sync may have dropped the rq lock */
+	if (scx_dsp_prev_stale(rq, prev)) {
+		verdict = SCX_DSP_RETRY;
+		goto out;
+	}
+
 	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
@@ -3449,8 +3455,19 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	}
 
 	verdict = scx_dispatch_sched(root_sch, rq, prev, false);
-	if (verdict != SCX_DSP_NONE)
+
+	/* scx_dispatch_sched() may have dropped the rq lock */
+	if (scx_dsp_prev_stale(rq, prev))
+		verdict = SCX_DSP_RETRY;
+
+	switch (verdict) {
+	case SCX_DSP_RETRY:
+		goto out;
+	case SCX_DSP_NONE:
+		break;
+	default:
 		goto has_tasks;
+	}
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless its own
@@ -3517,6 +3534,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		     rq->scx.nr_immed))
 		scx_schedule_reenq_local(rq, 0);
 
+out:
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
 	return verdict;
 }
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 1e39d12678c4..87b8193785d3 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -18,9 +18,28 @@ enum scx_dsp_verdict {
 	SCX_DSP_NONE,		/* nothing to run */
 	SCX_DSP_LOCAL,		/* local DSQ has tasks */
 	SCX_DSP_PREV,		/* keep running @prev */
-	SCX_DSP_RETRY,		/* pick helpers only: restart the pick */
+	SCX_DSP_RETRY,		/* restart the pick */
 };
 
+/**
+ * scx_dsp_prev_stale - Test whether dispatch's @prev went stale
+ * @rq: rq being dispatched for
+ * @prev: @rq's donor when dispatch started
+ *
+ * With proxy execution, @prev is the donor and may not be the running task.
+ * Another CPU can reset the donor to rq->curr while dispatch has the rq lock
+ * dropped. Dispatch restarts the pick when that happened and doesn't hand the
+ * old donor to the BPF scheduler.
+ *
+ * During a pick, the donor only ever changes to rq->curr. Only __schedule() on
+ * this CPU sets a different donor, after the pick, so the restarted pick takes
+ * rq->curr as @prev and can't go stale again.
+ */
+static inline bool scx_dsp_prev_stale(struct rq *rq, struct task_struct *prev)
+{
+	return sched_proxy_exec() && unlikely(prev != rq->donor);
+}
+
 /*
  * One user of this function is scx_bpf_sub_dispatch() which can be called
  * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
@@ -33,8 +52,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
-	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
-		scx_task_on_sched(sch, prev);
+	bool prev_on_sch;
 
 	if (scx_consume_global_dsq(sch, rq))
 		return SCX_DSP_LOCAL;
@@ -106,6 +124,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			rq->scx.sub_dispatch_prev = prev;
 #endif
 
+		/* the dispatch so far may have dropped the rq lock */
+		prev_on_sch = !scx_dsp_prev_stale(rq, prev) &&
+			      prev->sched_class == &ext_sched_class &&
+			      scx_task_on_sched(sch, prev);
+
 		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
 			    prev_on_sch ? prev : NULL);
 
@@ -116,7 +139,9 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 		scx_flush_dispatch_buf(sch, rq);
 
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
+		/* ops.dispatch() and the flush may have dropped the rq lock */
+		if (!scx_dsp_prev_stale(rq, prev) &&
+		    (prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
 			return SCX_DSP_PREV;
 		if (rq->scx.local_dsq.nr)
 			return SCX_DSP_LOCAL;
-- 
2.56.0

