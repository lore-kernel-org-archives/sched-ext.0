Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE72C87F;
	Thu,  8 Oct 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417836; cv=none; b=hP20NOjLUv58bax+7DbBh3/Lp34s1DvwnZ3mlAoYD6XYismU43DCxtSquJB1CeZQjGGMub2yvPAdHE5bkiU308BB9d2eD73xTGaCEuIO22abcer8EVso1dwUfYDOOPvm3Y7EyPd+LHzE2jMaXD+Ped1BdRDpsW6LZCKaPR/dWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417836; c=relaxed/simple;
	bh=Z6EoWTwRJA20i9rm/y6Bmv0H94g33VBeQ5Y8ZcYpqoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reFsVAQdhrsTDKkOHloh4Sebl7g7NORkhqaYHuQyj+Z5Xa9qbi0aOUbblhlS+vSYdMzboQzbDutrGSL9AJG5aX8nBlbf/0tvSFPUCLuG7EVtAIHW2w7Ejt8wYRxjGaJWt0N6rdRVP2WAAW94fhTPY4YqoqwFzNcieIAl1BRKd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOhEG8y9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOhEG8y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517371F000FF;
	Thu,  8 Oct 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417835;
	bh=e5BHidJwH5DYAQ8HAyrTTnFeOfq954w/2YsESkvKaKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOhEG8y9vIQc10yhFltR45mvk7bS07u/u6MjL1wbbbFI/8ahrs1BLq5eQMGnp08Q2
	 MDamzVcFqNbQIQvsVC7iF1s06pN1uHxTBVs7cYFF2CX+qcVbn46Fv29XB6QHV4SmIE
	 V+GrwKkutlez4DDWJFomhkTybN6OEFpZL/Kxqg9uUkbz9+aw9jXqVz+Lxi1Y35ycA5
	 dYoLUX5P0IKAWIEZYzDMb1gw+eqo6MZMDjs/UZTCZ1Yx3bClbmWTuAFL9voIddWmwm
	 ZbTYUiQXvUihUbGDMlAQYL7fFsPdU1JpQgqmWJV/VgwoBRFv6WuiXRoslIByhz4he+
	 4sPkxRfS/8GPw==
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
Date: Wed,  7 Oct 2026 14:03:52 -1000
Message-ID: <20261008000352.1689057-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008000352.1689057-1-tj@kernel.org>
References: <20261008000352.1689057-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child that ran a cid at a low cpuperf target leaves the target there when
PERF is revoked, since the kernel resets targets only at root enable. Reset
it to SCX_CPUPERF_ONE from ops.sub_child_ecaps_updated() once the revoke is
in effect, a detach included. Count the deliveries in the hier stats.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 15 +++++++++++++++
 tools/sched_ext/scx_qmap.c     |  7 +++++--
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 7f69394556b6..853db13d060e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -2208,6 +2208,20 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updated, s32 cid, u64 before, u64 after)
 	execute_partition();
 }
 
+void BPF_STRUCT_OPS(qmap_sub_child_ecaps_updated, u64 cgroup_id, s32 cid, u64 before,
+		    u64 after)
+{
+	__sync_fetch_and_add(&qa.nr_child_ecaps, 1);
+
+	/*
+	 * A cid's cpuperf target stays where the last write put it. Reset it
+	 * once a child's PERF revoke is in effect so that the child's last
+	 * target doesn't outlive the cap.
+	 */
+	if ((before & ~after) & SCX_CAP_PERF)
+		scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
+}
+
 SCX_OPS_CID_DEFINE(qmap_ops,
 	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
 	       .select_cid		= (void *)qmap_select_cid,
@@ -2232,6 +2246,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
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

