Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B42638AF
	for <sched-ext@lists.linux.dev>; Thu, 23 Oct 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206509; cv=fail; b=M6LBTlGC+MzeXcMMwqccBvlRz6Jz4Kglc70tgg6Mrq0I095Cjk778ewO0GhjmPR4iDudOcNJsPpaEOKmvpIlUCk2dDis5FzwsIfpJRqOEOAAAUry1VGIJGK+PwZeYEtN3hwCjdGYRaVCxB4ye6MUjRrwBPktNhPpYEW19qd53TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206509; c=relaxed/simple;
	bh=HNYozb4DoN3+45Z9ygv7dfGH/E8PIVy5SskElQEfvcA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GPK0zoCuF6mP1k05xw1lX1dzq2mSPLv3skhEGnifCUoBiamF8g/OKg4AeWnRIK9tGbV8l19YiW3FdP/VAreVDQXMYJEmoTSsnBpP6lU2MXD3pYuA7MjwYkpCej8WiiyYKwk//EcTUZd8xZeMB1IoZZ7/fQGTYJsUwRI0HWsJAgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJBkR68L; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJBkR68L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9+Exs0VHZpLmnGrR65aXhlPDucU1ucTiWUNSDxk15rLcjxHL5UrEO7F7szkTDifPMdLXULjLQSUpU/UYFiG/YMoEJIfUeETPfIYhi8+b6GGaCXdw6gaN78gIIzWj5T83qyrOrh3CEdCiKEIZ0JavWWjv7r5VFwExvROsXGTgdrjoH8bwcjDhNhSL9jdupR8oLuCpmjbi4joffiVHvfoxnzZwOm9YMzfp5qHKDzyWUICwRbGup83QsZzc+z9dP2AUxEHfzo9N+lTd+Wo463jFuAcmjSvEwg+HYd784kIiGR+PGZ5lP+SKe6HB3YlHVgp1uxxiSBDTrBmUss1BDu/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXShJzTwOWbfjniTHlyagBmHThmVvUJ8KiuCQzScUdM=;
 b=ukKwPERAeXIhRyBQnON2DVG8AsP/7Z9zqBwf7gdq92Mrf8K6jcnHqLD0do4dHPiIe61QIbcIihb7ie4LEGtk8L/QvJZUrl0jFRfFbXMedF99REcQaehMb4KoDxz4HJRqodrCn1XiJNVA17GjZY1BvBzs3xhsKMyGqYjwUvQIFcEIgF0SexDWlnciZ2NUnb2C+X/Dcg3PghtQ2DZIS32qwHyt41rEXfaRaRHp+srlyf2qSUplI6H0j2kplhGKymOQn0BW6WY3VsKMragzV6TAuJ+g5MmoAi1aBsodaHS0mxcN99sNmmTOgLCzAGkeDlzHfP+49zxHxae78CX/9O7QQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXShJzTwOWbfjniTHlyagBmHThmVvUJ8KiuCQzScUdM=;
 b=bJBkR68LbYvGVs4JOzuIGIyu8DsrR8h1uO0dGf/lp3sz1tX4yJFcmfUA1i05r+RsVzCHhRll43eH4zYIWnO9OkKLegMj7Ij4tHW/fALYj8QtJAjEkFY5IrnrAykDRGxsK4+/WoADSgTHZ77Oxs54Vo+8yfmZf0pt0m33Qup/HmKPptmzQZoeQx2BNyy/hXdbmWg3ujJc/lAPfFuAb44PacVHP3f0DsP60COzaWXxvRtsCDTMEXHSIWla4etCmYCq/TL4UqNpaMXgK6f3GA4EfHDGed1Qp4eTetlDvaTQSEtU0TBZOVxNp3ZDNB2nk6mXsyi+9BTfLVPVLlBk+ju1iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 08:01:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:01:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 sched_ext/for-6.19] sched_ext/tools: Add compat layer for kfuncs using struct *_args
Date: Thu, 23 Oct 2025 10:01:30 +0200
Message-ID: <20251023080130.76761-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0107.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e87457-3e20-4b60-2770-08de120a67b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tifroT9uAu3wZ3viQV82G1dxfYRfLlWY1tQE+Y6BxxcUJJVkoIFJn5sHh7k/?=
 =?us-ascii?Q?rNWI5I+xNiN3qV6WcyrKC1Kzf+uyv0a2JyW/u4uHlgzpStQnByiBuo5LdZ4t?=
 =?us-ascii?Q?RqL0zgHubsu5AB2XU5HikA7UpjBqDfcbP6qLusK3GDdvXNLUzF7At1WzUiqB?=
 =?us-ascii?Q?kPHSQbxJQXV+F0SwUZk0/Pw4R3axmz0H/H+8rZcDgsUjG0S5rtBqy1+sCVNm?=
 =?us-ascii?Q?GZS/JpZbweZzUh1AT0GKo+HA/dR/qIC30S0cWOp5LxQjAFahiJL7U5ijyhh4?=
 =?us-ascii?Q?E2IWf/dOe5Q1yYzmgCe13jEzvK4Ab/NhNffoHdr9DsZPdNdk55txZWGE3YGn?=
 =?us-ascii?Q?Rv4qvNpPOwmKPfg2sqWzk4kE62vTSOLNsbHG/op+tN57IKZPjOpKtlaA+yDE?=
 =?us-ascii?Q?+m/Z2H4Tlu6o6uSBg4KVVOBDeIHe2d1gwzUR0KkEhHglWV5otcLf4D/a7ItZ?=
 =?us-ascii?Q?CsxJaAMO2Ge6zCMnslEjaog4nqspGXZXCCKgv0qg1gW6qXRapb6fGdWfqnfC?=
 =?us-ascii?Q?E0x6ZheHBTFyn2eCKspPaYIiCErdg2fpiGxqrqvZ7BfRIGLLvCb1BXJuidCU?=
 =?us-ascii?Q?IYcgUN17rfDUqVEOkwgKkfzyPkUSiweyxiGE68z+Z5NykDaxPlkQtT8uGZ4F?=
 =?us-ascii?Q?AT27JUhJ7a9A8qRxsL0IeU9FcaxxNoLXyilURwBD30UNIRdKVOnmSyL0Fj2y?=
 =?us-ascii?Q?ycfnZkyqY18RrOy0qe7R+ohEiMFpkEXBZxZ4jzmIHA/4mTv2TSoKN48zFgVT?=
 =?us-ascii?Q?uX8ozfOIngQ5rFlk4FTHeUZ/gaGI9hxspG/408N+MKjfK+mgH55nPc2OiylB?=
 =?us-ascii?Q?Q/6pZfuhwL4BK7Vz0eTO5ro2M5GW3XRZr0fKRAFa3BGJDWviQJsEb6f3mXum?=
 =?us-ascii?Q?A3d037V/NXoOayPZiduHADBo+lg5yXDRCjr4WQ9KB2JzEPdL8juYBLIR7c6A?=
 =?us-ascii?Q?kyIp6fHv08m+9Iy4SJnjxYj+K8DyNc3LgsrQ/7SmjBTe7ck6tmCPGrRqaB1u?=
 =?us-ascii?Q?4Kus3ghDhcFy264SUddN7l0amjxyYV+wlISF6tVRbcPoOjwFm8ya9PDf/IdD?=
 =?us-ascii?Q?cxDPsBTaqI+QTY1ja5h7Vc/kL1OkOthMANu5DM7qis0jLPINJmcMeMi1/unz?=
 =?us-ascii?Q?DNFufWug4ZAddgI9zBBXPqudg46JUKurkQ/OxRvGq0qU/lE75GAc3tHSEnX7?=
 =?us-ascii?Q?yupIE38/uqW2x4Nmmh2mYSYbd8Aqzrr+InraLA4KYvKnokvkAMk/SxBrAkm9?=
 =?us-ascii?Q?w83GrPse1Fu4+TcbZuBVolPsVXjv11FRXYyyA9CiNIY/QQqKZpyyv2vKGpTm?=
 =?us-ascii?Q?k2JKCQ4lOFe8MY9mVg39+2WhJ9oAuvXKWP8MR1phlVh6YhOfUChfYQFByyXM?=
 =?us-ascii?Q?Cint3MwlROpDo+pWLxod7HcGRWludQeIRVU1oxlDV9oeOA4oAbs/kOet2/yc?=
 =?us-ascii?Q?2Ko8aFujo6OA6+2SvNgpgD7OEFA510SYOxNK9HQBcWgjlNNbisd8ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPfFNvntAO+QJ4Wzmxo4jCSOMkA0lk+50ybBrcPfrRpMM+JCKGHyPRYdM0hW?=
 =?us-ascii?Q?Ligv22eiWv8vGSMQCNeCzkBWAX0Oz6Q3NUAmnZEcSs4YmDz0OEh6+jvLrr5Q?=
 =?us-ascii?Q?sritC046DdEGJpDFqYxIzdLa20EkhDI0d3DmauFVR4i1l9git1QtKN9gP5Bn?=
 =?us-ascii?Q?f28yAUPZH3zsWyWJmDUte6RoJoRSpb6TkNp/nqqJ07H+DEW28bHeh2cXoA7+?=
 =?us-ascii?Q?d7n9llRHq8zIaQXrFzUlUrCQIfxd8XZsB4loZEd4ao0mebO4VuDcn1nSALH4?=
 =?us-ascii?Q?CoI7tbeCmq6NvT4TR19t4+CbbBhLmuZEkBdFXUPzP8bY3WpemjDCVNUEXTal?=
 =?us-ascii?Q?xWJIQVhpHJQ2aPXJZXGeb0aIvcVN00nNBb5klahWf/+TR9OWAt/kpyhKmoux?=
 =?us-ascii?Q?2xpcXJkk3xafY5GfI3c/Qup4OUe9vqph/l3ccbhtehY2dl3O7T54lRy9suYC?=
 =?us-ascii?Q?c38Zay0S6VQRO032flZvvYBY9qBtuca2xueTqrF6ZbaOhjAaIxy0ZYyTQjaI?=
 =?us-ascii?Q?Ueh4pmklboiBxX6jj8BBm+4HHXMo8I+YomA9pEhddw3hyKbl5ogNay1wv+SY?=
 =?us-ascii?Q?bOawjM+20+Zs4xBm8+mm+SLmHmJRsQCaTGpFuyvwUlQR/ttUb4TWTvI0nvbW?=
 =?us-ascii?Q?Pp4IiEPbex5qM5HD/ysU17qLbmQrJ8q9ohe+7Cgjw2J2L2aduCXV4uOWmYwP?=
 =?us-ascii?Q?l2jArgJ0AuQgLa6qAuRqKIFzYFz0ImP8+2Ol1AL0hLe17P81bqswMvaoDK+B?=
 =?us-ascii?Q?9mIiHU718hHXPvB49rhShtTa0VY7E7n2x2yfG35IFRMSNi+jDAbAvUmOG0T8?=
 =?us-ascii?Q?q9Ycb1lSixOqSKxwahl/k6wacdljGFsJbfB3YkYbV8/1M9YSiWjknKkarUkk?=
 =?us-ascii?Q?Wu4bA4iXT9Phjqzo0J6q6INEmis7FQphX1Ub8VBP2912sV+IaBG2oTUdQT2T?=
 =?us-ascii?Q?e7H1rz0XSwQcaEK6lU85ZVBgJiULX0ICDeYqq+2my1P62i2zt8vuFuN6DNm6?=
 =?us-ascii?Q?zKJe/azXPiPLk0zfn7WSy9/N+vB12aC/HI8Ti3p7VcH5L9ffQixComAc2zBm?=
 =?us-ascii?Q?oJ1Oey+dSNBJPpJk47np0RILEjR2MTO/twu+NkhJfuI9ghA8MknwdOvDP1Vv?=
 =?us-ascii?Q?wYhhqz8cre7ggm+P9TB+TrKRWNQ5MSIekowNpa0DeYabPMJef7/RhvrVsXK+?=
 =?us-ascii?Q?lv9GgCQ6nFQ9WRoJXwVGPbkUwZ0HtldS5tKNUPv1uYUP/BJmzx3yFyxPpE0Z?=
 =?us-ascii?Q?naYsi4X4mVB+f+DTijW3PqCwok1mGUAkRE9YKR9PtkgXCelu4s498Cfw65p0?=
 =?us-ascii?Q?b22zO1Hu2noHLBJNNOy8jEbwWdMGxy9hPGPqXM5O1QNXXZ2BLWe5/MnqKu0/?=
 =?us-ascii?Q?luqYkiIwipsWvzevtTGMX9YEtS9IN44XcGqTQYz87bHDAvB/w11ZbfquMGzJ?=
 =?us-ascii?Q?6g+J1A3fC91x0SshCRRRPVb45/KTW669ofsPy/T7UudlB2hXId+jS77KtxIS?=
 =?us-ascii?Q?FQOvKISHx5Ei12AqTCJw6Pf9BjLZH2s2SQBpbdpyFU/3Knlgg5dkjgFTiSwP?=
 =?us-ascii?Q?Aevb4wdKMPC/k8uSRJCWHNc9DpsJ68h7YifY8PXd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e87457-3e20-4b60-2770-08de120a67b8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:01:43.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro3khHMM+mS7ZOqMfBa5Q3lQJMNniLcBDyEdo+6Q/4h7LaFq6e5B3G8moJTx5Hi81mS0Ci4uYD7ZqeLZ6sJVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

Commit c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare
for aux__prog") introduced new kfuncs that take their scalar arguments
packed into dedicated *_args structs.

However, these new kfuncs need to coexist with the previous scalar
variants, which causes build failures in sched_ext schedulers when
building against older kernels.

To address this, mirror the struct definitions adding a __COMPAT prefix,
ensuring schedulers can still build also on old kernels that don't have
the BTF definitions for these structs.

Moreover, add a __COMPAT_bpf_ksym_exists() helper, which extends
bpf_ksym_exists() to handle static inline kfunc wrappers and fall back
to the *___compat() variants, where available.

Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare for aux__prog")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes v2 -> v3:
 - Drop the ___v2() suffix from the new kfuncs (Tejun)
 - Add __COMPAT_bpf_ksym_exists() to handle kfunc detection with static
   inline wrappers
 - Link to v2: https://lore.kernel.org/all/20251022153610.20111-1-arighi@nvidia.com/

ChangeLog v1 -> v2:
 - Introduce __COMPAT_* struct to fix build error with v6.19 (thanks Emil)

 tools/sched_ext/include/scx/common.bpf.h |  3 --
 tools/sched_ext/include/scx/compat.bpf.h | 36 +++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e65b1eb668ea5..64e5411d04c04 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -60,9 +60,6 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
-s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
-			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
-bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index a023b71991a6a..d534cacb94066 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -15,6 +15,13 @@
 	__ret;									\
 })
 
+/*
+ * Extended version of bpf_ksym_exists() that handles static inline kfunc
+ * wrappers, falling back to the *___compat versions.
+ */
+#define __COMPAT_bpf_ksym_exists(sym) \
+	(__builtin_constant_p(!!sym) ? bpf_ksym_exists(sym##___compat) : !!sym)
+
 /*
  * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
  *
@@ -161,6 +168,27 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
 	return rq ? rq->curr : NULL;
 }
 
+/*
+ * v6.19: Mirror the following _args structs, to prevent build errors in
+ * kernels that don't have these structs defined yet.
+ *
+ * The kernel will carry these __COMPAT_* structs until v6.23 (see below).
+ */
+#define scx_bpf_select_cpu_and_args __COMPAT_scx_bpf_select_cpu_and_args
+struct __COMPAT_scx_bpf_select_cpu_and_args {
+	s32 prev_cpu;
+	u64 wake_flags;
+	u64 flags;
+};
+
+#define scx_bpf_dsq_insert_vtime_args __COMPAT_scx_bpf_dsq_insert_vtime_args
+struct __COMPAT_scx_bpf_dsq_insert_vtime_args {
+	u64 dsq_id;
+	u64 slice;
+	u64 vtime;
+	u64 enq_flags;
+};
+
 /*
  * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
@@ -170,9 +198,15 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
  * compatibility. After v6.23 release, remove the compat handling and move the
  * wrappers to common.bpf.h.
  */
+s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
+			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
 s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
-void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+
+bool __scx_bpf_dsq_insert_vtime(struct task_struct *p,
+				struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p,
+				u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 
 /**
  * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
-- 
2.51.1

