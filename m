Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86F3C8C5E
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149017; cv=fail; b=GLIm/MvNGxqS9qNUC7SKcv3aEYyz+qKHk3fNbweXZBvENlCADSOZgxRLJvUyZM8tmaSXkQQcULLQngLgea1nQk9v/yRCkv11IiJ1qeaLwrlf4QAzTYEOXH5b0t/cky1Rq2HI/+5xBjKkoNmF7Fn5gySJqOjujL5GrcQhG2CbNiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149017; c=relaxed/simple;
	bh=W7t9XG5SJ0kKSMbMY38+m6Zi7PGLI15HM4e3S2JEx+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDNMhioVFsdPxuJTORNo9aD5A1ug2zXIrtz6h1XQGeyt7Ry13FVGZ2Ds8RooAhJuHHejQm/iD1boc3yxcNVokG0lSM8DFGwhjGYflyftlheQcvMbFxe+N420c+jKoWskHwLUtAXgYDydJ0FFzWEl54w5pNb5XYDiZaPM3oItHU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBsYQR0z; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBsYQR0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf8RbzwgFXxwIbYG4qgAkDHiWC9YaldYSeLvy1bAWLXWcQ3YY5RNTrbtWW5Vz73CxA34QeZM3Q4f9HDhBQK7VPngIOxspr41YRsRZ1Oeck1yWAg/yvydhpgj2ZgafrSk5KueWv43ldSVnFclMgIp1nITAT97HRVoZmYPIkPdKhM+bCheiGx5RIRpj8vbDzy1edlJAjpprUYIvuaklv8FsM7gedlvyc78Z7/UXgdOWNHM1jUeVrbR6cdGiACH8Ar1FSgl/5xEmgGRRdIRVyVxHL62FoHEttNagvaNiBRuaj2+vjEeMZVIUzHli4AIpYn6R6VdZ/OTxIPnO/u54VR4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE/L8gZf2Di9xnCGoMEpBxyKxduyC3sp15dIbAaW/Ig=;
 b=Bdj1lIHa340ZO/EfvhWqxZ+7C2Hq0UmSs/v6A9qik4ATNACeq7C76H09ryMKYgzWor+cSUOnmHHoyusHPtRPjDLNPwKqxw6Q3DG3bwcJJwLOl+k+R8H6r1+RI4GByBujNQKUMJvaNMgEz5ncZm9VU4nMBr8HmTcatfa5IbBb6Rgt2tVJaxRSxNAY3KgMuEJEmj59QbVMO506e3oqrZv/g7fm8ZGQTAQYxJ4He0vafE77nAfsaEqKsVz7KoJR9kV1M4wVZCZ1H4EfoBxP0Ht4X+rfMKXU8BZp73bWPTbrqEu+ek+KsHeGJ/+I1IYYFlOiTXomN+R8s4Vej7dwD+L5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE/L8gZf2Di9xnCGoMEpBxyKxduyC3sp15dIbAaW/Ig=;
 b=QBsYQR0z6r2rS3jwLr2Aq2C/0RNiEuCrcL0ol07TTOAsWXiI10QWq4iTC1aWUwJiS/P3d8IzfeUCx7PCsD/PaPgchRT7GcbTpobcYGimUPMNWg1btv7RYykjn1WiLz5aFILJDuG0bb0Slby0DDdrUYaGEDnpU0lvo3rM5BnF5SdEuSWqunQB0b0YRDfQic/FktxHWpmj0NpwpOMOAjuqYI8X4LYnVcaz+tNxzi98yvIciz4VMAaT6p2D5WLvizVBegVse0qeRzzgQbVw5wvor869wffTYIizJeZxQpsivFV9GS4fYCjTaIV2bLZcj2UWxq5GTpNgGxFZjsVu9YNapw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:49 +0000
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
Subject: [PATCH 04/11] sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
Date: Wed, 15 Jul 2026 22:54:12 +0200
Message-ID: <20260715205622.276220-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6a90e7-bf7d-4bfb-061d-08dee2b39704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|10067099003|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SryjEnBb2/N5uN9WHHCijnaFknlIUwaswX6Qj1XhffhHonohhKIZEJ09QAsZ7zsxVZlWzkrrg4iG3Fpai0PPuLN07TR6QmxUjoYow1E1wfJqZnBQ99WK96mpkjQZuFQSCbsTzMxCW+ORgiahXo2h4rsGsBTa8gIN8WU1HataC/5AI/SkttVA9aLYud0tvbkZQczxiWc232l7Bgqtz7yqN2GEhG4Eb1jjA4+2/hzxdUmcaoMTtU8PYzP9ZYrVDqtviqOEIeOUaOv22a725pPpY6YgIK84/SaveAEUv99KFRKaYdX+/3kd5DA7nNWby/3RQd7DQ8CEtIfY7a7l6rWc3MV1TrQrVk9X8A6Nzp+9RghoarS/v8CePKfHdY6INUCUQ64ngUV57zOzDTswhtBqsT6DLaJwGHVXkH2K3qghE1GWnF4yaqGou9aaOSdUC95YzTF4oALulULk8cI0JWPi9c/VVPzOp8880LNoAYjLkX+ZO/cc/6qJZwZNi0ARJnQ6xqv5bBiOHGyC/+98eC61TAEx1j3m2+AD9L4CsFepI8LnHY+dE/vyn86Zoe/z0EiU3OoH65i6ogk9FfR2ajCEx+x7JBjJq6IGr/k8tNIHM81n2OM/yYijGwMTNPm/NecpBuT0lm2qbXfKVWJJjNWW9xTKMC5Cxnb8AWzJlBbAqZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MN5YvoYebM8pTYTmU0rhDIgSXHxKoMhWyeDQVTP7hMNsoBvJ3/vDW1p6wIy?=
 =?us-ascii?Q?A672wjW9CT5Qm1HABbKLFjzVIo/y/qWXmVIPVKgxAElAGGDSilKeR+cTU2tW?=
 =?us-ascii?Q?R8AntN66R5JzVJFqddlCQ/PIYzyM7EiypctUOm7Z7m7kEh0//Wc6ZTtOAt0e?=
 =?us-ascii?Q?yF/8gKQzAX5HCTLXocJ10eVhTlzyJ5EeepcxV0ERDwp/sjtKoI+SIyfEFubj?=
 =?us-ascii?Q?XQKJW0+/CccbtlDEJRh7kx5SQfzER/rQtmd15xrrxCR62HkUm8Fy2HG3yBMM?=
 =?us-ascii?Q?4BoDRDNxqXPFLSLTnIKsKn66AdnqgFne0oI4A+ECbc9n6hlylFYFw1CWGM1j?=
 =?us-ascii?Q?SqBFKZeJDUw2k6bMUSGGk+kqq9f3ebY8W+XZTF8Xh5ZPUGMSFUartYhuh+Gj?=
 =?us-ascii?Q?5ebhLluh50vXpfaHvCdJ5zNxSE/twVcnG61IgWvm+TxtdhQuRKXJ5AOLpPcS?=
 =?us-ascii?Q?bI65wQ09d0xaF0Xi7rIQ1od+JmVo+vp1lFyKoEKkTVc10gBey2diBHonxeF0?=
 =?us-ascii?Q?GK8blL2SbBEImWQf63VWQr5QyLLBQfTOGXGn/T+RCHCT0HN5aO5dMCBnNAcg?=
 =?us-ascii?Q?iMRKdksf09HiWf5GR9rMjf+85ehJLFKAT2CClDx3sHw1/TKoyykE1R4fEthV?=
 =?us-ascii?Q?C9DJsCy4RYDPsgOLnKR4EJPfktk2C3j4cP1q1PD3FCrNpBFc5MMk72WLtBfq?=
 =?us-ascii?Q?bCA2f5gA1F1bvt0HaBPNBaGAzGtlwQTNMOgrdnOuG7wUjpeOQ2RpkityZ0Yr?=
 =?us-ascii?Q?2k5gcDp2uj3MTBOwJarQvfWiXEqYIq4V1sxJMUoLM2fVYzYWY/Y3ZKbU9H8W?=
 =?us-ascii?Q?CeElgP1KcbQATk6JKEzw9SInUj7cJxXR5A9gRHRN5QfdAVnD76nQVYirLCD3?=
 =?us-ascii?Q?v9f5gKImAt6oINWD3qCQIwyQQJe2v1c0XQRttppn1QsyyKVo9nQj1phPbL+b?=
 =?us-ascii?Q?WpQfIGx2b0ExvbzNA2ttChMpieqn+Crvi6+Ffs/SF25tDGIrMo2xks6EboLx?=
 =?us-ascii?Q?FPtuQnSBaqI2oIlYSn+p4sHRshoWrCTGcYfgaJ7zs/5bOIuR8AJ4+2UnPzha?=
 =?us-ascii?Q?VPjvWqDVySgDXMz8yTA6vcFuqJc2QbHZmqYTNRHMVaYapCJFo32TEoaQLXvP?=
 =?us-ascii?Q?q7w/wbbZKwvLHxDwasmtsbanSzh/dbQk+0I0PmIIpbG6+J6wKHeRlA5ggg1F?=
 =?us-ascii?Q?hW/vY4QGnRG10+lZ9w9r6A9bSWAVai0SCVOdAu+3suN+DYBO/0zwszCmGgTn?=
 =?us-ascii?Q?OlO1BpzZLm6v9Gx9ZbuCuf8Eb2fQUs473H0NLR4Pmvlk7X1cJXslLxLOMJur?=
 =?us-ascii?Q?Rrv+uUIRezjxkO++lTmEpsVtvrIpqEDsjQDAA/CcpXFuOuBJ8RESPttwSrVh?=
 =?us-ascii?Q?+n2oSNeJOkR8Bl4A4BqdBj2Td8WjzwQZGuhnWWaAC0duh9H1+k3fCkVw7TXl?=
 =?us-ascii?Q?7eU5UP6n6U/em1hIHgC73tizaYhPgvGfjA4BodGWHjIKrn0/x4Q1RT11jLmO?=
 =?us-ascii?Q?m3NXkoNPMBv+UfP8Hda/FJzNgQtT84Eje/C7gQhXTxzzsRL/opP8YMLO/YYP?=
 =?us-ascii?Q?9QBway/9FnYAz/tv3sPDQ98Zdh3bUdE6Uq4sNGmEWrzSzS+c2FOtKt0WkUyk?=
 =?us-ascii?Q?3qV4Crlmf8trFk2IZSgC8bjialPFmVlkpHHozaphSGY+ISQpSvdcTAG5x9gn?=
 =?us-ascii?Q?BMdcDvm/cGX4gDcvglzFR00fGJv7rhegSatbRhrK0qFYrHr3EMOh8MYFITPl?=
 =?us-ascii?Q?QLaRQVYE5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6a90e7-bf7d-4bfb-061d-08dee2b39704
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:49.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6OUODnlPqlNb1iAK/84Fus6bZqC34JH75KIXwDlwVVjB0WzJVOBJnQxSNlg1JXdBr9JHLR9wvANpbk2hIEFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

With proxy-exec, pick_next_task() can return a task with p->is_blocked
set (a proxy donor). put_prev_set_next_task() then calls
set_next_task_scx() on this "ghost" task even though the task only
provides scheduling context and never actually runs.

Calling ops.running() for such a donor produces a spurious running
event. Simply suppressing ops.running() is not sufficient because the
following put_prev_task_scx() would still invoke ops.stopping(),
resulting in an unpaired stopping event.

Introduce SCX_TASK_RUN_TRACKED to track whether a task entered an
ops.running()/stopping() session. Set and clear the flag independently
of ops.running() and ops.stopping(), as the callbacks are independently
optional. Invoke ops.running() only for non-blocked tasks and invoke
ops.stopping() only after entering a tracked session. This keeps the
callbacks paired for proxy donors while preserving stopping
notifications for schedulers which only implement ops.stopping().

This is a preparatory change for enabling proxy execution together with
sched_ext. The explicit running-state tracking is also required by later
donor-based accounting: it prevents an EXT owner executing for a non-EXT
donor from being treated as the active EXT scheduling context when it is
dequeued.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext/ext.c    | 33 +++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 803da0f1e5092..5da12d6562b8e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -103,6 +103,8 @@ enum scx_ent_flags {
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
+	SCX_TASK_RUN_TRACKED	= 1 << 6, /* task is in an ops.running()/stopping() session */
+
 	/*
 	 * Bits 8 to 10 are used to carry task state:
 	 *
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2035b71671a75..9836667356c89 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2208,9 +2208,13 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
-	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
-		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+	if (task_current(rq, p) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping)) {
+			update_curr_scx(rq);
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
+		}
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
@@ -2912,9 +2916,17 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
-	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, running, rq, p);
+	/*
+	 * See dequeue_task_scx() for why we skip when !QUEUED. A blocked proxy
+	 * donor is also skipped because it provides scheduling context but never
+	 * runs itself.
+	 */
+	if ((p->scx.flags & SCX_TASK_QUEUED) && !p->is_blocked) {
+		if (SCX_HAS_OP(sch, running))
+			SCX_CALL_OP_TASK(sch, running, rq, p);
+
+		p->scx.flags |= SCX_TASK_RUN_TRACKED;
+	}
 
 	clr_task_runnable(p, true);
 
@@ -3020,8 +3032,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
-	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+	if ((p->scx.flags & SCX_TASK_QUEUED) &&
+	    (p->scx.flags & SCX_TASK_RUN_TRACKED)) {
+		if (SCX_HAS_OP(sch, stopping))
+			SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
+
+		p->scx.flags &= ~SCX_TASK_RUN_TRACKED;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
-- 
2.55.0

