Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378836D9E2
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781838; cv=fail; b=cSUaYANfg+9UEDaWQHMcy5ztbHOWrt5A3xSMRJtSc9LRjLLldnd/auhVzpg0vxkUxMnAKvEcFjoCgOodyjNsDTiWVlYLV/kmDA9FUW5cBS+ygS7G7JrIFUUwIo3y+XsTj9AqX8EyM8CE/ih5YCUyZv1uNw830bvti60dlRgFf50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781838; c=relaxed/simple;
	bh=8xR0xIl3wybhxy43AKQEnTpZlp16PXOAihURlHWWwmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JuYZDiRDr6aO8aQt1OkC7wNZ9N+cLO+GXscmS80/9A3aVTAZINcjngigloYnkIqTpNm/+bFpe4V6SBrKgqk1WqZG/JsBQpE8TSVXnusSF9PiCu7xFRH8Bv9VilXj0WmRiN8ihD8J2TS0P9X4tmDFUwIdeyKuRstEzsOQXXsXwgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJ8/gigS; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJ8/gigS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCxSByTq5sPueQY6FwSRq3tzUCq1R0jdjeURQrWBK8Dv5fkhGP5v7e3WjmUWVS6jMildCf7mlCTlOgM5KxfOVrLPObZOQu9v/Lf0Yf9yuhbWt/Nryxr1ryqPiJqZ0lNXgMW6YQ60ApAi5BsEdMe2g2xFWpVjID90RrIKszgarFGaWgei2HTQMTefbolhiM2n+z086HWUy+RZNnGl8pCpPCODHVgls9hE+NMy03uQtUjbHP+x9zierEDIu8n5mbm6qMViRckKvlyLL5qdwGAI/FYeZ9vUSUE0lMVDuKP5vHsCpNjOp6wNsXaFDsAH7k8JNGPfeopCt0e4mjmeY+FCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE1acgppsRuC8Lo1JrIwYb4E/o/W/blj9UccCbQr7Ys=;
 b=CmI2u2tRBkYM1m0jh1P6Jxhj8gPHdCuRxGzkkpcvyfDMoOkEoeVH5yBfPqq/eUjlBzfOj2SAV82ovuDbUX4ns2stv4CYDGztn1Dz8ceLzgD2+VIcIhlVKZqM5TvgMDcDk0Ad1QWNST6Qsa4XgCyYYU8QqkdFjSGanzuUO6y+fIz1IxeZl8HVXFpO+UaASB5+1QbICdkLoRfJ25HM49+q6kW2M6Ck/GMj9rAmx3hGhTrMENoTh6qEAPFUShOW2LIMjmbFarCEzROHb0n2N6v5tbCdll2kcDEiUtPiF5XJeq0bLa1l+rXHRG5l+wEThtuprHe00fs7hf5iK546jyLIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE1acgppsRuC8Lo1JrIwYb4E/o/W/blj9UccCbQr7Ys=;
 b=VJ8/gigSNCpFJ/3VkqvP6L+J3Bz9VlCl2bcQHn3DEolLnPEPSuRO/aGlYDLjpHoIgwUd+J8gX0k3dck4TDicbpu85Cwsigu9dEbxjVMxiVIE9XXkGievQmOw11+bNdaHwVHaaF5+xcfbwAzWykXgp5W7C4LlP5iLd1bgJqxf2MDkh6Yt9Xa28pN6iQyBaB7Txuc+CFdEdVn9Smtzy8p/PfBC4FVY30bJTvUMo5Buw4xEZYg9GhuFcATYTH4i7LsTgHT8qbYsmvj7x+3u7/y5eTSdrNCBiNrs0EziEn7+g6tvU7RDTzvnoYK+6Uso9+aeJyvZ2XbhdPFdajPZVhymDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Fri, 6 Mar
 2026 07:23:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 07:23:52 +0000
Date: Fri, 6 Mar 2026 08:23:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCH 23/34] sched_ext: Implement hierarchical bypass mode
Message-ID: <aaqBBQPy0QYnWJbn@gpd4>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-24-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304220119.4095551-24-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e0fc87-56eb-48f2-14da-08de7b515197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	lJ8YmV0TJ3gInhz3/pmnKi6n5kDhdM+pMFpdFsHi0rzDGyJ2I96f8X5tuBOY2URHZ0A8zrGmKWj3DWSQYqKq4bwNT+6eg5wHC2+IkuJ/PFEW8xAzmzQlrz5kVoY9C46SC1ojeRfY5zkn7SKJTRkEeCeGLrHWPricRKnuC3P9GaaNHJE+U69RPLGRC2Pk7l/MgB4PUcXjSqJrjEnb8Vc7o9zssQOs/MIxfGvpDaMnYcm9gHbKJjVvMHJq/vjQ02fgB4P9PGpYSHztqb7bdIcjG5MjRSvVzTgAm9vge9eo03l3anf384PwKMW3zKleh0iqsmTiO8DikmB3nam4viyAQjkhszZHrtHgHhVTN4a364BZF4jZpKQbbiYKBEHn2/RUXBe5s13TUMrHWAfxUjmXO3mX0pHnFp0dSnW5N+rgWp3ASIx+2I5Wd4gj/UYsIZ8t9VZyK+QuVLvACpmUVJ8rkMSFKoSluGzUE0YZJiA4w+tKWqpb6zNQxeqYowjmS9dfeFz/ELqjDWXUtEF4sorMroAnPpAKFcUeoD3VSg6F+XUQGdIDwz0o0iWcNP21LI0BLgqeF8o48i5ej3HkOoRmANcKRN6NKbwp0LC0eLgO02imFBLyA7P5eyy6jqyQt+DEU0uH2T7XPwCapaZXLdkHNtkKqq8pkedDw+Xtvk046rGMUfEuPvAVlte71c5G/Bu89oe76wQ/nHa5jHD8fLhMC0vp0XbwKn6pUWBlpQQiwjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlbqRUVtCUfZs+8jiDIoX9ZW44F8Cxxfc+bslov2t1ZSdFfCWPuR2atL4OdB?=
 =?us-ascii?Q?E6RuAemKgYAhxxguHLaiT73yBvWun9bEL7E5kRj3SB9WCJt9Uw8YH7YE5KDl?=
 =?us-ascii?Q?IMq68KVGC9xBaW6M6ZWMoywY6pGeOegKRnbASRrizoWyf9u2tbxCZY3Nt2fr?=
 =?us-ascii?Q?8AcBJ3OqUnFIbBkaLsQdYuUK+whiiEuvoJB3ucHgVywbvjE+K5gOrOkeJ0dL?=
 =?us-ascii?Q?4reN9xpNR1HcxVdQ6AAlHm76/lCQmVPRXvSGLMV6gkkC3AThJtecLyUJkHW0?=
 =?us-ascii?Q?8CUSRTVprg7Qa9SXseqyWGHiRtv2vvhuqYHdIlTI9R8s/Tfn7fLzB+yPRIMi?=
 =?us-ascii?Q?zoAQgssJTu3hr+UekBvbCPNK6Z0NXqcdlhLLlo1q4hpY1W0Lroco0qP4x2xF?=
 =?us-ascii?Q?T9CZjzrv7vu/3yQZRA8BYUbjnwxZ3advHun4FnjkqP+2hfihhyzCcaa6YHGi?=
 =?us-ascii?Q?eCSVACaFoKZCfxAMan9nJ2fSuf96JxhGuztXpr0LZP4zxJiSejwOmhhyNMbm?=
 =?us-ascii?Q?PeXtMuq/AQjKJbQRsqmj6wo8Gde//y/hyCtlk1jiIGxY9G3PgO2p4S/e6ReI?=
 =?us-ascii?Q?Rm5gcfm1/IKtwk+NoSjXQatV3rWB3KzIlQFMbv1dh2wfKb+drO5kl77WHaHe?=
 =?us-ascii?Q?yN+tt5nGH1C0KWhnI+ZLvXXCH6v9pDtHH70mrJZK9ORUClHHMi6Qlf41Xi1A?=
 =?us-ascii?Q?lyiHtWnBiig5mMbY8tbQ9jJfGe5IMfk853v9gyb3Kv/wSs22ecffvWQyXdaf?=
 =?us-ascii?Q?djo3w8zQmNu3vvcOCqLYoXcTept5fUB1fWHWQuX4b0r3eP2Sc4w/WKMPmRsu?=
 =?us-ascii?Q?K+Le2sUwLlStvu2CAqaV1xwE4BcssEJdSl6wrNON6GPmPSYs83UpLtSQF5Y5?=
 =?us-ascii?Q?hm2/QqIuaF+ZySOYD6LmQjTM2MelGWPA12clUS04JmWf41wiJSJLzpWkv2y3?=
 =?us-ascii?Q?em5roS/SF2KTuxFNPqfO1TtB6uVWmDDcYJ9EuVCRKbNePXbGDuuzOam47RKV?=
 =?us-ascii?Q?ILST8yWish/G4BWeJ3DRREF+rqgnYhT7C5junmeQHrqC2AgPrJhLaouM9voR?=
 =?us-ascii?Q?perTLc8zmUgBybTSg4sFZe5VD1rN+fS8fIK/Jq4bokx/cB5iSJ4g02S6AIUg?=
 =?us-ascii?Q?XxHRPpLQZAfIXtj9E5q5z2qAcUiOkNTuHCPUF1QQkRLp8soOEXIcGlTBtP4S?=
 =?us-ascii?Q?hpbzTBxIN9xggIXAbA3lFQrvd1VgJzphI4rQ5Q9POSJ4gL6WybmLEBpNnUlO?=
 =?us-ascii?Q?I7dKP+82lFgDHZfJfeSKh9TwNAawIK53vBbi/69alTrasyL9KxOb7fb6V4Ul?=
 =?us-ascii?Q?8Vd2kgkuF+rw1pmC2RFzBza4bXtK7q6ohH9+b2/4+9sZdlxOC5FU+qmPFaiO?=
 =?us-ascii?Q?RUg9rFqWZp/d84PFP4B5BJlrpZ5QWV+ZWdCJhZwJPTmK2fMHavKjsUylpJza?=
 =?us-ascii?Q?NBQK9JXMBVn1bhp6px1mU4HT8YzRTQlLXGtIs3o2CKuW3aIhdCgQ0RMDw5Fb?=
 =?us-ascii?Q?zUKtCfVdrQ51cE3Az3GThwLqlg+kNQGr4uCJBSS2Y2n0R6lfGYtfA1v0+v52?=
 =?us-ascii?Q?ajS0xBdkrRV3sVj1X+noV4kGHLT1hxJHXKVsGjdEJHHtGb335VzORr/Lo5GI?=
 =?us-ascii?Q?wrdvK+gmYdwZDSvsGA0EvYXAYqiOZvVshe6bN14ICdfyfNv17Xr0KN7Tnn+Y?=
 =?us-ascii?Q?6BC0ONvRx9x78TyDP7NjogcnqK9BMU6lhq8Lgsf/32eY1bJZPcGs+PkV8tl7?=
 =?us-ascii?Q?b/NH7jIyLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e0fc87-56eb-48f2-14da-08de7b515197
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 07:23:52.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBxft3bybuPVn2rEIIfwKyAPMhwOuJ3GA3lqmKahDJzq/e4+ShukPg7l+V5kHMtD22jFb7OpM4YqYYoobcOWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601

On Wed, Mar 04, 2026 at 12:01:08PM -1000, Tejun Heo wrote:
> When a sub-scheduler enters bypass mode, its tasks must be scheduled by an
> ancestor to guarantee forward progress. Tasks from bypassing descendants are
> queued in the bypass DSQs of the nearest non-bypassing ancestor, or the root
> scheduler if all ancestors are bypassing. This requires coordination between
> bypassing schedulers and their hosts.
> 
> Add bypass_enq_target_dsq() to find the correct bypass DSQ by walking up the
> hierarchy until reaching a non-bypassing ancestor. When a sub-scheduler starts
> bypassing, all its runnable tasks are re-enqueued after scx_bypassing() is set,
> ensuring proper migration to ancestor bypass DSQs.
> 
> Update scx_dispatch_sched() to handle hosting bypassed descendants. When a
> scheduler is not bypassing but has bypassing descendants, it must schedule both
> its own tasks and bypassed descendant tasks. A simple policy is implemented
> where every Nth dispatch attempt (SCX_BYPASS_HOST_NTH=2) consumes from the
> bypass DSQ. A fallback consumption is also added at the end of dispatch to
> ensure bypassed tasks make progress even when normal scheduling is idle.
> 
> Update enable_bypass_dsp() and disable_bypass_dsp() to increment
> bypass_dsp_enable_depth on both the bypassing scheduler and its parent host,
> ensuring both can detect that bypass dispatch is active through
> bypass_dsp_enabled().
> 
> Add SCX_EV_SUB_BYPASS_DISPATCH event counter to track scheduling of bypassed
> descendant tasks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c          | 97 ++++++++++++++++++++++++++++++++++---
>  kernel/sched/ext_internal.h | 11 +++++
>  2 files changed, 101 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6b07d97b0af6..2a19df67a66c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -357,6 +357,27 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
>  	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
>  }
>  
> +static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
> +{
> +#ifdef CONFIG_EXT_SUB_SCHED
> +	/*
> +	 * If @sch is a sub-sched which is bypassing, its tasks should go into
> +	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
> +	 * not-bypassing ancestor is responsible for scheduling all tasks from
> +	 * bypassing sub-trees. If all ancestors including root are bypassing,
> +	 * @p should go to the root's bypass DSQs.

Another nit: no @p in scope, maybe we should use "all tasks" for clarity.

Thanks,
-Andrea

> +	 *
> +	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
> +	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
> +	 * all tasks are transferred to the right DSQs.
> +	 */
> +	while (scx_parent(sch) && scx_bypassing(sch, cpu))
> +		sch = scx_parent(sch);
> +#endif	/* CONFIG_EXT_SUB_SCHED */
> +
> +	return bypass_dsq(sch, cpu);
> +}
> +
>  /**
>   * bypass_dsp_enabled - Check if bypass dispatch path is enabled
>   * @sch: scheduler to check
> @@ -1650,7 +1671,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	dsq = find_global_dsq(sch, p);
>  	goto enqueue;
>  bypass:
> -	dsq = bypass_dsq(sch, task_cpu(p));
> +	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
>  	goto enqueue;
>  
>  enqueue:
> @@ -2420,8 +2441,33 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  	if (consume_global_dsq(sch, rq))
>  		return true;
>  
> -	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
> -		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
> +	if (bypass_dsp_enabled(sch)) {
> +		/* if @sch is bypassing, only the bypass DSQs are active */
> +		if (scx_bypassing(sch, cpu))
> +			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
> +
> +#ifdef CONFIG_EXT_SUB_SCHED
> +		/*
> +		 * If @sch isn't bypassing but its children are, @sch is
> +		 * responsible for making forward progress for both its own
> +		 * tasks that aren't bypassing and the bypassing descendants'
> +		 * tasks. The following implements a simple built-in behavior -
> +		 * let each CPU try to run the bypass DSQ every Nth time.
> +		 *
> +		 * Later, if necessary, we can add an ops flag to suppress the
> +		 * auto-consumption and a kfunc to consume the bypass DSQ and,
> +		 * so that the BPF scheduler can fully control scheduling of
> +		 * bypassed tasks.
> +		 */
> +		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
> +
> +		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
> +		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu))) {
> +			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
> +			return true;
> +		}
> +#endif	/* CONFIG_EXT_SUB_SCHED */
> +	}
>  
>  	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>  		return false;
> @@ -2467,6 +2513,14 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  		}
>  	} while (dspc->nr_tasks);
>  
> +	/*
> +	 * Prevent the CPU from going idle while bypassed descendants have tasks
> +	 * queued. Without this fallback, bypassed tasks could stall if the host
> +	 * scheduler's ops.dispatch() doesn't yield any tasks.
> +	 */
> +	if (bypass_dsp_enabled(sch))
> +		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
> +
>  	return false;
>  }
>  
> @@ -4085,6 +4139,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
>  	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
>  	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
>  	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
> +	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
>  	return at;
>  }
>  SCX_ATTR(events);
> @@ -4460,6 +4515,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
>  
>  static void enable_bypass_dsp(struct scx_sched *sch)
>  {
> +	struct scx_sched *host = scx_parent(sch) ?: sch;
>  	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
>  	s32 ret;
>  
> @@ -4471,14 +4527,35 @@ static void enable_bypass_dsp(struct scx_sched *sch)
>  		return;
>  
>  	/*
> -	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
> -	 * before starting the LB timer.
> +	 * When a sub-sched bypasses, its tasks are queued on the bypass DSQs of
> +	 * the nearest non-bypassing ancestor or root. As enable_bypass_dsp() is
> +	 * called iff @sch is not already bypassed due to an ancestor bypassing,
> +	 * we can assume that the parent is not bypassing and thus will be the
> +	 * host of the bypass DSQs.
> +	 *
> +	 * While the situation may change in the future, the following
> +	 * guarantees that the nearest non-bypassing ancestor or root has bypass
> +	 * dispatch enabled while a descendant is bypassing, which is all that's
> +	 * required.
> +	 *
> +	 * bypass_dsp_enabled() test is used to detemrine whether to enter the
> +	 * bypass dispatch handling path from both bypassing and hosting scheds.
> +	 * Bump enable depth on both @sch and bypass dispatch host.
>  	 */
>  	ret = atomic_inc_return(&sch->bypass_dsp_enable_depth);
>  	WARN_ON_ONCE(ret <= 0);
>  
> -	if (intv_us && !timer_pending(&sch->bypass_lb_timer))
> -		mod_timer(&sch->bypass_lb_timer,
> +	if (host != sch) {
> +		ret = atomic_inc_return(&host->bypass_dsp_enable_depth);
> +		WARN_ON_ONCE(ret <= 0);
> +	}
> +
> +	/*
> +	 * The LB timer will stop running if bypass dispatch is disabled. Start
> +	 * after enabling bypass dispatch.
> +	 */
> +	if (intv_us && !timer_pending(&host->bypass_lb_timer))
> +		mod_timer(&host->bypass_lb_timer,
>  			  jiffies + usecs_to_jiffies(intv_us));
>  }
>  
> @@ -4492,6 +4569,11 @@ static void disable_bypass_dsp(struct scx_sched *sch)
>  
>  	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
>  	WARN_ON_ONCE(ret < 0);
> +
> +	if (scx_parent(sch)) {
> +		ret = atomic_dec_return(&scx_parent(sch)->bypass_dsp_enable_depth);
> +		WARN_ON_ONCE(ret < 0);
> +	}
>  }
>  
>  /**
> @@ -5266,6 +5348,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
>  	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
>  	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
> +	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
>  
>  	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
>  		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index fd2671340019..79d44d396152 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -24,6 +24,8 @@ enum scx_consts {
>  	 */
>  	SCX_TASK_ITER_BATCH		= 32,
>  
> +	SCX_BYPASS_HOST_NTH		= 2,
> +
>  	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
>  	SCX_BYPASS_LB_DONOR_PCT		= 125,
>  	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
> @@ -923,6 +925,12 @@ struct scx_event_stats {
>  	 * scheduler.
>  	 */
>  	s64		SCX_EV_INSERT_NOT_OWNED;
> +
> +	/*
> +	 * The number of times tasks from bypassing descendants are scheduled
> +	 * from sub_bypass_dsq's.
> +	 */
> +	s64		SCX_EV_SUB_BYPASS_DISPATCH;
>  };
>  
>  enum scx_sched_pcpu_flags {
> @@ -940,6 +948,9 @@ struct scx_sched_pcpu {
>  	struct scx_event_stats	event_stats;
>  
>  	struct scx_dispatch_q	bypass_dsq;
> +#ifdef CONFIG_EXT_SUB_SCHED
> +	u32			bypass_host_seq;
> +#endif
>  };
>  
>  struct scx_sched {
> -- 
> 2.53.0
> 
