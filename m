Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7318470121
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522298; cv=fail; b=f9TAwm5kKAFcKH4MIeVzu1tJLWj4bq1EVGCPqoRjOI3YtvHTfmEXjFfqH43dzabyXBGvwSu2/uVoC86NNsppqbtlxmVV/cbqv/AloIBa21zrpdPnNi6XAfhI3hZrv53RHGPnRl+NCRbIibc6z2YlFjtc16IFA+OiIIR0DA06s+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522298; c=relaxed/simple;
	bh=3U665K0biRwCFn7mnTTT8tKwxgz1LbCSrN+W0KYnJ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRUJS4qeOSzDghBfooYC3BnzEUTUa4rQ23HNarvCtmrAIe0HtE20A4NNKW1Guio8+Nixzv1uJpQgG4E0K2WdqF/1EgRQlHVS2t5/uGz0ZP8kh77wD4gjUB69n5cuQC1Li6cWJ7NNIAUVsXoIftmZmCGNkoow521bLcz+9yqdoPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jf0+36uV; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jf0+36uV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTAJKKNi4MtRVlFHlnXKg8D7pPSIlKMsQMmeYS9Q9TT3bTupfRqvVz7d5ZeqEBuGqaqcPtczgvzW7oChVmJAqR7QEzQ3QpXz52cCvjD1UkaaMqbA/Uy7TFfg82Lpa7hcz5/XX6QNQR1Z8cWAn4OQ9pzVY6vbzFXGt6Atp4kLD1mdKA2KD+ibVYsuY0fpqAEknmsWjh+/qXEiSTuZbHeiyZl6Pu8Uq1DEPdcIZakcWGftqtwZKOO0a3/P7iCan6jRwksmYWt7vslcIH34GOH5JmVDa3ESA5aTnalluNVLpy7YMCGJ8TNOMPwL9VDG9b8M5EMPgVB1wlEinZPw4i3ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YNZqj4yalnvo2LhJ9kV/uDwlDJMtfFF458ywk8aPsE=;
 b=LS2PE5P7/OQqOIJvQxslkZPwvKWwpAcSKIS1EM/X/+iNVV2dFfFBeDOR5X9txpuC0aUE/Dq6g6F6H16n0iLenEZlu14/xO3oL/nKW+bG7+wPttHhhxLKeKakVSC1Xeyj2S0lfY/7tEqJUVnflOhBcaMuc+wyan6tGEpz54uJ1a4gXZToePIF7HgNVAe/XaB5F7+IIFfImIJVgNfmNDkJvLXkODx75nQHy+kM6ESi5aOswYYmsgxbvpmoX+oCf6WIQlOFTvlFXhRtUOE6T6NoU3JUjAOOZDLV5GywksL0ft73AfePzYDYMxTm173JDme2qKPX8xolcMe7KvjNLM4cNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YNZqj4yalnvo2LhJ9kV/uDwlDJMtfFF458ywk8aPsE=;
 b=jf0+36uVaUh00lTisIoGMQY+J4O8PGAb5g+9XNGh4zmDHMVp8Hc8SpZ6B1ZAsX4hhVJ1e5Km6veJe+Zg6+Fvk5bBPQ9PSV9KjytiZHnEmUkvPbgqm8gJcp6emcqDPxi9bq+4E0nldNW76ghI9/i6bjcNgs9l0M8V2QZ8W/66O8jZcSpVvID6pIWEWI7aVJLOiYl1c2wtAdVtfdEW6FkuSGcDnsWiuITuuoL03JUxVWha5YmsL+wmdVFvrcnb7NlJoNfSJ7UVC0r62zaXcYZ5sJ3so4gIaFRac9fkayrqYS+da8ZKes6ff0V06GETBro5jpJ20peGhEZoGk93OlPRDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:24:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:24:49 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
Date: Fri, 31 Jul 2026 20:23:33 +0200
Message-ID: <20260731182406.3166853-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731182406.3166853-1-arighi@nvidia.com>
References: <20260731182406.3166853-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 266c0bf7-a1b5-408f-c864-08deef30f56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4NMRWmJRvaDILk3BhJScDZlo1c2iQA+0CQB8Yw7Be0uwtZ5F+qmfH8MPMxOvAfpPHsLVQAX+4YNmiJX263SepccqWu38DYSGJT4q4cbBofIm6qDxeJHsb3W+d/HKagakVQuPvH8xed45hTX5YDgMb89WRYVerh+giF+EZtegk2P+h6IWKeHPZCZuECpUmtXpdl7IFsUC6E54ppsbhJ3gcD3dmwbjmOSO4vAL12EpAt/kneA4BCz6pVZkpGiyV2IPTWoOubHv2rfhyI37iPGEXTnUtYtuP7K+PTH8iPHWm0wEybH0FQsqVX5zEW/xEg3tdjpFmJaV+aNUHWJQQst5W74KZngD+Mv8+BcyCsyryL0r8x0MT0OL8JxDCi3T9CYoxYaVqj6zyChbhhNNfVuk9ZX4zMX/PCTLvCkXkRXI6/mZbimE/mwLkshrhw7Nx42jgFpYLzZ4GX3cajNRBVSFUWM2f+b+lExTfUq6GjNEkEZCgBxKCw7J1DbzWLbIQE9kYQH11PzPAvckSZ8dtcQQHM6DkXvnS2/eOELpYLsGdWLYOdeXJA9UpOBPsNTLlRnM5WPc8A2BVEJhY+M/4CXHEOlBFDrRbOJt247etTcQuojrWlRiH9ymhG7gbl7LXW4yKv02H9GOGDJizI67v58yIjANpzM0v155gigvc5RGY/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gc2Bh7u20ZwbzIGi9X7HxzNCxqM5hshSue4RdWTLTlg2s3E5wQd7yiUE4UqW?=
 =?us-ascii?Q?vQ+hAvdj8vEkIgDlXyfVSNx6/d4UTCFCLi3O+hstVk4B0wOdUIxejdPHbqW9?=
 =?us-ascii?Q?jgihcRbbqbv2+rh5tSNwD58vl4guZfJ5rQNJfJbgbGE2v1pT8quGu19iudUk?=
 =?us-ascii?Q?GgJz6xIRGHo/NnsxbgSvhvPkJL4Mf1RQgZKF1sRGAl6z69bLfBjIdVuIirYm?=
 =?us-ascii?Q?RNroc8TMCNfvVCKEWoVWFUCmYXYF2QkE6gysns/76njqXkIMCyCF1dxgINbI?=
 =?us-ascii?Q?tzVNDRoYH5Ax0QejB3uA/GCgOzlGigqLzyjspCK7kvP0Ssa/clJKITnE3fG1?=
 =?us-ascii?Q?nF3W3znWwB1SegqK+PqXxj2tcAkr2jT26ke1iYTGJvMrjIYrao7+pfyrTGjM?=
 =?us-ascii?Q?613WkEgexPVH+jItQmk+EwhhYFjmXVplXS/Mz58cVALWNh+bGnjed8E8D08n?=
 =?us-ascii?Q?50yanelnByASwCdqQoVaoGL00AgmJmKEi5wQyzpyD1Cw0CppZzSrzFrJUWc9?=
 =?us-ascii?Q?6PlioX0Iq5Qkr+im9XBkRGX9t4zW/m8dfeidMGRHfWVaqIa1y0zyDEkP7sMr?=
 =?us-ascii?Q?TSGoy3EP4YSQ6YGg3ykiBCrsrRrNTx4EbAGchig/uSivHm+vn2hJl1b7FLBr?=
 =?us-ascii?Q?mLu3P2BLMin5Uuja+vMLOCdi/OAD085i47HG4Uh0hZOhhDLLacVxonixh2YR?=
 =?us-ascii?Q?TcGwFvcQuZi1wcbBGQOmWfNDqV5X9LnS1tH4IGSaY4UX1GXqUwvKf7t4ulXO?=
 =?us-ascii?Q?WHsjWMIv5cQcriU3R+Qg+KPi3TGGmk9Td/5iBjpxE6Qj/y9Qq8Tswu/V41Gl?=
 =?us-ascii?Q?w+8KU9dXH/6S5M8RiwF4BSScyT5maheS693tnu4JGrqWacPqWE+f/sdBCva5?=
 =?us-ascii?Q?K/vhOwXtsh7nhSZE2cGWO/wOHmKIxWAWmOl5Gbyuzt5ODrgUGcgZNX3gwbIb?=
 =?us-ascii?Q?h07+5AWRypMPkLrc/MZ1CIcq09Cnbh7JMckStGqa+0rMDrzW0SdIfVQihWiS?=
 =?us-ascii?Q?A5vl3+sFzOUh0fxiPhzSxOFvcQfRJyIfyMlD84lx+jawvl+jHXgGkR0DNY8S?=
 =?us-ascii?Q?twkdOBItcqUSMbeEwrS5UvTShKK8+0nZmoIf24XgP8bGe2/OicUBni4+DC2i?=
 =?us-ascii?Q?JJlHG+vnVX6JYbojMiYAObTv4FPBe0bFt310KzMTNZLNbCiKOH7qZp9Ls8Dw?=
 =?us-ascii?Q?WOjRDNTvmkgKFOX4KSJvc433WEBjtCDC0ZBIxWYXdVTl5Rwt+pcQmMVzpZPk?=
 =?us-ascii?Q?pn+F8fUrkozX7qc+YLzOvsmFCGDbNIzNXcUWxRNtJ2KQypHQN/Ehrw5ZiX3G?=
 =?us-ascii?Q?6V6gWvurkKcV9GgPE+jgMFNYJahw6UG+1Hg7qCrzElYpkpnnB1cpEkEzU/eu?=
 =?us-ascii?Q?XuoDECd3wz4/3eb5n8YYNFex1B1wFsRRV7u5J2st8wY20GCWilRN9FUdpoQC?=
 =?us-ascii?Q?fVHdZftgN+0OLJo1+p26cPhbos+wt933hHmgF3oVpvQCTKIc9UN8p5WUN37n?=
 =?us-ascii?Q?SwHfOijf9DpdY5WFLN1gl060GC4T9ieueseCaKqPcjweN/fwiBe5XJAzqPK2?=
 =?us-ascii?Q?8CtvDUwgHfvNNnUU2i2axcOvUUISInhzYANccyOs7ysxsOBc73OVMf1F/F2B?=
 =?us-ascii?Q?Fl7yM63Ooh+48yrx+s/hpzKBlYGlX1MJnDS1HKyNj0YiD0rKgnS0Ms8lZxZH?=
 =?us-ascii?Q?iY3Hs0GqiRAZefFMAF4IarYQa3WYMNIDa6BxU4ncgbpmGE21IaP2EV6v3r9G?=
 =?us-ascii?Q?yQvJDld4Dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266c0bf7-a1b5-408f-c864-08deef30f56e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:24:28.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6COn/9xfOaqAG4pe559CVfeW/w7e6UVqShgJzw3w1PdA5lFJBzrJoDz0+zPjm7HlAgTaYsojVrtCRPvTRVaenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

The built-in idle masks are reset with all online CPUs marked idle, but
idle state tracking starts only after the scheduler is fully enabled.
As a result, ops.init() can observe busy CPUs as idle, and those CPUs
remain incorrectly advertised until their next idle transition.

Enable built-in idle tracking before ops.init() and refresh every online
CPU under its rq lock. Once a CPU is refreshed, later transitions keep
its state accurate. Keep ops.update_idle() notifications disabled until
the scheduler is fully enabled.

Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.h  |  5 ++++-
 kernel/sched/ext/idle.c | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..6d0dab822711f 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -59,11 +59,14 @@ static inline void init_sched_ext_class(void) {}
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+DECLARE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
 
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 {
-	if (scx_enabled())
+	if (scx_enabled() ||
+	    static_branch_unlikely(&scx_builtin_idle_enabled))
 		__scx_update_idle(rq, idle, do_notify);
 }
 #else
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 3e9d6a44bf431..edbfc80a04c74 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -15,7 +15,7 @@
 #include "sub.h"
 
 /* Enable/disable built-in idle CPU selection policy */
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 /* Enable/disable per-node idle cpumasks */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
@@ -810,6 +810,15 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
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
@@ -838,8 +847,8 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 	int node;
 
 	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
+	 * Seed all online CPUs as idle. refresh_idle_masks() below corrects
+	 * their state before ops.init() runs.
 	 */
 	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
 		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
@@ -855,6 +864,23 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
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
@@ -868,6 +894,9 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 
 	reset_idle_masks(ops);
+
+	if (static_branch_likely(&scx_builtin_idle_enabled))
+		refresh_idle_masks();
 }
 
 void scx_idle_disable(void)
-- 
2.55.0

