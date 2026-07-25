Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975C1AA797
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995602; cv=fail; b=LHjL5W30749swSCLt+PgJrdqvLHM0tjCPnP4vCVHwDhagGvdsovdp3reynFMgQ8cNtOCqRC2JGtUXmQMqORRd9DONgwfpQq56iSaNTL2+/17Cog9Mz18FxN/r9SJejcWwA4cHN8TAXwktRCcu9qDZn4CB2I+IusqDxhsL0/Y9RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995602; c=relaxed/simple;
	bh=cju0oZJYdilUFLawyTbj74larhiX+sW+3L51DCTe53Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0CC80KZuiPh853W6OLujlJGp+som5VauF5xAdjzKx9lwIY2wj75jvEfWyad/BNUwpF1448Um0ELIs4vKCHUQsTlcJVzpmsBANVijOkY+6+aAOkbq5jmv0nRZ5vB3tyHkVJ+A7yEkUUlfsiKEXyc3pNqf1kSWvjUgHD/NP3d4+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3D6IYWD; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3D6IYWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJKWgEKdUoB4udHyNhr9R2Jaf8YuV5Ste9Ss8gUjQTL6BFegvm7jHhKlCtxqZLom1K/xKcEu22st4Mgiqu+sbs6V+34/4v/G67nOYp0VxXtbbuCPqaWfcWBYMPJWWtaJi0l0aqOZzjXcKmmipXnnWq9IomaW42NvCO0P5ivoF2PMily/sElzx2xLHuz0eg3v5nALUYvfvXfJPggMc3nMxoxOOhe32GeduRjyjJQA8DIHtx+MEsOVD06ZTq64gpaa2G40osOcmaGsheHENYguX/ksX6hwtqSJFgqQ7wwgrlNfHjvpFY4wL9yu38dRvNt7pHZ6vM6ojgcHkFMyu8WF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKuHSTrmMaIdsu9FljsoTRELMeWDFj5bVKsP33gLIxM=;
 b=x5KLh4/0T3fw5dpiv/BA5eewTrES8B6C81dG5qZW+6i6U1WkL/lnN6TfRqis5RBdt4fu/VXyY1Ljtj1wbdg58Wc3U1arlvxYLdqDYpPTQa7Z7GbKOO47PvAEJP2eeHALI5+r9J1OEN5t4gTokdHOEJHCxLnroVBkDmeDTdQZC8O+GEVmzGEtowOvfxQnzSaH+/tRU6hWly+ORlI6dFEywY7jMp8MJOGv5nF9DN3ujQmY/dtNGE/7jM4na+WRDt2JWAr5VAQaa1VtWMfGDMAlWm6CfhHMenkgh7xeCkyCESug9xv+3d586BHOp5CA3AcYYIpNgl/7M8ADJu5pMGyXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKuHSTrmMaIdsu9FljsoTRELMeWDFj5bVKsP33gLIxM=;
 b=W3D6IYWDcCqJHndZKhLEgB9jGLr053KDOCc41iNBxMjNlkTfejy1RM6FKx7bwN8pKDSS3aM+EhCKQDCp4MDYzPof2SisXJVi48GXJGKM9L1+9Fv3LwmdRH8zDAQSMwzfROFvMnR2m+VsA2Z5VVpeqUCQNXbI6VyGtJlElRnTF7lZky8d82wysHGOlWV3z3bWRvt9g2psVX0J9NjsRo9q7KUu6Vs83A0B5yvB9D6odHN1M4Wy1UNQd2H+GTc7moMp5PrJI1wKzBAOMelVLSHldKIvVdlJHkQaASBbedUvuoK7I/EsLobL/OJLtPBkGDvx6jNcEi3/K1gnpr+0QXMuYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:34 +0000
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
Subject: [PATCH 09/14] sched_ext: Handle proxy-exec races in remote DSQ transfers
Date: Sat, 25 Jul 2026 18:04:15 +0200
Message-ID: <20260725160513.57477-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 536e6ff5-e486-4954-d7c7-08deea66b313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zB8Em8eVYH7a9SVkT9UwLh+lpQen0Ji/DPy7MpH7cECUSN3AeA9teqoKY+Jfp97ipPNq3PZUPsXm6Hmf3ZyR1zbEAgSF9L04nFNb6x2hdzBmnU8vdjsFUVMqBbVZBPQEXhzwlGMo0i7WGyvAjOVl58bNj7hoBMAlMp/ctXOa8HKP91mGOm/HXeNeXwg4W14ulEKXBzYRoNO533d5Vn5bpt3SoQfmUI9NMleDIck3Mzj7BiFTXujeX3F6jFN0Kt75ms+klm27Th5poRNqE3sy/f8aJWZsrD8s/JQvw3PPxPV5/0ObdXhsTmMx6OpMfnZ6pXJbcfpNEyTxAomSmMiJ2/nibTi5PmcDLfRE+eEj0ZDxW03zXC1DlLEWuBHOyVVz+LCBVupjG6dhVJqdABge5nYeskmkj8K07NW3sTEEou164aKTPG7CBD1OzIUx1LcZUmN7yyvV9nizYUzzB4iLvOuwcz3ZfR8cVbaQV3qq6dEEOUlMaBzGQeBYgEy2dhM1FGk4JyUXOUUH5P73W+bHzJl32WPB9j6B2qj7rk3MZv3n5r6gVnbujGaYcjtj07gpTy2srw4rvmMce9ufwcVax5RyKz9Af8M9mhHZfCQldaATWncgXnZO9Fwu5JwnYCKlVaXDVCrDbanA8IhLRXBPy2zPSBWU9ucvDlBq4VeNmDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mza+bKhhlCM3rXkTRamI1NiV0MYkt4NSNsuRqLKl6YHUhyGnsfBsL1p6o49R?=
 =?us-ascii?Q?kZOJg3F6i300EPYplXU32g/PDBq3GgZefASBJiQynBtHw2aPlAAtr/8M7pq1?=
 =?us-ascii?Q?yYtQFSE441WIVhGesgWtr4KXKo3z5GRHuK6Bv591eCX8TibUgACnpTJpzShO?=
 =?us-ascii?Q?dfXZaqvJk7G8vmZRQvs0oVrsML04ephlBpZsqpRC6jIKnXp+0NVzRVMRF/uv?=
 =?us-ascii?Q?D0NPpqumZa2wsxWs1eCm94ZEMQS54F0KsnKLm6YljpeMl7GYqGay0yiK9JhC?=
 =?us-ascii?Q?9UlwnAMk6KWLUHmzjuXFEuk7/RT3sHGOGh9AeyeUUcSbYNAR9h0mYCZxsrj8?=
 =?us-ascii?Q?g6Z0GagILsCcX2e9lljw2y1EOxzkk4APuVNr+GQHfPJYnlp/Z1v7YDygOU2q?=
 =?us-ascii?Q?VKh+yo7vt3vpJ9WFywOWHopZoaf03OVLlgUMfphU65IhhTBx79eUzBeDe95R?=
 =?us-ascii?Q?QVXssZ0bzjbx4bUoDJIxJuziz5PkHoZVGnkjEcbS0DTZDOWQF0j//DBJZXqF?=
 =?us-ascii?Q?kPWxCVPOUVXRyGCMT7C5z7R0lEUqd+Y0uL/ndX+WcmBMspuPo3SV/SdnDkko?=
 =?us-ascii?Q?0u4zeZobEmCDhFixg45TCLSHzEeo1/5JTdjFCEEONKiQ4BBpKjX4Eu1XyyL/?=
 =?us-ascii?Q?kIg+6qX9WZvsKChifvIK/SM85ad//cUJvNt2PB8MYddkNad/uR3JFRkgpjNZ?=
 =?us-ascii?Q?nXm00T3lXXOdLPkIRiBefNTc/Efgu4SKhT++/Qh/mc0XbbvgKJ/l0wkvBO6s?=
 =?us-ascii?Q?us6yMaX1S9LrtHqUwDQ1xJdqhD6QRhu2hQT7ef1J1/PSvizjugeAReA8OTRZ?=
 =?us-ascii?Q?qZPFbXkyODWwSutK2tQW0t8pCiIsOiqYexaz+paigtvuPMcwyFE7Bn0JXbhM?=
 =?us-ascii?Q?E3jfteVUxr2DkgfTQ+nmkLLTd9ks78D2eOJWUZmC+hpmv4j+krywvLuFR5Wm?=
 =?us-ascii?Q?YyXK029Omf1b3GuR8YnbKazgih742As5Ss9jDp/w8hPfqyXRcSV8gpNSrAOz?=
 =?us-ascii?Q?JxhnL2JEnFfcCVFcc7L3vJ6IJo9e+C2GgdqY0s0wuYp7yLm2sRcViHr/5FSQ?=
 =?us-ascii?Q?Ap+HlylCMaG13V0WMj1CzoYUBU6Ndbcs4av1A9jSgVMzFSh52eVO8yMqzqIl?=
 =?us-ascii?Q?avNqkr+HuU3RP1nP7Hio3i4QezccRv2aNPa7HOtryRl/DFWCUkVq+7VdS3tQ?=
 =?us-ascii?Q?wkOOtEFOpRKWBHKS8UVMRv4RkkboxipqxdL34ChAB8+jdgIwMn0C7o3zauvT?=
 =?us-ascii?Q?8/kiWMzOBL70mv8dSc0TLF6a5KytILRMmxkIaJRkV32KIcxADqWCNI6+amxX?=
 =?us-ascii?Q?q7B718oFPOaNWNQcopwrdJLSlwPa+KlAyXAXU+eZh7tB/UAAE2QbNPKtWx+Z?=
 =?us-ascii?Q?0tVpeBsFbV2RT9mpkYQQMfKTSb/XmAdQaXDTGmwRUhdGkKyoebptlVQJgOCi?=
 =?us-ascii?Q?icAINuOS4Etlj2QTaVaSyqzX8XW2eArt24iwm7+bm0M+MFQTmnIztkEvDagv?=
 =?us-ascii?Q?vHAY0oSDeCgh10Ik8LCrBWetarObsS0phxsa5XS+KLqYegmcknwGnBG0ap3i?=
 =?us-ascii?Q?IKxBAFzEt0CFizpDiFkw62fdxoEMPRJMK6s52bF0y2NzYaJjMfHY+CdTqFPL?=
 =?us-ascii?Q?kAIj0IgSkfSczhsfCKz1y/ddzYPHhMxibxV2HA5+8x0XYsWSgAEg8lWVH7sM?=
 =?us-ascii?Q?sehD8Na0lfGRznm52j/PT3yrwBdsX8VEFBPccrGFzGbmsn0bQJjeWtROGUJ7?=
 =?us-ascii?Q?m9RgcnYtNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536e6ff5-e486-4954-d7c7-08deea66b313
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:34.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 941QDtCgJtMqWx0xAkUJky74U5fslgT3+AH/pwbTm4RmeAO4kdyizyXL0/OAS3Xk0SqAsa2WtMb/jMK8BPwNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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
 3 files changed, 140 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 91b255fdd16bc..4d16c225e9af1 100644
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
index 2fcd303b44894..95aca029a6e57 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1069,8 +1069,17 @@ static void schedule_deferred_locked(struct rq *rq)
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
@@ -1449,9 +1458,15 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
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
 
@@ -2350,8 +2365,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
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
@@ -2359,11 +2376,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2410,6 +2422,60 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
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
@@ -2467,6 +2533,23 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
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
@@ -2497,6 +2580,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct scx_dispatch_q *dst_dsq)
 {
 	struct rq *src_rq = task_rq(p), *dst_rq;
+	u32 reject_reason;
 
 	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
 	lockdep_assert_held(&src_dsq->lock);
@@ -2504,6 +2588,15 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 
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
@@ -2659,6 +2752,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
@@ -2668,9 +2766,14 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
@@ -4382,35 +4485,41 @@ static void process_deferred_reenq_users(struct rq *rq)
 }
 
 /*
- * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
- * scheduler chooses placement again.
- *
- * A task can be re-rejected repeatedly, and there's no repeat limit here. The
- * private list below prevents a task from being revisited in the same round.
+ * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
+ * owning BPF schedulers choose placement again. Proxy-active tasks remain
+ * parked until proxy resolution schedules another drain after switch-out.
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
 
@@ -4421,6 +4530,11 @@ static void scx_reenq_reject(struct rq *rq)
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
index 00a7f864ac23d..fdcd723c29a3c 100644
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

