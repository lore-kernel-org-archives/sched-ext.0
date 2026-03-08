Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45227F005
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772958035; cv=fail; b=RWouUOBZQP4JEJLAcXCkK3r5KOBbAPWymWZlzEQWULOsmGwi4F3IOC8W/UBKJVyertRXLfPhh1PMJGQI4qUYPFTdYFegLhGvlneILXkYgNA7r+ENSt/uFKSRTxiY/xvBcYu5pJlk0eYUKenPDCuNBY8/+xlxHkqkF90GgBOMOi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772958035; c=relaxed/simple;
	bh=aTPT2BAdqSyQJVApW37PETLm6Ikms4P/I/fd7hsXB5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QOIVYNPfYwoMp5A8QhPMiq35Z6iy6cScAQX5Wpy/3xy+Lpj+ghCliP9g8fzmlVqOikzOdGGD3hl6BLugCYIQFbXlawQgL8bgF6BnugMixlPBQ0j9/6B+HC36VYZwIUdSE1Ixm66Bw/z6EWbibQC9lHTpr3KNEbiWiFQ9zx00ANc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxLd3ItX; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxLd3ItX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWntSK/xlfZ8CxtwyVCsHBonyb6itowe0DyaS79L2N4EhpMUp9NecVJRuR23FxsGFDCTC6rGPpRC97XWFA3C3692IrQUNqyTMPEBu8HvcP0AZUdVU6VzFum8NaYSGPFiwJVqPUD9mPXmctHup+EsGBRS3PM0MyeijIWzqPFZ9NvhaJOKXw91WYNlP/R5frFrvX1h0hME9bPOvenD7BubkrnoH2wNWXh06nNbCAAhLDHtTrVjwjP3iBtpp7ZWUTv1pUTLT6s9hU2dCw3MN3w0t5F2WCEpla+HViwuOH94MkdPtw1yaipuKdl0m2DM8t8cB3sLgYhuzIZ6/osyf4Xa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifgMOxpg8yGFlTXhvk9rDoddZ8KtfvysONk31q9M81w=;
 b=CvgM5sGqnQEgXZx4TJw8Dyfo5kYAW52ucFtB3epNfDqegMdt7zNFLrkstXVxDA52vX7U1MZ1hN6Pp/DczTnq5UAq75gr/OLkasCnHtFYfpBON3hPzdL0pTFfSXsfQuKoz/H14UcEX9blSPNA1/KaQ64MRj+ZsbBfgpph1tJqpT4//8ejSlGM6UMGiYlV350m3YxK+a8aADPu5r6gwbsbeF8F1/XauQSyx2/hLrEHT0J9PJ5k9iSqJEMX2ofANNwABZHBlrvUclwMa0G+y9AmFqTBR5zmxWXqwPCcrQgdPzw+degyD73wER4SVyA6dgXZjfVXzNwFmwYlBCF6vOtrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifgMOxpg8yGFlTXhvk9rDoddZ8KtfvysONk31q9M81w=;
 b=OxLd3ItXR34i14IdG67HLOaaIt2f1kivpWoTZY4JPjLY69MLuCMmXfTgfdaKNsAuQjDZ/ROJCHKawD/6852P6IvBlxcDYJUcEK87VSdPXDKMQeVgidg9TLgpC73eqLRRYMXgDUJUb+iBNEKoQQo1A62DD09Ev/u2NDRCnR6duJE/z5P22FpRNlYKXTZrnjQRf2xLC2f3V3UnZaf1DHleiFQ4LBD/5IAtigypRwc92dUoU9wt+JAHwgQsLvqro+31Ep1/zec00m6egp6M85KWNrtRh/qNq1srtSPKEpnxhaxHpIRoBE7Tsr/C+8OF0yPMh5nOCErIhpcyHE+f3O7GcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 08:20:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sun, 8 Mar 2026
 08:20:29 +0000
Date: Sun, 8 Mar 2026 09:20:19 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] tools/sched_ext/include: Sync
 include files with scx repo
Message-ID: <aa0xQ4MfdWDSa3GF@gpd4>
References: <20260308024519.1980564-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 233675d0-4ad4-48a7-42c0-08de7ceb8ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	eQpdcvxPfEK/YQT7KmNEBh8ZI9M8LjeaF8JihCRVf0uhdn0i9kZsLmMfJXSAcyYxVegfGc1Ofv6SN19m+Aq5tByy7SkBnxPorcwWG4OSfu6qHoRlqT2n1lIyTG679NLOY5OSK9QFw9TNOQ6cwN0zlKfv8Ua5JTDHocrmCjLiblc3Ayjt1ABZjyGKFeppmEmLS/uPyfegOWUrO/T1VYjgVF7/henfPBFMWCQlx6av6J0UtmujR/U+Ec9kDuYk+kFIumArD6o/AYEZX4zzyIe9gigO2PbeAf/fLClciMcBXKVA96mm5F3gXJaQId/sxFQfPWbYpUFHKYabytPeYMB0GBsTgHlwAldGDZtq2FDKgcHr6mrcKyLaUSytjPkbXnfdpeFG7ikJCwB0YqaGnsW/+8Ig/IgxWb0papZ1sPL1CyHa6eZRZt8h0Fo/Cp6drj+2JsxTCTZZxwfcmGCimes1r9YzdfczHqIbgqPi/1ndMCol9TzD6/sP1MuJ+XxivAB1Qs2TdyWYrdfqIfboX1QqIy9OX4FXNlZ5mjv4nRicDRabCj1yHgCG9ShBb+nPHPUZjNvM61g40ousNCnA4Q3qn+IZbfwm4cM1MvgPESSFY+OVflbAsGDwecOuM2HSUuWzxdlAbDCEGGlfccNByq6gvaO0kwa8TWaMx7z2SqFMa2ci4ocnODw5CkXHUMyYeREAPNjD3Z+e1xC4oxe0cxhD0QusJVswZ9EnT/W4zo1Clfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKmCohtyjiiXPP5sRkKgP+VLhbSEVyFARFWcpJ3QAfCuzIOOyxsVcZ4dwrPu?=
 =?us-ascii?Q?dzE4pW/A0z0heB9c8Zka1GgLDv0NK57xExAc39lt+hMCJggnZNR8NAxXJdR8?=
 =?us-ascii?Q?zKNdit/IdpiI/WMgZlKnVIwkZWQRaAzNOmaKrgpeBPLGfPAXDjhc5/Lo5jVd?=
 =?us-ascii?Q?++mI9PeZqivgHHQw4CcVELf7FHZm7IhD8IHG8p0Q/slXYynHujLsmhMrLUv9?=
 =?us-ascii?Q?U5Nbouv9KtLim3aGfYwAin8RlIldiO9kBByucUfONYyC3qOPHGT80BVI1yru?=
 =?us-ascii?Q?12g/wyafgEVVlmkX4XPz1DqUDxSDzX8QBBmotG5upFfbuSViqp8q/LmvxmWp?=
 =?us-ascii?Q?dEN+CFYqH5yN6wQLWA01wgxx2KisZdxk2a3CUugsf7D1n2e5WIQtnGC3cds4?=
 =?us-ascii?Q?4+PnP1KDAg5d8Dm3KSXHaDlT0qFVndHo12wYw9xyvre7nqUPb8IAfuy7PMAa?=
 =?us-ascii?Q?GwRfJd+XaVHLFRJbwnVlDhqXwtw9FyK2Sr7rMfEp4+14lbROGKkx6OYMaLkz?=
 =?us-ascii?Q?AdyGao8zr7Ac2qNvQHG7Ja8a1yV7u/fOA7AKWaoOQ9dSYbjFZ8JtHwboj79P?=
 =?us-ascii?Q?4O0qn7Lo3m+bTETPeN7FTfz55BGU7SdA2W/t3CbneYhb1hlwwbolciEObcGP?=
 =?us-ascii?Q?oF/UTXo/pzDWN9kb0bMqG4hJ/Neh8ahAiczrBPGv++WNGYRhjh3p468ifvex?=
 =?us-ascii?Q?iFPGcf3CX7JlbQvteuyOFJ9tD1+e/p830/TIhA+aWn7R5/ikHD3AtSpT7ey3?=
 =?us-ascii?Q?DUrzZDlYAA/ddNEPxyYiMSVnpJ21mCm1Ip70WokkzC22CL1vlUbr8pOxeodf?=
 =?us-ascii?Q?rjxnUVfv89bn8699X/fhEbJUdpqulT/Uct5bwvHAE/cAFWkPlWWNKGapeaUq?=
 =?us-ascii?Q?2mvGFarFmRU1+gUHFzhtqeXYXhdVAEDqmg2QUSQauBbnYCG6GOKv+hzh4WtV?=
 =?us-ascii?Q?k9mhZFKljcNRbBjmUmUfaShrfQfkfCJfjeay6zWNo7xb80ARUZRBMZcld6jl?=
 =?us-ascii?Q?9ah4EVLaA0/o3ykS8Tqh0KcZE5EVm1UZbvb+GeJJQniyFTVbqX1vNB8sCjWt?=
 =?us-ascii?Q?gWrXQ8G488NV4Z1gh47NVmuI+xIzCNXBcLlfO7OAJMTk4VWVsjMdfd9WqrGN?=
 =?us-ascii?Q?wSeVXWSF60lhNvsa72Is5BcoOiyt2y9/xRSFqHUJY+Z/yXJV5qPTwRinA88o?=
 =?us-ascii?Q?dzw1tpUDC3F01s4qTGOLxd6lPWh2V/3LgL3DV+PM7IkUq0kwOfR4xzEKF4uS?=
 =?us-ascii?Q?/zy6MwFTYMCtxMSUDV3nG7c6OQGFVWrsvjUOX0/RfYYrJQFyOC9pfG+s0ntX?=
 =?us-ascii?Q?OLz1Yh8N0Dsdg6X641CgC1EnSYoiUd3sn7lydT0/OdQ26PawiuVtoF5x+FtC?=
 =?us-ascii?Q?NI2IJ/jpM6KLaXAUjDL+CTicrFprrdc6bO+ueIruMquZr5f76ukzO5mJZEkC?=
 =?us-ascii?Q?XzrwqbYSfJXEn591evw2Kwc3ZA/cw29aYF8o4iAKbKl6tEG1pOxo5pPhjybL?=
 =?us-ascii?Q?wkD9WygP5YtWQ3TIZEo+3g7+twe40fJDcQcD/O0OC/+yCjhap/uIkOkRZgnr?=
 =?us-ascii?Q?imgA1bfVp5OAAGGnsTZ9lfMBWx6gNk9yiH7QFtPP4xJbwFOiYWwemTdrRFO5?=
 =?us-ascii?Q?Nn5YNPWK0nsSkkUZmPD6jtEwRwUBHRXpWKshffoGgGX4HivsdFXBJ6mZkLGR?=
 =?us-ascii?Q?Mq02EtXRrbp4Fb7eurCDXYgHCDDiR7cAbXdjr4ouLEwF8iBZpbAyv3YkewMT?=
 =?us-ascii?Q?MqoL2Z37BQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233675d0-4ad4-48a7-42c0-08de7ceb8ece
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 08:20:29.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOFr1jwFzgHyusOlKcgIwx0OtlPHbeZSKd1esdjtOFCdFAs/pB2oLwh0cD2VYdwGjqS88Cs6kYS9ArI9wE3bdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

On Sat, Mar 07, 2026 at 04:45:13PM -1000, Tejun Heo wrote:
> Hello,
> 
> Sync tools/sched_ext/include/ with the scx repo. This brings in helpers,
> compat wrappers, and generated files that have accumulated in the scx repo
> since the last sync.
> 
> Based on sched_ext/for-7.1 (28c4ef2b2e57).

Looks good.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
>  0001 tools/sched_ext/include: Remove dead sdt_task_defs.h guard from common.h
>  0002 tools/sched_ext/include: Sync bpf_arena_common.bpf.h with scx repo
>  0003 tools/sched_ext/include: Add missing helpers to common.bpf.h
>  0004 tools/sched_ext/include: Add __COMPAT_HAS_scx_bpf_select_cpu_and macro
>  0005 tools/sched_ext/include: Add libbpf version guard for assoc_struct_ops
>  0006 tools/sched_ext/include: Regenerate enum_defs.autogen.h
> 
> Git tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-include-sync
> 
>  tools/sched_ext/include/scx/bpf_arena_common.bpf.h |   8 +-
>  tools/sched_ext/include/scx/common.bpf.h           | 277 +++++++++++++++++++++
>  tools/sched_ext/include/scx/common.h               |   4 -
>  tools/sched_ext/include/scx/compat.bpf.h           |   8 +
>  tools/sched_ext/include/scx/compat.h               |  35 ++-
>  tools/sched_ext/include/scx/enum_defs.autogen.h    |  49 +++-
>  6 files changed, 357 insertions(+), 24 deletions(-)
> 
> --
> tejun
