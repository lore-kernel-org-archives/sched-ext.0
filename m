Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809A37CD2C;
	Mon,  6 Jul 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302081; cv=none; b=EIs1Ho++1sz2pdFb+eOWpAa4/RGU3cNAzy0w/J33pd/jSjH/+Lv0yOBS2k5Ou7e1aVPQc6HUhAvnqlNDiRsselVpGXFNMhWQRYogTb3sZBqIS6brb3IuutLFyyFOljbeGg4lHc938ocrtlQXFYVy6sIlcm7bWWy/5XTYr1MGvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302081; c=relaxed/simple;
	bh=25zpT6miwMQI2+5EVECSYjfDcjvj09EUKFz30DAfnpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xti3agydrtTaCYpkY4KPUc79bAEOM2TnEWRHZgRpuqUS2fv8PhMGQ+MWyBa6aNgZ4LlR1pf2V1VSBlFi3qRJ+JiQtNqvR6hksuSN6Ym0SZPJCor+4kNysY0spbd1OWbK5Sjwu5Z7UIWt5I9PIwQiEg5jTgLPMokhwopK6sq5l9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxV8wzme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxV8wzme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979A21F00A3E;
	Mon,  6 Jul 2026 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302076;
	bh=VViWsPJc7oYGwqCvL10+nWdxbnewmwZh3pfVdIx7etQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UxV8wzme6JfgD8tKQpghH39pgyCrpEi2UZDX6b3FDDIFka96I+G/dAocQbBaFWsre
	 AHulXh0qmSiQnfVpX/BqVmlsPP4NvY+2LhGz2/bDFH9yhGreRJtd4pZMCIJKS3NBvj
	 qhE+s8Y8uOQ977yLhcnSMlM5nq6KUmD8QgWIiwSuCJXmEQhw+QQn6CSXe6abi/QTAO
	 XfkDNmmd67cQulwes8JnsTAysC9e8nyaVBmvulf8rVCFK3ITC0cK4HwfhDHOKK99zk
	 z0dcvtb+Xtk8YzGiMkBPu3/griB6oJejbwnomgA3BiSWq8R1/EmtgwgyNQORREdSje
	 Fj1fMnYAdpA9A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 17/36] sched_ext: RCU-protect the sub-sched tree's children/sibling lists
Date: Sun,  5 Jul 2026 15:40:39 -1000
Message-ID: <20260706014058.439853-18-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
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
walk that propagates the depth has passed its parent. Take scx_bypass_lock
across linking and inherit the parent's bypass_depth so the new sched starts
out with the ancestor bypass state.

v2: Inherit bypass_depth before publishing @sch on the RCU sibling list.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 10 +++++++---
 kernel/sched/ext/sub.c | 11 +++++++----
 kernel/sched/ext/sub.h |  4 ++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8ee980f822aa..9231ccc775e0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5463,7 +5463,8 @@ s32 scx_link_sched(struct scx_sched *sch)
 	const char *err_msg = "";
 	s32 ret = 0;
 
-	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+	scoped_guard(raw_spinlock_irqsave, &scx_bypass_lock)	/* for bypass inheritance */
+	scoped_guard(raw_spinlock, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
 
@@ -5487,7 +5488,10 @@ s32 scx_link_sched(struct scx_sched *sch)
 				break;
 			}
 
-			list_add_tail(&sch->sibling, &parent->children);
+			/* inherit the ancestor bypass state */
+			WRITE_ONCE(sch->bypass_depth, READ_ONCE(parent->bypass_depth));
+
+			list_add_tail_rcu(&sch->sibling, &parent->children);
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -5514,7 +5518,7 @@ void scx_unlink_sched(struct scx_sched *sch)
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

