Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9A2E1C6B
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495427; cv=fail; b=G7PBlo7O+p5DZj2sTnBwND58Gb8XO/el2hTMKs8uQhMfMchmTT/HhtqdFnc9YahpK7qFhp04ShQ7b/6Sc6ftJjjCZ4BqRyOz3fmpQg3QWePMgcqS4hQQc98R7DOqeqtez9SAEijepXaa0XOWEOjJZ7tg06UPrrceGcIXN98kyGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495427; c=relaxed/simple;
	bh=AqvBgrxC4wpsidr17+7+8PfxGki2Q+raHQ9LGEAh9+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tXH584Ya3LQhQ08L5vLvEXei0sDqMGq1uqCWumGorfZ3M6LlzeNDB4/l4SQHYqzw9nE2Z79y9H9Pd+814D5pGlIDEzqg91dL5CdKFFEejCfC1drnHIsyl73WRLBQgwDdjTY4y3QzqUOa5uxzDz4cBZGQBmrHWZcvGCVpl/Qq6Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COOnb/WP; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COOnb/WP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsBCQ+fJ5pcTKISNUcVMlBS4cXRDMiagkXvDYwT4l4XLU1D8LCz/YuSxG6ah88AT3g4pnjDWRuUbpq4O7T4radVThxkQW4JuCNUvVkUASh6sGQazc0U1MpOTr8GvSKddenppoa5calVSUH+FI1jRCDV//ESu0kMfQzjUQCWFhHDtHXNaRxJEHYA+n5XuW4o2FIwcZTUGSZyV7lwUaBLpI/9AB65G4q87tm/pNxwTjePKAY39Z4ek6iUWqRnAYcKBIv4kHweSQ11LCHwvczwRcK/7X9v3TD9S6zDdQOQz+pAl6eYkgjBXcvk7aVosoTsH2JbYSLEhSv8ryzoZLa5GVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPMAsThAmxDIpC8OfV4KMjelxON5Gih8ETLqroLHIbo=;
 b=b9we8j6zYGD4pxcl6A7lAD9/+VVjxMtH0l9rvS4te/iu+YG0kbYvCT/NFGJztnPzzn0dNHpLtrd9z6mDD5fj9JufyCE2/3EmNBPb1pzM39+ki841kZ0bqk5fnSn7/nY34TgyFHDZ6BR+gord4RcsbLJpbz9Gk9z1SCR7ACr/i6I+gdzV2DwlmUs4+73F/aEdMWBAEpnzIggXguAQzxQdwWRj2sbw9pmEJwcJsKlRWI74XLbGKr49xkQIgQ5wSzqGIo/TKLJlf/UYZ3Y/MW7aCveGj9xOcFTs2mhscuXBCz/vrc8AnH3ziaYCZZr790sXOeaUZ484u5Q/nD0bwwvwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPMAsThAmxDIpC8OfV4KMjelxON5Gih8ETLqroLHIbo=;
 b=COOnb/WPKCtMNO+hlr0x4aV77R3rud83Xlkkw/nQ0VNEfg7H0E9R/kxaqlpxjMztBfab11Irn6jH9tWM+Pk8bDeZAnDcv5qekC9N8yniCrYCotz9SdZunEU5IRGYbcfqsdy8ox+m6nnvRt9v7T1GITni6ylbjqxPFD24YDIGNDncdxwhlqi1QVZAuVJTaDQzZBTb6KZ3QyQr8w+LBkYgKrlwDR8/tAbxicnG7ZT+dP+p5c5LnzcPO3+1PNAefHmUZqHFMVs8lSHaDmvVfG0EFXwev/3FHI3n+3YHf01810sTh9iH61x7U/RJYxf+S36u3oKyYvved40KCGAsR80cmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 23:23:43 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:23:42 +0000
Date: Fri, 12 Dec 2025 00:23:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Factor out local_dsq_post_enq() from
 dispatch_enqueue()
Message-ID: <aTtSeZ0dAadWj7Wi@gpd4>
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251211224809.3383633-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211224809.3383633-2-tj@kernel.org>
X-ClientProxiedBy: TY4P286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 968bcffd-65af-4e3a-108b-08de390c52d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtaUYXsSg0dISvZib37bfdQEYIow0dE0fxnfEoKycXICF+bw4xtAGFhKHnHR?=
 =?us-ascii?Q?IUoWCFt3G69gSADjZBz7FM9Qf1U8s5pxeUq+faJ4GB4crcM3pgzn4QqXxIW8?=
 =?us-ascii?Q?sKDlmH3UnT0yHEPvZQzsyyO0NolVwOMhBBMS1tGZtkoneZGJE9znyUD4IgwM?=
 =?us-ascii?Q?Iap2jFKrw376xJlV+TE9sRgbRn+jcyCnRCZXt2EfYeaHtf4mIsKPDbfOppxI?=
 =?us-ascii?Q?TlKUNiEWJiqv2e5fe5fl916RJ/qOG1dKmZK/g7FV1TGn/O1hnfyjduzEiB5w?=
 =?us-ascii?Q?XIipvywvciR9b19eH22r6XjP39loHaVgTq7hFbkyZRrP3mP5wqLQ1EJmqvcN?=
 =?us-ascii?Q?YsD6GVy9Trs4DTYV2LzzmPzz98Ni6cPhdpcArtftri03BtjEB7qdCt9oBi/R?=
 =?us-ascii?Q?NPKOJol76yhe32RToZFnVT3RQQMMgp/kfRygFzn9+J0ZmOkdnaPQZmEfmlRR?=
 =?us-ascii?Q?REiNBK7DDoEhR5XN8J0JNZ8T6RTAE8dFqjN+Bo+TZ8TtA1yyhiseqLJ8zkxW?=
 =?us-ascii?Q?aArm9CweuuxgijhgyUTOSvDzUiFzVPT2P4Lh1uxlYL0W1cRQCIMKWfbwRPS+?=
 =?us-ascii?Q?x2UyPKA8cF+5ypuc39o5ANwCYHBp6jIPS/lgNUoYg+OyT+mjanjItZprVJD2?=
 =?us-ascii?Q?QMgyADbGDErg9Fx9PRsQhvWidSL9VO/oMLBNe0wSQhpkBDqHyVVuKj6kPyFQ?=
 =?us-ascii?Q?9+3x76p0hBMoR44Bji3B49HNiA0v27hcAU8USupGcw/T6KCjxdaZe/aQ+RxN?=
 =?us-ascii?Q?Pjmh5UdFefwi6Sbs1I7PGq8tpvx5Gh7j2NnnG9AwZLyUPvDrs22JhBNpI1bK?=
 =?us-ascii?Q?qOF7tx3RdYQ1mIcJqcuZKF0twhwNypGaFnKEFYQwJC0bjua5vYqUbmi38lSA?=
 =?us-ascii?Q?63RMAKPbqR3/DiI+Vs6BKBpB3apjL98+zok2p4YUikJegA+JD6RphfOIYGg7?=
 =?us-ascii?Q?qH/g+aXHq0S5HlNn1PxPjoDJmDZWK/Mvjr3QcaLSC7dzHVp/jxNoSw2SHWTC?=
 =?us-ascii?Q?jM/KmVrKN/vxmMr82NlBGxOYH2yYj58Z+38Jc+jL532F1GasY2iyoGs5OKmF?=
 =?us-ascii?Q?+zokRVVd86Yu8l7VgDOqgTk0qxsUFr/AfXs2/1YaQE84Rpb1wt1KBao2SOcS?=
 =?us-ascii?Q?YqLxIhILbpO8d009uT6wjSFactoQf65VnffPaQXHKvgayPkrNn5Bu2uqLYxV?=
 =?us-ascii?Q?/axWwvmr7NPZVVyQwF8osiQ1WXtxsHf64pVR+Yb7WgT+3zw0NoapZBAdY78Q?=
 =?us-ascii?Q?zmF3lChM1hlZzPba37BeU0Zy7SQgu84TuQ+lJi6qJSLXr4B5p2i5nK4SAj9s?=
 =?us-ascii?Q?SlzV6iiiq9dvpfB6UdRzWVqZUr+xiecrZbNT2gEjb4od315w81m+Hr3STc1i?=
 =?us-ascii?Q?yqO4/pxZirF5Y2ueafAtQRMz+7zhivhcfOS9lx70zQPXb80xLBrC0CBQr19g?=
 =?us-ascii?Q?rMLeo7QSjhECwEPHueySJEiAP56qoUwA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lcnZbVsKw9tOcP2OwH542iUf2pRx6MIKQM08qBS1Il4Dj/ZnYzHAT+9DzOzT?=
 =?us-ascii?Q?IZO7KVuS1+QHzxs4pU8niq8fIV8bqvhx4OF3mJuSAfOZ3h8vzam7dgcAG0pv?=
 =?us-ascii?Q?JJtd8TxdJu78Y5oV4MSgGbbefSjL6lukymkzZTV98YlJMCq+T40TzwCeJvvZ?=
 =?us-ascii?Q?jY4WYveh7Al89Cq1YS8RRWc9rHEClLnUZ1/ffoFFfpl493ojlWHYaCPlNBDp?=
 =?us-ascii?Q?mPsP89IVxruqYQZzhHHDOVnAiDfHn4bRgBqdQQL40zLpwvb/NeQ4PhLoksDw?=
 =?us-ascii?Q?F9mwfdyPhzSvkkH0BQHC2WaDI/4gNBUU1lCDFGy58+SSsez76nAL4TO7iuow?=
 =?us-ascii?Q?F3cWi6BrxwTOaefs03I0b4xPx2Lyl9eoTup3JFTo6l+6tweShtNJEe0BLdfX?=
 =?us-ascii?Q?ZeqBTYJlISFBqUob9sPniVQJ/YtPEnHlUazyRKh5E4TTDqAAsjmEV7N8C5dL?=
 =?us-ascii?Q?2SRZoagY0UI0Ul/D7YJcxZm3MkCgKjECsCCmVugS7wh73S4NNHjoeJS89ZWi?=
 =?us-ascii?Q?4SGbqwWiBACAJeypdI4eujJ7DlqniqlJM5BBv0rFCyQ45sbMKdigcWLwgvew?=
 =?us-ascii?Q?z0A9beMuwque2HiUhyvUfgxucUmGmnTCzvdQBVDZ+dj1b6+f/MRngoSKnNDF?=
 =?us-ascii?Q?fs52uhTwqeiAMp0BZJ671386GkS5RDuL+0dA6DOkGgoqZFYHL+4loOMPsQDX?=
 =?us-ascii?Q?yH5ghTscNP+ewU/K/cIvQfsexCgxl6Gb+iJwHHz/21X3pQO8JO+3REd4rygc?=
 =?us-ascii?Q?CjmMk7ZF5YUS1vkMVLe1ncRIcO+6MyGaw7Sbqq4URTe2a/BC3mARVFdsv7Fs?=
 =?us-ascii?Q?KuUg+cArFJWjYq1+Z2lKBNRyPWo4vjEDlgP25TTNAkR7Fc7RE7zpTHhNfkiN?=
 =?us-ascii?Q?dkdB7jBOpl1LXGiAbiokfvQRsxgjl2yOfrpM11KdIM6mwy7U80wKvVI4bC8m?=
 =?us-ascii?Q?b9+LIAAqUBIzYxqS73ZpYCQ6CVFpzO0Vgt5e/AYXxXB9G3nXEPtj0TjBhbYQ?=
 =?us-ascii?Q?8+SuWBkKE28oS2jLxehB3ybEkAm4a6Fz/S0QwyjKKB0G1oXB3IU2xFCRn2qA?=
 =?us-ascii?Q?bzs8lsEEYGwT+nfFtfJxE2bmnMF2p4pPxSQtPNR5A12XRA8x5EGsBg7O5/Mf?=
 =?us-ascii?Q?uoGr4iiVhxjZZ4nI3QXxLJ8MPlTH2WehyTtHhqsRsvYwx6LWSi7jntjK838g?=
 =?us-ascii?Q?KSE5pQSySMkkbdw5EkLOtYB3iYdHSlx0wjIZG4gBcpXFCgTtTrKqbMiSYBJC?=
 =?us-ascii?Q?IkUH63pT0BC63mrcunFlhNssmJUBzFR2mW+lgLpV7bEQ3ut0J2/UuGLfHEkY?=
 =?us-ascii?Q?nvpKZWoPq2mBh6gZOWrHpYaxEv0bHtyPes+yRvtqdLoxxrAPOHnwm/W5nb7q?=
 =?us-ascii?Q?m7y09d6OaTKQgX0/792kJopnOjM12L4VcVYHYvi9IJniLEphZWZ029NLevgD?=
 =?us-ascii?Q?IfWj4/B5fUZWoCup6N6VSELGDP/YwcnpMa7SMNBeFBJXVF5x8RI+185Y/A2i?=
 =?us-ascii?Q?3x1OAoJmx8JJ8kJKfxFW8PQMV2nCWRNTTNaRtbhVccR7GNQvYBkzNQDHdAzi?=
 =?us-ascii?Q?kngdcajK1X1UnMTZLquibavYadjNA8JN7aIdPxfMjMM90Ny+756H5OUNcNI4?=
 =?us-ascii?Q?3h+F7n+Xvk/Aj0P9EM2UKjBN4jo60D+hKHLqSPa+nXjx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968bcffd-65af-4e3a-108b-08de390c52d5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:23:42.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB4j4WwDjS10JL3YNFPsDM+su/4gqpNwpLGKFSrt6g52h0LXlNg9v8RcoaKXAdvN5wxOsgarJONR2QwS3fzA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

On Thu, Dec 11, 2025 at 12:48:08PM -1000, Tejun Heo wrote:
> Factor out local_dsq_post_enq() which performs post-enqueue handling for
> local DSQs - triggering preemption or resched_curr() if the enqueued task
> has higher priority than the currently running task. No functional change.

Maybe "higher priority" is a bit misleading, how about: "triggering
resched_curr() if SCX_ENQ_PREEMPT is specified or if the current CPU is
idle".

Thanks,
-Andrea

> 
> This will be used by the next patch to fix move_local_task_to_local_dsq().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c |   34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -975,6 +975,22 @@ static void refill_task_slice_dfl(struct
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> +static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
> +			       u64 enq_flags)
> +{
> +	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
> +	bool preempt = false;
> +
> +	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> +	    rq->curr->sched_class == &ext_sched_class) {
> +		rq->curr->scx.slice = 0;
> +		preempt = true;
> +	}
> +
> +	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
> +		resched_curr(rq);
> +}
> +
>  static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
> @@ -1086,22 +1102,10 @@ static void dispatch_enqueue(struct scx_
>  	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
>  		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
>  
> -	if (is_local) {
> -		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
> -		bool preempt = false;
> -
> -		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> -		    rq->curr->sched_class == &ext_sched_class) {
> -			rq->curr->scx.slice = 0;
> -			preempt = true;
> -		}
> -
> -		if (preempt || sched_class_above(&ext_sched_class,
> -						 rq->curr->sched_class))
> -			resched_curr(rq);
> -	} else {
> +	if (is_local)
> +		local_dsq_post_enq(dsq, p, enq_flags);
> +	else
>  		raw_spin_unlock(&dsq->lock);
> -	}
>  }
>  
>  static void task_unlink_from_dsq(struct task_struct *p,
