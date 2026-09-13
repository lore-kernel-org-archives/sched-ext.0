Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90829AB02
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282102; cv=none; b=Hh6gFv1f/r/tiqdFEmMNX7hzhgFneJqBW+6EDd2rme5Fhpy7n9mkDobUk/F/LliixG0qm3SPq1Co65mRjzRalIcpW+0LeDy4T7WckiAtUklTcRgDYDtI9LGwXZwmvrSfflXsfCU3DA7XJcRdADHg4LwKLXmOJ5bRjGT/mgoVBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282102; c=relaxed/simple;
	bh=e51Lw+eXyTMRoF1WNvIMXex1i56BEBjlDeaWNEuNchA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbIdxBcocEW74XgRG51HNv1GGbPglnEbbZM4NRtS68Kg4ZkYqRNFKN3Y08ISHwZBIBnOb+7Q8n4wO4EtVvgNpP5psjWo+4/DZgxiRuTvfnY5L1yPOWpxYf2Ti/lq54INzqiArBNMR3ociMTNrLWi+qz5gJOQ3GixL4Co9C9XQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R0FT9v+h; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R0FT9v+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tM
	jkso+o5p+Voknae42nMgD3a3sKhBWIkLuJ9y3vptM=; b=R0FT9v+hA7ndNtLtO9
	BEyltfDdpSXjywrUUSiQcJdX7xRG267bMG/IHqmATuhVSHiPG8i/u61JyaUcaYrr
	rtanmk8uvAbpWo7aRSlqHtCM/DURHOqmzKMSIQWOX3xCiaDkIUy37t6AuzjeOotK
	6+8Du3ZX9qkEG403hfdQdJlZs=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXqWkGR6ZqwKmwAQ--.56670S2;
	Sun, 13 Sep 2026 14:47:34 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	soolaugust@gmail.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v5 4/4] sched/core: Fix donor slice accounting under proxy execution
Date: Sun, 13 Sep 2026 15:47:22 +0900
Message-ID: <20260913064722.1534766-5-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913064722.1534766-1-sh_def@163.com>
References: <20260913064722.1534766-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXqWkGR6ZqwKmwAQ--.56670S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1ruFWkur1xJr17KF4Durg_yoWxZr47pF
	Z0va4Yqw4Dta4jgFWDArs5Wa43K3s3J345urs8tayFkr1rt3yYqF1Sqr1jvF45Cr1vkF12
	yr4q9ry7C3W7trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCsjbUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gcXdmqmRwcqvAAA3W

Core scheduling uses __entity_slice_used() to decide whether the current
scheduling context has consumed enough of its slice to let a force-idled
SMT sibling run.

The check is correctly made against rq->donor, since the slice belongs to
the scheduling context. With proxy execution, however, task runtime is
accounted to rq->curr. The donor's sum_exec_runtime therefore does not
advance while another task executes on its behalf, causing

	se->sum_exec_runtime - se->prev_sum_exec_runtime

to remain near zero and preventing the force-idle reschedule from
triggering.

Using rq->curr is not correct either, as that would compare the execution
task's runtime against its own slice rather than the donor's slice.

Track the donor's task-clock timestamp when it is selected and measure the
elapsed service using exec_start. update_se() advances the donor's
exec_start from rq_clock_task() even under proxy execution, while the
accumulated task runtime itself is charged to rq->curr.

Keep the selection baseline in struct rq: there is only one active donor
per runqueue. Storing it in every sched_entity needlessly increases the
size of the hot sched_entity structure, especially on 32-bit builds.

Proxy execution can switch rq->curr from one execution owner to another
without changing rq->donor. The scheduler performs a synthetic
put_prev_task()/set_next_task() pair for the unchanged donor in that case.
Preserve the baseline for that reselect, or service accumulated before the
owner handoff would be lost. Refresh it when selecting a different donor
or through an explicit set-next reactivation.

Keeping the comparison in the task-clock domain also avoids depending on
the entity's weight. A vruntime delta accumulated across different weights
cannot reliably be compared against a slice converted using only the
current weight.

Only snapshot task entities, as task_tick_core() performs the consumed
slice check on the donor task.

In non-proxy testing, the task-clock predicate matched the existing
sum_exec_runtime predicate across HZ=100/250/1000 and nice -10/0/+10.
Under proxy execution, the donor's sum_exec_runtime delta remained zero
while the task-clock delta advanced and triggered the force-idle
reschedule. A focused same-donor owner-handoff test split the donor's
service across two execution owners. Each owner's individual service stayed
below half of the donor slice, while their accumulated service exceeded the
threshold and triggered the force-idle reschedule. Both phases kept the
same core_sched_start baseline.

Fixes: aa4f74dfd42b ("sched: Fix runtime accounting w/ split exec & sched contexts")
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c  | 27 ++++++++++++++++++---------
 kernel/sched/sched.h |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed08b287016a..9a7be87f1991 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6469,7 +6469,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 static void
-set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool reset_core_slice)
 {
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
@@ -6502,6 +6502,10 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
+#ifdef CONFIG_SCHED_CORE
+	if (reset_core_slice && entity_is_task(se))
+		rq_of(cfs_rq)->core_sched_start = se->exec_start;
+#endif
 }
 
 static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags);
@@ -14786,16 +14790,16 @@ static void rq_offline_fair(struct rq *rq)
 
 #ifdef CONFIG_SCHED_CORE
 static inline bool
-__entity_slice_used(struct sched_entity *se, int min_nr_tasks)
+__entity_slice_used(struct rq *rq, struct sched_entity *se, int min_nr_tasks)
 {
-	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
-	u64 slice = se->slice;
+	/* exec_start advances with donor service under proxy execution. */
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
@@ -14815,7 +14819,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * if we need to give up the CPU.
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.h_nr_queued == 1 &&
-	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+	    __entity_slice_used(rq, &donor->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
 
@@ -15049,7 +15053,7 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 	return throttled_hierarchy(cfs_rq);
 }
 #else /* !CONFIG_SCHED_CORE: */
-static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+static inline void task_tick_core(struct rq *rq, struct task_struct *donor) {}
 #endif /* !CONFIG_SCHED_CORE */
 
 /*
@@ -15257,6 +15261,11 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 	bool throttled = false;
+	/*
+	 * Reset for a new donor or reactivation, but preserve a same-donor
+	 * proxy reselect so service before an owner handoff is retained.
+	 */
+	bool reset_core_slice = !first || rq->donor != p;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight = NICE_0_LOAD;
 	bool on_rq = se->on_rq;
@@ -15271,7 +15280,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 
 		if (!IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) ||
 		    !first || !cfs_rq->h_curr)
-			set_next_entity(cfs_rq, se);
+			set_next_entity(cfs_rq, se, reset_core_slice);
 
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		throttled |= account_cfs_rq_runtime(cfs_rq, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a8deddc725b..f2f1e3642831 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1382,6 +1382,8 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	/* Task-clock baseline for the current core-scheduling donor slice. */
+	u64			core_sched_start;
 	unsigned int		core_pick_in_flight;
 #endif /* CONFIG_SCHED_CORE */
 
-- 
2.55.0

