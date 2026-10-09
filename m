Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E645563C
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544656; cv=fail; b=OHLzDDYa7YM1+2dcbq+3AsOZeDlS14ZIVkqT0dVZ+cL1PXJPkxg1UUl3s86ktYwaeis9sqN9wkVDmlkTvzs2cvdszFVIihK7wnB86BHlrXCl6TArTVRlQ7lKAG5wHWDRBAPkMh6YBlDSjxWWtkqutvEazv0oMZcHNkgqLQHpdL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544656; c=relaxed/simple;
	bh=TZNyAtBjuAD9rvSa39NOcFBgl8TOjqZ+Mbyqn5BFT1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mxIIp5NMCXkp/PD0N8s3Aea39Jl1w12KlnthhBqhvkjGwi0g8zj1bMnT0vfXuPg7X3MhlD8md+oyTSm/MIAVzZhFUWWxRdw1SpL7uGW3wJylABCtoXZcNGhg6BHpTKIwDweBpPSGckIC5JC/FY67vl3CJmw0tkyEBJKbz7Nb9FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPKQonQL; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPKQonQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDhtpNPTJQLxYd52Zqwreh/Mjv4Q9x5oAlCRsevJtTi6yUYSNd/JvbZUePCJ5bpvyeOSVZf1hNBDzHVswXDPV+Mt4D4FKoSxGpvE29xw7jCEGt45fS9bE1/pVR5iUvV3i9wKR0S5g2uTwzmsZDZ/jIViG1iq66Y9JsHm8B8QrjkWt0zlR9xa2YNtuqTenFtBNygVfzwNSiSC55/fHKXo0tt3adiuOlBiSocxj6S27HpPU4PjO37uV8GSbEtBLuxrHuj9gtcXmVxuInW/z+lyfhsXshY9rH3lHVAVNAUFi+p5VVqyfiKWuFdKGNe5FbxgWhEp+AiDSNGNxdJ+vflQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG+zaW++qnxehDbvSDAMqOxyTB5sB4se2UuyPD0zhvI=;
 b=ipwU152tNyte+8VXWbKDx9K3jdswPIlrEtFVJAion6A9DVV/Wo9WRdnEx3bIvR2ErF4bMsKbEOxAceG9OJjsRjNwcSqlZZFkO8Hn1VhZCdOn20gitSRgSuL/uUdXGk/HkukjLfJN5LwhpsA+VtL9HHQ6eTVePZ5bZyLSVJA0V97TQ9A+RvtOKvD7oh2/fIAXKG9UJ01GlWIO2CLR8o76yLgaX+ouv+oP/VItbFCMUvjOLQMf8wAh4AU6SjX9OlZDuDK03uV0XcGqQcxsU2u6UAfqStu0pWvrOeap0Haj1xQ6qBUIpPVUlUcw0hHNA4AwvcNVy+CzGPC9kFJQb90YYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG+zaW++qnxehDbvSDAMqOxyTB5sB4se2UuyPD0zhvI=;
 b=HPKQonQLZlr0NMJSycu/Baxv1wgrC0gCb7KsiCPudvYRMuOVmDNVzjP90OLy7CNTEIzNp681ga2Fr+Iq60cbi1VueBTdcU4zhOej6f5yoo4uCx8ctf3ENg7qpcgev+oYN1Wofuq3ivBkBdplXaC0RyZ00s9bQtK4UdmmXjkX0JA93BpZD2rKhDOMavTizfE5SqCuvtAgC2ZZN1SKbQPj4ua1hbV5c2nbiP1/TKPeZCK8J4g7IeUQsuAyR28F+0Ej260NpUi5rZVheR5Rw1LCVx4/Bn49VHTcxHfV9fRKpEtX4+sk4y4cENyEpVviJq+IqFyfo3nxrHeJenErdza6Og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 11:17:22 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 11:17:22 +0000
Date: Fri, 9 Oct 2026 13:17:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add ops.sub_child_ecaps_updated() to
 report a child's effective cap changes
Message-ID: <asjNO0ggCPcfIP7Y@gpd4>
References: <20261008093228.2015427-1-tj@kernel.org>
 <20261008093228.2015427-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008093228.2015427-2-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44f) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e5cf4d-4a90-4be4-2f7b-08df25f6e3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|5023799004|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CKVk+6p1zBqwkmYIzAOb+EmRBuRpFP5QQIcwn8UwID6CObq2kt6pKmR3KnYU9cV1I4frFVl4URKpNojaq2MA/K/pJwByqSORSYUEmuzdtgdxo9GAY6RXEPlvP3bAb07fAkARJCHTHzjpAHVfsu2nAuwrSVeXBYkkLEDNU/bT6qx48CHKS2UipSCtzj16EscicbUaWTGYFIyyf/r/L2TIP1125geO7vlqJSHirr3w7E52FOg9AGCbxjc85gDyANrrSyiWc5V/MHOacidBMmaBaTvLmYX4GXW5gmwjpL0BUeYuOrmm8SB2LdPs0KwXFVDHErihQxCRYg96rBFPApAP55fAsQjGJJiZyVw8j12aB0HGaP5d/kByUV90hVjfTIohSH5PCJLyYk8SJ5Lmuu53OKTFC6PgXjG6wu7cXrUsXZDGL1WiglsHmsthocysQqu70mz3HOzTqeoygaMQhgxKQj48ZsH4gmXhN5Qpmwq3lNo7LWFNCZOes4/jzheJ7cPcFgp5Y3Pzm1TS4x8zT/+fmFUw+PqAFeSiuTrcgFcP5rH/jiwcMDp1SMX72XRwuRbSYeVAWAj+KX8oHZJCaAetKGl4j0Y4DFmUpHCk5s2igLUSdxWoYS+oDK8M3jumG8pXIdictSCP25WHKwTc4/QShXhPYMIdPMLeDoJ2bbQDAFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aK3YlDePHfVrYats46vMHRk5mXEA7XOTLsni24Q2RGk9RLJebE0DSOy/rkrz?=
 =?us-ascii?Q?K/LumQKEYJkym7ptGML9t3hxbTid4qhzaLSqSfwLqv5ejaNZU0RRXAHPVCyp?=
 =?us-ascii?Q?Fmqhi+Sp5dzuFcO9cOeyAScVWyyx0+4AvFLtNWjLxcYYyHQ7JH38aZZ3OCtx?=
 =?us-ascii?Q?WIX/Y5b8ogSdhK0cuWTkUdcGUFROBwdv1BHWvRlEN7LOilLUQrVaZlSc/u6K?=
 =?us-ascii?Q?jIkMCR4Ds+RqAZb5Gmw1wTAainpYvbgAl52c5oprt2kMBNWXKn8xuulHyBNr?=
 =?us-ascii?Q?ZFjaWZKKJ1tsgkRtA3I3JAEXLyR6f9D9Hu8zZPsyA8NoAVtUf6xluQdLKwzS?=
 =?us-ascii?Q?N7oOn3oS2RTthxW41JNvwtUZy6jDMG74vJrAqUlLBUEcyabxDkf8kWixVoZl?=
 =?us-ascii?Q?JS9yvLHcCCFjZ9pMKGEJeRZNXAzXG2nS86c3MnPvNXr9HalMCjogTMtGOvvn?=
 =?us-ascii?Q?rRukNerNHqB7T7ydZ5ZpUFHY3aqtJgM9T9y+b5o7tdm4ePXuCt8hwHLXlVdQ?=
 =?us-ascii?Q?R4KoimHgRfdTyETi42TInQVGpHox4ASA/MQ2Kydk02BVITDyLXjnuLeobQ3w?=
 =?us-ascii?Q?8Otpv3i5N8STR8mT25FPK7zk32IqSZNbqqa91dfWblDbI+KNVDMY5+UuJATy?=
 =?us-ascii?Q?97waTxlaRFG/zIe/qAc/6hrAJiCeBpveS6YCRbJRrGHSafpBinAcgxDDY9R4?=
 =?us-ascii?Q?jtN3ieKJAaG0XKefx1frAdf1Xebve+0YsEQfF/qTFfjwJzRa3lj8Rd9EVU3v?=
 =?us-ascii?Q?BCRBa9BAecyv6XLNMZaNeD3D5Cvbh87vgADJDstECCRUJZcyI6lthfos2uZn?=
 =?us-ascii?Q?OQwlPZyqug1FfoExDC62mKIdibGiqyF1slpfMAXjb2Nwiwpd1zcTUAZzlQ2X?=
 =?us-ascii?Q?FSHF0hrdXh6SdWiBt62ESHmTgMym5Q59QbaY+oKWysrXwHUUhYq+vol2wK3a?=
 =?us-ascii?Q?AaCXTdPiGxapZFm1oPFwS0xkjJkBA0yVc7PpfblcrqTa3Z/RzU0+ivVnjToU?=
 =?us-ascii?Q?16+3Nh+BFuilRbEkPfD8n+z3WJxocAOaTJuI9jCO3x/wsZViWdhwu6clLsJg?=
 =?us-ascii?Q?v+i+uiPkE7m2anylscNJRj2+C/U+ntDTTmRnWXPNAffaSVhjfNhDHZ3eLddD?=
 =?us-ascii?Q?9uX6TSMjJbWW4+GwY0wrk0gBJ+GXfMx/cOq6G+kvxT4bwLwoiLaK8lc2Fd8P?=
 =?us-ascii?Q?VEEbNfKOWhV2JX8juzPyK1ZYAz0a4/bQFXgp1jYQW6iRLrb353pO8WeYm7FI?=
 =?us-ascii?Q?7g3CLg/P11oBH1mc7h990jYekT+p2UKNcE/6kzPmoHM08zFgGF+HkTahiG29?=
 =?us-ascii?Q?2Lf2VFojsdoK++hiWEWDZjxrev32+0QkAufp+UZsNSPAS+mIqZlh1oAtGM2a?=
 =?us-ascii?Q?8apiw6Q8OA/ni4SQ5L+OvEnT/RezKyyG/mHi7HChjJyI9mGEeQBIoNyyG6wP?=
 =?us-ascii?Q?Aq+KfGh7BCrEjdoJTyD7sqmi8d4853UvYMYxl4t5zzU/1i1oXnqUmXtwAz3e?=
 =?us-ascii?Q?xHsGQuXYs/1jTHIfTceDPJlpbbOLwhiIqZ3fhbXiAntaEivEyB9DV6PMawOY?=
 =?us-ascii?Q?JtusWTlBa/zz5/a+vI9nRPQfVDQax7esem/Ka7Hy/21V5Em2n6Q2rqCysGoq?=
 =?us-ascii?Q?Vphyv70XiZEVNG8wUPWdVsjgj8borpbLPPdHpdEsvkddXIEiTIETIiPg6Eua?=
 =?us-ascii?Q?9IHG8fnRwMoChk7uEZ1AY92VesM+88A2OfvwMrMnpRBwmJ4FQx1ORdZkgBLo?=
 =?us-ascii?Q?Ee624ma7CQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e5cf4d-4a90-4be4-2f7b-08df25f6e3de
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:17:22.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGxUr0bWJ9dmd4LPwPLhgOAstUotPtiWZ6+COMtR6U3lu5pUzUM9hn4jLm9tqcci+4/HUgyA55i9vIx3/WRASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

Hi Tejun,

On Wed, Oct 07, 2026 at 11:32:27PM -1000, Tejun Heo wrote:
> A grant or revoke only records the target caps. They take effect on a cid at
> its next dispatch, and nothing tells the parent when. Without that the
> parent cannot act on a revoke: a child that ran a cid at a low cpuperf
> target leaves the target there when PERF is revoked, as the kernel resets
> targets only at root enable. Nor can the parent tell when it may schedule on
> the cid again.
> 
> Add ops.sub_child_ecaps_updated(), delivered to the direct parent right
> after the child's own ops.sub_ecaps_updated() with the child's cgroup id and
> the same before and after caps, in the same dispatch context. Both
> deliveries are suppressed while the child is bypassing and replayed together
> afterwards. A disabled child reports nothing: ops.sub_detach() is where the
> parent restores what it had delegated.
> 
> A sub is now bypassed before it is linked, so that the grants queued for it
> from ops.sub_attach() are consumed while it is bypassed and replayed to it
> and the parent once it is enabled. Otherwise a sync consumed before the
> sub's ops are registered would reach the parent but never the sub.
> 
> v2: Drop the disable report with its sleep lock and nested-dispatch gate,
> the parent restores from ops.sub_detach() instead.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 51a53467cf98..c7c95661280b 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1121,27 +1121,43 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
>  		lost_all |= lost;
>  
>  		/*
> -		 * Tell the sched its effective caps on this cid changed. The
> -		 * invocation is equivalent to the dispatch path and may drop
> -		 * and re-acquire the rq lock temporarily while the rest of
> -		 * @batch is held privately, see scx_discard_ecaps_to_sync().
> -		 * The dispatch kfuncs resolve their context on the executing
> -		 * cpu, which under core scheduling can differ from @rq's cpu,
> -		 * so the context is set up there. The rq recorded in it keeps
> -		 * the dispatches targeting @rq.
> +		 * Tell the sched and its parent that the sched's effective caps
> +		 * on this cid changed. The invocations are equivalent to the
> +		 * dispatch path and may drop and re-acquire the rq lock
> +		 * temporarily while the rest of @batch is held privately, see
> +		 * scx_discard_ecaps_to_sync(). The dispatch kfuncs resolve
> +		 * their context on the executing cpu, which under core
> +		 * scheduling can differ from @rq's cpu, so the context is set
> +		 * up there. The rq recorded in it keeps the dispatches
> +		 * targeting @rq.
> +		 *
> +		 * Bypass propagates down the hierarchy, so a sched that isn't
> +		 * bypassing has no bypassing parent. The child's bypass state
> +		 * gates both deliveries. Both report the same before value, so
> +		 * one reported_ecaps covers them.
>  		 */
> -		if (ecaps != pcpu->reported_ecaps &&
> -		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
> -		    !scx_bypassing(pcpu->sch, cpu)) {
> -			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
> +		if (ecaps != pcpu->reported_ecaps && !scx_bypassing(pcpu->sch, cpu)) {
> +			struct scx_sched *parent = scx_parent(pcpu->sch);
> +			struct scx_dsp_ctx *dspc;

Should ops.sub_child_ecaps_updated() still be delivered to the parent when the
child is bypassing but the parent is not?

For example, the shared pool may rotate away from a bypassing child. IIUC, its
PERF revoke takes effect at the next dispatch, but the child's bypass state
suppresses the parent notification too. If the child is being disabled, it never
leaves bypass, so the parent only gets ops.sub_detach() and cannot tell when the
revoke took effect.

Could we notify the parent when the revoke takes effect, even if the child is
bypassing, while continuing to defer the child's own notification until it
leaves bypass?

Thanks,
-Andrea

>  
> -			dspc->rq = rq;
>  			/* stash @prev so nested dispatches can access it */
>  			rq->scx.sub_dispatch_prev = prev;
> -			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
> -				    pcpu->reported_ecaps, ecaps);
> +			if (SCX_HAS_OP(pcpu->sch, sub_ecaps_updated)) {
> +				dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
> +				dspc->rq = rq;
> +				SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq,
> +					    scx_cpu_arg(cpu), pcpu->reported_ecaps, ecaps);
> +				scx_flush_dispatch_buf(pcpu->sch, rq);
> +			}
> +			if (SCX_HAS_OP(parent, sub_child_ecaps_updated)) {
> +				dspc = &this_cpu_ptr(parent->pcpu)->dsp_ctx;
> +				dspc->rq = rq;
> +				SCX_CALL_OP(parent, sub_child_ecaps_updated, rq,
> +					    pcpu->sch->ops.sub_cgroup_id, scx_cpu_arg(cpu),
> +					    pcpu->reported_ecaps, ecaps);
> +				scx_flush_dispatch_buf(parent, rq);
> +			}
>  			rq->scx.sub_dispatch_prev = NULL;
> -			scx_flush_dispatch_buf(pcpu->sch, rq);
>  			pcpu->reported_ecaps = ecaps;
>  		}
>  
> @@ -1940,6 +1956,15 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_disable;
>  
> +	/*
> +	 * Bypass before @sch is linked and grants can reach it. The parent's
> +	 * delivery advances reported_ecaps, so a sync consumed before @sch's
> +	 * ops are registered would reach the parent and never be replayed to
> +	 * @sch. While bypassed, the syncs are consumed without a delivery and
> +	 * replayed to both at unbypass.
> +	 */
> +	scx_bypass(sch, true);
> +
>  	ret = scx_link_sched(sch);
>  	if (ret)
>  		goto err_disable;
> @@ -1985,8 +2010,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	}
>  	sch->sub_attached = true;
>  
> -	scx_bypass(sch, true);
> -
>  	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
>  		if (((void (**)(void))ops)[i])
>  			set_bit(i, sch->has_op);
> -- 
> 2.55.0
> 
