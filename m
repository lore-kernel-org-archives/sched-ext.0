Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E9381AE1;
	Fri,  3 Jul 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065739; cv=none; b=pgzSXzzyXR2IRNt6QT8n4anO3MzikOsFYJwgyBFSAoyVrCpSYzupoutIILEV858Lu6VXw5GXVJzWqY0v2p2IbA2UqE58gEf13z1WBGxpJf3zh9inJhuTcREoFx6UlxhM/0yRXKfU3sqoV8m+1Hzy+DO/E9Jui6s2mRuvkTMNPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065739; c=relaxed/simple;
	bh=1ea+0Pyw6Lt121O6/juy4vMfz2doKnbT5+JfIJswZRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXXXQGMbV5x5Gc1BlZ4neOkY/ZMa5Xvl/BroehCnWZUtmXQpagioHGTxFusbvjpw3XLcPU/5NnJJOAEweI5rR/vy2xMU6cre5SNae6aI3AA0bjlCecQZzL4iClxeoyExN53WK0K5IJybyfZcQHvq7ev0wGTb74I3zXYAUUD7NP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZqLxpLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZqLxpLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503321F00A3A;
	Fri,  3 Jul 2026 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065736;
	bh=eEDuIx6dE1ZtnmFIQKb0TMAr4lZcLlHcynErg2EewNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZqLxpLYPuj1BrXng8hknRSD0ZY4SIA3wmSWA5dMrOFAxGhdAgfstuNnHNC7SMnwE
	 k7RfuTBjypQBjfT3B6J9TMhMbqa5ebaETNh+WVOPR5XGSAhEcUkbMBHh2h5silwUuX
	 8G/Jz0YvuXxoSFCCIz+G/+54jBu/y4O3bxOpRu/cAEgNeCmvwq3WZYTtAwwC8B9lET
	 s9+nhsc0WWxly5Y9dA1ZBc2oiB7L4Qp4dJH+x7yuizkb3V5vcO1RSzNzsoB+wbzORB
	 Ij9UlmdwIfTsF53TyBbNUWFfdGhz4XFXk6i+KnrjFZ6bEB+cUkpsE4jDv7DakJmr8B
	 laN5vgs70fNKg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 16/32] sched_ext: Add per-shard cap delegation for sub-schedulers
Date: Thu,  2 Jul 2026 22:01:43 -1000
Message-ID: <20260703080159.2314350-17-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caps are per-cid permissions parents delegate to direct children via
scx_bpf_sub_grant() / scx_bpf_sub_revoke(). A child's cap set is always a
subset of its parent's. Sub-scheds check their caps locally, and cross-sched
communication is needed only when the delegation set itself changes.

Caps will be used to implement sub-sched scheduling on the enqueue path.
Picking a cid for a task at a leaf depends on which cids the leaf is allowed
to use, and resolving that programmatically on every enqueue would mean a
cross-sched round-trip call chain, possibly retrying if the request can't be
granted as-is. The dispatch path is different - it runs as top-down
recursion via scx_bpf_sub_dispatch().

Locking is per shard. cid space is split into shards, and each sub-sched has
its own pshard->lock for each shard. Operations are broken up on shard
boundaries. Different shards never contend. Shards are expected to be
topology-aligned and likely to serve as the locality unit when cids are
allocated to schedulers, so per-shard lock granularity scales naturally with
the allocation pattern.

This patch adds the framework with a single dummy cap. Real caps land in
later patches.

The enable path is reordered for pshards. scx_arena_pool_init() moves ahead
of scx_link_sched() so the pshards are allocated before the sched becomes
reachable - scx_alloc_pshards() skips allocation when the arena pool isn't
initialized. A failing sub-enable also records an scx_error() now, so an
errno-only failure leaves a recorded reason for the disable work.

- scx_bpf_sub_grant(): Per-cid all-or-nothing grant to direct child.
- scx_bpf_sub_revoke(): Clear caps on @cmask across @child and its subtree.
- scx_bpf_sub_caps(): Lockless snapshot of caps on a cid range.

/sys/kernel/sched_ext/SCHED/caps shows the caps each scheduler currently
holds.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   |  77 +++++-
 kernel/sched/ext/internal.h              |  56 +++-
 kernel/sched/ext/sub.c                   | 334 ++++++++++++++++++++++-
 kernel/sched/ext/sub.h                   |   2 +
 tools/sched_ext/include/scx/common.bpf.h |   6 +
 5 files changed, 463 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1e38aaad4332..26b869c373c7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4710,9 +4710,52 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 }
 SCX_ATTR(events);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static const char *scx_cap_names[__SCX_NR_CAPS] = {
+	[__SCX_CAP_DUMMY]	= "dummy",
+};
+
+static ssize_t scx_attr_caps_show(struct kobject *kobj,
+				  struct kobj_attribute *ka, char *buf)
+{
+	struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
+	u32 npossible = num_possible_cpus();
+	struct scx_cmask *agg __free(kfree) =
+		kzalloc(struct_size(agg, bits, SCX_CMASK_NR_WORDS(npossible)), GFP_KERNEL);
+	unsigned long *agg_bm __free(bitmap) = bitmap_zalloc(npossible, GFP_KERNEL);
+	ssize_t count = 0;
+	s32 cap, si;
+
+	if (!agg || !agg_bm)
+		return -ENOMEM;
+
+	for (cap = 0; cap < __SCX_NR_CAPS; cap++) {
+		SCX_CMASK_DEFINE(snap, 0, SCX_CID_SHARD_MAX_CPUS);
+
+		scx_cmask_init(agg, 0, npossible);
+		for (si = 0; si < sch->nr_pshards; si++) {
+			struct scx_cmask *cm = &sch->pshard[si]->caps[cap].cmask;
+
+			scx_cmask_reframe(snap, cm->base, cm->nr_cids);
+			scx_cmask_copy(snap, cm);
+			scx_cmask_or(agg, snap);
+		}
+		/* %*pbl takes unsigned long bitmap layout, convert from u64 */
+		bitmap_from_arr64(agg_bm, agg->bits, npossible);
+		count += sysfs_emit_at(buf, count, "%s: %*pbl\n",
+				       scx_cap_names[cap], npossible, agg_bm);
+	}
+	return count;
+}
+SCX_ATTR(caps);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 static struct attribute *scx_sched_attrs[] = {
 	&scx_attr_ops.attr,
 	&scx_attr_events.attr,
+#ifdef CONFIG_EXT_SUB_SCHED
+	&scx_attr_caps.attr,
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(scx_sched);
@@ -6711,8 +6754,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 	/*
 	 * A cid-form scheduler finalizes its cid layout in ops.init_cids(),
-	 * which may call scx_bpf_cid_override(). Run it before ops.init() so
-	 * the final layout is in effect.
+	 * which may call scx_bpf_cid_override(). Run it before the caps and
+	 * shard state are built so the final layout is in effect.
 	 */
 	if (sch->is_cid_type && sch->ops_cid.init_cids) {
 		ret = SCX_CALL_OP_RET(sch, init_cids, NULL);
@@ -6742,6 +6785,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	scx_init_root_caps(sch);
+
+	/* the cid caps and shards are live now, so ops.init() can query them */
 	if (sch->ops.init) {
 		ret = SCX_CALL_OP_RET(sch, init, NULL);
 		if (ret) {
@@ -7423,7 +7469,7 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 /*
  * cid-form cfi stubs. Stubs whose signatures match the cpu-form (param types
- * identical, only param names differ across structs) are reused; only
+ * identical, only param names differ across structs) are reused. Only
  * set_cmask needs a fresh stub since the second argument type differs.
  */
 static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
@@ -9611,6 +9657,28 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 }
 #endif	/* CONFIG_CGROUP_SCHED */
 
+#ifndef CONFIG_EXT_SUB_SCHED
+__bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
+				  const struct scx_cmask *cmask__ign,
+				  struct scx_cmask *denied_out__ign,
+				  const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
+
+__bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
+				    const struct scx_cmask *cmask__ign,
+				    const struct bpf_prog_aux *aux)
+{
+}
+
+__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out__ign,
+				 const struct bpf_prog_aux *aux)
+{
+	return -EOPNOTSUPP;
+}
+#endif	/* !CONFIG_EXT_SUB_SCHED */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -9655,6 +9723,9 @@ BTF_ID_FLAGS(func, scx_bpf_events)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
 #endif
+BTF_ID_FLAGS(func, scx_bpf_sub_grant, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_sub_revoke, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_sub_caps, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e79175fab862..0fa1e298220d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -786,9 +786,9 @@ struct sched_ext_ops {
 	/**
 	 * @init_cids: Finalize the cid layout (cid-form only)
 	 *
-	 * Runs after the default cid layout is built, before ops.init(). A
-	 * cid-form scheduler may call scx_bpf_cid_override() here for a custom
-	 * layout. Ignored for cpu-form schedulers.
+	 * Runs after the default cid layout is built, before caps and shards
+	 * are finalized. A cid-form scheduler may call scx_bpf_cid_override()
+	 * here for a custom layout. Ignored for cpu-form schedulers.
 	 */
 	s32 (*init_cids)(void);
 
@@ -1183,9 +1183,57 @@ struct scx_sched_pnode {
 	struct scx_dispatch_q	global_dsq;
 };
 
+/*
+ * Sub-sched capability delegation.
+ *
+ * Caps are per-cid permissions parents delegate to direct children via
+ * scx_bpf_sub_grant() / scx_bpf_sub_revoke(). A child's cap set is always a
+ * subset of its parent's. A sub-sched checks its caps locally, and cross-sched
+ * communication is needed only when the delegation set itself changes.
+ *
+ * Caps are used to implement sub-sched scheduling on the enqueue path. Picking
+ * a cid for a task at a leaf depends on which cids the leaf is allowed to use.
+ * Resolving that programmatically on every enqueue would mean a cross-sched
+ * round-trip call chain, possibly retrying if the request can't be granted
+ * as-is.
+ *
+ * The dispatch path is different - it runs as top-down recursion via
+ * scx_bpf_sub_dispatch(): a sched's dispatch op invokes a child's dispatch op
+ * on the local rq, and the subtree dispatches in a single pass.
+ *
+ * Locking is per shard. cid space is split into shards, and each sub-sched has
+ * its own pshard->lock for each shard. Operations are broken up on shard
+ * boundaries. Different shards never contend. Shards are expected to be
+ * topology-aligned and likely to serve as the locality unit when cids are
+ * allocated to schedulers, so per-shard lock granularity scales naturally with
+ * the allocation pattern.
+ */
+enum scx_cap_flags {
+	__SCX_CAP_DUMMY			= 0,
+
+	__SCX_NR_CAPS,
+	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
+
+	SCX_CAP_DUMMY			= BIT_U64(__SCX_CAP_DUMMY),
+};
+
 #ifdef CONFIG_EXT_SUB_SCHED
+/* iterate set bits in a u64 cap mask */
+#define scx_for_each_cap_bit(cap_bit, caps)				\
+	for (u64 __caps = (caps);					\
+	     __caps && ((cap_bit) = __ffs64(__caps), true);		\
+	     __caps &= __caps - 1)
+
 struct scx_pshard {
-	int			_dummy;		/* until the first real field lands */
+	raw_spinlock_t		lock;		/* serializes caps */
+	struct scx_sched	*sch;		/* backpointer */
+	/*
+	 * Per-cap cmask, inline via TRAILING_OVERLAP so cmask.bits[] overlaps
+	 * the trailing _bits[] storage. Access as &caps[i].cmask.
+	 */
+	TRAILING_OVERLAP(struct scx_cmask, cmask, bits,
+			 u64 _bits[SCX_CMASK_NR_WORDS(SCX_CID_SHARD_MAX_CPUS)];
+	) caps[__SCX_NR_CAPS];
 };
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 1e84f4620176..e7259623fa3c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -122,7 +122,21 @@ void scx_free_pshards(struct scx_sched *sch)
 
 static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32 node)
 {
-	return kzalloc_node(sizeof(struct scx_pshard), GFP_KERNEL, node);
+	const struct scx_cid_shard *shard = &scx_cid_shard_ranges[shard_idx];
+	struct scx_pshard *pshard;
+	s32 i;
+
+	pshard = kzalloc_node(sizeof(*pshard), GFP_KERNEL, node);
+	if (!pshard)
+		return NULL;
+
+	raw_spin_lock_init(&pshard->lock);
+	pshard->sch = sch;
+
+	for (i = 0; i < __SCX_NR_CAPS; i++)
+		scx_cmask_init(&pshard->caps[i].cmask, shard->base_cid, shard->nr_cids);
+
+	return pshard;
 }
 
 s32 scx_alloc_pshards(struct scx_sched *sch)
@@ -146,6 +160,22 @@ s32 scx_alloc_pshards(struct scx_sched *sch)
 	return 0;
 }
 
+/*
+ * Seed the root's caps fully. Root owns all cids on all caps at enable time.
+ * Children acquire caps via scx_bpf_sub_grant().
+ */
+void scx_init_root_caps(struct scx_sched *sch)
+{
+	s32 si, i;
+
+	for (si = 0; si < sch->nr_pshards; si++) {
+		struct scx_pshard *ps = sch->pshard[si];
+
+		for (i = 0; i < __SCX_NR_CAPS; i++)
+			scx_cmask_fill(&ps->caps[i].cmask);
+	}
+}
+
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
 void drain_descendants(struct scx_sched *sch)
@@ -425,6 +455,23 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		goto out_unlock;
 	}
 
+	/*
+	 * Allocate pshard[] before scx_link_sched() publishes @sch into the
+	 * parent's RCU children list. A concurrent revoke walking the tree
+	 * would otherwise dereference sch->pshard[si] while it's still NULL.
+	 * Unlike the root path, the cid shard layout is stable at this point.
+	 *
+	 * scx_alloc_pshards() skips allocation when @sch's arena pool isn't
+	 * initialized, so scx_arena_pool_init() must run first.
+	 */
+	ret = scx_arena_pool_init(sch);
+	if (ret)
+		goto err_disable;
+
+	ret = scx_alloc_pshards(sch);
+	if (ret)
+		goto err_disable;
+
 	ret = scx_link_sched(sch);
 	if (ret)
 		goto err_disable;
@@ -449,10 +496,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
 	}
 
-	ret = scx_arena_pool_init(sch);
-	if (ret)
-		goto err_disable;
-
 	ret = scx_set_cmask_scratch_alloc(sch);
 	if (ret)
 		goto err_disable;
@@ -640,6 +683,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
+	/*
+	 * Some enable failures only return an errno (e.g. -ENOMEM from an
+	 * allocation) without calling scx_error(). Record it so
+	 * scx_flush_disable_work() runs the disable and ops.exit() fires.
+	 */
+	scx_error(sch, "scx_sub_enable() failed (%d)", ret);
 	scx_flush_disable_work(sch);
 	cmd->ret = 0;
 }
@@ -733,6 +782,281 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 				  true);
 }
 
+/* Validate common inputs. On success, *parent_out and *child_out are set. */
+static s32 sub_cap_preamble(u64 cgroup_id, u64 caps, const struct bpf_prog_aux *aux,
+			    struct scx_sched **parent_out, struct scx_sched **child_out)
+{
+	struct scx_sched *parent, *child;
+
+	parent = scx_prog_sched(aux);
+	if (unlikely(!parent))
+		return -ENODEV;
+
+	if (!scx_is_cid_type()) {
+		scx_error(parent, "sub-cap kfuncs require a cid-form scheduler");
+		return -EOPNOTSUPP;
+	}
+
+	child = scx_find_sub_sched(cgroup_id);
+	if (unlikely(!child))
+		return -ENODEV;
+
+	if (unlikely(scx_parent(child) != parent)) {
+		scx_error(parent, "%s: sub-%llu is not a direct child",
+			  parent->cgrp_path, cgroup_id);
+		return -EINVAL;
+	}
+
+	if (unlikely(caps & ~__SCX_CAP_ALL)) {
+		scx_error(parent, "invalid caps 0x%llx", caps);
+		return -EINVAL;
+	}
+
+	*parent_out = parent;
+	*child_out = child;
+	return 0;
+}
+
+/**
+ * scx_bpf_sub_grant - Grant @caps on @cmask__ign's cids to a direct child
+ * @cgroup_id: cgroup id of the direct child sub-sched
+ * @caps: bitmask of SCX_CAP_* to grant
+ * @cmask__ign: cid cmask to grant @caps on (arena pointer)
+ * @denied_out__ign: optional arena cmask accumulating refused cids
+ * @aux: implicit BPF argument
+ *
+ * A cid in @cmask__ign is granted to the child only if the parent holds every
+ * requested cap on it. Refused cids are OR'd into @denied_out__ign when
+ * provided. Refusals outside @denied_out__ign's range are not recorded.
+ *
+ * All-or-nothing keeps the caller-visible result binary per cid, so
+ * @denied_out__ign is one mask to interpret rather than a per-cap matrix.
+ *
+ * Return 0 on full success, -EPERM if any cid was refused, or a negative
+ * errno on other failures.
+ */
+__bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
+				  const struct scx_cmask *cmask__ign,
+				  struct scx_cmask *denied_out__ign,
+				  const struct bpf_prog_aux *aux)
+{
+	struct scx_cmask_ref ref, denied_ref;
+	struct scx_sched *parent, *child;
+	bool any_denied = false;
+	s32 si, ret;
+
+	guard(irqsave)();
+
+	ret = sub_cap_preamble(cgroup_id, caps, aux, &parent, &child);
+	if (ret)
+		return ret;
+
+	ret = scx_cmask_ref_init(parent, cmask__ign, &ref);
+	if (ret) {
+		scx_error(parent, "invalid cmask (%d)", ret);
+		return ret;
+	}
+
+	if (denied_out__ign) {
+		ret = scx_cmask_ref_init(parent, denied_out__ign, &denied_ref);
+		if (ret) {
+			scx_error(parent, "invalid denied_out (%d)", ret);
+			return ret;
+		}
+	}
+
+	/* apply the grant one shard at a time */
+	for (si = ref.shard_first; si < ref.shard_end; si++) {
+		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
+		struct scx_pshard *pps = parent->pshard[si];
+		struct scx_pshard *cps = child->pshard[si];
+		u32 cap_bit;
+
+		scx_cmask_ref_shard(&ref, si, slice);
+		if (scx_cmask_empty(slice))
+			continue;
+
+		SCX_CMASK_DEFINE_SHARD(granted_cids, slice->base, slice->nr_cids);
+		scx_cmask_copy(granted_cids, slice);
+
+		scoped_guard (raw_spinlock, &pps->lock) {
+			guard(raw_spinlock_nested)(&cps->lock);
+
+			/*
+			 * Narrow granted_cids to cids the parent holds every
+			 * requested cap on. All-or-nothing per cid.
+			 */
+			scx_for_each_cap_bit(cap_bit, caps)
+				scx_cmask_and(granted_cids, &pps->caps[cap_bit].cmask);
+
+			/* fold granted_cids into the child per requested cap */
+			scx_for_each_cap_bit(cap_bit, caps)
+				scx_cmask_or(&cps->caps[cap_bit].cmask, granted_cids);
+		}
+
+		/* record cids that didn't make it through into @denied_out */
+		if (!scx_cmask_subset(slice, granted_cids)) {
+			any_denied = true;
+			if (denied_out__ign) {
+				SCX_CMASK_DEFINE_SHARD(denied, slice->base, slice->nr_cids);
+
+				scx_cmask_copy(denied, slice);
+				scx_cmask_andnot(denied, granted_cids);
+				scx_cmask_ref_or(&denied_ref, denied);
+			}
+		}
+	}
+	return any_denied ? -EPERM : 0;
+}
+
+/**
+ * scx_bpf_sub_revoke - Revoke @caps on @cmask__ign's cids from @child
+ * @cgroup_id: cgroup id of the direct child sub-sched
+ * @caps: bitmask of SCX_CAP_* to revoke
+ * @cmask__ign: cid cmask to revoke @caps on (arena pointer)
+ * @aux: implicit BPF argument
+ *
+ * Clear @caps bits on @cmask__ign from the child named by @cgroup_id and all
+ * its descendants. The origin parent's pshard lock is held across the subtree
+ * walk so a concurrent grant from the origin parent observes the revoked
+ * state.
+ */
+__bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
+				    const struct scx_cmask *cmask__ign,
+				    const struct bpf_prog_aux *aux)
+{
+	struct scx_cmask_ref ref;
+	struct scx_sched *parent, *child, *pos;
+	s32 si, ret;
+
+	guard(irqsave)();
+
+	if (sub_cap_preamble(cgroup_id, caps, aux, &parent, &child))
+		return;
+
+	ret = scx_cmask_ref_init(parent, cmask__ign, &ref);
+	if (ret) {
+		scx_error(parent, "invalid cmask (%d)", ret);
+		return;
+	}
+
+	/* per-shard, walk child's subtree and clear @caps */
+	for (si = ref.shard_first; si < ref.shard_end; si++) {
+		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
+
+		scx_cmask_ref_shard(&ref, si, slice);
+		if (scx_cmask_empty(slice))
+			continue;
+
+		/*
+		 * Pre-order with subtree skip: a descendant that cleared
+		 * nothing means no descendant of it can hold @caps on these
+		 * cids either.
+		 */
+		guard(raw_spinlock)(&parent->pshard[si]->lock);
+		pos = scx_next_descendant_pre(NULL, child);
+		while (pos) {
+			struct scx_pshard *ps = pos->pshard[si];
+			u64 revoked_caps = 0;
+			u32 cap_bit;
+
+			scoped_guard (raw_spinlock_nested, &ps->lock) {
+				scx_for_each_cap_bit(cap_bit, caps) {
+					struct scx_cmask *cm = &ps->caps[cap_bit].cmask;
+
+					if (!scx_cmask_intersects(cm, slice))
+						continue;
+					scx_cmask_andnot(cm, slice);
+					revoked_caps |= BIT_U64(cap_bit);
+				}
+			}
+
+			if (revoked_caps)
+				pos = scx_next_descendant_pre(pos, child);
+			else
+				pos = scx_skip_subtree_pre(pos, child);
+		}
+	}
+}
+
+/**
+ * scx_bpf_sub_caps - Read self's or a direct child's cap cmasks
+ * @cgroup_id: 0 for self, or a direct child's cgroup id
+ * @caps: one or more SCX_CAP_* bits
+ * @out__ign: arena cmask to receive the union of @caps within its range
+ * @aux: implicit BPF argument
+ *
+ * Read the cap cmasks granted on each cid for self (@cgroup_id 0) or a direct
+ * child - the literal granted set. A sched can read only itself or a direct
+ * child.
+ *
+ * Return 0, -ENODEV if @cgroup_id names no direct child, or -EINVAL on bad
+ * inputs.
+ */
+__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out__ign,
+				 const struct bpf_prog_aux *aux)
+{
+	struct scx_cmask_ref ref;
+	struct scx_sched *sch, *target;
+	s32 si, ret;
+
+	guard(irqsave)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	if (!scx_is_cid_type()) {
+		scx_error(sch, "sub-cap kfuncs require a cid-form scheduler");
+		return -EOPNOTSUPP;
+	}
+
+	if (unlikely(caps & ~__SCX_CAP_ALL)) {
+		scx_error(sch, "invalid caps 0x%llx", caps);
+		return -EINVAL;
+	}
+
+	/* @cgroup_id 0 reads self, otherwise a direct child */
+	if (cgroup_id) {
+		target = scx_find_sub_sched(cgroup_id);
+		if (unlikely(!target))
+			return -ENODEV;
+		if (unlikely(scx_parent(target) != sch)) {
+			scx_error(sch, "%s: sub-%llu is not a direct child",
+				  sch->cgrp_path, cgroup_id);
+			return -EINVAL;
+		}
+	} else {
+		target = sch;
+	}
+
+	/*
+	 * The target's caps storage may not be set up yet (e.g. a self-read
+	 * during ops.init_cids()).
+	 */
+	if (unlikely(!target->pshard)) {
+		scx_error(sch, "scx_bpf_sub_caps() called before caps storage is initialized");
+		return -ENODEV;
+	}
+
+	ret = scx_cmask_ref_init(sch, out__ign, &ref);
+	if (ret) {
+		scx_error(sch, "invalid out (%d)", ret);
+		return ret;
+	}
+
+	for (si = ref.shard_first; si < ref.shard_end; si++) {
+		const struct scx_cid_shard *shard = &scx_cid_shard_ranges[si];
+		SCX_CMASK_DEFINE_SHARD(local_out, shard->base_cid, shard->nr_cids);
+		u32 cap_bit;
+
+		scx_for_each_cap_bit(cap_bit, caps)
+			scx_cmask_or(local_out, &target->pshard[si]->caps[cap_bit].cmask);
+		scx_cmask_ref_copy(&ref, local_out);
+	}
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 3d5ad9c36d64..3a913cc56422 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -27,6 +27,7 @@ void scx_sub_enable_workfn(struct kthread_work *work);
 bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
 void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
+void scx_init_root_caps(struct scx_sched *sch);
 
 #else	/* CONFIG_EXT_SUB_SCHED */
 
@@ -39,6 +40,7 @@ static inline void drain_descendants(struct scx_sched *sch) { }
 static inline void scx_sub_disable(struct scx_sched *sch) { }
 static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
+static inline void scx_init_root_caps(struct scx_sched *sch) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e7b3ba491c5e..09c21602b2ed 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -114,6 +114,12 @@ u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
 u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
 void scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
 
+/* sub-scheduler cap control, scx_bpf_sub_caps() cgroup_id 0 == self */
+s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps, const struct scx_cmask *cmask,
+		      struct scx_cmask *denied) __ksym __weak;
+void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps, const struct scx_cmask *cmask) __ksym __weak;
+s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cmask *out) __ksym __weak;
+
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
  * within bpf_for_each() loops.
-- 
2.54.0

