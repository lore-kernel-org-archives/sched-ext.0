Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06493428490;
	Fri,  6 Mar 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823992; cv=none; b=uVle747Mnfl9rpNMxugAQcv9efm3qeKxJ6lwTCTiJsSxQozutwemOtzjCULlF3GTBbD3KRQ8449CMgTk9LYOXB/rreU4aiBwBRpRvkpEMbg2XcJnC+QV+846sMfnZjS5vFMOyCJrvfLGe+snXQGFJil5NZXp9ioS5HbwpPDeLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823992; c=relaxed/simple;
	bh=08TB+HqDVyHPls1Y/B4CtPEae30fGWs6ckHGoC5+SBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7EUO5yVGRgn14D81Sq/2Yi+4cb0jFPKSXHZvzN1ErEqNyDGEXLBSOqlZ2keupIRYNLlanO0OcbCW8wdLS6y5KvaJC/VH93Tb9Kh1vdKR/gTtdzcpmRz+2cBBkYneMIf9y2aYfrp2GRNY3bxebtsUiH3xwLafZsP/mBqHF116vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFj3vU5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFj3vU5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0421C2BCAF;
	Fri,  6 Mar 2026 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823991;
	bh=08TB+HqDVyHPls1Y/B4CtPEae30fGWs6ckHGoC5+SBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFj3vU5bpeXO5sU7wsun4Q5sKalNhihUbeYT5WIaGI5RP46ORhf5KvchaPHyLHzGz
	 B/VbSn9D+CO4vLHG79rRRK4C7e6RZbim3l2qFGUfaU1UghRoCD01WRURCnTglKLBEJ
	 HssgcEw3paU8jZbMcX25/Dtw8KUx0OwZ98dAaTK74LFFBJM8de+JLA8sc7MK6u1aV/
	 DU6A/G/oLBVvmWQj6kgNxOnfvbv3mFuGxUXGzSOdBTVVMAX0Jd9vhWsIIX0ksb1pun
	 Yo0xahkd2SqnAO8iTYctFg4sSBkIN5Cvv/9fCFnIpJr4AZc8WdeLyYAgYQvsIYy+WO
	 +Qxw9vBCxBQ8w==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/15] sched_ext: Wrap deferred_reenq_local_node into a struct
Date: Fri,  6 Mar 2026 09:06:15 -1000
Message-ID: <20260306190623.1076074-8-tj@kernel.org>
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

Wrap the deferred_reenq_local_node list_head into struct
scx_deferred_reenq_local. More fields will be added and this allows using a
shorthand pointer to access them.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 22 +++++++++++++---------
 kernel/sched/ext_internal.h |  6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ffccaf04e34d..80d1e6ccc326 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3648,15 +3648,19 @@ static void process_deferred_reenq_locals(struct rq *rq)
 		struct scx_sched *sch;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
-			struct scx_sched_pcpu *sch_pcpu =
+			struct scx_deferred_reenq_local *drl =
 				list_first_entry_or_null(&rq->scx.deferred_reenq_locals,
-							 struct scx_sched_pcpu,
-							 deferred_reenq_local_node);
-			if (!sch_pcpu)
+							 struct scx_deferred_reenq_local,
+							 node);
+			struct scx_sched_pcpu *sch_pcpu;
+
+			if (!drl)
 				return;
 
+			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
+						deferred_reenq_local);
 			sch = sch_pcpu->sch;
-			list_del_init(&sch_pcpu->deferred_reenq_local_node);
+			list_del_init(&drl->node);
 		}
 
 		reenq_local(sch, rq);
@@ -4200,7 +4204,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
-		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local_node));
+		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
 	}
 
 	free_percpu(sch->pcpu);
@@ -5813,7 +5817,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 		pcpu->sch = sch;
-		INIT_LIST_HEAD(&pcpu->deferred_reenq_local_node);
+		INIT_LIST_HEAD(&pcpu->deferred_reenq_local.node);
 	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
@@ -8391,8 +8395,8 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
 	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 		struct scx_sched_pcpu *pcpu = this_cpu_ptr(sch->pcpu);
 
-		if (list_empty(&pcpu->deferred_reenq_local_node))
-			list_move_tail(&pcpu->deferred_reenq_local_node,
+		if (list_empty(&pcpu->deferred_reenq_local.node))
+			list_move_tail(&pcpu->deferred_reenq_local.node,
 				       &rq->scx.deferred_reenq_locals);
 	}
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 80d40a9c5ad9..1a8d61097cab 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -954,6 +954,10 @@ struct scx_dsp_ctx {
 	struct scx_dsp_buf_ent	buf[];
 };
 
+struct scx_deferred_reenq_local {
+	struct list_head	node;
+};
+
 struct scx_sched_pcpu {
 	struct scx_sched	*sch;
 	u64			flags;	/* protected by rq lock */
@@ -965,7 +969,7 @@ struct scx_sched_pcpu {
 	 */
 	struct scx_event_stats	event_stats;
 
-	struct list_head	deferred_reenq_local_node;
+	struct scx_deferred_reenq_local deferred_reenq_local;
 	struct scx_dispatch_q	bypass_dsq;
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
-- 
2.53.0

