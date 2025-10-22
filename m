Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A127EC7C
	for <sched-ext@lists.linux.dev>; Wed, 22 Oct 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169064; cv=fail; b=rOCIKICoNcE4eCrEQ4ookQRlgd2/0Ek6kqgAmF9030gd/PQb9aNF/LSKDznNXl7AHszDpkTnQrpofBGfVs4PxR0uHHl/rF6x0zHuV1L8Yg0KKHvJ6bZpkEhnytqbwjor0tRbBO/We/xCaSAp8+cBaqLL8GXJ1Io2xizcaFhkMMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169064; c=relaxed/simple;
	bh=kUa7PkQqT26Jqi0LqG/V1/h7l7cociklS+WHTMS9rCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fE/1BsKnjT4KecEXxhdIGBoPHdKP7JEz4lduekmGUepK0HK40YOsrtQ7LkiA/lywa0MBAYcUK9UTS81ZVgUDcc7H3OxRo/1ppdgUwnJFoee3gITrjQNUcVfbq+z5w6vZ+NhThcZ7S4QLtpVByZFtVg2OkfgfVhHVLlFLBc/LBuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXHDPZks; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXHDPZks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJRxi72/ficO5Y1HdHTrRfRUZAHUn6EfoXE81tFpdzuRgDEjIDiGgAIKTrYJpXtVqakWz5JPX6KSW3hH8q64iwuBsRbx9N2CKmPr1ZUVxpr5RlIiNVfl3qnDlI+/YrhMaDIMVBlGe0XDp4vjxgcYcVrlJ241Df5xz05ZBdDQqeFTALDaQwVK6tWSKTav+SA3dZteuLSESztVxPaqF5WesPDj312j4Fr2TkPsOBzd7VZKyUBm4oiDmS9YaV5Dxf/8LrxnOA+IxVorij+PUdqSJXaSBdC/fp8Akal6uMztV3uVImQX7So3IzSP0uD6LAJk0ralSlAkvG8XoenJ6lM0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYKWfW7mV6wS6Rq/RQJbpGbGsMi9w23d5uWk5M2QutA=;
 b=N8fKhk3yaJXjXVVgB3QnemKLAzhQLA3Vp46dQVMb/O7T0mbvP3OSTmyn5ja5f978yd/8hi0FIX5yC4aXL7wTP9mFYgV7sWoHm+m61gmRcMLRwXJgJha1EhtMnOXxhkZIRFYWYfUrAoMm27TbQ2rKQBM/lL9J+4i+zBrozWpnnIglVWUaxHo9gId58c6h8CrHAPqtP/ShU4WeyxYLEUvXSPwC3wxWTbNRv+Kc0L07nIEXbH9mCyuuAp3lnDRx2OKHVEWRD1mNsUMSQBZSl5vDIHDkbb7fp/sATDGW9rn1jpUBX80osc8oKWFXzYdpycZZKFp4vQaCkZ3cv/wRH5IZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYKWfW7mV6wS6Rq/RQJbpGbGsMi9w23d5uWk5M2QutA=;
 b=EXHDPZks1/FfY423d1Xwy0JqBywfIpnCsg7v9duajsOptMJ8xUWA3zMBEr17FIFDJWNnUEi7RN3qC54TW1kPH1qpuABKVObWj1LPSuS1lDSuQXJG7mjCRssdBBrgbPbWaNPScmYwHC6wg75awA39nHfNYBv7n0LHSE1JhosjXQbdAxVEjfVJlJkQXmEdHVFS9VGb2rJy22QD+88JEoBGeM4qnHQ7I0MYy+Jn6ytFxr4ZHtEeUknF4tDvdO3b6MhFO3Hx9+2DoqIqszgGG2ghCVyIsj5gJ2UL79jvvKOEC2erEAgo3GqPsK1RbDf3LEc7pAWWtz2LVuW0/JBdjaAbGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 21:37:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 21:37:39 +0000
Date: Wed, 22 Oct 2025 23:37:31 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aPlOm0C8CsvVdq9K@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c70209-ee0f-493c-5121-08de11b33956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aGbnG7qwaz+gtrLn7PiJVrwPoVL0iYUf6vVHmOerQN4jPF35WpsokIEI4WkH?=
 =?us-ascii?Q?TijYuA5A1PRcw62cEj29nnXKL+4mGa8IV97l7LgB7pVbBgDoTk13zd081vKW?=
 =?us-ascii?Q?1eeEKb//r+PhxzQdYR+GTQ3UF9H4eep60iySIrObP3YjFuAvMjrlYbm5QqqP?=
 =?us-ascii?Q?a71cs1EITQsdvr8GxodzqxY4oRaomxyR9xJjIuPhrwT0aCLUB3aF7+Uq0uyy?=
 =?us-ascii?Q?PE3b/M2oJtu9Kz9chsw6XwWEVQ79tYRM7DipDTN27l2Tbz4M5z67BzykoQGk?=
 =?us-ascii?Q?VUKPwCmiFj/4b7b//RN4V/fuWcF9QM406I1skigh/I1PX+IKtWyX/myHVfBL?=
 =?us-ascii?Q?R8vLtYS4FzLfFxu1EAI2kcQIjT3EqAmxDYR59tXf2GDR5Onwjm08BX+lvZvS?=
 =?us-ascii?Q?FolMgDPnUVexpLwejSADQbxi1XlJrsDS/G/AdPyO31DdL7FglpWABNonmP1C?=
 =?us-ascii?Q?pH2IM2ssbYFi3SBoRoXA2vplVfKzC8HNiiofeEEFAkiZMxzulj5zgVnubIQV?=
 =?us-ascii?Q?tG1w27VAtOcwi4yXn7gmDqZtYiiY+6BQFqtGMNI6PBP32snAtWRv9LBUTveg?=
 =?us-ascii?Q?3oLxSzVCUZBOTmYrEn8iewH7sCknL80BBO8zebo5u8Q8MEVrj3uHE4juHRt0?=
 =?us-ascii?Q?wYV1Zk0GrMV7XdTGMjiKCMXDd+aN9VbGvCf87uAWrbREFUDln/LkFweYIt0w?=
 =?us-ascii?Q?+iFteqBEBpPtmDL/C6fh3jPZJafT98zG9cwROwTsB4eRpc5B39OcAgcetyms?=
 =?us-ascii?Q?1WenI1U13voCcFIHh2z3SxTvyK/3hMrZ2f8i1IaLnkc0FitCWJhL1SAo11Wy?=
 =?us-ascii?Q?g94HHw9s6T88wSvgqSaA/yVCw3JTfY2JCe8nr/OgTIVfZJ28CISM/lCOUyjG?=
 =?us-ascii?Q?F7rrYUF+U5WfKk1zRrjVhZFyni5aa/a9gIy5juxzsz8u7qOlYApACXxehPxT?=
 =?us-ascii?Q?2Q7k1ebFu+LAZ6YiMRtT0gQ8jKlwL5LjY3hN7TUAyHsOClp/uSdE+t9vN1u5?=
 =?us-ascii?Q?Tm7SgFVDRYZLSRAO2ySMT62wNF3QQYgBxlzS4PKhOKGcSYoS3IOj8tDn78Kk?=
 =?us-ascii?Q?mfCo0M3QO6eKSPATjGUNdSTYHbPrhD8IbMalrLlPYZSaFBpDeasX6blIVBQ6?=
 =?us-ascii?Q?z61bv6vdr3eaFdLajc1XO6EkEecZbO3tJHMQPMCSKb0NefTQcLg+4vR6nAfe?=
 =?us-ascii?Q?vXu4AQF1hS89JvdcPeD/3Wt5KtXQx82EoUr+ymDT67zmEIohYketiC1Cpgje?=
 =?us-ascii?Q?cfFaUNL9GBVl8gwD1z+6Ky7hgKJ2ewQX36W91yz2Yl3SxQFHEW+KIFWu+ucw?=
 =?us-ascii?Q?uYzrkak5WuxG2ZBzeWTakfsmD2qcwIjSyIMG+UzGc6ifIEfaY9mvJuStaBX/?=
 =?us-ascii?Q?mq+vozxKM+RR5iZXdA0GNrRAM1W77CileyLxIJPTqoWLGBL0Jfon4GJBHSnb?=
 =?us-ascii?Q?HQVIS6PzWcs5ittxp1DjXGoOnvW1xxOj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjygqKAGqKjKPc5uTeOoj/W5XAJnn576STMuMWXEkB4vIkdS7QcmNhJX2Yqx?=
 =?us-ascii?Q?ItMNCzu8+NAzc6gNNPrPa9tFpwP15/8B14jfIW1tlGAcWyi4VTxCHf9IA3Cm?=
 =?us-ascii?Q?bNyEk/azfuRd81gdpKYuH6FD3DJ19wEAS9vSx9/ymRJIOq393FSnrN1fY3f2?=
 =?us-ascii?Q?UI4ItYo97W0WisrP+If0xcriS6q0eH8NNj6M3zUX2XtlMWk6ShgN9svzYWLm?=
 =?us-ascii?Q?k1W8OPb9YHaDPpCRBpbQLCppNpzqSrU/u9tf3Z8xxyOhYAzpuOsVFbyZcJzn?=
 =?us-ascii?Q?aI+kh8G6SpTjQzJlYq3wIsYjXDSlhUN8oNYIIEtXWtpadcpXFIEuOjOA/yI6?=
 =?us-ascii?Q?+9L28z8ELbv5WYeYG0ydD47myITVVoAgLN68rVk5cC4xTSqyvuyh2SH8BKjY?=
 =?us-ascii?Q?tavYr8mykECKVIVhl98NOXPNNOFlsDSjbzEX6nGGoIQLjWi7WPrHrwaFTlxg?=
 =?us-ascii?Q?FycjOomHLrLV3gWNrl7DOM7cGWImfM3Vzobvr5fiuz9NVCHeNa7gIGefxmE9?=
 =?us-ascii?Q?r+072MkgwIdBnf7QxBrCjHEvuMyGJlOjBQ7+6WVIzkx2HPKQqYt+6akdSKSf?=
 =?us-ascii?Q?aNdZJ3khTk0XalpZYFvieUqtb5GGI9Mf1qECZr93o74o79F98hiVgswagwEG?=
 =?us-ascii?Q?vxIGWTi8Bu9Vlxxf0e+i3woq7yWRIXNz216Uu9LbOlr0YO1Cy6XZCkzovhJB?=
 =?us-ascii?Q?x3sFLD0evTizDaH4X2bge5Le2wASCrLmoDWbpwoWc9kAL5LX2E/1EnV+bwl2?=
 =?us-ascii?Q?RbXiKgX05GYfy5k8RKmv0TOofGMdJue/Ih2hWb/JZ6qYMQ0dLFiQ2qlBn70e?=
 =?us-ascii?Q?oX+M9BHlfqJJkuwxqC+TmgZJqgQmu+wzC1Q5IYjqiVcd7PUkoADj0Qh1htIZ?=
 =?us-ascii?Q?GwPDR0VWED4qIZgA26INN1PaWuOSiKJuqGhByuBRjfGJpjPNRjCUkYads5LN?=
 =?us-ascii?Q?v9Sz08uGpGQbdm/9swDWssOYnveS8mhh0VuPP8/i5L9vq1tvWwxWJUYvnMGb?=
 =?us-ascii?Q?QgqhNfy48vNp4zGOGOZy98k6LKhdX2zH9yYEkxvyD5J/Bd65QkKzomUQDnhF?=
 =?us-ascii?Q?Idfg2eDKa18eF+idDA87QH6pxKDlTjy5AsX0v/Ohxo0MDgO2ZlcZvHe1dcUE?=
 =?us-ascii?Q?6gFMnIO9uUpRdDEumdEDZjXOFPwX4ltydGCAFSWTHQm2EQC9OEn4QphQLpmc?=
 =?us-ascii?Q?5bnoPVB+0+Pza43hOMpwqwjSl7nVkEZttDUUAoZzbi2UWqX4WHjxQkQ7/ORF?=
 =?us-ascii?Q?gj11OmlCeJMW69rJ88TIJv40abgjSL69C2SE2DDPu/yd3Ir4+nhhwcyYDGBB?=
 =?us-ascii?Q?o0QAiw6AALrPp58UyEYfmsgq8zX0ANbvU4dZZvisHwt9vbJuIUMAQduydPoV?=
 =?us-ascii?Q?QwXR8VxSnXoA9jwMq57OmlWxK4YSAehcA7W1zyLLvKZDqdtXs9XzNMGK79tT?=
 =?us-ascii?Q?0Pnw8DhL8VN+ItJNeSRcmIZvKNJ1f8tWimxU98vWLcPImSWjOrzw1vV4vywm?=
 =?us-ascii?Q?14yvbmJ+ZIDipOAVvDmKiBsIaDwwRdawMB2Jyj2Ll0NR8jJXTyQMqzn8RObg?=
 =?us-ascii?Q?cnwrvgsjIjyRopNR9NwqlxnuZ7huAUgWLA7f/IIU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c70209-ee0f-493c-5121-08de11b33956
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 21:37:39.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpfXjXYsy00Pt9jD5hXJnkP72DjN7rD9fZ6BSpmyIOqr7Cqm+kdgTtSEKBo07TMmfqjIsKUAla3re/TwzowNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

Hi Tejun,

On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> The find_user_dsq() function is called from contexts that are already
> under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> rhashtable_lookup() to avoid redundant RCU locking.

Now that bee8a520eb849 ("rhashtable: Use rcu_dereference_all and
rcu_dereference_all_check") landed upstream, can we re-apply this?
Maybe add:

Requires: bee8a520eb849 ("rhashtable: Use rcu_dereference_all and rcu_dereference_all_check")

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f5873f8ed669..df433f6fab4b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
>  
>  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
>  {
> -	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
> +	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
>  }
>  
>  /*
> -- 
> 2.51.0
> 
