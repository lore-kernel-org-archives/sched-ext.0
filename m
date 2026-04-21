Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C138758F;
	Tue, 21 Apr 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755994; cv=none; b=MaWTft8mVr4X4KYNCXv728gxMc0YkolmOx126CkMoxM1pqU4WgP3pglsWaRlooqyEQ2tm5t6GthP+d4HpnELS4my/izAzucyCRtX6hdiayT//ZOjMPcTaQ8BAB5HSplOK0Es1idt4ehXyoBmrXRJ35C9pbfKrA6aFMWELszTSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755994; c=relaxed/simple;
	bh=tkm6oNzAGfeaUGDoP3hdlMT/RJry7aJ2X1KcvZloZRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkIhfP8rGyDFoeONa6nUg26NcDUQevEl8foH3HkGZxSCSHKa+1LUQ0p/m7uYY1ssnW1n84UJC6KsTAQ44S4pKGMSNpfI2shuN8UN7YwaAdYdw18aQfDJbEBkv8Wo/WyTuh2SXk2L9B24ROiGKA+lHDcdmGAqPHXR4sObgSvtixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ans8a2fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ans8a2fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D1C2BCB0;
	Tue, 21 Apr 2026 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755994;
	bh=tkm6oNzAGfeaUGDoP3hdlMT/RJry7aJ2X1KcvZloZRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ans8a2fzkeeXcK03XVA33/nmkq9ik21/t4PeIgEn9ZD2P3gXNYmGjOKwMY5afceEc
	 WZpm2uXFWPUX5VXndJojOFNnPoYG/S73c+ZuzebQIqiCMvX0f1DLSileqmr+hBEe1c
	 PKWWVHTcWxw2hzKaZJzFkrsFja5LfkFEHgmBjrnHGstWCbBSHSuyOvAnQ6jevLfAaq
	 CU/lD36d9rsa8cprQkJ+5giDrwoAsgAbApg7S8CIKVScRx2pcNbrmsXrdok8vP5lTG
	 o7FRnc4C0QWScWFSel48nRWzNp4x4k2XVgL+kupjRFZmPpFJJLQw2tyUbcFjpusP1T
	 j4DDMBldVz6lQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/16] sched_ext: Add scx_bpf_cid_override() kfunc
Date: Mon, 20 Apr 2026 21:19:36 -1000
Message-ID: <20260421071945.3110084-8-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auto-probed cid mapping reflects the kernel's view of topology
(node -> LLC -> core), but a BPF scheduler may want a different layout -
to align cid slices with its own partitioning, or to work around how the
kernel reports a particular machine.

Add scx_bpf_cid_override(), callable from ops.init() of the root
scheduler. It validates the caller-supplied cpu->cid array and replaces
the in-place mapping; topo info is invalidated. A compat.bpf.h wrapper
silently no-ops on kernels that lack the kfunc.

A new SCX_KF_ALLOW_INIT bit in the kfunc context filter restricts the
kfunc to ops.init() at verifier load time.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 16 +++--
 kernel/sched/ext_cid.c                   | 75 +++++++++++++++++++++++-
 kernel/sched/ext_cid.h                   |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 12 ++++
 4 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ac0fa21cab26..fedad66d13b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9640,10 +9640,11 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  */
 enum scx_kf_allow_flags {
 	SCX_KF_ALLOW_UNLOCKED		= 1 << 0,
-	SCX_KF_ALLOW_CPU_RELEASE	= 1 << 1,
-	SCX_KF_ALLOW_DISPATCH		= 1 << 2,
-	SCX_KF_ALLOW_ENQUEUE		= 1 << 3,
-	SCX_KF_ALLOW_SELECT_CPU		= 1 << 4,
+	SCX_KF_ALLOW_INIT		= 1 << 1,
+	SCX_KF_ALLOW_CPU_RELEASE	= 1 << 2,
+	SCX_KF_ALLOW_DISPATCH		= 1 << 3,
+	SCX_KF_ALLOW_ENQUEUE		= 1 << 4,
+	SCX_KF_ALLOW_SELECT_CPU		= 1 << 5,
 };
 
 /*
@@ -9671,7 +9672,7 @@ static const u32 scx_kf_allow_flags[] = {
 	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
-	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED | SCX_KF_ALLOW_INIT,
 	[SCX_OP_IDX(exit)]		= SCX_KF_ALLOW_UNLOCKED,
 };
 
@@ -9686,6 +9687,7 @@ static const u32 scx_kf_allow_flags[] = {
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	bool in_unlocked = btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id);
+	bool in_init = btf_id_set8_contains(&scx_kfunc_ids_init, kfunc_id);
 	bool in_select_cpu = btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id);
 	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
 	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
@@ -9695,7 +9697,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
-	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch ||
+	if (!(in_unlocked || in_init || in_select_cpu || in_enqueue || in_dispatch ||
 	      in_cpu_release || in_idle || in_any))
 		return 0;
 
@@ -9731,6 +9733,8 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 
 	if ((flags & SCX_KF_ALLOW_UNLOCKED) && in_unlocked)
 		return 0;
+	if ((flags & SCX_KF_ALLOW_INIT) && in_init)
+		return 0;
 	if ((flags & SCX_KF_ALLOW_CPU_RELEASE) && in_cpu_release)
 		return 0;
 	if ((flags & SCX_KF_ALLOW_DISPATCH) && in_dispatch)
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 55467ca69800..4ee727d27c78 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -210,6 +210,68 @@ s32 scx_cid_init(struct scx_sched *sch)
 
 __bpf_kfunc_start_defs();
 
+/**
+ * scx_bpf_cid_override - Install an explicit cpu->cid mapping
+ * @cpu_to_cid: array of nr_cpu_ids s32 entries (cid for each cpu)
+ * @cpu_to_cid__sz: must be nr_cpu_ids * sizeof(s32) bytes
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * May only be called from ops.init() of the root scheduler. Replace the
+ * topology-probed cid mapping with the caller-provided one. Each possible cpu
+ * must map to a unique cid in [0, num_possible_cpus()). Topo info is cleared.
+ * On invalid input, trigger scx_error() to abort the scheduler.
+ */
+__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
+				      const struct bpf_prog_aux *aux)
+{
+	cpumask_var_t seen __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	struct scx_sched *sch;
+	bool alloced;
+	s32 cpu, cid;
+
+	/* GFP_KERNEL alloc must happen before the rcu read section */
+	alloced = zalloc_cpumask_var(&seen, GFP_KERNEL);
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+
+	if (!alloced) {
+		scx_error(sch, "scx_bpf_cid_override: failed to allocate cpumask");
+		return;
+	}
+
+	if (scx_parent(sch)) {
+		scx_error(sch, "scx_bpf_cid_override() only allowed from root sched");
+		return;
+	}
+
+	if (cpu_to_cid__sz != nr_cpu_ids * sizeof(s32)) {
+		scx_error(sch, "scx_bpf_cid_override: expected %zu bytes, got %u",
+			  nr_cpu_ids * sizeof(s32), cpu_to_cid__sz);
+		return;
+	}
+
+	for_each_possible_cpu(cpu) {
+		s32 c = cpu_to_cid[cpu];
+
+		if (!cid_valid(sch, c))
+			return;
+		if (cpumask_test_and_set_cpu(c, seen)) {
+			scx_error(sch, "cid %d assigned to multiple cpus", c);
+			return;
+		}
+		scx_cpu_to_cid_tbl[cpu] = c;
+		scx_cid_to_cpu_tbl[c] = cpu;
+	}
+
+	/* Invalidate stale topo info - the override carries no topology. */
+	for (cid = 0; cid < num_possible_cpus(); cid++)
+		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
+}
+
 /**
  * scx_bpf_cid_to_cpu - Return the raw CPU id for @cid
  * @cid: cid to look up
@@ -282,6 +344,16 @@ __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
 
 __bpf_kfunc_end_defs();
 
+BTF_KFUNCS_START(scx_kfunc_ids_init)
+BTF_ID_FLAGS(func, scx_bpf_cid_override, KF_IMPLICIT_ARGS | KF_SLEEPABLE)
+BTF_KFUNCS_END(scx_kfunc_ids_init)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_init = {
+	.owner	= THIS_MODULE,
+	.set	= &scx_kfunc_ids_init,
+	.filter	= scx_kfunc_context_filter,
+};
+
 BTF_KFUNCS_START(scx_kfunc_ids_cid)
 BTF_ID_FLAGS(func, scx_bpf_cid_to_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpu_to_cid, KF_IMPLICIT_ARGS)
@@ -295,7 +367,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_cid = {
 
 int scx_cid_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_cid) ?:
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_init) ?:
+		register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_cid) ?:
 		register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_cid) ?:
 		register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_cid);
 }
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index dded0a540a26..19848fa9e8fc 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -68,6 +68,7 @@ struct scx_cid_topo {
 extern s16 *scx_cid_to_cpu_tbl;
 extern s16 *scx_cpu_to_cid_tbl;
 extern struct scx_cid_topo *scx_cid_topo;
+extern struct btf_id_set8 scx_kfunc_ids_init;
 
 s32 scx_cid_init(struct scx_sched *sch);
 int scx_cid_kfunc_init(void);
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 2808003eef04..6b9d054c3e4f 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -121,6 +121,18 @@ static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
 	return false;
 }
 
+/*
+ * v7.2: scx_bpf_cid_override() for explicit cpu->cid mapping. Ignore if
+ * missing.
+ */
+void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid__sz) __ksym __weak;
+
+static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz)
+{
+	if (bpf_ksym_exists(scx_bpf_cid_override___compat))
+		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
-- 
2.53.0

