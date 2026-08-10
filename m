Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D741612A
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375037; cv=fail; b=VQEiI77uSv6wEbVl2SMq97ISiN7UYhjy4Ax82XX3ocHxoAC3/geUvqh+awzm95SY+8HcFuvewlevXg84ARIOG+m/mS0eaDXVmHCLID6rRADOdcDnnqYQCCOx6Bxbkw4AiFF4qA47W6AVTrfW38coAdtpi+OqxPjrkwVBMzt/lVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375037; c=relaxed/simple;
	bh=pW5Jej5E/scqF9NLaTrIvy0ckLUKkbEN3sOtnyVU0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfkNV6wsL4/15lEI82LbqJzIiWAIY4Ugn0EP7CoMZdROc6NXZRV/AUhwdxAGql/ggug41JQsnxvPQhcsTD9NHTh7SiTJQJnmFtZNb14sfHV6GFG9l51ug21EaHs0XXtirkVYzBrn7RYeLI0x6E8jJHZMSCe0rGNkJnUwTjg5IM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7Jgmyq6; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7Jgmyq6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUW/cDzikqxvUPCDRdjluMS9G7V+391L0tDufygEMp69HyYSscyB8z0dPYKNCsuUEU/l7Qg7lTIOLBnQgpsQN3ShdjFI0vPnxndJ4iqBR0KIairqPRb+07Ai7zXdlHk2bgmh4go9N1ox4IrAjmqxJXbUH4I2zrox2hEsFa/3X6aaTzlUSWUjA3FeS2Yg61FCX6P7J3ZvdEauYyiA18OtWFtpo3Ah91B4YdwOR9d45p7XNfK/ev5K+1gJtThEU4CpYnQnHAqme5J8gujjh++JN+SJewSdSBevFmkhRsrSimzM3nPY7AwnkYhbfCacHfSq7ie4mdSaudgF6TEVbr7OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC1jEI5AW7hQjbEf1yzZWiFKR4QVapri9pT6nU605EU=;
 b=xIe9tNsnoZdUG+I+GW5sIHIrwL3Ko+kOvhIdPYKeLkZH7FY257/pJ2uc8VOJGSIugNPOdqT9/ejyL9ViGhgy0KrpG7rGsHIuYd2WNDqS3TAbJdET+KuBNILeeWe4C2Vzw8jSd8ydXqIhMm5XP3eQEKEWii9M+JwhCfN7+/CQUj5Npx53SUrU1tFf6Xol+8Vs7KtuhhGOtronpWU8Wj3XFZeFrdNTk3uXrYbIidNvpd+71VwHZVRW1CP002VXW2aEbjWW3AilnrosPDELlSNIspN4yKWEfjRwKFbtUsgzqXMueCgSvBO8Ewris/Ghkr9SbPQTzXG1pFyj8z4HeObAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC1jEI5AW7hQjbEf1yzZWiFKR4QVapri9pT6nU605EU=;
 b=G7Jgmyq61W2Zb6SXwIzht7zyfEUKaabGNWd05zy+wW1ZcxMddIE7TfKrhOA+gePjMUI/pnQZTWq/KkZaOPlYx6ADUh9q+S05cKiLLaVfyuvHRCKxko4zu/68EmdIY0Wdf1xdL1s/07NezyLTlj1Rr2rB78tv2I2cqsbDgbtGyCS0Eutu6N099+0lcmF5B+96Xk1Ot0uF8j8dtTwaI4ko74vXD7QJsMnVLvPhNtlPESKTZo2JJLyWqsx94339+Ar2rdq82+zTJK2sX23wH7bX+K6L6D6yl4iMiccQLzF990C/+BL/utUtdFTpS9He1KTDPyeSbvhC/ogBuxQs9MrodQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:17:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:17:02 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] sched_ext: Split curr|donor references properly
Date: Mon, 10 Aug 2026 17:13:57 +0200
Message-ID: <20260810151523.86994-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: cda88627-30a7-4bcc-4481-08def6f26ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V4xeGCPSXAQFjlqB44XrQr/21YxNn18T6wc0TR1BAtZtuh5DSsP4OvuTP+F6otZB+XUcNRHdMwteHKY0n7f0Uso48zNQDZhG6P+TZ+4EOuE+MNMdaL5vbU1j0JpHSAtQTUtSV7DAampWmoAKY306m42FxGGjs/QACDl/CAWAYhzPKEYnFjqO/oW89BRtEQhzZx/75nqjVV7NAUH94WVMdN1R1Z79xNBS7R8OZ5fG+brj313LS8ITGUrDKT41pl8J7C0rSDZtulY4BG9xGw6EOt/bbaa2MkEcZXbXemdSlMaMBOj0bFKAIVePiVmlyxWJ4qLJTezYzySdNhx1Ix/xBUnreI7WQ0vW7qWFLdYkFC47mSyho5OWBEkt4T0sd+fQm7wvRz10UFlLweNzbeHw6FA6mDCHN3vDjN42a+w0xyPXlhVCNbI6T3Hdp1ynW/Lf2Sl+WVjgkuS1mLW12ddHL5jxgdKpVD17rtNBnKPg0yBckDQzi+efjHMX5Gf839juebva+VUUR8eSI5DtgRukigei+odKRENrgSEl9vzKD8KmD7xLoZI1G00L4jzIFsxVW/ZJyH2tJsqw9+kVeOiJOBK5X4aKV6MfNGYamZEJKzYpfji4jbGVIMXGpev7JQxqbUCpro44T5ffyYyEjk48g4umPQsx/rmLJEuV7YfhUtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMDfhohWudF9O4ni4lNxyR7Ia3c/ippCr5y06Uibu2JBEHCzRHuKnKZUdQ0d?=
 =?us-ascii?Q?QdsSXPQwQWRJZJq6GAnvlE8niLkGDIY/OAH7UfUtJqHiJPBrLXmvD9Qp1h9T?=
 =?us-ascii?Q?gCwROCuslW+YL1d8sTOClMVKtDyvQ09Fga+GMek2KuyEW4RHP+tPE2qXdNF5?=
 =?us-ascii?Q?D6Iv6skx+qlim4NAXFmctYf6q+32VGTEv9ZB9QXibuAJeGs4HqCQEfV3FDPe?=
 =?us-ascii?Q?sMHt1TyM82wF/w+SiG9hOidhI3hagBOufc9fiTp/6fLtC+aWe2Kfo13LpSWE?=
 =?us-ascii?Q?/aR9/DNmUm0fSCdscj3PZqLez7XPpSW3+46p2mV9gQd/LlpGEJJvDPmE2MLh?=
 =?us-ascii?Q?nrV1uzLFw+tgNMLvBZEdRhi2wz1YVfFqwuf7ZxWZ/cQsDig81Cimw5n1dttQ?=
 =?us-ascii?Q?FpcXXqvjtRMz3HbcyqxH01jy7GFDkMKuldnVucvW74Yz7O8WbFRkkcBUXqzO?=
 =?us-ascii?Q?nLxVC9+hyiEjJ74zpbrHVmUdd18z1Swo+9BsEzIANbsHxRyqsnN+4KasV6yS?=
 =?us-ascii?Q?9rGkXsKNtt89l/ZfaYdvbxQ6jCQ+EIznYXz0CMcYpHWPBxIS8R3XYYkB7dSU?=
 =?us-ascii?Q?hNPOaFoQoyq89wgA/zo8Koun7jxe3rMomd7JSLBXbXQozWpBcG1x2t5nThsd?=
 =?us-ascii?Q?NKaIWd9AltlfDyyleShsif5V+iNFMRR6zhA8PHXZaiie2Jm52FZsOPTMTfHb?=
 =?us-ascii?Q?Tvz7FTpTTlzc4vJHjS2/U0bz2lt/u/qM3fTY3M64qwRHjQUAq33tdpD2lJgN?=
 =?us-ascii?Q?DMzlw/v7SMvZQrmrmLN4YjGPtUyy1AXcCkDWIuQuxjxCvwK8pE7Fq9qYydS9?=
 =?us-ascii?Q?zQR+5wzCUQ+R7HWXiMWI6yMQUAQdT6Er2Ifg8HwbswWdtdHfwG9VjmWrpKo4?=
 =?us-ascii?Q?ciA5g85v0TGMBQiVDWddT1efyf+DJVXWajfrBNLgdZB3hxUBFjHb707KzIuZ?=
 =?us-ascii?Q?OO3i4BmNPPci9blw5kItFIx+A87I+LCUVqZN6SyGkro6Olr+G3lGzHaqtzlP?=
 =?us-ascii?Q?eWPSfL+/PfOem2AqBKbtQQUHHAozPimDWIDsKQZ7QQCnTKICZhMVs8MJDjdD?=
 =?us-ascii?Q?bGSWB7ocFOJH/ptCBjus2dwTPKDHsCHtbhVN/KIkciPWJFtMRWDG95S3sCoo?=
 =?us-ascii?Q?gKxVRycEIzNiE0t1zHMGGoBPt84rtg/S3MnQnrRYTJ+kCkBC3nMDQv9Xh6aA?=
 =?us-ascii?Q?VeEL0I1CWZI4GQXFJiRlIsfhP2dGYnLEP19psket/8A+qWVHPJhf5FJOfT7d?=
 =?us-ascii?Q?GZ6jDMmgKGpILDidnJa40E5xNdC1f1pb/BxP/Oen+WtykGCArfbreYL80ptE?=
 =?us-ascii?Q?kENNJb77KrFY3ESiX7NetJrfuW6lz85Q4maPBVS0VImX0X75tNMH1QN0jhA7?=
 =?us-ascii?Q?nt93IP8W2h8gwixk8MxCpC0qxIAcIfu9riYjHVIJTt5Oq58yjYfyk64LT+Ak?=
 =?us-ascii?Q?3ok7TwUFOlC/zF8aicCJEMSwXnUIwHIlMhaojukQn7RoFdKloKI0m7S38vwn?=
 =?us-ascii?Q?8k6ovbRuyMHO18pq/JbMfuV4yzdFgKhgY00osXW4M+gGp08pUnIfePwRixNc?=
 =?us-ascii?Q?p01ShBdcMShzIgQMQmCQCiSgwUseVB8z2RCXIWVqqWV+BTCs2FLVGXcWKLJz?=
 =?us-ascii?Q?2pAR1uqHKZz7sqpBUS9uEpX6I9rV7RDAig5qyPvPdf16IBp8sa0isfDV7yZK?=
 =?us-ascii?Q?QeeTY/gu/Unn8NCDGvdADIh5l5SH92URp16LVrMCLOYtw6EWsNJHyuRuWZdC?=
 =?us-ascii?Q?wfkbKrXAoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda88627-30a7-4bcc-4481-08def6f26ddd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:17:02.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quSBGYcfZGtan7O8h8GYHyRX+j7lORnHYl9gKxtCBbT699MfdvgpzshxDFnQjRdXdYgcV4F6IiYyLOWgUvuDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

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
 kernel/sched/ext/ext.c                | 116 +++++++++++++++++---------
 kernel/sched/ext/sub.h                |  11 +--
 3 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index ad2fff3c05937..db1ef89ed8f2a 100644
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
index 7b467b666212b..39d3e3af05f90 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1438,23 +1438,30 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 
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
 
-	if (unlikely(curr == scx_rescuee(rq)))
+	if (unlikely(donor == scx_rescuee(rq)))
 		scx_rescue_charge(rq, delta_exec);
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1634,9 +1641,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0)))
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		if (likely(scx_set_task_slice(rq->donor, 0)))
 			resched_curr(rq);
 		else
 			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
@@ -2212,13 +2219,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
 
 	/*
-	 * Restoring a running task will be immediately followed by
-	 * set_next_task_scx() which expects the task to not be on the BPF
+	 * Restoring the current scheduling context will be immediately followed
+	 * by set_next_task_scx() which expects the task to not be on the BPF
 	 * scheduler as tasks can only start running through local DSQs. Force
 	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
 	 * IGNORE_CAPS to force entry into the local DSQ.
 	 */
-	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
+	if (unlikely(enq_flags & ENQUEUE_RESTORE) &&
+	    task_current_donor(rq, p)) {
 		sticky_cpu = cpu_of(rq);
 		enq_flags |= SCX_ENQ_IGNORE_CAPS;
 	}
@@ -2941,7 +2949,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3165,6 +3174,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3189,6 +3200,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3199,7 +3211,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3220,7 +3232,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3441,7 +3454,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3850,9 +3863,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3861,13 +3874,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		scx_set_task_slice(curr, 0);
-		touch_core_sched(rq, curr);
+		scx_set_task_slice(donor, 0);
+		touch_core_sched(rq, donor);
 	} else if (SCX_HAS_OP(sch, tick)) {
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 	}
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
@@ -4512,16 +4525,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
-		scx_set_task_slice(rq->curr, 0);
+	    rq->donor->sched_class == &ext_sched_class &&
+	    scx_task_reenq_on_cap_revoke(rq, rq->donor)) {
+		scx_set_task_slice(rq->donor, 0);
 		resched_curr(rq);
 	}
 
@@ -4762,14 +4775,18 @@ static void run_deferred(struct rq *rq)
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
@@ -4790,7 +4807,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6988,6 +7006,8 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
+	scx_dump_line(&ns, "          donor=%s[%d] class=%ps",
+		      rq->donor->comm, rq->donor->pid, rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		scx_dump_line(&ns, "  cpus_to_kick   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_kick));
@@ -7031,6 +7051,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8579,7 +8603,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8599,7 +8623,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 
 				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps)))
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
-				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
+				else if (unlikely(!scx_set_task_slice(rq->donor, 0)))
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
 			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
@@ -9575,8 +9599,10 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 		return false;
 
 	/*
-	 * Directly write only when we hold the lock of the rq @p is queued or
-	 * running on. See the write rules above.
+	 * Directly write only when we hold the lock of the rq @p is queued on or
+	 * provides the current scheduling context for. Under proxy execution,
+	 * rq->donor owns and consumes the slice while rq->curr executes on its
+	 * behalf. See the slice write rules above.
 	 *
 	 * While @p is queued on a user DSQ or in the BPF scheduler,
 	 * synchronization is the scheduler's responsibility. This write can
@@ -9590,7 +9616,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	locked_rq = scx_locked_rq();
 	if (!locked_rq ||
 	    (READ_ONCE(p->scx.runnable_cpu) != cpu_of(locked_rq) &&
-	     !task_current(locked_rq, p))) {
+	     !task_current_donor(locked_rq, p))) {
 		set_task_slice_oob(sch, p, slice);
 		return true;
 	}
@@ -10478,12 +10504,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
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
@@ -10544,10 +10575,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
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
@@ -10563,7 +10599,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10587,7 +10623,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 8f2425bdb9530..24357d8c5e335 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -167,17 +167,18 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
 	return SCX_CAP_ENQ;
 }
 
-/* the cap @sch needs to preempt @rq's current task, 0 if none */
-static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq, u64 enq_flags)
+/* the cap @sch needs to preempt @rq's current scheduling context, 0 if none */
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq,
+				       u64 enq_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 
 	/* a kernel-forced placement preempts regardless of caps */
 	if (unlikely(enq_flags & SCX_ENQ_IGNORE_CAPS))
 		return 0;
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

