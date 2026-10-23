Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778176;
	b=ZQ/FXRDOD8QjV8vs0nbuy42NAke5wmoMxqRIEpb6foeB1PuMq/MfD+x+NakofuSIkXsG
	 pref9sbK93w7L+o9JcbllJsIQwJ6swMbSzv/beCwghJtpG9SmQsoqjetZ6slWYe8nLgVH
	 klxQo7Hke71uHHZnGudq90D2ugWwYTc1Vm5ciI/nbhPitvSTenBlTAO0aj40XfAh07NHF
	 mgihhferpxK/bgXFd2x1DEpyOcYCLumSVrztS/BHU7o/ApbeHOXM0toafnt16hw7yPLMV
	 Tu8G3V+0mPRlk1tqG1+RLCbPMwyEcgjqOLu6fVcKnkmSkYx+0UlpCKk2T7rbcmYe+Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TrnHyjwghxoHH/7ZIa6c/atV7JqUeXQradytyyHUl5E=;
	b=NRA2ahyhHcYMVxSG4/l+h9lN95epaKYob4pDoXtE9uasDxOteGqmZiU571JkqQIOANW6
	 7WG74Dj5XJymdJD0L0GwxD7FoHdFRC8MLT7xfXcPnI9d4f4WIAQQYNqcOvHT8JSuQpoXP
	 imSxQ7Z5VmT74inKghYVE7CVI4dx7j7lgIUz9DyYJ8WveBrOrHN946Atppa2lVj0LhYoN
	 m1+GjAO7dpukKOwWBhNrOOU+Nb8a7ntohFj/zu5fmtn26uoz4RQepefAugRmVvoo8y5KA
	 NWVlMxZx9VP4EhtuCUc7JVTufp1rulwkV3j7x9U9MvgEshUTe94DFZfukypDReS3CzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="muIaeUY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A960A2603;
	Fri, 23 Oct 2026 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muIaeUY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D71F031E6;
	Fri, 23 Oct 2026 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778175;
	bh=TrnHyjwghxoHH/7ZIa6c/atV7JqUeXQradytyyHUl5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=muIaeUY/4c2V4HYqDZTrhcah566CAKzt7m0chf/CvpV32B7c1DtOI4dXBoeO9brcO
	 6+xH9RkqoX0ELgPV93njqrLJf4ggE8ZqNoNwIn9trRcdjSvbiv1y28xsUZpCO2Y6ir
	 ZMW4ggj4q4k5xhwqK23x6n5o9L4AMMLhh9tbmDt/tNsK0ELPqVqpKWtSCHU7LCmDP/
	 0w8laurlKNS2eLvQzBlsMRhS8E4fdcHJXJWbh2tWQ6f0qmiHRYtPJrBTDb9TDyYGJ5
	 CAIvs6DfDE5WUf41Y3V9aL23CuDAkQBLfn8XEMrg4Vah0YelyFx//S8V/TRtmfVheG
	 TYdtV7PRqku/A==
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
Subject: [PATCH 06/17] sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
Date: Fri, 23 Oct 2026 07:55:57 -1000
Message-ID: <20261023175608.4120910-7-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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
index d3db1277118e..d3f89ec4e4fa 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -401,9 +401,7 @@ void scx_init_root_caps(struct scx_sched *sch)
 /* unserved remainder of @rq's rescuee's admitted slice, 0 once fully served */
 static s64 scx_rescue_slice_remaining(struct rq *rq)
 {
-	s64 served = rq->scx.rescue.curr->se.sum_exec_runtime - rq->scx.rescue.exec_snap;
-
-	return max(rq->scx.rescue.slice - served, 0);
+	return max(rq->scx.rescue.slice - rq->scx.rescue.served, 0);
 }
 
 /*
@@ -438,6 +436,14 @@ void scx_rescue_charge(struct rq *rq, s64 delta_exec)
 
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
@@ -498,7 +504,9 @@ bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
 	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
 		return false;
 
-	scx_set_task_slice(p, remaining);
+	/* never called on a protected rescuee, so the write can't be refused */
+	if (WARN_ON_ONCE(!scx_set_task_slice(p, remaining)))
+		return false;
 	return true;
 }
 
@@ -581,10 +589,9 @@ static void scx_rescue_timer_arm(struct rq *rq)
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
@@ -593,7 +600,7 @@ static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 
 	rq->scx.rescue.curr = p;
 	rq->scx.rescue.slice = slice;
-	rq->scx.rescue.exec_snap = p->se.sum_exec_runtime;
+	rq->scx.rescue.served = 0;
 	scx_set_task_slice(p, slice);
 	scx_rescue_timer_arm(rq);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 37d4808d7f19..6fed367feda4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -807,7 +807,7 @@ struct scx_rq_rescue {
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

