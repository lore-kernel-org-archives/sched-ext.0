Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB53E0C59
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839779; cv=fail; b=t7SLOrosSvby5Xtk1ZapO376rKcVqIcwUKmLwaEvKz4XdbcYC71/C5+ZmhaCg8iFkOLUTjIP+UMVN604pHCpRGAOs7sQJmrc3/HL7V+zsaJ/mRrDygj/TWaoCw2uXQTGmkBjj2oJNOxankoi2qvqFiVjYhoohScLwgw8Vzhq+T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839779; c=relaxed/simple;
	bh=cWu8f0IT3gOoYev/1AblTYkyvZE0qMvCjGGkon/LxKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fArYY7UVmoWH34BmbiVTzIHza1iOrSoKKHJtTsjJwJwpD4Jo9YZCAQjuHlOIlxdhRayOj6dJTWr27lVhyZ/aWjdyR3FRf1sDYh2e5OX+K4+tYfqoRNXeNWONaTVUnicGpAB/eczFMNyiAMZcygsHIapdtDQXT3UXqTruGYSKYsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcJ+Ff3P; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcJ+Ff3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O15CN44ij4TR6otZyE2Ta+ecNGsKdYKfhpqQaz2u51JoXzkrg+6Op+asG4/xDR74jgY+apW3u6FBHFGg6gN/Om1ngK3h1B3Rj124xguS4MTYhezDT9BnY9GonPYqRHRFk8K3JKgqOt3r56H/8baGt2HUDA1+mhdY9l2wQ+8/TBjGgi6rTeXocTY/+N6sYnVBcolruvSaul4gWkYJIr4/XvGv8YyssJi2F/drGzskt64llZgBiDaHEKbHIHs9RXDDtTcelyjSNswIwjQ2FBewwynRW0p5EvLa7TDxf1NVJvIeJ74/eSIuPyjy0R7JSKjfcLcnGL/n6UP3okShK6szYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifCOLmyvQYu+h+bqagY4JPSlEO22KBwNhl+vYE9/kkQ=;
 b=eASiE+RAQxz26CLH1cjcoKdkE5eLC+mOh9o6+fVe+Yo9xov8cY/gPwcdBs6IKaFlBKrgZpVWErqxrECKT/NsD005rt1vQXPnnjShMsRjsZwcygiRS7BFFSOivPJ9lFzFvsF3XyMAsL9TcUCU8L4gTkP/ovcyjDrF52Nh+pOJMSw7XxMPLtqQalSseQvHS9o9KL+zEpQEgVpG7388wdfmgQ1JQ4nKRqAky9RYyPO5+0nX9De+jfwZIKpbnBsFW657RnIgiYOF4L5aUFI7io1Ds/ZgFuOM48Rw48QOr8Ss26rSk6km4Cpw6MREQrK05zUP/1J9JNRr7HPiwEUmXYmGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifCOLmyvQYu+h+bqagY4JPSlEO22KBwNhl+vYE9/kkQ=;
 b=CcJ+Ff3PkfsdhdNMYYmrNZw9nNXNKyn64xJXse/fjZRualRBq/dBCelPM4NGDWyC2PbdBlvvrxmPVPnXqAzVxori40iHOjpAvX1lLRX+qdKkvrvkEGwhFYNSEk4ITWrLk+QvlJHc3m+CUzSgXG8O70BNO1TIN/ZB+WY9KMywdPOI1ruyadey4dwVdCIfK0Urp2UTAu78cMqSjxxNB8V2d6dqyf97+ks26C5AO3rNUTkNA+xQkD7fMeKKlC6qMCEcN4pUp9s8RhKiNUBbiva0Lh1d9o1nGksPnTe8eykOpadcFND9o1HU1GEUOF7RrTFwAUxM09uhoG2W1bdXwF5kGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:49:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:49:28 +0000
Date: Fri, 10 Apr 2026 18:49:20 +0200
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
Subject: Re: [PATCH 07/10] sched_ext: Add verifier-time kfunc context filter
Message-ID: <adkqEKzzb5xPcUMc@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-8-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-8-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44f) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: e3af5f4b-64e9-4e69-d6a4-08de9721215c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R/6K0R3JFKJmp58SXdl9oPWZA+u2IKpZgr+rU5bH1Dkh29HJWp/Qs3+IB+3ItQmz0NtXYY7VtRC4DTnEqJ0yeSG0UH7n+HQ38rqFgxcCPA5L+2HdS+Behk5DfJF53ht2YQB/Vj50Yn/Osbx3LyRp4YUXloFCHnEV6efI7FTpymQcSFG6kj/mCKl7g9t4OgwqIg6r9kTIdkouR6a1C3LdXmWF/oasvF5AhMRsEO8qbrT0HzzMi3M43Hw1ZqMiWsxjU8YVz0BeDqKhgGu4pCxIu1qfYPq/UIIdeVIndULAAZyw2xtHCtW2B2pf39LTK4SbXYCENy4MO6ao2srC/gSeeYpbl+axywK3w3q2LlRqlQhYkC2Ei1AGLRCnVUGKSiV0bBy7JyFJwwwcwEvbV47BmkL8TrNf5Q48p2q/vXiXeapoWDwZp6sTjEsy76nRNlW5oJ15MUC/3d18UxftSy2olbRF3xg5rbIzUgkF1Dp8t6bvU6FmAeIDyJvarh+E8IxVO1yutAJ1f2T1zs/ulVAATDPcPMoRT5peXlbGO5IkskvK4nS9v9NebYeoHD/MnB241/N5DvhK6YHr7AfsvcnF+JQmKmW19TsjW0twk5wYdcWHRcie73BJRAP5v331KtGyVwV1mhcCtpgr7NULwL1tq2D8uTm+Lils1PqESLCFSxg4xTOen3lbks72WulS0ThK1WQBugEW5k81bJcpxbXhhoJWpeZPOYDS0D1UL2pCGFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xD/ktztMmLs79l95LRxPu9Qvbfx/b0iorRr+n6haUWWvoLtyRhhzN3cJsTK4?=
 =?us-ascii?Q?w5X+MmZwnXa1x1OnOSdmAQH5nfcot/A+Zz8BqGdnxeL4rQVR3M/jPUaoBRs1?=
 =?us-ascii?Q?OSa7rJywub16yYvYLYz18n5CVV7rryHh2M4El9l4p3Wjg3vrJzm86wGHFcMS?=
 =?us-ascii?Q?uRt1ue8k3LHSlkvNKcXxFGPtQZon8wS/wAWJWU/gi9hGFo53b+n31y27g/u1?=
 =?us-ascii?Q?aOdq12rEvoZVjYgu8MRTiLagLZ5kW2+wBxAADzpfvzxdn+GkRUnDT7Ug5qlf?=
 =?us-ascii?Q?HIrcjQVTjdT5gGQQ2yHleks4+9fqo6rDUIHZqn4wpk9geuQA6YEoTE/1v+zU?=
 =?us-ascii?Q?bgzQF3WuyKfuiqgFp2zpvmzdzCTc+v8FP5ws1mlF7z2nxYm4i3jigyRTQgFw?=
 =?us-ascii?Q?IbXjcRrDmi6tedhcNGOMOtfGjOcO6OoL5vS+zjpeO3PsM4DAE2ckFa+GeWMH?=
 =?us-ascii?Q?N+IxSsWnuin1ECH00c04FGZKjxd78/lz13vdrfF3u8810JUlHuB7gmBExaar?=
 =?us-ascii?Q?hW/L/dAJnduAnVZC2yza9GpGGDFgxMLURResM3O2ALoY1OsS5x42xLNsE1Gq?=
 =?us-ascii?Q?F//1eIUUKsDu8cW1697m+keVmKe/7+fevhFA6r9aGf7wFOut2zCuw+RmakJx?=
 =?us-ascii?Q?LH8ImytnFNxCVb655/4TKvT8AbBr9a7EvFGBxUOH/IZCQqA4WeMswuwh4gW4?=
 =?us-ascii?Q?z7WmULByzaHig0wNdUuchhvkhmya0P9fLB0YzMzi1ELakndlXjh9tcADZC3Z?=
 =?us-ascii?Q?p1KzZ2X7ihT4o4xJRvKw0wqKMok9oFcR1UsdgTfvXL2s8TggMdv7UMVQrDGR?=
 =?us-ascii?Q?pV0bKOkycNpW7jGuwm1B6lld1fTtbjWCjr/KcldUhBhcD/5wkVpt2jn9uqdr?=
 =?us-ascii?Q?yCK8XIN5LBwJe8fIbzuIf1ZyvF3zx22Nwh61bZEENxGLjla5OOC1wGiG8XED?=
 =?us-ascii?Q?lxHmE1hpIf3YplsH8FNf2GREHrPlfyVZqRG5g+/KvRHREAz5WG52YIW3bCKE?=
 =?us-ascii?Q?/dMDQcAf9xBbRKiq7WBd2XNaeo5k6pm1oMguApW2e5/2nXvXg0vPhImcfalS?=
 =?us-ascii?Q?QK1I3QDY0gGt1+qgTtplHktRXTyJ2kd3K71w2SSxNC4tvowZOqsX2rJT00YZ?=
 =?us-ascii?Q?LnHnYhvl5NkNA+pEyOKruhiAiQWfbOCQ4qvOYR5gP1Qm1UVZjZwa2FBBxsjw?=
 =?us-ascii?Q?tbCJH1QvcmmFs4Dr536grbIvykON+lwQHuw7ZeeMRKIXf/gqUmMrYHKJ2p6l?=
 =?us-ascii?Q?JkTqX0RNcJP45laru38Osvp9faCkUj0dGC5P2Ua+Oyj8wo4KkNAR+Xmcg2rQ?=
 =?us-ascii?Q?LGc0E4dlibiErgcYE9b5nDqoPRenNpZMD4xBTkWfZuLticymJOh/NwsTzHs9?=
 =?us-ascii?Q?dFsddh9JcKgsPj+MYMZbFWci5OPAQ1i0EUoi/+sATbkoXEXY4FMl32dPAqaw?=
 =?us-ascii?Q?3RKfHaVykpXlijs7COS5aDg1pTqcs4HXetUDDkO1GlLhDNwb4qJg/AeE2zdH?=
 =?us-ascii?Q?2j9BzokR35UgUg71JEf6/4oyCCMj9+vvr3FTYUUxNwChu/8A9asXQpAjGI5W?=
 =?us-ascii?Q?Q5Ql2f6zaaiv/R4l9bSTQkvIqYRq6OGfbwyRLQRPu1/MAp3OrSNp6gQcNW29?=
 =?us-ascii?Q?Lq7ShJTCRl4TMI1BH59ijY6c9e0onDD+iPtzZiRtfydILWZJ+OLRDP0BMdpM?=
 =?us-ascii?Q?0txeMeCYs7wEU4CvY2pWTsqFX5Q3+vn/5ntTJIuGaKSgIRnEv+m4ebrfNPsy?=
 =?us-ascii?Q?o+CRy/+Wrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3af5f4b-64e9-4e69-d6a4-08de9721215c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:49:28.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3YvYA7eipSlRNAqpwEfxpx433xFf2rdkfu0UGQ5Eg8OZWzS/d8w3eUaK+QGRa6Qn/362Y4EyCrikhHBQVXOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

On Thu, Apr 09, 2026 at 08:30:43PM -1000, Tejun Heo wrote:
> Move enforcement of SCX context-sensitive kfunc restrictions from per-task
> runtime kf_mask checks to BPF verifier-time filtering, using the BPF core's
> struct_ops context information.
> 
> A shared .filter callback is attached to each context-sensitive BTF set
> and consults a per-op allow table (scx_kf_allow_flags[]) indexed by SCX
> ops member offset. Disallowed calls are now rejected at program load time
> instead of at runtime.
> 
> The old model split reachability across two places: each SCX_CALL_OP*()
> set bits naming its op context, and each kfunc's scx_kf_allowed() check
> OR'd together the bits it accepted. A kfunc was callable when those two
> masks overlapped. The new model transposes the result to the caller side -
> each op's allow flags directly list the kfunc groups it may call. The old
> bit assignments were:
> 
>   Call-site bits:
>     ops.select_cpu   = ENQUEUE | SELECT_CPU
>     ops.enqueue      = ENQUEUE
>     ops.dispatch     = DISPATCH
>     ops.cpu_release  = CPU_RELEASE
> 
>   Kfunc-group accepted bits:
>     enqueue group     = ENQUEUE | DISPATCH
>     select_cpu group  = SELECT_CPU | ENQUEUE
>     dispatch group    = DISPATCH
>     cpu_release group = CPU_RELEASE
> 
> Intersecting them yields the reachability now expressed directly by
> scx_kf_allow_flags[]:
> 
>   ops.select_cpu  -> SELECT_CPU | ENQUEUE
>   ops.enqueue     -> SELECT_CPU | ENQUEUE
>   ops.dispatch    -> ENQUEUE | DISPATCH
>   ops.cpu_release -> CPU_RELEASE
> 
> Unlocked ops carried no kf_mask bits and reached only unlocked kfuncs;
> that maps directly to UNLOCKED in the new table.
> 
> Equivalence was checked by walking every (op, kfunc-group) combination
> across SCX ops, SYSCALL, and non-SCX struct_ops callers against the old
> scx_kf_allowed() runtime checks. With two intended exceptions (see below),
> all combinations reach the same verdict; disallowed calls are now caught at
> load time instead of firing scx_error() at runtime.
> 
> scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() are
> exceptions: they have no runtime check at all, but the new filter rejects
> them from ops outside dispatch/unlocked. The affected cases are nonsensical
> - the values these setters store are only read by
> scx_bpf_dsq_move{,_vtime}(), which is itself restricted to
> dispatch/unlocked, so a setter call from anywhere else was already dead
> code.
> 
> Runtime scx_kf_mask enforcement is left in place by this patch and removed
> in a follow-up.
> 
> Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
> Original-patch-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c          | 124 ++++++++++++++++++++++++++++++++++--
>  kernel/sched/ext_idle.c     |   1 +
>  kernel/sched/ext_idle.h     |   2 +
>  kernel/sched/ext_internal.h |   3 +
>  4 files changed, 125 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d7c5c2605c7..81a4fea4c6b6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -8133,6 +8133,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>  static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_enqueue_dispatch,
> +	.filter			= scx_kfunc_context_filter,
>  };
>  
>  static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
> @@ -8511,6 +8512,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
>  static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_dispatch,
> +	.filter			= scx_kfunc_context_filter,
>  };
>  
>  __bpf_kfunc_start_defs();
> @@ -8551,6 +8553,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
>  static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_cpu_release,
> +	.filter			= scx_kfunc_context_filter,
>  };
>  
>  __bpf_kfunc_start_defs();
> @@ -8628,6 +8631,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>  static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_unlocked,
> +	.filter			= scx_kfunc_context_filter,
>  };
>  
>  __bpf_kfunc_start_defs();
> @@ -9603,6 +9607,115 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
>  	.set			= &scx_kfunc_ids_any,
>  };
>  
> +/*
> + * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
> + * group; an op may permit zero or more groups, with the union expressed in
> + * scx_kf_allow_flags[]. The verifier-time filter (scx_kfunc_context_filter())
> + * consults this table to decide whether a context-sensitive kfunc is callable
> + * from a given SCX op.
> + */
> +enum scx_kf_allow_flags {
> +	SCX_KF_ALLOW_UNLOCKED		= 1 << 0,
> +	SCX_KF_ALLOW_CPU_RELEASE	= 1 << 1,
> +	SCX_KF_ALLOW_DISPATCH		= 1 << 2,
> +	SCX_KF_ALLOW_ENQUEUE		= 1 << 3,
> +	SCX_KF_ALLOW_SELECT_CPU		= 1 << 4,
> +};
> +
> +/*
> + * Map each SCX op to the union of kfunc groups it permits, indexed by
> + * SCX_OP_IDX(op). Ops not listed only permit kfuncs that are not
> + * context-sensitive.
> + */
> +static const u32 scx_kf_allow_flags[] = {
> +	[SCX_OP_IDX(select_cpu)]	= SCX_KF_ALLOW_SELECT_CPU | SCX_KF_ALLOW_ENQUEUE,
> +	[SCX_OP_IDX(enqueue)]		= SCX_KF_ALLOW_SELECT_CPU | SCX_KF_ALLOW_ENQUEUE,
> +	[SCX_OP_IDX(dispatch)]		= SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
> +	[SCX_OP_IDX(cpu_release)]	= SCX_KF_ALLOW_CPU_RELEASE,
> +	[SCX_OP_IDX(init_task)]		= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(dump)]		= SCX_KF_ALLOW_UNLOCKED,
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +	[SCX_OP_IDX(cgroup_init)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_exit)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_prep_move)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_cancel_move)] = SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_set_weight)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_set_bandwidth)] = SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cgroup_set_idle)]	= SCX_KF_ALLOW_UNLOCKED,
> +#endif	/* CONFIG_EXT_GROUP_SCHED */
> +	[SCX_OP_IDX(sub_attach)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED,
> +	[SCX_OP_IDX(exit)]		= SCX_KF_ALLOW_UNLOCKED,
> +};
> +
> +/*
> + * Verifier-time filter for context-sensitive SCX kfuncs. Registered via the
> + * .filter field on each per-group btf_kfunc_id_set. The BPF core invokes this
> + * for every kfunc call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
> + * BPF_PROG_TYPE_SYSCALL), regardless of which set originally introduced the
> + * kfunc - so the filter must short-circuit on kfuncs it doesn't govern (e.g.
> + * scx_kfunc_ids_any) by falling through to "allow" when none of the
> + * context-sensitive sets contain the kfunc.
> + */
> +int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	bool in_unlocked = btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id);
> +	bool in_select_cpu = btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id);
> +	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
> +	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
> +	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> +	u32 moff, flags;
> +
> +	/* Not a context-sensitive kfunc (e.g. from scx_kfunc_ids_any) - allow. */
> +	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release))
> +		return 0;
> +
> +	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
> +	if (prog->type == BPF_PROG_TYPE_SYSCALL)
> +		return (in_unlocked || in_select_cpu) ? 0 : -EACCES;
> +
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +		return -EACCES;
> +
> +	/*
> +	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
> +	 * guarded by bpf_ksym_exists(), before check_attach_btf_id() sets
> +	 * prog->aux->st_ops. Allow all kfuncs when st_ops is not yet set;
> +	 * do_check_main() re-runs the filter with st_ops set and enforces the
> +	 * actual restrictions.
> +	 */
> +	if (!prog->aux->st_ops)
> +		return 0;
> +
> +	/*
> +	 * Non-SCX struct_ops: only unlocked kfuncs are safe. The other
> +	 * context-sensitive kfuncs assume the rq lock is held by the SCX
> +	 * dispatch path, which doesn't apply to other struct_ops users.
> +	 */
> +	if (prog->aux->st_ops != &bpf_sched_ext_ops)
> +		return in_unlocked ? 0 : -EACCES;
> +
> +	/* SCX struct_ops: check the per-op allow list. */
> +	moff = prog->aux->attach_st_ops_member_off;
> +	flags = scx_kf_allow_flags[SCX_MOFF_IDX(moff)];
> +
> +	if ((flags & SCX_KF_ALLOW_UNLOCKED) && in_unlocked)
> +		return 0;
> +	if ((flags & SCX_KF_ALLOW_CPU_RELEASE) && in_cpu_release)
> +		return 0;
> +	if ((flags & SCX_KF_ALLOW_DISPATCH) && in_dispatch)
> +		return 0;
> +	if ((flags & SCX_KF_ALLOW_ENQUEUE) && in_enqueue)
> +		return 0;
> +	if ((flags & SCX_KF_ALLOW_SELECT_CPU) && in_select_cpu)
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>  static int __init scx_init(void)
>  {
>  	int ret;
> @@ -9612,11 +9725,12 @@ static int __init scx_init(void)
>  	 * register_btf_kfunc_id_set() needs most of the system to be up.
>  	 *
>  	 * Some kfuncs are context-sensitive and can only be called from
> -	 * specific SCX ops. They are grouped into BTF sets accordingly.
> -	 * Unfortunately, BPF currently doesn't have a way of enforcing such
> -	 * restrictions. Eventually, the verifier should be able to enforce
> -	 * them. For now, register them the same and make each kfunc explicitly
> -	 * check using scx_kf_allowed().
> +	 * specific SCX ops. They are grouped into per-context BTF sets, each
> +	 * registered with scx_kfunc_context_filter as its .filter callback. The
> +	 * BPF core dedups identical filter pointers per hook
> +	 * (btf_populate_kfunc_set()), so the filter is invoked exactly once per
> +	 * kfunc lookup; it consults scx_kf_allow_flags[] to enforce per-op
> +	 * restrictions at verify time.
>  	 */
>  	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_enqueue_dispatch)) ||
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index f99ceeba2e56..ec49e0c9892e 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -1491,6 +1491,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
>  static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_select_cpu,
> +	.filter			= scx_kfunc_context_filter,
>  };
>  
>  int scx_idle_init(void)
> diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
> index fa583f141f35..dc35f850481e 100644
> --- a/kernel/sched/ext_idle.h
> +++ b/kernel/sched/ext_idle.h
> @@ -12,6 +12,8 @@
>  
>  struct sched_ext_ops;
>  
> +extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
> +
>  void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
>  void scx_idle_init_masks(void);
>  
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 54da08a223b7..62ce4eaf6a3f 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
>   */
>  #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> +#define SCX_MOFF_IDX(moff)	((moff) / sizeof(void (*)(void)))
>  
>  enum scx_consts {
>  	SCX_DSP_DFL_MAX_BATCH		= 32,
> @@ -1363,6 +1364,8 @@ enum scx_ops_state {
>  extern struct scx_sched __rcu *scx_root;
>  DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
>  
> +int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
> +
>  /*
>   * Return the rq currently locked from an scx callback, or NULL if no rq is
>   * locked.
> -- 
> 2.53.0
> 
