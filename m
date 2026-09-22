Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E742576ED6
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096155; cv=fail; b=La7ooSlpNvXnKivmWy8bpSmgYbN0Qf6p5q1qwqD+xkKLNvUclEcqMbKf8GIkbNzb9RZngLjp2PvtOtoxqlZw2n1S4vBIWwqZj17Slay/msxYKh0tHpcloo0bQb+q0qeCAqfggzvIJGPgUjDzA4u2T/Iw1/hD/4wcoRvKm/8LWEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096155; c=relaxed/simple;
	bh=CqP9DLhyriKXQh45MIAooYjWNA55PkShr9mlQq86Xjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0aax8sd27lFQRwfHnaTDtWjq9fEKtuEN2GLlZsIbyaU9GoyhfDgDQj04HskwpK3DgSefsWz1q0dEJh7m7hmxnp9ggOHssKFZ2T/b7xVyuyLVh8i9eAf1wphZplwo8povZUwdPCX2fd1ZDL9jeaKmyrp8VnnlrS8RLEJDftFFKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDqITXHC; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDqITXHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c172iILlZJ4RTbcbi6STPOBd+0YxMdCpnfPjw9pCDE7/yZlgZVaffdLts7liwQpJoTiOeJz8KXVilioG/4sGQNL/rJcIjMx5DmcexeNT+Jp319hs3PzaGqcdq/3T26vl9KYKp4C0OUYQyUSCd9lLK1tlA2k1cLWIP3YSqnFJ3lQwiukbc0DV7uolWB61PIfdDCp7HiuvpPH3jeMEpa/VQYENip3RIjqvGmSHYa71Up6mLuMANk90OpS12hpMsuFa73lEo8g/+96Rbb3GIENW/8sgnnRIwGKTMcQk9YKdJOJB74MAkpZ63XjMvlJP9hv5Oz/Sjgb8zYkIqB8xRxdYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIsAyzFnxIBJxLTZryLEWg49d8JF4flg8ehNHKCkiqM=;
 b=HN4fPgkP+O2Syq23sucSRAFagGCGGfD2gwk0iu/98cCJKmQni4v1806aHlvJVAKoZP4vx3eI5aKMAJrGCA5d+JVKCcUbL1LkOTTF4bfvIiapS50P9gLldwzhe98GRmlKMiylRIgqguZcPKLVQZIJh2k8TryUuLp9gwdFqCaGbRLZyCO4JDk8PWYMqoXYA7ywZKr4ytttgttsxtBxvOMH6fCZvmejHMh7FnIfXGJ7O9qSXBG4m8m7kl3XgeuhvoI31BZMFnZHbJ3DTvd0zsevG/cDx0JqcSuzE615ieg7wRBod/eQ6YMg45tDQbIB+qOm339mV+igcJu8saUSJHsR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIsAyzFnxIBJxLTZryLEWg49d8JF4flg8ehNHKCkiqM=;
 b=rDqITXHC9yNy8AcEftk0oKQRHWqTQUgxLzyR55xmiSqp7K+s7YcnS2PNxy4dY9xaKaUDieIwqI5De7onoCncp2EakL4kAOl/mCNE2ijz0aLck1UlHkjCOzFTDoIrAuc1XaTez+t+vo/rWccLb8ulURFiuBudKRw5/Ywfzerzib5iwZOm+q453Km4K7K0t+VA0WQWIzKxT9AJzJqTxs5wwQpQBmoapRSDV4SDiBekl+h62p6tlejIOIMNUOHvz2KKPf1jJokvh5WmLqWQs+cJS8Uieq+4mY8AGKf1wGQZrnTdh9H48qnzFEIWdBBk0Ub1d+nRFnzoTa1er89pw8R8nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 22 Sep
 2026 16:55:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:45 +0000
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
Subject: [PATCH 13/16] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Tue, 22 Sep 2026 18:51:52 +0200
Message-ID: <20260922165445.943315-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0086.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::31) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5dadb7-89ee-4f55-e150-08df18ca582f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	yoOy3vtu0TyYledbSJG3Bw/pVRfEfPcauU3zqOUam5tN3chciRhu7XuqgpZ898K/vS9xqC1G5aVGL+DeC0znpmRHkSr0If+rTHWvoH6Zn3Z4SHntKVwY/G/ChF4MolMt5EqXE4PxQLjDMObTaTkSTsouW5icu/pLRuo7BEueW//ZstB/SmrotSnCczjaszRfBFixp13uFGvjjHxjcEqca5E3Ion3ucLbvOHKF36xKDWyVPFlT+8rblmiaxZeG6GNJBDDOJLH70T+MSqfIqGVrd7R/KiCNf/59s/SpoE3uAX77wpToT1PEIlbne2ktTqExQnR1usVoQTPNkO03GdMkIOgOvNxuPjSwh0xzG8yGez77dTTW5fJ6g8xCqWHsdbwHTuNJpSUGeIIFn7M69IsLYeeHKfDjobTKC9PHndqcXtsqPcntDJlnQMFXEjd2zQCI16XGRYzLynR0EjiiCcZLK6X/+N08IRa3LzdMiSEHlrHykqWucKrVAI93vlFmgOY3cSX0iHVef3Xys08w73dUyoAOOuvlkl6cweC8gu/DqwuPY83u270vEhYu6iI7yuzjX/NkcHt5UqAFlJNUW0e/R2Saw/fPruqEqPER1l9mIZtKH1oKak3umEB6knoACWhC3Jm0u87rizDOJ99pcEVKHRjmMlsUzzKhTkOFbIYMQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRxCCHlqfvcxsC4KTWUYnAmoAXjuDnIylw7OiadIBrj4QGE+7dmoh+j6GsVg?=
 =?us-ascii?Q?udJFuCRarDshCeD31FTUoQBkm9iVRhYvXAxujMHhSiMyAeDMSiEPu02CgP9a?=
 =?us-ascii?Q?9k40zvvvm2PrcHgJBK+6yNV8qTmZOGjrf6M1WLZfWASsPqr/3zAxMWKyDByd?=
 =?us-ascii?Q?AmBej9k/3VYrr9I8/Eejy2JDTHICSzkxZv0vER3SxJXcm41DGKYRMjeO/ZaD?=
 =?us-ascii?Q?ALLXVJUvmo53dWh/84j5b9OUsv6sYhVPUaM47U4gZdths8nM/PHvJNKwBu/u?=
 =?us-ascii?Q?2L1Q1ZePlIJkUz8Ft2ZLcKwkzfPe+krpw1wCd50thKWDshTKgmIZT7BA3LIF?=
 =?us-ascii?Q?cQyZBdMc3kZFu/R6mIMWrnddv3ArdIvKBZVZluhI/D4xD2+nU1eSGpyvDn36?=
 =?us-ascii?Q?HQT3MgVAFh1x5xj+mH8XmOxnuVbayvSXwB2VB4REBEos5MJHCARJcnAG4xbR?=
 =?us-ascii?Q?8WjXQsIUnGkRLjq5eCZTnDebo0vpCeCcqdEPDP3q3+ERs9BCtnP/ROpxdfcr?=
 =?us-ascii?Q?Vr+cCMl9Ss/DnOIRIxuariNL/w8QA9qPoytivvR5FmFke+nHu5aG4xHIrj+K?=
 =?us-ascii?Q?kvZxt/M+yV2z7mFeJmB8IDopwbE+b5oWjZyB2vaG4wyAq4gdNDAGrzSz2FnE?=
 =?us-ascii?Q?GerefKrbT150HQDK31ZVzJaPUUNTuaCi1/Ch9lP+GToPgGVnb76BosLAot+K?=
 =?us-ascii?Q?1HE5rSShRLAHsElip3xiHMkCx1jwIoiNCOQBssLtWwx4M2sDyBPHOBEdvcsR?=
 =?us-ascii?Q?1jucO/Xe39C927RUYTUQGS9PzyCm3XozlPTQ5mT5rfEsGQLgW4o7K+tpxbqK?=
 =?us-ascii?Q?vA3+jPfYc5zGiXNXXTKYuSCRDePgWM9rN/org9+98xvk4Wa86bNUOsyOiaAO?=
 =?us-ascii?Q?/t3OQk0v8YQRmPs6YusXmtEllHNTivUnnuxAJfJHFSHZ0DeEblpeF2C5KWwp?=
 =?us-ascii?Q?PpuBYOXt0rlISeGwMY3gV45dVkuEYOxQYoeWjDDGiI1DULrqw3hiXH/g8fLT?=
 =?us-ascii?Q?nP8P0RxbZHnbwawtIr6A2jYB2WN98jYiiK1zuGMamcxyKa7oE1sRpBTeYVv+?=
 =?us-ascii?Q?1GeJU+uc2T89BC4Dg8GmpJVpIxybqfkQSlJ5Rg35DDLQ1EXae82DR5V75yqR?=
 =?us-ascii?Q?N1sa/HQ7ILQXqSysRzAwuILLoJ+QBWoPLaxjLyrQm5vWL+ybwPVFXbOopoaQ?=
 =?us-ascii?Q?bbcUEZpUzg0vOUv0trA1VxoYXsqk/MV27ScPWdvJ2+zhnNJmwuTT+CyXP2Ok?=
 =?us-ascii?Q?57BvBObqE/j9+eceRJprKo7Yck2QarMTE3YJn+OWDx9NWY2TTY03P8oz9W5O?=
 =?us-ascii?Q?bh1Tvhcec/2xgNkCkILd77U7Ly8RCxbgjp2sc2+l2UYVQcniuOI9y6eF4l+B?=
 =?us-ascii?Q?R4QBv/V3KbNJ1TZPv/GWUxD117t+CAD4nel0UchC1QgsBgH2/RdZkweo2Jkz?=
 =?us-ascii?Q?vgb2dOhwC2N6Cu6nccHiQXLtDkVBEzvESGFrcFOligoNStIoVhYBFxllLEWm?=
 =?us-ascii?Q?DLkps62d9kuB/NYr+N2V0nFt7WabKT63JoZ6Rt9pkRrnSaGgax32x/K81111?=
 =?us-ascii?Q?abFfrk9tIKDdqa9RP4K1iYZJSBCDhyV7ZawjJq+xsSYRBLbkI3ZfAQ0zL0we?=
 =?us-ascii?Q?sNqWdUeJy9NhcZHR0ymx7GWLTmXpCnA9StGvuqi1ZnS/LmVBHHIdRmL36Sli?=
 =?us-ascii?Q?xFETKLVyhnhxGtHYDi6fg17b3msFCIGrfLhYiE847guXRrEBGve3jN1ebiqf?=
 =?us-ascii?Q?Vdjlgv2/1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5dadb7-89ee-4f55-e150-08df18ca582f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:45.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRR3Td8KFa79DNHZrSj3zgnVzS+/5QMQP0R8O5IYFodPwzfq85DJLEfQkwo+Pu4b6ITimGTduhIhKM0d3oKyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

Proxy execution keeps a mutex-blocked donor runnable so that its
scheduling context can execute the mutex owner.

Define SCX_OPS_ENQ_BLOCKED as the admission contract for retained
donors. Schedulers without the flag block EXT donors normally.
Schedulers with the flag continue to own blocked donors and receive them
through ops.enqueue() with SCX_ENQ_BLOCKED, allowing BPF to choose their
DSQ, CPU and ordering.

After BPF dispatches a donor, proxy execution may move its context to
the rq of the mutex owner. This move is distinct from BPF placement:
proxy_set_task_cpu() changes task_cpu() while preserving the donor's
pre-proxy CPU in wake_cpu as the starting point for normal wakeup
placement. A proxy-migrated donor returns through the full wakeup
activation path when the mutex is released.

Do not carry a retained proxy session across BPF scheduler ownership
changes. Before root activation, parent-to-child takeover, rehome or
punt, fully deactivate a retained donor unconditionally. The incoming
scheduler then starts with clean task state and applies its admission
policy the next time the task blocks.

A retained donor can wake through ttwu_runnable() without another
enqueue_task_scx() call. Use WF_TTWU_RQ to identify this path, where the
wakeup skipped activation and enqueueing. wakeup_preempt_scx() requests
dispatch reconsideration after is_blocked is cleared. A full wakeup
activation has already enqueued the task and does not need another
reschedule.

Blocked-donor enqueueing takes precedence over the exiting and
migration-disabled local-DSQ fallbacks, so that an opted-in scheduler
sees every eligible donor request.

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                        | 104 ++++++++++++++----
 kernel/sched/ext/ext.h                        |  10 +-
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 .../sched_ext/include/scx/enums_abi.autogen.h |   2 +-
 9 files changed, 132 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 247da76021044..14bd920196cc9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,18 +24,24 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
-bool scx_allow_proxy_exec(const struct task_struct *p)
+bool __scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
 }
 
 /*
- * End retained proxy execution before sched_ext takes ownership of @p.
+ * End retained proxy execution before changing @p's BPF scheduler ownership.
  * Called with @p's pi and rq locks held immediately before
  * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
  * is updated only once.
  */
-static void scx_prepare_task_sched_change(struct task_struct *p)
+void scx_prepare_task_sched_change(struct task_struct *p)
 {
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
@@ -2167,19 +2173,28 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
-	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
-	    unlikely(p->flags & PF_EXITING)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
-		enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
-		goto local;
-	}
+	/*
+	 * A full wakeup enqueue happens before is_blocked is cleared. Don't
+	 * report it as another blocked-donor admission.
+	 */
+	if ((sch->ops.flags & SCX_OPS_ENQ_BLOCKED) && p->is_blocked &&
+	    !(enq_flags & SCX_ENQ_WAKEUP)) {
+		enq_flags |= SCX_ENQ_BLOCKED;
+	} else {
+		/* see %SCX_OPS_ENQ_EXITING */
+		if (unlikely(p->flags & PF_EXITING) &&
+		    !(sch->ops.flags & SCX_OPS_ENQ_EXITING)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
+			enq_flags |= SCX_ENQ_RESCUE;	/* avoid looping on cap rejection */
+			goto local;
+		}
 
-	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
-	    is_migration_disabled(p)) {
-		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
-		goto local;
+		/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
+		if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+		    is_migration_disabled(p)) {
+			__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
+			goto local;
+		}
 	}
 
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
@@ -2515,10 +2530,23 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
 	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
-	 */
-	if (p->sched_class == &ext_sched_class)
+	 *
+	 * A retained proxy donor can wake through ttwu_runnable() without another
+	 * ops.enqueue(). WF_TTWU_RQ identifies this path. Request rescheduling so
+	 * that ops.dispatch() can reconsider the task after ttwu_runnable() clears
+	 * is_blocked. A full wakeup activation has already enqueued the task and
+	 * doesn't need the additional reschedule.
+	 */
+	if (p->sched_class == &ext_sched_class) {
+		if (sched_proxy_exec() && (wake_flags & WF_TTWU_RQ) &&
+		    p->is_blocked) {
+			struct scx_sched *sch = scx_task_sched(p);
+
+			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+				resched_curr(rq);
+		}
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2633,6 +2661,21 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/*
+	 * proxy_set_task_cpu() preserves wake_cpu when moving a donor's scheduling
+	 * context to its lock owner's rq. For example, if BPF places donor D on
+	 * CPU0 while its lock owner runs on CPU1, proxy execution moves D to CPU1
+	 * but leaves D->wake_cpu pointing to CPU0. If D is later put on a shared
+	 * DSQ, CPU0 could otherwise consume it and move it back, only for proxy
+	 * execution to return it to CPU1 again.
+	 *
+	 * When task_cpu() == wake_cpu, the donor has not been proxy-migrated and
+	 * BPF may still choose its placement. An actively donating task is
+	 * rejected separately by task_proxy_running_or_donating().
+	 */
+	if (sched_proxy_exec() && p->is_blocked && task_cpu(p) != p->wake_cpu)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -3436,6 +3479,24 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/* Delegate retained donor admission to its owning BPF scheduler. */
+		if (p->is_blocked) {
+			/*
+			 * If the donor is the same and only the mutex owner
+			 * changes, avoid triggering another ops.enqueue(): the
+			 * BPF scheduler has already admitted the donor, so it
+			 * can continue running.
+			 */
+			if (next == p)
+				goto switch_class;
+
+			if (WARN_ON_ONCE(!sch))
+				goto switch_class;
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
@@ -7802,6 +7863,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_ENQ_BLOCKED) && !ops->enqueue) {
+		scx_error(sch, "SCX_OPS_ENQ_BLOCKED requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
 	/*
 	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
 	 * may set it to declare a dependency; reject if the root hasn't
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 8348d6008651c..d32bc01071b01 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -21,12 +21,20 @@ int scx_check_setscheduler(struct task_struct *p, int policy);
 void scx_prepare_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
-bool scx_allow_proxy_exec(const struct task_struct *p);
+bool __scx_allow_proxy_exec(const struct task_struct *p);
 void scx_proxy_donor_start(struct rq *rq);
 void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next);
 void init_sched_ext_class(void);
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
 
+static inline bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	if (scx_enabled())
+		return __scx_allow_proxy_exec(p);
+
+	return true;
+}
+
 static inline void scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 {
 	if (scx_enabled())
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 3320b280f0a6a..e54a0688cc289 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -230,6 +230,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_LAZY_RESCHED		= 1LLU << 9,
 
+	/*
+	 * If set, mutex-blocked tasks remain runnable as proxy donors and are
+	 * passed to ops.enqueue() with %SCX_ENQ_BLOCKED. The BPF scheduler controls
+	 * when donors are dispatched and whether they should preempt other work.
+	 *
+	 * If clear, mutex-blocked tasks are removed from the runqueue normally
+	 * and cannot donate their scheduling context through proxy execution.
+	 *
+	 * For blocked donors, this flag takes precedence over
+	 * %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED.
+	 */
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 10,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -239,7 +252,8 @@ enum scx_ops_flags {
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
 					  SCX_OPS_TID_TO_TASK |
-					  SCX_OPS_LAZY_RESCHED,
+					  SCX_OPS_LAZY_RESCHED |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1765,6 +1779,12 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
+	/*
+	 * The task is blocked on a mutex and is being kept runnable as a proxy
+	 * donor. Only passed to ops.enqueue() when %SCX_OPS_ENQ_BLOCKED is set.
+	 */
+	SCX_ENQ_BLOCKED		= 1LLU << 42,
+
 	/* high 8 bits are internal */
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
@@ -2105,6 +2125,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
 bool scx_set_task_slice(struct task_struct *p, u64 slice);
 void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
+void scx_prepare_task_sched_change(struct task_struct *p);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index da8653cf9502d..c177a2bc0db51 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1212,7 +1212,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scx_prepare_task_sched_change(p);
+	scoped_guard (sched_change, p,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		scx_set_task_state(p, SCX_TASK_INIT);
@@ -1242,7 +1244,9 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+	scx_prepare_task_sched_change(p);
+	scoped_guard (sched_change, p,
+		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		scx_set_task_sched(p, to);
 	}
@@ -1898,7 +1902,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p);
+		scoped_guard (sched_change, p,
+			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7c12df45fdbac..0e1f8f1b1a8a3 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -214,6 +214,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 015eb6f400684..9707abeee00db 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -90,6 +90,7 @@
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 21e1a79d5ecda..0a5478afbe79f 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -142,6 +142,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index 6e0f6a3a219ac..60a1e55761268 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -51,6 +51,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index f1bb6d70bf1d7..251eea9b81e77 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -180,7 +180,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
 	{ "scx_ops_flags", "SCX_OPS_LAZY_RESCHED", 0x200LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x7ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

