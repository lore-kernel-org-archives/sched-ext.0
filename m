Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1B42B310;
	Tue, 14 Jul 2026 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070566; cv=none; b=TCcddj3+Zl//6DVUOJqeKGev3sRuKq9Kk7EXcKQcpJRZ8ymx80T5bbF0FbBvltfbmqOxxyauV1p6M3fTE0mFBANiCtoSqxOb4FZEASJrf370RMRIyGL4RjqE8gqVGJlXziVYYosRTqF4xb3T8nAmrzkOTvb8NuNtx9KvI7ywYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070566; c=relaxed/simple;
	bh=t5RT3oUXnuO7OfGa4X/xjf2nr98QiptcYb7J4NUkgKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuTAuqbKUpfYwIlOEjSys0LphDF8+p272TPmw4CjNF8JKGVYOYB2stmxMOsPK6Vdfh3qfjZcD4nelahipXHwVOuV3OiSiWMHo5kjrPOCF0M0gCULm6D2k8Rl7eOdFXsA2nNTWtVo3BzOduVoIdbwaV7wO/pj/Dvz+7ynqzw/VoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkC4DbtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkC4DbtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F51F00A3E;
	Tue, 14 Jul 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070561;
	bh=W10MfeW/ikZJibnPce/rF0BJm4CgC9lCGJkxaDXKOFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EkC4DbtCqbPcnI+1VWw1+MK7jMFxQt2S7NMbYCQoIW2p/c3QLS/UsoVnrdCwnqqGP
	 vy7rWy7w7DOqXO/Qnsd+Yy0lSr1gwsQcEyMrpgc/2j+Yt1wGswwsEGQhCQ5syZwY6B
	 1yt/bnTVoTjUchuaVSt+MJsfxpQfqXpKWQjMDMzvtGAOTq5dCxqLv9/7hYsTXSMlN8
	 cTvj1+DYxTVnKYgFi6H0537sw/kSNc6M09Q6k/tHTU1ZWLW05pgfPc7/oMEgjTNp+8
	 4GYQ+yj/Amv29nnGQdz2zhAjPSy+mVVOGt35MnntZ+IYAiCWBZKIb/lOU8M2SXlxrq
	 RhACCHj4cs8/g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
Date: Tue, 14 Jul 2026 13:09:16 -1000
Message-ID: <20260714230917.84158-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714230917.84158-1-tj@kernel.org>
References: <20260714230917.84158-1-tj@kernel.org>
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
---
 kernel/sched/ext/internal.h | 19 +++++++++++--------
 kernel/sched/sched.h        |  3 +--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 88b2a9b5d3ab..8c940be9278d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2352,16 +2352,19 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
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

