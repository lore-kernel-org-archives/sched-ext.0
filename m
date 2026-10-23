Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778178;
	b=xt6/E1/eeEujE28xywz86+4L/n4JtXAjiOqY93FiXK+dY+/cteBbO6/xOdX22XJsNN32
	 3touyTiaFoVM6t6qEY5NBc/X6fnglA86QUIBrNXBsRM12hq2PIWEuL/8uCqF70q6NxJIY
	 CpaTHfW+/wEOre1kD6jMO1i2A32Mh2s4BrvwCrw17PaGqPsDtuJu84MmSUztVEAcTkmJU
	 DhLJm28Ye98nUzlHU+pq0+cisok7zC7sKhkTfzIsrdCxFkT7eawzCoSn7TLIO8xl7C7jT
	 8/HK5oPPrJw0nAob/m/nG0SDaX11DI2cnIYXNV6ljLGnNs6C/PGomdAAS0QH0HKIUlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8I+YqADEE6SEYnCz+JJg1Bnd3FMUkRM02RFKqlGPjiA=;
	b=u1/o/+ru8V4Kaxpe0W8mr5K2rfi/TC7aGtC4GkrMpEMnIrvOdZdNKEClv2QYVpMO9nwq
	 qEDtdZao9woyW7HglvwcJugycjE+wdjCaNjTcNPH9OgFKnvm2e+v0LcKhN+nOsz9ihAlC
	 VTY/BcVabga25OmHf5KqYSe2WNn2EWkOxig7B4DFQW75I++jGMYlrptXrRzu5LS70sgPK
	 IuC9wZWUPVdTstrUIDMEULlk+dCFQbl/BmapUUNaxNuaFrorDMr1ICWY15PmXEWeph8d+
	 OnlqZyDompnzp0uJ0R3QpKduR17Bw5lyaQFqWLrfixG7YMtnrmAvf5SBamP42NzQ23A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeoVTqCa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E860A2626;
	Fri, 23 Oct 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeoVTqCa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD4B1F031EA;
	Fri, 23 Oct 2026 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778177;
	bh=8I+YqADEE6SEYnCz+JJg1Bnd3FMUkRM02RFKqlGPjiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeoVTqCaIQLu4YXdJhR0efxti069jbzgwW14ap+12UuK7uaKLYF89XHerxgKhBbAA
	 noJV7ShjphbkfUzhOPEcVQ//Sf3mQJxyxnoh4tpsU3RS4UwGJUWeIopEIopqRbZqS0
	 3gOaFtGkysz6lqaZ1KVF3VAGiK1z81d+A9rO9jbJQbHbempzquB2PIWGXLzBhl3Iw8
	 HxIRAid24RQf7DFY++2DCE+dLRRDD9Wz8P0+exaNYDhF+/GoPaBUfkooIme59pqpQQ
	 a+IBEKhV2Xu8Gvlt+labv5JA6dJhScru+XDGEZHmN7UpUWQY5DLiDhptokQgz8HGjz
	 SyUZGulWcq1zA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/17] sched_ext: Fix a cpu idling with a runnable rescuee
Date: Fri, 23 Oct 2026 07:55:59 -1000
Message-ID: <20261023175608.4120910-9-tj@kernel.org>
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
index a9961dc33af0..de3fa7476fec 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3361,6 +3361,34 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
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
@@ -3578,9 +3606,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
index d3f89ec4e4fa..42ac92ecb627 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -480,16 +480,17 @@ void scx_rescue_end(struct rq *rq)
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

