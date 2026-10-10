Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FD3D7D97;
	Sat, 10 Oct 2026 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791635667; cv=fail; b=g/Cj32R4fdMEhGYJ8x0YYQXylW0U1Zpti1JpGDShxX3MUBYh+R/NI9OUCk80uSjJCpkFeXSa9YbwntoLVF2EKiGhQLBbxDw3APgVfVlnsj0XCvduxpllKTZlwWr0UcP686FdqUDoNLDPV7sKK3pNwzwk89oMtPZuNwChn7BFu2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791635667; c=relaxed/simple;
	bh=ElHk6zlGDVNS4qxxGFHqTwed39OvtpbxLwmMMBqCKsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E4PYg9b40gNR7WlHro1i4s12PzQ4PQSoR1pn5yGvDw4DyxeZlgDvuHxu6g8SXPhM/z/kIiiCbqbWR6f3p2mEynljnvDQUWfutaKs1j2pFg6JBctsWWc/wvDLf1EcCjEUAlJlknwP90/llrFyCWn9qPn+OBPUse8gI2IH4C2D4FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sn0N4AVL; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sn0N4AVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpI3Pbk8hMly+4SP7dr+5cvJdfMI4di+mvRugoa12AQMmS+38TbawO45rmZOeSNSXxYr9rJHk3zxBZEgKGkv6m1IzcRBf11JxCT8vVzpCZRL6gCmHudePmP3p8vSm1CgGT/gyaWYHUM5LmcNVWiqznUN4kWQJhNi5cB9CsnhI7VZIL0NOZdcHN5F51XVV5UFWpYSeenM+XN0ty8hzZb6rrZTtBsfbXL+GDsE2PdlRuLV+dtVvhM1tSRZpnaUXWgAbZjPHPJ4FOy7rWpBKPrp9VakQ7wtPw10qtStHaRChRhvOJ/kDNwt0x6ZEDKjVR8pRuOwcy/HFRibPJmf4c2uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WukMybrU9PbGne5jmnVZZajbdzmdlnsHDzfnRh32p3E=;
 b=xNra35iim9yjb51kD7W2OqcBOfKEzVALgu/C7XQMB84YTPuPpUb8LdlrJx+OB2EyzcTm4y7o6kX5rsR0o0RrhOuQo+ukIi+sZ6OML1TEASZQUwxk0g+bpD5t0K9K91G6uw5ke+E3pWDE1bpSKl99byzFAhrGrXEicbB/9oD+z+l3ZJaITcBd+zIQXFB2QQExJVd9cgZQpvpXhd4aBGF4+2D8T93wE/J1FgcE9+MkyeD3j8VwQ3eizAS8Y+a1ghOsWZNXY7lnrKVeozR4xuXbgHbn37nWkN4rzlJwCGXkyJdS+JQDF1iqojiCFSe1g2E6yIK4OVwEjge1w6MWdUglGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WukMybrU9PbGne5jmnVZZajbdzmdlnsHDzfnRh32p3E=;
 b=Sn0N4AVLI6YSvP6evMXcZp/+BTSL2sWUFMwJFGfNR6lM1Tvjwu1Pq3nBH8g8y2i5iq5Y7t9u3/MIPzqYtyFsTwY4JotMQnWr9ewbvwOtsVcPtVlHRcawdSNHt6tR4N/rUP1tNSCjnI1kYpoQIbSJdTR3fqimWR7psy6/51qXbhWd3GIW2HJ7ZQX76Z/pAhTfmKJV4yNa/7awdNZLHdcvbfZIFw8VIKe76hcACmQ3e2WignojeT3TKH5R+7sutNGGaEQZy/fT53gHrQcqfKetV4/MfxYcqAA8JYWozFO2TxZ+GWPy4kvVmJlWHAkhYiz4rC0iMadhby/yr6pezdjojQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 12:34:20 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 12:34:20 +0000
Date: Sat, 10 Oct 2026 14:34:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't leave balance
 callbacks queued across a pick retry
Message-ID: <asowxUQzQpb-wxMO@gpd4>
References: <20261010095208.276806-1-arighi@nvidia.com>
 <sashiko-outbox-166417@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-166417@kernel.org>
X-ClientProxiedBy: MI1PEPF000008C5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::427) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: a45a8f32-280d-4f21-d57e-08df26cace95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8YEgKBL5qEZXt/xyODL6LTDIyMTjAm5ogBifQMfRuhl+IdRzJWzLpjHluT7Cc6fj5TJRpK191n6DGWjVWCUpRewb0oLIlQ7HuFET41YASt7ljVET6F4t9eeRgD0IpFtH5Olc9KTIJcwAYvN70mjk0z7/1EQLvC1id1zOAhw/wuguX4bu7FdOxo1sU1KBHo4qaG95EMAGxO20EDPxdJ0xZMAYYBfvhjOt5OH01E9F4/XhJFwuGkE8hTbPSvliIfeSVAX488D+mTpd4RbXC1spTplbEJyiM117lUx6MNrW61gK0UjlRhewOLlZz3Ck7G8ipWFs+ykRhjtnPvnLkm22lwo6c3GWk3K1fqh2QlshW7obqPOS8C+eVcm3RAo3sxGnXkJGR7mBccJU0HCNbhw60HqEJuawAGgbUpgzr7H/zGORudmu3x3DuZ1rymO2oqRBrUjLdG/7EALuSSlVrndRcu4oZu2RRknPI396yaqNq0NTJrwUzdSqTqWYFfWADuExAAzlI/fWOba/8wkD5r6w/lFX3synAv+oM0hBQGyk41DrkHu9P0bDYQ69iu8uSU31b61cOoYSVtXWw1GR9bvOqMdl3uX081ZtnH2TLQLnrvUUMf1D7WDbd+vwydu3kdqHd+7x81PFVZD+HF4VyWljvGdQyRpW6DbJSZNhXccbi9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPBmDXFfhuIAy6xMRDBth94YLPiFnHg1NYG+6sH0Iqw+6hC4F6xTxJavpwJV?=
 =?us-ascii?Q?Vb7dZYNm56XrYRnJk7jov3emQOYEAM+DYbdd94nSJ5aa7HFyARULIe1bwWID?=
 =?us-ascii?Q?zTnnBOe8xwgRPqb+vH1VNYyUO8NBqPCwZbFx3yXnYgjY5UAAwvj9VjkKo32d?=
 =?us-ascii?Q?lIJDKrv6XARrk8jcigtYSM51XWmN3NjiUpHi2O0eTWMGyLmEhDuPO9X4xap1?=
 =?us-ascii?Q?Eje8DEj/7g/C/2K/7eZcoDkpmXXDaL90KmzVjBPLbSaJlxYomyQKTTVeAeFe?=
 =?us-ascii?Q?i+1z7liwgV3oJze/QfZCaCbhcUjjTECL0DQBTN+6ydLM8QDUFf1HPTKOERbZ?=
 =?us-ascii?Q?Zo3Obwiaz1URVJz3h5Vc05Y39P4mue6BtoVrMXWnc0hRKYsMa1NzTxE9J/Kl?=
 =?us-ascii?Q?FIrHgzVsAQN0hx9uaGlL99r6bf1PuDbu9YcsHUY/xHbKMxIYnHVfV/UzgpVl?=
 =?us-ascii?Q?vF1ra0rZKfuEPQa8fwQmHfNgouv3mN9ss7YGyNT9ilCxkGBCyNCnyplHYQLo?=
 =?us-ascii?Q?50oE35QSaZoY/z1CBgMIZSWupXWPLRmBgHYEtBXItEM2WjtflS5ubrkRLdcX?=
 =?us-ascii?Q?maWBOE4XUqTyZUV6zjwgmcOjUtzAlbJyyokaSUKXHWuGr0bGnc8AwXk2c0uB?=
 =?us-ascii?Q?Npy+W7Fvz0nj9CV1LYuuZ3C2enZtvbeqTPBeDFK6Nq275an3qyorDmltcT3j?=
 =?us-ascii?Q?rUIs/ZiUzQwbBiY4ENVN7ft+EErSZVQ+hnfsI6iewlb/tU0hA41DNcZt7kjp?=
 =?us-ascii?Q?2QbQtLy8To8ZErWBg7wvbAwrmmfxxfqaVKYZGINblB3y5LAg1AuF6Nssx5BA?=
 =?us-ascii?Q?Cnb98L4xFuoYIHYSdTaR9de2Ya3KAitf+BI3u2nAst/i9y7rl6ffLNbSHK/C?=
 =?us-ascii?Q?/A6tqLJa1K1CN/F4seCUhcrPWr2fUuaID/O8j3rGO6M2SbRTE1AMGDlKj7c7?=
 =?us-ascii?Q?1wPoQaxUVrDBDmmNWk+HhpnKWfSMpmCA4AMoBIgkZzRcpzgXq16564GgxS4p?=
 =?us-ascii?Q?LTYpJBs7EGCSeooery051yMr4o89EBMIOwAIFhwh/uYKoxnhFI5D4XIKXbxz?=
 =?us-ascii?Q?lqyVet9Ibr1ayOMFz0BVbl7sI1hLTORH74OFRPoykPHEsx3xTeLBnkzZ5HpY?=
 =?us-ascii?Q?LdimXMI8RnpOcTsMDoUo1CekoNoNQrOCejiiNWcnF8oJ+bi/G+lLDcE6tkKs?=
 =?us-ascii?Q?PH5pDo2EBluHnISIyCIz5SzEhu0yas7NxQeZvEx9DLoxHEIKW4kKc8dxNc+m?=
 =?us-ascii?Q?nahMM5s8HD6Uy6ydG415Y7Oz7y8E5Vtb/JMGfX2AqB6+7pJQYCmwrrX12sUY?=
 =?us-ascii?Q?ZZwyDcdPeLkBxus3yTEJbzSDCTq5ut24n26hbu6Z1NCRRjnDB8MlqoZGafij?=
 =?us-ascii?Q?o8x8B6OzL1WT6Jr2Ba958d1aBEteyTT+7MlsKyGZEPGWXC+C577C/E9nm7Oc?=
 =?us-ascii?Q?vlpKGF/6XwmapvPX1Avu3xo78Kg4nEbMd8uKRlLwkbGMMh3DHJPhCoFz8won?=
 =?us-ascii?Q?ZKeDGglmXHeVUUgM3N2yy5iUD7OSwrSJ7cjuVYWpkm10G9/HQUrLNaXaf2No?=
 =?us-ascii?Q?h3Hbd6Jg+c+/QRsFbfizOv4uwgmxqZPybIQBWSqANuf9lyG8DC3xwt0wDu9y?=
 =?us-ascii?Q?gGtJxKFA01I4/JZKV4cmfRKnuIsbE6dfetQlAWt+3MwGNjbTZMBvIMWuQtAv?=
 =?us-ascii?Q?mjo13SnA7wb0obUpOLnlBQMfiGWlQEf2QOC5OX46qHASWJed?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45a8f32-280d-4f21-d57e-08df26cace95
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 12:34:20.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWFQXg0ckYPoRbgoF8CoYlclDThTlZ7A3VCL3KUmE50Zc7JjB/jz6mbfU2RDdaKa8Xs5UODMGRDXE2gdBUXMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585

On Sat, Oct 10, 2026 at 10:03:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] sched/ext: Balance callback queued on NULL pick risks lockdep warning during newidle_balance
> --
> 
> commit 82685b13d2a91f21d4676e7837dbf23573a2e3ac
> Author: Andrea Righi <arighi@nvidia.com>
> 
>     sched_ext: Don't leave balance callbacks queued across a pick retry
> 
> This commit modifies the dispatch path in sched_ext to only queue balance
> callbacks when the pick is final. If the core needs to retry or continue the
> pick, which may release the runqueue lock, it instead punts the deferred work
> to irq_work.
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 3f79156467799..54fa382ad8d78 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> 
> [ ... ]
> 
> > @@ -3433,6 +3450,17 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> >  	return p;
> >  }
> >  
> > +static struct task_struct *
> > +do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> > +{
> > +	struct task_struct *p = __do_pick_task_scx(rq, rf, force_scx);
> > +
> > +	/* after a NULL pick from the dl_server the lower classes still pick */
> > +	pick_queue_balance_callbacks(rq, p != RETRY_TASK && (p || !force_scx));
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: High]
> Does this logic incorrectly identify a NULL pick as final when force_scx is
> false, leading to premature queueing of balance callbacks?
> 
> When a normal sched_ext pick (where force_scx == false) fails to find a task,
> it returns NULL. The boolean logic evaluates to true because p != RETRY_TASK
> is true (since p is NULL) and !force_scx is true. This marks the pick as final
> and queues balance callbacks to rq->balance_callback.
> 
> However, a NULL pick from sched_ext is not final for the CPU, as the core
> scheduler loop in __pick_next_task() will fall through to lower-priority
> scheduling classes, such as fair_sched_class.

This looks like a false positive: fair_sched_class is not a lower priority class
than ext_sched_class, it's the other way around.

Neither pick_task_idle() nor set_next_task_idle() release the rq lock, so the
pick is final at that point and the callbacks are consumed before the rq lock is
released.

> If fair also has no runnable tasks, it triggers newidle_balance(), which
> unconditionally drops the runqueue lock via rq_unpin_lock() and
> raw_spin_rq_unlock().
> 
> If another CPU acquires the lock during this window, rq_pin_lock() will
> trigger a SCHED_WARN_ON because a balance callback is present on the runqueue
> while the lock was unpinned. This defeats the patch's purpose and triggers the
> exact lockdep warning it was intended to fix.

The fair newidle balance runs from pick_task_fair(), which is called before
pick_task_scx() in the same pick iteration. If pick_task_scx() returns
RETRY_TASK and the loop restarts, the pick is not considered final and nothing
is left queued, which is exactly the case this patch is addressing.

The only case where a NULL pick is followed by lower classes is the dl_server
one, that is the force_scx == true case and it's already handled as non-final.

-Andrea
