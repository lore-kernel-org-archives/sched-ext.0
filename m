Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1551C05E
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698657; cv=none; b=MDCteaEJY7fPdf9MFarJ8Oe8e1PpxyZbxaPZ2wY9PeDg80DH6oXkmAe3+gh/M+vA+nxK8dcnrJAma91lH6eFr0yYwmaGmuoyfzMpmeH+X3AMpQjBLDnChOEfYkv/Exez092H3sT5iFkgzta/TQ/DNn6xUfnqsEzMoPCLziB2ASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698657; c=relaxed/simple;
	bh=qJxAG6G8/LvW6p4Ong3UCYruH3W/HI/b/QEEpkkiYHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XZ7EmBrKwQFwnDUBNAKDGaoMwbVwryGGk2k5Kl+oPA+kTuIXmB6fGYZH9YyuQ+drbQjIwJpLEejA8lJj7uPgETV2j4CF5RJf4GUT8KAjD2glIqdb/8FDpvXa6oPMVPJKJo5GC4ktbQPOqqSmvUpXn80fP725J/2kueJb/TeD3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEn+a53e; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEn+a53e"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso40178265e9.3
        for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790698654; x=1791303454; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUg1JPo4dsFZ+2B785rvlA2QB0vfJBtEIvCNiSYWqL4=;
        b=bEn+a53ewFi3oacxv39vHGljHQIkxXI29UGXWJH0bKIp+ZAB5p2XeU9laXkT3zXyQ9
         gTOxtz30aPhyAlrDxp6ljQNyvefN8a4wySVV1A+Gp736tLZCiA2D7UBGnN8jNW4kd5hI
         ++7VcGPylqPzlb3b5PayWtPv7a5L7Z7hQYrTSlTHqTTheLvDwZ/XB3KxZeo0IsijRvl3
         DnqPfpIWxHMnu0/ruQt8GXi5DEnTR/ctFZHBOW55J1zpcX7Cw2HEvv3tE1yxMKSTNIVX
         XVjLyfZWZR4ohkK82mmQfR6pnRUMbk+9SVwDZvz2D/D7JBeR/OpR5iMU7VFpKfZYPy3t
         WzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698654; x=1791303454;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUg1JPo4dsFZ+2B785rvlA2QB0vfJBtEIvCNiSYWqL4=;
        b=zVTCorFHMquaNeibWQ04OsCrXMuv8WtP6KV8h+cTO8b/d+cF69HU0Rr9sn+mTmV+wV
         VxoGn7+Fne43UCgu7HyDm/C/N/fOm1+7PEXX8/9WF40sHxO8PRWoWkcGpqo7h1kl6ieh
         mgpLeiCsV7q93lQQhuGpqrTOBsqlEFloNB0tJWjKIrzPxcyyzvZdc+NiR3HSUK3WPrps
         NKZC0fxcYtnLvUZP9JJg19Cyy8klkKo/wF6bHqkpYEY30twOpt+cBf+1Fu1pXNvTGJLL
         NXdB6MGXbZGcNn1UL0gIDTS99M2sybQliCEyHoTS1W1K8R5JsVU/vwmFlAwkEZpsmWlb
         9hqw==
X-Forwarded-Encrypted: i=1; AKwUvBw9aWgG3PKxwtChsjTIMSv9lNZ46uNaijwY2bZDBZ0cQLliD1ylW4IM4jlCj1nxXbivpIJ4503nhSI=@lists.linux.dev
X-Gm-Message-State: AFuF++nIawCD+upmtXgS9pC1svXH/cNXSHFw3teb0SOJ7UT3ticg1ZJx
	j60ue817K8Rcd61Q84BfHSqAmj2qCHleHek6Eaq6B/ngaf6haZ8QRBl9lRjBF5RbBkpw0M74Yug
	9fZc5ShY3N/c83w==
X-Received: from wmom18.prod.google.com ([2002:a05:600c:4612:b0:4a0:ca2:a388])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr338444905e9.3.1790698653925;
 Tue, 29 Sep 2026 09:17:33 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:17:25 +0000
In-Reply-To: <20260929161730.185271-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929161730.185271-3-jpiecuch@google.com>
Subject: [PATCH 2/3] sched_ext: Call ops.dequeue() when a task arrives on a
 remote local DSQ
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the BPF scheduler moves a task to the local DSQ of a CPU other than
the one whose rq the task is on, e.g. with SCX_DSQ_LOCAL_ON dispatch,
scx_bpf_dsq_move_to_local() or scx_bpf_dsq_move*(), the task is migrated
by move_remote_task_to_local_dsq(). p->scx.sticky_cpu is set across the
migration so that dequeueing the task from the source rq isn't treated as
the task leaving the BPF scheduler's custody.

However, enqueue_task_scx() only clears p->scx.sticky_cpu after
scx_do_enqueue_task() has inserted the task into the destination local
DSQ. task_leave_custody(), called from rq_owned_post_enq() on insertion,
still sees the migration in progress and skips the custody exit. The task
ends up on a terminal DSQ with SCX_TASK_IN_CUSTODY set and without
ops.dequeue() having been called.

The custody exit then happens only when the task is picked for execution,
in set_next_task_scx(), which reports it to the BPF scheduler as
ops.dequeue(SCX_DEQ_CORE_SCHED_EXEC) even though no core-sched pick took
place. If a scheduling property change hits the task while it's waiting
on the local DSQ, the BPF scheduler instead gets
ops.dequeue(SCX_DEQ_SCHED_CHANGE) for a task that has already left its
custody. Both break the ops.dequeue() semantics, under which a dispatch to
a terminal DSQ ends custody with an ops.dequeue() call without special
flags.

Clear p->scx.sticky_cpu before calling scx_do_enqueue_task(). The routing
decision in scx_do_enqueue_task() uses the local copy, and the departure
side is unaffected as p->scx.sticky_cpu is still set across
deactivate_task(). ops.dequeue() is now invoked on the destination rq when
the task is inserted into the local DSQ, as it already is for same-rq
dispatches.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # v7.1+
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ad391a8cbd05..763de7797056 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1501,8 +1501,9 @@ static inline bool task_scx_migrating(struct task_struct *p)
 	/*
 	 * We only need to check sticky_cpu: it is set to the destination
 	 * CPU in move_remote_task_to_local_dsq() before deactivate_task()
-	 * and cleared when the task is enqueued on the destination, so it
-	 * is only non-negative during an internal SCX migration.
+	 * and cleared in enqueue_task_scx() on the destination before @p is
+	 * inserted into the local DSQ, so it is only non-negative while @p
+	 * is in transit between the two rqs.
 	 */
 	return p->scx.sticky_cpu >= 0;
 }
@@ -2189,10 +2190,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	if (rq->scx.nr_running == 1)
 		dl_server_start(&rq->ext_server);
 
-	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+	/*
+	 * An SCX-internal migration ends once @p arrives on the destination
+	 * rq. Clear sticky_cpu before enqueueing so that @p leaves the BPF
+	 * scheduler's custody when inserted into the destination local DSQ.
+	 * The local copy in @sticky_cpu is used for routing.
+	 */
+	p->scx.sticky_cpu = -1;
 
-	if (sticky_cpu >= 0)
-		p->scx.sticky_cpu = -1;
+	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

