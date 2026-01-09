Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477042F4A19
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953533; cv=fail; b=I3TFR1W3WketXJCLUJp4Rk3/MNIkoH10Ms90D0RF226leJNCyG73sArhEWx2PrC9ZTTmQLV9gUCNLosf0OgBUGt3K1xeS4MXnwul4cWi9aaPNzoZ4eWiEdN24Z/vPSgk7c5z3TWWnePjMOSVVAXaexAfVpK2C2ibY8tZyP32gM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953533; c=relaxed/simple;
	bh=d55YGNweKHrG2IyXXZ6k6E/s2fm+o9QzNZ9c5LNbzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mwiZ431U/bbISY3i6T4EksArEYw99F3ejFTS31C7o1bPl8z1yODEOXEHBYsZAsAZLp4KG2OolZr6x0TeAzmsH+A2ub9DSXABbPixSpf8kZ+q8nRZd6Is+Gqy88am/XUW7Y5jHcknlLHcMwEUk25kqFW46Sx2kc3nL5bF5LoLHxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDdPKaf2; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDdPKaf2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+E8wPuWm/dcJGJu1sJ8CejWeUothTGq/V8L4s9dgOeFYdgO+qXvdELL/BYj5OikHR+SAhK7VJRh1KGa/EuxYR/ur1YrykWYAC+XEnprKSrTNASfkurml/roBZ3QAeBJCFQHWrkEZgz+KO/CnaF8ZHKjij/l9Q7LJhyy6ZMqny2rQLXA+XVY6s188IzohQYRETdy/NXFA3miHs4Z59RqWiDzlxcS18uSWxbDhAFmE9GNQipJCIRrkH8TgIJyYblhYVEiXEZ6mITcn5GEGyO3zR6rZE2JTt5VTC6ZS3gDShhsJCy9/UMpW13MG1cnbUNpqsuHFc1/2tfC1ZB+Ftik7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIzcbR7YVS8yGbi2MmJXZJJm1I9NkTUSMGHLZupg+6M=;
 b=owViUfXSjCs84PE3DhxOsnV+uO9mfardijBLHAWvvS25twqnMZYabXtEGZ2rPkkfqRLdxSLDvstKbha1qrQ9yRCiLTd5yaJvGQe46848bsHQ5c8wpVlahZHi4N9rI1B2dnwTvB26Cr3EzwIonEP8KXAJy84SyMJkp9rXNa3WamfK6koz72uPAAoDCK4yl0xlKZqL3azepI//gj3HyiyJ7t77sK+orare9R6D9yrPsRcR1VKVKjaSPDtxf9bmTmSAP3c//2y1ynAc+S0uS3wLtzVttIE5A23es0EkFxvQnGdQOUvVaePCXLt+GOSSqS+qztx0DFY9j3ZD6F8muiKftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIzcbR7YVS8yGbi2MmJXZJJm1I9NkTUSMGHLZupg+6M=;
 b=hDdPKaf2su0lcCU3al0ZHeDNInXAfY7B/b5kd+xDqIXcUFCk8VkxkjExXX4VH6I8PA+Dfj8tVOAGaKNpg0zdLjZhHS2n0H4LkwGZ6j5OZI00d1jnv+rua9BBnLTYSfZrjgl/lYm13lhVMoXs7w18EezLhH15OYPXpymGFWkuCnj3+1ynndMBJKpzxY8SAAm725XxkVlLfUIn6unh3Cqtuhbs3fIX/GTUgKLMJmdkMKpG7EfYp9RJikm0epsZOZd2zn/RVNf8In4h5l2qvUSgOaWxWS9+Wx5yi67QCMCRZ1Pfgvjpno702wRTaUvuZYlWwXAGRI5UtjQKUBJoDYgUkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 10:12:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 10:12:07 +0000
Date: Fri, 9 Jan 2026 11:11:57 +0100
From: Andrea Righi <arighi@nvidia.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: changwoo@igalia.com, etsal@meta.com, guodongtai@kylinos.cn,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	tj@kernel.org, void@manifault.com
Subject: Re: [PATCH v2 1/1] sched_ext: Add error logging for dsq creation
 failures
Message-ID: <aWDUbVsJXth8KuqW@gpd4>
References: <20260109100358.93045-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109100358.93045-1-dongtai.guo@linux.dev>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2605e151-a387-4eae-4148-08de4f678afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wID/oLYZQHKvvZcUVTkT2oVn9/k3G9m7kaCvpnu1CR1DVLJDwjzo9SUsLS/N?=
 =?us-ascii?Q?OKLujW03gEmHsKyFT3JEsiyyWrpymBVE3UzXnh5J3VNqlTZPbOtpHwzlRDZu?=
 =?us-ascii?Q?dajIDE5T9ueVZXT8Jh03bJ6vj/lY7HSrLG99C3Gd2zdEEvrx6h1rzSwdoc2M?=
 =?us-ascii?Q?kmRM/MO5ZZb+KrNhNXiq1E+1EuWb9eNg4HNgbhskdjO7WglAuh7eiUf7YcMP?=
 =?us-ascii?Q?ri32xRVrmUEZTeTjAiq6iHgX+IOD56eeFVFWMkK8twLx+MnSH6t5oDr+S5Q+?=
 =?us-ascii?Q?wvn+782tmX8MnvVkA55LrN9kjVGLViOrdggIvq5lBdBDnOlqJzOsQK3qlLOg?=
 =?us-ascii?Q?Z6h2HqMrvwBJt7SvTFwj2kdRA559BYthJHkPkcFyeGA+KxLi8uCLuTDwpBN+?=
 =?us-ascii?Q?Inp0JLb2qx0mbYmJ4FVHgMZM+M/k+MteNJnTgd8ZFQ514YHlHQlZPQp3dRmS?=
 =?us-ascii?Q?Rg7vZ7y5rxOZQrfc/u1Nm4fPwXgnufyvuheRFtwW4qrrPJWUSlHTCU8ntr8w?=
 =?us-ascii?Q?UTmpbcOt407SMLC/UHteRCq0OsLUCOUA6xoCj+YHmP3NLl3jWcTVgLUGvy2a?=
 =?us-ascii?Q?oVpBieE6OnfYGDTWMuRxu+a6dSkwLK3Qm4JxxI+VQDxPXboa1myPM0hhqx27?=
 =?us-ascii?Q?lfUsFNeRhVWns6iHj2yg01KE/QCVKLFLI4DuS+t12jztQFiGYa6MHVTpPv58?=
 =?us-ascii?Q?wN1s6Tw62r9Hq0jv9lt1iZmiV2EiQ6oSRYH1pkyX5xDT1bvwbPsYY+ThHkak?=
 =?us-ascii?Q?yb7OaVqI3OUi/0sORCAjlPhwTTK9+/lemcR0Q668PplqY2rr1YtVXNJmOm9/?=
 =?us-ascii?Q?WR+cmJaEk+jjwEc4trs5CeRfGdRvg+XhOaZZdRW6M5FytoEndF4Bx9MTi2A7?=
 =?us-ascii?Q?p8eRJqIY2eRgeoHb2UwQ/vY8kx+zIQHM7Hy0pCnCSjm8zZhkd6hVovrIZYxX?=
 =?us-ascii?Q?47paSpISAVMVx+4N2T5rCAtBmavL/X3YkX2eu05z/cSKS8L7HFZauv6LbjIW?=
 =?us-ascii?Q?oiA2wVg/BO6GGUNqC+3h7TQO3V6ts8LqPnI//AihMhBcal9Hk9IWIyFg+EhA?=
 =?us-ascii?Q?YcqY3Hj4vUUVZEYN2mXCvlc+asAs0cN3so1nthd/CE3vY3iX5BTJtNt8NBGz?=
 =?us-ascii?Q?uwphvwsYFVKkVW0EwIFI93jvcFtR51xVjbOTM5x+IrhnDuqz54UN0Go5ztWp?=
 =?us-ascii?Q?VQ9D3BgJkWm1J8rJVd/YH+CSv7hv21yEHIG0qlSkhclc7LcYwpE/LIOO6aZI?=
 =?us-ascii?Q?Er6uVIPFPOY9J9+eaPLHKjYuSzDq73e2Sp/TNoyOixjV3t+6GNVzuc9Nds9d?=
 =?us-ascii?Q?5XKP6bo2fWQLYwmrKWo6BpwRkgm3m75y4BQuyFrbkknDKOukW3Nr93xCE1zY?=
 =?us-ascii?Q?z+7BGtc601CEca7qvqV68xx+WWV842U22PkL2HcV+fsu5vwVcAPdh0KFiHta?=
 =?us-ascii?Q?OXfbA+/yv++pC7ef/3va0rKDnIVrYd2z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHdrkV4RPM36Hd3ZyUMAT5B0EgE/mPBrXHYgXohVI3BU6GC+mm4nrIsk0Ya6?=
 =?us-ascii?Q?Hsk31M2IumVRXOdLKsEzcgVFmHJcdP1YjLSi1/A6hxeqXta4faciD6O+DBjT?=
 =?us-ascii?Q?U5wGkyuuH4qZAM7jq5gc96OU77zoryDBx0Ohm3YFFjxSMn70ZcBX24mwk0qh?=
 =?us-ascii?Q?2HeCGwLWSMH+3ea4utoLoVTCqPsjIIQEq/pNipcUZ4JdfdPuuH3dWmyVhcQu?=
 =?us-ascii?Q?Dkhf36MbcNV71eE7sDo5UvZjwrb5bMghVmFV/2TfqGKSfc8yCW9pvNBFZToh?=
 =?us-ascii?Q?BUohD6kG5x97SJtLUeQQ6RqpTY+ZlzdGUkznbx8e+rdzgq4lPYynGPsVJdaE?=
 =?us-ascii?Q?Phbapj9iLQ7LPr3fAjHwsJj14eq+A/9a/sJecHMSQ1FKlga8WTdHb1sEt70J?=
 =?us-ascii?Q?kqxfijVwaFYMaP3bq2rUZk3h0a4JnH08R5rzHaw6QyvTv5kMwlTQ9bJCaR7g?=
 =?us-ascii?Q?5/N+bXq6GgZBqcxLw18sD38MLj9u9iIT08nq0ZQgkt/0/wDPAVeNHrrZL2aA?=
 =?us-ascii?Q?iEY58eLFNBgwSOQ4KNUWAYEQRh35DfdqVqmx/mEVxrwsGKOajrsLQjuOWsLm?=
 =?us-ascii?Q?VMzLmMp6Qx8rRpekAThsunvD2T7uAzuoKHDSJjveuorvrpZ2chm9YwvPT+19?=
 =?us-ascii?Q?E+e/5C/b5FiqwohLZRIBb9pZsYIWP/a9Zog3xsSBMv74/wK6Tge9DPOfoIot?=
 =?us-ascii?Q?r7NOM3R9XnndRNVX0NxK6o4vFnm5J3gRXo9a6ZvXTJpQo1dfsizQBz94N4QQ?=
 =?us-ascii?Q?Rzu6kXQVCWXJizGsSVa2P1n24uX5Ztc9a9RJzXjUMUCcOuiagNGaHFBn5Vnn?=
 =?us-ascii?Q?WT+H5aDHokGsDNz9EoZnbpSVvfbhKKFhINOOI2WH8CaAgcJLdLT/nCmO0Qmx?=
 =?us-ascii?Q?9eLIu2POEM6zIpT3RMUcJCq0hf+Pya8XolaTqP2Sx/NB6NiWBLHUtk1RlQm9?=
 =?us-ascii?Q?QBWybiQD+1W+qNMgb9R+jwwiff6XY8oNZERJ3yK11z74uISnENtgB9E4qMmL?=
 =?us-ascii?Q?RQCP+WsKYcRDDXjyTDBrZMvnJQ+4/Hwg9dmVbHHgQ9y/GNDTZw1d5+N8d7dq?=
 =?us-ascii?Q?E9IxGhH+gdMbEH5sxsLTAdl/1Tz7SIGwEz6RvkaBQoYL8A0alhhrJRw4OlfW?=
 =?us-ascii?Q?P4xMOa1gwTBFccR0+wfBHg7AyCyRdQK8Zl78F8Wh9kWOYC0Gp1uTmyHdLNS5?=
 =?us-ascii?Q?RfJNP8VZ5rZbrLjhmJ/1r7+G7ee3e5g57Et4iHliBdsK3dR6ggozDO63rCnA?=
 =?us-ascii?Q?qeO7Y7clbmbQErBQP+1z3+HBI3sgZ3qFFeWd7P6MgGdb2QP7lCzdf82Wx9Ag?=
 =?us-ascii?Q?aDMuYYyTmnr9IeQqRiojffUbS6EQlxsixEQSTDwUyg+LU6KS895qgzXbr1dS?=
 =?us-ascii?Q?FdoU2FAd5kaPO/LLytZRuqh30XedsdK0xb4jSOpPNN78QWaOTfUOYVBNF1pl?=
 =?us-ascii?Q?qU5e8AGfd4r4Wq/MlYOD8hCMdnhoxDlGFJPkxZq7bxTeMRAINqmDxTP2s+zv?=
 =?us-ascii?Q?ZlelqjYiEsXQR08vOjXmAa7UXWcb1YSg9J51BUOusbfkTmAg22mFYSv8sOk9?=
 =?us-ascii?Q?E985KTHxW7xjyprwQGD21EmiZ7OgudpnHU5drxc7Tc/0tNVnT46kDRKjPjJO?=
 =?us-ascii?Q?pul1WS5PnK7KPuMoHrIe5LP6oYmtSw4GhYcppRdx/P3tGK4+z2QwLJc3dLOF?=
 =?us-ascii?Q?05xmc/+KSnRSOcY0FeM3SFxYgUIZGdCJJEMpfVijdyzl8Sgn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2605e151-a387-4eae-4148-08de4f678afe
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:12:07.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ovFE3wb6M/J4bTFVAUcFbzNSp08ZazqZq15VT6CO8E8nvh4k5xXiAIjdiriXTDvcA4caAOZtgnigUmvU+6jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

On Fri, Jan 09, 2026 at 06:03:58PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Add scx_bpf_error() calls when scx_bpf_create_dsq() fails in multiple
> schedulers to improve debuggability:
> 
> - scx_central.bpf.c: central_init()
> - scx_flatcg.bpf.c: fcg_cgroup_init() and fcg_init()
> - scx_qmap.bpf.c: qmap_init()
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Huh? No, we already get an error message both in dmesg and in stdout when
scx_bpf_create_dsq() fails, so I don't think this is required.

Are you sure you were not hitting other issues when your scheduler failed
to load silently?

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_central.bpf.c | 4 +++-
>  tools/sched_ext/scx_flatcg.bpf.c  | 4 +++-
>  tools/sched_ext/scx_qmap.bpf.c    | 8 ++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index 55df8b798865..1c2376b75b5d 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -301,8 +301,10 @@ int BPF_STRUCT_OPS_SLEEPABLE(central_init)
>  	int ret;
>  
>  	ret = scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
> -	if (ret)
> +	if (ret) {
> +		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
>  		return ret;
> +	}
>  
>  	timer = bpf_map_lookup_elem(&central_timer, &key);
>  	if (!timer)
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 43126858b8e4..c216480c3ee0 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -842,8 +842,10 @@ int BPF_STRUCT_OPS_SLEEPABLE(fcg_cgroup_init, struct cgroup *cgrp,
>  	 * unlikely case that it breaks.
>  	 */
>  	ret = scx_bpf_create_dsq(cgid, -1);
> -	if (ret)
> +	if (ret) {
> +		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
>  		return ret;
> +	}
>  
>  	cgc = bpf_cgrp_storage_get(&cgrp_ctx, cgrp, 0,
>  				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index df21fad0c438..5fdd83769405 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -866,12 +866,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>  		print_cpus();
>  
>  	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
> -	if (ret)
> +	if (ret) {
> +		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
>  		return ret;
> +	}
>  
>  	ret = scx_bpf_create_dsq(HIGHPRI_DSQ, -1);
> -	if (ret)
> +	if (ret) {
> +		scx_bpf_error("scx_bpf_create_dsq failed (%d)", ret);
>  		return ret;
> +	}
>  
>  	timer = bpf_map_lookup_elem(&monitor_timer, &key);
>  	if (!timer)
> -- 
> 2.49.0
> 
