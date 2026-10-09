Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C564BEE38
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544759; cv=fail; b=cDfbZpDafIbJ9Z70risyQxcOr1qD9puI0xUgPIE5j4Ef53r15TSAwy0AvX/gRB3BP6rXnw6zXwh2HGanxleJ89+bs5olBzWSsDelFsE3oNy75Qf8tY9VqOtpIrzOQV4pW3q5YCTae0fDgxpFfwxeGm0baAMrJt3Av3V3j3fZWNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544759; c=relaxed/simple;
	bh=J5DG2DVJJt6o8s94Y2/JXXx8xr/+gIViZG2TTb/6dOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKmktsvuGnSDvYtPwY/ougntjTZermOwLTEb0GoF6KB7VfeSRi7uwHbbqo2yCl6Qd6vTMGNph2A2M7B/jcoFM7xqh+45Z/Edd9myPQJoPp9BDyUUV3NDr8vArXiu0XoKwQq7fPTQs0wVeuxohkAfEQKwQGNDkS7db4hUoQaIGwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lviixIHK; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lviixIHK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0kDTVEVbzsL766TwSuxH8+eF9mjW/25NxkrdprDOKyJmUurziwOxUmPOuaLzXEBzjeWkPCV2A1lo+jGnBIuYbflWIY2Jzm8PKdUvwlNs3+nEC7RBPKKopmJO/drwVK9QQxDXa1dhfE+qOYGiWgcu00N+0zvTYu7XKLA0x/mX0C7p7ShrWisd0Ta71xHVseEaF6UO5/N1K+UiVenzYB+DuNNfvu0tNSuZ5IbSJd14i9pdgLw7lDnSmkfWDuBgqCjkPxmbIVv1rKo6xLAyRWLzepiqI9HkVjea4FvGVslsT1ieStuvIiDJsZhqsLY1cW/VRi7KdlqRqKPQLf/79wR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTuiGGHB1s1MtsjDbxay5SU+/qvLDzRTey+B4wT9/xY=;
 b=mtzcj2lAHpq1dZVbZvMHUGHZKfIrbxjYk+7fS3QSuKCMIAuLhqfg2LvjVeRi7cSqNlU6mUwlSGYoQiOypo7NE43OAalPLohhwKnnS0Zr8U6AepgyfDpHVbl3UGzN2RNuL4RtO12Ai9D8A8j9rajq6CUK8jyZEOJS+jEq2rDjbtmat+BrvaswYsx3NBZkLgfFFYx5oqnZMTPcVr/jpbA4hcLEW6zcxjOKrdCXv8D304i1fn2bvkSmz5JXb8AM++Dm3PvlqBaNbR2bMkTiHLr8kdtldDtCja4hLVxaOCpo1l10X/pHqDQ74XUKwuQqVbypRBO8TAOOR5WWrHAHj/3GpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTuiGGHB1s1MtsjDbxay5SU+/qvLDzRTey+B4wT9/xY=;
 b=lviixIHK/ML8CuFWud2xy5l34/aFyt70IsIRepYUecByqYZ10TvxgV3UFha5Pc/Vma9asjhUlA66RbMAsZNXYO/z1pbsqdpjeLC6UrHMOe7oeFK5tjmBvwPgIzO7i0uBV1iLh83on/woohbXnGhC4LD+FhfCSbZTI4qTLL54FBZJDLIxEapGKoXGu2pbL9cUxOcekY3lAliiKAyL3v+9kIoBf9AmvOaGqMMurncyCEhtoB+bggYU9/o1l92NmS6JzdnXg4JgNm0grNq/2LuujlYt+ET7wBzH3EH3x/jTW4aKayOTY+A7sLxFycCLkZeBy05VNUwOtpi8e4JT8+aSrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 11:19:04 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 11:19:04 +0000
Date: Fri, 9 Oct 2026 13:18:59 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: scx_qmap: Reset a child's cpuperf targets
 once its PERF revoke takes effect
Message-ID: <asjNo3JmkmeTK8dr@gpd4>
References: <20261008093228.2015427-1-tj@kernel.org>
 <20261008093228.2015427-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008093228.2015427-3-tj@kernel.org>
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: c366c594-cdd8-4558-b28f-08df25f7206a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dbK4OB8OcIwABYvBs5+t2qWw5lwPAnbkotNp5B/ke+5FARS5MAOwTDHBxfNOQ+YMJCHyNwFTePrVrrBoHRvGtmQ0TX2Eg6rU9DSNDrsA8coLDwu7rltj2rKeNvovRmADGY3KhCMZk8D6AJmuqw4fCzRvdZy5L1PyLKsUu80LY0L46/V2BP1eRwVyIBKc9MlliyqjO5ra6tL/yp1i47ADa8Pdl/J7JuFYkkLqQwS4Ybb8TjarG3vJEhhtwLtjEkp6OimkMyRfYWklxyhr+cSw5xabVLnRA9UnANyvRJbYjv7voc0fogkocEffZ6+3MTsggJKbdnDFuuWkATIAm8BB0Aw+fp+3LEdnUx8qGFv8zlh4XkRycBfbK6RCVc+RNauf93rZmhO+WQnxbEwZRbsWNncL9IC4QIB42S1gHaMV5j4cyL7sjROdXHgyCj77Mu/LoXvwIhL4LtCmpk9HTQBNymXyVL8xzo+qV0Zkk0OL9LSTeXThZocvOCmiobisTHzEIhHuH00cZFaql9jtV/a0uq3CUmgmmPs6rOBI3UR8/G1D2dPvUt6uYAl151zxpPEpqfnsUuCE6jdMSzvIzHDAt8JL2r5NBdIg4C6elui/ubF4dw3vjO94UDpkDDGQH+KHkHPqyQtlpSWbcd1LvxiHzIYFzACg2JLS4W1XaqxdCUc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtvmenDmxCItq5l6xRj1gGvnKm/Tr7WVh2YZFYx7+9VSFQMnxbVLEYb2nY96?=
 =?us-ascii?Q?48i8tydmoY1DBLYmWW/WNupUifiP+zdkav4d7sR0x+elZJ1Qm08VPhPxzLY8?=
 =?us-ascii?Q?pMzynbfjsKwCb7WW3OJhDqYjuyxv5INqK4cE+5AuBkZNUwcEUS3zevIhucfT?=
 =?us-ascii?Q?AmC/bqGnPNu4/nXlFoeX+zjCfTkgb3ACooOunnar7BfjZhpZO2VXuojGUuJ+?=
 =?us-ascii?Q?2gwWdwt9WkBYrRcDPTveCuTPkFXGUAprpJz3oTk0WqCNJgbxuX6HCww/kIo1?=
 =?us-ascii?Q?Sne6oNuFQw1vvc0LXH2Tc3A0cI9b7IOrRbEy9OJ5sK0JngcBcMx6y5jInlpK?=
 =?us-ascii?Q?aocd4Py85CCoqEMhZAOfRoHrUyE6HO5g3yD8UN+Y9J410cF36BThNljhGnLv?=
 =?us-ascii?Q?GLgudUrVyvcQ4lrFyB4YxT1tZoziwY3irtioXqdHLw1givwoH4nbb/mhLXm9?=
 =?us-ascii?Q?VbcFVDqHSV/Rt236IjD43qxMdNKS9dG2+HPr9UkUpBeRE+LC6mPg0F9pmcI8?=
 =?us-ascii?Q?O9IyrSZ/Ebi8KGh9uJmCBC6ybtX4x69YixIUO4S1ieBfrwLLfUUHneUvnoDo?=
 =?us-ascii?Q?/c2ABDSReTHcCKlXiykKUBmGIiIYGYfBhIWAQ+Mv4DrOyhfuoQq4GdPtVdUi?=
 =?us-ascii?Q?QstrfURF8+7wgmTDP2Ob5vV2P/5zj7eVwAx+8GMKll/IQbPWSlbyb9wWnmi1?=
 =?us-ascii?Q?1AQdtFmz772zbosrGMz4CmFT5XUHsOHjncRf9vV0hxRhLKHuFKWXY5a9duA2?=
 =?us-ascii?Q?ZuXqdDmfPSYDa1S/Kzz1Lgbqdjrar0zx8TrwX5R1hogRT8/c95OONvX+pYI8?=
 =?us-ascii?Q?kZ+nkQODjoSPEClY3iO6deUKstnAxvuTgBC1fA0HKk7PZ5qN1qXo+iLD3yzh?=
 =?us-ascii?Q?VgdhFnMWaAj6bcaCZdiNJvVloUh+j7IgLg1fP0TFHAEVAiWIwoO3njt53lTx?=
 =?us-ascii?Q?lRbsGp4rfpOEiB3l43s4wWJ6uEAlbj6nAJ0Qoe5X1mQUKwlr3uAWyUIgb6Gz?=
 =?us-ascii?Q?vY3HEPw8kl1Zoh0War4tsOfUZRYuvH+SQzdpuVnKlwY8ZEsbll7d1gge4QVS?=
 =?us-ascii?Q?jgy6VafbDIzYNo/Q0NC3ho0zMKu9rT16AZaYLwYReJ5GLdWcghfG7d+H2mFB?=
 =?us-ascii?Q?oYvwWvO44UDt66oJuI2I6max40l0QDQn7P5ryngkU93+9Awe3PNyVWDOyL9d?=
 =?us-ascii?Q?8CI2oQv9Ll3omaw6U37twzDTQ9GeivtdAhXENKkVZYZFxvVyudYguBNb/kSB?=
 =?us-ascii?Q?6GaDcODEEJp0oDElj/DNqqTRXxsyhXZ0KJlQ3fdqtaVj91Qg/LqZ772pgK+n?=
 =?us-ascii?Q?3dvY6FE8W6HIMXGhvWhYZUnaiV16gp2l7B1WDIvBAESlQ18tGrUxBAzlrxT0?=
 =?us-ascii?Q?dWfKBPFeKMhbCEVu31Cy8uQeGTAp2D5V+oSKyzl81oC4YEsuaqYNJV84R0Uk?=
 =?us-ascii?Q?KannQCHNgJJjPMazUGoWshVl2WNg6MSq5yTgkcg+7PMMwWfpqqKOw/08RKSh?=
 =?us-ascii?Q?1lTIJnzRt/0IKluYSG7ONZCxe6+pOuvh2XLLaSFrlh/grI4V/zIRmSHvlPC3?=
 =?us-ascii?Q?QLEqXFMqtVb/Kf8pJHouNKNEjwnxZjSSkIb6dj8iNag0fvZH3xlfvdy3/B7Z?=
 =?us-ascii?Q?khnUrdpXIpQBI2UI4b8KOo5faPS8iN/l+//3Tw8Tqh7VacH/g/C9FGfcexlN?=
 =?us-ascii?Q?3hBlY4zZuWwqnSkqPrJX/bPW3NgWChk7UqlNhrJw007r0wpwT7CuMLqvAWzL?=
 =?us-ascii?Q?8ne0z/kFWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c366c594-cdd8-4558-b28f-08df25f7206a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:19:04.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gMWfW3bJ0MKBYTvY7XMAmouSyKOTEr03jVOdstWOehhQiK9sCoiPEeE2Zz7h3e2JSxVPBCFei1c/uT6cepS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

Hi Tejun,

On Wed, Oct 07, 2026 at 11:32:28PM -1000, Tejun Heo wrote:
> A child that ran a cid at a low cpuperf target leaves the target there when
> PERF is revoked, since the kernel resets targets only at root enable. Reset
> the target from ops.sub_child_ecaps_updated() once the revoke is in effect.
> A detach reports nothing, so ops.sub_detach() resets the child's cids, the
> pool included. Count the deliveries in the hier stats.
> 
> v2: Reset from ops.sub_detach() for a detaching child's cids.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/scx_qmap.bpf.c | 33 +++++++++++++++++++++++++++++++--
>  tools/sched_ext/scx_qmap.c     |  7 +++++--
>  tools/sched_ext/scx_qmap.h     |  1 +
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 7f69394556b6..4c152b44bc91 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -2167,12 +2167,30 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
>  
>  void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
>  {
> -	s32 i;
> +	u64 cgid = args->ops->sub_cgroup_id;
> +	s32 nr_cids = qa.nr_cids;
> +	s32 i, cid;
> +
> +	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS) {
> +		scx_bpf_error("-ERANGE");
> +		return;
> +	}
>  
>  	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
> -		if (qa.sub_sched_ctxs[i].cgroup_id != args->ops->sub_cgroup_id)
> +		if (qa.sub_sched_ctxs[i].cgroup_id != cgid)
>  			continue;
>  
> +		/*
> +		 * The child's caps are gone without a report, see
> +		 * ops.sub_detach(). cpuperf targets persist until the next
> +		 * write, reset the child's excl cids and the pool it may have
> +		 * held.
> +		 */
> +		bpf_arena_for(cid, 0, nr_cids)
> +			if (cmask_test(cid, &qa.sub_sched_ctxs[i].granted_cids.mask) ||
> +			    cmask_test(cid, &qa.rr_cids.mask))
> +				scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
> +

qa.rr_cids covers the entire shared pool, regardless of its current holder,
right? If child A detaches during child B's turn, this resets the pool's cpuperf
target even if B still holds PERF and has written its own target.

Should we avoid resetting the current holder's target here?

Thanks,
-Andrea

>  		qa.sub_sched_ctxs[i].cgroup_id = 0;
>  		qa.sub_sched_ctxs[i].weight = 100;
>  		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
> @@ -2208,6 +2226,16 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updated, s32 cid, u64 before, u64 after)
>  	execute_partition();
>  }
>  
> +void BPF_STRUCT_OPS(qmap_sub_child_ecaps_updated, u64 cgroup_id, s32 cid, u64 before,
> +		    u64 after)
> +{
> +	__sync_fetch_and_add(&qa.nr_child_ecaps, 1);
> +
> +	/* a child's last target must not outlive its PERF cap */
> +	if ((before & ~after) & SCX_CAP_PERF)
> +		scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
> +}
> +
>  SCX_OPS_CID_DEFINE(qmap_ops,
>  	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
>  	       .select_cid		= (void *)qmap_select_cid,
> @@ -2232,6 +2260,7 @@ SCX_OPS_CID_DEFINE(qmap_ops,
>  	       .sub_caps_updated	= (void *)qmap_sub_caps_updated,
>  	       .sub_ecaps_updated	= (void *)qmap_sub_ecaps_updated,
>  	       .sub_cid_sched_updated	= (void *)qmap_sub_cid_sched_updated,
> +	       .sub_child_ecaps_updated	= (void *)qmap_sub_child_ecaps_updated,
>  	       .init_cids		= (void *)qmap_init_cids,
>  	       .init			= (void *)qmap_init,
>  	       .exit			= (void *)qmap_exit,
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index e83d5e2147dd..17cf584a2a3d 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -113,6 +113,7 @@ struct hier_prev {
>  	u64 nr_enq_blocked;
>  	u64 nr_inject_attempts;
>  	u64 nr_rescue_dsp;
> +	u64 nr_child_ecaps;
>  };
>  
>  /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
> @@ -208,18 +209,20 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
>  	}
>  
>  	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
> -	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
> +	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu child_ecaps=+%llu\n",
>  	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
>  	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
>  	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
>  	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
>  	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
> -	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
> +	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp),
> +	       (unsigned long long)(qa->nr_child_ecaps - prev->nr_child_ecaps));
>  	prev->nr_reenq_cap = qa->nr_reenq_cap;
>  	prev->nr_reenq_immed = qa->nr_reenq_immed;
>  	prev->nr_enq_blocked = qa->nr_enq_blocked;
>  	prev->nr_inject_attempts = qa->nr_inject_attempts;
>  	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
> +	prev->nr_child_ecaps = qa->nr_child_ecaps;
>  
>  	/*
>  	 * alloc is the cid-time the partition handed each participant, and used
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> index 949459d06a18..9e6eefb39735 100644
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -195,6 +195,7 @@ struct qmap_arena {
>  	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
>  	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
>  	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
> +	u64 nr_child_ecaps;		/* ops.sub_child_ecaps_updated() deliveries */
>  	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
>  };
>  
> -- 
> 2.55.0
> 
