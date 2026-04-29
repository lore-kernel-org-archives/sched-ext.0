Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1857421F0D;
	Wed, 29 Apr 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486902; cv=none; b=CWmWAeYNUoqMBCtrCjqknTXhsLQs0FA4m65yhzIh666AxEaNym24QOlWN+VHcsKqXA7aUxMQb2Io6zpavpuibLmy2yysnnAsuHwCe0cSK/Eauj2sQ/hb2byNQi5Ml3lgp1joiNNw4l22sJTdtU03gz4owted4UaWG7bAyYQfM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486902; c=relaxed/simple;
	bh=OF7NwPOQ++dxHH99qtMBHB5g87HNvfPP6YMLrgi6KEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1FD5slMKUuMwDgMuoxDyIrhfbX9Ct1uTrYqAb+HWO3ANHsc8e2tjg8IzZmWQadIMBLjefCy3yxJDG7kHkbOIizd7XG2TvUvUmPbY1Ya6TwJBOhbCAA9x+R1c4+Hs2T6P+Kv1a14TU3KJffcBV67PPq+Z+dvdj1QfKjfhSxHCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnB6BKLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnB6BKLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAB8C2BCC6;
	Wed, 29 Apr 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486902;
	bh=OF7NwPOQ++dxHH99qtMBHB5g87HNvfPP6YMLrgi6KEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnB6BKLn9PY1UFUaGPil3lBnEYCav+lPTwBWSglTTjfuM4bMecGuyElexkGLPhaD3
	 NGgzMxKqkbl3Fz6D8z1H8gBBLE4qlKcyRmvpII6aULKsrowS8C1D+73yggxA1cElm6
	 XfXphS+nUWylL+cvR8/NwcqpL93BGNsqw2p2CL3iw5340sMlZYxzDSgBWGOlkQ3J4Z
	 3iKoJ2IbUK6tNOY6+xFaOfinO1OutFFTBERRS0PtvdAtUizUybwC1rt8ZtYloA18nl
	 PMvxusFk1KGq4ui3TkIoNEzCsWqfVDuebq/EmGdYAmHL/WkIhi4phawqsi5tLVsmxQ
	 9NqzlPB9FLKCw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 09/17] tools/sched_ext: Add struct_size() helpers to common.bpf.h
Date: Wed, 29 Apr 2026 08:21:23 -1000
Message-ID: <20260429182131.1780125-10-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add flex_array_size(), struct_size() and struct_size_t() to
scx/common.bpf.h so BPF schedulers can size flex-array-containing
structs the same way kernel code does. These are abbreviated forms of
the <linux/overflow.h> macros.

v3: Use offsetof() instead of sizeof() in struct_size() to match kernel
    semantics (no inflation from trailing struct padding). (Sashiko)

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 18f823d424cc..087ae4f79c60 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -1043,6 +1043,16 @@ static inline u64 scx_clock_irq(u32 cpu)
 	return irqt ? BPF_CORE_READ(irqt, total) : 0;
 }
 
+/* Abbreviated forms of <linux/overflow.h>'s struct_size() family. */
+#define flex_array_size(p, member, count)	\
+	((count) * sizeof(*(p)->member))
+
+#define struct_size(p, member, count)		\
+	(offsetof(typeof(*(p)), member) + flex_array_size(p, member, count))
+
+#define struct_size_t(type, member, count)	\
+	struct_size((type *)NULL, member, count)
+
 #include "compat.bpf.h"
 #include "enums.bpf.h"
 
-- 
2.54.0

