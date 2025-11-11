Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3D329E73;
	Tue, 11 Nov 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888710; cv=none; b=ZJcrghVPqN2CLwUThA2QINdiLgh/Iv2dwLZcbkRfBz9I2QRy3ZIYa69WzZu8+CCEsyW45g57Rf1DiPvcFaJZWgsJfGMmUEbIXeER6KDgMKsB8Q9ijJtIDfPIp1LW/rHzNGeYp6vHQd4q7s60BvKd/zyATa7gKV8XCGRnuQGvYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888710; c=relaxed/simple;
	bh=SAiKFjCo7NnpF5mJ8ZIkUN5IT7DPGcS5yTN0zcl3ngM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+mBegwceiecKkTX+85sAZDzjat1LA435MT/WBrxH2MBTdw4jCOrr6KyVMzn0cFav17tBKN/HVqIPPYdO/pPNKGPrOLXaq2Inkiwt/4vCIHKRFV7wHOVv2FSLX6ZTHAjsM/9BKoLssaWn1SZ0qDgf4ll9ZXLasZa3MYGJimbG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgzoSt7l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgzoSt7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FDC19422;
	Tue, 11 Nov 2025 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888710;
	bh=SAiKFjCo7NnpF5mJ8ZIkUN5IT7DPGcS5yTN0zcl3ngM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgzoSt7laiphhrPpPhZ9to0tgPyJ14fdg0od2AoocqXty+gk8uwy7756+wiHgKDGv
	 pH1T6giKQuv9u1RSBLpOh1ND+kJSgtN/j21s3DyeJrOmCKg+DYLGYMmzNI/PifY0b+
	 GrrvDIM910tab0ZDfTrwvfR0kJgR5WPnQa3OYOCGEUNQ8SUmmR+86ym60NZxRKwCKY
	 uJUdkTxveLW1x3PxZ8/UCevom2d56fZW3EdJtZhK7syiWDYoiq+26CiiCZd75jCN0Q
	 f3Gs2D74Qb9j6z5M1FQAIVsqk/KUEpUGyli//M1jwbKX+Is6H1JtOfkIBKbTmHTts1
	 a8OXCFyuEng5Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 12/13] sched_ext: Factor out abbreviated dispatch dequeue into dispatch_dequeue_locked()
Date: Tue, 11 Nov 2025 09:18:15 -1000
Message-ID: <20251111191816.862797-13-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_task_between_dsqs() contains open-coded abbreviated dequeue logic when
moving tasks between non-local DSQs. Factor this out into
dispatch_dequeue_locked() which can be used when both the task's rq and dsq
locks are already held. Add lockdep assertions to both dispatch_dequeue() and
the new helper to verify locking requirements.

This prepares for the load balancer which will need the same abbreviated
dequeue pattern.

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56946aceeb28..10d8532f8d9b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1106,6 +1106,8 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &rq->scx.local_dsq;
 
+	lockdep_assert_rq_held(rq);
+
 	if (!dsq) {
 		/*
 		 * If !dsq && on-list, @p is on @rq's ddsp_deferred_locals.
@@ -1152,6 +1154,20 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		raw_spin_unlock(&dsq->lock);
 }
 
+/*
+ * Abbreviated version of dispatch_dequeue() that can be used when both @p's rq
+ * and dsq are locked.
+ */
+static void dispatch_dequeue_locked(struct task_struct *p,
+				    struct scx_dispatch_q *dsq)
+{
+	lockdep_assert_rq_held(task_rq(p));
+	lockdep_assert_held(&dsq->lock);
+
+	task_unlink_from_dsq(p, dsq);
+	p->scx.dsq = NULL;
+}
+
 static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 						    struct rq *rq, u64 dsq_id,
 						    struct task_struct *p)
@@ -1812,8 +1828,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		 * @p is going from a non-local DSQ to a non-local DSQ. As
 		 * $src_dsq is already locked, do an abbreviated dequeue.
 		 */
-		task_unlink_from_dsq(p, src_dsq);
-		p->scx.dsq = NULL;
+		dispatch_dequeue_locked(p, src_dsq);
 		raw_spin_unlock(&src_dsq->lock);
 
 		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
-- 
2.51.2

