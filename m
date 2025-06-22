Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D137923
	for <sched-ext@lists.linux.dev>; Sun, 22 Jun 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585930; cv=none; b=GdF+va+ry0mypJyP81XyVQv/D47uYOXr/e1JNM0C6ifAb1+qeZUaNjZVEudSQID/0i5pP94I6aidR43hil6fjj3Xr7x+suAilzRy6opHOcZJBmmSFnFAsfvW8cBd+GHg+E88wu6GhfegPeFOoevBqa98tPQzv5Cq0Tl6gLpMAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585930; c=relaxed/simple;
	bh=qg1XKwHQlbCxjbJcFtDomYFzmaLIf8X48YrHz/fk7xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf+v1sByMBedXix77sukx7TGkxMrTR6Q/a9lVM/fPkEphXspmAigMfE5CuEcsqH3IlfB4LZxmNCxJW1gMY0QbHkT4VEPICsnppnvF5D7+6DiSEGsMWzmOnVKml2eDnwX/3tsVsV7ySTUXWKhRdSmoLlTaHrMJmRP1Ih2NgXen+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0jdn/Qcr; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0jdn/Qcr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750585924; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/7LRzQ8TWi10km0kHT15tcByLrhCWbZ/e1nFzvxOMgw=;
	b=0jdn/QcrpIcaLDW7bJgno/+6WTN7CLK76zLd7KWZMYEgstklbftEZ6+iVrgkIVLxfF+7FvuJXmacDOTGdrE7q/aUdNBEXU9cwjtCpgu8LdGrD23/f1Z/eCx3srdJMN9htmWeheMFidyyoZzOib67FBYrvtD5RKE4tn3tJNLT4hQ=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dTG5la5_1750584990 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 22 Jun 2025 17:36:30 +0800
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
Subject: [PATCH v1] sched_ext: include SCX_OPS_TRACK_MIGRATION
Date: Sun, 22 Jun 2025 17:36:21 +0800
Message-ID: <20250622093621.1669-2-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250622093621.1669-1-henry.hj@antgroup.com>
References: <20250622093621.1669-1-henry.hj@antgroup.com>
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
 kernel/sched/ext.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d86..9b05bb9 100644
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
@@ -2390,7 +2397,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, runnable) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !task_on_rq_migrating(p)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
@@ -2482,7 +2490,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
 	}
 
-	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, quiescent) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !task_on_rq_migrating(p)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
@@ -5495,6 +5504,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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

