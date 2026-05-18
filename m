Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0D25B2FA;
	Mon, 18 May 2026 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148708; cv=none; b=fYIiPAMnTNJHuEtRwkQpMfBJdwqdA1+ALqVaq2bbqSrEesXqoCkGNDjFzfuUuKY2p8CRZPYrqytBouj+bP9QUcpSqboMyjdebNrzakgD4JYZFaH1DWfaWSwb87m3hGFga0T0icO4OeRzHml+iCowJRt3bFGVYe/IuDBVI/Xh2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148708; c=relaxed/simple;
	bh=jgU1Ux0RSKsoEQTyZSVlLlzMwDuv4HMvnNIQKAz6Hfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbL0S5JwVmX1PyhRN204yvKwDRnvwSZKcdItJmBlfdIwEpUGwo1meN3DQ5wx1vRhzh0cBFjIlZt4wWs/zSMODfr2ziV1gF6xgVlBh2AHZrtW41LQljT66sDNHyP7E7YPaYhI14aU1xGovKC7nkCaysCTKavK+SH8GpPWgCyRZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MioqW4/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MioqW4/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FFAC2BCB8;
	Mon, 18 May 2026 23:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148708;
	bh=jgU1Ux0RSKsoEQTyZSVlLlzMwDuv4HMvnNIQKAz6Hfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MioqW4/bNR2OBdh4lkd5hnZyiB8eJ5QIaSy9ZpY6b+OyZ8I+UqqXrFt/GwgdGFD1B
	 ZY5RXSO+7NhrcpR8Xbj/k9hmb1uAkE6ePyN6j6o16shFXXAxtzKYg5v9jVE4xvYhqJ
	 uhZNKxgsm8dQIaJpHYOMXjDRt6yKXqgpCkcM/xMYnlWWzBNtF9b2gIcrhDAQNZXt7M
	 lx3z35bgICjj8XmzI5TOdOw0dnZhLYN6jQIQzJe2PdcHW0lJiLmOaxRvWSGH5KXuC3
	 y8BzcEmG9/kEYykS0PzFnJc07afffrMZiBwqQR4aAG5pMq6JUehlRCAdf7n3C/SO3y
	 lDQJa4v23nfsA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 3/3] sched_ext: Add cmask mask ops
Date: Mon, 18 May 2026 13:58:27 -1000
Message-ID: <20260518235827.2353545-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517183614.1191534-4-tj@kernel.org>
References: <20260517183614.1191534-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-sched cap code and other upcoming consumers need bulk cmask ops, both
mutating (and/or/copy/andnot) and predicate (subset/intersects/empty).

cmask_walk_op2() walks the intersection of two ranges word by word;
cmask_walk_op1() walks one range. Both are __always_inline and dispatched on
a compile-time-constant op enum, so each public entry collapses to a
specialized loop with the inner switch reduced to one arm.

Two-cmask ops only touch bits in the intersection of the two ranges; bits
outside are left unchanged. scx_cmask_or_racy() and scx_cmask_copy_racy()
mirror the locking forms but read @src word-by-word through data_race();
callers handle ordering with concurrent writers themselves.

v2: Add scx_cmask_empty().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.c | 270 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext_cid.h |   9 ++
 2 files changed, 279 insertions(+)

diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 44dd47a87709..0c91b951fd33 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -397,6 +397,276 @@ __bpf_kfunc s32 scx_bpf_cpu_to_cid(s32 cpu, const struct bpf_prog_aux *aux)
 	return scx_cpu_to_cid(sch, cpu);
 }
 
+/*
+ * Set ops on cmasks. cmask_walk_op2() shares one walk across mutating
+ * (and/or/copy/andnot) and predicate (subset/intersects) two-cmask forms;
+ * cmask_walk_op1() does the same shape over a single cmask range. Every public
+ * entry passes a compile-time-constant @op; cmask_walk_op{1,2}() and
+ * cmask_word_op{1,2}() are __always_inline so the inner switch collapses to the
+ * selected op and cmask_op2_is_pred() folds the predicate early-exit out of
+ * mutating ops.
+ *
+ * Two-cmask ops only touch @dst bits inside the intersection of the two ranges;
+ * bits outside stay untouched. In particular, scx_cmask_copy() does NOT zero
+ * @dst bits that lie outside @src's range.
+ *
+ * The _RACY variants are otherwise identical to their non-racy counterpart but
+ * read @src word-by-word via data_race(). Memory ordering with concurrent
+ * writers is the caller's responsibility.
+ */
+enum cmask_op2 {
+	/* mutating */
+	CMASK_OP2_AND,
+	CMASK_OP2_OR,
+	CMASK_OP2_OR_RACY,
+	CMASK_OP2_COPY,
+	CMASK_OP2_COPY_RACY,
+	CMASK_OP2_ANDNOT,
+	/* predicates - short-circuit when the per-word result is true */
+	CMASK_OP2_SUBSET,
+	CMASK_OP2_INTERSECTS,
+};
+
+static __always_inline bool cmask_op2_is_pred(const enum cmask_op2 op)
+{
+	return op == CMASK_OP2_SUBSET || op == CMASK_OP2_INTERSECTS;
+}
+
+static __always_inline bool cmask_word_op2(u64 *av, const u64 *bp, u64 mask,
+					   const enum cmask_op2 op)
+{
+	switch (op) {
+	case CMASK_OP2_AND:
+		*av &= ~mask | *bp;
+		return false;
+	case CMASK_OP2_OR:
+		*av |= *bp & mask;
+		return false;
+	case CMASK_OP2_OR_RACY:
+		*av |= data_race(*bp) & mask;
+		return false;
+	case CMASK_OP2_COPY:
+		*av = (*av & ~mask) | (*bp & mask);
+		return false;
+	case CMASK_OP2_COPY_RACY:
+		*av = (*av & ~mask) | (data_race(*bp) & mask);
+		return false;
+	case CMASK_OP2_ANDNOT:
+		*av &= ~(*bp & mask);
+		return false;
+	case CMASK_OP2_SUBSET:
+		/* stop on the first bit in @sub not set in @super */
+		return (*bp & ~*av) & mask;
+	case CMASK_OP2_INTERSECTS:
+		return (*av & *bp) & mask;
+	}
+	unreachable();
+}
+
+/*
+ * Walk the intersection of [@a_base, @a_base + @a_nr_cids) with [@b_base,
+ * @b_base + @b_nr_cids) word by word, applying @op. Mutating ops walk all words
+ * and return false; predicates return true on the first word whose per-word
+ * test is true. Empty intersection returns false (matches "no bits to consider"
+ * for both mutate and predicate).
+ *
+ * Base/nr_cids are taken as parameters so callers with snapshotted bounds can
+ * drive the walk with values independent of the cmask's header.
+ */
+static __always_inline bool cmask_walk_op2(u64 *a_bits, u32 a_base, u32 a_nr_cids,
+					   const u64 *b_bits, u32 b_base, u32 b_nr_cids,
+					   const enum cmask_op2 op)
+{
+	u32 lo = max(a_base, b_base);
+	u32 hi = min(a_base + a_nr_cids, b_base + b_nr_cids);
+	u32 a_word_off = a_base / 64;
+	u32 b_word_off = b_base / 64;
+	u32 lo_word = lo / 64;
+	u32 hi_word = (hi - 1) / 64;
+	u64 head_mask = GENMASK_U64(63, lo & 63);
+	u64 tail_mask = GENMASK_U64((hi - 1) & 63, 0);
+	u32 w;
+
+	if (lo >= hi)
+		return false;
+
+	if (lo_word == hi_word)
+		return cmask_word_op2(&a_bits[lo_word - a_word_off],
+				      &b_bits[lo_word - b_word_off],
+				      head_mask & tail_mask, op);
+
+	if (cmask_word_op2(&a_bits[lo_word - a_word_off],
+			   &b_bits[lo_word - b_word_off], head_mask, op) &&
+	    cmask_op2_is_pred(op))
+		return true;
+
+	for (w = lo_word + 1; w < hi_word; w++)
+		if (cmask_word_op2(&a_bits[w - a_word_off],
+				   &b_bits[w - b_word_off], ~0ULL, op) &&
+		    cmask_op2_is_pred(op))
+			return true;
+
+	return cmask_word_op2(&a_bits[hi_word - a_word_off],
+			      &b_bits[hi_word - b_word_off], tail_mask, op);
+}
+
+enum cmask_op1 {
+	CMASK_OP1_ANY_SET,
+};
+
+static __always_inline bool cmask_word_op1(const u64 *ap, u64 mask,
+					   const enum cmask_op1 op)
+{
+	switch (op) {
+	case CMASK_OP1_ANY_SET:
+		return *ap & mask;
+	}
+	unreachable();
+}
+
+/*
+ * Walk [@a_base, @a_base + @a_nr_cids) of @a_bits word by word, applying @op.
+ * Returns true on the first word whose per-word test is true; returns false if
+ * no word matches or the range is empty. All current op1s short-circuit on
+ * per-word true; if a non-predicate op1 lands here, add a cmask_op1_is_pred()
+ * guard analogous to cmask_op2_is_pred().
+ */
+static __always_inline bool cmask_walk_op1(const u64 *a_bits, u32 a_base,
+					   u32 a_nr_cids,
+					   const enum cmask_op1 op)
+{
+	u32 lo = a_base;
+	u32 hi = a_base + a_nr_cids;
+	u32 a_word_off = a_base / 64;
+	u32 lo_word = lo / 64;
+	u32 hi_word = (hi - 1) / 64;
+	u64 head_mask = GENMASK_U64(63, lo & 63);
+	u64 tail_mask = GENMASK_U64((hi - 1) & 63, 0);
+	u32 w;
+
+	if (lo >= hi)
+		return false;
+
+	if (lo_word == hi_word)
+		return cmask_word_op1(&a_bits[lo_word - a_word_off],
+				      head_mask & tail_mask, op);
+
+	if (cmask_word_op1(&a_bits[lo_word - a_word_off], head_mask, op))
+		return true;
+	for (w = lo_word + 1; w < hi_word; w++)
+		if (cmask_word_op1(&a_bits[w - a_word_off], ~0ULL, op))
+			return true;
+	return cmask_word_op1(&a_bits[hi_word - a_word_off], tail_mask, op);
+}
+
+void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_AND);
+}
+
+void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR);
+}
+
+/**
+ * scx_cmask_or_racy - OR @src into @dst, reading @src without locking
+ *
+ * @src is read word-by-word through data_race(). Same per-bit independence
+ * rationale as scx_cmask_copy_racy(). Memory ordering with writers is the
+ * caller's responsibility.
+ */
+void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR_RACY);
+}
+
+void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY);
+}
+
+/**
+ * scx_cmask_copy_racy - Snapshot @src into @dst without locking
+ *
+ * @src is read word-by-word through data_race(). Head/tail masking matches
+ * scx_cmask_copy(). Each bit in a cmask is independent, so partial updates
+ * just leave some bits fresher than others. Memory ordering with writers is
+ * the caller's responsibility.
+ */
+void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY_RACY);
+}
+
+void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src)
+{
+	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
+		       src->bits, src->base, src->nr_cids, CMASK_OP2_ANDNOT);
+}
+
+/*
+ * Return true if @cm has any bit set in [@lo, @hi). Caller must ensure
+ * [@lo, @hi) is contained in @cm's range.
+ */
+static bool cmask_any_set_in_range(const struct scx_cmask *cm, u32 lo, u32 hi)
+{
+	if (lo >= hi)
+		return false;
+	return cmask_walk_op1(&cm->bits[lo / 64 - cm->base / 64], lo, hi - lo,
+			      CMASK_OP1_ANY_SET);
+}
+
+/**
+ * scx_cmask_subset - test whether @sub is a subset of @super
+ * @sub: cmask to test
+ * @super: cmask to test against
+ *
+ * Return true iff every set bit of @sub is also set in @super.
+ */
+bool scx_cmask_subset(const struct scx_cmask *sub, const struct scx_cmask *super)
+{
+	u32 super_end = super->base + super->nr_cids;
+	u32 sub_end = sub->base + sub->nr_cids;
+
+	/*
+	 * Set bits in @sub outside @super's range can't be in @super, so any
+	 * such bit means not a subset. The walk below only visits words
+	 * common to both ranges, so these need a separate scan.
+	 */
+	if (sub->base < super->base &&
+	    cmask_any_set_in_range(sub, sub->base, min(super->base, sub_end)))
+		return false;
+	if (sub_end > super_end &&
+	    cmask_any_set_in_range(sub, max(sub->base, super_end), sub_end))
+		return false;
+
+	return !cmask_walk_op2((u64 *)super->bits, super->base, super->nr_cids,
+			       sub->bits, sub->base, sub->nr_cids, CMASK_OP2_SUBSET);
+}
+
+bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b)
+{
+	return cmask_walk_op2((u64 *)a->bits, a->base, a->nr_cids,
+			      b->bits, b->base, b->nr_cids, CMASK_OP2_INTERSECTS);
+}
+
+/**
+ * scx_cmask_empty - Test whether @m has no bits set
+ * @m: cmask to test
+ *
+ * Return true iff @m's active range has no bits set.
+ */
+bool scx_cmask_empty(const struct scx_cmask *m)
+{
+	return !cmask_any_set_in_range(m, m->base, m->base + m->nr_cids);
+}
+
 /**
  * scx_bpf_cid_topo - Copy out per-cid topology info
  * @cid: cid to look up
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index 223ed0e857ec..abea22ba2cc2 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -53,6 +53,15 @@ extern struct btf_id_set8 scx_kfunc_ids_init;
 
 void scx_cmask_clear(struct scx_cmask *m);
 void scx_cmask_fill(struct scx_cmask *m);
+void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src);
+void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src);
+void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src);
+void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src);
+void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src);
+void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src);
+bool scx_cmask_subset(const struct scx_cmask *sub, const struct scx_cmask *super);
+bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b);
+bool scx_cmask_empty(const struct scx_cmask *m);
 s32 scx_cid_init(struct scx_sched *sch);
 int scx_cid_kfunc_init(void);
 void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst);
-- 
2.54.0

