Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4B3D6472;
	Sun,  2 Aug 2026 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707693; cv=none; b=DK/HnMaqddji7eGYJ5TFeA78Ww4p3Ps1RwHoVjXi7dNmJQHeu0uH5TLB/469h04cluGaD3p75zQMWQvjKJMia2WDWvFjFRxHt8ZbnVJxG2ZOXaSdec2Qvd+SnhpXNQuDjJna6SX+Ks1WP5oUPtPYeFPeLn3+7F/uu6+KqHWUuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707693; c=relaxed/simple;
	bh=LarekCwvK5IRvhU1j3njzuu42WBUX8BWHjcHbKKlb80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKAh+9Qe8G/OT4UY4l6F5KFGSsCxhWq7Z1SVdywcAupRI4EJusot/m2C3sP9suuiTHH1vx9NgOegideIKxc1QYRk+NJ7KOG5U8Hbx37XQ8021O26y0TZg7qhLCkJB7MlLztkynp5t4hRXC/k3jjKH4Ln8Yqb0OkbIwb47CneT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isx/O24n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isx/O24n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E8B1F00A3D;
	Sun,  2 Aug 2026 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707691;
	bh=ndK9ILlQsUW1wy209iCaGtsVBuFuArwuyscbD0lRmKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Isx/O24n38PQ9TdiKD1Lcwdq55oA1qDu8JUu2dJQqa7F9RchhKnaiqIVpQt7kJMLJ
	 JE3nowjgwV7QVD3EIiHBHv9Cn6LO+twS9r1DcSHjU677kqkqOJv5WcLVxSP6WRcH2U
	 nDDHB1wq9s/0TITKgtreAzPfr/TB5IU/zn4ktsMSc350OXvgntZtf9JJp51KWfGQZT
	 B7GpOuFycOEgLbNUwuyPjlOvWNyLkoH7PD+jd8qDmXzcqTRIwRRCYr3OOqFNAW+wej
	 onhc+tn8WvD/tTB5lpXaQ9O/5r/h09Zn5vjDh7kWGSptYvBeK24ZeVg4v8Fft2rLQr
	 gvNP9yCtBgMOA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/12] sched_ext: Reject internal enq_flags in the dsq move kfuncs
Date: Sun,  2 Aug 2026 11:54:39 -1000
Message-ID: <20260802215447.3134509-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
References: <20260802215447.3134509-1-tj@kernel.org>
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
index 777ae515c88e..1577a063d63f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8394,6 +8394,11 @@ static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 *enq_flags)
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
@@ -8416,11 +8421,6 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
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
@@ -8652,7 +8652,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 };
 
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
-			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
+			 struct task_struct *p, u64 dsq_id, u64 enq_flags,
+			 bool priq)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
 	struct scx_sched *sch;
@@ -8674,6 +8675,10 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
+	/* internal bit, can only go in after @enq_flags is vetted */
+	if (priq)
+		enq_flags |= SCX_ENQ_DSQ_PRIQ;
+
 	/*
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as scx_consume_dispatch_q().
@@ -8930,7 +8935,7 @@ __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
 				  u64 enq_flags)
 {
 	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
-			    p, dsq_id, enq_flags);
+			    p, dsq_id, enq_flags, false);
 }
 
 /**
@@ -8955,7 +8960,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
 					u64 enq_flags)
 {
 	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
-			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+			    p, dsq_id, enq_flags, true);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.55.0

