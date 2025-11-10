Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973212EB86C
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763853; cv=fail; b=QH03crv4ea7yKQYgvyyzPGC7/2ymi5esJ/2n3MJsLv/P/u9T54yHuGnROu5OtTQavFjTcJ9I3R4TdAhObOQNG+Ak0rw8m6fCsF3w3Ce9E0ywJTOq1ltoWKYbfrcQ8bJytef9TgyDQwv0D1yDLqlftt/8+B3OIIMVZvVRPpSQiWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763853; c=relaxed/simple;
	bh=Ok/OFhV+SJIKiDYKodIfMEuW1OjPUR7XUfipmRJ3Wgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEAN16GIZz9lmirxr/dJBXO4Meal/sudOE98n02bPwTrVmaehVa9OfgcNh+3EKx53ceXXijo8lZBdVwfe8TBzgTdcsXWLdUFCQ+J66DQCpat+DOiyCmRG/WvBlOM0kaiUGKdrwI+qANSTG+xGSTymcRT4hRudDYI1gyDsGKoRD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NI3zpFjW; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NI3zpFjW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIYJeMRgt/GoJtC+/bkNYt8MmHZjZ7U/UlYT3JqxY7oL9WfXyF8Rg2oxKqzhUhEPBQYZf4ApFdz2NkgDQeiYGWmz6sf2Vu8bxdhQC1ceT5P/oRfAeuIPyEKb0NU7qv1Pk9dklwmsNGX6GiwHwqcUMuSEHSzQ9+l+UK5EGthPMEEP0pnOYg9FUDkAHa068zWySt9niXmCwBOrEZbt9kv8dZ67ang/b0PRcctC6LDlf21SW+MGGBaCr4jyrUn6IPaicKcJxpWxLMsuSxTTVoUtK6h82XFf8fb0BGNSO3UTgSMSJH5cYlTiL1bVqo72LCe2x4iAKhyoQGy3FgJ+rX1KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dGs6Dh/qlzGE4dHGnVbx7Nu13jz4WN6Xeudkh/TQnI=;
 b=OtQgeu6EIEVeihGPD10rQv3Cnmqp5b1bkri7hYyQ4Vb5mcFaddikSXj2Hc4QvclajC6movx/BjI4bO88Q5goiggtgRwqJrJxPXjb3z4qbMK8J4lkUORFvh0H1G8wQdgeS00gG9ZudZj6jqtUG47bBM7hmEteOOwG/BsWRj5CRUyxpbolO49hcKuK/s7E+RYSWy/CFDc1nupi+v0jvC7VSoCjm9zQP7pSoU/myWM1izYDtt6oNUYIeiWsa1rwpkvB8tRNAk1oogdViGRZDduKqke+QaHptjWWFPmsGPB4W8yc/jzwrOknsR0WJlmOsVQ/5uS77nXZaUVPY4dgwa9rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dGs6Dh/qlzGE4dHGnVbx7Nu13jz4WN6Xeudkh/TQnI=;
 b=NI3zpFjWo4xLO8Ln02+bS4K99vsigvoKlFzNOJiWbihxhjh0XetTV5E1nqkSlbi+wQ8Vg41kVZWkA9NOXJ4xrIOjMrMm5BPdYrBueBp2fBzAA5XTZ42GxGnfnW2rYGHe1zF9z7v0YYg+G/vUQQLjxbomRcuJ38qdgjwOmYMpSK3aQpm2w2nl9a7s+sh1OgO6HIerd+DCgR8HFZG4FgEtuGC/9ek5CVJmW56G1UaAv4ah5dKdPczSdUC1QK8Jr7gt4K2vaO/yV5nPqHA2hbKyNbzStsCJtDUuS6C2vQrWQKjVPGNoLgMWof6RpVLjNdWgc6xdtYi2DUNhK4b2w8UkGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:37:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 08:37:28 +0000
Date: Mon, 10 Nov 2025 09:37:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] sched_ext: Factor out scx_dsq_list_node cursor
 initialization into INIT_DSQ_LIST_CURSOR
Message-ID: <aRGkQe7H2VNfVqwA@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-13-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-13-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a86ec5-fe15-42e1-d2c6-08de203461bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4bnJGux+zaxWZSC7UXUXgMNrOX3ExyuhgFjKXd6+oF81kOdLU7XArO+cJnSv?=
 =?us-ascii?Q?8vmOKyYaz4hVLeX9UFBuYeh5OdjkWLC+aj6nI1WevXAq6wzQsejCgBjYQ2GV?=
 =?us-ascii?Q?GDdtc9i187s16gOEMunlGV9X+OpEI1iseHVtnkwPYqQPnOpMhuqSHgGgMAOT?=
 =?us-ascii?Q?zsmyTF/Nk9MZGrBQ0VAMG97VzGe/gwtqYJ7sffDGLyMc9sZSqTSfpRYxtlIX?=
 =?us-ascii?Q?rQk6RA/cYS3UVyQI13gCM7y6ZgnYn2LUen3kn2J9cuRLPOEY89w0QTD/DYVt?=
 =?us-ascii?Q?If8YKDu66MxrV7RajtOmc/DPHRZrf3tIkIZM9Mhys3aMXyrehncA4/zLdeLz?=
 =?us-ascii?Q?/CP+8n08o6HPKYOsWid4TBQT5nhhWrkdcqI/Or8kzD2+irjUywNMzB8iFj6O?=
 =?us-ascii?Q?zjcHa3jSXXxP5+Jn7PtYQZpS1i5sw3ycuPMAgBAxC8Jb+eEM5z1hDoXEz3ID?=
 =?us-ascii?Q?svRczjNwdkGi0Abg2EtICF+vbKopfcs9U1DPTjoLXzMbgxsV1LxXt4k4VT60?=
 =?us-ascii?Q?91BTRgfyIND48/q96BtnYbuAFlZNcUg63jo4FYgjBj+0Ti3r13uOXLTtlz2x?=
 =?us-ascii?Q?Gnw3VdU6tS0IBLjcwKdIOQAxRC6ztksVV/mK9vNcgYFJKen96HMiN9qUUIqH?=
 =?us-ascii?Q?bKgIPbRRiPy23NGkxfyB8x5qFsCL4GjneuHFV7i//CvIQ9yu2Ct/5p5ZMNlJ?=
 =?us-ascii?Q?KbkBETecaKDOvCnim7ym05U61erKCtR5r42KOqaqp/oWOdxCv2zEXWuIXpRC?=
 =?us-ascii?Q?GBF9+1B0N9vmfJuVSjwVgzZZ9/daCZbxm0VVAb6pR9GozqG1DAK6ATSDIV5r?=
 =?us-ascii?Q?W5A0nwytj1bE7NnWo75tt+TDDRfpZqG/0rGTgLbsZp0h2FecfHloVMOR2USt?=
 =?us-ascii?Q?JoOZAtz/9SWmgE8XZrHco/V58bbd9e9TCZa3rEj9MuMhI2Fw5l8n1bkLGwSW?=
 =?us-ascii?Q?eUewVXjw80LDwRLZDpCyjckpJqO0WkItLj/KNY0n8RrnQvFYek5/TpqyDpkO?=
 =?us-ascii?Q?9KZZdWyt3g2NpSq8fOPOEAhhr88fU6C4TfrjhWV5QSFqfng0KsIDhbJkrK+3?=
 =?us-ascii?Q?WGIRXc2MAo3g4aVeorvLBn/95FDPxDUt3XN3arXSyLb1zfNHEjaVkUZLmWna?=
 =?us-ascii?Q?x7ObnEXnjtDC0ZipxZqfkZIXMAxqQAu5vwhzt0Xq/rHWt55hfFu27CltBbBX?=
 =?us-ascii?Q?K4hCgTVmvJYOgZJBkRdCtLVx9RrDpKE5/OOx450+zwFBVJH9gWxF2jxz3DAb?=
 =?us-ascii?Q?qXrVr7o9936L5BvBHa767WlVhIGjkYh9PsJx2aLvYcyuHb03J8nxelUSzpPg?=
 =?us-ascii?Q?KbU6QOx+AQ0FcpkpXPWuOkbYPZNTAMLqlNSX2gyU7OjihAI3NMv7IgCdlJ7S?=
 =?us-ascii?Q?9tPe8m7MDTMBlJCtQulFERWKLF7ZJNM1BA8DuzBvOJTzw1m3gbVXkjKHPjoH?=
 =?us-ascii?Q?0Vk7sIT2WChToU6bZUDzMCCuM39uQ3vw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2gfDjX9rRY425EAsy3cQHJf6YW+ChAqRpzj6eBoXRyTig/FLPXD4Fm7NxPv?=
 =?us-ascii?Q?t+4wb8TnEvZ2LkQ8WBibRH0ArdeDK4TWQy3qfLVZjy663Um14IzgA5uv7LX+?=
 =?us-ascii?Q?zZJ3a1MlGczKpX/1AfsNU1MXKoNfUkVyyJipD57RXhPfaP2qQ+l6N8RDP/IM?=
 =?us-ascii?Q?08GTUgvQtMR9d5gb05zoptZOmissTq9Vm6vtJd/1SoRGG62MsnnlDN4ddkVA?=
 =?us-ascii?Q?YNIOlFsjOb7aWbxjHoFLUHaEX1v4gG0eOvfLu4z3Fncs0+mrTGfzvuQHcAXM?=
 =?us-ascii?Q?u7zLal7qNHlqOSY0VasLVTlGgQRngE4qOUpVPe3JgsE8bK1hFJN0XDhQFG2f?=
 =?us-ascii?Q?is7J+SuYhwCPdyDawwblGMXheg5o1UqKi02aBT1Kt2Lxmc328WI04f2Tjgnt?=
 =?us-ascii?Q?A5bdLjXN9DYq06xf14jRsRZcBdFRIqEdjApokqX3AEPofK49DcgT/acZUknx?=
 =?us-ascii?Q?8Ha6k8C11NhuB8II6Xe2AfZidTiVUAZuYj4JQ1cOh/06sJFnm7FOS8Sk0hnY?=
 =?us-ascii?Q?IWIbZEofa1rslN2HAIRQe2aMl85ckmmmJ1F5GTh7Qy+IFRDZoj7wdiho3pHm?=
 =?us-ascii?Q?v2T+2fuQ56Rf61Nvy9TcikHQocIG/qTcYb4O4D9FrKtf13Ys28DVltwPy/vi?=
 =?us-ascii?Q?xjvBTlwQeha83c3SGJr64v+hCOimsSehjyj0jPfdqNS6oRCZHjJJjvI+XFyu?=
 =?us-ascii?Q?Fcv5rhpxj3jmGGHvvv+7oafY/JRi5j1HBpJsMIawSLpYQ5yCCT1LDs+ZEfhP?=
 =?us-ascii?Q?RPi8PsozVOvkR+6YMIf/6ojhg1z1i844dcB4rb1pjUCBTdtT2RI5aGdxu/xc?=
 =?us-ascii?Q?JuQltK57bxpDdJOjWQdIeAoZvHpkrKlsRtDn1y9DaqNJiRjQBxzManO156P4?=
 =?us-ascii?Q?0paKZZdT5beZL4dq4Cn0WFFcEA6kTor3hukYE4BHLwQFoAx8F2/jQwAWzOJy?=
 =?us-ascii?Q?8tgszIz+YTonKAWCH69G81RMR7gVN4y9VP/uvyn4qw3OW7gwk/Kw+UKDcYrG?=
 =?us-ascii?Q?HFFNZzCkxjVJRwHl49iGinsstvBRdzEckxHyqvtSISb3gpaLm84Y1/zbynSw?=
 =?us-ascii?Q?BP6eESkAY2aTdwL2Erf+Q7LuPhybJ2UacQyDK1wXvuvtqTX7UxkLBrGSZsBh?=
 =?us-ascii?Q?MXX2pQFXZ2dLnElLnQbkcfGHlyIeHq52rbFxF1/d0RA0Uj1Z4I/DI19adFa6?=
 =?us-ascii?Q?n57dXNOPIORwSlXLkeHZrsTtbvnT4j0PnTmn/jIRufvhKygOc9aCdLoFPnQH?=
 =?us-ascii?Q?EaOiGBpqYWZHseI/XYPDwhfGmsR+UGP9GA1NaPOSW+AwaV22AImibulkQ3ne?=
 =?us-ascii?Q?OLHuc3hQ+g6DhTrZ2429UsRxPggtvQJe/+CSA8W8oQqbUBFNodywvnnhbBpn?=
 =?us-ascii?Q?n1KsPkfss7YMgu3MT8XmdCdivasjfzkh7wBq3tsxIaorWrZbI0eE898cr+Hv?=
 =?us-ascii?Q?Sz2H8yp2TP/SUemqMqN2W3J5jg0KJXxRuIo5uCJPGzpKRbU81e5NqR5TszDM?=
 =?us-ascii?Q?PHksj9tKMYei7JHOOybEnqHBBKxrl2L4OUoJmo2dkPXi2AFkIO75gznXa1Ig?=
 =?us-ascii?Q?x6zm5xVxZKsHi2bW7hXUxMWSRzbbHkJ1dx8w82dL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a86ec5-fe15-42e1-d2c6-08de203461bc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:37:28.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovyl93bA8vhypifnp7VVKqiH9elSRTkTTgcuVaEY4xPyKyP2V20dsVLogVDDNwp56p8yL3VeJE2nWQnjPoGdVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

On Sun, Nov 09, 2025 at 08:31:11AM -1000, Tejun Heo wrote:
> Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
> macro in preparation for additional users.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h | 7 +++++++
>  kernel/sched/ext.c        | 5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 12561a3fcee4..280828b13608 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -149,6 +149,13 @@ struct scx_dsq_list_node {
>  	u32			priv;		/* can be used by iter cursor */
>  };
>  
> +#define INIT_DSQ_LIST_CURSOR(__node, __flags, __priv)				\
> +	(struct scx_dsq_list_node) {						\
> +		.node = LIST_HEAD_INIT((__node).node),				\
> +		.flags = SCX_DSQ_LNODE_ITER_CURSOR | (__flags),			\
> +		.priv = (__priv),						\
> +	}
> +
>  /*
>   * The following is embedded in task_struct and contains all fields necessary
>   * for a task to be scheduled by SCX.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index bd66178e5927..4b2cc6cc8cb2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6252,9 +6252,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
>  	if (!kit->dsq)
>  		return -ENOENT;
>  
> -	INIT_LIST_HEAD(&kit->cursor.node);
> -	kit->cursor.flags = SCX_DSQ_LNODE_ITER_CURSOR | flags;
> -	kit->cursor.priv = READ_ONCE(kit->dsq->seq);
> +	kit->cursor = INIT_DSQ_LIST_CURSOR(kit->cursor, flags,
> +					   READ_ONCE(kit->dsq->seq));
>  
>  	return 0;
>  }
> -- 
> 2.51.1
> 
