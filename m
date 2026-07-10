Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A113AFCEB
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716462; cv=fail; b=fx590Gkhxv1sZd5eesgh3lR4ysOwgOwm7jotXbsBWhw1N9qyDZm3vWBe3IhG0weDSGa/svtc8BWhQSMC7StjCjQxRzbFRgd+yB6zbSVEMlaCcmgYBzapfHkdnosa3Z0R4IXmrJGJFyqZY7lml9M3yrQPzYUw98ZLH8+8Ma+bIeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716462; c=relaxed/simple;
	bh=aSCYsvDGiR2QcwOPATUD7ayk5e7pATuf+89ezRSCVC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nkSFhGdJ0LWGlBDFsMHzrxhmZpG1TtRIkXyiiP73QQmB6Ur9TAIGc+5K3RQ0qrbA1TeQ6SrYLaIJFK6TH8o2AWtrxapjBndsfscTGUuB0Qq7KLP1BOJg8V48JOSs0nW2AslX1lDvjfoECoqH1hWJL4vpEawSy1jwEMf8Y3boxgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYHG/qvT; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYHG/qvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nv1rkogWj/Qjl0ypotMCAtOTnwAbqAYCyXKUnj657Tw5NwP8tBboYEa5nPcavorD4AmwvqyCaXWkrfl0t0yVvh/02IbwS6vfURDsagJQrb8iW2HAZWde96kRfbty9bUBklNckTlqe+WDXoY9inS7qk1c+9pnft2ICJdtp5wqnT/4FQbjVb8X8sC6y7RRpyNLE4GWuDor5GQB55kGYcEnwZHXkLat7Rv8tfsQFywtNKcHe+vvUgpdRd62LWEAQqluCSUy8Z/ujfo8RX6VD1RW3rkZ6HcsmcKoXf80HA+H5Ijnj+XcHta1t14hkPGlkwYKvI1em3BYLHAv4nh9gs9+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th66wVqwkVkq5mlI6IfoepZiyW2XiLcROYQh2tFwaRA=;
 b=lbCOHAsimQY7vC2WqEcl921zeLbvEy4cLtOBpdlugw4+zhC8mg1qee7LiPWrif5w5jDCOAej6cAyzlnozgM1i4sKhbL6AjOGSfVFuwZ9nlii4b0WuOUnKMtcdCObPrTIevfhLlmAzkZhQtOcFX/AALM+UbMky2+YxM94nWjV26kBE7LQg/iN4BNhKpxUVCzxgacLvTYO8tDjODRb9nht3rb7Cdas+udmcrN1FTVimRahiqoKOs1Fz8pPxKacTn6UQ5tKjKp38Cb5IfIxpoXVWWu4bowXDH2MjuYwY0uO9xllwCIpxwq+yuE8mGp79GWzuv/37dNT259XbUukORcb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th66wVqwkVkq5mlI6IfoepZiyW2XiLcROYQh2tFwaRA=;
 b=NYHG/qvTUc5JQdrsnzIJndHIg4p7vc51JquXTAPH5b3sr6YFcbwE64ODbqKbwV0m3qzEZukOfRDCnwiTXzu4kS3hANIqMz8iCPklvPe2xTOPUP59MlXr7TFYs0I5OlBJnfUznMbxW3ukg5zFGhDytD9pCxgZ+Ku7LFMuEimA6cLD86VNxVA6GjmZFZNy3leAN5KC5OscbB0+WE2r4Bp0XSXuM36Xj4qtfDY6QJsARhUhaA97ihiDxIwHzZ7yIDDjsWjHhlAOSYS/Cxzt9vcVpX6FEUZs0TRRslJcfEXCrZ/TnS+cS5bySGVtL1aijNgAcD+zbZey2fld3jyQxaWb2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 20:47:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 20:47:28 +0000
Date: Fri, 10 Jul 2026 22:47:18 +0200
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
Subject: Re: [PATCH 01/10] sched/core: Drop mutex locks before proxy
 rescheduling
Message-ID: <alFaVuDMuGNz8a-g@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-2-arighi@nvidia.com>
 <CANDhNCrR+jiW2QEDE9yhbuFEp2nfnWh2Vf-_GT9NWhSP3oSE2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrR+jiW2QEDE9yhbuFEp2nfnWh2Vf-_GT9NWhSP3oSE2Q@mail.gmail.com>
X-ClientProxiedBy: MI3PEPF00004E96.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::446) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 542b18c6-cafc-457c-6205-08dedec474ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|5023799004|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Usd8IvqkrJuFVeXFCfXM0P1/xskYuX2xQyfoQDAN4MzA1T032tU1CMLN6B06MG5CZ3gffj/jDcaSv3U4ZfS5De1hSFsj3qqt2B4+VM7J7/94EJcGGMI8UKmy+Orl7eo13lAdQ3k540M3vfeyxF7z461BKfsDpeUrbwjfECRh1MGH4x/Ym/J6NxORwbkFqPSe03uRSQjyTx2H4BHILRSxg7pCxMAm1IVqSgx1q/zaO1/5L7TPcCbNpEE4WSIHxb0tuzmOTTjUEhysW7RIEVFNj6PFUEwWE1hZPJajTVNDOSM9avfIUpyiWcnUxSaDDHIXu79YktD3V0d4JY6nzZ4uyHCCLu+bB5PHn86Szwkhi4oD7C84ZK2+tc5Pjl8oGrVqsJeW78jBmBtPd6yFiyh+ECpymuz4nNKzmM88r+39ka1NPI6Ksn4LWmVryVUmpOyhUQiGwNQP70ecLF1Y2i2+k0KVwPYnNJRjyDujHV3lKy7F3uscLKIAZ0REZtZ4ziiPU1qaRUttlTjKGMwDAE7fK0vVlGlfTo4bDvrAWLr9t14FP0vuzVteoxMCsNj37+dotdVN76Qx6Ij5k/8/Om9/hJoIQ/miOiaYflrqhNDssh+xOJpQqJWD1Bkxf+lxItozkfJpcy2pjV4mdv/SGyBGhXRBkw+gixe3JMdtF6139xQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(5023799004)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lwY3duQTlEVTlGWmxMSmR4YUtjaHVNTk1pWTVPTjVpVFQwazQwODd6dHF3?=
 =?utf-8?B?WXFYWkZFcVhJblhidGlZSmFIM0VDeXlWOCtQYnNPK2l5SHZZR2lQYW9QclJG?=
 =?utf-8?B?V3NXK1lpbHRQRTBXcjhkRVpoWEY3RFdCSXZTMTVab1FpcDNhSVRzYU1GdXpY?=
 =?utf-8?B?djQyKzJ4ZjBDR1hQNTZjK3J0Yy9GREZaZzN3YzhIbnVQNXlFdTV2bDllRGJE?=
 =?utf-8?B?cTdRME1SRml2OFFsdG1PYXJMQnJmcGdWVlJYdlcxSktkTFVjQi9JMnN6a1Uv?=
 =?utf-8?B?V2o1MmdVd2swb1FYUCthUTJSRXl2UC9FeG1lalpqNlg3RVAydEFyV3VBUUY0?=
 =?utf-8?B?L3hsanEyODlGVDZreStRYkh2Um9EKy93TFAzYmgybWZNTW11YUt2WkpQVGFo?=
 =?utf-8?B?WW0zdUNmWXg1WHN1SisvQk9EV21xaG9MemJCMWF2cEp0VlZRRHJXQUlMTmpG?=
 =?utf-8?B?QmxRQTJPaTh4ZGlnbmhjUEpjU1lvemdkV1pzNFFMMVJtM0RZWUpGSzl0UVha?=
 =?utf-8?B?V0tCRGY5WVRhVm9jczFpRld3RGYzakZKQTZJbXJ1V29maWJMaFBieU9ES2RN?=
 =?utf-8?B?Z25VNkZpbE00OUZpYWZWbzhiWWpjTVJPYnFla0gzcHg4MkduQUFINlpjQ3FN?=
 =?utf-8?B?V3hXdnpkVmw2dVdXZUdvL3doZEM1eGtOR2hJbktaSjg5U0l5Q1ZBNnA1ak5h?=
 =?utf-8?B?WVRlclQ5RTFIL1VpNSt6M1BvdHpHaUFaQjBZVUxzam0wYVlOMmNXOWo4ZWsx?=
 =?utf-8?B?REU1RjBCRldFU09pdHpBSEFlL0JncWliNUJPaXpURUNmUUFmUk1yTHRXaFFH?=
 =?utf-8?B?c05FVFJONlozeXViMlA2anp5b2lGdXlQQWZQaTJrS000b1VUWUdlQ003cm9r?=
 =?utf-8?B?Y0k2WXk0akRCTXBpQXFVWUZEWUJhWlNKREFCRUNpdnZyWTBzUTJFVEtvUVRE?=
 =?utf-8?B?MGVqRWpmc3hGeElUejhhMm1VVUNHZXhUWER0RktmUDUvTisxR1ZCd2RnaWpE?=
 =?utf-8?B?YmNOakZzaWJ5bWhjU1d4TXZoTjU3RW5nYmZTNmd1YkNndk1jWnJLRmFlL1d2?=
 =?utf-8?B?VHEwT042dFBSampXa2ZBTnRCTFZyNS9BbDlpOXNwV1k5REhnTUdHMlhQM2hM?=
 =?utf-8?B?bTF3eXJBYUNNSEpoaHNxbytmZGk4SVMwSVBmc3B0eWRWTFRsb1JqSTl2L3JL?=
 =?utf-8?B?TStvNjRvSHVkbllMOFo2bFkyNXdJcEF1cTZKOXN4S1k5RGRvaG1iYlJHSUQx?=
 =?utf-8?B?cEZ5T1JiSE5GYit1Q2diWG9sRmhzdU1LT0Z4cENaTTR2UThvRXBxanp4cC9k?=
 =?utf-8?B?TDc3ZUJ1SnVOV0dTaGtMUSs2SldGeCtQcTZXNEYrMEFTdHdhZXFEUTR3VlBp?=
 =?utf-8?B?SURpVk9TNXRJTEtUcFhEMm1wdENWKzREcU0wdDQ1cGNMU0VZYnhEQW9FdUlZ?=
 =?utf-8?B?Ri9QdFo5OGhGNHhDVWtvUnFOQWZBWUpQSDBHU1RTajVtUndZcnpqL2w3bXpm?=
 =?utf-8?B?QW15dmdneUJYNE95TkluemNsZTE1bVFXYTRYanlWcEw1NGZ4VjRCZjk2aGI3?=
 =?utf-8?B?TituemhwcFNFQ3BrdG9mbFRBenZoMzU3MkRkOHBHTGp3dTA4aUM1Wmt1R1hC?=
 =?utf-8?B?UW51RDZpRjd1MFhkYXE1bk1hTDZjeDJiMVZOZEwwdTZDWTBLOUM5cE9PcTFr?=
 =?utf-8?B?Z3VXS2haN2xoTTNObkJQRzAraVFRQ2kyZm9RR3VjQTZjVlhvenZPQk1yMnJM?=
 =?utf-8?B?Q3g4M0ltaEJ5dXg2UGtHWWZ2ZURHSjNuR0lscDRmRHAyMk85WDlKeU5YaHh6?=
 =?utf-8?B?Rnh4Vmw1cGtkWWgzYlhyWU5YUmtxNm1vTXc5VmUrTCs2WGk3Qi9HVzJsbCs5?=
 =?utf-8?B?NVd4NTRrZ1VKazFINHJZK0hZb1FvUlJ1VDY0NkFNb1lBSnMvbENzeUE1ai9X?=
 =?utf-8?B?K0tyY0drbDlFd1N2SCs4bU5HSjhRZWkzV29tMGtHRlpVR0ZwK1IyS0h4Sjh1?=
 =?utf-8?B?SlVxV0ZGZXI3bFFOQ3JDVjNjRk9mQmZBSTcyUVlIVURuUm5ucFJTU2w1TlE5?=
 =?utf-8?B?Q3ZVQU1YMUFtbHQyalVoaUlmdklyTGVlSUhsV003V2tmK2ZISG1lbVU5dkVK?=
 =?utf-8?B?WUJQenovUmlhLy9iMTRRZWZ4eGRyYkRBenFvTHFwM29GTXZTdUdIa2c0ZlJj?=
 =?utf-8?B?UW1YdXVkZmdwWk5VZlVTTWVGd1dodHY5dW1XeUd5UHZzTWdMc1FnczZYQ2dH?=
 =?utf-8?B?K0lUZEFTVmRVa1g3dHRreUk1dkRMd21GVzRNOUFsZGY5RElhOHp3RFZFUzRi?=
 =?utf-8?B?SlYxby8yeVdwekpEbW9GT2dWdlJwMWtTTUpPT09sR1k0NnQ3bHROdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542b18c6-cafc-457c-6205-08dedec474ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 20:47:28.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD2QCNHQFNO+Qly56He8RPSkNo3Y79MOV0LGnDBz/Kjw8XJ074UeT8p8O7j56N1G0sCEDm/ibBD+AMIyXbjSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

Hi John,

On Fri, Jul 10, 2026 at 11:56:04AM -0700, John Stultz wrote:
> On Fri, Jul 10, 2026 at 1:39 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > find_proxy_task() can call proxy_resched_idle() while holding a mutex
> > wait_lock and the blocked task lock. Guard cleanup does not run until
> > after the return expression is evaluated.
> >
> > proxy_resched_idle() invokes scheduling-class callbacks through
> > put_prev_set_next_task(). Calling those callbacks with the mutex locks
> > held prevents them from safely inspecting the proxy chain, as doing so
> > may require acquiring the same locks.
> >
> > This is a preparatory change to support proxy execution in sched_ext. It
> > leaves the guard scope before calling proxy_resched_idle() so sched_ext
> > callbacks can safely inspect the proxy chain.
> 
> Thanks again for sending these out!
> 
> So, I wanted to understand more the importance of the sched_ext logic
> being able to inspect the proxy chain?
> 
> I sort of roughly understand the argument that some sched_ext
> schedulers may not want to keep blocked tasks on the rq (effectively
> what the "Delegate proxy donor admission to BPF schedulers" patch
> does), but that doesn't require deep inspection.
> 
> This change seems to be needed for "Add proxy destination query
> kfuncs", where the commit message sounds reasonable, but as I think
> more on it, it doesn't look correct (I'll comment more on the patch),
> and I'm still confused a bit as to the purpose.
> 
> So can you describe the premise and a bit more detail as to why this
> is important?

Inspecting the proxy chain is not strictly required. A BPF scheduler can just
accept a blocked donor, enqueue it on its current CPU and let the core
proxy-exec path resolve and "virtually" migrate it as needed to the owner's CPU.

The motivation for providing a scx_bpf_task_proxy_cpu() kfunc is purely for
optimization reasons. By knowing the owner's CPU, a scheduler could make more
informed admission decisions. For example, it can inspect the task currently
running on the target CPU, determine whether the donor should take precedence
over the running task and kick that CPU to trigger a preemption. Without this
information, the scheduler can only enqueue the donor and wait until the task
running on the owner's CPU releases it (potentially adding up to one time slice
of latency).

That said, I don't see a correctness dependency on exposing this information.
If the latency-policy use case is not strong enough to justify the API, I'm
happy to drop the query kfuncs and this preparatory lock-scope change for now,
the blocked-donor admission support can stand on its own.

Thanks,
-Andrea
