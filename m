Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705124;
	b=ymepUOqGC13QLUR0k+5MhFwS00qoHxFxsgmWe91kPKyVA0Mt+CG9XX6sk+YwzycZGAsY
	 19AhI+flnP4C+vSIr/nfcGAp/HK3JVaU5LQ3NjQrQgD+REDFw4WPkYNGXAITYmEsoS+Ia
	 Vl7mIGUAvXTz+9u5RfTbUQnxenj1Dpgsv7BxYaMjQ7EByS3o9LmxkT6CSQSTKJ79MsAs4
	 /T0mhoWPXDztaVlgmmcrADaZ41If8UHQQ+Pw6Bh9g0eZD+ruofUI1tRkE3oUGdLJFkJCL
	 zTSPRraHjk1aULVCj6d4dI5wEL+d2QCz68XtnF2yejjaK5EZ/q8XOGKg7YzjfPunWJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CFMWau3x523G/OXdmBCHDdMrJAHVni272EgKPmjBESc=;
	b=LjVsOPSDOrD/eTICFNjbzl21oXBKAM3h9EuUkG01gW09s1IJC8FEy/mvyCX+3dzAMPNK
	 IqVJJslhrWkaiskNGU7bH3zFzqr8076nDcxSzv+0KYj6TNQFjnXpJivrn4RWWrHZ96if0
	 K2DUvIvP7CG85F9H/82YXpYXRx/dIzbUdXLsAgR6S9DCTs3YUWEzec0PsKwrCPoPRd271
	 7jGt8pasyBwJxIwU+Ufj4WGrCBWEgyDjxojzXKxgA2xN5OtrKXGhMWyO3+xsMP+FIsW6y
	 KL9/eiJdedtOLPQyk0nTh3MPqZHeyFQpAfv1nNLj0Hk903U3J6O8tnYj1roEhcSom1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjXyxJhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426A606A337;
	Thu, 22 Oct 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjXyxJhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF51F031E2;
	Thu, 22 Oct 2026 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705123;
	bh=CFMWau3x523G/OXdmBCHDdMrJAHVni272EgKPmjBESc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjXyxJhFd13A+jFtlxiXk8qz86vTaYRpBZRTOuI2czU3R+h5Gr8Il1U1vJENFZHLZ
	 uNu5EmZVCC4zxjNM+7r/sIF73R+Vun8hXXkWru5z0a5hADZY8QIg40TEqg3Igdjr91
	 jzFZvQ30F804oYx0i+HC3h04aMDhcqt4ePBJuScR+R43cXWS5/tFz693XYQdQJ++wJ
	 MxI2q7kOHSfxGlhrjqNLjxavs9pJYwZQh8/8BsBSdeiUUU2G7Hn7bw5DUigB9Oc7hu
	 EefgVFcyZznD8YWl2SHIszAtS6Z6OOdnXkM/P5gxpc+55PndmlTkR07CEq9dEJf8/V
	 N32oN6YZX1vzA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/14] sched_ext: Fix a cpu idling with a runnable rescuee
Date: Thu, 22 Oct 2026 11:38:28 -1000
Message-ID: <20261022213836.2259069-7-tj@kernel.org>
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

The new keep also covers bypassed tasks run under rescue in the following
patches.

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 30 +++++++++++++++++++++++++++---
 kernel/sched/ext/sub.c | 15 ++++++++-------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4b976beb2f6d..b68674d7f762 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3354,6 +3354,26 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
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
+		 * the rescuee queued. The keep above declined @prev, and a
+		 * reinsert from put_prev_task_scx() would come after the pick
+		 * settled on idle. Keep @prev running on the remainder here.
+		 */
+		if (unlikely(prev == scx_rescuee(rq)) && scx_rescue_keep(rq, prev)) {
+			verdict = SCX_DSP_PREV;
+			goto has_tasks;
+		}
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
 	return SCX_DSP_NONE;
@@ -3571,9 +3591,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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

