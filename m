Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE9490BFE
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508442; cv=fail; b=Nt33FWP2RafogeIG+H3nS1H1M6aAVhwWMg1qrglsK2O/65uRRYn0FZhcrfWoEXSfbkamHeLNTLVMipQSCNozhqRgMg2TivHz7NiVFkRNbqon33LNnHmJdrr438YhI3DsAHB27eyYBqydrQb8wsE4BvL771JZ9QB/6dZklrE8SDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508442; c=relaxed/simple;
	bh=qgLGJhuxLMw4wvvDVOjSXrEr8NeRhIk8/H23WZqnv5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HL19hYlwP2PcqmXiDu0LREOyegt6C9LPuNfHLQRtLeAHHVCHHi1Cm6BMWLaJdcBrSEU755+bRGy/phpdV1dRVgdBDFRc/CX3HnQSbqkj4dJE+AMPFn2NOhqkKzkpjh9lKtL9QsBlxw/7T1QVPeDp9H8ZNUM1jayQDn1hdex8KLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0unn3i3; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0unn3i3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLJ3ErtBc0q1QYkieAqE0Qn/M9CVEIlskn1mL7oxitxLvSKRAGZXhkbjEaj/E4QQckSZV1FxJsnDKvhCgJjL5DFkdSrDtLuhaTqC0GEo7vn/7qfj21boWFqgBN9VYwN+RUh/YMgh8hW26FyHnUvesv5vTj1Q0euOEMu6VgbTmqJ+7oX7RZixZIx9e1ArH9Wl82pRLCFMSlSquUFQ/MeNSfR+38qM2+FtUOHYH7vBURC0Ty+RngHIaXnSP6mTvwIcp74WgSUoRQTEFy/n4/QMRMiZhGVByRbsmEXwpskfeMnydXDGIyGBc/1/TN1f7CJ/Gq+FqIQnWAythYw1MK80aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJASmszuvAq2B+eQCaH/6PmIhFC+ljx7xTDSx+wnUUY=;
 b=cQgyJi0KFwYOJqWY7FNUMMuKwBgUTGGsNiVm4ueacscoGRmsqCK1A2iOPhHC5vo58E/ho78tZ2Uwt/TG5Mb4uiOjyWbrCnwpCY37vlpyW0Xz6uEV6/YWTMYRz7NSTxiyDll46A5g9hxGWrmIFsRM3KHpkRzVC2DGwaiJdam9YTny5v20ML2SZvBfnCk+uORofmNytDyy3NF54TJdA21G9SsdPdVORzQDEOqPs9h/hrzZdgUAtJ/kICHQt/y49DCyB/FwnPXu5k4XAji67yI2VjhkF8KIS4oT5xqA6Aqi/s5d4ieWnaxdzuE0EZoyRXavZ/kdMM1U4mZiq+xHibiN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJASmszuvAq2B+eQCaH/6PmIhFC+ljx7xTDSx+wnUUY=;
 b=a0unn3i3psoJ1X6JVVfxGywAvEoFQPPvk3r99GlM2eQPbB75gIaZDqbm+ME7CLfpGsOoEVy6s0mxzQ+j8mNTulT6g3sAmPyi0JTt5ISIwryfBcqfGi9010ehZgN5w3qVrnK32T0PzHRWqj+A1kqHkodGV0Wlwwue5HYj1tpw7xI+ytmdnhZMuI+sNrnBwHfumsxjTCzhzZ3Qes5EXRcH7kEnll7VI3vFF9IeZULnjfyNDJrX2K/dC9ci+Mr4JPlnH3SzLAhZwd4dWjj3+Lpq9xU9EHSUXmJCWSRZ90iGFDCd1lVschu1BbQS+GW5b/tw1bSKcVxPMwIxNzH4q4VOaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 21:40:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 21:40:33 +0000
Date: Tue, 15 Sep 2026 23:40:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/18] sched_ext: Block proxy donors across scheduler
 transitions
Message-ID: <aqm7Rpp_xyWER5Y2@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-10-arighi@nvidia.com>
 <20260910105335.GJ4120091@noisy.programming.kicks-ass.net>
 <20260910114158.GS788244@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910114158.GS788244@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a745cb-1604-4cce-2a21-08df1371f872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JQV+4/Hg0sgeRhbLhiHDUC71eyocjjTZ6dW3SgarhHKJgfOZiw2s1hWc6hbCgBI8iFyIuXEAYCymh627KPHntvCWV4EpOkbIRjXBuyjmTT30hUUrqbtgrWPNUXrU+rMWqnc08xPbe6tAskiSjmUPqGZe5dN3WWSVT6oOLQ8OoWFFWVqhB4TdilfFWmfXgN6bUIuZIW/RcSyl5gVvpt1OT8XOAzgDvTcJKr8bXwDkXNZVN/f6leEmywHfLIja1fSGyBM4t8IMdthhK+RpNrEABxJmj2UpauGBJJJ0NFPkJefQLJmjd55Zk3vK2MYzQaTT3dJ6I5oEEWeTZGRtwNJnKP6u7BIyjWqy/H3TPsqXTKCAMwNsVIZDXRPwyv4r8LESeatljB27aJf3MQ77q1sVVgId0DZvJ/AXAVcwkvUP4abv/nfShEnbwpzVJOYGvB0BkCyhDS4iCAsQ02pEGhyTUxmEVAqKh/adW+c9g+6N4/5jYg9ld28ONgxztGqjOzdMtWrQ3FoMhcLKUoeu/yvrM3lsWeaOrUYyuQhKOGeqm9Dlljx7PQsmWl7G236Ngy/FKcS03pXTgxvqXH6u25GNihMpGKXxBNfu8hwxXjt3rfN3+g9PIspiTvjJV3Z3zaGQ8+tezfA1Ub6fSzXu0CfzG8bnVx/WFIGbnolBeWsaeNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ibfoo/m64y3ITuRnz6MqFyi1ZV6qIDMEPYmltDXFAd7WdmR7kePmV7W+diqp?=
 =?us-ascii?Q?eCoWX0c60+aG1UzzJlFS6TW73RdC9f1rLGbEdCnyihvHDDkBqbL+qE8KxMWS?=
 =?us-ascii?Q?vW/H+D0sqk5iR13Xb7kHGr3CM8UfjOGokFPC+Pq7C2FF/iJAi1r8j0Dre64q?=
 =?us-ascii?Q?n5kzICNVdf0nUwq9n5C4gKye3IrIFxHSOAHN0A9dVZLOnyebDHc70sHOzcQF?=
 =?us-ascii?Q?pp1jrjNgY2trH5nbBx/FD/AD7jlXobhvRyA1jT1S+OM1G9doqkQNFrU0GTvg?=
 =?us-ascii?Q?M2xEGVhkyOld+1WJN9JJtU+76aFLmCUXwUtSpRh7epNR5awl4K9ZVIFDT0sh?=
 =?us-ascii?Q?4erR85pz+KXsFJX71GRuD2J/hV1ymWooQWaz8uPPGzgLcRos3XIMPZdtjrI+?=
 =?us-ascii?Q?HypViWmCMM87Qg026YsRz20IR1hjhGOeMlgUa3IBZ56ZjpCTjc2UKL2fDHXh?=
 =?us-ascii?Q?UBiQf7o6twC8aGJhWQpmL2O7BAd6NgQuh7PZRqm8G3b9mgXt2v01WY114hgV?=
 =?us-ascii?Q?BOwvc9pwwawwyvpUkEJjVqAEsXgemdMyDq4M4dNcRfx3m9UkMHiauSz3yNLz?=
 =?us-ascii?Q?TFdHPoWbdXiiAD0md2QF25KFaQKBOCs9hoYnF5uukFqD5DbDUZs36CIVrPip?=
 =?us-ascii?Q?TI4laS2tbgOlIpUWnL4wCxfjvltLYCMYOzEG6WuCigRgPdSfOe3hKqFUp77X?=
 =?us-ascii?Q?0hP7s4bNMPXoyV5XQHJuvEUuQDazf67MHIfitmZVtQhJdVs/tfD+A498kkQt?=
 =?us-ascii?Q?FHSQmZdE41QBRsSag5IwavAGLTSA52NY9jHOGT20EMVM5HPSYkSvKCeu6rmT?=
 =?us-ascii?Q?Ja/Xt+yb+89Mp1/dgXUQa0TA5rqndslrYegxkHCZ32nmoBlbdJPWALzdfGM1?=
 =?us-ascii?Q?9mgage8XyPMO95VUjkubT3nb0X+7tKBF/tk+QLWHDrDfBxOEK6B3rTQSDkBQ?=
 =?us-ascii?Q?yM/Zmw1/MmknYZ0Xn9MBZiPTmP3xDHUL6uu+FViLN6mosZXy00fMl+Ao/9md?=
 =?us-ascii?Q?VL1vwZ/mjbFcUShnr3k6ne6Dd0fPSMsu5FhbnwPMfM8DVzhlZqtu9rWfoge/?=
 =?us-ascii?Q?Q9uAhNMfQRrigLxxW6KesqMY/5jbtyH8okHih+3djoJnGJ2udapReyP0oLmX?=
 =?us-ascii?Q?jPInjTB5olq1lK63QcF2LpnBApfSe6aPlJMXIck9eWGvrIy2W/VM8vJxAaB6?=
 =?us-ascii?Q?6QnivFbtuTg+l1Z9B65pIVaTwojxuWzbBy3PF/3mTS5CX1SGVhQd6PX1fiEb?=
 =?us-ascii?Q?Re1HLK5fpaU4ca3yPzeCM3FlIn4GapNaKdWbcge6D+9XEwikZ6fPiqlLaJDY?=
 =?us-ascii?Q?ZgZLNgXulxqzosRXBqOF3ivVX8/Q/XXPdxaqcPA2tzbgH+N9eWR4XJYQxljy?=
 =?us-ascii?Q?FxiNwlXzWzzIjHgYyhPtzFg6lnnsc0BkQtmPKfV1znU9ogfe331FC4COxw/S?=
 =?us-ascii?Q?seHLrfhmzPK7XQNTHakDhO8ff6rDMyGkWALTjYGa+HTWPq5rkEIEI64v7vsw?=
 =?us-ascii?Q?FJn0pCXCe06HmhMfDWrrBGiAq5p/hUdhzlEkhVYulLztWHEt45ncNB16ERV9?=
 =?us-ascii?Q?eHWWm+uKuxROB4aJHBrfz73PpwtN6+8fke19FXT/bQH/9cr+HDspH4Y+5KZn?=
 =?us-ascii?Q?82hltFSBis6z2keSSUFazPLAq2xpUy7z4nNRAsp5uBiun9mPiPBiDFLmzB/t?=
 =?us-ascii?Q?sqHRRGuawS9PsQhPhHr4e+5KGbmjfRommBtKdRdDcjHS2OjOnMzvJKD1Swai?=
 =?us-ascii?Q?WsmbpR7BZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a745cb-1604-4cce-2a21-08df1371f872
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:40:33.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poFRMqUafgl+eIlU+xwxSzw53vkeHOTvh3VZ8HIG8jvsThW3CQIxfQI+q3v1LUeg+lZ10HIavpCSlBCu/4gydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

On Thu, Sep 10, 2026 at 01:41:58PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 10, 2026 at 12:53:35PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 31, 2026 at 03:42:19PM +0200, Andrea Righi wrote:
> 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f142ab455b797..4bd956182af8d 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -11302,6 +11302,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
> > >  		flags |= DEQUEUE_NOCLOCK;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Don't carry retained proxy state across scheduling class changes.
> > > +	 * Compatible RT/DL PI transitions could preserve the session so that a
> > > +	 * boosted donor continues proxy-executing its lock owner. Defining which
> > > +	 * class transitions can safely retain that state is left for future work.
> > > +	 */
> > > +	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
> > 
> > That's a tautology, having DEQUEUE_CLASS means next_class !=
> > ->sched_class.
> > 
> > > +		sched_proxy_block_task(rq, p);
> > > +
> > >  	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
> > >  		p->sched_class->switching_from(rq, p);
> > >  
> 
> > Hmmmm... I don't like this. I was expecting this
> > sched_proxy_block_task() thing to be called in the big switcheroo
> > function when loading one of these ext thing. (scx_root_enable_ or
> > somesuch).

Agreed. The cleanup is required when sched_ext takes ownership of a task, not
for every scheduling-class transition.

Calling it from sched_change_begin() also breaks proxy exec across FAIR/RT/DL
transitions. I'll move it into the sched_ext enable and task-ownership
transition paths and test that approach.

> > 
> > We most certainly don't want to do this on every sched class change. It
> > isn't even gated by scx_allow_proxy_exec().
> 
> Why not do:
> 
> switching_to_scx():
> 
> +	if (!scx_allow_proxy_exec(p))
> +		sched_proxy_block_task(rq, p);

The scx_allow_proxy_exec() gate makes sense, but switching_to_scx() is called
from sched_change_end(). At that point, sched_change_begin() has already saved
ctx->queued = true for the retained donor and removed it from the old class.

Calling sched_proxy_block_task() there is too late: sched_change_end() would
still see the saved ctx->queued value and enqueue the blocked task in to EXT.
Also, p->sched_class already points to EXT even though the task has not yet been
enqueued there, while sched_proxy_block_task() dequeues through the current
class.

I think the cleanup needs to happen in the sched_ext ownership-transition path
immediately before sched_change_begin(). In this way ctx->queued is recorded as
false and the task is not restored into EXT.

I'll rework it along these lines and test the sched_ext enable /
ownership-transition paths.

Thanks,
-Andrea
