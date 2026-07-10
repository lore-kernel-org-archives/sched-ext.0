Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784053EFFDB
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672803; cv=fail; b=AizH/K4dGYislhbfWPTJoUmxy0ZI1xAYTPj/MSMVAp2faQScBRARKuFrZDpxSE0cxFatWfQ3TDG1OB6y/2ZNp7QVPjYOUYpfNGnBVWK05F6U8AuhVMj7lC7R8X7NpGEzMsj5wk+ddAle2gTnysmVX7pUDoNVU3fZaxLJ0xP4sL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672803; c=relaxed/simple;
	bh=wObnTi21cGCTILTxj+7p2nwGtiDBMhJXgRSfVWqHM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGqGZghjjYpaEEcImMM/DyMV9VEzKXOnIISGVMN/fmvQof85YxMqV794Pkvf3o0XwRKAb/3budBhpYnBWT0tDqaEoR/PMcaTUivjs9Gz3hJSCfUEy03xydEESj7pXsGJXPT9fQjL70ASRbtjgmLEcSF6imek4FIvx4rgXv/8AtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/Glty22; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/Glty22"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzDjTSvwiKJKp7HvAJdw5nBrIHCfhIwb2sUKLAEdc/ihR+pZk9LW3NcGQlC6BofqGR8l5ZJ4RpVMOPjWS0Jyf7AHE/VMKG0EHNeBxFBBGNySUfeghBnTLgSzkyIn59v2WZqO/JLQ5/SueMSJa34la6MlrE34mZRoODUWOyRHR9ikZ8TMavP45Me9ZSPEC4Xm6HmZPKbNF+4diJTr3Sg0kXbRoZIschIwD5PGXmimWgnmqS+sDa6sUxXAN9caxXRp6IuBLptJQPpmuiGjykvM7Rt39iuNiKRo/4QHnZmqIVKd7LveQgpNb8AA6AEWc4xWJrZKgkWp0tm8sMZ4uFi/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR4krANdzlhG88LPOLKSElhWan/TUM4NlDch1VV2GL4=;
 b=cG01ymFDY0JLU/eBywi1kXE057qUFnva39Smf31A85daGjzG+ExsczcJzkmB9Caw9REy0yNmRxO4rfsCPnH/drOnn8af4NAYarplyLp6Q3O0jiPGR3+A6RlwT0yHfuP0KCfLoLN+p3yXqRrCEvsFex2xGpTQrcsapZwMNDUvXddmaDAHoB87hkFPYspCMWRyOvmiVxzgMcjZE2rs68H7omPmvqBtIh/mZZUjCZpOQuDFExP6MGlujzdgtFYV3CE/6aS4VTlFUvrNJlZHgxsASvI8cWiC+S6xH2BI0tsACDrnQeRFtyCuQetRHSADYuIreE7iERW7QvEIeFb689PgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR4krANdzlhG88LPOLKSElhWan/TUM4NlDch1VV2GL4=;
 b=t/Glty22rqn5vqyIm3npedD/35PsvT/itY3tjIC6CmPtxLfy1Lhhq08C2gcmTPfO37gm655LMfCOuU3lFnWf6pwTtxjOKU70GhKsr5BH01BUPBhgK9f10EFklqaoZXJI65JgFiuqtJjg/ZUEoygO756Nj8mkZNnMHeMSsTJ+fj1mrLwgbIUr4RPBRhrDhTYTtKj5Z49dxz9aacjuetntAI29Ri26kunMlPXQCulqsyLDQrdW0ypZ51ofxLyyeNsmHSIckfKNS18bELyOw637y1cA1BvgA6Ind4mc0G7FLHMpvzqmFlxRhijErqAR5dTTvIqIEmJqqO+HEaBAWpImwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:39:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:39:54 +0000
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
Subject: [PATCH 04/10] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Fri, 10 Jul 2026 10:36:28 +0200
Message-ID: <20260710083913.30573-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df8d9d4-0b04-4269-af14-08dede5ed0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dUDvsO+Kre3O2hUseUSMS7d8NKyvR46R+K4hMQTjCZPQUf2N+oJNZnJExAoi0WLrbKUy4GKf2EwP9MAAfIXIfQbEwtCf1ybXRZNw2jWW48WIEsY5LId+y3LPfnkmDNN/0fAT/noDdQoubX0SXAxKmI1WfsbMLOKT750PQGL+YjXN3zQoqyGcF9mu7wYi9ZUbW1/dKr8LNVFGp91u96C4RjhTOW17zzeDQtDg2thJ7eEX4eunwBS6R6BujAeHgGnnyHYqHrkMimjJv6XNe7XNAjkqt0EwezhZnmomgBwj3XcTgbNqAMmzJ2LuIhjnJznp+4Yq076KPx3i4gsPw7yXQ/NFaR23g6PbAgnUg2dBLmY0et2iB3bnE7YUPv8AiharFx9bnTywwwLysIO8PXZ7F3IOoDMCoCtZgI/eE0nDqcuFbL0LQ37EKklnIQv2JXrnugj3bypYEptc3B2/xj+Cm+Tg13FRsXoLNl5TEYZgnmzUV2cAsVwHwomi+i9W5sHKX5dwNW0OpNkCZVAUUaSG8PQxoRQVXxuSdcHpbtn8MxfovB9B+AmdDr/ToVz65VfGtJxpqdEKjPfssksRXO8CdzNmVOXZocecSnzyaug83ZG6dvcovo93Sj3HMM/16XWn7dYnnErHDtSFNXXqh35Fetvh0sx4KdYAKdDq16y+FaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfVis6xzR1iIRbgA+/2bbTmbkN+a4+uz65ij6Pvc1aF451ql9e29WWs674lH?=
 =?us-ascii?Q?7OMy8fD8OK1fy4Kzot6Lxy5TzwO+n573zDe0QlmcsTlir1Jmmko2S+nTmLtu?=
 =?us-ascii?Q?z05nBb5io1oZKv/Zr+9yYUtYj8eeQQfziTcCrPYZdVk5APFw9U/peEeJbF66?=
 =?us-ascii?Q?E0JlMWUrCT3je9WxZtAthQEYVgu9MubnvB+UTlbjQsxY1ME2JfRMeOBAA7yx?=
 =?us-ascii?Q?N3QltZoVxSiMIkNqiawOMpRp2utq6OIGVlvw6CVib/bPxIKNGHAEI6kFgLvF?=
 =?us-ascii?Q?yP9AnPryud6iuhgizVzaGmgyp0MWqYkxiaxVlSNvpLfrhxs6M2Usa0NsA0eb?=
 =?us-ascii?Q?/yPYNb8BOZKEaCwY3daMFjgMmDykDtMK7I7/lEfQD8sPVr7rVjzzbU4dU1ki?=
 =?us-ascii?Q?yS4NS6rA1WPlpPmsqqMg1sn7ORX5YGwI2oLQ1J/JVJkjleDSIKqCPloaRnFR?=
 =?us-ascii?Q?0drPQs7ghcJi+rMERBKOyassazEAt2sjww1FVVVTpRcpQ9KHnOXrQf0a17PX?=
 =?us-ascii?Q?rVPfCVLlAh08eVlksFbRtLcgL8rOuGQhyv4g49iyJOqJn2cM6tC5xorItt+H?=
 =?us-ascii?Q?bsIibsW/rMf5kBU2rWuNT6h2e74CLjcnhwabwO6p8WGOcXAqvnJh5BVYVXQP?=
 =?us-ascii?Q?aIpw99/QBhxlZ1q146EqUvH/IYba2H1R+JL/qRLqww40U8+8c1Ht9e/1hHAk?=
 =?us-ascii?Q?/CwVcz4N7m5msqPfHNqRHxiJo6Rrvyzj3dl+0/dEG+ONATvxoNEBPw3qCGav?=
 =?us-ascii?Q?2+PfJ7kYLrlxpuZAsytBnzpLsSMvbQf8n4J+nGgOzwSjrEayL/nWmOZ0tvIA?=
 =?us-ascii?Q?4yzCgcAdYchF16ZHe1c6ScD8YGmr1dVWZ1UmNAVzd96nWOH97xBc5rEzZlWX?=
 =?us-ascii?Q?PEjW9nEwJUmxsZrGlW6Tfr++4fYvSCCxZoBIjvrnvx+wownxpWQcvBBzz1QL?=
 =?us-ascii?Q?UizQMFDlpjWfRpROLbNaKaO5hA7fSTFodm8DP+SeVYLW0FAjc9wuzoyWSTwZ?=
 =?us-ascii?Q?zhB+SXrzJm93V1w55GbtmdrNW8XGjwdt0qVRJsrpLRiy70ccFMlASskT1qyF?=
 =?us-ascii?Q?tDDIp+zNRU+B6+DiRahzfXfe/ytaTISeC8A3NSKvYClr7qJBGMMFr6boIGSS?=
 =?us-ascii?Q?7F6slTUNFZMak7Y3LArejfTdotg1Zg29nIywF4wWyZdrqbnUxKhazjLk/AYd?=
 =?us-ascii?Q?ybDpPEq0YSPUV5N8hpULvKcoubXnmWC37XcOlO8a+93sUYTbfpSQLIdLx7av?=
 =?us-ascii?Q?0IEntzZRYzTsanFfOpzzZaP7GCWcCcypn7NstGdOfyVyl4G9uuPHrU4j5FfV?=
 =?us-ascii?Q?3cL5rmUGFPdcuwp61PrGo3jMKvfU/jQSJbvKfbDm/NnHDTP4KbMxC/K4r/5u?=
 =?us-ascii?Q?wVBTaY9LTU0DvtOm4Qly+azUH9fRDMJmthjJr/mpbkczEu2Ul2lz2jucxMQV?=
 =?us-ascii?Q?fb2RfEldiYF4u+L1M7CY1JEsgpELscphYeR6TiYhkXmQbiRQwLk3Elkb/fO/?=
 =?us-ascii?Q?5XT2t0RUokyMALzVe1ByXNz1KOPYFxFTuTQoVg5VBPQkceFMGp1LjKQrtt9X?=
 =?us-ascii?Q?BWfZ23Gn36Gd2gcoAq2iiRGcASASuOZp3kH2WJyIhfi40nb/iVLmAoGffhUJ?=
 =?us-ascii?Q?YgmuaFPvCCZdaSHiHLTxmMMfnF1pS0aYLE4RO4uVkOuOzTeU52H+lhK4yVeK?=
 =?us-ascii?Q?NhR63cCqWGAP5DbOU0kQEOjN1KsDXa3spPQdBZ0IXPC2H8Aw7eY0cbOKTbGt?=
 =?us-ascii?Q?2Tqo9eCE8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df8d9d4-0b04-4269-af14-08dede5ed0bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:54.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ETJRLRIpFibHLtzYdzd+gUXbE3Ahy1437w9deXSPxRJBu1wfdwn7w43/QqtogsEV41vFgu/sgTHPQv5mJddqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

When pulling a task from a non-local DSQ, scx_consume_dispatch_q()
checks whether the task can run on the destination rq via
task_can_run_on_remote_rq(). However, it then drops the destination rq
lock and locks the source rq in consume_remote_task() ->
unlink_dsq_and_lock_src_rq(). During this window, the task might become
migration disabled, making it invalid to migrate to the destination rq.

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

While the destination rq lock is dropped, clear the tracked rq state and
restore it after reacquiring the lock. Otherwise, a nested ops.dequeue()
callback can attempt to restore an rq which is no longer locked.

Closing the race and preserving rq tracking across the lock handoff are
prerequisites for correctly supporting proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1946824f3b8a9..de1eb6f193d9a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2145,8 +2145,10 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
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
@@ -2164,6 +2166,10 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Don't migrate a task which is running on a CPU. */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2257,11 +2263,32 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
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
@@ -2377,7 +2404,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.55.0

