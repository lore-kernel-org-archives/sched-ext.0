Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676623CFF49;
	Mon, 20 Jul 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535970; cv=none; b=uKGzxTpIdwoUgwJLDkllxbVnxI3LxSpwtDzx8+Ce2L9sUeqcxFuZGzrGFFAIM26B0ShC/C2xictHXVbFUSSZ1tiicBTuQMEoEJkGFrFsenpyy4Y5XklZNr2uAQTWAUuCAvJTyGxl83fGwZTPNwEVYa6yZVfz+YTOu4fGBRraDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535970; c=relaxed/simple;
	bh=U5zIrNcSbtAxQ3uzISpC42OPX0dW+4SQgwiWK+iL8VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRWLwLmokKaZG60ywj185zMS1vNzjc+G87lq9yGJY4vNMrC1NoQbiW6Blm6mSqgJSKaiCDszaf6jm1jbcCimP6expCPZvKJl50wLvTRAk3hYPeujczjP6Ess1Ye7lG7qKi5MDksC29Xqx6tWxNn/WmfuqtB5jqDqXCT82CG+J30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YztwI2Wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YztwI2Wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231FA1F00A3A;
	Mon, 20 Jul 2026 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784535969;
	bh=hCNwYM3NF2P3NU3LkmGKN/ywMHgD8/jO2BF6DSBOa2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YztwI2WuHKFKIhPcEiLZKJDf7MRk1vYhTHkAT8JwV3FJ+yrj/T30tKJ84UGjQRzgH
	 xO//aAsfBsrxakzWn7cUALObjlmD8ldLDIh/T96F6OJ4l97HmMF+ZfPgWD25Yoay/m
	 TNsY06m4kGIbLAxW7HKVSKkZkSl53NUxE77cxwCZljnkd6A7Z6FT5YQV/FQEtO2oem
	 RSqCW1WJj5fY1NlksccSxXqsIlO9F73k+1DZD3+CXZjR6mh+56YKkYz/NIaY5nATIL
	 PUISVXsaVyBZUXT+sgqvl+Kb1s92ni+A6+6NEERPFvS/Yt8BO2RBnAhWvTYcb+kdwq
	 u7KiWblItbWRA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: Guard the cid kfuncs against unallocated cid tables
Date: Sun, 19 Jul 2026 22:26:05 -1000
Message-ID: <20260720082605.1451945-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720082605.1451945-1-tj@kernel.org>
References: <20260720082605.1451945-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid tables are allocated by the first enable's scx_cid_init(), which
runs after scx_alloc_and_add_sched() has published ops->priv. A TRACING or
SYSCALL program associated with the enabling struct_ops map gets a non-NULL
sched from scx_prog_sched() as soon as ops->priv is set, so a cid kfunc
called in that window dereferences the still-NULL table pointer. Only the
first enable since boot is exposed as the tables are never freed.

scx_bpf_this_cid() and scx_bpf_task_cid() already handle the window by
testing the table pointer. Do the same in scx_cid_to_cpu(),
scx_cpu_to_cid() and scx_bpf_cid_topo(), returning -EINVAL / all-(-1) topo
as before any scheduler is enabled. __scx_cid_to_cpu() and
__scx_cpu_to_cid() stay unchecked for callers with the tables guaranteed
allocated - ops invocations on a live scheduler and the enable path itself.

Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c |  5 +++--
 kernel/sched/ext/cid.h | 23 +++++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 9dfd242be34f..699cb8db228d 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -875,17 +875,18 @@ bool scx_cmask_empty(const struct scx_cmask *m)
 __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
 				  const struct bpf_prog_aux *aux)
 {
+	struct scx_cid_topo *topo = READ_ONCE(scx_cid_topo);
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (unlikely(!sch) || !cid_valid(sch, cid)) {
+	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
 		*out__uninit = SCX_CID_TOPO_NEG;
 		return;
 	}
 
-	*out__uninit = READ_ONCE(scx_cid_topo)[cid];
+	*out__uninit = topo[cid];
 }
 
 __bpf_kfunc_end_defs();
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index b36a1a28eac8..1498efb81549 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -90,9 +90,10 @@ static inline bool cid_valid(struct scx_sched *sch, s32 cid)
  * __scx_cid_to_cpu - Unchecked cid->cpu table lookup
  * @cid: cid to look up. Must be in [0, num_possible_cpus()).
  *
- * Intended for callsites that have already validated @cid and that hold a
- * non-NULL @sch from scx_prog_sched() - a live sched implies the table has
- * been allocated, so no NULL check is needed here.
+ * Intended for callsites that have already validated @cid and where the
+ * tables are guaranteed allocated - ops invocations on a live scheduler or
+ * the enable path itself. Prog-facing kfuncs, which can run while the first
+ * enable is still allocating the tables, use the checked wrappers instead.
  */
 static inline s32 __scx_cid_to_cpu(s32 cid)
 {
@@ -119,13 +120,17 @@ static inline s32 __scx_cpu_to_cid(s32 cpu)
  * Return the cpu for @cid or a negative errno on failure. Invalid cid triggers
  * scx_error() on @sch. The cid arrays are allocated on first scheduler enable
  * and never freed, so the returned cpu is stable for the lifetime of the loaded
- * scheduler.
+ * scheduler. Return -EINVAL without triggering scx_error() if the tables are
+ * not allocated yet, which a prog-facing kfunc can observe while racing the
+ * first enable.
  */
 static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
 {
-	if (!cid_valid(sch, cid))
+	s16 *tbl = READ_ONCE(scx_cid_to_cpu_tbl);
+
+	if (!cid_valid(sch, cid) || unlikely(!tbl))
 		return -EINVAL;
-	return __scx_cid_to_cpu(cid);
+	return tbl[cid];
 }
 
 /**
@@ -138,9 +143,11 @@ static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
  */
 static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
 {
-	if (!scx_cpu_valid(sch, cpu, NULL))
+	s16 *tbl = READ_ONCE(scx_cpu_to_cid_tbl);
+
+	if (!scx_cpu_valid(sch, cpu, NULL) || unlikely(!tbl))
 		return -EINVAL;
-	return __scx_cpu_to_cid(cpu);
+	return tbl[cpu];
 }
 
 /**
-- 
2.55.0

