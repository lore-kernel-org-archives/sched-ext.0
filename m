Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E931352D
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253548; cv=fail; b=gNPsIFiL1kxjf5L2eqgVVvC9MRJOGdA1CS5S5SNClu/CDmbSyckkp41bn+a/DGkTstyvm81ZK07kKS0UAlZhMacgsVrXVgJH8lHgBf8y5IEZF/Yks3h+UoJND4OvN430s8JqIsjbnO5mtWIKOA++9lRgi1wbzYVG3zaWLLLHvVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253548; c=relaxed/simple;
	bh=RSFrbsojGcZtbuUs3GT7+QKSrVLaeSS7H4MfeGyBRjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbM7EcMI2CYY/LHajTMBR2njye05dZTK5033loBaTzInlurBcQZGZnaedyay/xc3qYZTlA1qWTXVaE8SFlbPdcQi357EY8Ktzp/KEskBaD4/rN4wG3ypNRj7/1NlHy1Cyd+LmhT0DwJhLSaxMQ6Ci3h1AjL7e3m2QfgTvbU3pkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+GcUS/n; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+GcUS/n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q42EB/HPSZVSLJ1DdrLniFeguaCRKtoT4N3+v7tgx6iF/0lb4hypyzwR2HvtDtV+GlYxK9iH3aoO6/5D9fIE9QGzMCq2F2nqMscu+jOfyhxSYQYUlZIaSH0FEB3wAI2cL3ZkeblE8kLDq22EM8iTfuCguBybKDRF2X/JVftU2TtZKx51+yQ7ufeIDBP8FWGLz55qqnWloy6kekjeINIl/JWcmcluFsJyuUob46emfdcyv+90oSO+w0wT3uHDDW2C64Y5ya6uyXlSiAsXA0rQ7/ZSKXjslSn9M6nOfHmk9dad0HSQDghhP/7yJa48jvNfFU1l9z+0PaUbyNTs+JQsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtFz0AVf6UfKP/Sakkw9RPsa1SBJFbnhgKBEPT+7pCM=;
 b=m2L9RJhvN4e2jefXhz61HZCCaHOkZCZxQi0E6yZkN99SK1pxLfvKcMjgQZimNeTKz4WwP/bttjWjYeAIvqD0MOpp3MQIIk6sVgTepLt2AM0fALjat910Q8+a7acmsLi/7rlgpAg0fUH06OJ1RVPg7D6YOkSVrKf8X15teyS/JamNiumHN8nlgOktUvpK88yDthJVve2QhopPy1TufcgDKfONPTgdvdShmes4ntMEfWT5gspQE14DRYbauI7nqBxbhcWuQR4Q0f97Dxn6Xp+EUlhsd7ZI5DZoE2pdClZqPHijQ4lYGfTtA/RdhQZUqTVNbiF8A4z2TiSrnECQOvKtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtFz0AVf6UfKP/Sakkw9RPsa1SBJFbnhgKBEPT+7pCM=;
 b=p+GcUS/nuTjZaaMy3Yd0yFJAgb4MxhYR2x+c6uNJOl94xSBmMDWVlkbNAVGDG5ErEdr6YhFJXHW74lKZ8wbnrr2JGqDlvqI9TrpHN2BWmKow1icuaAv3BdaAf9uCmJgKH0aURmDL09UtLyPDPaq0wgXyOTWyNtroDVRomrHQElT4nDbIXoX8cGPfM5alRRG4e5DG0KIRVtlOJ/eyiEUqwb8Q6JNjgr7VrA13XMenh1DjfdJ2/M8UcG5iNE6HJ0zr/ZpPu4HKJM0R7yvYV5Ct4VvM9u3G82sxeFtLyFU2eHm5/+Nbui+89a8pyf3f6OabsbeQG3uZ1FCzALBes9ycCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:37 +0000
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
Subject: [PATCH 11/15] sched_ext: Split curr|donor references properly
Date: Tue, 28 Jul 2026 17:43:29 +0200
Message-ID: <20260728154425.1549660-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 380b1d83-aa13-41e6-8827-08deecbf44cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|5023799004|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OdvPPKV8OrOCZbdpjx2gFSat3rUyNYSrGkOYA37d3UuK0TMu+4LTFpoUaTTn7LOf0JmQipw4qJ46Oe+LyfyvxKw2f9gqHQ5+OC0I/uT/5FVUimypHT5v3cNW2R8V9Vo1vMeuOMUhplZCfdvY62tZgSm+QB6SUDK53XMNMrcu4JPnwXaap9caTn9SoHacVw6DK4HdnFT2peD2PQAXjNqkt3iepX5E4wFlg7H9T05KKG+2uV8r0LGH/r8+i6d6zhrFqOzyXosuVpi+7MjKhorhF82c5BBR2BGwU4zC6D/ai0eutsb1OPsM8a+VEOeE3s0J2eMv86u7jPSggX7rJ/Gr+Dq8YJ8x2V0/ZkM66/yvl5tvi63Onmhv2giPGX5dl19mtc47yn6o9xF6SYnnITQsq2VVMq2AOH4of5BGPc7c4F5WecWc6OndWKbKwL6NeroqTh1L9AGEYP+iW00t9Ag5qCl+ti+7TTORqRtgFgAjjprgKQMIhzysSRtvT2XWZ/CM3HsX7W7t/SJ8AxRMAO1Wr0bR6zaCsRo1ei8y+5XDVN9wPkfW4wJpT8UXnzGVESl6j317jNW4Z/TO/nkMMjBgzQg2qq2wwQeMl+ijWzo0ZVWlHNriMhbpb36vQTl4TKjJeRP+5Lt8qUpiN5KbkTh5vXLCs2RL4ujzM36iY4myunw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(5023799004)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0c90VbYVCThCsJOfU71wWyq9Pm6+fnJaeW22V6guFuaIB34j9wfD0MM+A11M?=
 =?us-ascii?Q?Uq8lEOQoXQPCkDTzFb+MuI0fFC09SdPW3Ijg9pkDWpXAHdHLdBYKrHcsZTKm?=
 =?us-ascii?Q?t3+Wc+1tC/RhBc3PS7hUBHJVbPKFO2fZuhmKANcr+Cdc1L8QQY5ulEmSb3Es?=
 =?us-ascii?Q?e7JUQLJNEtemt3hKN6roPJOTxsZ0THy2PfwqcGh25bI3bzDHTuXBSlEFICsL?=
 =?us-ascii?Q?XWVh9bYaUhwQqV284K9eutKxS8AhmuM7VnN/zxwlNnSUaQU8RyhEnLUt9jmk?=
 =?us-ascii?Q?BbB3FptxaH8KUqBYJmjSHKRX6ITHEjDWlVFGH+Sgl79xs9G8b/+TwsGBRQPd?=
 =?us-ascii?Q?k/M2mU4k891y8NYCBLF6+RiBhG1N/J1Qy3uB6bTnc+gGEsknWrF2LK3RwUkk?=
 =?us-ascii?Q?OG1SOFGnGx/EMf/Klc/x44By1AaHKl+dRo3a32CC4oKb2gBN09FwT3FuNRX2?=
 =?us-ascii?Q?hA9gkbHDJMORQ9kqyn8bIV98yvSHBE8XxYGQL+tPc6pGgUe81F8QULS8N3Zg?=
 =?us-ascii?Q?w/20Rt0GFUxohUhBTUn2YqiEMncgd5uqVxiWuhlOb2UCJC2uIzY/KUvS0bQ0?=
 =?us-ascii?Q?llCGgwe54AGRmWq3d/cqUTsyx68Okz7ta0Lxyo+Fikm6WGpcA7jiaAzDlBEG?=
 =?us-ascii?Q?sUqz1p/Eo8p5RME6Eu565sj5DVEe4AO0P1t5prhpSt5+hMg0Gnw+d9RgkC0b?=
 =?us-ascii?Q?Z4HdZPTucXOVhZmJPO/c3mY0QbXRPWbbTmWKvepZvIclARe9a3p7fYDCUqn3?=
 =?us-ascii?Q?OmN1tyidQRh4CJEjKNKw2A+gqG0g80oltRG9PHMPWOZGfWON5tL7nCWvB3RC?=
 =?us-ascii?Q?qwfK7m0e7NJ30xxWO8FaapwQBWGs73TvzKnUZhj5xk9JvkH5LRwaR3kzgd7j?=
 =?us-ascii?Q?uLyz83dAUB9xurbEZqhT/yMO2Dx60wKQNz4uBp+KkhQYN1SqB6739UjYcPB9?=
 =?us-ascii?Q?NFaWsGxIPPKiD3Or0IFW7lkGBbpJ0I8CJZx+pjT71+mGIdFBHOLi4+jj7rTD?=
 =?us-ascii?Q?y4vIXusaIU0tWHS4cEOivZ33iqhJAjhQpSOsJujvNBv6AAoNBHhLzDwqC7wf?=
 =?us-ascii?Q?JXZDEHbyYru74H5UzLzdGL49/AH/12HeAyMyqED67rc4v/B30LwLsU8+PhrD?=
 =?us-ascii?Q?lPa8qHoB/HcTKg3faeTnaMKcsEq8CFDH4+CFGFqMQTt3AOKTvAOkXylQITCX?=
 =?us-ascii?Q?Spr+cGOMFE2zj1J15mfYMb7yt86ydME/PbED+SikGjUrbZNiIPSxIgZqwlnE?=
 =?us-ascii?Q?fns/1LKWUS4liRpfU3G6hgOgYX/NAjL84WUJZ5AEw2co+/fkWM4QhKdX3SWe?=
 =?us-ascii?Q?HXaxdUWtW3EDZFw4aeLzpwh7nLd3W+SP2VIZHAF3WPBekxV5EagXJjrJTY5k?=
 =?us-ascii?Q?iTk6E6NBrwXbD3XBgOX21RT7sAtopUh5iZ05hPMuAF92c+aY6qHm769nFxYi?=
 =?us-ascii?Q?XsOYRqhEiAgiVExCaQ7Wj6bHmPcj3/jGLUp7uBGIN0y49RyHS+ylp5fjyHSw?=
 =?us-ascii?Q?9GyRdiiW73l+LaqmDe9LpJpf8QBXhQIzugIC0Y1Qq8nzBJ4rG2XY3vk96Ax6?=
 =?us-ascii?Q?9ElvLq7s9+WtAFeSc0Qdb2H79/rHO4nHKRhYTvBTFywAdvXfxryWDT5w5FeY?=
 =?us-ascii?Q?MLtdABlZktmiK3QngZf3px5rD8J6Qt9FnJ2smHze2qXCTm877B9zxAPxpdHh?=
 =?us-ascii?Q?RIu/GD+e2waqR6zVERBSDDiEp6igEEjSn+tjFPVaOnO5VCi4zzL+jEqYn/mN?=
 =?us-ascii?Q?B6kdrY0WuA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b1d83-aa13-41e6-8827-08deecbf44cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:37.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnAZczeeUQxgjYZrnE9/pIuItUl+0MfJ0veVk0Tcpm0NAAjlAsHnvMxXwchQXcmcV54WfcNZLWhFy2khE8znPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

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
 kernel/sched/ext/ext.c                | 115 +++++++++++++++++---------
 kernel/sched/ext/sub.h                |   8 +-
 3 files changed, 86 insertions(+), 43 deletions(-)

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
index 3fe66298d1811..5dbf89debc6c7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1336,20 +1336,27 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 
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
@@ -1525,9 +1532,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
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
@@ -2090,13 +2097,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2812,7 +2820,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3036,6 +3045,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3060,6 +3071,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3070,7 +3082,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3091,7 +3103,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3280,7 +3293,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3679,9 +3692,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3690,13 +3703,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
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
 
@@ -4335,16 +4348,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -4581,14 +4594,18 @@ static void run_deferred(struct rq *rq)
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
@@ -4602,7 +4619,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6796,6 +6814,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(pcpu->cpus_to_kick));
@@ -6839,6 +6860,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8367,7 +8392,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8385,7 +8410,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					set_task_slice(rq->donor, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
@@ -9360,13 +9385,15 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
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
@@ -10251,12 +10278,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
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
@@ -10317,10 +10349,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
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
@@ -10336,7 +10373,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10360,7 +10397,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index b5870aeb9c625..0579e32015d17 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -153,14 +153,14 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
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

