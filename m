Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D92C027E;
	Tue, 10 Mar 2026 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105417; cv=none; b=kzpaOQ004JsRdJV1yBeIuAIwfGAGPc+husFtNDYujuI5uTRv4A0+a1KJFwB0CV+vM/VOyZd1J69s6pWuC3KcwiUQXhhvSo2QRA107vY8G0dTlFm8IfR776UYW1bhiC8CimA6Pha+O3iMjiyiQXc5jMAUkVgK+oFZgPCDmONwfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105417; c=relaxed/simple;
	bh=XKzOOjd0NJiRZucgPZ9DNMc5eA1TyoA72zfUlu7LWAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il54wg8gXJ/6yHWkGfezIEjU7oQPsgoKtyPyFgDBOunN51eAtoLqvWXv/RHf5NHTbn9LVSJkNe7YGGAQTW6JdJORIPJDyVvYEAN4tMkCyAZG2fjXaB+9T74w4BJCXBdBjgTces7ptzs9ErAJs64vwsPrlAog6qv1Of3nu9apSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYvcmUKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYvcmUKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F95C4CEF7;
	Tue, 10 Mar 2026 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105417;
	bh=XKzOOjd0NJiRZucgPZ9DNMc5eA1TyoA72zfUlu7LWAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYvcmUKHB+wqeHe6f6QOvTS2EqWH5ylXHs1VSiJyoVivEaMdro9+sS6PLbrZyMjhQ
	 1cLU01HEy8X8yU4FaeT/MvGdqCM0Q3TS8/T7+rRagfz4lEjmnWORWM8/pYuPISfxr0
	 XNI6qVMYGc9ops3LsMgiPyaHkV5ztAFPbTL5SpoXglVcgkC43Y/vv3tzAaV2Q/lhYo
	 glX60MifVDfjKfqLmIzS/zxEw5QYi/u6QsPjpiTHFXceIDSQWPD1qbZA5DSAaD44VJ
	 zsO++splvZirjvMMipABu66lH3v5i3uGdQh1dL7yh7sHPwJBcbcj3ZKIk99w5YCRiC
	 ZWj3ug2mbKFCQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] sched_ext: Add scx_dump_lock and dump_disabled
Date: Mon,  9 Mar 2026 15:16:50 -1000
Message-ID: <20260310011653.2993712-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
References: <20260310011653.2993712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated scx_dump_lock and per-sched dump_disabled flag so that
debug dumping can be safely disabled during sched teardown without
relying on scx_sched_lock. This is a prep for the next patch which
decouples the sysrq dump path from scx_sched_lock to resolve a lock
ordering issue.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 25 ++++++++++++++++++++++---
 kernel/sched/ext_internal.h |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8bf4b51ad0e5..d76a47b782a7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -136,6 +136,8 @@ static DEFINE_RAW_SPINLOCK(scx_exit_bstr_buf_lock);
 static struct scx_bstr_buf scx_exit_bstr_buf;
 
 /* ops debug dump */
+static DEFINE_RAW_SPINLOCK(scx_dump_lock);
+
 struct scx_dump_data {
 	s32			cpu;
 	bool			first;
@@ -5279,6 +5281,17 @@ static void scx_unlink_sched(struct scx_sched *sch)
 	refresh_watchdog();
 }
 
+/*
+ * Called to disable future dumps and wait for in-progress one while disabling
+ * @sch. Once @sch becomes empty during disable, there's no point in dumping it.
+ * This prevents calling dump ops on a dead sch.
+ */
+static void scx_disable_dump(struct scx_sched *sch)
+{
+	guard(raw_spinlock_irqsave)(&scx_dump_lock);
+	sch->dump_disabled = true;
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -5414,6 +5427,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	}
 	scx_task_iter_stop(&sti);
 
+	scx_disable_dump(sch);
+
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -5525,6 +5540,8 @@ static void scx_root_disable(struct scx_sched *sch)
 	}
 	scx_task_iter_stop(&sti);
 
+	scx_disable_dump(sch);
+
 	scx_cgroup_lock();
 	set_cgroup_sched(sch_cgroup(sch), NULL);
 	scx_cgroup_unlock();
@@ -5680,7 +5697,7 @@ static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
 
 #ifdef CONFIG_TRACEPOINTS
 	if (trace_sched_ext_dump_enabled()) {
-		/* protected by scx_dump_state()::dump_lock */
+		/* protected by scx_dump_lock */
 		static char line_buf[SCX_EXIT_MSG_LEN];
 
 		va_start(args, fmt);
@@ -5842,7 +5859,6 @@ static void scx_dump_task(struct scx_sched *sch,
 static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 			   size_t dump_len, bool dump_all_tasks)
 {
-	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
 	struct scx_dump_ctx dctx = {
 		.kind = ei->kind,
@@ -5856,7 +5872,10 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	char *buf;
 	int cpu;
 
-	guard(raw_spinlock_irqsave)(&dump_lock);
+	guard(raw_spinlock_irqsave)(&scx_dump_lock);
+
+	if (sch->dump_disabled)
+		return;
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bec4d22890b0..3623de2c30a1 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1003,6 +1003,7 @@ struct scx_sched {
 	atomic_t		bypass_dsp_enable_depth;
 
 	bool			aborting;
+	bool			dump_disabled;	/* protected by scx_dump_lock */
 	u32			dsp_max_batch;
 	s32			level;
 
-- 
2.53.0

