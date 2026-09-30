Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE6EED8;
	Wed, 30 Sep 2026 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726667; cv=none; b=AKW1ZqDVgmWIVE9iXMdmmNCbHFzITwQA86acczqZpUjPb2v3n2JGN+CCNfvIE8sTrrArBVIJ0DdprwulKhZtZgehY9QuIv2GfBE+aqAZz4Io87W3HmB+iHNn3wpdlc8ID16N+ByjBRdZ0S/s6EQDUinNOsjyD3fNTr7OxGahD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726667; c=relaxed/simple;
	bh=FDOXrF/E+YBmAUxei8/uvxGbGXrluMyAB89y1idLl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcseU1ZmRMsumpeNHHRvm0lS03rBWsX390kmsW3so7UW/4QKokqgpGnoeqmHM0EfWcQ0KmKFmNOe500m+/pG+c8LYUldvbr+N6MdkNyrLxU7mxU8YVCpBsdMDUQTkiRKMWiI5c6Tho0Uq5zarQdVLmL4x6LTXPnLEkYct8/hj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOqFige; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOqFige"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDB1F00893;
	Wed, 30 Sep 2026 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726665;
	bh=Gaf1VJG3hQDjV+bafv1j6OhXX3qT544I6D1rHp4gVrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTOqFige6GZQAPnFYYJ41LHbpn5oXNh1qSePpNxvYXnmFPhIrVAadKwWDil9LVPYk
	 qzCcLNhLAUtN1siOikKfF6Fsin0nsMiDJzQJdOy3Bho4ITsf4LBXBxU0KnY7IOnSaU
	 qYGUYl28f6EfkH05BaW8AlbRcph8gezcu01hGRNRRNOLhyLJETzSVrDU77NT0lwV2E
	 DPdlEOEmmYppNbjHp8CBPJiEaygZqkMv+tcG/XrZbcgyxd7xixJ8f535etDenmLANb
	 6rA0H2TEvLTYqcuVsVrub5vy8a4qwS9nl2wF2xcRGEWyQ/R02Of28kwExPsSlQeWJN
	 z3YLk2/I+uzCQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Sync common and compat headers from the scx repo
Date: Tue, 29 Sep 2026 14:04:21 -1000
Message-ID: <20260930000422.3350352-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930000422.3350352-1-tj@kernel.org>
References: <20260930000422.3350352-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync cid.bpf.h, common.bpf.h, compat.bpf.h and compat.h with the scx repo at
c9b90b3ad3d0 ("scheds/include: Sync with kernel sched_ext/for-7.4
(c6fe97c34a1a)"), which accumulated the following since the last sync:

- cid.bpf.h grew the cmask helpers the cid-form schedulers use: fill, empty
  and end tests, unchecked and word-level access, distribute picks over an
  arena rotor indexed by cid, range set and clear, and three-operand and, or
  and andnot that report whether the result is empty. Its word loops walk
  with bpf_arena_for() and its bit helpers take the fetching atomics when
  the loader's probe finds the JIT lowers them.

- The prolog probe's default now makes is_migration_disabled() over-report,
  which errs toward local-only dispatch instead of crashing, and the
  cid-form open macros repoint the probe at bpf_scx_reg_cid(), which
  cid-form schedulers register through.

- scx_bpf_kick_cid() and scx_bpf_cidperf_set() changed their return types
  without being renamed, so compat.bpf.h declares both flavors of each and
  lets the kernel pick, the way scx_bpf_dsq_insert() is handled.

- A macro supplies scx_bpf_cid_topo()'s size argument from the output
  buffer, TRAILING_OVERLAP() embeds a struct that ends in a flexible array
  together with its storage, bpf_arena_for() walks a range in a form the
  verifier converges on, and features.bpf.h carries the kernel feature bits
  the loader probes before load. const-defs.h holds the per-architecture
  cacheline size that cid.bpf.h aligns its rotor slots to.

scx_qmap already used the cmask helpers, and the three-operand forms of
cmask_and() and cmask_andnot() had not reached its copy of cid.bpf.h, so
tools/sched_ext no longer built against scx's headers. Its five calls take
the three-operand form now, with the copy-then-operate pairs folded into one
call each.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h      | 689 ++++++++++++++++++---
 tools/sched_ext/include/scx/common.bpf.h   |  90 ++-
 tools/sched_ext/include/scx/compat.bpf.h   |  63 ++
 tools/sched_ext/include/scx/compat.h       |  15 +-
 tools/sched_ext/include/scx/const-defs.h   |  20 +
 tools/sched_ext/include/scx/features.bpf.h |  29 +
 tools/sched_ext/scx_qmap.bpf.c             |  14 +-
 7 files changed, 808 insertions(+), 112 deletions(-)
 create mode 100644 tools/sched_ext/include/scx/const-defs.h
 create mode 100644 tools/sched_ext/include/scx/features.bpf.h

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 69fb4e97bc77..d1e6ad1432d3 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -3,8 +3,8 @@
  * BPF-side helpers for cids and cmasks. See kernel/sched/ext/cid.h for the
  * authoritative layout and semantics. The BPF-side helpers use the cmask_*
  * naming (no scx_ prefix); cmask is the SCX bitmap type so the prefix is
- * redundant in BPF code. Atomics use __sync_val_compare_and_swap and every
- * helper is inline (no .c counterpart).
+ * redundant in BPF code. Every helper is inline except the binary operations,
+ * which are weak global functions defined here, so there is no .c counterpart.
  *
  * Included by scx/common.bpf.h; don't include directly.
  *
@@ -16,6 +16,11 @@
 
 #include "bpf_arena_common.bpf.h"
 
+/* libbpf's bpf_helpers.h defines it from 1.4 on */
+#ifndef __arg_arena
+#define __arg_arena __attribute((btf_decl_tag("arg:arena")))
+#endif
+
 #ifndef BIT_U64
 #define BIT_U64(nr)		(1ULL << (nr))
 #endif
@@ -76,7 +81,7 @@ static __always_inline void __cmask_init(struct scx_cmask __arena *m, u32 base,
 	m->nr_cids = nr_cids;
 	m->alloc_words = alloc_words;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= alloc_words)
 			break;
 		m->bits[i] = 0;
@@ -122,24 +127,115 @@ static __always_inline void cmask_reframe(struct scx_cmask __arena *m, u32 base,
 	m->nr_cids = nr_cids;
 }
 
+/**
+ * cmask_nr_words - Words of bits[] that @m's active range spans
+ * @m: cmask to measure
+ *
+ * @m->base need not be word aligned: bits[0] covers the whole word @m->base
+ * falls in, so the count is taken from that word, not from @m->base.
+ */
+static __always_inline u32 cmask_nr_words(const struct scx_cmask __arena *m)
+{
+	u32 wbase = m->base / 64;
+
+	return m->nr_cids ? (m->base + m->nr_cids - 1) / 64 - wbase + 1 : 0;
+}
+
+/**
+ * cmask_word - Read word @k of @m
+ * @m: cmask to read
+ * @k: word index, counted from the word @m->base falls in
+ *
+ * A word past the active range reads as 0, so a scan that looks one word
+ * ahead (at an SMT sibling that falls in the next word, say) needs no bound
+ * of its own.
+ */
+static __always_inline u64 cmask_word(const struct scx_cmask __arena *m, u32 k)
+{
+	if (k >= cmask_nr_words(m))
+		return 0;
+	return m->bits[k];
+}
+
+/**
+ * cmask_range_word - Bits of word @k of @m that fall in [@start, @start + @nr)
+ * @m: cmask the word belongs to
+ * @k: word index, counted from the word @m->base falls in
+ * @start: first cid of the range
+ * @nr: number of cids in the range
+ *
+ * Scoping a scan to a domain that is contiguous in cid space, an LLC or a
+ * node, is then one AND per word, rather than a test of the ends of the
+ * range at every bit or a mask kept per domain.
+ */
+static __always_inline u64 cmask_range_word(const struct scx_cmask __arena *m,
+					    u32 k, u32 start, u32 nr)
+{
+	u64 wlo = (u64)(m->base / 64 + k) * 64, whi = wlo + 64;
+	u64 lo = start, hi = (u64)start + nr;
+
+	if (lo < wlo)
+		lo = wlo;
+	if (hi > whi)
+		hi = whi;
+	if (lo >= hi)
+		return 0;
+
+	return GENMASK_U64(hi - wlo - 1, lo - wlo);
+}
+
+/**
+ * __cmask_test - Test a cid without checking it against the active range
+ * @cid: cid to test
+ * @m: cmask to test
+ *
+ * The caller must already know that @cid lies within
+ * [@m->base, @m->base + @m->nr_cids), or the read runs off @m->bits.
+ *
+ * For hot scans that have already bounded @cid, where the per-call range check
+ * is repeated work on every candidate.
+ */
+static __always_inline bool __cmask_test(u32 cid, const struct scx_cmask __arena *m)
+{
+	return *__cmask_word(cid, m) & BIT_U64(cid & 63);
+}
+
 static __always_inline bool cmask_test(u32 cid, const struct scx_cmask __arena *m)
 {
 	if (!__cmask_contains(cid, m))
 		return false;
-	return *__cmask_word(cid, m) & BIT_U64(cid & 63);
+	return __cmask_test(cid, m);
 }
 
 /*
- * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
- * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
- * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
- * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
+ * The bit helpers use the fetching bitwise builtins, which order like the
+ * cmpxchg they replace, and not every JIT accepts those on arena pointers. The
+ * loader sets SCX_LIB_FEAT_ARENA_FETCH_BITOPS when a probe with the fetching
+ * form loads, and the helpers run a cmpxchg loop otherwise. The fetched value
+ * is consumed through barrier_var() because clang 19 lowers a builtin whose
+ * result is unused to the non-fetching form, which is relaxed on arm64.
  *
  * CMASK_CAS_TRIES is sized so exhausting it means seconds of real spinning
- * on one word - past any plausible contention. Abort hard.
+ * on one word, past any plausible contention. Abort hard.
  */
 #define CMASK_CAS_TRIES		(1U << 23)
 
+static __always_inline u64 __cmask_fetch_or(u64 __arena *w, u64 mask)
+{
+	u64 old = __atomic_fetch_or(w, mask, __ATOMIC_ACQ_REL);
+
+	barrier_var(old);
+	return old;
+}
+
+static __always_inline u64 __cmask_fetch_andnot(u64 __arena *w, u64 mask)
+{
+	u64 old = __atomic_fetch_and(w, ~mask, __ATOMIC_ACQ_REL);
+
+	barrier_var(old);
+	return old;
+}
+
 static __always_inline void cmask_set(u32 cid, struct scx_cmask __arena *m)
 {
 	u64 __arena *w;
@@ -150,7 +246,11 @@ static __always_inline void cmask_set(u32 cid, struct scx_cmask __arena *m)
 		return;
 	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS)) {
+		__cmask_fetch_or(w, bit);
+		return;
+	}
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
 		if (old & bit)
 			return;
@@ -171,7 +271,11 @@ static __always_inline void cmask_clear(u32 cid, struct scx_cmask __arena *m)
 		return;
 	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS)) {
+		__cmask_fetch_andnot(w, bit);
+		return;
+	}
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
 		if (!(old & bit))
 			return;
@@ -192,7 +296,9 @@ static __always_inline bool cmask_test_and_set(u32 cid, struct scx_cmask __arena
 		return false;
 	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS))
+		return __cmask_fetch_or(w, bit) & bit;
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
 		if (old & bit)
 			return true;
@@ -214,7 +320,9 @@ static __always_inline bool cmask_test_and_clear(u32 cid, struct scx_cmask __are
 		return false;
 	w = __cmask_word(cid, m);
 	bit = BIT_U64(cid & 63);
-	bpf_for(i, 0, CMASK_CAS_TRIES) {
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS))
+		return __cmask_fetch_andnot(w, bit) & bit;
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
 		old = *w;
 		if (!(old & bit))
 			return false;
@@ -268,17 +376,242 @@ static __always_inline bool __cmask_test_and_clear(u32 cid, struct scx_cmask __a
 	return prev;
 }
 
+/* atomically or @mask into *@w */
+static __always_inline void __cmask_word_or(u64 __arena *w, u64 mask)
+{
+	u64 old, new;
+	u32 i;
+
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS)) {
+		__cmask_fetch_or(w, mask);
+		return;
+	}
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if ((old & mask) == mask)
+			return;
+		new = old | mask;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return;
+	}
+	scx_bpf_error("__cmask_word_or CAS exhausted");
+}
+
+/* atomically clear @mask bits in *@w */
+static __always_inline void __cmask_word_andnot(u64 __arena *w, u64 mask)
+{
+	u64 old, new;
+	u32 i;
+
+	if (scx_lib_has(SCX_LIB_FEAT_ARENA_FETCH_BITOPS)) {
+		__cmask_fetch_andnot(w, mask);
+		return;
+	}
+	bpf_arena_for(i, 0, CMASK_CAS_TRIES) {
+		old = *w;
+		if (!(old & mask))
+			return;
+		new = old & ~mask;
+		if (__sync_val_compare_and_swap(w, old, new) == old)
+			return;
+	}
+	scx_bpf_error("__cmask_word_andnot CAS exhausted");
+}
+
+/**
+ * cmask_full_range - Test whether every cid in [@start, @start + @nr) is set
+ * @m: cmask to test
+ * @start: first cid of the range
+ * @nr: number of cids in the range
+ *
+ * The range is clamped to @m's active range first. True when no clamped bit is
+ * clear, including when the clamped range is empty.
+ */
+static __always_inline bool cmask_full_range(const struct scx_cmask __arena *m, u32 start,
+					     u32 nr)
+{
+	u64 end = (u64)start + nr;
+	u32 wbase = m->base / 64;
+	u32 first_wi, last_wi, first_bit, last_bit, last, i;
+
+	if (start < m->base)
+		start = m->base;
+	if (end > m->base + m->nr_cids)
+		end = m->base + m->nr_cids;
+	if (start >= end)
+		return true;
+	last = end - 1;
+
+	first_wi = start / 64 - wbase;
+	last_wi = last / 64 - wbase;
+	first_bit = start & 63;
+	last_bit = last & 63;
+
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
+		u32 wi = first_wi + i;
+		u64 mask = ~0ULL;
+
+		if (wi > last_wi)
+			break;
+		if (wi == first_wi)
+			mask &= GENMASK_U64(63, first_bit);
+		if (wi == last_wi)
+			mask &= GENMASK_U64(last_bit, 0);
+		if ((m->bits[wi] & mask) != mask)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * cmask_set_range - Set every cid in [@start, @start + @nr)
+ * @m: cmask to modify
+ * @start: first cid of the range
+ * @nr: number of cids in the range
+ *
+ * The range is clamped to @m's active range first. Words are updated atomically
+ * so concurrent updates of other bits sharing a word are never lost. The range
+ * as a whole does not transition atomically.
+ */
+static __always_inline void cmask_set_range(struct scx_cmask __arena *m, u32 start, u32 nr)
+{
+	u64 end = (u64)start + nr;
+	u32 wbase = m->base / 64;
+	u32 first_wi, last_wi, first_bit, last_bit, last, i;
+
+	if (start < m->base)
+		start = m->base;
+	if (end > m->base + m->nr_cids)
+		end = m->base + m->nr_cids;
+	if (start >= end)
+		return;
+	last = end - 1;
+
+	first_wi = start / 64 - wbase;
+	last_wi = last / 64 - wbase;
+	first_bit = start & 63;
+	last_bit = last & 63;
+
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
+		u32 wi = first_wi + i;
+		u64 mask = ~0ULL;
+
+		if (wi > last_wi)
+			break;
+		if (wi == first_wi)
+			mask &= GENMASK_U64(63, first_bit);
+		if (wi == last_wi)
+			mask &= GENMASK_U64(last_bit, 0);
+		__cmask_word_or(&m->bits[wi], mask);
+	}
+}
+
+/**
+ * cmask_clear_range - Clear every cid in [@start, @start + @nr)
+ * @m: cmask to modify
+ * @start: first cid of the range
+ * @nr: number of cids in the range
+ *
+ * The range is clamped to @m's active range first. Words are updated atomically
+ * so concurrent updates of other bits sharing a word are never lost. The range
+ * as a whole does not transition atomically.
+ */
+static __always_inline void cmask_clear_range(struct scx_cmask __arena *m, u32 start, u32 nr)
+{
+	u64 end = (u64)start + nr;
+	u32 wbase = m->base / 64;
+	u32 first_wi, last_wi, first_bit, last_bit, last, i;
+
+	if (start < m->base)
+		start = m->base;
+	if (end > m->base + m->nr_cids)
+		end = m->base + m->nr_cids;
+	if (start >= end)
+		return;
+	last = end - 1;
+
+	first_wi = start / 64 - wbase;
+	last_wi = last / 64 - wbase;
+	first_bit = start & 63;
+	last_bit = last & 63;
+
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
+		u32 wi = first_wi + i;
+		u64 mask = ~0ULL;
+
+		if (wi > last_wi)
+			break;
+		if (wi == first_wi)
+			mask &= GENMASK_U64(63, first_bit);
+		if (wi == last_wi)
+			mask &= GENMASK_U64(last_bit, 0);
+		__cmask_word_andnot(&m->bits[wi], mask);
+	}
+}
+
 static __always_inline void cmask_zero(struct scx_cmask __arena *m)
 {
 	u32 nr_words = CMASK_NR_WORDS(m->nr_cids), i;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
 			break;
 		m->bits[i] = 0;
 	}
 }
 
+/**
+ * cmask_fill - Set every cid in @m's active range
+ * @m: cmask to fill
+ *
+ * Counterpart to cmask_zero(). Storage past the active range is left as is,
+ * matching the kernel-side scx_cmask_fill().
+ */
+static __always_inline void cmask_fill(struct scx_cmask __arena *m)
+{
+	u32 nr_words, head_bits, tail_bits, i;
+
+	if (!m->nr_cids)
+		return;
+	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
+
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		m->bits[i] = ~0LLU;
+	}
+
+	/* clear word-0 bits below base */
+	head_bits = m->base & 63;
+	if (head_bits)
+		m->bits[0] &= ~((1LLU << head_bits) - 1);
+
+	/* clear last-word bits at or past base + nr_cids */
+	tail_bits = (m->base + m->nr_cids) & 63;
+	if (tail_bits)
+		m->bits[nr_words - 1] &= (1LLU << tail_bits) - 1;
+}
+
+/**
+ * cmask_empty - Test whether no cid is set in @m's active range
+ * @m: cmask to test
+ *
+ * Scans the words the active range spans, whose bits outside the range every
+ * mutator keeps zero.
+ */
+static __always_inline bool cmask_empty(const struct scx_cmask __arena *m)
+{
+	u32 nr_words = cmask_nr_words(m), i;
+
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
+		if (i >= nr_words)
+			break;
+		if (m->bits[i])
+			return false;
+	}
+	return true;
+}
+
 /*
  * BPF_-prefixed to avoid colliding with the kernel's anonymous CMASK_OP_*
  * enum in ext/cid.c, which is exported via BTF and reachable through
@@ -291,92 +624,136 @@ enum {
 	BPF_CMASK_OP_ANDNOT,
 };
 
-static __always_inline void cmask_op_word(struct scx_cmask __arena *dst,
-					  const struct scx_cmask __arena *src,
-					  u32 di, u32 si, u64 mask, int op)
+/* range bits of word @k of @m, which spans @nr words: 0 past the span */
+static __always_inline u64 __cmask_word_range(const struct scx_cmask __arena *m, u32 k,
+					      u32 nr)
 {
-	u64 dv = dst->bits[di];
-	u64 sv = src->bits[si];
-	u64 rv;
+	u64 bits = ~0ULL;
 
-	if (op == BPF_CMASK_OP_AND)
-		rv = dv & sv;
-	else if (op == BPF_CMASK_OP_OR)
-		rv = dv | sv;
-	else if (op == BPF_CMASK_OP_ANDNOT)
-		rv = dv & ~sv;
-	else
-		rv = sv;
-
-	dst->bits[di] = (dv & ~mask) | (rv & mask);
+	if (k >= nr)
+		return 0;
+	if (k == 0)
+		bits &= GENMASK_U64(63, m->base & 63);
+	if (k == nr - 1)
+		bits &= GENMASK_U64((m->base + m->nr_cids - 1) & 63, 0);
+	return bits;
 }
 
-static __always_inline void cmask_op(struct scx_cmask __arena *dst,
-				     const struct scx_cmask __arena *src, int op)
+/*
+ * The binary operations combine cmasks of any active ranges. A cmask holds bits
+ * only for its own range and reads as the operation's identity outside it, all
+ * ones for AND and all zeros for OR, so an operand alters only the bits it
+ * covers: ANDing a shard's mask into a global one edits that shard's window and
+ * leaves the rest of the global mask alone. ANDNOT is AND with @src2 inverted
+ * over @src2's range, so where only @src2 has range the result is ~@src2.
+ *
+ * @dst is written on its range intersected with the union of the sources'
+ * ranges and untouched elsewhere, and its padding bits outside its own range
+ * stay zero, the invariant every cmask mutator keeps. @dst may alias either
+ * source, and the two sources may be one mask. Returns whether @dst has a bit
+ * set afterwards, over all of @dst's range.
+ *
+ * The operations are global functions, verified once per program. Inlined,
+ * every data-dependent branch in this loop would multiply the states the
+ * verifier explores per iteration at every call site.
+ */
+static __always_inline bool __cmask_op(struct scx_cmask __arena *dst,
+				       const struct scx_cmask __arena *src1,
+				       const struct scx_cmask __arena *src2, int op)
 {
-	u32 d_end = dst->base + dst->nr_cids;
-	u32 s_end = src->base + src->nr_cids;
-	u32 lo = dst->base > src->base ? dst->base : src->base;
-	u32 hi = d_end < s_end ? d_end : s_end;
-	u32 d_base = dst->base / 64;
-	u32 s_base = src->base / 64;
-	u32 lo_word, hi_word, i;
-	u64 head_mask, tail_mask;
-
-	if (lo >= hi)
-		return;
-
-	lo_word = lo / 64;
-	hi_word = (hi - 1) / 64;
-	head_mask = GENMASK_U64(63, lo & 63);
-	tail_mask = GENMASK_U64((hi - 1) & 63, 0);
-
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
-		u32 w = lo_word + i;
-		u64 m;
-
-		if (w > hi_word)
-			break;
-
-		m = GENMASK_U64(63, 0);
-		if (w == lo_word)
-			m &= head_mask;
-		if (w == hi_word)
-			m &= tail_mask;
+	u32 d_first = dst->base / 64, d_nr = cmask_nr_words(dst);
+	u32 s1_first = src1->base / 64, s1_nr = cmask_nr_words(src1);
+	u32 s2_first = src2->base / 64, s2_nr = cmask_nr_words(src2);
+	u64 any = bpf_arena_loop_zero;
+	u32 i;
 
-		cmask_op_word(dst, src, w - d_base, w - s_base, m, op);
+	bpf_arena_for(i, 0, d_nr) {
+		u32 k1 = d_first + i - s1_first, k2 = d_first + i - s2_first;
+		u64 m1 = __cmask_word_range(src1, k1, s1_nr);
+		u64 m2 = op == BPF_CMASK_OP_COPY ? m1 : __cmask_word_range(src2, k2, s2_nr);
+		u64 um = __cmask_word_range(dst, i, d_nr) & (m1 | m2);
+		u64 dv = dst->bits[i], v1, v2, rv;
+
+		if (um) {
+			/* a word in range holds zeros outside the range */
+			v1 = m1 ? src1->bits[k1] : 0;
+			v2 = m2 ? src2->bits[k2] : 0;
+			if (op == BPF_CMASK_OP_AND)
+				rv = (v1 | ~m1) & (v2 | ~m2);
+			else if (op == BPF_CMASK_OP_OR)
+				rv = v1 | v2;
+			else if (op == BPF_CMASK_OP_ANDNOT)
+				rv = (v1 | ~m1) & ~v2;
+			else
+				rv = v1;
+			dv = (dv & ~um) | (rv & um);
+			dst->bits[i] = dv;
+		}
+		any |= dv;
 	}
+	return any != 0;
 }
 
-/*
- * cmask_and/or/copy only modify @dst bits that lie in the intersection of
- * [@dst->base, @dst->base + @dst->nr_cids) and [@src->base,
- * @src->base + @src->nr_cids). Bits in @dst outside that window
- * keep their prior values - in particular, cmask_copy() does NOT zero @dst
- * bits that lie outside @src's range.
+/**
+ * cmask_and - Store @src1 AND @src2 in @dst
+ * @dst: destination, may be @src1 or @src2
+ * @src1: first operand
+ * @src2: second operand
+ *
+ * See __cmask_op() for how the ranges combine. Return whether @dst has a bit
+ * set afterwards.
  */
-static __always_inline void cmask_and(struct scx_cmask __arena *dst,
-				      const struct scx_cmask __arena *src)
+__weak bool cmask_and(struct scx_cmask __arena __arg_arena *dst,
+		      const struct scx_cmask __arena __arg_arena *src1,
+		      const struct scx_cmask __arena __arg_arena *src2)
 {
-	cmask_op(dst, src, BPF_CMASK_OP_AND);
+	return __cmask_op(dst, src1, src2, BPF_CMASK_OP_AND);
 }
 
-static __always_inline void cmask_or(struct scx_cmask __arena *dst,
-				     const struct scx_cmask __arena *src)
+/**
+ * cmask_or - Store @src1 OR @src2 in @dst
+ * @dst: destination, may be @src1 or @src2
+ * @src1: first operand
+ * @src2: second operand
+ *
+ * See __cmask_op() for how the ranges combine. Return whether @dst has a bit
+ * set afterwards.
+ */
+__weak bool cmask_or(struct scx_cmask __arena __arg_arena *dst,
+		     const struct scx_cmask __arena __arg_arena *src1,
+		     const struct scx_cmask __arena __arg_arena *src2)
 {
-	cmask_op(dst, src, BPF_CMASK_OP_OR);
+	return __cmask_op(dst, src1, src2, BPF_CMASK_OP_OR);
 }
 
-static __always_inline void cmask_copy(struct scx_cmask __arena *dst,
-				       const struct scx_cmask __arena *src)
+/**
+ * cmask_andnot - Store @src1 AND NOT @src2 in @dst
+ * @dst: destination, may be @src1 or @src2
+ * @src1: operand to remove bits from
+ * @src2: bits to remove, inverted over its own range
+ *
+ * See __cmask_op() for how the ranges combine. Return whether @dst has a bit
+ * set afterwards.
+ */
+__weak bool cmask_andnot(struct scx_cmask __arena __arg_arena *dst,
+			 const struct scx_cmask __arena __arg_arena *src1,
+			 const struct scx_cmask __arena __arg_arena *src2)
 {
-	cmask_op(dst, src, BPF_CMASK_OP_COPY);
+	return __cmask_op(dst, src1, src2, BPF_CMASK_OP_ANDNOT);
 }
 
-static __always_inline void cmask_andnot(struct scx_cmask __arena *dst,
-					 const struct scx_cmask __arena *src)
+/**
+ * cmask_copy - Copy @src into @dst
+ * @dst: destination
+ * @src: source
+ *
+ * The single-source case of __cmask_op(): @dst is written over @src's range and
+ * untouched elsewhere.
+ */
+__weak void cmask_copy(struct scx_cmask __arena __arg_arena *dst,
+		       const struct scx_cmask __arena __arg_arena *src)
 {
-	cmask_op(dst, src, BPF_CMASK_OP_ANDNOT);
+	__cmask_op(dst, src, src, BPF_CMASK_OP_COPY);
 }
 
 /*
@@ -395,7 +772,7 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
 		return true;
 	nr_words = (a->base + a->nr_cids - 1) / 64 - a->base / 64 + 1;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
 			break;
 		if (a->bits[i] != b->bits[i])
@@ -428,7 +805,7 @@ static __always_inline u32 cmask_next_set(const struct scx_cmask __arena *m, u32
 	start_wi = cid / 64 - base;
 	start_bit = cid & 63;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		u32 wi = start_wi + i;
 		u64 word;
 		u32 found;
@@ -457,7 +834,7 @@ static __always_inline u32 cmask_first_set(const struct scx_cmask __arena *m)
 
 #define cmask_for_each(cid, m)							\
 	for ((cid) = cmask_first_set(m);					\
-	     (cid) < (m)->base + (m)->nr_cids;					\
+	     (cid) < (m)->base + (m)->nr_cids && can_loop;			\
 	     (cid) = cmask_next_set((m), (cid) + 1))
 
 /*
@@ -495,7 +872,7 @@ static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
 	lo_word = lo / 64;
 	hi_word = (hi - 1) / 64;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		u32 w = lo_word + i;
 
 		if (w > hi_word)
@@ -514,13 +891,14 @@ static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
 static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
 {
 	u32 nr_words, i;
-	u32 count = 0;
+	/* callers compare the sum, see bpf_arena_loop_zero */
+	u32 count = bpf_arena_loop_zero;
 
 	if (!m->nr_cids)
 		return 0;
 	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
 			break;
 		count += __builtin_popcountll(m->bits[i]);
@@ -528,10 +906,7 @@ static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
 	return count;
 }
 
-/*
- * True if @a and @b share any set bit. Walk only the intersection of their
- * ranges, matching the semantics of cmask_and().
- */
+/* true if @a and @b share any set bit, over the intersection of their ranges */
 static __always_inline bool cmask_intersects(const struct scx_cmask __arena *a,
 					     const struct scx_cmask __arena *b)
 {
@@ -552,7 +927,7 @@ static __always_inline bool cmask_intersects(const struct scx_cmask __arena *a,
 	head_mask = GENMASK_U64(63, lo & 63);
 	tail_mask = GENMASK_U64((hi - 1) & 63, 0);
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		u32 w = lo_word + i;
 		u64 mask, av, bv;
 
@@ -603,7 +978,7 @@ static __always_inline u32 cmask_next_and_set(const struct scx_cmask __arena *a,
 	start_wi = start / 64;
 	start_bit = start & 63;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		u32 abs_wi = start_wi + i;
 		u64 word;
 		u32 found;
@@ -646,6 +1021,17 @@ static __always_inline u32 cmask_next_set_wrap(const struct scx_cmask __arena *m
 	return found < start ? found : end;
 }
 
+/**
+ * cmask_end - One past the last cid of @m's active range
+ * @m: cmask of interest
+ *
+ * The scan helpers return this value when no set cid is found.
+ */
+static __always_inline u32 cmask_end(const struct scx_cmask __arena *m)
+{
+	return m->base + m->nr_cids;
+}
+
 /*
  * Find the next cid set in both @a and @b at or after @start, wrapping to
  * @a->base if none found in the forward half. Return a->base + a->nr_cids
@@ -668,6 +1054,121 @@ static __always_inline u32 cmask_next_and_set_wrap(const struct scx_cmask __aren
 	return found < start ? found : a_end;
 }
 
+/*
+ * The distribute helpers rotate through one slot per cid, a cacheline each so
+ * picks on one CPU do not bounce the line of another. A missing allocation is a
+ * setup bug and aborts the scheduler. On a CPU outside the scheduler's cid
+ * space the helpers fall back to the first matching cid.
+ *
+ * TODO: The slots are one allocation without node placement. Move them to a
+ * per-cid arena allocator once the library has one, for node-local slots
+ * without the cacheline padding.
+ */
+struct cmask_rotor_slot {
+	u32 cid;
+} __attribute__((aligned(SCX_CACHELINE_SIZE)));
+
+struct cmask_rotor_slot __arena *cmask_distribute_rotors __weak;
+
+/**
+ * cmask_distribute_init - Allocate the distribute rotor from @map
+ * @map: the scheduler's arena map
+ *
+ * The shared arena init calls this once. A scheduler with its own arena calls
+ * it before the first distribute pick. On a kernel without the cid kfuncs
+ * nothing can pick, so the call allocates nothing and succeeds. Return 0 on
+ * success, -ENOMEM if the allocation fails.
+ */
+static __always_inline int cmask_distribute_init(void *map)
+{
+	u64 size;
+	u32 pages;
+
+	/* no cid kfuncs means no picks and nothing to allocate */
+	if (!bpf_ksym_exists(scx_bpf_nr_cids))
+		return 0;
+
+	size = scx_bpf_nr_cids() * sizeof(*cmask_distribute_rotors);
+	pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
+	cmask_distribute_rotors = bpf_arena_alloc_pages(map, NULL, pages, NUMA_NO_NODE, 0);
+	return cmask_distribute_rotors ? 0 : -ENOMEM;
+}
+
+static __always_inline u32 __arena *__cmask_distribute_rotor(void)
+{
+	s32 cid = scx_bpf_this_cid();
+
+	if (unlikely(!cmask_distribute_rotors)) {
+		scx_bpf_error("cmask distribute rotor not allocated");
+		return NULL;
+	}
+	if (cid < 0)
+		return NULL;
+	return &cmask_distribute_rotors[cid].cid;
+}
+
+/**
+ * cmask_any_distribute - Pick a set cid, spreading successive picks
+ * @m: cmask to pick from
+ *
+ * Counterpart of bpf_cpumask_any_distribute(): a per-cid rotor makes successive
+ * picks rotate through the set cids instead of repeating the first one. Returns
+ * cmask_end(@m) if @m is empty.
+ */
+static __always_inline u32 cmask_any_distribute(const struct scx_cmask __arena *m)
+{
+	u32 __arena *rotor = __cmask_distribute_rotor();
+	u32 pick;
+
+	if (unlikely(!rotor))
+		return cmask_first_set(m);
+
+	pick = cmask_next_set_wrap(m, *rotor + 1);
+	if (pick < cmask_end(m))
+		*rotor = pick;
+	return pick;
+}
+
+/**
+ * cmask_any_and_distribute - Pick a cid set in both masks, spreading picks
+ * @a: first cmask, the scan is bounded by its range
+ * @b: second cmask
+ *
+ * Counterpart of bpf_cpumask_any_and_distribute(). Shares the rotor with
+ * cmask_any_distribute() the same way the kernel counterparts share theirs.
+ * Returns cmask_end(@a) if the intersection is empty.
+ */
+static __always_inline u32 cmask_any_and_distribute(const struct scx_cmask __arena *a,
+						    const struct scx_cmask __arena *b)
+{
+	u32 __arena *rotor = __cmask_distribute_rotor();
+	u32 pick;
+
+	if (unlikely(!rotor))
+		return cmask_next_and_set(a, b, a->base);
+
+	pick = cmask_next_and_set_wrap(a, b, *rotor + 1);
+	if (pick < cmask_end(a))
+		*rotor = pick;
+	return pick;
+}
+
+/**
+ * cmask_distribute_rotor_pos - Last cid picked by the distribute helpers
+ *
+ * For callers that anchor scans of their own on the shared rotor. Returns 0
+ * when nothing has been picked on this cid yet or the CPU is outside the cid
+ * space.
+ */
+static __always_inline u32 cmask_distribute_rotor_pos(void)
+{
+	u32 __arena *rotor = __cmask_distribute_rotor();
+
+	if (unlikely(!rotor))
+		return 0;
+	return *rotor;
+}
+
 /*
  * Like cmask_next_and_set() but over the intersection of THREE masks. Return
  * a->base + a->nr_cids if no cid is set in all three at or after @start.
@@ -701,7 +1202,7 @@ static __always_inline u32 cmask_next_and2_set(const struct scx_cmask __arena *a
 	start_wi = start / 64;
 	start_bit = start & 63;
 
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
+	bpf_arena_for(i, 0, CMASK_MAX_WORDS) {
 		u32 abs_wi = start_wi + i;
 		u64 word;
 		u32 found;
@@ -763,7 +1264,7 @@ static __always_inline void cmask_from_cpumask(struct scx_cmask __arena *m,
 	s32 cpu;
 
 	cmask_zero(m);
-	bpf_for(cpu, 0, nr_cpu_ids) {
+	bpf_arena_for(cpu, 0, nr_cpu_ids) {
 		s32 cid;
 
 		if (!bpf_cpumask_test_cpu(cpu, cpumask))
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5003e33f5142..deeae74ee5ff 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -27,6 +27,7 @@
 #include "user_exit_info.bpf.h"
 #include "enum_defs.autogen.h"
 #include "bpf_arena_common.bpf.h"
+#include "const-defs.h"
 
 #define PF_IDLE				0x00000002	/* I am an IDLE thread */
 #define PF_IO_WORKER			0x00000010	/* Task is an IO worker */
@@ -107,8 +108,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
 s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
 s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
 s32 scx_bpf_cid_node(s32 cid) __ksym __weak;
-void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz) __ksym __weak;
-void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
+/* scx_bpf_cid_topo() and scx_bpf_kick_cid() are declared in compat.bpf.h */
 s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
 s32 scx_bpf_this_cid(void) __ksym __weak;
 struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
@@ -117,7 +117,7 @@ u32 scx_bpf_nr_online_cids(void) __ksym __weak;
 const void __arena *scx_bpf_online_cmask(void) __ksym __weak;
 u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
 u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
-s32 scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
+/* scx_bpf_cidperf_set() is declared in compat.bpf.h */
 
 /* sub-scheduler cap control, scx_bpf_sub_caps() cgroup_id 0 == self */
 s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps, const struct scx_cmask __arena *cmask__arena, struct scx_cmask __arena *denied_out__arena__nullable) __ksym __weak;
@@ -534,14 +534,14 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 /*
  * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) calls
  * migrate_disable() for the current task. Recorded once by
- * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires during
- * the natural scheduler-attach call chain (auto-attached by scx_ops_attach!).
+ * scx_lib_init_probe, an fentry program that fires during the natural
+ * scheduler-attach call chain (auto-attached by scx_ops_attach!).
  *
- * Defaults to true (conservative). Over-reporting in is_migration_disabled()
+ * Defaults to false (conservative). Over-reporting in is_migration_disabled()
  * causes local-only dispatch, which is safe. Under-reporting can crash the
  * scheduler, so we err high if the probe somehow fails to run.
  */
-bool __scx_prolog_disables_migration __weak = true;
+bool __scx_prolog_disables_migration __weak = false;
 
 /*
  * scx_lib_init_probe - non-sleepable prolog probe.
@@ -552,13 +552,20 @@ bool __scx_prolog_disables_migration __weak = true;
  * ops.init() fires. Its address is taken in the vtable, so the symbol
  * is non-inlinable and has been stable since introduction.
  *
+ * A cid-form scheduler registers through bpf_scx_reg_cid(), the .reg
+ * callback of bpf_sched_ext_ops_cid, and so never enters bpf_scx_reg().
+ * The cid-form open paths (SCX_OPS_CID_OPEN(), scx_ops_cid_open!())
+ * therefore repoint this program at bpf_scx_reg_cid(). Repointing rather
+ * than adding a second program keeps the object loadable on kernels
+ * predating the cid form, where bpf_scx_reg_cid() has no BTF entry.
+ *
  * Entering via fentry runs us through __bpf_prog_enter -- the
  * non-sleepable prolog that consumers of is_migration_disabled() live
  * under.
  *
  * Loud warning: the prolog adds at most 1 to migration_disabled.
  * Reading > 1 means something upstream in the
- * bpf_struct_ops_link_create -> bpf_scx_reg path disabled migration
+ * bpf_struct_ops_link_create -> .reg path disabled migration
  * before the prolog ran, invalidating the probe; audit and adjust.
  */
 SEC("fentry/bpf_scx_reg") __weak
@@ -1186,8 +1193,75 @@ static inline u64 scx_clock_irq(u32 cpu)
 #define struct_size_t(type, member, count)	\
 	struct_size((type *)NULL, member, count)
 
+/*
+ * <linux/stddef.h>'s TRAILING_OVERLAP(): embed a struct that ends in a flexible
+ * array member together with its storage. @NAME is a complete @TYPE and the
+ * @MEMBERS declared after the array reserve the space the array grows into.
+ * Unlike the kernel's, the padding is named after @NAME so that one struct can
+ * embed several, and it is sized with __builtin_offsetof() because
+ * bpf_helpers.h redefines offsetof() as a pointer cast, which is not a constant
+ * expression.
+ */
+#define __TRAILING_OVERLAP(TYPE, NAME, FAM, ATTRS, MEMBERS)			\
+	union {									\
+		TYPE NAME;							\
+		struct {							\
+			unsigned char __offset_to_##NAME[__builtin_offsetof(TYPE, FAM)]; \
+			MEMBERS							\
+		} ATTRS;							\
+	}
+
+#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
+	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
+
+/*
+ * Loop counters the verifier cannot see through.
+ *
+ * A may_goto loop converges when the state at its head is within the state
+ * of a previous iteration. A counter tracked as a precise constant prevents
+ * that convergence: every iteration creates a new state, and the verifier
+ * unrolls the loop until it runs out of budget whenever the counter feeds an
+ * operation that requires precision.
+ *
+ * Loading a writable global gives the verifier an unknown scalar while its
+ * runtime value remains one. Using it as the step makes the counter unknown
+ * after the first iteration, and the load on every increment keeps the loop
+ * body from making it precise again. volatile is required to keep the compiler
+ * from hoisting or eliminating the loads, and the value must remain non-const
+ * so the verifier cannot resolve it. The variable is weak so the objects linked
+ * into a scheduler share one copy. Its runtime value must never be changed from
+ * one.
+ *
+ * bpf_for() avoids this verifier behavior too, but calls bpf_iter_num_next()
+ * on every iteration. bpf_arena_for() is intended for hot scheduler walks
+ * where that cost matters. @var must be no wider than u32, and @start and
+ * @end must be representable as u32.
+ */
+volatile u32 bpf_arena_loop_one __weak = 1;
+
+/*
+ * A loop-carried accumulator that a caller later compares is kept precise, and
+ * a precise scalar whose range grows every iteration keeps a may_goto loop from
+ * converging. Initializing it from this zero makes it unknown from the first
+ * iteration, so every pass through the loop head looks the same.
+ */
+volatile u32 bpf_arena_loop_zero __weak = 0;
+
+#define __bpf_arena_loop_start(var, start)				\
+	({								\
+		_Static_assert(sizeof(var) <= sizeof(u32),		\
+			       "bpf_arena_for() index must fit in u32");	\
+		(start);						\
+	})
+
+#define bpf_arena_for(var, start, end)					\
+	for (var = __bpf_arena_loop_start(var, start);			\
+	     var < (end) && can_loop;					\
+	     var += bpf_arena_loop_one)
+
 #include "compat.bpf.h"
 #include "enums.bpf.h"
+#include "features.bpf.h"
 #include "cid.bpf.h"
 
 #endif	/* __SCX_COMMON_BPF_H */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index c5c90d1d81e0..f5726bbfe91b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -143,6 +143,69 @@ static inline void scx_bpf_cid_override(const s32 __arena *cpu_to_cid, u32 cpu_t
 					      shard_start, shard_start_cnt);
 }
 
+/*
+ * v7.3: b38332be61a8 ("sched_ext: Make scx_bpf_kick_cid() return void") flipped
+ * the return type from s32 to void without renaming the kfunc, so the v7.2 and
+ * v7.3 kfuncs share a name but have incompatible prototypes. libbpf leaves a
+ * weak kfunc unresolved when the prototype doesn't match, so declare both
+ * flavors: the ___vN suffix is stripped on the BPF side, both resolve against
+ * the same kernel symbol and only the matching one gets bound. Drop the
+ * wrapper and move the decl back to common.bpf.h after v7.6.
+ */
+void scx_bpf_kick_cid___v2(s32 cid, u64 flags) __ksym __weak;
+s32 scx_bpf_kick_cid___v1(s32 cid, u64 flags) __ksym __weak;
+
+static inline void scx_bpf_kick_cid(s32 cid, u64 flags)
+{
+	if (bpf_ksym_exists(scx_bpf_kick_cid___v2))
+		scx_bpf_kick_cid___v2(cid, flags);
+	else if (bpf_ksym_exists(scx_bpf_kick_cid___v1))
+		scx_bpf_kick_cid___v1(cid, flags);
+}
+
+/*
+ * v7.3: 94480606a677 ("sched_ext: Add a size argument to scx_bpf_cid_topo() so
+ * struct scx_cid_topo can grow") added out__sz without renaming the kfunc, so
+ * the v7.2 and v7.3 kfuncs share a name with incompatible prototypes. Same
+ * two-flavor trick as scx_bpf_kick_cid() above. The size is always the output
+ * buffer's, so a macro supplies it and callers keep the two-argument form.
+ * Drop the wrapper and move the decl back to common.bpf.h after v7.6.
+ */
+void scx_bpf_cid_topo___v2(s32 cid, struct scx_cid_topo *out, size_t out__sz) __ksym __weak;
+void scx_bpf_cid_topo___v1(s32 cid, struct scx_cid_topo *out) __ksym __weak;
+
+static inline void __scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz)
+{
+	if (bpf_ksym_exists(scx_bpf_cid_topo___v2))
+		scx_bpf_cid_topo___v2(cid, out, out__sz);
+	else if (bpf_ksym_exists(scx_bpf_cid_topo___v1))
+		scx_bpf_cid_topo___v1(cid, out);
+}
+
+#define scx_bpf_cid_topo(cid, out) __scx_bpf_cid_topo((cid), (out), sizeof(*(out)))
+
+/*
+ * v7.3: 3a21e34eb258 ("sched_ext: Gate scx_bpf_cidperf_set() behind a new
+ * SCX_CAP_PERF") flipped the return type the other way, from void to s32, again
+ * without renaming the kfunc. Same two-flavor trick as scx_bpf_kick_cid()
+ * above; the v7.2 kfunc can't fail, so report success for it. Drop the wrapper
+ * and move the decl back to common.bpf.h after v7.6.
+ */
+s32 scx_bpf_cidperf_set___v2(s32 cid, u32 perf) __ksym __weak;
+void scx_bpf_cidperf_set___v1(s32 cid, u32 perf) __ksym __weak;
+
+static inline s32 scx_bpf_cidperf_set(s32 cid, u32 perf)
+{
+	if (bpf_ksym_exists(scx_bpf_cidperf_set___v2)) {
+		return scx_bpf_cidperf_set___v2(cid, perf);
+	} else if (bpf_ksym_exists(scx_bpf_cidperf_set___v1)) {
+		scx_bpf_cidperf_set___v1(cid, perf);
+		return 0;
+	} else {
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 58253fe8e85d..07fb55e63c57 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -336,9 +336,20 @@ static inline long scx_hotplug_seq(void)
 /*
  * Open a cid-form (struct sched_ext_ops_cid) skeleton. The cid form postdates
  * every op the load-time fix-ups above handle, so none of them apply.
+ *
+ * A cid-form scheduler registers through bpf_scx_reg_cid() rather than
+ * bpf_scx_reg(), so repoint common.bpf.h's prolog probe at it. Both the cid
+ * form and bpf_scx_reg_cid() appeared in v7.2, so a kernel that accepts this
+ * skeleton always has the symbol.
  */
-#define SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
-	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", __opts)
+#define SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, __opts) ({		\
+	struct __scx_name *__cskel;						\
+										\
+	__cskel = __SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", __opts); \
+	bpf_program__set_attach_target(__cskel->progs.scx_lib_init_probe, 0,	\
+				       "bpf_scx_reg_cid");			\
+	__cskel;								\
+})
 
 #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
 	SCX_OPS_CID_OPEN_OPTS(__ops_name, __scx_name, 0)
diff --git a/tools/sched_ext/include/scx/const-defs.h b/tools/sched_ext/include/scx/const-defs.h
new file mode 100644
index 000000000000..4c8f45756b51
--- /dev/null
+++ b/tools/sched_ext/include/scx/const-defs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+#pragma once
+
+/*
+ * Constants shared across the BPF headers, the lib and the schedulers.
+ * Freestanding so that scheduler interface headers consumed by bindgen can
+ * include it. Rust code cannot, so rust/scx_arena/scx_arena/src/lib.rs mirrors
+ * the values. Keep them in sync.
+ */
+enum scx_const_defs {
+	/* mirrors the kernel's per-arch L1_CACHE_SHIFT */
+#if defined(__TARGET_ARCH_s390) || defined(__s390x__)
+	SCX_CACHELINE_SIZE	= 256,
+#elif defined(__TARGET_ARCH_powerpc) || defined(__powerpc64__)
+	SCX_CACHELINE_SIZE	= 128,
+#else
+	SCX_CACHELINE_SIZE	= 64,
+#endif
+};
diff --git a/tools/sched_ext/include/scx/features.bpf.h b/tools/sched_ext/include/scx/features.bpf.h
new file mode 100644
index 000000000000..992f4a74b277
--- /dev/null
+++ b/tools/sched_ext/include/scx/features.bpf.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel features the loader probes before load and hands to the BPF side in
+ * one rodata word, so that a program can carry both the path a feature enables
+ * and its fallback while the verifier prunes the one the running kernel cannot
+ * take. scx_utils sets the word in the ops open macros. The bits are mirrored
+ * in rust/scx_utils/src/compat.rs.
+ *
+ * Included by scx/common.bpf.h; don't include directly.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef __SCX_FEATURES_BPF_H
+#define __SCX_FEATURES_BPF_H
+
+enum scx_lib_feature {
+	/* the JIT lowers fetching AND, OR and XOR on arena pointers */
+	SCX_LIB_FEAT_ARENA_FETCH_BITOPS		= 1ULL << 0,
+};
+
+const volatile u64 scx_lib_features __weak;
+
+static __always_inline bool scx_lib_has(u64 feat)
+{
+	return scx_lib_features & feat;
+}
+
+#endif	/* __SCX_FEATURES_BPF_H */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 81575294027e..3566e3e02e21 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -1473,7 +1473,8 @@ __noinline void compute_partition(void)
 	/* find out the cids we hold */
 	scx_bpf_sub_caps(0, SCX_CAP_ENQ, &qa.held_excl.mask);
 	scx_bpf_sub_caps(0, SCX_CAP_ENQ_IMMED, &qa.held_shared.mask);
-	cmask_andnot(&qa.held_shared.mask, &qa.held_excl.mask);	/* held only as ENQ_IMMED */
+	/* held only as ENQ_IMMED */
+	cmask_andnot(&qa.held_shared.mask, &qa.held_shared.mask, &qa.held_excl.mask);
 
 	qa.part.nr_shared = 0;
 	qa.part.nr_rr = 0;
@@ -1628,8 +1629,7 @@ static __noinline void account_alloc(void)
  */
 static void refresh_usable(void)
 {
-	cmask_copy(&qa.usable_scratch.mask, &qa.self_cids.mask);
-	cmask_and(&qa.usable_scratch.mask, &qa.avail_cids.mask);
+	cmask_and(&qa.usable_scratch.mask, &qa.self_cids.mask, &qa.avail_cids.mask);
 	cmask_copy(&qa.usable_cids.mask, &qa.usable_scratch.mask);
 }
 
@@ -1708,10 +1708,8 @@ __noinline void apply_partition(void)
 		if (!cgid)
 			continue;
 
-		cmask_copy(&qa.to_revoke_cids.mask, &ssc->prev_granted.mask);
-		cmask_andnot(&qa.to_revoke_cids.mask, &ssc->granted_cids.mask);
-		cmask_copy(&qa.to_grant_cids.mask, &ssc->granted_cids.mask);
-		cmask_andnot(&qa.to_grant_cids.mask, &ssc->prev_granted.mask);
+		cmask_andnot(&qa.to_revoke_cids.mask, &ssc->prev_granted.mask, &ssc->granted_cids.mask);
+		cmask_andnot(&qa.to_grant_cids.mask, &ssc->granted_cids.mask, &ssc->prev_granted.mask);
 
 		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
 				   &qa.prev_rr_cids.mask);
@@ -1957,7 +1955,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 
 	scx_bpf_sub_caps(0, SCX_CAP_ENQ, &qa.held_excl.mask);
 	scx_bpf_sub_caps(0, SCX_CAP_ENQ_IMMED, &qa.held_shared.mask);
-	cmask_andnot(&qa.held_shared.mask, &qa.held_excl.mask);
+	cmask_andnot(&qa.held_shared.mask, &qa.held_shared.mask, &qa.held_excl.mask);
 
 	bpf_for(i, 0, MAX_SUB_SCHEDS) {
 		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, nr_cids);
-- 
2.55.0

