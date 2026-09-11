Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265E58B6BF
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156731; cv=fail; b=U+9lyDEfAEBJg4caXMfhdj8uzcaaz7DNeshD/Du1DpCz4lDeKMrLInfxAfwELmiydPFUHvkcXWEKDKA2QYvrP2GcZ1/IjZZa7EV/Ykcb3tkGB3vHyXccE7MyxcMwJ0YXvi9U76AIqkX2M+VyuZGSJh6YOeYG43baKHh7V7Qg7iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156731; c=relaxed/simple;
	bh=AYE4gDf8aA9hJmpBe8EjgenKQbUIcuPadD9Lp5iRES0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNNAqeudspt5MAjnIY2pBtOxfIUF4lxjBIDOwFKKWxED59ln6db3RZ+ZuypvXymKePXudofhC0egCR8mveCbK9eoIVRm+F5CbzNG5CqesmjhSXxMr+Ug9qiff+4c6/otjrVSHWaZOSiemaoXGi3ozIN0ybnbhoeSIvmTxwsqyFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOUknG2b; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOUknG2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOihWl5GUqo6QFfiPHD8CBw7JTayf42Sd0jtEG96qGqlR/s2kZvzSq9XbfI4qq7qLT9cxVxDmPKknnslLTDFewIY4uWdMBnD5lsQ/Ahzl+r6xyy1BtwGekKb4JNQombqMRik+aA9PhLwQ4EJi9sAq8njScX6XqOKUxqGeyJqCTFAPeUF0tXSzZFHfX0eIqqgKIMlAv037+Gh7+fuzQNxRruoChnqEK9GGHakG4pZz9uovRCCgOB26PCLvNTMQK7/Mo5Rxra6iI8n3vOOuXwUD5SlbJJji1zh6OGK47L2pmC982nEkFaGH+x9Sf7JBUwTTiBPW//TiQ9AN5oQXM2iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSOt4x9H4p9gfEjHpZHn/LkSGSSU1WoyWyNdUNb/hGQ=;
 b=xWcTrlmkOvEmnHw4I5ogyG2WsJaSP0pReDoV5ia5bLL3VHJOmmZ5kIb7efhZpuq9OTJpOlSrANFQaNDocMxu6YuSoz00/gVhmQxu6eJjM8/GbVOGmPBlNGXKMsNyJh1yYy90JJl2IWlgYpMAzyguxXkfQ0HMQWQQURJYbs//T25NNPH9etOdPcrmb5iTcREtyPzPz/fnv5UtSB8+s6q8D33rvrLKQdvTbvixjX9dJQ8w8DOTx5IZoqCTgVWkzQXmQmRGh8bVFdzV4RPauhAfWb1Yr6f5jgC5llpFhDesDLdPMExzAfQEZAJXgdiav3KeHxznmsbmeW3ur+dM1XD1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSOt4x9H4p9gfEjHpZHn/LkSGSSU1WoyWyNdUNb/hGQ=;
 b=jOUknG2bFzOb7W9csR1xk9jKEgHhA0STet8BR+3+62cwg+P8o4+FSAopi0+LehOPxrhQPYr/PglMxhzOjMFeo4Bg2ISHhVEy/hdGA+EDETlbNh5qhs35iu+NMIA7iPezvaQhsWKSAjgb3yWB9Voavy58SI/xW72kaLHOCacOfSbCy/CIwgY+enwFgaDJThkiSnSKMxPrq4CkDt2OHBPl1faNoEEAFe84a6Vx+cfV91Hgkn0WxYnt5s/45Xq+RPQsoAS1x1anAE3OcrnU8DiCG52XJaIZUBTBYU/+/QpuSx/angtrPiMG3+wtdoNau7HJFxmZTGJCnpOq2PFur3qrjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:58:21 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 19:58:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Fri, 11 Sep 2026 21:56:53 +0200
Message-ID: <20260911195800.974364-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911195800.974364-1-arighi@nvidia.com>
References: <20260911195800.974364-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B87.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::405) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3e2455-b363-4a54-c9db-08df103f0798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5e61C5fW75ofQ03Nm3hAZXSuJz4w5JgkzDLQnE4ydyl389g09SpHOwIjS3kMzIuNX2YgXwQakkup3oP+8TuNe4m/hwC5KMrIJAWNnwPGQWqEQulbJvArBoupG2hy69gv6cNlDBhD211Au8Zdll4Z3g0zocoDRXH6bKFCVCJxP998/wLqjRH7pCv4n5cioJkB47B9ZbOvMNc7rvbEcHBYXWa6xoQUO2unitxSukCEp4u3qljErO6VZViuj4jldvSCdzupNxcavRdhjF08HXbBkTfkxppi5AWxE10TJJeBhfwbtLsALl3+4XXSpblagUs3KEk82yX27I7JRzzhnix8OIWfQnaJzNw36jfDHgPEReeX1b7XkFMMXnEzJewRLID2W//uqjRYvF4uGvo1ccezlreWycoPkWhpVvMbQJ8t13qgTaA2w7BB/H01RAdca877XP4i7O4stuLfma+cBvwDiGTax5Uu/qax5O09pwbb0X9X2s1M+xU3Sh8mj5gqRmkQWd/EUypTyrjTrjV5FAgFCteuBKLUvtNhJV7CxIrZbhmqLyh9aEzGlos9hKVeVFjBTbVGSgJfSn+msQuoi4pO21yBqrlRdjrH1dQCnx6vui7IAhSnkFIjfZvytXl0E4EGbpsEOzumgLF7uT2VT96qSlAPsYATnD7r8KHx/ejebbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O05hXDgb3rHrT4UDuF1wDy59L0bTK8PuyvxGbvN4HemdfCCzc7wVLumg3s2/?=
 =?us-ascii?Q?rrZM4T94OJjZAWe46vsYdM1Z4hg6ev9huJ1BtTBqiJgvoodJf+YSg4WhqEqf?=
 =?us-ascii?Q?iI4Y8zSSxPTQE76yqHcYJWAdY+NzroGHt75McMmQPrC1omQ0rdg7t8IaBwVv?=
 =?us-ascii?Q?sez0k6xLgCSkmpgH/AGMEVnL8PUKPktqWHOsyIlbqkrQ73M0g3E/b0QwLyO5?=
 =?us-ascii?Q?0aGS29hxuPLfWJv7ghzg+MMIrhcXN+abhj9y1OlfLKIPACNIOANDQNtjGTPW?=
 =?us-ascii?Q?oAapN6Le5Bjt8FRTZDw8an5+OP2zE8fpNwlVXkf13S+jhy06QdYGuqQ3wbvW?=
 =?us-ascii?Q?5w7iFzpmofaZTJqV+9Nmwy3EWIlV9+RGaE76Ro2BnpiQh1p7w8Y1hk0H+Wgt?=
 =?us-ascii?Q?1ToIVSZFZcl+7bVafGYWiMMSuiPs4y1cs35GVFeGCJ4xGNLqtBskElmO0asx?=
 =?us-ascii?Q?0PV4s7tf7Qe75w44c/Y/ay4AeNT5GDNRX6PvI/aPnsDsO0Wkuazrxx9IGM+7?=
 =?us-ascii?Q?kpXogRwDMAEs6Filo3aVNHnaG2fM1lcee4/d5Jd2MtJoQtQUmofFzoOr1ewV?=
 =?us-ascii?Q?85odvPmsyULsVKOpDff/wopJDap3/P37VvA00swmmwmqXJS0Kff8toSYHDDK?=
 =?us-ascii?Q?wMPGxXQUM9ysZcl00IzcDYUk0dmqP3WmHxMsHwsoFArgyoOd+sNKDoTcAFCA?=
 =?us-ascii?Q?VdAGKkZ78LEXWXm9Qi9X6jYONjHUAWGRr40PI0uypM9d9jIClyH1YJzIkxAA?=
 =?us-ascii?Q?Mjg1NcyXjz+ewsLo39L1bbWXI+a8UQ6PYFv0gebHPL5tKCZP4/fpIvAGvT/u?=
 =?us-ascii?Q?8PhCaYwPh0kDXAlJ0yulzO+nepMwD6M1G9GMweC/NFXEcNfoonh5peNWkbqQ?=
 =?us-ascii?Q?GIEhrxv7yogSC5Rj3LH+hnUDvk7a7RnRp91J4MFAVW/+NYowBRkxuLwuznae?=
 =?us-ascii?Q?IYocGRJp1tM9bTtujido5btQrMK5RaajuWRCIKLvARzVImtk95jtO4I4xXd8?=
 =?us-ascii?Q?fXSy20mUrFM4mUvoxlXcJZzoUCvOC3myOHvf2iFIXzMCm5hdMVzM7ft/psmX?=
 =?us-ascii?Q?f5MiYVkQ2y0kAtKqx8yMpZwXSsI5r/ShhcFdHqPCiTV/0SfH3L/BoTuU3stP?=
 =?us-ascii?Q?vNVUYafwmuXp7hT0ivlDVkpb9Po0EasvfGvJRfiffnQEHnYs1+/n00bteMlS?=
 =?us-ascii?Q?fvKHRlJgcyl82tZk9xOywMQX9Ea3bauENymxGzfKcFMop8P2vrJfqboguvBw?=
 =?us-ascii?Q?F4NQAezUdQpSjKMX8V/wA0Eui3hdnxm3xVkxwgFFqSY6yj350ID9oKyNJCk7?=
 =?us-ascii?Q?hnPTaBolTqYs7UL9zEaSJcRJvCHk0zLarcmPkYLEXxq/IwMeaYYOghj5hyVI?=
 =?us-ascii?Q?2h+RJl6dc4RGk1+/ZrjYuSxd4QtpVmjWToWGPHPpwZMQ80pO1uieTxw0qvtQ?=
 =?us-ascii?Q?3MnlMpb1GhUv056ZzsI796jwdzdL4i9WYKSF7eOKNQbv+X6uGQclHa+o7bkw?=
 =?us-ascii?Q?7iWQ9/yVP9pKot+glE5Ax5K6dYqlVPNhkDE345qKQoL8VXlsmrQ0dafKPEjB?=
 =?us-ascii?Q?/J2NriCNp0EuLWd6lzpkIXvwQFhahj4gQmpKLf07SFRPmXCOb0MXgS+90iqN?=
 =?us-ascii?Q?lO6Cjo0f77Bt7EWnEQfsELqUAd4RfAO79zehdW0oyc/lOoYFSnECRaJd7U2j?=
 =?us-ascii?Q?PpNGUX6OOlelnRwrVAv1G0QqOQGvadnBUiWl7XJZ8RNDCU22WJSTDtDl5LwC?=
 =?us-ascii?Q?fB7DviHfaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3e2455-b363-4a54-c9db-08df103f0798
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:58:20.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvjLCNEMFE1RdEejx68LK1GtrW3tCJoUvmJpIJyyD9/YrXlRYqHaCqpjFimeKM/HHFWYQy6nB5RE8muGITT7HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

The fair scheduling class supports lazy rescheduling: when lazy
preemption is enabled, a lazy reschedule request does not preempt the
current task immediately at the next kernel preemption point. Instead,
it is serviced when returning to user space or promoted to an immediate
reschedule by the next scheduler tick. This avoids unnecessary in-kernel
preemption while still bounding the scheduling delay.

sched_ext only supports immediate preemption, so BPF schedulers cannot
make the same trade-off.

Add lazy preemption support to sched_ext through SCX_ENQ_PREEMPT_LAZY
and SCX_KICK_PREEMPT_LAZY. Both operations still expire the current
sched_ext task's slice, but use resched_curr_lazy() so the scheduling
boundary can be deferred when lazy preemption is available.

On a non-local DSQ %SCX_ENQ_PREEMPT_LAZY means a head insertion, as
%SCX_ENQ_PREEMPT does there.

fair.c also expires a slice lazily: update_curr() calls
resched_curr_lazy() when the slice has run out at the tick. Let a BPF
scheduler opt into the same with SCX_OPS_LAZY_SLICE_EXPIRY, which makes
task_tick_scx() request lazy rescheduling for a depleted slice. A task
in user space still reschedules on the way back from the tick, a task in
the kernel runs on to its next return to user space or to the next tick.
The default stays immediate, as does rescheduling while the scheduler is
being disabled.

Reject requests which combine immediate and lazy preemption. Also reject
lazy kicks combined with SCX_KICK_WAIT, as waiting for a lazy scheduling
boundary would have a potentially unbounded contract. Unknown kick flags
are now rejected as well, where they used to be ignored.

Track lazy kicks in a separate mask, outside cpus_to_kick, so that a
lazy-only request can be told from one that coincides with a plain or
preempting kick. An immediate preemption supersedes a queued lazy one. A
plain kick reschedules at once, but leaves the slice alone, so a lazy
request next to it keeps clearing the slice while the reschedule stays
immediate: both are served.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c                        | 115 ++++++++++++++----
 kernel/sched/ext/internal.h                   |  36 +++++-
 kernel/sched/ext/sub.c                        |  15 +--
 .../sched_ext/include/scx/enum_defs.autogen.h |   3 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   6 +
 tools/sched_ext/include/scx/enums.autogen.h   |   2 +
 .../sched_ext/include/scx/enums_abi.autogen.h |   5 +-
 7 files changed, 149 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4080902a528cd..a918e3ade1148 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -383,11 +383,11 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 		return true;
 
 	/*
-	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
-	 * so allow it to avoid spuriously triggering reenq on a combined
+	 * The preemption flags clear $curr's slice if on SCX and kick dispatch,
+	 * so allow them to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
-	if (enq_flags & SCX_ENQ_PREEMPT) {
+	if (enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 		struct task_struct *curr = rq->curr;
 
 		/*
@@ -1577,12 +1577,16 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+	if ((enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0)))
-			resched_curr(rq);
-		else
+		if (likely(scx_set_task_slice(rq->curr, 0))) {
+			if (enq_flags & SCX_ENQ_PREEMPT)
+				resched_curr(rq);
+			else
+				resched_curr_lazy(rq);
+		} else {
 			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
+		}
 	}
 }
 
@@ -1672,7 +1676,7 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 			/* new task inserted at head - use fastpath */
 			if (dsq_insert_head(dsq, p) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
@@ -2386,7 +2390,7 @@ void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		dsq_insert_head(dst_dsq, p);
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -3804,8 +3808,14 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
 
-	if (!curr->scx.slice)
-		resched_curr(rq);
+	if (!curr->scx.slice) {
+		/* see SCX_OPS_LAZY_SLICE_EXPIRY; the slice can't be trusted while bypassing */
+		if ((sch->ops.flags & SCX_OPS_LAZY_SLICE_EXPIRY) &&
+		    !scx_bypassing(sch, cpu_of(rq)))
+			resched_curr_lazy(rq);
+		else
+			resched_curr(rq);
+	}
 }
 
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -5371,6 +5381,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 
 		exit_dsq(scx_bypass_dsq(sch, cpu));
@@ -6883,6 +6894,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (!cpumask_empty(pcpu->cpus_to_preempt))
 		scx_dump_line(&ns, "  cpus_to_preempt: %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_preempt));
+	if (!cpumask_empty(pcpu->cpus_to_preempt_lazy))
+		scx_dump_line(&ns, "  preempt_lazy   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_preempt_lazy));
 	if (!cpumask_empty(pcpu->cpus_to_wait))
 		scx_dump_line(&ns, "  cpus_to_wait   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_wait));
@@ -7200,6 +7214,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		if (!zalloc_cpumask_var_node(&pcpu->cpus_to_kick, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_kick_if_idle, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt_lazy, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_wait, GFP_KERNEL, node)) {
 			ret = -ENOMEM;
 			goto err_free_pcpu;
@@ -7335,6 +7350,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 	}
 	for_each_possible_cpu(cpu) {
@@ -8462,10 +8478,20 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	const struct sched_class *cur_class;
 	bool should_wait = false;
 	bool kickable;
+	bool preempt, preempt_lazy, immediate;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	cur_class = rq->curr->sched_class;
+	preempt = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt);
+	preempt_lazy = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt_lazy);
+	/*
+	 * A lazy-only request sits in cpus_to_preempt_lazy alone. Any other
+	 * kick for the same cpu, plain or preempting, is in cpus_to_kick and
+	 * asks for an immediate reschedule; the lazy request still clears the
+	 * slice, the immediate one still reschedules now, so both are served.
+	 */
+	immediate = !preempt_lazy || cpumask_test_cpu(cpu, pcpu->cpus_to_kick);
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8479,7 +8505,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 		   !sched_class_above(cur_class, &ext_sched_class);
 
 	if (kickable && !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
-		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
+		if (preempt || preempt_lazy) {
 			if (cur_class == &ext_sched_class) {
 				u64 caps = scx_caps_for_preempt(pcpu->sch, rq, 0);
 
@@ -8488,7 +8514,6 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
 			}
-			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_wait)) {
@@ -8500,14 +8525,20 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 		}
 
-		resched_curr(rq);
+		if (immediate)
+			resched_curr(rq);
+		else
+			resched_curr_lazy(rq);
 	} else {
 		/* a kickable cpu was skipped solely for the missing caps */
 		if (kickable)
 			__scx_add_event(pcpu->sch, SCX_EV_SUB_KICK_DENIED, 1);
-		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 	}
+	if (preempt)
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+	if (preempt_lazy)
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 
 	scx_rq_lock_drop(rq);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
@@ -8566,6 +8597,13 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 		}
 
+		/*
+		 * kick_one_cpu() clears the lazy bit of every cpu it visited
+		 * above; what remains are lazy-only requests, see scx_kick_cpu().
+		 */
+		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
+			kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
+
 		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
 			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
@@ -8734,6 +8772,11 @@ static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 *enq_flags)
 		return false;
 	}
 
+	if (unlikely((*enq_flags & SCX_ENQ_PREEMPT) && (*enq_flags & SCX_ENQ_PREEMPT_LAZY))) {
+		scx_error(sch, "SCX_ENQ_PREEMPT and SCX_ENQ_PREEMPT_LAZY cannot be combined");
+		return false;
+	}
+
 	if (*enq_flags & SCX_ENQ_IMMED) {
 		if (unlikely(!is_local)) {
 			scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
@@ -9539,6 +9582,24 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 
 	if (!scx_kf_allowed_ctx(sch))
 		return;
+	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
+			       SCX_KICK_PREEMPT_LAZY))) {
+		scx_error(sch, "invalid kick flags 0x%llx", flags);
+		return;
+	}
+	if (unlikely((flags & SCX_KICK_PREEMPT) && (flags & SCX_KICK_PREEMPT_LAZY))) {
+		scx_error(sch, "SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY cannot be combined");
+		return;
+	}
+	if (unlikely((flags & SCX_KICK_PREEMPT_LAZY) && (flags & SCX_KICK_WAIT))) {
+		scx_error(sch, "SCX_KICK_PREEMPT_LAZY cannot be used with SCX_KICK_WAIT");
+		return;
+	}
+	if (unlikely((flags & SCX_KICK_IDLE) &&
+		     (flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT)))) {
+		scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
+		return;
+	}
 
 	local_irq_save(irq_flags);
 
@@ -9564,9 +9625,6 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
-			scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
-
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
 				scx_rq_lock_drop(target_rq);
@@ -9577,11 +9635,25 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 			raw_spin_rq_unlock(target_rq);
 		}
 		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
+	} else if (flags & SCX_KICK_PREEMPT_LAZY) {
+		/*
+		 * Recorded in its own mask and not in cpus_to_kick, so that
+		 * kick_one_cpu() can tell a lazy-only request from one that
+		 * coincides with a plain or preempting kick. A queued immediate
+		 * preemption already clears the slice and reschedules now,
+		 * which is more than asked for; a plain kick doesn't touch the
+		 * slice, so the lazy request must stay recorded next to it.
+		 */
+		if (!cpumask_test_cpu(cpu, pcpu->cpus_to_preempt))
+			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 	} else {
 		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
 
-		if (flags & SCX_KICK_PREEMPT)
+		if (flags & SCX_KICK_PREEMPT) {
+			/* an immediate preemption subsumes a queued lazy one */
 			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
+		}
 		if (flags & SCX_KICK_WAIT)
 			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
 	}
@@ -9623,8 +9695,9 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
  * scheduler via scx_cid_to_cpu(). Caps are enforced on the delivery path: a
  * kick is dropped if the caller lacks baseline access on @cid, and a
- * %SCX_KICK_PREEMPT degrades to a plain reschedule if the caller lacks
- * %SCX_CAP_PREEMPT for a task outside its subtree.
+ * %SCX_KICK_PREEMPT or %SCX_KICK_PREEMPT_LAZY request degrades to a plain
+ * reschedule if the caller lacks %SCX_CAP_PREEMPT for a task outside its
+ * subtree.
  */
 __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e1eb3a0d456cb..0b38f84353eb8 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,17 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, a slice that runs out at the tick requests lazy rescheduling
+	 * instead of an immediate one, the way fair.c expires a slice from
+	 * update_curr(): a task in user space still reschedules on the way
+	 * back from the tick, a task in the kernel runs on to its next return
+	 * to user space or to the next tick, which promotes the request. No
+	 * effect on kernels without lazy preemption. Rescheduling while the
+	 * scheduler is being disabled stays immediate.
+	 */
+	SCX_OPS_LAZY_SLICE_EXPIRY	= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +234,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_LAZY_SLICE_EXPIRY,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1327,6 +1339,7 @@ struct scx_sched_pcpu {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_preempt_lazy;
 	cpumask_var_t		cpus_to_wait;
 	struct list_head	to_kick_node;
 
@@ -1407,15 +1420,16 @@ struct scx_sched_pnode {
  * the allocation pattern.
  *
  * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
- *            - kick the cid's cpu (except SCX_KICK_PREEMPT)
+ *            - kick the cid's cpu (except SCX_KICK_PREEMPT and
+ *              SCX_KICK_PREEMPT_LAZY)
  *
  * ENQ        insert any task onto the cid's local DSQ (implies ENQ_IMMED)
  *
  * PREEMPT    preempt any task running on the cid regardless of the owning
  *            sched (implies ENQ). Preempting a task in the sched's own subtree
  *            doesn't require any cap.
- *            - SCX_ENQ_PREEMPT inserts
- *            - SCX_KICK_PREEMPT kicks
+ *            - SCX_ENQ_PREEMPT and SCX_ENQ_PREEMPT_LAZY inserts
+ *            - SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY kicks
  *
  * PERF       control the cid's cpu power/perf management state, currently the
  *            cpufreq target set through scx_bpf_cidperf_set(). Hardware
@@ -1685,6 +1699,14 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * Like %SCX_ENQ_PREEMPT, but request lazy rescheduling. The current
+	 * task's slice is still cleared immediately so that the next scheduling
+	 * boundary observes the new ordering. Implies %SCX_ENQ_HEAD, which is
+	 * all it means on a non-local DSQ, as with %SCX_ENQ_PREEMPT.
+	 */
+	SCX_ENQ_PREEMPT_LAZY	= 1LLU << 35,
+
 	/*
 	 * Only allowed on local DSQs. Guarantees that the task either gets
 	 * on the CPU immediately and stays on it, or gets reenqueued back
@@ -1811,6 +1833,12 @@ enum scx_kick_flags {
 	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
+
+	/*
+	 * Like %SCX_KICK_PREEMPT, but request lazy rescheduling. This cannot be
+	 * combined with %SCX_KICK_WAIT.
+	 */
+	SCX_KICK_PREEMPT_LAZY	= 1LLU << 3,
 };
 
 enum scx_tg_flags {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 380a5653dc529..a88b87614b55e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -686,9 +686,10 @@ void scx_rescue_init(struct rq *rq)
  * rescue is enabled, or @rq's reject DSQ after recording the reenq reason on
  * @p.
  *
- * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT and %SCX_ENQ_HEAD are cleared when diverting
- * to rescue or reject. %SCX_ENQ_PREEMPT is also cleared on a fallback
- * migration-disabled admission.
+ * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT, %SCX_ENQ_PREEMPT_LAZY and %SCX_ENQ_HEAD
+ * are cleared when diverting to rescue or reject. %SCX_ENQ_PREEMPT and
+ * %SCX_ENQ_PREEMPT_LAZY are also cleared on a fallback migration-disabled
+ * admission.
  *
  * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
@@ -709,7 +710,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * On a remote activation the scheduling sched (@asch) differs from
 	 * @p's owner (@sch). Check caps against the scheduling sched.
 	 */
-	if (*enq_flags & SCX_ENQ_PREEMPT)
+	if (*enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		needed |= scx_caps_for_preempt(asch, rq, *enq_flags);
 	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
@@ -726,7 +727,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	if (unlikely(!scx_rq_online(rq) || is_migration_disabled(p) ||
 		     p->migration_pending)) {
 		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
-		*enq_flags &= ~SCX_ENQ_PREEMPT;
+		*enq_flags &= ~(SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY);
 		return &rq->scx.local_dsq;
 	}
 
@@ -735,8 +736,8 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY |
+			SCX_ENQ_HEAD | SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 63b6b14b19bd4..f1554c22071ff 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -85,6 +85,7 @@
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
 #define HAVE_SCX_ENQ_PREEMPT
+#define HAVE_SCX_ENQ_PREEMPT_LAZY
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
@@ -148,6 +149,7 @@
 #define HAVE_SCX_KF_ALLOW_SELECT_CPU
 #define HAVE_SCX_KICK_IDLE
 #define HAVE_SCX_KICK_PREEMPT
+#define HAVE_SCX_KICK_PREEMPT_LAZY
 #define HAVE_SCX_KICK_WAIT
 #define HAVE_SCX_OPI_BEGIN
 #define HAVE_SCX_OPI_NORMAL_BEGIN
@@ -164,6 +166,7 @@
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
+#define HAVE_SCX_OPS_LAZY_SLICE_EXPIRY
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..2cec24beb2d80 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -109,6 +109,9 @@ const volatile u64 __SCX_KICK_IDLE __weak;
 const volatile u64 __SCX_KICK_PREEMPT __weak;
 #define SCX_KICK_PREEMPT __SCX_KICK_PREEMPT
 
+const volatile u64 __SCX_KICK_PREEMPT_LAZY __weak;
+#define SCX_KICK_PREEMPT_LAZY __SCX_KICK_PREEMPT_LAZY
+
 const volatile u64 __SCX_KICK_WAIT __weak;
 #define SCX_KICK_WAIT __SCX_KICK_WAIT
 
@@ -121,6 +124,9 @@ const volatile u64 __SCX_ENQ_HEAD __weak;
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
+const volatile u64 __SCX_ENQ_PREEMPT_LAZY __weak;
+#define SCX_ENQ_PREEMPT_LAZY __SCX_ENQ_PREEMPT_LAZY
+
 const volatile u64 __SCX_ENQ_IMMED __weak;
 #define SCX_ENQ_IMMED __SCX_ENQ_IMMED
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index e616326545172..dd762ee0ddb36 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -40,10 +40,12 @@
 	SCX_ENUM_SET(skel, scx_ent_dsq_flags, SCX_TASK_DSQ_ON_PRIQ); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_WAIT); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index d53899764f5ac..672c02a497d14 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -97,6 +97,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_enq_flags", "SCX_ENQ_HEAD", 0x10000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_CPU_SELECTED", 0x100000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_PREEMPT", 0x100000000LLU },
+	{ "scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY", 0x800000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_IMMED", 0x200000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_RESCUE", 0x400000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_REENQ", 0x10000000000LLU },
@@ -160,6 +161,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_kf_allow_flags", "SCX_KF_ALLOW_SELECT_CPU", 0x20LLU },
 	{ "scx_kick_flags", "SCX_KICK_IDLE", 0x1LLU },
 	{ "scx_kick_flags", "SCX_KICK_PREEMPT", 0x2LLU },
+	{ "scx_kick_flags", "SCX_KICK_PREEMPT_LAZY", 0x8LLU },
 	{ "scx_kick_flags", "SCX_KICK_WAIT", 0x4LLU },
 	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
@@ -176,7 +178,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE", 0x40LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x1ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

