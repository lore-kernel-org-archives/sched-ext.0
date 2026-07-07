Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2E81ACD;
	Tue,  7 Jul 2026 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383170; cv=none; b=O/mrkPPS1M86C8PTMaydUClq7cPQ1sTELiXnRz2r7lEDRBrjf8cR5b/PQ3wAhRiEVWsvznJpnnpLtIEkMtkOgwUUQrv+tGQDM4gc33riMV8wUNd0FQ5Sc8SU5VOTBkTW/jbOHvVjLbSU4xkvochJH1bzEMYIGSVzF3LS+YSEgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383170; c=relaxed/simple;
	bh=rTjFo89eTNM3ZITRs4ga9Rp/14eeSlsYT83nnJG6Rxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFDe2belCSTJwNbUPQG1j0W+FEJmoU/McqrTXG2V2CpPQTRzzdLeQNVfdQ1yQwx0WlwyJo7uaZwdYhw7s00n2lFvqmxM5ZxHxPMB1vyPDWqsd4m89ua3z52aug6oUdVqL6E0aoecL0R6YWAJU2pNxS00l/XRlFtk2mxNrP2mBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbSTwM36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbSTwM36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D881F00A3A;
	Tue,  7 Jul 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383167;
	bh=6rmFLDBKG8lwGRS3DrXxfsqNXlKBgD2G/yy/FJIking=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbSTwM36xoTbOWd7UqXWN2fKI4p03KUI+OawwHh/KupBvrmUoMUxfStdtAeWkZG0A
	 t4hjwrltqNPLpyQiGVwTI8QmI7WLiZqDzTWBc0XYfty4VFcC50r59S8gZS6z01pchL
	 1rP+E8UWl0EC6hMUkMj4GTUYzQWPOzaWZivvxcIAERcdoflHqlc+mnv7ZgxFnEIRqf
	 TVAKHWe9Tks8oxqt7F5sJBlxFL+T7mACaKEs3iYoBQimhRpkunTScxG7DxwjO1B0QP
	 29tbTTkNLhDJq7UofuR96EA/gYYXfo/3fIg+x4kAa3CUlW/9kWCEAT5mP9Y10wlKlX
	 LzMtx8HRQmdmg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 18/36] sched_ext: Add scx_skip_subtree_pre()
Date: Mon,  6 Jul 2026 14:12:11 -1000
Message-ID: <20260707001229.1410929-19-tj@kernel.org>
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
index 5f1661597d70..eb9056f21ce8 100644
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

