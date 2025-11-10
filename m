Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA402F617D;
	Mon, 10 Nov 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808201; cv=none; b=YsuRdOIwxEtbKVzILjJcUfyhkdw5vkI9XlpSz1vsZasVziLzFlgusqfIMFrygPhv96Gccf8Rb7cVP4tTm/EnSP5p6BfkUNoFC9QRH+Cvnn4/3uc2XFy3EDuDpFb5Ps+JS1fPVL1nEuJW044bsV7po+OnnKznoZM1kxS/qKgAhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808201; c=relaxed/simple;
	bh=Ltfe/ZNWtmExrhfPQA6/hrNb1qAM6aGB+l66utUgQLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9zY1SovlpO4FfQD/B+Cr1WzXzJ4Mo1IyKQUTMfYwLn6RJLdFiAmLPSW9jAT2kXXlVMAHwJiSOHwQYmjyXT1kkuhW+5smJJIIguoXpq3zUp2uwlDr1euafrVcTtMeMj5WgaXCZioKXGQmFuZ3ZMSLgqU7tfu0at1V+kbDHGGvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiwKkLlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiwKkLlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F293C4CEFB;
	Mon, 10 Nov 2025 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808201;
	bh=Ltfe/ZNWtmExrhfPQA6/hrNb1qAM6aGB+l66utUgQLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiwKkLlzMEBdyZL/ZgeQSwHnAkV6wBOMBNjVDZwZKvB6pQ8EodHG6YNhvUDw23xmX
	 u++9614rXdL42Iqe6gcamgl66Y0802OolzBHW9h6Aeg5tF/1mpqN6/lbT1VgLrjP0S
	 YrYWlDvW3s17iE/Xm9WYlYhQyI2Dtqi39QOC1STky5i560G2nrqE8FGECMuN2Twn5M
	 qZPWQt6zWhJ40Alc3M0Gt4rZ/tOrrFA4qyoY2+hR91OZgZ8cqOKhMt06epatfpdfex
	 euHyJl12nNma3Gfky84n9ZCJFwHkB75w/HAjkxIrlgXEuBK1v5ynGJjB0rexw+PK3d
	 oCmAnFJ/SWgSQ==
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
Subject: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node global DSQs in bypass mode
Date: Mon, 10 Nov 2025 10:56:26 -1000
Message-ID: <20251110205636.405592-5-tj@kernel.org>
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

Bypass mode routes tasks through fallback dispatch queues. Originally a single
global DSQ, b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node")
changed this to per-node DSQs to resolve NUMA-related livelocks.

Dan Schatzberg found per-node DSQs can still livelock when many threads are
pinned to different small CPU subsets: each CPU must scan many incompatible
tasks to find runnable ones, causing severe contention with high CPU counts.

Switch to per-CPU bypass DSQs. Each task queues on its current CPU. Default
idle CPU selection and direct dispatch handle most cases well.

This introduces a failure mode when tasks concentrate on one CPU in
over-saturated systems. If the BPF scheduler severely skews placement before
triggering bypass, that CPU's queue may be too long to drain, causing RCU
stalls. A load balancer in a future patch will address this. The bypass DSQ is
separate from local DSQ to enable load balancing: local DSQs use rq locks,
preventing efficient scanning and transfer across CPUs, especially problematic
when systems are already contended.

v2: Clarified why bypass DSQ is separate from local DSQ (Andrea Righi).

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 16 +++++++++++++---
 kernel/sched/sched.h      |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 60285c3d07cf..3d3216ff9188 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
 	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
 	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
 	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
+	SCX_DSQ_BYPASS		= SCX_DSQ_FLAG_BUILTIN | 3,
 	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
 	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
 };
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b18864655d3a..4e128b139e7c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	if (scx_rq_bypassing(rq)) {
 		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
-		goto global;
+		goto bypass;
 	}
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 global:
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
+bypass:
+	dsq = &task_rq(p)->scx.bypass_dsq;
+	goto enqueue;
 
 enqueue:
 	/*
@@ -2154,8 +2157,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (consume_global_dsq(sch, rq))
 		goto has_tasks;
 
-	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
-	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
+	if (scx_rq_bypassing(rq)) {
+		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
+			goto has_tasks;
+		else
+			goto no_tasks;
+	}
+
+	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -5367,6 +5376,7 @@ void __init init_sched_ext_class(void)
 		int  n = cpu_to_node(cpu);
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 27aae2a298f8..5991133a4849 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -808,6 +808,7 @@ struct scx_rq {
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
+	struct scx_dispatch_q	bypass_dsq;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.51.2

