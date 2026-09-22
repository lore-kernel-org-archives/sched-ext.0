Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E7572689
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096129; cv=fail; b=J5iO9aPhTx9LFJI45rzfRWnCzWKnbl4TLBQWJ0NQku6eYJAFMh31XKX/f8PxqkGZmhmO8Ac4DtJh4cWppGJrQb5OBbPzYMXm4oQSAhRH32aLSE6t6H01OnfR3ssAD16pgW1JPGpNQBSuH8Fs1WVfdn/e7gkgQUjhFgMBMgrJKAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096129; c=relaxed/simple;
	bh=HpOhWyqNDidh7fOmqZ4H7KTUhgLHZ7od7Iv5nvepnWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnV3FaC/IKQRe8j8AFJPfNrAE5zTvgpzIWJmPIVb8Q59exRH1dXVSR+U1Qh7Q+gkhERt0KZjEQm6g/6cDV8RIKNlzQNInWn7Sfk9ym0NvwlamcNjPoa3wEdOjd4ZgdqN1xPLjdE0iXS1f8OIFXlaZtYdoUfWGVemoKt9rVbTrZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f2PDxJ1g; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2PDxJ1g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh72pj74mDYASCoVFzXzxLNNKReE76FUcyChYAJxG6fTnlk7XDY0UKeXDHwYrLsiTPzEZ0JHedB3PEhzSGBf+D1pEw6M9MjnwN4YNPDK1s9TuQAZ+XAYT/NgsJmH7U/4D+mRKYJA4ZNf6Q4UzNOEcLFO3a4F8naZcRYoRnW8zMI68hWSPqpzdTyrYl5NGU5q28rnYZa4i8w6qy9mL/fA+j82R56ZCv/FwxuW5y26JceDr1113vG5+g9BjXLf6nAEJDhy8gge8l72lvsdygnmcFlCnA8w6vaSlG5RXBE/DYBlbkiVG0Q7APaY1nGA2HHVdcYZ/4wy7uzBdEj/5GkC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkCZO1ctFg+epQQceycCicpdXJ80Fw6ZECwoHuXU33A=;
 b=VAQyD0nUAhpQqlqkDMzae8jJDOIWv8warnTGq9oyQDDfT8LcIefZr85d/GXqtVXgbYhd+yl9d7S9A9ZwqZE1waNsbR5hrLHbY7qBl6pXsaEApQswvdJ+Ai8pvyxmceJ/qtwMQH7NGBBaAQgZuh7ZaW0APsedsl+bFAqJM4j5RDT0oN1MhpCZd9/ARFOn31LtMy91SefmEJPSOH4lplFGycwjOivQsOmPtOseFkaT+aYiylPgFbD/41HXrPL7Ro20GlCYHhz+JzWstMuA2q/UWDHd4/rjnFRQZCFu9cGIAzrxv45qcZWxE+6oHlp1yHTdajfeAWDWQ5ibFlJxlVWIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkCZO1ctFg+epQQceycCicpdXJ80Fw6ZECwoHuXU33A=;
 b=f2PDxJ1gip38b7IcHn42AHREqownMXpujVr/inib6jUI6xlj8vnHEGP0ZHrkjalFYkOjyzJKF6R1rQsb13/lPFqS26LS+0BrNfxVwTReSfg1ELBk3WsQpS11wE44w5CslVQPvVFnJ0znMHZNJdNaJIH5ZVKLKDbIPZhq/Nizy3p0PYeRJI3QxsGEqmhOasELMGcyfQ+xcRJn2xPgSYy9gWRs9KNSpwg7M6Xd4Gre8qyhfHfUrbRNj1A2ObW7yNwkkylcPjGZsmbd22ohRAZXCV33Wp99qHARHZpyyEqJB2o/kLCN1bgTDyrAnbS3ykitMucYCfMmTTeYQqGP1n4GOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:55:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 16:55:22 +0000
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
Subject: [PATCH 07/16] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Tue, 22 Sep 2026 18:51:46 +0200
Message-ID: <20260922165445.943315-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>
References: <20260922165445.943315-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e3fd79-7c6a-49e6-f536-08df18ca4a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CYO552d3QHoaMs4mT6IUViJoju5NPOuJ4/G+tIVukxNtu3SiaeXJcEUV0kwKEL9QzlOH4NjZB0DH+5BYdM9TpX8DRCuV3bt3oqVMW0XologLtiC3DkZ1kKoTMYkczpTyaVz13MvoPxzhlo8wTF0jisIc3PPQfejBBi2pGlaJYGcmV+53jbMo6CUdVcFda14WSK1y+XXXicgtQPJCw7a8Wjkow3AXYyJpVbZ53o69G+qoYF/GY+BIm75720F6U//+iE8E/RpjNXo8mglu3sTnE0PH9gUh3Z2Eu+sn5OhZcfohm18eeKfIiz86eaqFjKMTAgtgPfX0Qq8dlsB4383jcMJuJx7dCw2UGwKbPXseP3c8y4p6IGvlzFAEiiePNl8ovnTNjBKkB1TaPRRleQu6TnimkpuJH5We/Vfkx7nOJiBo1vya1U77GtlHQ0Z9irupAn+5XKRbUODDEtPPOMJZMvsK/V4WY5GHzzzQoSPrCvycVB37uhRAkZnx527kCUn0tZ34q6Ht0hZ1SqNDzWjGtrtsOydhoVbDX4vww8wMraeJZ5SH1AyuPb/jRq/wFG+0WTLXYAejuSA6dz7CGR+PHtTMnVa2dBLfFXo8o25HvVEymFQ94mNoTE8QfqFwFx4uTn1TIojS2eJTvlxh7CxgUSWoFOxrvnWU/rJw5aSeaZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DydWVHDmmC+AFilZR9GGKkJzraR3oIyrZvDMXlBr04QNkg9H4JmzKx9uX+E?=
 =?us-ascii?Q?/OUOgMUGH4G6QXG/yf1MGtSGEvWiiEioWUM6xTZXENK54byviU6Ta24w1BiS?=
 =?us-ascii?Q?FloEyTO/e7n01dvhfLi4wBp/tjj/U4I0ZeGxmD8e/IyeNaIZinT7Xlb8xSYv?=
 =?us-ascii?Q?c3cad/1TASrppvsWWc9BTMmoMcmc3q5TupDpkfsLkyk158rrvFFQylLgSPgI?=
 =?us-ascii?Q?ZzQmuTAH5a8gvspTEBkQgL9BX1XquuszYO8tO2k606I/qh0rsbKocfYswp6v?=
 =?us-ascii?Q?LaJDat1xhBMzmoi5OvWSqyN/ePUFwmEXwc+Hfh13RnAjL48sHcv7N/HKY3Og?=
 =?us-ascii?Q?FMKxZbk5PxZfpRJAaHLptFCcK07togK3LCRMkwoG+ZG7kV4TimyEoZCm7Zf9?=
 =?us-ascii?Q?o1xGzfgPQ41KvMjKOo5/UT/aFDmPi4N5zY4vbgkEOrs39CrjY60khbBVplvG?=
 =?us-ascii?Q?Pz+guTqLEMONTZkOLCz5Cd6LQLnC2/+WCfqyctZUdtOrE69kHX+b94WjQgIN?=
 =?us-ascii?Q?ZLMB2iHkVFMWCEnfJICjIyJDMWDXgpPHcWcIVCxp4jT8ks6wxyWCeq7l0scq?=
 =?us-ascii?Q?om2uoK5ex7PmHTM9iREdZJLIZwUYA/l1ALbgyoACALJ0GcPezOo+4NgTzv0N?=
 =?us-ascii?Q?FxmucaVPw4MOTWKNvWu9jX23MHhFdLZpvxtMZGavooPKq+Dz10AM97b5asMK?=
 =?us-ascii?Q?mAGW/F3QxG3+rxa/WVQEMuiugInS+6lDXT6hpEjbh0y02qz2NWQ3XOUiMh1x?=
 =?us-ascii?Q?8/mLgOYz11mlIsxmlYNM3FIhtX8qw6nNGd+7EnxXFmltZDpwJDMadJQlMLaz?=
 =?us-ascii?Q?TW6qOYlgr2hTTlIhZM/24MsTWkXNIYfSMLdf0n+ZjrjjJk8hMW5G3XLueyXq?=
 =?us-ascii?Q?b7h8ibCW2aLVhMxe8gdgjA7EDJHwQdHrJ6/aPBlAXz9W5KWjXjpSUqsKISQH?=
 =?us-ascii?Q?oxFDu9RUUy9pghq012vgObKfEJpc+uCowGSKs95uQMzY6RAF24+abbdqNceI?=
 =?us-ascii?Q?WzsU+Sf/mBIX5VIWp/lnSAZEew4Q9GxS69X9rHr4IPYntYMsHWwUbMkhwhhg?=
 =?us-ascii?Q?GHx4uXFVxcKH1lAbIbQ8vi0IZCDnQeNDua80QOYMp2FwEiFz8zhIMeLbHS2Q?=
 =?us-ascii?Q?cEJoEEPlKPCphYkJEmAWhyaHVDx2ZmJgEDsjA6zFQUH0sNWEFNTvd+YyPxyW?=
 =?us-ascii?Q?CheNZgEHVip5jXHr2fpIRZ5GhuhFIEvuDLRswiaiYxWkQ4iN2ne3wmWMOoCs?=
 =?us-ascii?Q?6Ex+PKshIuST9k+nqgMZSHbZv9chXoDF1b6P1gCxpB06qQfbsh613QhlRY8f?=
 =?us-ascii?Q?sE7sPjtnZ6uL17vvcNH00CmlJF/nDFWGympye7K16C3Tfa10+77t2EvAsjP0?=
 =?us-ascii?Q?XCsuPyESw3CmDW1cOMjmM4ZhHUusexNeUOc9WT7e2BDv21rKBPPAqPJjJR5q?=
 =?us-ascii?Q?BgFOH7qSje4swMEqf2i0Fx+aT1asecQNuNz67B5/YupAWlm9jCNjJcookcZt?=
 =?us-ascii?Q?UEPGct8PO7TQy55Ibk7PDh4przlD95a9uUp1iaelo/EtSs2+3n1Z6pqf3Sje?=
 =?us-ascii?Q?Bpf5QoXaRHa4ngXuCkhG7UmtaV/CI4/7/sMBvAn2oy3Yj7o3j08qvncaE7fV?=
 =?us-ascii?Q?w/gApVqB43oLKSCEoRfUcbQSKk7PiUc8JBQcA5tz2n7YGgNWmDHpS8zSSNrt?=
 =?us-ascii?Q?KVRLdVu2R8i1Z+YwIURzbfrpkjHmXDxjJwv3Tf7ZnZCesSsVvh9GR6pJbzAl?=
 =?us-ascii?Q?CpLHrCKGNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3fd79-7c6a-49e6-f536-08df18ca4a47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:55:21.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWjdQho+eU12/L31dyavYsRw4vZoHrhY4M3myLCHRD2uXHksK9zR2XRTcOpIutcKLrqGL/Xs5BCB4Sioqjssfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

With proxy execution, pick_next_task() can select a blocked task as the
scheduling context before find_proxy_task() resolves the execution
context.

From the BPF scheduler perspective, that donor is running while its
scheduling context drives the lock owner; ops.tick() and other
accounting must therefore remain enclosed by a matching
ops.running()/ops.stopping() session.

In this scenario, the session boundaries do not always match physical
task switches. Keep the "running" session open when the same donor
continues on the same CPU. When proxy execution migrates a donor's
scheduling context to another CPU, end its running session on the source
CPU and start a new session on the destination CPU only after proxy
resolution succeeds. This prevents a failed resolution from exposing a
provisional ops.running() event.

Track these sessions with a new SCX_TASK_RUN_TRACKED flag. The explicit
running-state tracking is also required by later donor-based accounting:
it prevents an EXT owner executing for a non-EXT donor from being
treated as the active EXT scheduling context when it is dequeued.

This is a preparatory change for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |  1 +
 kernel/sched/ext/ext.c                        | 70 ++++++++++++++-----
 kernel/sched/ext/internal.h                   |  6 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1e1fc3312bc40..b71dfdfb09f62 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -104,6 +104,7 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
+	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 288d479c71694..3b6caaf70fc77 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2360,10 +2360,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
-	 * A currently running task which is going off @rq first gets dequeued
-	 * and then stops running. As we want running <-> stopping transitions
-	 * to be contained within runnable <-> quiescent transitions, trigger
-	 * ->stopping() early here instead of in put_prev_task_scx().
+	 * A current scheduling context which is going off @rq first gets
+	 * dequeued and then stops running. As we want running <-> stopping
+	 * transitions to be contained within runnable <-> quiescent transitions,
+	 * trigger ->stopping() early here instead of in put_prev_task_scx().
 	 *
 	 * @p may go through multiple stopping <-> running transitions between
 	 * here and put_prev_task_scx() if task attribute changes occur while
@@ -2371,11 +2371,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (task_current(rq, p) &&
-	    (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq)))) {
-		update_curr_scx(rq);
-		if (SCX_HAS_OP(sch, stopping))
-			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping) || unlikely(p == scx_rescuee(rq))) {
+			update_curr_scx(rq);
+			if (SCX_HAS_OP(sch, stopping))
+				SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -3082,10 +3084,21 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void scx_start_task_running(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	if (p->scx.flags & SCX_TASK_RUN_TRACKED)
+		return;
+
+	if (SCX_HAS_OP(sch, running))
+		SCX_CALL_OP_TASK(sch, running, rq, p);
+
+	p->scx.flags |= SCX_TASK_RUN_TRACKED;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
@@ -3097,9 +3110,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED.
+	 *
+	 * During a normal switch (@first), a blocked task is only a provisional
+	 * donor. Proxy resolution may fail or migrate the donor to another CPU,
+	 * so defer ops.running() until scx_proxy_donor_start() confirms that
+	 * resolution succeeded.
+	 *
+	 * !@first denotes restoration after a SAVE/RESTORE cycle. The matching
+	 * dequeue already issued ops.stopping(), so restart the session here
+	 * regardless of the donor state.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !(p->is_blocked && first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3145,6 +3169,12 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class && (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3220,9 +3250,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			scx_task_slice_ended(rq, p);
 	}
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	/*
+	 * Preserve the running session when proxy execution refreshes the same
+	 * donor around an execution-context switch on this rq.
+	 */
+	if (next != p && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 4f170cfb79863..9e1eb1028eaf6 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -468,6 +468,12 @@ struct sched_ext_ops {
 	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
 	 * target CPU the task is going to use.
 	 *
+	 * Under proxy execution, the BPF scheduler continues to observe the
+	 * donor as the current scheduling context. A blocked donor enters a
+	 * ->running()/->stopping() session while its scheduling context drives
+	 * the lock owner. The lock owner executing on its behalf is intentionally
+	 * not reported through these callbacks.
+	 *
 	 * See ->runnable() for explanation on the task state notifiers.
 	 */
 	void (*running)(struct task_struct *p);
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 92501498f6a36..a6c1e36f83964 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -106,6 +106,7 @@
 #define HAVE_SCX_TASK_SUB_INIT
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
+#define HAVE_SCX_TASK_RUN_TRACKED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
-- 
2.55.0

