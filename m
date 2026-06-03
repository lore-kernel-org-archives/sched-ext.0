Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857EB453495;
	Wed,  3 Jun 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507316; cv=none; b=dp9QYZho64tZ/2W9bfUp2BbD7K9dqQSOFUlurLhJcOH4czyziCIBy0ip1Vsfi2bgjbnWCOvps5OTHSNiJPe0wn5KNNs+zQllntHDS4cMqnGCeFOjpOUqreZ1dllTCrnnGf9tCt0wjUtQoEbWks3xrrbwB48/iun9VC1pCaz4cLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507316; c=relaxed/simple;
	bh=TLeklP9tZV4IRMAnM+TAFVdxDegWu02V9abWBNLDgGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StCY709t2c+tDeQtpNRAZGptyf8aB4shvkEK1M3s6aG5koFS338ZKbTDeFzX9oEkJDYz9YV+c0KMzpQq6i2YDn8Z8Yne0ktI/kLAXW5YBXdCFItG7TrX3AP741U+wUtMmanr2RPOrxV2bmAz131ICshicFK49JQOOkH0aLNKIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaaHHqhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaaHHqhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAC61F00898;
	Wed,  3 Jun 2026 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507315;
	bh=u5ZXyxRmN925shYlI/YuTWC0iodGKkq4C19zisanqYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaaHHqhZX1YM5YGVlfI7mmh7Jt0iJ1d53gZXk3FjeA+eRLUE2+eGcYa3DTzfZJIvT
	 DDG/2obVgRjkHvCRXpy3aLflUFJcAXFsdVwx5/Bu7Kn7LciN3NTBiMl36bcJ+nr7uQ
	 /cvwrzH5ye2LuS22U87lZU9XfxH8WNCrTQy9bJEMaNLKM9428jdw+jJuFFAAzAKfEG
	 HXMoEqjtAjWPts2githKcnVHvyauLvgba9sKl16J+HFbD+8G/m1JDgZFq9WhQM22pM
	 0iNrLNvKZdXMdl2jqAqdkO++x8ncN8xC+Z2DNSgA7XEPLVmYkngzK6ku1cJwJjEwn4
	 Ab8y5/5wMFR1g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Order single-cid cmask helpers as (cid, mask)
Date: Wed,  3 Jun 2026 07:21:51 -1000
Message-ID: <20260603172153.3081861-2-tj@kernel.org>
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

__scx_cmask_set(), __scx_cmask_contains() and __scx_cmask_word() take the
cmask first and the cid second. The kernel's bit and cpumask predicates put
the index first: test_bit(nr, addr), cpumask_test_cpu(cpu, mask). Reorder
the cmask helpers to (cid, mask) for consistency, ahead of new single-cid
ops added next. Mask-level ops (and/or/andnot/copy/subset/intersects) keep
(dst, src).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_cid.c |  2 +-
 kernel/sched/ext_cid.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 808c6390da5a..66944a7ef79d 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -267,7 +267,7 @@ void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst)
 		s32 cid = __scx_cpu_to_cid(cpu);
 
 		if (cid >= 0)
-			__scx_cmask_set(dst, cid);
+			__scx_cmask_set(cid, dst);
 	}
 }
 
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index abea22ba2cc2..46fd8eda0443 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -147,13 +147,13 @@ static inline bool scx_is_cid_type(void)
 	return static_branch_unlikely(&__scx_is_cid_type);
 }
 
-static inline bool __scx_cmask_contains(const struct scx_cmask *m, u32 cid)
+static inline bool __scx_cmask_contains(u32 cid, const struct scx_cmask *m)
 {
 	return likely(cid >= m->base && cid < m->base + m->nr_cids);
 }
 
 /* Word in bits[] covering @cid. @cid must satisfy __scx_cmask_contains(). */
-static inline u64 *__scx_cmask_word(const struct scx_cmask *m, u32 cid)
+static inline u64 *__scx_cmask_word(u32 cid, const struct scx_cmask *m)
 {
 	return (u64 *)&m->bits[cid / 64 - m->base / 64];
 }
@@ -218,11 +218,11 @@ static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 nr_cids)
 	m->nr_cids = nr_cids;
 }
 
-static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
+static inline void __scx_cmask_set(u32 cid, struct scx_cmask *m)
 {
-	if (!__scx_cmask_contains(m, cid))
+	if (!__scx_cmask_contains(cid, m))
 		return;
-	*__scx_cmask_word(m, cid) |= BIT_U64(cid & 63);
+	*__scx_cmask_word(cid, m) |= BIT_U64(cid & 63);
 }
 
 #endif /* _KERNEL_SCHED_EXT_CID_H */
-- 
2.54.0

