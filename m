Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B353C8708
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306605; cv=fail; b=tid2Qvv4AQnZW/dbBVtiGT8E6vMU10x/OCMiJ8yIrRVRNeeRUX+0QFrH4OvTL+EFKnJQCuC+3bLemC4IPfiTb/zszyjAzZgNJaccQXJ1bCWX9NyxZF48QnQQIW+FQo9F+fhEYsstiuiPqnnPWlJuXH3X78Jy7FUEdVDrFka9L8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306605; c=relaxed/simple;
	bh=aFUOe+JXTWCJq0XQCpfMO5oXFwfJk/h5mqoGQweiSSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJ7DxVQ2y9wrgMY2ogs5VEnqDtP1JtnNOO1VeFT8dvDT/1gpEH9g4I5ZhXvxOoZslKEzSSYjTbcUmKyWe2eeZI3eFTW5XbR4fbkkS1bxbZfozHo/BV7kcsrIYOCfWixsWIPx0OfCXeCvOJYcKhr/kGe5NMQcm3+avdecJt7OL34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CnCU4l/P; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CnCU4l/P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxlg/t7uS7pT0pkMAdOgjHWd4wUn0C5Y575HVdab7+/0ZXD4L/fhAWpfETycqXWJpCYqh4sJUcsc5fuL2MEzFR5IC0tAJd0mC6WVU8FxP5P9SIHEpSl7bJcY1xcU6lFykA9lwxsJSrCs4xTel2TBKNf6dhIkPJJyrO/SMEuM5xlfCman6EPlply091cnoqSvlrBCFwS+5amw6n3Y4XyiB8zfFWY+iXXtQzXtcaIuwB/OXiG2+I/oZF+xtCPKYFRDwjnG6+aH5QnFKXMHdSTsuaZpmljP37EpQXNb7wn01q6gFnj4JcHLP91UCSQgSCVuUCAeCJjvrGJ5+DC9AjpKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNqIshL4PZavcQXmdThmaAf/uBPz4cUwtXOzKoZ51DM=;
 b=uU+dplgW2xoSJgIznWyPnzmnan9az69EdX3yZ94B2cKkA9rmMCblCghmpbNE2t2608nbC09LvmS4VnNZQzbFT8Nq06o7UXn4P2Z1PObP+Anlpep4GXn/OruQnUcBiaLzewCEwlO36JDOeVEyZ0wnZ7ft9lWY1kVIqa7sUGhb9SG71WXndFGynhpXi5gWgrpLMCTZLKc8UvlrBulfIVLDHnZijhL/rfgMXbtHeG+gfZ63Sf1o2IBCGLGW/v+XqxgUPf1Vmaa5jXKjHqycov53c2ECuE4pYDi8uHZDHAMK8fsKK+SScpRTqyIIvvbOYQsiydZv5xxjjdAVUCi7YtTg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNqIshL4PZavcQXmdThmaAf/uBPz4cUwtXOzKoZ51DM=;
 b=CnCU4l/PCOuZaSDsVbGttn3OFiWlWH05gYP95wYZrUpwNSbfchh5ttibZqWRc8isYs/xenX7ryFKAuopoaSiPpwIty97moaTsdSdR5kFPO/givkVbsnOhRxx9JIvGHmni4/m+Ung0Dn0DA4Iiq0OWbzI7mMsBp6AN6HN2itoBkYd73LUnoCfKo5aICv3CrNp0RUuSDwCDxNc94OquF/0TEQSlR2AheIHG8Si8rScbqHk+8ttrLGVA86RPljZgSSPs3oRd1VAqA81MQygc/YGyt8nbvn5O9tiP7e+MATFv3c2f73smhWocP4rhQYvRMn/DhcvyeFRtqEaRUlN/DW85Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 06:56:41 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 06:56:40 +0000
Date: Sun, 18 Oct 2026 08:56:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: Free a sub-scheduler a grace period after
 discarding its ecaps syncs
Message-ID: <atRtoSdf-c87N5tz@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018015952.1499528-3-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: a550b698-3d35-4d5b-81b9-08df2ce4f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|5023799004|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iKfU0g7ME7TCCOyq5/Yaq5ruYJY2ZNlJvxTJu5q9OtIzMc9Xg2RhqmWpT/TD9uhpm07sWZNyS6FrNXX5y4AX8XCmR5BDNixYB/CQ6V9FxW9NxZlo8nR+OcLQp2mqu6yXq9eLfjnSj4gXORWG5qWLD263vmoN7lraiCVBCHhp0Kq5NjMzm0kmlNJAWHChtFAI/9vKmL8eDNGtvO97puKxbUDqsDsEJeoCceNowFhpQvsnF68+7ab3lE1ZZrym7xUcsY3wshjOr+wRp563sxcBKibHaQ4fymaH9jGhRyBqMFh3WlouCIqe+TjJIwo5kZ4zYxtNDV/eqfMXQMxwxeIh3xt6jYp0UwF0LyCUDycY2SSDUR0/dnkuQpdE3EVhmFNnMzQAbXDtqIgdl2cebz1hWh5yM+AR7aDl8CaXyk+k2ytQWjsLBdaCtgkDON2olfTP/zdc2kK0zfAgpWAJVCcshtwX/Rjw4zbYreo7ORbE0a6zTmLEBqijsPc9F/84BoU9rkRBJldyGFDmFcPaqr/Wf1UC8/S0hBTdYsfcYYNPDg+dWpX2P3ifV1TTuxgBmQw/dgcVw+/HA3drzQgLL2mE4MHHZaG4TfHYexDMjYFwaPQXwWv6gsJjylvnIISOjFP02YYUDT+htCY0L+47dMPlbpZ4ihLpeDxxR83GI8hEljg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFuwcBKl1OwMc5DsvfamvlN4/roW+e2jfFDxPHBjaiDfCb8hekE1kJGaroK6?=
 =?us-ascii?Q?SgFdglSMAxR366b7g3ebKgwF34/zRaPpldWON/YxNbnNS5JSwyCF4YiBluTZ?=
 =?us-ascii?Q?td9RoyQiH6PMJk4c89knP2djrxRReOkDn+uOSSpCDhpgJhkuWgZJOb3N7GyT?=
 =?us-ascii?Q?3fKvRgrSgk9iklVICr/hD4xtGa1pWpnveLCsKFYOnaK08jmucmur4jUG/fJ3?=
 =?us-ascii?Q?orAE7+rB/b5+zIjyqf5AdlTJ1t7r4MZjOFpwjQ08aMh9m2C8NeBwNx1HZXXv?=
 =?us-ascii?Q?YP5J3H/CrelWHtzir5RcSapFwqGwD6+FyW3+uG3/Dn7YOOST7lGRmb7LvYXf?=
 =?us-ascii?Q?uUA+MOzKwrGQwZNtDEQ6UKz57BKLkPAS9m3B/UqINz4nhxudKC+Q9IRfSZmi?=
 =?us-ascii?Q?TTltWGtorIt4nzUux/gaUpwSKPvZtqrGKlrJi+BA1zPDRl0Wq5kshM9Z8Bzf?=
 =?us-ascii?Q?NXT/ohAeuREaqLlqiEDR0jUjWUV5ylQzJVIcW2diV9TCHzYA7UtLUwWDfBdp?=
 =?us-ascii?Q?HC1Awrd1VzDRf+vtmDyky/6W2QfcfInvYnngdepDhDCNFjIUTtToNsHhqffB?=
 =?us-ascii?Q?YeIJjEtBJi867ciyjGd0//x0OIal0bWzmXSxGJevjmlrBURQlynlOShEbSDq?=
 =?us-ascii?Q?/H5gy7akOmVfyXhUazIzRHlWp+PjuhxjzAm6/Pad68jeLqzzFmyb2laozhcx?=
 =?us-ascii?Q?h3i6CgEpHooiWd4Lzg0EmwgjaSlUMwimvEKaPYGhUnOz4KcU2uHcmpHFfKIT?=
 =?us-ascii?Q?IUtXQkwvcugpieZS+L6SFOgqG2p5nksc7WOcr5nZjXnIF55cs4bD96k1L9DZ?=
 =?us-ascii?Q?C3OBwPx9U+2Gh1sRW2/gRaVmFiJyQzrO25N4Kh6tb5V/LAGPbVKJtGzSGrL9?=
 =?us-ascii?Q?ZbE8GYRao/fw4TJyoEXpbUcDsgan5aR+Wt/mPkACXicVMNymnbY+7HdzqEJU?=
 =?us-ascii?Q?xG5tYnGQQI7NB2awTJw+9YjjT79Muk9Zn8IwPcsaHmt8FV/49j7X1+k/g1b/?=
 =?us-ascii?Q?joIJ7YHzCfkUGUtfXCJs5zunW5Bw+qHzMXlBR1lwTr4WBdEf5xE5/6V4mXTp?=
 =?us-ascii?Q?zOqPs6YsAA0SJ/1vCVgXJlY9ke8MPsRMMU5uivs+bjpgU3Jlf7unTqMVeifA?=
 =?us-ascii?Q?7CzfqGwO9mt8MbQdFQ3wPwaT6beUvyoUJRbZYlZQRWKuVuGxij3QFfXz/QX3?=
 =?us-ascii?Q?9QF9UHv87s3xTXi5yOJ8qMNgcQ2mUjIsD4w4znzsWwNN6VeeDamMM61GHfKO?=
 =?us-ascii?Q?CLq05o1eoK5xDjRAFgCOWBAkzBIa2XhcPomlwx1E1MOns/+UOkPeGTDzJ9j6?=
 =?us-ascii?Q?1bgcOFsDzrsSgqWjOQfcO/hh+V+mcu/jIUOYITNphM1YnwPT5GwRDmrrl9+k?=
 =?us-ascii?Q?aF2Femx0xZViPhg/Nk5ba9M5zJ67+ZU1qhhcXBA4RIYkNltt2tXF8PB5a+za?=
 =?us-ascii?Q?R/9Ue4NxQsqrwWii9Ff6UtPcU1d7UwNWIKmo+JTAJvuaZKa+mr4XzDfSqo7g?=
 =?us-ascii?Q?4Z+vaf7JzZiHTpkiRToP6KWFbD8Z0Z1RAodXpvthvDZ+3gMqt76ZZ6i6jExu?=
 =?us-ascii?Q?XjV/hypjPwVeBFdmfekVs50kOqZmCSH+9Q2Rq21tnAepqV2KJ2XyY6DZPq2/?=
 =?us-ascii?Q?4vbXZ+ZBgl/TH5c4V3w77eyxKt1waYy0LVYWFiKnCSbCGEWILoWPc3LnT8s5?=
 =?us-ascii?Q?G6gB/nf/K/q9TxS4M+yN3HWXJDVhlwCFKwXTY3TwTTab4+rhNRpYDOwjK9NA?=
 =?us-ascii?Q?WJtV50Ga9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550b698-3d35-4d5b-81b9-08df2ce4f62f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 06:56:40.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc9f50s6U79jr0DS5uMYcoLtpP6Ymz0KpgQhLuoiB0A4wCp2FznpkG1WcpOdtRxjiT/hXmaFzuMbTY7fjgvQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

On Sat, Oct 17, 2026 at 03:59:48PM -1000, Tejun Heo wrote:
> The free path removes a sub-scheduler's ecaps sync node from each cpu's list
> and then cycles the rq lock until the node reads off-list, as a sync batch
> can hold the node privately. Cycling the lock is correct only because the
> sched is bypassing and a bypassing sched's sync calls no op, so the batch
> touches the pcpu within one rq lock hold.
> 
> Tying the free path to what the sync does for a bypassing sched is unusual
> and brittle, and it gets in the way of changing the sync. Delivering ecaps
> to a bypassing sched or its parent would break the wait, as a delivery drops
> the rq lock.
> 
> Wait for the batches with RCU instead, the usual way to wait for lockless
> users before a free. Discard the nodes after the first grace period as
> before, and free the sched after a second one. The first grace period waits
> for the paths that found the sched before it was unlinked, such as the
> sub-cap kfuncs and the cpu hotplug hooks. Until they finish, they can queue
> its syncs, and a cpu can take a queued node into a sync batch that the first
> grace period doesn't wait for. After it, nothing queues the syncs, and the
> discards remove the nodes still queued.
> 
> A batch that took a node keeps irqs off from llist_del_all() to its last
> pcpu write, even across the rq lock drops of a delivery. The second grace
> period waits for it whether or not it called an op. The exit and disable
> irq_works, the helper kthread and the bypass load balancing timer are
> stopped ahead of the per-cpu checks as before, so they move into
> scx_sched_quiesce_rcu_work() with the checks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 7edad2ddaa54..1923bdc33d6b 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1318,8 +1318,10 @@ static void clear_all_caps(struct scx_sched *sch)
>  }
>  
>  /*
> - * @pcpu's sched was unhashed before the grace period, so nothing re-queues its
> - * sync node. Remove the node from @rq's pending list so the pcpu can be freed.
> + * Remove @pcpu's ecaps sync node from @cpu's pending list. The first grace
> + * period has passed, so nothing queues the node again. The second grace period
> + * waits for a sync batch that took the node earlier, see
> + * scx_sched_quiesce_rcu_work().
>   */
>  void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
>  {
> @@ -1327,43 +1329,28 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
>  	struct llist_node *head = NULL, *tail = NULL;
>  	struct llist_node *pos, *tmp;
>  
> +	guard(rq_lock_irqsave)(rq);
> +
> +	if (!llist_on_list(&pcpu->ecaps_to_sync_node))
> +		return;
> +

This is called for every possible CPU from the free path of every sched,
including a root without sub-scheds, whose nodes are never queued. With the lock
moved ahead of the test, every scheduler unload now takes all the rq locks with
irqs off, which on a large machine can be a lot of lock traffic.

The first grace period has passed by now, so nothing queues the node again, and
a node taken by an in-flight batch still reads as on-list. So, can we keep the
lockless test in front?

	if (!llist_on_list(&pcpu->ecaps_to_sync_node))
		return;

	guard(rq_lock_irqsave)(rq);

And the WARN_ON_ONCE() on SCX_SCHED_PCPU_ECAPS_REPORT added in 3/6 could go
above the lockless test.

Thanks,
-Andrea

>  	/*
>  	 * llist can't unlink a single node. Take all queued nodes, drop @pcpu's
>  	 * and resplice the rest. Nodes in the taken batch read as on-list
>  	 * throughout, so queue_sync_ecaps() stays correct.
>  	 */
> -	if (llist_on_list(&pcpu->ecaps_to_sync_node)) {
> -		scoped_guard (rq_lock_irqsave, rq) {
> -			llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
> -				if (pos == &pcpu->ecaps_to_sync_node) {
> -					init_llist_node(pos);
> -				} else {
> -					pos->next = head;
> -					head = pos;
> -					if (!tail)
> -						tail = pos;
> -				}
> -			}
> -			if (head)
> -				llist_add_batch(head, tail, &rq->scx.ecaps_to_sync);
> -		}
> -	}
> -
> -	/*
> -	 * An in-flight scx_process_sync_ecaps() batch may still hold the node
> -	 * privately across dispatch-induced rq unlocks, reading as on-list.
> -	 *
> -	 * Because a bypassing sched gets no op call, init_llist_node() and all
> -	 * @pcpu accesses share one contiguous lock hold, off-list under the rq
> -	 * lock means @pcpu won't be accessed again.
> -	 */
> -	while (true) {
> -		scoped_guard (rq_lock_irqsave, rq) {
> -			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
> -				return;
> +	llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
> +		if (pos == &pcpu->ecaps_to_sync_node) {
> +			init_llist_node(pos);
> +		} else {
> +			pos->next = head;
> +			head = pos;
> +			if (!tail)
> +				tail = pos;
>  		}
> -		cpu_relax();
>  	}
> +	if (head)
> +		llist_add_batch(head, tail, &rq->scx.ecaps_to_sync);
>  }
>  
>  /**
> -- 
> 2.56.0
> 
