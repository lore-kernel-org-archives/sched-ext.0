Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC930B502;
	Sat,  1 Aug 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574314; cv=none; b=mzMwhkiffsWtWK5OHyomxiXx5Z+UNYmvmOyYFKipKeEFaeiBqM2TvPomY3LJ2docP5vVTA2on+V9yQUdMq04KryO8pxwLUFRffTE2BEUle+K0h3BuJnZSgBN/P+XGmVmbu17H0U2RQaWEoqmblLogMaq7HjXr/S2AMPwNO860eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574314; c=relaxed/simple;
	bh=5Xqn2vEhXNIs8tQKCUxZmMg0A2PQd6PLdq19A0aIxCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9NlF+nt4G95xHv0lFgC4SSxA2Yo5ozQZEqdSOmCh2IKV2nmog0wXOGI0hB0+ZgyNzvNR+cdL9Rlj8tcGRc8MMKEPkblsLTKgZmrLRUMajVvM2RU1xIuqPSGMyEb0on7MurOLU/BBzt1zTk3mSJqGoTV8Gw5sRhzn8UYNv0MvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0L9+wbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0L9+wbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAFA1F00ACA;
	Sat,  1 Aug 2026 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574312;
	bh=OSYbT2I+ge3QhjhUC60Undj5rTfEV7kIoyyujsbgHjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0L9+wbGodnaLKIw7vNfzgS5m0XLHwMRWBwgmQ6kHftGEkrLvEQ8gqy2FSsHZj/oF
	 1eTtJ8n3ROwcuK5wNbB4L+/+vJYEE99V/ucJuc9smoVEC9V+gFGX1tRwICdzxI+y77
	 tUXqSmVEvbJp1oruKHEWyyYz3tUWr+Nmr7wSimwaWJnuQ1nkhaX4rkJHZBy6yxJr/X
	 PEAZv7fI8RRjseqRzOsv0hME+R7JY/7mKyhmgpkKowE/t1/VLZFDBN+kndVqpGzwcq
	 WorDx8d4SxaTDMCLakmFy+ViJIZpR4NKEqXuY4pGDrvEJxur32aupay5Y8Jzgf5yxV
	 fIiDbBMBEo7Hg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/12] sched_ext: Rename scx_local_or_reject_dsq() to scx_resolve_local_dsq()
Date: Fri, 31 Jul 2026 22:51:39 -1000
Message-ID: <20260801085150.2697653-2-tj@kernel.org>
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

The following rescue execution addition gives the function a third possible
destination, making a name that enumerates the outcomes a poor fit. Rename
to the destination-neutral scx_resolve_local_dsq(). No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 4 ++--
 kernel/sched/ext/sub.c | 6 +++---
 kernel/sched/ext/sub.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 312938179e52..595b45746245 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1507,7 +1507,7 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	bool is_rq_owned = false;
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
-		dsq = scx_local_or_reject_dsq(sch, rq, p, &enq_flags);
+		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
 		is_rq_owned = true;
 	}
 
@@ -2279,7 +2279,7 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq = scx_local_or_reject_dsq(sch, dst_rq, p, &enq_flags);
+	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
 	/* @dsq is locked and @p is on @dst_rq */
 	lockdep_assert_held(&src_dsq->lock);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index daf7fbd3d0c3..2ea9a690e986 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -230,7 +230,7 @@ void scx_init_root_caps(struct scx_sched *sch)
 }
 
 /**
- * scx_local_or_reject_dsq - Pick the local or reject DSQ for an insert
+ * scx_resolve_local_dsq - Pick the local or reject DSQ for an insert
  * @sch: enqueuing sub-sched
  * @rq: rq whose local DSQ @p targets
  * @p: task being inserted
@@ -246,8 +246,8 @@ void scx_init_root_caps(struct scx_sched *sch)
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
  * always holds all caps.
  */
-struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
-					       struct task_struct *p, u64 *enq_flags)
+struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
+					     struct task_struct *p, u64 *enq_flags)
 {
 	if (!scx_has_subs())
 		return &rq->scx.local_dsq;
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 0019b75a2560..db449559bbe8 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -34,8 +34,8 @@ void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
 void scx_discard_stale_ecaps_syncs(void);
-struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
-					       struct task_struct *p, u64 *enq_flags);
+struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
+					     struct task_struct *p, u64 *enq_flags);
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
 void scx_reenq_reject(struct rq *rq);
 
@@ -84,7 +84,7 @@ static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
 static inline void scx_discard_stale_ecaps_syncs(void) {}
-static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
+static inline struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
 static inline void scx_reenq_reject(struct rq *rq) {}
 static inline void scx_dec_has_subs(struct scx_sched *sch) {}
-- 
2.55.0

