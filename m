Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6963F823B;
	Wed,  8 Jul 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545893; cv=none; b=BjV1EypXgSTCHNEWpwTcXb6pLAmxWP1v2x1ADV0xuCcURTZjG9XqQgkJxIbDfoUy80w/ItreWU4K/SCumru6W0qi7glIn8BzG5v/SjQclWQuOb4B6L2GZG1Z6P3Rk0i8LpHXNMz95izgxr2QW2aXqr3dDBtWHzOoyM/+Bw71G+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545893; c=relaxed/simple;
	bh=ub142xZueG6r9/4oeM2Tl2QTmUSYB1AjIlx2xGTFMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1RFHgK0FRJ3XVOQqemhOavc1TwTThMaqb12XmVd8OadR6hZeUlvDeK6uWJ4VHbv9nMVrgeaZyRRb1/i8h5IYcOpiZ9A7CJGvMOnlzLw0sswzdwv8Qmwgic+GePDOOP/oc2YGTlE1Biqdf+cBbwiUTMvd+lHR47J2Ot2MnbN5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr6LaaRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr6LaaRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1A01F00A3A;
	Wed,  8 Jul 2026 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545891;
	bh=9bm49HgIs0GQnaTOlFuMRW24MRjfiCy+CXMxL8dNKCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dr6LaaRA/IX31Y/Qs0+GSBMXKPPDq7JIO6gAdvCQyeZ9HHek5iGaeePUJdjqOLsvp
	 d/ksriySeUvycDWTrxXuMQmOQDG9N63Iy4I0GBYBcd/GVk8s+jTAaFOaiZ7oPJkSfh
	 ZrscNWovsdOKbCgCD2oWmyhCy5cKxBxbIekpYQF0hjD0BK5dfynRNpCjD5JVGxjNDn
	 OSML2Id2dtDAvG3P2cYwa54uHmhRCVOsnB04MAXD2Ky4Vws+dpEF4023zSPQRoL0we
	 mm1PEpXV6cZTyNzi7j87VFGBO/399BrSDgEVjE/QsPPFQvQSNf3nBTncS/tq//enwS
	 lfcQ9Rmolj6Lg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 19/40] sched_ext: Add scx_skip_subtree_pre()
Date: Wed,  8 Jul 2026 11:24:08 -1000
Message-ID: <20260708212429.3405787-20-tj@kernel.org>
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
2.54.0

