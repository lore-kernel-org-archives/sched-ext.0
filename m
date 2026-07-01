Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE93B5854
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935024; cv=fail; b=MX4yo/Pd4za13FkH//x4kgvDo40V6yRtrrjYf+KeWuOUX7AUYnzQIHJ1itwiBYWqYpVmnLehIqZM5V4ydIPVlGeP6NY7u6yNwXHRBygxXlzlh9V6eUIuXAc1I1mHHdeaFN60sC5xkLfQWiZT/BMiQZkAPZjs//QmTjBhhRgSyKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935024; c=relaxed/simple;
	bh=Sdd507PBz8tLcAkTt3XoOywTt44YVdxAOGjL5QMdgnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/boOAuXDaFNjZovuAxo4Jp/FZrfqlj+H/7cBqGK7JnTb8lc6cQ6CaaL7wpkb0zWs2AhRgfmkm1yCHzaTsiZUpbhsMVioM92KbYuMUu+NMbogw1NEx2Le18+mwRz+IBBhpHDhsfLtpRoSzT9YkCSFRElKRnXXIyRfsDPokkUzNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rYs9pT4J; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rYs9pT4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFRGLPrGFJdqv5nKYcN8RZe9+Z3M62uk7cvUMjLHsIPkcOzA4LHz14UYPHCiSVkpFWTQNwXeMUDPolaojl6HuVNizC13gH3aPlfXPNO4r/GwcJo27ZQbVlgYHGQMkMmTx7ZFcvQTUn+KmsBQdOVJ6ZkfSJiLp4JCa5RTyy/mnfVuYh0u8Ej6QdvKFktnydsQQRSzGq7/+KBKzQXdwSkRv1ohyQusfyXoVxin8tjwMLpOKTVr5N2N4RXmfUsUCdN9p9NrtI9Dex0lqm7R6fBQJqnxTxX9t0RLKwKerjDw1auwoBQNhDFxc8CQjvIgEnJrSxzKYavk/qS6A3iu7jA2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za9OCxPE6qKBRY922w8KYBaqbjwwpbrn5UYmpEC/9pk=;
 b=ScLvq3cZqjE5UEv83pvqBnHNytLOHZSqHwCiAKK3ZW5nh7KH4vKdS/J7Oz3P9vSgRieWoWpCfThzPuLKd3MQjxdgZZILs8GcOD6Y8DRClCMgKTyRbRhVT0C9KBvTivSQSrl4Z0vPh6D3ZaWEQMnw764nY0rPYdMtScwpE831102Cq365u85uOAtee5MozCnIBUqoOtz5OqQ0OwHhVLAB6h2VhbtJ2+5Fw6JtqkPm6BApGJHXGQba55pkKmkeFrIRcMF65/U6Z7PG7BvqGhWbwkd7VPFvNmIeoOfJWwrxi3Ma9YeTcUbjcWsMuiqgLAb6Kz1brCxr5qUsLBlBstGlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za9OCxPE6qKBRY922w8KYBaqbjwwpbrn5UYmpEC/9pk=;
 b=rYs9pT4J9tU242OX5lGYcmrzf7cmJt3xSfJbuQxu5HT4+GGuuJ2I/Wl4upaVKkwbAovSMEgSXl1/5CLZ91RWXotEArBSAX3zoCQJmKUrL549V53FgHO6B6TQAsoUN5asFBhmxFqr1QqI679oJyqL2OOl/QGAuBii15VsAonDGfxJQ3x6dqTGG31PJinjR6bDeW8FimhscU7AHgUAujiUhPvfrNppir8vzUXa79kzXtcaClRC4KghEfiPSk6F1n3PNoWXjmpYqpTMo42UUMBGUpE1r+Fsi1rjM4N+kGkdkwrag7yMgmQtmt4aN+3X5UHydYyADO2GA8l4KOAu8C/RXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 19:43:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 19:43:37 +0000
Date: Wed, 1 Jul 2026 21:43:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Split sub-scheduler
 implementation into sub.c
Message-ID: <akVt3dx6dPj-Rt2p@gpd4>
References: <20260701181046.2490390-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701181046.2490390-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: b8415617-0abc-48b8-a1af-08ded7a90b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oeqDfUKzQAgJVzkAhb1IffS3Ynlfnh6jCni8fFoTS/f8elTwTv001ljUZuhsSvb4dMo09K5TzApbis/MFDakFUu3IqyVE5bZveC8QOC8gj7I3FL+5ep73EMR3IBPFHgGy52IB0eHlQa3FhM4Eof1Ylt0aTqrs7wzFa10zItswnR4xNU7oCYTGiAzg8dq+mJzcJhP2UMPZbqck/OcO0OzF0Sg0OPJulnHt5CNChk314BxuK6b6+IfabZJmKmsyBnsHsdFAGpJMepDu/u346+SeS0Z+rbxGdMf8r75o9C1m4mrMRzq5HaHuPhUWiW9e++U9cfmYUW56XgqKRsauz3l+f8dI7/nQRYRO4WFuKYa+PNwwOB9KLElQdGPaAjph4YxE1jq3NdWQIJddqmdpTTMy2GF3KpyXUzjArL5+YGcd5iWTAQ167HVaf2VLRWqHy/5dLhzGFTGyp9KAvoiAaXAiX21qWvfATvb768WCKfniP8Qzo5z4vumZlpRsShINUSP6+59mkEik36TR81QXkba/bWgvthTJ9AC9+O59i7hfRvPqhdrEvQz69ra7FjZKGVMJSbsZfQZpYayVTVpf0epZ9+c7gMHJQD2NKjQa7uaJgMHRuTPCqdX2v7vGAjMR4L+SzMcO1qjaqOHcE8uPsz9/9Sz/+xdo/U+wCzX+2QjuHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WlB1pkbhNHLyVDkQONCGXQ0r4ROVEA/v0LOLwzDhwJLbAx+pIH6IxJzyPO6?=
 =?us-ascii?Q?rasLnro2c7J3+a4ul8A/M2DAV6f9ZBC39b6Pp1fP4/YHtwNFJNTZkeBxxQkz?=
 =?us-ascii?Q?80o9EJuQ6SCJm4dmlQnID2PlqFS3EYHWQ2HCmYVU2DkeCKLTiYYhHLPQ1v9W?=
 =?us-ascii?Q?R6vTU3JP+/gTCcmcEUnkXYGWmF5jY4uG835hE4iSyihlP0WxhytMoOyR/sFK?=
 =?us-ascii?Q?ZUiKL+a4IO7OiEaHogPuDOZlY6Ig/I2paqcF0YhO2RWlwYb9Km4sLKX06K17?=
 =?us-ascii?Q?Xk5aVFkk/rlYABJSXxxWD04vstmg2xCIZxGXst6N8MKQ1dGciAIHdfgSJvlc?=
 =?us-ascii?Q?v0eqzlaUSEMLXcTEqP5MU+qbBWeHjTqASafCRYXrHmsfQ8eC+ZSerLgfN/4J?=
 =?us-ascii?Q?RUep0MIDC9jdnBN+I7BrpUkf4JiQ4G3eICcX9//8smtFJgLdmSY9fFl4XmTc?=
 =?us-ascii?Q?iwQk0Jwqvs9LPXnrdJbIsge8mzoVTwPYz73H4JgP4gEdrx8ttIRMjMFx8nk6?=
 =?us-ascii?Q?ee8w5tg2RGFKBuFC1X60Xe6Q8rXwQHlsDZXJpyNaUH7lAYiJdkxIA/X7gMv7?=
 =?us-ascii?Q?2gAJmgxec1/Mg5x3oWYoBGB403lGNK/IvajGoZ0TLiRd0CXwxp+diSjVtJXa?=
 =?us-ascii?Q?9n1l3AUU76SYAzt0FYXYNNQEZ5xu5+6vo+UOZkmx3OuBYfavJXaK9xWYP63z?=
 =?us-ascii?Q?vjEOu7tMBUh2EQS2AgZlqRNf1OHi/jWkPvwhaLZnaWERSM3Wc2ezGXV9WinX?=
 =?us-ascii?Q?9YOAsgyStHDQui82ldxjllkzASwy2BY3yVvop/jDN16gfWTSel1S88Y9gqAP?=
 =?us-ascii?Q?uqxwcOXgmNjO/mBhcfdxZ60coaqVxg41figjgYSY/JqoOonvf+VgT5pgzENI?=
 =?us-ascii?Q?Rrj+usKHoK4mxO6sxrbX+bBcUAczBI3UL+Cs5R3BPEhWPjROKF7xuHQzTa40?=
 =?us-ascii?Q?v0tqDzWzIkMeUPZo+iWRqRzzb4TL73x31c+4Wfuc8OItswzg4jIy1eOcr6Yk?=
 =?us-ascii?Q?1MrbM2H9BPBnI7NmSlQibQS4NmSwj9d0a8QQO6Svw3LBi1rHiORYRQ8SnJ1O?=
 =?us-ascii?Q?3hUUVDuVpUSBIBQKdfhMAEZe2eXlOMdu5ALSGo+k6nJVg8cP7SM6XxaNHLzE?=
 =?us-ascii?Q?K/y1+ZiUhi4UPHH22n8R2hzJLKI7GHvStvq5SMvLYTixJjmd3kc3KDdYvv0Q?=
 =?us-ascii?Q?q+xcvFhpsI5yMqa57crxpJYOledO1e6CHDacxawbfldkpT75St06nD8Z6KjJ?=
 =?us-ascii?Q?MzvzrtwlXv8kveoi4JCfS+Lc8Yw8Y5PElG++vs3cDlC3ZkpwI0jjkiqBtIQB?=
 =?us-ascii?Q?eprWdF/ID+z7Z1tbkUTFPszEi7ET7Mm9+zOJtmA029N2IPwjEK54bEz0mEHN?=
 =?us-ascii?Q?fc9/1X28eD2dIXSC8o8a3KdR3uyZKzu99GPfayGCv7UIIUcqLnajx44971+v?=
 =?us-ascii?Q?QyuAID8cwrwqHHM/XfaNU9xfvq605EjotkKgSuTtXgiMF/5AEGG+3V1+Eg4Q?=
 =?us-ascii?Q?i3ehe3j757Tri9kVuUMtPrlsd7bHB0QIohgATKnAC3oW+I21/WttQehIKzgS?=
 =?us-ascii?Q?nnPwB2y77zK9O8oaBBMw8+OldrLq4tA3AAEBU0JevSEtDkN7SRRIB8uFelYA?=
 =?us-ascii?Q?Wn8FnVR44RoVDcpftAUcpKx/eckfwuxnG4GMjEnr/9Vm5V+0r0ikbhmViRiL?=
 =?us-ascii?Q?f24tVX53Rw/0JiQeicxKcZzi7mXuPGbhDX63TOp5/ieNa3W0WJ2cjTd58hNi?=
 =?us-ascii?Q?RNZ09DqJ1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8415617-0abc-48b8-a1af-08ded7a90b7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 19:43:37.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5JMnJUVQzEVs35ux8i8mXNA/KeCx5m0XGd+ORJKHuU0yzfw9SLqL6KLtDyoeknlqt0+RvluZctGnzRIH9Vk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

Hi Tejun,

On Wed, Jul 01, 2026 at 08:10:42AM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: Fold the scx_dispatch_sched() sub.h promotion into the split (patch 4) so
>     it is self-contained. v1 left it to a later patch, so the posted split had
>     sub.c call an ext.c file-local static (Andrea). __always_inline kept.
>     Patches 1-3 unchanged.
> 
> v1: https://lore.kernel.org/all/20260701031429.1892218-1-tj@kernel.org
> 
> The sub-scheduler implementation has grown and will keep growing. Move it
> out of ext.c into a new kernel/sched/ext/sub.c. The first three patches are
> mechanical prep (prefix file-local helpers, expose shared internals, inline
> a few trivial helpers) so the move itself stays pure code motion. No
> functional change.

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3 (5df6a4506d06) with sched_ext/for-7.2-fixes
> (b7d9c359e5cf) assumed merged.
> 
> Tejun Heo (4):
>   sched_ext: Prefix file-local ext.c helpers exposed by the sub.c split
>   sched_ext: Expose the ext.c internals used by the sub.c split
>   sched_ext: Inline small ext.c helpers shared across the sub.c split
>   sched_ext: Split sub-scheduler implementation into sub.c
> 
>  kernel/sched/build_policy.c |    2 +
>  kernel/sched/ext/ext.c      | 1117 +++++--------------------------------------
>  kernel/sched/ext/internal.h |  164 ++++++-
>  kernel/sched/ext/sub.c      |  668 ++++++++++++++++++++++++++
>  kernel/sched/ext/sub.h      |  161 +++++++
>  5 files changed, 1101 insertions(+), 1011 deletions(-)
> 
> Thanks.
> 
> --
> tejun
