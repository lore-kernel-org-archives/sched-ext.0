Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB5303A2E;
	Wed, 22 Oct 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166594; cv=none; b=uYtckQrvcNTJ0kuMtgT1g/CAL6G4S7tnAV2aUvF/Df1p5VMH2m8Ig7nTQJmIp32/iX+xSpLbPLkHp1qh0CqkElheRLoqYJa0aq6HcuNteBbiRBn6fJ62JtXFH5v5yHpP1HeOXgxYlmxJM1dkj+IVb1aYdyXkJCUFMDB+NkTbW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166594; c=relaxed/simple;
	bh=VKWFVy7XCQrFd2DdX5VPfAMp0XUdeIkTX4YYGvHGvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIuk1XAUbzYVh2NfFlZnWxaDUGt4VOKZewRmSssyvlPXmDrnucBiSdCcjehdtPXwCEJXstmd7zlqQFk7ZM5jFhnnwF9u1bfGKe8p253Hc/2a+wZ1rLm0DYfDzsN2wPhkyJVL247/WqB2rPuLwGIrV/Dc6iEBQZTTDpmwZf9jucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzFlzQpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzFlzQpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FFFC4CEFF;
	Wed, 22 Oct 2025 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166593;
	bh=VKWFVy7XCQrFd2DdX5VPfAMp0XUdeIkTX4YYGvHGvD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzFlzQpRsGN96aDCwHJbf4FZyY2AagSDyf0SOjeemI6JeAnJBMsoYaxzrA2KTqt9Z
	 DKzzeVemopKdAqifS9PCOa24ZVYP30ZfiLBYsz59X5YMZ1Az25hKvIDcsey/j/k63o
	 /wddOzG15mzGVOGJ5u/l9q6XMI6L4+IvtWS0bhSiHMB0YouIniJVTvgT6EoedKbgZN
	 3+za9KLbnn51j/RzzAOiRG8579GAsVyMvWm7+iI5LV9ivhvIlA6Sxzr1DCLjZyKrWf
	 1Eem5a1G012FHUfSmOLc8cSPm/zfkwBMQKQrIn2a4wmENMGJ3vDkicSRUntX5ePDNz
	 br8oBIvmzwA8Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH RESEND v2 3/3] sched_ext: Rename pnt_seq to kick_sync
Date: Wed, 22 Oct 2025 10:56:29 -1000
Message-ID: <20251022205629.845930-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251022205629.845930-1-tj@kernel.org>
References: <20251022205629.845930-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pnt_seq field and related infrastructure were originally named for
"pick next task sequence", reflecting their original implementation in
scx_next_task_picked(). However, the sequence counter is now incremented in
both put_prev_task_scx() and pick_task_scx() and its purpose is to
synchronize kick operations via SCX_KICK_WAIT, not specifically to track
pick_next_task events.

Rename to better reflect the actual semantics:
- pnt_seq -> kick_sync
- scx_kick_pseqs -> scx_kick_syncs
- pseqs variables -> ksyncs
- Update comments to refer to "kick_sync sequence" instead of "pick_task
  sequence"

This is a pure renaming with no functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c   | 80 ++++++++++++++++++++++++++--------------------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -68,18 +68,18 @@ static unsigned long scx_watchdog_timest
 static struct delayed_work scx_watchdog_work;
 
 /*
- * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task sequence
+ * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of kick_sync sequence
  * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
  * allocator limits on large machines. O(nr_cpu_ids^2) allocation, allocated
  * lazily when enabling and freed when disabling to avoid waste when sched_ext
  * isn't active.
  */
-struct scx_kick_pseqs {
+struct scx_kick_syncs {
 	struct rcu_head		rcu;
-	unsigned long		seqs[];
+	unsigned long		syncs[];
 };
 
-static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
+static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
 
 /*
  * Direct dispatch marker.
@@ -2301,7 +2301,7 @@ static void put_prev_task_scx(struct rq
 	struct scx_sched *sch = scx_root;
 
 	/* see kick_cpus_irq_workfn() */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
 	update_curr_scx(rq);
 
@@ -2357,7 +2357,7 @@ do_pick_task_scx(struct rq *rq, struct r
 	struct task_struct *p;
 
 	/* see kick_cpus_irq_workfn() */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
 
 	rq_modified_clear(rq);
 
@@ -3883,24 +3883,24 @@ static const char *scx_exit_reason(enum
 	}
 }
 
-static void free_kick_pseqs_rcu(struct rcu_head *rcu)
+static void free_kick_syncs_rcu(struct rcu_head *rcu)
 {
-	struct scx_kick_pseqs *pseqs = container_of(rcu, struct scx_kick_pseqs, rcu);
+	struct scx_kick_syncs *ksyncs = container_of(rcu, struct scx_kick_syncs, rcu);
 
-	kvfree(pseqs);
+	kvfree(ksyncs);
 }
 
-static void free_kick_pseqs(void)
+static void free_kick_syncs(void)
 {
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
-		struct scx_kick_pseqs *to_free;
+		struct scx_kick_syncs **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
+		struct scx_kick_syncs *to_free;
 
-		to_free = rcu_replace_pointer(*pseqs, NULL, true);
+		to_free = rcu_replace_pointer(*ksyncs, NULL, true);
 		if (to_free)
-			call_rcu(&to_free->rcu, free_kick_pseqs_rcu);
+			call_rcu(&to_free->rcu, free_kick_syncs_rcu);
 	}
 }
 
@@ -4038,7 +4038,7 @@ static void scx_disable_workfn(struct kt
 	free_percpu(scx_dsp_ctx);
 	scx_dsp_ctx = NULL;
 	scx_dsp_max_batch = 0;
-	free_kick_pseqs();
+	free_kick_syncs();
 
 	mutex_unlock(&scx_enable_mutex);
 
@@ -4287,10 +4287,10 @@ static void scx_dump_state(struct scx_ex
 		seq_buf_init(&ns, buf, avail);
 
 		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu pnt_seq=%lu",
+		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
 			  cpu, rq->scx.nr_running, rq->scx.flags,
 			  rq->scx.cpu_released, rq->scx.ops_qseq,
-			  rq->scx.pnt_seq);
+			  rq->scx.kick_sync);
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
@@ -4401,7 +4401,7 @@ static void scx_vexit(struct scx_sched *
 	irq_work_queue(&sch->error_irq_work);
 }
 
-static int alloc_kick_pseqs(void)
+static int alloc_kick_syncs(void)
 {
 	int cpu;
 
@@ -4410,19 +4410,19 @@ static int alloc_kick_pseqs(void)
 	 * can exceed percpu allocator limits on large machines.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
-		struct scx_kick_pseqs *new_pseqs;
+		struct scx_kick_syncs **ksyncs = per_cpu_ptr(&scx_kick_syncs, cpu);
+		struct scx_kick_syncs *new_ksyncs;
 
-		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
+		WARN_ON_ONCE(rcu_access_pointer(*ksyncs));
 
-		new_pseqs = kvzalloc_node(struct_size(new_pseqs, seqs, nr_cpu_ids),
-					  GFP_KERNEL, cpu_to_node(cpu));
-		if (!new_pseqs) {
-			free_kick_pseqs();
+		new_ksyncs = kvzalloc_node(struct_size(new_ksyncs, syncs, nr_cpu_ids),
+					   GFP_KERNEL, cpu_to_node(cpu));
+		if (!new_ksyncs) {
+			free_kick_syncs();
 			return -ENOMEM;
 		}
 
-		rcu_assign_pointer(*pseqs, new_pseqs);
+		rcu_assign_pointer(*ksyncs, new_ksyncs);
 	}
 
 	return 0;
@@ -4578,14 +4578,14 @@ static int scx_enable(struct sched_ext_o
 		goto err_unlock;
 	}
 
-	ret = alloc_kick_pseqs();
+	ret = alloc_kick_syncs();
 	if (ret)
 		goto err_unlock;
 
 	sch = scx_alloc_and_add_sched(ops);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-		goto err_free_pseqs;
+		goto err_free_ksyncs;
 	}
 
 	/*
@@ -4788,8 +4788,8 @@ static int scx_enable(struct sched_ext_o
 
 	return 0;
 
-err_free_pseqs:
-	free_kick_pseqs();
+err_free_ksyncs:
+	free_kick_syncs();
 err_unlock:
 	mutex_unlock(&scx_enable_mutex);
 	return ret;
@@ -5119,7 +5119,7 @@ static bool can_skip_idle_kick(struct rq
 	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_IN_BALANCE);
 }
 
-static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
+static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
@@ -5146,7 +5146,7 @@ static bool kick_one_cpu(s32 cpu, struct
 
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
 			if (cur_class == &ext_sched_class) {
-				pseqs[cpu] = rq->scx.pnt_seq;
+				ksyncs[cpu] = rq->scx.kick_sync;
 				should_wait = true;
 			} else {
 				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
@@ -5182,20 +5182,20 @@ static void kick_cpus_irq_workfn(struct
 {
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
-	struct scx_kick_pseqs __rcu *pseqs_pcpu = __this_cpu_read(scx_kick_pseqs);
+	struct scx_kick_syncs __rcu *ksyncs_pcpu = __this_cpu_read(scx_kick_syncs);
 	bool should_wait = false;
-	unsigned long *pseqs;
+	unsigned long *ksyncs;
 	s32 cpu;
 
-	if (unlikely(!pseqs_pcpu)) {
-		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_pseqs");
+	if (unlikely(!ksyncs_pcpu)) {
+		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_syncs");
 		return;
 	}
 
-	pseqs = rcu_dereference_bh(pseqs_pcpu)->seqs;
+	ksyncs = rcu_dereference_bh(ksyncs_pcpu)->syncs;
 
 	for_each_cpu(cpu, this_scx->cpus_to_kick) {
-		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
+		should_wait |= kick_one_cpu(cpu, this_rq, ksyncs);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
 	}
@@ -5209,7 +5209,7 @@ static void kick_cpus_irq_workfn(struct
 		return;
 
 	for_each_cpu(cpu, this_scx->cpus_to_wait) {
-		unsigned long *wait_pnt_seq = &cpu_rq(cpu)->scx.pnt_seq;
+		unsigned long *wait_kick_sync = &cpu_rq(cpu)->scx.kick_sync;
 
 		/*
 		 * Busy-wait until the task running at the time of kicking is no
@@ -5223,7 +5223,7 @@ static void kick_cpus_irq_workfn(struct
 		 * the wait when $cpu is taken by a higher sched class.
 		 */
 		if (cpu != cpu_of(this_rq))
-			smp_cond_load_acquire(wait_pnt_seq, VAL != pseqs[cpu]);
+			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
 
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -803,7 +803,7 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
-	unsigned long		pnt_seq;
+	unsigned long		kick_sync;
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-- 
2.47.1
