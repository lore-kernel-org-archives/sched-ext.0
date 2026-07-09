Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F323BFAF7;
	Thu,  9 Jul 2026 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637455; cv=none; b=USrt8AqYZKmxPI0/dBvSYL/4hHluDhs4i2wdYOxYquKWS5TtaAmhdZD0TANM71NPtc6HaGkq1mKrgNQ5XzGtTUrDEbGuB9Ydme/uphbZYgJw5Us1zYak0t4N5Hl6krrWR1CA3a4LKvPEYILOQEx4S+R+Yui+Q+V1fczh8Hxhr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637455; c=relaxed/simple;
	bh=LSyaX49kpraen8MRVh5eRJRKIIMfkUPpwRBWSDewTz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlRWpxinD6WNh2UHPPVFW6javcfVA4n8ADrvSpvsSuCXdKuqPoa75DzfZxhWbF8vQGp4j5PV6krhxBZ/Yt3oJhJEqznEwpafQCp0+0/Mplqs362RcP02W8Eh3jqNwgw5Zg/Q6fzZ1l6Z+gnzWd4OiJRxaQyuFa9QRP7+JogYWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMZXtJA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMZXtJA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F051F00A3A;
	Thu,  9 Jul 2026 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637453;
	bh=thgH6yBlUoTaTDgcDt0+Df0DwSUkmBT7Fbi2G37DwS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMZXtJA2wIs+Jao7LV0zEgcMkOUotF7aSK8SJf6mIcPLZNINhAX/BIUzGSVlbbKfH
	 6iBW+L1QiwrWZhhf4DJCrET2IHc2qu2tu7aBFnqZ2aLQAVuER+mFc5mVTKGl/wjkn8
	 LGeSpXhbP7uEUXpRtJUJovKOsULU3iqK3q1/zSN7RWhYGOpiKK9H306Lx1kP7x/AVs
	 1nOltFVNoI6A/hMi1pW3KP4b/ufic5SIXDGqlxdGkRm2VVCTmElLT9XFA5KdHlR/+I
	 MM5e+oMx5qkffsA28+RPUni7+6PNs77Cg+KVQtVg4NHl96XECt2IAtRRpJAvYZgSCM
	 Objzd44ePQDMA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 10/33] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
Date: Thu,  9 Jul 2026 12:50:18 -1000
Message-ID: <20260709225041.1695495-11-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
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
index c82aa5346772..ba83fe832343 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5502,7 +5502,8 @@ s32 scx_link_sched(struct scx_sched *sch)
 	const char *err_msg = "";
 	s32 ret = 0;
 
-	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+	scoped_guard(raw_spinlock_irqsave, &scx_bypass_lock)	/* for the parent bypass check */
+	scoped_guard(raw_spinlock, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
 
@@ -5519,6 +5520,17 @@ s32 scx_link_sched(struct scx_sched *sch)
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
@@ -5526,7 +5538,7 @@ s32 scx_link_sched(struct scx_sched *sch)
 				break;
 			}
 
-			list_add_tail(&sch->sibling, &parent->children);
+			list_add_tail_rcu(&sch->sibling, &parent->children);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -5553,7 +5565,7 @@ void scx_unlink_sched(struct scx_sched *sch)
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
2.55.0

