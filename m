Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E22C3252;
	Wed,  8 Apr 2026 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617902; cv=none; b=cHDNBjkVbSEdsdeAMUMB27nUAOe+STXKUo4AlTfzwLJvHj5iR5vqgyHv1a2t/TbX3Uq1KWejsX+nvFrGoiU+ZZ/GGNrJUD3shVSVdPVDQH5oMO6rKn2faarrUAk/TH1LUzAKOJOFskpeIruMbW2LJ5md85TmG+zla3NMIspCPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617902; c=relaxed/simple;
	bh=yofZjsFxaLQ+c9RGnTnqBmRLsHmDsmJmd6NyCCvFuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmjwLAZQE5Wn022wtAt2jmvrNu6rCCHeJN1NEWiO29/ZHCWfkjtZRrskUkKsUOO6QoR/A0gi1/iRBehaBZme9KkMKNB3cJRr4cq2zup1JJEmXKVZW+LxvL9W0liAYRw6maC02v/ForE1sBVER+q/sqDZ381oGiA8Mhd+Grh8PO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=krJ/veDg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="krJ/veDg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=T4VtYXI2IFQgDkkQ+hIpBs44BuCKsZd86Opn0mAnZr4=; b=krJ/veDga1acgKz9Sf9H62fMVf
	7avWxgACZdb4B0LQtouslWoO5GO2nBMU8N7r3EDN/ivAy46l5ynx0gDCligspVwvGb8jQLZIq4R2X
	bvcUbmK2gbAVVT7B39ygbfJWcZAGo88AUcPA34nepIUswRYx5FxZqjnCffjfm4qdg4UH/zVqrIlDE
	rgjyzmh1sFaakQwMzgcvgIMBa0sx4hrshsb+3X4+Y9djebyWl31EuSQeLuUYHTz/qDaa0t5/uddnh
	uto3qwdf0hFBkQp9JYyd7yUOymh/TnHppSLhKLF751dZxXHU6zRrU2oaiBCWpDH1XLwgLSjq6loHY
	P0A5xO1g==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAJKC-00DIXy-9X; Wed, 08 Apr 2026 05:11:29 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Extract scx_dump_cpu() from scx_dump_state()
Date: Wed,  8 Apr 2026 12:11:12 +0900
Message-ID: <20260408031113.76005-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408031113.76005-1-changwoo@igalia.com>
References: <20260408031113.76005-1-changwoo@igalia.com>
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
 kernel/sched/ext.c | 173 +++++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 83 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b757b853b42b..8f7d5c1556be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6190,6 +6190,95 @@ static void scx_dump_task(struct scx_sched *sch,
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
+		SCX_CALL_OP(sch, SCX_KF_REST, dump_cpu, NULL,
+			    dctx, cpu, idle);
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
+		scx_dump_task(sch, s, dctx, rq->curr, '*');
+
+	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
+		if (dump_all_tasks || scx_task_on_sched(sch, p))
+			scx_dump_task(sch, s, dctx, p, ' ');
+next:
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * Dump scheduler state. If @dump_all_tasks is true, dump all tasks regardless
  * of which scheduler they belong to. If false, only dump tasks owned by @sch.
@@ -6210,7 +6299,6 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	};
 	struct seq_buf s;
 	struct scx_event_stats events;
-	char *buf;
 	int cpu;
 
 	guard(raw_spinlock_irqsave)(&scx_dump_lock);
@@ -6250,88 +6338,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
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
-			SCX_CALL_OP(sch, SCX_KF_REST, dump_cpu, NULL,
-				    &dctx, cpu, idle);
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
-			scx_dump_task(sch, &s, &dctx, rq->curr, '*');
-
-		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
-			if (dump_all_tasks || scx_task_on_sched(sch, p))
-				scx_dump_task(sch, &s, &dctx, p, ' ');
-	next:
-		rq_unlock_irqrestore(rq, &rf);
+		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
 	}
 
 	dump_newline(&s);
-- 
2.53.0

