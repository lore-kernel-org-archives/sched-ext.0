Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705120;
	b=zJQqX/w6ckH7Dr0x0uHNvE9mOUii98/Vxsdz+cRl2lKtNWsk6aYVXpDAin3Ps/otLhy5
	 PQJCLsvtaJYLVMLJvjqeYkhua+FDlaNrECF9HfVJeEaxs8i39+LIdIeQELxu/wy1JPj/X
	 mUoqrbBejbxCFfnslq5G9X0V9nMQu4E+02I5wnY7mXXDe4BsJLe+K4Dbcf7LGJQE9RJV4
	 fC/OE6hEwJZJX+1arw1xwlaq8h56/SVDEACv9FCWildyTUMi/Gt81UI4kV0OKim0143+U
	 pwrDYGsKpcPfNehz1bkQozQNRuExnF5vjyFVcoXxrz/ukgACMTlefI3WQZMF8wl8c2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wRpA4vF4Sk/UfaW67b88A9WROnoA0uJnVaDmwLQ3n0Y=;
	b=Nomn8isXkNROOpSM/nCO70F4fDrlEU7saRHVBpq8AhfRrD1iPz6gDzvHq5k4s9jeFZoR
	 EV1wTin0F/K/dq7JKb6INEeqTM1+bqCRurtiUfjPM+moUboTubJmCA8mxRaOjgUJgIg07
	 kxch2fwRkChpm7gJyf9eJnxnNoaMNs9Q/Xq4krEtDdJLtJ3+7kW9q8oZwE/lgxHNmoVMm
	 zKibwA8sQQNbLYMbzMruYnigp1xTs1LBrEs81755aESv+mF6STxeBCL+5Qfp+uyhOJzJs
	 DZ44r4Awywf2R/9hk1AItWFC8Cp4ImCI227mLGQk7wR66YZBw2uF6bPWOzpkHOb79rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/utO1P+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBED606A327;
	Thu, 22 Oct 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/utO1P+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7461F01825;
	Thu, 22 Oct 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705119;
	bh=wRpA4vF4Sk/UfaW67b88A9WROnoA0uJnVaDmwLQ3n0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/utO1P+ZMth9zW4yK25p3FS0Vd+40+8Bf5Rex3tUMdzpkfL/A/gA/LREm1NzZrCz
	 oVKkXzaWR9QR5KWRSpjCYHsQjs4i4X2i/0/PXwcKalbVAbbhrMksNxVELFAU6guP9g
	 bmL5JUVJRAIxi2SU5CUt5nAh1+4Vxx2cVzFe3jkHAncZK0zE0SFvU7RK5+mWrhZcFt
	 HKsFDeisRWV/clWWmgUwRqAW2lFGe38BinJAhD4ZOHgdUzWY4u1e3aH1zIUlV9wJ4i
	 q4a6Dy6otJ4Gwiu2YNXuS/iTuhKwqxxpPEEdcznFLkclSdH32b+ba13bzW9RifbUYf
	 DlP2xjx0Q8Frg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/14] sched_ext: Clear holding_cpu where the claim is confirmed
Date: Thu, 22 Oct 2026 11:38:24 -1000
Message-ID: <20261022213836.2259069-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
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
index 07857039aee6..bb36264e626f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2829,7 +2829,6 @@ static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
 	lockdep_assert_rq_held(rq);
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
 
-	p->scx.holding_cpu = -1;
 	p->scx.flags |= SCX_TASK_REENQ_PROXY;
 	scx_divert_strip_flags(p, &enq_flags);
 
@@ -2863,8 +2862,9 @@ static void scx_proxy_reject_task(struct scx_sched *sch, struct rq *rq,
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
@@ -2887,11 +2887,13 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
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
@@ -3127,20 +3129,21 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
index 29e69a83d876..44ede6e6fe1a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2107,12 +2107,13 @@ static const char *scx_enable_state_str[] = {
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

