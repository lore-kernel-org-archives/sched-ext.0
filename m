Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564894E1C7E
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955916; cv=none; b=Oxsky8CKBhUgHXvYMBsjyeMnK4C5/ZD2LNXIW4eDEIhnWVOdfmv0Zch9L9eMpWD5/Nf+IXC9Roipxtdh54b0AA61ift2zEHaW/82ApAfwDdBivo/DMzPpYI+Kt99yIM9/SBQdxsgIuo+8tcz97vDhNTD9lTQBd/BuWeeAkzH/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955916; c=relaxed/simple;
	bh=/2VD4LC+odtHLOqq8yAYPNfVMXKOIt4UdVKHp/RrnnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6vy2SQIcYWJKsCMu1FUv021hXmp+bWKOVJCzibpdq6eZHIIKuEYQdgxkVfcr/ARdsC7RkeMSlQmhk7eCg3o+6xUUfXyMBMh/kOQ+LVrhG6lRKfq/c3dkTv3T8MVbCQd4N8VN4lJT+g6+bD/1eYz7bONXoh7X1/4J/RN+wVouEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVKn5Wst; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVKn5Wst"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso227145e9.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955911; x=1791560711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPyZg82TXoz+4EHOEjtMUqhGA+LRIEAnq1slizudzTs=;
        b=LVKn5WstZzDZ9iUFEmsfiQe6mfOlx2eDMRXQ/TqFUkST+eqwDIVHK1QAYWs3TOuKqR
         H8kkinsc+P3qtvPnP/e95V/mVKPSANaRMVxOX3NL5fxo51vIXmW/x/AWu9cGtEmIMBxs
         dXnNnwiuCd4MKaYh5x+6/+S+wuji+fIAT/Yzp637ZZCQPi0MwVf/6lFlLmmD6/u86meJ
         ua+SzzIJS+zV42dm56JYf18JzdsUVn7HuiQ+ej0bGy8b6io3PBu2BiS0NlW5TgEuRJOW
         AnoJwN8yqLSzbLzmaGkJrcdu3DaY9j/C7r3PUj3KQEhYE2JadQ/yE/RcwuYjAZahuwnN
         Q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955911; x=1791560711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPyZg82TXoz+4EHOEjtMUqhGA+LRIEAnq1slizudzTs=;
        b=kLCbcnK/P+GJ6p9x7yQtzzfCsUtysYUGZb6q/m35WEHQfUVgVXbrhSO220keqAF9w4
         VcFKUCqLxO5HirktWFv3zCRj3ZbpDDukMOhyJ4Cg5c/N28LOEBqkL0d54DvNS68tmmHS
         DtG3l6RJUQoAHFeAz9asnKtW8QIgt67yqTaDKKTeMKIh9AGBRsoAPV4QsU2KKB8EX5+3
         P1YMzML7rCGlfo/H/XWXF72gQNo3S0hrdwFjI5ujfOC4G1F5j9Act6bmrovb+IxaxnXc
         72P0jXSWjxCtEPd8+OBJt3c4NtrvFZ8X9LnRxrg77ny+K4d9oE80zKxlnPdJxwf+ZOqT
         fS2A==
X-Forwarded-Encrypted: i=1; AKwUvBziDIbnZ8M14wq6Qlq2mGm2+7Fir63igawqJ/6nmppIccPZZ5HWrSMmT7fGYVSgB+4ktegm/z9Jgj4=@lists.linux.dev
X-Gm-Message-State: AFuF++kjsTRQNbwPE2miZv3qfQo+Byb8DUsU5D+S+W9mDkBEQvQaM3SL
	xWNNHBSnpdyDdI6shGMdvbTXYMg8BXHtT6aywFgcwfvUxxKa4ZpA7gbA2g/DdHZHPow=
X-Gm-Gg: AYBFou0pz5iP5fHddbRja00y2IWxIIeh8Uw5GwRLD3MtZED1Fdtfq/+6AAfb3SE5Xe7
	IF0Y1D6SG9vanFQZ2hXUrnaymO+NNZfbxvqIFeNFnKE82keIkEiX/W9VEO+gAQK3+zpMj5SjdaV
	uzCSfLlMhaU5NFNEDeKuA6qE6IyBPKtyjZ+BLxuFA72XH16zvHUTVGhD0OmNMxfRrxf7cdFKGyx
	zsPAqFmvFrO4Wkm1N0LR4GwdQMRcPcHu6tgcYTwryalL4yp4lLP99dJ3q7tDtmgKSWanNJ0XgAi
	cYSyOuucmVo1FK5Nen2d6OAuiolTJFU8VV/XPgiqAHe/y43dWezaWDtqXc8YkpCP1C+Rr3m+f1W
	DfFP/xx9XhQbf1czG8RPr56v1IoRPTYviyESOYHFWnr7vYQwJeYZJLZRZ5dBPeUxlVvUWTOkiH6
	VMf7N14qIQlmffSyK2kldaFRnSLitWgViR97twnm0ZGcFiCVLKH7+O7/bgsZ7qtRvbrQ9gmCe+y
	I5/CUt5VLdnvt2Q
X-Received: by 2002:a05:600c:138b:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a02759b46fmr60064605e9.19.1790955911245;
        Fri, 02 Oct 2026 08:45:11 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:10 -0700 (PDT)
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
Subject: [PATCH 06/18 v2] sched/fair: Prepare select_task_rq_fair() to be called for new cases
Date: Fri,  2 Oct 2026 17:44:03 +0200
Message-ID: <20261002154415.2270586-7-vincent.guittot@linaro.org>
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

Update select_task_rq_fair() to be called out of the 3 current cases which
are :
- wake up
- exec
- fork

We wants to select a rq in some new cases like pushing a runnable task on a
better CPU than the local one. In such case, it's not a wakeup , nor an
exec nor a fork. We make sure to not distrub these cases but still
go through EAS and fast-path.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 57 ++++++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f38cf5a37a8a..837dc74c9a8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3618,7 +3618,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 }
 
 /*
- * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
+ * The caller (fork, wakeup, push) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
 int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19a0e67827f7..f12678850ce2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9800,46 +9800,55 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 }
 
 /*
- * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
- * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
+ * select_task_rq_fair: Select a target runqueue for the task.
+ * There are 2 ways to select the target runqueue:
+ * - The fast path which only looks for an idle CPU in the LLC or the smallest
+ *   asymmetric domain (i.e. the lowest domain with all compute capacities).
+ * - The slow path which looks for the idlest CPU in the highest domain with
+ *   the relevant SD flag set.
  *
- * Balances load by selecting the idlest CPU in the idlest group, or under
- * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
+ * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU and no
+ * flag (Push) uses the fast path.
  *
- * Returns the target CPU number.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
+	int new_cpu, cpu = smp_processor_id();
 	struct sched_domain *tmp, *sd = NULL;
-	int cpu = smp_processor_id();
-	int new_cpu = prev_cpu;
-	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
-	int sd_flag = wake_flags & 0xF;
+	int sd_flag = select_flags & 0xF;
+	int want_affine = 0;
 
 	/*
-	 * required for stable ->cpus_allowed
+	 * Required for stable ->cpus_allowed
 	 */
 	lockdep_assert_held(&p->pi_lock);
-	if (wake_flags & WF_TTWU) {
+
+	if (select_flags & WF_TTWU) {
 		record_wakee(p);
 
-		if ((wake_flags & WF_CURRENT_CPU) &&
+		if ((select_flags & WF_CURRENT_CPU) &&
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
+	}
 
-		if (!is_rd_overutilized(this_rq()->rd)) {
-			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
-			if (new_cpu >= 0)
-				return new_cpu;
-			new_cpu = prev_cpu;
-		}
+	/*
+	 * We don't want EAS to be called for exec or fork but it should be
+	 * called for any other case such as wake up or push callback.
+	 */
+	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
+		new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+		if (new_cpu >= 0)
+			return new_cpu;
+	}
 
+	if (select_flags & WF_TTWU)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
-	}
+
+	new_cpu = prev_cpu;
 
 	for_each_domain(cpu, tmp) {
 		/*
@@ -9871,8 +9880,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		return sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 
 	/* Fast path */
-	if (wake_flags & WF_TTWU)
-		return select_idle_sibling(p, prev_cpu, new_cpu);
+	if (want_sibling)
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 	return new_cpu;
 }
-- 
2.53.0

