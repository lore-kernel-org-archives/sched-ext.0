Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAA3AA19B
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365956; cv=fail; b=WdhqKF3lTkB2JhdCeNWHCpk32o9MPGqokLcZUwjrS2+CQnNhs/iJvcGMdc7mKxMhIczo98Ulqpwqf3kXrJEUdjIfRaLMAlM87hm94dTEGr4I0i6RgqSql57sjMH8uL/IC3pFBda2wzpno7vxNhfO+pEk0kqlBS6nZ/Pi/XRY96Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365956; c=relaxed/simple;
	bh=mxVkRGjFWj0J5FMfUo3DLWMMgrD9gTL13auntm44ac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1OKxgARDe1yqu1oH0deBnyCPN8Piwp+epXechENwMQ9mDf0pilxQZnrK6BBWbyD+B1rsfBxF/yX9R9pEjmYcSKfNwYuYjeFbk70RmT6CDg/oWa6wbYwltvhhvilFV7V181ODL8C68+wJXQssHWSaMJTe6mXoknQ0YgeyaAS+No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GI1cC62P; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GI1cC62P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EloofIuJ92YqqSn5K+F/4OVPF9jLn42DAZvfCakbJmosPTQs6PjEu0XYoU97670aS70Gw4TlG6ahS6AewjsszItqoJj9RHIHwgng+qDg3UgA6eGWYTR4x5XN/CtvENLAaaYNzKW7AQk88RuDwKKlCcpSXOVv8bZ28AyRM1fky3aJ8qUtvYJYF8G4c6/wlyg4Ywjm3QGvF5+bgSjX9mJhF1anNbQS2SVlmGK6h5zuQ7itFakeJrYgutvp/SM+fzMM2IPZZzBDiEcTjbGD0wtqPkxpd24uJhPJwiJdyYohUshFz5xiTStyrd8p7LiKxZlYld9As+q917bxCQaVIZv9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e+5a7KTmNPK/uzfAVJo7T/Zjv2p13OpHPz2+wCO8BA=;
 b=dAsZZCH6tCbjgfTby1yq2qS8kc3xdExQBlV+1qZUQg3VsLj+MzelWfgjPl/rb8+hBvxDnpjCU9t8H7OpPvHHgnOtlO00FzBLKqHJAi3mVcdW7KoeQZszWAY+M8S4LykwqoeYCRPWPQpGxMjx8l9HwiIsR91rLnWNJf6XcADl0HvZRB6K5arywc+pQNATX2enwP37pBKevaDbBTe4RmTh5jEizObtIglCHxhYfpE4o6tFKFPOG9njmYSQK7R2Lzr/nwK6dRZXiyL+9LLJBWLFgEGhuA9sv+N5J10SucUOhTl/N3TXEI6KB/mU5Dg7s00q3rMUJy8rCGDFekfjj2DQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e+5a7KTmNPK/uzfAVJo7T/Zjv2p13OpHPz2+wCO8BA=;
 b=GI1cC62PVGOjYj6m5EvbmSZCMrZkXcxwWp6kPRhwzELyWA7rLR8jY82TqUoCHGEWwS1Z9jbbpKcvx5RtI2m4LsKaww6xRnPB2ZOWRKzLJs3nD8yfN2OlEaSRtJ/Roq7/EAQp0JFWIvgH8LQhR1I3Ly60rqIRhxAV6AAz0GYeoIPrSZeUsV7CrxNRPoibCJT0ZgVaYy1PJN+vIaOSXF9g5i0gmjSYLscYOLA3BxMLLTxsQuG9rrxc/pPY/WnZAb++ZkbyeaKMx4j1D9hUHc+uep0HiT5IDx7gvJlHeEEuEv7eGVrxEdBpAh65oRDhJWSfAswkdcsuJ4CM9FxN/GOzTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 06:05:47 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:05:46 +0000
Date: Mon, 14 Sep 2026 08:05:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Message-ID: <aqeOsEWZpsCLqlKT@gpd4>
References: <20260911195800.974364-1-arighi@nvidia.com>
 <20260911195800.974364-2-arighi@nvidia.com>
 <050b21a95813f39e131ff1509ad76120@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050b21a95813f39e131ff1509ad76120@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::450) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: ac172475-1a75-4b6e-b061-08df12263781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NzYYtdF0jYDmSSmwCh1jWmoaLyrE5f8Czqv+/iWG0W+clH5fQlHtNDo+B5B+J+Ce8D7xKKGezxE4XbL7ibC8832eWbq594MSMxTz1/kCPeSU+gZ2WTDO4xcEWjby3kC73na5KgWlANaH+S+UhWnAQM22NO3lsTQRpAQSZlLyFaSG9P1V/hqvzZtQcnJZVNGJjj04iBa1SLcn1p3nN+NFcNDlfMqyret7+D+tUqb/t8gHf7y6CB1zuIqBb5aW/NpHkmgi60SsZA1RMrPbsl+wj5Vf5uOX29Ef87Ho7eJ74/XAlBca7vvXMaEpVqjBf6S5ILJfgBgY/4C1Eo7KysXeQx3DrkRxKpklmwZrL2votYTiRzdlOoOCUqmf9LwEFgMSjv/ucGzHksqtQuX0s3nwW+bFPD2ZCd+l0q4+Y8FgYg9UBgGdyH3js6+uYOXrvARXuoAHDsTD8Xu8hJLZ9Rs3hBAFDplulNvpnTTmYKS3mNwYgJkvQR4jZH41olpZXhow9G5U571vUhn0hrcaS+LA12QZZOPtQTpXuuI3O2PP7O43PEOgkgm1QWiymQIHVk2PVBc/kCAVVwZZvc21VRWaOmMMoWEdNPuuHVAIISg1rxikoucdP+CYEtviy3Hftcq0I6WtcN33pQAbHFeECkjIWbI22x4kprIhel/Qvbr4EcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/9ZioCekrHNbYEJPBStt1GiCxTZPA4Voe/KHOrkWQuCSwUlTf+3b5KYqEmRV?=
 =?us-ascii?Q?AHFRWIUanQGyiaDC+zJZSoW2ATX1ctql+SgXyWRIRmfUmfs7uxXtqgS6M+AI?=
 =?us-ascii?Q?ABVHeUhQrnYQCwvuAW6mBWeLfXg+i0nm8qsVQ8xRzyIHYMH/N/SKm5WThBQv?=
 =?us-ascii?Q?/8UsGkHmev+1uC+ArSTlIb/NUUsCXHB2uGeyNtmTFEs9d+H3RM2XNeAFD5FM?=
 =?us-ascii?Q?N3zo6sm5G3eHEjpVRAOFei8BAQHAKtmCgukUF2uJfNGC4vAAXZ1UXdwaKIKB?=
 =?us-ascii?Q?vyqUDvaZUYzRpWKEkr8OweniCaqta1XFzDAZShK+aXqjTcYZlIsvvxi9rFZ3?=
 =?us-ascii?Q?inh/Q7PclJUHof5P/ZqJv1ysrNKoG1+yGh6LYBsW+0W5ziI7rOSwKWlTTt9P?=
 =?us-ascii?Q?z2GIj8bx6CtLa0oyFthRkweNgbh24LvnjGSuV27k5HW8GEPf52RJ4iA/7+rS?=
 =?us-ascii?Q?Y5sPs5DPnznSe34pdFG5i40G3xQ8WloRKckf/VyW13L9q5jQ8BV16s9SqkTh?=
 =?us-ascii?Q?lfJkA+N/C7Av3nQ+y1ZhQ8kpnxnglUvRgcVD2/qDf+xqGec5xN8mkOaQsiAL?=
 =?us-ascii?Q?/VtXbM2gQepInq5qflT1HdBjREmeXe2nBRrkJRwPfO51XTM5jKJ9qWZ3rkFR?=
 =?us-ascii?Q?luSuT0RJMCE2p0KfWgBTjGqpiX+rseS8wDilpx2M4ZGlJt6iucoCaq8K1OhW?=
 =?us-ascii?Q?evw05OUY7HkJPCTKzVuQ+lS6h0Uqums8C/5TsTHZ+Ij8y9IWzC2ssGbJkLin?=
 =?us-ascii?Q?vYkLCPCbptuB5+91+9lKrsWtLLYVt8zAeqt/xnVYTfFMlY8kWWWX5lFEL7jq?=
 =?us-ascii?Q?zw4oZPXYis551anKbOlNT5uoDsxIiXozrNKvEwa2uGJ+GDxXUy5w+hyFCzv2?=
 =?us-ascii?Q?FBqVQFA/eJzVoJQagme2X8QAB7cYZqE/Syewoj4UYLGyi5zNg0l3z0jQV3ir?=
 =?us-ascii?Q?eaHoUJlLKV8ZVthTjO2h3Hbe50k3DFnchZVoavg9Bu6w+QKdfGb/Wg+y3V0f?=
 =?us-ascii?Q?zNGXsLu0r0nU5z//ZfvIiJEz7seqsq5No9WDPlo1dbCFOPcJnbrCGQseuoe8?=
 =?us-ascii?Q?ao2mso94gYaULheh0K28Yr7lswLxPf81BmrkXCx6LPH8U290a1d/tDvStY9t?=
 =?us-ascii?Q?nQIBw6wiz0MDWJ2Nh7espPxBWbQOIDInA+HBcSBXIjtOCz6wmj6CK1eTKM77?=
 =?us-ascii?Q?ZmGhEkbGX8McayBJf04ClT5Bz2xeeDgP2T9MibCWzXl2rEdQVfjc4EfQnEI1?=
 =?us-ascii?Q?rRyTnBmjnIGkhUcXLHZDah9EpW492cFtfl4teoLhHo5yeKoIcSjAkQ32yHbq?=
 =?us-ascii?Q?Tp0IU9MEP/st61TyWAwl1Rac1q/dl7Jug04MLao7wtNbQ/pc69FFoiEws+y/?=
 =?us-ascii?Q?P3vDM7+cNZX4jMb0dxqNtjrTT0q7mGbihDeoYDEfYOkwieMBS5V3/fgQx1tR?=
 =?us-ascii?Q?l0bi4iQU5tW7IQxcaNgM4/a/vkkOOAhdKnY8a+qRC4Y/RRHTrGkdjtOb2foF?=
 =?us-ascii?Q?+NGqjUI+XYRsKVUNbVYMAaX6dbpNGk2yIy+CunJpImKdgnvZTzvA4YZ2ihDH?=
 =?us-ascii?Q?ihklyioH5YRuZewycIO19SyMvQ8meurCedFlE3Ca1z9BQj1a3nuYlv+zzvmw?=
 =?us-ascii?Q?/VANfLDN5fb6Lcf6OGbrA4GDpScrMmw+0klH6SsbXYyeB6aytLcjioVuqzuF?=
 =?us-ascii?Q?mTmqZavKWwd+XCksHhshOTcBIJtfcc3QVg/zy9Q8QFLNFLfbdG3TLj3aF0ay?=
 =?us-ascii?Q?wlgLA+qMGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac172475-1a75-4b6e-b061-08df12263781
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:05:46.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGN3in3Loee1Y2HfpXvaq3iHEaW00z1/QmIH6rvWvxsH3SYQ1Mz5ytdfu6E+WSnx+XlgsGmGqkatiStKzBFO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

Hi Tejun,

On Sun, Sep 13, 2026 at 06:50:14AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> This mostly looks fine to me, but the kick path changes could be simpler.
> 
> On Fri, Sep 11, 2026 at 09:56:53PM +0200, Andrea Righi wrote:
> > +		if ((sch->ops.flags & SCX_OPS_LAZY_SLICE_EXPIRY) &&
> > +		    !scx_bypassing(sch, cpu_of(rq)))
> > +			resched_curr_lazy(rq);
> 
> Could lazy slice expiry be a per-task flag, with the ops flag providing the
> default? That would let a scheduler choose immediate or lazy expiry for
> individual tasks. BPF should be able to override the default in either
> direction, with bypass still forcing immediate rescheduling.

Yes, that makes sense. We can add a BPF-writable per-task slice-expiry setting
(e.g., p->scx.slice_expires_lazy), initialize it from SCX_OPS_LAZY_SLICE_EXPIRY
immediately before ops.enable() and the BPF scheduler may override it from
ops.enable() or any subsequent callback.

> 
> There's also a NO_HZ_FULL corner case. If a remote target is running with
> SCX_SLICE_INF and its tick stopped, resched_curr_lazy() sends no IPI, and
> clearing the slice doesn't restart the tick. sched_tick_remote() calls
> task_tick_scx() directly, bypassing the lazy-to-immediate promotion in
> sched_tick(). With lazy expiry enabled, it keeps requesting lazy
> rescheduling. That leaves delivery dependent on another interrupt, such as
> the deadline server timer. Both the kick and enqueue paths need to arrange
> progress for a tick-stopped target.

Good point. We can add a common helper for lazy SCX rescheduling, when the
runqueue was allowed to stop its tick, the helper clears SCX_RQ_CAN_STOP_TICK
and update the scheduler tick dependency before calling resched_curr_lazy().
And setting TICK_DEP_BIT_SCHED will restart/kick the tick as needed.

Both the lazy enqueue and lazy kick paths will use this helper after
successfully clearing the current task's slice.

> 
> > +	if (preempt)
> > +		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
> > +	if (preempt_lazy)
> > +		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
> 
> Why not clear both masks where cpus_to_preempt was previously cleared,
> including the skipped-kick path? There's no need for the additional
> conditions here.

Ack. I'll change this.

> 
> > +	if (unlikely((flags & SCX_KICK_PREEMPT) && (flags & SCX_KICK_PREEMPT_LAZY))) {
> > +		scx_error(sch, "SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY cannot be combined");
> > +		return;
> > +	}
> > +	if (unlikely((flags & SCX_KICK_PREEMPT_LAZY) && (flags & SCX_KICK_WAIT))) {
> > +		scx_error(sch, "SCX_KICK_PREEMPT_LAZY cannot be used with SCX_KICK_WAIT");
> > +		return;
> > +	}
> 
> Do we need to reject all these combinations? PREEMPT should win over
> PREEMPT_LAZY, as it does when separate calls request both. WAIT can force
> immediate rescheduling. A plain kick combined with lazy preemption should
> still clear the slice and reschedule immediately.

Agreed. We can accept these combinations and apply the following precedence:

 PREEMPT or WAIT > plain kick > PREEMPT_LAZY

A lazy request should still clear the slice when it is combined with an
immediate request. And I'll make the enqueue interface consistent with kick.

> 
> > +		if (!cpumask_test_cpu(cpu, pcpu->cpus_to_preempt))
> > +			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);
> 
> [ ... ]
> 
> > +			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
> 
> Can we just accumulate the requested bits and resolve precedence in
> kick_one_cpu()? That would remove both the guard against cpus_to_preempt and
> the clearing of cpus_to_preempt_lazy.

Yep, makes sense.

Thanks,
-Andrea
