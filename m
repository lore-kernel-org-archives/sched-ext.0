Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33131457E59
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=EXsS6AGutXpfi56sem3i5jtJH8h4fQEg5gRijz0aw0FZ6pzKWFyrLkR9b7s3FQDMJherNJAApVXrT7cGwj2j2v7sYlmKdxu12ExD7ANm0OvGr2rZ+CWxywVMdnDdo8E1UNWb9LeUOtVewxbYihnTxr0LpEsmVH3a/hm1LqwKKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=7hap95mxpTk9UW2dteAHIfeOd/zesefXqWk9LTMKroo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGSGTkliG8fbl6/0cTR+42+W0KdFFoSpOxgEV6N65XQd3MGN/cI4UjlvBvYvK6qmS4Xuj4OjWrN0SEIrr8pm7o9K4h2TxhoqvOe4romWQv6n8Qpp4wx3/wfBFQ9phUHsdSIRT44h3OWx0OMkcqvZQFF0nnwQAUU1sZjOMEs+eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEaMuH14; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEaMuH14"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so186195e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955918; x=1791560718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twXh4IEgj3c3B1TaynWUaOppTXyXcqyaqn780+9h4uM=;
        b=jEaMuH14NUS1tNWyufU2uaUnXK14GZdQNyiGXHVaa4K4dMylQ6b3oRTpv/7RGKZaWb
         R+5R5vKwziya5Qg+NGZTureQYf4cTXeAELY3Fr8cdMRwSuEA0UzEPp2i+34JNvzFdZm/
         dUqKHz14xjo87MQu5psJJP2zUjOkgfhVPZVKhURgOkBVx3w0R63+56Ym/hpxEXjbThvK
         clUfJHwq+iDqdIajcaQwyBBbS8CRLwnCfayyJzWZZ7giFQMg1b3VHdgeTnAeai3ULo99
         k8TqkynMId0mMyvcqKN34KilZp5SmtIBnFrro2rX5CSFXUuqpaMq+eBZfTReETUzqV09
         xEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955918; x=1791560718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=twXh4IEgj3c3B1TaynWUaOppTXyXcqyaqn780+9h4uM=;
        b=kEC6LpVhwrmQx1bXqZ6ExPS7hGL6ytnnBx3FuWneULNbyn7ccTkPmJ/3JeKJEmgX4L
         bFGi1n/oGn2gzOLTmkrzhdmMpEbeh5LltDwFsuDhkjnFXnwVq+6eEwbFZ1EbaLUwsDFY
         Rwj14rumzBkM2vcpKgU1t833j7uaTq9vY/rxaMtnTE6efahld3ldaSsf1xb7M5nP9THP
         LyOXCbswbVWgc/73KcDLS4YLeKFHa6P/QUDc+G3U1+pEIWMS3SQXQjusFDtSW9XoJKqi
         czzB/1uxN/U08xiPNWo7GCB5hWo/80fMRT71KYBOlunxpszHstYMRyWB+iPBddpn2Xme
         W+Rg==
X-Forwarded-Encrypted: i=1; AKwUvBzomEGmPgEztZnZKOrEBmuLn/bNAjkzcNDI0FfB9O+96HJSY1cMWk6gQXb2/kkuSuOiuR2d+6uPj2g=@lists.linux.dev
X-Gm-Message-State: AFuF++m2D8xwilDs40/1h2XVJoI9EsLckeH6nTCHPzc6Gx/a/nizF99q
	EMm0BSqXjOTjJ5LLhqK6NREXUpfMr9jq5bEEewhy2HaGK0Kxz4DjHtGoewGeK3ozxTs=
X-Gm-Gg: AYBFou3Po+KwMovAwXApNorJxsHbBjcy5sojRYfXHJVKE+HPvgtGfTicVg1eMe4LUrm
	FRYZ93iRC1y2wxjDYyCPcB236k0vHK8cosx0S1d4piDHkGP1Smaqz4gG2GFAwz2ppd2Mq4nl6w0
	DnQ+qEhjJLIr+112eljolLec+FgH6dBjIZmJVEc1XC8l4E+s78aBwoNOOw76fz0AahRQ9Lg31RJ
	e9DDFA383F2IJmf+F3375xl+3V7a4XQ165ngd3VrhiVyeEfc4SftQXBza5tHmfUttsflxyQw2f0
	pJ4DfYInM7rS9Zpqlp6XY0CUnBhURo8sqGGmOc0X/13ITD6EftCZbZNHOJ8Y1GMHz+r741jZUEJ
	ZGTps2Khl+VBVHvFhJe9A7wW+niSLBZrC0VvD7Lv1YWgbIbdSVMXw4Qk0X4wPstilZP7HBDEK7M
	KugkRgNbMXouJ7kg3a+L/QOemeEtIxi3gUqiF6uM8rsqauY1lnTle5bvTON6M9uuyhrcjCEilcS
	vsJb3BrLbhnBr1e
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr63230245e9.12.1790955918295;
        Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:17 -0700 (PDT)
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
Subject: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Fri,  2 Oct 2026 17:44:07 +0200
Message-ID: <20261002154415.2270586-11-vincent.guittot@linaro.org>
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

When the task is alone on the CPU, it's never put back in the enqueued
list; In this special case, we use the tick to run the check used to push
runnable task on a btter CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 71 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 483ed5807dfc..6ed3e5bb7fd6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9955,6 +9955,71 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, stru
 		__fair_add_pushable_task(rq, prev);
 }
 
+static int active_load_balance_cpu_stop(void *data);
+
+/*
+ * See if the alone task running on the CPU should migrate on a better than
+ * the local one.
+ */
+static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_push_task_enabled())
+		return false;
+
+	if (!rf)
+		return false;
+
+	if (WARN_ON(!p))
+		return false;
+
+	if (WARN_ON(!task_current(rq, p)))
+		return false;
+
+	if (is_migration_disabled(p))
+		return false;
+
+	/* If there are several task, wait for being put back */
+	if (rq->nr_running > 1)
+		return false;
+
+	if (!fair_check_pushable_task(rq, p, NULL))
+		return false;
+
+	if (!raw_spin_trylock(&p->pi_lock))
+		return false;
+
+	new_cpu = select_task_rq_fair(p, cpu, 0);
+
+	raw_spin_unlock(&p->pi_lock);
+
+	if (new_cpu == cpu)
+		return false;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else {
+		return false;
+	}
+
+	preempt_disable();
+	rq_unlock(rq, rf);
+	stop_one_cpu_nowait(cpu,
+			    active_load_balance_cpu_stop, rq,
+			    &rq->active_balance_work);
+	preempt_enable();
+	rq_lock(rq, rf);
+
+	return true;
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -15373,8 +15438,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_fl
 
 	task_tick_cache(rq, curr);
 
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!tick_pushable_task(curr, rq, rf)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.53.0

