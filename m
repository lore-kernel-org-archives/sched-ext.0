Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7937F011
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321532; cv=fail; b=U4GWgbjn7OEuMAArksCsF9p/ZXp4gUdGqmdcZz7bvjcAT0BBOww52cGdCFhTCXDMFvfszykr0smGL+IR/p4DZqvAX9TJD4LALKyCzmcXDSyf5p2Tao9az9GZkK2HGgnTDBtl/tZEOM9QlZ2/gcLvvUOd5Pq9F0tQpd8zlzmX+zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321532; c=relaxed/simple;
	bh=Hymnar8/wC8rRI9RplG1Ghbvm9hnoZBbzBjjK5Y6nT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mg96QHEKMIyMk09G2t66263tL4wFvFz28c5kkpG7/yfKW9RMfkXSBvQwgmXwzhuGFvdlDSo8GySEHbgnFjwacy+uCTOH95YiyPrP0Loz6oq23XKIgChB8/SUvmxSDOdQTyzscHLSdzDXvTZIQOk+ZhnQTTabmNgxmjw+RYE/pRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCAPWz9q; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCAPWz9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW4xjCA8RLfran/n5XhdLyBJQ+j+hYYF3/Mwt41BSnN//W97iJBCZbwbweyyZQXORHODv2lSG8pz4dYK4kj6Fl/jS91o+YjtLMwycVBrnUtyqTp4fy+DuLCgzMY/5Kdi1+nNlcBZHCuBM94kWgibmfsky1yntMg93zI/JAZosWSmsQBLwuFRFCWtKdmznfhTu4iR2BnfO1fU8N7QYAF5q33LkV3QFYwNACiGCzeKEOorLHNsxkB6vyn2/u7V5NrtuQaXKbl0BoR1p/QnYfr3gP8hVqr+qoS7EGOwJPvzmTB8TvzJH5mC4vuUwCF6Ptt0AuGWmw/TcAk5gbWdkHKe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQdHbFf7Dj8+p7rz5b4C4UF28caVQtPr5tDm13GOaGI=;
 b=MbZ2mA3qg7qrbjoaXn/UTsgaUDDLT6V7n4agV1INwsdr11RhSKyyg3E1i1JoRLKlXYI0KOW7UbTjZIJNpg1+1ojebJb01dGnxPgd9j84szu/eIe/XQXJP3yjohwIW3pyKu0Kw7XZJHAB9crTPIjub54iXQ89D3J1PQ44Pd5LE7goVfqi4/AwRwvl4kOVBtSAv+nQhMXjSmcVPClQyy8G7e0nL4zSTCWc4Bo5hOK2KNv/jllh5Wsageexr9DnIHMhYZahybB6gGcDG1XvFCEk1/Wgif7JZrz2KvNVoiI91FX4Qqgh+E8Zj8yyOeeNJSQzveHgklUcK56AkhaP+Rq7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQdHbFf7Dj8+p7rz5b4C4UF28caVQtPr5tDm13GOaGI=;
 b=OCAPWz9qwtoS2/6eREMydAHVS1vb3eETBaeVEJ1Dq5zoBPvck+kWuB+nMKCgvag/JvTQAE4frrli92aKFk9OyGbguCTEFWlCV/e+WVMgF908VV4s1IMDpvedxyU6YBNo6JO0ZLTY0AmqlemoOf0k+zUo4A+OwWJgZBnk1f/euR5Tr90aYIC9TvNudWSfwg2CqLaqKvewWZlxr0f+f+e6UI6mEBENKw60csh/Yp5y1N87/4oYAn866CIFumE5T5fdBFqB0w8I82znsoygWtshsGAHptDRolVjOT7z2xNVBtO692taIsSCnJ5iCqdcozekHrAaXyuO3feD7X1c/IRk3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:55 +0000
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
Subject: [PATCH 5/9] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Mon,  6 Jul 2026 08:51:00 +0200
Message-ID: <20260706070410.282826-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9cf580-4bc3-40d0-ac7c-08dedb2ce272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	L2YgTq3x/WEwAhkWgeyUpyac+vO1cqSHIiLd7TWEUF93/SNGkKkGE1HKAY7ye1iAq8W53UVNCZ1kVKUpjPeWvvsUmoWS3u9YSYFB4jqNqHvOBNnVIK46VdV++nbhdOYINl8frSn/LjxyT6fcS0hP31tlaofEMjoI5gIELfLs4aQoMROAqa62WD93bVEQUTDBwWzaMSDx54m5hsE6wC1BfzEZPbDZMx/6/3ts8LSOaFXVfMtnFt5YhXkxj6V+kakJJrk2CMNcMUcsfJQ+ttNPcCOSzU4MykjGqHobFJb+NuG6KCXTEIBP5PtR3Rp7bNiL7vhwQcwgmELgkrNh7AJ5xaWHyh4gY3Ahz2VPgFJXGVHuERP+21t5q2YpImwPFlDC6apeiLmlBQdNiIR4i+YVxJx9bOsSi8OHZez1e3I+g98wkvK7HKwSTX/Kb1UTox87IIY2dpbE9/U63fFC9ByULOQWKBEKgoEGs2fJk9pTo35NCZ2dWGcptyenGf+J0iu3eAk7uoivcxcvpvbrrHkAZpakB/CaGCZicysGqYjOgyrXXxSsQjVm5ejEf/61fo3EZvA8vTwkrS7zIvc8ujd/vs7H8LJIFK9Pc2f4DwpkWrADJAggZaZp62gU89OlgFsF5/O9xBtaZjYvDRyxC8OetXT1K0KoJta45js0Q4Tdn/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/vaTvfoYukJ0FAqJ1sEtpzDE8OsSTauA47Yo1+f1TVrTIgEr25vk07xIkR+?=
 =?us-ascii?Q?jUWPLA5VZvk2hBFKpdrm981V56ktvdNFgCnN/d5l0Fn/KmS/20z1QuZZ382Q?=
 =?us-ascii?Q?M/OgKJ6KzKTbB1qohih1QWEH7Dr5oY6he1XMV8HTpez/PncyfDj8u+Q8T5TR?=
 =?us-ascii?Q?32YWHX4RMTcr28lHTCOAK0uppA+hlozRB/yY9q/6RN/HXC1ibtQRfjPMQ8Tc?=
 =?us-ascii?Q?0+h/bnZ+5a8mh0IUh3ithw3ZeXF2LSZkHNc3Y8zE4SotIPs+Z7265UqTRjfc?=
 =?us-ascii?Q?IzDL4sHLIfywgOxLQTyYKbzF1FHZsG4kRh0G3x4SbyA2mPF0fgSHJjHlQKnT?=
 =?us-ascii?Q?Fk7hjK7pXrA5540goL8u1e1vI7Um+K7CsOoKSoz6AbXn2uHJEM+i/gRBY767?=
 =?us-ascii?Q?mOIWjTIP8JQyr+rZQamUpbDdpQZs0CRD2UqAShIRzdAf285RuLuR+oCmCdvk?=
 =?us-ascii?Q?Zu2alclxwngm1jvS17wuYKxEbrZNMwzZFrofmASS2jYsPQggTARJ63aiIaAE?=
 =?us-ascii?Q?VhQKJIl6hJCJJ3dVnI8DPm1SvwLn8xpUM2mBmsnDIyygdsNU1mIs9D0UeUDb?=
 =?us-ascii?Q?FjpAvzCuk/sU76Nz1D7/MhrphHlbbdzAWIT2Bigrjp4KBb5mkbaG9nFup+Ji?=
 =?us-ascii?Q?OHvr+3xeS96CwxvUpOgmItKeSi+afL1Mn4qu/j0VhbLnyeAvlx1OhnRZcZy4?=
 =?us-ascii?Q?65ZgpTQwVlTTn2ZLo63gkILvA55VgESA2ZVmWxBJrLTnKuKtaAmE7tW7b3mi?=
 =?us-ascii?Q?osiIaCtqIsXFO+9EAZ+MLa57G+SZjM0r6o6mv4eCGUxOy2F8idRn1IChpvCB?=
 =?us-ascii?Q?QDw8ZUc1AATxIzHXRC7WzaDifoIqjdKajJTWjdZeUzRn2CCyhtfYOG1919zC?=
 =?us-ascii?Q?DIysPENDnv+3j76WkPffRZFvgy1aiJ5O1M3Y3dscSriN3XPJK1lvTr/9LyoO?=
 =?us-ascii?Q?iGzUp0MQ6Lib5LQiO3xVwwrRtnOKF2nZS4U3dV5pLPnU6UcZa8E/j9QsXMx9?=
 =?us-ascii?Q?/fQoOj5r0kln1jD/gTZYPPKA4S2bXoqqnPPYx+m8C5e5iMDBCnv75lfarP9e?=
 =?us-ascii?Q?D25viHB/pHHiX0ff4mBByiz/fT29HaV1O7Z276BN5lJ8PNIDBXTtijLfNy/t?=
 =?us-ascii?Q?cIzYi2Gb9X2yWHt0vIfSuUtd+zmQErwk2/+77M0udvLn952wxb91MTVYHBuc?=
 =?us-ascii?Q?XQLG/CnHm4bpc+GzqgfbuAyQFAmKSN9Bzpalif1gkTIaBO+tI1zUns+VX3UK?=
 =?us-ascii?Q?E+tYtqktye26ZoXfzqxuu1xCBHZrLnUUs79ckHipVb2+IG8N7EASZ3zL/OlQ?=
 =?us-ascii?Q?xJEkkO9sv8t63amRaNrHwh7/xGYNra9Jn2kW+uKWLpY4HxjbOAhOPHKcH0be?=
 =?us-ascii?Q?zpYmUXCem3D9EKDxrrGTq46WYYdM1X3subc7AHZ7G5lrWN+kILuenK3mp2Bs?=
 =?us-ascii?Q?QoqyNA0cUOaC3vKdE2n4xd0ljW5ThY8BLFo27GPUwVc7R72TgfKgS39rpa11?=
 =?us-ascii?Q?JOo16R8LTOvC4wtWR+BGDL8+LaLftDgDjzLas4z6XEofhP7tPgIrjyxNcvwh?=
 =?us-ascii?Q?nkddsEQaF6I5++dzsJD/wk4w3z2xTj+tyVXRjOBL8TNb+VLFyu25apgeVcA+?=
 =?us-ascii?Q?BcZMEUlXAtR1cZwY68Kl6mwI2vqK8Ty69A4gQhzsY8GhDIfaNpEnwM20xIWj?=
 =?us-ascii?Q?5OWotM+fO39n6QBynBuFhiAfbWYS6bxHbbhgry36VdqGagQZtVOdd1duw3nk?=
 =?us-ascii?Q?Mx4Pm/qqcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9cf580-4bc3-40d0-ac7c-08dedb2ce272
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:55.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94yeLkJs6ma6bxBQmoLtH3pkyyCU123vMTCsRyoiNoNApNunwLpjhoVvzhhRTkA01wrFw6ElvOUl8VjRI+gixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

With proxy-exec, pick_next_task() can return a task with blocked_on set
(a proxy donor). put_prev_set_next_task() then calls set_next_task_scx()
on this "ghost" task even though the task only provides scheduling
context and never actually runs.

Calling ops.running() for such a donor produces a spurious running
event. Simply suppressing ops.running() is not sufficient because the
following put_prev_task_scx() would still invoke ops.stopping(),
resulting in an unpaired stopping event.

Introduce SCX_TASK_IS_RUNNING to track whether a task entered a real
running transition. Set and clear the flag independently of
ops.running() and ops.stopping(), as the callbacks are independently
optional. Invoke ops.running() only for non-blocked tasks and invoke
ops.stopping() only after a real running transition. This keeps the
callbacks paired for proxy donors while preserving stopping
notifications for schedulers which only implement ops.stopping().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext/ext.c    | 33 +++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 75cb8b119fb79..c6f58e1a66cdb 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_IS_RUNNING	= 1 << 6, /* entered a real running transition */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e7cf88b2be7f6..85e07cbe626f6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1985,9 +1985,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2743,9 +2747,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked proxy
+	 * donor is also skipped because it provides scheduling context but never
+	 * runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !task_is_blocked(p)) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_IS_RUNNING;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -2834,8 +2846,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	if ((p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.55.0

