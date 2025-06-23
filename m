Received: from out187-17.us.a.mail.aliyun.com (out187-17.us.a.mail.aliyun.com [47.90.187.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8C1CD0C
	for <sched-ext@lists.linux.dev>; Mon, 23 Jun 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750653476; cv=none; b=Lscc7Yu5TRlvo6oeAJYAcYbUOg/M8kIR1sFPVw4IrxmteqB2rT8Ph98lVjejlnoVb5BCXHxPV52GI7IGKNwotQqQqC6O7EC5FJ53NG++9++j9oUd9z1GyB3J8hF6D6FmN6WRfx4MsNF9uCwI+JYlKRiGMS5Aqr4K7cQ902oGRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750653476; c=relaxed/simple;
	bh=9cHvpM1axwIYhbnNRB+6jHu0vrYX5mFE06ZLLk1WCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxlI4rq1FPoccO4sBU7gWpu3yhhqRTRCB7sqfPRmycgOWHkNLZiogF8pvfD3oGmqPLpCg33MuzLmbinqytOLvO2abP6GMYv8Flbtszw72lalIVpziQ5RgR1hX0AA8OyFBEuV+b7gbuQShP0W5VHaCu8Oh6IjyAZujZhqMvBiJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Zqx/JYUe; arc=none smtp.client-ip=47.90.187.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Zqx/JYUe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750653462; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PTzqJrjXHODj/Wjy6TXN88FHfaVngWzXDhz04YsGoV8=;
	b=Zqx/JYUeyDP6obVpfePbkOX53yQWJR73OH8p/tTd06Tlo8IELWO5ZpKDpSHFKuVkd51MoNco9IRRtDj/ctlDFV8KpihFcL5VWQKgVQF2ILqakpb+r2lWLhGo9CnjwkRjCytw/J3j1Or7o4V5S4kK+mMuVfkfDV4H3e2y4ktfeZE=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dTqDjet_1750653145 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 12:32:25 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com
Cc: "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <sched-ext@lists.linux.dev>,
  "Henry Huang" <henry.hj@antgroup.com>
Subject: [PATCH v2] sched_ext: include SCX_OPS_TRACK_MIGRATION
Date: Mon, 23 Jun 2025 12:32:20 +0800
Message-ID: <20250623043220.63793-2-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623043220.63793-1-henry.hj@antgroup.com>
References: <20250623043220.63793-1-henry.hj@antgroup.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some BPF-schedulers, they should do something when
task is doing migration, such as updating per-cpu map.
If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
would be called whether task is doing migration or not.

Signed-off-by: Henry Huang <henry.hj@antgroup.com>
---
 kernel/sched/ext.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d86..42c5251 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -161,6 +161,12 @@ enum scx_ops_flags {
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
 	/*
+	 * If set, runnable/quiescent ops would be called whether the task is
+	 * doing migration or not.
+	 */
+	SCX_OPS_TRACK_MIGRATION		= 1LLU << 7,
+
+	/*
 	 * CPU cgroup support flags
 	 */
 	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
@@ -172,6 +178,7 @@ enum scx_ops_flags {
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
+					  SCX_OPS_TRACK_MIGRATION |
 					  SCX_OPS_HAS_CGROUP_WEIGHT,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
@@ -2390,7 +2397,11 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
+	if (task_on_rq_migrating(p))
+		enq_flags |= ENQUEUE_MIGRATING;
+
+	if (SCX_HAS_OP(sch, runnable) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & ENQUEUE_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
@@ -2463,6 +2474,9 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		return true;
 	}
 
+	if (task_on_rq_migrating(p))
+		deq_flags |= DEQUEUE_MIGRATING;
+
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
@@ -2482,7 +2496,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
 	}
 
-	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, quiescent) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & DEQUEUE_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
@@ -5495,6 +5510,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_TRACK_MIGRATION) && (!ops->runnable || !ops->quiescent)) {
+		scx_error(sch, "SCX_OPS_TRACK_MIGRATION requires ops.runnable() and ops.quiescent() to be implemented");
+		return -EINVAL;
+	}
+
 	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
 		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
 
-- 
Henry

