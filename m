Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978411;
	b=spjIxmXv+3a0SKGlBf6W/9NPDCPhJLA5LcZgb5hMcMwx1pnOR04BrCClxyn7ZYphk2bO
	 NcgU1M8k6ETQEg2tP3zb5rGyhX90l5VsTq5wWda/9B3ErznQ1rfLGNaSN2bzBGkbBCgIW
	 S5fL6io1rVNOgLOVemwEsgkMlHTilrqHxG4bUXLP0oWS10lFE6C0Veg9n2QMArHw5pZTw
	 8SiZk00yWWxyZgiasnZ60XqEfUTZiKKLMS3avwt1kSI/fBZ5M5iV8rYHSCioXeZbLsqmc
	 U9ELuJmuIIsnbZFynAR/lozZ9ilWqQJbWoCHEz3bAtHdNweD1L+fWdFDq2vQuSdtfqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
	b=CrHq4MyFCJNSv2U3BFiyE59DhQZc4mYgTvnTWDQ+T6s6RQM9nBSgV6rAKpzDWA94Jd2Z
	 XNdWjK2P/lGodj76EljZ4Af9/oFly+ENoRCd6ZKecOKvn1C0xIHTnXKOsD1cZXUPjIbQI
	 sumLqtYx2Rbu1gd9cApe2vyFrCQS4orPt/c7lCFYY7cwr7u1xgf0AOoa8aXzi3ZxeRNeR
	 MJgm7ShTzYTjzywDNXnutM5wPqW+5pRogyqTC3JWzDUXHUI3vIn+ySFpAEloAHwh1va6D
	 G2fe4eHcFVYJjfqs+HgtRVgrs6q7NdJ1pJ3cY0+VlNEFRG56OhbwEllRydGXbOE4FnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VsL20adz;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B1606A33A
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5B1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VsL20adz
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so6421085e9.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978409; x=1794583209; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
        b=VsL20adz2THsdBj7I/Lvp/DU4i9mRn2sT/Xt4HvmfeICFwrzmzgP1xcHRWiWymC67u
         xJxv5YRrKH0/RMV0E6B5crYWFylSIGEi35qpUw+8VipTc/XiiiQ/Nb4lcoe/oT/ARAn9
         pOpg2Pl0L/h4sSC0JTB57R7ti0xBYC8R64YCcdUz0y8YQK/Yg5QkkIm5zkhZDixKJFpb
         SLe2zCOuh2ETK8b6yfPPc6zZ762UgJsju3AbCOy8r7mHjPz0n65uC1ul19Zi5k6ZuQxX
         /pjVEJRgIiLZv04qELq4c2MqucweKqIdzsv0hwi3qON6flV9vpFU8MzgvvKQjPz61uZV
         h8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978409; x=1794583209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
        b=aAcwBKN+uaSp0sf1jzGQOWHw+nXkDsHIcMAhDtj23GYfjMaVJCvS8rTVLf5zGqhA46
         u4Tc71NQ5siLS5nFOL/EXRfvHdQhxMuJwmxRXZ/LNlX3Zzsc5ORk8peMZAdF1Nv2cpXK
         RQ7vbB7JcbHJs5RlFTalVOZSdKDEM6ghs1MuHlDYjzCLnHgQQYCFqCEFBmdDWHvpOVgv
         FWXPlJPk+xRlHrXmYCxsC40cbCIscJ9r4MTQwM9TddZ0YGVDKIx39R693ynsUwTaYfBh
         biH15VN69WYbWENfLqj20M/nOz/9n5oZG6w1+Vt/iD6kF98bhscwf4gJhLypEF5JZ2xH
         x4jw==
X-Forwarded-Encrypted: i=1; AKwUvBwk7mmK/ouLGA1IQQ6YY501qmocGt0Ze0DsUTzeLPygBeyPeMtzkMDTBes0J8ZzsOvpOkmYhiYKRM8=@lists.linux.dev
X-Gm-Message-State: APuU4Z/LR+dbgadBRwfKtjibCDuh5sq9U+ZAd5lk7vKq5O5jAY30JmkE
	gsVOFH7kYNn4Wg4GSdaLXEO1VuyM6JsFDWrq8+JdJfplzzs2E2KknQXAszLxCnvlYeKUaGaIBUl
	10w2b
X-Gm-Gg: AYBFou2bDdI4+QIvPMlYhTpnaqNkdGKSlXKeHjPpjljFw6dmHtPnMyCjDWpDq6Zx2tF
	nY0thMz6+uOpo87QvY+KxvrwrLVDMLg8DmPh45Ywmx+3PsgTOunCzelpdAXYGQH8JIpEt/Usp0d
	Aez6UVJQMii1puf9HkcAnnORydSdPVzfNz3TAsjUvXZCmgKK35Omer7CmMp2QQA79fAzQoymz6W
	hoNHYStvsRL5upUVFrbh7ZNd+MTq424E6+tJMVVcAByukGASjGJ1fVOCfG384/LmmoG72opKkWa
	LkVMxfptS1yoc/8RFxcrnPkDCXecRX2wOj8K3gSdu6QrPTzJ9ylV0ubqq34bNpr8m43zEhaF7hL
	cd5dsdS3d3zszqYxVQTIf/+i39kwGUaVIq79IGELZptOg4Olqa1bSWJo3LxZ9uysZahS0GBlmo8
	Go5QxWKNUpEFIdJniE/FSavPvTTImHvssQO8ci9xHh2VAS4ldZgB0ajHJHd2Y5lzfAOzfPz9ZRB
	Ne5G1ys0mIR/xx+d9bAalKLPj7OToPDRAgV+sKxEJ/G9xriM8oTZZ2L2BhWOQw3LJF+01NROCxy
	j/WBRq1/RG4WL0DvYniNm9NglzyC1yrXnX3JCVRXnhBTUmQ=
X-Received: by 2002:a05:600c:8b28:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4b6dfba8628mr43728685e9.30.1793978409162;
        Fri, 06 Nov 2026 07:20:09 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:08 -0800 (PST)
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
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 10/20 v3] sched/core: Add rq flag to tick parameters
Date: Fri,  6 Nov 2026 16:19:37 +0100
Message-ID: <20261106151947.3991524-11-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
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
index d71da9069218..a1a3aa45ecf6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -923,7 +923,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, &rf, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -5857,7 +5857,7 @@ void sched_tick(void)
 	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
-	donor->sched_class->task_tick(rq, donor, 0);
+	donor->sched_class->task_tick(rq, donor, &rf, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
@@ -5953,7 +5953,7 @@ static void sched_tick_remote(struct work_struct *work)
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
index 0403c4634281..8728e394d4fb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3822,7 +3822,7 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct scx_sched *sch = scx_task_sched(curr);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2999d3f88e4..3bcb663ebcde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15686,7 +15686,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
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
index b88857dd3941..95a18c0d21c6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2751,7 +2751,7 @@ struct sched_class {
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

