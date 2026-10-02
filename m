Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85C4F3924
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955917; cv=none; b=Z2Q+5M34kyIRWv55hB9zh6REumtxK+Dbgn8O0DiR5OlVznfmDOEW2OtFT8X40TuXXdEfmrNPGdUroh65G9v2dqgz/dJFB4AcNwv9FWGgXhodpiVj69Hfswdr83RpSjQt4QpPh/RNWTacKhBsjWKHCAByJIwvNkukS7kezIT6vI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955917; c=relaxed/simple;
	bh=SXGyDDrL/ROMF7j4me/V61A0ATkUfNuEhqq23wRxJKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtOcyxcpy+9y0O4PvWD0f3P4cQXaxdlG8BlEBLBMVPTHZU0jm9FZUIbNVLRfKmmCgS0vyCtkvQBCH9vaXlSocUH4UpTS1w4nfo+1nmcLWutPGxzEQsWu0TJDm9Et+JDwefOzajG5COZTZ8O3FEHWUr9G8MYiY2p0/Gp/yWQYjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKJ1Cda4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKJ1Cda4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so285615e9.1
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955912; x=1791560712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWycLynOeS31BSwjrLwbY4e26mfEhfwnJrseaf0sLdU=;
        b=DKJ1Cda4F/H7B3Ag+JN5nDlN9PnCPj5Mq0RQAriU8pabB4ggq/qvJgXMnSbu8EBUkW
         MeuZQOSAIuU4eloioBglAK5pbhJPGgBDTFzL5d5EdFw1D11OTQxgsddf9PiRypSBdUcV
         1mi0QoTU5MtfJd+k8IOEYOZvf36xplSoJX41UVZrfDXGocmjKQ4EkUKU6IhiRiPUAqqd
         hoJuqgjbzN81BaKbmOiooBgADHHsbCex4pSshqU2cKJFr/2/NPrm1ciu79Qm9yFvMnKI
         g5S2OWMdC1qV2BLivHgM2BiVR9c6Qg3HhbPMd20PydDdJHsjyCwK4QO+ag7s9Zg0yYBT
         ReiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955912; x=1791560712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWycLynOeS31BSwjrLwbY4e26mfEhfwnJrseaf0sLdU=;
        b=PcT4MN9zFKnGfqr+/PKWsck4Tz9BGDgbHg+5QunXztXueNUZjjXgNZiHHEcL4Xg3l4
         K9J5LBYZLXnFM30i2yAFVl8XuYZXoVCRwjW+oAztgP+EyrmQaUsM33aAFVVRiZ7YVfaf
         gD9U2XAOlp3+PI1YLCavZNINVcXP1Z6/ohaMMlJ5lIqgIWc0KA03MtTEn1rbcTX96+zq
         mp9VE8hzAPbspwvqSeSpwITuTj6qzQ13iiA8tYMBVotGzG8qKOkPtAlIyTuYm6S1n/Gp
         tlrQZzOG0h2b9BYEXqjlLjVZiz+mQV/UmwEV/WyFy73MqG6Wk6j6NV893LoxrTDBeVm+
         GXYA==
X-Forwarded-Encrypted: i=1; AKwUvBwzY0Pkcj/o6Y8hLAUExaH1habIg5469IgvKZg/3W24xjKgC8seT8zgggKbjraOVPL+s2EcwBe/mu0=@lists.linux.dev
X-Gm-Message-State: AFuF++nuwa/CyieH2yHMCxW8BkA9zsroWuoPUzB26fN4IVxcWlNhRGVS
	FWL9o0FgUYjK61JmELR1bH9dyMU2zFhwHgrxsPmJdTL38dRJK20F+FD44M2zOJrDtuU=
X-Gm-Gg: AYBFou37RT54Def+vV8hpZvGwQjomV1HK06xWOieYaLuriahF1IEJiaXCz+upoclmdE
	DeI0HF2+8VOymCABb9a6dNMi6mWlvAktPU/cQLKPj+I+4A27+ilEQ872hrcrSHdCswBoJgWzRfh
	u1Aru4DsbhAMnIDHPzJTKWruxjoUFHwkP54YVBsYJoZk2LIwHIlOwd3DLnipGLDYWtmBM6YNuQU
	szu7e1G5o0elc0nSoRsEELDgGlzwEBdr71/k4RII4ttkNsabAe2MQNfUGrJEsu7GpRAwhpijdvr
	s2KkJuMO1PI/UardV2cVVwJ5LFWM4pKEZPIdWyCThC3/OIUWdZYKCWY42XCbI93LlwuvZFaV/g8
	4/HFBQfu7UQmcXivwq7OaZXqqOxpCL7fH1kPbloDBGdap4rnDN0LM48+dMtrjrNeEKthl6c7Y+q
	yyd9H+veUs1fr9StN6KkUYr0j/9Ic0jUFTsbKkxKdWrTnpn1ViJo/qjy4bzRHpyExvW7GZa13oZ
	iPduqCDzNczKVkzNvMS04/qAXOb
X-Received: by 2002:a05:600c:a306:b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-4a0275758cemr42890805e9.9.1790955912417;
        Fri, 02 Oct 2026 08:45:12 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:11 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Date: Fri,  2 Oct 2026 17:44:04 +0200
Message-ID: <20261002154415.2270586-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task doesn't have wakeup events anymore or at a far
too low pace. For such situation, we can take advantage of the task being
put back in the enqueued list to check if it should be pushed on another
CPU.

Add a push task mechanism that enables fair scheduler to push runnable
tasks. EAS will be one user but other feature like filling idle CPUs or
short slice tasks can also take advantage of it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   7 ++
 3 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 837dc74c9a8d..18692b752814 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu)
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu)
 	__must_hold(__rq_lockp(rq))
 {
 	lockdep_assert_rq_held(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f12678850ce2..00078ac7fada 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8179,6 +8179,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 	}
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
+
 /*
  * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
  *
@@ -8195,6 +8197,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	update_curr_eevdf(cfs_rq);
 	update_entity_lag(cfs_rq, se);
@@ -9799,6 +9802,157 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return target;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_push_task);
+
+static inline bool sched_push_task_enabled(void)
+{
+	return static_branch_unlikely(&sched_push_task);
+}
+
+static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
+{
+	if (!task_on_rq_queued(p))
+		return false;
+
+	if (p->se.sched_delayed)
+		return false;
+
+	if (p->nr_cpus_allowed <= 1)
+		return false;
+
+	return true;
+}
+
+static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
+{
+	if (!__check_pushable_fair_task(rq, p))
+		return false;
+
+	return false;
+}
+
+static inline int has_pushable_tasks(struct rq *rq)
+{
+	return !plist_head_empty(&rq->cfs.pushable_tasks);
+}
+
+static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->cfs.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+
+	/*
+	 * Remove task from the pushable list as we try only once after that
+	 * the task has been put back in enqueued list.
+	 */
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+	return p;
+}
+
+static int
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
+
+/*
+ * See if the non running fair tasks on this rq can be sent on other CPUs
+ * that fits better with their profile.
+ */
+static bool fair_push_task(struct rq *rq)
+{
+	struct task_struct *next_task;
+	int prev_cpu, new_cpu;
+	struct rq_flags rf;
+	struct rq *cur_rq;
+
+	next_task = pick_next_pushable_fair_task(rq);
+	if (!next_task)
+		return false;
+
+	if (is_migration_disabled(next_task))
+		return true;
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	prev_cpu = rq->cpu;
+
+	/*
+	 * We need to release rq lock and take both task and rq w/o
+	 * triggering a deadlock.
+	 */
+	raw_spin_rq_unlock(rq);
+
+	cur_rq = task_rq_lock(next_task, &rf);
+
+	/* Task already migrated */
+	if (cur_rq->cpu != prev_cpu)
+		goto skip_push;
+
+	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
+
+	/* Task doesn't need to migrate */
+	if (new_cpu == prev_cpu)
+		goto skip_push;
+
+	update_rq_clock(cur_rq);
+	cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
+
+skip_push:
+	task_rq_unlock(cur_rq, next_task, &rf);
+
+	/* Restore rq state */
+	raw_spin_rq_lock(rq);
+	put_task_struct(next_task);
+
+	return true;
+}
+
+static void fair_push_tasks(struct rq *rq)
+{
+	/* fair_push_task() will return true if it moved a fair task */
+	while (fair_push_task(rq))
+		;
+}
+
+static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
+
+static inline void fair_queue_push_tasks(struct rq *rq)
+{
+	if (!sched_push_task_enabled() || !has_pushable_tasks(rq))
+		return;
+
+	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), fair_push_tasks);
+}
+
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_push_task_enabled())
+		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+	plist_node_init(&p->pushable_tasks, p->prio);
+	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+{
+	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
+		__fair_add_pushable_task(rq, prev);
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	cfs_rq->curr = NULL;
 	if (se->on_rq)
 		__enqueue_entity(cfs_rq, se);
+
+	/*
+	 * The previous task might be eligible for being pushed on another cpu
+	 * if it is still active.
+	 */
+	fair_add_pushable_prev(rq, prev, next);
 }
 
 /*
@@ -15379,6 +15539,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 		goto repick;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	if (on_rq)
 		__dequeue_entity(cfs_rq, se);
@@ -15423,6 +15584,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
+	fair_queue_push_tasks(rq);
 
 repick:
 	/*
@@ -15439,6 +15601,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e025d2a6c302..74130bd2a2c8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -721,6 +721,8 @@ struct cfs_rq {
 		unsigned long	runnable_avg;
 	} removed;
 
+	struct plist_head	pushable_tasks;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
@@ -3877,6 +3879,8 @@ static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
+DECLARE_STATIC_KEY_FALSE(sched_push_task);
+
 #ifdef CONFIG_MEMBARRIER
 
 /*
@@ -4209,6 +4213,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
+extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu);
+
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

