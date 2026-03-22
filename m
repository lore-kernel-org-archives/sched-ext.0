Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839B1DA23
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774163636; cv=fail; b=SXT/nWm8a1+8BPl0YHuMvnNHVM+LKyIDOCX9Pq2aRM7CqLyKKf9+bXPcFTtIHKMpnkpKlujFhzDjYjHuIzWEoT2mPRDX+tkbPXK32D9ZUO45XpDci7CooTdhbM0dcwrcbUX9u3ATzuldHHnyahIIriXMn+B0u9kxJm5QOZ3aLSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774163636; c=relaxed/simple;
	bh=14sAWBHgzPm+JOaZY3uwbGdZTfkQSBEswP9vVAcfW/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WTU5QaukOl4luuFBCTh3EmgjQGb6iKY0NBMDhHZCy/pXcNtuEniUlUn85rVbPuQWuA1YqFWi4BUz10noCpcJ1Vtz9m32fFlJL1veTOdtiCbxEFX3bdx5ah1g4WwCltHCwXJ5p+G5Gdd8TPxCoU0APlU9N8xGWkjGV42kMgu6K7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdYunMRg; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdYunMRg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lffsl5ENWmQn7EV6+xJ7kkYDmOwv5h8Qcd2VF7Wdc/J+oYGKUb/x1bTCGTOgbCtjwOuYfhPUnSZxU8iaK2eEKHZfzxoqQ+vZ1hqCGHYfwYRBOkNKqzlDWZ3rjiQ2epbIUne7tk4gHl/kBbqaiL/TsCS9wqBECyUoKX1NUaW0UDPq3eT4sla5xnnMmAYLvTgAVC2Hp8uIGj6GBH2XWTxMlNOUVuhg79JYxBP/n6m4LbMS2aWTZDUT/Stq682VnEaAlVVJKfbcEV0Lel7ARizfQwXAXBEI4jMJHoTmZWRfwyY8fesrWty56chbqFWJT9lE+xDpSE3K0vw+e7acWUHLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdKfsZUOGDdjxWqA4wtprL7SeZpXQd7DQ4X2TKncxC4=;
 b=GnpT5cLClth2j+KcJJyWi241qAyJW0Z43ZjN4uj+Zj/v5SxQZEz+iezI1lHD8gLU13NkqtAA+Mi6oUBiTkl/s45UUWRCpr1FxCP9CJI9HoCtncnU6h6v3o2K9fmQOaQ3mYqRJhJGtAfWdKbfeH0J9bhA6+vFt6zFrKoz3wUI7yeZUvqQVYfrwemOwUcwgKs73sx/yyeMj6HS0Tn/z5ttEzv23ZeaeMtz+GeKkJox9PpT2AlnxPAWqN69zgmT6O+Tncw1nAv3ht4bHkRBeFH3AloB3rHgGAOTm2MvSNRMOmrrNzUqwfYgUA94NtdhhWPHAI4foD+8ZKEfZS+HKahfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdKfsZUOGDdjxWqA4wtprL7SeZpXQd7DQ4X2TKncxC4=;
 b=qdYunMRgr3theQ+Bt3fexnyAeM6UrSKCQTH2p22lFpCEObbCtfv3rWN98IFqGftXZM9ab60jDb4g6h/qw659wcGvbPs7hbQEjWAv9qJPBKWwAhJSrPW3RLBkm7dr+i6DNnyUyVKbuRxxp8Prket4gekompHuGaqiEODd0ZF8dElI/ooBnbviJ66LjPfRKNeLZ3/cBZNk6a3Nm8JsomNeYU0ozqtVuZPMPymVV8tbPNvjH8ohVPII165Q6vQyvmpziIotSkBl8bTYkFZcgQBekC7V97xG/nENfTu/U9MS80lf89W6VQU8EIV8UUPVZ4+o1Himu1ijBG/gxCyhaiH03A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 07:13:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 07:13:51 +0000
Date: Sun, 22 Mar 2026 08:13:48 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix build errors and
 unused label warning in non-cgroup configs
Message-ID: <ab-WrGgPTU27W9vl@gpd4>
References: <20260322063955.951848-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322063955.951848-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d71a206-895a-4f19-7710-08de87e29208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	khhNc/mMIWK/vgWAsQ2HkVr+bF9lAkA4o0b6T48gTltUL+XHonQcAInnYhrMVtcNHLhhg9A4XXoIQsYIAq+QpMmuEUkTyrZC+RGHSKgofgGlFPtMeY1mqOPhzQcwKbnee5vTDFaMIhEH3QiVSo+lltwmBPuS7cVs7jAt9UrUwnwJhsnUD5XaEJnJjGjMH972uxTjVJmSozAAB2k1uMqWpRx/2IZ0806c5YJT/jkFPPmLTd6lqgWgv0tbebc+JOdLumC5xCaOfLQ95JUWeXKMEESm0dpxSqgKcc0hfChcU3W9KLT0539m1zZW5aO/3MJiMmqlyPQghFCGKVcdVFOirhHU/sCX5S32bwJcx9jU5vz8xBGTnyDJ6LJ1JKaisWt7qLh10uQFR3we/OfmFtBmi6irYTR060TXbLoCWJKBRA0oSUSn92bzf9TPpSXrc9E6+Xx19OnyZkTxtu6BWDZcPv5s0BI5uWsio7KhBkdDnFTcnkwQCSEtx4FuKpyde8l2EUixMRyfpQnM3yncyTMuOUtUO22Ef9swR02cH0U/d2xv/mKaQzRyxX5vGRUpp0r62KlI4H/ht+aG8tKl8mpHJs0JOqgQ5UEe+OFW8qXjNFk07JzkyfAkhHc9umwpeS97lhTzjAzIpzEc8FuOteEPA+GDzAuVAlBpvfYk8y7TXxtCy4c3CCr4EdGD270PIQLZmFCkl3pxHNszBk+uJvY2IpwyPBXUsIpuVsWhRrkI5G+DsU0cw8JJSEuNdGuvRXLF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsdm9L2CzeI5c0obyUJQKqDgrkAN4k1mSKFKiN5f3ylN4TLu71QTirZU11B7?=
 =?us-ascii?Q?AO9BEs4Nvh4jFzJ6edny06XzSHHR+dnD8Pvho67KPKcDpJ8zJXrYc6PAKuJW?=
 =?us-ascii?Q?R/t2npxHcN8iV9wUkzkOzoddIADTI+xXPdUGMc88ZBHsmdT7O2JI3Lnq+JJ1?=
 =?us-ascii?Q?yWDKJ6S2FYjNhFh01HHAILqw20//l3/ZL1mZ+GAo63lojWf8Vb7likr0Y1fM?=
 =?us-ascii?Q?SKkyJ+45gAMYepwBvTUcw5uL2/GbIyho0UoP8lbVbERHUfTS6Rw+reBmIfth?=
 =?us-ascii?Q?vPY08N/PfRVXyZWGfW1j0GN0PfPEPhPr4RO7gTT/MXCpqP5jf9cyy8nIA48D?=
 =?us-ascii?Q?ET7B9zzec+f3YWDoD+lKVgMSaUkzSIhQS2QuX5FNC8lATHCQXmqjXUyqdbJ5?=
 =?us-ascii?Q?bm5JHfp+gn1EFtd6uzfdT9Ypr6YptYIz43yaq+X1HQvLNCI1dP9wTqqpsYLW?=
 =?us-ascii?Q?i9EN9L9mtUm7J/7E0NWO3EaPhGnNhvNmB7Lj7iJxwY5SdKToTKZml7zd9CtU?=
 =?us-ascii?Q?P1djzAmMb8mykFoiLkbQ0nSWk21MR9emWPcKFXkNZlatipBISPxJpr3i9l9c?=
 =?us-ascii?Q?unwFJnvF7h/y0X6FphWO/oT5gMIgjEz0B1DABMGKryDHxv23wQJ37U6WSIKh?=
 =?us-ascii?Q?fclNYD3+wO1nYveexnQw/G0Q8d5T9UZUOyB6bSPxrQAzpY+pAbsAdC1wEVY4?=
 =?us-ascii?Q?jHCRlUXD4NyhELbeLeTmMqZCTNa0JZ9IDPg7sNfYA4P9IR8m4A0WgbMiRy9+?=
 =?us-ascii?Q?JhaaV5IwnHNAlJ75ZF55yRTQGlAtwayhgofuI6l3YyJ7tzoXkag0CbEvrp6P?=
 =?us-ascii?Q?sMeNyzpx5qZMyBiqf5cu4GodezVMzN3CoceiGpwyPnowSV6qAsj+iXnUXeQc?=
 =?us-ascii?Q?tu1txVZxKaOHHNSuC2mR0ukr1qPUUhoDaisj4mOrQQf+13VPmdLi5atMSHqT?=
 =?us-ascii?Q?5MrIRw8DK7jdYdsCSorECqYurtMp/L7XGTtLzIhWIJxo6BJyNcY1mi7ZHoFX?=
 =?us-ascii?Q?Bsr6g8s6oFk9xOe2YrtBlN/Cj7YQ8NHp3YSEKNVsh37zJDPhIaz715ljWWuE?=
 =?us-ascii?Q?rbLMSLEO6k5iWC4GnaIOoVMS1ouT3vXZKga4AGUrBKOM6fk1fblOStGDOY2L?=
 =?us-ascii?Q?1MNNnFHmBK5HU29PHL7o63GqRZTOQrX/R0ZrV0ugaO17KTMG5YYUgemYf/HJ?=
 =?us-ascii?Q?lx/PMPlnGe/qKFwtHKnsOWOh0rLuTE8zmk7Wd/zmMMwVp4688ebjLG2Lezw7?=
 =?us-ascii?Q?1S/ckzOrVcBsXFmHBW6BZjRk5UWUq4ecyJzanVOKUzFqWKzX+d49dEnQwNGK?=
 =?us-ascii?Q?SY/+PpAj/RMVh3wKbgDFa0nKgBJMvxFsnd9u7aEgjAhEd/lA00HXnv7k8H6I?=
 =?us-ascii?Q?qhxo4edyDUgUTnlBsYHpU4CB86MAX0EK/qVLsK2KuoJB3ZVO7M8u22WI34sI?=
 =?us-ascii?Q?UvXiPRApLXpojWBeKenu6JaA2Zci2HdfL5zu+n573q1fWjE7xRxJ97hGTdJf?=
 =?us-ascii?Q?rLfNooBy54DL0rFkW+X8mMwnKnODMpClGVv7VbWAZCjqkDvRmSaUeZTOnoIu?=
 =?us-ascii?Q?2iIgQd4ihc7byxmFAbtjYgifOJXJ1LwzIgfwvsL8zXgbxs5dy5zBDnn/YAmB?=
 =?us-ascii?Q?5+Ikg5Ee9YYQD5JNUtRtq9Cacc+TS239tZgp709PlolP6nQ2N3MIN4QXjvjw?=
 =?us-ascii?Q?9qlOdh2BWlHG3mFcuhYiDgCp5Z61PyL6NjtmbGX1HDYBPoorS1QVmrPXD2N1?=
 =?us-ascii?Q?v1+8Dm/oiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d71a206-895a-4f19-7710-08de87e29208
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 07:13:51.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ93pGigy9b+A8z0NBmX20kmIBQI0w22ogZcdqRlTepvv7bjKJpqW0VF+Q8ZZho665nHkuY8DIqR6FIlydzSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On Sun, Mar 22, 2026 at 02:39:50PM +0800, Cheng-Yang Chou wrote:
> When building with SCHED_CLASS_EXT=y but CGROUPS=n, clang reports errors
> for undeclared cgroup_put() and cgroup_get() calls, and a warning for the
> unused err_stop_helper label.
> 
> EXT_SUB_SCHED is def_bool y depending only on SCHED_CLASS_EXT, but it
> fundamentally requires cgroups (cgroup_path, cgroup_get, cgroup_put,
> cgroup_id, etc.). Add the missing CGROUPS dependency to EXT_SUB_SCHED in
> init/Kconfig.
> 
> Guard cgroup_put() and cgroup_get() in the common paths with:
>   #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
> 
> Guard the err_stop_helper label with #ifdef CONFIG_EXT_SUB_SCHED since
> all gotos targeting it are inside that same ifdef block.
> 
> Tested with both CGROUPS enabled and disabled.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603210903.IrKhPd6k-lkp@intel.com/
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  init/Kconfig       | 2 +-
>  kernel/sched/ext.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 06abd8e272cb..487a93e34be9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1178,7 +1178,7 @@ endif #CGROUP_SCHED
>  
>  config EXT_SUB_SCHED
>          def_bool y
> -        depends on SCHED_CLASS_EXT
> +        depends on SCHED_CLASS_EXT && CGROUPS
>  
>  config SCHED_MM_CID
>  	def_bool y
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
>  	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -- 
> 2.48.1
> 
