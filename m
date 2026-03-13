Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80B346E7A
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429726; cv=fail; b=JUuO62MPisvx/kSBWKlRioGiQ0oiCjQvI6H7tFisczA1TAQcS6BsfHlJdQWiHUlUS6meyGRx2wy0AY02iVwsq5mfAEPw8xqN4a+ztoUpiSPcJbCbXOCK5IwV2qG/qV76PoBDnXczmZfu4JeT4rwDlAhKD6wl7pO/zvxDXzbBBLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429726; c=relaxed/simple;
	bh=KLDLWfew9Ph0pBvp7ka+YyA4gBB8eOi43e8ii6rVXfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pa5YkMUej7Sg58EDAzgrhFPfvNZo9c9P9AkrkvhhANVzQUg6/NcRMdZptnUTuKkX9jS3E1fzoKXZc0BeWF9sr9rxVntavBsJhCazDyeD6X5WxkfOGnRkRdo91oJcv1z1pES75JIFpABBUpDmkUSFIBnJV5oIEB59yzJk8kED1dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KLl64OKO; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KLl64OKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idOwWMfo1Y4C3a/UTSPP37vTLa3Fh+rSunWfQyf8x5uV9zlNFgpw1zQFxDRJK1c+PySF1UVXSzF2uXn95PdvWEyL85Wn8y64P4FNaeuq7pZ9uZTYsJaW5BrsOuOsXVbP5HLsNE1f3NKjG96dwLNjTKcg5AXSyYP2fqTBBumL3dqE47mGSQgmaXqvzcgwQvjtfHcne9cIMdM4ZUojwOS2ZBBbu2AOM8aRa1M977BmkHC2zbTSHpiwE7YIP2JKfWf3fXS9N0T+dcuWqAEdZIeqctHsqT9Mdq7QQYUn/m+hifr4V3iaM/DPZW51913tAvdcyedLHpoGCxKeGFo3okqD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY2lVUI2x2jOzxIdTQyocp6W0H53z9ynd2inEvogLds=;
 b=rligC/Ghj7d1PbhcEdLRdxtajCk8QQ2W4Sv/Ral4alNKMgn72oeNcYPgX56btWbdep0LI/31VoxOewblYiDQR36DFlmqKdAW5abMP60yuIwDQWFMUr4U7CWcnhm0g2eYA1TyGCZ0ZXG4myWcw5d/aLmGdrlxuA8nUd8Gaqo4lrDQiOCbN4AQhwA0Rt6PXiwqhelitvuPqtexKMYNsNFmbMfzSB6y4mt4ViDiCimhLLc7/B76nP0oww0mPgdE1uc6xDu6dZ2/x8IiyPxFsfvhyViGbrn8Q3X5bNDrcOD2HPyvdxFLS3wZf50aQW/E4fFMXXQehuNCiIqOb6/LRxZJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY2lVUI2x2jOzxIdTQyocp6W0H53z9ynd2inEvogLds=;
 b=KLl64OKOVWzkpanGdG85MdyLFaHyZSxay5Ce03IynJKGff5mgwzVIxqHWQNp0MpSk4ShhC/6KoJoxJHjrL4Csm0MuJsTKsAs+l+SHo12hZT6I07UU8Fk2Kk63F27BErMnFuwd4AUl+7aYVmwR/suLHBreMhDVJqsIR1yjpOzacE6ThDIsI7JKeSNJP9kNlH09C4VmcEwm1Ot2WdC4B1a4I5qpqoYCRw+7d+YYmB7NRz+bN7Ow5BXGYAO09B4HiVtgOMtPU1lPgyXHVMfv97MIuWgtEXlTTJH+pigSLYsy9rr+cyFggrxm2iG+G2s1JTLFdcIZovdTULTcqaKhYekmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 19:22:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 19:22:00 +0000
Date: Fri, 13 Mar 2026 20:21:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.1] sched_ext: Implement
 SCX_ENQ_IMMED
Message-ID: <abRj0b4CKMnuwjos@gpd4>
References: <20260313113114.1591010-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 84967b13-4fbc-4ded-a734-08de8135cce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6JawuV96p0aTZV3U/FJzGJigQggAGhzFK8p0ynFoUyA+fO2gtukRrGKJHZsRRkVQ4stpxcvzApJ1/Tze2D2c2EoZeAlru1KaoHDCO5Do0+QwL56K/vFEnMNJl4MTpl132mpr/1CUrcKeVqPxN3wxEyf4GwEkxfmCGDo4Tij4yWwyGhaOL1Ef+1ArsQxEbbc7NxDcBsb2fK9m2AdMGc7zSsuu0ZBB/ljkLt21bao4MZJ1CBlC86ZSA+nw3w68chBQqgsTCQ60jUcFVdmchYbDUvUZ0vab25VDiWCGgw7OYLNiXvhYPVLEud8M4G8Vxll0JXP+rTdazkS5rI/JC1uWU4gkMORGJR5dd4LcJ93hLmJyyQnQGta3AubRrR/79vVaSlIXAJirkaZR3eTp2jvZiJCRsqcJGvouwQfyp93o4Li/CFfwhvHI10tBG+5Aq2AENO7hy/TqnrcDZ3z1KPP6LCzR4t92iiLUbHDXZJ0E4uryBy80JTsEkpJ8TOtucRElbOxcpBDyA479g11gLJJgucFIHuf4LuQYFCjrCPIEUTQsCAkb89SgWXCQuom5LBn/3Laz2L6fymqBy9wpneahde8IbEw4sdy17HjuymZQzkub0WM/uNcofRUimjEq7FF7NrDiP2qNCD/V5ZxDiNCo+1b4hfJswhJrPFTDRx4uV2ZbJ7UVHyYel0FrzKsksTYhDe+wBVevtD89slkbHKqJcSWN7smA/j2IzyywXeLkQj466lEzGWDfi2MhlkStmZnH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Xv6fkhU/wc0NPdyUTNU2rNKvi1MzkW9lNgVW0M9L78nqtWH5Xed9W4JteBB?=
 =?us-ascii?Q?0CZzBvkD8L+/YmRdYcJs4MKGtOzMtV0kBUsRMnw6UbaxH0pfiDj2awkQGMH1?=
 =?us-ascii?Q?IuFJ6KNwsCfUbt8x2CbjMmr7Wz+xl8nBzECSwf3NzxhyFGCiUMHTE3a3M/AG?=
 =?us-ascii?Q?hziI95vfMGRToTvGV8BbQy4HJmk/d83GiNt1XNja24Wm+nf2XKlWyCyXkOpE?=
 =?us-ascii?Q?uBE1sQ7lz5pTI/ZuXVbQFbvHWQv7Ki31X1QZAtrJ3aEX8Wm5Y4NKDqOXSefX?=
 =?us-ascii?Q?OHV+edHL4gTdEZlQ1hUWPHB6cqh/RUjxiHMuV2uyhp1usmoIGEpvK36RuK2Z?=
 =?us-ascii?Q?w3EzzR8EMFN+7vhILg9HfiHJ73tvXuUkGUPO5c3s8vQ8AD+dj3a4wpNRYuV6?=
 =?us-ascii?Q?9e0bM2mJOa/iwE+w6wgBk9fFgXhwuIKLlmoGYDc0FTJ4Wxfb3OZ8skPmr1ZX?=
 =?us-ascii?Q?XZSZKLfPc7mQ3l+jSgz0rd0XKXx1IdpsZOTu/uWeYwEOhHf+hoEPEQ7ktjY1?=
 =?us-ascii?Q?4qww3QuWlqnG7NQ53n35Qwp+dQmq4wVI+2Ra3oANOElqdYRvAGfat+rjrQLS?=
 =?us-ascii?Q?s3hPWEwJNIlRvQ6p8JJZdP3tjU6LIpT4EJ6fTKtLJ4XhuNE00NoYs20mXUwL?=
 =?us-ascii?Q?Z9iD+bbwFoEkqQqqX81mxNwSRoXj4Nt3MnKI2YNeMOqpvnLZm2fXSAAHMffG?=
 =?us-ascii?Q?j0aIg744b6pRhIIVBMUh7EbZ+432TUvMYKFU9UBZC+JQVZD4ECYwIojUFonw?=
 =?us-ascii?Q?N8lG62yTzkzl4CawjLzEBcmO/xGgYcxlfw+i5mYYDj+Rqxtq447rj8PUXJGc?=
 =?us-ascii?Q?affuEk22iIzS0gs8SGngRZU9tvA+ZZExIty73uXrSYh1Mwr4Dz6XcnVAp7zP?=
 =?us-ascii?Q?+zvL4/nKmi+4XHDyCuHvuIpZhbmcFwGuBA8GK7ty62H/kbMBenG7/X/JeM7E?=
 =?us-ascii?Q?uAoc9Ne1aZQvbkymA1hgPajAVQLXJuh1OohHt27NM/JXjU/okq0KosU1SxZj?=
 =?us-ascii?Q?S7imJPnvtIOxsla5DFBtBoilVQo8/OGb2eZraANd1FtnSviuS4G6MPUuMBtI?=
 =?us-ascii?Q?qfufV7dw9Z2lBnMq2Bn9mCNXoXQ6m5SWbGdZBgKZfzUpviq+e+dUqUa+KoB6?=
 =?us-ascii?Q?Cg0SkVIrTTn8o7B/1C+CXuS6xInVuFwAFiWsojvFalO3KXIUfXpFiLYzgTrp?=
 =?us-ascii?Q?jKwoj3NaOAFXi23aRz+/TXb4x0KYnl8m+vXVZAfUdNvjFHEJ6Ee/u9Je4HYC?=
 =?us-ascii?Q?DKVgA3GyDKybOnykbbSK03XtPXmR/FKFeTCI7zCxl47PnVbg7B+pIq8qjB0n?=
 =?us-ascii?Q?m6N85i7fdkp1y/LElbdthoiB5u5a+8RAM3x1k4vGUPCphQ76EXhSeEx5CdL4?=
 =?us-ascii?Q?c4xs0wfCDzfyhIMCTiVy+1SRxXFGAT7YoZjf25oHS3n9cfVS1xcqnUCMokoS?=
 =?us-ascii?Q?gluvsHNykhjI/GRNYjYQRMcs+U6lFbzjBec+O/DxHJo8kq4nnKo6aqUEC2hA?=
 =?us-ascii?Q?fBKpR6jYNwRDpXuXHwBnymx9hC7DAIfesBndB33wXUJWLbh5BH4VGa3puyEF?=
 =?us-ascii?Q?WIP7GHM9lt5UnX1JMgmK/DT3d6a6TBTM05uEF/wrBkQMXyJw8btQRNyHEI2u?=
 =?us-ascii?Q?JzFlpq6Ao71jVeAfLyKYKk09WxGhXyno0xKDeBuXunixLokRHEoSpqT80G85?=
 =?us-ascii?Q?avImtc4Purkib2WXCOfNaBBZ0tjkYaGtZcnSkAhvvkXZfX/hEqxZINkoJ2Os?=
 =?us-ascii?Q?Uv4X9Ys5XA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84967b13-4fbc-4ded-a734-08de8135cce9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:22:00.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY6jOzh884wno1B2kYP07wRNHAZiUs8HDxO8oL8FwtKmcANVDLK+wtQX8qO8l/xMr3qADQe5d+oz9G8M91Uy1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

On Fri, Mar 13, 2026 at 01:31:08AM -1000, Tejun Heo wrote:
> Hello,
> 
> Currently, BPF schedulers that want to ensure tasks don't linger on local
> DSQs behind other tasks or on CPUs taken by higher-priority scheduling
> classes must resort to hooking the sched_switch tracepoint or implementing
> the now-deprecated ops.cpu_acquire/release(). Both approaches are cumbersome
> and partial - sched_switch doesn't handle cases where a local DSQ ends up
> with multiple tasks queued, which can be difficult to control perfectly.
> cpu_release() is even more limited, missing cases like a higher-priority
> task waking up while an idle CPU is waking up to an SCX task. Neither can
> atomically determine whether a CPU is truly available at the moment of
> dispatch.
> 
> SCX_ENQ_IMMED replaces these with a single dispatch flag that provides a
> kernel-enforced guarantee: a task dispatched with IMMED either gets on the
> CPU immediately, or gets reenqueued back to the BPF scheduler. It will never
> linger on a local DSQ behind other tasks or be silently put back after
> preemption. This gives BPF schedulers comprehensive latency control directly
> in the dispatch path.
> 
> The protection is persistent - it survives SAVE/RESTORE cycles, slice
> extensions and higher-priority class preemptions. If an IMMED task is
> preempted while running, it gets reenqueued through ops.enqueue() with
> SCX_TASK_REENQ_PREEMPTED instead of silently placed back on the local DSQ.
> 
> This also enables opportunistic CPU sharing across sub-schedulers. Without
> IMMED, a sub-scheduler can stuff the local DSQ of a shared CPU, making it
> difficult for others to use. With IMMED, tasks only stay on a CPU when they
> can actually run, keeping CPUs available for other schedulers.
> 
> Patches 1-2 are prep refactoring. Patch 3 implements SCX_ENQ_IMMED. Patches
> 4-5 plumb enq_flags through the consume and move_to_local paths so IMMED
> works on those paths too. Patch 6 adds SCX_OPS_ALWAYS_ENQ_IMMED.
> 
> v2: - Split prep patches out of main IMMED patch (#1, #2).
>     - Rewrite is_curr_done() as rq_is_open() using rq->next_class and
>       implement wakeup_preempt_scx() for complete higher-class preemption
>       coverage (#3).
>     - Track IMMED persistently in p->scx.flags and reenqueue
>       preempted-while-running tasks through ops.enqueue() (#3).
>     - Drop "disallow setting slice to zero" patch - no longer needed with
>       rq_is_open() approach.
>     - Plumb enq_flags through consume and move_to_local paths (#4, #5).
>     - Cover scx_bpf_dsq_move_to_local() in OPS_ALWAYS_IMMED (#6).
>     - Remove obsolete sched_switch tracepoint and cpu_release handlers
>       from scx_qmap, add IMMED stress test (#6) (Andrea Righi).
> 
> v1: https://lore.kernel.org/r/20260307002817.1298341-1-tj@kernel.org

Only found a small typo in patch 3, everything else looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
