Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606124;
	b=DbGtN6VX2gKXw57tcGkLzfcxeFpQHLa7oNFTtbmquhDKHj0zblGZDhfp2+RjL2CN6IW1
	 c5ktjyifCi1+8TsgwM2Z2KKf+OIMegKdHWLGCmN0mL0ihE4KLbbYLYpUt7U+CeobwcQCZ
	 RGqBDkWaj649QsrWWy8RV8Zm65XnfVQIFWeEi91O438NVLarjRZvIm1S7I8pMElWO4sPh
	 WzoOn3O+z0iytXD+c+H7FDtQppI0ZGGnGJ0U8aUhaxftWeJIT3D+uqRmEmlXin9Dxfvch
	 ctnoBirVrVNPQpVJ1/xWnYZp8wq8sRwgFdFph0Ry35VaVjalkSBQmmTMSLAkBvvH/ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Qd//H+we0TeasQzPW52DpsCIJIXJMWVEEvyKH+0QRSA=;
	b=I5UBx0EpQmvBn13cCW2ujQmLCuVo0KDShJirBjXafMTGU6DC4ZwXlsj9eq/ptCOseApY
	 oD3LQ0rutGGN5vcNTB/brhwhYHbLD8sbhgTvNd13xlFkEEzyHwVXXAebmaDEEn9RdEOZm
	 HxTz5T/v94jA9pAmNV9m2AmtCrdmKsj+jYBEqPLE4KAJW0/d8p9hIRy+muv1QMznBIhgW
	 RklWsRNicTOGlJ2+WOxbXIMlfjQzi3HBfYqUnzUHYPNOnVpAmfFdCGTsIorUr0V30BNja
	 eNd7neSHi8LQLJagt6vT/D3610KIrrmHX/PPsgj7yTvJmlEBT35UpDsLTElP9t+xdfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjO3vLaQ;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741E606A683
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4741E606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjO3vLaQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso3150355f8f.2
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606123; x=1796210923; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qd//H+we0TeasQzPW52DpsCIJIXJMWVEEvyKH+0QRSA=;
        b=JjO3vLaQtE5z9Fz3lJHhDJCtdZVsw9QiIdbyQ3eYPtjhVVM47VZWAkSA1g4pQipub6
         genWV3imtN1n7LAcsP60tz8RbZiiWQE987NFyenWp33yQ7L8J8BczdG2EbOA/5S2peZQ
         Um9RevUooRmfgJuRBSUUdHTL3YVQlTO8//Fo2GaRJks0PQTx9zFRwZCuYEhCbi/YUkt3
         m33rSpJO04zJ37QXlPbTW38e5eNCb5r5yV5pnC0R5AjeA/9FUO6uJBorZWWScasW52Xg
         0AiM0kwVkzmDFJaH+gvLAb3n6pgPM/GC/J3Iz+Rzi7AdSIGOMcfvbDYUJHf5B1rMoAFB
         HaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606123; x=1796210923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qd//H+we0TeasQzPW52DpsCIJIXJMWVEEvyKH+0QRSA=;
        b=qwNvM52vAaaEr2y5MK5tsceT/pMd4AOQGsT4hA4i4iXad67WwN9R/uiDnz18STvrdS
         n5Mob6oP8eC2p7tbd3Z/ZV0hrSLSab9+gjnHuUzEYJ+qaT/S/pWkm5aeL8VtIPTFlYPQ
         rLfjgx7su5xjRKQ1EjVyNSdIpivtRcmvV6XEfGyPk0lBMPlUlSYjbJR0NB7KHtN364YO
         Wgft4UHQxlI1n51P9fpdLoRL3QJbpPu7gQoXv2eZ2XrqylAdkMLfnt7A4St7gq8bI/eS
         wIer4CnoSkYL050kv4KjixG+qeEcXg+C9H5DJq3S4HKmMfTx94OtHiSZozJVT6nOYl30
         1fzw==
X-Forwarded-Encrypted: i=1; AL+hErG/6KPplF0nu02AI1jkPqQT8S40ybfzxqaEbgy9z5zEo7oQbeHjHluI7cd1r7Iv+TRisIjXzlNVpss=@lists.linux.dev
X-Gm-Message-State: APuU4Z/qK7/cfAVwiNlB96mqmvE/qIEdfbRtDVLqnqIDQXZpGSjXBH+1
	JMp/KsHkfyIGXE1fPDQojlZhedmqgIdB4yWDhZcfW/XAMJ7Ol2nMA9rTZhf5W22uuWtZ4DkYZG1
	A4vb8Dk0YvhamyQ==
X-Received: from wrmt15.prod.google.com ([2002:adf:e44f:0:b0:4a3:da3d:b9a6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178d:b0:4ba:18fa:1187 with SMTP id ffacd0b85a97d-4ba18fa11fcmr3252982f8f.46.1795606122470;
 Wed, 25 Nov 2026 03:28:42 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:37 +0000
In-Reply-To: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125112553.1539758-4-jpiecuch@google.com>
Subject: [PATCH v2 3/4] sched_ext: Remove scx_wait_dispatching()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_wait_dispatching() waits for a task found on a DSQ to leave
SCX_OPSS_DISPATCHING. scx_dispatch_enqueue() now clears ops_state before
a dispatched task becomes visible on any DSQ, and the remote dispatch
paths release DISPATCHING before they lock the task's rq, so the wait
can no longer trigger. Remove it and all its callers.

ops_dequeue() still waits on DISPATCHING, as a dequeue can race a
dispatcher that hasn't inserted the task yet.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      | 24 +-----------------------
 kernel/sched/ext/internal.h |  1 -
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8451eebbe2d1..3a69100e47f7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2726,14 +2726,11 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
 				      u64 enq_flags, struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq;
+	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	scx_wait_dispatching(p);
-
-	dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		dsq_insert_head(dst_dsq, p);
@@ -2993,7 +2990,6 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 		 */
 		p->scx.dsq = NULL;
 		p->scx.holding_cpu = -1;
-		scx_wait_dispatching(p);
 		return true;
 	}
 
@@ -3053,8 +3049,6 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(src_rq);
 
-	scx_wait_dispatching(p);
-
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		/*
@@ -5255,18 +5249,6 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 	return *reenq_flags & SCX_REENQ_ANY;
 }
 
-/*
- * The dispatcher runs ops.dequeue() and stores the final ops_state after
- * dropping the DSQ lock, so @p can be found on a DSQ while still
- * %SCX_OPSS_DISPATCHING. Wait for the dispatch to finish before operating on
- * @p.
- */
-void scx_wait_dispatching(struct task_struct *p)
-{
-	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
-		wait_ops_state(p, SCX_OPSS_DISPATCHING);
-}
-
 static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 {
 	LIST_HEAD(tasks);
@@ -5310,7 +5292,6 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
 
-		scx_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
@@ -5449,7 +5430,6 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
-		scx_wait_dispatching(p);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
@@ -5554,7 +5534,6 @@ static void scx_reenq_reject(struct rq *rq)
 			WARN_ON_ONCE(p->migration_pending);
 		}
 
-		scx_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
@@ -6818,7 +6797,6 @@ static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
 	lockdep_assert_held(&donor_dsq->lock);
 
 	if (rq == donor_rq) {
-		scx_wait_dispatching(p);
 		dispatch_dequeue_locked(p, donor_dsq);
 		raw_spin_unlock(&donor_dsq->lock);
 	} else if (!unlink_dsq_and_switch_rq_lock(p, donor_dsq, donor_rq, rq)) {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 58652370da5a..c77f62cd7bc9 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2322,7 +2322,6 @@ void scx_resched_curr_deferred(struct rq *rq);
 u64 __scx_bpf_now(struct rq *rq);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
-void scx_wait_dispatching(struct task_struct *p);
 int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
 		    struct cgroup *cgrp, bool fork);
 void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
-- 
2.56.1.839.g22a8290db9-goog

