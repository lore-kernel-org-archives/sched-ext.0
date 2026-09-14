Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B3C10BE;
	Mon, 14 Sep 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429384; cv=none; b=ehyWatTF07LbyvgZqImtD8ViDxvRoMPzEx2qKdypyzDncHJbzAYVnXua6cNHMuWOSSRDNDdoEK3RiOn9BXWSygFg5Fl6f8/ijtlmTHtvsCLoKpQbefBaSX4IYYwbydtb2Tzmrg5DdSTlxQdRDiyiu1VqsOPv7YwTKzr9fo77DHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429384; c=relaxed/simple;
	bh=IHCJJYsM69/x9ExLdP7eoEmBCDBMmjRNaSlWrplRZTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5vpcUUIchbD3eV1xKP9AusZ2w697grCJOW9mzrxOQ5sSMmdsXRuxiH62fVNJA7MZ8sDptTzQUpEsH503D1y4q6h9070hlo02yja6OTCxm0d4ScKnK+cJjyzsp/dDgAr/zmJGKIXC8LsRTq0X3CNGF9/eGDIZRNueKzKIIrRphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH6tVa35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH6tVa35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202E1F00898;
	Mon, 14 Sep 2026 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429382;
	bh=mg3Q4qt8Ofjv2S0dIbdw0SYBd2t8KZymtlWMb+c0fjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AH6tVa3562tnQf4lc1zFM1JXGuSxsVDbXioxbEKm4AccrDJXDaJ8JEIdCx3FI+Suf
	 SlnwIRppUCDqi8AnBlnuvU+S7cmPycnJoy6r7gkl/lJMDoxGm3k6AakfK5+ZHPGlG+
	 2I20dflKnxLQchOq8zSKewitXMcRN7G08iOP01F7+ZoGk5yIy4w+95VFCY6LeKWBCc
	 TB9tBpA3mTrxZ2N3z8cKqTU5F93Lts3ToQODq6wO1/y8njfDz3Z4wSu+5Tnq5nIM8/
	 2JLi9j2MQZAm4xf+W8ZWzbuhcTazBYwMDntcYzX9M+T0OkRzQAfu6VTK+VHLvwV/or
	 ralD6L8sGjPug==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Maintain an online cid mask in the scheduler arena
Date: Mon, 14 Sep 2026 13:42:59 -1000
Message-ID: <20260914234259.3585373-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914234259.3585373-1-tj@kernel.org>
References: <20260914234259.3585373-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Schedulers on the default cid mapping treat [0, nr_online_cids) as the
online set and restart on hotplug. Schedulers that install their own mapping
with scx_bpf_cid_override() have no way to learn which cids are online: the
count no longer identifies members and the CPU-form cpumask is unusable from
cid programs. This is an obvious hole in the cid API.

Add scx_bpf_online_cmask(), a kernel-maintained cmask in the scheduler's
arena, allocated alongside the per-CPU scratch masks and populated after the
cid mapping is finalized and before ops.init(), for child schedulers too.
The pointer stays valid through ops.exit() with no reference to take. It is
the arena offset as a void pointer, the same form struct_ops arena arguments
arrive in. The verifier types the void return as a scalar for the program's
arena cast.

The mask follows the SCX hotplug notifications: seeded from cpu_active_mask
and updated before ops.cid_online/offline() runs, so it lags cpu_online_mask
only inside a hotplug transition. Updates walk the scheduler list under the
lock that also serializes unlinking. Reads are live, not atomic snapshots.
Root initialization excludes hotplug.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   | 74 ++++++++++++++++++++++--
 kernel/sched/ext/internal.h              |  3 +-
 kernel/sched/ext/sub.c                   | 10 ++--
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 4 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 934605dfd950..54a1d84469bf 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3670,8 +3670,20 @@ static void handle_hotplug(struct rq *rq, bool online)
 		s16 *tbl = rcu_dereference_check(scx_cpu_to_cid_tbl,
 						 lockdep_is_cpus_held());
 
-		if (tbl)
+		if (tbl) {
+			struct scx_sched *pos;
+
 			cpu_or_cid = tbl[cpu];
+
+			guard(raw_spinlock_irqsave)(&scx_sched_lock);
+			list_for_each_entry(pos, &scx_sched_all, all) {
+				struct scx_cmask *mask = pos->online_cmask;
+
+				if (mask)
+					__assign_bit(cpu_or_cid, (unsigned long *)mask->bits,
+						     online);
+			}
+		}
 	}
 
 	if (online && SCX_HAS_OP(sch, cpu_online))
@@ -5280,12 +5292,17 @@ static void free_exit_info(struct scx_exit_info *ei);
 static const char *scx_exit_reason(enum scx_exit_kind kind);
 static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
 
-s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
+s32 scx_alloc_kern_arena_objs(struct scx_sched *sch)
 {
 	size_t size = struct_size_t(struct scx_cmask, bits,
 				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
+	struct scx_cmask *online;
+	struct scx_cmask_ref ref;
 	int cpu;
 
+	/* hotplug stays excluded until the online mask is published */
+	lockdep_assert_cpus_held();
+
 	if (!sch->is_cid_type || !sch->arena_pool)
 		return 0;
 
@@ -5301,15 +5318,28 @@ s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
 			return -ENOMEM;
 		scx_cmask_init(*slot, 0, num_possible_cpus());
 	}
+
+	/* pack the online mask alongside the scratch masks */
+	online = scx_arena_alloc(sch, size);
+	if (!online)
+		return -ENOMEM;
+
+	scoped_guard(rcu) {
+		scx_cmask_ref_init_kern(sch, online, 0, num_possible_cpus(), &ref);
+		scx_cmask_ref_from_cpumask(&ref, cpu_active_mask);
+	}
+	sch->online_cmask = online;
+
 	return 0;
 }
 
-static void scx_set_cmask_scratch_free(struct scx_sched *sch)
+static void scx_free_kern_arena_objs(struct scx_sched *sch)
 {
 	size_t size = struct_size_t(struct scx_cmask, bits,
 				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
 	int cpu;
 
+	scx_arena_free(sch, sch->online_cmask, size);
 	if (!sch->set_cmask_scratch)
 		return;
 
@@ -5396,7 +5426,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
-	scx_set_cmask_scratch_free(sch);
+	scx_free_kern_arena_objs(sch);
 	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
@@ -7602,7 +7632,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
-	ret = scx_set_cmask_scratch_alloc(sch);
+	ret = scx_alloc_kern_arena_objs(sch);
 	if (ret) {
 		cpus_read_unlock();
 		goto err_disable;
@@ -10339,13 +10369,44 @@ __bpf_kfunc u32 scx_bpf_nr_cids(void)
  * hotplug, which lets schedulers treat [0, nr_online_cids) as the online
  * range. Schedulers that prefer to handle hotplug without a restart should
  * install a custom mapping via scx_bpf_cid_override() and track onlining
- * through the ops.cid_online / ops.cid_offline callbacks.
+ * through the ops.cid_online / ops.cid_offline callbacks, starting from the
+ * mask scx_bpf_online_cmask() returns.
  */
 __bpf_kfunc u32 scx_bpf_nr_online_cids(void)
 {
 	return num_online_cpus();
 }
 
+/**
+ * scx_bpf_online_cmask - Return the online cid mask in the scheduler arena
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Return a read-only cmask covering [0, scx_bpf_nr_cids()) which the kernel
+ * keeps in the scheduler's arena, or NULL if the calling program is not
+ * associated with a live cid-form scheduler. The mask follows the SCX hotplug
+ * notifications: a cid's bit is updated before ops.cid_online/offline() runs
+ * for it. The pointer is valid from ops.init() through ops.exit(). Root
+ * ops.init() runs with hotplug excluded. Other contexts can observe concurrent
+ * updates.
+ */
+__bpf_kfunc const void *scx_bpf_online_cmask(const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	struct scx_cmask *online;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return NULL;
+	online = sch->online_cmask;
+	if (unlikely(!online))
+		return NULL;
+
+	/* BPF rebases by the low 32 bits, like __arena callback args */
+	return (void *)((unsigned long)online - sch->arena_kern_base);
+}
+
 /**
  * scx_bpf_this_cid - Return the cid of the CPU this program is running on
  *
@@ -10709,6 +10770,7 @@ BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cids)
 BTF_ID_FLAGS(func, scx_bpf_nr_online_cids)
+BTF_ID_FLAGS(func, scx_bpf_online_cmask, KF_IMPLICIT_ARGS | KF_ARENA_RET)
 BTF_ID_FLAGS(func, scx_bpf_this_cid)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 2586879e9084..067cddf47220 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1572,6 +1572,7 @@ struct scx_sched {
 	 * and passes it to the callback's __arena argument.
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
+	struct scx_cmask *online_cmask;
 
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
@@ -2098,7 +2099,7 @@ void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p);
 void scx_cgroup_lock(void);
 void scx_cgroup_unlock(void);
 #endif
-s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch);
+s32 scx_alloc_kern_arena_objs(struct scx_sched *sch);
 void scx_disable_bypass_dsp(struct scx_sched *sch);
 void scx_bypass(struct scx_sched *sch, bool bypass);
 s32 scx_link_sched(struct scx_sched *sch);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 385302d19914..f7aeb1488566 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1805,6 +1805,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	scoped_guard(cpus_read_lock) {
+		ret = scx_alloc_kern_arena_objs(sch);
+		if (ret)
+			goto err_disable;
+	}
+
 	if (sch->ops.init) {
 		ret = SCX_CALL_OP_RET(sch, init, NULL);
 		if (ret) {
@@ -1815,10 +1821,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
-	ret = scx_set_cmask_scratch_alloc(sch);
-	if (ret)
-		goto err_disable;
-
 	struct scx_sub_attach_args sub_attach_args = {
 		.ops = &sch->ops,
 		.cgroup_path = sch->cgrp_path,
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 76f5e025e107..2ddb01a059fd 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -113,6 +113,7 @@ s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
 u32 scx_bpf_nr_cids(void) __ksym __weak;
 u32 scx_bpf_nr_online_cids(void) __ksym __weak;
+const void __arena *scx_bpf_online_cmask(void) __ksym __weak;
 u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
 u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
 s32 scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
-- 
2.55.0

