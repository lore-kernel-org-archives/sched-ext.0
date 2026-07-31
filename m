Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39F314B8C
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488647; cv=fail; b=QnIdsJWEoA1bJXH92zEWZAU4yRd8DjN8OLOkLUAym6oq8ZkW2OAwjCk/kbCnie8poTKWKbJ9l31S0cxdbnbZ190xrTaNnNWbWykofcstrVaEIPqMzxYnLeg2C/otQhXaE28Ial+srhun6yquU+WQZqisbITDQplVb+w+r4Ka8Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488647; c=relaxed/simple;
	bh=tHVWuJYgyTAw3vFiRYxrluebQUqCXiZscwjd9YAFKK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiMN6qlaYQlROT8VE6v8gaAIqdISph/T37cb7qLytcy2+W23m0PgM6aVmCbtZxyGQSsPlpZRYgnxHkrVUt5ahePCtN8auRY/4auDniuQKtQtbflx/vsCeRX8l9Zm8Vie9Bp/11ozoMAS5swcmKMn+pQKgVWTp6wqWshb/TCtBlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pc3mnHi6; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pc3mnHi6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK0vZSDgUcorg/YIDrwJQNYErDp1Jpaq2SBQlmRJu5kaUVJ5GR16TTLNiFpUF9RVIEUZjUolj0u1uKqWZCpEc4rJThE4VbDkY7e4Qj/tExrseUC7D6QUpocqhgAGSvBO4nOPQn+a2H+1h47bNiglcch3UfYMHYkTVY7gcK7f0cQK21RLPnryWSzVKKZNemWrlK7x7jTNQ29IwghRaIYT4h8lFn4vJ6xaM1Hbwtu/VdkaCNavEEMbfzGjDz3RsYTVafvTEJPMw5DFdPfKDL0nEK7+KeRKwGISdMhUZrL0N/OmGQiphQQTdg4I6A9CkvTYBRfFSf1jUkqKf2BpXYlf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX9UiOoxdxLHftRcx38co0VcHzAhXAbiQvmC4rE9OfQ=;
 b=I0OhmPkj7FoxEXe3IqTW1ure3CZzqH8ZciZ8APUxSm6jYBqOYT4kPinhBwogsJP3NTsn/PKAKfx0mtTCdr+M+c6/ypQjRZTI8vDDBMZHOvA8Qc0jNeULgKkAV59LlzuSlLlXifKF9fR3trGWPESmI0SsuC33o2qSOAG9xY/NDN7jMXlEgDwqwbsjB/u+ib3NZyNGNFVHtYf6UoQXojItrzlhiU47ZS2OgRYNZ20DPGkrE73SSEDtyZAQ2uFby9TbYOWxr9HcwoFumxxnxYGq51KeM7KZnmR50OJ41Fne0qgPwZW3XKDBLOHIkWdvQyNC/yQ93orG0b9Fdx4Njvy29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX9UiOoxdxLHftRcx38co0VcHzAhXAbiQvmC4rE9OfQ=;
 b=pc3mnHi69f6y41Jpny0sn9jP2WKz4mYJIo1iplluQki66z8BXkP7SgpRJ7en7JdB+eCndww8aGovqwVQB40CRyReqiCst2Llh6059+rnijCo8AMwXcxZnOBvGp0CWm7mLWLqjnePUMonGXwDMqKnvXsAmm/zC+8U2pwEr/pSVn+iEDzqdjepoOEl3FPt4CdL47MvDSU095ECMU0ya6PlZ4kWq/ewaCY5hyBa1RPfkzIpoQPNpRE6Zk63AEmYpxVYJhg2ZpuszTAdm+kVDTud55XwBNJfOFgtJAi0RMoHH2mOVoFtxRU/CxzUlcI+w6GXQqvaLyRRnU9RjARsSTlxng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:04:01 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:04:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
Date: Fri, 31 Jul 2026 10:59:48 +0200
Message-ID: <20260731090334.2911948-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731090334.2911948-1-arighi@nvidia.com>
References: <20260731090334.2911948-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 95767751-2e26-432d-a709-08deeee2a9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cjiG1tuN+IUPUA8LztKi88kJ7TGJQ52CIgUuk2cXE+DGr5ZG9LWqncDZL8UuOl2UauW8iiOr5YYlGXTvLQzBZzBD8nfNt9tEZCropdz6Jek05t8ODOoMMOVaIlLNGmLxDWwAsPkSKUghbZAc/JU1mULhwoiFSPaYXg6pqezCLL3AuTeDhBy2YvSs7q9IBGVjdsW4XB9Hu9vkLEDuHt3MJWD5I9KC8ZEhAqAmp7XtL94REG9xHu9tcHgeOMf5OOyG1kDgxLu/lIoSFPi/0Rcr/Vx2XhRGMHiWLxZk0k6DiQjbLQ6UTOQIBFu/DDz4W7Is2YEWY3mtDd8/ogKjwo2P1JmJZNpKCnudSXIijQiOHijXpyMqpUH1fnhwbGvC2r67lL8JJcDx5OYCe/yAC6XfmX36Z8+YsC+YKtsQdZq+J2XngRpyS6P748y46EV5rRZA70O+2NWZChhfBBl4V4HRfScsRLFk8P2m0Ea1eY4rWh757haIJ92dhHEP+Q9tOoUHs1CfvYUj4NbebgmQEeZYzeInM/ptsvFgMFockYmm0ie4Paxhr2UuP5Uvk00GdUF4KvnvFl8yFCdIBw4vJtef11W8Rx5xlY0uJQT398y3HbDwrfk/jyR0fM03LLwkJvVGXkThIXjTc0pKgAoRwxVPOPIPj+FilzS7oCRPLuvqPVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGOCBfBriPKOO6eGRvs+Ka1be/63WxUp8HV9Qa/IfZVxmfvl3RIaoqdKU8UM?=
 =?us-ascii?Q?vEU3yibJwa7EiKPnmdYnMrafML5h2Fmmc5RCP3myrN3TUSL6b8PCvjCApGX5?=
 =?us-ascii?Q?uzpvw8k2jp0BY6HZMWXvY9e2RPL+qNCrDQE5G3BQBscIdUSk7ZukBtzXkwrZ?=
 =?us-ascii?Q?KC41USmGZtLruAvXyNSyR7PY32cKg7CP2GOgn+8aKtaeoX92IXxjrytdypQN?=
 =?us-ascii?Q?ehLPzWMCdCcpkMfwtAbbIfJ/aXM11y9wZjInkwN1qrJFG+jl9CRDFqToYcYW?=
 =?us-ascii?Q?x/5Ie4fdB1/p2P+4re56ZIE1KQcuEpu60b7RJf0Aamh6BJ5NY1lzr6YnBkDw?=
 =?us-ascii?Q?9tY9/r6KDV0y5BkknPSZ8kRdeMbU+xQTMq5f7UwGNAXC5HWX/JyzQNX/QInR?=
 =?us-ascii?Q?8HNHHpKiVjp56mEqDIVR1LYiRM9MXEaupoXiL2TdPL6RK6ESwF4dpuElvJIJ?=
 =?us-ascii?Q?rgYF2qeM1tDwsEu23QVDXH3Xysi7+R0+jSdJoPKEPLyiSsyE5bAWQBE2BtM/?=
 =?us-ascii?Q?JEdvpN+8/5yyeMOUMYt/Dehm2+n5O/zvX3Jbl37KaF42U8Tmhw/EcG5Gm416?=
 =?us-ascii?Q?T6EnxGEu0dKcAVck47li5p0PlHZ0/nU/Qhc1wFfHsLFeFLmNBGmszMsr1MGP?=
 =?us-ascii?Q?mgwOwGgi8RMWBYJDQSSeYi5WlPswYcnatXryAejSpnjIg3PQdfX7rmdbspUd?=
 =?us-ascii?Q?AhHY9LT5BjuRVLG6ke0EmjuQvqSkd03gEuM2yPH4EXsXcZs6OO3YrtQ277IP?=
 =?us-ascii?Q?df6n+pkA2WQAEc+9PDYm9UhG224SSutWjE2OVKlaREM5KvqZjcwyYYlfcQK3?=
 =?us-ascii?Q?8QeWVkaN2UzCgY+fbi/jGWHgKywiDXrns1iW7jYUjYkoFIX4z6k+PjaQHxDW?=
 =?us-ascii?Q?YMxn0lqmo/eql2W7K58f4/BUhqugCpDLjT01t77oZh60SzpByvQp4EebOe3W?=
 =?us-ascii?Q?NCkK2dr52aPwAfjQjXBu6Q9yVVIH2WF5DUegJFqV3xFzEfppJDLYGRNFpghB?=
 =?us-ascii?Q?2cuXdavbhttzss6hbzW9Fs7YQWQLZ8grvnGTAHuCt2tEWPCUYcahNdeFPN4B?=
 =?us-ascii?Q?U7uKJwX5XVLbNJ7+2EFAT7IS6mwSs/+JZKjDFs8wwlyGO31bRp3pj414sarm?=
 =?us-ascii?Q?X/RyAQVmcet0+YOSJloETLNj8AqNtXiP/p8xdhY8p0I2CUiB90D5HpdBhphM?=
 =?us-ascii?Q?et+hoseLIGc4hS16a1Zq5Xo4JVwKaZW+AADF4FcnYAMRsbRHifvxEdvNoFFS?=
 =?us-ascii?Q?pm4a3fHZKLvrAOeyEq9teCDimtg/G4PfD+r+YpbMCvpdovtJexPv/jtq2yOk?=
 =?us-ascii?Q?OMEw5EpvfcjBOmNyZNCwXOGKY0jF1IpPWeE1xpZYQOiiaK+mufI2BqubvAzr?=
 =?us-ascii?Q?E29noOVTdUy2fb9AuIrjL1xtXYqlFM3Ca7aBBRpDSKkVkJ3UQXBbWYI4j/hz?=
 =?us-ascii?Q?JovqAONzn8EABvEXuuwTlXCwHzjw6mBNQwuaQiKyXyce6rA/K5yvZpZV3qy4?=
 =?us-ascii?Q?UTdQxApuZOQeTQCkPR7GYOyow6T+kMr1/v4yZ1n43ChfeaSQkL7FhLeTuoTK?=
 =?us-ascii?Q?4aY2ARUxpHF/goa3b2eE8hh2ypio+YK21YwVnYuPv7NZs7Oq4Pj8tOv82mEi?=
 =?us-ascii?Q?JXrVGSMCtXg+fSSO8p7XtshOMjPKSo/A9F0PogVRLdzo47/ksL5xwiSCquF9?=
 =?us-ascii?Q?tswheONsYc0zff74IkRRHmvT4ppvRXv6hOZuBgria4rFGKW5ge98EjBPmwVr?=
 =?us-ascii?Q?5xfQDqawXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95767751-2e26-432d-a709-08deeee2a9b0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:04:01.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYrjbSRwNyKs1jrfAq/sVVjoaV2RRvH1ot1bkVw0/B/WjhMiBw6Mr0cVYoV+1w6WYbfqstUk7S4LbV80WHNoxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

The built-in idle masks are reset with all online CPUs marked idle, but
idle state tracking starts only after the scheduler is fully enabled.
As a result, ops.init() can observe busy CPUs as idle, and those CPUs
remain incorrectly advertised until their next idle transition.

Enable idle tracking before ops.init() and refresh every online CPU under
its rq lock. Once a CPU is refreshed, later transitions keep its state
accurate. Keep ops.update_idle() notifications disabled until the
scheduler is fully enabled.

Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.h  |  4 +++-
 kernel/sched/ext/idle.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..495e7023c9ee1 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -59,11 +59,13 @@ static inline void init_sched_ext_class(void) {}
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+DECLARE_STATIC_KEY_FALSE(scx_idle_tracking_enabled);
+
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
 
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 {
-	if (scx_enabled())
+	if (static_branch_unlikely(&scx_idle_tracking_enabled))
 		__scx_update_idle(rq, idle, do_notify);
 }
 #else
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 3e9d6a44bf431..6d81bb7c43966 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -14,6 +14,9 @@
 #include "idle.h"
 #include "sub.h"
 
+/* Enable/disable idle state tracking */
+DEFINE_STATIC_KEY_FALSE(scx_idle_tracking_enabled);
+
 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
@@ -810,6 +813,15 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	if (static_branch_likely(&scx_builtin_idle_enabled))
 		update_builtin_idle(cpu, idle);
 
+	/*
+	 * Idle tracking starts before the scheduler is enabled so that the
+	 * built-in idle masks are accurate when ops.init() runs. Suppress
+	 * ops.update_idle() notifications until the scheduler is fully
+	 * enabled.
+	 */
+	if (!scx_enabled())
+		return;
+
 	/*
 	 * ops.update_idle() fires on real idle transitions, indicated by
 	 * @do_notify and managed by put_prev_task_idle()/set_next_task_idle().
@@ -838,8 +850,8 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 	int node;
 
 	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
+	 * Seed all online CPUs as idle. refresh_idle_masks() below corrects
+	 * their state before ops.init() runs.
 	 */
 	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
 		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
@@ -855,6 +867,23 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 	}
 }
 
+static void refresh_idle_masks(void)
+{
+	int cpu;
+
+	/*
+	 * Idle tracking is already enabled and the online CPU set is stable.
+	 * Once a CPU is refreshed under its rq lock, subsequent transitions
+	 * keep its state up to date.
+	 */
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		scoped_guard(rq_lock_irqsave, rq)
+			update_builtin_idle(cpu, rq->curr == rq->idle);
+	}
+}
+
 void scx_idle_enable(struct sched_ext_ops *ops)
 {
 	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
@@ -868,10 +897,15 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 
 	reset_idle_masks(ops);
+	static_branch_enable_cpuslocked(&scx_idle_tracking_enabled);
+
+	if (static_branch_likely(&scx_builtin_idle_enabled))
+		refresh_idle_masks();
 }
 
 void scx_idle_disable(void)
 {
+	static_branch_disable(&scx_idle_tracking_enabled);
 	static_branch_disable(&scx_builtin_idle_enabled);
 	static_branch_disable(&scx_builtin_idle_per_node);
 }
-- 
2.55.0

