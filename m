Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2D3F99E5;
	Wed,  8 Jul 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545894; cv=none; b=u1PcYWjT6wqw/uF1gowL+CtVfu2poDtOlTrKXJC86sd8j6cDKBkZWvxsCi8qzvogBpQtS0Oz4Ta5piGLkVOiF8SuQs+tT4eQ7zp71LpVekvj8ZBclZAEe2kBxQj+bkfhr2luRjmIHpati+EV4vQyo8Okke5w3Gd2naOYTj35fLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545894; c=relaxed/simple;
	bh=rq1pt28f+xhO8N2oS55Ccsl/IJZgEfLoYin7waWE1L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3MgfU0A0yGUIj376faEPHi5/doCjRaojM12MJwaZ76tDdznD6c7dwvXd3gZY4onDW4c3zIjTVuASFL9YNrFKXaeI/47mSxZ0RuINHGUXCrn3bMHUsRK7o1kSBq60t6gnwH79VUrm2xTR3u6ipmbCwQOnTIHa1F2U8b6Un0Dd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu6llFOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu6llFOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A761F00A3D;
	Wed,  8 Jul 2026 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545892;
	bh=HFC9ux1zZIh1AHWRbOvtOSZR/UauD1ZQi6B9KdH64tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vu6llFOUJjcxZnqt0COUrlEZiwJTNbxHNkBBnbkjb/IpjjdNaMGjcnYYTjmTaQ+MK
	 s/RFvC6m5Y/r8EW6EHZFJ9ZhrfQk1Ldq3D8dk/oM7dg0iCAfMZMUyho4gGxYtChajo
	 HeaE6leMW+IDg+BW15zRWsVjgYKSMo/PpylcvfSDx64f+Pzm1qKx/kD2z2XJP1GLMz
	 Nbl7gPOI3bEW69sw5C0wUKETr05ROyPfpYXd0dQbEESXR0cbcSskOc2vud1rzUusQC
	 0bjqD/QXthp5tUL/ThH6UzkockA6AzRN04qTF0qXhM2KaFdNDma501TCuB8Uc/PkzK
	 J95OcIbSIgdwg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 20/40] sched_ext: Stop resolving a disabled scheduler's programs
Date: Wed,  8 Jul 2026 11:24:09 -1000
Message-ID: <20260708212429.3405787-21-tj@kernel.org>
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

A scheduler's BPF programs can outlive it. A timer it armed or a tracing
program it loaded can fire after ops.exit() has run, before the programs are
unloaded, and scx_prog_sched() still resolves the program to its scheduler
through ops->priv. Harmless while kfuncs touch only lifetime-stable state,
but a hazard once a kfunc reads global state a newly loaded scheduler can
change underneath it.

Add scx_sched->dead, set right after ops.exit() and drained with
synchronize_rcu(). It follows exit() rather than preceding it so exit()'s own
kfunc calls still resolve to @sch. scx_prog_sched() returns NULL for a dead
scheduler, so every kfunc's existing !sch bail rejects it at one choke
point.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  8 ++++++++
 kernel/sched/ext/internal.h | 13 ++++++++++---
 kernel/sched/ext/sub.c      |  9 +++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 46b80b31925e..b877f2459ff6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5696,6 +5696,14 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 
+	/*
+	 * @sch's programs (an armed timer, a tracing prog) can fire after
+	 * exit(). Now that exit()'s own kfuncs have resolved, stop
+	 * scx_prog_sched() from resolving to @sch and drain in-flight resolvers.
+	 */
+	WRITE_ONCE(sch->dead, true);
+	synchronize_rcu();
+
 	scx_unlink_sched(sch);
 
 	/*
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index dce07b83c166..87582bca5cc4 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1202,6 +1202,7 @@ struct scx_sched {
 		struct sched_ext_ops_cid	ops_cid;
 	};
 	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
+	bool			dead;		/* set after ops.exit(), gates scx_prog_sched() */
 
 	/*
 	 * Arena map auto-discovered from member progs at struct_ops attach.
@@ -1968,14 +1969,20 @@ static inline bool scx_task_on_sched(struct scx_sched *sch,
 static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
 	struct sched_ext_ops *ops;
-	struct scx_sched *root;
+	struct scx_sched *sch, *root;
 
 	ops = bpf_prog_get_assoc_struct_ops(aux);
-	if (likely(ops))
-		return rcu_dereference_all(ops->priv);
+	if (likely(ops)) {
+		sch = rcu_dereference_all(ops->priv);
+		if (sch && unlikely(READ_ONCE(sch->dead)))
+			return NULL;
+		return sch;
+	}
 
 	root = rcu_dereference_all(scx_root);
 	if (root) {
+		if (unlikely(READ_ONCE(root->dead)))
+			return NULL;
 		/*
 		 * COMPAT-v6.19: Schedulers built before sub-sched support was
 		 * introduced may have unassociated non-struct_ops programs.
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 17ed0d28f383..8d9825093649 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -344,6 +344,15 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
+
+	/*
+	 * @sch's programs (an armed timer, a tracing prog) can fire after
+	 * exit(). Now that exit()'s own kfuncs have resolved, stop
+	 * scx_prog_sched() from resolving to @sch and drain in-flight resolvers.
+	 */
+	WRITE_ONCE(sch->dead, true);
+	synchronize_rcu();
+
 	if (sch->sub_kset)
 		kobject_del(&sch->sub_kset->kobj);
 	/* not added if enable failed before scx_sched_sysfs_add() */
-- 
2.54.0

