Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEE2701D9
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628602; cv=fail; b=cuWi5K0iwHRM9E1VrzD8rvdmOF7Dd92Lp+neIsiqckkYpvabBnN5yovpXw38PwM3WBhPvjVGgi3AfOKmt8iwdckvbKFfE1xnbGb/Ic/eO41I89ajsaoQVfHZjWRz4tLzmOtrWYy+ZlvuIfFfkt3KR27VwmhHOV0xlOfXnzOUDLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628602; c=relaxed/simple;
	bh=no/BitsgNVSHUUzytkwfhFYIHz6XpUnd6Sj7y6TjACE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDHNRU/mUToXBotSjc7IEwvj9pPcMqN8Kooa6chEWQREVa7P4YiJVSI0SaSXiRkVB2lHCdcMeFvrqbknUYWuNRzVtWGq8ik80nIS5pX3WyKnTgw0aMOpekWD4IWPwQFkR+eHBobkyN47PTqRQqctVM747ZT9e/zPrqYeV1pZ41k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EHz9aaxx; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EHz9aaxx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWTvO4QEKuSNPUaWXwZhDPu5K+ElPovIzu9l1z4uX/max7PQfDNnFs3WQgalXa5zJPoOsqCXOp8yPbeuWkWi9SlhYTrShKdrOc3QUMPQ9ryisDDMGa+GwC79P9Hd2xPKWhOREpAx1zgugXe1aaQJ9hb5ENSalE0yFPbWJwlW+sd9f6P27XqV4J86sggH3ylCbwrjDvhXDy4bcnn3IHAVjn5FyMAw1ECCL4KqFS/PKvX/zofMswv7sr901M5dyQjDtRUsuNy2G2aKzwChga9+iYr45bUs8fi+9nD3OLPbwwYv1l4xDzYkBklJZcycOXXSZ0xOC/OXBJMkqRS896ZlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLuvCbDkk6606fUQccf2c3tWpypp4CeHJeSG6FWw2A4=;
 b=txt5KpZhVvi3KPmHhm5mG3v3m1acPeXhHDXNU+T0JZMLa0iO0TTdLQtiEhPSKY8/KErb5AbYeFCLGaw8libGoFscz80kKz8P43A9dDvOe0slYGLgsAKezCvVN4ugZ7uXQBHQkTGky0Gl7NGoOHatwvH7ID6/oeogXiQB36QCYyZvSBwh9YsBWYaKVOX84+UYPDUNII4hdfKCzxzZ5yoqb+JBaTMcPZbvxGS2nYO/mido1lpPUHJkOvBPBwNQUz59BeqIWlRWwWXOSLO6bDpDo/XqQgC4No/LjFBj9yPU38tQStKNrwzp84bDLmCK5kq66ktHuAnfcbHmGnpMKsQZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLuvCbDkk6606fUQccf2c3tWpypp4CeHJeSG6FWw2A4=;
 b=EHz9aaxxVIEsoUUQEY8SDtvmo7Mp3EJlM0M/bbEnAFrQ1HCbCTfHV8Z/0RYNC9SJuNffVvTajlORH2gHQH9j0z0Q5ocOduaZUzdhp54fh7DA69JD0RI1j2/1HUcGRLesV8TNTsPPRW5e7kubyw9855xhXXsmUCDGKiwIUiYInzIgTE3hKQrAVmODnQUvr2Zs+Qmsz3BhIHoiWzkTM1v7dQ/bMapmLi/zYg+M9Gs/HaXCtHrzrZ34W6XKFuwUBqDIOgTpbRHYN4yv03ESr6r81PMlB/T6F3w1Y8kv+Rf91YZVN0liv/1W07GCfTbMIShjNrbGLMOCnMHSgGMjb6x8Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:23:16 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:23:16 +0000
Date: Thu, 9 Jul 2026 22:23:08 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix typo in scx_bpf_dsq_insert() comment
Message-ID: <alADLIDIRHm3Zwyc@gpd4>
References: <20260709080205.534892-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709080205.534892-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B79.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40d) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: ba38822e-0e93-42ab-65dc-08deddf7e869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	4GiksypDsp+kEYSZcrn+W87po7s2uVYMK5/WLV9ArPjE3DjYxu7iQhphiIJpbJ3wLO+Emi2k9z/lD7/T71l62xUWY/G84lglCXy0owdq1RthamJZi46snDrc89/V3p9C2qYHYdU02Qcc0J5PcoG7LoDRVP8nU9iRpe/uTr4f7OgNtLtc9ZKAzVsxnWSnT4hKp/A3doisdqXFq3p++sZ3SwO2dYPJTb/6OE6UDC8KV3thpve1Dvz+OHlW9fgu/nEMKmHS+fZZmKlFGQ813ksnHDJXzldoQZLW8tg9sK1TiW83AKWgb62ou2DP2YAFLUtIgLosF/WLWEEVYy8AMI3Eddv41j1F/6s2vPbO0LApQkTWXzTXHDySUCzeMdOIg1ik0kQuE1cKfIaRefU0UDEAGao20NBbMsbeDrGz7koHYSH9BPu2Q+CAxB0EKmxZ/e76XUvc7ek62rpQWqSwtMjpLyt38sPSNcBTyAiQMardpjJPJV/3afW0e4OyJEoaoxCwrh7O0y9d53H6eIDnS+7gB1zxhSAP7PAiKQ3WNm2XL0WFnjHmzvKweTI+/8Cc8MQ2SwFcuROYmD38PsBpV7bZfM3gC6e9D0xWVzg630ldZai8AnS9n64W3IxZ+XEeuiwvEXCa51VguurgzgaP8xGsKhc1VeAZse0IunzuVq7fuw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xP/eoMmnpIUyeSyOHGsBOyesmBmBtfkE+4fxm0umcnNDZKfRLicw0TidNN3?=
 =?us-ascii?Q?s52+ixxU1UczCnZCil4cPtxpbD+z4XJSqgtbqhkq3E0KwPmKDGNcppxi7xHD?=
 =?us-ascii?Q?6zGzjTtcudw9Uz7f2L9lO7VAOjZJobeg3Ngalo7ZL9Fmggs39dQxw96HYFgl?=
 =?us-ascii?Q?jHmW8740HVYfc4bpYRREvmWFDY7IUieb8zCOqMyt2YnmEt72c7fLDOAxzMyt?=
 =?us-ascii?Q?aecXgfqtLQ/N0JFJLXPWW7GfLk62nlVvG5oAYYWerGTNNaYtP1M5kBurBJ8Q?=
 =?us-ascii?Q?WSTNDSeV8Wgzc5hnCCeNga1YXV7QXWpTOQ2LJEkyHqDVEBy7hMm80kP3cSK2?=
 =?us-ascii?Q?Q0tNiF5zhvNup2BJ/qsmPehHzedJ3v+SfSDwG+kzytMdyYwIHvT3tdnzD3Ch?=
 =?us-ascii?Q?k9ZVPp3kwLyA0lAew+W2zsmsABF61var7omAHpaaWPD6XzKiXwnmdIfWYXk9?=
 =?us-ascii?Q?4y/+sOK7B5IKsORkWvuJtYp9fab72mw8eQEyOJztO0FNIadBHfMoEWybsuN1?=
 =?us-ascii?Q?DTSLb2CpvGsKNWjTxJTfAv8uJe/BGdgg7CK/T7Bx3fDOCzYeLaAkazanFI6t?=
 =?us-ascii?Q?pooySMAPvP7P9PA2fdqMSX0E0gJ6nIRm8TCSpH0Cl749McoMEaqzDLn8Hen1?=
 =?us-ascii?Q?ZI4W8WicGxls0SgJmjfU62QjZawzD3OALf+Hd0SeJJSO8T0E1hzcJzNNMIUK?=
 =?us-ascii?Q?ktM9CW/SA8QGpwAgIJSkqTO386RxC+FOMgp5cIFitQYOZr4gO9fIxFY094dL?=
 =?us-ascii?Q?LiAixCk3EmxkOyYAV+OY6myQeX5Cizfni4HQ4i4gnpy2TkhdcM7Msrkx0536?=
 =?us-ascii?Q?R1csn5+tgk33GIDxmlv2EfwWklpmbcz9z0G/6p6kAT9q+xwd5GOYz+UDcLrs?=
 =?us-ascii?Q?jVTPID+Kk4iOaFpMqK2YCweVJzMFFPDw1l1SNdkkd7T9tGz9yux2M5FcZ1pW?=
 =?us-ascii?Q?IFPwKttcCLjES7rJb3opJ9DEsov56/8pmKG3lzCM15OHtljuC2T13aSt1c2t?=
 =?us-ascii?Q?AkStohH9MJBiKnqsstliYz1NTsNennMrE1lT+eMBdz7pCCgSUgxYE1Y3bkkm?=
 =?us-ascii?Q?cVdN/mspqR4i+07LabQO34BaIXxwnoAln4VLLC196ADOI+eHiTQECrQsuJwN?=
 =?us-ascii?Q?JaFmE7mDAQZOzv7ydyCkB6guLO80Tkt2sz4P1is7nmYjAmF49Tajc5dTu9du?=
 =?us-ascii?Q?o67Dv53HtNT1qgxJ/zWS/iqHH/VXMb/bs2Rv/QMhZMNCQ2FxjGn6IJJPSktq?=
 =?us-ascii?Q?maZfMSSdQb9MU1xYI0wsDWQo3vd1qEHbAF+9pOPFNgT8GVymhY8EyXwpRmLv?=
 =?us-ascii?Q?OwjxjFvHMzIywIH6EAjEOuE+zUGYREsaonw8ELV8pRxUL11vDKZDc2U4cNSB?=
 =?us-ascii?Q?N7tNMlz8g22HTISNK/jSfH+qJJ8gp2a2a1edA8XAVbavMsRrHUbcbJmgjhS9?=
 =?us-ascii?Q?dRmhIi2qnx8vcNosWX0ezVPXKD8ktXuZctmcsox0IT9d/BAozkhNvroMTZq1?=
 =?us-ascii?Q?mg31HPqXO2eoZBDsGqAoSlDcGGB5ilPl11zzxAZfBnDfaLXaJZC5XLWd8HB6?=
 =?us-ascii?Q?otsR/ToBiccPO3LCo1jhMr4EqsGf9EyesfMGVgY+I4wu7AT+CEnGyG23JR6h?=
 =?us-ascii?Q?pZw0lGzFHeQaaSFGrza3I0ylHynsvQBk+vXBRIAj1CXV3s29vrtjhH71KMsN?=
 =?us-ascii?Q?HpnvJticClwCVgMk0OOxGTitGsOZ7WHYCS8N3XQW2BYEg3UkzCkNZCjYFCYN?=
 =?us-ascii?Q?aWDbLD/dIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba38822e-0e93-42ab-65dc-08deddf7e869
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:23:16.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orO1BRGJrwuvqMsjg75VZAN38bsk9EXqtQYRYR6vqN+0wLEeaXr+XVVO589ejT7D3r8RhJeSBytLPXBTvrR56Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537

Hi Liang,

On Thu, Jul 09, 2026 at 04:02:05PM +0800, luoliang@kylinos.cn wrote:
> From: Liang Luo <luoliang@kylinos.cn>
> 
> The comment for scx_bpf_dsq_insert() references "@dsp_id" in the
> description body, but the parameter is named "@dsq_id" in both the
> parameter list and the function signature.
> 
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>

Yep, that's a typo.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f64..cbfa23d71e68 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8572,7 +8572,7 @@ __bpf_kfunc_start_defs();
>   * When called from ops.select_cpu() or ops.enqueue(), it's for direct dispatch
>   * and @p must match the task being enqueued.
>   *
> - * When called from ops.select_cpu(), @enq_flags and @dsp_id are stored, and @p
> + * When called from ops.select_cpu(), @enq_flags and @dsq_id are stored, and @p
>   * will be directly inserted into the corresponding dispatch queue after
>   * ops.select_cpu() returns. If @p is inserted into SCX_DSQ_LOCAL, it will be
>   * inserted into the local DSQ of the CPU returned by ops.select_cpu().
> -- 
> 2.43.0
> 
