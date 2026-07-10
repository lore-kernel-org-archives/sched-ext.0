Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC53D79F9
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672835; cv=fail; b=gt/zkdcUiI2QP3HC78rYS+bIgGy5ySbliYO7dudXwye+lvWPczrCkKoqdLMSiwucWVOmHfw7BK94tlcZ1vQGAS7+FBIyZWfIWzxhidhsWRHbnZwejBHfuW2zRikgxyWNuygPJIdoV2FsirrWN94oJMD5FPsGvqWi/cp+sgDvfK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672835; c=relaxed/simple;
	bh=CkISoUFGjZ05liWQH3kyVQQWanO+Mx1mNeANOaTX5gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNK3qPIQnPYgOYLB7VRcTE6YBO7/QwvEauTASnHxpDSmH+HOVrFo9Cjw0CfPpR+n1oHkRTIs1NJmr9tDdzC7BwmdTjYDgqPQGF5pqFRo0ryXL7PuclqTBsSsG9lvfjK9UslrxiRUP1MkZ39vHlQiq/f6bRD3/uOJctDsxPaW4Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hm6P4WxJ; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hm6P4WxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF7/W2i9BxLHCUTKMA+/KsF/ijTqWdU4+UkKJlpk0Y89s0wUgiDUZft8WCrQvEIfbsj1zJKoXdK2WOc+bOicyWiKx6a5t+sZ3bkUOcYQYmNm86bxo5Fp6MlIrl7ZaxB9K+FmIFJ3QgqX6iR4UwxY/AgbzZ2IF1+n7Coko+K+JUDhhs//ndqEDdUHidIihy5eR6Yq6j6FPTnv62ky9lSRPQL/I81MkOakz4pKPnOHsHDiz9H5hNy8DigytNdmLkkc78XwCYVHzDunBMG6i9HNmqbXds5GnTQggHoPH8KZpnjJbCj8dNXc8VZH6pvoR3MY/69XS5VkiZF2lbItDrgvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gesOQ6kxfVsznCJLoeGm1JVUIFNrePDvMiaXe5nakiM=;
 b=Tv+m34pAJIBBpJeSkIC3gWgF4m2QZfRt4evKZ0wi5JyOwDOm5g3L+bjZ6DzLvUt5QfrWRBmp22NzecoPAG4Y/c/sAOXp5ZfiRkfbXDglDA8nNK3rUupDayOyfIiI6HTxoI7kBog7brYi08HK74VUxyNFm29n1Kz7YXXpEMlvmFCFCzHtrtXnImyldp6apFMwhrf84VUC0ZMEsda6Hfh3feGMAwZXbW0jZKYcMZDY0RhpGl9zByIvDn82kIZSxYYV2f61yUXf+IFthEIsyHbc9PxlX3pBUPqSCRse7ZVWHY6mJQGcWBY3tGsO2Vmo/jd7Y2dTsyuimUmRAlVLo64W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gesOQ6kxfVsznCJLoeGm1JVUIFNrePDvMiaXe5nakiM=;
 b=Hm6P4WxJLaiayPmuJL6wc4PclplnnXRfm/nCHASYo+6dffTFtHlQk7JjMEy6FgAXlCHzYBBtL5MZmbkfhMKrPqMyo7r63tkLErir0iEZjuZso5YTEHrOAZlaTPlhAvcVhJ2q79E80odFHcDlxZT7ASjQI2jhqeGip5DZL+FO3fEDY02NZvHcblyi4Xs2O7smX8rJCnIt3J/wBz7S8A+ekB0bQj+C5+IJEXyxe3B0S86S/Ff7oyHnzT11TnWBnkp24fFxzHJPVMHikPG3XeKKKU2xv84mY1tz8R54R0v2M2/IaasE1bSVApReEwLy/zijHBN/QPFlmwYCEN8c0JEWEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:40:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:40:28 +0000
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
Subject: [PATCH 09/10] sched_ext: scx_qmap: Add proxy execution support
Date: Fri, 10 Jul 2026 10:36:33 +0200
Message-ID: <20260710083913.30573-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710083913.30573-1-arighi@nvidia.com>
References: <20260710083913.30573-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1a6ee0-39dc-4bb4-65a4-08dede5ee515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0IeCr6DZbXYk3/ttWCYDMjKY4nD7luUE/Nz5H90qvyqN9yIZP/Ug+3WTgOMIkmj4AxES3aFBoJpf28R2Kkzim7d4ezs62I//CxNC2qvd2imaIuEyv2ltuBZQ3FZiMT8TOtQ7Y81+fumI0q3ggBu2bfrMFVI3rGwGUZbLapPQkQmtbUAaLALdY47hdbALWashXAGBjXCLhur9a0OI35b6EgyuS6DYVR1mzqWkmmsammeEkxWwS9lK5pS21w8U7AwJawp5heEOIHYptVoRkz3M0nxpIj15tbT/15kE5IvCH3g195GyBuExxXCPF0vjc8t+1M+5jfQorRw6AFB1a2V4lDL28fDXfyCu+KiqSSuQgtxtOoT9IIgWUo53furhI23Gk944oClHRRHu1MA7uNsRu+uL1miMbRPV8B+p50KN6CaaAsGcS97t4jUvekp9tdnSQzL9aoxNPd62PEMPmKWFr6BXfrs2cJdJxM72wRK+rfl2+pwSk43bE+LuuQlaD1IA4PeahHV4EyKZSoD7sxUXUmlOuL15QLiihkjdKh1TGkbwUPtQ8nXX6Ftg4cMz1sF4FDfHYeBfJdK/rNoW5TiCNsRpfeQV+6j3ggO+gCsc3prOFKoiC1BSo8Gn0Agae7tofRulIrZlbjElHeAo+YRzx1+YmahxIkh0GaxWLWXXB/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGoV/+pRqHWx52hiWjKdEhjz8zS53HhzGaTIfOgvNUaU24LoyWxkZq15tM+g?=
 =?us-ascii?Q?4U7ULY1EpBbmLBaBPFyZrCNtQWlMn43ep39jDv3dw5HVFDiJ+D2kB8CVlFEs?=
 =?us-ascii?Q?bacHSwOuDCOEHr8xmDop6tguUusUhgozDCOVRT2iwyAWAb+C5C6edHOQGUAb?=
 =?us-ascii?Q?f8tOIhd28EdG9kj21xhpg7+DnzT1ryzVnnGfmoq8PfIG+B9LgDrWWtBXm2kR?=
 =?us-ascii?Q?oUbjFJAbFPRz3qdQnjnE3XJqjg1UIeIjX2bd72dQ8yHGoPPG8Pv4BtQ+zzCn?=
 =?us-ascii?Q?hBbakJo13D9B6I02wJSh0ZNUF7w9LR96TvGYGAa7HjMA5PKn3LJFvMSBLyVa?=
 =?us-ascii?Q?MBZ/oU+yVKHi1AEheG/RLOv7H8Jf0ZtBYVYNwpLHbqNgCxFgxxl7e/O3kZTi?=
 =?us-ascii?Q?LX/R2okd7+oMA8xPFj6Uk/O7fY2+uJxxp3/whkEvTR6slw4hJvyJ+ZTdVEwv?=
 =?us-ascii?Q?PgkF1OZjyE8kWJtZUZowIuSZn75ZFuQR0n2MiHvmRchbdqLWSv7eKH5ga9DT?=
 =?us-ascii?Q?R9GBnEPD9ED8TIfmdouyt7nr6LhEr3TyoUq2n3+r21n6xBMp/P+hup1N6s/s?=
 =?us-ascii?Q?q/A7jrhkzGEnft1YUyn0/vcPNHBOeAPvvtPb02Jm5CyxcvRgj88x/y1/ivfT?=
 =?us-ascii?Q?1IEx2xzZXHpTg7KoVpeDqMF9mJurqiN64mnYy0vtmONT57fDmb1axZgClMHL?=
 =?us-ascii?Q?zQ1Pp+Zgh484wK8+64S1fJT+MUFH4SLiq2y2OMNQTjYjeb/xnYe5EV+ucHz7?=
 =?us-ascii?Q?9CXEiHX91iAA0m65vDGIXBZP3plk0ID1MzDxSqpmXflg6nlD69pb1QqE3eqK?=
 =?us-ascii?Q?p8S/0ptJ7fsfmVgP3vwFedSnrWg6phDdwfY/tKMce6xhpvFly2jXPocWA7hp?=
 =?us-ascii?Q?6nDqsfSebnaWLuLirEiOenb5UhUXFI8olKcwSeqLHqW9h0Xd/AQ1aqTa2OA+?=
 =?us-ascii?Q?pCfKSK41CHgRAPepcLZDhA9Hqntr4MVxjQHZygLyKtILrlV+irbq/GUXnuJA?=
 =?us-ascii?Q?vNAjb7nQHzXnWOxNmkOZ12FFvQwKWkM8dMKgXEcSgmnWvd4kD5Xhhw2IDkB9?=
 =?us-ascii?Q?O5we45onqMuFB7ERIBPXd1v+PfhMd2UKi1cLA2VPrpxUeYbtC+M0G2v/s2nu?=
 =?us-ascii?Q?jKPaayxY4L3TgHB4IwDu0FJujlPeMwZrhf8/ETz3Ppy4uNtDkKdVPdxQDBkQ?=
 =?us-ascii?Q?GDcbUPSNxq8nPqo8jq6wRqn8p0lhIWVlgs2JZASOEe5BqkfE8f4C1b2YjhFA?=
 =?us-ascii?Q?XaDt74RrQ3zNLBUoQPhR5NrZK7M6OcqRFYpWJ2Qjax3VNN0/oGh5TwzdFEYl?=
 =?us-ascii?Q?H3zMSojFZs+RrWexT54HNdHrNqqz+evmGw8kDAMGeK6pIIIFzCaUuF+un5vj?=
 =?us-ascii?Q?qiSLY3ykkM5/7gQkAyDBptrTYxUkOl2H8VAcYuyyV9roC3OQR62aVm6pk92T?=
 =?us-ascii?Q?fdzYdWVMcgeJ77hti4i73C0EAcV/PrXwYYA5T9I2zBySTQJ8/Q5V7qHDMGtf?=
 =?us-ascii?Q?YPTllGBbfsPF2bbNtsg96Q3I26SLpwPViXy0G2BJdiARKJxfrCYa7WpruMzg?=
 =?us-ascii?Q?wLJJDdsd0Dmk8kYIORRqMnBW/dLA17kW9EvxkIMgp5dLwUBGaOkUMV680Lz0?=
 =?us-ascii?Q?afeUUByRx9e+Ls2nbMLCl4CmiXO58exfAcYXMPlsY6MCCZgL+Bxqt4D2fmWI?=
 =?us-ascii?Q?ku/Vmh7jz1faR25TRuqoHr832kjPEJBeoFRsearNdikfEC1oLjECI1uAIsVY?=
 =?us-ascii?Q?k11Aw3y2sQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a6ee0-39dc-4bb4-65a4-08dede5ee515
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:40:28.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg//a71Pv+zlgo9RPZODRUhJTux4if0z22UT9NAAA6MaoVpq/U3ZS83r9K6o+sImTO9M9NDNMm+RzovQ8OIV0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -B, set SCX_OPS_ENQ_BLOCKED and
enable the corresponding BPF-side blocked-donor admission policy.

When qmap_enqueue() receives SCX_ENQ_BLOCKED for a donor with runtime
budget remaining, insert it directly into the local DSQ of its current
cid without refilling its slice. This lets proxy execution continue
using the donor's existing budget.

Once the donor exhausts its slice, let it proceed through qmap's normal
enqueue path. This applies the same placement and slice refill decisions
as other enqueues instead of imposing a proxy-specific policy.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 13 +++++++++++++
 tools/sched_ext/scx_qmap.c     |  9 +++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a676278..2ba3e2a4f625f 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -49,6 +49,7 @@ const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 const volatile bool always_enq_immed;
+const volatile bool enq_blocked;
 const volatile u32 immed_stress_nth;
 const volatile u32 max_tasks;
 
@@ -396,6 +397,18 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
+	/*
+	 * Admit a blocked donor with runtime budget left by inserting it into
+	 * its current cid's local DSQ, reusing its remaining slice. If the
+	 * slice is exhausted, fall through the normal enqueue path.
+	 */
+	if (enq_blocked &&
+	    (enq_flags & SCX_ENQ_BLOCKED) && p->scx.slice) {
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   0, enq_flags);
+		return;
+	}
+
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
 	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index f1eaebcab5dc1..2b099167694f0 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -23,7 +23,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-B]\n"
 "       [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -42,6 +42,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -B            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range)\n"
 "  -v            Print libbpf debug messages\n"
@@ -89,7 +90,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIBF:C:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -149,6 +150,10 @@ int main(int argc, char **argv)
 			skel->rodata->always_enq_immed = true;
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'B':
+			skel->rodata->enq_blocked = true;
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
-- 
2.55.0

