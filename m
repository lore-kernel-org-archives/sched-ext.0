Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C142432BF2;
	Tue, 14 Jul 2026 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070564; cv=none; b=mt5KP75e/e53vzGDOPPyXbnIYzoyvnAhsgfsWBebL8E7zR1F8CaTZOBMu862u0/BT1QG0i6MJH0wJcNSJSDd3xo37S4P4EOUZgdG42OmeIKDBseQXef5ewBK+k6XYOmKHpy7gLC1RnVh7kCW/VtspfJnL4F6kwnH5ZzoJ7f3taQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070564; c=relaxed/simple;
	bh=AinPRch1s6wSU+B4poHiDNO1buWe0vDixm86Iclwt5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWxzqckP3+q4pRVerqpRHEsDjRqhTNQOx1Ry9NcokWl9fafCZOnXcJ9kyZ1GNEaMeO7P8ESTCcsqpwPEIC5m7J6mJq066HP4m0se8NMy+BF712sbz9ntu/Q1KD+W/Tb7Vitc0PT+aKUkBU3vQ/6B9nISrxCkD/Qx4dxySUd+lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHrU3J7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHrU3J7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494B51F000E9;
	Tue, 14 Jul 2026 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070559;
	bh=8/qloYRphb4DJ+GSDdndAKC1FBBzMea379jAtLUMK1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHrU3J7TP+dGtAwcVDKOdbcsKu2hd6KpYo6jFRvKxpxnaI7k1x+vGZuXA69Nb/vS2
	 4agH04LpAZTMyczYQEtF7T+wp6nrZdeJEuBz0TKIgVEROckCyfkda70l4kPGwJQ85Z
	 oQmbiqCkxiVPxgCUor1RzhkpsFQWLh1oArpRCg4sKKXAMIHc5X7v5HKrkvO7wLRrFt
	 6lbMgcndxd6pwBi4gKwvybOvV+o4POqlWDgTvlr1jsWVaCOSWeHtpIl/xMhjQrUkTu
	 9cEQkE+Q061FcHmU4TyWTooFcCOtWIZC5QSXoF6K1ruziZTvHDhMyN+m8Ry7Xu3Jam
	 hFv1YskOXydpQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: Remove queued ecaps syncs directly on sched teardown
Date: Tue, 14 Jul 2026 13:09:14 -1000
Message-ID: <20260714230917.84158-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714230917.84158-1-tj@kernel.org>
References: <20260714230917.84158-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_discard_ecaps_to_sync() waited for balance_one() to consume a dying
sched's queued ecaps sync, polling with resched_cpu() + msleep(). The wait
is unbounded - the ext dl_server forces picks through sustained fair or RT
load only while ext tasks are queued, so an ext-idle cpu monopolized by a
higher class can stall the teardown indefinitely.

Remove the node directly instead: take all queued nodes, drop the dying
sched's and resplice the rest. Consumption runs under the rq lock and batch
nodes read as on-list throughout, so the producer-side dedup stays correct.

A node that an in-flight scx_process_sync_ecaps() batch holds across a
dispatch-induced rq unlock still needs a wait, but one bounded by that batch
completing rather than by a future balance.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |  2 +-
 kernel/sched/ext/sub.c | 67 ++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f8f8597b6f78..428f2bfb2cda 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4877,7 +4877,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		 */
 		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
 
-		/* retire the queued ecaps syncs so the pcpu can be freed */
+		/* remove the queued ecaps sync so the pcpu can be freed */
 		scx_discard_ecaps_to_sync(cpu, pcpu);
 
 		/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 68ab3675337f..198063a78a3a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -13,7 +13,6 @@
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
  */
-#include <linux/delay.h>
 #include <linux/rhashtable.h>
 #include "internal.h"
 #include "cid.h"
@@ -537,7 +536,12 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		gained = ecaps & ~old;
 		lost_all |= lost;
 
-		/* tell the sched its effective caps on this cid changed */
+		/*
+		 * Tell the sched its effective caps on this cid changed. The
+		 * invocation is equivalent to the dispatch path and may drop
+		 * and re-acquire the rq lock temporarily while the rest of
+		 * @batch is held privately, see scx_discard_ecaps_to_sync().
+		 */
 		if (ecaps != pcpu->reported_ecaps &&
 		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
 		    !scx_bypassing(pcpu->sch, cpu)) {
@@ -661,38 +665,51 @@ void scx_offline_ecaps(struct rq *rq)
 }
 
 /*
- * @pcpu's sched was unhashed before the grace period, so nothing new queues.
- * Flush its pending sync so the pcpu can be freed. If the cpu is online and
- * scx is enabled, drain via balance_one(). Otherwise, discard under the rq
- * lock.
+ * @pcpu's sched was unhashed before the grace period, so nothing re-queues its
+ * sync node. Remove the node from @rq's pending list so the pcpu can be freed.
  */
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 {
 	struct rq *rq = cpu_rq(cpu);
+	struct llist_node *head = NULL, *tail = NULL;
+	struct llist_node *pos, *tmp;
+
+	/*
+	 * llist can't unlink a single node. Take all queued nodes, drop @pcpu's
+	 * and resplice the rest. Nodes in the taken batch read as on-list
+	 * throughout, so queue_sync_ecaps() stays correct.
+	 */
+	if (llist_on_list(&pcpu->ecaps_to_sync_node)) {
+		scoped_guard (rq_lock_irqsave, rq) {
+			llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
+				if (pos == &pcpu->ecaps_to_sync_node) {
+					init_llist_node(pos);
+				} else {
+					pos->next = head;
+					head = pos;
+					if (!tail)
+						tail = pos;
+				}
+			}
+			if (head)
+				llist_add_batch(head, tail, &rq->scx.ecaps_to_sync);
+		}
+	}
 
+	/*
+	 * An in-flight scx_process_sync_ecaps() batch may still hold the node
+	 * privately across dispatch-induced rq unlocks, reading as on-list.
+	 *
+	 * Because a bypassing sched gets no op call, init_llist_node() and all
+	 * @pcpu accesses share one contiguous lock hold, off-list under the rq
+	 * lock means @pcpu won't be accessed again.
+	 */
 	while (true) {
 		scoped_guard (rq_lock_irqsave, rq) {
-			/*
-			 * scx_process_sync_ecaps() takes the node off the list
-			 * before it is done accessing @pcpu but does all of it
-			 * under the rq lock. Off-list observed under the rq
-			 * lock guarantees that the sync is complete.
-			 */
 			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
 				return;
-			/*
-			 * Discard only when the cpu is truly down. cpu_active()
-			 * is already set when scx_online_ecaps() queues an online
-			 * resync while SCX_RQ_ONLINE is not - so test cpu_active(),
-			 * or that resync would be dropped.
-			 */
-			if (!scx_enabled() || !cpu_active(cpu)) {
-				discard_queued_syncs(rq);
-				return;
-			}
 		}
-		resched_cpu(cpu);
-		msleep(1);
+		cpu_relax();
 	}
 }
 
@@ -704,7 +721,7 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
  * still-open link fd defers it) and can leave queued ecaps syncs behind.
  * Processing them would decode the dead sched's pshards with the current cid
  * layout. Discard them instead. The backing scx_sched_pcpu's are still
- * allocated as the free path drains ecaps_to_sync_node before freeing.
+ * allocated as the free path removes ecaps_to_sync_node before freeing.
  */
 void scx_discard_stale_ecaps_syncs(void)
 {
-- 
2.55.0

