Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E053BA241
	for <sched-ext@lists.linux.dev>; Sun,  6 Sep 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703360; cv=fail; b=Yr5SHcrCLaBA6H3Sqp2f/bcw0Iui9JI1oDKHfon86/0RBsCcY8k5Q6GkqywQVcpDvQF6h6Jfxzq2Z2eylHCtjLFFlEg4hAZndK5QlnMgQZIFqjhe3T0Wob4KAb8xIAekyoQZxUtwWPg7PtGel7slggKQd7QMaqVIrYDccZMnWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703360; c=relaxed/simple;
	bh=tF39IB0PeFWHAYRDR9zK0614LRiwSS+UXxePd91Ea0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPfOxhWiyz3puQr8NyyNr35QcpES6V1WWPUDA8a49BogbRmDVnN8b1m9T68ShLJxAA/BC4atsALce88v82LBq0ZdBGTMzcaHG+ITxXfdpnv0VdS1+wbEce109rDdFZGpBPGY8kREmEaS4ef72TDeekhAqov9ufY6S5GkUgdDhEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QNltYcJD; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNltYcJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxyOLEfpc3HYZt1eoq0EHacSphVTHlxhJuw1kZcSH3J+OSdwB9DtUxb4mt7WvYnpPdbTeW+IBTTF7znDjb/0c1Vh0y9xA6mkYBjXo4zX2BYmMErM9XUJksNkNgPJLSWABceHCMPZKaJ7gwkQDf0W7cQDaVjP5K4q3Kj/LmZDjNh0zLidAhHSclJIeQlUZjjdLf6N1OhiVWwwvhqWt6s9Pd+wUlp/G8ZVs5Xpl0M0DiBTqRiG0gOvq+m7DTZHW0W+niVW+wrSoGQM/TLHYXxa/z/1vO4tFEnjDz9XfFC3jsMu3ze2Sexd7Yt+Kfepz1RY6TpWJ+pYgjbmrEVK4fmaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS2Y5silc1qlxH8Avf3YOx2/4eJMxE7eW9tqYCnyBRU=;
 b=loNDsa0KCfRXDpWKaL80MgN8t8cY6QZP3vEMN51UWIN94reXoB98P9MCC1CyID7qcFum8cY8jTkM/4cE8aCxw1RMU37gSwB3jatZ4xfM7eT0HNrQGfZRJSAVCqZskShdkmFByIlCls2KLns94JcFQQ9fK6bUI4UpYCpGQaoenur2/lQD/rtJtDUKctxtuJVKnzbRpUfMUS8lF3lTSqDEaXJVTz0wSfbQSZD50y2Kov48NWL45gvIHlvtejZukuQDDTw/+KLVvLaitdkYVktuE+W7HEmMGaQBzXo3TQWrqFJ9GMhP6EseT64PFM2HOowOHXhCg++cmLgdj8bNVMqEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2Y5silc1qlxH8Avf3YOx2/4eJMxE7eW9tqYCnyBRU=;
 b=QNltYcJD2Eylqbwm/q5ZbYgbGcd8PICGELA40N2hOfgleI7aJVFQblRAgWdCrw5beTAnjY1KAAQpNVoxBAohjBug4kqcC/MHOZDmeuywqvDxpKWdpQwHFsik/+amW7SH6NNQ4tcufyEGbdjRGxgIU2+wg4TRYHJRclsIbw6audJwkf5PNiSA7QXjXzwf1C6QmA9OzlTdlRVSe+NeWIAcvIv3SrPwU4msYHX26dBnquQjgMYoDyGGFT/McvjNh6DsbeVTBFCdL2B7YI/j73/Zxk78P/IDmX7RWyobZtgiwyuaEQJC/zFbCU64dGMwpKWt2ktMgcN11VelcghxeEX5XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 14:02:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 14:02:33 +0000
Date: Sun, 6 Sep 2026 16:02:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: scx_qmap: Fix pending
 partition work handoff
Message-ID: <ap1yb7oMEFeBNTPZ@gpd4>
References: <4c9a9c9cabc3547e23bae5ae00421a52@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9a9c9cabc3547e23bae5ae00421a52@kernel.org>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bce76b0-ea9b-420f-2309-08df0c1f7f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	b2YaqEwsdfdoIxe0cxEbTBAycCIyMhBXGyC8o+AWWKXl4KFGlTnKhZ9WRDbZ20Az0Glgr15+rzLOWOo1fZ7xBlC6MURM/+NN/aU/nftmS9p+xhgpBpwua/X2b/gEtpPeAvEid7s6SD5E2qYsJqkZskVBkaJnRsTvYIhkmNGaWAiTXHfjDxAMsc5c+5AeJE9PSPhzPkEUkqZn5Z7EpFGrfCrtUycCNt3gtPmJrQyqn9wW0puOAj5KLehXTmunGqMktI6XfgSHKq78kQAMxp2wPvlZMpgb5ZiJ3RiPSF57IZzYY3XtjXfE8WFzIsBUe210RllHH1HzV4yFF4qEpuAOPC71VhibVnCJY/od8Gk2hYV2Oaz6RMwm+DpP5He2hQwglVtekGe8IIFr+L1IFHJTaERIXdXmwke/PAoeYw8UEkO1W00+nPciPl8idlRbOxDQgHfBqAfFmFuKT+cj3lOQYT5T0qpzZnb4Z/WGb9GNgsdPOrzT1e/DkkMjkdVLs4ORGSeZ4DfkqrIWN2Ck3WQ7/iOGDCogxY+D2j4KeBki/wM9pePn62fljTIKykagJJ4emSBOPvoZC1Kha2fwisw0lDXHb2moTTjwGyWX1nygyIXOFudYmXoXuGu1kCsm3Kqg1Q54JhZ2sD1I2yAxx4ofiJlXTtJ0+8vJZ7FRlWnFZhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOwAyK1jaW2Bfh/n8gu+V+Z4AQlHejk5DhVXRhw4CgKZ4ikdqEGeKx3Cxq82?=
 =?us-ascii?Q?SSvZo//ht9e2j5Gf98743s6cQWJH5F4TdXC9tDQfWOMY8cLm4IQCooy5R7Gl?=
 =?us-ascii?Q?WRUFWUE+uUfUttiFG4wlTUZyU6nRf3mMQVLSbIRdcXtGYS+TGuc+aJgb9o8J?=
 =?us-ascii?Q?dt2pLLwj6+ZMGQjQg5Lt4z6AyVjRC3RJ4GlKu1HBeA05AxuB2r7EP83Z9OOc?=
 =?us-ascii?Q?aLNg9NdxgpNWsyw/SzYaqKc5h3UHGuoAeZESEhhFErIGvrlbsRU7YllyaVB/?=
 =?us-ascii?Q?/J9WJCRAAs9vjLwkrK4AFb/dQoBQoi7Z3Vlu5paqW6ULKmrmW9304ajj8pK1?=
 =?us-ascii?Q?3M/OeYRF9IQJPE29A53dnBuy5FA7MuotRj06Ld6DdobCpce9HGLQT1UpxXe3?=
 =?us-ascii?Q?kdFezU3eNLqvc1AeMhc8chFhXGQ70tqw3WNCy3SfWtx57l2frg4blTSHrlcf?=
 =?us-ascii?Q?/Zij+mlufIJ8/9GpTy5m+v2Jdg10x137fl0CDN6ehBbbeyCg/poPEQavSz5A?=
 =?us-ascii?Q?yz7aR7C/ZyL5Dnj1gWz3tfX4YLyb52ua2OqfuusDIYu1P7esrfw7nldroq9g?=
 =?us-ascii?Q?xVNrOhyFNFEZCe8KBaQqtrS60tJsdLliFGt6vVZsR3HzdGIEQGIHe+ilPA2f?=
 =?us-ascii?Q?5/eGPucG7KGT2uFQdbp6AzP8/1KmVDPQU6gjpG94msBX3qJAh8HZOA9cFXGU?=
 =?us-ascii?Q?7tgorcW552zcRIdkhIcybDrpeY+bpQ9QZ8JBbmHaEgBvG55AEdNYjuuaLGr1?=
 =?us-ascii?Q?2VzCPXyL4P5asaeUObOEZ5bye8Hk8vX9eAVq7WBPeaDFXe7yKBerPZfEcQMe?=
 =?us-ascii?Q?0YpY2n5W3xcLnRzgqz/Un/kd8SgcjzzYmVotM5U2TGi3t9zqFZWygtnxsKMt?=
 =?us-ascii?Q?n6pMl/K54t7Xt/eTemOZAU9rM0PWeoXV2K15HnOhCWYq8bgAthi/lezwePK1?=
 =?us-ascii?Q?4UeeJ6hnDalHLoNCbsZHNdBGJ5iWLGdrybsJrNUtaOgyZvIJQrr+zfQPhLnq?=
 =?us-ascii?Q?wUfqtbNG3TwbmWFfjo0T4coqsFBMre3PK+r+1JDbwBqjJg/rBT8upITV7JxI?=
 =?us-ascii?Q?wJU2ShZk0bybQ9SdpIvaOJMU7nnGiESeHrU3NPVU0CHWNjWX5Z/7QpMEPwrf?=
 =?us-ascii?Q?J0rY0UCYHj+GJH4ZMc+pFISE3d4fk2Y33L3gnsuaRId8h8fIN4DQbPFHpJjF?=
 =?us-ascii?Q?3WLOS+U+io+mA6yzofYVqk4Jkmv5HNlzTIFkaxvduCq9lgS5QbzQGATZgyWo?=
 =?us-ascii?Q?kFyP9j9Uex/uPT7d5WocJTHn0/93c0hOGAJfnT0iwCTJIGdbHI+jlWeQky/J?=
 =?us-ascii?Q?8H7+NryE4qC/ABUPfO13l1TofF0EXKZ0w+VKbjTvCtjhLAa3QUOf1FeDp8YD?=
 =?us-ascii?Q?oNkCB+gpZyEYUjlc/Kij27GCwq8bkNFEidEVnah4+AGn9LvTckJ8CWlqL2cq?=
 =?us-ascii?Q?Etqi6NyNU0+y5liKimj/q/2DUd0RoZjz1GzDSrHNherfkw8OC0CUoXLpoLUX?=
 =?us-ascii?Q?3rPyaPSG0EdxzPGe6RNt+UICjSkEQyJQwZcsXMrQ+GgGh7X8oaWPEnHS0332?=
 =?us-ascii?Q?CkKzmzas9dvU7q03jq1sk21gpP/v9WzlGENyBWzeJw9KyglDiHlbUwqjyL2D?=
 =?us-ascii?Q?ZvJ6n1BQmTARJdSYw4S1WKSLSXpHKxms8BKu8CAzciMgDxveHlGBvoNJxGy1?=
 =?us-ascii?Q?pRqm3MlzibdsDUswVtIOXNFVJIop275cO433wF65j8bGSxxI1PxvepZaiNHJ?=
 =?us-ascii?Q?yQQiuCYn+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce76b0-ea9b-420f-2309-08df0c1f7f58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 14:02:33.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/VX6rM37VlDCTFmTP5tjcmJKYVz5bvCU4B21b0WV4hs8SAzxsO6Bzkt82BzPkqFCKK/H/eRt/Jmt98/mYKwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

Hi Tejun,

On Sat, Sep 05, 2026 at 12:53:44PM -1000, Tejun Heo wrote:
> qmap can leave partition work pending with no runner. The effective-cap
> callback publishes its request after failing to acquire part_busy, while
> redistribute() checks for pending work before releasing it. Either ordering
> can miss a request arriving as the current runner finishes, delaying the
> update until the round-robin timer runs.
> 
> Publish requests before trying to become the runner and release part_busy
> before checking for more work. Have all holders drain pending requests after
> releasing it, including the stats flush. Distinguish mask refreshes from
> repartitions so an effective-cap update only rebuilds the partition when a
> repartition was also requested.
> 
> Fixes: e9151ed5c944 ("tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling")
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me, thanks for fixing it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c |   75 +++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 35 deletions(-)
> 
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -1295,11 +1295,16 @@ struct {
>  	__type(value, struct round_robin_timer);
>  } round_robin_timer SEC(".maps");
>  
> +enum part_pending_flags {
> +	PART_REFRESH = BIT_U64(0),
> +	PART_REDISTRIBUTE = BIT_U64(1),
> +};
> +
>  /*
>   * Partition update synchronization. qa.part can be written from concurrent
>   * contexts. This single-runner guard admits one writer at a time without
>   * holding a lock across the grant/revoke kfuncs. part_pending coalesces
> - * repartition requests that arrive while it is held.
> + * refresh and repartition requests that arrive while it is held.
>   *
>   * They live in .bss, not the arena: rr_advance() runs from a bpf_timer
>   * callback, where the verifier rejects atomic ops on arena memory.
> @@ -1668,33 +1673,46 @@ __noinline void apply_partition(void)
>  	}
>  }
>  
> -/*
> - * Recompute the split off the node's held caps and apply it. The contexts this
> - * runs from (the sub-sched and cgroup callbacks, the rr timer) are not
> - * serialized by the kernel, so a single runner does the work. A caller that
> - * finds the guard held leaves part_pending set; the holder drains it before
> - * releasing, with the rr timer as a backstop.
> +/**
> + * execute_partition - Run pending partition updates
> + *
> + * The rr timer is the backstop if the loop reaches its iteration limit.
>   */
> -static void redistribute(void)
> +static void execute_partition(void)
>  {
> +	u64 pending;
>  	s32 i;
>  
> -	__sync_fetch_and_or(&part_pending, 1);
> +	bpf_for(i, 0, 1024) {
> +		if (!part_try_start())
> +			break;
>  
> -	if (!part_try_start())
> -		return;
> +		pending = __sync_fetch_and_and(&part_pending, 0);
> +		if (pending & PART_REDISTRIBUTE) {
> +			/* charge elapsed time before repartitioning */
> +			account_alloc();
> +			compute_partition();
> +			apply_partition();
> +		} else if (pending & PART_REFRESH) {
> +			refresh_usable();
> +		}
>  
> -	bpf_for(i, 0, 1024) {
> -		__sync_fetch_and_and(&part_pending, 0);
> -		/* charge elapsed time to the current partition before rebuilding it */
> -		account_alloc();
> -		compute_partition();
> -		apply_partition();
> +		/*
> +		 * Requests are published before trying the guard. Releasing it
> +		 * before checking pending work ensures a racing request is
> +		 * either observed here or handled by a caller that acquires the
> +		 * guard.
> +		 */
> +		part_end();
>  		if (!__sync_fetch_and_or(&part_pending, 0))
>  			break;
>  	}
> +}
>  
> -	part_end();
> +static void redistribute(void)
> +{
> +	__sync_fetch_and_or(&part_pending, PART_REDISTRIBUTE);
> +	execute_partition();
>  }
>  
>  /*
> @@ -1708,6 +1726,7 @@ int flush_alloc(void *ctx)
>  	if (part_try_start()) {
>  		account_alloc();
>  		part_end();
> +		execute_partition();
>  	}
>  	return 0;
>  }
> @@ -1765,9 +1784,7 @@ static void rr_advance(void)
>  
>  	part_end();
>  
> -	/* a resplit queued while we held the guard supersedes this rotation */
> -	if (__sync_fetch_and_or(&part_pending, 0))
> -		redistribute();
> +	execute_partition();
>  }
>  
>  /* advance the time-shared cid pool every round_robin_ns */
> @@ -2041,20 +2058,8 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updat
>  		cmask_clear(cid, &qa.avail_cids.mask);
>  	}
>  
> -	/*
> -	 * When another runner holds the partition guard, set part_pending:
> -	 * redistribute() drains it before releasing and rr_advance() checks it
> -	 * after, so the deferred refresh lands by the next rr tick. A
> -	 * repartition that lost the guard to us runs here.
> -	 */
> -	if (part_try_start()) {
> -		refresh_usable();
> -		part_end();
> -		if (__sync_fetch_and_or(&part_pending, 0))
> -			redistribute();
> -	} else {
> -		__sync_fetch_and_or(&part_pending, 1);
> -	}
> +	__sync_fetch_and_or(&part_pending, PART_REFRESH);
> +	execute_partition();
>  }
>  
>  SCX_OPS_CID_DEFINE(qmap_ops,
