Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A54353EF7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901880; cv=fail; b=ZZz+YU/ccEVRAt20bdODSGA101IGx7gFAhk8AwnvSRoQW7YwS6/Iqj37Zl731aE9f8IUO5lu0d/aO+sz7iGccacpCQrVCxe2kFi//4MK4+i0Y95tKJvTJ1bSFax8hOn684cmKYrGO0czQlrrm0bcggohQfqFQ0ByJz8VV3Mp60o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901880; c=relaxed/simple;
	bh=8dygY21XznRfxtRZBmQqkehzGxuKV0Toe3IiER6yzyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giogACxHjhXygI/wZ8sYrkrtMhAftTOS7V1mWKeO5oABiPAZG0KoVUtOvNfMJ7N9d3pZedi9LGhbla/Q+z7oUD0yd9lwqsMr29wVjGtYvfOnLv+CumocrRawlTWA8sLA3jic7AXgpa2/UzN866EVeOAnH9B5Mm6BSwXpG6fyICw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GX5QFtYL; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GX5QFtYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRhVCvbOsDpG2t7gglU9PhF3t8a3q7XbA1/I6hgV00tsuV5yWgF23nPuIQh7g5RvSPOPZ9TMwnQAlFLV7i16vsRVOktjqtl3KmDmAJoHG0UiVWOH1BXpDy8Jxtrg7Wmk6wAbS3knHymztBIJexjj2vQERM22/t7uIuw4cWsMogq3Zhdx3uUA77GtKVBWnNh3rm+46QG4JyAscnLDtdJQ/PkdsbYB7Z7L+oywnGlfUtrWklwvPL8A6cCRVOSKpJg7UrNqBug1VMQpgumid0B5Ylw87HLtr1yo4OfoQDQeDeaumREYWHMaJHeRMKFzWvuU9qzLbyAz7mAPx/+JSATyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHmGcrbI8U/LXVJZqhWhBeErEx7+uiBjV5IgRS2JQV8=;
 b=EAn2uP03+mGDVdGSENyMaOfDp3i8Koz5TgWGhNtdQPSYX0p/otfS4xj05Wx2aorhlkH/67vkoMiHQBmYQFMAMeP+FvOgTMu878I0IuszlKIRLP2nvAmJKJplvfGF9b+V4cBQ6LQVrLGCerGGLzYQ4Mi+fHJVFvJie947UzzFo7wu2pr5HazpZ9xP01IZJZ/TEQdqURbQ4USihq/EeNY5GtiIOd4yXGrurFqFYZImJ78y6VReCXj30E9tQM3Y/Zp5n9yDfto/FidqowUW/1xhNqHjwYuF+URdkAhs/tiFBAhXhZuhm0ETBjsjsjvjygFCCTJWS2+TZ4e6ECpT/4QIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHmGcrbI8U/LXVJZqhWhBeErEx7+uiBjV5IgRS2JQV8=;
 b=GX5QFtYLaQLFUFZMZAiWxg869roIyBvIdZAfc7H658AwRl6itcQmlPtsuMnOOQ/jlOiwuN1czoc+yHy+RdqGcBb9F6mpepfzBAB/YtoKoJpPw7wjMywUZ7nomHBR06TeN+fkoACEHR8tWS8K/oJV0yjWY0f2YjH1KJO71JbfXz/EgzgfWXAFEXfBRxwvTcmTO42nwcsfm2WGm5ikeXhFBuV3M9kGF77Ypi/gknu7sy2ggH+CIrK1rssEUIx0/BHq7ZPjHxQGXZamrMQtW5AAFJYG3reVqzuilwfBPH63CrJY4un8M1BNUXSLcbkCJxSaFn4cZrXIelGOBmtvbntggQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:56 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] sched/core: Avoid false migration warning for proxy donors
Date: Sun, 16 Aug 2026 19:35:02 +0200
Message-ID: <20260816173732.17162-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e880d82-cfca-4589-723b-08defbbd1b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	mTWYYh4wW5NYX5Ecd5InRTSyOxyNGNxTAslHARtM5QYVyoVcyNZLBT78Eq++tzcOQuf0ZgVt0dOcTHjlO4nFRCOdBG8WrAa8YF0iTZTUHrlVo05yus8ViGYwlU0R4BdcFgscK7w4ua2IuNJ0PDKYQMUX0/riMe/qep4u92B/eW38lRGeiK+9whJoZtco4NVrtzJvAB1CNJ75nxWGeZZSHUbHpRrog1HqB9R2T30aTrRZ3HPdtY6GhfHaeeRdtJx4iGzUYKc7rL8k2W8/4dP9DhIgnl9W2dxsnN5EZjt1ryF1m1fcYpIunH4p/OzHwp75pDgvdqDM1X6eGHQ6yHNRwmVYVFw7XudnKrnot38GrSf8uAPCSLKYqbnFvolxKOUt2SypuDw5h8qwz4TFCEdKyT88wXJ3x96RS43NhWViC270G1iIk/HdoHazfHDcnlMO+pu8cK9kqkIl+fRda/egVr+sodm0j8lOu7bRdL+/yu7zTNjqeFVH7KXPiUWwMxXfYAmyzj47Foj1X7eniwmF021deOx5WhD2h/xklb8VxTtwz77kOu6wLgho4HVCWarcjBie8+MudyYBeA/jMQvQ0zCOqXtnE8NCWiHGw2zwNRQab2pCVrY9vl0ggW/CqGcJVSunAD7jxx1bYuR29IK6fvs0MnP6ktjqzgI9YedkFUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Llnd3+pKF7B0SUg1D+muhCfW+ig31/bgRyp6VU3DEPIT4fMxFlu0I/ZjN8Nr?=
 =?us-ascii?Q?NV+Fan1tGAYE0Rye+/nArWFNlszPc8TGNsdPPzoMUGH5+UPdDZDZkEq3EqjL?=
 =?us-ascii?Q?u0t2mAg7FkWnHE8Z+CiQZUgxWKOPFwNVcPPxSmQzQh85YQs56M2h4NlqHTcy?=
 =?us-ascii?Q?Aw2Rv3S9g8abs+M0H2hsaTqnxA1MElDy20BoMzAgeASNd4HuzNeTer1kx3pd?=
 =?us-ascii?Q?ziaA1hQ/j7Mtlm4jETVL4wKzf/PiBOt1VPAeQglBNF41GX5rqvXWfI4/LYN9?=
 =?us-ascii?Q?iupCbFr0iJtHwpiKtjV3Xk9naAgmQeKdGe9Ewq+jwAND5U1Qm4HmG7sR696A?=
 =?us-ascii?Q?SkkYK3/NZPhC17/EGed029G1nceUlNvZVRRYpWt7/h7UmD5X/Y+FGoeDVkdB?=
 =?us-ascii?Q?brcYvDJ9gYTBjHQcR/z81MvZZaPbxVi0uUW7i2UB6bvE/tOFuS4m2iGnLSKY?=
 =?us-ascii?Q?5We8vZuG0/OTHkfTxC1/UGa2D9Yc8cv1iWlR8s5EEk64/IPnUHt/O4F5oBmN?=
 =?us-ascii?Q?P0+0Tw7/5E/H108CRsZx6rgWyQqAHpfvK4vLY2qd5PVsFSsLvzk+Dv3+17ZV?=
 =?us-ascii?Q?4UoM6GoxyBWJV+gZ6t4gFtORcLujz2Wi/QmYadaK9ApXmPk83xyT0HlNw5SU?=
 =?us-ascii?Q?wTcEsB8VNsuyITC4QxD3rBYmgU9P7Xm1zB6xsXYrz1wrT+uhqQx1z0mfN/yo?=
 =?us-ascii?Q?DfOk7D+7ucJ1Gvi51xJu1IXmCyUQ4Fx0ipLehuel2WSUSflCciFWEkOQBMc0?=
 =?us-ascii?Q?+JlOMKkxy9YiCocd14QxNgNkmtmCK11hwFO8oqs+O4YEM9/O6a8NASvcDNV9?=
 =?us-ascii?Q?Kf2K04yiH3HvKaBk3u2OevT1XzcSLekdWSzRMQmq4ulylhN2TIdaltR8QOJu?=
 =?us-ascii?Q?ygFRRZ78lOAeLVLPaV9O+wBeOn8tWZ8Z1zERJHXgTJ7XeWywRRSjJ7RpNQOC?=
 =?us-ascii?Q?NFuJ9GaWsdsmVJPKYfpUGPWkVRoFrmKLrPH/mwHhnbowMP9cLuyiUMVgBtAv?=
 =?us-ascii?Q?+IJbGUay/Q987wv8L9AvYPJAfD8HyAxOaVVZGngB0y6hjnWCRTGApEM85jaZ?=
 =?us-ascii?Q?ZcguykdxGbYENVgFsAVXIH4w0woGgcEZDRtdO9suRgAZTBpOPkDyHYVhVxyp?=
 =?us-ascii?Q?BOozNBV33oUxcfD0HTbp0ECftg2hxJn6qoCwH/Lx9upLsXDbSftu1iZ4MOEL?=
 =?us-ascii?Q?r8nySmeZdg7clAgqTsfbW+4DMviW4nL8RYcqOiAnrTDuBm6t3oaXEkPxHdiT?=
 =?us-ascii?Q?ywTblbp/dWzf1RPqA72hHfRWSg1O79qvb6U5w8jk0ictsK0EuOitdgt0WK9T?=
 =?us-ascii?Q?gkfAIBKLQSljsbLNv1T8TLcXBZw9DudEinDY7Z3AsnytEPYS7MJjruaU8V7G?=
 =?us-ascii?Q?MIPTSK2hI2A6F6JHDbvqoxjEMyRMRzr0bsUbi22sMOiyCoXg2suScIpvNu2k?=
 =?us-ascii?Q?FQknz7R0ORyHRgQoakJhn0Qx71U1RAhXWKZ9EGeF3RhN1sd8DZf0OJqg1bQQ?=
 =?us-ascii?Q?drWwOBJLX/R1JhsFOMtEKOKhB6bhKKXLo113tXkoNw2sWI+z1oNcWh6/ol/y?=
 =?us-ascii?Q?NYUwmMwpBXfWzqHxJVljVNbm8i3I5/HNOHIqpn+Ao2Jy0ZRognIOoDJwDpJH?=
 =?us-ascii?Q?S+sIznpNR+3P65+2wUmCru9rWh6xvwjWkdujaP3kPof0NDsiuxjLc9iPYa3C?=
 =?us-ascii?Q?ho9Xq3qcEGY/q4ktJszKJZwBH0gAof3catNFXTKdRdnjDWRjcisoxiTcyk/Z?=
 =?us-ascii?Q?CGbv8oG5FA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e880d82-cfca-4589-723b-08defbbd1b4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:56.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTSNOuh2F08AC0/oh3mIMrDK40REo/4lWdna44gujf3Fy3dC6TFNkAu1GCFyBYNMm8gQBwUNQnx10G2Ndcvreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Proxy execution can move a blocked donor's scheduling context to the
lock owner's CPU even when the donor is migration-disabled. The donor
does not execute there, and its original execution CPU remains recorded
in wake_cpu.

set_task_cpu() warns unconditionally for migration-disabled tasks, so a
subsequent proxy migration or the wakeup path returning the donor home
triggers a false positive. Moving a blocked scheduling context does not
violate the migration-disabled execution context.

Exclude blocked proxy donors from the warning. The proxy wakeup path
restores an executable placement before clearing the blocked state.

This is a preparatory fix for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f47514ba6c241..f2d34b7f96e67 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3352,6 +3352,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
+			      task_cpu(p) != p->wake_cpu;
 
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
@@ -3387,7 +3389,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
-	WARN_ON_ONCE(is_migration_disabled(p));
+	/*
+	 * Proxy execution can move a blocked task's scheduling context to any
+	 * CPU without moving its migration-disabled execution context. The
+	 * wakeup path will return the task to a CPU where it can execute.
+	 */
+	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
 
 	trace_sched_migrate_task(p, new_cpu);
 
-- 
2.55.0

