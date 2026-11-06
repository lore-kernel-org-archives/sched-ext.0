Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978409;
	b=kGWyavgEhF4qbnHFJmb9tRiLj8I9WTfpqP+HJ/YFcnAcwARWcDwhr8nDby0CxqTwA5tV
	 3odYf+KeIhkna61hGt0GkZ1R0+M2+nnwYcr5WAiXcqnlLU7Rw2Km4w0QQvBnoI2qAK1Wj
	 7T3PPLzvceC6GDT4/nRrCD0dI4GRvUwR+663JljI00PW5rKIjdKmYmmA8tvbYI8GThSwR
	 0n2r3UdK1F3PzOOx1NHhnAC5S7iUWhaPH+zkWNI/mOEhhBirRAbs3gs1uZjzwzv5QHM8n
	 f5iEpA7xccVAu8vPI75wIUy5jWWCtCyn0SzQ2mBL5b2E3hquFbqzZUnfgjqKi6kQJ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
	b=SiAu+CZ1nBaa6lxd6j9x5NTb4KuMkT7WqTacWXJ+HhiuQn2OF1i0Refqp4W9Onkfxd9B
	 SyOnfEzuzTtotRitgmaX1NhE+9WhmGUW51YkAgCsM+x9/+kJRNS4AwYhN790WGRtwu75z
	 T9WJRl9z8aYhlwj8pqxIKSJE9z/8D8JwxBUj7ROQIcvup5hG5NbofC3RTODlG5SDPVME5
	 Ga2tkJjZ3ZZOzE/MDILagrSAlwITxMkxfypsOL9B17/pw1QYcMzIQFVNy/BMB0913CDpM
	 94aRbbE6rXY8NYtlYzxcUQx/OQeXALhXtpcOxDnwVp55d1wk58mpROzhUm83f8QGPGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zy1LKHV4;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B2606A330
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6B2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zy1LKHV4
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso552325f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978407; x=1794583207; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
        b=zy1LKHV4ijFJH2Z1yYHMBUICJPdHye4HI/aRIm7D1mFS83041Yvftszg+YptoHeGCn
         S7ixr2GO4jM8CuuT9QN8GiizBMUWrHqBRubOVepFx6QQMW/srd2TlVchByhG7hv0ByoA
         lk0as7e6G+U4K2dzvhArtyylzEyeQ0qSovB13ZXPAYYRz3i9kv78MYNk6jAv6S6+x1dJ
         S5denLFOYBwsMro9Cw6v4Hnsq2NY1ZhDgvuz2OpdaFSRRuhnfeZYCMKra3VcyC3icq74
         V57ueEng2OHT2ZtxLccxr/bge5RgTycc8YFDUAdX69+PYzIR/yN+tm6iXQ8G/d79G/Oi
         Rqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978407; x=1794583207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
        b=dyWJaCUXltlDf1azfK4UuljKx0ltST+14GLTfSz3MHos9UYYguGycCfF+DsCu0a3r6
         9cGrq9SQgsDe7pMuYEMqVE1LBOtMsb9/mdH28Mr2f9aQs3eRP7i7SLvVBg6P4/e0/6ae
         Kp1rpJby0mS5nQ9xKZUREacILYb5dqka7gp/Y+PqnNkJrBXtYvKPgxjIfQm3nZWoEzzI
         JyEOI0FRXqZIRTtN6SoK2OD2tvDab4mOMXilwzvbpEnjjHiaHOETVbaLPoKwQy3BGFLr
         YdUrY1PW2HW69YCoRO7crpGCbnHHOhLZ4HkX1Crm2Vlwu5FhA8Gb9qSWFC92VMlIo1Zg
         q4fg==
X-Forwarded-Encrypted: i=1; AL+hErGAIn0ZzJXrhEr3F863I2y2O1ZA0OFLhEAknjMEf2mj7gLRdd5aN228DPDk+ovIzavwMCHs/+HVRlE=@lists.linux.dev
X-Gm-Message-State: APuU4Z8XUOsNPP/rMQsYKklnpLszUa2kdOAnu8t1Cl9s5kyfnhLZM2zg
	YxS1ZXNLfAmA+pVBt+UBvo5MgGnXnS7Fs55wPrBAH4fxfJfFTQzsdHxySb4puqg7xSE=
X-Gm-Gg: AYBFou0Zb3AhesM9n0RH5tA43fcdapZgY+b7F2zHKb28w/g/XhA9WlX63zSIGReUPJm
	VVmxR04GYT+yjzLp7PZN8o1ABIcqZ0e5EDixxIfotmgaTBOaNcacDD2Cftw5gPCoctNR9+Oi0Bf
	od2cSI3FRE84AE2+rB5pWXxWh23R9rW0ZjGlYjfTVrTjBtpiAbrZDJhS8/EMcOWXPIh3K1YZAnu
	2cYZ4/X23CfNQg5qpmb12EiLT6Qk8uhxGQnSAcJa7tttodw3gJC1VwfpVqBBv5H94zFtfo4m5Rn
	z52kTbaoO05VjKUDoFoxPq6vrF3v6P+gIks5HwpWDb4UTT6lObBDvRxyaYJWaOmXqCsdosp/58t
	Jx1YMGX9Md8MLBLKXp2La+ZRwhAmToYt9F3SFAdOAynWJBz3wHlYvtpvGYSXNQF6nXmxuE1o6lJ
	P/yPHmbBxrFBIymPzpIvyZOoYn9KBB1IvldIUyVuKEdvGmIINxwTMgNWCnpR4Q6pctnaT5I0tI9
	elCRbDTY+NpNyv+tKqxFmuZu0AdMkXs/HZJqWMP/BNYxaLsdIuZsVuw/S4ayj0Ic20qx7GZFBlo
	qugk/HgOYqKbgdajrr2JjMKW2SF8dFZeezmXUYDwGIgKl6IyPf/o6k7ls7C7CCZ8tj7Z
X-Received: by 2002:a05:6000:990:b0:48d:f160:efad with SMTP id ffacd0b85a97d-4911ad38a5emr11827296f8f.30.1793978407281;
        Fri, 06 Nov 2026 07:20:07 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:06 -0800 (PST)
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
Subject: [PATCH 09/20 v3] sched/fair: Optimize push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:36 +0100
Message-ID: <20261106151947.3991524-10-vincent.guittot@linaro.org>
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

Instead of always unlocking local rq in order to lock both task and rq
in a safe order, just try to lock the task. If the task is already locked
by something else its state is probably changing and the conditions used
to add it in the pushable list are probably not true anymore so skipping
the push sequence seems like a good choice.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  | 44 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h |  3 ---
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1096ea9cbc4c..d71da9069218 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2589,8 +2589,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p, int new_cpu)
+static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu)
 	__must_hold(__rq_lockp(rq))
 {
 	lockdep_assert_rq_held(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e37f8b55a293..e2999d3f88e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10148,8 +10148,7 @@ static bool fair_push_task(struct rq *rq)
 {
 	struct task_struct *next_task;
 	int prev_cpu, new_cpu;
-	struct rq_flags rf;
-	struct rq *cur_rq;
+	struct rq *new_rq;
 
 	next_task = pick_next_pushable_fair_task(rq);
 	if (!next_task)
@@ -10158,38 +10157,41 @@ static bool fair_push_task(struct rq *rq)
 	if (is_migration_disabled(next_task))
 		return true;
 
-	/* We might release rq lock */
-	get_task_struct(next_task);
-
 	prev_cpu = rq->cpu;
 
 	/*
-	 * We need to release rq lock and take both task and rq w/o
-	 * triggering a deadlock.
+	 * The safe lock ordering for task and rq is task 1st then rq but we
+	 * already get the rq so just try to get task too. If task is already
+	 * locked, it is waiting for the rq's lock and it is about to change
+	 * task state so skipping the push sequence in order to speed up the
+	 * release of the lock is the best choice.
 	 */
-	raw_spin_rq_unlock(rq);
-
-	cur_rq = task_rq_lock(next_task, &rf);
-
-	/* Task already migrated */
-	if (cur_rq->cpu != prev_cpu)
-		goto skip_push;
+	if (!raw_spin_trylock(&next_task->pi_lock))
+		return true;
 
 	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
 
 	/* Task doesn't need to migrate */
 	if (new_cpu == prev_cpu)
-		goto skip_push;
+		goto no_push;
+
+	new_rq = cpu_rq(new_cpu);
 
-	update_rq_clock(cur_rq);
-	cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
+	deactivate_task(rq, next_task, 0);
+	set_task_cpu(next_task, new_cpu);
+	raw_spin_rq_unlock(rq);
 
-skip_push:
-	task_rq_unlock(cur_rq, next_task, &rf);
+	raw_spin_rq_lock(new_rq);
+	WARN_ON_ONCE(task_cpu(next_task) != new_cpu);
+	activate_task(new_rq, next_task, 0);
+	wakeup_preempt(new_rq, next_task, 0);
+	raw_spin_rq_unlock(new_rq);
 
-	/* Restore rq state */
+	/* Restore rq lock state */
 	raw_spin_rq_lock(rq);
-	put_task_struct(next_task);
+
+no_push:
+	raw_spin_unlock(&next_task->pi_lock);
 
 	return true;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 74e68d458509..b88857dd3941 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4223,9 +4223,6 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
-struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p, int new_cpu);
-
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

