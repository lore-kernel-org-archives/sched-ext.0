Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D157189F43
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169482; cv=none; b=ZdNpm1GpuIm4sjlUSAdphP2qdlBDnwpua4r9y5ju4IS16LPOUemGPmbE+PyidCMIQkv7yR8mwKA7GwHjJ1v5xP9veWUNt/whTufKd9dt4ccK9D4XV0Qrf+quyol8PjKtY5ZwcKoAFUBSxXOCVmJX3tLgCgwIsVQOLrqeKwMZ5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169482; c=relaxed/simple;
	bh=FI2TBwk+/jO5vyptdoeTuop/+n86LAlW/FYdQUtDhNE=;
	h=To:Date:Content-Type:From:Mime-Version:Cc:Subject:Message-Id; b=u/BSdT0pAyYedJgZy70biZaygkvPnKof7reUxBlOYwLfcinezjnZcaWVrG65inR2LXAqr8MO7pn33PlGK7Uvkjg5mES7QYsaS2Yxo/h2pL+9n1zbJssbyIDvDxjKBHKGH8wJCnvilzCP9y5ktZOrdpxqTiEk9XXo8SnjTDYaCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iJQQnBlU; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iJQQnBlU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784169474; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wmsT7xiYYdahyGCxkr50gXE7qZLzHUCMlD8tV3D9ZRU=;
 b=iJQQnBlUuLezhiJd5LVHL6iFKri77gZUClmpCv0+/akWdr0/IaKZsWrsUdrQwO9IMC4j4m
 wsjmoztI1I6SWNyj3rCUyKEktYWv0j9gyR7VU2fDVYkJMk5KrRMHzLzbnGKuoKI0sLAPoZ
 yF/V/IKopw+VXWyNgo3rQM4q1JCELtlKiAm7m20UUY6lZ9QwfNmm05ZFnS35IF1Xoq3TSn
 H3AK1AJ5spVU378lqA/8nyVpJ+wYHwCC7AIhDE+O4vIsac13VfQt6tPjEwNpm9Dw9mnPG1
 AUFJK0rmrCqNUZcDMFJ5fk5S4nn8UeuaUd0xtbBAJt+sou6U+jQzVRyiL86xjg==
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>, 
	"Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, 
	"Ingo Molnar" <mingo@redhat.com>, 
	"Peter Zijlstra" <peterz@infradead.org>, 
	"Juri Lelli" <juri.lelli@redhat.com>, 
	"Vincent Guittot" <vincent.guittot@linaro.org>, 
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, 
	"Valentin Schneider" <vschneid@redhat.com>, 
	"K Prateek Nayak" <kprateek.nayak@amd.com>, 
	"Emil Tsalapatis" <etsal@meta.com>, 
	"Cheng-Yang Chou" <yphbchou0911@gmail.com>
Date: Thu, 16 Jul 2026 10:37:46 +0800
Content-Type: text/plain; charset=UTF-8
From: "Zhimin Feng" <fengzhimin@bytedance.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	"Chengming Zhou" <zhouchengming@bytedance.com>, 
	"Zhimin Feng" <fengzhimin@bytedance.com>
X-Mailer: git-send-email 2.39.5
X-Lms-Return-Path: <lba+26a584400+f6800d+lists.linux.dev+fengzhimin@bytedance.com>
X-Original-From: Zhimin Feng <fengzhimin@bytedance.com>
Subject: [PATCH sched_ext] sched/ext: Keep tick enabled for finite-slice tasks
Message-Id: <20260716023746.3289089-1-fengzhimin@bytedance.com>
Content-Transfer-Encoding: 7bit

SCX tasks with finite slices need the scheduler tick to make forward
progress on slice expiration. However, set_next_task_scx() used to refresh
the nohz dependency through sched_update_tick_dependency(), which evaluates
sched_can_stop_tick() using rq->curr.

When switching from idle, RT, CFS, or another previous task to a
finite-slice SCX task on a nohz_full CPU, rq->curr may still point at
the previous task while set_next_task_scx() is running. If that previous
task allows the tick to stop, the scheduler dependency can remain
cleared even though the next SCX task has p->scx.slice != SCX_SLICE_INF.

CFS does not hit the same gap for bandwidth-constrained tasks because its
pick path has a next-task based check: sched_fair_update_stop_tick()
explicitly sets TICK_DEP_BIT_SCHED when the selected CFS task needs
bandwidth accounting on a nohz_full CPU.

Add a helper to set the scheduler tick dependency directly and use it from
set_next_task_scx() whenever the next SCX task has a finite slice.
This avoids basing the finite-slice decision on the old rq->curr while
preserving the existing tickless behavior for SCX_SLICE_INF tasks.

Signed-off-by: Zhimin Feng <fengzhimin@bytedance.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/ext/ext.c | 21 ++++++++++++++++++---
 kernel/sched/sched.h   | 11 +++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..6c0c805d489a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2950,6 +2950,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
+	bool tick_state_changed;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2972,15 +2974,28 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * @p is getting newly scheduled or got kicked after someone updated its
 	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
 	 */
-	if ((p->scx.slice == SCX_SLICE_INF) !=
-	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
-		if (p->scx.slice == SCX_SLICE_INF)
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF;
+	tick_state_changed = can_stop_tick !=
+		(bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK);
+	if (tick_state_changed) {
+		if (can_stop_tick)
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
 		else
 			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+	}
 
+	/*
+	 * If @p has a finite slice, it needs the scheduler tick to make
+	 * forward progress on slice expiration. Don't rely on
+	 * sched_update_tick_dependency() here because rq->curr may still be
+	 * the previous task while set_next_task_scx() is running.
+	 */
+	if (!can_stop_tick)
+		sched_set_tick_dependency(rq);
+	else if (tick_state_changed)
 		sched_update_tick_dependency(rq);
 
+	if (tick_state_changed) {
 		/*
 		 * For now, let's refresh the load_avgs just when transitioning
 		 * in and out of nohz. In the future, we might want to add a
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba26..d692d92fc095 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2998,9 +2998,20 @@ static inline void sched_update_tick_dependency(struct rq *rq)
 	else
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
+
+static inline void sched_set_tick_dependency(struct rq *rq)
+{
+	int cpu = cpu_of(rq);
+
+	if (!tick_nohz_full_cpu(cpu))
+		return;
+
+	tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
 #else /* !CONFIG_NO_HZ_FULL: */
 static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
+static inline void sched_set_tick_dependency(struct rq *rq) { }
 #endif /* !CONFIG_NO_HZ_FULL */
 
 static inline void add_nr_running(struct rq *rq, unsigned count)
-- 
2.39.5
