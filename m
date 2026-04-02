Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BF33D4FA
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115646; cv=fail; b=GLbSSBKWUGmb6PSBNieTsLZQwFCxfgvjx3XTZwS3QS8EZmKJRwvpbKASDPVQX/BkR+t0xL6DWb+KJQm9OPKfBBMpspF7VjrZArOVBeA3Xg5zx/xGC3C/n3Grw7T6s34xwb38o2iNe9q8tWMYnyzfxQRVBKdKzfrvhoMoDuJsKSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115646; c=relaxed/simple;
	bh=RphEP5auNoHCWIl62sIs9PN4K+GC5woYzNpZIfX9r9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYUHR7xCRsyaTj9JZw6uQfs6fcysH8Mdg2DJBMuHNdCt3AGd8KlI5LzrVXZL9EvvhoCVAx13UuUO/vm07ZcZKsUnChBqShsDCIS1X5A1L6kJ/HB7NqYS4iOpDe8auzpsW4TKryHn9S1ICU4HmjiuojsGz2gamdLbzd4SpRXHpG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pRsGu80e; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pRsGu80e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcIlp10vFOuaYQMaKzD8OfPm0mSc1/1gle9eSkw84AV9D43DhiBfpdYC74S/2TCSyIAp9e8+XselSUAUpvdVPqMTsHaiWHnndpT8GZLTm47jhG2VD2mu3fOoE++fqR5XZsrH7EV4cpo0kILvC7Myx7M5JCLiVEolvL8k7mdUE8ms1uoxYzXSKB4SgQ7wqi2D4d4INaZA33irMdkAo2AaPmSpPXerNzkNsxdO0obdVOd52Vjz+hcalDLZlxQCCBGkjvvXPS7Yy3CzMLsSVRRW5b01z1MQlCnBVvApQYV0DqyIVTeEv+EPa4P70T6VogEh0XulaLXySWO+vrqK5/uQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DjCJXaNWuu1D2xwieATMasMoRBPRmFW2Z8cCeWbrFY=;
 b=pNDTZH+gP3FEI5mwM+0AhDCoh/jXNqB9NgtUwik6uL6fHPSzftj+zfhc+4Z0ZLeKBnZy7jLE41fH3wZERP/xJiHzGny2aPoIRasEEl3Gjzox7PhJi/6RGbN2Tgyo7J9IVYA8n537V/w4Jdd8wRB7SuOwR0gMgCIVIowT3EXrNZok6AlVxmSU6jB20+QYI+HLe8XqYAVcy1k5FMnPfHkWRdIqIAvUYQtYWm1oE1bmNrxRKWYzU/xCYuuM3OwpT1jzZfJcjvTdNHfJ1k0yiMGuajktlyr/x/ZCXChb+rImfEbJSzwrpn0RjvgKeYh7U9veRL01qN9PEGYzFH4fDqWxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DjCJXaNWuu1D2xwieATMasMoRBPRmFW2Z8cCeWbrFY=;
 b=pRsGu80eX1riNYBcDS0fW5dl2+fsEc+1rAMe/EGAQ7i6937t00Q8bkjMbd5YKaL1w9YoE+m527V060WODNCB4Y7+OWM6xLqXV+FlPAM8N4UZTvQDRPUpcmQzWjeGh0zia8m7E9KXWTUa6Nx4AGFoV2PCzA6uf+1l7NVcf7VcU0Z2yOLMyE9LJp/JeyDb7+SB7DCKHAn+tDnvG6clbkMtdNguOZQA6WmE8YDE0xgmYB1m6wsSive8RYWIE/4FsQXijOJjRClpuoFgM7tvYgh7X2vYlUgCF5SW5uA7S0H3236rqLVWIO0dxb6BXJdSokgL/FmYUyp3/H1GgBSPL4UpLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.13; Thu, 2 Apr
 2026 07:40:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 07:40:40 +0000
Date: Thu, 2 Apr 2026 09:40:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, patsomaru@meta.com
Subject: Re: [PATCH] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Message-ID: <ac4dbpuXGBUEVm6E@gpd4>
References: <20260401215619.1188194-1-arighi@nvidia.com>
 <ac2gYobvvAXSPjxd@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2gYobvvAXSPjxd@slm.duckdns.org>
X-ClientProxiedBy: MI2PEPF00000B7A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40e) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: fa885fa1-0a0e-4750-fbcf-08de908b2351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O26OWm/foKb/GcaoSG+ogOkDSI3Jk3z1dqpIh4PS/I+E5/+4DYigp8hN13yXNuJEyKLN3D/iqYuhD6zBieECaOgCDLGXj1l284QTHC41c8icWtirTEwSDfNcByvIBjouSQOZ/kBkRO9171cRxc9TxB4OCtX1XWv7QYKg6toL+WSwcj0dyGOvl7zFXB09jO4kS2QJc1XSqRzEw/UkpE2jGXsnZDWPaykBrpKHKsbD9pwYinHpazdKCYDbfMLBio8HfkJkx0MuccTmKBxT7TC7bYQs2UU7O/YVA/kmuTOX6ErqTfmBxoZ2WL4+4hK0IdlV3U/RRWGi744QmkRwwJGQ9cN+4GtAss9Yg3zVmmS4pkqHeQ24VDJUdv9+DEs2Q6rGPGdE/HBq/mELn7kQxmxlbtxrQLLSPUu8McuP+yjEgRK7YXpmA4RKBzMMme/AGy/nPEGpdVOYO6B39z6hU58XEsKnWlhBwtL5q4DOkO74TcQgpUWuyCL5pj1Q15RWDaI+TLypHOlAKyAS6rjjevYii2nhUwIL9z/GgeCwT02kdEz7DbMWXvVzgrsBe0eREOqbSKe11Hjdv0u2rO/g89nKXBkXBvkGciIQZRjAwa2HDJwR7uBU5a7UAV+1LDt96OOtf085uqpU43808XTpau55uyJ/pjbReEIuOvdNI9WMujuVelZ0V7QCFk5pboRiwv0DkgHDkI72iP8p+M20JX2IrJFe7kgYZ+PzAOtY/91igw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22LwT1IUk/KwjL92EgBfMAqRRoWEEqdqxaEykpfSbHocWoiUII0BjMPzjov8?=
 =?us-ascii?Q?onLyQKAWAkBFlvKovgRQt1gkJs2EFWqB+8r/X9ToEPfI0eHaoeHAn6tO64C7?=
 =?us-ascii?Q?BxqRcnda1Xa2mQK9BZY+ILyezKSLEWFGCa/cLk2wvYthueQ9y1khHy8jPrOX?=
 =?us-ascii?Q?CFdatR7CUd1M/+9syymxMJm4UZVUxlSdbq5SPtTx78T9F1oTrozyx7hOGHR4?=
 =?us-ascii?Q?XTl4Ky8HpUqHocOPNv1po34Q1b9VbiLEEElVP2qH+Fo6gWaHGtdAtFE3Olkf?=
 =?us-ascii?Q?fMFp7UdnyrMN4E7WsjBYqI78keEYzOQ8UqERKhqRt5YcuTQpMVyT34knW3CW?=
 =?us-ascii?Q?2URqz9yRxDIM1KyJHGyyWcxq/CBMOs6IVVmoAzAH1ndygwydtQbiHpgbWRN9?=
 =?us-ascii?Q?ek44MHcGTXrru7Z2Lu0AoNTVaPuY4T8hmrUZGE2mHFsAQaXh0tds85qgRWeZ?=
 =?us-ascii?Q?sQ7Bg33eG7bvWg3IuEE7V4JhHLyq6Pg+m8QOG+rhRrSQbmsiv5IEpG96qFM5?=
 =?us-ascii?Q?SKfN6alcJJbmUJkka8gafCvXJ1dgtAUJjD3N4yF0wTcIAS40EBPOgyrPfM3o?=
 =?us-ascii?Q?w/zxNw2nHT4opKn4LenpQ77JDeVTRyjMQ4QfTwC4RD/Ec5n3kJozTEnqnR1T?=
 =?us-ascii?Q?DR2JJ08U2SsWSsQF0PBnUIRCULIlYVnARqyM4OxfBY7fYoYw1uCv0UCbsMXB?=
 =?us-ascii?Q?9nnnlW3r4U7Dsho+70fAnpnDZYrzkHevQJUdRdNRVNrZW4I83OVp3pONVQaK?=
 =?us-ascii?Q?3yxtpYb0GfvvG4BtDoV53OHmMicJPN759/5JMhBrovui94jUlxKU1S7G8Bzt?=
 =?us-ascii?Q?2Y8nNZIoTnnL6kG7M9fVi9zjI4hbJQtaeVil/b1DuDkWNt3Ziq17GG8R1bnA?=
 =?us-ascii?Q?RFjLxaXV14Ffg8Gne/+BRq4dIFilTRTVoW/XOUBAF8bEzXt8s1u1vEXUGxFl?=
 =?us-ascii?Q?JTGDRi3k/ssM1pjY2EJkJZCVp75hW2c/2P49DARVnYnTZxbIRylu+seeWEn4?=
 =?us-ascii?Q?BkVgYa3g3osvhkNusSTVeoSEwru835tyHjPtV4vsctSOSLsp/nBtW0JaLzKm?=
 =?us-ascii?Q?SrtuwXNFTdg4a0fECN0HVIFhu+5C1MS/d+DI7NQXA1I1xrf+dFpfcxMehNQK?=
 =?us-ascii?Q?LpTBdaVPiSlp/oRnOtsk1k+BW/RBXby2YJYYDWjYvcNthVmHzSc/3minJyPR?=
 =?us-ascii?Q?pqZqUFVIgDAn0BlbLHUKjk5HYSO42x+9ptMFPxIy6biD2SPaqxkH82fpX9oD?=
 =?us-ascii?Q?w1ZPZIhSvlod5nXfLP8sZPFO9BLqicBbjMOgQEMeQgP1CA99VTGjmSuDfYYa?=
 =?us-ascii?Q?YMo8pV0V1vc9jheykYZpW+VWMu3HOS0tx9q/wIGDK6R1bDdfBV/3cRiXNSew?=
 =?us-ascii?Q?2OsK1Efn+PNdsoLaJwFEECB7uPveGrt58HG1PUb3AKH/HsiPCcETzDSZquJS?=
 =?us-ascii?Q?oifOVd/b8kN+tRVUVx10U/U3GdVlYOz9SRTIw5soSH7C2LnYV4pPGIlAag8I?=
 =?us-ascii?Q?xpXjRnyLWIoU3h6Vj+ci5bcp0tbNgKtYE1zIyYgR+fGqpMlDjc3EAUjkwlq5?=
 =?us-ascii?Q?hVXC/yQWJW38QzIQlff4f4Fh/NkdPnwDGmByW88WEh3B1RxzeOQnqFlExVAg?=
 =?us-ascii?Q?/ZscHJstF7v/ilCu5pDZRJywW8skS1Xc6AjsWiVCA4s3wrDLnEeFXV4pgICP?=
 =?us-ascii?Q?wcD9faVkJXaLfLVBh/uBI+y0hArKnjqGbFeX7G89G7tClESKPW6WC2lKB3JF?=
 =?us-ascii?Q?rK+3zEb9PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa885fa1-0a0e-4750-fbcf-08de908b2351
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:40:40.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBNn49jnQ6apd96fbqtY68dTldMfiY5lKccc+/z1TxPKmpDc1bezWCmMCJlHs1xvCO9q6VuDuRjasRRsRJIb8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA

Hi Tejun,

On Wed, Apr 01, 2026 at 12:46:58PM -1000, Tejun Heo wrote:
> Hello,
> 
> (cc'ing Patrick Somaru. This is the same issue reported on
> https://github.com/sched-ext/scx/pull/3482)
> 
> On Wed, Apr 01, 2026 at 11:56:19PM +0200, Andrea Righi wrote:
> > @p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) in three
> > scenarios, causing a spurious WARN_ON_ONCE() in mark_direct_dispatch()
> > when the next wakeup's ops.select_cpu() calls scx_bpf_dsq_insert():
> > 
> > 1. Deferred dispatch cancellation: when a task is directly dispatched to
> >    a remote CPU's local DSQ via ops.select_cpu() or ops.enqueue(), the
> >    dispatch is deferred (since we can't lock the remote rq while holding
> >    the current one). If the task is dequeued before processing the
> >    dispatch in process_ddsp_deferred_locals(), dispatch_dequeue()
> >    removes the task from the list leaving a stale direct dispatch state.
> > 
> >    Fix: clear ddsp_dsq_id and ddsp_enq_flags in the !list_empty branch
> >    of dispatch_dequeue().
> > 
> > 2. Holding-cpu dispatch race: when dispatch_to_local_dsq() transfers a
> >    task to another CPU's local DSQ, it sets holding_cpu and releases
> >    DISPATCHING before locking the source rq. If dequeue wins the race
> >    and clears holding_cpu, dispatch_enqueue() is never called and
> >    ddsp_dsq_id is not cleared.
> > 
> >    Fix: clear ddsp_dsq_id and ddsp_enq_flags when clearing holding_cpu
> >    in dispatch_dequeue().
> 
> These two just mean that dequeue need to clear it, right?

Correct, we want to clear the state where dispatch_dequeue() cancels a
pending direct dispatch without calling dispatch_enqueue(), so I could have
just clear the state unconditionally in the !dsq case and simplify the
code.

> 
> > 3. Cross-scheduler-instance stale state: When an SCX scheduler exits,
> >    scx_bypass() iterates over all runnable tasks to dequeue/re-enqueue
> >    them, but sleeping tasks are not on any runqueue and are not touched.
> >    If a sleeping task had a deferred dispatch in flight (ddsp_dsq_id
> >    set) at the time the scheduler exited, the state persists. When a new
> >    scheduler instance loads and calls scx_enable_task() for all tasks,
> >    it does not reset this leftover state. The next wakeup's
> >    ops.select_cpu() then sees a non-INVALID ddsp_dsq_id and triggers:
> > 
> >      WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> > 
> >    Fix: clear ddsp_dsq_id and ddsp_enq_flags in scx_enable_task() before
> >    calling ops.enable(), ensuring each new scheduler instance starts
> >    with a clean direct dispatch state per task.
> 
> I don't understand this one. If we fix the missing clearing from dequeue,
> where would the residual ddsp_dsq_id come from? How would a sleeping task
> have ddsp_dsq_id set? Note that select_cpu() + enqueue() call sequence is
> atomic w.r.t. dequeue as both are protected by pi_lock.
> 
> It's been always a bit bothersome that ddsp_dsq_id was being cleared in
> dispatch_enqueue(). It was there to catch the cases where ddsp_dsq_id was
> overridden but it just isn't the right place. Can we do the following?
> 
> - Add clear_direct_dispatch() which clears ddsp_dsq_id and ddsp_enq_flags.
> 
> - Add clear_direct_dispatch() call under the enqueue: in do_enqueue_task()
>   and remove ddsp clearing from dispatch_enqueue(). This should catch all
>   cases that ignore ddsp.
> 
> - Add clear_direct_dispatch() call after dispatch_enqueue() in
>   direct_dispatch(). This clears it for the synchronous consumption.
> 
> - Add clear_direct_dispatch() call before dispatch_to_local_dsq() call in
>   process_ddsp_deferred_locals(). Note that the funciton has to cache and
>   clear ddsp fields *before* calling dispatch_to_local_enq() as the function
>   will migrate the task to another rq and we can't control what happens to
>   it afterwrds. Even for the previous synchronous case, it may just be a
>   better pattern to always cache dsq_id and enq_flags in local vars and
>   clear p->scx.ddsp* before calling dispatch_enqueue().
> 
> - Add clear_direct_dispatch() call to dequeue_task_scx() after
>   dispatch_dequeue().
> 
> I think this should capture all cases and the fields are cleared where they
> should be cleared (either consumed or canceled).

I like this, it looks like a better design.

However, I tried it, but I'm still able to trigger the warning, unless I
clear the direct dispatch state in __scx_enable_task(), so we're still
missing a case that doesn't properly clear the state.

I think it has something to do with sleeping tasks / queued wakeups /
bypass, because now I can easily reproduce the warning running a
`stress-ng --sleep 1` while restarting a scheduler that uses
SCX_OPS_ALLOW_QUEUED_WAKEUP, like scx_cosmos. Will keep investigating...

Thanks,
-Andrea
