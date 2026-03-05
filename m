Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636F2E173B
	for <sched-ext@lists.linux.dev>; Thu,  5 Mar 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692151; cv=fail; b=CWXardRIXeuARDnViC/xupsUSEHbkvrGBKRBawo5JjuFpwgTMr5zoDVIz91bAi+JCYZAZJTx3Z9gh6poYu3WZBjdiPjq6hZMFwikkDQSxyN8Oq4w001boSjlGB8oxA6ZyMG70K4ZxrXQFIj4PiQ7xLmwQlHx+nEOhp1BnMmcZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692151; c=relaxed/simple;
	bh=7l6yx5jzZ9/eE+qFQUWGvwnjrDT1n9CS1ngM68FZB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KllkHucLMWdaXUEdEHyFiRR5KmQ7xIbRDt7ilCZwZswO2BcYWm8wmo0cOz37WtUbRHjSKMp1EsQN8qVFgITzOCJEbf6mISwz73Me2u1robBjVbCfVp2H+po/mqs0sp8nqagu+gtO2v0ZDDwtlQ88ywF9bY5Tm9fLzFROySE3OMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ksvjf9Xe; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ksvjf9Xe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl2fpSKToQT27of4rccxPfF6E2IceqEK74Pm9dJ9lwc7JtYKie4pVZvdseV2MNXWL7eoFWPhLwG5dXvSenWjEdIIUyKw3V8XGtAHbr29bPqnhwyDlY3mqRPD14/QrKmrcIg3HvkgeUQ6b4oNMzcxsDLUad+CtpaWItV7ZsmLjp6UmmdNotOg6XchRIdXq6tTn3V/qUiwfbDxQOwvR6UHiCpPSXXh5Ih0NKNuR0Y8mhGPsLS4PmtnpDORjf+jwxWEyj50apcBQmBYdmaOVdJLrRXtwxb77j6pSw48KbPk9ZY88Tu/eXPkH34AEFD+QQ+SbM1TIIH41dcpBpVbth/62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp93quJswiLpqCBzc+Fn3dduFceRJvC+rOBT5GLkVK4=;
 b=Tjd1aen1WSdHgehgm1lfq+g1Z6pvmsn/GpELDSD8w+OvCW1PttD8BkXxdVeNTzhrJp+5ic6kfFlt4YIjZiESxcPf4Knfnn9L1phDrRVTqe1eGE9H6PJ/7LbswToLoYOjO9paiayB1SoEsuPPvjvfwgEiMj6P8RLlv27hysHRmfQcTgYaOEIR2t/t1eSCuqlKs/hs9VReVEq7jkx4OA4pnYaGrNUWR4m+S4L/FYEOx4ftwGMAZconXLhNQH9ympC6UcGysNerAJQKVF4rRNaR5ZV/fXamqrhRrviUvcODjOcT9q554/QFoKyOW152C0rkHVRKPlMQeC/WgG6sqIZtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp93quJswiLpqCBzc+Fn3dduFceRJvC+rOBT5GLkVK4=;
 b=Ksvjf9XekHuebYlwbiqjzTs1nPgOkLluUnS+9v4uTw9l6lI/P8Stc68oza8QTp+GIRadkHh2xd5zyLQbWzNrN7q8feEKJ59wnf/ouj14ENZedpBTRhqYIIL4YeqX/MTa87odA5YKWwLwTpqInsl2wc/MSzZiKFVli09f190/5P6/i61+QridUg8kQxTTT3zxJ75QapVoEyXtE2ohqvOezaSmWi7asiAbdpp+dL/N7Xb5ofhfVgzxjUkJS8Pf5tpPgTkPVo2LZjVe/4aW5gfSq6L3ZuUQYqYQRxsP01nPneALeG4q8QfhisYl5pT/luZLJVH7Ci4WcmjasaZD92YoEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 06:29:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 06:29:04 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Document task ownership state machine
Date: Thu,  5 Mar 2026 07:29:00 +0100
Message-ID: <20260305062900.43450-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: f01c27de-986d-4c3e-a580-08de7a807f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	1Eucujpb4GDUTXAaNkLAjG2UIfLDnoHhaDEWquJWsLaBI4iPbgXzspAX7Odg500j/gosTCmnGBLte/SNWlp0NjXPhQPjkwq7P+hsfDPNGMt5sLQ9K9MmTu+Ti8ht8gI4a6NndLmmvOmP/yLZwXbDAMevNSASR8VCABP99tVw3T352qBRQkewISEAFkkih3ekU9Zx2iJzBVlR+Pj/42DibocynETW2VDusgkPhWpzcM9JDsdRgcHQ/WOEQmPlpbXWY2Mw9y+4ca1esVEkR8U53/xUF70wU4FjWzBzzkdhEaLhPRRimo7E/d2CBVZZ5/0jgYEWFIYZbVX8SN+RAngwodaimTLkFyVOZnchtmPFLz1yHHY8fcv06kvxydMnT1UCC+i30qE/xWdVd0OD2Fj8M1f02ZyXSR1GIiVrE0Tm6KkoytGt5xXdDH7wOKWLproKYW80wnnUXJ9+Rk3uZLhsF/ady2FoDWQhm/WSPyqgslDpGzkzAg5uZCUYQo6PsoorqEnlVpprgD2ChrLB9KPUl9vZMjxQhS2ahRmvdVJhdnvMaCoviAEw6oojoz/nM/GyWgESz142R6j8XAuLJq8eY6S+5ti+1z9d+I/dNG/i3NrdbxjA1SDeqIixjWAngnw65R8hEFMM0ArXGgQHDONrcYXBGIxDieSpycSwMTmpyGtHi2SEPVC+afnjoRYGITbV/gQyyEYGwC+u1C01EqLaLK9VmCBQGO4yBP33402Xvd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgXsTbbhOjkAgmiEnGn7buM+zOcqVl57YO57LDPJJqXcVo1HXrT0DdAa8bWt?=
 =?us-ascii?Q?KtesvQG4OFWT19S0ducPCDgzROP9R8CXveaDEOfTZxqnuCIjECQxbwu0vUsj?=
 =?us-ascii?Q?ZyOv2JnCoA+oK7acZ4LvfPz7UIl8/UU+rWgk7WOl9fjPWw9EBM1jT98GSX6z?=
 =?us-ascii?Q?JYd2m/1HvoFL9Hrnf9oy3pERdngPP5FKNc9sD7UefUkf3VZ0Ud2nRiqxruc6?=
 =?us-ascii?Q?VfY6MKyAWR8oRI4LiOssY/pe2g/nCew9UjPo+s455RQMkULF1wtkVnpsnvvi?=
 =?us-ascii?Q?9kh97eLkt1HP4VO6dnnH3V8D0Vrk3gQkPRkecTQPdtdcuDTBGXJLQVqDnVC2?=
 =?us-ascii?Q?P/x+ge1nw/pX4Apc97PeFX9KU9eT2JBFR6sGHXo1bgOl1OoRhyG8DYFT+1AV?=
 =?us-ascii?Q?04pqqvT3+8kNy2jICNRr2vkv2fLEhFaKK3ugq3MjM0Dy7L37jl75N2YTQlXV?=
 =?us-ascii?Q?bKtgelTFGwYemYGkeWIjlN14R6csNjjYePa6YO3f4j4IQTnIPI8T0ZcB4Ipb?=
 =?us-ascii?Q?N8YMkklnTqjjx7JQa6nHlPP0gBRmkqHr1wM+MjMjd4Is8xl+cBO/DxoLprHG?=
 =?us-ascii?Q?9Gqz7Uet/0/QWzUi4F69WXCt/n3jT5zCW2zpMm26I1UA/r9LjvU2X730vihl?=
 =?us-ascii?Q?DM5+MjCN9TOtM7uMRU7h1mDlsf+jemqRf1DVUdmStU7QIQ8drVhgfkVk3Z7k?=
 =?us-ascii?Q?3Sr1dCNomb4NwL5vJBR4TCqk1PeTzdDaAsceYgpNvgEbpnuz1nG6ooEtl9PR?=
 =?us-ascii?Q?u5t+EZW7WyoVD6CCpZSlAP8NHawHKLHbnRLPqBBh78JqdtzMgUQQ+Q1URWx5?=
 =?us-ascii?Q?KbbwJy6OduWmroLpWyvf/CaP9dritsmH+kk1Pr4HESalFWsbIgKa2xBx1jTc?=
 =?us-ascii?Q?QrAJ9lJd2RoeyPwlumKEU6hZGSBmoD9b6jk5WfOae+JArMm1WSDvrO9sHsHV?=
 =?us-ascii?Q?dypBqklMYecPqZ8ZSDkqWibQlIZ8wkUqnsDD02tgPsPWIa6OJU9snWPuTtlV?=
 =?us-ascii?Q?8ONZDkaIo9Xy7hJDPP5148WB65sVNKUjyAYjiEGO75h+1nOMIIXOp5B+j4LK?=
 =?us-ascii?Q?8juskhBZPsE069PO02Sv3Ut490JOWnSeiYoixYD0bsAqM90Ow49Sj1mcBP+I?=
 =?us-ascii?Q?KV6qbBxzh9PpaFcuttgsuLmFUH6w35/dpNOwHhD6OYF+kfr+dXUfLS1JR5U6?=
 =?us-ascii?Q?sSIDc801hhoNnsbIt/mYB8xZVhHdMpJr46h4bQ4WDSAHw9dkvP9ZCtvEdh7s?=
 =?us-ascii?Q?GFsVgZmuudZpJJgUf2GIGm42OC2fFOoq5Pr+sYXAe7WNsh+lIHqOBt808fux?=
 =?us-ascii?Q?0eoPT5ENxjUXegoZ2icpNIuMmSYVGQy+D1I9jjPsJmsb5B6J0xOhWv+85IGe?=
 =?us-ascii?Q?JLaHBlJceVT1pfL6kfTrr71L9LKA2e5cOxY6nFmCKIYVz9YFWlEiEM5mQ5Un?=
 =?us-ascii?Q?/Sw1aVKOe4NT/MHGv9JsrxnwQWbA+SdhawIB/tb4KqtniACElJq8H/4uvv43?=
 =?us-ascii?Q?WO1z2LgJzD2l1goOYFv5eBgnRM10dm425IJeQD5oRzSilt1Qip+yU61ZDYUh?=
 =?us-ascii?Q?1t0VE1PdpGUrwPQ5eB3mew3qGl6bl1kXbz90IZQF/cffCQbIgBDix4PQBcpI?=
 =?us-ascii?Q?+sjQ975Tg/VPX0of2amHa6M/BoMkFu49gfyBa5OxfiCCsRB87ZUAVaBWMnEU?=
 =?us-ascii?Q?HBKyELCILTKTwcs3BBFiU4YPGdBUSzXyRy6Ky6R2g7HKSoSAd+ApEOjWLJKy?=
 =?us-ascii?Q?uRJn9l8Hcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01c27de-986d-4c3e-a580-08de7a807f09
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:29:04.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPLd8Hm8PuvL3D/bBXBrKOw4UF8nEUPfKN3Z0LhGI8UcolUeQUGuekHPHLd9x08CHFIL7IeZqm1FBLwgzGdNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106

The task ownership state machine in sched_ext is quite hard to follow
from the code alone. The interaction of ownership states, memory
ordering rules and cross-CPU "lock dancing" makes the overall model
subtle.

Extend the documentation next to scx_ops_state to provide a more
structured and self-contained description of the state transitions and
their synchronization rules.

The new reference should make the code easier to reason about and
maintain and can help future contributors understand the overall
task-ownership workflow.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Remove DISPATCHING -> QUEUED transition (Tejun)
 - v1: https://lore.kernel.org/all/20260304153343.340285-1-arighi@nvidia.com

 kernel/sched/ext_internal.h | 114 +++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bd26811fea99d..417d3c6f02fe3 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1042,26 +1042,108 @@ static const char *scx_enable_state_str[] = {
 };
 
 /*
- * sched_ext_entity->ops_state
+ * Task Ownership State Machine (sched_ext_entity->ops_state)
  *
- * Used to track the task ownership between the SCX core and the BPF scheduler.
- * State transitions look as follows:
+ * The sched_ext core uses this state machine to track task ownership
+ * between the SCX core and the BPF scheduler. This allows the BPF
+ * scheduler to dispatch tasks without strict ordering requirements, while
+ * the SCX core safely rejects invalid dispatches.
  *
- * NONE -> QUEUEING -> QUEUED -> DISPATCHING
- *   ^              |                 |
- *   |              v                 v
- *   \-------------------------------/
+ * State Transitions
  *
- * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
- * sites for explanations on the conditions being waited upon and why they are
- * safe. Transitions out of them into NONE or QUEUED must store_release and the
- * waiters should load_acquire.
+ *       .------------> NONE (owned by SCX core)
+ *       |               |           ^
+ *       |       enqueue |           | direct dispatch
+ *       |               v           |
+ *       |           QUEUEING -------'
+ *       |               |
+ *       |       enqueue |
+ *       |     completes |
+ *       |               v
+ *       |            QUEUED (owned by BPF scheduler)
+ *       |               |
+ *       |      dispatch |
+ *       |               |
+ *       |               v
+ *       |          DISPATCHING
+ *       |               |
+ *       |      dispatch |
+ *       |     completes |
+ *       `---------------'
  *
- * Tracking scx_ops_state enables sched_ext core to reliably determine whether
- * any given task can be dispatched by the BPF scheduler at all times and thus
- * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
- * to try to dispatch any task anytime regardless of its state as the SCX core
- * can safely reject invalid dispatches.
+ * State Descriptions
+ *
+ * - %SCX_OPSS_NONE:
+ *     Task is owned by the SCX core. It's either on a run queue, running,
+ *     or being manipulated by the core scheduler. The BPF scheduler has no
+ *     claim on this task.
+ *
+ * - %SCX_OPSS_QUEUEING:
+ *     Transitional state while transferring a task from the SCX core to
+ *     the BPF scheduler. The task's rq lock is held during this state.
+ *     Since QUEUEING is both entered and exited under the rq lock, dequeue
+ *     can never observe this state (it would be a BUG). When finishing a
+ *     dispatch, if the task is still in %SCX_OPSS_QUEUEING the completion
+ *     path busy-waits for it to leave this state (via wait_ops_state())
+ *     before retrying.
+ *
+ * - %SCX_OPSS_QUEUED:
+ *     Task is owned by the BPF scheduler. It's on a DSQ (dispatch queue)
+ *     and the BPF scheduler is responsible for dispatching it. A QSEQ
+ *     (queue sequence number) is embedded in this state to detect
+ *     dispatch/dequeue races: if a task is dequeued and re-enqueued, the
+ *     QSEQ changes and any in-flight dispatch operations targeting the old
+ *     QSEQ are safely ignored.
+ *
+ * - %SCX_OPSS_DISPATCHING:
+ *     Transitional state while transferring a task from the BPF scheduler
+ *     back to the SCX core. This state indicates the BPF scheduler has
+ *     selected the task for execution. When dequeue needs to take the task
+ *     off a DSQ and it is still in %SCX_OPSS_DISPATCHING, the dequeue path
+ *     busy-waits for it to leave this state (via wait_ops_state()) before
+ *     proceeding. Exits to %SCX_OPSS_NONE when dispatch completes.
+ *
+ * Memory Ordering
+ *
+ * Transitions out of %SCX_OPSS_QUEUEING and %SCX_OPSS_DISPATCHING into
+ * %SCX_OPSS_NONE or %SCX_OPSS_QUEUED must use atomic_long_set_release()
+ * and waiters must use atomic_long_read_acquire(). This ensures proper
+ * synchronization between concurrent operations.
+ *
+ * Cross-CPU Task Migration
+ *
+ * When moving a task in the %SCX_OPSS_DISPATCHING state, we can't simply
+ * grab the target CPU's rq lock because a concurrent dequeue might be
+ * waiting on %SCX_OPSS_DISPATCHING while holding the source rq lock
+ * (deadlock).
+ *
+ * The sched_ext core uses a "lock dancing" protocol coordinated by
+ * p->scx.holding_cpu. When moving a task to a different rq:
+ *
+ *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
+ *   2. Set p->scx.holding_cpu to the current CPU
+ *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
+ *      is set, so clearing DISPATCHING first prevents the circular wait
+ *      (safe to lock the rq we need)
+ *   4. Unlock the current CPU's rq
+ *   5. Lock src_rq (where the task currently lives)
+ *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
+ *      race (dequeue clears holding_cpu to -1 when it takes the task), in
+ *      this case migration is aborted
+ *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
+ *      into dst_rq's local DSQ (no lock swap needed)
+ *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
+ *      src_rq, locks dst_rq, and performs the deactivate/activate
+ *      migration cycle (dst_rq is held on return)
+ *   9. Unlock dst_rq and re-lock the current CPU's rq to restore
+ *      the lock state expected by the caller
+ *
+ * If any verification fails, abort the migration.
+ *
+ * This state tracking allows the BPF scheduler to try to dispatch any task
+ * at any time regardless of its state. The SCX core can safely
+ * reject/ignore invalid dispatches, simplifying the BPF scheduler
+ * implementation.
  */
 enum scx_ops_state {
 	SCX_OPSS_NONE,		/* owned by the SCX core */
-- 
2.53.0

