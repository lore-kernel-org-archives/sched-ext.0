Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26273472774
	for <sched-ext@lists.linux.dev>; Mon, 28 Sep 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628485; cv=fail; b=nAJQwRK3OY5T/QDmHZDXtDIMqDI48BQoCFr1VG/OkcvOFiISdO/DsAwVmWhZO0gqE2O8waGN1aGEFA2Q+BHI1OPdXgYFS55urlZ1M2A9G0WfbVk7ZmxlKm/qVWTbJjikqdDz9w6JbgIDrGXxBr61frEW0VKjfk7glDNMbcN1Tqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628485; c=relaxed/simple;
	bh=GeDp1HSb74G8esbltnhFH+CRaHsvgUPsVU8HS0jPgxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jz6rD+xfJzh0PpLbqiAPwx2LBeQx9adtgF6ZnicVKpndx+cRm/Zar2gVbbxR59Wn9HTcffb8rhwVyvRUihO+/ncZfQ6X7YeXH4QPZjsMGUamKK5eiSOFy1PO7UguB7pahV+yQD3n9A/JL3TamcBSls7a+SAs2g8CtKq/Ogb35GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouKOhrcS; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouKOhrcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl1hnJkq/yyQOychYhyzw3A9pL6Ai8kNBUpZZCivGEsIEBRNCpcIAePJYRsQeKjKzqZxeN0r4sfA73+wVb1WEd9pItzGhc24B8lUxZKLwd5FIvF4GB1h5dW+7n9v8ha/z7kk9isgrHsWPTxsNHCUBlkaXm9dbkIhh20EinLwNXYnUX9FYa1W/Q3qlCllDmrA8Hd5ugpFz0aYlAaW7kAkS67I0YlETfQdopJWmvwBcIewATb1ZP8fs55hameNImWFwavASJc2RGzuhrKflThx3aRvqnpeN6djm/W+0st/akadfbEpJK8W9SLm1LjfBuVASGfT0F8AzWA4tW4hNo3H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omwC7klSY45TdjfUxwFNfd1QmJVd/1sj89l1KJmkhb0=;
 b=pIDuSTRfR3f3sM+pdUXbZ9vInljUKoaRPcrtPfjxlDeYCA9oNd/JR3hh/eAeqJOXBvhERHJzt0o1gJfMwEPv26sMXWgI1N0IZB1Q1DtbZHGON/2nwmnwOjoAlLJFmGVoJ6L3Z90CnJtoEbZ1/xPwCS4sCFyHI9vsmOJbw15CC+3YH212VUC4xHK+ECy/yttRudwIdib7SnpC+N5Lycu68XaYA5ukhtXt+iRbe5keAaUvQfc6NVww5llTnqgKuzXvHYLnNpLmDdJ4NAWjWuOZ+tAFP+aFmdIyktJr9MghJPQ2ZLzXK76OI3yKuFzYemYpNDlorLv54bwcxS/tCw0rNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omwC7klSY45TdjfUxwFNfd1QmJVd/1sj89l1KJmkhb0=;
 b=ouKOhrcS7bIoYXo1GCjK6IaLKZadlJ2DmX0NWVy1240xokZP6wCUSujqhJ6wx18BDuSCRyiNGEWWWJBgMm5c+FPvXgCuDVb3r7l4Wdw17v6wrtDyEDcGEq+t3cydGmiDWb30kfnsN80YvEOwRdAeNYHWQ/eq5Wrf9KHxih2vryic5zdmyHcRB7RWsHmYSjY8Kc3iysZ3MGch5/OL699NEcZZBC3W10Yz/PWNg2vc8E3JmNdXFa2EKt6V+pW0dUoxxzkcNWJ9mQMlOc9RewOkSYhaiF3FUVxPsc97e7lJn8Ua13z0S9mgVm4d08HbS9Uhku5hLLXueMeN0KsV/k+X7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:47:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:47:56 +0000
Date: Mon, 28 Sep 2026 22:47:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <arrSdAzAUpkjbFng@gpd4>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <72d8d44fee50dc88f500bdb808eb21f6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d8d44fee50dc88f500bdb808eb21f6@kernel.org>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: f4978725-c904-4877-93eb-08df1da1c65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MkIo+LhR4Msf9ib6jF8M531JpLjbS3hZWQETTYAzK72unbwF480n03qoBsF1bv8V/GH7neboPj7tdF+2es4fxmDFK5MRUyQkubjrXFYPh2aAfftTc1b8aokPe5kcmC85wdaw/Y9dVkLb5UqcS540cb5+Jr6s3nxpGdRKADpYgTXnZ4MXBVeU2ugerP8JYkSZ6yUcIhRO33280KZEjrrcRpaoCuhL2wIzYSmXri7mFxOaDCYUI9EJlXQEFJN1asrZeGeY4W6ALNH6bBrsWifwhFD4FdiNx77Scjjw2UMNRU+bSMCTIVZp9EgD5IPGQVj25eeHzuVvQSyLjMfS4XdwgHDCyAlxjhWoVKDbAJzwIL+6eFS4BDd9SMXzqOY3Hc88SPWwXaBRH7skKRShtRJRctYc5fdJRO8yWUc78y/VwZxGxYrD3PdQWR/5GQM/zoi9hsMHgfMq354NMmd9s2F8iu1mhZeyUIGa1K37n5HQqO3NmydfmHLQQoJcihVzVsWlHLTe8WxaDXaCEMroJl8aknA6uv/FtO1MDoTtAgz1pBl/E+PT16Oai3sm0qykj//dhe5M1eV/SyKJJYLAiEKPXkPkrhOvUW4tVC45eueugWOfWA/Wa6N+w6z/h2bh2RWF9r87k3hll3Kjlf+4qk34W8mOoBsAA0usrijKLCfZER4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5SOxuRH4eAVt0uC6HP12cp9X8eSIV2Y35CBx9lfID0xQlxtZiyP7TdGsROf?=
 =?us-ascii?Q?LQ0pp0YNQHY2quGcsLA43XanH0gozqAnm1QuEuR5VrLux1OstgPJxP1lbSkA?=
 =?us-ascii?Q?N+uNdh4qQrCXOfFmRoSBqwoujxV+tMtZy4gTp+1Z/9JozvXfHXlkQgfrCF2C?=
 =?us-ascii?Q?omD2Ewm27tHQhUWa3bmwRAQkV1w0n2EfnDu20fp/AQ3BbKUOdunTLx+RS6Ld?=
 =?us-ascii?Q?3dEuaC1oWtbojNYCF7m4YAOPOryH/He1psObRy+uaI/vqdJE5kx7SQGaoNQV?=
 =?us-ascii?Q?pZ5pQnzbVBcxBZKPUoCgbahdcOn57vq6SBqbxrZShSLXG56QAVGUWQLKUt9j?=
 =?us-ascii?Q?W+swkk+QxrNnOWHSYXqCtbNwyXRcOm05NzsFXOSPjfX70SQUM/ZAMhUKygMc?=
 =?us-ascii?Q?e550PVIAxcxQUZda3KYRQqSmD6t6x6pGEOBbLfUlQQqQGyOaSOcUWPjA8nRD?=
 =?us-ascii?Q?sbOTNucTE8Bi3JwSL1iNB0x4cM1/z0CHsp+9tKqDeKbH5PV+kP0kAoCW20oG?=
 =?us-ascii?Q?IOqOaN7e+JwwEhogADhfiTNCy067Dfc+R9sVd9alfmQSruUjGi30Dbv9j7UB?=
 =?us-ascii?Q?HUXaXGdHkdqIZtaf1TADrH30QhEJDMMDSQLVKalCQtFujGFTTwLH6OHzT6BW?=
 =?us-ascii?Q?n+mp04pvin17of/DGcQ288Na9ZKt340D7ZWxvqXuImH+koMYgXYtCi2bXT1S?=
 =?us-ascii?Q?fYndXIRP0MmvazXMAwZdH5+kZ/Y48DHJNwihg+pE1nBwPXw0WjHi28EJDEQ3?=
 =?us-ascii?Q?6OPQvgFmIjpb9hXN5WDUbeORXwjw0WJNIkpVZel5xUk8b2gUrklL3mpyPUvb?=
 =?us-ascii?Q?EkiWPNjyQiiSe1zkEFviJezhxkAX3buwOfBGYi+Z49zK8JpTeNwvtqRKgbQ+?=
 =?us-ascii?Q?Z6/GJXyAdXWDsHdehEPD5wqY1fpoSNiWoeddGoRS3o5aDbHQWzHCKoHKJiUK?=
 =?us-ascii?Q?5OsqmrLjA8hSs/nTcImx5qLxczS9rReJ9QpfCJ3seTfOCA/zgZVMHCguIB0f?=
 =?us-ascii?Q?XsifBrm0w+acvMU6vZ2aTigunAKgBNC5mxjt3hYVESr88WQnudrRkEvXJzse?=
 =?us-ascii?Q?Kk/VYXToZ7SrpzYxc+LACXRDNVDFSkSUpKNV/WX+uhanOKR/HvqYuf4BnYWN?=
 =?us-ascii?Q?wI7wN2pNSE039/ZBvTFoW3wZw4RdFAnlC8w0rj57Ry83OMkRfA8SeIUjpJl+?=
 =?us-ascii?Q?obhQEe0e++H4HicgvFb25GSBDLOMALfm1V3Y+KQpvP/QlUyMoQar5q1eyts8?=
 =?us-ascii?Q?L0wvQx42lC2YUw5GMP5uxs36w9g7c60mxkRAFadr0HxYTUN6N3hRVWw8BGG+?=
 =?us-ascii?Q?kqsIWZQXDmStE7SlLOoezPDVC5Y5bYYvy6ZIjpFVTfdBCWNX3yazL800O1oT?=
 =?us-ascii?Q?WZRLny24k1esAEagCArd0kLnFF8GZ2yxQFiS8bLfGPxTUuyVx+3PORFtxux0?=
 =?us-ascii?Q?EOrOA5iDU2UWcLR/Ki2wmg/7XTdwhgFqxN1LbxTbUy7JVgmt/Cffnt9irahC?=
 =?us-ascii?Q?TVc5CYnBAQh78YgemJmUfAGQ2rbsR4rh09QI4FwIZuwiadP5nXgAMxfTgKPM?=
 =?us-ascii?Q?z9fUrDkP6BESbDQerDNqO7ig2xREk73qqF8d6mcapqLO9AOiqClTBzrRBGVY?=
 =?us-ascii?Q?wQqXoEb0jVoNmFssv0cWhwuAxNVqjq0TD17ly3xaIRcKPvRHlSzgJqg7MNzp?=
 =?us-ascii?Q?h3RGhpirfE0YZfEmT49aMt7DRkdrKT6OHxZSJHNgUEyf1Z+4QsNwDQxiP1De?=
 =?us-ascii?Q?pOxJHtOSKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4978725-c904-4877-93eb-08df1da1c65e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:47:56.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr5QybWmjzJrljPXrXF1zC9zgVAmDTi+9RMYmunf+jEiJzbtoiZIi+2mNONjssEGBXhP41q8j2JLbg5xO5YSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623

Hi Tejun,

On Mon, Sep 28, 2026 at 09:53:31AM -1000, Tejun Heo wrote:
> On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:
> > Andrea Righi (16):
> ...
> >       sched_ext: Block proxy donors before taking control
> >       sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
> >       sched_ext: Move reject DSQ draining into core
> >       sched_ext: Generalize the reject DSQ reenqueue path
> >       sched_ext: Handle proxy-exec races in remote DSQ transfers
> >       sched_ext: Split curr|donor references properly
> >       sched_ext: Track proxy execution for NOHZ_FULL
> >       sched_ext: Delegate proxy donor admission to BPF schedulers
> >       sched_ext: Add selftest for blocked donor admission
> >       sched_ext: scx_qmap: Add proxy execution support
> >       sched: Allow enabling proxy exec with sched_ext
> 
> Applied 6-16 to sched_ext/for-7.4 on top of tip/sched/core (be100c77178e)
> with the following conflict resolutions:
> 
> - 07: sched/core's c72945693b90 ("sched: Restart fair hrtick after same-task
>   repicks") changed set_next_task_scx() to take enum snt_e. @first is now
>   derived as type == SNT_PICK. SNT_REPICK returns early as before.
> 
> - 08: for-7.4's 7a919c7f86de ("sched_ext: Test scx_has_subs() inline before
>   calling sub-sched hooks") split scx_reenq_reject() into an inline wrapper
>   and __scx_reenq_reject(). Moved the combined function into ext.c and
>   dropped both from sub.h.
> 
> - 08, 09, 10: Kept scx_reenq_wait_dispatching() from 7de9a6fb44ea
>   ("sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task") in
>   reenq_local() and scx_reenq_reject(), after the new proxy retry checks.
> 
> - 10: be100c77178e already has the fixed scx_proxy_reenqueue_retry()
>   signature, so only the body was applied. The rq_owned_post_enq() comment
>   update was applied over the context changed by cb86607ada73 ("sched_ext:
>   Don't run ops.dequeue() with a DSQ lock held").
> 
> - 11: Context only, the can_stop_tick declaration in set_next_task_scx() and
>   the rq->donor change in scx_rescue_timerfn().
> 
> - 14: Context only, enq_blocked in the selftest Makefile.
> 
> - 15: dispatch_to_rescue() inserts without needs_immed() per a0d356696f87
>   ("sched_ext: scx_qmap: Do not add IMMED to rescue inserts"), and the
>   rescue comment keeps the for-7.4 text.
> 
> Can you please verify the result?

I reran all my proxy-exec tests on sched_ext/for-7.4. The conflict resolutions
look good. The only issues I saw were unrelated virtio console warnings while
testing inside virtme-ng, fixed by:

  b144dc5a2414 ("virtio_console: allocate the port_buffer with the caller's gfp")

Otherwise, everything works great!

Thanks,
-Andrea
