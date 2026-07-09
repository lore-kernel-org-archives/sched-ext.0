Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEE3E7BCB;
	Thu,  9 Jul 2026 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637471; cv=none; b=lRi6LLaMuCvcgEeBW5XtuUEgFi1i4cx1GrKRlnPAnoD6niS9HJoS4sMyhaZXQqDxzjz82YuOOhdkAY53aw5730DYQWi/P9BscSw9yfQhLzgwx8KmIm31UsmsEcaGpFHe2/NxUSlJ/euQeL8ET6z/kC9u7GaUb2KRWiZ+6r/C16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637471; c=relaxed/simple;
	bh=mwEZlT2cjTlqTdR2O8tpilISnNMlHrBapPCmD++iOb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsPX3uo2G47c7T+ZNrO6PFqwAjHmS8kVcNi4tBUBS0kmPXg8qLQzbj4xXEx8lx1XutIFR0jenAcIo0ZVoSEaKel07Ug/zsRh05hx8yv1b54aIe+UNqYDJl8SmQBpmE7E++OB8Vu5klYzSGuw3IA4/cd1yERTT8UJg8ACl/0YMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSkSHPEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSkSHPEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AFD1F00A3D;
	Thu,  9 Jul 2026 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637468;
	bh=PEI7FC0lDEBoLFhvJDHiTd3Z4Gj4rRVoO0VGNj4k/Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HSkSHPEyVflk0rlMhIdmtvRIfJKG4pntCzO2m3F38/93cKq+7sVF0P4SXhlgocHS4
	 9Tfd5R8nOHI2k/0aSvrGZfjEufykOC+lKcCKOy2zmZmATDcQvd4nxbrY5ye+wIRVYO
	 7+keRzv2FzBhrOvEXr/vEVKbo84T58zzj839FjS/TiksaRIllMrMa0OmWR+uK2hnHj
	 WLa+dX8ZEPTgNSkbokBqZmW+/IRK4iw1yaocmF+NEX2/sK8xnBojKJ/IQELMBoQGr+
	 N2K3cMB1+qlbiioSevPvU3ZtpxM8GAPu/fGgumHmEyDGYfH+sWhP8ss1NO2ciEYwEh
	 rtSqfswPT1mfw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 23/33] sched_ext: Track the cpu a task is runnable on
Date: Thu,  9 Jul 2026 12:50:31 -1000
Message-ID: <20260709225041.1695495-24-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
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
index de5a7293c1fb..b58b3b4bac18 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1865,11 +1865,19 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
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
@@ -3531,6 +3539,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
+	scx->runnable_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-- 
2.55.0

