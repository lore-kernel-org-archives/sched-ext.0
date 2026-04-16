Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CF3947AE
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333947; cv=fail; b=p9q26hZdbulPfrk/7FFb2o7zkF3y11UObJAh5Ymg7nAcadhSlCDNuMAkK88TKEwoV3lxNYcfLsYGy/eoIRyRcm88URivl4/0hyZ0deCg/YDokbeTqrb3vrBKLzjbShujFW8f/6kpynoLox/t6SbwRuBXsaSGvvi2hZbyLZ8m6u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333947; c=relaxed/simple;
	bh=PgbNlUht65s28wkgGFp7cAKybHpw9g7RONiXDR+FyUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8iK+OADgerCV1ZdAqBBHvMd+jS73VACRP63DizxQnfYp2U42Gl1FakXtRpnlGF0SPDL1kVXnx8dvK6dc8frg2pqP2B4/z/dF49oo59YYli3/qz3B9aT/yjDlEYXvocLiFJyR3fV7n2/Yj6sFPrlYZpen7RBwA/JE6oKW5JeBCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFG18871; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFG18871"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3rvyp8qE8qx2nqK6yKLDsNTTnO1yi4NNiInkT5zG79HsoRIF0f9mXqniHOE9CrJvDd3ACJSqjwG1Sm2PTreumOd7f2L/0rNzxAh4QJLJKO8ArgFhXiDftvndyonV2wKcNy4r0Mvi32c8oh2SBKPWp8gutjvRwX6OGdz4MXgZzE/dsmQcIpbbiqqPJckn/EGUFwPyHVd7m5/P4wYi4T7wCp1VQPsMNHnyqlRbZ8oRNck1SMMh5iiXNRt+kczUALPK3cyi9PVe4814T1zXI1Ro/rZpY9s82sKrg0qS5eziE/bguvOuzVScddVSlsbo+HVgYBNanlgPvq350m5ZkMxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJcgMIijc+kKFnAtmAQenXoeAAhf8TR2uNtVzaulSyQ=;
 b=NA1USzP20wZh+wVRjiCA6CWCxMcoCJiwlcWWEv5em0dNLL0Hi0I2IXgNnK3s+ZGvwMjWG4dzxQu1LYPDU4O8ckNSlunLIcHhPqkVOdGH879s5W9gdIJcrNVZqqr7Njka0JVmpqz7TYNaR+968LwhFg2DGXmY5f0zhPkOp7oUHg212vJeeyT/H7Mj14M9z+jINFtsTTKzmOZ9VI0sLhT0i+1HRbfIw8i8uVPoV3NWD0xil3T02b03da2B/DbmOFrt4BqdOmO5DJ/JzsBcz2WjaKs99FYNnixbU7Jbr5nJ54BGPwYtzb40v0Binx7iPSJK+jNAMuSLK9kaPBH6gIj8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJcgMIijc+kKFnAtmAQenXoeAAhf8TR2uNtVzaulSyQ=;
 b=iFG18871A/TclitPev3oUpcoIOiX3GWcPmV1eoaQ4yfGgOHNioAgIgoYJDy0Ab27mrgJu9mO057y4Mieeam/LeqU8aXDN+fVFVOhElglLwzDOVLQMIUbW5ctM/jY68cz9sTHQQfNK22TMH0pu9hjLNxRtrIW3SzHtFm7rPCjC9UGSLAIfMo1YdDawHkpX9PGDFimX67DynP9zABDI2jFT+yxs+VeW7jLLk8yUgMkh9MuTlv+4U5zEKfGW62mz4Z+mdzGYsjeO4WGplkQ3NID9yjlWb2oYoMJfYfX7eEMCqN4IeI04Mxrt81MVSJe180LxNpUdzbXD+um+kdZWINBbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 10:05:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 10:05:37 +0000
Date: Thu, 16 Apr 2026 12:05:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2] sched_ext: scx_qmap: Convert to BPF
 arena
Message-ID: <aeC0bK8b7gIKOJxQ@gpd4>
References: <20260416081626.1285617-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416081626.1285617-1-tj@kernel.org>
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c541c0c-d7fb-47f1-e3bf-08de9b9fb4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	Qn8ZJMqvsbNrbTGp+qKXfEa7GAMzddCgRgDDu/cxIorc2wWtvUWSG3Ok5geZD62+6zTcbE7VOzHhRwO95DwPzoSxXMkDtkwoWuVOwA1myozUrffPMqxfL09iRDErbw91elBUsYIhx0uFBlWQ93d1wTJ8yUDgI7cISZJbZnRrlMQpxYzlegXCsToBwduXey9f4weEojCWy6NliNCNld7bIlvQI8hLaKFT+dqF/uhqbSdAAyx8jLLQ/9n3uIldKbPGFv+E9b8OoQjkkUN2sAMimOBO369zdQ51ng5m/wmqHcMiWL/KW/39j624mE/A+f+40++dNIICLEBSxSLtrNFvwAdN/NdNvqBms2SKx6iOCDGjIswZ5jlwpceRy/6wRfMS+/h7PmIh1OXK3TxPITyUDiA1Xgw9cqqU0HIL4TEh5W1WWWk0WN0pwBFvloOXLyptIluvcYEyqrRmO1xEoSf/MreSQ5d1J0iR+lOCY5Cr+Ace/1IUtTuwbYw535DUhg0SGa3OGJGqEg8Bd0mKPEovfpyE+Wxk1AIr0GCVQ/GhXCnBN+SYsIXSbwJEYIGhd8PYWUVQBItokcDL2LymemsD+XqnlAdTBpOO7+H1sTwMlBc54NcKR+gPjzsxxOSs2mWRaEvDE54bp0Yy9Q6aIeytejeTsR9RG30FFJELo26CoIfu4KZcHy5zPBAeHY7f/aDt/AZCdVDfqFwbWUgkE0XuoOGhy2mp7gyuSeyNz6o0gI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ft3vFsqljFUWYZ8TLdDRXipiLmufaFlchBTsYuv8n1KTZtpepPx+ku0+Ppsf?=
 =?us-ascii?Q?pii1+OsKowFiqgqefv7lrxFsAYY0H7gixAvImp3wgR8AxYKVklg0d8atvreX?=
 =?us-ascii?Q?04VTZR2BLToDbQHwtZHj0pU6bG1rC5hZeFY/qHukWUIl0Hn7iNGFunCjmRrd?=
 =?us-ascii?Q?Cv+SQHFeTNJDCIE+lZ3vG8i5HsnbPAb2bu0FVayGKh6haahlJwfhDe/lu9gi?=
 =?us-ascii?Q?G824diKad9dgHaHFe/YsnWmY9KFNYP6PihO2rMDxEL6Hh34YzVokON0VX1Wb?=
 =?us-ascii?Q?6phA7/Ffjt4bBZ77lX5EtGRjpWaV7XyBbZMVAhTNakRdSilqf7CNod2DTGe/?=
 =?us-ascii?Q?eS7U2v5mPFDJdmQoJ57q2+VS1KPD258vCHah9Qw5rlSjTHdfdVPBhmbzuJ8k?=
 =?us-ascii?Q?X+AfNfDT4KGXCGkrmRKDqfSHWO+Iu4jNGynBKVo9bmLfySV9FpBkPeymDdza?=
 =?us-ascii?Q?Ro62H67nRrBLxfWSgffyXALbeSmVecJrDrGUnloQ3T4007kmA7wXjurkMX4b?=
 =?us-ascii?Q?un5+MCYHEs3HIrQjxVD7vOOaAkKlSl6sfU3nR0gNogOnzIAharqzelTvkQmt?=
 =?us-ascii?Q?4OIyKxwbD0YVZTmDBZEMlNgr+R2Iz+iVEpS+fF49kSFilPqbA0mQfvNyNHFh?=
 =?us-ascii?Q?ksZwHZTwQB23wI03/b9LQL6esg5NoJmoH4GdOWyN0qWLxSdR41deed0feuqS?=
 =?us-ascii?Q?9z91qEiq8lmYtrhGKQ69X9TxYCvkY43Rt15RknSRvIJQI1npE/6v5/YGt0gN?=
 =?us-ascii?Q?BMhWTtmViiJU3nctpJhPpUDNWIE2kJYepihZnBkkIxe0s2arPHgE5yx/bm80?=
 =?us-ascii?Q?FeMdquIJ3NEiJEI4S4Vv/Ew7PsI+Zn2RhGNR/SUh61d4EsKwA4zU3ZoynFL0?=
 =?us-ascii?Q?JEC6ZXISWN3JIolhvE5184Cm0BUKKYHbr/FcQ88f+pUnv/rbhCvHVH/cVP5c?=
 =?us-ascii?Q?RFG22lVLC8E6X4cUQ5wfHc9Z8t3X/ouaosNNF+hgNuc6UCb/Q/dFtpPIP8Eg?=
 =?us-ascii?Q?jWdSdElL4jWJVeyI22+ApLvvYSu5cBq3MVB8ZOPYscOXHEWT48Vke9WQe0SM?=
 =?us-ascii?Q?atouWUr/FEjaoptzMJrb1UfrBwcf6a7bU3BsmKImAnp9VOWN+PgMv5pdBAGK?=
 =?us-ascii?Q?y1lW7jQl6Z/GLnN6lMJgv+qD0CZg3X+RwyN2ZpfUcmDmjDeX85cXru97k+Ct?=
 =?us-ascii?Q?H6rv7B8IaGm3S/VTfY0V1BTIcefwkiA293RfHlD3FI6w2ccJVvaQXKiCRjB0?=
 =?us-ascii?Q?RYGidasNQ3vD4M7jWXwDEllSBy3eWrDxxEashu7VuzriJDbgZsHL6JeYfKfN?=
 =?us-ascii?Q?/3viY3I3rHBlgBdsN2U6QuzJR+hXIQZwKRUlCf7NZB1Oy+FZyw3jgjN+vgqa?=
 =?us-ascii?Q?/Mvc9XZofXkUBd52smn5pOzGRQSNkGvCBKnkKSk8w5xAkeQq0GCrr4+TKRUN?=
 =?us-ascii?Q?VzRRnZIg9c/zWbOKfcp8gNFE+n3ZXcWa1RTPvYuEFm/uyv+bIpoW7o3rzkxY?=
 =?us-ascii?Q?Q7qQdZIc5g8rZGM4oUOTimlyVNXiMxWRZRKBLOau8uBGUyLIv5GmQFQE25iV?=
 =?us-ascii?Q?HAf5EnoZwFvXwMbXCbRGuGkndhMhh7POShD1S9Jc0wj7XL37L0l+Dv+oe3SN?=
 =?us-ascii?Q?DHRvLOq1uXgx05eVk/UVhZCdhuiJY9FwZdjW169xqNxqhQOIko9OYQEY4MFW?=
 =?us-ascii?Q?GoVm14WMBZIxTKX+iVFgHYxC2xW3atvipALWcUt06QUK58fvR4MSxDnXMkmc?=
 =?us-ascii?Q?YOHfsMUu4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c541c0c-d7fb-47f1-e3bf-08de9b9fb4e5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 10:05:37.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcijigv9czNkCUkuAoUpXaam7GPQsjWIJ9qm1JbrUuXZPEU6oXuorDtipCUoejNm6umOg3Qm57YU2MZ+hywn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828

Hi Tejun,

On Wed, Apr 15, 2026 at 10:16:22PM -1000, Tejun Heo wrote:
> Hello,
> 
> Arena simplifies verification and allows more natural programming. This
> patchset converts scx_qmap to use BPF arena for all mutable state, as
> preparation for further sub-sched work.
> 
>  0001 Rename tctx to taskc for consistency.
>  0002 Move globals and cpu_ctx into arena.
>  0003 Move task_ctx into an arena slab with bpf_res_spin_lock.
>  0004 Replace FIFO queue maps with arena-backed doubly-linked lists.
> 
> Based on linus/master (1d51b370a0f8).

Sent a couple of comments about patch 4, everything else looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
>  tools/sched_ext/include/scx/common.bpf.h |   4 +
>  tools/sched_ext/scx_qmap.bpf.c           | 561 ++++++++++++++---------
>  tools/sched_ext/scx_qmap.c               |  54 +--
>  tools/sched_ext/scx_qmap.h               |  73 +++
>  4 files changed, 459 insertions(+), 233 deletions(-)
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git qmap-arena
> 
> --
> tejun
