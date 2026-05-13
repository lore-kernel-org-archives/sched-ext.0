Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7723E95AB
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666192; cv=none; b=UT6+JoWQeHJPjpwFYSx4S4J608hVK0tc8u4LmmMlrPFiBIoZnyBg7pyCqHH+esAVSKut/WCK831XoXAjOrYaUuT8G7xn1l5vOR1Lmgjx1WNLEyDKAkc2VDGpa7BgURS27AFp48zawrFi/iilusPaU8gs7o4EWjjnwul+C/4pgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666192; c=relaxed/simple;
	bh=IOGPW7rhFClYe0kTP8pK3hLKJHAqgxusifh/LUJ1AoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKmzNXXhRovjHbzrOSWTwui7ywypalT35tW6sDk4KJ59uBPGcy9RNFDtRTKxl8a0KUAFyU7uiIQQpf5LA0HrcySJ7OoYU24ucAAHukHdOM4wpqwl6fVbdy+P22yT8X3ef2b6O0aPzegPKqBdzkn1g9+bQGVIMKXss3B1pT5l51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EalkARxz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EalkARxz"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8E2D726F96;
	Wed, 13 May 2026 11:56:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWLyZBfz14ob; Wed, 13 May 2026 11:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778666179; bh=IOGPW7rhFClYe0kTP8pK3hLKJHAqgxusifh/LUJ1AoM=;
	h=From:To:Cc:Subject:Date;
	b=EalkARxzqH7FsGBWU4MPvjCpT2F35zNoerKfkjNmo5b1Mph+etlxzdqPZ6OA0AYDg
	 ZnfqgN8Yu4Fp1kz6JZZ8FC5DqKIJ8HvAielAwoXmj0g1TKYfOddmdlCkfIlhljSWkt
	 HadztZ7SrzMdpuZKauQlrjy9k0nQRucSMi8BWcaqlLAHae7x/excpOGqNJ4QOo6Vlw
	 aWPxQcB3KDJaevwLdrBH/8jm5k83gTy+hrWMrqrQVYSDvy6FVF0izmz5vb0Ulf/A78
	 fdgPv8JbQn9JgctUiuDLlEB0cr0VpvotMJfsued/ET668OJpQ2WD4OeWKwJfjKp2db
	 I5bDazv96PWAA==
From: Samuele Mariotti <smariotti@disroot.org>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()
Date: Wed, 13 May 2026 11:53:29 +0200
Message-ID: <20260513095329.4029345-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops_dequeue() can race with finish_dispatch() and spuriously trigger the
"queued task must be in BPF scheduler's custody" warning.

ops_dequeue() snapshots p->scx.ops_state via atomic_long_read_acquire()
and then, in the SCX_OPSS_QUEUED arm, asserts that SCX_TASK_IN_CUSTODY
is set. The two reads are not atomic w.r.t. a concurrent
finish_dispatch() running on another CPU:

CPU 1                                    CPU 2
=====                                    =====
                                         dequeue_task_scx()
                                           ops_dequeue()
                                             opss = read_acquire(ops_state)
                                                  = SCX_OPSS_QUEUED
finish_dispatch()
  cmpxchg ops_state:
    SCX_OPSS_QUEUED -> SCX_OPSS_DISPATCHING  [succeeds]
  dispatch_enqueue(SCX_DSQ_GLOBAL,
                   SCX_ENQ_CLEAR_OPSS)
    call_task_dequeue()
      p->scx.flags &= ~SCX_TASK_IN_CUSTODY
                                             WARN_ON_ONCE(!(p->scx.flags &
                                                     SCX_TASK_IN_CUSTODY))
                                            /* opss is stale: QUEUED,
                                             * but task already claimed */
    set_release(ops_state, SCX_OPSS_NONE)

The race has been observed via two distinct call chains: the most common
goes through sched_setaffinity(), a rarer variant through
sched_change_begin().

For SCX_DSQ_GLOBAL / SCX_DSQ_BYPASS, dispatch_enqueue() clears
SCX_TASK_IN_CUSTODY before clearing ops_state to SCX_OPSS_NONE
(intentional, to avoid concurrent non-atomic RMW of p->scx.flags against
ops_dequeue()). The window between those two writes is exactly what
ops_dequeue() observes as "QUEUED without custody".

The observed state is not actually inconsistent, it just means CPU 1 has
already claimed the task and the QUEUED value held by CPU 2 is stale.
Re-read ops_state in that case; the next read is guaranteed to return
SCX_OPSS_DISPATCHING or SCX_OPSS_NONE, both of which exit the switch
cleanly. The retry is bounded: once IN_CUSTODY is cleared, ops_state has
already advanced past QUEUED for this dispatch cycle, and a fresh QUEUED
would require re-enqueue under p's rq lock, which CPU 2 holds.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
---
 kernel/sched/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 23f7b3f63b09..d285e37f2177 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2078,6 +2078,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	/* dequeue is always temporary, don't reset runnable_at */
 	clr_task_runnable(p, false);
 
+retry:
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
 
@@ -2092,7 +2093,9 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		/* A queued task must always be in BPF scheduler's custody */
-		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
+		if (!(p->scx.flags & SCX_TASK_IN_CUSTODY))
+			goto retry;
+
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
 			break;
-- 
2.54.0

