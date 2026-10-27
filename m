Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060277;
	b=e0g7ki9kVq8c6VSTkVW4MAI6//+tAJacKGGIfLfr6cCsiWyj+xgL7WaeTEPwbrOuL0Do
	 iHobOqQBQiC9q1crTWPdixYBzUGNOrow7HxDkP/aJPRcSLjSzl2FkbugiZUDWS0Vo7obh
	 TmECdN4bQkmf3E83jHVby6u2estRtZbX2c0Re65OIFXG3beTSVqXnz0deHvpEksGPABJh
	 +/fsrz2ak794CEPkF0dlJwm6OO18U/JUytiB1XUdK6joHuJPr+O7RprqEFgFci57YUEst
	 kW8PEKPSXTxmhfEcs+xt10rDV8wT4gfAqzCjG5sky/+3efswgAHdwly6iE4mq1EK9+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aD+m4fgT/murgPZ1dfJAGfgzlDNjMXHqsMTjsdbRhno=;
	b=cZKgsgn/9fPYsFY3WgxgmbgVN3qrJ+8XFai5Ls57sO0lWUm8gPScA+W3lgnmncTAeiBM
	 QAbX2/dcFmGa+nk/KUM50Ho2bJ3UBbyP+AnFaP6PMFyUclZ43FYgmn+tP10AlYl57EuPr
	 5mSpM2lR8W92zFjhHzKH/5r6Br9Elj3foUL1nPAwgkxiFkJSxN8iUE/kB6qUrBsP2ytuN
	 EUX5fXRjrBbhS1BIPcc3h//etMzcDWOqkZRGZ7YoDz/Jiq7tOOoXkFrQT87Icr2Upvo1p
	 zyiDIhm7JHG6KVZC76aGfYB6Vyr744MzH8PA756j8FxvH0BAT3upuoobNrfMTYCRSaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECcBRdnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B83606A320;
	Tue, 27 Oct 2026 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECcBRdnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414DC1F031E8;
	Tue, 27 Oct 2026 00:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060276;
	bh=aD+m4fgT/murgPZ1dfJAGfgzlDNjMXHqsMTjsdbRhno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ECcBRdnbLgEBoCNpm0xFgZXmD2EwNBgkoe0dGKVjuz8y31Ndn5dfV3zjFJKN7PuqH
	 h+typ95TkrvOdAoQ3sL6Z3UXqXMKKiBiwtV5Qbqk7XeAt1StB4bU38nu2WG+XrQGgS
	 LurI1ihsC26qxCBxzLIeSyOJrk185lN0jzZTtsxsAReKs2pyK0lm4cP37NcTgAJAzS
	 LYPQwfkUorVNHZDN9+YrWNAzTxAlxmfOArO2ouIQNIiTr99nMpAG0SX3sUR6QmI9lp
	 Uo0kXMEAp8RznuQZF16rdEo+t4+QyIqbDfWgvWsZnXVu62953EyBqm1okQn1x3HIEj
	 K2kCerG1aP/4Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 06/18] sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
Date: Mon, 26 Oct 2026 14:17:37 -1000
Message-ID: <20261027001749.1821379-7-tj@kernel.org>
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

Rescue measures served time as the rescuee's sum_exec_runtime minus a
snapshot taken at admission. Under proxy execution that measure follows the
wrong task. update_se() credits sum_exec_runtime to rq->curr, the mutex
owner that executes, while update_curr_scx() drains the slice of rq->donor
and charges its rescue. A rescuee can be either, so its served time and its
slice disagree in both directions.

As the owner running for another donor, the rescuee accrues served time that
drained no slice and charged no budget, and its rescue ends early. As the
donor, its rescue runs long:

 1. the rescuee blocks on a mutex and the owner runs in its place
 2. the owner's run drains the rescuee's slice and the budget, but not the
    served time
 3. the slice runs out with the rescue still open, and scx_rescue_keep()
    restores a remainder that the owner's run didn't reduce
 4. the owner keeps running on the rescue until it releases the mutex, past
    the admitted slice and overdrawing the budget

Count served time in scx_rescue_charge() from the delta that drains the
slice. Charging the owner's run to the donor's rescue matches proxy
execution, which drains the donor's slice and accounts the cgroup time to
the donor for the owner's run.

scx_rescue_keep() also ignored the return of scx_set_task_slice(). The call
refuses the restore on a rescuee that escalation marked SCX_TASK_PROTECTED,
and the rescuee was kept with a zero slice and its protection set.

That refusal is now unreachable. Escalation sets the slice to the unserved
remainder before it protects the task. From then on every slice write a
scheduler can reach is refused. Only a sub-scheduler's task is rescued, and
sub-schedulers are cid-form, which rejects direct slice writes.

The slice then moves only by what update_curr_scx() drains, and that drain
charges the rescue by the same amount, so the slice runs out exactly when
the charge ends the rescue. WARN and end the rescue if the restore is
refused anyway.

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 25 ++++++++++++++++---------
 kernel/sched/sched.h   |  2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a7b14ea16822..998888ca5ea7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -428,9 +428,7 @@ void scx_init_root_caps(struct scx_sched *sch)
 /* unserved remainder of @rq's rescuee's admitted slice, 0 once fully served */
 static s64 scx_rescue_slice_remaining(struct rq *rq)
 {
-	s64 served = rq->scx.rescue.curr->se.sum_exec_runtime - rq->scx.rescue.exec_snap;
-
-	return max(rq->scx.rescue.slice - served, 0);
+	return max(rq->scx.rescue.slice - rq->scx.rescue.served, 0);
 }
 
 /*
@@ -465,6 +463,14 @@ void scx_rescue_charge(struct rq *rq, s64 delta_exec)
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Count @delta_exec as served before the clamp below, which bounds only
+	 * the budget charge. update_curr_scx() took the same delta off the
+	 * slice, so a slice set to the unserved remainder, as escalation does,
+	 * reaches zero when the remainder does, see scx_rescue_keep().
+	 */
+	rq->scx.rescue.served += delta_exec;
+
 	/*
 	 * A rescue slice is bounded by one quantum and tick-driven expiry can
 	 * overshoot by up to a tick. Clamp to avoid wild over-charges on VMs.
@@ -525,7 +531,9 @@ bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
 	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
 		return false;
 
-	scx_set_task_slice(p, remaining);
+	/* never called on a protected rescuee, so the write can't be refused */
+	if (WARN_ON_ONCE(!scx_set_task_slice(p, remaining)))
+		return false;
 	return true;
 }
 
@@ -608,10 +616,9 @@ static void scx_rescue_timer_arm(struct rq *rq)
  * @slice: CPU time to grant
  *
  * The schedulers keep their normal control over @p and may preempt or reslice
- * it. @slice is measured on served CPU time against the snapshot taken here, so
- * neither shortens the rescue, see scx_rescue_charge() and scx_rescue_keep().
- * Prolonged denial escalates into protected execution, see
- * scx_rescue_timerfn().
+ * it. @slice is measured on served CPU time, so neither shortens the rescue,
+ * see scx_rescue_charge() and scx_rescue_keep(). Prolonged denial escalates
+ * into protected execution, see scx_rescue_timerfn().
  */
 static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 {
@@ -620,7 +627,7 @@ static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 
 	rq->scx.rescue.curr = p;
 	rq->scx.rescue.slice = slice;
-	rq->scx.rescue.exec_snap = p->se.sum_exec_runtime;
+	rq->scx.rescue.served = 0;
 	scx_set_task_slice(p, slice);
 	scx_rescue_timer_arm(rq);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 628765910934..dcc639998069 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -816,7 +816,7 @@ struct scx_rq_rescue {
 	u64			clock;			/* last budget accrual timestamp */
 	struct task_struct	*curr;			/* task being rescued, one at a time */
 	s64			slice;			/* curr's admitted slice */
-	u64			exec_snap;		/* sum_exec_runtime at admission */
+	s64			served;			/* curr's served time */
 	struct timer_list	timer;			/* paces admission and escalation */
 	u64			kill_at;		/* last ejection, init before any */
 };
-- 
2.56.0

