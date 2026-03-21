Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4A29D26E
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103730; cv=fail; b=f8xWl1qDHF4Gm1XHcmx6Z0Un1mLUs6N7r9gGalmukqsps8kakKn/IQV1KwyH1FfgpVYVXm2gh869rQX41sgDULfVm9mKLG+ZnDaLoTsriefNEd3bMSlOaVegRYFRTJlwASPoPMIQRSjdVi2Vao8hsSk+2+WVTshWM5pvdKoAScA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103730; c=relaxed/simple;
	bh=i8oDqi+5HIWeNJWLT98rT2b01XhToSIWzvNHo03Y0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u67zj5c+Q6Bk9Cum6PeMmy9/SnpT1MjnURbxvTBF5Bi3HO5NP2ObKJgYBnG9I7X0H7L5QOWIL/E0EWlgpqVdTIcAurHOawWz0/cWSwJkPVqe8kup8WCxCNxyiIgvJYuobhMbtcxh/Dwd7msMmYGB7U7Fxn7TfOqdHVqgwoeWSEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIu0dlDG; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIu0dlDG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Thg56G1KQTcjk44nuvN8spZohAlhop1/UoU5MWlmH4tYqCoO2njj/q7+hfSyx3cakOOrjxbOML8DjARGFU8gSPhK6y8OBoK8zZdcDsTi8ux3Xk3TyQu49zZAdOH27xh3aC4ZK3HmkNdIebnyCTRr5N9h3znHdPtvnptt7Gg8lZVI9v7CcU4UtyDL4RfgXOvzLGD8SHCw3b2EARYXu9007vgb3CBxRg7jDF4PsGpSxqwvbe2eKXwHDM7buwIsuvcizaTiUAbYUkjUbU0qZHqdMIPlLeJg4peNZnkPcqqFgSXa/s+//gcHhbBl4nvPLnbZ5nZcnb1rRpFV91nhnCeNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inEt58UdURMw3u03OFF6u3WnBo+zIgCSOuELuhaKrM0=;
 b=Zoi9B+wX3ivcx2uNidpWe/SJ43tpAwKofXf97AG5wfbdQ3YIZ99HQdJeJ1EV4YeSc9V9Ueocot3lDIg5pnKzwWliMnLKeX0iAO7ohvZOCLT+ZMfvqM8krYVVgYctNqtzOlmdj2Nd+UsvMiHC9VURxoKx4wlOOokzWLkyoYObCaYf1Udk4I/DbH/JHfRwDEZOPTNOl4H1VV/WiLWVyQhq/BN1NbCw1Fmfw66aB6P3bNYPUu2Urxcyj7G+j/MUapbPEEbrCJE/pHiejUjupxBkbu5XdzGFJEoEQ707zg7SbxFhrsj2IBDzdLFy485COOJEMu0iBw9vQu1B7PRvV4TRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inEt58UdURMw3u03OFF6u3WnBo+zIgCSOuELuhaKrM0=;
 b=ZIu0dlDGUCHTmGPrwhdKUHINRfDrTPWmfZcciLoSeGq5LwMAyXjn7d5lsimUvoW2NlvMSGpAhSc78WQ86NdnmOeOi3qXdMlcUDAY8idpGoxv1tmKnBWPCC37fhx89wWYs0onaZGrxLwRQ74PHNF4W7ISPC/gM2w503MG8QIrOTBSrQ4CGo46qfw8ERJsQ0nIq3FuArjKBLzLA/rbTrtpsVZB+dX1PBYZGZjhpZRqDB5nkHYRsAu18nAuMlpwmUIvd5RABjalESEJUAvE5ySBKNmisA6/rr+Q2szXJ0zXsxI+N6bh6guEodotWCZs7WdcTkwlvOYkPU2B01NKT7IIMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 14:35:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 14:35:24 +0000
Date: Sat, 21 Mar 2026 15:35:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix build errors and unused label warning in
 non-cgroup configs
Message-ID: <ab6sqIW4p8QKYQXA@gpd4>
References: <20260321070605.691776-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321070605.691776-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 844f4061-6aec-47c2-a6a2-08de87571651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	U5jpuA5y/fV7nHjJ6hrbh8M44FF+GA/TZxnRrfE0YOciokgFTAFMzJF1CV10W+PeUpnlmPx1ScYFd9byArQMndogsMSagLoarmHY0qs5gPblqZJnZK0WcVBBMlHAN1hRCMJw3G3dIIKJRywBmORJ8393eyU0s+0Avr+qfBApfB3YEb4S7E0zEZtnsVeuPrDBUec01aDklxc4/JJSyUoauAM/UQUD3LDM2ZXUcvgzgiZ9LXSbP1DZdNik69neFqOSHDb5ssA3751/2UlhcHYn2OPdqqxs7fR6leTvba60SQLbmV6p0d9jvc/D/+iUnmBzzhsJfHlli96pbkYGm/uSUMkOZ4IAreUR9b2p08k9FhlKs+ve++gIBT5YtPTgri+BbNeia2Q+RVuLn2oM8WMadJd3DfCW6IC+PmY8qva5XoGm4YRVb3tt9rdxLyGzjWliafynjTCoK6EZ0lCNzz5GlJQPb08mA6YgVSccqqJZiSNbT3rxcCRsUSdohTs28C5seG5AEwMMLWhAd/JVOAxFmyyfbLNmls4A2R6py8+kuyZ18gBv80w0rw0FvpF2ruRu4/GwQ9B6GXqTYpQkNBLCEC+9u8HyDXMyHMzI1VhejZzoJye4JORLqvEUZ7Dv1+ZeO2ScBORv9s+Yo9ckx7ZmvBRjfEb/JItVN8NEHwdgcOsJ7xO4B+NNZjcYEj2iDJ7/wCw0Dm8ge1zWQSfWzaxp438uhOuwIpdwMzLI1M6T8uU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssGi9YjTFjoKaih+nBVwZbcvsByArU78dC/6lmOQga0sXhMAixNMoT3CrXor?=
 =?us-ascii?Q?Fz4FehCuazpSTBhpcmAu4WgqR56giEbTKg8CruqelLVTqIaMKieSsoy1GO8F?=
 =?us-ascii?Q?gCuTtxojodzl3ZphdxNMJyDxtyJjIc0XZR4OBcMjAkAB/r5Xv68G+gsN/Hr5?=
 =?us-ascii?Q?phvN/s7/YC0zP8dfZ8z+2J5QDt6m6BcQo87/gYc8EIkAMKMN/9GOtcJLMXjO?=
 =?us-ascii?Q?G+nQ6W1ex1syUnn65ljDP1mlxcdZQ736cA+Y6OO8pfvMUGxXBN4nRRvI/6vF?=
 =?us-ascii?Q?Ezjawg4w4RqEjfY+egbirP7KsKUQGEMfq+10vXTvbgOd+460DSAyhV29+t3a?=
 =?us-ascii?Q?e13QljMjsVVDTlAYWk8KOHDt7RgiXA/SaJxl749IJLzrYF12GFwlfF4qWs6O?=
 =?us-ascii?Q?rleJ1nrflOZavncXMltMySdH3e7nVLnxUYBA+xkI3lr7qtcPeIPUxjSK0hUv?=
 =?us-ascii?Q?1kW8y9U/kNihd5Mgbt7Y+ilRvLuzqWE72jFfHFHd9TCmdEV3IS7+MSKX2SOe?=
 =?us-ascii?Q?FI9cpjAQLThlE+l6XJkU47GN6m4zqvFiwbAyP7fi/u4y+HQkN2ZOODiwM/MN?=
 =?us-ascii?Q?LQsaFXHg78VCFS+q1jYFaOqOIvyXP/pH5B3ET/ggVFwKj3hSxkRibxl0yswG?=
 =?us-ascii?Q?jR4RI/wkdkBmzs1ZVBNuYOLSaRHyAvZZ3nj+4XPwgekcdL8FoJHEh8GZC+4X?=
 =?us-ascii?Q?Pe9HWlvT4jDbYQoJoCXATJ0Gh/x2L1IKyNtZUk8gso1rd1Iq032ypglHip22?=
 =?us-ascii?Q?1rBD+rQSQF85Fj90ZKSed45eXlcaKU2vAL3lrL8A1IK6tuNGfAhFA67Mbaid?=
 =?us-ascii?Q?xCqBG9peZh5oTYHNSDEHT8Q0mkGB3YKTM/M6ETxHD3dGQBDnLAIdkLkGz5tc?=
 =?us-ascii?Q?Hzlh65hyzgSHB8uS1sfM/MfJWnKzXzp+jZHfupg3AEbPkH1RTxrRA/oxaXZz?=
 =?us-ascii?Q?fuH3MRoJOPMZ2tAo6UeMiymM2VQb8cIB+n/I5IbjHo0FqXRqIex9jQU4q8YW?=
 =?us-ascii?Q?SFvE4KtcD+461lOYMwIe/maChsOkLWB6ndVkDuMZBH44W5IAtHynjr4CNmJI?=
 =?us-ascii?Q?Wxn1uaq5al6IitsYGiEA2HWHrn882A5P+qxTaGXSFaZ5uwsyf2G0cOLRpLTn?=
 =?us-ascii?Q?HxX7TPWsGrbcNs9noxttC4npiqLUPwCLX/30faFsAuFpaqzF0G8ge3B9gd9O?=
 =?us-ascii?Q?1twJlhf8tosiK9BVwsJs3QzZvhiyPHUD1MyPhXFjOa0zXuCcsy3cuTxLvNAM?=
 =?us-ascii?Q?q9eDK/H7C2oi1tZFJawBRtxx8KxmbTDu9nW45WYJo3HUAkOZqVNkbEZMOSMr?=
 =?us-ascii?Q?kNBm7MVU2IixYdZF0+z2QvmGUlSgWkctnstGydYhs2XS/n9tA4Mk2LQmdrsM?=
 =?us-ascii?Q?OLmp9Q4yoq1aKkKe9+Q7uQ7XDGp9nzu75kw8SrGayXkC6xQ8VnDFnEmYW9Sp?=
 =?us-ascii?Q?TZrXOMb6IOeJA+bOM/KDvjZb8KPFOetswYDYaR4y27wrBpDR558AvfNIE7G8?=
 =?us-ascii?Q?kXALkZaWx0MOxeKxHT4WQIH6CsDYAW5rrEqlR2bM158GIH+/b2VLjSJ4fmg4?=
 =?us-ascii?Q?5ADrXB2VWCjvYhEYPMsWE2Rz3Aw7JmSXNvfaGyD6c5Con1hKQ5LHvXs1P4Lt?=
 =?us-ascii?Q?WbDbF0daz0oSUeW9oemF8wma4MVYr3J3NbJ6RKSEMgklgMgZZNo1fB4R5Pj8?=
 =?us-ascii?Q?M/3Whw7lf2o0m3Ai6FllpKmxedIi0p9yOQaypdydbIlrPjKza8LClbOxV7n4?=
 =?us-ascii?Q?GXs5czXXnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f4061-6aec-47c2-a6a2-08de87571651
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 14:35:24.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX71lPq6dD4HoVeMBCJXg65vk1oGWumVERBKKqA8eHc+3lEh9oyUnqrE9M6gCa1EyAIUKVDa9Hy29qJ2elWSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

Hi Cheng-Yang,

On Sat, Mar 21, 2026 at 03:05:15PM +0800, Cheng-Yang Chou wrote:
> When building without CONFIG_EXT_GROUP_SCHED and CONFIG_EXT_SUB_SCHED,
> clang reports errors for undeclared cgroup_put() and cgroup_get() calls.
> It also flags an unused err_stop_helper label.
> 
> This conditionally compiles the cgroup reference counting functions and
> the error handling label to match the configurations that require them,
> preventing implicit declaration errors and unused label warnings.
> 
> Tested with both configs enabled/disabled.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603210903.IrKhPd6k-lkp@intel.com/
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 94548ee9ad85..2e7a1259bd7c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6494,8 +6494,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  	return sch;
>  
> +#ifdef CONFIG_EXT_SUB_SCHED
>  err_stop_helper:
>  	kthread_destroy_worker(sch->helper);
> +#endif

CONFIG_EXT_SUB_SCHED is always defined whenever ext.c compiles, so this one
is unnecessary.

>  err_free_pcpu:
>  	for_each_possible_cpu(cpu) {
>  		if (cpu == bypass_fail_cpu)
> @@ -6514,7 +6516,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  err_free_sch:
>  	kfree(sch);
>  err_put_cgrp:
> +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>  	cgroup_put(cgrp);
> +#endif

This ifdef around cgroup_get()/cgroup_put() also always evaluates to true
because EXT_SUB_SCHED is always true regardless of EXT_GROUP_SCHED.

>  	return ERR_PTR(ret);
>  }
>  
> @@ -6603,7 +6607,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_unlock;
>  
> +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>  	cgroup_get(cgrp);
> +#endif

Ditto.

>  	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -- 

This looks like a false positive, the kernel test robot likely tested with
a manually crafted config, so I think we shouldn't apply this patch.

Thanks,
-Andrea
