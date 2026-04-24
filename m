Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2A372B24
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022667; cv=none; b=r8MRXnTWbf2pO3B3M9663o+rDJ5pbkdJeHlzs7sT9t3spmQ7K5pLWF1C2DRgikXJCo7TE+EHcxxcJXVhgOf9slBRO5UkUo9tAc79baSbrUkbwayYv3ksaOLmZ+VQovtrh4OUrhewZaL6iylrgRMHXQGaWzn126nz9P47mcI+KEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022667; c=relaxed/simple;
	bh=m4wkbucZDqiwRQgCi3C5GP0+GvBJowo+E9lh5+Fard8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kCGcBE9owzB/X0Q0/lABqKnHFzFT37rH8yqwBobJcT3SdfHzeNRdyJ09P4BUADBLQRKKIIBw5tR8kBSLPDN/JuDfBCBEe2l5v8ci7bPRHtVY4+T6EgfPf6TUq3VAod8TnO8RL9/fFTIbL9z9G1RekEWbAP43oLtxPxSlISF7/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBv5mqbi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBv5mqbi"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so58397395e9.3
        for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777022664; x=1777627464; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCnZUBbOFm+NpCPSvShrUcUmnxgANsGzshR4TjOR3Kk=;
        b=NBv5mqbiUEOh454SfWs/MkSX69+y9PrT61EQ4CWSxOO3TfHWYsTIqG1kslZ4KXpiO2
         PC0a3utHzVJq81xLlvSwGFSHqrvxG0ZrGVyCg+52ikku8oM0tMErezNiPorF1Uwc5O6f
         kVJzYxt7ZzR4Nkz/69ng9Ynt/vbtRLGRISIzzDyMHcqoOsAl4ltTlHeEk9d2UJCmmcYq
         YtkyvYBce2JhSdxx+Wy388zPaQ0cu/P4tp0RPFoW+S8FACxQHzmnbnQIv7j69xQpZ7Ye
         z99pl7XsfaZHxp1+tBSrejjXlF2ks6A5ga5r/0d1kYwVsZrfCcDlosFUgPYE90CichjO
         QAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022664; x=1777627464;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCnZUBbOFm+NpCPSvShrUcUmnxgANsGzshR4TjOR3Kk=;
        b=NVV5pG1auXjBE7ZnoFWr0VFrIMpcCot33cPOnnOzO/Wc+nnGoh1XPV0QsEiPliPRZy
         OQFooodV/2zVCnLhwaIejLeBnjE/DbNPttJo0yQ+KiL8Sh0oBKUtt9OVjkjbnWpycE3m
         JHOvBr4wsmFOT8UrjMMva5FZAbWDK5edNFVbqRCIE/k3t7twqcxes/QjC6WyTnSSCd8+
         Oi18Wpro8w4PZSYOWchQmXJQbyjmhzbhz1yEpyumt8n4OMyuMympjYSQn9m35dMZ8el5
         pxpAvn6X0G3CiEchbx1AGoUmNY4MIzuE0gupjZBCU76KBSxh50cPhhCWRamX2M0KD1TS
         Uh+g==
X-Forwarded-Encrypted: i=1; AFNElJ9nNW6sMp1EXfcaVkV3jJZKfCwTWawH/1g+GXdijBxJ3j4pw9VgygzUHcmiZqw8YiFMrth6N2suDmk=@lists.linux.dev
X-Gm-Message-State: AOJu0YytTjONHX37X6qHz2w46/kSV4l7vj7GgRrxY70OTcY544T1/amV
	Z8bh9SgpO4nPULjX87IEeVbr/0+vdFnOONRtAaR2GcAJHT6aND5YV8IXcb7pg+WlpHiLkTWuLKx
	suVHqRt3t9wAldg==
X-Received: from wmtm7.prod.google.com ([2002:a05:600c:c4b7:b0:488:a6d9:e91a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id 5b1f17b1804b1-4891a3a9f38mr194689215e9.26.1777022664577;
 Fri, 24 Apr 2026 02:24:24 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:22:44 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260424092245.3212529-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Call wakeup_preempt() in local_dsq_post_enq()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

There are several edge cases (see linked thread) where an IMMED task
can be left lingering on a local DSQ if an RT task swoops in at the
wrong time. All of these edge cases are due to rq->next_class being idle
even after dispatching a task to rq's local DSQ. We should bump
rq->next_class to &ext_sched_class as soon as we've inserted a task into
the local DSQ.

To optimize the common case of rq->next_class == &ext_sched_class,
only call wakeup_preempt() if rq->next_class is below EXT. If next_class
is EXT or above, wakeup_preempt() is a no-op anyway.

Link: https://lore.kernel.org/all/DHZPHUFXB4N3.2RY28MUEWBNYK@google.com/
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1f670028bf19..034df77e3af1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1393,7 +1393,6 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 			       struct task_struct *p, u64 enq_flags)
 {
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-	bool preempt = false;
 
 	call_task_dequeue(sch, rq, p, 0);
 
@@ -1408,11 +1407,19 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
 		rq->curr->scx.slice = 0;
-		preempt = true;
+		resched_curr(rq);
 	}
 
-	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
-		resched_curr(rq);
+	/*
+	 * If @rq->next_class is currently idle, we need to bump it
+	 * to &ext_sched_class using wakeup_preempt(). Otherwise, if we drop
+	 * the rq lock later in the pick and an RT task wakes up on @rq,
+	 * wakeup_preempt_idle() will be called during RT task wakeup and
+	 * SCX won't have an opportunity to re-enqueue IMMED tasks from @rq's
+	 * local DSQ.
+	 */
+	if (sched_class_above(&ext_sched_class, rq->next_class))
+		wakeup_preempt(rq, p, 0);
 }
 
 static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

