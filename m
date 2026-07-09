Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0523B6368;
	Thu,  9 Jul 2026 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637451; cv=none; b=g2+CFUE8YRCSBgyO85dEZYic4EmgKlrYuOncu34rXSE0LQoEJ6jUpy5gp0s/Eeoz2i34cvBpQRgRJOVIzPaC0xs21QmbSkO1n2x3SxppaEPM6lBcFjWtPqSuC0k4CzxkfOoIGLHVkV8iYfEmcmJMRz8D6BaZe10NSYoCkMrPakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637451; c=relaxed/simple;
	bh=HbmSv8onmZo2Pnn3gUDMKfPSrnlGzeuW+qk2rEmTZwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo/OdeCo1pubMbzl+iqOvNvJ9YpGjKx3T03Vv+DurMLGSHI31B2LmBb03acIK5YFAxJNGD7vLqdsbDgBM5rBfiCEyhGFxxN0868xKkVPG2kKDxEr7/nN35/ygclSbZ68cRFdy+LPZokbpqCMaCbnQa/VviE0KeQvIUZ07fdT+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMuC4hnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMuC4hnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6821F000E9;
	Thu,  9 Jul 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637448;
	bh=rZuzmYbnSLdJwh6lFictImCK9zbtRAxaqcyZ5rsUwo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMuC4hnSpCB4LzbljPb88L90wh3ZsiAt0rqY5HTpJ0bf1voD0s7l+FTLnBSX0E9XW
	 GAc7NqD7E1r3cZkiKnyVgAxvJVbfSI3RHFoGjj4opO5wKdNAC5rqFGNwdGmQBQTvIL
	 MjaUL9usW2MFjWFYy8hYbNfuriMHLLfSvRBXhxDIMOBHOU+qODcyF+oKjKtDkrb3AN
	 aiW1wkHDToJXz/gbT0BD4Ft8mHe1/JXNgmqvA5pa90QeB5vnyUkaWojRg2GsUcWpSF
	 fMCiMAOBxr0PzNIoCOEFyDvSogIp4FQgGBkSrUisTkQ1K9sSQIyGfVLvh2PRNG1j1k
	 wQ3Dw1EWMjuKQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 05/33] sched_ext: Add shard boundaries to scx_bpf_cid_override()
Date: Thu,  9 Jul 2026 12:50:13 -1000
Message-ID: <20260709225041.1695495-6-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An overridden cid mapping invalidates the auto-generated shard layout, so
the override call has to provide both. Extend scx_bpf_cid_override() with a
shard_start[] array that lists the first cid of each shard (starting at 0,
strictly increasing, last shard implicitly extends to num_possible_cpus()).

A scheduler that wants only custom shards with the auto-generated cid
mapping can read the current mapping and pass it back unchanged.

Overridden shards can span NUMA nodes, so scx_shard_node[] is rebuilt by
majority count: each shard is assigned to the node that owns the most cpus
in it.

v2: Snapshot the caller's cpu_to_cid/shard_start arrays before validating. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c                   | 154 ++++++++++++++++++++---
 tools/sched_ext/include/scx/compat.bpf.h |  11 +-
 tools/sched_ext/scx_qmap.bpf.c           |  16 ++-
 tools/sched_ext/scx_qmap.c               |  34 ++++-
 tools/sched_ext/scx_qmap.h               |   1 +
 5 files changed, 187 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index f3c54f4223b4..6a22bead4c60 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -392,29 +392,66 @@ void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst)
 	}
 }
 
+/*
+ * Return the index of the largest entry in @counts, or NUMA_NO_NODE if all
+ * entries are zero. Ties resolve to the lowest index.
+ */
+static s32 pick_max_node(const u32 *counts, u32 n)
+{
+	s32 best = NUMA_NO_NODE;
+	u32 best_count = 0, i;
+
+	for (i = 0; i < n; i++) {
+		if (counts[i] > best_count) {
+			best_count = counts[i];
+			best = i;
+		}
+	}
+	return best;
+}
+
 __bpf_kfunc_start_defs();
 
 /**
- * scx_bpf_cid_override - Install an explicit cpu->cid mapping
- * @cpu_to_cid: array of nr_cpu_ids s32 entries (cid for each cpu)
- * @cpu_to_cid__sz: must be nr_cpu_ids * sizeof(s32) bytes
+ * scx_bpf_cid_override - Install an explicit cpu->cid mapping with shard info
+ * @cpu_to_cid_src: array of nr_cpu_ids s32 entries (cid for each cpu)
+ * @cpu_to_cid_src__sz: must be nr_cpu_ids * sizeof(s32) bytes
+ * @shard_start_src: array of first-cid-of-each-shard, strictly increasing from 0
+ * @shard_start_src__sz: nr_shards * sizeof(s32) bytes
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * May only be called from ops.init_cids() of the root scheduler. Replace the
- * topology-probed cid mapping with the caller-provided one. Each possible cpu
- * must map to a unique cid in [0, num_possible_cpus()). Topo info is cleared.
- * On invalid input, trigger scx_error() to abort the scheduler.
+ * topology-probed cid mapping and shard layout with caller-provided ones. Each
+ * possible cpu must map to a unique cid in [0, num_possible_cpus()). The shard
+ * starts must be strictly increasing with the first entry 0 and all values <
+ * num_possible_cpus(). The last shard extends to num_possible_cpus() and no
+ * shard may span more than SCX_CID_SHARD_MAX_CPUS cids. Topo info
+ * (core/LLC/node) is cleared and the shard layout is set from the input. On
+ * invalid input, abort the scheduler.
  */
-__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
-				      const struct bpf_prog_aux *aux)
+__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid_src, u32 cpu_to_cid_src__sz,
+				       const s32 *shard_start_src, u32 shard_start_src__sz,
+				       const struct bpf_prog_aux *aux)
 {
 	cpumask_var_t seen __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	u32 *node_counts __free(kfree) = NULL;
+	s32 *cpu_to_cid __free(kfree) = NULL;
+	s32 *shard_start __free(kfree) = NULL;
+	u32 npossible = num_possible_cpus();
 	struct scx_sched *sch;
+	u32 nr_shards;
 	bool alloced;
-	s32 cpu, cid;
+	s32 cpu, cid, si;
 
-	/* GFP_KERNEL alloc must happen before the rcu read section */
+	/*
+	 * GFP_KERNEL allocs must happen before the rcu read section. Snapshot
+	 * the BPF-supplied arrays so a concurrent map mutation can't change
+	 * them between validation and use.
+	 */
 	alloced = zalloc_cpumask_var(&seen, GFP_KERNEL);
+	node_counts = kcalloc(nr_node_ids, sizeof(*node_counts), GFP_KERNEL);
+	cpu_to_cid = kmemdup(cpu_to_cid_src, cpu_to_cid_src__sz, GFP_KERNEL);
+	shard_start = kmemdup(shard_start_src, shard_start_src__sz, GFP_KERNEL);
 
 	guard(rcu)();
 
@@ -422,17 +459,57 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
 	if (unlikely(!sch))
 		return;
 
-	if (!alloced) {
-		scx_error(sch, "scx_bpf_cid_override: failed to allocate cpumask");
+	if (!alloced || !node_counts || !cpu_to_cid || !shard_start) {
+		scx_error(sch, "scx_bpf_cid_override: allocation failed");
 		return;
 	}
 
-	if (cpu_to_cid__sz != nr_cpu_ids * sizeof(s32)) {
-		scx_error(sch, "scx_bpf_cid_override: expected %zu bytes, got %u",
-			  nr_cpu_ids * sizeof(s32), cpu_to_cid__sz);
+	if (cpu_to_cid_src__sz != nr_cpu_ids * sizeof(s32)) {
+		scx_error(sch, "scx_bpf_cid_override: cpu_to_cid expected %zu bytes, got %u",
+			  nr_cpu_ids * sizeof(s32), cpu_to_cid_src__sz);
+		return;
+	}
+
+	if (!shard_start_src__sz || shard_start_src__sz % sizeof(s32)) {
+		scx_error(sch, "scx_bpf_cid_override: invalid shard_start size %u",
+			  shard_start_src__sz);
+		return;
+	}
+
+	nr_shards = shard_start_src__sz / sizeof(s32);
+
+	/* validate shard_start[]: starts at 0, strictly increasing, in range */
+	if (shard_start[0] != 0) {
+		scx_error(sch, "scx_bpf_cid_override: shard_start[0] must be 0, got %d",
+			  shard_start[0]);
+		return;
+	}
+	for (si = 1; si < nr_shards; si++) {
+		if (shard_start[si] <= shard_start[si - 1]) {
+			scx_error(sch, "scx_bpf_cid_override: shard_start not increasing at [%d]",
+				  si);
+			return;
+		}
+		if (shard_start[si] >= npossible) {
+			scx_error(sch, "scx_bpf_cid_override: shard_start[%d]=%d >= %u",
+				  si, shard_start[si], npossible);
+			return;
+		}
+		if (shard_start[si] - shard_start[si - 1] > SCX_CID_SHARD_MAX_CPUS) {
+			scx_error(sch, "scx_bpf_cid_override: shard[%d] span %d exceeds max %d",
+				  si - 1, shard_start[si] - shard_start[si - 1],
+				  SCX_CID_SHARD_MAX_CPUS);
+			return;
+		}
+	}
+	if (npossible - shard_start[nr_shards - 1] > SCX_CID_SHARD_MAX_CPUS) {
+		scx_error(sch, "scx_bpf_cid_override: shard[%d] span %d exceeds max %d",
+			  nr_shards - 1, npossible - shard_start[nr_shards - 1],
+			  SCX_CID_SHARD_MAX_CPUS);
 		return;
 	}
 
+	/* Validate first so that invalid input leaves globals untouched. */
 	for_each_possible_cpu(cpu) {
 		s32 c = cpu_to_cid[cpu];
 
@@ -442,13 +519,56 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
 			scx_error(sch, "cid %d assigned to multiple cpus", c);
 			return;
 		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		s32 c = cpu_to_cid[cpu];
+
 		scx_cpu_to_cid_tbl[cpu] = c;
 		scx_cid_to_cpu_tbl[c] = cpu;
 	}
 
-	/* Invalidate stale topo info - the override carries no topology. */
-	for (cid = 0; cid < num_possible_cpus(); cid++)
+	/*
+	 * Derive scx_shard_node[] by majority count: an overridden shard may
+	 * span NUMA nodes, so assign each to the node that owns the most cpus.
+	 */
+	for (si = 0; si < nr_shards; si++) {
+		u32 end = (si + 1 < nr_shards) ? shard_start[si + 1] : npossible;
+
+		memset(node_counts, 0, nr_node_ids * sizeof(*node_counts));
+		for (cid = shard_start[si]; cid < end; cid++) {
+			s32 node = cpu_to_node(scx_cid_to_cpu_tbl[cid]);
+
+			if (numa_valid_node(node))
+				node_counts[node]++;
+		}
+		scx_shard_node[si] = pick_max_node(node_counts, nr_node_ids);
+	}
+
+	/*
+	 * Invalidate stale topo info and install shard layout from
+	 * @shard_start. Walk shards to derive shard_cid/shard_idx for each cid.
+	 */
+	si = 0;
+	for (cid = 0; cid < npossible; cid++) {
+		if (si + 1 < nr_shards && cid >= shard_start[si + 1])
+			si++;
+		scx_cid_to_shard[cid] = si;
 		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
+		scx_cid_topo[cid].shard_cid = shard_start[si];
+		scx_cid_topo[cid].shard_idx = si;
+	}
+
+	/* Rebuild scx_cid_shard_ranges[] for the new layout. */
+	memset(scx_cid_shard_ranges, 0, npossible * sizeof(*scx_cid_shard_ranges));
+	for (si = 0; si < nr_shards; si++) {
+		u32 end = (si + 1 < nr_shards) ? shard_start[si + 1] : npossible;
+
+		scx_cid_shard_ranges[si].base_cid = shard_start[si];
+		scx_cid_shard_ranges[si].nr_cids = end - shard_start[si];
+	}
+
+	scx_nr_cid_shards = nr_shards;
 }
 
 /**
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 133058578668..cf469d5ff9ca 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -122,15 +122,18 @@ static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
 }
 
 /*
- * v7.2: scx_bpf_cid_override() for explicit cpu->cid mapping. Ignore if
+ * v7.3: scx_bpf_cid_override() for explicit cid and shard mapping. Ignore if
  * missing.
  */
-void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid__sz) __ksym __weak;
+void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
+				    const s32 *shard_start, u32 shard_start__sz) __ksym __weak;
 
-static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz)
+static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
+					 const s32 *shard_start, u32 shard_start__sz)
 {
 	if (bpf_ksym_exists(scx_bpf_cid_override___compat))
-		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
+		scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz,
+					      shard_start, shard_start__sz);
 }
 
 /**
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 2df7c53992dc..f6cfe63425d3 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -54,18 +54,20 @@ const volatile u32 max_tasks;
 
 /*
  * Optional cid-override test harness. When cid_override_mode is non-zero,
- * qmap_init_cids() calls scx_bpf_cid_override() with the caller-supplied
- * cpu_to_cid array to exercise the kfunc's acceptance and error paths. See enum
+ * qmap_init_cids() calls scx_bpf_cid_override() with the caller-supplied arrays
+ * to exercise the kfunc's acceptance and error paths. See enum
  * qmap_cid_override for the modes.
  */
 const volatile u32 cid_override_mode;
+const volatile u32 cid_override_nr_shards;
 /*
- * Array lives in bss (writable) because scx_bpf_cid_override()'s BPF
- * verifier signature treats its len-paired pointer as read/write - rodata
+ * Arrays live in bss (writable) because scx_bpf_cid_override()'s BPF
+ * verifier signature treats its len-paired pointers as read/write - rodata
  * fails verification with "write into map forbidden". Userspace populates
- * it before SCX_OPS_LOAD, same as rodata, and nothing writes it after.
+ * them before SCX_OPS_LOAD, same as rodata, and nothing writes them after.
  */
 s32 cid_override_cpu_to_cid[SCX_QMAP_MAX_CPUS];
+s32 cid_override_shard_start[SCX_QMAP_MAX_CPUS];
 
 UEI_DEFINE(uei);
 
@@ -1082,7 +1084,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_cids)
 	}
 
 	scx_bpf_cid_override((const s32 *)cid_override_cpu_to_cid,
-			     nr_cpu_ids * sizeof(s32));
+			     nr_cpu_ids * sizeof(s32),
+			     (const s32 *)cid_override_shard_start,
+			     cid_override_nr_shards * sizeof(s32));
 	return 0;
 }
 
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index c0b5cab579d6..9124183bffec 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -43,7 +43,7 @@ const char help_fmt[] =
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
-"  -C MODE       cid-override test (shuffle|bad-dup|bad-range)\n"
+"  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -155,6 +155,7 @@ int main(int argc, char **argv)
 		case 'C': {
 			u32 nr_cpus = libbpf_num_possible_cpus();
 			u32 mode, i;
+			s32 shard_sz = 4;
 
 			if (!strcmp(optarg, "shuffle"))
 				mode = QMAP_CID_OVR_SHUFFLE;
@@ -162,13 +163,15 @@ int main(int argc, char **argv)
 				mode = QMAP_CID_OVR_BAD_DUP;
 			else if (!strcmp(optarg, "bad-range"))
 				mode = QMAP_CID_OVR_BAD_RANGE;
+			else if (!strcmp(optarg, "bad-mono"))
+				mode = QMAP_CID_OVR_BAD_MONO;
 			else {
 				fprintf(stderr, "unknown cid-override mode '%s'\n", optarg);
 				return 1;
 			}
 			skel->rodata->cid_override_mode = mode;
 
-			/* shuffle: reversed cpu_to_cid, bad-dup: dup cid 0, bad-range: identity */
+			/* shuffle: reversed cpu_to_cid; others: identity */
 			for (i = 0; i < nr_cpus; i++) {
 				if (mode == QMAP_CID_OVR_SHUFFLE)
 					skel->bss->cid_override_cpu_to_cid[i] = nr_cpus - 1 - i;
@@ -179,6 +182,33 @@ int main(int argc, char **argv)
 				skel->bss->cid_override_cpu_to_cid[1] = 0;
 			if (mode == QMAP_CID_OVR_BAD_RANGE)
 				skel->bss->cid_override_cpu_to_cid[0] = (s32)nr_cpus;
+
+			/*
+			 * bad-mono needs >= 3 shards to build a 0-based but
+			 * non-monotonic shard_start. Shrink the shard size so
+			 * the test runs on any machine with >= 3 cpus.
+			 */
+			if (mode == QMAP_CID_OVR_BAD_MONO) {
+				if (nr_cpus < 3) {
+					fprintf(stderr, "bad-mono needs >= 3 cpus (have %u)\n",
+						nr_cpus);
+					return 1;
+				}
+				shard_sz = nr_cpus / 3;
+			}
+
+			/* shards of shard_sz each */
+			skel->rodata->cid_override_nr_shards = (nr_cpus + shard_sz - 1) / shard_sz;
+			for (i = 0; i < skel->rodata->cid_override_nr_shards; i++)
+				skel->bss->cid_override_shard_start[i] = i * shard_sz;
+
+			if (mode == QMAP_CID_OVR_BAD_MONO) {
+				/* swap [1] and [2] to break monotonicity */
+				s32 tmp = skel->bss->cid_override_shard_start[1];
+				skel->bss->cid_override_shard_start[1] =
+					skel->bss->cid_override_shard_start[2];
+				skel->bss->cid_override_shard_start[2] = tmp;
+			}
 			break;
 		}
 		case 'v':
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 3bcc3579839d..6c3ea1fc74ed 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -33,6 +33,7 @@ enum qmap_cid_override {
 	QMAP_CID_OVR_SHUFFLE	= 1,	/* valid reversed cpu->cid mapping */
 	QMAP_CID_OVR_BAD_DUP	= 2,	/* invalid: duplicate cid assignment */
 	QMAP_CID_OVR_BAD_RANGE	= 3,	/* invalid: out-of-range cid */
+	QMAP_CID_OVR_BAD_MONO	= 4,	/* invalid: non-monotonic shard_start */
 };
 
 struct cpu_ctx {
-- 
2.55.0

