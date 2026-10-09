Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D836B907
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579836; cv=fail; b=VOgVbVOKA+WP//lXnnxd1OAHG5HSirhQH1lBdz5k5Uc/U0JzNYrNdXNOchlIFwl1u2vwIluMjDG8u76ljRCza0kfKPaKMy4EgR7rvrQ95V1T93O9DKwdziwecOVApSQ9fvPk6lTBISt1CezERMz+xnoBjJ347hAsldozdETdoe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579836; c=relaxed/simple;
	bh=6KHGrFJbW7Bn6R08+MrgAdjGBucrVfTE2kcTuHQlDY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8JNHCUsnQyvjwW+eyiMCqjmc2FunHlL6e919n7cgv2Tl5CH4hMMmAKVjXyIQJanBO2kvIww8g85z3g7LbNozGHPzbLec9c8TF9E7wYiCi+THcWlNff1g0O1bEhe7PLrL4nRbbmYQx2gLgikmzC3WaMqUajCo5Lg0DHBR50EGi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFTYyvcX; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFTYyvcX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGzEEhySPa6cxtlAygfK7QONyOG0eRWBYnoD99+gozUmqOtoPCV2SyF4COwH5MM3t3fgyblCQ4rZov4nHm2xcTmR4hTXqPrGoRs3v498+z8ox2zo879PkGnja2dWNB+JgnpJEQyhz2TB1okLfdwEBJaIHtI1nk8jHEPUNMAqReHk360jcodZ2ARFcIk+Fwz/3y9n6ArHONEIl463OL/17g+cMRc0RP0fuS80jfo9k4BHd6KyVR8j4zFZypADaCCjiIJBAD7ylFRhfQ/ZDuLSBSPwC8iRmcF2sGKYbJYKHdCKOoVDujRiJFXasrNeVVUtldFLRsdy/E5BmTn89t0W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHurk+vZlgvmCzAgOOx9LcqKudY+mKaXaZIH6zK5Vok=;
 b=PkP3tNWL5eIp2oe8ovxETzOfN8ZtvY5O13kiXgTOxKY8kCjIE2yTrxTycNX9Bjp2iGZ4NH3nJIYd35EHg38B2EEKoC8SjpthUc96g75Iv7ZtySSkkqCl04Jl8EijIP1PGhVcd7AbxkKxTRHNE45+IgCWHA/6Ty8OYYwjfBsRSr4UtE2ctko7tV+pNHuZ6repduJ088af2sCZnZtldbwDflzoT/ikPnKsKD3jhC/NPUh4Q6nwIMxBXzuD3TvuTQtI9U0tChI6N3HkG/4fdtXm2Sk4ZPqHgg1NHDIsNc1I/kQjD6u+yWHEI1VJzaalJV3ac4xBG0kabdoI68w7rz1p0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHurk+vZlgvmCzAgOOx9LcqKudY+mKaXaZIH6zK5Vok=;
 b=JFTYyvcXaCSTo433+isfaMH6qb4ffWvz3CJ8KgFI+Wuh0tJ0ftrQVs19CdQaKh+kHplE0fa6W0LC16ZdnBpgNn3oYPsRb8+vvuIziAzIVJjzICIK3tnWwvYi8ArOdlX/l8oLlM2+4MlqCMga3KSd01MBA+tYkcoIq9JcQQWJXvKFIn8wKbZ8isHCOdS6nwVP7ISUhSuqxYuOGSZk0A3i50X6g86KlG4XTQuYHdNjA4erKhXRB5zc+wQ/R0miFkzQZ1KqX+q8pfI5JPwd54fJup6bEegWBmRoV2emiU7nlC8ljMm0eTRgxZYybD3kgb23k+JQhrMSet3XSb7Ka9OSsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 21:03:47 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:03:46 +0000
Date: Fri, 9 Oct 2026 23:03:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Add NUMA balancing
 support
Message-ID: <aslWrnlHYy9b5lEm@gpd4>
References: <20261004072901.3579967-1-arighi@nvidia.com>
 <61b9a8607e1f25ffd316f13135432581@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b9a8607e1f25ffd316f13135432581@kernel.org>
X-ClientProxiedBy: ZR1PEPF000077B1.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::426) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: bde13913-bc4a-4b8d-3ee1-08df2648cebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	woBsj9i87WRw0UlsT0GG9x6PBHgKJqY6BuSW4fQ5xjJumbxE+W9ZtJm3ESMVqCy5OHBTggLFxDOicL2qgzDSCSS2DswOjUqL4PoIjBkdvphLjXi8b7jApQCVVjaw2BI0MJLPGVs+ZZEijGjKbwcSrymYTh7Twtv3CFTwKLx9HfYAFoiiWC0IilgEEfmcXmfX8iLK+pOaiOlxWlCDGPSkWkBlYw0MdSHz2hG+wUSCRERjOBq6zMLF6JYynKSGPjku8BlpcDdiCpTA7f6Y9Rer80RcuQBs/oh6h2zFEQRNKbHXATn6/YmcaoHFjLvNlA+AzqlDvIjXC4Ax6XmAbudCyyZvC9jXzsHJTQpKnU9mIR22RmpibDhBu7xqgZoeDzpUNYpjYahuevgH1nCcYESTW6EfYnaMUoNVExXi2h1nORVggc/7bauSYU/ShAjS7AxbR8hBmBkygYRsqDap9KbVUf8U9V9ckIT3RcIe8lX13XZzTx5MgMfIxhBylen0+AGomPFeYcGLnEmIj7NINKdLlXkQHoeMopc7nnkHad4xs1eMwAQCvTw8YqhcKAOkRuLSae2QWRVySV3oEFV1QQDFGwutP5G3TsbMyCJEd1YeNfj7hQRIsRWWMZaQkJ6k0qHsBR6yy8IZSCaF067iQjnaNz/urwFShMjybpIs7yoQlFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?saK5RUwiBjnVERoP/swtPAQ9mZYyWUIpHUZ63c+uRzbKYplTeMenlLHTF9LC?=
 =?us-ascii?Q?JJXWZ1oEEVQqOMkWqXO7x/B1jH7UoBEIbeJoHxQurTZef06yfP4dMt+5T7YP?=
 =?us-ascii?Q?3g8Cv8IpWdy/bsP76QSN04w/Hg53OwilemH3VzV/UT6bEaoYte6qzWNDMCaj?=
 =?us-ascii?Q?6tVP7OHuHGAsaDtN/JSnKWOpZt/gib8FTVYZNP8/xoQw+bqosQ3+B8OAILTF?=
 =?us-ascii?Q?Y8cN9tQc6FRfZ8ub+kaZdgfWV8/TdCQFh5ZCoACpQmrRqnEoD/ox3Ubr7Mof?=
 =?us-ascii?Q?NBUTIcWvTZiWNov2w8Q5P/WXAHUIrpVGcIKTLRiBKNeMSs4OiOTQGNRPa3Po?=
 =?us-ascii?Q?8TSAlS0p+C/0JM+htgQXBEP9cwNEaGAfSGQdj52FKpBbRRBv0NUmxyA1cEwt?=
 =?us-ascii?Q?8UN49oXJNjAwkKS6qhxpedjmyEXROwsBVTwOWoae+zVtAHcB3QYLnffFbN53?=
 =?us-ascii?Q?MO0iVAnCgL4eR/qRfw0nQiT5MyFOmTJ57hx1D4xtO2Ur94kF2gPsqpBqVmi5?=
 =?us-ascii?Q?QD9zRxdtiWYKQACRB+ahTgjN2u9UqFYKoj0ApN+aShPW2e71UMT6QnRDmygo?=
 =?us-ascii?Q?TcE+Xeh4TlhryTF7BjfrP2FXBA9N4KlBOXvgijyzCUSsIXlp0FOOIYoP1x7L?=
 =?us-ascii?Q?3SfsZIKUoVNMmFzmfRadWGRFq9B+54lJ1JNLAVhhcg6wnZ1bW+DMIjHCipKi?=
 =?us-ascii?Q?MieOER5PWdAX1qFOej8J6hcMFchhlEeBFT1Gubxlg+5MP09IkXysZkGTsTB4?=
 =?us-ascii?Q?U2WaGXpu5pkoAKHotwbv/x8LAZgxo2aEqtjZik19cdAtaLry7kfwoHqkMEim?=
 =?us-ascii?Q?xtlG/dykjSJpJu+lJDTlKNS2u3OfZnVbqC8aGWU8hXxZ4uIDHn9wrR0gFWvD?=
 =?us-ascii?Q?V/8gajqmZrbDYjHOLVJQ8ZUUnpJyVSYuX+bIpBYW6gPpHG4WfLZNycAfH32B?=
 =?us-ascii?Q?8w5yd5UUflaWKziU67afoLIzn8OxlsczZNXycCbeSQe1T3IuXy/A9zqaf1et?=
 =?us-ascii?Q?bRrS75SynaIdzejOcNTbdasJB7viyP3h/bBlKKgL/mgHSfA6w9/rSx2icHbd?=
 =?us-ascii?Q?87aictM4Dut9be8wIhL9FTCz8zIXi2efYx/ihBx+f+UotvAKr/xmhnVv2/Dw?=
 =?us-ascii?Q?5tLdlA+Li0aubRCx5029LHSJrnBX5M8fomW2QSDe1sadr/wZcFd4BjKlxcKr?=
 =?us-ascii?Q?mgDIb7PIM7Y3X1JKvJlVQgnYFwZ4b42uBEs2aJAPm8gUqp1lfa6VJOgVGWgZ?=
 =?us-ascii?Q?CgIjdoLJHRs4Ien0dRFnzOO7YFFKrK96s/EbIUkOCmE40Wo33krrPRagQX3t?=
 =?us-ascii?Q?HwSdceVGLVD92hHeCK4/erqAhDVTwfRJuoVsTi8JQgL1fnPSMpmgBUWSD4Ix?=
 =?us-ascii?Q?IBVteVMJwaUOJ1XxtZjPwoP8T6eI5sfKFOH8STPPR2RY4vpla3Gv1eFg8Gp2?=
 =?us-ascii?Q?i+OO+hRH7yLtGoDeuWvjIEV5Qvj+rVJ/TldHPdwSyoOICu6tLXUx2xxyiTcr?=
 =?us-ascii?Q?NSzbvqe/MFSINCOH0tsqji9TtEbdHTJHGAPHZS2rm/aB3esA8B428ShqfzBA?=
 =?us-ascii?Q?e/4OSqXdzZY3aq2v687+BJEKQhEZQ2ojEc260TqQfkJ6OTH0vKO3fOHYHK+E?=
 =?us-ascii?Q?k4DgnxBn2zxSfLWpoxUFgXSCblvoNUe3SGB44qyxHNhFt/2FTFQjPATNIhrZ?=
 =?us-ascii?Q?1GDhiod3v6CsHWKoX74LJS0UFz9hPydMsLqq3b0l6NPQSPwa23LWiJZ/DjZa?=
 =?us-ascii?Q?BLhtGILgXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde13913-bc4a-4b8d-3ee1-08df2648cebb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:03:45.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGyxb6ZUwhCvgENSxWjpTMasaqcgOmpMrgxJZYMvfA1Mx+o7eMOuWh5nbyUuceZOdunnKtxqOuvu7GmVT3L/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688

Hi Tejun,

On Thu, Oct 08, 2026 at 08:23:16AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sun, Oct 04, 2026 at 09:27:06AM +0200, Andrea Righi wrote:
> > This series lets a BPF scheduler opt into the NUMA hinting-fault scan with
> > SCX_OPS_NUMA_BALANCING. The existing scan is driven from the sched_ext tick for
> > the tasks of such a scheduler, and the hinting faults then work for them as they
> > do for fair tasks: the kernel maintains their NUMA fault statistics and
> > preferred node, and migrates the memory a task accesses toward the node it runs
> > on. The tasks themselves are not migrated: their placement is left to the BPF
> > scheduler.
> >
> > The resulting preferred node is exposed to BPF schedulers with
> > scx_bpf_task_numa_nid(), which they can use to keep a task close to its memory
> > when placing or balancing it. The value is advisory; nothing in the kernel acts
> > on it for these tasks.
> 
> Is there a reason to gate this on a separate ops flag? An alternative would be
> an op which is called when a task's preferred node changes, with the initial
> node reported on enable like ops.set_weight(), and enabling the hinting-fault
> scan iff the op is implemented. The scheduler then gets an event it can act on
> rather than a value to poll. The node has a single writer, sched_setnuma(),
> which already dequeues and re-enqueues the task under the rq lock, so the op
> can be called from there the same way ops.set_weight() is called from the
> reweight path.

Yeah, there's no particular reason to use a separate ops flag. I think I like
the ops callback approach that reports the preferred node and enables the
hinting-fault scan when the callback is implemented. Maybe something like:

  void (*set_numa_node)(struct task_struct *p, s32 nid);

Calling it from sched_setnuma() under the rq lock should also simplify the code
and lets the BPF scheduler update its placement state before the task is
re-enqueued.

I'll do some experiments with this approach and send a new version.

Thanks,
-Andrea
