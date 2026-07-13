Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83040B363
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959710; cv=fail; b=JgKVJhQI+Rwnzgo/CXdWuG4hyVpXss8YSgrKV/PdQwmfJwVv40bJf0Cz+XQgqfdVLJbk1YQE8tBke+bTaUGPVJqyY1FZtehauxPFeE6FWHlXPCVVC4OsuOWB0tSuWM4BeAAYBXV2alf8wDXQMEvMvmwLzCH1WNw9OdK2hDCFWC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959710; c=relaxed/simple;
	bh=aQysjCMbAuljz6BnPUamN+DS6m+9bOImZFyvTm/O47c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqG/GDg4eXOwHuNElqc6aNhkxfFcTKg/4OI4BRmKLtidEFujKaVYwUNqKMq8EBcB2mKj9GKin2hvusJvxbyjYyngv+e1Ri5tGJn/g646KjgRd4qmWCBvfqWUwh/x9/1LOoiiBimCW9CwcUdSVHlzvL8WDDNzcBcG3jFsKroId3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scsPcfK0; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scsPcfK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szx6BgK+j/s6hH3qhIZu9G+JSS+i9u+y6MjCtuW0jIwcLVd3t5vH+V+Oh1m+fIfeewdlZl/fQxeBpYNuW2dD8YlQI9ghB/4YiZiGt2QNVWOn/p6xPk0CxlEicPDqPrx1TwztDen8Ono64lHU0zWoFIDqG11YbNWlstxNXJXuo4fUgdA3toH18CE7wCdx5NJnPiPuTmX5sE3pAHMkicIpbSqG9yPyBkKa+O4wa2OsxJOOmsySSwaEwHiZTeEohx3asB+mnlA4Qxt6TvbvPRkclTW4OFS5iVe4y5dKXa2nlxTML5G4E/ifE9hSjKM4c4CB0V9ogNyxTOrrXVniQXFM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFjNask4DhWKK3yLPoV9h4JV+ee66aHSDWhxRLuwAMU=;
 b=sKEGBkyq9RvL5kpO6oAIfVwP7rUroc1a1CGqkL7Jxqe2k+gFRKYDY4USS2D6SUvtFD1MSvLCYL47b2vMgjJABG/vgc8TSPKCn+oJwPw8CK1CEqiz+AUg1xV/ycz76UkZxxp+sIPqMnAAtalBSUmyRzbZOSLENBglBLgmyDmO/gmXl6maXOkcMyCoqGp/yVXMWxntKldl8D0cQzcnCucN2mHQ6uARScUg5bjeneSZTjCBC9F1rCNCbm2fwSbcUUQIZf4R0fUcQS3nTlyrXrfoFb30UBKCHn07cqioqI3vuhdrjtbPC1fuhcaeBEEXD8ENuCN/viZay6wQvJqBaBFeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjNask4DhWKK3yLPoV9h4JV+ee66aHSDWhxRLuwAMU=;
 b=scsPcfK08UOR7OAhXW7g6pPBtXmlhV6IcHgW1rNOjJfHOQ7NsYxxT2nB29zNokGVXNDuIf+6gHJvXIEGtLrk9Bgx+7cM5YoJDtxBj8MeoXZtY0DdQra5UHKlVIpBENybmUSaaxDC2MwuB+lcD90gVdq8FVlAFVUIl8Hdt23h/YXW5yNq7ezGtDhyan93xJil2RUkQ0Hb2gXgEE1s93auVz5DkAprVAvG0u6pDPy7yPczzk7qwUDKyEzyYIBKI9dDcWT70zyT3XP5lYRAQd2Lt70nnuNiCvnVz4nxwnnIi1PahoQUjok1LxnPgLFauUcVRojeSeoITsiiHwhU59ycng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:38 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
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
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sched_ext: Block proxy donors across scheduler transitions
Date: Mon, 13 Jul 2026 18:17:02 +0200
Message-ID: <20260713162112.26785-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb40700-cb97-4517-0771-08dee0fad0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	dmAVc1OZPsuvBrXV/TXMyikeZ5FPxl7bN8TmYbth/0rd7xDRAgwmpyz0kEw/dUALu31joSMJHkPjjXaH9oZ9Qm3VUq+yed8MU3+fnQAI/qa/r9c8tJ8eIPhUL5JV/RqkxjbUndMGRX7hTXLFn7ba+XAfCzYG+0WML3OeJ6PpA3IvdRLwRX9ZLGXDDnyUrZRpsP071DFbxG/203SSXFOz8E7jKpuOIA1W2XZUwJgIEJsjxuxeXCQDFAFZ072ACRereJxR4tpyAfUfMqUn5rUHNz7r6BvdANuTnu8kyrQsO4hQjP09Y5kt0+Ou2+GZrloE4jbzfH7WyUUIRlVunLTexlZAvqVsdLTnUjxalde+EVsTVVmDnM6GPeuaf0orYyZpECEVtPwZlGX9CcNc/TOa/DZeGY+7kdmHPhNBM37pWJywVKpQTQRdxmLoA3lx0szX8gGtNZIzTeDIyhfCCBE4MJSF6iLBotTe+9slc6icXqqtGIUe3ZLxBfd4xM9EtIYqQK9XOh4ak5c0T2U2KbmEEhQpG5cyLv/qeqFijbqEpLKR1sR/K0ttwJvMjZRtIFhuSCyqeCsnpX9vKOgWN1bYfOqToK5HoQjYT4Ht9CphDSRDy1bVxODQ5LRJNtsFmNj+SymBh8iXQLtRJxOLEZc41NbEhxcehUUz8DN9+EdlnKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGHrHZQsfv2fMuL/eWDhgfd0I4DuUMnoQxzFy+Au+p397m/4FenUVLSUoeaV?=
 =?us-ascii?Q?V8cosyKL0tQwpHeadv5W/DI41hh5YXgk8SGEmNTC7EZO330uks2XNfT9I2Hn?=
 =?us-ascii?Q?/PyPSL5j7mog5pjz0w9BD0i1++HznuJHxfg877XVpDjfNud19pVReB51eI2t?=
 =?us-ascii?Q?gqaCcRjMAwNyhiOXo9G0SABxHNRieUXCjcDrI4B+ad2X2o2qnKxoqe/mLUXU?=
 =?us-ascii?Q?LCeQM3GfREgKqoDed864PyNoZNtm6oI427XbO4gByeoPMu4CBajUvG0rY4h9?=
 =?us-ascii?Q?RagWp6p02BZE2s6z02lGbiq3KV4wehARSl4T2GK3O/RenH23Ed+xSmoYGqM5?=
 =?us-ascii?Q?x4A/wCx/tP+EIysf2m88o8vfDf8gHpI8V7x2tXh5nwqI9P2Rvlfq0O5bIxdU?=
 =?us-ascii?Q?lrtbWDNbNLA7/sC2lTZAt/fOa9BxFq+HXNFp7rj5llLM5kf9pzofMNZ8Sg9e?=
 =?us-ascii?Q?OxrUNqvlrQJ73MzoZ6nvH13R0HuxFSRHnhK4fx5DBFvAwCUWqcmt3EPuzVJ/?=
 =?us-ascii?Q?6sHs4xZ2Fm8xAw94uessqX/g6XP4BVxxiqzZC/A9MbdgB0QoAZGOfc6EHLlg?=
 =?us-ascii?Q?Qfp7nBdnQf6E9FFD7ukNoxNTYZM3YC9/Rtn+l2mmT9PKpMJJVvb4jM1gGa65?=
 =?us-ascii?Q?apjsjkslstf1m5ebNkqAjTt+Pi8kzHMZBjrMiqOgBN+6qDuweNa6MsFcNFL7?=
 =?us-ascii?Q?mljzyD1QJXf0HyKfB3KzvAoLrHH55iMMG2kdrB2VrOtrZQwztaqV4oKQS9ig?=
 =?us-ascii?Q?8GxaYKwIedy90T4TYB7MoiS+vl1mLzY8lTgRuC99xdmrUKwTxK7xFMf/pSzN?=
 =?us-ascii?Q?vuSnHcX4INHZnoDiufwCEilSDFCEe1NU6Vq1S0KM0vb2WpiWSUGyuFjAhqwB?=
 =?us-ascii?Q?ZkRE3avU5LkAu6Gw7o7Wv51ENoFDUsaMTmSO3xIXg0LjUFFQieWLFiHRQgQI?=
 =?us-ascii?Q?gM8p4Ol8A97JpBQVbhjwD5KgApwApzx2pKMx2tXQVnoUfLWL/7vDMrXbHCyu?=
 =?us-ascii?Q?AoAapZg/1hiZi9CMQQZCiSbSu1I7tUamlhozBpuKmJbA7+30C0RA62Zvqbiq?=
 =?us-ascii?Q?q+1wL5pg+xhU+ZCbTOopvKedThsUnBDyppVtEjKQvWz8CoI2tP4Fve5fTFSf?=
 =?us-ascii?Q?DMPbPCFst0F+WasemZw+iAWDJjZgR2DG28HeqQpCNujsnEEaDpj9YQMeuV4n?=
 =?us-ascii?Q?dBNi8GiorY3dpi74f3nL9Ykiu6xkHG924pZ6gh/zSkwIA2eraqeRffD6k3Kl?=
 =?us-ascii?Q?7LKB0J+NbV+Ayog2xrbiiATIsY7k0GJ9n0V0yh9htZUz1WByNLY6kihMXs6P?=
 =?us-ascii?Q?7xTe1IidSG6TCFATPDWPuC5TEBs1NNoPnAQHt3pTyifFDVdb+sYxbh7qa8u9?=
 =?us-ascii?Q?mJpxD1gWm3EmqOBGDfseUI1JGnpN7eg0sSBE+9b9bqHtaTLiRW5lvNL9F93Z?=
 =?us-ascii?Q?KPNvnFtglWl4PZOZbGDADT+2HWPUO8WdHg2+sRT7GUl13PSWUMtMZe5NrmW6?=
 =?us-ascii?Q?yyIqdIrX/TF812EBKTDsazLnc4fWuFOCs+GdM1xEcDH53S3p3s1CP4xl5LQT?=
 =?us-ascii?Q?bw6LWLh7ZD601OCituOE83V+fF2h2P5tWBv/ju6c9eNdc2d22DyULUkjUkwQ?=
 =?us-ascii?Q?RsjXIH12A/aBl7qdxTbpOuLrvO+CO7aZjomK+YwvPjqbzjUvu7kiIGm7wecM?=
 =?us-ascii?Q?uG6Q9V0hy0rZLNyNBOkzfel4fwwLtWchkSe1tF5YDN8mIr/OWpsQz6KvI8Rd?=
 =?us-ascii?Q?rH1eo8flAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb40700-cb97-4517-0771-08dee0fad0c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:38.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj1WVfIMtHNSfGV4SCla9dRdTxZL7104CyuCK3t3N5L9IlTSHNuLGmQ9pnLUYUAahXHuZULFSRovHXvOdI5AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
retain such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Force blocked EXT
tasks through the regular block path in schedule(), and fully deactivate
a retained donor before sched_setscheduler() moves it into the EXT
class. These hooks establish the safe default that a later opt-in can
relax.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  3 ++-
 kernel/sched/ext/ext.c  | 21 +++++++++++++++++++++
 kernel/sched/ext/ext.h  |  6 ++++++
 kernel/sched/syscalls.c |  3 +++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 17f37ad639680..cdeb189f63cdd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7173,7 +7173,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9aeb378fa894b..8c527fa14a15f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -23,6 +23,27 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	return p->sched_class != &ext_sched_class;
+}
+
+/*
+ * Called after sched_setscheduler() validation and immediately before
+ * sched_change_begin(), with @p's pi and rq locks held.
+ */
+void scx_prepare_setscheduler(struct task_struct *p,
+			      const struct sched_class *next_class)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	if (p->sched_class == next_class || next_class != &ext_sched_class)
+		return;
+
+	sched_proxy_block_task(task_rq(p), p);
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..d708abf2c3bb8 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -18,8 +18,11 @@ bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+void scx_prepare_setscheduler(struct task_struct *p,
+			      const struct sched_class *next_class);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -52,8 +55,11 @@ static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
+static inline void scx_prepare_setscheduler(struct task_struct *p,
+					    const struct sched_class *next_class) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a60..2bbba3dc8c890 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -678,6 +678,9 @@ int __sched_setscheduler(struct task_struct *p,
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS))
+		scx_prepare_setscheduler(p, next_class);
+
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-- 
2.55.0

