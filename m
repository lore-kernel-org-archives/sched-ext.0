Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5B346792
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770546378; cv=fail; b=rN/GUaYK1oeoeysLwmHtXs3uhHBqcQyEf2eVfZ6bI3bml4UhP/gaqhiLpxOLmrpvd95WjV61wqY19zSfZ1GvBvbW1XBz2rfQ5S8qLXn8ijtmQlboQ5dR9EBrbzQLSrV8H1hs/AnQdcAjOu3qWzhWBU3vppbn6/72kQLpCrukqKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770546378; c=relaxed/simple;
	bh=tGNKOCDEc7aKn3f5Rh+iuh2dF2BCbi4bMflYYWrN8bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pswjjZ7nRv8oc9/G8md0c1YPa3iZEAYac2sDvlUlhtUOMGRhBRSWOox/qCC34i3BLJACV7ivE4eXS0PsC0Ae0Q1Ey5zunGcBnUJ55Rl93p425uLL8K7eX34bxW1ruX1R02L8etGTjh4pR/RG9m5yjXPc4pzwceGkP+XHen/7gYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lc80CXTA; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lc80CXTA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqsptmwxzeayDQrx75haoJZV+IDTEyJ1mfDad75OEYxIFs4gYLBQ8Ascoayo+Ov4NnMp4xUD3TkozFrGTqjFKBVnCBD15WXtVLhORsi1V9/64NC2sZ0H31uGbs9TpaZnp4Hv7BiVYGiLhH7dBuSvYaJFGq8CQZ0xRL++1ylW8eN2A2+V4xjhBsomPMlONr3vZMDCa47+Q2iEqCOMrbN8GG4CXAgwuUNRk0VxQ3pnzZzNMbvS20FUoMK+5mbkChfat19aIzk/iu6Twkg8GBf38RF7UJ+qHeGqquV8aFmeB3Z0NtqZaxWI00K6VvDIurUdpo59rWf3UT9fyS9cGhAYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/BieZWGzaca1vA8RxfBC3HSu8jjKEicVafIYLQJVyY=;
 b=eFNvuMejUgk5lfOsJokoqbfcdKvZV16ReiRR0pu3ZwT8O71cGsSusydoHlShlRsa51GsK9iApUl7aFwfsunkeFJ4cS4i0ICNXFkrHupsmV0qzt4GDLod0aS2765rgh09NvcBvXUgdJozqvzOdYnMd8sBxz2SqA9jmVXGEV7rF6HZCppEi73BujQ1aaCvRJa7/n2+6WztTLqWFDIJLpBr6wDPEdombdvCO8pLJ5ab4Zgd1sImq6/EhEJJB9CpusHQuEgm1KFxi6AXeFh2buRbN27JSOislJ7zaJ5uWDrpFkraYkjggx3K+6Hucrzrv+yFyj87ePrsNnhEKGet15+OyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/BieZWGzaca1vA8RxfBC3HSu8jjKEicVafIYLQJVyY=;
 b=lc80CXTAczYEfsp2dMX0F3N+lcwV3m6vdtvqDPe2ydEW8GpheqxNl1QGHk6As/xQeY+yk404Wwldq7Kk8UZ3W60wLVsLc8HejIy0sPp09ybJ6i/3VjZqnPbwKosoaYMkTsqiUxGcqWI2tMfFFywSies5gUzqtsraBHgm8nL2bBCZoMdF/ebRcT60l1hMrur/2qRvHozhabBJso/5AM5dzoVC10/NZdwcHpYdwu1YXO1yKoMhsrT8Sy7S1HvoThtRfLp0e6/tiSq4g8iCcvmRfu5BWRVAvbxhMMJvspbnDpBUNBeDcOpjBgU1/AwES7zUXZJbT9uAtoHP7jA42WzwuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 10:26:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 10:26:12 +0000
Date: Sun, 8 Feb 2026 11:26:07 +0100
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
Message-ID: <aYhkv2K99aqiuwr5@gpd4>
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
 <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYhRKbkHf-or9lNO@gpd4>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e9131a-fd06-41bb-f378-08de66fc7b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTcujQGhYre56Ug3ClxqiIYTqrcD1w0uCB8zNBc/C/3gtg4XJWRqppp+eTEo?=
 =?us-ascii?Q?kh2ahHcc4k6eaTw7XXAHRwdJEuO9VOxwGRWDSObhyuYp3TyLegUlGlbdp53k?=
 =?us-ascii?Q?V6zaQhdWN1OQOoFbuTFGMavu+j81+BnBWH2PXQzXPZtXtH1UozfRb4K/TMJW?=
 =?us-ascii?Q?dzWe9nKawIYWkx6Hdu5858/kklVfRpzCHvUDJw4GFyWquEOSCs+pHQSvG2Ap?=
 =?us-ascii?Q?9SqLfdHiqkajixpUaUVvKDih5n5/dWn37oyBQk2yEbolyymcNUmMQWB20fiu?=
 =?us-ascii?Q?naADHmTPOdP1bGf0i5DhUmB1ZgqLMQ0fNsQX3SKGPfftCGqpWDd12JrcARpI?=
 =?us-ascii?Q?FdqlWOGx6OUJ00THHHEC6MwHK5jhwXkOLvJztxduSoCB/qC9kv9sKmrtr1rK?=
 =?us-ascii?Q?XUjKFiiz+2guB8x8I7V35hoh83OSqwmL8swlKyQio901LS3qGTbHbq/CM/lW?=
 =?us-ascii?Q?QBPIztPP1Db+hQf/QurUU9DOF8htf5eaTvMPIEsyObHKkrrdH0Tiqzz/QE4K?=
 =?us-ascii?Q?E+Wy9MaKVdhtoRORt9/sQqjjOVFwvGks+DXJBW/aezcxR3T2UO6EQJFqmdFe?=
 =?us-ascii?Q?oiKGrKJIX/eA1JWSLMTTBq3yW6A3aIPehLfJxfB4/Bm/FSn+Lt9ZW4PXromG?=
 =?us-ascii?Q?dY86/MfRO+7HFd1wmFKfLHbDXTT+0VjaF9EXYiwfKHFAYV5FQV6OWf86L5tm?=
 =?us-ascii?Q?OLRxZ3h6xe5P2+Ebj22apHKA4UwbPgJBbvHP2CQXUJ9MAlMlRo413FMZUAyx?=
 =?us-ascii?Q?8agQG8klA8jCsPt1VNKEdoBPu4QvN9i+OPBR0wZ74icFn9S3UnRe6Bg/N57A?=
 =?us-ascii?Q?ukjDB/l235HwA7WGlM5OpqgUFiVNb9m9NqNBFy7i9rrFtJvqJgNkUeSoIyim?=
 =?us-ascii?Q?fgcPNv+rDB8mEvcx19t2j4JocjNnS3y7hKTq8GBywP7uUTLjHdGvOvopDP8A?=
 =?us-ascii?Q?wjHvZpC+q2y2rywUthV5Ro9JsLsdxAA+JpE6G0zu7tWjJiTRJeMue5kVIiHn?=
 =?us-ascii?Q?MpIWWN6sCkDal0sph+YygsXEGYc7TOoUf4b0L55UuQy+/uobr6YIMadOG6UC?=
 =?us-ascii?Q?Gc3WPnrGYQ1YhhVnkggC9UwokQaAy5AcT3CRqdjZmD9SH74eHuoDgEUzza5U?=
 =?us-ascii?Q?CFXPkce1wiofB2TEQI92nIupb7hVOWiW+W+Zi3lVbcF9bNVCh+OugeUcZk4i?=
 =?us-ascii?Q?mwNQz5GEiOYy7ZDjtaWrxknTAzr/KrUtXL17gg3nUGUtWP518Yy4q2e2mIF4?=
 =?us-ascii?Q?5g+CLUKa/K0W76wRoWdB8gSH/lKtpFrN/mfpF9KLhebYgFjp9uopx7SJcMQh?=
 =?us-ascii?Q?/YtW43ABaKz3MJN3CNrbn2v43ZkWjQlTcYRRqsxIABErOe47K7QLcLUgXne2?=
 =?us-ascii?Q?/mwvk8K0ja0Psa618WXIdmm99nNQ9cPvvZbG/IhpVuQ2NCzYdJzWRA+q7PSR?=
 =?us-ascii?Q?VW7Ix3Lz6dYk02gRVFLNQhzjyJVlZyMhvos1vfdyVuPP11QQnAQ89LTMvPLP?=
 =?us-ascii?Q?xERE+lDXJbnm5jQtJxxGLL+0r/TKAXmutNB4+wNIOr5Yn6HlGiqhu1FOswBv?=
 =?us-ascii?Q?t8m8uVvnfc2cMWHJNW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPaE/aoWTeGt0f+6FQqZuqCBOta5m+DRNDMX+xUaprsXcXB8lBrEpJPKRRAK?=
 =?us-ascii?Q?z4EwTg58LjS9slTgLhSUru7idgL6XXSKSFQfxg1v9dpS8HQeKar4tQnUxDeL?=
 =?us-ascii?Q?c+A9lL8ZDtbWK6NkijKr1OA83Ui2A5gGegJS6h8pUu+tjNnQks4TW3fJY77e?=
 =?us-ascii?Q?XP+OBn9h23pDEpgyYK72PuY16YVeXVa5XTtmTeTAWTFiQTFctDQNyNPaGOj1?=
 =?us-ascii?Q?9pLBNBdcu2F2f7X1arWZ3GRuSCqgg0+eZvt+OOgUtKyHhQ6Q/RvFl9K4Q7XN?=
 =?us-ascii?Q?yAcv0TU7XfwMItXm9gWRUu0+3OrMoOB6I7Ic1GMg07mq4UruVXvA8CARVILs?=
 =?us-ascii?Q?KuG1Svt3lPH/zDqCEVmrvdme78JFQrDcthuE3pFFpVcicDGyt7GxtsLg8sVN?=
 =?us-ascii?Q?pxpYTtyc3xL60unlWRmBtaya8FpXj5WcO6rvEV30KbPqY8JYhM2lDsTEA3rY?=
 =?us-ascii?Q?EWEpeQ+Bz33qpYuso1EwIo+H2HzrxjfbSisegwMAdhX2LMGc75B3UhMnzf2m?=
 =?us-ascii?Q?03Y/44tbZPXEl59ooW4+pNBP4PazWHz9DtuRTuHZZ/k+y8zU38P53ZxQS1mC?=
 =?us-ascii?Q?5j9MRXv3BSZhyioXFttxeEM05Kah2zMtInelgUD+gTywmawdxGpRWv+1OWn4?=
 =?us-ascii?Q?dR/jw1qA8MNz6G9PsOlkJi5fPuCxLnrFYs/IvRLa3cQOSfZRNBSLjqZS0ncD?=
 =?us-ascii?Q?Fc5cpLW0rrzQAT6CRIvCvePpAfr/rHQUAGvnIuUEz4ASJyP/jn/DfL8VZhtK?=
 =?us-ascii?Q?uYolOCWVlu5LwRq3dxUGSbjOXUAJV7386Y3ICC8znEkKs6XDMg1nB3fsFgDt?=
 =?us-ascii?Q?k9wjMRoTqhMXzbj3DAX648DQBFvG8f28/LzBhZdKj7BHMkAnQ+mSJX23d2x6?=
 =?us-ascii?Q?zIGyNGFV5Isey1G1ad7w53O4HMgLbR5tqSDNDlnA0qAS6rc7hqaLew11x26w?=
 =?us-ascii?Q?XTJqO42Fm+TB2qjyRFkbWyL+KIzdhcI1hPlZ5uzcObxb+8rqwztYtmkZQoT2?=
 =?us-ascii?Q?EsZic+Z8/8ZOcbVbRVjakPaVkBgZodJgdZHB4/TeNTMSLxxYrXyCGmVNExYE?=
 =?us-ascii?Q?Dl/PLyWZNjx5eR+XJEXNDEXAf8cQFy0eq2Ih9e5GqqO+aEzoFhtm09pR6Q8y?=
 =?us-ascii?Q?uXW87tRnEV/s8f4Z2mTCfz4OxSW4r1MOKauRSnQ+SVNklLGz759h8ZqCY2B/?=
 =?us-ascii?Q?NV15RmdA2n8IkBB45PDOuAl2dTGvRVVEATNZHv0xxzJc7s41qyJ89xk8A7zG?=
 =?us-ascii?Q?TSZSkE87lil9uX57Flepi0No4svLvQWNb8hqiL+s7HcYDEu1nm+nyyNRQC88?=
 =?us-ascii?Q?p3I6B5xpwxiP0cwFfl+90KMZhR0o9UmspHXNlBpQ4COO2bragPwTloJUVE4c?=
 =?us-ascii?Q?+oHcttkIscTxoGEkJUYJUPqASVDpl09YyxvcegzYoZ1F53cMYrqTgLT6yoZc?=
 =?us-ascii?Q?iVja3nxkfkGvFiYHUk9V3WiOUR4gpSkJC4j2Cfr4L85bemS/t2kjL4IbRAyZ?=
 =?us-ascii?Q?y7PrNAM8hcQJ1tl9u2T9pisey9AKLIFmQ8qOaIBDAgvIBLedwfTisuc2P91d?=
 =?us-ascii?Q?TIUhrYhyifQA5fvS6XOf7XIQun1HXDN3osrH6VXwJnHO02ytZBDUPPLyMSul?=
 =?us-ascii?Q?gGbiN/A36TTtL9F+51u0uRnAXKw0CPfNARkBG1C+Z5CdTLdh6BiJKPTl7b9S?=
 =?us-ascii?Q?rBW2s4vlrlspuhCBewX4xRP0We0aWEoGUR5gaMqZYq6FPr5P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e9131a-fd06-41bb-f378-08de66fc7b8e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 10:26:12.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDiRe5zYVg99NO63fM7IlVPFXvuUzvFh55suUkIJrRDMj7ysC9BMRLJxXLq2mNgt6j9LquL2Eh2J4qMZK17z7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
...
> > >> >  - From ops.select_cpu():
> > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
> > >> >        the BPF scheduler entirely; they never enter BPF custody, so
> > >> >        ops.dequeue() is not called,
> > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
> > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
> > >> >        not called,
> > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
> > >> >        enqueue/dequeue lifecycle tracking and state machine validation
> > >> >        (expects 1:1 enqueue/dequeue pairing).
> > >> 
> > >> Could you add a note here about why there's no equivalent to scenario 6?
> > >> The differentiating factor between that and scenario 2 (nonterminal queue) is 
> > >> that scx_dsq_insert_commit() is called regardless of whether the queue is terminal.
> > >> And this makes sense since for non-DSQ queues the BPF scheduler can do its
> > >> own tracking of enqueue/dequeue (plus it does not make too much sense to
> > >> do BPF-internal enqueueing in select_cpu).
> > >> 
> > >> What do you think? If the above makes sense, maybe we should spell it out 
> > >> in the documentation too. Maybe also add it makes no sense to enqueue
> > >> in an internal BPF structure from select_cpu - the task is not yet
> > >> enqueued, and would have to go through enqueue anyway.
> > >
> > > Oh, I just didn't think about it, we can definitely add to ops.select_cpu()
> > > a scenario equivalent to scenario 6 (push task to the BPF queue).
> > >
> > > From a practical standpoint the benefits are questionable, but in the scope
> > > of the kselftest I think it makes sense to better validate the entire state
> > > machine in all cases. I'll add this scenario as well.
> > >
> > 
> > That makes sense! Let's add it for completeness. Even if it doesn't make
> > sense right now that may change in the future. For example, if we end
> > up finding a good reason to add the task into an internal structure from
> > .select_cpu(), we may allow the task to be explicitly marked as being in
> > the BPF scheduler's custody from a kfunc. Right now we can't do that
> > from select_cpu() unless we direct dispatch IIUC.
> 
> Ok, I'll send a new patch later with the new scenario included. It should
> work already (if done properly in the test case), I think we don't need to
> change anything in the kernel.

Actually I take that back. The internal BPF queue from ops.select_cpu()
scenario is a bit tricky, because when we return from ops.select_cpu()
without p->scx.ddsp_dsq_id being set, we don't know if the scheduler added
the task to an internal BPF queue or simply did nothing.

We need to add some special logic here, preferably without introducing
overhead just to handle this particular (really uncommon) case. I'll take a
look.

Thanks,
-Andrea
