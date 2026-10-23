Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778181;
	b=c8OzUFmdadJ1WRCou1Rtw4dfTm6ux2Xwquk1vaTwZDKo7MTtupOq68VXFg35vJyn/4Ma
	 oCEkbV8jJk4z+C169wb7pSiCjjFb7LVk+ZnL3KRyiVfpZlsUusUbAH1vNRtiBEdRLtqZ/
	 FpQuuJmhRCJsgVH89QIee7etk8XJbR8ETTM+nv/DHNzg2+on4yrio5kOUsRLvujJ2dae3
	 1t0TLwfTxa//8kJHnD6lw3kVrKc/KXBdFAidvGfpRK+PehalubDI/txl/vsRM0qsSLjKq
	 vBgGLSCI6dmxCyWvKZXKKRuq2L9grk3qz39WEAeAg1pP4kNAW0fkWoeIonkm8ZzQ8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z23/XZo8aASqoi1ZJmd8LuMb2eYM/u4/cl3lSNwkFDI=;
	b=gg034Icp2vqKaTpLg+n01oLZ/oWHUyKKufQnatv3BjyvldQcp+al/kxVF2UdTe9mNUkY
	 ciYA8758DiZ29u9hGnxHSo6fJSRE9GWS8oCsd54/JECtZ47jOMq9QqpaSzwoQMsOAU4Kx
	 IIRFDqSB/XvvWhzKqt372CAwv9i3M1/eZFDRoaDPAj+aRFhlw8UeuSNcKSC/7RWjrQKy4
	 BeA2MJVuNZE9R41TLCuKfVtsnxdfnSztAxLxyxcRIB4+KfPas6CJqCUlMKtyyJzC3eJDr
	 6azk00AwirpVxVbvNlI9FfhjzUrQeSY5sWu/s3+7VFfUZI15FctEifaPmoRtCJlh0pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1F5Gwge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663160A3821;
	Fri, 23 Oct 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1F5Gwge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80771F031EA;
	Fri, 23 Oct 2026 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778181;
	bh=z23/XZo8aASqoi1ZJmd8LuMb2eYM/u4/cl3lSNwkFDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1F5GwgeE7oW/JLFL9C5cY03PF1vRie9ftY0jC4Jzz252iITlvtpwZA4b+xKGKJYL
	 gYzuuOzfkVfCBAZu+bLVnDvAvnRrf5Ww74YHmFoMFlU9aHso+CcEqvyO4BEe6FUDwU
	 beGm9TP/YnVUKaQPboBVji8+X10+BRShBYwUaPg4O+/ukJJfa1zDQOcWZIXzC5iPjT
	 02gwG/8UNIO9fJ3WbbzBvFxpdafEKRo3mkScNPwYHkTiDlLsRbmnBQB+scQDZTLrAj
	 dLvZuZ2XZHdTosg+h1kBLOBOMVqN0pJtbLe0FVlCXLdYMI6Z2u0eInWBQniqsYOyCQ
	 sIyYZxMGRFF/w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/17] sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
Date: Fri, 23 Oct 2026 07:56:02 -1000
Message-ID: <20261023175608.4120910-12-tj@kernel.org>
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
index 46f956594448..072153416256 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3606,6 +3606,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
 	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
+	bool going_idle = !proxy_put && next &&
+			  sched_class_above(&ext_sched_class, next->sched_class);
 
 	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
 
@@ -3711,25 +3713,28 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

