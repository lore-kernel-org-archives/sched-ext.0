Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7928352034
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012868; cv=fail; b=Kdpgf01071CWiDrjCLK4e6QKei7Pd7u3d0cXKeRmdEnFnjbAM373lrP7BU9EMDmG4+32NZE4uC/y+twNQzya8HymfBGlC4lKwe4GeaO3LIowY27MGLyN4DXXs6CC/Hksfsb/++5Q3DMJvMTc4hbiXcXo4njXnIRidedf9NWud5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012868; c=relaxed/simple;
	bh=aoX35Mp8zTPoq5QSpBjiEjrlgTtQjV0XeSe2DN4SvSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bd2QNXFD3lHlmM435kDkYIDWbIbQYND8cd0cKOLLFxMqmgW4sc6wBzTd4xpDxeXaqLTPb6qRLelLSxrnHsQq8BVezSm1j9s9rQdn2C+sT5R4jUv5qhhn2TgpuazWUDx+ZmKyHpsmJ4RFZCij2PkwP8RlpZrBPynWMUIkzFi/bfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iWHAyIjk; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iWHAyIjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQmTT2poTJ12yr8Zza8h5qbLiC41q0HG4aOPjlI8vwRvCRAKH4OUA2wlLavF3InSYJLUu+hqnxmRUGuALho2s/CuvMYlE0OBoAdiwJ4+uCFB29Jyg6rLu5e+Qmg+7THobvJrTR31dUZn0JCeCSHrYQFkfyjw9d9wa2yr/iW2bS2PHdFrrollpLhkE0Y2hl0HjBFZ6Xgfx0ANmVc4x/GkPLFpvh1BKftT+Q16P5Mcakcu1vV+p2QQb4y5h9cisXQ5z1S6QY0WVyhYaBv4w+qYXui87c7uxaoW5rtkAfil1rT9iy8TT8ASU9n7UJWBeMfaxxnd1WbY2+Kt/pz76OotnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnLLwD1DfRUQEYCdmetTzyBvv0d9KPphDA3+ML5DTt0=;
 b=HcthPbugRHVDlZM5P/8vW04B/GOj8uASZt077ZMC+OGfL5QDPvsrnGzEeJBeIp0/3ReZ1HQc72/rLJgM8ukqOuhpQ9Oq0jtcaQ1mHbDMhn5J7BGdtxjSr8tlU5YQzabTHPeXCvWDsufGBleELvWgyjMeIoipIQ/rd8Reg1Qw/u1/taseiNZqKFS2RK4a9hKoh8Ubx6s4zVfo3HlPsDAJixvaeiSq+zqPhjyMrXzxt952uEMUkF5Yopv4BCWWqhVIrz+85G32JHPNvX6uSl5L/9GuN1UegZpzYUMwrWmvfI3IqJzZyjpBAZzNlBTog9mpkikhyLqP/Szu3wsi8SQUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnLLwD1DfRUQEYCdmetTzyBvv0d9KPphDA3+ML5DTt0=;
 b=iWHAyIjk5tEhOb5BagMOqtjS4bkWh2E8pzQYisPf4FpjGh9FpQZMZOfokn3yhiTlQdvZE/iXEcGjcFHlBAxARTdpRyGRvp412U8+rUWp2VqrMdKHmAvJ4KYM3a8ENxp6ZR0nV73VDaJvHJC3UwON+Kf0kaiYYTT++VewSWEWxO7nRhdY3opl0lfFsnVBij2qCpY64dJEO8paSfrYLItBjzyU5mu/9ZHDSy+Uabm9ebV7RPTYqYUuAoSPurToHt2PmWmf5yaUEaGAz+a+UQefpG476Mb1LDW29SfD9Cj8aE65SV4MdSVN8o2KaShgGIvHnkaQcZ500b0l3xu9rQgLlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:21:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 17:21:02 +0000
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
Subject: [PATCH 12/12] sched: Allow enabling proxy exec with sched_ext
Date: Thu,  2 Jul 2026 19:09:28 +0200
Message-ID: <20260702171909.1994478-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702171909.1994478-1-arighi@nvidia.com>
References: <20260702171909.1994478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EAA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed1af02-f606-401a-2283-08ded85e4a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nTZLL7tdEP8eHtkxoRnc78n1Yo5ipIgbdrn1N/fFQWqa4WNWIHJzDDjqfpUD1WDjFe9zkGqf2cj+Q3AEPX5iYzDbodBxGXcukZj1BqrrY0J9uwCC3TJzofzZVwmqJ3q4xDIRQIvYyh/VkZjK5DSlWt9Wdhh8Et4cC7yUpj6DtK7YVY4XH1gy3i1HUcSNdO/vVaSyexIdcLTI2jUmcTw04dJ5li9DPPY8kJPFX4eB+5jSJdypI2YOu7aDCCJBU5S1ODNYY4m1Y2B4amzxigEQX82xjNtkL0HGFi2lkQlFh+PEPIwYQWt18mTo1Nk1gKlNfOs0PY/SVKRABYJ9jLdizNkyPcP4xjjSrgLZG+r6JQeegNK52MP6qU/GGXtdqZaTBonEDR4DyOCfSakBOssTvOYXKLv4ciqqGNm8rHnP4gbdsQHx9SLNE30T1F9ijj2W4hl0h6AOceJJbL/ZxlDoLPBTE4J0oCN7qQ6+yTzvTLBoEAJ/WiHen4AN0qKMs8yxRnuOoww5MSzxaoAXYacLxy8qZIJ7oJlsGfQTZXTHItzS5A7q+ZIl/uu0xGIxMG5WnDwiwRbxv1lbRIyxetwOak4K4pgsXfDQ2s02IdOtw83bzQsytxWYAZzxil0dyVswXGSg/hPDJiKN2xvC8m6hxeOc/S2bsa/t06xLDIVdj3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJIb6JwfH2bk4U9rFP5MBM2/lMhznl8sgDtj6YHsJ4e0OaHAWTXJpAeFYbeG?=
 =?us-ascii?Q?EMyiUAWt1qsq1UhsXVgglKHBqWExK2s9S4bYxW323+AhsHVK1dHgDqvODs2/?=
 =?us-ascii?Q?t7aiHLiyjcCnkWYETM+IqF4yurX8XeWJOcceIJ9eyauCsQknIwQtk5UevhFt?=
 =?us-ascii?Q?BXFFEmtU1sPTGuK9PDfoexckmcLjWSCVl2kKcea9+RbhzMFY37D7DolkS3dD?=
 =?us-ascii?Q?9iwjq4nlfcEwfGGwFCRiDUXjVOdUmmufNrf4hqX+0h51y2y4JV7iwolTGjzP?=
 =?us-ascii?Q?Chaq5yEdc4Dwd+yCO5MSs4Tp8q6QCQ0IbNbT864dq0Q4Hg3bmT6oTnwMglnW?=
 =?us-ascii?Q?mFU/i4UdSCeF4Kzpxzou6oGxgKQF56KofL2c/EHIKhzyS9JWLv5rHKP9Azu3?=
 =?us-ascii?Q?1UdQ+2RZhM5G8yrcc4BqjLgA1hNfzf5Gy8zTEtdE4rynVk4nX9AI/ATd7t6Y?=
 =?us-ascii?Q?8m4EnBvB9zY3XU+82QnIA5Af8rTE/ovR68PZJUyDYrJmX/5AD6a8ZWdYh4fb?=
 =?us-ascii?Q?2n0MyEXyzxFmYfPkgjJTJsjTOrvMc6oX5ZjQ6/CDDf/yQahQjEw/cWZ3VJy4?=
 =?us-ascii?Q?qhRag6y4vuXgyUGjXBCdNytQYEtJLQFe00fgT97bN6MZQgIykVvjyZd/1lpF?=
 =?us-ascii?Q?DpX7962sgxJ2YLnk8R4hHqf4+KjkhAY/e2wm+jxEm5gf93cAw25Ficdfz9Pk?=
 =?us-ascii?Q?G0drlKSYo4waC7TGUog3oM+9KCagO7RxTnjH3Z0uBYVjpZU7kBWKAtRgAldL?=
 =?us-ascii?Q?41dk2ZmmjgzwkSLRKJ/nvtWKwc319+NdrPKcGjv77d3KV0HO8pywpTwev1SR?=
 =?us-ascii?Q?UXsPBSRF48ZvDuOftfIkdMMvXa+doH6errSzQTkWecJgaRKJg1xYqAAY9N4T?=
 =?us-ascii?Q?/72ff1MnuGozMMTW42Feyq42ZeGFs9o+8G/Y9ZLZ/n6YmECFZIqb3j8H5wiR?=
 =?us-ascii?Q?TV5XaPztUjeW0cpyheNQEWmCq0vdAHHeczq2ar8K0pUmyGC64kKv3fV+KfbV?=
 =?us-ascii?Q?jZBT9KQ3wdymZ+TgKLdpjB2zsKwQPfPOMBr5hHUoXq9a64BjYzYU+A3FABGq?=
 =?us-ascii?Q?dsHAwM3FdxuK+nITcQBUd9/u58653UNkDiPjF28towmUTEdUolZ6aomawQmg?=
 =?us-ascii?Q?MzNp+7n0qy4kN3JZdl33599zFLjcHkcQBUG3Bv1ZpPEXXxnFj/mrBfXsvJX0?=
 =?us-ascii?Q?KJwUo0fpPQ5Ij8bf4rIp+FcEXB3Rl8jzO9VAUGgo0Ni123GNeBfG51qmySGO?=
 =?us-ascii?Q?5c63eFPoSQ410xv/3Jmaf6cbrOWxNw1JbqrIiruoGdtPIwUZ/7O092SDGddJ?=
 =?us-ascii?Q?zFHeyLTgCOueL5vwRGBKdOJERS6xvR3fFLPg7i3tJxtKFczIa2B1gOOyjm5S?=
 =?us-ascii?Q?kloefREuCMKZJCZHMgFgrgxR13xp8siprrVaZIb7q9Iofejxh7nxSpV0a6nV?=
 =?us-ascii?Q?UhkluIFMhva0/WATazOhx5rLqdrGv7crFMDEWjJ/0hmB5LEm/0vybTD3o9P6?=
 =?us-ascii?Q?9Tjc56f5MNWqKzxShdCjtcjXKd9+nLvFdLSQ87htPsUvPHcxlPKlSv5hTBj7?=
 =?us-ascii?Q?1XbCNCnJIZNB3NXvf8ZaOuiy8doVAAX2xh7N6qNCXs6PqO/jXZZPXRsQITW+?=
 =?us-ascii?Q?+Rt4QXtY3sO+j32qEP6bjUCbHYF6Z2dZ57I0iIegUG63D6lVfgIHKxE9W9Y5?=
 =?us-ascii?Q?To8Y7GxFE9yRtit1Wxe1g6PWhoTYzPzXoQ2LhVErUFWoZ51vLwXKc9n4Gomc?=
 =?us-ascii?Q?J54m9FOUkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed1af02-f606-401a-2283-08ded85e4a67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:21:02.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO2UHZUFWjiNGZIpXMdyOmYIwyu1d2/LbtCaGi2C9TgD6U69fxSXI1PrQu2Ha9/+AOqPF4oKRt6ntDFOUHtgsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

Now that sched_ext supports proxy execution, allow enabling both options
together.

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

