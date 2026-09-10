Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF146C835
	for <sched-ext@lists.linux.dev>; Thu, 10 Sep 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037794; cv=none; b=a0gW7rUS2R8ZBotj2es7fbs4k/swO6UL1fDyxbphxnn44NfwGKG+figiKeFg+wjJkswGL+8iS4Xd2cabwqWlQhHMA5CUslez3ZMskAgq/wG+XJL83u9y8RvgB/aw1/LiCC80LPDU9IAy1JOgghq12zXEFy1RpczK/m7bFZpaqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037794; c=relaxed/simple;
	bh=YdzrMk8ilrdPcMZUfLVgW8yhf7sgCuNAjKqnreba/YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jld9UmD91l9NbRzuN/bm3wAuL2JbV07Slvs9sUKGsYm8lt4qDD5vIJqo4pUMDKssRBB7/2GHCT6daLuY83KSRo5nIHsj7XFFZ0KEt5J+SJhlK6M395MC/F8b63X0DJT+61uXYIsiihO823XNTCmEgVd7JKVJOLqtVu6/pArv3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SDUP0OXg; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SDUP0OXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vI
	h0xwNIpntqCuDSbP8n7bFxK9BFVqY3UFuS+N7bAuQ=; b=SDUP0OXgNuSCp6cTlb
	GgZLyHC75GzV3f3ER5bcIgopZS6lmn8B8ybDElv1OKkvNIg6y1ObZ8tk4/tZMXg5
	CtLLNG3YWvwig4+MEk7Ey+Gdd1SrBK+fYsaAWRe+z2ckxUZTKzVpohx8vIwv3nPA
	RWHTSPNnSEkJzEkq53Fr8PF10=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHaACSjKJq207aRw--.7088S2;
	Thu, 10 Sep 2026 18:55:15 +0800 (CST)
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
Subject: Re: [PATCH v4 5/5] sched/core: Fix donor slice accounting under proxy execution
Date: Thu, 10 Sep 2026 19:55:14 +0900
Message-ID: <20260910105514.2788543-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909092901.2989564-6-sh_def@163.com>
References: <20260909092901.2989564-1-sh_def@163.com> <20260909092901.2989564-6-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHaACSjKJq207aRw--.7088S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWDXrW7tr1rWFWfWrWDtwb_yoW3WFWrpF
	Z0v3WUtw4Dta4jgFWUArs8Wa43K3s3Ja45Xrn5tayFkr1rt3yFqFySqryYyF45Cryv9F12
	yrsF93y7Crnrt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtfHUUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwROK6WqijJNs+QAA3z

On Wed, Sep 09, 2026 at 06:29:01PM +0900, Hui Su wrote:
> Core scheduling uses __entity_slice_used() to decide whether the current
> scheduling context has consumed enough of its slice to let a force-idled
> SMT sibling run.
>
> The check is correctly made against rq->donor, since the slice belongs
> to the scheduling context. With proxy execution, however, task runtime
> is accounted to rq->curr. The donor's sum_exec_runtime therefore does
> not advance while another task executes on its behalf, causing
>
>         se->sum_exec_runtime - se->prev_sum_exec_runtime
>
> to remain near zero and preventing the force-idle reschedule from
> triggering.
>
> Using rq->curr is not correct either, as that would compare the execution
> task's runtime against its own slice rather than the donor's slice.
>
> Track the donor's task-clock timestamp when it is selected and measure
> the elapsed service using se->exec_start. update_se() advances the donor's
> exec_start from rq_clock_task() even under proxy execution, while the
> accumulated task runtime itself is charged to rq->curr.
>
> Keeping the comparison in the task-clock domain also avoids depending on
> the entity's weight. A vruntime delta accumulated across different
> weights cannot reliably be compared against a slice converted using only
> the current weight.
>
> Only snapshot task entities, as task_tick_core() performs the consumed
> slice check on the donor task.
>
> In non-proxy testing, the task-clock predicate matched the existing
> sum_exec_runtime predicate across HZ=100/250/1000 and nice -10/0/+10.
> Under proxy execution, the donor's sum_exec_runtime delta remained zero
> while the task-clock delta advanced and triggered the force-idle
> reschedule.

Following up on the task_tick_core() discussion with Tim and Chen Yu, I
reworked the implementation while keeping the slice check associated with
rq->donor, because the slice belongs to the scheduling context.

The new predicate measures consumed service in the task-clock domain rather
than using the donor's sum_exec_runtime:

  rtime = se->exec_start - rq->core_sched_start;

update_se() advances the donor's exec_start from rq_clock_task() during
proxy execution even though task-level sum_exec_runtime is charged to
rq->curr. This keeps both sides of the comparison in the task-clock domain.

The deadline/virtual-time prototype did not work reliably in my reproducer:
update_deadline() can advance the deadline before task_tick_core() evaluates
the predicate, making the reconstructed virtual service small again after
the donor has consumed service.

The baseline is stored in struct rq rather than every sched_entity. There is
one active donor per runqueue, so per-entity storage was unnecessary and
increased sched_entity from 224 to 256 bytes on i386 with
CONFIG_SCHED_CORE=y.

One proxy-specific detail is that an execution-owner handoff can retain the
same donor. The scheduler then uses a synthetic put_prev_task()/
set_next_task() pair for balance handling. That reselect must not reset the
donor's core_sched_start, or service before the handoff would be discarded.
The implementation refreshes the baseline only when selecting a different
donor or when reactivating a task after a scheduling-class transition.

In non-proxy testing, the new predicate matched the existing
sum_exec_runtime predicate in 89,900 samples across HZ=100/250/1000 and
nice -10/0/+10 with zero mismatches. The proxy-enabled
CONFIG_SCHED_CORE=y scheduler objects and full bzImage also build with this
change. A focused force-idle test which splits one donor's service across two
execution owners is still pending; I will not claim owner-handoff runtime
coverage until that case runs.

Could you take a look at whether this task-clock and per-rq baseline approach
is reasonable? If so, I will complete the focused owner-handoff test and carry
the result into v5 before posting the updated series.

For reference, the complete current core-slice patch follows.

Thanks,
Hui

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed08b287016a..0fea899d61c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6469,7 +6469,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 static void
-set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
+		bool reset_core_slice)
 {
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
@@ -6502,6 +6503,10 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
+#ifdef CONFIG_SCHED_CORE
+	if (reset_core_slice && entity_is_task(se))
+		rq_of(cfs_rq)->core_sched_start = se->exec_start;
+#endif
 }
 
 static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags);
@@ -14786,16 +14791,15 @@ static void rq_offline_fair(struct rq *rq)
 
 #ifdef CONFIG_SCHED_CORE
 static inline bool
-__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
+__entity_slice_used(struct rq *rq, struct sched_entity *se, int min_nr_tasks)
 {
-	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
-	u64 slice = se->slice;
+	u64 rtime = se->exec_start - rq->core_sched_start;
 
-	return (rtime * min_nr_tasks > slice);
+	return (rtime * min_nr_tasks > se->slice);
 }
 
 #define MIN_NR_TASKS_DURING_FORCEIDLE	2
-static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
+static inline void task_tick_core(struct rq *rq, struct task_struct *donor)
 {
 	if (!sched_core_enabled(rq))
 		return;
@@ -14815,7 +14819,8 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * if we need to give up the CPU.
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.h_nr_queued == 1 &&
-	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+	    __entity_slice_used(rq, &donor->se,
+				MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
 
@@ -15049,7 +15054,7 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 	return throttled_hierarchy(cfs_rq);
 }
 #else /* !CONFIG_SCHED_CORE: */
-static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+static inline void task_tick_core(struct rq *rq, struct task_struct *donor) {}
 #endif /* !CONFIG_SCHED_CORE */
 
 /*
@@ -15257,6 +15262,8 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 	bool throttled = false;
+	/* Keep service accumulated across a same-donor proxy reselect. */
+	bool reset_core_slice = !first || rq->donor != p;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight = NICE_0_LOAD;
 	bool on_rq = se->on_rq;
@@ -15271,7 +15278,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 
 		if (!IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) ||
 		    !first || !cfs_rq->h_curr)
-			set_next_entity(cfs_rq, se);
+			set_next_entity(cfs_rq, se, reset_core_slice);
 
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		throttled |= account_cfs_rq_runtime(cfs_rq, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bb6f87552220..b430092fc9ad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1382,6 +1382,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	u64			core_sched_start;
 	unsigned int		core_pick_in_flight;
 #endif /* CONFIG_SCHED_CORE */
 

