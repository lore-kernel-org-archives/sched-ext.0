Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2C19DF62;
	Sat, 17 Oct 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792276662; cv=none; b=KS213PpEl+jCovgZyD57cU3qKvG7RFBPbH95qKLUG5+4O+2Tnw1BZx45F/hyApamkpKV2POX51a1msAzWR12c40Hsbbi3b1IANwknhusr7xnj18B/cgWMiYPCu6KkfMHtXnHGOKPuqkpY162KsVOFRdm+WxsaKjNCafpsXzbzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792276662; c=relaxed/simple;
	bh=kM4HZLgYzvf5ntXgjwxtUM3ArAODRcxTAaQcnjMVHjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+7X1hYG7VoSQiFtDUO/sZRkO9AWnVp0kP572tq1uOo0zQPJXsKNvqAHiN6ejlSU3Nqd6TV6lPZbWRIriyOXiRsTJKyYw2vx0Q73qc1gGKK91DvXLgIUDW12QRnyc+HvCuNRqAQNiyOqKAO2M8YwJXJbNXeh3/40PTP0WXt9bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoA6/uT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoA6/uT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE61F000C5;
	Sat, 17 Oct 2026 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792276661;
	bh=fg8Dyuuxz5C8n1jvmqKXYzcBSnRtj0AV1+VEozw2Qw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BoA6/uT6eI5NWiFqHckHRxHbtKjUogdgUttLe4WMu+gLdumPcREYsy1noiJ4/3Bax
	 zBq2jYeodFRhhyCGzEQiIW0mIRwpOj8aSPAUnfRhpT0kKfg2JHiESgnT+D6jeD+J5x
	 WQByWUSmQ5QkztE5AMmE+BCAXJWQwea3W6iVs0TP2u2eYWs9jLMg1LU4M/CLrjyepL
	 pmumf130BC+m77rOEsaUXGlcoqPcxvqdSMw7dsrXt+nKarQ8xe77IIeISp+eC9fIWn
	 tapLRYiUCbCoeJTSBVOEMitrHXvTs7rBFNrdDD4puRfMAPTgL7YhjcrG306m3Ipm65
	 7bDnuY2+iZeBA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Factor out the rq lock switch of scx_dsq_move()
Date: Sat, 17 Oct 2026 12:37:36 -1000
Message-ID: <20261017223738.993262-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017223738.993262-1-tj@kernel.org>
References: <20261017223738.993262-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the rq lock switch on entry to scx_dsq_move() and its undo on exit
out into kf_switch_rq_lock() and kf_restore_rq_lock() so that other kfuncs
operating on a task from a DSQ iteration can share them. No functional
change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b9f80fb29255..3e707b00e78b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9745,6 +9745,40 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.filter			= scx_kfunc_context_filter,
 };
 
+/*
+ * Lock @rq from a kfunc called either from ops.dispatch(), which holds the
+ * dispatched rq's lock, or from a context holding no rq lock. Under core
+ * scheduling, dispatch can run for a sibling rq, so the locked rq is not
+ * necessarily this CPU's. Return the rq locked on entry, NULL if none.
+ */
+static struct rq *kf_switch_rq_lock(struct rq *rq, unsigned long *flags)
+{
+	struct rq *entry_rq;
+
+	local_irq_save(*flags);
+
+	entry_rq = scx_locked_rq();
+	if (entry_rq) {
+		if (entry_rq != rq)
+			switch_rq_lock(entry_rq, rq);
+	} else {
+		raw_spin_rq_lock(rq);
+	}
+	return entry_rq;
+}
+
+/* undo kf_switch_rq_lock(), @rq is the rq locked now */
+static void kf_restore_rq_lock(struct rq *rq, struct rq *entry_rq, unsigned long flags)
+{
+	if (entry_rq) {
+		if (entry_rq != rq)
+			switch_rq_lock(rq, entry_rq);
+	} else {
+		scx_rq_lock_drop(rq);
+		raw_spin_rq_unlock_irqrestore(rq, flags);
+	}
+}
+
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags,
 			 bool priq)
@@ -9779,27 +9813,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (unlikely(READ_ONCE(sch->aborting)))
 		return false;
 
-	/*
-	 * Can be called from either ops.dispatch() holding the dispatched rq's
-	 * lock or any context where no rq lock is held. If latter, lock @p's
-	 * task_rq which we'll likely need anyway.
-	 */
 	src_rq = task_rq(p);
-
-	local_irq_save(flags);
-
-	/*
-	 * Under core scheduling, dispatch can run for a sibling rq, so the
-	 * locked rq is not necessarily this CPU's.
-	 */
-	locked_rq = scx_locked_rq();
-
-	if (locked_rq) {
-		if (locked_rq != src_rq)
-			switch_rq_lock(locked_rq, src_rq);
-	} else {
-		raw_spin_rq_lock(src_rq);
-	}
+	locked_rq = kf_switch_rq_lock(src_rq, &flags);
 
 	p_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
@@ -9838,13 +9853,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	p_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
 	dispatched = true;
 out:
-	if (locked_rq) {
-		if (locked_rq != p_rq)
-			switch_rq_lock(p_rq, locked_rq);
-	} else {
-		scx_rq_lock_drop(p_rq);
-		raw_spin_rq_unlock_irqrestore(p_rq, flags);
-	}
+	kf_restore_rq_lock(p_rq, locked_rq, flags);
 
 	kit->cursor.flags &= ~(__SCX_DSQ_ITER_HAS_SLICE |
 			       __SCX_DSQ_ITER_HAS_VTIME);
-- 
2.56.0

