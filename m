Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E643F8DE;
	Tue, 21 Jul 2026 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673083; cv=none; b=J4OQ34NGPwkzNjH9TNWm5vLg8XxhCH5SKji/o4vCs/QklYk4CowfsopxcUxrG49RjUG6VTm2hZJEGGCs5pCGVtXRQ5PI1jheOdV4p0rT7TXIT3IssdElhL36ewdDuW+hoaHFaFce+AG0gZDo4QMIa5bSafcewcMG0ZdfNGYR3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673083; c=relaxed/simple;
	bh=4eguOlHFb7Z0x8SEITQYy+Ifk1IR2AmQIKysMHps/kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEdD/ZIoOc2DbmB7cjB0ZeB6BEOe4/5FORQVqE5y/9M97mW1KK0R1eVjeNR1RUH3YO27J2pyTy3BJteZjNZrwflFtgYdEiqgUAJ2UTBMVtgCwMfQvhyV0HzmnyaJvJbjtOY2bhps0dSygK5raMXutRfJKqf0lMWXcQrnnbbfWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgLeGuLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgLeGuLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC401F00A3D;
	Tue, 21 Jul 2026 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784673082;
	bh=ysdCnGiY4iYfs05NslJ40g3e1HB03dUVjPx81koGlUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgLeGuLx7b+pqg0AUTkAY0xMjbyQ0OHuFPSDGqTT25s/C6huDoh8YIt5OjFEnnoUT
	 IRemMeNbZX3k0yirLWr0dOUeqyMxKRjzDrKV5ciPD5pFlR2VBFqHzWuI+gLvhxh45s
	 34g7z/d5Rz5vxLtVQbAtb+cJDNo0TBJEYZtQsSxPSLwT15O7M5EsjlysxZS3/RnNj3
	 eRpu2Md6UZzSMhxr/4ar5dFAp/lrj2Ik/JtCvfwhi2yMbmY7kLQxAV/uTig9PfmYII
	 6eUp/87w18eLBP6CJ2yt1B344dBs0rUlWC7Ex86xHPQFfLIpFQqR65cYGy0bORTLqE
	 TwJ6q/rP93URA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 3/4] sched_ext: Drop unused scx_cpumask_to_cmask()
Date: Tue, 21 Jul 2026 12:31:17 -1000
Message-ID: <20260721223118.2268529-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721223118.2268529-1-tj@kernel.org>
References: <20260721223118.2268529-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_cpumask_to_cmask() has no callers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c | 21 ---------------------
 kernel/sched/ext/cid.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 9dfd242be34f..5f990d95735f 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -371,27 +371,6 @@ void scx_cmask_fill(struct scx_cmask *m)
 		m->bits[nr_words - 1] &= (1ULL << tail_bits) - 1;
 }
 
-/**
- * scx_cpumask_to_cmask - Translate a kernel cpumask into a cmask
- * @src: source cpumask
- * @dst: cmask to write
- *
- * Clear @dst's active range and set the bit for each cid whose cpu is in
- * @src and lies within that range. Out-of-range cids are silently ignored.
- */
-void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst)
-{
-	s32 cpu;
-
-	scx_cmask_clear(dst);
-	for_each_cpu(cpu, src) {
-		s32 cid = __scx_cpu_to_cid(cpu);
-
-		if (cid >= 0)
-			__scx_cmask_set(cid, dst);
-	}
-}
-
 /*
  * Return the index of the largest entry in @counts, or NUMA_NO_NODE if all
  * entries are zero. Ties resolve to the lowest index.
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index b36a1a28eac8..470ac9224da4 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -68,7 +68,6 @@ bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b);
 bool scx_cmask_empty(const struct scx_cmask *m);
 s32 scx_cid_init(struct scx_sched *sch);
 int scx_cid_kfunc_init(void);
-void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst);
 
 /**
  * cid_valid - Verify a cid value, to be used on ops input args
-- 
2.55.0

