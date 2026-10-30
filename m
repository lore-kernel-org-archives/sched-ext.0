Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793379660;
	b=YRUXAxgY5L6NMGHdCswoBAx4crMVn5v76VDmvinAtSUWyPbC6dSsnWhVkfDRvzaZjZAf
	 HfTmqgE6KLF77qm9FFVVsPHxJzQxYeANY5MEuiszfL/RzzUwztOg6wOnGYR5Po9pb/7Hm
	 dqLZchPaWMiPwf4Np4R40PNT6mBW4N7WEgKvdzst8Dtw0M1Pk7U5FXTuPCgz51FOnRSX4
	 ODAtVonwQUOYncdc/o79i72nS54E0tWuf0D6696bW5jTZAU6j0od46jZVhzlhg2cLU1J5
	 O8e7IJ5prYvjnRsbySraEqiI8VkEZotbtku5Up7DFWxTeyMrZWckRHp5iRSfl99Jvog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379660;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Tqg22EJf2Z2WlwxRpMN0QmDWKkNLxymQxbRF2/7ELgk=;
	b=Xow+YH0qyeD3AFPnVvmVB4O8zZt1IemDwbujg1pKmFuJz1nlFjhuUe2ZHL6vgOcwK0do
	 mNDWrpry+vabExEp4BUG/kWJ2cMSj8byzL9kcjx+nsfzdELmfNo0QvmiIasoc4eHhIfDZ
	 lt3NQjMEokHO8kP8KXfaC5DkrEA7YnffpsvgcomCAeGFW/t3W0VmIpcqrGqgoe0EACuVU
	 Xlkz1ZjzLC2gOQjSFHzXwh+i9sL45H1TX41SS2542BFjmSv18zMzl+GsTRKak3b3nRUS9
	 dTyC+5T/uI955VzqALCERwp85MZFLglrslQTimLKEjL4hwV1bM2uFE09tOLPOPQv7Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a8EXXbBN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6604606A31A
	for <sched-ext@lists.linux.dev>; Fri, 30 Oct 2026 17:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6604606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a8EXXbBN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR8xtN5+ZAQ/exUwxL3wIh3EbbiJUY96zRWVP/98d7n7Sow+EGKMBBVQDFlwzKfKgW1wHM8ibnrfrqWmYLtLlCcnMWd7W/V7WE6cEoKw8I3UQlWdbmEe7fWQScowd4qhnTGflIaMc7xdwCv5+ORJYlp0i3QENiv5bo+avD/E+zLGnsSIswvjYnuXNuEmndXKxDnht1dNa14PY1Na1nVxS5NjA8ypE3i1CDERzV9XqSX9I2M/TsFxTmsQjpXH4L59nlZosrUSqLnzpUmQ2LJqiQDwv/mHvvLm6RSTVybDLlZtfKdVbj1rTwxeJ5bJte2GSBp9EOAMpYCyDZbUAul/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqg22EJf2Z2WlwxRpMN0QmDWKkNLxymQxbRF2/7ELgk=;
 b=j/4Kz/dDY3t4RuPfE0asnFCaf/NQuTd3Dhv7D50npxSObXJ+SV3bY+Q6Lz2ezoujHfrbthpivqBoUXrjpPANV2u8AXoqIhxXSoF6WUH473Is75/02Y/r+E/esYl7hTdW/bwmX5Shx4KaLus1JYKGWlFxJcik9W0bkJKEh6uCAp4yvvsi7m8pQ5ixYpUvuwHEEA/amHvKhcNLKe6AKJKHufCbs1ZIfjSVtKoq7Tnk5o16EvLUgTpl1W/QWzUMHbNyzW/mEpGZWhno91np/MfIbOYcG+bFz7nBtnDLCRL7tU20YRTzNWDxcqX0MPvq4aRhBjtX1fuPtSK78g0+4yqojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqg22EJf2Z2WlwxRpMN0QmDWKkNLxymQxbRF2/7ELgk=;
 b=a8EXXbBN/xTM/W3KQdTztae7UyfwPdHY7ki/ji8IHVROJ1H7W4iJwbzVGQw8vszgfgE7yn+weTnr97ntPCwGDOsJAVaZRP0J9PIXJbvM6rr6ZKllR2clUatboYRtL0GmJaNi1BaojPg6qZxoo1LgxX+mJTroOqxTG724oXu6R9QtUiVyd0ZbRhWGDPMZyz3MQOqGIdQTNwsKwIpMu8rROows4dt+3FjT1wOo0vXMn1iLPVvKI5psS19LWKQULSgqsfZt1UO86BQ85FtabW3D6IP3t/TyiP1X7f5syfu1pRFD2hYXEZGsIsV5wrH516nZKjqnoXWwSXgjn+sMI2wpKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:00:55 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:00:55 +0000
Date: Fri, 30 Oct 2026 18:00:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when a
 wakeup resets the donor during dispatch
Message-ID: <auTNPtiaPyO9R5NG@gpd4>
References: <20261030142338.3453484-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030142338.3453484-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a8daf2-55a0-494f-1345-08df36a75c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|5023799004|11063799006|261022075727099003|261021121427099003|261028144727099003|261026121527099003|261022105027099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	CL0VOiTPlcQXty0qq8uCK39U6JKIszRoVyUkWrlWu4driJ4Y75DdYHLcdVNwhS67IyXqln4kl8kLjmv9lTU5NL2ohShGcpivjOgcg1eqm6r+ZD5gFEgj4jYd7BlVSL9jRcfflotv7acmoJQpmoaZz4G4z1zltaNHwLWLJJWCdqVaUsQ+p+NmxcOR7lI5tjcCk8ElxvPb1/h91XE1w6kXMDwVfn17RQNn+RaS601ZHr3x6g/NKLMhvfSJa4bzu93VVvd7l2bWFSo+NtCmPnseOH7uEJM308QTNx9h3dvdEz+DIyEQuhGTGhEm9htjTefwd2gype6hf5JvRMHBQsoSNttbWwyxH2U71Z9Xph5yRuFNz0KHh3Tg0GCUguIpd9wfxTFnqZjk0Y5ZtxyOCT9j5Zb7lJHUl8xZuvmZMN2bqdvmo+xfn7JCcOJX2VdQZwFrkTzT2PSCTGngsqkuj/NjyQpmB27JXU4fB9YgDONbY0xypztsbafYWZNMhGWIKrtfsV4WBK1i3xSzL+TTWxMZ/tIDd8TgjiObTfiZV3CPzPCNHEILTtyDoZ6/UnB8PQ1Tgw1VBdAHDlxEt2lnv9fxr5ZbHCQcgg53jxNyNpEKHj10phIeXw1Vhz0RDVEZ2jemFpsWIz48WPp51bEKtRQ1MPOqu3ifV1Nni54YQAuqRoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(261022075727099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qqwjk4nAGDPHni4WreZb6wkGhoK3Kuf13j9lsTFe5bXhGb4yaQcZ4MHAAh7?=
 =?us-ascii?Q?538johKQVU+dyvhGecYdepZdPYUxaRJhBq7U67rrVGoBLC6S4lxdg9T3+bQ7?=
 =?us-ascii?Q?luIjXNXO+PkhXU+p+5EWbgHJlH7j8UwPsE9HA/UsskUfIRyM788cLG5P0iQ7?=
 =?us-ascii?Q?U0hveI2wG0uViNs8QEsVlc8NewqdGftZdYnz1Qk3VU9zngIfRhfJ52mn8/nG?=
 =?us-ascii?Q?Ou0UokOLSqwRGYWvQVogJ6xsoGQvrF2CQ1cUqh/YayBGidiajecfJW3YLHXn?=
 =?us-ascii?Q?f9Nga1uoJOUopUtvCQQi4DbQGEM8F3BJC6J6VEjV9dtums/GM6GGK/mNrWob?=
 =?us-ascii?Q?3GtjJ8kli8dGC6i0ZkqN3Fxvzlou0/HdJRzdt1sFfpRrx3YjkbwCPzXoQJbF?=
 =?us-ascii?Q?dtnK3o85DFBqcqtmCIbYGv6e3g89gcQ/EAMXU60YM+ZgqOSFE/bdsWCycCoN?=
 =?us-ascii?Q?err5LmXEFvPtctOoqCWzRQp8n8goSD6O1mEyhcTn6WXIKGkV5gSPGR3MJsnv?=
 =?us-ascii?Q?gFIyAJqrgCWQJSw8c9d1Fme8WMQ+NXWdA0LTjLJ8+2uxura75E7WA9OOdgj4?=
 =?us-ascii?Q?xObp6VZKzuvd802N3WINVNsKDxmR9xPookc7AkA79wGJs8Ss3LdSoy+9TjNN?=
 =?us-ascii?Q?4Ap/+DQMbIz3jIHBPs5HOaX3s5Mns5SvmSX8/LUMSweT32sJSzXwwzOrMEW0?=
 =?us-ascii?Q?uYcd2XP73r9xTHOtZAwMuBuNxsXvwJG4G/uV4cKnmeMc6MNOPpEglW87SxMp?=
 =?us-ascii?Q?QPc+i1iB3FcDDxt5z3PMQAtKebpyY0MpAAsird3+1KRneGR0F4Y7+WSVTbhb?=
 =?us-ascii?Q?xhQ/9+lII7vsq8Zp8vz+4yjJrcGC2QFQjYFu67Q10gldKj7F6UdKPabMticB?=
 =?us-ascii?Q?2husaJBtqwPoIIgQkKTY3W6/8uPJSiyBQ2NbCj7JzNoQfR9noK/P9+bqKSW3?=
 =?us-ascii?Q?Pmv6pXkCuHhhRBtrun35nZwb86uhR/a9F4B8LpMbQGq64q1kCxothTE4gujU?=
 =?us-ascii?Q?b1k8D0X9gdzzlDAyPNRXmDKHOLmTaKUmq0W+UXYfJR1t68ZphXzNhy77Gy6z?=
 =?us-ascii?Q?d6nHVH/+6A+C2vUmJEQKvHMnrrc3uGEiyJNzI3ownC6aBLeTXq6kVZlq/4l/?=
 =?us-ascii?Q?a2yWLDs+cLTfw5g3Q0TC+ga7ZL0EUpN+b13nqz+c1DgF3YPFKy6JRE1jtTO1?=
 =?us-ascii?Q?YjsXTalrh/erBpiOi8XNXy8EO9IsW4eQ4pK5nd3IzqKLbboefJ92PvS0ej5d?=
 =?us-ascii?Q?OXvZyQFH3xyalWhh0p+WAGAOIp8lDH+DBgUjwvgaO7Ugs/BLYoJdD2FTALWk?=
 =?us-ascii?Q?AJGv6ncOjwz+zXPss3USCqQKsV90Zwou3sOWA96G0V2HVoGVU9rDudjXub5+?=
 =?us-ascii?Q?TnHAtRYNloErWZKhHp4BcM9+KQmEEQgnt+xmT4vOxBm8uIyQkaaAn+C34kue?=
 =?us-ascii?Q?LB0r6wh1mff9J+UF8JUkSGqPmjqIWjzA4IOdA+Y6MwotVp8VBy9g8bYzRTAE?=
 =?us-ascii?Q?DmgB3SsdepPk2wxrgtMqHq+CVw4i6DTsvmkps1vekxoqgyxmorR3miSMQ5jh?=
 =?us-ascii?Q?U6qa1juFl1zcwy+UbxsvSvfxfvCU92HDMUMr7mcfRV+zlwslrItwsobrNjgU?=
 =?us-ascii?Q?La85NUMKXYkanTLhpTz3/HPryK8MHOmLNozJr7ZMl37EoiNY9dN3UXXSXdPw?=
 =?us-ascii?Q?w2nV4KIeybweVzj8NKz/HeDUbcIKCkDCEb2DD80sUPnF6/JD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8daf2-55a0-494f-1345-08df36a75c9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:00:55.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arZkgZJsLXofO2Ixr4bZ/d0q27bzQVgfmSU9XV3NCvJn5qtGiSFA/Ey7l6puYhv5yCtaI0qokZuEmvl11e2Jkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

Hi Tejun,

On Fri, Oct 30, 2026 at 04:23:38AM -1000, Tejun Heo wrote:
> With proxy execution, do_pick_task_scx() passes rq->donor to dispatch_one()
> as @prev. Unlike rq->curr, the donor can be moved to another CPU by a wakeup
> while dispatch_one() has the rq lock released:
> 
> 1. dispatch_one() releases the rq lock, e.g. to move a task from another
>    CPU.
> 2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
>    proxy_needs_return() dequeues it and resets the donor to rq->curr, and
>    the wakeup enqueues it, possibly on another CPU.
> 3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
> 4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
>    on another rq.
> 
> The other verdicts are stale too. If the dispatch finds nothing before the
> wakeup enqueues @prev, SCX_DSP_NONE picks idle, and put_prev_task_scx()
> parks rq->curr on the local DSQ with nothing to reschedule the CPU, or trips
> its SCX_OPS_ENQ_LAST warning. SCX_DSP_LOCAL preempts rq->curr even when the
> dispatch would have kept it.
> 
> rq_modified_above() catches the reset only when rq->curr is in a class above
> ext, and the dl_server pick skips the check.
> 
> The verdict, whatever it is, describes the old donor. Restart the pick when
> @prev is no longer the donor, as dispatch_core_pick() already does whenever
> the dispatch released the rq lock. The retry runs with rq->curr as the
> donor, and proxy_needs_return() returns early for the current task, so the
> donor can't change again.
> 
> 7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
> closed the same window in prev_balance() by reading rq->donor instead of
> taking @prev. That doesn't work here, as the dispatch never evaluated
> rq->curr, which may not even be a sched_ext task.
> 
> Verified with a synthetic reproducer.
> 
> Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 15123f181b5b..3119a1938c6e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3936,6 +3936,16 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
>  	verdict = dispatch_one(rq, prev);
>  	rq_repin_lock(rq, rf);
>  
> +	/*
> +	 * With proxy execution, @prev is the donor and need not be the running
> +	 * task. A wakeup while dispatch_one() has the rq lock released can
> +	 * reset the donor and move @prev to another CPU. The verdict was
> +	 * computed for @prev and doesn't apply once the donor changed. Restart
> +	 * the pick.
> +	 */
> +	if (unlikely(prev != rq->donor))
> +		return SCX_DSP_RETRY;
> +

I think Sashiko's first point is that this check comes too late to
protect accesses inside dispatch_one(). If the donor changes while
scx_process_sync_ecaps() drops the rq lock, the subsequent
prev->sched_class test checks the old donor, but update_curr_scx(rq)
operates on the new rq->donor, which might not be an EXT task.

Maybe we can detect the donor change before those accesses too?

And the second finding also looks valid, __pick_task_dl() sets
rq->dl_server even when the server pick returns RETRY_TASK, but
__pick_next_task() skips clearing it on restart. If the next pass picks
a non-server task, it inherits the stale server association.

Should we clear rq->dl_server on restart? (I haven't reproduced or
tested this).

Thanks,
-Andrea

>  	return verdict;
>  }
>  
> -- 
> 2.56.0
> 
