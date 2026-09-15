Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E16408623
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451078; cv=fail; b=oeL8iCOiI244f+1CXi/FG9BWLurhVk14nqNBpAuExzZiYqx6xmftougOPunab8zR9ZoxGDCkc5zqd65YZlcBZfGR/f0WHSFiKFQRlAJ+Hhpd3t5VKfm1nplWqOHytkJNw2JOE+BwVaXeWp/unEVo2Vd4p5DZj4EkvmBKpROIar4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451078; c=relaxed/simple;
	bh=49CPRbEKERaaZIohjsZS8SBTywvmfJWR7kmnJmVr26k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hXqLIn+xHIOAsgOvQLaOthoplgOd8fqdW2pNHo/YvYIfWNSV/Km41FBhhGaLYVtZ4PuMx7MgbcfN09Nn9ullcbS3WqC8nWdZAbatSXug3mII7Q9DmDRhsLF3fjlu80KXpmoXX/f1AbPslazNrp0oc9T+znm2omRzyfSZHxScwn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dq9pTg/A; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dq9pTg/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEy3231iiovndkH2K8NWygnbF3J36QV+2L26Pq7KGRy3+XHHDAbJenFmPHG7e3af9aNDzp9NfJkQ6IkLKGt4CqYZSs3d/3jETEUrFNSzsXn+DNde7x8q543Olj3hT/MlPcuh6B74PEATVC0TZNHUO0SnT/rTOMGNBxkcBUoHSoXgF8LFRrwtPYNgIeIhwuM7NAwYQGTOXJBmxWhUZypRxQ02NBVu3d2csWJHm4oQIweTS5rNBb6az8o/r84SZTB2zd1sr+Pymupz4Bu2BH8DcWq9A7nk7F6nhXvu2wcG22tJrVPIizuYTntCPavT7yL/aM4YrM2EKYOyCfN4Lw2Eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7FBLSyoXwo4roN2c0MeK/q/FAGt79R66pXZOCYzlSQ=;
 b=IIucDHIwxbUXVkJqoxhC1Cls072vBgWl7Ce/k70//HS3qOz4FgcXs56edf13bxyXVBebMQEZ1ju5fp5b8H+naOZwtHFBuAA2GloSNFk1TlMlbeJxJbIDbZisMIGngo0O42pD8Pf44R6f7wXFYeEbLlQ5OSP7XXJB6OGeT4xUqNgmZngZOLecrTUu6dy0YMZ+QOVUoRWFqSZa/QcsSTzPbmICZn+PXZ9zs8w8c9xu5okCBPUXtffDrZ6DCY+PLQsyVcHXfuLdM3md/Pg/lJGOEDbOR0TxMF6YuxAse+SALnCdk7JQK+1pZqhaKodsX3CczZluLCthY13UgFCLCIV2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7FBLSyoXwo4roN2c0MeK/q/FAGt79R66pXZOCYzlSQ=;
 b=dq9pTg/A4PG0QLYtOE7WlXYVm2pkMmEqQ2ka6QgnG582DQfHxPwOuKM1JOfCkEMtQp+VpSGO9VcBa4Ty8vwDQIiKymVSXk6Q0Zi5qIXQ4haMiAN2zHAzOqDyfP0Y1E+ggr5g1+fNw+sXncf6jGt3gNG4t9EvNLXJyRikdryL/JLV/RWLhgp1SldNJ7i0QRYjRvoQeeeMAkVB15zz8aIevuKm2rBUkcxsyfHKL3KrPU/cfS3D1gGMwFw/2K5z4ne7JHnATTVqrWSmjvXtO81E3AuZwYXWKUFvRYSl+WGWPUA1OlbXScWMBfFF51v0NKgiUorMdSTPMbjrMwnqBRXfzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 05:44:32 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 05:44:32 +0000
Date: Tue, 15 Sep 2026 07:44:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Maintain an online cid mask in the
 scheduler arena
Message-ID: <aqjbNhrVWJkiNSvR@gpd4>
References: <20260914234259.3585373-1-tj@kernel.org>
 <20260914234259.3585373-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914234259.3585373-3-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 21833a24-e59e-4247-3db0-08df12ec6a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|4143699003|3023799007|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CgLMDPx9cUAEd8la9gmOZyfY2RqYVeWq8aOuflNwArbsVYQczEz6WAguxYmQAz/vA1+OIbQ54aVTGlHbTlI27RdqhPAqKbIRNmfbpZzwbhXGAkQ/sj7KUS9nCR66pFH34DTAakbHM0JaTjO/8X41d4ph5knEDzix5b1fV9QuMgY42l9QraO54QWe7U8HJWAkKZ/CT40cGfj+2MjhhyNaSSi1qrjSm3gIw9Zu+aRTW6vrSXtz2RZ3EIeSa2MOcvcmIDsvxAzP2uIHpI79V0CGBtainLF9al8MeFjwlMAC3lDIqlDLWkf0STbEQZTlT959WfUpSdubaOqR5BNSYgfkoF9muo6BFs3FpP0enrG56iyVjF6xgDtC7GOJRJBEqSP+80sSeIDK7RzD/dHxt4wVRgWyAt/rHaT+6gIweCjcb0zY34lj+f4fmOW5POUN637inuRCpT5r1Ct7NqpupZicqIJ1Bvzc5TNMnK7NDfpmYjRqc3P8ivEos18y1R+zSlnpZmr31BFdM71v5o4boV3mpVduWnV1qhBr4zCT2MSEvScB3hOjO9fFoy7Z/R2irZcd+IkEnQzB37Lf3NC3MxwiBQeK//OlQI27Q9jx9wq6mIQOg8o2IVCzaXajMQvaRXniOjmq+TLZmrob5KZEPENJyjCGOyp7Hb5YdNZqSk/tnmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1XrKgZNaii+gvyg2GeJKEd6cOUkotLu+2IHSfrpP5DJKgc0jFjGn9wf/+pLj?=
 =?us-ascii?Q?+MyKDepeTBkl4aExu3IY9+wp/WapdYblMKUXvZTwA4QUvZ6VtCdFGJG1d3vZ?=
 =?us-ascii?Q?NSjZYFimnSZ8BCkvveIj7IY854O62v1hrFOISlftpaCjwCINkRjwRfx0OWLZ?=
 =?us-ascii?Q?PPm7Y4ZKe8Bu/8ixUKiFGtPAsfxOI505Hr9EdL6CPVVHSLqhx8Z1CtG12Qpv?=
 =?us-ascii?Q?LyJ1WbhjymkTKPoQXHt0bDiArskq+n0hkhhMNO238tenIKG9JrOd8kWskXlb?=
 =?us-ascii?Q?k7PtJCGBzStJl+ihaonPnPZqnBk9m08icaPGRQweifHR99srDd5mV+tKnTUk?=
 =?us-ascii?Q?0KmOcDr+PbMJ3UBqn6wc4TuDyRP3lZDMOgIVHMJ2xCpO/RCzhTWSr9HDB2HV?=
 =?us-ascii?Q?AcZFxSX4bK2/R91zca1GBZANjNxnrkE4EUiIB2B35WA5H8fXh3gj3JXQquLm?=
 =?us-ascii?Q?VB3l6P8xXmrUdVuW+gV+rZoPKN04E7L8ms7q6CkafbDndRHTVU+JRsqgn/uS?=
 =?us-ascii?Q?rlHlYZ4t2FHcFfhKi7ksjgxP3zDUgGzVVL6JlX60tB8pO2Xx5i5/S7qTSgMw?=
 =?us-ascii?Q?0JGeVgF6ylgH2krZ8JbeDv1FPD3OYEV5EfD3q9h7Tah6GXT+H9FGjM6XQBfK?=
 =?us-ascii?Q?xoaWM5pAnt9WK8NnRRROKdwkz/ttSZOnQG7fEkoozPyiraM2lceiN4SnEWEZ?=
 =?us-ascii?Q?0pWyD2wkk+cu55umzGQQ5i2DCOog7if0CQ3tSwVi+SzzhR4v5mDjwKJzDsGt?=
 =?us-ascii?Q?x1LhWKVEq12+1o1wF4RfB6kOeBO3HtDLYLF7RYsxbyAKZnVDko3zRqJZPiFK?=
 =?us-ascii?Q?5Cu9vlQu+xyBmFKEZsHsWv9fRbSMTebVR5UA69XeR2qE8u49qM9n2LEokYgl?=
 =?us-ascii?Q?3JYridicFyOJWey5NMdGMD6d+JsllIND55fadx4/eiiWcyUgsRWdhYjrwBoq?=
 =?us-ascii?Q?G2W6fKPZQKKJ6DZ2J+2HTewC7hJePelSOvXecmAdQMwAlnvaCDr1ikb5Tgac?=
 =?us-ascii?Q?mRDO1DgDv6/1GPTpNS2qFKZkxZtmGscBbBPIbmFD4FdBWWahT4sMIwwXW4Eh?=
 =?us-ascii?Q?MjLaXKqHW/+yNOg+us5fpWdkHLM5c1bA13R5G8K+fFiR9gfxMHTCWTV1Z0Ry?=
 =?us-ascii?Q?oNS1LGlbaw4Cy5qVrKp8+L1v8xudKl25DyooOBqkHeIdcOmg+1JgA15L+wBs?=
 =?us-ascii?Q?M3UD4k35fn2dJx2ub6p+cfRuZ8ta2BwVBCc6zu6slzTl1djPmOgSGnQTxOLI?=
 =?us-ascii?Q?HdHTStqMmAWqB6ilAHgY6kqwiIMFJIYlWvubwzOjZp1tMvnLKdiblAWEyAXn?=
 =?us-ascii?Q?aH5Jrs0s9SI8dLMG+ue8uVDkulS7fsmBPgVCDcv1iFgI5PoaqZPS3I6Kzog9?=
 =?us-ascii?Q?zP65EbVHm3WIL+TuD336uLT1tk+BwBGgWYkquBlN+q26tldB/bEJmPGn2mPm?=
 =?us-ascii?Q?/0UQdxkUb6cO8FmjCqbzkFTlmVuQypr1fnOAy+CsSkLuQ/rOguqvkK3mgu0d?=
 =?us-ascii?Q?IqKi2MH5Hqn/WBHzczazcQZohSKlCXcQFy2XkESFLmStJEBqtJA47wf5uxIr?=
 =?us-ascii?Q?8SFRQB+llGCJWQIkYp86EJ7h+d1h8xmZEDM45mwTu7ieCBwsEcU/1Nw8Zrk1?=
 =?us-ascii?Q?hyzn7tqrPf7S1xOCAVtRZoBcm4xRQkGzc/W61A3sBqGxe/+oPePT7Ux1JnqO?=
 =?us-ascii?Q?5zrMQtoLSQK+2fwmg0ZZ6Ha1cnW5fc+c0+RmxVzqv8ze2US3zEfOh4n5Z5NJ?=
 =?us-ascii?Q?2qtCOEsOsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21833a24-e59e-4247-3db0-08df12ec6a69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:44:31.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pznUhc2Nghh9h/Q5fqWsj8UJdQsBuvsHL4B8+2efO+FzdkPfNm/fNt8UVq807oOdJZhFJL6dR5+yqAIfZQxNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

Hi Tejun,

On Mon, Sep 14, 2026 at 01:42:59PM -1000, Tejun Heo wrote:
> Schedulers on the default cid mapping treat [0, nr_online_cids) as the
> online set and restart on hotplug. Schedulers that install their own mapping
> with scx_bpf_cid_override() have no way to learn which cids are online: the
> count no longer identifies members and the CPU-form cpumask is unusable from
> cid programs. This is an obvious hole in the cid API.
> 
> Add scx_bpf_online_cmask(), a kernel-maintained cmask in the scheduler's
> arena, allocated alongside the per-CPU scratch masks and populated after the
> cid mapping is finalized and before ops.init(), for child schedulers too.
> The pointer stays valid through ops.exit() with no reference to take. It is
> the arena offset as a void pointer, the same form struct_ops arena arguments
> arrive in. The verifier types the void return as a scalar for the program's
> arena cast.
> 
> The mask follows the SCX hotplug notifications: seeded from cpu_active_mask
> and updated before ops.cid_online/offline() runs, so it lags cpu_online_mask
> only inside a hotplug transition. Updates walk the scheduler list under the
> lock that also serializes unlinking. Reads are live, not atomic snapshots.
> Root initialization excludes hotplug.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> +/**
> + * scx_bpf_online_cmask - Return the online cid mask in the scheduler arena
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> + *
> + * Return a read-only cmask covering [0, scx_bpf_nr_cids()) which the kernel
> + * keeps in the scheduler's arena, or NULL if the calling program is not
> + * associated with a live cid-form scheduler. The mask follows the SCX hotplug

Documentation nit (feel free to ignore): since the read-only property isn't
enforced by the verifier, should we rephrase this part as the following (or
something along these lines):

  Return a kernel-maintained cmask covering [0, scx_bpf_nr_cids()), or NULL
  if the calling program is not associated with a live cid-form scheduler.
  The returned cmask should be treated as read-only, even though arena memory
  remains writable by the BPF scheduler.

And still keep const return type as source-level documentation/checking.

Other that that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> + * notifications: a cid's bit is updated before ops.cid_online/offline() runs
> + * for it. The pointer is valid from ops.init() through ops.exit(). Root
> + * ops.init() runs with hotplug excluded. Other contexts can observe concurrent
> + * updates.
> + */
> +__bpf_kfunc const void *scx_bpf_online_cmask(const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +	struct scx_cmask *online;
> +
> +	guard(rcu)();
> +
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return NULL;
> +	online = sch->online_cmask;
> +	if (unlikely(!online))
> +		return NULL;
> +
> +	/* BPF rebases by the low 32 bits, like __arena callback args */
> +	return (void *)((unsigned long)online - sch->arena_kern_base);
> +}
> +
>  /**
>   * scx_bpf_this_cid - Return the cid of the CPU this program is running on
>   *
> @@ -10709,6 +10770,7 @@ BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
>  BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
>  BTF_ID_FLAGS(func, scx_bpf_nr_cids)
>  BTF_ID_FLAGS(func, scx_bpf_nr_online_cids)
> +BTF_ID_FLAGS(func, scx_bpf_online_cmask, KF_IMPLICIT_ARGS | KF_ARENA_RET)
>  BTF_ID_FLAGS(func, scx_bpf_this_cid)
>  BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 2586879e9084..067cddf47220 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1572,6 +1572,7 @@ struct scx_sched {
>  	 * and passes it to the callback's __arena argument.
>  	 */
>  	struct scx_cmask * __percpu *set_cmask_scratch;
> +	struct scx_cmask *online_cmask;
>  
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
>  
> @@ -2098,7 +2099,7 @@ void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p);
>  void scx_cgroup_lock(void);
>  void scx_cgroup_unlock(void);
>  #endif
> -s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch);
> +s32 scx_alloc_kern_arena_objs(struct scx_sched *sch);
>  void scx_disable_bypass_dsp(struct scx_sched *sch);
>  void scx_bypass(struct scx_sched *sch, bool bypass);
>  s32 scx_link_sched(struct scx_sched *sch);
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 385302d19914..f7aeb1488566 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1805,6 +1805,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		goto err_disable;
>  	}
>  
> +	scoped_guard(cpus_read_lock) {
> +		ret = scx_alloc_kern_arena_objs(sch);
> +		if (ret)
> +			goto err_disable;
> +	}
> +
>  	if (sch->ops.init) {
>  		ret = SCX_CALL_OP_RET(sch, init, NULL);
>  		if (ret) {
> @@ -1815,10 +1821,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
>  	}
>  
> -	ret = scx_set_cmask_scratch_alloc(sch);
> -	if (ret)
> -		goto err_disable;
> -
>  	struct scx_sub_attach_args sub_attach_args = {
>  		.ops = &sch->ops,
>  		.cgroup_path = sch->cgrp_path,
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 76f5e025e107..2ddb01a059fd 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -113,6 +113,7 @@ s32 scx_bpf_this_cid(void) __ksym __weak;
>  struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
>  u32 scx_bpf_nr_cids(void) __ksym __weak;
>  u32 scx_bpf_nr_online_cids(void) __ksym __weak;
> +const void __arena *scx_bpf_online_cmask(void) __ksym __weak;
>  u32 scx_bpf_cidperf_cap(s32 cid) __ksym __weak;
>  u32 scx_bpf_cidperf_cur(s32 cid) __ksym __weak;
>  s32 scx_bpf_cidperf_set(s32 cid, u32 perf) __ksym __weak;
> -- 
> 2.55.0
> 
