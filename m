Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F023D7D87;
	Wed, 15 Jul 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159498; cv=none; b=rv/s8rwQ5MPHneaaHzlUU8qxGTlppKjIrSA1X/DasNBYZ7I7qnuVnFBt8jxfchtwAynRAmE/fYVelwIS+EdYOkFwC4A+pq9vKeAuq763qoMtSnuaklcS4Dw57RklvFEqeFMzAxMbSQI6OFU1NV0RF+UDhwhkGTYvCCmU4wn7Tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159498; c=relaxed/simple;
	bh=UVd4MDKLu999GqbteuyyBKir0lSGhmPtfjxAlnV8UOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoNzKho3IolpIGIrH7Z/8SXkbJtyZ6N8GREgHNRDUK7gaqyHozkU/vwvn6C143iJNhxPGamwYPKLea/8dCH4Maazdh+Q5U5+WldUxXFXYwAUzRFnHUK7qB5+maA7JPVBijXoZ1wyiBPklsHyHV3zB6XW049aNPttMURrVVcM9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO02K4+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO02K4+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738191F00A3A;
	Wed, 15 Jul 2026 23:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159497;
	bh=Ccz51KOc3UZHzByl2QgBkSvr//gPhD6gkeEh3HSHewE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mO02K4+K1omoe8NVGmqCCNsLcztjpRFL1KJSpRHJam9cOrTLR7/zkgKnVrp+1XCHe
	 9jgBH0KRPjq1ngBmI1S2EmKN6kfJRSNS6xl/xOEHuHfsR/Jr2G+jibikpsfdbXAsCg
	 rCTSPdehmodP+/bcLPqCSpFIopOan6srQHLTb5vCsOnaND0a2bxvfqK+u4psQ4RK1Z
	 9djVNVNJHJt4T75xNnhOn8bG76ZdJcl3IBfKTToIDHb2n1GRFeVIwQGxqA006uFrk1
	 euWmnviyeenJWlqtwe+n9isBmfXPvwXZz5ZV71k8oxIvmy1IlmHd+OBVmOs/xXKT6I
	 9TVnToI0V75bw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
Date: Wed, 15 Jul 2026 13:51:32 -1000
Message-ID: <20260715235133.810434-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715235133.810434-1-tj@kernel.org>
References: <20260715235133.810434-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rq->scx.sub_dispatch_prev is sub-sched-only but was left unconditional. Move
it into the CONFIG_EXT_SUB_SCHED block next to ecaps_to_sync and gate its
updates.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/inlines.h | 19 +++++++++++--------
 kernel/sched/sched.h       |  3 +--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 45c657bdad50..d2d074cee1cb 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -74,16 +74,19 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	do {
 		dspc->nr_tasks = 0;
 
-		if (nested) {
-			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
-				    prev_on_sch ? prev : NULL);
-		} else {
-			/* stash @prev so that nested invocations can access it */
+#ifdef CONFIG_EXT_SUB_SCHED
+		/* stash @prev so that nested invocations can access it */
+		if (!nested)
 			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
-				    prev_on_sch ? prev : NULL);
+#endif
+
+		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
+			    prev_on_sch ? prev : NULL);
+
+#ifdef CONFIG_EXT_SUB_SCHED
+		if (!nested)
 			rq->scx.sub_dispatch_prev = NULL;
-		}
+#endif
 
 		scx_flush_dispatch_buf(sch, rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 54cff94556c0..64d79e9efc3d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -814,6 +814,7 @@ struct scx_rq {
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct llist_head	ecaps_to_sync;		/* pending ecaps syncs */
+	struct task_struct	*sub_dispatch_prev;
 #endif
 	cpumask_var_t		cpus_to_sync;
 	bool			kick_sync_pending;
@@ -821,8 +822,6 @@ struct scx_rq {
 
 	struct list_head	sched_pcpus_to_kick;	/* see kick_cpus_irq_workfn() */
 
-	struct task_struct	*sub_dispatch_prev;
-
 	raw_spinlock_t		deferred_reenq_lock;
 	u64			deferred_reenq_locals_seq;
 	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
-- 
2.55.0

