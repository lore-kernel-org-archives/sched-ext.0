Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D83F0AB9
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168872; cv=fail; b=pO3diL8J6HEtnJl9yMwpLW48+BZcsRiiuLiD5h6SSmyiVHK7j9ITaIhqvr7wESuw4y18nzT9mgf5d/pzZmn1Mpr/ENonD+GtNbLeh6QbHX7AaaKrM9y4RfWJCZj7Ph+c+jBsHkUtQdPLTSZ0qXS5TCc2JD8jLIQvQLUdhMvW2Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168872; c=relaxed/simple;
	bh=Ba+KucqUmFomMrDHnOS4f5hQJ2r5MEQeF/U9sFQcX18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FTjH/FzbNzDhfcxqEfdwYy0uIs2pIC5GJPbVegNvJqM3rMuf2g8WpeJrXISBDOoVGfCzAFWrNdrP1JanThq/jPOT702ER/PUoZuYb+OpcLB3uBLC3wMG8JcAopZCAg6jIUsrPvLDKdOXXpzw8JrYC0l9683VHHclGp0iCF1GYj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVk76DEu; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVk76DEu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpgLPp/7xWKIP+qXIMB7gwexGQNZBfvd7Y7JFvJc4qNZb2rycpwVOLPQyLu2QlyKbcqGl6a3n3xjxjystkWwba/w1MEuguuyHW7YE5+Ur/OxCODaLYSufXLrkDunDH0feTE2qbFaTEdmwzsTHJfq1xftiPw+vpDFeYdfxiOdWG6YtR0cD4tL1ynun5ZT/D32oJukeYi85edNnZRlMJafbCtFg/K9yx0j2aJ3f3cuNU85GVe1BRKUHFV6qG+kquzdXZCA6dSOygO+xPxcO5ztpRjpjdvrkH66WSuXFbNY9Xe+hQ0Q5WJ+ZrB0clvB6a/EnkwWAhmNlUkD2/xLT5i3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRM8NiJo7Wk9cgTPKicorXqcjsHNdZzQ8G06aVGqr/I=;
 b=wAlIv9NDpqZzqDUVUvxOR7Jc7shsCHLxH1SKXodNbLucJHL3/rSOYzxPXV4K61ZVnZmL/lOGLFoutCZMby05IrwfQ7OQQTAWgJUYpHGd26Ds2MQ0e6feTHFuAX3l9qKjS1s1YPAyq95+RE93NbyCdoNB1P3ws/wT6Z4CsCgyPPfSIDi14Suh5q4X4btIl+/Ohe50oaSXkj5AkQG5SaS3dSC7Hs6knm1GSYgy5dUJzHdqQ1q5W22MgaZRsqnuvZ2udfuRa/aSkjY4zENMaEud/9IgB2SkjCQ0N9anb/5PCfSZpg9dShFAsxUneYHPUNSkgNAc9ZhTIg67PlSfDXySDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRM8NiJo7Wk9cgTPKicorXqcjsHNdZzQ8G06aVGqr/I=;
 b=eVk76DEu6oIMCFNFYzadrGYha/St3Z6z1sMSs28hPYGkM4PGFQwyIiqdz0zbL3D+RtN67y6A3gfVnvnc8efe7vDmEAbsXzd7QFlxjihWJe0mENYxEk6ULCocRHpFgTLs3Q09olRlFn9q6x662PiN5OUQEtW8EQMjl1czDrBwJfw=
Received: from PH8PR02CA0039.namprd02.prod.outlook.com (2603:10b6:510:2da::26)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.18; Thu, 7 May 2026 15:47:42 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::6d) by PH8PR02CA0039.outlook.office365.com
 (2603:10b6:510:2da::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 15:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:47:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 7 May
 2026 10:47:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 May
 2026 10:47:40 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:47:35 -0500
Message-ID: <24ffc508-a806-4be0-9b33-fbe8c02d1742@amd.com>
Date: Thu, 7 May 2026 21:17:34 +0530
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
 <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com> <afxlvypRoa0qCHhs@gpd4>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <afxlvypRoa0qCHhs@gpd4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 004c9ec2-8dcb-47f2-4513-08deac4ff94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jFvlHaSr7rrOT9jj+UZfQSIgajtQBmsMfSdp5fMnnnp0Oh4MSlvWmMg+ziPKinq8o2JxLgVtKHam0RdAWLvuzroWlPomTiWyb2pKTEG71baSe+bYHVVJZeVHfKw7IZMiTEuir++hr9OfMvJk61t/L9w1inP2VbwHt5SfH26gVOU/+S/3+H5vfFEAFKGDC2keWCUL5ifPEqwySRu7AaiiBLbGvHAUbdjyjhVXCVKGW7uGwSDSOy20scWZIxciVx3BdQMYaJHDwJiwuH/ompt156Mf750ddOd8ieAIJVUiGoBdeFpwsZ/iWqAZ86wKMGwrZ+y7zLcE6BYA+mRIPStHkgJZ4Pr4L5AdHP/uExmYPNxjDh2RUGHq43U823XvQ/yR8CGXq4U/nNashSNDOz45l90PUcd3T4URHQnd8sVFCaqF+vxDj7uML2tTxCRxIyTVRcojswQqjvRPX9xLb3xo9BWSdkVm1ikKAYdgl4aCTr52LtkRgkkOAO4h+hiNnsScJOi7CSY6fVjG0Fq/fKdr6mKPEcS332bHcad00+D7aig+8aSLGzP9hrtOGC+qTWv1LfAxwD+KPv0ARwlgYNUFMVaYNIq9SLW/P7O+c6C6CF+z85nuDtM/ZyHcTDVSdWezidwlVw5mZQSfrcIHBHTKTGvcSTaDR1WCYf/7QH0RN9NzkUwWTaNClLlZ0wKDLVgx9E+mITia275utoOv7FHBwCGJxsZhms7qWed5jfnAxew=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K0xgjTtuf7/17YXMrfhhBANAn3joOP+WrXAeREjD3sTecns1uBU4AY4tK+jRSqy6/raZKcaPO0Z20bUrMInlXBYhDlrVGpjJZ0PLlMdiH0sO9jtejN75VB7qrow3f+RNdDLQHePugUKC3USLp19EobhLimWDyLQuTcoZsP0g/rFDxfebCP4oWobrQJbxasWXTw/6oD4nb6Eg+0hhLiCsg3Gdrptr22agv4NmgWeL5piZ3gD6dU2gTMeAMpchyM4kfASD40pz6nZjo595/FtY/NfTwQ459UQKX0MzDXKEXvpdH9SFoeYIRobFO0S6Xjhou8bfjNzDFCSpayjvKWPJL6NWIb8SO8KB/HdcwmjrOziMwxlp1PP+Bf+3L/VZzXoiev4mdf8mM3sQ9i23FSJF0MJ2Q8Str/W+rcIYFB3i6/SV4iuS/1EvuSULbl3vcc7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:47:41.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c9ec2-8dcb-47f2-4513-08deac4ff94f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

Hello Andrea,

On 5/7/2026 3:43 PM, Andrea Righi wrote:
>>>> scx flow should look something like (please correct me if I'm
>>>> wrong):
>>>>
>>>>      CPU0: donor                    CPU1: owner
>>>>      ===========                    ===========
>>>>
>>>>   /* Donor is retained on rq*/
>>>>   put_prev_task_scx()
>>>>     ops.stopping()
>>>>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
>>>>   do_pick_task_scx()
>>>>     next = donor;
>>>>   find_proxy_task()
>>>>     proxy_migrate_task()
>>>>       ops.dequeue()
>>>>         ======================> /*
>>
>> At this point I mean ^
>>
>>>>                                  * Moves to owner CPU (May be outside of affinity list)
>>>>                                  * ops.enqueue() still happens on CPU0 but I've shown it
>>>>                                  * here to depict the context has moved to owner's CPU.
>>>>                                  */
>>>>                                 ops.enqueue()
>>>>                                   scx_bpf_dsq_insert()
>>>>                                     /*
>>>>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
>>>>                                      *
>>>>                                      * We need to allow local dispatch outside affinity iff:
>>>>                                      *
>>>>                                      *   p->is_blocked && cpu == task_cpu(p)
>>>>                                      *
>>>>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
>>>>                                      * is_blocked indicator should be stable during a dispatch.
>>>>                                      */
>>>>                                 ops.dispatch()
>>>>                                 do_pick_task_scx()
>>>>                                   set_next_task_scx()
>>>>                                     ops.running(donor)
>>>>                                 find_proxy_task()
>>>>                                   next = owner
>>>>                                 /*
>>>>                                  * !!! Owner stats running without any notification. !!!
>>>>                                  * 
>>>>                                  * If owner blocks, dequeue_task_scx() is executed first and
>>>>                                  * the sched-ext scheduler sees:
>>>>                                  *
>>>>                                  *   ops.stopping(owner)
>>>>                                  *
>>>>                                  * which leads to some asymmetry.
>>>>                                  *
>>>>                                  * XXX: Below is how I imagine the flow should continue.
>>>>                                  */
>>>>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
>>>>                                 /* Runs owner */
>>>>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
>>>>                                 ops.stopping(donor); /* Accounting symmetry for donor */
>>>
>>> I think the order of operations should be the following:
>>>
>>> ops.runnable(donor)
>>>    -> ops.enqueue(donor)
>>>    -> donor becomes curr
>>>    -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
>>>    -> donor executes
>>>    -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
>>>    -> __schedule()
>>>    -> pick_next -> proxy-exec selects owner as next
>>>    -> put_prev_task_scx(donor)
>>>         -> ops.stopping(donor)
>>>         -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
>>>    -> set_next_task_scx(owner)
>>>         -> ops.running(owner)
>>
>> So ext will just switch the context back to owner? But how does this
>> happen with the changes in your series?
>>
>> Based on my understanding, this happens:
>>
>>     -> pick_next -> sced-ext returns donor as next
>>     /* prev's context is put back */
>>     -> set_next_task_scx(donor)
>>       -> ops.running(donor)
>>
>>     /* In core.c */
>>
>>     /* next = donor */
>>     if (next->blocked_on) /* true since we have blocked donor */
>>        next = find_proxy_task(); /* Returns owner */
>>
>>     /* next = owner; */
>>     /* Starts running owner */
>>
>> How does ext core swap back the owner context here? Am I missing
>> something? find_proxy_task() doesn't call put_prev_set_next_task() so
>> I'm at a loss how we get to set_next_task_scx(owner).
> 
> The sequence should be the following:

Still a bit confused! Hope you can bear with me for just a little
bit longer :-)

> 
>  - pick_next_task(rq, rq->donor, &rf) returns donor (because we parked it on the local DSQ)

So put_prev_set_next_task() happens as a part of pick_next_task().

When we pick the donor, we have already called set_next_task(donor)
on it before returning it from pick_next_task().

"owner" is still not known at this point ...

>  - in __schedule() (still holding rq->lock), proxy sees next->blocked_on and does:
>     - next = find_proxy_task(rq, next, &rf);  -> returns owner (or triggers migration / retries)
>  - Only after that, __schedule() reaches the point where it performs the switch
>    (put_prev_set_next_task(rq, prev, next) via the pick path). At that point,

... and we don't do put_prev_set_next_task(donor, owner) after
(or within) find_proxy_task() as far as I'm aware. The "donor"
remains as the task on which we last called put_prev_task().

If you are referring to the bits in your Patch2, the calls to
put_prev_task() and set_next_task() is done on the same "donor"
task. It is purely for the sake of adding a balance callback if
we had skipped migrating away the prev task due to proxy.

AFAIC, nothing does a set_next_task(owner) after
pick_next_task() in __schedule() unless I'm grossly mistaken.

Sorry in case I didn't see it until now but could you please
point out where this happens? I'm not seeing any scx specific
calls either in the context switch path other than
sched_ext_dead() called for a dead task.

>    next is already the owner, so:
>     - put_prev_task_scx(prev=donor) (or whatever prev is)
>     - set_next_task_scx(next=owner)
> 
> And parking the blocked donor on rq->scx.local_dsq makes it the obvious
> candidate for pick_next_task_scx() on that CPU.
> 
> So the donor isn't "moved" by find_proxy_task() in the DSQ sense, rather:
>   - SCX picks the donor token
>   - proxy-exec replaces the picked task with the lock owner (or triggers
>     migration/return paths)
> 

-- 
Thanks and Regards,
Prateek

