Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F542CB0D
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355321; cv=fail; b=c+4E3MIvRyjuOLGDkAB0jYsrnshsRh4vuX9c4Se2FJARdg4kzLtC7tYy0PfinNJDVqCfFn201J9ZYfhCrIjMzeuqfk/RptJXHVFFBdJqPtcrD788NUZsPgeJjfRXuxyql3BxcwdLWoRgbJvxfyCRsw/zpyqTYq/5bT8rxybkgos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355321; c=relaxed/simple;
	bh=KNMrpW8okqTLP+n7dz3QkLFcRQWxDMZ6XmohC933TLI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VJxsN7/9GlNh+XCU+5jeWjBjWalTPCzA4Uo+PRwOcUdeT6cmpbqrw2v5ehseGrJFhDqbDh2NQp4bBqGbU9fny1k/bcBUQ3KvXvsobfAGCk/RXTpQiwLDWypvvPh1Ukfg9vjqar2GRCmf7EB6cC0/Jm0isjJBfQozTJQq6y/Ofgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZoDVe0mT; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZoDVe0mT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5/HWYQGO737hn9ZrOeuIVL2WvSOPCaKGEEorCveWVglE7i6g5q417sLuJWxZyPrzgILAseUAxo7HbTl1BAwnAX0rx/g6q8HzA0WHb3vPu+SjXrHKI0jFuUk0SZQU2noazjoY1lUYOB3UYT2WRsxvaTed8l/fmpk7c54qaiHPbnDNBCT8nUHLgGveLPlqozAVb6RAwuFzqP3CDxqQAJvQhebULyhcd50MijVyndZcvSQlrhonzm/Jhjxd5po/UegWDeocq2G4bxH3Ye2fSVVpBndWl7+zJ+vWC77P0BsFZqw1dJWH53f9QVUJ9sTUZXVsqZgUGuCUwSZDD5j2Ar88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU7lpchtc59B5d/ELsR5C5PhkYH7bFl/IDGIhspIdtY=;
 b=gOlpi+3CEBJtxwAj8r7e14bvtwi3I/IwI4Taod0Udu3dxGvQuUkGAQ8cbin9GIjJbf30tRAoSl9RdwFqlb8xm7bDoU7yMlSBa0L+7r5y6jmosuNKkolPlZYPb0wx+Geco4z4lRwq32hvoVJPQMpHgGNJszmcaaZu94mn8dd1b0BV63ep2osdN2sgh0sjz1XpFwZCEfxlIeTOe/BO2SwX+dRLLUCmNqLSm7Dz6ZNl3cDqmGEzi1k4oNI5mKgg74OZmJnq9n32CzCulAdT4WD10K5Ez2FXDS073Mj32cQDI3u6fwbaC8fpzgHBdrFrO9Qx3cfKLDWhLAe64o5fbqOiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU7lpchtc59B5d/ELsR5C5PhkYH7bFl/IDGIhspIdtY=;
 b=ZoDVe0mTVB8n77WQrDMh/epVaE4j5upyVl8iP6zooVsNd8b0nplynbda7FyU0SDS5NAtS+FpsZQSdfejkZaRWpyjSa6zpHmCMBrF9cX1QeaRdyvezc/+4HKNqOBBzEBsZe5OxByCqEi/lr4hsxGYg79+Z+MStacbstQOqnsgHT4jOjIejd9oFITN/XjTykhjfY1QcK0j3aezorVAbI9Um845MJrJtlT56dxOSFHsW2MUKHsuSnOqc9MTiOVj2vqVqJrPhj+XEcbgQfqPpUBt66XIfjM9FBAivHpTxAj/2YLA7YFE/XwYefUywld+73kD7m5FBrHWwjj5VvIy0YaY+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:28:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 16:28:30 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Fix finite-slice ticks on nohz_full
Date: Mon,  6 Jul 2026 18:18:20 +0200
Message-ID: <20260706162819.650155-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf1be92-6a82-4a21-d012-08dedb7b9d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3+jiRTX83QSGSDsNBkpeoA/vzGrk8pR+oSm214g84JsI2us4vyP96/Ii+fICa+kcusWAtjjbPlM+1hgYtq6xOUbfsMXGyYFMTPdq6ZjZ3b2V4XdfBAqKirI2okmTEpvvYddxy3HJKL5ICrCs8lBqpmpw3TuGAFAxm+uz7F3Bwz9w6OYkpOwDKeobM9fFmoT3Nkjo/7Pgwfh/xCw1CNn8uYSjc33Uqqkf+3ffcXUViTC92O6C/6N5dTMITiXR5I+ELdezWzUjbSYdJQXquF0mxhjfP+MpjKRv0aAJu+e/ffRoSdR+N/HaYu0U5BkFCfWjsw81fFHZfcGB1B5dHvn3lqkihhKUSpFt1BJxavpFwka1K75f+AoNLGZrcsKVnW4w90GoaT6twwOEyaxFTCKgN8u/OJWuI/IjA3ryqoE/Dnv2/oeQ6ZBxvP47tmAxpWwaVQmz4gXXdLh86eoEJE5U26aUir9MTzkCotgk5147R9i0XzeU74NhqcULHQczodhpiBWAJNZmAGH/ViEFSzd9UDIT/BtTfcK4w8HYGKbjXrHvWULmNR/KANdyFpH492ieN8tEWMaPXP1xnsCcZE63aw4yM9N+NSEf1hDssjRCVOZtFqBIVLXp2uFt7xEMWhnuZ/0Y8KB6cF1HoAtN+XbtUZ4caif6JMI8KgG975kxf7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(3023799007)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsXSVT9zkqz+CA/RFwObFAwe+2/eKxtxiVIwLzB7CDXKGctQfIFBrUyltav3?=
 =?us-ascii?Q?T8C+JXhdvv6wqfFquceJjBP8U8hBCX+MoWqY1OS+nvGTa0ERnQHaerYa0NtQ?=
 =?us-ascii?Q?NYIDQl7h2mOns56m0yLqZODsfH53uiw8teZ3uMBedsBPQF1KJzrv1jrkhk3d?=
 =?us-ascii?Q?ecvGfbrR+WsX9PmXWmIC2ZFk9WYkDDOwHvmsvqw0HLRe1ir9da2U5AwdYJM+?=
 =?us-ascii?Q?XEp8QoBgxb0YE6/Y2l3GWRboAct+GO29rqernUE24xfbl+vn8hkm7dO/cXzH?=
 =?us-ascii?Q?pVtekyg4KP5F3DXG+jEKn8satkvA9rv1T0Gtx5VtolLpRqboVOAUHZzPwfXT?=
 =?us-ascii?Q?6jupK0UhkxooDJPoyn664H1uZ5aTJonZGRmlV2KcLarVJNWuZbTgBGkFq3Kn?=
 =?us-ascii?Q?ToDHsKy+CpgD4eUAN934iFacVVw//+xTFsNIyC4pPXxERvDBGVbPFUbSKJP6?=
 =?us-ascii?Q?tN14f6Vim3kXvb//o0SE07ndc+7f8ngL+P1COJASjHJ0ppxUt0FfeRFdE+rK?=
 =?us-ascii?Q?fUIVjdjR1j/D7BEmtofcPWjTE62wdg16iRouiE4YyD3uRnvWXGnDzYxH4VAL?=
 =?us-ascii?Q?ydxi5vFp8w+7MeZFvs58Xq8XHyM+ShVTUDMgCWLEujDMXhzR6LaGmYD4Bg+v?=
 =?us-ascii?Q?OtyDcOl/qcI8QTy36bGzANM6fdr0SwgtC5xJsQ1lUpodv+WIAZFprlUgCTJi?=
 =?us-ascii?Q?m3Vcatt2u7xsf9SOK7NgRLNVMLyyTL5EHe/duZfO8azw8MPB9k7xf7O6IUQo?=
 =?us-ascii?Q?HWOsRClZ9H8QWRQh7WSYmEK47iQcFcTBwW2DpONw1NQ9t8VDj78LbSinafL0?=
 =?us-ascii?Q?9XNLZGJAtJRbLwrHWoFPpQpAdIBIxVEjf9mm6O9K43eSA6TLSBINdF4lT6qy?=
 =?us-ascii?Q?PRBAHUbtgQ5Gm+f86qh7z7FYW/K8p5dLNzni5Ixnxw7Ki3P9r9US9+kN7viT?=
 =?us-ascii?Q?6rR3t711jkpIRcC3Eo19Ka2etIZ1G9OYlRhokeZ2lrMQGH8lYgcMyTMQpLZ/?=
 =?us-ascii?Q?57VMO+1y5vDFTj/j9VPnMnsdITlJmmvjbDoITEXrkTTdTu1AksYJzWOlQJVo?=
 =?us-ascii?Q?Rowivv8vrdN+lHhcpAoBMRElfox9Upgk3wJLhGTiHkdOSVN3WtQnSa04qA53?=
 =?us-ascii?Q?4dWbRWJHYyYAv0uefyfrJQk/OsQBkaEaV/femEXJ/yH1xmZF4KN0lkHqdAmh?=
 =?us-ascii?Q?5cOV5VOI61jCTC3ND219m6mSahxWAh0iHJmTzEsIjoKrT8HMvgbiBUfwOa8l?=
 =?us-ascii?Q?xbryBf09EQTaKeb741vLWyan3r+8TtABu/se9AKcqsM1Nup0R2gjK/FIr33k?=
 =?us-ascii?Q?osaADRxx/cqbGA0FWk3oQ6RRIxi3Bv2cYXblBxYWukL3BglGhDQi8Pc2qNAo?=
 =?us-ascii?Q?rmlb5HTvg4Mqogwa5wFj+oPO8Gtis58nTcSLCd0YPEqx2W6K00ig42y9t7//?=
 =?us-ascii?Q?1p/rf3RsKZJu9FXkc4WcEs1Z8b2ZtHrj4pyhXtesMIE9JTUNfBcFOjBvXVgs?=
 =?us-ascii?Q?KHbvgXOLUBzJDJUovCNRpC1T/UB6hJ2BzewDKo09DMsFbRAw0cRyUBf0OQZa?=
 =?us-ascii?Q?7yR+sMcrRjnoqORnNn9kb7YVaTqjcdM9g8k+fhgLs+BSiUGiqqEANABLPlEG?=
 =?us-ascii?Q?yhze22AOP2X/5WQNLXNBcEawNZKneXWJB1ZoqaqIV31dw02bkLWYjxony/2/?=
 =?us-ascii?Q?x9QwKZAgL/ZOf780w7B/Hpjh9YmMEA7gG/n/SSDU6svhtpIVZFFBALf2ucyk?=
 =?us-ascii?Q?Ti73WQLF5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf1be92-6a82-4a21-d012-08dedb7b9d09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:28:30.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DiX8U5hzuHIxttbV6B6ud7yi0RIJtY1uVOpFrRCvEvCkyMhqKqYbTjYwN8I9COa7H9BehYAKCLY3RQW64i/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

When an EXT task with a finite slice is scheduled on a nohz_full CPU, the
scheduler may incorrectly keep the tick disabled because it still observes the
outgoing task (e.g., the idle task) during the context switch. As a result, the
incoming task can run past its assigned slice.

Fix this by always enabling the scheduler tick for finite-slice EXT tasks and
provide a kselftest that reproduces the scenario and verifies that scheduler
ticks are delivered correctly. Test is skipped in kernels without available
nohz_full CPUS.

Test case (using virtme-ng):

  $ vng -vb --config tools/testing/selftests/sched_ext/config \
        --configitem CONFIG_NO_HZ_FULL=y
  $ vng --append "nohz_full=all" -- \
        tools/testing/selftests/sched_ext/runner -t nohz_tick

Before:

  $ vng --append "nohz_full=all" -- tools/testing/selftests/sched_ext/runner -t nohz_tick
  ===== START =====
  TEST: nohz_tick
  DESCRIPTION: Verify finite EXT slices restart the NOHZ_FULL tick
  OUTPUT:
  ERR: nohz_tick.c:270
  Finite-slice worker received only 1 scheduler ticks
  not ok 1 nohz_tick #
  =====  END  =====


  =============================

  RESULTS:

  PASSED:  0
  SKIPPED: 0
  FAILED:  1

  Failed tests:
    - nohz_tick

After:

  $ vng --append "nohz_full=all" -- tools/testing/selftests/sched_ext/runner -t nohz_tick
  ===== START =====
  TEST: nohz_tick
  DESCRIPTION: Verify finite EXT slices restart the NOHZ_FULL tick
  OUTPUT:
  CPU 1 received 4 finite-slice ticks
  ok 1 nohz_tick #
  =====  END  =====


  =============================

  RESULTS:

  PASSED:  1
  SKIPPED: 0
  FAILED:  0

Andrea Righi (2):
  sched_ext: Enable tick for finite slices on nohz_full
  selftests/sched_ext: Verify nohz_full tick behavior

 kernel/sched/ext/ext.c                            |  14 +-
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  65 +++++
 tools/testing/selftests/sched_ext/nohz_tick.c     | 309 ++++++++++++++++++++++
 4 files changed, 386 insertions(+), 3 deletions(-)
