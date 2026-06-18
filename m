Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4340D56D
	for <sched-ext@lists.linux.dev>; Thu, 18 Jun 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802072; cv=none; b=s5LM6V4RymRiWp3bc5kg7hQvnAlkryvf9Z8JMG+YxVErKGnWRtEVZEBFiD8qBz3zeTfDP1nfU8tHW1bBb99CFabhFL9zDM32A+fae5yvk/EddWPiiRu4MM+qYfpXFoB4jF1mibfcV8rS6IRmIOLy6xqeP0u82OddjBnqep/98A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802072; c=relaxed/simple;
	bh=POJxynirHEvhbXzJ6PdnZWrfxi2J/LOpvCGQAOXWUjs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tqQRKYaYbnK2ggOxO42vPqkFlFFDlADHh6fJhepXWUXiPsktjzVQKUINqYYHuJK3Py+scYmgRYJsMAGLPlbS9KyN/6DX86JenHWYZo/iaURJmLi0sbeFWE9ue9ug7npUhSSqV0YuUXLvKfg8jrHyKrrALrVYpSP5Irg004rkNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pt+jF2Co; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pt+jF2Co"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bf2dfdc0582so116541866b.3
        for <sched-ext@lists.linux.dev>; Thu, 18 Jun 2026 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781802070; x=1782406870; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SuGr+RI9/ZxkyJkzsqDtqWFtFCFTkeJWpb4pHOiDdk0=;
        b=pt+jF2CoI4k9Uo2JCgGiId6V4PcJi6rm4MBiyzfQSEh6hobwUJfeLeLA+H5m9cj55E
         ToTS8cuYMRKn50LxJ4JKQV577C7kS5L30/6juGLzF2cCC80Ltuzffb6JwkTq+bt1Xmfy
         P0zr6WQ6oy+zsUVyQFlUVXEj5loPbRz4vx85EmSlV8xllqMUc3o5tvdiu0tnjNSdDHit
         gUcg9rJ4AOGLM3XYqgf/Bwm6YXYGzbjqwbFeFoT6HG/7xiX6xJ9hkpp4tB5i1ogh947X
         HLfCd6m0iDvBO4ZE4DX4hB/I4ufwFSJGhV3QXwCdFaa6XstTenS7HoHy+ZQ/ep0xu/J6
         ILhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802070; x=1782406870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuGr+RI9/ZxkyJkzsqDtqWFtFCFTkeJWpb4pHOiDdk0=;
        b=jSXMQHNQCuIFsDMvctTiyLHQtmRgewMEhexGXZd3wWTjMMSD35zUi0ZnQI5P2psDy8
         QLqj3264K4aq8YT2DGMf8ZrwIxn/DRAYyoiW/xr7W/nLSvC4GqXzy95hcb2FZBVauDMY
         qZnX15AQ1yJK7N3qCyWM6jwkN/UqYA5PU4kSB5xVP0/i4VzcBYd9OnImSGBPVNqKCVp5
         nBVzQFEEdLDIBKCUuIpMa00ZJkeJajGwF0AtSrWKBFoqioWTOKtcijaayf5T5VNlZP8f
         StRf9wzqYk+xKE609UUKN9OXxuAeqO7kjoHTk+CNYh/H9ono/dyY5FDCQEqdOZ1Rt/xH
         4C+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xquV6vu/HES53GkuuXx4GbkCPz+uxMa6RD0r+76fwCOYjaO2DsW4SBM8MaBItIfia3ixus7PlUR8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIakvVU5sEs+tS4tAWuWSeZnIydXZjBiKOeALoV9nIvCgZXTZo
	e14Qldf+n27Pu/3UVrzn2lL+dqyKDyFoLZbNXdO7mjRMwtvGyk7x6Zlm56drgcWKf1659qdqisQ
	SonWtKTEeWEPnPw==
X-Received: from ejbjo13.prod.google.com ([2002:a17:906:f6cd:b0:c07:51fe:191c])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d03:b0:bed:8f7e:d85b with SMTP id a640c23a62f3a-c05d2ca2fe0mr498827566b.42.1781802069525;
 Thu, 18 Jun 2026 10:01:09 -0700 (PDT)
Date: Thu, 18 Jun 2026 17:00:47 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618170047.283701-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.2] sched_ext: check remote rq eligibility
 under task's rq lock
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

task_can_run_on_remote_rq() operates under the assumption that
p->migration_disabled is stable, i.e. if the kernel observed
is_migration_disabled(p) == true, then the BPF scheduler must have also
been able to see this when dispatching the task, and it's the BPF
scheduler's fault that it tried to dispatch a task with migration
disabled to a CPU other than the task's current CPU.

This assumption does not always hold. It's possible that the BPF
scheduler saw is_migration_disabled(p) == false, while the kernel
observes is_migration_disabled(p) == true in dispatch_to_local_dsq()
-> task_can_run_on_remote_rq().

The crucial thing here is that with CONFIG_PREEMPT_RCU, migration is
disabled while a task is executing a BPF program. So, if there's a
situation where the BPF scheduler checks a task while it's not executing
a BPF program, while the kernel checks it while it is executing one,
the BPF scheduler will be killed through no fault of its own.

Consider the following scenario:

1. SCX task @p is executing on CPU A and CPU A gets preempted by a
   higher-priority scheduling class. On entry to __schedule(),
   p->migration_disabled == 0.

2. In put_prev_task_scx() @p is enqueued on the BPF scheduler's internal
   data structures, making it available for other CPUs to dispatch.

3. CPU B enters ops.dispatch(), pops @p from the BPF scheduler's data
   structures, checks is_migration_disabled(p) which returns false,
   and dispatches @p to CPU B's local DSQ.

4. On CPU A, @p hasn't been switched out yet. Execution reaches
   trace_sched_switch() which enters a BPF program, as the BPF scheduler
   hooks into the sched_switch tracepoint to detect idle->fair
   transitions. On entry into the BPF program, @p disables migration.

5. CPU B enters finish_dispatch() -> dispatch_to_local_dsq() ->
   task_can_run_on_remote_rq() which observes
   is_migration_disabled(p) == true, triggering scx_error().
   This all happens while holding CPU B's rq lock, so it's not
   synchronized with @p switching out.

This patch fixes this by moving the call to task_can_run_on_remote_rq()
after @p's rq lock is acquired in dispatch_to_local_dsq(). This way, we
synchronize with @p switching out, since @p holds its rq lock all
the way until it's switched out. Thus, any BPF programs that are called
between put_prev_task_scx() and the end of the context switch are
guaranteed to have finished and cannot influence p->migration_disabled.

Also add a lockdep assertion in task_can_run_on_remote_rq() which
ensures the task rq lock is held if enforce == true.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6567f626b3f0..4ae7ca4e0a41 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2422,6 +2422,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
  *   no to the BPF scheduler initiated migrations while offline.
  *
  * The caller must ensure that @p and @rq are on different CPUs.
+ * If enforce == true, caller must hold @p's rq lock.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2429,6 +2430,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
+	/*
+	 * To prevent races with @p still running on its old CPU while switching
+	 * out, make sure we're holding @p's rq lock so as not to risk
+	 * erroneously killing the BPF scheduler.
+	 */
+	if (enforce)
+		lockdep_assert_rq_held(task_rq(p));
+
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
 	/*
@@ -2696,13 +2705,6 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
-	if (src_rq != dst_rq &&
-	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
-		return;
-	}
-
 	/*
 	 * @p is on a possibly remote @src_rq which we need to lock to move the
 	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
@@ -2729,6 +2731,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		bool fallback = false;
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2738,6 +2741,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
+		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+			p->scx.holding_cpu = -1;
+			fallback = true;
+			dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
+					 p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
@@ -2746,7 +2754,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
 			resched_curr(dst_rq);
 	}
 
-- 
2.55.0.rc0.786.g65d90a0328-goog

