Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BD37F739;
	Tue, 15 Sep 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502992; cv=fail; b=bkKWFsUuM8Qrc0dX3eGwQcXpD6ek6CA2A1cxqd1lXc0n8ZpO3YqziPLX3D7YsYUtsovyShtZ3OOwB9lMEbW8f8yNhhqZ7w/ax/A5pGtrdnPvlDN1qP6Zw44bdjgkNz8Nfo9nPd8pn2/3ZNgd9DXyrvRj1GtTTfjUv1c2WrnjREQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502992; c=relaxed/simple;
	bh=i3EDb4NwTs+Y96yeRSDXbPn98MN8gxVOepW/IEg4Uz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AeZK9H2UfhMFZOz/zuGQHgkECb7qmX9LKl++G7b6JsJTCxa6FNWJf/cURimJAIhoWUyx6dR9kM1DI8q0w+3vE84GzxyqgXKuDJt6kAP79Dlu1OWzIj/zKBmptNdOs67cdBA8P4vf/wVSRlc8vpxEdRlvwBr7EkmjS/idHIuavyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+BtL8Vd reason="signature verification failed"; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+BtL8Vd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUyol58P7gncVZ4oBddGJYcrCD0YzBwIUUe+CGBCPiB4M5kYLab2Zi16Z0R+0Jg2GknKjk1XrGOTtq/M3U6/jWaZAv54QfCMv0oC1BkhJ47JNBxa0sx3O2GfuNCJNzaJBa2W0kcs/YnlJvr2u/4gQgSJ0F6NMUqkUQ/JlO+CSUh7DEwu8D5UgIUoMcMN+R58rpnqdkkTJ3WTl6tThF8OHngLplgYUlOjCRfKJ9wprYaYGZMwiLPG+T2S/tbPSZdEa4AlBSmaCIbergaKzZxUYe6zQBAkV6GAW7E7N0wgsX5NAKV0ann7eyJ5c6+yFbi/gQeY+cfOtJEOq0E9K3WFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juUdnhWVq6hRpv6C0B60ZfcjjSwLnRgGwf9+TBjnkzE=;
 b=aOKM+GQTRcQFlQHtO3IuV8hsna5UiJUUZ+xMe1VqU/VW3qGEE5mOS42X80AUJFz7FsDFZXraEn+HShK7Vh3EhEcNFya13oI8AVDSEb6q7InyOvQ9/ItX1+6dUJ2TnLlgbpB0JRJDzt1sGbEyd71EkzBTK18i7XG65KpSYwFkX5M8wMtfiO7UQsfgGswSdscr923wZAXsyfS5sEJwbZzgTjwr9Oec+tSPB2Y/CRpcR74HlWC2HuE3QD9ADIrP2lXhPmgAi7TyoTjf8CG+ufyTQC5lxcoVx6jrdDVksrjA6Cs22OMKLnJNxQQ+K2wjJjV7fv872w09InrJbHQ05hn1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juUdnhWVq6hRpv6C0B60ZfcjjSwLnRgGwf9+TBjnkzE=;
 b=G+BtL8VdvyrilVZAYZ1zvtTBn6F+P8LgIlooHH3jK4HsbCiGudyAiITNl4L/rejAxq2N5F4b1yiYUlMJeKQ7U4lwWeQSZ5rOX8kwiquPFxoQpNMu28shvOpN0rmaF7N8hEO2GA3xBUpv2fuXinK6xJPXbdqFDTGbxsW1BETAS+Uaic9hkiJHcJS3eSF0MQypPixHQAyN66JEQ6VQGivEEsWPUdNpk+LOEg/lz+ZbN4VlLImZcg2mwRb2pMqNpTX1Qj6snJsxnoSyilgSBPrRZdbs+GtV6jwRjtmPUaww3g68mCDlJGEf4O1LZj36Jij2tPAimSt3kQrv6MGZgbCJ3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 20:09:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:09:43 +0000
Date: Tue, 15 Sep 2026 22:09:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Message-ID: <aqml_lz1qnLWc6q3@gpd4>
References: <20260915194611.2674127-1-arighi@nvidia.com>
 <20260915194611.2674127-2-arighi@nvidia.com>
 <20260915195752.80F431F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915195752.80F431F000FF@smtp.kernel.org>
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: fe217afd-2a11-49d4-1bb0-08df13654862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EWiJtWsjs6wMBrg+R438s1tug2o21pSfOqFafn2iAzZk1c7YG7TrMZTDRf/yrcSds4SO78C3hs38oBL5zCXiiUBfGQdumbSywLD5+FoUz/aVg6I4FkBHoqludo/nGxj9/xYr62Ps9Rr20CkPx+I2FEFkTo8dN3YjegwBwtNAtMcKN2V3Lj3tQznvTB3x2xDn3Py2zdEJYfuIWWHz29YR8/qTWX0ltySGOMunknmEmnSUOU0CJCUmVABsb3pAmyjWw/ARcHmFJ1SsVEFzVJsOx+NJ++Hes7xXBJIxTjYV7/wpIhzLT+9u1a3xgsL2ToriUcnAGIioYN7ZylT5j1wa5bYU7+w89dGVvAHjMrLCYXHoyKzYNxeE4ZFvzxjbSpR+9zlqoqAXD9kJLDpdyx7TzWIr8wBWOH3UmzHEbTiO9Rd6L8o4ZK/3qZfNXB/6zKeIiRxLk5s6ZYy/c1ZF3IQsIVuDNyShDECMV7GlaDL1oELHf/8mQumoE+KczkQ0GKp4hKWSBBVg6ERD5nbxLxA5zBtElVC/ufRz0xVftREj5ZJKrbv3GXw1PYg94pNxcIlpsm0GHNHpx34A4U1FmP6he6nkQTxh26+CDM6NUiG9gTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zLI3EWjFsEe81S2b4bpABdOsIj4bJ03rngPh3YQTOK+jjrEPZ2CXMpw2J+?=
 =?iso-8859-1?Q?pU6vGADhz1VznpchGQgCD4HDzHth/djTijKNrCX4LRdZpCvAperwc9Wlnd?=
 =?iso-8859-1?Q?TTqQ9oehX7ueIE62jtKBHmA/ul6YFJvhxXOgaXtnZzD9YhLLFB8czytb49?=
 =?iso-8859-1?Q?rX3VaHJ5HKe52kbOTlru5zqihXwnMPdgFyLB+16M81OYwsy+EGRYm1Ov94?=
 =?iso-8859-1?Q?cl6J5KG10vGyTIxvAcGqVyBq0YEdMcFs3NZMj994hRCj0oLXrVZcGFrkKG?=
 =?iso-8859-1?Q?/LJMRaIhBHEhzCQHhkjeuSw+ulru7rMqj2ev0PX4yTtSiJxGxQzlOPtCtf?=
 =?iso-8859-1?Q?wia3zmhoo4SOhhIUTTA1WR5OcHLlnIvY71q6Nqr8Jnp/Szv96Gb/xHTp+H?=
 =?iso-8859-1?Q?n6rfrl9pIjK/CRc2kweq7tN+5S6Pnb0vU3owvD5VWVpejRHX0jgJtroGKc?=
 =?iso-8859-1?Q?LlKTB2d3BTOQyAwrA6Atvd78x8JeBZtkCwl0Dbe9VowslAyFIGFEBt4b1D?=
 =?iso-8859-1?Q?nvz7vT9fLOEWvJed9/xuq+D/aeEDI537eVNyqiFHMiW9ylqa2phvDJBv/c?=
 =?iso-8859-1?Q?ODQKT4KqbWBCzvhCDUCABEXZcFKMR7yOoYkkmG95SZPizISAiLAIcPsfGo?=
 =?iso-8859-1?Q?XRrcmg1NVt+dR4oM+LykxqjvFwXptXoyIAxhvUfNrZqwdmLM8RnThUtHR1?=
 =?iso-8859-1?Q?x0/XIggn+oSV/HokYWaIEYfVx5f7X+E+44k65wfMJIpx13EAVPywmD5q7B?=
 =?iso-8859-1?Q?fjJySVT2Odp/Kpt80Ldguwd7Q8XnQRk+Q/IU4pJa0xRXd0+v7n4K3imtTo?=
 =?iso-8859-1?Q?dK8tib4p2YgVrtniiAZBsvglsf2wZCX1mvyfiP54ksgheFkYB3W+qjB873?=
 =?iso-8859-1?Q?8W3FSeNulcXjjsJwUyxqfQcudm5gfvU8wqJmQij3UL+66jyUFb6j7Z6qmJ?=
 =?iso-8859-1?Q?BSmlISIGGm5cgqcE4Q6VQS3xSuFe5/dqj72mjyjUPvpF3xmNpXzToFMDGt?=
 =?iso-8859-1?Q?YmUV7m4a/HUHXaqv62358cLdRm1QngsgR6UMrVFCauloRNJqU5nvM5Ou9v?=
 =?iso-8859-1?Q?uOfU9gblrTLC3ExHaA+m1tM9aQcprzwFrnRwhZVI8vjg+u4+URwK4m9cLl?=
 =?iso-8859-1?Q?9/qAWoAedcNA2kHOdPdQY3hiXNNucpYuvx2D1h5C3x/pB4HpKncDajsKxZ?=
 =?iso-8859-1?Q?XnlsyQyOm3N+Pige9Ei2ZyQsI6OibnZPO85RXbcmW4znjqLVV4+m6VvVHy?=
 =?iso-8859-1?Q?ItGsACpu4s0kVTlg8FbQca9SoRjwlO7k594P60V/3cbvwzs4TM0eFWxAcH?=
 =?iso-8859-1?Q?R5OT20n54ssJ+Etfl400BhVeQ5E7SzQhgtH7GaX2F6X7dUaSTRjehzc74o?=
 =?iso-8859-1?Q?bqGV7TQ6eGg7b3i/vavF6K4SXdDW0ADbrrzQoHFmSHjNH+AQSrU9Yp8G+H?=
 =?iso-8859-1?Q?vP8bNurosbCHnUzB+k6M7KnXdHuMu8DNiQNtLLYhfGpm1IRyLIoUT79cdp?=
 =?iso-8859-1?Q?b6WZ1yvo7VlB1hVVhgHDC2hAHHG1doVYPFWcDQNmCXTUim76oP+cKFizor?=
 =?iso-8859-1?Q?qEYvIo8QJYZWKdtWsVmJFj38dEU24TamVbhsYpuUKVi5YHvdWdOvWJUjh+?=
 =?iso-8859-1?Q?xb7abxebgL14SxP0HTynNbuDFfWAlD4NyKLGYZJsFdN+/Q8aPKTg85YsXr?=
 =?iso-8859-1?Q?Lq47dBhYTxpueHaLn9Fq7hrSPtTUIUR1x6ljqrxc0P7S6ngnbLl7wwbr85?=
 =?iso-8859-1?Q?HghvEKwSLpzR89mCoAPI9gKpFhioMeSBr+WktUa2SWUB0khUpRTUwPCmP7?=
 =?iso-8859-1?Q?esViWBxMAA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe217afd-2a11-49d4-1bb0-08df13654862
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:09:43.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3JI8CPQpMlWB2NR+u4Ly7f+wzGlDP7sh1TrT9FBGkPegp37Df7B0e9UICOQtQ4nnTg0+dm4Q9sIaIhigTuYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

On Tue, Sep 15, 2026 at 07:57:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] sched_ext: redundant idle kick processing for lazy preemptions
> --
> 
> commit 42fa214a424ea8999256e25137769c2bfce81537
> Author: Andrea Righi <arighi@nvidia.com>
> sched_ext: Add lazy preemption support
> 
> This commit adds lazy preemption support to sched_ext, allowing BPF
> schedulers to request deferred rescheduling. It introduces new enqueue and
> kick flags for lazy preemption, and updates the task slice expiry logic.
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index f875c50f00bbe..819995667cc26 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> [ ... ]
> > @@ -8574,6 +8626,14 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
> >  			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
> >  		}
> >  
> > +		/*
> > +		 * kick_one_cpu() clears the lazy bit of every cpu it visited
> > +		 * above; visit the remaining requests which contain lazy
> > +		 * preemption, see scx_kick_cpu().
> > +		 */
> > +		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
> > +			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
> > +
> 
> [Severity: Low]
> Does this loop in kick_cpus_irq_workfn() intentionally skip clearing
> cpus_to_kick_if_idle for the CPUs it processes?
> 
> If a BPF scheduler issues both an idle kick and a lazy preemption kick on
> the same target within a narrow window, but without a non-lazy kick, the
> target CPU is serviced by this loop. 
> 
> Because this loop fails to clear cpus_to_kick_if_idle for the visited CPU,
> the subsequent idle loop immediately below it will redundantly lock and
> evaluate the same CPU again. 
> 
> Could this cause a minor performance inefficiency due to the redundant
> evaluation, and should cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle)
> be added here as well?

This looks like a false positive. SCX_KICK_IDLE and SCX_KICK_PREEMPT_LAZY may
accumulate from separate calls. Processing the lazy request does not always
satisfy the idle request: if the CPU is in SCX_RQ_IN_DISPATCH, the subsequent
idle pass intentionally upgrades it to an immediate reschedule. Unconditionally
clearing cpus_to_kick_if_idle in the lazy loop could lose that request.

-Andrea

> 
> >  		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
> >  			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
> >  			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915194611.2674127-1-arighi@nvidia.com?part=1
