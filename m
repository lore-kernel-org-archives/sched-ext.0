Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085634F48A
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632411; cv=fail; b=oSN4EC2f/gOy20W6k6x79dDh2+iWWVsOLbGtiXfc6ZnqpwhjkBP//CCpF+jtzxoDuZ82rSnlaub33v1qtlBJPD8giVxewPnoLt6u6t0rz7lhlDAnvBOibIjdinxe8bR1ydkJHUgtAALwgmwVCJwRNuQUtLr/EiCPhpVAAXQWx7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632411; c=relaxed/simple;
	bh=43/mXx87xf65fmRje7QLQZc4wq1BrvgpFprFvUSY068=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uROalg5k616IK6KFDChtWhhW7GgEjzgiTuIm6ctlcv8bE9ruA7CVIqdZhm7ih2vjzqgcNWdt3ejCbcfeHTUQF6tfdREF9wsfwdclxSOuOH/wHOcDQma7sAGa7GNcao8ME6GxntmGgzqHWc0oz9uFXqSp6qIn6qL4EsJa9ks95T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckr+t2Rw; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckr+t2Rw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI/Ec4EltL4in0SrKu62m2Q2Au4eNtIzn5F+V4k0AM1RLNa94LZ5jaZJjDZo07mSPTQWnenH1tziquqxTjbzviHYf/nYaBH4F5FVdXvc9R0q/EDoyQKeOLXhFgh1LSECDRKJj7089923TYxR9+PK5Tr8bpTJJM9XR0gnueWNofBmU+pZB+aOLwXJgzlN1AYzrVYPSdex7rjWNdxfRi4T84Y8g5IxD4MVwmPaJ2fU4z7XHmzGWEc6FH3B6wR9Os6u92qZxG7qtUMLw8B4PCU5RJbgyO5tVijAxJHlvWLH8OMTIWyVDg4/eXfuTi5coFiZQLLAkaJmhWwUKU5wYPGHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+48zGKoKRJjmhy35PPWp+FfBbc7S7KBcFJzKYoWv3pY=;
 b=aZmkirH3Wa1dq6I4q40fugY+fthH5Wz67j5SUXQQ2frhBCd0sUX0+TXG4xRtcDNr/s9Awk/Sk9Q3tIQ3l2ibGxdxGEbELkKdk82wl3+6r6JMzbwPibJ75n1UQl2bCQjef0LlRui/LGs+I/pUrW/ldhJhkkfq1mVK+OAunf3uH3CANG50l3POXkzEacOwDQ4nOFx7l5GQMs0MS6qjV0eoPGSzX/+6bEbNYNZ9Nh/BDPyPmfDRDn6uv0RkEEzrAh/0HvlO++OCawJsFwH1taDjShKTh8RttPZQ+FWAFCJEx/ivR9Xl2+rTmD7ab+BaUoSQSWBUUqjv/BZm9ptcLIFA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+48zGKoKRJjmhy35PPWp+FfBbc7S7KBcFJzKYoWv3pY=;
 b=ckr+t2RwZ9nYxyzmETeHZre68kPoHKb91n2wcP4v78zkn0HmPMKw+GbzndZzETeqw/F3u23EUm2VifLRj2P8J5TvasTvNjvr6CXZV+CRAcp/Grnaf9+ngvQJClRHEDA3LfD/OMURiPoIhzVlHyYYNBQWw+Ia2G8OjRQuRCrsToIAcYp5OD+dK+dqDEMADZ/Yli1ClFUsA+4n/26S+N/mSgbDscvc4nEtNjLy6h/LDrIBQGojW1LOf/HivzKgS49OrvetduW3EL8ogZQWSqSo8uj4BPIteuYmBz7J6cOAgrnn8zMOzKYS0f1lwOckmqoL6j0On11BM5KPSLrpKpqDqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 10:20:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:20:06 +0000
Date: Mon, 9 Feb 2026 11:20:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYm00oHl3BRWNFFA@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYjtOQP0tmGIqoOM@gpd4>
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5601a4-df67-4028-9ad7-08de67c4cb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|19052099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L05nHEi1Ywfu+Q5fcBupDUSge6cLxRovEgfW+x7TOo/wc4RYtlc/UMr9ZIkt?=
 =?us-ascii?Q?ax/2vg6YxL/1ZsTW90aa+IK0paue4/CNBcgqUXDZI8E1OwyrBiEZXYGgMNze?=
 =?us-ascii?Q?2ToOGeZCWnuqyeDnK6P09atYbsF+m6Eb3vFAhbTUuadTRg6RFJH1SWyYBVTy?=
 =?us-ascii?Q?G9SPs0Mmc6exxkv0liO+lctPNxuDBo6qf8EuwW8uL6fYa/vl0ecnmb7fIhDt?=
 =?us-ascii?Q?5K7F9TS0drd2FGWJl6/wsWnsEqhCfKO0zHcvrQAlpzZh9lbRb4hrIciJkL9a?=
 =?us-ascii?Q?UQixJ6zYhUFVEYQmkm+JBZeR73YZaYx4S8LgW5BGHB6QWilkbMqdmpOzh66H?=
 =?us-ascii?Q?7RdsYMdhiQkXowMXvg51cm+hawLuilhquddDtrLWgz1YqVs3xsFMKrcBfyDX?=
 =?us-ascii?Q?Oagad59FboRblH8A7BxL0Rr13tQKrrYhQ2VGBN34+0oBVO+euMDyaxm3s93V?=
 =?us-ascii?Q?EocIMK4KPjwHJDe6d0gr1dQpILzP95HSvt+3hln0oeTqWXbrX74WRWVfcXX6?=
 =?us-ascii?Q?FXxFG2RR/b05TJaqLJEPcr2xJqXdkNT74+M2/iIOTfSuD7knyK4vive7TswO?=
 =?us-ascii?Q?fG1EpVUHDVUdRI/CUyqqNywZRpFNv1/rYSPwlLT7LA/YXvV0PxgJZbU9Z8m4?=
 =?us-ascii?Q?Fi4qz9wDqoltxheEGBBiY5zSft+zPwj/kEWZ9B3VF0An5HiPcbc41A0cHwVM?=
 =?us-ascii?Q?gJSLaDLY6zCqk0teI2618gZ6wecq5aRmeopieSHKt6hhhHq99qMbyMCBSYkl?=
 =?us-ascii?Q?eGGR7fE48Kc0he4qJlEMyUGhSveWqd4Oi1f0QlbIeXLloeXYtp4mEnaZSCFo?=
 =?us-ascii?Q?xKbvhJVhqlgTV8GNGPvaR0Kd3hi5TZg9C2W9aDhitI71NkqL1ytFkWeC5tal?=
 =?us-ascii?Q?2JIxOJXU+GwgHjTIgHHhnamJ4MEPi2U4Zg1lW271cHSqMKFEqCNMFAG79Gqt?=
 =?us-ascii?Q?0PwR8/lAFc5h4mOvHjE6I8pRgacSOHwWpX9t7pFIPE2azce/VfnQSLXZ9ioZ?=
 =?us-ascii?Q?NCB/YrIm+PJttqvFAY8L22RWdOzDGUFsT/qCnWZC+TIJc0HKHtyN0bv+Nyqb?=
 =?us-ascii?Q?08l5eePCqS1W4UL5yGWrAXZZb2zbiZyUGUtwNoRLlf85vDAYg4OY/6HN5pxX?=
 =?us-ascii?Q?wnyxPGkil15w0ZHeabm+98VFZlzmkBpO3nYwtMVD7kWfU9XvTt3b07IKOCHv?=
 =?us-ascii?Q?vgsEO+Xxd1y/k3KVMn5j4ox1lg8Pxcslgf2acy52k5NZZv8fiMKnl0SeMycl?=
 =?us-ascii?Q?n6azmYzNnVDKfqOeb3rNdyUUKXiVeXbmEUs5BZZb7WBVfLvxTjG14BHN40sK?=
 =?us-ascii?Q?9OZ9Uv+Q5cUcxOLMw/oyNZL0bw+ku692Lb4Xczp7CKLvIQfp7e/INNntOPYs?=
 =?us-ascii?Q?2PS6sduU5Ve8tgiwRrEF6oS6aVp1ZWPSrQHaobXb4OdAFdrciXMWzGz/llVC?=
 =?us-ascii?Q?Siwp92dUoPzNfrmbYkPCNkkddezT+4vg3KKYuavdBEIl0sVcZeap+iXedznE?=
 =?us-ascii?Q?ED4SsKoo0aGy5AVbHXhodOfltctuZhgl1NYY1WOpI7ckrH37Q2/5/3vSNWxo?=
 =?us-ascii?Q?F6EXOmwJRkYKeTr6Nw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19052099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPuw3znXIqN/pR3cKXyLBhdPbbm+dVIn9B82BYbq5zxYnucNELGIES7v6MvW?=
 =?us-ascii?Q?x4zdKP4LWZzrJLtqKNhZmxKRkH4txfHEHDE4CCurSbzHu46N77bGTqEwdRyS?=
 =?us-ascii?Q?d1ldC+LDDOhN0myS549tSFLp0s9LYGjruCH16D/BJZbwqsD5+IC4haq3F5w+?=
 =?us-ascii?Q?bnnc5qMN5lVpEXDaixFgyNVBbikDJsg7Qv1jRQt22EOScbRJV1q82SOpAYHm?=
 =?us-ascii?Q?XEqTEEuOzfiLkTwaMBKG8+6d/wkp8pG8LUTj2lyADuHc6cDraTcu8fOBsnHh?=
 =?us-ascii?Q?27pu4VXd/tmu5WSinGyc+BRsTIDnLKMgj5mBxPsctp/DFL4+K3Q06DIv1gkR?=
 =?us-ascii?Q?4WGFkFNdHR4R9nNni0XV1Am0J8yV0digA4VKzc6v68kZ88dzNP7MinzCA3DZ?=
 =?us-ascii?Q?5/2ZYx73xNCxQ1kmDAxkI5Fz4JnHivzd224dm8Z3sXFqolierJVMw9pCNCj3?=
 =?us-ascii?Q?mxqNE8bxDkfoJv2uhytVx3ePJ7GQKjPq+3S3VV/tkXckCcd81MuPwN0PwwsW?=
 =?us-ascii?Q?1r47BDJL4kzAZIjaRX3xVsUl26ds3GA0inO0NoJzWzCFzN+RSRcjSDzTH3r+?=
 =?us-ascii?Q?+Wi1g+OfRaKC/K5F+Ae0gKbS+cvstpLXpI6Y1Ct/Y3FtK4TBKMzWfPLDoCqX?=
 =?us-ascii?Q?c4noOVNwyFB6t6aZipnWgY2IqlupNWVBOYCFoLLmL/pjWqjsbXIUiQYkxg+i?=
 =?us-ascii?Q?qe6X+R8WC44AFkN8l76oHzKNciBb38WMLA+jPjffXYc/Xq2XFhEweAXfIJE2?=
 =?us-ascii?Q?5rrCpbgkvGi4yNUHYxdj4bahbQmYu1qBU1TzZ2O0bvwkvJTZfGAh8jvCUNII?=
 =?us-ascii?Q?nzKaenc0/lkWlqhZbuVURZo1Gomwo+gGCM3sKX9uMWYXZH0+IqKYDeV/tu+D?=
 =?us-ascii?Q?fPUVsBa5lXyZX6xjnvk0eW9uEx5BK38QK734E1tuC3r7X7UwDvaNtGTsOoeC?=
 =?us-ascii?Q?38aO/d0oVYxTmCWfAgLZcdW8D8CeLlMHOMWWFg8vMHGv0y8xlRJvhV7HDqlW?=
 =?us-ascii?Q?5Nw7jaDcvlVcWpGWrLp5PZxy10idlWAhXNU3eoDIkPm3/pG8TaqqCgGF3FX3?=
 =?us-ascii?Q?RpZ6C81+LkV3RwarCDTnOBCA2GXeXH0ZS+jv4X7kJSj/MriD2fPyL+xKgMLf?=
 =?us-ascii?Q?RtP7NZLn7zRt8DvNZsG0WHzwfAX0Dkc7CT+urpxSpKMk3iAGdNekNCRCpZs8?=
 =?us-ascii?Q?Kki3J/j8MH4P2h0X9htKY+vtKUkFnz41R/D8CF3eJkl0Ia8J9Z15Cmjrbgoc?=
 =?us-ascii?Q?93xldbq+Ekh542GpLYcwuhFJgvzFPUPseB9UX4nUNFLJEgRUwe0x+yhwp7lv?=
 =?us-ascii?Q?EX/jsqKtycJD4cnBlbSksHen432Kq43Z9YbziqDDzkTbRzdd2orkGKRF2XF4?=
 =?us-ascii?Q?aqj80fE+/O5ay37+nY4dYyr/sr3X4VH9i3rtGysn0ScKa+GHp8BG3EpQIGnb?=
 =?us-ascii?Q?P4jZ8mffRiSPvwxTfxZsPyQd5/nWPrrYyzezQ5Gp5Qodo/q/iWJ+dAbFk/UA?=
 =?us-ascii?Q?eIAKFyVT89Az2018+q1W1RI59YhFMLQUtymmJvHIJq31yXjzOhW0ojpffFQy?=
 =?us-ascii?Q?Sv9FKXO11l6q1/SX92fkCqkhU42uhNL5T57zavmkpwso10cr4tNP0jY88xGs?=
 =?us-ascii?Q?/n09fNw4A7glfB7I1Oxkl92HGIn71mbLf2ttCIlvFLzBKysCp/kGyZ+n1nDk?=
 =?us-ascii?Q?GnhO0cUgcrf+jE4KxD+RflQsk+iqnWhvs5sEovZDPF43eTLV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5601a4-df67-4028-9ad7-08de67c4cb4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:20:05.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hzrvH9o6ckkqf6mNejKufZQxYDtJKbIj7yjbi9lotyK1upipWVKexjsbilRj8ENVsqmwzgsCeLjqtwV7rhCEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

On Sun, Feb 08, 2026 at 09:08:38PM +0100, Andrea Righi wrote:
> On Sun, Feb 08, 2026 at 12:59:36PM -0500, Emil Tsalapatis wrote:
> > On Sun Feb 8, 2026 at 8:55 AM EST, Andrea Righi wrote:
> > > On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
> > >> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
> > >> ...
> > >> > > >> >  - From ops.select_cpu():
> > >> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> > >> > > >> >        the BPF scheduler entirely; they never enter BPF custody, so
> > >> > > >> >        ops.dequeue() is not called,
> > >> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> > >> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> > >> > > >> >        not called,
> > >> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> > >> > > >> >        enqueue/dequeue lifecycle tracking and state machine validation
> > >> > > >> >        (expects 1:1 enqueue/dequeue pairing).
> > >> > > >> 
> > >> > > >> Could you add a note here about why there's no equivalent to scenario 6?
> > >> > > >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> > >> > > >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> > >> > > >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> > >> > > >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> > >> > > >> do BPF-internal enqueueing in select_cpu).
> > >> > > >> 
> > >> > > >> What do you think? If the above makes sense, maybe we should spell it out 
> > >> > > >> in the documentation too. Maybe also add it makes no sense to enqueue
> > >> > > >> in an internal BPF structure from select_cpu - the task is not yet
> > >> > > >> enqueued, and would have to go through enqueue anyway.
> > >> > > >
> > >> > > > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> > >> > > > a scenario equivalent to scenario 6 (push task to the BPF queue).
> > >> > > >
> > >> > > > From a practical standpoint the benefits are questionable, but in the scope
> > >> > > > of the kselftest I think it makes sense to better validate the entire state
> > >> > > > machine in all cases. I'll add this scenario as well.
> > >> > > >
> > >> > > 
> > >> > > That makes sense! Let's add it for completeness. Even if it doesn't make
> > >> > > sense right now that may change in the future. For example, if we end
> > >> > > up finding a good reason to add the task into an internal structure from
> > >> > > .select_cpu(), we may allow the task to be explicitly marked as being in
> > >> > > the BPF scheduler's custody from a kfunc. Right now we can't do that
> > >> > > from select_cpu() unless we direct dispatch IIUC.
> > >> > 
> > >> > Ok, I'll send a new patch later with the new scenario included. It should
> > >> > work already (if done properly in the test case), I think we don't need to
> > >> > change anything in the kernel.
> > >> 
> > >> Actually I take that back. The internal BPF queue from ops.select_cpu()
> > >> scenario is a bit tricky, because when we return from ops.select_cpu()
> > >> without p->scx.ddsp_dsq_id being set, we don't know if the scheduler added
> > >> the task to an internal BPF queue or simply did nothing.
> > >> 
> > >> We need to add some special logic here, preferably without introducing
> > >> overhead just to handle this particular (really uncommon) case. I'll take a
> > >> look.
> > >
> > > The more I think about this, the more it feels wrong to consider a task as
> > > being "in BPF scheduler custody" if it is stored in a BPF internal data
> > > structure from ops.select_cpu().
> > >
> > > At the point where ops.select_cpu() runs, the task has not yet entered the
> > > BPF scheduler's queues. While it is technically possible to stash the task
> > > in some BPF-managed structure from there, doing so should not imply full
> > > scheduler custody.
> > >
> > > In particular, we should not trigger ops.dequeue(), because the task has
> > > not reached the "enqueue" stage of its lifecycle. ops.select_cpu() is
> > > effectively a pre-enqueue hook, primarily intended as a fast path to bypass
> > > the scheduler altogether. As such, triggering ops.dequeue() in this case
> > > would not make sense IMHO.
> > >
> > > I think it would make more sense to document this behavior explicitly and
> > > leave the kselftest as is.
> > >
> > > Thoughts?
> > 
> > I am going back and forth on this but I think the problem is that the enqueue() 
> > and dequeue() BPF callbacks we have are not actually symmetrical? 
> > 
> > 1) ops.enqueue() is "sched-ext specific work for the scheduler core's enqueue
> > method". This is independent on whether the task ends up in BPF custody or not.
> > It could be in a terminal DSQ, a non-terminal DSQ, or a BPF data structure.
> > 
> > 2) ops.dequeue() is "remove task from BPF custody". E.g., it is used by the
> > BPF scheduler to signal whether it should keep a task within its
> > internal tracking structures.
> > 
> > So the edge case of ops.select_cpu() placing the task in BPF custody is
> > currently valid. The way I see it, we have two choices in terms of
> > semantics:
> > 
> > 1) ops.dequeue() must be the equivalent of ops.enqueue(). If the BPF
> > scheduler writer decides to place a task into BPF custody during the
> > ops.select_cpu() that's on them. ops.select_cpu() is supposed to be a
> > pure function providing a hint, anyway. Using it to place a task into
> > BPF is a bit of an abuse even if allowed.
> > 
> > 2) We interpret ops.dequeue() to mean "dequeue from the BPF scheduler".
> > In that case we allow the edge case and interpret ops.dequeue() as "the
> > function that must be called to clear the NEEDS_DEQ/IN_BPF flag", not as
> > the complement of ops.enqueue(). In most cases both will be true, and in
> > the cases where not then it's up to the scheduler writer to understand
> > the nuance.
> > 
> > I think while 2) is cleaner, it is more involved and honestly kinda
> > speculative. However, I think it's fair game since once we settle on
> > the semantics it will be more difficult to change them. Which one do you 
> > think makes more sense?
> 
> Yeah, I'm also going back and forth on this.
> 
> Honestly from a pure theoretical perspective, option (1) feels cleaner to
> me: when ops.select_cpu() runs, the task has not entered the BPF scheduler
> yet. If we trigger ops.dequeue() in this case, we end up with tasks that
> are "leaving" the scheduler without ever having entered it, which feels
> like a violation of the lifecycle model.
> 
> However, from a practical perspective, it's probably more convenient to
> trigger ops.dequeue() also for tasks that are stored in BPF data structures
> or user DSQs from ops.select_cpu() as well. If we don't allow that, we
> can't just silently ignore the behavior and it's also pretty hard to
> reliably detect and trigger an error for this kind of "abuse" at runtime.
> That means it could easily turn into a source of subtle bugs in the future,
> and I don't think documentation alone would be sufficient to prevent that
> (the "don't do that" rules are always fragile).
> 
> Therefore, at the moment I'm more inclined to go with option (2), as it
> provides better robustness and gives schedulers more flexibility.

I'm running into a number of headaches and corner cases if we go with
option (2)... One of them is the following.

Assume we push tasks into a BPF queue from ops.select_cpu() and pop them
from ops.dispatch(). The following scenario can happen:

  CPU0                                         CPU1
  ----                                         ----
  ops.select_cpu()
    bpf_map_push_elem(&queue, &pid, 0)
                                               ops.dispatch()
					         bpf_map_pop_elem(&queue, &pid)
						 scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | dst_cpu)
						   ==> ops.dequeue() is not triggered!
    p->scx.flags |= SCX_TASK_IN_BPF

To fix this, we would need to always set SCX_TASK_IN_BPF before calling
ops.select_cpu(), and then clear it again if the task is directly
dispatched to a terminal DSQ from ops.select_cpu().

However, doing so introduces further problems. In particular, we may end up
triggering spurious ops.dequeue() callbacks, which means we would then need
to distinguish whether a task entered BPF custody via ops.select_cpu() or
via ops.enqueue(), and handle the two cases differently. Which is also racy
and leads to additional locking and complexity.

At that point, it starts to feel like we're over-complicating the design to
support a scenario that is both uncommon and of questionable practical
value.

Given that, I'd suggest proceeding incrementally: for now, we go with
option (1), which looks doable without major changes and it probably fixes
the ops.dequeue() semantics for the majority of use cases (which is already
a significant improvement over the current state). Once that is in place,
we can revisit the "store tasks in internal BPF data structures from
ops.select_cpu()" scenario and see if it's worth supporting it in a cleaner
way. WDYT?

Thanks,
-Andrea
