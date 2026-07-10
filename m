Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B03F0AB1
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672808; cv=fail; b=b31ahSi+NuJxIKgG3uUmzP+TYFJvA4ozhphZ84lr/T1NEjh8ODIrj4xyZvKiWSPAp2pMY6WSLfQrUg7oP4WQxsa7zj1lBB5shdirlB76IUf4X0dMubECmVpetdpWjT2QHNuu76jj1acNa+dfHkCW9OkIbdFU3xyXqjU3WI3FP74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672808; c=relaxed/simple;
	bh=3fr2U4R7d7YwxGMWVXp4m8k7VGBJ5kF91ZGDKN5/rwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJkoZv2eyFVqTRO6/jPXopVeNge9UgATB2coKQljsqjatb9x1VNKxIAmoS7/9FRxqhyEVS8fL3MBtCHCpMJrOPxS9SXn5asPVHcV0/KJj04eDeojymVaK095haJfoQxhaZhWmccy8JaoOWPhWBpu99LQbYG7AbsLD8lNV9/Ji6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2sjfmDB; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2sjfmDB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPF8aWZJD9jpYdE8y3vCigLyiN/5ea+dPq5F1n0le2frRbpa59mtDvDo/GDqGac+m66Pmj3shti+YD9LkB0cRXJbSaDJxxqULww/WB4pYiS++Epink6Tkce78Ky6UIelojeoIlmir+o+wWXu5t+484WBLUXSPlTqNZ7FIpxwcwkY7CSRUpNbg08ZV5QcGBN41x6RmcVfZBP9/DP1OhSSio5RjrOoK+nEyN57u1Csaz4Jqb7UAVoREwdF/W8kPhCVBkdMpWgKOraMcBgvJZH0cztfzmrgPcDUSFNYBek8MwF2TPdCweQXWFjXxyi1yjS7U7ecKWfSUZmeoZ4PccNd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROwxJg9d1el0tJLA4Kud12mnCUm4F2WFMJoRmEqXPSk=;
 b=wuoAUW4CdfKHoYo/QtvytIU2wIf+uonh0ZrTje5ILxW7jj3z/nkR/bRZ4kSctNIydkSYV7jK8wEeIGR7T/rfEl5LM/B5bFBOFl08Q3ZnGgAohpH6mE3rVc5wbO/ioBgPfTeuO2k2Hn4U2+PtPS5tFwd6IZ0cDmxerhGqfxjk623JocLiSDVdaGdUKeRdGqx0hdu4INZDAiLrwrZrCFaMaqn7G8lVyplnpxkDxWCCq3lXvTE6zFzYOsWaRQZWXfTzkdY4nuaUlo4cJn35v87qizGdfPHtEl74KixJQn8hUkLuIKAbOK0d3g054AelSprHFNpuSgOT0+Aq/v55oqyYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROwxJg9d1el0tJLA4Kud12mnCUm4F2WFMJoRmEqXPSk=;
 b=R2sjfmDBTW4BZBwE7jQo3k8IhDNjin3uBrjBIOibihenuGDoJl3Dkl3U0op31m3x70gpIK7RnyrwG6nvlNSt18/skmYrKHRVfOmCulprOANC5qc2lK0xriCmVw4KyC1oBvv8IfCv5hwB2vdqY8jPT4Xi40IBPSLToBfI8utm1Ppo/TPgRjbsbxHdHsfJOn23HS3RrvmuGv6CIx3/LawWe5UOh0+lw0+E+J/7/p0+3U4dwM26OeM7D8WcACLVlO9rgvZUL9WeMZGqxjxvTZEIeNUHHPKDgKJy+LdFgrNoaIZVrLcA29mR2NWcT2Gs50gP3OHoXrlH+RvYDVGSHBFAYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:40:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:40:00 +0000
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
Subject: [PATCH 05/10] sched_ext: Handle blocked donor migration with proxy execution
Date: Fri, 10 Jul 2026 10:36:29 +0200
Message-ID: <20260710083913.30573-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ee8d13-ba4a-42eb-de34-08dede5ed3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zZs2IouYgbnnt/Z0vWSsLL+nGzVYOcrL3kVRWWXs4kbm/EqDH8rSXAU9Zeesy0NJpmiaQczov0hIoSUVov5YP6Gmn3NFllA5yA+VEnYXXyx96W7T7gpjUQnIeUANLkEMHpvggxbs9HEOmeYaj1aTn6oQPx5A8f8bLBuHXHZm22wRMeLGHERoJ2Gc57t1kUtwUhK57bfz0VX7DE6H+NqOS2/4YUHDhtF7G1wSb/SqSMHCIPxEe4JqsTRkY/0HkI6kpNw6GfGhmzB/BiVqL9xOkOEj/Ar3vsAgxHPGljbDyyCw3n/VPLnx1apB8VZFIGKahD5dYmhXLD4f7k/Xlf0ftF/cU6fGE3h9bWAl/AMsNTtMeSTHpVX6ERfh2uKht7v/J/17BWWQmkYQIQ3DnxdOb9jXSmJn6NicHzDd+HtsTcbvNeVinvzxNC1mBkkAUqC8Zz4KjmqKHIJ3u6PVoaPTQzXpoQZt6IeLUfIb7D5Y0Y2JmT7KvlkiZPkw0ZkpbncbQGIFyyXlM6cngMydcFwnuX9ubYPjKLD234ijMyNOlseYE806Q1ddb6qGhHiEfCE1cg2aZ7mPhgX3RBXFrp2tQ29D2TfvCszv0CeewyAShspX9isewpoAoxlZvpLjwA8Z5IvpGo0SLIfW4Ed0It2Hh2XPltzCro3OhHFTp48lbYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Vu3MuhJF6ZinjRx85F4HmbR0lrkwef9SBh0gVpEJw9906w8uFdZRCWv20FD?=
 =?us-ascii?Q?HUHThsgcbnGby2F2jbOreb4/KffUnRERJufthAZzQ4/qhtSfDSZ1pwbByQgg?=
 =?us-ascii?Q?FaGVfG5/fq3e6JO2yJuuQTEiSQHxnQIhd7/hIA7V67nXGIqxZIpVSEpq/XTd?=
 =?us-ascii?Q?q4ysA2Yxp+ywESWX2OUyVvmwZZqRSQ77yWdMsVdrPHplnA+8e9XDEjbnuVxZ?=
 =?us-ascii?Q?hMkz6KBx87YhbUSY8iScNdHzByM+qF+yp4LP8BvsR+7ibbA0WPEkdM+os8el?=
 =?us-ascii?Q?ykF7zX5rsdowOUcF/SZBQONUfsoy5881YjQbSJCoBHIB1hlRWqtDI15tx05L?=
 =?us-ascii?Q?0iCrsHlhHxK6/8su202MM4vPvUA9PZygcWAacTDdU73ypDFvvcaUPb1RYQiD?=
 =?us-ascii?Q?868Tit3v9K/S26b/aGuf0/0AvDqW/46q+rX825WU62fxcSyHqZJaBhvfp+S6?=
 =?us-ascii?Q?AEZP76VYQ7gZJc7JjdqfGLydqmVXU8YP+NkHXV4rM+XNtLmm0Ialygxlp6RF?=
 =?us-ascii?Q?Txkov71EB7bJ2X5YRUgm7J8nXTaSNnmzcX/YVoMEWJFJvXCgA382SYqI7sLB?=
 =?us-ascii?Q?vraTUkfv4M+YiHBhbW0h0mhU3y+zEU78QTFQQsAx8eabNvZr6fqScRB08vuj?=
 =?us-ascii?Q?hAGZCZFFZ0yHbRQuf9FyLiPpBdnhWdWkbuiAb19otsVCD3mu36sKDPGnx/0B?=
 =?us-ascii?Q?RU6+q8DCGn8guuwXEijo7GxZkpHLY7Ardw/VCXAJJuDrdHz0sQBEm54ShL3x?=
 =?us-ascii?Q?GqZ2iahcHvGTBYFApJBjidB/1H/sknittzA70vypLTsqxgl5X/yisaFV6qSK?=
 =?us-ascii?Q?9XhD/9niKTyttjQfInuHA1EyZ0kAnHvn+cvRLqWRLl3SNptOxoLZTg6SPEPq?=
 =?us-ascii?Q?xAROY1yGnwSYy4d5Wk80Wg3iG8rjbk8HafuE1fWRMVD831vFmVD3aeVI7c9B?=
 =?us-ascii?Q?5HOfCRC0yMpvxQKjI2PNptkhXpRhddPmbQZo4lmNH0rKNenXeQSIa46Y/QkF?=
 =?us-ascii?Q?NLEx20sDtrj+zCXZGdciBcUiF2OKOZv/h6aQImKBEwQjkIR/gSMKLLYc7n1g?=
 =?us-ascii?Q?Qq8DVmDosEK629NqxokBnSmZPkv9+2OeWhbKJBsxTSOOiR1BkJ6kGPzE3M6I?=
 =?us-ascii?Q?fzZ4bT9ZkOvZdpEZH4j6/v6mu/u5ukd73gs6shvvBvH/t+HcWode2AtuubhD?=
 =?us-ascii?Q?FqH159zPSrCSHzMMQrOdit16cWxorgJ7mpVDlejC98YR5JbPHGNrSlf9gta1?=
 =?us-ascii?Q?mQ0YMhOinwl9F27hyvmtrwR74CfQB1S/psm1B8BsTEkfoc0pS/UxSjlUNbxV?=
 =?us-ascii?Q?ks8E47MpXnSjs77xgwh20b/mIh6ijUq9BeXvq22DdULcuuwaPEPwpNa+rLBq?=
 =?us-ascii?Q?x20oTGJsK75PCTREUAkrnpz7VHvPJRkUUDocS8alHmobHqcPI5kCYiRj7Z7h?=
 =?us-ascii?Q?sw1oRPORf6PmvCbljIQpGv+EKqL9d2gDpqNegvKq7xeFtjIbLEGckyHYJArF?=
 =?us-ascii?Q?xzFaEv6ezPFd4rbz9Q7OUthRsdK3G3vEFsZNz/YVdQ2q2Jhoi/XXyOgBnAHL?=
 =?us-ascii?Q?5CGYjOAXdW9ugcLCftof69bRnFz8B5ghbev0pvxO1FvjroPFDYDMaUeYuMQY?=
 =?us-ascii?Q?smJmhwxOeg4E1Y630ieIq9alx+O6e2VvyvYoBQDCSBo/0blfaHclz/D4ffX2?=
 =?us-ascii?Q?8bbxBVkPtjpglRPFhcz0m/t8Vs7CQH5276zNVFB6hDL5BUgVb2/toDaz1VU8?=
 =?us-ascii?Q?3QQqGlXumw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ee8d13-ba4a-42eb-de34-08dede5ed3ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:39:59.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNUPYu0QoFNJJnyGU40egsXic03lXndEpmOCwFUoLUZDgBK4Vz/cwne/8NKZfUu/rVFC0K8sK6RJ5q1xYnchLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

From: John Stultz <jstultz@google.com>

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

sched_ext may normally relocate a queued blocked donor. set_task_cpu()
updates both task_cpu() and wake_cpu, making the destination rq the
donor's new callback home. This remains valid if the donor was
previously proxy-migrated: the BPF scheduler is intentionally selecting
a new return destination, which the next proxy migration will preserve.
The usual migration-disabled, affinity, and rq-online checks apply.

An active donor cannot be moved normally because the source rq still
references it through rq->donor for scheduling-class operations and
runtime accounting. Moving it would associate the task with a different
rq while leaving those source-rq references in place. The core proxy
migration path avoids this by switching the rq donor to idle before
moving the scheduling context.

Allow normal sched_ext migration of blocked donors unless the donor is
active on its rq. In that case, defer migration until it is switched out
or leave it to the proxy machinery.

Keep blocked donors on the local DSQ when they are put so they remain
visible to the proxy pick path.

Signed-off-by: John Stultz <jstultz@google.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index de1eb6f193d9a..c755cbefe2f2f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2170,6 +2170,19 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 	if (task_on_cpu(task_rq(p), p))
 		return false;
 
+	/*
+	 * A blocked donor may be moved normally to select a new callback rq.
+	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
+	 * callback home, even if the donor was previously proxy-migrated.
+	 *
+	 * Don't move an active donor while the source rq still references it for
+	 * scheduling and accounting. The migration can be retried after the donor
+	 * is switched out.
+	 */
+	if (task_is_blocked(p) &&
+	    rcu_access_pointer(task_rq(p)->donor) == p)
+		return false;
+
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
 	 * the pinned CPU in migrate_disable_switch() while @p is being switched
@@ -2852,6 +2865,22 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
+		/*
+		 * Mutex-blocked donors stay queued on the runqueue under proxy
+		 * execution, but the donor never runs as itself, proxy-exec
+		 * walks the blocked_on chain on the next __schedule() and runs
+		 * the lock owner in its place.
+		 *
+		 * Put the donor on the local DSQ directly so pick_next_task()
+		 * can still see it. find_proxy_task() will either run the chain
+		 * owner or deactivate the donor so the wakeup path can return it
+		 * and let BPF make a new dispatch decision once it is unblocked.
+		 */
+		if (task_is_blocked(p)) {
+			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+			goto switch_class;
+		}
+
 		/*
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
-- 
2.55.0

