Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733103;
	b=SO1EiPnhSG7BGyco8r8VRpVUFzA5YM6efc3u5VrczdpYJWjShAcC1qMv/tusr7RLQ0a9
	 GezGQwpgusXaJQXiKd2LT/vi3OQjMtNGlG1TbAg9LIBteDMkzfzRUIc0IPioVNxpvk8Eo
	 X34eFrsNTFd22BkUPTLW4auaxNsVPyMsELH/zrHdnyndBHi6Y308626ya76cfjtr3YjQi
	 aR5DHD4JxHOQ2FTwJqodAB2P5b7J3KUDqiM+OJyJwN7EYGa9HYLv9VdmTfjZSY1KXpoxs
	 wtGy9v1XdAPRg0Ji80bHFpH40aV7eSMR9wSZYRY0bDEbsmE5Rf9FGvVSJtnU/BknMyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NdfdIDkYAlD1K1U/MPC/6OAvrbjyEtKQ858LOlS3Jaw=;
	b=ryJRasiMnxSEykMHNWlY4+pjl0xaTXbs9aBYWHV2Y6hI4EfGKA0/xkN7OUsjkOJwL04S
	 GueVYBgva/Ud88rjEthWR0RCByGkrZ6HoLjuOqfnDq/ZyTDufzbTcyN07SHP0e7NPSVGm
	 fGhj/sYSeC7Wx05t+YWpnQ1c5koEfeW1y3ou6HQGg5n/l5Jd5Gmaa+2/Q9m7RN/71Wy9y
	 Dyg1deI5OsLZ1yBaqOpJfEODtI6ndkCD9U61hO1XXTA+0vKtC+hGYpD/bbjlNHrGP5Mvp
	 oZWMsI9ZqYBS0EGY1HgnVY49QOeNlGzVamIFi+YF/ezQJe2i7xbBcyPb49LlTQPbVow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQIv1feO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F932606A336;
	Fri, 23 Oct 2026 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQIv1feO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5D71F031E7;
	Fri, 23 Oct 2026 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733103;
	bh=NdfdIDkYAlD1K1U/MPC/6OAvrbjyEtKQ858LOlS3Jaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQIv1feOJMoCsbnAE/J73oJrzSUnmwE+eV8UrLy5s7ZihR61C5H8f96cZFquGbFK1
	 ocmm3pjSQc52nFIbB7WTE2JteyJqjsET12NcGZUVrSdbOOFzrShe3ikC/QOWrE/guy
	 03Qu7akv/68ZokjPdrzIly0dq0+qBTsRWmqmLroOphKEg+RYqnmOCtbMB6MsFjm+eY
	 QMd6sdq+NfRkpbnWWcdzrTj1DWyt8O4IZMrl5mofvW4lI2HSRFlcd14QYy6Jefrbh0
	 RtVlmGfAeZryOC6N1H42OVPfpd6gJBo1zxgchv0R+/IvU+vGCZnyDxq5NDc9cwdUhZ
	 s776ZjkyVy3bA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/15] sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
Date: Thu, 22 Oct 2026 19:24:46 -1000
Message-ID: <20261023052452.2889061-10-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023052452.2889061-1-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
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

Reschedule after either insert. The following patch makes the plain insert
the common path for bypassed tasks under rescue.

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3ca150154a3e..2e8596a74188 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3599,6 +3599,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
 	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
+	bool going_idle = !proxy_put && next &&
+			  sched_class_above(&ext_sched_class, next->sched_class);
 
 	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
 
@@ -3704,25 +3706,28 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

