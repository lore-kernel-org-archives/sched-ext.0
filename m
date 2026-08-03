Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF03AB498
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744657; cv=fail; b=AzX3VD9z64lW5/XPkn0hXoBGcqZ1pwNmtGB8OefGP9Y/7GqZ4Aw+qjVXGcPi5vKLq2XmNgMH1h0hLqb7Sr2ChRmOV9oyxjkmpGElRB5aH2FuRxafOAwMIt8N471n7WvOTOQIuA5btbea8Rxfjdhsrt0W93mWVnshwGDxLSf65rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744657; c=relaxed/simple;
	bh=gy7H5+oippWF7QWPb8XIQvaHqpzO4jC62y1uHp5YEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QkEDjoGD7i8akMtQzZ1wM7e/usw0A1Z/voi1n/P7GkfpQz1hisk+Xg4QAV3IeNut7JXpF+RyEacZD1MjqREwubPEAjRNkbsSY9HfUL5Ydlz8EZUzdzh1NM86aFadp4IMIerhBymQYN8GNy2/HjaDLXGpcgHe2chvBcP+eM3lsLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ab6AnYwi; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ab6AnYwi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywyqLXoc6x1uTrBZGo9GWjVWFdbZA7vTtEn91huT7aIqMMEjn1PKvPw8lu65mAj5Z3308CvEKYjun+WAtzY9X9HyIxEpUN8SzLEpH0fBm5nPF1l7Pn7r9T3czWGNMkdUyZ4ldtYY66G7++iu2nEIblQLl3UgmqpXLkcdRMeFr4VgQdAC0a5/VKNUZfku2XJnhKKz7OhPCrq7xVEFGkyRpUseczvjgFCgVcur4kRz9BB0TYA265YtGyDX/edFkhfZMFrQGJEeR7Yy/FPVghJWVDSqjCsjiPqVW6sfGhDVVp/vX1Y2xmTjX/Lg13hAhtDX1UgQeUG1thGJ8OUc0UyJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfwIaZjHKgc6pIC09iEhYUjW9i4xdxEhUAeWx5q3TS0=;
 b=egv5x/80v5yIGoyvnE8pC93GAYx7EZXdOGpLv2KFWUDfeMcjCRycLTNw/HY53oBSwRgyG4kSiNNgniqbpXxJINN5qgB4z4G15zZ+8yP72XRvWnpUIe+3Qu7+oe+bD6Uw8+RnPQLG3AwiOgcaFNJ5tfQF5CAP5EFDf+QzPWCqOXWMIAQ5/KfxC07KmofxND+TqFaAlDu+7bfIDiL5LWNevuQ3Atku1n+FpUrOTj5xsLeoi+b/S7UYBJ6CJeKxi/IGS4cy0xWlV3OszY++ru7k7TZVkfzBgzAarNg2E21/mZTtYa7eWxSVCaT3kah9G5Ez8bO/e174IvZiS/J2BKbW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfwIaZjHKgc6pIC09iEhYUjW9i4xdxEhUAeWx5q3TS0=;
 b=ab6AnYwiit5AxwHXKJhCl4L8YY5c60bYwwn8rAPlgV4n9q/VC2nKTkgLbQfVjobg8NBrj3RBylVHouL5lFV8I6bxyt2Aqe2qnitO/RLxOvzwOQYTYJDF8xhSSTtTygnhrp5LQXuLb8bg0DBs48WPuqdz96lFRwzp8XaKhuk+J26vBUZSmosUHpPZRpomqa+bT/qTtzVwpvmC+FPZHZ3yiTyDiKjO0XiyXxE2zbbOIb7705VKBeGHMTE2W6QK1UH5TvLVx+crJmQ14aCq4Rwa8BoIbKVVawuN3VoeNvlgnT6nt01y9RpupmU884EuzWv2aE+1h7zTH9mDG2ZaUDD6Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 08:10:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 08:10:52 +0000
Date: Mon, 3 Aug 2026 10:10:41 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] sched_ext: Add bandwidth-limited rescue execution
 for stranded tasks
Message-ID: <anBNAQ_dZ268Ekba@gpd4>
References: <20260802215447.3134509-1-tj@kernel.org>
 <20260802215447.3134509-9-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802215447.3134509-9-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ec295c-294a-426d-36ca-08def136bc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	np3AaNkhhp1e4bB9oG9PL/yTtwhj4rJCo4V1X7pDwxHb/27rNc7DhpJ3pguXO/3JtYXeEhYefFGNjcyY5wVjtY0jvLnQnbSjinxcvKzhi091GIYc7y0mRi+mgDjmUvQdn3tpH09LE551p9f29siOoJZLBe1vspZdbulfFAXjbcjK4IDAeKBLe/nReGQ9ix1uNY2bv6EsSslqlzXuIM5H01eX1APUpsVeoUzDb8qdczC6JSIyNv3TUd7eqXbh7z2roH3MJBc1YNs8uvX1aoXH2OOzd7BDIKRHN3dvIiMBUMfbCwLC045gW9qk7v+A+KoPZn6BqBKgJBKe9XthHyBapZlqdhurSMfYkzVc28bZe3PUpA6psg4XJ73WDy3H4RLiDVkK0rEP/M965SVrlEwtlwYZU4AXZlIkxC5wxOwf4/Eh36G5w2hfdjQ3SkS9AC8YaWU0AV7CYwWK9zC5XY3y9iWJ4g+54bVbHyYUaoXqHnXZS04pr4hiTZZL1LrAH6RaLJoR2Rtg3oQ3Z6s93GZadgYJ5Kn5SYDO2Ignk5C/59GLLWz0WOkpoBk2OyOLVcqUBnespObo+dMZ6Z7p2/KgdWklRjlhpa8WY/XaieT1jMTSUUjUNsEfEwyWrvssXxNEsFZSw+E90c3tJIP/9owp8+1fhNDr9gtU8U9aeWbl+FA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50wq5FDhCGOX7JwKc4PObdeJYNm5agDUjXB7H5vo5Qa7PW+BbtokJKN0sz/q?=
 =?us-ascii?Q?8KSY4193vkEHl1mGxZN2Gfv7aSAlDR17OiYATIyCojB0y9HYrmUrQ/DYtwd9?=
 =?us-ascii?Q?mipx6IEGYKxKM2lfFOnDlXO5NwRaPr9Yh5Rt1asgxSiVrkHR4O8SBkzzUE5N?=
 =?us-ascii?Q?0bwvqY/ol9gxbpoQNM9UjtyFE2yi67JhTJ6bUhhTsO8eMgqZQXjCVNpz2j0b?=
 =?us-ascii?Q?xqYfZJN47ryO/XtW4PgelWHEloEwEX+oXM3XpeG2rZQ5KZ/Zm5paHcCZjl3n?=
 =?us-ascii?Q?bgnI5B6N5mQzQ/RlFaMDQvRIoGhn4zszgeFcUR7gg0ZAZPduLMfaqc0mL0bA?=
 =?us-ascii?Q?AZu77jSb8wxwgMlMu6dC7aUmTAV8uNxxvh2hMD0f0olXYhWWxCvWorHnJsSa?=
 =?us-ascii?Q?J34Gf89T01ej0c+Gh+7F08EA2oMRRj3cu1AjBbyzUqPzp3rfO731qqA15V9B?=
 =?us-ascii?Q?qUhNAy1ve3e9lsPKQa93tXnFRTSl/scyGaKB0xiElJAOir+wRKi4xHKiWi3i?=
 =?us-ascii?Q?QNeehd2npYSsKZGmRrr7Es4RIn2VoEMPIhv7iQo0h4IomS8F6kNjOuK7rwsZ?=
 =?us-ascii?Q?tdHEYtkhL1qA/2ETuMVQQ/lZR+I5xqXX4FNhkcpdN5/S44Eeqw1jxl9SUVQC?=
 =?us-ascii?Q?1pEy+ly73geQ63n1m0y2FMOG44BMvSWMn9vLBg3PIx0Y19hnJmsEje/9QNpo?=
 =?us-ascii?Q?yFznZdajGCmd7J3GIevHJ6j1vz7i/i/kDDQdZL47MaJhThrSjH3u1KFzP+LC?=
 =?us-ascii?Q?v9Zb5Qa8CtX6B+ySEIKNzakLMQsIg9uA4dVy0oiBzUS4hAA6o1Ozi2vDA3my?=
 =?us-ascii?Q?joFVSFsM1LfmO/nHgfnfs0ELERayl4e6R4h4Sxh2EHMm6qJtlR/Ye3PbvfDK?=
 =?us-ascii?Q?WT/o/zKlGRAC0SGNKTdk95WUauEBnIghirEpOriJkx0Y5jC3sM/dmpmTK+sG?=
 =?us-ascii?Q?ae69OEh1INj2INet2Yr2IP7qNTYUnEY9Nbhya1GeAjxFq8ueMiwd24gNi7lI?=
 =?us-ascii?Q?heYR/ecabcTcv+0uQmnwsbEbHCSF82+b+PYasBfdz40Ms303jpe8Y6gq2P81?=
 =?us-ascii?Q?0maZGq2tCwakYeBgAwVNFduDuURkWbOvgba7noZte2tfrhAoY7VWZAPaZjee?=
 =?us-ascii?Q?8V3QtCVvbQqiZJQfg6rwSFTZZCCk+PDqXXPuBFjZOwyTisZHtmU2fE6hFV51?=
 =?us-ascii?Q?AZczXrSEj7NzsU8/Fjyt5yQiwFDhpTSwejlVbLgpa2qmbjQTv6WUAjbEQa/C?=
 =?us-ascii?Q?3nw1SFywaPMdcylBY8IZF4erYG2ya1lg9yCqAOVlnhiUBwP6KokOInEb/izJ?=
 =?us-ascii?Q?lwtwls0PvceARKNEErZCz5atrhR0JFByScn00b/h2UJX6JxFFqoK2Xv8MnI/?=
 =?us-ascii?Q?s4QQotsYxM6p53IXaGnZgfduYg/78rtm7tdKsD1KOo0JsDxrttHXvAmFUCkT?=
 =?us-ascii?Q?CrDKW86FBtAkoTcq8DBqsdfpd2aMcdZkOX8Qe0gn/byY7tApe4KHDpVMz+5p?=
 =?us-ascii?Q?N7yHw4eSrX1BG039ArSxISVVGl8eeXFGhgRjb/tlkSAK1vhPyGdDuyblkpJy?=
 =?us-ascii?Q?4ro6Sc0B4BEk0ew4QEt3FhtV7lDc1sQKiNjMFxigI1KBAqnfhuZ59A0X0teo?=
 =?us-ascii?Q?YL19BZwcXmOYyXIgMJuzWsxWYN7q4LnHbO0HKmEWBdE+nD39ylZ1x4dzcgIf?=
 =?us-ascii?Q?EkAZQ0/rBPkgcEUd0gd/oMUcSZUHQUdbAtSXPRtt0TJcyBgdeHTbyCr+jmJ+?=
 =?us-ascii?Q?KEVs8M3MWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec295c-294a-426d-36ca-08def136bc06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 08:10:51.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1qO8Y1MubpQwc9QQkjoe4Z8tgbFHFmREIzB3Pqmz7AYKKJJszLGWboYq8QCMZvsvyP2IaKVM93qUV9Wv6y3ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

Hi Tejun,

On Sun, Aug 02, 2026 at 11:54:43AM -1000, Tejun Heo wrote:
> A local DSQ insert lacking the needed caps is diverted to the reject DSQ and
> bounced back through ops.enqueue() so the scheduler can re-decide. That
> recovery assumes the scheduler has somewhere legal to send the task. When it
> doesn't, e.g. when the task's affinity is restricted to cids delegated away,
> the task starves until the stall watchdog ejects the scheduler. An exiting
> task is worse - it skips ops.enqueue() and the rejection becomes a
> self-requeuing cycle that burns the CPU until the watchdog fires.
> 
> Add SCX_ENQ_RESCUE, a fallback modifier on local DSQ inserts. When the
> insert would be rejected for missing caps, the kernel takes over and runs
> the task on the target CPU without consulting the owning scheduler. The
> kernel sets the flag itself when enqueueing an exiting task.
> 
> Rescue is a last-resort forward-progress backstop with a persistent
> disadvantage, not a way around cap enforcement. A per-CPU token bucket
> accrues rescue_bandwidth_ppt (default 2%) of CPU time and rescues run one at
> a time in arrival order. Each is granted a slice of the rescue_quantum_us
> (default 5ms) quantum divided across the waiters, waits at the tail of the
> local DSQ claiming no priority, and rejoins its scheduler as a fresh arrival
> once the slice is served.
> 
> The schedulers keep their normal control over an admitted rescuee and may
> preempt or reslice it. Service is measured on CPU time actually received, so
> neither shortens the rescue. Prolonged denial escalates - the remaining
> slice turns into protected execution (SCX_TASK_PROTECTED) and the rescuee
> preempts the current task. Escalation is paced by the same bucket, and
> delivered service converges on the configured bandwidth no matter how
> aggressively the schedulers dispatch.
> 
> Both knobs are root-only and SCX_RESCUE_DISABLE turns rescue off, making
> SCX_ENQ_RESCUE inserts reject as usual.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index d418935f1e6b..18983dbe81f4 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -924,6 +924,37 @@ struct sched_ext_ops {
>  	 */
>  	u32 cid_shard_size;
>  
> +	/**
> +	 * @rescue_bandwidth_ppt: Rescue execution bandwidth in parts per thousand
> +	 *
> +	 * The fraction of each CPU's time that may be consumed running tasks
> +	 * from its rescue DSQ. A higher bandwidth admits and escalates rescues
> +	 * faster, see @rescue_quantum_us.
> +	 *
> +	 * Only the root scheduler's value is used. 0 means the default of 20
> +	 * (2%). May not exceed 250 (25%). %SCX_RESCUE_DISABLE disables rescue -
> +	 * %SCX_ENQ_RESCUE inserts are then rejected like any other insert
> +	 * lacking the caps.
> +	 */
> +	u32 rescue_bandwidth_ppt;
> +
> +	/**
> +	 * @rescue_quantum_us: Rescue execution quantum in microseconds
> +	 *
> +	 * How much CPU time each rescue gets. Rescues run one at a time per CPU
> +	 * and admissions are paced to keep rescue execution within
> +	 * @rescue_bandwidth_ppt - with the defaults, one 5ms rescue every
> +	 * 250ms. A crowded queue round-robins on the quantum divided across the
> +	 * waiters, floored at 1ms. A stuck rescue eventually escalates to
> +	 * forced execution. A larger quantum interrupts the CPU less often but
> +	 * for longer and spaces rescues further apart.
> +	 *
> +	 * Only the root scheduler's value is used. 0 means the default (5000).
> +	 * Non-zero values must be within [1000, 100000]. Values too short for
> +	 * the kernel to meter are lifted silently.
> +	 */
> +	u32 rescue_quantum_us;
> +

Not a blocker, but should we add compatibility handling for these two optional
ops fields in tools/sched_ext/include/scx/compat.h?

Otherwise the later scx_qmap patch would break the qmap build with older
kernels.

Thanks,
-Andrea
