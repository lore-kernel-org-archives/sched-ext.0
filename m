Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E233F8A6
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321505; cv=fail; b=ZNOWrsnybtDc5x43vKbNTLMGw2VzBlzN/gwndjD31ndQWPcMm1tcYgCeuBrKin30EIBSQmlitTXBXXIrYmqD04xL5iAQ8I5MPh3Q/RKJrG8CSjdro1L9gthXl6XUjpYHKQMNHw1tn+hyNBR+9SKADgSoODn9dC3KbfztWxjX8Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321505; c=relaxed/simple;
	bh=9rQSuMGMtSB+TsvRJeC3TWRv4nv7U8/HQDmLOnkoH0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ra6gysecmYBKm76of3gKa8qDUaobcWgWqqZQwuvGy2Dy6w7/hBQoDMAapISHF1BYZ9RKi1ctWBuG/U8XuVD8VBOo3r8NBuIftCJc8czQcqIwVVpngARLEQjCsqEoDmmWve3ba1NtxyYGimMpWCNV40kO1S4D3rMHkNWyTqbROtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jWVH3zNQ; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jWVH3zNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9cZo9NIjcf0Je0Nxmiu2XmOU+4jyEf+UFpbcQEUGZl0EzLhSA+XjkWltmgp53Io2dBURu/hIMXKO+cNoXfCRdLtiCIEolz5QD+EXtribHMwJtX3c0lxdIcH/pEghC4Jm9n0B6U5RJOXDwIEyznOfXnMB0H6B4T96DUVqeSdZNdlrDzBlBKZEdX7G95sYxRmxFYNTbxBt7OydAEWawgQnE3xZqpU9sdKC4YBE4HkWp+lCVKgsmsIREvp02vCdUEgXKXQu73zyEJtkw6aSfQCGKihq0XyJDFqhsYuR601298Y2QjUqcvKrkExngvk9/sVDBva2Aizu0WZf5cGAecs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXytBJXnk5+RxHz7LBJrZ7IYGdHJvCUxMe9u+5piBJ4=;
 b=OyjPT3gtXZH/HXA8lR71hNq0jlaaovEQJj6JvqFpnLtLvUWbSr/WldLh/STJF4sh+Dl760wMHiKCgz3q56mkNv95kFz9dXdqBQufP6Y/3Q3OoqKHl2uHqYgx0ePAGVtS4WW2sDLu/5EPvSX9km0ypljZsJfGgmpC2jCly435hKbrYFEQbLcwj6oLUFiYWUkYdqL0ICLqDK7ceyVG1bpTHXJI8w3v/1n/7tluRb+kCNTK8QPjgjRwW8kHj8Bkmtk5PpSs++F8sebMFDgQuhiDJQE2jl2HWM0mjgeXLLZgr3bH5blpUu0x7OJwmI3FhPebSHU4csiCOYB7rLTkC+knGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXytBJXnk5+RxHz7LBJrZ7IYGdHJvCUxMe9u+5piBJ4=;
 b=jWVH3zNQtatOZLjr0dowEPHSxWOni22Jcl3I63Ai33DO1T6/0qqTXhhejcIqUzBMYLZlI2kuKnxVYEdzIfUbj2OSiRaQS6OgVnkQPIIuhoC4TxLpKIuw+TxtIUQABp52ZVacdccb8F90K0HKTk6ylG/TP2V5bxTteRL9vyYdYLstSIzXGge/GqB00EQgNqfX75zrOYlr92WDVyttjnKehv+bAHBRXgBp/GrRKxZfev+/SUQWxVrDppHyZ7EfSoY6FloiM/ikiyPIG8YFm5UqUgvPQEXq+9BWVTuDd5MhPVjJwUZUsy2kObyLoZNVHagJxa7ib3wREy/iACJHCa7R4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:39 +0000
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
Subject: [PATCH 2/9] sched_ext: Split curr|donor references properly
Date: Mon,  6 Jul 2026 08:50:57 +0200
Message-ID: <20260706070410.282826-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2c0ab0-98f2-4cec-f7e2-08dedb2cd88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eRcQIF+o3BDaMUZhPxNajpSOwK2qf3VhHOB7va1VMScm8xCOH+fA2zTND4hhT6UDwucRMbVhnyebRB7cAI60N8OiYSbjY9P4KXqOmgnTxXtfXrHXFenFCj50Nhiu5mEY8mr9Rv36+8BXFvaC6NVSzZHxpH9NqI1Tvk9qRTz6H+6a8k42UmW6yDRsBNU3lkH3FYU+J9G0FzSlF7EPFJei9nbB7Y3wwDdblHnFFRFbYgOSHFqHaJO4IcHWgAwKDk4az3v64oTGxvdEqc7kkxGu0EuhAjM/EdaK0dWWGAeybJKqxkFP1bZDflkW6VWOw/8OTWahoQopP69/k8F2/AQ0L6/dddYjzp5R4c6CfsUm47ESknaiLrvDhAn6ruA1wXnvIMvVgpWrVhZ5tmg6HRcO8q0o76SQX2KkwKx31wUhNQi9Z2T1W+QWGP5EFVOkOu853sX32zYbbMnmRRN3toH/kFOdbHl0ZQ+mHpjncBUqt9Fx07IHhv5feYYYcaX9hZ8gdffnw7YuTRG+NWjOepeVPvhBe8T3Y2Z9ulcCV/SpF/y6qN/kpfuPnT40qlhSHT5CFYyzOMfG282flJV+y2OY7wbll87R0/JvDQ9JOr3YdtWElgAWtSS6ezmKTdMT1UIZs4694UrXihYVm/SWU1B63edryRe/Q8ypZDoIRKsVGkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VE8jxYDAQ70XFwg+GhJ86rCxx68/vhFaYmlTOCDbixazjXiqxqcDz47H4DZ1?=
 =?us-ascii?Q?S8jyfoORpxDsmXoVrq98DBM9/Wy1I1sk/gUHQOZFWo0l2GEsK5IJ0AtUE0Zd?=
 =?us-ascii?Q?tmBWGaR9w5Bhs+dmuVSEl2LqKYMzh1QpgPFyjShkkxolm3ZQtuel3gzvrj+A?=
 =?us-ascii?Q?RScRJ3WrMRo2m4wIIrCyRoOKphN+r71noSmeOAW4HCmtQWGC8OGchXAhS7qC?=
 =?us-ascii?Q?hRRqWWihaB2zXUDasoZ/Ru3fFiL/DFiA6vnjvpjUA6+V4PoFAldLib5Mn6Ni?=
 =?us-ascii?Q?WfcJgRQT7CGR3cOHvnpFQwEeSvoAgQZ/2+Ev6X+3jCNKmdRpYenZV3GwdhNQ?=
 =?us-ascii?Q?nHSQFLqALjNpRqVzmkfjQ1aTZm5qGWT3lelYErPv5oA1bNBtwoAUsQER/dH+?=
 =?us-ascii?Q?8AccATrL1pcHBItcswrCrLrnTURyeJly4oC64Clq96vcqevTAY+onyY0qSQS?=
 =?us-ascii?Q?MMRSo1G02vogsl43anquSntCB4NOxhLTgmnTFIDNJsBqWhyHZoPSYRR4b7Fk?=
 =?us-ascii?Q?5Jpk4Rlk3sSFlUknuVdPIwDp/gml8HmE/cw/twyKrxTMCUyiX63H7EAqbViy?=
 =?us-ascii?Q?L1H3bRNUC7MQHiFqJZ6pWNfiUwrqTtJvMmASQn+fj7hqOBaDGRZvHBEVXpMn?=
 =?us-ascii?Q?MJxeWp4puT48lAwybaIMoBHk5ZUrzus4DLckOoYFfpuauqZ598tjY5te8RKU?=
 =?us-ascii?Q?59DCgy0Fs40pB519n840AFKQzAMOTcHrwWunE6NR9x+hPYeeYOeJIrGnKCpC?=
 =?us-ascii?Q?Pj8slR41YToJesSygu/RqWsd/5VCiPKg7aRrTiPh+so9HbQoDu2XkPe8FJ2Y?=
 =?us-ascii?Q?XIvPwmyuoXNbhd7eIZGUJ+vlW2eqWaS7WEHNXDCSj4OO8lJAAbl4V1vr/6nh?=
 =?us-ascii?Q?qSlkWrwl0T667wE6xsarBiRI/8AETJXoSFdGgu0/Hjwh1BIyTI9ArtyNrMC+?=
 =?us-ascii?Q?+8lCZszHk1iXce9w5USP9eCRwWFhMZKQv+zxj1AhKvFw3acvHFVGI8Y16owM?=
 =?us-ascii?Q?2D9TUqXNinaD9C6GYm4K17TNSUhQC5kLYPz6hOOICFNq773ic5PulbG4IS3L?=
 =?us-ascii?Q?LtNfkx04sIwQKQVhfNXOV68XboeTsgEeL2V/1dcVVnIVOTbwEURnY2KPIXZ9?=
 =?us-ascii?Q?d4wcCH5Zp8gTA8JuPCgPbOYB79Mc39yKP3ffsqpvGSt4LtXf3f5BV7Yh8KKv?=
 =?us-ascii?Q?R9Pa7qGs//GGvGQtCMv1v4ZaiKYhl+oe+Vazu5qdfUrhZLLdpisoZti5XWHj?=
 =?us-ascii?Q?Dr5rHNHZnl/uZXzhbBTvAsnMVNvU98mejTM+BSYoiH94l7Y2IfmH+ucOb1UK?=
 =?us-ascii?Q?5HaqZi3a814eBonRVQ7DZggzflmBl3x0acqqF0MKSM4NE9jm0+3HJ/k2IjJR?=
 =?us-ascii?Q?p2tsGHLF081F4cCz9fgxszdjViY6/XMlYfM8hFHIR0ra3zQr43Sm7o/S2oMQ?=
 =?us-ascii?Q?ejmOyH4/SOLxSnm4+aCQIxp2B2qx7IEcnNsALNDxPcQZP7B0GKhhmPmD771t?=
 =?us-ascii?Q?TX6iUuI0itknsu1K8JEHpLCu2ijd6Qm+qjZ+vVdU3gBQFXzW68HNCaGDKLA7?=
 =?us-ascii?Q?x530s2Um1XqLftG9Aya/hfLsuKAHEZmqj2/7wEhFvGFSfREWSd4UqWUZjKOa?=
 =?us-ascii?Q?enGl83XOSjD4n6PcnUrOehFiZdgKX9UqRmxC2fjahJOdidEpO0stWETVVg4c?=
 =?us-ascii?Q?tYXnuVOqAZ0ICrA1IoejuZTeLoTFhRvppDmm0XbL44Plj58KNpv+KNGynAMa?=
 =?us-ascii?Q?Zffljs70nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2c0ab0-98f2-4cec-f7e2-08dedb2cd88d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:39.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR7oK1Y/DPaHwFdVGiVKSPeaX2FU7sII6L3bqRo7C6e8PQJ5dikK1rO+beVEVW1wswOooUNWU4LxjXJC+tv6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

From: John Stultz <jstultz@google.com>

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

Use rq->donor for sched_ext slice accounting, preemption, task picking,
tick handling, and CPU kicks. Also include donor information in
scx_dump_state() so both contexts are visible when they differ.

CONFIG_SCHED_PROXY_EXEC currently depends on !CONFIG_SCHED_CLASS_EXT, so
this has no effect other than the additional scx_dump_state() output.
It prepares sched_ext for removing that restriction.

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77d..242f6ffbba350 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1145,17 +1145,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 
 static void update_curr_scx(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 	s64 delta_exec;
 
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
@@ -1316,9 +1316,9 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
-		rq->curr->scx.slice = 0;
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
+		rq->donor->scx.slice = 0;
 		resched_curr(rq);
 	}
 }
@@ -2464,7 +2464,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2876,7 +2877,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -4029,7 +4030,7 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->sched_class != &ext_sched_class)
@@ -6007,6 +6008,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(rq->scx.cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(rq->scx.cpus_to_kick));
@@ -7452,7 +7456,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -7464,7 +7468,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				rq->donor->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
-- 
2.55.0

