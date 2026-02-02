Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB48346A00
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070722; cv=fail; b=PdaCNBGqEFwOMotdmxD7Rm4s+UmRA+QLq9TIqGK8abluykHz3ME40UGmD9lHEijCT/YrBb83RfNRvZcz2hakclwDV0oSOKjrMmWd6WdY6TMJREjsDKSEBMjRMepvQZsoC8tG8jrBn4lS8s8LNDpbWnJ/D2rif0YEQbW9HTZe8S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070722; c=relaxed/simple;
	bh=GTj2is2MfaF6fxHC+XrqFnTbdXSEAWhPRcw0O3UeKBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIjyEndh1A2omaWBTw7xLtHApDRRD0bwbzlUQihhRg/s+FSeg+apUhh7LxI1XbQUDDEGuZyrI0f+xDaAo1OudZkypieIzP2ValFH8hrMwEYOKQa41asyGjy7hPQMblQ+VkD0Wr8dtdraP8b8SsMPxO2wsV+yUFqqo2G3ahY+YlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QnFm6Gr1; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnFm6Gr1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdnlP0+2OLMwzBxjViPsLerHY4c1K+ZdMFBM7BI7A6zD3zW1bGibuz29vBE2qZ69iuAMSo3Gfi9nzDBFHfmLOvBD8i86KxsdhczwgO9tpn3jcUErZc30WwlFdV2fktlHr0ooWFvRXiVmG31VOyyiErCqWWqQGjrPIrCLv3jbw2yrou5RuH3UTjdoNBXX92YTXLjgafMWRMK9DHjcUJVqKgqpeXdQb23jG2cDG5uP/y/hWwTSQm0cMOZp/xRVMRfdoAYt7MnKuGJbUKaQ0p22814YhS5VrjVglNt3JC77C3s09BH07pOvFgFjobnYT/pjyS1xxIIEgW0eV/VSLV2Fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FISIiY49Zk0bZybcI9j/hxbBLaAXVdasNIhCQjiLub0=;
 b=kdiCEgVFU9lhRv5rX1C1ztRMiUvicWKMyHRpDMTvbVhgadz4zQFYnhIzNhr0MUiCE55yXippCYjbC+2p2YyOkZBQjWQKqiqkyLb0fuMd7q7B9Awm1bnjSKt7IgjG+c9o+INLcGCO8P50ibb2QqP/0uj9qRoxS5Rs7XGZCEK+kXkgs9koxrOtf6IlWjLmvI9MS4P5fAfb55SeR7XVnTuneHBxOhblgaiefdiVoa3KwfnXo463/4YnZlyjSufBtGn/T+DEbu1uThT1P0h719y2UnLjPL0SenGfKfkpGW+EuK1POJKrBqbc1ZUq3dmSHOf0PUkxm3x+/hWd59iBiXg7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FISIiY49Zk0bZybcI9j/hxbBLaAXVdasNIhCQjiLub0=;
 b=QnFm6Gr1J2CHV6L+1xCf8zx8hrQYH/W0lTPAqumuJozCdpWodkwDMNBOjwHfhasIY793P2WN19Fl1w5lEGW/dZKzpeCIS0G9xm5phwCD/UOh6aRKgFb1H4Z6ZL3OHCm05EvUCGj5aV+n2c74gTmnPQVEG/ZIHhnPFMwcvnAKrboXf07RjWOe4DMNSUkSVzWJp3KPAPNSc/hLmaXu4dlyHIcZeWs6PxiEx4OgCQYO2KQvCI65HBJ8R9yJ9ns6cyPIS4e3rx473latEP/wEm0Umzpc/TqMdq/HfDQ8tma94GCmM59BkqgXwBNYgHLeCZEZ/IMeAJBdRQko0dRIpzxYdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 22:18:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 22:18:36 +0000
Date: Mon, 2 Feb 2026 23:18:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aYEiuNsM__t4HQ57@gpd4>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-5-arighi@nvidia.com>
 <20260202195035.GG1282955@noisy.programming.kicks-ass.net>
 <aYEJ4BCyw1tE7xOC@gpd4>
 <20260202211004.GM1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211004.GM1395266@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: c148824f-81b2-43b4-732c-08de62a90240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvA5zb0ab67cy2elzit8ZyqQFkkDG9/3eLobDby0XR4Pkg16exWpBOeqnd3y?=
 =?us-ascii?Q?IYFxNHueiTKj1cbtrf6LdmcmrPSb78ybiFWBj05d38MvPFdRc/rcY9nWSCtG?=
 =?us-ascii?Q?q5YyfDKXLza7LFbwJQCWl7fcZlBv36YXmCjlZzrWQo5cL6fq345hVEgsd6iG?=
 =?us-ascii?Q?eweDhn3fPkmwIn2NSgKEryWGH/Ifz5KcuBLCqEGIKCetZAKLAB5Ipr8CeKaJ?=
 =?us-ascii?Q?+qOI9VxhE0gsYNto+nPmp27j2NGqAAKLFvqAJ/p2OMMfgiqEuJlsRcsC1PZi?=
 =?us-ascii?Q?GfhJ41OtxIwiu0iy4EVZJjVRzd87Rzx3lwTAFothl1DtOnxeaXnYdhZH36k8?=
 =?us-ascii?Q?dqyf5qCiMoba/7niATuKBm2aGGK+cNtDlye2qqj822CKWaLt89BTzr/9l1u8?=
 =?us-ascii?Q?U+KZnJctE4w3E2K0qx+cpP4W5sDolLnQ+tYDm4I02v1nlnVyXQvgxrCDlPGY?=
 =?us-ascii?Q?IkkLKJO8XuNLrpNiK/lLuYAgX6BjV0xpHGnDbvpJEZrtuBi2rmkj1QP3HJ96?=
 =?us-ascii?Q?L5xUgLV8r142s2Ai7ydBPFY8nca3c3mdSqkJumDrSa5zfytXqLMePZ9KUFrN?=
 =?us-ascii?Q?Dx2oRjfkN9BNG05sdoTSKqc8ya58pzEuAiuD3Lby0WfRAuIPNmVGn7KmhYOn?=
 =?us-ascii?Q?lC0lXX0iAEsyCJHy25GxBrvcck+5dzRrWLPCWYc7boGaeMTSfijhQYVo8zA5?=
 =?us-ascii?Q?I8WM9U4LUWs2lI1+GimeoyGFRod8xhTkTOAZDtlM+5HEn2ksHuj+58qi6nOC?=
 =?us-ascii?Q?dzLv/BzVvgabfYCLzHHHX0Fof3eo6gtKALAaP5hk80k0hzkBZDpZ3xb+geru?=
 =?us-ascii?Q?APP6fnG8E2GhIJs0zThUA41tBmeL6Julnh+9vGgue3Sxer5fNZGcZzcmQXFu?=
 =?us-ascii?Q?nouyrEJvt06kHAx2mWrXTQAg1+aJQZ5Bx923Dp0WaQJXkqUWBYoPa7TO+Cru?=
 =?us-ascii?Q?6r7TzZF6qYE3XBvN3ukP5jFFtjvmRJyJ28/5IrSlaJT+mAfj/7XXzih7T9J6?=
 =?us-ascii?Q?TrlDBAyOrh39vQP/Bm2i/5C43asS1CiutP3bjtaiCcP07u7XmzCwCkW75E3U?=
 =?us-ascii?Q?+fbzKsfLJR/pQhHDYoT0uX0Umrh7gWytg7DCCeJP/EWCSUQZ+7HWrl9fO+ks?=
 =?us-ascii?Q?p/LuQK/8c3y7IU1IoJk61t4crmCSyERVMxt+r0vvEXWF5Ej+BCoJ1TOIgAQS?=
 =?us-ascii?Q?pA/uAFpD/QqcZFlY4VnTT2Ej2I9Y6sPKERq+vy5/Yxg2ko/obqTG6NSZc1VV?=
 =?us-ascii?Q?Bu00iA8+5J7gBaj5x/N2ZD0Xmh26UDcmt6XZUAgwCHtwq0hCtiDirCVukZy0?=
 =?us-ascii?Q?mNzUTiX+ElzXqLs8zmZbEZvVSNa5gJ867QQuRmezq7yCD76fNJiblJV9TISR?=
 =?us-ascii?Q?TJzmdKcbnVXA9a5W9PUiAl+4czGtrf6+GLydwum2Utd76q07tUR4s1Da568M?=
 =?us-ascii?Q?Cl/1p+DjUm82Y5aAKFw9BjKOW2kxf6CJo8+vYfc/leAHab4QSXKecA7PkMBw?=
 =?us-ascii?Q?279bojDavt5ayUfdEbg+3LDQ/ysIJkGj8C+6HWeQPZ/wG2e5aRJp3rT4n6RX?=
 =?us-ascii?Q?glVZXcYfzlElTsdPql8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWknCqg6xdWTaoq18NZxiMGmPMFHwyVtmBpUWQvdsMwSibibWsqbQotD/MEB?=
 =?us-ascii?Q?ZuQOHGJ7hYzLnj+QgmvYyu/dPVPNZauR91soNXgQijRm1dX1xlUnCmUG3B3h?=
 =?us-ascii?Q?LAwBNRuHZhoe5YAEuGOkmlr8FIKdoq328Icb89qKuX99hLWogsUDgtK5NRJc?=
 =?us-ascii?Q?iteepk98KU72rbR7DEndBVUAl3jW21FgT/8qLlD6f4P8uJe4V3J1Zru/eRUq?=
 =?us-ascii?Q?qhiRaQUfz/Mb8fVRBmfaCvZNR96+B7kcOaEbqHOyXtqV7bkJMDxeS3hYQpPa?=
 =?us-ascii?Q?bbPoynC3TR0v/v1QRbGVmkkPvtX1BdB0psFS9f1mArmWJ6v11cDSEbgErKAy?=
 =?us-ascii?Q?5ipCVIRoGV4UgNEoJ3vWnZ6fKCW+aiDDzrqOoT+nACbhabSdm4F4ezt/ejwp?=
 =?us-ascii?Q?y8cEt2N+1xdCTGz+o3o17nxR/zC/eZeI3XCVrUno3z5G5iGJz/9lfEpw4i7G?=
 =?us-ascii?Q?3bROhNEj5tOlxxIsi+9KpDEiROns1eAMYyIXrpqF/P+48czNQbI4mQWpu+YQ?=
 =?us-ascii?Q?mYng2mbTezMRD8QgVV01VENPQV4mhqa2GVc3XJpYxx0w0v9u4qQdu/XkdfER?=
 =?us-ascii?Q?SNX8Y2MFxdS51TjfVaUigUeQiOSuXH5LL07/ahQfxtc6lj5++RAwA7XfDfj9?=
 =?us-ascii?Q?okBUh/T1dRXGvsc1teXFE4+XpiSAJfwXxG7vt7YPkum/xehLGQ4fqVqdkKAN?=
 =?us-ascii?Q?4pLCkmCbp/w6LanzHoiX2hxf6UKoaf1BH/GEmk8P1jex5O9Tkh7EmzR+zqTo?=
 =?us-ascii?Q?t6+rVkOMAhuIdRgy7N4ZcYgGSjwe24gGksCHb5aCbjL7Sfy+deBTD3I5yXa+?=
 =?us-ascii?Q?IU6zgcSBNk6KnvdPQBczxlsUrDnFG++LR5N87g+YshJjwE1ub/we84VsYdhy?=
 =?us-ascii?Q?1LcbtT1WK/ImW60QUZhgF714hKsVHvkwmaGk1l4LF+XYdGBnDrbJIQEvfowv?=
 =?us-ascii?Q?eKISFxUw56FoAuBj+Nw/Np0s1JHXSJkNuqN4xcxWyZbN0VreWb/xuAdp4Y0e?=
 =?us-ascii?Q?/ujau/RC081PAQCVX9xdAMtfPb/X4GLY0A750KLM8tc30vrJbfd0FThtfyWB?=
 =?us-ascii?Q?y2lpOYaPqzPlnPs/3QrNxHL0yurUMW6YDBjIAq7c5daKpkfBIDqCAaShbtgM?=
 =?us-ascii?Q?t2Icz2uEAa/fx213aC/OQAUpA+gn0/KL36sINcqFAul4+g9P/hj6YzCApczi?=
 =?us-ascii?Q?jxbsrjDzDESwDMOctrA7nzkLvd8l6aZSYhl0+HGQUkatCaQ2y+AU2aMuCH3p?=
 =?us-ascii?Q?CBC+VbzFA2ZW3TWTBTP8iRNk2yl2h6c5Y6CAmpv8WRhUlZEFV9yU2dcUTVFc?=
 =?us-ascii?Q?rbLXTXdXEBB7+WMUXSwlzpp0U/1/iP3LvnHyhF7t0E1kaAo/cDY+516ADg+N?=
 =?us-ascii?Q?QaeSWB8uhVWQByqu4NesFN/lAOkXznBO3g/7UQTV+RFU9gouJ45KrN9GRPjB?=
 =?us-ascii?Q?i4LRKy0bxFDX0xWhH7MQP3oOhA+BvAVhePRvB4TVrczymRpVd2yiRdGHoNDw?=
 =?us-ascii?Q?67OpDAjvlecQNnz2wBQJYB5K/rDuaZe5pcDp1Otc8es5rPQUNtVJdbFW0QEH?=
 =?us-ascii?Q?hZFb1+Uiegxpv9BYtXpmXOB88HSYKrG4v7v/TodhPSgo5gze/01Hbp/UYyuE?=
 =?us-ascii?Q?nHXsv0ITiw9tbinA6PpbIdvBs5JKP0qwCJafyHDIZiQ2ITk7/3ssjLoV/6Zu?=
 =?us-ascii?Q?aAiiMJFL5msV5s7CKPD7D9G+JqqDUw0+n7F3OIBwVK/n0/K3YUK18lrpXSyp?=
 =?us-ascii?Q?Dmvi2N++Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c148824f-81b2-43b4-732c-08de62a90240
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 22:18:36.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlCp3ip7t2uRXoeoWt54IwBbxtV0Bg4D+2a7leor3fGQ7OoYdSaNRpke3wKO+1Gb3wkd0JR6nSVjv5PfZjuF9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807

On Mon, Feb 02, 2026 at 10:10:04PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 09:32:32PM +0100, Andrea Righi wrote:
> > Hi Peter,
> > 
> > On Mon, Feb 02, 2026 at 08:50:35PM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 26, 2026 at 10:59:02AM +0100, Andrea Righi wrote:
> > > 
> > > > @@ -3181,6 +3193,36 @@ void dl_add_task_root_domain(struct task_struct *p)
> > > >  	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> > > >  }
> > > >  
> > > > +static void dl_server_add_bw(struct root_domain *rd, int cpu)
> > > > +{
> > > > +	struct sched_dl_entity *dl_se;
> > > > +
> > > > +	dl_se = &cpu_rq(cpu)->fair_server;
> > > > +	if (dl_server(dl_se) && cpu_active(cpu))
> > > > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > > > +
> > > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > > +	dl_se = &cpu_rq(cpu)->ext_server;
> > > > +	if (dl_server(dl_se) && cpu_active(cpu))
> > > > +		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
> > > > +#endif
> > > > +}
> > > > +
> > > > +static u64 dl_server_read_bw(int cpu)
> > > > +{
> > > > +	u64 dl_bw = 0;
> > > > +
> > > > +	if (cpu_rq(cpu)->fair_server.dl_server)
> > > > +		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
> > > > +
> > > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > > +	if (cpu_rq(cpu)->ext_server.dl_server)
> > > > +		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
> > > > +#endif
> > > > +
> > > > +	return dl_bw;
> > > > +}
> > > 
> > > Should not this also depend on scx_enabled()? It seems unfortunate to
> > > consume bandwidth if scx isn't even enabled.
> > 
> > Yeah, that's a good point. We can just add scx_enabled() here. Let me try
> > running some tests with this.
> 
> I suspect you need some callbacks around where scx_enabled() is changed
> to add/stop/remove things.

Ah that's right, simply checking scx_enabled() isn't enough, because the
state can change at runtime, we need callbacks in scx_enable() and
scx_disable_workfn(). I'll test this tomorrow. :)

Thanks!
-Andrea
