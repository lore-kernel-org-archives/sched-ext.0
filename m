Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A34C6C
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759813588; cv=fail; b=Qdw19Y7pwDsJmGYqf5pmG22zFLXzY7L0NBhqPUUpafger1BHomCO38AScKCxnlM5BphPZLuiLqHPHrr7oJ7e4B0YyCC1bCYw0fIN/8B1P58aDP/jLf8e7Aek2mYqMpX0SSgy8wPe8FxELnCnTe7NUhvPSKq4iQuLv+lO0+Qe9OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759813588; c=relaxed/simple;
	bh=OEdHhGQVBkwaG/A5UEb2qOCgJGi5wiIIV4qtyGQcupU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CEPXlAN8XCDnUNJHTma1gfpNeBUhf9tc9mVk4xogv1RDuWT2hB+UHDOpoQK3ga7oYwS8UlTgaHxuxbN6MNa68izzhs7ucSr/vhHDy+ai7WuQhXqyyb1EIWskgLVOan8SYMXHaJ9JtsdrrBVpADAupa6WUkX9Gf4v9YGuXK+JRug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aQJK+OJw; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aQJK+OJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRmUiCVIHJBlJUF84/7Qc2YpvY5U6R2OleSnwt2595/+7krTnpkAg1N+JiF70B4R2ezFvR/CEKu/CNZPsSIKTi4ZKPIzMp2e3+w65AI71O9t7Tp9NnptjVXL4SJ3H2ONQxnqxiyD9dPmCG1FeF59DK4IMgdsVP0IKW8VXVZTOC7BHuSwTX46Zadb6fiZf2PlmP+A9TUcTNvHNewX7yowRJrFAilYKC+jQZYWiX48UDgc1aS/9waF9pcLUG01eO4f8Rm2rWFe7MmG7vsqMmyvoLHl5AOBTybOOGR0OfjshHMqxGwKl+/t1lLJmi23ZRqdZlijwaZBQFQafEhRfUrtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtv55+oznXO7xUMDngaNoHr3LpKLeKyzxbw2l5McZ1g=;
 b=c/8cPWD4A6vN8zdB3QmBkTZClIxJoMs8qqC8oIg/JpeXJPR5iFZ+dL67Q6LlPHpJbWQgqIjPtoV8RICLwMZ8cimgjOhd2WpBf6ao5fuRXJwsAIrnw5KsWsEzQ6KTjqCNtHYwo+UT9GYHGjLkfdqXU0xK2G7w4IKucUY7rspyfH35A98KI5kU88ge0VwpdZgMRLE/mcMMhhtYPcazaxWjzC/4Qu4cvfRBHosQa/nt3jliqAPD4FOtLkb4iPC/6l4Z2sx9PCDOJd58bWLaRFgtTsgMuBdZ6B7oPmp0gB1LJUpGmAlpDRM6AjJKtXMYqI+AD5HDG25XxaITJwysrKjq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtv55+oznXO7xUMDngaNoHr3LpKLeKyzxbw2l5McZ1g=;
 b=aQJK+OJwYHtiRF3yl8F0iarRkUSAlfiL6sn/ZRDk04HxqEaqiXYwDMvSmiITUcuJfopuazT0CL49VS7upPtejc8Li7ECNPfkJZzaU4tKK4pJrNPgQJzaIiRtkw6WAwgQNepjag9nvhbzf1Q6LJcv3KAFGzcuS2DWtiEa3iX1kXZHzOn/4CbxULC+hDIVbzEd9HTkAdmxeNyurFQXrtHquKc/qhb5n7Ap0CspuycKPcrwHWEXCl48xipI3Ih6WCoCB+64exUr13oSHjxpmn0zGIDEGE731I66D9ME921q8mTF2bxFRNco4tsXZZhOT2rMNq/nuSPOzlmir8yk4doi5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:06:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:06:23 +0000
Date: Tue, 7 Oct 2025 07:06:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18-fixes] sched_ext: Mark
 scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
Message-ID: <aOSfyDN_7RuGc75j@gpd4>
References: <aORuaIXJftQDMBIA@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aORuaIXJftQDMBIA@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 653c1b6d-5c83-41f4-aea2-08de055f4287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwM7eS7a6o/cdy+ZOvIUqelO6WRuNOI9YWquyJQaA1bqAO89V6uhUsOWzpAq?=
 =?us-ascii?Q?VeVA4QuFPsuBfum6GcQtGHl54wT3RCM6ARkqrV8xRAJbFOW3KKMsMPJwrFbR?=
 =?us-ascii?Q?OGIfvZYZAI05625NtvBwx9TgOVJ27tpjqg5yhyYKlFFeA51gVy/S7VKKYZ0+?=
 =?us-ascii?Q?HIrlHolJRmgwZfp2V2+8n8qOMLhw4Ns1hwcNLPtic1zjR3LNorWG9LkHO00A?=
 =?us-ascii?Q?0YgAZdFbXHNsYxFPfBrrcUjhn9BsgqcDhqGsGE63lldKSDOpRabAidXD2iE8?=
 =?us-ascii?Q?/eZB9ti5t4SN63ONX4sVBW73JUwR6K6dYe1UKA1eb4c9HyXaUTJHEyEMDOdd?=
 =?us-ascii?Q?0oBpZB+dsLXSR3AVwmDOxSAG5P9+SXMg92h7llV5Rq43oIHEfTsKVQ90CWnq?=
 =?us-ascii?Q?2VHltflKM+Ct0hXSM7ziq7JPCN9vNcwalFw6ZuOLdZ7Ts9nLLmNRqBcFF64W?=
 =?us-ascii?Q?lcdoGL2Qebh39OVFTxYxWoScJ5Pa6wwMUD8BIhzxVntr/MV5jBZ5Dsj1Ww0P?=
 =?us-ascii?Q?edmjUvgXOS7QT2kLR5xpIt5N4vyX1b3hNOhhLhZ8gDAf3LJHScnnmbeiFQhV?=
 =?us-ascii?Q?ljzni8Q2h6syA7ifYW9fNNn06a/Q1AOLhqNs/norYPdwPFKDmwf3V9C09Zy7?=
 =?us-ascii?Q?Acc3My+T4/8XqaNQRLO6R9+PaHSQdyItOBoLRPrZ9V7XPh/J9FUXtfR5WMkX?=
 =?us-ascii?Q?Rnrr+uamqLuYakOXEhGtxHofPoES5WGGgaIXIuwjp8sKDBH2HqUTJieSrqGl?=
 =?us-ascii?Q?2meDkOv5DH7DEnZEhvhVKt64xo+2d3rri2ccQ9lRi2RfTB6R2Bhjiwfy2wYh?=
 =?us-ascii?Q?AD+9w/ak2Gebw+2RT/zL/BrzI30a2QwRe9ee5KJpwvTHHGjlO8bmpJ5Zz1OC?=
 =?us-ascii?Q?qis2xYp5qQJPRhKlSWMvfqRvS8HPrWWolLJBwShvm1OyWTqux2j6RTcYDU/8?=
 =?us-ascii?Q?PN/uBnRMQxmjKzd2VbhozLpfvQjrDynBGAoXr3b3x2UU0mgB6du9TRQfGcRX?=
 =?us-ascii?Q?qrVkMtKrmusk9GegzadWCkGYS/YddcnZNCBFDJmdwA6j9V3yAQItIr75ImVu?=
 =?us-ascii?Q?GE4vu9c9kC8DFOjQyLB+A9yS4eX0Z7mNE9VEZCYS7S9giZtnj4Vl8VzF9i0h?=
 =?us-ascii?Q?g5wbSHEN8dJ3HcDVzESq8Zh+JqKIsU2ExEpuam4pd9MCGoCD8HfBspKbfvnW?=
 =?us-ascii?Q?vuu8n72bPTfW4C8QTtZp0/CbBLfa/rMgyzjudYC/7vY4L2XgHLqLGFrqcmrC?=
 =?us-ascii?Q?V3kh7OyYFG17W0hI7ZZZ2jbggeuvTG4FSOODiKQcrM5nTZceSYBRBN0impG3?=
 =?us-ascii?Q?fnTJ9GlpXjzOnc9oT+4Ye/iEwOX2ybuURHivyiFtjVrjhktHb0vh6fw5RFvq?=
 =?us-ascii?Q?RQ4v7Ki9AtNSmASjBKm1lYz9cztmx3LuSg7+AdcyFVF7qakI/Ylqe2PRcIY3?=
 =?us-ascii?Q?N5F0UgGQQJ8DM7jFDt7DSCu/bMi9gdAx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8k4kMeb5F9IpnlCIJ4xP4xQUy0nteHiBFHpTb0f14qgj2vWxLjThjlSaYdRa?=
 =?us-ascii?Q?fTqWXW6HzaSC8K8L0XGy+5EMkazo7lN3QSqnBvm2HpV50apmnWMVUPsfaYzb?=
 =?us-ascii?Q?fB49PVbCthZ+a2n2GOpuSqGTO3J/xabgezNr48sJ9Unfy0csss3SpKJtkJ6F?=
 =?us-ascii?Q?I5a9qfih44QR6twsZKvYw787F/NVcqLtEZ0/k4DddCJwP8HWDVMGb2nK4ZiC?=
 =?us-ascii?Q?QjMx76OZNLpE5VO4M971GNWuzDu8O8Y7vge0yKU1ac1TBGasSBvr+TiOkCaK?=
 =?us-ascii?Q?uLnUDYKqq7DNBq7QSvXeodI/vitgOA108NApk40kpW4ICvcgx+HlX1oTUpy7?=
 =?us-ascii?Q?C4KXROIWSvsZMwHhPOXjgKbF3W0Ng6sg55g70tniK5uV6e53YotQ20n/ZuNd?=
 =?us-ascii?Q?Tulu4Ibc9pn0kbuZ855LE8j4MdOG5/W9RxSCcPfUf+ksnH1vLSuTzXT846+U?=
 =?us-ascii?Q?AtIPeHYMLtyJjXdKFDzwu/bcdJrb1T7o0gMYRPFllrpnYBrC2Nc5abok4Qa0?=
 =?us-ascii?Q?RWRaNEvT1Q7B6kyAoyOgkcu+DhaLuu0t67gRk3wzJBjuelgyh6i4ohS4DxYG?=
 =?us-ascii?Q?QbUfVwbzHej5DstB/nRdh3pOff9uPVfaif5KLV5mMYTz5IUeMQBTuJSB+lD2?=
 =?us-ascii?Q?0PW0SgJ5PpBkh41OOrhDYPSeR0emM52zz98QPYHuSdh9lIZKtXEDyi1j5ArT?=
 =?us-ascii?Q?xHrWdlWlTkkG5IjcdJED3o05Fu1EHyA1QvITWEbzEmXjzXgilggLDoR82AZJ?=
 =?us-ascii?Q?7ClN4/OHIKYJ0nfgJc7xcws0Y3H8dswbl4nP1n1Q6xF8TZUqi+++xxqfo9wm?=
 =?us-ascii?Q?N9sy0j2D7bG+EljoiJz98NKoZGXAIZYbNoJnuscXnH2yZy2qYQL/CH2aC4PM?=
 =?us-ascii?Q?UBSI0WnvL3hsvHPQvOcNEeFFNJymOoiLn/S7ZtdacXOITKDh/q4zlanpnodG?=
 =?us-ascii?Q?iYadiBW5yKB9bN4j2VAQwxY2u3U9XewLHAKa5yCIuX5UOhZMoOQG2oX7MvyW?=
 =?us-ascii?Q?p1YxZ6jaX9SWC10bkWPL32eGNXkMvy8G7umJV6CbQXPOSjCFUFyl24nJfnNs?=
 =?us-ascii?Q?O2/uSVGbhoAGVsG4Pn6mtRQJ+QY35OizH7KXbVVOaLF+tBhxbuhBIbToe7M0?=
 =?us-ascii?Q?KnT7GFZmrHOWh+L69cH01wppg+nzrv72XUH7JiLoWYtj7ckT9H+vVteKOzjZ?=
 =?us-ascii?Q?wqQEM6uay29I2zN8kGTdAqLjUQKUkS8ttS5sEX/B+JY40iU7Knkas49Q4FKJ?=
 =?us-ascii?Q?8uqf5NjL6Lu9b3IDBfSs00Q31e4KOTfnInabc6pXLBgH9TPVVDHQQC9UYg53?=
 =?us-ascii?Q?CYv9dPrR2Tpv43eKPqXxBmPWmb7DoN/VXxV8ROeRY7MparSx8UuUwCOVxVWb?=
 =?us-ascii?Q?8jieX9IVWhTiK5/Yz10MKsEcuYYl6FbF+5fscVAT52mizVUSATWZIkzOL+Ln?=
 =?us-ascii?Q?shsn/S/vs/e0aOIaOU11kUCjKOq5IFoTqv59oeJrZo2rgb4AZw43d70Fpoyu?=
 =?us-ascii?Q?tfZJ9vXgPCgkr9ZiVdqqaERpxEW/iZAqnkNXnSe0k3N8b/sghk21rH5OdgYt?=
 =?us-ascii?Q?0khmJUPIJqxQNcUL3Zf3hmEy5AgRSgl1fHVs4UyY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653c1b6d-5c83-41f4-aea2-08de055f4287
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:06:23.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpqUPS77SRBGHWzeMawY86pemvlrAK1nJXtUGbzf05sKDWbwzg9k8XOrwtix5Ayc+kvBeWshqi0qdVG5kBPpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On Mon, Oct 06, 2025 at 03:35:36PM -1000, Tejun Heo wrote:
> scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() take a DSQ
> iterator argument which has to be valid. Mark them with KF_RCU.
> 
> Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5688,8 +5688,8 @@ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
> -BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
> -BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
> @@ -5820,8 +5820,8 @@ __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
>  BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
> -BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
> 
