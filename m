Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C83909A8;
	Wed,  4 Mar 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661684; cv=none; b=OUxq6f/hkWGU7qohxOcF97eSyTydkeQFSZ0Q/zhfix0BxboeCa+ZaXCG9LSVRmH+ZYYdCZUm75KYVLdvaFQHpk16vzctDZt5uO0dXqZpM9A0d2Y1r4MphJC+Ac4SQbelbuV24kg2Fb1NUtdu7v2XTZjcQQ/NTeFDJm20XUJsbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661684; c=relaxed/simple;
	bh=evz/JM/J053iW5o8DLaQzn8vtseD3AvMZ/r8WmTunNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKCOg5kpvX+dWWUq7/UZw048UyZCv05KC49hcSjtZVt6WVty8js+wZQqzH7IdJG3fWU0J1xvVK2xXINJ2Uh8JqHwe+rePPFfDYI3r5GiSPBEL3YiEiV9R8/hxpjNhFkaumQfe8Jplhh2EBit2ccvcx82x9hIfjhx0m2ce2wi84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9uLchTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9uLchTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D2C4CEF7;
	Wed,  4 Mar 2026 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661684;
	bh=evz/JM/J053iW5o8DLaQzn8vtseD3AvMZ/r8WmTunNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9uLchTFDHNKvPI6O7vCaAdWHDPRCN28655VTtkPKdxcTvoHso2mWA7YdUXA7OZpu
	 LA4sqkebaHaZbEH4jtw32p2G0qGqnWAMZkN7m/28qc+1EDw1e9eIRxfbvcHjcyfFMG
	 hKoOQM40KlgKwE8CxKcs90f3eLOfDGIohyTaSnkeuCdG0caelr/Gy/Dtfgwz2MCPwE
	 kLBBXv3airv6EDvx7SfsynEM0WOJ4dfxpBcdbEGLMAdmCqmgM3gfysbUA8XxYSP5kP
	 IBfEKihm/m7BfZWkhLSLK0H9trBubW100d7ClsiUMf+ougQfrlnDKq8pLIu9qelH6W
	 uheJ8gMjOFWMg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/34] cgroup: Expose some cgroup helpers
Date: Wed,  4 Mar 2026 12:00:49 -1000
Message-ID: <20260304220119.4095551-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the following through cgroup.h:

- cgroup_on_dfl()
- cgroup_is_dead()
- cgroup_for_each_live_child()
- cgroup_for_each_live_descendant_pre()
- cgroup_for_each_live_descendant_post()

Until now, these didn't need to be exposed because controllers only cared
about the css hierarchy. The planned sched_ext hierarchical scheduler
support will be based on the default cgroup hierarchy, which is in line
with the existing BPF cgroup support, and thus needs these exposed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h          | 65 ++++++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h |  6 ---
 kernel/cgroup/cgroup.c          | 55 ----------------------------
 3 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37ee..e52160e85af4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -42,6 +42,14 @@ struct kernel_clone_args;
 
 #ifdef CONFIG_CGROUPS
 
+/*
+ * To avoid confusing the compiler (and generating warnings) with code
+ * that attempts to access what would be a 0-element array (i.e. sized
+ * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
+ * constant expression can be added.
+ */
+#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
+
 enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
@@ -76,6 +84,7 @@ enum cgroup_lifetime_events {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct blocking_notifier_head cgroup_lifetime_notifier;
 
@@ -103,6 +112,8 @@ extern struct blocking_notifier_head cgroup_lifetime_notifier;
 #define cgroup_subsys_on_dfl(ss)						\
 	static_branch_likely(&ss ## _on_dfl_key)
 
+bool cgroup_on_dfl(const struct cgroup *cgrp);
+
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
@@ -274,6 +285,32 @@ void css_task_iter_end(struct css_task_iter *it);
 	for ((pos) = css_next_descendant_post(NULL, (css)); (pos);	\
 	     (pos) = css_next_descendant_post((pos), (css)))
 
+/* iterate over child cgrps, lock should be held throughout iteration */
+#define cgroup_for_each_live_child(child, cgrp)				\
+	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       cgroup_is_dead(child); }))			\
+			;						\
+		else
+
+/* walk live descendants in pre order */
+#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
+	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
+/* walk live descendants in postorder */
+#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
+	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
 /**
  * cgroup_taskset_for_each - iterate cgroup_taskset
  * @task: the loop cursor
@@ -336,6 +373,27 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
 	return cgrp->kn->id;
 }
 
+/**
+ * cgroup_css - obtain a cgroup's css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest (%NULL returns @cgrp->self)
+ *
+ * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
+ * function must be called either under cgroup_mutex or rcu_read_lock() and
+ * the caller is responsible for pinning the returned css if it wants to
+ * keep accessing it outside the said locks.  This function may return
+ * %NULL if @cgrp doesn't have @subsys_id enabled.
+ */
+static inline struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
+						     struct cgroup_subsys *ss)
+{
+	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
+		return rcu_dereference_check(cgrp->subsys[ss->id],
+					lockdep_is_held(&cgroup_mutex));
+	else
+		return &cgrp->self;
+}
+
 /**
  * css_is_dying - test whether the specified css is dying
  * @css: target css
@@ -372,6 +430,11 @@ static inline bool css_is_self(struct cgroup_subsys_state *css)
 	return false;
 }
 
+static inline bool cgroup_is_dead(const struct cgroup *cgrp)
+{
+	return !(cgrp->self.flags & CSS_ONLINE);
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
@@ -387,8 +450,6 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
 
-extern struct mutex cgroup_mutex;
-
 static inline void cgroup_lock(void)
 {
 	mutex_lock(&cgroup_mutex);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 3bfe37693d68..58797123b752 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -184,11 +184,6 @@ extern bool cgrp_dfl_visible;
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
 	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
 
-static inline bool cgroup_is_dead(const struct cgroup *cgrp)
-{
-	return !(cgrp->self.flags & CSS_ONLINE);
-}
-
 static inline bool notify_on_release(const struct cgroup *cgrp)
 {
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -222,7 +217,6 @@ static inline void get_css_set(struct css_set *cset)
 }
 
 bool cgroup_ssid_enabled(int ssid);
-bool cgroup_on_dfl(const struct cgroup *cgrp);
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root);
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be1d71dda317..cdc63be63f2c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -68,14 +68,6 @@
 /* let's not notify more than 100 times per second */
 #define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
-/*
- * To avoid confusing the compiler (and generating warnings) with code
- * that attempts to access what would be a 0-element array (i.e. sized
- * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
- * constant expression can be added.
- */
-#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
-
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
  * hierarchy must be performed while holding it.
@@ -509,27 +501,6 @@ static u32 cgroup_ss_mask(struct cgroup *cgrp)
 	return cgrp->root->subsys_mask;
 }
 
-/**
- * cgroup_css - obtain a cgroup's css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest (%NULL returns @cgrp->self)
- *
- * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
- * function must be called either under cgroup_mutex or rcu_read_lock() and
- * the caller is responsible for pinning the returned css if it wants to
- * keep accessing it outside the said locks.  This function may return
- * %NULL if @cgrp doesn't have @subsys_id enabled.
- */
-static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
-					      struct cgroup_subsys *ss)
-{
-	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
-		return rcu_dereference_check(cgrp->subsys[ss->id],
-					lockdep_is_held(&cgroup_mutex));
-	else
-		return &cgrp->self;
-}
-
 /**
  * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
@@ -741,32 +712,6 @@ EXPORT_SYMBOL_GPL(of_css);
 	}								\
 } while (false)
 
-/* iterate over child cgrps, lock should be held throughout iteration */
-#define cgroup_for_each_live_child(child, cgrp)				\
-	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       cgroup_is_dead(child); }))			\
-			;						\
-		else
-
-/* walk live descendants in pre order */
-#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
-	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
-/* walk live descendants in postorder */
-#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
-	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
 /*
  * The default css_set - used by init and its children prior to any
  * hierarchies being mounted. It contains a pointer to the root state
-- 
2.53.0

