Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82411E3DED
	for <sched-ext@lists.linux.dev>; Sat,  7 Feb 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770455824; cv=fail; b=EVOUHmVCBKbosKfnP42b1pl1Qc12WSb16epaRUwq4M6j7RmU1ElwLY2hhV/gECL/jzkEEgFTNMLcBCyxYDDfEPhEF/fc5k6zpoI54OoXx5e5ochTNyUqmpm//iQBPalxvO7XcDm/UmMdh9MYiQqVCVPoBUbvwWUgvouob8VQZnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770455824; c=relaxed/simple;
	bh=Kxgh3g/3KurvabKqbcA7Qs90k1TYpomZJfivLt823Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=my0Rpwuf5jjJf4njwa03P1BPfSbGd79JTAfhz6A4WyrC2sA2Za7M1J2XCrYHx4fHpXpkEx6uERg43sTCJVrnI90bV5lB1jJ8+OMS5dl0/6Y1vU+MvDNM4Qln0Kz+qzHEE97sxAJrTJBn63pKxwbHQGW+hR61eR/a//sRMfGen+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uz3W7fTx; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uz3W7fTx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V12BqcS+Mq3KPp6AVvPfqiR8sn8/nQo7FlzD2huti/SogIEftwUfhSaZ3iuvlpGD1GNw/XX3ApQkL3pETyPQe5njRt6qJKVy3TkozCM2yPlfVnJLTB4A91LFIk4h3dpB2p+SbejelnLLL4RoqEcfBmyvBOUT3+zk9Yyt1E39FZD18Bm15acxC4EgNGLaZ/94jwuHwPHd7xtJEGTLTlrQqCz8fnSf6ztlOXIf1+PQrql9C1MwT6QQR1r3weP/pLp0T4yXV88Y70o53xKbwgEuWYvg0Volvk9IxUyUMT23380I/m/baY2AnqaDqz5065tBpDnKl/19N7jLJFWmKsLwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CKNRbn2ls+WkS3jMpXfz4HSUIfBeeLH3KMsEuJBoQA=;
 b=k+zieQTbLrfKvTbXDqc2/PtDfjnNyjCihtThq/xqJ9c7U93WfCJopoo7OD/6LhmE75zOaViG2peYty+UKaJxDTAQ44I3GIla8Me9NGfHIVjoGsFhfkE36vKMdaPmdppS3SebtLJ3F7AcvrrCl/hHVF0Q+0sJLnd18lvnZSb2MCmYNN2dhdRmGOS3ujEfEt/5p4N1K+aBMP2rHQmEA4WsHkVCfvJaUdh4rmZsWfKo7baCGjAaeA5klDERcQ7qqBa0CNc/38zaaOZC+oD/V3avfRt8g2GLLUKUbu7RhfysUCBkZQVzn3Bc+OJ3pJHrtNLZGFL5Hzbs4yUSgRRhmqptpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CKNRbn2ls+WkS3jMpXfz4HSUIfBeeLH3KMsEuJBoQA=;
 b=Uz3W7fTxk+gwKaXtYKqpmapqYI0TgjSMWF+AQEBFzeyceQj5d6utUU1c5D7XjYj34ZGLLgszYDLItqInsv5AxvQYYVc2g3cey9ag94nQSwxbrEZQt2v4CR+cA5KjliHeRwNVdrp36osVwBwBpE5FcDWpwWBBr9uzfaXbCSVG7W+E5ZjjgoyU+ps2x7sSoHn5SXlQ1xeEms2dbxsIi/U3a7KSWFSGMuIbtfFWQUEhc9Y3ISr9MELpoTwQ2PmU4sMAuH0whibNf+wM//Qu3VcFtG1m6sv775pmtkMbHjb6dwb6CE3z262J1wekgKk2vqOSASzIVSB+MmdALM2obN0hhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Sat, 7 Feb
 2026 09:16:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 09:16:56 +0000
Date: Sat, 7 Feb 2026 10:16:45 +0100
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
Message-ID: <aYcC_aKj_tO62rXZ@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c947892-bb4a-4051-ba04-08de6629a3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QeyvhOgwIwa9VrB8LRxV5TIaEU2kho3DiOo1yA06sf/hhM4qpMBVHcUEJnAO?=
 =?us-ascii?Q?RYg4x1lTTJANVTnpu0NXPdyEinO4hrJ27lB0RaKF6Q6/ej5t6JlcESrY/0IG?=
 =?us-ascii?Q?v873zh7Dx+QUMYVzxTqW2i2KdWaBMb8kC1LoYHr55DIM+rvE5sYXwVnsYngI?=
 =?us-ascii?Q?bezSujLlHWKSlZVUyXCAHHvuD89miFnX50qt19LNH1GJ3YqbK/7hfdYeskDp?=
 =?us-ascii?Q?9plZjyBfDlGvhK6kFDa2PcauQU4W1zr1tI2wCL4iyzbZm/yeIKa8Fand09rj?=
 =?us-ascii?Q?po5kMgwJvtQMJFG18luFBFp3OE/Md+jETor6hVpiCK7YktaDlebc3svjsMQe?=
 =?us-ascii?Q?AorzM8SZDLgDq2J4Q29/bqNHraoTBQYxeRL3jW1FreVsB35v1McthD8lNvVq?=
 =?us-ascii?Q?Hsu8EE4W24ty9PX2LnjohT2Ee54DljX3hQTlskCkRfzvYyhaAGlojaysqH3A?=
 =?us-ascii?Q?JwOPUE4pu6gm96DuyXm8IV2/cSzBIQ+vMe3yE3RPo0KBNlFOEqo5Q85Su4i1?=
 =?us-ascii?Q?EqPfggWI8FNAnsP+CjKNhO3ojgMgq8uvG3boW4YwwMPK3HqCApICoNw2VR1a?=
 =?us-ascii?Q?d77J+BJ746YECvbBJ7soBL7ufWq2T5BFC1vQGLA3smgUU/j8vyniCNkZ1RVV?=
 =?us-ascii?Q?Hlg66PG2yji9QEEqJy4sZ4BYaEIOTyWWupULj4vjxxDeeEMxaiz3bNbvTBiT?=
 =?us-ascii?Q?yUQPezVBzQ99qe5vsn+OiamosE1vgalTC66C+Q54NtFGxvMTXEdtsqOhYOTw?=
 =?us-ascii?Q?/pFwsHq0oyo99CACsiMv6xc331AwAiDEWOyQWWSrN8MzAwRwOUgkJBgavQ03?=
 =?us-ascii?Q?34mdaXEPqfMFeLqCbNX6Ue0pOgsqS6wHAY+mAcBnk0VAiL2fjUNpYRURdy4J?=
 =?us-ascii?Q?530bwTDZ8YTI4CXZ9/eGghiwdbEvesfPtlAp4Fz308ckvjAVrX+gOHrl6P+Q?=
 =?us-ascii?Q?MPsTwPSpdp+R7R7G10wAicnYVDfGgmjaAYz8b+qU03ePJZ5OpLoqf8qqPUsn?=
 =?us-ascii?Q?DaOsnI2R7/cIGhnAo5hthtaSDLSx/r/C/2FQRXTeMIcGdIjDyqiD2M+mGYXR?=
 =?us-ascii?Q?cqmOZwu11HyLj3VzAmI6iLYbvadY65VpRWTo+sXpPJn9lBZTSYHgLJPeIfUS?=
 =?us-ascii?Q?OhDhhHrsa5jJg9yRf4fvCZobmpD2HH2P0lovQF82hwPTr2XML9PUv/Jjmvni?=
 =?us-ascii?Q?U4qrLf+0ccrsco1Mqa70ReJQdfMPRcuUaVxhprdg0XQUSiuGsKm1zr9JpFAX?=
 =?us-ascii?Q?NQC4a9SGjxzsIHFZJHat1Jm2OOvdColsfMU6QWO51eQfwKUngbQR+fh5cDp1?=
 =?us-ascii?Q?nu0G4UUG5EKKvO2A0DlVQ0qJH0403SLiiQyOHk0aRBoIEc/bZS4KSxA/KoqM?=
 =?us-ascii?Q?vnMF5+/GmpIIwr8CgTH57b0T9Dn1pnFRGMtJJm/7qPEmhhlT1Aln8IP2Qey0?=
 =?us-ascii?Q?H7rh/I7J2XpOkBQ4FEpISOKGWhPCp5J/at5zqRNXkBBjIWp3KYo6cV4puqJd?=
 =?us-ascii?Q?q2w+Xe9J7gyIxrM2YCD8fQtV4tWZnvqmkm5xvRoEtxG36IShJ/j5EdWlmeoy?=
 =?us-ascii?Q?ddNrnp5bwFlwpzsfjY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KUIK8WX9tyHdMhlwuzGLqgM1ALJ7kbO3diHi+rLwV+HDeNh3zUgRwXkPrbp9?=
 =?us-ascii?Q?9OKrN2R5QoIe/zO1DnquGfNnNV0wT9zQctl5CDVuCQTF2/IinQdwukMa48Z2?=
 =?us-ascii?Q?zjDblPZhtObL7tozXQSnFUqPKERTndHLS2tGiTTFtG9HGvLTb5dXQcKYNi09?=
 =?us-ascii?Q?ddunRNg2jp5PBEAFLZMQzz2w1QZAKCGeAn7yOFj0jUcpDMpveucukqH5vzuF?=
 =?us-ascii?Q?PpEzLVl73e748GZ8d1PTCNFpZfC1AjlrrQBy0VHV3MdwgeabJr9+cS2ZBbm3?=
 =?us-ascii?Q?17AxVEHV0rHj7x6w2B1lG00kTipgh5k87DCoSbu8eH/zVUva/PTLKLeAOt0u?=
 =?us-ascii?Q?4Z2L9e6yu/ZOgXspAk+H5OuHV38xjOFshEcLrxjuV/uDWmxfQWPpNfVXhd1a?=
 =?us-ascii?Q?7kc+phDeLzC7HEsuGrwuWLsbZj92d3kLbD50JJhgRDnybSMVMLTSbItW9VaR?=
 =?us-ascii?Q?S+QBNZwCsd6zMDi97cYZ0WDnfjSnp3wqV7625CRxOcbCnbS7BG4NuQQw49uB?=
 =?us-ascii?Q?Pq7+lTgDTTv7nusD7IL+Uh0OkCplCipVbxf4nyJV2ee6mvTwsmMluHMhRjyR?=
 =?us-ascii?Q?xKZvfrX6f1Zq2dhype48wuJq99zB3bfM6ORlPpwSnIEU8AxsjjLOrw/Ya3Tp?=
 =?us-ascii?Q?y84vaNpS1wrZ5rilzPyiZ2AAgbM5NOrqkScsd3XDUViBEMrHGUjzDvbHZjaX?=
 =?us-ascii?Q?cmqKjYvcEqwTTXxP3BdGGyJewsicvds0QvPDBYD4qsj/ENuvD2RPxXLm7nKg?=
 =?us-ascii?Q?XZQ+OX9fuoCiwhGQl36u8FC9TKaK65+UHgikbujNK/Su31v03WZttncnu4lh?=
 =?us-ascii?Q?etLh6WhgNJhwCFeadPkpaX2rXh/BKUi2qCgigOSO2O4m6+EB7x4boWrgN35j?=
 =?us-ascii?Q?LRuBQj5wg6ehJA6L2bt2UUL2h+Jj3iDhuzcvakVjhYsisRc/w0vLnbZlgSo3?=
 =?us-ascii?Q?zTKgs9fpnvuLKlT2wwjxqKY7QwfCb+5epbTX0xsFnDY4esSHdNkthy/fN0um?=
 =?us-ascii?Q?Azpj4X1MtPUsm2kwR7Tx6q1MIPmBbVB+dgjZGt/tkYTqXmhAZCpFfAVJMxoY?=
 =?us-ascii?Q?s+9Trs/OQUq1MyGP/xxJ3pe8uWJdt+0KNoZLCMxoxcUMsHtJ355dy/iHxLcT?=
 =?us-ascii?Q?puSFK5uu+Atr01y/AnAdoPmQkJbhrJ8idBvDZBFQ6oH4UGChV84VIDLQecBJ?=
 =?us-ascii?Q?rnhfKlQQAmqAfe7NtalLO9piomOBwlXwH4L987XrgAuvjq0K8ZamAd7qhnkZ?=
 =?us-ascii?Q?z1dwC/4cxeF5tI4eA7xuGHwXV3XT6mR2uuBU1lJC6lwHWG6YsT3vcoJlB+5M?=
 =?us-ascii?Q?zdNfO8macN2fPxRn7bhijWpdG3V4e/KRxNG1TX/Vc6/HN08HyE8+Bkm+0gKd?=
 =?us-ascii?Q?PeLHixPI0WujcLm+1s2DiGRxsDfd4X8SLsAfljMyfvcGR5/2gChfJ4c5/BCP?=
 =?us-ascii?Q?EUyISEvo+A1yA1dM1xc2zIrrMExoGHYS+FuvsM7Ff50U8cb0tUQrmNLJqdyq?=
 =?us-ascii?Q?bvZ06s3fQA1lZaug2NuLbjakjIQ5pXlrN9kcJEQ7AnGjSzrcjornWe7jGFrE?=
 =?us-ascii?Q?t2nQSyeAvMF4lhp2Cy9n+SaXUoHTWzcN2wi1TVwUOuzJzFdZaWqb4u/E8EBL?=
 =?us-ascii?Q?V2ExUIMvBaDDT0oCfX9/Aak/HeYt+2PoL5m9evIg2md2YKWCNuqTd+6WK2Mz?=
 =?us-ascii?Q?+iQIHLa7691VyI17D9CgTcvPwoYdRKiHWAZ+JZrzPmyO6fvP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c947892-bb4a-4051-ba04-08de6629a3e4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 09:16:56.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q90NA5y02y7gXlF1HN/O4nFA7puGbWjrpzzf8dPqzP00jC4azQfomPKtqUidCl5R7iMcxFDDz1TgMVMOoD4ZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

Hi Emil,

On Fri, Feb 06, 2026 at 03:10:55PM -0500, Emil Tsalapatis wrote:
> On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
> 
> Hi Andrea,
> 
> > Add a new kselftest to validate that the new ops.dequeue() semantics
> > work correctly for all task lifecycle scenarios, including the
> > distinction between terminal DSQs (where BPF scheduler is done with the
> > task), user DSQs (where BPF scheduler manages the task lifecycle) and
> > BPF data structures, regardless of which event performs the dispatch.
> >
> > The test validates the following scenarios:
> >
> >  - From ops.select_cpu():
> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> >        the BPF scheduler entirely; they never enter BPF custody, so
> >        ops.dequeue() is not called,
> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> >        not called,
> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> >        enqueue/dequeue lifecycle tracking and state machine validation
> >        (expects 1:1 enqueue/dequeue pairing).
> 
> Could you add a note here about why there's no equivalent to scenario 6?
> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> own tracking of enqueue/dequeue (plus it does not make too much sense to
> do BPF-internal enqueueing in select_cpu).
> 
> What do you think? If the above makes sense, maybe we should spell it out 
> in the documentation too. Maybe also add it makes no sense to enqueue
> in an internal BPF structure from select_cpu - the task is not yet
> enqueued, and would have to go through enqueue anyway.

Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
a scenario equivalent to scenario 6 (push task to the BPF queue).

From a practical standpoint the benefits are questionable, but in the scope
of the kselftest I think it makes sense to better validate the entire state
machine in all cases. I'll add this scenario as well.

> 
> >
> >    - From ops.enqueue():
> >      - scenario 3 (local DSQ): same behavior as scenario 0,
> >      - scenario 4 (global DSQ): same behavior as scenario 1,
> >      - scenario 5 (user DSQ): same behavior as scenario 2,
> >      - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
> >        in ops.enqueue() and consumed in ops.dispatch(); they remain in
> >        BPF custody until dispatch, with full lifecycle tracking and 1:1
> >        enqueue/dequeue validation.
> >
> > This verifies that:
> >  - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
> >  - user DSQ / internal BPF data structure dispatch has exact 1:1
> >    ops.enqueue()/dequeue() pairing,
> >  - dispatch dequeues have no flags (normal workflow),
> >  - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
> >  - no duplicate enqueues or invalid state transitions are happening,
> >  - ops.enqueue() and ops.select_cpu() dispatch paths behave identically.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
> > Cc: Kuba Piecuch <jpiecuch@google.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../testing/selftests/sched_ext/dequeue.bpf.c | 403 ++++++++++++++++++
> >  tools/testing/selftests/sched_ext/dequeue.c   | 258 +++++++++++
> >  3 files changed, 662 insertions(+)
> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
> >
> > diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> > index 5fe45f9c5f8fd..764e91edabf93 100644
> > --- a/tools/testing/selftests/sched_ext/Makefile
> > +++ b/tools/testing/selftests/sched_ext/Makefile
> > @@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
> >  
> >  auto-test-targets :=			\
> >  	create_dsq			\
> > +	dequeue				\
> >  	enq_last_no_enq_fails		\
> >  	ddsp_bogus_dsq_fail		\
> >  	ddsp_vtimelocal_fail		\
> > diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> > new file mode 100644
> > index 0000000000000..4ba657ba1bff5
> > --- /dev/null
> > +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> > @@ -0,0 +1,403 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * A scheduler that validates ops.dequeue() is called correctly:
> > + * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
> > + *   scheduler entirely: no ops.dequeue() should be called
> > + * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must be
> > + *   called when they leave custody
> > + * - Every ops.enqueue() for non-terminal DSQs is followed by exactly one
> > + *   ops.dequeue() (validate 1:1 pairing and state machine)
> > + *
> > + * Copyright (c) 2026 NVIDIA Corporation.
> > + */
> > +
> > +#include <scx/common.bpf.h>
> > +
> > +#define SHARED_DSQ	0
> > +
> > +/*
> > + * Scenario 6: BPF internal queue. Tasks are stored here from ops.enqueue()
> > + * and consumed from ops.dispatch(), validating that tasks not on a user DSQ
> > + * (only on BPF internal structures) still get ops.dequeue() when they leave.
> > + */
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_QUEUE);
> > +	__uint(max_entries, 4096);
> 
> Nit: Can we make this larger? I don't think there's any downsides. I know
> there's a mitigation for if the queue gets full, please see nit below.

Sure, like 32768?

Or we can keep it like this so we can potentially test also the fallback
path sometimes (mixed BPF queue dispatches + built-in DSQ dispatches).

> 
> > +	__type(value, s32);
> > +} global_queue SEC(".maps");
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +UEI_DEFINE(uei);
> > +
> > +/*
> > + * Counters to track the lifecycle of tasks:
> > + * - enqueue_cnt: Number of times ops.enqueue() was called
> > + * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
> > + * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
> > + * - change_dequeue_cnt: Number of property change dequeues
> > + */
> > +u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
> > +
> > +/*
> > + * Test scenarios (0-2: ops.select_cpu(), 3-6: ops.enqueue()):
> > + * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
> > + *    scheduler, no dequeue callbacks)
> > + * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypasses BPF
> > + *    scheduler, no dequeue callbacks)
> > + * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF scheduler,
> > + *    dequeue callbacks expected)
> > + * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
> > + *    scheduler, no dequeue callbacks)
> > + * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses BPF
> > + *    scheduler, no dequeue callbacks)
> > + * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF scheduler,
> > + *    dequeue callbacks expected)
> > + * 6) BPF internal queue: store task PIDs in ops.enqueue(), consume in
> > + *    ops.dispatch() and dispatch to local DSQ (validates dequeue for tasks
> > + *    in BPF custody but not on a user DSQ)
> > + */
> > +u32 test_scenario;
> > +
> > +/*
> > + * Per-task state to track lifecycle and validate workflow semantics.
> > + * State transitions:
> > + *   NONE -> ENQUEUED (on enqueue)
> > + *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
> > + *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
> > + *   ENQUEUED -> NONE (on property change dequeue before dispatch)
> > + */
> > +enum task_state {
> > +	TASK_NONE = 0,
> > +	TASK_ENQUEUED,
> > +	TASK_DISPATCHED,
> > +};
> > +
> > +struct task_ctx {
> > +	enum task_state state; /* Current state in the workflow */
> > +	u64 enqueue_seq;       /* Sequence number for debugging */
> > +};
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > +	__uint(map_flags, BPF_F_NO_PREALLOC);
> > +	__type(key, int);
> > +	__type(value, struct task_ctx);
> > +} task_ctx_stor SEC(".maps");
> > +
> > +static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
> > +{
> > +	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> > +}
> > +
> > +s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
> > +		   s32 prev_cpu, u64 wake_flags)
> > +{
> > +	struct task_ctx *tctx;
> > +
> > +	tctx = try_lookup_task_ctx(p);
> > +	if (!tctx)
> > +		return prev_cpu;
> > +
> > +	switch (test_scenario) {
> > +	case 0:
> > +		/*
> > +		 * Scenario 0: Direct dispatch to local DSQ from select_cpu.
> > +		 *
> > +		 * Task bypasses BPF scheduler entirely: no enqueue
> > +		 * tracking, no dequeue callbacks. Behavior should be
> > +		 * identical to scenario 3.
> > +		 */
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> > +		return prev_cpu;
> > +
> > +	case 1:
> > +		/*
> > +		 * Scenario 1: Direct dispatch to global DSQ from select_cpu.
> > +		 *
> > +		 * Like scenario 0, task bypasses BPF scheduler entirely.
> > +		 * Behavior should be identical to scenario 4.
> > +		 */
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> > +		return prev_cpu;
> > +
> > +	case 2:
> > +		/*
> > +		 * Scenario 2: Dispatch to shared user DSQ from select_cpu.
> > +		 *
> > +		 * Task enters BPF scheduler management: track
> > +		 * enqueue/dequeue lifecycle and validate state transitions.
> > +		 * Behavior should be identical to scenario 5.
> > +		 */
> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
> > +
> > +		/*
> > +		 * Validate state transition: enqueue is only valid from
> > +		 * NONE or DISPATCHED states. Getting enqueue while in
> > +		 * ENQUEUED state indicates a missing dequeue.
> > +		 */
> > +		if (tctx->state == TASK_ENQUEUED)
> > +			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=%llu",
> > +				      p->pid, p->comm, tctx->enqueue_seq);
> > +
> > +		/* Transition to ENQUEUED state */
> > +		tctx->state = TASK_ENQUEUED;
> > +		tctx->enqueue_seq++;
> > +
> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
> > +		return prev_cpu;
> > +
> > +	default:
> > +		/*
> > +		 * Force all tasks through ops.enqueue().
> > +		 */
> > +		return prev_cpu;
> > +	}
> > +}
> > +
> > +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
> > +{
> > +	struct task_ctx *tctx;
> > +
> > +	tctx = try_lookup_task_ctx(p);
> > +	if (!tctx)
> > +		return;
> > +
> > +	switch (test_scenario) {
> > +	case 3:
> > +		/*
> > +		 * Scenario 3: Direct dispatch to the local DSQ.
> > +		 *
> > +		 * Task bypasses BPF scheduler entirely: no enqueue
> > +		 * tracking, no dequeue callbacks. Don't increment counters
> > +		 * or validate state since the task never enters BPF
> > +		 * scheduler management.
> > +		 */
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
> > +		break;
> > +
> > +	case 4:
> > +		/*
> > +		 * Scenario 4: Direct dispatch to the global DSQ.
> > +		 *
> > +		 * Like scenario 3, task bypasses BPF scheduler entirely.
> > +		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
> > +		 * leave BPF custody immediately, so no dequeue callbacks
> > +		 * should be triggered.
> > +		 */
> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> > +		break;
> > +
> > +	case 5:
> > +		/*
> > +		 * Scenario 5: Dispatch to shared user DSQ.
> > +		 *
> > +		 * Task enters BPF scheduler management: track
> > +		 * enqueue/dequeue lifecycle and validate state
> > +		 * transitions.
> > +		 */
> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
> > +
> > +		/*
> > +		 * Validate state transition: enqueue is only valid from
> > +		 * NONE or DISPATCHED states. Getting enqueue while in
> > +		 * ENQUEUED state indicates a missing dequeue (or stale state
> > +		 * from a previous scenario when the scheduler was unregistered
> > +		 * with tasks still on a DSQ). Reset and proceed to avoid false
> > +		 * positives across scenario switches.
> > +		 */
> > +		if (tctx->state == TASK_ENQUEUED)
> > +			tctx->state = TASK_NONE;
> > +
> > +		/* Transition to ENQUEUED state */
> > +		tctx->state = TASK_ENQUEUED;
> > +		tctx->enqueue_seq++;
> > +
> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
> > +		break;
> > +
> > +	case 6:
> > +		/*
> > +		 * Scenario 6: Store task in BPF internal queue. Task enters
> > +		 * BPF custody (kernel sets SCX_TASK_NEED_DEQ). When
> > +		 * ops.dispatch() later pops and inserts to local DSQ,
> > +		 * ops.dequeue() must be called.
> > +		 *
> > +		 * If the queue is full, fallback to local DSQ. The task still
> > +		 * goes through QUEUED in the kernel and gets ops.dequeue()
> > +		 * when moved to the terminal DSQ, so we track it the same.
> > +		 *
> > +		 * If state is already ENQUEUED (e.g. task was on a DSQ when
> > +		 * the scheduler was unregistered in a previous scenario),
> > +		 * reset to NONE and proceed to avoid false positives.
> > +		 */
> > +		{
> > +			s32 pid = p->pid;
> > +
> > +			if (tctx->state == TASK_ENQUEUED)
> > +				tctx->state = TASK_NONE;
> > +
> > +			tctx->state = TASK_ENQUEUED;
> > +			tctx->enqueue_seq++;
> > +
> > +			/* Queue full: fallback to the global DSQ */
> Nit: Can we remove this fallback? This silently changes the behavior of
> the test, and even though it makes sense to avoid overflowing the queue,
> it causes the test to succeed even if for some reason the
> bpf_map_push_elem fails. Why not just bump the queue number to a
> reasonably large number amount instead?

Hm... but if for any reason we overflow the queue we'd get a false positive
error: task is ignored, we trigger a stall and it looks like something is
wrong in ops.dequeue(). WDYT?

Thanks,
-Andrea
