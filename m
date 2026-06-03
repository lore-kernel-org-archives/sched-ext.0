Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADD46AF25;
	Wed,  3 Jun 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507318; cv=none; b=X/cHBkeKA7kXgqWrhdUtfODH+dMzogYsD3Pjoe6xtlTaCFNzzRrxx9e08bUDLYyQvMMaZ66PawQw1tZTkdsllorqJ21TzwHxgHChbwvM+v9XQyFreDf0FSPaHrkclsbMw3Xi9YPYB7z0aDPcvllsySxsgmJ96u+aJ9mo8zltCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507318; c=relaxed/simple;
	bh=ubeJ4rNQG0Ef6kO6sgM1fpCp8AHwVjx0eI7FQ81ZpGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqgUUA7HhEIsBvd4l7Qi4WefqpiROMf6qUMJAal+jY/aCrG2g0s4B7jcVLIuZIkgvTR6/w3mIxqxiSxixDgYMRRjsCUirmxEEwgCYE1MDBu8xxp8QgMgH6wr8xiA2Oi1fLFJ8WZewHTs8j0OqQWHjL9WVg08AAhdtWycfW4+MzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ3yNKM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ3yNKM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ADA1F00899;
	Wed,  3 Jun 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507316;
	bh=RRw0+fHhoSh1DjgvQrikdK70eQbmSg8XU3PleKXE8Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJ3yNKM0SGYzbusZdMzuAf2bUIPR/vliT2xmYcsWCyDy4mnKN4NV534rPHK6z1uoQ
	 sFe3UEgatXgqT+EjfD6gv/oDRvUomiVhbdW0oQlGPLStdpofvasmipL1YalUee2LHV
	 dVtsPs6X4r01V1PrBZV/BsWjVOCI5L6QXm1pj0aVA3eKiHtoAQeOaMbKaB3vxb/LSn
	 9/J7jOyJOeRVCqCeXhrGv59oHsGYOU+QhQhrUKLZ63ldav9KK6waVI9lfSQXmT8Xvc
	 LPvQaUXhd558hfBRCmgpWepEwg8emxLFZVmuvK0ovgrwAYEa2SjbrtJlMT3/GfVAUn
	 AXbdeB8/mgIsA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Add scx_cmask_test() and scx_cmask_for_each_cid()
Date: Wed,  3 Jun 2026 07:21:52 -1000
Message-ID: <20260603172153.3081861-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603172153.3081861-1-tj@kernel.org>
References: <20260603172153.3081861-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add single-bit test and iterator over set cids in an scx_cmask.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index 46fd8eda0443..d4c3ebba7416 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -225,4 +225,35 @@ static inline void __scx_cmask_set(u32 cid, struct scx_cmask *m)
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
+/**
+ * scx_cmask_for_each_cid - iterate set cids in @m
+ * @cid: s32 loop var that receives each set cid in turn
+ * @m: cmask to iterate
+ *
+ * Visits set bits within @m's active range in ascending order. Relies on the
+ * head/tail-zero invariant of bits[], so no per-cid range check is needed.
+ */
+#define scx_cmask_for_each_cid(cid, m)						\
+	for (u64 __bs = (m)->base & ~63u, __wi = 0,				\
+		     __nw = SCX_CMASK_NR_WORDS((m)->nr_cids);			\
+	     __wi < __nw; __wi++)						\
+		for (u64 __w = READ_ONCE((m)->bits[__wi]);			\
+		     __w && ((cid) = __bs + __wi * 64 + __ffs64(__w), true);	\
+		     __w &= __w - 1)
+
 #endif /* _KERNEL_SCHED_EXT_CID_H */
-- 
2.54.0

