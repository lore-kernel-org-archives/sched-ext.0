Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60D2853FD
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783760859; cv=fail; b=DFMWMCJ+YnArLZ5nHrAXrix0a7laysjP7N+D8NIwXdqQPq83PAvDUvLxI1tqGDuE2Z/izpyAdCoLrDtAdMUL8l4lfjjR/soGOei7OId0KK3BQP76PsS23VznxowGN2dxzwg4FpG7cXemtfMGFD3Q3xyw/qdPLNI3i5hhtI3WZxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783760859; c=relaxed/simple;
	bh=D3XbAsSMLvenUCQiVXgwSTP2R8XwPzK69pdipY1jz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0Q6VQMpKhS2B1WloVURwMIU72ZjIcKk6VfZOnY9SW+NTPJDAInZxELx7y7AzvmWBuu8KfOh0jJLz8eOweayKSk/EqbMfgGO8XoW0RZ0H/An+S7ojeSrzbqfESAv1KkxGz3qo23qUNZ+65GJETFH+jaaAdF4blF4zXMHK/3hhqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mg31CDnj; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mg31CDnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYlmS0aF3JSlXy8VIabOuSiF3KLrCb9cooBlgoicQoYfN29pGrkhUEwPpbTr0DnjPzH4fCJw6cHp4c4fGsCY5m2WESRVHdTOD9xYbWJLt9b+T7FTcn8RJAp+aWysBxbjyM74KcfLtLaxhFR8C1ePDdAVtFWXo/1BWC1UgD2HGNuSH0yrxncm90SEtS9N4Q636auCdQ4uhO10OtxCrHKNxGQQr58N/xhsH+j9mqX106ajzkxi+67D3vopPc4UfPXH+ZrvdA8iQwi25u9WgDhCO0GEjJ2TN3WPEbBYXnpNO2KLYpvN9jj25OhhdWBqlLrKbiDk9M/D57Dvlr/+niAlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNP00ryo9fGhxRwkzgwmTYvRv4eEYp0JzJcVXZaGQIg=;
 b=yxGVO/zFxxiKO96BIaVaoCSwMxjXAIHxEUWIgAr6zXGgTFOTA6CqwdiZ/zRLf+lV3tmgwIIR6DAzjZT7XTIIfqPe94/msxksQca7ox8lHCZ4JBVQa1ANlt8DPxqeF74agwc3OPUZUo5gRUK5whQhuBig/xYX+u/Mz0LoSDxDnEsydHPkRlfGj7FnHBZFDRThWZQls8fv/A50LyllcQyMNP3d5FiTGLXb3OxK+wPVke9XJCL98BLqD2Mh+iAwvSTnSkl9Qkbk36ankzwQsMgbOFxW/1Yt4NVe+4svNC+nS2Du7L9/a10+6M8AgAy6zzp+0mltnbN7D1xOforGDD5l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNP00ryo9fGhxRwkzgwmTYvRv4eEYp0JzJcVXZaGQIg=;
 b=mg31CDnj0X12nrapvzcWsHNKv6rF1QkgnpZ1v2M8XA9wA9oUtuvL2ehfaw760F5NfTIxO29+U5M1HHGy+i4NWbYgA+F1zTznR7b9ne4AIdfZ4BbGH6uvQSsTHBf9t3oUws1rtv+kYL99cYhg+k1/LnJxXgF7aKs/jc51IGkdbprrC7CflwuU6Ju41gcjD7P64CsaGpAOxM4Mc2iLR3pvanL2VbfBbJlzqgiMioBUNyekeF2yraMQlrkMiz8SOLCGhUwUdDNBdGyKl/2eTJLX47UpE4x4DeEtsrcIqENqQB3BrrheHMajELOezP+WKr5yaO4XmLYLB/FnNzGotT9fFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Sat, 11 Jul
 2026 09:07:32 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 09:07:32 +0000
Date: Sat, 11 Jul 2026 11:07:24 +0200
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
Subject: Re: [PATCH 07/10] sched_ext: Add proxy destination query kfuncs
Message-ID: <alIHzKRxL2DSwmnB@gpd4>
References: <20260710083913.30573-1-arighi@nvidia.com>
 <20260710083913.30573-8-arighi@nvidia.com>
 <CANDhNCoiA5fqRYSM-Tj3cyJn0tViAgCgbvqK8t=zF-eoTQPTwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoiA5fqRYSM-Tj3cyJn0tViAgCgbvqK8t=zF-eoTQPTwA@mail.gmail.com>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 661330de-e87f-48e9-cae2-08dedf2bd73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2NRD487j1INBJFIb9Tfrvj8v/GP97g4Htf8IB6sNaL2wIHi5IiLST6dPa/eM+a6sdghRZdRGTfizUYqV+LwtTiWYsNFXUEqbOaGPQBKPEOOBbdE0OfVRg8Jv5SCoJzhH+ovWbjYOEvdJPNJAS2szNMf0e9pG+4JI+K4iccFiPsTELTe0MfyZJefwyAsSZcH7y669rIpHB9DFT+ryKQY2hrbmNjmYPtGLpyJYgnO5k+KEbhjtkKRYqxqoneclxSa99eNZXYIDJQVC0FOAGc7XXwoO4dtSghm/HkNKgrSFoPabarvw2wT8K58cOk3lxr0GfS07mGpr7EKbwKESDB5GySJG+IUqTXvqyS9I+1NiAWcyrr6A9m3kqNQe8b3e0+eCSFGpbnrkiB5yaGcX1sbA7z7FjkFBnjCZpc/dW7z3TLNfyivExhclecrtVKl41hM6N7Hrg3wn1gqfDjpuq3Vz0KUVELhvWho0+B9HZLnmpt19V4/4Ni++hxwI0d3HAFLEbb6nvDRjwtYdk7jxDUZmtt+idBEFwyHjSji5sOBl1Cfd9JkQQNuKfpoduPUOyAR1tGmtupZX8beNf0X9w6l7fbgLaImx1CR8vNRU3O13xBQ0SWGF/zzv1JTKQWv5SDxDnBMH5/QQXa7tFu/CcL9Bldyv3Hl+QF1ZDIaM9MLJBrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVPNkZtYjd0Wll3R0xmN2NFdVBuTWJXSUFnd3EvZlpKZVg2TldQWGNiWDVZ?=
 =?utf-8?B?WkZoazg3dllNZUZLa01lTlVZQVo4UER6aVVCbFFUaUNXVDBYdlRnN3JCVHBy?=
 =?utf-8?B?SThLOElkM3h3MmtZZ0NZVEVkYUpPbWJCeklrQWwyRm5XQXF1NmowdjNkL3pr?=
 =?utf-8?B?K3NPbjRIS1ZJLy9seXZCT203b3hVa1hXeTgxQXcvOU9WWlhhblRvM0VFL3gv?=
 =?utf-8?B?QnZSQnZJVk5acE05UGZOMktzNmVJZHZocDdPYU9BejNtbi85SFNlem9BMm9n?=
 =?utf-8?B?UTdPY3VTMHh4QmcrUW1nYU1lcXR4SzllcEJsc205YW1nWFgzb1JIRHZ3TFh0?=
 =?utf-8?B?KzRkOXppVDltWjhhR2tjakJTK2JtQUtENENJalB2YnNXMWtzckVlU056K0Nu?=
 =?utf-8?B?QWNPb011dXlqR0EzRUdlYUJSNE5jOTQ5WUErUG1nd0NneXA2TUpZenRnKzh4?=
 =?utf-8?B?M0ZNT0piVEdaOEtDcTJGY0U0aWVDdWFaaGZPSDU5WGEweXJhbmJGVUJPaita?=
 =?utf-8?B?SVUwTW4yL3V3NThaTkx6L1pJUlVFNVVoYkx1K21pRjFVYmdrRXVYMWFDRGxR?=
 =?utf-8?B?Ly9tb1lYRUFxZXpKS3BEOVhEdVRKTFkycEQ2OTZ0MllYbU9SNzJ0V2lDMTZs?=
 =?utf-8?B?MFJMdGlwcmRCYm95UVg1TFl0K3pISDJpVHJjeVc0a3pjZld4alBMWlUzZGNr?=
 =?utf-8?B?WnFpTDNPYllHaWg5OEsrWVdtQ3R0RFNoQnNaM3RMRVlJUk1MWFVra0ZUY08r?=
 =?utf-8?B?K0RzSWw4VUdCSmhib3Bqd0RkeTZKNm1EcC92L09wcDdwWEY2Y3dvemhwMVMx?=
 =?utf-8?B?aVZaR3Btd3NpOEdnblluMDlNVU85OVN4cFZYbyt0dW5VT3VFVEFCRDF5cjB1?=
 =?utf-8?B?SGJZNncwdzVEV21iUzNSQ2tBNnpCeFk5bFg0UTBSb0RLQ3NZT0E0MUJCcEk5?=
 =?utf-8?B?WDh1UWpiaVdNekFFWXh0WFRzZDZmRGQ2OHVVRlNQbVZjUG5KNnhTNDE5amdK?=
 =?utf-8?B?K3FBMjhOQThDRXJWaVRUQXVvWEVVNSs3TWF2ZnFyTDRlRVJ1TE9ZbWlsTGlT?=
 =?utf-8?B?N1Q1Snc4MEdOTHMxeDQxeDhRNVRiOEk0NURubFFSNTQwOGFiMVdFam5ZK0ZR?=
 =?utf-8?B?VGJSU1RHV0NRWEFOVjM2WVdnamZhMis4d052eVNGell2ME9LcVhVdGhNWnpq?=
 =?utf-8?B?OVA2ampsVVgveU56RHNkdk1TQmw4TnhlQVNkL2tiOCtHQVdEQjhLTENGZVNm?=
 =?utf-8?B?N1J3MVRiZ3FLZlQvRHhyNzEwZUQrODlWekpLY1pDT0QralVjcjVyd2dyMzZN?=
 =?utf-8?B?UTBoNDdRanVQZFo4SFRMTE1mOWV5eWZmcUJhK0lCS0kzUXlhbXo4RDFQay9p?=
 =?utf-8?B?bytzZUNJaWJ3c3lmU053NmtBQklEdEMyZTJNcnRldmphMmxUK2NrZGZuRFpO?=
 =?utf-8?B?MlVGVDdZU2VQZFd0KzFhK2hoRkJ6NnZHV2d6SnYxS3k1SlBXTGF5cVpRNU5N?=
 =?utf-8?B?SEVYWEdXSSs1bU1DR1phK1YvVmJ3NTU1NThXM1lucU1aQjJtSCtkZi8yU2lx?=
 =?utf-8?B?ZWNHNjBnbFhnbCtOU3NReElBRm9jNDdRZTA3VkVmOWZlR2hVL1cvdFZSdmto?=
 =?utf-8?B?RFhhSllpa0VoRXhUaXpHNU91Q29xNGh1N2dycUZWYnMrNTlVMjRaWXlvaUpX?=
 =?utf-8?B?QWN4VlcwdjJybEdadGhiZEx1YUNrRTJaNi9mNTNvMmJWMmlXbm13YzFpOXZT?=
 =?utf-8?B?UkNWMkdqVTJZNTFhdnZaNGF3Uk1aUENMcWhwaWZPcktGM1NuVHB4M3ZmekZv?=
 =?utf-8?B?S1QwZm1KNEM5bUtNUEdVZm5DenlHdDFRM1hyeElqc2RlbENKcmV6Z20wR2hR?=
 =?utf-8?B?YzVOV1dNbVFpUUJ2VGFMcWI2eHlYb2UxMEZCUUFKclJWSFRkNEVQOFpwV1Aw?=
 =?utf-8?B?RzhKLzBMeXdUZUl5SzEyN0xoV0tDZUYrSHhOMlJ1dTh2VnkyQ3V4U0lwOUla?=
 =?utf-8?B?OUlCTHFIODRqVHNDdmU5S0VKVi9MRGUzSVhLVUJ0Sis5ZHdUT0pMM3NuRUFl?=
 =?utf-8?B?NkFpYXhPZzNxN1paMVNwa1NSd3N0cEptdXFzSno2aHZQeVl4NEVMV3FWOXpx?=
 =?utf-8?B?RzFwY3I5OTFyWVBKOU5FN3M1VFloTmRMcWtVSnM1dUhwbUthSENlVVVGVGU5?=
 =?utf-8?B?cnBHc0hsRnZWNG9SSkxEb0Q5ZzBrMGxCLzBqb2oxNnVZcFlDM1dPMW9Wck1q?=
 =?utf-8?B?bUlaeFJEbVloWkNrZGJKRVMvNlQwT3dMcWhFM2ZCbVVWSlIyRDRyWStyNVZa?=
 =?utf-8?B?U2puUkFTWGRCZFhEalVETmx0OWhodW8vTHNBemtXdzdqNzRoOWFsdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661330de-e87f-48e9-cae2-08dedf2bd73b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 09:07:32.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU/YMOONKFajcz7DDxWho5foekKARBsWxfD4jtZss47pB6NsrxZNFPysambPFNZxpsnl6SRbPNWHa9bNsFdZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

On Fri, Jul 10, 2026 at 02:54:39PM -0700, John Stultz wrote:
> On Fri, Jul 10, 2026 at 1:40 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > BPF schedulers admitting blocked proxy donors may want to know the CPU
> > or cid where the mutex owner will execute.
> >
> 
> As I mentioned before, this probably needs some more context as to why
> this is useful/important to the bpf scheduler.
> 
> 
> > Introduce scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() to
> > return the CPU or cid of the next mutex owner in the proxy chain.
> >
> > The owner relationship may change immediately after the query, so expose
> > the result only as a scheduling hint. Return a negative errno when no
> > valid proxy destination or cid mapping is available.
> >
> > Provide compatibility wrappers that return -EOPNOTSUPP when the kfuncs
> > are unavailable.
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c                      | 28 ++++++++++++++++
> >  kernel/sched/ext/ext.c                   | 42 ++++++++++++++++++++++++
> >  kernel/sched/ext/internal.h              |  6 ++--
> >  kernel/sched/sched.h                     |  2 ++
> >  tools/sched_ext/include/scx/common.bpf.h |  2 ++
> >  tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++++
> >  6 files changed, 96 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3d72f64ffe627..39e2689ea6c3b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7046,6 +7046,34 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> >         return NULL;
> >  }
> >
> > +int task_proxy_cpu(struct task_struct *p)
> > +{
> > +       struct task_struct *owner;
> > +       struct mutex *mutex;
> > +
> > +       if (!sched_proxy_exec() || !READ_ONCE(p->is_blocked))
> > +               return -ENOENT;
> > +
> > +       guard(raw_spinlock_irqsave)(&p->blocked_lock);
> > +
> > +       mutex = __get_task_blocked_on(p);
> > +       if (!mutex)
> > +               return -ENOENT;
> > +
> > +       /*
> > +        * @blocked_lock stabilizes @blocked_on and thus the mutex lifetime.
> > +        * The owner is an atomic snapshot used only as a scheduling hint and
> > +        * may change as soon as this function returns, so wait_lock is not
> > +        * needed here.
> > +        */
> > +       owner = __mutex_owner(mutex);
> > +       if (!owner)
> > +               return -ENOENT;
> > +       if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
> > +               return -ENOENT;
> > +
> > +       return task_cpu(owner);
> > +}
> 
> So, I'm somewhat skeptical of this. You do disclaim in the commit log
> above that this is only a hint and it might change, but I fret it
> might be to a point it's not worth much as a hint.
> 
> First: you're only looking at the immediate mutex owner, not the
> actual runnable owner of the full chain.  So current could be on cpu1,
> the next owner on cpu2, but that task also just blocked on a mutex
> owned on cpu3. And the task on cpu2 may be about to migrate to cpu3
> (where current should ideally also proxy migrate to).  So I'm not sure
> what such an ephemeral value might be worth. Again, maybe the
> optimization you have in mind is worth it, but it probably just needs
> some additional explanation in the commit message.
> 
> Second: The blocked_lock does stabilize the mutex lifetime, but not
> the owner's. Once you've read the __mutex_owner(), without holding the
> mutex wait_lock, the mutex owner can be releasing the lock and then
> immediately exit, causing the owner dereferences that follow here to
> cause a UAF.

Yep, as mentioned in the previous email, let's get rid of this kfuncs completely
for now. In this way we can get rid of unnecessary complexity, fix these issues,
make the patch more self-consitent in sched_ext, it's a win-win. :)

Thanks,
-Andrea
