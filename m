Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9D3F0A9B
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672819; cv=fail; b=KfS0XckBMSevXDgX6xhJcVWXlMS7lZPCORZXhqDkMkfq+ofvKnCoVI7gLxoHVB8/xYKxbdq9RvuhWlRBb7Zp6k/IwoGwJJEMUru5lJonG+ry+LLYdSpNtxFginBFZc5c3xnA+UchoSztk0GpQCGk9lhujlp+PQObNKwF4JiqdTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672819; c=relaxed/simple;
	bh=EpuwOOLuwGn7HNpE3PJLQtG4/y5Ir4yrY05wRz47jHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWjms9qXr2/uqezTd+VJ/uNLsbTVuaEPaOcfR9iRgJdc5/rdDuxLQ+apVzeYTX1OwAJ4sv3p2Zgv/SAPA+FJhPdXlyim6ehoZrHYpupRSB4oWkZCMRDI6nrEv9zxov5Cu3L+zl/eFO/92l7ohrXHfL5E0CbXljQKyfyVMpEG/hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKNdvMyk; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKNdvMyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INiaHd/CWJ3eQn38fvoUTz9epSpc5ck514kqDl/gUx3lBoCooAPfNJavFZYKLM6EvmDxs8zvxZ8XqPI5vFuGQoPbZnGrZmIYFELNIACrOq2y4rDjUEB3Jyzg8AqwC0e3d8svvIUCp8aKl3k0nu2tvmtue2DgnNsMOzDpaiJPCLUPZeE29357WJJbd/J34lYrb+aVAUyMNwfx7mNgoRC1b63Khyz6GzyOtHTsCKKh69Cblg6H2C5rjRy7rbLRfZA9ewlJdUO+gbuuhdqN7OUPI6EONz/+nashOFCyd1LiWd9WFv8w6naFcf+CB75UD599XDT2Fpenyygb2lKAk7X1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH7Um+tkLchRwIK3QgMqyW8MLlt5Er3XZcG9RJvzrV4=;
 b=LYsJgjOmNwgljqfbmqCQDO8ZqOvFQfySnGku2hrMtO1LHnJiFLWzpbrel8049/qUuaIdLebHbBe1ERMTtM1MuGOBh6XTxhPFlAnbO8VxdvQ4jrU8PYBQmHorZwfYhJHJluzSHwaJ+4125ZRlSkmsR5i28nsmR3XQyxHX6AtAFtz4w/1FQSEdPczlezfpIMdE8dP9vVVfrFMHfULdoMNlgcH3sTJ3HCRxc4TAqDaPD27WYRI9uEgKAvlCnrpHGjydVPLi3z/3VI7Pl0UeU+kP4d4thUv0sOzqxMRHZM9hssdGHkhNXj5SMXF9R705HkLHFMQynaglEU9h+izLVatBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH7Um+tkLchRwIK3QgMqyW8MLlt5Er3XZcG9RJvzrV4=;
 b=WKNdvMykvv/grjQnlz+oHbwKTJp9teWZ3nVCOhrzW146w4z68jH6JTZWCq5VgPKWWXO82/5UmLKc4nt09VCI3Aeo4PaRm0DraVm3ml1K46dlgmoeWF5cacdWTLktOhoj38yM7+UQmqytueocV5x+qK4THlzPblG22OUI4TWCQRboiqRfNn5cpEWkgLVY1IkI6G/j5DVKHrSyFnnFTmzl5bPQX4+Bnj/nOzfuhi54VaMN3G59ycpv5nlgRPtcnvSwvoqweGomhivqtu8gYlwm75NPAzTFN2//GtKCUI4XYgDjim23U+aO6FvtFk1ALdHVDaAu4g5hUDRpWm2O4zul6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:40:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:40:09 +0000
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
Subject: [PATCH 06/10] sched_ext: Delegate proxy donor admission to BPF schedulers
Date: Fri, 10 Jul 2026 10:36:30 +0200
Message-ID: <20260710083913.30573-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba1fc7-dbe2-4415-e07d-08dede5ed95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|5023799004|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6NNXMI4ivjSMZgmIGoHMkEwUWkp5p/cAF/pwsYw2XOVamoZLWA7qY16JJmneUd61nEZK/uZQb6OFNRdGZlt6uiulkJw1vUerRl92JQZ7dMidXKQaIqx1Yq+ifOcyt2XF+YS3NKbJREqLvb5NFyDt2nWit4gDKDJuAQfpv3pfPLBjY4oq0JhaZF3oOmkO4RUjeeJZxW97Foqka9ofJ626hbbIxVFPMsmrD3+jcMNljby2orndA7EPVCUCEImT3vgXnyGluCR7ipHPaP0PKu0fItVFTZJ2yP3MJvIEzCPrwmwJ/R5XPkJPBKtAtSCU44IpVcr0JHs1cJeFW/I98byAvUR2CIlZkhXbtsYiGp/UmJ83Vo7Q8N+4P5A6M0LcciWsMaR8y95qweqyTyiA/WtDx6Dtlto2kvy0uUvS1QfjYb0QaAgG4REkn7NmyMGnAsILsxRwv+d3hVkqHi1VEq72uD+2y8BzcXSy+XkgjCIw26uKfFZgYSf7hc9yisIO+j7JFTlodshc3SuKWxQ1fVawAaV4KRqipCM5rEocQi2BNptmlLDUCgdGU0PG3DPfQToHVy6Jb7AoPWEBQTgpIJQKvdQSoI/kpjNJcOLrIVY9dc+uHEPy7S/dsHzXxBAZ2I868LQyidAUybRQBUFl/W9Rto1hEc6oN6yhfYRQ3sgpyJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTG/32owtQXUwEdUwq1skg0JxwGrkegn1JGE1Omd3XjgNvIZdR4pwXFSwrhZ?=
 =?us-ascii?Q?+di6avxLw0rWsCDs52iAIjviU+MSbh1P3S/oXHkhrSxJOwuJpb0Lse6lH86H?=
 =?us-ascii?Q?V+axbsAJX5BOdhKTISP3LvB/1vNKKYep7gWkjkasuIE5R8Ey77+2iJAzmroD?=
 =?us-ascii?Q?+L8QDr/yJV6rDKo2xPZYXOATT5I92Q9zUf6+mFvW4V+bCrvJET3Ijy+KWIxi?=
 =?us-ascii?Q?PfGb+Z5f4AnwnIOX/bow/OU1rWSa70g+RuirdHsmpwKN5GSFrgjBy6Q0aV1f?=
 =?us-ascii?Q?CkX0qArMPGm158AUeQ6Uy9vqEJc1HPzZYtuWsSCaBRWSzVxCxf5t7AlfkNQF?=
 =?us-ascii?Q?n9yylvLk0m97DWRqBa4J+9850VfQ9srtGzzyPW+glREzno9blHXnu8Sz0jrv?=
 =?us-ascii?Q?vhgD1kb8lDAvDoVxrrUcoUGsS/a62HufgUyUsR1a4jjXOM5GU0IMtWWMpVKe?=
 =?us-ascii?Q?/DyKDYAk7DatGMx7HT3GfcWcj1vmGJZew/dE+iRGiW1oo0qdlPw6wrefkHb7?=
 =?us-ascii?Q?pmBSn+SVIQhvsYgdZzeK7sl3v5IwvZLMKL071DS/Zc9Yi+HpAXI4yYm7TxA7?=
 =?us-ascii?Q?8tHrYLmTeRB2QP63pFdyBXScdXz6IVosOoIaU6Wh/PFQeBNwVhViYL6dw6V+?=
 =?us-ascii?Q?Ny+Dv0n4+3iHLfeORsHvDd2Yg2GHFCmv6xnE1O4niCIarlc/f6mc+JovqNUB?=
 =?us-ascii?Q?UjVwLB1DAap+uO9xgfxBlM0JcS5oOSCSzmOR3q2dhV2qCkDGMhzegvTho9Qg?=
 =?us-ascii?Q?Gpnd5ehV5sFXpjRfZj6LpVRAj7JtoDogwsz9Z00NTe0VLiX5G3TYnrjxdOyW?=
 =?us-ascii?Q?2gSruHp8IZu/rNwv0AZ6uRQv57HIizATnNtMqZDxmjh190ha1LBdidsuEHT1?=
 =?us-ascii?Q?9BK8ligAT8kOJ6NeKjFV1rOFRuJ2Wl4/NZRTlUI2ZRacJtKHQpqS4GY65IqJ?=
 =?us-ascii?Q?WNZgh35vbXMmYZxh4/MdhSDgJZ2E+vU8LNy7JYyi1Vt9RrVKERh4Y/fXb+EM?=
 =?us-ascii?Q?hMk0BS/p6d8GOKb24/BfoOK4xN91okETrFZ3qZJL2U4HiNtIouAXdYIC+QJ3?=
 =?us-ascii?Q?9Vx4FRaAiLkgAkbGxt10qmuuupl5tEx9W+Bqhybu1mYY7twhA/jUP0wKJ0Hi?=
 =?us-ascii?Q?V7DCyUybvL6usZuSAc+iczeMiqn2cGRzQqbOenx/qQa8PAK/oWdDwMtDUkJB?=
 =?us-ascii?Q?aswhBsOFS2PIaZIQY3uPjvT0l2v73pnD9jHu6l0tP3JznsOm2yQbkRgKZvVY?=
 =?us-ascii?Q?C3P1nLTSUgnJjKMRqfrRE5K08iwjdDIJGHzlo9CMQZAiSIhfDlQ0uugBoUIU?=
 =?us-ascii?Q?92N8i1tLmWoYmPBU5EQ8lX/PPPE8EncW57sv/g7qFae3QeL19eoQUv1hL09Z?=
 =?us-ascii?Q?9XeNMXeCqJnPwnkVQr22NZo/UhhYSRUX/7JjL9Y9QvZKD0uqX4vNwpo+QQW+?=
 =?us-ascii?Q?iCyclC8G8qjinOMN2uHFU9asewU2qpOTjS+MHa6MBUmVza3jeYo/Y4poX6cX?=
 =?us-ascii?Q?K3MVKWhb/ph+4aTxNq5nDBgx/oU1JMGlKnr+PEsZtXItT913b2Zb1OP2tsu8?=
 =?us-ascii?Q?MF5sE0MzmfDXYz+VD2/HGynwIZhMutrgM4W2MOrJhY9rITUVS0UaEEuDFioQ?=
 =?us-ascii?Q?Geg08mk99GkK73L92U7mqK2Y7nkaWAxyILZ8/0NH+pp+wlfYoAweK2FScCdn?=
 =?us-ascii?Q?owjhIpHZUWLnBkJNk45Y47w55ko2NqlHVYRQfygpah2MyRQSeV2jdE3zTG/M?=
 =?us-ascii?Q?yh+I/PKJ1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba1fc7-dbe2-4415-e07d-08dede5ed95c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:40:09.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkVuitHPwzlYMyJjtduNhLPnmVImKrXjH0bP8WAub41+NPdJAfBqYa+a/DOhBfU5aq7CcoApZUHm3htqi1DD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

Proxy execution keeps a blocked donor runnable so its scheduling context
can execute the mutex owner. Dispatching sched_ext donors on a local
DSQ bypasses the BPF scheduler ordering policy and can give donors
more CPU priority than intended to perform the proxy execution handoff.

Add SCX_OPS_ENQ_BLOCKED as an explicit proxy execution capability. Tasks
owned by schedulers without the flag block normally. Schedulers with the
flag receive blocked donors through ops.enqueue() with SCX_ENQ_BLOCKED
set in enq_flags and can apply their own admission policy.

From a high-level perspective, the resulting flow for a BPF scheduler
with SCX_OPS_ENQ_BLOCKED is:

    D ------ blocked on -----> M ------ owned by -----> O
 [donor]                    [mutex]                [owner]
    |
    | ops.enqueue(D, SCX_ENQ_BLOCKED)
    | BPF dispatches D to CPUi
    v
 +-----------------+
 | CPUi local DSQ  |
 +-------+---------+
         |
         | pick_next_task() selects D
         v
 +-----------------+
 |   proxy exec    | move D to O's rq
 +-------+---------+
         |
         | run O using D's scheduling context
         v
    rq->curr  = O
    rq->donor = D
         |
         | O releases M
         v
 +-----------------+
 |   proxy exec    | return D to CPUi via wakeup
 +-----------------+

Scheduler ownership can change after a donor has already blocked. Since
sched_change preserves queued state, handle both iterator-driven moves
to root or sub-schedulers and sched_setscheduler() transitions into EXT.
Before entering a scheduler without the flag, deactivate the retained
donor. It remains on the mutex wait path and wakes normally when the
mutex becomes available.

The global sched_ext enable state can change while __schedule() holds
the runqueue lock. Once an EXT task has an assigned scheduler, consult
it directly so the task cannot retain a donor during the transition
unless the scheduler opted in. Tasks without an assigned scheduler keep
the generic proxy execution behavior.

The preparation helpers require and assert that p->pi_lock and p's rq
lock are held before updating rq state.

The donor starts associated with its original CPU. A BPF scheduler may
dispatch it directly into that CPU local DSQ to let the core resolve the
mutex owner and execute it with the donor scheduling context.

Reschedule a retained donor when its mutex wakes it so ops.dispatch()
can reconsider the now-unblocked task. Make SCX_OPS_ENQ_BLOCKED
override the exiting and migration-disabled enqueue fallbacks so
opted-in schedulers receive all eligible donor requests.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c                           |  43 ++++++-
 kernel/sched/ext/ext.c                        | 107 +++++++++++++++---
 kernel/sched/ext/ext.h                        |   6 +
 kernel/sched/ext/internal.h                   |  23 +++-
 kernel/sched/ext/sub.c                        |  12 +-
 kernel/sched/sched.h                          |   6 +
 kernel/sched/syscalls.c                       |   3 +
 tools/sched_ext/include/scx/compat.h          |   1 +
 .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   3 +
 tools/sched_ext/include/scx/enums.autogen.h   |   1 +
 11 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0139cd4a8be7e..3d72f64ffe627 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6764,6 +6764,45 @@ static void proxy_deactivate(struct rq *rq, struct task_struct *donor)
 	block_task(rq, donor, state);
 }
 
+/*
+ * Remove a retained proxy donor before changing its scheduler ownership.
+ * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
+ * drops it from the runqueue.
+ *
+ * Unlike the regular schedule() path, this must leave @p fully dequeued.
+ * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
+ * which would let the following sched_change preserve and re-enqueue it under
+ * the new scheduler. Complete an existing or newly-created delayed dequeue
+ * before returning.
+ */
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
+{
+	unsigned long state = READ_ONCE(p->__state);
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	if (!p->is_blocked || !task_on_rq_queued(p))
+		return;
+	if (WARN_ON_ONCE(state == TASK_RUNNING))
+		return;
+
+	if (task_current_donor(rq, p)) {
+		proxy_resched_idle(rq);
+		/* Kick the execution context if @rq is remote. */
+		resched_curr(rq);
+	}
+
+	if (!p->se.sched_delayed)
+		block_task(rq, p, state);
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
+			     DEQUEUE_NOCLOCK);
+
+	WARN_ON_ONCE(task_on_rq_queued(p));
+	WARN_ON_ONCE(p->se.sched_delayed);
+}
+
 static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
 	__releases(__rq_lockp(rq))
 {
@@ -7006,6 +7045,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	proxy_migrate_task(rq, rf, p, owner_cpu);
 	return NULL;
 }
+
 #else /* SCHED_PROXY_EXEC */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
@@ -7136,7 +7176,8 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) ||
+				  !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c755cbefe2f2f..60154b25ce975 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -23,6 +23,63 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	struct scx_sched *sch;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
+	 * Once @p is associated with a scheduler, use that scheduler's policy
+	 * even while the global enable state is transitioning.
+	 */
+	sch = scx_task_sched(p);
+	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
+}
+
+/*
+ * Called after sched_setscheduler() validation and immediately before
+ * sched_change_begin(), with @p's pi and rq locks held.
+ */
+void scx_prepare_setscheduler(struct task_struct *p,
+			      const struct sched_class *next_class)
+{
+	struct scx_sched *sch;
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	if (p->sched_class == next_class || next_class != &ext_sched_class)
+		return;
+
+	sch = scx_task_sched(p);
+	if (WARN_ON_ONCE(!sch))
+		return;
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
+}
+
+/*
+ * Called with @p's pi and rq locks held immediately before
+ * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
+ * is updated only once.
+ */
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(task_rq(p));
+
+	update_rq_clock(task_rq(p));
+
+	/* Block retained donors that the incoming scheduler cannot manage. */
+	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
+		sched_proxy_block_task(task_rq(p), p);
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -1705,6 +1762,7 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
+	bool enq_blocked;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1737,15 +1795,22 @@ static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_fl
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
+	/* %SCX_OPS_ENQ_BLOCKED takes precedence over the fallbacks below. */
+	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
+		      task_is_blocked(p);
+	if (enq_blocked)
+		enq_flags |= SCX_ENQ_BLOCKED;
+
 	/* see %SCX_OPS_ENQ_EXITING */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
+	if (!enq_blocked && !(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
 	    unlikely(p->flags & PF_EXITING)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
 		goto local;
 	}
 
 	/* see %SCX_OPS_ENQ_MIGRATION_DISABLED */
-	if (!(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
+	if (!enq_blocked &&
+	    !(sch->ops.flags & SCX_OPS_ENQ_MIGRATION_DISABLED) &&
 	    is_migration_disabled(p)) {
 		__scx_add_event(sch, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED, 1);
 		goto local;
@@ -2048,11 +2113,18 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 {
 	/*
 	 * Preemption between SCX tasks is implemented by resetting the victim
-	 * task's slice to 0 and triggering reschedule on the target CPU.
-	 * Nothing to do.
-	 */
-	if (p->sched_class == &ext_sched_class)
+	 * task's slice to 0 and triggering reschedule on the target CPU. A
+	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
+	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
+	 * blocked donors, reschedule explicitly so that it can reconsider a
+	 * donor it declined to dispatch while blocked.
+	 */
+	if (p->sched_class == &ext_sched_class) {
+		if (p->is_blocked &&
+		    (scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED))
+			resched_curr(rq);
 		return;
+	}
 
 	/*
 	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
@@ -2866,18 +2938,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		set_task_runnable(rq, p);
 
 		/*
-		 * Mutex-blocked donors stay queued on the runqueue under proxy
-		 * execution, but the donor never runs as itself, proxy-exec
-		 * walks the blocked_on chain on the next __schedule() and runs
-		 * the lock owner in its place.
-		 *
-		 * Put the donor on the local DSQ directly so pick_next_task()
-		 * can still see it. find_proxy_task() will either run the chain
-		 * owner or deactivate the donor so the wakeup path can return it
-		 * and let BPF make a new dispatch decision once it is unblocked.
+		 * Mutex-blocked donors only stay queued when their BPF scheduler
+		 * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
 		 */
 		if (task_is_blocked(p)) {
-			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
+			scx_do_enqueue_task(rq, p, 0, -1);
 			goto switch_class;
 		}
 
@@ -6629,6 +6695,11 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -6978,6 +7049,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
+		if (new_class == &ext_sched_class) {
+			scx_prepare_task_sched_change(p, sch);
+			queue_flags |= DEQUEUE_NOCLOCK;
+		}
 
 		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice = READ_ONCE(sch->slice_dfl);
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
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5ca44ad887864..8ac195934f63b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -212,6 +212,19 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
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
+	SCX_OPS_ENQ_BLOCKED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -220,7 +233,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_ENQ_BLOCKED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1339,6 +1353,12 @@ enum scx_enq_flags {
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
 
@@ -1624,6 +1644,7 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index ce76ae141e0a9..954aef5950e95 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -117,7 +117,9 @@ static void scx_fail_parent(struct scx_sched *sch,
 		if (scx_task_on_sched(parent, p))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_sched(p, parent);
 		}
@@ -209,7 +211,9 @@ void scx_sub_disable(struct scx_sched *sch)
 			continue;
 		}
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, parent);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p is initialized for $parent and still attached to
 			 * @sch. Disable and exit for @sch, switch over to
@@ -503,7 +507,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
 			continue;
 
-		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
+		scx_prepare_task_sched_change(p, sch);
+		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
+			      DEQUEUE_NOCLOCK) {
 			/*
 			 * $p must be either READY or ENABLED. If ENABLED,
 			 * __scx_disabled_and_exit_task() first disables and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80b72d934ff37..dfa0cb722c00c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2471,6 +2471,12 @@ static inline bool task_is_blocked(struct task_struct *p)
 	return !!p->blocked_on;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+void sched_proxy_block_task(struct rq *rq, struct task_struct *p);
+#else
+static inline void sched_proxy_block_task(struct rq *rq, struct task_struct *p) {}
+#endif
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 	return p->on_cpu;
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
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 23d9ef3e4c9d2..8d5606e465080 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -117,6 +117,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_ENQ_BLOCKED SCX_OPS_FLAG(SCX_OPS_ENQ_BLOCKED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index da4b459820fdd..79b31eb7db7cb 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -55,6 +55,7 @@
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
+#define HAVE_SCX_ENQ_BLOCKED
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index dafccbb6b69d2..7efe7b9346b49 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_REENQ __weak;
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index bbd4901f4fce3..f8fbeb7fbf95b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -47,6 +47,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
-- 
2.55.0

