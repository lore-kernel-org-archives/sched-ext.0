Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A628313D;
	Tue, 28 Apr 2026 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408558; cv=none; b=EiALq0U3MVryNqaDq+xxtBG/R9Ncf0dDecVg45Iyqp4+RBT1L8Q4RvljV2eIVP7Ds8DbAI4q9JULHzBFgTDHm73+RTxI0LCpxACZY9NZRIUxMB/MZeKszXO0U0fFJ4QbeENy/u6dIihnYYo3SEfHWnyu3g4O+muxA7VILfpJGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408558; c=relaxed/simple;
	bh=qUF32O5FGqJhQCHiAYNZ+4CZ+sUce8p/sQoRpFJVEaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+t70uudUwQj6OckmSkRStwdc8muF7jDsrx+OOlS+oEt2ZO1dl1LklG7UNSC2barbPwpJ7rwHUlFfBnW+FyHyG8uerlWTmRMBLtUth1l9UCuHaOlBymbgWm7yzvkabhQyLz08T+iaApKIzMt4Rcadsp4LjLNRa325tPm5Sl4uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACH4imo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACH4imo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7835FC2BCAF;
	Tue, 28 Apr 2026 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408557;
	bh=qUF32O5FGqJhQCHiAYNZ+4CZ+sUce8p/sQoRpFJVEaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aACH4imoZfzZ+xXGBpRyk0xTc9Ew3f+d32S9FPbGk1D4poNDQxjRgmA65uh1Ij9l6
	 pFQwYbM8pzCY0M4gB74nbnwKxK8E0jxDpbQG5ZD/gBvqLNrg3Py8bw7DlMIFgJwTo4
	 Ff20lMGdC9Nn4LhNF49Dmu9k+CU82Yv+PJUXDmjcppAzdLmH/2Nwvm4TfxM6bYUIw/
	 d+GHmPGDDCXclyk5hmveRJz6ZK4QUIBMGe7IRfrp8/gCdZ8zeR6EwNm+eME3a7ZPRD
	 lEUcYTMjeDV+lPt0SE9vi6EKKjREPeOIziDJVHz8q3iPNtCvpWk0nCUwQAFPEMEOKT
	 IP22df/pgOpBA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 10/17] sched_ext: Add cmask, a base-windowed bitmap over cid space
Date: Tue, 28 Apr 2026 10:35:38 -1000
Message-ID: <20260428203545.181052-11-tj@kernel.org>
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

Sub-scheduler code built on cids needs bitmaps scoped to a slice of cid
space (e.g. the idle cids of a shard). A cpumask sized for NR_CPUS wastes
most of its bits for a small window and is awkward in BPF.

scx_cmask covers [base, base + nr_bits). bits[] is aligned to the global
64-cid grid: bits[0] spans [base & ~63, (base & ~63) + 64). Any two
cmasks therefore address bits[] against the same global windows, so
cross-cmask word ops reduce to

	dest->bits[i] OP= operand->bits[i - delta]

with no bit-shifting, at the cost of up to one extra storage word for
head misalignment. This alignment guarantee is the reason binary ops
can stay word-level; every mutating helper preserves it.

Kernel side in ext_cid.[hc]; BPF side in tools/sched_ext/include/scx/
cid.bpf.h. BPF side drops the scx_ prefix (redundant in BPF code) and
adds the extra helpers that basic idle-cpu selection needs.

No callers yet.

v2: Narrow to helpers that will be used in the planned changes;
    set/bit/find/zero ops will be added as usage develops.

v3: cmask_copy_from_kernel: validate src->base == 0 via probe-read;
    bit-level nr_bits check instead of round-up word count. (Sashiko)

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext_cid.h                   |  25 +
 kernel/sched/ext_types.h                 |  38 ++
 tools/sched_ext/include/scx/cid.bpf.h    | 667 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 4 files changed, 731 insertions(+)
 create mode 100644 tools/sched_ext/include/scx/cid.bpf.h

diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index 52edb66b53fd..c3c429d2c8e2 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -127,4 +127,29 @@ static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
 	return __scx_cpu_to_cid(cpu);
 }
 
+static inline bool __scx_cmask_contains(const struct scx_cmask *m, u32 cid)
+{
+	return likely(cid >= m->base && cid < m->base + m->nr_bits);
+}
+
+/* Word in bits[] covering @cid. @cid must satisfy __scx_cmask_contains(). */
+static inline u64 *__scx_cmask_word(const struct scx_cmask *m, u32 cid)
+{
+	return (u64 *)&m->bits[cid / 64 - m->base / 64];
+}
+
+static inline void scx_cmask_init(struct scx_cmask *m, u32 base, u32 nr_bits)
+{
+	m->base = base;
+	m->nr_bits = nr_bits;
+	memset(m->bits, 0, SCX_CMASK_NR_WORDS(nr_bits) * sizeof(u64));
+}
+
+static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
+{
+	if (!__scx_cmask_contains(m, cid))
+		return;
+	*__scx_cmask_word(m, cid) |= BIT_U64(cid & 63);
+}
+
 #endif /* _KERNEL_SCHED_EXT_CID_H */
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
index be4d3565ae8d..ebb8cdf90612 100644
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
@@ -63,4 +63,42 @@ struct scx_cid_topo {
 	s32 node_idx;
 };
 
+/*
+ * cmask: variable-length, base-windowed bitmap over cid space
+ * -----------------------------------------------------------
+ *
+ * A cmask covers the cid range [base, base + nr_bits). bits[] is aligned to the
+ * global 64-cid grid: bits[0] spans [base & ~63, (base & ~63) + 64), so the
+ * first (base & 63) bits of bits[0] are head padding and any tail past base +
+ * nr_bits is tail padding. Both must stay zero for the lifetime of the mask;
+ * all mutating helpers preserve that invariant.
+ *
+ * Grid alignment means two cmasks always address bits[] against the same global
+ * 64-cid windows, so cross-cmask word ops (AND, OR, ...) reduce to
+ *
+ *	dst->bits[i] OP= src->bits[i - delta]
+ *
+ * with no bit-shifting, regardless of how the two bases relate mod 64.
+ */
+struct scx_cmask {
+	u32 base;
+	u32 nr_bits;
+	DECLARE_FLEX_ARRAY(u64, bits);
+};
+
+/*
+ * Number of u64 words of bits[] storage that covers @nr_bits regardless of base
+ * alignment. The +1 absorbs up to 63 bits of head padding when base is not
+ * 64-aligned - always allocating one extra word beats branching on base or
+ * splitting the compute.
+ */
+#define SCX_CMASK_NR_WORDS(nr_bits)	(((nr_bits) + 63) / 64 + 1)
+
+/*
+ * Define an on-stack cmask for up to @cap_bits. @name is a struct scx_cmask *
+ * aliasing zero-initialized storage; call scx_cmask_init() to set base/nr_bits.
+ */
+#define SCX_CMASK_DEFINE(name, cap_bits)	\
+	DEFINE_RAW_FLEX(struct scx_cmask, name, bits, SCX_CMASK_NR_WORDS(cap_bits))
+
 #endif /* _KERNEL_SCHED_EXT_TYPES_H */
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
new file mode 100644
index 000000000000..960108708eed
--- /dev/null
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -0,0 +1,667 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF-side helpers for cids and cmasks. See kernel/sched/ext_cid.h for the
+ * authoritative layout and semantics. The BPF-side helpers use the cmask_*
+ * naming (no scx_ prefix); cmask is the SCX bitmap type so the prefix is
+ * redundant in BPF code. Atomics use __sync_val_compare_and_swap and every
+ * helper is inline (no .c counterpart).
+ *
+ * Included by scx/common.bpf.h; don't include directly.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef __SCX_CID_BPF_H
+#define __SCX_CID_BPF_H
+
+#include "bpf_arena_common.bpf.h"
+
+#ifndef BIT_U64
+#define BIT_U64(nr)		(1ULL << (nr))
+#endif
+#ifndef GENMASK_U64
+#define GENMASK_U64(h, l)	((~0ULL << (l)) & (~0ULL >> (63 - (h))))
+#endif
+
+/*
+ * Storage cap for bounded loops over bits[]. Sized to cover NR_CPUS=8192 with
+ * one extra word for head-misalignment. Increase if deployment targets larger
+ * NR_CPUS.
+ */
+#ifndef CMASK_MAX_WORDS
+#define CMASK_MAX_WORDS 129
+#endif
+
+#define CMASK_NR_WORDS(nr_bits)		(((nr_bits) + 63) / 64 + 1)
+
+static __always_inline bool __cmask_contains(const struct scx_cmask __arena *m, u32 cid)
+{
+	return cid >= m->base && cid < m->base + m->nr_bits;
+}
+
+static __always_inline u64 __arena *__cmask_word(const struct scx_cmask __arena *m, u32 cid)
+{
+	return (u64 __arena *)&m->bits[cid / 64 - m->base / 64];
+}
+
+static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 base, u32 nr_bits)
+{
+	u32 nr_words = CMASK_NR_WORDS(nr_bits), i;
+
+	m->base = base;
+	m->nr_bits = nr_bits;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		m->bits[i] = 0;
+	}
+}
+
+static __always_inline bool cmask_test(const struct scx_cmask __arena *m, u32 cid)
+{
+	if (!__cmask_contains(m, cid))
+		return false;
+	return *__cmask_word(m, cid) & BIT_U64(cid & 63);
+}
+
+/*
+ * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
+ * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
+ * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
+ * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
+ *
+ * CMASK_CAS_TRIES is far above what any non-pathological contention needs.
+ * Exhausting it means the bit update was lost, which corrupts the caller's view
+ * of the bitmap, so raise scx_bpf_error() to abort the scheduler.
+ */
+#define CMASK_CAS_TRIES		1024
+
+static __always_inline void cmask_set(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 __arena *w;
+	u64 bit, old, new;
+	u32 i;
+
+	if (!__cmask_contains(m, cid))
+		return;
+	w = __cmask_word(m, cid);
+	bit = BIT_U64(cid & 63);
+	bpf_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if (old & bit)
+			return;
+		new = old | bit;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return;
+	}
+	scx_bpf_error("cmask_set CAS exhausted at cid %u", cid);
+}
+
+static __always_inline void cmask_clear(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 __arena *w;
+	u64 bit, old, new;
+	u32 i;
+
+	if (!__cmask_contains(m, cid))
+		return;
+	w = __cmask_word(m, cid);
+	bit = BIT_U64(cid & 63);
+	bpf_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if (!(old & bit))
+			return;
+		new = old & ~bit;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return;
+	}
+	scx_bpf_error("cmask_clear CAS exhausted at cid %u", cid);
+}
+
+static __always_inline bool cmask_test_and_set(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 __arena *w;
+	u64 bit, old, new;
+	u32 i;
+
+	if (!__cmask_contains(m, cid))
+		return false;
+	w = __cmask_word(m, cid);
+	bit = BIT_U64(cid & 63);
+	bpf_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if (old & bit)
+			return true;
+		new = old | bit;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return false;
+	}
+	scx_bpf_error("cmask_test_and_set CAS exhausted at cid %u", cid);
+	return false;
+}
+
+static __always_inline bool cmask_test_and_clear(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 __arena *w;
+	u64 bit, old, new;
+	u32 i;
+
+	if (!__cmask_contains(m, cid))
+		return false;
+	w = __cmask_word(m, cid);
+	bit = BIT_U64(cid & 63);
+	bpf_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if (!(old & bit))
+			return false;
+		new = old & ~bit;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return true;
+	}
+	scx_bpf_error("cmask_test_and_clear CAS exhausted at cid %u", cid);
+	return false;
+}
+
+static __always_inline void __cmask_set(struct scx_cmask __arena *m, u32 cid)
+{
+	if (!__cmask_contains(m, cid))
+		return;
+	*__cmask_word(m, cid) |= BIT_U64(cid & 63);
+}
+
+static __always_inline void __cmask_clear(struct scx_cmask __arena *m, u32 cid)
+{
+	if (!__cmask_contains(m, cid))
+		return;
+	*__cmask_word(m, cid) &= ~BIT_U64(cid & 63);
+}
+
+static __always_inline bool __cmask_test_and_set(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 bit = BIT_U64(cid & 63);
+	u64 __arena *w;
+	u64 prev;
+
+	if (!__cmask_contains(m, cid))
+		return false;
+	w = __cmask_word(m, cid);
+	prev = *w & bit;
+	*w |= bit;
+	return prev;
+}
+
+static __always_inline bool __cmask_test_and_clear(struct scx_cmask __arena *m, u32 cid)
+{
+	u64 bit = BIT_U64(cid & 63);
+	u64 __arena *w;
+	u64 prev;
+
+	if (!__cmask_contains(m, cid))
+		return false;
+	w = __cmask_word(m, cid);
+	prev = *w & bit;
+	*w &= ~bit;
+	return prev;
+}
+
+static __always_inline void cmask_zero(struct scx_cmask __arena *m)
+{
+	u32 nr_words = CMASK_NR_WORDS(m->nr_bits), i;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		m->bits[i] = 0;
+	}
+}
+
+/*
+ * BPF_-prefixed to avoid colliding with the kernel's anonymous CMASK_OP_*
+ * enum in ext_cid.c, which is exported via BTF and reachable through
+ * vmlinux.h.
+ */
+enum {
+	BPF_CMASK_OP_AND,
+	BPF_CMASK_OP_OR,
+	BPF_CMASK_OP_COPY,
+	BPF_CMASK_OP_ANDNOT,
+};
+
+static __always_inline void cmask_op_word(struct scx_cmask __arena *dst,
+					  const struct scx_cmask __arena *src,
+					  u32 di, u32 si, u64 mask, int op)
+{
+	u64 dv = dst->bits[di];
+	u64 sv = src->bits[si];
+	u64 rv;
+
+	if (op == BPF_CMASK_OP_AND)
+		rv = dv & sv;
+	else if (op == BPF_CMASK_OP_OR)
+		rv = dv | sv;
+	else if (op == BPF_CMASK_OP_ANDNOT)
+		rv = dv & ~sv;
+	else
+		rv = sv;
+
+	dst->bits[di] = (dv & ~mask) | (rv & mask);
+}
+
+static __always_inline void cmask_op(struct scx_cmask __arena *dst,
+				     const struct scx_cmask __arena *src, int op)
+{
+	u32 d_end = dst->base + dst->nr_bits;
+	u32 s_end = src->base + src->nr_bits;
+	u32 lo = dst->base > src->base ? dst->base : src->base;
+	u32 hi = d_end < s_end ? d_end : s_end;
+	u32 d_base = dst->base / 64;
+	u32 s_base = src->base / 64;
+	u32 lo_word, hi_word, i;
+	u64 head_mask, tail_mask;
+
+	if (lo >= hi)
+		return;
+
+	lo_word = lo / 64;
+	hi_word = (hi - 1) / 64;
+	head_mask = GENMASK_U64(63, lo & 63);
+	tail_mask = GENMASK_U64((hi - 1) & 63, 0);
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 w = lo_word + i;
+		u64 m;
+
+		if (w > hi_word)
+			break;
+
+		m = GENMASK_U64(63, 0);
+		if (w == lo_word)
+			m &= head_mask;
+		if (w == hi_word)
+			m &= tail_mask;
+
+		cmask_op_word(dst, src, w - d_base, w - s_base, m, op);
+	}
+}
+
+/*
+ * cmask_and/or/copy only modify @dst bits that lie in the intersection of
+ * [@dst->base, @dst->base + @dst->nr_bits) and [@src->base,
+ * @src->base + @src->nr_bits). Bits in @dst outside that window
+ * keep their prior values - in particular, cmask_copy() does NOT zero @dst
+ * bits that lie outside @src's range.
+ */
+static __always_inline void cmask_and(struct scx_cmask __arena *dst,
+				      const struct scx_cmask __arena *src)
+{
+	cmask_op(dst, src, BPF_CMASK_OP_AND);
+}
+
+static __always_inline void cmask_or(struct scx_cmask __arena *dst,
+				     const struct scx_cmask __arena *src)
+{
+	cmask_op(dst, src, BPF_CMASK_OP_OR);
+}
+
+static __always_inline void cmask_copy(struct scx_cmask __arena *dst,
+				       const struct scx_cmask __arena *src)
+{
+	cmask_op(dst, src, BPF_CMASK_OP_COPY);
+}
+
+static __always_inline void cmask_andnot(struct scx_cmask __arena *dst,
+					 const struct scx_cmask __arena *src)
+{
+	cmask_op(dst, src, BPF_CMASK_OP_ANDNOT);
+}
+
+/*
+ * True iff @a and @b have identical bits over their (assumed equal) range.
+ * Callers are expected to pass same-shape cmasks; differing shapes always
+ * compare unequal.
+ */
+static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
+					const struct scx_cmask __arena *b)
+{
+	u32 nr_words, i;
+
+	if (a->base != b->base || a->nr_bits != b->nr_bits)
+		return false;
+	nr_words = CMASK_NR_WORDS(a->nr_bits);
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		if (a->bits[i] != b->bits[i])
+			return false;
+	}
+	return true;
+}
+
+/*
+ * True iff every bit set in @a is also set in @b over the intersection of
+ * their ranges. Bits of @a outside @b's range fail the test.
+ */
+static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
+					 const struct scx_cmask __arena *b)
+{
+	u32 a_end = a->base + a->nr_bits;
+	u32 b_end = b->base + b->nr_bits;
+	u32 a_wbase = a->base / 64;
+	u32 b_wbase = b->base / 64;
+	u32 nr_words, i;
+
+	/* any bit of @a outside @b's range is a subset violation */
+	if (a->base < b->base || a_end > b_end)
+		return false;
+
+	nr_words = CMASK_NR_WORDS(a->nr_bits);
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 wi_b;
+
+		if (i >= nr_words)
+			break;
+		wi_b = a_wbase + i - b_wbase;
+		if (a->bits[i] & ~b->bits[wi_b])
+			return false;
+	}
+	return true;
+}
+
+/**
+ * cmask_next_set - find the first set bit at or after @cid
+ * @m: cmask to search
+ * @cid: starting cid (clamped to @m->base if below)
+ *
+ * Returns the smallest set cid in [@cid, @m->base + @m->nr_bits), or
+ * @m->base + @m->nr_bits if none (the out-of-range sentinel matches the
+ * termination condition used by cmask_for_each()).
+ */
+static __always_inline u32 cmask_next_set(const struct scx_cmask __arena *m, u32 cid)
+{
+	u32 end = m->base + m->nr_bits;
+	u32 base = m->base / 64;
+	u32 last_wi = (end - 1) / 64 - base;
+	u32 start_wi, start_bit, i;
+
+	if (cid < m->base)
+		cid = m->base;
+	if (cid >= end)
+		return end;
+
+	start_wi = cid / 64 - base;
+	start_bit = cid & 63;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 wi = start_wi + i;
+		u64 word;
+		u32 found;
+
+		if (wi > last_wi)
+			break;
+
+		word = m->bits[wi];
+		if (i == 0)
+			word &= GENMASK_U64(63, start_bit);
+		if (!word)
+			continue;
+
+		found = (base + wi) * 64 + __builtin_ctzll(word);
+		if (found >= end)
+			return end;
+		return found;
+	}
+	return end;
+}
+
+static __always_inline u32 cmask_first_set(const struct scx_cmask __arena *m)
+{
+	return cmask_next_set(m, m->base);
+}
+
+#define cmask_for_each(cid, m)							\
+	for ((cid) = cmask_first_set(m);					\
+	     (cid) < (m)->base + (m)->nr_bits;					\
+	     (cid) = cmask_next_set((m), (cid) + 1))
+
+/*
+ * Population count over [base, base + nr_bits). Padding bits in the head/tail
+ * words are guaranteed zero by the mutating helpers, so a flat popcount over
+ * all words is correct.
+ */
+static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
+{
+	u32 nr_words = CMASK_NR_WORDS(m->nr_bits), i;
+	u32 count = 0;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		count += __builtin_popcountll(m->bits[i]);
+	}
+	return count;
+}
+
+/*
+ * True if @a and @b share any set bit. Walk only the intersection of their
+ * ranges, matching the semantics of cmask_and().
+ */
+static __always_inline bool cmask_intersects(const struct scx_cmask __arena *a,
+					     const struct scx_cmask __arena *b)
+{
+	u32 a_end = a->base + a->nr_bits;
+	u32 b_end = b->base + b->nr_bits;
+	u32 lo = a->base > b->base ? a->base : b->base;
+	u32 hi = a_end < b_end ? a_end : b_end;
+	u32 a_base = a->base / 64;
+	u32 b_base = b->base / 64;
+	u32 lo_word, hi_word, i;
+	u64 head_mask, tail_mask;
+
+	if (lo >= hi)
+		return false;
+
+	lo_word = lo / 64;
+	hi_word = (hi - 1) / 64;
+	head_mask = GENMASK_U64(63, lo & 63);
+	tail_mask = GENMASK_U64((hi - 1) & 63, 0);
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 w = lo_word + i;
+		u64 mask, av, bv;
+
+		if (w > hi_word)
+			break;
+
+		mask = GENMASK_U64(63, 0);
+		if (w == lo_word)
+			mask &= head_mask;
+		if (w == hi_word)
+			mask &= tail_mask;
+
+		av = a->bits[w - a_base] & mask;
+		bv = b->bits[w - b_base] & mask;
+		if (av & bv)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Find the next cid set in both @a and @b at or after @start, bounded by the
+ * intersection of the two ranges. Return a->base + a->nr_bits if none found.
+ *
+ * Building block for cmask_next_and_set_wrap(). Callers that want a bounded
+ * scan without wrap call this directly.
+ */
+static __always_inline u32 cmask_next_and_set(const struct scx_cmask __arena *a,
+					      const struct scx_cmask __arena *b,
+					      u32 start)
+{
+	u32 a_end = a->base + a->nr_bits;
+	u32 b_end = b->base + b->nr_bits;
+	u32 a_wbase = a->base / 64;
+	u32 b_wbase = b->base / 64;
+	u32 lo = a->base > b->base ? a->base : b->base;
+	u32 hi = a_end < b_end ? a_end : b_end;
+	u32 last_wi, start_wi, start_bit, i;
+
+	if (lo >= hi)
+		return a_end;
+	if (start < lo)
+		start = lo;
+	if (start >= hi)
+		return a_end;
+
+	last_wi = (hi - 1) / 64;
+	start_wi = start / 64;
+	start_bit = start & 63;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 abs_wi = start_wi + i;
+		u64 word;
+		u32 found;
+
+		if (abs_wi > last_wi)
+			break;
+
+		word = a->bits[abs_wi - a_wbase] & b->bits[abs_wi - b_wbase];
+		if (i == 0)
+			word &= GENMASK_U64(63, start_bit);
+		if (!word)
+			continue;
+
+		found = abs_wi * 64 + __builtin_ctzll(word);
+		if (found >= hi)
+			return a_end;
+		return found;
+	}
+	return a_end;
+}
+
+/*
+ * Find the next set cid in @m at or after @start, wrapping to @m->base if no
+ * set bit is found in [start, m->base + m->nr_bits). Return m->base +
+ * m->nr_bits if @m is empty.
+ *
+ * Callers do round-robin distribution by passing (last_cid + 1) as @start.
+ */
+static __always_inline u32 cmask_next_set_wrap(const struct scx_cmask __arena *m,
+					       u32 start)
+{
+	u32 end = m->base + m->nr_bits;
+	u32 found;
+
+	found = cmask_next_set(m, start);
+	if (found < end || start <= m->base)
+		return found;
+
+	found = cmask_next_set(m, m->base);
+	return found < start ? found : end;
+}
+
+/*
+ * Find the next cid set in both @a and @b at or after @start, wrapping to
+ * @a->base if none found in the forward half. Return a->base + a->nr_bits
+ * if the intersection is empty.
+ *
+ * Callers do round-robin distribution by passing (last_cid + 1) as @start.
+ */
+static __always_inline u32 cmask_next_and_set_wrap(const struct scx_cmask __arena *a,
+						   const struct scx_cmask __arena *b,
+						   u32 start)
+{
+	u32 a_end = a->base + a->nr_bits;
+	u32 found;
+
+	found = cmask_next_and_set(a, b, start);
+	if (found < a_end || start <= a->base)
+		return found;
+
+	found = cmask_next_and_set(a, b, a->base);
+	return found < start ? found : a_end;
+}
+
+/**
+ * cmask_from_cpumask - translate a kernel cpumask to a cid-space cmask
+ * @m: cmask to fill. Zeroed first; only bits within [@m->base, @m->base +
+ *     @m->nr_bits) are updated - cpus mapping to cids outside that range
+ *     are ignored.
+ * @cpumask: kernel cpumask to translate
+ *
+ * For each cpu in @cpumask, set the cpu's cid in @m. Caller must ensure
+ * @cpumask stays stable across the call (e.g. RCU read lock for
+ * task->cpus_ptr).
+ */
+static __always_inline void cmask_from_cpumask(struct scx_cmask __arena *m,
+					       const struct cpumask *cpumask)
+{
+	u32 nr_cpu_ids = scx_bpf_nr_cpu_ids();
+	s32 cpu;
+
+	cmask_zero(m);
+	bpf_for(cpu, 0, nr_cpu_ids) {
+		s32 cid;
+
+		if (!bpf_cpumask_test_cpu(cpu, cpumask))
+			continue;
+		cid = scx_bpf_cpu_to_cid(cpu);
+		if (cid >= 0)
+			__cmask_set(m, cid);
+	}
+}
+
+/**
+ * cmask_copy_from_kernel - probe-read a kernel cmask into an arena cmask
+ * @dst: arena cmask to fill; must have @dst->base == 0 and be sized for @src.
+ * @src: kernel-memory cmask (e.g. ops.set_cmask() arg); @src->base must be 0.
+ *
+ * Word-for-word copy; @src and @dst must share base 0 alignment. Triggers
+ * scx_bpf_error() on probe failure or precondition violation.
+ */
+static __always_inline void cmask_copy_from_kernel(struct scx_cmask __arena *dst,
+						   const struct scx_cmask *src)
+{
+	u32 base = 0, nr_bits = 0, nr_words, wi;
+
+	if (dst->base != 0) {
+		scx_bpf_error("cmask_copy_from_kernel requires dst->base == 0");
+		return;
+	}
+
+	if (bpf_probe_read_kernel(&base, sizeof(base), &src->base)) {
+		scx_bpf_error("probe-read cmask->base failed");
+		return;
+	}
+	if (base != 0) {
+		scx_bpf_error("cmask_copy_from_kernel requires src->base == 0");
+		return;
+	}
+
+	if (bpf_probe_read_kernel(&nr_bits, sizeof(nr_bits), &src->nr_bits)) {
+		scx_bpf_error("probe-read cmask->nr_bits failed");
+		return;
+	}
+
+	if (nr_bits > dst->nr_bits) {
+		scx_bpf_error("src cmask nr_bits=%u exceeds dst nr_bits=%u",
+			      nr_bits, dst->nr_bits);
+		return;
+	}
+
+	nr_words = CMASK_NR_WORDS(nr_bits);
+	cmask_zero(dst);
+	bpf_for(wi, 0, CMASK_MAX_WORDS) {
+		u64 word = 0;
+		if (wi >= nr_words)
+			break;
+		if (bpf_probe_read_kernel(&word, sizeof(u64), &src->bits[wi])) {
+			scx_bpf_error("probe-read cmask->bits[%u] failed", wi);
+			return;
+		}
+		dst->bits[wi] = word;
+	}
+}
+
+#endif /* __SCX_CID_BPF_H */
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 087ae4f79c60..ff57a7acdbeb 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -1055,5 +1055,6 @@ static inline u64 scx_clock_irq(u32 cpu)
 
 #include "compat.bpf.h"
 #include "enums.bpf.h"
+#include "cid.bpf.h"
 
 #endif	/* __SCX_COMMON_BPF_H */
-- 
2.54.0

