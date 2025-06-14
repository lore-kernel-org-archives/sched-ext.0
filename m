Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31932151990;
	Sat, 14 Jun 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864234; cv=none; b=i2iM0CYuNqzASIvaI3XgShVayWt+7bPDU+5rBHehNM544Rtfla7/FerBWAqvWIJczrUCyKYjP0VNDlGqt1SF13arZ++UKYK6iWt5HsFPqwqP+2/CJ04grGGuYV1rcRrdl4IOiuZy9EQQxLaFkMjel7UbiJ2AzPk72LLD5VXvd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864234; c=relaxed/simple;
	bh=jmnQOULJ2u1KPG3F1AMgRwSW6d2bByiHvcY/fzeS9uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax/8Q+AgDIq8gkhlxpXptyWOWS3ivWAkP3xFj/OtA7ryJY1BtHxP1PfYEsnQ+P1I8E9XK4uQCukQkZ0VJH1HP8HNEUjpNic1n++jkFiN/r+2Kj2VhZ1859Mc8y2RIGSgGd26kUL4gZrZWwvkp65rz3mCAOjdvfrsbY4zMeYKbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2ZQDAzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2ZQDAzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F623C4CEED;
	Sat, 14 Jun 2025 01:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864233;
	bh=jmnQOULJ2u1KPG3F1AMgRwSW6d2bByiHvcY/fzeS9uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2ZQDAzOEeyPaEeIIBtTLg/CyiZFaKNY8ZIW1zlTw/tmMef2eGnL4lPT8Ip/QGeVF
	 n3RkJ2Lc8Jg0MWXXH3BX8aH5MF0hTNzFPAP1RJSZJeFcENgqEMfqq0W599uiDhq65K
	 kroJ9XaPll+6Gl09CwbN1WYYyw8z/zxLsdCesM7yDQLxOeMjQDdEzPl+E8I31ARq1H
	 Vf/JYDwDTNV+Jm2qHAgf5t2U2dkRFwtx5wxfqYbz0Dkgd3EXvuU3eGx0Lzj4JgAVd2
	 W4n+sweiA2Wf6qnxtIgaM0i/WJtjVATyN1bXlmG/lAydcjpEAvsXohh5SQ/mFw6r2h
	 O40HYZ51JkNFQ==
From: Tejun Heo <tj@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched/core: Reorganize cgroup bandwidth control interface file writes
Date: Fri, 13 Jun 2025 15:23:30 -1000
Message-ID: <20250614012346.2358261-5-tj@kernel.org>
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

- Move input parameter validation from tg_set_cfs_bandwidth() to the new
  outer function tg_set_bandwidth(). The outer function handles parameters
  in usecs, validates them and calls tg_set_cfs_bandwidth() which converts
  them into nsecs. This matches tg_bandwidth() on the read side.

- max/min_cfs_* consts are now used by tg_set_bandwidth(). Relocate, convert
  into usecs and drop "cfs" from the names.

- Reimplement cpu_cfs_{period|quote|burst}_write_*() using tg_bandwidth()
  and tg_set_bandwidth() and replace "cfs" in the names with "bw".

- Update cpu_max_write() to use tg_set_bandiwdth(). cpu_period_quota_parse()
  is updated to drop nsec conversion accordingly. This aligns the behavior
  with cfs_period_quota_print().

- Drop now unused tg_set_cfs_{period|quota|burst}().

- While at it, for consistency, rename default_cfs_period() to
  default_bw_period_us() and make it return usecs.

This is to prepare for adding bandwidth control support to sched_ext.
tg_set_bandwidth() will be used as the muxing point. No functional changes
intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 205 +++++++++++++++++++++----------------------
 kernel/sched/fair.c  |   4 +-
 kernel/sched/sched.h |  10 +--
 3 files changed, 106 insertions(+), 113 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8de93a3bfa27..2f8caa9db78d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9309,47 +9309,23 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
-const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
-static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
-/* More than 203 days if BW_SHIFT equals 20. */
-static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
-
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
-				u64 burst)
+static int tg_set_cfs_bandwidth(struct task_group *tg,
+				u64 period_us, u64 quota_us, u64 burst_us)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+	u64 period, quota, burst;
 
-	if (tg == &root_task_group)
-		return -EINVAL;
-
-	/*
-	 * Ensure we have at some amount of bandwidth every period.  This is
-	 * to prevent reaching a state of large arrears when throttled via
-	 * entity_tick() resulting in prolonged exit starvation.
-	 */
-	if (quota < min_cfs_quota_period || period < min_cfs_quota_period)
-		return -EINVAL;
+	period = (u64)period_us * NSEC_PER_USEC;
 
-	/*
-	 * Likewise, bound things on the other side by preventing insane quota
-	 * periods.  This also allows us to normalize in computing quota
-	 * feasibility.
-	 */
-	if (period > max_cfs_quota_period)
-		return -EINVAL;
-
-	/*
-	 * Bound quota to defend quota against overflow during bandwidth shift.
-	 */
-	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
-		return -EINVAL;
+	if (quota_us == RUNTIME_INF)
+		quota = RUNTIME_INF;
+	else
+		quota = (u64)quota_us * NSEC_PER_USEC;
 
-	if (quota != RUNTIME_INF && (burst > quota ||
-				     burst + quota > max_cfs_runtime))
-		return -EINVAL;
+	burst = (u64)burst_us * NSEC_PER_USEC;
 
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
@@ -9437,50 +9413,6 @@ static u64 tg_get_cfs_burst(struct task_group *tg)
 	return burst_us;
 }
 
-static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
-{
-	u64 quota, period, burst;
-
-	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	period = (u64)cfs_period_us * NSEC_PER_USEC;
-	quota = tg->cfs_bandwidth.quota;
-	burst = tg->cfs_bandwidth.burst;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
-static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
-{
-	u64 quota, period, burst;
-
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
-		quota = RUNTIME_INF;
-	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
-		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
-	else
-		return -EINVAL;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
-static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
-{
-	u64 quota, period, burst;
-
-	if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	quota = tg->cfs_bandwidth.quota;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -9614,6 +9546,11 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+const u64 max_bw_quota_period_us = 1 * USEC_PER_SEC; /* 1s */
+static const u64 min_bw_quota_period_us = 1 * USEC_PER_MSEC; /* 1ms */
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_bw_runtime_us = MAX_BW;
+
 static void tg_bandwidth(struct task_group *tg,
 			 u64 *period_us_p, u64 *quota_us_p, u64 *burst_us_p)
 {
@@ -9634,6 +9571,50 @@ static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
 	return period_us;
 }
 
+static int tg_set_bandwidth(struct task_group *tg,
+			    u64 period_us, u64 quota_us, u64 burst_us)
+{
+	const u64 max_usec = U64_MAX / NSEC_PER_USEC;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	/* Values should survive translation to nsec */
+	if (period_us > max_usec ||
+	    (quota_us != RUNTIME_INF && quota_us > max_usec) ||
+	    burst_us > max_usec)
+		return -EINVAL;
+
+	/*
+	 * Ensure we have some amount of bandwidth every period. This is to
+	 * prevent reaching a state of large arrears when throttled via
+	 * entity_tick() resulting in prolonged exit starvation.
+	 */
+	if (quota_us < min_bw_quota_period_us ||
+	    period_us < min_bw_quota_period_us)
+		return -EINVAL;
+
+	/*
+	 * Likewise, bound things on the other side by preventing insane quota
+	 * periods.  This also allows us to normalize in computing quota
+	 * feasibility.
+	 */
+	if (period_us > max_bw_quota_period_us)
+		return -EINVAL;
+
+	/*
+	 * Bound quota to defend quota against overflow during bandwidth shift.
+	 */
+	if (quota_us != RUNTIME_INF && quota_us > max_bw_runtime_us)
+		return -EINVAL;
+
+	if (quota_us != RUNTIME_INF && (burst_us > quota_us ||
+					burst_us + quota_us > max_bw_runtime_us))
+		return -EINVAL;
+
+	return tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
+}
+
 static s64 cpu_quota_read_s64(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
@@ -9652,22 +9633,37 @@ static u64 cpu_burst_read_u64(struct cgroup_subsys_state *css,
 	return burst_us;
 }
 
-static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
-				    struct cftype *cftype, u64 cfs_period_us)
+static int cpu_period_write_u64(struct cgroup_subsys_state *css,
+				struct cftype *cftype, u64 period_us)
 {
-	return tg_set_cfs_period(css_tg(css), cfs_period_us);
+	struct task_group *tg = css_tg(css);
+	u64 quota_us, burst_us;
+
+	tg_bandwidth(tg, NULL, &quota_us, &burst_us);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 
-static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, s64 cfs_quota_us)
+static int cpu_quota_write_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cftype, s64 quota_us)
 {
-	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
+	struct task_group *tg = css_tg(css);
+	u64 period_us, burst_us;
+
+	if (quota_us < 0)
+		quota_us = RUNTIME_INF;
+
+	tg_bandwidth(tg, &period_us, NULL, &burst_us);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 
-static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, u64 cfs_burst_us)
+static int cpu_burst_write_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cftype, u64 burst_us)
 {
-	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+	struct task_group *tg = css_tg(css);
+	u64 period_us, quota_us;
+
+	tg_bandwidth(tg, &period_us, &quota_us, NULL);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
 
@@ -9733,17 +9729,17 @@ static struct cftype cpu_legacy_files[] = {
 	{
 		.name = "cfs_period_us",
 		.read_u64 = cpu_period_read_u64,
-		.write_u64 = cpu_cfs_period_write_u64,
+		.write_u64 = cpu_period_write_u64,
 	},
 	{
 		.name = "cfs_quota_us",
 		.read_s64 = cpu_quota_read_s64,
-		.write_s64 = cpu_cfs_quota_write_s64,
+		.write_s64 = cpu_quota_write_s64,
 	},
 	{
 		.name = "cfs_burst_us",
 		.read_u64 = cpu_burst_read_u64,
-		.write_u64 = cpu_cfs_burst_write_u64,
+		.write_u64 = cpu_burst_write_u64,
 	},
 	{
 		.name = "stat",
@@ -9940,22 +9936,20 @@ static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
 }
 
 /* caller should put the current value in *@periodp before calling */
-static int __maybe_unused cpu_period_quota_parse(char *buf,
-						 u64 *periodp, u64 *quotap)
+static int __maybe_unused cpu_period_quota_parse(char *buf, u64 *period_us_p,
+						 u64 *quota_us_p)
 {
 	char tok[21];	/* U64_MAX */
 
-	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
+	if (sscanf(buf, "%20s %llu", tok, period_us_p) < 1)
 		return -EINVAL;
 
-	*periodp *= NSEC_PER_USEC;
-
-	if (sscanf(tok, "%llu", quotap))
-		*quotap *= NSEC_PER_USEC;
-	else if (!strcmp(tok, "max"))
-		*quotap = RUNTIME_INF;
-	else
-		return -EINVAL;
+	if (sscanf(tok, "%llu", quota_us_p) < 1) {
+		if (!strcmp(tok, "max"))
+			*quota_us_p = RUNTIME_INF;
+		else
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -9975,14 +9969,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 			     char *buf, size_t nbytes, loff_t off)
 {
 	struct task_group *tg = css_tg(of_css(of));
-	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg->cfs_bandwidth.burst;
-	u64 quota;
+	u64 period_us, quota_us, burst_us;
 	int ret;
 
-	ret = cpu_period_quota_parse(buf, &period, &quota);
+	tg_bandwidth(tg, &period_us, NULL, &burst_us);
+	ret = cpu_period_quota_parse(buf, &period_us, &quota_us);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
+		ret = tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 	return ret ?: nbytes;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10019,7 +10012,7 @@ static struct cftype cpu_files[] = {
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_burst_read_u64,
-		.write_u64 = cpu_cfs_burst_write_u64,
+		.write_u64 = cpu_burst_write_u64,
 	},
 #endif /* CONFIG_CFS_BANDWIDTH */
 #ifdef CONFIG_UCLAMP_TASK_GROUP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 707be4570430..7e2963efe800 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6422,7 +6422,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			 * to fail.
 			 */
 			new = old * 2;
-			if (new < max_cfs_quota_period) {
+			if (new < max_bw_quota_period_us * NSEC_PER_USEC) {
 				cfs_b->period = ns_to_ktime(new);
 				cfs_b->quota *= 2;
 				cfs_b->burst *= 2;
@@ -6456,7 +6456,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 	raw_spin_lock_init(&cfs_b->lock);
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
-	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->period = us_to_ktime(default_bw_period_us());
 	cfs_b->burst = 0;
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e00b80cd998e..105190b18020 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -403,15 +403,15 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 extern struct list_head task_groups;
 
 #ifdef CONFIG_CFS_BANDWIDTH
-extern const u64 max_cfs_quota_period;
+extern const u64 max_bw_quota_period_us;
 
 /*
- * default period for cfs group bandwidth.
- * default: 0.1s, units: nanoseconds
+ * default period for group bandwidth.
+ * default: 0.1s, units: microseconds
  */
-static inline u64 default_cfs_period(void)
+static inline u64 default_bw_period_us(void)
 {
-	return 100000000ULL;
+	return 100000ULL;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
 
-- 
2.49.0

