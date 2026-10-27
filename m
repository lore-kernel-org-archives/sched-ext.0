Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060282;
	b=bqiovDikTcssNbJFx3oP/xZzH7jQcNVDoUFQPwSd7Q0w1wA7X8iZJgUtpMhphWu9k7Ii
	 ai7LJVMVtILKzC3lUSt613uqPZkoDnJh98n2fzAqpI0lQ00yBBFIcrc6VEz3aQ6F7h1D4
	 ahYrcsmAlYd9ng3D4+RKYu2nN1kNxMSl3yd+mQqDX/hqdPJXdx3/ozOf0/1C/X85nDZtL
	 iunblVCRs6pZ9hI6lC0AGmX7QZ2Dc3twRMlPIHwEKggI79busbyTaI7NmgwrZccTQaZ9E
	 bmmi187JKAYVvJsqx8jFR0iuDPx/CR1TD2DweMz26H9jPT2Uz66/txV1SmZ2rmuV9ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bkqvKkr23v2Dtys+XrzF5+H2bilwiMUkSe5Xc0wQB98=;
	b=5peNkBAy40TSf7sSx7Q9ikt1ALNBFg1IvaARBUWWXuR1vKdViDzUVq565yayHuBlYg+/
	 DwSTByv2Bha/pHb6xylkidtmGsrS6np4q79lk0oonw76v3vp/5RhC2zUri9xCN4aYi42u
	 aGEWTxc3HXPDnkPFO2/VTQRA6FHiJ7b5dYDCq0CLv2mRbYNRQ55CglWKOflU4YPH5Nbvo
	 4Ei+HghT6ughm/PabteMMBpkhAZG4l7djVA1i9WyrvXUapVIL9aFQpxbLgGf7APbGPhda
	 e1q9inushHShiRcLwkqdmK9Cu852g4k32jNu8FuISZaS2J2uG5yK4EaCrFBBGM8UUmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjQ4ESX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6560A263E;
	Tue, 27 Oct 2026 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjQ4ESX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7C41F031E5;
	Tue, 27 Oct 2026 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060281;
	bh=bkqvKkr23v2Dtys+XrzF5+H2bilwiMUkSe5Xc0wQB98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjQ4ESX2EzLd+XTIGt04i0H3VHpQZUVjMsWi8YHgmY1jvtJGXW2Yj/2hvKsJWeR8n
	 3e5INCdWGNDC41TYmzBwzLuOp88Qg/DXN3b8yihlC09zfG7ZoXVLiPtf68Z95ou6Qr
	 ghR+ylDbIajhHnrm9qq0wGjEE4HZmtyMmPV9YXTYFOu9KnAlf3MOsYcprg00ioGyPb
	 z37zT4gE8vhPl/3LCFBEae/Jp//XEH8lTkHIn7OCKEgkcBM7GPISeW9p9CBs4l6mDN
	 l8bzXy5mUV0P+nipVTLNGwmQBo5yxMhVcDQjDpKlhYbs0lf6lZIBoTaIJb2UwNKog+
	 GVx3mP+EU97BA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/18] sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
Date: Mon, 26 Oct 2026 14:17:42 -1000
Message-ID: <20261027001749.1821379-12-tj@kernel.org>
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

put_prev_task_scx() enqueues a still-runnable task when the pick has settled
on idle. The insert can land the task on the cpu's own local DSQ, and then
the cpu must not go idle over it. 7a9df7667963 ("sched_ext: Fix stall when a
task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ")
reschedules the idle task in that case, but only after the SCX_ENQ_LAST
insert.

The plain insert, taken when the task can't stay on the cpu, can land on the
local DSQ too: rescue can admit a task there when its scheduler lacks
SCX_CAP_BASE on the cpu. Without the resched the cpu idles with the task
queued until an unrelated wakeup or the rescue timer's escalation.

Reschedule after either insert. In the following patches, the plain insert
becomes the common path for bypassed tasks under rescue.

v2: The description's forward reference to the plain insert becoming the
common path no longer names the following patch.

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5308c7443b44..9e503510ba1c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3658,6 +3658,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
 	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
+	bool going_idle = !proxy_put && next &&
+			  sched_class_above(&ext_sched_class, next->sched_class);
 
 	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
 
@@ -3763,25 +3765,28 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * locally runnable and can legitimately go idle with @p still
 		 * runnable (see do_pick_task_scx()).
 		 */
-		if (!proxy_put && next &&
-		    sched_class_above(&ext_sched_class, next->sched_class) &&
-		    scx_task_can_stay_on_cpu(rq, p)) {
+		if (going_idle && scx_task_can_stay_on_cpu(rq, p)) {
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			scx_do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
-
-			/*
-			 * A task put on the local DSQ runs, as anywhere else.
-			 * Here the insert can't reschedule on its own: the pick
-			 * has settled on @next and @p is still curr, so
-			 * resched_curr() would flag @p and __schedule() clears
-			 * that right after the pick. Flag @next instead.
-			 */
-			if (p->scx.dsq == &rq->scx.local_dsq)
-				set_tsk_need_resched(next);
 		} else {
 			scx_do_enqueue_task(rq, p, 0, -1);
 		}
+
+		/*
+		 * @p may be on the local DSQ now. With %SCX_ENQ_LAST the
+		 * scheduler can put the last runnable task there. The plain
+		 * insert runs when @p cannot stay on this cpu, and rescue can
+		 * still admit it here.
+		 *
+		 * The cpu must not go idle with @p queued on its local DSQ. The
+		 * usual resched doesn't work: the pick has settled on @next and
+		 * @p is still curr, so resched_curr() would set need_resched on
+		 * @p, which __schedule() clears right after the pick. Set it on
+		 * @next instead.
+		 */
+		if (going_idle && p->scx.dsq == &rq->scx.local_dsq)
+			set_tsk_need_resched(next);
 	}
 
 switch_class:
-- 
2.56.0

