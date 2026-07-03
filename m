Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718237F8CA;
	Fri,  3 Jul 2026 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065737; cv=none; b=mUYk9zmi7Iy2uMf9nzJgJI9zhqETdw7H6pBQtgRQl4cK5zkvgjp8VliXlU/1uF+icyDVwp1t2lzURbK1iXRZ367ljEJE9teXwKN9GmfOmoTfBPaJ8P1UErOVxFweSRVcf2uavDeQBRmXYHJLqhyjNYM+8ZOAGm36ygWUUAXyllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065737; c=relaxed/simple;
	bh=8S3A6eNpb+/1k5uMvj1v3ybq4lUkpCq0GZIuJaE4zko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWuQwxirK0HlyDK9YOOaVRS72gyUte06SJjz3gPtT97yf2H3oEq5jmmvQOTUKTBi2ufWMa2tzqbVJP01BFQLPaD/GjnC2PZw/TqY/g0rJ6UNCYs1DUKXn9SZtX/pS7Kek/JU+Kz8mfBw8OWoMEp3N/T00SzPi9VGM5RWa4VuNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzZ8NIyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzZ8NIyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CB01F00A3D;
	Fri,  3 Jul 2026 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065735;
	bh=jH/Htu7GIh/J8I3Kbcfi0Xq9rPd9EHLEbZbFKomP4YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzZ8NIySef4LDxjIcF5/8gx6y/z9nEz0kZbS1BtsNWpFozwka5Aid6V+lhVglwmfZ
	 eWVV9T37YprT0/YMeUDiZ7luEshMFnWn9KRA55jJ0Klwf0xLnxQocBMiViWwHBypqL
	 oOLZK8powBoNHLr5BJwsEBfz5eGgMguE7sFhFyZhD9ZZjx2NG8CSKdeK/4dszoByZj
	 +p9oue8xPZ4gAIIkWb5YRBa/z3zuGF9C4b7/X27tX7YLfe3Y5OqqD6BAH5ZmSKCWwO
	 50KenJXxp+b2R/MTax+XfgNqWz1qIDhJ+vao6Oz5d6QdnFkNzD4dueQZpUymzAljLi
	 CZYVQUECPUvEQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 15/32] sched_ext: Add scx_skip_subtree_pre()
Date: Thu,  2 Jul 2026 22:01:42 -1000
Message-ID: <20260703080159.2314350-16-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index 066fad0a60b4..1e84f4620176 100644
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

