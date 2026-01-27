Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023B2BE051
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523502; cv=fail; b=tr6hpIAlieuS3B0EgYQGfN8VtONf/qw+MW1pIM4QGPqR5DTNYO9KBnpPHeKR3CBs0Ou+Q/u5gxb5OX3ubE/Xa7YGOLetSkFgXXLPh1Fb2Buy/mwxj/Ou8B8IzAl4AZbJcHAsuAe2C3Cvxyfm7LP+JkD7GB5PkH6ZO7628tJDORw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523502; c=relaxed/simple;
	bh=pHqix/bYf7ZDnXrWzTFKGos5TpG1Y5hnr5DEYAEucKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L25JEzSubWoG+tKTOL4UrLzfOlfSGzkpjGscCITPHf+7y1trzEiZFEU7kJyN4+MYUYbSyBBx6aDt/3LOckDnQZH7OZhUic/yhbBjmSYA92kyx+BB4eSqi348tUSVXfdZC81fsB0BJA4+Mp2H/7N53/Etlo8P33rFCDfhGgHx0iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXE0vUFn; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXE0vUFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s89Y5aAfM1iO/fPTetRedLuUQMVVXvgaZQU7z4kg/Pzewil7ksDUJ1VT1DIiXMkuKKlV6Vs/jS4wC2MzXTeEUCM3Wjw1VON9rxqnehmDCNdyiJ3qG4S1blsImoxxJUfR4XPdSjLTo8Hcfnu7ptRfdTIJ3RzW2/DGbXYn87dpgc3SyHgDLdnCLfNCjGHQhyDNhNNP1LSTBFbtjz0MJAbQUtzTKPAOIgdCNCL2P9DIaQpoAvQwKNjoc/08dpQZ2fK1DZosLg3PIReBSUTaMFZMwfigAfoJzNuLkQw9uwNDZGc1xrcJGqdSG6fB8a8jPncxGQWFxzRpkrVz3TpPPIK/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvcrYy4FzXU6V02zfyg0ooeyoDoEa2LhLqn5c13b+9Y=;
 b=xfId5lZBKiOVmYZNFeI59ofSi9incrKHWlJeCRE5lF5mIwjGnGsB1iI/8Pd+BZmVL+S1SoB7+SgLBCFbVoRmfnFoz/Ec8RA9g/WgnIsPBK1Aqx9uK3gaK30S+Z75tkZyL2HpM5ij9+VfbllBrzt03EzUNn98V+pa/zn5jdUW9qFwqgq8UAhJuMnt8SrW9Us09R6IRsHozyYYIjhcBqYm4ohQqx+3/WzwNMHva7RDT914+SNtlKrCTovaoJrHrxdkraTciC4hFhgPPYhBqaBXuBozSFYm/cpJzGPk5/vWzFH7tlEP+dFZvKj5SJe7h8ygeFqz6B2XPUJXgCKu1WKpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvcrYy4FzXU6V02zfyg0ooeyoDoEa2LhLqn5c13b+9Y=;
 b=LXE0vUFnefqxtzzE5OdSKpLCju/nWO+MvEagYYEuIsGNwb25nfMej8eHkw+RVp7lobd77gOJhdmafTNhYxR7N/5cbpfhCQEYUNDNqPwrCnZNGW913PtnuUCuOn917KqgGEJ65xMSFEGiS9SfW/mehwP8MbCf77FcVYdxinUh9wdRyg3Hy14xzoT8cs7KSSfKSzSMgafFLBNYa8VSaEnOE0Kzs7Vt29CL20kfHc5EWG5tdOOVAXDWFEAQEBmFRooxpylqAA2dxlTPQAGgocixbkfUZMwo+jRU8sheYoDvP0Z0yBwkCW0aUAivpM61BHmLD0Y/7+zPD0e33E6mzZTODg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 14:18:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 14:18:17 +0000
Date: Tue, 27 Jan 2026 15:18:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXjJG-72XEqvaVtL@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
 <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: a592a2e7-84d3-4a6b-2039-08de5daeea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6EHdBpCh6WILw+ZBErVbaVh6LE+WZsD4RvAoGorFejYOgVmPgkhAhzJxPPTi?=
 =?us-ascii?Q?OeuP//SdUeIUeQlUL5MNpX/zE/tDkOrQIYZe98ylTGVs3Ct8wRTTRD+HtTDy?=
 =?us-ascii?Q?gogVXCU+LPjZRJZjZElqs9AO3FTTOh4Q0udp98QRWBmext+wEfnrLMxdfZdj?=
 =?us-ascii?Q?UNVA8o54crn3o2APgOBod0PennCQdFg1uds38oL9UzLiQ/j9kG73hPolanet?=
 =?us-ascii?Q?IOffX39Q7yZkkB7ZBNi3K3yBfF1m3lRvufdDcOj89c5RvIpDGaUFJiBONjW2?=
 =?us-ascii?Q?W96WJKpd0CI+rfXDio+wQLU9wn4mWCgdFgiosLzfVueCbKEaHNACUX/+/q5S?=
 =?us-ascii?Q?gSCYQ3CiUM6KkyvTKg65QuQdRyH5jwXcwWdGVIMk2aIdlVZf0/VutkbomAyP?=
 =?us-ascii?Q?gJEwjxQObjRvASphkCcaFVh7uI50b/6XGTAMTNRYLjlJeArqMTyenZwmDy4M?=
 =?us-ascii?Q?KnfUkmZ9b+sVZFH5S4E5MkKzFkkXFfX43aWKcwiP3dKV8p8uCoBV2yh9vjJu?=
 =?us-ascii?Q?LM3hyxrJVsVrC5DQgmUyMuyCOiFvAoOMdHhhr7gapm4gP0oN9ows0Xxxm6YY?=
 =?us-ascii?Q?hY7qs5slkG7anB4Jad4u4tdcOxr9hasaKJTy7ZSLxxwnAP1OMFkAh0xG4uJn?=
 =?us-ascii?Q?FwmMk7WdMPUqo9V635HRfQBYkvmnYdx/+WSuOSn+qkExWGGsJ99Gr4b1sXkt?=
 =?us-ascii?Q?kFO61MQsie58QFY8ALa40Mi5NNwrH+CaGom4rzzWLeRv2PCIhkrSjMYgUlmN?=
 =?us-ascii?Q?Np22zqfVxsbdSY/Y1sRHUmkGdNNblvGIgUC1D7HwSu2knbp1Ag/fT/8px4iO?=
 =?us-ascii?Q?8jSZurXQXccm7uqerm//zHp+fJuaGHX9kHwguf4VNZwpxIp+U/7b1elhf/Up?=
 =?us-ascii?Q?+P/idBt0c1agCdtm44EqWmPqh7uhHwKwPlCKOClJpFr3FeJ3ch54zXadkmP1?=
 =?us-ascii?Q?URQf+z98ltUfl/ruhjdKuIchARjlvTk52q/EiQZJCtsi4Ju8cORd3JpK2CO+?=
 =?us-ascii?Q?OxC+Ef92+LtB+cSPS0HzgzGbQsKUaHWLCkqn12Q5lX5j3BwXIEQNZ/grb01i?=
 =?us-ascii?Q?CHaR1LFINPWEbReOEZz8IDz/2vBVmUSUjmRAfxeiJtyk9/MpmzQ8GXr0ZH2U?=
 =?us-ascii?Q?+H5O0JLWUCfIZXCEw7/Z7ZZoUzNeI/39M5P4QQlD1la1vPudAXvLwbtj+JUV?=
 =?us-ascii?Q?ysWnc0KEt1NhBQax4ZIS5Vjk8Iv33FAcxNdJGeDa7eOjtjv9OM/o13jk+jhl?=
 =?us-ascii?Q?EIaYBV18DvrbDERfaL5fBjS8FhgQR8KaKhMjXoMTN/kzFHadC0DzwUKqIZch?=
 =?us-ascii?Q?tL3wgJF7CEyjkKQ67a32FNmvLuM3u6bfaqkL4BWd9LyDsW5P99dDMvId/f5I?=
 =?us-ascii?Q?3RFNzIJ1L+XF/K1p1F0i+7CONBK/yaN8XgPf9tDQnYgzrCBtptpog7u5jhCm?=
 =?us-ascii?Q?5vW/fsGq5Y5SYYySac+j5fMCcGzurih74F+4WAZUz60V+0iGZbGiK2WJyTag?=
 =?us-ascii?Q?yIFBBbpO0VMNjKXwVag/OIptJVP1gQrsR0lY8BRwkACRvQA6wKuE0xo//TCD?=
 =?us-ascii?Q?YFpnLyibfflVyGERH9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3QLq0N2KxFGTuFvnRS59gNI9EeZxr23SZo5A5obb0f8S5emGCV7vNVHxMOqE?=
 =?us-ascii?Q?JVP3tjv6ZwM0JUTewuYd4vwiiqQ1/KSUmb02zTnZiPPMGqmcEgS+nrdmz66l?=
 =?us-ascii?Q?QeA1E1El2qO7hEAGKjYJJI/nRzg8FVaYDUSaqX2IQTDnU+eW+pvkfcs2CAlB?=
 =?us-ascii?Q?cPu+MFKQ/aPc1I0eYc2zGXqwFAxvt6fGxbCnt1UKgbdypXbT52akk4zQs22C?=
 =?us-ascii?Q?688CPBlsjX7UJ3SXjrnAHVuMNWn3firFiCS93TQx3ty84BmYEkNSZ1hS+3Vc?=
 =?us-ascii?Q?HTJQiZm00EimST9O4woq9eHuctyGEzEjSrTnwfDIPuVYMAPT8jB/3klluR4u?=
 =?us-ascii?Q?8SXYXgkywxBstO2wtRNTsE0vx14xyv0/FDYzXEPpjbG+ZCYlF2FIfAT3aJSe?=
 =?us-ascii?Q?zG+OlIvShltQP8pkHuZjXxX82hEHYLC1EFiO8Tc0kIsz8BsETB4kzZJ5svZo?=
 =?us-ascii?Q?z7p9NcTt/sDXAp9MU27HQ727aO/UDtrL2IuoCdzT6AQvRyDCZHutU72FZ5ui?=
 =?us-ascii?Q?9hsFF1ZJCERFbjb+tHUpyx2hhLru50QVA7ItDB5XMye5iNVj7gZOBv0a4LB/?=
 =?us-ascii?Q?sscwXoHEUaQJXvFOWPPnKkHZ9dSgcSB9OpqDUX6XmxQkf040vCT1BZZjXmX4?=
 =?us-ascii?Q?EbkO2MCGPjJQzTGrcW8KJnUeui4l3Ih/6qsbmENnEP48VQ5RGBqouropdMLH?=
 =?us-ascii?Q?r8n+tHjMnuH4fruUeo7CPCcU+ZrH21jBcZeUHT2odICe6hJ065KDLvZdyxCT?=
 =?us-ascii?Q?Iv9cEHjJMMJ9OZnhFBG9WgDxg+HnH6ppa0jj4W2nDcWEPkgBl2ok5/tREpY8?=
 =?us-ascii?Q?cxXaWArheAndv184R4NU806G4gH6Iiy0GjyId9qsdeDW5vNzPUoxvbgZQ6ny?=
 =?us-ascii?Q?fbzg74c29NoScH8NXSxOGNpQgmof678tPZyXgCdE5rla/s5izCrWx0PNfe15?=
 =?us-ascii?Q?LsjJkKZht9howalsfH6YOCxVF/fUQ/Ay7lWg2BhcyLY8i0MRXM0nW7zZxoWG?=
 =?us-ascii?Q?cO6UvYIUE50gKLdaakLHGIbvkdED0DQ10F4c+7emgmXTTE7WdWc4mdKYuuHZ?=
 =?us-ascii?Q?djMe2FNLsU0CGgU+6sJlnx+iFnYJSZZ83eIGDOdayJadv0VBGIGz4nI8dAU1?=
 =?us-ascii?Q?LTPRqh3h56dWRDohpAPDqr8oNvf5swp30NjUfim4MFtV4m/fDfrWL0/BQ9SM?=
 =?us-ascii?Q?EnlvbwxuXf6UozwClbNEeWzCLvu8DPvoJfPbZKS/eKe1BDfKo7oaBjR7y65+?=
 =?us-ascii?Q?Njs3JfQbs0XObH8tPcvp4lCReL8kzKW7llUwj3qZqBzsg1qptY91DX0bWiWR?=
 =?us-ascii?Q?DF6IkvcVfkdz9bZDbCEsIJjrNdrNHhC0ot16M4Iqn6Ar51KeUbyELaA5ANa+?=
 =?us-ascii?Q?wC2pmzhHHfuY0nx1depPA4ErEzl7pPwny4eUVp1VZlo1fThbm4q3OPPqgyuV?=
 =?us-ascii?Q?/aEmGI4ikyo0UTNe9m4cVSH2LdOR/41Up+OBf0/OS4IC/OPon+KOfBCcvnOX?=
 =?us-ascii?Q?kBNPuKQSn8AdJsUjLJS08mqLo0Ko5lrlyo604wLSENTIZ8o2e4Vaqlo+Tnl4?=
 =?us-ascii?Q?FODSu0zXS+c/V1UN0bUkcuYKQ1DDxYlvxm9Y/8cU7d9crNhxRVfJJvxrkzwT?=
 =?us-ascii?Q?sjYtpqVDwaPBZVLSn3cJnRXrJufZiA4TzG3lqaFNSRh5GOJZHgNpi9U/vlFl?=
 =?us-ascii?Q?ZM8tKRH0OWbR73WgalNiNLop+6DHuhUM03vS3bsoUFNvXVTYGDursBIqfEJb?=
 =?us-ascii?Q?JUgw4O6bHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a592a2e7-84d3-4a6b-2039-08de5daeea4c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:18:17.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77B8slMMVV720ShirCnxItO5Lnvq8ixe8lyrtms9OzNLdl6+fOvu9vi49qssCd1YwP5Z2YGS6DbUHFlRpbgm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800

On Tue, Jan 27, 2026 at 08:52:48AM +0000, Gabriele Monaco wrote:
> 2026-01-26T21:27:11Z Andrea Righi <arighi@nvidia.com>:
> > On Mon, Jan 26, 2026 at 04:56:52PM +0000, Gabriele Monaco wrote:
> >> Still if it starts before the deadline, the server is going to get throttled as you observed, and perhaps since in your tests the CPU isn't idle, we don't stop the server after that dequeue and then we never replenish after the deadline (because we never start and as you mentioned, the timer is not armed).
> >>
> >> Can this be what you're observing?
> >
> > Yes, I think it matches what I'm observing.
> >
> > In my case the server is (re)started before the deadline, so it immediately
> > runs with exhausted runtime, gets throttled, and is dequeued. Since the CPU
> > isn't idle, we don't hit a path that would stop the server cleanly and
> > reset its execution state.
> >
> > At that point, because dl_defer_running is still set, the restart path
> > assumes the server is already in the running phase and skips arming the
> > deferral/replenishment timer. Therefore, once the deadline passes there is
> > no remaining trigger to replenish a new period and the server gets stuck in
> > a throttled-but-running state.
> >
> 
> Alright thanks. I believe your fix would work even if you reset the defer_running only when the runtime is exhausted.
> 
> This way we'd still keep a bit of benefits of the start-running sequence if fair/scx tasks sleep and run back when the server still has runtime.
> 
> We could even keep the defer_running as it is and mark the server as defer_armed (with laxity timer and stuff) only if it starts in this exact condition (runtime = 0 and deadline not expired). But this may just be overly complex for little benefit.
> 
> What do you think?

I think my case should work also doing something like this (I'll run some
tests later to double check):

	if (dl_se->runtime <= 0)
		dl_se->dl_defer_running = 0;

In this way:
 - short sleep + remaining runtime > 0
   - dl_defer_running stays set
   - restart can go A->D directly
   - no extra defer / zero-laxity penalty

 - stop with exhausted (or negative) runtime
   - dl_defer_running is cleared
   - restart must re-establish eligibility
   - deferral / timer is armed again
   - no stale "already running" server

However, I think the right assumption should be that both runtime **and**
deadline are still coherent, so we should probably do something like this
to be fully correct:

	if (dl_se->runtime <= 0 ||
	    dl_time_before(dl_se->deadline, rq_clock(dl_se->rq)))
		dl_se->dl_defer_running = 0;

This makes the stop path slightly more complex, so I'm not sure whether
it's preferable to go in this direction or just unconditionally clearing
dl_defer_running, which is simpler and more explicit from a state-machine
point of view.

Which one do we prefer? Happy to go with whatever approach you think makes
more sense.

Thanks,
-Andrea
