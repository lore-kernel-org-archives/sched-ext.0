Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28917490BE9;
	Wed,  7 Oct 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390410; cv=none; b=rUhq7z+lRJgDiMUFilEKnDdqQzaup4cd0ETusXJ1QIdy/eX5FPjzzJtDvye8MKvLCUxsRF9T0jzCWonO8Ag826hn5E+IF6rwEi+SyPq0+DXFegPz5ezEv1N48UnpLDoYkC/2zmtXA9Tl3BVj9DBJu+4w6fsanGlBU/v+OgppejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390410; c=relaxed/simple;
	bh=NOO2Utd1+LiriiW6d5H2cMEDHN7Lj/5gzM35BKKJqkE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=oxhwQCG07VgUc2uvI/XC5nMLGiWE05s3LUsJNr3HOry2Ku8DXFiUABKK706Rfn8Gy2qin99BxJ8dHq6u1KHc8Jzir4WMIsbOIahYaGHAlrI0splfq7TIG3sSyCz0tcOW5CgipmjHaEABHdj2ANY2E4uS4XqmPXFEGHTWniP7uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuDLY++8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuDLY++8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A132F1F000FF;
	Wed,  7 Oct 2026 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791390408;
	bh=xTk6ZSpyKI0cR+ISWGzBScL7TldzKEG6Bh1fMOkPui0=;
	h=Date:From:To:Cc:Subject;
	b=SuDLY++8iOA7ZOQoDDP2ybn3BgMlwj5vOLP7wdjaCk1xRkA79j4kMBB9shJwS7p+B
	 I9RnE/AR+huLXvUvFFsJImWX0TzSWiAFwAo1hg7sGQYo4cnBXwqFUifX4zCjZlonS/
	 8T+QyhBYjkgPhObq7Q2WOGrDg9rrdOip2Pq3K+ZJZaszjfv/UhH+z4mVLIuLpTlKjx
	 4BoSlpMKXqE2EuNIbMbRpMzNrz1qyWxfz1OMENPI74mFCzn2g0JBRcE1C8qdIoHH9H
	 AgjUoLoVDhO4ZpF2LSCq3+r82bFSJPrSK/mFRgsGLRR+ah/0Qm6T4QJMlcS02Qg6n4
	 ZH889IBwcIkOA==
Date: Wed, 07 Oct 2026 06:26:47 -1000
Message-ID: <2b405553751fe811b4cd2c24f307d961@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, Xiangyu Bu <xbu@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix stall when a task
 enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

With SCX_OPS_ENQ_LAST, the last runnable task on a CPU is passed to
ops.enqueue() instead of being kept running. Exiting tasks without
SCX_OPS_ENQ_EXITING, migration disabled tasks without
SCX_OPS_ENQ_MIGRATION_DISABLED and tasks on an offline rq skip ops.enqueue()
and go straight to the local DSQ. This happens in put_prev_task_scx() after
the pick has settled on idle, so nothing reschedules the CPU, which idles
with the task queued until an unrelated wakeup lands on it or the watchdog
fires.

scx_mitosis, which sets SCX_OPS_ENQ_LAST without SCX_OPS_ENQ_EXITING, hit
this during mass cgroup teardown: exiting tasks stuck in exit_mmap() for
over 40 seconds.

A task put on the local DSQ runs, as anywhere else. If the SCX_ENQ_LAST
enqueue left the task on this CPU's local DSQ, set need_resched on the task
being switched in, as proxy_resched_idle() does. resched_curr() would flag
the task being put instead, and __schedule() clears that right after the
pick.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Xiangyu Bu <xbu@meta.com>
Link: https://github.com/sched-ext/scx/pull/3870
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext/ext.c      |   13 +++++++++++--
 kernel/sched/ext/internal.h |    5 +++--
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3213,8 +3213,7 @@ static void put_prev_task_scx(struct rq
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 * This doesn't apply if the baseline access on the CPU is lost.
 		 *
 		 * Under core scheduling, a pick dispatches only when nothing is
@@ -3226,6 +3225,16 @@ static void put_prev_task_scx(struct rq
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			scx_do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+
+			/*
+			 * A task put on the local DSQ runs, as anywhere else.
+			 * Here the insert can't reschedule on its own: the pick
+			 * has settled on @next and @p is still curr, so
+			 * resched_curr() would flag @p and __schedule() clears
+			 * that right after the pick. Flag @next instead.
+			 */
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				set_tsk_need_resched(next);
 		} else {
 			scx_do_enqueue_task(rq, p, 0, -1);
 		}
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1774,8 +1774,9 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * The BPF scheduler is responsible for triggering a follow-up
-	 * scheduling event. Otherwise, Execution may stall.
+	 * If the task is queued on the local DSQ of the CPU it was running on,
+	 * it continues to run. Otherwise, the CPU goes idle. A scheduler that
+	 * wants a full dispatch cycle on the CPU should kick it.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
