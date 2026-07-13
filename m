Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EC409624
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959721; cv=fail; b=sft+NHAsHLwMcF+7s0DMOt8WkMUe8cGhSrzjxdvAKA8mGLHDjUjmnRhvuLA/mm3Qwp63+nn7TnmqFLbydSLvNPcIs5k83flUkY5YLjjlw/11UHWVxvmJG2ElgRR49K55KnHtodohy4FMC9eqZe8cz5qQhTrmnRQwDxEt9Drunqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959721; c=relaxed/simple;
	bh=Wt4tsw534GtY7xesuYwbPZE399OODMSLYdFdLh4J6+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZpr84Z/O70HpcdugsnWk0ylAmqTpm6OJngYgnpgiMwA8Tg18crtZ9Kagq7RczyBOcIgKAiIFAEcRkisAyPHJ+LZ/od39qtS9HhT6LcXgwf6z7/AE+d2ovdPev7782UN2DwjCj64OrEIUY4hdiOF24cRB/9bGxHhnz99UGZ1BbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZazR9QZ+; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZazR9QZ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO8E6U2H+k1CyIthPUVMGGvdFSMu+k2rs2eNmvdviy5llZDr4vSwBbGpXsluOxIzgtCFfAv1rrg/walk1w70kQA/hU8CV/zY5IhU+/aVSpXQVPaDmnpNu+YAlSoh6SbPaGL4zOn1vRIwhdB9il4pA3mqpMKD7aHi3TJo/iLypPsysWR2mTyTg8iWvsNVHlF6X7zwezVwdBZYRMMV2guKbu1rS5NXOeCNo1n5x+8ftM7YoSNg1EnrEauckpin0z8rKFiwrj+JnDRiFjUcHCr/gYYv9AtMz2NUpyfV4M9x37C9poAufH3Se3+cWlbufXfM/Rd7zESksHcrAsMWFhVLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDeG04Rt71FnNhxc/MZAUaiW8BtsggJED84hI9myd9Y=;
 b=V1J3HGa0/cWGN7JsmZ82eOom1yPGs5+7AxW8fzD3Fp32rIoXVgcKdeVKo0YDsrs2pY/dZjzDExMHoI5YTIPqacHfypQY3T1gcJK2pdPAYsvULuvGEvBwyt2CYEztIScyI8B2evUz6qmDp4lntKL/sgZUj5qApQnaZ16umh8SsVUYLoCJOuDAYWZsnXofilxFnBkgUYWGB8xumgZRiqkSeJo2srl77sBOk98ksg7GUt7t/uWEdx8KmcZiBl4O/rgYtzCd3yapHdIKXKMIEgLv7BUBrvMzbaFMl3Xz4PtvdTgkntjAOBcbZJodslzX99MBsAs5UahxwoeDaJMRpVwwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDeG04Rt71FnNhxc/MZAUaiW8BtsggJED84hI9myd9Y=;
 b=ZazR9QZ+VDv4ZjmbEDxNHTR3LhrycqZfyBjn3Q6anM1XgBM+HuC+c8MIsFrWjJj0cvh9CTYX1wtNhzHYLel9zO+Tn1sxiBsjJB0NeI6vilnz7t1iDVlzoExB+lGwrQSgTDCGQW6TqMrJyFLggDHnFMwf6EKIUQwYTtSIDUW4VpSHcwTZ76n/mCBWUs1AxVWusx7F0//9GBm7oMddD+et2W/9joJYQNpYHE2xBBVx+hNUZeA0LH/bTdQkxJG2ULBjRjTRpdwJPGN0ee3LMWag0vUb/vv6j4oL22laDS6W7RXYML6bhmLbU0dSRnWKOReWhxakqoVI3jEOiFSq2Y6zBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 13 Jul
 2026 16:21:51 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:21:51 +0000
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
Subject: [PATCH 04/10] sched_ext: Split curr|donor references properly
Date: Mon, 13 Jul 2026 18:17:04 +0200
Message-ID: <20260713162112.26785-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713162112.26785-1-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: b97fcd35-fd1a-4d9d-aa4b-08dee0fad828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	pKUqYfbqiEC7numIYEKz62XJXabPcbzMY7jf8rPQBhZESzIJUr6TZzQYmMKDlS1eKHZ+J4KAUtgEUib0dRtS2Gd94DWPs8YuGItq3h4Q/3STpnaB/H589Q72lerJ58iLPKlNpGYnyyDYtSxvRpSiCv/NjAyYQgQ5hFZ4zLbcM1YVFV+BaO/5vYYfGCEmre2T2LLli2iJtuZC7mXzUT96DjrfLLqgiojo63Ck2hx+vWuREays4Rj7uzMl1qbzFnFAOcsGE6QXs6/GP68fnLWfGr2gI+p0Nm0AkvCWSp1FpvT2yt2j4ovHKk7VoGynT/qQK6b/Xx8qb+e5uNGP3YXoCJVyOWSu0Vp4CG8pN7XU5m9R3rSs3uKeZ8tSG6UnyCibwzbDfVpW47YN5ruvrIQTlLJ9xS1NzJDasyRUNuRe1JZgkVKYsHLjfRsqHUl1EytJFMhxhCHfpfW3aI/WSykVfF/MoxqhinK2qejhp2nHSNByyMLA/2HA6m2xADDC3u9pCFLSRzuPPYXfpEp7RMC5V9LC6YQIwF6CO6Bxctfccr/H11jhJ0JjTKDlM3mtmZD+tR+bA5vFZ66MbgQuIwaI3hOq90vdRc5717lZ4WHTYwVvo/99COSZqDy3vQMsxacJSWkukKMFoF8SRsOJSrMCYUQMhsxC8U+87KqWffFtUms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6w8ZFbUSJjmzFyjIsRaC2BuUyUukV/AiBXWjhayjNyQrRbAAu5O4mv6HO+H?=
 =?us-ascii?Q?+/vhsTglWGcSbcJbA7U2nXqkENDd8fAjkn812NE1B1o2qc+o7lUv0VGevDMz?=
 =?us-ascii?Q?CcGX+N53LAqg/fjMtgt79FUuzXsHFW1LAsAG4GHSDsdb2TsoGzkNYpTc9Oee?=
 =?us-ascii?Q?LocwVDOSRhaFHwNDUawffWFqcbUhawm+klGoxXUsOjXN2qDc9gJSO+xb5FkX?=
 =?us-ascii?Q?Q1c5iwBTgL08u50NwcGjHR04pH8Kld4VQB6OUWDTtdMSUO6JOho0kDaLq+3F?=
 =?us-ascii?Q?XiCcGQV4CQYeZhBY59HAwGocrU/5TdDTL5wI4JJCt6F1/AO76aWFAVxdbuwX?=
 =?us-ascii?Q?ijVYI2Xw6XBNHDpJP+IuGGqp8yC716GwQA06+XtO5JUmdEUGXKdtrHLKn2iC?=
 =?us-ascii?Q?Z5VZ00oYEO7kYdpr4KP9ffoDg61KRSRhSEbJJ2OLwFx0fhl3A57eSfHfA1Mp?=
 =?us-ascii?Q?8are9KEPaR+57NmwS+5XZ/1IxVImXlzzTzXlIVGsMhjUAU+/6Z1r4nhVd+Wo?=
 =?us-ascii?Q?gQoINfNAsRtfjjltc7IhxyE9zE/JjyC0hXSDylwOe7CUQwI7UhmoA41j1hBT?=
 =?us-ascii?Q?PetSinVTOSo+RezyGg7wrSqV2129Ijr03ohWyZT03F0IVVuCnRrUl5SZGxnV?=
 =?us-ascii?Q?mv/M/re7NUN3hMC+sVZocpn8YVIsOQFVD8tz0ZU/hWTz3cJow6lTAy7upsPl?=
 =?us-ascii?Q?e+C6qx8zqVHeluNPMw1ATe8ZZqG1M8I8vpxxYuqiAqw57a5XwX0xE2vwvzJs?=
 =?us-ascii?Q?OZNqvLNPCnwiBxoSA17Ql7OGhNJoHYU1ANpYrZS68AFTxQHhG7l0rA6z4LoE?=
 =?us-ascii?Q?+vkSox7uv2eNPnkgClTDMl1MnbfIyBaudZYAKDToQzD3ZgMyCtGdBzZbCOvP?=
 =?us-ascii?Q?TUUtisKtContP3AiyOrDTLMVBVgnoKWxHxuqAjOZSejk6/t1lWSWMkY3J1tg?=
 =?us-ascii?Q?MGWOkWxNU69fV94rxCYwRXLiS5gMKRc2r3CLFmaKMZ6CkmGyofnh7Vk1LYpu?=
 =?us-ascii?Q?Slv0JRb0nmFca/IBDrZy2Za8Gp7frmnsHx35jYhp9PUvAvPPPslziAPpBiRX?=
 =?us-ascii?Q?416xE7jdzmSTp8hH2Ilukq7ZYMgT6b9KyVuDpebUFVSl1mELLvQdylIJIA0h?=
 =?us-ascii?Q?ekohAYuvztcMGPg9hUePkclU1hNMI6jK8/nprDiAANZxpLxRhd5yu1/HnxnS?=
 =?us-ascii?Q?uVNX6DwFTPfOdbbV4DwWzXDu7XZipQFYSVKwkv5vJXSSa/eH5SgERxmQCUmv?=
 =?us-ascii?Q?Ib++kc+DH4mrQz5/Xcx0gq6jkO7+m17lEiOctBU3Eu1cL3BL6Ed0t2VPq+h4?=
 =?us-ascii?Q?lBn6/Qwq2AEKVWV79qLDqYkUzV4ygxeGa0Gr6Qln/PUQhrdP8iWBgzWb0GEn?=
 =?us-ascii?Q?dQw+cgVpN/NoVDynlg1eObMrZej8MIi/uLFU/9UFZvQQBf3xWqzif6ztTcUv?=
 =?us-ascii?Q?pwL4uf7SJvF3s3MfcKUTtxG9Ihglh89od5w0X3c9pUvaHJAOV9z25VD4nO6z?=
 =?us-ascii?Q?p/iV94z/sGJsmXzQV3YRRW4GsyH1N/nd/KD+4/jIoBsONLwvT9aMHco00ttW?=
 =?us-ascii?Q?170OQM46ogEsJIapDamK6mJOEu/FYr+uD/dY0XZH+Il1IDGsk+1HvdSpeAaL?=
 =?us-ascii?Q?LVI6ik4rNbfKur4V2X+w12ljTtXddJJ2iKfoWz7xa9M7ddwXSdlUU/owFeDy?=
 =?us-ascii?Q?f+DjT0qG7o1vzLl9w6D85ggmQqDGICYlXyt8ba779rYys0e2aS+PK1uXrd5m?=
 =?us-ascii?Q?FFvApDutkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97fcd35-fd1a-4d9d-aa4b-08dee0fad828
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:21:50.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mD3k2Irf9ryqpRnpvftx8OsQlgmPHRauu64BuuSwJptl+Q0Gg2S0HY+gX+w+41gJFc/Mnv+wQFsUxEUvrSsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

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
 kernel/sched/ext/ext.c | 53 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2bd7d6efa1f2f..26bd247f4f29c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1170,17 +1170,24 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 
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
@@ -1341,9 +1348,9 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
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
@@ -2491,7 +2498,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class,
+						      dst_rq->donor->sched_class))
 			resched_curr(dst_rq);
 	}
 
@@ -2699,6 +2707,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
+	bool can_stop_tick;
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2724,6 +2733,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	clr_task_runnable(p, true);
+	can_stop_tick = p->scx.slice == SCX_SLICE_INF && !p->is_blocked;
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
@@ -2734,7 +2744,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 * nohz. In the future, we might want to add a mechanism to update
 	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if (p->scx.slice == SCX_SLICE_INF) {
+	if (can_stop_tick) {
 		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
 			/*
 			 * Bypass mode always assigns finite slices, so @p
@@ -2755,7 +2765,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 		/*
 		 * @rq still references the outgoing scheduling context. A finite
-		 * slice is sufficient by itself to require the tick.
+		 * slice or a blocked proxy donor is sufficient by itself to require
+		 * the tick.
 		 */
 		if (tick_nohz_full_cpu(cpu_of(rq)))
 			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
@@ -2928,7 +2939,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
-	struct task_struct *prev = rq->curr;
+	struct task_struct *prev = rq->donor;
 	bool keep_prev;
 	struct task_struct *p;
 
@@ -4081,14 +4092,14 @@ static void run_deferred(struct rq *rq)
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
@@ -4102,7 +4113,8 @@ bool scx_can_stop_tick(struct rq *rq)
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
-	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 * iff set_next_task_scx() determined that the selected scheduling context
+	 * can run tickless.
 	 */
 	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
 }
@@ -6070,6 +6082,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
+	dump_line(&ns, "          donor=%s[%d] class=%ps",
+		  rq->donor->comm, rq->donor->pid,
+		  rq->donor->sched_class);
 	if (!cpumask_empty(rq->scx.cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
 			  cpumask_pr_args(rq->scx.cpus_to_kick));
@@ -6113,6 +6128,10 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (rq->curr->sched_class == &ext_sched_class &&
 	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
 		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');
+	if (rq->donor != rq->curr &&
+	    rq->donor->sched_class == &ext_sched_class &&
+	    (dump_all_tasks || scx_task_on_sched(sch, rq->donor)))
+		scx_dump_task(sch, s, dctx, rq, rq->donor, ' ');
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 		if (dump_all_tasks || scx_task_on_sched(sch, p))
@@ -7541,7 +7560,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	cur_class = rq->curr->sched_class;
+	cur_class = rq->donor->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -7553,7 +7572,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
-				rq->curr->scx.slice = 0;
+				rq->donor->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
 
-- 
2.55.0

