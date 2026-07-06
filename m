Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0037C0FD;
	Mon,  6 Jul 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302077; cv=none; b=G+TeXn9QgVGGhg5lhw9KyH72Ywxu8YzSfcLc9wUMtzPmI9/bPiEP+TZJopq3+CfjDhxxV8kjq6uEyHpHXceeI1SAoddpdeUkyzGyd862c8RdfrNAkW3lW5k0ORQPKCdRfmlNgE+CJE571w/35oOkFPq1HqRCNhoXVBClAY5Oaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302077; c=relaxed/simple;
	bh=ejNMiuX3qqQnbyHfM/Z+OKJuFaS8mNjkD6jnWadHoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+j3S02ZC2R7sRgCO08qVckjBZ8FcR09pYHY9gtYkyxbZkIPh0qW56Bm8wI1OfYQ1tPT6J0FeK9b8jLbAZ3h6pyifL/XRyUuPGIdHGKCeBcyBlJ3RBodQDKLKGwgxrmuoHlSw9dCXyG97v+cWPEZmESZCA2K42okPZA6L5eKdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y317rYER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y317rYER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9801D1F00A3D;
	Mon,  6 Jul 2026 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302075;
	bh=j2zyd8Kp3/o5W/DXSbsNPkdtKXewSwLHSA5nmzIkf48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y317rYERAubdv/LxPO+RnHWgiw3z0pXUvdBKuWhi8NzGiJPOHW9Te/pLlyAo+q3Lo
	 yODWmU5D8kHTZ7Xh5+Z4ikq7yX+LYRfe6f44SviryawtNBU+MoisbgGs6yC2ZRsuk5
	 71W49u8n5KSnyU+cUiiF2ioquMBQ+DMfkLsGCO+ykbwQqHhTMlW4PJHsLbJUiXbVLg
	 SFmTvNQ+AhIE0MIJN8KUKP525eNCEJgwOM2dLIQbUGOuIrWt+agMyesEZ6MJde9cxU
	 0IBRRY7vNpmrcDax8Yl/7dM2zz037sJoNDV1vml8biaQsfteBCJHW5yVQcWS3YXIfP
	 67L/277CE1bZA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 16/36] sched_ext: Build the set_cmask scratch from trusted geometry
Date: Sun,  5 Jul 2026 15:40:38 -1000
Message-ID: <20260706014058.439853-17-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_call_op_set_cpumask() builds a per-cpu cmask in the set_cmask scratch,
which lives in BPF-writable arena. A scheduler can corrupt the scratch's
inline header (base, nr_cids, alloc_words) from another cpu, so sizing and
indexing the write from it risks an out-of-bounds write.

Drive the build from kernel-known geometry instead.
scx_cmask_ref_init_kern() imposes base and nr_cids rather than reading them,
and scx_cmask_ref_from_cpumask() fills the scratch from the ref. Neither
reads the header back.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/cid.h |  4 +++
 kernel/sched/ext/ext.c | 11 ++++---
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 42fc8348b3b4..465e4e7b0619 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -948,6 +948,38 @@ int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
 	return 0;
 }
 
+/**
+ * scx_cmask_ref_init_kern - Bind a scx_cmask_ref to a kernel-owned cmask
+ * @sch: scheduler the cmask belongs to
+ * @m: kernel address of the target cmask, storage sized for @nr_cids at @base
+ * @base: first cid of the active range
+ * @nr_cids: active range length
+ * @ref: output ref
+ *
+ * Like scx_cmask_ref_init() but the geometry is supplied by the caller, not
+ * read from @m's header, so a concurrent BPF write to the header can't steer
+ * later sizing or offsets. Rewrite the header from the trusted geometry and
+ * bind @ref to it.
+ */
+void scx_cmask_ref_init_kern(struct scx_sched *sch, struct scx_cmask *m,
+			     u32 base, u32 nr_cids, struct scx_cmask_ref *ref)
+{
+	WRITE_ONCE(m->base, base);
+	WRITE_ONCE(m->nr_cids, nr_cids);
+	WRITE_ONCE(m->alloc_words, SCX_CMASK_NR_WORDS(nr_cids));
+
+	ref->sch = sch;
+	ref->src = m;
+	ref->base = base;
+	ref->nr_cids = nr_cids;
+
+	ref->shard_first = scx_cid_to_shard[base];
+	if (likely(nr_cids))
+		ref->shard_end = scx_cid_to_shard[base + nr_cids - 1] + 1;
+	else
+		ref->shard_end = ref->shard_first;
+}
+
 /**
  * scx_cmask_ref_shard - Read one shard from @ref into @out
  * @ref: validated ref
@@ -1029,6 +1061,44 @@ void scx_cmask_ref_copy(const struct scx_cmask_ref *ref, const struct scx_cmask
 		       src->bits, src->base, src->nr_cids, CMASK_OP2_REF_COPY);
 }
 
+/**
+ * scx_cmask_ref_from_cpumask - Populate @ref's arena cmask from a cpumask
+ * @ref: kern-bound ref, see scx_cmask_ref_init_kern()
+ * @cpumask: cpus to translate into cids
+ *
+ * Write @ref's active range one word at a time, setting each cid's bit when
+ * its cpu is in @cpumask. Offsets and length come from @ref's trusted geometry
+ * and stores use WRITE_ONCE since BPF may read concurrently, so the arena
+ * header is never read.
+ */
+void scx_cmask_ref_from_cpumask(const struct scx_cmask_ref *ref,
+				const struct cpumask *cpumask)
+{
+	struct scx_cmask *m = ref->src;
+	u32 base = ref->base, nr_cids = ref->nr_cids;
+	u32 wi, nr_words;
+
+	if (!nr_cids)
+		return;
+
+	nr_words = (base + nr_cids - 1) / 64 - base / 64 + 1;
+	for (wi = 0; wi < nr_words; wi++) {
+		u32 word_first_cid = (base / 64 + wi) * 64;
+		u64 word = 0;
+		u32 bit;
+
+		for (bit = 0; bit < 64; bit++) {
+			u32 cid = word_first_cid + bit;
+
+			if (cid < base || cid >= base + nr_cids)
+				continue;
+			if (cpumask_test_cpu(__scx_cid_to_cpu(cid), cpumask))
+				word |= BIT_U64(bit);
+		}
+		WRITE_ONCE(m->bits[wi], word);
+	}
+}
+
 int scx_cid_kfunc_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_init_cids) ?:
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 70d97acd0ac4..b36a1a28eac8 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -295,8 +295,12 @@ static inline s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
 
 int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
 		       struct scx_cmask_ref *ref);
+void scx_cmask_ref_init_kern(struct scx_sched *sch, struct scx_cmask *m,
+			     u32 base, u32 nr_cids, struct scx_cmask_ref *ref);
 void scx_cmask_ref_shard(const struct scx_cmask_ref *ref, s32 shard_idx,
 			 struct scx_cmask *out);
+void scx_cmask_ref_from_cpumask(const struct scx_cmask_ref *ref,
+				const struct cpumask *cpumask);
 void scx_cmask_ref_or(const struct scx_cmask_ref *ref, const struct scx_cmask *src);
 void scx_cmask_ref_copy(const struct scx_cmask_ref *ref, const struct scx_cmask *src);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a5e782147bf4..8ee980f822aa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -412,12 +412,15 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 {
 	if (scx_is_cid_type()) {
 		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
+		struct scx_cmask_ref ref;
+
 		/*
-		 * Build the per-CPU arena cmask and hand BPF its arena address.
-		 * Caller holds the rq lock with IRQs disabled, which makes us
-		 * the sole user of the scratch area.
+		 * Build the per-cpu arena cmask from kernel geometry via @ref,
+		 * never reading its BPF-writable header, and hand BPF the arena
+		 * address. The rq lock makes this cpu the sole kernel writer.
 		 */
-		scx_cpumask_to_cmask(cpumask, kern_va);
+		scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
+		scx_cmask_ref_from_cpumask(&ref, cpumask);
 		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
 				     scx_kaddr_to_arena(sch, kern_va));
 	} else {
-- 
2.54.0

