Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1736606E
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425621; cv=fail; b=MFoYaYZy3j0IPVA/u+8oUOpzI9Y3p1hmBYs/wMdDc2S5QjVtOkPNc9CV57sNIom039ZOVHsPlPblaw3IZ5ww0zlQ240iQ6rruJqIOq7rWJ+WViZNOYMjqi9Zgusl4jLUWo2O/JtCGxQGc/fA1EpFL+Q7VP8wSuFJeRVjKCU9MDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425621; c=relaxed/simple;
	bh=DGvntquMA0bwv+Sxwbg2OlcORtx8wKgX2w3O8/PGWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KY2PP7H3/tycr3+KOATdoooszbtVX62B9V9JJUC5CAymHsHklIkBmYeQaCtJLskZvGhV7HfpM/w1840bT6xMrRmcJ9iOfxXIXcn/jbF6/eq72So9paFAuEKOjo3T03ZiPYipvoFpYAeZbX9rKGCpWFuXfnKSNo2llIrCJeUnPPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Np0+JqQE; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Np0+JqQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIK8XDSP7erextD0WTlPkz5+8EwPesdHOVQzlGAIEPzm2BJiy1qL59dDSzOSpifQcVN5pmPnkMmYnFip/UoCWPUOa2aMSoAAWyUi0tEAVui3IasXBzLH3KAVFf4vCr/vKbCKC+tIcrgqylziV9zlpQOC+vyaGfpeRtl4M/vPlGsLhiZp0oQK0PJlOgCPd2gYynDHrqdNgN2yHAfIwDuY1m4LCU4xjqLvYvMcqQtdBxW3sZhshSOtHRMfwMcIGgznt8WxsW7tx0CaTN4zjt1hLBEZgJjFWfFt6DXV9YLrzIxZtUQv+0DFtW0v8Izng+HuJ0aPGB7ZheG4XGiPWxvJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05lcrK/0AFCglRwB+Au0cE7nQ2NwRdDGhdxaWWOnWWo=;
 b=crRDsMYyo3MzYVfqUmW9IzS1tOAaqPsA/uCE1eD+QP95UZxcrKhMnCMaToa4POcYo/VY8fjR3h+L6Ug1MiG8r4I7J+LUrmnkDkHeOX87N6UU417fPeQLwvAPYMuhCEjV3e1pAlnMREe0/zi+KsQ6qohNTZWoIcq9qpTwlM5UG0c81CLA91Ln1CHG6kX2Br4ikysICzG5bVTDzbfbVNX5+hTu0nI+CMPj92k/xWhFi3GS0H8QyikYHSEwASDyrjdm5ZOX3f20m5mYtIkwL6Pm4WRmewK0aSw1/h1nshiSajSxM+pIVlUyybb3Oj1wh+GMXl3gaFFKReGHqaxHol23Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05lcrK/0AFCglRwB+Au0cE7nQ2NwRdDGhdxaWWOnWWo=;
 b=Np0+JqQEa2iiZh4x1To4lihxlShzuhhMYSbarewgv0Ly4BfavHfhbfyfiRMuS3nxRQHxk/Nh8I+Q0xSZkKgW72cQ3HyWg1K6FpFbQHWznHX4JUULc8P6euau/A0fZ45V3Pc4LcDI1Vy6c+8XR6zcyRgIbwEGDA0dXFkxSKNseO6ywlTBTEyxJGY/p30UJujmVxTZXLbmB1aMjrGREVz7cG4EUGWYAMaLOibf5u8bExZKZU9YdEGle7kaK0wTK6IPonRHqv4Kasjos6xCo7rKw9gxo0dg3+QYopb7/VudyhDdQhQer7UhPOqDtdjmctU1zm22RoAa00o/Ek3wQqY7jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Sun, 10 May 2026 15:06:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 15:06:48 +0000
Date: Sun, 10 May 2026 17:06:41 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, jstultz@google.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	christian.loehle@arm.com, kobak@nvidia.com, joelagnelf@nvidia.com,
	emil@etsalapatis.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH sched_ext/for-7.2 0/10] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <agCfAY9zqrQiKAJ4@gpd4>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260509010059.345908-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509010059.345908-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B8C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41a) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: b649e1f1-1a96-43b6-237f-08deaea5c21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	teV3lR7TJMsu51R3/ASxyLToVvoviBws2eocRFY7nK8L3o57AZ2/Dke15/xo3Co0d/mOsFBUcEVE5LFI62g7H6j0E/KVA2ozsX9AF03creGsMzTBMzHA0iO+mKDFGRY63WBOGpvRZFZX9VNNxLvjBue5bvOwT5lV8W8/NXdAwQ/lByj5E6KVf+tTtj8WG71m0i7rXgqBugu3zxORFEBFZiDOX/b+bImcUCt9a7/gdgsv63jvsJhZkpCtsNSFwnmC3pFBl6KaCqDJKIglKaa60QJGPpIgoWdXrcKJKoACd2tmtTgK2/g+CoZkTVY8Eo3nWApzmYmuiY7+7Do97yx8ojgosM0HoICke6xEesmBQQjRL91D5UNJbYHE1h7WGM+J1Y0DynkOwDuije3UW1B35pIxnpM7chfVox7BzydrtEEfOgW13BpQ1SvpXwpLN5HJ1FcA30ucTWqUnA+nmlG0QgsETy12VNBfS+2IvMQztBOANFpl1ca5/eqxmic0/Cj7dc7gdnJfKc3hG4onLhLbwVKyUloFzfMReRCJlu9Bg3b+kFBZUTJTLuzh+6kwIMhCFROhxlJY1A5l3d/iyfsSF5Fzo49lcVIaZaHHn2gm2D1EOLjICtnMbjslwfFLKfVLCDWewueBDZLfpaB1KAUDiL38VIZlFUnTocdzCktrXTIFJ7LqGx5UOheFmeG/Lwhb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVSJ+Oc+xr6397kmOkX30vsPyl6wZk0CJKSE7Sx5PAedUG4Y6Am48f/00Aif?=
 =?us-ascii?Q?2wfiq6JhRaQYrMi8Jo7y0RGjqVy9EEvtNlZuU8lsyVTogs0YrWQQbsKSYPeo?=
 =?us-ascii?Q?3pslWtZvdRkGWXAvSMkKYbHcgBHvrifn0aSARfJlhyjcUgBeSFyvbcd7xYa7?=
 =?us-ascii?Q?G3wP3kdCUSLNmZoOyLogHJTgQiyD1wh65GSAiMd0aVRF5Am++j+LVbTYdSnO?=
 =?us-ascii?Q?Cna7d0nYY15674Gr9Jzt5/06ZObEqD0rbnWfIRPCfHRf6Sr5JhbIcq4iKBnt?=
 =?us-ascii?Q?tmEURGU/HEmmdG27SJfqSf3Mzi5TF8lJYvLzqekecgvUDN+BFk1aGMlx9eR3?=
 =?us-ascii?Q?dBIH2xhqxBGCrmcrviojKpF7eg59ZXbodG/chlikVxKEbekUuVamnXRcPiqz?=
 =?us-ascii?Q?e82gtza0DDhHN4WkV2JaC1dIGlrlM+PUf+I8FnYjc8NqLuxK0M912H6yimrL?=
 =?us-ascii?Q?jh57qOxrsb2djxGPBQY1vETbDW2UbizgMWAXIG6FJToMw1Lf5m7k7bTM/roL?=
 =?us-ascii?Q?q0kVlRXps9LU72UY1R4A4bcxzER5naYnpLgHYxJZx4bNvlhnkP3Wl/yzrKk/?=
 =?us-ascii?Q?8w687ZkJ8kfoQl8HEghdejlJZME/1zP5EadNGqQ9OPrnCVIj9kKhpuFPAxdO?=
 =?us-ascii?Q?CbHLkGXiuXD4xyvsh6jmZr7Cx2iF1Dady77e7JN/xCqozjkz6FUZxyuYfUf5?=
 =?us-ascii?Q?m0aI6Xq9HrocAMm9sn/fc+Z8POJY1aeWaUBFYFLqOmjOxehxnQKhKvwNcKYB?=
 =?us-ascii?Q?Ag5XKo7BjId9+Rh1nj0bkAnRn+N4Cv/RyhYreshjlMs7F/RvknP6CZAx5H5t?=
 =?us-ascii?Q?jXBXa1oolgFlC1B8fe0ckHq/Qd2D8Rh+mrJCcWnwEdoRKrgvzouGfaShPVbj?=
 =?us-ascii?Q?xiLvmNM7Msvj0F3OCVb3f+HVLjcJeXrIJS2Wp9r7dN9LOPtBxw9ggkfRSmL8?=
 =?us-ascii?Q?9j2puit89A2LPBOm6VPh22y3lke/afj5oWUvKwVK592de8ciBNeWhTI3469p?=
 =?us-ascii?Q?w0XCBR9fW01Y9D8cIqwHyMt1uQR195uW5qamzcw0xWqCGMTlqY8Sj59EzF0f?=
 =?us-ascii?Q?TbBEP6YdEYPsX8ju/X50x0PRPue0c+SrxCv+mu5YtSfwAN51C7il/i7iMMh3?=
 =?us-ascii?Q?EkQKe9VRI7jEbhdI2wKYOCzMwWYvgAJQhgg7M3VvP020FxfaIUrRYdye56if?=
 =?us-ascii?Q?bCkGkdTPe6/xX7PqiWNQzoVLWA+2Tr2kZae1CTOJ4Y/hQnHsfb2/ETWvtG3M?=
 =?us-ascii?Q?ohUj5Juts+8mFaeg02Aj8pnJeRIDFbxbq8YTEw143A16IAAN4pAGYRl3RsVf?=
 =?us-ascii?Q?iNmvDWiwrFtF2hrNDoeyDewVBKaiuFn5oYynIjp3eHaKENWscbYp1zvRKPcy?=
 =?us-ascii?Q?SpX4nYKv6CpQaD+9NP97ORm1TW72/k2Kd8HUHXb0IkGWfWn9th+NXTNHSsg1?=
 =?us-ascii?Q?pnpjLw4O3AkWw0B7s6979DPTNAyxxRt5oMdbyhU5ZJFE7/U29XeG94S6U3Pg?=
 =?us-ascii?Q?Y8VNmuuwl0k80fJidLPYAR4JrJUhyG/OW45Tgw8PN1YMna3iCJ1mWJ88xpPI?=
 =?us-ascii?Q?NSHkSgEzvnwOByKZCZ1+x7AvtCLe73hgcCSb4SzrSbUwYCkAu0iwGt5pfRlD?=
 =?us-ascii?Q?alFsPHDnj2xfv2TjeQweC1PgiIIED2oGZdYc8F5HmdbZ5mWKt3Wm1Z5Gv/dN?=
 =?us-ascii?Q?iATsxoIsdR4fNSN2ZDudE46+0EPRxOtcm1/4DoC7zm2PTBCYH/gCPmTIn4Hq?=
 =?us-ascii?Q?Ub1JoU5P8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649e1f1-1a96-43b6-237f-08deaea5c21f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 15:06:48.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtgTctC4TZvzlTtZi0dzPfcnAYvTtpV+zaTK/Lt+32h8Zd0+pE0zGO8Ygc2FPLLFqzTA70LSmhBtA2g3NQa0JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

Hi Tejun,

On Fri, May 08, 2026 at 03:00:59PM -1000, Tejun Heo wrote:
> Hello,
> 
> I'm a bit worried this is more invasive than what it buys. Even with
> the full series, the cross-CPU gap Prateek raised stays open -
> find_proxy_task() doesn't go through put_prev_set_next_task(), so owner
> runs without ops.running(owner). Closing that seems to need yet another
> protocol on top, either synthetic running/stopping events or scx core
> taking over dispatch_dequeue for substitutions. The BPF scheduler ends
> up dispatching tasks it didn't pick and observing callbacks for tasks
> it didn't enqueue, which feels too magical and error-prone.
> 
> Maybe worth considering an alternative where, when scx is loaded, we
> just turn proxy-exec off entirely and expose blocked_on to the BPF
> scheduler. Schedulers that want PI can implement it themselves on top
> of the relationship; ones that don't pay nothing.
> 
> scx_enable could flip the proxy_exec static branch off, after which the
> existing gates in __schedule keep blocked tasks off the runqueue and
> skip find_proxy_task on their own. The remaining concern is in-flight
> donors at the moment of the flip - the existing scx_bypass walk already
> visits every rq's runnable list during enable, and could force-block
> any task it sees with blocked_on set. Mutex unlock would re-wake them
> through wake_q normally after that. blocked_on itself is set and
> cleared in mutex.c regardless of proxy_exec, so the signal we'd want
> to surface is already there.
> 
> For the BPF side, the natural shape seems to be tagging the existing
> ops.quiescent and ops.runnable callbacks with a bit indicating "this
> sleep/wake was a mutex transition," plus a small kfunc that returns
> the owner of the mutex p is blocked on. A scheduler that wants PI then
> records the owner in its own task storage on the quiescent side, boosts
> it via the existing vtime / slice / dsq_move / kick primitives, and
> drops the boost when the runnable side fires. No new dispatch protocol,
> the BPF scheduler stays in charge of who runs.
> 
> Does that direction seem reasonable, or am I missing something that
> makes it not work?

Thanks for looking at this and laying this out. Let me try to elaborate more
about your concerns and the alternative approach you're proposing.

On the cross-CPU gap Prateek raised: you're right that find_proxy_task()
substitutes the owner without going through put_prev_set_next_task(), so neither
ops.stopping(donor) nor ops.running(owner) fires for that substitution. But I'd
argue this is less critical than it looks:

 1) For the ops.running(owner) side specifically, I don't think skipping it is
    actually a correctness problem. With proxy-exec, the owner is not really
    "the task that is running" in any scheduling sense, what runs is the donor,
    the donor's slice is what gets consumed, and the donor is what BPF
    dispatched. The owner just happens to be the execution context the kernel
    uses to make the critical section progress, more like a function call inside
    the donor's quantum than a real task switch. If we frame it that way,
    ops.running(donor) + ops.stopping(donor) is the pairing the BPF scheduler
    should observe.

 2) The cases where the owner is on a different CPU don't go through the
    substitution path at all, find_proxy_task() either migrates the donor over
    (proxy_migrate_task()) or proxy_force_returns() it. In both cases the
    receiving CPU's __schedule() does pick again, so ops.running() fires
    normally on that CPU for whatever gets picked next. The "ghost owner runs
    without ops.running()" only happens when the chain resolves locally, i.e.,
    when the owner was already on the same rq's runnable list. That should
    narrow the surface considerably.

About dispatching tasks BPF didn't pick / observing callbacks for tasks BPF
didn't enqueue: point 1 above is essentially an answer to that. If we treat the
donor as the running task and the owner substitution as an internal kernel
detail (a "function call" in the donor's context), then BPF only ever sees
callbacks for tasks it actually dispatched.

That said, your alternative proposal is also appealing in that it gets sched_ext
out of the proxy-exec dispatch protocol entirely, which is essentially the part
that genuinely is invasive. But I think there are some gaps before the "BPF
rolls its own proxy-exec" model is workable.

Let's say we expose blocked_on (and a kfunc returning the mutex owner) via
tagged ops.quiescent/runnable(). The BPF scheduler now wants to boost the owner.
What's the actual way to do so? Some mechanisms that we have right now:
 - slice extension: scx_bpf_task_set_slice() works in place, but it affects
   only a running owner,
 - dsq_vtime: scx_bpf_task_set_dsq_vtime() updates the value, but for a task
   already enqueued in a PRIQ DSQ the position in the rbtree doesn't move, so
   this doesn't actually boost an already-queued owner.
 - DSQ move: scx_bpf_dsq_move() requires an iterator and the task to have been
   queued before iteration started. We don't have a kfunc today that takes a
   task pointer and atomically yanks it from wherever it is to a higher-priority
   DSQ. We also have no API exposing which DSQ a task is currently sitting in.
 - scx_bpf_dsq_insert(SCX_DSQ_LOCAL) + SCX_ENQ_HEAD|SCX_ENQ_PREEMPT: it probably
   works to run the owner immediately on its CPU, if we have a way to
   re-enqueue it.

So, to make the BPF-side proxy-exec model real, I think we'd need at least:

 1) A kfunc that returns the DSQ id a task is currently enqueued on (or
    NULL/SCX_DSQ_INVALID if running), so the BPF scheduler can locate the owner.

 2) A kfunc that removes a task by pointer from its current DSQ and triggers a
    re-enqueue (or inserts the task into another DSQ).

Without these kfuncs a BPF scheduler that wants to support proxy-exec has no
concrete way to actually boost the owner.

If we add those primitives, the alternative seems reasonable: scx disables
proxy-exec, the bypass-style walk you described handles in-flight donors at flip
time, and proxy-exec with sched_ext becomes a BPF-side policy. I'm willing to
experiment in that direction if we think the primitives above are acceptable to
add.

Thanks,
-Andrea
