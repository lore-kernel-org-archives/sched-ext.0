Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978424;
	b=jywpO2x/rzNGT3DE4b1ojSgksnA7RkZnkIbLFvDtLft8d5zuYMgB67ANgBOEF1gVnOvu
	 Fb3ajrSh52linJi53DPUD51eX2bl0M3rDpDOrWXNAkVTZTXYqsU3F64RuiQGrw0fb5SBj
	 mVepvOvMoRLrSKjOMmvUp0sVGViGg0cN7z6uBpJ1wcK5G6nRwyIC8qlg0yId7rf1ij7kE
	 qoEQrVxkQe3aT1jl1E/a81tRarLcisRWyFpH/a1HXlag/yfsG7j2Ttol52ZetVaBCrlym
	 uEmtgG21sQSoXHqE0oPozUyJtZU6xWSqwvuEoP0VZKpfYEOAGLQw7jqiY3vsBxf8Thg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EWbonbDJjkojArAdpN+VF+9XA4YwlUvltwATo1QlbZc=;
	b=J0myFunHixwsAeOsfR35O5Dma6D5p7i7dsEUKP4+lLiCq8MBaKMfXqcsSa0w13f5ClTK
	 51DbiXTBtz5sK5P7+iGo6VvgdJd7cRmmO6cdAkNQvjSZDP0iCkTlB7rC3WZobOuXbr3fi
	 +FMEaklLMAN/rB2bX0bGQ/GVsBT0w42MzaLXrG3mEiv9lCVHye3dTe0HaBEFVrSa1ADqn
	 Qn4IGbdsiIW/9/L3y7X1bmtObDHSzN7eoDZf3VLz0Ro3qsIjIw3mxVi9HB55mSElfUfuE
	 u1MGHRMIre/R7ZkYJiLKkOTgmZ4mMP2HNZHY/I9lESwTXUHNXcsOuTgwnczhS+K2BSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HC4i19xo;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812206083627
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 812206083627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HC4i19xo
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c1d337d8so505005f8f.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978422; x=1794583222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWbonbDJjkojArAdpN+VF+9XA4YwlUvltwATo1QlbZc=;
        b=HC4i19xo84dZoEbwWWO+G4Pn7mxt0hNTlqe+mB1b849bICcOG0tnOr/5WKqys791Gs
         BWnTNaJUhj0Wvdzd7kJVw0SFHnstbyBNzVOEaf17RcZpyFwwCGgrwoLiqyHBNrEN2qiG
         qaL4cdNCfeTOMaMnfPzVZH3+pppPE4iJo8MqB8ZjXaE2534svGAdMXCkLW08Nciouexg
         U0KZR/MER37Lxww0V7NjiyDNbW8UumAiYqsLLJnEyO8VREeIt8TLuqsy6KR4rn1+3LbO
         jXLPBHb91Ct1OfQ9YtIupaobfY+T1r4m0jzz8Lts9jMv+5Q2czQRZalZhpOSe/iSt0qB
         ndbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978422; x=1794583222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWbonbDJjkojArAdpN+VF+9XA4YwlUvltwATo1QlbZc=;
        b=uTx3jlkG5ZScTSMUsIxAOdNjukPe5HQudoEMeQ6WJ1az69ZnhUgbp8QbZZa9GnZmts
         cnMIUA6I3EOHu/1gN2cKxTZuyo/sL9/spLxlV1hoN17aow1j0SCdS1LsIWr+nZGr/dVT
         9x1PSjFUlusLLR2nfCfQb3pxHk+q2f15I+1tz5vVL9kSnRKILZbGFXU3la9nv9GQm2W5
         qR6yaMj/XlT3ZqiwwcBl6RCCdk4pDOmY3OvwfgkYBK4d/5sU+rhYmPY9eY0jcyx4DABf
         VI1Gzm40GtRD7E6e9ccs5xRQj/ecJtFE90MfjnSBG4Lu4Qjds0pgFEXhuqYWPOVvRNJ0
         EIvg==
X-Forwarded-Encrypted: i=1; AL+hErEJc06aSUQGykE3stzxks4RKoUfNxVGX/ptW8nLk0sLBEuffAS3Svd8VUCqmFA5C5kscJQwiLMY2oc=@lists.linux.dev
X-Gm-Message-State: APuU4Z/RrTjXct8pxf4mJK2bbEEmmjj3zptthjQ7yUlK1u2sZcwIhsR0
	jCUgyB6QEfg0mSVdu3J4waic92LOBooO23c04FEdWqgk8Dqn8IxbvIO+ZuDp4iGQ+j8=
X-Gm-Gg: AYBFou1u0ZSup95EeM0sZqJdgocYmD6BYvYDMGauOc4ztX8U7rLUV2SYmzHKuyArfGH
	T7Q5UrUJUn/fmZ1qssqlq/2X8vIlF5O9w7brmg+1eGsjGbwz1X7FPab4+M28/zqpsStPm2rfUTn
	a+00fn4DRMIfNqi4PbUuCYpMn6ktZ+CgQ9gJZ93YTAddxSDsirGPZldtn7775ouOGjpohydO8u2
	3hPsgCsIKxlTgevm3VVWgljJp8NgxJdhkJsQ5MRQHOAaQ3UlXx3ni9e5FAI6XXzG1TfIfh8nmlJ
	SL9FjozqW3fT7B9eVHwsb3d5w102a2e01id/RnxTTJYTbeRMtEVZJxLdErPu5KpiB5ZiqYcbhPD
	j3GyboJeLSzA+busMB8JbGm2RqJ66eAC5S6JKQ78kqXg60Q0Q9MDqQcRpfFOsMvo4Qu3Hhtme5a
	KJWio/17uKCf15y7Xb8lWfXbF9ygF2sr2yO0j96UwTXURA7Fimp9vNUOSA7Ne47UZCaSAI7Adfv
	87p2Tn1t1voAM4a3FlqnRvo1NTa1bcunWWwzQ5Ri6s3gzJyN17B4R8KivvY30VyDXn9jhO3kZEG
	+zkp/0dbhZQtdONL+Grrcftn6cGFtfHIFnXkrDoVEmvF/KI=
X-Received: by 2002:adf:e009:0:20b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-4932eb8f10dmr2459869f8f.41.1793978421652;
        Fri, 06 Nov 2026 07:20:21 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:20 -0800 (PST)
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
Subject: [PATCH 17/20 v3] sched/fair: Rework feec() to use cost instead of spare capacity
Date: Fri,  6 Nov 2026 16:19:44 +0100
Message-ID: <20261106151947.3991524-18-vincent.guittot@linaro.org>
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

feec() looks for the CPU with highest spare capacity in a PD assuming that
it will be the best CPU from a energy efficiency PoV because it will
require the smallest increase of OPP. Although this is true generally
speaking, this policy also filters some other CPUs which would be as
efficients because they use the same OPP.
In fact, we really care about the cost of the new OPP that will be
selected to handle the waking task. In many cases, several CPUs will end
up selecting the same OPP and as a result use the same energy cost. In
these cases, we can use other metrics to select the best CPU for the same
energy cost.

Rework feec() to look 1st for the lowest cost in a PD and then the most
performant CPU between CPUs. The cost of the OPP remains the criteria
between Performance Domains.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 472 ++++++++++++++++++++++++--------------------
 1 file changed, 255 insertions(+), 217 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 894bee51b99a..ea117c3d0dd7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9730,29 +9730,35 @@ unsigned long sched_cpu_util(int cpu)
 }
 
 /*
- * energy_env - Utilization landscape for energy estimation.
- * @task_busy_time: Utilization contribution by the task for which we test the
- *                  placement. Given by eenv_task_busy_time().
- * @pd_busy_time:   Utilization of the whole perf domain without the task
- *                  contribution. Given by eenv_pd_busy_time().
- * @cpu_cap:        Maximum CPU capacity for the perf domain.
- * @pd_cap:         Entire perf domain capacity. (pd->nr_cpus * cpu_cap).
+ * energy_cpu_stat - Utilization landscape for energy estimation.
+ * @idx :        Index of the OPP in the performance domain
+ * @cost :       Cost of the OPP
+ * @max_perf :   Compute capacity of OPP
+ * @min_perf :   Compute capacity of the previous OPP
+ * @capa :       Capacity of the CPU
+ * @runnable :   runnable_avg of the CPU
+ * @nr_running : Number of cfs running task
+ * @fits :       Fits level of the CPU
+ * @cpu :        Current best CPU
  */
-struct energy_env {
-	unsigned long task_busy_time;
-	unsigned long pd_busy_time;
-	unsigned long cpu_cap;
-	unsigned long pd_cap;
+struct energy_cpu_stat {
+	unsigned long cost;
+	unsigned long max_perf;
+	unsigned long min_perf;
+	unsigned long capa;
+	unsigned long runnable;
+	unsigned int nr_running;
+	int fits;
+	int cpu;
 };
 
 /*
- * Compute the task busy time for compute_energy(). This time cannot be
- * injected directly into effective_cpu_util() because of the IRQ scaling.
+ * Compute the task busy time for computing its energy impact. This time cannot
+ * be injected directly into effective_cpu_util() because of the IRQ scaling.
  * The latter only makes sense with the most recent CPUs where the task has
  * run.
  */
-static inline void eenv_task_busy_time(struct energy_env *eenv,
-				       struct task_struct *p, int prev_cpu)
+static inline unsigned long task_busy_time(struct task_struct *p, int prev_cpu)
 {
 	unsigned long busy_time, max_cap = arch_scale_cpu_capacity(prev_cpu);
 	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
@@ -9762,124 +9768,161 @@ static inline void eenv_task_busy_time(struct energy_env *eenv,
 	else
 		busy_time = scale_irq_capacity(task_util_est(p), irq, max_cap);
 
-	eenv->task_busy_time = busy_time;
+	return busy_time;
 }
 
-/*
- * Compute the perf_domain (PD) busy time for compute_energy(). Based on the
- * utilization for each @pd_cpus, it however doesn't take into account
- * clamping since the ratio (utilization / cpu_capacity) is already enough to
- * scale the EM reported power consumption at the (eventually clamped)
- * cpu_capacity.
- *
- * The contribution of the task @p for which we want to estimate the
- * energy cost is removed (by cpu_util()) and must be calculated
- * separately (see eenv_task_busy_time). This ensures:
- *
- *   - A stable PD utilization, no matter which CPU of that PD we want to place
- *     the task on.
- *
- *   - A fair comparison between CPUs as the task contribution (task_util())
- *     will always be the same no matter which CPU utilization we rely on
- *     (util_avg or util_est).
- *
- * Set @eenv busy time for the PD that spans @pd_cpus. This busy time can't
- * exceed @eenv->pd_cap.
- */
-static inline void eenv_pd_busy_time(struct energy_env *eenv,
-				     struct cpumask *pd_cpus,
-				     struct task_struct *p)
+/* Estimate the utilization of the CPU that is then used to select the OPP */
+static unsigned long find_cpu_max_util(int cpu, struct task_struct *p, int dst_cpu)
 {
-	unsigned long busy_time = 0;
-	int cpu;
+	unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
+	unsigned long eff_util, min, max;
+
+	/*
+	 * Performance domain frequency: utilization clamping
+	 * must be considered since it affects the selection
+	 * of the performance domain frequency.
+	 */
+	eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util(cpu, p, -1, 0);
+	/* Task's uclamp can modify min and max value */
+	if (uclamp_is_used() && cpu == dst_cpu) {
+		min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		/*
+		 * If there is no active max uclamp constraint,
+		 * directly use task's one, otherwise keep max.
+		 */
+		if (uclamp_rq_is_idle(cpu_rq(cpu)))
+			max = uclamp_eff_value(p, UCLAMP_MAX);
+		else
+			max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
 	}
 
-	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
+	eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
+	return eff_util;
 }
 
-/*
- * Compute the maximum utilization for compute_energy() when the task @p
- * is placed on the cpu @dst_cpu.
- *
- * Returns the maximum utilization among @eenv->cpus. This utilization can't
- * exceed @eenv->cpu_cap.
- */
-static inline unsigned long
-eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
-		 struct task_struct *p, int dst_cpu)
+/* Estimate the utilization of the CPU without the task */
+static unsigned long find_cpu_actual_util(int cpu, struct task_struct *p)
 {
-	unsigned long max_util = 0;
-	int cpu;
+	unsigned long util = cpu_util(cpu, p, -1, 0);
+	unsigned long eff_util;
 
-	for_each_cpu(cpu, pd_cpus) {
-		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long eff_util, min, max;
+	eff_util = effective_cpu_util(cpu, util, NULL, NULL);
 
-		/*
-		 * Performance domain frequency: utilization clamping
-		 * must be considered since it affects the selection
-		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the min
-		 * utilization can be max OPP.
-		 */
-		eff_util = effective_cpu_util(cpu, util, &min, &max);
+	return eff_util;
+}
 
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
+/* Find the cost of a performance domain for the estimated utilization */
+static inline void find_pd_cost(struct em_perf_domain *pd,
+				unsigned long max_util,
+				struct energy_cpu_stat *stat)
+{
+	struct em_perf_table *em_table;
+	struct em_perf_state *ps;
+	int i;
 
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
+	/*
+	 * Find the lowest performance state of the Energy Model above the
+	 * requested performance.
+	 */
+	em_table = rcu_dereference_all(pd->em_table);
+	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
+	ps = &em_table->state[i];
 
-		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
-		max_util = max(max_util, eff_util);
+	/* Save the cost and performance range of the OPP */
+	stat->max_perf = ps->performance;
+	stat->cost = ps->cost;
+	i = em_pd_get_previous_state(em_table->state, pd, i);
+	if (i < 0) {
+		stat->min_perf = 0;
+	} else {
+		ps = &em_table->state[i];
+		stat->min_perf = ps->performance;
 	}
+}
 
-	return min(max_util, eenv->cpu_cap);
+/*Check if the CPU can handle the waking task */
+static int check_cpu_with_task(struct task_struct *p, int cpu)
+{
+	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
+	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
+	unsigned long util_min = p_util_min;
+	unsigned long util_max = p_util_max;
+	unsigned long util = cpu_util(cpu, p, cpu, 0);
+	struct rq *rq = cpu_rq(cpu);
+
+	/*
+	 * Skip CPUs that cannot satisfy the capacity request.
+	 * IOW, placing the task there would make the CPU
+	 * overutilized. Take uclamp into account to see how
+	 * much capacity we can get out of the CPU; this is
+	 * aligned with sched_cpu_util().
+	 */
+	if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
+		unsigned long rq_util_min, rq_util_max;
+		/*
+		 * Open code uclamp_rq_util_with() except for
+		 * the clamp() part. I.e.: apply max aggregation
+		 * only. util_fits_cpu() logic requires to
+		 * operate on non clamped util but must use the
+		 * max-aggregated uclamp_{min, max}.
+		 */
+		rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
+		rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+		util_min = max(rq_util_min, p_util_min);
+		util_max = max(rq_util_max, p_util_max);
+	}
+	return util_fits_cpu(util, util_min, util_max, cpu);
 }
 
 /*
- * compute_energy(): Use the Energy Model to estimate the energy that @pd would
- * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
- * contribution is ignored.
+ * For the same cost, select the CPU that will provide best performance for the
+ * task.
  */
-static inline unsigned long
-compute_energy(struct energy_env *eenv, struct perf_domain *pd,
-	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
+static bool update_best_cpu(struct energy_cpu_stat *target,
+			    struct energy_cpu_stat *min,
+			    int prev, struct sched_domain *sd,
+			    struct task_struct *p)
 {
-	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
-	unsigned long busy_time = eenv->pd_busy_time;
-	unsigned long energy;
+	bool target_idle = choose_idle_cpu(target->cpu, p);
+	bool min_idle = choose_idle_cpu(min->cpu, p);
+
+	/*  Select the one which is idle */
+	if (target_idle != min_idle)
+		return target_idle;
 
-	if (dst_cpu >= 0)
-		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
+	/* Favor previous CPU */
+	if (target->cpu == prev)
+		return true;
+	if (min->cpu == prev)
+		return false;
 
-	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	/*  Select the one with the least number of running tasks otherwise */
+	if (target->nr_running < min->nr_running)
+		return true;
+	if (target->nr_running > min->nr_running)
+		return false;
 
-	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
+	/*
+	 * Choose CPU with lowest contention. One might want to consider load
+	 * instead of runnable but we are supposed to not be overutilized so
+	 * there is enough compute capacity for everybody.
+	 */
+	if ((target->runnable * min->capa * sd->imbalance_pct) >=
+			(min->runnable * target->capa * 100))
+		return false;
 
-	return energy;
+	return true;
 }
 
 /*
  * find_energy_efficient_cpu(): Find most energy-efficient target CPU for the
- * waking task. find_energy_efficient_cpu() looks for the CPU with maximum
- * spare capacity in each performance domain and uses it as a potential
- * candidate to execute the task. Then, it uses the Energy Model to figure
- * out which of the CPU candidates is the most energy-efficient.
+ * waking task. find_energy_efficient_cpu() looks for the CPU with the lowest
+ * power cost (usually with maximum spare capacity but not always) in each
+ * performance domain and uses it as a potential candidate to execute the task.
+ * Then, it uses the Energy Model to figure out which of the CPU candidates is
+ * the most energy-efficient.
  *
  * The rationale for this heuristic is as follows. In a performance domain,
  * all the most energy efficient CPU candidates (according to the Energy
@@ -9916,17 +9959,14 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
-	int cpu, best_energy_cpu, target = -1;
-	int prev_fits = -1, best_fits = -1;
-	unsigned long best_actual_cap = 0;
-	unsigned long prev_actual_cap = 0;
+	unsigned long best_nrg = ULONG_MAX;
+	unsigned long task_util;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
-	struct energy_env eenv;
+	int cpu, target = -1;
+	int best_fits = -1;
+	int best_cpu = -1;
 
 	pd = rcu_dereference_all(rd->pd);
 	if (!pd)
@@ -9945,19 +9985,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_task_load_avg(p);
-	if (!task_util_est(p) && p_util_min == 0)
-		return target;
-
-	eenv_task_busy_time(&eenv, p, prev_cpu);
+	task_util = task_busy_time(p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_actual_cap, util;
-		long prev_spare_cap = -1, max_spare_cap = -1;
-		unsigned long rq_util_min, rq_util_max;
-		unsigned long cur_delta, base_energy;
-		int max_spare_cap_cpu = -1;
-		int fits, max_fits = -1;
+		unsigned long pd_actual_util = 0, delta_nrg = 0;
+		unsigned long cpu_actual_cap, max_cost = 0;
+		struct energy_cpu_stat target_stat;
+		struct energy_cpu_stat min_stat = {
+			.cost = ULONG_MAX,
+			.max_perf = ULONG_MAX,
+			.min_perf = ULONG_MAX,
+			.fits = -2,
+			.cpu = -1,
+		};
 
 		if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
 			continue;
@@ -9966,13 +10006,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		cpu = cpumask_first(cpus);
 		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_actual_cap;
-		eenv.pd_cap = 0;
-
+		/* In a PD, the CPU with the lowest cost will be the most efficient */
 		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
-			eenv.pd_cap += cpu_actual_cap;
+			unsigned long target_perf;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -9980,113 +10016,115 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util(cpu, p, cpu, 0);
-			cpu_cap = capacity_of(cpu);
+			target_stat.fits = check_cpu_with_task(p, cpu);
 
-			/*
-			 * Skip CPUs that cannot satisfy the capacity request.
-			 * IOW, placing the task there would make the CPU
-			 * overutilized. Take uclamp into account to see how
-			 * much capacity we can get out of the CPU; this is
-			 * aligned with sched_cpu_util().
-			 */
-			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
-				/*
-				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. I.e.: apply max aggregation
-				 * only. util_fits_cpu() logic requires to
-				 * operate on non clamped util but must use the
-				 * max-aggregated uclamp_{min, max}.
-				 */
-				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
-				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+			if (!target_stat.fits)
+				continue;
 
-				util_min = max(rq_util_min, p_util_min);
-				util_max = max(rq_util_max, p_util_max);
-			}
+			/* 1st select the CPU that fits best */
+			if (target_stat.fits < min_stat.fits)
+				continue;
+
+			/* Then select the CPU with lowest cost */
+
+			/* Get the performance of the CPU w/ the waking task */
+			target_perf = find_cpu_max_util(cpu, p, cpu);
+			target_perf = min(target_perf, cpu_actual_cap);
 
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
-			if (!fits)
+			/* Needing a higher OPP means a higher cost */
+			if (target_perf > min_stat.max_perf)
 				continue;
 
-			lsub_positive(&cpu_cap, util);
+			/*
+			 * At this point, target's cost can be either equal or
+			 * lower than the current minimum cost.
+			 */
 
-			if (cpu == prev_cpu) {
-				/* Always use prev_cpu as a candidate. */
-				prev_spare_cap = cpu_cap;
-				prev_fits = fits;
-			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
-				/*
-				 * Find the CPU with the maximum spare capacity
-				 * among the remaining CPUs in the performance
-				 * domain.
-				 */
-				max_spare_cap = cpu_cap;
-				max_spare_cap_cpu = cpu;
-				max_fits = fits;
-			}
+			/* Gather more statistics */
+			target_stat.cpu = cpu;
+			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
+			target_stat.capa = capacity_of(cpu);
+			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
+			if (p->on_rq && !p->se.sched_delayed && cpu == prev_cpu)
+				target_stat.nr_running--;
+
+			/* If the target needs a lower OPP, then look up for
+			 * the corresponding OPP and its associated cost.
+			 * Otherwise at same cost level, select the CPU which
+			 * provides best performance.
+			 */
+			if (target_perf < min_stat.min_perf)
+				find_pd_cost(pd->em_pd, target_perf, &target_stat);
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
+				continue;
+
+			/* Save the new most efficient CPU of the PD */
+			min_stat = target_stat;
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (min_stat.cpu == -1)
 			continue;
 
-		eenv_pd_busy_time(&eenv, cpus, p);
-		/* Compute the 'base' energy of the pd, without @p */
-		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
-
-		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
-			prev_delta = compute_energy(&eenv, pd, cpus, p,
-						    prev_cpu);
-			/* CPU utilization has changed */
-			if (prev_delta < base_energy)
-				return target;
-			prev_delta -= base_energy;
-			prev_actual_cap = cpu_actual_cap;
-			best_delta = min(best_delta, prev_delta);
-		}
+		if (min_stat.fits < best_fits)
+			continue;
 
-		/* Evaluate the energy impact of using max_spare_cap_cpu. */
-		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
-			/* Current best energy cpu fits better */
-			if (max_fits < best_fits)
-				continue;
+		/* Idle system costs nothing */
+		target_stat.max_perf = 0;
+		target_stat.cost = 0;
 
-			/*
-			 * Both don't fit performance hint (i.e. uclamp_min)
-			 * but best energy cpu has better capacity.
-			 */
-			if ((max_fits < 0) &&
-			    (cpu_actual_cap <= best_actual_cap))
-				continue;
+		/* Estimate utilization and cost without p */
+		for_each_cpu(cpu, cpus) {
+			unsigned long target_util;
 
-			cur_delta = compute_energy(&eenv, pd, cpus, p,
-						   max_spare_cap_cpu);
-			/* CPU utilization has changed */
-			if (cur_delta < base_energy)
-				return target;
-			cur_delta -= base_energy;
+			/* Accumulate actual utilization w/o task p */
+			pd_actual_util += find_cpu_actual_util(cpu, p);
 
-			/*
-			 * Both fit for the task but best energy cpu has lower
-			 * energy impact.
-			 */
-			if ((max_fits > 0) && (best_fits > 0) &&
-			    (cur_delta >= best_delta))
+			/* Get the max utilization of the CPU w/o task p */
+			target_util = find_cpu_max_util(cpu, p, -1);
+			target_util = min(target_util, cpu_actual_cap);
+
+			/* Current OPP is enough */
+			if (target_util <= target_stat.max_perf)
 				continue;
 
-			best_delta = cur_delta;
-			best_energy_cpu = max_spare_cap_cpu;
-			best_fits = max_fits;
-			best_actual_cap = cpu_actual_cap;
+			/* Compute and save the cost of the OPP */
+			find_pd_cost(pd->em_pd, target_util, &target_stat);
+			max_cost = target_stat.cost;
 		}
+
+		/* Add the energy cost of p */
+		delta_nrg = task_util * min_stat.cost;
+
+		/*
+		 * Compute the energy cost of others running at higher OPP
+		 * because of p.
+		 */
+		if (min_stat.cost > max_cost)
+			delta_nrg += pd_actual_util * (min_stat.cost - max_cost);
+
+		/* Delta energy with p */
+		trace_sched_compute_energy_tp(p, min_stat.cpu, delta_nrg,
+					      min_stat.max_perf,
+					      pd_actual_util + task_util);
+
+		/*
+		 * The probability that delta energies are equals is almost
+		 * null. PDs being sorted by max capacity, keep the one with
+		 * highest max capacity if this happens.
+		 * TODO: add a margin in energy cost and take into account
+		 * other stats.
+		 */
+		if (min_stat.fits == best_fits &&
+		    delta_nrg >= best_nrg)
+			continue;
+
+		best_fits = min_stat.fits;
+		best_nrg = delta_nrg;
+		best_cpu = min_stat.cpu;
 	}
 
-	if ((best_fits > prev_fits) ||
-	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
-		target = best_energy_cpu;
+	if (best_cpu >= 0)
+		target = best_cpu;
 
 	return target;
 }
-- 
2.53.0

