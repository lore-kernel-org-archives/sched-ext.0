Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8E3CEBA6;
	Sun, 17 May 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042977; cv=none; b=i6HYmB5WEIQ/kkhqupIIlcP0BmpWCiH9eh6rTa/T5UBCcHfzVf3Z/snRp8AxsCTDeSInZ96Z82jw3Qwui3Mby35Dar4YOMU5H8nHx4ntav7LcZW1rwKAI7d8ZZhpnTmN7gQskOuEsI1SF4pe7yMm29EUHBZwGstottH+BtjoDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042977; c=relaxed/simple;
	bh=Yv5kgu2QkDrPg8aT11HONTvat7KacStUE5UVY855lE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UevdIHufHTnUSq6EiWPJk9ojYjcvqu8VgE/OwBTIEZWh64n3ZB33pL9xSglBqdcEq5hRdhrIJVjG++kc3+IjI7tROcc50AVe5fK8cOFAb10FipBKV9vG3cxSYxwHTWcPEAL/3V0Ikb4b3hKHnYEYaXfYjWACmRuyhk9sxjb9x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf2m+pZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf2m+pZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5C1C2BCB0;
	Sun, 17 May 2026 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042976;
	bh=Yv5kgu2QkDrPg8aT11HONTvat7KacStUE5UVY855lE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yf2m+pZU+JvMhA+NQSJ2RZBRyxSTdUyZEOZAFiuKFy2UaPBiaabbYuwLd2pKLBsh/
	 zDTHRUBqcsQXFjQr0ZhpzRbjcu2vggZWWPHgoGDnYMehOWWNXB7kiiiwSilL4n0SC8
	 aj3pK+BnuDlxBWTPzgk0qYF1oVYJMdN/QwywQJh4DYKU19Gm0/L0sr+pSKbfsWMmKM
	 EHP4dejmPUfg5zxMLlRFeDDJiYdc6uRnFGWRWnObsCFmbI2+592/P80kFXYLLRFYef
	 3r/csKcqyvJBgTmQ4xsBevt0HneU2pcGge5vXGwVzxAabBd4ehoXv1lNmGLphw1XMW
	 byeYmL1uEYk+A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Rename scx_cmask.nr_bits to nr_cids
Date: Sun, 17 May 2026 08:36:12 -1000
Message-ID: <20260517183614.1191534-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517183614.1191534-1-tj@kernel.org>
References: <20260517183614.1191534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct scx_cmask is a base-windowed bitmap over cid space. Each bit
represents one cid, so the count of active bits is the count of cids. The
sibling struct scx_cid_shard already uses nr_cids. Rename as a prep so the
following patches that grow the cmask API can use the consistent name.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.h                |  8 ++--
 kernel/sched/ext_types.h              | 12 ++---
 tools/sched_ext/include/scx/cid.bpf.h | 64 +++++++++++++--------------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index f41d48afb7d1..e1c44a180bb1 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -138,7 +138,7 @@ static inline bool scx_is_cid_type(void)
 
 static inline bool __scx_cmask_contains(const struct scx_cmask *m, u32 cid)
 {
-	return likely(cid >= m->base && cid < m->base + m->nr_bits);
+	return likely(cid >= m->base && cid < m->base + m->nr_cids);
 }
 
 /* Word in bits[] covering @cid. @cid must satisfy __scx_cmask_contains(). */
@@ -147,11 +147,11 @@ static inline u64 *__scx_cmask_word(const struct scx_cmask *m, u32 cid)
 	return (u64 *)&m->bits[cid / 64 - m->base / 64];
 }
 
-static inline void scx_cmask_init(struct scx_cmask *m, u32 base, u32 nr_bits)
+static inline void scx_cmask_init(struct scx_cmask *m, u32 base, u32 nr_cids)
 {
 	m->base = base;
-	m->nr_bits = nr_bits;
-	memset(m->bits, 0, SCX_CMASK_NR_WORDS(nr_bits) * sizeof(u64));
+	m->nr_cids = nr_cids;
+	memset(m->bits, 0, SCX_CMASK_NR_WORDS(nr_cids) * sizeof(u64));
 }
 
 static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
index ebb8cdf90612..c6c4e3db7311 100644
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
@@ -67,10 +67,10 @@ struct scx_cid_topo {
  * cmask: variable-length, base-windowed bitmap over cid space
  * -----------------------------------------------------------
  *
- * A cmask covers the cid range [base, base + nr_bits). bits[] is aligned to the
+ * A cmask covers the cid range [base, base + nr_cids). bits[] is aligned to the
  * global 64-cid grid: bits[0] spans [base & ~63, (base & ~63) + 64), so the
  * first (base & 63) bits of bits[0] are head padding and any tail past base +
- * nr_bits is tail padding. Both must stay zero for the lifetime of the mask;
+ * nr_cids is tail padding. Both must stay zero for the lifetime of the mask;
  * all mutating helpers preserve that invariant.
  *
  * Grid alignment means two cmasks always address bits[] against the same global
@@ -82,21 +82,21 @@ struct scx_cid_topo {
  */
 struct scx_cmask {
 	u32 base;
-	u32 nr_bits;
+	u32 nr_cids;
 	DECLARE_FLEX_ARRAY(u64, bits);
 };
 
 /*
- * Number of u64 words of bits[] storage that covers @nr_bits regardless of base
+ * Number of u64 words of bits[] storage that covers @nr_cids regardless of base
  * alignment. The +1 absorbs up to 63 bits of head padding when base is not
  * 64-aligned - always allocating one extra word beats branching on base or
  * splitting the compute.
  */
-#define SCX_CMASK_NR_WORDS(nr_bits)	(((nr_bits) + 63) / 64 + 1)
+#define SCX_CMASK_NR_WORDS(nr_cids)	(((nr_cids) + 63) / 64 + 1)
 
 /*
  * Define an on-stack cmask for up to @cap_bits. @name is a struct scx_cmask *
- * aliasing zero-initialized storage; call scx_cmask_init() to set base/nr_bits.
+ * aliasing zero-initialized storage; call scx_cmask_init() to set base/nr_cids.
  */
 #define SCX_CMASK_DEFINE(name, cap_bits)	\
 	DEFINE_RAW_FLEX(struct scx_cmask, name, bits, SCX_CMASK_NR_WORDS(cap_bits))
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 7a867e435670..b9dcc14870d3 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -32,11 +32,11 @@
 #define CMASK_MAX_WORDS 129
 #endif
 
-#define CMASK_NR_WORDS(nr_bits)		(((nr_bits) + 63) / 64 + 1)
+#define CMASK_NR_WORDS(nr_cids)		(((nr_cids) + 63) / 64 + 1)
 
 static __always_inline bool __cmask_contains(const struct scx_cmask __arena *m, u32 cid)
 {
-	return cid >= m->base && cid < m->base + m->nr_bits;
+	return cid >= m->base && cid < m->base + m->nr_cids;
 }
 
 static __always_inline u64 __arena *__cmask_word(const struct scx_cmask __arena *m, u32 cid)
@@ -44,12 +44,12 @@ static __always_inline u64 __arena *__cmask_word(const struct scx_cmask __arena
 	return (u64 __arena *)&m->bits[cid / 64 - m->base / 64];
 }
 
-static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 base, u32 nr_bits)
+static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 base, u32 nr_cids)
 {
-	u32 nr_words = CMASK_NR_WORDS(nr_bits), i;
+	u32 nr_words = CMASK_NR_WORDS(nr_cids), i;
 
 	m->base = base;
-	m->nr_bits = nr_bits;
+	m->nr_cids = nr_cids;
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
@@ -206,7 +206,7 @@ static __always_inline bool __cmask_test_and_clear(struct scx_cmask __arena *m,
 
 static __always_inline void cmask_zero(struct scx_cmask __arena *m)
 {
-	u32 nr_words = CMASK_NR_WORDS(m->nr_bits), i;
+	u32 nr_words = CMASK_NR_WORDS(m->nr_cids), i;
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
@@ -250,8 +250,8 @@ static __always_inline void cmask_op_word(struct scx_cmask __arena *dst,
 static __always_inline void cmask_op(struct scx_cmask __arena *dst,
 				     const struct scx_cmask __arena *src, int op)
 {
-	u32 d_end = dst->base + dst->nr_bits;
-	u32 s_end = src->base + src->nr_bits;
+	u32 d_end = dst->base + dst->nr_cids;
+	u32 s_end = src->base + src->nr_cids;
 	u32 lo = dst->base > src->base ? dst->base : src->base;
 	u32 hi = d_end < s_end ? d_end : s_end;
 	u32 d_base = dst->base / 64;
@@ -286,8 +286,8 @@ static __always_inline void cmask_op(struct scx_cmask __arena *dst,
 
 /*
  * cmask_and/or/copy only modify @dst bits that lie in the intersection of
- * [@dst->base, @dst->base + @dst->nr_bits) and [@src->base,
- * @src->base + @src->nr_bits). Bits in @dst outside that window
+ * [@dst->base, @dst->base + @dst->nr_cids) and [@src->base,
+ * @src->base + @src->nr_cids). Bits in @dst outside that window
  * keep their prior values - in particular, cmask_copy() does NOT zero @dst
  * bits that lie outside @src's range.
  */
@@ -325,9 +325,9 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
 {
 	u32 nr_words, i;
 
-	if (a->base != b->base || a->nr_bits != b->nr_bits)
+	if (a->base != b->base || a->nr_cids != b->nr_cids)
 		return false;
-	nr_words = CMASK_NR_WORDS(a->nr_bits);
+	nr_words = CMASK_NR_WORDS(a->nr_cids);
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
@@ -345,8 +345,8 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
 static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
 					 const struct scx_cmask __arena *b)
 {
-	u32 a_end = a->base + a->nr_bits;
-	u32 b_end = b->base + b->nr_bits;
+	u32 a_end = a->base + a->nr_cids;
+	u32 b_end = b->base + b->nr_cids;
 	u32 a_wbase = a->base / 64;
 	u32 b_wbase = b->base / 64;
 	u32 nr_words, i;
@@ -355,7 +355,7 @@ static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
 	if (a->base < b->base || a_end > b_end)
 		return false;
 
-	nr_words = CMASK_NR_WORDS(a->nr_bits);
+	nr_words = CMASK_NR_WORDS(a->nr_cids);
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		u32 wi_b;
 
@@ -373,13 +373,13 @@ static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
  * @m: cmask to search
  * @cid: starting cid (clamped to @m->base if below)
  *
- * Returns the smallest set cid in [@cid, @m->base + @m->nr_bits), or
- * @m->base + @m->nr_bits if none (the out-of-range sentinel matches the
+ * Returns the smallest set cid in [@cid, @m->base + @m->nr_cids), or
+ * @m->base + @m->nr_cids if none (the out-of-range sentinel matches the
  * termination condition used by cmask_for_each()).
  */
 static __always_inline u32 cmask_next_set(const struct scx_cmask __arena *m, u32 cid)
 {
-	u32 end = m->base + m->nr_bits;
+	u32 end = m->base + m->nr_cids;
 	u32 base = m->base / 64;
 	u32 last_wi = (end - 1) / 64 - base;
 	u32 start_wi, start_bit, i;
@@ -421,17 +421,17 @@ static __always_inline u32 cmask_first_set(const struct scx_cmask __arena *m)
 
 #define cmask_for_each(cid, m)							\
 	for ((cid) = cmask_first_set(m);					\
-	     (cid) < (m)->base + (m)->nr_bits;					\
+	     (cid) < (m)->base + (m)->nr_cids;					\
 	     (cid) = cmask_next_set((m), (cid) + 1))
 
 /*
- * Population count over [base, base + nr_bits). Padding bits in the head/tail
+ * Population count over [base, base + nr_cids). Padding bits in the head/tail
  * words are guaranteed zero by the mutating helpers, so a flat popcount over
  * all words is correct.
  */
 static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
 {
-	u32 nr_words = CMASK_NR_WORDS(m->nr_bits), i;
+	u32 nr_words = CMASK_NR_WORDS(m->nr_cids), i;
 	u32 count = 0;
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
@@ -449,8 +449,8 @@ static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
 static __always_inline bool cmask_intersects(const struct scx_cmask __arena *a,
 					     const struct scx_cmask __arena *b)
 {
-	u32 a_end = a->base + a->nr_bits;
-	u32 b_end = b->base + b->nr_bits;
+	u32 a_end = a->base + a->nr_cids;
+	u32 b_end = b->base + b->nr_cids;
 	u32 lo = a->base > b->base ? a->base : b->base;
 	u32 hi = a_end < b_end ? a_end : b_end;
 	u32 a_base = a->base / 64;
@@ -489,7 +489,7 @@ static __always_inline bool cmask_intersects(const struct scx_cmask __arena *a,
 
 /*
  * Find the next cid set in both @a and @b at or after @start, bounded by the
- * intersection of the two ranges. Return a->base + a->nr_bits if none found.
+ * intersection of the two ranges. Return a->base + a->nr_cids if none found.
  *
  * Building block for cmask_next_and_set_wrap(). Callers that want a bounded
  * scan without wrap call this directly.
@@ -498,8 +498,8 @@ static __always_inline u32 cmask_next_and_set(const struct scx_cmask __arena *a,
 					      const struct scx_cmask __arena *b,
 					      u32 start)
 {
-	u32 a_end = a->base + a->nr_bits;
-	u32 b_end = b->base + b->nr_bits;
+	u32 a_end = a->base + a->nr_cids;
+	u32 b_end = b->base + b->nr_cids;
 	u32 a_wbase = a->base / 64;
 	u32 b_wbase = b->base / 64;
 	u32 lo = a->base > b->base ? a->base : b->base;
@@ -541,15 +541,15 @@ static __always_inline u32 cmask_next_and_set(const struct scx_cmask __arena *a,
 
 /*
  * Find the next set cid in @m at or after @start, wrapping to @m->base if no
- * set bit is found in [start, m->base + m->nr_bits). Return m->base +
- * m->nr_bits if @m is empty.
+ * set bit is found in [start, m->base + m->nr_cids). Return m->base +
+ * m->nr_cids if @m is empty.
  *
  * Callers do round-robin distribution by passing (last_cid + 1) as @start.
  */
 static __always_inline u32 cmask_next_set_wrap(const struct scx_cmask __arena *m,
 					       u32 start)
 {
-	u32 end = m->base + m->nr_bits;
+	u32 end = m->base + m->nr_cids;
 	u32 found;
 
 	found = cmask_next_set(m, start);
@@ -562,7 +562,7 @@ static __always_inline u32 cmask_next_set_wrap(const struct scx_cmask __arena *m
 
 /*
  * Find the next cid set in both @a and @b at or after @start, wrapping to
- * @a->base if none found in the forward half. Return a->base + a->nr_bits
+ * @a->base if none found in the forward half. Return a->base + a->nr_cids
  * if the intersection is empty.
  *
  * Callers do round-robin distribution by passing (last_cid + 1) as @start.
@@ -571,7 +571,7 @@ static __always_inline u32 cmask_next_and_set_wrap(const struct scx_cmask __aren
 						   const struct scx_cmask __arena *b,
 						   u32 start)
 {
-	u32 a_end = a->base + a->nr_bits;
+	u32 a_end = a->base + a->nr_cids;
 	u32 found;
 
 	found = cmask_next_and_set(a, b, start);
@@ -585,7 +585,7 @@ static __always_inline u32 cmask_next_and_set_wrap(const struct scx_cmask __aren
 /**
  * cmask_from_cpumask - translate a kernel cpumask to a cid-space cmask
  * @m: cmask to fill. Zeroed first; only bits within [@m->base, @m->base +
- *     @m->nr_bits) are updated - cpus mapping to cids outside that range
+ *     @m->nr_cids) are updated - cpus mapping to cids outside that range
  *     are ignored.
  * @cpumask: kernel cpumask to translate
  *
-- 
2.54.0

