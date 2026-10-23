Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778177;
	b=WGhqKhebPxMOPz3bimR5J7J7GwTvqafk4oUDxz26z7QHj8681D43dX2Hvn0c6HV0ENQY
	 KjXjDWX7hWO4wUhBqGF/xzY8dhDjAoRERKvKUT4Rer6BOX3O13usklGCZKti+fU17gafo
	 wkx6AvCg69cDyqHLqC9Pki3SHS64Di6c9gohcZDulM6bKdQUXqy3bCwQPzBpSXSlNYTAX
	 Zs8HSeCOMJpeErgAxl3BCh3WF4RShm+uLVBmYj/4GX39hZG/AjvII3wtc8pZ4p+C1vTmS
	 qWy/pYCluHueUdbNfCYZ8BAj4da0wfP+IvaUeLcgjZqYmVkjPyMFQhVD9QVn8fRJ0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gioI6WIJoaDhcNURvIji0/KKA3c7CI7XGmtExiV/vDg=;
	b=o9riTdvKmObTiaau6A9kj5eljR90jB8Gy/SfcxrCHG3NbEyncYsRvjJOAwlTarlyAmxv
	 kSF36xWts/tbAB5coAwHX4JVFVH4/ZEkHadeczpPurOKjmGAFS46bt1rllkq1sDpwV4I2
	 zfhTVavLgC7Ap4L8MIqB9XHNG6aYOLA6PWsSajK8wm3OUzyjAz5IDSVAhY7QKywyFs3BQ
	 /OiRv3hpXLlNCjmRXucI/oGP5NslL5LeUU9TsXmzCssT3f+LUijd3U5jEndDb4/NlpRQK
	 0hMR95/8zVUoFSbjoFQQ6KnP4WQQwOgzyOWYk+wtYXTSndcZ7MsvTqImacdNp/w+nBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTNI954;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F8606A322;
	Fri, 23 Oct 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZTNI954
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911641F031E6;
	Fri, 23 Oct 2026 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778176;
	bh=gioI6WIJoaDhcNURvIji0/KKA3c7CI7XGmtExiV/vDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZTNI954ThTaAkqKzLkMmHL0hlXIahPxl2DrEofT02g+2xSy87VqFB+jf4bEpZNG8
	 mC9/JMmzMKgJOa2zsCWqV+stea1um6PEXIpMAJYy7wO5dlVUPvYtU31619aKs4oYdl
	 1lWv36zjlWq5C2N/kQQ7G0GFFCoPp5Bot3+wYD9MnfOljm/qeC2PlaHp5NkjqSrdqE
	 JdS6wDyC0znbdU5bYMMf9X/bQ+gEr655hNsXYshokReKLUHPjfmg2MmPMIE1PMUCQH
	 vyC23fKJgfv5Mf3Q1WjBtY2YC7cjd+Kdb3gaPHaP39xw+QQbNhn+TvtRARSqFnGX/g
	 VQD8TpQKJYnIA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/17] sched_ext: Restore a rescuee's slice after ops.stopping()
Date: Fri, 23 Oct 2026 07:55:58 -1000
Message-ID: <20261023175608.4120910-8-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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

The slice end in the same block moves with it, which changes nothing for a
protected task. Its slice is the unserved remainder, and scx_rescue_charge()
ends the protection in the same update_curr_scx() call that zeroes the
slice, so the block never sees a protected task in either position.

v2: The description no longer says that a protected task's protection
outlasts ops.stopping().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 70bc76ed4aa0..a9961dc33af0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3565,17 +3565,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
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
@@ -3588,6 +3577,18 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -3612,12 +3613,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

