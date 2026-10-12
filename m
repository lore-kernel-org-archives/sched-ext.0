Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5174E0B73
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839276; cv=none; b=ZfPI5x8Kv0QM8f6UUK838H/DtdBql3rxcsUaH/sQK09zAQXscHJhlDxyf2ajrpnk6QduJ5A/SjUZ8oMLXQsBSEau91If7Be+x6u2hpyzcUZgAk/nCm+7oo/zyCkYNgAQmxzaxkxjvdrRxfY+domlQoxnaSfW9pORNBXGT4WFad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839276; c=relaxed/simple;
	bh=2iGJa1pRiVOXDM67nmTfy4VDeqP8cmUx/xWfbwxMNUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCbuhYvkkuqkhgZEx+pO9MxCeGeBKxOkID1SDJ/DHycJKJgRnujeVvAW9PizAignmtR8je3h4otlA3mG7SaaP4JkrGxGo51PurNwEXwpPr7OV+AZBZZHwshcL59dnqTRkRfQEsTPWY/8D4atTUfDBhyKIit8DQuanKoZfA2Egxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMXBbRSS; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMXBbRSS"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso18692785e9.0
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791839273; x=1792444073; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1rYrNeMFCmb08SKOQ3NwME5dyCsxgu8ZWcr1xM3xV0=;
        b=QMXBbRSSwjLLFf5Ncz+kTb6w+m7XNHYdotExKuU4RYcrT+3wdyOu8w0zs0qK5VckXU
         ZzVlmCqgDhq1oSVGO2MK+JLxLV7JQFuvvWWbSYC6kCi/eUseDLTJx4n4CImdFVyvZHUo
         vClNbSImUfLvUUgRDyBvHXXTGZ8Lz931HwGAiNPQ0zIzcpGoe3E7W3P6Xs9bBqXvCVY2
         4XU0B8Ai1ii0eYiztG6hc+TVYCbKf3bsQ1tKp4DVIu9sgc4TP+eEKW2CW8EFXZtiWqOL
         r11Oy08kzpCCM52+tnHUjPgRJsWpOXa8Jj/NDAO3RCZA3XPJbvjbNo7QedNZ40Dw1xih
         rLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839273; x=1792444073;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1rYrNeMFCmb08SKOQ3NwME5dyCsxgu8ZWcr1xM3xV0=;
        b=LXk9SgN1f+ReKjMffyirxI5bAxqACvolAvsFkeHxqn1NG3xWVqkS5rAXGR+S/pP24Z
         LuctAMq415HymHxEtINnHwpvKEIlUp1/dJyXLMJsKKqF7LCS7iL4+NBocw8IKbPUEuzu
         FCwfdeHu0+zcS2su2AJf8zSthFjeo1896pqfDat6tk0bx13nHr8GRZucumnf1QeFZIQ9
         IWN8QNy57RNS12DJhdsuUn88H53QRrKRm7x9Xl6QGfy9rqLyohir1Sy5XivThAVtFBK5
         3f6aPrjubcLfmUE3IN/ySzKsfKsFKMu9SuTXtXZsk4kt3C2EN2x5hHldnFPQVXJfajZT
         zzKA==
X-Forwarded-Encrypted: i=1; AKwUvBz+O9sWvOxz3CDxx9K0BWVX/DvXFOxyIUwuc3j7+NAOB1nEdZBF69DI7yqXlpLu1YaxM4bLim6GEyg=@lists.linux.dev
X-Gm-Message-State: AFq9FYIvTJ3y5HjVKiqRsoax8pDL51FWdbRCjHO82/e128dz4FWNvskN
	IpYV+h0MKAvJGERPJU9qyVMc02bOIRUJc381Y4kMwSznca6z9nNuCPT0+9V5u0TvgH4gdalFdRA
	3YcVpgS43HzNmzg==
X-Received: from wmgb17.prod.google.com ([2002:a05:600c:1511:b0:4a1:989a:a866])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id 5b1f17b1804b1-4a18e49d633mr193168105e9.7.1791839272782;
 Mon, 12 Oct 2026 14:07:52 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:07:46 +0000
In-Reply-To: <20261012210749.2955291-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261012210749.2955291-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012210749.2955291-3-jpiecuch@google.com>
Subject: [PATCH 2/2] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving
 tasks off DSQs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A task can be found on a non-local DSQ while the CPU which dispatched it
is still running ops.dequeue() and hasn't cleared SCX_OPSS_DISPATCHING.
The DSQ consume and move paths don't wait for the dispatch to finish and
can operate on the task concurrently with the dispatcher.

Call scx_wait_dispatching() in scx_move_local_task_to_local_dsq(),
unlink_dsq_and_switch_rq_lock() and move_task_between_dsqs() before they
operate on the task. In scx_move_local_task_to_local_dsq(), wait before
scx_resolve_local_dsq() as it may update p->scx.flags.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Fixes: cb86607ada73 ("sched_ext: Don't run ops.dequeue() with a DSQ lock held")
Cc: stable@vger.kernel.org # v7.1+
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index acfeadf5503d..d2a69dfda9cc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2407,11 +2407,14 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
 				      u64 enq_flags, struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
+	struct scx_dispatch_q *dst_dsq;
 
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	scx_wait_dispatching(p);
+
+	dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		dsq_insert_head(dst_dsq, p);
@@ -2591,8 +2594,13 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 	switch_rq_lock(locked_rq, src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
-	return likely(p->scx.holding_cpu == cpu) &&
-		!WARN_ON_ONCE(src_rq != task_rq(p));
+	if (likely(p->scx.holding_cpu == cpu) &&
+	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		scx_wait_dispatching(p);
+		return true;
+	}
+
+	return false;
 }
 
 static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
@@ -2635,6 +2643,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(src_rq);
 
+	scx_wait_dispatching(p);
+
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-- 
2.56.0.385.gd3acb90ef8-goog

