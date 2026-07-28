Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA732BF24
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253544; cv=fail; b=VHI/87jBgetPxFmirWM5H9vXqxt+hoiXWb8PbOjyV4BLSGllMdv8IiYkdUbv18XBeiJEbByiklEXo1CrrcdtGsxvHppuyBSIV+5Rd8LiKHtpk2UWBl6QKzNVMJJBfbZUR47zCxSzfueE+7HF4CSyCq64Ah9r0xO020XH0pQh8Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253544; c=relaxed/simple;
	bh=g0ZPV23CEOuKjmfQzIdsUPFm8pFzkNnbiZD18vM5kik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVUb83pJqt1Z6YP7/JmKJ1Zrzr75chqqGdALe96VhieGmQWZIH35d3iywykgvi1FuQWB1hUdFv6jheVWqJjzeFigIgWepLJFcnI0nQoXyMY/u4W7uD4U0Cg1rDSOXeO3HBO+todER0018Jo7i9WPN14eMWW/rAlJku4YjPzBhzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFYLV42z; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFYLV42z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqSfLUKTtUVOqqJHag2lEqoa2PMOQFiac6w1XI8zQouAF2NEcWyAeCU+NK7SkA/pAHnTNmqK6LzqZNew4hiDFxlDHQmKX8C0slwX+8XelVoyPqzYEDj+Vg0ew+zdWO4j2LrSVmoPhrJt0Ikwqrev5m3bQESb0Cr8VyG7EYFngGNYWGZO77c1zBXg2iG17Gb0GU/xLLagTIRVka9RpnuXFdTSGeTc+3znE3IYpFGTf+A/nXPNMRbw0Hw0xcul8TEK9Xn9HpliZKUoN62qJRpstHBKxU6BAhOyNQZ+FRd7pLZ7kekuHYfoYIYf9TeRdKQ+GGyE3tkGFe9/C028E3xw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y412Od6lLioR79CwkcYphkNCLJHFSIgS4ptNJfyg6x0=;
 b=bUS6SkSbii3f2WvFCARZnwbfeiPLVFuS2o0imAd19GspKJex+xDDIVBLDeTiMC3iFIPfPqwvL2VkJBOtsyU18GyFqupkrQKFEg3+czYTavB+W/rmSNUTwFNIlUJ9ixjqX7izdSGBLcUEUi4zCgKThoFKdkczmcbBajZh/78hokNJDTodEScKKo2VGgd27N6adaJXgW3nOBisOaBojZp/ANJFRg+IlN2jcmYTxmcNR6drvo2JcGpd69RuRywGaKvXRy2hdRcDt3qJvbE0QodPN1JdKFXOeloSZsBUBzU7DuXrdvcFZDo0eOM6oItBLPzFsVkUNqOJoCIHzGN8VbqEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y412Od6lLioR79CwkcYphkNCLJHFSIgS4ptNJfyg6x0=;
 b=mFYLV42zw/KqYmnLYr+FUefP1f2Nwo5jCT0uAKXQnhjR7N40Lkaf9aEAIrgv+vQ9gTSxwRKX27EQ4J0DXghwuE8yeECioV6Mv7YAPfERZTX9AwsKqGvgJ4GkTM9XXOhRpIOU8+aAZ3ONQolPDhneK5iMxPgKqBn5WlzVKHQA0pCHdIHESepr9pomx0eFhBaJJOVUzxxSCPjIw9AbUyr+BAB+KmZYL/JKB8p5JjADK5JmCwwajiKBN8i40fVAf8qbV5E0EL36vNn4oyrz+T39zn0O3iU7JDE34qxtEAsz0helF+hcpjbAtxVMU4TbvP7T6opxwtSCgA59YND5mXISPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:32 +0000
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
Subject: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Tue, 28 Jul 2026 17:43:28 +0200
Message-ID: <20260728154425.1549660-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: e23c58dc-a630-4037-8dfa-08deecbf41f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fN5MzVDALtYEk4WLtUudF1HXld7UF6QFTBVZmh7KGFtSLBiVGVru2W6a6D51Kyq6xSGBvb5QskDEBwvrDRpHxCZthChZn+DbCsUzeD2i1YOuy1unwbKkULssCfnHAsvqUNDaS2veP+YgMkMQWWQDGNX7ngYt+82+gEup0Ze7mVyktlb867iuR/ZzCxOMNsrwJESOCPED4Hz3sua4A1AznmHxNmU2+iofEFkKcUY1Ba4mYMXVECrAiPCBDXz8VhtHX0jI8gq5SrjYlwYrwbKr5j31hI//Cp2V2X8teKbQmxwyqROt1trLRcqdR5vHKQm9Ygz1D9cDEkJcbEGyX0wuZKQanHqpTQdR9PPVRvI6Cv8+xAlhhsm1+FLSjAXLdhW04dueJKO8e8j0sD3luEzCRs9gmZlNc126rigKcnr9EQqHeYMoL/U9TdmwfWCfNb+AqUg5Csm3Ugoiy/uU4fvTruHpewO7plXl9vl4eL+8mH4AinNnHgVk2tL4oNkh6pKkjdKQz7e+hZCZ4DPfT2e6A82chi+BWg8DThQFleM2Mxja5jG+u9SfXxxAnfJzpsKcHRdpWTjtMRNr0zPR7h3We6v5nuGAm6nor5BAlOK6e4ywGORz8TTsfkP7eb2VrQbdq9DXA47NAAqjKpODoBqBPy0+YUlfiNc5zfaVnw/wB7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+GQ9XYPaN4EmEQWhmkpX7r5pMF7Sw+vNAz6pH9H/JyWjvJcJh1b3d2rtoW/?=
 =?us-ascii?Q?ufa+UJeu/Celn+Q2DtIKRLWiSHUL1K3r/sKVRzzd47DfZIcw1vqCibuoMiSw?=
 =?us-ascii?Q?wJ8T54Xq3tu0mA+Z0n42Y9l+DsL4zFbsuHJUPArkw67pUqFMcdqItE6iQ4IM?=
 =?us-ascii?Q?kMo9I5SEesl783Bpa4WYLTZbAbunOLAifzcDsLh0CjmmLl2YBM1/ec7IbkL2?=
 =?us-ascii?Q?ZdyGahJRPQfrTzTlrUcMv3JQMemZSirc/kzlvwiySvOHXZ49ypOuV4myLxLM?=
 =?us-ascii?Q?OlAHXmnDi7ijFu6DGoXtkBnREZ05p8VQfeGHxla/v/McOAsnf9Ig00JUrhg6?=
 =?us-ascii?Q?CROjgRopz4pO21gFOgeYmsZHu76v07y6MR2JNbEVg0I/LPpKEL9ncUgDk6FX?=
 =?us-ascii?Q?MLfiQB9C/tWXAPfSY/vZ5XvteuRU9O/LQOswmLHZjTxGyygdB+I75/tMyjo5?=
 =?us-ascii?Q?NxMfVdGeKlSQUaEoFPyjvLMWjPBo68WyrrXJtyAGFTZkIFETOlgt9ZWnOhEb?=
 =?us-ascii?Q?eOWCeJOyTpcLcxtO1Zoxfi1x36J+c+CUZrLjLUJhEjG/NClJm1hIHgcPztb1?=
 =?us-ascii?Q?Avc9jQ6Eyv69RYsa9fVX0JYA+zx6lInn+9z2KjnnK27/5VQzwFUccSB25IPj?=
 =?us-ascii?Q?wPCKJ5fxa7Pc9Gj6sbfW/e7U/c+ntVuJIHp2wNftYYs+nEmTqK2yFepwWk/b?=
 =?us-ascii?Q?QQpOQp/YfG5MHxjoEvQIR9QSbmBymiYWjDJLEXgnTP0/8kHwcI53qhAAKaJC?=
 =?us-ascii?Q?n+nXdR4OXK4nW8qBT+ChJ656a+H1qm8dIG3qWYV6GeLfwfG9HO476bxIL2Ty?=
 =?us-ascii?Q?5/KzKFZNeWz4CHsYlrb8pyK5Fdj3HeD0tkgdXTeF3PWsy12/I3kRRjj1myAB?=
 =?us-ascii?Q?E9WA8sjXo33twhJsWFB8t6y5dMgBorA70SX7fttgSRvOmvE2nf2HWGujAAzs?=
 =?us-ascii?Q?HqhTkf10pYC6OXh7td1HVyhIpIumrY5zhz92yhWWnklpKnHx2eZHa2zyF4XW?=
 =?us-ascii?Q?xpZZBvqe/PM69XYcNDANue7csLgRTDNV1VuiuH2qz/LSi/9yxPU7OcMpMYdR?=
 =?us-ascii?Q?79/nE6/MtPzBUKax2MVmqSG+o3faS2moUUs6byJB4Y0Sw4dehHn9hgAfVQbl?=
 =?us-ascii?Q?EIn3QDW3E1Z2IdJveeZtkn9uAkd5fNV9EXREBFtFteGddCWvU1FWMEjwDHib?=
 =?us-ascii?Q?AQSBM3v5BR66SATJWjOsaxZTvfdooEpTdIdVY5IwNeVuLgnr5fpeZMXStzmG?=
 =?us-ascii?Q?t0lxQYSF7cUoSV77r510wQf9xPIZJ5SDPiOjzYlLPF6AF/89JyUF0+8DkWbi?=
 =?us-ascii?Q?DgU1c6TB9hgVNqV4V4k2Cp/S5HpJdhH5feK2oqF/+U4r1riAl/cCs/K4HQco?=
 =?us-ascii?Q?g77lmFV5rafAqn+BMyw+O+lDyV0SNUHGCHHSEeKw5dN2j1s5Pmu19KlC5T+b?=
 =?us-ascii?Q?XhzLbTda89au9L0OfzRmXyuSjyPQSu4+gBcWTUW0gNV+LpxZ9CljZBp70F2p?=
 =?us-ascii?Q?uPSqryDzB/bywkl7k/bkd6Bx6m78JYOA4Fhw2wZvosJRIufaOvmWIXjJJRs+?=
 =?us-ascii?Q?gNbMea0CIdyq64aSukU8+Gebm5wiybON1UTuxDPVhuOhW6bu8YHFVWB+Imn6?=
 =?us-ascii?Q?aB4GFjq5Y1FLCtR/8+ty8v3ZNuS+4ut7JaFbclq6pRemuQjtJSK20myZroGG?=
 =?us-ascii?Q?KJCGx6qWJqcj8O57clyXNxnOfEw2Wg3SXYZnl7NlfaAD/qqxiw/oYPExs2kd?=
 =?us-ascii?Q?Ga0PUcBdRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23c58dc-a630-4037-8dfa-08deecbf41f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:32.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuyDwwo6uA20+W0lHipgo6R+9VYVbV3BSM/aMutvdb3Wjp3ZSo7gTnxn6UjG0l6HhEOAx8LWrCzlR3/v+4O6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

Without proxy execution, the DSQ lock and holding_cpu handshake ensure
that a task cannot be dequeued or start running during an rq-lock
handoff without clearing holding_cpu.

Proxy execution is an exception: a task can start physically executing
as a lock owner while its scheduling context remains on a DSQ; its
on-CPU or migration-disabled state can therefore change without clearing
holding_cpu.

Recheck these states after acquiring the source rq lock. If the transfer
can no longer proceed, park the task on the source rq's reject DSQ and
re-enqueue it through its owning scheduler. This preserves the BPF
scheduler's placement policy and keeps descendant tasks within their
sub-scheduler's cap grants.

Implement the scx_proxy_resolved() hook to drain the parked tasks once
proxy resolution has settled and the outgoing owner has switched out.

Without this change and proxy execution enabled, stress-ng --pipeherd
can trigger this race and migrate an active execution context, leading
to sleeping-while-atomic warnings and subsequent lockdep corruption.

This is a preparatory change to support proxy execution with sched_ext.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |   5 ++
 kernel/sched/ext/ext.c    | 154 +++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h      |   1 +
 3 files changed, 141 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 0f25d99f5fdd0..53da9eea0c925 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -135,6 +135,9 @@ enum scx_ent_flags {
 	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 * PREEMPTED	preempted while running
 	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
+	 * MIGRATION_DISABLED
+	 *		migration-disabled during a remote DSQ transfer
+	 * PROXY	physically executing or donating during a remote DSQ transfer
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 3,
@@ -145,6 +148,8 @@ enum scx_ent_flags {
 	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_MIGRATION_DISABLED = 5 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_PROXY	= 6 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index fd4860b7fce4e..3fe66298d1811 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1066,8 +1066,17 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+/*
+ * Proxy resolution happens before rq->curr is switched. Queue deferred work
+ * on the rq so that an outgoing proxy owner has cleared on_cpu by the time
+ * reject_dsq is drained.
+ */
 void scx_proxy_resolved(struct rq *rq)
 {
+	lockdep_assert_rq_held(rq);
+
+	if (rq->scx.flags & SCX_RQ_PROXY_REENQ)
+		schedule_deferred_locked(rq);
 }
 
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -1458,9 +1467,15 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 {
 	call_task_dequeue(sch, rq, p, 0);
 
-	/* rejected: kick the deferred reenq, skip wakeup/preemption */
+	/*
+	 * Proxy-active tasks must remain parked until proxy resolution. Other
+	 * rejects can be reenqueued immediately.
+	 */
 	if (unlikely(dsq->id == SCX_DSQ_REJECT)) {
-		schedule_deferred_locked(rq);
+		if (p->scx.reject_reason == SCX_TASK_REENQ_PROXY)
+			rq->scx.flags |= SCX_RQ_PROXY_REENQ;
+		else
+			schedule_deferred_locked(rq);
 		return;
 	}
 
@@ -2379,8 +2394,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  *
- * The caller must ensure that @p and @rq are on different CPUs.
- * If enforce == true, caller must hold @p's rq lock.
+ * The caller must ensure that @p and @rq are on different CPUs. If @enforce is
+ * true, report violations attributable to BPF-directed migrations. The caller
+ * must hold @p's rq lock to avoid reporting a transient race as a scheduler
+ * error.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2388,11 +2405,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2439,6 +2451,60 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Proxy execution can change @p's execution and migration-disabled state
+ * without touching its DSQ entry or clearing holding_cpu. Check those states
+ * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
+ * sufficient and this must not affect the existing migration path.
+ */
+static u32 task_move_reject_reason(struct task_struct *p)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	if (!sched_proxy_exec())
+		return SCX_TASK_REENQ_NONE;
+
+	/* @p may be rq->curr under another task's scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return SCX_TASK_REENQ_PROXY;
+
+	/*
+	 * Reject only BPF-directed migration. proxy_migrate_task() may still
+	 * move a blocked donor's scheduling context to its lock owner's CPU.
+	 */
+	if (is_migration_disabled(p))
+		return SCX_TASK_REENQ_MIGRATION_DISABLED;
+
+	/* Don't move an active scheduling context off its source rq. */
+	if (task_current_donor(src_rq, p))
+		return SCX_TASK_REENQ_PROXY;
+
+	return SCX_TASK_REENQ_NONE;
+}
+
+/*
+ * Park a task whose remote transfer raced with proxy execution. Reenqueueing
+ * from the source rq makes the task's owning scheduler choose its placement
+ * again and preserves sub-scheduler containment.
+ */
+static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
+			    struct task_struct *p, u64 enq_flags, u32 reason)
+{
+	lockdep_assert_rq_held(rq);
+	WARN_ON_ONCE(reason != SCX_TASK_REENQ_MIGRATION_DISABLED &&
+		     reason != SCX_TASK_REENQ_PROXY);
+	WARN_ON_ONCE(p->scx.reject_reason);
+
+	p->scx.holding_cpu = -1;
+	p->scx.reject_reason = reason;
+	p->scx.flags &= ~SCX_TASK_IMMED;
+	enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT);
+
+	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, enq_flags);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2496,6 +2562,23 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		u32 reject_reason = task_move_reject_reason(p);
+
+		/*
+		 * Proxy execution may have changed @p's running or
+		 * migration-disabled state while switching rq locks without
+		 * clearing holding_cpu. Park it on the source rq and let its
+		 * owning scheduler choose its placement again.
+		 */
+		if (unlikely(reject_reason)) {
+			p->scx.dsq = NULL;
+			scx_reject_task(sch, src_rq, p,
+					enq_flags | SCX_ENQ_CLEAR_OPSS,
+					reject_reason);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2526,6 +2609,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct scx_dispatch_q *dst_dsq)
 {
 	struct rq *src_rq = task_rq(p), *dst_rq;
+	u32 reject_reason;
 
 	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
 	lockdep_assert_held(&src_dsq->lock);
@@ -2533,6 +2617,15 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		reject_reason = src_rq != dst_rq ?
+			task_move_reject_reason(p) : SCX_TASK_REENQ_NONE;
+		if (unlikely(reject_reason)) {
+			dispatch_dequeue_locked(p, src_dsq);
+			raw_spin_unlock(&src_dsq->lock);
+			scx_reject_task(sch, src_rq, p, enq_flags,
+					reject_reason);
+			return src_rq;
+		}
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
@@ -2688,6 +2781,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
 		bool fallback = false;
+		u32 reject_reason;
+
+		reject_reason = src_rq != dst_rq ?
+			task_move_reject_reason(p) : SCX_TASK_REENQ_NONE;
+
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2697,9 +2795,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     enq_flags);
-		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			p->scx.holding_cpu = -1;
+		} else if (unlikely(reject_reason)) {
 			fallback = true;
+			scx_reject_task(sch, src_rq, p, enq_flags,
+					reject_reason);
+		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq,
+							       true))) {
+			fallback = true;
+			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
 		} else {
@@ -4399,37 +4502,45 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked until proxy resolution schedules another drain after switch-out.
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler. The private list below prevents a task from being revisited in
- * the same round.
+ * scheduler.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	struct task_struct *p, *n;
+	bool proxy_pending = false;
 
 	lockdep_assert_rq_held(rq);
 
-	if (list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list)) {
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
 		return;
+	}
 
 	/*
-	 * Move tasks to a private list so a task re-rejected by
+	 * Move ready tasks to a private list so a task re-rejected by
 	 * scx_do_enqueue_task() below isn't revisited this round.
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
 		u32 reason = p->scx.reject_reason;
 
 		/* migration_pending tasks should have bypassed to local DSQ */
-		if (WARN_ON_ONCE(p->migration_pending))
-			continue;
+		WARN_ON_ONCE(p->migration_pending);
 		if (WARN_ON_ONCE(!reason))
 			continue;
 
+		if (reason == SCX_TASK_REENQ_PROXY &&
+		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
+			proxy_pending = true;
+			continue;
+		}
+
 		scx_dispatch_dequeue(rq, p);
 		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
 
@@ -4440,6 +4551,11 @@ static void scx_reenq_reject(struct rq *rq)
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
+	if (proxy_pending)
+		rq->scx.flags |= SCX_RQ_PROXY_REENQ;
+	else
+		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
+
 	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
 		list_del_init(&p->scx.dsq_list.node);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ade8bb393786a..bbd90329585a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -789,6 +789,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
 	SCX_RQ_ROOT_IDLE_RENOTIFY	= 1 << 8, /* the root is owed update_idle() */
+	SCX_RQ_PROXY_REENQ	= 1 << 9, /* proxy-rejected tasks need reenqueue */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
-- 
2.55.0

