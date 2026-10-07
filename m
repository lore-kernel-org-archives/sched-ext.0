Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E734BA42
	for <sched-ext@lists.linux.dev>; Wed,  7 Oct 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357360; cv=fail; b=Iln1rNZNIApKF0BuMDnkcqsjz5Ev2gLsowEPGLcxySWg1knSF2iZnORr8HivVP7AP+fFmf2iA7YXxO8FkhdN4VMB6SydDO1zZbf6rWZz32Td/AnyfjNZ5Cmaux8L3FGSjThHy6ki8giBn6EOFdIqeDDI6dqdtgGdMoYvhMXtGAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357360; c=relaxed/simple;
	bh=iFqnT1x3NvnUDCUBE6LCJYkpc70HI5sidnm0IVGyenc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U0SvYgyMRGs9fEXJM6zm+OxdcKY0JgAb04P/K3oZvOK4ln4cirirVFcrcSLGrqukF0Dy3Hi8jCOjzBbeRLHBOWShCP1cj/0KNXHCK+4qMS0/byeC5V4EzbanA5LNQ5n7yAYNhEym9IYrpxgmiVT/Lc6/Bb4rxI20PNmnzKL4CN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWene5mM; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWene5mM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5Ch2hXKnhE94oiahucyGsrK8dAbS8fh4Wx+RGi13IjdMZcrXRbZmQlQhLTopxnveYdCUujycev5vct1foKulR10inQMWpJglnw2UdxzLlAgWP/1UroYo8xKePlkCvGQ05Wh0uYQ0TgkUvlTL7e1ghaH5e+KmJ1MwnXIXV/cv9VBRwGBjYic3nhOjJ+C87x0CgSTTV38pi/Ppbb3wT50myWAbSbHypZVEwSJMVR4Fn9LSMzRBehaqdG8CZlDIo9BCQOS43X0iI+pQ1mE2eHypzD/Zf1eX0yYpn62BP2NTbV8wHmjuCLQgbbkx2l+0kdVuu6wABFA4vbvINzWHHDiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2alSYpBJEWkBn4f64qrNH3zTCHmW2EMN5MqcqkqrDas=;
 b=vSmgrmM5EGlzsuenQd+ePE8cGFD0gyKgujTr6bcKcNGGCFNyDj1WmUOp3xKzhflV1CEDGrDiAayQNm/MdjTudGeRbz7wL7a9ka2elCI2N8HB5yEIH/xAZCICY5IWpljL6/dI1a8AiUa1tMMtccXdx9Puzk1LzrX5zy4HkynwyGB/ankffY90nN0aqIR8lGWtUazN0Nvgj9+4KHsjgz6qD3rBVWN+p1PMfTlq5vcr8HctkdMBAkfVJAnBQl7/Kh4Pi8OvBYQeb0YmfudR5ThRGNXVuqE3FrOwP3oPEhCD6/3gu7sRNdEhiyyjlIP7ijgg/9IkuANf9DDUIyMcH+soHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2alSYpBJEWkBn4f64qrNH3zTCHmW2EMN5MqcqkqrDas=;
 b=mWene5mM8Fu5MATaodCjQFEnc1Qy6Gz2h92BD0G12cF54V+pdV+ZqyUcTAfUC30ulHh0ba815qIGQ1hfB/OucEHLt7MeDZQxoNDTrslJ73wLOyLZDPSP+4hc0JU3d01lOHtyieswVUsxbq9VQ+DcxRcCl1z5adIXz0JyoKFyEL38fq3XN5ONB0H3oFFOjYm/rXOAH6Ln6yZJFK8cz+5NDzzyiRQ3QLwVf/dv8m3i6DhAWRACeJUHZaC1SUiiT8no9C3UOJW5aZksAUpb3dSFd/cw0tTz/qBq1yUrvnHe9ZnlaB+znKxNEXonZtjBmh3iXJkLByWvMB42Nx5CoTYSFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:15:55 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 07:15:55 +0000
Date: Wed, 7 Oct 2026 09:15:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
Message-ID: <asXxp0WabkwdB5aw@gpd4>
References: <20261002221559.3090900-1-arighi@nvidia.com>
 <09a36d7e76652beedcfb891b587a9c82@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a36d7e76652beedcfb891b587a9c82@kernel.org>
X-ClientProxiedBy: VIUP296CA0078.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::16) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: df3a5fe6-d987-40d1-ea96-08df2442d38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|11063799006|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	25WgqvE+IhFH/BnGuXieKAuf402YHf7uKmKxbON3nL8GkDfTgkEd4ahkixKhJNm3aiVCRJXkwOo9g7rWb5QYRevp8ms89ounPd91yEr0/L/hvZl3vwPdLbxvs1how0d89x8Lm4EadyiXnjr/zhcEKSg1PoOxDpc3H5tDTLU/8lROq5dGt2xWBmGz5W9zpzmSqZR0LuH+IGT2vQDdX0HD3h1+MkCakaPKVXZgx3xNblLw5MTZX2ESxfAPECbJ1rhDLIuh9+WEd5C8BPO6u9I0x0RBTN2Z3p8D5qW8yryt/CjV5Tx5/zMppC/IPzlFGaO7ACEoh8qPJJFy4twRaLKV1ciPFgRqoW+KegSHDgTyJekfoSFTshjf39wKxU1/WW9B0nSBXkqvSO+8MqR5y5cjzWQaHwXiVcEvYWOghkQybp6/g+XPd7tK+xIoJKDyd6Oz7+DESIJW2NOzVNqDULCXUZnTSz81wJn5rPcWgiC74WAdqKtc9/oZEud0yVJuFnUOTkJCZH1EOcNhNpZMh18zTm5TEpRnYUtoLmzj4z0OIGn2H0RCaNT7c5YXZ2ir2BbNO/sCRQ+Npcjkf3mTzWgfwrWnP+gNahvLuP56jxkvv+EPv7HHttvmkTNu24cLZD8uDUA5c/5tkPARUXLnWGPy2H4j7w+g+JEzS2TGRfWfYDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iE6daJmO4Thi42rY2wr7tmXR9XyIGCoR2tnoOmOSRPj7KRawfSq0zCYqKZai?=
 =?us-ascii?Q?wzF8U86rNrOJo5gt4VdVHMh0/PaOk6dUG/yxrpG8zhpULtb8ZEnk13uiTnn4?=
 =?us-ascii?Q?VVJ1X5PpS/GrzYx6HDdiIjpdIXtc81Fqnq0e3EGRiV3sEdYCibsnCOmfDIbi?=
 =?us-ascii?Q?9hbI8PnsFx6zhZL4yJ5sQsfE9jpOali6DVssSqkNTlD5XbiQGz9FzmmSIQQO?=
 =?us-ascii?Q?maj834PdYclGfv5gG8rZLFq9NubALK2YD1CrEJLqlprU//AZEr2SxmzNZ7nu?=
 =?us-ascii?Q?a/MDk74OYY4H559QGSItMWOZNoJsUUl2bLtSBe5OuK7++t/zD+9p0BZryYM2?=
 =?us-ascii?Q?J23qej37uLJOHQKaFstpgEpuXdWQ0KwArN3ZSQkGWgcEbq8cdB0o7G6LBd5v?=
 =?us-ascii?Q?pgV/sx3Fw4Abbco/ANi0Jnzk0nfPoKJuNDxVfBk//NrDlJF5NWUP57v5tlU6?=
 =?us-ascii?Q?NI3UpW5lSNn2TOhaoDM1M4mJbIh7Xx/BkG61Oz/4y9+w4kJajjpK8E3+VNDA?=
 =?us-ascii?Q?vQwDll4xQ6DcGQTQ11oc3wAy6MK2HBjuK9xh2hyPSSsb6WNEPAL8/tU8pj3B?=
 =?us-ascii?Q?j8URHJxfWe1UurvWOTTxQ7TWoNnFaZsOXEzq8ae2UQxrbKPvG5OeVVYI8ePT?=
 =?us-ascii?Q?43/h3OsG6YFbDShejGN+TBLlxL+2piXVJrVryzkzSe074f/Z0dUaSvWqr/e2?=
 =?us-ascii?Q?FyM5VSQVchuyKAscyrwnexO5R1xniufA8aP7XeSTvk4MrAwHmGGs/CXY0FgP?=
 =?us-ascii?Q?e1fSl7dnGouuEvIUw6b95CWVIX5fji3FPu+17i4JMjaQfLu28hHWYxDpUkT7?=
 =?us-ascii?Q?G5Fg1eQH3DlZSgiCYz7qb0LqBV0kzULZW6hWIk9/26KEfKPuFf53OF2NO4tF?=
 =?us-ascii?Q?XMq/yeID3+ijaQsR437ibnwCisdvsltWVhoo2rPV8ioFpnahgOAjfnUM87GH?=
 =?us-ascii?Q?N3vcNHopQ6nyAOkgITc+HN/2W7KclW0b09MhHTkiEyE+qt+eY2brnRjCqfsb?=
 =?us-ascii?Q?xq/hG1Rg6MJCpbeZ62DhcUPGb3cye2H5aa9iqA7quHxGbYR4cApMYYxB7v2y?=
 =?us-ascii?Q?oIaJEtiy21WjgEtnpQAr8nS66pBWXg54y9sUv89aiiKdy0FtuAZtLerx6Y7y?=
 =?us-ascii?Q?1AbZh/7LAoRMWYWtN75p9Q5M8ebydRjF/a3lkHu48FaKgLU0dE0FGCsOOBqT?=
 =?us-ascii?Q?ak0fSP5XFoVSddRvUhuhf4AL+FiyondxqBcEabmC87+88LXEh4S+u1WEp7w/?=
 =?us-ascii?Q?LkzRYGfM2BC4snZ1gyH2Gq/YfgVA5U52L07x76xryzv0Ahp3qAzm03lNEVwF?=
 =?us-ascii?Q?yh503cD8DdNdZL64kfzYo2elb2gU4Z8VBB/65WiMXZxPY9+Tk31CsusldGAg?=
 =?us-ascii?Q?1/yl8l16DbfPywqs+AUtpMBTGKgzDyaiKcLq7LgUrmiWsiJW+MNR88e9vEFF?=
 =?us-ascii?Q?ISHoLD7RUmaVXQ6Gi7E5mHhWU49of+rulaxRqtf9Pv+Tqk1Nq9H605dZSheV?=
 =?us-ascii?Q?moXIhl0B84IFTGFJrmWFUcGLwMb8agtIcEZWv9rB/cQGLhwLLEgBfuNMg9u6?=
 =?us-ascii?Q?/7nTIdAofkkZio8u2xiUyq3G1vwLZlszQNO+lJ3XnQDaZbpvbhoZMDg3caJS?=
 =?us-ascii?Q?muNdpuZh56OvsCajabMxxQPVLuL9o3z3yv1Dj7CUb30do2+MQqkt7KDZeTjd?=
 =?us-ascii?Q?sV5iEYeIOo7G3OCoCinXsOsaEwWYhobN408nxo6FWqp4WopobJk8sngATx7K?=
 =?us-ascii?Q?RNrUpw3QiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3a5fe6-d987-40d1-ea96-08df2442d38b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:15:55.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDLh0Efcwxm9s4ZJuhX95AucmlSwEb48UeM05xoOBn6V8UcKy7iz6MtW8ahP8n3c/w1/3zZz0XcKkKohFjawDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

Hi Tejun,

On Tue, Oct 06, 2026 at 10:28:34AM -1000, Tejun Heo wrote:
...
> On Sat, Oct 03, 2026 at 12:15:58AM +0200, Andrea Righi wrote:
> > -			if (p->scx.flags & SCX_TASK_IMMED) {
> > +			if ((p->scx.flags & SCX_TASK_IMMED) && !p->is_blocked) {
> >  				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
> >  				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> 
> Sorry, I steered this the wrong way. Exempting donors from IMMED entirely
> overrides what the scheduler asked for on that task. An IMMED donor
> preempted by a higher class now sits on this CPU's local DSQ until the CPU
> gets back to it, where IMMED would have returned it to BPF to be placed
> where it's picked and resolved right away. The donor and the owner it's
> donating to end up waiting exactly where IMMED says they shouldn't.
> 
> I think the condition we want is to keep an IMMED donor local only when
> it's about to be picked right away, which is the bookkeeping put from
> proxy_resched_idle(), and to treat it like any other IMMED task otherwise.
> That's what v1's proxy_put with PICK_PENDING did. Can we go back to that?

Ack, we can restore PICK_PENDING so an IMMED donor stays local only for the
bookkeeping put during proxy resolution. And a real preemption would return it
to BPF via ops.enqueue().

> The deferred scan then needs no blocked exemption: after the bookkeeping
> put, the donor is first and the rq is headed to idle, so the existing
> first && rq_is_open() test keeps it. The wakeup_preempt_scx() recheck
> isn't needed either, as a donor is never left where an unblocked IMMED
> task couldn't stay.

Agreed, we can remove the blocked-donor exemption from a deferred IMMED scan and
the extra wakeup recheck.

> 
> > +					if (p->scx.flags & SCX_TASK_IMMED)
> > +						enq_flags |= SCX_ENQ_IMMED;
> 
> Can you add a comment here? This reads as flag preservation, while the
> reason is that scx_caps_for_enq() maps IMMED to SCX_CAP_ENQ_IMMED, so a
> sub-sched holding only the base cap on the CPU can keep the donor local.

Ok.

> 
> > -		if (next && sched_class_above(&ext_sched_class, next->sched_class) &&
> > +		if (!p->is_blocked &&
> > +		    next && sched_class_above(&ext_sched_class, next->sched_class) &&
> >  		    scx_task_can_stay_on_cpu(rq, p)) {
> 
> I suggested this but I don't think donors should be excluded here. For a
> scheduler without ENQ_LAST this never fires for a donor: dispatch_one()
> keeps it through KEEP_LAST and refills its slice. A scheduler with
> ENQ_LAST needs the signal on a donor as on any other last task: the CPU is
> going idle with the task still queued and BPF has to trigger the
> follow-up. Can you drop the !p->is_blocked?

Ok, makes sense, a blocked donor should receive SCX_ENQ_LAST when its scheduler
needs to arrange the follow-up scheduling event.

> 
> The one put that changes is sched_proxy_block_task(), where
> proxy_reset_donor() puts the still-queued donor with the owner's
> execution context as @next. With a fair owner and a zeroed slice, that
> takes the LAST branch and the WARN fires for a scheduler without
> ENQ_LAST, on a legitimate path, so it needs handling along with the
> above. One idea, which may or may not work: proxy_needs_return() dequeues
> the donor before proxy_reset_donor() so that this put skips the QUEUED
> block. If sched_proxy_block_task() can do the same, dequeue_block_task()
> first, then the reset, then __block_task(), the put sees an unqueued task
> and the ops.enqueue() and ops.dequeue() pair the current order generates
> goes away too.

I think we can do this without modifying sched/core.c, sched_ext can set an
SCX_RQ_PROXY_BLOCKING flag around its calls to sched_proxy_block_task(). When
proxy_reset_donor() invokes put_prev_task_scx(), that flag tells sched_ext not
to reenqueue the donor and block_task() will dequeue it immediately afterward.
This should avoid the transient enqueue/dequeue pair and the false ENQ_LAST
warning.

This is separate from v1's SCX_RQ_PROXY_PICK_PENDING, which needs to be
re-introduced to distinguish the temporary proxy_resched_idle() put from a real
preemption of an IMMED donor. SCX_RQ_PROXY_BLOCKING, instead, identifies a donor
about to be blocked during a scheduler ownership change.

So we need to add two rq flags in this way, SCX_RQ_PROXY_PICK_PENDING and
SCX_RQ_PROXY_BLOCKING, but the whole logic stays in ext.c (with the flags
dfinition in sched.h). Does this approach makes sense to you?

Thanks,
-Andrea
