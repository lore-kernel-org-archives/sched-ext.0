Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1E347BC6
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321570; cv=fail; b=jgIDYdIb+RN04mkXn16zDP1qIcOqN9PX0vx7aVyDra3LrMfvSk5AvxTqSesl6Wx+i7eYiQgjALdWntcSLdcJ4nbU2fnmSx+Sy+ejmID+ZT+n9atFBd0L3OGoYarR+4grKQVR+VMDetkuJrcGd9E1UhBtagdOpt5cdwx3LXltfn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321570; c=relaxed/simple;
	bh=1FdUVfSt4RQISHefca2TB+7NxXrzIsbbaqLvHILldGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvLemGb1d4ITSP5pPlk5G+iD5yBW5EvHu8YKFzshAVEhB0PhcqIpyCkgvXw7T4Jt+1QHEdtxgNGweNQjvdPdjBdCeoh8RFt+ZkZimIQHNdoxXXxDQcYtwnzLIBfqEip7DeBrfcT0vby2Yz3eT0iav48KM4Fqf2KZhAM0MOoJt9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=heHC3/gb; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="heHC3/gb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7QPz0EGv2ib8zx1QeDMgUCxXrrV/aB3Y3wTtbcXiMbCclfi40hgydSeWdAyhXPorYyoYGXX/XawKCvEJcgIHFGWdxUQBXpi9jIsh6Xycz1jUKe1iHecdRC8/oGrnE5+FpLqcWNKViNS+NnSb42OS9CJwMDzS1z773184m5JUVfEIAvjxV0np1/rHd3GeN+OV9NDNMJumxQBOogsp7GZGEPQNoxjDRaoxr6zIBrvLDf1y+uFgMyaqsql/xC3CFZJHOpiubDk3QOE9QO4yHUqStHEEM+0riKUlGLBfOoCmYnj/nfzUR8JMv4j8ojjCHLminA74Hh8xzZpMVNZMb8w2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=b9qdY7wB6N0AHbyIuZSqYrbUv6L4m3Zf20QVwCNHfWhhGudNAaMS/26QYWPUgBgbefV4CxmZTpxheBlDyiM2Y+QCpltSUMuucTZPrmsLldfx7AD595Kd0xQuoN8toNXCTSr1XDBaOEJVpnt76EjP8YDJ35p2xhW54iCov2nPH8HSWEfwtcO3HQxpVwMvYHtTPCPTxnSkSGtAFBzxSp/WdyrxIGTkLis2agZWR3end3lMORmj4fw0kNRncg2p9s3jQn1mLcPnHfkH89++0VQ0lrnYHwbpjZaFpv6ltFUX+ybYXZQAR2kEJkc9ZItDoFOpVKYw+CsdLMKyGwoIZ3bIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvy6/tCikmy+3BPHcFy5kVCeeHFc5XSrFcF3SOf5I1I=;
 b=heHC3/gbGgse5xb24sWogfCnANyTGkz7tRPoQvmXm29Cir5f9Tswg4q6pjCsPLKo0LZU19yRvbr8igndYFMPpv/LuqVvsg4Ylh7jVRzES7JCEy0QYqplVD2xoZ5CDwCLXToDgITcblHNh3+dNMV3VwpCQDNeJEx6zNdmpDhZsxeg7r0U+9Hu1ras0AjSNJjgCW/I9A7Mf10ZpR8z+Zy+Qqwhsq9BPef2TTbEWmcYxZy/wzVYdi2O4UJNiYqBH6/Tz2ZHQvGavpSXB2XPnxQ/1AeLb6Ua7U1JkcmCHvoB1s/R/8f+bEvA9yWGQmfvjRSPzMC5wS32iNU8Dk1OZo6Osw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:05:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:05:30 +0000
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
Subject: [PATCH 9/9] sched: Allow enabling proxy exec with sched_ext
Date: Mon,  6 Jul 2026 08:51:04 +0200
Message-ID: <20260706070410.282826-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6b513f-9670-4cb4-5ac2-08dedb2cf725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VB7xcJ0Znu5BylEsEOiinNECa8sbBpcTxOrXVuun6DYA3G/jFsp2APUMJRgx1f0HSk9hZVWFcI5PAOKPS0JWMZlicg7wuANN8d8OU8J7p0wsBfPBi+PXmhRIzn5CcrcN3OfddmCB4+KrE6GCI2FC+ZF85BV86xaex+UucQZ22PGU07x9idjhFdQcFE+3YE6wLBQV3G5bg9aGBmGL5jl3OQ3gbHb5WCPua/WUdMKw99NwchZ70gTeUIWEJxxy7teCLmhb0IrfbwgGS3tkaALpWj3zBIr6rCQA8W9E89bKGubuFg3GgDMa5mGDK6QIExv29y73C4F20oS4r0m//d0UNE2+GDzkU+/RSQpBP/fkC9kzz3PT2Yzz4hd7Bnlu8CSqDN6gA1y29gPGfiIRIZAojpl/aU3lzznkuZb+re1ZAbwEzV8Yr5TfBikajiDI9iMe2A40k7e+lA1UcbOPyb+D6NOTesGkI1hjf+JnHpwpzuTTE1fkdzwPXstZCwLijNPrs9UkvfusK2/xHjO/iX8kq0CpLkJ4UsrUNrLvwz49wO6RvtjFJYZTbLQ04yOcu8MGtu7B+0XGi3TwSgYyroMpIfjS2cga+871xGwBV0LeZEcDPhVFHBcC+sVCwcZ2HnbrhCNthHXskYqm6iOYxA9yQTBGNVYowVFilH2IbAQh5e0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzyWybBHGdq9aEWryK6hx3lROQE7aq2mA3lfw/9Z/jxEsisQDGFRNYRGzaRw?=
 =?us-ascii?Q?EpH0gH7UU8HunoR72Amp6onTzL4DdqJRK0ahxVY8LSR9HoaHUxeU3Vjas+RY?=
 =?us-ascii?Q?Nr2hAXqvqG5QFyI5GIfrpxIRKpCOIzao0OB+4YBrYhddu3aGFZxKGVZvpubr?=
 =?us-ascii?Q?Fm1GB7ANeF9Q9IVoiI81FFJP4V9H7LLDGX2aagljXj/WDJCN8+iFcNI9Ozkm?=
 =?us-ascii?Q?oxyVJQKc01oT/xC7IKFmA8nRG7m7txxGD3LFuAR1G/kCfvAkMM36MxcaW9jM?=
 =?us-ascii?Q?WeEr1cywXTNA0F96pmt3T/rPn6WriTmmhPTLbHQQuZ96TTMLL0d3qHhAgI1D?=
 =?us-ascii?Q?9L3sXUI5QOrudcZojB30q+Q98lxQqNOQXtFh7cT7RNXDkq2YoiiRt8WH0ldA?=
 =?us-ascii?Q?rOcftPbELsQd/s56RBlzZ40BkvikLEz+jAlifB6rylKUhWfdsC/OsCwMEuTq?=
 =?us-ascii?Q?N9J4GEF8F+vBjbHWnt+xcgFO8nY59Lx0jnce6Oo9UgvYjSg2kIaviR8sR/d1?=
 =?us-ascii?Q?EeP9tDuq12GmOxq5oT0Ntjwk+eFzyiHbVFjGq7fy3bqVabXaz3YwmWFXcVJC?=
 =?us-ascii?Q?XnuiMIpOEcsgjyQH2kmGPBueZff9OZH6Fvy047l5o7TrZJy1xvcTRZwQQxfQ?=
 =?us-ascii?Q?qkhsOcU83TB6vZksFrgxN+qnnceLxP8E3N19Pvm9SnRGULi/ylz01dqjUT+6?=
 =?us-ascii?Q?6C09nhUtSjTTxkfAyEvm1lOyBVptESiA2ftwzk1uzB3gXOXca5if+Viis/Aq?=
 =?us-ascii?Q?kGef6iTW//y85GNIimPs+6O7hnLnfsXECih7PDZPWeJZtUTxHCj8peXh9kVh?=
 =?us-ascii?Q?TS5DOiN1lyHRbFlbhqPLNyNjQYrNwn5jM93n0tMYgQlG7pWPYDJrQLNC9TgC?=
 =?us-ascii?Q?keS2t1eVZC7n1Z33MHkjbJtgqy+aKgisD5ZM8KnbxZnjzmnsHZj2ayWD3MzQ?=
 =?us-ascii?Q?Ya2O70Hc/4u3NGqdW5XdSOBusBQcpoflahHVQWyvT8PxqTODaV2kA5ih4rls?=
 =?us-ascii?Q?9k9V/sZwSMeiMIMAhPltPm5w4BGrTJwyqOI0GlSRJb4YP1F9wfVRdollWbGu?=
 =?us-ascii?Q?wHMj496nLjhn7UABPQ8Dfdgd0gFlzJyAr70Du1b/oj+1wIDcNhEJdnPITG6o?=
 =?us-ascii?Q?XETDtgEJ9iUcZOo61yuu2Q9mZi+PmYkvVwd3ZdzqlbJZzu3v2T30ooMMBcEY?=
 =?us-ascii?Q?SOtC4/saXTziyuWY7aIBmpWWU3zODfhomZTXJHyzR4rnHzX4vEmFH5WfjbCj?=
 =?us-ascii?Q?1NG2To2ah5H6QWh0MrAQKI6XR4dZdolbJyfPp4Lju8aAsnj4HWI1ZBQd8P14?=
 =?us-ascii?Q?hguOSmYAqREj/NtcQHrMlwtQk3QtHNyAmf0NMoGMy/rcW/bY3EOH8z/Pksxi?=
 =?us-ascii?Q?lyN06qEdaqMIrcy9CO+V4sMMMSAwUtaKHVOFiPMiU167xBjmVESEwvXqDjpd?=
 =?us-ascii?Q?lFppkPUddLNH9WdMbx3s9rS/7mNjdM9u1JthablZcG58dRk1RXCuYYZpHuvh?=
 =?us-ascii?Q?a/8RnDiDtRSoYXOkl0Vl5+J7pS85P9eBCPVSD+4KLnjI+MjFvHOycGQjDupo?=
 =?us-ascii?Q?qeG2yJSdbfndpGdAcGdtopxSTvi9Gbhv+NYfZDqkw5mTG4/S3jteVz9DQuzP?=
 =?us-ascii?Q?wXl0TmxDvubDtqXUv60sUsvnLYrJY6Wdegn+drf2sJcoMh02XGnYg+4UaUv1?=
 =?us-ascii?Q?I8QkxqwK+w6SONNDdSKrf11o5OOmwOA2xBED3nML2aEN1sFetSyF8rDbg/yr?=
 =?us-ascii?Q?NbF8PD514g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6b513f-9670-4cb4-5ac2-08dedb2cf725
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:05:30.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frdU+AjrOVp3kr71PgEfvZfyR65XemtXzUSRi5SeScLFrtC3edVdXIqqMgm3tV5DV7iYTO6uOPCxNSWFue9EZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 init/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c8..0817e62266e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -934,8 +934,6 @@ config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
 	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
 	depends on !PREEMPT_RT
-	# Need to investigate how to inform sched_ext of split contexts
-	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
 	depends on EXPERT
 	help
-- 
2.55.0

