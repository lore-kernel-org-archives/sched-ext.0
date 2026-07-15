Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4643CF204;
	Wed, 15 Jul 2026 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159497; cv=none; b=ZBiOkv4To8Lbm+wr1SDQz3+68964zrgPcgaD4zsayvjqnOFnCM2TkZxINLMJowM6UazOb1Rko6ptm1FMnp7LhSZzp1kh7maN1Gk0V5gmnX4IB/ldQtTarDU9nbH9S53zpbpPLkg9SWgp/O+q3hAf3a8T1Afu+jlR+9qX4nxfEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159497; c=relaxed/simple;
	bh=ID5OR9ea3lx/XTXgNNWm85qQnV4XHZp73qdQc8M0K/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg4cCxEo2LVIKpTj8q/ibFoOrRrAvWYztCmxx3XuYZCSdstNl6Jp33AJkakznXOU6kqMiFsCcd6pLGdkVQTrSRAHtRj0VGxmz3+bTJO4zZXINi14Llt1759zdjxVSlelh11SYFqw/cO4+wiANhHrm4VHkwgURtq8XSdBn9pJ4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M76Cv2sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M76Cv2sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DB71F00A3A;
	Wed, 15 Jul 2026 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159495;
	bh=Ny58PTih5gDiZkxMe0b3UrTBbaBzwognws77wfq6Wno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M76Cv2sae3AIiOEMle29Zu2I1ODabC1XtRK0HXqSLtVIDaTJB3KAVIIZ3Gi+P0mLm
	 65KKs5dJecIEl30nLuC1EqiSIcucVCP5tRwad86SnWu5q0L3pzvZ8Z4T7z7cPbuyCb
	 BX1tvkOZpe7+unR9dVbXN93+2i636sb2bVhLhAg3A8KRXGO7Bv3P2s2TwEa7J+6XTT
	 FTwtsom2NX5SLpou6PZK+DjF72/PAdsYblR6lJSMEI7iPEgUIXQIJOcxkcDEsAqW6f
	 K6Hy+/6RB11InyjUNmxWHwWRIJ8YAd0W5cZcxYLv6XKG4X5Usm9lzS9EsLqUUtKF2a
	 dp3HD2DYQSMIg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: Remove queued ecaps syncs directly on sched teardown
Date: Wed, 15 Jul 2026 13:51:30 -1000
Message-ID: <20260715235133.810434-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715235133.810434-1-tj@kernel.org>
References: <20260715235133.810434-1-tj@kernel.org>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
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

