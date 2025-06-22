Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FF72617
	for <sched-ext@lists.linux.dev>; Sun, 22 Jun 2025 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750596105; cv=fail; b=ODPNElH+ONQTNPHhv/bTmuufwDfQNZ1v+9kwOmXEKp3GDT2b6E63Tj98AWRNj/9G8r+8V92anyY3R1+Ng+nVwTFwm/nBbtVQ+umQutFd85rLZojoGAptD3uN5umXdSdiNERvNiLx8cODBK5Tkd0M814c9vcrv+CAOFJEPym3FIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750596105; c=relaxed/simple;
	bh=r1KKw/6UR4RGV/Ae98N6Eg4viESyVdDubSVVO99FZuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kW8etkicCsxBpIz0RvwcRVBDqoN10zD4QcFc3f3wuwStWHHFqrVDy2dKb9ZMITGGZMsJkI9foEZK1XTgG9i1ifgm3d/p/NXFuuPkJ6cwj4GgsCa67Qs9f0naUKw6k3vsczCe2rpFnQc5O7t+ur2uJfNMEKDLfP9FU/d3qEZa+KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPV16Kib; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPV16Kib"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so7suq6neGcJFbt+caJY6b09exfVh3ExAOWVOHhUgqOvQI8QNDTHiWn9K6XYMskToR1IOX33pybU4EWxui9GkxFNUUkW/Xs3A9lzplCyrR0d/fKTOEKnHmpe3qiKz097y0OyQh22PiTqbIQAH5oU7ERUB+wRqxuZEJuv5mB+gjX34cXhB/Pm13SCOPogqxkN1KuCt29SnKwyQrvcn4g/FvLtidbKqLWIsrsTADCXG9gTFewW8qypqdU9sfJMrWQtxfTA2U+iGwWbJS4MD9NQ2ObSAibGd8dTY+3oaZF+KnjHxR9rlKDnKznigid4g6RookTxsOQ9odvslUoed9CTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PsvETBesPl8CvbW74TrHUtyYZWnmaMifXO9nLmqpLo=;
 b=Bn0CmBIzTxRk87I8bqkHMfFobbSEoAF3b0QkbUChM74Mnw/3EqmgJKRMg2AU6l/yVgvVu4fIAlcw3YlPN8yb/vPH16vvf/+8sxgrA+N1yJvHbxk9TWRh5wvx3PV/kJLBqZi1yJ/6nSYH0EtYrz4m92os7QixOh6246BQOdg/SKQEWO2S7fzH69cz92VuxOzgfzXk80czeF5Yi4CajXK8hwJEmsO6qlOA+7rnuEJR27oL64teJEWLKG0+owvUwZp8lfQhSkAseZWyf06p1peh+qUzKC3NcbbtMNTHhpkUypOZK7y+XXg4YBPGcaj5/7C19kSJ2p0ubnSJRznWp3rGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PsvETBesPl8CvbW74TrHUtyYZWnmaMifXO9nLmqpLo=;
 b=TPV16KibNYgDfcZL5qRx2yT9XaiDjX/JWPEgOL2H35Fm0A0A5HNksWcQ73a2bfOzwoArc8ZjoitIVOyXCjUSyJncyN7nC/9ImSq4t1rCzUeWwOKQU53CT6ipgG+t8Kgalbu9RfifpFaGgD9ccF+72rWGPoEcElhSEnSEhy57LQrXLtssd15R5X5iEyonnkW86h2yT0YS4tIaiaLqnAgsL9hqCb/HRQbxaIQzJE3I3uInacv75Hh9MITp9I5uC3Tpjob1HmW0vHczn1QvcOXkHSFFj/nJM73zF2lL6ibKTgLpvi8jDjICudd27uqA6rIzjKZQOZN9yCE51E3gakPFtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Sun, 22 Jun 2025 12:41:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%6]) with mapi id 15.20.8835.027; Sun, 22 Jun 2025
 12:41:39 +0000
Date: Sun, 22 Jun 2025 14:41:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Henry Huang <henry.hj@antgroup.com>
Cc: changwoo@igalia.com, tj@kernel.org, void@manifault.com,
	=?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
	"Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v1] sched_ext: include SCX_OPS_TRACK_MIGRATION
Message-ID: <aFf59XSp_kRexHvU@gpd4>
References: <20250622093621.1669-1-henry.hj@antgroup.com>
 <20250622093621.1669-2-henry.hj@antgroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622093621.1669-2-henry.hj@antgroup.com>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d3bb65-657f-417e-8370-08ddb18a21cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BfXCitEDC6/huNbbdY0EJfQmE5eGR26ouMQsNnr1T3x/YP2joY5m9wu5UMGD?=
 =?us-ascii?Q?XNXKb1Rfm2oI4GNyPtjm7LzQLF6Qm+Ljwe8/61xGCF635ORgp5QMr2C8Qmqc?=
 =?us-ascii?Q?1Lf2zDkgLb0EykHOMYS9gAS7k6qAkm1ufzRcfFPSlYotRkYZDQ4ff67GZMcF?=
 =?us-ascii?Q?aKptkE3sWFUEP1+l5pQM17UNh/eUo+yqjT2DdLe++B6IDaTgtfjn0W1zY45K?=
 =?us-ascii?Q?hqmq+SgOVBT6ETcLVTV6/3hhABm4V0lTS7zPO1GKh+TiOTDxyMmzvvUmcK5s?=
 =?us-ascii?Q?MIMhd6JfhPZsZ/eUbLwJNI78PWkT1rcwB1OO+Q0KFi8ajqmceIPTD8/h5Yyd?=
 =?us-ascii?Q?dHLv1Hws+rCEMa8KS7iVJAqbsIIEs/QkBEpEvYfx0PGsBaFQI7OE1hKYBM+L?=
 =?us-ascii?Q?NsiqabRxEbhOs05AqoFvVg61WB/355ECHicSLuCOpBiWzoVc4lnaqlwVcRO3?=
 =?us-ascii?Q?1P4bsV14zNlbku26jQyF7VhZ38S8i1Y/gJXI/mcFtNgLtJX0K1uCahIeJrlH?=
 =?us-ascii?Q?pHWTXc2GSqRVZPoVKoCJA+yAeWYaSPfxPgJ9BkHtS4XycLeqExVG5qQ8jcH+?=
 =?us-ascii?Q?fFS6igI9JuTu1asqsLddXR5A2OkqAmCoQ8H4ErBIiURUR0/FjUY7GDw22XC5?=
 =?us-ascii?Q?jAv8oO++8QXQ0vMQwr8S2zWmUIJkaq28Xk0b6rdKFk5LrQ8HuTtymjcQrgjw?=
 =?us-ascii?Q?hlnIx/v/gEaWsRF/RNpSy5gqDrKZNN27ivZrcRrndkSOE+G1ZXVA6idQcnDW?=
 =?us-ascii?Q?3eJ62fcg3faqSI5577qpKlPmNOnxB1zP9md6Na0bDwzstjaweBwP19UjqJ4s?=
 =?us-ascii?Q?b/Dsf2fRunLnG4q2xIyUayI+VWSbpW+EPNdYXW1XjFSuIFvdHd4MDGC5aU5p?=
 =?us-ascii?Q?O0TWkby4y2BaKNR1aFW/pT04JDk8pJOg4xHBTKyXwHy4fjPz6MOZC+4WBy9R?=
 =?us-ascii?Q?G5651suERZdCqrTuhw4fKFR3HhIRBVRNvEcuHBn8GDpQjXVryp2+zDu07DCN?=
 =?us-ascii?Q?RjmdZRpJCXwt+lV3yFv6k963PnnJzZu7tMgTrsgUjA93VoW+aaR2YeEgv0WS?=
 =?us-ascii?Q?ycvP1Hhu5BQwlQdwXa2pS7ykQ0FXiBsqui/OtqU/KIaw+AxQ6VpVnk1Ap1Xh?=
 =?us-ascii?Q?8ZTYHVOT6ahDYBH5jajBOJxEeKX1/SG6YWn1dHkaMIw95qrDF/V7oxuVcypi?=
 =?us-ascii?Q?afpwnrvjec1MY4ZnnPZEh1OFKnybnYufRQciKCq/GKwiKSfv0deZKuIHO5KL?=
 =?us-ascii?Q?QtYjd7RROY73Gio1ULcxL0guGt71d/QqDCRKRrmsREVp99bE5g4IuNJlRptV?=
 =?us-ascii?Q?iKQggU7ke3AU7GnHcYLo83E+Px1gQGQ+xUacVA2zHgtrtLUWDnuScklggKQR?=
 =?us-ascii?Q?0+O02eOWrTs8aL5epF7w5dM3OSaIAb7JCdBLidT7uP8pfng35Y1k2atEuB5n?=
 =?us-ascii?Q?D7HxRKrrNtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIPjYo3AkXRXKLbUK9MAAP99bT013/UChg53LwpGQL+mW+eXSb2fP89n5FZ0?=
 =?us-ascii?Q?SGg2y8CGTC2GqFTaIsnJMoxKscuo1xO7fDGMge5rofjeVvjNi6EahsnSxqVk?=
 =?us-ascii?Q?jeeDVr2T6wkgYiMfcxCznjH5QmOy0F+jjt6vgEd1S57L0v7255Zhq2tbyfp7?=
 =?us-ascii?Q?XmQ/FQ+TbJxev4c3AWtM4+ayn/9UdYBolCnGzcpwJYyzpJgi+tCLMYWIPBmO?=
 =?us-ascii?Q?JF5C48jgi33Brj1VRqgpgeCe9eF1wWb+VUh3nN2G9xIaRd+ztCpdMtw76qCR?=
 =?us-ascii?Q?1dtHDr65z4AtnNm07SWcLcQM+6s+2sxvy5lR3/7IPCG7CWzyWqmND+pUBFGM?=
 =?us-ascii?Q?7VYsaA39oFDZ1imMilotkzNRYPfPgTzxETlKIFCjssoNty1wEUoqlULWzd1C?=
 =?us-ascii?Q?AaMYYhcO9BofvFxUgMeHM3Yiqo6axH6WUXJ5LQ7IUbiS24JICGQGW9mG3foF?=
 =?us-ascii?Q?fve05FVpVkNQhw+PdQkQuIr9AjmybstQYYFU2PFFdQucEMNpBIYmAb6H6i7M?=
 =?us-ascii?Q?p1QRmyziWLD7leHyPEqcE01jLC+ghGlbUq5o/eISL4nfLWZncQYhmkA9OO2a?=
 =?us-ascii?Q?AhygTL5iIuHIQYOcj5dGUsbJIolndvWAmbWvgYLQ64O8B+z94698tJNHCnMm?=
 =?us-ascii?Q?46tJvJ5r++6A8ChNy4V+Q7c3h2q6vH6L36Cx0XEkWgpXpKpzH1LFS3VggHDz?=
 =?us-ascii?Q?VCI2dDKP6BVJneMKTSGGkg0G9C4VxK5k3a0pncs5q+yQMHyLg7OEZrMpF7NK?=
 =?us-ascii?Q?TaA8P2zudOFWjIMNLIQvuqWnKVXSig+D6lHpZlX90y1JSzMQIKRF3OAf2nHD?=
 =?us-ascii?Q?SdJ/z8z9p8GVU0HtlNKDK8/K9BKdTLkfhpeuH34QUQL4aCUrvbyGJAsMeLRq?=
 =?us-ascii?Q?vkEb1LGPc3tkuf5UMAAHmU1/ujs4j4Jm7VgV4mFeXtwkiEBrZzWpKAr6dGy9?=
 =?us-ascii?Q?QYsbF06pipX00Cl2DV00PLB5Zsl2OLiFhFrAaa+P0HWCV1DpqZtExoO62jW0?=
 =?us-ascii?Q?1yLBcA/uojE0ipjtTnh1O7l6Fr07kAUG91v1pXT7A0Jg8yGKyklfeq3ZAY5g?=
 =?us-ascii?Q?2k0uyoh6fVIq4IvM4W8ZHrE1l1jJReyUQsPSShxywoyYoP8Ow7tSze0qVTU1?=
 =?us-ascii?Q?xiwlXvT5xDLu0T6Q0bnxJPXNCV5osrcdKlPQzCY1Xm34CTjEYeuFzUAdgloY?=
 =?us-ascii?Q?VDteWsvzs2zczGmxfI67Dxc51Y3fJ2CFiaynJ3DYKQCDpZTd3bsCimnIDQRO?=
 =?us-ascii?Q?F4HkBUPewECPQNvqLjkMr0KEFV2d0+BzhJhMzJS9tjNR2BetoVT2xr0a1f9Q?=
 =?us-ascii?Q?JbcC+3mM9RHMI3imShX+tcUP5KyuvSJO+Ammqf5XhQofD/kls1qQqVqNViZK?=
 =?us-ascii?Q?wtFVJP70lnGhUCJ43iCvIBgpqLxkVZqNg51EgrRnyzDBpZW7yVGzwVm0srJy?=
 =?us-ascii?Q?VZkt0meLFAFQngAYoIq6MTvk7Wq4v5UZ599h9kT7B5VKW7aS6H2v4oeZYyHf?=
 =?us-ascii?Q?QgRmDF6oEbAYv4NxwSvQ+5777s/8qRY11kBT7zqL3DA52shPC+DKBPggUM/U?=
 =?us-ascii?Q?ou09zlWFd8RUkD3hqpRzekAYeC6LGtjNkjoQsUVM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d3bb65-657f-417e-8370-08ddb18a21cd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 12:41:39.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y92umXiqqHMgtemOIneOsqABmjpOKMArcp4tCqPQuY6CGeRiMEGheJN5gSGI+9pk/5SeKHcDrBADVBsWwPdihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

Hi Henry,

On Sun, Jun 22, 2025 at 05:36:21PM +0800, Henry Huang wrote:
> For some BPF-schedulers, they should do something when
> task is doing migration, such as updating per-cpu map.
> If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
> would be called whether task is doing migration or not.
> 
> Signed-off-by: Henry Huang <henry.hj@antgroup.com>
> ---
>  kernel/sched/ext.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d86..9b05bb9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -161,6 +161,12 @@ enum scx_ops_flags {
>  	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
>  
>  	/*
> +	 * If set, runnable/quiescent ops would be called whether the task is
> +	 * doing migration or not.
> +	 */
> +	SCX_OPS_TRACK_MIGRATION		= 1LLU << 7,
> +
> +	/*
>  	 * CPU cgroup support flags
>  	 */
>  	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> @@ -172,6 +178,7 @@ enum scx_ops_flags {
>  					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  					  SCX_OPS_SWITCH_PARTIAL |
>  					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> +					  SCX_OPS_TRACK_MIGRATION |
>  					  SCX_OPS_HAS_CGROUP_WEIGHT,
>  
>  	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
> @@ -2390,7 +2397,8 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	rq->scx.nr_running++;
>  	add_nr_running(rq, 1);
>  
> -	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
> +	if (SCX_HAS_OP(sch, runnable) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !task_on_rq_migrating(p)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
>  
>  	if (enq_flags & SCX_ENQ_WAKEUP)
> @@ -2482,7 +2490,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
>  	}
>  
> -	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
> +	if (SCX_HAS_OP(sch, quiescent) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !task_on_rq_migrating(p)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);

The overall change makes sense to me. I'm wondering if we should set
DEQUEUE_MIGRATING here when task_on_rq_migrating(p) == true (apparently the
sched core doesn't set this flag).

In this way we can use ENQUEUE_MIGRATING and DEQUEUE_MIGRATING to
distinguish between a migration ops.runnable/quiescent() call vs a
"regular" one.

Thanks,
-Andrea

>  
>  	if (deq_flags & SCX_DEQ_SLEEP)
> @@ -5495,6 +5504,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  		return -EINVAL;
>  	}
>  
> +	if ((ops->flags & SCX_OPS_TRACK_MIGRATION) && (!ops->runnable || !ops->quiescent)) {
> +		scx_error(sch, "SCX_OPS_TRACK_MIGRATION requires ops.runnable() and ops.quiescent() to be implemented");
> +		return -EINVAL;
> +	}
> +
>  	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
>  		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
>  
> -- 
> Henry
> 
