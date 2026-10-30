Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793404650;
	b=SZzwu5OnPKBNCpdLBjT0CK5xO/t1EP1ausyEdEFmRpTI6sXcHSdaEgQIi01pLSOyZpTb
	 3LYg7HSthP8/VImdIRP69U0Qu4i3ubq1VncpjkU35TsVV0eRIRIWW28ZpZZ/W0TLKmG6q
	 DFOKFo6oR3hJ4+wue7hvs5kBBzIxFTaE1AMW+FfuHrt6FmO9FCZ8mmaC4KX3K+kRPbgAz
	 AK1s4N3JOh6HKKbw0XUxY/x8LQDuR7k8+re4PEw6AYa4n8H+t3LQH3FNJxFN1Of4DP+sd
	 wJLsK7/GvHCcTFs/k/g9pzB6gRVLetu/BK96LohWKeK0JgQxealERuklJZ74d979Gkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793404650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3EuxvSewNdXujnqS9ssYqa7k7KdCysDqjb7ER7jH6jU=;
	b=E7O3fvqFeg0fjJdtBcBZEadqiCYufPyjycCH6GJndYcs8hieEBaz8jRSgNvGQPkllI6Z
	 9MFrXHH84fWglBXUfg1bRNt7oSz3cx1fuDNz1IxzVam64BFHkFQse/U+en+d1NWfDuCiN
	 bYlqAtxDISHQf+nlvhy7NJ9X102zpLAkPj4ksURwlf5YmyxsmQ4qV90jj0I+KMQkqO9G9
	 JeJe0F99FSySfe71TNh5lHmW0QoBpoBS/uEtAJrCkAme9YsxiX9AqTZORfRbt4OuqDvcI
	 g+vPPleLYjcGjSOVT0Fcivstji8MY+QWYVpVxsrW7WIHgnDJLzuvmbu4V318/uaEQaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUy+mhUK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9AB606A31A;
	Fri, 30 Oct 2026 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUy+mhUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F51F000C1;
	Fri, 30 Oct 2026 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793404649;
	bh=3EuxvSewNdXujnqS9ssYqa7k7KdCysDqjb7ER7jH6jU=;
	h=From:To:Cc:Subject:Date;
	b=aUy+mhUKlPKj1k00PKbTZpkFkKrS3+kMpmdSwLcIpi6goyoc+1q+TfcNL0aD0W9Yt
	 blWj39Bpsm2omJ3oxc4A3nfCzxwZZrcBRTeiOxEGqbSqccSrXeOccywf1GNJp5fYro
	 d9qGdXt7OCs67PLCK5sorexaNEuel2Rngrc7AzBeAa9lSV67vjN3/oLUJ/U7qdo6Hz
	 bFsKBEcNKqiJfHdYLEIY6z/TkKqF3aS98aF97zpvFBQ0WwDn2SaILWaTtxUY/etqKm
	 v7bq6T1w8x0fnS6o9ozW/4WxDiYra2wCntLHPrDesy4iJLLmWM6ZJt6tuUBFop0zfC
	 Je2rOQagLbWew==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when a wakeup resets the donor during dispatch
Date: Fri, 30 Oct 2026 13:57:28 -1000
Message-ID: <20261030235728.4098872-1-tj@kernel.org>
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

Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c     | 20 +++++++++++++++++++-
 kernel/sched/ext/inlines.h | 29 ++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

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
index 1e39d12678c4..fb0c58927d42 100644
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
 
-- 
2.56.0

