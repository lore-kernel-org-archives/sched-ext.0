Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB13EBF2C
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935419; cv=fail; b=c85HGO+rBniTwauFL5VymgKn6RjEMcicftyVsf5OSwllMRrZq+fuhv3IyxRosaCgvIXLCPTiY0aOfSsQwY+BaURqnV5cIJQrX0y7Qwhbov7hu7MqCr0cTPwSQ2IzuGI/y8uQmEq/1lH3DqQlir+Eohoh6IkqPm2ym3KkJ4mpNlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935419; c=relaxed/simple;
	bh=iUz/TreILPC+SRvDMSPK8F4OfADJZxKpMAoLoNoq94Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KGyr739J4LSFkOANR41/42YNJ0N+zJo+D+r4uptTxOn9X3BmclVREcgKacPqwM12kkBpSZYFCn9JNsYuYUCrgTEw4kjFb6iGCatYZi+grog1rvXGrFL6xoejKAoIuFd7E0VxaCB9gH2idpY3lGXkx2XOhEOHU0qctGfE9npI5es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJr0S0mz; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJr0S0mz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmZQPtI/ddssCoY0OnyY/jIueUwoPMg0oITXcP2GAhyS55pft5NcvEYysW6XYSwpFHqhD4RjgafQd8T2B5f9vY10ctw2bxMgnSYR5kNETuXb/IXZqYkO3oNCbCJv8fHQp8yKig9kWkbHYUecLiOkcC3JiQuEGwkZ3OFZtO/fbt+TurEeFfkJiDTeLwqGfClYmY6HqgWqUj7JcDmK1NIWJIZ297FFXT/8WmDjaB1yjqn2p4BS5PoIIRzz9Ls/kikR8tRC5UvTbRjph8+QnjxKmlTjyj2nE48HcvibDe5iLlxqOGYEyHYRtJihNhO8efMer9+eEL+b/rintf0YBGUCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvcdh7hzwv6G/PgN+9hIussBxKrpOeArDhchVQBjXgk=;
 b=s9tLgmye1Xw7n8eL3GztDL2OqHJTypmKAIKA6iGfWqM0gKZ9+w0E2WXb7v9kA0q5OtinJvnN6exqcnHMKn9zBmfZ0L9iT+2PHHT5FrrbEC4oO9jhBXLCBo9afvuWaxpvuGp6j7G5Vmby/v9/TK3pYufdLYacXzXtfYykni5UNaZx4CClMblnHqozN45OcZWEs430PmD3azXhjvouXLeP6bYvEKT2emlBLmwnIVx7aAxuZopNiJahvGvk5gDdJP6Gc+UUaTdrpufcvbpata++AvgxlNP+kXLIYEVvny4qB0n6IRYN88ubnJ1IndkYfhe2qzn9ah7DPm7NvOnRbt0I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvcdh7hzwv6G/PgN+9hIussBxKrpOeArDhchVQBjXgk=;
 b=UJr0S0mzYXDIlzgg8kDZUtVyjiVXFPDoasvrDP0qK/6nOR9q1PK3+59iwS/vrzVb3h4fvK6/BZb1HiXrpGFXzp4AAFV39bM8Q1vxd6hXw+4gGIVfIO9q9xh2I30DfY8FGsVMKbavUCGheHCSM0A4HxLgrLrBeyv5HvIp0yKQ8fUOMAuMCv5k0KeCb4J607Lr9dPrGNvlpcsLFtmviZVEuEnLYMFHXDRCyV5JypbruTflwTbvclAnwglZ75GxJjAeBJ5HogixZ+NtgLZMg9b/LLHivtpS6d2+7DgwQ4L4/qh4NApMkH3YcYbOfsmpQyu4iu2L1umO5rVGXh6ax/z4+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 22:30:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 22:30:13 +0000
Date: Thu, 12 Feb 2026 23:30:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aY5Ua_mFijPmRJSi@gpd4>
References: <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
 <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org>
 <aY2ofYcZpni9L0px@gpd4>
 <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
 <aY31pzTFyZ-nKK1J@gpd4>
 <aY4IuX59PsmSsi1g@slm.duckdns.org>
 <aY4YdW79Y3FBM5jo@gpd4>
 <aY4di9M4BUfutfrw@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4di9M4BUfutfrw@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 15519242-95df-4169-7d46-08de6a864a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UdEOnSvGyGhfqGXRk9+11TD27EnPTApXGvuqAx+kxAm8J0t+diCq/FgaiyYl?=
 =?us-ascii?Q?PLsWW4x24d4KjiUhB+zQdQS+FsS61UBgjtk71BUrhgrFPKskj2NTDny4Uvmk?=
 =?us-ascii?Q?Y4Oq81/1zOBv24eWA07QAroRwbsBGbgdqw0Hh1EzwtTOz0q5fvJUdjVa+NGb?=
 =?us-ascii?Q?YGwy26tumbMNg00reUc8qLIsZh5IWCIXDKLjBEj+ur4gdjJ+aQPxgBFkV10k?=
 =?us-ascii?Q?kqTyGwCGtjlYayN4JHkzXsr5k0TivrWHmcx+jO+uOagcvJaYZA7sgl4FaJlC?=
 =?us-ascii?Q?6ohs5m/kiwireFCRcIkB83731cuxx1mwMlnAuqdZ3i8kc1SxMaPYtbkNkGvH?=
 =?us-ascii?Q?9ne542IRAf2TpjYAHCuROGtT5akhf4Zt4YnZxd454cjr4pGBkjucPXfJvfHd?=
 =?us-ascii?Q?qI81Y92P2NxP2mCg60wiIi0pxnyYvySNwCYnNFIojuQPLvOvMFAqNGohXGn/?=
 =?us-ascii?Q?ccVbylido8R/kgZHDiglHrD9tRHhrV+JIvbmen37G+W6Jbv32X8C4Z0neAFz?=
 =?us-ascii?Q?CswgoGkO8HM++pxffmPLD13ar/9DreexUMVzfkbf0lr6q4zSabeOAIQvgoHm?=
 =?us-ascii?Q?FZkMPAwuYpZwKwc/GDUSGgoFON4/XVHrDI/v4F+1XyRxizl8p43HGzKUDv0N?=
 =?us-ascii?Q?sOm5uSkNkKkVWs3sWj4kOGgRhiqohIRXk9p83cKp8NK7lOfgMUHL816sLaV3?=
 =?us-ascii?Q?NFeTZJB5ODZ3i/F679I2TaLOzgcoxmiBbup/Jl3JF3Jez6MZ7Ft8oSEO9Eo2?=
 =?us-ascii?Q?mMVlHBRScmt+vV9ci5J5OJ0px5g+kSrKDzdP3M6wJkE9mXp9lOAO0kxh1FHi?=
 =?us-ascii?Q?PdJSEoj0lWCpZFrWAbqrbiXUZhAqy2xktLv8MA2+P6nvZk6wZqBXq0NQvKm9?=
 =?us-ascii?Q?AU9jLwn5yLQHMJEeHL73DggCx/rtkgZc+ihz/KS9296Tzkyh/PehnFFu/+kS?=
 =?us-ascii?Q?EZ0vVY8y7pryY4Te06abJD59mznhxYbqzAeCWr6GQqmDLRU0XzBmqEXj3Uh0?=
 =?us-ascii?Q?hwg5Fz+fvLCagVlxuETDExUhMA7TtGTELzxh3JNEg/jyY035OuWoAG55mG3B?=
 =?us-ascii?Q?0IJbkC1lSNVahSNIbeOP5Eb58EL8Y153y4ImNpirsFhC20EzVlwCvcqIif9Q?=
 =?us-ascii?Q?el3tZJM0yKyFAy8Vw0H5WyI3Q2zf7fD11m6m9Zn9Lzb7Q5l2Wt2zYsr1aPvb?=
 =?us-ascii?Q?is1j5r4bVTDWrTY6+yxHwBxgP8X/a3LYjVdo7DK/JA2TcCnx+icSfWPgM3iD?=
 =?us-ascii?Q?n/OyUIfrjP6OdRI+hzkt4TH93c78Y/z2fEiOnzdMMxcLfdQ3XW8CABnQA8fn?=
 =?us-ascii?Q?Rh52SDpgjjL0ya5yA49S2odBPDavf3Vt8ki1CV17qGFCamPG9MgBC5VmcK3y?=
 =?us-ascii?Q?LUTZeBWaWTzI2ZRncZkk3oqtv+QsZBU590B34M7HJO7d05VUPDw56cZdgiir?=
 =?us-ascii?Q?rGSv/TRqMuSfI1yCEyqyKkv5lr7zcFO684xNzqVl2wNafHbdZKAZ211qzxAO?=
 =?us-ascii?Q?mtY7+jNad22WPBmxscsz4xxKt1BmECtc1Ii+tAee8XtSyFVdqbjzcqRaZKoT?=
 =?us-ascii?Q?l0sgIKxh6TEIP/+NqsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Ke7xE8Qxa8tDj67r7t5L8gpWpZl1NqJnxpx+nwZlQ+pPNmXoanWKA7LV8CH?=
 =?us-ascii?Q?U+j2YAldm922mCNSiJQbGOX6A3AImf3qilsoRFfUxk2btjuttY7vogxpZuSq?=
 =?us-ascii?Q?ELzav8z+Ws/tOFQAa2n8oqWq7z36RODv512jdKiNmEZdVAzJXfOXNnV91uRg?=
 =?us-ascii?Q?sobKav0R4Vt03YIghIIfHVWGoOMSAQrL5bA5bCjF8FtClnm3v5AyzvxRerRe?=
 =?us-ascii?Q?AtQbtOd8N1uvrIlYgz5Hsf6xfTMwsmm0pMIp4CTPhA8bQ9l5RdM0wElB1IcB?=
 =?us-ascii?Q?uovrRJhpkgWokvtJAWeqMN3d+MHHSjl3+CnMSC4nZjH/GSCqkQfO7wY0tHYD?=
 =?us-ascii?Q?sbe2EQsAY9S8ZhRUiHuN8K4NeVuzNMznCTd6Xt/uczLGbZsI2/3nq3EVO0wA?=
 =?us-ascii?Q?c04GqZzz4CONYqxRPNoBrkN/svDVWB+JKls1TgEYTluKhXd0AAfq84WmiXk+?=
 =?us-ascii?Q?ZQG8VggVV4bxoY97df1sZqiiLVwM7dMy3OAF8Dl/QBcpYCEmcBKH2q7/XAwB?=
 =?us-ascii?Q?Blm1hewtd6Ky0JeZR9WLEmZw1wvXQ1J+pZt30aD+cY9BioUUQ5UR6r/f4PMG?=
 =?us-ascii?Q?QmLjhgckKNsMlk+jwxzIWb0LWZdvy3bmfNfAZ52y+P3UkKn67HKS8InXfaDy?=
 =?us-ascii?Q?3MoFn4N4xlPs3iTnWenGyxMGJB/BISbD3aEX1NA9K77FhrWch9gnHVJUODAP?=
 =?us-ascii?Q?wG1U5g/qd6Cjh5eEemrv6YQJlVNDrnTMX+4sKBcO6mHvaB9MHJrSKljn8US2?=
 =?us-ascii?Q?aT2mO/DC6thiW6tN7W5TADcuJ7/a+mCW8Dv3X+IQI62VF1X5ybsu/A3Emxfz?=
 =?us-ascii?Q?8lzUF2j2QTbUv8woqt/u6tuDDwlzdMzmBoVg6so9l5LVys2yWoLTBCp050eh?=
 =?us-ascii?Q?h/aO+VXPC8ADIu9dJQ3dIuQ8eJZtKACjygckR/Ysa1X/H1ck+a7Ujq/rrGCj?=
 =?us-ascii?Q?ByXGzeASQC50Z7edfFDwmCxWpLeDMoYuXyzH2wyooU+0DSIixHdwVMpEfPtH?=
 =?us-ascii?Q?MHLlqWmb7WgkD42F6tyUHz14I7lv7uIU+WqnBdook3LGs7qb20TSjor+LVsQ?=
 =?us-ascii?Q?N+gQHabULyQbnSGqaQUWKViCAv6GLEG3F68Glt3JWmufxsAXl9fJ50/vwCjz?=
 =?us-ascii?Q?S8DoeZyjvkI29tbCQzuUr8Gp4GQtYII/9wfg1vM9ZKSYW5q2EmdUtoCxVUO9?=
 =?us-ascii?Q?yLsRy8JGr6ehRcuo4d+Q4oCilA3yJAF3oxQobXcj3p1LLB6o/CQynaxHKFN5?=
 =?us-ascii?Q?dbQ4cp30YDlPwqnt0L0RdK5nVJ3cIv+AxKq2io+8WzUsW4oonFJTXZ5+buRZ?=
 =?us-ascii?Q?IhR0QUnUpMihL62u13R04h5RDG1ONcwWgqsGS3aYMe/PlO1hGsvAJAHXTP3E?=
 =?us-ascii?Q?SElxaKiYHJ5CriEVbuYdnAnj4ctv3E//i3CoPAK+bs9qMRQxOZOHjdzFGiX3?=
 =?us-ascii?Q?TtE5Dvkgz2hOUO/8N+M4dthsZRITkcd4Y3pEbHJVXaL7TqLwqv5s4vSuhDQT?=
 =?us-ascii?Q?46Fu0kJJqnA7/Q8lqAP+0bPl5bnZw+YU+qSzyXAt13N2NQjvy+FSdxy+QCwr?=
 =?us-ascii?Q?Er0qEcvthb0bTkUWGhdhOfT0MLq5iI05gQ6TRpLpm2FlpCpz6/4VfKyqdtYn?=
 =?us-ascii?Q?wsxXVCqR99a7ufLuLiRetuCFryhs9wN0kHpHuyLgERwM4ReGTYR7Jkq8k3NK?=
 =?us-ascii?Q?6Fh0YCknNkOzk1Oy6WYdJ+z4a2FUjhQpgNb+LB+by2VLAh0Vii9rZ9eVSKKr?=
 =?us-ascii?Q?0qxKtjzoDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15519242-95df-4169-7d46-08de6a864a13
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:30:13.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g65Z3DqQKK49HHmsHMgAxarMVa7kLcgE/i//3sN0I9HUjK1rgr40TkD1gWOmtT3O6Km76NSmxSbzW1NUT2Rscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

On Thu, Feb 12, 2026 at 08:35:55AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Thu, Feb 12, 2026 at 07:14:13PM +0100, Andrea Righi wrote:
> ...
> > In ops.enqueue() the BPF scheduler doesn't necessarily pick a target CPU:
> > it can put the task on an arbitrary DSQ or even in some internal BPF data
> > structures. The task is still associated with a runqueue, but only to
> > satisfy a kernel requirement, for sched_ext that association isn't
> > meaningful, because the task isn't really "on" that CPU (in fact in
> > ops.dispatch() can do the "last minute" migration).
> 
> Yes.
> 
> > Therefore, keeping accurate per-CPU information from the kernel's
> > perspective doesn't buy us much, given that the BPF scheduler can keep
> > tasks in its own queues or structures.
> > 
> > Accurate PELT is still doable: the BPF scheduler can track where it puts
> > each task in its own state, updates runnable load when it places the task
> > in a DSQ / data structure and when the task leaves (dequeue). And it can
> > use ops.running() / ops.stopping() for utilization.
> 
> And the BPF sched might choose to do load aggregation at a differnt level
> too - e.g. maybe per-CPU load metric doesn't make sense given the machine
> and scheduler and only per-LLC level aggregation would be meaningful, which
> would be true for multiple of the current SCX schedulers given the per-LLC
> DSQ usage.
> 
> > And with a proper ops.dequeue() semantics, PELT can be driven by the BPF
> > scheduler's own placement and the scx callbacks, not by the specific rq a
> > task is on.
> > 
> > If all of the above makes sense for everyone, I agree that we don't need to
> > notify all the internal migrations.
> 
> Yeah, I think we're on the same page. BTW, I wonder whether we could use
> p->scx.sticky_cpu to detect internal migrations. It's only used for internal
> migrations, so maybe it can be used for detection.

Perfect. And yes, I think if we set p->scx.sticky_cpu before
deactivate_task() in move_remote_task_to_local_dsq(), then in ops_dequeue()
we should be able to catch the internal migrations checking
task_on_rq_migrating(p) && p->scx.sticky_cpu >= 0.

I'll run some tests with that.

Thanks,
-Andrea
