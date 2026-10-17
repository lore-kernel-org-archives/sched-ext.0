Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29C3F23C0;
	Sat, 17 Oct 2026 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281522; cv=none; b=iy1ZI9WBv9z258588Mj9qty6Dg1OOFfis4twnMNfyoR7lTsiSjOQO+vFn+U1rMYfY+lb9fj0U09ADsyFECCnWNZNtPHrG0kd5J3R2Fhu4xIkmomWVdCoDvYkYWWYVNUoh+B4Yg/e3DJiYYMP2tIYww5CSf3B1AOorOlHnLaLoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281522; c=relaxed/simple;
	bh=i1JoDSMQsfyQCWPin9CWuTGDf4DbIkRgW1bQNI6/tCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIye7VwKaQYBI0ZGjZWPUJUGlHBVS3ji9zZt3LdzprNXS4GrH88ZtQDN5O6xgLKnIJbOiQAbUhqpzGXaclBUuFljtiiKNgDo+mLh4l1HlbbAAB4YNM0Yr7c/iGvJ+s25b+mS+izbWi1Sx1aaLlbarOWqZf858HYHsvXDRTQ+uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni3sM2/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni3sM2/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B811F000C6;
	Sat, 17 Oct 2026 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792281521;
	bh=Xim3n1YnAwfRcEuEbzZA+jo5ewtNLVgOOQ+QHN4UHwU=;
	h=From:To:Cc:Subject:Date;
	b=Ni3sM2/nU5BN5baRXRA9EFRpDiEU/G1lPDh/42QiJG8O6fhDi01SlnwdpehdBq590
	 U+mMWRL/e3CrJMu2FAtl26zhqjjJew+McF9hj4A0xzvYjg3JFQwl+63+L+kaJegFoc
	 r0rPFq03JdJT52niOdQrbE/i4qZEnYNw7aalg8+tziSN9Prn3UNjZr02bKXeocORYV
	 eGriv3vBkUP/+zRkTnbIavVroSW6lnDt5bcwfOK2FXjRpzaePWp6Jzb+rc8yk52Wq+
	 GqYNEZ9IYOi7QI2dAidi75TfLvJ8Xn0uo9AqVwn4vvMJCAf1l6gIy/EQMxn/wTveXt
	 tNVM0mH5JlY1w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.4] sched_ext: Drop the locks periodically while walking a user DSQ for re-enqueue
Date: Sat, 17 Oct 2026 13:58:40 -1000
Message-ID: <20261017235840.1446655-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reenq_user() drops dsq->lock around each re-enqueue and its rq lock every
SCX_TASK_ITER_BATCH re-enqueues. A walk filtered by SCX_REENQ_MARKED skips
unmarked tasks without dropping either, so a long run of unmarked tasks is
walked in one hold of both locks.

Count the visited tasks instead of the re-enqueued ones and drop both locks
every SCX_TASK_ITER_BATCH visits. An unfiltered walk drops the locks as
often as before.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/all/atP-LIKpxPhR-Nuc@gpd4/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 14fe63428036..07857039aee6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5111,7 +5111,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 	struct scx_sched *sch = dsq->sched;
 	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, dsq, 0);
 	struct task_struct *p;
-	s32 nr_enqueued = 0;
+	s32 nr_visited = 0;
 
 	lockdep_assert_rq_held(rq);
 
@@ -5121,6 +5121,21 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		struct rq *task_rq;
 		u32 reason;
 
+		/*
+		 * Count skipped tasks too so that a long walk doesn't hold the
+		 * locks throughout. The cursor keeps the position.
+		 */
+		if (!(++nr_visited % SCX_TASK_ITER_BATCH)) {
+			raw_spin_unlock(&dsq->lock);
+			if (locked_rq) {
+				scx_rq_lock_drop(locked_rq);
+				raw_spin_rq_unlock(locked_rq);
+				locked_rq = NULL;
+			}
+			cpu_relax();
+			raw_spin_lock(&dsq->lock);
+		}
+
 		p = nldsq_cursor_next_task(&cursor, dsq);
 		if (!p)
 			break;
@@ -5157,13 +5172,6 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 
 		scx_do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
 
-		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
-			scx_rq_lock_drop(locked_rq);
-			raw_spin_rq_unlock(locked_rq);
-			locked_rq = NULL;
-			cpu_relax();
-		}
-
 		raw_spin_lock(&dsq->lock);
 	}
 
-- 
2.56.0

