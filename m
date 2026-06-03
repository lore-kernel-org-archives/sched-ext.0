Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BB3F6C4A
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512085; cv=fail; b=AT+HC6WQNZdnJLhpYrSbBmv0vDfQSfFQL8OyMU5YP+pgQGphvUKcjpvWV3ac5MhkXh02SNj1KB6a7myCyG3sA4foj/qG5jY1EaJ/LDK7ly77mk/cIBBv7curkfPsD/keelMyhpiFhzSi1+IJp5X6kH95tmfejPvnbUSecYDCOLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512085; c=relaxed/simple;
	bh=l1enghJq8VgKbExvaoVzr7Q7h3XKVh/6OyM91a1+oKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MTUzVAllWM20G09cipstnLt1Iutfcreznp9+v6IWUXs1RzEwsMiP7UviYNE5Kj8KGOaLBJSxqSPmyy8WGTXhOeyLU+Ix/0JRkmW8QEXH+looog7iQI8ANqRdU1qD4UA9A78ZjTLaa5PQasNknAIJWOIj+EvDaVQFvmwe/XhJD/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCeHFCPc; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCeHFCPc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOqDHLBIjQwLMJ0xpAVBts9ylCv87CzhoCY0pVnUnM27z2Q338BYan6jPmGqyi67o8TiegdLC5KDMqWBX6s5cBrKF1MuTdz29tX5YWHCHhEJwY+Ebb97UA0hkOlvu/5Ge5Q6rAvl5+SZN2nIFO7QFCo4gGpvdhUo720B9VkiX6IxDf1Xl5I/cUziadrubKhjWX6zGXUXNEQa9wy4PJJcP9KoB+OZnO7zTQeMQ8026NhxtPoWfOUhAPx5Vp4SF6lIOOEAoMK+QTZWC93sBzuGzJO1aiWB424piJEBRyq8slP2A0nFWAqb0bLv9ioSaafRFNPZlCYGKUfKDNIEyqjkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npOIS5VEQc+KI5Q8Ey0WWwP6XRwnpxXoDDhmCBGBxVc=;
 b=S353n0m3BdEDQ+G6gFHn3N4f0517PAj1MOTg2lbaqFkxat+88wbN6Gw1vkw42pqgZbEhKoEGNTo8SeaVtW3YnX9eoUM756LBvvjrL6G8fL89JCikDA+0VPqxWLmn9XV/K2Tw3Iox6AjOHKu00sygN0FK28W1tOqgUlEgmt+oQPI0usg6wH9dqOQ211XooDHmU1bEo5z9c/7SyoR3QUqoTIHSt1uL5oLHcD33+KPYgL/NLSFg4h/wuoY5kd2EqQZgjP5ZpT0LGd1ezzS6RzTkc2isT5yubCFohpugqIctxhSPWFkF9/arXjKD8BJHMhjYSUIHjnvqSAlxf5/quMAehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npOIS5VEQc+KI5Q8Ey0WWwP6XRwnpxXoDDhmCBGBxVc=;
 b=qCeHFCPcwugIeqCd10CDACewNNLFxoPc+P7zRiYBPFjDgqG4v0ZD0ou6B69xs/UqTNvt3cGCPt96LTnO2pn/f6tVu2/QKGCW9a03+dVQB9lqN7Kht0yjsh9Kp2BMoxQ8UqorEEIEPlHgZoVUg/CGilVwntpPkA6e2olgli54fhspDREk27M3E7CKkEBMfnjwBzWZA9Re5/XgCFr3zjO6ULpVgCAIN4ppRpJ1TrkYekxmFbYfJUgL69o5WbowGoDdltfOjueBfKkfsZZrYtVB/n4gkSeU2QQO3u2uRcL0Fr8vZq7GNFeLJ3wAXX4Jg7rJfUaA4ZUyQQrL1QpxuRcQ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:41:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:41:18 +0000
Date: Wed, 3 Jun 2026 20:41:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2] sched_ext: cid/cmask interface prep
Message-ID: <aiB1RuBsaZU1qjdV@gpd4>
References: <20260603172153.3081861-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603172153.3081861-1-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a8538a-55a4-43c5-0699-08dec19fb2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	AtRIbRk5I7I+8RnacLi49/7QhjQ+X0NkeabBSm/zSHJO2cEz0YfQloKDQOIrl0++Qlt5fCd0kPkpwgm/JsrJ1XWB4wVQNQJaNnygqoDYNrbpTYuSXLyOEZKa3BBbyH/f6PzzhdfmtS+NuIVIgXbFJtRjSiIGpkJNXiUB8TkuBLdMSCtIGIxD2GRnrRIMR/HPbVzmq+NqCQtXk6XtVqIgIZPwgBzLSGyRSHHXV03Ge/9NYPnsMdXUbBP8mYTwFySTI1r774MslOw9Yns/BcNqMImhWDSAoT1Vsjph3D5+FgxQoE+apQsE9hPcELgJv5/YxPkr5eVLSQ7qebUquOKACpRmzP1zfqDjpn9EYl1GC/jgz069Au7ETuq84SbB1aRqEeg5PKdckDswwSHzLZLEk2gzzXBytSKFDMuw49mu80BUjx+AgQJPNSvN3311b6MnuqrOPlqoWGzvFNwjeSPOevZFxZLmxZ78MBCXjaX051Rh54PYZlnRR3Eo+siAJpVxahYTHAk2wdPmzlb5U821YS57ks8pj/0NiZkI6QW9iF2FWCT7cCRp65nTSJYy+hBwtVZkL+RhZG+bYx+o75pKoLojzQoOtO8/m0TfWCo3pEr6LI1PJEsy6OA3iEiL8rEQHYGQxfyWzRSs42GIUROVSGNkjWFCGq/Jz58AaT37c6G1hABdQbln6XFL2zVrlWyD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KH/YPGeWY3DZAwJbKDlO79KelXAj3jxtKUeKWow2a2jbJfEw/AqHBoUDCPab?=
 =?us-ascii?Q?79nvUXwN8GevCLFAmC6s+egdBMecQ7FVGvmhGsMpTRRdXC19R45mi5nVksCZ?=
 =?us-ascii?Q?ya2RMMzvZfQjQPahkv8k8x3F2RWjgxcONL9MNTEwBVaaVPRoUDH8zVq6tNIL?=
 =?us-ascii?Q?wdshRxbv42gjKzIAwRBOPStkyeRu2yIWK9379ux91+k8oIgfRN9+7YYNL8zp?=
 =?us-ascii?Q?N1NXGYduCAJknOFcMAsO/0P+URxybIt7vbYQfo1ubbzDIgIbcbuhd2laSxY/?=
 =?us-ascii?Q?5fmDL3ZfbZ9QHE/CLdQLGxEfP56agpAAkmuAU75V0yTbXswLDSPuUDOpX/Jj?=
 =?us-ascii?Q?4hUlNkoT4dEEL0xaFrF2qLVcnDD6RFO/7giNZ4D/jHNHLsrp2LzfrRbE3Ldf?=
 =?us-ascii?Q?ohq1CBeQZMKvw8dnCDsnpTchUloIj22iuWsOf7DBm/vw1f1SkWDdRkWe/SCx?=
 =?us-ascii?Q?/64/fgC32jHOopSejsUK6FI5gUQ9FG9ebekorqwR/kKPxcZjANlfVLYS30wy?=
 =?us-ascii?Q?TRZqFJu1HWUOydGgkiHvfD5bdrPnrKxKWl4XpRfxZ+qDLYX2x3iTWZQumLjw?=
 =?us-ascii?Q?Hpqq5OUoOX83DXjttAec1pBhvyQ7d7J6IQZ+H3LSsCmwNCuDOqg4HZ2QMsCa?=
 =?us-ascii?Q?W/vk4Hj/shrx1dOr164bG6AWIONdEmbIc9KkMr/bANMLF6+1b1fQWYL2EVBu?=
 =?us-ascii?Q?y0lKkbXht1b5oubsi9wDcQ0qD7kZG328fbqqP4yZ9Ym9A0bowP+jshEnMHYG?=
 =?us-ascii?Q?p4GfOLslag3nLPGLqHhrnC0DlFqT6mTGXkunEzt3B06KXx/rjsDF455zngMi?=
 =?us-ascii?Q?481tD/nMBAEjzcnxVYVVT/dOzg9eKSKNyvoXTBbva7/Ku7VT2KKVHNTKRItz?=
 =?us-ascii?Q?94AMFg3Ta96LG76cRLsxXOvYhuVte0ZoUf6gn197kUbFM6AK6fFxhWLS0lk6?=
 =?us-ascii?Q?p/5+W9LDphVc+n20p+h+ZfFil8sL2Gvp3E6lN5PBqlfsLqb0og8ND6D2FDVj?=
 =?us-ascii?Q?+WB0RQyrP2qQDC0R1rOLsxmyFvs446Y5zWVc/8BF7liiBJ7IELHhkV/VtyZ1?=
 =?us-ascii?Q?3aANLf7ykinCcQdYbi2zY2XtajuudieJ3fyI1wJGf+SHSTToqcmCGHC7cKzS?=
 =?us-ascii?Q?kGbIvCGeMik4zgShLA+Gs204rw2BNxIVwvwrhN+poLHgkEepzPvxR1NYFh6b?=
 =?us-ascii?Q?RJAImFhI72ulV0Yd4J9e7sB6SyDycRiIa0XVeBboW7Kf8YQiA2WnwaKJx4u4?=
 =?us-ascii?Q?FhlF9X4RjzI89WBg3OlnwU6vm99eP1nwnOyxNhax3EuW8EjqJgmv/yn9oclJ?=
 =?us-ascii?Q?Gb04ZmBX7SRnakSAhPpzhc7NruV/Jnd4L8JyPT32DOhSDJPcIvq4wejs0N4m?=
 =?us-ascii?Q?otF30IQq3g4hzM5GP2tPHnnF63BlfuXkCNG2Ap2ZhveTwIb3RPfUb1gNJhgo?=
 =?us-ascii?Q?BtLmln8CNTXLEUwBM8X+xJxRDILgnfNFdhI/AA5ReSu6PPYWIJXNcXO2JheF?=
 =?us-ascii?Q?w4+DrkPgZBlOvB66LqFqy0vOuPWKi/sdtdjqKkhkVcgzuELzBARE1RJOQURW?=
 =?us-ascii?Q?Bh63NlDIWvraTNMPiY1FrU1xT3LG0+VJW69HopkIabQ6CayiWm/IrfcX8fkJ?=
 =?us-ascii?Q?E3LAh6ydjPPXfejSLn8Q0119O8KWAKSSlAFa3rRQ3sP5ZQTrMvmPFagZlBeT?=
 =?us-ascii?Q?JKRh7PY3IPjDsIVfr6IBlVaSBh+zrEL1A08FXTv5YEPa1KI1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a8538a-55a4-43c5-0699-08dec19fb2fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:41:18.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8KGi5Ztrj63xK1EgsVN3LqjgIxCiz+2zrFhVm2SvngCTUMYSS4knY3zNq1lfWKV1r4RjLPZGgfnLVlKEmQz+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

On Wed, Jun 03, 2026 at 07:21:50AM -1000, Tejun Heo wrote:
> Hello,
> 
> Three preparatory changes to the cid/cmask interface that landed in for-7.2
> this cycle - a helper-argument reorder, two new helpers, and a kfunc
> return-type change. Posting ahead of the merge window, in particular the
> scx_bpf_kick_cid() return-type change in patch 3 - it changes a kfunc's
> signature and is cleaner to settle before 7.2 ships.
> 
> - Patch 1 reorders the single-cid cmask helpers to (cid, mask), matching the
>   kernel's index-first bit and cpumask predicates.
> - Patch 2 adds scx_cmask_test() and scx_cmask_for_each_cid().
> - Patch 3 switches scx_bpf_kick_cid() from void to s32 so future cap
>   enforcement can surface failures. The cid interface has no external users
>   yet, so the ABI change is safe now.
> 
> These are extracted from the in-development sub-scheduler series. Nothing
> here depends on the rest of that work.

I sent a comment about patch 3, other than that looks good to me (and thanks for
the cid / mask reordering).

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
