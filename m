Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77A374721;
	Sat, 17 Oct 2026 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215444; cv=none; b=iAm/lKEyBt3tX24KI2dZE/nG8CTqrmDcDBQHfDajbvEXRx/yBuCdmrSLp8G5UZ+6C0BUAptc1LGWetxjnz/nzitRZl1AR+YUBx+DzaY2/wFn+zayF/zAPwNR+iKvSJbhd6IGRQG4eeuPY9fMgjvvhRft4DM5DqlId8wM8UEIcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215444; c=relaxed/simple;
	bh=n4D3RvcdaMbSQQ2VdCMb26FC+OOXVQvdwviaeirI22w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC/lC3nmNkbOELZLLk8exrjIJ9MJoGajSUCj6vUAsOmeI+cT7tRGPhJ4LcXAsK1YKt/PYMr1EhKDpM2LwvooJn9II8Hiz4K1b7oU/w3g6VyLVYND+ee9zexi9V92W7xPuYWUZwzjUdowTC9XjDQ27A11pVvVw6TmEhJtiQVJrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvFOotd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvFOotd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECE1F000C4;
	Sat, 17 Oct 2026 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792215440;
	bh=MVUVgN85an6FVSCKgrHJ08YhHAP2T6TxH5nCUcFTMU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvFOotd8SOWRKh9k7QO9XkgRPVxSXs9d/J5qS1ykzJ/dpw0sMxGsjJkLioWANvaoV
	 76d40lfb/2E/6hKzJAqqemUelx6sQAphrUuGeOKxHYiHmmA3YImpwvWJRK1SpxVpVb
	 Klg2+iOay6ZaMGaiRdzjVu7AdlW5fFDa2xRcsLHbbYjuEe5NkO+q3XDHoNjopUZkcG
	 PPXMpA1Mn5IdShTQ9QzYOR2faspht2TqFfRcTKtGJHYJahUnBrRBcGrLA3aUBq38Rg
	 V4CkHA4KMJ+peCbCdxLiLnjMNSeATdv7HrGeBJ4FyM9zzzCmQo3ZKN8zcxhwyTjVqK
	 zljrPHEvuSExQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
Date: Fri, 16 Oct 2026 19:37:17 -1000
Message-ID: <20261017053717.3162619-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017053717.3162619-1-tj@kernel.org>
References: <20261017053717.3162619-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bypassing sub-scheduler's tasks are run by its nearest ancestor that isn't
bypassing. The ancestor puts them on the local DSQ under its own caps.
Whether such a task may stay on the cpu and whether a cap revoke reenqueues
it are still checked against the caps of the task's own scheduler.

The bypass load balancer moves tasks between cpus without looking at caps,
so a bypassed task can run on a cpu where its own scheduler holds none. Once
its slice runs out, it can't stay. It goes to the ancestor's bypass DSQ
without a kick, and the cpu can go idle with it queued until something else
reschedules the cpu.

Make both checks against the caps of the scheduler running the task. When
bypass lifts, the running task keeps its slice without a cap check, so evict
it then if it can't stay on the cpu.

Fixes: 75a8c8202c91 ("sched_ext: Add reject DSQ for cap-rejected dispatches")
Fixes: 46a85ae6fe5b ("sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 21 ++++++++++++---------
 kernel/sched/ext/internal.h | 17 +++++++++++++++++
 kernel/sched/ext/sub.c      |  7 +++++--
 kernel/sched/ext/sub.h      |  6 +++++-
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d6689bf8e769..6b472506944e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -322,7 +322,6 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 
 static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
 {
-#ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * If @sch is a sub-sched which is bypassing, its tasks should go into
 	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
@@ -334,11 +333,7 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 c
 	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
 	 * all tasks are transferred to the right DSQs.
 	 */
-	while (scx_parent(sch) && scx_bypassing(sch, cpu))
-		sch = scx_parent(sch);
-#endif	/* CONFIG_EXT_SUB_SCHED */
-
-	return scx_bypass_dsq(sch, cpu);
+	return scx_bypass_dsq(scx_exec_sched(sch, cpu), cpu);
 }
 
 /**
@@ -6322,11 +6317,19 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 		 * Bypass trumps protection. Cycling the queued tasks below
 		 * clears theirs. The current task isn't on the runnable list,
 		 * so strip its protection here.
+		 *
+		 * When bypass lifts, the current task keeps running on its
+		 * slice without a cap check. Evict it if it can't stay on the
+		 * cpu.
 		 */
 		p = rq->curr;
-		if (bypass && p->sched_class == &ext_sched_class &&
-		    scx_is_descendant(scx_task_sched(p), sch))
-			scx_task_slice_ended(rq, p);
+		if (p->sched_class == &ext_sched_class &&
+		    scx_is_descendant(scx_task_sched(p), sch)) {
+			if (bypass)
+				scx_task_slice_ended(rq, p);
+			else if (!scx_task_can_stay_on_cpu(rq, p))
+				scx_set_task_slice(p, 0);
+		}
 
 		/*
 		 * The use of list_for_each_entry_safe_reverse() is required
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 352547aedbb7..03f03204d158 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2539,4 +2539,21 @@ static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL;
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+/**
+ * scx_exec_sched - Find the sched running @sch's tasks on @cpu
+ * @sch: sched owning the tasks
+ * @cpu: cpu of interest
+ *
+ * A bypassing sched's tasks are run by its nearest ancestor that isn't
+ * bypassing. Return @sch if it isn't bypassing on @cpu, otherwise that
+ * ancestor, or the root if every ancestor is bypassing. Hold @cpu's rq lock for
+ * a stable answer.
+ */
+static inline struct scx_sched *scx_exec_sched(struct scx_sched *sch, s32 cpu)
+{
+	while (scx_parent(sch) && scx_bypassing(sch, cpu))
+		sch = scx_parent(sch);
+	return sch;
+}
+
 #endif /* _KERNEL_SCHED_EXT_INTERNAL_H */
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index fee75fcdb59d..90430493bb72 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -755,18 +755,21 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 /* @p lost the caps needed to stay on @rq's local DSQ? Record reason if so. */
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
 {
+	s32 cpu = cpu_of(rq);
 	u64 missing;
 
 	/* migration-disabled tasks and the rescuee are admitted capless */
 	if (is_migration_disabled(p) || p == scx_rescuee(rq))
 		return false;
 
-	missing = scx_missing_caps(scx_task_sched(p), cpu_of(rq), scx_caps_for_task(p));
+	/* check caps against the sched running a bypassed task */
+	missing = scx_missing_caps(scx_exec_sched(scx_task_sched(p), cpu), cpu,
+				   scx_caps_for_task(p));
 	if (likely(!missing))
 		return false;
 
 	p->scx.reenq_reason_caps = missing;
-	p->scx.reenq_reason_cid = __scx_cpu_to_cid(cpu_of(rq));
+	p->scx.reenq_reason_cid = __scx_cpu_to_cid(cpu);
 	return true;
 }
 
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index f7bcdfda8dd8..0ac7b8e59205 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -199,6 +199,8 @@ static inline u64 scx_caps_implied(u64 cap)
 /* may @p keep running on @rq's cpu? requires baseline cpu access */
 static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p)
 {
+	s32 cpu = cpu_of(rq);
+
 	if (!scx_has_subs())
 		return true;
 
@@ -206,7 +208,9 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 	if (unlikely(is_migration_disabled(p)))
 		return true;
 
-	return likely(!scx_missing_caps(scx_task_sched(p), cpu_of(rq), SCX_CAP_BASE));
+	/* check caps against the sched running a bypassed task */
+	return likely(!scx_missing_caps(scx_exec_sched(scx_task_sched(p), cpu), cpu,
+					SCX_CAP_BASE));
 }
 
 /* the task admitted for rescue on @rq, NULL if none */
-- 
2.56.0

