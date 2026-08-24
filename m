Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC325B0AB
	for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557764; cv=none; b=DghvQNNucRMcqRA/a01WOjwN/axZb61dQ1aNdP+k6IkGNZHe80G2FGOodDrsEzF3GqXzfYLyCk6iVHEsi75WmwR3+aYqxsIzBGkpgfiJrmtmR3nlsI3BtmnxgnXU/tR66HCox3i3BQP6p6L3tTaNJ11cGMqwamjEPY+YNgvVvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557764; c=relaxed/simple;
	bh=KLtZd4nEpmMC9H/76tYypADXQP5NczFzjZBVZaoxQZs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bIWaTML2H2eVgORxSzBXnTZ2fSOA/b5J6Pc/2HqF9nhROrkv99jqSSll4ppDhzXG/0lQpXqheiL2r3hOeGL3Ya981gOuPcPYmZ2VuOf0rhslZ537LolN3NFx8CK/lhk14w2kZqiYDmT4wLowPVSgNOn48VsoOo/PKNFICV/yESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxJDKeDk; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxJDKeDk"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a57aa074f7so3155400a12.0
        for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787557760; x=1788162560; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnKVA0pgkeGByF6leu3TPLtIstvfEcu9RJBYbVbjMy4=;
        b=NxJDKeDkAfxnIPuWEOd58gaOUk2Ph8FGZeIxAdotvohjBkl8XBKP4D8x801g0AiU+O
         sUmANa4VDiP9dBCOXPcYC4Kfa2zJcospiG2kvJATVhSH9YdtPxIHJEpJRgzKv1/mbOq7
         JnkxQzhOxDX4+JQVUMC58BhXQFHBKR5Nu19eDd5WwnohVZ2a4DKQC6LcjkpJ59gdz5a6
         X6fkbvq/x53/cfQsBMVHaoXl8dPy1GMCX7oW3vpPjhuFaPQyGPyQIdS4WQNMhM5HbHfA
         E0FtcjrcZ70JjTCVPQwnglsdGM6OyOrh1BFdMiWAtie2Xl6u9AGBQMZ2OaqTXh50QJTw
         G7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787557760; x=1788162560;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnKVA0pgkeGByF6leu3TPLtIstvfEcu9RJBYbVbjMy4=;
        b=G+LMVs3Gu5gSHepeo1HwIMISe2wykqa0VGHrdsHE2s+S0fDyvTV3eAKNt/rhIttHa8
         9PBZmTgwDP5uHBM0/Wrr/SeVi36vpW4l/uwlNH0HgInrWp49/f3qgj3Pfm1iligyyLVr
         RQoG870DV1v2MiQkHtCI3gtj7PcFI1OiZBpHU4JI15DMyEpHRcgFHPAhno9RDjJf6CXe
         XGtIKFbnVYUDtM2n1+JZj6tMSDWJLfsfq8EudKKPapaT4etJTQb2wk0iVcKHyOUOKvPS
         X9mJ1CP+yVm29cvwrgwtczeZGRyns40PldNJsA36MuKw+mfDDZZJXgab2Wq/UsqdNlh4
         IpnA==
X-Forwarded-Encrypted: i=1; AHgh+RqtWau4NhsYeKUSW88IqwXxdv4Ry1SCqAPRVn60sXYppXqGgjMn+WOue1tbdwsWVBBlluZHqxMDS2w=@lists.linux.dev
X-Gm-Message-State: AFuF++mbbcM0OtT65fjSXUrpMLkskd22XRTmugIvWlSJVGDVevArifcC
	C7k8ZNBqYZs17soWyiQLyt8fbeGcozP9CP2edtVdhLkXH9jHESadRfBxRrgK/QB7EtA0Hl3NU+x
	qp016RX9QsOEtRIv/ew==
X-Received: from edxz18.prod.google.com ([2002:aa7:cf92:0:b0:6a1:2592:3722])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3882:b0:6a3:5685:703 with SMTP id 4fb4d7f45d1cf-6a430bf024fmr24061123a12.3.1787557759575;
 Mon, 24 Aug 2026 00:49:19 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:49:13 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260824074913.2468177-1-michalblk@google.com>
Subject: [PATCH v3] sched: Lift cgroup update locking to core to prevent
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
v3:
- Renamed the shares and cfs_constraints mutexes.

 kernel/sched/core.c  | 35 +++++++++++++++++++++++------------
 kernel/sched/fair.c  | 25 +++++++++++++------------
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5f7ff8c680a..4673a78cb9e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9779,6 +9779,8 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
+DEFINE_MUTEX(cpu_weight_mutex);
+
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
@@ -9796,7 +9798,10 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 
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
 
+static DEFINE_MUTEX(cpu_max_mutex);
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
+	guard(mutex)(&cpu_max_mutex);
+
 #ifdef CONFIG_CFS_BANDWIDTH
 	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10229,6 +10234,8 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	int ret;
 
+	guard(mutex)(&cpu_weight_mutex);
+
 	ret = sched_group_set_idle(css_tg(css), idle);
 	if (!ret)
 		scx_group_set_idle(css_tg(css), idle);
@@ -10405,7 +10412,9 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(mutex)(&cpu_weight_mutex);
+
+	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css), cgrp_weight);
 	return ret;
@@ -10442,7 +10451,9 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
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
index 001140132a7d..4e0a38b0cb3c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15392,13 +15392,11 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
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
@@ -15430,36 +15428,40 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
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
 
@@ -15505,7 +15507,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	else
 		__sched_group_set_shares(tg, NICE_0_LOAD);
 
-	mutex_unlock(&shares_mutex);
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 26ae13c86b69..a989b54f7017 100644
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
 
-- 
2.55.0.860.g4b6b3295ed-goog

