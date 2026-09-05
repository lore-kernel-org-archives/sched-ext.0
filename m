Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D836402A;
	Sat,  5 Sep 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624612; cv=none; b=qSBNi2bGmSTYHIl2xU5GCMDzGa6LkordOdf16XY1PpHxoI3vIx9rgJ9tf0GZ6w4CzRa6mfh5wmK+unPSnFbMIdyg2c+PiDwgjO627R4HrKk8FWshGvSb6Ou1ZWnnZBIp3MoF+9YKdf6GWxbXX1I5LdYMxnHqbb++3UxSZsoiXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624612; c=relaxed/simple;
	bh=WUeBvwsJUvmhBAJV5/UqnCj+gr/jldNZC+UvMZccEGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jymo1hUemX39OklCXDQyp7JNb1/NDLbsrJv5c8gvYCJist0airp1IZXHuJ+WJgCoPv2D9x1KLAo66AkN6tzor2DM5rlaNOzVOIyv3mYUlfGMKauQA3hQpLPP+/NA21ZJ4QUWyb52iicKMpom13CnH8e10b9PdfcYPCCtt4qncOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JylQ84CC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JylQ84CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C21F00AC4;
	Sat,  5 Sep 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624603;
	bh=8OoYtIardGs2l+aJ5vqdQjPnkqV/DTUcfcQ6gSJDn/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JylQ84CCZmWtWjKkv336P5OdfZXcprZkPu0KaUXWtMBxGtcgvRCf9CVtbD5Zxozr5
	 XlM9FCxM4YuAkmVD6SzrWXsMvbpeBHxpablhYfzE1lxnh9GW4DJDfiSRBcf6/maYBb
	 JNsiRfiQiJ5/otQRWDNil+kgBhTqfJJ+1+IeqPS6aImOmZP4CHzN2z5KKazSVbZPR1
	 Xr2qpmHczgej9bUy8LU12D9j9c/ZbOE6Nghcvg0Kt1DO3roIh4vNc50PLLD4cWo84B
	 d/TI6rqh2bV2uHTkxwx/x9mV0fYeKA/Cb5SF4NMHano1GT2TcjsArDvAwT9AspqTTX
	 6slGxTOROoHZw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes 4/4] sched_ext: scx_qmap: Place only on cids whose caps are in effect
Date: Sat,  5 Sep 2026 06:09:58 -1000
Message-ID: <20260905160958.1565156-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qmap decides placements from self_cids, which redistribute() derives from
the caps view at ops.sub_caps_updated() time. That view runs ahead of the
cpus: a granted cid can be in self_cids before its cpu has reported the caps
in effect through ops.sub_ecaps_updated(). ops.update_idle() only comes once
BASE is in effect, so the idle-gated placements reach such a cid only
through an idle bit left over from an earlier hold. The highpri scan has no
gate at all:

  parent                    cpu Y, qmap               cpu X
  grants ENQ on X to qmap
                            sub_caps_updated() adds X
                            to self_cids
                            highpri scan moves a task
                            to X with PREEMPT
                                                      caps not in effect,
                                                      move denied, task
                                                      bounced with REENQ_CAP
                                                      reject drain, enqueue
                            the scan moves it to X
                            again
                                                      denied again
                                                      dispatch syncs ecaps,
                                                      sub_ecaps_updated(X)

Every highpri move to X in that window is denied and bounced. The two
callbacks are meant to split the roles: ops.sub_caps_updated() tracks what
the node holds and drives what it delegates to its children, while
ops.sub_ecaps_updated() says whether a task can run on a cpu now. qmap used
the first for both. Track the caps in effect from ops.sub_ecaps_updated() as
avail_cids and place only on self_cids & avail_cids, so that self_cids stays
the delegation split and avail_cids gates the placement.

The stranded tests keep self_cids, as they ask whether the split gives the
task anywhere at all. A highpri task whose self_cids lack caps in effect
waits for them instead of being moved and bounced.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 83 ++++++++++++++++++++++++++--------
 tools/sched_ext/scx_qmap.h     |  3 ++
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index e4e51303bd29..062bb22ee65c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -24,6 +24,9 @@
  *            time-share that stays self-local.
  *   self   - The excl cpus the node kept for itself, plus all of held_shared.
  *   owner  - Who holds a cid - a child slot, CID_SELF, or CID_NONE.
+ *   avail  - Cpus whose caps are in effect, per ops.sub_ecaps_updated().
+ *   usable - self AND avail. Placement decisions use this: self is the
+ *            delegation split and can run ahead of what the cpus honor.
  *
  * The scheduler splits its held-excl cpus among self and the children in
  * proportion to each node's cpu.weight, handing each the floor of its share as
@@ -208,8 +211,8 @@ static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
 }
 
 /*
- * Try prev_cid, then scan cpus_allowed AND idle_cids AND self_cids round-robin
- * from prev_cid + 1. Atomic claim retries on race; bounded by
+ * Try prev_cid, then scan cpus_allowed AND idle_cids AND usable_cids
+ * round-robin from prev_cid + 1. Atomic claim retries on race; bounded by
  * IDLE_PICK_RETRIES to keep the verifier's insn budget in check.
  */
 #define IDLE_PICK_RETRIES	16
@@ -221,7 +224,7 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 	s32 cid;
 	u32 i;
 
-	if (cmask_test(prev_cid, &qa.self_cids.mask) &&
+	if (cmask_test(prev_cid, &qa.usable_cids.mask) &&
 	    cmask_test_and_clear(prev_cid, &qa.idle_cids.mask))
 		return prev_cid;
 
@@ -229,7 +232,7 @@ static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 	bpf_for(i, 0, IDLE_PICK_RETRIES) {
 		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
 					       &qa.idle_cids.mask,
-					       &qa.self_cids.mask, cid + 1);
+					       &qa.usable_cids.mask, cid + 1);
 		barrier_var(cid);
 		if (cid >= nr_cids)
 			return -1;
@@ -542,7 +545,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
 		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
 					       &qa.idle_cids.mask,
-					       &qa.self_cids.mask, 0);
+					       &qa.usable_cids.mask, 0);
 		if (cid < scx_bpf_nr_cids())
 			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
 		return;
@@ -646,18 +649,23 @@ static bool scan_shared_dsq(bool from_timer)
 		if (!(taskc = lookup_task_ctx(p)))
 			return false;
 
-		/* only run highpri tasks on cids this node holds, not delegated ones */
+		/* only run highpri tasks on cids this node can use right now */
 		if (cmask_test(this_cid, &taskc->cpus_allowed) &&
-		    cmask_test(this_cid, &qa.self_cids.mask))
+		    cmask_test(this_cid, &qa.usable_cids.mask))
 			cid = this_cid;
 		else
 			cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
-						      &qa.self_cids.mask,
+						      &qa.usable_cids.mask,
 						      this_cid + 1);
 		if (cid >= nr_cids) {
-			/* stranded after the cull - rescue it from here */
-			s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+			s32 c;
+
+			/* self cids lack caps in effect yet, leave it queued */
+			if (cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask))
+				continue;
 
+			/* stranded after the cull - rescue it from here */
+			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
 			if (c >= 0 && c < nr_cids) {
 				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
 				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
@@ -1115,7 +1123,7 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool idle)
 	/*
 	 * The kernel delivers update_idle() for every cid this node holds
 	 * SCX_CAP_BASE on. Track every cid's idle state regardless of
-	 * delegation: the direct-dispatch pick masks idle_cids with self_cids
+	 * delegation: the direct-dispatch pick masks idle_cids with usable_cids
 	 * at selection, so a cid already idle when it returns to self needs no
 	 * reseed here.
 	 */
@@ -1539,6 +1547,19 @@ static __noinline void account_alloc(void)
 	}
 }
 
+/*
+ * usable_cids = self_cids & avail_cids. The inputs have separate writers,
+ * apply_partition() and qmap_sub_ecaps_updated(), so the result is rebuilt in
+ * full under the partition guard, in scratch first so that readers never see
+ * self_cids alone.
+ */
+static void refresh_usable(void)
+{
+	cmask_copy(&qa.usable_scratch.mask, &qa.self_cids.mask);
+	cmask_and(&qa.usable_scratch.mask, &qa.avail_cids.mask);
+	cmask_copy(&qa.usable_cids.mask, &qa.usable_scratch.mask);
+}
+
 /*
  * apply_partition - execute the plan compute_partition() built
  *
@@ -1561,6 +1582,7 @@ __noinline void apply_partition(void)
 	/* no excl cpu: run own tasks on the held shares, evict children */
 	if (!qa.part.nr_excl) {
 		cmask_copy(&qa.self_cids.mask, &qa.held_shared.mask);
+		refresh_usable();
 		bpf_for(i, 0, MAX_SUB_SCHEDS)
 			if (qa.sub_sched_ctxs[i].cgroup_id)
 				scx_bpf_sub_kill(qa.sub_sched_ctxs[i].cgroup_id,
@@ -1598,6 +1620,7 @@ __noinline void apply_partition(void)
 		else if (o == CID_SELF)
 			cmask_set(cid, &qa.self_cids.mask);
 	}
+	refresh_usable();
 
 	/*
 	 * Apply each child's exclusive cids as a delta against its previous
@@ -1839,8 +1862,11 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	cmask_init(&qa.rr_cids.mask, 0, nr_cids);
 	cmask_init(&qa.prev_rr_cids.mask, 0, nr_cids);
 	cmask_init(&qa.self_cids.mask, 0, nr_cids);
+	cmask_init(&qa.avail_cids.mask, 0, nr_cids);
+	cmask_init(&qa.usable_cids.mask, 0, nr_cids);
 	cmask_init(&qa.to_revoke_cids.mask, 0, nr_cids);
 	cmask_init(&qa.to_grant_cids.mask, 0, nr_cids);
+	cmask_init(&qa.usable_scratch.mask, 0, nr_cids);
 	cmask_init(&qa.held_excl.mask, 0, nr_cids);
 	cmask_init(&qa.held_shared.mask, 0, nr_cids);
 
@@ -1854,14 +1880,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	}
 
 	/*
-	 * The root starts holding every cid. qmap_sub_ecaps_updated() maintains
-	 * per-cid shared state as effective caps settle, and redistribute()
-	 * rebuilds owner and self from held caps. A non-root node starts with
-	 * nothing.
+	 * The root starts holding every cid and gets no ecaps notifications, so
+	 * its avail set is fixed here. qmap_sub_ecaps_updated() maintains the
+	 * per-cid state as effective caps settle, and redistribute() rebuilds
+	 * owner and self from held caps. A non-root node starts with nothing.
 	 */
 	bpf_for(i, 0, nr_cids) {
 		if (!sub_cgroup_id) {
 			cmask_set(i, &qa.self_cids.mask);
+			cmask_set(i, &qa.avail_cids.mask);
+			cmask_set(i, &qa.usable_cids.mask);
 			qa.part.cid_owner[i] = CID_SELF;
 		} else {
 			qa.part.cid_owner[i] = CID_NONE;
@@ -2002,12 +2030,31 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updated, s32 cid, u64 before, u64 after)
 {
 	/*
 	 * Effective caps updated. Track which cids hold shared caps so a self
-	 * task placed there enqueues IMMED.
+	 * task placed there enqueues IMMED, and which cids have ENQ_IMMED in
+	 * effect at all (avail, see the header comment).
 	 */
-	if (after & SCX_CAP_ENQ_IMMED)
+	if (after & SCX_CAP_ENQ_IMMED) {
 		qa.cid_shared[cid] = (after & SCX_CAP_ENQ) ? 0 : 1;
-	else
+		cmask_set(cid, &qa.avail_cids.mask);
+	} else {
 		qa.cid_shared[cid] = 0;
+		cmask_clear(cid, &qa.avail_cids.mask);
+	}
+
+	/*
+	 * When another runner holds the partition guard, set part_pending:
+	 * redistribute() drains it before releasing and rr_advance() checks it
+	 * after, so the deferred refresh lands by the next rr tick. A
+	 * repartition that lost the guard to us runs here.
+	 */
+	if (part_try_start()) {
+		refresh_usable();
+		part_end();
+		if (__sync_fetch_and_or(&part_pending, 0))
+			redistribute();
+	} else {
+		__sync_fetch_and_or(&part_pending, 1);
+	}
 }
 
 SCX_OPS_CID_DEFINE(qmap_ops,
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c78d61806b39..e95fffcf7b23 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -165,12 +165,15 @@ struct qmap_arena {
 
 	/* bpf-internal cmasks (embedded, see struct qmap_cmask) */
 	struct qmap_cmask self_cids;	/* cids this node runs its own tasks on */
+	struct qmap_cmask avail_cids;	/* cids with caps in effect on the cpu */
+	struct qmap_cmask usable_cids;	/* self_cids & avail_cids, placeable right now */
 	struct qmap_cmask idle_cids;	/* idle state of all cids regardless of delegation */
 	struct qmap_cmask rr_cids;	/* the shared pool, as a mask for grant/revoke */
 
 	/* scratch cmasks */
 	struct qmap_cmask to_revoke_cids; /* delta cids to revoke */
 	struct qmap_cmask to_grant_cids; /* delta cids to grant */
+	struct qmap_cmask usable_scratch; /* refresh_usable() build area */
 	struct qmap_cmask prev_rr_cids; /* previous shared pool, to clear stale grants */
 	struct qmap_cmask held_excl;	/* cids held excl (ENQ): delegatable */
 	struct qmap_cmask held_shared;	/* cids held shared (ENQ_IMMED only): self-local */
-- 
2.55.0

