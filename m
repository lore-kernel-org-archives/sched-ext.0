Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEA448CF1;
	Fri, 24 Jul 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917294; cv=none; b=b/ALjF2YRXR1uMdzv5WiN/XOtDSuturnqrqyHFesG084g2tE5QcThAObZvcxSvB6lKuSz3daBuz/DCvp3EcppxvPVvQsy3gfNJgW6TirUGeq94rReVX3Vg5xyXnNwLjq7tQJ6z5HOaaoiouOqR9/aAu73ETdwQcx38yJqefapJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917294; c=relaxed/simple;
	bh=ElpkOodSX5pTlyQmB0zQPSuOHPCqkYr4lSNVBfuDsow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2PZdop1PCMz+2nX8Xw5L06FhVJ5wifkGZYVVYW/R+LATSnJPVV16qtTSDIrQBG+IWSDQrszPn+p9qop3IXV/gWBzrcNNmBPcjZLgX1Twnz1g210eZTl/aWGeyGA5BtwtDN7kyFw9uQJQj/PV8NGMkRQd2/Nt9VxvFZQ6USp4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFJkHOe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFJkHOe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C271F000E9;
	Fri, 24 Jul 2026 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917291;
	bh=A57AS24i5QykfYMde5MSFKG+EC0AiVlmMNeqF0cRPqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFJkHOe4or4CgK8P/noII/uHgj139HYlqKJOmTA1FqSGuHQLBt5emuklbv95HvZdf
	 2xJpz7S1LobAQFEGduRPnnIYmj4/BcsYpx6NUlA1Y7OHOymmAT15489PAYu2f71od5
	 I42Y+Szo1zVtNQVZbnOgZYMEhsaOMTrmnRwWln8gUEtsbWYDm4uYZ9ZI0gkuz272vY
	 6k4y8mIljgM1Zm/QYt+UqOp4GlwtMy93oX+WhT0h/EnMFj4feEjEcixz9a00athOGl
	 3i0rtZN5/8larkm9Y1H85P3AkHtYu8kcln97jakbQid0HYRN9kYoEksrwnjsev6HeD
	 0cmHGbqNSEbBw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] sched_ext: Gate scx_bpf_cidperf_set() behind a new SCX_CAP_PERF
Date: Fri, 24 Jul 2026 08:21:25 -1000
Message-ID: <20260724182125.985061-6-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724182125.985061-1-tj@kernel.org>
References: <20260724182125.985061-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cidperf_set() reaches cpufreq with no cap check, so any cid-form
sub-sched can steer the frequency of any cid in its view, including ones it
holds nothing on.

Gate it behind a new SCX_CAP_PERF rather than SCX_CAP_BASE: hardware control
is a separate axis from queue access - a parent may well delegate scheduling
on a cid without handing over its frequency. PERF neither implies nor is
implied by the other caps. The check runs under the target rq's lock, which
ecaps updates are also folded under, so it is authoritative - a write can
never land after a revoke has taken effect. Denials are counted in
SCX_EV_SUB_CIDPERF_DENIED.

The operation is synchronous and the outcome is reported to the caller.
scx_bpf_cidperf_set() shipped in v7.2 returning void, so add
scx_bpf_cidperf_set___v2() returning 0 or -errno, -EACCES on denial, and
keep the old kfunc as a gated void wrapper. The tools compat wrapper prefers
the v2 and returns 0 on pre-gate kernels, which always apply the write.

scx_qmap grants PERF alongside its existing cid grants so the cpuperf demo
keeps working in sub-scheds.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                   | 53 +++++++++++++++++++-----
 kernel/sched/ext/internal.h              | 16 ++++++-
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++
 tools/sched_ext/scx_qmap.bpf.c           | 17 +++++---
 5 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 366245daab68..4b7cb0665798 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5144,6 +5144,7 @@ static const char *scx_cap_names[__SCX_NR_CAPS] = {
 	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 	[__SCX_CAP_ENQ]		= "enq",
 	[__SCX_CAP_PREEMPT]	= "preempt",
+	[__SCX_CAP_PERF]	= "perf",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
@@ -9800,6 +9801,7 @@ static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)
 {
 	struct rq *rq, *locked_rq;
 	struct rq_flags rf;
+	s32 ret;
 
 	if (unlikely(perf > SCX_CPUPERF_ONE)) {
 		scx_error(sch, "Invalid cpuperf target %u for CPU %d", perf, cpu);
@@ -9830,13 +9832,24 @@ static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)
 		update_rq_clock(rq);
 	}
 
-	rq->scx.cpuperf_target = perf;
-	cpufreq_update_util(rq, 0);
+	/*
+	 * ecaps updates are folded under the rq lock, making this test
+	 * authoritative: a write can never land after a revoke has taken
+	 * effect on @cpu.
+	 */
+	if (likely(!scx_missing_caps(sch, cpu, SCX_CAP_PERF))) {
+		rq->scx.cpuperf_target = perf;
+		cpufreq_update_util(rq, 0);
+		ret = 0;
+	} else {
+		__scx_add_event(sch, SCX_EV_SUB_CIDPERF_DENIED, 1);
+		ret = -EACCES;
+	}
 
 	if (!locked_rq)
 		rq_unlock_irqrestore(rq, &rf);
 
-	return 0;
+	return ret;
 }
 
 __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_aux *aux)
@@ -9853,15 +9866,18 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 }
 
 /**
- * scx_bpf_cidperf_set - Set the performance target of the CPU at @cid
+ * scx_bpf_cidperf_set___v2 - Set the performance target of the CPU at @cid
  * @cid: cid of the CPU to target
  * @perf: target performance level [0, %SCX_CPUPERF_ONE]
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * cid-addressed equivalent of scx_bpf_cpuperf_set().
+ * cid-addressed equivalent of scx_bpf_cpuperf_set(). A sub-sched needs
+ * SCX_CAP_PERF on @cid. Returns 0 if the target was applied, -%EACCES if
+ * the write was denied for missing caps, other -errnos if @cid didn't
+ * resolve.
  */
-__bpf_kfunc void scx_bpf_cidperf_set(s32 cid, u32 perf,
-				     const struct bpf_prog_aux *aux)
+__bpf_kfunc s32 scx_bpf_cidperf_set___v2(s32 cid, u32 perf,
+					 const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	s32 cpu;
@@ -9870,11 +9886,27 @@ __bpf_kfunc void scx_bpf_cidperf_set(s32 cid, u32 perf,
 
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
-		return;
+		return -ENODEV;
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
-		return;
-	scx_bpf_cpuperf_set(cpu, perf, aux);
+		return cpu;
+
+	return scx_cpuperf_set(sch, cpu, perf);
+}
+
+/**
+ * scx_bpf_cidperf_set - Set the performance target of the CPU at @cid
+ * @cid: cid of the CPU to target
+ * @perf: target performance level [0, %SCX_CPUPERF_ONE]
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Pre-v7.3 variant of scx_bpf_cidperf_set___v2() without the result. Kept
+ * for schedulers built against older kernels.
+ */
+__bpf_kfunc void scx_bpf_cidperf_set(s32 cid, u32 perf,
+				     const struct bpf_prog_aux *aux)
+{
+	scx_bpf_cidperf_set___v2(cid, perf, aux);
 }
 
 /**
@@ -10306,6 +10338,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cidperf_cap, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cidperf_cur, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cidperf_set, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cidperf_set___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cids)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 308d16320818..886f1d132e6b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1206,6 +1206,12 @@ struct scx_event_stats {
 	 * sub-sched lacked baseline access on the target cid.
 	 */
 	s64		SCX_EV_SUB_REENQ_DENIED;
+
+	/*
+	 * The number of times scx_bpf_cidperf_set() was denied because the
+	 * sub-sched lacked SCX_CAP_PERF on the target cid.
+	 */
+	s64		SCX_EV_SUB_CIDPERF_DENIED;
 };
 
 #define SCX_EVENTS_LIST(SCX_EVENT)					\
@@ -1227,7 +1233,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT);				\
 	SCX_EVENT(SCX_EV_SUB_PREEMPT_DENIED);				\
 	SCX_EVENT(SCX_EV_SUB_KICK_DENIED);				\
-	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED)
+	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED);				\
+	SCX_EVENT(SCX_EV_SUB_CIDPERF_DENIED)
 
 struct scx_sched;
 
@@ -1353,6 +1360,11 @@ struct scx_sched_pnode {
  *            - SCX_ENQ_PREEMPT inserts
  *            - SCX_KICK_PREEMPT kicks
  *
+ * PERF       control the cid's cpu power/perf management state, currently the
+ *            cpufreq target set through scx_bpf_cidperf_set(). Hardware
+ *            control is a separate axis from queue access: PERF neither
+ *            implies nor is implied by the caps above.
+ *
  * Implied caps apply to the holder's own use of a cid, not to delegation.
  * scx_bpf_sub_grant() delegates literally-held caps, so a cap held only through
  * implication is usable but cannot be re-delegated to a child. When granting a
@@ -1363,6 +1375,7 @@ enum scx_cap_flags {
 	__SCX_CAP_ENQ_IMMED		= 0,
 	__SCX_CAP_ENQ			= 1,
 	__SCX_CAP_PREEMPT		= 2,
+	__SCX_CAP_PERF			= 3,
 
 	__SCX_NR_CAPS,
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
@@ -1370,6 +1383,7 @@ enum scx_cap_flags {
 	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
 	SCX_CAP_ENQ			= BIT_U64(__SCX_CAP_ENQ),
 	SCX_CAP_PREEMPT			= BIT_U64(__SCX_CAP_PREEMPT),
+	SCX_CAP_PERF			= BIT_U64(__SCX_CAP_PERF),
 
 	/* alias for minimal cap to make any use of a cpu */
 	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index acc2b131ea8f..c8809887cbde 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -112,7 +112,7 @@ u32 scx_bpf_nr_cids(void) __ksym __weak;
 u32 scx_bpf_nr_online_cids(void) __ksym __weak;
 u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
 u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
-void scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
+/* scx_bpf_cidperf_set() is wrapped in compat.bpf.h */
 
 /* sub-scheduler cap control, scx_bpf_sub_caps() cgroup_id 0 == self */
 s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps, const struct scx_cmask *cmask,
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index cf469d5ff9ca..1a798213105b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -420,6 +420,24 @@ static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 		scx_bpf_error("kernel too old to reenqueue foreign local or user DSQs");
 }
 
+/*
+ * v7.3: scx_bpf_cidperf_set() now returns 0 or -errno - -EACCES when a
+ * sub-sched lacks SCX_CAP_PERF on the cid and the write was denied. Pre-gate
+ * kernels always apply the write. Drop the wrapper and move the decl to
+ * common.bpf.h after v7.6.
+ */
+s32 scx_bpf_cidperf_set___v2___compat(s32 cid, u32 perf) __ksym __weak;
+void scx_bpf_cidperf_set___compat(s32 cid, u32 perf) __ksym __weak;
+
+static inline s32 scx_bpf_cidperf_set(s32 cid, u32 perf)
+{
+	if (bpf_ksym_exists(scx_bpf_cidperf_set___v2___compat))
+		return scx_bpf_cidperf_set___v2___compat(cid, perf);
+
+	scx_bpf_cidperf_set___compat(cid, perf);
+	return 0;
+}
+
 /*
  * Define sched_ext_ops. See compat.h::SCX_OPS_OPEN() for how backward
  * compatibility is handled (this macro can be expanded to emit multiple
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index aead17658573..8822ed11c0d8 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -1585,11 +1585,13 @@ __noinline void apply_partition(void)
 		cmask_copy(&qa.to_grant_cids.mask, &ssc->granted_cids.mask);
 		cmask_andnot(&qa.to_grant_cids.mask, &ssc->prev_granted.mask);
 
-		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ_IMMED,
+		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 				   (void *)(long)&qa.prev_rr_cids.mask);
-		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT | SCX_CAP_ENQ_IMMED,
+		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT |
+				   SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 				   (void *)(long)&qa.to_revoke_cids.mask);
-		scx_bpf_sub_grant(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT | SCX_CAP_ENQ_IMMED,
+		scx_bpf_sub_grant(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT |
+				  SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 				  (void *)(long)&qa.to_grant_cids.mask, NULL);
 	}
 
@@ -1605,7 +1607,8 @@ __noinline void apply_partition(void)
 
 		holder_cgid = qa.part.rr_slots[pos];	/* 0 = self, nothing to grant */
 		if (holder_cgid)
-			scx_bpf_sub_grant(holder_cgid, SCX_CAP_ENQ_IMMED,
+			scx_bpf_sub_grant(holder_cgid,
+					  SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 					  (void *)(long)&qa.rr_cids.mask, NULL);
 	}
 }
@@ -1696,10 +1699,12 @@ static void rr_advance(void)
 		 * time-share.
 		 */
 		if (old_cgid)
-			scx_bpf_sub_revoke(old_cgid, SCX_CAP_ENQ_IMMED,
+			scx_bpf_sub_revoke(old_cgid,
+					   SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 					   (void *)(long)&qa.rr_cids.mask);
 		if (new_cgid)
-			scx_bpf_sub_grant(new_cgid, SCX_CAP_ENQ_IMMED,
+			scx_bpf_sub_grant(new_cgid,
+					  SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 					  (void *)(long)&qa.rr_cids.mask, NULL);
 	}
 
-- 
2.55.0

