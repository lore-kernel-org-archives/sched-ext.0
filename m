Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8484219EA;
	Wed, 29 Apr 2026 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486898; cv=none; b=PiSa8SisiB7CrkTCA/yBEG/Ke+5RXbPY28wdQY9O6R0UMQpSV8aZ2AxKYAOIBisOYfeHuCKjANljAO/dMqffVk6YTqcGUXLojuLUKdMQ3yain13SrgPz/sdM/wW72dY7gKzrzSfoQ4Ewg3hzsDKDaeZHmyBBN1tepYIiAcwevBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486898; c=relaxed/simple;
	bh=bI/KlmfLYKo3fJSKS9UG8/EVbZflHaGLSm+mkZwufr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0dvPqK0dmTsZYss+aQi2toWaX6xFq4KGyPNPKOCxs/ykYNNoRUCe45dKJ7Z7LJEgBICYp2SnBxWmyDi7J1ipZ5Xygcypv34jOUt0IsStLK/HxY8MreFO2INklt5VstkzO0ztErOrSqV+LC2EhXHT/4/uLx7QAvd8WOezwc9XjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld9t3Z2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld9t3Z2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A117C19425;
	Wed, 29 Apr 2026 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486898;
	bh=bI/KlmfLYKo3fJSKS9UG8/EVbZflHaGLSm+mkZwufr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld9t3Z2+uvW83uwUK4lAaf/Z/3XZnFalI5rBIuuK5z9/Oj1a67lklp7RTMWdBXAew
	 yrS2/IIj/oWTIAEXL1xJwShxKbrg+xYrixtyQSD44/YdV7abA7aBhgKlXvSVlAvcTg
	 sFeBLklRIz1DYmWU4aGxZeheOsoBgecD6ctWc6zYgKRGMMQYQmxxuryAbm45OptWU7
	 B3m55o7U8pCRTRiBJU9EjdPCkvLuNNYpm5cFoMQUY0DxPs+J//vkrZeZhoJrB/BAt7
	 q30ZUwkV1JryG/jYIW7LegHEMkFTl1bdBPCnCfTlWfCOBEc2IUaC1Ehzc1bWT3XADL
	 0nUF7MQc9+bAg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 05/17] sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
Date: Wed, 29 Apr 2026 08:21:19 -1000
Message-ID: <20260429182131.1780125-6-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
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
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          |  4 +--
 kernel/sched/ext_internal.h | 54 ++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6575b52f4b9d..6bf1418c4237 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2823,7 +2823,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * core. This callback complements ->cpu_release(), which is
 		 * emitted in switch_class().
 		 */
-		if (SCX_HAS_OP(sch, cpu_acquire))
+		if (sch->ops.cpu_acquire)
 			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
 		rq->scx.cpu_released = false;
 	}
@@ -2969,7 +2969,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	 *  next time that balance_one() is invoked.
 	 */
 	if (!rq->scx.cpu_released) {
-		if (SCX_HAS_OP(sch, cpu_release)) {
+		if (sch->ops.cpu_release) {
 			struct scx_cpu_release_args args = {
 				.reason = preempt_reason_from_class(next_class),
 				.task = next,
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 0c55c5481fa5..c6de974eaf48 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -529,28 +529,6 @@ struct sched_ext_ops {
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
@@ -841,6 +819,38 @@ struct sched_ext_ops {
 
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
2.54.0

