Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12F27AC57
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920744; cv=fail; b=O2elMRmZO/2pEE3r3Cm7dSRo3BDXZqg/0nbBFi4d5loOhFUebHuxQDjHa35bWBDHxtaL4CeD/dxu247yShqQMjKyp3o+CgqCdAavVJwMUuzt+uOQddcB2v+N6H37ClbRhHzgHCx9qZDyGs9WjG5qbsxgTnVSf55AENvEUv6xWHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920744; c=relaxed/simple;
	bh=Je9ndPi18TTDM05DlCDQ7kirp7gGCsQQQdx6yrTYogA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f87aC5yqRn5nOikHrXg+S3hUz6kJpwL2sG71EznAXujUbR6LY9IjCxupgVVf/O/mETxDbctjr6bYqjZjhXKAfmZ2PS+U5BCvKsLpfLo9ABSM/NmBElEclYKRsaqtthcEqlIrC2NZciHbzlKDLkcNioNifd3/4f88qvAMykuoveQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T0tRNkNn; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T0tRNkNn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEyKrjmSBMbgnnpSPasM1YrrRACWmKBmeiiZsLWIh+Tu31AeCb0fuIOND1TgcqCV+ZklNfnGEdZfpT3evMZ8W3iq8Rx9fr46Du7krNSOlBdLHywhip4j/mJ69039i8UxabWEHVk3Rq3m4D9RpgM1JFi+kQQw7u50kHiT5IksI3W6+OJn0ZaxQZfJ49jpGloSoDQ1HsrS1E5yUobt1meKpfmLKoo9zYUo179iiiCbziz8JQDs8J7g8Z//LW/cGFfXDYe+RlBUEe2EPyP30uRSSxJYEjyLdk2xHXalNzDtXs90Vaf6YG4QP5MqGYAm8cK2XZPHl3jP+zINmGilefo16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kdSO6f3+V5FrZt16ip4N+SZYWFI+/ZPU0tukd3DmVE=;
 b=Bp/tISLeS6xrb1fXrOkqbbo9ifNW49Jw9jm+qtiDkeHRqQ4gS06yq2QyDXb30zV/OjGqEeaoE35c1f84pc0puzzcM+IOS/cm2Sz/YeFwDqpFVevKhEBpwze2oOBP7nOqPxrSnAc7P3rdsVeDSroFGEneFizCU+iKnlELXeCib1gd29xajSv41vbzzdMUlzDtVdreU3d8b2gSh7xHE4XgtR2nny5ue68RzrlfB3V4hZl7wEoYsEYuboeQSxzZ/zBdGt8g/z4LAiXSAEoEG5miGi82YN3odCYKtBBPe1/luKnk/RzDlHwmYxZGVG8B/lWeVRsBlHtdE9W58+m7Lf/UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kdSO6f3+V5FrZt16ip4N+SZYWFI+/ZPU0tukd3DmVE=;
 b=T0tRNkNnEa19FJXqvgAhk0d1U7/PFbQR6JneFKEdCnVpiUh2axLyil6MuGmqGq9Q18+T2fNR24LAiN/e3f+Rnk0jgz6z24fxIR81aps0GKJtNRIaefO/zgWyiShrua4T8qqnkNnNmz4JSUjmmX3GvQpMk30zRE9/FYOHyBG5PwW8GzlkAYxCpPBk3sx7TZjGfdFCUrZqs4HPBWPpAk5JteNtc4OeRlQLYYQ7NEwW4MWB/2vH2UgfHXqv3LxEniI+wsHhboPkyrZXIr8+nV7Pc8kNSh+92wu+lRQtqbSC4Hrq2CSiA6HyTy5qMW1/DMQ9o0ll093pO6jX/zs2xSdcoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 18:25:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:25:39 +0000
Date: Thu, 12 Feb 2026 19:25:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aY4bGgHpz03iUusM@gpd4>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-3-arighi@nvidia.com>
 <a1538ff5-c10c-49dc-90f1-b6b6e9b1a7a0@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1538ff5-c10c-49dc-90f1-b6b6e9b1a7a0@arm.com>
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: b517f98f-ba30-4d52-d697-08de6a641f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yLeTuGZArIRx7IUdKCad3wFXItwxestcSbskOQoD7dUCN8XEqaRZD+yWR4GI?=
 =?us-ascii?Q?/JbygDxP8ksrX8zi4nnjlLDOMwtSVeT8/CZPhgjLa0cvi/3yF4jLXfLA59X0?=
 =?us-ascii?Q?2mZr4eCCmt3f70lAet7qRlkZiIPoK8kBTRKrRGNa859sGKkpTcmmBNgrrken?=
 =?us-ascii?Q?h5VuzehzvTK1NV1c4Dq2NThv1LIZ6yxk1rnrP4YZX9uBqplEx8fY1+1LJkIf?=
 =?us-ascii?Q?VjEon69uTo5Vo5LwoQGxx/2tO3KRceM1NcKzQIwujyLo5tJsY/RATHwlGWJM?=
 =?us-ascii?Q?ZK52BEhHm883gLfA15Mz2a4TxtvRsiSybGTD875s5iwPUuo7l6/id7XR4yjg?=
 =?us-ascii?Q?XmTbLQ/ilfaMf69kIswGrYwc6vRChRPe6iVUNJXt5OysLe7xy5DEIetOGOLt?=
 =?us-ascii?Q?nqyuAMNKXPyVYk3RBWcjwxOtzyei1W5BoC8iJ2HkYrNB6tBn/qkCEaxtCuID?=
 =?us-ascii?Q?BH9xEXx70lz0XaJNxltWevFAi99Gb3Gx+E8D3kAlR7Zaw4/S2g4jWAHcEZTM?=
 =?us-ascii?Q?2bSt5fEoAB4mxKGHIBADrvLc0Iaa6uzLwLBSruAOadQecbOiC5FIDPjTbOh7?=
 =?us-ascii?Q?LCOUn9u9zxIEMe7UdXEs4S/tbX571qAyrdoo/MCSMHKBmO8FM0te3BytGWMU?=
 =?us-ascii?Q?LbrAvuP4QPnuwKSnsTJ0m75OqoOdZxby+gGKWt7JITdAWYvoE6FU5+eLs/C5?=
 =?us-ascii?Q?uxCRctWMuqxpTIUpbR1NCPRX30a4pLeKr70RkRuKxE3wYy1BWVVeyESlqPjV?=
 =?us-ascii?Q?Djyxpw2HDcF8JoRmF5v22DydvOD6q4OGefkDkIK1yANe3q8rpKv4Webdwqay?=
 =?us-ascii?Q?dW6wyu6x2Ceeu7y7t0iahCIofAA3HH89Rgn0KDxOqZdWfbNYR1V1Dn0xfK5s?=
 =?us-ascii?Q?S3GbpbQnXcniXcFd3BLhYrRzVLDYwRsxr9JP2K+YGdLk1alIJurTN3CXYBlk?=
 =?us-ascii?Q?6VRU103cSlQVBgmKr2iRw7RZMzWqP+5u1WCosg912OuNYp5/ydDKHbM8KEY2?=
 =?us-ascii?Q?N7qLASl8YPBaEEn9YV37rcFeVmSXW4NwUZK0LZpxgI7E/jYBOL+KAuftjRHt?=
 =?us-ascii?Q?NtBC4lLHlKq0u4srFuRRs0T3IxE+7LIxPDhtJOvWTfiSNzjwWm70LU6rDqwg?=
 =?us-ascii?Q?9J0+nRWuFhVnIt7AWTIAVBmNE51tYoXZ8RvJFAwMsFJa8voqUTkS1spIOeWG?=
 =?us-ascii?Q?7/F8H1PBL+6t2/sRmJPHIRTyvGqjRfHNbGBXUouHzYpEKOPzkEMVN2I9DNNR?=
 =?us-ascii?Q?QNL6ok66gG/HJIvWUorbPFABWJ2UT23WmiQKtroKp6NRVPzNDZkrcXXVA5EO?=
 =?us-ascii?Q?Ekc36n45i4QABxlYNFMZ1qvKpcHNHX004Hk6mDKUt7+4BL57o1CI8t3JkZ1F?=
 =?us-ascii?Q?Z246YR7MymgZK8Jk96PNzz8pnFgA8nL+6jyb/pZxMFpK+C61HHUQHPDSotYz?=
 =?us-ascii?Q?g6v/9HS9jjL0drfA9vJRTsTXNZQk9J5xezJ/yqb0k2TNRO8PbKVAEkCKCdM7?=
 =?us-ascii?Q?+ZuXMxZKzocAv8X5sBCyrJusK2BHkeOYSBshJWTweCfzPyEBCUmZY6zwW0LS?=
 =?us-ascii?Q?TpKepXnb3VJcY3s2aNg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVQzrUwqJc4EEmgvrPgPBykK94ag1c+8txxuTKWe9cnvAfXPHgeGJAEph2Gk?=
 =?us-ascii?Q?fvSkjXuLw36j69y2NpE0NFoArdX44N5hBJwWblPMxjvVAzi/ULCioMbm9LzD?=
 =?us-ascii?Q?mA6TcsEOK2bIOH0J0McSMthmL2fXLAQ1JQqCSEbAGcTSsVOXC11WicJ86lth?=
 =?us-ascii?Q?NwkQ62ilsmiTvWeXL3KJZiDYMILEe5ESFUtAxSFcX5lrpuT9V3+XVsvWsnKh?=
 =?us-ascii?Q?/nBNuET2vcSbXogjMQn+fRb7pQv/4uSGWe4odY+Y2Vb8ORkutWAjD8ku91fF?=
 =?us-ascii?Q?uAkWzcsIuQjkF2/EzyTTav2Dxsv7pT0sy+38qj5wjMtgEPmtCmOnkJTw7KHc?=
 =?us-ascii?Q?SPyAvKBuuzFtQy+nLRDcham/n5MIZHdBQ44r5QqNRAg1SXc/iN79BR4MXL92?=
 =?us-ascii?Q?WVaAtZyBWEa9K+fTq/yfhWho3jQRxp2aheRgt14Z5Pw8APBekIc3AAgNXo3R?=
 =?us-ascii?Q?GO129d+afLZvw326nCJHurMsLw4UsLBEYJ9RD66yj7bB9RJ/zeUfYhqG4+GJ?=
 =?us-ascii?Q?eJQ2V1eKfu7Am2S0YNwNrFwr1gNLQfUBu7l6dITt1cqYco9MGB+EXR+G0fkG?=
 =?us-ascii?Q?2DJkAGQkhb3H64LmP4OwSBfa0pGx0ef49vXtrDkkLtahRL5YYFjMib4kA89R?=
 =?us-ascii?Q?twhXemWE1Oe3QQ8gbjiMchK897kqHfSa76Btj+xq4Y1D9C3Dk3+kAqGzBSV4?=
 =?us-ascii?Q?wZjiT9xRpVtENJCh4J1Kj1su1tftNeM3CcQpQGVQX+7z4pZ40j8p3nK06LYs?=
 =?us-ascii?Q?1tES/zK3wGWD69itI8R1qMD8POCMLe6DfXhf0W/kUQUUtzAo/elbGaVNMScs?=
 =?us-ascii?Q?7mf9fRRefhFjVNAEzHIy30d5Tqh7bMKXZg2dcOEoKMLW+2eh1rhi76D6ffFG?=
 =?us-ascii?Q?CUrSGy67tWVX1YKrc9P6gWDGVcL8kHyWnQsJu3rghymHg6yK2IO+XwJqdWv7?=
 =?us-ascii?Q?cfZloxyoF7cuLXPSzA0F+SAc4nJpIsM25U9a/lphhuBzJxm++/U3Qc/mdkkR?=
 =?us-ascii?Q?WMTYJo+83h6BkXZ1MEyMShA8bQbrxHXSWMom1+BMfL83etlyI0s7453v+CRW?=
 =?us-ascii?Q?jnOeHB63H41IzP7JzOSLQdsCDDk3ftKSCkoQrFcG0gpIeM3ZvFwHDAM27r1M?=
 =?us-ascii?Q?/sYAiUoth0EfZInSQNIEWO37W7PSabsjWoxJXoxhRitTAX9NUgyN10xYXObH?=
 =?us-ascii?Q?rubtTIcl3RCMrVEvCUVKxVurEKKv+fcTqiwCTzP9AiJgjeZ6blH83wsC0WY3?=
 =?us-ascii?Q?noCscw3CxBi7kW1OI1gSPT1WmKpDJmM8cjlL5avM8d2UiAh5zBXcLQXWZ15H?=
 =?us-ascii?Q?poywAbMCn9DT2O3rs4T6y5S5fvGsk9QDhyL3kYH4BtmXeLhaTa6WQdA+1ZAs?=
 =?us-ascii?Q?h5n5Ezrpz3ymJTgC/iDKLkdsycWFNj8hHbK8bnnN+K2lUz3KnaMVykGn7+sl?=
 =?us-ascii?Q?j+/0t6l71LiKAjW6x8N7NM7zxYRO+P9nNHCm8e3y6uSdMZLRngmzRNm0CyR+?=
 =?us-ascii?Q?UwxMVFrUNfb8atnO9OOV8pIK/9B+isaNWfUdpdf2NFqm/Dx51Pi2lfWYLahV?=
 =?us-ascii?Q?ALc1xSlFedUMufi3Hh7vyEvnt55jqyQMlclSzVrPMKfyspUiA6q4NP4Hvcdq?=
 =?us-ascii?Q?f4ZcpMGXRZQ81WkNil6nXfkHLAKt0ikBldwMQbe+hAJEiow4qWkLTEcVL8SF?=
 =?us-ascii?Q?FWqQvV+a3II4mL3Q/WMaEj/NCjczM6JTOJJk2vQr2CltOfo3T4kQ2b3il0UD?=
 =?us-ascii?Q?bWP0pDXzWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b517f98f-ba30-4d52-d697-08de6a641f4e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:25:38.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OB+4S3BtRAORju98bI9I+iZ0gr8pgOm5vRpLE9qSudQUcDOlv6wfRK/tbcRMUUl9fIUst5/n3FaJzfGwr7q+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

On Thu, Feb 12, 2026 at 05:15:28PM +0000, Christian Loehle wrote:
> On 2/10/26 21:26, Andrea Righi wrote:
...
> > +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
> > +{
> > +	struct task_ctx *tctx;
> > +	s32 pid = p->pid;
> 
> unused

This one is used, but the one in dequeue_select_cpu() is not. I'll remove
that. :)

> > +static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
> > +					 const char *scenario_name)
> > +{
> > +	struct bpf_link *link;
> > +	pid_t pids[NUM_WORKERS];
> > +	pthread_t hammer;
> > +
> > +	int i, status;
> > +	u64 enq_start, deq_start,
> > +	    dispatch_deq_start, change_deq_start, bpf_queue_full_start;
> > +	u64 enq_delta, deq_delta,
> > +	    dispatch_deq_delta, change_deq_delta, bpf_queue_full_delta;
> > +
> > +	/* Set the test scenario */
> > +	skel->bss->test_scenario = scenario;
> > +
> > +	/* Record starting counts */
> > +	enq_start = skel->bss->enqueue_cnt;
> > +	deq_start = skel->bss->dequeue_cnt;
> > +	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
> > +	change_deq_start = skel->bss->change_dequeue_cnt;
> > +	bpf_queue_full_start = skel->bss->bpf_queue_full;
> > +
> > +	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
> > +	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
> > +
> > +	/* Fork worker processes to generate enqueue/dequeue events */
> > +	for (i = 0; i < NUM_WORKERS; i++) {
> > +		pids[i] = fork();
> > +		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
> > +
> > +		if (pids[i] == 0) {
> > +			worker_fn(i);
> > +			/* Should not reach here */
> > +			exit(1);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Run an "affinity hammer" so that some property changes hit tasks
> > +	 * while they are still in BPF custody (e.g. in user DSQ or BPF queue),
> > +	 * triggering SCX_DEQ_SCHED_CHANGE dequeues in scenarios 2, 3, 6 and 7.
> 
> Not true for 3, right?

Oh yes, this selftest has been changed so many times that I was sure I
forgot to update some comments (also, scenario 7 doesn't exist anymore).

Thanks!
-Andrea
