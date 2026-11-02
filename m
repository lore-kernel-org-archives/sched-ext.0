Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617932;
	b=3qKWLl1iN8JcCSkm/Zr7D20LlNtBZk5zwabK16ocInp2dLnRG6+EcAJcNaS76X2RIs0G
	 +zjqSszm7y2fndtFfgAVPJaU8zRcwhdQ35OCxn9g74uK0005u9gJHiCCx8svaPWKYVn0G
	 kqxaeNG0h2nhulNyBaGkgFv3GUjtJz2GkMh2/Jw6NbcrTOU1ViZVVBEJ8SWlOJieGEnJh
	 FbDGvoDnZJWfh72SbGj1AaP8irLfjByK+jcJP7M98Zmsba0ZHOGR3AwcGCazdt82PzH2U
	 cnbGpu6Ojg6pmAviwAY7MYZku7JBgIT9j8zR87k/kNzjU7RShuCNn1xLgtyjaGGnKWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617932;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8pDTjSsxM5U6Ulfu0iqVLLFejr/vVLquSQNs6jlRCNI=;
	b=oXj92ElHWepV29nz0hvRHMPSvuNiMEdR8JTVop3PuBAJPYbxlZmXOl+cbbgAJQ/lzK+G
	 rCHCOEwtynPIoQCRTYDPftOScdzI1+91LV8yLHRUzSItpfcjYTIvJKs000IPlTtfZ040g
	 ZgOWMM60svUKu4O1bazP/NKINO6Lp7x8dAKDUBgukHD1EiQ+Y7MfOqhs4XlgDMiFkiRpH
	 HQbWoRdup6jQ6DZytaGWBZRTMa3HqwUbKn4vXdRfgVWGdcizZhzT4Qhs6uM/aK+BV35zF
	 Qc/RS3oJrgsKQ7G877kbjn01/hUzgreL75a8FdOvAs9WxXU7+a35AqZJ3xRAC5zSFzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TqUsZKRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1E606A326
	for <sched-ext@lists.linux.dev>; Mon,  2 Nov 2026 11:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F1E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TqUsZKRz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXTWCdc88CijbBwsR1SbGDTOBDndFfrXdO4zlFWchh/mTenfracbjQ9jqwNO5IJIEdJQU9S+Qfvgd66tRK+fLjvaPN9lxpU3+GnJkjG8nHMIZ0XhHZ//dLfZy6Mo7RoJNMdtsXmk+aTOvrBsasOZ1dTjdhGE6CuK+IGy6k1m0ZDE5OqUiBWTpp4YIkHhHHilcInO2zgSTfyXTShm7ekNoyvgdRAsi8B2a0y8imyUk41t2JD3HtzkfO+Hl4I9Jqnnp4xTxnjkTL6efK0/joLsrW0U8bFD+3aQhb9ZGpKsDXb8mmYC4LAw+VmpD7NgV00z8Sk8MQvigW/FZ93oz+OvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pDTjSsxM5U6Ulfu0iqVLLFejr/vVLquSQNs6jlRCNI=;
 b=uXYN7kV9dGqiB9JbpgHzphC4HJ+r/ib+jaezReEJoT2+bgaSd8IqJb0YazhFE1iIjXP68Vtp0TwPFaC2vTegqolTI6V8rBcM5AYHpVyaErH7Jsg99hgDaes3GNQoRdJ7uDWsIVWSqNumureS90mBXWHJrN7c6zc0CwQh0BFFVKDmc+HIRT3Lj7Cm0sjhXFOXIBzela9D/e7TWJqZBODN4PV4vZB6Fb7C4BqRqnLWpPwMsjYb1HDeCFRAGIzQ5EayIPKNMVqaCTDzaczLbSAKDWcJv8U619MET8T4ETAhDjeDi4ZMCB++lx7J+ALC8Y0JoUitT/Dh7djeIwve32oJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pDTjSsxM5U6Ulfu0iqVLLFejr/vVLquSQNs6jlRCNI=;
 b=TqUsZKRzQyjb4j8E/BRgpnVWVzfmvd3bb9lJcRHK9XesfJ/UbkZhkE1LObHyGF5jRy8Xsh1E5twI0ZcC8tbNitgsdKQ2jqUNzuQ6ewLkXMIFMzKYiWjgko7K6Kwid/qS3TsJNU7DSnroYjUYpOq6k8nE2hGBgoZOZKFDHpkzPjjI6V7NSMnswJWSVl0afsWJoB/5jhfBsMIdh3LNXsyRq8YUFFO+8a67cWOKr/7yJvyDtZSckdrG6TCqxKusniOZW2RKPe2dWI3BuofYJjD1lZSV+DWfDTbF0MplVkswJIsTLcMqN4oCks7euf9vR6/a+wevCxh16zzczt3yhUkZTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:12:06 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:12:05 +0000
Date: Mon, 2 Nov 2026 12:11:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix
 ops.enqueue/dispatch() calls before ops.cpu_online()
Message-ID: <auhv_Jdir0wpi3fw@gpd4>
References: <20261031170541.710939-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031170541.710939-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb664a1-b591-4651-4116-08df38d220b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	rgtZ3HgvpUg6GKBSHA0mNH8FoUO3Yp2NpztHaW0mCD18Ic0hTdNZZsoF3sCM1Ol5R5/RPUlrMwB+JqjNbGhLJEDdtwMMteOY+HLiilAN8wAt6cww/DNU3IZaH07orC+UxpJ/xiMTMP1bp3eOer9W5/ZIrR79FgIpISjFbwvzddJ9514ujflfRXDb3GGVbpFKKPP8Dks72SS4sSrBBcvrMfKAqChkQgHVKgO0WqFc1Dzn5YR1nLgxJ28t5TH7dDd7vJmWTeOQ0jOV9bmqzn2HtPcvMF+/28Gbo8Aov4+uX9le6TgHdAVsEYyiCz0QLkNHNk++2ffGrW7PQI9MPOytFyCOPLYtOL38+0BXWYJVbGUpwgsowZVnrAbpReT0WlQrHei3yxPvBMYuEw+N5rnQtAcIe8BRSM6zfSUsPtDwIBm8xc1I5T76Nk9DpNAszQn0/ysueUxSKQ6lcJh95u+84MGayuiWthj8jBtYLWLaqvOes1BUB6eR3y2fQGYZfH2th0lDGawG9zf8sINABEJt5jbqNUPtGronM69DDjbIozUAicLRRTrI1jYsZT9YJ4t7VuIee75y/GwIL2Q7t+OP3yUarqbK/OL9EScZUe+0I/etcnpfASPegFca0g87wc+Cw+WNne/6zHl63iv2MmFfCG4gWCMnxJ55spGO1H+6flM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omMzqY5KAWiai6/RoH418vIB3Q1s4XUMPIyq5JYW9lzDqFhwA3j9H53g7vqD?=
 =?us-ascii?Q?azdnEDrj9q/xDAc+dBUkQ91VAnkYKyrdOVZrMmEr+JGReqETEQNlctUlWiyE?=
 =?us-ascii?Q?eW1qw/L3jDNAKHYtQzsSyiuv/4r/f4unb1ED8LSC33ZP+G2QAQ/CJXvGG741?=
 =?us-ascii?Q?XiyX77OeVExIiazGKqG7sAT+6KniuZjyip4qT3rN2kuAGD4zB7Smy91agtRg?=
 =?us-ascii?Q?sTopuQEmF8DqfhXvXK9fupYtrDBFuz0HP8xWp1U59rrFtXHdjOS6TZhiUQxx?=
 =?us-ascii?Q?G0VaP3HjDWgjJ+QsyojIN4r5OnBQOzeM5SFiF9jC1nsoLJAV45gJ0422+MYm?=
 =?us-ascii?Q?11MFQTWzyXpop8qTiWCYVHEzV0JHhxhf5SGXJFyJSf8E4VNO+JCPdaI4kxWM?=
 =?us-ascii?Q?Sb6WdDEmoHhx+KD5RKbCV0+Aso0Y6uhtt/JHJ1mxJ4Lda9VNQjLpWFdhVcRz?=
 =?us-ascii?Q?FqKEu2pFvOm7ScmZJ3aLiGzLpRsDhCPAcG2eTlL+lMxWIdtgq1aUBHALiMad?=
 =?us-ascii?Q?YOugx4vV3gviw+yCN+r0ym1d6z7xvAYqmSFyuTIyxTp/8m1FiRXvQ0pPgGS8?=
 =?us-ascii?Q?fgcKNDSHfh+HRyb1f0CT5bCQrRyN6dDlt1cWCuV3Q+9qL7Mg2JnOuacGcI8Q?=
 =?us-ascii?Q?jLfW4P6BZgX+vDCg2e8DYJYeuAVN50hNrC+mrCEjR/Z/GyZ5hmSeKHbo1DVz?=
 =?us-ascii?Q?6CSIeitkbrDhFm4ih0uBQkr/1Fmaam1cFeZYDCRJzCiCCwf31UFeBn+DTzAP?=
 =?us-ascii?Q?Z71b6OCk6EnPliLpzQJrN8g5QEDcLzWvVnyWOQl2A7Sd5QHhsksdGvuN2J7j?=
 =?us-ascii?Q?SvxYzQ74H8x+AX7+MClf0WMhiidI/lXKr4E5UqtN6La7RjAizV88HTuFc8S6?=
 =?us-ascii?Q?7x+WLvIUcUyX9ulZlbrdqQLQCngJ9wlJFtvOvtU3ARAw3O8IlpylpDV7UGYm?=
 =?us-ascii?Q?5yajuBwEcU27ygk2xi0OppNKYT1s4OgjwPUHUAA0HW3FiK2tyBusSbKAavOe?=
 =?us-ascii?Q?Hwvd37d0g9PKX2dcyvP1cWOCFsqu/2aPk9r7kxYR3tJ7HRLAWxHJYUySfFK3?=
 =?us-ascii?Q?h+gxLv5zZevFUAYu2BD2M+z3UWfV3hDrJXXsvH5TDYljy80joUHjDtDRkwpA?=
 =?us-ascii?Q?Atqr9Kd6rcxrZoeoQ3SbE2Hcebu2Y9qcnVAgtIqVc8QaMx3/py9FCAfNz7At?=
 =?us-ascii?Q?2ymGhQ2vA67qgMFTX0zR7L1Ua1PlxPT26477bfaIUvWLIb//CnLdTEogUpf1?=
 =?us-ascii?Q?OXv0QE05UmrO5LpFyeEbG0sSwh+0OButTseQwpcfe3Y+oSPIanBlDB3kZpUC?=
 =?us-ascii?Q?CyQrNZ6n5njlQGyKutLPXlWbMCHEj1LSIDJKtCdXHsR7aTdttUE2UGtRxccG?=
 =?us-ascii?Q?VU76IkSrxOrmLG/0IMqzBwcMLzaKeWcnxFWCMAcem+NMvndeS+ATyrwFXq+i?=
 =?us-ascii?Q?s7liJEqEyv+bPfzuEWz/G5U7USR6s5NXJmZrGYhK3uI5YRD4nKg2jlqbIPY2?=
 =?us-ascii?Q?GdtmCxc8aFKThBafmI/jiLblJZxoBYFHDTNLtuzr+r76bkNJFU3P3V7v5PsX?=
 =?us-ascii?Q?qpqCmZvbM4oEkv5bZ0jiHikbR8N+2f4vf9yDh7qkTbPRH6Dj3o1zNvYcSSO9?=
 =?us-ascii?Q?c4eqOd3/HnWLCCAg9pOu+ITXjQed/2dOks9w3NTl5Ez/FF6Vx+NZRuAt1/J0?=
 =?us-ascii?Q?Z5p70bK23582m9t0N70gB6zNHKKSg5nmnGe4O3+2wvK1yBP0kvfOnWI/bHsW?=
 =?us-ascii?Q?NtQdObXDuQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb664a1-b591-4651-4116-08df38d220b5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:12:05.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9k4fHlE58tefWQVchzaaw9R+pjwRp9YiLTDC+tQdRHIrX3TL5gsLqOXyG9rBjy6VsI8ZkHDogkqPPq6CaP6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400

Hi Tejun,

On Sat, Oct 31, 2026 at 07:05:39AM -1000, Tejun Heo wrote:
> Hello,
> 
> This patchset fixes ops.enqueue/dispatch() calls for a cpu before the root's
> ops.cpu_online(). Both ops are gated on SCX_RQ_ONLINE, which follows the
> core's rq online state, and on a runtime cpu up the sched domain rebuild in
> sched_cpu_activate() puts the rq online before scx_rq_activate() calls
> ops.cpu_online().

Both patches look good to me, I haven't found any issues.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> 0002 tracks the flag in handle_hotplug() instead, set right after
> ops.cpu_online() and cleared when the cpu goes down. 0001 is preparation.
> 
> Based on sched_ext/for-7.4-fixes (0aba89317f38).
> 
> This patchset contains the following 2 patches.
> 
>  0001 sched_ext: Factor out drain_offline_rq()
>  0002 sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cpu-online-order
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c     | 93 ++++++++++++++++++++++++++--------------------
>  kernel/sched/ext/inlines.h |  2 +-
>  kernel/sched/ext/sub.c     |  9 +++--
>  kernel/sched/sched.h       | 17 +++++----
>  4 files changed, 68 insertions(+), 53 deletions(-)
> 
> --
> tejun
