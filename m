Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF929D268
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618178; cv=fail; b=Agm3wZKGKZGnDXCbeRAGzi8JGHWGl5+2+z/xAJLo91c2SB4/eM8lP3SOpcFzmcMRYqxSN9lF5hs488klflHRvz0RG2a7MUcDKKAVFgM1NuYkg3SAPIKB8Z6b4uyiEE3vMW5/ayNa+2GcDMk4/cd9MRdXQsP1gwaZoTOH1VdXpws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618178; c=relaxed/simple;
	bh=zTrvF1bG+YlTMgYvRQNWX4VHApKkc33BaxaNY1qanFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C8tlu5tknklQXv6lgnJqt73alAvvxFqwum1oy/Hokz+wYXwwVNbr8RDf8oV9Jt0axjSOmC5KtBNu2TdaacS1R+u4iUklUiLzDVSTmU927vtI4IdHX07vtXOiIXdLGFwyUOyYNoEJ0C9Co0S8XY+tVs12eM6BK5WO1TWsH0aFuvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgN3SSEX; arc=fail smtp.client-ip=40.107.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgN3SSEX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebLWYEt8103gMw+kwbMOURurl0rlvmnbFVZuPMvnWwmutRhigEvXAUMBMGT9lDOrZian7hwR3xkV2LbjNhQt4URo7ZBGyKdZ8qljFX74JIJZtVQb2/1bQGkLGSDQDhvnaJ6YnITGyfC2Fi/v+hQ02XlIbQkZOGxjMinFfgF57DlBUsSQQ8HRzLmJtwOzwLnx9jEfqL4yhlY6zA+vROIGpdE0sczXz160SoZCpVmjkX5u1wvexohmhPKTA7i9+LHfJQJGzfHKD9PzNbhGk12jshhxTn6vZq6obK4Bo0Cjt+/mK/VRMMqP7sGzshbw4/HbT/z0QvN9mnJcyn+/xCNsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bamd5LrBecfXbuMjGMGxK+RSgf4erypcLcYuEQVoKpY=;
 b=s/SiQCYMpkR4Wg/6T3XsluDzfZJOQVRTYaH+S+PX7rD23Ie2Bss6SUFjvx4fCmlDahoRxrLKxQXhgNl466KGdcCFAUMR8UKCgCTEWckU06vk5ehMBnUK5TAy67MWEea94E5mc3PSr/S2LM9a5ltdrBZnqEqxnIR0oKRxI3oJGXJ18V4G0uap+K8x50l3QvtsEItuWeiIHScqlkW4u9P1y4aNP63L9uGsINKTkJcOgpXZgmHHnfO9G7CrebU2Vba7czDu6XUOKikpyzgNuBpEWo+ounML1CHC11SAVaAKkgsbVPJocKabXrBtvU1qkIb07irgUnazL0lituHJ7LlA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bamd5LrBecfXbuMjGMGxK+RSgf4erypcLcYuEQVoKpY=;
 b=XgN3SSEXtJpLzB6LuCfCQPcxFNe56wicj1PdAp3wwjLtw4GzRzt1kHrNIdVg7XeXydaYMHJXdcUzNsiPoGnoQkSeFto97qVu95E3gPE+eST7nL3iWVNA6pIC7s+8TYiMviMlkKbd8Jksshc7FXMX4Og60o3/yQ4TXO1K3suOZ+s2ZasrAf6xsn+Q+9Xny+MEOEspQWVeMagvl6mpvdIidODumqSjKFvqWSEeSB4fHa8Sp7k+5tECb4wuymGfudbkayUq23XNLY9717p/fqzu6nvaZmZoWlqUtTVFBonxovrWqJfwIzbHQuRIFvjmHwk7MipglYMP8hIF8mA/T3Jt7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sun, 19 Apr
 2026 17:02:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Sun, 19 Apr 2026
 17:02:51 +0000
Date: Sun, 19 Apr 2026 19:02:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <aeUKt4Mv7NPZIrLW@gpd4>
References: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f8fbbb-dc70-42be-5808-08de9e357dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T+XuzBpsSemfO8v5mSzTcb01jUo27+NhCGaMM/abemeH3HI1PHTBgRVZCT269XKUjtIyTMNixQz3jIiIgIdiy7/puViFg66G3OISOvKQzur3RyqZLu2NJ3+EaDjzv52A3jg/WCycTyXE/gKNXQ4N5zYAvb5DkyBbYeL7ZY8lbwvCVqW1TTss4bUvesCNhmotoq6oqGr1QmL8gUO/wz7Ix+5c4WmOlh5W2BversoEFi0O9w3ymaRgDqofaFCzLyW8N4QekKD+zHr3qtwAibA/zjS6AqDFqyRR8CUz5lvKsf0mq6eusFwN3D954664OCyMV21H4bhOc/MUIup7UWuezDWQ/s2ZzPelK3A2FAaB8pDIcoEaFfiQx3VBWy5k+BBNcH5C4w9QW8W9eid/jCZU202PD+Nbfm3ztu8b502WTKipmpW4MJwZUUeEjLuIarIOJ6BlQtKO4gW9as6Q0e3hxBMVFLwjCc59J4S8zI3jf9DxiJC+4JwfeZVZWZYttECQ1dJcwxAd8LDv7xezkf9PXnRt/KsXFAEOIbmR/mQmsFQKN9/QH2Ce7CtSMYt0lUvYLyBAOoD3xkv/XW/Js70SonzvzVsBwxXz+sGIigjATmdpnSTXsItewCKL/a5GYNeenC+yQkFAmwpy1vrYE5vtecBLzWxnAgkKTDLj+TxDc3nTaaqe5tzKMRV/0Zgv3rVeDDgL69rQ+CkgGqWvX2ptRsNFWaD4Mpim2skdr6B2xOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLzqqKRQqi78iSDPVRYLiNutLwtc++5S22XoRdOCLCzSkaQpBOR9wUu10zKt?=
 =?us-ascii?Q?JeVHEum52EJ3g8MDivvo9iIGPgt6l6BZc7O4wFDYceX/WiryiNGCp1ypdq0t?=
 =?us-ascii?Q?E+q0zUvfLVkmGSXMN3H0FE2UEL4Jf3r0aOhBRMXJlY7rLoYlIAdu1GA20dKV?=
 =?us-ascii?Q?LfDI5sVWjv/tmjhF0HpJGCwb8DZETb1PRU6cBxMwdcjkxjXTP1mkUmcpKBBi?=
 =?us-ascii?Q?+sdHbM623G0O3kpta9KF5uHH9+PodLDZ/BREhONRPIWu24pQxR2rVl90CjHR?=
 =?us-ascii?Q?i8lW+MwUcH0EXdd61msYRZ4uqgrpjgT8j/bqvrpzGStKBmkijaQ0Re7aXWLv?=
 =?us-ascii?Q?2w9Ubo7RUfBr00a2detcecNU3yC/gn4GFBEjlHHGSmN/tsBxZiBy0ktGyNm0?=
 =?us-ascii?Q?f84DAIRAiUsuF84zssjmYoTJ1/I++IqMJMiiFDOo7TcxgYau75a+e8P1MC42?=
 =?us-ascii?Q?/BYV5eqBAYi+OxSxPc8ZDxYHihGeWfYr0xxAg0qZfUiKZrhx0QUXyYYBBZ6I?=
 =?us-ascii?Q?WjzqYxP+GaYSAikD+ugCdYofQyqtwZ0Dhc5rOi17Y80iMUVgmF0SuoDO7Y0K?=
 =?us-ascii?Q?pES72s7zv8hJGBGLHIcc/H0+hTSvOW3ZCO3irWCWTUxjQFJBxebjeWuGcr31?=
 =?us-ascii?Q?yR9UxJzHYlnL9kr1jnIAoLfGqYbC+LrmkHiKmdlesJtchNXqaSg0SOSGhen8?=
 =?us-ascii?Q?B6UhbPEvghVMzSH1gz1BBjLA8RSS6GwOus6MblSEep/6IcfD8v5MuflKlk44?=
 =?us-ascii?Q?YpyJv5LUIW71j31k0wk/qfjaCx3fyuY5/gPZq6GGK3KvZBIRlDmf5OwRXhEZ?=
 =?us-ascii?Q?PMuPi1QmaqYtllLEhpkeMM2Oi+wVUzF2Pk3MEIeqaNl2jEVki+KvBSfjYTdy?=
 =?us-ascii?Q?5kq4lHIOVHEGCbKdqUvdGVlBBihe+guXmkTgUrpkVQ5xui52D9fnxLG7iM+f?=
 =?us-ascii?Q?HlOwHrdHzAq12jmXHQ2bzW80py7kx6n9Fl1nk9Ds9yrWeh6brXleiyDHeByB?=
 =?us-ascii?Q?H73hqWcV649ZTR5HeprHlR80v5q3WMV1WpCvJIJUX1LQI+fOjWs/5RVY/4sl?=
 =?us-ascii?Q?cCoinuG/iszE0r1LJGUWUBILphPqQdGEA15Z6mPE24Sduoyp4/vu2wOs58td?=
 =?us-ascii?Q?pb40BMQ+lDGfhH4EsSYZbutRk7HVpgC83q339eZrpDC0HiJts7Xpqev8OQgC?=
 =?us-ascii?Q?XJje52zO5z2m1Jj7YmsLJbhvutEz4Wm4UiU+0XHZ+b6FahQzmOH2Tk7ynV8V?=
 =?us-ascii?Q?pEsDgNPi86Igy9B2thKFum90fdRIctMSAEJKnZxEhYR+7saM4qW3UcZKt6ko?=
 =?us-ascii?Q?L2uJ/LoHdrnJBpSJ4zsisljmeoFVa+GeDU4ADIcspPiw7v+/dzqeWhrtlbZV?=
 =?us-ascii?Q?WlkHEgwOeEQ9rXy0wnoJF9TKD+pVcy71VidZS+I0QymVMFipjFOOP6fGuPSL?=
 =?us-ascii?Q?SaEAMgQYP5g6bFcFOUm3UrZyQZ4QgWGD/QU54Bywbww0+WyyCFF0SxMdi0bP?=
 =?us-ascii?Q?g1J8YRi/p+aZ9Mq4DcYbyMOaVIaXBSkbc/JObMFPumu8OwqlLoj6+OPQIvMg?=
 =?us-ascii?Q?k8xpQ97ldeH1ZiOEpcZ1XpbAQymGLL6kqrxz+wRu0GVxItloXaedwqLPNz+6?=
 =?us-ascii?Q?o1F08V0geGcAtDQ+yErnnCdVKbBovzhU9OKG9Jnb4FwV5g8uCT7Cal4nkHWe?=
 =?us-ascii?Q?yxT3Ru8yBMhrYTx02waPlLjZI2tNt5SA3dL2cj1LeaoCL9q/8IKoY2n+Lc58?=
 =?us-ascii?Q?OAiYaVFuCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f8fbbb-dc70-42be-5808-08de9e357dcf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 17:02:51.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaQ7oJTujX9xh+u4aKwd2ltctBiZhSsVdWkp981dSiZknnyLO7IXu9Gp9AT0wV9+9feznm8vnDV6ptDLj0kLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827

Hi Tejun,

On Sun, Apr 19, 2026 at 06:18:46AM -1000, Tejun Heo wrote:
> BPF schedulers that can't hold task_struct pointers (arena-backed ones in
> particular) key tasks by pid. During exit, pid is released before the
> task finishes passing through scheduler callbacks, so a dying task
> becomes invisible to the BPF side mid-schedule. scx_qmap hits this: an
> exiting task's dispatch callback can't recover its queue entry, stalling
> dispatch until SCX_EXIT_ERROR_STALL.
> 
> Add a unique non-zero u64 p->scx.tid assigned at fork that survives the
> full task lifetime including exit. scx_bpf_tid_to_task() looks up the
> task; unlike bpf_task_from_pid(), it handles exiting tasks.
> 
> The lookup costs an rhashtable insert/remove under scx_tasks_lock, so
> root schedulers opt in via SCX_OPS_TID_TO_TASK. Sub-schedulers that set
> the flag to declare a dependency are rejected at attach if root didn't
> opt in.
> 
> scx_qmap converted: keys tasks by tid and enables SCX_OPS_ENQ_EXITING.
> Pre-patch it stalls within seconds under a non-leader-exec workload;
> with the patch it runs cleanly.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h                |    9 +
>  kernel/sched/ext.c                       |  144 +++++++++++++++++++++++++++++--
>  kernel/sched/ext_internal.h              |   20 +++-
>  tools/sched_ext/include/scx/common.bpf.h |    1 
>  tools/sched_ext/scx_qmap.bpf.c           |   13 +-
>  5 files changed, 170 insertions(+), 17 deletions(-)
> 
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -203,6 +203,15 @@ struct sched_ext_entity {
>  	u64			core_sched_at;	/* see scx_prio_less() */
>  #endif
>  
> +	/*
> +	 * Unique non-zero task ID assigned at fork. Persists across exec and
> +	 * is never reused. Lets BPF schedulers identify tasks without storing
> +	 * kernel pointers - arena-backed schedulers being one example. See
> +	 * scx_bpf_tid_to_task().
> +	 */
> +	u64			tid;
> +	struct rhash_head	tid_hash_node;	/* see SCX_OPS_TID_TO_TASK */
> +
>  	/* BPF scheduler modifiable fields */
>  
>  	/*
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -38,6 +38,15 @@ static const struct rhashtable_params sc
>  static struct rhashtable scx_sched_hash;
>  #endif
>  
> +/* see SCX_OPS_TID_TO_TASK */
> +static const struct rhashtable_params scx_tid_hash_params = {
> +	.key_len		= sizeof_field(struct sched_ext_entity, tid),
> +	.key_offset		= offsetof(struct sched_ext_entity, tid),
> +	.head_offset		= offsetof(struct sched_ext_entity, tid_hash_node),
> +	.insecure_elasticity	= true,	/* inserted/removed under scx_tasks_lock */
> +};
> +static struct rhashtable scx_tid_hash;
> +
>  /*
>   * During exit, a task may schedule after losing its PIDs. When disabling the
>   * BPF scheduler, we need to be able to iterate tasks in every state to
> @@ -58,10 +67,25 @@ static cpumask_var_t scx_bypass_lb_resch
>  static bool scx_init_task_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
> +static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
> +
> +/*
> + * True once SCX_OPS_TID_TO_TASK has been negotiated with the root scheduler
> + * and the tid->task table is live. Wraps the static key so callers don't
> + * take the address, and hints "likely enabled" for the common case where
> + * the feature is in use.
> + */
> +static inline bool scx_tid_to_task_enabled(void)
> +{
> +	return static_branch_likely(&__scx_tid_to_task_enabled);
> +}
>  
>  static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
>  static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
>  
> +/* Global cursor for the per-CPU tid allocator. Starts at 1; tid 0 is reserved. */
> +static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
> +
>  #ifdef CONFIG_EXT_SUB_SCHED
>  /*
>   * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
> @@ -111,6 +135,17 @@ struct scx_kick_syncs {
>  static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
>  
>  /*
> + * Per-CPU buffered allocator state for p->scx.tid. Each CPU pulls a chunk of
> + * SCX_TID_CHUNK ids from scx_tid_cursor and hands them out locally without
> + * further synchronization. See scx_alloc_tid().
> + */
> +struct scx_tid_alloc {
> +	u64	next;
> +	u64	end;
> +};
> +static DEFINE_PER_CPU(struct scx_tid_alloc, scx_tid_alloc);
> +
> +/*
>   * Direct dispatch marker.
>   *
>   * Non-NULL values are used for direct dispatch from enqueue path. A valid
> @@ -3665,6 +3700,21 @@ void init_scx_entity(struct sched_ext_en
>  	scx->slice = SCX_SLICE_DFL;
>  }
>  
> +/* See scx_tid_alloc / scx_tid_cursor. */
> +static u64 scx_alloc_tid(void)
> +{
> +	struct scx_tid_alloc *ta;
> +
> +	guard(preempt)();
> +	ta = this_cpu_ptr(&scx_tid_alloc);
> +
> +	if (unlikely(ta->next >= ta->end)) {
> +		ta->next = atomic64_fetch_add(SCX_TID_CHUNK, &scx_tid_cursor);
> +		ta->end = ta->next + SCX_TID_CHUNK;
> +	}
> +	return ta->next++;
> +}
> +
>  void scx_pre_fork(struct task_struct *p)
>  {
>  	/*
> @@ -3682,6 +3732,8 @@ int scx_fork(struct task_struct *p, stru
>  
>  	percpu_rwsem_assert_held(&scx_fork_rwsem);
>  
> +	p->scx.tid = scx_alloc_tid();
> +
>  	if (scx_init_task_enabled) {
>  #ifdef CONFIG_EXT_SUB_SCHED
>  		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
> @@ -3717,9 +3769,13 @@ void scx_post_fork(struct task_struct *p
>  		}
>  	}
>  
> -	raw_spin_lock_irq(&scx_tasks_lock);
> -	list_add_tail(&p->scx.tasks_node, &scx_tasks);
> -	raw_spin_unlock_irq(&scx_tasks_lock);
> +	scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
> +		list_add_tail(&p->scx.tasks_node, &scx_tasks);
> +		if (scx_tid_to_task_enabled())
> +			rhashtable_lookup_insert_fast(&scx_tid_hash,
> +						      &p->scx.tid_hash_node,
> +						      scx_tid_hash_params);
> +	}
>  
>  	percpu_up_read(&scx_fork_rwsem);
>  }
> @@ -3770,17 +3826,19 @@ static bool task_dead_and_done(struct ta
>  
>  void sched_ext_dead(struct task_struct *p)
>  {
> -	unsigned long flags;
> -
>  	/*
>  	 * By the time control reaches here, @p has %TASK_DEAD set, switched out
>  	 * for the last time and then dropped the rq lock - task_dead_and_done()
>  	 * should be returning %true nullifying the straggling sched_class ops.
>  	 * Remove from scx_tasks and exit @p.
>  	 */
> -	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
> -	list_del_init(&p->scx.tasks_node);
> -	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
> +	scoped_guard(raw_spinlock_irqsave, &scx_tasks_lock) {
> +		list_del_init(&p->scx.tasks_node);
> +		if (scx_tid_to_task_enabled())
> +			rhashtable_remove_fast(&scx_tid_hash,
> +					       &p->scx.tid_hash_node,
> +					       scx_tid_hash_params);
> +	}
>  
>  	/*
>  	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
> @@ -5794,9 +5852,13 @@ static void scx_root_disable(struct scx_
>  
>  	/* no task is on scx, turn off all the switches and flush in-progress calls */
>  	static_branch_disable(&__scx_enabled);
> +	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
> +		static_branch_disable(&__scx_tid_to_task_enabled);
>  	bitmap_zero(sch->has_op, SCX_OPI_END);
>  	scx_idle_disable();
>  	synchronize_rcu();
> +	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
> +		rhashtable_free_and_destroy(&scx_tid_hash, NULL, NULL);

IIUC we don't unlink per-element nodes here, but we just free the whole bucket
storage, right? So, nodes may still be chained in task_struct for live tasks
(leaving a potential stale state).

I'm wondering if we should have a teardown function, called before disabling
SCX_OPS_TID_TO_TASK and destroying scx_tid_hash, to explicitly remove all the
scx_tid_hash entries via rhashtable_remove_fast().

Essentially the order of operation should be:
 1. disable all tasks on scx,
 2. drain all tid hash entries,
 3. allow forks again, turn off static keys, synchronize_rcu(),
    rhashtable_free_and_destroy()

Am I missing something?

Thanks,
-Andrea
