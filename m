Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B27846A;
	Sat,  1 Aug 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574317; cv=none; b=LqbjmbLwnxPKAZgSTiwmVgG5i8IT1tc7orz7ZX4fv8Zwdab98mCqIVxwsbePqXGKlcP5tEBozuq0kz4xZd9hmPVw1S63kPnye7PQ1UAQMJDsKu0zRchi8HSEb0B0jxnzdtV8F9alivUgzU6NyfoOszWaArFP0YyNdST/rjlc8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574317; c=relaxed/simple;
	bh=J5DV9VvcBTHGZ6DCK3OSV2r8qVjUpJ5ye40RyKFKbnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qajyi0OeO7wKnPrtIwwh+pgMMiyjITTEXVIvOZyOKS/5OCRSL8TWO9KxQvS77Rd+AjxSTUEOMvQkzFruvb41RijkjC54uRFd0nwA1ueU4ql5TbN4HaMLokLIWbuk76WoLr50Twz9Ln5QQLSIFJUH/kDdLcBjMgbrC2qOUzv2HY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeERScBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeERScBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899331F00ADE;
	Sat,  1 Aug 2026 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574315;
	bh=2p4h7LgtBqZLcaXjtZmO6y8QdHjeUJC+/DixWNs6qa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeERScBsysEtOEmPrBuR5dCIAIPoaz7V+SdIv6hafa1WmlILw60X0/pzGnR7vv2Gm
	 mX5JVc6YqYREmtcLiANWV203rQWNcLI76k/1uDUJEYod4KK9YvlF9gW/H0A+xRLBjK
	 fCOiLanXUoUuuDOPRzIAWxygNyAGarWzZHWSedB6/F00gnzeLqUTHwDwftBd71GbOg
	 QxGwmNC7YuEelTQxAMjn1rs3A4d2cAhWMH/Cc02fsmII7PWh1/JQBHZS87SvJgPFe1
	 7CeqqZZFJQlo81Lp+76kDKiW+jnwKzVp7MTrTasYeIRy3QpdYg8sZ7JTABlylk4UKg
	 JfVINALo4GmFg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/12] sched_ext: Reject internal enq_flags in the dsq move kfuncs
Date: Fri, 31 Jul 2026 22:51:42 -1000
Message-ID: <20260801085150.2697653-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dsq insert kfuncs reject __SCX_ENQ_INTERNAL_MASK bits in
scx_dsq_insert_preamble() instead of scx_vet_enq_flags(). A scheduler can
smuggle internal flags such as SCX_ENQ_CLEAR_OPSS through the dsq move
kfuncs and corrupt the dispatch protocol. Move the rejection into
scx_vet_enq_flags(). The vtime move wrapper OR'd the internal
SCX_ENQ_DSQ_PRIQ bit into enq_flags before the vet; the bit now goes in
inside scx_dsq_move() after the vet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9ce7e50c13d3..028cfbcd1314 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8393,6 +8393,11 @@ static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 *enq_flags)
 	bool is_local = dsq_id == SCX_DSQ_LOCAL ||
 		(dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON;
 
+	if (unlikely(*enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
+		scx_error(sch, "invalid enq_flags 0x%llx", *enq_flags);
+		return false;
+	}
+
 	if (*enq_flags & SCX_ENQ_IMMED) {
 		if (unlikely(!is_local)) {
 			scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
@@ -8415,11 +8420,6 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
-	if (unlikely(*enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
-		scx_error(sch, "invalid enq_flags 0x%llx", *enq_flags);
-		return false;
-	}
-
 	/* see SCX_EV_INSERT_NOT_OWNED definition */
 	if (unlikely(!scx_task_on_sched(sch, p))) {
 		__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
@@ -8651,7 +8651,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 };
 
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
-			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
+			 struct task_struct *p, u64 dsq_id, u64 enq_flags,
+			 bool priq)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
 	struct scx_sched *sch;
@@ -8673,6 +8674,10 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
+	/* internal bit, can only go in after @enq_flags is vetted */
+	if (priq)
+		enq_flags |= SCX_ENQ_DSQ_PRIQ;
+
 	/*
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as scx_consume_dispatch_q().
@@ -8929,7 +8934,7 @@ __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
 				  u64 enq_flags)
 {
 	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
-			    p, dsq_id, enq_flags);
+			    p, dsq_id, enq_flags, false);
 }
 
 /**
@@ -8954,7 +8959,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
 					u64 enq_flags)
 {
 	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
-			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+			    p, dsq_id, enq_flags, true);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.55.0

