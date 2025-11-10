Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F93331A4F;
	Mon, 10 Nov 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808211; cv=none; b=gm42/feYiT9hR4IYBBbohZ/9XXswYnhelpzXHL2Pt/Xm4Z0u4fH+iDLyjoAFhEjpZ8J7e5WIT2uAUvB9DIIsW3cbkQMFGkUbfvGnjv+AC7Ag1YTzgAk5OTCU5vaEH4GXazazXbY7AquonamtQwfjmzAW2RkRypuvXRGcGlAHpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808211; c=relaxed/simple;
	bh=Xdp8yvSa/eU1lzUi/lbdX3fqdzXdYLCBxBd+AS0g1AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbROuqBPKmtDsGUvzC9k3gntKaptxVFSvzW35WLwlEfULgHgxHmxtci94IjZPhRLjrUHm7EtHSmsETR3vnwFrlJpDV0OsWbl+Pim4KaclLqQ14OV7vVgvsYC5zlW/fqsVbemit9oUy4+179aYJq/ObStfLcHsYA2rNgFHvld8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol4qRsKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol4qRsKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1903DC116B1;
	Mon, 10 Nov 2025 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808211;
	bh=Xdp8yvSa/eU1lzUi/lbdX3fqdzXdYLCBxBd+AS0g1AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ol4qRsKO4eJSAcXQ6jXdRYyIgLhzLS3+O7e58aZ8kZ4Py481rQ7jQKpDTn3hFzKVo
	 zSMi92sr428t5uXZW1JRdDoWBVDIQIjZNHV781xg0vhluujluzw2puyD7Lm1mqa6P+
	 TWBNwE+aetRoMF3qpPJifQw2oLAYImuEM1IB/T1nP3pMWEktDkDF8wDs/jSheMHgJ+
	 2CJ72Pw0hQoY+XjV3VQvtiDn4bydoenRxExu8nLU4UphetxXqS+BTVa4KPyTroh6OE
	 gginEgXQLChh1KlU7u08YILqHLeCSUVsVFq2rveXCNjgOuJblfE7juMQfX5Na0nm6c
	 yz1o65nEMMooA==
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
Subject: [PATCH v2 13/14] sched_ext: Factor out abbreviated dispatch dequeue into dispatch_dequeue_locked()
Date: Mon, 10 Nov 2025 10:56:35 -1000
Message-ID: <20251110205636.405592-14-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
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
index 82f0d2202b99..3bb0e179b512 100644
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

