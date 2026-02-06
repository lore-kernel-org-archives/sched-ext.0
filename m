Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919834CFC8
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367409; cv=fail; b=Omkz6joBH+DX2xOcx5GkpSN/xgeq1JM+BRcdWHt9HBSgGQVxzV5aCvgxtkNdopBCDv5gCvEwZsKr+BY1IzG4lxjll2mR6asF/6dyy8cF2ijHxdKmHGgejPFr13uvonBktr/u7qRpHZDmSsjf7IaETTzL8Fdmf+zVqmIf7AG1JgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367409; c=relaxed/simple;
	bh=b5SUjStagoQ9lxiT219yK1ZE11t0K0pj/f8TORicGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RUjjrNH25hrJdEiMGP3EWF3PxtD8tRwNMDgK0u5EdVaRdaPtGdo0n2babV8914yMQzBdqllLz4DPpXK3tBis1hjDg8LsKxnStpv8lWmmEs0/2wncAe4xsSXpxbjvGTeNwSHB3XxGojq4t8bkzAMNj5FaTbYgIZVAcLrN6CQT0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Twh2hAN/; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Twh2hAN/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYfvpyO068ncJkkFmFoKAN2TGzurc7ICYRVL07EGaF5H3K/4ZLTH8dmNH31kXMyBZiTQiSrsINfANK/zJmdbtyeeYgE/Aoh2s5JypyWyS8qyzIac+x+G4G/K9HboJS41pI8nKL6cp8/SY3Un1gayAGDNal6VEpn0wmayhPt9MPRq7EomaZRl4zdz827NdxgTpHRTU3DrQ0wpNf0pQcQMrs3o7ziZYwv1WhS1ATCbEoSZKvh63VwKGFqXXPNM7GG8JV1go7WfsvodoO7aSSu6RarhwhMoZLHXwRrA59u+cwYFAoayXfafElJFW1NUj2O3jw+qpPIZFiGlaKJeZZP4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbv77GSj50CRv4kgg3j7U461Qr1xK4gu4WLlNF5AOtA=;
 b=LArn11DcwP3967+vHhEJH+k+Srn6qumzkhwqjp2e3+iOUUVVCeZdbc0UI4UpryciMSyus/+OuPhpNDczB1qhKksW28qUsda1WJpRtJ3fMj0/cKBz3geRMFftyDW4avHr+lrr14E3/0ONJM+dPB30hnSGvPRFJ2oFeYmuZk7APrOf1M5btiBtINbDDBKRvdJi6bjWyiAorzRwK7tLNz/ZDtbl3MjXBu5xrxLzGJpBE4Qoy92zxZN5Ni51f3zj6L2dFyvdnvoQU8nAB1vZ+hAFfYDbug6rX6aqDnOl/WU8YfU6RH9fAZyfXLPJeLtWmFRN44FbiEje+HepWM32D7462Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbv77GSj50CRv4kgg3j7U461Qr1xK4gu4WLlNF5AOtA=;
 b=Twh2hAN/zYsOEpbWi0eOysC+l49s/o6XlCBwiDCFwxHnLhP2dDPOGM3tkevbtpaQPHfPiMClIMEIutiv4wyLYu/lkRuZVLfoNwxNXdMEI8Ac/6LwiwXZSarqatS7bWREWoGfE9pDFcjdljBsanIyrx5yqJXkXbYeyuMjg/FI1Iwr5PjBysX7jqB9Eb4EtMX+0n4nieX740VfPLwTDpCD0cLW5hv1IraomYhd1Y/21agfneG775OPJn5ac//CEEGX9QCPBZqn/ZHuM0Qh05Vgl1rYrgfJHoKB970vy/ryo/3luWbF56cx4XdOV+jYqqyzT+0pG/5VBDBf6+n+vPmWzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 08:43:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 08:43:25 +0000
Date: Fri, 6 Feb 2026 09:43:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYWpqDtzjci42qa0@gpd4>
References: <20260203230639.1259869-1-arighi@nvidia.com>
 <aYPW121Y6vGtmtST@slm.duckdns.org>
 <aYTH5XT0YFkznqvv@gpd4>
 <aYUgQGvzJsoEaDZL@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYUgQGvzJsoEaDZL@slm.duckdns.org>
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 506fb18b-ed24-43cc-09c7-08de655bcae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdJFh8fXbx2SKEiHSvyMsbZ8tXDK+TzPZZF+Q5Bgzislv/4ToTHZD0+YR+Rq?=
 =?us-ascii?Q?meYz2Jbp+aJMjXxtIuaKJYpA/+7gXaP6wt+Su8rPybNgs5ABuzWnCdRSOvjs?=
 =?us-ascii?Q?Qcaj5gpcp5SOs71TWW/gdvYRNvvg9VQklH5vLdn4SU+BiO402UG+xjpPI67E?=
 =?us-ascii?Q?FzuVoF9ot3chJzcl1d50ioVrzWb/dswDKReRwLwXKEx5kr4SdZdtxyZAPe9q?=
 =?us-ascii?Q?2pBMGwrB5pcMl+VuUMRcQXFK5DVeZHoTSvGZlLNf78E+B3Q7/wmg3BzzRFy8?=
 =?us-ascii?Q?Q/W168jPFbDgb38DR2SRbjU8dbDy3b75WOqfusHjNEkxM0sokblwTYjibN6l?=
 =?us-ascii?Q?zfZB7VBPL/D5pItbl+5VQgT0pYuzpGvqblQDQYwnC7j2rfg2NZ9QEbVXzT9I?=
 =?us-ascii?Q?aDUQN/bTDANim6OyI9FS51fEV5cReYFqLxd6GCk1k3uEUUlyuhlTC96nDY6P?=
 =?us-ascii?Q?HWXnHySl9f+XWF1TbNliBkWF2X8A/MYCdR3Y5ggKOop6w7YMB6GQsdK0FJEl?=
 =?us-ascii?Q?I6sGe9agqMNUDqz3Mwo4lI4+c2npwoAYM0m9HhjtFxVLg9Eu6rINInMcbdNC?=
 =?us-ascii?Q?flM6PYjoztpTd85t8Y2rPvrMLFZ7c7vA+tPyjcwl+8Pww6m/TU0UA8anZBKJ?=
 =?us-ascii?Q?T/gna39+mQO7uUkpgokWosQO7y9IAWsBJCTZr4yrli58PQPiUIhFaCN64Wg4?=
 =?us-ascii?Q?6oaOVH346UCZTcb63cwPubO0catzltoTRr9g/Aq7mRhwQjb5QuHuqfvybePi?=
 =?us-ascii?Q?mG2Dsm1LNd8XW3HEzXQbX77R//VmXFlJClgamCLtXZDIFEMIeXXg5kXxOaJe?=
 =?us-ascii?Q?MKErGCpxSrTIxqjNb7fT2TnN/WgGOjp8Gnwu/jKi1FznPbVUhG+3t5HFGMwQ?=
 =?us-ascii?Q?faQBXopodRAXLY3+ul9Ef2KMsfdEDQIXpHMY/JB79gJLKos0lk4qQc2IzXxG?=
 =?us-ascii?Q?MJZdZWTE6lKhS+Nm+delORSiLvc8z/cqt0/HxjO45S1w0oOv5+zf5PNHYHUv?=
 =?us-ascii?Q?GNxLASmH3V/ya+rJK7D+HJ/HxbvvkwZBszXx22Qkyu5c+Sn++L88whlhXTbq?=
 =?us-ascii?Q?gX0nNstIhyn+rtaPdoNKuTRlvqTlAFRpKN0vwMrnln6/nu4t/9bmbhKmBd5k?=
 =?us-ascii?Q?dnln9SgVn1fI6YcFi551egJzQkBj1OE0eELOCe2hI8oS3TvWoPdyqLQGFsSb?=
 =?us-ascii?Q?6F2yaEsdVyC2bKaeORIEVpraW0zWHG5RYOuAIPuOOXEyixyx7Q7Xx9QX69ch?=
 =?us-ascii?Q?8rG4a0RmRMa3LGzq8TrhE4fxk4BezPpjABqcD/cLkwWc4u2ZI6o0WT53zLI6?=
 =?us-ascii?Q?T6xwFskxCp1ZhYYbfFf034h5OrHqb1SZOI/1MdaySvK6+TVM6hLPamOgpS+3?=
 =?us-ascii?Q?JjCzI4qbZawPJWqVGKe8ghEC9ztqAc7N3Uw0QlrR89YbHVOfkFJ+p2cwHUAq?=
 =?us-ascii?Q?pd12z6xMGhf7S/NNufrvKbxontIicrloqYRX/IqdDAP5tnOmWZA6ErCp5aD5?=
 =?us-ascii?Q?kC1PPlWAb0Ylzr6AOnJaWlcB3rbCouPDCPj+ar7hpPvpr5vAqO7b2Xd7DHgX?=
 =?us-ascii?Q?HWbaoTjINfsMAwyC3n8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duA1s99G+BzqGIGm7j9llhQaylxEIcdkGgxx0A2qJPoZ2QqKZT878LNuZVmu?=
 =?us-ascii?Q?glL1PNC4ZLhiyEywkLc8ywmzsfUmtNDCwuvundPXE5+RemyHenX8NtH6ve+a?=
 =?us-ascii?Q?f3kavx7a6dKG4LqXMgYgo5UYb4E4bAD56vStknH5ickvocPPu9HOOpoQzwu/?=
 =?us-ascii?Q?/HiIEbaDbBqpf8tV5HqGHIHz9vw4vNtFOHp6p9rpdX6YEUPIhHG7y6gDnr4w?=
 =?us-ascii?Q?o2yDt3ZijugaBrpu9IH46USGv6rAl+nj1MpPDA6058EWoIVg2R+dQWnu+cmX?=
 =?us-ascii?Q?5wwba/Y7z/F6SIQysAbMskeOqGzr4p0pkeq/fL2yuXoOpNOrVsScYdGa+reX?=
 =?us-ascii?Q?p+Apov94QUhr6jjA/T8bmcZQUssswvxYjlNhFicUHAKd70HL7NkoZb+E8pSd?=
 =?us-ascii?Q?S/q5h0rx7vaZOT6Y7W03bX+ZzJWQTan6DT4Shvii0pitAuOS8zwL+HNVPgei?=
 =?us-ascii?Q?JhJ1e1uzCvG4rGysF7y3VPsbgukb20xh5jVDYJ/cgjyST6cZxSaePZmB5iOu?=
 =?us-ascii?Q?ViBvvmAgcTga0GY8woCKcsNyatJWKrJMZPP0XEFjPdfL5YVM5pSjfUlB5i39?=
 =?us-ascii?Q?/YX2bQ3DPS3em91SLxz1dJ6fWAyg1Ty2JMPx7tA8s1XWLJOnmCcOGXuuNboP?=
 =?us-ascii?Q?DgiK51jNTs4gkQIEn4HIZK0ZrhZSGcYImvie0wi/edooVCK37224uQOkH25q?=
 =?us-ascii?Q?UNdh7ckTuzdVywf6IvGwEjnLNORLTT33gILu302rrHviz86R3sK6xqvpvoVg?=
 =?us-ascii?Q?Rh8ot3Jdc1LtV8u/461mkWrrGUCywWtThUz9CE5V4WB9eKDIljBF8B0zzvUB?=
 =?us-ascii?Q?RmuC2kMzLz7MBnIqNYjfi8FjErq/wFb5IMlsVPgilh6aNpfMC0NJOLBOeAPp?=
 =?us-ascii?Q?PNjU3/A+hsAcpn/GN6SIBRWTNMP2WcivAKZpTmF0KIVJ9lCNLLfjWDyTCQlF?=
 =?us-ascii?Q?AmRO+EI7aZB6YdoYqnlPiZzbkQprRQ73+l+Jguhj9WHgc3cB8SaBITFRrIBR?=
 =?us-ascii?Q?7EIwWBw9RjnQtKZPCN/hfETJF6uia90HPE8JrhzcF8DyWCFvdyRmpWvb78sh?=
 =?us-ascii?Q?zePiSgUR2APHiKNGfgJLJQTArANGCrfcu4mjgG8C4F2zpd6jQXIiv7X2hh+R?=
 =?us-ascii?Q?CRR6cASpe4+35GfFu8IknwlVSJ6rHcBlwJUiX0KErTQ7vVMqTCvMe2zNhcJa?=
 =?us-ascii?Q?dZU8BJTfk3E1jbW1uf5yXiyBEC9FXYAeQ4IJRe9eybFXbLzZPT9kDLzvER/0?=
 =?us-ascii?Q?GfIAxmQd12iyg7O37wsOv6fZNa8lTM6b/64iLPdqfEIuaHikgvmEHImQetv5?=
 =?us-ascii?Q?hBh2RazkHFlX6yybbGUJ2GPGKzY/78Jaz092Zp+6fHNH+hfZR7wPRgA5Ilrh?=
 =?us-ascii?Q?ob8Vr0VqNv+4fS5PJ9saQVtx9J6eocCwHGB7X2wJ1FmRMUfD1YvHxi/mug8Z?=
 =?us-ascii?Q?a+qbKCgUDMsJe8FHIaTY7n3GwgAsEYISouknt0VS3UVwP/HEUia2BP7eqcds?=
 =?us-ascii?Q?CxvpGOnoBYi+cA259bfhr9ggrsWv5B8CdiD98tCQuuNrgagnsXJh1yEIpw80?=
 =?us-ascii?Q?ptBzNyhu0xZJ+pwAH2UA9YR9Ho+52v1X4lPvdo2syO6oKeaphIfqQ90gEwoL?=
 =?us-ascii?Q?Xxp8Md1w1ECQF12MEZjeyyWIrJq2CSqdd/5pID/79bAbgs1Z+9dqHmxNyWxV?=
 =?us-ascii?Q?CzLX+NZMdRdB6o7KusjS2K9sNzbEcFgWdtRDH1Ep78KpaN+n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506fb18b-ed24-43cc-09c7-08de655bcae4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:43:25.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1myncw0NHfkwvacIgLSYAdjg+8KxHG22OogLgcQ44ev7C72tasyY7o3GoWbvbqQDPAZMk24geaxOP9XIjAzSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775

On Thu, Feb 05, 2026 at 12:57:04PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 05, 2026 at 05:40:05PM +0100, Andrea Righi wrote:
> ...
> > > It shouldn't be returned, right? set_cpus_allowed() dequeues and
> > > re-enqueues. What the seq invalidation detected is dequeue racing the async
> > > dispatch and the invalidation means that the task was dequeued while on the
> > > async buffer (to be re-enqueued once the property change is complete). It
> > > should just be ignored.
> > 
> > Yeah, the only downside is that the scheduler doesn't know that the task
> > has been re-enqueued due to a failed dispatch, but that's probably fine for
> > now.
> 
> Yeah, but does that matter? Consider the following three scenarios:
> 
> A. Task gets dispatched into local DSQ, CPU mask gets updated while in async
>    buffer, the dispatch is ignored and then the task gets re-enqueued later.
> 
> B. The same as A but the CPU mask update happens after the task lands in the
>    local DSQ but before starts executing.
> 
> C. Task gets dispatched into local DSQ and starts running, CPU mask gets
>    updated so that the task can't run on the current CPU anymore, migration
>    task preempts the task and it gets enqueued.
> 
> A and B woould be indistinguishible from BPF sched's POV. C would be a bit
> different in that the task would transition through ops->running/stopping().
> 
> I don't see anything significantly different across the three scenarios -
> the task was dispatched but cpumask got updated and the scheduler needs to
> place it again.

Ack, knowing that an enqueue is coming from a failed dispatch or a regular
running/stopping transition probably doesn't matter. And the scheduler can
probably try to infer this information, if needed.

> 
> ...
> > > Now, maybe we want to allow BPF schedulre to be lax about ops.dequeue()
> > > synchronization and let things slide (probably optionally w/ an OPS flag),
> > > but for that, falling back to global DSQ is fine, no?
> > 
> > I think the problem with the global DSQ fallback is that we're essentially
> > ignoring a request from the BPF scheduler to dispatch a task to a specific
> > CPU. Moreover, the global DSQ can potentially introduce starvation: if a
> > task is silently dispatched to the global DSQ and the BPF scheduler keeps
> > dispatching tasks to the local DSQs, the task waiting in the global DSQ
> > will never be consumed.
> 
> While starvation is possible, it's not very likely:
> 
> - ops.select_cpu/enqueue() usually don't direct dispatch to local CPUs
>   unless they're idle.
> 
> - ops.dispatch() is only called after global DSQ is drained.
> 
> If ops.select_cpu/enqueue() keeps DD'ing to local CPUs while there are other
> tasks waiting, it's gonna stall whether we fall back to global DSQ or not.

Well, if a scheduler is only using DD's with SCX_DSQ_LOCAL[_ON] and a
per-CPU task ends up in the global DSQ the chance of starvation is not that
remote.

If we re-enqueue the task in the regular enqueue path, without the global
DSQ fallback, the task will be dispatched again by the BPF scheduler via
SCX_DSQ_LOCAL[_ON] and it's less likely to be starved.

I think if we just drop the dispatch without the global DSQ fallback
everything should work.

> 
> But, taking a step back, the sloppy fallback behavior is secondary. What
> really matters is once we fix ops.dequeue(), can the BPF scheduler properly
> synchronize dequeue against scx_bpf_dsq_insert() to avoid triggering cpumask
> or migration disabled state mismatches? If so, ops.dequeue() would be the
> primary way to deal with these issues.

Agreed, we should handle this in ops_dequeue().

> 
> Maybe not implementing ops.dequeue() can enable sloppy fallbacks as that
> indicates the scheduler isn't taking property changes into account at all,
> but that's really secondary. Let's first focus on making ops.dequeue()
> working properly so that the BPF scheduler can synchronize correctly.

Ack.

> 
> ...
> > > I wonder whether we should define an invalid qseq and use that instead. The
> > > queueing instance really is invalid after this and it would help catching
> > > cases where BPF scheduler makes mistakes w/ synchronization. Also, wouldn't
> > > dequeue_task_scx() or ops_dequeue() be a better place to shoot down the
> > > enqueued instances? While the symptom we most immediately see are through
> > > cpumask changes, the underlying problem is dequeue not shooting down
> > > existing enqueued tasks.
> > 
> > I think I like the idea of having an INVALID_QSEQ or similar, it'd also
> > make debugging easier.
> >
> > I'm not sure about moving the logic to dequeue_task_scx(), more exactly,
> > I'm not sure if there're nasty locking implications. I'll do some
> > experiments, if it works, sure, dequeue would be a better place to cancel
> > invalid enqueued instances.
> 
> I was confused while writing above. All of the above is already happening.
> When a task is dequeued, it's OPSS is cleared and the task won't be eligible
> for dispatching anymore. The only "confused" case is where the task finishes
> reenqueueing before the previous dispatch attempt is finished, which the BPF
> scheduler should be able to handle once ops.dequeue() is fixed.

Yeah I think we can handle this in the dequeue path. I think I have a new
working (maybe) patch. Will run some tests and send the new version later
today.

Thanks,
-Andrea
