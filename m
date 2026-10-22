Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705123;
	b=pYpo9cHXL2e3cIJkJql6YiUuASDDigDHLoERSxANXApo/zira8WGK+K1dJhLBm0qUy1Z
	 K2sfW/3vdm8YS9BfsJ8lI0FmYva1xklJluuhYIAJ6u5DQ7b2sJXSms9jIkJFTZ+mkGXFw
	 pbbDMo0YDWJ9gSMGGbHv8qHkFGb3CGnhBipbymX+ODp7j6kh7DohsLEUVOMkkSEFlAwNm
	 spUvQq86ok5PmYZ5SzwxH6uBybnb6vZnzocE1NhrEzWge0MX0ayCSuBR8OqfYa4i04nuL
	 YUSWSm79+wcCjd5jZ/w9/BFV9gwdMtxLGQTPDms21XrD0FV4jYNqdZDrseHdOdM8RUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FftEjJeFJ/W17MfTGrQ7oYkwpecy2Hl+HZ5sm8SFOJA=;
	b=DQ00hNONkVMNJLz/9nGOAcQg6BnaSNSMOtpYxyBwl9W8Q1lteJ/kn+xhWilZ3jsqNhZG
	 3N+UmZ6a9kjT7uw5ew9O0ovGo9swTmoL5EAJuYCfizP/Zc6XCvzYbOUpQfKVpuaanGECx
	 dEe+CnwWNa9M45X9Jw0XRgchSgKf2M+JDFGXZwDRWjDSdK1wH9R2Krxr5uEAgb0qqPGAE
	 yPabxZgSfxQCDs8I2pjZ9kt1sj8/pu9l2Rew8eqIabDUkJLjc2cTBfNq7aT0cy0gV9g4f
	 xhbfXes7qiTvVzjdHAbFfxQ+6G1oqwQLo+ShTupQKUnco+2wJEm56e1QRFT1ZVLCwmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWqElFPz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD9606A329;
	Thu, 22 Oct 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWqElFPz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E81F031E1;
	Thu, 22 Oct 2026 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705122;
	bh=FftEjJeFJ/W17MfTGrQ7oYkwpecy2Hl+HZ5sm8SFOJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWqElFPzFDgmKSqPs24o6Isr37m+KfJtlH0VTBgGXPDc4AyhzAYGeuL4ueMe+sA9j
	 MpxvY1R/vDi5qPoPsws4Hb2O2/AEZibrNu+9+e7P7v89HUMXJYBKlvY2hZOcdBspCY
	 auHHSbBBKR7d0Az+aacgecJYZxslurpy7ID3AzFDMGRdaCaHJIOWnq1qTpIp9Tj60h
	 kfMCLaqDM7wBoDR276Wm/8b+ZNe87u6UAlhVPCJsuUyJ/iEoY17/8iUaVP4J7dcc0R
	 sQfYiy4CyU9oGmalS9bKvDu1AL4GevWv+9sHCIErZJuUBfgssU/2K2ppxq28gNqmGA
	 GB2OMyUm6gZ/w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/14] sched_ext: Restore a rescuee's slice after ops.stopping()
Date: Thu, 22 Oct 2026 11:38:27 -1000
Message-ID: <20261022213836.2259069-6-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_prev_task_scx() restores a preempted rescuee's unserved slice through
scx_rescue_keep() before it calls ops.stopping(). A rescuee whose slice the
scheduler zeroes there is left to the reinsert instead:

 1. ops.stopping() zeroes the rescuee's slice
 2. the reinsert condition special-cases the rescuee and keeps it on the
    local DSQ with a zero slice
 3. the pick's default refill supplies a slice, or the task runs on a zero
    slice until the tick when its scheduler lacks BASE

Move the keep after the stopping call so that scx_rescue_keep() restores the
remainder whether a preemption or ops.stopping() zeroed the slice, and drop
the special case from the reinsert condition as a rescuee reaching it always
has a slice. A rescuee whose slice ops.stopping() zeroed now goes to the
tail of the local DSQ with its remainder restored, behind what the scheduler
wanted to run first, instead of staying at the head on a zero slice.

The slice end in the same block moves with it, so a protected task's
protection outlasts ops.stopping() and a slice write from there is refused.
The scheduler has to be able to handle the refusal anyway, as a write on a
protected task is refused whenever it is made, and ops.stopping() is too
late to extend a slice as the next task is already picked by the time it
runs.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 065ecdf3e3bf..4b976beb2f6d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3558,17 +3558,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	update_curr_scx(rq);
 
-	/*
-	 * If the slice is consumed, protection ends with it. A rescuee
-	 * preempted beforehand keeps going, see scx_rescue_keep().
-	 */
-	if (!p->scx.slice) {
-		if (unlikely(p == scx_rescuee(rq)))
-			rescue_keep = scx_rescue_keep(rq, p);
-		if (!rescue_keep)
-			scx_task_slice_ended(rq, p);
-	}
-
 	/*
 	 * Preserve the running session when proxy execution refreshes the same
 	 * donor around an execution-context switch on this rq.
@@ -3581,6 +3570,18 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
+	/*
+	 * If the slice is consumed, protection ends with it. A rescuee keeps
+	 * going when a preemption or ops.stopping() zeroed its slice, see
+	 * scx_rescue_keep().
+	 */
+	if (!p->scx.slice) {
+		if (unlikely(p == scx_rescuee(rq)))
+			rescue_keep = scx_rescue_keep(rq, p);
+		if (!rescue_keep)
+			scx_task_slice_ended(rq, p);
+	}
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		if (proxy_block)
 			goto switch_class;
@@ -3605,12 +3606,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * The exception is an IMMED donor put by proxy_resched_idle():
 		 * the CPU isn't busy, proxy resolution is only retrying through
 		 * idle, so keep the donor where it can be picked again.
-		 *
-		 * An open rescue must keep @p on the local DSQ even if the
-		 * scheduler zeroed the slice in ops.stopping() above.
 		 */
-		if ((p->scx.slice || unlikely(p == scx_rescuee(rq))) &&
-		    !scx_bypassing(sch, cpu_of(rq))) {
+		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
 			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-- 
2.56.0

