Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060277;
	b=QIIXsr3ycyEWd/svS04hqBRL8yzSDcyJzdkE195kxpo20Ng4Wx+3yJZqz7QfYtozcpn+
	 9AUG7rbWWa1C81v8qSKduOseaEAnNE+vII0o7nyXIeijxw7jS5cEnM/xAzGeGyHqFhxYN
	 +ywhRxX/Kr0WEmZhFPXrml9mNIBnKixclkX32WjlFFhLP7uJYgvPjusFDUCfIx9F7/R7O
	 yhRUF5GfwhtfUJaB2/6D2BkhZ4j5HwpAp1iPOIqgGaDR+YXE450HAvM8Id7eF97raxuvW
	 91FawwRJcPaeR2wM+SxSIzA1BBNwjFrniQbeYPcKESQl+Y/7iNqC0RNW2TkEiE9WOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gm/jin2UUvSZWV0rVrZQPJxaxPUqsgo6ygitKXiWgHM=;
	b=dPlD4LIZs7c6p9Q6EgRIjytiPhnXtwthhDV3nAOPFB2ul/SH9La2CrVg5M5LI2YbIqXu
	 n/fEhH1vaPV+AUowTOBvrJ9wqQVigYsNWygN8w/ZwzgYYtCbALk97pJKFSRdLv8YG9XOF
	 8eHS5Puq+RjZ00WDfL8JsKtMWoLZx34ZVmibs7ntx+6goYNkMtV3NMnA5DrTR4RKR+c33
	 gbqatyX3Tf3zLS6E9f2LpX6+6g6y8U12FVE+aTAk6RjSDNnW0kHVzHOfU9+40di0ERpur
	 FFLRfcNBZ+dHtPgGPra4V21lMPIKnJ3LQ6vmzZQipts7NVYP9FqIfaoxlHqt4Ool1Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XywggdhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046E606A33F;
	Tue, 27 Oct 2026 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XywggdhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E011F031E0;
	Tue, 27 Oct 2026 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060277;
	bh=Gm/jin2UUvSZWV0rVrZQPJxaxPUqsgo6ygitKXiWgHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XywggdhVFbjxKY7BZT0LxhmWCv7qT1r14vxmA2kI8xEkrRBNBb3fV+OpYL8GJLJLe
	 amol26N8O1y/53/dbcgCzM6glrhcQ0ZmQHMjOm+ARX4meNmKAMWA4egsxyZn4a7iBn
	 FyzSdgTBwWkIAJvFExObQSJrhQa+/mVpM5rRi9qs0hcd8LRvOskXEQz59AfsVaWZab
	 mmMJtEPkomcBiMrDMpG17RutKBNYfZFduPjOuV2DVx21etFRCJMJxUUZkt4ZJtZq//
	 umIpkcO8dGEC77FDcP61k5UFI5OErGyGAoIsHvtPfxxus7f2gyno/Ougj7hcwlA+vg
	 X/m7dFm2LekWA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/18] sched_ext: Restore a rescuee's slice after ops.stopping()
Date: Mon, 26 Oct 2026 14:17:38 -1000
Message-ID: <20261027001749.1821379-8-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
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
index 42a349aa2987..406571afc9d8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3617,17 +3617,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
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
@@ -3640,6 +3629,18 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -3664,12 +3665,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

