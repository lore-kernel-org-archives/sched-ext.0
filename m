Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C007326D62;
	Tue, 11 Nov 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888701; cv=none; b=b4ucC3X01ypunuy3pUyRkur86N1gyyBOyqa9/AM1m4+hPHO45gYl5Ya+lmRwv4z6dp+AC6Yp95hTxllEQwr9Tj4rNGHyAJ0+F//cw2+CilbvokBIFeh3efva/r1JV4MFwfmatpH08J5s1POSKrx4yGEZB/yi6kfxI7thNHTq/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888701; c=relaxed/simple;
	bh=NTnhOVNZd+o9seNA7S1c7Bn5RIXPmwTS4O2S2QvS9ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icV++WIue1cK8cTAqHUwSrtZjq3JJMUvzvFiGTk17iHBnFJ7o9Aw3QJdprnyY51+Ca3JvZzXX3u/H3PkHZ1OjBRTp1vxCCclgT2BSRwdupdVJw4sBzWHjZvpQUrtzaBL5U+XnIJmtQlzoVO2ulUZsVmy9yRMhzBEbR73F7BOLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTnrBbIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTnrBbIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04B0C4CEF7;
	Tue, 11 Nov 2025 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888700;
	bh=NTnhOVNZd+o9seNA7S1c7Bn5RIXPmwTS4O2S2QvS9ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTnrBbIWvZfmbq/vOemhR2oQYVbFSA/2YDo/76fMulGX/JX0bTQaDXr0qfVAPhOBD
	 zGYd9WQCMUaxsi9n3t356H+6od0SRBa14/lXlRiLmySrcGYlIgpfne+L/HhA1hcfb4
	 SSEcNu5E1+g3E6DYHUWzvWzUR0g/1rnmPrGo7v96s9uvqTJvV0pJzNgWuG5qLUJIQo
	 QkrnME051Q9Fy3UjwznffRDs0PSO8pEh6gJxVyIwl1UEFhEG8iHQWeZBKnRci6y462
	 qF56xOpwpA8AyMNvoYC866nWp26HEv4egnzz2hV1lVwRV1LHbxKqGhbBLBBhVHiluV
	 DnDZ26XGy+NZg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 03/13] sched_ext: Use per-CPU DSQs instead of per-node global DSQs in bypass mode
Date: Tue, 11 Nov 2025 09:18:06 -1000
Message-ID: <20251111191816.862797-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
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
Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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
index 43083602c15e..747391a3f6e3 100644
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
@@ -5371,6 +5380,7 @@ void __init init_sched_ext_class(void)
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

