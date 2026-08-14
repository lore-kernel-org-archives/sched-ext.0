Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BF39CD05
	for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733562; cv=fail; b=oLHrpDiCC2JpxBXV0CIx/B2QQCOkacMgf8T0hz1VrEzXs7bSW+9+vHzQvtQVzdEtFYHueH5Oap8axxT9fQG+FA1qUniXiSQy/4G4QWU6YKVHO/o8gGg91Z8fC8ylAuTjuO2pQe3pMRwD7Kc16AWw6dDuIBknA9deqEC1yMn72PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733562; c=relaxed/simple;
	bh=9bHYRYWltJgDm8m884s6409pXXmwKsmRV3VJEIb1MDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wvk9zzzsRri46lzvATKbLdgNvYZyzgH0fzJqqvdoLgpEujzEZUCzfejCwod3iPFStYz6iWABDtN5r0S2LCOM7bNTsn3OBavTU7Hj81iobuCz7Qp2lXwP55P5db9eN1YFSxtlRPgEFWvqh7iy25EmJiRWEXem/Fq8/V78EEsqR4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j3QKARje; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j3QKARje"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyEcpBrOKoSjlJueatLbaMrWZR9ueOe+5G/rJifrTkySdnmDomSs8unBpbYooxeed3yAf876WR76JRXF949nF9GHm+HUKKKiPw/It0f+t9TJ+J8ZPzKhcHUTNV6lWHl28YwqXsl/LdHt9/h//OiWmDm+IB2HyNtkOPLQnUcQHtrSaa4eFrWxdDTMyWbyYlyTorwvLcHO9/rdIuKjQeKdDw4TqahilZYkLqDAH9hx8a2IcG4j5aCd5b+1yNFEsKOyV4Z6zafuLmb/PV6Sh59DSWlMWboqa9QzX9oDiMpXqL/Xk7mUGG6Cga5zGa35HcY46vtgs8+vBGcfRgBK2au5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhkvrHarpWsfe1rywVthrSrul2m9UZ4pMAokz4EyCLM=;
 b=xIq8yNyG8zKBpmqA0QNliU2TmicB8CnnLwW0Uk/iF3ipvdoIgCmb2RNwf5dKcpICCUX9Z8DlYznQkpbuJ0fM6qDgUAwocD7aPWaf5MEc6KFFiPoaQvCj3g6he94uUfSj6Au7ILwmsPAH51MjumnYA1uTJDJST01pGo8G7w4wUM1/1y94DLP/53pL9FB/2vuu9tHS231uvgmGljGgUPzCdfEVEDn3YcjiWBOe/q/u9IaNVHhpde2H+afMynm/PaNOlhSZyjhuC6NQm7CL7bvfDvzKWaLkznD1AgrszBT09lzb6Nitibs6ZwIWujvoMLsFSTo3fYRct0ngQTw4qvIyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhkvrHarpWsfe1rywVthrSrul2m9UZ4pMAokz4EyCLM=;
 b=j3QKARjeMDTQYCRvfDa1wNONaWFPjaOOJ0hoI1Rr3dHnv4tSsRCitWhW5VYp8QgYtHK1VMJrUDcepaH8XENl/4V8IBLhxwrRgi/BZ9hzmCgLGK/Ts/aHHEdzuS6FWwhygYvrrbiYZ9mRpXc3sdibeEfV1fgVGgr32+1sfWXG0hTofO+3AOdlyQQu7WwraNaD4k1I77qs0YmDPSM/7MCajiZxpyV1B0mWShTMVCrIsHaJnuoDLWPvgbFRhzjimhZMC9WE2En0OS5ZUDYFtOk5ZbqwCydzsKagv23/Fne2B9oRq1kPpjyAI9jSYulQep9NIo3tdUTHc6maC3WaV3N46w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 18:52:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 18:52:34 +0000
Date: Fri, 14 Aug 2026 20:52:21 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Set up
 ops.sub_ecaps_updated() dispatch context on the executing CPU
Message-ID: <an9j5Zq7zgt2Wlk5@gpd4>
References: <874500f5212b5d192092950ea8d284b8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874500f5212b5d192092950ea8d284b8@kernel.org>
X-ClientProxiedBy: MI1PEPF000008D7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c56b1ff-b51b-42a5-e718-08defa353389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|5023799004|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uVWR0+sb0j73mRFbSfqfHNRoXv5Cl0QBn+sxmjr+iZxOYVquWNBLqveRkNVy6ViH36lPysF54jfX19Dt94V+ptVe0LKRhbRGH4XtsfUA0JpE4sFOHxvYWEeepq3UwJRWsqHp9/1oXlc8lQ1JO3cwuBXk1Yys8oTtyj79Zg79YG62QEsJ1vjNx0kCa+VRCchZ2IGdkvYxiZKQdKoTpR6xngonAs7pFj8nPkiT30bELAuFaHZEs0i1EBnkueW3hzbDHE5gMUA8AhhFcrYqffLwbiA3ctSXJKEvha0BBM4Xd48Ya/xRGHxczcg6En0OaJ3P8oOV6LnIfxeS2UWMj0QKLJcPMgVEbgBpEocUk4uyQQRuHzPLGtPCDR6uEy5/6CUa9nl5ZkGxMF/fYoWaM8iAw8iCNSYniVRFH9veW2OpxaCgxQXQ5Bj1kML1iSJSe3FjeV/4SvjU3XZiuPgtIpC5gnhcxPPCMEHLuCjAKyEa7vT7CuCCR+Glb/qYJFyRhFiO+ShAz2YZK1zz5ybQYompEkR6QYITvkKJO8CsbN89azAOi5p7L8O+rfse9x5VhOFdZRylX5mkzd0u7n3HOyeTDj2GEL7oXWwtNoEldOBue93ZTY8V7JsTn8s9+vCftOtiJ+HLw8IuXLlnYhROkCN5ZDxdWfQscZKR7E2GbBun2qs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXaFeeEiKDCzAN8h5O5EjQUMn6bk4H/Wx3TWzJ7OvCgdY2vllHZFOs5jWcnu?=
 =?us-ascii?Q?X7CHVhAKMx0eGIqnVZM5WFUXs8bNMxzwwQVi2ARufPM8Ii7AJf6f5WYFoJI/?=
 =?us-ascii?Q?EAIc4rpPKHeRPOgXoVhsbrR0NUk9X6mGxjuBMt1DmxHgKbB7Vmj1dHFsB8zl?=
 =?us-ascii?Q?T/S7h/sWDuWFGVztDha+JFde7gjSmh882u6Vsz7A5mtNqJMRylVD0MR9OCue?=
 =?us-ascii?Q?NeSK1grPJD/NEKzKTNBQtPG0dBX16rG+unUKXla54RmvzX9Y7U1ldao1v1Oa?=
 =?us-ascii?Q?deRb0au7Iz/04z/VThnzmyJTbJHgeXuAmvqzw0J/+SrBR8O8AHyTYxOfQMBA?=
 =?us-ascii?Q?12C11hBoMgHqReWJb6uvMZ7xUFdGauuREx/OSRLCDlbla8XnCTHU7FDJcYlx?=
 =?us-ascii?Q?kDfcULztQjdVeM0jMFAY7wtDOQLKhNWUsqco8pCQwk7AUQQk/0b6LLw/MqRK?=
 =?us-ascii?Q?mNP603b1U2xLny6YbDSLtTysl4TFQ+qteeNIr2JdlhQKKCtMpy1HEd3AQZo0?=
 =?us-ascii?Q?Jft8RiwDW+6FKRq5UPNlAC3h4nmJc9d1wIyWhVk5uZYxZUmahEX6i4thCs27?=
 =?us-ascii?Q?w1p5P8u2l6/SC6T/kjeSZlvb2bg+LlDsk+UZJyInr4Nb8gzP+shfzRZZtRKM?=
 =?us-ascii?Q?VO6qix6MyQdoMGkn+8ikMUAam65Aq7rlPK6nJx5bpixBqtIUpYgbkGxdPyFy?=
 =?us-ascii?Q?NwBUdmgqXPTZq76yYwdTFUvdKM2H8KKtNiJvn6BOoL99BMzKk6+Leozb3uLY?=
 =?us-ascii?Q?dhG1AtcW+7S7v41AMMqbQvCwgYUAq9cEd1QWz5u56GgjzyJ7/3Cb8xEPctaB?=
 =?us-ascii?Q?JhGWUqMCQFThh94y841zLSZaWZLoKeeEFZ9hS+LaEHIy8W6PWDuctZE1tRum?=
 =?us-ascii?Q?G/QOA95TaKQ9PoW+BLxFxfFyWhA+/7IjcRCL6sxpdvnFVGoSnTqxdxGsTb98?=
 =?us-ascii?Q?VosXVxmqFinIYbzqLHBv9kqmIneeo1bX0B62wc00pKkFqDY8MlY2vaz90CM1?=
 =?us-ascii?Q?ml32TwMymt2E/Ku5WXpaFincF0gcVk2VRm9TPtEiyKZ33dkeN2BImdkawiTH?=
 =?us-ascii?Q?wT0tif+UnfbKw5lcv2/lh9HHxqHOg3oBPp2gwXse7gqmIUkjKQsWWuVmno9s?=
 =?us-ascii?Q?H/AZmKzchOHrsJQwzNuXS8f4wp9qsHrqISC7JLVKPi9IbuGkF25a7BQMt/po?=
 =?us-ascii?Q?rGKlIYSJ+If+/4PnSwln1pNPTERLlUCJW6VQHQ7k/QpKWckKisANc72MMtx6?=
 =?us-ascii?Q?havqjQr/rGGViaZJOHYq7WW/BB7CWspL3PEEJP57WWxeNVlRARogiSA5mQCN?=
 =?us-ascii?Q?/9ozt4SYYl0JykHc8qa+pK4na2S2eSw9e5iT1rEemYBake6mQtoefMCaV7/g?=
 =?us-ascii?Q?cabLV0L9ps8IA3iKHgtXcQ9WOJLSvxXLaeGC+r0yjY4J76vltDwC3v6Xdk74?=
 =?us-ascii?Q?rtT+yIh9/xabglE0ScoYx8btfvLZY1ly7sU6my7Z9/RWvN3Rbl5mMNjLYsHu?=
 =?us-ascii?Q?p4QcTBrNmMK3nwFTeA6g4Mqon/W1BTxGbdoTWkpWhtVtPj6r2Ad+4y2ljzY0?=
 =?us-ascii?Q?DvCb3kWIfVGSN8pufh+9+dTXran72uzAGMl4tVug/Pdk+/LLEZ328xHk8zPo?=
 =?us-ascii?Q?Kfu9hF/eiXgij3Orm2ZMFs5XuebZjo+Xy3HAcYFyIn+boyyFdURTchnyGSCb?=
 =?us-ascii?Q?bdJr35tghdfEfqGr5rYQ2ImnXD5s6ewmwvD34CDQcOG6f8fbc6y6/WiZkd//?=
 =?us-ascii?Q?noyIliL71w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c56b1ff-b51b-42a5-e718-08defa353389
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 18:52:34.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImImvRQ9Kk8PG+RNiXrJ15svti4SHXi2onFHN/4/66lzA17sAtccAU2B5uAoCl2lcZPK6fyYc+qFKNpFzxQo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Hi Tejun,

On Fri, Aug 14, 2026 at 07:46:46AM -1000, Tejun Heo wrote:
> scx_process_sync_ecaps() sets up the dispatch context for
> ops.sub_ecaps_updated() in the target cpu's pcpu context recovered from the
> llist node. However, the context is per executing cpu: the dispatch kfuncs
> resolve it with this_cpu_ptr() and the dispatch buffer lives in it. What the
> dispatches target is determined by the rq recorded in the context, not by
> which cpu's context it is. Under core scheduling the pick runs balance_one()
> for sibling rqs, so a sync processed for a sibling invokes the op with the
> executing cpu's context not set up and its dispatch kfuncs misoperate on a
> NULL or stale rq.
> 
> Set up the executing cpu's dsp_ctx instead, matching scx_dispatch_sched().
> The recorded rq keeps the dispatches targeting the synced cpu.
> 
> Fixes: b81a6c018cde ("sched_ext: Add sub_ecaps_updated() effective-cap change notifier")
> Reported-by: David Carlier <devnexen@gmail.com>
> Link: https://lore.kernel.org/all/20260813045931.8691-1-devnexen@gmail.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Everything looks correct to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/sub.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1017,11 +1017,15 @@ void scx_process_sync_ecaps(struct rq *r
>  		 * invocation is equivalent to the dispatch path and may drop
>  		 * and re-acquire the rq lock temporarily while the rest of
>  		 * @batch is held privately, see scx_discard_ecaps_to_sync().
> +		 * The dispatch kfuncs resolve their context on the executing
> +		 * cpu, which under core scheduling can differ from @rq's cpu,
> +		 * so the context is set up there. The rq recorded in it keeps
> +		 * the dispatches targeting @rq.
>  		 */
>  		if (ecaps != pcpu->reported_ecaps &&
>  		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
>  		    !scx_bypassing(pcpu->sch, cpu)) {
> -			struct scx_dsp_ctx *dspc = &pcpu->dsp_ctx;
> +			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
>  
>  			dspc->rq = rq;
>  			/* stash @prev so nested dispatches can access it */
> 
> -- 
> 2.55.0
