Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B72217F55;
	Sun,  9 Nov 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713078; cv=none; b=BwA7xA3elxcQzawi17GIyvVjSOyv+ING8j8kAvmbapKX4gEq1SWyBICqRwLEee0ccukWC0hy3AeLoJ0jQv9uD/mRgrOLuVIBXeUjjiBbDGvHWMCKEyTS7O+SCCR949Csy2w8dSBHDETjTWmcydOcC+x9Q624Zq9h4du3xGSKxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713078; c=relaxed/simple;
	bh=3CS1lrhGnw8hi3KbFklamM28QX+/cuvddqsJ6YRK0lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY91RPqYEMI4iVWhQdckW1ZoO3seaF5EVFlSVoOoSEE22dJRrT4wiN7WCHBJJxfd0StqMjgaRqfF5SOFS8jNbC8H5qPhTJ08JCVc3YSo+ftYaGNRCIdYQ9MNd1dNum45ymXuUdhL/ODucKr/ywvFo4PN7LFd4ep/bPJ1PbIIfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmHW1upr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmHW1upr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D7C4CEF8;
	Sun,  9 Nov 2025 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713078;
	bh=3CS1lrhGnw8hi3KbFklamM28QX+/cuvddqsJ6YRK0lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmHW1upr9YZ3yAkIZJWrEoAhIluCebRq0AyWaKG5Pu4DqfUl/R3+N4aBdMrrcARQw
	 wDM4q/Vnr5+Bvcsi7TEsf8M/PP+VDNIuQzF4Z9i/IADuGZKoHs37pPj8gjJd6MTQOT
	 +s4c3A8zfGZ26bRsr9T6bUxlhNiZOU+Kksf5UUJ6i13VY4r4nGoX4jX5p53Ue1OR5y
	 QAN9HygUib9vHQFE74hqgXuc5NKx6S0pTQ9JRXdCMpHw/ECKCwpHFVK4Y5Un/q67b1
	 RNKB2rrGDupzX3gnYQqbxd4RCc28nSlTT7cB9cnjaBstGwChA76+HP75hleMw+1DkC
	 dc+PQCvlNTH/A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node global DSQs in bypass mode
Date: Sun,  9 Nov 2025 08:31:03 -1000
Message-ID: <20251109183112.2412147-5-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bypass mode is activated, tasks are routed through a fallback dispatch
queue instead of the BPF scheduler. Originally, bypass mode used a single
global DSQ, but this didn't scale well on NUMA machines and could lead to
livelocks. In b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"),
this was changed to use per-node global DSQs, which resolved the
cross-node-related livelocks.

However, Dan Schatzberg found that per-node global DSQ can also livelock in a
different scenario: On a NUMA node with many CPUs and many threads pinned to
different small subsets of CPUs, each CPU often has to scan through many tasks
it cannot run to find the one task it can run. With a high number of CPUs,
this scanning overhead can easily cause livelocks.

Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
on the CPU that it's currently on. Because the default idle CPU selection
policy and direct dispatch are both active during bypass, this works well in
most cases including the above.

However, this does have a failure mode in highly over-saturated systems where
tasks are concentrated on a single CPU. If the BPF scheduler places most tasks
on one CPU and then triggers bypass mode, bypass mode will keep those tasks on
that one CPU, which can lead to failures such as RCU stalls as the queue may be
too long for that CPU to drain in a reasonable time. This will be addressed
with a load balancer in a future patch. The bypass DSQ is kept separate from
the local DSQ to allow the load balancer to move tasks between bypass DSQs.

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 16 +++++++++++++---
 kernel/sched/sched.h      |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9f5b0f2be310..e1502faf6241 100644
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
index a29bfadde89d..4b8b91494947 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1301,7 +1301,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	if (scx_rq_bypassing(rq)) {
 		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
-		goto global;
+		goto bypass;
 	}
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -1359,6 +1359,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 global:
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
+bypass:
+	dsq = &task_rq(p)->scx.bypass_dsq;
+	goto enqueue;
 
 enqueue:
 	/*
@@ -2157,8 +2160,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
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
@@ -5370,6 +5379,7 @@ void __init init_sched_ext_class(void)
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
2.51.1

