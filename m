Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CB42378F
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208202; cv=fail; b=V2BxR12E0UgozrTsp2+6No9zGXhQiBRMkyoLd1++zXU9om1m2kfaOYSdcU6X9uegLygH05l3+jcq11ubLvqwxip/KZ9TZDE85xiNgWyZYPfvWeclsbWSl5h3Vv0WhVq2OvUIwA5bRrAn8Xqy3E8rTgDprB1wSnuJ654pqVFmn2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208202; c=relaxed/simple;
	bh=+9xvWVBsXggQ/7inJADe0VQYIuXlP9Q6JxVuabaIhuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmVQK0potCs+TMI+omREko0Rq4mJUGvVs3PtREkrS8z2PfFL+oHYmK5oAxBgqoJT1CjOhRcgr4/eOIxW2DbJW63zDAddEMp/k2+2Yyy532ZoHgfjApJhus8y/giPOMSIIaPVqxX3qC1zN3GFI/AMTWxU6V1S9Iq7wb5gJv6V7UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2Yf6EHD; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2Yf6EHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq0HPaBaWG98ANpRtBS+Grv4Yy82KAnX8iysbUdcm6AKMzRTCkJgmNexaUa+aNzTqFxBz67u2Xv2tUDylbuhPYS0Gd9tdVfUGDy6fnZKS6pvqcIXQccFLczD0nO8dTJo8q3mM4Bmp1tuSf/QaHEcbh26DjfJYDQ5uH9G5i3HTYa5NWuKJosdnMvFzzJYBYGnxuKAJ2FkLY9cjCHYi0vEiOrxRiZaJDuOt3H8yuk0ucsygZYJfs39x7OY/YF5lTlzgQIBXVHA8u09yIWC5wx+tWII3PG15SWRHFoo1WRRn+3HthUmY7wa0e7YoyfZX2dNGhZd+k7lY1JDtxDyUg2NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGqOKL13fe2qegr8np+NK6hOjTQHa7k8B6Hx6yudE/8=;
 b=CuASkYCbig8gfPkEltELgiZAZGF6Bt3+Yr2Odx1V8KbYUQciAG/5VbuuT+tCj9nEQrF//LtelZCftu1cWjjLKlzmoANpOrr1SBJcTvAdkcuVQZoR8b5VUHEcjF9l2UpqMJIBmfSUjTUfZJs8YFk4JRdnMT5lSrM+q3XR3mx0hthLDMCsUG0/GR/URc15n/NM+yFrlHG3rII7eQzTiFflsix5VwhPUcrr+c/WZBJp2vQUf1p2a72vcV2LWON9EXcvq1Fi/wmRpRRwjjBUocVDfOPeBbRl7O1ECIZIHVrBZkrB3mpH5LJsjRnT82AKB1g9H3ysxopKePP6JrwUHysOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGqOKL13fe2qegr8np+NK6hOjTQHa7k8B6Hx6yudE/8=;
 b=Z2Yf6EHDIz4XClQ1yOO/rNbpRKA7j1vXKByY7Flfkg7Z3I9u28BEM4KInxka9GmK3ACEsLJkyRQ/cogl/Fa6iqT9aTXHBDHqKFxvwaS2jzqPsYkHqWf/V7Jyck4m6tZJLucmzpGjk4fDJK8S+3cakvR8WZxDEe07GWDNU7rJEBifLdw7r+AHbgJ3KMQhaeWx3X+8xkWw7I2KiLRpMLcoHFkSb8Z8NvuXtR8/f0seYIFeF0ROTT/euqx6T6qANEEXaH2AWCZUFwojnqaua+tcFan/wJ2veE6UxorkBXFD/6Lx2Su/KkmXigoKeSze2An4vSUcyPZ+05ePQvO0ezNBjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:12 +0000
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
Date: Thu, 16 Jul 2026 15:20:40 +0200
Message-ID: <20260716132229.61603-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e05602-a200-45ce-d304-08dee33d62f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6n8YloWbIGqDLFTWPCyw7rbl80n4PV+43Y+SH915pZspvYB19gCi/aZQ5HM0ikD1tV7dSNGXrKmx+tvFl7mNt0C1oIHJaS+7R5PZ240lbyl65QCv/Ou0s5jy3VpEYCM6oUBDobN0vOvLyoZFJVjlaFwV27kqBBIsf5w9BXlj4VBlHITgcMfl1OeN15dLYCTl9zlI18i4+6Lrl62Ogh90S+kBjASJ6do5h1FhR2dGBu3PKh2KGVp7+dxXCSR3i9ARuzidF+Ys0wTh3CHDxjZtUuv8Pr+UkB7awsTPpNGgCS98IHAkF9tWbcQp/AZQWFyuRtnczLEIpXtxlGVRtmsujdepX2d2TYQ4CbPb5WLSVzfUUoLqQh9cO3BOA8Va7aFi8Q5w4HulZhJYTKvqCOlKXyDX2vxu+8KoeqvT9AuMxhaQrT0ZE1kbRLKVxyQvnElypOenvwf7WAgKzIQ5H8WTt2TXSnKXQoj3w8Pl63aJgh95gi1yB8Dfu2N8+UIWsoEfZNwHvynjhiUHSRqlhFzfMbWDe75x3PmGT3PDW0Jwqcy9MuFw2cIE06hV8fu2Nw1/PUfgtSxLbJMkctbgLpStGqIcuZf2h/piMoPV3VnQbriEio5nNN0LlkI1iXLuxejZDBiYVYz63xWJU1xmqDT+u3MI1qOYPySnJ0ue97upz60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vS4StU5pVkLg5KELbq68qeGhRBLSDtP06B0ZVhrjV89Q/RV4d25sjY5q1I2n?=
 =?us-ascii?Q?BePPVtKyfeNwf0FYKOFdvauMwA46ElL+jO592EyQVvR3z3AhmDwT8YdN/uCe?=
 =?us-ascii?Q?XCyr9UtlWJZgSUdjlXvock6DDaWlFoL5s9s7Q2fFwBnDeqAj8qH6Cr718w+u?=
 =?us-ascii?Q?ASQ6bIOLEZOBmRnzRpZfZ+z9wkzRjXGoWju/gCE4FfOUyeluFTzBAAbSRh6D?=
 =?us-ascii?Q?5GApFkqRxRJbjtc6QRuO0SyKsXzi6IsJrBEj3Dyz+nFidQySq0yhnMAUivc5?=
 =?us-ascii?Q?I+Ko9sNU8KJM39mTvU4VAWU38i8HiK5mYvcLDxM1EpWndaAnpJUEZRzmY1z5?=
 =?us-ascii?Q?Ud55D+c/sClePYzjN42TN6ZKQ6T5mcJW5tdpDGC/biOH6nT1xYaBmUFpeUT2?=
 =?us-ascii?Q?YhJwayYcg0AyHHA7sA4yFYo+CLZaKOmQ27fO26k9mm/52Ybb9OEj8I7tc3eq?=
 =?us-ascii?Q?KYUJ4Xkgqp5LHGkOsKo4pwaPH6Ro+w0a7EHB8ZIK113Fc+7wQu6CU5so8629?=
 =?us-ascii?Q?oaZlh9nrpsxtevjZq0YcWzQutMpPFO/fLgeyOXZUEsXXdbHdc5jIqB3Wu3vW?=
 =?us-ascii?Q?SiAU11LkIZTcMgAmSmAsAh2jslnPU97H/bYPlBEtMTNmKbTq0GJaaaaLONcZ?=
 =?us-ascii?Q?62bVxDOxbUy0AKLMqF6nziMFq34em07RP9pmR84dtCAnDIeNxK2vU4BLMgCY?=
 =?us-ascii?Q?rFS9S1I7WugM1rH6bDg0OZNZU0KwRbdOgo/8NQouC/OdCuurcmaZiraOjzLw?=
 =?us-ascii?Q?ToaWJSBw0LtDybMgu9ENCJp4fLmM0jY4QXcYtQ5IeVyGFkTDZLD7MqF4xfJr?=
 =?us-ascii?Q?Xz9goQIPq0GxJqshy8nxU8JKf+RoDKZp7q5rUjL3pjr1DLjeEV1W7Y4eTqcQ?=
 =?us-ascii?Q?GUZegCY16SAQR2OKoi0UrTXnRhxuD6vSLitboXUDaPGBg+3f0XZNt8x9RIxM?=
 =?us-ascii?Q?YMqDFnH27nScTiTKen31y+cj1w24uyEhmT8ANcV1iFbUYhJR/jR/7KuOo3F9?=
 =?us-ascii?Q?KdhfJTAxjhv4n1mfrlVriDSybgaxL7m6c2//At2lnCEbncxW8jA35q2/iTSa?=
 =?us-ascii?Q?g9NDN0zHbNg+0aEAbjhQ4eWheUI1CUMfrAKO8lHUfIKxQbAZsfsVWwEkE9/D?=
 =?us-ascii?Q?YR80aPVm94Zv7SmoTGBjzdcjrXzjXZD1SgCkMr2RPaBZJgtdqBNmjXxDpEwI?=
 =?us-ascii?Q?0gFaRCC7PVw/Pi1RLG5/uZ5gUTCE2co734y9VzGzD/2Df2iuGvk4gIpu8h8M?=
 =?us-ascii?Q?RmmHOHLodxMtPJxZS1crvipEbUI+mpx2KLPZAMCPcot7ajAUliKqVgyNzZiY?=
 =?us-ascii?Q?DMRjVzAa8FSKL7WLsz6YbbtPCQv8BXYYq3KG2gtg4cDkzbuwMuaNMYkPjZZt?=
 =?us-ascii?Q?fjonjAAsqrPHUL7oG59BHwNTdXwfA44B3C3Fs9hetxrvghGT7oGv2KNgznB+?=
 =?us-ascii?Q?F944edGZYgNkeczTntKPP5eKRIDcZMetPYr0D47mk+RXyNBuBLWcGq+cADCP?=
 =?us-ascii?Q?U/wRInl1Isb6CZvBW9s+muQ924YT7hbshDivI6qz57+s0m4urmdiXX8Wq1oi?=
 =?us-ascii?Q?SlkfSFCmIFHVei4dg0p+bO0WiGYKpXikQiXgeHmIUogf6aSpaguw3OWA/Bwg?=
 =?us-ascii?Q?YrWt8/0zZX1NkuuIcmb7hsSHx99IRSrhRcMbboj4euAQbry6aCeKhv/7HII4?=
 =?us-ascii?Q?hT2LQVlzF0ctXRLpHxfQe5GMJO29aWySqYw2XO8d+HNdv8QUUqB948YIT9QN?=
 =?us-ascii?Q?JVg59o1Q0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e05602-a200-45ce-d304-08dee33d62f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:12.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSsdlYqRp3mFgYz3czs77lZ+ZWu4hM36qizTtcooADjErCai11lTxg0P+/NUChEx+dwUJNEOCxyYpJEolFG/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

When pulling a task from a non-local DSQ, scx_consume_dispatch_q()
filters candidates without holding the task's source rq lock;
consume_remote_task() then unlinks the selected task, drops the DSQ and
destination rq locks and acquires the source rq lock before migrating
it.

Whether the task may be remotely migrated can change across this
handoff. In particular, proxy execution allows a task to execute as
rq->curr under another task's scheduling context while its own
scheduling context remains on a DSQ. The task can therefore become
on-CPU or migration disabled without dequeueing its DSQ entry or
clearing holding_cpu.

With proxy execution enabled, a mutex-intensive workload such as
stress-ng --pipeherd 0 can easily trigger this race when a donor becomes
active on its source rq during the unlocked window. Migrating the active
execution context can make it resume with IRQ and preemption state from
the wrong scheduling path, triggering sleeping-while-atomic warnings and
subsequent lockdep corruption.

Fix this by splitting the validation into two helpers:
task_can_run_on_remote_rq() remains the preliminary lockless filter used
while scanning a DSQ; task_can_move_from_locked_rq() is used at actual
migration points, it requires the task's source rq lock, rejects the
task if it is still on-CPU and then applies the existing destination
checks.

After consume_remote_task() has switched to the source rq lock, run the
locked check again immediately before move_remote_task_to_local_dsq().
If the check fails, the task has already been removed from its original
DSQ, so cancel the transfer and enqueue it on the global DSQ. Use a
non-enforcing check, because the failure results from a kernel-side
race, not an invalid BPF placement request.

Deferring this check until the source rq is locked both closes the
migration race and ensures the task remains discoverable by an idle
CPU.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 56 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ecef4cd9be1fa..08773f0aca5a6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2364,8 +2364,10 @@ static void move_remote_task_to_local_dsq(struct scx_sched *sch,
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
@@ -2373,11 +2375,6 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
-	/*
-	 * To prevent races with @p still running on its old CPU while switching
-	 * out, make sure we're holding @p's rq lock so as not to risk
-	 * erroneously killing the BPF scheduler.
-	 */
 	if (enforce)
 		lockdep_assert_rq_held(task_rq(p));
 
@@ -2424,6 +2421,25 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	return true;
 }
 
+/*
+ * Final migration check with @p's rq locked. Unlike the lockless DSQ scan,
+ * this can safely reject transient execution state without losing a kick.
+ */
+static bool task_can_move_from_locked_rq(struct scx_sched *sch,
+					 struct task_struct *p, struct rq *dst_rq,
+					 bool enforce)
+{
+	struct rq *src_rq = task_rq(p);
+
+	lockdep_assert_rq_held(src_rq);
+
+	/* @p may be rq->curr under another task's proxy scheduling context. */
+	if (task_on_cpu(src_rq, p))
+		return false;
+
+	return task_can_run_on_remote_rq(sch, p, dst_rq, enforce);
+}
+
 /**
  * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
  * @p: target task
@@ -2481,6 +2497,28 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
+		/*
+		 * Whether @p may be migrated to @this_rq may have changed while
+		 * switching rq locks. This is a kernel-side race, not an invalid BPF
+		 * placement request, so don't abort the scheduler on failure. Fall
+		 * back to the global DSQ, where normal consumption filters can select
+		 * a valid destination without forcing the task onto the source local
+		 * DSQ.
+		 */
+		if (unlikely(!task_can_move_from_locked_rq(sch, p, this_rq, false))) {
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
@@ -2519,7 +2557,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+		    unlikely(!task_can_move_from_locked_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
 			enq_flags |= SCX_ENQ_GDSQ_FALLBACK;
@@ -2682,7 +2720,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					     enq_flags);
-		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+		} else if (unlikely(!task_can_move_from_locked_rq(sch, p, dst_rq, true))) {
 			p->scx.holding_cpu = -1;
 			fallback = true;
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
-- 
2.55.0

