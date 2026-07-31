Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608883431E6
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486361; cv=fail; b=dMKkle3b3jiX7TziFG/SLAXV1kuR02895PyoNAUmTv7diOJZsFL/R8aFFB8tWZQ2viLLDMvyG7R/RDrSO2YWiavL5lKdOYXFF+s2LTpuCPIq9HRR2vKs9948oQu09LMJkXeHeFG9fbquVZfxLH86RKc243NEET3n6bIAmIRsnYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486361; c=relaxed/simple;
	bh=l1KbihhgPe2hLsfzByDiGezZvgy3dTD7/DNxQaafnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FJhB7CqFvFji1wfh1b6vYnQqcxHaPF0W34KA0IzqKboWnkxGngBnSZvILRJfvekPPahGF2jTJCkuSXM7UfGMIp/Cdq9nfge7tp6o6rnmBiVDudZPMH/dUISdf7ZtOkIuqbKGuqzFnOdFpeayIuLKVgYtqmQTei1nWLAhvk6Zoq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKZVYbK0; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKZVYbK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s616dxt095JV1F0qzVe2gUwS4ZGA3KkfQE9rhmn1ogw73/aBH5kscIZmhSKyTHJvRqrvgOvQ9dmL7TkxQyiLBtfZTkelZIoGbRqPtVCGcFbWg76KpbaaXT9SLruA7Hcy4D2r7Pos1dUPGkX5dWrESjoMDJwpsSaFa+pmN7Vi+PT9gDn87DQ0i0hd0DFb3wAQqSitNF3p6KjoVdsTGjRqg4S7kWngzQnyJcJqOV9Qnw7jzHGKk/7zdD1SAG81YYHrbTc1rqviI8P8ZC36Ju0JZmE8Igg7jqRobMEj6k1Qb+/Scbiq50AMRsHDBIe4k5lLyltZIEjSyRnIJb1MBdCeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FEf9jTNT76qSo5Oqg7CeUhO2A8Jdx/earQDhVlR9Uc=;
 b=R/QI8pgiupXoypJnyEX1drUkQYSA/R/UrJ3r7TnEmQDFUHuNF/Pq4XHEaqgsVw4cY/NYRJfQAlW9F/DyLwrcRts7t4BMzirVAjp2kB0KpFBHMn8T+rpCeybNYPEyb5U/trfpxZFkFzGWCT4EmTF0/qv4VjIGg4N2/gYJmUkLM4gvBMT7E62GYLRiXhMF5g5Uqg2hsAm1dz/aEHLVEWYR2X2/GfpCP70niKssr+sndEJ3JjUsXhUGslvnYVKk0A+yWG8+4OxGMTGrcLlNDCl4FnNcet5vtQL2IlCpNkSpyd3tinZ+z9KHCldln5AxKCg2+I7ItmicTptEJSjXl7Gq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FEf9jTNT76qSo5Oqg7CeUhO2A8Jdx/earQDhVlR9Uc=;
 b=bKZVYbK04RDtjlf1tH3OIaBU48RaBkFV3Cp5I/MD41FwXvIaARV/kSn4LVzDa7jSUsJL9AmibkvaF1ZcyKu/L6+n97FEPu4EQyI63/yHcHZOGN6TdI7YzJ8Kqt2IOx0nAVnlTK/2YsyeMBY1zX4tWOa6LVT0rR9DAu2nJa0uwJznmqedNEwvLqsaOkEyqjUXPNF9Hj/HVNcvqAwxOuVHhJRql81yC/JyPODEP5kl0v+86CIpqr2A3FAgEcVLqQQzHCBZAXH/tZWD5YVf/htezkTHJVoFsJqRYgjpS+WmBmXoW0iXJIEIKL4mSc8e3TV1MF4rPrAxtuDUuVoy5iTrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:25:51 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:25:50 +0000
Date: Fri, 31 Jul 2026 10:25:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Make
 allowed_cpus idle validation race-free
Message-ID: <amxcBhkt-3i-tFYA@gpd4>
References: <20260726064754.378671-1-arighi@nvidia.com>
 <DKC06NICM5DQ.9OON50GZUAN3@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKC06NICM5DQ.9OON50GZUAN3@google.com>
X-ClientProxiedBy: MI2PEPF00000B83.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::419) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1022d89e-ed1a-4395-0bbd-08deeedd548c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AJl0rjys3w3olWRmIU5XbGkYnwlqziXfeczRn41X7Of3YSvCF5hvNEmAycysiseiwWuqe5KHwCWE5xwfIZ19GbdXeBtCz30eukhYghB/plJvLsBT9ME1uXWCtWd6qoD6+/wQ3YspMrhhU7TzbJ3A30pV1ZHnGMD7cAVYfp1DbOOxzhvXDrqtz6cQE2pbP1M+QPvL3vEuwEP6+nrJ4TAKOMjihRoWquqjVjIYYi24Armg7BuXIfWouS8LuDk/t08Jx/0kPfuDcLOPe2OlOwkyDK10DoN5hlOV4/QdBqZ1cicOPAeCom7fwxTFV8J1RoAm8XVzFeb3x1GoaozM9QpM762jQCTB06veGUFxC7G4jx7xUX/P4fYCP7ALFUBedeNiQV5mx2/yljnKP4k0X4WTfa6RgLboOhMDqCOJ0BmSS1Fad3/ym184/yd0DGCpM9ZAPeh9UBShrH+RWyZflB0YhvEeYbaG4akRJxt/tiIk/uP7q6hSF55nqjMo3nntUBRtQATDbYP8voy1isA+dr7H7wYw/hfndpZOwLxjfrMBL9fdhWdnV5LcT0VYpEpXGWSCL+LriRpvAvqGV7v5ZmTbUOY2vmrmADpHxvAkXbN+IJRCYHBooZou0x8QoXXXULgFGGBGzyE2xDQWfQi90XjsszX8CANgf34smvUozyXLzWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXM9xFRpjzX5x9LXrGSVt0kIvUynTx5sKg0W6714NN56z87qe7td1qW2TqfJ?=
 =?us-ascii?Q?5/qJz+jLoFkkocnV/bfDWEOg+x9aI/xiIZZ1wH4/Sxxe83Xuh62YInnBZB0K?=
 =?us-ascii?Q?1PIVKmuEoa7U2gcMIaG31wjhMyn/di/NVewRBmYhYiJam/9ws667d/+HNUmt?=
 =?us-ascii?Q?oKl6a24dengrxuqeT14kc6om27+BbffZGfKbxFdFxjjoDfQqFq4HdcouhB8h?=
 =?us-ascii?Q?Mzo1c4wvE6wfJoeK9N+IorNq7u+UWKT5YQn4eWXA7GO0D8oHI1g20Qu1DUEg?=
 =?us-ascii?Q?sD7p9d2hOXMlEX3NH5FPwtLbg/6Zq5iLPbY488Ne0atdsdsGE4RwpMsY2Jf8?=
 =?us-ascii?Q?5OwzqLFiZ1fKFs/acIoJjlRcCLUki96Cxsis86bhJgIjYIuqo7OVEEaDP42y?=
 =?us-ascii?Q?3AwsRtEZjIY6DM6a1rgckVosMA/NLxKtTkT09nOS+Lwna7w227+XDSeo2MOV?=
 =?us-ascii?Q?WM7sexI/VUaMdVynHdED9s8LtnFkjIL3alDlNGTXeFG+5a4zuzR7eODUKJIv?=
 =?us-ascii?Q?+3PySSR+IytdqvZYLODeBLA2HYKEAZKmoxhTZyczbffgc1w2ULxW5et7J9fm?=
 =?us-ascii?Q?sNUkdrECC7udDhShy+pB8GIjyPrdRs1NGFhpA0q1DJmlY5JW8TLoFi1o3eFr?=
 =?us-ascii?Q?uieOdT5DPjnB7fqk/5a/BOMW8xXSKbXlrgpo0VuEcn/mTEMQDAz/P70lnqU0?=
 =?us-ascii?Q?4i0uPkBNaj80cGXxNAJuuewMn8ZCvXXcFN2oy0l/64oqTRU8BrPGqTi/oBFD?=
 =?us-ascii?Q?XJEFKn/aTeqshvDTmzkYYyNTwMsprDl6qWT8iy1Oy9Efkq2Dqhj9YbvKx9Hp?=
 =?us-ascii?Q?EDKZ0HNTDqb4m1lEdUs99zP0hc1691t8LchaI2WunBZwLr2i9SPb0ZWc/Ynr?=
 =?us-ascii?Q?Min2nnRzBIe5ql5mSHakZvD2aQDlY3v7cv6AqA38gQVTq1r6C7SxPmJtdw2+?=
 =?us-ascii?Q?lbsJdk+uBQi7i7NA0Oc24ySHHMsTAkeMpo5Y1yLtoqXNeviCsaGXrYma9FNa?=
 =?us-ascii?Q?hheSui7qxo16bOseNzv3dYl8OnYbhTn7ShaT7UBqdWRlDJ21+P4GytvcOvAf?=
 =?us-ascii?Q?6HMRwWC15EEGNWM1I4+x/U6BieKsswSKwfi0xaWqPkSpIWuBUFrKkF8nsEoK?=
 =?us-ascii?Q?z1s6eOnhr1cxr6eV6liVVs1HElGzVQrU8tcwziLABuLCxQ2uvbS7XUZqY5TM?=
 =?us-ascii?Q?21uWsGN9eTX0FOZlbBVJMVPR+xZkLVF6HpcUUq2s/vOLYPsuZhzrsgCVvS+C?=
 =?us-ascii?Q?3GKJ50t9tjpwTuNBc5mvGGNqn/UIqlasvV4eOUa7GkfWQU+a4P12eGfg7sYr?=
 =?us-ascii?Q?E7fu/KCHT0Bkgi+ab5F4Xw7EGKDYmLp+5D90YBOAnlTwCsoCOh50w6XNYZnK?=
 =?us-ascii?Q?HXWIzInIGu3C9Oh2KRVuwFH563TSAvt//EH0pXKLlgMikjAjZ4FMcUwggiJi?=
 =?us-ascii?Q?MkoNmfVpjRNudFyhm0DlSzyO6TRFIOegFFz6SsQWk8+zN4398tKtDDkpZ9R1?=
 =?us-ascii?Q?YThELm0pnoM5IlfBLU8/rl7/aARiM4WdhXTf1aCNhg89PxubbYStfOM/asZg?=
 =?us-ascii?Q?1LjeOKH5ZWWr7KEZpz6e7AcLF8CJyg3XV8T2NtnnPjWxHZCaN2nTyvf3sHRs?=
 =?us-ascii?Q?9ZVv8s4qP7sTjYdXAaE+FMqV+s5sD4oST76r1AypSJJ5ct9+3e+9/77FwmS6?=
 =?us-ascii?Q?qe2oKP6WPZ10OCNnpcHsf3uKeM2Vw0PTYk2qPsz6VM+yHeR0q3+JG8rRrAX4?=
 =?us-ascii?Q?EE2kiIkQ2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1022d89e-ed1a-4395-0bbd-08deeedd548c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:25:50.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SITqAXlAX3Al0unRaeVxPt7pYsAMPE7+BIAYh2sscq5u7VawwU01jjONmLxFhGd1/LPNjJdWjWXnzteCeTlgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

Hi Kuba,

On Thu, Jul 30, 2026 at 03:19:08PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Sun Jul 26, 2026 at 6:47 AM UTC, Andrea Righi wrote:
> > A remotely selected CPU can be re-advertised as idle by an idle-to-idle
> > re-pick before the BPF program validates the selection. Checking that
> > the selected CPU remains absent from the idle mask is therefore
> > inherently racy.
> >
> > Validate the stable local invariant instead: a CPU running a non-idle
> > scheduling context in ops.select_cpu() must not be advertised as idle.
> > Also validate both the requested domain and task affinity for selected
> > CPUs.
> >
> > Moreover, bootstrap the test by running a task on every active CPU while
> > ops.running() refreshes the initial idle state. This ensures that the
> > idle masks are properly initialized before strict validation begins.
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  .../selftests/sched_ext/allowed_cpus.bpf.c    | 51 ++++++++++++++++---
> >  .../selftests/sched_ext/allowed_cpus.c        | 38 ++++++++++++++
> >  2 files changed, 82 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > index 35923e74a2ec3..4a14b05065453 100644
> > --- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > +++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > @@ -13,17 +13,46 @@ char _license[] SEC("license") = "GPL";
> >  UEI_DEFINE(uei);
> >  
> >  private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
> > +volatile bool refresh_idle_masks;
> >  
> >  static void
> > -validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
> > +validate_local_idle_state(void)
> >  {
> > -	if (scx_bpf_test_and_clear_cpu_idle(cpu))
> > -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> > +	struct task_struct *curr;
> > +	s32 cpu = bpf_get_smp_processor_id();
> > +	bool curr_is_idle;
> >  
> > -	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
> > -	    !bpf_cpumask_test_cpu(cpu, allowed))
> > +	bpf_rcu_read_lock();
> > +	curr = scx_bpf_cpu_curr(cpu);
> > +	curr_is_idle = curr && (curr->flags & PF_IDLE);
> > +	bpf_rcu_read_unlock();
> > +
> > +	/*
> > +	 * Unlike a remote selected CPU, the local CPU cannot go through an
> > +	 * idle re-pick while this callback is running. If it is running a
> > +	 * non-idle scheduling context, it must not be advertised as idle.
> > +	 */
> > +	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu) && !refresh_idle_masks)
> 
> I don't think it matters much in terms of correctness, but to me it would
> be more intuitive to read refresh_idle_masks first to ensure we're bootstrapped,
> and then check the idle bit.

Ack. And since I read your other comments below, we can remove this condition
entirely if we move the idle-mask initialization before ops.init() in the SCX
core.

> 
> > +		scx_bpf_error("running CPU %d should be marked as busy", cpu);
> > +}
> > +
> > +static void
> > +validate_selected_cpu(const struct task_struct *p, s32 cpu)
> > +{
> > +	const struct cpumask *allowed = cast_mask(allowed_cpumask);
> > +
> > +	if (!allowed) {
> > +		scx_bpf_error("allowed domain not initialized");
> > +		return;
> > +	}
> > +
> > +	if (!bpf_cpumask_test_cpu(cpu, allowed))
> >  		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
> >  			      cpu, p->pid, p->comm);
> > +
> > +	if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
> > +		scx_bpf_error("CPU %d not in the affinity mask for %d (%s)",
> > +			      cpu, p->pid, p->comm);
> >  }
> >  
> >  s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
> > @@ -42,8 +71,9 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
> >  	 * Select an idle CPU strictly within the allowed domain.
> >  	 */
> >  	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
> > +	validate_local_idle_state();
> >  	if (cpu >= 0) {
> > -		validate_idle_cpu(p, allowed, cpu);
> > +		validate_selected_cpu(p, cpu);
> >  		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> >  
> >  		return cpu;
> > @@ -71,11 +101,17 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
> >  	 */
> >  	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
> >  	if (cpu >= 0) {
> > -		validate_idle_cpu(p, allowed, cpu);
> > +		validate_selected_cpu(p, cpu);
> >  		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
> >  	}
> >  }
> >  
> > +void BPF_STRUCT_OPS(allowed_cpus_running, struct task_struct *p)
> > +{
> > +	if (refresh_idle_masks)
> > +		scx_bpf_test_and_clear_cpu_idle(bpf_get_smp_processor_id());
> 
> ops.running() doesn't have to run on the same CPU as @p, e.g. when changing
> the priority of a task running on a remote CPU. I believe the correct thing
> to do here is scx_bpf_test_and_clear_cpu_idle(scx_bpf_task_cpu(p)).

Ah yes, that's a mistake, we should definitely use scx_bpf_task_cpu(p).

> 
> > +}
> > +
> >  s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
> >  {
> >  	struct bpf_cpumask *mask;
> > @@ -138,6 +174,7 @@ SEC(".struct_ops.link")
> >  struct sched_ext_ops allowed_cpus_ops = {
> >  	.select_cpu		= (void *)allowed_cpus_select_cpu,
> >  	.enqueue		= (void *)allowed_cpus_enqueue,
> > +	.running		= (void *)allowed_cpus_running,
> >  	.init			= (void *)allowed_cpus_init,
> >  	.exit			= (void *)allowed_cpus_exit,
> >  	.name			= "allowed_cpus",
> > diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
> > index 093f285ab4bae..eb1708e55982b 100644
> > --- a/tools/testing/selftests/sched_ext/allowed_cpus.c
> > +++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
> >   */
> >  #include <bpf/bpf.h>
> > +#include <sched.h>
> >  #include <scx/common.h>
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> > @@ -47,14 +48,51 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Run this task once on every CPU while ops.running() repairs the bootstrap
> > + * idle state. Once a CPU has been refreshed, subsequent idle transitions keep
> > + * its state up to date.
> > + */
> > +static int refresh_idle_masks(void)
> > +{
> > +	cpu_set_t original, one;
> > +	int cpu, ret = 0;
> > +
> > +	if (sched_getaffinity(0, sizeof(original), &original))
> > +		return -errno;
> > +
> > +	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
> > +		if (!CPU_ISSET(cpu, &original))
> > +			continue;
> > +
> > +		CPU_ZERO(&one);
> > +		CPU_SET(cpu, &one);
> > +		if (sched_setaffinity(0, sizeof(one), &one)) {
> > +			ret = -errno;
> > +			break;
> > +		}
> > +
> > +		sched_yield();
> > +	}
> > +
> > +	if (sched_setaffinity(0, sizeof(original), &original) && !ret)
> > +		ret = -errno;
> > +
> > +	return ret;
> > +}
> > +
> 
> This bootstrapping mechanism feels like a bit of a hack.
> Couldn't we improve SCX itself to ensure the initial state of the idle masks
> is accurate?
> 
> I was thinking we could enhance scx_idle_enable() by making it enable idle
> tracking (currently idle tracking is controlled by the __scx_enabled static
> branch), and then iterating over all CPUs, locking their rq locks and setting
> their idle bit based on whether rq->curr == rq->idle. All this would happen
> before calling ops.init(), so the BPF scheduler will be guaranteed to have an
> accurate idle cpumask. WDYT?

Agreed, this is much cleaner. I'll send v2 as a two-patch series and move the
initialization into SCX.

> 
> >  static enum scx_test_status run(void *ctx)
> >  {
> >  	struct allowed_cpus *skel = ctx;
> >  	struct bpf_link *link;
> >  
> > +	skel->bss->refresh_idle_masks = true;
> >  	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
> >  	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> >  
> > +	SCX_FAIL_IF(refresh_idle_masks(), "Failed to refresh idle CPU state");
> > +	__atomic_store_n(&skel->bss->refresh_idle_masks, false, __ATOMIC_RELEASE);
> > +
> 
> Won't a WRITE_ONCE() suffice here? test_and_clear_bit() implies a full memory
> barrier, so I don't think we need any extra synchronization once the read of
> refresh_idle_masks is moved before scx_bpf_test_and_clear_cpu_idle() in
> validate_local_idle_state().

Yes, WRITE_ONCE() should be sufficient for the current workload.

> 
> >  	/* Pick an idle CPU from user-space */
> >  	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
> >  

Thanks!
-Andrea
