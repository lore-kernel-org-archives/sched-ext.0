Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705127;
	b=oWkxk951zVyV1oRGEie28J3LfmJC3zaesYWI7Z8+2h+MVu11SDyS/5lRzZjwmIXtz4/w
	 H1s3W57K7DZPN8N8QuwS063RNkth0eWyqNIb4VjXu6Bz9UC+CCHmPluzWHSL7feqQTu5K
	 WHMisTeZ7h5FVKZ1rS2TwTdTgjaSUeeaybu+LGM98tk+2ltwHF0gq3t/CDD/Rt13xIHgP
	 64Zb6V7JB2HJCv2EPosLevbWfm2nyAWOjTTi8U0GEfKk9VtmUwn1pZ4yoNUFbaAKVsn8V
	 gzYAW4io85ixUNUwcuFhHBFr0NKsdm9ZxwyBnzLAeYdH9RtHtfRoWvml06WYBOBP9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FTwfkk/Q//CAkzJCUUOhDlo8wTREH1aKJhFO5+w5zqk=;
	b=4MSxjHepCCcKRVOxnjBnHQ0WL7szrZiU+M0s8Mqzk10iiyyy65GOZhxrj3p5DqiaQCgF
	 UfEpfaN63iWm6jP6NSjlrX26+UGgaFNvQl35SKf3u9l4qTMGY2uqc9oZfZgrvI2lqgQFj
	 7z2iATzKp9z1e3mWcB31bps8XIvojsjAHrybYn5mv/Vcgu3fmvYyQ8xvijPcXYbje3GaZ
	 y5hVm3Ny0ZtrPlJUTpUy8OdmBQY5ehsIXmNi7uJJGmdnaSoC3r46DqHdfIa+J1Kj/59tB
	 drWyKjvvp07psCX8HrItKZZNz8XDgfb5gUTrF4yij2U6yhvBsLcsVNX8rssntWNlcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6tgbd3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF4606A331;
	Thu, 22 Oct 2026 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6tgbd3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825841F031E9;
	Thu, 22 Oct 2026 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705126;
	bh=FTwfkk/Q//CAkzJCUUOhDlo8wTREH1aKJhFO5+w5zqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6tgbd3aEiPykx+vfOpNHMsDrEv5TMibIJZtO0U+8UaASDszo+59XtfeJDfXxyZRw
	 bFsz61xV/+iOQVksfDNMH7IAQO5UOpHPC2kPoNj8/uL9EIY91QzlaiI1Dsp5i4N2sp
	 UxGYdl4Sio8XCWK1ocw/Km4dD/lsNF9xJaJA8ANmQl4sIBGWlwdHhLXBlgZzNTro1J
	 umknYyhxequ7AcFveOOdDv9UQMxxKEJXxgS2qvekt98kQahPY/Tbv/R9/uclGZnsjR
	 0PR33Wo3xCpQUcwnD5Z0FBk6/21HYb7tCgQvqXp7niWt0BGwDBHaoDqnVwMREWuaoy
	 5pxmqHn3QDSWg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/14] sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
Date: Thu, 22 Oct 2026 11:38:31 -1000
Message-ID: <20261022213836.2259069-10-tj@kernel.org>
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
index a35be2c5b453..f462d84c9b72 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3591,6 +3591,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			 (rq->scx.flags & SCX_RQ_PROXY_PENDING);
 	bool proxy_block = rq->scx.flags & SCX_RQ_PROXY_BLOCKING;
 	bool rescue_keep = false;
+	bool going_idle = !proxy_put && next &&
+			  sched_class_above(&ext_sched_class, next->sched_class);
 
 	rq->scx.flags &= ~SCX_RQ_PROXY_PENDING;
 
@@ -3696,25 +3698,28 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

