Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DF1487E9
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980101; cv=none; b=jaoC2/keZokGP4zxrZSS/pEuw+ECEoeLqQ+xIFiE+tmX7k4JqbaxkD9x2VOl7K/ClEQF00YrOwom3gcmsukTSpf2Q/cLb+m4C7CkogUmzwkrbYksQsUjVOGj1+j/D664h6uAD03TFoEEPg5zagdarpzi6KTHowr98Mgk4xClQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980101; c=relaxed/simple;
	bh=5WtD6k98BxZm1ugxEKncG6MTBPADYFrbytB4YGdeiB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O9w9fV5StJQ6Y+oN8mQM9DetyAOdfqImkwMRZZxgrx5ibUqt4V9j/Wnlr16Vf3Fi0DIjKrbdBF1feVSkMMGQZaZCi98ElTJWCpRN3hZ3Y6VTUL60uSMDtiqqrc0efbaNxK9K72KlsC6Q9wg3s1jmq7iYiAhKSI3SSdJF7tujW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fENpsMiz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fENpsMiz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7d481452732so4326882b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 05 Dec 2025 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980099; x=1765584899; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3cEtc6f0/lfF9FXuA+00G32aR06pcVYGdnh6khS/0c=;
        b=fENpsMizHgi7tApYAJl/sHkRK6sS7hdHHHDlEbGxzTARAnZ3XB9LillffobPNfvTUq
         gU8+PYNJ7udkEF/4iFOHwwJlvqpRGNwa3BbXmyL8wV3S4avvHeY3dnJIgKT2XbR62ubs
         0fuQmvwrz/xX61EvHFPkNskHbXJ8K4PX/ksVEYSXOQr/KP7RQEeGT3wHghz/mtbtE5Sk
         I5Ka5MQGZol/nMOmWPS1G4afEqfM6tpDMhsSV4Hr/fzlkFwXc41Yg3VMCtL8vGE/joXi
         FGiZqkuKjgEvSMvngF7xrUg26tpvo2tt79vP3gIUp3GXXHZ+hfQf2MIKSkNx6QS6uXKg
         Pp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980099; x=1765584899;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3cEtc6f0/lfF9FXuA+00G32aR06pcVYGdnh6khS/0c=;
        b=ZlNrxa1mJmE6tZNzQF1qYlTziwHLHsbMKhNRyRpuXFrTFnfxgdm3DXKAZs/NPajh+b
         MxEmgUpsK7FMQvKy/zZbAzpbu2uBKlMrVt9m/xiP6poDMJ/XnvD2mE3mScZO1L429rXa
         RnVALe5JRSgTMCnhKtbugfxLw51dI56TM1VDfWYJyJvX+1RTIehn4N2l7Yc+EkFj2tx4
         tBEjnEaYJYcA95NUDfFQgTwXvbzT3ZryQnZJjsYNJSuKarHBs9RrNa/SQmqT4sFm5uaL
         PyobJQTRe3eWBXx7lYalpx3v4IULMra3iocYJwun92G5cnqPOT/1IHOjmGHiNdCvoX7z
         J4zw==
X-Forwarded-Encrypted: i=1; AJvYcCWZq9SKkZaUZ9+NU2SJCIRQ4KP0bDBKF28jVVWSIEIpLOcScy4PJGx5b4iMlPFBklff4tNJUv1DvPY=@lists.linux.dev
X-Gm-Message-State: AOJu0YySVBxEzA3qg94lWzueG+khXfroAPIPDuLAyU3KcoL78yC6DqSt
	BYEvt8MDZQmcWaXxG5jAPTezgluZ+rXAGY9xwn8NOiq03CfeaNQRNADhYWNI5ajZVvvSAAlJMVj
	rvSCrVj/0
X-Google-Smtp-Source: AGHT+IGrs2qWvcvxyvWaNiLVsxZBIvEtG/ed8axGpcta2J0frmLvOYGpO6eMaTfYs/IhnIUT/11156Kdav4t
X-Received: from pfblu2.prod.google.com ([2002:a05:6a00:7482:b0:7ae:a150:ac8])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94c1:b0:7e8:450c:61cc
 with SMTP id d2e1a72fcca58-7e8c60de799mr778041b3a.60.1764980098770; Fri, 05
 Dec 2025 16:14:58 -0800 (PST)
Date: Sat,  6 Dec 2025 00:14:45 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001451.1418225-1-jstultz@google.com>
Subject: [RFC][PATCH] sched/ext: Split curr|donor references properly
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

With proxy-exec, we want to do the accounting against the donor
most of the time. Without proxy-exec, there should be no
difference as the rq->donor and rq->curr are the same.

So rework the logic to reference the rq->donor where appropriate.

Also add donor info to scx_dump_state()

Since CONFIG_SCHED_PROXY_EXEC currently depends on
!CONFIG_SCHED_CLASS_EXT, this should have no effect
(other then the extra donor output in scx_dump_state),
but this is one step needed to eventually remove that
constraint for proxy-exec.

Just wanted to send this out for early review prior to LPC.

Feedback or thoughts would be greatly appreciated!

Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev
Cc: kernel-team@android.com
---
 kernel/sched/ext.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 05f5a49e9649a..446091cba4429 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -938,17 +938,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 
 static void update_curr_scx(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 	s64 delta_exec;
 
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF) {
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
-		if (!curr->scx.slice)
-			touch_core_sched(rq, curr);
+	if (donor->scx.slice != SCX_SLICE_INF) {
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
+		if (!donor->scx.slice)
+			touch_core_sched(rq, donor);
 	}
 }
 
@@ -1090,14 +1090,14 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 		bool preempt = false;
 
-		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-		    rq->curr->sched_class == &ext_sched_class) {
-			rq->curr->scx.slice = 0;
+		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+		    rq->donor->sched_class == &ext_sched_class) {
+			rq->donor->scx.slice = 0;
 			preempt = true;
 		}
 
 		if (preempt || sched_class_above(&ext_sched_class,
-						 rq->curr->sched_class))
+						 rq->donor->sched_class))
 			resched_curr(rq);
 	} else {
 		raw_spin_unlock(&dsq->lock);
@@ -2001,7 +2001,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (sched_class_above(p->sched_class, dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2424,7 +2424,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev, kick_idle = false;
 	struct task_struct *p;
 
@@ -3093,7 +3093,7 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 
 	if (scx_rq_bypassing(rq))
 		return false;
@@ -4587,6 +4587,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
+		dump_line(&ns, "          donor=%s[%d] class=%ps",
+			  rq->donor->comm, rq->donor->pid,
+			  rq->donor->sched_class);
 		if (!cpumask_empty(rq->scx.cpus_to_kick))
 			dump_line(&ns, "  cpus_to_kick   : %*pb",
 				  cpumask_pr_args(rq->scx.cpus_to_kick));
@@ -5426,7 +5429,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -5438,7 +5441,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				rq->donor->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
-- 
2.52.0.223.gf5cc29aaa4-goog

