Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F7351C34
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139942; cv=fail; b=VRh8SfG0VxYILHpELeIN5ZttjPFYq9I2rrcTAQh/NrtJV4wVj6eGp2vPKLyzLWAjJgxihiXACsWSpf1jBPUk6puk1s3akDX6ivRFs/2JvGZQUn0KdrS7VXw74KeRpIQzw1RLG9LMJMHM9Dpe4rqK3Hai5ivsSnEvwQeRBiPzZfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139942; c=relaxed/simple;
	bh=Hw+rRiHqFQYSRx8DTOzbh1iYGNdKK+mRRdr+t15UAz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GY9mTWMa5izonMOrSqzNS31TR3G7PyaFg0OBh3wwTKqHmejAS5CGL6bW2ZdbAo4YHpjxK2v1ngniLkPF+BN9xtdbvfi8NK5gUNYlYsmJSwtysdZbcDsiYoKgRbRoXTMbq/KM0S91g9l9FxQT0aSw/1v8M/toSvzEWIPd9cmhnmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mwGykIIy; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mwGykIIy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nztzUSth9rKUvtbFH7sgt0atVe1iVMwnMWQq4fKiJS7m33VGVAOwHV66PJeZHAJgr3vb2xz5841lee/5pAo9LS+cZv4WYUHiviBqzl4fmt/48rR+CjDYOXAgc7IpAZro4CVRD0uJRDJbtIeI/l0LXAVOGIZfAD2r+vzZZqZduhIBFvyCc/H2nzEhuQLZu3Ro0J1HZ+3n97Es9S3bIqm/b7TCBbJN7homszfRDp96srTtVHqPfz8K1knLXo3Fp9vmrgx4bW/cRVdnFhfviw//zUZfYSGIPT5rAHR1J+yqhT4iFzgP1yjQeRC6XU7h6d29jbuqFPFVQffiRRdqAp2s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv36oDxD4JioCirhc7ufgO/bUptDNeXKxtlVH9wmd48=;
 b=qCjkfr4pHSS2O+lQyhK+2VFBzBdzWJIMqXB5IwNsVKCynlvQFw/R5zRIs32BFzgPuDBSKzt6tpIYeetOM9QVKjNsEaXJPXRase1ch6nTPjxb5LVPlTthHMtC0hL54SKoNVv6ocgJXKBheA9D2D4RGvpE3Yapw0GEBUdoI7rGMnd8mXzoEpLdXUbnKEaq7sXlGknO4xkFyFTteY5QFVa+ZRBIcIue+j/7VYUCJ8IC11XfYECz+n1mvyRZT3wlg+kOT2QQVnJUXhFKBn9cvf4NRLTq+9ja5F5ReglpL+WLTo9r80RQP2C8P5jkUwc+cwxAOJbbesCNdaHNmRUnKOM7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv36oDxD4JioCirhc7ufgO/bUptDNeXKxtlVH9wmd48=;
 b=mwGykIIy3hJwgtIyFyOVPhXSXaRyjyKXHLsaX/WqzvQuN7pz8JsjBsU6sYnhGjPfihiNTs7xC17zkbxiebiKEQz6dWKa/coevjVnR0y6B4QS55riVJ25id5JbDZNfqIsE/5jW1mfovytgaVHCTvBAR+JpfRB1bvf7dNLc2u5kHk=
Received: from BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26) by
 MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 07:45:35 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::48) by BYAPR01CA0049.outlook.office365.com
 (2603:10b6:a03:94::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 07:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Thu, 7 May 2026 07:45:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 02:45:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 00:45:32 -0700
Received: from [10.136.42.25] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 02:45:28 -0500
Message-ID: <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com>
Date: Thu, 7 May 2026 13:15:22 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy
 execution
To: Andrea Righi <arighi@nvidia.com>
CC: John Stultz <jstultz@google.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Christian Loehle
	<christian.loehle@arm.com>, Koba Ko <kobak@nvidia.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
 <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com> <afwxsJiNJcNQrcHN@gpd4>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <afwxsJiNJcNQrcHN@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d69a1c-b079-4a1f-890e-08deac0c9ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003|13003099007|7136999003;
X-Microsoft-Antispam-Message-Info:
	6Hoj5BVo1/is0LuIEhQZu7vYf/dVZSkTHvjcBi/NztzVTteRyLFvmi4k0LQcAU8y9D+aeSW/Sj8de22EfQ0x6UesCt3OBMZfnGlgo6a9wjj93AiEzdYPy3oV4Df2gKdazJn5YGAcl0c49uq4IfGrIU1bbZBMfQ/WMdU3IRfyRyHOXKRXmwOE9aaEPp+fJdvMicqlH3gxhroqFa+kvT5u+fOKlJQN2SEK0hFlKIQ73rQdFqVFXTrjs0e6A5Pj9oybWYO8NJF7hu4ZtJ3EAEijnDlW9JtCwBpqFaoZ4+TIB2JV9cmx6pMdBIrhgMvMNgY3oXVSJ9jEawlcwQ/w8UgxZjzj18jYxK5L5qjLUYcxCtt9NNudSEFLZpVyuoKw1rYXytCHtbO6hqWsHtyWfpdWdtYvnm/vfAC7V6uNod/71Bu9R/Ah0ekjlxR4bTHuIVRwuKH6MP/xz49f5c2v3nLixkSNb5JdelpNd7Rplj6Gj8I9Vce9ncJ7C4CU3AGDev9c18FBMFbMlqd0C78czTMxP89g7B0tTqajpFg7N5g7bVVq/7I+RRwHCO38pwXD/pxq73ZIMsWgeLTr893J9X4TY+Vcd8hq1d5M5qKP0hENeK+H1haM4TSKyYtApWEAsi/txlvVnr73yy1RysnlW/U8J9HaOvtrHBhEfmLDwynUvjMKtn8dXdLalrFX8FEn0Q4Y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(13003099007)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JyUSbmwlDjE/CLe0v05TzoYeSBqomBQF/m5J4ZxwjbcjPhyoAdvN20mfB+B+xjJkGLOmV8ZbjgQEXe2Ue6X7MdFJuvG00Xvg9d+SAi1i8NpVrVxxLX5uGtQg0HBGlT8B8LaLLTiEV9t934I0MCnwW8h1T/UhXGs1fXjZ1FDY9loofuIlZjop13CK3z38u6wtNGoWRSQ8ndQ9djYLLDuCgMucsLM7e0VKPGIdBcIwGK3j0AbUl/aMAOw0Jo/p6k5RlUaM2sABy6witq4K/kmsaVV17flUO57e/8+urEaOxcVfUhyp5APaCoeEgtZkJ7zTEThzEkZ238mta1vJ2qS4hMwRAXJ1eJQ30Rbbvi7mjneLeOjODI7Xs2WxFMhRAsPKk3fUr44HT8eiD7bgLzKVv/N5b8OPh+IFMCpMm+zMkzfb6zdOBEUo1+gkvEvj0XJg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:45:33.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d69a1c-b079-4a1f-890e-08deac0c9ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367



On 5/7/2026 12:01 PM, Andrea Righi wrote:
> Hi John, Prateek,
> 
> On Thu, May 07, 2026 at 09:04:57AM +0530, K Prateek Nayak wrote:
>> Hello John, Andrea,
>>
>> (Full disclaimer: I haven't looked at the entire series)
>>
>> On 5/7/2026 2:39 AM, John Stultz wrote:
>>>> +                       /*
>>>> +                        * Tasks pinned to a single CPU (per-CPU kthreads via
>>>> +                        * kthread_bind(), tasks under migrate_disable()) cannot
>>>> +                        * be moved to @owner_cpu. proxy_migrate_task() uses
>>>> +                        * __set_task_cpu() which would silently violate the
>>>> +                        * pinning and leave the task to run on a CPU outside
>>>> +                        * its cpus_ptr once it is unblocked. Stay on this CPU
>>>> +                        * via force_return; the owner running elsewhere will
>>>> +                        * wake @p back up when the mutex becomes available.
>>>> +                        */
>>>> +                       if (p->nr_cpus_allowed == 1 || is_migration_disabled(p))
>>>> +                               goto force_return;
>>>>                         goto migrate_task;
>>>
>>> Hey Andrea!
>>>   I'm excited to see this series! Thanks for your efforts here!
>>>
>>> Though I'm a bit confused on this patch.  I see the patch changes it
>>> so we don't proxy-migrate pinned/migration-disabled patches, but I'm
>>> not sure I understand why.
>>>
>>> We only proxy-migrate blocked_on tasks, which don't run on the cpu
>>> they are migrated to (they are only migrated to be used as a donor).
>>> That's why we have the proxy_force_return() function to return-migrate
>>> them back when they do become runnable.
>>
>> I agree this shouldn't be a problem from core perspective but there
>> are some interesting sched-ext interactions possible. More on that
>> below:
> 
> So, I included this patch, because in a previous version of this series it was
> preventing a "SCX_DSQ_LOCAL[_ON] cannot move migration disabled task" error.
> 
> However, I tried again this series without this and everything seems to work. I
> guess this was fixed by "sched/ext: Avoid migrating blocked tasks with proxy
> execution", that was not present in my previous early implementation. So, let's
> ignore this for now...
> 
>>
>>>
>>> Could you provide some more details about what motivated this change
>>> (ie: how you tripped a problem that it resolved?).
>>
>> I think ops.enqueue() always assumes that the task being enqueued is
>> runnable on the task_cpu() and when the the sched-ext layer tries to
>> dispatch this task to local DSQ, the ext core complains and marks
>> the sched-ext scheduler as buggy.
> 
> Correct that ops.enqueue() assumes that the task being enqueued is runnable on
> task_cpu(), but this should still be true even when the donor is migrated:
> proxy-exec should only migrate the donor to the owner's CPU when the placement
> is allowed.

Not really - it'll migrate the task to donor's CPU even if it is outside
the task's affinity with the reasoning that the donor will never run
there - it only exists on the runqueue to donate it's time to the lock
owner.

But if you mean runnable in the sense it hasn't blocked then yes it is
SCX_TASK_QUEUED + set_task_runnable().

> 
>>
>> With sched-ext, even the lock owner's CPU is slightly complicated
>> since the owner might be associated with a CPU but it is in fact on a
>> custom DSQ and after moving the donor to owner's CPU, we will need
>> sched-ext scheduler to guarantee that the owner runs there else
>> there is no point in doing a proxy.
> 
> But a donor is always a running task (by definition), so it can't be on a custom
> DSQ. Custom DSQs only hold tasks that are in the BPF scheduler's custody,
> waiting to be dispatched.

I was thinking more from a proxy migration standpoint - when the donor
is on a different CPU and the owner is on another one, and the core.c
bits move the donor to the owner's CPU.

> 
> The core keeps the donor logically runnable / on_rq and the ext core always
> parks blocked donors on the built-in local DSQ:
> 
> put_prev_task_scx():
> 	...
>         if (p->scx.flags & SCX_TASK_QUEUED) {
> 		set_task_runnable(rq, p);
> 
> 		if (task_is_blocked(p)) {
> 			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> 			goto switch_class;
> 		}
> 	...

Ah! This is what I was missing but then, this task gets picked and
is moved by find_proxy_task() in core.c right?

> 
>>
>> scx flow should look something like (please correct me if I'm
>> wrong):
>>
>>      CPU0: donor                    CPU1: owner
>>      ===========                    ===========
>>
>>   /* Donor is retained on rq*/
>>   put_prev_task_scx()
>>     ops.stopping()
>>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
>>   do_pick_task_scx()
>>     next = donor;
>>   find_proxy_task()
>>     proxy_migrate_task()
>>       ops.dequeue()
>>         ======================> /*

At this point I mean ^

>>                                  * Moves to owner CPU (May be outside of affinity list)
>>                                  * ops.enqueue() still happens on CPU0 but I've shown it
>>                                  * here to depict the context has moved to owner's CPU.
>>                                  */
>>                                 ops.enqueue()
>>                                   scx_bpf_dsq_insert()
>>                                     /*
>>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
>>                                      *
>>                                      * We need to allow local dispatch outside affinity iff:
>>                                      *
>>                                      *   p->is_blocked && cpu == task_cpu(p)
>>                                      *
>>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
>>                                      * is_blocked indicator should be stable during a dispatch.
>>                                      */
>>                                 ops.dispatch()
>>                                 do_pick_task_scx()
>>                                   set_next_task_scx()
>>                                     ops.running(donor)
>>                                 find_proxy_task()
>>                                   next = owner
>>                                 /*
>>                                  * !!! Owner stats running without any notification. !!!
>>                                  * 
>>                                  * If owner blocks, dequeue_task_scx() is executed first and
>>                                  * the sched-ext scheduler sees:
>>                                  *
>>                                  *   ops.stopping(owner)
>>                                  *
>>                                  * which leads to some asymmetry.
>>                                  *
>>                                  * XXX: Below is how I imagine the flow should continue.
>>                                  */
>>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
>>                                 /* Runs owner */
>>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
>>                                 ops.stopping(donor); /* Accounting symmetry for donor */
> 
> I think the order of operations should be the following:
> 
> ops.runnable(donor)
>    -> ops.enqueue(donor)
>    -> donor becomes curr
>    -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
>    -> donor executes
>    -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
>    -> __schedule()
>    -> pick_next -> proxy-exec selects owner as next
>    -> put_prev_task_scx(donor)
>         -> ops.stopping(donor)
>         -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
>    -> set_next_task_scx(owner)
>         -> ops.running(owner)

So ext will just switch the context back to owner? But how does this
happen with the changes in your series?

Based on my understanding, this happens:

    -> pick_next -> sced-ext returns donor as next
    /* prev's context is put back */
    -> set_next_task_scx(donor)
      -> ops.running(donor)

    /* In core.c */

    /* next = donor */
    if (next->blocked_on) /* true since we have blocked donor */
       next = find_proxy_task(); /* Returns owner */

    /* next = owner; */
    /* Starts running owner */

How does ext core swap back the owner context here? Am I missing
something? find_proxy_task() doesn't call put_prev_set_next_task() so
I'm at a loss how we get to set_next_task_scx(owner).

>    -> donor runs as rq->donor, owner runs as rq->curr /* execution / accounting split */
> 
>   Later, when the owner is switched away (another schedule)
> 
>   ... owner running ...
>    -> __schedule() / switch away from owner
>    -> put_prev_task_scx(owner)
>         -> ops.stopping(owner) /* if QUEUED && IS_RUNNING */
>    -> set_next_task_scx() /* whoever is next */
> 
>    Later, mutex is released - donor can run as itself again
> 
>    -> mutex released / donor unblocked (!task_is_blocked(donor))
>    -> donor selected as next /* becomes rq->curr as donor; not superseded by proxy */
>    -> ops.running(donor) /* set_next_task_scx(donor); QUEUED && !task_is_blocked(donor) */
>    -> donor executes as rq->curr
> 
>> I think dequeue_task_scx() should see task_current_donor() before
>> calling ops.stopping() else we get some asymmetry. The donor will
>> anyways be placed back via put_prev_task_scx() and since it hasn't run,
>> it cannot block itself and there should be no dependency on
>> dequeue_task_scx() for donors.
> 
> The ops.running/stopping() pair should be always enforced by
> SCX_TASK_IS_RUNNING, so we either see a pair of them or none. So in theory,
> there shouldn't be any asymmetry.
> 
>>
>> With the quiescent() + runnable() scheme, the sched-ext schedulers need
>> to be made aware that task can go quiescent() and then back to
>> runnable() while being SCX_TASK_QUEUED or the ext core has to spoof a
>> full:
>>
>>   dequeue(SLEEP) -> quiescent() -> /* Run owner */ -> runnable() -> select_cpu() -> enqueue()
>>
>> Also since the mutex owner can block, the sched-ext scheduler needs to
>> be aware of the fact that it can get a dequeue() -> quiescent()
>> without having stopping() in between if we plan to keep
>> symmetry.
> 
> We can see ops.dequeue() -> ops.quiescent() without ops.stopping() even without
> proxy-exec: if a task becomes runnable and then it's moved to a different sched
> class, the BPF scheduler can see ops.runnable/quiescent() without
> ops.running/stopping().

Ack!

> 
> As long as ops.runnable/quiescent() and ops.running/stopping() are symmetric I
> think we're fine.

I think it is mostly symmetric other than for that one scenario I'm
confused about above.

-- 
Thanks and Regards,
Prateek

