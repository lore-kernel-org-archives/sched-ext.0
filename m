Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35244CDDC5
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828680; cv=fail; b=jMG7uOCnQY+mv3oY8cOQwT4/pxu5XxtGDNEttlH2FLxHEJ7Xpg+huEIlssZxRSTIaL/miGrXX6tJkfr0KS5MvYzPnr1BJJDcEp6V934PLw6F4mY87ss897J3+qhYSSDSiBzOFcA6O7iDZaIl3TPTYWGnLtceOzJiKcG9Re89vbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828680; c=relaxed/simple;
	bh=SPSKzsQSUJqdEjFAa0lySxmI5Nqu8yoxe4O+fTm/RIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/LZCZgJvFwqhNacjaiRgECWsvHDGtc1vZ+kPkhI19I5zDf/vm+/WH5P6DwLguq1RbnldUgoku51UwASDQ1i4Kg+9Txc0A66GFUnr+4kOxXfOV+IxvkYBPuZewbHuhs4ENlP2bRaCqW4+IV5JUWQ85Rtid6LSn3wHsQYcc4Qm7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDcR9HyZ; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDcR9HyZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgOX6+DVAJMW3S0JBAVd9jcxIMRKC7GZnPZjTbVxzmh/ohknjmQiOF2BDDI5GRLHacFTx2O331aNWJ0ZmN/VTJAougCXldibTF0UQ6SmUitI/QIc7yhHE8HOWIMDWVIt8jSFmcgZrKMh04DAi7tShXoJB1MB63MquDivmSitEAY6m3+OttuROYDY/ez0wEM7jGxU8Abg0iUBTIOWIen6khzzfBbimNBEECp7156Rl5iZizPb6IWTdp0Ejo1RWe43qNOYWlTjstLTqLjpBA2kcq7jpDr79wg10uAmyLKA1OyFYRFADpH8LV2xSy29YFxZ/I4mBEmJn7zaf6NMjs6+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1kVCR7uF65Af5axbq4bMyFe4DmNgP0Z+zUvSe9tYYg=;
 b=eqysSxZGAPR40L8QBJHBNAWy0zqBAPodlc7OnlRkkIztJliSdgO/JsmoB64954PhAUiXbMcf1r49PTq0NaY5lnCGgSl2+v61yq7XrMd2hmehvgsaXutLmsdJEwSthvUGPigxwge5nPQuOLT3UoxcyAJoU3Go68yuTg7TQn3tEBnl9S21dLZEgyVDp7ycrOpkHG9bDVKEl9VTB/RihuSgb713ewBY3xZ5zItR5dTLuZlhbBER0n6uR3WHsXqCmV4vp6nsH4D7aLSSljt+ZggjBbRdzUjK7QSwlHJHfHYssO+O3diF85BwoejXF0+1dshOveARmQt6LK/BesJ9OEquxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1kVCR7uF65Af5axbq4bMyFe4DmNgP0Z+zUvSe9tYYg=;
 b=jDcR9HyZ9afa3N4KkGylnsoaOg8bpSAz93Ab9HaKJBYPBuGL1tXQBN8bMZOInM2KSxcbT1OvTqiiEF8sTlhj9gv0MG6Hh9Dj+TIUYdchVSfACK1SqQ1x5IImEwlKFtVeY5thQ0gV71tti59wIZSPwaodzpUbLi+kF8fo2OYmyDPceXm30l6hP+qLkxH4gB0unQ5DGErhLnxAjgUwoju3QoQdroXW1EBydRJvu392DSo/w5irU9ylcKBEf3P27jUTItjD+ng1J4G2mhunAZekPurLUsk6LDMKrWy/wYK7QRPcEHnDcjQ2HPdwCRCuIPoE8/SptGJnmFgsa3qraypmOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 18:11:10 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 18:11:08 +0000
Date: Mon, 12 Oct 2026 20:11:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass
 propagation and the bypass dispatch claim for overlapping bypasses
Message-ID: <as0iuDUeWBPiiDvJ@gpd4>
References: <20261011214028.743546-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011214028.743546-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: c76b85a8-edbb-4d3e-3eed-08df288c3034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ozq6l97BnRfXP3Ljh6LMgHDw/Awa6TTJnneJtD9SWza9o2xZ/oNsEgsAiSDsVB4Rf1bBQvwiVxPkuKQmb72aAMVprouncFuaZMmcWD9EDecWZ3EB9OHVbHGJmSHRahjtXj8R6t+w7zS5B1pG+JvxAUTrH9r7x1ZeBNG9vId05PkdA3umjVY5GH73LKu117O0UROGSnBRHsfKbvIun6mcSJIBm7iPkOFqtEMEpBpd2O4lh+hMPFm5DdgUj2rXK58cRwIYO+gMuHMYtzKWQILXFJYuYQ0CWGKLK/uA2pm8c3rG+I0+PNxsQVE5Jjdo/vwHWS+HQPfjmd2tS0x2gWZPSg7EIh58JTew1q2S6fVv+wvjPQh70Rho654y+S4kAteO7ZNF1lphnPRRKaJUuLPtbdVtboL6BvHjhG0Swy1vn9tP5uhilnvavSUmmG0T0AoVrFQpXeTGgabtbnABHBhyafSdSkz/FGYcxaGdg9YeR1DmYacU6DdK6daOX9HvHhoGH/THO3FQqOpBNJlgASTGRwYtOIyR+qj8kLZowMRIVgQZSciAM7UAXJAoMlZaBsaqb+tMgOGr+pT143kV4q0XQqmsDziI4dS2xQYLXvKkYeSFfIlgqaMLvu45mstZu7/x3ioU+uwIlQdzDFWVHKCI8yqhNECeziVXqFn9BFOi0oI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?koCi8JTqv9NbbX8hG3maKn2AeS0qL8FPKSSNvujYK4Ev9Ha/Dp6pDbuUQ0uH?=
 =?us-ascii?Q?jz5hHGHrqfTkQ9Zomwhid/2aw39nJWmHQ7MPuXSMTy+MLwHKHgpOUgns+JXV?=
 =?us-ascii?Q?fX56CImGZgeN84QIYit4iXn7XoZThfQM0DusPa+6Jtg6uyX9qSaKRBqKp++j?=
 =?us-ascii?Q?n1hy0iHjleatI450Xb7xXuXvpfDs9iHgh3D34j02W0dfMZEIpS5xjA5BKpfR?=
 =?us-ascii?Q?HJ0wkG9tTALhyAmyVzbxiD8VZBLo+ftxhB0Em0abuT9/jKQRas5Pn/EvDNo3?=
 =?us-ascii?Q?KqkbAq/6wTDLBCCaV1eFLF3yQqIBTvqh445t6T7yJigW70zPAgTv6c6o3TwJ?=
 =?us-ascii?Q?iV8ytymEgZQPUoqTHGMX8Z5TQrQvasF73j4hArUQdPyZR27bzk1Ni4c0ce1V?=
 =?us-ascii?Q?Uk6RilZrCknGskPAs90XtQAAp9FfYmBtQyUoOLFiOtPC4StmOhU/NHHDatPT?=
 =?us-ascii?Q?mlOFyOfQ5a6qKoR2lI3qhA1wNJHqiqTaPjVpCmOjiFrjk4IpYed2zP7d3wlH?=
 =?us-ascii?Q?Q3JML/NGI3fE/X4HODiIM3/H4pPaukCInSwQCpIR5bxKVAlfNtJjt47CgVBj?=
 =?us-ascii?Q?IfMleAXKh0UgWI4P9BWjmRSthIXAf4QByMFEi93On1XvwDiJFhZYTLP+02NL?=
 =?us-ascii?Q?UDMBOaV2vrJzZ2heOunZx39eefR2ks3S3wjM3K2obBwK8XEtyLqqe4w1cD3z?=
 =?us-ascii?Q?l5Z64m6f5FuTQJzt5e4fk8Rj4EcVwlaM0nJkDTJgev9eKuqJyRhd35m96+CK?=
 =?us-ascii?Q?/fBSRUmB+WYtlptSutWqMAGrV00PKXPTjHhJRdjIihdkNL8K8B7K5jyUO6fx?=
 =?us-ascii?Q?l4dnlqgM0P8tWaP/WM3TaZNEU8OHmD/JYsYYUxB8lNuXb01dupCv3/LdfUbU?=
 =?us-ascii?Q?VaHsHWOx5KuZOxggyX5v0GtN+VCv5WiI9/VEl3vlsm5XQwDvgSUzIJ36hY3L?=
 =?us-ascii?Q?2l+EPOz8Utg479t4q0pryw71IeSVrdC4GNLPCPobYTgwYz0Kros/3qW2EvOn?=
 =?us-ascii?Q?R6JS3P6BjEEqjxF2mPG5WQeXjLyYaoUBz91gCpUSy9vLucIYYk1Xv0QicPPz?=
 =?us-ascii?Q?zrILPUnk6TRnYnxrF7lH9Kt/Ez96ibsbQKyctF1qys5I9+kHVBtJyPaL3VeP?=
 =?us-ascii?Q?4VobnjGnAM9EL61szuVEFxGu+OEsHNCWXB3ka7azK7J5CNSU1zP9qlO68puI?=
 =?us-ascii?Q?ehCneBxikEe4awBe0oplIPG4Rn0sj7+aHm6kaeD8PC/hQzH3ThFYI2MOGQbQ?=
 =?us-ascii?Q?MJLxmOFCcM+g10EJGRTSw1pDtKCW5w+SRRtdPYIxCclh+AfPqyxjYB3VEnyp?=
 =?us-ascii?Q?1LYGHO6jCVUzLh1u3Qyjy5kFmWg7KYzqHTGDwX1B9ifXDIo084Gi3QH+zFVO?=
 =?us-ascii?Q?mjvEf7gOQ6bbVXnr/imvuSSymAtDI1G8LKIjCT2Il/zb2MgTw9v+MP+ZRpcm?=
 =?us-ascii?Q?8ZPah8yGY95Qmrk4iFJPCCbZ/wz4/7wZZF8j8vopo/AUhuGhQcUDzE+IUz66?=
 =?us-ascii?Q?hqDXFAxm6n314IEjKsOKgmeb0EguCm56wBsB0S1U0EnQ+eZNtfq8SuUbp7Su?=
 =?us-ascii?Q?DKdL1F6LiVdCRmoYa0fT61WcdEM+zuu3DT3kLpyeBS3w0TWix66ifUfKsSkQ?=
 =?us-ascii?Q?57s/emTZprRENkAjga9RzbFp6paiOroRL9g77lPp006EjYD+jiFMc18NwFWT?=
 =?us-ascii?Q?0KKSg49WUG20wn+AeLrP/hvhJLvea4IjU8S9a2G/2XTCnhUc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b85a8-edbb-4d3e-3eed-08df288c3034
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:11:08.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpSYpdoEQqY0S5BJAS5pGsrnXZ3WsRIEfXrjY5Uh0aAsRNj/Kd0R7KEsa16H7LEjdE/KFAz+TLoVj2zBVVa/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

On Sun, Oct 11, 2026 at 11:40:26AM -1000, Tejun Heo wrote:
> Hello,
> 
> scx_bypass() propagates a bypass to the descendants, and claims bypass
> dispatch on the host, only when the scheduler's own depth crosses zero. A
> sub-scheduler's own bypass that overlaps an ancestor's then misses both: its
> descendants drop out of bypass early, and its claim is leaked or never
> taken. A PM suspend over a sub-scheduler's enable trips the WARN_ON_ONCE()
> in enable_bypass_dsp() on the next bypass, and one over a disable leaves its
> tasks on the parent's bypass DSQs with nobody consuming them.
> 
> Patch 1 propagates every depth change so that a descendant's depth is the
> sum of its own and its ancestors' bypasses. Patch 2 claims and releases
> bypass dispatch for the propagated descendants too.
> 
> Verified with a debug patch holding a sub-scheduler's enable bypass open
> across PM suspend cycles: every suspend landed inside it, the unfixed kernel
> trips the WARN on the following disable and the fixed one does not, with the
> sub-scheduler's tasks running after each resume. The claim protocol across
> the PM notifier, sub-scheduler enable and disable and root disable was
> model-checked with TLC, including the sequences fixed here.

Looks good to me, for the entire patch series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3-fixes (069403dff337).
> 
> This patchset contains the following 2 patches.
> 
>  0001 sched_ext: Propagate every bypass depth change to the descendants
>  0002 sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-claim-fixes
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c | 54 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 21 deletions(-)
> 
> --
> tejun
