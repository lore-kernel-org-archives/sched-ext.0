Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AE387596;
	Fri, 10 Apr 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802652; cv=none; b=LMXNejk4Ii3uXaHDiSv/pIbco8WqAbKdP2hjLIHIfY3dSJCVWkSu9cqBC4g+LFhKhQ/JmfbWL1RYzaY5qFNDy5aky8rqoYaztna39PelhfWkRvn4X0Ngu0YeTJJVjXAh3FCnt3EpXZtrl0gabc/5+9NukVHVW7czUDHR7El3yiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802652; c=relaxed/simple;
	bh=wwTWEve23351kQWGbuGSsk90vkUmH5J9EsH/zBQiwVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wkqi9/+o7vPRe1avj+mGeR2sHOKAY2yVCh2Dtk7wM92lZ7bkOOSxfzj02ghzvPA9Lg7IMsbLiFH+ohBeeieWEs/BME+p9w7q7nrtPpuo0FVe0D2sX1i7KatI7BFAS1hmtxNl8AcNcuTllMGumMLuVGjGHFwjtlnzvKlulLq3MUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq/nPwls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq/nPwls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03557C19421;
	Fri, 10 Apr 2026 06:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802652;
	bh=wwTWEve23351kQWGbuGSsk90vkUmH5J9EsH/zBQiwVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bq/nPwlsD84gWtbfvCZNYkQ5y7tKB4eoH0PDPhXMtIM/EjKWB98hbwYdowgXRx8BC
	 wk1Y9YyJNp4uQSB/WiOfQYcrJFVZLtHXpsJxXON/wCHsP0QZ8GSy5cqA+33oy8lueb
	 E0BuUm0rDkfYH+z3l5QjWM3YJgoenx4uWG+KiqJlG20kLv4pBMov5FgLXYAneUZU0I
	 90jANUUnQtE9IK+QkBYcSe3sXpyjDBez/v/KtAoF96QNgi5Rwx4pu4U8Gp1mHhnD63
	 DhbG5pJtkzOmBroz1LwYKE6tlv1lfuX6cpbY5i2dtQM7vAZbP4Mjg6sOTNNgW2wg7E
	 B1TvmCsTt5yMA==
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
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] sched_ext: Fix ops.cgroup_move() invocation kf_mask and rq tracking
Date: Thu,  9 Apr 2026 20:30:40 -1000
Message-ID: <20260410063046.3556100-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ca0085903e0..f7db8822a544 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4397,7 +4397,7 @@ void scx_cgroup_move_task(struct task_struct *p)
 	 */
 	if (SCX_HAS_OP(sch, cgroup_move) &&
 	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(sch, SCX_KF_UNLOCKED, cgroup_move, NULL,
+		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
-- 
2.53.0

