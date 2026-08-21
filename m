Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311C38E8DA;
	Fri, 21 Aug 2026 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339155; cv=none; b=Bl0yuXJmaP61/Lba541ycvKMUgsGBcW6cBARyqAzO7FwrVge/B6mReal6jQRg+BRx4EB6nYT7O8ndYk+y3W9QA3855/O7jhPv/5FUxLJmPgCKXBkNUP3sMQ+Ez8LOfNR1qkTr4AlhIQgsDtSuwxbT2fJNrizaCbXGeWpP3FUXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339155; c=relaxed/simple;
	bh=BXwzC/o7+wzzyOgny2Iz8qWNgkC9nOGI1B2Rm9yjJ2g=;
	h=Date:Message-ID:From:To:To:To:Cc:Cc:Cc:Subject; b=J19zg5D1afnyfJehWTS9HqS5kAHrnecWoAg4/corGxEcCRGonXEGazkBTOwYDzELD+3OVbQP7TUtDvjQhbbFcY5Cp2DsNfP5aqYebEuNt35Ods5z66ffhi+isqFxdB+Mcy2N34KBebdEoUZoOpwNazFj8e10NI6CDOCjvm6U0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKfaO5/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKfaO5/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65521F000E9;
	Fri, 21 Aug 2026 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339153;
	bh=EGkvMFqDA+k5y3HDINukKqc1JBSHxHzV/eeNSy25ju8=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject;
	b=BKfaO5/uUbCUE1aIMXevichpbG7OVDw6zZrGbKX7LYd3HTxvWv20GwD6mt+K8mg7r
	 Pt+hru2cbWy/EvbyxkCO6MWPq7Ax6eyL0ZcX3WrNycFLK8b5h9HWASz1nObdVasBPv
	 nUbCxCbVNfZCE4gXt4V1ODKnDUWZy6i9lncMXIarzqtjtErUWomWxjyNXCW+tBI5oj
	 8EodPTJMF/ogdDGTtgoo3g91y1XXlzfZjyhQ3p/+KYSeEvwiOrkEsSubOsDPzKtPsK
	 AoFhpKpwoGzeC5o10yW8dbUTqnhgv37N5f1TE5oeWfg8oAh4NVc9FiQaa/BCh6bqwz
	 rVdTWcnFk8GbA==
Date: Fri, 21 Aug 2026 09:05:52 -1000
Message-ID: <7b3b7e35d462fe061105f09de3a2eba9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix spurious aborts in scx_bpf_dsq_move() on ownership change races
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_dsq_move() verifies that the task belongs to the calling scheduler
before taking any locks and aborts the scheduler on mismatch. The task can
lose the sched association at any point: It can run and fully exit, which
clears the association, or get rehomed to a different sub-sched. Both are
benign races, but the early ownership check escalates them into scheduler
aborts.

Move the ownership check below the cursor-lost check. Every ownership change
dequeues the task first, so a task that is still on the iterated DSQ under
the lock while owned elsewhere indicates a genuine violation and should
abort.

Also fix two stale comments still referencing sched_ext_free(), which has
been renamed to sched_ext_dead().

Fixes: bb4d9fd55158 ("sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7694,7 +7694,7 @@ static void scx_root_enable_workfn(struc
 	/*
 	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
 	 * preventing new tasks from being added. No need to exclude tasks
-	 * leaving as sched_ext_free() can handle both prepped and enabled
+	 * leaving as sched_ext_dead() can handle both prepped and enabled
 	 * tasks. Prep all tasks first and then enable them with preemption
 	 * disabled.
 	 *
@@ -7786,7 +7786,7 @@ static void scx_root_enable_workfn(struc
 
 	/*
 	 * We're fully committed and can't fail. The task READY -> ENABLED
-	 * transitions here are synchronized against sched_ext_free() through
+	 * transitions here are synchronized against sched_ext_dead() through
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
@@ -9004,12 +9004,6 @@ static bool scx_dsq_move(struct bpf_iter
 	if (unlikely(READ_ONCE(sch->aborting)))
 		return false;
 
-	if (unlikely(!scx_task_on_sched(sch, p))) {
-		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
-			  p->comm, p->pid);
-		return false;
-	}
-
 	/*
 	 * Can be called from either ops.dispatch() holding the dispatched rq's
 	 * lock or any context where no rq lock is held. If latter, lock @p's
@@ -9040,6 +9034,17 @@ static bool scx_dsq_move(struct bpf_iter
 		raw_spin_unlock(&src_dsq->lock);
 		goto out;
 	}
+
+	/*
+	 * @p has been on $src_dsq and can't move anymore. If @p is not on @sch,
+	 * the caller didn't have authority over @p at the time of the call.
+	 */
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
+			  p->comm, p->pid);
+		raw_spin_unlock(&src_dsq->lock);
+		goto out;
+	}
 
 	/* @p is still on $src_dsq and stable, determine the destination */
 	dst_dsq = find_dsq_for_dispatch(sch, locked_rq ?: this_rq(), dsq_id, task_cpu(p));
