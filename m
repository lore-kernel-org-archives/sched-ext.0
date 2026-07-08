Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937643F88A3;
	Wed,  8 Jul 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545892; cv=none; b=uX3GJD3I+AZAUDq9pobWL1rxPT1XhFVu7kdZIK2bC2Pl/v1VmQawT8bS2alj5kg4zjgsPK0jk+Kfw3Q6zHd46l15HhhJ3AV8HIUI1tHYxXyBcGl2YRvdDTrqc3qG4MdFgwgyEY7nlBPyAGioHFvKe5tget3Sz+XD/VE1d+ID1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545892; c=relaxed/simple;
	bh=NubeVCk6RJx1/0eHXzXOnduuml0E34WeEWj2tUp59+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbwLxpS0Xo2s2B27Gef6Lq+OLuiNDS7xEW71rk7LwsHCJW4zFB4aT0g5CQjSFOGQXWhhuktZtt/caBZNuJ4eTWVIrUa0ug9HyeObPnC5Br71sXogAPI9GjPv5VD6tph4F9hw9JyeI0jEDQIYcbUmKxmKAUxgLb5er8gGQvaV++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P62soChW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P62soChW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214531F000E9;
	Wed,  8 Jul 2026 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545890;
	bh=ZaI7GJYKYrl6GyWKbOWh8xY8UDJo5PgrWGDsVicmbSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P62soChWJ/TTs/7EvsLwnTsgpxngVp1e2JlqSLmoXifjsu5g1iMlHL+ConGSosyTV
	 SV7iFH0vaA05f4SPIbzohyKB8uzIX9HkoOnXTt87GpsV2Q4PuTlCKKKBB0cxItVm1B
	 B1cZR6QOqtb40q6pY1/RxV7kFUron2GKyjJ7h6PQYPoTpV57oR03RTL+yigwc9GYxJ
	 UFGhk5qeZsnupBdcRpO/3LhQWnX8NDM0aXPjUvTIbHW0S1A3NQEpMJicwJWsvHOfEv
	 rM7mxaGHmzaxSJDiOZwY/dUNofLcTr5Tl4ZUFVoGq2eHKEnCs7d05JmD6Qrfe3mTyR
	 daWY+ypjJa5HA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 18/40] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
Date: Wed,  8 Jul 2026 11:24:07 -1000
Message-ID: <20260708212429.3405787-19-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future kfuncs need to walk descendants without scx_sched_lock. Make the
walker RCU-safe so that they can. A sub-sched's fields are initialized
before it is linked, so a walk that observes a linked node also observes its
setup. In-place changes after linking carry their own ordering.

Switch the children/sibling list ops to RCU and expand the descendant walker
to accept rcu_read_lock as a valid read-side context. Walkers that mutate
keep scx_sched_lock.

A sub-sched can be linked while an ancestor is bypassing, after the bypass
walk that propagates the depth has passed its parent. Bypass state is a
per-cpu flag plus a depth count and can't be established atomically at link
time, so refuse to link under a bypassing ancestor. Take scx_bypass_lock
across linking to check the parent's bypass state coherently.

v3: Reject linking under a bypassing ancestor instead of inheriting bypass_depth. (sashiko AI)
v2: Inherit bypass_depth before publishing @sch on the RCU sibling list.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 18 +++++++++++++++---
 kernel/sched/ext/sub.c | 11 +++++++----
 kernel/sched/ext/sub.h |  4 ++--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c5201553f566..46b80b31925e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5465,7 +5465,8 @@ s32 scx_link_sched(struct scx_sched *sch)
 	const char *err_msg = "";
 	s32 ret = 0;
 
-	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+	scoped_guard(raw_spinlock_irqsave, &scx_bypass_lock)	/* for the parent bypass check */
+	scoped_guard(raw_spinlock, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
 
@@ -5482,6 +5483,17 @@ s32 scx_link_sched(struct scx_sched *sch)
 				break;
 			}
 
+			/*
+			 * Bypass state is spread across per-cpu flags and a
+			 * depth count, so inheriting it is tricky and has no
+			 * valid use case. Refuse it.
+			 */
+			if (READ_ONCE(parent->bypass_depth)) {
+				err_msg = "parent bypassing";
+				ret = -EBUSY;
+				break;
+			}
+
 			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
 					&sch->hash_node, scx_sched_hash_params);
 			if (ret) {
@@ -5489,7 +5501,7 @@ s32 scx_link_sched(struct scx_sched *sch)
 				break;
 			}
 
-			list_add_tail(&sch->sibling, &parent->children);
+			list_add_tail_rcu(&sch->sibling, &parent->children);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -5516,7 +5528,7 @@ void scx_unlink_sched(struct scx_sched *sch)
 		if (scx_parent(sch)) {
 			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
 					       scx_sched_hash_params);
-			list_del_init(&sch->sibling);
+			list_del_rcu(&sch->sibling);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 3adec9343e46..5fe2f79064dc 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -35,21 +35,24 @@ struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sche
 	struct scx_sched *next;
 
 	lockdep_assert(lockdep_is_held(&scx_enable_mutex) ||
-		       lockdep_is_held(&scx_sched_lock));
+		       lockdep_is_held(&scx_sched_lock) ||
+		       rcu_read_lock_any_held());
 
 	/* if first iteration, visit @root */
 	if (!pos)
 		return root;
 
 	/* visit the first child if exists */
-	next = list_first_entry_or_null(&pos->children, struct scx_sched, sibling);
+	next = list_first_or_null_rcu(&pos->children, struct scx_sched, sibling);
 	if (next)
 		return next;
 
 	/* no child, visit my or the closest ancestor's next sibling */
 	while (pos != root) {
-		if (!list_is_last(&pos->sibling, &scx_parent(pos)->children))
-			return list_next_entry(pos, sibling);
+		next = list_next_or_null_rcu(&scx_parent(pos)->children, &pos->sibling,
+					     struct scx_sched, sibling);
+		if (next)
+			return next;
 		pos = scx_parent(pos);
 	}
 
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 9fa6b5c8be23..e936867bc5c5 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -46,8 +46,8 @@ static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
  * @root: sched to walk the descendants of
  *
  * Walk @root's descendants. @root is included in the iteration and the first
- * node to be visited. Must be called with either scx_enable_mutex or
- * scx_sched_lock held.
+ * node to be visited. Must be called with scx_enable_mutex, scx_sched_lock, or
+ * RCU read lock.
  */
 #define scx_for_each_descendant_pre(pos, root)					\
 	for ((pos) = scx_next_descendant_pre(NULL, (root)); (pos);		\
-- 
2.54.0

