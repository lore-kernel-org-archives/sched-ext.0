Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C00311595
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612150; cv=fail; b=rwwkVf8k2YOnGZsgRyFCvK40mJxk3bBAFg1rdsdyW9At/W45sKYaF4findKEctOGTPyg69mvhpq1wyoqVNI6jhtXAr0UKRkjJKEL2Xqn8NqsEUMCiNBHdqKf6TYTWGABt59BA+CkwMuyvEaxBqXT+AIJ6E/kTEe3ZEZErQHCu7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612150; c=relaxed/simple;
	bh=eF0UPPBi5i6dHwiDv04FlvNYmg/p1oj30/P4Aap5s34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcZoAiaiOsYheSZ3ChQFP3eiYqYh7f+4rIwkjsBK0l9LAcUH0ysCflD0J8fYPLoJw18S6ZEElwjt/DbB62eV9aqmOJfNwWmPnozTzPCy38j2yXErBO8n+IOj5Y0XEOw9rz7RUJvLygWSMlxUG4O4EjF5757kbpRiWANAQ88G5Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgO6hyat; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgO6hyat"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxoMMdRJyzoB0gJsZy2tqD6H28HLNgme2l3TwDB3hxoOaQBaWDystyh8x5XfxNIRcxR6p4pIvARPE7K/9a6sqmxD5277zJevWhqMUmA9cP1uKRY5daAabpUvjqcA2wcjjKTyHD6wuMA41fYuGY4C9SYJoxT8yeLB+HYuUIX4cQjrEHgp1ap+g7aCGE27pUpFKPGob+mobNvbYhQjP01Ec4uf3W1X6ple9zYMQ4ScUDw/WqQyhDs+PnMQeb1f0q4XUtxp6zX8pYfFtyU339WS/n7o4wMf54vSKXzSB5yCW7zcR+wXaQfCYnuwCJds9oB99hzD/2YGcpb+Q48b7S47yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY4HuOXIsLeeA3MncHC3UoLEvpJCEdduF5luF4s0G8M=;
 b=yxN98U57cLT4pfJTS48Bf/2sn/RhQkkUaGrs8w/bGx5x5z117Qzcm/Vq5IxCkRnzjMCA3AC+p+w7euJdU9mH/Yy75LNxS0KX7xoMiAzAIwXBsvF4YfvS4Bv3AMg1BhgYrZcYRJUAYB64hD+yrQdksdkp0zWJyEcKYxUvtm1Srqspnp0fn5NlMjsa/BkRVTfp8NI2em+X1/o+qv+yG24tnA0JxQiyxgUF/Yer0oQqclPKZKGtqOQBuGB0dweAQCHdo9+c2gZId/IswKNcAlBsiQygxdmzkw0RAWtjM2G0ZQOg4IefFt+0i+Ed+oYQZGxLm5b3SR+ITQLwCBTP5HMXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY4HuOXIsLeeA3MncHC3UoLEvpJCEdduF5luF4s0G8M=;
 b=mgO6hyatyKARxykiCiwqis4WQVpVMAuB89H5XkxdoNifupdtoRM3hw0dahuNc3moRz2iD9lJEko0dDILKwGrCSLjD6K161nwBm10BJKtf+4SfZz+vD2ExGsPQHf1NYBR7Jz6Im5W8XZBKcf55XpQhJaCHqFBENE9bPjX1q0A00OiiNRcyV3tUIFfQ3fKjPkXmBSmWurTX/dVnt/xhWBdOGyiMA4lP6rBl6e5cxn4V9jobvHiwAmsDh/TyVPvKiRqTz3rmOcjJfXme7dYLpX9m7D2bbOTksTGDgsaIWto1xAYjssuUwTkHclp5fXVnReqsdw9LVJbGUl/E6NOseVN4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:22:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:22:26 +0000
Date: Tue, 23 Sep 2025 09:22:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/7] sched_ext: Fix stray scx_root usage in
 task_can_run_on_remote_rq()
Message-ID: <aNJKsO4vv_FnBSOe@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-3-tj@kernel.org>
X-ClientProxiedBy: PR1P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f72711c-d112-4856-3536-08ddfa71f2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1de1fxeS216kQPdjhYivGOcmwcDbsRVavfb4fJHwojqsQM4q3rOx6uS3KcCP?=
 =?us-ascii?Q?8pL1Fs5H7bUZkVXJaMXPlxXv5goB8hseQVn/Exc3qHfhl75+sfsC3T06SDNJ?=
 =?us-ascii?Q?oAoSqCIHrJ+1cE0/WIPwbLX+IyKyNjHv7mHXlZLcmTwJsEx4g5DBD5EAqWWJ?=
 =?us-ascii?Q?DnpkCucJlZQhq/1/WWl3n8TDGKRzwrCuPtqQi7XDAUe9YYDZDGJ7EEo89fr+?=
 =?us-ascii?Q?4pta2Fsdmv5c9OH84Oz6ieYGgX2GY3tPzKkp4QB+2DSU+tUY1K3l2CeyfUnJ?=
 =?us-ascii?Q?1NAoeL16zZ1S3209H79YBY5PAB3zexNeXhEqHwF2ARmNI8MjlynJOIQ0e/Bi?=
 =?us-ascii?Q?P5/52dZ0bTzQwS/NY/xrcH47xQDfJ1qSjsEcL4GNkvkLA/BL2iOiSFbeSzLH?=
 =?us-ascii?Q?yCHK5yTGdzjL1i4I24doIZLxt41dBChwjxLXzrroMl1CBUdascSBaNtZwgAa?=
 =?us-ascii?Q?V8Fnvu0kpYLTg72NJ2+sPxbNttYwjJaAlnikRZNmF2mTWOu8sex17EtizEOr?=
 =?us-ascii?Q?Fme8+o9vO854wkCmhsoeFWsDFVuFqAQRST/vhe9KGQ1YGdlthblPDXZvf/SX?=
 =?us-ascii?Q?bZ/TaqDa0PsyH3rK4sFKa1bAhB1Pp5MYDm7YQauZjvXh8pZ3w6tkGUR0ooGl?=
 =?us-ascii?Q?B5mbt26GcN1s78PDXEIEITYT02miNwmbVb2PlfIo3bBcv4Ho2QW+l+6okhbV?=
 =?us-ascii?Q?+cz2oEO8eqRdnXp0BdKpeoy57Tw5v5g4/awX/kRbiEVpRSW/Ogni826ekYPa?=
 =?us-ascii?Q?Ymg1fl5yDoNbOA0aQWzJjSLe0hpPXslDe4Rm9273v6K/cWXC1LramO2jInlP?=
 =?us-ascii?Q?cXB5WtINXNiPCSPohhuQcbQx7OERWXZGxG1N++PSmeV5YFpicpt1veV8kgux?=
 =?us-ascii?Q?GuL+9J0R7MUqvMkU8ZyBpoKIyuKIRCI9zpWy3wxr9V0lKEgewIZEpuzcO+XH?=
 =?us-ascii?Q?HufxcLj0gQzvnzXp1UCvyi6m/q9AWaI9LBENL0F/TxZJPDxQWDel4mSoapvw?=
 =?us-ascii?Q?IcjdZ+g+EPAgS/N7YIy6puBNPRU/TGegiDn7GORZBXfWVd9hpZ03Q3gG+q2H?=
 =?us-ascii?Q?LZT/a7LRtrHr6e/EmWmcbvYX6ZCB6wvUsBLF+vLWoRcIzdqgWsJFHq5tRcUt?=
 =?us-ascii?Q?iSocnp2bHV7D/U1y2yAhL0GworcVClfkZY8iAVTtRDDmtRNOfi+PWpjZQcTs?=
 =?us-ascii?Q?2Tg8nNv7MDXJdBll4Sr4E5H4912/wWajufc9AAIhxjz+9C/9Y3/K3gBtxZcv?=
 =?us-ascii?Q?MoKbfpYwI9w8ifoBZ3bsSjYYQ8ADZohivBp1oIoVIV+HNuwMurmyW37/vqvj?=
 =?us-ascii?Q?JtV+7HWM4BFPAMlb+eEVtsoq50o3ERtfiYIM1nA0DO0/RBqfa9rVTT8Cfml0?=
 =?us-ascii?Q?psJF9L+FxEX3GEZkDwoWu4b8Lj3B2OO+7jZ7hAPSq32pXdHi8qkX+dx2hz/0?=
 =?us-ascii?Q?L7Y5s19h/T8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fai32nTzj3bwLDJi2oxsJhPdSTDmI29FE4/u6pXkzwMqpc0BNiDuxxSeVnyI?=
 =?us-ascii?Q?JZJOzdWpjZlgmV6v3IXFbi6YSQC7MCWxrFtLJCq0Rk2qEGsU3+1+sjrL+kz1?=
 =?us-ascii?Q?80PpBVfZmwbYiKli2gDoTc1bQAilJ6MJdBWrYKHJ/xcr7hIWKG3zRcrMw7zS?=
 =?us-ascii?Q?P0nPSjJeZ0htRXpC941gyYjMu4xaFHP//Yv1A8XkxT5N9rZTUIkH+WJPfFKS?=
 =?us-ascii?Q?fgDb3T/Q39hNDwvYOX3v6McKZgQqsOTr53YKTtUZ8MumIdsF6ZTUw1fiPp6D?=
 =?us-ascii?Q?2JyTKVTe456g34MBVUH5+mnijHjB6kopO9rROeYzPTm2J+3us46zK1ck3lRf?=
 =?us-ascii?Q?PTjFcew+BJRrXpAhxIujQ4PAs8O1BC0bfBud4/l3C3kVuBoqF0UOwTNGPVKN?=
 =?us-ascii?Q?0QRjYVAzx37LDm3sOjd6wjpiDKTvA0K+3wYy+ThtZtAo333drWMybhNPRHat?=
 =?us-ascii?Q?e9uKWH5kn+kHbbq61r6aa91/AStW56AgpLtFPTzF5pOWRajNsnE1PEITKubf?=
 =?us-ascii?Q?4tusfCs3q3ODf2a9H6rDpEpjpzTNi04iRRY2X7PX7aJfu+UAQ9w6pEofI2Ns?=
 =?us-ascii?Q?nPp5gZnobXTsy90JOMT469Ao9V1ZUoGGiTj0huxqPdwPdvA7Ux1U6WyqX99n?=
 =?us-ascii?Q?Y1Vw18sidu7anXM67IG0jNe04ettQrVMWyh7xDXNji8vikc24jqmmmgynQEn?=
 =?us-ascii?Q?aJnh4VY3e42pcW2w576vINUHX2F8sKxmfK87esgzwdqVHT9imV6VtF+j168J?=
 =?us-ascii?Q?b+GxsBoDqJ6G8HzYjwbsXWny8/AmRQTPsGHocphBYIJUQbleKnfFIPGDlKhO?=
 =?us-ascii?Q?oM+qE+3091vE7h1B2uXhVxnRT1wWDA0afLAAnRmiU6flPfDQU6zmDciEIf2A?=
 =?us-ascii?Q?crcZXQV5gzVtgiH04UAs3VAUU0Qclu+uMzBBQp3DuIPKqgfai8rzD0TRkoZp?=
 =?us-ascii?Q?wPpMfjX88hyru2K1x40y7Lrt2pKBKKvknyjMrfMIl9dey/dyZRcPP0l0s3wf?=
 =?us-ascii?Q?xg7inBvVkZr0QvNbvV1E9icD4Dt30pWd44iFOd0tjc1qVI9riEIx5umSh7QH?=
 =?us-ascii?Q?Rk/My3jItcAqs/5IOYgW4V3KOpfCqhln8SDXLf0mrxqZ/5Degt+1B28aGom+?=
 =?us-ascii?Q?5zvi0Yei+SdsDPhhpRXqvg6NzxRyFL2PYtDVgzJi5TD7tcsq4zmN/eAP0rek?=
 =?us-ascii?Q?xfkFxQ+L9H1k2YerQW2/Fz9ZJCrIswfU6SO/am8JSu8b4CRzmgXvKXHlSIit?=
 =?us-ascii?Q?35hA9ZIcV+u5xeBQFi4lhJfx5wWwa1Crsg9Q3uLM0Ig8nwHFCSvan3Pw8q3x?=
 =?us-ascii?Q?HX8IcBKn9obX19VOdh2EYA9siUiOq2stGVcOkTkPe4yUijLs7b90kzx+6rO0?=
 =?us-ascii?Q?K4hCmJ+WY3wdnUEl5a/8oXdajjHY5oz0iHYQWxsAo2VFqe0amoG4Sf60i0TR?=
 =?us-ascii?Q?xEdnfUJE36i8VK7VEICR6XpBDEQiEZzynVpaMgaxVRyLgGO9IdxbE49TpWvf?=
 =?us-ascii?Q?kuxH0BJvBpy9GHSqDEZlFCt0gV5Xd57cNGD8DeyhumI0AsZ4U0Ho1ZxcQiNk?=
 =?us-ascii?Q?/86ZQ57plCxYJ4bk97MdBqM/PVJQJ5DOYCbbXju1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f72711c-d112-4856-3536-08ddfa71f2ae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:22:26.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuHhvw+yqpRO9vtFkR40lSJZPhETOXvj6Qxyt6guo9Sa5JkWZLbM8z9Sl14DM3ZxCw9EjbhOczBiLl2UP/5Z/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

On Sun, Sep 21, 2025 at 03:32:42PM -1000, Tejun Heo wrote:
> task_can_run_on_remote_rq() takes @sch but it is using scx_root when
> incrementing SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, which is inconsistent and
> gets in the way of implementing multiple scheduler support. Use @sch
> instead. As currently scx_root is the only possible scheduler instance, this
> doesn't cause any behavior changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Good catch.

Acked-by: Andrea Righi <arighi@nvidia.com>

> ---
>  kernel/sched/ext.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index df433f6fab4b..5801ac676d59 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1622,8 +1622,7 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  
>  	if (!scx_rq_online(rq)) {
>  		if (enforce)
> -			__scx_add_event(scx_root,
> -					SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
> +			__scx_add_event(sch, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE, 1);
>  		return false;
>  	}
>  
> -- 
> 2.51.0
> 

-Andrea
