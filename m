Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F0331ECB
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353657; cv=fail; b=X2TIfF7SzARSEJcxx3UaadtTkRfYV6hcD3OTfEm/9lIfD1KC3XbHKDk3Edf8bkiQEXg+eZT3mJtz0JzIHMvSqQlk328IK7Jw1bR3TFx1M3kSe4qpASA7tR72kiKkXaT2cStHfRsCZhHK9p3C1ZDBxY4LzeLPg3GJ7C0I9VOssLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353657; c=relaxed/simple;
	bh=uEC7yIYcRfWqZp8Tl0DH3EtJPz8lbIh2sUNnIzIK3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYUscg1E4D7g+Nr5tdTQqixcgYlhx+6V2RdSiycRnmQt5J+FjbhPn8jx4b1aoDOffQdrOGWP63uX57V33PIpCox1b5OryOZK2gWpOqL6ytbnxmvW2VwwoKFg5FagT0MTUWHGI+tKnZOLLMKLlyKHjC5IkWXA+tuq8opMUzdtgs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvwz9xDQ; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvwz9xDQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmqvIgiXghp7woIVubzY/+YLit02t320aNmymGAIsn3Y+v4zdWZ8H3Y9Y6ZdN8FikPJH3SX22t/kdH8HjU+DReOh/OxpPB1Klc6CllTPNIt+8lEQqQUWSh4U0JVJMStuB2CKRdzT1wifFoLtmkto9uYJpIusXOfes68oUnQEdG1kYzYUDzalIQar/RrxHocaTA4pi0+sMlW1ahy4Wi+TAhUcujc3Y90dg6zDyqvLqlhrPo+ZKdLFA273mtWK9xRusynQvPFP1If44Tf88gZ8xz37AbtAn8kAbTemmoT8H7S7TSo88JRe5TYB24bV0G6nvbkhPPi6p75Yev8RsoGmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1ibOdJ8qWkEp6YQ+ln0wnAxPflTOUv6xkIlzMRG970=;
 b=WQWOt1XDLM0yiVYKIt9h7rBOu6odqc5y3RVUHNGZAKyGc4u2BERhRhlJ9e4MaN0f4A41XV2sRzjZrRynetCLySOWo1Vz6SFZeXwuzXQNeLciWEnv8FHoj17cOwTAB6ri4JArP5PUu4psOAbmGBgGzQ7CMIu4BedpsNkq0BPtiGXe6l4fGq13xCyKEvlxY3GOAsuQQBMl1qX396fyr3VDBAajev3WEbwu3+jBsdeztVFBn1d9lLMd0yNQz6YJk9qWxvUpcxkLllELDuD+QWDwSi7ZH5PzofTmNel+da0c9YY6LvL8K1MxXyhYxm4vOy110R2Lx9oe+oiOgYYJ8awa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1ibOdJ8qWkEp6YQ+ln0wnAxPflTOUv6xkIlzMRG970=;
 b=lvwz9xDQasHYT6qaejSQYBuR3d7FTkAyOqPwr3sm7dceKZ4mRWeXbLlxesnLMZPKDoXN5ek+6fsoJ187GcaFrWsUStoxLTl6H0vEb6C9oGJoS1YoPiw12gLSft4JK3ext0ZSyimYQNJoGX0BjacdEcTqXPV2LeczmVCITtIhfoJMLDaqGy9cwyYpFKwqYjtEcuUN25Kru5f/A5MiQhdCTinXY8qEkJKB/c/P/AM32mkOFQ4NIn1cVSAgObEgsfcZpy/CI6ibCNuTp/p1Uv8fK8e191cbUjLmNq0agwGUXqnmTFyAHXuoWHksWX4H0Qe1zsYZIzafmVkdNeqTmjFJ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Sat, 18 Jul
 2026 05:47:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 05:47:27 +0000
Date: Sat, 18 Jul 2026 07:47:19 +0200
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
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <alsTZ3oBDndrw52u@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-11-arighi@nvidia.com>
 <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com>
X-ClientProxiedBy: MI1PEPF000008C4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::426) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: e7681507-a782-4ae5-6acd-08dee4900c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|6133799003|22082099003|4143699003|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Rrm9rjzQ7cUoH+NcRWqYzu2Ir2ejS7rbdpMc2d+hvapDJqXGJCTqr8wsMmeHIG3ZwM2VBZdSPt6Nv1IdRkbVoVBYiD5d/jlrGRq4b4tRX/PA57yiJzRv0gnbYzwQn1bJnvnLDBSTWyDU5DhfqiZop+eNijjyAko9reTvA/7Zmbbq6IU00mm1p692PyCKNU7HaOfCHJkxVgnoNENUrBSBJiVS9+HZSc0WfYuVdeEmPq5z0s2BlZez2fPVTCK+K1HiaSi7cFsXWKEVtlAQhUA1lLuzaKbAyhh63UAgSZAIqqlriRssS9bmmNycWiKNNZvCmuDt7Zms8MO74MZkyNJtp9dmiDdtAIb1/WrkC0Lgm65hq7n3X2lx7/kacresQj8QoU9Ff0SOskAP4CMUbJb+U1G0GPax5qqsyttAUkA2sClNTNkdC5a1/AYtC8haiyorpg6JYVZ+Yu+FFqzSp456y1Haj7M7rUQsuc0/mGm/tad8f6ybyFYh7nyk/yZ98FX5X1jw6BG9v9twa8M9ukiJNIewfOUHJaA9gyd+Tei0/lX2gHt3mXYfkKN0fZgdvz5a0ubFzE8uLanL1zO4CSPm3yAcuyFMon28YDR2zyI+LVg/GMcQf+OJ+NCHskmwRkDTh8ZbDyOdgAi3P4lCGL8yfceml9RAA0jLLmxG0Jr/HLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(6133799003)(22082099003)(4143699003)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3o3cXgzZC85OXpiTzVHZ3Zzd0tTajQzL1lEemJ6N2Y4QStRcGRmQWkvenVJ?=
 =?utf-8?B?YkFEUDd4d2FScG4zdTN2VmdCT1NNWmFZRnRMNXBteVNIbUpmMmllZ2NmUm9x?=
 =?utf-8?B?dFlPWVNuOTI1RUd6cHAwZk1ORTYvZFd3OS83aFlFYUVhQjV3cEE0VmZTSnJo?=
 =?utf-8?B?RnhLQ3hnNVlZOUFMYjNEL3YxTmtCZW1wWUpCNGF2Z3VnN09mSjBIR2NIeDVm?=
 =?utf-8?B?VnZ2ZklvTUtnWnhybko4a0s1WndoSEk2UUNSVWhZbFpJaWF5cG9JTXJaVU4v?=
 =?utf-8?B?R2h6QXdBYzlwNDVXNFp1QzNBSDdBb2g0dmk4L0gwdjcwdnFJdFU4OXo2K3lm?=
 =?utf-8?B?bGVpSmI5Ri9TU2h0ckV3M0lXZEVveXFMeGNlYmhoWnlYbm15NERYWlB1SU5h?=
 =?utf-8?B?NmNZcTEzOG5qOW1pU2taejloT0Zwck80TDI4MVBldzU3dncrTUZ3c0dZdzNv?=
 =?utf-8?B?bkRRL2FGVW1oaDlNWlhPYUJJUGJVbDlrN0JvbmVyQS9zbXBWeGorbnJKN3I1?=
 =?utf-8?B?bFlEdkFwQmV1TmZ6RXFoR2lORHlZSVBsaEsyNE5HRHVoSGE4SHc2NUpuS3Zt?=
 =?utf-8?B?SjNXbWRCWnBwQ0xDUG1CT1BYNFd5dncrdEMyUmtvSlM0d3liVHJHRE40OXNC?=
 =?utf-8?B?UU9HWGFWVXBtMnpJSUxHbHkweWpzQlZrZzVyLzVFc0FXTEJGQmhuZjdIa2NK?=
 =?utf-8?B?ZFQ2c2U5YWp0dXNDb0g4d3NsamR3bDN2SUZSeEtpTW8wWjF3MkZHVUJMUFFL?=
 =?utf-8?B?TlcwaDVCQVRzdkVqM3BZUmtvMDY5WVhxNnJKSno1N0ZTbm1UaDRPVU10Ukwr?=
 =?utf-8?B?SjZWVmF5TDhtS2dCbGxSTDZnV21kTDNqVk91d0dQSTdVOWdvbE9yektmdnRC?=
 =?utf-8?B?SUVoblJ5bWFFVzcybFU1TEZScDhtOTJyRXF3bUtNVjNKbDlNUkhTVi8yUnRw?=
 =?utf-8?B?WkdqTGk0L2ZQdlpzbEhYNTV0VmhZdzNnRUxBYTh3VWFZOUIyci9ENWUxeE5s?=
 =?utf-8?B?SnQ0bWdMYUphTUFMTm9YbHk5NWoyKzRta0I2ZWF4MG1LQlBjUHZxRkhEak1p?=
 =?utf-8?B?ZTJYNjN1RHBrYXhaKzhCRHhPR2xhSno2TGZ5c1ZBcjJiMm55ZXB5S0VzUEJr?=
 =?utf-8?B?M0ZuOG03RU11QkVOZjNSRVczMVRLYTRrTTNhWjJneTBiWllBOW91Rms1V0tV?=
 =?utf-8?B?NnRTNEd4RExiNTAzMzZUVkZNSWY0YnJWUkIvcjNPSEErUjNkb3FvZWRHejQz?=
 =?utf-8?B?dVo0M0NRR3VFV1d6eTErajM5eXcrdnFkbk92dThDRmpWZGFsRGJwMXNtZ0FX?=
 =?utf-8?B?T21GbGlOZ2FuYUUzaTJub3djZkt2NnNldWU5T2dBUW8wTzQ3SDZJUVBGVDFn?=
 =?utf-8?B?ZEFpNkdwNlRhSE5acTVMQUVLZ0NNUkFyV3JvZjd5cG9Rb0N4VTFSRm5JMlZB?=
 =?utf-8?B?ZjJ3TTdxL1BNcVo0Q3Ziay91L0VIRG9QRGF4eXRCdDNkdDFvMWc1a0N3ZzBN?=
 =?utf-8?B?M00zaW1zbm9NQy9LYmV6NmFmQmZTSWprY1c1a05XR0I1MllLeU9RTDljcnNs?=
 =?utf-8?B?Lzh2T2RnWWo1V2RWYVZXUmtvSEFNclR1QUttNVZZc1FqeE1jVUVRSjRFVU9E?=
 =?utf-8?B?dGFnUVZ1WUhSWjFKN0lNOFAzZVVYVnVEU2xxUVBUcldCZHdlbUo5Z21tdUNJ?=
 =?utf-8?B?N0dxYXQzRTVlMVhIS2dTNlRRZVMxSFgrckdtc2hpRW4wRmpPeUpISW1xYzla?=
 =?utf-8?B?M21jOWNQUmVsTkc2N1FvSm5vOVdxeitQem0rQnFsdHdxeUtBZXhGaEc0bG81?=
 =?utf-8?B?RklGNm9MbzcvK0FHdGpyS0NXMmpldXVrL0xYTUlvZWpiVlNYOGY1V09mQUt1?=
 =?utf-8?B?ODQvOTluNVFvMGxVdmlxVXNXZUJWQzF1aGk3eWo1bFBsSzZ6RktQeEZiYk9S?=
 =?utf-8?B?UWJqV3dPdUhlcHhHQmd2dllmWkVtN2UvNGRLeFIvWUR3ek9wekk3ZFRyR1Mx?=
 =?utf-8?B?cGJ6c2pwL3Y1dTN4N0NyMmE4RDQ5SWlrYzNCTmovUHhTeGI0dytsdURiZ3Jx?=
 =?utf-8?B?U3BGTHNoSFdjbVA0Rzc4UFpKSWNDMEJwZ2lOeWM4YjZPUVVCV2YvcDVGclhS?=
 =?utf-8?B?SVVYM0JaWDFFL0xVcTZOSnhFbU5hR1FGcldCWmNuR3JJUHVkZ0hFMVRYOWtN?=
 =?utf-8?B?QkFZa2lWZHZ1N1hhRHdCajJSOURrdGdGeG5yYnBrUEgveENGOFFVU0NpdHdB?=
 =?utf-8?B?azY2SHo1d0hEalRFa0hIbzI5UWZET1pYYzFTNlVQaXhmby8rbm54SDc1V1FL?=
 =?utf-8?B?bHlnUytjd2E5M25tOXVOVkdEZ2s5TC9LQWc2eGczNDh3dVhGMit3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7681507-a782-4ae5-6acd-08dee4900c8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:47:27.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3rtEMrgRvjP6+vZwG0QEyM6yuR6YZkcWLTNdxWsp6nNBUw9MzkOKAZC2SHhVYoCbx2EwGL49N5nHUBbsKNfXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

Hi John,

On Fri, Jul 17, 2026 at 07:28:49PM -0700, John Stultz wrote:
> On Thu, Jul 16, 2026 at 6:23 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
> > proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
> > and mutex waiters block normally. With -B, blocked donors are passed to
> > qmap_enqueue() with SCX_ENQ_BLOCKED.
> >
> > When scx_qmap receives a blocked donor, dispatch it directly to the
> > local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
> > This places the donor at the head of the DSQ and requests an immediate
> > reschedule, allowing the core proxy-exec path to run the mutex owner
> > using the donor's scheduling context as soon as the donor is selected.
> 
> Hey Andrea!
> 
> Thanks again for your great work on all this, I'm working to test your
> changes with my full proxy-exec tree, but before that I caught one
> issue here.
> 
> I was excited to try this out, but when building and running this from
> your kernel tree in a VM, (who's kernel is running from the same
> kernel tree, built on the host), I get the following error (with or
> without -B). The other scx_ schedulers in tools/sched_ext/ seem to
> load and run ok.  Maybe is there something I'm forgetting to do here?
> 
> thanks
> -john
> 
> # ./build/bin/scx_qmap -B
> libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
> libbpf: prog 'qmap_dequeue': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx() R10=fp0
> ; void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64
> deq_flags) @ scx_qmap.bpf.c:584
> 0: (79) r2 = *(u64 *)(r1 +0)
> func 'dequeue' arg0 has btf_id 142670 type STRUCT 'task_struct'
> 1: R1=ctx() R2=trusted_ptr_task_struct()
> 1: (79) r4 = *(u64 *)(r1 +8)          ; R1=ctx() R4=scalar()
> ; __sync_fetch_and_add(&qa.nr_dequeued, 1); @ scx_qmap.bpf.c:588
> 2: (18) r1 = 0x10000fff7000           ; R1=scalar()
> 4: (18) r3 = 0x10000fff7000           ; R3=scalar()
> 6: (07) r3 += 32                      ; R3=scalar()
> 7: (bf) r5 = addr_space_cast(r3, 0, 1)        ; R3=scalar() R5=arena
> 8: (b7) r3 = 1                        ; R3=1
> 9: (b7) r0 = 1                        ; R0=1
> 10: (db) lock *(u64 *)(r5 +0) += r0   ; R0=1 R5=arena
> 11: (18) r5 = 0x100000000             ; R5=0x100000000
> ; if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) @ scx_qmap.bpf.c:589
> 13: (5f) r4 &= r5                     ;
> R4=scalar(smin=smin32=0,smax=umax=0x100000000,smax32=umax32=0,var_off=(0x0;
> 0x100000000))
> 14: (15) if r4 == 0x0 goto pc+3       ; R4=0x100000000
> ; __sync_fetch_and_add(&qa.nr_core_sched_execed, 1); @ scx_qmap.bpf.c:590
> 15: (07) r1 += 48                     ; R1=scalar()
> 16: (bf) r1 = addr_space_cast(r1, 0, 1)       ; R1=arena
> 17: (db) lock *(u64 *)(r1 +0) += r3   ;
> ; QMAP_TOUCH_ARENA(); @ scx_qmap.bpf.c:268
> 18: (18) r1 = 0xffff888104842c00      ; R1=map_ptr(map=arena,ks=0,vs=0)
> ; v = bpf_task_storage_get(&task_ctx_stor, p, 0, 0); @ scx_qmap.bpf.c:270
> 20: (18) r1 = 0xffff88810c333600      ; R1=map_ptr(map=task_ctx_stor,ks=4,vs=8)
> 22: (b7) r3 = 0                       ; R3=0
> 23: (b7) r4 = 0                       ; R4=0
> 24: (85) call bpf_task_storage_get#156        ;
> R0=map_value_or_null(id=1,map=task_ctx_stor,ks=4,vs=8)
> ; if (!v || !v->taskc) @ scx_qmap.bpf.c:271
> 25: (15) if r0 == 0x0 goto pc+76      ;
> R0=map_value(id=1,map=task_ctx_stor,ks=4,vs=8)
> 26: (79) r7 = *(u64 *)(r0 +0)         ;
> R0=map_value(id=1,map=task_ctx_stor,ks=4,vs=8) R7=scalar()
> 27: (15) if r7 == 0x0 goto pc+74      ; R7=scalar(umin=1)
> 28: (bf) r9 = addr_space_cast(r7, 0, 1)       ; R7=scalar(umin=1) R9=arena
> ; if (taskc && taskc->fifo) { @ scx_qmap.bpf.c:593
> 29: (79) r8 = *(u64 *)(r9 +24)        ; R8=scalar() R9=arena
> 30: (15) if r8 == 0x0 goto pc+71      ; R8=scalar(umin=1)
> ; if (taskc->highpri) @ scx_qmap.bpf.c:594
> 31: (71) r1 = *(u8 *)(r9 +45)         ;
> R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0;
> 0xff)) R9=arena
> 32: (56) if w1 != 0x1 goto pc+9       ; R1=1
> 33: (b7) r1 = 1                       ; R1=1
> ; __sync_fetch_and_sub(&qa.nr_highpri_queued, 1); @ scx_qmap.bpf.c:595
> 34: (87) r1 = -r1                     ; R1=-1
> 35: (18) r2 = 0x10000fff7000          ; R2=scalar()
> 37: (07) r2 += 88                     ; R2=scalar()
> 38: (bf) r2 = addr_space_cast(r2, 0, 1)       ; R2=arena
> 39: (db) lock *(u64 *)(r2 +0) += r1   ; R1=-1 R2=arena
> ; struct qmap_fifo __arena *fifo = taskc->fifo; @ scx_qmap.bpf.c:320
> 40: (79) r8 = *(u64 *)(r9 +24)        ; R8=scalar() R9=arena
> ; if (!fifo) @ scx_qmap.bpf.c:323
> 41: (15) if r8 == 0x0 goto pc+60      ; R8=scalar(umin=1)
> ; lock = qa_q_lock(fifo->idx); @ scx_qmap.bpf.c:326
> 42: (bf) r2 = addr_space_cast(r8, 0, 1)       ; R2=arena R8=scalar(umin=1)
> 43: (61) r1 = *(u32 *)(r2 +16)        ;
> R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
> R2=arena
> ; switch (qid) { @ scx_qmap.bpf.c:129
> 44: (66) if w1 s> 0x1 goto pc+8       ;
> R1=scalar(smin=0,smax=umax=0xffffffff,smax32=1,var_off=(0x0;
> 0xffffffff))
> 45: (18) r6 = 0xffff88810c3339f8      ;
> R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> 47: (16) if w1 == 0x0 goto pc+17      ;
> R1=scalar(smin=0,smax=umax=0xffffffff,smax32=1,var_off=(0x0;
> 0xffffffff))
> 48: (16) if w1 == 0x1 goto pc+1 50: R2=arena R7=scalar(umin=1)
> R8=scalar(umin=1) R9=arena R10=fp0
> ; switch (qid) { @ scx_qmap.bpf.c:129
> 50: (18) r6 = 0xffff88810c333bf8      ;
> R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> 52: (05) goto pc+12
> 65: (7b) *(u64 *)(r10 -16) = r2       ; R2=arena R10=fp0 fp-16=arena
> ; if (bpf_res_spin_lock(lock)) { @ scx_qmap.bpf.c:212
> 66: (bf) r1 = r6                      ;
> R1=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> 67: (85) call bpf_res_spin_lock#85478         ; R0=0
> 68: (16) if w0 == 0x0 goto pc+9       ; R0=0
> ; if (taskc->fifo != fifo) { @ scx_qmap.bpf.c:331
> 78: (79) r1 = *(u64 *)(r9 +24)        ; R1=scalar() R9=arena
> 79: (1d) if r1 == r8 goto pc+1 81:
> R6=map_value(map=.data.qa_q_lock,ks=4,vs=4) R7=scalar(umin=1)
> R8=scalar(umin=1) R9=arena R10=fp0 fp-16=arena
> ; bpf_res_spin_unlock(lock); @ scx_qmap.bpf.c:332
> 81: (79) r2 = *(u64 *)(r9 +16)        ; R2=scalar() R9=arena
> ; if (taskc->q_next) @ scx_qmap.bpf.c:336
> 82: (79) r1 = *(u64 *)(r9 +8)         ; R1=scalar() R9=arena
> 83: (15) if r1 == 0x0 goto pc+4       ; R1=scalar(umin=1)
> 84: (bf) r3 = addr_space_cast(r1, 0, 1)       ; R1=scalar(umin=1) R3=arena
> ; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:337
> 85: (7b) *(u64 *)(r3 +16) = r2        ; R2=scalar() R3=arena
> ; if (taskc->q_prev) @ scx_qmap.bpf.c:340
> 86: (79) r2 = *(u64 *)(r9 +16)        ; R2=scalar() R9=arena
> ; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:337
> 87: (05) goto pc+2
> ; fifo->tail = taskc->q_prev; @ scx_qmap.bpf.c:339
> 90: (07) r7 += 8                      ; R7=scalar()
> ; if (taskc->q_prev) @ scx_qmap.bpf.c:340
> 91: (15) if r2 == 0x0 goto pc+2       ; R2=scalar(umin=1)
> 92: (07) r2 += 8                      ; R2=scalar()
> 93: (bf) r8 = r2                      ; R8=scalar(id=2)
> 94: (bf) r2 = addr_space_cast(r8, 0, 1)       ; R2=arena R8=scalar(id=2)
> 95: (7b) *(u64 *)(r2 +0) = r1         ; R1=scalar(umin=1) R2=arena
> 96: (b7) r1 = 0                       ; R1=0
> ; taskc->q_prev = NULL; @ scx_qmap.bpf.c:345
> 97: (7b) *(u64 *)(r7 +16) = r1
> R7 invalid mem access 'scalar'

This looks like something related to BPF arena pointers and incorrectly
generated BPF code (the other schedulers don't use BPF arenas, so that'd explain
why you only see this with scx_qmap).

Which version of clang are you using?

Thanks,
-Andrea
