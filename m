Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC3488222;
	Mon,  5 Oct 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222926; cv=none; b=Zbw/Nuyt8y3iX6asM8xmKZMiFAHDEqPIppQr4zsVL4al2TpFwlFTbXnwFoCDQbW778vwwlWaLtIk1zQOlgzNzj1uvyDC/ILobOM8ygNHtoN+0PYVrl25pI3pBWg/biK4r5TUnbog9CQJ5fx7UMfvyb12XuzuF7ZVPqrgMfC8Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222926; c=relaxed/simple;
	bh=Hlcvf/D2iH2mJnc4EiDOgW/MUX+Xyhu1IPOOKv57MYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ0dLWZSNPXR/imP1yl9NOtjBqzGMtNamiAPEJJeUut0Ptc3IeJVOp3G519CF5s8F77ccIxsuEQeu9cFHF7zw70KeWHADZm0SIvkoNQMbYiz3cMYzXFiwsdy8VAz5GjBxv12pVo+zd6myvD9ev1RMzhNZxYyTeS80xvGEfz25ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7yr3lSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7yr3lSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938981F00898;
	Mon,  5 Oct 2026 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222924;
	bh=WbN/e/4TdfYsXyMuJsOJLo3pmvFMn7Q1OfBGlFCkFkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7yr3lSmT85BX76LztFgdm/VwPnkBfGC7CygOBpgEn7pssQxEiVADIsr90SyWfQiK
	 VXyeEunlYcT2FloI7gUcV8eQgaA/ldTyXpbbDvxgkor6jr37RbOSRGFMbHSB6y3yxM
	 54HPFXJYxfjnaXU74WOB0TA8BY52NNRXw327vFftnlmdJS72DGXQbbpvetfZ9MyFQC
	 HljCzzpN56Kq7jbfv/ZBP4ceeR9pFUaDeAyQBnkPsKE4qQScTZlkDgpywsGGOryhwQ
	 qwAtppNJnRbP3qR6CxlU2eE+gguFhczXLN2YesRM6bfoHMC2EfYzqKCMO9Ea892CtQ
	 1Q3l3UN6A8Fgg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: scx_qmap: Show actual cid use per participant
Date: Mon,  5 Oct 2026 07:55:20 -1000
Message-ID: <20261005175520.2756986-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005175520.2756986-1-tj@kernel.org>
References: <20261005175520.2756986-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qmap's hier stats show how much cid-time the partition handed each
participant, not how much of it was used. Track the sched running on each
cid from ops.sub_cid_sched_updated() and charge the intervals to the
participant, then print the use next to the allocation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 87 ++++++++++++++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c     | 38 ++++++++++++---
 tools/sched_ext/scx_qmap.h     | 11 +++++
 3 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 3566e3e02e21..7f69394556b6 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -1782,13 +1782,90 @@ static void redistribute(void)
 }
 
 /*
- * Userspace pokes this (PROG_RUN) to bring alloc_ns[] current before reading
- * it for the stats display. Skipping when the partition guard is held is
- * fine - alloc_ts is untouched, so the elapsed time is charged next time.
+ * Owner id for a @sched value of ops.sub_cid_sched_updated(). A child is
+ * attached before its first task runs and its tasks are re-homed before it
+ * detaches, so a child's cgroup id always has its slot.
+ */
+static s32 cid_sched_owner(u64 sched)
+{
+	s32 i;
+
+	if (sched == SCX_CID_SCHED_NONE)
+		return CID_NONE;
+	if (sched == SCX_CID_SCHED_SELF)
+		return CID_SELF;
+	bpf_for(i, 0, MAX_SUB_SCHEDS)
+		if (qa.sub_sched_ctxs[i].cgroup_id == sched)
+			return i;
+	return CID_NONE;
+}
+
+/* used_ns[] is summed from every cpu, hence the atomic adds */
+static void cid_sched_charge(s32 cid, u64 now)
+{
+	s32 owner = qa.cid_sched[cid];
+	u64 delta = now - qa.cid_sched_since[cid];
+
+	if (owner >= 0 && owner < MAX_SUB_SCHEDS)
+		__sync_fetch_and_add(&qa.used_ns[owner], delta);
+	else if (owner == CID_SELF)
+		__sync_fetch_and_add(&qa.self_used_ns, delta);
+	qa.cid_sched_since[cid] = now;
+}
+
+void BPF_STRUCT_OPS(qmap_sub_cid_sched_updated, s32 cid, u64 sched)
+{
+	if (cid < 0 || cid >= SCX_QMAP_MAX_CPUS)
+		return;
+
+	cid_sched_charge(cid, bpf_ktime_get_ns());
+	qa.cid_sched[cid] = cid_sched_owner(sched);
+}
+
+/*
+ * Snapshot the used time for the stats display: the closed intervals plus the
+ * ones still open. The reads race the notifications on other cpus, so an
+ * interval closing in between can be missing from one snapshot or counted in
+ * two. The next snapshot evens it out and the display floors a negative
+ * difference at zero.
+ */
+static void snapshot_used(void)
+{
+	u64 now = bpf_ktime_get_ns();
+	s32 nr_cids = qa.nr_cids;
+	s32 cid, i;
+
+	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS)
+		return;
+
+	bpf_for(i, 0, MAX_SUB_SCHEDS)
+		qa.used_snap_ns[i] = qa.used_ns[i];
+	qa.self_used_snap_ns = qa.self_used_ns;
+
+	bpf_for(cid, 0, nr_cids) {
+		s32 owner = qa.cid_sched[cid];
+		u64 since = qa.cid_sched_since[cid];
+
+		/* restarted after @now by a notification on another cpu */
+		if (since > now)
+			continue;
+		if (owner >= 0 && owner < MAX_SUB_SCHEDS)
+			qa.used_snap_ns[owner] += now - since;
+		else if (owner == CID_SELF)
+			qa.self_used_snap_ns += now - since;
+	}
+}
+
+/*
+ * Userspace pokes this (PROG_RUN) to bring alloc_ns[] and the used snapshot
+ * current before reading them for the stats display. Skipping the alloc part
+ * when the partition guard is held is fine - alloc_ts is untouched, so the
+ * elapsed time is charged next time.
  */
 SEC("syscall")
 int flush_alloc(void *ctx)
 {
+	snapshot_used();
 	if (part_try_start()) {
 		account_alloc();
 		part_end();
@@ -1940,6 +2017,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	/* cache the cid count, trusted to be <= SCX_QMAP_MAX_CPUS hereafter */
 	qa.nr_cids = nr_cids;
 
+	bpf_for(i, 0, nr_cids)
+		qa.cid_sched[i] = CID_NONE;
+
 	/* cmasks are embedded in qa, so they only need initializing */
 	cmask_init(&qa.idle_cids.mask, 0, nr_cids);
 	cmask_init(&qa.rr_cids.mask, 0, nr_cids);
@@ -2151,6 +2231,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
 	       .sub_detach		= (void *)qmap_sub_detach,
 	       .sub_caps_updated	= (void *)qmap_sub_caps_updated,
 	       .sub_ecaps_updated	= (void *)qmap_sub_ecaps_updated,
+	       .sub_cid_sched_updated	= (void *)qmap_sub_cid_sched_updated,
 	       .init_cids		= (void *)qmap_init_cids,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 96e485c9e877..e83d5e2147dd 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -105,6 +105,8 @@ struct hier_prev {
 	u64 alloc_ns[MAX_SUB_SCHEDS];
 	u64 self_alloc_ns;
 	u64 alloc_window_ns;
+	u64 used_snap_ns[MAX_SUB_SCHEDS];
+	u64 self_used_snap_ns;
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
@@ -159,6 +161,18 @@ static void format_cid_ranges(struct qmap_arena *qa, s32 owner, char *buf, size_
 		strcpy(buf, "-");
 }
 
+/*
+ * Delta of a cumulative ns counter over the interval, as a fraction of the
+ * interval. The used snapshot can briefly run behind the previous one (see
+ * snapshot_used()), hence the floor.
+ */
+static double delta_ratio(u64 cur, u64 prev, double secs)
+{
+	s64 delta = cur - prev;
+
+	return secs > 0 && delta > 0 ? delta / (secs * 1e9) : 0.0;
+}
+
 /* partition summary + one row per sched: weight, cpus, dispatch rate, cids */
 static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cgid)
 {
@@ -207,15 +221,24 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
 
-	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
-	       "", "cgroup", "w", "alloc", "disp/s", "cids");
+	/*
+	 * alloc is the cid-time the partition handed each participant, and used
+	 * is the cid-time its tasks actually ran, per
+	 * ops.sub_cid_sched_updated(). Both are in cpus over the window.
+	 */
+	printf("hier   : %-4s %10s %4s %6s %6s %8s  %s\n",
+	       "", "cgroup", "w", "alloc", "used", "disp/s", "cids");
 
 	format_cid_ranges(qa, CID_SELF, ranges, sizeof(ranges));
-	printf("hier   : %-4s %10llu %4u %6.2f %8s  %s\n", "self",
+	printf("hier   : %-4s %10llu %4u %6.2f %6.2f %8s  %s\n", "self",
 	       (unsigned long long)own_cgid, 100,
-	       secs > 0 ? (qa->self_alloc_ns - prev->self_alloc_ns) / (secs * 1e9) : 0.0,
+	       delta_ratio(qa->self_alloc_ns, prev->self_alloc_ns, secs),
+	       delta_ratio(qa->self_used_snap_ns, prev->self_used_snap_ns, secs),
 	       "-", ranges);
 	prev->self_alloc_ns = qa->self_alloc_ns;
+	/* used accrues without a window, so prev moves only with the window */
+	if (secs > 0)
+		prev->self_used_snap_ns = qa->self_used_snap_ns;
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
 		struct sub_sched_ctx *sc = &qa->sub_sched_ctxs[i];
@@ -225,12 +248,15 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 
 		snprintf(who, sizeof(who), "sub%u", i);
 		format_cid_ranges(qa, i, ranges, sizeof(ranges));
-		printf("hier   : %-4s %10llu %4u %6.2f %8.1f  %s\n", who,
+		printf("hier   : %-4s %10llu %4u %6.2f %6.2f %8.1f  %s\n", who,
 		       (unsigned long long)sc->cgroup_id, sc->weight,
-		       secs > 0 ? (qa->alloc_ns[i] - prev->alloc_ns[i]) / (secs * 1e9) : 0.0,
+		       delta_ratio(qa->alloc_ns[i], prev->alloc_ns[i], secs),
+		       delta_ratio(qa->used_snap_ns[i], prev->used_snap_ns[i], secs),
 		       secs > 0 ? (sc->nr_dsps - prev->nr_dsps[i]) / secs : 0.0,
 		       ranges);
 		prev->alloc_ns[i] = qa->alloc_ns[i];
+		if (secs > 0)
+			prev->used_snap_ns[i] = qa->used_snap_ns[i];
 		prev->nr_dsps[i] = sc->nr_dsps;
 	}
 }
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 089c5176c4ec..949459d06a18 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -163,6 +163,17 @@ struct qmap_arena {
 	u64 alloc_ts;			/* last accounting timestamp */
 	u64 alloc_window_ns;		/* total accounted time, the alloc denominator */
 
+	/*
+	 * The per-cid fields are written only by that cid's notifications and
+	 * read by flush_alloc() for the snapshot userspace displays.
+	 */
+	s32 cid_sched[SCX_QMAP_MAX_CPUS]; /* per cid: owner id of the sched running there */
+	u64 cid_sched_since[SCX_QMAP_MAX_CPUS]; /* when that last changed */
+	u64 used_ns[MAX_SUB_SCHEDS];	/* per child slot, closed intervals */
+	u64 self_used_ns;
+	u64 used_snap_ns[MAX_SUB_SCHEDS]; /* used_ns[] plus the intervals open at the flush */
+	u64 self_used_snap_ns;
+
 	/* bpf-internal cmasks (embedded, see struct qmap_cmask) */
 	struct qmap_cmask self_cids;	/* cids this node runs its own tasks on */
 	struct qmap_cmask avail_cids;	/* cids with caps in effect on the cpu */
-- 
2.55.0

