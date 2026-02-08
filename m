Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556E25B662
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770581318; cv=fail; b=lTI0zMcWkCRe+E6iVCbk7Udi9KfpPVErB53OnQRUeUYWnek4owSpesTOucEwbn+lUY1/yHHR3/SM4MynZN5QczKipykgc4hAVNnaetqTJzWzffFBe54RK5rrJRFJEmVplddS7bqANRH2FyzwecOKcWhAfCj6iq6dMsbEPBNKHoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770581318; c=relaxed/simple;
	bh=1y1dv+G9/T+RjBlyD2BAHAkuZMomQuPr25IVOBc2rxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9I2VfdhF3/xbb/ocxCd8IxHsu9UJL7WIh6hSbu5HwX+ffNuhJz/OFrplusm6GHSIMMdAeQucS5wRHsIgzqnSFj5RHy72ijMM2rllqrWjR2SZgfcxV4N0D9+qv9MHF9OZQHEX8Q3VyvLIDlrvrskdYKJUhV8mMzbDyrUUOp9DqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKi/ro3M; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKi/ro3M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJJgfDeNbwkvWAi3D8Nb5NlirKMXDq4OFYjdNVstMNYZQBVySEx5rfel3CZqR6BGcJYfBN4pdyX5QXyDc19ve6Q6jxYVfaMsSeWiKeEECy1O/ywnmhftOzgD79+WTkEsoKH1l2HFU5YpzpckJv3YXuYF6NcSmDKOLgpbakg7jnCcWNOM9oEcOvlRVgY+Y946k+bQiepMySL5oLqq+ah8lHqfgWYJB6MvtEk2kJNuEYsc0zlOyHrlgMie3lqnIv0w/aqqcZMFvMMxiz7xJgP+Uox1rTFZO13CikMBkHY26cYQyP07nnpX9dZHVePc+3htYKxC5t0m3XnMrXJvGAbE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhvHrmPP9gGOKHogdsmRziw1qlNJCJpvnEQMwUDV4LU=;
 b=olH/QRCGYDsMUkpmw9YwK4lp2JeGySdJx0Tl6VNMbgQ8aaMbDuS8kP6WtIe53FTc1n6hu76jvZXcd102h9YWex4lepWg2vI9dNpynCqdkBk9P3edLrQs2QOFJiQ8kGIjvaRTD3RvY7udQuTwXlasVM3KQqCdDhKArZeewP8U9mgiHFryO5GkM6IQ5i0TCfjN3tNzOFI5G+RjkoMDd3jCdyiNiI7fMMxEIoQ5RVUyf2ehxt927Lk1/b1DkoTRfssWQgu7FV5aFbSG1P5QjIL0/2l2wCLP03Lpx7aRWRGj+XVBNzlhxvN31p6ytqdhxuqr6z+gjEPKyNmRQ5g+qjeriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhvHrmPP9gGOKHogdsmRziw1qlNJCJpvnEQMwUDV4LU=;
 b=iKi/ro3M3CzajVKm5bCDSWgCqXgdMfqQGATUID1Un4cI4yAefi4VD1fdXVesob3GrKval/VMquJEVULJOB2/GJFjBLcPykmxjPtFET9npUUiesD8Qa8Anee0hg3gLUluI0fZbQ8Jj+szzxr/1ESpYSNNKxIqFnNUwljjf2boyjaXcbMioA9sUFyNabtDblXZyDzc5RvC8+nZpWcptp2M2eQ8WyjmgElSvbinNKsKsCyzaW4JjLL1y2ru8G5A2AD06pPvaIbzXiIizD2nYDURxuiyaCfI2ifYLHvDaHQSfrvS7pht1FVBXt32C+yoTh4ZRcVM5neN0XPqSyLEZWPHtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 20:08:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 20:08:34 +0000
Date: Sun, 8 Feb 2026 21:08:25 +0100
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
Message-ID: <aYjtOQP0tmGIqoOM@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 46168a99-d518-4c7c-33e4-08de674dd37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|19052099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnTJK+hcjRx2wyAYZ6X6w8RKAKwxFJx3oICumDWmIG2F4iRcdMRcCIg2Rtod?=
 =?us-ascii?Q?tUPh3DF2a0XvibS4zSQMiLaAbYQ7haC5VpJdjC1JlTE8TucyOjZrKNCIKGcU?=
 =?us-ascii?Q?zkfCHmHH14hZjRhxDM/OvBsYOPp6sAj+fMLrXOmJYWEn6+KTyRBKE6MeaH2b?=
 =?us-ascii?Q?vYAUcF0qu8HZU78E1809FUH+oy8mcEcB1dsJvm2zYZ66Iv7gYuT7tY/6F8On?=
 =?us-ascii?Q?KEtgUSV9qNF5Jdewyz3vSyfOCZ3S81AYANpcM5oTuENSiCZKVemXMFFuR+MP?=
 =?us-ascii?Q?W1nYVZBa9qTBrPMLdGpX6WegRGdLc2O7Pi6VmZx7qsaAsWthFV4Ohwci4Yoz?=
 =?us-ascii?Q?NsKMdJ36P+m41mCH5m+EHga8ct2fAu6TMYL5tJN62qi7hSABYWB00vwR4kAB?=
 =?us-ascii?Q?aJCryqajc+MADzy1SBuKN2zEviYJNK2npTNEHHBOcKOW7Oxp1plGIfKbFKRM?=
 =?us-ascii?Q?DmUHXRLKxgTWqp0HJ1NuWlCGStiaxtCHv3tVJ4iG9SKe5df9fmRbCuPAnxqY?=
 =?us-ascii?Q?AT+iQjUTU49aWbPqeDnBpECVoVfaQD1caJYd8ywiWkm4v2j60sRKKsJRPGQ8?=
 =?us-ascii?Q?sRlROvntjsIdhyajlvH4ItCvnzMkn/NbmwNPTyhvKXQSTfXbVpFF63jwjQVL?=
 =?us-ascii?Q?z1Xkjr5jCmaCeXWXodGRTBhGmo9J6JP2pPBb6oGd6LUWeHh7Ubxd9BXwhV8h?=
 =?us-ascii?Q?gMgqWY/Z0+4As0AgB+6rlQASYXQ27UEBBypQsv1a7YJV709wH5+F5pU2XI4U?=
 =?us-ascii?Q?ilJm6hKeJW0gU36cUijgclUUXnYNIj8nvhy/AdKn0KAKRBiJ41fDunQSPSlW?=
 =?us-ascii?Q?0z8ug+WRrstpVzYA3D9jRQ6ZujTtbF1NzVvTsx4DLl0fMdnXMIMlIauBrFWg?=
 =?us-ascii?Q?VxQoIEUdy6UkhMbBIxcF25DisKfSqYP1zWRoPjPuuyKfhLrmtNqIYcratR64?=
 =?us-ascii?Q?PI3Ok+GjBJIOlxSSFfkuLoxkhN8BPT1xgSsLfm0Vg0e1z6/f4YXj0QcUUwbO?=
 =?us-ascii?Q?wTszb2dCY/yl2yKOhKNR/Gtlg0ioWamMFQpOJRDFzml+NwSS9flXOs9Aj0b7?=
 =?us-ascii?Q?3ASnyMd2uKTFn25rOqx82HhWbsGEqecFSYiEQMy9/ua2iO9rGlS0w/vzYSjA?=
 =?us-ascii?Q?JwpUYj8mhNDb2qZoRPsUZLh1aqmgRCuRoGJGslEBNbq1/31OVzo8p7vkeQeL?=
 =?us-ascii?Q?yg9M5JoMafwnsGW5NbqCYcURgSfYdMYV5quERJ1iVBe8FR9JpEyEDW0xqxTw?=
 =?us-ascii?Q?ca3dFM7Jx0dgROJhTea87Ncdg96ukkcDSQOCQJhiEoGXg5/+d+yFkto5m7W4?=
 =?us-ascii?Q?9r8jLtflpkz/nO+KPlFFfIWHV67+KQgHgRC0O9MrlM3riLlREx3xRzIvseY5?=
 =?us-ascii?Q?scfzM3utd33mxWWjJTjIO+HKjrhlczk4QSRjl0iFcUcWuMcyUYC2z68j4aUz?=
 =?us-ascii?Q?xE0BWNwymWnjPAhAR67YfrXDQUO9I2nqpmGLTafB3dVmA5QwqwayfYUTzCHB?=
 =?us-ascii?Q?RX1M7noZWheCB3Yn9OVWzCunkLwse9PhEpn9kdn12jooJubnFXxe1rYNa18n?=
 =?us-ascii?Q?q42epAGcp3fg7g8YA0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19052099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMIonyWv1rGMWIN9tw9xiehyFsCzo1tpNTrh+LfzB1zPatOcy4FwDWEnG6MV?=
 =?us-ascii?Q?/Bif98+y5nolLgp6NOJ9HCaYrz7KCL1PxVS3qtSYAWPYB5eV6WoxZpi/Yc2O?=
 =?us-ascii?Q?eUassITwY/rGHkzGcYyNiQOytnqVJ3m7sARBWsBx600wy1NCifYWqLfBCmvr?=
 =?us-ascii?Q?QcZUAbp/BdicOiAaVemZkdUnUSGkYEi4ZvuROOKYEAldJdKbAd4+sVw/d2sG?=
 =?us-ascii?Q?899qUptVJ/KUHup+tDckjvw/p1+gN8MYK/3tc8gqPvGzBeA4hv9MG5eAp2ud?=
 =?us-ascii?Q?ZUfQozTaRtP43ZTFhMDwVSntuMkpVbEfZZnQF9Vy5UWSjSukP9jLR+D9I/Bm?=
 =?us-ascii?Q?2JQgYCrTa3o08t+FvBCqS0tjIf8iKE7lMzh/wl7QxB+baFhdMlcJDFpaHgoO?=
 =?us-ascii?Q?xHwLkipC3F6uZU1+dg1Tqp6v7rHwtIkIKtjbNZnhhsAQ8iXObIkzAY4Vxp15?=
 =?us-ascii?Q?v/0nvu2s058oulG3fdp2jf27JzMIvIzObKSxcW6Hi8O8l9TV3jMafWePTH5i?=
 =?us-ascii?Q?+x8LHprrIg8t2wCAzwq1wHLPNWqfUqhqbYyLAScvP5Ov+zAzE91yNTrMi//s?=
 =?us-ascii?Q?LD4xivbVCz5eRvYbeO3S1DfLB+xonQRhTkepnpipqhm7MsVnsbOnmsAoU+uD?=
 =?us-ascii?Q?xEOXZmVZZlFlPivTQ+8qUDcieifhxoj6dxHpKtItFigTnCPu19/AnJZOtFks?=
 =?us-ascii?Q?mueyMBxGJhklpuX3hmzPA3i4sDSA6iv+OcE3l03ab0T6kaH0PQnrtPWKMpIk?=
 =?us-ascii?Q?d/RKoR8oXXB4689zQPHtdAdZNvVqyVWCa9/qBpY+Iq0+KUg18wcZAZMkAeJV?=
 =?us-ascii?Q?Hr1mc8jFfaRoxcB+HmvORfUig729iyc5z1zsZzmDm/11UmdCxPNf05jswgI+?=
 =?us-ascii?Q?jeCc8saNqbvcaq65ULFJ7n1XRx/t3IkI5AKL/hJ6wogfztVCwJ5gHwWIlUwd?=
 =?us-ascii?Q?Ow4YKaII3bFEkjN9fDVlujOFctDKzWiJZphS5l5fm4Q1vG349sTHcy7+rNXj?=
 =?us-ascii?Q?YrBYmCQrs1asOfK1ooNOOBNcsdgJ8nG7hDqkByvBPNYAM+TdLKWickMeaor2?=
 =?us-ascii?Q?aLpMjkGVGBzNIOUEf7w4L11o2I3aspxbAhrqY10bnhOelZmnSomzqZWE7V61?=
 =?us-ascii?Q?ZMFJ6gNeNxo/kMQp1UK2/iIsJOwfcYznXmr50VIb4E83D33z92a5hgGu9F+a?=
 =?us-ascii?Q?K0eXMQ1oZGzIvf222xftRTKXHcSMku92ZBLAto5HAmS9PpGoeqGwWJKhRXBi?=
 =?us-ascii?Q?rxECqLv4dOImvYrrzZf1L6gvGHmTTYBxhJr9z2rfEiWSPtJuVlmMb43MYEqK?=
 =?us-ascii?Q?3WuFejaWX3AB2Vptvo7CllED6uoacxYLHqLkO6WzbZRlp1X5GaYfakX9SjPg?=
 =?us-ascii?Q?o21Yw3MJOXPlypejPZj2yibTFwJaVo1m1C+Cd49IvDfrUTnA3INV7Xg3ggeb?=
 =?us-ascii?Q?SwzBYxiyx9Z69kRTzxlfN4s/yj6OAl74HFk2SPgFrOEsyfwbBZdOqjOe/BSu?=
 =?us-ascii?Q?WO7a9suf+GlU4Q4L9rzDSv2qTbtYFISCNkR5WiIIHvWAjypEGj7mdq7Nn5lu?=
 =?us-ascii?Q?BMTqM1Ea9jgd7MAVwCII4jsSQnyPwoYIL+rOJP5wZ959mEj6m6zKC/LV2py9?=
 =?us-ascii?Q?4gRov+6OWLCMKEYC6gv/yHxSY5Iq4/2IJmtgGAwuvZ5P+8K3bk3O0dLGqO6a?=
 =?us-ascii?Q?MLTxW8AZxmv46iN5hBf3E4/ZTU+TBVIuayw4MJLazxUnWiI/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46168a99-d518-4c7c-33e4-08de674dd37a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 20:08:33.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHs4bvnctXJqG9lFDd70KG2U9hmo47wbEOvX+heJqZz1PWex+tpWUL3p34fi0BE9bCmY2eT//SIn0ifHh21Ieg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

On Sun, Feb 08, 2026 at 12:59:36PM -0500, Emil Tsalapatis wrote:
> On Sun Feb 8, 2026 at 8:55 AM EST, Andrea Righi wrote:
> > On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
> >> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
> >> ...
> >> > > >> >  - From ops.select_cpu():
> >> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> >> > > >> >        the BPF scheduler entirely; they never enter BPF custody, so
> >> > > >> >        ops.dequeue() is not called,
> >> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> >> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> >> > > >> >        not called,
> >> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> >> > > >> >        enqueue/dequeue lifecycle tracking and state machine validation
> >> > > >> >        (expects 1:1 enqueue/dequeue pairing).
> >> > > >> 
> >> > > >> Could you add a note here about why there's no equivalent to scenario 6?
> >> > > >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> >> > > >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> >> > > >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> >> > > >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> >> > > >> do BPF-internal enqueueing in select_cpu).
> >> > > >> 
> >> > > >> What do you think? If the above makes sense, maybe we should spell it out 
> >> > > >> in the documentation too. Maybe also add it makes no sense to enqueue
> >> > > >> in an internal BPF structure from select_cpu - the task is not yet
> >> > > >> enqueued, and would have to go through enqueue anyway.
> >> > > >
> >> > > > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> >> > > > a scenario equivalent to scenario 6 (push task to the BPF queue).
> >> > > >
> >> > > > From a practical standpoint the benefits are questionable, but in the scope
> >> > > > of the kselftest I think it makes sense to better validate the entire state
> >> > > > machine in all cases. I'll add this scenario as well.
> >> > > >
> >> > > 
> >> > > That makes sense! Let's add it for completeness. Even if it doesn't make
> >> > > sense right now that may change in the future. For example, if we end
> >> > > up finding a good reason to add the task into an internal structure from
> >> > > .select_cpu(), we may allow the task to be explicitly marked as being in
> >> > > the BPF scheduler's custody from a kfunc. Right now we can't do that
> >> > > from select_cpu() unless we direct dispatch IIUC.
> >> > 
> >> > Ok, I'll send a new patch later with the new scenario included. It should
> >> > work already (if done properly in the test case), I think we don't need to
> >> > change anything in the kernel.
> >> 
> >> Actually I take that back. The internal BPF queue from ops.select_cpu()
> >> scenario is a bit tricky, because when we return from ops.select_cpu()
> >> without p->scx.ddsp_dsq_id being set, we don't know if the scheduler added
> >> the task to an internal BPF queue or simply did nothing.
> >> 
> >> We need to add some special logic here, preferably without introducing
> >> overhead just to handle this particular (really uncommon) case. I'll take a
> >> look.
> >
> > The more I think about this, the more it feels wrong to consider a task as
> > being "in BPF scheduler custody" if it is stored in a BPF internal data
> > structure from ops.select_cpu().
> >
> > At the point where ops.select_cpu() runs, the task has not yet entered the
> > BPF scheduler's queues. While it is technically possible to stash the task
> > in some BPF-managed structure from there, doing so should not imply full
> > scheduler custody.
> >
> > In particular, we should not trigger ops.dequeue(), because the task has
> > not reached the "enqueue" stage of its lifecycle. ops.select_cpu() is
> > effectively a pre-enqueue hook, primarily intended as a fast path to bypass
> > the scheduler altogether. As such, triggering ops.dequeue() in this case
> > would not make sense IMHO.
> >
> > I think it would make more sense to document this behavior explicitly and
> > leave the kselftest as is.
> >
> > Thoughts?
> 
> I am going back and forth on this but I think the problem is that the enqueue() 
> and dequeue() BPF callbacks we have are not actually symmetrical? 
> 
> 1) ops.enqueue() is "sched-ext specific work for the scheduler core's enqueue
> method". This is independent on whether the task ends up in BPF custody or not.
> It could be in a terminal DSQ, a non-terminal DSQ, or a BPF data structure.
> 
> 2) ops.dequeue() is "remove task from BPF custody". E.g., it is used by the
> BPF scheduler to signal whether it should keep a task within its
> internal tracking structures.
> 
> So the edge case of ops.select_cpu() placing the task in BPF custody is
> currently valid. The way I see it, we have two choices in terms of
> semantics:
> 
> 1) ops.dequeue() must be the equivalent of ops.enqueue(). If the BPF
> scheduler writer decides to place a task into BPF custody during the
> ops.select_cpu() that's on them. ops.select_cpu() is supposed to be a
> pure function providing a hint, anyway. Using it to place a task into
> BPF is a bit of an abuse even if allowed.
> 
> 2) We interpret ops.dequeue() to mean "dequeue from the BPF scheduler".
> In that case we allow the edge case and interpret ops.dequeue() as "the
> function that must be called to clear the NEEDS_DEQ/IN_BPF flag", not as
> the complement of ops.enqueue(). In most cases both will be true, and in
> the cases where not then it's up to the scheduler writer to understand
> the nuance.
> 
> I think while 2) is cleaner, it is more involved and honestly kinda
> speculative. However, I think it's fair game since once we settle on
> the semantics it will be more difficult to change them. Which one do you 
> think makes more sense?

Yeah, I'm also going back and forth on this.

Honestly from a pure theoretical perspective, option (1) feels cleaner to
me: when ops.select_cpu() runs, the task has not entered the BPF scheduler
yet. If we trigger ops.dequeue() in this case, we end up with tasks that
are "leaving" the scheduler without ever having entered it, which feels
like a violation of the lifecycle model.

However, from a practical perspective, it's probably more convenient to
trigger ops.dequeue() also for tasks that are stored in BPF data structures
or user DSQs from ops.select_cpu() as well. If we don't allow that, we
can't just silently ignore the behavior and it's also pretty hard to
reliably detect and trigger an error for this kind of "abuse" at runtime.
That means it could easily turn into a source of subtle bugs in the future,
and I don't think documentation alone would be sufficient to prevent that
(the "don't do that" rules are always fragile).

Therefore, at the moment I'm more inclined to go with option (2), as it
provides better robustness and gives schedulers more flexibility.

-Andrea
