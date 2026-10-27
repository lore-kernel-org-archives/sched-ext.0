Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059740;
	b=AtZ6Rk0ata+TVxkbKD2nCPEwt+TkVw6nyQzWMphCzkaW+FfogECE+W1i8lWod3pqfluv
	 IPOXtFYxMXB+uIDq21hIsOsdeqBqFbequJVFncQVdrfkW6W53NeLpm9Keto9SgjnLXhUS
	 WaaiJOPbvCeoFxXlLHHIr8n9pCpmqHntf7oOLH8/m9Aths+5+ohQNhnU8NPX6YjEX/Ium
	 v8JTvKEI2cQsQmWMWizqjSpp3Im4NkWwwx9jNlTxZa/2TPH8Pv+hknPa7nfWZuAoAyVxN
	 0NryTL3zkszb7mIHSF2a4aNs7aB3IWur0cmJTsd58EZYhCbybnSWY/Da2Yqini3FByQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID;
	bh=/6pxU8wrtIh2nkso+EWLKH0jS8mbEswbeseQ/sR5l+c=;
	b=4xiWT6EsW/Fw5ABHvO+KLwevP8LeiWW1Fg44vDmYqV1cjK/R74iqCBCah9zCcW2E4RbG
	 LIIOk7RVSXemyBqu8x5gtVbeIEmdGi8IXxwHJ44Pbhv3sqcBwSAEw1uYuyCEeMOZonkDN
	 yCvzP6dEgS9Fdn2HrLxxni/TgFVSMu2DhR+fOPCj5eTQc4KHEJajsrn0ZPgmR1+AUOWG+
	 oWDolSZWaz+hQSpRQo52+dx1whkQPc/qZdnTGUsIXhmLFtm6W9vPpA2vo1ew+oTw3E5NL
	 hGBwrg6lX9kbV0DqRBrFfTESMvHkaHC/51V46h4zk18JqOXzMfAbgFluv8KYGLS1huA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yb/WJS23";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78037606A31A;
	Tue, 27 Oct 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb/WJS23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F951F01825;
	Tue, 27 Oct 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059740;
	bh=/6pxU8wrtIh2nkso+EWLKH0jS8mbEswbeseQ/sR5l+c=;
	h=Date:From:To:Cc:Subject;
	b=Yb/WJS23k/x1wlyt8V1fesdKK1aLNSZzE1FzwV0y7JU/e3ELVElq8/oPDT4LEMcpn
	 Z7Ix29UBV6rzlLjzxWHUrpwN6yWQLQJW+xoYdO2jfN3N6jZPhF8ucYFxGQXqg2a6lL
	 t1wegpS3NsmUW7e5Rj43EM/eD9oDJ9gBgZoZSPUQM2ZfYGNLDBQmP/u3UTmI4kAl2C
	 poLZzCVpYtwH9yg0fIi/BpU5/PlRgCIOVHAkZlkIliYzowDewyfRrcrcBARViuqJxI
	 IRAplOcfHU029Dqrob9E9TeDaHt08WOaPWBKpkast4Z1cVCTgRhNMAoJwhMm6GDMpO
	 gt7NMIRFiARUg==
Date: Mon, 26 Oct 2026 14:08:59 -1000
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix the stall watchdog testing and blaming the wrong sched under bypass
Message-ID: <20261026204300.3618150-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

While a sched is bypassing, its tasks are run by its host, the nearest
ancestor that isn't bypassing. check_rq_for_timeouts() tests a runnable task
against its owner's timeout. Since 2c91169377f4 ("sched_ext: Blame the DSQ's
owning scheduler for a runnable stall"), it ejects the sched owning the DSQ
the task waits on. The sched tested, the sched ejected and the sched running
the task can all differ.

- Timeouts are per sched. A bypassing sub-scheduler with a 2s timeout under
  a root with the default 30s has its tasks on the root's bypass DSQ. The
  root, not bypassing itself, consumes that DSQ before calling
  ops.dispatch() only on every other pass, and on the others only after
  ops.dispatch() yields nothing. A task that waits 2s there ejects the root,
  disabling all of sched_ext.

- A bypassing owner's task on the local DSQ is blamed on the owner, which
  places nothing while bypassing. If the owner is already exiting, e.g.
  during its own disable, the exit is a no-op and nothing is ejected. If the
  host isn't running the task, the owner's disable, which waits on it, may
  never finish.

- The wait isn't restarted when bypass moves a task. The time it waited
  under its owner counts against the host once it is on the host's bypass
  DSQ, and its time there against the owner once bypass lifts.

The sched running a task is its owner, or the host while the owner is
bypassing. Test the task against that sched's timeout and blame it. A bypass
requeue can change the sched running a task, so restart the wait of every
task scx_bypass() requeues except the root's own, which the root runs
bypassing or not. Single-scheduler behavior is unchanged.

A task that migrates while scx_bypass() works through the cpus, leaving one
before its requeue and arriving on another after it, is requeued by neither
and keeps its wait, which then counts against the sched now running it. That
is what happened to every task before this patch. This might be worth
addressing in the future, but the race is rare and the real-world
implications should be limited.

Fixes: 2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a runnable stall")
Cc: stable@vger.kernel.org # v7.3+: 30fb2b1e4d41: sched_ext: Fix the running task keeping its protection into bypass
Cc: stable@vger.kernel.org # v7.3+: 5809f749fbdb: sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
Cc: stable@vger.kernel.org # v7.3+
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/at4l0yXTk7T_ouk0@gpd4/
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4b7d2602b4d4..a9621bbdb183 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2458,7 +2458,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	/*
 	 * Don't reset runnable_at. If @p is waiting, the wait continues across
 	 * temporary dequeues, e.g. for a migration or an attribute change.
-	 * scx_disable_task() ends it if @p leaves its scheduler.
+	 * scx_disable_task() ends it if @p leaves its scheduler. scx_bypass()
+	 * restarts it when its requeue can change the sched running @p.
 	 */
 	clr_task_runnable(p, false);
 
@@ -4298,24 +4299,17 @@ static bool check_rq_for_timeouts(struct rq *rq)
 		goto out_unlock;
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
-		struct scx_sched *sch = scx_task_sched(p);
+		/*
+		 * @p's owner schedules @p, or its host while the owner is
+		 * bypassing. Test @p against that sched's timeout and blame it.
+		 */
+		struct scx_sched *sch = scx_exec_sched(scx_task_sched(p), cpu_of(rq));
 		unsigned long last_runnable = p->scx.runnable_at;
 
 		if (unlikely(time_after(jiffies,
 					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
-			struct scx_dispatch_q *dsq = READ_ONCE(p->scx.dsq);
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
-			/*
-			 * A task can be stuck on a DSQ that a sched other than
-			 * its owner is responsible for draining, e.g. an
-			 * ancestor's bypass DSQ while the owner is bypassing.
-			 * Blame the drainer. The local DSQ is consumed by the
-			 * cpu itself and keeps blame on the owner.
-			 */
-			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
-				sch = dsq->sched;
-
 			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
 				   "%s[%d] failed to run for %u.%03us",
 				   p->comm, p->pid, dur_ms / 1000,
@@ -6976,12 +6970,26 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
-			if (!scx_is_descendant(scx_task_sched(p), sch))
+			struct scx_sched *owner = scx_task_sched(p);
+
+			if (!scx_is_descendant(owner, sch))
 				continue;
 
 			/* cycling deq/enq is enough, see the function comment */
 			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
-				/* nothing */ ;
+				/*
+				 * The requeue can change the sched running @p,
+				 * and the watchdog counts @p's wait against
+				 * that sched. Restart the wait unless @owner is
+				 * the root, which runs its own tasks bypassing
+				 * or not.
+				 *
+				 * A dispatch in flight writes p->scx.flags
+				 * without @p's rq lock. The dequeue waits it
+				 * out, so set the flag after it.
+				 */
+				if (scx_parent(owner))
+					p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 			}
 		}
 
-- 
2.56.0

