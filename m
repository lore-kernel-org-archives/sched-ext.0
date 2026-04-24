Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F040148F;
	Fri, 24 Apr 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063472; cv=none; b=twC52SzF0hYK1Jd5bKCdt2XQNJaxN9gmwgxqI7iHblxY1BK8I8LTwZCj8KS60SHkkfCRnhm6yxWPduwnrlphJxLi6vj3zjWyrmYlxz5BOtyW837nM5+Y30lg90qwt5+hM3rQhcZqC+UFIzN5ECeQVTO13gLw7wOnjbfIs+yeA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063472; c=relaxed/simple;
	bh=ANEytGs1+qLxgWyc7LeyCkCiw6I6fwuwtWhLccBP09w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB1FSxd5+ks617dGtMlUbwv+oLWSd+CKH5X6ZxquNgFrUbPdLGHO4u7hFojvshZgwXwkvCyv1EVbnBs8JubSd81wqTkMqR5ZfBbXC9bZCm9ibqPSxX1glwK4hU/jPlz/kYkfwxjJ7o+/nYQYoEuCiwE1HoDC8w3m+V5olm+e3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHXoGH79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHXoGH79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A09C19425;
	Fri, 24 Apr 2026 20:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063472;
	bh=ANEytGs1+qLxgWyc7LeyCkCiw6I6fwuwtWhLccBP09w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHXoGH79sUBdVq7W/954FQQGr2iYZJsyDwjZzzoTgFZ0yewSGOT+vHCdZZaMmbMFN
	 gYs1L7+F9EjWUmlNd678n82ae7s3nNcHThHjOP5X/h5ZbBSNeOMXbJA+LWSTfljhyt
	 vP7ZDdfig1QcILzaXU3dVpz9Igabd8l16PlnQtvitb9cDpw4GjwHXGAbADKGbQTime
	 3LRIAaMOifKmucUjqz2ryjJeDJZmqkqq/AsWjmz4VAaa0JDM9I/HOil1WyOlG5Es/I
	 84Jx230lccBkGnuoxTScTmLnJSFr4DndMkzWAHU8ZvmjW82bDdeuq0M0t/G11Mnbnu
	 VJRlTPLAOS68w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/13] sched_ext: Align cgroup #ifdef guards with SUB_SCHED vs GROUP_SCHED
Date: Fri, 24 Apr 2026 10:44:17 -1000
Message-ID: <20260424204418.3809733-13-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two EXT_GROUP_SCHED/SUB_SCHED guards are misclassified:

- scx_root_enable_workfn()'s cgroup_get(cgrp) and the err_put_cgrp unwind
  in scx_alloc_and_add_sched() are under `#if GROUP || SUB`, but the
  matching cgroup_put() in scx_sched_free_rcu_work() is inside `#ifdef SUB`
  only (via sch->cgrp, stored only under SUB). GROUP-only would leak a
  reference on every root-sched enable.

- sch_cgroup() / set_cgroup_sched() live under `#if GROUP || SUB` but touch
  SUB-only fields (sch->cgrp, cgroup->scx_sched). GROUP-only wouldn't
  compile.

GROUP needs CGROUP_SCHED; SUB needs only CGROUPS. CGROUPS=y/CGROUP_SCHED=n
gives the reachable GROUP=n, SUB=y combination; GROUP=y, SUB=n isn't
reachable today (SUB is def_bool y under CGROUPS). Neither miscategorization
triggers a real bug in any reachable config, but keep the guards honest:

- Narrow cgroup_get and err_put_cgrp to `#ifdef SUB` (matches the free-side
  put).
- Move sch_cgroup() and set_cgroup_sched() to a separate `#ifdef SUB` block
  with no-op stubs for the !SUB case; keep root_cgroup() and scx_cgroup_{
  lock,unlock}() under `#if GROUP || SUB` since those only need cgroup core.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0980531c0e6c..9a31b8f064e9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4413,21 +4413,6 @@ static struct cgroup *root_cgroup(void)
 	return &cgrp_dfl_root.cgrp;
 }
 
-static struct cgroup *sch_cgroup(struct scx_sched *sch)
-{
-	return sch->cgrp;
-}
-
-/* for each descendant of @cgrp including self, set ->scx_sched to @sch */
-static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
-{
-	struct cgroup *pos;
-	struct cgroup_subsys_state *css;
-
-	cgroup_for_each_live_descendant_pre(pos, css, cgrp)
-		rcu_assign_pointer(pos->scx_sched, sch);
-}
-
 static void scx_cgroup_lock(void)
 {
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -4445,12 +4430,30 @@ static void scx_cgroup_unlock(void)
 }
 #else	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 static struct cgroup *root_cgroup(void) { return NULL; }
-static struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
-static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
 static void scx_cgroup_lock(void) {}
 static void scx_cgroup_unlock(void) {}
 #endif	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static struct cgroup *sch_cgroup(struct scx_sched *sch)
+{
+	return sch->cgrp;
+}
+
+/* for each descendant of @cgrp including self, set ->scx_sched to @sch */
+static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
+{
+	struct cgroup *pos;
+	struct cgroup_subsys_state *css;
+
+	cgroup_for_each_live_descendant_pre(pos, css, cgrp)
+		rcu_assign_pointer(pos->scx_sched, sch);
+}
+#else	/* CONFIG_EXT_SUB_SCHED */
+static struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
+static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 /*
  * Omitted operations:
  *
@@ -6583,7 +6586,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 err_free_sch:
 	kfree(sch);
 err_put_cgrp:
-#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
+#ifdef CONFIG_EXT_SUB_SCHED
 	cgroup_put(cgrp);
 #endif
 	return ERR_PTR(ret);
@@ -6674,7 +6677,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_unlock;
 
-#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
+#ifdef CONFIG_EXT_SUB_SCHED
 	cgroup_get(cgrp);
 #endif
 	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
-- 
2.53.0

