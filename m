Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BE299A87;
	Fri, 24 Apr 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994347; cv=none; b=AWtWfFnLlnooLwNO0Z7sKlhIUxJKCpJjyE1eP9xQRUq0QfeRu1SeJlR8/2HnTUI4LcVtBdqacgN4s/a33QP0OqWJrb4/t1lC+bc9+JX7O8S4xbSRpNz4aKkgVh9ARn4JG0AnCxhvXMWiN4SbOb51sYtmah3mtKiWRk5qa7gUF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994347; c=relaxed/simple;
	bh=r+Z8r8lWQGuoXh/Em8sBvlC+zdcTZBI4barR4wIwdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxFDhYQCslaQVrL+6VEslcXwlmG77mfiipWWP4tRT4K8yDxSVwJqF2bLpVtaFlaNKT1ZpZldzBN4jNxyCAoH4UELUSPYsYme0+vXNHx/G+i0QUlYts28qXHq0c0r4V1kBeZJcroBQ6RpRJyb/NwVc/oX/Kw6MfoFjyH4wt/9DBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y50hvECc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y50hvECc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF7C2BCB3;
	Fri, 24 Apr 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994347;
	bh=r+Z8r8lWQGuoXh/Em8sBvlC+zdcTZBI4barR4wIwdUc=;
	h=From:To:Cc:Subject:Date:From;
	b=Y50hvECcIqn4Hd2hjkIWBHQKYSC/apkW0RkTMaONXfugjfMiwEo+eGu+V6usO1540
	 IjhaWGr3GE0pqeIqieBRRU1k+jwgVBAGOaIgDnMjTaDtaYLL63v5yPvdgxmD4bq0uP
	 pTvLsC/4wkKmWbuN2TawTdO2APUYWJrBkXxHLNlVkb9+udcNft1B44WwmMTrYt39nT
	 evDwz60A3a6qIgQxc8qZ64QEAsntNmKB0DWIzmlyJJKppRcKgtFqwfZumN/SQGj+mt
	 NWidYxEhzxuStG8nQSNPwGObiboFmaJpHF+It89Q0yBM2/K9OgTdTuEu/rhAnpGoXE
	 jpYxeMjQjpMaw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/17] sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
Date: Thu, 23 Apr 2026 15:32:08 -1000
Message-ID: <20260424013220.2923402-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpu_acquire and cpu_release are deprecated and slated for removal. Move
their declarations to the end of struct sched_ext_ops so an upcoming
cid-form struct (sched_ext_ops_cid) can omit them entirely without
disturbing the offsets of the shared fields.

Switch the two SCX_HAS_OP() callers for these ops to direct field checks
since the relocated ops sit outside the SCX_OPI_END range covered by the
has_op bitmap.

scx_kf_allow_flags[] auto-sizes to the highest used SCX_OP_IDX, so
SCX_OP_IDX(cpu_release) moving to a higher index just enlarges the
sparse array; the lookup logic is unchanged.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c          |  4 +--
 kernel/sched/ext_internal.h | 54 ++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a94e621d2c6c..ad255268f207 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2814,7 +2814,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * core. This callback complements ->cpu_release(), which is
 		 * emitted in switch_class().
 		 */
-		if (SCX_HAS_OP(sch, cpu_acquire))
+		if (sch->ops.cpu_acquire)
 			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
 		rq->scx.cpu_released = false;
 	}
@@ -2960,7 +2960,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	 *  next time that balance_one() is invoked.
 	 */
 	if (!rq->scx.cpu_released) {
-		if (SCX_HAS_OP(sch, cpu_release)) {
+		if (sch->ops.cpu_release) {
 			struct scx_cpu_release_args args = {
 				.reason = preempt_reason_from_class(next_class),
 				.task = next,
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index fb1a555faaaa..dee7f7e2a2ca 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -523,28 +523,6 @@ struct sched_ext_ops {
 	 */
 	void (*update_idle)(s32 cpu, bool idle);
 
-	/**
-	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
-	 * @cpu: The CPU being acquired by the BPF scheduler.
-	 * @args: Acquire arguments, see the struct definition.
-	 *
-	 * A CPU that was previously released from the BPF scheduler is now once
-	 * again under its control.
-	 */
-	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
-
-	/**
-	 * @cpu_release: A CPU is taken away from the BPF scheduler
-	 * @cpu: The CPU being released by the BPF scheduler.
-	 * @args: Release arguments, see the struct definition.
-	 *
-	 * The specified CPU is no longer under the control of the BPF
-	 * scheduler. This could be because it was preempted by a higher
-	 * priority sched_class, though there may be other reasons as well. The
-	 * caller should consult @args->reason to determine the cause.
-	 */
-	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
-
 	/**
 	 * @init_task: Initialize a task to run in a BPF scheduler
 	 * @p: task to initialize for BPF scheduling
@@ -835,6 +813,38 @@ struct sched_ext_ops {
 
 	/* internal use only, must be NULL */
 	void __rcu *priv;
+
+	/*
+	 * Deprecated callbacks. Kept at the end of the struct so the cid-form
+	 * struct (sched_ext_ops_cid) can omit them without affecting the
+	 * shared field offsets. Use SCX_ENQ_IMMED instead. Sitting past
+	 * SCX_OPI_END means has_op doesn't cover them, so SCX_HAS_OP() cannot
+	 * be used; callers must test sch->ops.cpu_acquire / cpu_release
+	 * directly.
+	 */
+
+	/**
+	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
+	 * @cpu: The CPU being acquired by the BPF scheduler.
+	 * @args: Acquire arguments, see the struct definition.
+	 *
+	 * A CPU that was previously released from the BPF scheduler is now once
+	 * again under its control. Deprecated; use SCX_ENQ_IMMED instead.
+	 */
+	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
+
+	/**
+	 * @cpu_release: A CPU is taken away from the BPF scheduler
+	 * @cpu: The CPU being released by the BPF scheduler.
+	 * @args: Release arguments, see the struct definition.
+	 *
+	 * The specified CPU is no longer under the control of the BPF
+	 * scheduler. This could be because it was preempted by a higher
+	 * priority sched_class, though there may be other reasons as well. The
+	 * caller should consult @args->reason to determine the cause.
+	 * Deprecated; use SCX_ENQ_IMMED instead.
+	 */
+	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 };
 
 enum scx_opi {
-- 
2.53.0

