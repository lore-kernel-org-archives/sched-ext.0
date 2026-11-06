Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978403;
	b=c0Q1Cc3xnB6pr/gMt6i2scIL9WjYpx+s0gjzDJmSj6YYLwDj9GdXPtAUhHM3AEJHLe/3
	 jb2u+kgw0Twyc15qdTwoQcPF0aBn0q+yCVA4AdRvEt5QDFaTGd5AapF6MDcAsZSL/wk4k
	 BnpwnY00LG4JDdsTcx4f5oEjA4O7bTYDLin9f9J4fhJGoaOzB6Y1N5WQXjmvk14CI59JC
	 HjG7uU6wZUrj1AqhnkjS8YibwakcYawEpWYtBVQgxB1IurI5h9SaY17ulrTfhuquX92D6
	 GGAaFlVxZoOtjGoVNXXTO7wGbH01dYDJSeILmgTdrzLOWaNtNnqjooxqJKIzstvK0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Pf+5maXqpAz569Db8vuW9XhpxdXWCoWb3bAlNcqK4w=;
	b=rEeEq7xMKVepodMeeX8X//dfzimzvl16K9WBIeRl5yEgH1nywzZ8K7/mmuqicpADgevS
	 PcIgwSTK3+K8n0bDPVHErQsD+LA4KVm3uWMtl7Ecr8McVhjkq9HqJ/Sq4ia0NVTIPx4hZ
	 nktyFrxirraKrsmyd7QJZgsBlxm7Lpj3GSGGcpjmuLMy8lOsVJx3rvbVrL7DQiNg4xfKa
	 lzYkVksJjuB+0H8z20rMw5j5rGi882+RZuI6KjnfratXQQjG0qhe1zfAIp6Toq4DjjbAT
	 T4KbnDEnre+DiNq53Ed5x1PtceFPYRAqqM3p3EGkdANFpYso72gGyIlOJEtJG5tINXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uZ+Ubk+i;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BB606D813
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195BB606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uZ+Ubk+i
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so4847855e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 07:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978400; x=1794583200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Pf+5maXqpAz569Db8vuW9XhpxdXWCoWb3bAlNcqK4w=;
        b=uZ+Ubk+ijW4toBlnEPaTzOZjzAAVOC4IdwsBrAnoJBnVxNAEyhW6oCvosiAtfZ6bpj
         5d+Xo6pJxxx3D/WzAYSKqH7DJt0m59gfV38NW07ezVp7c86xV0GkXd0AreJ8TZokydkG
         yFM8+2JLwqsoeDi7FyEbxp0EdbIML16/VybJ72Zh75kOGjlPSOWCWnkUMUzkJi/rTnkf
         jZ4xuI8zwFkySn/r1dvMlMXjXLGgbdcbhLelhtAKbkrP8Oy3kfPkoIkfIMygwXumxctq
         d48OLXL8cNNnqYpswbeLGVrUCehHel8TpwpfW7maNaf8RFT85ASXPx+l0G5cUfDbiRum
         E2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978400; x=1794583200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Pf+5maXqpAz569Db8vuW9XhpxdXWCoWb3bAlNcqK4w=;
        b=ePrdECRKhhBm+VwUZovAEaxeHALnh9dPo7bWHbydhh6NEDaSeV/CxzdKQpDzZdHWGa
         LM31pVQiKJ8k7/ti2vmix7flSr9lyYomCUcf/2zxxfs3j3MI/NOIVkOdpDA3zaKBLxEp
         ntL+3jmdq0uMWBKs7IwpJAM8E+iUfLvttMyk+5E9bt+pbOYuMyIoKFNBGaoGetSsbDlz
         ZGnTG9YhJW35XDu+zyySrk7El3ibNMlJIw3D9Zgjed50IdB2SXsu52kFXZN1pCXSi69J
         KN2qMClzSvIq1G8G016UtMIZrl20QYUDwQLBFIwAlehWeThP+RLe3oCAm/xI0A2sn1QN
         B7nA==
X-Forwarded-Encrypted: i=1; AKwUvBwykrrxm1fxmCFmVz35a6K8MFyoqdn5kMbrD7ptgAj+8iIRRNUgcxfgOjcx5HZj5RKHWtifIyHjjVE=@lists.linux.dev
X-Gm-Message-State: APuU4Z9C8Rpzz+esNPIex9EmULzob2smp/SYRNM1QGO1J5KpLnof1CI3
	SZAZ6mLmHBxsAne2EtEkRjk71l0xUHnr80c65MT05th33Hd0kGid1VqkpW5SGaPvPyA=
X-Gm-Gg: AYBFou0vJLMg7BTp44A4l7zDybS3EHJkIsTxKLENJmyVoeNl1lve9GKAFwwpgdDHwA6
	6hNR/zRrk0eRPAnxUzJAkMCqe9OvNuR25w5jKnAw2HachZlAeioHIaz6k/cacdZsNlh5/mtsATX
	nkMGBuyzqBtssMMEMGVjQudKC1lFOqIiahlfbrBNxQbns7XnAnuKJkkcqyN6ugG0KzFySCn6q+0
	gwEIBvfzb1A8EIh1OsMUmsyr/yZ1FCoztA6Hwsl7lKtMhT/GGkwe6QBAdMQBIUM6qc2KBeyDjG/
	t6hMgmAmRNAXYOhq53QUok1okYd96rWpoTh7+FbY2ShAPMaVQoI25UUfBrxbBDRLpmk36doCUgF
	q4YR+O8F5vhz9qBzStF6CYGNgM2OoORZyr5o4QzOjOpfGBbQIqbTWaqFHa22dNYbH0XMJVzAVw5
	gW7rruaGCz6w5+EEL8MkzsKR9u3wHrf5YiZBLNNbPwN7k79x9j7l51ZOCYxZb770JCPZmGHak8f
	IjemoFxJGN8psWub5lp6capoOMHDH9wCQSdVruiCSaGs5SA/E9JDMVZ8o++Y9MmNvM23NYNs7YN
	NU/hLt72TMpfWo9nJz4wUQJBVJVupX0JHAiwtN5kss43NhE=
X-Received: by 2002:a05:600c:5294:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4b6dc40027cmr50426165e9.3.1793978400357;
        Fri, 06 Nov 2026 07:20:00 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:59 -0800 (PST)
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
Subject: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
Date: Fri,  6 Nov 2026 16:19:33 +0100
Message-ID: <20261106151947.3991524-7-vincent.guittot@linaro.org>
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

Add a new level for selecting CPU when select_task_rq_fair() fails to find
an idle CPU. This last level compares the min slice to select a CPU where
the task could run 1st.
This helps a waking task to select a CPU where a longer slice runs
instead of one where a task with the same or shorter slice already runs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c |   2 +-
 kernel/sched/fair.c | 157 ++++++++++++++++++++++++++++----------------
 2 files changed, 102 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 031efe7d49fb..d71da9069218 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9012,7 +9012,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
-		rq->min_slice = ULONG_MAX;
+		rq->min_slice = 0;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc99b94d9ce..039dce244aaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8842,11 +8842,25 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 	return new_cpu;
 }
 
-static inline int __select_idle_cpu(int cpu, struct task_struct *p)
+static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
 {
-	if (choose_idle_cpu(cpu, p) && sched_cpu_cookie_match(cpu_rq(cpu), p))
+	if (p->se.slice < get_rq_min_slice(rq))
+		return true;
+
+	return false;
+}
+
+static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *slice_cpu)
+{
+	if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
+		return -1;
+
+	if (choose_idle_cpu(cpu, p))
 		return cpu;
 
+	if (*slice_cpu == -1 && choose_sched_slice_rq(cpu_rq(cpu), p))
+		*slice_cpu = cpu;
+
 	return -1;
 }
 
@@ -8937,7 +8951,8 @@ void __update_idle_core(struct rq *rq)
  * sd_balance_shared->has_idle_cores and enabled through update_idle_core()
  * above.
  */
-static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
+static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus,
+			    int *idle_cpu, int *slice_cpu)
 {
 	bool idle = true;
 	int cpu;
@@ -8946,11 +8961,18 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (choose_sched_idle_rq(cpu_rq(cpu), p) &&
-				    cpumask_test_cpu(cpu, cpus)) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (choose_sched_idle_rq(cpu_rq(cpu), p)) {
 					*idle_cpu = cpu;
 					break;
 				}
+
+				if (*slice_cpu == -1 &&
+				    choose_sched_slice_rq(cpu_rq(cpu), p))
+					*slice_cpu = cpu;
+
 				continue;
 			}
 			break;
@@ -8994,10 +9016,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
+			   bool has_idle_core, int *best)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, slice_cpu = -1, target = *best, nr = INT_MAX;
 
 	if (sched_feat(SIS_UTIL) && sd->shared) {
 		/*
@@ -9027,13 +9050,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 					continue;
 
 				if (has_idle_core) {
-					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					i = select_idle_core(p, cpu, cpus, &idle_cpu, &slice_cpu);
 					if ((unsigned int)i < nr_cpumask_bits)
 						return i;
 				} else {
 					if (--nr <= 0)
-						return -1;
-					idle_cpu = __select_idle_cpu(cpu, p);
+						goto abort_idle_cpu;
+					idle_cpu = __select_idle_cpu(cpu, p, &slice_cpu);
 					if ((unsigned int)idle_cpu < nr_cpumask_bits)
 						return idle_cpu;
 				}
@@ -9044,14 +9067,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
-			i = select_idle_core(p, cpu, cpus, &idle_cpu);
+			i = select_idle_core(p, cpu, cpus, &idle_cpu, &slice_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 
 		} else {
 			if (--nr <= 0)
-				return -1;
-			idle_cpu = __select_idle_cpu(cpu, p);
+				goto abort_idle_cpu;
+			idle_cpu = __select_idle_cpu(cpu, p, &slice_cpu);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
 		}
@@ -9060,6 +9083,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
+abort_idle_cpu:
+	if (idle_cpu == -1 && !choose_sched_slice_rq(cpu_rq(target), p) && slice_cpu != -1)
+		*best = slice_cpu;
+
 	return idle_cpu;
 }
 
@@ -9074,16 +9101,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
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
- *   ASYM_IDLE_THREAD_FITS           -2   thread  Busy SMT sibling; capacity
+ *   ASYM_IDLE_THREAD_FITS           -3   thread  Busy SMT sibling; capacity
  *                                                fits util + uclamp.
+ *   ASYM_BUSY_THREAD_FITS           -2   thread  Busy CPU and SMT sibling but
+ *						  capacity fits and task can
+ *						  preempt current.
  *   ASYM_IDLE_THREAD_UCLAMP_MISFIT  -1   thread  Busy SMT sibling; capacity
  *                                                fits but uclamp_min misses
  *                                                (native util_fits_cpu()
@@ -9091,24 +9123,26 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
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
- * ASYM_IDLE_THREAD_FITS (-2) is never rebased because a fully-fitting idle-core
+ * ASYM_IDLE_THREAD_FITS (-3) is never rebased because a fully-fitting idle-core
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
@@ -9127,6 +9161,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	bool has_idle_core = sched_smt_active() && test_idle_cores(target);
 	unsigned long task_util, util_min, util_max, best_cap = 0;
 	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
+	unsigned long task_slice;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 	int nr = INT_MAX;
@@ -9137,6 +9172,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	task_util = task_util_est(p);
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
+	task_slice = p->se.slice;
 
 	if (sched_feat(SIS_UTIL) && sd->shared) {
 		/*
@@ -9160,42 +9196,49 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
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
+			 *    ASYM_BUSY_THREAD_FITS - fits with the exception of idleness
+			 *			      but can preempt current
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
-		 * of [ASYM_IDLE_THREAD_UCLAMP_MISFIT, ASYM_IDLE_THREAD_MISFIT] to
-		 * [ASYM_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT].
+		 * of [ASYM_BUSY_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT] to
+		 * [ASYM_BUSY_FITS, ASYM_IDLE_COMPLETE_MISFIT].
 		 * This ensures that an idle core is always given priority over
 		 * (partially) busy core.
 		 *
@@ -9219,15 +9262,17 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 	/*
 	 * A value in the [ASYM_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT]
-	 * range means the chosen CPU is in a fully idle SMT core. Values above
-	 * ASYM_IDLE_COMPLETE_MISFIT mean we never ranked such a CPU best.
+	 * range mean the chosen CPU is in a fully idle SMT core. Values
+	 * ASYM_BUSY_FITS or above ASYM_IDLE_COMPLETE_MISFIT mean we never
+	 * ranked such a CPU best.
 	 *
 	 * The asym-capacity wakeup path returns from select_idle_sibling()
 	 * after this function and never runs select_idle_cpu(), so the usual
 	 * select_idle_cpu() tail that clears idle cores must live here when the
 	 * idle-core preference did not win.
 	 */
-	if (has_idle_core && best_fits > ASYM_IDLE_COMPLETE_MISFIT)
+	if (has_idle_core && (best_fits > ASYM_IDLE_COMPLETE_MISFIT ||
+			      best_fits == ASYM_BUSY_FITS))
 		set_idle_cores(target, false);
 
 	return best_cpu;
@@ -9381,7 +9426,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
-	i = select_idle_cpu(p, sd, has_idle_core, target);
+	i = select_idle_cpu(p, sd, has_idle_core, &target);
 	if ((unsigned int)i < nr_cpumask_bits) {
 		target = i;
 		goto select_smt_priority;
-- 
2.53.0

