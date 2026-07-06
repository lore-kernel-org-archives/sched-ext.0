Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613B37D114;
	Mon,  6 Jul 2026 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302082; cv=none; b=D2uJvYgmZKtrxrPPPAPCNTf/e7yDA6u+snCa1+2IX9Mbq8uunCd7PeM0G2IXzSxcUyfpKcLxfMkqDdTPPMJYA9PH05mwUpdiIhK0/WD8k6iajP45vgpxSx1S1Dsh3VrvnAb/D7U9G8gxsSqKKgyFqZ3VIFbZypzHuBdKBQnz/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302082; c=relaxed/simple;
	bh=X4noOx+WrupANaxs4dG3DH8V7YSpx0mnEhhWr48eans=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXMprLsgv1BEAhKL6CpgTmiVnDvAjw2tKoyKMpWbnW8Gezz8kGIm0uDESKsH7vofrD+TFX/F6zIOBzKeXSREUWUjt9f6VaMZ9GVbQKcEUFgEPrs//IfdFMxCvXGN13js8t7tMzRk0ga4qOE1M70/A1kzbgmEgK9LesqKeXLpbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH7vmTnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH7vmTnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2681F00A3D;
	Mon,  6 Jul 2026 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302079;
	bh=ytuF44/A5Wb14ySmvYu80Z25vwDE8DZBFZUyoslFK0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UH7vmTncQh197ft/nB+XrdGTYy8FV/vyjMOLvKIyQxQ6dzVXfPp4CZd/tPg1UPBaG
	 iUUac9gDBKTnIZwjZzfGHka4MM9yGfNUvOWbzrkBxIWGyO6QXvMzR/LoMk3V8EWHYf
	 BiVUFIrrvl/butz3iYTEiMRGJ8lwSQhCMeeCv2ohvjPJcW3TwgYJ1PnKujog9XViar
	 q6DPsBLzK91Z5GCXZR8L+4nGeTBgjk5QsY9iWVQTAWfbuHrRZaUF+8CDPuVOjf6K7B
	 Dq6+QPCgP4KQUUHyXZcmM6gdAqyI8Euvz1uB4N0Gt7B+u+5HUqi03zs1dAVLqp6Lrg
	 oTXiduoMlvwMQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 20/36] sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
Date: Sun,  5 Jul 2026 15:40:42 -1000
Message-ID: <20260706014058.439853-21-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up ops_cid.sub_caps_updated() to notify sub-scheds of cap changes.

Three constraints shape the design:

  1. Static memory. Deliveries use a fixed-size buffer, both for runtime
     efficiency and so notifications can't be lost under memory pressure.

  2. High-frequency updates. Grant/revoke can mutate caps in bursts, and the
     notifier path must absorb that without amplifying it.

  3. Recursive grant/revoke from the callback. A child receiving a
     notification can call grant/revoke on its own children, which can
     cascade recursively down its subtree.

(1) and (2) lead to coalescing into a fixed payload. Each delivery carries a
single (cmask, caps) pair covering every change since the previous one.
Direction (set vs cleared) isn't encoded as it doesn't fit in the fixed-size
summary. The callback queries scx_bpf_sub_caps() for current state. Only one
delivery is in flight per shard. Further changes fold into the same buffer
and ship as the next callback, so a shard's callbacks fire in order.

(3) leads to deferred delivery. Events accumulate during grant/revoke and
are delivered after the shard lock is released.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |   8 +-
 kernel/sched/ext/internal.h |  71 ++++++++++++++++
 kernel/sched/ext/sub.c      | 162 ++++++++++++++++++++++++++++++++++--
 3 files changed, 234 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b00acbc3e16a..1fa656e2bbb4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7464,11 +7464,13 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 /*
  * cid-form cfi stubs. Stubs whose signatures match the cpu-form (param types
- * identical, only param names differ across structs) are reused. Only
- * set_cmask needs a fresh stub since the second argument type differs.
+ * identical, only param names differ across structs) are reused. Some need
+ * fresh stubs, set_cmask due to an argument type difference and the sub-sched
+ * notifiers because no cpu-form stub exists to reuse.
  */
 static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
 					 const struct scx_cmask *cmask) {}
+static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask, u64 caps) {}
 
 static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.select_cid		= sched_ext_ops__select_cpu,
@@ -7501,6 +7503,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 #endif
 	.sub_attach		= sched_ext_ops__sub_attach,
 	.sub_detach		= sched_ext_ops__sub_detach,
+	.sub_caps_updated	= sched_ext_ops__sub_caps_updated,
 	.cid_online		= sched_ext_ops__cpu_online,
 	.cid_offline		= sched_ext_ops__cpu_offline,
 	.init_cids		= sched_ext_ops__init_cids,
@@ -9959,6 +9962,7 @@ static int __init scx_init(void)
 	CID_OFFSET_MATCH(dump_task, dump_task);
 	CID_OFFSET_MATCH(sub_attach, sub_attach);
 	CID_OFFSET_MATCH(sub_detach, sub_detach);
+	CID_OFFSET_MATCH(sub_caps_updated, sub_caps_updated);
 	CID_OFFSET_MATCH(init_cids, init_cids);
 	CID_OFFSET_MATCH(init, init);
 	CID_OFFSET_MATCH(exit, exit);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 53fb3954d6ed..4cf110a3b738 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -757,6 +757,25 @@ struct sched_ext_ops {
 	 */
 	void (*sub_detach)(struct scx_sub_detach_args *args);
 
+	/**
+	 * @sub_caps_updated: Caps on this sub-sched's shard changed
+	 * @cmask: cids whose caps changed (cmask->base identifies the shard)
+	 * @caps: SCX_CAP_* that changed
+	 *
+	 * Invoked after grant or revoke modifies caps on a shard. There can be
+	 * only one in-flight invocation per shard. @cmask and @caps coalesce
+	 * all changes since the last delivery. Direction (set vs cleared) isn't
+	 * encoded. Query current state with scx_bpf_sub_caps().
+	 *
+	 * Delivered asynchronously after the change is recorded, and may run
+	 * before it takes effect on any given cpu. Use it to track which caps
+	 * the sub-sched holds and propagate to its own children, not to decide
+	 * if a task can run on a cpu now.
+	 *
+	 * May call scx_bpf_sub_grant() / scx_bpf_sub_revoke() on children.
+	 */
+	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -977,6 +996,7 @@ struct sched_ext_ops_cid {
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 	s32 (*sub_attach)(struct scx_sub_attach_args *args);
 	void (*sub_detach)(struct scx_sub_detach_args *args);
+	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
 	void (*cid_online)(s32 cid);
 	void (*cid_offline)(s32 cid);
 	s32 (*init_cids)(void);
@@ -1224,9 +1244,51 @@ enum scx_cap_flags {
 	     __caps && ((cap_bit) = __ffs64(__caps), true);		\
 	     __caps &= __caps - 1)
 
+/*
+ * Sub-cap update notifier.
+ *
+ * ops_cid.sub_caps_updated() notifies sub-scheds when their cap state changes
+ * so they can refresh internal state without polling scx_bpf_sub_caps() per
+ * enqueue.
+ *
+ * Three constraints shape the design:
+ *
+ *   1. Static memory. Deliveries use a fixed-size buffer, both for runtime
+ *      efficiency and so notifications can't be lost under memory pressure.
+ *
+ *   2. High-frequency updates. Grant/revoke can mutate caps in bursts, and the
+ *      notifier path must absorb that without amplifying it.
+ *
+ *   3. Recursive grant/revoke from the callback. A child receiving a
+ *      notification can call grant/revoke on its own children, which can
+ *      cascade recursively down its subtree.
+ *
+ * (1) and (2) lead to coalescing into a fixed payload. Each delivery carries a
+ * single (cmask, caps) pair covering every change since the previous one.
+ * Direction (set vs cleared) isn't encoded as it doesn't fit in the fixed-size
+ * summary. The callback queries scx_bpf_sub_caps() for current state. Only one
+ * delivery is in flight per shard. Further changes fold into the same buffer
+ * and ship as the next callback, so a shard's callbacks fire in order.
+ *
+ * (3) leads to deferred delivery. Events accumulate during grant/revoke and are
+ * delivered after the shard lock is released.
+ */
+struct scx_caps_updated {
+	raw_spinlock_t		lock;
+	u64			caps;
+	struct scx_cmask	*cmask_arena_out;
+	struct list_head	node_in_flight;
+	/* Kernel-side accumulator. Access as &cu->cmask. */
+	TRAILING_OVERLAP(struct scx_cmask, cmask, bits,
+			 u64 _bits[SCX_CMASK_NR_WORDS(SCX_CID_SHARD_MAX_CPUS)];
+	);
+};
+
 struct scx_pshard {
 	raw_spinlock_t		lock;		/* serializes caps */
 	struct scx_sched	*sch;		/* backpointer */
+	struct scx_caps_updated	caps_updated;
+
 	/*
 	 * Per-cap cmask, inline via TRAILING_OVERLAP so cmask.bits[] overlaps
 	 * the trailing _bits[] storage. Access as &caps[i].cmask.
@@ -1234,6 +1296,15 @@ struct scx_pshard {
 	TRAILING_OVERLAP(struct scx_cmask, cmask, bits,
 			 u64 _bits[SCX_CMASK_NR_WORDS(SCX_CID_SHARD_MAX_CPUS)];
 	) caps[__SCX_NR_CAPS];
+
+	/*
+	 * Shard geometry captured at alloc. cmask_arena_out's own header is
+	 * bpf-writable and the live shard range can change before the
+	 * rcu-deferred free, so re-init and size cmask_arena_out from these
+	 * trusted copies instead.
+	 */
+	u32			base;
+	u32			nr_cids;
 };
 #endif
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 36803b6df631..5bd3b8a1da6b 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -106,6 +106,15 @@ void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
 
 static void free_pshard(struct scx_pshard *pshard)
 {
+	struct scx_caps_updated *cu;
+
+	if (!pshard)
+		return;
+	cu = &pshard->caps_updated;
+	if (cu->cmask_arena_out)
+		scx_arena_free(pshard->sch, cu->cmask_arena_out,
+			       struct_size_t(struct scx_cmask, bits,
+					     SCX_CMASK_NR_WORDS(pshard->nr_cids)));
 	kfree(pshard);
 }
 
@@ -123,7 +132,10 @@ void scx_free_pshards(struct scx_sched *sch)
 static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32 node)
 {
 	const struct scx_cid_shard *shard = &scx_cid_shard_ranges[shard_idx];
+	size_t cmask_size = struct_size_t(struct scx_cmask, bits,
+					  SCX_CMASK_NR_WORDS(shard->nr_cids));
 	struct scx_pshard *pshard;
+	struct scx_caps_updated *cu;
 	s32 i;
 
 	pshard = kzalloc_node(sizeof(*pshard), GFP_KERNEL, node);
@@ -132,10 +144,25 @@ static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32
 
 	raw_spin_lock_init(&pshard->lock);
 	pshard->sch = sch;
+	pshard->base = shard->base_cid;
+	pshard->nr_cids = shard->nr_cids;
 
 	for (i = 0; i < __SCX_NR_CAPS; i++)
 		scx_cmask_init(&pshard->caps[i].cmask, shard->base_cid, shard->nr_cids);
 
+	cu = &pshard->caps_updated;
+	raw_spin_lock_init(&cu->lock);
+	INIT_LIST_HEAD(&cu->node_in_flight);
+	__scx_cmask_init(&cu->cmask, shard->base_cid, shard->nr_cids, SCX_CID_SHARD_MAX_CPUS);
+
+	cu->cmask_arena_out = scx_arena_alloc(sch, cmask_size);
+	if (!cu->cmask_arena_out) {
+		free_pshard(pshard);
+		return NULL;
+	}
+
+	scx_cmask_init(cu->cmask_arena_out, shard->base_cid, shard->nr_cids);
+
 	return pshard;
 }
 
@@ -180,6 +207,86 @@ void scx_init_root_caps(struct scx_sched *sch)
 	}
 }
 
+/* record a caps change, see struct scx_caps_updated */
+static void caps_updated_record(struct scx_pshard *ps, const struct scx_cmask *cids, u64 caps,
+				struct list_head *to_deliver)
+{
+	struct scx_caps_updated *cu = &ps->caps_updated;
+
+	guard(raw_spinlock)(&cu->lock);
+	scx_cmask_or(&cu->cmask, cids);
+	cu->caps |= caps;
+	if (list_empty(&cu->node_in_flight))
+		list_add_tail(&cu->node_in_flight, to_deliver);
+}
+
+/* deliver queued caps_updated callbacks, see struct scx_caps_updated */
+static void caps_updated_deliver(struct list_head *to_deliver)
+{
+	struct scx_caps_updated *cu, *tmp;
+
+	list_for_each_entry_safe(cu, tmp, to_deliver, node_in_flight) {
+		struct scx_pshard *ps = container_of(cu, struct scx_pshard, caps_updated);
+		struct scx_sched *sch = ps->sch;
+
+		while (true) {
+			u64 caps = 0;
+
+			/*
+			 * During enable, has_op is set after ops.sub_attach(),
+			 * so !has_op means the op is absent or the sched isn't
+			 * live yet - e.g. caps grant from ops.sub_attach().
+			 * Either way don't consume - leave for
+			 * scx_sub_seed_caps() to deliver once live.
+			 */
+			scoped_guard (raw_spinlock, &cu->lock) {
+				if (cu->caps && SCX_HAS_OP(sch, sub_caps_updated) &&
+				    likely(!READ_ONCE(sch->aborting))) {
+					caps = cu->caps;
+					scx_cmask_init(cu->cmask_arena_out,
+						       ps->base, ps->nr_cids);
+					scx_cmask_copy(cu->cmask_arena_out, &cu->cmask);
+					scx_cmask_clear(&cu->cmask);
+					cu->caps = 0;
+				} else {
+					list_del_init(&cu->node_in_flight);
+				}
+			}
+			if (!caps)
+				break;
+
+			/* caps != 0 only when deliverable (has_op, above) */
+			SCX_CALL_OP(sch, sub_caps_updated, NULL,
+				    scx_kaddr_to_arena(sch, cu->cmask_arena_out),
+				    caps);
+		}
+	}
+}
+
+/*
+ * Deliver caps owed to @sch that couldn't be delivered earlier (e.g. a grant
+ * taken during its sub_attach(), before has_op was set). Called once @sch is
+ * enabled.
+ */
+static void scx_sub_seed_caps(struct scx_sched *sch)
+{
+	LIST_HEAD(to_deliver);
+	s32 si;
+
+	guard(irqsave)();
+
+	for (si = 0; si < sch->nr_pshards; si++) {
+		struct scx_pshard *ps = sch->pshard[si];
+		struct scx_caps_updated *cu = &ps->caps_updated;
+
+		scoped_guard (raw_spinlock, &cu->lock) {
+			if (cu->caps && list_empty(&cu->node_in_flight))
+				list_add_tail(&cu->node_in_flight, &to_deliver);
+		}
+	}
+	caps_updated_deliver(&to_deliver);
+}
+
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
 void drain_descendants(struct scx_sched *sch)
@@ -654,6 +761,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 
 	scx_bypass(sch, false);
 
+	/* @sch is enabled; deliver any caps owed since its sub_attach() */
+	scx_sub_seed_caps(sch);
+
 	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
 	ret = 0;
@@ -852,6 +962,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 	struct scx_cmask_ref ref, denied_ref;
 	struct scx_sched *parent, *child;
 	bool any_denied = false;
+	LIST_HEAD(to_deliver);
 	s32 si, ret;
 
 	guard(irqsave)();
@@ -879,6 +990,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
 		struct scx_pshard *pps = parent->pshard[si];
 		struct scx_pshard *cps = child->pshard[si];
+		u64 granted_caps = 0;
 		u32 cap_bit;
 
 		scx_cmask_ref_shard(&ref, si, slice);
@@ -886,6 +998,9 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 			continue;
 
 		SCX_CMASK_DEFINE_SHARD(granted_cids, slice->base, slice->nr_cids);
+		SCX_CMASK_DEFINE_SHARD(changed_cids, slice->base, slice->nr_cids);
+		SCX_CMASK_DEFINE_SHARD(delta, slice->base, slice->nr_cids);
+
 		scx_cmask_copy(granted_cids, slice);
 
 		scoped_guard (raw_spinlock, &pps->lock) {
@@ -898,9 +1013,26 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 			scx_for_each_cap_bit(cap_bit, caps)
 				scx_cmask_and(granted_cids, &pps->caps[cap_bit].cmask);
 
-			/* fold granted_cids into the child per requested cap */
-			scx_for_each_cap_bit(cap_bit, caps)
-				scx_cmask_or(&cps->caps[cap_bit].cmask, granted_cids);
+			/*
+			 * For each requested cap, fold the newly-set cids into
+			 * the child and accumulate the delta.
+			 */
+			scx_for_each_cap_bit(cap_bit, caps) {
+				struct scx_cmask *ccm = &cps->caps[cap_bit].cmask;
+
+				scx_cmask_copy(delta, granted_cids);
+				scx_cmask_andnot(delta, ccm);
+				if (scx_cmask_empty(delta))
+					continue;
+
+				scx_cmask_or(ccm, delta);
+				scx_cmask_or(changed_cids, delta);
+				granted_caps |= BIT_U64(cap_bit);
+			}
+
+			if (granted_caps)
+				caps_updated_record(cps, changed_cids, granted_caps,
+						    &to_deliver);
 		}
 
 		/* record cids that didn't make it through into @denied_out */
@@ -915,6 +1047,9 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 			}
 		}
 	}
+
+	caps_updated_deliver(&to_deliver);
+
 	return any_denied ? -EPERM : 0;
 }
 
@@ -936,6 +1071,7 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 {
 	struct scx_cmask_ref ref;
 	struct scx_sched *parent, *child, *pos;
+	LIST_HEAD(to_deliver);
 	s32 si, ret;
 
 	guard(irqsave)();
@@ -966,18 +1102,32 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 		pos = scx_next_descendant_pre(NULL, child);
 		while (pos) {
 			struct scx_pshard *ps = pos->pshard[si];
+			SCX_CMASK_DEFINE_SHARD(changed_cids, slice->base, slice->nr_cids);
+			SCX_CMASK_DEFINE_SHARD(delta, slice->base, slice->nr_cids);
 			u64 revoked_caps = 0;
 			u32 cap_bit;
 
 			scoped_guard (raw_spinlock_nested, &ps->lock) {
+				/*
+				 * For each cap, clear lost cids and accumulate
+				 * the per-cap diff for notification.
+				 */
 				scx_for_each_cap_bit(cap_bit, caps) {
 					struct scx_cmask *cm = &ps->caps[cap_bit].cmask;
 
-					if (!scx_cmask_intersects(cm, slice))
+					scx_cmask_copy(delta, cm);
+					scx_cmask_and(delta, slice);
+					if (scx_cmask_empty(delta))
 						continue;
-					scx_cmask_andnot(cm, slice);
+
+					scx_cmask_andnot(cm, delta);
+					scx_cmask_or(changed_cids, delta);
 					revoked_caps |= BIT_U64(cap_bit);
 				}
+
+				if (revoked_caps)
+					caps_updated_record(ps, changed_cids, revoked_caps,
+							    &to_deliver);
 			}
 
 			if (revoked_caps)
@@ -986,6 +1136,8 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 				pos = scx_skip_subtree_pre(pos, child);
 		}
 	}
+
+	caps_updated_deliver(&to_deliver);
 }
 
 /**
-- 
2.54.0

