Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302E318140
	for <sched-ext@lists.linux.dev>; Wed, 11 Feb 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849311; cv=fail; b=T9Rvh5XROzqdqf8/QfG3Qa1pLQnWwn3Ced3gR4lZA/oVcZg95H94Y8KcZRl63qo39M5sDbJMdzA6XNzR4o134Gwd6mUx5evdGAkLGkFjAbfcz915O/Ya/G83O6bJ6RYiIiLJMFeHb2BvT+n5J53KFPgX6d/1dTOTV1VaWwBFeb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849311; c=relaxed/simple;
	bh=84lnh0rALVMonfsmPj2vw0zTzu+RsPGSkROyzropiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMiiVIpi1Rs4qhTHWPfxsY9roywbgdqwpE2T7wVSzdZKLXTaHQZCUs0mRtVju9InXJLe7diAYal7ExNTEmpsQ7fh+jAdE6fCsRysIaIncEev394sXz4Sz7ecUuS7nP8vtsW8onpWwDRlFZJcAuKDEjv/eUUvDqBLAq5yBi6rBUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtFqJT/9; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtFqJT/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsR1OW17Vom5Jd2FZ0N8AfP/wWFbcnWEhZVfXHNGcz/kMSfcImIvYAxxHO+SDhqkMa6LGEcOKqBT9fD1kLIwTvm2jjTrVQcVlHWTE5g8He7yxRVddlmeuXOBQ9g+w20VC7RnGQJaFGbkdJPWfRhD9UkWPZFsJWF9M4+TWwUOPfg3yIo1BvEON6Sa9Kv7oSTQhE8d+D4SQwvUw4u5RdYEymLRI83OcqYaNClvdZYpqt7MZoe949kCCPHDarFGgCVW3l7z12r9Hbb4rRb4oZuTfK8JE59of915tUAxNi3DwRdmjSWkSSeGyDPfIDtEeQScUDyNIJMG8Mz6rieG+vSk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0H0TsVFR7Xm9kxLrH3Ql2Jh2QGGAlYmx5+hS2SrKMY=;
 b=sbeNdToz1j+skRKBa3FOZGfiKMM6A5a9t9QO1iWMMpGk9SBJTQ85APfmLeAK3zt6weewZq29EqDPwaykG+MNgLq1zh5gXCNhA9C2cGmzQgeKI8hmJ8MhmRVL9vsLzjjUgd02m+9sWuWfWU+Fliik4ncfgBSsw79XQ8KovpCvVIUKmVuFgCMnC6A7OAVGXkQbWpk+VHol5q+ddCIVjUHWhRjCCG+IJ1Qkhl1hi/IAV8bO3dsZJ8S56DHwapt66ECrxGwcO5nuLBVYm29XU/CVUJA+YltZGSB/k2aNq8abAxRmnv6DgShoGDSqvV5pvOJlQmim8uA96A2TXfVY0kAx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0H0TsVFR7Xm9kxLrH3Ql2Jh2QGGAlYmx5+hS2SrKMY=;
 b=DtFqJT/97M/Z6lpOGC6Z6renRGeLyYiVXSR5DVNdS834pqoJNK9Pm+nyHghmBEwbg87nPEAmq4WhqWkBY4qSf4N8DNMk/FkH/S+MHHWoxMB3UIAmdDREz2/Fs7wje/KRGuoUM3E8m+QZzujbFEzFmK6a5Ql5yETL76y0OG0Ps2rVBivTzf8bVqQq9bvOJuGagNkRd9B6S07JH96pwVfY0+A7LE4w6wNtAn8SbRNBagAxTl4LiUdIS1Qot3hCy/mwgXNwz1mEQfx5oLNoKtSgBn3QX39tvIbjNqzTk1Om+Oe37iTTZX5CZ9kWpct7JsGfnkcnCpMy1mQmx9WQva3z0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:35:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 22:35:03 +0000
Date: Wed, 11 Feb 2026 23:34:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY0EDpFD1FSrigB6@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d42e03-b88d-4404-7b4e-08de69bdcc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsZGq8QzQPIBFoobEiznBHSRxl2ya7N6li/QZYNle0FIC/o/9w9E7XYRV1fm?=
 =?us-ascii?Q?U2/4i0MEsY6j0mK1+Bz+ZxlrV/hsU91Nujdf6a1IVEA4Cu74QXplhAE36UDn?=
 =?us-ascii?Q?/TqYZW+QxagyI/Qur2cxv4LnH6QYA04tRh/zPDIGL0QtZKNoHVpIdt56OUiP?=
 =?us-ascii?Q?yaW6O6bAIqk/4KVxUSLDqyrnJQuBKzfPSmuOJIygsC4MxQX9akXCsnsUz/DH?=
 =?us-ascii?Q?Cw+molcVGaYGoADLz9Kk+bbDhVoY6gL6DsTOvhbh0tZ/F0OccjiJ2JmqIAyM?=
 =?us-ascii?Q?CLnRPCDah0GbhjDA4B4CpLz6JTNi5S/eZI7lhhThpz4BVyERY3F0921iJrFE?=
 =?us-ascii?Q?QeeVlMB7t+jzCmiUxj8Aiz5iQ1l4GAuT9pLbF0W4lvNOqbZWhdzBfqXA8PUa?=
 =?us-ascii?Q?QRfkG1lNRj/nN5KUZvhjglNC1n5tGzSLytvuvTyPggOWYA9UAoDYsDpN5TIT?=
 =?us-ascii?Q?bOBq8a3ofEtFUYCsybj0Biz3VQXoV53NAT6dEyar5X5vIAw6ObfiB07Oo8Em?=
 =?us-ascii?Q?VqYodidgAp+xgyOCKLWQIaQkFp0C+vsmc/luNuok9ItVSEs7LqzU3N+JR6pn?=
 =?us-ascii?Q?d0t5cwwJAK3ii1zmXf2BRwnL7Rr38YR+WIUzd+1guoCGV3YiJJ5KsAXjAFkE?=
 =?us-ascii?Q?fBJrALmZEN/PudDttJknLHDZKKuNtNP+a3n1RhseagTTnNSwIungLJ5giB8S?=
 =?us-ascii?Q?gpjYGjP62FhYXFCHnwLo4zkErqiCX7qsQZrjjJRl+GwD7Y94yC2+ueXcpvwd?=
 =?us-ascii?Q?VDVPAoiAMH5wolK9gU4csI9tIn3PWx0H46etsG2LBoTjqY1+bFLbZaP/AAXV?=
 =?us-ascii?Q?O9X2+rq9SDRFYjpI4hfTMwJr8Nqk0R6pKoHMd3VuFv06SH9noqoWCh+gqMDX?=
 =?us-ascii?Q?LMZ2lF9DEATt4Fwq27ej3QDzkyaryZu9XPPboR1luLipgzri24eVKGiX5CG0?=
 =?us-ascii?Q?6rKsiq3U5SLHn9SbrYwVP6c8iU0zCf6QHe8YGNHTO/CvFnKgo7OfV2x6FjBQ?=
 =?us-ascii?Q?p85pGjFigLs4J4dAkF36eOk69LrsKJB1neGPb8bU2QvjKcbnY9+q3I4KbAQU?=
 =?us-ascii?Q?wj+9FBqbqHlRNezOKPXsJQgCM+LmYpxL4pD2BJFd1uFWU13RfiZQ9s6txf3Q?=
 =?us-ascii?Q?VYDGRdftgKdH/2zxtIZcEOnnvMg4aGsRo4nAHok2kzOaCesdTht8GQ0DdT0S?=
 =?us-ascii?Q?AZuTa+GHxwHdr4IjaCG0JFh8dGZ279cgEABv6H+o2uA9wHFx6cqbo2F75byV?=
 =?us-ascii?Q?n5N5vMVWMUDqlKxPmC3P72kGw+7zs2oD1yrMSPJKehiI+JM4PbxX42n2ubZf?=
 =?us-ascii?Q?wlOQv5MMgTVtkxu237K0/WCwi35pqMBZojJHkEdlruTkNCkBXUO3SShsH5my?=
 =?us-ascii?Q?i9RygkZQEn0706SZ8ZRUUgZ5K0SeomKhKOAw4eDf/UYhcpw+lxRJ1aFeiOXa?=
 =?us-ascii?Q?nxR1yCqye++Tl5eVUYxhgq7/7/ITFYMG4UzwHOqI85xbfoYRBzLyIHwj+qFJ?=
 =?us-ascii?Q?JI6OsX/N4AhIRap4diZNna/3azbUTWzoP0MaPWMBoPnHPfGWJapDAXy2rUXH?=
 =?us-ascii?Q?/hFS0dQXicyIB9KkLlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asAeernOwgQ7kFtVzeB3tkhEnexAgwUSRmShcvOP8z5gFd9WJusEJ0hv5YWE?=
 =?us-ascii?Q?5azQFeEiLwPCeCkYqUIP1eSVPr65Jv5sbIYyyDoSrHGig7Hdw30urg669bRm?=
 =?us-ascii?Q?BSMzl2fz388iV2ipV6NHdaK7ixPUweQKxhVTaotls/WWOHZ3730TnMkRwyIq?=
 =?us-ascii?Q?+8KwFvomitFTSLHNkGxYwYPU9vjY1KRTJiMhccwFSS4yQAxnEfA+wG8gDasi?=
 =?us-ascii?Q?CfP4n6w/G94UZzO3oIuRpGfoF6krsGFENa/R9sGKYgG+k41Rf9OH6ztUzpvb?=
 =?us-ascii?Q?FiyFEKHNQrMzqaZbYjLVW3m3cc+8KmTZ0YgOzpAeHkXDmQged1NxbBQfaGqv?=
 =?us-ascii?Q?jFTXFonMoTwvjc+Kd+LPZ6OULS1NkggFiAHJYHeHf8soZX9Lx4oHiW+SZ4BB?=
 =?us-ascii?Q?JvW9PuupOb5aM0vbs0aobxnfgKV8n/WIzKFEseD4+/EePY54F6G/3x1CtOSm?=
 =?us-ascii?Q?teYN6UYSot76Dou1j6sZXEpnwjjt/zHhLtG0iewDKGa+uF8GOHBFk8Xdce8b?=
 =?us-ascii?Q?pfBi9XQe5Ei0JOYikT5WNIqpT23CcT8Q3seaCq3D4Uw9jVl4EJbSU3NNMGex?=
 =?us-ascii?Q?CZkHzI3623iR+cVt2tYh2CeVvZxrUKa31e2dJDCbopb3WLNo11yiqka8wbp4?=
 =?us-ascii?Q?aXx3UKkjxG/ywiRV4q48BpA5z4kgob8rgfytr3iIVmYDVxfzcz1k6m7m6xWl?=
 =?us-ascii?Q?i4Yfr9v6rxOsuSofWmWRg+Wsf0KvGx3+ZRW7r21XjhGqa0pFhgCDQ5ONEfBf?=
 =?us-ascii?Q?42SCV+djC7XM8XS7m8S7T8fuEO+fQS+nA7QmstoKUHu9CcF711A6yOzaCij8?=
 =?us-ascii?Q?JAuN8i3Rh+0ncqQdBr7fWVGElErjOwva15gb0bE69jY7ME2h5jwpCcOMpGRQ?=
 =?us-ascii?Q?EZUFmF9w1pkqTrQXGuS8mQaIr0X5+R60fDynFmczxZSyKvIqoz+yIkANKdSQ?=
 =?us-ascii?Q?+qa6Vk3UblyGXI/mm1aqVUYyNlAfWbDOZIErR4km6YxzcHuN59nkXwnc45qP?=
 =?us-ascii?Q?zQGXV5xqlXTfJKNn/hOBXqzGyTs4d4gM/qTjp0mkcnQxLBlBU4AWu3WO5VTo?=
 =?us-ascii?Q?DfEosGvXOgEw9C8Equdro/lNSWT/yBKPCFlrdcUbPoKs6M/06qotCT55TFj/?=
 =?us-ascii?Q?78J+5YH7Ln7hQK+VZT6bJxr7B3X16nVGpVuep2gximv1v6kaFKgCJ2a+ToQc?=
 =?us-ascii?Q?4r/CC8N4/nR7zuqpZc+uw4MjHCHJQNMf/VhYMQFRA3xejlpMsCxHEKZWwCNb?=
 =?us-ascii?Q?ErMRxSArHhNQWUSeUCoKaWewcVXf+WJ6BFjmN/7CAWNj/BXAZnuZkdAQnEFY?=
 =?us-ascii?Q?SyhYBrwT3uX94oKrp5p74WheL/tzvmYm8JM719Snpi9lTKTvaBOsaXOOUyUA?=
 =?us-ascii?Q?NeSaq9UwbEpGq4VXZKHVzquoXNfJHRu+pKq6WXz92otvyQrVo1uvo0gughE9?=
 =?us-ascii?Q?jmI12BpW4uSvTJelb9tOP0U78bGoBNHDY4CwV/e//FcA+DKf/97FMJ50637t?=
 =?us-ascii?Q?3M3H8mXLK+UHQYD1RomZHuCxI0kXXSiENTVlYzubBoEgkL6DQEtHRjKzja8u?=
 =?us-ascii?Q?mSGZ73PNBDVSkEMnnOaNOytTrD3WGYLPJgoZshK17F9tbxQOtjZahL0f2jov?=
 =?us-ascii?Q?kTNBGGyW4nSkQtOkSy5BDaLIOGFg2jxcXJA476euRHRGqBoSnfSZGLPTi3od?=
 =?us-ascii?Q?Hp/IQh4sz4MTrBruNptkyG0JlAmYcBbVCGBmRyO5tW4xG8+WwdnZUwUYfARG?=
 =?us-ascii?Q?Tq1QZm9JJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d42e03-b88d-4404-7b4e-08de69bdcc13
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:35:03.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvvNixDikHuKL7aJkXh2o1Fe2CmIyU4c5jGJJWcDYFSKU03ai+K790tEcRNAOut3dwcPqzzjZUYLJ9Zi45fsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

On Wed, Feb 11, 2026 at 09:47:57AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 11, 2026 at 05:06:20PM +0100, Andrea Righi wrote:
> ...
> > > Please use () do clarify ordering between & and &&. It's just visually
> > > confusing. I wonder whether it'd be cleaner to make it take @dsq instead of
> > > @dsq_id and then it can just do:
> > > 
> > >         return dsq->id == SCX_DSQ_LOCAL || dsq->id == SCX_DSQ_GLOBAL;
> > > 
> > > because SCX_DSQ_LOCAL_ON is only used as the designator not as actual DSQ
> > > id, and the above code positively identifies what's terminal.
> > 
> > Ok, but we also need to include SCX_DSQ_BYPASS, in that case maybe checking
> > SCX_DSQ_FLAG_BUILTIN is more generic?
> 
> Ah, forgot about that. Hmm... we can do:
> 
>         switch (dsq->id) {
>                 case SCX_DSQ_LOCAL:
>                 case SCX_DSQ_GLOBAL:
>                 case SCX_DSQ_BYPASS:
>                         return true;
>                 default:
>                         return false;
>         }
> 
> I just feel iffy about not being specific. Easier to make mistakes in the
> future and more difficult to notice after doing so, but I think this point
> is kinda moot. If we break up LOCAL and GLOBAL/BYPASS handling into separate
> paths in dispatch_enqueue(), we won't need this function anyway.

Ack, makes sense.

> 
> > > > @@ -1524,6 +1590,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> > > >  
> > > >  	switch (opss & SCX_OPSS_STATE_MASK) {
> > > >  	case SCX_OPSS_NONE:
> > > > +		/*
> > > > +		 * If the task is still in BPF scheduler's custody
> > > > +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> > > > +		 */
> > > > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > > > +			call_task_dequeue(sch, rq, p, deq_flags, true);
> > > 
> > > Hmm... why is this path necessary? Shouldn't the one that cleared OPSS be
> > > responsible for clearing IN_CUSTODY too?
> > 
> > The path that clears OPSS to NONE doesn't always clear IN_CUSTODY: in
> > dispatch_to_local_dsq(), when we're moving a task that was in DISPATCHING
> > to a remote CPU's local DSQ, we only set ops_state to NONE, so a concurrent
> > dequeue can proceed, but we only clear IN_CUSTODY when we later enqueue or
> > move the task. So we can see NONE + IN_CUSTODY here and need to handle it.
> > And we can't clear IN_CUSTODY at the same time we set NONE there, because
> > we don't hold the task's rq lock yet and we can't trigger ops.dequeue().
> 
> I see. Can you please add a comment with the above?

Ok.

> 
> ...
> > > I think a better place to put this would be inside local_dsq_post_enq() so
> > > that dispatch_enqueue() and move_local_task_to_local_dsq() can share the
> > > path. This would mean breaking out local and global cases in
> > > dispatch_enqueue(). ie. at the end of dispatch_enqueue():
> > > 
> > >         if (is_local) {
> > >                 local_dsq_post_enq(...);
> > >         } else {
> > >                 if (dsq->id == SCX_DSQ_GLOBAL)
> > >                         global_dsq_post_enq(...);       /* or open code with comment */
> > >                 raw_spin_unlock(&dsq->lock);
> > >         }
> > 
> > Agreed, I'll move this into local_dsq_post_enq() and introduce
> > a global_dsq_post_enq().
> 
> Yeah, and as you pointed out, BYPASS.

Ok.

> 
> > > > +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
> > > > +			       struct task_struct *p,
> > > > +			       struct scx_dispatch_q *dsq, struct rq *src_rq)
> > > >  {
> > > >  	raw_spin_rq_unlock(this_rq);
> > > >  
> > > >  	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> > > > +		/*
> > > > +		 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> > > > +		 * Call ops.dequeue() if the task was in BPF custody.
> > > > +		 */
> > > > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > > > +			call_task_dequeue(sch, src_rq, p, 0, false);
> > > 
> > > and this shouldn't be necessary. move_remote_task_to_local_dsq() deactivates
> > > and reactivates the task. The deactivation invokes ops_dequeue() but that
> > > should suppress dequeue invocation as that's internal transfer (this is
> > > discernable from p->on_rq being set to TASK_ON_RQ_MIGRATING) and when it
> > > gets enqueued on the target CPU, dispatch_enqueue() on the local DSQ should
> > > trigger dequeue invocation, right?
> > 
> > Should we trigger ops.dequeue() when the task is dequeued inside
> > move_remote_task_to_local_dsq() (in ops_dequeue() on the path triggered by
> > deactivate_task() there) instead of suppressing it and invoking on the
> > target in local_dsq_post_enq()?
> > 
> > That way the BPF sees dequeue on the source and then enqueue on the target,
> > we avoid special-casing SCX_TASK_IN_CUSTODY in do_enqueue_task() and the
> > "when to call dequeue" logic stays consistent in ops_dequeue and the
> > terminal local/global post_enq paths.
> > 
> > Does it make sense or would you rather suppress it and only invoke on the
> > target when the task lands on the local DSQ??
> 
> The end result is about the same because whenever we migrate we're sending
> it to the local DSQ of the destination CPU, so whether we generate the event
> on deactivation of the source CPU or activation on the destination doesn't
> make *whole* lot of difference. However, conceptually, migrations are
> internal events. There isn't anything actionable for the BPF scheduler. The
> reason why ops.dequeue() should be emitted is not because the task is
> changing CPUs (which caused the deactivation) but the fact that it ends up
> in a local DSQ afterwards. I think it'll be cleaner both conceptually and
> code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
> paths.

Does this include core scheduler migrations or just SCX-initiated
migrations (move_remote_task_to_local_dsq())?

Because with core scheduler migrations we trigger ops.enqueue(), so we
should also trigger ops.dequeue(). Or we need to send the task straight to
local to prevent calling ops.enqueue().

Thanks,
-Andrea
