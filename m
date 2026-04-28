Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39E31F989;
	Tue, 28 Apr 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408552; cv=none; b=V3bzqLDskpcWKv8qYTb5InF4b6O0Nox4Cyf+4cxd/YYHecpsAdurIK21GehYgmiqZjNM2j6aEsPgPnRVjNsQc85QnvvH49CgOs4yiyhRfiGvYPSS1udySHI6GLunHXNWpx6Gv5dRDJcNSjUGzfVbSm84/DZ2eGFIWjMB+edG2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408552; c=relaxed/simple;
	bh=vvUHe5YrFjOtIc9INLDVF7VvPv0dmTltER9fEzlIAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyJW7QpIBMSTqJ7BQ3eRIiaj+BZlNLDz16I0XKULNO8HfGAlZiFjWNrdenyatkmBTKoX/gHF+moJRgmCs1VdXOEG0riwQ8WM3820ZXdPM81vdkPYRF3OtkctrAsA5hhhEU5DRod/cgcxSxaWbtxIRszwtu4GsvMUZaGzyHPhXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGv4zivc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGv4zivc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B1C2BCAF;
	Tue, 28 Apr 2026 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408552;
	bh=vvUHe5YrFjOtIc9INLDVF7VvPv0dmTltER9fEzlIAx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGv4zivczwW5UGoD4q27Y2ccH8tl343f9LShZVEEDG046+o0CObvD4iP8Oo+o7osY
	 7IX0SonswOKxguHCrQV/jbO0WjAqIU+iCYtqI+LCSJcCRVoNHEUPljbJkpQ1c8S0rp
	 7EGrsox1bkcn2YDy7Uzle8DUMH7ver4w7wF6jsNFwO6jZ/0EMN3V6y4PpVs85hz6dJ
	 tAH3twXgaXMLImcYwd1KTtW4EO8u/Q/NUDKn1uubMUEeUSSKR5+PHq9rZ5nRvvU/xg
	 vIJG2lfvhqeQsDLENZhCKymrPY77dwFruHTJuGhL/CjtUaa/ErySrdvaw68ViB/unQ
	 cgGwi+IKsLB7w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 05/17] sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
Date: Tue, 28 Apr 2026 10:35:33 -1000
Message-ID: <20260428203545.181052-6-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
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
index e9cf9d8f4626..b197da2b960d 100644
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
index d4960df23da4..919d4aa08656 100644
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
2.54.0

