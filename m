Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793316382;
	b=vdKuzdgtZDCrJ6ZeqcKIMtK6wzs9xcyCsIfEuZVHNw1gj7aa6r3ZE81J+a6rRxN50k76
	 SwCfR2iQiFitDxoQLD77ANLzIs9hCQkj4RkTMyA2PsVnG2UCTCKcO4gs4odNKf/KlU4XH
	 hlMKttnvsmB0gDW0aar6c3pEjCVl34tdUxRvsguxrFTzqtx12y19ntTp1gVT62qje2C5O
	 M8cUWQp4FIZUL6/33xOX6GCg3shrwQpjfVVh/bdh9KBJnv7c6ADG2JtAAiSuKI7Dol85b
	 YgEJu363WtnRtzC54nEWEqFufoibQEB4LYJvrbFLJ2lKavBN7z2+kWwmznzRu2pX9vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316382;
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
	bh=N369J5GrgZp6/Mykx/qdrzWj9nc6gKBW73UGtO8T4Bo=;
	b=1bE4P2u2XaBK/uBhwTFwccLlgSON7i4aT7gVbo/ZlCyXvjrbwIlxZ/0RqbjgKH4slmpo
	 sjR74yw6fllCAVagcuID/RRHs5HbkpsInxTKq4xHGmEEAvPh+XccNiDvDGvzL7+dZphjW
	 dgGJ41ofav9phPrPjRPqhGvesJQKnd5WxOWwvA4E+vKwDR4052IMKB26YpdkClljMTjNA
	 wy/FE3n3TNXFOwajQcHnUxGZq9InrBmDVUc3De8VVlBpaOZMCMxt8aEe76kk4YKPZpT90
	 oeP4vW19MV47I8qoJcD6YFsM9EpuTCAiVUVQZlwRfYB/wfzrbF7QD+a67X9YaxqQHxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZrBm0xm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.23
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A55606A330
	for <sched-ext@lists.linux.dev>; Thu, 29 Oct 2026 23:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A55606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XZrBm0xm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M14SWfaTB13tUDSvCCzDVV+RD7NoSf9W9245kNSjUwCNUnwZdoEiChwFX+ELIITIKD4zojnQXGm/Wh6xy4CM9GE535wjpVrzRyUyE9LjTZnkUG5JUlxfkDbuVkQPuZxl7DgGYsLn9LHBp+BLwPCf4wf7ZyLew7Zbq3N5xqJpw74eRrixm7K22edMsW1/Dme8uJRl4M5xr67qpqomY1FZ0HAJ4W6mc2kxqLlWne4yXFs6qine6Sz2rv5o/7cLG/3XVjr59k6MCfu6MXiEq2iD0fKjELAAsT0VlDyA8awXRY693pupaNG/xRoqqky+uQXDQvHb5u6XJBXb8IR5YavTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N369J5GrgZp6/Mykx/qdrzWj9nc6gKBW73UGtO8T4Bo=;
 b=B3yABkBS9C9QUKbm5a0m1peS7Gqi5A9iJ5QD4oZYvz/EENhjAKhQY4TeQCYHMn5NGRIBwGncTMGuxmiG6Bex2E/SwKqI+DjF12ui6OQx7Q1hH5mlQ7I1NM/MmXnTGaET1/kHs3CRREkwo4alrCSWszY5wmzTJZNvg/ROPppal1GbpD6tflVQRCjsx9+SAJ72svFKtNrHBNrG4/YmYt5pfd3TWLurFYzRP38fCxPfWa+6yPSN6tbAUj9uNnfZfZgFQr34/LBf8RxSAcEBNmeL0R0w4vOUj9fSj68KNeuiknYq8OMCi0hgm3E80naeDcg7fQ1ibNcfGTQ3dUtcykzv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N369J5GrgZp6/Mykx/qdrzWj9nc6gKBW73UGtO8T4Bo=;
 b=XZrBm0xmhUGpcH/BEDulvz75wvAYUoTNZqjNgVlIgj1ZrFMO/afcneFbRkdAvHm47NQgwLKuCKERB+6GX2U26LEz5NK0TIwVI2ZdyXazv14DKBKiCZ1kbPV9eisLyJYLM+VJA/+3ySdIjkCF6EPSi+KRLwpOhRQDDWH3KjogjdPHmvIge0uijK+YTSclpItoRudr/F77w2HsOZsZnrEIvYQ1egrhd8dXKhPBqRHz/QSZuKLCcTCA4/kWR3v7h24sDngoRLATJIqHk8zLmS0DkWE5t5Q3m3okNDp9FyHea7gwKoNHjKVkAhPe6X27GW/SQCs5DtfcZDSlLQZ3qGmQZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 23:26:17 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 23:26:17 +0000
Date: Fri, 30 Oct 2026 00:26:07 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Call ops.sub_attach()
 only while the cgroup is online
Message-ID: <auPWD4tWlxZCv4tB@gpd4>
References: <20261029222859.3099324-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029222859.3099324-1-tj@kernel.org>
X-ClientProxiedBy: ZR1PEPF000077F4.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::456) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c6c8bb-4834-4787-819a-08df361407ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261009223027099003|261026140227099003|10067099003|261022075727099003|261028144727099003|261022105027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3aCq3nrGyRi0inXvARgDnKZaFj1SJlno41ytaRGrA3shRKNIz+DBNyERv1Uwm7KHva2Qf6NMDbPfPHP8ckT/eKkJ+8LR9qqC3XTJFC20MqLN+UbNK08e3Jstn1VCJQlwFRVragcVQao6rjjSUDQxkLQpnnQy6Jfj1uLlv/CjNlXzaXY5T19VnlIiAL08FRVCnr3A1dTmB0TcscCYMrJ/xg/TYomqXLwPaul5hFUEv8YSXccmjS41iVPcxWVwkPo8cqTCOburYCd8NgxefZfK2d+9KR3stDP+A1Uuj+iMuaZhHHvl34HENXyJwtVob4xaVGedZh38/FXeQPu/dQcJirQ+94UBWbNn70uQYFv5GM7ut6QPm2s1xUlOJwhPMrVaZKuZzfrZQn92maR3YOWTzJCV0gWcZDs1tuA/SwzpSaAc5OsFzjE3hK6mi7HvvktMKNWVHt59wmzK+WDeRvIYuQTVDm66So8bFUtcz35N4w18n47H4h9Uum6EV5USc2JQ1CZe3+0bruXZsCitdS4TCMWDdo2jTx9CXfI95NKDyUyaOfnG2vO3lMTnOtbXEpwtP2V12yDZm0WR1VOs0iMLIzB8kQkFx7KgZINx26MUZcJtL4Xk/ROnr4mXxlAbkS8zkgsoI4OpzUEG6PI/Y1ngXjcvyrAQHVJGxjPG2Fu7+CE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(10067099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5w1A7PrBQKikQRrOk42lM7BwmvGiwbgZ6Blwf2EkjXEsYH4bQTWus1ThoPw?=
 =?us-ascii?Q?rPA25RrEpp3rkCFLtXYZJ0l5uvK96AuoHQeRRZ917ShqygkHrp/P5u7kL0nl?=
 =?us-ascii?Q?GDIn+7wYMcpPMusFx4bWe/UbvHXf0E4GRPbz4N3IVamUsuYxSUrgnd9zDUbC?=
 =?us-ascii?Q?ECCmp8DJvkFbX8VNCYu7lttLvSgsbICdoaCZ87OnOOSXbeC1Ph65/nTOPGXm?=
 =?us-ascii?Q?z3fYhoqD3k3MhkKy2FXM5faER7/uCI2b0mzdEa1fs+GPD6YVL0zp+uXR58eV?=
 =?us-ascii?Q?mTkDoIJgkAmNg1yjJtt6vzmTQHu12I9uuzAu08fDss29MWohXunexOsJU6Bs?=
 =?us-ascii?Q?TMnniUnbwnaYfpZRC3lCDjQqJKIqA9Gh31ReQywB+klxry328drM/Mlg7CUL?=
 =?us-ascii?Q?N825fOPMQFegh6KdiutsE7n2X62a0AVdb9LHwjHy/EgxpGywgDlvsfVjLY6R?=
 =?us-ascii?Q?MIHNgT1UKe5BlAunYKlleL9I8pbkwObxXpZOPPtNkosX9gmhPvjhO11TLMvG?=
 =?us-ascii?Q?6wemqmLOJ/+/sl1pBEeJO0hrMwkUUrnAxqfrrjPficsIucD0LejO0drFtXrJ?=
 =?us-ascii?Q?YKFNI/rbSf9r5EwSK8L/f/bKaYo5/8UfJi6zkhtHjLftKWn9XYBE+lKq/SpY?=
 =?us-ascii?Q?UNNFeh9zP6AvI4Jx7WeB8zxKN8MnqCWIJEdhhUR7rp8q4Wvb25oT5UJZg5qi?=
 =?us-ascii?Q?lW8vtCu/hxnmqRXCUXMm0HBo/2exM/3B3kB22h75VfNyrkA9DVxk9lHdTXl2?=
 =?us-ascii?Q?3zfJOETGgSnf9VgtZFrsnTq0tMmsq74hEDOYBmGWmCz5UAYgI+P8ez8Gub8f?=
 =?us-ascii?Q?WBLVgi5DnfAq7NZZKlEDKhxGs+677+RPxRpeXkfImxabABjpToa0aJdyxUVa?=
 =?us-ascii?Q?5tR9SivzxsAejYj9jT8VEiOCdsUeWm1xoBho2GDYACnEaUnDNmX9si+MoA/k?=
 =?us-ascii?Q?GgzkWj6MuueZlYB4QVIii/uR+meINtYm1qDXm+QjfD11c7MVnBxbh+pcuZ/q?=
 =?us-ascii?Q?kZ9QzZE056Jye1Rl7mIao1LsyE+tON9q6aGuRp2kuny8nAcXDvWlKGGIb0gu?=
 =?us-ascii?Q?nDcxhAwsHuXW9V/VT8Cf3PFlHRY37MDu6ftfulcpkj96OYRt7TZnGM4bNqHX?=
 =?us-ascii?Q?05rq1gH8NKIbDPtHUaE+iGxe54ADnsD82W3VCe9s5Jpwg1mmYeLPWs+gz/kc?=
 =?us-ascii?Q?hiN+g2c0HKUvl9yp14wGSo5i7KHG5Nvtyv68o191kSjVZhhdWfSmcEMuLGm4?=
 =?us-ascii?Q?BSYaHm8ToWj+9y7yQVZ3Dvqf8zP3WW9xV3BjOch+MK8Fy6NokBnzfFIUOJOh?=
 =?us-ascii?Q?SO4kITZhO3ZpfU1ZiaPI0ieBfjP5/Mbmx5CJHSe5JFqs0c6u9N0wz/IQt4Qm?=
 =?us-ascii?Q?BiTc436cTIO9EC5x4MY3lqETWhmfdXCjyyChfDF9Ai8p0pBK9NS2yjSWhzhw?=
 =?us-ascii?Q?uz3P9YxJ3fBaLN8wH4jP6rbY6pQEdnflwz2A7YNwqwtXvxdD46Oiwb3pNRrA?=
 =?us-ascii?Q?CJKQe8FX1NLBKEADUCOSgk7MzgeErMADxHmgitOqhqHRbKA1vlm7l2/vsjD2?=
 =?us-ascii?Q?b+Jt5wBjJeHTw6piqtEI2LNefCms5Dzl9lu3t8gXHR8Rjb60n6DXrl/2nocB?=
 =?us-ascii?Q?iLcbWrormDPIxLr++kPibAACd518MMT9o4QNaSVkSdZ0nTPkC7rLF0ADdd3f?=
 =?us-ascii?Q?2ext/wXtXzBTejiKxAda9jKozerDI9BmN/C8AW9aegQPEbju?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6c8bb-4834-4787-819a-08df361407ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 23:26:17.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfupOfaXwUp0J/pWg4dveYjIMLE995o9czCePQx63SvIuks+eF5JTeKUBOsUNGa+m895h8uqANA8ZZKbgaKIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

On Thu, Oct 29, 2026 at 12:28:59PM -1000, Tejun Heo wrote:
> The parent's ops.sub_attach() runs before the enable work checks that the
> cgroup is still online, so the parent can get an attach for a cgroup whose
> rmdir already returned. That complicates parents where cgroup cleanup and
> sub-scheduler attach race.
> 
> Check CSS_ONLINE and call ops.sub_attach() under cgroup_lock(), so that the
> parent sees an attach only for a cgroup that is online.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/internal.h |  4 ++++
>  kernel/sched/ext/sub.c      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index ff0a3d508533..58652370da5a 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -869,6 +869,10 @@ struct sched_ext_ops {
>  	 * @sub_attach: Attach a sub-scheduler
>  	 * @args: argument container, see the struct definition
>  	 *
> +	 * The sub-scheduler's cgroup is online for the whole call. If it goes
> +	 * offline after the sub-scheduler is accepted, ops.sub_detach()
> +	 * follows.
> +	 *
>  	 * Return 0 to accept the sub-scheduler. -errno to reject.
>  	 */
>  	s32 (*sub_attach)(struct scx_sub_attach_args *args);
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index b5d92d89629b..6bc6b93ca63a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -2340,8 +2340,21 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		.cgroup_path = sch->cgrp_path,
>  	};
>  
> +	/*
> +	 * The cgroup stays online across ops.sub_attach(), so the parent never
> +	 * sees an attach for a cgroup that rmdir already removed.
> +	 */
> +	cgroup_lock();
> +	if (!(cgrp->self.flags & CSS_ONLINE)) {
> +		cgroup_unlock();
> +		scx_error(sch, "cgroup is not online");
> +		ret = -ENODEV;
> +		goto err_disable;
> +	}
>  	ret = SCX_CALL_OP_RET(parent, sub_attach, NULL,
>  			      &sub_attach_args);
> +	cgroup_unlock();
> +
>  	if (ret) {
>  		ret = scx_ops_sanitize_err(sch, "sub_attach", ret);
>  		scx_error(sch, "parent rejected (%d)", ret);
> -- 
> 2.56.0
> 
