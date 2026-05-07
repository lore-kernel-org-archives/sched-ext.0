Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B33CF02E
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162218; cv=none; b=T55biCcBK9KRx5LwjCqc9M2yCiFT6U5ZDdF9IUadQs5ljkRpZNSclbXwHRTD8F18WIrToO2BWFwtrRkRhJuYN6v/PI/mYz6jRA0dDFY/Q4HdmVKc+uCGZEShw6OjU0Zag5AErhyhBD1UdnPXMTSbR3rSPlM3kFpQXlLVCyftn4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162218; c=relaxed/simple;
	bh=pqdr3ax+f4ePOA8BTD4LqskkoqSbDO+aLu5WelMH8Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=et2xgLnquVV4Zc5jubVB2AAag9WpwDjhF6rUn2kuExz2+MQ0ghKoJ6vboyr8hIdXmH2XZgKY1IUBQ5uNNPwmNBkxlwDj18yspUE0lZIvu+kyT6XLfaeXUvqesnqobNJ/QOeMxRLNjSCw2UhL2j9fCqKKzU6Jp/JG6aaGzoK9ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=moEygt/K; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="moEygt/K"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB1A2641;
	Thu,  7 May 2026 06:56:49 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.92.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A60B3F763;
	Thu,  7 May 2026 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778162214; bh=pqdr3ax+f4ePOA8BTD4LqskkoqSbDO+aLu5WelMH8Bk=;
	h=From:To:Cc:Subject:Date:From;
	b=moEygt/KX3xLpNLaj99p+oOmsxCwK5o3Zua+3BD+bRooX22xJnRp3y08dCVj3w7Fu
	 vyoUEMkoVsRCfxgkcv73hwhbK3isDlLhp6U5W/F93DVUyW91IA1n8EeEDKqkmAJvKz
	 dfAw0hVV7Fvuuu9pthYJHBCeiDIWtwdfvo9i8VlA=
From: Christian Loehle <christian.loehle@arm.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
Date: Thu,  7 May 2026 14:56:42 +0100
Message-Id: <20260507135642.692290-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When aborting, consume_dispatch_q() breaks out of the task iteration
loop entirely for non-bypass DSQs. This prevents CPUs from consuming
even their own tasks (where rq == task_rq) from any DSQ.

This causes a deadlock during CPU hotplug:

1. The BPF scheduler's cpu_offline callback calls scx_bpf_exit(),
   setting sch->aborting and queuing the disable_work on the helper
   kthread.

2. The helper kthread (and other tasks) are stuck on the global or
   user DSQs because bypass mode hasn't been entered yet.

3. No CPU can consume these tasks due to the aborting break, so the
   helper never runs scx_root_disable() -> scx_bypass().

4. The cpuhp thread is stuck in balance_hotplug_wait() because the
   dying CPU's rq never drains.

Tasks on user DSQs are equally affected: BPF schedulers can dispatch
RCU and other critical kthreads to user DSQs, causing RCU stalls when
those tasks become unconsumable.

The aborting check was added to prevent live-locks from the remote task
migration path (consume_remote_task() -> goto retry), but also avoid
holding the dsq->lock for too long.

Change the break to skip only remote tasks via continue, allowing each
CPU to still consume tasks already on its own rq. This unblocks the
helper kthread, lets bypass mode activate, and allows both hotplug and
RCU grace periods to complete.

Fixes: 5ebec443fb96 ("sched_ext: Exit dispatch and move operations immediately when aborting")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
RFC:
I guess this reintroduces the live-lock of a BPF scheduler having a
highly contended DSQ with a lot of tasks and the outer loop holding
dsq->lock and therefore it still taking too long for the bypass to
activate, is there a better way?
I also couldn't trigger a lockup through that, did I just not have
the right platform (e.g. 2x Intel 8480c). Should we add a selftest
for this too, then?

 kernel/sched/ext.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 345aa11b84b2..3cce200708b0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2463,10 +2463,13 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		 * a contended DSQ, or the outer retry loop can repeatedly race
 		 * against scx_bypass() dequeueing tasks from @dsq trying to put
 		 * the system into the bypass mode. This can easily live-lock the
-		 * machine. If aborting, exit from all non-bypass DSQs.
+		 * machine. If aborting, skip remote tasks from non-bypass DSQs
+		 * but still allow consuming local tasks to prevent deadlocks
+		 * during CPU hotplug where the dying CPU must drain its rq.
 		 */
-		if (unlikely(READ_ONCE(sch->aborting)) && dsq->id != SCX_DSQ_BYPASS)
-			break;
+		if (unlikely(READ_ONCE(sch->aborting)) && dsq->id != SCX_DSQ_BYPASS
+		    && rq != task_rq)
+			continue;
 
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
-- 
2.34.1

