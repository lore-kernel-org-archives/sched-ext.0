Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAB3F0752;
	Thu,  9 Jul 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637478; cv=none; b=nZTBP0tYA7SkplDP16hWkUDQnfpSgT1zJIIFFyYAUNe/l+LxWIFY8VKAPGUGipRMDkYmIsPMkIVJd851DWSZ5ofeIJLHewN6bc8wSYrv4PjM0QLjtgkknUgj0auiB1LT8y/VVxNaiNvOfubWTFVD9LsuXqz+fF/E2r3kzyAmaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637478; c=relaxed/simple;
	bh=8B5ySeswb13wqS9oEKUaRQm/Ghgyk6iLc3T4HRgeDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7StyS5nbh8Kep0jQuDBZvqMzN5Xo4+J6jP5+dAdCtBhXN2ojgayJZQFeddDb/r8YUvNVeaAXvQdbJudBQJGjZHYInZj8yIsVa6iu/CC7YLrc/GdtecDP/jJboi3UpyvWCu/dFtai4sOncUn+vXtR5lhE7xaq6D1LknZBeT7KN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZvEzWuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZvEzWuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF7E1F000E9;
	Thu,  9 Jul 2026 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637476;
	bh=iSM+m43QXK+m4/r6/TQ8Lm7qAn8+SwIi+JGrJPc889I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZvEzWuB+J+zusCUnTSrQ+GlPxNDDuF2Kms1oEguSuK/I5t28q9e+1qobI0XMJ/qW
	 zXLbGs2IAr/+pAj+bsXlbl3aCNHJ51jbMvyCfKeOntysMIhK7HN0QkI1wzqsp8BoJa
	 XvcjmnwwT5M/DUTTZiMSTvYu5kOcPR79DGP+hKgSMEAboAQwEfOo78fvvgKbGpUJ47
	 3g6MMHIpQgobkvGD+U+IJO0ImqXnEXUOUuoeshHmSNzHnVigzasrmIS0XZJ0rqZSyj
	 xscWSErUM/B0nOsexPZI6aav2iVQgBPOtrCf+1d75fN81C4nj4kuY9Q3O2ECc/xrGq
	 9MEWFw276KwOQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 31/33] tools/sched_ext: Add three-mask cmask intersection iterator
Date: Thu,  9 Jul 2026 12:50:39 -1000
Message-ID: <20260709225041.1695495-32-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cmask_next_and2_set() and its round-robin wrap, extending
cmask_next_and_set() to a three-mask intersection: the next cid set in all
three masks at or after @start. A caller iterating the intersection of
three cmasks can then scan it in one pass, folding the third mask into the
word-level AND rather than skipping non-members one candidate at a time.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 6b0b4e41b288..69fb4e97bc77 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -668,6 +668,83 @@ static __always_inline u32 cmask_next_and_set_wrap(const struct scx_cmask __aren
 	return found < start ? found : a_end;
 }
 
+/*
+ * Like cmask_next_and_set() but over the intersection of THREE masks. Return
+ * a->base + a->nr_cids if no cid is set in all three at or after @start.
+ */
+static __always_inline u32 cmask_next_and2_set(const struct scx_cmask __arena *a,
+					       const struct scx_cmask __arena *b,
+					       const struct scx_cmask __arena *c,
+					       u32 start)
+{
+	u32 a_end = a->base + a->nr_cids;
+	u32 b_end = b->base + b->nr_cids;
+	u32 c_end = c->base + c->nr_cids;
+	u32 a_wbase = a->base / 64;
+	u32 b_wbase = b->base / 64;
+	u32 c_wbase = c->base / 64;
+	u32 lo = a->base > b->base ? a->base : b->base;
+	u32 hi = a_end < b_end ? a_end : b_end;
+	u32 last_wi, start_wi, start_bit, i;
+
+	lo = lo > c->base ? lo : c->base;
+	hi = hi < c_end ? hi : c_end;
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
+		word = a->bits[abs_wi - a_wbase] & b->bits[abs_wi - b_wbase] &
+		       c->bits[abs_wi - c_wbase];
+		if (i == 0)
+			word &= GENMASK_U64(63, start_bit);
+		if (!word)
+			continue;
+
+		found = abs_wi * 64 + ctzll(word);
+		if (found >= hi)
+			return a_end;
+		return found;
+	}
+	return a_end;
+}
+
+/*
+ * Round-robin variant of cmask_next_and2_set(): wrap to @a->base if the
+ * three-way intersection has no cid in the forward half. Return a->base +
+ * a->nr_cids if empty.
+ */
+static __always_inline u32 cmask_next_and2_set_wrap(const struct scx_cmask __arena *a,
+						    const struct scx_cmask __arena *b,
+						    const struct scx_cmask __arena *c,
+						    u32 start)
+{
+	u32 a_end = a->base + a->nr_cids;
+	u32 found;
+
+	found = cmask_next_and2_set(a, b, c, start);
+	if (found < a_end || start <= a->base)
+		return found;
+
+	found = cmask_next_and2_set(a, b, c, a->base);
+	return found < start ? found : a_end;
+}
+
 /**
  * cmask_from_cpumask - translate a kernel cpumask to a cid-space cmask
  * @m: cmask to fill. Zeroed first; only bits within [@m->base, @m->base +
-- 
2.55.0

