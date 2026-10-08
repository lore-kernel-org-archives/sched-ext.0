Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D7422530;
	Thu,  8 Oct 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451953; cv=none; b=p8MGcIDObgjd5Drto688XJJ2Gz4/HoutqXgFU3sBRso16yFvD+vnmZNIh28RFNLMbNVyvOqPRWRlBNNuifx+9FDPl0l+gWGnushAnoRH8OjAokARW8j54JP0BVAyMeg8Vs42Sl4iSTb65Ul+kT7x74CJThJNcH6PSEk+VwoXFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451953; c=relaxed/simple;
	bh=iMiJf7fEzifNr/wF090hQM7isM+nesYlTPM7ProQMjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYrRPoxYyCxniV4YnwsGlDHTGlEtQGRETlCHp9K5JBJydQU/gqY1T7gieJ69q5Wu5zfUx/R0UXGbuc+OKfobKU/Jvo961htzk2IsE2s6K4e+WkEEiWjpyQz/IaRrDt7N+6MyeZkBSN/dfAUP2vcyxnpmVLDM5qxST99cQk6XDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLP4DPKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLP4DPKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B26C1F00898;
	Thu,  8 Oct 2026 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791451951;
	bh=U9EzVHqHib3lrbAj2l54u3YkkWw5idWjnj+X2mkqD+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLP4DPKx6udV2RR16vfhAAjzLL2we0GvNgGnR9x/2CY6VSWT2dyw6SNRkzYvrSj5r
	 Eu/mBsCsPT+5nm2VlwuvFeQZ4Yy8PCGOshnbP7o5vLeB3NiTfg+rgbOyp8PJgz77i0
	 dcIzt1bORi3BNpxd5LE9vlk8Sybfu6bC2jKy+lJ0v6XUVXfvm7DmRztQhdKDgksqYA
	 MwO6EAUMmelVouqf3kzit3BEdeXTDoPGTG1xEhNW56R5QFZkstENWdYJEzj0qIzafy
	 /Vl090+KzyVIOHBN3z4rcIUMsrnEkZJCthcBqPeaOo7DqeXd5I7c3GcUipFI809jQ9
	 A/q886xuNhH/A==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: scx_qmap: Reset a child's cpuperf targets once its PERF revoke takes effect
Date: Wed,  7 Oct 2026 23:32:28 -1000
Message-ID: <20261008093228.2015427-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008093228.2015427-1-tj@kernel.org>
References: <20261008093228.2015427-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child that ran a cid at a low cpuperf target leaves the target there when
PERF is revoked, since the kernel resets targets only at root enable. Reset
the target from ops.sub_child_ecaps_updated() once the revoke is in effect.
A detach reports nothing, so ops.sub_detach() resets the child's cids, the
pool included. Count the deliveries in the hier stats.

v2: Reset from ops.sub_detach() for a detaching child's cids.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 33 +++++++++++++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c     |  7 +++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 7f69394556b6..4c152b44bc91 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -2167,12 +2167,30 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
 
 void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 {
-	s32 i;
+	u64 cgid = args->ops->sub_cgroup_id;
+	s32 nr_cids = qa.nr_cids;
+	s32 i, cid;
+
+	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS) {
+		scx_bpf_error("-ERANGE");
+		return;
+	}
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
-		if (qa.sub_sched_ctxs[i].cgroup_id != args->ops->sub_cgroup_id)
+		if (qa.sub_sched_ctxs[i].cgroup_id != cgid)
 			continue;
 
+		/*
+		 * The child's caps are gone without a report, see
+		 * ops.sub_detach(). cpuperf targets persist until the next
+		 * write, reset the child's excl cids and the pool it may have
+		 * held.
+		 */
+		bpf_arena_for(cid, 0, nr_cids)
+			if (cmask_test(cid, &qa.sub_sched_ctxs[i].granted_cids.mask) ||
+			    cmask_test(cid, &qa.rr_cids.mask))
+				scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
+
 		qa.sub_sched_ctxs[i].cgroup_id = 0;
 		qa.sub_sched_ctxs[i].weight = 100;
 		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
@@ -2208,6 +2226,16 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updated, s32 cid, u64 before, u64 after)
 	execute_partition();
 }
 
+void BPF_STRUCT_OPS(qmap_sub_child_ecaps_updated, u64 cgroup_id, s32 cid, u64 before,
+		    u64 after)
+{
+	__sync_fetch_and_add(&qa.nr_child_ecaps, 1);
+
+	/* a child's last target must not outlive its PERF cap */
+	if ((before & ~after) & SCX_CAP_PERF)
+		scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
+}
+
 SCX_OPS_CID_DEFINE(qmap_ops,
 	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
 	       .select_cid		= (void *)qmap_select_cid,
@@ -2232,6 +2260,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
 	       .sub_caps_updated	= (void *)qmap_sub_caps_updated,
 	       .sub_ecaps_updated	= (void *)qmap_sub_ecaps_updated,
 	       .sub_cid_sched_updated	= (void *)qmap_sub_cid_sched_updated,
+	       .sub_child_ecaps_updated	= (void *)qmap_sub_child_ecaps_updated,
 	       .init_cids		= (void *)qmap_init_cids,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e83d5e2147dd..17cf584a2a3d 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -113,6 +113,7 @@ struct hier_prev {
 	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 	u64 nr_rescue_dsp;
+	u64 nr_child_ecaps;
 };
 
 /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
@@ -208,18 +209,20 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu child_ecaps=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
 	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
-	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
+	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp),
+	       (unsigned long long)(qa->nr_child_ecaps - prev->nr_child_ecaps));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
 	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
+	prev->nr_child_ecaps = qa->nr_child_ecaps;
 
 	/*
 	 * alloc is the cid-time the partition handed each participant, and used
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 949459d06a18..9e6eefb39735 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -195,6 +195,7 @@ struct qmap_arena {
 	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
+	u64 nr_child_ecaps;		/* ops.sub_child_ecaps_updated() deliveries */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
 
-- 
2.55.0

