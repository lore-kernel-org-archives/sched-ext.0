Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D23C3C0C
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837248; cv=fail; b=EANRyzSc6nw9a/aJ+WMQRpKM6jZhITvuXO/wPcbwV/YZAW0ygmcbjtgXoKUoZbs6shBrVp2WVBvCb50XY0sw/AsEr3IDxrnMxw7adpD9XZkiO0eQmJERd5tdfb2ij26Zkpm5Dr5hMiStzmHc/igPfuvF7s8ydMGndymgb9havPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837248; c=relaxed/simple;
	bh=anQ+lPWfAJDrSvQx8PDtaTRNfr4CaBqH2hLamHZZHr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MaJ7PTmJ1F4v/IjupnbHJDjFdfgCZRcTymW+8iek/Hcv/QZASSsz68CM8aqWujrLuL+WhYrybnuQMwPqDhhsFzlOGBgWK1miiSS5nVhmjyNJZNFR+orYLqrXxo5HUSRZhg6i9smwi0T54YWmgnuvXP/1OhfhLCKrjl5Jx8hxK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cvxJph8t; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cvxJph8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxKJ9u9AG2bFlAYuL4xKo+zfpicc8i5rjit7D6JAHx544cVqO/uc+wKzmbLoBPovh+qoy6xb+HlcVnm+MWws7hZ26X1umfLXwilgXpWFwiFtN0VT8N1tfJrGBHinzK56R8aQf7o3vN6wiprVqnyCQnoPmf7HsQ2KKBLgJEQCe9tH7MLe7GEiVIuuk5aZBzl/UA37KDdl5anFZ48aMcJv55ecR4qvVMXV87PTsejHhO4AlDqzX5m/UjAPZv59cqgGCe+0vQzmtEq2ZgfNlHOgIq34xsonsJ/aRnEWyjPEu5cvAXis9HQRkOvumFpV98GRt7xa5Z59/4hx4cDpo4126w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYZSGLTTT/U9x4A27S8yKvMH/Y9PNa1Xac01vrhp+fk=;
 b=urZdaZss0b0NmxQ3nBpVwHtNwiJZS7NHIhC+W7Ugrzx2ahB9QYAZe6naNs41QIxIvlW+dfu/h1kNsnuYHTEdIGhMZ+TkOrzGzSJYdPJXo8irmQVq8/B2nIGfVtFg65bUpzaVrmHi49mQW9Xf/lyMaqYjZ23u0LV4laCSSBIUaJzGXu5iIsUjo82rrfHdHd1mO04+Xr13Se31PvVMcVTUwttqJlpd5mDd3bdgRdBNJlzwRFbIE90HDodqYw6yK8EWBOWig3Ym4eJAvWm7HWFKNY0yjAGnVfGhbqDBpaPYwm0n97sqICtYcM+9ibcGkrlI5BFnAV+sKIAHCXKlNG1Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYZSGLTTT/U9x4A27S8yKvMH/Y9PNa1Xac01vrhp+fk=;
 b=cvxJph8t5K28Yj7umtfdy6hXbWGuHO28EYUnzo4tm3UZdTzTty+K5cRs1F9R8RNwayRl7BCe+3yqfvEW5DGiLasr/KREG3kbHBZghLteKFbL1hSq/p5+y9zIEKc+VpNzboDzSAUpdFzRqgYgYE8eshZYNC0aYe3wRIVL6J1A1SBsYFR63icN09KjsiEW3VOeU4sp61XHXl6DN/iNKZOl4QVEwRAJzaLGmQH7OCDEsAR8Hw9vBSO6HmZbzG9r3gcjibJlO/mh8ce7KSr4Fhu7WW0j6Gs+i3t7S6bqjxTrVfZjWL5k0mT0UkUfSdiaoxiD2Az7g2KnaU/59ZLKochH4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 10 Apr
 2026 16:07:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:07:23 +0000
Date: Fri, 10 Apr 2026 18:07:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] sched_ext: Add select_cpu kfuncs to
 scx_kfunc_ids_unlocked
Message-ID: <adkgNHHwGL2uM46o@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-3-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b217b7-be1b-424a-cac7-08de971b405c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cx6JV391NVta4SSjuZER1CkzlrrQlJY2a4rn4rkcLU/59EYKbsYDpaTOMtAlD6wqeMpdoHvefq+x7Q9J2Db/Og8QMQH4TiHUaq5ReZ8qCxzTyI6J36AdwdxWzF1frgKu+NXdgF3biZvMKVkiIaSos9SQuCBXzoSX/aCP9oS3Eoeo9sMDqUTVdSmuqwvSSVLjuWllJ84gAA89QjKsLNnPW/hcdU8fgbw8IWvaBrqSNJd7U6VLYX5duuGqzw986MupfpunD5Uur7SqRDA7G3BeVfa95iqZy9bLUh/BJUSCPdRl6vgbSMwsB+jagN0dRFDIj0L9bOXuZ1tnnLuvqegycckP64E4ufhZmPjUkKhDtqIk+IztiPYYdmXkVbRwKorDSSSnkAiOlqqpLLFcP09WWRGKsxbQTemzBcXxB6/dsN+G2lJBMrbVa/7XXdaE1HMzQQJjjvemd44MdxqT/cQrHiBe0PSjcjbwutXBsZ0lua0f7YT9AIkDwul6dXaLKtwFP7fi/5XHSG0uKZm7jYPHQZZS+Sl9xouisVjkYWw3FqWxgLF30eOCl1ZBGtQI/UllN2cZxfKZYTHwoBIipzaYI+KfcRZ84mlXGpI++LR7h8Et3LmFSatRhKkg/x7EF/3MjA4P2suRXev0YMJNjXiVqpx/22QKofb1okmbHF7TwveG39lJYdoSI/p5lkXzv1LlOUqnRTPiVgH+hTx+MczgDz8FoWXvBuqg3IjEmLtv5YA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RmpSf0DZJos9neNK/WEfxWDoIF7PuL6YArWX8yD4QmgKgxv8/1ZZ2L8Fip7V?=
 =?us-ascii?Q?hUSLAmuEoebxNWX58xYVY2EchQNswQ23UJqBafTi1CFDrcKCmZsEm2RSxTno?=
 =?us-ascii?Q?1A71VOezsdJVTYQ8pE85b6wNfzCN2H9LlnXxZ2JXr5xyR4DmWhmSSd8BF6MD?=
 =?us-ascii?Q?+J6XtBPNUfRlHA70Iy37PzHhxxMGU0Mot4r903TSFWRYvWscxghUZ2ljn/AX?=
 =?us-ascii?Q?kNmVGOfgtyErv+8pgmFtLULJarrB+uy4LTco/i5dp4mq6pXjN7TSRyNTMvLi?=
 =?us-ascii?Q?Afb+oAXZE4NGwkq2A70QSqYSjuowKDFGDMUbGkmuWIxPDD0VEevJCGOdVoZl?=
 =?us-ascii?Q?NFUpvVrBYDjYYx1CCzYJcjiT1W/ElNDjjYWU+hby2CJyhKVoegbuB2QTUt47?=
 =?us-ascii?Q?R4KrH8vjq+awDSgnuNdCs+R0x3xd8fnnLK//V+kXz1gOu7x7vJRIL5ULti6U?=
 =?us-ascii?Q?E73xjqFqFYwnn2C97TeQLnAiPsSiCf+llM9jqu6EP7pYwSjjzv0fozklB5Pk?=
 =?us-ascii?Q?tdSRhv8Eirn82nY5D5cGDBvjWvpzgxTXYoi6F/OapbJ1HU5E5+iyVw2vrFpq?=
 =?us-ascii?Q?diJmSa+z01uoOqbE7KLhG0JWw+2Ao3AwKnuxnFp5tqAghqNXYx1X9yf9zMpd?=
 =?us-ascii?Q?xGrSQBHH71Cva4Mll+Ch/eEFvfWo1h559Se986HlpbjSwnUkavTlbqyXrx4d?=
 =?us-ascii?Q?bctacwV/L75GBO/ZMKF/hXfYLffzjZk2VKhDEodaBuCT/UtACRtruF5114qC?=
 =?us-ascii?Q?kCenZwU83wiQVAPqIkToEmws20jcLrmWaarGjkM4xc2zXmC/ddf221F3w+Bw?=
 =?us-ascii?Q?UYvys7BiR0PSai6Rh6QPNq7R2u1pjuMT8/LbB7EuoNEtvefWYQWU22mndi22?=
 =?us-ascii?Q?rdrnUrkrV1X+UZKoUsxfSchqpUJTTFJELQAj5uC2k5Y7rWWXZHNj6rSAt6s5?=
 =?us-ascii?Q?5uCey67RUCcXECyN8gZiwvyPaKVnvyCoZpbhFUv+sGK/rYDqrdtPqZzznvTg?=
 =?us-ascii?Q?xd+CwutV9o9407SCUFZAxDZAk6wDJO/bVGOay2vFncKyD+PDe1ttS0Ry72vv?=
 =?us-ascii?Q?wH2in5CQwB4hLFVzmL9DphOzRfkiKXkJTx7HWVDjcDAmMvaP6tK1g03UQEla?=
 =?us-ascii?Q?1awkmKWxRjpO2SA/hmPGCDBBIMDZkGFwvo3j5XLdqP5zOAPcTubhN6qFZxOW?=
 =?us-ascii?Q?v/NKmZ4J5kTZRFrahuVywVAzxPcafGUeL1AS8/wA7d5NWlf4Glm3q2h3xllt?=
 =?us-ascii?Q?7fZ2L1wvweFOpFHeVdxJKa0NFsuV95F8ja5aLsPM11z8RG0F+Eoxk4kSC1ff?=
 =?us-ascii?Q?s/BtoMBb3GXw4NlBZleKGFnGta3/HRo6vAx25nba01mtdGW11BceyQqjQG6w?=
 =?us-ascii?Q?XkU7mFC75ltV3CJ4ajqXxF+N/JGD+lCtpk6aCAXhe5RFGaMdLRUXznWlxYO6?=
 =?us-ascii?Q?7J8iZgNvU3kNjMhb0elrO9iXwx83XZHAFhClzXflACF2D1ddkEW+hpmdnwls?=
 =?us-ascii?Q?RFPgieP+unWMJ8f+NwuT/UGxTCYWs5iOZ4H4sxTJkDgY3MUq8U++x9SHUnQh?=
 =?us-ascii?Q?cAA0wc5WsLHeaJH8Js9ezbJyVKs/D/7r+yPXv61B1Nij48W7p8PJpTFR/nGo?=
 =?us-ascii?Q?1lLKtxIQFwS4qKY3Wxm7e0oLf/PUeNg8FgNdjT7gyTLayfSYnPmGEqs23pSM?=
 =?us-ascii?Q?C2DtarG3Rgu01Ry0MfHgY/eS985JcjYtBHqq+7UGEN96+gxnvCg6iB5VrSfK?=
 =?us-ascii?Q?wBsKO5zB1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b217b7-be1b-424a-cac7-08de971b405c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:07:23.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQo3QFSgKLkSsqUCRBfrqlrGEnvtgTuISHb/W7DIwzaZZMfpp5hY0C1kxgFEteo+7chl2QXh64dLdapxIWrzdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

On Thu, Apr 09, 2026 at 08:30:38PM -1000, Tejun Heo wrote:
> select_cpu_from_kfunc() has an extra scx_kf_allowed_if_unlocked() branch
> that accepts calls from unlocked contexts and takes task_rq_lock() itself
> - a "callable from unlocked" property encoded in the kfunc body rather
> than in set membership. That's fine while the runtime check is the
> authoritative gate, but the upcoming verifier-time filter uses set
> membership as the source of truth and needs it to reflect every context
> the kfunc may be called from.
> 
> Add the three select_cpu kfuncs to scx_kfunc_ids_unlocked so their full
> set of callable contexts is captured by set membership. This follows the
> existing dual-set convention used by scx_bpf_dsq_move{,_vtime} and
> scx_bpf_dsq_move_set_{slice,vtime}, which are members of both
> scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked.
> 
> While at it, add brief comments on each duplicate BTF_ID_FLAGS block
> (including the pre-existing dsq_move ones) explaining the dual
> membership.
> 
> No runtime behavior change: the runtime check in select_cpu_from_kfunc()
> remains the authoritative gate until it is removed along with the rest
> of the scx_kf_mask enforcement in a follow-up.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Minor nit below.

> ---
>  kernel/sched/ext.c      | 6 ++++++
>  kernel/sched/ext_idle.c | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b757b853b42b..cf441fb4b1ad 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -8497,6 +8497,7 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
> +/* also in scx_kfunc_ids_unlocked: also callable from unlocked contexts */
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)

Nit: we don't see it from the patch context, but below there's
scx_bpf_sub_dispatch() which also seems to be callable from unlocked context
with this comment. Maybe move scx_bpf_sub_dispatch() before this comment?

> @@ -8612,10 +8613,15 @@ __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
>  BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_IMPLICIT_ARGS | KF_SLEEPABLE)
> +/* also in scx_kfunc_ids_dispatch: also callable from ops.dispatch() */
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
> +/* also in scx_kfunc_ids_select_cpu: also callable from ops.select_cpu()/ops.enqueue() */
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index cd88aee47bd8..8c31fb65477c 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -1482,6 +1482,10 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
>   * contexts where @p's pi_lock state is unknown. Keep them out of
>   * BPF_PROG_TYPE_TRACING by registering them in their own set which is exposed
>   * only to STRUCT_OPS and SYSCALL programs.
> + *
> + * These kfuncs are also members of scx_kfunc_ids_unlocked (see ext.c) because
> + * they're callable from unlocked contexts in addition to ops.select_cpu() and
> + * ops.enqueue().
>   */
>  BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
>  BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
> -- 
> 2.53.0
> 

Thanks,
-Andrea
