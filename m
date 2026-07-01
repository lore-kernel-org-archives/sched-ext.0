Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAA40DFCF
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900266; cv=fail; b=qi4/Jotdh1mheejE5Jy00Jb/3wziD0xoESN2GvyLY7ROOJ/7Q2dEVcWGFSmMvwAp0aRkQ4UisrQGJbybFDMmqG0wiey5JRg7dxHodVY820d+hp8eMgJ4ZemHyKspIe4kIm330U6iNSAtvo8gL8WgwdV0Iuf833tO6VggO7WUk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900266; c=relaxed/simple;
	bh=I/WrQ3cQHrVODbr0/kGf8mF4wja70s3XWRH+EZM2QZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kqBMis5VV4k46CaurofMZ74HW6obfFmqrZ61+H37MJPX7T6YQNRlpmQghuvg8gV+YvE9GQ2is+1zfrKqFeyOCRDd3LRDHUhJqvTPUi15RKP99k8XZoixdQGDRieFgtbVvN9xVSNz1/uw+e9UioUUT+cJGxYJ12Y0X+MShdVIS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0NRWnDR; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0NRWnDR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjSRX9/orgS2bpbzgbfZHh6mSUhDi6YjcK0RWMd8OIokKxA1NlCKDdxJs/zXi0eE9l/NC3uVw3tBIR41TmRsyb6adjmp+axAQQCzWA3YIb1TlqtHuTU/CPSg1s/FptwZn6PydZ4X7CRk5NJ9xrzOUMoy7pesfhODxZR0uDcHsIcUmc1ZEver6SATOD6hkr6yLdLMduC+oWCxSQxfxaym7qCpdoA0F6EPo7kCPCjkfV4kd/TeNoHDF+tyavlT+SGZmOA19KFpggVmv7S/NfRgxyms4TAKpNW/hjoeA/0/dVTwaW+icTBAY5tl/g2JHe793TYP7cI5rxGFp+uGj7xqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLGUiPH2WdmwoTCbbfzfxUJOXd0leNSom9BgLavyDng=;
 b=O+jUJOr70guUnFlcnsBvt+jIB0gKd+6xbJmjmVjgJXIwCtteRIaat4Be/bsNxMDexu0WvAYwTVijFQc0r8T04N43Gcb0tc6DbFMKPPK1MfPFpidzlhJR+Uo6f1nWW8moSNgM5MCRX7/XGZjmAN5pKg9OijqULbRrVJkobzNGBRVfqYgxEbwlNXX/6XNiSg6xQDqc4dIpdFif4bLhzKcKrWO5SsDoI+TN2qz9FKRU8eFneSWylHxmJCs2GyVpRBCkf72/58B2xdVMIWKJz1lx+Sr9bURLmTlhG6uiFV6PWzRYrQ6FNRUzfHag0G9DG8ExGieXXq/NM6x2fe3kf2YfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLGUiPH2WdmwoTCbbfzfxUJOXd0leNSom9BgLavyDng=;
 b=S0NRWnDR9Ru85CCi/FVjxNaXuB4irloCWUcnNYVHvaUfivvf2rf+JP/o5dZDvpy0P0v/2Aara9yvaCNzI1LNRqY46MFdHUqZttQSMXxujxPfOAC97+RcIyLSzzE42lDiMStSwSDm+EV+5PUBZlxg2lO7m3ICYu+42Zx2jB8kkR4kqjrSF4Y9FYfhdGujq3u2f1WTKRSfNc699Pur/Utdf3pClaSLGNl5XvwnFvIRPBX1arzEgxJ3FsdmAjRCmYksccQK+27JeMWrV+x8VGWotXWgJEFpoTiBbfSnaS6z+vPEkep+mn6EtQKRvVI4CJkecR8aw2N37ASBHJYoxLB8Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 10:04:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 10:04:17 +0000
Date: Wed, 1 Jul 2026 12:04:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler
 implementation into sub.c
Message-ID: <akTmFanypN_dRJiG@gpd4>
References: <20260701031429.1892218-1-tj@kernel.org>
 <20260701031429.1892218-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701031429.1892218-5-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a118ae8-4aef-45b1-2062-08ded7581c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|6133799003|4143699003|56012099006|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	jpCDgmOdqyG6OkDMlLLfLPuieWZEbeWwrOX4/FIdS+LZF8F5fxGWzDreLiaFnPuS7F0bDf5srJwXnSkFPi45w/SYFpx6ZmS3vbJ/o5oJ+UIs0tf2TA6glzcYmJhkw3Gy/DbqztN6iP7GKQQwlS4iw1XUdPP0gQ6PPqA/zrePlwbSSYfybzWQKHWUS7hXZG29jrrsdm4cLZbLtCoU31+d7yiqcILdCN/Fk4p3oGg6Uj+7GaJzM8OP3l1NonxEfSp1c0e31ysTtBRIeANjzTDe3Yp6FypbPN8ASo4Ybe4//Nwp+UD+k9OOSZFXSb0tHfdGNWELX2qWUu99mr0UGRnzNoj1ly+DHXmDrZVYpMKvvC3OmOrowLv32z6/afoaeMQYemKAkdK/d6AxS9ywXVE9WZpPD+DAi90mvE0V+7YpnUox5WyPwj8bXW8Kn72sYfKg56Vm/MgiABk3IDQ4dLIGrmKA5UblfAt99NIDp9AVplUgDAoZPfsZsMYSYUN8uxKWzucqmRzYWBvuw0o3jLz8316uIO93edwZ2XzMmfc0oLCdWkBLfAJFQhhGC3wM2a5IDoFIhYewzWOjf7U37Tcj9KVhQeVW2feXTvByIeegLBelTsvJwYlT1nv27r4d1F5JzZlWS8kwC42Jv/kVOTFKIu939bmOAX1xkysG8I0j1WM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dKPcAheik4AxZDUwTC1Af9rEh9pKbhT0VGRhfH7qF2u6Rzo9LysLA4yxeFBx?=
 =?us-ascii?Q?pweqH7ntL81Plyo6JUji7MscBZ5/HtkcAwtI6PJJWkq2XS4DJN6d33ZpSrzY?=
 =?us-ascii?Q?XQgC8t4mVGnnUERSzLAfQ4mWyfXTKxLNjt2LQRqzb/XBLMOO1D16TFONnZb9?=
 =?us-ascii?Q?NsDsF8rb+wg1fiITHfAk52o70oZ0wkinOvaoqvjd9ZR0hBJkP++i/vUY/MCQ?=
 =?us-ascii?Q?xLSYkbypLRX8q4rmpDsLzG6MFWBsUaEUlN37aPLvJHP0uJxCcKciA2lZnGKO?=
 =?us-ascii?Q?rHZBEOnGMcKry+aTnkhKobosfAjLihvX8EpaFpx+8MS4yGePA+nZ/6tcZ+gp?=
 =?us-ascii?Q?MAxpWuoNjezvG+ppnzIgxVufmr7q6GIcLg936Wx3OC1m/wXE9q7CuvbJfW3C?=
 =?us-ascii?Q?/+enekU/KyzKNHgqcUO9Oa/YgbjBZejO9KdwOJmNAGlPr5wvEfY0x4R2wDAz?=
 =?us-ascii?Q?hI5AdM+mqDNOFQdEwrP11bxGKET7pv+TcgdAWmgtG+z3YHVwP7+t6y/1lPhd?=
 =?us-ascii?Q?up3gkOHmQ9CXG91uAju5q/sOg89ud5WMyJuTudgQZHhuFgyGm1p0QFIDMbSD?=
 =?us-ascii?Q?h+Qjcnar8cx5IEdAx/7X97A0iaCyyGEmndE8S3NVsUwV2sjLh9gJbkRtKYBp?=
 =?us-ascii?Q?O2vdZh9cPGHzb4Ftf6ihfCsH3j1mCnz4nPlA8OIbRcT5j9lVCd8CfsZu2F3x?=
 =?us-ascii?Q?Yu+mK6m9gFm5KkJeJks6CQGFHzmZf2y8llZk6W4+LK0mjRsvsXkPovI25HCg?=
 =?us-ascii?Q?X3XjCPiIldhGXHc/D3OfAENxh48WlcZcFVFbzsBDQidSzPiMf3VPcO4eT63Q?=
 =?us-ascii?Q?1uxCAt9WW1ip7p1dL+WdRHr5fkc+hQ/3t8Mxl9t18QmqzOYKBbdGuncgKs/N?=
 =?us-ascii?Q?6v9Kz0ihU2XAxAlw7+uCBFwrXUo5KxlxRnbbajUu5Zjwd119hwW2fzQ/Pz5H?=
 =?us-ascii?Q?3ftWdvTkUOv0yNZBE5Ep4mXkNrtoHyYYMeXb/khR9A8ps9ky6eFc3+bXzK96?=
 =?us-ascii?Q?uhupYHcZmd+KJb/Kar8TeZj0rCQRdUe+DP9oYBZSPJPq+1dMYCDFfhY20VbZ?=
 =?us-ascii?Q?QZEK1g0uBdCGseSJpG5MkbtGMAO8jYhZYlPbXrqFY08tXLmRlmXF7VBrUdd/?=
 =?us-ascii?Q?vkq1JDaA3Xdg8qXsTrKUsfz9bWUvSeiM2PQgC+Ss9DYaEQDP+7gt3ExhM4Gm?=
 =?us-ascii?Q?vvhCGY3fBiSqnNJtvw3WPKf0n+LuUu0O/FNZ1E9Yw0x2QxwgDtzIimOjP6dT?=
 =?us-ascii?Q?Kt0q10QlDV8tDyZJTEvgJIs6lTc4GHcQd+0zmIH+VJjH6Qi9PobZSfh1UvHp?=
 =?us-ascii?Q?Un5rkb0yo2oXz1bO4Dw7QE8oW+yoAIdOSkyTS2Sqc3tDOUPwO/KDhKxc4BGZ?=
 =?us-ascii?Q?ERYW/Uw47ZRlZJwrH2pv+crDXdj8h47uz1talJ90YCOoS6PvGfW+rhK7IvOP?=
 =?us-ascii?Q?KYWCX6wgWYwpw84wtyR8T8yRwRMz40VbGqpftrLAVDUyqtYJjMTWHuQcyi1l?=
 =?us-ascii?Q?s6k2rplpZHTjE0iY8R+1HlKdHcNpIT/uvbmTkWAgRv0yTYPhBGC7Rz5wzL9V?=
 =?us-ascii?Q?WWZ3uT1PGBRdRYVcs1Y7VOkV1uDkfNXFYI8usERu7QuTU7mwj0gjG5O4EPWI?=
 =?us-ascii?Q?oT3hx70g8nn7vC4iSsdBUvKF8A4Fv69tAzHRHRJ/zVxc9EQOZkK0ODzmP+VY?=
 =?us-ascii?Q?2iVE/T/aNQ2i+K4Y3V+JtMEeBrcbBb/8sCKPG7AXfTxBQQgZwVnF3djIDPI8?=
 =?us-ascii?Q?zgIpHkT3DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a118ae8-4aef-45b1-2062-08ded7581c8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:04:17.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P+fwEvQrsctEejzrRCeVBd3DiBw55FSRw5OPkOIJ6IvCXAslkrzgIy+DDIWT90LBxVSk5fEtKRtDEFNEtXNWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

Hi Tejun,

On Tue, Jun 30, 2026 at 05:14:29PM -1000, Tejun Heo wrote:
> The sub-scheduler implementation has grown and will continue to expand. Move
> the sub-scheduler functions from ext.c into a new kernel/sched/ext/sub.c.
> sub.h holds the prototypes and the !CONFIG_EXT_SUB_SCHED no-op stubs.
> 
> No functional change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> +/**
> + * scx_bpf_sub_dispatch - Trigger dispatching on a child scheduler
> + * @cgroup_id: cgroup ID of the child scheduler to dispatch
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> + *
> + * Allows a parent scheduler to trigger dispatching on one of its direct
> + * child schedulers. The child scheduler runs its dispatch operation to
> + * move tasks from dispatch queues to the local runqueue.
> + *
> + * Returns: true on success, false if cgroup_id is invalid, not a direct
> + * child, or caller lacks dispatch permission.
> + */
> +__bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux)
> +{
> +	struct rq *this_rq = this_rq();
> +	struct scx_sched *parent, *child;
> +
> +	guard(rcu)();
> +	parent = scx_prog_sched(aux);
> +	if (unlikely(!parent))
> +		return false;
> +
> +	child = scx_find_sub_sched(cgroup_id);
> +
> +	if (unlikely(!child))
> +		return false;
> +
> +	if (unlikely(scx_parent(child) != parent)) {
> +		scx_error(parent, "trying to dispatch a distant sub-sched on cgroup %llu",
> +			  cgroup_id);
> +		return false;
> +	}
> +
> +	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
> +				  true);

clangd isn't happy here, because we're missing the declaration of
scx_dispatch_sched(). It needs to be always inline. We can move the whole
function to internal.h, but that would require extra restructuring. Otherwise,
can relax the always inline condition?

From a local build the stack allocation in bytes looks like this:

                         scx_bpf_sub_dispatch()  scx_dispatch_sched()  Per level  4 levels
                         -----------------------------------------------------------------
__always_inline                    104                    -               104        416
non-inline                          72                   72               144        576
                         -----------------------------------------------------------------
delta                                                                     +40       +160

I think the saving is quite still small compared with nested BPF frames. WDYT?

Thanks,
-Andrea
