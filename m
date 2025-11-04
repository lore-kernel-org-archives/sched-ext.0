Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798334677F
	for <sched-ext@lists.linux.dev>; Tue,  4 Nov 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293049; cv=fail; b=nA7WlkaQ6SFfQu/HT+Hy5fEIjljaUJtlhYyItvc02ekNsEN9jM1MpWS15wl77whhdQc4ZCxEroIrRIZ5CtWVtNIsf4jz8uuFAd6zDbAUZrMN6ARgLRCHmDbblvLGfvOqqHQKnebFZzXrw6u3zXESoubvlxAQ3hGZlHACGAt1hBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293049; c=relaxed/simple;
	bh=Wf3pG3ygphfCV74TQP8nHAkHPxkes7QTnkNLUa3TgAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTf3E8l0nHG8DKxCdUVPQVv4nX3I68clLcGqHAfYRCyvqSd8N3PNIU9zGaqngsU/otDvWr1isn331Fsopy8LohAjjowWODTxR5KJSg1BwsMBlc+qwKjBmOLclgmbYHxhVFvAcqJsbJfmFwMtkn1byN3WSkw8DeeOTMFpI3MfjtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDnxvwpC; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDnxvwpC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCe/VjPmmAHbbpePZNbpyb1pzHNUt9O0pMjD5lcgD2dQ1Wva0LngwJpcqz7dN0zZGemD3YWECj2OoFPOLL7KdvhjbA7OCp5YIhNyGzKspdH8/uXJEkJFjvp6qQyOmsL7NUYJX0QZ2BuFR6qUO0VTp/jt4rfDkfu6o/qfddYWkmbUFeQcyTdMIZu8ZhS9qakXYQJGQRX+UcnKnrIsbbSz3mEC/zMxplr8jthOcclldgV86aTYLZ8fbmrONQeH5Gqlpo+zzMZYddVmCngXaDMusAn+z1ef4VDfKWXHvBRu088IvLqRzc+oFWT9CiRMYPBsp8b3Wk/ogaIz6iIuhIY7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2dsgXuw2IcpMXGaVew9DEssDIE7jDtxz7kFZtlV3lQ=;
 b=S8ekkBvP0aHLMe2ifCp7t6ga5+NKoFBfrc8VkTIt5laFcl+kIR228wMih4R3cinFhi1yOjXDwgjuQ0kz2WmLCseD244Zjivg0vkQCvUuWxmnFGG8Ayjcu4IF5vl6XkO6dWRdzD9lZQYIU/Y3L4UxAxWZDmL4WXzUoT8kRbUyPQKMJTY/rSkXXetQhRE+rvooLH+iqDOQi2I4e4ocZ5LNl4xKu0ylASkT1DyMfvHed61fxHiM91kInBP3w6V7a5IrTInygH08IljWfigo0G7G1H3KfOXpIm6U9PghuKOG87wzY+uvxU/Rn0GHAcyJa7rboDMublBfS3V8u0tvVCHSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2dsgXuw2IcpMXGaVew9DEssDIE7jDtxz7kFZtlV3lQ=;
 b=fDnxvwpC0PMaPtFNzdbwUUkxv+2i8sGp1M2haXIBHkhCYwftQkZDT6SU7FO27mZXcuyLRXnQiglWLObIXQuCNXNXkeI0b0mDv2eyCoTakZEfVrfYrswvioK8yjhByNH3q8KQ358krObu62yohrvrlrwdNmdYhWrXXiCpP4YeT/IG8X4w42jzYi02g0hJmU7YIan+1keXdARongpntEW3nUWqc3D20JXZqng+1dqQnJidkdg8Jgy1SLujM5Nyj0kkfj25kxaWoewws5+bneYAcYtAolZa2Q7Q0JduPAG+fwUxoAxcSY4BnF7ce9s5FZOR49sUvs6B1PbM08Wr9BlmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 21:50:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 21:50:42 +0000
Date: Tue, 4 Nov 2025 22:50:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Move
 __SCX_DSQ_ITER_ALL_FLAGS BUILD_BUG_ON to the right place
Message-ID: <aQp1KGGSPF6m4NVm@gpd4>
References: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c20b74-1226-4159-d31c-08de1bec3321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unrFi63fP9hg/w+UMN+TQo70OWtLWrg4KXcZyEiY56vIwGvMKVsZYyjesM7b?=
 =?us-ascii?Q?i2xxsWUBJ+ExyjG+LAhUvkbNJ5U7yBQZVKibIIfIIEABuEgiR8lNFZ1eu7vz?=
 =?us-ascii?Q?Qfi/Si5babcgPjU6S+Qst7MFOYfvtZOJONK4VsFSjUBSGaK+i3WsDIQyncFa?=
 =?us-ascii?Q?6G27xqSDxhH5PckxDV8t3yaGC2gr0N87+hdu/JdCZk3KXj5xjgs9a4h5BVWF?=
 =?us-ascii?Q?rh+9mAiQYYVXUGoIdPxMWkKkiQETyI8YBxfq2XuGWYAplakKy1Ts/4LTKren?=
 =?us-ascii?Q?W6l0cnsDAKSoe1GwloYIgInLqtVPIyENZXZaq3xCcjWylMRVp0YzqPI5Dpra?=
 =?us-ascii?Q?udn2YG2pMDBt4ND83aeqDRIYjG6yf3KVRY8ss4g876I3FXM14BTrk5Y114kj?=
 =?us-ascii?Q?KZtJttufqIfJiBJUXtPyKcx/NUOJCGY6MfFAog8FJg029eoZn+aQCwWhQPsJ?=
 =?us-ascii?Q?QBx5YruyeZtBJ9Ah4uRi7VR3vp7PX89lcoRHgvRIK2DNROpEZbMlBGux3ykl?=
 =?us-ascii?Q?WzJRmh/sISaW653x29bq7O5mkYSTkT4u1sVN463gNp6+q1WOz/R4V8casm9A?=
 =?us-ascii?Q?34sbtfq6IwJdogJXDAtNnQ7fhtCt/T/+cYeuZLzh/k6sI41H4mQsk42dKvYX?=
 =?us-ascii?Q?qKsJ8LTWhZRufiKM5we4up3kHijo98B/RN+nafAtcpeX2lEGZIN2VAVjm6rd?=
 =?us-ascii?Q?QR5awHEWiN5KwBNYMJ/6XdA2KxHlojpSQfR/E3iLqg4yk6RDxzPuZ1DpbEgK?=
 =?us-ascii?Q?dmaSjoqTqvd8AhraRlrmJEYDVxTA6AQE3Q/Kkjwn09pD2ONKByZO4t9DVpaJ?=
 =?us-ascii?Q?iHncW1vn+SvG9P6ZA2D0TPJC3rWQQ1R8gss3+wHvOMwl40ywwnr6+g9F2MCP?=
 =?us-ascii?Q?JPpFdABFVdb9MHaCYfYnWXdBJsxKlDzR9HBYYWeoMUPTX8wQQ/701/4VJ6HV?=
 =?us-ascii?Q?MHlMfGEbtZ8jt6pwEM+hHyu6uj5F2jNsRrz4cx0H/xJE63xbkkpGeDRP9rpU?=
 =?us-ascii?Q?fw1nuisKdP3KsAyjHh/cI9JjmB5pM8TuzxX90ieKBNDClDlMhKABiX9N+mhP?=
 =?us-ascii?Q?fKgNS5D2CF9Nyvl4tr/2eOEMWlSgUHOveneB2GhONMEq++DEAjafjKcgfrl+?=
 =?us-ascii?Q?HOLnD4kKchalgKx1GwIjTy2GAim6Rai5YuxUeoQyrqCcxiswQiOvP70MxLxh?=
 =?us-ascii?Q?o7QsXMFpeGf+WrDE9NF44CPpK7/N6JQvw9R4QtNRlUEb3xHoONTxhqOfj7a7?=
 =?us-ascii?Q?vuMrKm/J6youpT0VPqrCw4HeaR/PzDBy9FZ+AF+SqUS+M68AZh1+DmoiN3w6?=
 =?us-ascii?Q?qxjeUnaNr9sa+gWNp1tTd8Q1F++rGZLMvcfk/ScH/yxZi3wb53/y0PE3rPHg?=
 =?us-ascii?Q?Uw/aSor3CnG+P5/3iRjtu7pDtpuiFX/PcK8RybPMYctDqW/fhVnGmMCIuw6T?=
 =?us-ascii?Q?aEEtdcHVtUX66308EWOmaWqJq3LKCEJA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UAqHRQW16DGIxKVfBLucDOCevnqJYQMlBQvGu8K7QkOFIDEYG5a3Qz9Sore?=
 =?us-ascii?Q?+ShnD5qILbWE4GaA8PXKWFUkhumcZj4jmP8+TwyetTOBv4aiM8fTA2pqgqOh?=
 =?us-ascii?Q?ChXPPo4wMIBw18KL++Fxbhe42aUuHgDSOAxXPQbd7JCwuJ+7fb+vCIcB2Z3Z?=
 =?us-ascii?Q?sz38iuVTiYNIvP2PFSChoVdbGjCSn1MKuum0jy7DOjBqdLT6A/z7we3tsnTP?=
 =?us-ascii?Q?+bKdlixdLvkAYGmNJtbW/FgngWoK9LdTtvx/6awV9cGdOz2G/P5hOcFU7LgO?=
 =?us-ascii?Q?SoI1ldc1m6v9V5PKfPr/VUPGpeRUw1Nz6YK3ykeVIJwu9VRUHEixgKnhC2cC?=
 =?us-ascii?Q?vuLK+5SL6YWbsLGxF+l+nOP95W/epsAAAwdOEK5M9osb3K2FI+LlM9LoO+4c?=
 =?us-ascii?Q?F067ddzvAibJkPL7SY8ZlLycaSe/j5K6TCiOBogn3qHimb8mxfzfkpTOIGfQ?=
 =?us-ascii?Q?+HW0jCv6PeSiLuSrq3JfETCaFOW8EvtMZ/7yY5GI00w6m4rC3Gkc7UBoQJ2d?=
 =?us-ascii?Q?8ISuJQ889O2rnQ7U+mcpEcJOWrgZ9aG9gC1WIY9mnz4ZFP1RTUkrIZnwLWPg?=
 =?us-ascii?Q?X0grd4hmU4UKplFCRG4pOv4H8efHOLt4udar4AAZkxFbN0oI75bm3lDWQGjk?=
 =?us-ascii?Q?zlby9dJai/hlRNoMur004E+P75ZSaF42d9FKy/ff6HYITkqOzT7Z/nAzQ5Wp?=
 =?us-ascii?Q?OTZRisVylvn4qtfWu9aDGUR+pkYsr2pVlt43me7tl3GcwQc0JmV1Y+IDesG+?=
 =?us-ascii?Q?kQTs+MF55j9pf54tGWpzOgqzG3CgisSbEBDLqzYU3EWCJwUt6p5W0Xyr+jh1?=
 =?us-ascii?Q?2GnlmmZja7YzhTrNwcdTzg7qpk4rDhDZs0bHdAtrMPCJo/XJArXLZTm4QqCm?=
 =?us-ascii?Q?zAQgNn1PFfBTBq9chd8m3Rcv/t+vW8IfRh+dYEriKsE3ITPfo5T5X5IDibgc?=
 =?us-ascii?Q?cTvcVq4hzP0SDfg8QXavV5vIr7kjN1Fta6lMyEUj2jcTyWY2WeyM3qePPgVQ?=
 =?us-ascii?Q?NVGXDQoIBOMtaP4O1nPBVOijgdQwZ2/UX+oq937wNoZx9RP03/pBf9TudPrV?=
 =?us-ascii?Q?q73DMixD6pgwc7rntF3dCOQPScztfc/1aWqsoIW5+dqlSrKjdWzvCWeZgryY?=
 =?us-ascii?Q?fSdNx7NM0FxrlwNoWRSEdiCzvKIoJbuXrejsZcm0bH0gkx2A94bfjf1Iw14d?=
 =?us-ascii?Q?h1UKBW7CEmjddtPwioycHq9c2/3D40r9REg9KYCIXaZQtcTFlgLoa20MQ1nH?=
 =?us-ascii?Q?pMJ6mxjG25PfLDXCs+fk9MWtzwokPtx9csZZd6wF9sVdi3XMNpxy105XQ5+R?=
 =?us-ascii?Q?iNxVcOGg2smLS15L92FTJtfWBrXkdR2CQmX8jVCYyoFQYYyl3VriYapsRR0A?=
 =?us-ascii?Q?6+ooZ6Vl6Lu0UzOYQKDGlJTaZaU/bNmXqWDZLXz7q/yAzrUbKdKjg+pUQ1XQ?=
 =?us-ascii?Q?wZ4vT79V8PT07/zgwhbTT796n80vts8vU1l2BucseKpLKK5xRzcHlFrSAOtz?=
 =?us-ascii?Q?ZHTYNwgAu3zausOCAzPCjFMTzhtv+YLrWq6Avu3LQ17LQIHZ7WL+2uuRRBKo?=
 =?us-ascii?Q?aesCs1eReK+9nC18lCZLJmefjiATmOlvZ/ZWDAwS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c20b74-1226-4159-d31c-08de1bec3321
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 21:50:42.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUudzEZpRhPyTiH70DSt49+sEp3P/r6EqsQL4nxIFqzOkcC664cJKOlEgHJ1r9eHdozrF3djs2RhDIekRr6y5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

On Tue, Nov 04, 2025 at 11:40:22AM -1000, Tejun Heo wrote:
> The BUILD_BUG_ON() which checks that __SCX_DSQ_ITER_ALL_FLAGS doesn't
> overlap with the private lnode bits was in scx_task_iter_start() which has
> nothing to do with DSQ iteration. Move it to bpf_iter_scx_dsq_new() where it
> belongs.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good (both patches)

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -474,9 +474,6 @@ struct scx_task_iter {
>   */
>  static void scx_task_iter_start(struct scx_task_iter *iter)
>  {
> -	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
> -		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
> -
>  	spin_lock_irq(&scx_tasks_lock);
> 
>  	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
> @@ -6218,6 +6215,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(str
>  		     sizeof(struct bpf_iter_scx_dsq));
>  	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
>  		     __alignof__(struct bpf_iter_scx_dsq));
> +	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
> +		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
> 
>  	/*
>  	 * next() and destroy() will be called regardless of the return value.
