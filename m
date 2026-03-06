Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB942EED4;
	Fri,  6 Mar 2026 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823994; cv=none; b=gw+IRvGrDDJmNuQ3o8hOG4AsXblbYh2FY7lmiBgSG78yyrDsuSPpcpjvwDJHnTgVdPVmeI844W0swCs8HLO6bQEIGGkjkeQmblvc2wNiAphgj/1R5Ti+DtNKGqxZBlUrNe/xFRhwMStcuTlk5n8DjDlrdTJ/+A0frh4c8HEhL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823994; c=relaxed/simple;
	bh=+Ortr6U7vhxjmKMMQA/8wQ5q4QL637yFxpWWe3954Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB0WOOwHhzr6xkgf53AZ94+pNC9/RbyNX3MlSF4AmHyaRzqbj2MNpoK0hV3IUPYzqHnUFqk73vP8JdmrJFmSTdKQ75IBRK/CYKGbXYx0oJDJKbowBO0Rmu3+DBjHxLR2aDqQ9m4mPp4+0/Afk/ZVSqZi5PHWGR9Rl8rznLkxnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5rzxR6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5rzxR6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3965C4CEF7;
	Fri,  6 Mar 2026 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823994;
	bh=+Ortr6U7vhxjmKMMQA/8wQ5q4QL637yFxpWWe3954Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5rzxR6ugWmJ2SQmndrs6FDia1c/5l7NTE9a8fv/bBsjHEnHj+mP1MWRmdsp+pJvJ
	 KSMpOa3ml6sMOaPlkq96CcDynZRvIpVcS3Zg+x20P83yQ5bhjmsEcwosqGHpHbp7kI
	 p8ajXYN5IvWsrAfyptIVtz6hYWuQADRW9RMzWwFTMRo7lmgWX0bbRk6CXYCEoN9GoS
	 I6o//JKxk2ukkV3H+QWX+JzrGaqSTxxcXxAPVczjmrk8w51gWLONE7yCI+te1d8FGm
	 iJ4prn//iSHrkiV4SLWFyrqDe/dM3SA88nvGJJFxVTtIRDp8D4gTxY2/C+NGOCzSbs
	 QXmUVbx75Kpzg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/15] sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()
Date: Fri,  6 Mar 2026 09:06:17 -1000
Message-ID: <20260306190623.1076074-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add infrastructure to pass flags through the deferred reenqueue path.
reenq_local() now takes a reenq_flags parameter, and scx_sched_pcpu gains a
deferred_reenq_local_flags field to accumulate flags from multiple
scx_bpf_dsq_reenq() calls before processing. No flags are defined yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 33 ++++++++++++++++++++++++++++-----
 kernel/sched/ext_internal.h | 10 ++++++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b02143b10f0f..c9b0e94d59bd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1080,7 +1080,8 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
-static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq)
+static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+			       u64 reenq_flags)
 {
 	/*
 	 * Allowing reenqueues doesn't make sense while bypassing. This also
@@ -1097,6 +1098,7 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
 			if (list_empty(&drl->node))
 				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
+			drl->flags |= reenq_flags;
 		}
 
 		schedule_deferred(rq);
@@ -3618,7 +3620,14 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
-static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
+static bool task_should_reenq(struct task_struct *p, u64 reenq_flags)
+{
+	if (reenq_flags & SCX_REENQ_ANY)
+		return true;
+	return false;
+}
+
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 {
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
@@ -3652,6 +3661,9 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
 		if (!scx_is_descendant(task_sch, sch))
 			continue;
 
+		if (!task_should_reenq(p, reenq_flags))
+			continue;
+
 		dispatch_dequeue(rq, p);
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
@@ -3671,6 +3683,7 @@ static void process_deferred_reenq_locals(struct rq *rq)
 
 	while (true) {
 		struct scx_sched *sch;
+		u64 reenq_flags = 0;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_local *drl =
@@ -3685,10 +3698,11 @@ static void process_deferred_reenq_locals(struct rq *rq)
 			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
 						deferred_reenq_local);
 			sch = sch_pcpu->sch;
+			swap(drl->flags, reenq_flags);
 			list_del_init(&drl->node);
 		}
 
-		reenq_local(sch, rq);
+		reenq_local(sch, rq, reenq_flags);
 	}
 }
 
@@ -7817,7 +7831,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
-	return reenq_local(sch, rq);
+	return reenq_local(sch, rq, 0);
 }
 
 __bpf_kfunc_end_defs();
@@ -8255,8 +8269,17 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 	if (unlikely(!sch))
 		return;
 
+	if (unlikely(reenq_flags & ~__SCX_REENQ_USER_MASK)) {
+		scx_error(sch, "invalid SCX_REENQ flags 0x%llx", reenq_flags);
+		return;
+	}
+
+	/* not specifying any filter bits is the same as %SCX_REENQ_ANY */
+	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
+		reenq_flags |= SCX_REENQ_ANY;
+
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id());
-	schedule_dsq_reenq(sch, dsq);
+	schedule_dsq_reenq(sch, dsq, reenq_flags);
 }
 
 /**
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 1a8d61097cab..d9eda2e8701c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -956,6 +956,7 @@ struct scx_dsp_ctx {
 
 struct scx_deferred_reenq_local {
 	struct list_head	node;
+	u64			flags;
 };
 
 struct scx_sched_pcpu {
@@ -1128,6 +1129,15 @@ enum scx_deq_flags {
 	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
 };
 
+enum scx_reenq_flags {
+	/* low 16bits determine which tasks should be reenqueued */
+	SCX_REENQ_ANY		= 1LLU << 0,	/* all tasks */
+
+	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
+
+	__SCX_REENQ_USER_MASK	= SCX_REENQ_ANY,
+};
+
 enum scx_pick_idle_cpu_flags {
 	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
 	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
-- 
2.53.0

