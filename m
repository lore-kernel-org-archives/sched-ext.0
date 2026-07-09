Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEE3BADB4;
	Thu,  9 Jul 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637457; cv=none; b=samClijCxYw6tkQLs+QMdE+mybEG/H08tAb3HOR97bctr9R36GNKi6sOCVeCXT1mvEGpzmoqoUYaIkO+fso4zyswcUFv0ZhZ0pMdngOgiNwMh5FkiII0wlY1aAtBg4u3jAHGgehabfwAfGhnFmUOtoEmCxkj6D5VPS1TJP10YP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637457; c=relaxed/simple;
	bh=+n2Y8ECl7JH5p1vOaqfllGs5Mb4sTBblP3TjSo1hu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAV9rqvhXH75nYSNZ12HEU4LdA3lR2fa5VEPnToO6i4Q/Uvm/s6NL+OmopfmQZBe4icIErxXfF5HqBLto2KxawL7/MqsFIHmMjT9JQXLNJtwBVCHUiiy0b5vD7nf7cvyzRAvfzQS1bh+TVDg23GKpBumFIk6XsQOYkSuJzLq0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZQI49gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZQI49gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C81F000E9;
	Thu,  9 Jul 2026 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637455;
	bh=MllUd1AJIMr5YgBMNCC0EYyFJ4XyCanc7SJN9kb5Ly4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FZQI49giR8segT9cKUYJgE0+HtkanAlULDxnqskiYGsb2uaw0m83lhl7trMM16t7s
	 E+3UlNJBEuzjIPeAdIoj/NbIQKLn93B4j3fvvq1c3QAKeKsRRqb+y9b9e0iCV/W3n8
	 Qi3wvnJP0k1NcY+pPSI9me6LO9ADjMY+Yg5lU07v2T5Mz/Xqi/LV+mIz7vyfFTTuOv
	 2IghjXW9if3uGHCPZ8sHapvdI5+KdXzhODwAO0AoaYoZDY8GO23HWq0SWUKkYMlnst
	 62g2fFklC3Bb2lj7gmP+wdcHiilUPhrvJZ1uPdUeWBBFXW3wNp2E2ajzU3ufoHxKPT
	 6NrT1UAJI1OnA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 12/33] sched_ext: Stop resolving a disabled scheduler's programs
Date: Thu,  9 Jul 2026 12:50:20 -1000
Message-ID: <20260709225041.1695495-13-tj@kernel.org>
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

v2: Check dead in the CONFIG_EXT_SUB_SCHED=n scx_prog_sched() too. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  8 ++++++++
 kernel/sched/ext/internal.h | 19 +++++++++++++++----
 kernel/sched/ext/sub.c      |  9 +++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ba83fe832343..fbf1c3477140 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5733,6 +5733,14 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 
+	/*
+	 * @sch's non-ops programs such as timers and tracers can fire after
+	 * ops.exit(). Now that exit is complete, stop scx_prog_sched() from
+	 * resolving to @sch and drain in-flight resolvers.
+	 */
+	WRITE_ONCE(sch->dead, true);
+	synchronize_rcu();
+
 	scx_unlink_sched(sch);
 
 	/*
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5b18c4192c62..4452aac89b14 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1202,6 +1202,7 @@ struct scx_sched {
 		struct sched_ext_ops_cid	ops_cid;
 	};
 	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
+	bool			dead;		/* set after ops.exit(), gates scx_prog_sched() */
 
 	/*
 	 * Arena map auto-discovered from member progs at struct_ops attach.
@@ -1976,14 +1977,20 @@ static inline bool scx_task_on_sched(struct scx_sched *sch,
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
@@ -2035,7 +2042,11 @@ static inline bool scx_task_on_sched(struct scx_sched *sch,
 
 static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
-	return rcu_dereference_all(scx_root);
+	struct scx_sched *root = rcu_dereference_all(scx_root);
+
+	if (root && unlikely(READ_ONCE(root->dead)))
+		return NULL;
+	return root;
 }
 
 static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 17ed0d28f383..017225ad492f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -344,6 +344,15 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
+
+	/*
+	 * @sch's non-ops programs such as timers and tracers can fire after
+	 * ops.exit(). Now that exit is complete, stop scx_prog_sched() from
+	 * resolving to @sch and drain in-flight resolvers.
+	 */
+	WRITE_ONCE(sch->dead, true);
+	synchronize_rcu();
+
 	if (sch->sub_kset)
 		kobject_del(&sch->sub_kset->kobj);
 	/* not added if enable failed before scx_sched_sysfs_add() */
-- 
2.55.0

