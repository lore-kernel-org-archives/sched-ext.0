Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A133557D;
	Sun,  2 Aug 2026 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707690; cv=none; b=Y6nscpwFwkBtvWErfg2s1XXpTryVl9VCDGpoI2lohGxpP4eUTMCpO0uAmoqhakJ7t1gArPrzdp8WxYc6Ikf7lDxOpwTCwxsCc8Va8N53SRsbOkFk7LQSwxd3C5WkQ8p8nwf31zAw8mTlhn6ds3fzCDtU9bQeEj+UveY3S0/eKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707690; c=relaxed/simple;
	bh=xDsG8zPZ0e5SvEK1kCWjm2KrhPMaxpckWoFYFzfHxic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FidFk2THi17tGJIATADu01SVzeVU65wGeS1vArJLIlAvL6NVFcbMpfxxuCP9OMbkWDFEa/rGAEV73zEGckcCkPokojckLSqKrCLr40vs+H88muexpWD723wvhkbe1rRth1RyAhp3rME3nIBTPwSS1NskcEZoPYdb3lKVHBWsCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k40tMgR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k40tMgR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9211F00A3A;
	Sun,  2 Aug 2026 21:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785707689;
	bh=ogUOXETMQlXJTJr1i4dEC9jxsqqK5Lqsp+thX7AI4Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k40tMgR0rT8g58tmiXMpTECZKYooLuOQvDazOr9pXk60Fg84U0uku+QXDlbel9jFS
	 dAa29RHiVzIRkaXQb9ssx4mLJS3UqDhLZdx9c/eedPmLm77/G2nuGomDsLc8NyDEpH
	 ZSDzCk47ugQDyP/oyS3OI5Mskh06zQCuS1oP+vlQNDHeS2hwzA82Y6vz8xOVwOdSr7
	 AFY9YFQsb+YXtndIq5xaTi/CQQ1h8QH5PjmQ+VT8YZ4ncUc0VYoFrZ7ARKQIEufwlJ
	 jqVlUSa23szl/uORA7T8ZUbUIHPKi6HLiJRST0M+IEjLyFcV6th7B7iXGmeQYBz39b
	 ZJaOqNl3Y/+Sw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/12] sched_ext: Rename scx_local_or_reject_dsq() to scx_resolve_local_dsq()
Date: Sun,  2 Aug 2026 11:54:36 -1000
Message-ID: <20260802215447.3134509-2-tj@kernel.org>
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
index 6a3e94707c8b..8e5c7e45520e 100644
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

