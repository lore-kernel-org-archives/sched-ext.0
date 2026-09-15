Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6731E840
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475259; cv=fail; b=rOfuas+33bj/9DqlSvKlPdlSKA2snsJ7trza255tLzPJAEkcNsDK0a7hN30QXmHYCi+Rwmb+sICNN7zi+FMtpuxEByUthm/oydVcCGQXhHHyHtjLr332d1BavCd3tCbVxyz/U5kWPvpsrlmThLlq0XhjDX0AiFv4/5wbp6U7Uow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475259; c=relaxed/simple;
	bh=6wpZ07ZI5JgZNAbUU4VX2+gma0iU9WAyFpTpQ5srxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVC6Xc7bLSJ2LQtTJ0IBoR8uKJLFgy9fT13m7pxpw+kTx+/k9l1YSq4e7if+HV1+b6Bjq6/Bc7VRdHFGdw/TgEno3k33kHgavWJBewj7RX7LXPCftRY/u09zAs+bKB+smvHcg72QRREwDKMqoSSzT3Lt2M+r9UwzkFI0Tz2lXqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oaeMFYlr; arc=fail smtp.client-ip=52.101.57.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oaeMFYlr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXd4Xby/M4AWdE3KyOXswvjfTF0Ug/xTp9dYU8hFkv69GbAb8j+TzpiRjwkznI5pJRvGCylKWs39VxtkqWagBdhtmvSvV8hvAqY/IHBLaAuZOJcYbphWsOXpppIBQxu7gYMGTIuYR2L0nH/6Bjr6XkP9YMoLMcPhVaM9ixMR6K4A4NcrrdH5+kFl8ioDbUl/7w25/fYnBxoAGJalamARSaTmGfL4q51/AMMKV60U/at76kcjt091x5Ya/ioEbcnDDuEGDM40FHsd2Xm7eInbvZGi800EyUEBDS/mVaoBLkjzgxR12kA49D3saXOCdHIwHcDCn0DoWn2yol23Bv+tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ9HckVFJZaultsrNO8h1o9Fn9OZS5RC71rqRAmbD44=;
 b=iZ8GsbfewdhXCTrl+eFy+icw0C1Vp6hDWonEo0/0DP9Lv06zqvRbZa5pcfky0Z4WDsFCvdJeSk0l+oPl+3mJzXhdzFkkxhIyGrWmzRnhVEs7LIRlSc40DBT8AHmGdMsHl9Hitp4IAvuNdlObvx4YjJIiXgxAbwBd3zrip4Utsvth2EPP2XyD2ropPwUOWWvcy20X0BbQQ4qu27YjiiPXduR/OlmlGi8r+u0nf9ZKxhNusNqN68aubZTmTqdd6iR7A9Zre7EdtCC9oM94VFLsGKtYpQPI2aSMbCvq90O5xiuJmxXuj3hGxIuanrXgnzZFHwXemeoPVLWeOVtnuby44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9HckVFJZaultsrNO8h1o9Fn9OZS5RC71rqRAmbD44=;
 b=oaeMFYlrcPTGkzV23XrrQ9vnKYp0LeSm+rUN8vr4kNw74dwSeoG6wELCYdZDd9Y9QWjjJ1HS4s9QOjXQAazRS2OmHvagCny3C8f2mZBb25CsrbWRztud401fYLy7WHsJB1nLVEfSY8YjSc/Sk/F3y0ie2eE6Qd3A9DSqSyW/StPf44bYaVX8Nb9jCKXQscGcfo5XVHzE4+gW0O2uMLnh61JqmPs8z7M+nWUI+3HkX+de4+38Wp9yJl2b6nm1SIsYwtntpUMmbVIWFQeolgtW9sFrfL+rgzHTwqgNRrejL1KEGsf9RGgHKmnB3fw7+a39Dv02BFRiDMslZbxyVcGCvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 12:27:28 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:27:28 +0000
Date: Tue, 15 Sep 2026 14:27:17 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3-fixes] sched_ext: Idle claim
 recovery and online cid mask
Message-ID: <aqk5pfKCXWudIBAD@gpd4>
References: <20260915082725.3881071-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082725.3881071-1-tj@kernel.org>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5201802b-2400-483d-2fc8-08df1324b429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4RNSpOXPjwTyOSND3vyHog86vPl5vdJe12ck5MuM9a6Q6+cSbY+OEEChTecmk+xnWLpIWmX+xT9Hzgt6ABKh9xF2KdIj2Dc6xj8t2luLT9i4qdN4wWBZvxj4WAsPi+alzLjtZFWRz40dP5Y5qAF+gMw8oZ4n9+Oa1+S1Lagwkrop4tId34XUA6jodPu1eL53UnbP1KeR3ADrgEyQ0PxhXIgVYKqXly5TrCcBMVAUekOtOUKxioQ8yXpQPNM+aQtN1Mngu43NR6i3smX94FoTfW2Yi8fGiTCjJoX9nStUWO6iB/MQFo8jULeaJgIrj1uzIeJaa+8cBIOZM+/J8NYx52AbVde1UwiVAKN7VFjwSrC/YFfL2PvtcfzHy9A63Wa26LBL28TJBKbTJTEtnJVCX07QKvfBNmi8IUxr7eZj5TBBcRxPQx2fajHkeE/5COGF2nUAYqmd3MGVucqpkP9y97chrF2Sk+gNE+ojDkVNjoii16q886ZnKCDJ61KJ76PtwiDzF2WknRDmJHKVlTZsabNkriA+C3XzwNxJRTA3Qgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/rWKiGSoVk5Z9AaQtzzCh8IaqlA907OE5GYwzoS3zWTBndlX0vLdecrPae4h?=
 =?us-ascii?Q?7NTYyp5ZddHZ3xA/b+4AytSRB+S8dBbR+n+y26dGXz3pJJd9BvAyYiJwU2L8?=
 =?us-ascii?Q?5o0xxmaeJUuFM72U/7pyWjYUpV3ZoGLW8If/OAcQOZ9SD7EATPk6oy46gFoy?=
 =?us-ascii?Q?V/f8QZRlP+vLrL7QPk5fYiaEHLqvVRf+FhUvdHK1NY1HJGuxmV6vcx6Yjm4M?=
 =?us-ascii?Q?wP8+nkeh4V92rJuc0dE1NHE9GhAQMhmKbz7ynPsqqV+8mSiOroMD+Ch/+dNH?=
 =?us-ascii?Q?Pz/uwcZO2HusvB5SigBC+LV/n85QXiVTijOFnW361SZMv0c9Xac8x9GONkf8?=
 =?us-ascii?Q?azFwG3LCQkCW7EiY1eDIDawamODzftaxPfdGroytGgz2W7K+HVsw7QVOqYTP?=
 =?us-ascii?Q?LIRwHPDNmvzm8Cv8p14AiwVwZMkDyT98ovxudY4FzZUhq/rwnegHo3o05AwB?=
 =?us-ascii?Q?Z8gRojlWdBokNbFmCqjtH9E1xid9B1L+McDRehhcPzZV8tdJSmtrqrVW0MJ7?=
 =?us-ascii?Q?JNOcS9LO4++EBefN5bhWDx6nB6ozapy8YXHPw30xbEJb9BlqWLDdyylRebBz?=
 =?us-ascii?Q?tJTYZIdQCyllzMQ51Fyy6P9C+peV3jMhDW88gnx/hG0SqlWeH2tIUwDfZm/s?=
 =?us-ascii?Q?+AqlCni6RXwL4wWY1w3n5kC3o6wS9yEDHSfLKLZj8rlAd+Xm+xekNVCqudwg?=
 =?us-ascii?Q?qqSPdzZM1eyi+ZCWIjwXTlZKhtzqYpZ3GUK34r5o0tkSNLYtYhiNRcMk2YX5?=
 =?us-ascii?Q?Yyz3pVRRoRSmKQSm9gDDOLDXxqA2eOmxFXHnRmXSTksNduTqI8qE4vlqKl1X?=
 =?us-ascii?Q?I/ANzvupOb8SnQlH2Z4upfpSG4mU7bhBH3EUXmcPjGvFpodLh1umZyUimghc?=
 =?us-ascii?Q?3e1WnG6ymy1ZfBvdEy2q+/i7ro2eHXgOFk6krZyOl4MtX+SnINGI4eDYJBsT?=
 =?us-ascii?Q?sFSVlbTGEVG3xaDMOhMj8B54xMsg210xiRzA5tS0u/M58ghUjU05MSoBZEgn?=
 =?us-ascii?Q?q4rgvgJHllsqD69OKfoqa9IAeq+UTfvdVJ4OsLaRYUoam5Jd9oLe9iIcT9vs?=
 =?us-ascii?Q?6TDxinrwC3rJVZn/ybFzQnGM/k56OQfosI3sr5QF4hCPQmY+3/234wlbHag8?=
 =?us-ascii?Q?mwtD+g7LPus87YCamSkS8DhUj0xUrHtN7OzqhNaJg5UlGAqB+bJV7BOU90QP?=
 =?us-ascii?Q?35xojB19ncst0v0/i/BM0gaBByLzGVgQMtIUCZNGMipGsGhokkqR8j930egB?=
 =?us-ascii?Q?QGNImWhvap4bcdqHsMJJdQV/p/ZTV+V9dr5xHQVpmfOctpkUyrB9parlGIUt?=
 =?us-ascii?Q?BT5YmIWQDAx4q8SfY1IUBqz3Rdg1OmcpA77bcFJDmktN5L55Yic3JN45VCbo?=
 =?us-ascii?Q?GII91BjJYYolBt2dAfWVeaFt3Q9WB0R34lY9v7YreS2H0Qa6ENSHyAmMbfGC?=
 =?us-ascii?Q?xbMzadOJJR6w/UBK9x6ph7g9n9byVG3/6pgmlmyoUn68mG7yxf40+e8//w6g?=
 =?us-ascii?Q?Hamxj6Dk7HysxMnXdm1YqVTjtYEvbRaNtQZ4Ma6e9z+yaqJ4pEY+sY4RJF7q?=
 =?us-ascii?Q?WlOztjN9jcZodjo+ujcRTHBo/NDoHdfdfQzY6l41PpiiwA2rckclPULXIZmM?=
 =?us-ascii?Q?hYcERqhZ4weLRqHPGMkDPS3px+vy9u/joyzsXGZOQ2aQat5vmR6QhYV2CoNg?=
 =?us-ascii?Q?9ZsEbC3J+Lr1deinRgHO2SJAgpgtYgGySRxX556ogcQBJrfA7IBv0Q/UfQ1a?=
 =?us-ascii?Q?uxzAmMgekw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5201802b-2400-483d-2fc8-08df1324b429
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:27:27.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsxDx2y1Yr5WpTCYT3It+IHwdizowLDjJE7Mjb96FDqpHMgeEXda1Bk2g7sI1OhTTWIEsr5Lg4v4r1iIEf4PIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669

Hi Tejun,

On Mon, Sep 14, 2026 at 10:27:23PM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: - Dropped the idle-to-idle notification patch. Restoring an unused idle
>       claim from ops.dispatch() is the established pattern (Andrea Righi).
>       Replaced with a patch fixing scx_qmap to do that and documenting the
>       pattern in ops.update_idle().
>     - Reworded the online cmask getter kerneldoc (Andrea Righi).
> 
> v1: https://lore.kernel.org/r/20260914234259.3585373-1-tj@kernel.org
> 
> Two issues surfaced while converting a scheduler that maintains its own idle
> and online tracking.
> 
> An idle CPU can be claimed and kicked without receiving a task. When it
> picks idle again there is no idle transition, so ops.update_idle() stays
> silent and a scheduler tracking idle CPUs itself loses the CPU until an
> unrelated task runs there. scx_qmap has this hole. The first patch restores
> the claim from ops.dispatch(), where a kick guarantees a call, and documents
> the pattern in ops.update_idle().
> 
> A cid-form scheduler that installs its own mapping has no way to learn which
> cids are online: the online count identifies the set only under the default
> mapping and the CPU-form cpumask is unusable from cid programs. The second
> patch adds scx_bpf_online_cmask(), a kernel-maintained cmask in the
> scheduler's arena that follows the SCX hotplug notifications.
> 
> Verified by building the kernel and tools/sched_ext and running scx_qmap
> under CPU and fork load in a VM. The online cmask patch only changed
> kerneldoc since v1, where a local selftest offlined and onlined a CPU in a
> VM and checked the mask and the callbacks at each step.

Looks good, for the series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Based on sched_ext/for-7.3-fixes (c7a1c6e8004a).
> 
> This patchset contains the following 2 patches.
> 
>  0001 sched_ext: scx_qmap: Restore unused idle claims from ops.dispatch()
>  0002 sched_ext: Maintain an online cid mask in the scheduler arena
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cid-online-cmask-v2
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c                   | 75 +++++++++++++++++++++++++++++---
>  kernel/sched/ext/internal.h              |  9 +++-
>  kernel/sched/ext/sub.c                   | 10 +++--
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/scx_qmap.bpf.c           | 14 ++++--
>  5 files changed, 94 insertions(+), 15 deletions(-)
> 
> --
> tejun
