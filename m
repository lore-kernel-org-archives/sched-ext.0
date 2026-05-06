Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877E4C0413
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089655; cv=fail; b=VmVUQeiwzH59ydFn7M1vttyr2VXbhldBXI3SJ84jhArv0qn+L3aN2UN4JftP8z8kK/T+vRRBpyHQRtW5MWKD6btKkOXqlYXDxXjA+BoUaGxqb3nHr86X9V6veLd9O4qDz+Ky9oAi3NKM5DTJ0xHjn2ZyXNtLX8Wjrj/tRZItG8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089655; c=relaxed/simple;
	bh=aBuNDuFvuC6u4+8ROBlZFlw7SaXtcH/cnZ7VHFdZR/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/iGj/09i/tVfUIDkE/BbGdfGCT11jOYy4vc4sao9QIRTz7AjP38YdQCgl1C+pYu3hkSYLuaKGys7ja4JvGljAi2/BW39tqWfXuYuginPccu7lKaTk1287357rmpRbJw78m+YqdBsN1AHRiBC2q7GooxwaUGZhgitUveejowlQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sknWVvDJ; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sknWVvDJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK/DovuAtvLcn9EvbIU1l2/G9/pQcmIsoqGB/o0FbycaAjvEWvmFmBDAsH5ogjU+lxR5tDMac9wZsX6S2etO64naD2dVXQC9C3h56kVNYtqrEObi/AQ2G5O8XLhZdkDdTrilFJ2sZK+VIRPUM839IK97sfjo9+G+qnB1wukw71ZWJSUSQBGQNgwPzrAzyukfsxmLoQ4O2fguI1aKLgz88oSO3BgHQeHdVAPZwE3xfYunawzMfGFAWT0gcZIiRwx6o8a0SycJXWLegoRmur8LB7zY6pIc3M6Tv5uragiOJ2CtCn7MLsg3ZA5AKv1Cc8Zb7JZ1NgC95iRRlE7DRRQTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2+bSx4ahcG3u/tfsQTZvvIWQqmfWibztOUh56NQm/o=;
 b=t8V44c2Ofphadi9AtIqPSXvLV4AfQynKf3eVjjjum/6S3QDNeL2d2LAtafoJfTvUK5nx5NEY1qMZIsb34LblmETWLbm2yWd7M4U0o3/OlTsCVZUvMFrlBygcpxrJmSB7ghgW5tSTkfdCck/KfS7yHOAoTrBgyFGz3FFYhImp6x5Uvpq2snWGafr1KVvQxfUXmPQ3k0f+61N33sFAZ2WcSzTRBOTWPNsSM4rSFKBYw7L6tvV+k2vNXnz/W0vK7gdi60/UYOZVNe1wTmvOpAY1NxyOxIgTrVs8b0A1Y3f96SFhScsaqXdP/Q2ifmz4PPwG0nmDVIO7aOYazVpfJ0lGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2+bSx4ahcG3u/tfsQTZvvIWQqmfWibztOUh56NQm/o=;
 b=sknWVvDJyDQc+nLDXZTJpvD9gjHirtQp3a5bnouOliACoUXfjHJjY75yzHCiwBxzPJhsB5g4OY5WjnSd8imjyfgNsgCr/rd/fWGzEdXFl5xufDgLR9Mtbk/yCNeEm5eaS5QQNYJ6GHuY/bZtX0aF/xtr9Jd3//KcY8MuMExnjNzYttM8f/8u6zxShn3diuZvoEDxf9zwJ0sWwLOC6FBDRgzje6raVdDSi9XNBG9UrCCFNdRx+4nfBGViKzQAzD9ef/9BLaWVOeGGfNXfUz41MNYBT37VnjXZpq0ljpJYWtEnikZ3fsJqBVJITLM1HyJZwM9wrfspxEtk/KEEBwjvYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 17:47:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 17:47:24 +0000
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
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Wed,  6 May 2026 19:45:46 +0200
Message-ID: <20260506174639.535232-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506174639.535232-1-arighi@nvidia.com>
References: <20260506174639.535232-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008D5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::430) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: de0f81ef-9a82-4227-82e5-08deab9787e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n4hEK7L5WRiOuHvGSxj2Ci8owDD1qvDr8vWBn4PR6crpZz2TAGX1p99gS53mM8FHAxQo0KkuOpdSyiidOVKqh7DEfWTRO04s5z9MtgQmS7WGZIW1Pq1hrhFfqhj5QwLhmckfTPvIvCF+KZ+LYEMYTzVVTK9ZQxZnX3Fp3xaE4xpIcqGVlJiwvio4x/iyX+71NdPwEFGSOjEKOdrj081TfU1N3FoanjxY8s/X9GbA4uFGjO9x1n713qD58qO2zPWRniuQFRxhmkwlsBB6oPc4kpQ2DuTpPKJ71t7lNOHTs4cqSJMMS5SQ/rexV1k1Vi4kGrU2C53tejQH/Jr8bV/RRMY+etHMCCtiGX2gARex+PUdZM3Bz7Ao3N9SkYWtULV0Eb7Pkv/gfo0q5gUdyf20BhTyGCGl4tuLZF5TnA1kE9tzjBOrZaVK/dg46wFs5o3quhP0AyMGbeWgiOeLjSCHkxcbQFgN3f5VoCT1qpuxmwe8PJCfsq2qefpo5mMycwQrlODoHI4iZBsxg/F816gYpmZ71B1qI+FytE2mgnBplyUTcRdxw/HRBzK6bkDaP4D81CjjKsK/h1DfY3rfnr7JdRqqsCmCzRT540rTX5+lW3YW4xx3BFEE4yepvxDh5WmMVKYtmQrfQ1I3pTlkQEONXxS+id5ZUgWiAcvKeLA+GYXGzW6DUmF44QCip3kY7tCdQ8SzE732XeKygDRyxmEY2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cwsIOx9RQzFN4UVN5o5P07IQtrZBE2Kpq4fP0dRqtT5MlgWO6/fp1dhSA6hw?=
 =?us-ascii?Q?MrjaGKAoGoALftRI8zUvA/BGDDtleBsLd2qincAVde8wlrXtEKXsvaI6joAl?=
 =?us-ascii?Q?sIQeATqBHnku3iBD+hilDaV+dHwurz5UeDW6pvhpvCoASetGlOPXLGb68Lew?=
 =?us-ascii?Q?CLYLTL9Yr1zZ/B6wZAWoU8J3bWgHRdRN+zyFtYNOw9W9nh/SnH3M+01OoeKK?=
 =?us-ascii?Q?Sh2SjcOhiik0bryPrz9QjhkyyAmzf4cBGhsPXB4o8Fr7+iJV44fjjddm98sv?=
 =?us-ascii?Q?1KM65lvvaNzDo6WvasNZbuhSs74YYhLKMq2WznR42ppW8VD9QRULrq9CZQEy?=
 =?us-ascii?Q?VwOpEtuMXKb518os3oQ9QaS5EMP2ynZb8Z1VIcPYqZaY+LgDLuu3HJQEfV5F?=
 =?us-ascii?Q?vzMVPsi/vWWPHNMERXdYQya+1HS+CagbDSLH5BR6oFy1LY3HEoyQaPcdSQyf?=
 =?us-ascii?Q?7OaWyR5tlWUMHKeVdVBrH/M60vtnSYeRNtAmoLoq6ZIVS5HztGIqKd79q3LY?=
 =?us-ascii?Q?IFrOnu53JV3MIvCyuY/MQJW+pOaJ/iPnKPHud8IrZqNZAiegt+bW8RqM/Bmb?=
 =?us-ascii?Q?qtvKxHUBTOTDETGMUV4D0EAXt/S8ZeH6t8oS6ff4MlliNhJKnUBWdNXep5Cl?=
 =?us-ascii?Q?f8iYdUFvgdkYotp7q5q4Ty8JbdF4CDrY75NdYQfraElbJn1ZPsSlkwiPgGXH?=
 =?us-ascii?Q?X1/RvBBDC9Yndszyq9ouf2JMTYdqpV7DSPqGs5dj87XmXRgCTl2I7UMW6Y3D?=
 =?us-ascii?Q?uzNlTAHa+rqqX9JKv2NosI4nKejJic2PSLcmurDFoCd/m/s3WgAgj+4Eyc7M?=
 =?us-ascii?Q?gKc+S4m6uIswNwysxmaYbUaGia4POvHgngmNzWLurFUXvJr1yjWMM1Ty2QIO?=
 =?us-ascii?Q?ffvCJkfQOrJsQYFobkpXPYuFHZkyKVK5dqfOYpPtXbzuluJosZzrspFG9YGN?=
 =?us-ascii?Q?QkCzrI3coxc7IlM2Ur3vGZUKXGv56g4m2k4OBrHTD6Sidt59QmfHudQZUi+H?=
 =?us-ascii?Q?1HQXYbym3RbFebL8OXCgp4RDpvR5LfGLGE2EX2iKIa9t4Cf3HVLMcZqJnNw4?=
 =?us-ascii?Q?4+hPzxUE0vHxTDpGjAX+aNj35PfRQVirHbW0V6u1iZU/uiHR4Js8E85ITtA9?=
 =?us-ascii?Q?Fa4ZqFiugAMIa3sJafSxnK92RQyGwM+2A5ADrnpDz/9zpD2TNfTAE++P1h38?=
 =?us-ascii?Q?jHmsthhTpZDGGcC5KuuygIHBdnsDhDM/zoBMNzpZDeQsM17SJpbSXh2k40y6?=
 =?us-ascii?Q?p0kwIdX2ZrgP4WfSI40+km3F5pj/eb2pu2G9oegG/uwB/G2TmO3s2KlWLU/x?=
 =?us-ascii?Q?eGy9UxvULoKasr66YuIT8i2/wzSPq3exewXIbeFWd1PXYyPWuSTOV2PPXzcx?=
 =?us-ascii?Q?C8yiixJwT5EuPHI/El09PL5d1FIF3B99SXSUYP+Cui6W25B6ixGWqv4cg7yx?=
 =?us-ascii?Q?1CSI9eBblCHaiw8eM1Bp1sC5ylqGbwnxUeE2RnwUGH0jDLqJB2rUZbqg6/jo?=
 =?us-ascii?Q?TBJ4XmFhXH2/3/eAycp74qCpk2TP3JdPtXwKXJHWQ5qxHtuAKYFLo2HStngt?=
 =?us-ascii?Q?reYwzHVERPfMcjPvo4F15iiiDikmgEbcYPL2+vTXUE8NuBAyec66cCSNWLNe?=
 =?us-ascii?Q?3zUWfatkUWzeUpgN6+lsQTKrxz1pqo8tAnpNqYfzISkN9ZOA0oBFsmuYrzuo?=
 =?us-ascii?Q?LrHi9M3ahlE5Jbsh8to8gapsbbArrABwn9/mDWk8ueSvgMHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0f81ef-9a82-4227-82e5-08deab9787e4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 17:47:24.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNOWjQ9UqD/o59wxTX6VE5eyyKnGMWMr0iFVuGAUfxikgy5HaN7IWLzbYcRbnfFLSLYL7s35YczHWlJSvhRk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

With proxy-exec, pick_next_task() can return a task with blocked_on set
(a proxy donor); put_prev_set_next_task() then calls set_next_task_scx()
on this "ghost" task, which fires ops.running(). However, the task never
actually runs.

If we simply short-circuit set_next_task_scx() for blocked tasks, we
break DSQ bookkeeping. If we only skip ops.running(), we create an
ops.enqueue() -> ops.stopping() pair without running, because
ops.stopping() is still called in put_prev_task_scx().

Fix this by introducing a new flag SCX_TASK_IS_RUNNING to track whether
ops.running() was actually called. Skip ops.running() for blocked tasks,
and only call ops.stopping() if SCX_TASK_IS_RUNNING is set. This ensures
that running and stopping callbacks are perfectly paired even when a
blocked task is picked as a proxy donor.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext.c        | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d05efcac794d6..5096c05d7a978 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -102,6 +102,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_IS_RUNNING	= 1 << 6, /* ops.running() has been called */
+
 	/*
 	 * Bits 8 and 9 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a70f8693b906f..b6d29087ec0e8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2164,9 +2164,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
+	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
 		update_curr_scx(rq);
 		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2986,8 +2988,11 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
+	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    !task_is_blocked(p)) {
 		SCX_CALL_OP_TASK(sch, running, rq, p);
+		p->scx.flags |= SCX_TASK_IS_RUNNING;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -3076,8 +3081,11 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_IS_RUNNING)) {
 		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+		p->scx.flags &= ~SCX_TASK_IS_RUNNING;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.54.0

