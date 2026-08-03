Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799D38F64E
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737386; cv=fail; b=k0XSRSiCgJ7/aepqdX52JKV6U5LqZ+9PYa9nD21pXFb5SwoHGGOU2+nmLBC7kQxzww7haqaMZsro773bALXzBirbgDg5ACI6e32n4xnUcyOVhT6Bc/oSZFgS7+u98BjabY1zlrU6vymIiiRUTgQngT11YugRe+f6XfFXEqNfrkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737386; c=relaxed/simple;
	bh=QQn+xZeXplX1ZCp4o9oN5Uxph39jvxj0OL6W+V9dsek=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bie/0VhPhSAQQ3Mot6jmJQsPFyIcqetyLgJerqnU2C5YubTS3ZokePyaiyrRGqv+UnTfgwd0RfgRQ20qFKXLr10QMN06+4EaPQ80MLPbQx1RQlLUGQr4N5XcQlLuchVnfLx+wyO6w8lzaJeBQS59/KMUeoWrfrj2IM7LpT3bxUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKMyWRh3; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKMyWRh3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE3gwsfK5tM/EL2jEbmwRVMt8XJqYpdCfp72AfP2lVs7h0uA7PUPtm5e+ogHbRvGvsYc/KJPZ7EZKl9ncHybGNVWvfypBJuMf06pG8dckkjVa43UhCtIezlCy+/XT7ADkQ74/aolmPmKgcMR9xN2B5gX1f5dvIhWwwqIbzg9IDK0vHL6bb/xUIzcqellRZu+LG0o6nTKHv5s34Evn1yRM24xij00r906jCHip+OUaHam1EyD1iWE7ZFIPtEYA5Z4XyibzEFz1SPEnTU1aPMeVlDxid9TEbP3Rx+LubUoqAKRGthw2/ck4VOxyeIuquujgb3kokmS2/+wFxD0QOEQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXAFd2uCvYgx2UoSpjcGV7p1RxsBV8b5XqqRprNJNrM=;
 b=sqBCcCuFlKLbY7D170iMqpwE99k9cwirux15yqfrFoXJPeuIJKajzwLyPBiHqpeNe1DCY/fCfFgAwSH3G/zUDcmVFvQqZp3aeKvfGNM07eeilNm/Md8svNwrBUNvcKdCEQfkENrvsYJeKIK/zAJNvzPBSYneHi0Lw0+PyPJNY50E+2C0A2oVF1J8rW9sJO5PiFGsm4sZqGgMxU+Q/IOu688HQ4BLfME8PNMGzw3BGqirV5tD6T6OH0RM2GqUSVI7dVEqRLcG+4bPVczSO3K5rLzxvo23gJ2MoeiIJqTHdSVvgy3BRLQGfkyMrplnInovLLBFLfhaGMiJKmodLjt5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXAFd2uCvYgx2UoSpjcGV7p1RxsBV8b5XqqRprNJNrM=;
 b=nKMyWRh3u3cotDQbWcz7hGQGFtH1xa7HBWDAvuJAfKEFzXedw7Rs0wnrQrurfPx3v8ECn4aQRMrdbl83WI5fO5JcuLo4lN5xfyMvBpgVUANLK8hzHhP2DxFYG8/xFMps512pLFCxay5HdNZOoi+jYRHiycXlfD8PPuQYyudLFOoUOY07elnKZzeY8EDtC/i5f/eDcU8tXXthe7DVs+/XrGv0nRgXlO8K/OOIu9AWhLuWFXDOTkhLm6D2I92Lr4GxiUAjgncNMXuW3kInKJBbtDaU2xjaSUlzvpWyarMtXxj/L5zisR9g/zxm/GP26Br6wFnnfQlE6A2X7j9SwBhwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:09:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 06:09:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Fix idle CPU state initialization and validation
Date: Mon,  3 Aug 2026 08:08:11 +0200
Message-ID: <20260803060930.4111746-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ed6127-4b10-4ba7-d0e9-08def125cd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rh/w3IMjNxQ09K5PBb7v1uuResWo1MiP8/Lh1rdaazZWWc3mDxFULV+pWZeQVOe/J9uZwQZsfUqCL8OiJ8IWCjfzn8V4YVmbUgBmSuwe/D6ZQ+K2bPUqhxa1EZSBqK0GSiI18IJgTWL3Mx9PDjgp7riJOCapQYFjO14OyawBZlIkyRuCHS9Vw6zkDgR0IOZ57tgALVcF3ygSBudVilp/YOhn9EWp1244OKFyjP8UnFpAlUlsaofyCe+bvo1ZknZLfxH6FNdqS7MTyqPMei+lb5m1tz0ZHOR46cj0MoC2U3Uw8kzkrLmlL2z8IN2gD6iKK7WQWdsHtvEyyoNj0utiiSvt4EqFTC0AjIT10q/QKe8Pj6UxsRmGiULpd3iLfy8hKzVChNGM9zDNyeLNHAq5883Z4eROy+SZIPE3kktTnzfah5o91lFIa0TN8JwhLL56+XHY8f2js0TcOd+Rq52/3ZS1BsRo6Bu3Gmd44EwsiSX22X43mZhuUW/nru4GamV9Q+V0q9y9zDiPVGz8aWZlOpYP+lzR0SXneLxPwoMI+SuQYYdH33ssnKS5iVJ62WkfW37DXxzdeoDoi6UJdc9ce3DgnMWdtfNlavgVNFgbZ9VFRN+PuxyOiqRkwDuWbbG7He0V+PZ8EYQIpS02HJ8Bq6toIGQU/WRX6gQAVcZpzjs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XxvqwBOGYBmldgxB69fqeUTYncFQUzqyDz+c/fmYPBWLPbYrCubThag6PxTF?=
 =?us-ascii?Q?ecaO5HIvJQAWW2cYWYmPilUUsL1lSuFCNWcpDkeDXKDVPSy+rBIYUNZfwBN/?=
 =?us-ascii?Q?X4dDiXZoGseaatYl83kFIsaA4j6gQE2qQ20esLl5+eMTVCTE+URk4pMC5Z7s?=
 =?us-ascii?Q?ZM0Oy7ra+bIBLK4XH/mSUlmcR1ZOD6yWbOQWdE3DshRx8tO6pukV+98EZ0UJ?=
 =?us-ascii?Q?qSrvbWQTAZSx+zHKhj2YjcRtcmeJJbCDx5cp3+geRdxcGq1hEr/Dd6O8WoxV?=
 =?us-ascii?Q?KNsaP+IB7T9m4kIKCK+yYgUZABOE2mi4dWFQurlwh9ABd1pyOn5jBbHFa5bM?=
 =?us-ascii?Q?0bZ5iodyYUrJFEtUiU81RbiijQEt+m8LmgFU5TnMOGoi8wOQWbDdE4cLvzWi?=
 =?us-ascii?Q?kGsPcSaS20FnRHJK8vUt+E7veJsv+peNo4LVr92ZuVCVYcxNweWwGBuiJxUQ?=
 =?us-ascii?Q?oAT5eEYOshuEeDYdTRRpcNfDlrTOzf6yK0UZgFEvdl6sZkzCzd6/gGC8SWfJ?=
 =?us-ascii?Q?3uApfdt5a1DB365naX2xXirRGmkYoG7Et/068FJ4b8zzaEeFh5fp7LCZK6cN?=
 =?us-ascii?Q?bg0FpCUti6YTqiSv2wkvXpvgZuSslvdeZYJdv0bs0eaMrhsckAdqQDsA9jme?=
 =?us-ascii?Q?LF/SCvZKhF6A1S4MJN+4QU0HjW4THptSo8AffWz1kUC9lup9AxB2QG6osmr0?=
 =?us-ascii?Q?IP6nNDGz9XEDJHGr5i1GLmiKz5hK4GVkColuz+KGfGqOWvqwUFmtygyRFEWj?=
 =?us-ascii?Q?Z6z0tZsKnZfc2C2Cv5yenN37/vM0pWYuz8bNpdvhydp5PmDKeRmQznzfdqlG?=
 =?us-ascii?Q?v6PLZYKq2tQKQIKEtYRv0cDRhwhHKE5kg5zVSfLXYWa+3OYTvLaO4YmMixQY?=
 =?us-ascii?Q?7pt56q0vGLA0uAkAyWiBBMmgKf/yeFlX4dyDOBVzZyKxry6gxTlDl0POIMND?=
 =?us-ascii?Q?mrAHZATRvWqUmJi2Izj3Z6NlLJvZYV1Rci8pPGs0Pb48edzlBJSiT/qKlJLc?=
 =?us-ascii?Q?5OSi3rbdwqWxA4frkVjgem2rKXdDLSbNOl+mNlR+3FsI9C/lrQUgfEbwlHd0?=
 =?us-ascii?Q?RGN3Jp6RR8vBlGGEbpjMCwDCIgfDFrMtz2nZHzGrOKS7hv1H4VPSgrpix/U3?=
 =?us-ascii?Q?UM6hvSvb9aO7Gu1RkdZDL2gYQVMUybhKW3rMuPcldq9P5zhtBxTkn81PZ4Bg?=
 =?us-ascii?Q?13v4pvwbP437lxkl11SoSC0OuoLWqD7OOt3lKdIr0v7jw4osGgKaGgrxNeAU?=
 =?us-ascii?Q?dqGfxqZiieUW+UmZi72aC5wuK85buYEucvbtd8Q1T9XciztEvTiU1EEitP0s?=
 =?us-ascii?Q?jVi8JAzpsc9o1feqAFkJXzlJx5dqxu7yeWShspYr3/cLUHsabrNOeTVpLHIx?=
 =?us-ascii?Q?fQw5DMfYaqzeel9nKqr/ZXEoUrIQ1Xu9KbIdJ0657cA99BlMUrPSy/3LgBjI?=
 =?us-ascii?Q?m53ItL3EQ5r8CIBNSgBPv/ZlPGVFxXREe3rht8X1bB/owtSdZwJxbCCv57LX?=
 =?us-ascii?Q?SRv5Ya7E6phEmel5fkCwhTPmrowtJNxPKZ8DqUHn0u/hHOErYJOouP3hYTJl?=
 =?us-ascii?Q?ChTI7WkCyg4C5UbaSod65ucVH4OuhTRstzPqmWvyRfXXIyfSEsNs8j9E4o1z?=
 =?us-ascii?Q?sC69I6+i4HlN+Z5DmlpO5u+1R8rWZXGrI89JFj6TcHmBoNLpMaEoBNEo7kF+?=
 =?us-ascii?Q?iuaEXs2guu1axK2T97tqLiWOzccV6rSKr5a9WRfvdTWimFrm0r7zkLSO5M6p?=
 =?us-ascii?Q?FWGT40xG4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ed6127-4b10-4ba7-d0e9-08def125cd8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:09:40.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h8hWbanMCxePkj6q0MFbqsuh1bbT/5Hu8wefTjbmZBcEiGpiAm1dTt1mz6XU5eIBy4sMpQq7YrsZc7K2LAOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

The built-in idle masks are initialized with all online CPUs marked idle, but
idle tracking currently starts only after sched_ext is fully enabled. This
leaves busy CPUs incorrectly advertised as idle during ops.init() and until
their next idle transition.

Moreover, the allowed_cpus selftest checks that a remotely selected CPU is no
longer present in the idle mask. An idle-to-idle re-pick can re-advertise the
CPU before the test performs this check, making the validation inherently racy.

Fix this by initializing the built-in idle masks empty. This makes the initial
state conservative, so busy CPUs are never incorrectly advertised as idle. Once
the scheduler is enabled and bypass is lifted, the existing idle re-notification
path reschedules every online CPU. Idle-to-idle re-picks then populate the masks
with CPUs that are actually idle.

Also rework the allowed_cpus kselftest to replace the racy remote-CPU check with
a stable local invariant: a CPU running a non-idle scheduling context must not
be advertised as idle.

Changes in v4:
 - Initialize the built-in idle masks empty instead of enabling idle tracking
   before ops.init() and refreshing every CPU under its rq lock (Tejun Heo)
 - Rely on the existing bypass idle re-notification path to populate the masks
   with CPUs that are actually idle
 - Link to v3: https://lore.kernel.org/all/20260731182406.3166853-1-arighi@nvidia.com/

Changes in v3:
 - Reuse the built-in idle-selection static key instead of introducing a
   dedicated idle-tracking key (Kuba Piecuch)
 - Check the local CPU-idle invariant from both ops.select_cpu() and
   ops.enqueue() (Kuba Piecuch)
 - Inspect the idle mask without modifying it and perform the check before
   calling scx_bpf_select_cpu_and() (Kuba Piecuch)
 - Link to v2: https://lore.kernel.org/all/20260731090334.2911948-1-arighi@nvidia.com/

Changes in v2:
 - Move idle-mask initialization from the selftest into the sched_ext
   core (Kuba Piecuch)
 - Add a dedicated idle-tracking static key so transitions are tracked
   before the scheduler is fully enabled (Kuba Piecuch)
 - Rework the allowed_cpus selftest to validate the stable local CPU-idle
   invariant
 - Link to v1: https://lore.kernel.org/all/20260726064754.378671-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Initialize idle masks as busy
      selftests/sched_ext: Make allowed_cpus idle validation race-free

 kernel/sched/ext/idle.c                            | 16 +++----
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 49 ++++++++++++++++++----
 2 files changed, 50 insertions(+), 15 deletions(-)
