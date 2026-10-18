Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C35351C17
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315084; cv=fail; b=XRfGvXbbmuXi1elqrL96pegKXEVv6mweE46ynNek3NSPs8gMdEJ5+k2iyZbFmdYPtS584C2HIOyabklv+1+kASW239b+6o9i9wYChl6Pztw2xV/bcKno9DssSn3ZjFYMOQMrnoFUC9kTdm0kZVe/lxF44bB2kbPM9m2++IybAkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315084; c=relaxed/simple;
	bh=EhIvZXpf/w/1TPcQdt/3Ai1mMGsEb0b5mUfG16GI0zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mgLz4UBWDBzq2anvHpZhFYMbQoVwr/3oCicMSZ0623oHVYtt+MavN65pc5Itga3Y8pnnTEL4mwq4unkMvBnLxIo9DowMYQ2N+6I8tCohx9/yWYa5tmYph+5PQLD8xaz/PTUr9EYkvxK00fZuOx+Q7ngqtDRBehI65wHj1CWeIcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJC2i+7d; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJC2i+7d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGM7UThqib62cZ9TJqDzws0C4F7YxWFiY1f556jP5XqVenvpM4sN9s6/OR2aYqBkUSQGPrTUczjQnFOl/HJUv235PW2kwz4e5q2ezemj9OhNIz9+IDQ4hlVa5uybSOJ2dMPQHLul52n/U2OmexXnF0wgVvbRj5BFSIewWHedUWWz1uQeVhw0p5gUSl63sSsPAgbhp2Gmr5PevtURbMmve3JWZ0nc7yezM8SC7enelQnjdw3jfIWfbFRjlPqraoMxb1rMDF2RknT9XtZgzxcPIhD/qbu9ZhgHl7QK7xRL6NLjWaJAaYPYq6/vD1SrJhFIdURXCzKwN+TK454wqPg8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83lEC5vt0oFO2vtmEicJywRbgTXygultYq8l/fuSkC0=;
 b=qW+YobBO/LIMKKdpwh14u6Y/o18+Xd6DGPPUCr87UWZcuEAnJwEDGogXjUnR8eRBHuS/b7Nke3QgSqzAZkbCqN4RxzM1+F384n2cHoXbjq/yz4LLfeZxQFi7z44fdq/w5IYUNyDoUMc7eeW5xMED+dFw77AzVYJqFL7NPFSvqj6kbXyT+/375ebkm2F0g3s/gaCgLU/ZyrWbgQTs0Xxhzp3fgf7nO7kE0KHYpOqwKMksl+AsyKIxl1LP2MyprDboT0fangD6oAzVUyaJLJJw2LQ4Dta9/LEa6XSbZFr5M17G2Pteu9Nkr2zHLP/ugsGaVCGqnmMn2hl6fWNnwFXgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83lEC5vt0oFO2vtmEicJywRbgTXygultYq8l/fuSkC0=;
 b=lJC2i+7d0PUq7SXRq8mUyfrgD6FbaOobFQtsq+kgYKI/LgUAfxbXKGkclMxsq1MoDYUaOylN1XKG11ND7hmaFZvL1YyMGJfU42bpfy3CvKrJlNFGpFch6dAWf/EnM7tdFitEHj9PwhUUkakTrxgKpVaTThZBZiK1mWzacB2rE/3HE/0VLC2Lp6WWSL5Q0akt0JMwVKzTT/coPh4EtaDE7pbKCruSHw48hErIr+Ie4UR5D91bq0px5e8hi02b57HtF13Kb7WfT4nKmd4inayZBxYzVfuib6ozwaDH1hrjaaFsdkpLLHi9/awGv/e8ItsZuPxoebv231zMpeOm8vY3yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sun, 18 Oct
 2026 09:17:59 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 09:17:59 +0000
Date: Sun, 18 Oct 2026 11:17:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: Free a sub-scheduler a grace period after
 discarding its ecaps syncs
Message-ID: <atSOvg1WszSymDdJ@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-3-tj@kernel.org>
 <atRtoSdf-c87N5tz@gpd4>
 <cdba4a956a7a2e3079e27e536981ac41@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdba4a956a7a2e3079e27e536981ac41@kernel.org>
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 36683311-a387-426e-2c33-08df2cf8b41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|5023799004|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	SDXXGp5Gzc2wUBQgTvecSsIzlR27h97ZF5oMvw+zjUZYU7PcQsRPk6RsaZd3iz55gzQiV8492JDaF/LRwK/7+OrUrWhh4QMcfW9Nt7eNFSrsLnIJULJmJRja/+T9fvDbkkfFmh9KxzIEBwjL8O3WTFR6j8W/jS3RUTGP0K37xCwvrRZ8xJtXNgQSgV/WKs8zw7RWnOeNIhQspmxnTnP7Cr+Zj0HgEj9pxozMdgTfIts7a2UxxHXtRWCBHQcO5A5voKH509D/0EgPuUT9Jqc+lQMogz9J+jxPmSz4YZGT78JwnBFrfcgR547S3WgxpGh3KSTzJIJ33NX4gd8vqwbPOOZ1n9LC6+9GBNxEpLGTBj21eczSsxB5+f83cXM7rSS4iClCrwE65J5V2WxE69L3TlnGDXXSrvjU/OGTiOocFKSGVEcoFmk0h9Mc/OfpQU6kApCLbEazJV6+z5YUxRJyeHusHYCmR8nr2CxHxJ2eH76NKgkvMNelnA1/8YJDQV56qLhVPqe8NVCJA1+2D4DLnwVUZUNBqZT/iL0LrOZCtWwq/DLSH6kwBZC/JJ2rCRBBUSvqQYUMIYVarH6sZtYQPMMleotFzn4ObQh8pd3OQ4YQf3nE8RwwmeG5spE4nSxuKF2m0h7tywauMkpHoN4VM8eULXaAypuFoRxkP7kkjwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(5023799004)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnW1NzvwUT15VRD4afSkXw3U/8kQWKCYauQwenz2uizcy40OZqfRrVNXfjbW?=
 =?us-ascii?Q?X8KofSoqKY7cLgYlIQiGLqxWozNmhwPxpq8dpwfFdywA7C2tPz1vSqD64o/V?=
 =?us-ascii?Q?sSLoF5TSSjDHtJyEb6DsGmUjQjJdZTkjFOgUctApbcz85KWtL2u3cDsXAI9z?=
 =?us-ascii?Q?DY9bL2d414Ea141u0QEXw7hkRf+3aTSaBBlVaCjNfkmJoJo/D6w+v82fYObk?=
 =?us-ascii?Q?3VtCWYLtCVCd/DubULXfwMvvoAU/Ki89gwsfPNRWtQqrTo1g/asaGJHMh0BH?=
 =?us-ascii?Q?2hgxmlf7hC5zMv5Wy6Ka3fQG81F50eh9aNdHjXp7YAdHyU8Yr5pfkUC4Ij4W?=
 =?us-ascii?Q?PojqITTT0QSvdjByBv9UpQvDtfRt8YNe7YMX49ZoHUKgVPGOmv1AzzTFQYbz?=
 =?us-ascii?Q?MyYemSDqXpZ+KmHlda0siXKMN/5TgBac5def51QVnKyZMbKBzWOE6N6zqI7p?=
 =?us-ascii?Q?S3hm+ZujrPHw2GIo4WDewuLNtHVZU2cM4v4oZdSnhmL7H7qUlQzh0Fmgw8ji?=
 =?us-ascii?Q?01QIB0k5bE63+IIhuNrFgfahNMWM+yazLsh4KaCFm4lnoIghgjbOmqk92aUf?=
 =?us-ascii?Q?nBDy7jNmTbtW7ncte4DtCF1DyxtnsvhpUVBBp93GokjFQ3DVHYjVqrRwKWHj?=
 =?us-ascii?Q?aDE4BgMiBZ1LLMOJlgNhEieOM/clniJ7WCAjP7PQOWIYOfnAIVDFXN6rcXbt?=
 =?us-ascii?Q?8xQt6dXQI6CVzK/w1kdaLBXSsYSOxa0SAtX+INUyLY8Mv15P/DeWIRqaAL6u?=
 =?us-ascii?Q?VqnSAyRGKcK9vXmV3xdx6tjVu6caRWCf4Zz10/Fn8BU+snp6fenK++NGVvQy?=
 =?us-ascii?Q?HiSlN0b2Yd2Rh2sdkAYJkH/AuB4sJLXXgk2DR0Ii/Qj44xZtmFPiI/DGT7bW?=
 =?us-ascii?Q?psL5dfoeZZB9ceBCi4eSlYMzDV1Y9BRu4isxTLMKoXiESzxcB1n4r49qKrkF?=
 =?us-ascii?Q?uZLrmO8VevGs8ULtlZe0KFnaAMDs+tcXo+Y5+gvzO5zSzJNO7ZDUhA6K+JXt?=
 =?us-ascii?Q?veI6cTuQS0bS81tuOImqxjX8wyiqTVZET8pGjHvw2nH0BssGoPMQ7vJLoWHq?=
 =?us-ascii?Q?vajit21kjubGFHgfnS9I9GJizjyLRMkU8WMb9qCu9b83q38sdbZESA1YDPwW?=
 =?us-ascii?Q?Sp1BXIzYREClq+qDA9aS/yOi/MZZFrZVD0F5AzCGz9r7ykcMcc2hOM3gAHUf?=
 =?us-ascii?Q?sNPsUyDX+G6sb64ZxRAt06zJOTXMDMSG93B+IlVLtgeG6vmxPiRkd+Kl7p4q?=
 =?us-ascii?Q?QkP1I0GZ34P7+tu/rc91kctO5y0PTVlhEw4rdfietl2TWjyRT/WMJ/4xz7KZ?=
 =?us-ascii?Q?fWsUnNp3P4AcbFZy8L9CcKW5E5GZLYzpjKuwGvJ//yG5wgQCipD3Q8EVraw8?=
 =?us-ascii?Q?aZlPD6dmMN9cpXiS9CQkVWOVND7xcKiZ++Q0+XMAOKadRMeECPDwrbnVN3SX?=
 =?us-ascii?Q?BnQjVzvBVwNsvbZDcuWI/fUsitxUr+lMcLx7M5trdpAeLnxAcYw6bRoa53Bd?=
 =?us-ascii?Q?tbDM+Hp/qzRODJV1y7/A6PEIORgkoyfij2HaT0Rh//P7oLk7P09KMM9q3ELS?=
 =?us-ascii?Q?sCwUpheDSV+nO0dHEVwP7JbpTgHWNUeF+9//SIhfK2qczrR1HahRoscqeGKs?=
 =?us-ascii?Q?RdtAPfcJYEKgL0k4eGJJVRHhuSp5LuY9WYLu6OQTbVQ12L7ekp0BGx1gL6wx?=
 =?us-ascii?Q?Fg1N1NMWEbhSnukkpQVHuSwUWsWIFUnqr909xeTewVMI5fu7YPqww8ZRIMjf?=
 =?us-ascii?Q?dt5rEOEcSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36683311-a387-426e-2c33-08df2cf8b41c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 09:17:59.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13+1CZDlZTpOt2M7C4gKf1lKjVZStbus5b4cWw2Ut9jWdPuA6tLe9XCsRBdPFxbcJaJXWlD0phNuhEMi1PZNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On Sat, Oct 17, 2026 at 10:16:01PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Oct 18, 2026 at 08:56:33AM +0200, Andrea Righi wrote:
> > This is called for every possible CPU from the free path of every sched,
> > including a root without sub-scheds, whose nodes are never queued. With the lock
> > moved ahead of the test, every scheduler unload now takes all the rq locks with
> > irqs off, which on a large machine can be a lot of lock traffic.
> 
> The loop this replaces also took each rq lock once, and attach and detach
> already cycle through all the rq locks several times, e.g. in scx_bypass()
> and ecaps_report(). Cycling through the rq locks isn't that expensive.
> 
> > The first grace period has passed by now, so nothing queues the node again, and
> > a node taken by an in-flight batch still reads as on-list. So, can we keep the
> > lockless test in front?
> 
> A node taken by an in-flight batch doesn't read as on-list.
> __scx_process_sync_ecaps() calls init_llist_node() on each node before it
> writes the pcpu and calls the ops, so the node being processed reads as
> off-list while the batch is still using it. The lockless test would still be
> safe, as the second grace period is what waits for the batch, but the
> rationale is incorrect, which is kinda par for the course given the
> complexity of this path. I'd much rather keep it as dumb as possible.

Makes sense, thanks for clarifying.

-Andrea
