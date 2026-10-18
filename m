Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A33BB115
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306202; cv=fail; b=mRZWP2GV2Kw5gGdHexVnebttRPO9lpswA4a6IwS3iePk4Q4tsO/jr2hFBI6zuNKagWa1KW9gUvFZMj9mYSBB0cOTwEUL2pG1uMuBfCrI719rDFkFyFoXkHW6WjRT0pug6rRxKr5JcWQHCzntFXV1vufon3W1Pi0+2W9Vy0PxEFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306202; c=relaxed/simple;
	bh=f0Whod35dhwztdZJotNg3tEjn2kt67WbbUhI4c7WPvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJQcOxLOJEtA8ZFhlLzs7tglW0kvsZxbL6mjR4QvI5jFDE29qg1pz9FRlKrxOntxJX3dgHT4dFDXPiHoqR6nKn2wpzXgcESsFAGrteCjrD+olVeyYZ+WZvkdopSvXMU59ewfCUXKOHyzy4ksruIAISAyAcWEURGw5Lmj36XgEyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msDsLrKt; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="msDsLrKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTe27JoTVLXVe1h93lZb1swd40y6FsQD7Ic8Q20F1beluSKtxw/v+i3gQcfZ3+EhCUL1V9OX6q7ZuU5h8MIWTHpoP/29PaeEffZtgP/LbMRTZ4V9GxijOrHDDItjBDAZtGSknZJGLu29ylLlOq9kdvY1cvdjm4UH2+v/pFuget0veR1tgjAxoXoXVDd8QHW4E+sm1Q9NN2PuNgTO7k7gAmVMuv0h150bJ4Eqx8jggUUvtSypH4wE3+EUCBjnATFQbjW56vSLf34HABZeyOaZmcLpXTWEC8I1cPw3O05hwGOwdgtXgw6ms8KepPseNLHOxsiVk22EOH639NsDiQeKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz6fu+cnLvV2614jkZPNhK/RiMicTvOgKNBva2Iz6yo=;
 b=GxD6AzzQEK3s7yuGRJG4doa0rdrRPGZVldu2adlc+cTKbheMBHTRzBateZzdhz3x2Q3MC73pCBiKACD3jotvqKFssK93161CIDk5UZM8ZWjypKumLZZH88ijNBfc6l7FNSppqe401jx9p7LtrVJ4TfJUW1zRkWpXDtQD7YGRfn2bzKj24IrJiyZE1ENJ4QGW2EIHUAth4a/b5QwM4m7YD/AjW7BaaG6T68+fWXwHwpzUbn0jaGVQr1teU+FXQEqFRspuIRnRZ/kUfkw+vVQAkX4oGoSCKIb3WSVBUqcdv3aykJPzFW5oF3fGj7aON7S4tiXXFjyGFtafMY+rQK0/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz6fu+cnLvV2614jkZPNhK/RiMicTvOgKNBva2Iz6yo=;
 b=msDsLrKtinIWcjdf1VXtgUqQiHK/io9mvGaISd0EMo8qZDZW2S+oegZe3MG1+nNDWTSeI4dw3pEDOVSb7q89arg+gIdSTf5pKg2o40SLEcsP0a/lVqCQtQRIFZsPoxOdNaUM19mPucRAnkIdHAnigUHeg9jVkQI9rA1hpY5y47M1J9VnRlSX5n0bmZNvzkhGmPQ9PY+eae8s0W2DWcC8igTOrV/4LcJtZk5f7qDPerjdhLxi70iUiFIThf3ZRTB4DRYZGYqyZgnBPCRtDnhzV+sz0gHBcJti3/xR0OBvYz9jJ99a5iYijFK3L+Q39n3NqkpGUYCzb9QUNqt36pijOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 06:49:57 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 06:49:57 +0000
Date: Sun, 18 Oct 2026 08:49:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
Message-ID: <atRsDV9T_lJpgWs-@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-6-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015952.1499528-6-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f09c9e-ee18-4ec5-91b4-08df2ce405ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kxVPaQNSu3OtPZhBRMyhdVdvsTrqe3EeXXtkpC01c5T4c32NKeP8OgrQ6bQuBnskhcLSqSc1g0Ap48z1azaqNx+WchdRXk8mD8pjgFA7hACIxXe/umasFAllx+h7zNYE9ycyeuwTw7H5QfGSLuHUQ0V0IrXs6M4yObiesy2eEqmS5IKaLbkPD5e+iOc05yJI+eacAuD+FMgPlJRn5gyds+UWIUMwHuQ/iSex4YZ/3X34VqDniUmmidTM7XZV0WuRERqZ378KCP8AEQEFTXtFVQk3uBUp8S5mE2QsJyXfGUex6zq9NSg4Qqpd7+jPYGOMHlOEA7FA8Aif73i699K4xFZqVXce7OH3Yrg8mZCMKquqld+ZmCSVRxPS2iBexC6pigJp7Qn6HpP6vYUAq+KTeqcTFVRDg+IAUf1J5Wtsw0EhKh5WBu0mCQBKhh0Ynv4uMIrdDJFR7BUXbJ+eZ8hmjt9n7rqDQqh++6OZz3+WapUX0AIzWj7SD5oO3SDitHWFPEZHZc66r40GGSFUfdPmwd6f6VDA9qbqGebEfAxfxxrz3yF45lcq9tsN87Ny+nskku245uQxq4PDIc5UkBwSebZLxC4pVU4T5Xn2hurbv/s5eiBqypcHKkGzuof51yS2FfgKGbZC6BaNp+PGAB5Z9V9M8659eN3GT3yVuYoXOcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qL3Cksnsgp/S0HwvOrfGvvTQMUS4X/VeSwcNgL7umUK3ziwxCeZZjbb0yvfr?=
 =?us-ascii?Q?KT8kEO/SvIZI27TJcsRZ3vVqYj5ZZSVmnkq/LglnR2ENx31Lt5OLTMyUe0yo?=
 =?us-ascii?Q?7Nqp+iGO8X0uNWyl2ELQ5hcD6cBGv1VkwQaL/4EUxS17zHhf0cLvGYk4iM4K?=
 =?us-ascii?Q?39OanNbVWBftcVEAxGm1W18HyvAQucJx2aghAvmWSgA9PtXWSgUvSbV3dz6R?=
 =?us-ascii?Q?8dOf0yWpmcmXhc/qlv5CDPBb3uLQqIe334+diRTHv3bjOh/OimPY6QkvLjyv?=
 =?us-ascii?Q?eJgL0UMWtFDNqS6AKYtYBgCjHJSLI+hYtjuofV/iFXsEH9y6LeYs3AU+SEMO?=
 =?us-ascii?Q?GVJtvElyB/mW5vcAmTXz9vKTx9ajQp+2uil9lZSPsAEq9P1uc7N1Fv6O7BCj?=
 =?us-ascii?Q?3k/jTZR74igreGkUUdNrp9J3MyiOf0gdTcJa3YbHz2g1S/KkstkIdzr4T3lH?=
 =?us-ascii?Q?64K6g/I1IuGY5Wwwg2qClmBNJFb7fA4GWgGECd4nT4kJ5vzoL7jHV1TNxD95?=
 =?us-ascii?Q?uEwN74Y5ZOSrJNK/6eUXNFT3qKq29CA4RikdrVwjNm3rv0hsYGhsUUL/RXVG?=
 =?us-ascii?Q?jCPQfRzINJYwDTAma6Jxx2ZRZM9NGx2naoJL0vICU6gYv8SS8FXAwReCg2pm?=
 =?us-ascii?Q?wwRzfiDn/zmfizjBGXOlpi+b0d32UiKckfZ64RqagV1HAmCQVq0AH1AY0o7A?=
 =?us-ascii?Q?+2nETeJW1s16gDpkXpT7BJ9DmsNB5r8tPMZfccPtgEFMco/+ZHdDycPsv+5G?=
 =?us-ascii?Q?bo++N8vTxnHHwSWUd0QcD8XbXM89I+gISbZ5ou82HLvYS5uQQFtx5Cn8jx7S?=
 =?us-ascii?Q?oa9+mTEGpCLnj5acRmW6hGuH6RSiiKCaCwc6aagOvODzwaM5I4SgWQYYRqSF?=
 =?us-ascii?Q?H1YwwOPsUR5MzwBqI0BnZjmdwPL/Nv5RetOe3xS9bkbEtN0wSFYDG0K2VqW/?=
 =?us-ascii?Q?b3ZmsOLnOs2pR5skUls0Ii3tWh2SYFm4p8aSZpYwDlcWKEahzTAQblDoXLlr?=
 =?us-ascii?Q?ceKR2EMvneoEiDNRMIdy9Uflmc7EYGuAU/ouTA2YdtSxCQIJUFcqyKz+x7m9?=
 =?us-ascii?Q?H7RNz24UvGOhaxIhf+dm5FgfzN4TFRRiOAZCEBiXE9CXc2A1oTQgMJQYSJtt?=
 =?us-ascii?Q?EFJ3HOuW12HW3vP+LsuDTcN59zDTrDzmd4pbLuuyhHG04H2ngrZZ9KqL7n/Y?=
 =?us-ascii?Q?wja9SooW3MqKFa6h+EMHcVJEgYGBcFcS5mUNfgIeURCO8Jj3ymzB5+PuqnYP?=
 =?us-ascii?Q?kCCS0k2zY19qKaq8TUT38MY6+ImJ+hRcjq44P+cyixhdtRjfVIqnIXRidgd3?=
 =?us-ascii?Q?p5TNwqukziumC7Ya0bSKcqu87Lr4j0xTdAEXwVbwdN33xk1t6b2WhITdX6th?=
 =?us-ascii?Q?J67hda9sDzDx41ZnElhCQ3ZlC5ykCytdTcvdxXSr+OFlMCp+S0CExqHsRLPM?=
 =?us-ascii?Q?SmRr5XauE/xXNypdSB4tB+77yabGSDX9qBdbOm2jBsIjPLIlBO2+S+ngh5Cj?=
 =?us-ascii?Q?DZ9bz26hI+VA8nCtxXscSX9T+2rMsXww1PinMtBHNc0f6lKqnMAOojZYwZll?=
 =?us-ascii?Q?as7zraaa/C7NDcdIjRHTwlwyLy1sWapexHCeSjws+8eVg3CAswsfEZLLAvQf?=
 =?us-ascii?Q?l2XzkUiIV6irWkyseWLNBS/iPQgzWE72DSArdAsZa3YCr8BqnVbQScfTfXmI?=
 =?us-ascii?Q?tYEmAxPkAXoujXvFU8pnkVvrJ8D+r5iZh6ycN7XwCO+gwGPcIhkJXpSucLaF?=
 =?us-ascii?Q?6ws5hcI3Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f09c9e-ee18-4ec5-91b4-08df2ce405ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 06:49:57.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+2YyUi2+NAKbVlCM+Q41nSIhfhmFs2dB4ELQl0l5Ai9YsHG8C3xb9tA8TbJD1saJT+92m8L7Pvi+mM0xxdGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

Hi Tejun,

On Sat, Oct 17, 2026 at 03:59:51PM -1000, Tejun Heo wrote:
> When a cpu goes offline, a sub-scheduler's effective caps on its cid are
> cleared, but neither the sub-scheduler nor its parent is notified. The
> sub-scheduler keeps treating the cid as usable, and the parent can't act on
> the loss, e.g. reset the cpuperf target.
> 
> Report the loss before the root's ops.cpu_offline() and the regain after its
> ops.cpu_online(). The zeroing at offline was the last change to a sched's
> ecaps outside a delivery, so they now change only with one. Syncs on an
> inactive cpu are processed instead of discarded, and the reseed reschedules
> the cpu itself, as they got no resched when queued. Suspend and hibernation
> now report their cpu downs and ups as well. This is temporary, and a later
> patch leaves them out.
> 
> Two things need care. A cpu going down marks a sync for each sub-scheduler,
> and its hotplug thread waits until each marked sync has been processed. The
> cpu's own ext picks process them, and the ext server is started in case a
> fair task holds the cpu. Only the marked syncs count, so a flood of changes
> on the cid can't hold up the hotplug.
> 
> The detach report reaches only active cpus. It holds off cpu hotplug, so a
> cpu it skips has reported its loss as it went down, and no unreported loss
> is left to drop.
> 
> Drop the cpuperf reset from scx_qmap's ops.sub_detach(), as its
> ops.sub_child_ecaps_updated() now resets the targets on the loss reports.
> 
> v2: Reschedule from the irq work and document the regain order.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 05cf0f0056e9..59dfe7999603 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -846,6 +846,7 @@ struct scx_rq {
>  	/* sched of the open running session, see scx_cid_sched_update() */
>  	struct scx_sched	*sched;
>  	struct llist_head	ecaps_to_sync;		/* pending ecaps syncs */
> +	u32			nr_ecaps_offline;	/* marked syncs a down waits for */
>  	struct task_struct	*sub_dispatch_prev;
>  #endif
>  	cpumask_var_t		cpus_to_sync;

nit: nr_ecaps_offline lands between two 8-byte aligned fields, which adds
a 4-byte hole and shifts everything after it (kick_sync included) by 8
bytes. Can we move it next to kick_sync_pending instead? Something like:

#ifdef CONFIG_EXT_SUB_SCHED
	/* sched of the open running session, see scx_cid_sched_update() */
	struct scx_sched        *sched;
	struct llist_head       ecaps_to_sync;          /* pending ecaps syncs */
	struct task_struct      *sub_dispatch_prev;
	u32                     nr_ecaps_offline;       /* marked syncs a down waits for */
#endif
	bool                    kick_sync_pending;
	cpumask_var_t           cpus_to_sync;
	unsigned long           kick_sync;

This way the u32 and the bool share the existing hole, and kick_sync and
the following fields keep their current offsets.

Thanks,
-Andrea
