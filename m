Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBE3B9D81;
	Thu,  9 Jul 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637458; cv=none; b=mBrpP0eFXRoub/8Xb5x++ae4/olouxI/NX0WGcEWxb5jL/snYieGUgyGt6n00+dHk4XEYjH4Y16K4UH2lcZ+y9KPQOuvXOT6amzT+DNyDUOwZoBrejxJjPp5eazR5UTbCL/vwVMPNJbj4ftpmHB0ZBCbKBgdFXPqykGNpw0EPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637458; c=relaxed/simple;
	bh=RWMU8kjVZA8nqOytlrDOQzXfQTlC3KBGsgvm9Nhn+Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/xR+E4vyRAXOHhjJifp538m4J3TgrMcKsd6/djyPzQrNsKGc24Agv1yfUs0TBz1ih8f4TZxU032ISkLeNUHRNa0k7q2dArtys6arnT65cg/UeeImvXg8TeZjobq+trbeHaEGxo8mEIKNtmbXYwuCCNikr8ql23I0lwFVH7jtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDuvoepm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDuvoepm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAD41F00A3D;
	Thu,  9 Jul 2026 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637454;
	bh=ZBeHrnScBcS8evRRVTjHwkc3p65JyEjb2JH/LWIcNIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cDuvoepmdWo3nO+FCXU5mYWh75naW3oJz0hfcmhs4oG+KoXuLigN3yJp1avs3QTB0
	 bPiRzquUnyqOmyyYUqermgh9ZvNNRc3ZQH/2L0losKERU2q788IfAcKA+bfAAn2p+r
	 mxjxCP/YxElp4Qw5yzjrsNYfB4ng17N7IdNcebGCHhytlXzR1u9cTg7Dz0i28CLWhF
	 utOJLg7W/q4aEFCol+/p9DxXzI6GBHOLQo75X9q9m/ILOXeTEwonDILeM1xUVju+Wd
	 /J7A3nxu+g4P3gOT+Z/k/52Ec7FIybLlYzHulVEFBCSqovrOf6Lpk5tX8e7tuSMjwm
	 t47QyNKo+//DA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 11/33] sched_ext: Add scx_skip_subtree_pre()
Date: Thu,  9 Jul 2026 12:50:19 -1000
Message-ID: <20260709225041.1695495-12-tj@kernel.org>
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

Factor the sibling/ancestor portion of scx_next_descendant_pre() out as
scx_skip_subtree_pre(), a pre-order walk primitive that skips @pos's
subtree, and call it from scx_next_descendant_pre(). Same locking rules as
the existing primitive.

Used in a follow-up to fast-skip subtrees that have nothing to do during a
descendant walk.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 37 ++++++++++++++++++++++++++++---------
 kernel/sched/ext/sub.h |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 5fe2f79064dc..17ed0d28f383 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -21,6 +21,33 @@
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+/**
+ * scx_skip_subtree_pre - Skip @pos's subtree in a pre-order walk
+ * @pos: current position
+ * @root: walk root
+ *
+ * In a walk started by scx_next_descendant_pre(), continue past @pos's subtree:
+ * return @pos's next sibling, or the closest ancestor's next sibling, or NULL
+ * if @pos's subtree is the last under @root. Same locking rules.
+ */
+struct scx_sched *scx_skip_subtree_pre(struct scx_sched *pos, struct scx_sched *root)
+{
+	struct scx_sched *next;
+
+	lockdep_assert(lockdep_is_held(&scx_enable_mutex) ||
+		       lockdep_is_held(&scx_sched_lock) ||
+		       rcu_read_lock_any_held());
+
+	while (pos != root) {
+		next = list_next_or_null_rcu(&scx_parent(pos)->children, &pos->sibling,
+					     struct scx_sched, sibling);
+		if (next)
+			return next;
+		pos = scx_parent(pos);
+	}
+	return NULL;
+}
+
 /**
  * scx_next_descendant_pre - find the next descendant for pre-order walk
  * @pos: the current position (%NULL to initiate traversal)
@@ -48,15 +75,7 @@ struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sche
 		return next;
 
 	/* no child, visit my or the closest ancestor's next sibling */
-	while (pos != root) {
-		next = list_next_or_null_rcu(&scx_parent(pos)->children, &pos->sibling,
-					     struct scx_sched, sibling);
-		if (next)
-			return next;
-		pos = scx_parent(pos);
-	}
-
-	return NULL;
+	return scx_skip_subtree_pre(pos, root);
 }
 
 static struct scx_sched *scx_find_sub_sched(u64 cgroup_id)
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index e936867bc5c5..3d5ad9c36d64 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -15,6 +15,7 @@
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+struct scx_sched *scx_skip_subtree_pre(struct scx_sched *pos, struct scx_sched *root);
 struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root);
 void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch);
 struct cgroup *sch_cgroup(struct scx_sched *sch);
@@ -30,6 +31,7 @@ s32 scx_alloc_pshards(struct scx_sched *sch);
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
+static inline struct scx_sched *scx_skip_subtree_pre(struct scx_sched *pos, struct scx_sched *root) { return NULL; }
 static inline void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 static inline struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
 static inline void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
-- 
2.55.0

