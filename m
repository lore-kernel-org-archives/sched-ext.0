Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FACA6F
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671723; cv=fail; b=pQTvM941TQetesIduSYjbx2HEcmD6r5zprAijnfntRExLIddmZeRVbdE89jL7SPpYqGAPD5Frs+CWAGzjw4a4fqx9sqmvMt0wbBRyO9zt6gVnQylKwYlbDl1U9XHA2TrarMnM305A9qGaIGKc8vTLI5AGxntKtxZw4I3d1q07rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671723; c=relaxed/simple;
	bh=ZSROljsQ2S8VXF6v6NxMtPrjk6hMT6pYxuGiBVf/xmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uaBDsn95CDjgwbH69eS9fuRU2m0YthK/PYD8W8XQu1XpcRbal7GgcmF0XfH6fTBA1X0XVjahGR5cPSKm4SFTH8yk/Ra19xhKKtGsqVqUy2JhibJowY/qmhRaXtAGjtJzVEfTLxoR0IhyLna1e99XRog6Q5DpK2Bze5X5jfPVD/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abUNgvwl; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abUNgvwl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha+uqgSLBIG7iqT0mJb7m3NWqOUoqXm57g9HCVDB3t0ppF0SqWBqlrj5ehTxGWsGMxurRPzRBGn4KlnPxZbS1Qf7vZWOn7Tpdegf5F17Gy8qpyq1Z0omMM0GMjfR1PcyBsrAfavFeZ93DTUF/WDS8d51K+9PsXpeJ/DvXkFFzS9ot6XWd6oXf74UvrMDjgE8J6cThnjGT3v1sLgZTUCvl0Cd6/UY1Qnmf/bABRG46OOJtFKBeVK0ym4UTsfPs+1XesMDzyf0xqk0EdTB8HenD+xpeaovwXUhquPygd+ycAkB+JdOD0BuP9oyjcz7KB3e3yDMMwKicbMIdy10tCvfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMh6rWgVK5FV1T2V+sINrt9sCZCY3fqllmLb37R46G0=;
 b=DbwkoKm7lhxPBBwVbn+lo6OsYiQCVGcuiVxbjcnFr6GDuLxQEUW+LlEVBtiEJ3mEm+mOP44rJLsFCHilSLBOcxlAI8chJc6nUwpPgw2dBJXF6+RpHmsWHPk70vFeKi1zWNhym7Wr6lDGUaDOcTA+CJkGFIbedrTAun/uQnqIAWnao4JZrY6r/+UVkI8A9VL+isCNB6IV9Nc7J/88yBfGtQQag10yFbtqNXfadTbT2DOu7vLaJJ1uEucJ6gBf4GFniefMyLjZL7OtKb1t0dbEyMLeBu+Pf9EntAb0yrugv2YDsYZ+F19kjAnbY7oWxV4yiD4uwh0KEQrdBMuvHTu5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMh6rWgVK5FV1T2V+sINrt9sCZCY3fqllmLb37R46G0=;
 b=abUNgvwlUYVy8sAOiOTSv7Ot/dGokrpPCwAFrnZF5Qyq8ZBRTTsaqGXL5NPWQFcxMDiTQ/K3n8AAmAxQ7po+fZWXZgvDKv+Hixt1+qQwUryMAREHpswssjzzKoePiiig045fYGb0H82sDbMZs8Na34JVNxOOP6fzyYAZmCG/V8GR4Nj4xQ8XiF0Bx+mL8WhVtf8pPBF5SAM87VOuXZPpv5zeSuveY2yYH+oQeDvIeEdk/DVxsE8BnCOZHJcAGtNGOjng/29b7naW2JmTMxo562vPoyxuOiV1Boif/cS5zUdqon72EUv1jLDh18A9hiEphxKsdCShfjHiYpZ2StDQiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 13:15:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 13:15:19 +0000
Date: Wed, 16 Jul 2025 15:15:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <aHel4LvT_Y5gpYfy@gpd4>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716125128.GX905792@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfea33b-28f6-4412-875d-08ddc46ad05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrUC48mHLPJvmz1OLBoP/4c7pneDaPXj6uU+rAKGWXW4fY5/jgeMXFIvqhNF?=
 =?us-ascii?Q?lKxplgZ+krqQ5114HU3TAJGr1ghXJ2pF+GlIYqI4l0qR4LEbmY/kpPOZ8f39?=
 =?us-ascii?Q?5CAgjxDgBq7QysptLapjL9IsKmdnlXLG8kQB9jBpSaD2mXlPb0xjTT8UilkU?=
 =?us-ascii?Q?c8fPO9vIcH+5HGW+ZS5qxffZ7iR63AeERWS0hWsCmvfm11QqdzLRePKWJ0lL?=
 =?us-ascii?Q?IX5pvJKnS5VKsLu+NDIYNxTqKGcYnhkYnUKjYqGRYSkf7NUYVcUSVnwqb+oO?=
 =?us-ascii?Q?JCuhFdM0gE6X21jYM0YZXskX6EqBQzV8V0qmZSRWqDZIcvz6gQG6ijclmBom?=
 =?us-ascii?Q?/wfafNqLQ7QI5T6/UrFNoccj4ecVuRV+Orvizp5ws22HJBnOT3DKjCxz8Ber?=
 =?us-ascii?Q?GqNegZAl9LC7vCWgdT0QEbT2iCcvOzyFT8sjntNIbnOVlRRtk51qHfh8slKc?=
 =?us-ascii?Q?DCVaFUflRusNH/sydd8YwcomdYRqU0OYlws7fi6tLK0FtuW4mTVtK10+xc+g?=
 =?us-ascii?Q?3IsZfsJm0e6uRI6jI0L64K5y5nqKXoovddGfxYMn336pKKicSgDiIfe96I1b?=
 =?us-ascii?Q?oUhtYJhpFoK1ZcZh8GEtGVwwbfssNWmWQ+PlHLqwduvdqhJcz4A5P+H1lt2r?=
 =?us-ascii?Q?q+r5CFMNAF1cZ7VFW1dy/jxhG2wpI1yRFxolOGsXTGjbHGstXoCsRaDmEfEa?=
 =?us-ascii?Q?ZjIGK/Vf2LHuBXHDIN5Fvzftnt2BXV2UNrwgo3/0S1+8m+o+Ih7RYO87e+CC?=
 =?us-ascii?Q?nR8VYrGR3U0YJjgypJBkz63EZFJ+WIbMKV6W718OyEqTkbyD63bi61TQg8lT?=
 =?us-ascii?Q?GRMilyiiImV27NpGqNHfUfx3MEcIcwM1PM0eAO7gDcQiaPAKuo0hyzFWNuJl?=
 =?us-ascii?Q?Fm67FeTrzn0hG/eRjircCcijPMy3Io8MrtZPoooV+uauXlX4O9uM65Fc1BfL?=
 =?us-ascii?Q?yWQFFCEZz86DUBCB7fXO9922VsZGg7EkAQHzioR4vQbMIKjJChRF8pKMA1yx?=
 =?us-ascii?Q?n8gEmSZO1H+G6Od8t7h6GfSWZrisDANpPeE0gSwCnslj16GEVBsWUM5vAy1I?=
 =?us-ascii?Q?/w9Di/J1mW7yyYiv+6kwcy/kuOqeUwaYH3y3+FIIlS2GBIQ0PFthzMmNWlSG?=
 =?us-ascii?Q?IVziKkl/kGr9MgWYZyumxKM2yY9AS5p/z39Ew4xuEqRn7P19OphEichD5xpv?=
 =?us-ascii?Q?RirBAOPNtHmkItSiEaBY0nYQAzeW1KI5Kwhd1MPzTDqkizXor18ShD1pBi2C?=
 =?us-ascii?Q?62cp8+1LB7Try0BKsDAkuMoqd/sfLEyXvqQuCRrZhAkRhR+YU6Kb1p3rG0G9?=
 =?us-ascii?Q?RMrAlOld6jRwQ5Dctu4ZL3iaiXqEnRWIJpproCreP6lJMWa2gbOf8xW08RWs?=
 =?us-ascii?Q?6pDvkrjWLX7JEbJrBHsBrWYTfc30sET7ohyV4nBweV5I14BTZBpY+4cFcfX/?=
 =?us-ascii?Q?7oFF4cKgkCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pq0JARsgpBcawwU+JSCpWeLD4cLmEvWL6Q4170hiMHamoE3WpYdfYI03Y4BE?=
 =?us-ascii?Q?Y5GKlP1xRVNXscPIA8bHKzWNbNNGIlyn8dLsAe5tEpn8b8WxeWjyAowadoLb?=
 =?us-ascii?Q?Rn1x9hY3H/eT/w51Ll7LepUuNcnwkCRw1dzfZmWtkOacVbqs8Vy4MTLg4dFq?=
 =?us-ascii?Q?4WRaVXhtxap+4rGvx7CLPlBDEBMJ1WMf7yKSIzs4O2o/TQq45jhHJgdSIiV7?=
 =?us-ascii?Q?8lMABL1LX7G/Jt9BRwts+F28O32fmBUeKW2gbEFB/7IuByuQRXiB08bBQhwh?=
 =?us-ascii?Q?Fy3p/JJ++tjeyMiJcrmEoOha7p0ELN0IWS1F+p/PPTbD7nljRX8zUeRghXk6?=
 =?us-ascii?Q?akI2whFHnZ2iU4ksdSyjxqXWNa7rv1Y00I6nuQru7ljtzy9dI+mbVTjOnCUd?=
 =?us-ascii?Q?QqLUCkuukf9mx1W/TGtgkeD7pBz1jFlhJcdDp9kattHVI8yOweyVovFw6GYT?=
 =?us-ascii?Q?ZSgHNjt7xDf6j7uXjZ7p2NURx1THHPpxCzb4D1TFh0jfrRraOzWqKqbS2NSe?=
 =?us-ascii?Q?F3i2tDWRFYt32lNM/sBy5+4H3CtAuCpczg+R1tbXXDF127R7ffHjQ5GRP8g1?=
 =?us-ascii?Q?3F530yaTVwp0rU6oYUkdW6H1Xg+FYTT85mOqAN7pxEohsQeA5w+/FIroYACY?=
 =?us-ascii?Q?3qpLq5XzSGklSjYFiXyNPO0ggdWhiKSUdEDlZpmngV4Bv+zR60Fth6DydwQD?=
 =?us-ascii?Q?LfRQ08WDeX1A68q2yVMeMAugeUiAVhvVx8ZD6m8FQQ2VWj1bTlK5SJGBXHD6?=
 =?us-ascii?Q?LDO8uK77WTHTW9Mx387aeTlxny0esauQCDqTOTXlnGDn4BsY/ezL05G395n9?=
 =?us-ascii?Q?NkdydWSEJTEdkH9ud5uMLbDLKz0Qm65iaZWUyJW8AAnc+BKYvovT21in73cR?=
 =?us-ascii?Q?qm2+l1oZQAEQFdpb8LX0/WtZPpPkibrRI4Wpcq0dWNmXpzkUZ1d8rDtP8Gvg?=
 =?us-ascii?Q?3jOuAM6Fm/s+CzUvF5jhX2gJ26AbO+nsU6y4sX8S7VdIyQszGx+Pughu6aeg?=
 =?us-ascii?Q?HZeQRhfuNnV5NkT/6CBf9gbFixj96K24j9DFeh1NuZTVSEPuH106S0FVHN8r?=
 =?us-ascii?Q?9kqROAS1bbwJscQJTSrKGLUMkwYh2nSJt707nooHDdqDWtNtAeOBay6Hr9Tg?=
 =?us-ascii?Q?vngO4JghwZGYk7aaO2noebxOGJaZaSJHWKQm03DkSY+ZSOx8sL2qzL7QdO4b?=
 =?us-ascii?Q?ZJ9z9iyJMq6aOJgQlYFvpA46aJQLkSbdm8KtAeFq1jCvMmZtM3lGYv506+nB?=
 =?us-ascii?Q?Lt//T9vk0tmfUOpqTk0zwyg7vCMIFGVpJhFhv3W4wxYp2RWWUJ/scyMUhhyU?=
 =?us-ascii?Q?9emgwHFaHfNqOzvLxnxQMjgWolFqOxKZ6BnqVjOOTBMIJtRxMMghtch6nliN?=
 =?us-ascii?Q?Om/rFb2skIGbN9j/BFKQqq5B8d1zDUgk+f70QZXhVhJE0+r4GwLdDZ89ZVIu?=
 =?us-ascii?Q?kenAF/GVlYgEvIUYOLgRFW6e5pgU/EfxNLuTUA+tz0lM82MFlmc8XDIUpbKl?=
 =?us-ascii?Q?8zrkX3xbtfG7ofe+96z13mHlCVYu5iZub0xtQRSoBuqqnfhXxIkAQkMYasvj?=
 =?us-ascii?Q?vPxboPz7xwEz9d7T7pvDsjBQSY8mk4+z/XAPdKdX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfea33b-28f6-4412-875d-08ddc46ad05c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:15:19.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QJOzAW27Dro70sG+PxeDT1SCyICRyTiA1Q80IDDFJ1v2SYhC+Q0/8exp85nkplpmYCs7qchMk9tyS3Vwp1qXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

On Wed, Jul 16, 2025 at 02:51:28PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 05:46:15AM -0700, Breno Leitao wrote:
> > __this_cpu_write() emits a warning if used with preemption enabled.
> > 
> > Function update_locked_rq() might be called with preemption enabled,
> > which causes the following warning:
> > 
> > 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> > 
> > Disable preemption around the __this_cpu_write() call in
> > update_locked_rq() to suppress the warning, without affecting behavior.
> > 
> > If preemption triggers a  jump to another CPU during the callback it's
> > fine, since we would track the rq state on the other CPU with its own
> > local variable.
> > 
> > Suggested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> > Acked-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index b498d867ba210..24fcbd7331f73 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
> >  	 */
> >  	if (rq)
> >  		lockdep_assert_rq_held(rq);
> > +	/*
> > +	 * __this_cpu_write() emits a warning when used with preemption enabled.
> > +	 * While there's no functional issue if the callback runs on another
> > +	 * CPU, we disable preemption here solely to suppress that warning.
> > +	 */
> > +	preempt_disable();
> >  	__this_cpu_write(locked_rq, rq);
> > +	preempt_enable();
> >  }
> 
> This looks dodgy as heck. Why can't we do this update_locked_rq(NULL)
> call while still holding rq? Also, I don't seem to have this scx_layered
> thing.

Giving more context.

The idea is to track the scx callbacks that are invoked with a rq lock held
and, in those cases, store the locked rq. However, some callbacks may also
be invoked from an unlocked context, where no rq is locked and in this case
rq should be NULL.

In the latter case, it's acceptable for preemption to remain enabled, but
we still want to explicitly set locked_rq = NULL. If during the execution
of the callback we jump on another CPU, it'd still be in an unlocked state,
so it's locked_rq is still NULL.

Basically we would need preempt_disable/enable() only when rq == NULL to be
formally correct. And if rq != NULL we should probably trigger a warning,
as initially suggested by Breno.

How about something like this?

static inline void update_locked_rq(struct rq *rq)
{
	if (rq) {
		lockdep_assert_rq_held(rq);
		WARN_ON_ONCE(preemptible());
		__this_cpu_write(locked_rq, rq);
		return;
	}

	/*
	 * Certain callbacks may be invoked from an unlocked context, where
	 * no rq is held. In those cases, we still want to constently set
	 * locked_rq to NULL, disabling preemption.
	 */
	preempt_disable();
	__this_cpu_write(locked_rq, NULL);
	preempt_enable();
}

Thanks,
-Andrea
