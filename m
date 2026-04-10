Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC323E3C4C
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842737; cv=fail; b=Sf6y2M8V+pehk1wFA5ili+Ql+ktCXkgEjOohXxnvnVj8iERgUKQATUME7xVEPk0mz4hWJ8QptFt965+N/k/lhvptTYMzJkSzjFeLPIX6zqSfbpQEx6otAykE62t+vr3AFrtFwEn2sDVjk6F4jBCVKEmHdHGkkdeev5uFgGaeYp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842737; c=relaxed/simple;
	bh=xedAQAD7f+SVWge7JsEIc6sSeylg3Qw62K2pkCSEWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2fJfU2fT1RVyqKQHVyEcG4a4BCzu8Z8V/JXPwK9z8zE51btCEg3c3p5Gwg8AExoGs5u6P0CQ8ALyFszLxYlxTtaV5KhPflxDzerVGdrvqMNHGMpcW9iOEIWGvJq/yHKNgkJTnfy6iFihDPDcb/T0F00AB9BnFqbltvr/73UlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwRtl7GB; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwRtl7GB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKiprtelmFUbBL5+SzcZEYh5X3Np34gO7DOQ5WL1pwZfDOLTdVf2aspCtOK8kr2R2xeB1IkSoMg085JWK+Rox2gk6VLtVHknLjsNZLtPdlO0MRA3lV6VAc6lbqyyHqInne88Sp+Kd7X4pF2RUt3V8aIyIXrCT+nx/is0exI2jFvoYqc8w3ptjUw5dIbh51C5bS/5egmZDsWVKMl6cZKSYQz74kXu3A8VOXz9ujmLDQTKXA1NeHgxbp576Qr3n09pevbUGeGHOMR8pN7/StI/vNERWcptTEY6FDVqAeTeseNzihZxc4QgKDCw3PnLAmT7EG6CLGFSCP4Gz7A4WxIQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nandwjXUOvusvDOf3EU5wTnNXyYg6kaOz3EWCfb+ENc=;
 b=pUE4bsye/TTBHIR1wMOUg4VuXIFOiBMwara6xOraGR2t7KRQLitU5PAcaB8F5RSWeMozv/PkZ/AO2v4Z4ZdGVGVG6HfoQSEoYXwpz1BikMEg9bqEdF7mQwr+l9WMbBOSnbaebhRF4bOb+y8/C65AEvOr6ThydfjCluIWwb0Z42eB84G89V8rh475pb4slxnIsW8HFhMa+fMQEm1HYUhNAHIxeIKgSrJf3vG0n/ehB6558sBP0rum/mYTZ2gVTs2f/EzLrOs0CE0iqFLJPIZ96BL2smGIBliHzpFehdGs9aSmEvIBX50y9W99FwZ6dL58QSPgRlIViz4j74yBDsTzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nandwjXUOvusvDOf3EU5wTnNXyYg6kaOz3EWCfb+ENc=;
 b=nwRtl7GBDE20nY1ERsIHacafIjAf5gbPQeUreIprWSMKCIhpM+xhBBfVbnAV2g/FAPQI1Ntsobij+ohQgD7Bn5eeNe9BxsFsvjXCRtYVBSTVN6EHLqrV8uBFOHLl6vjZTI+7QuaTjiL/oeEfJ2vc2GAT5wUbW1k5jkxg8JkdutXXDOdZ7y5drjhtlUlWaKdvrgFcARIPY9PEKeEd+Uf4Ob42VgvP+qqiyI7UsyNcKWsbNW4Z5WrehtTRtQLZ5c7umybY6TL6aYivoNpByt+iHBTLB1EGSIr7dGgWVYsaR9JOHvfDqgp+JE0/KV3HrpYrK4/Sr647K77hgeD0c8gZfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 17:38:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 17:38:51 +0000
Date: Fri, 10 Apr 2026 19:38:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] sched_ext: Warn on task-based SCX op recursion
Message-ID: <adk1ojwzqRNFmGEq@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-11-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-11-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44b) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc595fa-08ff-44eb-02a4-08de97280756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y4OUChstIZ6ns6EeiuGTKN6ce/rWSjjW3Y1W5/7wMbC54aYpK3KaDrkbOdKgSgUJ0wSkSxDj5g712UtzRcDTt6DUdNoC93kCE9jcmhJbBjgVxbyYE7Z+AEUYDMjPaqDfh/dCXpD6B80bJyaMnSbYiAn/D9F/uu6NDg7aCuY6UrB6TuaAadr2PZT17Y9OuH0SgOabGzez0YAniMMa+eNCmInsdNK6skWZWq0f5yLTIjT11MwdDUpaIN8Lg9sgVquMK65i4YbLdNtIfwN1QbPqYT8KoVs5X7U1+4gogO9Mi1sJMxiMtWVkvhh7mGgLQwiuxjMa4d/XyhF8pIxj7CsvLoka5iF8xsgad3U25t2w2I+mVub4vKI5P6b92HlXHB/zxeFcLI/4uuNqt9LoF2jM3xLNJA+A3PCYIn3aSlONjMDufhM7xYa5nEYKhU2GKsUhngy+e1K6DbmxrLkJU0PHNPcfjQu/L1VsgwkoQsfwPAyxdIneDjnTxZGf35sqOMX9xWMPxewiCF9yivarY48lr/GCFdOVh7YaZQQurQwsTPmrMgLhq8uq3T0m935mACQ+Ti8shkghND5P0a2uzBn/ruUWU1182WbnDc1YEPPSaS3zsUVW3zd+6yNhnJ5lxlasU+0xD43D5OwmeUWUrn3qGX4p+WEzvH9i4CK+5PMHUIQOFYsl9464fczg59xxkMmAHWoiTkeYWKiVaR2e/kEf4v3TtEs5Se/URE2UXlYws5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glQ5NeCcsIjqnvJ8gSYgUpzone6tGymCLIyQMlE4FU9tl/2Hthi9mkVA+uA/?=
 =?us-ascii?Q?tmv6rwlo2MixJMacP59UiwDAqpyOe1JMPeJu1Ft7InYmo38H777ZBaMPwAfo?=
 =?us-ascii?Q?kC1PySxcYvnnbjE70XSCrJyUyextDqiIGqsVHnrZsZAiqebKx7i1bReWd4Vo?=
 =?us-ascii?Q?xTXIJeL1zy5BfAMtEhxR/rSmkjky/C01J9lXsm80ylNdB9y2yIc/VKWB4qdv?=
 =?us-ascii?Q?Gw6UygFCc1VTqqZJCyrMcEqVRpE7CZnssnkJddmutGs8KpGiUwe3zcNZgIOW?=
 =?us-ascii?Q?fpV/aRPzeBXsKfPOlef2ncdFIHYPLr9bzg95czSFOKHCe5nNlFAoeZsCR93g?=
 =?us-ascii?Q?qIfQsVuV6X1Nu97dxWr/uK51Ff8Ye5zGEHHMCF0xNsyMLhTG/fKrvEc7UqxB?=
 =?us-ascii?Q?d7lLlxgn55b0x87EE78uOTksHlS43cYhnNZfOog7ocn2F00txfP8i0IXYesM?=
 =?us-ascii?Q?t2JB0JA5MJbyfAGB6hGk7LU2tCEChF3RPg3oQksD3TkYSqeXk3c9AN1eKDyM?=
 =?us-ascii?Q?eU5FgyOG9rqCqFjWmsZKNRff/7iLCgOMWjOg3UtW+enl61Nxrabli11Lg4pt?=
 =?us-ascii?Q?I4kQriZSwqX/f90j8M6XwtbKgw207umzd0pzGcm2/PNsiFFIsa/uFAfIYTaw?=
 =?us-ascii?Q?mRzfQMBT7C9x9VbT6k0aLzDmUqVJjx+DXjq3mBjw/OHiLoS9kXlYn3rZ0dWf?=
 =?us-ascii?Q?YHtv7YQoiyZ0PFwUb7bMr2r8jdvG1T6QdvtAYpyga6VHPeLuO66WBDlUulwU?=
 =?us-ascii?Q?QOC2c9UQmb55hYpgqGQ+TzP2Da+PAonXrSbAw97VhX2xYgZLCNkgyH6up/zt?=
 =?us-ascii?Q?oKkIgq3DEWyvxnL+NZfExVNMPpPfBMJX4KNtyxgENIeS9OVMlUmWzagJQpmg?=
 =?us-ascii?Q?3a4uX6m97e0u/G4t792xFMkxh6zIJT/zOCpcwq/1yzb4vTUPwLyE38//b6Nd?=
 =?us-ascii?Q?Gdj19+esGCzL+nT702TAeuNG6fIW1S8Jm4cajOQxaQbwvDb1uky/OBdBDYHf?=
 =?us-ascii?Q?8Ilc9W8iqSJU/no3Ko49Ui0LG+BLfybFeJ1+kyEdtd1u0ix+5ryNGqelzBdX?=
 =?us-ascii?Q?rROORoqLgXlc0NMAFPNQ3qy+2bFQDHKuCDoWPNH7SiO+WxsAx6bz/juMxN1i?=
 =?us-ascii?Q?l420/TxDR1Y6rBPsDFpFQ/Pj3Hq5ZinodrDoZGyUitHGtvJDU7rDunRE0KqH?=
 =?us-ascii?Q?sb8Epskb3OVGWbf4uglgbB8dqnYqe1uA4BRwJdGC6iE68ZZpQwAnc1DU6aAA?=
 =?us-ascii?Q?6xapSVKgj6clCpMllMSH44EB+mUiQQIhFTQSj2dvnRi1U2D/dqpNCAoo/SnT?=
 =?us-ascii?Q?ZwhqSVKS8pMNv6txnMNfWqK07imgj/ELJiRp0tfTk9qT/QKSMxnSrKLGwZql?=
 =?us-ascii?Q?IW7Y5igasV3CUtAAsxhHaCT+zYv5vJmCr6Ge3lZwpo2f+4+03Xd9MUxsLrit?=
 =?us-ascii?Q?AK18cwWDS0TJKQ1AgUg49+BeeuPCLrBXZDbWxpeUdBzwj/YK8zgwhsWwc5+0?=
 =?us-ascii?Q?E5Mzz45+/7DXMWWl/hkWII1XHeJ7OFNzkAxF+Pw72dwq3pGWe23Dox3KNu3y?=
 =?us-ascii?Q?WMbCBpPN7z84XQAqd1kXefkgdt0WB8n+00L1J7nynqHpMnJvNfl9lyQIff1S?=
 =?us-ascii?Q?px2UO0QhizNbyggDeWb1YgwRT0PgriZMQ7xwfZ2791Ns93SKXKLIZLoHoSby?=
 =?us-ascii?Q?1Okhv3Aj2QfKnw3vCCeFXO3Y1+6cvr5HpIIWVgpf5uUsYPn67SzsOsoHZ4Ak?=
 =?us-ascii?Q?ugJXut978g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc595fa-08ff-44eb-02a4-08de97280756
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 17:38:51.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjJ0LuvrUdwuyaWaHy8/V7ZUzq1OG40V+2r9v5QzeeKHdzG/v5/VpBQbNIxGOJxfS4wDT/OQGOCL4Zvcv1L4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212

On Thu, Apr 09, 2026 at 08:30:46PM -1000, Tejun Heo wrote:
> The kf_tasks[] design assumes task-based SCX ops don't nest - if they
> did, kf_tasks[0] would get clobbered. The old scx_kf_allow() WARN_ONCE
> caught invalid nesting via kf_mask, but that machinery is gone now.
> 
> Add a WARN_ON_ONCE(current->scx.kf_tasks[0]) at the top of each
> SCX_CALL_OP_TASK*() macro. Checking kf_tasks[0] alone is sufficient: all
> three variants (SCX_CALL_OP_TASK, SCX_CALL_OP_TASK_RET,
> SCX_CALL_OP_2TASKS_RET) write to kf_tasks[0], so a non-NULL value at
> entry to any of the three means re-entry from somewhere in the family.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 27091ae075a3..99760d1fbbd4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -502,10 +502,13 @@ do {										\
>   * held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu. So if
>   * kf_tasks[] is set, @p's scheduler-protected fields are stable.
>   *
> - * These macros only work for non-nesting ops since kf_tasks[] is not stacked.
> + * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
> + * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
> + * while a previous one is still in progress.
>   */
>  #define SCX_CALL_OP_TASK(sch, op, rq, task, args...)				\
>  do {										\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
>  	current->scx.kf_tasks[0] = task;					\
>  	SCX_CALL_OP((sch), op, rq, task, ##args);				\
>  	current->scx.kf_tasks[0] = NULL;					\
> @@ -514,6 +517,7 @@ do {										\
>  #define SCX_CALL_OP_TASK_RET(sch, op, rq, task, args...)			\
>  ({										\
>  	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
>  	current->scx.kf_tasks[0] = task;					\
>  	__ret = SCX_CALL_OP_RET((sch), op, rq, task, ##args);			\
>  	current->scx.kf_tasks[0] = NULL;					\
> @@ -523,6 +527,7 @@ do {										\
>  #define SCX_CALL_OP_2TASKS_RET(sch, op, rq, task0, task1, args...)		\
>  ({										\
>  	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
> +	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
>  	current->scx.kf_tasks[0] = task0;					\
>  	current->scx.kf_tasks[1] = task1;					\
>  	__ret = SCX_CALL_OP_RET((sch), op, rq, task0, task1, ##args);		\
> -- 
> 2.53.0
> 
