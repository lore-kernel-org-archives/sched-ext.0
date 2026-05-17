Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E773C661D;
	Sun, 17 May 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042978; cv=none; b=GdsgLg/52L/H093wqWRb+AHPjfFD5RwfFA+Uo/4jPta7Jb1bEqiB8MdsYlrvQg7a1cvUEC64ELXwXf54OtPhSYrQp0N1xbh+dTwZ45Kn9XbGf73QWHNp9h3dD1LLVZ1ghNjfqQXTvAfMfchEodPHBeLrzkhB+ZzCcTnHl9IBCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042978; c=relaxed/simple;
	bh=PMM4cLOhe/29nsCob1wed2fB2p0UXmJFKEn3YP13lDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW17GS5cGu0P0M3Gc/5SXISvNe2llO9qUN5uRRBBZG6+M6XJIaQJuEMeYY9bfbr1/U3UiLrBFcafUyS59UTqpxwDp9qDgizc5HGoftDH0Rqj91iVCoef6gEucopF9/mX0dxWYw+BPiUsNNTeecm/is5X7oGcP4APa1pUWEs9Ks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGpQQFPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGpQQFPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BBBC2BCB0;
	Sun, 17 May 2026 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042977;
	bh=PMM4cLOhe/29nsCob1wed2fB2p0UXmJFKEn3YP13lDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGpQQFPqgl7le+fSdJqAlXfZQLXOJuslyRduQMsqVqJ/8+lBnInsd8FiE9osE1Hpn
	 AM/0PeObH9rh/xdznAdf485xQGLXfkd1m5rPyqZrsmmEP0cPv+7javkXSJ+F6snt1b
	 trhKrrK70f9k0tUywgGYIKNJQlJWIUsDWj6gvRRjqZE0XPaUfjE3NGQSNefGmMXwGj
	 XzXs7beQqGqKNcgzKRfXY6B/4IWzjMlRJUTDgqhk+jmh+5P8Rt910ecp1nTCche3Js
	 0VQnS740CBRpfX7rkmM7xRuQtOc+s3PQfUU1bMWXH2zmx7x3brQK0+gSjp0PM17Y4p
	 6AP/xCEYa5mNw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Track bits[] storage size in struct scx_cmask
Date: Sun, 17 May 2026 08:36:13 -1000
Message-ID: <20260517183614.1191534-3-tj@kernel.org>
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

scx_cmask carries @base and @nr_cids but not the bits[] allocation size, so
helpers reshaping the active range have no way to check it fits and later
kfuncs taking caller-provided storage can't validate it.

Add @alloc_words (u64 word count) annotated with __counted_by, and split the
bit-range API into three helpers:

- SCX_CMASK_DEFINE() / __SCX_CMASK_DEFINE() define an on-stack cmask, the
  latter taking an explicit capacity for oversized storage.
  SCX_CMASK_DEFINE_SHARD() is a thin wrapper that always reserves
  SCX_CID_SHARD_MAX_CPUS bits of storage.

- scx_cmask_init() / __scx_cmask_init() initialize a cmask, with the same
  tight-vs-explicit split.

- scx_cmask_reframe() reshapes the active range without resizing storage.

The BPF mirror (cmask_init / __cmask_init / cmask_reframe) gets the same
shape.

Add scx_cmask_clear() and scx_cmask_fill() to zero and set the
active-range bits respectively. scx_cpumask_to_cmask() uses
scx_cmask_clear(); scx_cmask_init() would otherwise re-write @alloc_words
on every call.

A later patch uses @alloc_words in scx_cmask_ref_shard() to refuse output
storage that can't hold the requested shard.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.c                | 48 ++++++++++++++++++++--
 kernel/sched/ext_cid.h                | 57 ++++++++++++++++++++++++++-
 kernel/sched/ext_types.h              | 56 +++++++++++++++++++++-----
 tools/sched_ext/include/scx/cid.bpf.h | 57 +++++++++++++++++++++++++--
 4 files changed, 202 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index bdd8ef8eae3d..f50319c5c65e 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -222,19 +222,61 @@ s32 scx_cid_init(struct scx_sched *sch)
 	return 0;
 }
 
+/**
+ * scx_cmask_clear - Zero every bit in @m's active range
+ * @m: cmask to clear
+ *
+ * Storage past the active range is left as is.
+ */
+void scx_cmask_clear(struct scx_cmask *m)
+{
+	u32 nr_words;
+
+	if (!m->nr_cids)
+		return;
+	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
+	memset(m->bits, 0, nr_words * sizeof(u64));
+}
+
+/**
+ * scx_cmask_fill - Set every bit in @m's active range
+ * @m: cmask to fill
+ *
+ * Counterpart to scx_cmask_clear(). Storage past the active range is left as is.
+ */
+void scx_cmask_fill(struct scx_cmask *m)
+{
+	u32 nr_words, head_bits, tail_bits;
+
+	if (!m->nr_cids)
+		return;
+	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
+	memset(m->bits, 0xff, nr_words * sizeof(u64));
+
+	/* clear word-0 bits below base */
+	head_bits = m->base & 63;
+	if (head_bits)
+		m->bits[0] &= ~((1ULL << head_bits) - 1);
+
+	/* clear last-word bits at or past base + nr_cids */
+	tail_bits = (m->base + m->nr_cids) & 63;
+	if (tail_bits)
+		m->bits[nr_words - 1] &= (1ULL << tail_bits) - 1;
+}
+
 /**
  * scx_cpumask_to_cmask - Translate a kernel cpumask into a cmask
  * @src: source cpumask
  * @dst: cmask to write
  *
- * Initialize @dst to cover the full cid space [0, num_possible_cpus()) and
- * set the bit for each cid whose cpu is in @src.
+ * Clear @dst's active range and set the bit for each cid whose cpu is in
+ * @src and lies within that range. Out-of-range cids are silently ignored.
  */
 void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst)
 {
 	s32 cpu;
 
-	scx_cmask_init(dst, 0, num_possible_cpus());
+	scx_cmask_clear(dst);
 	for_each_cpu(cpu, src) {
 		s32 cid = __scx_cpu_to_cid(cpu);
 
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index e1c44a180bb1..223ed0e857ec 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -51,6 +51,8 @@ extern s16 *scx_cpu_to_cid_tbl;
 extern struct scx_cid_topo *scx_cid_topo;
 extern struct btf_id_set8 scx_kfunc_ids_init;
 
+void scx_cmask_clear(struct scx_cmask *m);
+void scx_cmask_fill(struct scx_cmask *m);
 s32 scx_cid_init(struct scx_sched *sch);
 int scx_cid_kfunc_init(void);
 void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst);
@@ -147,11 +149,64 @@ static inline u64 *__scx_cmask_word(const struct scx_cmask *m, u32 cid)
 	return (u64 *)&m->bits[cid / 64 - m->base / 64];
 }
 
+/**
+ * __scx_cmask_init - Initialize @m with explicit storage capacity
+ * @m: cmask to initialize
+ * @base: first cid of the active range
+ * @nr_cids: number of cids in the active range
+ * @alloc_cids: storage capacity in cids, at least @nr_cids
+ *
+ * Use when storage is sized larger than the initial active range. All of
+ * bits[] is zeroed.
+ */
+static inline void __scx_cmask_init(struct scx_cmask *m, u32 base, u32 nr_cids,
+				    u32 alloc_cids)
+{
+	if (WARN_ON_ONCE(alloc_cids < nr_cids))
+		nr_cids = alloc_cids;
+
+	m->base = base;
+	m->nr_cids = nr_cids;
+	m->alloc_words = SCX_CMASK_NR_WORDS(alloc_cids);
+	memset(m->bits, 0, m->alloc_words * sizeof(u64));
+}
+
+/**
+ * scx_cmask_init - Initialize @m on tight storage
+ * @m: cmask to initialize
+ * @base: first cid of the active range
+ * @nr_cids: number of cids in the active range
+ *
+ * All of bits[] is zeroed.
+ */
 static inline void scx_cmask_init(struct scx_cmask *m, u32 base, u32 nr_cids)
 {
+	__scx_cmask_init(m, base, nr_cids, nr_cids);
+}
+
+/**
+ * scx_cmask_reframe - Reshape @m's active range without resizing storage
+ * @m: cmask to reframe
+ * @base: new active range base
+ * @nr_cids: new active range length, must fit within @m->alloc_words
+ *
+ * Body bits within the new range become garbage - only the head and tail
+ * words are zeroed to keep the padding invariant.
+ */
+static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 nr_cids)
+{
+	if (WARN_ON_ONCE(SCX_CMASK_NR_WORDS(nr_cids) > m->alloc_words))
+		return;
+
+	if (nr_cids) {
+		u32 last_word = ((base & 63) + nr_cids - 1) / 64;
+
+		m->bits[0] = 0;
+		m->bits[last_word] = 0;
+	}
+
 	m->base = base;
 	m->nr_cids = nr_cids;
-	memset(m->bits, 0, SCX_CMASK_NR_WORDS(nr_cids) * sizeof(u64));
 }
 
 static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
index c6c4e3db7311..0c318a359849 100644
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
@@ -69,9 +69,10 @@ struct scx_cid_topo {
  *
  * A cmask covers the cid range [base, base + nr_cids). bits[] is aligned to the
  * global 64-cid grid: bits[0] spans [base & ~63, (base & ~63) + 64), so the
- * first (base & 63) bits of bits[0] are head padding and any tail past base +
- * nr_cids is tail padding. Both must stay zero for the lifetime of the mask;
- * all mutating helpers preserve that invariant.
+ * first (base & 63) bits of bits[0] are head padding and the trailing bits of
+ * the last active word past base + nr_cids are tail padding. Both stay zero;
+ * all mutating helpers preserve that. Words past the last active word are not
+ * read by any helper and have no constraint.
  *
  * Grid alignment means two cmasks always address bits[] against the same global
  * 64-cid windows, so cross-cmask word ops (AND, OR, ...) reduce to
@@ -83,7 +84,8 @@ struct scx_cid_topo {
 struct scx_cmask {
 	u32 base;
 	u32 nr_cids;
-	DECLARE_FLEX_ARRAY(u64, bits);
+	u32 alloc_words;
+	u64 bits[] __counted_by(alloc_words);
 };
 
 /*
@@ -94,11 +96,47 @@ struct scx_cmask {
  */
 #define SCX_CMASK_NR_WORDS(nr_cids)	(((nr_cids) + 63) / 64 + 1)
 
-/*
- * Define an on-stack cmask for up to @cap_bits. @name is a struct scx_cmask *
- * aliasing zero-initialized storage; call scx_cmask_init() to set base/nr_cids.
+/**
+ * __SCX_CMASK_DEFINE - Define an on-stack cmask with explicit storage capacity
+ * @NAME: variable name to define
+ * @BASE: first cid of the active range
+ * @NR_CIDS: active range length
+ * @ALLOC_CIDS: storage capacity in cids, at least @NR_CIDS
+ *
+ * @NAME aliases zero-initialized storage with the active range set to
+ * [BASE, BASE + NR_CIDS). Use scx_cmask_reframe() to reshape later, up to
+ * @ALLOC_CIDS.
+ */
+#define __SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS, ALLOC_CIDS)			\
+	_DEFINE_FLEX(struct scx_cmask, NAME, bits, SCX_CMASK_NR_WORDS(ALLOC_CIDS), \
+		     = { .base = (BASE),					\
+			 .nr_cids = (NR_CIDS),					\
+			 .alloc_words = SCX_CMASK_NR_WORDS(ALLOC_CIDS) })
+
+/**
+ * SCX_CMASK_DEFINE - Define an on-stack cmask on tight storage
+ * @NAME: variable name to define
+ * @BASE: first cid of the active range
+ * @NR_CIDS: active range length, also storage capacity
+ *
+ * @NAME aliases zero-initialized storage with the active range and storage
+ * both [BASE, BASE + NR_CIDS).
+ */
+#define SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS)					\
+	__SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS, NR_CIDS)
+
+/**
+ * SCX_CMASK_DEFINE_SHARD - Define an on-stack cmask sized to one shard
+ * @NAME: variable name to define
+ * @BASE: first cid of the active range
+ * @NR_CIDS: active range length, must be <= SCX_CID_SHARD_MAX_CPUS
+ *
+ * Storage is fixed at SCX_CID_SHARD_MAX_CPUS, active range framed by
+ * (BASE, NR_CIDS). Passing NR_CIDS > SCX_CID_SHARD_MAX_CPUS leaves the
+ * cmask claiming more bits than storage holds and subsequent cmask
+ * operations will overrun.
  */
-#define SCX_CMASK_DEFINE(name, cap_bits)	\
-	DEFINE_RAW_FLEX(struct scx_cmask, name, bits, SCX_CMASK_NR_WORDS(cap_bits))
+#define SCX_CMASK_DEFINE_SHARD(NAME, BASE, NR_CIDS)				\
+	__SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS, SCX_CID_SHARD_MAX_CPUS)
 
 #endif /* _KERNEL_SCHED_EXT_TYPES_H */
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index b9dcc14870d3..211f4077f43a 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -44,20 +44,71 @@ static __always_inline u64 __arena *__cmask_word(const struct scx_cmask __arena
 	return (u64 __arena *)&m->bits[cid / 64 - m->base / 64];
 }
 
-static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 base, u32 nr_cids)
+/**
+ * __cmask_init - Initialize @m with explicit storage capacity
+ * @m: cmask to initialize
+ * @base: first cid of the active range
+ * @nr_cids: number of cids in the active range
+ * @alloc_cids: storage capacity in cids, at least @nr_cids
+ *
+ * Use when storage is sized larger than the initial active range. All of
+ * bits[] is zeroed.
+ */
+static __always_inline void __cmask_init(struct scx_cmask __arena *m, u32 base,
+					 u32 nr_cids, u32 alloc_cids)
 {
-	u32 nr_words = CMASK_NR_WORDS(nr_cids), i;
+	u32 alloc_words = CMASK_NR_WORDS(alloc_cids), i;
 
 	m->base = base;
 	m->nr_cids = nr_cids;
+	m->alloc_words = alloc_words;
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
-		if (i >= nr_words)
+		if (i >= alloc_words)
 			break;
 		m->bits[i] = 0;
 	}
 }
 
+/**
+ * cmask_init - Initialize @m on tight storage
+ * @m: cmask to initialize
+ * @base: first cid of the active range
+ * @nr_cids: number of cids in the active range
+ *
+ * All of bits[] is zeroed.
+ */
+static __always_inline void cmask_init(struct scx_cmask __arena *m, u32 base, u32 nr_cids)
+{
+	__cmask_init(m, base, nr_cids, nr_cids);
+}
+
+/**
+ * cmask_reframe - Reshape @m's active range without resizing storage
+ * @m: cmask to reframe
+ * @base: new active range base
+ * @nr_cids: new active range length, must fit within @m->alloc_words
+ *
+ * Body bits within the new range become garbage - only the head and tail
+ * words are zeroed to keep the padding invariant.
+ */
+static __always_inline void cmask_reframe(struct scx_cmask __arena *m, u32 base, u32 nr_cids)
+{
+	if (CMASK_NR_WORDS(nr_cids) > m->alloc_words) {
+		scx_bpf_error("cmask_reframe: nr_cids=%u exceeds alloc_words=%u",
+			      nr_cids, m->alloc_words);
+		return;
+	}
+	if (nr_cids) {
+		u32 last_word = ((base & 63) + nr_cids - 1) / 64;
+
+		m->bits[0] = 0;
+		m->bits[last_word] = 0;
+	}
+	m->base = base;
+	m->nr_cids = nr_cids;
+}
+
 static __always_inline bool cmask_test(const struct scx_cmask __arena *m, u32 cid)
 {
 	if (!__cmask_contains(m, cid))
-- 
2.54.0

