Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4F3E3DB9;
	Fri, 10 Apr 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843514; cv=none; b=L7YZwLDMEp1ig3aPo1YUuVc2Za+dK8+pyyAmIsJ50cwWP7z8N/2evkPjPYJIGZ6vBl5YrRAY64V91o8+5hdmi5lDQOr6VxRL7TVRf10oY6i4zBWrT/65g++pbbvC7GuJfIKZTHEZ5cZmAm7u0DZ1GbP28DKj8eCmABZAxYNUg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843514; c=relaxed/simple;
	bh=J8J3+XfePlpZfpWwrf7K/zGVGVLEz7Gc5GahPR9n/dQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=NBj+2pbGEePxFERomyd+/jYuojXVyvssNQnq+Y1b+SnpVMD31B5hX66/h/wjP+yUz/Ct2hgw2bSB1Owf2WFPwlqz8UnhoyKJrDddy9voMwYyHb0peNYUVXe97oe5ghg+y9vKsKzGu8PYulTrEdqypa6/UIxKnKx4YZmXfy47onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWYfSTC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWYfSTC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21A8C2BC87;
	Fri, 10 Apr 2026 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775843514;
	bh=J8J3+XfePlpZfpWwrf7K/zGVGVLEz7Gc5GahPR9n/dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SWYfSTC1eUZeYulXbtqU2q3c9kpBwd2y1Oj51RNcMRBHLbQ9z+JJpQu3DY6I+58ED
	 T/cbQi6nGFkbvcmDKiWd62P53qYdqOqMVUutHabhmE95Ycat/eYSlUAWP0xHceRMLB
	 wWJitZatnPh7lgcfme5CQyaNSKZibIVyDhGYF5vgiZgBbhbSVKYEwqsbn1OCZFmCC/
	 S+bEgCZ2P3fP9oaehcJPf6PVawDct8mjNIx041aWY+J3LMGjG0UUnOXQlwSgllIoQ3
	 g3sQ8zt/Q4aovF9gIGM9ya/RISGp4Jauin3rpYY9b4opHg0x4NJ3GWVX9Ud5PvwkPB
	 VeqkgDutm6sMw==
Date: Fri, 10 Apr 2026 07:51:53 -1000
Message-ID: <b3e87aa43672ae32a39b60ea434ed4c1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] sched_ext: Decouple kfunc unlocked-context check
 from kf_mask
In-Reply-To: <20260410063046.3556100-6-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_kf_allowed_if_unlocked() uses !current->scx.kf_mask as a proxy for "no
SCX-tracked lock held". kf_mask is removed in a follow-up patch, so its two
callers - select_cpu_from_kfunc() and scx_dsq_move() - need another basis.

Add a new bool scx_rq.in_select_cpu, set across the SCX_CALL_OP_TASK_RET
that invokes ops.select_cpu(), to capture the one case where SCX itself
holds no lock but try_to_wake_up() holds @p's pi_lock. Together with
scx_locked_rq(), it expresses the same accepted-context set.

select_cpu_from_kfunc() needs a runtime test because it has to take
different locking paths depending on context. Open-code as a three-way
branch. The unlocked branch takes raw_spin_lock_irqsave(&p->pi_lock)
directly - pi_lock alone is enough for the fields the kfunc reads, and is
lighter than task_rq_lock().

scx_dsq_move() doesn't really need a runtime test - its accepted contexts
could be enforced at verifier load time. But since the runtime state is
already there and using it keeps the upcoming load-time filter simpler, just
write it the same way: (scx_locked_rq() || in_select_cpu) &&
!kf_allowed(DISPATCH).

scx_kf_allowed_if_unlocked() is deleted with the conversions.

No semantic change.

v2: s/No functional change/No semantic change/ - the unlocked path now acquires
    pi_lock instead of the heavier task_rq_lock() (Andrea Righi).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          |    4 +++-
 kernel/sched/ext_idle.c     |   39 +++++++++++++++++----------------------
 kernel/sched/ext_internal.h |    5 -----
 kernel/sched/sched.h        |    1 +
 4 files changed, 21 insertions(+), 28 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3308,10 +3308,12 @@ static int select_task_rq_scx(struct tas
 		WARN_ON_ONCE(*ddsp_taskp);
 		*ddsp_taskp = p;

+		this_rq()->scx.in_select_cpu = true;
 		cpu = SCX_CALL_OP_TASK_RET(sch,
 					   SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
 					   select_cpu, NULL, p, prev_cpu,
 					   wake_flags);
+		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
 		if (ops_cpu_valid(sch, cpu, "from ops.select_cpu()"))
@@ -8144,7 +8146,7 @@ static bool scx_dsq_move(struct bpf_iter
 	bool in_balance;
 	unsigned long flags;

-	if (!scx_kf_allowed_if_unlocked() &&
+	if ((scx_locked_rq() || this_rq()->scx.in_select_cpu) &&
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;

--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -913,8 +913,8 @@ static s32 select_cpu_from_kfunc(struct
 				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
-	struct rq *rq;
-	struct rq_flags rf;
+	unsigned long irq_flags;
+	bool we_locked = false;
 	s32 cpu;

 	if (!ops_cpu_valid(sch, prev_cpu, NULL))
@@ -924,27 +924,22 @@ static s32 select_cpu_from_kfunc(struct
 		return -EBUSY;

 	/*
-	 * If called from an unlocked context, acquire the task's rq lock,
-	 * so that we can safely access p->cpus_ptr and p->nr_cpus_allowed.
+	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
+	 * lock or @p's pi_lock. Three cases:
 	 *
-	 * Otherwise, allow to use this kfunc only from ops.select_cpu()
-	 * and ops.select_enqueue().
+	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
+	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
+	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
+	 *    nothing held, take pi_lock ourselves.
 	 */
-	if (scx_kf_allowed_if_unlocked()) {
-		rq = task_rq_lock(p, &rf);
-	} else {
-		if (!scx_kf_allowed(sch, SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
-			return -EPERM;
-		rq = scx_locked_rq();
-	}
-
-	/*
-	 * Validate locking correctness to access p->cpus_ptr and
-	 * p->nr_cpus_allowed: if we're holding an rq lock, we're safe;
-	 * otherwise, assert that p->pi_lock is held.
-	 */
-	if (!rq)
+	if (this_rq()->scx.in_select_cpu) {
 		lockdep_assert_held(&p->pi_lock);
+	} else if (!scx_locked_rq()) {
+		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
+		we_locked = true;
+	} else if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE)) {
+		return -EPERM;
+	}

 	/*
 	 * This may also be called from ops.enqueue(), so we need to handle
@@ -963,8 +958,8 @@ static s32 select_cpu_from_kfunc(struct
 					 allowed ?: p->cpus_ptr, flags);
 	}

-	if (scx_kf_allowed_if_unlocked())
-		task_rq_unlock(rq, p, &rf);
+	if (we_locked)
+		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);

 	return cpu;
 }
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1372,11 +1372,6 @@ static inline struct rq *scx_locked_rq(v
 	return __this_cpu_read(scx_locked_rq_state);
 }

-static inline bool scx_kf_allowed_if_unlocked(void)
-{
-	return !current->scx.kf_mask;
-}
-
 static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
 {
 	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -798,6 +798,7 @@ struct scx_rq {
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
+	bool			in_select_cpu;
 	bool			cpu_released;
 	u32			flags;
 	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
