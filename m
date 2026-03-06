Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F429426EBC;
	Fri,  6 Mar 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823999; cv=none; b=ewxFgeu5UdEUaWH4S7jOp2f8eb7hCsSU/JsRtuuzzIFo9SXRxAbAZirofIMbJF2n01wxEkCX4b6HU147kZGkVjhQes6oWUGAc/OmVlkaUoTJLLjSaM7RqINawbBV9P5cf4vFL/581WGHHmQ2F+1SlWRRMaB/z4Ev8Oi7PrOwwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823999; c=relaxed/simple;
	bh=iC8XuPyGvR5rXzr0A3Fnq97IIDbAtHIUyW+NZshN14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJMlIvsnIxB8W1WoiBPMcGuZ1u1ffxYwz99CZfxJc6fcC9t9508ALjHk4Rdp/olAT7xvJrqrTdpd5SB0QHYL2IjnX3V7FWPy+jNkNeIpIXAOyFXAXsMQu29byIwkBmVAAqg3syBIB983NHKdYtWBR5zXwu9d4VlljhZgSeGiXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd//eqWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd//eqWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2749DC19425;
	Fri,  6 Mar 2026 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823998;
	bh=iC8XuPyGvR5rXzr0A3Fnq97IIDbAtHIUyW+NZshN14w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kd//eqWZAGlirc6OBatgKXupLi3d/gm5AZav2Oy344bgTH1k5aR11TUcbmMs2xveq
	 6cyKphU8+oBw9CK0yjmW7B7IIv8XgKdHkClGM3sWmT30DHzO9SGj3IWM9N/3/QoYbR
	 8b130L03yHfPvCpKuTGu6ph81Db3eyGW6dE1B2rn+Rxe45SgPXcP7lvglR4bAWPtPT
	 G8ZWQfUzAaoGkOEIYXvHK20b1S+QK1ow2690myqX6blZ6sAiqU+axj0hHpWW/PYpTe
	 /inQamZ8ua7mJVIuP8q0V7QgGNCgf15NtBfewmEdBn4jJt3jihYqLnD/qh1kwYlfQG
	 DsjfDCT7218RQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/15] sched_ext: Optimize schedule_dsq_reenq() with lockless fast path
Date: Fri,  6 Mar 2026 09:06:21 -1000
Message-ID: <20260306190623.1076074-14-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

schedule_dsq_reenq() always acquires deferred_reenq_lock to queue a reenqueue
request. Add a lockless fast-path to skip lock acquisition when the request is
already pending with the required flags set.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f58afbc69cb4..8e7dffe4094c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1174,10 +1174,20 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 		struct scx_sched_pcpu *sch_pcpu = per_cpu_ptr(sch->pcpu, cpu_of(rq));
 		struct scx_deferred_reenq_local *drl = &sch_pcpu->deferred_reenq_local;
 
-		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
+		/*
+		 * Pairs with smp_mb() in process_deferred_reenq_locals() and
+		 * guarantees that there is a reenq_local() afterwards.
+		 */
+		smp_mb();
+
+		if (list_empty(&drl->node) ||
+		    (READ_ONCE(drl->flags) & reenq_flags) != reenq_flags) {
+
+			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
+
 			if (list_empty(&drl->node))
 				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
-			drl->flags |= reenq_flags;
+			WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
 		}
 
 		schedule_deferred(rq);
@@ -1186,10 +1196,20 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 		struct scx_dsq_pcpu *dsq_pcpu = per_cpu_ptr(dsq->pcpu, cpu_of(rq));
 		struct scx_deferred_reenq_user *dru = &dsq_pcpu->deferred_reenq_user;
 
-		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
+		/*
+		 * Pairs with smp_mb() in process_deferred_reenq_users() and
+		 * guarantees that there is a reenq_user() afterwards.
+		 */
+		smp_mb();
+
+		if (list_empty(&dru->node) ||
+		    (READ_ONCE(dru->flags) & reenq_flags) != reenq_flags) {
+
+			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
+
 			if (list_empty(&dru->node))
 				list_move_tail(&dru->node, &rq->scx.deferred_reenq_users);
-			dru->flags |= reenq_flags;
+			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
 		}
 
 		schedule_deferred(rq);
@@ -3774,7 +3794,7 @@ static void process_deferred_reenq_locals(struct rq *rq)
 
 	while (true) {
 		struct scx_sched *sch;
-		u64 reenq_flags = 0;
+		u64 reenq_flags;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_local *drl =
@@ -3789,10 +3809,14 @@ static void process_deferred_reenq_locals(struct rq *rq)
 			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
 						deferred_reenq_local);
 			sch = sch_pcpu->sch;
-			swap(drl->flags, reenq_flags);
+			reenq_flags = drl->flags;
+			WRITE_ONCE(drl->flags, 0);
 			list_del_init(&drl->node);
 		}
 
+		/* see schedule_dsq_reenq() */
+		smp_mb();
+
 		reenq_local(sch, rq, reenq_flags);
 	}
 }
@@ -3866,7 +3890,7 @@ static void process_deferred_reenq_users(struct rq *rq)
 
 	while (true) {
 		struct scx_dispatch_q *dsq;
-		u64 reenq_flags = 0;
+		u64 reenq_flags;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_user *dru =
@@ -3881,10 +3905,14 @@ static void process_deferred_reenq_users(struct rq *rq)
 			dsq_pcpu = container_of(dru, struct scx_dsq_pcpu,
 						deferred_reenq_user);
 			dsq = dsq_pcpu->dsq;
-			swap(dru->flags, reenq_flags);
+			reenq_flags = dru->flags;
+			WRITE_ONCE(dru->flags, 0);
 			list_del_init(&dru->node);
 		}
 
+		/* see schedule_dsq_reenq() */
+		smp_mb();
+
 		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
 		reenq_user(rq, dsq, reenq_flags);
 	}
-- 
2.53.0

