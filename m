Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAA310784
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792303668; cv=fail; b=VgeeoNHBFQg7zpQ2ANZunfK07KgHGJVijCygmeWEsdlqo1Q5i8M2SCrKTgg11NcI6Tb+03hN/9iiUcj5j1hUY9O0w7UKE3NtEc2G/k8lAc4U5eNp3fgvsUvM28q+pz4zprubVs27STJOKLndxtKRxFB6waNsYmDz5R2trrXSvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792303668; c=relaxed/simple;
	bh=RDe/aSN+P9VzGBJlWsPQF6JC9fgUikpg0YQAhl6p/eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fj8VKQ+MLxohGCM1+jBqlM8V+rytj+hm4umYDuenuF9y+ZOtM03tYOEkVVzbwce7QN7/kP/CxWsC6XMsIo8WPnbQQKCOGYOuRkJF7xDWOz6Iuvf0X70rejq0sHFNy+ls/f2AS5o8IfUxsQaANUybrhb7kgYZv8XImFavFr8LJnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaHVfmlM; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaHVfmlM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guzZopOPUqHWtJt8YUz/yArR32E69Wc7AvdeFx4v8Fx3tF/YTa1rKu/V4u3kPeYarQM45es7nzA72SRzQ4shvO2+f+EVhECXH3AMXiu7YvDA4JrDvdsmfgg8zglCukxPfeL+hiLERNYsbmvOSq4Azsf9xKN/sDbV//lD4CmYHkIH1o+yofAIFu3l4ac8XzyHuhHl1XxJ+aq/wXj+mD0novCxFQFfHaqHpDlD8kVAys3sQi3S3sSQmXgRH/koxMhAMgj4U4zrA+VEzHEoFWWDL00i+ppnKVJN2Ke2si6LNwv3EY7SaQL2/gdoCmbXixLVWyNBNwqsn4QIcYkbbLLIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JAEIu2RRqDm7jtsmnRCq7MKcPy4zNsBLSvfrPIhgmM=;
 b=wavf0wiAu7jN6N3XsSD76aT/4R4084BaXNRYULTZ8VtR4dOxvY7jbKb707Waqe1uuJvqBPt0ipykYDkIMmo1vh/cDkXqbTcbx3bex807ppV/vrqZKsFELQQqU8OiSpvULeU3RmY+ZqCYjTJ5BceX1JsXiXJVtoF8c60QsFMaf/gvONOA7BcJNYfoqPo/nT/2R5e3O5czdacymLob/sBlDo+E8LbDtlJGjxTK8YPi7K4cqCDB/0muNnRFW7w5UI4h8t5M6KWkEQjEKmI/cC0qawDg7vhNzcpC+0CVCKgEa9EzvHk29aFfx8fb3XGQJxL4eFzlzT43ExBDIaHH//Nitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JAEIu2RRqDm7jtsmnRCq7MKcPy4zNsBLSvfrPIhgmM=;
 b=AaHVfmlMhHXAQiu1PHfxGGDLFU09Y2/9jgpIYlPVRJMCrEWieNN678yFbRGVfi+QLzHSuCGpjh6+Nz5RHZDMMOX3q4DXbuHhXn67wfdd/jhiUDL0X0SxPChtmjDvBPbPJIrqA07GJQ5Z38B5BXfR9qJdnqC4VJojYzNJk3kCo2KFepm25reVpU1oHtdgC+Q3JgsIcekOsRWVhMq0rTeipFdPa+FmK8J4VZeWTglQ1yjvwaAhzyzQF5uON1kRIGchcuqc/vuL6tmtni2sKJfp7oowgbEtnw2AZ6/OIi2FN3a34J+XkqkiIfYOAsNayokDDNeu9baocHDuLW3zX+d6Uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 06:07:43 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 06:07:43 +0000
Date: Sun, 18 Oct 2026 08:07:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Drop the locks periodically
 while walking a user DSQ for re-enqueue
Message-ID: <atRiJSZfbaRunnkL@gpd4>
References: <20261017235840.1446655-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017235840.1446655-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E9F.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::451) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7047d4e2-d08a-4e07-d520-08df2cde1f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	93O0am+buCpBk8Ak5CoYqwU6H7Lw5K7iQD3RQvWQZUS6mL/e6y92LsVMyalvKlfUURMVW84QdTbK28BUXI36KdsUomyZo7FihsOVac08DQA4ioDN5RFN+XxCl147y/3+jZsE4ykBO0e4eebLrtko55Ls1Fw/Mv4m/VUhgR0wa7iqbBDND5adWAEl2yLKGWddrkG53Dfe8jLwGEH+/BA1V9aqoRr3Vq7/5W6ey4MTUp+sHXwrqi6+xdF6WrorsfLKdZzHViLIerpejh1l5MdkGZZKj8bbtKuhdEE84MA95VZJD93L7FbCUy3Jnw7P9eaPwsWJ7yd4UqIWUAnrs70BD1RsfijftiS7su4xFnuyeG5ZZsCxK7ZnJdG1H1qBzdiEJ3jzR4whJkW//62zFUZqQNSYiI5zDeDK7K38AqgP08QRbakB3BORDYMQJyN891uGl+i2xdKdTBEbkmNSc1ckRKTPEYZiR/jWabNemEi1WE/ZVZg1Z+mW6vTMd8kRIDd3VKLCXRv7lB2bkQsCmrdqkqJFsNW4BUekPXyu7XygBY+XaXJIVCKFSHV0kPgwX/5Cj6dYesVaNg8rjWiS1636SXO1PXTC/CqviXRc5Dhv1Mpdn+DbE57j6p09pBPi+MImBVhNdCmVJCfRcRpd/KP28LQHmrTR2TBXKc0zvc5ZT6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4TryT4UXMAaOUyyl6QImCMaWO/52FHdDDxHOh3oAVo8PvmT0dMFxEBoghQ4?=
 =?us-ascii?Q?bLkfrkQKD3mRtfFzU0uOlUTlK0Tgg+IcFGwyPB8X2GJ5JQednIDYD/MytxYU?=
 =?us-ascii?Q?vOffzXUR5HpJsApHHM60cBVP1k4FhCm/7kKKoQhEcm80a2Jav7ogzYZdrpmX?=
 =?us-ascii?Q?oLUQXgu+sUTTEqwwgG2nxU5M+V/yBD03NcfuOCFSy0G7jK7/qEtnUdnu5m2x?=
 =?us-ascii?Q?5UY0JdGZG0YBLYNmpepR8CQzuoAOKHMwPMRGX5dZ6aC/DAq3TDC0HxxHH2CM?=
 =?us-ascii?Q?559u0zzoL7IfXRGhhS8jNEEotDngFeIE2OejT/SwbiVBEAOv2t2yRSVEYyRH?=
 =?us-ascii?Q?nViAwn+mk8LCmrX9igSHGez0B7/htmyZdiJzVDsYYxtxiOSamSVruAsquuVq?=
 =?us-ascii?Q?zeWvIRtt0zvCJeL350Db8z7Yx5jWggzZsdDPxXxUINjiLfTSK5z+pojnorRt?=
 =?us-ascii?Q?PqXb4dceR6W+v8z1RicWSu/4GSsnBNZgbA91tpMGWuStjV/HbU6Aw8nm/8i0?=
 =?us-ascii?Q?OZTBJ1wysXxtZNkXNMm7azPP5pvgcuQwBWfrAt6nDviOambzXBadHz0VEQig?=
 =?us-ascii?Q?1yZiL5+LEOr2R0o0ITxlRr2haKTpW6iruz4+cbcsw+vFvWBEEXqahvQmGqat?=
 =?us-ascii?Q?LsunBHDwHEmKUGXjJRq27kWasY0Bb2hXFpSwNLTfup5fnAvbnvHSDurOZU4N?=
 =?us-ascii?Q?+r31utirH+7H9eio+GaQAZMQqZjltRtvS8PPK7AC0hX/vySWF69bhlB1ljte?=
 =?us-ascii?Q?06owogZSfG1YfgvP3sj8ZmQuL0iIgcPrZAQ1/6pX+9SFWNTNPEJqYAdz8h+Z?=
 =?us-ascii?Q?PxIqPsSRJ0kE7pG24GhSyn/xR3aJsY2F+o6n13L/rtpf0qVUpO5ChUQNZGe9?=
 =?us-ascii?Q?+lIWLkFc0SOGMJMTMztc7Vd+tRu5MAnkW7Fdi7Zjm7wTl/HDOdSl20LmLn/K?=
 =?us-ascii?Q?bbgFAndpJHgcqUbkyKQG11KZrTzOMgzXKBUqS1XJTGduOOouBEeLwOXTGm7e?=
 =?us-ascii?Q?l5mT3dU4FQqgDI5ufa6l+kTeF1GlIeFnZ/Vab1vopMpvA7i/CtayRnVXSSwT?=
 =?us-ascii?Q?gz/d5jCy0JPlROqoQOi1bzs+BIK0cjC2uFW0cOAUq2J3THPwh06v0RzRm6Dw?=
 =?us-ascii?Q?dlmhcB/3wZ/J/GoUSkbGrX00MyO1O6VL1owGO3kDrYAVj2eaT958IxRKIS7c?=
 =?us-ascii?Q?XwX0P/FdMp29BpOTE3uF7Hvwu/WNJEBPgkL/jar9fRKWbBpBpurChGfQXGim?=
 =?us-ascii?Q?AdAT1nXvmqDW/sYIHWiySwqrBS/Iwc8TADX9thE37u5CzIpxnEkrGZhHlBuE?=
 =?us-ascii?Q?SvksO6xaO43ynDbKKlvbOOizlm+Y0V2cM2rWfBTSYCsntqUijlo5IcxSb9W+?=
 =?us-ascii?Q?WzxB2BRogvGxFtFFJf183Jz29KGa+s5O4orFvVq5b/Dt6m8SIi7JdNXCLily?=
 =?us-ascii?Q?uXG9hCPniVzhmLRi/epVAGQKeem+NOTXp2S+yMacvG2e+eVkCJXjMxhGKZNx?=
 =?us-ascii?Q?3h2bg2hAvfnQFZhWJd81HrMuYecxKc1P97D3Wc57RhSWmP6Wy/J00cg0Xxdh?=
 =?us-ascii?Q?Tg46dxcAhxuTuL1gJF+Q/KjiW+4pd0Tgt0DOhUcwjgVUsbLLomHPipH2kEip?=
 =?us-ascii?Q?E98nRLYtAf69spNrO4w8P1sB+stBV1xyXs+l6XLScc3brfN6M9MfC4rqyHpf?=
 =?us-ascii?Q?u7XeiFoOLwXya5oXhHtjRhmkO/RQB5CybKlxuIJnWqXUvMDcbRayFurpgvlH?=
 =?us-ascii?Q?VDaW2sCWxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7047d4e2-d08a-4e07-d520-08df2cde1f52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 06:07:43.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsC70QRv+q4QoKmVRWdr0psPdNYlvGfOt55acCeL4PLDIYEn4DfKJFEMMCTxhWQk0RTuBRN8tFW4Zjt3ehm69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Sat, Oct 17, 2026 at 01:58:40PM -1000, Tejun Heo wrote:
> reenq_user() drops dsq->lock around each re-enqueue and its rq lock every
> SCX_TASK_ITER_BATCH re-enqueues. A walk filtered by SCX_REENQ_MARKED skips
> unmarked tasks without dropping either, so a long run of unmarked tasks is
> walked in one hold of both locks.
> 
> Count the visited tasks instead of the re-enqueued ones and drop both locks
> every SCX_TASK_ITER_BATCH visits. An unfiltered walk drops the locks as
> often as before.
> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Link: https://lore.kernel.org/all/atP-LIKpxPhR-Nuc@gpd4/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 14fe63428036..07857039aee6 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -5111,7 +5111,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
>  	struct scx_sched *sch = dsq->sched;
>  	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, dsq, 0);
>  	struct task_struct *p;
> -	s32 nr_enqueued = 0;
> +	s32 nr_visited = 0;
>  
>  	lockdep_assert_rq_held(rq);
>  
> @@ -5121,6 +5121,21 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
>  		struct rq *task_rq;
>  		u32 reason;
>  
> +		/*
> +		 * Count skipped tasks too so that a long walk doesn't hold the
> +		 * locks throughout. The cursor keeps the position.
> +		 */
> +		if (!(++nr_visited % SCX_TASK_ITER_BATCH)) {
> +			raw_spin_unlock(&dsq->lock);
> +			if (locked_rq) {
> +				scx_rq_lock_drop(locked_rq);
> +				raw_spin_rq_unlock(locked_rq);
> +				locked_rq = NULL;
> +			}
> +			cpu_relax();
> +			raw_spin_lock(&dsq->lock);
> +		}
> +
>  		p = nldsq_cursor_next_task(&cursor, dsq);
>  		if (!p)
>  			break;
> @@ -5157,13 +5172,6 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
>  
>  		scx_do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
>  
> -		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
> -			scx_rq_lock_drop(locked_rq);
> -			raw_spin_rq_unlock(locked_rq);
> -			locked_rq = NULL;
> -			cpu_relax();
> -		}
> -
>  		raw_spin_lock(&dsq->lock);
>  	}
>  
> -- 
> 2.56.0
> 
