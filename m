Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0E53A3B3
	for <sched-ext@lists.linux.dev>; Wed, 23 Sep 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172480; cv=none; b=N0Dj+velaSDxb3gFwp5BLZJC9DIxixefwo1/DmRTfcstPV5R1zKjY/etcR50+joJZTMJVsEZQPSDwrVlvjd+MCrbVAv12Czp2dS9div+bILrhsvyO09mhAuQmmiIObLp5CNn8iYPrqpodTIEKVo4liXCVwEwFTdAVpccQXUdXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172480; c=relaxed/simple;
	bh=pdlIPUjgc641og+5ljWmUNziLLzZYsmLnc8hlsa0+Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVt3G1XV3FrPC1QQXNSK7QbXPH2GHCNFYKKJ/WW2tdR89C+gaHkpRL7nq7vRR9SbMW/EyxLyxo0+N+Nsb0+1JIFxkgNiDHvDw7JcCfpkDy9EwcNxlLH8DLUvJEVnLj+JcFxxjX0o+aUT7qc5RHbYfRFR2YFZejFImkzcuMR8Mhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gcxq+zIu; arc=none smtp.client-ip=91.218.175.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gcxq+zIu"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=pdlIPUjgc641og+5ljWmUNziLLzZYsmLnc8hlsa0+Lo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790172474; v=1; x=1790777274;
 b=Gcxq+zIuVO3WbOR/aCUOrGGbEkRYu958J2EQs4UDICzQjvamZ9AGNgoojlGgS+r8xBE2UAUq
 AGn6R47H0kCT4RNXiZx8ofVgsaPYG8t8gB6VFzt73/WtOj+30I7qHHok7G5UwQByTw5KhH7uEEN
 gSRvhw8DDFWH1VwRCvSfm/1A=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id f43060941825ca69;
	Wed, 23 Sep 2026 14:07:54 +0000
X-Mizu-Trace-ID: f43060941825ca69
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] sched_ext: Avoid relocking DSQ during remote consumption
Date: Wed, 23 Sep 2026 07:07:50 -0700
Message-ID: <20260923140750.2128382-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A remote consume unlinks a task from a non-local DSQ before switching
to the task's rq. Leaving p->scx.dsq set makes the following
deactivate_task() reacquire the DSQ lock in scx_dispatch_dequeue() to
clear the transfer state.

Keep p->scx.dsq set while switching rq locks so that a racing dequeue
can find the DSQ and cancel the transfer. After acquiring the source rq
and confirming ownership, clear p->scx.dsq. The subsequent dequeue then
takes its !dsq path without reacquiring the DSQ lock.

Fleet profiles show that roughly 70% of the cycles attributed to
scx_dispatch_dequeue() are spent in queued_spin_lock_slowpath() while
taking dsq->lock.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cf8e32044ffb1..0135ff6824b03 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2612,7 +2612,7 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
  * points to this CPU. See scx_dispatch_dequeue() for the counterpart.
  *
  * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @p is
- * still valid. %false if lost to dequeue.
+ * still valid and detached from @dsq. %false if lost to dequeue.
  */
 static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 					  struct scx_dispatch_q *dsq,
@@ -2632,8 +2632,19 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 	switch_rq_lock(locked_rq, src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
-	return likely(p->scx.holding_cpu == cpu) &&
-		!WARN_ON_ONCE(src_rq != task_rq(p));
+	if (likely(p->scx.holding_cpu == cpu) &&
+	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		/*
+		 * Keep ->dsq set until we own @src_rq so that a racing dequeue
+		 * can find @dsq and clear holding_cpu. Once ownership is
+		 * confirmed, clear it under @src_rq so that deactivate_task()
+		 * takes the !dsq path instead of retaking @dsq->lock.
+		 */
+		p->scx.dsq = NULL;
+		return true;
+	}
+
+	return false;
 }
 
 static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
-- 
2.53.0-Meta

