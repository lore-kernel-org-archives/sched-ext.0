Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BC4BCADD
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321306; cv=none; b=lKcZW6Iy25cOKoAsOO1ZKQmUe5ds1VBGjdB3IWqhdmkHUP3EhTU+1P7SzI4DUAPl94jZQRYZqtaEyA+ftSDgEhEeFXZxHT88Z0PUCO6vR/LcfrNMGpjRlYlU7fOMZjSCbFPinsjpMtvfrzjI/XvVxbpD+Lb5tr/DonwvMrEeTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321306; c=relaxed/simple;
	bh=1UUlF2cZTl6c2ibL0rI8cH0G51rHXWflFbG4d2ailV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFrF5g3cb7Gnu0/9wUu/5//7I6R11i1kBKuG/9gIJUIsH0/n5vY8ChkijJbd88YVTJhao4hr3aSRF2DJLjDT+hHZlVPv3thsbyB2nCLr69wojXQts0MKqM0BbIwH+DQ4+byVp0Qf6oCTheZ/CrsUwJ/NuNbIo/LJ8E3RAbBbTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOOU3+4B; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOOU3+4B"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15ceb17a28so80099366b.3
        for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787321303; x=1787926103; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCzTkx0pupMnYZ6ntE5lO1Cpb9db2o3gqIZbTK/FRCY=;
        b=tOOU3+4BE1l1WSw8qwatlVHY4glJHh0AcVgLUBFcnmdYf7pauul3RI8M6YeomPRDHo
         zvY9t9nT2feUa/equQanBEoxp5Yc6xNnuJZkJr6/YAjc95wiKv9hTtCnea8quexObKPc
         Fj9vxf2xAVQgEkcivFYxl/WRbUFr4pcJApnNlRyhmX1/+K5/SJ70SgO0c6xTyuDqtLtx
         oWmQX34fiwH1K8hhlT1Y4285SA6aRT6jx/4hCcsLZdUfTkPZ2lP++GoYwi80D4ST22Ig
         aqipOaUOjsnZ200Ccv+mTQVAUuzMm2cZhNTzZVD/E4kbq2dBnDr0IUhYCjMuZujgBB2v
         yIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321303; x=1787926103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCzTkx0pupMnYZ6ntE5lO1Cpb9db2o3gqIZbTK/FRCY=;
        b=RQ/XPUzRz3V8JSvpM1BfpXJFo1smUL92KthPcsLTM8HEq3FAfrpzUrvmZ6jCKs3VBx
         FYgW5z8sqrm8KLO747t5UcfbtJvYneI2Jt4CX+ABq1fj9qZ3+ex6ewKrGtuCMJYkgTg7
         HTPbunEyOUAL+OnsIZMxDFVHpmeXGK8ZQpNykVWYEQ+7c1Tj7QXd5sQmn5cp7nQRqa1N
         JYRWd6qtiInbkiqvV22MWT53FZ2T+of/amaQAHKBgwM3ckeeeYpjjAvqYrw98rOcvsXe
         +UtPKpZd7HtO2yzX2Mn97XhZzeKV6ScsQcZQH4CCiOlVrYIZxBDvKaqEFdsdVyysMWHM
         saww==
X-Forwarded-Encrypted: i=1; AHgh+RqIziki0NCXKoEa+T2Zuo3C6J0L/Ycz0XPC/gYYVIyX6kJUGWwFD7z2IOB4ROuqgEmzmAqznB9rNm8=@lists.linux.dev
X-Gm-Message-State: AFuF++mf82eEiFYlxXIjnqxgZKEZa0nxyaQk4H6LMV75ZOn3LPTB4YKd
	VfdSOlKy/32z9Oimz8AOl2K5cWNzjMwArqERJh7/Qb7aIAQ6XTEL7QdqThwMuPuBgwoMUPrVV4g
	TtAQnOkfhrK0soBLWqg==
X-Received: from ejcus4.prod.google.com ([2002:a17:907:cd04:b0:c21:7748:c9cc])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d0a:b0:c20:83b1:396c with SMTP id a640c23a62f3a-c246a62b68fmr658178466b.17.1787321302375;
 Fri, 21 Aug 2026 07:08:22 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:08:18 +0000
In-Reply-To: <20260820160956.910663-1-michalblk@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260820160956.910663-1-michalblk@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260821140818.1559100-1-michalblk@google.com>
Subject: [PATCH v2] sched: Lift cgroup update locking to core to prevent
 CFS/SCX divergence
From: Michal Blaszczyk <michalblk@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Michal Blaszczyk <michalblk@google.com>, Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
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
---
v2:
 - Lifted existing CFS locks up into the Core layer instead of introducing
   a new global mutex, ensuring both callbacks run atomically under
   the same lock.
 - Refactored internal locking callbacks to avoid double-locking scenarios.

 kernel/sched/core.c  | 35 +++++++++++++++++++++++------------
 kernel/sched/fair.c  | 23 ++++++++++++-----------
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5f7ff8c680a..6dd21a701bb5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9779,6 +9779,8 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
+DEFINE_MUTEX(shares_mutex);
+
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
@@ -9796,7 +9798,10 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+
+	guard(mutex)(&shares_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(shareval));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
 				     sched_weight_to_cgroup(shareval));
@@ -9811,8 +9816,6 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 #endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 #ifdef CONFIG_CFS_BANDWIDTH
-static DEFINE_MUTEX(cfs_constraints_mutex);
-
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
 static int tg_set_cfs_bandwidth(struct task_group *tg,
@@ -9831,13 +9834,6 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 
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
@@ -10089,6 +10085,8 @@ static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
 	return period_us;
 }
 
+static DEFINE_MUTEX(cfs_constraints_mutex);
+
 static int tg_set_bandwidth(struct task_group *tg,
 			    u64 period_us, u64 quota_us, u64 burst_us)
 {
@@ -10131,6 +10129,13 @@ static int tg_set_bandwidth(struct task_group *tg,
 					burst_us + quota_us > max_bw_runtime_us))
 		return -EINVAL;
 
+	/*
+	 * Prevent race between setting of cfs_rq->runtime_enabled and
+	 * unthrottle_offline_cfs_rqs().
+	 */
+	guard(cpus_read_lock)();
+	guard(mutex)(&cfs_constraints_mutex);
+
 #ifdef CONFIG_CFS_BANDWIDTH
 	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10229,6 +10234,8 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	int ret;
 
+	guard(mutex)(&shares_mutex);
+
 	ret = sched_group_set_idle(css_tg(css), idle);
 	if (!ret)
 		scx_group_set_idle(css_tg(css), idle);
@@ -10405,7 +10412,9 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(mutex)(&shares_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css), cgrp_weight);
 	return ret;
@@ -10442,7 +10451,9 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(mutex)(&shares_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
 				     sched_weight_to_cgroup(weight));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 001140132a7d..9d69372dc0c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15392,8 +15392,6 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	se->parent = parent;
 }
 
-static DEFINE_MUTEX(shares_mutex);
-
 static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 {
 	int i;
@@ -15430,36 +15428,40 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	return 0;
 }
 
-int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares)
 {
 	int ret;
 
-	mutex_lock(&shares_mutex);
+	lockdep_assert_held(&shares_mutex);
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
+	guard(mutex)(&shares_mutex);
+	return sched_group_set_shares_locked(tg, shares);
+}
+
 int sched_group_set_idle(struct task_group *tg, long idle)
 {
 	int i;
 
+	lockdep_assert_held(&shares_mutex);
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
 
@@ -15505,7 +15507,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	else
 		__sched_group_set_shares(tg, NICE_0_LOAD);
 
-	mutex_unlock(&shares_mutex);
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 26ae13c86b69..9e14b07bddcf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,10 @@ extern void sched_release_group(struct task_group *tg);
 extern void sched_move_task(struct task_struct *tsk, bool for_autogroup);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+extern struct mutex shares_mutex;
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
 
-- 
2.55.0.860.g4b6b3295ed-goog

