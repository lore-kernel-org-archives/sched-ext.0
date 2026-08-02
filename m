Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB73D565D;
	Sun,  2 Aug 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707692; cv=none; b=OrCUYEdQzS9zRC5otFa+EjGNwwuAOjxuCVItm3wUJJ974j5tvskjb71h0+xjm53qdvZmwcQLE7bJJbe1+hva4U+GT2aO3BooQGbVBM6hfelH7t3vL78TS/5aHk+4Dghv7hgSOMpnWmiXAX4a2ApffCJ308mlBn9P0H5ss44np2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707692; c=relaxed/simple;
	bh=6WnmjJsVoUZ8Ax8Mjdcv7V88sQjI+Fgi5R+OSRHm1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFElVEqytzx+eZZAO43QZumEe1pKgLFfEKySTyo/y5HVLMrza2gg9ikPiGY6G5i6tgXZa8+GvzJ3ph4VUhvCfh+LcRW3ZwHoPeTHxdC6mAuKQhRo0+SwFza6TldYcP36qL7p9mqgJ4k4HA/86EbMs2iXPeGuQiTCbPRbPHsqqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF4Vr4o1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF4Vr4o1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0531F00A3A;
	Sun,  2 Aug 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707690;
	bh=N9RYN8JpljVIQjcRDaMyalez5raALr9ZZLY33bLTBkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CF4Vr4o1gOBwAXtSc1wcX+FXpP4s5HP7eLWUPH19T9nxwpCI1BetW+uJfmBvfty8X
	 +Tk03nclHXskVfNbqJy4kCKejMl4x5q4an7yS+8XmgO6YcPMfpyx+NBUtD1gq01/8o
	 B9Cecxygk4qq8iQ6l5oose9+R1sH7tNJ97KV2CieuVav+jT5zt1T+6luxy8fp7Iup0
	 qdSHuBFYFjPt25Dgjp5Tv0grTd+DyAhsBId7L6My72fY55EPauEBDJn3iaQpDgRbYx
	 PFOHrJ4ehuiiSZcsDIYidoiB+j0OiytwX8BqtjK+I3bRckdU59tCBbVOCM2QaT8TfT
	 oPs0EzTZ7YGFQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/12] sched_ext: Factor out __scx_bpf_now()
Date: Sun,  2 Aug 2026 11:54:38 -1000
Message-ID: <20260802215447.3134509-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
References: <20260802215447.3134509-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_now() couples the valid-or-fresh rq clock read to the current rq.
The read is useful for kernel-internal timing against a specific rq,
including a remotely locked one. Factor it out into __scx_bpf_now().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 59 ++++++++++++++++++-------------------
 kernel/sched/ext/internal.h |  1 +
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4245a737592a..777ae515c88e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10160,6 +10160,27 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
 	return container_of(scx, struct task_struct, scx);
 }
 
+u64 __scx_bpf_now(struct rq *rq)
+{
+	/* the caller must be on @rq's cpu or hold its lock */
+	lockdep_assert((rq == this_rq() && !preemptible()) ||
+		       lockdep_is_held(__rq_lockp(rq)));
+
+	if (smp_load_acquire(&rq->scx.flags) & SCX_RQ_CLK_VALID) {
+		/* if the rq clock is valid, use the cached rq clock */
+		return READ_ONCE(rq->scx.clock);
+	} else {
+		/*
+		 * Otherwise, return a fresh rq clock.
+		 *
+		 * The rq clock is updated outside of the rq lock.
+		 * In this case, keep the updated rq clock invalid so the next
+		 * read outside the rq lock gets a fresh rq clock.
+		 */
+		return sched_clock_cpu(cpu_of(rq));
+	}
+}
+
 /**
  * scx_bpf_now - Returns a high-performance monotonically non-decreasing
  * clock for the current CPU. The clock returned is in nanoseconds.
@@ -10190,36 +10211,14 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
  */
 __bpf_kfunc u64 scx_bpf_now(void)
 {
-	struct rq *rq;
-	u64 clock;
-
-	preempt_disable();
-
-	rq = this_rq();
-	if (smp_load_acquire(&rq->scx.flags) & SCX_RQ_CLK_VALID) {
-		/*
-		 * If the rq clock is valid, use the cached rq clock.
-		 *
-		 * Note that scx_bpf_now() is re-entrant between a process
-		 * context and an interrupt context (e.g., timer interrupt).
-		 * However, we don't need to consider the race between them
-		 * because such race is not observable from a caller.
-		 */
-		clock = READ_ONCE(rq->scx.clock);
-	} else {
-		/*
-		 * Otherwise, return a fresh rq clock.
-		 *
-		 * The rq clock is updated outside of the rq lock.
-		 * In this case, keep the updated rq clock invalid so the next
-		 * kfunc call outside the rq lock gets a fresh rq clock.
-		 */
-		clock = sched_clock_cpu(cpu_of(rq));
-	}
-
-	preempt_enable();
-
-	return clock;
+	/*
+	 * Note that scx_bpf_now() is re-entrant between a process context and
+	 * an interrupt context (e.g., timer interrupt). However, we don't need
+	 * to consider the race between them because such race is not observable
+	 * from a caller.
+	 */
+	guard(preempt)();
+	return __scx_bpf_now(this_rq());
 }
 
 static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *events)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1d226aa8a003..a0a2294f1dc2 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1984,6 +1984,7 @@ void scx_flush_dispatch_buf(struct scx_sched *sch, struct rq *rq);
 s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch);
 __printf(2, 3) void scx_dump_line(struct seq_buf *s, const char *fmt, ...);
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
+u64 __scx_bpf_now(struct rq *rq);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
 int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
-- 
2.55.0

