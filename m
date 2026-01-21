Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81E3B531C;
	Wed, 21 Jan 2026 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037109; cv=none; b=TvOIBJ7U7CaFazsTVZN50R1STWh0ja5G+r7HMP7hpPg6SO1S+og+31P+SsO7//17MLClxLVd4QW7ossssNNJmlxq5e3/M8iu06IPEqQ0c+BJOmFP119N91ASucj05lSC0n/wV1Tlg7sl08oMPMSMP6ukbkUO6K9XWe2ppwE1grI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037109; c=relaxed/simple;
	bh=B26XvVYwHwuA6dvKdNc4FFEC6SpD4rQPwa5McMm3bo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp+VCwPaHaSX1780Xre9USvv5s6bzpM+0FkPxgnFfSn+FFzSRpxCGSIBfEalPoTriocSAvwPlaf1toBXc4wDv0UcajCqsHAgNSVtHocCc+crg5aQKKqi5ZJzIz9i2aNO60wmJsfS4QgUNbrpSX0RJTgFjbq1m0oFRlYLsWuBm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POYqfcWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POYqfcWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B15C16AAE;
	Wed, 21 Jan 2026 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037107;
	bh=B26XvVYwHwuA6dvKdNc4FFEC6SpD4rQPwa5McMm3bo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POYqfcWcToDq3qZCFtLXGjRK0z5EVvlqCIe7WBJtbYzdJy++eXzAR6xgDtvD9RsS1
	 3wUn4zcL/awfAR5cAeQ5x9bnT9KoUH0SaTZz7rt7fq4z8YzwbWYmBEA5/pMmkw7eXp
	 pHayWCNMykRNvk3iN5HRPIQs42SKiRwiy7uCnWrzAGeYNFh92G6GxtR75Tzr2aBkfQ
	 ooHrDp28wENzfphIEheeypYhPxJpgQ+9csd9vJZw/cClidn5Apur5f1czL6d6LjxXq
	 Y2KW1d9qaUTs9jFACY/q6YbMxu09phlmqOVUlETf1hpu+RHgZ96bshaTain0A/VsVE
	 CgRTG7ve++uFg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/34] sched_ext: Reorganize enable/disable path for multi-scheduler support
Date: Wed, 21 Jan 2026 13:11:12 -1000
Message-ID: <20260121231140.832332-7-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, reorganize the enable and
disable paths to make scheduler instances explicit. Extract
scx_root_disable() from scx_disable_workfn(). Rename scx_enable() to
scx_root_enable(). Change scx_disable() to take @sch parameter and only
queue disable_work if scx_claim_exit() succeeds for consistency. Move
exit_kind validation into scx_claim_exit(). The sysrq handler now prints a
message when no scheduler is loaded.

These changes don't materially affect user-visible behavior.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 73 ++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e61af4b0961c..c501ce2ca5f2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3094,8 +3094,8 @@ void sched_ext_dead(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
 
 	/*
-	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
-	 * transitions can't race us. Disable ops for @p.
+	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -4246,24 +4246,12 @@ static void free_kick_syncs(void)
 	}
 }
 
-static void scx_disable_workfn(struct kthread_work *work)
+static void scx_root_disable(struct scx_sched *sch)
 {
-	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	int kind, cpu;
-
-	kind = atomic_read(&sch->exit_kind);
-	while (true) {
-		if (kind == SCX_EXIT_DONE)	/* already disabled? */
-			return;
-		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
-		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
-			break;
-	}
-	ei->kind = kind;
-	ei->reason = scx_exit_reason(ei->kind);
+	int cpu;
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
@@ -4398,6 +4386,9 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
 
+	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
+		kind = SCX_EXIT_ERROR;
+
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
@@ -4410,20 +4401,30 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	return true;
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static void scx_disable_workfn(struct kthread_work *work)
 {
-	struct scx_sched *sch;
+	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
+	struct scx_exit_info *ei = sch->exit_info;
+	int kind;
 
-	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
-		kind = SCX_EXIT_ERROR;
+	kind = atomic_read(&sch->exit_kind);
+	while (true) {
+		if (kind == SCX_EXIT_DONE)	/* already disabled? */
+			return;
+		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
+		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
+			break;
+	}
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
 
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
-	if (sch) {
-		scx_claim_exit(sch, kind);
+	scx_root_disable(sch);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+{
+	if (scx_claim_exit(sch, kind))
 		kthread_queue_work(sch->helper, &sch->disable_work);
-	}
-	rcu_read_unlock();
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -4927,13 +4928,13 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	return 0;
 }
 
-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
-	int i, cpu, ret;
+	s32 i, cpu, ret;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
 			   cpu_possible_mask)) {
@@ -5180,7 +5181,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * Flush scx_disable_work to ensure that error is reported before init
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
-	scx_error(sch, "scx_enable() failed (%d)", ret);
+	scx_error(sch, "scx_root_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
 	return 0;
 }
@@ -5312,7 +5313,7 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_enable(kdata, link);
+	return scx_root_enable(kdata, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
@@ -5320,7 +5321,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = ops->priv;
 
-	scx_disable(SCX_EXIT_UNREG);
+	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
 	kobject_put(&sch->kobj);
 }
@@ -5448,7 +5449,15 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 static void sysrq_handle_sched_ext_reset(u8 key)
 {
-	scx_disable(SCX_EXIT_SYSRQ);
+	struct scx_sched *sch;
+
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_disable(sch, SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF schedulers not loaded\n");
+	rcu_read_unlock();
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
-- 
2.52.0

