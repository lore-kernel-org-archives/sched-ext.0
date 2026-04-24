Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612A3E6DC6;
	Fri, 24 Apr 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051652; cv=none; b=oYcIcIAwE/bNTj5FwLsQAZ1gOkr1LWaB9grtPXgSPr2vcPrzV2i3LZ7h5OSGwN9Kb6b7CysH+WVQ91j0/7TaNbQBWA86sfZusgFn3FFAXP9AvlGIR0UOBfCoQgCOpu2w9Suek3fIQRd3mD04NdvYNgI+/hFJ8lV7sc30CSwO5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051652; c=relaxed/simple;
	bh=n5kejj6BzyKYnOn6hI3vHslIhOOV3WgIc5pVi14MlPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TneRdbEUnxWC2qXI5XGuFLRb/z+sgHo2Q+HQM6ZwqeFGIbpei+7blCT8v0x246eyt634N/tII3MPUSKJnJJLYUn01K6SAEI8JA6G4uzsnQDSueU9C1RZ+KfLGUOHuXDSktEX6hsC9nNPfKsgUCAzc5Bajdsw2STafb7bBnWyoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkQiQKQ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkQiQKQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C395C19425;
	Fri, 24 Apr 2026 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051651;
	bh=n5kejj6BzyKYnOn6hI3vHslIhOOV3WgIc5pVi14MlPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkQiQKQ9XfnOTCTkvC+H1+zloLOeyhHDmDLtAJ8ohCGmWyLnYjj1PDUMrWe4tcbl4
	 D450/rEE0JyOOE6xeaSz6h9CKB/QtyrOnYrDeOmfpHcjklHi2bwDMnzckVqXtSdxfT
	 UKebp3k/BnR+ji2F5kPfcVdwNnDW7rzltSXttnWATlRloJfsMNMOiZC8mty1UQawqs
	 Usn984EtoKpzIg9tviUt2PCLbs5kBIKAmQu3cOkuGhM/cEU3TYl31tX14JBMajdROl
	 rbGnJ+r59v/G23MVTQj2/GERUEThf1NXBAFAEWx5iXKtxzsJKi+37n8vWe+idhRwPM
	 HlWMK+m6Xl+hw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/17] sched_ext: Add scx_bpf_cid_override() kfunc
Date: Fri, 24 Apr 2026 07:27:12 -1000
Message-ID: <20260424172721.3458520-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
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
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c                       | 16 +++--
 kernel/sched/ext_cid.c                   | 75 +++++++++++++++++++++++-
 kernel/sched/ext_cid.h                   |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 12 ++++
 4 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e05d35e8c261..271399b9faa4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9641,10 +9641,11 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
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
@@ -9672,7 +9673,7 @@ static const u32 scx_kf_allow_flags[] = {
 	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
-	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED | SCX_KF_ALLOW_INIT,
 	[SCX_OP_IDX(exit)]		= SCX_KF_ALLOW_UNLOCKED,
 };
 
@@ -9687,6 +9688,7 @@ static const u32 scx_kf_allow_flags[] = {
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	bool in_unlocked = btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id);
+	bool in_init = btf_id_set8_contains(&scx_kfunc_ids_init, kfunc_id);
 	bool in_select_cpu = btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id);
 	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
 	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
@@ -9696,7 +9698,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
-	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch ||
+	if (!(in_unlocked || in_init || in_select_cpu || in_enqueue || in_dispatch ||
 	      in_cpu_release || in_idle || in_any))
 		return 0;
 
@@ -9732,6 +9734,8 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 
 	if ((flags & SCX_KF_ALLOW_UNLOCKED) && in_unlocked)
 		return 0;
+	if ((flags & SCX_KF_ALLOW_INIT) && in_init)
+		return 0;
 	if ((flags & SCX_KF_ALLOW_CPU_RELEASE) && in_cpu_release)
 		return 0;
 	if ((flags & SCX_KF_ALLOW_DISPATCH) && in_dispatch)
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 26b705b6e20d..4c356e31394c 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -212,6 +212,68 @@ s32 scx_cid_init(struct scx_sched *sch)
 
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
@@ -284,6 +346,16 @@ __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
 
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
@@ -297,7 +369,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_cid = {
 
 int scx_cid_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_cid) ?:
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_init) ?:
+		register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_cid) ?:
 		register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_cid) ?:
 		register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_cid);
 }
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index 1dbe8262ccdd..52edb66b53fd 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -49,6 +49,7 @@ struct scx_sched;
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

