Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889F33F5A8
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995607; cv=fail; b=iaW59z4c6eQozZpzEUMIQo0Fmrjy3s425LRk12sR7Z7mf5BeW8WqiwmnHdVN/91bDJRLOPVLpjawphVwsYPd09Qf1Kgc73I3E6I4J3kpEflLb+jqAkBs4muWZjoRDdNiqHl0q8utPh2OJlQTi6kaFWvm72rmVgIsJ+UNtIEOhrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995607; c=relaxed/simple;
	bh=QKAo9BIIaGKE47XrM3mJYt+lPtLHoGHbJcC7GPKhKZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u75aipjK6AK0e8ANf/CMlIGpK5bZDXJZLlMz1ZYwm5KsQioMkjbJumOR7KD22khraEoamRMQ+0Q0ccKhQ0rpns0Fyrfslr7ODNzVE3ob8wackKazWQXEa2o9MJSD64qC8d8kglib1NWsnCGiz+kv4Em8NodCYpUTTzjgtTYNp8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biwn1fEw; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biwn1fEw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzijIV9sUHaiJCqLafDb6VdetI6Q3KyzdtiW2rSv38K120ShOVDK1CPv+QC1NPCDg8+oucSkJnRXDAsATyfxne/Hzq27TMHrkExFOsXdYh0mgivE+iP8fXUqwqgH+mQLJfKI07aXA1f1iAx9f4wDhguLZZKCbIh8dUJtawRPXlJkv8QVbyW4sRAvkNHUoKc0S6/37IySmWzNjaqpHIW9ZEkwfllt/2HyAWi0FDQIXy7OtYxyQLLVYpl6hjpxjpUUFyha6YVrixqTq6MCoAs2yh/q2/0eHDeWQ3rTFT6AeAEb3RI/bfqaMgQQ3EhIlR9e68Mjy5RXX3GDQpw+++RgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8td4/RTTl8qH35+lnSEaT9Zt0S8bHqRCSL6anCsI3E=;
 b=EHBf4Ql4Q9gChC4M/eQrkK4VFBm4k/wdkuG8D4eXGrEDDmKy2AXbv5GCNxubazX6jKNznQJwc7JoujCWmZ+41zmauc/mMze0qrhZRxB2AtpYr2Q+PECpLFnJUwpLecmPLVineaaZOk7tlvX0srv4g9/J6zZBio7EDMbs+1Ov53x8vP2OGYZXlLS/28Unyw4DwWvsmlA37lZK0VJrggQMjvtm6019IepZzcwGjfl5N0MgAN/O45XFbbk8t6Vk33XLk2cbRKrOsYnPpCQNrpCqzC3/rIKo+Wiw6OkdS0XP1d39lrIpNzYKWV6fbE6SFovUbQca2G4rUCkAx6MiUlFtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8td4/RTTl8qH35+lnSEaT9Zt0S8bHqRCSL6anCsI3E=;
 b=biwn1fEwfd+ScxijyN+CVw7uw1ZwlxWe5SlLWAcnggtrS0fs8CSvGewcY73sg4cmCJo9Jew1J3l+NdXsZuOa87F39Wjts5ye6OTHYpR+JzQv725GSxkBYurWztk5U6xjaBKV+s6noPchX1OhTfJwDAj9jIXannLT25SsuVl7LiuuCsFuF2OYEJyk5jGDA7Fh/qQAgW3dETp7uFO8jWterc0T40oTfpBLfE5p07dvf4o7wTEQoaYXZ00dTcxawmhk/sQVKCazyLSiRl5IWzyko1ad+aBGyp+4OrbfmfrzDduIX7q2ADMA6ZqOag/dkvta3/S56wPLvA+y/YoUBskBxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:06:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:06:39 +0000
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
Subject: [PATCH 10/14] sched_ext: Split curr|donor references properly
Date: Sat, 25 Jul 2026 18:04:16 +0200
Message-ID: <20260725160513.57477-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b338c2-9958-4a76-81f0-08deea66b5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hR13czGWwsHLoXmuh+8wWyD9e50aBVP9XNy89/n3/92YpO+u808VNtnGPtwxTmaJTwgqjn6iCX3MiBtnSOJZLs1ioQraZLwVkcZZ+6UfneN+eiDS9veBGYXt68HLYbVnafp6zYcUoo7pqJ56D6H1XYaLlaggHrlnGcIfOpfMjU372ztqlnrUfeyE3T4+6MC9lNriod0cPPrTFvjmteTFxNvXu/0gc12OXDtwHyjW6dDRb2CnShcnRfn3m4YSc4Wt2aPbgzUafhVI2OS2XPmK30HLzpsf4BOqjB08MChu1EQGDTdxWaYZCWp+6ZsbpUpkzALt6pwRfSot0wn2zkKemOmmtRmTcFpVg2Bpi7hEHXtfW5xt+fTWSMkO6ARNnVQy1zBulZsgXye/v/GDXERRugoWnz+Aml0eWEdSbznz0pWLkbxAmJOUV/BdQw4K2d+UekMPALGwx0hbFn6ZepW+YQox9XxQgsgalfMQIvk2RBiIpEX2lpFxEmSY0UnleXqKibymURQam8ZIIMlGOytrZk5nxzVHlmtgM21N5O3lG7eRns4M+chGCzYgpbN7xOwXWg5fAO1sjcpCPh3A4zKLJPEw66ex2B3yWXD/LTd20g3s5o9XUqDM5OnI9cpJMkDPetIAvEM4R9feqvqoryekAfF6kXf7UX6G5VWADbkKcc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ook/xpY2mFkNz0ZBS8BmsMG7Zfic0q07LxKwOuTE2uxlZFLEQKFSwFr6GbVM?=
 =?us-ascii?Q?aljNU7xSi9R9ZVMQmnYYb0fEvLHJpRiqnwOACNTN+3ehSGR4XhYGvJYcF2o4?=
 =?us-ascii?Q?1Ir+/g8s7PlEK7h0MROtk2dwgcsY3cEAuFQ5dbniN2I58fGA867YlH6ZKeKg?=
 =?us-ascii?Q?Cml0AybLuInXnRV4SZ9jHa+ISmVIC4wiwSPnTmf6iaSKfbLhvTrC1nEa5oh1?=
 =?us-ascii?Q?cECYf/+YxS57a2k5K+zdmjEpakAduVp4MRHX2KsBTYVIBEKvp1+HmozMs0J1?=
 =?us-ascii?Q?e99sOj74jK345FqcjR0U3G9Vn8YQLa922Mn73O7Ojn4iQIfdb8d+7ir2pMIW?=
 =?us-ascii?Q?/N10H17vemnxgPUE+nyOoeC7nvatRhcAwp8f1zO3Ez7P/zFZAr4QqENqNWHe?=
 =?us-ascii?Q?HJuJSreu6W8xJyvR1bkUv/A5msJuek5Ufdihw/N8ACfFWE/yNgHv6X7n4V+n?=
 =?us-ascii?Q?AAj+BxK8Ytb3rQXAsfiq1dw0f4Rs/1ItCvgGvAKwCmaTzjffsaKPQtSLKwV4?=
 =?us-ascii?Q?fHhpmVCRmpb7szMyyZhdowz6Vu0uddyC4Gb6/q2Ct9KOgAItO0UbJvXtgub4?=
 =?us-ascii?Q?nJRXN1W5kWC3eKhLJQarqVPhfQ+MzDdvV1SiRSTA3M+OMbAybUnOCsND0RO1?=
 =?us-ascii?Q?+aKV+lOrQySf2JklXqT1t8RTlC31kb8cHRlgOrEcDzQbNUhMqcJnB+0FnfMf?=
 =?us-ascii?Q?ssnSWF1CrZKveq8en1eOvAgtKgMHqU/JpKisWvvU2E8gJl3IE1nMz3py+UwS?=
 =?us-ascii?Q?Dp5Xgv2AxDVYhedSA97FoGcWR7X15ib3Y0x8i4qdPFLtwIhddFx8pqFJvrtN?=
 =?us-ascii?Q?FPh5cZcLdPFC55JvtId3jksc/t6GzW7QI7A6gUbKo7YIpmck/74u9xkVYH5u?=
 =?us-ascii?Q?sppzMA9zOPU6hWWKrA3+H5ZZso5bXO8XABrBLctwUc1XpRH/rvugbcN06OAA?=
 =?us-ascii?Q?p1qlsY8bfrM4hwDaF7g/tHcX29nhL0RUILGqqwU8+KspAjAA9+MxTNP/xztH?=
 =?us-ascii?Q?etco+xLDJ5qNuiclWWUWAxsxzn0jTk3dNtOrItj7pOeehXEulUzZNFJkMpZP?=
 =?us-ascii?Q?gWDCaZrM2FYn/uKlEF6KeWyOz5X7m32wnM/XcqT8F8SoSpH6A6Kt5k7Qcoyg?=
 =?us-ascii?Q?XtRPfTgh3o18p0SxlASYYMkLk11avT+QNNdB32NLg6msF9PKS7096aTlm25z?=
 =?us-ascii?Q?SLbuIi5kjWxvQQ+xqB03jdQpAwE9E9cn2MIus3VQanefn9UMuwCLGcw+VZA4?=
 =?us-ascii?Q?1+2Xw0BTFyk+tifPs4ODUFIyu2ou5zYlJvwptrgxaMEV9nyiRQBNjKJPFEbN?=
 =?us-ascii?Q?wf6Qu5Hl+6y/57aqKs6KPuFZNQHpFknbmg1X+71gQJCOsVEivohoc+qRZl8q?=
 =?us-ascii?Q?S+zTSSZmgA0uEthEhXQDJc9rlT+iG7Lbgn6I61SaMcAw2+q8hEaSCZRDG2ED?=
 =?us-ascii?Q?OkRyFtjiXD/qsviqFeqHButLtlvIbqxePVKkS6Wrd0d0cyj7ozb/IfeeE2NV?=
 =?us-ascii?Q?Yi6Haz2hj+NQtFL5LU7gSy3PLK504I6Vyp7ZSrVV8/K0mxBX5+C0S/iLVZNg?=
 =?us-ascii?Q?jJ0BJFPrSmlNKbCF3f2kRYHfNKlzd0GiMWcn3boR1I5p3sjn8BJmerVoJ5Vp?=
 =?us-ascii?Q?wRXjW1YeMjg/YwBkREWSb78Vo/dtOG4pyTMwEXjwwwU+C1OkXYKwkRA6hpWj?=
 =?us-ascii?Q?LdeeeiP4MRbsUaHR8oQPDJNLkwMTA74NYErIo1fYK9C4oviKrf00jXddqY26?=
 =?us-ascii?Q?ry2jGLXpiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b338c2-9958-4a76-81f0-08deea66b5e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:06:39.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS6xJ2SAxj97NQ32Qm3JztxNCdxhe5fJr7+7POOhQ9sJOZqN4NlDWbGQMPM9X5fLpGvUysP8PixIgQz9mqyH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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
index 95aca029a6e57..c6720e5c78dad 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1327,20 +1327,27 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 
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
@@ -1516,9 +1523,9 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
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
@@ -2061,13 +2068,14 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
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
@@ -2783,7 +2791,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -3007,6 +3016,8 @@ static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
+	bool can_stop_tick;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3031,6 +3042,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -3041,7 +3053,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3062,7 +3074,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3251,7 +3264,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3650,9 +3663,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3661,13 +3674,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
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
 
@@ -4305,16 +4318,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -4560,14 +4573,18 @@ static void run_deferred(struct rq *rq)
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
@@ -4581,7 +4598,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6775,6 +6793,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(pcpu->cpus_to_kick));
@@ -6818,6 +6839,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8331,7 +8356,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8348,7 +8373,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					set_task_slice(rq->donor, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
@@ -9317,13 +9342,15 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
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
@@ -10160,12 +10187,17 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
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
@@ -10226,10 +10258,15 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
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
@@ -10245,7 +10282,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -10269,7 +10306,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 08d46b92633a6..e2e3c2f52a146 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -139,14 +139,14 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
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

