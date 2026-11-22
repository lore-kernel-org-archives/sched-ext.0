Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795319576;
	b=QHLYPLG3fk3maVY4IAgI97boNrRUGjPFnLH+2klY2GJg+tokuVa8hoLY5O1t6Gb1hFYH
	 9Xd7YGm3IDw3BhFBufa4NSk+e75mnebUqa4y1rpwUeDiiL2yYoP26GuhQuBAq/9zHAQJY
	 07CcCXk4UIRI7yv+yZ4CDCFulITDX9BNbH8Cdr+zfwCndRCfOs78Eg8Yl8ix/mDTvdiIZ
	 LRwhKiiUYhWmNoMd+UtyBszvhtqKLwvMoEOKF3kQ38QgSrlzshwwXIHKhI+mTGaMPregT
	 yxQvjMs1+8oMAnSiDthS5jQbV/dj2Kt0OEK4n7H2Q4ZNz7jRb2GXtpZaOff+9PLx0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795319576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=b+r6XPfaUdJuFlB5RmbvVvkEeNjRjm4uTzzQBZy+VHg=;
	b=mJ5B4DVpbPCbhK0nawux5uebaFKptpdBaUxgWjVr0U/8gTRXU1vd6yQKb9u1FMFSo8f7
	 ccwUBepHCj3IuKgf5ob783GBpPwgzamYCEQV4XQxm3AErQ9Kct7XRj3mLxVEzgU3ecs5D
	 Zf3H54Dy7V/xLSwmyNFoIaMpkqxVHszTpBd3gJEwXpQQsOWBH//w//xHqXRX7OdMDRbZG
	 DoaMC7glj9qMBua1RLEi73NqJKcyVZmyRdiwXypA6g/Qrj+6/FO4FTm8KLV8FNobwr7j7
	 3jzYfpLH0nJ73GYDFEpSMvi92tIcgADS8gR5tAAAeSeN7BjUcr3PbM1mL3WyTnZoIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bfrs3ybI;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53982606A320
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 03:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53982606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bfrs3ybI
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-384c78aa0dbso3161137eec.0
        for <sched-ext@lists.linux.dev>; Sat, 21 Nov 2026 19:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795319575; x=1795924375; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+r6XPfaUdJuFlB5RmbvVvkEeNjRjm4uTzzQBZy+VHg=;
        b=bfrs3ybI3rLQ3MhUOQQp+5oGU9YR4mmcv82So1hRnTjIfmhsHNfejvImd5T8/OoVWp
         HRM8Kn9Vk2P/lSphQTlIqvpgjpBH05kXJZJoG/IeBSPii9/clwmw0Q4AxziIb98iBK9S
         8qVVomT+fUEv7WMvXSlfz0g6PqUO4ryG2oC3Aa5xZqR4hywO9mQ5vuGcHiFvIGhsnlXU
         MO6bO8t+9ujAx4WkiCScFxpWTE/x/yWz27CNR5RL9UFfaQqOOq9l1Q7alIgARAobA5Yb
         ISHVaX4jYeyqQmvNtAf6KJjzv2b2O73xJCtEVHdpNohuQs62vlv1+RV4TX1cVO4E5YSC
         nPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795319575; x=1795924375;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+r6XPfaUdJuFlB5RmbvVvkEeNjRjm4uTzzQBZy+VHg=;
        b=LvhX+17As5wen1WlZl6nFIYyLCExNMsFNz8Iw7/C/3/kgg84FiLOrkHjDxF45LovYb
         BeaIj99Ehn5eMI0S1IU8IA+6y8+evhMfoVSpnTGiXfk/MtHYu5uNi5V0qTUNyGU/aRk5
         xJR3k2Aq6uQmILseh/9oZrW7J1GBtggmRmwrMBKpu+v95DP5rzIFbzGWXmUz2BVjGSNR
         qkGHedph7h2ib9IRr+G2KdyHSQZADgFzJOAmeUxnpUjwasNYb0FNlIoE7Dd0TUliA/zX
         Vs9xZ44oTUpqbLQspAp1Bg++70gzaDOBlizWvwlDZ02qqBoAoxPx5rMAuJQFTxW5WIrj
         ySiQ==
X-Forwarded-Encrypted: i=1; AL+hErEb5hToI33hyK119NkfjQ7c9Z634qFXkUt8jI8GMkRdhDz2CoEYVsmCqIfozyNF/NX0CFgOc0RuXt0=@lists.linux.dev
X-Gm-Message-State: APuU4Z+sl6jCRSBnEgX6yasdeBPXB8tc360VlMDX0DoFiO/SAnkcO4O/
	Y7jEDc0kLtH7bW83HUXvqqY7rcKVIZyglF0HwLq+eH3VOsZ6S5KQVvZ14ZKKZY51zyDzsoNFhO6
	ARzQiajT0cogHmMh8rw==
X-Received: from dyev10.prod.google.com ([2002:a05:7300:430a:b0:343:520f:7a80])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8807:20b0:380:c3e7:7814 with SMTP id 5a478bee46e88-3856f65e4aamr7582380eec.7.1795319574972;
 Sat, 21 Nov 2026 19:52:54 -0800 (PST)
Date: Sat, 21 Nov 2026 19:52:54 -0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122035254.2891197-1-penghuang@google.com>
Subject: [PATCH] sched/proxy, sched_ext: Skip proxy-exec on SCX owner with holding_cpu
From: Peng Huang <penghuang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org, penghuang@google.com
Content-Type: text/plain; charset="UTF-8"

During remote DSQ consumption or dispatch_to_local_dsq(), another CPU
claims @p->scx.holding_cpu and drops the DSQ lock while switching to
@p's source rq lock. Because commit 13ae184e4b82 ("sched_ext: Handle
proxy-exec races in remote DSQ transfers") made proxy execution
compatible with sched_ext, find_proxy_task() on the source CPU can pick
such an owner while holding source rq->lock, forcing the transferring CPU
to abort the placement and bounce the task to reject_dsq once it acquires
source rq->lock.

Like task_on_rq_migrating(), an SCX task with holding_cpu >= 0 is in an
in-flight cross-rq lock handoff. Expose scx_task_held() in ext.h, have
find_proxy_task() yield to rq->idle via resched_idle when an SCX owner
is held so the transfer can complete, and pair the lockless READ_ONCE()
with WRITE_ONCE()/READ_ONCE() on holding_cpu updates.

Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/core.c    |  9 +++++++++
 kernel/sched/ext/ext.c | 14 +++++++-------
 kernel/sched/ext/ext.h |  6 ++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed660f099a5..8aa309d86a6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7108,6 +7108,15 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!task_on_rq_queued(owner) || task_cpu(owner) != this_cpu)
 			return NULL;
 
+		/*
+		 * Do not proxy-execute a sched_ext owner while another CPU has
+		 * claimed holding_cpu to transfer it off a DSQ before locking
+		 * this rq; yield the rq lock so the transfer can finish
+		 * without bouncing the owner into reject_dsq.
+		 */
+		if (unlikely(scx_task_held(owner)))
+			goto resched_idle;
+
 		if (owner == p) {
 			/*
 			 * It's possible we interleave with mutex_unlock like:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e29c9c18e1ab..5202f750a3b5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2043,8 +2043,8 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		 * but @p->scx.holding_cpu may be set. Clearing holding_cpu
 		 * tells dispatch_to_local_dsq() that it lost to a dequeue.
 		 */
-		if (p->scx.holding_cpu >= 0)
-			p->scx.holding_cpu = -1;
+		if (READ_ONCE(p->scx.holding_cpu) >= 0)
+			WRITE_ONCE(p->scx.holding_cpu, -1);
 
 		return;
 	}
@@ -2067,7 +2067,7 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		 * unlink_dsq_and_switch_rq_lock() that it lost the race.
 		 */
 		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
-		p->scx.holding_cpu = -1;
+		WRITE_ONCE(p->scx.holding_cpu, -1);
 	}
 	p->scx.dsq = NULL;
 
@@ -2978,7 +2978,7 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	scx_task_unlink_from_dsq(p, dsq);
-	p->scx.holding_cpu = cpu;
+	WRITE_ONCE(p->scx.holding_cpu, cpu);
 
 	raw_spin_unlock(&dsq->lock);
 	switch_rq_lock(locked_rq, src_rq);
@@ -2993,7 +2993,7 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 		 * holding_cpu with it so that no caller has to.
 		 */
 		p->scx.dsq = NULL;
-		p->scx.holding_cpu = -1;
+		WRITE_ONCE(p->scx.holding_cpu, -1);
 		scx_wait_dispatching(p);
 		return true;
 	}
@@ -3213,7 +3213,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	 * under transfer with holding_cpu, release DISPATCHING and then follow
 	 * the same protocol. See unlink_dsq_and_switch_rq_lock().
 	 */
-	p->scx.holding_cpu = raw_smp_processor_id();
+	WRITE_ONCE(p->scx.holding_cpu, raw_smp_processor_id());
 
 	/* store_release ensures that dequeue sees the above */
 	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
@@ -3230,7 +3230,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		bool fallback = false;
 
 		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
-		p->scx.holding_cpu = -1;
+		WRITE_ONCE(p->scx.holding_cpu, -1);
 
 		/*
 		 * If @p is staying on the same rq, there's no need to go
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index d32bc01071b0..f936300b5aea 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -54,6 +54,11 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+static inline bool scx_task_held(const struct task_struct *p)
+{
+	return task_on_scx(p) && READ_ONCE(p->scx.holding_cpu) >= 0;
+}
+
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -75,6 +80,7 @@ static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
+static inline bool scx_task_held(const struct task_struct *p) { return false; }
 static inline void scx_proxy_donor_start(struct rq *rq) {}
 static inline void scx_proxy_reenqueue_retry(struct rq *rq,
 					     struct task_struct *next) {}
-- 
2.56.1.750.gf70dc682cf-goog

