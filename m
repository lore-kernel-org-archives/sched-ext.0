Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BC3AA187;
	Wed, 29 Apr 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451024; cv=none; b=s4vJgoP7V8nLFQAoktG8lILCYfxBUDTCpQzgirHlJAFbKH5+xVJZirSBbGRXK+ToCtZLofTxkG6cYPrBt7Dw4qyYWaLrtlnmqc3n0IEIz5OO2UkUhRoNqM70exBaBRwyCoWiWpqWl66JjDxjXSfAIS0SukX5sf/Xu3DpRoooxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451024; c=relaxed/simple;
	bh=tmev3C0/K61R5hUQP3goa+paRWXMOoFpuhKJgZgtJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDrFFriwhMBkPWB+qmu64NQoMjB0fubwKN9WI3NFRBPhjUQeDwR4sQRtjOuYRdPiRRJYQw/PU76DnlGO/bVtmrI5YHUd7xIqSIcxA/I9WMxStqYo8yfW+quQ+nBL/OmATpGjYieizptSAz3YTYUqbg1NRYqRoAVYtf5apGB1sAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KtuNUzKL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KtuNUzKL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xgf1mC19G3kAVlRSFzdVX0/yQON471GsvBrex7BxcXc=; b=KtuNUzKLux22e3G+9D2LEt3pmc
	r5AUDxzAzgYbuljWGkpyueKqiemMhtS5qwA5xgZyEXbCQR1+yGRmXPybOhAWNbBeKS7OtQFVFhl25
	ZM9lYhaKbfUq5L4/5DWOCnycplSeCYwuNJOo81+txoizp0xnSZJXBsJtmFuh8os1ZJ0+Pbo9ncF+/
	v/qgBxIxuNxNgoDZewnIJ1EXEoXN6j6UkI5Wiix2bGO0HQfQ4wGhH3foWBkbfpZ7hs46WrbqaA/Zd
	ODsG8FHFHVH/0GWzuFVBFsOjwKraPAhMSCaX5xYBobOF6vUdEfwAofHQRoyu0rDL4q7L0e2AV8l3Z
	lpknCOGQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wI0Cl-003oj5-Ho; Wed, 29 Apr 2026 10:23:35 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] sched_ext: Extract scx_dump_cpu() from scx_dump_state()
Date: Wed, 29 Apr 2026 17:23:16 +0900
Message-ID: <20260429082318.420146-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429082318.420146-1-changwoo@igalia.com>
References: <20260429082318.420146-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the per-CPU state dump logic from the for_each_possible_cpu
loop in scx_dump_state() into a new scx_dump_cpu() helper to improve
readability. No functional change.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c | 171 +++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 82 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..025bd8c6f429 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6256,6 +6256,94 @@ static void scx_dump_task(struct scx_sched *sch, struct seq_buf *s, struct scx_d
 	}
 }
 
+static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
+			 struct scx_dump_ctx *dctx, int cpu,
+			 bool dump_all_tasks)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+	struct task_struct *p;
+	struct seq_buf ns;
+	size_t avail, used;
+	char *buf;
+	bool idle;
+
+	rq_lock_irqsave(rq, &rf);
+
+	idle = list_empty(&rq->scx.runnable_list) &&
+		rq->curr->sched_class == &idle_sched_class;
+
+	if (idle && !SCX_HAS_OP(sch, dump_cpu))
+		goto next;
+
+	/*
+	 * We don't yet know whether ops.dump_cpu() will produce output
+	 * and we may want to skip the default CPU dump if it doesn't.
+	 * Use a nested seq_buf to generate the standard dump so that we
+	 * can decide whether to commit later.
+	 */
+	avail = seq_buf_get_buf(s, &buf);
+	seq_buf_init(&ns, buf, avail);
+
+	dump_newline(&ns);
+	dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+		  cpu, rq->scx.nr_running, rq->scx.flags,
+		  rq->scx.cpu_released, rq->scx.ops_qseq,
+		  rq->scx.kick_sync);
+	dump_line(&ns, "          curr=%s[%d] class=%ps",
+		  rq->curr->comm, rq->curr->pid,
+		  rq->curr->sched_class);
+	if (!cpumask_empty(rq->scx.cpus_to_kick))
+		dump_line(&ns, "  cpus_to_kick   : %*pb",
+			  cpumask_pr_args(rq->scx.cpus_to_kick));
+	if (!cpumask_empty(rq->scx.cpus_to_kick_if_idle))
+		dump_line(&ns, "  idle_to_kick   : %*pb",
+			  cpumask_pr_args(rq->scx.cpus_to_kick_if_idle));
+	if (!cpumask_empty(rq->scx.cpus_to_preempt))
+		dump_line(&ns, "  cpus_to_preempt: %*pb",
+			  cpumask_pr_args(rq->scx.cpus_to_preempt));
+	if (!cpumask_empty(rq->scx.cpus_to_wait))
+		dump_line(&ns, "  cpus_to_wait   : %*pb",
+			  cpumask_pr_args(rq->scx.cpus_to_wait));
+	if (!cpumask_empty(rq->scx.cpus_to_sync))
+		dump_line(&ns, "  cpus_to_sync   : %*pb",
+			  cpumask_pr_args(rq->scx.cpus_to_sync));
+
+	used = seq_buf_used(&ns);
+	if (SCX_HAS_OP(sch, dump_cpu)) {
+		ops_dump_init(&ns, "  ");
+		SCX_CALL_OP(sch, dump_cpu, rq, dctx, cpu, idle);
+		ops_dump_exit();
+	}
+
+	/*
+	 * If idle && nothing generated by ops.dump_cpu(), there's
+	 * nothing interesting. Skip.
+	 */
+	if (idle && used == seq_buf_used(&ns))
+		goto next;
+
+	/*
+	 * $s may already have overflowed when $ns was created. If so,
+	 * calling commit on it will trigger BUG.
+	 */
+	if (avail) {
+		seq_buf_commit(s, seq_buf_used(&ns));
+		if (seq_buf_has_overflowed(&ns))
+			seq_buf_set_overflow(s);
+	}
+
+	if (rq->curr->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
+		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+
+	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
+		if (dump_all_tasks || scx_task_on_sched(sch, p))
+			scx_dump_task(sch, s, dctx, rq, p, ' ');
+next:
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * Dump scheduler state. If @dump_all_tasks is true, dump all tasks regardless
  * of which scheduler they belong to. If false, only dump tasks owned by @sch.
@@ -6276,7 +6364,6 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	};
 	struct seq_buf s;
 	struct scx_event_stats events;
-	char *buf;
 	int cpu;
 
 	guard(raw_spinlock_irqsave)(&scx_dump_lock);
@@ -6316,87 +6403,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "----------");
 
 	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		struct rq_flags rf;
-		struct task_struct *p;
-		struct seq_buf ns;
-		size_t avail, used;
-		bool idle;
-
-		rq_lock_irqsave(rq, &rf);
-
-		idle = list_empty(&rq->scx.runnable_list) &&
-			rq->curr->sched_class == &idle_sched_class;
-
-		if (idle && !SCX_HAS_OP(sch, dump_cpu))
-			goto next;
-
-		/*
-		 * We don't yet know whether ops.dump_cpu() will produce output
-		 * and we may want to skip the default CPU dump if it doesn't.
-		 * Use a nested seq_buf to generate the standard dump so that we
-		 * can decide whether to commit later.
-		 */
-		avail = seq_buf_get_buf(&s, &buf);
-		seq_buf_init(&ns, buf, avail);
-
-		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
-			  cpu, rq->scx.nr_running, rq->scx.flags,
-			  rq->scx.cpu_released, rq->scx.ops_qseq,
-			  rq->scx.kick_sync);
-		dump_line(&ns, "          curr=%s[%d] class=%ps",
-			  rq->curr->comm, rq->curr->pid,
-			  rq->curr->sched_class);
-		if (!cpumask_empty(rq->scx.cpus_to_kick))
-			dump_line(&ns, "  cpus_to_kick   : %*pb",
-				  cpumask_pr_args(rq->scx.cpus_to_kick));
-		if (!cpumask_empty(rq->scx.cpus_to_kick_if_idle))
-			dump_line(&ns, "  idle_to_kick   : %*pb",
-				  cpumask_pr_args(rq->scx.cpus_to_kick_if_idle));
-		if (!cpumask_empty(rq->scx.cpus_to_preempt))
-			dump_line(&ns, "  cpus_to_preempt: %*pb",
-				  cpumask_pr_args(rq->scx.cpus_to_preempt));
-		if (!cpumask_empty(rq->scx.cpus_to_wait))
-			dump_line(&ns, "  cpus_to_wait   : %*pb",
-				  cpumask_pr_args(rq->scx.cpus_to_wait));
-		if (!cpumask_empty(rq->scx.cpus_to_sync))
-			dump_line(&ns, "  cpus_to_sync   : %*pb",
-				  cpumask_pr_args(rq->scx.cpus_to_sync));
-
-		used = seq_buf_used(&ns);
-		if (SCX_HAS_OP(sch, dump_cpu)) {
-			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(sch, dump_cpu, rq, &dctx, cpu, idle);
-			ops_dump_exit();
-		}
-
-		/*
-		 * If idle && nothing generated by ops.dump_cpu(), there's
-		 * nothing interesting. Skip.
-		 */
-		if (idle && used == seq_buf_used(&ns))
-			goto next;
-
-		/*
-		 * $s may already have overflowed when $ns was created. If so,
-		 * calling commit on it will trigger BUG.
-		 */
-		if (avail) {
-			seq_buf_commit(&s, seq_buf_used(&ns));
-			if (seq_buf_has_overflowed(&ns))
-				seq_buf_set_overflow(&s);
-		}
-
-		if (rq->curr->sched_class == &ext_sched_class &&
-		    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
-			scx_dump_task(sch, &s, &dctx, rq, rq->curr, '*');
-
-		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
-			if (dump_all_tasks || scx_task_on_sched(sch, p))
-				scx_dump_task(sch, &s, &dctx, rq, p, ' ');
-	next:
-		rq_unlock_irqrestore(rq, &rf);
+		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
 	}
 
 	dump_newline(&s);
-- 
2.54.0

