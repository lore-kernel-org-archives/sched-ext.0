Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CB37E2F7;
	Fri,  3 Jul 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065735; cv=none; b=eA+4X9sdF+GsZnSMp95B+G6Pgs8l70D9qsXxfIskgb5eF/f5VHljTeNrzhJwl9qFDrB4sAoQYzESpGKwUjPuooJdT5fPqcAsBGb7/Qg+frhTIueb3erXgL7NA7DeNqPIML0gceCCCNevbsskgWL0UASBImDu5iq7DMVRGn8Ghe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065735; c=relaxed/simple;
	bh=ghtkTWHL8mmrcA25JWKv/5xKe4Im9Ro2LdGhTrfqwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEpYBEcqevND62/q9E8mF6wpClwwiyU1kefLIgCKPlGZyNgDuDRKTmyl9jZWeKqWZY71XEI/ZLQ9609CQmtfqKe561r9ZVT+n50TQB7orfPQun/UJ/kJhS4UGlJ7mGl54ZBzS8XEh8cdgfZkckZO5lP8g6F7jLFAwD/7UZEIBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWxDjeRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWxDjeRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594401F000E9;
	Fri,  3 Jul 2026 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065733;
	bh=sizMu9SgVLEAF5HeQz+VR+75VTVlEtbCKA0qY2LIHNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWxDjeRF18KMXn3SyMeq4p3AVbdr9jnjncn5hS7Ei/CoXc90HSFstDlTYlmyADVha
	 vT8GMjcl6vMBVejmT4Z8xEkF6kC1G/+1FsbjcJIbN4xKgNNqUT3GpjOV8u+dFRZJcH
	 IZtptANQOs6wevFe1MFkW1zm1ydftE1A99NRxueExvwJ3wgamgiOgjVZeGYJqkARZd
	 Zvj5buRf3KfPVFQWDpEQJzvIAc42WstMj8BnkCXjd9ImoeBk392GDXugiAXemJIXXm
	 hmSK3XoOtZS9sM42nYVZeyZKVzirPxbLjOhl79THt5htfrrXAdzwmBnksQsVhPXIfc
	 oICYB0D+bg3MA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 13/32] sched_ext: Add scx_cmask_ref for validated arena cmask access
Date: Thu,  2 Jul 2026 22:01:40 -1000
Message-ID: <20260703080159.2314350-14-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfuncs taking struct scx_cmask * from BPF arena memory have two problems.
The pointer can be any value the BPF prog hands in, and the header (@base
and @nr_cids) can be mutated by the prog concurrently with kernel access.

Add scx_cmask_ref, a validated handle. _init() normalizes the input pointer
into the arena's kern_vm range via scx_arena_to_kaddr() and snapshots
@base/@nr_cids; downstream sizing uses the snapshot, not the live header.
_shard() reads slices, _or() / _copy() write back; all bounded by the
snapshot. No callers yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c   | 130 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/cid.h   |   7 +++
 kernel/sched/ext/types.h |  37 +++++++++++
 3 files changed, 174 insertions(+)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index bd0467e8a8d2..7325ad04c386 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -633,6 +633,12 @@ enum cmask_op2 {
 	/* predicates - short-circuit when the per-word result is true */
 	CMASK_OP2_SUBSET,
 	CMASK_OP2_INTERSECTS,
+	/*
+	 * @a is a BPF-arena cmask. Words on @a use READ_ONCE/WRITE_ONCE since
+	 * BPF may read/write concurrently. See scx_cmask_ref_or() / _copy().
+	 */
+	CMASK_OP2_REF_OR,
+	CMASK_OP2_REF_COPY,
 };
 
 static __always_inline bool cmask_op2_is_pred(const enum cmask_op2 op)
@@ -661,6 +667,12 @@ static __always_inline bool cmask_word_op2(u64 *av, const u64 *bp, u64 mask,
 		return (READ_ONCE(*bp) & ~READ_ONCE(*av)) & mask;
 	case CMASK_OP2_INTERSECTS:
 		return (READ_ONCE(*av) & READ_ONCE(*bp)) & mask;
+	case CMASK_OP2_REF_OR:
+		WRITE_ONCE(*av, READ_ONCE(*av) | (READ_ONCE(*bp) & mask));
+		return false;
+	case CMASK_OP2_REF_COPY:
+		WRITE_ONCE(*av, (READ_ONCE(*av) & ~mask) | (READ_ONCE(*bp) & mask));
+		return false;
 	}
 	unreachable();
 }
@@ -891,6 +903,124 @@ static const struct btf_kfunc_id_set scx_kfunc_set_cid = {
 	.set	= &scx_kfunc_ids_cid,
 };
 
+/**
+ * scx_cmask_ref_init - Bind a scx_cmask_ref to a BPF-arena cmask
+ * @sch: scheduler whose arena hosts @src
+ * @src: BPF-supplied cmask pointer
+ * @ref: output ref
+ *
+ * Snapshot @src's @base and @nr_cids. The snapshot is necessary because BPF may
+ * mutate the live header asynchronously.
+ *
+ * Return 0 on success, -EINVAL if the snapshotted header is malformed.
+ */
+int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
+		       struct scx_cmask_ref *ref)
+{
+	struct scx_cmask *kern_src = scx_arena_to_kaddr(sch, src);
+	u32 base, nr_cids, npossible = num_possible_cpus();
+
+	base = READ_ONCE(kern_src->base);
+	nr_cids = READ_ONCE(kern_src->nr_cids);
+
+	if (unlikely(base >= npossible || nr_cids > npossible - base))
+		return -EINVAL;
+
+	ref->sch = sch;
+	ref->src = kern_src;
+	ref->base = base;
+	ref->nr_cids = nr_cids;
+
+	ref->shard_first = scx_cid_to_shard[base];
+	if (likely(nr_cids))
+		ref->shard_end = scx_cid_to_shard[base + nr_cids - 1] + 1;
+	else
+		ref->shard_end = ref->shard_first;
+
+	return 0;
+}
+
+/**
+ * scx_cmask_ref_shard - Read one shard from @ref into @out
+ * @ref: validated ref
+ * @shard_idx: target shard, in [@ref->shard_first, @ref->shard_end)
+ * @out: output cmask whose @out->alloc_words must hold the shard
+ *
+ * Set @out to the intersection of @ref's range with @shard_idx's cid range,
+ * with bits[] read from @ref->src via READ_ONCE. Empty intersection sets
+ * @out->nr_cids to 0. scx_error()s on @ref's sched if @out can't hold the
+ * shard.
+ */
+void scx_cmask_ref_shard(const struct scx_cmask_ref *ref, s32 shard_idx,
+			 struct scx_cmask *out)
+{
+	const struct scx_cid_shard *shard = &scx_cid_shard_ranges[shard_idx];
+	u32 shard_base = shard->base_cid;
+	u32 shard_end = shard_base + shard->nr_cids;
+	u32 isect_base, isect_end, nr_words, src_off, wi;
+	u64 head_mask, tail_mask;
+
+	isect_base = max(ref->base, shard_base);
+	isect_end = min(ref->base + ref->nr_cids, shard_end);
+
+	if (isect_base >= isect_end) {
+		out->base = shard_base;
+		out->nr_cids = 0;
+		return;
+	}
+
+	nr_words = ((isect_end - 1) / 64) - (isect_base / 64) + 1;
+	if (nr_words > out->alloc_words) {
+		scx_error(ref->sch, "scx_cmask_ref_shard: out alloc_words=%u < %u for shard %d",
+			  out->alloc_words, nr_words, shard_idx);
+		out->base = shard_base;
+		out->nr_cids = 0;
+		return;
+	}
+
+	out->base = isect_base;
+	out->nr_cids = isect_end - isect_base;
+	src_off = (isect_base / 64) - (ref->base / 64);
+
+	for (wi = 0; wi < nr_words; wi++)
+		out->bits[wi] = READ_ONCE(ref->src->bits[src_off + wi]);
+
+	head_mask = GENMASK_U64(63, isect_base & 63);
+	out->bits[0] &= head_mask;
+	tail_mask = GENMASK_U64((isect_end - 1) & 63, 0);
+	out->bits[nr_words - 1] &= tail_mask;
+}
+
+/**
+ * scx_cmask_ref_or - OR @src into the arena cmask referenced by @ref
+ * @ref: validated ref
+ * @src: stable kernel cmask
+ *
+ * Bits inside the intersection of @ref's snapshotted range with @src's range
+ * are OR'd into @ref->src and bits outside are left unchanged. Stores on
+ * @ref->src use WRITE_ONCE since BPF may read/write concurrently.
+ */
+void scx_cmask_ref_or(const struct scx_cmask_ref *ref, const struct scx_cmask *src)
+{
+	cmask_walk_op2(ref->src->bits, ref->base, ref->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_REF_OR);
+}
+
+/**
+ * scx_cmask_ref_copy - Copy @src into the arena cmask referenced by @ref
+ * @ref: validated ref
+ * @src: stable kernel cmask
+ *
+ * Bits inside the intersection of @ref's snapshotted range with @src's range
+ * take @src's values and bits outside are left unchanged. Stores on @ref->src
+ * use WRITE_ONCE since BPF may read/write concurrently.
+ */
+void scx_cmask_ref_copy(const struct scx_cmask_ref *ref, const struct scx_cmask *src)
+{
+	cmask_walk_op2(ref->src->bits, ref->base, ref->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_REF_COPY);
+}
+
 int scx_cid_kfunc_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_init_cids) ?:
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index cdc18a7a48f5..70d97acd0ac4 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -293,4 +293,11 @@ static inline s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
 	return scx_cid_to_cpu(sch, cpu_or_cid);
 }
 
+int scx_cmask_ref_init(struct scx_sched *sch, const struct scx_cmask *src,
+		       struct scx_cmask_ref *ref);
+void scx_cmask_ref_shard(const struct scx_cmask_ref *ref, s32 shard_idx,
+			 struct scx_cmask *out);
+void scx_cmask_ref_or(const struct scx_cmask_ref *ref, const struct scx_cmask *src);
+void scx_cmask_ref_copy(const struct scx_cmask_ref *ref, const struct scx_cmask *src);
+
 #endif /* _KERNEL_SCHED_EXT_CID_H */
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index b31d12931999..98a6e072c33e 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -172,4 +172,41 @@ struct scx_cmask {
 #define SCX_CMASK_DEFINE_SHARD(NAME, BASE, NR_CIDS)				\
 	__SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS, SCX_CID_SHARD_MAX_CPUS)
 
+/*
+ * scx_cmask_ref: validated reference to a BPF-arena cmask.
+ *
+ * scx_cmask_ref_init() normalizes the pointer into the arena and snapshots
+ * @base/@nr_cids. The snapshot is what downstream code uses for sizing - the
+ * live header can be mutated concurrently by BPF.
+ *
+ * scx_cmask_ref_shard() reads one shard into a cmask. scx_cmask_ref_or() and
+ * scx_cmask_ref_copy() write back into the referenced arena cmask, bounded by
+ * the snapshot.
+ *
+ * Typical input use:
+ *
+ *	struct scx_cmask_ref ref;
+ *	SCX_CMASK_DEFINE(shard, 0, SCX_CID_SHARD_MAX_CPUS);
+ *	s32 idx, ret;
+ *
+ *	ret = scx_cmask_ref_init(sch, src, &ref);
+ *	if (ret < 0)
+ *		return ret;
+ *
+ *	for (idx = ref.shard_first; idx < ref.shard_end; idx++) {
+ *		scx_cmask_ref_shard(&ref, idx, shard);
+ *		if (!shard->nr_cids)
+ *			continue;
+ *		... use idx and shard ...
+ *	}
+ */
+struct scx_cmask_ref {
+	struct scx_sched	*sch;
+	struct scx_cmask	*src;
+	u32			base;
+	u32			nr_cids;
+	s32			shard_first;
+	s32			shard_end;
+};
+
 #endif /* _KERNEL_SCHED_EXT_TYPES_H */
-- 
2.54.0

