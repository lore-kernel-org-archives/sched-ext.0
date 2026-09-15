Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94149DBB9;
	Tue, 15 Sep 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460850; cv=none; b=koVr7PIcfhMTJXzOBeYwNFpEZ00onrUiogsrZtA41eQTQzRM0kb6BLNI8RerMSlSiJBLkvV6XvNE2pJb7IPLGy3LyfP5OYQoWsziObv6fuyCHO46yASNS/Vdhw09S9g1RQf9RseyBdqzKpqa/qBv9ahgvV1I3/Tpaz++cripju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460850; c=relaxed/simple;
	bh=Rf6vDjJ9YQPHHhCbEsefcg1KFicJPVI8AWG9IkgH8HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upaaFUQOKn2WPqhgdWuqg32+FfCUTDhBeUtm9BcMz4aXc0KzVdcb1Cldmj6nP4sksFGDdup/iwaeoPZlXupERZSQNIXPnfHML6vq+mbuk/WfTJc0ibdmT/5bfEb2bLKzJeUjlqRa5Wgzsd89bP4uIPKHpkdftO00r4XJ81zLtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAgSykCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAgSykCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED841F00898;
	Tue, 15 Sep 2026 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460848;
	bh=YCD+eaM0vQuBoorLLP6R8i7M/O+TRaN06s+Q/kXHLGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAgSykCJllc/wtP85OAkGoHIbpO84YyG2qxV3KZE7befltimgXvYW9KF4o/KreBKv
	 WuaCySsq//0SzY9CCyLNdF7u3bEyhQ4Jthc5EPOu2lahscOtJbri0oC4CMYNhNz+uD
	 GjpKkKePgVXzG16+M7brEfor12j5wUJC3lN0Hpzc8OJx9ydIo+B8VbmiQ+ZsL3S3IB
	 f7aSSube6jkGaLV8XK3d0KtXi8GCKD5+JInPj8qRCAaMBHCYWg886R1u5Dry+maDtn
	 3ubjNvcYqdJBoIgp8mYrJRzgwZN7fbmc568SVdBB068i9XMQazYNYvO0NkWeDdZbh4
	 Os4rpImgG3/BA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Maintain an online cid mask in the scheduler arena
Date: Mon, 14 Sep 2026 22:27:25 -1000
Message-ID: <20260915082725.3881071-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915082725.3881071-1-tj@kernel.org>
References: <20260915082725.3881071-1-tj@kernel.org>
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

v2: Reworded the getter kerneldoc (Andrea Righi).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                   | 75 ++++++++++++++++++++++--
 kernel/sched/ext/internal.h              |  3 +-
 kernel/sched/ext/sub.c                   | 10 ++--
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 4 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 83999203a63a..70b711c4de6e 100644
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
@@ -7601,7 +7631,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
-	ret = scx_set_cmask_scratch_alloc(sch);
+	ret = scx_alloc_kern_arena_objs(sch);
 	if (ret) {
 		cpus_read_unlock();
 		goto err_disable;
@@ -10338,13 +10368,45 @@ __bpf_kfunc u32 scx_bpf_nr_cids(void)
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
+ * Return a kernel-maintained cmask covering [0, scx_bpf_nr_cids()), or NULL if
+ * the calling program is not associated with a live cid-form scheduler or the
+ * mask is not allocated yet, as in ops.init_cids(). Treat the mask as read-only
+ * even though arena memory stays writable by the BPF scheduler. The mask
+ * follows the SCX hotplug notifications: a cid's bit is updated before
+ * ops.cid_online/offline() runs for it. The pointer is valid from ops.init()
+ * through ops.exit(). Root ops.init() runs with hotplug excluded. Other
+ * contexts can observe concurrent updates.
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
@@ -10708,6 +10770,7 @@ BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cids)
 BTF_ID_FLAGS(func, scx_bpf_nr_online_cids)
+BTF_ID_FLAGS(func, scx_bpf_online_cmask, KF_IMPLICIT_ARGS | KF_ARENA_RET)
 BTF_ID_FLAGS(func, scx_bpf_this_cid)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 0adaf649d5e0..3464e0f113c1 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1561,6 +1561,7 @@ struct scx_sched {
 	 * and passes it to the callback's __arena argument.
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
+	struct scx_cmask *online_cmask;
 
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
@@ -2087,7 +2088,7 @@ void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p);
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

