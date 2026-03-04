Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59D33CEA8
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638445; cv=fail; b=tCvAFUo81J1G+a7KzNbG+AKeoqfXLrBCKyPlF7JVqZpBMPN8RU6pBAXd1+/3Crp3rH72dNztbAv8t8s9ehWZItW5Fj7aBqNeG9Tbj0UTpgZsWmRKHCsVfww34Q3U7NANHihJgiZmi9z5U6jDgrWiHK5KusAtpzGC2pMiGjrxzMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638445; c=relaxed/simple;
	bh=aC2/i6CI2bgt0h5pj3/BXmTjPCmtin1Z8QllnIoqRPU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gr6JBY13TTiQVbksCIJf28O7NkmXhtkb90SqK6Z7m+FdlL5BK3TSaKpLHxZL/LqfYsbxtGlT6fWzDty3NrToEIg4Mm94CDE6FP+59bt79tuQuyjEIu6mu367iS28W8292pPdcfvnc5eW4xgUJEc4fCeY+/XyiraSAZ5CBrTay14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fU+M/5Cg; arc=fail smtp.client-ip=52.101.57.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fU+M/5Cg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+nWJA9wngxyv3MszTOS6f7wUdRxPc4MVX/M9k3JNLCpaYqzFkxVvFMiKfmRjn70qAksavicwC2JvrKA0Mjab7jnTQGqmAQ9I5CaL0Rc04sxrXH+8cbNIAxb3BdecuSlPktdrKP5zgbIIwd6+uLCMww5hQy4eFaPfD3vBAs7r//dDxGEC+znrnVohSb6pA3zyIRKdIL7hNOXenBjShEwGhiEhCabZwBWWx5ijRSE+aRPJDYrwPytCEHnYJMiNSHUb32upraiROIQcZDCNKEtcBHoKOIb/PA25T5JlXkcnzctGwPXLlzx9+tRZRLmXlQdYWlMr/2gkal82IUQfLrDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCpuQYboU3pXabFPeV1peM0z/V21o4XxCAErBOzbggA=;
 b=uPA1jSUpLyWbkyzorhhlj55hGJ3F/4RS9AlOCLKn1S+6sMNJtDLoSnfOITvfzSR01id7WJb8ucj+ykyCSxHkEILxf6GgvMsc34Zx4UCLzELSmoDZ4oOAvunaXAVboUzBSM3e/ZpDqhWs3M/+/Rp/7JRv7WBI/G25u3E5HQX+Vl6o3M91sYd6vlBendyHU+YR1OKPuaKJqfyPFxkkhAhuotY2RQVMmcjhc9uXGly7+6Kn0xO6Z7jrJTNjdD9+YxJwuhIc5MGzSxok8p7Yxp37E5M2HnNEbqUvG2xPEaFTdX/1RxubvAXgRT54e7Ib13u0xyXHtNlreMh8PcR1jp9ArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCpuQYboU3pXabFPeV1peM0z/V21o4XxCAErBOzbggA=;
 b=fU+M/5CgdI3CFRQGFOqvwy84wqxVYF/8o6J2cHTlIFYwhp4Vaii6XRFgznho3v7W4z8NOkQ0bIP9q2adyLsDeuDWlkQr/rzU/UU0tQc0pQ+W5y9eUEC2zo/DLztKB/fslj1qJn+B4egz+ue0HDRnYrosQlgiklmG7OezdMJ938jriwbdhmBn027/BAhnovfEv4TrebD9YY047OFMxpn58HZuxfqcT16dGmt6WWVuWxNVXBw5KyTrKx6jpNogbXFVMYpdylJaLYUrG3fZO0nywLCTZEeJkRgc55hYG+jVgi0GPuiGMOjW3n594iGmr4nyfqFMypQHFPqHbQ5IRtB+Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 15:33:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:33:55 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Document task ownership state machine
Date: Wed,  4 Mar 2026 16:33:43 +0100
Message-ID: <20260304153343.340285-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8ef59d-6b88-41eb-b1a4-08de7a03726d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	odhsPmgF0K74ZeuB+EWGuxFqrs8umqGGVh3rL0jKhiOs7vykcZ+poP62aqTgocqSaK3zd76cwj4p252vzsIxo5vDQYTTXEFO4z8OJg/4meAlLxQFKj0jGPI+2QgxWamDwvDvwHKvfRiYYLbdBeFyuv9qmAcSoFAeSUodxN4pQR+lbtmWNw5ogG/70tgQAbyL52xzyIR40Wk6z954pXywplehRsh90BmRgzO+xVSzJx8qh6WBYk2EY/H5sASEW+xXZ3vK4BJ0dq8AKNF5q9yBHu4ZbTaIOj/V/J3gLBkqlbIphZL+JTA+BL1EfdeRxUgfWaYhOxiCUdYYKTQvl/u/7L8rCKJrLBDy09DceqR4d8sJKSjR/itQ+J24Qkidrx39CCKJnbIyeeoYlT20U3mtYtdHfnrZ7e0al9EWZs2UA/Nx2rqCZBI/lwDdQ/y0YzGYUz8tRZxtkbPl0uBU3xyAF2Xs6jxUHTmSHaWYC+zhML5RqihsjRnP2/f3faR/ep9LT9UR3kY1i2eZCzniUatsA2MWGF25FFmMf7fhpgDb8lhx0lT/J3OmVPU3gWbX8v6BrJV0CZSERcZXqeFf+jiRWpDNiHzQFJUzLLTBoZXWWJNrGD3G2S9CSmpgFGuLMSp6KRtvqUdq4O4VxYmBaCZDOdryB0cLvCwXXLeGTcVwLDRm/p5Wb3VYNCA/EN7qvX9va7b/tMHokhG034eqzGk5teFuQrbFVPwnsgLpxkieqeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJRHSAV+KOSFCpNm8u3wW2UCJQHUfxdou507F7IDY2F9QUZVAypmLHqZmC3m?=
 =?us-ascii?Q?CHtPBjp0OOkwgH/Aft4lFGwLWRAvvUJWKUWuF9bZXv9AOMsw9KkRf6ja+nyO?=
 =?us-ascii?Q?OHMlN4kZzlGF6lLht2hYhDyWsG+IhKJy4DanUAgUcnNV584hxMpbhfXYMSKn?=
 =?us-ascii?Q?pUaE0seJxyMrn9hS2AglWBQi6oOQ/AQ7AdGJNMDCZY8jryX8nVGxDlfNbSDX?=
 =?us-ascii?Q?opvDkXODuKGh2tvly1ocg/2G7Numw+7HsE8pKCVyMRELf6UkVMYirmlvy6Dk?=
 =?us-ascii?Q?vtkoZeyEpVKgoSbou2F0LZL0tJAboUSVJ9KeEvVasyythci1bujOZMTx8VQ/?=
 =?us-ascii?Q?X5cdqKNbWX8gKY13/HNUALoTik5zBbJub9NZT6JpoHOuSpw49ZqbY/4UXN0Y?=
 =?us-ascii?Q?BRcKL44ZWHsv5GLDgVhtySHDziuUyIIq7oWrssSOXr+yoM/GzhUUVlDO+O6t?=
 =?us-ascii?Q?c9OiREERBi7OixTmUZwtq2FeRUgRyJSB3dKZRQVM+Js/o2ereURkpMMllqCR?=
 =?us-ascii?Q?9/VgQgyM0C2Q7M+WpbGtLhFJoQY1mvIn5433/mnurAzVhvejiJcIsHylgmrb?=
 =?us-ascii?Q?nBohyufOhSkvvW1Cz3TgQAO2pGKGZHCy2zkF65Y5z42IIQOymjS9YNic879q?=
 =?us-ascii?Q?zRcY3YX7p1OtHLJ/JJYi2n0DYV9YGaCgbny2ZSYuZ5Xcrb7T6k6+BpCWDMrQ?=
 =?us-ascii?Q?Nd6ZGPgb7aklccVyX/5OMdptqfq4nK4dxIdIf0QdH4ZpUS+ZmtxTWyUyhwca?=
 =?us-ascii?Q?0LmbnOJ8nbzoVrVHhPwfyaEivL16UlJ+AA+ai0++eu2XQeOUYLPBXGygg+Sa?=
 =?us-ascii?Q?iz4PvldWjhkxfn+KpMWXhUUaqEGha/wUo5V5ggCxB9YRHllP0eZVOM6zwZCG?=
 =?us-ascii?Q?yFXQDRA9+yqMIId0a1gsREJPI0Qoig4h5KSc1no2Nyr3UEWEUrjXBMgbBrqH?=
 =?us-ascii?Q?ATWU91HbaILfNvEZM16kPnlaM6NLocibgnat/1Hp/L2ekbGB1BKBdefvD8wa?=
 =?us-ascii?Q?v09fhC1ME33insXnuuNPE1MwWQZskZ81Ka5erEZ8P3UDuSNZ1hkfro9pxnE6?=
 =?us-ascii?Q?IDji13ZBXx/S/GsF1D+muM/QaXausS20qy4AB7s38xn/OhDPlqRyXCi+xxza?=
 =?us-ascii?Q?YjStqWfguPfRrVDj7r5ibn6PSw881qeG+nOTYlD9cXzaJ+CdB2xJgZQp4NlE?=
 =?us-ascii?Q?ifrjFyyyFkyBeeT7IffRjwhl0TqZg0zeDtNvCl71PSJxavq1tkYrUkRICjCu?=
 =?us-ascii?Q?jZ+LidOiatmvFMl7tydDk4lWLkNBW6dXxbGTNPOwhnpWEQAt0a89SQ3x2XEI?=
 =?us-ascii?Q?g19rNKOUFcvtCCr0rgKlbijgpYWB2X9aNf+m9GSFaywZoo8M8hj/5shPcgVn?=
 =?us-ascii?Q?nXDbQhbequXSqnD5ZtSjnl4vMZCv4CgZwV/7kcKADZVhQeQIbARe83WEKznA?=
 =?us-ascii?Q?m4wFcNuH2JF4aWN7I07XpNK3LUDqnJEmVRYZAb8CoPy9Le19h4ipWgGOQoXD?=
 =?us-ascii?Q?4PMT2dOCO7G/g9ADYr0GAhu/ysWcwwtNVp4UJhXAhIBtFcWp0v5geeu+5VBr?=
 =?us-ascii?Q?Tlyzn5SPWkigoaSESnp+8B58sabhTQyxRjLgBWy6J6GMDRT2+kVn9i+RUl3Z?=
 =?us-ascii?Q?A6ljJRax1KATrArSRVZHBeBvq1hAWfF+K8nbvOgIH6T6Qh28bcMGIRbdIE8Q?=
 =?us-ascii?Q?205TACC8U8UgDSecCgrxZVsNCeLgAKP/7IMxxTGS5wzQTiC4SjFL0tgea1bZ?=
 =?us-ascii?Q?f+SJvNtdOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8ef59d-6b88-41eb-b1a4-08de7a03726d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:33:55.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lQfcAluZZ2gHp7StMSMi3vqm34RW+5WDQQ3JmtuJMJhKo0f0Tge8ZJjkLNQFkw9sve+TEiwkZeOs7bl6auTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

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
 kernel/sched/ext_internal.h | 119 +++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bd26811fea99d..d804e711de9c2 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1042,26 +1042,113 @@ static const char *scx_enable_state_str[] = {
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
+ *       |               |           ^
+ *       |      dispatch |           | affinity changed
+ *       |               |           | (dispatch aborts)
+ *       |               v           |
+ *       |          DISPATCHING -----'
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
+ *     proceeding. Exits to %SCX_OPSS_NONE on the normal path (dispatch
+ *     completes via lock dancing in dispatch_to_local_dsq()), or back to
+ *     %SCX_OPSS_QUEUED if the task's CPU affinity changed after the
+ *     dispatch decision: in that case the dispatch is aborted and the task
+ *     is re-enqueued with a fresh QSEQ so that set_cpus_allowed_scx() can
+ *     place it on an allowed CPU.
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
+ * If any verification fails, clear holding_cpu and abort the migration.
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

