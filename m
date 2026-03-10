Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83E2D73B9;
	Tue, 10 Mar 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105418; cv=none; b=YM2u7R8UoPwj4HSxdx42wOan6VUdrXMYQYB85DPCFBE6meX3l1Xx4lxT/lmYmCs2TnPlGGiYM5s3C0tnIsuqadI3h4r2MHiEJXJUDWfqeMFDFjaC3VVFq90oAL2NblxVVeY8VAR9ljHRjPRKyOrPb+zNLFZIyUpyqnzhVTexizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105418; c=relaxed/simple;
	bh=F/J0eGBlAz1/FmxeRAayoV3e9jP84oUHX+8Qf59Ai58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzxhJ/spsru8PtDvAibN6IddfRbf/8nfgJKEyvuFgNBm25uPLJXP8KBp1sK27ekBJRRyH5TCvpQM1Vopq6w8Ni5BuoLZ60GPf0JHAztfcyk/sJrfriZeVHFwbZILdM0yb29U5ynEgmTa1DCpgfe3uY/vHUQBXWLhbGrBrJ19FlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyShQ2ZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyShQ2ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3971AC4CEF7;
	Tue, 10 Mar 2026 01:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105418;
	bh=F/J0eGBlAz1/FmxeRAayoV3e9jP84oUHX+8Qf59Ai58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyShQ2ZRLT+DFKitCLmXIReBaZM9qWD39tJnjzYa0oj9R8NpU82yJFIO8tQOBxU1O
	 2B1Mofl76iJ70D6arCi3tpkEGcZfoO4p3BG+ktFx6T4A1d22FYh40H3LM9NhDbW+Ox
	 x0dTrOsrisAa6qKrx9IrHQl6yiy+uGmgSh28vGotue6FafxzDw2BISXXm6fyfMdSWX
	 Cn+K2yXt89ou148Rh3YpLaa6ezlh2JUt5mTLu/sx6v+IrT88yyTpKtHxrOmMlIekLv
	 cF8fAqeeBX4ZTj4hhNZEUfI2RcRPoKLL6YyCA8K/9aO82Ng0lV3RagWXlJqGrud6vm
	 QjCqMf4qjrYOQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] sched_ext: Always bounce scx_disable() through irq_work
Date: Mon,  9 Mar 2026 15:16:51 -1000
Message-ID: <20260310011653.2993712-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
References: <20260310011653.2993712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_disable() directly called kthread_queue_work() which can acquire
worker->lock, pi_lock and rq->__lock. This made scx_disable() unsafe to
call while holding locks that conflict with this chain - in particular,
scx_claim_exit() calls scx_disable() for each descendant while holding
scx_sched_lock, which nests inside rq->__lock in scx_bypass().

The error path (scx_vexit()) was already bouncing through irq_work to
avoid this issue. Generalize the pattern to all scx_disable() calls by
always going through irq_work. irq_work_queue() is lockless and safe to
call from any context, and the actual kthread_queue_work() call happens
in the irq_work handler outside any locks.

Rename error_irq_work to disable_irq_work to reflect the broader usage.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 12 ++++++------
 kernel/sched/ext_internal.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d76a47b782a7..cf28a8f62ad0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4498,7 +4498,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_dispatch_q *dsq;
 	int cpu, node;
 
-	irq_work_sync(&sch->error_irq_work);
+	irq_work_sync(&sch->disable_irq_work);
 	kthread_destroy_worker(sch->helper);
 	timer_shutdown_sync(&sch->bypass_lb_timer);
 
@@ -5679,7 +5679,7 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	guard(preempt)();
 	if (scx_claim_exit(sch, kind))
-		kthread_queue_work(sch->helper, &sch->disable_work);
+		irq_work_queue(&sch->disable_irq_work);
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -6012,9 +6012,9 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		       trunc_marker, sizeof(trunc_marker));
 }
 
-static void scx_error_irq_workfn(struct irq_work *irq_work)
+static void scx_disable_irq_workfn(struct irq_work *irq_work)
 {
-	struct scx_sched *sch = container_of(irq_work, struct scx_sched, error_irq_work);
+	struct scx_sched *sch = container_of(irq_work, struct scx_sched, disable_irq_work);
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (ei->kind >= SCX_EXIT_ERROR)
@@ -6048,7 +6048,7 @@ static bool scx_vexit(struct scx_sched *sch,
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
 
-	irq_work_queue(&sch->error_irq_work);
+	irq_work_queue(&sch->disable_irq_work);
 	return true;
 }
 
@@ -6184,7 +6184,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
-	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
+	init_irq_work(&sch->disable_irq_work, scx_disable_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
 	timer_setup(&sch->bypass_lb_timer, scx_bypass_lb_timerfn, 0);
 	sch->ops = *ops;
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 3623de2c30a1..c78dadaadab8 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1042,7 +1042,7 @@ struct scx_sched {
 	struct kobject		kobj;
 
 	struct kthread_worker	*helper;
-	struct irq_work		error_irq_work;
+	struct irq_work		disable_irq_work;
 	struct kthread_work	disable_work;
 	struct timer_list	bypass_lb_timer;
 	struct rcu_work		rcu_work;
-- 
2.53.0

