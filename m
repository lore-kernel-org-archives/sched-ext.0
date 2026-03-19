Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4023A9D92
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909330; cv=fail; b=brnFLlVP3Lee+3jIwDOSLaV7iWmrtWoZ6Y0QlzCxvSvBVrRAxv3OVpDJ2dYj5ONBmpuwR35nWOmta0zObrK9V8ovAUNx0bambYwSl1CyjToQ+EYTGInfPKPKsxk9yXTySA1q4AcxVKd6NhoVACjuHAilvxxuRmFXgtQJeakZB8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909330; c=relaxed/simple;
	bh=2XIaOaEckCGymHezRZJr2D7hEvG6GgPiZgCdT690PQE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sgU8tSBZ2gOyDO2ivWG/QGKasv9Hp3WU5dYSnOzsrzLRyDyAKDeULqeTSiNRmzUejQuu7GgfJWyuAX/fMLKmEDyX2I+8tHe6rrX8da+0lm0HM9o2gc/77p2Czq/Zmx7Vn73oqsZbQ+c2YwR9jPmF6ukxuPE6cVk8xtUo8F0rYCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mseUZXch; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mseUZXch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpwfERK5XYe3K0y9yn9xK+yXEww44KOuhlkvlb6Jgktmzmww8Ztge+4JdjYI+oB8EBzWt76Ruorz+DsIlXwynp1mlRfDTYw41FZqZO6TUab1iTgwYJ120RIteDLvzutBS/oPLPWAVDsvUx9oYbDdRaUt2EqIDjP8+SgqowE2a5pQ0bD7xX4u2D5uzrSeBrKuu5hTsBK4F5C5h8MGxGWzZdamxNFIUfq6sECU7IRqtxnbXUsteruuQ3Ay7Sg1pBupwqzxY/uMKuVtyDxwzUvubV9G1Niek4IY/vU1cRH1DeVHeofIF4wZh19hkhjxwJUFuavLLSIWhwjkEzaga8zUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKeQ/bqb+ov6jW5HTIsprFYDQ/WhsdKH/LkGoR/M0nI=;
 b=tJZ9JNnzSIhJ9gXrG6+ATebKGB6XdZ9PM/rvygyVALEM3tUGKOaLvTAgflgt5eIsrlkRkyg2uCkU7G93cKO0FMk6olsm3zYtHBJbF0gHYcgchwrapJT4rFqV9Yh131tugA15nr5GTp/pzTei+prNRLjZvirFX+F/2JaC2FZvFdtn1PiS+RgeRjj97S9DynTqC6LHf3QSSLTdWupGTRV2ZJQdMvdlNNqKSuWLlxXy3M0IFsC2SgBAucF2WBFNQBulCOKC78Gh0D36RELOcAJlKtumGsjWApjzxevuSVQmz0DpEJkiRX6PuEo5M5/RbKJtkx1iJWqGQTI2+Yyxzo4oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKeQ/bqb+ov6jW5HTIsprFYDQ/WhsdKH/LkGoR/M0nI=;
 b=mseUZXchRjVVYlsUV9XaQgGsSbiuzn0V4EHWXeQMY7nw1c5I2M1OB90wOC14O5ZIbpOLYHE5/DYTKB3YcbjAwh9D7C8AJLVt+K14ncpS3/nfIAq2rlmHUfNMYhISGYm11Tvkb2d30oHs1JMdfXoVVjORfaQhgmAQZ4C3ZtikSw9G7kNGlsjLEHU/nowdgdBKFJoZtSGOe7ASUIlL/SKagfAooWPNYU8ktNoG46yUOwRrYazBLvtNFxt8swM2NynGDm4av27S7798iumhhqzDuXVmJmikxtnCguLBUxkzOiT+ig6qAcHchdsBx38bUuSEfjNLwxSzCBhq4qcUSrxoJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:35:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Thu, 19 Mar 2026
 08:35:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch decisions on CPU affinity changes
Date: Thu, 19 Mar 2026 09:35:18 +0100
Message-ID: <20260319083518.94673-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: c299b210-69c8-4c07-025e-08de85927797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cEqjwZaXJOM3M/rvdYSu08cQ/7lzq2ezMJuCcl8Jhtll8TbSEjLDzD/oYPL0NZgjfEPA1sfj06fjPVFLc43I3xkYrN6XxjjFJXWiNKuvn3f9iD94BmDPB08d/aTSsoct0hxbcW2tmGkXtAEU9d7GME4/r4R+ANSrq10mpet0Bu2ac8a2HGFc5We+suX/W6l4+JhYFIFIzW/oN6YruqgfJL746TG90GSPUrsJyHiU3E9FwHHrn3/ySAX5Dqh6+PI8HQpf2tioPppD/5ioKre667EYbSDtzuZs+2lQ0qjIeOTru6wbb0ErVRKN/PfnqWa5/y9PQjjLuH3GEI6psSwu2LVIZNECNXQfrZE9TGEBeYVM7/7sD9PZi/n/hklWRl4DQV2kYYdSPJ/aePBzbRh5pFR50N51RqrEqEFE4uopSaW4XUDQd5oSciek/cKTF+tAu9vkR58h4UWb0iSbWDxym83C6wbHznKwlerz69rlF7kYHNqOjrsULTxcUp+YA3N/KFmWDaM0rrEPbWW3eE2rrRsLzmykVL52N0Z4RM0tUjjD+mLAL4PB+ex9MEJN87q9FV8X8yb22NtXGT+W179dilvyS0aRpMZzaw7lOSyb/EzlVHFOKngShsqL5TOUjAU18tdPsoqogk4AOncAoW1QhXIO6FnwdKL682HQG83dQra4qY00vSd+n7LyMImBaFjIhIVZsFzzhv+xbwK3qrOcRsWPEKKtR+NvtU0lBk/baqt11yXNS3miaOWPojNSPEP4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sVvr/rBplEZIUeWTdSCqRFqsyg9kQ+GHJlJIsBQSDFD5ZvwLLVPDcCpU5zc?=
 =?us-ascii?Q?GIe0spFCFIMoeS5lhCDG0RzlZv73NnP9CIcFQg3YIC265JTG0cEu0W2uIg57?=
 =?us-ascii?Q?wLj63q+7AbVMfjFcfY7T/jULx9fhoFtI7FkKZJKaIDM9SWAuu5l2stL+yKql?=
 =?us-ascii?Q?Wj4HvImNkaTn6FhpGIKRfzpEQU4Jhuktz5cnAA3qCvXcklM1zM3tG4zOkoAN?=
 =?us-ascii?Q?CgQQnLg4NS7lX8725w01UuhV9Cx+MOKoQtCrgBEZNCz7gaGBfsxbnSEq+20F?=
 =?us-ascii?Q?V+eukd4v9/EQTmvlHEKVFnv2elQ5mww9PYIlwdsIypUhdq5Js4xlNWTRHajj?=
 =?us-ascii?Q?kXKo/dYq1HPQk7IYwQj/cPE5Opnrh5QD14NYqxgUlUXVdpnPjV7h7Kc9ORPi?=
 =?us-ascii?Q?kTEQ3vHQ+2L0u6usSkrIy4UY9eXqnmgK2/17j09NHDIjSLTbxrdyhCQZAsNb?=
 =?us-ascii?Q?u2iPIsE7aErkhVdneg0JJOIDRyiulrocnt89D0LHFtrybLW3lmvAkBieVxy5?=
 =?us-ascii?Q?DrFVz25qNUeDH1snrn1sdLhLgVcGcs1D7CpDFLxZsMiZNPe0AIF5+m1G+RiB?=
 =?us-ascii?Q?dZgDejRnX7pF7j2Zw7JZ1Eut3kOtAcvLXfw3wNQ6gsHvlOW87ChMfmH/zsOj?=
 =?us-ascii?Q?n6Hu5tgMmHX+C4tiBz9EuJZgR6A6EW0MHVbxLIMFO+9heDoTFBiEGoVj+Z8g?=
 =?us-ascii?Q?rfMWf3qRXfSoaCjtz7xlIynY4qrfOb0WMrbAY0tDBj0KSErlE/j6AbyNr0gk?=
 =?us-ascii?Q?8HPke9xH/QfMo0f08k5y/ZIKOY3MbZUwNrYO+MIr8cttz/OXoiU2Uz7MYv0Z?=
 =?us-ascii?Q?4dPNGvDzeYwRgeRtVh25oulQge0oILg5nFMJIrB3g6dgh/MZF6+L1Yhpyoxk?=
 =?us-ascii?Q?aeH4Be4HzhHoMpRdnlHHYbbz7Ew5FM86V48WOzPuo8gREcXcQ8jls5vPiXiZ?=
 =?us-ascii?Q?iwbhefbADpmknm10vhZ2yWNbNYPe5QS3dEVWA1Zah8a59y2IMsuojiKUUMk6?=
 =?us-ascii?Q?4xH7HrGVYa7x4bofwYaoGpKz6LoldjOpSEaePD6PR1BRyoXo9BkXk7cXrUHg?=
 =?us-ascii?Q?B3Z7KU0ra8Ml208aAGWRXCsZQ04dbXaSjZltHjg0ztwY9VKVcBs5NrP9w3v4?=
 =?us-ascii?Q?x7SdlGmiALlUIaTu/b7BBjZZjXS+AmGeHkYsDa2MlHys17WIGyIBsuL0SURC?=
 =?us-ascii?Q?gYgdvaL46RChLBrYSNwEWxfnTQGb5PpXHatxGU4/3E66V3gFOwPfsFJ9evEs?=
 =?us-ascii?Q?Nxxzazn/nm39Q0nkWKRbJBEMhKAjZ3RiZNtp3aAgjK0Qhf1CHirsu/oK+Z3o?=
 =?us-ascii?Q?t+gtLahsKxN5OAypToDlVFlWIpu6Rq8GmSBuETr5vWhQzZdUxPXCkiRC2nt6?=
 =?us-ascii?Q?y1mwNUWMHbjVx1Zh55VnOHX9x7CB09fO3nbp3/2Qk5deLoP5WxNRoepzfqlg?=
 =?us-ascii?Q?gzhTFDxyuyxs2IcSxamTxvJxUlqEXMhv1QclrzCaDn5DaLT+RRPTDr+C6bED?=
 =?us-ascii?Q?aqNHkUtPYFDTufHTnYvk2pK5qosp7bY7TlJe3yVxPioL+6vN3fbq7VAogtuf?=
 =?us-ascii?Q?2pz9uGhsdcecPzycYq5LELy2ANjl5ykLh4XzzS2kI+Kt7HDy2OoxhMQIsXHC?=
 =?us-ascii?Q?9aUMxJ1pClFhYlOoRD0pna31DVjXBMb2k5xgO9SlR8oc2B5vZesIOQR/Z0G8?=
 =?us-ascii?Q?Yz4+6oV4YSNKN0gUAOPJth6AVfCS69Zb4CEUm8ghi7cmmy0n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c299b210-69c8-4c07-025e-08de85927797
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:35:25.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cG0+wzVUSoBFIjqt3P2ZP9nFWFsgq1qU/tM1QnQQDPLhIOF7RMkbFVLwzdWBV2umh7rBPnglX4QeiUmQ0rPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
target CPU. However, task affinity can change between the dispatch
decision and its finalization in finish_dispatch(). When this happens,
the scheduler may attempt to dispatch a task to a CPU that is no longer
allowed, resulting in fatal errors such as:

 EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])

This race exists because ops.dispatch() runs without holding the task's
run queue lock, allowing a concurrent set_cpus_allowed() to update
p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
then finalized using stale affinity information.

Example timeline:

  CPU0                                      CPU1
  ----                                      ----
                                            task_rq_lock(p)
  if (cpumask_test_cpu(cpu, p->cpus_ptr))
                                            set_cpus_allowed_scx(p, new_mask)
                                            task_rq_unlock(p)
      scx_bpf_dsq_insert(p,
              SCX_DSQ_LOCAL_ON | cpu, 0)

With commit ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), BPF
schedulers can avoid the affinity race by tracking task state and
handling %SCX_DEQ_SCHED_CHANGE in ops.dequeue(): when a task is dequeued
due to a property change, the scheduler can update the task state and
skip the direct dispatch from ops.dispatch() for non-queued tasks.

However, schedulers that do not implement task state tracking and
dispatch directly to a local DSQ directly from ops.dispatch() may
trigger the scx_error() condition when the kernel validates the
destination in dispatch_to_local_dsq().

Improve this by shooting down in-flight dispatches from the dequeue path
in the sched_ext core, instead of using the global DSQ as a fallback.
When a QUEUED task is dequeued, increment the runqueue's ops_qseq before
transitioning the task's ops_state to NONE. A finish_dispatch() that
runs after the transition sees NONE and drops the dispatch, one that
runs later, after the task has been re-enqueued (with the new qseq),
sees a qseq mismatch and also drops. Either way the stale dispatch is
discarded and the task is already, or will be, handled by the scheduler
again.

Since this change removes the global DSQ fallback, also drop
%SCX_ENQ_GDSQ_FALLBACK, which is now unused.

This allows reducing boilerplate in BPF schedulers for task state
tracking and simplifies their implementation.

Cc: Christian Loehle <christian.loehle@arm.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Rework the patch based on the new ops.dequeue() semantic
 - Drop SCX_ENQ_GDSQ_FALLBACK
 - Link to v1: https://lore.kernel.org/all/20260203230639.1259869-1-arighi@nvidia.com

 kernel/sched/ext.c          | 55 +++++++++++++++++++++++++++++--------
 kernel/sched/ext_internal.h |  1 -
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94548ee9ad858..8c199c548b27e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1382,10 +1382,8 @@ static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 en
 	 * e.g. SAVE/RESTORE cycles and slice extensions.
 	 */
 	if (enq_flags & SCX_ENQ_IMMED) {
-		if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
-			WARN_ON_ONCE(!(enq_flags & SCX_ENQ_GDSQ_FALLBACK));
+		if (unlikely(dsq->id != SCX_DSQ_LOCAL))
 			return;
-		}
 		p->scx.flags |= SCX_TASK_IMMED;
 	}
 
@@ -2043,6 +2041,13 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
+		/*
+		 * Invalidate any in-flight dispatches for this task. The
+		 * task is leaving the runqueue, so any dispatch decision
+		 * made while it was queued is stale.
+		 */
+		rq->scx.ops_qseq++;
+
 		/* A queued task must always be in BPF scheduler's custody */
 		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
@@ -2390,8 +2395,10 @@ static bool consume_remote_task(struct rq *this_rq,
  * will change. As @p's task_rq is locked, this function doesn't need to use the
  * holding_cpu mechanism.
  *
- * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
- * return value, is locked.
+ * On success, @src_dsq is unlocked and only @p's new task_rq, which is the
+ * return value, is locked. On failure (affinity change invalidated the
+ * move), returns NULL with @src_dsq still locked and task remaining in
+ * @src_dsq.
  */
 static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 					 struct task_struct *p, u64 enq_flags,
@@ -2408,9 +2415,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(sch, task_cpu(p));
-			dst_rq = src_rq;
-			enq_flags |= SCX_ENQ_GDSQ_FALLBACK;
+			/*
+			 * Affinity changed after dispatch: abort the move,
+			 * task stays on src_dsq.
+			 */
+			return NULL;
 		}
 	} else {
 		/* no need to migrate if destination is a non-local DSQ */
@@ -2537,9 +2546,26 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	}
 
 	if (src_rq != dst_rq &&
-	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
+	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
+		/*
+		 * Affinity changed after dispatch decision and the task
+		 * can't run anymore on the destination rq.
+		 *
+		 * Drop the dispatch, the task will be re-enqueued. Set the
+		 * task back to QUEUED so dequeue (if waiting) can proceed
+		 * using current qseq from the task's rq.
+		 */
+		if (src_rq != rq) {
+			raw_spin_rq_unlock(rq);
+			raw_spin_rq_lock(src_rq);
+		}
+		atomic_long_set_release(&p->scx.ops_state,
+			       SCX_OPSS_QUEUED |
+			       (src_rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
+		if (src_rq != rq) {
+			raw_spin_rq_unlock(src_rq);
+			raw_spin_rq_lock(rq);
+		}
 		return;
 	}
 
@@ -8112,7 +8138,12 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
-	dispatched = true;
+	if (locked_rq) {
+		dispatched = true;
+	} else {
+		raw_spin_unlock(&src_dsq->lock);
+		locked_rq = src_rq;
+	}
 out:
 	if (in_balance) {
 		if (this_rq != locked_rq) {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f36d8b9c1dd..49cef302b26bd 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1145,7 +1145,6 @@ enum scx_enq_flags {
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
 	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 	SCX_ENQ_NESTED		= 1LLU << 58,
-	SCX_ENQ_GDSQ_FALLBACK	= 1LLU << 59,	/* fell back to global DSQ */
 };
 
 enum scx_deq_flags {
-- 
2.53.0

