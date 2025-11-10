Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57C2E8B95
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757863; cv=fail; b=LEnj0apEfy29Vzetb7tb+PKG1ig2smPNHI/spqZkazAZGLrGjn5az8oBP+D3aOjCi8t/JcM3ISxWfJ7dij6+g0gwADWLm+swqgdC+8J3kv+qKEriRbK7EfX+jruDqhiuV4tADhMcHVwJcYpLYplDn7IC3XhPQjp01Q/gASRHpMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757863; c=relaxed/simple;
	bh=w+7wwbVTvf8HjGj91B27dWbutXlwL8Rp70bZ7eERA2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GbgYKiU9VrtCZ2gtiRv+8ZCNUrJN1V0W5R6C2VtdjGZWJuS9kmvwgiLfzueYBTxfFmsgyGqdWHPDNeTe+rSUcxbKojiG0qisKkN2DMTbTd/kGoA9KF1oIpkC0p6DdLOnA5LdFRtdgGUtJ+YDV6f4G+zBhOPcKnUUqlKexbptUe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pw8UCTec; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pw8UCTec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6h3+nWIeajUT2tf9Z+OqWBz/NHqiT/Jc0r5ESozpXh7tUTjgSZGAcY3/BMtEbaRcRzUyIbJckKX9ByBMFMgYxAGvKIQqw9DYVHPFBe5QhzvFn5QJeXbIPZOrds+hA0YoIe9/TwsNLabGtwCyQevj51kWrbitCT9SlchV+e2+1/Wgz9OP7HczABH8NoB7GQqJXtKlLw32o4tOcqpqXM4POQSiYyFydHMlzPcoGB1gCewLcf5KuXXmY2BHds6iiG0gkCDTAMwmtkGI3EQDfJ43nazMOjdio1QiGyAgU5rF2YgTs9fbcmTbA8cV6FbC7qTu6W15YKhECKTn++Xb425zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcK7kCRwnHAhjmpUKMMcv9v/U7Zn7Zuxw+n+cRxLlYI=;
 b=dQUXu2e284qgeHarAJ9GaWTQ4WzYOAiuf9Opbn3kdiATlzNtog4b1TQedqrlkglmDpvIh7egTtVdA9YXUwfp3jIKoAK1tDoePXSZBkz9BaYBdqdeeNfe5laD1ryWG/HyebKxxB81G+HNsdM9IPMoDl4tvGzLmQVWmytnpExxzAhPRwVWyFoUwmBF2s2RTWigxMV5avfE7u/lRefjOMh8y7R0eP7CvXEotFpJ28ykuDAVQchj7osKLBJe2BMYcX2maJZ0qeNttnQ8/3dNs1dBMUpe/tMDH9e+asFPOtFFjfu7LypwhHAOKtQv3QqW+2zEGAKO6kSIHMlulvHzA+vDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcK7kCRwnHAhjmpUKMMcv9v/U7Zn7Zuxw+n+cRxLlYI=;
 b=pw8UCTecWTmj45jSsT6Czls7r4d646KNqoA+56+U1iDxTuK+TCnGfQi7aavCWCjMXiXKTWLugOhMrxA3SE8S6CdR00sBIh/PkuXITq4vGrUMKAwY0OJvL1XONpIqGk97e4HofoDzR9HU7bnToUZ5oSz76Q7q6jkTuSbWe4G5n379EE/Xr6yf0ijN9dlRGU0H10cux/tEBK9a4sKSfiAeueTiVGip7v21mYfeANQUL7qsqIZDtWjSwvl+5ZDzEuQhLEZEe0D3VPx4Q5JXHCwFKeWBpsvvyrTXfJsLl3rUXjxE6i9ikTfDCELxneZyRk8vQldY27L6ngAzrjnz1acv3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 06:57:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:57:36 +0000
Date: Mon, 10 Nov 2025 07:57:18 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Patrick Lu <patlu@meta.com>
Subject: Re: [PATCH 01/13] sched_ext: Don't set ddsp_dsq_id during select_cpu
 in bypass mode
Message-ID: <aRGMzjXMkOsU-2le@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 382abcb0-b949-4134-0afe-08de20266e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t9F3AIJOCfYhZPs7iIe2o9GetklzUXHeYQGLWk1O3mwJ2Q0+Dnjuuz9n3GNS?=
 =?us-ascii?Q?crc87ScCbxbs4gnaH8c9FA7pSxF1ludXZsHKUSXQoF3bIGkjA8mNCklRz+xx?=
 =?us-ascii?Q?x8n0V56VKML9a2f7ljRDzGVlI6xo09n9kUEEIrr2xl2Jnn/bUNPDtbuZIF26?=
 =?us-ascii?Q?rzmU7bKR3iSrrDX98dsiO8nfzy4dWjG5r2zYKhC/WCnNUDH+xD1xRy4x7U2Z?=
 =?us-ascii?Q?qrO/gM2nKKnV5U/vg7czjTvBZ1hfetVBz0yGDWuzvJM/KIBnKNcIjWauy83S?=
 =?us-ascii?Q?9bMlWCZIHqEo151HlQrHxEQasBrgCvqYab1rGa5UmximaNvtdgSYJMX+NwCM?=
 =?us-ascii?Q?N72OONLHW13faXD/NQdxva9GSdZ+0VtjVoR3VujGSivUc6cNNgo4ySUg78Rw?=
 =?us-ascii?Q?eBZdfmH/qR2QAOLHWPvmUVdCOU9ktuCBlba7sgOrCcGn62wgQAX+VkP52Cqe?=
 =?us-ascii?Q?kDHG35sq1rUuDASJbXJyno8zkInKgpAHmMETjIhF7Y3cMps9lJ/xP6lkWpu/?=
 =?us-ascii?Q?i1TKbjB2ZwBHY0YNVlzrPfRkT7KbPgW2i7WYJLnOFTKKSus8lOnrCzXvQIuT?=
 =?us-ascii?Q?PY/pRmLYaLg85fcU2ZlU6DnpiAm/kR2QiiPbPNTAgVTwCOlIl+MnXPbMN3xH?=
 =?us-ascii?Q?B52cmOpHU+Ws+hK5tUPvimKzt8IkKegg5SFH9F+/ql8+ux9XyXWFgT8e6Iza?=
 =?us-ascii?Q?3vjyZOIY9D53Ukq32Jcp3lp7DQ6ZS0eKFIgURG4ctBqMK2c3asntdEQ92X0/?=
 =?us-ascii?Q?XnZM1RE3Urwqf87ysGbHZL6LMqnv1qOXeSAnH2labYdMDJcZrAaiVv3p5yNy?=
 =?us-ascii?Q?mzUZJ0NkxxJwOczxg302BYuWmmXtb+axZafeAS3hD34CYVbbO1vRMva00JbF?=
 =?us-ascii?Q?RMIu0yAPyXA+rCKLrtZDhVmQYEzx7aoLrpDWHccaFEepsEeFMWniIZwYzYOI?=
 =?us-ascii?Q?pfzxinQQcbj9ZuoOG2SRSiTUlzN6N7bC57k7BvnpCiZzOPccfTmWxytDDBsM?=
 =?us-ascii?Q?g0iGw+t8fWIPZPDoLfr3BeKW/2zHjCKeBDWmaIWPeg1xsrS2UXAkiwFJUyqw?=
 =?us-ascii?Q?SZI7DhNWX0OzaPEJ1plp6MuBaejZqkFv3VHWR1rbAeReWOE1orj4Ys9SM1xJ?=
 =?us-ascii?Q?gYhuOJ3k25hEmqORXwZtMyNzC3rZhp3I22Rsu+vgWaS4RSPeyyY9OYnk77Z9?=
 =?us-ascii?Q?T28tHPjkotnVisUzdePKperI7k1xlu3HDT44nER3CD8ZppsR+T03Ep56BEvB?=
 =?us-ascii?Q?jTaAc8c+Wh9iYidzgKfjtcxYVt95s8ejjR4z4e7JW/hxOvHMoCk+GgN16s+w?=
 =?us-ascii?Q?KJGVX7mQF9dAFMjGkhP8lKb28kqi/Q1w2c3172ITnbWzAYuXPSBR6xfVwWjw?=
 =?us-ascii?Q?XiGzFpTe4HaXbgBFomP529Z0l5nxap794UF2Vg9GVE8/ETacdx8h1xaTnqYb?=
 =?us-ascii?Q?MUlvGy2ZjIUjK5RGxoLBsuQxBvbrtIzsSPFyELHJU1setw9VDXxz+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERPVAtyHJdQBVO24GZgyFCNmDg4jZThwWFjfD3USkKteZPLKRQi4N/0wKF1C?=
 =?us-ascii?Q?rIup+DXZdG14QRhilmpYHLUVPGM/JcautCeKOMoJWTP/az8fvOOkeU2TfAcJ?=
 =?us-ascii?Q?dHItunffgGmlTWTzTTVNZYnXOJmvUzRlOgMCqKZUejZNcHziLkQi79HzzwyD?=
 =?us-ascii?Q?4eNz2nYExY7E5vGdw3lgpNliglnNqyH+eIAYhhor//Up8hRjEsuETjThIF0X?=
 =?us-ascii?Q?eq/OM6NbjyYcgs2WROXGc+BAZI+3BVC0bvyii4LNPe9r9vaSjwEVLcEnhmm2?=
 =?us-ascii?Q?2tWMD7781ccyMlJrHbrjskRNYT5yWoGOI0o7Tf2K4rK5YksjkMwHYucbXQVF?=
 =?us-ascii?Q?7ZskA03Sa8EjTZmRVKJridKEkviyLScmJWqATbZglv85GCYUcELX8F9QuIks?=
 =?us-ascii?Q?6QITHArJQmhSpdYGn7w5RUSRwLJVRtvx7PtU+KhHz+qMrqyvmoUAmpM/c/w4?=
 =?us-ascii?Q?NoMjOhEy6ByBNdBXU3KwO/PXTT+hz6CX7pvypByMYCWpNgd8Jdfn6ZDY2a5g?=
 =?us-ascii?Q?iL5xybhKNccxNW0fFxB9Hw3Cg6zN2HngScYyYLdy0hbqKf9+795NPXT3IuWg?=
 =?us-ascii?Q?uGwK1vQb8PAtaQAI6jUiwGYad/WLaKIOks/qlDIncWVlUQvwR9vOttPqihmg?=
 =?us-ascii?Q?NXu+gT1oB9HmBPLIHk3v/+hLYbuNOFPLWhjl3Ljt9YCbe+5ivsPxHiTVjAyV?=
 =?us-ascii?Q?3aVM+/I6kFYAmlbxtp8yDuRfM/LjYj7WQZ2SxMDzBz8MZ3EVpC5MEGAsHiur?=
 =?us-ascii?Q?FcUmMJP0i6Qg7n0yrxv4/3b38uRQKCGm4PBx4i7M7tnXkEUl7dphnJzcZrc7?=
 =?us-ascii?Q?6LRmg4DZrAUVj0dgqWrGpsDlo1IkbNJJmObfMNqq/5g4Dv+p+OmQNc8LMVXi?=
 =?us-ascii?Q?VZQBE7bhhnWdGzaXaYpluQg0Ymh5AEp8E8pY1FcDzWpFfC0GReR68wLQmE6w?=
 =?us-ascii?Q?mfXgpFFIx2qyu5nezMEdjQc01dKCYQ/RqiR35PpR2zR39pVw+SohQVvhgcrU?=
 =?us-ascii?Q?B6A4IG6ilcRBxbpN4RBouVWy5iqGrn/xRBShJRWu3j6PVldauQp3m3ThJzmB?=
 =?us-ascii?Q?rjeZGZghkIc4xFIQYxbbC3gXpzLBl1IT5A3WQgurxM+hcsgbcRv6VlspdZFx?=
 =?us-ascii?Q?rxhVAvE0YO8H9+J8K7A6x5p3G38Noj+tiNJuPb8ror7Jr8bYRF5zyLu8WxHF?=
 =?us-ascii?Q?PlcNOYjGPmoBeiO1ki/NqZAkf69Xz/5E5eb36rR8BuszzUcSOJjLn+lM0ldH?=
 =?us-ascii?Q?hENwxGB8J+kzDwE299r07KZL+5yMEoo176e/YqLhzpOU1sUHtR05LRDFVjqZ?=
 =?us-ascii?Q?bXdZ48YJ9AnSrDeWXTJHRJy5ndQxbq/0is3cDcJR+TF/2HRcMjfEY8khGdf0?=
 =?us-ascii?Q?t7klp22wNC2Pv1kejGqcYDQRwSybqvWHlOcKe8Ouz2HqEBnMZ82OyePILlNn?=
 =?us-ascii?Q?vlEQyYHuHd4CCaKZqU2PwWWHCVd6IiVh2mUkT2kZzdH/jn1ROFAoTp811ELD?=
 =?us-ascii?Q?LP9R0N+zhh7yQOZVVmL18umRL1GIVGYqOu4J0x+hPBP/dAFJ+aaZpDLxspRG?=
 =?us-ascii?Q?0VVQs5pko+7keQpoUpvplLeKAF1oDwHeF5bSZfVI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382abcb0-b949-4134-0afe-08de20266e32
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:57:36.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8dj+t40EnAU5PFnxPyt032Ib/OEo9TT35l/WZ+Tt1Qr4LmK7DaaVVxIjuhXA7u3NW66uL5SqmbrtQx8ZmBPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:00AM -1000, Tejun Heo wrote:
> In the default CPU selection path used during bypass mode, select_task_rq_scx()
> set p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. However,
> do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the global
> DSQ, leaving ddsp_dsq_id dangling. This triggers WARN_ON_ONCE() in
> mark_direct_dispatch() if the task later gets direct dispatched.

The patch makes sense and I was actually testing something similar to fix
https://github.com/sched-ext/scx/issues/2758.

However, in dispatch_enqueue() we're always clearing p->scx.ddsp_dsq_id
(SCX_DSQ_INVALID), even when we're targeting the global DSQ due to bypass
mode, so in this scenario we shouldn't see a stale ddsp_dsq_id. Am I
missing something?

Thanks,
-Andrea

> 
> Don't use direct dispatch from bypass. Just return the selected CPU, which has
> the effect of waking up the picked idle CPU. Later patches will implement
> per-CPU bypass DSQs to resolve this issue in a more proper way.
> 
> Reported-by: Patrick Lu <patlu@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 652a364e9e4c..cf8d86a2585c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>  		s32 cpu;
>  
>  		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
> -		if (cpu >= 0) {
> -			refill_task_slice_dfl(sch, p);
> -			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
> -		} else {
> +		if (cpu < 0)
>  			cpu = prev_cpu;
> -		}
>  		p->scx.selected_cpu = cpu;
>  
>  		if (rq_bypass)
> -- 
> 2.51.1
> 
