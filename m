Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527083491C4
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641521; cv=fail; b=lfiL2Zce5V03Kkbcrbk10WR9Jv2ZURkV6dMuh1ufrNGhdorg2yt0c9iOoK9LS9kQskhN51tebLOHlO/aVHbrJtLdZ/3NmNTLlG8ELpvYOe4uxRdXJMmuUCJ2q40Ce7M+uSVThA/w36NI7vQYw+Ke0uPPREmXM4g1/4agYSormmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641521; c=relaxed/simple;
	bh=aKiTtLyUGTgcXHJinhM2ijOjOSfHnY79+GP808hJUhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VNV+VOQ96nH612FU7zd2lOIW0GsOH7zV5o05X1SH0jr5vlfjYtSOr263bP8ZO7T7k0F67EKcURAryvAYAArZ7fKE1EDTTkBsL7s0rWyulm7xmw03Gf9496LevJzARby2bM20FNcusTu2unDQ4gwXiF4ku8SqresGTdpmcMPoD28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNG4grQq; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNG4grQq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5V1iFtrctvQS2+tRJO5L0tZ/7RUUMmfyDNZQxMv1tob4eOkMM/akilhMl8p8t9JIUnh3fFaAWRdHnSda2REfiEOl/+AS4gQ4osRR4NUefwqkp7z8MG4D83ZbnkfBqpHQXgpix3WHLzfD686J2B1NPDRHmcewa15RmpRVqdzzDIR7vAs1pNJ/pUDZS5TmRjde0pYgAqxDhGtVM1wdkYTgdaV5wFVazHCA5BChBuCanAYhYDVFb+i+LbO9NgN5xZPIUVHRPBHxhOjTH2BOxxsHl9nQW8yTqZaM0KwuInMoHoYNjnbUlmyzTekOtzlsPL0dRZzn6vu2uxn5EqW6NKDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE1rXL0worvXuTOpyBZxu3GoU5QS5IotSe1m8skLLFk=;
 b=tw/e4aelsZgvvPwrR/p20cmnL8Du/qAypQlcKEkXee32vNzN0k9OEHKHd6i2UXp5AceqTHNkdNcKXN8tk9WQR3D+d80tRXIJMriCEc6musR9oby2fhk69wYG3iLfEUqIMCPiMxgHWJ8qNiP8YRGr6XCPRN+cBi5D/5ORwxnjdcpV1cKXk7R2RXGw7q+iVjF7wtq+Gf2Fz9CQXjt5NJ6HJEjl637+tEGVmMmiyBn9bFTjfk26bYJfRFpZZc6gjHHY2TGc9NuHQzdq3HOvW6Gu6ko05t7OSqInan5gYaloUD8IHlNAAIo+QdP/bcx8W+d4cPfJdHouJSsK6ZmKf7XJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE1rXL0worvXuTOpyBZxu3GoU5QS5IotSe1m8skLLFk=;
 b=iNG4grQq7jzaRWxeAE39no7KAs7FzF9v9HUC8CcnDQstHVs8e1+egKbcpooShe0n8mjXPBC/RzaU82deBVJuqxddSo+GpGwCju+K41FLclXo8/rvJXUK4smmo7KjADVm2Y6UxAPlUCUydFL90DRMEoG6JIO2B3nemmTTlylnTj8/x7kWbB6JIh6CsGCZU4RTvk5Gq61AV4Qvh5GHfVd9oujSVINGd0aw1+GNbDmnsD+l0n1atJaFIqamoKMl7RMUecusfBs0gUjP4kuqoOzTo1dnCHz0HvR0FTGYJm5ObJdBwzsB0FwOsn3sa7q1lCluYMXxO3+xbFvAJPj47SYnQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 06:11:57 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9700.009; Mon, 16 Mar 2026
 06:11:57 +0000
Date: Mon, 16 Mar 2026 07:11:44 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix cgroup double-put on sub-sched abort
 path
Message-ID: <abefIFqKlWofXRN4@gpd4>
References: <20260316054328.838304-1-tj@kernel.org>
 <20260316054328.838304-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316054328.838304-2-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 24da639d-2d2c-4ad7-de94-08de8322ed94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	RrPmAy75ZLTywBDLONanzfT5403BVF+oWce8o5oAbBYPddPKlV7xMqcSFOBPmRRHlZiphUhG1c8WoURORrTU2z+gpf0gocYseEu/yyMw6sKSc/jLd9f6D9O2rIBiBf0b3mUkJI7hitOv2GOrKgewVNXcWtrRF5IuQgD8WnBWoRQtWHmSbpgiTjs5GPTWRsbfTjL6dYD1CfvvouGcROPPYoHQA1UN9v2WAwJIrRQQuB1Cnyyspg9TTGoTg5vPEiNls4VrPr7Cx1MtGRHcaMRIetpOk1gpFmI/1T656qqBEJq6xoiuJRjsAczVBlFbFRoTrWS9CGsMDLmZGbxZRKG54MZ5wBrmzjRmdyf7eqHPoB4BqvpA1fPcm1qb99kUvVWVCbfG4yAvZdjAvXH4nDKidnTRD0cnC10EvS759mS0z/Vl9PH/R0ymQSBpOgCu64FmUTElSRQ8ed6ojvhMAEiJJidUiPTMp4tp70Hlnnjqv5z0aqPz4MlrTBg6rGNIV+6+ulAYxmd5I9SiXi9TnacLIbFLEOb8b7m6zKs64C+r0RSEpn2WIcFapnnCxwOuwl/FQDRL43k0hjnShp9bumZIgjNHsAipt4nMxMMIsDp78t98MODXw3erUnYXRRyr8bat0yap8efZTbSL7+43J54tWbhinj5Nw65IspmQpf+yltSdSkomzJO0szwwVT1RgHXMnVlZPm7vgKJXqON2qOyEHO6ROfhxsfdK6vs0UPjtAbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1iCBK6yPX0fYsYrgVUOOK54sgrZJzHj17lNjHm0uSgf3NxFyD3OLtZuoQ94/?=
 =?us-ascii?Q?3/2X0yW98/S6lNYnvzxCuMlrQByf66lN6M/dWBf9xuTTspFSOK4FN6D43y3m?=
 =?us-ascii?Q?6kAxBtk227KWxqrpHuAEAFr2SDQss71shX7MRJtEqrCcpJ9e0T87je1n1P5n?=
 =?us-ascii?Q?NOzHrTcgK1B2hI8B5ER6vGEc8Z/rBQotq78k/KUUmf9B0G6UlpK3sKjLbFc8?=
 =?us-ascii?Q?4LUoWyAyvB5xRN5yqip8/BQr0nDj8/NGZYY6qlrIIfuEUmOkikguU20cq6PE?=
 =?us-ascii?Q?PgIiMP+xP/XugWjtlbNtBoQ+DXYKmWhFfL3WklG+BdxvjVhqj+mZyy/uYrXn?=
 =?us-ascii?Q?FftWbQSYvxspWlBT7kKKfqqq1pJyUdca2atdmhJ2vomma8rrDfalu/DqAsye?=
 =?us-ascii?Q?OONjkKzV4Lg4XLsEOdl+P4+rVzDGGI1270Sm0MjkIptFwcPUBpOC5SOqSzvG?=
 =?us-ascii?Q?W+N6zS5p3kRkL2Kohe3fijxoEoImvPKpP1xQJHu09eXTq8DKjqpz8w6c6D8G?=
 =?us-ascii?Q?Q69ltOMUt0ndKHi3OCUfS373QBABshtCJm63c0Qi3Pb3nQYJ2sl6fmEC6YR/?=
 =?us-ascii?Q?6ocUD7UiHEO06zaPAIgbQ5yWiYBsDrzy+S9yiBQ+ErJmNnBU4PWufbRbFLcj?=
 =?us-ascii?Q?p2KKUvDAGsqwaGPvUIt3n5mGZ94eav2mogBOwzsOt8S0AtgOyLrXVRxolED+?=
 =?us-ascii?Q?KX1Q2Wp8jcq148uGGGQT7mXPrXLX/h7w76+IqeYv6UGNNmVnaVY/y5EyqNes?=
 =?us-ascii?Q?YXvUK7U+qPlpUnDMOWOSa1Q5PLTDN86YoXzlESWaPzV2nom7TjwVhgk9AQlz?=
 =?us-ascii?Q?frGdsucky2A+1cGXjGO9WanMOznlSw32iCJkEv/Dxb96EDzVDPBCSLfZPSxD?=
 =?us-ascii?Q?TV3AsHJDT4z0LoCjyA7xQBXPBPjzQ2BTiWiQytLVXvUR6rMmlEwDaKJw3iGY?=
 =?us-ascii?Q?jMUJwBCHkPf4/S0uxsJyhLhQde7sU+rmOg+QOOF/6qlZfa3LQAiEkOmYLOXw?=
 =?us-ascii?Q?fmv+EQfe5K9bD/wa8nZ302kYksfP7TxMxPBUQkn5Yb5gvr4s0TOghbrfSLep?=
 =?us-ascii?Q?R3wZ/4sNFATa1dVGax0K9Hm1glMfZ3g6BeCSNitIEZksXSaSJRH+dmMOy31Y?=
 =?us-ascii?Q?ZdImmThgFy3BWr94DhECtHpJxqZh461fjarq/5/MY/IKBjtbsqe4u5bP42Ll?=
 =?us-ascii?Q?itBlnpDGHJx5Qfl++wCYv0IRDWiGv+XYOTlqHmdZOFolLMBcFJfbVpmTeKY+?=
 =?us-ascii?Q?zE/qVfjNwY0MwN+htN8qxO/nhJCTVCcQm6RdSa+vOfUp8CPhPnpIHE+3w4EZ?=
 =?us-ascii?Q?hQ+F9WTG/WPDIU+wVqdKsJP6eGsyzBHxQZJDENbQF3/HMlvXju6gfMg+8Rlh?=
 =?us-ascii?Q?LeGQhUVEc9PiQe74KNd60eSISmD90AnCbVagunDjsTR0O2JRiR2PhsHAz9aY?=
 =?us-ascii?Q?6eqBPcZoZcRE3jcLRXu4MPw+2AhPZbtVBsRpSlMgtnCIfVrz7NMwfXXj4kBp?=
 =?us-ascii?Q?dIqQSj2rDw8QsbnMqMdxzqIclxnlRWw27L3FkQxjHzRO8ocmodgZ4/ytD8+s?=
 =?us-ascii?Q?Sdbok5mRqrXrmaIPXr+viroO5yRsypT++TiXpTT+ShFNsLudejxVdlY1kn5G?=
 =?us-ascii?Q?3zsbvTIYEKOF7BxNBgBvHr4AhxzIAWk/vilP/FyRh6AMjHPnMdvjwfLKzj15?=
 =?us-ascii?Q?tscAIprhTehlcMXu87xchuZaSrU9r1Jp/+ZC74grKFEHayBFVoAZgPANOo2g?=
 =?us-ascii?Q?wgWKaZPEAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24da639d-2d2c-4ad7-de94-08de8322ed94
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 06:11:57.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQ60YfTAg9XEsJ7AvoAZDFPVYUH2rlO6uq2RfkN7U+w1NLJ9fFwzzqzprvKKV8oN0kzbNp0N+TmvQEmVEY4p6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

On Sun, Mar 15, 2026 at 07:43:27PM -1000, Tejun Heo wrote:
> The abort path in scx_sub_enable_workfn() fell through to out_put_cgrp,
> double-putting the cgroup ref already owned by sch->cgrp. It also skipped
> kthread_flush_work() needed to flush the disable path.
> 
> Relocate the abort block above err_unlock_and_disable so it falls through to
> err_disable.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")

Maybe we should point to commit 337ec00b1d9c ("sched_ext: Implement cgroup
sub-sched enabling and disabling")

That's where we added the real sub-sched enable/disable implementation and
the abort block.

Apart from that looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9202c6d7a771..2f70effcc4a6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7050,6 +7050,13 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  	ret = 0;
>  	goto out_unlock;
>  
> +out_put_cgrp:
> +	cgroup_put(cgrp);
> +out_unlock:
> +	mutex_unlock(&scx_enable_mutex);
> +	cmd->ret = ret;
> +	return;
> +
>  abort:
>  	put_task_struct(p);
>  	scx_task_iter_stop(&sti);
> @@ -7063,15 +7070,6 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
>  		}
>  	}
>  	scx_task_iter_stop(&sti);
> -	scx_cgroup_unlock();
> -	percpu_up_write(&scx_fork_rwsem);
> -out_put_cgrp:
> -	cgroup_put(cgrp);
> -out_unlock:
> -	mutex_unlock(&scx_enable_mutex);
> -	cmd->ret = ret;
> -	return;
> -
>  err_unlock_and_disable:
>  	/* we'll soon enter disable path, keep bypass on */
>  	scx_cgroup_unlock();
> -- 
> 2.53.0
> 
