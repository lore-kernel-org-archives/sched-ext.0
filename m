Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494C39934C;
	Fri,  9 Oct 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578911; cv=none; b=qb+wAqTDHWZTXyp45rB+ND5cD+9ZcncP/VdMLO1Pl4HEHvYGjJ48FuLunD066hbacTHW0BfhyBF7ZF0NNd0CsSY7x+wUBAmxYog84hlNU5RvySFaxGwPF+OaL7s0RITd+UIW8InYcUrQjPzXCUhj6geGno+TfNAULfYfdnbRNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578911; c=relaxed/simple;
	bh=ylDlEbXEeSJP7kU6nx3pzvaBgTPZs0Bqt4evgacdQoI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=T7LAjSGHI7XoLLpmH291zzH1wIScfqA47Z7MAZxpT1hzXFgzAALtWm9TbXv71V1Z9U9TqZUy1Nz6QPruQux0AUg0KeFiXzgu4abIx8UnC92Ng6DOgocIqveMRkQwgalcpa8WJ+ki+DZIdhVN0nYNaT36WqlcO2JKpRMDJ1gNCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwsUZNZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwsUZNZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF311F000FF;
	Fri,  9 Oct 2026 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578909;
	bh=sACGEzIktJ8cixoDUd7FWD8UuLF50KKMgKVkIGUIpFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bwsUZNZ6eQhd8m/KnRZnphSkrLOK0fpq8f3vR8fb1sG76qUlRRMXYXfdGp8IRVwas
	 Ej/Mj5soJYSQQykUitCu3/O1K5t7KvMGdO0+7nethxINXhgN6TqSyHtBet6pzgSYsh
	 P+I1j+HjzvXG4eNrY3oDNZ62Ho5Nb3hSqsh+J4wdEbW580sCXMujY8WtoyowiHlwpg
	 MSohOcU0QbiGb5/344lnCV/qA/e8gXDJHV7Xsy81TftMe1dwQNxI1TbBqqpWbfKni7
	 23+UhjaYclul4Dl2NnPN1f1aaJjK9P+sbSvPeOy2cHjsoSfRaziOgit4rvOESEZ1SR
	 4rLyKzQXVYWXQ==
Date: Fri, 09 Oct 2026 10:48:28 -1000
Message-ID: <330648461b790ac9b6c431318be04c7d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] sched_ext: scx_qmap: Reset a child's cpuperf targets
 once its PERF revoke takes effect
In-Reply-To: <20261008093228.2015427-3-tj@kernel.org>
References: <20261008093228.2015427-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

A child that ran a cid at a low cpuperf target leaves the target there when
PERF is revoked, since the kernel resets targets only at root enable. Reset
the target from ops.sub_child_ecaps_updated() once the revoke is in effect.
A detach reports nothing, so ops.sub_detach() resets the child's cids, and
the pool unless another child holds it. Count the deliveries in the hier
stats.

v2: Reset from ops.sub_detach() for a detaching child's cids.

v3: Skip the pool at detach while another child holds it (Andrea Righi).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c |   39 +++++++++++++++++++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c     |    7 +++++--
 tools/sched_ext/scx_qmap.h     |    1 +
 3 files changed, 43 insertions(+), 4 deletions(-)

--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -2167,12 +2167,36 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, stru
 
 void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 {
-	s32 i;
+	u64 cgid = args->ops->sub_cgroup_id;
+	s32 nr_cids = qa.nr_cids;
+	s32 pos = qa.part.rr_pos;
+	u64 holder_cgid;
+	bool reset_pool;
+	s32 i, cid;
+
+	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS || pos < 0 || pos >= MAX_PARTS) {
+		scx_bpf_error("-ERANGE");
+		return;
+	}
+
+	/*
+	 * The child's caps are gone without a report, see ops.sub_detach().
+	 * cpuperf targets persist until the next write. Reset the child's excl
+	 * cids, and the pool unless another child holds it: that child's revoke
+	 * report or its own detach resets it then.
+	 */
+	holder_cgid = qa.part.rr_slots[pos];
+	reset_pool = !holder_cgid || holder_cgid == cgid;
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
-		if (qa.sub_sched_ctxs[i].cgroup_id != args->ops->sub_cgroup_id)
+		if (qa.sub_sched_ctxs[i].cgroup_id != cgid)
 			continue;
 
+		bpf_arena_for(cid, 0, nr_cids)
+			if (cmask_test(cid, &qa.sub_sched_ctxs[i].granted_cids.mask) ||
+			    (reset_pool && cmask_test(cid, &qa.rr_cids.mask)))
+				scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
+
 		qa.sub_sched_ctxs[i].cgroup_id = 0;
 		qa.sub_sched_ctxs[i].weight = 100;
 		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
@@ -2208,6 +2232,16 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updat
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
@@ -2232,6 +2266,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
 	       .sub_caps_updated	= (void *)qmap_sub_caps_updated,
 	       .sub_ecaps_updated	= (void *)qmap_sub_ecaps_updated,
 	       .sub_cid_sched_updated	= (void *)qmap_sub_cid_sched_updated,
+	       .sub_child_ecaps_updated	= (void *)qmap_sub_child_ecaps_updated,
 	       .init_cids		= (void *)qmap_init_cids,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -113,6 +113,7 @@ struct hier_prev {
 	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 	u64 nr_rescue_dsp;
+	u64 nr_child_ecaps;
 };
 
 /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
@@ -208,18 +209,20 @@ static void print_hier(struct qmap_arena
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
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -195,6 +195,7 @@ struct qmap_arena {
 	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
+	u64 nr_child_ecaps;		/* ops.sub_child_ecaps_updated() deliveries */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
 
