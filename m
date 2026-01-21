Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74B3ED100
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029880; cv=fail; b=JZSQhSDJyfKeaibAx0u66VEPU+mG0LVe1YIlcvgcCgGXMOUXAnB3dOzFijkgp4yGKLWWKSY0gyXk/XyplQ26NfxSQESZ1IZnGzQ8WknuzyOEhGTY7rJUZk0FZtWZz27X3mF2M3bMR7lNviN9ITBMYAJrv5NF2CHm3aWv+4jtzU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029880; c=relaxed/simple;
	bh=zDcDCO37SqrCEzfIJfmZidCYdo0JyyWr+foQsa1l8V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTfBehy15EqVgtJy6rT1afptZFm2vOkOWlQOd40GA5Bjk6N40pZbQQbGVJR41LaWDZysyaevGD5OSlh/9SqOUYE6TTFTfe1s+q8xviFJlCy43GuhB2W8A5IpOaHQP0thtVq35b9CJDzNN1V1TM6TXIlD3AKkxvwrdN2qLkUg6zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCnC+vjE; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCnC+vjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsAIaZ98zRPJSGOhkmWTQYADiD064E2d2eH+l1N8AmCKyENJHjBWb8E1/+20Vx4Zqd2h1a/qf1KZP5WZrL10kVt6e8y7b3W6t+1Piwqc3O6sHHZ+joTfvdj+0BLZcmYUkYJ2twLtkzbwlZXMzb5W9N2j2bRFbsT2fSrlMPYB/sQICr6aTDOLJAOzR5PLPzEPpJ+4qSWr+13f8LBeUAJigkaoZUJ9/welpUpRA38zhcubYxSHQIKCX+dL3EC6bNzHr/CFQKnusesacFSeZD43FbDMHh+3BPyibDVQMlpDOpWfcLySukD6y4VcFdajGe4pWYOUdEMLWzeLgQXTWl9FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iQNHwpu3obtx4/MSPxt9Qhriye2iYgSr/d7g8feT3Y=;
 b=Y8RM24bL688FmHjtDYXzwvgCsroYBqfZhPfj+bLTsP/k1qJ4u13Ns2/2ordNyAFSboFh46eK3oa2/Jd2S4ZdgntYbAMFP+x1xeXs+5L1dN/hNDyS8s30dlVicnPG6NMcVXD0fp1VeHDYIsZpCkjh81T34CxLPjwnkLuniRL/XluAkqadi2rCbJSJy/LeG8jOOI+2WNPCakShpLscOBV3VPH9klzMUzTbO3e8hw6RdeO6eSMOGgy+hqcOPYDLljmzY9DsWvIRFNf4QiRxNLc8aaKU1QSIF2sHBWJ+z3d9ee699Z7WmTc+BMxk7oT9LLby47LJ1zRlv/D4h9H5xMYtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iQNHwpu3obtx4/MSPxt9Qhriye2iYgSr/d7g8feT3Y=;
 b=YCnC+vjEilyI3NrFifN+OVXvxNKXBgj8XkvyOp7Pvq6FTOyFpdlR9YncLUC6qH3BfC23IbHMmLTcWUnsud8WybDI4UmTZodJPwt18UwKQYIzLpCIeQlKiPgFAo9arX7lh0CGIJIWR2wBcKUx/8TpNT+AOqrzsxT6xQq9bw2M5BLu/YGiazOIvDWpgUsJtLU8LAhgUwUuSr/j/mhOli9hyT/hyEMNi/KtNy0iI8MpK9Kc7bH7T72X8yqO0kdO59uTkPtElTHVZNSLc/hSgt0hk2cxBfH8zMUGiBIJK0t/IRgSAsetJf0LAghZ1s3cvppzqX9KdfqAc8mayCHhaw6okA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 21 Jan
 2026 21:11:04 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 21:11:03 +0000
Date: Wed, 21 Jan 2026 22:10:59 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Daniel Hodges <hodgesd@meta.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Clear direct dispatch state on dequeue when
 dsq is NULL
Message-ID: <aXFA4-b4WLPjxCME@gpd4>
References: <20260121155602.598130-1-hodgesd@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121155602.598130-1-hodgesd@meta.com>
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de7a907-2fbe-46a6-a70a-08de593195d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gBAhwsK99mWjmBMZne3xKverqC1/nE/wjrgZAPrj0ONvgbhDfti5BDkLN50?=
 =?us-ascii?Q?4yO7g1UfTMxdr0fQLC7ViH067oHmEZECCCftuzIOVqVZkewk9zHuTPSPdoxQ?=
 =?us-ascii?Q?x52iTZA6caiPL0QvqaS9ZyMfAqdU+BGITEJUaol767DSPbKnej6DUoHaBlV1?=
 =?us-ascii?Q?bRZdwK1X6877aMJXQHAkcPKzw34xWe6qyCU69cB1JEYkcjqSQYQYMz+AjfNB?=
 =?us-ascii?Q?4XfBxTO99HiUZVutuJKqnPG7eMKCWNCzI8zQ16rUHvKs9fPkrpWePKXI5NLg?=
 =?us-ascii?Q?8CAH2F1GaCUkeQiAveHiU88r7XDbkkDegoaRyheEK8XVwRj8H5ZL6PNnAPiV?=
 =?us-ascii?Q?Dnhgw9zlt44cZWVUsUz2EnqvSZaMyuGIiESRu5omBP2V6rS0/wfa1FN/D4Yf?=
 =?us-ascii?Q?C0xcnZDLZ9LHneEiw4oJNfyGUHTFkVFj1vx0wUii4IivPhhKWVtybsYGsYU+?=
 =?us-ascii?Q?x9qFvAQCnVxD4XhwzrVqK5RpTLnxbvSBg/BE7jOvSl2B2TAFIGdHvGumO0xO?=
 =?us-ascii?Q?2xomgIlYOsp/Q1Ir6GHqJft+rJrrCM4Q4KU6gGYvaMxNMm79Jc0mtjtuhKnq?=
 =?us-ascii?Q?SAj3q4eJYM5ifBmKZB2Y8gYIwCYd9BdSPCtcz1Z3RrPTYWJNeSfHz0/0Z/y2?=
 =?us-ascii?Q?Kogel4aIDTNg8xnYgQtWhag96HDc4MkqjgITeZ4y9f1jQK5YrHzeikiXQtnt?=
 =?us-ascii?Q?z6upHFTLQwPGiuj+4VsOvRAosqqEtQamHOn/39RB9VliBSjkAuDXjAo3O38W?=
 =?us-ascii?Q?3AI2+CtqrCJj3V2K/wDm/+EBVVSHdhV09lpxykXiI2P+GLzOUo07inICgfWr?=
 =?us-ascii?Q?mHBkX+RY9snabGLrviuWNmyQ1Scdp0Ham87+qLxkxU6o9A0CQR4PjahsRhYR?=
 =?us-ascii?Q?2rt5CmsxoimcKb4hoA/xCjLZfCVMwB5PXmWvnUXKT/JnwQZxRXeWIIBpF0pz?=
 =?us-ascii?Q?ws3Pc6NdniSZNKmqUkXkKtXNVP7vR5WujtAQt2WuopQsSUk+d3GjkLJIKxgy?=
 =?us-ascii?Q?MzpCEbgrvqIo5D+LOTyvkFOoSdcp1bVT5cvVRZNUiICmUGaGg3xr7Q0OHs8y?=
 =?us-ascii?Q?4ND703W2sMta8LhI7Km7pMm34YpQLUd2MCgzBOmL7N1su8d5z6mwpyQqfYBb?=
 =?us-ascii?Q?9lU89YZVvPNsKHCBLi/MFHtzW1m2bllSji6aTAHe1KS4f1d0/YKgh/VEM5bS?=
 =?us-ascii?Q?MR1MVbGcE0w2PuaGZHPn2Pa7mZhheVefglFy3nW2Up26Dca+APucztgULk0E?=
 =?us-ascii?Q?muVFPKn4vcoRL6vs0J9jqvi1XLtZt9mcbTlgXHEwD+Z+15u5IdcBRuvpaWmo?=
 =?us-ascii?Q?iIshlnqTuM3pXgmLEOMmKMhXyA6aV0ME+mAjdSLIe03vOq1UqUaGdysMkE1e?=
 =?us-ascii?Q?Ni3I39beOrvJW3eiiTp7iurvmcuk4fHSS8QpzGlWeMdeO/cvGIa7SrMmXmTL?=
 =?us-ascii?Q?sIb3U/PlhXWgFYGHnjRjiRKOUUgxox3ahV40VGxIu9SKlyiUrVwgQwidg1w/?=
 =?us-ascii?Q?jzv7IkpAaXG5/00nEK2AQCt/xr7fuYaMRqMbaY5JEC+XLZhaGtFs9VeI4yJQ?=
 =?us-ascii?Q?ek+OK00dVhj0D87bqqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQbYQJKbd48nWlWdJSS+wu2nA146LpSPfeGWuQKMMNvF6S9cbqoVhL2CCr8N?=
 =?us-ascii?Q?XFKKSYX5rqkFHjhCMwcXukz6LVYA9ZaUMA/wY0AYJWiSuD6t7K+l4Vjdy5ak?=
 =?us-ascii?Q?fT5d8vp2dbjIbR0pitx/xobh5USt2gsmjmv6UkJ9M0LjIV1b2I0WBud6EJ1b?=
 =?us-ascii?Q?51SwOGwW//RAwl81lpAx7skxsdTb0x7ARzy0cogO6gcweHKJGoPX8nUe6uw9?=
 =?us-ascii?Q?ckFOZrs+rd/idowm+Wupu/J81edzptU24zEquWvrP38OfLX4IC6PjPQpQuO6?=
 =?us-ascii?Q?gMM/gmXhBKy0KgMYipf60m1EU50UOQBcfKY1hlhxspuHT5RsHt6SWe0MpYP8?=
 =?us-ascii?Q?ZQKH8LEngoQaJ45OqKhEa1q3dfHYm0sTzof6mGaFWGEeCPeQj2tsW5vk34jK?=
 =?us-ascii?Q?JtSPIJDZQir5jz4XBjuf9tjiAlQSBmwppv1O5CK/S6ELGSuM2NRxOvZ5Uj6z?=
 =?us-ascii?Q?PfAqi1u2US5yM4sNFrOHHN07UaWO9OE40Oo2nLiZCv8cmcF2lnK6QRsTYblN?=
 =?us-ascii?Q?oXA4QYoeW5HfiYiP7U1/QOHEQR1UgydFc/ox51QgvQkFuEu2++joULtkWfz+?=
 =?us-ascii?Q?/Ubwi13D+QKFOb7IKOWMiFoLLoyNdh7QXyuMDSKzXW3F77qKt2dT9shn0pm+?=
 =?us-ascii?Q?oAADCW8Hmgzj0wPowCxALRA0uhcR5v6qYRaBJZB3xbj+cY6o7feXj7R/E43G?=
 =?us-ascii?Q?62H65xoz832B3sATNGToe5JRjB0zFBaxDkF1SiLxdE1VhKWAZtWvt7Zx5+pA?=
 =?us-ascii?Q?y/CW1CK8baOeguZir05+7JaZKmZHHYJhfWumQwh5SoCpR1WajUC1nJAZey+X?=
 =?us-ascii?Q?C+vqcpmsbgJZZpZ3jbiTYRJWxkgrC7yODRIaco4ys25CNeBuSPPd3WFUeQA/?=
 =?us-ascii?Q?l7EvFHkNJW7D1VCEtECcMa1094NAAHuotUz1Sbf6wqhnm7cPIFEHjlOEmfpV?=
 =?us-ascii?Q?flOcrJomnEdT80jx2KeC6d6rX5+hGUSBj/d/4KE5GPmY6TKMVhaVGOvyqpvM?=
 =?us-ascii?Q?l65ygrDo9NFZQ3BS+9viJk/mF1O/5yfZeM7J96oxIthnmaMVFocCgIKvb9R3?=
 =?us-ascii?Q?HlC/g9URxYbAuy2AOst9P2nW/4A8vviz7SRcdVgKntDe5cXU1BUjkkyzOz4Q?=
 =?us-ascii?Q?dkqkUl7KVix8ly5ryznZwP3S2SvN7pxSiFprNlxK3Tb6+wIE+9hwkR8dEnfB?=
 =?us-ascii?Q?IgX5NBTHN0AzVY+2Dzt/WflPaE6k65VpErs+L+d7e0WVMYYrHXwpW/4VdQfs?=
 =?us-ascii?Q?VKZaKyuylLuIx9L2oVy4w1EnWFzIO9lWfA6Pyyt4IXO8Ar0x94dVgOF/jz6g?=
 =?us-ascii?Q?TiOV/4GSyUSHX/1rTieopoCJ33U3LiJ8TSYVzMSQi2DJ3/tf7BKSV3u6mJfc?=
 =?us-ascii?Q?m9E593Ok3nUM7rV+V8M9gBou7ghNVszJT6GCq83gqvMKcf9iPUgrC57JfMVC?=
 =?us-ascii?Q?t2vvkuM/QR1ARwfyWbz5xD5O8w/pDuhVp/1qT7Mv0aiSmoBeUznckic8pOhq?=
 =?us-ascii?Q?H0MAfqtQO0tLINeEF7RTp+tvK7UeGv1yEah7fUKzQqx4mvxjLL9oXwzNS2Hf?=
 =?us-ascii?Q?aEwZg59/usJhmaok46c3+vuT292r8HqvjR6fAfYDefmvjFevFlpuvqETMNdn?=
 =?us-ascii?Q?8F2doXm4uNoJuNupB9mR3AZqKP1FAbMCnzd86Qome6KxHs0fHjwICf+fxsky?=
 =?us-ascii?Q?vFZV0iEQlOYOeezSpomOebiFM1QTkUt4A1x6AnIk3kvOTgYBJHghW9oukMKj?=
 =?us-ascii?Q?dExL6bxzhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7a907-2fbe-46a6-a70a-08de593195d3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 21:11:03.7825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFXvvdfheSk8Dryf2Z5XLJHlD+N2SZJ5BfFHvsloO59RxrlYnoflOv4AANCPLabA6s3+VeNnwpACP9/N9kKoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

Hi Daniel,

On Wed, Jan 21, 2026 at 07:56:02AM -0800, Daniel Hodges wrote:
> When a task is direct-dispatched from ops.select_cpu() or ops.enqueue(),
> ddsp_dsq_id is set to indicate the target DSQ. If the task is dequeued
> before dispatch_enqueue() completes (e.g., task killed or receives a
> signal), dispatch_dequeue() is called with dsq == NULL.
> 
> In this case, the task is unlinked from ddsp_deferred_locals and
> holding_cpu is cleared, but ddsp_dsq_id and ddsp_enq_flags are left
> stale. On the next wakeup, when ops.select_cpu() calls
> scx_bpf_dsq_insert(), mark_direct_dispatch() finds ddsp_dsq_id already
> set and triggers:
> 
>   WARNING: CPU: 56 PID: 2323042 at kernel/sched/ext.c:2157
>            scx_bpf_dsq_insert+0x16b/0x1d0
> 
> Fix this by clearing ddsp_dsq_id and ddsp_enq_flags in dispatch_dequeue()
> when dsq is NULL, ensuring clean state for subsequent wakeups.

I've tried to fix this a while ago (same as this, right?
https://github.com/sched-ext/scx/issues/2758), I remember that I applied
exactly the same patch, but I was still able to trigger the warning.

IIRC there's also a race in ttwu_queue_wakelist tasks and
sched_setscheduler() that can hit the stale ddsp_dsq_id (maybe other
cases).

Long story short, the only thing that was working reliably for me was to
clear ddsp_dsq_id and ddsp_enq_flags in select_task_rq_scx(), but I thought
it was a bit too overkill and then I've never finished to investigate the
real issue...

In conclusion, I think this is fixing some of these warnings that we see
and it's probably good to apply it, but it's not fixing all of them.

Anyway, I'll do some tests with this patch and report back!

Thanks,
-Andrea

> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>
> ---
>  kernel/sched/ext.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b563b8c3fd24..fdfef3fd8814 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1143,20 +1143,28 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  
>  		/*
>  		 * When dispatching directly from the BPF scheduler to a local
>  		 * DSQ, the task isn't associated with any DSQ but
>  		 * @p->scx.holding_cpu may be set under the protection of
>  		 * %SCX_OPSS_DISPATCHING.
>  		 */
>  		if (p->scx.holding_cpu >= 0)
>  			p->scx.holding_cpu = -1;
>  
> +		/*
> +		 * Clear direct dispatch state. The task may have been
> +		 * direct-dispatched from ops.select_cpu() or ops.enqueue()
> +		 * but dequeued before the dispatch completed.
> +		 */
> +		p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
> +		p->scx.ddsp_enq_flags = 0;
> +
>  		return;
>  	}
>  
>  	if (!is_local)
>  		raw_spin_lock(&dsq->lock);
>  
>  	/*
>  	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_* can't
>  	 * change underneath us.
>  	*/
> -- 
> 2.47.3
> 
