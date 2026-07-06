Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4737C0E2;
	Mon,  6 Jul 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302064; cv=none; b=SvBXv53m0KcTtM1mwNh1WnDTSKfHYZyCgyw23gZb7lBriAnjZfZA9P/ISyBuNSOCD/5Xv2FBjDk2dbu9s2RqlABFJXrHX+Mya8gwC/VK4DLRetiqKxJmF/oB8JSvFPwgJfNe8i3tmNpfrT85MAuRvGEJ46Z+vK/nyAhnX0c3z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302064; c=relaxed/simple;
	bh=ls857EryogaKLgK/p5F9r1KvmAzQouGiJAbqeryMVWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxVwPoAXwilJMS/aXD3QlLcRKyg5O/udOfj8MzM+Hh2+kacXHuQ5cXbObQh5MImz+VOV1pJo4Uo5YcwAtbk6hXoVtK7B/dEB3xu8OfsmLz6EZtoe7p1OwSGL/v8EFOpeeACU5iGIEGKfO+uqttZxflSujDqClQnynAisFqqV5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD/iGymU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD/iGymU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510651F00A3A;
	Mon,  6 Jul 2026 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302063;
	bh=iQMsxSme3BLLykqisXlRcayWbs+A567wzEFBAHXYSLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BD/iGymUGJ0BUoY+EaMDaGMn2Ruj2opl0auCa+6ZxdgKF+ZV10mvJje4uwH1rjR3m
	 3yI6XRZTT4TALd8x41pGzv48Kmmm4Y7O2KoK7aS86Q/8HxpJTztdzE3oDRmYFlQde5
	 hJTerUfONxLssB6sO3Zt9KqlljeqNeesosNO8Oj86LIxqGg6Nv2u2VFM/v4lB2oAU5
	 umoZ88qy/oAlj+kkue5JO3hgIiLIVE+fdLuTB5VZ7Xio6hQBzhcrHsnKMNoTgYFUXq
	 P5FAHZzjKphaBs5Bhprk9Au24Qtnd4k8+0up3RXhiiqvF73i45lR9P1YiW5vWny+Kp
	 X9meuOwj0QRfg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 04/36] tools/sched_ext: scx - Fix cmask_subset(), cmask_equal() and cmask_weight()
Date: Sun,  5 Jul 2026 15:40:26 -1000
Message-ID: <20260706014058.439853-5-tj@kernel.org>
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

cmask_equal(), cmask_weight() and cmask_subset() bounded their word walks
with CMASK_NR_WORDS(nr_cids), which pads by one word and can't tell the last
word in use without @base. The walks could thus cover a slack word past the
active range, which cmask_reframe() leaves non-zero: a stale bit there gave
cmask_equal() a spurious mismatch, cmask_weight() an inflated count, and
cmask_subset() a spurious violation. cmask_subset() could also read
@b->bits[] one word past its allocation (within the arena's fault-recovered
range, so harmless), and deviated from the kernel scx_cmask_subset() by
failing any @a range that doesn't nest inside @b's even when the overhanging
bits are all clear.

Bound the cmask_equal() and cmask_weight() walks by the words the range
actually spans, with early returns for empty ranges. Rewrite cmask_subset()
to match the kernel semantics: scan @a's overhangs for set bits with
cmask_next_set() and walk the words of the range intersection.
cmask_subset() moves below cmask_next_set(), which it now uses. Padding bits
don't need masking as every cmask helper keeps them clear.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h | 88 +++++++++++++++++----------
 1 file changed, 55 insertions(+), 33 deletions(-)

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index db247e42fb45..6b0b4e41b288 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -391,7 +391,9 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
 
 	if (a->base != b->base || a->nr_cids != b->nr_cids)
 		return false;
-	nr_words = CMASK_NR_WORDS(a->nr_cids);
+	if (a->nr_cids == 0)
+		return true;
+	nr_words = (a->base + a->nr_cids - 1) / 64 - a->base / 64 + 1;
 
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
@@ -402,36 +404,6 @@ static __always_inline bool cmask_equal(const struct scx_cmask __arena *a,
 	return true;
 }
 
-/*
- * True iff every bit set in @a is also set in @b over the intersection of
- * their ranges. Bits of @a outside @b's range fail the test.
- */
-static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
-					 const struct scx_cmask __arena *b)
-{
-	u32 a_end = a->base + a->nr_cids;
-	u32 b_end = b->base + b->nr_cids;
-	u32 a_wbase = a->base / 64;
-	u32 b_wbase = b->base / 64;
-	u32 nr_words, i;
-
-	/* any bit of @a outside @b's range is a subset violation */
-	if (a->base < b->base || a_end > b_end)
-		return false;
-
-	nr_words = CMASK_NR_WORDS(a->nr_cids);
-	bpf_for(i, 0, CMASK_MAX_WORDS) {
-		u32 wi_b;
-
-		if (i >= nr_words)
-			break;
-		wi_b = a_wbase + i - b_wbase;
-		if (a->bits[i] & ~b->bits[wi_b])
-			return false;
-	}
-	return true;
-}
-
 /**
  * cmask_next_set - find the first set bit at or after @cid
  * @m: cmask to search
@@ -488,16 +460,66 @@ static __always_inline u32 cmask_first_set(const struct scx_cmask __arena *m)
 	     (cid) < (m)->base + (m)->nr_cids;					\
 	     (cid) = cmask_next_set((m), (cid) + 1))
 
+/*
+ * True iff every bit set in @a is also set in @b. Matches the kernel-side
+ * scx_cmask_subset(): ranges don't need to nest, and set bits of @a outside
+ * @b's range fail the test.
+ */
+static __always_inline bool cmask_subset(const struct scx_cmask __arena *a,
+					 const struct scx_cmask __arena *b)
+{
+	u32 a_end = a->base + a->nr_cids;
+	u32 b_end = b->base + b->nr_cids;
+	u32 a_wbase = a->base / 64;
+	u32 b_wbase = b->base / 64;
+	u32 lo = a->base > b->base ? a->base : b->base;
+	u32 hi = a_end < b_end ? a_end : b_end;
+	u32 lo_word, hi_word, i;
+
+	/* set bits of @a outside @b's range can't be in @b */
+	if (a->base < b->base &&
+	    cmask_next_set(a, a->base) < (b->base < a_end ? b->base : a_end))
+		return false;
+	if (a_end > b_end &&
+	    cmask_next_set(a, a->base > b_end ? a->base : b_end) < a_end)
+		return false;
+
+	if (lo >= hi)
+		return true;
+
+	/*
+	 * Walk the words the range intersection spans. Plain word tests
+	 * suffice: the scans above guarantee @a has no set bit outside @b's
+	 * range and padding bits are kept clear by all cmask helpers.
+	 */
+	lo_word = lo / 64;
+	hi_word = (hi - 1) / 64;
+
+	bpf_for(i, 0, CMASK_MAX_WORDS) {
+		u32 w = lo_word + i;
+
+		if (w > hi_word)
+			break;
+		if (a->bits[w - a_wbase] & ~b->bits[w - b_wbase])
+			return false;
+	}
+	return true;
+}
+
 /*
  * Population count over [base, base + nr_cids). Padding bits in the head/tail
  * words are guaranteed zero by the mutating helpers, so a flat popcount over
- * all words is correct.
+ * the words the range spans is correct.
  */
 static __always_inline u32 cmask_weight(const struct scx_cmask __arena *m)
 {
-	u32 nr_words = CMASK_NR_WORDS(m->nr_cids), i;
+	u32 nr_words, i;
 	u32 count = 0;
 
+	if (!m->nr_cids)
+		return 0;
+	nr_words = (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
+
 	bpf_for(i, 0, CMASK_MAX_WORDS) {
 		if (i >= nr_words)
 			break;
-- 
2.54.0

