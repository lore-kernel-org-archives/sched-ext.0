Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFE4ED18D
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955914; cv=none; b=G33fDuy6lhQPYtWVvzoRvMtKSFr/yoxijBvbahgMRh2pscXOH91Ypu8sprLCPMkduI2jC9MknHeupyMjJuor1yEyklPfgfmd+KjxvsAdvA6CfUI/TLZf+LMq9Qi0hraWYUE9+AH9DARJdn24mm6/nrZ4y3J5b6M04KwxQGknayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955914; c=relaxed/simple;
	bh=WZVknkITQWs7oWBi+0A58jnM26FncEnONNZjHL6TLOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZs3L0h4J0wLNYMpTz3eXLfFPCuDMmPqJCjgYsyqjbe4XMAi0PzZ2tYoPTvh4k2xcpipszAExfgdMgVQTNMhdRHmhBJgVdL6NZMdV2abQGkHO9oM3Qtmf4o/zvucqGvW4ArfZsCAjgheK5MilIBZsmfBARJX9Pb3I9Ne8QYmyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzDdcX4Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzDdcX4Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so396305e9.0
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955910; x=1791560710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ioyIM3L446Zr1EwfEa+dONNeCVeHZuOjQgRKhrViUkI=;
        b=JzDdcX4YYomercAQjhYkBn5FlyZpqXqDACTTlY3ejOA7KPGXELDEA7VM7w24V08NIM
         eW/at50G4cjPHpRnoja0c9t2VBXbnnlmPsJE1C6WDg+M19i7ZqbCdg6RCnYzQg96HBfj
         zLUPa79hm+xq92cZzOP1vAMTf/JXA6/6OkCVl3NsX6340/tnyweWnPmAvcDdrshy4XtG
         Ote4BuUK50eiBvrRmfr3OFkLq8Whge/k4y4YX/Cxx4Enc+aMCY5kAXhimbpQURZ2l2i2
         3gQ3UIyj6fPcfqhWRUeuDqevwpI9CYj1vxb7IfOeiNCCZ1zbPOsrtZLlsXsQ1PqZOIbX
         5h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955910; x=1791560710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ioyIM3L446Zr1EwfEa+dONNeCVeHZuOjQgRKhrViUkI=;
        b=N0LG9+w1HkS45c3FC/5d7NDoOofuEJ5LbmgNNyMQfQdBpkXXN8YpVSiF8uoGrpGlGs
         uWvGA+W2f4TDO7ciwNqAFEv2b9DNdA1V8VKU1KB/5umszQcN2VwyBq55Vbay+ZqfJW+7
         qDMJlyzkVIRaDXeqwIjkXsmq/3UF6GlZ0ZhZAqXr3qL8NCpAaBUxSCTk0EtD+zaRWcYr
         lvQcbfmSCnLasCCRpfZzuqPPVuBej61a8/r7ICze5TDtKoSDByDf9DyeKc6oUvMTeKgz
         wkv7RUWhsvtpDGIG1mJczuMCOlkU6LXx+0kNoKtHRjhZKB5cMZqWNw/J3ksdZdHWe6RG
         tVSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTCuSeCafQ1/3+Kww+g/068b1plb98Dbx7FB2963mnIKQ34C4/7Ixxk6A8RWWkPh/maANuDz79dHA=@lists.linux.dev
X-Gm-Message-State: AFuF++mdZJtXdVgdwMUKgcuX+Rj7O7TxlvCrBk2YMf4V6T468EoliaLX
	/6AWm9S2mdDo2n7+T3tRbrkedkxx1pAMXRxa2n5Ywn4/kK/Dw1HQ1tWFZyx8Uaj8dew=
X-Gm-Gg: AYBFou1Fsh39OQM81bwDErBjpyG3yKh9IFZDE3vAnbLGaV7B1i/N9WNYOjwqqU/VrYC
	DjPPP6YSO4qupegFIo5qV8yZoMHuqeXKYMLzMOVpsAKd1oiOO9t4JVXkFwdO453O65Ui7TskeC1
	VkUkwF9dHACOjx6dba/kVCUDUVnhEM4iLjs9oiHdfcnNS8MY4f+vwWOoHY5Rf140GknnjCdco+3
	4vhl+2ElVHWPV2UwVR67891YVty7u+jR+yo73EgUPbJlNhyBDILuNASkuqvL69Fw9wp2fb7/SDu
	xTqz1Qe+qflUSTTfyob1ySxF++kJrL15R7HU0NBbMU05iUKdM9wQvwSJclSVVmN68zxMu2HH9VK
	6qtP7psuycJxVFH8uU49WqSFD89j3jR+w6F2aIn5td2BGrN5CHgcTZabd4/8E5sfUGzlHMWWhet
	5BqpS7XaEf4ED/wnWAF3qzcibMeVZRrr/0SMpWz+KQy6exXa1DfNt6wltO3aQtTeNIkIfOG5zq5
	iaJ0GgTaxnzK5rpDRXBHF4z1Mo=
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-4a027594557mr51582015e9.19.1790955909863;
        Fri, 02 Oct 2026 08:45:09 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:07 -0700 (PDT)
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
Subject: [PATCH 05/18 v2] sched/eevdf: Add min slice check when selecting CPU
Date: Fri,  2 Oct 2026 17:44:02 +0200
Message-ID: <20261002154415.2270586-6-vincent.guittot@linaro.org>
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

Add a new level for selecting CPU when select_task_rq_fair() fails to find
an idle CPU. This last level will compare the slice to select a CPU where
the task could run 1st.
This helps a waking task to select a CPU where a longer slice runs
instead of one where a task with the same or shorter slice already run.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 106 ++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eeac0aaba3cd..19a0e67827f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8771,10 +8771,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int *best)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, slice_cpu = -1, target = *best, nr = INT_MAX;
+	unsigned long task_slice;
 
 	if (sched_feat(SIS_UTIL) && sd->shared) {
 		/*
@@ -8795,6 +8796,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr))
 		return -1;
 
+	task_slice = p->se.slice;
+
 	if (static_branch_unlikely(&sched_cluster_active)) {
 		struct sched_group *sg = sd->groups;
 
@@ -8814,6 +8817,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 					if ((unsigned int)idle_cpu < nr_cpumask_bits)
 						return idle_cpu;
 				}
+
+				if (slice_cpu == -1 &&
+				    task_slice < get_rq_min_slice(cpu_rq(cpu)))
+					slice_cpu = cpu;
 			}
 			cpumask_andnot(cpus, cpus, sched_group_span(sg));
 		}
@@ -8832,11 +8839,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
 		}
+
+		if (slice_cpu == -1 &&
+		    task_slice < get_rq_min_slice(cpu_rq(cpu)))
+			slice_cpu = cpu;
 	}
 
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
+	if (slice_cpu != -1)
+		*best = slice_cpu;
+
 	return idle_cpu;
 }
 
@@ -8851,14 +8865,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
  *
  *   Rank                            Val  Tier    Meaning
  *   ------------------------------  ---  ------  ---------------------------
- *   ASYM_IDLE_UCLAMP_MISFIT         -4   core    Idle core; capacity fits
+ *   ASYM_BUSY_FITS                  -6   core    Busy core but capacity fits
+ *						  and task can preempt current.
+ *   ASYM_IDLE_UCLAMP_MISFIT         -5   core    Idle core; capacity fits
  *                                                util but uclamp_min misses.
- *   ASYM_IDLE_COMPLETE_MISFIT       -3   core    Idle core; capacity does
+ *   ASYM_IDLE_COMPLETE_MISFIT       -4   core    Idle core; capacity does
  *                                                not fit. Still beats every
  *                                                thread-tier rank: a busy
  *                                                sibling cuts effective
  *                                                capacity more than a
  *                                                misfit hurts a quiet core.
+ *   ASYM_BUSY_THREAD_FITS           -3   thread  Busy CPU and SMT sibling but
+ *						  capacity fits and task can
+ *						  preempt current.
  *   ASYM_IDLE_THREAD_FITS           -2   thread  Busy SMT sibling; capacity
  *                                                fits util + uclamp.
  *   ASYM_IDLE_THREAD_UCLAMP_MISFIT  -1   thread  Busy SMT sibling; capacity
@@ -8868,24 +8887,26 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
  *   ASYM_IDLE_THREAD_MISFIT          0   thread  Busy SMT sibling; capacity
  *                                                does not fit.
  *
- * ASYM_IDLE_CORE_BIAS (-3) is an offset, not a state. On an idle core,
+ * ASYM_IDLE_CORE_BIAS (-4) is an offset, not a state. On an idle core,
  * fits += ASYM_IDLE_CORE_BIAS rebases thread-tier ranks into the core tier:
  *
- *   ASYM_IDLE_THREAD_UCLAMP_MISFIT (-1) + BIAS -> ASYM_IDLE_UCLAMP_MISFIT   (-4)
- *   ASYM_IDLE_THREAD_MISFIT         (0) + BIAS -> ASYM_IDLE_COMPLETE_MISFIT (-3)
+ *   ASYM_IDLE_THREAD_UCLAMP_MISFIT (-1) + BIAS -> ASYM_IDLE_UCLAMP_MISFIT   (-5)
+ *   ASYM_IDLE_THREAD_MISFIT         (0) + BIAS -> ASYM_IDLE_COMPLETE_MISFIT (-4)
  *
  * ASYM_IDLE_THREAD_FITS (-2) is never rebased because a fully-fitting idle-core
  * candidate early-returns from select_idle_capacity().
  */
 enum asym_fits_state {
-	ASYM_IDLE_UCLAMP_MISFIT = -4,
+	ASYM_BUSY_FITS = -6,
+	ASYM_IDLE_UCLAMP_MISFIT,
 	ASYM_IDLE_COMPLETE_MISFIT,
 	ASYM_IDLE_THREAD_FITS,
+	ASYM_BUSY_THREAD_FITS,
 	ASYM_IDLE_THREAD_UCLAMP_MISFIT,
 	ASYM_IDLE_THREAD_MISFIT,
 
 	/* util_fits_cpu() bias for idle core */
-	ASYM_IDLE_CORE_BIAS = -3,
+	ASYM_IDLE_CORE_BIAS = -4,
 };
 
 /*
@@ -8904,6 +8925,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	bool has_idle_core = sched_smt_active() && test_idle_cores(target);
 	unsigned long task_util, util_min, util_max, best_cap = 0;
 	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
+	unsigned long task_slice;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 	int nr = INT_MAX;
@@ -8914,6 +8936,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	task_util = task_util_est(p);
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
+	task_slice = p->se.slice;
 
 	if (sched_feat(SIS_UTIL) && sd->shared) {
 		/*
@@ -8937,42 +8960,47 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		if (!has_idle_core && --nr <= 0)
 			return best_cpu;
 
-		if (!choose_idle_cpu(cpu, p))
-			continue;
-
 		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
 
-		/*
-		 * Perfect fit: capacity satisfies util + uclamp and the CPU
-		 * sits on a fully-idle SMT core, this is a !SMT system, or
-		 * there is no idle core to find.
-		 * Short-circuit the rank-based selection and return
-		 * immediately.
-		 */
-		if (fits > 0 && preferred_core)
-			return cpu;
-		/*
-		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
-		 * Look for the CPU with best capacity.
-		 */
-		else if (fits < 0)
+		if (choose_idle_cpu(cpu, p)) {
+			/*
+			 * Perfect fit: capacity satisfies util + uclamp and the CPU
+			 * sits on a fully-idle SMT core, this is a !SMT system, or
+			 * there is no idle core to find.
+			 * Short-circuit the rank-based selection and return
+			 * immediately.
+			 */
+			if (fits > 0 && preferred_core)
+				return cpu;
+			/*
+			 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
+			 * Look for the CPU with best capacity.
+			 */
+			else if (fits < 0)
+				cpu_cap = get_actual_cpu_capacity(cpu);
+			/*
+			 * fits > 0 implies we are not on a preferred core, but the util
+			 * fits CPU capacity. Set fits to ASYM_IDLE_THREAD_FITS
+			 * so the effective range becomes
+			 * [ASYM_IDLE_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT], where:
+			 *    ASYM_IDLE_THREAD_MISFIT - does not fit
+			 *    ASYM_IDLE_THREAD_UCLAMP_MISFIT - fits with the exception of UCLAMP_MIN
+			 *    ASYM_IDLE_THREAD_FITS - fits with the exception of preferred_core
+			 */
+			else if (fits > 0)
+				fits = ASYM_IDLE_THREAD_FITS;
+
+		} else if (fits > 0 && task_slice < get_rq_min_slice(cpu_rq(cpu))) {
+			fits = ASYM_BUSY_THREAD_FITS;
 			cpu_cap = get_actual_cpu_capacity(cpu);
-		/*
-		 * fits > 0 implies we are not on a preferred core, but the util
-		 * fits CPU capacity. Set fits to ASYM_IDLE_THREAD_FITS
-		 * so the effective range becomes
-		 * [ASYM_IDLE_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT], where:
-		 *    ASYM_IDLE_THREAD_MISFIT - does not fit
-		 *    ASYM_IDLE_THREAD_UCLAMP_MISFIT - fits with the exception of UCLAMP_MIN
-		 *    ASYM_IDLE_THREAD_FITS - fits with the exception of preferred_core
-		 */
-		else if (fits > 0)
-			fits = ASYM_IDLE_THREAD_FITS;
+		} else {
+			continue;
+		}
 
 		/*
 		 * If we are on a preferred core, translate the range of fits
 		 * of [ASYM_IDLE_THREAD_UCLAMP_MISFIT, ASYM_IDLE_THREAD_MISFIT] to
-		 * [ASYM_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT].
+		 * [ASYM_IDLE_THREAD_MISFIT_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT].
 		 * This ensures that an idle core is always given priority over
 		 * (partially) busy core.
 		 *
@@ -9147,7 +9175,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
-	i = select_idle_cpu(p, sd, has_idle_core, target);
+	i = select_idle_cpu(p, sd, has_idle_core, &target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.53.0

