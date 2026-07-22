Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDF4028F2
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707220; cv=fail; b=uc18VqhOCVoUbFEd9/OyPxcI0rb0i9S2Mh08WID6rgmz5F/RfPOLeJmhYnaQwSSWaNxMgbAgwSe0EkP1XDdQvFQ2g9TtEGxEFpOzGFaQPsoW4iPQGvPfGwMTqjopcYeMkE6du4skbBLesBdUvU8EZ5KrrVdS68XAnvcLQqy2ykA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707220; c=relaxed/simple;
	bh=X/ISKN5QQn8E7IUZOtkRcJ1vUvAKX7t/whHQvWgW6vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FfULnzRToOGC0GnjGRhuWN1hiB4Jp0lIw8SA5ur7qAq8SilUwFZ/6JHb8RSLOpSxe+ahoOgNYxwN4PtwB4ZJp3W+B4Zr8AIm2+xmQvXzP+Q8YWqtNYqiKYihyenaBqWAeunM0vaFC9qVnufGfCT0I5KpWnkhk5p5FWXdZoeMnQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGESq/VP; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGESq/VP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJj72mJFQSu2Md3DO+FF4XFHcMTE4vm4jBpC+dUdboOW5vwK5Gvt7+KnpVZxMIJMwAPHupELSgzjyB40VWpDsURCC4Q+gvTZnR405RCJw0Z9sT/NBW5BuIqNHjYpcAmbMhgKAbWTGX5ei/SQhgNPS3SHlLYa9nkQH6hjeLRzpg47yqz8ZGZAGSYn4p7xLJ9IrLCMzpd9xlj66WNyDEGNgV7ar4FjIy797do/bMnl/+ejgNBq9Swp+w/tYheCUyUUgwEziP5jgqxR/nc9mngGjCzcp1FR2RCEBw8fkAHqugaEGSZayFit0dFcrBXS7oNY1QGOD6xLu4sRiIJ0hWYbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5EjTCETCNob6Ev6pqYkf/gJIgk7v2ehYHZTxgz7qHE=;
 b=gaADsUSfgHpJjJuPsNfO+Ge/TTN064Sm/ktjvrM/0IOLSx6hfk96E7KIvo2wERcwPv5nW32N5iCUeczbUp9fl7+AWuG5gxmXxi5PSCQuhqlYmZakCGoE12SHfGJ9VOX8edrO80zCuNx616EieDqgFsNFXw5pC/FgpSM57cbjm8Si+/3a3ssnQg1Qq9vOyopFrffEQKr14dN801aLYYHcc8gEx1b1v+IX41iZuZsfAa+Fc51qQ1D4jMc3OuBs1O2wlfc7b95meZe9JWpKbaMlaMtLr1Ob71iJ5bbMpJcn6BDao61p/E4rhuTJQATDvOcItBEbjXLRD6R2xcXmOisqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5EjTCETCNob6Ev6pqYkf/gJIgk7v2ehYHZTxgz7qHE=;
 b=pGESq/VP/vlstwR6ubjOJ7tVlAQ0JVq/haMnt+M70sc9MOMgCdJuFYCzC66h4ihF2zYORDYinhT2NtUuv3mrzA0GccEHuZxVisEJo0TAPS0G7rI8fNvqbvtiXMcICWGoGzYrplH2+1CVDow7YacLvlcifFclra8Om1gcCAXcLLSea98vcEFzkE8kb2NMd26Msxds443qhMjRR3VVDaWD0l8RoFsF9LMAByqKz53UfrpXEaVyggkGVP4a3hEAWVmrGcjoN7nRylNHxtEeDhXCfcP25JOAbP3QFmEPxJIZclwMeBuHw2ieTz97yYLi7rTAIrSIVL3siXLe+0PUUaDt0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:00:15 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:00:10 +0000
Date: Wed, 22 Jul 2026 10:00:02 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Sub-scheduler and cid
 fixes
Message-ID: <amB4glZfP_3Nb3iR@gpd4>
References: <20260721223118.2268529-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721223118.2268529-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f7e2bb-5624-4fe2-800c-08dee7c740d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KO3Nq5b2TgPvaAfAIirmOh0weYB/nHwOI7j5Up1vSjTSZ4UqIlt1uNLjQJkGGi7NXsbGEKYy86vFkR4EXIdc9suoA1yuxiY5skFxGQ35pYD5brIXgxyPeM/GCfgiYSKHcULvLvwsMdUSEy5Mgk9TyOuVdyRSKrEtaYJFx45pRTT0l8KE82Hcn4FPNm5fh9VdkGr3hBD56xKrBojSzb5OjbWI8x0WHiS35l3tcfOUJHJoLypVz6FTDau1rLSS5/WkUnc3bWLcBAmRY9EttXlAjmaWjLGXhd0w+gKnJq90puY3b1flcAWoCeTtfYlrBuy9eOcakMYhCouUFY1OAxlR/r0TviMqelh4FCMHgzVcZhc5rDd9nJp1p82NMZU82rskagD+ILwr9c990x4yxoS8ucKf6XmHCbq2r1Z81nM2xilYrM4tRGPx8TYPMQrJikZ7TtUnfmztg/ejifuQB39AlUfXB2fu4plrznTlS6mpszOGk8pyBTjlGV5zkDgZ74igJeD9poldZDDi8LAO/99vr3G1S3CnBtTvu6nA5owuSlPF9vZAzpdQNHD0P2d74s+MNy5KDNEcm52G/ecPyzV5YXq8YwDswWaoff704am+p5mryrr+ZEOjvIrjt6ikz+ZJurEpkuynhQz10NvT0JgqpppBadPK9YhrMuiQhHmvgtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AW2Cv0bqMflqx7n/5m42GzHItzTSKKlwbVY6u8oYSSWXj8FNdRc4Zazh5g4?=
 =?us-ascii?Q?Zl6KtwWbj7E77L1Srhm9CXbKmDDi1BzDlt+8AVmt7HRQZ1LopHmcFjK5RpMr?=
 =?us-ascii?Q?1HLtKnMTAar+cbmO6nsKgufbq0r8mGTynhw/ATDPe7IWRImf35dr4WVIKRot?=
 =?us-ascii?Q?GhW08GQR7CuWqBYwxp1EKP4u+GMsceG+i4ELsnRaRKtM5tCmxdhBcbplZsEh?=
 =?us-ascii?Q?Iitzx+M4/FeAeZ5l7pVQ2WrHKcOz4itar8Kuj9aXlgnndrNdmiVSc5IPdOBR?=
 =?us-ascii?Q?xf3lRiGWOby3XwDhE0RJlHH818Mtr6GCL+kFlgJKfNeO6f0UNanqtcVIMmA6?=
 =?us-ascii?Q?dWGADTdeaqmuJkPMTQyG+rawBXm255Bi6sWqiRSp/vphuKDHGF8JXpdx8hZv?=
 =?us-ascii?Q?DkAIKC3z6UV7GNpGko+F/+8qqIhGfE54IzDELv7IEjtVkRYwcGmQvzLZqwfj?=
 =?us-ascii?Q?nNCoJBQwO6r7g8Krh/7AgKQnZytDKepb03VBwVMb66L3QfIJ80ZD591Ldot5?=
 =?us-ascii?Q?7gQlQIbx4mSAJoW9EO55quZqqrGJ7Qbh0Fr28YzfrySeqIdkEsRJwRF5IZ5B?=
 =?us-ascii?Q?/ZFOQJGgIKwILajQES3axcDlEuFClvUi9VVvitG5pSIE1StOyc68fme+0gjz?=
 =?us-ascii?Q?x7n2UgXdaMIKLYwgE1O5TIl/V3N+l+cNp7Hg0pX5IOOS1HSh1m4PWnXqtxhX?=
 =?us-ascii?Q?2jibKjavaatQr4D97lTReiRqXDs5NrchT8AecoPfaeXhW3BRSHBy+7VLERVF?=
 =?us-ascii?Q?D9isYMf6y0Zy3174s0Ikkk92XK2A28cw2YnH8MUPxhIb3C86fQgyI2eL2T0+?=
 =?us-ascii?Q?uellMwyt+AlJmDbWvc5LMrZIHUt25DuCBrGxWGmcVHBPOpch2NIbIOHyohOC?=
 =?us-ascii?Q?Jj0VhaWkKHK5nvKlGBmOeOW5OPsNyoOjIEbuwIfabd8v/Kd74xWpJfe2fyNC?=
 =?us-ascii?Q?FxRW5O6wv34lyWo/jajkxiBT+MNcGUtEQxK4BlhyvVXEbPKSDuAKEHqt+y29?=
 =?us-ascii?Q?rS5HLU0UtQMiYe8I+iZ79M0o1c+gJNmaiwE1QUuH6ITnXg+iUU2dBeXHBRli?=
 =?us-ascii?Q?C9VnSmvS1hIdzS7b3fbzk6WcNmj+C85fuEWqB9miIyzcKJLf/C+MYsdfIj9B?=
 =?us-ascii?Q?ckwJa+5vHaUs+V6Tjg1x4PTsxW4lk2Rzw0Itrh8sp+BJsmaQSuujRvxd2tqo?=
 =?us-ascii?Q?Ym15fW8imnArh6MibvLlLvaOBKTqad5n3476YRUGw+Per1tJNlQbgJM9C4c7?=
 =?us-ascii?Q?/JOWRFYQDozRQoA3U1vu9DCKvlJ1vPrboEE+t22FDxSsj7KosZ80G3VYb4f1?=
 =?us-ascii?Q?BTfa0001CO4souQnolTBso9r7WsTZ7Uutv3ZlGnUNiGkPahARR4pgJBqY6yR?=
 =?us-ascii?Q?eLKnSRCvfBbgM2IxiTht6XQwb6PmAeTTJlMGsxPTvQSPN+VMU+FdKoeY0GzR?=
 =?us-ascii?Q?YEy4j83nzcFh5sQvBk2/ErsXKDxB1ngxBC6a4HVtVTndLS/WO84hrltkfLiV?=
 =?us-ascii?Q?qsqthVHl72bzoFkAvVGb4DFjHiNmSm0ENDdA82/gKaS7jcp4VIdtM15W/g+c?=
 =?us-ascii?Q?qSz1HPLusDlwiEDkZ+GmDkO6F3N3esEKggFkZVrD0dRg4hi9xUaq+UhdHyBh?=
 =?us-ascii?Q?yH4UtGdy0VouBBK/Bh9mvMS+EUR/Lvo2HEqUAF2QhJByU4IMT0ZxtqKcQmex?=
 =?us-ascii?Q?AWQaSkjBuvac3q8cLzebG0OAKJFw2j4dhIirMuRAMH25y4AWlvrXtZxkyTNr?=
 =?us-ascii?Q?t3UsbJUACA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f7e2bb-5624-4fe2-800c-08dee7c740d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:00:10.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk3YT2Dz9LuqEc42fqgOZK8HhuBe/HYlNskjWf60jYoqWjNj4yGpmMfZTVeOqVDSCp4AsGhpCmuK5hmvfhYhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323

Hi Tejun,

On Tue, Jul 21, 2026 at 12:31:14PM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: v1's 0003 only added NULL checks and, as Andrea and sashiko-bot pointed
>     out, left the cid tables readable while being filled and rewritten in
>     place. The new 0004 replaces it: each root enable builds a fresh table
>     set privately and publishes it with RCU once the layout is final. 0003
>     is a new trivial dead code removal. 0001-0002 are unchanged.
> 
> v1: https://lore.kernel.org/r/20260720082605.1451945-1-tj@kernel.org
> 
> A few fixes for the sub-scheduler and cid-form code on for-7.3.
> 
> - 0001 attributes a runnable stall to the scheduler that owns the DSQ the
>   task is stuck on rather than the task's owner, so a bypassing sub's task
>   parked on an ancestor's bypass DSQ blames the ancestor, not the sub.
> 
> - 0002 skips the default CPU selection while bypassing. The pick is discarded
>   by the bypass enqueue anyway, and it consults idle masks a scheduler doing
>   its own idle tracking leaves frozen.
> 
> - 0003 drops the unused scx_cpumask_to_cmask().
> 
> - 0004 ties the cid tables' lifetimes to the root sched: built privately on
>   enable, published with RCU once final, unpublished and RCU-freed on
>   disable.

I left a comment about PATCH 4/4 (purely doc stuff), overall looks good to me.
For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3 (b20dfde5ec54).
> 
> Tejun Heo (4):
>   sched_ext: Blame the DSQ's owning scheduler for a runnable stall
>   sched_ext: Skip the default CPU selection while bypassing
>   sched_ext: Drop unused scx_cpumask_to_cmask()
>   sched_ext: Build the cid tables privately and publish them with RCU
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-fixes-v2
> 
>  kernel/sched/ext/cid.c      | 279 ++++++++++++++++++++++++++------------------
>  kernel/sched/ext/cid.h      |  58 +++++----
>  kernel/sched/ext/ext.c      |  80 ++++++++++---
>  kernel/sched/ext/internal.h |   5 +-
>  kernel/sched/ext/sub.c      |  42 +++++--
>  5 files changed, 298 insertions(+), 166 deletions(-)
> 
> --
> tejun
