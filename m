Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11737C92C
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794426; cv=fail; b=WI4BZdEq8MIS9Sb2/FkfCLK4IicgCXNK0C73+abvhxRfKy0RkpeoeUd8BkmKPBJdxfyeWAVDaOolNWQf7jt88x5ZdPF3c9+pyVnO74IY7YWXX1KbxNDLfKWyT4wkbT9ATXXbft+xflIEAu0BHMZ7hBazRpRTfJJiZRtGGAJ+jtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794426; c=relaxed/simple;
	bh=eWJidRcJSPu92GZD2VKa2O4gRL4k17hulofFYnEHnR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SWCmnHo9t3G5bOqHaKte4afcgxFbygegAqmyGgSZyF8b/itb9zxCYjSttxJaQQrDqdaBwsSwdCYxjeFmWu66CwIdsuGR7TfQHCwPGnbUP/5+FKetXf15lIsnfIcybQGClXtWveq2EKMbICU6aN/S1cDzPYV3YuSaXBGgPS581fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0qhBI4a; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0qhBI4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soJYNGiD1I2sjGT6z74nHJcwLUmRHbrpeIdXw+/dkJy8bTT2FLyaEQdyFEL1xeumIN1RdDt15bm3lCYLBfzUbONb/OvRf+o3L8BPvRZrW4xb/Dz3qV7vSpETQIoz+H44jxNANjriLbjSpSzWS6Oj2JPbabZVDJWECDF8DRnodYirYDwBDIanKlJ7yFAMltVICJQY9S00npF0gUlNUG0rz8fYX6beyO2HRa0pob/dy5xTu0ZzOTlb+N9tnz5Ll/8LS6VMHGOFKcWek/RGkFGcuKhEZYiMGwxK9vXXbYrNQHdtl7d77KaUxB3t8CmJo1Qunb5xbk0aiSa1v9l3YP0B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+HUs/X9Q48fgd392KroiBGebYMB0PObgRYhjTx51zg=;
 b=yrbuRKmvMaj43trj9l10d2oeW711c/uRk6qtTPjR/P1j3XHDLTfklNi6ls4Uw1mtPvWGuoTkznwMiN5PZokSglbnDQWaXJW+V4TU7U3BE9nc2VBXG461SBQ11vX3sY6H4LktOpajBnp2YIXzaiIuDooOWdAyOvz81BkoeV7TjLw0TY+ODTxjX8RiQ5DvyJHRC5wYWGPakA9p5SQHqK95XLRiFbCqhSby5cHLmpPK48XPh6N6whxnpxIuZanPaL8H5l+gFPFlAZJaFrZib+/8ybfnOxSAlCPbQz+RSH4KCF4V2EzA1NXWnkiHm/tAQmBsgByvKLzvoVVxe4POnznmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+HUs/X9Q48fgd392KroiBGebYMB0PObgRYhjTx51zg=;
 b=C0qhBI4aKO1fr/7eMvVEI5W466i7A4YeWW/jde1javkXhgqETRb5xsARuYflbGKjmVYFTZb7r2Huuks4NIKUVDpDe4meJsdvZ4h3WW6mJYN7I9ih9cs6wPlxVv/Z+a5to2rd3qSiM6mFmzSqU+WNG0p6xWYXAxiDx7UOS9qL2WyotZxKROUWkEkq6kt+hgSta673MaLawaXFu1OQZdtADPH62etFGWvNqcLs3Ru5ZMUDthFJEFT2ywCPmm3iA1Ie4+Ka9JOSbxpchuf/gJsqlOv1N4K7u+AqPHHtm9kpFrIL2Gx24mUHT4S8sc00IHMDKnGJ7L3+N1oPxq26mseUrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 04:40:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:40:20 +0000
Date: Tue, 30 Jun 2026 06:40:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH v3] sched_ext: Don't warn on core-sched forced idle in
 put_prev_task_scx()
Message-ID: <akNIpkhGj05-1KLP@gpd4>
References: <20260629225548.3562257-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629225548.3562257-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: d153bfc7-7ec2-4fb0-b14f-08ded661b0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HFq+VUgBVxW7R5vksWtFDZiyAeG6LbXW+7IKDaDfLt7Tb1K27INUECdxFVK6eW2ITtvaruKezDn4mbuGpy/ANX/xcQ6qiGHxvexJlG6iA5aOwd31bpbfamt0fIrP2P5M7omM+dJn7dsXRpHyQu3brnezatdHIR8F4UGSCmFGifuEQkYrW1amIEZO1p8w14yJxRJNAUtwGvWZFpUIUVnlJDs5z0FZRWeMPfncf03wZqa5nyORCW96TcZHu+TPFdvt1LiDH4Q9foxLH6vR+OHh0lkrmGOpKI8da0X57KR5m/MmRW9MIoxhpl2ky177UIPlKhz/kVFgRNx3fqBbsLw6O4rO/BTZBD6BmdgRZ4hbEVnELqAvHQWP1ST9vQQpTeKQTIq+c2CUlspHXv/wvKAsYz39jMiDjNw/U6mApf/SagrHZtHUczPvDECwKBJDmoSlAYAQ9qx/P6IVWOst+boTPTxcWNBQwX2/Z6CjT8jOjJpHxarc9wNNnUyR/i1ZvyPOXoQl1cfAeagho9DJSFHGe26IniyhtzZkZb5HCV+onNvqZVzGkdI89qwl0qXHR5ZvVKBZIsVt2Q/fyuckR0rWv0UsL8L/7mmASysJpn9z+yAbxc07s48hyiPpEnHsoiesq9FVMq6zEioRwhQklvw/2Uwj1yybFByW6rPZCxAyxJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dZYREsVOlkNHrVKCmf3CWZ839YMaJslfBZNa8PRmnmQssRiJDNNIwGlO2cI?=
 =?us-ascii?Q?O6VMO0MgDJM/mrDVkLINSl9T0Rzn/T+WOUdqkxTUczwST39DvcIzFtQZE0nw?=
 =?us-ascii?Q?YATeKqSOWqcFJ84bxTlKlvKdcZIoC2AZMtGuMe6c5V4V/X8rsgK9C5VygwGh?=
 =?us-ascii?Q?MhXt5Hule3Xe4O/St9HZRak6QKBTqfS5XB60EhDnjJLkBTjX30+w5GvgoJ99?=
 =?us-ascii?Q?ecSmfcmy/y6PuBoDs7KR+0nJoCev2S7Ly0GTqKdRJs4AtDoAgBC5tFkzrCXM?=
 =?us-ascii?Q?eRyN4ms9NXR1P6Z2+boda0YyPsx9GZ1DGVqcYjP0Ca9m8TfHELZyNWfo87ue?=
 =?us-ascii?Q?/iY1mnWNETF2taOaM2V93FHbpGtHeTBfhua5Mk9m2e7kvSmFb5FYBP5n9Nj0?=
 =?us-ascii?Q?S/7Bs8eCUG/afoLw8Ofwru89ElnabWX7Q2CKIMM75lV9Ha4MeriAQqUaDpOn?=
 =?us-ascii?Q?Yg5Wz0keTV6sDSWfeDPhf0upL+5uXeFjUPgU432UJxF4+2d0o82KuNdU6xc/?=
 =?us-ascii?Q?9LlWI1qSQ/bfpz3Rc/EF35nMVrP0qlY41zbAruNI+yVO5eLOz7PfEgxV/6Gw?=
 =?us-ascii?Q?CLIy14Xu9MSGdjCzp3f/fADXbK8LeMF9KqDDsC2FappaglkTPwrJDwHZoL0R?=
 =?us-ascii?Q?O102OjVZOGDKmM3xBtcTZJRlX2JgBDNwMV9fL31rDM7/Ru8dr1NZxhuqIYl2?=
 =?us-ascii?Q?7wguLGmh6n1vAVgTK+KUiRyQIHvJlcMYlmKYqgzw5FJqsAcUZ3lMLQEjxomP?=
 =?us-ascii?Q?QzSM4hGjad+E9OCryq3ZJyXvNXbs3NgaMTCKZwSoCMjnniZbX8Ps9sUgNg3y?=
 =?us-ascii?Q?mLUj489JwfDi2TxiqkLvlSUQyiy/QWt7yvf4eUl0ISXtGaBXb16f/bYCpkNU?=
 =?us-ascii?Q?St4R3ICjB7FsbDdP8tv2tvlk4axWLJ6MNTaVnjXONg3tsh6d165EvzsSseDQ?=
 =?us-ascii?Q?nutauW+xlQDz+8XCJYMqyGfETw7wuoVRmFUHzZsfL3k7xLIihB6Xrx2bO1UZ?=
 =?us-ascii?Q?jTgslOp5VwyPXKe9WshVjyRFf4VrtuVSMoe5t45FBdD1SqzOb0C0P3i2Xwup?=
 =?us-ascii?Q?5cRI5NKIu6/rbvaJi29/YeSY0pFbAipk4up8U6I3nmxhlyY1JqUn2YlLKNni?=
 =?us-ascii?Q?TAmoMrX9Lpa6VM8Pe4X7rrmz+hePGF/Yo3iFKp2mqOkUH7KGmpw4hrUwj9bJ?=
 =?us-ascii?Q?FddK70qwbBfy3LNsv5RNFiIBxkoGueQjAncpT/y6swxSh/yxGy9IIBkp8/ZK?=
 =?us-ascii?Q?7wDieXD9imbCKcLKFJ0IfyRJr62mfxF/Ea+Y3qj+nTn7Nk53cBuCDfhkI0jd?=
 =?us-ascii?Q?CxRITvSwkD2kSJOXZBtG5ibNApGxkxG6uCNTow203UkLrRSX7skoY9A/yDJM?=
 =?us-ascii?Q?IgkwRdP3N/a4+a0bvIN2hgkv81+ykuJxZjaqh9PlUccA+UgZQMCRuRVgjsnP?=
 =?us-ascii?Q?o1uigJt9lIzt+QEvCgTtAU+FDAI67HevmhPZD2bQ0qKrLyyAiBnxDuyVqwQP?=
 =?us-ascii?Q?AoYJHxW9FnBMY0BMv6+g7o56m6rRo9zlutq08pIqO7jV4X+Vwvb2ptkTt4tQ?=
 =?us-ascii?Q?10ao/1v/4D1J7NCL3hoK2F+qVJJPWp4v/UtaKtyOIRnXtlRjiHF5FpPWH3Rt?=
 =?us-ascii?Q?EjJ7SzS4VOFBIBjqnQFi9mMAjlosfJ5uu2YBDpZstOOKkT0/HwAIZqeuDbBc?=
 =?us-ascii?Q?g9Gl5jqoEWeTEDkk5zJ1f8znk3s9M+DzjSne6Ew2DJHE3hmVuScYrKg+NTH0?=
 =?us-ascii?Q?UFP4/ILerw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d153bfc7-7ec2-4fb0-b14f-08ded661b0ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:40:20.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMCVdwq/r1BtxW80+I1cR376G08xRxFSPSSnAH178lP7fPxiEVQuTZQ7k5h1GjBjxb2dHlKV82v/D+DBQUSa7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

On Mon, Jun 29, 2026 at 12:55:48PM -1000, Tejun Heo wrote:
> put_prev_task_scx() warns when a runnable task drops to a lower sched_class
> without SCX_OPS_ENQ_LAST, on the assumption that balance_one() would have
> kept it running. Core scheduling breaks that: a forced-idle SMT sibling
> reschedules through the core_pick fast path in pick_next_task(), which skips
> pick_task_scx() and thus balance_one(), so a runnable task can drop to idle
> with ENQ_LAST unset.
> 
> Gate the warning on sched_cpu_cookie_match(): a cookie mismatch means core
> scheduling forced the idle, while a match (or core scheduling off) still
> catches a genuine missing-ENQ_LAST drop.
> 
> v3: Gate the warning on sched_cpu_cookie_match() so it is suppressed only on
>     the forced-idle CPU instead of whenever core scheduling is enabled, so a
>     genuine missing-ENQ_LAST drop is still caught (Andrea Righi).
> v2: Reworded the description (Kuba Piecuch).
> 
> Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3b2e13bc924b..e75e2fd5ab7e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3090,9 +3090,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
>  		 * ops.enqueue() that @p is the only one available for this cpu,
>  		 * which should trigger an explicit follow-up scheduling event.
> +		 *
> +		 * Core scheduling can force this CPU idle while @p stays
> +		 * runnable. @p's cookie then won't match the core's, so skip
> +		 * the warning in that case.
>  		 */
>  		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
> -			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
> +			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
> +				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
>  			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
>  		} else {
>  			do_enqueue_task(rq, p, 0, -1);
