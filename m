Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7132ED51
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421710; cv=fail; b=ea3gFduRPAsnXC68ZppoNTrXmwdyGxaYgEy44XO169JfRJzafBsJxudWj86NabipDpop5u5yYgmttht8OryM8h9ED4DipR6uPKvRTKoNCx8ryZNV6NIgyuJQkGWkN1SgN8pJBpe28je7TnYon+8D1EA7zAJORr3qvBNWGdNgOh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421710; c=relaxed/simple;
	bh=Ythbnf41oiqdLMlQSTm0BhzFFA0d2usN5CZ5BiSolkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdtybF7bOK8hXnbclfInITwXmLJFvnzoiD6JmLF7qYmGfnV//tRjdQng4NLhGpdaOi3JmWnm8FBRPNctqfwfI7rkgQ5tk/1JUP1f0lNda6zbtNC64jMG6Cv8gWdDoFzP84WCtd7Fi6FiBCsdmSfm0TvHcgEbHW2JiO7zC/jycGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mONgxndV; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mONgxndV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkypcZqAss/PZAMycqO7mx5iNDzvpmf6BhjCRl5xVXFVXd3BTnELINUGF5pt/gjWHHdL8An/1D2JL0CWWaKO63UKM2hBD6PPrQuQL9wUxCvH+FuhZxZr50RMx5HvB2se8tMg0bwuCv1ZGomrYp2JZVD87GF5mL+3rrdY2OC4d4wAMqwYKkLHDuk9tj6cQoyV0EPso6d1hSg6b4RRVZV5bifN2F7wiImFx02nFzGwMysaVesaGyIDMR5YRucd8kwYEoG0Szjw7ld/6AgHPehDVtijmuVCwOeUYhziJoLi9gS2X7gAVvJY4vy105EBbsiPYbWurMxwiFOo1kF54OP0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0g6GNahttYut6Qhocbgt3uZBzl2HRFSiUFeQ/YLHL4=;
 b=Av+jdQ3QhmtBe+PuVnQiwc+h40z/L7Ml9xdd5MdfMJRJEb1sBRaK915znS0Q/3vJOFCZCbJUMN/QVnjkpBJ62cR4dXgSObE0WUEjUc1gW8KTsT75O0bh7OCwx1kzDG3veLZLMTIbtrbkQK+vw+9DB13dgE4e7EjtwWIh8zqGDwWVKMnwi9gHHE2UuN7Bt6FwbTXnRpIZ0+4BEIKnRQhUkGhkxGqrzS74BB3ISncuCW3riyD0bY7DKuOj79M8nf+6MaKIGlZU2iJOX5HhxCsAxu/b4nPV364eU6kPmsnTGx7sKC2E16IHr6h2UaPwrcuI0pu1dAo7bzQimITJC2wy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0g6GNahttYut6Qhocbgt3uZBzl2HRFSiUFeQ/YLHL4=;
 b=mONgxndVvYJjE5MkOH9MXaJb64PkwEZbViqrPYv2vEynJqnIiEVovwIVwUfqueMofyoQRTxBog+VJ5OlRxo6YSZKlzMRRNDmoJ68KzgDo9pPqvuT8AuSln/9IOTdakwu8Wq9LVXzEYDGW3Ic7uAHQD3gnIx5tLmSYiqnvZxqqf1GGEDML9z7oCsz9910cRoC8fDHD+ipLbdVFiNICATXL9UqQuzHccmgW98v4t/UEun6vlUf4bIS3ZcEU0OJJIUF8d5k3o04Y4B5bUET3vhlis04SXxgSHbxh4I56RTf7PmuvlAaxukMyZ3YjvTUVeqMwBhpGwa2uypy12BxwVY3pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:46 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Mon, 26 Jan 2026 10:59:05 +0100
Message-ID: <20260126100050.3854740-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::15) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 329c17f4-71a9-4205-a404-08de5cc1e9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kB8ZhA4ce2Hn5oPHmhrv/FwrLnC590lXZu2e0Ti62IqRQQvkFqDsgwtwVGJ3?=
 =?us-ascii?Q?hqAoAuqLdL6Q0RNVyufDGyfoTEC9eqUiIHCmjavFnRLKRnLmH92A6nUAL4xH?=
 =?us-ascii?Q?a2VQc2PXl+h//ODhCRb2ZzpR57t1uSXvfAdtxJ30Qba4wJI92StiAXkY4BUg?=
 =?us-ascii?Q?GzVXx3Y0l//ZxzBBQy1bOZSb5JyftohZlBiOqWKuRM8wjHklhgnyQLxjt0fC?=
 =?us-ascii?Q?U6LNRSK9XCnGjHfEN1Z49ia2SE4TDrhPrpOP6CsjptjiA0GCL2CIDEadk0of?=
 =?us-ascii?Q?4ztvsuQhoo+99lqbnDBjSnazeLLXgVv3EPcMRqr1HJscHxk194QPZAhVzFHU?=
 =?us-ascii?Q?DuGaT9FQTQHhK1P2/3IPAGhAGYunk1Szaipr/I30N6Y9gzVxtrhmb1kF4JtT?=
 =?us-ascii?Q?/i6yhoMn/HjePuvgVpIzYum0ZgKKxxAUd07MDl71bPcqewiY6AUpZH8ZMRCF?=
 =?us-ascii?Q?1cbUCBVEuAsSqZSi31orG4xp62vWSj7grQr70q4AcoViALFdTe/7yqoggxsK?=
 =?us-ascii?Q?vOlLlUsVPMhbsnoJ65AXE9Tj50Pt0JYgYers1P0vBcFayTvupQzsbMEX8AFw?=
 =?us-ascii?Q?hPw1+952O0rX+yBVhGMeRZomgs8+uqmudb7S+gxwZiq9egLSKZ5i4NOHw/6e?=
 =?us-ascii?Q?mBTTGH6izw8OgXXpU1XkSjXTTxEF5Y9uAsfr6AdEw9VfiLCIkSA2sU9375eY?=
 =?us-ascii?Q?tDOyJnZiQ0e0jWqN09PyE8evuTG5VYZNfbwPJJ9mLRcKXldeLjGQBoMHvLmS?=
 =?us-ascii?Q?Z1LqdEyZaOzVTIhghDxraeeGqw0Hq4xqEmxuHUncPET1470dVQ/YI2xTXS3P?=
 =?us-ascii?Q?tV87pF9DjONEHcxmlMGrW5K4iDvqypYQtsS34IDTD+KCMvM9+p0/lW6399As?=
 =?us-ascii?Q?mnbFp+RQS9a503CGmX4TZDt/tBo8Tv1x+QjbtNMvfUWCH9JyV+HwmLERbFjQ?=
 =?us-ascii?Q?UQBHAwzY/Lnwd2lIvx3hHWiJz3gEQRBVYb9wuB7tSfLo2ldbxlWxwMEIsf6b?=
 =?us-ascii?Q?UWqCr8+L+Q0MbqZArga9MoKK6vpzX26jR0wJcJXSz1UueqsxgvvBgDKFQb7N?=
 =?us-ascii?Q?RKVBi2x0+0mNCPso1KHVBMaKzgCiw/lMcN37k3CwlDYLq4L46hEAfuw86OlR?=
 =?us-ascii?Q?phmZChSN7gblbD1NEMHGeYm2Ff6dJtaNtoQWV9AFEeCTuIIfqcR+xGx6rDG8?=
 =?us-ascii?Q?alqgW9ltqUkry9gJP7TDkbf7QMa3/iT1DikcL3j6MLyHmLUgtaSojGzYjxBe?=
 =?us-ascii?Q?rEk6elmxSPhpB1hc7gNL0mz+iz0cFcSyQQtTFGcIpNxCO3k1OQF1UqBZfLvk?=
 =?us-ascii?Q?nCnZ2cOslYum82qRzR3I1jboj1V+akXSDdXULS3Mo/jf+TeVqe97ZRHDfZbI?=
 =?us-ascii?Q?Se1hpyenUfDMDeIkKAObqjInlQ0+icMlvwC/BFBGBcP8hoSLTA/c6UVQaRU9?=
 =?us-ascii?Q?TWqT+GnjV7xqw2rxfJK8wBk4BFLcmvId9xborxZo4VECgFiOXVrGCH21aSdZ?=
 =?us-ascii?Q?Guldqv5KVS8FXrDb5uW53S93TE2NB6Z21xjIZARdQnwtUdsNaxp2SvSeO7Qp?=
 =?us-ascii?Q?x7qYb7QejJnJ1/YPvVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWpwEu4sPw9S0mSiwROBc5GxDQTg/+QgINWHDXN9yFmNFfSiw/KgOzs/W8xa?=
 =?us-ascii?Q?VPf8X8/0RSyufZll+0UK2JFU3IA21eG4DiUsqiEPkKtyyZACS+F18709YR7a?=
 =?us-ascii?Q?oswvquChin3IIS2kel5212PKYQAvWmzOByY8DdV1Nfy7s/KF+9VMNIqs71A/?=
 =?us-ascii?Q?iK+BYscPeTxNeAqpCVQkLyq48YZQMSGVDSQ1/Bpu6D0VOQXhoW8i/GyeOVx5?=
 =?us-ascii?Q?B4QhrtEVhU3NkqQWSVcK3ZTlKWqGAF0tqIGmdCmXsH4H2x92pVeAcQycU8dJ?=
 =?us-ascii?Q?wVoie4PYfQrEXpZ3vOmgFjx0P+jvJGKi91t3wCRUHmA8fIxk3iBStAghRt1F?=
 =?us-ascii?Q?M/vIpn4amWxCekkW02cdOgMP/LpL5peakD/yatXFmm1IRCKfXt+5t4elycBp?=
 =?us-ascii?Q?sZfReBNdWw6t/IQLkSoEvDj35PThN6Ev25/7Bu0tsRaYLQMVYpN/blgPdxnx?=
 =?us-ascii?Q?fGX3gQzf26VBmHF5FM59W9mxmEOEAL3lh0ju+pgPchqaJe0XxnKQVw+DwwYt?=
 =?us-ascii?Q?6/milXwEAz/Qz/5nwg3hYSzCByJmu2B2VAVnMv3gkjjaoVrRfQTHaHQkO17X?=
 =?us-ascii?Q?8Wh3nl6udcfJEnwYVeOByj4M9Pdhqk4I3P4/JEA8K8Z0IAzXMO3jNHQfUDbj?=
 =?us-ascii?Q?UQx135UdUqsEZsNF+OmKdgkcSGZMDCf8WguKtYQbrPHILMYUcC0q+0Cf6VeY?=
 =?us-ascii?Q?ZQnjbdEGVU879hsVijVU/Mg/CmDQNhMHJBlgn64VkC4IO/dTsj59IMK/LFNt?=
 =?us-ascii?Q?dtVhEi8QDsc9S+PJWq41nHmunIuLDYglvK4G8hG89JtFHARITvOOaeNIvFBR?=
 =?us-ascii?Q?nRMusLVRRH0v0UftcJ0r4QYxXSwJ09L4QwDP8p7IbozBC3mYA7S42JMKkVpO?=
 =?us-ascii?Q?CNkhWwdX2aabOJ7srtWAoGzY6Z8AM0beH0TrDnpQVBPYK1GUQyIEYNvq8kYZ?=
 =?us-ascii?Q?2d3SkPuH0/lynylCoBXkQGdlJnBxS96r3HP5gp93fWLms79t9viHYZR3z96o?=
 =?us-ascii?Q?wwdHtQu0st5gNgB9G8dBFdcZvjBXJCg6LcuJ79ya/Bv6iZG77jIklbDKSXqt?=
 =?us-ascii?Q?rkDngedkiIUe998CP+vV5j7bG2LE0+pHVcytEfN/59ddZ7J+OfpXm4wCm8DB?=
 =?us-ascii?Q?XcjbE5fx0H+q0cD6UuLWPhAwvVw7jdzite91cY1DCpzoUize48+25RxP/JQ2?=
 =?us-ascii?Q?z/s3xSLDa681vXWsxRd9WmL0B6E7X75xmhvVi/jdG4DpcMG3UzgDcVBgV25B?=
 =?us-ascii?Q?h9aOPqx3XGMCai2Xn3O/x4fJchyKZsEHRPbzS39NyVRU87nrplnwoXt94Lyo?=
 =?us-ascii?Q?rFNE1hwRs2SDfKxfIkYgW6XAB++ZGm1hDclnT22nk03k0BYNXZr5qC4c2Oji?=
 =?us-ascii?Q?bWeR7NGAFNqiU0iiTcAVmjvrzf0J303/FT2FwgIfgdGCkrYg/t1AWI3swLvP?=
 =?us-ascii?Q?pMxk1+A+GfNTUOcQAIX2WQ4thvX4Y7cDSe9fa7SygYWqFP6YmOi31B2bPRl4?=
 =?us-ascii?Q?4Kb48XMlJvtK1uUR9afNBiViOhjeaY8reaUndVrpjDIzj5csavKGIQ9R86FI?=
 =?us-ascii?Q?rCR36UlOPVfiF1jwhmT6aEFSS/nPmkny/uS3ZUJME6k1UmrwrOL6L7wbksFH?=
 =?us-ascii?Q?JQg7urpiLFUiUWiTf8aHirHmBvI2ssuc9MU15hL6KH1EbU5L1IICtREZX0sx?=
 =?us-ascii?Q?TfV6i/Y75wze2bjcNB0IVAMxKtI54jxS/eDuFisg8CiwwgE8dA63/jclASAL?=
 =?us-ascii?Q?/msPSQGVsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329c17f4-71a9-4205-a404-08de5cc1e9ef
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:45.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hbLFdWDxSkLa3hzR+E/9Y4h/9iuooL5NKa6gTYYCHqTli0d0Vx3ttqtliahcvrhSJL3fyjA6KF+FB3pDXugYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Joel Fernandes <joelagnelf@nvidia.com>

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c9255d1499b6e..2c601a7eaff5f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,6 +185,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..5b0a619bab86e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 NVIDIA Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.52.0

