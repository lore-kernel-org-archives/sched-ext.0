Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78D32E121;
	Mon,  6 Jul 2026 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302062; cv=none; b=VJIvKthiofRaDVXy/Pm9fzdrvTCbtEPulFtM7ZVFH24NQFoCNc8sI7i2aWnLd8FXBmyQIt/22tWlc/sH9elVmQKdmqrg9NDVSdqNIJiOybM/uAS4W26b2QNUDbb2/lVFbtjPh2RO0QzenxPx+vIXzkY69QiVdfs4Q0TylWxDQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302062; c=relaxed/simple;
	bh=Gs0DY4skzUxDJcoAUdLKS+CVrIjwqmDpuXBlhkdHboY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkzB4iqRislaaLt9hB25ITgj41FwuvpDG9cnhgYsgCtoJy8MB6agsroa9bl4nWMGgIvQpWec3L5YVIr9BN6Mhu0HHeYitZiugqNr0gygUkBE/7w23n1xPrZVogeoQrIAC8vO1nYwh9GJnXzAD5bVMK6tNIt9vE9PH12ont/svAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0kr5LQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0kr5LQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FD91F00A3D;
	Mon,  6 Jul 2026 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302061;
	bh=G53dXQhkJaxH3bQ+S+EqX2WmpEbXWk3f96dnSqTuycQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0kr5LQ6tQm7ZhQS/9gSEnaKZ+MB4eOTElHsnKFO01eJ48GABTUYShMC8gTCaDGqS
	 QT5nNiwHftGytxkqo7lMQ/4ugZqIbZrNrKGAxGqjjJMtdGdc5obWUrYQjuImJ+xugC
	 QC9ypDhqo1NtPNyEcyNc6dKSjpwLb0wQKJC5Q7rCJcuf1w6MqW5JsNUhdAKyNF1zn2
	 YnJSpFxbkwvAPfO1leYzyBwys9Q6EffCYOlFtk9xWGMztK0VF1LxHqQtrDd5hNnZjr
	 SDrmALOL03MX/KjVSgbQNxO11mbki+RaubTQ3P827ErDGx/Ttz//YbOJ4B1aQQbhxk
	 hgSibx7HkynuA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 02/36] sched_ext: Rename extra_enq_flags to remote_activate_enq_flags
Date: Sun,  5 Jul 2026 15:40:24 -1000
Message-ID: <20260706014058.439853-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_rq.extra_enq_flags carries scx-specific enqueue flags across the
activate_task() boundary during a cross-rq task move in
move_remote_task_to_local_dsq(). Rename it to remote_activate_enq_flags to
name that role, and fix the stale comment that referenced the old
move_task_to_local_dsq() name.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 10 +++++-----
 kernel/sched/sched.h   |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b1bd506fd6ec..d15cf3c7f87c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1824,7 +1824,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 {
 	struct scx_sched *sch = scx_task_sched(p);
 	int sticky_cpu = p->scx.sticky_cpu;
-	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
+	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
 
 	if (enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
@@ -2097,13 +2097,13 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	/*
 	 * We want to pass scx-specific enq_flags but activate_task() will
 	 * truncate the upper 32 bit. As we own @rq, we can pass them through
-	 * @rq->scx.extra_enq_flags instead.
+	 * @rq->scx.remote_activate_enq_flags instead.
 	 */
 	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
-	WARN_ON_ONCE(dst_rq->scx.extra_enq_flags);
-	dst_rq->scx.extra_enq_flags = enq_flags;
+	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags);
+	dst_rq->scx.remote_activate_enq_flags = enq_flags;
 	activate_task(dst_rq, p, 0);
-	dst_rq->scx.extra_enq_flags = 0;
+	dst_rq->scx.remote_activate_enq_flags = 0;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba26..80b72d934ff3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -797,7 +797,8 @@ struct scx_rq {
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
-	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
+	/* see move_remote_task_to_local_dsq() */
+	u64			remote_activate_enq_flags;
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			in_select_cpu;
-- 
2.54.0

