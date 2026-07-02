Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5613346E6D
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012803; cv=fail; b=CO0cGsWDP4K9o5/ISFL/1idAA50QbvxQFqM0odKn02MHpmEw9qml4CYlwnly2DT+2UcZlQ7q3eRJpqp3o8euI+pZ4FhJ+OgmQdnfsODO8Fnq4mI6ejQ1aaNQlsm8a2/RXx5m2mLzIO4uubUZ0CbDa5MJ6xrFzWbnH9znusAcoBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012803; c=relaxed/simple;
	bh=Iw1e3m3uncmK7aOjZs479NJK72O9s9faWwjGOO6IVSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AeZtq/t7qUilahFJovoGqFYYJnJKxb0VEPalqHRFLpSfsCTraX2hR9s7QAMRhguXr9Y+ZMwv2x0LVb5nJpaRXsx4hGQdV4bz8S/4vsQ1btwdXVRoSrzo957nQNoqAx718Fn0pH1jtHCfQqRFGzX5owThBnGV1Xbia0Y7T5eFk4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJFvbYo7; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJFvbYo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svTNxem9Ft4NI23SXAoeepyxWMPl4oKSJTBrI3rRlGCvrpQLRSKeaVDMOLtrfpV/LiFdxKuTuzdWjKI2zWWGtBdUaaJoa3nbv86qyEHWIZVdo84ayEgr/vRztxVQecKD41gKyA27QiC6AEiaqf7hHYWOclASdaHkiha46AnbUOgQuwFv659x6nfFLpNIQ7gyK96mHsPJG+FvoKaBkl3cMRxzGWiKxDbMVq6g7XMYt5Ze+NN/+itGMX5HeO2Il3i9uIXQK/YiUyDMNdbRVgJkhj3A8E1H6jEvJWgR7s2Ax6vJdZpMOkQXLgsAcElP5AVTqO5ltuiuR9+cw17HjaU2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmnvnO0vUtHnACuftTPK5GL0XsRcCDwcNi30UQFluuQ=;
 b=QGFKEC9YqGgAPKme1GE5dRGwteFNHGoVbjDd17l/V8ISrjjSS/HY/B5e1mCSTiszbOHMHw7z9qCFdrjeEnWQVbURXf84tXWM06q0zRHvS540Pr/LNIc90q6wDjT6F61O7F2bSiG5fM8BRSUQNVSyHLG7rOVjNBCy+XeQVnwdr9la2iqJFOtEm7ezxg9FKQOxaIfjTVWIL/eWlmqn/PPRC/q0SRYm1zxcnsgZUOS1ZkEugQT6+XWVlLIB1zywxiljCHpK5ZoQDGSXSNUnYJqz7Iz8N4Mazdxnxqrdt9A3wK/JJIe/R6e/GYMGYjHUrB9TJhi1uk1DPKSyqFpejBrJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmnvnO0vUtHnACuftTPK5GL0XsRcCDwcNi30UQFluuQ=;
 b=fJFvbYo77SBwQTNUDbyLV2PBJ1bqm2vokT5KV6gDDQg7V92ZBHakgzryiW85DY8HLkRNzbUnJC6GRHPgZXUUkoBYc2Korqq4QYSRE1svrMbV5oKdWGJVIT6Lpp9A5HUEGg/44H+HG3QpIItBWGDRH2AVSLjH3Mwe4zCh6wYOV8U6q1XYZvAXlRhrT2kAgwRww/56jGugIu1E3tAS0JyyBtPeA0c6GTkZyzOi9pbq8DHQAXhD32XPUrvag5+SUNi7HsyFVjNZyO2cgCJGQiqM4ExIrGRq5QspItwSmjEFiG8I/7Sc5z7enAxA04U3i8zhNO3K5K2/AGSRzq579QXU8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:19:55 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:19:55 +0000
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
Subject: [PATCH 03/12] sched_ext: Split curr|donor references properly
Date: Thu,  2 Jul 2026 19:09:19 +0200
Message-ID: <20260702171909.1994478-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 427062e1-f5c3-4d0d-4ac7-08ded85e2284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	smqy5URIc9hFDqytsOnUUsxFw+FS3YEOeVhZ7/Sy/Vrr1r95IUoD0JGHRZjBciPwzQ0xZdqJJlz4PPiQ6oUyD9/bobWbozjESa85EY1EL7UOjTg0OFCo4qbbOObLbJgPEfvH2YPDWqLdxMm9aFea+3IrTXbNNUXdDkhxINyZ2C/nvPkNrPnB4R77wP35RhfbdfCk/L73LVjgxz3b91t3lvXKx4hRZ0FHVZ5mA+Bt4UPSZA0PCn79ycOmEQQnG1kHO7NlPoibC6IBHftXN+k5TittGH99Bj6Cr7NaQUzSQjMR6HQxJMwEVwPDeHT4XMTTDMDUG8MD8W6qwiu8j//Cuz94smE8NYLN8VIgbFnCaJfaeVQa+qOKBLevDJSQFuHaAue7MnikE7NZTymnjyNkDAWI090FeWlXwlY7SP3nAN2k9kkHew3sdJi6W0Wft78/JrUrv5hHX04kPoMTlyGYbl/GzZOHbkMPLmOaGUtMsMl7HQOohzjP2gTZbl+5ClXQ5OWfe/jlSJpwemdIPPqfAtpGnUuy0oTkGp5twnFTeJBoHTvVy4nmjX/nQlNgV1h1exDhuQAk284cQjfWTlhLUYlvitt/2mzbfM9f/6XNuX2sAunxa7WsA9s5dx5xSmtE1Lm3XDSbuLnKr6VieTupmsG/jjiLQtuF9yIG2DDBme0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DWcdsLrzYVDIv8DumEfIU3lpYPfCb22UXhYVK6JckPXxuQfT1zkEP1L2PAzZ?=
 =?us-ascii?Q?wSq7LoLKNNyH14OEo7UEEf7z9Yaj1Tz7beAQz5EZHj9m6Z0M42CEmyQtv2Jq?=
 =?us-ascii?Q?6HWjyDRRMGV3feZ2otEeT2vJv514MJjQ5y6+BHDS4u2HG2ZVIHXXGsh6c9t5?=
 =?us-ascii?Q?1T88HmoJ8t8sdVwmPamo7NnFamNIJjt5l0ISzFZ1jk5pmHPn5157ZAfLI6/F?=
 =?us-ascii?Q?UKnLUteGsiuYYM6gBSGjQY6252KGxc/4uB/f/KeQbTWDR90Cjs6FyLhUKAjC?=
 =?us-ascii?Q?IXAZmn3zCfsIHlpikw1uaMZ+mTPGCL0V0RGlcFB9kqDsrG/WYKw9RxOOaPgh?=
 =?us-ascii?Q?a1Lgx+cydBB48OmAgybeX7ctBl4rRMnKLKPsgDCA7eTVUxjJT4tuxNjEpcpp?=
 =?us-ascii?Q?B7t2t6arj6zwHYxZcaTyIaOoBQ/GK86dk6QgcgQ3yyDq8uOdiG0unNBV2k22?=
 =?us-ascii?Q?nl51zJ/OBjtR9rNseBqQB1Bv+qYEit/f9OBpQkU8SxoWzPhZ4GicKstHIEhY?=
 =?us-ascii?Q?TOREqgHYduwf8b989kwwSWrihuof3MHWeUWdYAvTML+9g7VxK7xwD/FYsSz9?=
 =?us-ascii?Q?99FJb1+UdkboNr7EdfaecWYE8AguDJwf1PvvMUaGnHdhzA0cYtqFVda0fNPG?=
 =?us-ascii?Q?2GBYp/fyfaa3amL5VzBNdUyszk1/O2ZwqYto6XnF2IODUly9sM4SQLKk8TRQ?=
 =?us-ascii?Q?5sKeLg9aQkhKCL8cLGzI6hL4OtbeVMaUxJEuE3gHqNCVDx5C+fhcDugjgNy/?=
 =?us-ascii?Q?4Yy8VKAII0dvQcWcXlN71uWU5o7crIOZqwR7abT7N0H/JXy/Uml7T67OGxui?=
 =?us-ascii?Q?XieaJ8PJeMlI+/sDzIoOTA58w7ajhowdOWp1hdC5q8Nxegp5pzWZnXg5tTXl?=
 =?us-ascii?Q?V3xppZVfSuN+SvQ7WCyn2BnQ1VJGp9yvhaydtg8J7pRN0nafT1b5BG5mipqf?=
 =?us-ascii?Q?nwsDuYRMDFyGVXSUM1VtlWNYkH/xRrlc53KCAJuKxfJGe6nefjdJIJ0RbBo7?=
 =?us-ascii?Q?PIgxeqswPS/g62xRy8b+0dAB+8r0ylu6XnRtvRaLXYRchmg99t4yAQtzqN8b?=
 =?us-ascii?Q?kN3uHCeG06s60k3iEX5w4RzjcIqoNWV0Q/kxqlMgyKNVsdsuo8JyMIiNluIm?=
 =?us-ascii?Q?Hsyc086aWAT2jMtlifV0YzDrRXnPftIt/qzwrIK9qU0v6U1Fy7fLLNzBfj9x?=
 =?us-ascii?Q?QwGaF5YIx5nPqsUXdPd5c/8WTXJZqzuossgxM3KCDzCboZflBCfQ2CeDO1i7?=
 =?us-ascii?Q?Jjczu+6jc5dcKRUHBNEgOGqhRiFMGLgjCMVPP/WozKU0vSpqsEEIJnxeQcdZ?=
 =?us-ascii?Q?w4nXz5rXweccZwbS+SsUCMJt2IFyQvzAwN7wESNih3QgqtUJU11bWnp0QmL3?=
 =?us-ascii?Q?Vtn1E6nZGcDOEi+JKZOMWgKLukkcXlt2ylSJ5EFbJnRdhS0Eru7ogo4gR2uB?=
 =?us-ascii?Q?o+vCHA8wq24jnq79xbx8lBV9bcDx8ktYvoCVj5MkSvx2p5LTfpag4rweR0qL?=
 =?us-ascii?Q?o9iR1P6uFNhivhlrjod0LJiNf7rT+f/IdtWAdR03Ghvu5RRqKeEhf23NZBLV?=
 =?us-ascii?Q?AQ8bb2YGG7iwJ0IRk1gDYzO3kip4xwFYDlYu1TJ4ZlslGapMpI9vcIhdLfS7?=
 =?us-ascii?Q?4ZHUV9aVc0ZXECLhXArLExcJ3PM+HHbGynJYA+R7Czz1yl5ozwkmG2gEvKMH?=
 =?us-ascii?Q?wKPP5ZyZzOaCNI2EPYmesMDl23THcLFxbZxLEzTuhd03Q2yzWNvWekNPzG6l?=
 =?us-ascii?Q?RjMenAO8JQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427062e1-f5c3-4d0d-4ac7-08ded85e2284
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:19:55.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZnRCfUeSmAdI/Z1mh8UdQacbPm0AzQGB1U2YGt48ZbGBK68xI9SHES7bThZblT26ahMvWTF52qx1xrJ4Mz0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

From: John Stultz <jstultz@google.com>

With proxy-exec, we want to do the accounting against the donor most of
the time. Without proxy-exec, there should be no difference as the
rq->donor and rq->curr are the same.

So rework the logic to reference the rq->donor where appropriate.

Also add donor info to scx_dump_state().

Since CONFIG_SCHED_PROXY_EXEC currently depends on
!CONFIG_SCHED_CLASS_EXT, this should have no effect (other than the
extra donor output in scx_dump_state), but this is one step needed to
eventually remove that constraint for proxy-exec.

Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/ext/ext.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77d..1588565050679 100644
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
@@ -1316,8 +1316,8 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-	    rq->curr->sched_class == &ext_sched_class) {
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
+	    rq->donor->sched_class == &ext_sched_class) {
 		rq->curr->scx.slice = 0;
 		resched_curr(rq);
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

