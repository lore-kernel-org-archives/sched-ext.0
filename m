Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0240BCAD
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959723; cv=fail; b=Hc2Qzvxh+6KCHh4hUQ3G8P4uBpHvwQegXqK5IdLv5ZnsQuWvFdnUmaFyndNql/V6C6eZf91zKJRia76DueS1Ia0QA8VuCEcQLyUHUYeCTK6hRKsBAWUZGRX0a9AnP/l6TtfkNdXh0WgI4deG2a+/EV9prXdjAonbR0Ov469s5GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959723; c=relaxed/simple;
	bh=Uv7ieuQF2qdoclLWO+9R3TlmRRpRzX5miLQb9aCLEWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmM4eKH8h5+2PDsqzROCZesiv9fFFb6XyC1/zpudoCqr7L5im2D91XL0trOkrZtLauyfazhEBRttDa37WBPz2cfHplTnLKnrDmWFGxlib5K4ZPmRJPr7W1dlwlfl3cYEMeB8Eich0CM/SUqKhLuQ4N5Zmhzeshc0sgtMkYlD1k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hbuMLjL2; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbuMLjL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACJNoyN0nH0QzIZYljfsXkDPZOqLZziSGemE5H8GZLKYBgqTbf7QBJpqfALynDIVmG4IUihG0ybMGY6milo9p2TighnbEGgCZ3c8SZxzalmru+p3nNAew/qHKaKPaLxu5hawr7GiAxx2PGxzJzjqoLqw6xuUtGSeZ2pQSlN5F80/ey7rdAAXBEGET4b9JFzamSEE37OaRiDb0igK5RTQS3fGXCOJeDTOZ59oXHg007Hp1qDdYlR16GtDIZ1zpOFsHO2hjUD9EC3iv7LEtb+ONVzwXr5xyF5KXTOkxHGHCtFq+eOle6WNxUn83D9B4+BbB/BA5rYVcU5CgYTuBb0rbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzN/anAzZoMYsr+q4bPT7KWP/lvDMuJaHJIeSiAs/Tc=;
 b=gbZ9oKgQzs4t8bxbog3yCXLfnyjTJr7KbFFGgju/LGLmEaxA3ANnANdhkO8Tho/Nk0mL+6fkuNehD0kB9qmdJ0sDfEakVClVQdvhYUL8VV2cxe8TrNQQDcG+/WlQC9tFVpGLnEq6Ax1lC9AWwwODGloFptaJy92xHENJglS0agmWH7JPkgn+rCc3UTc/qv4ywWiDNErAyTvSv0paLtVYbI1T5sSJMbKytOpvlHWHxNOMyH45IT8EhveVdWjx/r880p/5NdN6ceVrtWPsNzAcR8Lade5I94LZCZqqTW6rKjvKiw3632lGQywwHaCcRtzniOtkpWcAzS9+KS3aCy19KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzN/anAzZoMYsr+q4bPT7KWP/lvDMuJaHJIeSiAs/Tc=;
 b=hbuMLjL2plaRGLJKC30epjFI+s5RmlbJC8pnAiicQQSsZGxFryAtkwI7b7CgnCu62yzTINJzNXLex3HSHdksvcs7dKWITclxw5nxAurm9RyQa2mT+n7JqXWTFl46o5nik+N+oyZTti3VlLkGWepDKRmn+ugr6QKNZ64jtMHtu8EKr9LrRQulMHFiGbsYHoGB8Hwu1aiCk3WhQQ+9N5QEO1QoKpD61gkGwiFGl5NG4jvH+0FYzHGoV7x76I8AnqZzIYca1ZSrOjzbvYcWKylNViLMmZaNcvrn2E/G2UFtCChvmFnC/yyUU+5dFNJ9FgADNTRqAnaCHaDANT/QMD/TOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:55 +0000
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
Subject: [PATCH 05/10] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Mon, 13 Jul 2026 18:17:05 +0200
Message-ID: <20260713162112.26785-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cd8dfe-d572-4bb6-decd-08dee0fadb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	RMyktWx5/yj40yRMhZ1OoEWmHJJ8E23YnJ+n84CfLs4LkPJHyQLHKAyVBvsk9CD7cmLaxm7HRqXsCggiA3txhCppiP3oz0OHG2M5fNd7TK1co8akuhkpMwh+LPC7KFMMGpUihSZ/6xB5ow0fWYX/XZb0BqHZR2QkWhRYqkzi8CHRhcuVAhNAfxHbPTyNV49ZpRnYPxp/WaMswmWNM79QUEIHU+bJNzDdLeQJDR6stOhWx/fjLOuZN7zgu3aGuUjWtKxtcFuU5sUQA5gUoAMlLKHs1zMWClb7AoUXca7cxondRqJqS0VjLj6/mjdVkGQG+zzHzEsc/UU5MMKX1Qyu+aWlMmCyhXzNZ/oslOaiu0AeV4RjN/4T71DGELqvM0jY7P6Ylz8ajFSKPvX9IaAvyS0PsNdqjScULUe9gPgSgdWl1ZpNqZgRQA72F8LbtFSIAPJ/gbmMXIznqObfydM5upicQcCN/yJ5FSfQZZawowKwMAypOVneR7aqJUWzaqbVg8Mtv3fDhfqorQfvs5CKmcWNW17W3T8ZQIaDNgM9KD7EJaPJjS3vHAtZW7dH2roJviVgB+ubmmAQnPspsebYt3gpJrnJuX1M4JuiAg7y2LRVdi7i+QQXcd9o6D1mjOpFG9O9p+YOPojz1mJ9ufcqwloeDJtPUZO8pxccrKhvJPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2iMF//Mr3fSeGwlrDJvCMHF2Bl0dXstLh9YGzHfh6ww9bXrCcuqVAS2Wt4z?=
 =?us-ascii?Q?89ocpPCcXNr3wXz6w9JIyjnGz/ilHOirQW+6hOfcnpAuwP755S5UTk6BHUHh?=
 =?us-ascii?Q?ME6ULe1VDYxTaVPKT6AwBxNj+VdIkZPCE7zO54ewlwiEdUq3PQ7UMrLv0JNa?=
 =?us-ascii?Q?AljQm7K1Yd6hCIrGlrRdQ7IbYIlBxhnA08nH83+ViC5bDQ03J2hMq6fVJVag?=
 =?us-ascii?Q?5J5FCx4R7l7nKHwL6MVho7cu9Rg07UON1G3V9i7+yqaUhhqwLR6dFIdpPKt2?=
 =?us-ascii?Q?yU3pdYv2sGcupYB6+yu9zfCy5yD1TfD3v2qZZ4ixtQGwyPDVTDS/bLP4OcNA?=
 =?us-ascii?Q?gTvITvt2yeNSn/MG/e3UV+N4zZDvuH3mEKmnY2L1iO8ImVgwgIYetDRdQN+1?=
 =?us-ascii?Q?Kk4Ygo5z1SSa79l9E+RB5seDYqtEx3TvgnnD+Ohln+YnawT0uRBsroyIuo1Y?=
 =?us-ascii?Q?XNQE0B0zhhMkGxRk02AjNXUUMZb0UV8e3IU5uXK+nPVzsgX1rqBPf5vECvx3?=
 =?us-ascii?Q?6LAerhDDbgc0I+TiapHXM6iklCmD2pGhQsDaOUij6IXxv8/bGWOT2h7sDeKU?=
 =?us-ascii?Q?EsKU9yfPt6Ul0To6mmY91ademDI/feMXA5607wHrvWe10PYRGny9JIioiJpT?=
 =?us-ascii?Q?ceCdIvLsoXDTd84w/OwGFkn735kgU4i24u/CCdH+yRdOQ3oKm9B8JbdAW4W8?=
 =?us-ascii?Q?0ePoYzf/iQ0aKpooM2LIOA0EVCzbXDoaUAbaq8vScwFdNUoTG9p+EcKBsKxl?=
 =?us-ascii?Q?VPHPYPqOdF11rRVlwVL3IFJ2aDvfmGOMuSK8dZHAJRajN0Sa3d00GmwDPl8b?=
 =?us-ascii?Q?ye+PYloD0URdBxnlu4mikBK/AfOojc5wrKyimSAUarb5hYx8BMxQbH1gBVem?=
 =?us-ascii?Q?3aXDiY5L4kgJAy+pHec9+VXWsY8P03lrB8GZ0+x9lYu7hPRl1L2xe/jk7xn4?=
 =?us-ascii?Q?i4c0K/PWcFIIbhKK4jt/Hb7cy9JwQwz4v00NEh9wnjwlBEKwvSaGwAzsH+lo?=
 =?us-ascii?Q?z17Z1inoFP85xmCx+HWYQV/ZiXa0YTZUKJHPLcLVc/uqNWDmsXfKGINsJY+v?=
 =?us-ascii?Q?a2AhXHEWfTkgyOEZTA4klO/cuDpNZhDQZF6yjf2geooqvxUROPS9gutkJljv?=
 =?us-ascii?Q?fX4X6SJYkD24dJyAdzGaIrWxynqQLTmlr4PxubY/ow4iy8bR/f8IfGr3N00O?=
 =?us-ascii?Q?3BZ4SOM8tusa4zrWJAZNBFb0/ImNq0J6IleilqI9h4gxbIYQ8nTWrBhCrvpn?=
 =?us-ascii?Q?i3/OYCfZk0z72JO7kdnp36l1qMOTRVdzPnq8O93areCxhoNQyoJtj3KhydQm?=
 =?us-ascii?Q?1eMYhi0a8Gs6m6KCKp4nlbC4V/iM2KEb+hS4y0lHAnvZUECoyD5xUmqxUIT5?=
 =?us-ascii?Q?7FIqbH+fIrehTPH7CfbtIQCISSF96A61wRpdplfB6g1qQmxA6wrUXaeRMs89?=
 =?us-ascii?Q?Lu4paair8bRRLWD4CFLlW6lDlgmtxEn+2P6VyqJatptB/VPXTy2qmiZuBvED?=
 =?us-ascii?Q?0mt4odU6nf9MX8aCWsDXke8ZvTGpNnIqXUTR1SOL1wati3aCkd1yT3nTwna9?=
 =?us-ascii?Q?LBo2hVeFgUo1Dkq6DQVbhBtkHVsmbu7lBrHorv/iS9gibhIqFgwH6SWjsoBu?=
 =?us-ascii?Q?l/9r7BsekNjzENhPAYI1ELGLuYPbu+TQJlHI/9F+bIFabNfR1cDPjGzMDKpV?=
 =?us-ascii?Q?JlmrrpB2CUfMqGv0TIFRUHXPYufr8GEsQr3YigxdmIbIMYurRKh08xWXYfjQ?=
 =?us-ascii?Q?4OGHHTEZPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cd8dfe-d572-4bb6-decd-08dee0fadb2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:55.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnjUJERx4z2yHGingwpky04TiWQB60CypX4bphRjJUGhbHt9ILWaTVfq/sXUfJCsqVucoWTbUWHBR541/+KV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

When pulling a task from a non-local DSQ, scx_consume_dispatch_q()
checks whether the task can run on the destination rq via
task_can_run_on_remote_rq(). However, it then drops the destination rq
lock and switches to the source rq lock in consume_remote_task(). During
this window, the task might become migration disabled, making it invalid
to migrate to the destination rq.

With proxy execution enabled, a mutex-intensive workload such as
stress-ng --pipeherd 0 can trigger this race when a donor becomes active
on its source rq during the unlocked window. Migrating the active
execution context can make it resume with IRQ and preemption state from
the wrong scheduling path, triggering sleeping-while-atomic warnings and
subsequent lockdep corruption.

Re-evaluate task_can_run_on_remote_rq() after locking the source rq. Use
a non-enforcing check because eligibility may have changed during the
lock handoff independently of BPF policy; reporting that transient race
through scx_error() would unnecessarily abort the scheduler. If the task
can no longer migrate, clear its DSQ association, reset the holding CPU,
and enqueue it to the global DSQ instead. Normal consumption filtering
then skips it on ineligible CPUs while allowing an eligible CPU to pick
it without forcing it onto the source local DSQ.

Also reject tasks which are currently executing. Although an on-CPU task
should normally not be available for remote DSQ consumption, checking it
explicitly prevents a stale or racy candidate from reaching
deactivate_task() and set_task_cpu().

Closing the race and preserving rq tracking across the lock handoff are
prerequisites for correctly supporting proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 26bd247f4f29c..fd530b55c68f5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2166,8 +2166,10 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
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
@@ -2185,6 +2187,10 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Don't migrate a task which is running on a CPU. */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2278,11 +2284,32 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq,
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Eligibility may have changed while switching rq locks. This is a
+		 * kernel-side race, not an invalid BPF placement request, so don't
+		 * abort the scheduler on failure. Fall back to the global DSQ, where
+		 * normal consumption filters can select an eligible CPU without
+		 * forcing the task onto the source local DSQ.
+		 */
+		if (unlikely(!task_can_run_on_remote_rq(sch, p, this_rq, false))) {
+			p->scx.dsq = NULL;
+			p->scx.holding_cpu = -1;
+			scx_dispatch_enqueue(sch, src_rq,
+					     find_global_dsq(sch, task_cpu(p)), p,
+					     enq_flags | SCX_ENQ_CLEAR_OPSS |
+					     SCX_ENQ_GDSQ_FALLBACK);
+			if (sched_class_above(p->sched_class,
+					      src_rq->donor->sched_class))
+				resched_curr(src_rq);
+			switch_rq_lock(src_rq, this_rq);
+			return false;
+		}
+
 		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
@@ -2398,7 +2425,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.55.0

