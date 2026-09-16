Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC393B5311
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541475; cv=fail; b=CmaMCz7zJ2DphIb5r6+O28E0oe0pWahA2rf4wP6ktDx+ZmhgKZxR03eBMPifraIxIcFvgCwXDByTxfGGSn8gf6kNcocBsffeH8TOMIsR10VX4HthFUyCpVWS/kZwM5CSpM8DUOKYEJkjHsj/uuoatkCdDaj9HGr7B5H7MYwb1jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541475; c=relaxed/simple;
	bh=z5vyVUCMAzwcr4Pb4+2swfB/gY6I9Jh7w6T6sKFQydk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uy8QUcQHeVyYZvu4G/RTQAhIgxzeQEYewXw9wSkqChhjpnTS4w4WhQMUbl+ZlTZ2L5p1IOiV3FbVG2ELUBlAGpjS1tBuQ3lR6Ce+2Q2jUh3WPeFNBVnDzVAQjR37lTTCMuyLwJQ62z6fGvgRbOZs7PUvBylfI9nhQZ7ksHCGcX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M5HXwDBJ; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M5HXwDBJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/4NGLWSImrHz2TrzwpIKKy3Pr53wu9urvet/nHYYwExPm5oHk1FP7mWok3lT+fkETIV/Q984IXOrVzdaOmZzX56Q8U2UebxhihBqO26DrSNIc+hWpOBukx6Ys1NP4JstCDSI5iWdGY8PJnQXrZIAHg4ky/gmo4tTQTjmrxrr1qh4cfYr5YxQbhpORlizPJjZroPBkRQMC9MTzVStQsEF5gjmvhu8ta5wBfpratqWjJ55bg0CL+j4VzQ5HVZz7UVg5xIsCydnnhXXBuzqsltRc1m3JRBF45niwH6rHjfoZt4cMc2SdpQkQ7qERY4Yt5mZuypz05PTcUmLJ4hGpRpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MWl4THuPr42VDsZDGiwuRaB7D0YP2y8n3eqnMRknaA=;
 b=U++3mHZsksBEYn082ZWXWzl4dy/G6DX7puzNz7aFoJgZm96D76WsjUZqH7z3HCoWDUw8Ko6UV70aZhGhORqC3Os/NBmiKqPDh5DtypjUxNq1TebVl9NwvJqUm0mXGQetwpwyFbbBQDVjb1DxakQvIeZv02i8lpH5mVRnOjuCp4LfDFcenZWvogiv1Y4p2EX9k8tOjoFwVAK1MzgQvDn/wH2N32kOBGRbllYAHWJKdP0Dd9U1metr4KYcPug0aymJFEpVm9lxoM4hvkHcWr/9UsGNs4f0HFo2WPqJDUqamf9xVDMwFfp16g88rWgfJueZL7KM15xvTlgRb0tJbEyzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MWl4THuPr42VDsZDGiwuRaB7D0YP2y8n3eqnMRknaA=;
 b=M5HXwDBJNhR1BNKd0e8CVu4FCmNo6emIT5e/DPx/9Zkg2moa8GJlaKNelhRes3Eg2QdlJt23n7Q3oj0xpvKpub2d0V1WLibg1YbeNh7m7Uy0eHnQtn80K3Ys3XTd2d36BitOLNhbqijGPjHjXyoyVxHfDX/gIS/c2Yex6XI3tTrW5Y+RwBP7ab2OVwudQg6z9Z3B9iIGzi24hXkpPMFHZdS2anko8KWY+Kb/aSKLp+0oZMCR6X9hedTjWLQJGSrdemf3zR/Gs0VEwCnl2gmzodcVSfgtSuAGUd73CElbJXLUZu4Rf0z1faccOOK1+L5hAJIt/y+XxAUgxD4svFADgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 06:51:09 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 06:51:08 +0000
Date: Wed, 16 Sep 2026 08:51:01 +0200
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
Subject: Re: [PATCH 15/18] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aqo8VVgKOo_VoFsw@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-16-arighi@nvidia.com>
 <20260910133900.GT776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910133900.GT776954@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: b388f37c-9c0f-4572-e394-08df13bee30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7PfrHjd12eAfo4a/vEHPe0ctFyxu6LWuhjvM0Hajf1NipMMGHX8BAnCoNc7XQhvVLUDJWBl4bcvcQYxgqlOBYUF1rY5Bwnusj62WDv0QF8549q3P80ctCxBE8nb8bdjBshFn7avLg0QtRWh1NAQQ5DbYFRTa8/akrXqIZxFCUJKg+1cXzRBTmE11ys5cdTCvbi6IW0hI9wMdS2cVNvOVOi2vQr/bZpRD9HPmEsAHDZYxHeJmBlX9zo+xqcc3JkqZrldB+A9StPz+yorc/HORDXt5QZyggTl3sijVmtdMilfVvdNGN7ExR7HrzcsLwhim9/EUf2nUZ6fP9wdEqYw/Ra8xWbQjWX21bd4uWQ5r2TCtMgUMhT776PS7K2tAtLYdwbI9WAn6nVF1Op5kvvjgw5BxYRO1rgRVDn5SEK7BnT1rFnJUTRGmd5wP4e/rxe2Nax/2XfKF/zLcfv4mDjBQRb5My4iD24Lh0cNOO5mCW9wqYehxb7GabRuJvQeXBsxTmEUEz9HnY7lvX08OKIAFXNIj9H+yjQLSIuSj82KAzBgJ4RdzEIxzyN7/pk/A+VOkyKRjz3S3KA3YRmExg630zYmojR+S9yCjXJ/+fzNnnX+SwoK0DhCmo31+2LmddBVu1PFfflw8gKKkV+svC+rY8vWcIm3rPqr8hUTgat52EY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mhAdMa80t6FiUAiT0yYq6RxGVMbPzEhsoW+eM3smRr9JEnN7c0c6DtlzM+Bx?=
 =?us-ascii?Q?Czsh8U2NIv+53HGOpNqsXzD6xZ0KJ38HjqHkdCt8XQhkSYM37fDG9FNvitPz?=
 =?us-ascii?Q?IpLDEYVrtGX/W3Ztqq6fJRavRCAcK1F47lg8qDN/9HFCMV0X6nTUt0nwMbfn?=
 =?us-ascii?Q?h9/Clbsq99CXjhk2HhXv2aZ4yf20pDk8JryGF1sGkNMPKgIJDbO1jk739Goq?=
 =?us-ascii?Q?c9rtX0AoBoMXrrmTm9SOR6Bb5Bi71isiHPhr8Ch3uVkbdnTk9r0ZpokSmv6u?=
 =?us-ascii?Q?BgHJu+13Z9juhSseCcgjHBX34kS8tQlxQd75Bnt64y1vZNaseTUvSTJ887Lr?=
 =?us-ascii?Q?c7iZjY6JetPWOXX2pVV/UVvMkQ6uR1WsrAi60NT2HoIDT+WCD2bxYOIq2SYS?=
 =?us-ascii?Q?cCRT6hy5mc0sxA/9EpWO0uuvzesuibws1bvT09IAvkICN3Q+zHVH/4sAWUg6?=
 =?us-ascii?Q?AJBYdL8wshcdbPvD3p+Lm20RElVTCyZSbO9fDWHrOsYLnbN+FBIB5XK9G07k?=
 =?us-ascii?Q?J7n+BPNZnu2x2TANPu92j3abkGkxG2abTKLjA/DOWkUXEiQOVQxIiHyAKwBP?=
 =?us-ascii?Q?OfHHHsV2GVORDwHAPQVvy2Q/n+4FFUdL94nSPw0xhH0ucl3aSiXjcgf3jX5I?=
 =?us-ascii?Q?pf75+WaOuL2Z98SnJ+asoZjby5xB2oNMcULr0PfsD6VD8jni+zn7+jEx8YpE?=
 =?us-ascii?Q?AAybJH9VsGX6XqsjRg6O4NHqPOZttkfCdRea8bZHVXjsRZLvZDgYhd5qyv6a?=
 =?us-ascii?Q?n1lAz2r1sOhgTmwRy9QFIEMb+UvW0xgByPh00oHmqYLj6HsBC93N8PS0t6YC?=
 =?us-ascii?Q?vEzdPQpNaoEL77LFTbREN0gOqfbU+a7hzOIu/MBX+YPtDb8qHIC94NncJUUy?=
 =?us-ascii?Q?F5Rmmtxhe0i0dJWua9CvAX00SK2VTyHlYK9jhdEMfPzQxNoY4ocGAYB6t7kJ?=
 =?us-ascii?Q?0haAwN9GfiTckuPh7thd0m7Hnzq3iOgDk581x34iMUf2SpwSMgyp8iryEVIr?=
 =?us-ascii?Q?Uhx57Xz/JXPE1o9JoZP/ehKuFkeQfGeMDwen83CocK7ursom2L0bNEKJSW+0?=
 =?us-ascii?Q?plxIFoAydRWjXwX2jMk8IWdEVBwfQfnGY6AhKrHHdOqOonFh4D+G/fPkHeji?=
 =?us-ascii?Q?KU4YwywLmePrr/HU4zPXrTMvwiUuNdZzXM/I2rISsE9/pClkOIAuX/8Hz5U0?=
 =?us-ascii?Q?2hPxeTukfV91k7XG5ZOzdv/ni7o7KBHtEimoYgJnfxNrsrB7jlYRvI7lIPtd?=
 =?us-ascii?Q?MU/V+jMZEl29VSjd3B1zs5K+n4Jo4h+fO1qo37JzEwENenoL0rFIHwXOfBOI?=
 =?us-ascii?Q?xDa4nEkZhM8wWrqJGO+MYfGj1NmV5mWSg8DtdpeIUsr/sY8BXkaMmoqpRTz0?=
 =?us-ascii?Q?1wJwvOwKRHlHYlUaWi1mBgPTJdmZrxZjiSHzJoYF5SZERjCDRcuhiFJjEjOK?=
 =?us-ascii?Q?3rjuIvwaVv9poBynR3srpi1hmOXNyq2+sAcZOxFLUWkHDUHchmGHbxk1bo+b?=
 =?us-ascii?Q?veplWv16q6AVG0P59HQPln8gbjHAm5eoYHagFj7GtIR5z5tJlukhc+litZRQ?=
 =?us-ascii?Q?vs9nBFE6QIvhgPqgATJf5xkLIF5K1gLpU5ihptT1JhjwR+GYzpRe4N6/DfMh?=
 =?us-ascii?Q?DAvjHga5S+6/1qwGIfZFL+T+YNI7OXUwTC4KEc/VTs7DO5XcT4Z7FISvCMBT?=
 =?us-ascii?Q?0zNqenVlJpOvPW3Zu5mww+uFelLJ+Hx+ZE9Fjhnkkm5V0MmaQLNdZBx/yY/W?=
 =?us-ascii?Q?Mv22XqPAlg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b388f37c-9c0f-4572-e394-08df13bee30a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 06:51:08.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdFgfbpNWXa2Xi1cTjTrUEFjUSGmhZ1tTy0NwyUMgBATKHo/tjuFyWX9sGXDaUya0v9kaCJDn5VlTCTKcZOMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278

On Thu, Sep 10, 2026 at 03:39:00PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:25PM +0200, Andrea Righi wrote:
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 5f4956cf7e369..aa6ba9e8d7cb0 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -26,7 +26,28 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
> >  
> >  bool scx_allow_proxy_exec(const struct task_struct *p)
> >  {
> > -	return p->sched_class != &ext_sched_class;
> > +	struct scx_sched *sch;
> > +
> > +	if (p->sched_class != &ext_sched_class)
> > +		return true;
> > +
> > +	sch = scx_task_sched(p);
> > +	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
> > +}
> 
> Can we have this thing either be inline or wrapped in an inline function
> that has scx_enabled() on?
> 

Yes, that makes sense. This is called from the scheduler blocking path, so the
inactive sched_ext case should be handled through the scx_enabled() static key.

I'll add an inline scx_allow_proxy_exec() wrapper that returns true when
sched_ext is disabled and calls __scx_allow_proxy_exec() otherwise.

Thanks,
-Andrea
