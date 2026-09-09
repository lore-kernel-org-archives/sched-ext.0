Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB0361DA9
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946291; cv=none; b=mM5uzaJZjt0gmGp66izuSIOdO002HrmF2BmhZ1FgAAB3GnYo9cTd9guz2Y5sWfLBgp2qITTGOV8EkKa0T0xgn0HpPyQyj+IY852eE/ilOT3QIUaYCu4mczUuDRfCDgjSFA0WkJL3ViLyL9QhyqpJHYpc730wkq2+IOWR8Gu+Nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946291; c=relaxed/simple;
	bh=Dz4FveT8OUkLOszhSNpDynyKbpeqEK0RRW5tge5WD5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkrvgTGRyfk04InpYLKaOILOwESBz/IyTcaOuXMTRybrtR3N++b9zdB+Cvl682xTeH9qFv82h/jsRIYFs+LdKiSZDtP9sY1eqj90jUStic2t70lEVYxL1W/ouLlo4psGas2jpKcaBcMszrltdCEcF8IiMEFinO4mu0HrLtdqT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o5WRQfdp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o5WRQfdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hu
	gNHo8qlNHoP/MVhiB2gdPt4TVaEftzdU5dpBV1j8s=; b=o5WRQfdpGRPCxkR6uZ
	l8kwU3jyHwHqa6kOX/3k8sHN4SHeV6jXQ4s5rL+I8Pu9KXRHjfei3rU6u6H73OCR
	Uht4bs97Mw7AM+1iDzosHToQWO9SGgjnCdXH39pqAayKr2acaJ2xrTgSy8Bs1RGH
	qWMrJFxB3+S2hJNMB6CqilUvE=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXJfwUJ6FqRggZRw--.47966S2;
	Wed, 09 Sep 2026 17:29:56 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v4 4/5] sched/rt: Fix RT watchdog accounting for proxy execution
Date: Wed,  9 Sep 2026 18:29:00 +0900
Message-ID: <20260909092901.2989564-5-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909092901.2989564-1-sh_def@163.com>
References: <20260909092901.2989564-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXJfwUJ6FqRggZRw--.47966S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kGr43Wr1kWF47tFykuFg_yoWrtr18pF
	ZY9a45Jw1DKFWUKFyxAw4DW3WfGwn3Jay7WF4DJryrAFn8Kr1Fgr1vv34avFW5Cr1SvFya
	vF4jv3yxC34jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3Z2-UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhXRMWqhJxUqGgAA3+

Proxy execution separates the scheduling context in rq->donor from the
execution context in rq->curr.

When rq->donor belongs to the RT class, task_tick_rt() keeps RT
scheduling-class state, load tracking, and RR time-slice management
associated with rq->donor.

The RT watchdog is different. It looks up RLIMIT_RTTIME through its task
argument and updates that task's rt.timeout and posix_cputimers state.
update_curr_rt(), however, accounts elapsed task runtime to rq->curr, and
run_posix_cpu_timers() checks the execution task after the scheduler tick.

Keep the RT scheduling work on rq->donor, but run watchdog() for rq->curr.
The watchdog state then follows the task whose execution runtime advances.
The callback can also be dispatched for an RT execution context whose donor
belongs to another scheduling class. In that case, run only the watchdog
for rq->curr, without applying RT donor accounting or RR time-slice
management.

Reset rt.timeout when a task blocks under proxy execution. A mutex-blocked
task can remain on the runqueue and bypass ENQUEUE_WAKEUP, which normally
resets the RT watchdog interval. Also reset it when a task without an RT
policy is subsequently selected with neither the execution nor scheduling
context in the RT class. Preserve the timeout across ordinary scheduler
preemption and when an RT-policy task is temporarily PI-boosted into the
deadline class.

The donor/curr attribution was checked with both the in-kernel mutex
reproducer and a userspace owner in a two-node QEMU guest. FIFO and RR
donors produced donor-targeted watchdog traces on the baseline kernel and
execution-owner-targeted traces with this change; both proxy runs
completed successfully. A DL donor with an RT execution owner was also
exercised; the execution owner's timeout advanced and SIGXCPU was delivered
to it, while an RR execution owner's rt.time_slice remained unchanged in
execution-only callbacks.

A targeted rtmutex test set rt.timeout to 123 on a SCHED_FIFO owner. A DL
waiter then PI-boosted it into the deadline class. Without the policy
guard, scheduling the boosted owner reset the timeout to zero. With the
guard, it remained 123 during the boost and after deboosting. A FAIR owner
leaving an RT proxy interval still reset its timeout from 123 to zero.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/core.c | 18 ++++++++++++++++++
 kernel/sched/rt.c   | 12 ++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 05e599665fdd..d8a785bec639 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6768,6 +6768,14 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	/*
+	 * Proxy execution can keep a mutex-blocked task on the runqueue, so it
+	 * may not pass through ENQUEUE_WAKEUP, which normally resets the RT
+	 * watchdog interval.
+	 */
+	if (sched_proxy_exec() && p->rt.timeout)
+		p->rt.timeout = 0;
+
 	p->is_blocked = 1;
 
 	/*
@@ -7243,6 +7251,16 @@ static void __sched notrace __schedule(int sched_mode)
 		rq_set_donor(rq, next);
 	}
 
+	/*
+	 * End a previous RT proxy watchdog interval once neither context is
+	 * in the RT class. Preserve the interval for an RT-policy task that is
+	 * temporarily PI-boosted into the DL class.
+	 */
+	if (sched_proxy_exec() && !task_has_rt_policy(next) &&
+	    !rt_prio(next->prio) &&
+	    !rt_prio(rq->donor->prio) && next->rt.timeout)
+		next->rt.timeout = 0;
+
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dd058a6ca06b..0fdb8edb7528 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2542,15 +2542,23 @@ static void task_tick_rt(struct rq *rq, int queued)
 	struct task_struct *p = rq->donor;
 	struct sched_rt_entity *rt_se;
 
-	if (p->sched_class != &rt_sched_class)
+	if (p->sched_class != &rt_sched_class) {
+		/*
+		 * The RT callback can also be dispatched for an RT execution
+		 * context whose scheduling context belongs to another class.
+		 * Keep the watchdog tied to the task whose runtime is advancing.
+		 */
+		if (rq->curr->sched_class == &rt_sched_class)
+			watchdog(rq, rq->curr);
 		return;
+	}
 
 	rt_se = &p->rt;
 
 	update_curr_rt(rq);
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
-	watchdog(rq, p);
+	watchdog(rq, rq->curr);
 
 	/*
 	 * RR tasks need a special form of time-slice management.
-- 
2.55.0

