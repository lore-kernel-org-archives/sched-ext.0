Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6743CE6D
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511607; cv=fail; b=Lz9JHD1m93499+uYy0Bwq2ZCUoT64xBuyI5f+gTwSPF9tnZVmQPdg/U0Isjo2DQqmwCB0NeY8UOgBrRKhShgYWr4xBzZ+/dEi7wtqfhSLgpeOZd7Gdi46m5AfWlkL2Z414mAZj6ey0W9RAqVarW8E611y3fxGe+6ASpdQiXWbeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511607; c=relaxed/simple;
	bh=7PeKXBKlqsTcfJuNY7ehv2CsQbvunEtsTQtg6YGC+z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nu9YzbhTW0Ozrhba/sXmSpmC2xZrynupT424q0/zuZXXLdeBxWVla4390gAZa1PleJHvAOBc/bLBG0NnEcijSifWEGyc/XTf99Bc2lhAjoBNsS1Z72mLHRGWddphZ6eKFBMUDKrvIqZi5k1XxbyIaIRvn52B14iQ9znjYSTZ2kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PiJSfF4f; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PiJSfF4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQE/aE0YJ4ck7XDNyvzjkv2kPQfIlXuOUovOp3/3CgBaFJlPHMpx8m1O5vQDoyLJIJnxPlbqus7cTKRin5SIZBhojaDzlwYTu9DAEVjmD0JLfmyW6VmttANszLdUzqqr6krRhjzWHXDM78raHqpedXvbwRhQSNIsXOgw/zv/Y63aORfXfdT4t4MVzA3GuIq3aYh9iW0hxCAlWxdSfWATgavFyDIDx3XwEMiNWOSPsjz8lCQQDJ+k8501J4xxSWxPH5dvivX/9lLQ+WNDsP4zw3oovCMrOwb/DkHeXf7nx3JUL89FleUSwy9vmtXDR/lFo51SffllxhcYn7HGq9TT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70kFcWF69v8Eomddcc0d1dA4pvzrXnCpH9zCju5gjkA=;
 b=sZX31wzi6zAFn2aIDQwz5lQqBWCCHomkEKtSy0d/WfNv9UBw1V3OpUVJE+qf7DtNPQ8kPEAxLnFVLQ4BoGYH2DapDIoGtpGBgjxaSSJiqVMflev/noAUU9ed8zeSR4Y7JTVTiFOPorN+O9P0MS7IFg3mStbyIe/LIcO5+BAquqUHKP58NoJ51S1fkRbWYr2zq43VkfjyiJjrUd6pNuJskio5D5aVJ8BpivAz+YXtBbUh397YZGNc2qsIq4SMYGxPYydPdunDUYRL7t7s+4VMgi46ZKUIxLKoQe9hmqfzC1brz2lH8AV7I0Xdz0EAKOuig00PVfsCJgqt0O13oYKdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70kFcWF69v8Eomddcc0d1dA4pvzrXnCpH9zCju5gjkA=;
 b=PiJSfF4fjgdq2lqiNZUhS/Xeb2Lpl27Oju42sCuJeHtMK2esq9LMcAAXMVERbOeBJkeu9JbtA3j2Yv/ZEj1Q/C20PPgDNUwy6s43xvjDcVecSlI7BQGS7I/RH3fA4xdfTWiIBbx5sS3ZLwC3zuVWEs/KmJtTfUFlj8aJlApAVpyvHburz6xHE7W04DV2kUgui6Flcmlpu3iyKHE4dLDUKuJ7PQsxsRmzUkM+BiyefgFw+erb8KlE+PehZtiakPCuSSPwPvBqLb4pY/IxWIQ0HBo0K2nxGkGVyZZ1To9pkazZWTyWay8JdTtCP07O0YlrE/a6WhJcSevAIisaDSaaXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:26:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 15:26:37 +0000
Date: Fri, 31 Jul 2026 17:26:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle
 validation race-free
Message-ID: <amy-pKcguBtwJQZE@gpd4>
References: <20260731090334.2911948-1-arighi@nvidia.com>
 <20260731090334.2911948-3-arighi@nvidia.com>
 <DKCPMDMRE6FN.3EII6EE13O4SY@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKCPMDMRE6FN.3EII6EE13O4SY@google.com>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d4300b-ff31-4f6d-0764-08deef181c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PyUGe9etVCbwPCu6MZtbLSbsHAWZ9op/T4V5yOHC6txhI+KNtHgKvC9R90i2m16Izzj1fQ+cSVnpIK5dXaFa7BkirMF3PFaAXh5Xv4rMFgWlQPhQ4xbXGRmpcx/2txiiGSaT1g84ExXv5dKkVbfM011BarAaxlT/gUbJ5madiN2+zkfcVHwYcGrh0TKizJNRa6F6vP/Fpjj6OLpcVQC1m0mQLJmvW7CCWdzjhlOJgnmBwqc47vaGvkyX+dIr/eU0E8zYZTgSld3Rbc3sRVIz4jLohKpWclLX+op0C+bjuNX4JBduj1hVY7Z7q8wu8bMPlg0z+vrt3jW6R+KNulgeU7HCBV24BVl3X3MThI/rYDQyXU1eQS9afrD81y5wXbroYvWkpakOTNh02asZDZ6mbeJ9N65Qf+cU5mhoTA8bdq1jJtOYJw4blUp31DyLE4uYMXm3qlm9WQaxuJ0V1cX3aPXlPv5n3TBKccTe1XA7JkSArZMeFwPRDqAExl08cZY4E4AVUL5bPnNJ1enCMg1S3EZdEgaYuuvAcFKn7AJLgB9o1zleVEyR0nszpmkhYPwuLJ8U2jJFxeWowvKjPTWyaRxXNc0chUODSe0amq/fV7F0H3MTui6qZmGRzlizQddyKj8LcZGudcZcMUwaGKgQvQJ+sMg9rX5ayEamlEHhhXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qOAZdM6EXepOXvdRXKMQk+PMK4zKFqqUKDqnXwznKz2ARKX2CsfrqpVhCa1?=
 =?us-ascii?Q?qBWdQeXgY9MvKGMgKG3n8FRg/l6lMjCOFjl88ODnzWSosCT4XUaiMyOf/7Cu?=
 =?us-ascii?Q?Hv3fDDNmKL9zhPTn3v2M+FSqRCZjXIQOCIEDtCoiz6lQpFSiXawnAw3aBlGM?=
 =?us-ascii?Q?s8HkFxQS6n44B4/VGTuzP0f7SIEa6nAP1kZj+O/ua9IaWyLoIymvBXVyTeeh?=
 =?us-ascii?Q?wOmJ32ef1kw3mgr6BVJkKFIIHRHMoMDQLxALoTNGSfdkCsYytvPbXQFW3FWQ?=
 =?us-ascii?Q?NbXxtOv/9+CaJwBglc0kzFyS2jDejGJDkwgR4OMyJ91/+8pV/pD3H7VFdl5R?=
 =?us-ascii?Q?hHYdOTOSc0uGS3jxoY3wWneImUKQOFFc4OS60ymLwn6UYTDIu6A45+HCuvFz?=
 =?us-ascii?Q?1X4HC8dlgxmQfDrNWW+BRlnXvt6fe+h1CwzTjt8D8OHraIBqTw5jXLEG3r4c?=
 =?us-ascii?Q?mcguMNUlqHPevYpvXfSRmcmbu/J+W4nW+7Q2yIeYAwVxNGZYgzwCwqrrPxmL?=
 =?us-ascii?Q?5RDFsR/A1wYYC9PqeAcXtmZUKnNzYCXraJ7qqbTM8kJnyIhSOfUTSDeeUVIA?=
 =?us-ascii?Q?xZlFO0BS2Fws18vMmWFnHSPxy6Zo9Zm9E0iifG/fT05GITWpeaXgQyn4LAd8?=
 =?us-ascii?Q?gvtC2SakHZhTLcI3rYDv2ePUawngF/s80uAo3/eU1SXeuTCdz/oPXT/ThACR?=
 =?us-ascii?Q?LQ2w2NNt5PX1eLYFcX32FaFAdGs5Y9/7OFi9o01lCtP+JnQ2N/fPMd+YKsU9?=
 =?us-ascii?Q?lBGQTN2GjVrQ5qDQ3e/hgh1rQpQcWHRydq6ngNV63gXKRlRM4+x+2pwS/UlO?=
 =?us-ascii?Q?22wdZIzaR5gpkdNzAjFDoWi+Lg9/9bx3cdnSE5sQSjPfIGpqHNQhdF95FkeT?=
 =?us-ascii?Q?SBnfLq2qn0uztwiQur9CIx6ezKF0WfsSVMHb5/tHWpSgpskFLdRnQqGOgteC?=
 =?us-ascii?Q?i7wYG9xd/vomvoIPUUXeygGpoGtl4jSHvCYKeGwbGW0uHHQLFOAijcv3U6Co?=
 =?us-ascii?Q?0AA0me7EMw3QZ/zxUsXMVcmkhfadzc8m5udBl33/yv+3X3G6rTZEjWMF8Y7M?=
 =?us-ascii?Q?7psGWC4NDUkmf15YiD/mq3ewaIVXxBrVe6x6zD71HIqgxr5SXHf6GZ1EsYHc?=
 =?us-ascii?Q?XO32RVYvNil6AzxpuSpqRBZp8TJzrweHARncNInhJLYMmMX47awnO5K0dU2M?=
 =?us-ascii?Q?kl4BbyoU+RmkCxX0KaNzJ9xLP7ynO181ugEGuarp81zDXN+cF3N9V96f4aSZ?=
 =?us-ascii?Q?PFMhKCNRpWRbA3by3hvf2P5Lg8+9njUi6/enQie7q0m5wHLZbas0ygA4A4co?=
 =?us-ascii?Q?/OG4gqT38R1+PZmCwYHtszxRtsmNyQqV3FTyqNvUPusu5bkyZTCPFpd601hc?=
 =?us-ascii?Q?nMavTKE7Hw5kqSxl29CTMlulB0V+05Sz7QgHQuGU5hnsmF1SDhrksT2bT6cO?=
 =?us-ascii?Q?aOcUCXt6Drhg5uweiv4doBekqrmIfMu76P/I7V6bAyyKtFe/Gr5hK61RYMci?=
 =?us-ascii?Q?aBbdu+wsjiHdsLXwuR+mz9e28Nor3FpdVpQrOsjA0DCyaUl/z6giQfjcuGuy?=
 =?us-ascii?Q?wegDGdu+c25+7l7OMIZAURzqe+bRAIWvjvr8MF7k+MDoQB5IbZiCWetRVlGS?=
 =?us-ascii?Q?IDom6ew30lxhZ8eptUenpL/8KMVbv9cCl4PKTFvSyhUiIBSsr4PZfs8yNP1l?=
 =?us-ascii?Q?fKqwA+jBqdc0fcADEZks+6Lj7lc/JCs1TSzACKUShN56RL3cBg2XfiTsLcWh?=
 =?us-ascii?Q?NkZ76VoRUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d4300b-ff31-4f6d-0764-08deef181c0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:26:37.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQI8wvW/XCgBp3pwaNiRPKW7B1hAzpxgpQIY5m3GMre+pNS40g5habi/buNxQH+kkfI+iMreLrplDQQPFYxN3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

On Fri, Jul 31, 2026 at 11:12:09AM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Fri Jul 31, 2026 at 8:59 AM UTC, Andrea Righi wrote:
> > A remotely selected CPU can be re-advertised as idle by an idle-to-idle
> > re-pick before the BPF program validates the selection. Checking that
> > the selected CPU remains absent from the idle mask is therefore
> > inherently racy.
> >
> > Validate the stable local invariant instead: a CPU running a non-idle
> > scheduling context in ops.select_cpu() must not be advertised as idle.
> 
> That invariant sounds like it should hold in many contexts, not just in
> ops.select_cpu(). Is there something preventing us from checking it in
> ops.enqueue() as well?

Yes, nothing prevents checking the local invariant from ops.enqueue() as well.
The CPU running the callback shouldn't be advertised as idle. I'll add this in
v3.

> 
> > Also validate both the requested domain and task affinity for selected
> > CPUs.
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  .../selftests/sched_ext/allowed_cpus.bpf.c    | 43 ++++++++++++++++---
> >  1 file changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > index 35923e74a2ec3..411a7edcb9605 100644
> > --- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > +++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> > @@ -15,15 +15,43 @@ UEI_DEFINE(uei);
> >  private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
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
> > +	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu))
> > +		scx_bpf_error("running CPU %d should be marked as busy", cpu);
> 
> Could we check a stronger invariant by also checking that the bit in the idle
> mask is set if we're running an idle task? We can get the idle cpumask through
> scx_bpf_get_idle_cpumask() and check bits without clearing them using
> bpf_cpumask_test_cpu().

I don't think the other direction always holds: an idle CPU can be claimed by
another BPF idle CPU selection helper, which can clear the idle bit before the
CPU necessarily stops running the idle task. In that case, observing an idle
task with a clear idle bit is legitimate.

However, we can safely use scx_bpf_get_idle_cpumask() to perform the existing
check without modifying the mask.

Thanks,
-Andrea
