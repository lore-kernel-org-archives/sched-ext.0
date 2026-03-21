Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB658218ADD
	for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135616; cv=fail; b=cw54jHiK2ODT0IEjlKj0kSBOLCi3CpoeIMBmG1IjrUoSy4af/0/N/Bq5q/up/+7X0sUySKbdYLb9BqcW0dsFqwxAOZYjhdbdekTGSotvixQx0NOkkfLkSOyf6NhTMI/i7CJBK8sQy6y1eAqAE0TPwUXj0JQNmbo8GMz8Vdb207U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135616; c=relaxed/simple;
	bh=poDqAyB5Zufov++qtst0vE1mA9sSMJ/Pnn1FktH+8LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFOSppmi2Dc+XCm9Urwes2uifrV7dC1itC91RT/P43Nnqw3vlYjOPJPkCAg892X7FIq1dkeQSLaosASbKWg3uW/5lx/XJ8Oy1uMTUyaZR+8V+4Wc09TA09nu3PBguBxWDRDPYAszg2bNcK3/kAxV+0voVBU0U1DlAXo/Gr48g38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1YMzuou; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1YMzuou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Y4p42+XVskDCCvySGSB1RiDKzvp8QRJuux50+NZqv69oYBf3LivWGle8mkNOcmvFCCOB0zMBon/YmmCqPmHCvkcUmCsj16k737dWIRn/UMJJhbQYvYA5C0Rhgo8u3Gf0ZDfviPptqfZcxSZzho8iLs3rpJdeJCnJ3lnDBqFtocoKK1vZA5ALhRLgY5EYi8dsroIqONvhpxtJx2CTtBpVZJ2Vi9z+rOt+tXlcx/K9x9LjQXOaAh8rE2lTJ1Qh22hoocrfIppvM+MfOzROnVk1E6Yubdux0l0uoFoKrXzdiLIK0dq8SdS7XCHUFnItjsVV8xi4YR4IVZSLqrVImunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKGkbnBDEjjUBdEWA6yTxquu0nCByb0aIKe/x1tdjpE=;
 b=wqx3FcXpecfVNN2+n4NNHsRarzFMxn1qzCHL6Rorvf9APhSSXfz7gKlCV/Gwkfa+6EPmPe6m7n0VMAz3ZUpnjq3E02lzenf0W47WbKJeDOR1L7qHtLVEzra4PZwo0IhjO3cW5oH9m9+5y7B9mfFwrSw9oSrMslitg0pzGJh9C33V6MMFVS9Z1DwfZtUm3tXViqHB0mEBHLT4Wew/PQMimqH5PjgghnQHNqxG+mYPnrEHlwYJtY9fC9wRwq9PNI6wBuXMoaRUqCuEnUSzqOPWOyddLnLQGq90WeEHthGPG+aY9SH3vLjHQ74wo944m9niYyQA0JlQt8V2YxFEu9OXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKGkbnBDEjjUBdEWA6yTxquu0nCByb0aIKe/x1tdjpE=;
 b=N1YMzuou2IGP2cNzTvOTPczBl7TBp+3zACsL2tn9SDLhz0HAIzTvCQBcH7vTVK1JTw5V2evSPx+s6Ef5vG315Pef968ccGItYRZr2eSg8qOKouGa2bRChPgjreNe453GAMC9w+cdsQgLO2M0SkCiMXsjeVgiHH2Wui5FeyPJwP3GURj3MZUyVoiCvEjAG8eBDY4AgdrWs/NaYccfrkw22AF9IUex07sO+pVTpeVnIkP+iqsrKjFNZiB1ymtR0WJlQB/WDseJdTRvH4wA0QPnKCC3QMkuYT9LH1f7sojyn69nrGFwHchXvkXYeoDUMxYvVRV3tWtYVmqPEBX7uVICIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 23:26:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 23:26:52 +0000
Date: Sun, 22 Mar 2026 00:26:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix build errors and unused label warning in
 non-cgroup configs
Message-ID: <ab8pOX7ef-dN9pjJ@gpd4>
References: <20260321070605.691776-1-yphbchou0911@gmail.com>
 <ab6sqIW4p8QKYQXA@gpd4>
 <49aeada41a0e78e9673f053806321df3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49aeada41a0e78e9673f053806321df3@kernel.org>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: df22f1d3-b443-4b03-2c44-08de87a15516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OX3M/ZL7tEv+IgrUD7Ii9vDmAofc3MnUTp74mUvohBhavSPKL04vxwfgMZhlWq+XEnK6cIlGPJABw8+AYbGdxdpS1Op/uPkSEHwA9q4oZXvI5MWe2U0l8xigHLYCKOyKy3JBwbJ6AkKGxfYtqBevS2aTo/SU/qBTjRKq2IvnOkoaVH7KSFUEIjPJzbMnvMpIM00+tUdk1ctIFpxNhCoBBHcFOSRaIMsBnXUqIohbQs6queMsPJP6vzPq4DY6K45ojV6b7F9Vcs9v4WZvU9+y1GmtrdpvZckaIzUxDgkPs+zLi2ogqpyLlgoYuk71LH79yuWu9Y8dKPw0Qo2rR3XgLbfXbRLsWV7tjkBN3uyRSsCnLqIhnAzMXQyJeBi1hFZx2HwMqA8F80A4lQGmyUxdb1OozlHS0ypZmWX/KpNig15FDz6NwP7LWq57DxnAUUMhtUpOBTYSvbnBK1SA74pdbcXN8Qps1FIhQ1RN5GdjCdgqW6FGxKsUw/uwx3WrTIfgZESK5vRpMyy+cGqGY4cqTUYJ3pA2lE+/RpFkfOkW/mE4mIj8DfunurEL/WKgxrKtXQnhdqzLlLxoKLEJZ4cW9ikgck+hgDH9kARl5QxO5yCeO+tHd8EMvHdaO9zdAGd1vU/0ChPBIc0g2hXj4V+2tVcZywuV18abCxGyVwJ1OgJFV6z5LNZ5tMae+sFaUh+CRLG6TiBANndCaW1dMG//LwjSvSgzG8KoDmjbXOni8CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KltuCZi8VBOOTetMq+fpb+e36HTn8GMpfxtYQfdzikgVi2P4GI6JGXeP2jkW?=
 =?us-ascii?Q?Q5/elOzAQYTPuMCJf6pevAvlrIcYkg+3cpw/ZgXyWLfeeH0i2nykREDzYKQG?=
 =?us-ascii?Q?cweo2V983+rbZIS8b5IPQgiI5fC8PxZhZVt85w29+ryopoYYCZeXg9aNYY2U?=
 =?us-ascii?Q?CMrZ8PnqVFtXYzi/ild0O6O++jESafGFokApBMYWQ69D8AtrD7oa0/EM4FNA?=
 =?us-ascii?Q?HMxiblMogUjO45d3Z0bdxXvnM0ttFzIRZi733HFhT5w6oaQESSrFETDw0i9+?=
 =?us-ascii?Q?KPCkC8vtbzNPl4Y3QOMiJOERF2vgli23WzWwRPZVC5GACeygsqU9b6EccgyP?=
 =?us-ascii?Q?5fIvVMqzq9pNR9U8w2t3Lruc104lFUiwUeaSbS9litSpA3/xoCALt2i89ou4?=
 =?us-ascii?Q?3kFmDeRBCPYbDTHjnYL4pEZaTLGmydy+dr7tA2Km6ueTo3kYDi3nhO5bMA2Q?=
 =?us-ascii?Q?MGJCCx4Rm802aMt2FKEdLUcd9ciEmv3qKoJJiw8TQGkogEDjN05SW7A3RDb8?=
 =?us-ascii?Q?2A0lx5S2BnmgKK8bRjdDAtIytiupS50tsEwjg3LQm1UPe3aLkUzb3HzKo8q5?=
 =?us-ascii?Q?mLwWdA1zFVov6XU+QvFc7zffqEk6L+ulCyeMEJI06cN4SmYfCPYcZpTF/Np5?=
 =?us-ascii?Q?ya4dJSEXf3T8Gt7dt/xeMKAQhKpn6MJyJeox+kUWPYEPrbuniFdr/NeC3QqZ?=
 =?us-ascii?Q?F9KPJEaWOJrjOv1tbrcJuGk5OQFVWQ3ZNIqgKFOu+MdVw9GxEarzoKj639/E?=
 =?us-ascii?Q?7xVuYXeUIiDD8yqqNPMOwIq//g4V80A+AJgYxG3ILNHZHRtEYrfBMpY+vNZs?=
 =?us-ascii?Q?1XB0JQ5fDKbijF3TsRSKrd+Zae9+aBbQdbu3IQQ1mPrDF5QuOTev+MOQpMG3?=
 =?us-ascii?Q?13sVMMBkl5CxWpn8jeEl8+VGoyyd4jpgd8k1dj0qaEdTE6mDmRkXI+mJhPF4?=
 =?us-ascii?Q?kKxk1ZFriuFyE80Cw5z2jpkzYblCSx0o8SZuUsYHg7ANoAEJBQzTD+DYdnlj?=
 =?us-ascii?Q?2Q3pd0FAgJfsMrpnQAHbu8CHN0AWGEYAmfla4kIID5tr64C63wHT2jc+Nwpa?=
 =?us-ascii?Q?s5j1gi1N+KnLzw8ZDynntOKzd3herVyxcePrg4A8sOmzoBKvGKzs5QlW47ZO?=
 =?us-ascii?Q?3b19HSbW4E+JAMd6D3tP2kSs0meXNMz5mAcSmktxflG5ZfaN/q1VbnaGN+CX?=
 =?us-ascii?Q?IDRH2GbF1GWCXk3vjmXHAptzrecPIiMIDE0+d3/nxxGeFRQkTAY15od6ZZb7?=
 =?us-ascii?Q?JJAphkBm0o1UHbnv3Fwv2LJz9fMNLn0uCh2BdI0ZPbyEIPFFkg9F4liEmQie?=
 =?us-ascii?Q?xKFi4hg6pwHwX0SqRIdVkoAuPBrA95HnhWAfgPshbScBoG6sA+A1qPKH0mju?=
 =?us-ascii?Q?C3abciJNNa0hCGQ/KNPA1HGCLRyYc9ZcjCTkhCpXYE7pPS5C9Rapvy+PhcLI?=
 =?us-ascii?Q?B+y1zGdA2ZB8MVmiQ7BZRNf+ObnCH+oCowNNrXYSILXGOQByR22kVh39fYqE?=
 =?us-ascii?Q?1VxtoQ6fVqoEdC0bYLrv9GpCSn1pnA2JoyMer5jdiFPfbOfHabaS7B++W7NT?=
 =?us-ascii?Q?u85DlLOE5JyeMMlohS64vRlPdTo3L3D81isJOUPxf+w6Rj6t8uySaBSPMIwK?=
 =?us-ascii?Q?enqxGyrDK4fHumbk+NXWY8IufcIJH15Sae0IVqmUZ9+Tm+RlQkbZCzhmDLhy?=
 =?us-ascii?Q?7fA7V/4Oq5gS8umpK/anFWrjTwYGoMN8zOB3FERnJBbFDGudCcxuWYlWB5GM?=
 =?us-ascii?Q?IBA/RXNbhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df22f1d3-b443-4b03-2c44-08de87a15516
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 23:26:52.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPugsWZVi9gqo3VCibvRAiyQrZl/2Tqko6bO4WqPCUJ76DDczJIjk8AeX69Sc4vqWrZvZVt3fqXxqBAsoJUzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

Hi,

On Sat, Mar 21, 2026 at 09:10:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 21, 2026 at 03:35:20PM +0100, Andrea Righi wrote:
> > This looks like a false positive, the kernel test robot likely tested
> > with a manually crafted config, so I think we shouldn't apply this
> > patch.
> 
> It's not a false positive. CONFIG_SCHED_CLASS_EXT doesn't depend on
> CONFIG_CGROUPS in Kconfig, so SCHED_CLASS_EXT=y with CGROUPS=n is a
> valid config. I reproduced the build failure using the bot's config.
> 
> The issue is that CONFIG_EXT_SUB_SCHED is def_bool y depending only on
> SCHED_CLASS_EXT, so it's always on. But EXT_SUB_SCHED fundamentally
> needs cgroups (cgroup_path, cgroup_get, cgroup_put, cgroup_id, etc.),
> so the missing dependency is there.

Ah you guys are right! I was assuming that you can't have
CONFIG_SCHED_CLASS_EXT=y and CONFIG_CGROUPS=n, but that's just wrong.

So ignore my comment and sorry for the noise.

> 
> Cheng-Yang, can you send a v2 with the following approach?
> 
> 1. Add CGROUPS dependency to EXT_SUB_SCHED in init/Kconfig:
> 
>     config EXT_SUB_SCHED
>             def_bool y
>    -        depends on SCHED_CLASS_EXT
>    +        depends on SCHED_CLASS_EXT && CGROUPS
> 
> 2. Guard err_stop_helper with #ifdef CONFIG_EXT_SUB_SCHED (only
>    jumped to from within CONFIG_EXT_SUB_SCHED code):
> 
>    +#ifdef CONFIG_EXT_SUB_SCHED
>     err_stop_helper:
>             kthread_destroy_worker(sch->helper);
>    +#endif
>     err_free_pcpu:
> 
> 3. Guard cgroup_get/cgroup_put in common paths with the existing
>    CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED pattern (matching
>    the root_cgroup() / sch_cgroup() stubs):
> 
>     err_put_cgrp:
>    +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>             cgroup_put(cgrp);
>    +#endif
> 
>    and:
> 
>    +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>             cgroup_get(cgrp);
>    +#endif
>             sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
> 
> I verified this builds clean with both CGROUPS=y and CGROUPS=n.

And this looks good also on my side.

Thanks,
-Andrea
