Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323942;
	b=xUno4ybRwigs47U17gBSkglWZePyUwhV6kmLNqJdvlp5OZZNtMvkqp9si5ea+DNF65A6
	 4J9dnQDdNTdTbfUwCigb1hj3yHLaAmG9tbBWsrknYkzIM5D3YR3iMlNH+w0q7o7dxRmrz
	 62ucdhSQj/f3SkA9FQzyVYJOHLjCxKa/7iiranBone6oRUbLZ1oJWCz2qxKBYuZLXXaii
	 zvHSgxAB6ET7JOTQkfEkY9dLxowLLecst8Ykp0FPCYf1+Hu0Gzk1bEajkK5GyxZH9A4r2
	 WVe7hNu8O158PFhpFd7tFR9pM2xaDHuJx0xxxqrBmcjmEaG/61O4LF/YQ8lxYrWT/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=meXl6cdPMOiFQd1MWbHvUuZLpLChUkZmfs0n7XP8iAY=;
	b=NhD47IhwxWeNs0n4wAjbOxDIJhGKTxr6IxTc+01bFLJuF0fOkNXqeYRkthGDHwrTqMbe
	 13nCPeB9rs2WpOzvkZJYOELBnLY41ujySuKEVll+pUaIbqhBjlDICp5vlij79H6AjhH3J
	 xs9ec/gsR5/Yn4ORkZLljzSqW859RD4IGmuGxVipF1lKcOefpd6Gmt54LEIS6uGk+Pn+j
	 hhgAQyCkKuDCbQneM2J2PCJP+3k35iv4vH+x1F1CP8SthCHZjl+37b5mGNnhlvtiPGO/a
	 qc54MVACALDw3ZAsqqlHRDVnGeP7+AQggSvflEOQb7UbO0Vbdr+rYA8VKEwOkeS9gog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oqv8UAoP;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A960A260F
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 15:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628A960A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oqv8UAoP
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50593b3eebso45360966b.0
        for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794323941; x=1794928741; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meXl6cdPMOiFQd1MWbHvUuZLpLChUkZmfs0n7XP8iAY=;
        b=oqv8UAoPDG2wM1d3kKzKqjKnLldP08vmM7ZPZ7lXfUxhBu1YeAd8jf+gBQeuLnkZFR
         69jk3K7wt5Zc9Qyr3Tdlyx+vdua3YdFFscUEyko+yWr5Z99Es2TSmjfjrD68HYotTyTb
         lJMBAi/oJc9eT+VjIeQtncLavDzpl+UT2iXeiMxfHNZ7rTEyjmC/zJ52acvaf1XpkZkm
         FRMAM9DC0pic3LhtfddCAYalHc+S7Vme0VYMog3b0PBQtP8IPkMDzAI7bDVCUU+QW/C6
         AJZVFSETOMNd8mGJHmG500TUsxz/rFGRqtCs7/0HgHpvPNdu+oI9aDYaRDv9Aoieykuo
         A5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323941; x=1794928741;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meXl6cdPMOiFQd1MWbHvUuZLpLChUkZmfs0n7XP8iAY=;
        b=jp7RNVHJHnRWr8LHH6Ulb0vRlG7OF6mDD9xjseuBHE7Hx60yX2WarEG2xTQcCwTmMQ
         TPTox1FaMgKHsJsUPDomDQR4AV6RnlAWgGmXtw5BN6lpKq1e5gUmV04nPLo6h6fJk8Vo
         /CpAFDksvxfgsrscx2/KgWNYqa2QeL4wpoxCbiOgiufl80vTIonqqR434H+CUnk1mGFU
         LfmvveesB5Rqaji4FlAO5gJLFxZ7sZ0f/2Z1cyctWwU23fTgwcotoNaQSb+Vaqn+q7/2
         5cUa85OGt2XvrkfkNU3EWvCME+l5U3zUwKxsHeBOBdjPHmP7kmnW6RqJ6LQYrqnJ/96Q
         +kJA==
X-Forwarded-Encrypted: i=1; AL+hErFwZra13Hf7CHMqibeePqBxeQ4T3ZPZd1HdjP/S4WNdz5kYOn7ysyDRhJ3Q6ySdkH7QmygrqItBIZU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/P0hsJwUrcicyvqOMg8HVgqmRN0xHzhXeSfCdQ3VTX2Di0CAcO
	k7vfP/rwkOV10fqqWRdUu/7jHVVNoeDGLyevlquEsziZ/qGDat7umbR5i2oCZK0yrRaXwj1myEv
	3UDAxcpw20e6PIBxj0Q==
X-Received: from ejdx2.prod.google.com ([2002:a17:906:2962:b0:c50:519f:c790])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d05:b0:c34:c5e8:1dc5 with SMTP id a640c23a62f3a-c504951a77bmr241791266b.20.1794323940348;
 Tue, 10 Nov 2026 07:19:00 -0800 (PST)
Date: Tue, 10 Nov 2026 15:18:57 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110151857.1864222-1-michalblk@google.com>
Subject: [PATCH v3 RESEND] sched: Lift cgroup update locking to core to
 prevent CFS/SCX divergence
From: Michal Blaszczyk <michalblk@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Michal Blaszczyk <michalblk@google.com>
Content-Type: text/plain; charset="UTF-8"

Concurrent writes to cgroup control files (such as cpu.shares or
cpu.weight) can lead to state divergence between CFS and SCX.

For instance, in cpu_shares_write_u64(), the CFS update is serialized
by shares_mutex (internal to fair.c), but this lock is dropped before
scx_group_set_weight() is called. The latter only acquires a read
semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
and act on the sched_ext update concurrently.

This serialization gap allows concurrent writes to interleave.
As a result, the recorded state in CFS, the SCX internal bookkeeping
(e.g., tg->scx.weight), and the BPF scheduler itself can end up operating
on completely distinct parameters (pairwise distinct values).

Similar races are present in tg_set_bandwidth(), cpu_idle_write_s64(),
cpu_weight_write_u64(), and cpu_weight_nice_write_s64().

Fix this by moving the CFS locking up into the core layer in
`kernel/sched/core.c`. By acquiring these locks directly in the core
write handlers, both the CFS and SCX callbacks are executed atomically
under the same lock.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Tejun Heo <tj@kernel.org>
---

Notes:
    RESEND:
    - No changes since v3, rebased onto tip/sched/core. It also applies
      cleanly to mainline.
    - Added Andrea's Reviewed-by and Tejun's Acked-by from v3.
    - Peter agreed with lifting the locking into the core on v1 [1], and
      Tejun asked him to pick up v3 [2].
    - Retested on tip/sched/core with x86_debug.config. The sched_ext
      selftests pass, and stressing all cpu.* knobs and autogroup nice
      values while attaching and detaching a sched_ext scheduler triggers no
      lockdep or other reports. In a temporary test whose BPF scheduler
      spins for 5ms in ops.cgroup_set_{weight,idle,bandwidth}() while
      another value gets written, cpu.weight, cpu.idle and cpu.max diverged
      from what the BPF scheduler saw in 30 of 30 rounds each without this
      patch, and in none with it.
    
    v3: https://lore.kernel.org/r/20260824074913.2468177-1-michalblk@google.com
    - Renamed the shares and cfs_constraints mutexes.
    
    v2: https://lore.kernel.org/r/20260821140818.1559100-1-michalblk@google.com
    - Lifted the existing CFS locks up into the core layer instead of
      introducing a new global mutex.
    
    v1: https://lore.kernel.org/r/20260820160956.910663-1-michalblk@google.com
    
    [1] https://lore.kernel.org/r/20260821072653.GD4120091@noisy.programming.kicks-ass.net
    [2] https://lore.kernel.org/r/e9cd7bd7c303b57d8716c4a8cab35058@kernel.org

 kernel/sched/core.c  | 35 +++++++++++++++++++++++------------
 kernel/sched/fair.c  | 25 +++++++++++++------------
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 175b52a7ea793..8b4e4a6f4ae02 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9783,6 +9783,8 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
+DEFINE_MUTEX(cpu_weight_mutex);
+
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
@@ -9800,7 +9802,10 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+
+	guard(mutex)(&cpu_weight_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(shareval));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
 				     sched_weight_to_cgroup(shareval));
@@ -9815,8 +9820,6 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 #endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 #ifdef CONFIG_CFS_BANDWIDTH
-static DEFINE_MUTEX(cfs_constraints_mutex);
-
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
 static int tg_set_cfs_bandwidth(struct task_group *tg,
@@ -9835,13 +9838,6 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 
 	burst = (u64)burst_us * NSEC_PER_USEC;
 
-	/*
-	 * Prevent race between setting of cfs_rq->runtime_enabled and
-	 * unthrottle_offline_cfs_rqs().
-	 */
-	guard(cpus_read_lock)();
-	guard(mutex)(&cfs_constraints_mutex);
-
 	ret = __cfs_schedulable(tg, period, quota);
 	if (ret)
 		return ret;
@@ -10093,6 +10089,8 @@ static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
 	return period_us;
 }
 
+static DEFINE_MUTEX(cpu_max_mutex);
+
 static int tg_set_bandwidth(struct task_group *tg,
 			    u64 period_us, u64 quota_us, u64 burst_us)
 {
@@ -10135,6 +10133,13 @@ static int tg_set_bandwidth(struct task_group *tg,
 					burst_us + quota_us > max_bw_runtime_us))
 		return -EINVAL;
 
+	/*
+	 * Prevent race between setting of cfs_rq->runtime_enabled and
+	 * unthrottle_offline_cfs_rqs().
+	 */
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_max_mutex);
+
 #ifdef CONFIG_CFS_BANDWIDTH
 	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10233,6 +10238,8 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	int ret;
 
+	guard(mutex)(&cpu_weight_mutex);
+
 	ret = sched_group_set_idle(css_tg(css), idle);
 	if (!ret)
 		scx_group_set_idle(css_tg(css), idle);
@@ -10409,7 +10416,9 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(mutex)(&cpu_weight_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css), cgrp_weight);
 	return ret;
@@ -10446,7 +10455,9 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(mutex)(&cpu_weight_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
 				     sched_weight_to_cgroup(weight));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4cc0caee6265..0cad2d48a4d7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15789,13 +15789,11 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	se->parent = parent;
 }
 
-static DEFINE_MUTEX(shares_mutex);
-
 static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 {
 	int i;
 
-	lockdep_assert_held(&shares_mutex);
+	lockdep_assert_held(&cpu_weight_mutex);
 
 	/*
 	 * We can't change the weight of the root cgroup.
@@ -15830,36 +15828,40 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	return 0;
 }
 
-int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares)
 {
 	int ret;
 
-	mutex_lock(&shares_mutex);
+	lockdep_assert_held(&cpu_weight_mutex);
+
 	if (tg_is_idle(tg))
 		ret = -EINVAL;
 	else
 		ret = __sched_group_set_shares(tg, shares);
-	mutex_unlock(&shares_mutex);
 
 	return ret;
 }
 
+int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+{
+	guard(mutex)(&cpu_weight_mutex);
+	return sched_group_set_shares_locked(tg, shares);
+}
+
 int sched_group_set_idle(struct task_group *tg, long idle)
 {
 	int i;
 
+	lockdep_assert_held(&cpu_weight_mutex);
+
 	if (tg == &root_task_group)
 		return -EINVAL;
 
 	if (idle < 0 || idle > 1)
 		return -EINVAL;
 
-	mutex_lock(&shares_mutex);
-
-	if (tg->idle == idle) {
-		mutex_unlock(&shares_mutex);
+	if (tg->idle == idle)
 		return 0;
-	}
 
 	tg->idle = idle;
 
@@ -15904,7 +15906,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	else
 		__sched_group_set_shares(tg, NICE_0_LOAD);
 
-	mutex_unlock(&shares_mutex);
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4df59c9c9b60..5826f6c3b23d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,10 @@ extern void sched_release_group(struct task_group *tg);
 extern void sched_move_task(struct task_struct *tsk, bool for_autogroup);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+extern struct mutex cpu_weight_mutex;
+
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
+extern int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
@@ -607,6 +610,10 @@ extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
+static inline int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares)
+{
+	return 0;
+}
 static inline int sched_group_set_idle(struct task_group *tg, long idle) { return 0; }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 

base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
-- 
2.56.0.506.g506a7eabc5-goog

