Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA092236FD;
	Mon,  1 Jun 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341759; cv=none; b=i5AsySVDDaoaA3Jdh/sierlHnq1PEACErPzikUOHZbCoGLBhdKusU06+DEPFnTUAmwWFRl8Zk1morVLK832oDdesbWC6HCRWk/E4y0GPDguecJjh/VysBOvOwET4UugIZKlWieMNfx5hgCyOAdTTYTArd9D9FPfOwF8A/ibOrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341759; c=relaxed/simple;
	bh=nM/Zq1eHYghQyMKHrCsP29vZ+A4PAXvLH1i4WV/LTzA=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=cJcZ2Zeg0iiYu+dS3bNif8ZMUcCoeDC3kGUTp9xX+YXiNSicCdIcJ8pUW3VmWyQVluWYU2vmofQlfqv22qMYuSL3l4VEtGvvO2kPzUEys9Yu06XqamMrSQytqgHpHePZfGRLtgcGelIJG+WkOuKSSmxHOpLvNCS8IW9fnDaihgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0gjwo86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0gjwo86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA0A1F00893;
	Mon,  1 Jun 2026 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341758;
	bh=IyiLzt81/gUnmt9QT6nkETkQq9mUMw1ylpFY5THXhvY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=n0gjwo86i8/JaKGHksCozf4skKmGPUGNcrV7utqOW81j4jYFzM29/VFZ7WPREHaJ0
	 nhvvw5yVWBi/7s0V2ErlP5+sq1ZGexj+DfFMtSx5i4IJKkcC0ZTsc33z2u/dIyOGmo
	 m7naZIYrZ1+hdgsKCboP9khuFZlerGi8WaOPZfIx+yBGtfsBjyMVaxHnZCbucyGrYt
	 xt8TNc0ls8bJONHx366XQ+5XVLqUbV0kpwYKPw3xdqE9LoU1SP5zxAtQVd6z6PLpps
	 bMIVlHKdTL8+grbJJbYsSMPU6F/W0eBZleznII/9ME7SeCAnj0WmekNqgw6vBcgNRK
	 mNCs5p57uvGNQ==
Date: Mon, 01 Jun 2026 09:22:37 -1000
Message-ID: <fd46c41cbae0ea3194b9d8c1c8efcefc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>,
	kernel-team@cloudflare.com
In-Reply-To: <20260601124156.2205704-1-mfleming@cloudflare.com>
References: <20260601124156.2205704-1-mfleming@cloudflare.com>
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Don't warn on NULL cgrp_moving_from in scx_cgroup_move_task()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

A WARN fires when systemd's user manager writes "+cpu +memory +pids" to
its own subtree_control while a sched_ext scheduler is loaded:

  WARNING: at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
   scx_cgroup_move_task+0xa8/0xb0
   sched_move_task+0x134/0x290
   cpu_cgroup_attach+0x39/0x70
   cgroup_migrate_execute+0x37d/0x450
   cgroup_update_dfl_csses+0x1e3/0x270
   cgroup_subtree_control_write+0x3e7/0x440

scx_cgroup_can_attach() arms cgrp_moving_from only when a task's cpu
cgroup changes. It can still be NULL when scx_cgroup_move_task() runs,
through this sequence:

  Step                               Result
  ---------------------------------  ----------------------------------
  1. cpu enabled on cgroup G         cpu css = A
  2. cpu toggled off then on for G   A killed, B created (same cgroup)
  3. an exiting task keeps A alive   migration skips it, A now stale
  4. +memory migrates G              stale A vs current B pulls cpu in
  5. cpu attach runs for all tasks   hits a live, cpu-unchanged task
  6. scx_cgroup_move_task() on it    cgrp_moving_from NULL -> WARN

The mismatch is that scx_cgroup_can_attach() keys on cgroup identity
while migration drives the move on css identity, so a NULL cgrp_moving_from
here is a legitimate css-only migration, not a missing prep.

The call is already gated on cgrp_moving_from, so just drop the warning.
ops.cgroup_prep_move() and ops.cgroup_move() stay paired.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/all/20260601124156.2205704-1-mfleming@cloudflare.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8b..a1f7698 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4293,11 +4293,13 @@ void scx_cgroup_move_task(struct task_struct *p)
 		return;
 
 	/*
-	 * @p must have ops.cgroup_prep_move() called on it and thus
-	 * cgrp_moving_from set.
+	 * scx_cgroup_can_attach() sets cgrp_moving_from only when the task's
+	 * cgroup changes. Migration keys off css rather than cgroup identity,
+	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
+	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
+	 * keep prep_move and move paired.
 	 */
-	if (SCX_HAS_OP(sch, cgroup_move) &&
-	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
 		SCX_CALL_OP_TASK(sch, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
