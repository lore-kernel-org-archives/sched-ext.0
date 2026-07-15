Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547123C872B
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149023; cv=fail; b=fhozQJSokAN7ZpWvl0ZZZp4E5aRnW6nJyq8b569dLKMklil3l64CZTzgQlXkJtIjaJM+xxGFaTKxOdn7nlbYQPG1dh5ZAvum0gbzFdHENN4mqI6g+Q1rOYLDPxLvuFWx0KF9ZFhZc1E0YBhnzqO5eyuNJPXNL+Ld9+kXxRJ8ebk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149023; c=relaxed/simple;
	bh=sJYMp69YSdHR4CZuVSciGniO0JFJgz6lKOUtLBRdKPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mockSmvjygK0abqSz8eTyvu7NdsyNF+hrpRwgceHumjVdxRoKSIplWBy9ov1ZmPexx/ztytvD+QsyuU/TQaewbcr4zRy1CxjB+TeiHNOqo58al2vKZSJlRLXLVGmBge7TBWyeaT/x62J8owWIkAJosZjDZ1qeoSZi60vguSnAe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eewzDzWg; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eewzDzWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT6ugN1Fu8baZ8SUabktAAAbI7rbW8jz0P2MOg6YJOq1UbUl4guBrKrwnOfuKzZcVTt7rVQueM304OIf6OHYElRodluTTO8OG5H1Ic0GVUPOwiQI+NL4n6cEdTHzZbNpFplJwJNzrjHBs9wd7w9uhb9OoHahtfTntqXEBegUv5PqQ8a7QoT2/xhOJ1snPEDL6HOrbqTJQCnuH89Eo49lA6TBoWJL0ZKgxZJR3y7zGQ3vDfKNyf/kZV1myFi6BKEoUtXCdcCdFDOOD0sTYyNDJvnkv6WVRtRNhQGUG3pMHfjse9LxV1EEVA69zaxO5gep3vNkytC/zRbhJT7SI5oH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEqtkGAaHuadhajh0ArgfxN+PjpVIja1DeAs9A/pcjc=;
 b=NoHyL5zYopNQVBZVrj1GDRvRElrnXFU6z05aq9jYH5EQ1LyZXO+DpnYXdQTrkOkhuOFkgQ810HXnzX/TNcYuOjslVtLCKGvYnG1JXj5dT98HYZNhiaZrJj+Q8RiZhG3O8iy6QpMHaP6UKQpz8ACd9ZVFSKvVcv3RHWzEFV+jvy/utoO9Gk1RVQdGvRDgTXciIoDT+K+kPwc3+tqmi2OtqKaZWTeFc3C4NB4av3qHVM/M51qe7SAlrpZx85zRG4OUcYqDVbeK5xXgSNTLhOpO/1mR861KR5j2O8VPPvnhES1Djhk+mxrHGxXqXcjW09sSeHxNWzE938x0E9CUmn/Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEqtkGAaHuadhajh0ArgfxN+PjpVIja1DeAs9A/pcjc=;
 b=eewzDzWg2tCkauvdlZd/QWThLCbS5/nmjL0UPjXhFj6DcD7jYG3M5xsRNcdsTnEAa72wEQZu96b/TwRWfmA/tkDXJj8IPLI0om50sbtyCyt8cTKznRfa0Ih0sXgZKXM26d/aLVBchzAmWeifOkAKzMRC53eIUbQZBZF8BD7AcfMU+0QLxnhlZxoSP9voxanE/elmjUDEY+0HGhCZ2PUA/lsuys3YO8xMBPaMHZAkpL8hTn2FwqfXsTL2NkRNhQa3tKcmG98nqFePvlcvwIGFZL6BFF6U9FSGk4XvhKQdy4XTtU5Z++xffAFwN1Lk3KY+147wmPe+9xxJEM0JF4oExQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:57 +0000
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
Subject: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_task()
Date: Wed, 15 Jul 2026 22:54:13 +0200
Message-ID: <20260715205622.276220-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007542.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d0) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b4dac-4e0a-4eda-2678-08dee2b39bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YrcNqFncG8Z/mnQ8647jY6d5JmOHy/WKn0Dlj6on2RvOtf7auBxQB6ioLR7aHP2PiZ5L4DAJZTBAc4oCtfuM49jJ39gRxznWrQEPr1pJKaOoTVpaSqB0veFYannx1oOwtk2UU186cQL8mluasG+LB2tTNbNRj7VEaVIMi9m3Qf2g//Gy5KuzNLHhq9VZib/s82a1SNP3PEWLH4+foih1yBaVRV1RSdBFZBrW6kkQB2pDdGLF+mixUW2cpGcDVA28hXBJFzbtIhhwQbF1+8/+cYyqrAVvJoGRWr55ncgAdk5bHpFKZzOv7Q6uJoV02hdZGbtQJ/9Rs10Sbz9iVP/ExobgqdKPuRU4CUY45IY9/wOMAfj/npoWrG84Q3g5Uj3FfTUsQOdWnSIvPKGv12X8T07Y6ntguED20wuK9VquUcU5dSK004P0LrewD19B9QCDzTEOH3hi3mObkP6onB3gp4qUQgHyhhxq7Y7RG0GzN7GsUzQFrc0lV/xeR4SqJoQXkrgClTdWl2sGaQ385P6MO6s45CoCvzY8uLBnzQNgAHKiPj1O45sA8DnPVw9D/gichxNykfmQZSuZQ0S0XXkyIjvU7oac3Ic4e6D4pN7HcolbcN0pV6eqLsmPPrmuvx4MmddOTm3DMCL8IWZtVjtiwqfSEB7Z4DMOiKbzh4zBuXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKv/18A6gYjtlhUHr94HGa++GfKhw/2Vl54tqnMqKIRcoQX2Ryp8I1se87M1?=
 =?us-ascii?Q?KP8tStHEBqaG910aFy8EVb/3wd06/W81+Wwro9rZG/CXgzKypl7tBps35dym?=
 =?us-ascii?Q?BvB8oK6yCBh0dpw+N22sy0BngnyefDaebFc349Lz7RH/3PFToaSJX+Fzbqze?=
 =?us-ascii?Q?bnZQ/yRQksq5YB1ogJ1Hi3hDWPvfAYl2YtcM6caG3h7r8ZvD9LbVQnXSrXYW?=
 =?us-ascii?Q?HGU3VUHUOVnQAfKUaOri7xggCLp9Pyk6j0+yPpGiy+0+m8oyZcYhhgjcZdI2?=
 =?us-ascii?Q?TUqlI/69jeXB30On1H6RWqRtd57jTstkR1gKiFg+GfN0sC3cbB+sUv14RF5C?=
 =?us-ascii?Q?S5xap3lvva0J+ft9RQMEbEYFXuMdxFTEdGkA7yF+qwo73WGzoorhxYpUev9e?=
 =?us-ascii?Q?Fy2ekZsUBBXchQY8K0qYbQvSEqZdYnti8AeUUlA3BNwbQL31JGdQhybf4fni?=
 =?us-ascii?Q?uf6/85NvNsz3marffWMi2/cvfVcCj1CxdtpYe99laZJ0ZFtmMNtUVlutx748?=
 =?us-ascii?Q?5SX+N6B63mXSrUbGQApppitbGv0BSStuUTc6yyyF3j9JvxuG+i07arf0VuaZ?=
 =?us-ascii?Q?Eq4AtXUpVTj+B0Wd7ToWfmG/yh7KJf5dtQc6lYVC6fbvi5oJM7vZ0plfNxgs?=
 =?us-ascii?Q?eiAaWA2zcfaX1bu92HwArzj0ooXH3lORPH7RpXyRJr3s5wPiXe2AzAhgYSny?=
 =?us-ascii?Q?WHnNgZmip3MnJP/zufRqmz+/rm0KRfRYfGlUE8w7OHIuBGN6A/hU2xEdYvin?=
 =?us-ascii?Q?3fP7bt1s3wmwACXbAtIyGL13dCm1JOB1ygrdxpxH2m3HkNDQwNVlMiSeMRmm?=
 =?us-ascii?Q?yR0wyQCCSPsnV3xAMp5VsPRUR+DzVqJFhsbxBROduQ5AEyRtnp6mxRs84oXO?=
 =?us-ascii?Q?AGq14Q/pVIdsr4KT3UrzL2rsIqQ06uopACkLPc9PAO3D6vBSmFIsNulS29Cm?=
 =?us-ascii?Q?NI0rG8JgDsPthFCLfgGOVP31iybTAkNLhLeKQov94HjdcIRcoKt8Nv5H2rLM?=
 =?us-ascii?Q?Pu/39IjX1Tol14qwLKErhvlT+N2R4UBFyYluJDs9qEArOZQmqKZ9MbRlcuv5?=
 =?us-ascii?Q?wxdPqTfgkCmPOSd36ON4OhwFW0KPxq/1AjZexraaKcaE0YGgxSjBzclmpFzU?=
 =?us-ascii?Q?Cgf7xAbihv1aHYKjxdEVZwBIzAxQw5FSGS5Ikqbe74rhl28mb2GcrxLc86On?=
 =?us-ascii?Q?DwZTXrlRuYLyvJ1PwiwrFKb/eIqQ5OpCtUpfW5QCk/aLJMj1DDQoYkpx9Ojy?=
 =?us-ascii?Q?SJtFsw7T34gkO2yqevkLTGfv4uDuawt5Gl2Gp4MZiMGO6NzceoRsR77gam60?=
 =?us-ascii?Q?CVF47sADalhu+L2komJLNX4Jxh/7YwBCTbNjlS8L01GDUGOqmn1/7UTYCNTi?=
 =?us-ascii?Q?9slUmqOjIGLhZTDZ7VHGFgdP1yX5Mq0VdLn9KLEyN9tkKwEACf+hsov3mPxo?=
 =?us-ascii?Q?P0rLYBtZdPe6QPB8BcKR7zxM8P6mLu72eUR0Ex3ia0y2Mq/YyO53VUcIBSJy?=
 =?us-ascii?Q?nQwMN0E1+kL5tVc/vCKvUAXzNT/mBgPdwdWzZFsJj8qclLNmoHLcytqu84ed?=
 =?us-ascii?Q?fb2C6NbSvntXmklVAnfRH2G9NgNTy5U2XLbDBUGNpRhxVjeMWoK6ltRDPclv?=
 =?us-ascii?Q?7wZeuRWK106BjuqcRr7VjnmPgRoh8oPHK1X57p5v+VGlP/RmSrdxhq9pw3D1?=
 =?us-ascii?Q?m7OpRXgpm8RHE5fYDyDE9FBPlHvIO+aP+7hYYXaeE6L3V7GMDrTTY0BMObC+?=
 =?us-ascii?Q?mW09IuQy4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b4dac-4e0a-4eda-2678-08dee2b39bdf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:57.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N7AqdgBiEfMAeX55o9GFefpVU2VFRAwzpcx/m7FqlAhdMHBNN15ltoXjb+V3ifSX3jmoe7X5dLceK5TgXhnLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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
 kernel/sched/ext/ext.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9836667356c89..ca400f765cb7f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2363,8 +2363,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
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
@@ -2382,6 +2384,10 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
+	/* Don't migrate a task which is running on a CPU. */
+	if (task_on_cpu(task_rq(p), p))
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2480,6 +2486,27 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
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
 		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
-- 
2.55.0

