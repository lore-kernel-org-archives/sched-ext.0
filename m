Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34923F23BE
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278410; cv=fail; b=mbGIZJgzE47hIGznZYvaow1NyZGaDo+Hx1i+P0NM2kr/Cp9q+SF4Cl/Ic1YYemaFBgkN2gf7xVKNP6iqlEdkhp94JVXKW/U/ojV8K/4vwGqBpW2cdRRTAgMjbP9nW+q4LBUJBBHDjZwemblFUWEJNJ+7a+XtVpVxaagcwQZKG3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278410; c=relaxed/simple;
	bh=o/K3Mz8P9nz+r5SyEcHU1NEN3SDkmPvUmg5Ry6FdgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5ZBotfLdc1mAC3oAm/+P44SrbulY1HSj1YhBCpI6uLjeEdUxgcpfB7pP5SV7LZmZbLsavPtt9GNNdW7/hN3GMDhbRkWMiuJwv1iyRffu+ypPN3a9LexkYCeav5x4jEAwyFSsZCDm+iaouPECy95mOQNScv0YeJK2+qk97OwImM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RHqyTlPe; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHqyTlPe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC9M5v4IxCjeLFLz5ioPo2m9kGVIBthb/TavgDz9fPG/5D9t74irJ3D0CBkCDz/DGqURsugY03ZGBM1th+GRFYkZmz3mrjLX0D0FpyVB0/K4DluikN9WPDELyhzOmJvXz6PIXkPB03C/OTZ106zpYybQmDXpNAVTvS/pZn9CmeMnFIkZTJn5mvhKT3lHfl3elC82jZVa882WuU/70m1dGD820m4ZwrMlJmxdXBf5qDLZisz9YDmqYW4hLmxj7o5PeYIipBL6ONS/CsInpCorOZzOpFaNoabz68Ij16Oc56aHG7FdcAymHC3N650YaBxk21vEi+awENTt9R6h5P49pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89mFK6beUX3ZRMgK6fWXaK2s6KA9pXFUzQL8nzXkrY4=;
 b=BeQAJtGj+FurT4ldyaGp/VC+Gssktl0sGBBEYl+lGGNjn4J09TBo2uQCi9M8Ye1QPGh2xOwubwbzq/jbMdk/V8QX7DNMTSHOvMw7sV6DKBZfTimqjnPVOkxOzRHxzspfp9ojo6cpR6XEuXcHO2QmjOYIIhwM11YRVu3+9gdmQEPhgdhryI5x58lEc4H5qYjyT4NXSn47wqUF+SAabdsictY5aavweEJ5hGY0Ozk8ovipftau/xxVlTMgtb9jFQ7tqe2kae/ecQMF9od9+Q+er342X5ZPY/adY7nIcXQt48ClCTLHjYx/CEWgRTeYn8Mh9aj5hZUiU2eow0sXGJjywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89mFK6beUX3ZRMgK6fWXaK2s6KA9pXFUzQL8nzXkrY4=;
 b=RHqyTlPeJrf/b3xRoUiz62CMslFIXuyMJr6t6kRtGO0D5vQkhlzjEFJiJUmJ4vzoYqyUQzzPEyukDs49qD3fCKBiw3ryxSQCV9YIGOK3GoIawj08WRzlQVtCaTuBTz/+bY8wbRI/1gWIDeHOj9AWWw2OkTTS7dbXQcBw+4YBmdeympJCe1lgq7FSMsIjffn/hWSSgqnWpgz1i4+GWbCu/Qzi48M4B5XJ+puRoqq7NLdKwXbM5AOUST4aHVygbn1xdF6Q95KjOwkcbfeJRC1GAaJsEZUDCBHeFX0Avrlnrt6rAsUG9eGyLs1EyZXFIZQH/tMWmW5hBBrbuMbY/bu4nQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 23:06:44 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 23:06:43 +0000
Date: Sun, 18 Oct 2026 01:06:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: scx_qmap: Also re-enqueue stranded tasks
 with scx_bpf_dsq_reenq_task()
Message-ID: <atP_f5S5v_1V06L2@gpd4>
References: <20261017223738.993262-1-tj@kernel.org>
 <20261017223738.993262-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017223738.993262-4-tj@kernel.org>
X-ClientProxiedBy: SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: fa65254b-6d6e-4707-58a4-08df2ca34f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|4143699003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	w6fVnDsEpVnBMCijUjyAJ2n2m/NqqEn8O/iafRUw4qNsNDYVrFeHBmjybPzjClivhmk0NGC1E1c0qlJTOUKWeHx0aLtMJCboZezgbqhLuPgJ5Ei+y3Mm2AFbZF5UDVMLvaDOT3Xh0Qm5dqpnXk/n0kNW/eHgnWjNYReFY99rQUtW2ySKwTH1csdiR++QM57IZD9wMPbZq1CiBl6FlsCG9b5v3UO0YZltPCamJoAtiRCtrZsB4EoQsW7JljQwl38m0/CXMuKR1TcJPWAWX0taLZBJ9GsNJtlVRSNSIBubEv4kAhwb16nJWyEoXPq6Uagt78FKS4sgXYjtnRE+FkwHvClKXmWH/oJRPVyeQsdld05I7wp565KgkkqpME5iitRk1lj9BSRDaruUA/JzsYmuITPscRA6bDrU4MY5xZ0PK/+An3sL2m75g9p5ySnEgvqKCvHoZogxHGp0x7tziydbH2zlRIPLLed+cLC8SvTSCOJzr0Z1jSsUwZon67uZgU9xLXh4YF5TNyz5eSrtkkmqkU80s4GI4jMWA9FuIWSxcuLR/NDlQsx6Zo/fDyFYiIkboNpVCJt3KOEpMuWUYhMLNgGch0ZSNLBEA4JLKWLsx/glayhs1psuaqFeQ9mO8xeJ1NssRtGqWocD/Qzk98mGIFN78H+A1IOmC7jFgSJcznQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCK6GAlzlrx8tys0W+LiJxgjDOrrPZLR3fQ0Kyaju40oRW8UePAlEWONbuQh?=
 =?us-ascii?Q?XRpmxlsWQ1hlFl+xEQqXhYZDlBD8QDUw/EftLBTpefCtpzTDqIEVUkKqzyh5?=
 =?us-ascii?Q?5QFYoSzc8lncg9KljM+g/5kOq+mSPDj7UAZD99BcB7izL4rDGGRyx/6ogErN?=
 =?us-ascii?Q?Z4SZDDSaxlqeXunDSuq1dR1f5mMNcUWDVs8qnzfsD3l8me9ZEG8g/TgL0Tgk?=
 =?us-ascii?Q?QOYWTzEEUeUH2bBAeWOfoxziCK8CVeA1cFpgYC7f9ZCBzEZKIQrYOWhAnUVK?=
 =?us-ascii?Q?MNUdT3bWhn09P7Om3f2GWrHrBC4LRmbVpI/7l74EvU7siH4+cN2w1fYFO4Ct?=
 =?us-ascii?Q?QWE1QSS0HSFA5UQeiEEzFZvZEoA/LxPgWphkPgj03FrQytG7XHY897X0MjEn?=
 =?us-ascii?Q?PKPBlx643ANhMp2PLYh236veJELb0swXJLdeUyiQ3o6mLcBLgzuInMxhK66j?=
 =?us-ascii?Q?qbzZ0yAYEqkg1BhCanat2/Z96phzLaUi+RnbPRQYPHsFHQ+KXh9oXEXu0tiO?=
 =?us-ascii?Q?XqAMys177pXVLsItIp7lijM4dfrY0CxH/gpyeLCivuyiTIzy7ADUmn1n2hWE?=
 =?us-ascii?Q?i1hZvOQAlz7aNzhnRCu2DdpXHYwRmregCrJw3R2vBRSYQJYz4axZq0sLO7Uv?=
 =?us-ascii?Q?NqpVgNMnK/y8x+bwKCMT/prIf14e7aQx+Gwzn3sBGKanBTnNR0fGWO2PjfRX?=
 =?us-ascii?Q?dK9JoqO3FUL50byqAqQ2NazDkZ+5mq8AFhAabyny9og6+STzvKGHJ4u0OsId?=
 =?us-ascii?Q?r1tPPEQavRPgp0K5lugdllcCS2jhPyye3rJceC4/I5tLsVWI9Mwc1vDmGvJC?=
 =?us-ascii?Q?7s+KqBBXZgobNE5JW0dAqBWZYnDePg2YJqk6hD+Hh3urn+Yqo7F5or/zMWPi?=
 =?us-ascii?Q?8Y4trp8EfmIBPUlTktDvAP0QR4zmY/LKsnh0xcA5hY31b1Ox7foYdNHbf9gZ?=
 =?us-ascii?Q?GKMxr9H63OZNtX9gwMOX0rPhUNqyCw09qWaEkw58sWuMki5X27Zhg/j9+zyS?=
 =?us-ascii?Q?Zdqz8b9CosPai8WyOYLun9E5ICzfkMDAhgx+zZrqfxk0dzZUlUDjKXgzpNAx?=
 =?us-ascii?Q?qlNAOLsGWm273oUWDB8AahW6XUZMLchtBeRqvwDwCoVyYtNKkSmJLTLV9+p4?=
 =?us-ascii?Q?GVkooNCFYqstiscpGfYdC1P+Y3e/3qpSEhxLESuzeFDCYSGbmyTTAGPWVOs8?=
 =?us-ascii?Q?twXWQpuhcc27TGQyVe2FEbSao1IZo5rdTPZoXFxMV2kC8KIat0GKcE/BCRZP?=
 =?us-ascii?Q?3i7AqpFALNbzmNwFWrO7DN6VOsuIUWpCHbgH9q93nEocpKahVrl6v6Rvml2l?=
 =?us-ascii?Q?/1VC68NbxkJ6yGqaqYNVZC+Wl0yv/BwxjSU0Do3qOulQfKryn+6Jx/4ozg5u?=
 =?us-ascii?Q?0egALdmQsrcvJGw+3OjyrUFgpv47QOW8fjuXdcXyokrA1k0k4iMfeVzs0wWF?=
 =?us-ascii?Q?XLn0s1RVm9X7UlgAqJ11tC9EQ20iGEtGbH0GIDZaqGyhg8jepFtBKbi5xxC6?=
 =?us-ascii?Q?5GcCQBbZa+rppsvUWyk3AR6RlJtfbLBoItiQgIyQDAC03h+3e008lQT/Dzwv?=
 =?us-ascii?Q?s1laOYH+b8bxoMEGtKv/aartcIbG7iGyO6cCTujJDSLIPRYukMEDURVRSZRT?=
 =?us-ascii?Q?mNf0NdIPqwTSy13opg60P3ZuqWRL917X8CQE7COzgRKiqwWQLEi5TFzD2BZs?=
 =?us-ascii?Q?29N6W2CU1ZkiDUM4m3jouUPIAhCvS60mBIvmlriD+u6MqGc3H4th+BcRMVLY?=
 =?us-ascii?Q?R94aRs2ZRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa65254b-6d6e-4707-58a4-08df2ca34f9b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 23:06:43.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRNc3CMUFRVhQdtE9p2O+rmiH4OE74oTyAvdU3FCa56hsd9kcxb6swm277uuy5odNyD+tCrgn2frC1zjCUmJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

On Sat, Oct 17, 2026 at 12:37:38PM -1000, Tejun Heo wrote:
> scan_shared_dsq() rescues a task stranded on SHARED_DSQ or HIGHPRI_DSQ by
> moving it to the rescue path with scx_bpf_dsq_move(). For a task with an odd
> pid, mark it with scx_bpf_dsq_reenq_task() instead, which sends it back
> through qmap_enqueue() and its rescue, so that both kfuncs are exercised.
> 
> scan_shared_dsq() runs from qmap_dispatch() and from the monitor timer, so
> the kfunc can be called both with the dispatch rq locked and with no rq lock
> held.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/scx_qmap.bpf.c | 50 +++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 61143a2d79f8..e8e451be862d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -651,10 +651,35 @@ static void update_core_sched_head_seq(struct task_struct *p)
>  		qa.core_sched_head_seqs[idx] = taskc->core_sched_seq;
>  }
>  
> +/*
> + * Send @p, stranded on the DSQ @it iterates, to the kernel rescue path. To
> + * exercise both kfuncs, move tasks with an even pid there with
> + * scx_bpf_dsq_move() and re-enqueue the others with scx_bpf_dsq_reenq_task(),
> + * which takes them through qmap_enqueue()'s rescue. The choice is per task so
> + * that a marked task isn't moved by another scan before the re-enqueue reaches
> + * it.
> + */
> +static __always_inline void rescue_stranded(struct bpf_iter_scx_dsq *it,
> +					    struct task_struct *p, task_ctx_t *taskc)
> +{
> +	s32 c;
> +
> +	if (p->pid & 1) {

nit: if ((p->pid & 1) && __COMPAT_has_dsq_reenq_task())

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> +		scx_bpf_dsq_reenq_task(it, p);
> +		return;
> +	}
> +
> +	c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> +	if (c >= 0 && c < scx_bpf_nr_cids()) {
> +		__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
> +		scx_bpf_dsq_move(it, p, SCX_DSQ_LOCAL_ON | c, SCX_ENQ_RESCUE);
> +	}
> +}
> +
>  /*
>   * One pass over SHARED_DSQ: rescue stranded tasks and boost highpri ones. A
>   * task whose cids were lost while it was queued in the fifos would strand on
> - * SHARED_DSQ, which is consumed only on self cids it can't run on - move it to
> + * SHARED_DSQ, which is consumed only on self cids it can't run on - send it to
>   * the kernel rescue path. One whose cids were lost after the highpri cull is
>   * likewise rescued out of HIGHPRI_DSQ below.
>   *
> @@ -663,9 +688,9 @@ static void update_core_sched_head_seq(struct task_struct *p)
>   * consuming them first. This makes minor difference only when dsp_batch is
>   * larger than 1.
>   *
> - * scx_bpf_dsq_move[_vtime]() are allowed both from ops.dispatch() and
> - * non-rq-lock holding BPF programs. As demonstration, this function is called
> - * from qmap_dispatch() and monitor_timerfn().
> + * scx_bpf_dsq_move[_vtime]() and scx_bpf_dsq_reenq_task() are allowed both from
> + * ops.dispatch() and non-rq-lock holding BPF programs. As demonstration, this
> + * function is called from qmap_dispatch() and monitor_timerfn().
>   */
>  static bool scan_shared_dsq(bool from_timer)
>  {
> @@ -677,19 +702,13 @@ static bool scan_shared_dsq(bool from_timer)
>  	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
>  		static u64 highpri_seq;
>  		task_ctx_t *taskc;
> -		s32 c;
>  
>  		if (!(taskc = lookup_task_ctx(p)))
>  			return false;
>  
>  		/* stranded? rescue - it can't be dispatched here either way */
>  		if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
> -			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> -			if (c >= 0 && c < scx_bpf_nr_cids()) {
> -				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
> -				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
> -						 SCX_ENQ_RESCUE);
> -			}
> +			rescue_stranded(BPF_FOR_EACH_ITER, p, taskc);
>  			continue;
>  		}
>  
> @@ -723,19 +742,12 @@ static bool scan_shared_dsq(bool from_timer)
>  						      &qa.usable_cids.mask,
>  						      this_cid + 1);
>  		if (cid >= nr_cids) {
> -			s32 c;
> -
>  			/* self cids lack caps in effect yet, leave it queued */
>  			if (cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask))
>  				continue;
>  
>  			/* stranded after the cull - rescue it from here */
> -			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> -			if (c >= 0 && c < nr_cids) {
> -				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
> -				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
> -						 SCX_ENQ_RESCUE);
> -			}
> +			rescue_stranded(BPF_FOR_EACH_ITER, p, taskc);
>  			continue;
>  		}
>  
> -- 
> 2.56.0
> 
