Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705431DED5C
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925124; cv=fail; b=Sk76DvjNrQOUYjG8uOtT3LR7D3lgXP3KAVlp//b5t+wips1oFa7KMSDKUtmvgZBtiksRZl6fSqXLTowao352lVDOdz2RT2uitCjVmbkc0jLoeIzdLyJ+e8G+KnSqowVRFuGv9jTCPOltYV8zYGqmShMWeSuzp1o6LoAyNr7wN8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925124; c=relaxed/simple;
	bh=nrwhicYdHg5SIQczubKMjAE/DG2XtGXpzY6Mz2kjoWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ffJJwszpnXu0ve/5242VCWeKvtR5/6WF3m3QZBbHajfqwGfB7VstwU+c7R3Oaj3y+3ZO8bJJDE8rVW3c5SY52Ey5/w2CZXDf/zOdpMlI2RWAI/Ad7QwOMS0wgOUGtqM24lTRE7g8YdbuvLyfT3SawSWbSdXvu3niakHzCA1poHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gvLs8mvJ; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gvLs8mvJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcfn8uHLXUZGr7CWEKhMHjrF2G2yAaBh0XrtjnAc1zAYhr9RsJKrSul3s7o19zcU+2+hlN/zzN36gRzFr32ZxFAMAsdGOXABrOJY9nxRbEPc/s8i6uzQBOGAOs69PZIArzE+oUIhMiP1aYwMALrVcZeDKmRDzdWYNZbjOWEqLzhF/F7WqZle6d1NvJeK9Lax8usVrAyIWrao6f1fg/B/iIRlLhkZDVb2zIUmXATfn+1Lp/idjwbXfsBPqvvbCd1b1QJ8p8LPq9SNFp72eTDVafB1ie5xJ70owrqe8FSu797rmCj6D4g1aNtmJXr1qvZl5cjC0ZDn32cVgpR5leBczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrT7uXdUElHlJ3DKtCr/zod4X/VWhZGphh+lzdOOYSc=;
 b=EBD1JIJg8G0z29Has4Z6gvgwnbAQW/6wLwkV8O56tYvU3Jd4x0tFsqaBXDtq2GHT4iuiHctDKQ6odrCh5Yl4JjJW+Un8lFkvGUGZmPbgpbvM8I7b//Ca1Yco/lmv7qEE7/Y+bhxiGXLmR0wYU6nYUZIJfnQBodySbX6Oart9NkKLZ1pv8lW+T3KHW3LcYSbDL7cXgTVEFCdFNiYJTH83gQItSyBRcCCZ5R89m1yH70PBBJAVwFiTWRB5ijuviAJBLZMWe+Moim7m5iCezusEEMk4Xup956FzuL6ECwq+dkies3RY6NOn9RufS/Vo3O+XQhq/bWM9Mf1z+AyGYNe8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrT7uXdUElHlJ3DKtCr/zod4X/VWhZGphh+lzdOOYSc=;
 b=gvLs8mvJhQCgoSO9vT4NQmsbjmLYdAA1T9vQybd6ej6eXKmpKTCHk1lxYcA9CZp8ZUr+8r721uyL1iKyxcDgye7leiidDk77p9nl9sKYW5DX2pNe+6mKbpeFo5KElDa48Q/YuckmlqnrUHwqXfN71tfoS2xhHUwxTtcj6FP+dwGpmMiSanGFjcbZ8JfMHNRtoaFvD+ilkAOKKO+TdC3Wq03irRfCSznCHHt8SXRBKz3L+hAj4BRyTXXhESgtME2YEMJGl1ySreewHz/xNWHh2/PmKDfn1LD5my6j9/1zyRqHCz25qGcgA5nlkpn8RvN6cPDr/2XONv4CH0HUcj5l1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:45:19 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 06:45:18 +0000
Date: Mon, 13 Jul 2026 08:45:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
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
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] sched_ext: Fix ops.running/stopping() pairing for
 proxy-exec donors
Message-ID: <alSJciAF-PVDKxq3@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-3-arighi@nvidia.com>
 <CANDhNCo3H=KjOiQqzpjqV+px6HS-8qJWTS9XWF2PN+NJPRcUDw@mail.gmail.com>
 <alIOwoNds4x7i_bu@gpd4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alIOwoNds4x7i_bu@gpd4>
X-ClientProxiedBy: ZR1PEPF000077E2.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::415) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c78fa7-3aed-4ecc-7760-08dee0aa4d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|3023799007|6133799003|4143699003|11063799006|5023799004|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3OVKk6b04Pma3xlr8IiryhEG5yFzwbHqD2k9J67/rVZC4q4c8+YtiEeh1JZYYSXNQQiQKfYKrpw0kCY6TLV9BA8ZI/gFn+0i4eBLt2FT150tIDFC2msicFyr0thKQU7zr3A8Ao/GPGPI4bvSViBysorugQfoFaJ1OepdsWo0/Q/VshesnWacvsyBwmgIwtHvfK2asJHpy0j8vXgUzrFNGhnfGQHH63U5ct1qAO2s1ZkNZ8OUNgExNUU3qqTE0vU2zc8/ZW6huXlNkxVjlVWAazYGQN0pYu/1D/ZlPFOPN42XbGLzsPWnJo63ark3zaj91L+yJ+Unwrp7bR7QefG/CQwWwUdN3D6zcNlioff44K4GtyHxA1RFMUg/Gz49/vv6IvUOSIDz1yLhRX9iA6Vz7gC/6/b8G2QeEVIvoizv7tvJ+65KIagOIh4832mS8jz3U3sufgBcu3GnJMUcJxArVjZgHW8ld5KdO7g6swc76AafBtR/YwBoByLy9oWs98J10NeCiEf7/n1CNobkhIOCSb0n8kOS0NZGR5mZni5cckosp7ls//lW3D19+l2qQUDk6cSFuXwsuvxbBNrB13FLe3Qupo7ZPJNP4PJc6/mmmYzsj/e7MxhrHsYyk/kU7uPmRoKL2lR1DqgbMYiFgitGJ1vcasJDlOfdzlp+1LhD860=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(3023799007)(6133799003)(4143699003)(11063799006)(5023799004)(56012099006)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUN4NkNxcjNqaTdnd25tRE1HY3V3cC9XTWFJeG5XUkFMOHZ3L002d1ZoMm4w?=
 =?utf-8?B?ZG8zWDAyVmhwQUpmTTRTZ1VkLzNSZ1dsc3pwNUFQbHFnRTJOdldIWnlJVC9W?=
 =?utf-8?B?MStHdE1mVmRmZWFOYlJ6SjZ5VHBCQXZySHl0Y1lzcW9tS25oZHBET0FDcHN3?=
 =?utf-8?B?TEh2RFU2OGl6UDZVSzNXdFd0YUZ1cnpzUFB3NjgzUzdoc0VOejhJbzdhYk5l?=
 =?utf-8?B?VnErdHBSR0RUbEFKYXpaZWNEREhxZGRMZGJhVXRrMkVQVkJlb1QzVzlzRjBD?=
 =?utf-8?B?SzZta1FxekRwbFpiUzFEd0VYSExJZnNBeEFCRExKTUVyYThJTEVyckNMemlS?=
 =?utf-8?B?RXh4TjRoSk9QTk9WekdYc0Vtc2xvVmczbHRsU2xSWURLYkdMalhkdkMzVUpO?=
 =?utf-8?B?bWxBVzQwNlljVEZYOW85aVE3YTgzN1VKTFVhYlVmejA2WHMraE54YlVGdkFq?=
 =?utf-8?B?V252blJwazBUY3F3VkxLdTY5Rkl4ckVhQk5NUkRETjdxdW54b2wxc2VteUw0?=
 =?utf-8?B?TmEzalNLeVRnTzQrZ3hqTXFPdWUyYWFjM2hlbXFmcWdWMjN4RnRYWlhoSUsy?=
 =?utf-8?B?TFVSV0RKV0gyU3E5RGs3L2x1VGVMYVh5bnFTdnAzZG1BeFRjZE53UmI1Vjdr?=
 =?utf-8?B?bHdlVWZGT0RKZ003Q1NTSXZKQUJwcjl6MUMwVkd6azZtd3NDYnNkVlg1Z0hH?=
 =?utf-8?B?cFM0dVgrd0FiS05qdldKTGhpNDBRNjdZd1g5VXlXWWZsaTUwRjhUbGVwQzBa?=
 =?utf-8?B?eUd4THlac1l3WktFU29KVmc5NlNLVlBZbnROZEJVWThTQk1DSTkzWHVpQXda?=
 =?utf-8?B?azZhSlpZK24wQjQxclYzd1NiKy9lSzNZTnY1TmNaMWVEemk1RnZ4bi94MnJ5?=
 =?utf-8?B?czcrMzNDRnJqVURyV2c4RzlnbEdocisyRnIwdGIvcDE4WUNucGVyRnZPWm5K?=
 =?utf-8?B?SDFxV2tITDU3ZlhiM25kbm5OMFg3ZlJ3MmpXZ2Nxb2lzRlE2OUNvQXhCcDlI?=
 =?utf-8?B?TGt6Ui9RcnhnYlhTTzRCS29UZ2QxMFRmYlNDeldSUVJQRjFDcEZqZndiZVN4?=
 =?utf-8?B?UVFHaW92RGpJUVlsS1IwYmtZMGNRbFlwWnI4SHZoSVVjQVMzOFN4UytZSUp3?=
 =?utf-8?B?elRORHNJRzNHbGVubVN1YzA0WG5vVkVBSUZKd2pCQmp2Vng5Snd6WktKUk9v?=
 =?utf-8?B?Qm9aaUlVYXZpOFY1Mzl5dk8wVFNxUm5DZVJ1WnVmVFhnNjVPOHhNbWthMnhF?=
 =?utf-8?B?Nk8wWVNjN21rVW8rbnNTNUIvV1dqZzR6TVVPSExzV3FIa0hUcjZOM0EzcERQ?=
 =?utf-8?B?SFpWVTMyOWszR2RoSTJlcXAvWCtnaFVQd0tHaGhWOXZOdCtacGgrQW5NVCtv?=
 =?utf-8?B?VzhtblRVT3BOVnB1NGpjek5tN2hjTUhlZVFabWxKaGNKWUNkVitEVklYVDZ6?=
 =?utf-8?B?Um83UmJUT0ZRc1ZBSmN6L0ppd1RrbUNNVUdwRkpyN0ZuMjZxNmk2YW4rSlZ4?=
 =?utf-8?B?TEhudVN0NE9pVjh1ZkdNRXpCVmF2bmdUQlBhNndWaWs0RC9JSjZEQUdvaTMr?=
 =?utf-8?B?SmZXcXBJUHFiT2pWMzhiT3hlSDJ3VVZpOHlsYjRFd0N6T09tcGUxL0ZobWUz?=
 =?utf-8?B?dkJVZGRsbzk4OGJDOFdvUnVENHNVdWJKcngyUlV6Sk83Wkx6V09Jci9ZRVFV?=
 =?utf-8?B?UFgxSFVIcUhsWUJnWUt3QjBtcDJsQWlpTlBLUUdGQzlRRWlYYnp1NDZyeTVl?=
 =?utf-8?B?MldBWjZJZzZjR0owVk5uUE10NytPYVNvdGxzNklYelJlOGdRWXBTRk5Vd054?=
 =?utf-8?B?aWJUQUV1V2gzcWVLU3VWUVRIYm8ySlRxNWV5QW1qc3prVVlPQTRnWGhDYWZM?=
 =?utf-8?B?TWh1Tm5VZUtDdW8vRi9YeUY0WTk2Z3pkVWZlcG94MEo1Q3cyVldheTR2STV6?=
 =?utf-8?B?eWFTbjc1M011YmY3TUh4THNHcGhXRzZLZE4ranJWRXJQQnBIcDh1SXRpMmdJ?=
 =?utf-8?B?ZFQ5eUo2UmVyaXJ3c1QrbnJ1ZE5OTGNVTzZJT1ppZk90UnhJcjd5RGhiZ3p0?=
 =?utf-8?B?d0RXbTBCOEZ4bXJWckFEZjVESUZ2UUdZeitKVFZ2T1phS1N6WVQ2SnlNNkEz?=
 =?utf-8?B?Q05JK3BxZ0lsYjNUK2tPbldwNlhxUGZOU2VLTWNDOUwrZ2dNeVdTNk9LOTMr?=
 =?utf-8?B?cm43Y2Q5WFgvM1BQbnJSalpwdmNZNG8rRnVvQTN2VVZ0NG5Oam5FQ1VmM01o?=
 =?utf-8?B?S3Zrb1RJNDN3dlU1aWRBYWdKaWtlQksvYTlGY3JhMkhHRUtmODcvdXNXbXRE?=
 =?utf-8?B?UzlRN2F5QTNxV3hxNkU5UU9QVVpzM1VhR2wveGtFVHpMeHJWZnI3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c78fa7-3aed-4ecc-7760-08dee0aa4d93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:45:18.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O3IoiM6GUuPKUq9W83EKklzhyDQuYcOPoo5O7TRW1G5Nvc1CfsjbmSovWhzd6TE2vw7MhH/pt1xNepa+97yoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On Sat, Jul 11, 2026 at 11:37:17AM +0200, Andrea Righi wrote:
> On Fri, Jul 10, 2026 at 02:33:55PM -0700, John Stultz wrote:
> > On Fri, Jul 10, 2026 at 1:39 AM Andrea Righi <arighi@nvidia.com> wrote:
> > >
> > > With proxy-exec, pick_next_task() can return a task with blocked_on set
> > > (a proxy donor). put_prev_set_next_task() then calls set_next_task_scx()
> > > on this "ghost" task even though the task only provides scheduling
> > > context and never actually runs.
> > >
> > > Calling ops.running() for such a donor produces a spurious running
> > > event. Simply suppressing ops.running() is not sufficient because the
> > > following put_prev_task_scx() would still invoke ops.stopping(),
> > > resulting in an unpaired stopping event.
> > >
> > > Introduce SCX_TASK_IS_RUNNING to track whether a task entered a real
> > > running transition. Set and clear the flag independently of
> > > ops.running() and ops.stopping(), as the callbacks are independently
> > > optional. Invoke ops.running() only for non-blocked tasks and invoke
> > > ops.stopping() only after a real running transition. This keeps the
> > > callbacks paired for proxy donors while preserving stopping
> > > notifications for schedulers which only implement ops.stopping().
> > 
> > It took me a while to understand this.
> > 
> > It seems you're wanting to distinguish normal task selection and
> > execution (without proxy) from just task selection for proxy-donation
> > (where it doesn't run).
> > 
> > I think what makes it confusing is that TASK_IS_RUNNING is not set for
> > the case when the task is running (rq->curr) as a lock-owning proxy
> > for a waiting donor.
> > 
> > Would it maybe make it easier to follow if the flag was
> > TASK_BLOCKED_DONOR? And the logic was flipped a bit?
> > 
> > That might more clearly cover the case you intend here without extra
> > edge cases that you'll have to explain (well, you're running but
> > you're not the donor and running... ).
> 
> I agree that SCX_TASK_IS_RUNNING is confusing, because it doesn't describe
> really well the rq->curr/physical execution.
> 
> What the flag records is whether a task entered the sched_ext running/stopping
> state. With proxy-exec, the selected scheduling context (rq->donor) and the
> physical execution context (rq->curr) can differ, which creates two relevant
> cases:
> 
>  1. a blocked EXT donor goes through set_next_task_scx() even though its mutex
>     owner executes instead. We must suppress ops.running() for the donor and
>     remember that it did not enter the running state, so that a later
>     ops.stopping() is also suppressed,
> 
>  2. an EXT mutex owner can execute as rq->curr for a non-EXT donor. The owner is
>     not a blocked donor, but it did not go through set_next_task_scx(), so it
>     must not receive ops.stopping() if it is subsequently dequeued.
> 
> So, I don't think changing the flag to SCX_TASK_BLOCKED_DONOR captures the
> required state. SCX_TASK_IS_RUNNING handles both cases by recording whether the
> task entered the sched_ext ops.running/stopping() state, independently of
> whether either callback is implemented.
> 
> How about renaming it to SCX_TASK_IN_RUNNING_TRANSITION and explicitly
> documenting that this is the sched_ext callback state, not physical rq->curr
> execution? Something like:
> 
>   /* entered the SCX ops.running/stopping() state, not necessarily rq->curr */
>   SCX_TASK_IN_RUNNING_TRANSITION = 1 << 6,
> 
> Any other ideas for a more clear name?

Or perhaps SCX_TASK_RUN_TRACKED (I think I prefer this one). I did other changes
to the series, so I'll post a new version with this rename as well. Then we can
continue the discussion in the new thread.

Thanks,
-Andrea
