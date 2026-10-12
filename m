Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10984D0CD0
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839275; cv=none; b=iGuArphGhO47YaKPrLncRhL0d8H5KaWhTECyR3f+vwueLkTcO3D+8qZntNh3pCuutxMVEmPoVLlA0BRpPWS4Ca1gOcOJyU/tHZpHW6VMh/xi8DTt2LzwYKirqwtpgCaIqSnxpFYh5jPvzzSAcyo3hK/Rv9c7zJUu9G9AZZcqLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839275; c=relaxed/simple;
	bh=hqn5P4L3CZnxjs8yZX9QzNZcOkEwsd2v7845ON8L4oA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uG6FizNWRee4YSszTN25TJUpknYbVI/5BNNfDTXYlPUNSL9FtmP0HCG5gIG1u/I/07kqzu9JdPJ+ITl0Vy65vKNAfH+mnVMQW4uJpdZC/FhM4zoOrMCUAcT495XSv/VCAkxrqX/eZdFXm/6trkuu26jcxKjOxDdz8npADeUU40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTkh0Nxm; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTkh0Nxm"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so18773435e9.2
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791839272; x=1792444072; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nju8hJCq3oU25r3nG8uHzCMNYnVy7/XIFrhD7fzQFSQ=;
        b=MTkh0NxmYI2IGQ6FEj4YALdGc9Y5F1jkxzcHWl45AwZKC+avndEAzNR6zZgAIT5Z8H
         AxKayo4I0uFrCPz+XrFfwN+DAFna9gLbd22B5+IKreU57MrmF5oDHE9qE3m5wjksQyUL
         IbdLphsEyfkOkNq8NvmVlq7PzwLqWnrfjoa6CoEXeHg3iwpZ/xGLDnpMiFy0+IA4tw60
         m0Z9w6268w/WTmIy2Wu3Yuc2TTQPySbxXWvee7lJ95dZyk7ZcX84YbGT/Th2KpM6JS/k
         dKpvrpbrDZXWR1KzEULGdKahLvMx8i89FlwL7ddcXInBLzO8UW/RUs5PECidoLy9HpAM
         0/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839272; x=1792444072;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nju8hJCq3oU25r3nG8uHzCMNYnVy7/XIFrhD7fzQFSQ=;
        b=THiPd47Hijr2X34/CwOxd1L2sxfP/gvV64VB0BL4HmYUscpcQ0WRhSNWvVJnYomzdL
         X7dAdUS6rUKk1RoCHHr+bU5VDOlWPXKtvusRLfZdTyKop5ChrZj34/rZgE2OSvXf6zMQ
         GKEXatb1g68kUqIl68M1lJW+eEDB04TKQKxY0OfyJON4l7vddiFmL1L5dUIc2cU4gSG0
         e07V6bB4idmK6QrZJFmIjOzCFLaz57xudJhEiG+epSNF/vnzpr7iwdAUhWJizDm01M6A
         nhR3tHoSKngEdiSVdU48TrRmCxuQlqv0n/OMWNAN/IUsR9c3p/ltXg8+60rLnVRIVaEQ
         Papg==
X-Forwarded-Encrypted: i=1; AKwUvBz+wykc+wEbzuX0hK3t5uRd0hqaDMINBTsAAjxnuyrZTCHht0viDYY1261UfnHxsXOwNauPMhfGM5o=@lists.linux.dev
X-Gm-Message-State: AFq9FYK3C5NXljMnn6VvGup6/c5LZ+hxstzEci6SRWD0nC/mWIEIMqtA
	XeNm2aVDWKcGyofLP9033kEgMRY4gtERBOLgYvX5C3cKrQ3plhk+LlMY68mMbaO8MDtb+18tVU0
	RB1NZjPTSFmBe6g==
X-Received: from wmbjn2.prod.google.com ([2002:a05:600c:6b02:b0:4a1:8bbb:59bd])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr200521275e9.0.1791839271989;
 Mon, 12 Oct 2026 14:07:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:07:45 +0000
In-Reply-To: <20261012210749.2955291-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261012210749.2955291-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012210749.2955291-2-jpiecuch@google.com>
Subject: [PATCH 1/2] sched_ext: Rename scx_reenq_wait_dispatching() to scx_wait_dispatching()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Waiting for SCX_OPSS_DISPATCHING to clear isn't specific to the reenqueue
paths. Any path which takes a task off a DSQ can find it while the
dispatch is still in flight, and the next patch calls the helper from the
DSQ consume and move paths. Rename it to scx_wait_dispatching() and
update its comment accordingly.

No functional change.

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      | 13 +++++++------
 kernel/sched/ext/internal.h |  2 +-
 kernel/sched/ext/sub.c      |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a6a72ae7f815..acfeadf5503d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4483,11 +4483,12 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 }
 
 /*
- * The dispatcher stores the final ops_state after dropping the DSQ lock, so @p
- * can be found on a DSQ while still %SCX_OPSS_DISPATCHING. Reenqueueing @p
- * before that store lands would have it clobber the new %SCX_OPSS_QUEUED.
+ * The dispatcher runs ops.dequeue() and stores the final ops_state after
+ * dropping the DSQ lock, so @p can be found on a DSQ while still
+ * %SCX_OPSS_DISPATCHING. Wait for the dispatch to finish before operating on
+ * @p.
  */
-void scx_reenq_wait_dispatching(struct task_struct *p)
+void scx_wait_dispatching(struct task_struct *p)
 {
 	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
 		wait_ops_state(p, SCX_OPSS_DISPATCHING);
@@ -4536,7 +4537,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
 
-		scx_reenq_wait_dispatching(p);
+		scx_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
@@ -4660,7 +4661,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
-		scx_reenq_wait_dispatching(p);
+		scx_wait_dispatching(p);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 85579fcabf52..352547aedbb7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2123,7 +2123,7 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 u64 __scx_bpf_now(struct rq *rq);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
-void scx_reenq_wait_dispatching(struct task_struct *p);
+void scx_wait_dispatching(struct task_struct *p);
 int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
 		    struct cgroup *cgrp, bool fork);
 void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index c9b44ab3bd0a..fee75fcdb59d 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -797,7 +797,7 @@ void scx_reenq_reject(struct rq *rq)
 		if (WARN_ON_ONCE(p->migration_pending))
 			continue;
 
-		scx_reenq_wait_dispatching(p);
+		scx_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
-- 
2.56.0.385.gd3acb90ef8-goog

