Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607459;
	b=jNjbXsyqnYU9KZ18xv8CyyuBIoQ0irheWitwCXmVdu1MbRaj0rck+sR0cIt+cWx9MOS2
	 XMUBM80vcB54Q6Et12ivtZRzApdXC4arFCQoyvBAWzjUBQ3q2LGzXamOqX2IOPAPfsk5L
	 8k5q5LyztP3b8bWhrh0FXs+5mF4FytbrzfjxxEOhnwRrv17kMy6uVflq8LiN5bzYmU54K
	 GmXzmHE/POrRZUs1Q7sg8VzwSeprB0D/bMjsysaxeRnVQfrZfCl7wSti1lT0eZ8vZeqq1
	 5qWYhQSCa+Imqj0S6nbZbTOqxLapRIBgiv91KHq960M4v0LTYQlB/kxabdxzTJOmZkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XxpHxjNY3UsTDcTzG60Yu5gGt0anPZ0u89T3qoWHlA4=;
	b=ipujAlLhOfg94+Fza/pzPFmhJ1Y317uLFBpK9IUcaw+nRkC/9qg2lhyWmADP387MSMLY
	 uyqziogWSbOO5A8i5kUwme7+dD6Ub8P0/HZkCzjd2/9Iojf31Rc7Ff12MGDIHEPWfcWyf
	 PauQiOBtHUtHlnhhjxxnMAM6cNUtxeK2fmD80jQblEGWpjy/qETG8I4TYsZKkGUnGeG7/
	 sUXUkNFoPRYwUZy455ENfz0QljSiIjkV91n+Zgw3BBQL0IrRgB7lGA95mLdC7aeibx+e1
	 Jp4Tlb7DSjn4lMlSxnJy6MLxXYlHvvt3BdeTFSXPAmXjN8FQabNTvc8rX+yhKEt04nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ahAHraVB;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85F606A327
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED85F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ahAHraVB
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3263358f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795607456; x=1796212256; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxpHxjNY3UsTDcTzG60Yu5gGt0anPZ0u89T3qoWHlA4=;
        b=ahAHraVBsutAP2tIAi6aeTrR+aDr/QAu4J0nuRyBfs61dx4SA+CozBmYnXzYLGRyVn
         XnBArk+I1XqjqW6/o8PFCtEnYPqgUvkqzbbc+/viMoqqAzeoXgLkO13SJ19yGP6hlQRK
         RqELPjB0vx7ywEOjXF+RFaDOmdSDELYGd08lEwEsMZvJceFSwfepca8nKa+VUYRfiXo3
         rsPUG5hEhda1FcTEtw9zGfTmNtVDPfcDHCJDWjJRJ7l2MHVG6+Lu6GAWPGojeZqo2L7N
         V9CgNHqwLK+YVEy/QhpqzhPXkUge0U7yH/Igcm0EnRH3hAzahfrJvofJW9iWKzNJxY6C
         tdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607456; x=1796212256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxpHxjNY3UsTDcTzG60Yu5gGt0anPZ0u89T3qoWHlA4=;
        b=kYWQj69p322kYDApj7mNFPlhhtTjaPUzC4Kbdg/Ak2GiwixIQ3QhwOOABWZUAtD+fi
         lB3pINlhi23OfFyMmj6+L/K2dcTkPIVIhFiRgI+uOFa70Gti+/rdXj0kyYjF5QUG//14
         ojkvaLB4caPp7A6p9xPxhhTzwhQhNiFo378D7kxb3toHONTcxnUZSE/B/zwpPutOBuSI
         45woQenKtkAy5LsodEsmKrXxoHxx9eiT/LaA/rhQETAc8tahvVxz62Ap5Pd8uYR3vRe2
         FxDR0/+0DfhpQSgZ5h91wbfDne0Fr5wRfPQWdEF5C3rjotWzDmVubEDY0LZuGqSZc/Up
         FBsA==
X-Forwarded-Encrypted: i=1; AL+hErGnvQ0cYPH6v3aS33BKUbR23s9c04gYTTkaT3V5zm3LcceQT2Zz0hlJ105aFCzZnF8lbPpZo70ZboE=@lists.linux.dev
X-Gm-Message-State: APuU4Z9vaiQ1uv+QzXOZ7uHZR2ORGKsqCdOBLUyPJkVk0p8Ud3KUcT/3
	G/KnIENtBu/HAsqWLmD5AQ1/oxVBcPKC8+eVW1N00tqJbPFABwnvz7KPu6d+w7hJvh42BLKSqdX
	5msLa+i1U8KciTQ==
X-Received: from wmbiv17.prod.google.com ([2002:a05:600c:5491:b0:4b6:5d12:e070])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cc:b0:4bb:69b3:2b42 with SMTP id 5b1f17b1804b1-4bb888277b3mr377419855e9.16.1795607455071;
 Wed, 25 Nov 2026 03:50:55 -0800 (PST)
Date: Wed, 25 Nov 2026 11:50:52 +0000
In-Reply-To: <20261125114932.3198836-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125114932.3198836-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125114932.3198836-2-jpiecuch@google.com>
Subject: [RFC PATCH 1/2] sched_ext: Reenqueue IMMED tasks when a higher class
 wins the pick
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SCX_ENQ_IMMED relies on rq->next_class to tell whether a higher class task
is about to take the CPU. rq_is_open() refuses IMMED insertions while
next_class is above ext and wakeup_preempt_scx() reenqueues IMMED tasks
when a higher class task raises next_class. However, a higher class task
can take the CPU without going through wakeup_preempt(), leaving IMMED
tasks on the local DSQ until it gives the CPU up:

- sched_setscheduler() or a PI boost promoting a queued task to RT or DL.
  sched_change_end() doesn't call wakeup_preempt() for tasks which aren't
  running, switched_to_rt() only calls resched_curr() and switched_to_dl()
  calls wakeup_preempt_dl() directly.

- DL replenishment, CFS bandwidth unthrottling (in partial mode) and RT
  group unthrottling make tasks runnable without wakeup_preempt().

- When the ext dl_server picks an SCX task, next_class becomes ext even
  though RT tasks are queued. Once the server runs out of budget, RT takes
  over without a wakeup.

- With core scheduling, a forced idle pick resets next_class to idle while
  tasks remain on the local DSQ. An RT task waking up on the CPU then goes
  through wakeup_preempt_idle() instead of wakeup_preempt_scx().

With proxy execution enabled, scx_proxy_reenqueue_retry() already catches
these. __schedule() sets rq->next_class from the picked task right before
calling it, so it reenqueues IMMED tasks whenever a higher class wins the
pick, whether or not that task went through wakeup_preempt(). Without proxy
execution (CONFIG_SCHED_PROXY_EXEC=n or sched_proxy_exec=0), nothing does.

Rather than chasing every path which can make a higher class task
runnable, check once the pick is final, whether or not proxy execution is
enabled. Add scx_settle_pick(), called by __schedule() after proxy
resolution, on the path which every pick reaches. If rq->next_class is
above SCX and the local DSQ has IMMED tasks, schedule a reenqueue. It runs
right after the context switch. rq_is_open() is false by then, so the
IMMED tasks go back to the BPF scheduler. With proxy execution,
rq->next_class is the class of the donor, so a higher class donor running
an SCX lock owner counts too. Core-sched siblings apply a pick made by
another CPU in their own __schedule(), so they're covered as well.

This makes the IMMED check in scx_proxy_reenqueue_retry() redundant, so
remove it. The reenqueue from wakeup_preempt_scx() stays, as it kicks in
earlier for the common case. When no BPF scheduler is loaded, the new hook
is a static branch.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/core.c    |  1 +
 kernel/sched/ext/ext.c | 53 +++++++++++++++++++++++++++++++++++-------
 kernel/sched/ext/ext.h | 13 +++++++++++
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f7a452123ef5..7eb99b833a4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7340,6 +7340,7 @@ static void __sched notrace __schedule(int sched_mode)
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 keep_resched:
+	scx_settle_pick(rq);
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index efa1d01d03af..cea7bd9acc8b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1264,14 +1264,6 @@ void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next)
 		scx_proxy_update_tick(rq, next);
 #endif
 
-	/*
-	 * A higher priority class may wake up while @rq is transiently idle
-	 * for proxy resolution. wakeup_preempt_scx() isn't invoked in that
-	 * case, so reenqueue IMMED donors parked on the local DSQ here.
-	 */
-	if (rq->scx.nr_immed && sched_class_above(rq->next_class, &ext_sched_class))
-		scx_schedule_reenq_local(rq, 0);
-
 	if (rq->scx.flags & SCX_RQ_PROXY_RETRY) {
 		rq->scx.flags &= ~SCX_RQ_PROXY_RETRY;
 		schedule_deferred_locked(rq);
@@ -2713,18 +2705,61 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
-	 * This captures all preemption cases including:
+	 * This captures the preemption cases which go through wakeup_preempt()
+	 * including:
 	 *
 	 * - A SCX task is currently running.
 	 *
 	 * - @rq is waking from idle due to a SCX task waking to it.
 	 *
 	 * - A higher-priority wakes up while SCX dispatch is in progress.
+	 *
+	 * The rest is caught by scx_settle_pick() once the higher-priority task
+	 * gets picked.
 	 */
 	if (rq->scx.nr_immed)
 		scx_schedule_reenq_local(rq, 0);
 }
 
+/**
+ * __scx_settle_pick - Reenqueue IMMED tasks left behind by a pick
+ * @rq: rq of the current CPU, locked
+ *
+ * Called by __schedule() once the pick, including proxy resolution, is final.
+ * If rq->next_class is above SCX, IMMED tasks on @rq's local DSQ can't run.
+ * With proxy execution, rq->next_class is the class of the donor. A higher
+ * class can take the CPU without going through wakeup_preempt_scx(), as
+ * rq->next_class doesn't always reflect the highest class with runnable tasks:
+ *
+ * - A queued task getting promoted to RT or DL by sched_setscheduler() or a PI
+ *   boost only triggers resched_curr() or a class-local preemption check.
+ *
+ * - DL replenishment and CFS or RT bandwidth unthrottling make tasks runnable
+ *   without going through wakeup_preempt().
+ *
+ * - When the ext dl_server picks an SCX task, rq->next_class is set to ext even
+ *   if RT tasks are queued. RT takes over once the server runs out of budget.
+ *
+ * - With core scheduling, a forced idle pick resets rq->next_class to idle
+ *   while tasks are still on the local DSQ. A later wakeup goes through
+ *   wakeup_preempt_idle().
+ *
+ * - While @rq is transiently idle for proxy resolution, a higher class task
+ *   waking up also goes through wakeup_preempt_idle().
+ *
+ * Catch all of these here. The reenqueue is deferred and runs right after the
+ * context switch. rq->next_class is still above SCX by then, so rq_is_open() is
+ * false and the IMMED tasks on the local DSQ go back to the BPF scheduler.
+ */
+void __scx_settle_pick(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.nr_immed &&
+	    sched_class_above(rq->next_class, &ext_sched_class))
+		scx_schedule_reenq_local(rq, 0);
+}
+
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
 				      u64 enq_flags, struct rq *dst_rq)
 {
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index d32bc01071b0..c66c4c97a2e0 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -26,6 +26,7 @@ void scx_proxy_donor_start(struct rq *rq);
 void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next);
 void init_sched_ext_class(void);
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
+void __scx_settle_pick(struct rq *rq);
 
 static inline bool scx_allow_proxy_exec(const struct task_struct *p)
 {
@@ -41,6 +42,17 @@ static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 		__scx_update_idle(rq, idle, do_notify);
 }
 
+/*
+ * Called by __schedule() once the pick, including proxy resolution, is final.
+ * A pick which lands in a class above SCX can leave %SCX_ENQ_IMMED tasks behind
+ * on the local DSQ. See __scx_settle_pick().
+ */
+static inline void scx_settle_pick(struct rq *rq)
+{
+	if (scx_enabled())
+		__scx_settle_pick(rq);
+}
+
 static inline u32 scx_cpuperf_target(s32 cpu)
 {
 	if (scx_enabled())
@@ -80,6 +92,7 @@ static inline void scx_proxy_reenqueue_retry(struct rq *rq,
 					     struct task_struct *next) {}
 static inline void init_sched_ext_class(void) {}
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify) {}
+static inline void scx_settle_pick(struct rq *rq) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.56.1.839.g22a8290db9-goog

