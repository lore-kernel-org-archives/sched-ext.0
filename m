Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086729DB9A
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488639; cv=fail; b=j5wOTWiUaWl6Jo2FtnMZR0qQQ1ZVSda5FCEPSDQIbCMmR5+K3RBQvsXZn9ke9+Kj+AXZGc+j1qPdowNv/FJw0okp9i2kh6MX9hNxW1Dc7j9cJVnOx2vqOtK/8wUkpgZBSQD9+uOMo8AmzfS6bWWlH8ExqKvt4IOKCkZ0T9sIIek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488639; c=relaxed/simple;
	bh=RWtOlraTD1WnR2hL3a8OyE0kkIse+RBaeG4C/2KxvkY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oJllqklg1IryRqrUGnWHIzWzYTTy30HqAv4xLkOisd1VQFu9qosRrU5wmZLYBQeW60SSKaRDgi9x0XzPEwuHc3pDh3//IDWItaaos4nqyVLDTpLnTN2vLB+cj1kaJbUvsKFs4sAb47BKqp5opeqYsXna3EHCo2jy5BDLiZCgkr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suZCYjbO; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suZCYjbO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJLlmVb59BxCVv/SXc37lL7XI/A9Dpm1Q7gCicq6keDq9MvvDTLneSlCxn7RitKqUXuzqBXwCjrwB9lgBWlucL8tB1NAPl1BlLiay6/KBINXCllgQAGjk8tVVk7qSFW3Pu+3rKMrue5wXHpnTb5KbapSqo4cU0fDDMlM71RqkwcREDhzCKtZaTqD8Bidrpu+oG+hKejh5CTmfKQEcT/nTqu/RLnJexUfJEhusB0BSBG7O0EtbbsswakrbalNDRZuFRrlYwpy2PtInMb7JN9LzNUOJG7+qyBWeb4UKJjWhRgKBCHVSrFvI3wLODE3JhkULpmjPpdWai1Gxj50wZBL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOqqRexM+JFqIdqP9CItHIOEyz8ohEf8FkIWx0BRy2o=;
 b=K/Xie1ggSKSbFf/f3GL3g6jdqDEQ1+KtKAHxiHKio+BiuKeuMVghtzJZqdJMvWQiW7p1+LtkpmVkJ+yhb//Z6/9NzSpfTtiJHqKK0dtMv8JmKVomr9s5SNY1Zabdl8mNucC58g7PXlnH3CJFaspfMPVCsotXqzyQsnx9FXSnZhPg6+bXJ3sJwfJzIH/OnII3BBqDmWT5oNFB1Lw8FCTe4t5/SFk7qE9yjo57cc91tb7BBjFx/sS2ZXDimGJw7j8QO7xAkfpDC6oL5H0CEXDEphv7ZpLle1ZIM9GDhFatlr7CNBfuUMruTyzXGcoO1we4eM5m6Ni+FOdcKROvqePcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOqqRexM+JFqIdqP9CItHIOEyz8ohEf8FkIWx0BRy2o=;
 b=suZCYjbO2qvgvA45mJ9/4tmtFBhObP7j+/HtjzlXnpnmwrbQPrgzxEwCfHfnn+b5GLlinjfh2ZMMV/VKe+K+Nq6uyGFOXMbsU62mtq+n30PPUvhbcou5GMODW7ysgwS6BhQJsWuJZnXnXG+UTE1lJjJMA5h2cC6NlhiLJm//RCZ5xE8vQ4GV7BXYVdAg03AlKDQIiWH/Qgri5Qh9hYXZRF1wF3PIBTfEBpqA4WCJ1kUIrBYVLh1gmfAMt/zjcEzcXj8uNIbb1timmu6xN1iniGy9klvOHmnZPS62e+nAd3M5rG022rQn/ScAR8slcmTFjNMeNx1Zj1KjsacxHGjghA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:03:51 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:03:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Fix idle CPU state initialization and validation
Date: Fri, 31 Jul 2026 10:59:47 +0200
Message-ID: <20260731090334.2911948-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077F3.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::451) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc0b069-850e-4e93-e505-08deeee2a361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n7/vna39TUnLW4/97xkPz6umH5Ih+RMrah7yt8I7ZZB6IVy3poBUql3HDCCMacCb65KhT4CxjaH6mLu7fgW3PNBAowXbcFeSL3rcJ7jMozDDOoXpk70UuVaTau51ATtAKVnwxenGxpUb+w9uavhz1Mya//yTjc90i64Ys9pMmqdMaqEDI0aC9TIVTRXnLFcebtAFCZ1x02WljGjI3wzI8C7u+1j3Q/ivIMgf6p6AvVk2YlOxjqWBpqsDjfnhrXHJL6bNH4WmobMiNdicVYkKfUAEVXC+j/byb2Dlc2eqAWFiP9rEpS3Y6t8h8XYfWcGFZ7VnvPM4riYS1nw1xvM6jym6pe35hOhcjXDvXtkxrX8gqShVCdfOQfO0vv1L2hG+rmssGqvFYCTI5EVnPf61CB2PQ6Rkb3vy6NXUfp4o6A3GtaZqd0edRCUtGO28SrpHjUQGqY+AlEfOIV4HiqRxZeCYHf63ebj8DalhzodP5eBmDzBOYwmdDJ6KaC97iDJPacSL7yy/9VXYh2SW9xgfxUh99DNGP10FJvoMzkddteoBcM/N+qKa6qGAcMz0acm5VKOTW953YBhsDOzgdcqcEHb63Y9nfO/RjgLxkobApraygLFS+W1F0ByNTFM8+xm/O9RfZxH/Wuc/so0H4Sv8c2SgRhYQwxFYNRT4l/Kp5Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWWKTq1pXS+BTgMUSCsqh7X1GO4t+ZMiRc+3WnD31DcmC1wnwOFwAcALiS6d?=
 =?us-ascii?Q?OqvByrRxMJdzZMk70Qba9R46eiHPFRVthaSt/TF74dN0j/EXHjZ3a4YGnd7E?=
 =?us-ascii?Q?AjtA7h4R55XQ1viFixkaTLVVLS1yy0ACTuoVb4WpI6StRbGzbmIq01YLLm1v?=
 =?us-ascii?Q?flRsEmss3uJvabxUaSsjUDuq+ngjWxf0B3OCH0rcUENWBjUQUnpTNNgiOdus?=
 =?us-ascii?Q?HkjnikkbNJx7sZdlgygc/RHc+x2LNVz1QxXcwB/JkxfY5cT0mil7s6IBcEPw?=
 =?us-ascii?Q?+Y4IaS3oRMJU1j9SnyLSXl2Vph5l9Thu8MgGhnxQF4pDnTjwaoOcL3/dR5dG?=
 =?us-ascii?Q?C6dnKPnXxBsBTRJNoSBRvd+CwrooSXIHzpz5I7uEt76wofjVhCTd4JXL+dzP?=
 =?us-ascii?Q?oxntuNt3riP4C9xfgBbNaIZ+1sfRvIXBLE7dWqhqCjxrpYiTSz6hrrNOQtCL?=
 =?us-ascii?Q?cVL6vgWE91MRDq//Z7OPLEyy0pUDoWX1EOYZoJAn2xj55jmUyZ9o93XmWB3K?=
 =?us-ascii?Q?mUsOLknAVQokiSjzrh3JBsw4fN9z3gPefuolvxVNe8p9pgkNkwwkNhKFS8kJ?=
 =?us-ascii?Q?7jvELoLKKloUtZfaqQvZBY03yY9CxGYpoRGrcmIrSljPyRtTGSnpFeajnied?=
 =?us-ascii?Q?nLDZDNfxKXacem7YQbGI6cPu64EJEKOOKnBy/jLLba9rpA3moLMhJLLKAxMa?=
 =?us-ascii?Q?qWN7ZjQYh7Qu+ZNRlE3q7n64j66jx5jKwF2C3D5bjLC0BFI65pM2se5YAfEg?=
 =?us-ascii?Q?KmvQONbaJ6TNXH9zi3cjFjvKAATs3UTxRc6WLk2f4yrpKH1KSCXTfwktkCEh?=
 =?us-ascii?Q?Tx7vVkCzXeULghjMmruExK4aBWfid5zDPVIUnqFr9HZGT0eQu0R5iSFTwb0y?=
 =?us-ascii?Q?nVDX0STCRbnmSHkr829CvIynY3+2YBCumdMYF7gCgzCAd4kheawZWl9XMFij?=
 =?us-ascii?Q?Ze/ewx6mUmm1jA5bWAHBr/Wevj4oQ0Ta/ESaqsfi7cuUjt6+3ZdrrxILcwrv?=
 =?us-ascii?Q?sreZwUwW04YRK8hrRBc2erOJKMYRK19BxXIZiWNFZOjEdwJ13nQrIFex9BmA?=
 =?us-ascii?Q?r1bhz65j1SVISIC9A71DwqS04hgQe5/AqUmvg2IpQYMTYYaq1+eOPw3dzzIc?=
 =?us-ascii?Q?yDTwf7TfVF4itRC/xIc7J77DpJ1TjQs0gLjg49ihnCTd4xPIXcjLaaQkrBCZ?=
 =?us-ascii?Q?6TIUdcDsKMXZzWFFIRw7xxlXpL0CZV4wl60qQmlhcG1MThOguBYY3DIncv6e?=
 =?us-ascii?Q?Bn6aVGhsOGk3ZgIgxMaUcg7Wu3ZRfkCXircK1wOi9snYbGrwVYQSIaBASdy7?=
 =?us-ascii?Q?mVnqafwuuDjSGtjUGeaFp8WeoW/MUiEN7X/Nvdko3aGmOe+dDIgdr7f4k79g?=
 =?us-ascii?Q?7Q+yILvvkor/7A/C27LY3vWUQiByi5+ux3lLDRAtTNe4V+0lXlESqUTQ8yMr?=
 =?us-ascii?Q?46WLwrJzMiJcPK6BD2KbP5q+qGeCMlSHNcUKdBRtfTQo6l7MicQrBfxFEI7M?=
 =?us-ascii?Q?kpYPB3CyZm2LSDRxYxkxGiT1Lte8EZuCCiWFsqvDXA4vtydZ7GW2wVxme+Hh?=
 =?us-ascii?Q?IMMFOZ931BC1BVGZ5BPzmbQwa3UsUOYL5532x9KIxY1QUwUxmRgrCXU6hRDg?=
 =?us-ascii?Q?TsxBlRkv/nvXRX5GPKjERaVS/ZuhsT7k1GvRzQVL9GDGXuwiMyheaNhSIHyO?=
 =?us-ascii?Q?PCg+2GKohHCFWEiUFip8NXOKz2Hq7shN8xPsFd4dKymYEE9nAjgh3rvEnSro?=
 =?us-ascii?Q?qlx3Ydn6bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc0b069-850e-4e93-e505-08deeee2a361
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:03:51.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxQr36FsYuhNmJtrbS7Ux3MBFE0TP3UObMeWNnQeBqLUZIwqoH2MwsgjpcBKcX3LDGdjLOpjQvwnsg0P5wAmtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

The built-in idle masks are initialized with all online CPUs marked idle, but
idle tracking currently starts only after sched_ext is fully enabled. This
leaves busy CPUs incorrectly advertised as idle during ops.init() and until
their next idle transition.

Moreover, the allowed_cpus selftest checks that a remotely selected CPU is no
longer present in the idle mask. An idle-to-idle re-pick can re-advertise the
CPU before the test performs this check, making the validation inherently racy.

Make the built-in idle CPU masks reliable from ops.init() onward by enabling
idle tracking early and synchronizing every online CPU's state under its rq
lock. During this early phase, only the built-in masks are updated;
ops.update_idle() notifications remain suppressed until the scheduler is fully
enabled.

Also rework the allowed_cpus kselftest to replace the racy remote-CPU check with
a stable local invariant that relies on the newly guaranteed initial idle-mask
state.

Changes in v2:
 - Move idle-mask initialization from the selftest into the sched_ext
   core (Kuba Piecuch)
 - Add a dedicated idle-tracking static key so transitions are tracked
   before the scheduler is fully enabled (Kuba Piecuch)
 - Rework the allowed_cpus selftest to validate the stable local CPU-idle
   invariant
 - Target sched_ext/for-7.3 instead of sched_ext/for-7.2-fixes
 - Link to v1: https://lore.kernel.org/all/20260726064754.378671-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Initialize idle masks before ops.init()
      selftests/sched_ext: Make allowed_cpus idle validation race-free

 kernel/sched/ext/ext.h                             |  4 +-
 kernel/sched/ext/idle.c                            | 38 ++++++++++++++++++-
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 43 ++++++++++++++++++----
 3 files changed, 75 insertions(+), 10 deletions(-)
