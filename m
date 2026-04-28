Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FE3644CF;
	Tue, 28 Apr 2026 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408554; cv=none; b=uXdcdTbRLaIcRhDjtTKMqW90Fg3slBPLLFdqCu+oYI+1MYTPAAVNnRK4SB60V7PEoeA/XNckw37VGio8I9+jD0nEzAxCrfFvjvP4906ra8ycrBF7fDR+0wPJkvKnENmOW5VpMsZzJu7sc5t9B8IoXWq4v/pw9Kg3P068HGUK8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408554; c=relaxed/simple;
	bh=k1roT+tJVE/1m/GNMgC6iyLQgv2knwsH6/iiuN2YPdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9pz1iv+EVu8J+b26z4clwc7uiOQuAh1a3UZtdisrN4DCWeIuH8xw/An2wDk4EfBIxR1zyKq1t8slqYGBWPA99ldXvFTMFXiXgllIN11D/4aZPPduGhHvQEqSoXI8luRYE6xrpDvCCbzRvETj3gXM3a07FHZk5M6XOlYhhBjxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZnP53K2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZnP53K2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A41C2BCB7;
	Tue, 28 Apr 2026 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408554;
	bh=k1roT+tJVE/1m/GNMgC6iyLQgv2knwsH6/iiuN2YPdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZnP53K2uaoi+cjovzhqJCiBfzZFrJNKPQTDzGFxsZ+qM5LwyWlMzTV8d62Ce0gbv
	 u4xxfV9fcs894thEdNJSzNvnSRCEARdrqFTDdjpdAE6GLHjcW4XU8F10S/OiijQ2dF
	 H8QQloaEt22YF9YxkLuxFfsnaRqH6yqy7U8n+LI6P0BZR1Ix9FMxkeaaLEpeZGHzje
	 4SUAdTIDpxRvZwEMereaXwaogJdVPEry7s7/nVXf4LRBVyy/4VrV0kAlLoxFMbpZTy
	 1NopXOxN7NoocnNtKYGy9LPyCno+7nBITfAhfP4N1Q0shVDJQnToLwGzfqNyllw9So
	 I66OB4hpyyg5A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 07/17] sched_ext: Add topological CPU IDs (cids)
Date: Tue, 28 Apr 2026 10:35:35 -1000
Message-ID: <20260428203545.181052-8-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raw cpu numbers are clumsy for sharding and cross-sched communication,
especially from BPF. The space is sparse, numerical closeness doesn't
track topological closeness (x86 hyperthreading often scatters SMT
siblings), and a range of cpu ids doesn't describe anything meaningful.
Sub-sched support makes this acute: cpu allocation, revocation, and
state constantly flow across sub-scheds. Passing whole cpumasks scales
poorly (every op scans 4K bits) and cpumasks are awkward in BPF.

cids assign every cpu a dense, topology-ordered id. CPUs sharing a core,
LLC, or NUMA node occupy contiguous cid ranges, so a topology unit
becomes a (start, length) slice. Communication passes slices; BPF can
process a u64 word of cids at a time.

Build the mapping once at root enable by walking online cpus node -> LLC
-> core. Possible-but-not-online cpus tail the space with no-topo cids.
Expose kfuncs to map cpu <-> cid in either direction and to query each
cid's topology metadata.

v2: Use kzalloc_objs()/kmalloc_objs() for the three allocs in
    scx_cid_arrays_alloc() (Cheng-Yang Chou).

v3: scx_cid_init() failure path now drops cpus_read_lock();
    BUILD_BUG_ON tightened to match BPF cmask helpers' NR_CPUS<=8192.
    (Sashiko)

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/build_policy.c              |   2 +
 kernel/sched/ext.c                       |  18 ++
 kernel/sched/ext_cid.c                   | 301 +++++++++++++++++++++++
 kernel/sched/ext_cid.h                   | 129 ++++++++++
 kernel/sched/ext_types.h                 |  23 ++
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 6 files changed, 476 insertions(+)
 create mode 100644 kernel/sched/ext_cid.c
 create mode 100644 kernel/sched/ext_cid.h

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 1d92f7d7a19f..5e76c9177d54 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -61,8 +61,10 @@
 # include <linux/btf_ids.h>
 # include "ext_types.h"
 # include "ext_internal.h"
+# include "ext_cid.h"
 # include "ext_idle.h"
 # include "ext.c"
+# include "ext_cid.c"
 # include "ext_idle.c"
 #endif
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f9a1f217bc47..2b531256c763 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6820,6 +6820,18 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 */
 	cpus_read_lock();
 
+	/*
+	 * Build the cid mapping before publishing scx_root. The cid kfuncs
+	 * dereference the cid arrays unconditionally once scx_prog_sched()
+	 * returns non-NULL; the rcu_assign_pointer() below pairs with their
+	 * rcu_dereference() to make the populated arrays visible.
+	 */
+	ret = scx_cid_init(sch);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
+
 	/*
 	 * Make the scheduler instance visible. Must be inside cpus_read_lock().
 	 * See handle_hotplug().
@@ -9888,6 +9900,12 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	ret = scx_cid_kfunc_init();
+	if (ret) {
+		pr_err("sched_ext: Failed to register cid kfuncs (%d)\n", ret);
+		return ret;
+	}
+
 	ret = register_bpf_struct_ops(&bpf_sched_ext_ops, sched_ext_ops);
 	if (ret) {
 		pr_err("sched_ext: Failed to register struct_ops (%d)\n", ret);
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
new file mode 100644
index 000000000000..5b73900edc87
--- /dev/null
+++ b/kernel/sched/ext_cid.c
@@ -0,0 +1,301 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#include <linux/cacheinfo.h>
+
+/*
+ * cid tables.
+ *
+ * Pointers are published once on first enable and never revoked. The default
+ * mapping is populated before ops.init() runs; scx_bpf_cid_override() commits
+ * before it returns. As long as the BPF scheduler only uses the tables from
+ * those points onward, it sees a consistent view.
+ */
+s16 *scx_cid_to_cpu_tbl;
+s16 *scx_cpu_to_cid_tbl;
+struct scx_cid_topo *scx_cid_topo;
+
+#define SCX_CID_TOPO_NEG	(struct scx_cid_topo) {				\
+	.core_cid = -1, .core_idx = -1, .llc_cid = -1, .llc_idx = -1,		\
+	.node_cid = -1, .node_idx = -1,						\
+}
+
+/*
+ * Return @cpu's LLC shared_cpu_map. If cacheinfo isn't populated (offline or
+ * !present), record @cpu in @fallbacks and return its node mask instead - the
+ * worst that can happen is that the cpu's LLC becomes coarser than reality.
+ */
+static const struct cpumask *cpu_llc_mask(int cpu, struct cpumask *fallbacks)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+
+	if (!ci || !ci->info_list || !ci->num_leaves) {
+		cpumask_set_cpu(cpu, fallbacks);
+		return cpumask_of_node(cpu_to_node(cpu));
+	}
+	return &ci->info_list[ci->num_leaves - 1].shared_cpu_map;
+}
+
+/* Allocate the cid tables once on first enable; never freed. */
+static s32 scx_cid_arrays_alloc(void)
+{
+	u32 npossible = num_possible_cpus();
+	s16 *cid_to_cpu, *cpu_to_cid;
+	struct scx_cid_topo *cid_topo;
+
+	if (scx_cid_to_cpu_tbl)
+		return 0;
+
+	cid_to_cpu = kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL);
+	cpu_to_cid = kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL);
+	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
+
+	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
+		kfree(cid_to_cpu);
+		kfree(cpu_to_cid);
+		kfree(cid_topo);
+		return -ENOMEM;
+	}
+
+	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
+	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
+	WRITE_ONCE(scx_cid_topo, cid_topo);
+	return 0;
+}
+
+/**
+ * scx_cid_init - build the cid mapping
+ * @sch: the scx_sched being initialized; used as the scx_error() target
+ *
+ * See "Topological CPU IDs" in ext_cid.h for the model. Walk online cpus by
+ * intersection at each level (parent_scratch & this_level_mask), which keeps
+ * containment correct by construction and naturally splits a physical LLC
+ * straddling two NUMA nodes into two LLC units. The caller must hold
+ * cpus_read_lock.
+ */
+s32 scx_cid_init(struct scx_sched *sch)
+{
+	cpumask_var_t to_walk __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t node_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t llc_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t core_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t llc_fallback __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	u32 next_cid = 0;
+	s32 next_node_idx = 0, next_llc_idx = 0, next_core_idx = 0;
+	s32 cpu, ret;
+
+	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
+	BUILD_BUG_ON(NR_CPUS > 8192);
+
+	lockdep_assert_cpus_held();
+
+	ret = scx_cid_arrays_alloc();
+	if (ret)
+		return ret;
+
+	if (!zalloc_cpumask_var(&to_walk, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&node_scratch, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&llc_scratch, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&core_scratch, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&llc_fallback, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&online_no_topo, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* -1 sentinels for sparse-possible cpu id holes (0 is a valid cid) */
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		scx_cpu_to_cid_tbl[cpu] = -1;
+
+	cpumask_copy(to_walk, cpu_online_mask);
+
+	while (!cpumask_empty(to_walk)) {
+		s32 next_cpu = cpumask_first(to_walk);
+		s32 nid = cpu_to_node(next_cpu);
+		s32 node_cid = next_cid;
+		s32 node_idx;
+
+		/*
+		 * No NUMA info: skip and let the tail loop assign a no-topo
+		 * cid. cpumask_of_node(-1) is undefined.
+		 */
+		if (nid < 0) {
+			cpumask_clear_cpu(next_cpu, to_walk);
+			continue;
+		}
+
+		node_idx = next_node_idx++;
+
+		/* node_scratch = to_walk & this node */
+		cpumask_and(node_scratch, to_walk, cpumask_of_node(nid));
+		if (WARN_ON_ONCE(!cpumask_test_cpu(next_cpu, node_scratch)))
+			return -EINVAL;
+
+		while (!cpumask_empty(node_scratch)) {
+			s32 ncpu = cpumask_first(node_scratch);
+			const struct cpumask *llc_mask = cpu_llc_mask(ncpu, llc_fallback);
+			s32 llc_cid = next_cid;
+			s32 llc_idx = next_llc_idx++;
+
+			/* llc_scratch = node_scratch & this llc */
+			cpumask_and(llc_scratch, node_scratch, llc_mask);
+			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, llc_scratch)))
+				return -EINVAL;
+
+			while (!cpumask_empty(llc_scratch)) {
+				s32 lcpu = cpumask_first(llc_scratch);
+				const struct cpumask *sib = topology_sibling_cpumask(lcpu);
+				s32 core_cid = next_cid;
+				s32 core_idx = next_core_idx++;
+				s32 ccpu;
+
+				/* core_scratch = llc_scratch & this core */
+				cpumask_and(core_scratch, llc_scratch, sib);
+				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, core_scratch)))
+					return -EINVAL;
+
+				for_each_cpu(ccpu, core_scratch) {
+					s32 cid = next_cid++;
+
+					scx_cid_to_cpu_tbl[cid] = ccpu;
+					scx_cpu_to_cid_tbl[ccpu] = cid;
+					scx_cid_topo[cid] = (struct scx_cid_topo){
+						.core_cid = core_cid,
+						.core_idx = core_idx,
+						.llc_cid = llc_cid,
+						.llc_idx = llc_idx,
+						.node_cid = node_cid,
+						.node_idx = node_idx,
+					};
+
+					cpumask_clear_cpu(ccpu, llc_scratch);
+					cpumask_clear_cpu(ccpu, node_scratch);
+					cpumask_clear_cpu(ccpu, to_walk);
+				}
+			}
+		}
+	}
+
+	/*
+	 * No-topo section: any possible cpu without a cid - normally just the
+	 * not-online ones. Collect any currently-online cpus that land here in
+	 * @online_no_topo so we can warn about them at the end.
+	 */
+	for_each_cpu(cpu, cpu_possible_mask) {
+		s32 cid;
+
+		if (__scx_cpu_to_cid(cpu) != -1)
+			continue;
+		if (cpu_online(cpu))
+			cpumask_set_cpu(cpu, online_no_topo);
+
+		cid = next_cid++;
+		scx_cid_to_cpu_tbl[cid] = cpu;
+		scx_cpu_to_cid_tbl[cpu] = cid;
+		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
+	}
+
+	if (!cpumask_empty(llc_fallback))
+		pr_warn("scx_cid: cpus without cacheinfo, using node mask as llc: %*pbl\n",
+			cpumask_pr_args(llc_fallback));
+	if (!cpumask_empty(online_no_topo))
+		pr_warn("scx_cid: online cpus with no usable topology: %*pbl\n",
+			cpumask_pr_args(online_no_topo));
+
+	return 0;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_cid_to_cpu - Return the raw CPU id for @cid
+ * @cid: cid to look up
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Return the raw CPU id for @cid. Trigger scx_error() and return -EINVAL if
+ * @cid is invalid. The cid<->cpu mapping is static for the lifetime of the
+ * loaded scheduler, so the BPF side can cache the result to avoid repeated
+ * kfunc invocations.
+ */
+__bpf_kfunc s32 scx_bpf_cid_to_cpu(s32 cid, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return -EINVAL;
+	return scx_cid_to_cpu(sch, cid);
+}
+
+/**
+ * scx_bpf_cpu_to_cid - Return the cid for @cpu
+ * @cpu: cpu to look up
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Return the cid for @cpu. Trigger scx_error() and return -EINVAL if @cpu is
+ * invalid. The cid<->cpu mapping is static for the lifetime of the loaded
+ * scheduler, so the BPF side can cache the result to avoid repeated kfunc
+ * invocations.
+ */
+__bpf_kfunc s32 scx_bpf_cpu_to_cid(s32 cpu, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return -EINVAL;
+	return scx_cpu_to_cid(sch, cpu);
+}
+
+/**
+ * scx_bpf_cid_topo - Copy out per-cid topology info
+ * @cid: cid to look up
+ * @out__uninit: where to copy the topology info; fully written by this call
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Fill @out__uninit with the topology info for @cid. Trigger scx_error() if
+ * @cid is out of range. If @cid is valid but in the no-topo section, all fields
+ * are set to -1.
+ */
+__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
+				  const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch) || !cid_valid(sch, cid)) {
+		*out__uninit = SCX_CID_TOPO_NEG;
+		return;
+	}
+
+	*out__uninit = READ_ONCE(scx_cid_topo)[cid];
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_cid)
+BTF_ID_FLAGS(func, scx_bpf_cid_to_cpu, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpu_to_cid, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cid_topo, KF_IMPLICIT_ARGS)
+BTF_KFUNCS_END(scx_kfunc_ids_cid)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_cid = {
+	.owner	= THIS_MODULE,
+	.set	= &scx_kfunc_ids_cid,
+};
+
+int scx_cid_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_cid) ?:
+		register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_cid) ?:
+		register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_cid);
+}
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
new file mode 100644
index 000000000000..1dbe8262ccdd
--- /dev/null
+++ b/kernel/sched/ext_cid.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Topological CPU IDs (cids)
+ * --------------------------
+ *
+ * Raw cpu numbers are clumsy for sharding work and communication across
+ * topology units, especially from BPF: the space can be sparse, numerical
+ * closeness doesn't imply topological closeness (x86 hyperthreading often puts
+ * SMT siblings far apart), and a range of cpu ids doesn't mean anything.
+ * Sub-scheds make this acute - cpu allocation, revocation and other state are
+ * constantly communicated across sub-scheds, and passing whole cpumasks scales
+ * poorly with cpu count. cpumasks are also awkward in BPF: a variable-length
+ * kernel type sized for the maximum NR_CPUS (4k), with verbose helper sequences
+ * for every op.
+ *
+ * cids give every cpu a dense, topology-ordered id. CPUs sharing a core, LLC or
+ * NUMA node get contiguous cid ranges, so a topology unit becomes a (start,
+ * length) slice of cid space. Communication can pass a slice instead of a
+ * cpumask, and BPF code can process, for example, a u64 word's worth of cids at
+ * a time.
+ *
+ * The mapping is built once at root scheduler enable time by walking the
+ * topology of online cpus only. Going by online cpus is out of necessity:
+ * depending on the arch, topology info isn't reliably available for offline
+ * cpus. The expected usage model is restarting the scheduler on hotplug events
+ * so the mapping is rebuilt against the new online set. A scheduler that wants
+ * to handle hotplug without a restart can provide its own cid and shard mapping
+ * through the override interface.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef _KERNEL_SCHED_EXT_CID_H
+#define _KERNEL_SCHED_EXT_CID_H
+
+struct scx_sched;
+
+/*
+ * Cid space (total is always num_possible_cpus()) is laid out with
+ * topology-annotated cids first, then no-topo cids at the tail. The
+ * topology-annotated block covers the cpus that were online when scx_cid_init()
+ * ran and remains valid even after those cpus go offline. The tail block covers
+ * possible-but-not-online cpus and carries all-(-1) topo info (see
+ * scx_cid_topo); callers detect it via the -1 sentinels.
+ *
+ * See the comment above the table definitions in ext_cid.c for the
+ * memory-ordering and visibility contract.
+ */
+extern s16 *scx_cid_to_cpu_tbl;
+extern s16 *scx_cpu_to_cid_tbl;
+extern struct scx_cid_topo *scx_cid_topo;
+
+s32 scx_cid_init(struct scx_sched *sch);
+int scx_cid_kfunc_init(void);
+
+/**
+ * cid_valid - Verify a cid value, to be used on ops input args
+ * @sch: scx_sched to abort on error
+ * @cid: cid which came from a BPF ops
+ *
+ * Return true if @cid is in [0, num_possible_cpus()). On failure, trigger
+ * scx_error() and return false.
+ */
+static inline bool cid_valid(struct scx_sched *sch, s32 cid)
+{
+	if (likely(cid >= 0 && cid < num_possible_cpus()))
+		return true;
+	scx_error(sch, "invalid cid %d", cid);
+	return false;
+}
+
+/**
+ * __scx_cid_to_cpu - Unchecked cid->cpu table lookup
+ * @cid: cid to look up. Must be in [0, num_possible_cpus()).
+ *
+ * Intended for callsites that have already validated @cid and that hold a
+ * non-NULL @sch from scx_prog_sched() - a live sched implies the table has
+ * been allocated, so no NULL check is needed here.
+ */
+static inline s32 __scx_cid_to_cpu(s32 cid)
+{
+	/* READ_ONCE pairs with WRITE_ONCE in scx_cid_arrays_alloc() */
+	return READ_ONCE(scx_cid_to_cpu_tbl)[cid];
+}
+
+/**
+ * __scx_cpu_to_cid - Unchecked cpu->cid table lookup
+ * @cpu: cpu to look up. Must be a valid possible cpu id.
+ *
+ * Same usage constraints as __scx_cid_to_cpu().
+ */
+static inline s32 __scx_cpu_to_cid(s32 cpu)
+{
+	return READ_ONCE(scx_cpu_to_cid_tbl)[cpu];
+}
+
+/**
+ * scx_cid_to_cpu - Translate @cid to its cpu
+ * @sch: scx_sched for error reporting
+ * @cid: cid to look up
+ *
+ * Return the cpu for @cid or a negative errno on failure. Invalid cid triggers
+ * scx_error() on @sch. The cid arrays are allocated on first scheduler enable
+ * and never freed, so the returned cpu is stable for the lifetime of the loaded
+ * scheduler.
+ */
+static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
+{
+	if (!cid_valid(sch, cid))
+		return -EINVAL;
+	return __scx_cid_to_cpu(cid);
+}
+
+/**
+ * scx_cpu_to_cid - Translate @cpu to its cid
+ * @sch: scx_sched for error reporting
+ * @cpu: cpu to look up
+ *
+ * Return the cid for @cpu or a negative errno on failure. Invalid cpu triggers
+ * scx_error() on @sch. Same lifetime guarantee as scx_cid_to_cpu().
+ */
+static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
+{
+	if (!scx_cpu_valid(sch, cpu, NULL))
+		return -EINVAL;
+	return __scx_cpu_to_cid(cpu);
+}
+
+#endif /* _KERNEL_SCHED_EXT_CID_H */
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
index 19299ec3920e..be4d3565ae8d 100644
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
@@ -40,4 +40,27 @@ enum scx_consts {
 	SCX_SUB_MAX_DEPTH		= 4,
 };
 
+/*
+ * Per-cid topology info. For each topology level (core, LLC, node), records
+ * the first cid in the unit and its global index. Global indices are
+ * consecutive integers assigned in cid-walk order, so e.g. core_idx ranges
+ * over [0, nr_cores_at_init) with no gaps. No-topo cids have all fields set
+ * to -1.
+ *
+ * @core_cid: first cid of this cid's core (smt-sibling group)
+ * @core_idx: global index of that core, in [0, nr_cores_at_init)
+ * @llc_cid: first cid of this cid's LLC
+ * @llc_idx: global index of that LLC, in [0, nr_llcs_at_init)
+ * @node_cid: first cid of this cid's NUMA node
+ * @node_idx: global index of that node, in [0, nr_nodes_at_init)
+ */
+struct scx_cid_topo {
+	s32 core_cid;
+	s32 core_idx;
+	s32 llc_cid;
+	s32 llc_idx;
+	s32 node_cid;
+	s32 node_idx;
+};
+
 #endif /* _KERNEL_SCHED_EXT_TYPES_H */
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 67b4b179b422..18f823d424cc 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -102,6 +102,9 @@ struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
+s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
+s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
+void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
-- 
2.54.0

