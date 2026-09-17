Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C73B4E94
	for <sched-ext@lists.linux.dev>; Thu, 17 Sep 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624211; cv=fail; b=Q5ofEfLTBhj5zxAc/z52LPf9TL69+2wX+t5l8T0J/J6WiPh1wT7mgXMNW3pwvyq0l+eHHXg33j5t/S7GYdjKBzig+L1NfFSyZq1GTTOpKXJr8JH2X81AaMBCp72XKu4bjorI73Juzn1f0jX56vX90gA4C9W55a+O6StqyQOHh38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624211; c=relaxed/simple;
	bh=li36DwjVHMbdVTM9z1q152cqFheT1jCera4RIg3BSOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lx0htbl22nngGFx2Yw+MnNpdjeoBJjlMhYpr0XVhId4cDDA+BndF0Qj165svb1N81h+5qK4Hl2hecGVM0SzBPczL+2EsiiYvaZEaZFaIHi5WuL+QN1alV2j9QhQoDebUw5VpeWRgPCU6zJzjYiNNRU3d37dptsttXPvCuFFCgeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVbUPFCe; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVbUPFCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXOOmLmdW86Xdc4o6bq+RcBgDsqYpPVNzXe2oWch7j0L4z1S0Nxck1P9YGvYHiiMU1awEUhIBisnRQT8NuEI4O5GSYeYA5xzlAxx7BQ+nWIU7k14LWEvFToeKPhDFx90BGA8DjY5EEGA3kaauJIJy8Eq0JjEGC6DNLuzDung/5MKXVoILlrdFTlobvos1gMJeD51zJnnkz5FPhnDE67njCTIP4KVgKPhYXVvAH4LlK6iiP1WpqeuSWGaeqAWbEmz6Z/EeBMPCYaUjQooXdWIaXnj1C8K9aGERWPQRZnVG1nT1uDRw3TnbPsgiQvyHSa054sBIdKJMFeOYPFeeDlTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taXz9bCsTcmyqq4wMs0lNg/01RoIHs+jK7wSGnNJZeM=;
 b=edRAAXKSfooHjSjeUXIo6VeLo0Xd0JIQAScl4vQQLtpWbh9YgRkb2TgMnBwumo2fGau+9+pyO6q18WFWINuclWql7M3OtboIflVH5KAUdQ0w0sFk+3U+IPTRh1Byl7xHnave8SHNrwiW9wIu9hXZJw1eCPvR0ysesGdxw/rW1MXB8DUpl9jmOnnvAeDssza/X2odfgHYTX7a4txEoRPbwDymBLsmfUoFWWDdfBlx+ZJP1nRNfO9lGxK9N60mEMG1BAwgoYzq/wIXeq2fdFpwuJH8Y+kj/HwAtLfods2b10KXg2t75BeYtTTfAY8ySZ+L7lEJthVXN7Gu5PPO/ww3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXz9bCsTcmyqq4wMs0lNg/01RoIHs+jK7wSGnNJZeM=;
 b=PVbUPFCeEFY/idX8aokw/tvOotHoSKm93AXyZPUpXxJyP9f9wwt8hsgu/KBIhoKp9IYyhyHw2YcNRfPCaM2KgKmNe05oj9JoVoC2SkHhOpsuZ2hiFGpNSXLrZsxgx9B+iXtseA5DE/WyfCBsRNoO2OpxTfPNs3LMEablrw2C3vUhVDtmPbDJ2bYwIpP4ikTy6HZIXuHMOtcAa7CAtAeArQniWlFBQeHDVJXsqCMj+IIgzqoybCkC6TKMib9GUHIoaeilniSbYXHlDZF7Wbqd/ILLzKXzdVsXB/VcUoGdg0rmX+es0yZ3Nu6XOkHRaPT0pLNNYRu+gk7uF/YccSqD8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Thu, 17 Sep 2026 05:50:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 05:50:03 +0000
Date: Thu, 17 Sep 2026 07:49:52 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Derive
 SCX_RQ_IN_WAKEUP from the core enqueue flags
Message-ID: <aqt_gFpEPQfBiduC@gpd4>
References: <20260916215713.2701551-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916215713.2701551-1-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 81514610-1c36-451a-c8de-08df147f84b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|5023799004|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jWNJNaIkcnrJ1vmTEH8Yf5HTBQAhZ/vYWQ1BkNAxyyShCWbJEDQFqEHwHS46ecdl8OC5FK8dSZwwRgCyB+0H3qbicbAojXQDVIKP8+vsQ+wvSfedK3U7vDu+QcC9AXEWgLuKSvb0wX62Qftn8jNr6TySAvNn3mNbt9w2wml5TLHxw9/XTVZYQ33ej88Y15HiaA8nbQ/LsoYnGPtOPYyDyN3nimvReAtWklglHdKOZWsP+ex3C5IXA6tuchicrSMC3e1oeYRDQbhrv5Yoj6SEKTZ2L3HBNUTh39jfGQGEraT4vl87zOvQBU5ZlPoVNISL+t0z9ODgTVfrfH+P74+b4COrO2yCwmRZwiq2PwxcnSgAuJexuVKhLcxFLYVe+WSeCkw9vGdl/ai97sKBgUC12q9jx54OPjXJDV6OOBoaM633powXDPGiv2nGsBT9xLGa8w11IUdEH2m5pQwBq+zMUI9FqN6Udi/Bd0MWG9FAgRIDTmbvupd1Petz37BKSlFrgDdNIKdQsfSyxSwjDAWwWJWWdjBSlF8ao+bU7ysyc4DJMEUkNyP3R8IAnc1QVMeLFEpGySiB37LWc3Ah+KpgRpAPS1EkgIsUIPHor3TbiCTfjalcndlqs5GdFZjgFxxqbOKvBKcc7pp46jPLnICkMNo1BmO3xyo2FFqjfheMNrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8qBLYDyryByhKnZvvnLv4N0tiHbjF7E3+uaLgeJalBrnP8G95wD++qjyyXM?=
 =?us-ascii?Q?yGLnvb3yrImHKX9d5KIUPHyjsbv7SUi9/7xma6IchOYK74ZDN+ImF66zwLWE?=
 =?us-ascii?Q?Of76q0o5qQJ/rV1AK+W1AX9cm3bHCVZV3Kt0OM8XSoD6HfyKQg+4RW1yHLuB?=
 =?us-ascii?Q?tzITj5XcApnfKlXmbNqWZPS/77+MF3SeT07NqC63UGrF66ybG7gt5v0qUkZD?=
 =?us-ascii?Q?vjkM9mpF94A0cq6UrIygpMZamMeL8de53WgY6fjGPUa54awOgws2mHE4uPvS?=
 =?us-ascii?Q?qFHn553nMrtizPBy6g5xazeCwcQptnhVAz3vaIZEIRAYB1EZk1ysRWScGrmq?=
 =?us-ascii?Q?uuo9oP3vAt+vVUEAkOwykW4vkWs0/oP5A6ccPKeEK+lV6MO/WA5RKG8IlNTx?=
 =?us-ascii?Q?IPdxlMdR7yBXLJ3X9gKCk4hMdgZew59vRfS1J/oGWnDbYhE3ick0J9m6spGs?=
 =?us-ascii?Q?JoFcE58s8EZKvqXi8ILsEZh/iuWdG5onKlTB4jA/YvkVPouwpq/XNSSKSNpc?=
 =?us-ascii?Q?Uodbh7wWl62L4Vq/XEuOQsjjFqTpktIeujxGV6tzZm6dYyBFjfH/icP+jORV?=
 =?us-ascii?Q?Q25E/asX15Cxys//fwXvQCiB8EAtv090tT1XhD9sM2Kte2ktWHNI/MtwgLwD?=
 =?us-ascii?Q?uTSn6aq339DOv+/8r27zj3ceasK8C+AfZrh0OIrzSLOEDVgC+X0KFpGwyGDq?=
 =?us-ascii?Q?DzUySHDI/lypkx2gdL8teSIlKc53kmvxv+RdYxDW87rCfO+/CS0HTyf66V75?=
 =?us-ascii?Q?vcrpYEBDw4xXnH4qyBBgYjTEV6mYNdMQ4XvZ2GTm5umPfjOjxrDLGgi8bmdy?=
 =?us-ascii?Q?Sgtjam+PY+LDGLwRdSyc7M1xnNb/XepU1Bu3Yy81369A34VpuC3Kaw6fB5DR?=
 =?us-ascii?Q?N8S9wMivKOT3NxFo80JKevms2MU7gyp9WdAqSm3y/RvDfdXK6xG5D1YgdOXM?=
 =?us-ascii?Q?jjPO+sJDqUVQCqT8Mw1/mKe+pEcbz1tqlrcmCb7ONPciMOdtAKejJHjLGF2/?=
 =?us-ascii?Q?vzVC4Xo3TY0x/jDCKeyMBAb59cuftD6weNnpqEnLAUVF3tQCKvwU6+ST1va6?=
 =?us-ascii?Q?OaG0VMjrDNC2n2TTAK42MesFfYUZ3QxTqFy8NSXVj72ZXceyJbbScsbgiIfq?=
 =?us-ascii?Q?cso+gk/LKKKqNbo/M4cS4DxyAd1tZLUw5VTzedwWtnf59cTXkQh/lb9Zch3a?=
 =?us-ascii?Q?fApFiichYv5QHZqstNl/G/58wBbUnncAHnatKh1LjG/51YAHKvnQKE6mtd2A?=
 =?us-ascii?Q?MvJyM0I2EzRsQ11hpraf3jkQheBqQ1gBKN6Q5u6ZiWlSJDzMqH/iyAbFa6Ih?=
 =?us-ascii?Q?FKr0iM0bcSZh1pF9FSWdytrXGfg0Psg1dCi4rKPGl569N21351fjGBYheb78?=
 =?us-ascii?Q?/IwvQ8UKrYrXMT/FxEz6wKX5pOT82OcE6W9C565WAZ9tTrGLcjkKxoXnfz7j?=
 =?us-ascii?Q?Rx5JCx1LRz1OE/at4HnbIpLqqHhMeQUd9KM5VjwNOlZFxjsXJn3NGHhzlW39?=
 =?us-ascii?Q?FW6wwZF8hc/C0jvoC7QOrCwZpxe/w/3NFrie6XdqJctmImLnGbdzZRrZ1C0G?=
 =?us-ascii?Q?roYR0+KKwRg/hjrnA1xyTrY+TuifJbt4ioGVzGBoGoyBjULgjyL7z+0uWYYq?=
 =?us-ascii?Q?0lWlOITWZYz9Lr6j80yAXKmGTi80UJAmNhAIYV8A2+rMTRH8q6vzjGKSLov4?=
 =?us-ascii?Q?CiIA03oPrKtJnBYe3o/SGnE6K/KtC4k+fl92sVxD07ig2I04iulvMRgj5IQ9?=
 =?us-ascii?Q?4PAH2HdVfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81514610-1c36-451a-c8de-08df147f84b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:50:03.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p40mFEU/URmziXM8xESKqYAIwVfq/jOYzJKcIfXribeqS6IYCWyRR1cDi770aJpEr+0CopeemXs7xtBpL6E6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

Hi Tejun,

On Wed, Sep 16, 2026 at 12:00:24PM -1000, Tejun Heo wrote:
> schedule_deferred_locked() skips scheduling a deferred action while
> SCX_RQ_IN_WAKEUP is set and relies on the task_woken_scx() call that follows
> a wakeup enqueue to run it. enqueue_task_scx() sets the flag from the merged
> enqueue flags, which include the flags stashed for a remote activation.
> move_remote_task_to_local_dsq() thus sets SCX_RQ_IN_WAKEUP on the
> destination rq when the moved task was woken up, although no
> task_woken_scx() follows that activation.
> 
> An IMMED insert into a busy destination requests a local reenqueue during
> that enqueue. The request gets linked but not scheduled and stays pending
> until an unrelated wakeup or preemption on that CPU runs the deferred
> actions. The IMMED task sits behind the running task in the meantime. If
> nothing runs them before the scheduler is disabled, the request outlives the
> scheduler and points into its freed per-cpu area, which the next scheduler
> dereferences from run_deferred().
> 
> Test the core enqueue flags for the wakeup bit. Only the core's wakeup path
> is followed by task_woken_scx().
> 
> Fixes: 57ccf5ccdc56 ("sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags")
> Cc: stable@vger.kernel.org # v7.1+
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Link: https://lore.kernel.org/all/20260916145807.3250167-1-arighi@nvidia.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

This looks better than my fix.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2141,7 +2141,12 @@ static void enqueue_task_scx(struct rq *
>  	int sticky_cpu = p->scx.sticky_cpu;
>  	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
>  
> -	if (enq_flags & ENQUEUE_WAKEUP)
> +	/*
> +	 * SCX_RQ_IN_WAKEUP promises a task_woken_scx() call once this enqueue
> +	 * returns. Only the core's wakeup path delivers one. The flags stashed
> +	 * for a remote activation may carry the wakeup bit without it.
> +	 */
> +	if (core_enq_flags & ENQUEUE_WAKEUP)
>  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
>  
>  	/*
