Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB242467E
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208210; cv=fail; b=gSMIcj4QVzRNH049tEFTGCBjXHbEizyDq4UhHE25KXICiaNMqUXJ1YnItbW85cIIVRVeExYAkoMYV0JJqDUF4Jf5lJuVnGO/+gPz7eDBq+MpE9QNj7WjWaZjpEwZqwuGnKbhiVl9BQOAcE8CAasYH7rDXdjR9rfJdk8Sez0M3qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208210; c=relaxed/simple;
	bh=YP04/xgc+EocGBS1JWBO1Af6XprIq6OhgKUZw27pnnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epQSZtjRHwar9k1v5xOou5dPAVWxy8PQnWs+4ve8HFYhUwoph3ZLTQjRWSz4+oysejvKzb1XBsYe2ae81Y8zKD3cMFTWP3sp39jIUicQ8XToL4eYvmKNAnnAez0XhLPyQyNFq+WxtArnxbkcjkGR8iRsLo84raFAsPRD+NQ0Y84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cEH6lWii; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEH6lWii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2SoyCS66FRNj3UNmOqgvfgUHBbSxqGD2kLeGkjsfALdu/9+zCGuTtfJYMBGAMQQWP5CgcoGbR6ZxleB308t0+y3Ze1XRUNaMDnmkm1r3Vow0Qxkw5GjS6rjpFpqMZIJ3CP1r5S0O+hCZkIIWghaLTXGkNHdAiP01hTXsKcQS0WA7j1XEXCMsNIG4XsX98N4hsD7hVmVP8JxtQw2cFXg9cGx/dRLMuv7VszVmHKn5ylpxJFhIf/SGJHXWs/ahQ5DwFyfeCWWUTV5lHgXGzFFirqWIc6dojoFP8P5TgHs/mE2XjNDjfN/j0V106eXohrMs2CQ5Hj7QavAa4OUJ3B2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl5ppXGLUYEi7so9eLwA3B5ELzmRyV4eI8kX9WmueGM=;
 b=eoT/5V9QKPMgQpQGJUkyLO4xfzQM7x+azdUcvVwvIEyZif1ZLL2n+RkbrfV6w4h7g3HOuU1POJR8zyIfSxDAgkaSalQsO5kfnpXSyvqMTZak3W1+pCEma7QJ2L+vWv3OiAiPn7FDOtaOL2Fgdfsk/+pWuK2eGrv6GO8L9cadmPPkN5Qhq/tR3klLl4WaFuWUJChB3yPqkIo+eRfSH6cLSEAMTxWIk4MSVoGHngSU7Y8Sw+HRvCS5fkoeatc1gDcmZaXM7dwCIOFdBwD5gNgspYNAHklHY38O/I8cu1vLwubVM/DH9gYvaqGJcc3hMAsTktunAxY9Dw7uWuWiHOmgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl5ppXGLUYEi7so9eLwA3B5ELzmRyV4eI8kX9WmueGM=;
 b=cEH6lWiiILQI9+1JszHLPoNL9/l6vzcE92ef0iB3NWU+FRI2dGlGFJoNgAVuz1lJC3PfncmgIu1timKEkFvQv3SZ/oE8oj3XNGT3NVLWNKwUUiMj44bwHwewOubA/n+ZvKugv1CI7+0LNW73Yy1DQnNyjzKjfFKJaLLluVJTPlF49nPOqtYHzmZZE4i95wSA83K4cVcQesYVqOsq/b+Sl+4rlFbM/+6uvOYkZjF65/r0vvM9qqrhTqiVfb7f+a206wW7RFLYt0l/tsC22R2vRrUhnXdtsPFfsYLuipnsru0md++5zjXuJ+/Pzy0K8VDoGoc0YPlx4QU5aT9LC5axPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:23:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:23:22 +0000
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
Subject: [PATCH 06/11] sched_ext: Split curr|donor references properly
Date: Thu, 16 Jul 2026 15:20:41 +0200
Message-ID: <20260716132229.61603-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132229.61603-1-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce3316c-0ef6-4d16-f4be-08dee33d686e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IHIR3BKTmeNLiw2hrrGnV6rGKNbn0bX/P6jQG6xIWbwQC3kENPXGZFeSdnmNalNj2RxrApzsHE2M26d1RDoMB6JHTDzY1THmnX/S41fhp95e59dI3lxVJOJbPxh/Hw11FMYkwm6TG8fhjf3aDFJy5B2KSlel8nkNP+s5fBnY76xNom15/5wI8dBOHpxItC85bQjc9tNGv81nJshdDqOuxlR/qmqTQJMrxcxih9MK3nmquE+uG3RX07Yy3p2VzzqYq2qZe/5z3I/duzGw+bXg7rU96gZRKS3srAEX4tuwdjJLHOeHecRsmGCKKoieHVz8atK4vLsltQf0lkMzGXrXbqkza/qvF7Tribmv2ZapGpB1v7yuhYa3KScE4UQaJ3PcgZHJmGJZcYPBfdJeinU2Gs4iTNl8CfcEOSCLvAnfkJ0MMkin6Nx3DXVDLANBKzaxJzqrdeETDDniUrnRlXnIwrb58EYeOKMMCJ7GlDs4sFNIpxRHUN0T7bHHNgprk945HDxhJrJNYAdiJGLOKYf5/8/XG/8Av7/ak2izzhVBM+q2W3FG1M70dVrf6TrihLgGHeyNh5XtZizkXp4wv9BFKSykPdEnMjI7G40IXjHBNWNc3Pqkd4ppSVWmFzjIyjTfmy0gt+qsRZjXpF2AjmonDtZ9/KSEGWisRLN0/EOQXHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iu4m83ienhbnOchj8/+s7Ec/xAJ8Ed1fBv9SlQDeyk3QPpRvYepCphMLmpAW?=
 =?us-ascii?Q?W4+v/kpOy1qw52eSyZxLoWyRFUardIbTefSbbOhGQ1MXa/SK05M0jJoXp99u?=
 =?us-ascii?Q?bdIk2cpChjgiqhbbvtQikGBZPcwQ+dkc7ywWbCLg+dnHbybcJCfWIAPAn1SU?=
 =?us-ascii?Q?GFm62sHsD5reVrzIK69e825AXPs/pCSp8uazlqS2PAIt2rzL4xZaKrGTHRPY?=
 =?us-ascii?Q?IwKUqDfdFUYM8hjithFwc3X+8Qs0cODEJbDwQL7HE5uHUa7cfr/fmLr6dhIB?=
 =?us-ascii?Q?/a6jRe0w8dwFoA+mhAWCCLKYUqNOAOfLR4tBcF5p9HvitxB1F4mK6O5/JuSR?=
 =?us-ascii?Q?6C/C0MX5vdveOVeP+VMMyg/pGRVaYcoyr/WKw7iCRk1M67VDTHPYi46MkQed?=
 =?us-ascii?Q?r8d64d8zP5OXHIM5oUfNz2iE+IqDlSGWMSKHLLJSelt6YhH/PTJZFKJlsV+L?=
 =?us-ascii?Q?FKJUR3PKLiKjnVY9rBqUkRw7SAjn43BowejyXmnAHbaIVEy6Dje4+KIu2ONl?=
 =?us-ascii?Q?PND5gHmXlxwz5CqaskzfuO0fHd5ZluGW/R3RXe+Q1927uEo3TNNs9xtu8CWZ?=
 =?us-ascii?Q?8s0QrKh3vLigNpRgL0B549PSlT/fXiiVyesiB/VlllQDCP2+Dd4PcxGi4K53?=
 =?us-ascii?Q?lY+e4unoMxpobjlN3RR3JCkK/M2myfQxUnuSQIEbrLv4XG+LU9wwLHqptMHl?=
 =?us-ascii?Q?f926gqnPNSFU+WZhu/DYRlEO7+L7F5MCmu/4T0n0YE4wvR5AFTsmNJ53J4Yv?=
 =?us-ascii?Q?kNFOY++7AnsZx3PcQJEQS63cn2+dn/UTaymZmfrk0dwmUXpCNAq7C4Hidahr?=
 =?us-ascii?Q?x3BIRQbGFHXxk9PWcGanSfw4ExiR68pECXTxEpKsucKx65zezvvIZMGrDk5d?=
 =?us-ascii?Q?58TCgI13knR5gK76hAhiDtzwb0X3h71yZPXggfBio3vVt2k+hISybmi1gfEE?=
 =?us-ascii?Q?BtzpWXFo8l8sIcuHMMbFfxfVn8ZtLvC/5mtwJjlS2zyCDY/RsDQhfUK/64iu?=
 =?us-ascii?Q?C9ku8RuncVN84wWD1DC2RWYmif23SEK7dbLUiGtNhQG4YPq/XrJqLXUIiKbD?=
 =?us-ascii?Q?rCfsb9u0sbr4lwRwQJaT5KQuAyPk7pnhw1K3hNSUjM1gO6T1XMHf8U6+9jwQ?=
 =?us-ascii?Q?Hjog4NyYBXXGLfgIMuVlOyoUwZcpjw40ZuyGXRQHu14DZyRxMeHX5Py8tA2I?=
 =?us-ascii?Q?aRExwtc2ppENy6TJoysBKjWY3pS4Xg5JkGYS3KNcH/bV4C7hbRvXhVMaZhgo?=
 =?us-ascii?Q?mclj6+Bx3JcwLqIBuKiTff6GwN57bMy1tJz9baMarqRb3h/mk4GwByfcA43d?=
 =?us-ascii?Q?6tNQ3u6vAWuVq/feA+Kg6CAysQQz3ptOycV6MA+ujoYEsxuM46wdoi6BcR9i?=
 =?us-ascii?Q?xf2vmYb3UuROznwP39t3x1M9Txo2kFY29fjBjyqiOTG1/PQd01T3NZDj+VdP?=
 =?us-ascii?Q?c1HKg+jZ6r/Ix6pRi1rdQUdtCDkOsw2ZrDas55zDM2O5J+Awg9lHO95l7qRm?=
 =?us-ascii?Q?Uj2nPAucQItZiLPO+HRzm2zjlOcj18xyKTRX2L84VJk5q2A4fgZiUFsZFLZs?=
 =?us-ascii?Q?6+1SQAB2bl3ntr0NaH0LzINVoIE9JAXE/ocTFAYYKe81QjgYxA7kGjK6EJLM?=
 =?us-ascii?Q?NXCvnrhcCdtTpbubJU3voYqnTqJeRTjKY5u5+gIzqTOoYdj2+/U7kNTCm1Il?=
 =?us-ascii?Q?MoBOvBfpAhlypnJOsovSTdud9xRtXKu7GOrfLEUTngQQdBrULsLOZMNz+2+N?=
 =?us-ascii?Q?Jx3Gi1cAJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce3316c-0ef6-4d16-f4be-08dee33d686e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:23:22.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbVkB8LKTpbYWPxjWS5t9BCZC3Hj6Gqhi3XvwDYC7HaPqQzjcEFMvkTrDvEvOuG8pjHS4K03jjDQn/nt6vm+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD

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
 kernel/sched/ext/ext.c | 93 +++++++++++++++++++++++++++---------------
 kernel/sched/ext/sub.h |  8 ++--
 2 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 08773f0aca5a6..c924af485224f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1333,20 +1333,27 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 
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
@@ -2732,7 +2739,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2943,6 +2951,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2971,6 +2980,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* apply any pending out-of-band slice request before the tick decision */
 	apply_task_slice_oob(rq, p);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -2981,7 +2991,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -3002,7 +3012,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -3177,7 +3188,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -3537,9 +3548,9 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct scx_sched *sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3548,13 +3559,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
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
 
@@ -4165,16 +4176,16 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -4360,14 +4371,14 @@ static void run_deferred(struct rq *rq)
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
 	/*
-	 * @rq->curr may still reference an outgoing EXT task after it has been
+	 * @rq->donor may still reference an outgoing EXT task after it has been
 	 * dequeued. If no EXT tasks are accounted on @rq, ignore its stale
 	 * slice state. If another task is dispatched from a DSQ,
 	 * set_next_task_scx() will update the dependency for the incoming task.
@@ -4381,7 +4392,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6480,6 +6492,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(pcpu->cpus_to_kick));
@@ -6523,6 +6538,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -8035,7 +8054,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8052,7 +8071,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					set_task_slice(rq->donor, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
@@ -9864,12 +9883,16 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 }
 
 /**
- * scx_bpf_task_running - Is task currently running?
+ * scx_bpf_task_running - Is task the current scheduling context?
  * @p: task of interest
+ *
+ * Under proxy execution, this reports the donor rather than the task whose
+ * code is physically executing. ops.running() continues to report when the
+ * task itself starts executing.
  */
 __bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
 {
-	return task_rq(p)->curr == p;
+	return rcu_access_pointer(task_rq(p)->donor) == p;
 }
 
 /**
@@ -9926,10 +9949,14 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux)
 }
 
 /**
- * scx_bpf_cpu_curr - Return remote CPU's curr task
+ * scx_bpf_cpu_curr - Return remote CPU's current scheduling context
  * @cpu: CPU of interest
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
+ * Under proxy execution, this returns the donor, which supplies the scheduling
+ * policy and runtime budget, rather than the task whose code is physically
+ * executing. ops.running() continues to report physical task execution.
+ *
  * Callers must hold RCU read lock (KF_RCU).
  */
 __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_aux *aux)
@@ -9945,7 +9972,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
@@ -9969,7 +9996,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cid_curr(s32 cid, const struct bpf_prog_
 	cpu = scx_cid_to_cpu(sch, cid);
 	if (cpu < 0)
 		return NULL;
-	return rcu_dereference(cpu_rq(cpu)->curr);
+	return rcu_dereference(cpu_rq(cpu)->donor);
 }
 
 /**
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 625d7ce334aa8..a164e6b2f2562 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -141,14 +141,14 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
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

