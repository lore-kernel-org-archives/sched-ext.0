Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AF39A046;
	Wed,  4 Mar 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661687; cv=none; b=HHSjscfnCWEmylXo/5kLpYPYjFChExZl0p3cT1LVy6hHkb2A0V/d5W6EHqGVkZjM7wcNQ+cQQMlwB0ya/Q2MuOvK28AjW2Puzu1qgWFhrlHFVh+9NzKyz+FA+xLdYv+aZ3SZxvlAkOeuwp6K0RSJtVm2oXzfsVRWhyazqKSkaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661687; c=relaxed/simple;
	bh=gujlPOKoSu8uUNdDQ8vI3Kj+wgIL8N4jV5+5n7MW9Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqnD1yd4VrLSDUOVo8anNsm0T26OKI45TGf8HB1jhoC3kxld0mHaMKsBJ8435RfTSOJe7fNYroHdQLv0hwtp2t8qFmF6A9TgiYmzXO/kDsEBaYdrcoSqVHsCDL25bsbYm/kxcgwpJ9gG53D473lFdA+VflFvT5byciKLXZ9gMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huAQ4LCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huAQ4LCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B84C4CEF7;
	Wed,  4 Mar 2026 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661686;
	bh=gujlPOKoSu8uUNdDQ8vI3Kj+wgIL8N4jV5+5n7MW9Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huAQ4LCvmi9xlaESUMK9b+wcv9tf6EJ8vjGl0tFwGi5qA6IO5J07WXcY3wORMIP7V
	 UxmhTH91BUy1DzeBlT/juy0na9HDz+hTZC4RVbKr3eTyraRRnj7CAObwGhdl1zA4fH
	 rMFAe8G5OTzKn/cBM5yFecFXEZp1C8myc+azAAn3hlawdzI5sBwT1pVZ4BOOjp4XJA
	 bAQLw0yh/898alGVS5enpJ3QAVTYLq3yMTxHQ9zggmFUcgD0BqM0iy6EU0JBhNB7Vu
	 ONs9i+40AemAUwbHa5yoR8k+ytveN5xlstqdr36bJdxVB/coimaNsFjqgFUtjpFTmi
	 QTiJHrdO7TFDQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/34] sched_ext: Reorganize enable/disable path for multi-scheduler support
Date: Wed,  4 Mar 2026 12:00:51 -1000
Message-ID: <20260304220119.4095551-7-tj@kernel.org>
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

In preparation for multiple scheduler support, reorganize the enable and
disable paths to make scheduler instances explicit. Extract
scx_root_disable() from scx_disable_workfn(). Rename scx_enable_workfn()
to scx_root_enable_workfn(). Change scx_disable() to take @sch parameter
and only queue disable_work if scx_claim_exit() succeeds for consistency.
Move exit_kind validation into scx_claim_exit(). The sysrq handler now
prints a message when no scheduler is loaded.

These changes don't materially affect user-visible behavior.

v2: Keep scx_enable() name as-is and only rename the workfn to
    scx_root_enable_workfn(). Change scx_enable() return type to s32.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 78 +++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d1f7de05da04..f1d946749e54 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3267,8 +3267,8 @@ void sched_ext_dead(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
 
 	/*
-	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
-	 * transitions can't race us. Disable ops for @p.
+	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -4430,24 +4430,12 @@ static void free_kick_syncs(void)
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
@@ -4591,6 +4579,9 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
+		kind = SCX_EXIT_ERROR;
+
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
@@ -4603,21 +4594,31 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
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
-		guard(preempt)();
-		scx_claim_exit(sch, kind);
+	scx_root_disable(sch);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+{
+	guard(preempt)();
+	if (scx_claim_exit(sch, kind))
 		kthread_queue_work(sch->helper, &sch->disable_work);
-	}
-	rcu_read_unlock();
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -5135,10 +5136,9 @@ struct scx_enable_cmd {
 	int			ret;
 };
 
-static void scx_enable_workfn(struct kthread_work *work)
+static void scx_root_enable_workfn(struct kthread_work *work)
 {
-	struct scx_enable_cmd *cmd =
-		container_of(work, struct scx_enable_cmd, work);
+	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
 	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
@@ -5387,12 +5387,12 @@ static void scx_enable_workfn(struct kthread_work *work)
 	 * Flush scx_disable_work to ensure that error is reported before init
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
-	scx_error(sch, "scx_enable() failed (%d)", ret);
+	scx_error(sch, "scx_root_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
 	cmd->ret = 0;
 }
 
-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	static struct kthread_worker *helper;
 	static DEFINE_MUTEX(helper_mutex);
@@ -5418,7 +5418,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		mutex_unlock(&helper_mutex);
 	}
 
-	kthread_init_work(&cmd.work, scx_enable_workfn);
+	kthread_init_work(&cmd.work, scx_root_enable_workfn);
 	cmd.ops = ops;
 
 	kthread_queue_work(READ_ONCE(helper), &cmd.work);
@@ -5561,7 +5561,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = ops->priv;
 
-	scx_disable(SCX_EXIT_UNREG);
+	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
 	kobject_put(&sch->kobj);
 }
@@ -5689,7 +5689,15 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
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
2.53.0

