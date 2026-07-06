Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99037C113;
	Mon,  6 Jul 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302065; cv=none; b=guCGrZNhBAvCcTsSdDmotIYTHmoGUumaL9aF7tJQKJv8d1JnlM8mS6BHtG0gL4XFRH4ApUTyRLQ67KUPMuZF0kindC4tT+B8/QN6cUQv1QqXgJuz+j0WmG2g9NkpLseZBt+Z+aFWjyZsnIRf2J2M91ovxuMrUhmdL6SzEhoilA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302065; c=relaxed/simple;
	bh=ynTR7hZv/fqWiQ7rTHvXRiurrVK9snqWW6zWuTQEsHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpOFEMD6G7J8sA1LTk0guW1oVWXEHEQQ4OWmXW4XC89ibWVPVrTjLGSo/aZgLHEuTKEPsZie/gFbHu/qoWq5701V6dAh5+ZI2Fv4nedZrQ1tGBJR8DUnfcFSfFCKXkK2B6GocYhscCeAB9fLCQuK9WsMNrfCY16t0loT6KflQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzsbmRQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzsbmRQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF791F000E9;
	Mon,  6 Jul 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302064;
	bh=alzteE+v7RXuDVcjbQCFV6tzNbqMp5nl83HxhoV0Mzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzsbmRQAtwH42DhqFIhbmIrQKyJV4ksP2Wz98xPlhBVZgf6pI7Dw3wm8kHgxNK0rY
	 NGr7IkNEmwxrZmXqu0ulXUdXH7tC5n6T63eXlQllBkr+5ZiAwUAx+P5TIOkwqjsYun
	 ggN8Tmxu9YAQFc4ICebzwsjFNoa6Fya40OFZjEzNDVoLSO6xE5/bfSKi87blklwIYC
	 E0aBN1vpgauVrXVGYoL7x24VDmCVKf0mJ3+XoDRCd4vrUiZXktFlMyDfXngyM1ySVh
	 CoMX4kV6hFwGK1CfKE59rzDktzkaJ3TQ2pAtHf1rNV2onMZLPIRMoBIjxe08o7ye38
	 wxxqrFYEXdQaQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 05/36] sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
Date: Sun,  5 Jul 2026 15:40:27 -1000
Message-ID: <20260706014058.439853-6-tj@kernel.org>
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

The cmask ops can operate on BPF-arena cmasks which BPF programs may read
and write concurrently. The _RACY op variants existed to make such lockless
reads explicit but this turned out to be too restrictive. Mark the word
accesses in all the two-cmask ops with READ_ONCE/WRITE_ONCE instead and drop
the _RACY variants.

v2: READ_ONCE the cmask_word_op1() ANY_SET read. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c | 55 ++++++++----------------------------------
 kernel/sched/ext/cid.h |  2 --
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index af83084ec740..f31113b080e9 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -395,17 +395,15 @@ __bpf_kfunc s32 scx_bpf_cpu_to_cid(s32 cpu, const struct bpf_prog_aux *aux)
  * bits outside stay untouched. In particular, scx_cmask_copy() does NOT zero
  * @dst bits that lie outside @src's range.
  *
- * The _RACY variants are otherwise identical to their non-racy counterpart but
- * read @src word-by-word via data_race(). Memory ordering with concurrent
- * writers is the caller's responsibility.
+ * Word accesses use READ_ONCE/WRITE_ONCE so a caller may read @src
+ * locklessly. Memory ordering against concurrent writers is the caller's
+ * responsibility.
  */
 enum cmask_op2 {
 	/* mutating */
 	CMASK_OP2_AND,
 	CMASK_OP2_OR,
-	CMASK_OP2_OR_RACY,
 	CMASK_OP2_COPY,
-	CMASK_OP2_COPY_RACY,
 	CMASK_OP2_ANDNOT,
 	/* predicates - short-circuit when the per-word result is true */
 	CMASK_OP2_SUBSET,
@@ -422,28 +420,22 @@ static __always_inline bool cmask_word_op2(u64 *av, const u64 *bp, u64 mask,
 {
 	switch (op) {
 	case CMASK_OP2_AND:
-		*av &= ~mask | *bp;
+		WRITE_ONCE(*av, *av & (~mask | READ_ONCE(*bp)));
 		return false;
 	case CMASK_OP2_OR:
-		*av |= *bp & mask;
-		return false;
-	case CMASK_OP2_OR_RACY:
-		*av |= data_race(*bp) & mask;
+		WRITE_ONCE(*av, *av | (READ_ONCE(*bp) & mask));
 		return false;
 	case CMASK_OP2_COPY:
-		*av = (*av & ~mask) | (*bp & mask);
-		return false;
-	case CMASK_OP2_COPY_RACY:
-		*av = (*av & ~mask) | (data_race(*bp) & mask);
+		WRITE_ONCE(*av, (*av & ~mask) | (READ_ONCE(*bp) & mask));
 		return false;
 	case CMASK_OP2_ANDNOT:
-		*av &= ~(*bp & mask);
+		WRITE_ONCE(*av, *av & ~(READ_ONCE(*bp) & mask));
 		return false;
 	case CMASK_OP2_SUBSET:
 		/* stop on the first bit in @sub not set in @super */
-		return (*bp & ~*av) & mask;
+		return (READ_ONCE(*bp) & ~READ_ONCE(*av)) & mask;
 	case CMASK_OP2_INTERSECTS:
-		return (*av & *bp) & mask;
+		return (READ_ONCE(*av) & READ_ONCE(*bp)) & mask;
 	}
 	unreachable();
 }
@@ -504,7 +496,7 @@ static __always_inline bool cmask_word_op1(const u64 *ap, u64 mask,
 {
 	switch (op) {
 	case CMASK_OP1_ANY_SET:
-		return *ap & mask;
+		return READ_ONCE(*ap) & mask;
 	}
 	unreachable();
 }
@@ -556,39 +548,12 @@ void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src)
 		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR);
 }
 
-/**
- * scx_cmask_or_racy - OR @src into @dst, reading @src without locking
- *
- * @src is read word-by-word through data_race(). Same per-bit independence
- * rationale as scx_cmask_copy_racy(). Memory ordering with writers is the
- * caller's responsibility.
- */
-void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src)
-{
-	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
-		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR_RACY);
-}
-
 void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src)
 {
 	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
 		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY);
 }
 
-/**
- * scx_cmask_copy_racy - Snapshot @src into @dst without locking
- *
- * @src is read word-by-word through data_race(). Head/tail masking matches
- * scx_cmask_copy(). Each bit in a cmask is independent, so partial updates
- * just leave some bits fresher than others. Memory ordering with writers is
- * the caller's responsibility.
- */
-void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src)
-{
-	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
-		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY_RACY);
-}
-
 void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src)
 {
 	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 9c4f4b907f12..54b10df32fd5 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -57,9 +57,7 @@ void scx_cmask_clear(struct scx_cmask *m);
 void scx_cmask_fill(struct scx_cmask *m);
 void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src);
 void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src);
-void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src);
 void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src);
-void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src);
 void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src);
 bool scx_cmask_subset(const struct scx_cmask *sub, const struct scx_cmask *super);
 bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b);
-- 
2.54.0

