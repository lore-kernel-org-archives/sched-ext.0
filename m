Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3D3E3D8F;
	Fri, 10 Apr 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843513; cv=none; b=M1Gwu2oPWSjtFzp1hZQ/93AUiCMPjsVJ6xvCmJcPYpIcZLVWb81humpRy1GQFpPS/rGXKM7sPnVRn4wbeL7ualJR37W1QDMNQGMOJH/cuJ3iksuHFNNe//Gsa0r5CYaFo7q3IE1DG6dtoBbwNW9k6pwQzFhsagfqQqXslV9fcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843513; c=relaxed/simple;
	bh=dnshkJHrDT6+ocuIgSvanFIJ9X5ULt7HscFxTBzy+bY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gKt6+ldAt8IqIkG9nKL7oDO8sdApuIVNwrH2PzZI7t8aBOLjNi301eNysJDFqhX5HM4vs9517AOwjkqCIXVzQg/jcp+7pJSWf8O+aDz6/G0H3AQMC+D+TMF/zWu3/BcCA41y3OIIqBNFwS+y99hKwM1FEHhKWjVdQ2ycv+kFidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSjFIbD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSjFIbD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C602EC19421;
	Fri, 10 Apr 2026 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775843512;
	bh=dnshkJHrDT6+ocuIgSvanFIJ9X5ULt7HscFxTBzy+bY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSjFIbD1LXwQKj51tvszZLmS7M7OI9KoP/nlwN6Wo9lyKXWPMP3DLcd1T5w9ZG+ZT
	 lOf7Ec0KGH4g0EDx63lM/JyRgNvR3WfGMlM4x0qS+44Xqf8fYvhbs9jxQfeBt6Rxga
	 i7qcz/wvdweRfc5b5JiX5PsnQDdCFcTAsmhbTy2yQJlBbopkQ1h9hXG7IzbFGYhYxm
	 Pwq9/npmImn4U5tPKfMTvxm/KMSd+dobbsHgAWMf3r+h9WAGDoEFC1CiPGIgrqZGch
	 wUYTM+YyD7royrd1Qhw1Mq+SuuxI0eKiF29KbpSpwAHsaYbl/7Kkd7qgCB+aLyakGh
	 8FgRCKKt+7trw==
Date: Fri, 10 Apr 2026 07:51:52 -1000
Message-ID: <8299992f6b7f07447f47c4cb29ca78fe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] sched_ext: Fix ops.cgroup_move() invocation
 kf_mask and rq tracking
In-Reply-To: <20260410063046.3556100-5-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

sched_move_task() invokes ops.cgroup_move() inside task_rq_lock(tsk), so
@p's rq lock is held. The SCX_CALL_OP_TASK invocation mislabels this:

  - kf_mask = SCX_KF_UNLOCKED (== 0), claiming no lock is held.
  - rq = NULL, so update_locked_rq() doesn't run and scx_locked_rq()
    returns NULL.

Switch to SCX_KF_REST and pass task_rq(p), matching ops.set_cpumask()
from set_cpus_allowed_scx().

Three effects:

  - scx_bpf_task_cgroup() becomes callable (was rejected by
    scx_kf_allowed(__SCX_KF_RQ_LOCKED)). Safe; rq lock is held.

  - scx_bpf_dsq_move() is now rejected (was allowed via the unlocked
    branch). Calling it while holding an unrelated task's rq lock is
    risky; rejection is correct.

  - scx_bpf_select_cpu_*() previously took the unlocked branch in
    select_cpu_from_kfunc() and called task_rq_lock(p, &rf), which
    would deadlock against the already-held pi_lock. Now it takes the
    locked-rq branch and is rejected with -EPERM via the existing
    kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE) check. Latent
    deadlock fix.

No in-tree scheduler is known to call any of these from ops.cgroup_move().

v2: Add Fixes: tag (Andrea Righi).

Fixes: 18853ba782be ("sched_ext: Track currently locked rq")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4397,7 +4397,7 @@ void scx_cgroup_move_task(struct task_st
 	 */
 	if (SCX_HAS_OP(sch, cgroup_move) &&
 	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(sch, SCX_KF_UNLOCKED, cgroup_move, NULL,
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
