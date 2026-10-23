Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733100;
	b=CcSJ5alxkuj9coZzi9994rCcnc68uXLwZuqosjnLBJB4/PfzysqZRws5K/9UlEFYjrTq
	 5PrmlvgerODG+MX4Kbjn342/M4ZBBRSanc8EwXwtQvD7ApY1LjspwPaLbPX8rClPmHq96
	 PxNUpnS71pu3bAO7R3r7CrUwevOTVqx5X4eIH9fvrB+GH3WGje34u2b/z12yZac8SJzRW
	 /9Fmg5dxg+fG8eWiF2xV3Svb9RDRQHDZEfPP11P4KFltFHrPDjLxYEJm4msIFDItc1rPz
	 p2a1dkot+gl9/8ZFVdKpP4WzVMOnqka0hvLp5SzPlB+BYW13OSXqOD0fQ9hrrtSyRdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UhN+onfnxju2rh6dtJs9mAtp/Y5tK+lXhOeIoKTUMJ0=;
	b=KqVtduA0oGJprzxsQk1566xzvIscgFj5iclLeDMHhQU3ZfFJtm5tn2UuUEjI4G5HlG7H
	 GZosBYcbeuxdrRzis1tLnSmJqxGi2/WWjUF+Ha8g/9pywfljnhzhpKTY4EjkgeeMcrhGZ
	 vMnrX3VGCishdV04PsN6Exc7sdhS7fDXu1fJdHk8gLCG0lJJT40XtG/JNWxu8glw6Jfi/
	 FCr+KrmC2+FWjQ82mXgUwSu0vrdXmuBGwHGiDaN9Ir0d1Y4YDrSYGqx78oOlgIyfJtxrZ
	 DvQpVzwJ2e3B/lo7WOyix440FwkNDuH2yb3dg2kEVN0Rz+YjfgsPy4fEAgHhA9omUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4WxtYRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0E606A322;
	Fri, 23 Oct 2026 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4WxtYRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD081F031E0;
	Fri, 23 Oct 2026 05:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733100;
	bh=UhN+onfnxju2rh6dtJs9mAtp/Y5tK+lXhOeIoKTUMJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4WxtYRJt37ESO3tjLJSx2IMkDflVOA5d3z4mr34Yqc05ER0Fc/dgcV+S1tyYBGht
	 bsnZ2L7DplfNHLl8tvmElPAfQXumPsHmCsVtF1t04Gp0cDvjS7iGDn1Cx7AiANG80b
	 6hEc4pN5eP3cgnUYPuLg9y1XhMnBYNdu/rYT6L7LajoWUM+I09drEC1E4ids76sw/W
	 TrVXlOvvImjbQO7y87rv+h+zLFs5n47U1UenFO34m0uIh/aU6+BjWGHTMDKZvsCDAS
	 H5jsuNxh5TseOW7d+8OUqdUVU939HxuDC7TyglpQJtM8fhSxcpcS/MbPvuxwuUExvL
	 rFlCOV+cbXj8w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/15] sched_ext: Fix a cpu idling with a runnable rescuee
Date: Thu, 22 Oct 2026 19:24:43 -1000
Message-ID: <20261023052452.2889061-7-tj@kernel.org>
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

A scheduler preempts a running rescuee like any other task by zeroing its
slice. The rescue grant survives the preemption. put_prev_task_scx()
restores the unserved remainder through scx_rescue_keep() and queues the
rescuee at the tail of the local DSQ, behind whatever the scheduler wanted
to run first.

That breaks down when the scheduler zeroes the slice but dispatches nothing.
dispatch_one() keeps the previous task running only with slice left or, when
nothing else is runnable, with its scheduler holding SCX_CAP_BASE on the cpu
and not taking the last task through SCX_OPS_ENQ_LAST. A rescuee fails both
once its slice is zeroed if its scheduler lacks BASE there or takes the last
task:

 1. ops.tick() or scx_bpf_task_set_slice() zeroes the rescuee's slice
 2. the pick finds nothing else to run and settles on idle
 3. put_prev_task_scx() restores the remainder and queues the rescuee on the
    local DSQ
 4. nothing reschedules the cpu, as the pick has settled and __schedule()
    clears need_resched right after it

The cpu idles with the rescuee queued until an unrelated wakeup or the
rescue timer's escalation.

Restore the remainder from dispatch_one() too. When nothing else is
runnable, its last keep now keeps the rescuee running on the remainder, so
the pick never settles on idle with a rescuee runnable. put_prev_task_scx()
keeps handling a displaced rescuee, where another task won the pick.

A rescuee that passes the existing keep-last test is kept there instead and
continues as an ordinary task, its rescue ended with the zeroed slice. That
is fine as its scheduler holds SCX_CAP_BASE on the cpu.

The new keep also covers bypassed tasks run under rescue in the following
patches.

v2: The dispatch_one() comment and description now say that a rescuee whose
scheduler holds SCX_CAP_BASE on the cpu passes the keep-last test and
continues as an ordinary task (sashiko).

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 38 +++++++++++++++++++++++++++++++++++---
 kernel/sched/ext/sub.c | 15 ++++++++-------
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4b976beb2f6d..79552a4afd39 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3354,6 +3354,34 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
+
+		/*
+		 * The scheduler preempts a rescuee like any other task by
+		 * zeroing its slice. The grant survives the preemption. The
+		 * rescuee gets the unserved remainder back and runs again
+		 * behind whatever the scheduler wanted to run first.
+		 *
+		 * Two sites restore the remainder. When another task won the
+		 * pick, put_prev_task_scx() restores it and queues the rescuee
+		 * at the tail of the local DSQ.
+		 *
+		 * When nothing else is runnable, the cpu must not go idle with
+		 * the rescuee queued. The keep above takes a rescuee whose
+		 * scheduler holds %SCX_CAP_BASE here and doesn't take the last
+		 * task through %SCX_OPS_ENQ_LAST.
+		 *
+		 * The pick then ends its zeroed slice, and the rescue with it,
+		 * and refills a default slice. The task continues as an
+		 * ordinary one, which is fine as its scheduler holds BASE here.
+		 *
+		 * For any other rescuee, a reinsert from put_prev_task_scx()
+		 * would come after the pick settled on idle. Keep it running on
+		 * the remainder here.
+		 */
+		if (unlikely(prev == scx_rescuee(rq)) && scx_rescue_keep(rq, prev)) {
+			verdict = SCX_DSP_PREV;
+			goto has_tasks;
+		}
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
 	return SCX_DSP_NONE;
@@ -3571,9 +3599,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	}
 
 	/*
-	 * If the slice is consumed, protection ends with it. A rescuee keeps
-	 * going when a preemption or ops.stopping() zeroed its slice, see
-	 * scx_rescue_keep().
+	 * If the slice is consumed, protection ends with it.
+	 *
+	 * A rescuee keeps going when a preemption or ops.stopping() zeroed its
+	 * slice. Here another task won the pick. scx_rescue_keep() restores the
+	 * unserved remainder and the reinsert below queues the rescuee at the
+	 * tail of the local DSQ. When nothing else is runnable, dispatch_one()
+	 * keeps the rescuee running on the remainder instead.
 	 */
 	if (!p->scx.slice) {
 		if (unlikely(p == scx_rescuee(rq)))
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d3db1277118e..63d7876fe577 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -474,16 +474,17 @@ void scx_rescue_end(struct rq *rq)
 }
 
 /**
- * scx_rescue_keep - Keep the rescue going for a preempted-out rescuee
+ * scx_rescue_keep - Keep the rescue going past a zeroed slice
  * @rq: rq @p is running on
- * @p: task under rescue whose slice is exhausted
+ * @p: task under rescue
  *
- * Called from put_prev_task_scx() to decide what an exhausted slice means for
- * the rescuee. scx_rescue_charge() ends the rescue the moment the admitted
+ * Decide what an exhausted slice means for the rescuee. dispatch_one() calls
+ * this when nothing else is runnable and put_prev_task_scx() when another task
+ * won the pick. scx_rescue_charge() ends the rescue the moment the admitted
  * slice is fully served, so arriving here with the rescue still open means @p
- * was preempted. Restore the unserved remainder and return %true - @p stays the
- * rescuee and the caller reinserts it at the tail of the local DSQ, behind
- * whatever preempted the rescuee.
+ * was preempted. Restore the unserved remainder and return %true. @p stays the
+ * rescuee. dispatch_one() keeps it running and put_prev_task_scx() reinserts it
+ * at the tail of the local DSQ, behind whatever preempted the rescuee.
  *
  * Return %false to end the rescue instead - the slice is already fully served,
  * @p is leaving the rq or bypass is dismantling rescues.
-- 
2.56.0

