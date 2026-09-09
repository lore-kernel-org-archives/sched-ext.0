Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAB3C3C16
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946287; cv=none; b=PBwkz0bThllRBrpT8HKtwrF/GFN/0QDZYcbfI1JPenYFVryr2ourw34ciUotTmP9I8mRmLjvTnXhMF/8xF+RHWD2fQuthAQoYIG0LHVhqKXCn7gkRuqqsoEElaJHxS3fmgho2+4jEoI1hlmR21ODLosP7W2W/jw3U+i8NmdakPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946287; c=relaxed/simple;
	bh=sZtOrM6LqEaGZnj/DA+GuR8Qt+PbicPLN3ePrrNAQf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdQuqAl25Rw+UZsCdE9CX6snD3ZTENegB3NBjIF7Bi7a9eu123SZ47el4CSPOj7IS+OWQYpNXaOvVzNodnTuNsbsxehY5JRY9JsNcg7M1L+qQmofWR4ISGnq78j/uI2zFIXun7YZMhSZi11U29kdsEPX5DhKRkrPjJKmerFSltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQPh8NY5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQPh8NY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lx
	IMRscRls6xcpSeU4En25ja11Xm3g7TFdEKV5Km54g=; b=jQPh8NY5VdHOiLo2J7
	Lykdx/TZoJTv+EItjWsJa86951Z1nnayvz2egb0CcxNryoRodsiVImMvYeNrzIPZ
	diiMPMhj1yjl8S9HGiNzjHf6s03DXPmADqckBNpjcE2dB0XV9lyU0BtzoQNyDL2x
	qqJyKYWAysY0q/IINqwL/dcH8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnr5sVJ6FqvPS5Bg--.63400S2;
	Wed, 09 Sep 2026 17:29:58 +0800 (CST)
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
Subject: [PATCH v4 5/5] sched/core: Fix donor slice accounting under proxy execution
Date: Wed,  9 Sep 2026 18:29:01 +0900
Message-ID: <20260909092901.2989564-6-sh_def@163.com>
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
X-CM-TRANSID:_____wDnr5sVJ6FqvPS5Bg--.63400S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1rAw43ZF47Xw15ZrW3trb_yoW7JrWfpF
	Z8ZF1UJw4kta4jgFWUArs5u343K3s3ta45ur4vyayrCr1rtw4FqF10qF1avF4Ykr92kFya
	vr4I9ry7Cw1Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3Xo7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRbRMWqhJxYW9AAA3v

Core scheduling uses __entity_slice_used() to decide whether the current
scheduling context has consumed enough of its slice to let a force-idled
SMT sibling run.

The check is correctly made against rq->donor, since the slice belongs
to the scheduling context. With proxy execution, however, task runtime
is accounted to rq->curr. The donor's sum_exec_runtime therefore does
not advance while another task executes on its behalf, causing

        se->sum_exec_runtime - se->prev_sum_exec_runtime

to remain near zero and preventing the force-idle reschedule from
triggering.

Using rq->curr is not correct either, as that would compare the execution
task's runtime against its own slice rather than the donor's slice.

Track the donor's task-clock timestamp when it is selected and measure
the elapsed service using se->exec_start. update_se() advances the donor's
exec_start from rq_clock_task() even under proxy execution, while the
accumulated task runtime itself is charged to rq->curr.

Keeping the comparison in the task-clock domain also avoids depending on
the entity's weight. A vruntime delta accumulated across different
weights cannot reliably be compared against a slice converted using only
the current weight.

Only snapshot task entities, as task_tick_core() performs the consumed
slice check on the donor task.

In non-proxy testing, the task-clock predicate matched the existing
sum_exec_runtime predicate across HZ=100/250/1000 and nice -10/0/+10.
Under proxy execution, the donor's sum_exec_runtime delta remained zero
while the task-clock delta advanced and triggered the force-idle
reschedule.

Fixes: aa4f74dfd42b ("sched: Fix runtime accounting w/ split exec & sched contexts")
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   |  3 +++
 kernel/sched/fair.c   | 15 +++++++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..c32d9931129f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -590,6 +590,9 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
+#ifdef CONFIG_SCHED_CORE
+	u64				core_sched_start;
+#endif
 	/* Approximated virtual lag: */
 	s64				vlag;
 	/* 'Protected' deadline, to give out minimum quantums: */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8a785bec639..87178ec08392 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4602,6 +4602,9 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+#ifdef CONFIG_SCHED_CORE
+	p->se.core_sched_start		= 0;
+#endif
 	p->se.vlag			= 0;
 	p->se.rel_deadline		= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43d558289856..0528dc4846f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6502,6 +6502,10 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
+#ifdef CONFIG_SCHED_CORE
+	if (entity_is_task(se))
+		se->core_sched_start = se->exec_start;
+#endif
 }
 
 static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags);
@@ -14788,14 +14792,13 @@ static void rq_offline_fair(struct rq *rq)
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
 {
-	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
-	u64 slice = se->slice;
+	u64 rtime = se->exec_start - se->core_sched_start;
 
-	return (rtime * min_nr_tasks > slice);
+	return (rtime * min_nr_tasks > se->slice);
 }
 
 #define MIN_NR_TASKS_DURING_FORCEIDLE	2
-static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
+static inline void task_tick_core(struct rq *rq, struct task_struct *donor)
 {
 	if (!sched_core_enabled(rq))
 		return;
@@ -14815,7 +14818,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * if we need to give up the CPU.
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.h_nr_queued == 1 &&
-	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
+	    __entity_slice_used(&donor->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
 
@@ -15049,7 +15052,7 @@ static int task_is_throttled_fair(struct task_struct *p, int cpu)
 	return throttled_hierarchy(cfs_rq);
 }
 #else /* !CONFIG_SCHED_CORE: */
-static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
+static inline void task_tick_core(struct rq *rq, struct task_struct *donor) {}
 #endif /* !CONFIG_SCHED_CORE */
 
 /*
-- 
2.55.0

