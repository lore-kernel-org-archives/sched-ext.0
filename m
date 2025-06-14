Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A412B93;
	Sat, 14 Jun 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864864; cv=none; b=lfPLA1x5BL8OSWPWCsaaSpUiNAePTQg4WYW4bSZvdLITtmtJl8H2Dt5TR1R9a6ndpDZVngly6/QRRuC6Ys3RKyTe3DVagyWS94WzrAg5zkgfYCgt0EiU0IZlOii2J1fCGoz7HuWJqQbRNmQJ9RGZcP9sz7xYa6OqJla1FHFVwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864864; c=relaxed/simple;
	bh=vdAVaIAWpZAwboNWYVrZIhes0QfAaRghhqm6zvu9NQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHrXdn0JTIruin8TghwAoHABeJT/tyT7iWHTB4qyUQ78FV+vYyRJROjQoYuzHk/JERqRHlvhccpk/y9RjIMF9tdwKOxDCjNB6GjLXGhwC4XF7LADdEIvqtWt5tlsr4rOnOaHEzKvTUURVnvkY4K97p2MS+kW3i/8Alohs+/Usw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu9l8FBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu9l8FBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA64EC4CEE3;
	Sat, 14 Jun 2025 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864864;
	bh=vdAVaIAWpZAwboNWYVrZIhes0QfAaRghhqm6zvu9NQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nu9l8FByNzXS8KTXot7rpj0Rpq56p0EY6NU7N8EaPNEXMxXNoo6CZRULPgTjtFlQv
	 PA0zMgwW/XdT4jzUP+SOngSbq3w5uitshyO1pgoG8/6mXSaEMpUoHgyq9T78z+ONWG
	 byWJltY2YC0TLlno/zu2EeWh0hVh3CAGl5zMWAcJKu1nBdXuentD4TipGViF+2dRmW
	 hM1dtG8j6JxkMJl5pzMhYU0X5GHzSV4rDr5xi2G5fXzXD/J2eNyFxrNnROdYvHpqET
	 awr2wOSIrbSSo9VjlotQnAVRH6I3c7aXyBxjhUJe/7PZiJcwbsaaq7O0MWgeK3z8XC
	 aAykKGiSIVE5g==
Date: Fri, 13 Jun 2025 15:34:22 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH sched_ext/for-6.17 2/2] sched_ext: Add support for cgroup
 bandwidth control interface
Message-ID: <aEzRnjYmqxbOU-3z@slm.duckdns.org>
References: <aEzRVj5ha38RAEr5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEzRVj5ha38RAEr5@slm.duckdns.org>

From 077814f57f8acce13f91dc34bbd2b7e4911fbf25 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 13 Jun 2025 15:06:47 -1000

- Add CONFIG_GROUP_SCHED_BANDWIDTH which is selected by both
  CONFIG_CFS_BANDWIDTH and EXT_GROUP_SCHED.

- Put bandwidth control interface files for both cgroup v1 and v2 under
  CONFIG_GROUP_SCHED_BANDWIDTH.

- Update tg_bandwidth() to fetch configuration parameters from fair if
  CONFIG_CFS_BANDWIDTH, SCX otherwise.

- Update tg_set_bandwidth() to update the parameters for both fair and SCX.

- Add bandwidth control parameters to struct scx_cgroup_init_args.

- Add sched_ext_ops.cgroup_set_bandwidth() which is invoked on bandwidth
  control parameter updates.

- Update scx_qmap and maximal selftest to test the new feature.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                     |  3 +
 init/Kconfig                                  |  5 ++
 kernel/sched/core.c                           | 29 ++++++--
 kernel/sched/ext.c                            | 66 ++++++++++++++++++-
 kernel/sched/ext.h                            |  2 +
 kernel/sched/sched.h                          |  4 +-
 tools/sched_ext/scx_qmap.bpf.c                | 23 +++++++
 .../testing/selftests/sched_ext/maximal.bpf.c |  5 ++
 8 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index eda89acdb7ab..8b92842776cb 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -219,6 +219,9 @@ struct scx_task_group {
 #ifdef CONFIG_EXT_GROUP_SCHED
 	u32			flags;		/* SCX_TG_* */
 	u32			weight;
+	u64			bw_period_us;
+	u64			bw_quota_us;
+	u64			bw_burst_us;
 #endif
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index af4c2f085455..baf59d2a20a2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1065,6 +1065,9 @@ if CGROUP_SCHED
 config GROUP_SCHED_WEIGHT
 	def_bool n
 
+config GROUP_SCHED_BANDWIDTH
+        def_bool n
+
 config FAIR_GROUP_SCHED
 	bool "Group scheduling for SCHED_OTHER"
 	depends on CGROUP_SCHED
@@ -1074,6 +1077,7 @@ config FAIR_GROUP_SCHED
 config CFS_BANDWIDTH
 	bool "CPU bandwidth provisioning for FAIR_GROUP_SCHED"
 	depends on FAIR_GROUP_SCHED
+	select GROUP_SCHED_BANDWIDTH
 	default n
 	help
 	  This option allows users to define CPU bandwidth rates (limits) for
@@ -1108,6 +1112,7 @@ config EXT_GROUP_SCHED
 	bool
 	depends on SCHED_CLASS_EXT && CGROUP_SCHED
 	select GROUP_SCHED_WEIGHT
+	select GROUP_SCHED_BANDWIDTH
 	default y
 
 endif #CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8a4cbb5e9237..a9ea35b176a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9544,7 +9544,9 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 
 	return 0;
 }
+#endif /* CONFIG_CFS_BANDWIDTH */
 
+#ifdef CONFIG_GROUP_SCHED_BANDWIDTH
 const u64 max_bw_quota_period_us = 1 * USEC_PER_SEC; /* 1s */
 static const u64 min_bw_quota_period_us = 1 * USEC_PER_MSEC; /* 1ms */
 /* More than 203 days if BW_SHIFT equals 20. */
@@ -9553,12 +9555,21 @@ static const u64 max_bw_runtime_us = MAX_BW;
 static void tg_bandwidth(struct task_group *tg,
 			 u64 *period_us_p, u64 *quota_us_p, u64 *burst_us_p)
 {
+#ifdef CONFIG_CFS_BANDWIDTH
 	if (period_us_p)
 		*period_us_p = tg_get_cfs_period(tg);
 	if (quota_us_p)
 		*quota_us_p = tg_get_cfs_quota(tg);
 	if (burst_us_p)
 		*burst_us_p = tg_get_cfs_burst(tg);
+#else /* !CONFIG_CFS_BANDWIDTH */
+	if (period_us_p)
+		*period_us_p = tg->scx.bw_period_us;
+	if (quota_us_p)
+		*quota_us_p = tg->scx.bw_quota_us;
+	if (burst_us_p)
+		*burst_us_p = tg->scx.bw_burst_us;
+#endif /* CONFIG_CFS_BANDWIDTH */
 }
 
 static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
@@ -9574,6 +9585,7 @@ static int tg_set_bandwidth(struct task_group *tg,
 			    u64 period_us, u64 quota_us, u64 burst_us)
 {
 	const u64 max_usec = U64_MAX / NSEC_PER_USEC;
+	int ret = 0;
 
 	if (tg == &root_task_group)
 		return -EINVAL;
@@ -9611,7 +9623,12 @@ static int tg_set_bandwidth(struct task_group *tg,
 					burst_us + quota_us > max_bw_runtime_us))
 		return -EINVAL;
 
-	return tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
+#ifdef CONFIG_CFS_BANDWIDTH
+	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
+#endif /* CONFIG_CFS_BANDWIDTH */
+	if (!ret)
+		scx_group_set_bandwidth(tg, period_us, quota_us, burst_us);
+	return ret;
 }
 
 static s64 cpu_quota_read_s64(struct cgroup_subsys_state *css,
@@ -9664,7 +9681,7 @@ static int cpu_burst_write_u64(struct cgroup_subsys_state *css,
 	tg_bandwidth(tg, &period_us, &quota_us, NULL);
 	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
-#endif /* CONFIG_CFS_BANDWIDTH */
+#endif /* CONFIG_GROUP_SCHED_BANDWIDTH */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
@@ -9724,7 +9741,7 @@ static struct cftype cpu_legacy_files[] = {
 		.write_s64 = cpu_idle_write_s64,
 	},
 #endif
-#ifdef CONFIG_CFS_BANDWIDTH
+#ifdef CONFIG_GROUP_SCHED_BANDWIDTH
 	{
 		.name = "cfs_period_us",
 		.read_u64 = cpu_period_read_u64,
@@ -9740,6 +9757,8 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_burst_read_u64,
 		.write_u64 = cpu_burst_write_u64,
 	},
+#endif
+#ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
@@ -9953,7 +9972,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf, u64 *period_us_p,
 	return 0;
 }
 
-#ifdef CONFIG_CFS_BANDWIDTH
+#ifdef CONFIG_GROUP_SCHED_BANDWIDTH
 static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
@@ -10000,7 +10019,7 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_idle_write_s64,
 	},
 #endif
-#ifdef CONFIG_CFS_BANDWIDTH
+#ifdef CONFIG_GROUP_SCHED_BANDWIDTH
 	{
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6732e50e0679..39cba11688a9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -203,6 +203,11 @@ struct scx_exit_task_args {
 struct scx_cgroup_init_args {
 	/* the weight of the cgroup [1..10000] */
 	u32			weight;
+
+	/* bandwidth control parameters from cpu.max and cpu.max.burst */
+	u64			bw_period_us;
+	u64			bw_quota_us;
+	u64			bw_burst_us;
 };
 
 enum scx_cpu_preempt_reason {
@@ -664,9 +669,31 @@ struct sched_ext_ops {
 	 * @cgrp: cgroup whose weight is being updated
 	 * @weight: new weight [1..10000]
 	 *
-	 * Update @tg's weight to @weight.
+	 * Update @cgrp's weight to @weight.
 	 */
 	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
+
+	/**
+	 * @cgroup_set_bandwidth: A cgroup's bandwidth is being changed
+	 * @cgrp: cgroup whose bandwidth is being updated
+	 * @period_us: bandwidth control period
+	 * @quota_us: bandwidth control quota
+	 * @burst_us: bandwidth control burst
+	 *
+	 * Update @cgrp's bandwidth control parameters. This is from the cpu.max
+	 * cgroup interface.
+	 *
+	 * @quota_us / @period_us determines the CPU bandwidth @cgrp is entitled
+	 * to. For example, if @period_us is 1_000_000 and @quota_us is
+	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
+	 * interpreted in the same fashion and specifies how much @cgrp can
+	 * burst temporarily. The specific control mechanism and thus the
+	 * interpretation of @period_us and burstiness is upto to the BPF
+	 * scheduler.
+	 */
+	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
+				     u64 period_us, u64 quota_us, u64 burst_us);
+
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
 	/*
@@ -4059,6 +4086,8 @@ static bool scx_cgroup_enabled;
 void scx_tg_init(struct task_group *tg)
 {
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
+	tg->scx.bw_period_us = default_bw_period_us();
+	tg->scx.bw_quota_us = RUNTIME_INF;
 }
 
 int scx_tg_online(struct task_group *tg)
@@ -4073,7 +4102,10 @@ int scx_tg_online(struct task_group *tg)
 	if (scx_cgroup_enabled) {
 		if (SCX_HAS_OP(sch, cgroup_init)) {
 			struct scx_cgroup_init_args args =
-				{ .weight = tg->scx.weight };
+				{ .weight = tg->scx.weight,
+				  .bw_period_us = tg->scx.bw_period_us,
+				  .bw_quota_us = tg->scx.bw_quota_us,
+				  .bw_burst_us = tg->scx.bw_burst_us };
 
 			ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -4225,6 +4257,27 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 	/* TODO: Implement ops->cgroup_set_idle() */
 }
 
+void scx_group_set_bandwidth(struct task_group *tg,
+			     u64 period_us, u64 quota_us, u64 burst_us)
+{
+	struct scx_sched *sch = scx_root;
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
+	    (tg->scx.bw_period_us != period_us ||
+	     tg->scx.bw_quota_us != quota_us ||
+	     tg->scx.bw_burst_us != burst_us))
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_bandwidth, NULL,
+			    tg_cgrp(tg), period_us, quota_us, burst_us);
+
+	tg->scx.bw_period_us = period_us;
+	tg->scx.bw_quota_us = quota_us;
+	tg->scx.bw_burst_us = burst_us;
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
 static void scx_cgroup_lock(void)
 {
 	percpu_down_write(&scx_cgroup_rwsem);
@@ -4400,7 +4453,12 @@ static int scx_cgroup_init(struct scx_sched *sch)
 	rcu_read_lock();
 	css_for_each_descendant_pre(css, &root_task_group.css) {
 		struct task_group *tg = css_tg(css);
-		struct scx_cgroup_init_args args = { .weight = tg->scx.weight };
+		struct scx_cgroup_init_args args = {
+			.weight = tg->scx.weight,
+			.bw_period_us = tg->scx.bw_period_us,
+			.bw_quota_us = tg->scx.bw_quota_us,
+			.bw_burst_us = tg->scx.bw_burst_us,
+		};
 
 		if ((tg->scx.flags &
 		     (SCX_TG_ONLINE | SCX_TG_INITED)) != SCX_TG_ONLINE)
@@ -5902,6 +5960,7 @@ static s32 sched_ext_ops__cgroup_prep_move(struct task_struct *p, struct cgroup
 static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
+static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
 #endif
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
@@ -5939,6 +5998,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_move		= sched_ext_ops__cgroup_move,
 	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
+	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
 #endif
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index e7bcaa02ea56..292bb41a242e 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -104,6 +104,7 @@ void scx_cgroup_finish_attach(void);
 void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
 void scx_group_set_idle(struct task_group *tg, bool idle);
+void scx_group_set_bandwidth(struct task_group *tg, u64 period_us, u64 quota_us, u64 burst_us);
 #else	/* CONFIG_EXT_GROUP_SCHED */
 static inline void scx_tg_init(struct task_group *tg) {}
 static inline int scx_tg_online(struct task_group *tg) { return 0; }
@@ -114,5 +115,6 @@ static inline void scx_cgroup_finish_attach(void) {}
 static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
 static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
 static inline void scx_group_set_idle(struct task_group *tg, bool idle) {}
+static inline void scx_group_set_bandwidth(struct task_group *tg, u64 period_us, u64 quota_us, u64 burst_us) {}
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 #endif	/* CONFIG_CGROUP_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fdf5f52b54a3..06767a210717 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -402,7 +402,7 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 
 extern struct list_head task_groups;
 
-#ifdef CONFIG_CFS_BANDWIDTH
+#ifdef CONFIG_GROUP_SCHED_BANDWIDTH
 extern const u64 max_bw_quota_period_us;
 
 /*
@@ -413,7 +413,7 @@ static inline u64 default_bw_period_us(void)
 {
 	return 100000ULL;
 }
-#endif /* CONFIG_CFS_BANDWIDTH */
+#endif /* CONFIG_GROUP_SCHED_BANDWIDTH */
 
 struct cfs_bandwidth {
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index c3cd9a17d48e..69d877501cb7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -615,6 +615,26 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
 		     taskc->force_local, taskc->core_sched_seq);
 }
 
+s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
+{
+	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
+		   cgrp->kn->id, args->weight, args->bw_period_us,
+		   args->bw_quota_us, args->bw_burst_us);
+	return 0;
+}
+
+void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
+{
+	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
+}
+
+void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
+		    u64 period_us, u64 quota_us, u64 burst_us)
+{
+	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
+		   period_us, quota_us, burst_us);
+}
+
 /*
  * Print out the online and possible CPU map using bpf_printk() as a
  * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
@@ -840,6 +860,9 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
 	       .dump_task		= (void *)qmap_dump_task,
+	       .cgroup_init		= (void *)qmap_cgroup_init,
+	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
+	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 430f5e13bf55..01cf4f3da4e0 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -123,6 +123,10 @@ void BPF_STRUCT_OPS(maximal_cgroup_cancel_move, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 {}
 
+void BPF_STRUCT_OPS(maximal_cgroup_set_bandwidth, struct cgroup *cgrp,
+		    u64 period_us, u64 quota_us, u64 burst_us)
+{}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 {
 	return scx_bpf_create_dsq(DSQ_ID, -1);
@@ -160,6 +164,7 @@ struct sched_ext_ops maximal_ops = {
 	.cgroup_move		= (void *) maximal_cgroup_move,
 	.cgroup_cancel_move	= (void *) maximal_cgroup_cancel_move,
 	.cgroup_set_weight	= (void *) maximal_cgroup_set_weight,
+	.cgroup_set_bandwidth	= (void *) maximal_cgroup_set_bandwidth,
 	.init			= (void *) maximal_init,
 	.exit			= (void *) maximal_exit,
 	.name			= "maximal",
-- 
2.49.0

