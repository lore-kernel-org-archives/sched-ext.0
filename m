Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4F3ADB89
	for <sched-ext@lists.linux.dev>; Sat,  3 Oct 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791028402; cv=none; b=Xn+KA/SHS22Pe+Cg+aDo42rGpkU+SjR4XWWwo56bp0OCwxx6kVhRsyTOmQyHgO/jWNMejRaRoW1MKi5PVIp+h3gDA/Oly9JHHrMkZFQgHmOAN+0UY6MGgSN9SBruL0LvhRFz/EzT4lGlI8Mu33hkDRPl8T2YxCgyRTQo80Bd2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791028402; c=relaxed/simple;
	bh=jTZGWmb6VcxfCgGcuWMPXfcEnRpMmniFwWEtbVf0ElM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kY/jY3+c7hc6j/p3G1lkflVWb/Sl2sItv6mRzU3Xx0wPuz98h7grzVD2SNEdIZpaiU6F8xUDIV5kc3Gmdjg7nUnHhq6uUIPA87HbN/y4T6BlUPiQLUQ+c6yK0ggq9oEZetaydKrcuZj3Vz31VZXzYlKoXZVCPUkLri0G+7iDtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADOYSyQs; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADOYSyQs"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49fcd86b8d3so5195685e9.3
        for <sched-ext@lists.linux.dev>; Sat, 03 Oct 2026 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791028399; x=1791633199; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEvcNGC805Yog8asIJdN4QxxjqxMzRIw0qtLJ9yXclk=;
        b=ADOYSyQs7Jwuoe7wZJ3U0blpCpl3XOvfJs6t5+Oht6Is3T0N7/e/E1aOHqXkO9PDC1
         1BqGkQIOf/Zxvf8lW4zv52tI+x+xYJKUvEND7VB2ulkR7GttriGylj4QapqgnxaPc4Hb
         XSCsu/MxK1sU4U9KmK2EJAoKD7JdPeuunWbf8I7mHhlXxLEYUWDI+TKkRY6TuNsi5SlU
         rXFwA6I7s/4GmcYQpzC4MC8tiEI/QUhhsxUxjSNp7me1yGyqr1ZcbUGApE6VdAcScaTv
         bHIWHfG/Xpz9KYzf+YqlPpxaYUKSIesrdE3GjRsynVd2WVqmEcO3FUASWpaDFJfUTK1/
         EzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791028399; x=1791633199;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEvcNGC805Yog8asIJdN4QxxjqxMzRIw0qtLJ9yXclk=;
        b=VJNPTa9n/aK2jcBlv6QXWYq7yIHL7dttTF9AQwDlMbIF0Val6ehbiwTb9Y9e/V0iDH
         SaIa9HBVwtPaR8sYKB4F/hys8PCNT+OYHn2T5aOqqQXg1QO0Z43E5OBPA84EUZBZnqqH
         OfzpOXsyW76aCOWuipoNfskb4bQL1G39rEVJeV0N7zbPtQZsvOIXTZBIfTL8OmeJnyZ9
         tu/UTbxsb8js5RRqU6CRQz3fuFyk4C7uzkmfez/ODbjjXNC/u1HNHfmouIogkPCWCA9T
         UwXfagyJFLrs7BElaa1k0C97U+MQouIcabQznJJNeFpaF97JUVuuupogZ6b+5bsx7pwk
         wMwg==
X-Forwarded-Encrypted: i=1; AKwUvByAuVKKTc8tLqyqTqIiS8BmkOBlbOgk9WrwXryBwZFrMsCy6AyKtqaPkuBSLKDXP4ChTg/2V56rv44=@lists.linux.dev
X-Gm-Message-State: AFuF++m9M9jf0IU7L35EwlF4CPeX0HTSLTs+tICJgZsBKOBcJBEd2NfB
	VRT2PycDujg6IhvhngbG2QTXeS2kpsQzQidSFzwmyWxASYu31sS/YYt583S2z3d5cOr7cLeby7f
	J/RCh2ND5glzAYg==
X-Received: from wmpm32.prod.google.com ([2002:a05:600c:920:b0:4a1:6843:aebc])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d20:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a0276affa3mr107157025e9.30.1791028399266;
 Sat, 03 Oct 2026 04:53:19 -0700 (PDT)
Date: Sat,  3 Oct 2026 11:53:17 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003115317.43001-1-jpiecuch@google.com>
Subject: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Generate qseq from a
 per-task counter
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

finish_dispatch() uses the qseq embedded in p->scx.ops_state to tell
whether the QUEUED instance of a task it's about to claim is the one
scx_bpf_dsq_insert() saw. qseq is generated from rq->scx.ops_qseq, but
the counters of different rqs are independent, so if a task is dequeued
and re-enqueued on a different rq between scx_bpf_dsq_insert() and
finish_dispatch(), the new QUEUED instance can end up with the same
qseq as the old one:

  CPU X                          CPU Z
  -----                          -----
                                 enqueue p on rq A, qseq = N
  ops.dispatch()
    scx_bpf_dsq_insert(p)
      records qseq N
                                 sched_setaffinity(p)
                                   dequeue p from rq A
                                   enqueue p on rq B, qseq = N
  finish_dispatch(p, N)
    qseq matches, p is claimed

The claim itself is still atomic so the core stays consistent, but an
insert issued for a previous QUEUED instance gets applied to a new one
which the BPF scheduler has just received through ops.enqueue(). This
breaks the guarantee that dispatches targeting a stale instance are
ignored.

Generate qseq from a per-task counter, p->scx.ops_qseq, instead so that
consecutive QUEUED instances of a task never share a qseq regardless of
which rq they're on. The counter is only updated in
scx_do_enqueue_task() with the task's rq locked, so no additional
synchronization is needed, and it fits in an existing hole in struct
sched_ext_entity on 64bit. Remove the now unused rq->scx.ops_qseq.

Never generate qseq 0. NONE and DISPATCHING don't carry a qseq, so
scx_bpf_dsq_insert() on a task in either state records 0. With a
per-task counter, every task's first QUEUED instance would otherwise get
qseq 0 and could be claimed by such an insert. Wrap the counter where
the QSEQ field wraps so that it can't reach a value that shifts to 0 on
32bit either.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
v2:
 - Wrap the counter where the QSEQ field wraps instead of looping to
   skip 0 (Tejun).

v1: https://lore.kernel.org/all/20261002205242.3820674-1-jpiecuch@google.com/

 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext/ext.c      | 16 ++++++++++++----
 kernel/sched/ext/internal.h |  5 +++++
 kernel/sched/sched.h        |  1 -
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a983..36c04797436c 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -207,6 +207,7 @@ struct sched_ext_entity {
 	s32			holding_cpu;
 	s32			selected_cpu;
 	s32			runnable_cpu;	/* cpu @p is runnable on, -1 if not */
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e56c3c95018f..5acb5c325b5e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2057,8 +2057,16 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
 		goto global;
 
-	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
-	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+	/*
+	 * DSQ bypass didn't trigger, enqueue on the BPF scheduler.
+	 * Brand this QUEUED instance with a fresh per-task qseq.
+	 * Wrap the counter where the QSEQ sub-field of ops_state wraps
+	 * and skip 0 as that's what scx_bpf_dsq_insert() records
+	 * for a task in NONE or DISPATCHING.
+	 */
+	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
+			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
+	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
@@ -6947,9 +6955,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	seq_buf_init(&ns, buf, avail);
 
 	dump_newline(&ns);
-	scx_dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+	scx_dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ksync=%lu",
 		      cpu, rq->scx.nr_running, rq->scx.flags, rq->scx.cpu_released,
-		      rq->scx.ops_qseq, rq->scx.kick_sync);
+		      rq->scx.kick_sync);
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1df8f583b0ec..5b37faa532d6 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1998,6 +1998,11 @@ enum scx_ops_state {
 	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
 	 * on the task being dispatched.
 	 *
+	 * QSEQ is generated from the per-task p->scx.ops_qseq counter so that
+	 * it doesn't repeat across QUEUED instances of the same task even if
+	 * the task moves between rqs. 0 is never used as a valid QSEQ since
+	 * NONE and DISPATCHING map to this value.
+	 *
 	 * As some 32bit archs can't do 64bit store_release/load_acquire,
 	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
 	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..37df14377516 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -816,7 +816,6 @@ struct scx_rq {
 #endif
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
-	unsigned long		ops_qseq;
 	/* both stashed across the activate_task() in move_remote_task_to_local_dsq() */
 	u64			remote_activate_enq_flags;
 	struct scx_sched	*remote_activate_sch;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

