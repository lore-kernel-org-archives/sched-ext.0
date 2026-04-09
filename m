Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C03126DA
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743967; cv=fail; b=eWCdsiNTGi8xeFA4fY2etfRSAbvF4USJn8o6EbA7Uzz/sOnm1YQ3QBXo2J45vySSicqyO0IkTljS2B4JPYGfqSudZ7KsmrI1L5PB6ChfcHQUtQkb/z4439l7IryUt9aswYpdof1dCEFn7leclm5aYzZfjArhapLy0iYqIZYB4fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743967; c=relaxed/simple;
	bh=oRUSFEqftbP77IiE0um9050AyMb36coX2FM+sabCuTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uvo4bGwxN3OiZkzGeCNWRI8WeQcbGtHFoKY2KUTZaI6dVNVP8FvGIbGBWYHP0GAPtd3lt8DA57+2mCihYaFbGQSZlJ6KH4L3fb1hiZp4dlKjDcLQW3nwiXlg+it4JKPzvVR5HdrLVUVDHGvLvmZGevgC7crRF9S1SohVfA+ZTMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQ73gkNf; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQ73gkNf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX33cI8/YOFCx1rL2/RpKtFfKDqTAP0lrAIE4+mvZ6hmzfQxsFGe52rJYZe9IrBqR4O0seUYpclPGOdjMnv2DSfwM46TDKCrcbNQQkmPvUjaO6yHfXM9usz4x7yaW/InWQdYyqrifTBJ03/b4ZlTqU0f15RixyKbQ5YVtwhLEyoEeEgqkUaQ3unjb/rvbjwe+Bx011DN0v9nhl1m3KJ5Onz2mzjKeYoEwGcfEIeldGAthXY+skoLFHazDn6aBPrTuz5UjN8FDywTzThVNsPqSuj9jBaq2rRVLAjPuWisKD1asoEVU7zcalgOM6DVgziI0JdDv0PCvVC8aroI9axCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfKBEZfX2eG0qGh0PbQ2lTlo19gnxId/ywlgXcrWmhs=;
 b=PkyT/taVOt1Njz7xcIUdDmCdT610MBezvzFnBto/fFJv2/7kRZTSazIuP3Qsu5YibiDY9ZdKFsELig3JvysrWChb3dXelfMiI1VgUUYIEmrqP52hIIusWih+cSff8VvsqHZzDU7cl6sJtG4L75V6CsTuc8f40rfjguHM+LNhwotbDcsFO7sDIyijHOVID6SEhPkh2Fw9mlOwkMQrYibdLGlSOZa8YLB9T5PFdb+oTbZoIjit/cnoa6374YOZNWj5BlDDLA2oHupi1RFrA8QGfeqdf40WK18Nig870E9i99HqtWQI77YwxavFm5cDAdyqU54+jo3Z3dTEt4cPkykxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfKBEZfX2eG0qGh0PbQ2lTlo19gnxId/ywlgXcrWmhs=;
 b=SQ73gkNfIA1NwaNmzS4hV7a4Ob0wkyy06WR0OOSwH1I1c+x6FzWQPi6i463JRNQJ/DTjrHgjyy2vt0bDbVjAPFP+EG4SV3f1FEGjGDCtzQNMDCdYWEkJoi95GmNAJxqmpaYbnAnIq86I6WTcLnp8SWCnc/Sn73tndMz7JrHlSW+J98pV8G1FmvM9eihSnot0Ad1OCPpYWir8/N5we0pCG63bigRRxk3j/oHOZTwnTlcOz/N9wGP/cet+zdeajOpIYXaBRViomok0lZP9jp7mvcF+WN5zQnreaqtbvRupI0YtBMwf+OPAMQsChMGFgL7JGbN1ok1qWOIYmiVsDw33Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:12:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:12:38 +0000
Date: Thu, 9 Apr 2026 16:12:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <adezzWWsgrcGGD3j@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4>
 <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
 <adZsJZDFNgtod-Bd@gpd4>
 <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
 <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
 <DHONT6QVA0PH.IP79IYRM8PKK@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHONT6QVA0PH.IP79IYRM8PKK@google.com>
X-ClientProxiedBy: MIXP293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:8c::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0ebe22-ed69-4556-948b-08de96420e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0MrtkNaGYH4QpuQ7g0w01+6OF5Il8P9hVkMX9a2zaiymRgbKfT13qMq9ybqIBIZWZtGvyTbDAFxufcwRPyrU4CuxS8CJ0LCLvYseEfKbaDpY3nfDU79ZFYhQzBZsu6Cgoz/+7WOArrXzoMGX1+OIoFA+M1DlepnedacIjhQPPPqtlSM4ZGFZbiyJ8OZ5TPuZgtM0pYVksmcl8S570wQgsybFdpL1/iZrooybA6CKyg/eqfGp7OZsqiJvsBe/ZGdDQsfuTvjAR78KxRIbMPdkS0MPUEpPvTkXIeZmKNWfafivw+pCktyHklVdh2mJo46CgCPRR5dk+b1qK5EKtbsJWaJzFHfNrXrZwl/zyCestheXyWAK40AbRz8nmqFXU4iPGFtqDUgsluOKKtwefP3HS9l7IU/sIwb4m9/VEkLW/lH54fE9K88otsakJPPZaXDUy3ueshErtuaJT7djejUvlzpfKvz4OYtkVHAX2Od7AUEe7UkbhDVIH1ByymUrWzG1W7n+050rbHJqhA1LCoVJ+7c9qgj32j7pWIffINbCdFAR1VicChurBcXYNNFlGXu153agvml0brnGfrr5EZwpoy4b5LYPW9hqLim0dxM8Wu4QIyg9ItNl84tGacdxFD+OGIEoxhJ0q4iYvOOAcX9MBmnfGDttq95ezu4Zic78eWcGx3dcbuuZ8KvT+G1OuGRnkFuQgxQ82oEx4fBBpCi8Ua0DPxMG0UjQaEnHNbjX4Vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKIQOI037WGQkufDdorgqeC/DeLjjtbP6G4iRpZCRVemXEJMvJ53kAkQhwY+?=
 =?us-ascii?Q?vwNf9j89tJObHsZ5PfOdX4L0wUOFrGJTZ+EP39lyJEMgSJeSRJAmfO1OPoTi?=
 =?us-ascii?Q?Yxvl6VtJgZ/z6K0fnT+t4CnbUBW6mP0G4SnxWFqrOfbIRhDmrvtFfqXkXckv?=
 =?us-ascii?Q?/o3Q4QldazWPVaF40mEvSSpjXkpgLbDBdQGKoLJW/6kmUeV1gwTNepZpNBCu?=
 =?us-ascii?Q?07sZ9osUP1HjacUfxJiBLEI65J3ov5XLvD9ZnLsOJC0nJJFL2ylLjzMgntKI?=
 =?us-ascii?Q?iZSAumdhMn5H1FkixFlVLZxF7N1gtfl89twCCrw8b3NuF32l4tDaJhlP59kt?=
 =?us-ascii?Q?EppyCZ7QEdf99fT4nc/apX6y38Jbph2QHa0IFyneO8f5EvbjZvbxIAfoTn23?=
 =?us-ascii?Q?bqi2ZXJ0z0ngfecXCLhTCo0XuQWKRdPA1Uk+tcEc1pJwy67dZkKabvZg99EO?=
 =?us-ascii?Q?PyICkEDv/9lXWcHRW2f9Psoam8SembxnGRALIOqraNCwvfwQkiAIlYiMx+++?=
 =?us-ascii?Q?CgaI+DSWOm1WZsj2mpMYMK3PeT/ui51IlQdSv74z7aaPZ0L7od2MA+/2iSO5?=
 =?us-ascii?Q?R51ZNwp7Gm76yBGRWgRDNNzv1uM/rBK5+ad4kEa36D2o5qhHLhyJLDkwQoNL?=
 =?us-ascii?Q?lJOMVv66GiSdj7htm5j26D/M0uQ2Csv0pTiQuBsam94KNJ8blY7vI/fD0gbq?=
 =?us-ascii?Q?pW1X15k1fX377N2r4HAtAzZKH2oXKikj8MfU1pwrJvUbMe7IDBHItcemp+fL?=
 =?us-ascii?Q?DRjZrRFmRfhGDzYV+MZ9UIpkiUgGhk1wbuIEHndslpgMaySY4H19V5xqS2JR?=
 =?us-ascii?Q?5ba4Uq9IuLiV0u9/Gh2olAfeHfBj6z6d0CShuQ6lWMtvtlytW6c50aS972Ms?=
 =?us-ascii?Q?uG2s252hz+etbpMGfO46Fuh70Azi86kZUKfRg68fH5F1x8ux98QDWQJmLfuK?=
 =?us-ascii?Q?cK3R1DldW4j+bHTEnkQbfcsNHmDtsqKzEydLIUyBvZaJL8xZXeHMqyJGV5HB?=
 =?us-ascii?Q?z1pMPl1ueBMmJUWq2tvDHst/M4/1fyiihNut5wRRtgGQxgqypVn4JP8Sjh+Y?=
 =?us-ascii?Q?cASiC6jLpmhUkmdpvlauDvvtfA1LVSJazdeZT4/8Xp+PpaEwpnG2ZUqyGI71?=
 =?us-ascii?Q?GbfviuVLpuspYDN6upjOh7o6fhBTnV8ZSwcb9s0XW+vRs1bKr8dE0EJ4Yjm+?=
 =?us-ascii?Q?MPm37Z5RRWkSehRdo3v4P7e/iNTCGjck8gejtNf+rk0Cwk5Jo4wlBEIzndAr?=
 =?us-ascii?Q?d7cUSxdIliINH3h5dFG4D9KTvUtmtzozR2GVSAM9sbPKaLam8erln2C0WOtQ?=
 =?us-ascii?Q?Btsdrhp0NU6+4XJJdRXoe9Py7dreaZNjZOQjXKRmE/bDEl6UEPL60wvkazSR?=
 =?us-ascii?Q?9QwWdKz6n4/fKpoPOJRCAPoi8IAK2Rl31UP6FTQyRCBuVD68Q25y48gP6Vec?=
 =?us-ascii?Q?YgmFrUwaLGR7U2alIA6hLRT0HOVy1tIesfHV9NTa9HFQtX5RCejq5kZ0C6XD?=
 =?us-ascii?Q?wT2waPt54P9OFjVprlfHzoE+KxoYUEelozKTpENmn9B5A+TuVaSt2+hb21EL?=
 =?us-ascii?Q?L8GVHW1JAx1wqXer2+u1pBPB14t3kiki9UMOsRiEFNvsuc9wRFwx33wnarI7?=
 =?us-ascii?Q?5+931BtfcfE57FtPtKsLPtzXop2mwUsmExebqfZIAP+epfrJj2gF+HwKGxLO?=
 =?us-ascii?Q?2KFTywJUWGJHSXXD0bTTz6393ed9QPP0bdsW/eQk9XeAvjL0isNg711KU75o?=
 =?us-ascii?Q?gqVYX2gJJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0ebe22-ed69-4556-948b-08de96420e04
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:12:38.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um6Xf1laGe18IUifONZ/dqM/BvFuohyHGfulV7gIzWJ+OCv+weeTQ/dtvgSMXdP+eyRYz7i5KtY0L12Bia1RNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

On Thu, Apr 09, 2026 at 01:30:55PM +0000, Kuba Piecuch wrote:
> On Thu Apr 9, 2026 at 9:46 AM UTC, Christian Loehle wrote:
> ...
> >>>
> >>>     ops.init_task();            /* A new task is created */
> >>>     ops.enable();               /* Enable BPF scheduling for the task */
> >>>
> >>>     while (task in SCHED_EXT) {
> >>>         if (task can migrate)
> >>>             ops.select_cpu();   /* Called on wakeup (optimization) */
> >>>
> >>>         ops.runnable();         /* Task becomes ready to run */
> >>>
> >>>         while (task_is_runnable(task)) {
> >>>             if (task is not in a DSQ || task->scx.slice == 0) {
> >>>                 ops.enqueue();  /* Task can be added to a DSQ */
> >>>
> >>>                 /* Task property change (i.e., affinity, nice, etc.)? */
> >>>                 if (sched_change(task)) {
> >>>                     ops.dequeue(); /* Exiting BPF scheduler custody */
> >>>                     ops.quiescent();
> >>>
> >>>                     /* Property change callback, e.g. ops.set_weight() */
> >>>
> >>>                     ops.runnable();
> >>>                     continue;
> >>>                 }
> >>>
> >>>                 /* Any usable CPU becomes available */
> >>>
> >>>                 ops.dispatch();     /* Task is moved to a local DSQ */
> >>>                 ops.dequeue();      /* Exiting BPF scheduler custody */
> > Is this true here? Any dispatch followed by a dequeue?
> 
> The comment next to ops.dispatch() says the task is moved to a local DSQ,
> so if we assume that, then I think it will always be followed by ops.dequeue().
> Same if we move the task to the global DSQ.

So, ops.dispatch() is not a "task callback", it's a "CPU callback", invoked when
a CPU becomes available. So having ops.dispatch() here can be a bit confusing.

The intent was to describe the workflow where, once the task is enqueued to a
non-terminal DSQ, then it can be consumed by an ops.dispatch() event and, in
that case, ops.dequeue() is also invoked when the task reaches a terminal DSQ.
Not sure if there's a better way to express this concept in the pseudocode.

> 
> Of course, you could do something weird like dispatch the task to a user DSQ,
> in which case there won't be a dequeue and the task won't start running, but
> that's weird enough that I don't think we need to consider it.

Right. For the records, scx_rustland_core does something similar: from
ops.dispatch() it consumes a task from a BPF user ringbuffer, inserts it into a
user DSQ and then consumes the first task from the user DSQ via
scx_bpf_dsq_move_to_local().

But that's a bit of a special use case, due to the unusual user-space scheduling
part. But in this case the pseudocode is still accurate, since the
scx_bpf_dsq_move_to_local() triggers an ops.dequeue().

> 
> You could also have a property change racing with the dispatch which would make
> the dispatch fail and not be followed by a dequeue, but again, we need to draw
> the line somewhere.

Yeah, the thing is that sched_change() introduces a lot of different edge cases
that are difficult to represent in the pseudocode. I guess the best we can do is
document in a descriptive manner the concept of "BPF scheduler's custody" and
the fact that a task can temporarily leave the custody when a sched_change()
event happens.

> 
> So, in other words, any _successful_ dispatch to a _terminal_ DSQ is always
> followed by a dequeue.
> 
> Another case that isn't handled here is direct dispatch to a terminal DSQ from
> ops.enqueue(), where we don't get ops.dispatch() or ops.dequeue() and go
> straight to ops.running(). If any of the above cases should be handled in the
> pseudocode, I'd say it's this one.

Right, in fact it should be: any _successful_ dispatch to a _terminal DSQ_, if
the task was in the BPF scheduler's custody. A direct dispatch to a terminal DSQ
either from ops.select_cpu() or ops.enqueue() doesn't trigger ops.dequeue(),
because the task doesn't enter the BPF scheduler's custody.

Thanks,
-Andrea
