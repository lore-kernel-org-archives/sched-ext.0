Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BD2E091B;
	Thu,  4 Jun 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538438; cv=none; b=RnDaslbjCMhfTLjAXgcK0O1zkkC/yBgvomWd4BIChayF6u1YAisEEcWtXj5fbrb6kbPqRJKd0ur/PlaJKIQNayyRGI4AyUZG8ehyBYoLsNoc8rIIkvKXm4xC+VcjPRb7YE2ZX73HRJpb+ajL3l3dxkZK7Ayl0pAZJlyxEPsaCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538438; c=relaxed/simple;
	bh=JCehyu2gPV/I2VfOKna9vLlR/ORXCcPrsHeRU6UlipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0uXVdC+mV9LwNQK/SM9kQe/fTTp/clqgm6FZOCeZxkYhcz9tr2hZiIQbtXXhgrc3jCFIJm9ls+XZAR1WO1cc2C7uUKhdhXOOmyCjki9dv/ppT/mT/Gz2hYSOI0KacsX8nTbjNVi94nnOI8Qk9ZVc/POu6XyI8zcdogkhY0Egjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ8dNQK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ8dNQK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CAB1F00898;
	Thu,  4 Jun 2026 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538437;
	bh=8GzSf2hO2QNntgr6YU/BN9DqUtL3sro1P7MtZPRxLFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZ8dNQK/y1dzeNRFBBRMvh9LZK2VvuICKudNiuem3sxhi+GGEPuzdp7y08JnF8o+V
	 hb9W6NO1p57nRnFoKFP8puxspXRGabMdtTWdBIyditcwAOoYjq7tsqrJvzpXgvt8qf
	 9CCLjcm957s6XHOaUQNuerKEAmkXuB/ZAFACDzX5jELrKLHwnY+Z1orp9aNNro9CQn
	 VizMUJe/Gp2r0E7X/hguqZOjzzqUdHklnUGCGHVL7lp4mk+HYrXov0I9G+8AjyZQC4
	 MB/ArSrq6BSBBQ7gCY4A78Fs0LdKQs4dKNJUAGMq4bwU72Lw91F4dfNl8Laz5R53MD
	 he4ouGBATRH1w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Add scx_cmask_test() and scx_cmask_for_each_cid()
Date: Wed,  3 Jun 2026 16:00:31 -1000
Message-ID: <20260604020032.3536466-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604020032.3536466-1-tj@kernel.org>
References: <20260604020032.3536466-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add single-bit test and iterator over set cids in an scx_cmask.

v2: Bound scx_cmask_for_each_cid() to the active span. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.h | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index 46fd8eda0443..5745e5785e89 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -225,4 +225,47 @@ static inline void __scx_cmask_set(u32 cid, struct scx_cmask *m)
 	*__scx_cmask_word(cid, m) |= BIT_U64(cid & 63);
 }
 
+/**
+ * scx_cmask_test - test whether @cid is set in @m
+ * @cid: cid to test
+ * @m: cmask to test
+ *
+ * Return %false if @cid is outside @m's active range. Otherwise return the
+ * bit's value. Read via READ_ONCE so callers can race set/clear writers.
+ */
+static inline bool scx_cmask_test(u32 cid, const struct scx_cmask *m)
+{
+	if (!__scx_cmask_contains(cid, m))
+		return false;
+	return READ_ONCE(*__scx_cmask_word(cid, m)) & BIT_U64(cid & 63);
+}
+
+/*
+ * Words of bits[] the active range spans, 0 if empty. Tighter than the storage
+ * SCX_CMASK_NR_WORDS() sizes for the worst-case base alignment.
+ */
+static inline u32 scx_cmask_nr_used_words(const struct scx_cmask *m)
+{
+	if (!m->nr_cids)
+		return 0;
+	return ((m->base & 63) + m->nr_cids - 1) / 64 + 1;
+}
+
+/**
+ * scx_cmask_for_each_cid - iterate set cids in @m
+ * @cid: s32 loop var that receives each set cid in turn
+ * @m: cmask to iterate
+ *
+ * Visits set bits within @m's active range in ascending order. Scans only the
+ * words the active range spans, where head and tail padding is kept zero, so
+ * no per-cid range check is needed.
+ */
+#define scx_cmask_for_each_cid(cid, m)						\
+	for (u64 __bs = (m)->base & ~63u, __wi = 0,				\
+		     __nw = scx_cmask_nr_used_words(m);				\
+	     __wi < __nw; __wi++)						\
+		for (u64 __w = READ_ONCE((m)->bits[__wi]);			\
+		     __w && ((cid) = __bs + __wi * 64 + __ffs64(__w), true);	\
+		     __w &= __w - 1)
+
 #endif /* _KERNEL_SCHED_EXT_CID_H */
-- 
2.54.0

