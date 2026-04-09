Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45B3DA5B1
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742720; cv=fail; b=ip+xtcUFfTuiCIVC6+bZT3DjkfOX4Gea+yNwLzNHXPPXnUsm1Y3GmUlfMh+3AkdY7CCHjx3uD8aKx+EyQ4UL9CCTv44halz7LhUu1YWBiIB0PFrK4Vfs7h7Gc0fbGAOAZNqpPkAZadCUPEH5h8K/zDi9fvCl+FtHihKVYcOt738=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742720; c=relaxed/simple;
	bh=qxwkfSwudZFeeH+Ix0xGx3N56TAOQNUlZSed74qTGUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H3UG118YLrb0/LzvSP5XeKVnN3Y/OM/zxQovpWb8nDZCmZfcf/9WUHr+qpZ917YCr4UwOmBC5o5RVt+0ti7faj+7aD9G8cJtrUBve/bPjyLuNwWedewmmrQsW1E4tJfHNAaZf031jx8TFQ2FDTN+IEfA6cM6YbeQVf0TSnhZuA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jl4e+z4a; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jl4e+z4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtJ9Up/Necbys/TqlqTQ7+dZBQpBX4RAcsO6VvTcyVAyQUK9cpwdceLbqC40/55DOXQTQvyRF/IFTA6Jr/QrgS2H45cfEEhk69aZ2X9J9Q61fQjzuNBNqsQcbFcJ2xHNoM408YOs06URrUCgsAUGWuPmJ3A+Q3c33yXogvpmothuKpnvcqyN8twBH0m7DNKzyiLQrAERoyWVoeD6miNHENS8y8cF35AZzFvhcZ21I6DB5ck9aMhtzcMCvvbWv6DnF4aoIS+XcnLzlbPzYP9bdNHml4/i6/FE36zlLbKNlI8z2X7W5zGWunykQVCuvEVwgx/R19zR85+eO2dV4ODoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db7HOVr0a8KGIbI0fkulQ3r7wYE/FRJUFcbUvVKggDw=;
 b=jZgLaEeHKeouzx9KVxZz4dbLcTRU7NfYutFshW4Wl0wqyzir6fUCxmo6oyexmV11ALUt2kavD896A1d+rR9KvnW26Urlu1IuNIgp6YlU3D7BP/kHoYNYB4EO3+gx6EKGGJDHi2OmaqpL4qHeU1SA/i438Afoqxp3ktxnunoYYOfTUgVz/VyJJ0dfKDBE8VXxEk6T2W0dndURUbIERvLAsJtS+r7W+EbCAwQJYmf7+9luaMplEfKCg/XfugwV80WeJ115/+Izq6P2XLbGpdOT827Mpvz317jWmYmlWse1JYvqAe4CY1OvwcvEujGyngrPf4aR1vUFD6nkOxKsghg5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db7HOVr0a8KGIbI0fkulQ3r7wYE/FRJUFcbUvVKggDw=;
 b=Jl4e+z4ab9lxmoeGNpJaeAKAFikSJz33ao9GOT5mPKQwiAoCS0H2HEP1iVuIFMbVfT5NrKoVDo9F6KK0NJHN7Var5Z8JmPZAn1wagg2L0xI9SYuO/SeSfX47iD8mw3i5vrOUKcd1Vg8J6CFzn8IVdZ6spbx5nXXl/wPzRl2JC3f7GuxBLjaxGWRXajkwVSO5Nidk6VxVTBlImMcuB+zMrhmXPf70AX9vKPc37FkF8dkNJB7iZqJNX23s+VC8a6YHnxrhFFnVUXyuUrnNQZ5xiYyo2Xn7zKUdGBniBub6quoaJncVxiyH8rLVQ+TBYPVO0xfpkbxr412vCvqBoUsaxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 13:51:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 13:51:48 +0000
Date: Thu, 9 Apr 2026 15:51:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <adeu61JWGDJQFpoW@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4>
 <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
 <adZsJZDFNgtod-Bd@gpd4>
 <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
 <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
X-ClientProxiedBy: ZR1PEPF000077B3.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::42c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7672c5-2ea6-4c18-4504-08de963f2501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZEbtg5i+7FsUjyQS9eUyccBlpzkCQlkxRirqK0tY547/JOWAxzinxz2nBG8Rh+/GMnVC+lCEYmpT7vZ3ZlIfoasNfK5AtkRm12kLj8rWfJB8d96dmCQEHCHyx3oeGiw/WWsCHNa39lwvXWOCKRI+9dL0th/uRthY5m9GxW1v4hmJjRnQnE3cSZ2WEFbRL7paIzHHmIPISL1LZGe5uDhVv0csF1eLJO9fQENmirpdwsIZDQmHt1hqu0lzNRBIw8lqJcpqsqp8SHd3thfCLW+dWG/K29SH3F2chHLHrztPhoEajebhnYm+TJTIitCyFgXo2t9rkjybV/R0H+FvUgX5vqti9mnllIAjsx64l6niLuEt1pUWhRSYtlgVnNC+k1jM+5NffXcF9SpV11S3/RQyQgKXQ0xYrWEnMgbst1/CIZvBfMt13cxOlNk+HB6zG+xxRXAcE1OG2nEiIyqNRf101PZt7pwaxKuyvRkx6Fryh2xv+UJb++/bnahago99zgRIW2NWKwIG9EA3YbqadPRkgEZ+9YTFX+1uFjlzdJkX3gli1aViGjwmBruDOk5C9mh8s3GW9PufZPEDmEqyOBs8CSWI/MiJOQT3pjcvGDMpwSQcsXnT8G6ZL3e2J9buLaDJuwvBi/SQApKxjptzDNUMOO0NIIVvyLz903uN8s0djPrjB+GpB/lXtzepjGUNLmtdJiayI3z/3U7uWEs0i51qarCW16jjaJ8oBVSozBZsJlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L173wP0flVJD5Sz9OI8jDT/J5ti3g7q+9hJRwTMO7XV64V2XVgyFQuRLJc0k?=
 =?us-ascii?Q?V009ARQWAwWSXqMZPezdVNensRyXHF6o2/Am+dR5SzZwOZ9Ba0qfp8xTT/Qe?=
 =?us-ascii?Q?V7rCGDGgsJdfPNOm5H/aa3hy3ducHj3pq+KLCIT8P41ct9673eXL8EaME42H?=
 =?us-ascii?Q?YCEkDoOGjslKCGfJRkw+XAT0D2fgatjuuxR2QE751Ws8C0FzdxVwuw/6++JB?=
 =?us-ascii?Q?z1keInbCFRX+YYXHwNm083Y8XgsfusJW2vYRkWp9Olg+ZfkiWpfQrZIBPQw2?=
 =?us-ascii?Q?dN69o67LXB8//t4n+7W0jumEXyG4kEkyBoumD2ec8wGJ1cXkwDsjVOti32i0?=
 =?us-ascii?Q?ZeiY5ylKafCjUAGU8nmnVt3WuX2Y+W1pr09EB75HmVA8jS8khcP7zFHgQqs8?=
 =?us-ascii?Q?CaZZ71N10QKKs+5oT8AKyYn6RO9u1Ivpryha6Ajjy1Rj3DxxPPkdnHzBZIVX?=
 =?us-ascii?Q?atMcqf9Aoxu2gVh11RuOlmtoimfGHAUGqMhbP/nc6YyTOLYeYoK0MITKFqpL?=
 =?us-ascii?Q?wCPgIVkMvorJ4QBk9yNQaKpfTcqsyN5bSh1LeYYb28tkCtJOe8MxV2LygPyo?=
 =?us-ascii?Q?9fDdAGfIEyPG4ookr+pgNEQeaX2yXeB6Rf+Bd5ne5YofLoa3OhKn9qsi7Nla?=
 =?us-ascii?Q?Thpxuf/c9uzfRqm0iNjlrDB3N24CXUVt6bnxSxaOoWWHc+acWaN7BVhxIALw?=
 =?us-ascii?Q?P2F5tc00cK7qDhfsLCSALcVlFpEeFJUkGor2OcIAa0Yl+At5zc68DhHdmEQb?=
 =?us-ascii?Q?lqqEWi8fN1N4vmD/qq3Z29z6ptlHFvtkmmxhGd7N62AWP2fdhaW7b4/a1WS+?=
 =?us-ascii?Q?ewwtGhileUUX1hJ2cGQjqw5h9WBbVbuth+0edrOeYO8D4G4FD4tvlpxBzhLm?=
 =?us-ascii?Q?1LDr3docbaBxE7vAQlYefevhtfp6CajlZMuEnUBnIGygGkd36Muwn/XIV+M5?=
 =?us-ascii?Q?E82zrNvAk2hRd1JXUqdrYdmDpGC3hyFVuSaPGZMHJSastcnlOqY21YpdKW3Q?=
 =?us-ascii?Q?qzZf+NJrrYl9S3RKn6cZIgepoLtDM+LNxbEw0NFyRmL+29eokwKM/xq1I16x?=
 =?us-ascii?Q?peXjnieIQN/LU+WcrQNkext48DeMcesXHe2iqtAj0UlgtpbXjQ0szKwhTZcv?=
 =?us-ascii?Q?+awT88SWe9RiRjhfTUly3wzB379Ibxh49k89Yjbk/zCtScKYfhPCeeW9yEA9?=
 =?us-ascii?Q?MXkR+dmej7jn2fUXXdsAWoRFgW7j6vz6pLnyAmjzu1f2pbqB+gjsm4ywNrxH?=
 =?us-ascii?Q?vES1Vm5FrujNYZKG+1IGX4oUC3TI80c2swtCModQMPGjWbl/vze7J3yuT2Z/?=
 =?us-ascii?Q?d0QaoxgxPKQ5z6SXeI0i/yEooPM8fJrQUvKli3oNZeATs5n2ynix7GkYvgUx?=
 =?us-ascii?Q?qwLf1FrOVbvejb2UWXg1bNmNve46r5+qLQf0fcLWRdlJ/X3IwROzTB4RLRyn?=
 =?us-ascii?Q?Fpf+UFt+wBjAyII3vfHlMhoRVdOTE3xVDYMVaU0rMB2wmFsSxn5wMG9Q7CPg?=
 =?us-ascii?Q?EUKFHXkLNakUPOtXGYWg+zZb1Nis0TFEB4ni8TlE35UeWTMP288zlt6tR4lO?=
 =?us-ascii?Q?opCRfxbOnRgzi5KdBnF+L7XtydHgmTXaXn7vjx2f67L6v7aJzQBZGcNHoL7d?=
 =?us-ascii?Q?4sbO4+cdxDoiayTHsn8no6y04L9Vl/7gnp2b+0HHupysABOkm4yKb73L0vd1?=
 =?us-ascii?Q?ymVsYYyHQLaotYs4Mv2dm5mzVoBaYWB4aEjdrRWlUqHPMt+OjnGfrF8FD4hG?=
 =?us-ascii?Q?c5Xb3kvUxw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7672c5-2ea6-4c18-4504-08de963f2501
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:51:48.2671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzkzAUF1O+zuBzE1L+u4nzNf3q0h1gmitfE0y6m2phVCG4TPofLMTp2AJ2CJYlU293R4QbWDV/S1NZWd8Q/eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

On Thu, Apr 09, 2026 at 10:46:09AM +0100, Christian Loehle wrote:
> On 4/9/26 09:46, Kuba Piecuch wrote:
> > On Wed Apr 8, 2026 at 2:54 PM UTC, Andrea Righi wrote:
> > ...
> >>>
> >>> Another inaccuracy not related to direct dispatch: property changes can occur
> >>> while a task is running, while the psedocode only allows for property changes
> >>> while a task is queued.
> >>
> >> Sure... but again, modelling all the possible scenarios would make the
> >> pseudocode completely unreadable.
> > 
> > I'm not arguing we should cover all scenarios.
> > 
> > I'm ok with omitting scenarios whose existence depends on a configuration flag
> > or presence/absence of a callback, because:
> > 
> > a) Using the right configuration, one can actually write a scheduler where the
> >    pseudocode is an accurate representation of the task lifecycle;
> > 
> > b) The assumptions about the configuration can be clearly stated next to the
> >    pseudocode.
> > 
> > I'm less ok with omitting specific scenarios that can't be simply "turned off"
> > because they are triggered by the scheduled tasks themselves. A task's property
> > being changed while it's running is one example of such a scenario -- one can't
> > just prevent it from happening by setting a configuration flag, and sched_ext
> > schedulers implementing dequeue/quiescent/runnable/enqueue should be aware of
> > it.
> > 
> > What I especially don't like is giving the reader a partial picture that looks
> > like a complete one, as is the case with property changes here. We're letting
> > the reader know that it can happen, but the pseudocode makes it look like it
> > can only happen while a task is queued and not while it's running, giving the
> > reader a false impression that they can assume property changes apply only to
> > queued tasks.
> 
> 
> Agreed FWIW, I've implemented a few schedulers that need to track state transitions
> 100% accurately and it was painful to get it 100% right.
> I think it's either this or we add a sample BPF scheduler that actually does
> track/validate all possible transitions per-task accurately to illustrate. (Maybe a
> selftest?)

One thing doesn't exclude the other, we can have an example scheduler that
implements 100% accurate state tracking (the dequeue kselftest is probably
already a valid example of that) and this slightly inaccurate high-level
overview of the task lifecycle workflow.

-Andrea
