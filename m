Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB578633A;
	Sat, 14 Jun 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864232; cv=none; b=LBWvgxDh6z7O+lT51LMhg3LAgrrA+X3a5lJAuaEIc1zD4FFN5b71k6Rnh2I3zVyIiq82x1VTUS/8XXSMuJsgdg5p+Yv5Ezw32Y9vQUn+5ulmBquw4LtKiLI7QuJQ1/D9939hdRWri1njFk8cg86BK3tx8L0rJtkPw6trO1kKuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864232; c=relaxed/simple;
	bh=VNPNe5fTxBqdgMEOZ0AJqkwfQGRqSQ+BWaa14Pi7FiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGJWk8WWlgISA3FwIhFQelvBGwBrVPyLLMCAIoNGssNms1aO//AfdwBOYQoUxwSZ15UFYSsGDJVfEwxC2qj4cRQv4ykeHMItpLeJvxP6xW+VRWLY7QOy+0++JhwpdB3Z0CfdE/4MB4ITgo5zXbIKpcokdkemdcXPPxuAv0UvAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/JbwRr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/JbwRr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81738C4CEF4;
	Sat, 14 Jun 2025 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864231;
	bh=VNPNe5fTxBqdgMEOZ0AJqkwfQGRqSQ+BWaa14Pi7FiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/JbwRr04y2BPuU8LvB7DK3+OMm8lCmXywNlnk/GxRIsVc6G1Xkofm7/wy4SNGPOs
	 cDvuP91F3fEjitZzAuquSsOTroeZpdZKYQ3IF2TuQddeP0bkNstfvuUg6lAdkqT3T+
	 tt/jpfOB2Ig64XcWco/q1Q94WgYzv3npVs6BauAWWaFDOQ41hZ2YkO3Nf8wWFYUhG/
	 VrGwtn0DIQNQaApWGibs6mDBFs+i+ZBVnx4ZulUdnDjoZIFdT67+aW1LY/dRzwBtrn
	 ilHhiJTGnWQ1ITXRhCpcWU7VIMB/Jvjq/OTT/vqEyak4Fo7xwmTcXvHj6lyjf9iAa/
	 jeB8wljmaxH5A==
From: Tejun Heo <tj@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched/core: Reorganize cgroup bandwidth control interface file reads
Date: Fri, 13 Jun 2025 15:23:29 -1000
Message-ID: <20250614012346.2358261-4-tj@kernel.org>
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

- Update tg_get_cfs_*() to return u64 values. These are now used as the low
  level accessors to the fair's bandwidth configuration parameters.
  Translation to usecs takes place in these functions.

- Add tg_bandwidth() which reads all three bandwidth parameters using
  tg_get_cfs_*().

- Reimplement cgroup interface read functions using tg_bandwidth(). Drop cfs
  from the function names.

This is to prepare for adding bandwidth control support to sched_ext.
tg_bandwidth() will be used as the muxing point similar to tg_weight(). No
functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 58 +++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dc9668a6592f..8de93a3bfa27 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9404,7 +9404,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	return 0;
 }
 
-static long tg_get_cfs_period(struct task_group *tg)
+static u64 tg_get_cfs_period(struct task_group *tg)
 {
 	u64 cfs_period_us;
 
@@ -9414,12 +9414,12 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
-static long tg_get_cfs_quota(struct task_group *tg)
+static u64 tg_get_cfs_quota(struct task_group *tg)
 {
 	u64 quota_us;
 
 	if (tg->cfs_bandwidth.quota == RUNTIME_INF)
-		return -1;
+		return RUNTIME_INF;
 
 	quota_us = tg->cfs_bandwidth.quota;
 	do_div(quota_us, NSEC_PER_USEC);
@@ -9427,7 +9427,7 @@ static long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
-static long tg_get_cfs_burst(struct task_group *tg)
+static u64 tg_get_cfs_burst(struct task_group *tg)
 {
 	u64 burst_us;
 
@@ -9614,22 +9614,42 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cft)
+static void tg_bandwidth(struct task_group *tg,
+			 u64 *period_us_p, u64 *quota_us_p, u64 *burst_us_p)
 {
-	return tg_get_cfs_period(css_tg(css));
+	if (period_us_p)
+		*period_us_p = tg_get_cfs_period(tg);
+	if (quota_us_p)
+		*quota_us_p = tg_get_cfs_quota(tg);
+	if (burst_us_p)
+		*burst_us_p = tg_get_cfs_burst(tg);
 }
 
-static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
+static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
 {
-	return tg_get_cfs_quota(css_tg(css));
+	u64 period_us;
+
+	tg_bandwidth(css_tg(css), &period_us, NULL, NULL);
+	return period_us;
 }
 
-static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
+static s64 cpu_quota_read_s64(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
 {
-	return tg_get_cfs_burst(css_tg(css));
+	u64 quota_us;
+
+	tg_bandwidth(css_tg(css), NULL, &quota_us, NULL);
+	return quota_us;	/* (s64)RUNTIME_INF becomes -1 */
+}
+
+static u64 cpu_burst_read_u64(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	u64 burst_us;
+
+	tg_bandwidth(css_tg(css), NULL, NULL, &burst_us);
+	return burst_us;
 }
 
 static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
@@ -9712,17 +9732,17 @@ static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "cfs_period_us",
-		.read_u64 = cpu_cfs_period_read_u64,
+		.read_u64 = cpu_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
 		.name = "cfs_quota_us",
-		.read_s64 = cpu_cfs_quota_read_s64,
+		.read_s64 = cpu_quota_read_s64,
 		.write_s64 = cpu_cfs_quota_write_s64,
 	},
 	{
 		.name = "cfs_burst_us",
-		.read_u64 = cpu_cfs_burst_read_u64,
+		.read_u64 = cpu_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 	{
@@ -9944,8 +9964,10 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
+	u64 period_us, quota_us;
 
-	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
+	tg_bandwidth(tg, &period_us, &quota_us, NULL);
+	cpu_period_quota_print(sf, period_us, quota_us);
 	return 0;
 }
 
@@ -9996,7 +10018,7 @@ static struct cftype cpu_files[] = {
 	{
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = cpu_cfs_burst_read_u64,
+		.read_u64 = cpu_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 #endif /* CONFIG_CFS_BANDWIDTH */
-- 
2.49.0

