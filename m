Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10893B14A9
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901915; cv=fail; b=I/6G9G3yO8kaF0ubigdOGtD9nrm8M0ugEmcIjrUOo9yEjbcAbp2ssL9xh7toV/Q8OIbyOWkt0yJKuqCfxrRt+zysZot1Aob55ycCiKcRyNXr19oGoFBpCghqqHLRp/0XeyfQHeLoPGMjuzc+lXd6LA1r/+xtanTh9cipOAg3BFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901915; c=relaxed/simple;
	bh=i1mYbYAqauzIppv8Db8IV5rPoKdK7DYpmTK7l+ZodRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPNfacHlTrGJcq3N2dETIMEwqbRL5itGaSLn1HrMAZ1yhZNhEGvJiHXqrG64Dhn3zL14PF1gfrhQyYTYyFNu3oblM+CdxtvbatwQQe5lCF41qtA7Ec1W97ReAZfOfk86pz+RRdiP6uW2Blf+QqnC1Forg2M67gTEIx/t/jijlRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8vDtjjN; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8vDtjjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5ucNjMVY76+BkIIpq05WX6msvUD5sYO4pm9KA0VujwNGvnUXkN3hI2CfchbgKiCgPH9uqef9GUeClBG9CBFaoRFahHEO9Cnd47fV2zHmkByhnFcHj+LFcDppbtn4+s/8k7PxeakHe4Ru6h31fZNW+TTj1sx8cQqIcCUzNw4ruB91PdDb7bH/QAbvneeFYFhzVKgGSjCphCgVf4AfHO8ecs1zII94IK31Ntg9pIVRON4tEOHDai6h/2ySvqyd5NPzPWHE1H3baMRaswlMj4IJ1ttT/jPDTpklX7XwYLCtKg2WhcrTOpYboSRgu1qQG+Tjl9KMSSNQp4yNEOElbgqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVtZVH5C84BiT8dHFZl8uRwNGU3i14AvT3Q9DoyourE=;
 b=hr6eMaz/cIVQcVRkfuhul+WwyVaht3cGlWcJ6LsNkGu/6J+7l3OvaPPpYJPbrFxrTeYIhbsohuDXcqJNKrAP3ixoj8mqgIS0/NE1BIc7kvvzR/lfu6piAmTYvzvaAu2lG7U0SbpZ5LO+CBESKyq29zV2YoTakXpVPdmk2knKlzz0oFpbJAfKZIkvJB0e6mDQQhltZnadTGGE/9G94o+gVOUFCWsSIUNkLXvC2IguSFH6PR/x3W/2nEgrQHeSh3kGBOr+uGZJvLUqSv3ybj4eolJZfxLSFCBGBz55QuQzJUnO5xt2pamaduIAXgg7C8J+lmRxIcN5EFNc3jHPZ31Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVtZVH5C84BiT8dHFZl8uRwNGU3i14AvT3Q9DoyourE=;
 b=f8vDtjjNW8sBatwjxb5PDe3KhMLBjMlJ5PVoYEqY8Otqoyvgi2QsLmGcHp0OwYXhf6xhAYGBZUprBx4LtiklIyzGw81TqCfQuqfu2cJe3z2AhMgsL4UZmhNUKjirotaM1AxjP5dIyNe8+7kKKuEuHXRy+nnWuXcMVJTPAYh6kMFYdm4EcH3y2pMZO5WrOHFdAZQlbZexw17jAFUDJ2NfGHOeplx4rn+OVXntRi0zZCF9HouckOYwyZy1+IC5drvKDygcVqOODOI5CmiN8BZ0cqoypk1pUcDEH4X/RvTKXSGktGMBCaOUmBk9Cesfq3Um970XtcwyRde5QRxj0Wc8jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:28 +0000
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
Subject: [PATCH 13/17] sched_ext: Split curr|donor references properly
Date: Sun, 16 Aug 2026 19:35:11 +0200
Message-ID: <20260816173732.17162-14-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B80.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::417) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 226c2aec-8d4a-4cef-36c6-08defbbd2e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+bEESWoV4j775FRI2bdTq51eSpmGFivXdlhFWJgghpN4oByC+I9R1vEnuAxjlW0QhuMs/m5UOYsWu+ZZB7w/Bug/HkT3ERMw5VotA6BzSvMgnd99tsOQ6VZiXBpULwk85uQfY74yLFsZq3exUL2ZjBHTAQQzFaJ00yoZAyohQMbXjAACN1YjFhQmLfpmt7zMByvUMilKi6qktM9K6cv6pZQH5y6upxb61KibxlcOJ1DxNyEDvY4mo7VquKp+gGpSdE/RdkOHTzCo5EDr/LAluBLGeQ2cZCVtykuEYBVuetw6NkS1cEmiiTZDZfsr9C/gTqByhQSDksLjWbfqrM8dOz26uJ34P9UKXbUZhahuSsGjUmiC8CjTSRML9f1iVXXU4JeCPJvaSSHVxhZTKE9v84aPSyMGkwrRyvI0OsPa+iYjAniu5Oz+FMhVAUseJ3KRFTeO1t85BNce7gkY5nYX/pst1PAx0bqmYk4XCopQFd+Cxg7g2VKdZtd9Qa0mR37S1tytEeJWEHwrUHIkdFZByBo8mvpI+OD8Zuzv/ESbv8SD9M/G72lYPnfyGQvwSQfYYvaiD0bfCVP0y0Ihegc4yBs53EnWas7/Hd+KK/yfYtvpswVHMXSU58ijSdlFsXCevvFBha5eZfsLuz8yrUEku055HF8hIk74Mc0MQWwVASI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GZ8NwBt1gewZIgxs+AkquhdLL/Z7TIys5s4a7UbhDBtulCs6bUuBrfCKMX5C?=
 =?us-ascii?Q?RxvdFpniRqQr63KmThITYEgGrRKjBrx19wRrAjNubRRMi3/Ja2NaIkUDUejE?=
 =?us-ascii?Q?5AnPao1imd095rdc6fVnDXrAmRqqGmZeXJh42j8O08pnekrEd5umwHkn96yO?=
 =?us-ascii?Q?MtDSAVvZBnYEVY8uiKBndy8tj/1CBKoUCorRUVPvR/Jn0JAvgqTAVulYBx0J?=
 =?us-ascii?Q?A+HITIGESdje/xhDDJLzK2oDTpQRwQaB6odPAyVsbJOxkwtPROiH3BB92A6K?=
 =?us-ascii?Q?+6yjn0b15gJLcltM6NJRd6Q6KqJ7J//VWAjilvTNefUXEYMW58zoFZFl5zCi?=
 =?us-ascii?Q?JaeQV1ANs/+xoBi0gOVamzoBsqHXj/FEdtI8YryYP8j+2ZyAR3nRo7m6MuJG?=
 =?us-ascii?Q?o10Zuwv3Lp9YLC2J+kvfHx2/xpBmI1AX72KYkQZVv4GHvaW8082iR43NYyWh?=
 =?us-ascii?Q?E/zBvANqjxb2RQcZVCeXk+oVwFyrVc9LpRETSsgn6wBsPxVEia7VqUP+cxCk?=
 =?us-ascii?Q?Mq8kZHXX5fVd0arh3ngBvSgxRZsdmWsHlhnxmVunUECToA+RX9/ICAENhO5O?=
 =?us-ascii?Q?agM99q6ox0ibAnQo+5WkJnuonYCCSrttQH19ynKfXG8tXrdpnJZzw9vst9hI?=
 =?us-ascii?Q?oXwPjXLoys1K+5j3B/v+325kPbbD9nCGdiw5RlHYXC8donvBHlKGxO1Pol1O?=
 =?us-ascii?Q?J62j4Y8s19a2Y1UNVGJhkW6w/0UIHAIL1ktOGldVKZdon9lQLdQtlFLH2a6w?=
 =?us-ascii?Q?W3SyCPDAOffQ/XU9cd0O4T9wx2M15Bt8Aip/N7Ksg4FEBsG0dIRh+GdgyFb1?=
 =?us-ascii?Q?U/E6gSlhPD2c2kmmJpG2VPZBERHSmb1Vb1qtRv+SZO9pVCx1IeIWLQ8ZrC3d?=
 =?us-ascii?Q?ve7/UM68Q5bGWj2yMBbU6UurQwefCjkHh6W9cYrMaFSkhQArb05TTumTg3i/?=
 =?us-ascii?Q?CKX2kz4Ry9VgQM3HjfGU0kk5vOOGyY4mo/Y15Lfs5pMTKML5O+4C/mqnwBSQ?=
 =?us-ascii?Q?8zLYTKYx4+xo8Q4gDY09bsubOQYy2LTe3JPODQ2eh4JL6uiesvybhVedrsHY?=
 =?us-ascii?Q?66gUeKOKfKz9PKKbAfvMomsVGPcttjRG60gBJ4NJ24d+Hh5L1A2q3PWiUJQG?=
 =?us-ascii?Q?5JVDWxM8yd3RJzbJkqHIP/I+PR9k+nnhbezCeWDJlwSVpLd2lJrxbLeFijNV?=
 =?us-ascii?Q?orOVI354ryfdn5rF6gUqdvhBRosbnJf2UtqcBlWZuWcvTgyIDZozRZOBHzBo?=
 =?us-ascii?Q?D5GyF6m7h5sbpX2MfHoD2LottEizMxJWqVBJOCYZZ3EBW60+xkCjuaPvOWyD?=
 =?us-ascii?Q?WEQ0tFCJHRP7W5FysvSpGcPs/ThbcEY9kQiHZMEHQPR+l5seCxLTrIIOm3tB?=
 =?us-ascii?Q?QAUxvZDiRZgoNJAl31dsJJCprrIBr0vW34ab4HZ/8mGIkVTNN1KE3TpYri2V?=
 =?us-ascii?Q?Uo+79roQMcYy7yCu2s5Eq5iiDJvbnx8Fe0dP39qb9QKy4C4+m/wfKd6Yb7YI?=
 =?us-ascii?Q?GOeqRwKS5OvfuTolm3gQefI0dULz3YpBfy9khNEEOZJPS1q4Hl3pzPu0gK6I?=
 =?us-ascii?Q?5PxeZqybCIJ8PZusNm2W8sr7jGAUBGbie4Cf7xFv1fKBMaPINEId5qayZVJT?=
 =?us-ascii?Q?5Y71tITTcr7Gyk8e89VW6V0xhAvhjdApCn+0ipdZYHLsBFRfD/O26aEud9JT?=
 =?us-ascii?Q?zsSDoUjq1ltQ5LnztaF/N6HcqeBVHMVxMs2G9XVeznJ2ZQ2+d6j8s9orNXIr?=
 =?us-ascii?Q?LDmseuDPCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226c2aec-8d4a-4cef-36c6-08defbbd2e90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:28.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKjV+H1xc6PA0e0TEl4NcMqDSrx6+4Q5CtfioCPDBbgFa3+yDrrb1hkimkw4yW3WngZmWmomghxYhia+gAVZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

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
 Documentation/scheduler/sched-ext.rst |  13 +++
 kernel/sched/ext/ext.c                | 128 +++++++++++++++++---------
 kernel/sched/ext/sub.c                |   5 +-
 kernel/sched/ext/sub.h                |  11 ++-
 4 files changed, 104 insertions(+), 53 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0e97fd0199940..38ffd6da516e5 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -488,6 +488,19 @@ and edge cases, to name a few examples:
   class, in which case it will exit the tick-dispatch loop even though it is runnable
   and has a non-zero slice.
 
+* Under proxy execution, sched_ext continues to observe the donor as the
+  current scheduling context. Accordingly, ``ops.running()`` and
+  ``ops.stopping()`` report when the donor's scheduling context becomes active
+  and inactive, even when the donor is blocked and a lock owner executes on its
+  behalf. The physical execution context is intentionally not reported through
+  these callbacks.
+
+  A blocked donor enters a running session only after proxy resolution finds
+  an execution context. The session remains active if only the physical
+  execution context changes while the donor remains the same. Running sessions
+  are tracked so that ``ops.running()`` and ``ops.stopping()`` remain paired
+  and are not emitted recursively.
+
 See the "Scheduling Cycle" section for a more detailed description of how
 a freshly woken up task gets on a CPU.
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7fdf16886eb27..4890cede57281 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -379,28 +379,28 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	 */
 
 	/*
-	 * If we're in the dispatch path holding rq lock, $curr may or may not
+	 * If we're in the dispatch path holding rq lock, $donor may or may not
 	 * be ready depending on whether the on-going dispatch decides to extend
-	 * $curr's slice. We say yes here and resolve it at the end of dispatch.
+	 * $donor's slice. We say yes here and resolve it at the end of dispatch.
 	 * See dispatch_one().
 	 */
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return true;
 
 	/*
-	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
+	 * %SCX_ENQ_PREEMPT clears $donor's slice if on SCX and kicks dispatch,
 	 * so allow it to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
 	if (enq_flags & SCX_ENQ_PREEMPT) {
-		struct task_struct *curr = rq->curr;
+		struct task_struct *donor = rq->donor;
 
 		/*
 		 * A protected slice refuses the preemption and the cpu stays
 		 * occupied. See rq_owned_post_enq().
 		 */
-		return curr->sched_class != &ext_sched_class ||
-			likely(!(curr->scx.flags & SCX_TASK_PROTECTED));
+		return donor->sched_class != &ext_sched_class ||
+			likely(!(donor->scx.flags & SCX_TASK_PROTECTED));
 	}
 
 	/*
@@ -1407,20 +1407,27 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 
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
 
-	if (curr->scx.slice != SCX_SLICE_INF)
-		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
+	if (donor->scx.slice != SCX_SLICE_INF)
+		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
 
-	if (unlikely(curr == scx_rescuee(rq)))
+	if (unlikely(donor == scx_rescuee(rq)))
 		scx_rescue_charge(rq, delta_exec);
 
 	dl_server_update(&rq->ext_server, delta_exec);
@@ -1599,9 +1606,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
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
@@ -2180,13 +2187,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2351,7 +2359,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	scx_dispatch_dequeue(rq, p);
 
 	/* see scx_task_slice_ended() for the save/restore exception */
-	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
+	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
 		scx_task_slice_ended(rq, p);
 
 	clear_direct_dispatch(p);
@@ -2918,7 +2926,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3144,6 +3153,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3168,6 +3179,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3178,7 +3190,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3199,7 +3211,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3520,7 +3533,7 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
@@ -3950,9 +3963,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3961,11 +3974,11 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(curr, 0);
+		scx_set_task_slice(donor, 0);
 	else if (SCX_HAS_OP(sch, tick))
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
@@ -4610,16 +4623,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -4870,14 +4883,18 @@ static void run_deferred(struct rq *rq)
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
@@ -4898,7 +4915,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6384,9 +6402,9 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 
 			/*
 			 * Bypass trumps protection. Cycling clears for queued
-			 * tasks but current task needs explicit stripping.
+			 * tasks but the current donor needs explicit stripping.
 			 */
-			if (bypass && task_current(rq, p))
+			if (bypass && task_current_donor(rq, p))
 				scx_task_slice_ended(rq, p);
 
 			/* cycling deq/enq is enough, see the function comment */
@@ -7095,6 +7113,8 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	scx_rescue_dump(&ns, rq);
 	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
 		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
+	scx_dump_line(&ns, "          donor=%s[%d] class=%ps",
+		      rq->donor->comm, rq->donor->pid, rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		scx_dump_line(&ns, "  cpus_to_kick   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_kick));
@@ -7138,6 +7158,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8686,7 +8710,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8706,7 +8730,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 
 				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps)))
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
-				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
+				else if (unlikely(!scx_set_task_slice(rq->donor, 0)))
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
 			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
@@ -9689,8 +9713,10 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
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
@@ -9704,7 +9730,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	locked_rq = scx_locked_rq();
 	if (!locked_rq ||
 	    (READ_ONCE(p->scx.runnable_cpu) != cpu_of(locked_rq) &&
-	     !task_current(locked_rq, p))) {
+	     !task_current_donor(locked_rq, p))) {
 		set_task_slice_oob(sch, p, slice);
 		return true;
 	}
@@ -10603,12 +10629,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
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
@@ -10669,10 +10700,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
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
@@ -10688,7 +10724,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10712,7 +10748,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 8a7b712228bad..22b2fabb896bf 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -285,7 +285,8 @@ void scx_rescue_charge(struct rq *rq, s64 delta_exec)
 	rq->scx.rescue.budget -= delta_exec;
 
 	/* per-cpu usage average feeds the overload victim pick */
-	pcpu = per_cpu_ptr(scx_task_sched(rq->curr)->pcpu, cpu_of(rq));
+	pcpu = per_cpu_ptr(scx_task_sched(rq->scx.rescue.curr)->pcpu,
+			   cpu_of(rq));
 	pcpu->rescue_avg = scx_rescue_decay_avg(pcpu) + delta_exec;
 
 	if (!scx_rescue_slice_remaining(rq))
@@ -557,7 +558,7 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 		scx_rescue_admit(rq, p, slice);
 		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
 						 &rq->scx.rescue.dsq, rq);
-		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		if (sched_class_above(&ext_sched_class, rq->donor->sched_class))
 			resched_curr(rq);
 	} else if (p->scx.dsq && rq->scx.rescue.budget > 2 * scx_rescue_quantum_ns) {
 		/*
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

