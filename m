Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093425782A
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038615; cv=fail; b=NkjSkg/FiApD3fN7nAGLrcktphfOe02e+QOV2VqHSxHE04m+BCpLiT3w4brnS3S7D6zKFLM4RvdJncUvyUI1LRr1iRD0XKxz4zIeT7UQnDxVOtx48Pzv0CtMtQ2dHkJZ1V7tt24ibCLihiIbKr2gfG5kdSBLkyufsJMr375emtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038615; c=relaxed/simple;
	bh=dsMoubW4lBk0Fxi2guONeBCWGNHvDqOxJPXmt5+Xfeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZqaG/ezCw08suSUPiMqW1SwWh2PTMSy73dvPRnQqk2SvMMn0toIRtxdc+yUfvl24JuTbFSYEGrrZqDc67VyhZr1g8+GwCC10inaHcAvtBSQu3fhAWk7XrDV6gBRdsFMjm3s8AExYxv4bBNfyVRwayV6R7YozgXMQyMwLE5Ij3pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+IUdcFo; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+IUdcFo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFlXzGOjBeOxsK+Vf005iQWro3lGXxKJWwxL701nYVqdJ46ueJQ/SqxVLtLn3Cn7QFkDssvEa61bBUFsGpiCg/ds8wmqYoyud3h/Kz3yfIxak1+rddAyUpXmEIEdVw44XJaFE1wKerH2mOVO2PXrdv7M10PH9jTM0iAG9SO3Is3SiNxnnGPP1J2/27OD4jK1kOR4dvTHIOGOwGDRra+wBQWvOJTUhU9KMIWc54EZeofNrmZ2QHkp9+6hMBasNE3O1j5qO7vry6n6JdxNcJ+7KzNXHRSDQky7JiMzbb1noWzGB9/aJYfbbJ03s7bQ4d3Rh27IRxgdumJ2H9FD2aKWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiYLXbyeBaJnK0+gYTBHM+eoYcOlCEgKB9IInBHgrs4=;
 b=b4sbCcK6ImGbfTKwniKz+13dr7E75af8nvO7hVJfEGWtsZMT2qM1hXTvvWaFMIrBeqGtzGhxC66hZb9KLrRb4VlgwsilCNk0mMhCyN43dZhbzhkczbEDhNiWKwJ5nx5YNwbqfCsb7twE/VMYPCV61wuMPjd6VPtRznRN1pHFaN+1R3YeV74G8DK9SWTQBSE/h2UQMJeyq1n1jW59HDyVdIa4lFM9aL+5xCOgMd3J9EEQEVCdV98gvnhWjGOHSx/x77OcX3OZgIwfyKET5bA9cDSnJcEWiYeY9OnFTKw8h2+Zz56obYN5PmHuXcw9z0BM9Vr+kpnlGqq+6IcPpgj9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiYLXbyeBaJnK0+gYTBHM+eoYcOlCEgKB9IInBHgrs4=;
 b=C+IUdcFoYq85gtVwkErfxCRPiSuN4MMyvzSgs1YXMIqVDmvzdFjbNCfj2wSHLPf6AV06e7KseCghj8V7gsYjmWevvPppxHleoPfiCozLUsZij5SUwJ1ngH94NFqrrIBjgo8W2p+nrSiJstHWAh8GSbrXuJSL9ynMg2YWPIOuHRgULJQ8YQlWC78JqyrcaWMA0T0ltP4jUG6o+8x6/gsScZIaKuwyyAQwEQrwR1z5dLYK9Mf34FJMnvyx8/eEdD/FCD983XdyfC7nxjONfDsJcz+2I1r/gBRfSd9VKztsMK17IlBB89a1+F1fj44tNgw2zhY9JVnOzbXDt3PHBqCXLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 19:36:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 19:36:51 +0000
Date: Thu, 9 Oct 2025 21:36:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <etsal@meta.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	"Emil Tsalapatis (Meta)" <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: defer queue_balance_callback() until after
 ops.dispatch
Message-ID: <aOgOxtHCeyRT_7jn@gpd4>
References: <20251009173620.1882642-1-etsal@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009173620.1882642-1-etsal@meta.com>
X-ClientProxiedBy: MR1P264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e3bcd-6ecb-4ab1-10a2-08de076b31ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lcq/Cw5enG7KO9cekXT9ftTTLZIV26DcbODX3JBRYdWPx0Yx+qQriN8RVIlR?=
 =?us-ascii?Q?8hdEo+tUJlP9lopb4HrEJV6nKwQXPT8On7rtWPJVWCVvyfC0M7UTI+NTvK3H?=
 =?us-ascii?Q?kmhK4OO5JzMd7Due9LJQQHubwRJKt9NPzgfpnL4UXXyaT21mrByNjD/1yuUP?=
 =?us-ascii?Q?zCYk3/zTDr7IG2WjPrdl9GTvU3uTD9Ge+LMa0XECVrenuEr6nh6s9GDbnsH9?=
 =?us-ascii?Q?wzPN4G8+5K8d3f3OnEbrvmQvZ+R6Qw5rdeTyGJ+gaTW+pNUCDu6k1aH0nPVg?=
 =?us-ascii?Q?6qSVr2JXMklAhLQgdy/6YCN6IhvCzceqeBpvoKyURN7lxRRqfbiq5l/MKFha?=
 =?us-ascii?Q?PPA/mq335otsu6BPqnaWMIp5cXYcLsuX/hcMyOMjfwIcl7tGjy2VldB1304O?=
 =?us-ascii?Q?dmkNNNeEu0cJJM2gMz2gQmz3bzsqgu+YQjDqDnRXSPzYKvkbBRy7VQjsLynx?=
 =?us-ascii?Q?xEtyDGUaTlUNyIbj6wN/UyGH/qX5R3cmBSwtX3My64clH0qb7LBtBl4YLVEk?=
 =?us-ascii?Q?++fMBIUiogCLUV4LM11ldHiX6Qd00oQx8w/Gi5nVUD5rncgr0GRX/W6eIVDu?=
 =?us-ascii?Q?sOxotzGAc88vQW3IyYpzmzVCBodoSXyOaS0ZF0saMSUnDX4Gzstn96dpTib3?=
 =?us-ascii?Q?Ryi/EdAHODVTKD2smt0iIR+4kWtM+c8+ra+BwfjLU6HHX/+u2AoIYVIJhpFX?=
 =?us-ascii?Q?EZQId5kbXQED8cJ8rXBalpILra1DgM/tlBHIsc1LmLWEQmOLzEdcQSuHzTIl?=
 =?us-ascii?Q?0B8feOQQ5Gc4LhuPffoPRJZaa0+Ih6Wi1XnM+AeK2RcRfoa6vsrWu4GdrAVf?=
 =?us-ascii?Q?7YKjYI+q89LKsabsrnn4QmVDJTEsYPd5K3Uk5ZvniF22rGAGbyvBRQvdSn/q?=
 =?us-ascii?Q?ArZn1EVO6LdRchJLyeX2rz7ekHxG2ZVzeI+UcKZ+yY9Cdy6l49BCxRAbcB7z?=
 =?us-ascii?Q?tatmEO/YuYpMoNm5TDTHSi2aadNeb4ZHxBKrMEmRiWjUrGf3+eDLZGHkcthG?=
 =?us-ascii?Q?u2SmM+1JpTTWa5JF7rigEJiI+8ZnLH5Rwc5eOmC8m1PXmqovdPLvsj3o83od?=
 =?us-ascii?Q?KujpqeCZMPvKNy6AzqWHud7cLtcBdz3j4kv92VX/uqdB+UXe4k4A00TNp4sY?=
 =?us-ascii?Q?oLyQjGioOw7TXuiOv2VWYksbu8rD4NZRnHylDNiEKc3qEgVaHjL3vUy0l0TF?=
 =?us-ascii?Q?EthbZhGFPtb/c22XEOtv291kNuQxmnXZN+h7g23gQrb+e3IhVIntycyJNGV9?=
 =?us-ascii?Q?Y1dQ/kJzkQO9PN1rK9yNk5/yAw0ILfmDB74Mm+3dy3n5LJ+tXbwtHkJfdAP2?=
 =?us-ascii?Q?a9DTh4ctsC8l2WlN7KdxJ/Gce34S3pMJrDBeDc0AgFsnsg0VOi03DUXyGgWg?=
 =?us-ascii?Q?unAEkWK1SLsqobQ/ECF8yiSAxBMZY7TWGXCh5il8RvmuNl4xPf/wZ7FhePmi?=
 =?us-ascii?Q?4jkFR1QDO+FAwVsf7Fq6fYdEdOdivTmQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RguCDBj2DlLGB3EhN8k/oUW4qI5aGeHpHED6wcMbUODu543ty0TKyDoiFFm?=
 =?us-ascii?Q?0inibBnfYmo4tIkxusC+rMIV2Bt9i7o6HEIOP8qQXqXZEnTrshLphSvm/lRu?=
 =?us-ascii?Q?iJM0uVt4eiOLAcF9zt1SmEel2vRRF/8iOgGegcSqPlYyuy6BV+hVmCuF8N0z?=
 =?us-ascii?Q?4l30OEvg0ezbv1PfDlSwvGDoepBAea4yE8sFqEyJJzcBOvaWsFYSyI/B48Jp?=
 =?us-ascii?Q?fRfPIjOxJ6fP3HEbCQfHUG1wwU5H7Gs0HJtUEPNMxcPizHXANRW0M+V1QsGo?=
 =?us-ascii?Q?nk40v4sjLddrfFi5KPyO6zrttSfOjeVV5XWPiFiFJpsryUg8nlP5Z3DYKnhZ?=
 =?us-ascii?Q?/TVxtKLlLB5WOZOwSCskqjR1H/STdE82ai8msXweS54h9hm9VSwx9PfeXbMm?=
 =?us-ascii?Q?r3YP+1R0vJ0FHnOu1Rz5e7fJlHyEregg5dLxgjIHy/M5AQ4xm2NFLX137fff?=
 =?us-ascii?Q?OhdL8tSStGO5jAz+78pa+eQllEGi4eV94LhAsn1fImqwkHK/a14MMIu0Ni5O?=
 =?us-ascii?Q?DsK8mcur4w6cxg2Aqk28i+vYUaaNXLIkpgNzJIM3AQldCiHinGrEfmXHrDVT?=
 =?us-ascii?Q?VYFnJUJ8gKWRUEKUP1/zeH83lt8JnK76mTaFiS/7Ogf/LT66gIVtmRKDH1rH?=
 =?us-ascii?Q?rV8w2prxWIO6jk10baFkp6argnjRYwC0GaZj7NJCYq4T7PUci9eESrc60OK2?=
 =?us-ascii?Q?TCyx/4qpbrYBxWEeiEWDQGxkakvE+U75rNJWCDU+EDMsmWf4zeBdktQSQ2k7?=
 =?us-ascii?Q?BQyiYdRnfnuvYUmTZN+yphiCth5/9xTQgnykfAy7g430iJWqwj2h2gavbYqm?=
 =?us-ascii?Q?EAUkBjGcfwScjspvutRDvd8qrUz6jnBwSoIBpGfvQT+oWe4HNlqtGz/UmAlD?=
 =?us-ascii?Q?RVr5z5yq+O3F15/Fb58HWgX1XEtJPpbToUixMl6RTLEaBIedDPkT8oFUItRE?=
 =?us-ascii?Q?Vl2gopujh8mrkxgyFmZdZBpTmNeqvwoTPR6d2UQc0BwPGpzXQ2GJlfE/+2P8?=
 =?us-ascii?Q?ZFaKhWCeFeYJBzJF3Mu7dy6t0s/KSZ1SfEoluc4RY9Az4/TqCa1iWraK7y7V?=
 =?us-ascii?Q?BAznAkvsPBXm8saEx4/kaDwc/ZqJ3+xUU/h3cOFWFnRoZZ1DmG06R7x7k22W?=
 =?us-ascii?Q?4fIiLMdZQACeMYofAkoWmkPKbky9Z1+JgzkfwNpE8y3ROlyFdxx4N2T0SVET?=
 =?us-ascii?Q?R7Wj3b8bwQzeT//VuQC39HrkhZFUUcCwagFfWC0gjayhirxs7D7YtpVO7MzZ?=
 =?us-ascii?Q?8J09lgALMvoumDuSboIItnCxsGxjPI2BlsJ+qjOKv5Ob3HsL14MO5Ehm9FLk?=
 =?us-ascii?Q?xNifhedCXHrJdb8SxfsBuO6o5rLz84posAGcWWWL1ekPP0BWR+7skAspBEBr?=
 =?us-ascii?Q?jbTp6INaIG6rBWxEDP1sQEYxR7QryJ6g4TEpJyJSTvnNZgVKQbcBjgaITPdR?=
 =?us-ascii?Q?1u9jrlmYovXOunegLmanR2v+lNTLl4eQBu1cbmjfitDacJ8PcFQKWTWcLwnN?=
 =?us-ascii?Q?e13XKIx5aOfQObCI6YfTBB0NmLxzpSQ16RX8RNeBm8u38CJ9bypDhMW9d63O?=
 =?us-ascii?Q?MYVabj/eeRa8cALBG56BsPzLA1mm30A11xzq0z9O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e3bcd-6ecb-4ab1-10a2-08de076b31ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 19:36:51.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNfEcX1RMTrmbEh4zl+E0isO6RRTt4u2bo/TSEOmRE1J4Olhiaj/g5M1a/YmBbdPwHa5CieYtPr1/37Yck8Neg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

Hi Emil,

On Thu, Oct 09, 2025 at 10:36:20AM -0700, Emil Tsalapatis wrote:
> The sched_ext code calls queue_balance_callback() during .balance(),

I think we call queue_balance_callback() from .enqueue_task(), right?

> to defer operations that drop multiple locks until we can unpin them.
> The is call assumes that the rq lock is held until the callbacks are

s/is//

> invoked, and the pending callbacks will not be visible to any other
> threads. This is enforced by a WARN_ON_ONCE() in rq_pin_lock().
> 
> However, balance_one() may actually drop the lock during a BPF dispatch
> call. Another thread may win the race to get the rq lock and see the
> pending callback. To avoid this, sched_ext must only queue the callback
> after the dispatch calls have completed.
> 
> CPU 0                   CPU 1           CPU 2
> 
> scx_balance()
>   rq_unpin_lock()
>   scx_balance_one()
>     |= IN_BALANCE	scx_enqueue()
>     ops.dispatch()
>       rq_unlock()
>                         rq_lock()
>                         queue_balance_callback()
>                         rq_unlock()
>                                         [WARN] rq_pin_lock()
>       rq_lock()
>     &= ~IN_BALANCE
> rq_repin_lock()
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org> 
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  kernel/sched/ext.c   | 28 ++++++++++++++++++++++++++--
>  kernel/sched/sched.h |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5f957cff5d17..35dfce06297a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -780,13 +780,23 @@ static void schedule_deferred(struct rq *rq)
>  	if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
>  		return;
>  
> +	/* Don't do anything if there already is a deferred operation. */
> +	if (rq->scx.flags & SCX_RQ_BAL_PENDING)
> +		return;
> +
>  	/*
>  	 * If in balance, the balance callbacks will be called before rq lock is
>  	 * released. Schedule one.
> +	 *
> +	 *
> +	 * We can't directly insert the callback into the
> +	 * rq's list: The call can drop its lock and make the pending balance
> +	 * callback visible to unrelated code paths that call rq_pin_lock().
> +	 *
> +	 * Just let balance_one() know that it must do it itself.
>  	 */
>  	if (rq->scx.flags & SCX_RQ_IN_BALANCE) {
> -		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> -				       deferred_bal_cb_workfn);
> +		rq->scx.flags |= SCX_RQ_BAL_CB_PENDING;
>  		return;
>  	}
>  
> @@ -2003,6 +2013,18 @@ static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
>  	dspc->cursor = 0;
>  }
>  
> +static inline void maybe_queue_balance_callback(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
> +		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> +				       deferred_bal_cb_workfn);
> +	}
> +
> +	rq->scx.flags &= SCX_RQ_BAL_CB_PENDING;

Hm... this looks wrong. I think you want to clear SCX_RQ_BAL_CB_PENDING, so
it should be:

	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;

And while at it, just to better reflect the logic:

	if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
				       deferred_bal_cb_workfn);
		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
	}

> +}
> +
>  static int balance_one(struct rq *rq, struct task_struct *prev)
>  {
>  	struct scx_sched *sch = scx_root;
> @@ -2150,6 +2172,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
>  #endif
>  	rq_repin_lock(rq, rf);
>  
> +	maybe_queue_balance_callback(rq);
> +
>  	return ret;
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..8f3935785fc5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -757,6 +757,7 @@ enum scx_rq_flags {
>  	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
>  	SCX_RQ_BYPASSING	= 1 << 4,
>  	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
> +	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
>  
>  	SCX_RQ_IN_WAKEUP	= 1 << 16,
>  	SCX_RQ_IN_BALANCE	= 1 << 17,
> -- 
> 2.47.3
> 

Thanks,
-Andrea
