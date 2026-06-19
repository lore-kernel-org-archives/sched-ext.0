Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DE24B28
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875448; cv=none; b=XQRcV6W7IKJG3HYX4t9LoeI1PXtpxNUDOWj2eC72q0oG9ni+bIZLFqC2DlbFRgYXKg469UKpyo2OwxwfTeWPiP8tD7zcTz03x2E79H6cYZxtZhN7n4JSiSEX7SlerpeKdnEVgu14F79a20Xz3ecLN8+pbDECJuRqpg9NflijYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875448; c=relaxed/simple;
	bh=LMRjbAZ3TsdQZ+MWQYwxdcDpFvuUduWOF9tLV1onnLE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cv6NzZwkySWXW2MLNZnoAcLBE6usfN5W4iB2C8EtwQxc1xuAND8R2w+8HV6OSx94uLcXKJ8pTWEHAzCUWSxVopTSgvoJ+5JTJe1etfIROGHzvPD8+YXSQUCWTLXbZj4WvK5cqQ4DNet9oon0my5eXQSSZWbYBqPp6VKbElezgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv1xUUQt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv1xUUQt"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49243626f15so7571445e9.1
        for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781875445; x=1782480245; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+6YfLwnGD5dhR8vloXMw1n9EwCMzcPEVyleYvt1PT4=;
        b=Fv1xUUQt49wOA2Ojr9vqzUJZOILsnvEEVr2K/xYAv8FwNnzGX6njf26MGkDHYvLXob
         jOYPYLVg5wmnx4+8M3rw9vVDQ3QcqUeLvfTtM1QQCODySwzSswy1Axm9wOj1MWn7q4ae
         NX9ZlmxCgBQhfQquGLHiPmBVUNA9ZpETedcq0EsMHeRl4aV7iH9AaYl2aSnHV0u81TM9
         irMpXtVFZwDRb8eLHaND9X2Y3WlVUmOE4i3BIjYUmu7DFQALfAncrrpnuf041+Tbsd9h
         5hmr2eJYdm/WAfN+ljdpUGrYqebiq7leYga0J8nDpDDV9P3TcvwNDLOAjFreiIMh2T/e
         Yu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875445; x=1782480245;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+6YfLwnGD5dhR8vloXMw1n9EwCMzcPEVyleYvt1PT4=;
        b=aN3NVJpsD5mf2gU+dfF+wiJ9cOVzztNiiJPGpKkNhQo8EqWgWAR1EHgzd0RTHDj1g2
         XcpAUbtIUyW3Hax+wsFZIPWkeZqCa5TGBI4nmsuqqNVPtfUaBnjx+nRwkj4wnzd7vBKz
         iFJp6KDCLMkwxo0gOXvFP7c60pHFraXXmCZ4qv9jK9ghD9nQjNCYXDOzmhvCMnFB4Cob
         LYD3wdVWVScIBSkbWsmAuUSR1eyN40vRVYY6slbkchoJilTIgMyTUaVOsn+dl8Ayktvs
         BTsRtzN63XCg/apxfUHJ7WNHIrBCLfLFfBW0fSKnB0mk5ynFYgOpVkqSCrj7BHn7uMiD
         Gqyw==
X-Forwarded-Encrypted: i=1; AFNElJ/vohUqbGHbKDHJb/UOOTNU3YSiFBZyu0LQIz9ZeZhjnuToNNkr/J+2TsDbJooIRLjLIUP4LO0s/Jo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmXaWPQE34+/pIPE8bH+hL6U3GmNB4l7qxQ7fUBA1FsZz5jkgr
	05GNkQZDGwzoLTVEWheMEC6HU3stTu0JrnmVvXBklCuErUJaS2Jil3mnAJl8UfSPSo+cWcs9BTH
	7RWvw9k3MqKGeNA==
X-Received: from wmbhu21.prod.google.com ([2002:a05:600c:a295:b0:492:4527:3dee])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b70:b0:491:e3be:1363 with SMTP id 5b1f17b1804b1-49240d84c3bmr56847865e9.0.1781875444919;
 Fri, 19 Jun 2026 06:24:04 -0700 (PDT)
Date: Fri, 19 Jun 2026 13:23:59 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260619132359.831936-1-jpiecuch@google.com>
Subject: [PATCH v2 sched_ext/for-7.2] sched_ext: check remote rq eligibility
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

Changes from v1:
 - Update documentation in ext_internal.h explaining the locking dance
   around task rq migration (Andrea)
Link to v1: https://lore.kernel.org/all/20260618170047.283701-1-jpiecuch@google.com/

 kernel/sched/ext.c          | 24 ++++++++++++++++--------
 kernel/sched/ext_internal.h | 23 +++++++++++++----------
 2 files changed, 29 insertions(+), 18 deletions(-)

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
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b04701190b23..457df0bebcd9 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1463,21 +1463,24 @@ static const char *scx_enable_state_str[] = {
  * The sched_ext core uses a "lock dancing" protocol coordinated by
  * p->scx.holding_cpu. When moving a task to a different rq:
  *
- *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
- *   2. Set p->scx.holding_cpu to the current CPU
- *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
+ *   1. Set p->scx.holding_cpu to the current CPU
+ *   2. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
  *      is set, so clearing DISPATCHING first prevents the circular wait
  *      (safe to lock the rq we need)
- *   4. Unlock the current CPU's rq
- *   5. Lock src_rq (where the task currently lives)
- *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
+ *   3. Unlock the current CPU's rq
+ *   4. Lock src_rq (where the task currently lives)
+ *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
  *      race (dequeue clears holding_cpu to -1 when it takes the task), in
  *      this case migration is aborted
- *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
+ *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
  *      into dst_rq's local DSQ (no lock swap needed)
- *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
- *      src_rq, locks dst_rq, and performs the deactivate/activate
- *      migration cycle (dst_rq is held on return)
+ *   7. Otherwise, verify under src_rq lock that the task can be moved to dst_rq
+ *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu,
+ *      leave the task on src_rq, and enqueue it on the fallback DSQ.
+ *   8. Otherwise (i.e. if the task can be moved to dst_rq), call
+ *      move_remote_task_to_local_dsq(), which releases src_rq, locks dst_rq,
+ *      and performs the deactivate/activate migration cycle
+ *      (dst_rq is held on return)
  *   9. Unlock dst_rq and re-lock the current CPU's rq to restore
  *      the lock state expected by the caller
  *
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

