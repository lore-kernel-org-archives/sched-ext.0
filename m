Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D673AEF3F
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277586; cv=fail; b=Cl5f2ONMLu+ZKt/wIWDNnOfn+ZhOl19W6rkSyE9C66pWfD8uM+UpLoq16acvY2aHlAgIi0PVn8tfThqY2ny2/fIoxp66D87+xHJDOKN47nIo75rwzKuopIbaTzcgbIpMaP/+KDwtMz3rNmfIwNtpl1O6gFdzUrNArWZUtmVrs1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277586; c=relaxed/simple;
	bh=3Z6Qpm+UHBK5mkgZvcHoPUKGZsGIPyRKQbP++HfJyxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdpcyQXhINKf8yZud0QDfVFFrg+HOqsb/wiaEcckChsLkI3JRj2tv4efhWEp3yNhf0uSr4cNoclIAvF59dfn8Fpkhkc/fGKe1z7bmssTfpPzVInrL4mUb8aYxkJYgTRqUA2vfM+oOuQoZPnNP459golBnQkptSQ2v6PuKY+0Zr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KR2gMaW5; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KR2gMaW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcbq7HTl6mJNEODKxC/qwV2g604HLAnzgR7Soc9w5OcOSt/DQL/jbCvYQIo2aiSsibh+Nv4IF22mOYzmYZ922DgZfgPw1ScGEWN5O5nx4PD6hHUEC2bwHrnx277m2FzAmf2Q8XbHZzIsx3kII82FzZH2gZ03dhYvMpcBTLREwslQllT1ObMcl6fukoq8gWPrTN8DN9mFRMs5+anT1MqVvsmbU6My5aj3WD2CMJ4xWHYxV1Z1MJ0swVFZgFJdMwxYii0JluuBM13ITX1xwfdRJ9R7AyHFrGSPKUgbILLxgwmTHYdG/Yb0TS9GjGAgsuWCfRfL4lWdfhL140P50E1fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmzwDC+aL4Uq4vrEVHWTNU4xb3ZDjcIci7eLtiM7iUw=;
 b=L8r9yjrd+nkdmXWlFf669k0ivKBIgVKXCH60/II1J0whBgEYf/KKKW5p5XNCh9Ci9q6lMCLKzsamKLYzjJxqQXSV4M8PT0msxARGql/Hu/IQVFWN2V6xOcmeHiAYYhRO7wGKIMOMwtPHX4rIjJk/TETUTDdka3roHj6SASACQDGWqA/ugHcsu9VKCXESg0RjNmibUoVnFZvo/bBP+MLuS3DQeFfy6JQxZyP/Sg8RNJvYYa6R+EjLYxnO442W0S0js+bBY1R+AwWzFBmBY2QX2qhQPNMAvf5MUya4pkbRr760sZg2nUyv0ur2bxZqx+dmQRmxfoTrkCe5/esjxLzeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmzwDC+aL4Uq4vrEVHWTNU4xb3ZDjcIci7eLtiM7iUw=;
 b=KR2gMaW5k37/JMZVZY+kRFrR98FAbaQd2QRVobxG3SNm1HM1+BPmWMaKUGfJ/Ifgeqj8/FPVQ9SCau8ff7Rm1tx22XsMrrQ+rMjt8Tfr0LGjHVwkVBEni1eVMj3UsQSFo4NnPw2okpYh/MD1GTJNU8KPE2uCXrukP57uWMRW9XeuQUAxjQmPqLsptrwEEpvFQGYs2FXN2tLVRJQ3nWnB5ACuUODjUCdvZujMFPZN/QucDoNkldmupICC7wz8G3wDQHeSmIauYwPhWrWFnLKCDcUDKgWE/dXo5lfng45Ro4uz4h9/P5aVdRtkHz/S9VzxvuVFibwGPXRT+sOjh3Oviw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 22:53:00 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 22:53:00 +0000
Date: Sun, 18 Oct 2026 00:52:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Factor out the rq lock switch of
 scx_dsq_move()
Message-ID: <atP8QzPqztLBm2PP@gpd4>
References: <20261017223738.993262-1-tj@kernel.org>
 <20261017223738.993262-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017223738.993262-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: f3da072d-3e0d-4b80-c4d0-08df2ca1649d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WkB/yPubWZZfAbmIcS5HM45juvUBQnpsyrBscJQ2ugXfdsTVNnpFeHyRYGJ//kTTPMI/0WTxb1TpGZ5QpLcVKl5o3mZj92f+RrPsAYe9yPbYwvE6wirWhBQCMNa439x6105afa/q6RwV0NLCbnxucs5BOgllQq5qGpTeQ+LtBzvWSxgubcoot+LNLldoC2DDeGARxgZsWEz8V57cHmc+6alpyerlMiChar+DXSu7RiaM4LhKB4BnjqJKgPU8eLnv2c2DHy6agcb+5AsjiJc9xPDMmJxcN5pKJQJPdsHBaEaDSglwlIqyLng6AlL8PhYTeaSvZ2CJ6wP6geFgNRSY4iLS3pLWISoXqzfFpUG+s/rVQo0/bu4k24ygDoboM+b30yUMhVIQeOoWiYMfhO4T5QGOo2W1awPET5lQyawj1VJKwri1kW3+xUbsQkb96Skzin97V6jQNBSxDiRBjhEUw2BqMvNwLjiw7fBcNan6jmGdJvtT1eBZEO8JXorlkfewxFg0XvvY8YJfbGIALsHn7zGs9JZj7hSsWoSzKwmDCyqjxyb4iqs/N6ltv0a1WrK9HY8cU2F8AywNvETrQ9goJWV/tn782uDztquBLgqczaaMS2I4qYXLjE4M9QUMjettc0PCSDIz6do7DhLFGZ1law==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U8INsSYjgYf+qbN+/Uxq3KK7+jIuNVHdHOXjQPk9HVogGeQ+U6QC3MoHInZZ?=
 =?us-ascii?Q?Gq+/Jbk+zVaGHMPdy65NZakKud02bP3vyihpxGGCB7jMHJi8MoyvPsXxnkeT?=
 =?us-ascii?Q?AdfVE9v5fwmtxmUm1jUNYj8UGVDTtqy9kOMy/GruTEq/6oQ7Fv8L+N+ST5qN?=
 =?us-ascii?Q?NfvMEZySz38iCWANxZ4i4f2aiE9RhBH0qXdi4pjZ22HZpaX+JG06JkFgw7Je?=
 =?us-ascii?Q?bd5s5BvXaWxXnWMxQNfmCrBlbWUSM8kqsk9J7huOtmwD3RhVQikAHFCBHxYu?=
 =?us-ascii?Q?QaArJKoQc9Aborz74ZhM0AaWXSmF2tCx8OUlAjBRFYqEZDxOlFrPb3CfrdOQ?=
 =?us-ascii?Q?HyRIFanghtKipVvKxVwmxlXcXiz5Tegc+1JWFr++tOuW2AzQKcH3EPYbYpUf?=
 =?us-ascii?Q?WmAJSyH3YW2ro5IINKrSAfuybN+HFUjKpBE2Y9GEWjUvQSMQ5crdB4oQLz+b?=
 =?us-ascii?Q?K2Hy4wcW6JflqmOYn5XvcmmagvULBiZIFge/FAxqxAn/WflaNID/Xvv+mVrc?=
 =?us-ascii?Q?Nm4HS9pghdk777ECDvOBpfOhK1D6tpygpX9ryhyo77y+xv+GJPoHgz3q19uA?=
 =?us-ascii?Q?hnuujaDvpmEDvS6/OMBdEldE12lKifkVfBkx64ASFR184VtbzldyUdAChxb0?=
 =?us-ascii?Q?JOhp+P3Hl7tzZWUMh+jc4AP6+JaIG9UhdY9T6r77aImZ3c7MlSTcHzoLxIy3?=
 =?us-ascii?Q?TYEo0o+nikAln78/XynzKDtuJk+IJDFCmANpFyS1kWz6FzHascsrzTjWThMc?=
 =?us-ascii?Q?UVMSitPbH90LiX2BkEtp+N8I1k6FRSYsDvg+RxXVUp61AXUHZx3Oln0vRAsO?=
 =?us-ascii?Q?1pb68fdM0KgeQV8rVovY2ezqvsgryiTidKnRbd74gi70Q6M553jJmKs7bKCl?=
 =?us-ascii?Q?LLA9Yr2angHN214a9+HghVXl5XGfI6SgPgKiKV36PQnQ4P1StRCTzE9RFu1v?=
 =?us-ascii?Q?agOQy2VNt44UdvYw1SydE8+eCy4tzRcMdFm8bh2BNqB3u10TxTPlLnonzGuO?=
 =?us-ascii?Q?fuKVEW19doNq3fUtS66k0gxekzDvNfyTk4lRXwJkOAcbj6H4iViXvhIpgdLj?=
 =?us-ascii?Q?kHPGMjpF/XzgQIszuNGumt8ODuaFZDLN4s12vesyf+DYG4w28/9kxihjVndS?=
 =?us-ascii?Q?zQByEcnnW3LyJESmrSxWmWfMZZiTzCW5IrRB1VNf20HvJvt02E1S6FxXnZo4?=
 =?us-ascii?Q?Ra/PSdnpj+mK75ea/sEXaQks7ZxUbMLi9ljumLDss/8sQksCKH0Hoc9BBrAn?=
 =?us-ascii?Q?CX9HZ7rjZ7f18gLZYPsa3pOX5VbQleiqAgRJL8rdhBTIYg5XflZjpU3LgeB/?=
 =?us-ascii?Q?k6FB89VUJLTJ6qwoMTpk5tVmISZXVH5gLQh8u8fiHnimpreweqwnlaUz/5oF?=
 =?us-ascii?Q?SLpmKgIWu1p9nFNtC/eclzgx0ogMp/QuczQteMfQ0m6WYhPLVyMFizj9faTK?=
 =?us-ascii?Q?UpY5jHsX5Jz8mvjRLPo5inA0YGvpR6lZmOEgYWJ3m4f9i7rbY7pPZFt3iewe?=
 =?us-ascii?Q?lpceHqz0TjFakKZ0PUN2T/NY+tnU5cep5+7lze56IknE+zYd8b4eygFDhgWr?=
 =?us-ascii?Q?OPasO2F9P07/7mpbCZxbSwsyjN5aMBvn3mLaJC9yJsd35SU5+hTKHYYF397j?=
 =?us-ascii?Q?5FmBSZovw6BJXFY+DQnyEvwNK0kX85i4ExawEZSpsxeFj/qig1NVMQyYkNR5?=
 =?us-ascii?Q?6V+ayHZJbzw3+S4yh49tPURgJqLLgB4eHzqb25UplGeutRxGnO/miVEQeVGu?=
 =?us-ascii?Q?nM413Td5VA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3da072d-3e0d-4b80-c4d0-08df2ca1649d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 22:53:00.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xh9nDAvKQ2ALE7WytMzxNkGQu+6H7fVGwIJFoncVozgx/CyBI9sspcUYKMVTnElIvJ/BUEyRM+cIZeAzXLsZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

On Sat, Oct 17, 2026 at 12:37:36PM -1000, Tejun Heo wrote:
> Factor the rq lock switch on entry to scx_dsq_move() and its undo on exit
> out into kf_switch_rq_lock() and kf_restore_rq_lock() so that other kfuncs
> operating on a task from a DSQ iteration can share them. No functional
> change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 63 ++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b9f80fb29255..3e707b00e78b 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9745,6 +9745,40 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
>  	.filter			= scx_kfunc_context_filter,
>  };
>  
> +/*
> + * Lock @rq from a kfunc called either from ops.dispatch(), which holds the
> + * dispatched rq's lock, or from a context holding no rq lock. Under core
> + * scheduling, dispatch can run for a sibling rq, so the locked rq is not
> + * necessarily this CPU's. Return the rq locked on entry, NULL if none.
> + */
> +static struct rq *kf_switch_rq_lock(struct rq *rq, unsigned long *flags)
> +{
> +	struct rq *entry_rq;
> +
> +	local_irq_save(*flags);
> +
> +	entry_rq = scx_locked_rq();
> +	if (entry_rq) {
> +		if (entry_rq != rq)
> +			switch_rq_lock(entry_rq, rq);
> +	} else {
> +		raw_spin_rq_lock(rq);
> +	}
> +	return entry_rq;
> +}
> +
> +/* undo kf_switch_rq_lock(), @rq is the rq locked now */
> +static void kf_restore_rq_lock(struct rq *rq, struct rq *entry_rq, unsigned long flags)
> +{
> +	if (entry_rq) {
> +		if (entry_rq != rq)
> +			switch_rq_lock(rq, entry_rq);
> +	} else {
> +		scx_rq_lock_drop(rq);
> +		raw_spin_rq_unlock_irqrestore(rq, flags);
> +	}
> +}
> +
>  static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  			 struct task_struct *p, u64 dsq_id, u64 enq_flags,
>  			 bool priq)
> @@ -9779,27 +9813,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	if (unlikely(READ_ONCE(sch->aborting)))
>  		return false;
>  
> -	/*
> -	 * Can be called from either ops.dispatch() holding the dispatched rq's
> -	 * lock or any context where no rq lock is held. If latter, lock @p's
> -	 * task_rq which we'll likely need anyway.
> -	 */
>  	src_rq = task_rq(p);
> -
> -	local_irq_save(flags);
> -
> -	/*
> -	 * Under core scheduling, dispatch can run for a sibling rq, so the
> -	 * locked rq is not necessarily this CPU's.
> -	 */
> -	locked_rq = scx_locked_rq();
> -
> -	if (locked_rq) {
> -		if (locked_rq != src_rq)
> -			switch_rq_lock(locked_rq, src_rq);
> -	} else {
> -		raw_spin_rq_lock(src_rq);
> -	}
> +	locked_rq = kf_switch_rq_lock(src_rq, &flags);
>  
>  	p_rq = src_rq;
>  	raw_spin_lock(&src_dsq->lock);
> @@ -9838,13 +9853,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	p_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
>  	dispatched = true;
>  out:
> -	if (locked_rq) {
> -		if (locked_rq != p_rq)
> -			switch_rq_lock(p_rq, locked_rq);
> -	} else {
> -		scx_rq_lock_drop(p_rq);
> -		raw_spin_rq_unlock_irqrestore(p_rq, flags);
> -	}
> +	kf_restore_rq_lock(p_rq, locked_rq, flags);
>  
>  	kit->cursor.flags &= ~(__SCX_DSQ_ITER_HAS_SLICE |
>  			       __SCX_DSQ_ITER_HAS_VTIME);
> -- 
> 2.56.0
> 
