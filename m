Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8264A8C
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124918; cv=fail; b=Iw9IapTrhQQFTuhy60tJDBDrjb0b2nrucwaZiiM1ftJXGneAB/jiGT/F6cLOPDjZV2MlUG6sN5EjDuir2e0K1AQuy//00FLqUq9woHbnXXRtzU2p67H+lhIocrfc1ONQeeqIgRnUvRu+N50x2lau9ssiX6YBJ5iUQpSKAZTDqYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124918; c=relaxed/simple;
	bh=Du626/XeElUtZJ9fdNZhj/w7sCehviO5DuN2NZJ4/GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rvUEtkJGjj3WI/X2pGaW9Kye9ONbGPu77wm9rdhwUmRCuzQgOAi0SA0z2PKsBXnZl5OHPrmRoFKsuSLlWmOCcq2qmnJ6qgLqNz6uV06zWtPtX6ICI48sp5tsFRprC6i1XDZ+wbMpKVCCXcSAJx9hvc6KXCcJVxyTC3VGgJlZVBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SInuP26; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SInuP26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJJddmv6zzHP+kra9+tdLT3RdKu1adBUWz4UujX3GHyjj9I024ElzdrjJGLGO1I+X15r+vSUnbz5M9eDPU11g9EPD/VkCms18+ED6C694qBXPCux3bw5I3eBRIwNpEtydWSjWIJmX1kumQd02U9L9qz4Q3bMe8XlnvR8GD8jpxTvzWAKYhqlOzWFcUdZ9FOl/4HbdI5XGW2MhZ14/AEp/YE7JMYv06b5WnQP7T9IgtD+D2LvY1KuB0BN9Z7FnLd6jD/M+LdcaOTZgm3kTSBw2txYX8u7Tv2/SxgCIaItUBQ7pKkBh9Mpf8licjgQee1frrLQwXLGG9+xa7c6vZ3vEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKwWF0qpQH53PQf1Us+TDGGg+RrQDo6TFXb/mXvrm8U=;
 b=J+GSaFjBrBR85FvSHCw4VM1apPH2bWTCxPWPITqq+CB/yXX6/7jSBsDr8vj3DxvfMLG44351De/vFyMpbz5bj2x+QmH2MlgmHeKGHfznd8ifEy+UbAhNXcjnVNLHRgvm1zFjEPh5dhYPjm0It6NUtpJv+TMTys2vVP6KcGmJLMcmR/7a8tHP7/5IEDg5tvYceR3zh0whoSih/jhWkEO7woXCvSvHpygPfy6oKXWgoUvNHQme3bBNXsDDOQoo7vyy5Bm+PZr2CcLQf3uTok66Dc/mXsmqZIOk3YH1OR/BFWVEeuQzQoNCdhXY0jv8i044SX5E1N6F+7cnJxU6zxqLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKwWF0qpQH53PQf1Us+TDGGg+RrQDo6TFXb/mXvrm8U=;
 b=3SInuP26+y71UQaEdkW+hwho0QbXMc4Wnu84p5/IGFhw9x3WwcCmbDtyNwJ209DquyO54cWgny3fJeAdror8SX6HZsPTSXWzWx92FOdXQthOeM1EriDK+ZVAWDL3VAFxYwOgnSvcOneEPQCy9p8JEQfMwldjOT4cLoFa+lIWJMY=
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 03:35:09 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::dc) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.10 via Frontend Transport; Thu,
 7 May 2026 03:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 03:35:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 22:35:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 20:35:08 -0700
Received: from [10.136.42.25] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 22:35:03 -0500
Message-ID: <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com>
Date: Thu, 7 May 2026 09:04:57 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy
 execution
To: John Stultz <jstultz@google.com>, Andrea Righi <arighi@nvidia.com>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Changwoo Min
	<changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Christian Loehle" <christian.loehle@arm.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, <sched-ext@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: a80bb077-a5fa-4855-3108-08deabe9a36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	G0A6dqWobn6YBjR4LgOkpBtFMpihBH8bXutn6dLsRo6CxsR9Byxz5yCitj8jjwVgHwSfdrXNomX2UpZ28cw96hrBsjFEN7BYVfYrRstLJpRtVa4YU677i9CLVZxIxm86iz7rwX0MuNP+01p1PTBykXIkuJyuKGMvbnVLp4StSQCkTy+pV6T6YFBMLCuJ8kkzIKOjtbInSgQMYh0UzR3DXWK2rpoeyCVPN5LVe6BZXPtBWavLse9viDOz0G4az+2EYHiBpKrGzrDXK5XwQE/2FcQI6PEC9uFX3yw6gXUxdxWh4+fv7kqctlKPChPBM4Yn8YKMCxFmnq12g8EbzoL3iEW8d5Z3SwxvP3IqWBRwieRMREogRyAzy8qcLqoLPtBJM1m4u4nRc3VPxEOF7f2OxYbVgWqN8ARedzWTva3+dSorNR30I/FGpWLSaKwNExnHUWpf3fAf+LpPVOUVkRGj1UUAPmyOtPTsR/n+4083DQEbEl7/AbWKIq6f2Nt6da+7+xDkUE0SwJcG7L8FHZ98yadyU1sFJx0TEghFcPJk1gRRAMqXpc/CHLo2QM+ELmD2nO2i4Z/Xw2OIUr8QhCXEJWlJBvjcCrlw04pSlq/bHlH/FvtTzOtJhYK9Kmfzsj/AHAB1HYv51RSxEGCEdxSgMGXhPXD2D7Xvf3FCWtmx9qujQ7lKSg2BpygPREm9oGz8HfXaWtd9nXL2Pfu0+0jXNxynpb4l6r9RrZ0nEmjQj2c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lSzZnmr7fRjpN1EVy4TPWg800/SpAyNVjgMbXCqZF+Ip99FxcvwHyTpLagF9YikNv++baWYLobbIcooS6RDa6o+24LgPbp28wpUyGPxX2+ZKKayrX1YkQS4qHfwyHGtSkVtpE24tRVsNlLifOMtA5wtSecK1gFw/mnpqK8MwvLjW/2rW+xHs/R6t4VJg2ww7IZLmubrOlgaGBrHDAjrh+uKS6gCrG0FvJToMiOVZG9TZADclSAxJNswZeF9YaHd2TxBqxfejsw6O8YUnsK5VvdCRv5KSlPoRpVt4LQUEuxhMboIzhJZskhQeRR4JKWhIPJELUCi+5oCoUZqAPy6LQX/1GkaLW+CpZllwE3PjNgcCiNLGgDheKcVrdnEERcGddeD0E8fKJEBq+37uYt04UlXqqEiXNz7iN0SJtusqc2ImSYrFEG1zQc1QsHGX8J75
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 03:35:08.9473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80bb077-a5fa-4855-3108-08deabe9a36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

Hello John, Andrea,

(Full disclaimer: I haven't looked at the entire series)

On 5/7/2026 2:39 AM, John Stultz wrote:
>> +                       /*
>> +                        * Tasks pinned to a single CPU (per-CPU kthreads via
>> +                        * kthread_bind(), tasks under migrate_disable()) cannot
>> +                        * be moved to @owner_cpu. proxy_migrate_task() uses
>> +                        * __set_task_cpu() which would silently violate the
>> +                        * pinning and leave the task to run on a CPU outside
>> +                        * its cpus_ptr once it is unblocked. Stay on this CPU
>> +                        * via force_return; the owner running elsewhere will
>> +                        * wake @p back up when the mutex becomes available.
>> +                        */
>> +                       if (p->nr_cpus_allowed == 1 || is_migration_disabled(p))
>> +                               goto force_return;
>>                         goto migrate_task;
> 
> Hey Andrea!
>   I'm excited to see this series! Thanks for your efforts here!
> 
> Though I'm a bit confused on this patch.  I see the patch changes it
> so we don't proxy-migrate pinned/migration-disabled patches, but I'm
> not sure I understand why.
> 
> We only proxy-migrate blocked_on tasks, which don't run on the cpu
> they are migrated to (they are only migrated to be used as a donor).
> That's why we have the proxy_force_return() function to return-migrate
> them back when they do become runnable.

I agree this shouldn't be a problem from core perspective but there
are some interesting sched-ext interactions possible. More on that
below:

> 
> Could you provide some more details about what motivated this change
> (ie: how you tripped a problem that it resolved?).

I think ops.enqueue() always assumes that the task being enqueued is
runnable on the task_cpu() and when the the sched-ext layer tries to
dispatch this task to local DSQ, the ext core complains and marks
the sched-ext scheduler as buggy.

With sched-ext, even the lock owner's CPU is slightly complicated
since the owner might be associated with a CPU but it is in fact on a
custom DSQ and after moving the donor to owner's CPU, we will need
sched-ext scheduler to guarantee that the owner runs there else
there is no point in doing a proxy.

scx flow should look something like (please correct me if I'm
wrong):

     CPU0: donor                    CPU1: owner
     ===========                    ===========

  /* Donor is retained on rq*/
  put_prev_task_scx()
    ops.stopping()
  ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
  do_pick_task_scx()
    next = donor;
  find_proxy_task()
    proxy_migrate_task()
      ops.dequeue()
        ======================> /*
                                 * Moves to owner CPU (May be outside of affinity list)
                                 * ops.enqueue() still happens on CPU0 but I've shown it
                                 * here to depict the context has moved to owner's CPU.
                                 */
                                ops.enqueue()
                                  scx_bpf_dsq_insert()
                                    /*
                                     * !!! Cannot dispatch to local CPU; Outside affinity !!!
                                     *
                                     * We need to allow local dispatch outside affinity iff:
                                     *
                                     *   p->is_blocked && cpu == task_cpu(p)
                                     *
                                     * Since enqueue_task_scx() hold's the task's rq_lock, the
                                     * is_blocked indicator should be stable during a dispatch.
                                     */
                                ops.dispatch()
                                do_pick_task_scx()
                                  set_next_task_scx()
                                    ops.running(donor)
                                find_proxy_task()
                                  next = owner
                                /*
                                 * !!! Owner stats running without any notification. !!!
                                 * 
                                 * If owner blocks, dequeue_task_scx() is executed first and
                                 * the sched-ext scheduler sees:
                                 *
                                 *   ops.stopping(owner)
                                 *
                                 * which leads to some asymmetry.
                                 *
                                 * XXX: Below is how I imagine the flow should continue.
                                 */
                                ops.quiescent(owner) /* Core is taking back control of owner's running */
                                /* Runs owner */
                                ops.runnable(owner) /* Core is giving back control to ext layer */
                                ops.stopping(donor); /* Accounting symmetry for donor */


I think dequeue_task_scx() should see task_current_donor() before
calling ops.stopping() else we get some asymmetry. The donor will
anyways be placed back via put_prev_task_scx() and since it hasn't run,
it cannot block itself and there should be no dependency on
dequeue_task_scx() for donors.

With the quiescent() + runnable() scheme, the sched-ext schedulers need
to be made aware that task can go quiescent() and then back to
runnable() while being SCX_TASK_QUEUED or the ext core has to spoof a
full:

  dequeue(SLEEP) -> quiescent() -> /* Run owner */ -> runnable() -> select_cpu() -> enqueue()

Also since the mutex owner can block, the sched-ext scheduler needs to
be aware of the fact that it can get a dequeue() -> quiescent()
without having stopping() in between if we plan to keep
symmetry.

There might be more issues there that I'm missing.

-- 
Thanks and Regards,
Prateek

