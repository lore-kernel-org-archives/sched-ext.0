Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B073F6C5E;
	Wed,  8 Jul 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545905; cv=none; b=AWcC2cC69YPVyVZLYHil2fKvclPU91Sw/nRRkn3R/t5cpK0cKJhzrmLIi0n9Wxm5r7iFKtUojb2+MTQQ0sV0ql42iIo6emtoHfO7mqyVHM6idIdOnmW/VwqNJYT5N+1vYHIXP09B+oI9zH+Zmlvf6TB0GbVMEL+zXoUXK97Y3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545905; c=relaxed/simple;
	bh=MOjHNjXOcges43DAS/aD6F71HW4ABfBuJ+hQxH84Bqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4rJBAEUbf5Ob/XzEiOIIEPsE/ztyRPXovPezgRgyZthBTqDhdiaaUYlMBlZ0ikgX0eYoc3Ozyo2slg3skXRXQ2ZtJuPgettPmf2wsa6MfU9g2ZuOdBhvlPTHikZ0HKm/px5DwJPDu4TUH9B2wxCQOcUfnNk9IxoDAeqH4b0TDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkAn89IV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkAn89IV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912561F00A3A;
	Wed,  8 Jul 2026 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545903;
	bh=+uEguZxyIE6mjkluZClrKp3VSo5c4wD2vGWimD+nDG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkAn89IV+BFNz6t18Wd0N9ZHmWrx2nbpvQ0OiOCG9iXtFz8A4K3isp+NlRNxDX4jL
	 pv2xFQkb08+85gABP0W/Pfqg8CQYWfch3kMUJj5YpWamG5Bw0DR7guaZHygwi5hu2D
	 Cxs6cbr2sxf/AVOeGfIX3kbpAAPOIgxqrN8UlAml22ajju9pjiPFs/50805iExmaeP
	 y/p7sQQI0cLZNXvxovsBMQmOWQMoccv3J7LeCrVMN2s617WoSy4dQr+sUoiozzlDVP
	 unNQbT7OsFF2zURLSbTd1o0/icLqv6lBO1RBMVffsc21UDPQ8iF6v0ckD+TpdmzwgV
	 ZX9ypvL809f+A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 30/40] sched_ext: Track the cpu a task is runnable on
Date: Wed,  8 Jul 2026 11:24:19 -1000
Message-ID: <20260708212429.3405787-31-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add p->scx.runnable_cpu, the cpu @p is runnable on, or -1 when it is not.
It is stamped as @p joins the runnable_list (set_task_runnable()) and
cleared as it leaves (clr_task_runnable()), both under the rq lock.

task_cpu() can't answer "is @p on this rq" reliably: a remote wakeup changes
it under @p's pi_lock alone, without the source rq lock, so it can read as
the locked rq while @p is really elsewhere. runnable_cpu changes only under
the rq lock, so a caller holding an rq lock can compare against it to know
whether that is @p's current rq.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 1 +
 init/init_task.c          | 1 +
 kernel/sched/ext/ext.c    | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7e3f6b33f4a8..853f03b63133 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -201,6 +201,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
+	s32			runnable_cpu;	/* cpu @p is runnable on, -1 if not */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/init/init_task.c b/init/init_task.c
index b67ef6040a65..5c7ad50ac685 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -145,6 +145,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 		.dsq_list.node	= LIST_HEAD_INIT(init_task.scx.dsq_list.node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
+		.runnable_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
 		.runnable_at	= INITIAL_JIFFIES,
 		.ddsp_dsq_id	= SCX_DSQ_INVALID,
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ef0bc5c521d2..f5c34d77225a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1849,11 +1849,19 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	 * appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
+
+	/*
+	 * Record the rq @p is runnable on, maintained under the rq lock so it
+	 * stays valid unlike task_cpu(), which a remote wakeup can move under
+	 * pi_lock alone.
+	 */
+	WRITE_ONCE(p->scx.runnable_cpu, cpu_of(rq));
 }
 
 static void clr_task_runnable(struct task_struct *p, bool reset_runnable_at)
 {
 	list_del_init(&p->scx.runnable_node);
+	WRITE_ONCE(p->scx.runnable_cpu, -1);
 	if (reset_runnable_at)
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
@@ -3501,6 +3509,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
+	scx->runnable_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-- 
2.54.0

