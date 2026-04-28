Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A642B75E
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380407; cv=none; b=Z6rcGHvbm2GHYrehlCsJTN7Vu9LMu/9Jvx7oCxCw6+kOApnATZ/6TBZ9xX7/3zG0DNEpVnGVuKAQQMUqL5cOO1bBHzLw4ASzEFXk44CBBu2Kbdv7kVi0E+eO++clpCfKGCqLwDVhtbqMjvoXKiZiCvGCe6XU+g60/puVjoCpTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380407; c=relaxed/simple;
	bh=BoFbLlQ1uw+5llcl6uG33SBIqyChoCzbWsBr6joDY+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HtzADP3opXiZYa+T5Oc6I7yzN2/Kia+5do3x40QCiLDG5JKTwvJEKEppoLeFfFEOQ9paP9Sq8/SwUlO89vxlw0l/uE2BeRM4APSEcdJ+xa5WlPUBAEFLDt8+jidfqkK9M1k+EpOH3YHeeUWiuYinrMneezRfZVteGy1MxQxvjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4didsxG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4didsxG"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43ff19e54beso7053505f8f.2
        for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777380401; x=1777985201; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ygzb9zjOcMphk+6mIQlJbEZFPTgqztpzw+rBAl0DYAg=;
        b=n4didsxGMFLfaKKO7uWHj+yE3v3eYt0OwmAFAOVBfc0i7WVcZXnbhdXXoWfnER2OQH
         RptKB3ACab+w9XgGPLolxxYueRRtqSZ36lwmyAU89YFIO1TAWLhEH2O8XOaBLDfjuIeu
         +lt5yNZHRHZlJG5k82k4qiER712sml1ypjLCEjSSrOh6CLtTI/UnosBpON5dG+Q9EUZF
         cox7ciZhpSQuovRZ8XjAIMEBQOQD6y4lB9m6IIzjbXYHMJFXdX/UBiwjFHMGTbhV4PC0
         S9pzinmp1H8UHAiIjITL/4F7jIlOXBBdcyh7DGKGvVzDMoyX8GtqqIrjzau+H37h1O3y
         zx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380401; x=1777985201;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygzb9zjOcMphk+6mIQlJbEZFPTgqztpzw+rBAl0DYAg=;
        b=bh8TbvElWyXqxuMZRhLGDZcGC9IYjOWsJdH6XjKP+W0U7iodqoZXwokMWSbtCPvki0
         PxbalQqOnQDhUL39bNPe+qcaw2s7SR4cz7R2468e3wxXe3uDuJalyKCHPCQ+HixqGAcY
         iBmEfmuiH8cBFm2FiKicLrCmWGkmSF4MkCdq9frzMTwNB6dRVqxVpCshYku1UObfIBGT
         I0k4fQuiGx2qkSz1kq11qyOJ+Mz2ddVMWQl9qd3K+yrCUWbhqkigk3A1866QUj5vj6ez
         wTeE0+M9TWySTyuvywQAyO8HZ7mPf4GQuvRzTlPnG93VzVXjTgW7dSJLDlE2EomnYXRp
         GYCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TA9SZkv/MkK1mMQNjdNnQkm2AJ3BSf/LilCboG4FhEV85hX7osjfBHZ28EF8+VcbZR0h3Ttxk8gY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwCtE9ldRXXQyFcIKhyrg4DduSuGY7e9tbEB1Y5vAnH0h1aG4BQ
	awGzaCEgItOK+ymJk0j6xd9eMuxRRYPhVQ1XQ2J7/iKtgo0/jzEF81ZAnork/4Mf994WU+Q0VX2
	WStYKdy/mrcDQ8g==
X-Received: from wrnw1.prod.google.com ([2002:adf:ec41:0:b0:43d:75c2:d351])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1884:b0:43d:76ec:91f6 with SMTP id ffacd0b85a97d-44649c99760mr5165723f8f.41.1777380401103;
 Tue, 28 Apr 2026 05:46:41 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:46:01 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428124601.3017925-1-jpiecuch@google.com>
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Call wakeup_preempt()
 in local_dsq_post_enq()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

There are several edge cases (see linked thread) where an IMMED task
can be left lingering on a local DSQ if an RT task swoops in at the
wrong time. All of these edge cases are due to rq->next_class being idle
even after dispatching a task to rq's local DSQ. We should bump
rq->next_class to &ext_sched_class as soon as we've inserted a task into
the local DSQ.

To optimize the common case of rq->next_class == &ext_sched_class,
only call wakeup_preempt() if rq->next_class is below EXT. If next_class
is EXT or above, wakeup_preempt() is a no-op anyway.

This lets us also simplify the preempt_curr() logic a bit since
wakeup_preempt() will call preempt_curr() for us if next_class is
below EXT.

Link: https://lore.kernel.org/all/DHZPHUFXB4N3.2RY28MUEWBNYK@google.com/
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
Changes from v1:
 - Elaborated the comment on why wakeup_preempt() is needed by
   including specific examples (Tejun Heo)
 - Moved the wakeup_preempt() call before the early return on
   SCX_RQ_IN_BALANCE (Sashiko), see
   https://sashiko.dev/#/patchset/20260424092245.3212529-1-jpiecuch%40google.com

 kernel/sched/ext.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9eda20e5fdb8..cac0b18239fe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1402,14 +1402,51 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 			       struct task_struct *p, u64 enq_flags)
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-	bool preempt = false;
 
 	call_task_dequeue(sch, rq, p, 0);
 
+	/*
+	 * Note that @rq's lock may be dropped between this enqueue and @p
+	 * actually getting on CPU. This gives higher-class tasks (e.g. RT)
+	 * an opportunity to wake up on @rq and prevent @p from running.
+	 * Here are some concrete examples:
+	 *
+	 * Example 1:
+	 *
+	 * We dispatch two tasks from a single ops.dispatch():
+	 * - First, a local task to this CPU's local DSQ;
+	 * - Second, a local/remote task to a remote CPU's local DSQ.
+	 * We must drop the local rq lock in order to finish the second
+	 * dispatch. In that time, an RT task can wake up on the local rq.
+	 *
+	 * Example 2:
+	 *
+	 * We dispatch a local/remote task to a remote CPU's local DSQ.
+	 * We must drop the remote rq lock before the dispatched task can run,
+	 * which gives an RT task an opportunity to wake up on the remote rq.
+	 *
+	 * Both examples work the same if we replace dispatching with moving
+	 * the tasks from a user-created DSQ.
+	 *
+	 * We must detect these wakeups so that we can re-enqueue IMMED tasks
+	 * from @rq's local DSQ. scx_wakeup_preempt() serves exactly this
+	 * purpose, but for it to be invoked, we must ensure that we bump
+	 * @rq->next_class to &ext_sched_class if it's currently idle.
+	 *
+	 * wakeup_preempt() does the bumping, and since we only invoke it if
+	 * @rq->next_class is below &ext_sched_class, it will also
+	 * resched_curr(rq).
+	 */
+	if (sched_class_above(p->sched_class, rq->next_class))
+		wakeup_preempt(rq, p, 0);
+
 	/*
 	 * If @rq is in balance, the CPU is already vacant and looking for the
 	 * next task to run. No need to preempt or trigger resched after moving
 	 * @p into its local DSQ.
+	 * Note that the wakeup_preempt() above may have already triggered
+	 * a resched if @rq->next_class was idle. It's harmless, since
+	 * need_resched is cleared immediately after task pick.
 	 */
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
@@ -1417,11 +1454,8 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
 		rq->curr->scx.slice = 0;
-		preempt = true;
-	}
-
-	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
 		resched_curr(rq);
+	}
 }
 
 static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
-- 
2.54.0.545.g6539524ca2-goog

