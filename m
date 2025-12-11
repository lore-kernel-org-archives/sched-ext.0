Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947A1DDC1B
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495658; cv=fail; b=nQnnTATOH7933W77BtB4X8oNs9AJ2GX/wf+YjCbCHN/ScNxtMaxN59CnUrNQMFhCK9Jx6qiTIc0TIYVp72s7Y+t9eaAIrXDSBHQyS0fY43FKPFO+GEo87+rGAuDwyBbsx2/MSGferTudJLcdkFGIn7SkmhQwHE/HsaYtGHSP3do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495658; c=relaxed/simple;
	bh=V8KFjRMbnYlvCvaNfOLfw5T9IrRYAVwOqgLsg8M/TdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ig6fH4DAdQ1FVWgIHnlPsiBmx+e+A/JFS9kAL3JR6ORaJGT6uteLNkMazYp1YZh+U1KdjJF0IY/o+LamZCMski31ofuxu+KN3QkcTXLwoS81wMxn24ObGv3mVVuvAiYRm4n+d7A0Ten2XsCAZU46Wyen1X/Dw8CA8ZGpchbQRg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNc/FNdC; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNc/FNdC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guoapJdwFkrc3u8GHP1l7gX90pxingRb8TXBJ8qeSKCPrZ+zKCB5pdH8Z5PNz4uA2kcBba0UrxqY/YIfFr3TapGbeDrXMag60oH3yM10+x7RtN/sRYu30zurIYJ6AS5OYiEcY/EvD3Q4Ie3qXxggy3XEDbiA4iKJh9tLzayT7vBs4R7fBFBbKOyhISDnpy+mQvKh6qEHpFOc4c+qaDgeM6TyWofC9O2CBOlYvC6FbnE3OgALPxzM+kXMOi/1Eq0+uGigoWeYife89NaOuQ00gVrFpZVOZz5Z9CO4nCkuT8PY9n2JNF7yd8GnSZLlt/1aa1w/YCQ/xRNY+G4B1tznjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2FsDc3telb+tMqfI2p0GzNnyidTAbb5shz4hnHykcQ=;
 b=NW7BiHrp6ps8KstqtwIxEuUFyZr0b7rRJXZQfBoSCt6CiSmQsZ2PsOyqwGHjsmQRty/0H/CHJLZ6du0q34rSKbCaE/tAxjMjxyyxT8VFgT6Q42FyO3A/4xqVFUxdvASOQk8KohSXHyUEB07WeDpvFrdkeoLNHPztYC7u52fJoj5mePMJs8adjbLH7/lneeuCtzD0g5ajlwRP6wV/0q25ZCLrU9YuWziGFUokxFZPjo3k3eS7jiBzqwwCat89nvenn2EBpf9uA0v5/FmQdAyML6wqYA7cJISuwEKr+XlOU//o8lZ5U6AMLmZ+cHGwsL9nR7/EttoueGcAHTzUGzPGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2FsDc3telb+tMqfI2p0GzNnyidTAbb5shz4hnHykcQ=;
 b=GNc/FNdCdU22YTvhqQSj01nTZcOAIUVnB+v9ehi/uE5eIpl27ay0AORjJFCY4ED67eoKYKztRw80ju6aEo0iCyvl/x1VpsFSg+tNl0QIPR3DVD8xSKcsPSDFm+Rch9CE8bNRi7JnopWduLfENsps+VrtCwsoTyENrJ4J4sJoN3SM/ja76wicBn206GdYcsPgGUum/4T1rd11wTUANhWEvNu4DfrAQPcxQdWVleqBYxLdioeY3Z8N9bK/GQgWeNl6/Y1Iwo19uSa35PSd484cvjGTLi71W1UGYHc49SLLY2szuac7K6M+SUd1e8wXSf7lLUxIQT/lYLB1FSBPIa8cLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 23:27:34 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:27:34 +0000
Date: Fri, 12 Dec 2025 00:27:28 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()
Message-ID: <aTtTYGJ6XxDpbmob@gpd4>
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251211224809.3383633-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211224809.3383633-3-tj@kernel.org>
X-ClientProxiedBy: TYCP286CA0274.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::10) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4cf605-876e-4eb1-d9d1-08de390cdcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTbOJTMN51jMjxtyqwdjC7bWaqcYJicFh4Ze30fNFk8EK0yjWGPQsvDrKb8B?=
 =?us-ascii?Q?q8gOKnsU6ZG7S0av6aV+mq8e6aR4LMc1baCdk9kzLr1ijgYObV+ssOdV3uuJ?=
 =?us-ascii?Q?oaAJc1hOBsQXM+hKvxqLWz2uhHLWCvf1/4PtzW5oZWmCR5anEStBhGtcpALd?=
 =?us-ascii?Q?iX6QAS9mcKfUFDJKrYL9hvTCT9hCmfpTt26Bx8vCV9/ZLuWT68BKT4oY/xQP?=
 =?us-ascii?Q?Rom5kqkH2r4GWIjn94nc/7dcQ9PytiGGTiMAaa1JdjgZBuUXlwD4GFCtxiVN?=
 =?us-ascii?Q?PufE+oNg3AFmLuPCTd+mT3jcu4dTaTLvN1Squ+NY15aQSj+WWA6/DpuQSp3U?=
 =?us-ascii?Q?4kwiQEvCLzKRolgOhCyqiI58zDaNZshiMPVHBUtv8WBBCyHVx88gbGCr4vGP?=
 =?us-ascii?Q?ustEpyc3dh14/uSv9QhzVfTYldaH2aRYh7CslUYyMnVLP96YK4CMVUC4I+ei?=
 =?us-ascii?Q?ZjY6HtwLLWUiEVD2dP2dWc3bQ2wLBNZMGy4M+gZmM/LdTN9AZ/4ZzT9HGSOh?=
 =?us-ascii?Q?YF3Vutsbms4UdsOQcJPf9sABbWS9Bho1xCPiT/tnL5kQXbsPj0JEG6mRZkSe?=
 =?us-ascii?Q?d0mYI6Vbc7AyXGVkTagr1uhr5mMm/MFvQ3BxMcJ3UpoB9+NXOPAd02SUVTye?=
 =?us-ascii?Q?WNTfnq3XVCks66bw3yM5tiQrv18cVDNfEamZ15cpxk1pGVUOqYenz7r6NuvM?=
 =?us-ascii?Q?xley+jDin7els1prXsjckIZr8mEDccXq1H0mMFbG9da3FqDkHagSDGVPvl0Z?=
 =?us-ascii?Q?hD0UXo+aWZIbRqzGf0E6u1Q0vou/Lr8dvEblX/v7Upe+0/5hV2LcMn7aEwi7?=
 =?us-ascii?Q?WhG/PrX++fE0Ml2mhiM+qSkxvBBbIlKfHCoUhVHORhLOAEC2Kv0Nee5Bp89f?=
 =?us-ascii?Q?anzL+a96e53q9TCCfEXphtivI9JF7Z55LpnK1Qatrx6YQpdtChpgSZaKDx99?=
 =?us-ascii?Q?7LTf1rE3SET7bAUK/tL9Vo3Za0Jypi0V8QAnGTwvwtmbriDiCgipCjfFkDz5?=
 =?us-ascii?Q?ccnW3mSO/9TvJ0NBxvtOr1BqhVt8SUOFj2SH22KLFTHgrI5/L9rGHSC5DN9P?=
 =?us-ascii?Q?9P2RXy4WFXQsDClmujus0/HtXPnJQjKIs6nV1M6CVyIPbJWmU1dtCkKp71/K?=
 =?us-ascii?Q?7pLi+1sgUo74I2zECiXmOFPKxDr4gNbotQ5I+I9oUoHoENKAzPxvRrKkdOz5?=
 =?us-ascii?Q?6CtcOWsAprJbKArOSgiYpzo4WnJIGNeQIjnlwjPDCGq6UlaN8WtpcR09LUqG?=
 =?us-ascii?Q?pti2LxhXU5ElAiVzBQ+oOAe6dI/xfRgDPIVpYtaz3l3bEMGHtV5UjF27ijhm?=
 =?us-ascii?Q?5gLegD7YbR1Se3BO7TWvIVbGSXvHaMYrSAhcQX/4v6x8uf9bpHml9iiA5jvW?=
 =?us-ascii?Q?9ODLIerOul/ZmQu4zPXBwdgvYj3EMphUgWkXwQEx5Og3noy13GCYrnP3WgN+?=
 =?us-ascii?Q?z+mgvJYvM209rI+kSOpLGAv6o6yPG677?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeNe80ytD6d+ZaoFRrCQFeY9jHee3NQE0/mlr69oPDHxpAVA/L0AUyC/4A+B?=
 =?us-ascii?Q?wg9DAtqNTPQXxugLkdYMEFtlQBY9E9CwIv8hqNjRNT91dpdv75dNbDkNtYSO?=
 =?us-ascii?Q?xbTZlP+PikzA/pX6Gf+iZ/JwRo13XdwzVuM5JpYGr+GJOL03ajnlQ0LbPTkY?=
 =?us-ascii?Q?HyFn9+td2k36a60s2IsS8uHHzm4i0iucfhvIZn8AGN9FIh5YI5GpfjT5zd2a?=
 =?us-ascii?Q?YZjwM6rP2q0Kr+ywU0WI9fjzSksknmKHrwdR/5o/+5C6OSK0yXtyQhC+1r8h?=
 =?us-ascii?Q?em/7yBDc9NNPmKis2uFI/zgi4xuda0z6eA13tS1EqoyAbKR+/MZK0m/EbMKd?=
 =?us-ascii?Q?vEBVGOjbX4493dHmObKhxYi5HIFfopeAX8t9ZTEy/M/j92gJ/dffOm69eCPv?=
 =?us-ascii?Q?V7KqfppCONIW8x3lk8bdvOk+uIzGi4Pzacreu2MfPGLnxORSqtYTb0l1sEH9?=
 =?us-ascii?Q?VuViLVmuK27qdYwsZx0d8Q4257Tm7WMYYyn6z4R0V35zAw3LouvOV0oZJ34w?=
 =?us-ascii?Q?3rBBmEQC7GmR3OvUBnuAwguny+wf5Xc8DIQgNvAzQurniw5oE9A5QMuil6gY?=
 =?us-ascii?Q?l6SBBG7zltL619dR+gMupXRlMTYLizQXbCrNGib6WThiteThjCBYjhLfrxvR?=
 =?us-ascii?Q?35CAB+p8qQGRQf6SqyaVHXI+w7JogZS9zD13fsUV8PJFZFcT8h9JRHqr1J7N?=
 =?us-ascii?Q?qw6sFM3jpvrEUE7bbv0KRctQN3o0X8cqBrj1hBJGZE/S/cXNnWvCvEGgvC74?=
 =?us-ascii?Q?C9yE0FdctdCyM9zoY0kXklwyb5ETEOsGmbeX/wZQO5cKHA1ipSdlTE7JKkae?=
 =?us-ascii?Q?zPeeQha/Y7wlTUAiHfNnig+VJFkw6kJPTiZDbN+Yw4jfDu0w5kVLfybxZ63X?=
 =?us-ascii?Q?wE3uRXPsk/HemnZy4TOR7bVfL2EtIG20H45y6wwtUf/CHVAfPsKKh9aoLiWN?=
 =?us-ascii?Q?EZMYUjVqQotBoaNVM8Gk8xFqFiox/GpkB9WZSvotiyBDIGhZRzEpkRw8tngQ?=
 =?us-ascii?Q?yGg8xUsziHP+5xPhKkZ0RCAM8ZD+rL0pkWT6qbQCUa4oqPH8fXkevpl8ZrTS?=
 =?us-ascii?Q?/NrOgyJJ/QlUyToaqMtt14pTaT0jh9r6ADHalvYEN9MLHpXsf0Lj153ChuhQ?=
 =?us-ascii?Q?nPD2++yWEWq/1cmgBNL4NwQ/ALH8j5ZZk4EYMNh6dlh/VLloBaHO1u6YdcZS?=
 =?us-ascii?Q?Hya6WZcV5nfyWl1MgAAQVarQqJZUjWHSeF8KtTGlYvhSw5UCCa57AZCFW3O/?=
 =?us-ascii?Q?Jold36vvBFEfKXf2gjadgB2TD5N9Mdb+79cMWCQfI6S8qMfh3cJo7gkbBOTe?=
 =?us-ascii?Q?iia56vL+o2wxzGYBnaLDdo9BlPQyOdykZ8NsFCBayN3DpJylj/v3zFd7QH5h?=
 =?us-ascii?Q?RKmqz+TjHkiS/hIFY+lvSpR01+NmfWftKD1Bm+e1wPy/Efar1N6yWal5WSp7?=
 =?us-ascii?Q?7uOuH30sZJgZ+rdEFmSA0QtistUuzZzAbNkbnqS0/xaOXr5/fcl8z102jiJG?=
 =?us-ascii?Q?X4CkreoP4tiHeIhYZfkw9CeihL+jOeXX5pBBdT9hFj047GH8bZuOzb1j2aCe?=
 =?us-ascii?Q?50JapRRR3IHnpiy8qHApWghefXpWDDNjaYpfOANxxap4CcJc4/W6E+YG9T47?=
 =?us-ascii?Q?6/0NYQ1koTmPl7OfWbGEuHxVqdIyJi0oVZzh2kWwm7to?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4cf605-876e-4eb1-d9d1-08de390cdcc6
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:27:34.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooE4gfSPVUw52uSMK0mPbBKWGXquYSfVtoQeJBi9YrOidsBFZRrcjoSYvqO2w8vQUjabjtFFyJxfM9IiHIMB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

On Thu, Dec 11, 2025 at 12:48:09PM -1000, Tejun Heo wrote:
> move_local_task_to_local_dsq() is used when moving a task from a non-local
> DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
> without going through dispatch_enqueue() and was missing the post-enqueue
> handling that triggers preemption when SCX_ENQ_PREEMPT is set or the
> enqueued task should preempt a lower priority task.

Ditto, lower sched class / idle task maybe?

Thanks,
-Andrea

> 
> This was fine when the function was only used from consume_dispatch_q()
> where the CPU is already vacant and looking for the next task. However, the
> function is now also used by move_task_between_dsqs() which backs
> scx_bpf_dsq_move() which may be called while the CPU is busy.
> 
> Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
> dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
> early exit to keep consume_dispatch_q() behavior unchanged and avoid
> triggering unnecessary resched when scx_bpf_dsq_move() is used from the
> dispatch path.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -981,6 +981,14 @@ static void local_dsq_post_enq(struct sc
>  	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
>  	bool preempt = false;
>  
> +	/*
> +	 * If @rq is in balance, the CPU is already vacant and looking for the
> +	 * next task to run. No need to preempt or trigger resched after moving
> +	 * @p into its local DSQ.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		return;
> +
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
>  	    rq->curr->sched_class == &ext_sched_class) {
>  		rq->curr->scx.slice = 0;
> @@ -1629,6 +1637,8 @@ static void move_local_task_to_local_dsq
>  
>  	dsq_mod_nr(dst_dsq, 1);
>  	p->scx.dsq = dst_dsq;
> +
> +	local_dsq_post_enq(dst_dsq, p, enq_flags);
>  }
>  
>  /**
