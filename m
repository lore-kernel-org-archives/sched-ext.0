Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978406;
	b=V1TndBgTuGvDnS4OQa+2/K529FdDLlnXq8I+ZNQm9xSWDan34ML1hMJE2bdovEU/x6bu
	 amNJH6I9/zVrDUfKwQDb2tDmvoZ+v9RH/OeeF3YjhWjnoVlt+5ozd6AqVQ/Rz06lM9IhC
	 8wMSYzJIX6AGHv9IvCYkPsJiEj2VaKAmCkqJixhLjXMHC6ZThvqB9aS2STcbM43MchpS2
	 bRVnQSNvQ66XZava1qP7Rd4dgX8DCWB/toJ+AMJH/nkDtfm6x1dJ8AYqr1A7H9CJVDhKT
	 d6vxkDCJ1xDMuULepXnZ2tmKJY80sZlK6+XhqKiLECuN+bm0p+LxDperZ9SBvayM5zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
	b=Fzc0F7OYmYwgD/+l4IDqj7M5y2tLxFFt0sc7NT5tFw2uXU7FfE7CTf4elK1pyftWdF8c
	 TX5EYB6fMZv7R1ptacuZ3nAX7ZUSGnfnK9PsnSFSeZbt86DSgQD+/1FV2D3bmPt9yIe4o
	 O0aiVSruufCw+8Qn5tkKMlvzobrVmRff/HhuG2sMpFLQc8Jx5bSz/3KKV2CHz5hbEEVXP
	 LIfO62+rWmrKBoDH2oVzhSDRWKKG1HfAGfYfp6VvSnPMgkOmtV/iFmyBxVuG73d/0m1xu
	 fYMBGl2yrGcGy32Cs2ZfBWI4brXd8Jgr3QbAd3Tzdz6atGvN7sqjvcU8E/XChHMVvvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t6Uzcr8x;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C0606D83A
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914C0606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t6Uzcr8x
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4f540ebso478164f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978404; x=1794583204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
        b=t6Uzcr8xyJUgVEDxRVdO54i/YpegpZWFnShUfTqHZCSET+Zs0DdPKEp/A1Z0PmrNrc
         YU16Nck8J5et5NSiV+J8kKap/TRXUyd69KMmuaiLn3IhpQ020egHACfvd2BIPql0Rnub
         noPlMuRA8lP49fweuvahYyFNKgfk1cYe+M8i+drskK+c4RVQ/8/eDUXPMnk7P1CkBtTE
         lJpwOUvKQMiO5mfMmn+juChewtvvGXT/A7v0zgnCeAWa5qtLmzEzMrZMaM5ydLIu1Rsu
         ZGfErh1llVzHcSPSytuxX5ISO20vtHm0ntEJaSjuH5gi4Vbq8XxFcrcEl19lje1cP/5E
         HIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978404; x=1794583204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
        b=ouEccH2T7MdpQYjy5SSNwaLDp17QQVq1xPk2LTQL0uAO/kAsAlk3NOFsF6wn9xkzMv
         4m8O4p3NKy6x3IqVFhc2hWdOOeceu4SdugZsoYAJwkwbuDu61iIlPBzr7q8trltkixvj
         sg6oOqChgdzQdGT0MU/HJtNm7GNbSyD8NRrf6hutUYVLQ7ov9HLoghtaYqgS3kZ71UZ/
         xaw/NugvWYs3exhZbuYT9BGdmz5n6mcE1tn0GNG2eqDFaNm3VU/wybpndyfqhUCKaz9w
         TEgjav5Um2+Q0MskxJLWxYZCn07fz1oSjgffOMoyTgCMSQQQOD1pmdJ1FKAyFotKO62h
         c1bw==
X-Forwarded-Encrypted: i=1; AL+hErHIjm0K4tV+0KVCy0U3PBJralDvB8Yf8NaJBxRgfdnnDv9F+476WFowImQ3XL1BF4Wy/mp/jnplcSg=@lists.linux.dev
X-Gm-Message-State: APuU4Z+eshZE69g4XqyBRy1emToKGnfHaIgu54sR+PXLYuqg1oQQ37qU
	AbDRn2UGOYOUkfhcghDKcCN5SDwaDMUCLPhW6C4L5zD2zsM/dBMqRsiCGKhBWt6BKlE=
X-Gm-Gg: AYBFou0vhKzmfE7eGmdFEMmZKlKQPagUat9z0l34trbcaYQOB/T4vD1SGGIYQY3yNv6
	g9q6G9JbSuhJWWlO5Jg+mOtjHuEUNI5FSPaQmXs0sUe0ATX464EoV6FGcZ7GT2bu0aauC3vadpS
	JJMyL7REpD6X3zAUlxvZ60J2u1828jvHusLkj0qJyuagLf2CHSuqSQyMZoblLtp7jYZo+2DyjLi
	AxsFw/hWmIDGB9QwKIsz8kG2E0spA6LwL7u+yZf+ZXa20y6A9Tii45biOM3+lBJ02r0u4uQwlkc
	a51WxeFnSMc8u3HnuQiU+ESoUsbc8OeW2tqXvnNjVbc/F074xa52jjO58onQuh/qR/x0O6x35pu
	31lKrQU6mSuZHbp30mKumJkBHSxo1TPXDhch8laZmE8DizaUa2QAVH/+8YOxgvsNeYAu2mYNUoT
	bxjaTsTDNfWYGzes1ztti5rwYljqZGPGTs2H0hvyA9kAOf44Kh56CQQP6o6o7YB6NCqECBWv3/Y
	dYl5jOy5AoIw3auX7RNoxWuw2qebKESuQZ09aT48Lw5fIZeaeHKQ2Ck3gktrkEHeX43LKbhasY6
	0twMYf59bXDSK/7wzSZ9aR0cmnKtALn0EX84zu1hCoIYbU4=
X-Received: by 2002:a05:6000:4013:b0:48e:5db7:fd6c with SMTP id ffacd0b85a97d-492732dc848mr6173133f8f.4.1793978403829;
        Fri, 06 Nov 2026 07:20:03 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:02 -0800 (PST)
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
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:35 +0100
Message-ID: <20261106151947.3991524-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task doesn't have wakeup events anymore or at a far
too low pace. For such situation, we can take advantage of the task being
put back in the enqueued list to check if it should be pushed on another
CPU.

Add a push task mechanism that enables fair scheduler to push runnable
tasks. EAS will be one user but other feature like filling idle CPUs or
short slice tasks migration can also take advantage of it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 177 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   7 ++
 3 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d71da9069218..1096ea9cbc4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2589,8 +2589,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
index 8f99c8bf1a80..e37f8b55a293 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8405,6 +8405,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 	}
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
+
 /*
  * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
  *
@@ -8421,6 +8423,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	update_curr_eevdf(cfs_rq);
 	update_entity_lag(cfs_rq, se);
@@ -10071,6 +10074,163 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
+	if (next == p)
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
+	__releases(__rq_lockp(rq))
+	__acquires(__rq_lockp(rq))
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
+static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
+				   struct task_struct *next)
+{
+	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
+		__fair_add_pushable_task(rq, prev);
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	cfs_rq->curr = NULL;
 	if (se->on_rq)
 		__enqueue_entity(cfs_rq, se);
+
+	if (next) {
+		/*
+		 * The previous task might be eligible for being pushed on another cpu
+		 * if it is still active.
+		 */
+		if (next != prev)
+			fair_add_pushable_prev(rq, prev, next);
+
+		if (next->sched_class != &fair_sched_class)
+			fair_queue_push_tasks(rq);
+	}
 }
 
 /*
@@ -15667,6 +15839,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switching_from_fair(struct rq *rq, struct task_struct *p)
 {
+	fair_remove_pushable_task(rq, p);
 	if (p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 }
@@ -15710,6 +15883,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 		goto repick;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	if (on_rq)
 		__dequeue_entity(cfs_rq, se);
@@ -15754,7 +15928,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
-
+	fair_queue_push_tasks(rq);
 repick:
 	/*
 	 * A same-task repick skips put_prev_task_fair(), but
@@ -15770,6 +15944,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7a95df4f14d2..74e68d458509 100644
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
@@ -3887,6 +3889,8 @@ static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
+DECLARE_STATIC_KEY_FALSE(sched_push_task);
+
 #ifdef CONFIG_MEMBARRIER
 
 /*
@@ -4219,6 +4223,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu);
+
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

