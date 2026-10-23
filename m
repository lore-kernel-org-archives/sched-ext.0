Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733096;
	b=DmdwczSdi2mUAKDV/BdoWbOCxxJoJ5n7Uu5KWTcoGOcZz7+cPyW1yJCJqzhRf5r/Eqc9
	 gzOYT9FmZXXPsuWukIVg4sNZ4IolxvNpWVkwJ0xAoABp1uyQ0XQb05NpZkyuT3AiXH9Yc
	 siEuP1NQTComj3+Hi+va8OzTdHYN9r1dEdfXm9VEUXnAxWIE8egnFM6TSMlw0Q67Mfsaf
	 Cz4bAu/PsCILern4JOqBhX8lHZqfJGVJ3ulMgXuwyYwnlpkLgAb2rx8czPD6yBYjJVXzO
	 5z99Mbr9oDWFSMYh0htTeKNi7eLW0VHbvhjJqT2p/Nw+pBU+mLS/FZMOjWAmZw5ROvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wRpA4vF4Sk/UfaW67b88A9WROnoA0uJnVaDmwLQ3n0Y=;
	b=JstBNIQyjeLxvDN0bl+odIqWXV62+2bZgcLrYCUxwCbxlktSqaHKWlUbpQgfysKpGkq6
	 bayRARysnI6I71hVR9ETPXRSjhrDmK+ZWjnja3sODN6VpKMh4C00tw8zPfZbjZSdlUWU7
	 qMmhvYCrwQ+W+oeb+573VEEr9PRu7fMqPnbtbDbrkokxjKoc5SxiMwFkEnsywYvpKip+B
	 O7CV2y+MG9RxeldKxn7UPeFXgnuDoo8ycCmJ0m6gtPwNZlczXNLLQPPS/P1QQdGfFYpYx
	 Jh+7r6nPfE1R6h5OH/qWBJdmXE3bqAyEznJzCXvXwTq195lkdCM+kLwKdbuPB1Brhhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpJyqOFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F1606A32C;
	Fri, 23 Oct 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpJyqOFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDA1F01828;
	Fri, 23 Oct 2026 05:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733095;
	bh=wRpA4vF4Sk/UfaW67b88A9WROnoA0uJnVaDmwLQ3n0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpJyqOFUTqB8TmPshpe4LzneastbZoXU6vPr3ivgo+DGC3Mhubhqp2fdjvEyhrgb6
	 KS4EuMq6vta4aqK89CtYthfWL8OWrgpRrgnWGQlaHRfyaNcZMWzgejNO8D1qH33BqY
	 KuyDMoYkF1P/P534YHY3GlzlxXBngI9DW0m2OgF1nKWe/+wAMB+Xi2XAdlOUIpCJrz
	 JOK21D2dVUBw+NbBGQ9KmCElthxF2Pnd9ruPlSgr0rdlkz1WZMYFW/J7TM9hn+ZeFx
	 PJvT92ZbVLHcFbJ7NOa8qzgJJ1AZSHewjTpg0F/JoyZjj+4oJ0bPgx1obK4llOcZQC
	 LyqdQonH2x80A==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/15] sched_ext: Clear holding_cpu where the claim is confirmed
Date: Thu, 22 Oct 2026 19:24:39 -1000
Message-ID: <20261023052452.2889061-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023052452.2889061-1-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
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

