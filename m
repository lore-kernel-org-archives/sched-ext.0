Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101911A5B9E;
	Tue,  7 Jul 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383169; cv=none; b=aSUSb/+YjsHOfQhM2ZoEyTVKZk3XVDv1hRbOSmHDcOVXO/10jQinfGnUjEEJt/UcUDFUx6GEVXxiXDMaHCVhQecCVVC280RZNZoQq+CzP87vh5yOX7XdFfmTHyBttP/yUEIdwK6gZvxcF5ms0KClw8BnT1sqTeoH/8UWQ4+/I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383169; c=relaxed/simple;
	bh=poCORqdJcmIqlV08g1AAeWHTh5AP14+sfzM2BBb+8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzSE+Zgo75GrX4PHljgJd8goXlNnJGwnLBy7nCOSeX/pwFEEk+dOfVvedAEzZPH9UoqeVzOfZ07bPxWiFy3oW2rWvoUDr/VjHGIRYcrlNIUlDgqP40u4n2uI3b4PdwGIeSANPJYnKbHEIP9JD2qXcreCUWsrl/xauGX3UN9o6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmEKXHRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmEKXHRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE83F1F000E9;
	Tue,  7 Jul 2026 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383166;
	bh=Att7TnHPdfP0hhRl9ZH/lPEIT4AIlYdqv1GQeJ9OOF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmEKXHRBxychDkDyTnjhscQuJiQAxTs3u7LXnek5myfpeIRhBncS/oDqB81p2jQcv
	 1eLjntdlRFQVyNJNZh/g72H5cK/nBEM7BE3kE6erDBTWDdZ5xVGwOv16udZ9bkvYaB
	 iT44dSLg5J8IyLhmrbZsFd4IGPb3d2lZm6GIaUY57wwjuWTil31uJTkcDefMdrNWyn
	 aKXB7T9BTGQKr5nLpD+WJt3/z01SAoARSFjpzMsCDhEvJVajWyx6oVveZO7OEmikP2
	 luY8zaSmaTu5jJ5isusJDFZKthAf1Ksqr3j1xeNIdU2R4SRGWJkUru95sC/sO7D3hq
	 tqf8e6VbEuHcw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 17/36] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
Date: Mon,  6 Jul 2026 14:12:10 -1000
Message-ID: <20260707001229.1410929-18-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
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
index 8ee980f822aa..477120a931b0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5463,7 +5463,8 @@ s32 scx_link_sched(struct scx_sched *sch)
 	const char *err_msg = "";
 	s32 ret = 0;
 
-	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+	scoped_guard(raw_spinlock_irqsave, &scx_bypass_lock)	/* for the parent bypass check */
+	scoped_guard(raw_spinlock, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
 
@@ -5480,6 +5481,17 @@ s32 scx_link_sched(struct scx_sched *sch)
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
@@ -5487,7 +5499,7 @@ s32 scx_link_sched(struct scx_sched *sch)
 				break;
 			}
 
-			list_add_tail(&sch->sibling, &parent->children);
+			list_add_tail_rcu(&sch->sibling, &parent->children);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -5514,7 +5526,7 @@ void scx_unlink_sched(struct scx_sched *sch)
 		if (scx_parent(sch)) {
 			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
 					       scx_sched_hash_params);
-			list_del_init(&sch->sibling);
+			list_del_rcu(&sch->sibling);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6d8b9bcf2f49..5f1661597d70 100644
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

