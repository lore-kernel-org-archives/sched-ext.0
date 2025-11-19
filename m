Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406532D9499
	for <sched-ext@lists.linux.dev>; Wed, 19 Nov 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549109; cv=fail; b=Pw6+5MKAVKoeFEcKc51BSxMQ2irTIalTKheihWFUiroGVJcoIYoBG79ShLQZQgK7p7vAexJ9BFIqFVzqW+FGfg/H9UFT/acshVmTTybg8BsOQvSkoiXgIbB8qqONP7UXzRFFj/+0+TdkIhtcDUQBoJmoHJtji9Z2qoMl2J5Cpgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549109; c=relaxed/simple;
	bh=e1pDsaoePar1Qi+LckiqQ9HK8AoXAttM7IH3rEFxa8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P7+z9G5fjwn2fsIZW66t3Y4EmfQj8n4On5SDWis4tSW1CcGBwR1p3st3ryiFSZVmBybuKJdNd76cJ5ZWraIKnm75A6bJkyzS7tT1c2wAhxO2OZj+POdXRKAcnHypr399zKumkh8kICv281kwh6pzi2r85O6kS3SW0Fb0QGDF5A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTlOzYGR; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTlOzYGR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t41fdLgBRdPgl30VecPK8kV73PwTfWIA727NdGKJ6z1mcQCJV1SyRSenL2vI9kiz3z/S9qXr+WdC1xE4zGu5nnsYpuMiPJadlvTU+ImsHbAK4j5/hDEnpxrTTEJ1jeLUiBUX0W3jtyM638mX+es4SSWMvpiKU8r5T+sPJbJsfB3LrCzUOs6dlungx+dAHX78I5T174fPyqo2M+ILn6rRxL55DyJ12BiVOIf0NjNvNm0U0+Gi3cGIRVCNv2fOVKv/eUT20Zy29SskmTupnmUxdNE6IHem5a/YMci3Uo1Pz93ynJlihmxz0ex38hS6NtT5kSX8SBNtDXomnIMNOufrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYpd1DvPM+pV6GnT/FfmQQNzmCrrrxTGVYnDZ/CgdyQ=;
 b=CYVIdWEz7B6MVHWwqYBj/d4PS2FjhLOXSgAavXrN/fOb8nKrYY6UQrcshBfDhHDVASUKXlEIEPBKeCiS5KQ6eX9YxUCZIryyxu8Ze5YZD0oTnHDHB8Izc0KE0DUTC07rKTpOugSr3+TIoylr5sNz0uWaGRO1+9EnRXaSCCN7/Fy584UGF6mqd/uaRn7AK+DbmgyjihmAUbL0E7pv4fDI17UpZFIiFPegKBeFk347p6iQ+4aDiAVtYLnZtwOVTjNV9na/eXXH/QGerpvg7t6BQbeka3jfpqieG77y9+V7yCqXxgRwvRCHLbhQAY2pqGM2PxZHV7aA/R0L13SffEtgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYpd1DvPM+pV6GnT/FfmQQNzmCrrrxTGVYnDZ/CgdyQ=;
 b=MTlOzYGRm0xLDhd25nPvItDfT61y1PqO8lOg1NzTs/7Se2Z+wGsagvz7ijFiuXjOufDVf4dsIrStIB0clqNMTuAKeGy86xJZDzuLsG7HlRwaFf3GWUdOdZrbq3zKo22WMdrBoTdND9qxgF97dtpFpQ29xadmQKPBbToFxu/L/0P9r29PS8C4bDeL9Aae1yqoPo5JgVJpS6YV9/hQ5ueGmj4w37Yo6wlpLqyXYetxcu1YNfTTAPmapqoCRwvRDuz4CMTT+NYXXcQ+3w1uWijd+VoZa5ipU6/yF1dsgKSWbkSxb14bNULG29mmTLh6nfbSrKodtZOhRFGW/nJJ7s4a2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 10:45:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:45:03 +0000
Date: Wed, 19 Nov 2025 11:44:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	hbathini@linux.ibm.com, samir@linux.ibm.com, sachinpb@linux.ibm.com,
	tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
Message-ID: <aR2fo87bjKzINl8O@gpd4>
References: <20251119103722.309211-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119103722.309211-1-skb99@linux.ibm.com>
X-ClientProxiedBy: MR1P264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a6dcf3-dd3a-4f6a-c56b-08de2758b201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drx9c5jCcnPGtUqGNxpx0TxYTa1GIP1y8jDoC25ozU7L0kPwMmhFnhX5ULGu?=
 =?us-ascii?Q?i63UlKi9dJISlY3FRRTBNvoMxq1unZhSKPILeJ3xOPSnOWv2NM4GXZR5YVId?=
 =?us-ascii?Q?Nd74bjiBpxUTs+V7pRtmlq479yodLYRM3K9pWgaXNqdmtd7VjdnZ3AICYkjL?=
 =?us-ascii?Q?gEuXfFiaZgCG9MZ1Yj9pRqPFD2ij1MNbg3TGEultxNeezfZ26UZfbylvrnGd?=
 =?us-ascii?Q?ZMrucO/pzIv4qDgzDnPCIf+EbeY9kPrikAbteBKdmbM7oybsavVRBxE0dtMz?=
 =?us-ascii?Q?PKeHbXllFuU7j+cQLOMZR5zniEDmDDKO0zioUFmo1wHUFcFPkwcx+jDfRiOz?=
 =?us-ascii?Q?AR3N6z4xYrVZG+0zw0ZinuYZZIwfaYL9UnEz2Ij5AuE1D+3q/ecYFgkpe5k6?=
 =?us-ascii?Q?rGCRDZ29lejwem7SMiNMfTfqXAkEnGtJ8NaWmSZ6JkTds7kGB/LC6ePePlnb?=
 =?us-ascii?Q?cBpNe65Ps/TM3YXaIT1Ewd9hMRx3uxYdJVCArFoXEvu7oJOlnMLm5oqPo79s?=
 =?us-ascii?Q?/zrWhsrUr+twm2spms7h3UcNLaCScU+uplRjRapO60fzQoGBC3oTOR45DSlk?=
 =?us-ascii?Q?pustpP6wSheMaIYTtQ3nm6MRcE9YK8zmwOO8tyKcaaPDxgLySok4elXlg6dB?=
 =?us-ascii?Q?D20lFDATNsubYUKZRQIt1PriSl0dWiNkT7mTOdIcQUPhxz4cRuaoP/0aYQRU?=
 =?us-ascii?Q?rUazfw5zW6+1GlUcCu3/9Hxw9fG+QmDSJcrLZyYtKoqvLH9vpxCCH3TZSYnN?=
 =?us-ascii?Q?9nlhgzxlAt7nmECO8s3YtOdrgfTEnvONzWm2dbTK7M97TUHGmZSpCSQyCBQY?=
 =?us-ascii?Q?9OxzDDKfbOi4S8iXJnhkagAIhQ/hj43A8N0FdHpjE3SEbuAdpczP+JTmSBeF?=
 =?us-ascii?Q?T1M+ZfoRqyzr+DmCQDEO9nB4TPTkGBe7JdWwj+iSM4gK9P6BPa9CMwvgDz5r?=
 =?us-ascii?Q?DAzlEiBu4ObhusB5ZfLSJIDiobcDMR2Neq3AaFYiWBX8VNA4dMlwfNb8DOgO?=
 =?us-ascii?Q?p0l7COtIH26OaFDELCfuroke0zbCv4tZ0O8rGsxd1pi4HLbHvgHBPUXVV9iM?=
 =?us-ascii?Q?pCWJEafj7LhR2JaRLGwUQ2kbC7WR6VitM/a255I52dLZ6Gk3WLCwgrOhnoK1?=
 =?us-ascii?Q?y/2+hZo/u9e14n9IXOcLcEbFCRi6/Z21020gdwMFGZHBJyQ0EEBCnJ8TXa9Y?=
 =?us-ascii?Q?QttA8AKCofU3hvtmPaE7VE5AC8NAgRDtF2aZf7yVQfd7NBiABm0VuE5WS5Rw?=
 =?us-ascii?Q?m3cqmZTpIoUvmOMWvONIKi0ejLxLoWgdheC276B18U0V4EiIrpqgRqtAHr6b?=
 =?us-ascii?Q?l2EyE3Rmq0gi0jWTnwEM6di7gpYlB0BVMU2CCgRcmd/gzeGffLh2p9dX1owe?=
 =?us-ascii?Q?0l/GbzSFZSgGCWV7EeDARsQUAnGvZolUIhkp/B4AIokZx/FrDbnZ4tUN1KUk?=
 =?us-ascii?Q?1eE2YZBBq+gbTHpDBz7M11BJdUZ4Fjm1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0acHpJbRSFkKbNuPJ3eKmNjS6Ohf4KGVHdkuWp1/Mc1U+LqajIeCdQJab+F?=
 =?us-ascii?Q?BRpTdwLelpKkRHbIp9XMUKoAIGb1lzaEEn4OsQjO12j1sFlZHBU5yEhve6/i?=
 =?us-ascii?Q?wGDcr9Rmt6be55mNYNFIeO3EJEsVRHJOy5bE3u5kyhm9jo6YcCsTaqlVJbzE?=
 =?us-ascii?Q?K1eP2KOQcrfdkLs0A5BANdbq8xlszhUMuck5EpFYrSsFNbMaB0zlXdYC3oLP?=
 =?us-ascii?Q?RRoEINk4u+BL5/ltgH/mPDOsR5BIdTv+vqKBARRzHdZ+n5I5c/2Pw4xkIK10?=
 =?us-ascii?Q?u8eEHxiv9wu6BCAC/rLKhXgTkbUenWjojsZU96OPyXrPZL8eCTy0Iim9qEyY?=
 =?us-ascii?Q?zpTfamewmL1PWhcayslX/zw5pxquEU/VnnN7BJl4VVoQpU83R5iRA9b4PFxM?=
 =?us-ascii?Q?n34Urwy5t5XdyDnFRZe2Aa5MxKYmo27gJe7tOWMJlwofoK4G4KQc3PK99TVL?=
 =?us-ascii?Q?o9uL/hI/e0txDtrWNyqDP7Uf0TYlntZsniE+vvd/YdCYOApIyCCV8dvTqWKZ?=
 =?us-ascii?Q?H1JeqyqPfiPJY42TI7uOztS1JNLwpI2ZmU9B2D+dBFw/cM80k8cNPMgu2mQx?=
 =?us-ascii?Q?dfiAuxPC0irtCfz0tCXCoSDLEyMbfv/7D8JMlzIx7yfPy3tj+IcEoV6ACu7o?=
 =?us-ascii?Q?E2vKsDkw5XObj8XVlVvmHOefZD2IlfHRzfSQphyN7TzD9SyPtyqNhF3OidB1?=
 =?us-ascii?Q?l2DI4J9KeKtO6qfOHyHCUIrSr6vl+WARmuuT6XKsMhveVN3/JArh5UW9h1P4?=
 =?us-ascii?Q?MxrKr0bJ3rSOFh9s6TMlKNnnK4x6HYzpB87F7+St2LnkXCB4mTuiPyfk2pRP?=
 =?us-ascii?Q?BFa3L4gd5NOT3cP+0CD25yCkdlgG7Q9tVGkr17w6l35yreIkB865qAkABJVV?=
 =?us-ascii?Q?3COaHX7COSyG+UXVZwfAJCddCleC+MnKrHl/ES+xj4XvjgoMQ7twm142SUcN?=
 =?us-ascii?Q?up/a1W7GEuZxjaqaeygtbq81a6B2/LuWviWJZ6S/BiIqM4gqI+36kdW5H57X?=
 =?us-ascii?Q?niqZtdlX/XwghJPuFEYndVakvST424DQszrKoZFKyL/ItSt8w5MC/XijlFUI?=
 =?us-ascii?Q?mgnn4QLe8Yc2M1RSjsUf4htkhyLG3RM/nmmmSb43//9nwCPATJaO4LEn/cUX?=
 =?us-ascii?Q?KHjDnYP6vCarXkUtbO1WFNZm2DiA6FLdQ340GbCy+HqyyKjNY0zMsvK0ALyj?=
 =?us-ascii?Q?ZEDSuZVSvkI1l21aQPeW4v/YdrMcgp/GZ3nOxE2MmYrvMhIRsXiCfTn1YABt?=
 =?us-ascii?Q?VrEHF5h6fq5cL4m/lg7PvUdE6b1B4ATVD5WR9Rjw1GIH4gaU7mOOZ2gnaHfa?=
 =?us-ascii?Q?nqgAcqmQlJMSAu95iCQZ6Ww/ljlwqMgRgHGG1D8WrvhnNfE/3dHkd1ncAdAc?=
 =?us-ascii?Q?fY9LTlmbqsFagS0Lq4G4z2ocQ1QGZL4uEGgJG9aJADjUxB31Et/aJ6ayxA8h?=
 =?us-ascii?Q?8x5X/jXol7o9pe7oGCrC4bxzh8UdQvQ5g63iBV+uO8fWHP7kRHKONBMFSxjn?=
 =?us-ascii?Q?V6mtNApZNsbCkz0aGU/DoELNiPDbVgGwsaHYrvhtD2R12cdfuoRb0m1VGLjz?=
 =?us-ascii?Q?BbVzC37su1fstOLWr2U/XwC/06sgx1Ev0TeSpebl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6dcf3-dd3a-4f6a-c56b-08de2758b201
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:45:03.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GArtiKa2K6bUxgBDyw/m4f3agvPbJSnUk9ad+UyECQh09szC9SWDwrVaIROSrs8BFWTVJWU+kSRtAhdWJHF7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

On Wed, Nov 19, 2025 at 04:07:22PM +0530, Saket Kumar Bhaskar wrote:
> A crash was observed when the sched_ext selftests runner was
> terminated with Ctrl+\ while test 15 was running:
> 
> NIP [c00000000028fa58] scx_enable.constprop.0+0x358/0x12b0
> LR [c00000000028fa2c] scx_enable.constprop.0+0x32c/0x12b0
> Call Trace:
> scx_enable.constprop.0+0x32c/0x12b0 (unreliable)
> bpf_struct_ops_link_create+0x18c/0x22c
> __sys_bpf+0x23f8/0x3044
> sys_bpf+0x2c/0x6c
> system_call_exception+0x124/0x320
> system_call_vectored_common+0x15c/0x2ec
> 
> kthread_run_worker() returns an ERR_PTR() on failure rather than NULL,
> but the current code in scx_alloc_and_add_sched() only checks for a NULL
> helper. Incase of failure on SIGQUIT, the error is not handled in
> scx_alloc_and_add_sched() and scx_enable() ends up dereferencing an
> error pointer.
> 
> Error handling is fixed in scx_alloc_and_add_sched() to propagate
> PTR_ERR() into ret, so that scx_enable() jumps to the existing error
> path, avoiding random dereference on failure.
> 
> Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
> Reported-by: Samir Mulani <samir@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Good catch, makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..7fc0cce68a1b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4392,8 +4392,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  		goto err_free_gdsqs;
>  
>  	sch->helper = kthread_run_worker(0, "sched_ext_helper");
> -	if (!sch->helper)
> +	if (IS_ERR(sch->helper)) {
> +		ret = PTR_ERR(sch->helper);
>  		goto err_free_pcpu;
> +	}
> +
>  	sched_set_fifo(sch->helper->task);
>  
>  	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
> -- 
> 2.51.0
> 
