Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40636212F
	for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242213; cv=none; b=IOU17xp3BDAbazAh2jsh8EASb2tfEAKNN6MKlcSEgVsEWwNkTnxe2d10queH86BuIgeNLiFS/PiSYRiYJlv4EapxlFe4WmkL2mmuxlnva2zEdN4NIaJX+/ZiwdCXnoaT6UgNLOOPo4pblk7D/0LznI6SnL9qz5nnEf7ueq/ynMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242213; c=relaxed/simple;
	bh=az9gPeT42O3xNp1DQ8symakPd7mzh14IgDk2qGczqrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pRGDqil4Ap5tKc6VUWpuC3vjCPujX6qRI5WTkppe5Xdn9ijkb5uVX4l5b5oMasfHfi7LDPRUllwZS202fqbVwl8FfYVOQw+SX8jL43ZDl1EQPQslMPpy4MKJigintuaWm+nXDLkWWm18m14dt1+FSPM2SxzOvgJkkMvQtnt/Nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwgfvsRV; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwgfvsRV"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a18e266026so63438a12.3
        for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787242210; x=1787847010; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ff8gpvwhQpTLN29jVDY95lccIdW4t8LTU/PZ1Tpb+Y=;
        b=gwgfvsRVfG4ZzUOhSJsTnx4TniQQd3VKO1bVCuuz4gz3Fh8L6GPdQS1tRDEA5P4M/K
         f2RmItiYtPQ1VeCntqKWevGrOigOHwE9K6y1pGL8fpjrlVSmUEM1LCSXY1u4/eO8yZsv
         9DjVY4oc2yO3XuWgwaeF2yZsKJezKvHI+9I95jJNS5FJDMrqu8R/NASWUnO9Tt/zDcj2
         s8TGvds9B3mSxyC5b7EXDQJnj7jO1ajSZ5hVusMqXHWIPJlMzDs69MltJqmeVFgj6Dy5
         VDkuYbbnvAa2ZHAXktF5DG65WvAtFSW1Z32kXHejX7qUX+aZbKw3/xMRmIGKM5lqJ74d
         yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787242210; x=1787847010;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ff8gpvwhQpTLN29jVDY95lccIdW4t8LTU/PZ1Tpb+Y=;
        b=Ozo3Y0wPO51CVxiYDvsJvNoiwy7szwJWM9K07Zuhrxe7us0XC2PVNTGp84U6auYYem
         pOQib7dQ13TJhakYH3nMHpJdxYteEpUh4TH2JpuliyGMDj7hf7klF+dHZYa3O3V5uu0K
         fUy9Bks3YY5PKWF7Q0cLcwadz6ZPimJNnv2EZqKSyApCBW32t30pHo2fJv74FhrPFRcf
         oq17biP8NNBXD6orJ8s5rGwrhxL6PE80rgjmHySBs1st0i5+EJV/a63ce3i3bqfce2xs
         Lm5x58Cx1QAOv1o+teVFIg6FVc6/NbMHoxfZkDTWymqgnsGTAphhx3F6H8f3jDpT9H2T
         Z2GA==
X-Forwarded-Encrypted: i=1; AHgh+RpAN3CZTG2GMdU5iYTmsxJJupVM6Sp+b3EkokhnivHjGJ4bn4H3iV39zmHJWiPnqhUXxxrIDG9kW7E=@lists.linux.dev
X-Gm-Message-State: AFuF++m3AdT1b5yE7I5I1C59f7doSZwoH/fpe8loVw0I9zW7Kt98bGmQ
	Cw9yFxvz1Wz7Cm1QFYkrHI2PgdZwyh7H9sXa4IQ9N/YIBy+64PFjTyJ34bc4L5vXi34d6wT3LaD
	A5JNZv7+lcOz0CgVK3g==
X-Received: from edtl8.prod.google.com ([2002:aa7:cac8:0:b0:69c:30ad:f253])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4290:b0:6a1:fb46:c405 with SMTP id 4fb4d7f45d1cf-6a40330de47mr10713404a12.14.1787242209855;
 Thu, 20 Aug 2026 09:10:09 -0700 (PDT)
Date: Thu, 20 Aug 2026 16:09:56 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260820160956.910663-1-michalblk@google.com>
Subject: [PATCH] sched: Serialize cgroup updates to prevent CFS/SCX state divergence
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

Fix this by introducing scx_cgroup_mutex in kernel/sched/core.c to
serialize these file write operations.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 kernel/sched/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5f7ff8c680a..e3e84f7b9da9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9789,6 +9789,11 @@ static unsigned long tg_weight(struct task_group *tg)
 #endif
 }
 
+/* Serializes concurrent cgroup updates to keep CFS and SCX state consistent */
+#ifdef CONFIG_EXT_GROUP_SCHED
+static DEFINE_MUTEX(scx_cgroup_mutex);
+#endif
+
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
@@ -9796,6 +9801,10 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
+
+#ifdef CONFIG_EXT_GROUP_SCHED
+	guard(mutex)(&scx_cgroup_mutex);
+#endif
 	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
@@ -10131,6 +10140,9 @@ static int tg_set_bandwidth(struct task_group *tg,
 					burst_us + quota_us > max_bw_runtime_us))
 		return -EINVAL;
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	guard(mutex)(&scx_cgroup_mutex);
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10229,6 +10241,9 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	int ret;
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	guard(mutex)(&scx_cgroup_mutex);
+#endif
 	ret = sched_group_set_idle(css_tg(css), idle);
 	if (!ret)
 		scx_group_set_idle(css_tg(css), idle);
@@ -10405,6 +10420,9 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	guard(mutex)(&scx_cgroup_mutex);
+#endif
 	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css), cgrp_weight);
@@ -10442,6 +10460,9 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	guard(mutex)(&scx_cgroup_mutex);
+#endif
 	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
 	if (!ret)
 		scx_group_set_weight(css_tg(css),
-- 
2.55.0.737.g08866a6d13-goog

