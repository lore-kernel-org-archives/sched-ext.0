Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8F3E3169
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649726; cv=fail; b=lk04to1+gFj6S+DoaG0qgyxJnP+5xDWzQDp8316Sc+3xUGyJjIq2biBgKwgwY3407nHGWvJAJVhNyjnOJwvhljykPaWk9UIBvcW1UqsvYWPskOBrayVxDY2PioThahfhbap99dLgiUk8HPR/pwm+ngAswDgKLsfInT+S4ItcoN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649726; c=relaxed/simple;
	bh=6qjTRR5OBY+A+CQZpeh+Pn0cnSgaDpLpIxpEPDRAFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ocntAJc2qjhDcNn1GqWiy2heigeepdF2qAJMnlOjxYZ9z0zCVwFLuo8imA3HwLjplVzDys0I5bzVUM+R6MfBj0iHgykxkQKc4IMFNayrY0Z+03lw82BZXdszFHsFJhwpBJDfv2OLM7pnM1bc/neDRFpnH6ZprIYzq6CTO5/6J1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMZ1aVhM; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMZ1aVhM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iG+DnAQ5z6YcEpgKIkr5c3KlGRNzG4WXLvgiPwXAZvfzc5W/DQRve/EqWwj/4CKEc4Ea0h1+EjJMESfY8URxv1X4Dcs0a6pv5FrQmFoeT3JFgdLh/t+bPHTQVgOAWUt172s+5pW8O/TBg4gcGJZEGKOJex177tHDjt85AeA6CB1G4wI9D5aaXvV/Qz1VyWi40fEOmVWgNuV/YpAdvvP3atFA5x+Q8ZrwQs7nOfhEjwACOE8X5EZsziKOHhRpDwEoLp2OD3RiP3eLyHV78GWbfBbWJbfjHdhdyDWwahGDOgDU+9gHHAoje8NKgUr6xo7hlzn+nCYRnxQeJkHrxDmzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAl+01u5hlVDspXkN0mXNQ9NT1OrWMTomxB0Jg3xvT8=;
 b=e8ByB2a242iLlHlDr3mysvbnd6nJrLXPqz3iyze1ROa4WdcWYLUU2KXAs+FdEOyqtD04jCnlCSBas8Cc8gmaD0pcZQopBT9kd6qlzzO1jDGxZ6QeWqCiYmKcVcCO0VE9nMZc0QqboPYmjPIxpxP9JuaZs9XDmpcA1VVvDiuxkv+VNVGAcs0RaFaMOvzQ0ZtIAiGYUmmt5+iJetWmf3LDKQeswigWf1Jxkh5LZpTDRYiJYAsN/EUQcnNgngHof+QNiyMWbeMkzFw3dsvWE0O5PSVOBcb/Aj+TQ9AcOgckcMUICnH7jNqUp3AVzY4R0lJMqyxSdpc8w8WZpS6bOQZ4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAl+01u5hlVDspXkN0mXNQ9NT1OrWMTomxB0Jg3xvT8=;
 b=pMZ1aVhMULBdZUUoDNV1ytXjg7xkux1th/y2KQk1KYhhNsXVVbqHe6VlcrJvnj+zCDoxdnGhAu31K9inoEVTheXqotnGbopH3sT34soroXz1vgtLunx5rYG4qbBePUycgvxkfoOl3Vzj9DGCCZY8S6IvRV2knKWP7rCCgR6cADBKaEgxexI51J1mR7yzMCnxAADUtVchoa/FYpN8lcWEEPOIaTj2yogvE+n/LU33RXK5xriuNmQnKyaJCqHC55XJv4i5bD029qVQOgl0b+HOZA7/meJQTE2s7o14NOv3hNqUdAYwLMz0dRLuR0hsAd+mcwlVrNTsVojPhgL0AoZ5Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 09:21:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:21:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Tao Cui <cui.tao@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Serialize cgroup knob updates
Date: Tue, 25 Aug 2026 11:21:53 +0200
Message-ID: <20260825092153.2602809-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: eba485f8-3e9a-4222-4512-08df028a4fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Qen52RLB/ETA959ANmZ/ijxnvs5Zhu+GJuvykY1ITiO40ML+kun+dsGdCn1lBpPFOwQPHdL9heoi8MugUW3YPNKLvbaXLtG6kSAIWJjYzkZURKy8ZYsq7xrjYwhEIv+pUWLOYGiT7LGgBrIQCxp4UNOXoC8iorJKXW7htZ23uIU+4B6Yws4DJStOp8O4KpXeqsQTm5lPSHrGm3hTtQwq/x2ZSD4zrTA1eMzdziipNe2pQxpXfAG96idEp602YJPyr6EVtWm3/S7cgCC9zbD685Ans+aL/EU6uFZg22NtBdp6zv8wR0Vb7o6k+mN9ATqVDAHeeiGHTmKNhs3vtSjMi3tcpxY02kDfPJ232ju4X0EDm2GmCqq4EJHoh7d0Ju8RpUFPj1piO0yzQsJl1ZLiMW3XV1qJ56WBao1a7J3K/2KowX8e5wrvedLdwsoBpFhQtbszAn79GxD+bmk5yR5mkriiL09OC1QRepbFywIWqdv4XGvvMDTc56hZJQDqTEIvRC4lLlnBpDH8M5uel9ArOZsmpZ21Yn+xj//G7MnIYWXpvkGwBbaGK3C7L+1ek6GXqawA4MSHYlzej1OjW+mkyLjdByBXk9nEAM2W5H3Y7nHBtV294SxtXrUYNF2dIWv+bIsTpyOh5J8Fc3NBSFxPn7D8gyLeTj/C9Ujd3dlZyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SpxJ0b9I4l26tIxnM9UdEb/4wDYJZA7El8sIXQC3qLelzW+SIgMbOwCsHuRm?=
 =?us-ascii?Q?QwoguR7dn1QYendr0U5R4IJMycrTIfrPwPp2jHf79CFoutUhctq+5+5Nrprs?=
 =?us-ascii?Q?p4DGR4qFq9w2cL49SyBjb4zw+Yt75t5oG/070+wn2RKOKfiUe4AZ+0yi/O/3?=
 =?us-ascii?Q?H4qsaFwYita8rEwNabLMMcKeK3OpfzoXYYm3XzeCImJIaxr1WXNKqrop1qLa?=
 =?us-ascii?Q?ooyZ1EkblXiNenS7hXXfDj3uREAXMoSRWT7MREvjMWhGqtIETGry0xtzaKGf?=
 =?us-ascii?Q?A6rOqz46qxQUjKBH8I7gTsvu9pEk6QlxXpBMqwfUE7zGT4RQls5t7Y0zULmk?=
 =?us-ascii?Q?5l+z8SXYI7dTQIG8S68bGXO2AVW/WqQ344JsZ/K8l85YPgvr3Hw72xEsyEgf?=
 =?us-ascii?Q?gciFqs3PPcbEaGpouM26B5J0Wm1YsxcVFZxrzHh6DiocMzT3jvoZbc/Qz0ci?=
 =?us-ascii?Q?4jNbH+rxGCfDnSc1L32A1PngYiAGMhQKakGv5rKxJ+4ZCP2R+7L9V/JOP0HO?=
 =?us-ascii?Q?u4/eW8rdFyuqzViwy0/gVwUMPHLWyKFTktxHuQryNzs59Y4n4wUFG07fSc0Q?=
 =?us-ascii?Q?Kz+O7bqQqVFzRIBqAKo8/Gb2gS1JCGUmzxXihvWL8PCwA70EquOoG0hz+nqU?=
 =?us-ascii?Q?WTVUf4Bm/hoE/su6nJlSUcCUkoKP/XmdLCyWj/jOQ1LpEcF/IafIn2BN4/sM?=
 =?us-ascii?Q?TGTvw9G/HZnp+l9GyI5t8f2OKTTasIHjsdHfxIPjDWuAUTNLvdpQtB0qcK5H?=
 =?us-ascii?Q?oXfo+uffe+uHxFLYSHYo/xP3Eq9649FdxI0X/MFH7/KUkO5zhGZ9ig0yBOrS?=
 =?us-ascii?Q?bpwGcnurUb+uNyarkJlaupJrPVaZQkAWnpCjDpvaS11X+/728Widzb7h1Q7Y?=
 =?us-ascii?Q?/HF2T5TnYYkblQeFqC7b1SXyXKcrwDILJlgdzFBhF5waVOXTAADMGhc8ugcg?=
 =?us-ascii?Q?CTUMVdv86L2ukjRjDs+81ZZ0vJruOgaQUjGn9k9G2jMbFPfpY+iEDyoDFXY2?=
 =?us-ascii?Q?jZj0L2vJnV5cEdaA26N51KmpoapQCF+NCoT+DgwmRVW4UfG6P9qbKMNx5tz6?=
 =?us-ascii?Q?jFqwMD8vae4sWjU4U1QMziDC+AsUrt/Odz2aWPdKT7AS58tbWpCe3rXiJwI6?=
 =?us-ascii?Q?Vb7XEzr+I2qi5+r/yBw5jBeAyyhx4qBALZEfqJze/pzEDL9JYNo4FNPAKeFm?=
 =?us-ascii?Q?HSUOLe9XApifyXhfdvqsAFnAJh5TsA9hDwLGPe//aO6q8XBTVpa62k/WeB4X?=
 =?us-ascii?Q?RIrMI3feP5ttft6gjLt93wIa3uBtkVIU5gjXKP4FLQnbgxNhYNNt4HytfKUu?=
 =?us-ascii?Q?glcxtyTLAFd1xA/TUhEk1GOk0WSYn3oaP5zGY+VR7UzuoAxWi+Tb2mOMoZPX?=
 =?us-ascii?Q?fTdN5nIs8+LS0JJU1is0tNeIMjdhNSlcPwGC/HgWtSs3ti11K5jwyYUiQRyr?=
 =?us-ascii?Q?HqOwmVPxHHfV0+2w29CSZYypx3aMSuNmX+kWe49TTEdl1s/E+QEsZDu7tFS0?=
 =?us-ascii?Q?i0I7PXNI1tD6FZvD4nP8oUfvCPP+wEEllGFG5rJulm4lSwdkxzLGqNtvMlRm?=
 =?us-ascii?Q?KGpKOZ/be8i22xkOlWe7ElztGYoZaESAUGEoSlGBFU7RZCjX6wih1ZWXrkVO?=
 =?us-ascii?Q?w6O27ZsbCT9jrmfhSFv/PsN/IGh+Agk9FHU1EL8+pthrG7TzqY2r5P0U2U5M?=
 =?us-ascii?Q?NSHvBXZndrD3GNbPMpT02a0BqbzA1KQYrMRKx3I+PS6TpDjdSW01FKNGRR/N?=
 =?us-ascii?Q?WSc0mpxuRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba485f8-3e9a-4222-4512-08df028a4fd6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 09:21:58.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq2+Rzh/paBa/J6bmlPmCtAVyt/UxgYeZWe9ppScSCaKbOwHoY8g7lIs9WpDj/9WrKawALwf0hxYz38J3Tcsfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

Concurrent cgroup knob writes update the core scheduler under its
internal locks and notify sched_ext only after those locks are released.

The notifications can therefore complete out of order, leaving the core
scheduler, the BPF scheduler and the cached sched_ext state with
different values.

Add a per-task-group mutex and hold it across both the core scheduler
update and the matching sched_ext notification. Serialize weight, idle
and bandwidth updates so that their callbacks and cached state follow
the same order as the core scheduler changes.

Cc: Tao Cui <cui.tao@linux.dev>
Fixes: 819513666966 ("sched_ext: Add cgroup support")
Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
Fixes: ddceadce63d9 ("sched_ext: Add support for cgroup bandwidth control interface")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260825053648.EF7D41F000E9@smtp.kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  5 +++++
 kernel/sched/core.c       | 28 ++++++++++++++++++----------
 kernel/sched/ext/ext.c    |  1 +
 kernel/sched/ext/ext.h    | 14 ++++++++++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a9839..380b4b96fd08f 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -317,6 +317,11 @@ struct scx_task_group {
 	 * cgroup1.
 	 */
 	struct scx_sched	*sched;
+	/*
+	 * Serialize cgroup knob updates from the core scheduler change through
+	 * the matching ops.cgroup_set_*() callback and cached state update.
+	 */
+	struct mutex		knob_mutex;
 
 	u32			flags;		/* SCX_TG_* */
 	u32			weight;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 145eea2d99a1c..2239ea8e78d15 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9820,14 +9820,16 @@ static unsigned long tg_weight(struct task_group *tg)
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	struct task_group *tg = css_tg(css);
 	int ret;
 
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+
+	guard(scx_group_knob)(tg);
+	ret = sched_group_set_shares(tg, scale_load(shareval));
 	if (!ret)
-		scx_group_set_weight(css_tg(css),
-				     sched_weight_to_cgroup(shareval));
+		scx_group_set_weight(tg, sched_weight_to_cgroup(shareval));
 	return ret;
 }
 
@@ -10159,6 +10161,7 @@ static int tg_set_bandwidth(struct task_group *tg,
 					burst_us + quota_us > max_bw_runtime_us))
 		return -EINVAL;
 
+	guard(scx_group_knob)(tg);
 #ifdef CONFIG_CFS_BANDWIDTH
 	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10255,11 +10258,13 @@ static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
 static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 				struct cftype *cft, s64 idle)
 {
+	struct task_group *tg = css_tg(css);
 	int ret;
 
-	ret = sched_group_set_idle(css_tg(css), idle);
+	guard(scx_group_knob)(tg);
+	ret = sched_group_set_idle(tg, idle);
 	if (!ret)
-		scx_group_set_idle(css_tg(css), idle);
+		scx_group_set_idle(tg, idle);
 	return ret;
 }
 #endif /* CONFIG_GROUP_SCHED_WEIGHT */
@@ -10425,6 +10430,7 @@ static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cft, u64 cgrp_weight)
 {
+	struct task_group *tg = css_tg(css);
 	unsigned long weight;
 	int ret;
 
@@ -10433,9 +10439,10 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(scx_group_knob)(tg);
+	ret = sched_group_set_shares(tg, scale_load(weight));
 	if (!ret)
-		scx_group_set_weight(css_tg(css), cgrp_weight);
+		scx_group_set_weight(tg, cgrp_weight);
 	return ret;
 }
 
@@ -10460,6 +10467,7 @@ static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
+	struct task_group *tg = css_tg(css);
 	unsigned long weight;
 	int idx, ret;
 
@@ -10470,10 +10478,10 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	guard(scx_group_knob)(tg);
+	ret = sched_group_set_shares(tg, scale_load(weight));
 	if (!ret)
-		scx_group_set_weight(css_tg(css),
-				     sched_weight_to_cgroup(weight));
+		scx_group_set_weight(tg, sched_weight_to_cgroup(weight));
 	return ret;
 }
 #endif /* CONFIG_GROUP_SCHED_WEIGHT */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c539d15cda637..00926485e1b77 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4679,6 +4679,7 @@ DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_ops_rwsem);
 
 void scx_tg_init(struct task_group *tg)
 {
+	mutex_init(&tg->scx.knob_mutex);
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..68a455e23e3cf 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -78,6 +78,15 @@ void scx_tg_offline(struct task_group *tg);
 int scx_cgroup_can_attach(struct cgroup_taskset *tset);
 void scx_cgroup_move_task(struct task_struct *p);
 void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
+static inline void scx_group_knob_lock(struct task_group *tg)
+{
+	mutex_lock(&tg->scx.knob_mutex);
+}
+
+static inline void scx_group_knob_unlock(struct task_group *tg)
+{
+	mutex_unlock(&tg->scx.knob_mutex);
+}
 void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
 void scx_group_set_idle(struct task_group *tg, bool idle);
 void scx_group_set_bandwidth(struct task_group *tg, u64 period_us, u64 quota_us, u64 burst_us);
@@ -88,8 +97,13 @@ static inline void scx_tg_offline(struct task_group *tg) {}
 static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
 static inline void scx_cgroup_move_task(struct task_struct *p) {}
 static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
+static inline void scx_group_knob_lock(struct task_group *tg) {}
+static inline void scx_group_knob_unlock(struct task_group *tg) {}
 static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
 static inline void scx_group_set_idle(struct task_group *tg, bool idle) {}
 static inline void scx_group_set_bandwidth(struct task_group *tg, u64 period_us, u64 quota_us, u64 burst_us) {}
 #endif	/* CONFIG_EXT_GROUP_SCHED */
+
+DEFINE_GUARD(scx_group_knob, struct task_group *,
+	     scx_group_knob_lock(_T), scx_group_knob_unlock(_T));
 #endif	/* CONFIG_CGROUP_SCHED */
-- 
2.55.0

