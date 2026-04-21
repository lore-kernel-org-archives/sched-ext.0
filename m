Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7238758F;
	Tue, 21 Apr 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755991; cv=none; b=Pje+rL/9lkWYKIp6iEA7q0yYmswuR7BGQ+zMfjmSX1ae2thI9Xdd/59DAgtUXHUFpvreXJEedoC59ZL88aV0lnY45nS2yZiYc+pJdWKbFxh2seZvN8nqmSJOeJ/kzQRI7c4Ww0ww2ViB9+2JXrJlh4kequkbWcH5BSjVCLbpwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755991; c=relaxed/simple;
	bh=9OhS0wahMkQc6SaS2l2XMc3go9xdXg9IC/SYIfR5rB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJtlG2NIbF4aTbFj7Ozy98+BNmoQbMIghINGuhmwc2oJz8XztCcTUkStMtjypXd6oXDwLedFaH/EvS7SXHyxs/eTOWY+TUew2SvJCeyHSVzMt97cZV95mAjsF6MR3f5kY5T+5XRwz7n1tIk6TNX7WTgE+8/1m/amV9VHBZcMSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHWKGA0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHWKGA0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A7C2BCB0;
	Tue, 21 Apr 2026 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755991;
	bh=9OhS0wahMkQc6SaS2l2XMc3go9xdXg9IC/SYIfR5rB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHWKGA0USmMgYuJLIzMsWc0B6Vp4Rgt8035EP/7fFFfhyMBj0+y9NkiCogYMzqg70
	 Q7uzBt3RQ4/ZTtJBzs9W1foWyAATuyQWwgjLdX7N3IP1RVHSRIWG6Jld8ABKsug/dM
	 Fu6UodWtMLjR/XT7tZuTONjZvNFO4WOKuYocAkoJRy++snQvteTMs3hyW64kU3whW7
	 bc6y0JS/2eErAmqA+JXAoSGc+W2EPfpv4i3+cczSkeuDAsYWivX1m7PyaBF1YOzCrv
	 8DskWPcR54EN6WCiTxjRltBGW8B10pDr/aV7R5UaIdUZY/kjGNVKD1/CH/L+VETFpY
	 oJ5lZjy4iYTJw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/16] sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
Date: Mon, 20 Apr 2026 21:19:33 -1000
Message-ID: <20260421071945.3110084-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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
---
 kernel/sched/ext.c          |  4 +--
 kernel/sched/ext_internal.h | 54 ++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9e802d73f205..74e4271e44e9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2813,7 +2813,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * core. This callback complements ->cpu_release(), which is
 		 * emitted in switch_class().
 		 */
-		if (SCX_HAS_OP(sch, cpu_acquire))
+		if (sch->ops.cpu_acquire)
 			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
 		rq->scx.cpu_released = false;
 	}
@@ -2959,7 +2959,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	 *  next time that balance_one() is invoked.
 	 */
 	if (!rq->scx.cpu_released) {
-		if (SCX_HAS_OP(sch, cpu_release)) {
+		if (sch->ops.cpu_release) {
 			struct scx_cpu_release_args args = {
 				.reason = preempt_reason_from_class(next_class),
 				.task = next,
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 350b84876b2a..1d73fcc19aaf 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -555,28 +555,6 @@ struct sched_ext_ops {
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
@@ -867,6 +845,38 @@ struct sched_ext_ops {
 
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

