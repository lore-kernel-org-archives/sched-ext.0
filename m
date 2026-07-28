Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE032E151
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253533; cv=fail; b=fqDhiS0ayqWBxcZsbNwtI8yVM21AoBhV52vC1BsYntl9WAM1CtijRr/0LLlUMe7XDwxm7gB2grjS8/JGEkBHfyGKzXlerzKfHgBQGNm/fOw1EGrVQpM7OhHiThc6KS4Jd7gWJ+/wRsKnL41m7w9xggYDF0I+KPrQuyLAJ6rLpGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253533; c=relaxed/simple;
	bh=6mDBYj5QCw/+MTiMIM35BW/4pg9WX1LXsoQIDaiOYZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZgtPF8i9jfvgDSPIVRgX8LDAU9WwpX0V5Li/9qp87KlVmjYOMlaa+efZyYpoAx6uvClCh+wV84+tAt+7dOp5vUGXBaZ4pFmOSnA3AGTR9y5LuMNTvSvT5EDXLbwis3ydjznBMYGtX+8WqW70TInBGYdtjvtby/D9u7zvBwsmeLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLKccMYq; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLKccMYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0g12sy7pME9EJORIOxp5vTKW8d9Y5EB6RRpS6bfcQne54UBKGknPNy2AOpzVQi4Ep75S2OWx9UgErDiF3yvH/+biTLf/bfRFr2hvcjSq2PC+PXNebNkatJomg0J4jClgB5OQwpGmwuLt9aRkH9lhVAnmqajcdUuJfZlZKRJ6RUTtRWa0Ewe/7hDfrA6QyhyQyLMMfrCzann3AXyna9y5PDPEC8MY3xLiOY6oM1W5SkzUx4ARxsp5WRSEgBYW6pvPzMrFR2ZBylIfIUDk2W7Rh/k9DNLapx6DQWA2E1BuTw8lWgDTdWNyR+I6NoDxB/nXJ+5bRP6m5qaSMJNRWbZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc8Mg914fxW+Ut3DaCIYGFBh2qMQcGWj9KBZhEgpI8s=;
 b=DbA908264wfxTTroHdiZXgs0p1s4BrOQ3nT9cn2H1YlNb9COuUCLS0l2Hao3kboMLLfE+rW0ftvecDynR8hqFu0nXgU91y1UwiUZG0Y+LeC+u/7vrftMKNApoC7iIm7c0kGRpg0UyEW7dWipG3wYcn/D3UKzNQZdjEzrzgqWWAU0AxKBNDajNU+3n5rix6jHG4ceHk0JES+MA9u3W3/A6y1zBg2G9g2W9gXspOiMsI4j53qOIjLAfmW5JVDTWdqv9hlE9EZy5CFTN68El8xB0xSXHmJR0PhEnWBqd+SKibDsEQSGL3YcT/cF5/v2eJgnf1o1B3iaNC3bFI8ExN6hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc8Mg914fxW+Ut3DaCIYGFBh2qMQcGWj9KBZhEgpI8s=;
 b=SLKccMYqHrzHZakahqramqC8amGBdFu840p4BbF7b9TN2QkOMtpQIhi0x8H9MkKLhOBfK56lWATDhYhZUOCVLpzLRAdyP7eIB731clpPFxfmBoOoya9Kl7eeVjCSm0AMtLOn5W9B1RVW/mpV4kVZtOMlS1ivKeh81BzParL4KbMIddarP80NFTwNQyXzNcFCsVb0g3YUs2cNqPDYL1KoZCOpBJchKoLkvX09JqzVwdEc5jzKtxKQWBJ4zpe+6fevpRNpjT9JpBu2kA7jNAPI/sOPj4XRQDNMsNHelTvU+CkLxcewUu7yv3aUHR7LE3/MxMcdrQXGc8DMqjEORLEDxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:23 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:23 +0000
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
Subject: [PATCH 08/15] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Tue, 28 Jul 2026 17:43:26 +0200
Message-ID: <20260728154425.1549660-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb25e3b-b920-4e4b-b7c4-08deecbf3caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9niC+o7UoUW93ZsAz4Vzl7WA7FC1t83gT1IU5WQQQ38f0F4hDAlNfpj/DVWZCizSin3a8Wa1oI02c+9RQ7IXKQQeOljETxi4f957xU+ErfCuNEy1vfhEdnUV84bODISFw4vXKxzqdfo0t7wzS422baxI9/Jyd/0cLlS2cV4dwMVULozJV/SUibf83vtVxr7ZXi2sI5wGXzQ2193+p5HXqPELdirVZ8ffDO9eXhL39cgZM0kUCgFOC5ifzC+pfRJ4WguviauxGM6EnKFCRCOBMvbu0bgaD+IZsB99ZwOzPQKSLsiYIrdynIcJc/ffpu1T5TVnVj6RP1LlG0hikj4Ai5PHSc6UfleEX26QrwZ2zMwp3bQwb3JFFydMGtQtdQV1pYTFeR5x1j9EAHmoVqwBbXeRKGNipzTscPxeZQZZsV3e5iQThqAp4cYSL2DWlxx7uPxH4N8OcNXH8/QMeGDdhD0eNlEhjsRC3V/BLwUEDbduKrxddcbUpDI0oWjyO2O9p0H5Vgh7Pr50qoWRDi7Z+wL4RPm0RwTS9zloh+PfoNl7G4VFHdcJDYQX8el03TyN58Pyd0j+My33CSmmpklHpCG77pJhnhFq69BQe5Iqwbep6xVOSR7I4zA0g0cxrFFZnX/TnsZLrvuErubNMZJT38TPolw/LjUc4bSBV1RCF1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSQpKG5yC7P/AhVXE5p1Os8nENIk86P+x3poC25ekQfRg8XPN6Fxmvo8HF10?=
 =?us-ascii?Q?o1/GZmDOoAz/eHT8nH5BacQtjxZ6gQLMfP4/3PVaYU98iJcmJPyzI73Sovxu?=
 =?us-ascii?Q?Qgd6hMmI6tSXagVvMMrusP/vCVVoFd4jigoVIsAkyS+gNCfNMvwM9KY6kwsF?=
 =?us-ascii?Q?w85NDRbP+U7muXLp1IU3KeSHCtO/jHUo4GNkzrXElYy6cMk0ta0TOmKTAkkJ?=
 =?us-ascii?Q?450kpmRvnDsZ3KTiaXfkwFC1BJc/HWah7EWkcy3jrsXOF1xlt2HqprPenw2Z?=
 =?us-ascii?Q?x8fjxFFssPWYJQtUiQZRk6LFbo3NjgkKNIy/feaW2fLv5dC+RXuIfNpB0ndh?=
 =?us-ascii?Q?nOqPxvRus60Pw0pzHR48xOXoNz4MGWeQpvfP2btsB6XOtMAViu5cNUxGzwQE?=
 =?us-ascii?Q?YiWHGfmXrYF0J1P3j4Szs+H90y/dJPPlWTVIau/dv7qKRAmzXClHfq8Afj5g?=
 =?us-ascii?Q?YfexNiJTBzSpNi5eFDHqcI9FRZh54Lnyt00NYeJlIgaAxyuWLH2/TQOv1oHx?=
 =?us-ascii?Q?4PRyeyFx73XqNFCA8KJt/Q36WR3ctj1fizyV9nJK0OGud5BpPtU0TTMZfjof?=
 =?us-ascii?Q?ptEEdB91GvK4z9ODDR31txtN+4D8LmUSR0Am+5Whf7PIB2PS1hsINWdoCb2x?=
 =?us-ascii?Q?CeBw5lUVMcYh7HDLRxvTKWd2or66cXRX7N4WTqukXeDbAX5YKpmLSOmM3jFX?=
 =?us-ascii?Q?en+cy/tALb45Xu0qpGwPVM5o0HaG6K/+wtFgecA+MZxfqnOnHvZguGJ5O03q?=
 =?us-ascii?Q?tPU+X97u8Z13dwITpIjeKU1heIfX0Hyp7dPEVOEj38qQ+V2jUIgrEjzxaWRF?=
 =?us-ascii?Q?Bz0nIdfOBYuiTZkkvzlw4V7+WnhNvpf/yGY9GkUIGqVaw5+OIeGjrGoT35g4?=
 =?us-ascii?Q?TP17oyCJaDgz35BIzm1Ooy+qECLfZY/U87p1kjrv6RqWsWtatn0stPjEFObs?=
 =?us-ascii?Q?8WpQ+rKM68DgxJ+Ulvg13pZRCs+TN+3yQ+DccPyCmnVvCgZ4DTxIBeefcZPO?=
 =?us-ascii?Q?9B/E4AE4GGjtwBRZ9bmlr4MCVcpkkaD/vYDIVyyBtgLpVG0es0bl38SZ7OeC?=
 =?us-ascii?Q?CaS9vv5M7Aqe3moQ0V2lHh7ywhlvVswvtE33qw+F7NNwPJ+7fXK5nAz4FhfE?=
 =?us-ascii?Q?FAWVcoRvOdrv5rYBv1RSy1XYa4lqBvk60oXK+ixXrHLi+az1ul6Eb7Wg0b+L?=
 =?us-ascii?Q?08Zgxw7vcpwqPlBx1PKe0irMKD/QYxU/i5oQjo4JflHRnanJf/T8UgNReMXC?=
 =?us-ascii?Q?TgiDQsXBIhjO5jQ5HCzez4LfLSlCzNH6VlZGPN4GLIjzbHbS6hY6g6YhRlyp?=
 =?us-ascii?Q?K+sEKXoCR5HMXVaVWdnwz/X4K1KITeKfnCo78So6N4zgK+FZhOl1Ze3gmEVT?=
 =?us-ascii?Q?d/vPRt7+TrSrm24nEgDeKwC5o1g8Xyvihf9wagRMx65jz73MTd7R2mTUioBO?=
 =?us-ascii?Q?qB5BjwSABqUeeeu2jJpWE6liV3wMN5Yj+EeNhNQNuKu6cqiukNkg8nSVHtsq?=
 =?us-ascii?Q?vFzFjCir6Ld9KXpuxlVf4+d8V/Ay5gdjYfDpSM1tJ15fBNsT9tLJt31vX/Ck?=
 =?us-ascii?Q?EbZm5Y1EDt8xN9WXtBkDcDebc+5mQKQ+ymkeguYpyDPdgB6SEf+r0ReUbTpa?=
 =?us-ascii?Q?IUgSBLbZEMLrv95REKHyNLilNDfGCpit35qzT7+ycN5W7WKom13GVwP/QVR4?=
 =?us-ascii?Q?V/L3u5RN9uudialzUhB4gai0vAW2HpEW9060/VYhkLFEtfN1TVdWWn4XyjHe?=
 =?us-ascii?Q?rxumJuchQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb25e3b-b920-4e4b-b7c4-08deecbf3caf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:23.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p410mp0CnWnDnz+blC3dMP9mIzJ8APdOOKI1QR/BDpsiWg44A69+v/i6NgnQvm9Q9VPYcYACTof6EmoLt4i80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

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

Track these sessions with a new SCX_TASK_RUN_TRACKED flag.

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext/ext.c      | 62 ++++++++++++++++++++++++++++---------
 kernel/sched/ext/internal.h |  6 ++++
 3 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bd9c4059e8fc3..4785a02905ecc 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,7 @@ enum scx_ent_flags {
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
+	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
 
 	/*
 	 * Bits 8 to 10 are used to carry task state:
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4ee27eaea8604..240d84a0aaa37 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2212,10 +2212,10 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
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
@@ -2223,9 +2223,12 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current_donor(rq, p) && (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2913,10 +2916,21 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	return true;
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
@@ -2928,9 +2942,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
+	 * scheduling transition, defer starting a blocked donor's session until
+	 * proxy resolution succeeds. A restore follows an already resolved
+	 * scheduling context and can start the session immediately.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
+		scx_start_task_running(rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -2976,6 +2995,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 void scx_proxy_donor_start(struct rq *rq)
 {
+	struct task_struct *donor = rq->donor;
+
+	lockdep_assert_rq_held(rq);
+
+	if (donor->sched_class == &ext_sched_class &&
+	    (donor->scx.flags & SCX_TASK_QUEUED))
+		scx_start_task_running(rq, donor);
 }
 
 static enum scx_cpu_preempt_reason
@@ -3039,9 +3065,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	update_curr_scx(rq);
 
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
index 7501ec28958bd..c3b1f9a5cf3a9 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -448,6 +448,12 @@ struct sched_ext_ops {
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
-- 
2.55.0

