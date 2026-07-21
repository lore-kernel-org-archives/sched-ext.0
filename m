Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE68434E23
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615652; cv=fail; b=bMNzTN8KqZQEExhsjY7KUr1twt0r5lr61QbN2MAnquhIpQsFFsXr64iFhZm09tyaTm00mW89B27gnt8XmhF8sIj17jawoR1dqBI+ELUS0O9TfYGAPQoKumIRdF1ydzsbiarkq9FIfLdxyRBKaSOm0PbSFsMNF+hSXQD1Gw0f8bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615652; c=relaxed/simple;
	bh=1fM4IRKteHXLunLhkgpD5cucqWR49Xyv2xwBZNcU0ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANyiwsdSuu5jX4l25Arl10yoFO1x/AzAcwgmMHDgTLcMhiM1PX5ugHxiw8RImkuT6f9WmldSOqoplk3cMVYVYtnspFJLSei8ltzK4SG/qKYwHOBNNtNHEsqSwXa7bFrFZhFmz7eYzKDD706ESXik2H2Zk8UnJH7jbanTvZJJlO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGrpzuXi; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGrpzuXi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4mCnEycVl6ann5keDXTio/Zn8+ZApUhXzoAptmJ/X+ZjK0AaYCfKIqDeYt/igl9P/SJTb8KgG5+TMfbxeRiw5JAvknbKX1Y7pT6U3AkA++BwHHUnwihBHYe6mHCicpk0cdL9bqHR9wB67yaKQZJIRAq41b/7gGREaxaQNtrwm4hlj0VJPYvUE5j2uOaYjlz0fcmdEurhj3kZUk7/1VAl9vb0dzS+S79MQCglX4B8GC9Zrx0Os2g4xyJP6sR6NxukKIfXoTrMVrxXaYxpHpwQM8xUojdAFdTDoszIf3EzH+cg0nPZvrCz9FYtfYQoMNQeAdoaDX5kBtA/MAI22ECYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQG0MQ2NAtE3Bf85Ldt5xX/py1yKOXWsBrBx2e7CtpE=;
 b=tmG1GlRrqXthFW2N8y5RNtjwtoBYX/SDWs9bbN8CFTkDJGzqxjIYCXOrvvwnFqJYh/fVXnIgp1FYxXff6u2EJUjObCfyZSAWWpWcru7WpvOxGkoW+/6Fg5bcavgFAbt1s7CpY42l0FOaISEBt8U1ksE52RddzVRSZM4ZRHNbLT+SSWj+G3C3bN7DPQGgm4AlrWn8y6G1uVZH7zQ4VpuGWbY+61HxTSMPScFNR7aj0iBCUJL0rifMxQUhmPPFM2SDbUGPpOCAqpLJWFv+edGiB2qx4KGntRX+ce43F/KhAymSQpJ2fTW74Zg2d4Edjqwl/L08YsemUH9FWSWHPHBlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQG0MQ2NAtE3Bf85Ldt5xX/py1yKOXWsBrBx2e7CtpE=;
 b=uGrpzuXix8a3MqDwwa1dGIz6n5KSGINXkON3wAH9t8NTE3BvXOncURqRc5mNPnqUWrT/mmMOmCmiBS+mN1xp+5PVaH8jA6f/GiqDDu75t3wPfv+vfh4otOp7y9g0VxnwWe2eq1HpuQXtsW35qL5w70nwMiuSyuaGP53iq5HjfcxOiEn/Psa1gQ4RhzFjJf3qD6AxMvHaZw3ZlTLPCu+9eYk5WGrYNHGWB1NAidAhVMCYHU7fygBQm21ck2GrVe8vRrbt3UmYvfj1kEpQp8FCPGT4KibnMxwll9hH2W0DnhOteok09fde07/5Vqq68sckt9ylcd+hygO2ebRtz6+AAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:34:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:34:03 +0000
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
Subject: [PATCH 07/12] sched_ext: Split curr|donor references properly
Date: Tue, 21 Jul 2026 08:31:28 +0200
Message-ID: <20260721063242.552774-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5560992f-d0dd-4603-e731-08dee6f20e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MHZOK6eW1lmx1Afi/9Yp6vIx01W9NLZAxcxgn5Ycsb+qn2+toFWAggphklh2QHhoag5WBcGcGZ43l/Q+tqZVkeCKrwYeiFUMK0iBrH1ZDq8V+FQzCyCed1qGAtCaMe5Nr6nVZsKtq1COquT6JwUFHXQnX1blJEufKh98Q7vz9JdWLXl6nEQyJf1DYeVwWWOioxm1SSUFAAzMlp95swfB7lUqUQbAZMKoyheARERRaAbg3GsLOcDQTs32x3bg4fJabx7UcRgyqV8ujccOa29AmRbi9KnwZ/XiyrZEBcLHK/8E0rKkVPkgDTo5DrzZj68+6V0QRlX4iiHkhloBEuibxoPS2AXJ3aFCp3EhYDq4JYc9l8mkRRi0T8V5rtyupTknpEm4/ZHBMg3YH/7JuaVOJK4yjB2PXswqvDvbOtkgJRl9IyRlHSHZQDH3LCgY1qUuiBpN0We3z6qDXN0HTOVLxxU2JRIxnRHgvbhg2EbmSdADJ6+1Ucn15Ns9GAcXdu3Gl5Uqds/hd+i2VgrXZUwQuGS2fisxkZC7IANEbNE4IMwhLHIT0h07fp49RzJCiNZbZMJDTY1T7zX4NIoWMPJ8vrY1wmAu6LGKYfg3k3qZ6NuiOJv7mpbb7QN83PBInxPYccN6tH1FJ0r7EaJDyie1rPUoUR96OK2Jrxkd4VF2Ahg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uhMx3hxrqk1ljwKsupAB/ja4vYdzC0hgzFCEZipWZNuoVQebEnIkEkuRhpiD?=
 =?us-ascii?Q?65Moa07pLTKjR1oyYm6ZN9I0MiLZufFJTcf7yADFcgJynYEND+kTEeaRfo0h?=
 =?us-ascii?Q?ZqUZYZHTB1RxdidmtcFDwDrg/7XVUffWiqoYlsuYV/oKXufA3N73QuQ2Hbou?=
 =?us-ascii?Q?MGf41MUDKAlzqHr8JTolySkoct4xj7gRWcAhFVYLtCcMAEApepcUzF8d7w9w?=
 =?us-ascii?Q?lC8CmdY29YR76uLrsZOQxa2DTLdHPBZGeVK9sTP4WSK3DZzP7S+b3xaIqMhN?=
 =?us-ascii?Q?ll71VDRoIjjE9MRm+cl8aJqdw5r81lv6Yvw39bq/B2x8V6sxvhQMBLq72NPo?=
 =?us-ascii?Q?OUXmNCgz/goBFuBczI1Fw62zG6qfBHIEvMu2IS8cHDwZfH/BhWJOq1W1/akG?=
 =?us-ascii?Q?dSnr9Z2R42qqYmWKKZ76mwynVmFEbEZExzleuLtkFE7N45jdofSdo/b6xkyM?=
 =?us-ascii?Q?cXDTQKc9bv6WJNzaiWd63YrW+minpjXX6HDmf4MZACwWWY+070hvHxSscuah?=
 =?us-ascii?Q?uF+EpMc0LjhPsIcK3H/b8NcVVF7klrncYEC36DKoXQ6Z2KQCdis7YmauT6J1?=
 =?us-ascii?Q?kCMgWcWvVArjUsoHwBGTsZcHczgQgc0U4CXKl5iozE+vCG93mDMkg+VdfqXD?=
 =?us-ascii?Q?uWU5jHmBlNHwluwKc3ybcBFgdn+O3L2Woclj3lZWyJbrBbPsmf1euXFJ+z0p?=
 =?us-ascii?Q?2P9kPkrYKf8tkEg4/uVE03K6DfHSDD0QJN/zQngmNiI1WejDDbByyO7Y1cVF?=
 =?us-ascii?Q?BVtzkvyLKeCj5Imh2omj87GquQYrLBn89Boed5hS3qDfIpzqDAD+LrY3kpfF?=
 =?us-ascii?Q?cobdP8xeVPn17Iu2E8k4zAHxISmYuAvMZo96Ybe81fmhjY2oJ0V8sUHZIyb6?=
 =?us-ascii?Q?ySSjh14LVURO9lENmjycZzKTbQ+oPzkkp802qxiGKNOI44bJjYH8hIPcQME/?=
 =?us-ascii?Q?aHHoG2quoJlT4yGRCgk2wiW8I2u5Dq47HsgQmc8rSZ/S4aT2iaJi+koZfvs9?=
 =?us-ascii?Q?ktJ9Pe1mnzyerLJhwXRNViqPH9OtJ01u3HlOslG3KdVojukp0VMUXv1RJ/yv?=
 =?us-ascii?Q?cvRkyKzxTn8EP65wQ4j8PB7RJfI6GzDbT/ifNjKLypV09M6AZ90+/+YJd/uK?=
 =?us-ascii?Q?sKa2P0GZ0mbGgqVkHY803YaQ6KnDYqpwIo6joOSVGTIsJvuoIr3Blr/wChSN?=
 =?us-ascii?Q?EID32QNViS7qDz6bI00vPkiacbcKHPZAo3tHJ7/EIbLa17+DHA4gMoktHpNa?=
 =?us-ascii?Q?Dup5THP1IgL6PbGI37ghMgA2Z+P0oyf0WqIbTLy710XC0dfgKX6/LMUY0P0w?=
 =?us-ascii?Q?bRWOhn6a2g81JnJ8ZTj0YkBCaILSuzPaO/KgBBtbYUB1esSLS0Vx1RejyBk/?=
 =?us-ascii?Q?pus7v52Zb4QjCaNCAsAfZPzjT/2O0mOygsEbB8Xx4J+EINcYzXJ1OowztXup?=
 =?us-ascii?Q?/1JBwJj0DTXTumiu0YSUzduWlQFx1ohFGXJx3uUH8GT6AE72D0k7VkYRQo4c?=
 =?us-ascii?Q?3iexRTQXnJaUGZogl5+eQKmE8+IUH0NkYvCcZ8uMck/TLp8X2CoRQKQXqkd6?=
 =?us-ascii?Q?O25dIN9xhTlFV8K6TXwrviTWfVPGqPQ6xvYloGbNw6tcRp+p1UzBrWjypZQn?=
 =?us-ascii?Q?JfZvffAcpKdCJ4LlRf07M1DgvjnyUiSoanFdc8S2XhZTBQLlSJ2+ceVl4OEr?=
 =?us-ascii?Q?m2/hVm+QsP5dyNqt/nNlLWZdDH8xOAaxTvb3BkK1WB7p2YxbOnqKHPh/8bQU?=
 =?us-ascii?Q?zEd1k/dpQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560992f-d0dd-4603-e731-08dee6f20e75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:34:03.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R69TNs/sR9HQzjRWH3REcunOboW17ZKvOof2Sd9lmeDo8GcLSba5M70VSi9Hbwq2L8t++4X7TFsbP/jXavEtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

With proxy execution, the task selected by the scheduler and the task
physically executing can differ. A blocked mutex waiter donates its
scheduling context to the lock owner:

  D -----------------> M -------------> O ----------------> T
  [donor] blocked on [mutex] owned by [owner] preempted by [task]
     \_________________________________^
          donates scheduling context

where:

  D = blocked donor
  M = mutex
  O = mutex owner
  T = competing runnable task

During a proxy execution switch, D supplies the scheduling class,
priority, and runtime budget, while O supplies the execution context: O
is the task whose code physically executes. T is a competing runnable
task which may preempt the D/O proxy execution.

Consider FAIR and EXT tasks with sched_ext running in partial mode. FAIR
can be replaced with a higher scheduling class such as RT or deadline
without changing the class interaction described here. The possible
combinations are:

  1. D is EXT, O is EXT, T is EXT

     D can interrupt T according to BPF scheduling policy. O executes
     with D's EXT priority and runtime budget, while T waits in EXT.

  2. D is EXT, O is EXT, T is FAIR

     D is visible to the BPF scheduler, but cannot preempt T because
     EXT is below FAIR. Once T stops, BPF can dispatch D and O executes
     with D's EXT priority and runtime budget. If T becomes runnable
     again, it preempts the D/O proxy execution.

  3. D is EXT, O is FAIR, T is EXT

     This cannot represent T preempting O because EXT is below FAIR.

  4. D is EXT, O is FAIR, T is FAIR

     D cannot boost O above T because EXT is below FAIR. O and T
     continue competing under FAIR. Once O releases M, D wakes and
     resumes normal EXT scheduling.

  5. D is FAIR, O is EXT, T is EXT

     D preempts T as the higher-class scheduling context. O executes
     with D's FAIR priority and runtime budget, while T waits in EXT.
     D is not visible to the BPF scheduler.

  6. D is FAIR, O is EXT, T is FAIR

     D competes with T according to its FAIR deadline. When D is
     selected, O executes with D's FAIR priority and runtime budget.
     D is not visible to the BPF scheduler.

  7. D is FAIR, O is FAIR, T is EXT

     This cannot represent T preempting O because EXT is below FAIR.

  8. D is FAIR, O is FAIR, T is FAIR

     O, T, and D all have FAIR scheduling contexts. D remains runnable
     as a blocked proxy donor. When CFS selects D, O executes using D's
     FAIR scheduling context. When CFS selects O, O executes using its
     own FAIR context, and when CFS selects T, T executes normally. D
     is not visible to the BPF scheduler.

Thus, sched_ext policy and accounting must generally use rq->donor, the
scheduler-selected task which supplies the scheduling context, rather
than rq->curr, the task whose code physically executes. Without proxy
execution they are the same task.

On nohz_full CPUs, a blocked proxy donor must retain the scheduler tick
even when it has an infinite slice. Otherwise, a full dynticks CPU could
stop the tick while rq->curr and rq->donor differ, violating assumptions
made by the remote NOHZ tick path.

This is a conservative compromise that keeps the change local to
sched_ext, at the cost of a periodic tick while a blocked proxy donor is
selected. Allowing blocked proxy donors to run tickless would require
making the core scheduler's remote tick handling aware that rq->curr and
rq->donor can differ.

Moreover, extend scx_dump_state() to report both contexts. Each CPU
record now includes a donor= line. If an EXT donor differs from
rq->curr, also emit its detailed task record. The existing '*' marker
continues to identify rq->curr, while the donor= line identifies the
otherwise unmarked donor record.

Note that at this point in the series, CONFIG_SCHED_PROXY_EXEC still
depends on !CONFIG_SCHED_CLASS_EXT, so proxy execution and sched_ext
cannot be enabled together. The scheduling changes are therefore
preparatory. A later patch removes this restriction.

Co-developed-by: John Stultz <jstultz@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst |   6 ++
 kernel/sched/ext/ext.c                | 107 +++++++++++++++++---------
 kernel/sched/ext/internal.h           |   6 ++
 kernel/sched/ext/sub.h                |   8 +-
 4 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 2771ea4cc14af..4d8bcbdacb9fc 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -487,6 +487,12 @@ and edge cases, to name a few examples:
   class, in which case it will exit the tick-dispatch loop even though it is runnable
   and has a non-zero slice.
 
+* Under proxy execution, sched_ext continues to observe the donor as the current
+  scheduling context. A blocked donor does not enter an ``ops.running()`` /
+  ``ops.stopping()`` session because it does not execute itself, and the lock
+  owner executing on its behalf is intentionally not reported through these
+  callbacks.
+
 See the "Scheduling Cycle" section for a more detailed description of how
 a freshly woken up task gets on a CPU.
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b5fd91d9bca4f..a466adf8e1548 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1341,20 +1341,27 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 
 static void update_curr_scx(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor;
 	s64 delta_exec;
 
+	/*
+	 * update_curr_scx() is selected through rq->donor->sched_class, not
+	 * rq->curr->sched_class, so @donor is always an EXT task here. If an EXT
+	 * owner executes for a FAIR donor, FAIR's update_curr() runs instead.
+	 */
+	donor = rq->donor;
+
 	/* apply even on 0 delta_exec, callers may still act on the slice */
-	apply_task_slice_oob(rq, curr);
+	apply_task_slice_oob(rq, donor);
 
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF) {
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
-		if (!curr->scx.slice)
-			touch_core_sched(rq, curr);
+	if (donor->scx.slice != SCX_SLICE_INF) {
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
+		if (!donor->scx.slice)
+			touch_core_sched(rq, donor);
 	}
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1524,9 +1531,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		set_task_slice(rq->curr, 0);
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		set_task_slice(rq->donor, 0);
 		resched_curr(rq);
 	}
 }
@@ -2761,7 +2768,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2972,6 +2980,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -3000,6 +3009,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3010,7 +3020,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3031,7 +3041,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3206,7 +3217,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3566,9 +3577,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3577,13 +3588,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		set_task_slice(curr, 0);
-		touch_core_sched(rq, curr);
+		set_task_slice(donor, 0);
+		touch_core_sched(rq, donor);
 	} else if (SCX_HAS_OP(sch, tick)) {
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 	}
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
@@ -4221,16 +4232,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	}
 
 	/*
-	 * The revoke that scheduled this scan may have raced the pick: curr
+	 * The revoke that scheduled this scan may have raced the pick: donor
 	 * may be a now-capless task, either one that kept running or one
 	 * promoted off the local DSQ between the ecaps sync and this scan.
 	 * Zero the slice to evict it. The enqueue gate blocks new capless
 	 * inserts, so no later pick can slip through after the scan.
 	 */
 	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
-	    rq->curr->sched_class == &ext_sched_class &&
-	    scx_task_reenq_on_cap_revoke(rq, rq->curr)) {
-		set_task_slice(rq->curr, 0);
+	    rq->donor->sched_class == &ext_sched_class &&
+	    scx_task_reenq_on_cap_revoke(rq, rq->donor)) {
+		set_task_slice(rq->donor, 0);
 		resched_curr(rq);
 	}
 
@@ -4416,14 +4427,18 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
+	/* The remote tick path assumes that proxy execution is not active. */
+	if (rq->curr != rq->donor)
+		return false;
+
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
 	/*
-	 * @rq->curr may still reference an outgoing EXT task after it has been
+	 * @rq->donor may still reference an outgoing EXT task after it has been
 	 * dequeued. If no EXT tasks are accounted on @rq, ignore its stale
 	 * slice state. If another task is dispatched from a DSQ,
 	 * set_next_task_scx() will update the dependency for the incoming task.
@@ -4437,7 +4452,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6626,6 +6642,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(pcpu->cpus_to_kick));
@@ -6669,6 +6688,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8184,7 +8207,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8201,7 +8224,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					set_task_slice(rq->donor, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
@@ -9172,13 +9195,15 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 		return false;
 
 	/*
-	 * Directly write only when we hold the lock of the rq @p is queued or
-	 * running on. See the slice write rules above.
+	 * Directly write only when we hold the lock of the rq @p is queued on or
+	 * provides the current scheduling context for. Under proxy execution,
+	 * rq->donor owns and consumes the slice while rq->curr executes on its
+	 * behalf. See the slice write rules above.
 	 */
 	locked_rq = scx_locked_rq();
 	if (!locked_rq ||
 	    (READ_ONCE(p->scx.runnable_cpu) != cpu_of(locked_rq) &&
-	     !task_current(locked_rq, p))) {
+	     !task_current_donor(locked_rq, p))) {
 		set_task_slice_oob(sch, p, slice);
 		return true;
 	}
@@ -10013,12 +10038,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 }
 
 /**
- * scx_bpf_task_running - Is task currently running?
+ * scx_bpf_task_running - Is task the current scheduling context?
  * @p: task of interest
+ *
+ * Under proxy execution, this reports the donor rather than the task whose
+ * code is physically executing. The physical execution context is intentionally
+ * not exposed to the BPF scheduler, which continues to observe the donor as the
+ * running scheduling context.
  */
 __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 {
-	return task_rq(p)->curr == p;
+	return rcu_access_pointer(task_rq(p)->donor) == p;
 }
 
 /**
@@ -10075,10 +10105,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
 }
 
 /**
- * scx_bpf_cpu_curr - Return remote CPU's curr task
+ * scx_bpf_cpu_curr - Return remote CPU's current scheduling context
  * @cpu: CPU of interest
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
+ * Under proxy execution, this returns the donor, which supplies the scheduling
+ * policy and runtime budget, rather than the task whose code is physically
+ * executing. The physical execution context is intentionally not exposed to
+ * the BPF scheduler.
+ *
  * Callers must hold RCU read lock (KF_RCU).
  */
 __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_aux *aux)
@@ -10094,7 +10129,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10118,7 +10153,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 26bfda216524e..5dfb7e466108f 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -447,6 +447,12 @@ struct sched_ext_ops {
 	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
 	 * target CPU the task is going to use.
 	 *
+	 * Under proxy execution, the BPF scheduler continues to observe the
+	 * donor as the current scheduling context. A blocked donor does not
+	 * enter a ->running()/->stopping() session because it does not execute
+	 * itself, and the lock owner executing on its behalf is intentionally
+	 * not reported through these callbacks.
+	 *
 	 * See ->runnable() for explanation on the task state notifiers.
 	 */
 	void (*running)(struct task_struct *p);
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 625d7ce334aa8..a164e6b2f2562 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -141,14 +141,14 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
 	return SCX_CAP_ENQ;
 }
 
-/* the cap @sch needs to preempt @rq's current task, 0 if none */
+/* the cap @sch needs to preempt @rq's current scheduling context, 0 if none */
 static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 
 	/* a non-ext task can't be preempted by ext, own-subtree needs no cap */
-	if (curr->sched_class != &ext_sched_class ||
-	    scx_is_descendant(scx_task_sched(curr), sch))
+	if (donor->sched_class != &ext_sched_class ||
+	    scx_is_descendant(scx_task_sched(donor), sch))
 		return 0;
 	return SCX_CAP_PREEMPT;
 }
-- 
2.55.0

