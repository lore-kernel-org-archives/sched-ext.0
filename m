Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31B4D599;
	Sat, 14 Jun 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864230; cv=none; b=UauzJ5WBjx+qXSHSF36M0j2Lyw07WMhDlMfxPUMhb4kZAGBbR4ZVVkg5X2MF0UTPbHwH1nUM7Bu61GLl59eExwWPHXkNCQowQG3/m9TAOMmdYBfcZaXPqO9Mt6Y/Up1tAFfOPAOgx/F1iufO0LusYjkgkj7Wzco8tkW88+sJ+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864230; c=relaxed/simple;
	bh=Q1vDPFMEZ8YDYo/7iiM4deGh7nPttv91s0nXEWZuCqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oH4qgP+MbL/Jz/V2LA5Yxi+/7ovr5zY7wdL/7mhEpL7HrSX5WTQZb3rqkLNUXvntE8QYOGC7N/ByvKsdsoWHLE9E1twDfyT9uM9OgeAWFDh8MBaUZel80Ix8ZE0x/WFYpQYZD63jBdCk50V7WCbH6/UQiHy1XwxvFkyJQ2Sq3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4jAxq/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4jAxq/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52289C4CEF5;
	Sat, 14 Jun 2025 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864230;
	bh=Q1vDPFMEZ8YDYo/7iiM4deGh7nPttv91s0nXEWZuCqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4jAxq/bGJMzq3Ar2t8UFk80HrTVpizHq41KYoZAUI6Pmhm04kuphqg3G4C0Mg0G9
	 UmAtJUHCAXeK6nEotjtZzWPe3j7SSSYo5Vm5SBvQo3tIbE3fW8H+HHYNCB1szQfE13
	 eKeaIWCO6s2bVTJhQJDCVuPxJ78fMSzURInM/U18SCjG2+3FKrxA73aJx0JhNN5Gfm
	 uRO0qlR+OJ09qHfOaYaF/bWYetDYGVT87X3rPo6xk5UCZ4YFzl4Zj8fHZuXEWo7zBa
	 9KPriFw6QA8EWf6tnI1o2LMYD4w1wbPuQaNnbqgrgRKFr33ELaHMctz2YbmcnTGA41
	 Bf2NtI5sdDK5g==
From: Tejun Heo <tj@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched/core: Relocate tg_get_cfs_*() and cpu_cfs_*_read_*()
Date: Fri, 13 Jun 2025 15:23:28 -1000
Message-ID: <20250614012346.2358261-3-tj@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614012346.2358261-1-tj@kernel.org>
References: <20250614012346.2358261-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collect the getters, relocate the trivial interface file wrappers, and put
all of them in period, quota, burst order to prepare for future changes.
Pure reordering. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 134 ++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a03c3c1d7f50..dc9668a6592f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9404,20 +9404,14 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	return 0;
 }
 
-static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
+static long tg_get_cfs_period(struct task_group *tg)
 {
-	u64 quota, period, burst;
+	u64 cfs_period_us;
 
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
-		quota = RUNTIME_INF;
-	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
-		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
-	else
-		return -EINVAL;
+	cfs_period_us = ktime_to_ns(tg->cfs_bandwidth.period);
+	do_div(cfs_period_us, NSEC_PER_USEC);
 
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+	return cfs_period_us;
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -9433,6 +9427,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period, burst;
@@ -9447,14 +9451,20 @@ static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
-static long tg_get_cfs_period(struct task_group *tg)
+static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 cfs_period_us;
+	u64 quota, period, burst;
 
-	cfs_period_us = ktime_to_ns(tg->cfs_bandwidth.period);
-	do_div(cfs_period_us, NSEC_PER_USEC);
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
+	if (cfs_quota_us < 0)
+		quota = RUNTIME_INF;
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
+		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
-	return cfs_period_us;
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
@@ -9471,52 +9481,6 @@ static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
 	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
-static long tg_get_cfs_burst(struct task_group *tg)
-{
-	u64 burst_us;
-
-	burst_us = tg->cfs_bandwidth.burst;
-	do_div(burst_us, NSEC_PER_USEC);
-
-	return burst_us;
-}
-
-static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
-{
-	return tg_get_cfs_quota(css_tg(css));
-}
-
-static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, s64 cfs_quota_us)
-{
-	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
-}
-
-static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cft)
-{
-	return tg_get_cfs_period(css_tg(css));
-}
-
-static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
-				    struct cftype *cftype, u64 cfs_period_us)
-{
-	return tg_set_cfs_period(css_tg(css), cfs_period_us);
-}
-
-static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
-{
-	return tg_get_cfs_burst(css_tg(css));
-}
-
-static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, u64 cfs_burst_us)
-{
-	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
-}
-
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -9649,6 +9613,42 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 
 	return 0;
 }
+
+static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	return tg_get_cfs_period(css_tg(css));
+}
+
+static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_quota(css_tg(css));
+}
+
+static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
+				    struct cftype *cftype, u64 cfs_period_us)
+{
+	return tg_set_cfs_period(css_tg(css), cfs_period_us);
+}
+
+static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_quota_us)
+{
+	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
+}
+
+static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, u64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -9710,16 +9710,16 @@ static struct cftype cpu_legacy_files[] = {
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
-	{
-		.name = "cfs_quota_us",
-		.read_s64 = cpu_cfs_quota_read_s64,
-		.write_s64 = cpu_cfs_quota_write_s64,
-	},
 	{
 		.name = "cfs_period_us",
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
+	{
+		.name = "cfs_quota_us",
+		.read_s64 = cpu_cfs_quota_read_s64,
+		.write_s64 = cpu_cfs_quota_write_s64,
+	},
 	{
 		.name = "cfs_burst_us",
 		.read_u64 = cpu_cfs_burst_read_u64,
-- 
2.49.0

