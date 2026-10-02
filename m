Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CE4F55B5
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955925; cv=none; b=RbVeEmW5qDxp4g5Bsz80q6dS6y2yH6wh3qyNdgXB6RxFmY9g3RDm5jPxSG1Kbc6Oymb0qb8Jcbuvc+RZsLRbGgC64pBz3aBVRBp+B28aoz8tpMX+mEKvIYpkbB4j5n8iVocTCbL2/yez7VwrELQ1qlYbM9gWni+nqC9Nd3EfQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955925; c=relaxed/simple;
	bh=g8ii3PyBa0GiHh/9S+lqpPXalszN2DsJKkDUpSbsdmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S64cE6h7Oe+dvvgoY8DEGtGUubcNazU1CegiccrUEbCbRDxxIe5lCufDnr2kBQJuqpg0eQCw5wYs/3nFGdS4vcgo69XHpmeTPGvuhbP+1AQrLxy8vMUE8GjE4cxbT+9kYj/Wmynxs4KECVq8hGrLF646W3Jf7D+x5wT+uV31Gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMsC9n6t; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMsC9n6t"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so171755e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955917; x=1791560717; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEo/LxwFi1EqrOkkcTTlEnXPhiZDemt/Tt2IhYFOTaI=;
        b=nMsC9n6tU14OwjaKH/eGMaotsekFGWyMXjC5FymhFmbSMqWrwuSCDabEarPT+J9Ywv
         huQqjZHriWf61zs4/CLwmqqmXMah78PpmGkk7JGFptuFROPiKSLf+24nhkc+YBPNf+/8
         Xw+dhutannTz97NAmPCiD97tfQ7SdaPgBDhyCUW9i2i+OxU2qv9yrtYh/2z4N7+6nprT
         pEFkR8Aqil4J7VMIuKIRBtiIBgr32LUiPADZt5VXY0Aq59EAO5n6AeQgKJIsf6EqJQB7
         L3PBMPYeBdE0b4alLoelMOnGcWuQJ4+lfE9Q2MIFZKJwnrpxjqHR70cRu5wd0kCGEN0u
         bAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955917; x=1791560717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEo/LxwFi1EqrOkkcTTlEnXPhiZDemt/Tt2IhYFOTaI=;
        b=joCCxgo/jFfu7v5zjLJQQI3/d4gGWIs8rX8RyBnLH02zxJmp3rFNuJOwrI52y7wolK
         yTR6yX36jEpUFFlEMceBj0esaXq+/q6ICmWD/O9VztPCPTf2ygqtBTFHx8dJmK8Z3sOt
         ZBHTdTQ/p8LPOAw3zRDIgWRwOhcjH8NXbbGBKjCTwTh5EiE/3mLUAaO/slU1Rm8OXIoP
         lD/H5Egp7VhIvmtySHOOrvRkEXxxcrYoXjcX6gzu+//osJSQga9tMNFSVZgDYxL+06+S
         jHR06ScsfqfmWSKWH4/gCzpLdBNVdVmkQ8SBqSubby+ka6JH8ecn/aQjTmmCyn2KXUqH
         vlTg==
X-Forwarded-Encrypted: i=1; AKwUvBzbvbATSpvSnv7MwCDrFHOSMXlQR9CdI8wwNklnBKB5MfSMQDZGRIzu1lZavjPCe0LsQVGN/NFkW/A=@lists.linux.dev
X-Gm-Message-State: AFuF++lcX9WgVBIqyS0AKG/rZoElrY2U4w8dTE0UGoBAljBotFceyWkw
	t6g7PtS1XfTLdsjXsAKMpV7dNU5mPVOVorxp/JJ+Y+R0pppPJNmSfajRXcTd8e6DdTk=
X-Gm-Gg: AYBFou09/ZDHpqplFph3LZg6WTCZfcw26z/zd6TrB6uVt1bKNltwiFxgeA2kEEC+lzN
	wXi9ea5LkWwC/KcPDg0Hnf1LG5Gpgmauwq4ZXBCOnXeqCClXAuOAvmUceex2gnFKmwMS3lEI3vR
	tNrTTDGoZzwmjr4t9JBHscclwvOi/LpYnlSoY67bXndmSxhYOFj+kqWxQk47TPWMCQWmckwJ10V
	oJE9ZH6DssqbiAXtvSjB1mpMgBzjAQuOfSIyVc8ESo697hbbHPKc8D81PJbjag/s3R+baKjpgQG
	2l7DfCy3IaCZiBlWyaMv7u9IruZ9J7AihtZ+pomkCqryUHSikEFYodopbPj4W64mvgRsKJqxxb8
	V5osCvalrtKXqUEq59ze3aTiPRv8l33vc/N9bYoQup8YrxTlwJhVBOZdjHwJEEoZtpa8dmQ2Gpi
	k7SSfnHknXaOhmTxIcP3FFajY/bMBUeNLHADhur4fJjuCONTNFuHVmg4pd0OWWMrVwPdRZc3qBZ
	IgAsk1YPMuVzKDCGCQU/b/I+ac=
X-Received: by 2002:a05:600c:4ecf:b0:49f:d087:6526 with SMTP id 5b1f17b1804b1-4a0276c616bmr60045805e9.34.1790955915970;
        Fri, 02 Oct 2026 08:45:15 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:15 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 09/18 v2] sched/core: Add rq flag to tick parameters
Date: Fri,  2 Oct 2026 17:44:06 +0200
Message-ID: <20261002154415.2270586-10-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to force migration in tick, we need to unlock the rq

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c      | 6 +++---
 kernel/sched/deadline.c  | 2 +-
 kernel/sched/ext/ext.c   | 2 +-
 kernel/sched/fair.c      | 2 +-
 kernel/sched/idle.c      | 2 +-
 kernel/sched/rt.c        | 2 +-
 kernel/sched/sched.h     | 2 +-
 kernel/sched/stop_task.c | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 837dc74c9a8d..1e34c8fdbee8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -923,7 +923,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, &rf, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -5800,7 +5800,7 @@ void sched_tick(void)
 	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
-	donor->sched_class->task_tick(rq, donor, 0);
+	donor->sched_class->task_tick(rq, donor, &rf, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
@@ -5896,7 +5896,7 @@ static void sched_tick_remote(struct work_struct *work)
 				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
 				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
-			curr->sched_class->task_tick(rq, curr, 0);
+			curr->sched_class->task_tick(rq, curr, NULL, 0);
 
 			calc_load_nohz_remote(rq);
 		}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c0ebdcde5fe5..1f6bc63b3110 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2879,7 +2879,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_s
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued)
 {
 	update_curr_dl(rq);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 53275bc7c029..cdf48af9f05e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3790,7 +3790,7 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct scx_sched *sch = scx_task_sched(curr);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ba2efeba435..483ed5807dfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15346,7 +15346,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct sched_entity *se = &curr->se;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 76f3c84ca684..1ba0303aacb4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -538,7 +538,7 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_idle(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	update_curr_idle(rq);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1535046a23ff..35b3831a72cf 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2541,7 +2541,7 @@ static inline void watchdog(struct rq *rq, struct task_struct *p) { }
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 293f23620282..c1d7e04d2899 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2741,7 +2741,7 @@ struct sched_class {
 	 * sched_tick: rq->lock
 	 * sched_tick_remote: rq->lock
 	 */
-	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
+	void (*task_tick)(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued);
 	/*
 	 * sched_cgroup_fork: p->pi_lock
 	 */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1e0109ec36b3..3d99b23afd89 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -74,7 +74,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct t
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_stop(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 }
 
-- 
2.53.0

