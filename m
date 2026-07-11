Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97303921C3
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762643; cv=fail; b=m4uTqwGyhvwWp8kqrSufrkey5Gpn+OKKR/LkLP25rz5h/yt5JVUDWdOD3g2zhc5Wlw2PGXe2Xk765nvFpVcVv89hJ/AZQUfFN/0AJ3oiFC8dZKYL9ICjEGTcOUsTrhFFCrYop4uWUvwCcqrKJIi55f3xXgOpnMqOJ0LYL0bv6G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762643; c=relaxed/simple;
	bh=IMJPwEhvSziaNMaaRi61y36kUTgBbZh6OhHsLUhgZ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPC0i6eeyGvMjgH652o9t05j2h7jvvKAGM8xEpKeROguwdEFR2YsuzxPzyrTsWdZfwUCIR0D9SS7dAY3/y8YA0sEJs6WlAVO7YVtw+V2z5ApRZdLCSt3NvHeVWTm8wYgAYWNcfWt1iYMaIDs44DbkV/tCeJ+Ez1zApsokJK9R+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fwa9X1GH; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fwa9X1GH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoUNtiCjIo1lWicDXU6hv0wRdrlYx63wckHQ76cN34/D+8YL+Grhxg/ELG4dV1BJzH3o4hZfGall/FVelX6YaT7GRRy/zryDzHKl2vFa3fWiUFLAiWqrk1Ctb+p8rAFsc1VO/snlmjD0cdsTotlyKjB0nhFUaK0CIKg6IiKEf3oVv71giZbDIZECr4IbQUDmfwlVSvkyVjJzhuJnx+jGcFK3PxmVvrnxkHH7RWZOBRodwTBRk3E/B8jNmsVxJQ6WM5n76Po1QlPsTepprhAwegrHo3TynTcEVbcxVcBzdZQTm/4nFe17JfNV7YqqpoC7/vwq7f/wLlwthvZqGoRoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTvUKqKh9SJQbtImzT1zfQUD94YxBvv8kUxi5ve48uY=;
 b=PCIcBZt9kVoMfRXdkXmhdjOrM/V0Z4TSHPA+oU4M37o456QEsBkCDQtZxlj9vqcOHqR+SVRGEJaKbP3j1w4ID+tbPIu+PVaq7fyaRtLSdkrKv4OGocKY9KcifJe2iwClmp8mlKgxKmBHcVsyEs2YvnX7c/2kB3WeMvF9oBhPrb0K0Al14Oujgrn4aCBt0nqgCr2g7CNqZJ1JdLo3VxCzUXMgO+V8U9cMM4N8PMshArKga+P0pisPLXiSQ7z5+kqmxOrtnBg1CR/MrTkLze40B8FVO2eZyGv7ho+cEQ2mklCEiB2qRLaDWmXKHOsrSgtPK0zwkopYpbT6JETkTH5v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTvUKqKh9SJQbtImzT1zfQUD94YxBvv8kUxi5ve48uY=;
 b=fwa9X1GHBvBlfSs0v3pA8tqPP2wEp5cUAeIOlQc8X4EmBi601X6cMbCGvzzZtU6yWpZ12KDq5JYzmRdOYhCJi0ZmA24LLFuSJaNMFhqXe1z4R8YNOSK6oacwBRfswAWAPOn3y29MBgCOfqxF+bB6Gb4CmjQ0B+o6C8tO1cUUcybBV8jTL+0CbMq102mgUGZraekXikaquvv2XPfhZI+y9KdFKMaVKz3MT1crldmVjfE4wzTMSuEiHQZWYKL8YiewrPWF4OW+iPkxiqIb6kDxAXsUbOU3bHAZiDMy/Ja6tGf4CcIUGXmZEGHR11DxFOELgZek4eAY4TOzUHfPZvAIhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 09:37:16 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Sat, 11 Jul 2026
 09:37:15 +0000
Date: Sat, 11 Jul 2026 11:37:06 +0200
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
Message-ID: <alIOwoNds4x7i_bu@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-3-arighi@nvidia.com>
 <CANDhNCo3H=KjOiQqzpjqV+px6HS-8qJWTS9XWF2PN+NJPRcUDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCo3H=KjOiQqzpjqV+px6HS-8qJWTS9XWF2PN+NJPRcUDw@mail.gmail.com>
X-ClientProxiedBy: MI3PEPF00004E9B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::457) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9c46b3-e72c-4e1f-d3f1-08dedf2ffd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|13003099007|6133799003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	H5hLL4mZAxfuBikuhR3jBMHgvvJKlVwj7FJT0s67Mj6IG7pkCdh61RBW0PWi7VMm2BJI0AhvgcKNs2jyc4TiTRNQgTPwspVsORd/PAobQPyYnCTiPPq0Qr/4YeD+c/xbS9APU4xavKJ5mHEcbgex9wQi/tRkiOHAeyS7hPMfHcqXmLDy75YbAJbvNpogoTSVFf3I1CxNE6Duq+cO+wzNzbnN/RVtsnEXTuEMkt+zSOuu6+gmmpTUORiCsihYYipHXbV5DciRl6zFdid6ohWpcvLkdn03ixkV/c8GUE9SXQsFhqm99Xc+pZ2/m0cuFGDQ1mr9VSdkSd4vY/NZlE9F5uxoM6PDSyN21IphCraaBRfovT24NwEj5MLQiFdsnIjCy/rYwXmJH65Ph0G5IJqV3KF8rJRnJQEJ/yYUXS6DggdKIibJrC96fz6uk1knAbwstDqrSq51hD4vII/dtb2BEJLmRhhe4K0AipfcDEA8b+Hw8xdP+K8fx1YrAdiBjfg3M/54r3q7vo2NgRFBSPZ62jPkSIBT7YN1EB23/clqC/eHoLh/niE+9Lm/Sqq7ozRUrRTbgOGGiCDPctd74iITRbpbLtnxa5Mv4xbBwHmmciy9WUx9XkAoT6T3jgF14qdtV2E6EKUHQMBRQAUTi8kQOn/4T3JE1HJhoquBp3DuL4k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(13003099007)(6133799003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVRrUlF5aGRkMFphRFFjQ1F4Nzc5YlNqbXZsT3g5RFNNU1BpbXY3dnI1TlM4?=
 =?utf-8?B?dnlhaWVGd2c5QW92d2x5QjNRUzZlN01UeEZjbWlBTFFpcHlIR2JNQ2s4ZXNj?=
 =?utf-8?B?amlna2dWL0djSU9Hb0ZIRytGcEZnZ0tpRXZPUDV2L0FWZ2Ixbm1HQkhBZVhB?=
 =?utf-8?B?M3BVVzNUUlVjK2JvWVN6VWR0U3g4cndsazZuYkVXVXQ5RWZ0TE9OWWJ2TlBQ?=
 =?utf-8?B?RWZKS2U4MWpqWWRCQUVSYkREeW4yWmhyb3NGc0EzWFpnYnprUG11UkQyS1pU?=
 =?utf-8?B?RVUralBLbWcrMnhobXIrMTY4TGhrd2xrOWVicVdScjNpQytOeTcwMGtvZS9X?=
 =?utf-8?B?YUF1aHRwaWI2UW5uRktFb3diVXpZQmlENXdNdUh6dlpwb3hYeUIyYnN6Nkw0?=
 =?utf-8?B?Nm5Bdit3ZGgxazdOOGF2S1ZoOVJYM3JPNmV6S3FwU1Q0emZuTmlMODgxWjkv?=
 =?utf-8?B?TkxXMlJHWE5mUW1JUWFwazFpVFlwcFJmSm84dmIzaVltdWFxQll4cTlCc0g5?=
 =?utf-8?B?cUcxWHdrS0FSU0w4V3ZVT04raDVKTUF4L3NKZ3N1Y0tUNndZZnI1TWtaNUJP?=
 =?utf-8?B?aFV5d0oyb0dnVW5EUlhhMDhSWUJ0TEU0MEVrUE12enE5TGdMSncwZXRiMTFx?=
 =?utf-8?B?RTlqNWlncjAxOTkrMmtvclEzR2JpaTJ0cEdJbzR2NGVkVE5hcTFNNHorZnY2?=
 =?utf-8?B?a3VzYXNxVEpwQi9yTUtmQU5ObmloOE1tbWJNNHpTU21KY0QxSU9nTkVkZXFU?=
 =?utf-8?B?S3IzZWthNkZlYlIvbE5DaUQwdmNoeVJ2SXpQeml0RFlBS1FhMzJJMGd6UGF0?=
 =?utf-8?B?WXhjMHZQdVBWaFRPOGlXbFJPVUNrYXRuRzRqSTJrTnp4US83M0lZWkU4dmpK?=
 =?utf-8?B?dEFrMEUxTnpFSmR1RzV0NzB6Y1J4Nll2MGlKUkhCdjM3VkxjK09BU3Z5QUFr?=
 =?utf-8?B?d050d21Fd244Yzk3M3FXYUJMQjNGRUZKR0xuMTArcVJBTEJCT25heTFxLy94?=
 =?utf-8?B?K1d6YkIvdUtTd1hQWkhLbDJRajJtbXp2NzdpV2k1aDI0K1Q5YTBENWg2T0hJ?=
 =?utf-8?B?aVd6QnpFTEFrczdQWTc0aDFUVW1FdmdHelRlRjIrNUZPK1JvYXpBbVE5Q2xP?=
 =?utf-8?B?dC9yUlJVeEx0aVlYWkxOTFY3d2lMRW95RDkzMDhhYmR5M3ZUZHM3SXd4QUNo?=
 =?utf-8?B?ZHJpNmw3bUVEYnFJdkhDdnQ0SGFFS0hUUVdOZnlReDdGTVBxa3VZTG9CWFAv?=
 =?utf-8?B?UCtuMGF3ejNxTXJHenR0Ri9zWTZqNTN2U3ZVYVROZEoxei95RnRUMm12eHhW?=
 =?utf-8?B?QWI0aFlLVlcyUlVDMWZUNHFZeVBHZzJ5UTh3eDUxYUszMWpQaFp2ZnlLMlJj?=
 =?utf-8?B?T2dOQU9vNEcvRFA5RXNrUWdFUE0wSktvOHRwM0FWT25pcUFhOXRLM3dpS1Vn?=
 =?utf-8?B?QkRpS2x0U2x2bXBYNmFCSVFJOCsyZ2hJakcyc2I0SDJIZWQ1cjBrWVIrQUsr?=
 =?utf-8?B?SkhGZGFCbWtndmI3NjR0eDEydDVWZWJzVUhnWUpoTmhkcWxZSFFOcjhzb3Bo?=
 =?utf-8?B?OXZDRmxMQ0FkVnFoUGxoNDM1M2huSmpMRUJ4bm9MRXVtM1ZPa2taSnQ3N2Mz?=
 =?utf-8?B?SGhRMCtreTNsc3NrRW5PVTZ4MGlCTUtHRjNHUXV2N1NaRlpaTFFob25ld1Rl?=
 =?utf-8?B?aFMrclJJOUlIQkY5UU14UzVJRG9Udllxa01NanA2YUVuelEvMTZTUUpTV2pO?=
 =?utf-8?B?WHBrUjlTVUZ0MEJibUMyaUp5NHRkU1lVOGNsRWZiQVJDa096UDZmajgyZmky?=
 =?utf-8?B?VXFOT1hvUnYyZHJDbU8wRTViYll6dWo4MFZKViszSzlNaTBtSng0TEZ5UDN0?=
 =?utf-8?B?NDBCbmNYWjkxRHlDMXJRalNvMTZxdHNCWE00V2pPbmRYcHZIQ0E1RFM4cVN1?=
 =?utf-8?B?dU1oNUlRR0ltS1hkQWtSblYzcjc4WHV3eHlpcnRQa3NaSy96QUhMeW11d2pn?=
 =?utf-8?B?VndRSjhxaUp1b0d3N0hFeERqK2hnTFUvdUl0aTdTT1lnOXJaWmlHOEpmS3hV?=
 =?utf-8?B?KytzK3hTejRCdXJsMDd1cE8weTNuR0NzY3FUei9iVWhzNUpXam1oaEVkQS9F?=
 =?utf-8?B?QlJaZFZDcEZVREdnSkxXdmdSdUo1WmlpZnQxd0pWUDRXM1dFYnVsMEZFYzk2?=
 =?utf-8?B?WWo4VWQzWktSN2lKSExZYkcveEh2Vlcvb0kxN1lEUVltakxvRWYxMVJxUmtm?=
 =?utf-8?B?SHZpc2lNTWZITCtPSktKNEhrcWFLc2ZBbFRPdjRmUjc4WS90RjJteUFONjBN?=
 =?utf-8?B?WmNIRFBUcndYckJJMzFkMXJXVWxwb1JvaThRYlRaMWxuNnRaS3BXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9c46b3-e72c-4e1f-d3f1-08dedf2ffd56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 09:37:14.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhH6Jo1VWq9i43fASZtd13s5OR5aN1DorpHDYCfEuVuo6vJal/r45WWRMoACypmqs/ssBckPOzxJ88H7FERcxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

On Fri, Jul 10, 2026 at 02:33:55PM -0700, John Stultz wrote:
> On Fri, Jul 10, 2026 at 1:39 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > With proxy-exec, pick_next_task() can return a task with blocked_on set
> > (a proxy donor). put_prev_set_next_task() then calls set_next_task_scx()
> > on this "ghost" task even though the task only provides scheduling
> > context and never actually runs.
> >
> > Calling ops.running() for such a donor produces a spurious running
> > event. Simply suppressing ops.running() is not sufficient because the
> > following put_prev_task_scx() would still invoke ops.stopping(),
> > resulting in an unpaired stopping event.
> >
> > Introduce SCX_TASK_IS_RUNNING to track whether a task entered a real
> > running transition. Set and clear the flag independently of
> > ops.running() and ops.stopping(), as the callbacks are independently
> > optional. Invoke ops.running() only for non-blocked tasks and invoke
> > ops.stopping() only after a real running transition. This keeps the
> > callbacks paired for proxy donors while preserving stopping
> > notifications for schedulers which only implement ops.stopping().
> 
> It took me a while to understand this.
> 
> It seems you're wanting to distinguish normal task selection and
> execution (without proxy) from just task selection for proxy-donation
> (where it doesn't run).
> 
> I think what makes it confusing is that TASK_IS_RUNNING is not set for
> the case when the task is running (rq->curr) as a lock-owning proxy
> for a waiting donor.
> 
> Would it maybe make it easier to follow if the flag was
> TASK_BLOCKED_DONOR? And the logic was flipped a bit?
> 
> That might more clearly cover the case you intend here without extra
> edge cases that you'll have to explain (well, you're running but
> you're not the donor and running... ).

I agree that SCX_TASK_IS_RUNNING is confusing, because it doesn't describe
really well the rq->curr/physical execution.

What the flag records is whether a task entered the sched_ext running/stopping
state. With proxy-exec, the selected scheduling context (rq->donor) and the
physical execution context (rq->curr) can differ, which creates two relevant
cases:

 1. a blocked EXT donor goes through set_next_task_scx() even though its mutex
    owner executes instead. We must suppress ops.running() for the donor and
    remember that it did not enter the running state, so that a later
    ops.stopping() is also suppressed,

 2. an EXT mutex owner can execute as rq->curr for a non-EXT donor. The owner is
    not a blocked donor, but it did not go through set_next_task_scx(), so it
    must not receive ops.stopping() if it is subsequently dequeued.

So, I don't think changing the flag to SCX_TASK_BLOCKED_DONOR captures the
required state. SCX_TASK_IS_RUNNING handles both cases by recording whether the
task entered the sched_ext ops.running/stopping() state, independently of
whether either callback is implemented.

How about renaming it to SCX_TASK_IN_RUNNING_TRANSITION and explicitly
documenting that this is the sched_ext callback state, not physical rq->curr
execution? Something like:

  /* entered the SCX ops.running/stopping() state, not necessarily rq->curr */
  SCX_TASK_IN_RUNNING_TRANSITION = 1 << 6,

Any other ideas for a more clear name?

Thanks,
-Andrea
