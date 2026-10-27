Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060272;
	b=IZiYFtg8823b6Bx+fHolf5AqRlD4cC3lOD2D/UKSAuQQer9TcEXtPEcPA1wrXt+LAcJV
	 JNX1/BgQxWuUuiMxhqtXgPSZohI3xkh8bYYq3Wz/AqlxZGRLJZqLikE5r3VtlOz40RwWS
	 Pf3WnBdbVqP3EUyJbM6bnxBO9ERSxLJkZGWHdKzypiSupsMca/fOQmfiYQT98I6trQ6UI
	 v3W6ZDvgJcNQU40XtkoaA6QryqGnES69jpOiYzJnhU2OehqX4thIsWTXY1Vi6HHb2oW5c
	 qX+gzh+O6SEBRuKElF2DEDNO3BPxGb13ixI55LS5nQSZSxYhwE6MVaNoqGpmI/B6imQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G5jGp37TAZEFo9qCA9DNPVtlJ3p4aTVcndBab/5I5NU=;
	b=adu+eV22kAIRiZEmKxh+NsT1Iz1mkI3ZKN8SKw9fxATGLLYV9HqpwULxloUch+pebaWY
	 3wr973GBi5bJ/UEsb0K61V4u1dAd+aqAzUlpJfWy6XnN09+72FLw+pThlNkm/qVXwKY+S
	 lO6klw+lHRRLw8L1Y7f/8yz3TfuS75iMPh/Oe11O+XuJnkkHD5hUD8JJTwo2VWPA7Jjh7
	 Fi/fFgTHqCycKgH/F1t/VVm52Opy6OIXxf5844YjoCJkCwjsfRDeHZcgbUd3Piqrqr5ay
	 gp0tWGDl6aSXGU+t7D8ruSxIeKh6PhSHms4+mU6pBPH4ScYCZhgf8majpxWdciTgGSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJCiG2Sp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746A606A32E;
	Tue, 27 Oct 2026 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJCiG2Sp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105121F01825;
	Tue, 27 Oct 2026 00:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060272;
	bh=G5jGp37TAZEFo9qCA9DNPVtlJ3p4aTVcndBab/5I5NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJCiG2SpbDZ46EMjt2lPczBZbDhroQXhDxAEK1cto+6atYiVoUbWa5hPd+aoq2HEW
	 4JcgZJQY97h5hTC2gu7cOmaB5Qn3AanBQ6b03+3c4FwGxq6eH3gz/t8FEmSDJmMMZj
	 T3USutxxczA92Kz6cYiJlNG7pje8NwcEGazeUDPemFWVdmLyOlyqeb/T4jzscJ5xyN
	 n1xvvQcLo5gA5NLluJTuaCPn4w1M7KZk5ClMRmXXBqlSZGgZ4LsX1N9YjuibMNKcWP
	 wbwngt0ovhbjFD0KzfFcjKoKlGLqK9jwCS0U/K9E+teRamZg2azVHtLw9uCKlQRq36
	 tCWohWaOBxibw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/18] sched_ext: Clear holding_cpu where the claim is confirmed
Date: Mon, 26 Oct 2026 14:17:33 -1000
Message-ID: <20261027001749.1821379-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
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

The bypass load balancer will take tasks off a remote cpu's bypass DSQ with
unlink_dsq_and_switch_rq_lock() in the following patches and insert them
into another bypass DSQ. Clearing holding_cpu after the claim is up to each
claimant, so the balancer would need a clear of its own.

unlink_dsq_and_switch_rq_lock() marks a task with holding_cpu for the gap
between dropping the DSQ lock and taking the task's rq lock, so that a
dequeue in that gap can tell the claimant it lost. Once the claimant holds
the rq lock and finds the marker intact, nothing can take the task away
under it and the marker has no reader left.

Each claimant clears it at its own site after that point:

 - dispatch_to_local_dsq(), which runs the handshake inline, in its same-rq
   and fallback branches
 - scx_proxy_reject_task() for the proxy reject
 - the dequeue inside deactivate_task() for both remote moves

Clear it where the claim is confirmed instead and drop the explicit clears.
No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 19 +++++++++++--------
 kernel/sched/ext/internal.h | 11 ++++++-----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a9621bbdb183..0c0046766542 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2865,7 +2865,6 @@ static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
 	lockdep_assert_rq_held(rq);
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
 
-	p->scx.holding_cpu = -1;
 	p->scx.flags |= SCX_TASK_REENQ_PROXY;
 	scx_divert_strip_flags(p, &enq_flags);
 
@@ -2899,8 +2898,9 @@ static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
  * tell whether we lost to dequeue by testing whether the holding_cpu still
  * points to this CPU. See scx_dispatch_dequeue() for the counterpart.
  *
- * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @p is
- * still valid and detached from @dsq. %false if lost to dequeue.
+ * On return, @dsq is unlocked and @src_rq is locked. Return %true if @p is
+ * still valid and detached from @dsq, with holding_cpu cleared. Return %false
+ * if @p was lost to a dequeue.
  */
 static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 					  struct scx_dispatch_q *dsq,
@@ -2923,11 +2923,13 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 	if (likely(p->scx.holding_cpu == cpu) && !WARN_ON_ONCE(src_rq != task_rq(p))) {
 		/*
 		 * Keep ->dsq set until we own @src_rq so that a racing dequeue
-		 * can find @dsq and clear holding_cpu. Once ownership is
-		 * confirmed, clear it under @src_rq so that deactivate_task()
-		 * takes the !dsq path instead of retaking @dsq->lock.
+		 * can find @dsq and clear holding_cpu. Once we own @src_rq, the
+		 * handshake is over. Clear ->dsq so that deactivate_task()
+		 * takes the !dsq path instead of retaking @dsq->lock. Clear
+		 * holding_cpu with it so that no caller has to.
 		 */
 		p->scx.dsq = NULL;
+		p->scx.holding_cpu = -1;
 		scx_wait_dispatching(p);
 		return true;
 	}
@@ -3163,20 +3165,21 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
 		bool fallback = false;
 
+		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
+		p->scx.holding_cpu = -1;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
 		 * abbreviating move_remote_task_to_local_dsq().
 		 */
 		if (src_rq == dst_rq) {
-			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
 		} else if (unlikely(task_proxy_unsafe_to_move(p))) {
 			fallback = true;
 			scx_proxy_reject_task(sch, src_rq, p, enq_flags);
 		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			p->scx.holding_cpu = -1;
 			fallback = true;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, slice, vtime,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 80c746054ce7..752a9a2a94b0 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2157,12 +2157,13 @@ static const char *scx_enable_state_str[] = {
  *   4. Lock src_rq (where the task currently lives)
  *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
  *      race (dequeue clears holding_cpu to -1 when it takes the task), in
- *      this case migration is aborted
- *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
- *      into dst_rq's local DSQ (no lock swap needed)
+ *      this case migration is aborted. Otherwise the claim is confirmed and
+ *      holding_cpu is cleared here, see unlink_dsq_and_switch_rq_lock()
+ *   6. If src_rq == dst_rq: enqueue directly into dst_rq's local DSQ (no lock
+ *      swap needed)
  *   7. Otherwise, verify under src_rq lock that the task can be moved to dst_rq
- *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu,
- *      leave the task on src_rq, and enqueue it on the fallback DSQ.
+ *      (CPU affinity, migration_disabled, etc.). If not, leave the task on
+ *      src_rq, and enqueue it on the fallback DSQ.
  *   8. Otherwise (i.e. if the task can be moved to dst_rq), call
  *      move_remote_task_to_local_dsq(), which releases src_rq, locks dst_rq,
  *      and performs the deactivate/activate migration cycle
-- 
2.56.0

