Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5637AA9E
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116498; cv=fail; b=fDWVnzHNybfpklzGS3OGD5fOVOFWoSEGzRs3jfvB9F1Yoic7DrOuwvccipBKz9+CEFJWneR1H41Bysl++O0Lhxrd4C5Y1jG0EzEldl8aI7pehY/ipXM1VOwByt/647RoID4jZRynSzrR/XGZO/LnqZw9llDTnHBRYZW2VXUGbOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116498; c=relaxed/simple;
	bh=yB3ECk2jobMeNoDDRqb4+Ir7Y9veHtemzqP96oXNFX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5oK69CMEUW5c5GstqaJ7gjrr5OUIbOkr3/JTYl6424MivfIt3cQYG+nQt6vzES1WiGdPewFcJiParzwRiiMA4lZIABoqHBaNudY/8MfsEVRYNmmGBUzGTuJfce/NcZ1ki5S9l1LzmaM3wwXF/ytzkX/0vQ6d4Rfrg/q/YG+h0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MNSi3rRZ; arc=fail smtp.client-ip=52.101.57.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNSi3rRZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZpOMCM6jRZhtNud+oqW12yvGz2oY2S0M64Y0eCdG4tqaAMLm+2FQuGngPoG/Nx6S897MnTah9lhk1SdmFDb+2toDHDJTt+wEGBwaXqrkELq2U9KS18ExT6TqvBcMShkDIrum9WDykLsX0Kg/qBSbIz0cN78nOISWrjbWsZ23s4EjbWgZoJoof+vKI+uPMBFCzu8z7NlIBFdyzhYLyJS/dPrea/Ne9JyKGKeIvLqf6gUkZn2ivR7zZ4ISHnRFuJpKVcPPm2AJU0VscFfHu6So/5hIBKC+K6yB0zl1p8ihitqmgflcVpVbD0meUkksvzT61lUbqgBOynxNJKACz+Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB+Lzo0hWPGdYcAZomiHFa5mpXhQ8OUskluCFDC6jEI=;
 b=faHGnMLFrkbrjR74wexEc7ly7c5pTNFA/3NCHCBE583AqB9dAIG0aG+YgCROfWmQOxT2NL1GfRuusC/kVv3pnO0v7EppjPjOxL7AAZbjKUsa0qcM95lvsmAA4uvLd6sEk+sBUQBGH47T9Rtg3+j04xiLtDkVtCalhbIBSPvApOQsXYQ85+85lMuUGSRfbaxqUXEd8MiLpojEwmCToztbXHTK1NDSV5yRI4y6BjpxJfoPddfyxa5qDmKdZ49FLHm2+xaYm5+ADeGamaT9uqcnNWuWDF3XGCn8GtAnLlVRpPKYGbwxZUs5rV5NWpQaKqZYxMr52Gn7OtjHIWCE87U8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB+Lzo0hWPGdYcAZomiHFa5mpXhQ8OUskluCFDC6jEI=;
 b=MNSi3rRZCS23zquTNmRjlieTDYb9HZ/RfjL5jCCE8aw7ssNgQA2tCAahFe/1SVNIOMmcqV3htrtfBJKm2L5YcTSUMyeZvdAv1Ef810yiSDXm9drHT0liBo7TyMER8L668RY4JB/dE9YnCEOjS/6JEY/0VA1nCzG+pFgj4/DqqMyjBoHNVnzcmoG0XM5Yz/ZbedccB4fVt51EolLJM2j4NqzO4pu7cq2+hYT0Vun0HGBBg3el+jzTcpjr7fMoAJvcnqmeGmxVMolL3uYFwRk4Rc37H6v+oCRt/2U+bHT/J67n9/3AGqgZOW3FbitbV6DZNp/GtrRN2BSP7wEnR4gvRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 07:54:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 07:54:52 +0000
Date: Thu, 2 Apr 2026 09:54:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, patsomaru@meta.com
Subject: Re: [PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Message-ID: <ac4gxCImroMR6TYl@gpd4>
References: <20260401215619.1188194-1-arighi@nvidia.com>
 <ac2gYobvvAXSPjxd@slm.duckdns.org>
 <ac4dbpuXGBUEVm6E@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4dbpuXGBUEVm6E@gpd4>
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dfc68d-c72a-4b20-2c2b-08de908d1f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QONW16mfXG2VRZKfcxCK8VESXQGiaRtNE+PXuGg1JFKajkadz5rdyjpEKdTD0cqVZCCk/9lKaHNxUx8Dn/6lM6JgL7MYFRrH2JvA++V/2cciBoaS+jED5xsfiVd35IfcwttBq3R+P8S7LoShB9YUliM5XL3EnS/su4FCpQrTUVbro/Cou00EsMpdw2uvEX/I2qcAGhdOcsbAZr+wq+wqoSzv+sOAMlvZZjHcQLssc4l2NbbZ2I4Ji2nUrGY2+mczo2cfCMUj4+w425OSkG2cXUDL2VV5Y+6xx2Blhn8fVdg5QTB5y03AktLkUQcw20/TIrxVHy2nv9dhuhXpOXNctL5v8Ud8qqnCM/gEBmv/B/wRHagWk4WgVmt8IjsKibAgVJZtauY7nWyehfnsJXQxfKab9+19EqLZdWbJ0fmSyqQzZdJJSlk34+KOUmtF44tmqkecbDpb1pNYmEKkm9nPAR1sALIjkIqmgz17Ob3aXstj/ehK5pjGN+QtnLU9oLd6neOIG3j+eIkKB/oE+9I//1HEyOqHWiWTf9c88ALhTg0mJYmeGLMlV/N0ncWkak65x3vhXvZnlb4up1EsdSPC50Oh29y+m36Vwz+i+hjk1hcpDRVyaCqCmP4Kkn50pLgFeQucWbt8OqxsEebf3+sN8LL2sWOqbgdwhBdzQebTmvCxIsQFcvrG9AYV1gseI6XZIx8SzsLOEb3Bgm1sMA9iciJiyx6E0Fi1VU7LdDl0r+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZDZWCzqMDS2jDXLGoYzrn/E2iz7fefADnIAgy/Q9pZlQl4uJnCHrpPQV3FT?=
 =?us-ascii?Q?ia/Vjv/Ul19hg/0Z1y2cup0BFNPSngF5f6B/GZWYJJuiESDtRLhSp0fPiVGk?=
 =?us-ascii?Q?YISptjENYIIY2I0qeKbNAspWqPQMuHAb5p2+JjpyKTUql4REo69IgEWt/BQI?=
 =?us-ascii?Q?gKvKVD6DLHsRmC1daAkLJFUoc5ycNrPHr+EXqIYGCdid5L2F8fhPGoks/urB?=
 =?us-ascii?Q?l11utTkqoXgkBe88dS67CFnBLjbGYoI3LNIcZeGtBuBAT6thh8jOvlUR/1nw?=
 =?us-ascii?Q?2nlbXkE06/C/rED7WQUSWvl4e+9OBFL5MC6B844NrnjuJe19kbLF68PDCl7N?=
 =?us-ascii?Q?p21e0QUOPtTss4t8BGjYpoh4mjIPO5k1YYaB3xSbIWrhzvr2JUW5WMOYKaLH?=
 =?us-ascii?Q?HKy3lftZp3zOBYBjvWpRKIuQeLfzT7i0SViwTo0obTpDZk6URDgf0jJ/BaoX?=
 =?us-ascii?Q?gVh3CU9bAgdD1PhJQsRgiEuhfW3vN5jzUffdnINUizE9nWYNe9vb8itm2kKd?=
 =?us-ascii?Q?JFAVuuzj0WKTpujb+LTSoz9vNNEG2Zv0hlSExESya9mEMeqYDVF2qwCvNkqF?=
 =?us-ascii?Q?4hzFRCCYyl9CrHRdKjJaVGqnNEPWMNQuoFFXeuuFsHDA38eDTI6bP8A4W/7K?=
 =?us-ascii?Q?0gAbtu1zOSPF4iw2ckhD+GMr/PZD8G4gixLHDqgFzxfEzqWlEyuYQu4Kz5Gq?=
 =?us-ascii?Q?q8Dv0e4YiWTnQqgp5wLNUBTNonyLb5jo50zh6Y4ZltSTZ5GEbLh+FBMopomv?=
 =?us-ascii?Q?/JqCbjrSBM1kgpSfpIrwtnDIpFZkK2RSy5S4FfQMSq6h2dF6gX86zkOzIVT1?=
 =?us-ascii?Q?ooqNaVga+L4Vp5nl+Wq5DZPAdm7jgt9pQBTet4V3ZblnMojOShAMxfwUiggm?=
 =?us-ascii?Q?Mb01w2Uj9LpXUQneigS/Bcmju5cl1smp37Gr7gZj3wwg8NRSQA7Ksi24ntBb?=
 =?us-ascii?Q?B7eltTtK3dnP1oH9JXQWklAzOsnx9h9zTRiLqSM8LzbGSGNx/NmEwLQNv2/8?=
 =?us-ascii?Q?b8zDVKja1Tb7owag+uhiUvWvDLBqMFXlNu7qKcef/A0UMcF0shI8SMW8Ariw?=
 =?us-ascii?Q?nHU2WouJlZlRLIhLZPkFFBbQ05vwf+MhIB0gmppYaBd8NSuqO/GKfY3fjx3A?=
 =?us-ascii?Q?yzotOXwkYomr3bmFtR5KNISMCoSxiqv95iH35y3/5RDgTponRF8WcBhjJ/zx?=
 =?us-ascii?Q?wcWYUgwqQ86/BpnIhXr0MNuB13SnR/CTWIEc0rtt4nypbKbFkRvQ/txM0FBP?=
 =?us-ascii?Q?A2XgrPire/5m/s5FhZW96WTwbqHEiBsM+uHuufbBXzwRUllK25oRS4W/Nk1v?=
 =?us-ascii?Q?g1Z6Qtpey4VZuHSTEN9rlWaWCH4rOXHEvsifTWSkcAYSv5A9ZLgp+jFoUeTI?=
 =?us-ascii?Q?TsRwdhVLZqW1BU5oMw1YW53EBAYOn8gFdpkdAJes48TlWoBvlI2k/QbRaUAE?=
 =?us-ascii?Q?UOrrbLD7JCgsOhog4jtaF422Fvc5FhDMFqWhuywjo8iZpzZBEz8kD+s7M2p1?=
 =?us-ascii?Q?3Na0GOy8VYZMWCATZcyFpKqEg5RrNglqUoT2PkMFAUeEKec9698SM4qgS4d9?=
 =?us-ascii?Q?awm0FpdWfwjCLxSyfsv4KxTfLtTDXWgXJJW6WaRsrExycslGa+6zD1SNs89V?=
 =?us-ascii?Q?t3kE6oImt4sO4nNhrdYoq6q/okNSnkzs9QAJTbtifuH612h3EV0khc13WvkZ?=
 =?us-ascii?Q?QBqYmLSiXJa4hHkDE/PP8h0YoJS54vq2jsKn1st5FnmYVmXC5r3Dr6eyB7Jl?=
 =?us-ascii?Q?e+ROanMzng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dfc68d-c72a-4b20-2c2b-08de908d1f80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:54:52.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFtazQYetG5Mqu2H2lnlIzgFwntwQfF441yMoqK/RDRP7hZyIhElIEbl1S83ZOos7pBCH6CR44V5OZCKorKrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113

On Thu, Apr 02, 2026 at 09:40:41AM +0200, Andrea Righi wrote:
> Hi Tejun,
> 
> On Wed, Apr 01, 2026 at 12:46:58PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > (cc'ing Patrick Somaru. This is the same issue reported on
> > https://github.com/sched-ext/scx/pull/3482)
> > 
> > On Wed, Apr 01, 2026 at 11:56:19PM +0200, Andrea Righi wrote:
> > > @p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) in three
> > > scenarios, causing a spurious WARN_ON_ONCE() in mark_direct_dispatch()
> > > when the next wakeup's ops.select_cpu() calls scx_bpf_dsq_insert():
> > > 
> > > 1. Deferred dispatch cancellation: when a task is directly dispatched to
> > >    a remote CPU's local DSQ via ops.select_cpu() or ops.enqueue(), the
> > >    dispatch is deferred (since we can't lock the remote rq while holding
> > >    the current one). If the task is dequeued before processing the
> > >    dispatch in process_ddsp_deferred_locals(), dispatch_dequeue()
> > >    removes the task from the list leaving a stale direct dispatch state.
> > > 
> > >    Fix: clear ddsp_dsq_id and ddsp_enq_flags in the !list_empty branch
> > >    of dispatch_dequeue().
> > > 
> > > 2. Holding-cpu dispatch race: when dispatch_to_local_dsq() transfers a
> > >    task to another CPU's local DSQ, it sets holding_cpu and releases
> > >    DISPATCHING before locking the source rq. If dequeue wins the race
> > >    and clears holding_cpu, dispatch_enqueue() is never called and
> > >    ddsp_dsq_id is not cleared.
> > > 
> > >    Fix: clear ddsp_dsq_id and ddsp_enq_flags when clearing holding_cpu
> > >    in dispatch_dequeue().
> > 
> > These two just mean that dequeue need to clear it, right?
> 
> Correct, we want to clear the state where dispatch_dequeue() cancels a
> pending direct dispatch without calling dispatch_enqueue(), so I could have
> just clear the state unconditionally in the !dsq case and simplify the
> code.
> 
> > 
> > > 3. Cross-scheduler-instance stale state: When an SCX scheduler exits,
> > >    scx_bypass() iterates over all runnable tasks to dequeue/re-enqueue
> > >    them, but sleeping tasks are not on any runqueue and are not touched.
> > >    If a sleeping task had a deferred dispatch in flight (ddsp_dsq_id
> > >    set) at the time the scheduler exited, the state persists. When a new
> > >    scheduler instance loads and calls scx_enable_task() for all tasks,
> > >    it does not reset this leftover state. The next wakeup's
> > >    ops.select_cpu() then sees a non-INVALID ddsp_dsq_id and triggers:
> > > 
> > >      WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> > > 
> > >    Fix: clear ddsp_dsq_id and ddsp_enq_flags in scx_enable_task() before
> > >    calling ops.enable(), ensuring each new scheduler instance starts
> > >    with a clean direct dispatch state per task.
> > 
> > I don't understand this one. If we fix the missing clearing from dequeue,
> > where would the residual ddsp_dsq_id come from? How would a sleeping task
> > have ddsp_dsq_id set? Note that select_cpu() + enqueue() call sequence is
> > atomic w.r.t. dequeue as both are protected by pi_lock.
> > 
> > It's been always a bit bothersome that ddsp_dsq_id was being cleared in
> > dispatch_enqueue(). It was there to catch the cases where ddsp_dsq_id was
> > overridden but it just isn't the right place. Can we do the following?
> > 
> > - Add clear_direct_dispatch() which clears ddsp_dsq_id and ddsp_enq_flags.
> > 
> > - Add clear_direct_dispatch() call under the enqueue: in do_enqueue_task()
> >   and remove ddsp clearing from dispatch_enqueue(). This should catch all
> >   cases that ignore ddsp.
> > 
> > - Add clear_direct_dispatch() call after dispatch_enqueue() in
> >   direct_dispatch(). This clears it for the synchronous consumption.
> > 
> > - Add clear_direct_dispatch() call before dispatch_to_local_dsq() call in
> >   process_ddsp_deferred_locals(). Note that the funciton has to cache and
> >   clear ddsp fields *before* calling dispatch_to_local_enq() as the function
> >   will migrate the task to another rq and we can't control what happens to
> >   it afterwrds. Even for the previous synchronous case, it may just be a
> >   better pattern to always cache dsq_id and enq_flags in local vars and
> >   clear p->scx.ddsp* before calling dispatch_enqueue().
> > 
> > - Add clear_direct_dispatch() call to dequeue_task_scx() after
> >   dispatch_dequeue().
> > 
> > I think this should capture all cases and the fields are cleared where they
> > should be cleared (either consumed or canceled).
> 
> I like this, it looks like a better design.
> 
> However, I tried it, but I'm still able to trigger the warning, unless I
> clear the direct dispatch state in __scx_enable_task(), so we're still
> missing a case that doesn't properly clear the state.
> 
> I think it has something to do with sleeping tasks / queued wakeups /
> bypass, because now I can easily reproduce the warning running a
> `stress-ng --sleep 1` while restarting a scheduler that uses
> SCX_OPS_ALLOW_QUEUED_WAKEUP, like scx_cosmos. Will keep investigating...

I think I see it: waking tasks may have had ddsp_dsq_id set by the outgoing
scheduler's ops.select_cpu() and then been queued on a wake_list via
ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such tasks are
not on the runqueue (on_rq == 0) and are not iterated by scx_bypass(), so their
direct dispatch state won't be cleared by dequeue_task_scx().

How about clearning the direct dispatch state in scx_disable_task()? That would
catch those tasks as well and it won't leave the stale state from the previous
scx scheduler instance.

Thanks,
-Andrea
