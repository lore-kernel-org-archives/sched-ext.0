Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A36250BF2
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218142; cv=fail; b=OjMmT8M6RoDacxZOHmos5coYsFVtnt63NjB7eUHEVGlKiv/YJggOU4DQlkRz0zFQpjr5TOsseoWNJkfHJUWSHAnA2q4Hj43iq9wDkgzkHw0+nX9ZwXBvKqJ51g0P+ItIfEBVL84DFsgv/7WMo7UO6qYXA219KS7SbvbruUcZSf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218142; c=relaxed/simple;
	bh=e1FW3dov55kLeLrPxRIkS/DP/uCgmOAhxBZ3/zBp/j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O+yKn34pGOns9PBptOfUzUqKn1zaxc/QfkVf1MeJCYCvBNqgkWMc7gnlv9zyrCPuCV66bFGFk1OMGsnuMouSO/ESqVaqcH8tVPHtaQJvJcimDmhkhgeul4OqidFzrzqvh7unMaxGH5yxuqn0jvAom4aDglqWgG6OhXekRdbQpWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIldZrvT; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIldZrvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY1bz0LOizthzE8ETfhCztJGoNa1rm8dZQVozljVj8u3Ng0uu+1wtnfAw90idkHtJFL8YpLEMJC1HNsRsouqCo8WBEuDcNNdUxUjeKG2biWAbUH8qh2KPacVX+GZEq/71bYua0p75rciOYyw5es+MUp8Ol2ZLDam31K5b2Lcg4azUSMJ8X+Suarar+p+6hWrogt48DlHEhm6EBALbYCv1+NqycxQem2Iohsfhde86NuwhqcyVOJna/eB17MaCQiCtjHm44GGO8twFgRN7pzdoSEOdx88f8UvWp1DAKdMMBmb3vkFKrpwBuwG2yZm7cT+Lz83lfZctJEqK9EwFNMmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Agj12/n99LHhZ/sVUtXjowAM+zkQDbvQ73tZQJAh0A=;
 b=O4z/0hjBNq/v9cF2+nHNdSbTcXwD/u7TQeneWM9SR+7x9BTemrlC4GSt2H0FEwA1W22LApOv7GkLchvI4JF2U5aUnySMmL08KLJqt013jUbiZHTFEr3D7cMzlRsYBPKXmlAa+be33KZXdJI8bedxstcaN4RVANeiaKQ5udWDYwvDfoZzqhN3SWn1vIRII4YJsarjK3DREd15MYH0HDULIx4EGrelyIdJRnoF5agq0k6mAkfQgO9PcGZx2vR379UfY7F3iJ3mVLYYt6s0dwmj28YuGZHKow6+uH++Pvre+HsEfyxFCOZeoJXQoSwfe5Tcc26NhNNWVHUjBphSL5CgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Agj12/n99LHhZ/sVUtXjowAM+zkQDbvQ73tZQJAh0A=;
 b=UIldZrvTEW8vQOzuwW+8P7DRichfWw7UgOrYXBePK82CsglmBtM3eI3BOU/TQOxdm2CGUI/ub9rxQ2+r92UOvUw6p/e7xYsc204m4CwhvXHsiHcY1EL5HZ50S4lj8n84yaduvHgJR043pDx4+dwVTgJYbpSebr12PSKAHBsQip+du4v1dzwfO26bq++YV2MiOXt6q23xl+VDlK2JSay1/5IoDhlt5F4T8RZZlrXd0xwDni5/rfV6sFlmtCn9F+csJZgSVOgmyNP13mtQ7bDrMHsh236mGP5oKxVCFB5wQSVrGlCo5S258KkyZ8OhBYTnt05Z+7HHWHGdrPDFyuL/Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 05:28:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 05:28:56 +0000
Date: Fri, 8 May 2026 07:28:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix
 !CONFIG_EXT_SUB_SCHED build warnings
Message-ID: <af10jxkI3joCq9-7@gpd4>
References: <20260508001652.3477646-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508001652.3477646-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 654ee7b3-3ca7-4aaa-b0b5-08deacc2b322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wF1A1tLfp2ZzEDmRg9lndJ13RiglF/yobHlmaRGj9I/8EGQxmd+l+89qh3gnF05+7Zl9N7bn3XyX++1123hXW91xC2pOPiJ4Xib3sX8/DfSLTUVYmMf6lJIRUuJzPIh1MA9gMIqpt5Qg/+tudlNP+pZvOhlIRoQn94xgcMFaXm3sP3pjzATuA1Jb7iq4ek9BLPkFyLryluM6Og3n7HsW1OVQ4rr8dLg88dzhTfwE7jvT3ps7RPhf7pUUu1gD6P6EGu6R2EWaV//ts8eJtXA045rIedclQsbZqxZiZIX+jQKUH1w0tL5k0VF/cFFAzgM391bZ68UPdBwi7uPvjd/c/F3uJT2bjHnybo0UQ68bsIegjO3rcBw0nPFCDr04kwdbf0HUG1pjPswezbks92HOHnBreSS81U8J1g2QSNzig1cBV0SCtq0lZwyXh+iTU1fNwrYAs2HgA/gfdPjUFU3dsD1a2NsI3sa3MEJd9mDLZggY2lw1oSK5iBCTJaI99TL1SxEuXF8AudhwZohdoIpNYtNLOX3He6lanSkuD89aOmNddyws/dRAnftoEp3w4WGJu8zuBE+hpq9ZTlNv5kp+OETyAmlDcsV8uMbG47mu6sh7DtqSSCspVKkPIt2PjcYRefkULOscnDFspb8zK4uiR1n2c+ftVqttlNNDRFkM0Gx3kCrry6M7Z2Pj9+elW7nlGRD0RlGjz60M929M9uiKGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lO+n/ir6CkC/hG5LXnds0U1H7AeMy3iITFB+jD0rWDQstSlaRwLGvd+QioWM?=
 =?us-ascii?Q?9VNV/mKcIe8icCzD+CLlTuB+B1cDDbaIepIT50/YvAfSpfdZaervfkLt8bfK?=
 =?us-ascii?Q?Ou8xPUcj+KcMyljafQ+QWTXvD+U1XrkXHXf84fDxdu1lt0rqSx7jV6i20FZq?=
 =?us-ascii?Q?OEG7C+xyeyBZDqVy9txxlSNKJMZRyyGblMPccUC0d/EryXIkdTW/t9Ywy8cB?=
 =?us-ascii?Q?c+aujx9UbvIF55xtJtOf+iSK2B1T+0+g95l5xsFP881yS8j6bPQZE/fRIsKj?=
 =?us-ascii?Q?tXV2mzUVOH+ZGw7RljMlNEI1sIaw2dX0rG4OHXX3CIHwJCKR/sZv3vVL1CsQ?=
 =?us-ascii?Q?7aDXO0t7t0CLIq/1tgvYtiyZOYfuSqf8YS7igQV2fc9Ms8SCrfwkD+Vo9Vlx?=
 =?us-ascii?Q?MsbqGvqe94FnRb0Y2INw+Z5MwzpDHBVem8zj4ERIF7Wv5iLNIL5w87ctE0dk?=
 =?us-ascii?Q?NJ4IfPZzxsD/S7yKbxBsjDUfx4Hhsvo99QM8Qt2nXf5wmmEh76ABj4KlSUbZ?=
 =?us-ascii?Q?YxFVtdvj8j74kr7JGOgD5L7BZUqeSmF2AgS7txlwepskr8QBj1iCjsO7GSSB?=
 =?us-ascii?Q?ai+OGl84JhPjHoNm/j+O/IJQznd+VDudjb6D6KpfPBtGlvTKsJp+1rETRYSM?=
 =?us-ascii?Q?NJTJgxcu+R3UfWKqhxEuC46x+lMwKAcmVelb9idZ9zTxTrduK3TAHtxeTSq1?=
 =?us-ascii?Q?erXY8ziU3R7dP0NpaMx/pLtERoGGa04ukXxnXpmgO6mhnLdultvQPLoEMnoi?=
 =?us-ascii?Q?nV7GZ3bSzo0A/P/aGJOGNNHpG+0YbN4X9aeHNCzdQdvNDQAd8p3AyYA3qele?=
 =?us-ascii?Q?KeaQxsSo45J3YJfQFq3/f3nf0Ru/NJ4qRzIc7AUZuf4Jiy3JpBJ1YjjVEZjA?=
 =?us-ascii?Q?0Dc6jXHSF9BQ4CZWSAT7KA5ohbvh1a05HmFBEDydeiigZyOmLKJ1jOUMhtPL?=
 =?us-ascii?Q?v6Q0RqBNNJaZrBWNbt1MyXbkotEUnArOeYypeD/A26IoR7GLSLYw9TQJ3EsK?=
 =?us-ascii?Q?VKwBwmTlupYWs1xdJCryWuiZIqzy+FSNikuo6A0kHZvVKPLxc7t+XpiY2dgE?=
 =?us-ascii?Q?OlQlbtElwuBxti+bRlsyjG4yepEuqea8kfZJk+hXLcfQ4QBohozleS/SE7aY?=
 =?us-ascii?Q?InCDaachtaSmp+8ScyXD1pEwexmxYUBpPPyh8h4ZA69bBpUpRVHFkV3ht4pD?=
 =?us-ascii?Q?/pY3WOPhXAOEWu8FM6iQdbTMxcaO2IwpUqWFxJ1vKAdlN9WzqXQ77FApVPTr?=
 =?us-ascii?Q?MhX2obkwOORMkJsjW0tUmS08H+RxfQNF+Z9zTts/npsY8ddNKNLdqbNk/sKI?=
 =?us-ascii?Q?FieP1QztT1fvPqa5zMEWSirErgS27vt6FBfb0X+8DEf/UfqekIkJ0FzKmJaz?=
 =?us-ascii?Q?ktxRD/WJbz7UE8601Cx4HyKpsVqjK40D4PGLd7H0fvoAzKmsKO1AzfHFPZMy?=
 =?us-ascii?Q?y8KlycIJ+LRnIAs32hN0oYBDZPpFOA/0GAyVcrc5n8Ww8FsPsErvRC/HMgm5?=
 =?us-ascii?Q?/eB3EOOHW5vzOoW2MB8XLetADz9G0rGR1M/PkPeLku6S+cxDLrY98TdBFXQ/?=
 =?us-ascii?Q?13snywETIoUbgfN9b2urU+2n5PCz3RZMlnA6fPxv/7r+RhMB/ZArZSwNwIkA?=
 =?us-ascii?Q?VFFfcFjRXxn1Bn4qzxjR3qvpJIGTCVj/XSHCKhxSGxUWMvGbPy1TIYzMAxYt?=
 =?us-ascii?Q?ks5npBqE/T/IqfK9O/NOEGArjJxjFF5Q+x5Lst0jae89OsM+WbzzB9Fj7aKe?=
 =?us-ascii?Q?sCNACoWT2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654ee7b3-3ca7-4aaa-b0b5-08deacc2b322
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:28:56.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhrO2J9Q3YVzaC2hCV6sb6oFv7+Nef+XhQaoEQLQwRZNeYDLedxJP46Ob2nfpvAm9emgA3qGcrTbYuc9GeB0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

Hi Tejun,

On Thu, May 07, 2026 at 02:16:52PM -1000, Tejun Heo wrote:
> W=1 with CONFIG_EXT_SUB_SCHED=n flags 'err_msg' uninitialized and
> 'err_free_lb_resched' unused. Initialize err_msg and gate the label.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Maybe add also:

Fixes: d292aa00de1a ("sched_ext: Make bypass LB cpumasks per-scheduler")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605080821.ftqLNrXX-lkp@intel.com/

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 48b4834c7027..f4e2db8e56be 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5584,7 +5584,7 @@ static void refresh_watchdog(void)
> 
>  static s32 scx_link_sched(struct scx_sched *sch)
>  {
> -	const char *err_msg;
> +	const char *err_msg = "";
>  	s32 ret = 0;
> 
>  	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
> @@ -6652,8 +6652,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  	return sch;
> 
> +#ifdef CONFIG_EXT_SUB_SCHED
>  err_free_lb_resched:
>  	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> +#endif
>  err_free_lb_cpumask:
>  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
>  err_stop_helper:
